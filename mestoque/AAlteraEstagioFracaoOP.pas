unit AAlteraEstagioFracaoOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  ComCtrls, DBKeyViolation, UnDadosProduto, UnOrdemProducao, Mask,
  numericos, MPlayer;

type
  TFAlteraEstagioFracaoOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    EFilial: TEditLocaliza;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    EOrdemProducao: TEditLocaliza;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    EFracao: TEditLocaliza;
    Label5: TLabel;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    EEstagioAtual: TEditLocaliza;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    EEstagio: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    EObservacao: TMemoColor;
    Label11: TLabel;
    ValidaGravacao1: TValidaGravacao;
    EUsuario: TEditLocaliza;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    SIdEstagio: TSpeedButton;
    Label15: TLabel;
    EIDEstagio: TEditLocaliza;
    EQtdFracoes: Tnumerico;
    Label16: TLabel;
    Label17: TLabel;
    SpeedButton7: TSpeedButton;
    LNomProduto: TLabel;
    EProduto: TEditLocaliza;
    CAutoCadastrar: TCheckBox;
    CReimprimirEtiqueta: TCheckBox;
    Som: TMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure EFracaoRetorno(Retorno1, Retorno2: String);
    procedure EEstagioRetorno(Retorno1, Retorno2: String);
    procedure EFilialChange(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure EIDEstagioSelect(Sender: TObject);
    procedure EFilialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EOrdemProducaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQtdFracoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EEstagioAtualFimConsulta(Sender: TObject);
  private
    { Private declarations }
    VprAcao : boolean;
    VprCodFilial,
    VprSeqOrdem : Integer;
    VprDEstagio : TRBDEstagioFracaoOPReal;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    VprFracoes : TList;
    function DadosValidos : string;
    procedure InicializaTela;
    procedure CarDClasse;
    procedure PreencheCodBarras;
    procedure CarregaFracoesProduto;
    procedure CarEstagioFracoes(VpaOrdemProducao :TRBDordemProducao);
    procedure ImprimeEtiquetas;
  public
    { Public declarations }
    function alteraEstagioFracaoOP:Boolean;
    Function AlteraEstagioFracao(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer):Boolean;
  end;

var
  FAlteraEstagioFracaoOP: TFAlteraEstagioFracaoOP;

implementation

uses APrincipal, ConstMsg,Constantes, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioFracaoOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CAutoCadastrar.Checked := config.AutoCadastraAlteraEstagio;
  VprFracoes := TList.Create;
  VprDEstagio := TRBDEstagioFracaoOPReal.Cria;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioFracaoOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDEstagio.free;
  FunOrdemProducao.free;
  FreeTObjectsList(VprFracoes);
  VprFracoes.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.BCancelarClick(Sender: TObject);
begin
  VprAcao := False;
  close;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EOrdemProducaoSelect(Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EFracaoRetorno(Retorno1,
  Retorno2: String);
begin
  EEstagioAtual.Text := Retorno1;
  EEstagioAtual.Atualiza;
  if Config.ProximoEstagioOPAutomatico then
  begin
    EEstagio.AInteiro := FunOrdemProducao.RProximoEstagioFracao(EFilial.AInteiro,EOrdemProducao.AInteiro,EFracao.AInteiro,EEstagioAtual.AInteiro);
    EEstagio.Atualiza;
  end;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EEstagioRetorno(Retorno1,
  Retorno2: String);
begin
  EObservacao.ACampoObrigatorio := Retorno1 = 'S';
  VprDEstagio.IndEstagioFinal := Retorno2 = 'S';
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EFilialChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
function TFAlteraEstagioFracaoOP.DadosValidos : string;
begin
  result := '';
  if EEstagio.AInteiro = 0 then
    result := 'ESTAGIO NÃO PREENCHIDO!!!'#13'É necessário preenhcer o codigo do estagio.';
  if EObservacao.ACampoObrigatorio and (EObservacao.Lines.Text = '') then
    result := 'OBSERVAÇÃO DA MUDANÇA DE ESTÁGIO NÃO PREENCHIDA!!!'#13'É necessário preencher o motivo de mudança do estágio.';
  if VprFracoes.Count > 0 then
    if EQtdFracoes.AsInteger > VprFracoes.Count then
      result := 'QUANTIDADE DE FRAÇÕES A BAIXAR INVÁLIDA!!!'#13'A quantidade de fração a baixar é maior que o numero de frações com esse produto';
  if EFracao.AInteiro = 0 then
    result := 'FRAÇÃO NÃO PREENCHIDA!!!'#13'É necessário preencher a fração.';
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.InicializaTela;
begin
  FreeTObjectsList(VprFracoes);
  LimpaComponentes(PanelColor1,0);
  EUsuario.AInteiro := Varia.CodigoUsuario;
  EUsuario.Atualiza;
  VprDEstagio.free;
  VprDEstagio := TRBDEstagioFracaoOPReal.Cria;
  ActiveControl := EFilial;
  if VprCodFilial <> 0 then
  begin
    EFilial.AInteiro := VprCodFilial;
    EFilial.Atualiza;
  end;
  if VprSeqOrdem <> 0 then
  begin
    EOrdemProducao.AInteiro := VprSeqOrdem;
    EOrdemProducao.Atualiza;
    ActiveControl := EProduto;
  end;

end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.CarDClasse;
begin
  with VprDEstagio do
  begin
    CodFilial := EFilial.AInteiro;
    SeqOrdem := EOrdemProducao.AInteiro;
    SeqFracao := EFracao.AInteiro;
    SeqEstagio := EIDEstagio.AInteiro;
    CodEstagio := EEstagio.AInteiro;
    CodEstagioAtual := EEstagioAtual.AInteiro;
    DesObservacao := EObservacao.Lines.text;
    CodUsuario := EUsuario.Ainteiro;
    CodUsuarioLogado := varia.CodigoUsuario;
  end;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.PreencheCodBarras;
begin
  if Length(EFilial.Text) = 12 then
  begin
    EOrdemProducao.AInteiro := StrtoInt(copy(EFilial.Text,3,6));
    EFracao.AInteiro := StrToInt(copy(EFilial.Text,9,4));
    EFilial.AInteiro := StrToInt(copy(EFilial.Text,1,2));
    EFilial.Atualiza;
    EOrdemProducao.Atualiza;
    EFracao.Atualiza;
    ActiveControl := EEstagio;
    if (EEstagio.Ainteiro <> 0) and (CAutoCadastrar.Checked) then
      BOk.click;
  end
  else
    if Length(EFilial.Text) = 14 then
    begin
      EOrdemProducao.AInteiro := StrtoInt(copy(EFilial.Text,3,6));
      EProduto.Text := copy(EFilial.Text,9,6);
      EFilial.AInteiro := StrToInt(copy(EFilial.Text,1,2));
      EFilial.Atualiza;
      EOrdemProducao.Atualiza;
      CarregaFracoesProduto;
      ActiveControl := EQtdFracoes;
    end
    else
      if Length(EFilial.Text) = 3 then
      begin
        EFilial.AInteiro := EFilial.AInteiro;
        EFilial.Atualiza;
        EOrdemProducao.SetFocus;
      end;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.CarregaFracoesProduto;
begin
  EProduto.Atualiza;
  FunOrdemProducao.CarFracoesProduto(EFilial.AInteiro,EOrdemProducao.AInteiro,EProduto.AInteiro,VprFracoes);
  EQtdFracoes.AsInteger := VprFracoes.Count;
  if VprFracoes.Count > 0 then
  begin
    EFracao.AInteiro := TRBDFracaoOrdemProducao(VprFracoes.Items[0]).SeqFracao;
    EFracao.Atualiza;
    EQtdFracoes.SetFocus;
  end;
  VprCodFilial := EFilial.AInteiro;
  VprSeqOrdem := EOrdemProducao.AInteiro;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.CarEstagioFracoes(VpaOrdemProducao :TRBDordemProducao);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaOrdemProducao.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaOrdemProducao.Fracoes.Items[VpfLaco]);
    FunOrdemProducao.CarDFracaoOPEstagio(VpfDFracao,VpfDFracao.codFilial,VpfDFracao.SeqOrdemProducao);
  end;

end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.ImprimeEtiquetas;
var
  VpfDOrdemProducao : TRBDOrdemProducao;
begin
  VpfDOrdemProducao := TRBDOrdemProducao.cria;
  VpfDOrdemProducao.DatEmissao := date;
  if VprFracoes.Count = 0 then
  begin
    VpfDOrdemProducao.Fracoes.add(FunOrdemProducao.cardfracaoop(nil,EFilial.AInteiro,EOrdemProducao.AInteiro,
                     EFracao.AInteiro));
  end
  else
    VpfDOrdemProducao.Fracoes := VprFracoes;

  CarEstagioFracoes(VpfDOrdemProducao);
  FunOrdemProducao.ImprimeEtiquetaFracao(VpfDOrdemProducao);
  VpfDOrdemProducao.free;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.BOkClick(Sender: TObject);
var
  VpfResultado : String;
  VpfLaco : Integer;
begin
  VpfResultado := DadosValidos;

  if VpfResultado = '' then
  begin
    CarDClasse;

    if VprFracoes.Count > 0 then
    begin
      for VpfLaco := 0 to EQtdFracoes.AsInteger - 1 do
      begin
        VprDEstagio.CodEstagioAtual := TRBDFracaoOrdemProducao(VprFracoes.Items[VpfLaco]).CodEstagio;
        VprDEstagio.SeqFracao := TRBDFracaoOrdemProducao(VprFracoes.Items[VpfLaco]).SeqFracao;
        VpfResultado := FunOrdemProducao.AlteraEstagioFracaoOP(VprDEstagio);
        if VpfResultado = '' then
          FunOrdemProducao.BaixaConsumoFracaoAlteraEstagio(VprDEstagio.CodFilial,VprDEstagio.SeqOrdem,VprDEstagio.SeqFracao);
        if VpfResultado <> '' then
          break;
      end;
    end
    else
    begin
      VpfResultado := FunOrdemProducao.AlteraEstagioFracaoOP(VprDEstagio);
      if VpfResultado = '' then
        FunOrdemProducao.BaixaConsumoFracaoAlteraEstagio(VprDEstagio.CodFilial,VprDEstagio.SeqOrdem,VprDEstagio.SeqFracao);
    end;
  end;
  if VpfResultado = '' then
  begin
    VprAcao := true;
    try
    Som.play;
    except
    end;
    if CReimprimirEtiqueta.Checked then
      ImprimeEtiquetas;
    if not CAutoCadastrar.Checked then
      close
    else
    begin
      InicializaTela; 
    end;
  end
  else
    Aviso(VpfResultado);
end;

{******************************************************************************}
function TFAlteraEstagioFracaoOP.alteraEstagioFracaoOP:Boolean;
begin
  InicializaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
Function TFAlteraEstagioFracaoOP.AlteraEstagioFracao(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer):Boolean;
begin
  EUsuario.AInteiro := Varia.CodigoUsuario;
  EUsuario.Atualiza;
  EFilial.AInteiro := VpaCodFilial;
  EFilial.Atualiza;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EOrdemProducao.Atualiza;
  EFracao.AInteiro := VpaSeqFracao;
  EFracao.Atualiza;
  ActiveControl := EFilial;
  showmodal;
  result := VprAcao;
end;

procedure TFAlteraEstagioFracaoOP.EIDEstagioSelect(Sender: TObject);
begin
  EIDEstagio.ASelectValida.Text := 'Select FRA.SEQESTAGIO, PRO.DESESTAGIO, PRO.QTDPRODUCAOHORA, FRA.QTDPRODUZIDO '+
                                  ' from FRACAOOPESTAGIO FRA, PRODUTOESTAGIO PRO '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro)+
                                  ' AND FRA.SEQFRACAO = '+ IntToStr(EFracao.AInteiro)+
                                  ' AND FRA.SEQESTAGIO = @'+
                                  ' AND PRO.SEQPRODUTO = FRA.SEQPRODUTO '+
                                  ' AND PRO.SEQESTAGIO = FRA.SEQESTAGIO';
  EIDEstagio.ASelectLocaliza.Text := 'Select FRA.SEQESTAGIO, PRO.DESESTAGIO, PRO.QTDPRODUCAOHORA, FRA.QTDPRODUZIDO '+
                                  ' from FRACAOOPESTAGIO FRA, PRODUTOESTAGIO PRO '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro)+
                                  ' AND FRA.SEQFRACAO = '+ IntToStr(EFracao.AInteiro)+
                                  ' AND PRO.DESESTAGIO LIKE ''@%'''+
                                  ' AND PRO.SEQPRODUTO = FRA.SEQPRODUTO '+
                                  ' AND PRO.SEQESTAGIO = FRA.SEQESTAGIO';

end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EFilialKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    PreencheCodBarras;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    BOk.Click;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EProdutoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    CarregaFracoesProduto;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EOrdemProducaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    EOrdemProducao.AInteiro := EOrdemProducao.AInteiro;
    EOrdemProducao.Atualiza;
    EProduto.SetFocus;
  end;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.EQtdFracoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    if EQtdFracoes.AsInteger = EProduto.AInteiro then
      EQtdFracoes.AsInteger := VprFracoes.Count;
    BOk.Click;
  end;
end;

{******************************************************************************}
procedure TFAlteraEstagioFracaoOP.FormShow(Sender: TObject);
begin
  try
    Som.Open;
  except
  end;
end;

procedure TFAlteraEstagioFracaoOP.EEstagioAtualFimConsulta(
  Sender: TObject);
begin
  if Config.ImprimirEtiquetanaAlteracaodoEstagio then
  begin
    CReimprimirEtiqueta.Checked := true;
    if ((EEstagioAtual.AInteiro = varia.EstagioSerra) or (EEstagioAtual.AInteiro = Varia.EstagioPantografo)) then
      CReimprimirEtiqueta.Checked := false;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioFracaoOP]);
end.
