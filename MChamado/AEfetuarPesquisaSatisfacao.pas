unit AEfetuarPesquisaSatisfacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, UnDados, StdCtrls,
  Tabela, Mask, DBCtrls, Db, DBTables, Localizacao, Buttons, ComCtrls,
  numericos, UnPesquisaSatisfacao, Unchamado, FMTBcd, SqlExpr, DBClient;

type
  TRBDTipoPesquisa = (tpChamado,tpCotacao);
  TFEfetuarPesquisaSatisfacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PCliente: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    CadClientes: TSQL;
    DataCadClientes: TDataSource;
    DBFilialColor1: TDBFilialColor;
    DBEditColor1: TDBEditColor;
    DBEditColor35: TDBEditColor;
    DBEditPos21: TDBEditPos2;
    DBEditPos24: TDBEditPos2;
    PChamados: TPanelColor;
    Label5: TLabel;
    Label6: TLabel;
    ENumChamado: TEditColor;
    EDatChamado: TEditColor;
    Label8: TLabel;
    Localiza: TConsultaPadrao;
    Label10: TLabel;
    SpeedButton5: TSpeedButton;
    Label18: TLabel;
    ETipoChamado: TEditLocaliza;
    Label11: TLabel;
    ESolicitante: TEditColor;
    SpeedButton4: TSpeedButton;
    Label12: TLabel;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    ETecnico: TEditLocaliza;
    Label16: TLabel;
    EDatPrevista: TMaskEditColor;
    Paginas: TPageControl;
    PanelColor3: TPanelColor;
    Perguntas: TSQLQuery;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDChamado : TRBDChamado;
    VprDPesquisa : TRBDPesquisaSatisfacaoCorpo;
    VprTipoPesquisa : TRBDTipoPesquisa;
    VprPaginaAnterior : TTabSheet;
    FunPesquisaSatisfacao : TRBFuncoesPesquisaSatisfacao;
    procedure PosCliente(VpaCodCliente : Integer);
    procedure PosPerguntas(VpaTabela : TDataSet;VpaCodPesquisa : Integer);
    procedure CarDChamadoTela(VpaDChamado : TRBDChamado);
    procedure CriaComponentePergunta(VpaDesPergunta : String;VpaDono : TWinControl);
    procedure CriaRespostaSimNao(VpaDono : TWinControl);
    procedure CriaRespostaBomPesssimo(VpaDono : TWinControl);
    procedure CriaRespostaNota(VpaNotaInferior, VpaNotaSuperior : Integer;VpaDono : TWinControl);
    procedure CriaRespostaTexto(VpaDono : TWinControl);
    procedure CarregaPaginas(VpaCodPesquisa : Integer);
    procedure InicializaTela;
    procedure CarDPesquisaItem(VpaDPesquisa : TRBDPesquisaSatisfacaoCorpo);
    procedure CarDClasse;
    function GravaDPesquisaChamado:string;
  public
    { Public declarations }
    function EfetuarPesquisaChamado(VpaDChamado : TRBDChamado):Boolean;
  end;

var
  FEfetuarPesquisaSatisfacao: TFEfetuarPesquisaSatisfacao;

implementation

uses APrincipal, funSql, Constmsg,Constantes, ANovoChamadoTecnico;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEfetuarPesquisaSatisfacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunPesquisaSatisfacao := TRBFuncoesPesquisaSatisfacao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEfetuarPesquisaSatisfacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunPesquisaSatisfacao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.PosCliente(VpaCodCliente : Integer);
begin
  AdicionaSQLAbreTabela(CadClientes,'Select * from CadClientes '+
                                    ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.PosPerguntas(VpaTabela : TDataSet;VpaCodPesquisa : Integer);
begin
  AdicionaSQlAbreTabela(Perguntas,'Select * from PESQUISASATISFACAOITEM '+
                                  ' Where CODPESQUISA = '+IntToStr(VpaCodPesquisa)+
                                  ' order by SEQPERGUNTA ');
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CarDChamadoTela(VpaDChamado : TRBDChamado);
begin
  ENumChamado.AInteiro := VpaDChamado.NumChamado;
  EDatChamado.Text := FormatDateTime('DD/MM/YYYY HH:MM',VpaDChamado.DatChamado);
  ETipoChamado.AInteiro :=VpaDChamado.CodTipoChamado;
  ETipoChamado.Atualiza;
  ETecnico.AInteiro := VpaDChamado.CodTecnico;
  ETecnico.Atualiza;
  ESolicitante.Text := VpaDChamado.NomSolicitante;
  EDatPrevista.Text := FormatDateTime('DD/MM/YYYY',VprDChamado.DatPrevisao);
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CriaComponentePergunta(VpaDesPergunta : String;VpaDono : TWinControl);
var
  VpfLabel : TLabel;
  VpfMemo : TMemoColor;
begin
  VpfLabel := TLabel.Create(VpaDono);
  VpfLabel.Parent := VpaDono;
  VpfLabel.Caption := 'Pergunta';
  VpfLabel.Top := 10;
  VpfLabel.Left := 25;

  VpfMemo := TMemoColor.Create(VpaDono);
  VpfMemo.parent := VpaDono;
  vpfmemo.lines.text := VpaDesPergunta;
  VpfMemo.Height := 65;
  VpfMemo.Width := Screen.Width - 100;
  VpfMemo.Top := 35;
  VpfMemo.Left := 25;
  VpfMemo.ACorFoco := FPrincipal.CorFoco;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CriaRespostaSimNao(VpaDono : TWinControl);
var
  VpfRadio : TRadioButton;
begin
  VpfRadio := TRadioButton.Create(VpaDono);
  VpfRadio.parent := VpaDono;
  VpfRadio.Tag := 10;
  VpfRadio.Caption := 'Sim';
  VpfRadio.Checked := true;
  VpfRadio.Top :=  (Paginas.Height div 2);
  VpfRadio.Left := 150;

  VpfRadio := TRadioButton.Create(VpaDono);
  VpfRadio.parent := VpaDono;
  VpfRadio.Tag := 20;
  VpfRadio.Caption := 'Não';
  VpfRadio.Top :=  (Paginas.Height div 2);
  VpfRadio.Left := 300;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CriaRespostaBomPesssimo(VpaDono : TWinControl);
Var
  VpfRadio : TRadioGroup;
begin
  VpfRadio := TRadioGroup.Create(VpaDono);
  VpfRadio.parent := VpaDono;
  VpfRadio.Tag := 30;
  VpfRadio.Items.Add('Ótimo');
  VpfRadio.Items.Add('Bom');
  VpfRadio.Items.Add('Regular');
  VpfRadio.Items.Add('Ruim');
  VpfRadio.Items.Add('Péssimo');
  VpfRadio.Items.Add('Sem Opinião');
  VpfRadio.ItemIndex := 5;
  VpfRadio.Width := Paginas.Width - 100;
  VpfRadio.Height := 60;
  VpfRadio.Columns := 6;
  VpfRadio.Top :=  (Paginas.Height div 2);
  VpfRadio.Left := 25;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CriaRespostaNota(VpaNotaInferior, VpaNotaSuperior : Integer;VpaDono : TWinControl);
var
  VpfLabel : TLabel;
  VpfNumerico : TNumerico;
begin
  VpfLabel := TLabel.Create(VpaDono);
  VpfLabel.Parent := VpaDono;
  VpfLabel.Caption := 'Nota de '+inttoStr(VpaNotaInferior) +' até '+IntToStr(VpaNotaSuperior)+' :' ;
  VpfLabel.Top :=  (Paginas.Height div 2);
  VpfLabel.Left := 100;

  VpfNumerico := Tnumerico.Create(VpaDono);
  VpfNumerico.Parent := VpaDono;
  VpfNumerico.Width := 40;
  VpfNumerico.ACorFoco := FPrincipal.CorFoco;
  VpfNumerico.AMascara := ' ,0;- ,0';
  VpfNumerico.ADecimal :=0;
  VpfNumerico.Tag := 40;
  VpfNumerico.Top :=  (Paginas.Height div 2)-3;
  VpfNumerico.Left := VpfLabel.Left +VpfLabel.Width + 10;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CriaRespostaTexto(VpaDono : TWinControl);
var
  VpfLabel : TLabel;
  VpfMemo : TMemoColor;
begin
  VpfLabel := TLabel.Create(VpaDono);
  VpfLabel.Parent := VpaDono;
  VpfLabel.Caption := 'Resposta';
  VpfLabel.Top := (Paginas.Height div 2) - 40;
  VpfLabel.Left := 25;

  VpfMemo := TMemoColor.Create(VpaDono);
  VpfMemo.parent := VpaDono;
  vpfmemo.lines.clear;
  VpfMemo.Height := 90;
  VpfMemo.Tag := 50;
  VpfMemo.Width := Screen.Width - 100;
  VpfMemo.Top := (Paginas.Height div 2) - 20;
  VpfMemo.Left := 25;
  VpfMemo.ACorFoco := FPrincipal.CorFoco;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CarregaPaginas(VpaCodPesquisa : Integer);
var
  VpfPagina : TTabSheet;
begin
  PosPerguntas(Perguntas,VpaCodPesquisa);
  While not Perguntas.eof do
  begin
    VpfPagina := TTabSheet.Create(Paginas);
    Paginas.InsertControl(VpfPagina);
    VpfPagina.PageControl := Paginas;
    VpfPagina.Caption := Perguntas.FieldByname('DESTITULO').AsString;
    CriaComponentePergunta(Perguntas.FieldByname('DESPERGUNTA').AsString,VpfPagina);
    case Perguntas.FieldByname('TIPRESPOSTA').AsInteger of
      1 : CriaRespostaSimNao(VpfPagina);
      2 : CriaRespostaBomPesssimo(VpfPagina);
      3 : CriaRespostaNota(Perguntas.FieldByname('NUMNOTAINICIAL').AsInteger,Perguntas.FieldByname('NUMNOTAFINAL').AsInteger,VpfPagina);
      4 : CriaRespostaTexto(VpfPagina);
    end;
    Perguntas.Next;
  end;
  VprPaginaAnterior := Paginas.Pages[0];
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.InicializaTela;
begin
  if VprTipoPesquisa = tpChamado then
  begin
    PosCliente(VprDChamado.CodCliente);
    CarDChamadoTela(VprDChamado);
  end;

  VprDPesquisa.free;
  VprDPesquisa := TRBDPesquisaSatisfacaoCorpo.cria;
  VprDPesquisa.CodFilial := varia.CodigoEmpFil;
  VprDPesquisa.CodUsuario:= varia.CodigoUsuario;
  VprDPesquisa.DatPesquisa := now;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CarDPesquisaItem(VpaDPesquisa : TRBDPesquisaSatisfacaoCorpo);
var
  VpfDPequisaItem : TRBDPesquisaSatisfacaoItem;
  VpfLacoPaginas, VpfLacoComponentes : Integer;
  VpfComponente : TWinControl;
begin
  for VpfLacoPaginas := 0 to Paginas.PageCount - 1 do
  begin
    VpfDPequisaItem := VpaDPesquisa.AddPesquisaItem;
    VpfDPequisaItem.SeqPergunta := VpfLacoPaginas + 1;
    for VpfLacoComponentes := 0 to Paginas.Pages[VpfLacoPaginas].ControlCount - 1 do
    begin
      VpfComponente := TWinControl(Paginas.Pages[VpfLacoPaginas].Controls[VpfLacoComponentes]);
      case VpfComponente.Tag of
        10 : if TRadioButton(VpfComponente).Checked then VpfDPequisaItem.DesSimNao := 'S';
        20 : if TRadioButton(VpfComponente).Checked then VpfDPequisaItem.DesSimNao := 'N';
        30 : VpfDPequisaItem.NumBomRuim := TRadioGroup(VpfComponente).ItemIndex;
        40 : VpfDPequisaItem.NumNota := Tnumerico(vpfComponente).AsInteger;
        50 : VpfDPequisaItem.DesTexto := TMemoColor(VpfComponente).Lines.text;
      end;
    end;
  end;
end;


{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.CarDClasse;
begin
  with VprDPesquisa do
  begin
    if VprTipoPesquisa = tpchamado then
    begin
      NumChamado := VprDChamado.NumChamado;
      CodTecnico := VprDChamado.CodTecnico;
    end;
  end;
  CarDPesquisaItem(VprDPesquisa);
end;

{******************************************************************************}
function TFEfetuarPesquisaSatisfacao.GravaDPesquisaChamado:string;
begin
  CarDClasse;
  result := FunPesquisaSatisfacao.GravaDPesquisaChamado(VprDPesquisa);
end;

{******************************************************************************}
function TFEfetuarPesquisaSatisfacao.EfetuarPesquisaChamado(VpaDChamado : TRBDChamado):Boolean;
Var
  VpfFunChamado : TRBFuncoesChamado;
begin
  VprTipoPesquisa := tpChamado;
  VprDChamado := VpaDChamado;
  InicializaTela;
  IF VpaDChamado.CodTipoChamado = Varia.TipoChamadoInstalacao Then
    VprDPesquisa.CodPesquisa := Varia.CodPesquisaSatisfacaoInstalacao
  else
    VprDPesquisa.CodPesquisa := Varia.CodPesquisaSatisfacaoChamado;
  CarregaPaginas(VprDPesquisa.CodPesquisa);
  showmodal;
  result := Vpracao;
  if result then
  begin
    VpfFunChamado := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
    VpfFunChamado.SetaPesquisaSatisfacaoRealizada(VpaDChamado.CodFilial,VpaDChamado.NumChamado);
    VpfFunChamado.free;
  end;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  Close;
end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfREsultado := '';
  if VprTipoPesquisa = tpChamado then
    VpfResultado := GravaDPesquisaChamado;

  if VpfResultado = '' then
  begin
    VprAcao := true;
    close;
  end
  else
    aviso(VpfResultado);

end;

{******************************************************************************}
procedure TFEfetuarPesquisaSatisfacao.SpeedButton4Click(Sender: TObject);
begin
  FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
  FNovoChamado.Consultachamado(VprDChamado.CodFilial,VprDChamado.NumChamado);
  FNovoChamado.free;
end;

procedure TFEfetuarPesquisaSatisfacao.PaginasChange(Sender: TObject);
begin
  if VprPaginaAnterior <> nil then
  begin
    VprPaginaAnterior.Caption := copy(VprPaginaAnterior.Caption,1,1);
  end;
  VprPaginaAnterior := Paginas.ActivePage;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEfetuarPesquisaSatisfacao]);
end.
