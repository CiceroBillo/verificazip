unit ANovoChamadoTecnico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  Grids, CGrades, Mask, numericos, UnDados, Constantes, UnClientes,
  DBKeyViolation, UnChamado, UnCrystal, ComCtrls, Db, DBTables, DBGrids, SqlExpr,
  Tabela, DBCtrls, IdBaseComponent, IdMessage, UnSistema, Menus, UnProdutos, UnProposta,
  DBClient, EditorImagem, FunArquivos, ExtDlgs, Shellapi;

type
  TRBDColunaGradeAnexo = (clSequencial, clDesCaminho);

  TFNovoChamado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    ValidaGravacao: TValidaGravacao;
    BImprimir: TBitBtn;
    PanelColor4: TPanelColor;
    Paginas: TPageControl;
    PChamado: TTabSheet;
    ScrollBox1: TScrollBox;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EFilial: TEditLocaliza;
    ENumChamado: TEditColor;
    ECliente: TEditLocaliza;
    ESolicitante: TEditColor;
    EDatChamado: TEditColor;
    EEnderecoAtendimento: TEditColor;
    PanelColor3: TPanelColor;
    LDesProblema: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    EDesProblema: TMemoColor;
    EServicoExecutado: TMemoColor;
    ETecnico: TEditLocaliza;
    EValChamado: Tnumerico;
    EValDeslocamento: Tnumerico;
    EDatPrevista: TMaskEditColor;
    GProdutos: TRBStringGridColor;
    PEstagio: TTabSheet;
    PanelColor5: TPanelColor;
    GridIndice1: TGridIndice;
    Splitter1: TSplitter;
    Estagios: TSQL;
    EstagiosCODESTAGIO: TFMTBCDField;
    EstagiosDATESTAGIO: TSQLTimeStampField;
    EstagiosDESMOTIVO: TWideStringField;
    EstagiosNOMEST: TWideStringField;
    EstagiosC_NOM_USU: TWideStringField;
    DataEstagios: TDataSource;
    DBMemoColor1: TDBMemoColor;
    BEmailTecnico: TBitBtn;
    BAlteraEstagio: TBitBtn;
    Label17: TLabel;
    SpeedButton4: TSpeedButton;
    ETipoChamado: TEditLocaliza;
    Label10: TLabel;
    SpeedButton5: TSpeedButton;
    Label18: TLabel;
    BAgenda: TSpeedButton;
    PopupMenu1: TPopupMenu;
    PEmails: TTabSheet;
    GEmails: TGridIndice;
    CHAMADOEMAIL: TSQL;
    DataCHAMADOEMAIL: TDataSource;
    CHAMADOEMAILDATEMAIL: TSQLTimeStampField;
    CHAMADOEMAILDESEMAIL: TWideStringField;
    CHAMADOEMAILC_NOM_USU: TWideStringField;
    ProdutosOrados1: TMenuItem;
    EHorPrevista: TMaskEditColor;
    PHotel: TPanelColor;
    EHotel: TRBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label6: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    EObservacao: TMemoColor;
    MImprimir: TPopupMenu;
    ImprimirSolicitacaoProducao1: TMenuItem;
    Aux: TSQL;
    SQLTimeStampField1: TSQLTimeStampField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    LcomplTipoChamado: TLabel;
    EDestipoChamado: TEditColor;
    PAnexos: TTabSheet;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    BFoto: TBitBtn;
    GAnexos: TRBStringGridColor;
    PanelColor8: TPanelColor;
    Foto: TImage;
    LDiretorio: TLabel;
    BCopiarImagem: TBitBtn;
    OpenImagem: TOpenPictureDialog;
    Splitter2: TSplitter;
    PanelColor9: TPanelColor;
    CEsticar: TCheckBox;
    VisualizadorImagem: TVisualizadorImagem;
    BitBtn1: TBitBtn;
    BEnviarEmailCliente: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure EClienteChange(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure BEmailTecnicoClick(Sender: TObject);
    procedure BAlteraEstagioClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosDadosValidosForaGrade(Sender: TObject;
      var VpaValidos: Boolean);
    procedure EDesProblemaEnter(Sender: TObject);
    procedure EDesProblemaExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosDblClick(Sender: TObject);
    procedure GProdutosExit(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BAgendaClick(Sender: TObject);
    procedure ProdutosOrados1Click(Sender: TObject);
    procedure ETipoChamadoCadastrar(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ETipoChamadoRetorno(Retorno1, Retorno2: String);
    procedure EHotelCadastrar(Sender: TObject);
    procedure ImprimirSolicitacaoProducao1Click(Sender: TObject);
    procedure ENumChamadoExit(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure GAnexosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GAnexosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BCopiarImagemClick(Sender: TObject);
    procedure CEsticarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BEnviarEmailClienteClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    VprDChamado : TRBDChamado;
    VprDProdutoChamado : TRBDChamadoProduto;
    VprDAnexoImagemChamado : TRBDChamadoAnexoImagem;
    VprDCliente : TRBDCliente;
    VprDProposta : TRBDPropostaCorpo;
    FunChamado : TRBFuncoesChamado;
    FunProposta : TRBFuncoesProposta;
    procedure ConfiguraTela;
    procedure InicializaTela;
    procedure CarTitulosGrade;
    procedure CarDTela;
    function CarDClasse : String;
    procedure CarDProdutoClasse;
    procedure CarDProblemaTela;
    procedure CarDAnexoImagem;
    procedure CarDPropostaChamado(VpaDProposta : TRBDPropostaCorpo);
    procedure CarDProdutosPropostaChamado(VpaDProposta : TRBDPropostaCorpo);
    procedure CarregaDadosCliente;
    function SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : string;
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure LocalizaEstagio;
    function LocalizaProduto : Boolean;
    procedure CarValChamado;
    procedure PosEmails;
    function ExisteUM : Boolean;
    function RColunaGradeAnexos(VpaColuna: TRBDColunaGradeAnexo): integer;
    procedure AdicionaCaminhoGradeAnexo(VpaCaminho: String);
    procedure CarregaFoto(VpaCaminho: String);
  public
    { Public declarations }
    function NovoChamado : Boolean;
    function AlteraChamado(VpaCodfilial,VpaNumChamado : Integer): Boolean;
    procedure Consultachamado(VpaCodFilial,VpaNumChamado : Integer);
    function NovoChamadoCliente(VpaCodCliente : Integer):Boolean;
    function NovoChamadoProposta(VpaDProposta : TRBDPropostaCorpo) : Boolean;
  end;

var
  FNovoChamado: TFNovoChamado;

implementation

uses APrincipal, constmsg,FunObjeto, AMostraObservacaoCliente, funData, FunSql,
  AAlteraEstagioChamado, ALocalizaProdutoContrato, ANovoCliente, FunString,
  AAgendaChamados, AProdutosOrcados, ATipoChamado, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoChamado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  if ((varia.CNPJFilial = CNPJ_COPYLINE) or
     (varia.CNPJFilial = CNPJ_Impox)) then
  begin
    BAgenda.Visible := false;
  end;
  FunProposta := TRBFuncoesProposta.cria(FPrincipal.BaseDados);
  CarTitulosGrade;
  VprAcao := false;
  EDatPrevista.EditMask := FPrincipal.CorFoco.AMascaraData;
  VprDChamado := TRBDChamado.cria;
  VprDCliente := TRBDCliente.cria;
  FunChamado := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
  Paginas.ActivePageIndex := 0;
  ConfiguraTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoChamado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDChamado.free;
  VprDCliente.free;
  FunChamado.free;
  FunProposta.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovoChamado.NovoChamado : Boolean;
begin
  VprOperacao := ocinsercao;
  Self.WindowState := wsNormal;
  Self.WindowState := wsMaximized;
  InicializaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovoChamado.NovoChamadoCliente(VpaCodCliente : Integer):Boolean;
begin
  VprOperacao := ocinsercao;
  InicializaTela;
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  ActiveControl := ETipoChamado;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovoChamado.NovoChamadoProposta(VpaDProposta : TRBDPropostaCorpo) : Boolean;
begin
  VprOperacao := ocinsercao;
  VprDProposta := VpaDProposta;
  InicializaTela;
  CarDPropostaChamado(VpaDProposta);
  CarDProdutosPropostaChamado(VpaDProposta);
  GProdutos.CarregaGrade;
  CarDTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoChamado.AdicionaCaminhoGradeAnexo(VpaCaminho: String);
begin
  VprDAnexoImagemChamado:= VprDChamado.AddAnexoImagem;
  VprDAnexoImagemChamado.DesCaminho:= VpaCaminho;
  GAnexos.CarregaGrade;
end;

{******************************************************************************}
function TFNovoChamado.AlteraChamado(VpaCodfilial,VpaNumChamado : Integer): Boolean;
begin
  VprOperacao := ocConsulta;
  FunChamado.CarDChamado(VpaCodfilial,VpaNumChamado,VprDChamado);
  GProdutos.ADados := VprDChamado.Produtos;
  GProdutos.CarregaGrade;
  GAnexos.ADados:= VprDChamado.AnexoImagem;
  GAnexos.CarregaGrade;
  CarDTela;
  VprOperacao := ocEdicao;
  EstadoBotoes(false);
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoChamado.ConfiguraTela;
begin
  ENumChamado.ReadOnly := not config.PermitirAlteraNumeroChamado;
  PHotel.Visible := config.NoChamadoSolicitarHotel;
  EDatPrevista.ACampoObrigatorio := not  Config.PermitirGravarOChamadoSemDataPrevisao;

  if not PHotel.Visible then
    PanelColor1.Height := PanelColor1.Height - PHotel.Height;
end;

{******************************************************************************}
procedure TFNovoChamado.Consultachamado(VpaCodFilial,VpaNumChamado : Integer);
begin
  VprOperacao := ocConsulta;
  FunChamado.CarDChamado(VpaCodfilial,VpaNumChamado,VprDChamado);
  GProdutos.ADados := VprDChamado.Produtos;
  GProdutos.CarregaGrade;
  GAnexos.ADados:= VprDChamado.AnexoImagem;
  GAnexos.CarregaGrade;
  CarDTela;
  AlterarEnabledDet([BCadastrar,BGravar,BCancelar,PanelColor3,PanelColor1],false);
  showmodal;
end;

{******************************************************************************}
procedure TFNovoChamado.ImprimirSolicitacaoProducao1Click(Sender: TObject);
begin
  if VprDChamado.CodFilial <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeChamadoProducao(VprDChamado.CodFilial,VprDChamado.NumChamado,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.InicializaTela;
begin
  LimpaComponentes(ScrollBox1,0);
  VprDChamado.free;
  VprDChamado := TRBDChamado.cria;
  GProdutos.ADados := VprDChamado.Produtos;
  GProdutos.CarregaGrade;
  GAnexos.ADados:= VprDChamado.AnexoImagem;
  GAnexos.CarregaGrade;
  VprDChamado.CodFilial := varia.CodigoEmpFil;
  VprDChamado.CodEstagio := varia.EstagioInicialChamado;
  VprDChamado.DatChamado := now;
  VprDChamado.CodUsuario := varia.CodigoUsuario;
  VprDChamado.CodTecnico := varia.CodTecnicoIndefinido;
  CarDTela;
  ActiveControl := ETipoChamado;
  EstadoBotoes(false);
  ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovoChamado.CarTitulosGrade;
begin
  GProdutos.Cells[1,0] := 'Código';
  GProdutos.Cells[2,0] := 'Produto';
  GProdutos.Cells[3,0] := 'UM';
  GProdutos.Cells[4,0] := 'Quantidade';
  GProdutos.Cells[5,0] := 'Contador';
  GProdutos.Cells[6,0] := 'Contrato';
  GProdutos.Cells[7,0] := 'Garantia';
  GProdutos.Cells[8,0] := 'Num Série';
  GProdutos.Cells[9,0] := 'Num Série Interno';
  GProdutos.Cells[10,0] := 'Setor Empresa';
  GProdutos.Cells[11,0] := 'Valor Pagina';

  GAnexos.Cells[RColunaGradeAnexos(clSequencial),0]:= 'Item';
  GAnexos.Cells[RColunaGradeAnexos(clDesCaminho),0]:= 'Caminho';
end;

{******************************************************************************}
procedure TFNovoChamado.CarDTela;
begin
  EFilial.AInteiro := VprDChamado.CodFilial;
  EFilial.Atualiza;
  ENumChamado.AInteiro := VprDChamado.NumChamado;
  if VprDChamado.DatChamado > 0 then
    EDatChamado.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDChamado.DatChamado)
  else
    EDatChamado.Clear;
  ECliente.AInteiro := VprDChamado.CodCliente;
  ECliente.Atualiza;
  ETipoChamado.AInteiro := VprDChamado.CodTipoChamado;
  ETipoChamado.Atualiza;
  ESolicitante.Text := VprDChamado.NomSolicitante;
  EEnderecoAtendimento.Text := VprDChamado.DesEnderecoAtendimento;
  ETecnico.AInteiro := VprDChamado.CodTecnico;
  ETecnico.atualiza;
  EHotel.AInteiro := VprDChamado.CodHotel;
  EHotel.Atualiza;
  if VprDChamado.DatPrevisao > montadata(1,1,1900) then
  begin
    EDatPrevista.Text := FormatDateTime('DD/MM/YYYY',VprDChamado.DatPrevisao);
    EHorPrevista.Text := FormatDateTime('HH:MM',VprDChamado.DatPrevisao);
  end
  else
    EDatPrevista.Clear;

  EValChamado.AValor := VprDChamado.ValChamado;
  EValDeslocamento.AValor := VprDChamado.ValDeslocamento;
  EObservacao.Lines.Text:= VprDChamado.DesObservacaoGeral;
  EDestipoChamado.Text:= VprDChamado.DesTipoChamado;
end;

{******************************************************************************}
procedure TFNovoChamado.CarDAnexoImagem;
begin
  VprDAnexoImagemChamado.SeqItem:= StrToInt(GAnexos.Cells[RColunaGradeAnexos(clSequencial), GAnexos.ALinha]);
  VprDAnexoImagemChamado.DesCaminho:= GAnexos.Cells[RColunaGradeAnexos(clDesCaminho), GAnexos.ALinha];
end;

{******************************************************************************}
function TFNovoChamado.CarDClasse : String;
begin
  result := '';
  if EServicoExecutado.Focused or EDesProblema.Focused then
    EDesProblemaExit(self);

  if not Config.PermitirGravarOChamadoSemDataPrevisao then
  begin
    try
      StrToDate(EDatPrevista.text);
      if DeletaChars(DeletaChars(DeletaChars(EHorPrevista.Text,':'),' '),'0') <> '' then
        StrToTime(EHorPrevista.Text);
      except
        result := 'DATA PREVISÃO ENTREGA INVÁLIDA!!!'#13'A data de previsão de entrega não é uma data válida ou não foi preenchida...';
    end;
  end
  else
  begin
    if EDatPrevista.Text <> '  /  /  ' then
    begin
      try
        StrToDate(EDatPrevista.text);
        if DeletaChars(DeletaChars(DeletaChars(EHorPrevista.Text,':'),' '),'0') <> '' then
          StrToTime(EHorPrevista.Text);
        except
          result := 'DATA PREVISÃO ENTREGA INVÁLIDA!!!'#13'A data de previsão de entrega não é uma data válida ou não foi preenchida...';
      end;
    end;
  end;

  if result = '' then
  begin
    with VprDChamado do
    begin
      CodFilial := varia.CodigoEmpFil;
      NumChamado := ENumChamado.AInteiro;
      CodCliente := ECliente.Ainteiro;
      CodHotel := EHotel.AInteiro;
      CodTecnico := ETecnico.AInteiro;
      CodTipoChamado := ETipoChamado.AInteiro;
      NomSolicitante := ESolicitante.Text;
      DesEnderecoAtendimento := EEnderecoAtendimento.Text;
      if not Config.PermitirGravarOChamadoSemDataPrevisao then
      Begin
        DatPrevisao := StrToDate(EDatPrevista.text);
        if DeletaChars(DeletaChars(DeletaChars(EHorPrevista.Text,':'),' '),'0') <> '' then
          DatPrevisao := DatPrevisao + StrToTime(EHorPrevista.Text);
      End
      else
        if EDatPrevista.Text <> '  /  /  ' then
        begin
          DatPrevisao := StrToDate(EDatPrevista.text);
          if DeletaChars(DeletaChars(DeletaChars(EHorPrevista.Text,':'),' '),'0') <> '' then
            DatPrevisao := DatPrevisao + StrToTime(EHorPrevista.Text);
        end
        else
          DatPrevisao := 0;
      ValChamado := EValChamado.AValor;
      ValDeslocamento := EValDeslocamento.AValor;
      DesObservacaoGeral:= EObservacao.Lines.Text;
      DesTipoChamado:= EDestipoChamado.Text;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.CarDProdutoClasse;
begin
  with VprDProdutoChamado do
  begin
    if GProdutos.Cells[5,GProdutos.ALinha] <> '' then
      VprDProdutoChamado.NumContador := StrToInt(GProdutos.Cells[5,GProdutos.Alinha])
    else
      VprDProdutoChamado.NumContador := 0;
    VprDProdutoChamado.DesUM := GProdutos.Cells[3,GProdutos.Alinha];
    VprDProdutoChamado.QtdProduto :=  StrToFloat(DeletaChars(GProdutos.Cells[4,GProdutos.ALinha],'.'));
    VprDProdutoChamado.NumSerie := GProdutos.Cells[8,GProdutos.Alinha];
    VprDProdutoChamado.NumSerieInterno := GProdutos.Cells[9,GProdutos.Alinha];
    VprDProdutoChamado.DesSetor := GProdutos.Cells[10,GProdutos.Alinha];
    VprDProdutoChamado.ValBackup:= StrToFloat(GProdutos.Cells[11, GProdutos.ALinha]);
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.CarDProblemaTela;
begin
  EDesProblema.Lines.Text := VprDProdutoChamado.DesProblema;
  EServicoExecutado.Lines.Text := VprDProdutoChamado.DesServicoExecutado;
end;

{******************************************************************************}
procedure TFNovoChamado.CarDPropostaChamado(VpaDProposta : TRBDPropostaCorpo);
begin
  with VprDChamado do
  begin
    CodFilial := VpaDProposta.CodFilial;
    CodCliente := VpaDProposta.CodCliente;
    NomSolicitante := VpaDProposta.NomContato;
    NomContato := VpaDProposta.NomContato;
    DesEmail := VpaDProposta.DesEmail;
    IndPesquisaSatisfacao := false;
    CodTecnico := Varia.CodTecnicoIndefinido;
    CodTipoChamado := Varia.TipoChamadoInstalacao;
    DatPrevisao := date;
    DesObservacaoGeral:= VpaDProposta.DesObservacaoInstalacao;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.CarDProdutosPropostaChamado(VpaDProposta : TRBDPropostaCorpo);
var
  VpfLaco : Integer;
  VpfDProProposta : TRBDPropostaProduto;
  VpfDMaterialAcabamento: TRBDPropostaMaterialAcabamento;
begin
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProProposta := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    VprDProdutoChamado := VprDChamado.AddProdutoChamado;
    VprDProdutoChamado.CodFilialChamado := VprDChamado.CodFilial;
    VprDProdutoChamado.SeqProduto := VpfDProProposta.SeqProduto;
    VprDProdutoChamado.CodProduto := VpfDProProposta.CodProduto;
    VprDProdutoChamado.NomProduto := VpfDProProposta.NomProduto;
    VprDProdutoChamado.DesUM := VpfDProProposta.UM;
    VprDProdutoChamado.QtdProduto := VpfDProProposta.QtdProduto;
    VprDProdutoChamado.UnidadeParentes.free;
    VprDProdutoChamado.UnidadeParentes := FunProdutos.RUnidadesParentes(VprDProdutoChamado.DesUM);
  end;
  for VpfLaco := 0 to VpaDProposta.MaterialAcabamento.Count - 1 do
  begin
    VpfDMaterialAcabamento := TRBDPropostaMaterialAcabamento(VpaDProposta.MaterialAcabamento.Items[VpfLaco]);
    VprDProdutoChamado := VprDChamado.AddProdutoChamado;
    VprDProdutoChamado.CodFilialChamado := VprDChamado.CodFilial;
    VprDProdutoChamado.SeqProduto := VpfDMaterialAcabamento.SeqProduto;
    VprDProdutoChamado.CodProduto := VpfDMaterialAcabamento.CodProduto;
    VprDProdutoChamado.NomProduto := VpfDMaterialAcabamento.NomProduto;
    VprDProdutoChamado.DesUM := VpfDMaterialAcabamento.UM;
    VprDProdutoChamado.QtdProduto := VpfDMaterialAcabamento.Quantidade;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.CarregaDadosCliente;
var
  VpfResultado : String;
begin
  if ECliente.Ainteiro <> VprDChamado.CodCliente then
  begin
    VprDChamado.CodCliente := ECliente.AInteiro;
    VprDCliente.CodCliente :=  VprDChamado.CodCliente;
    if VprDCliente.CodCliente <> 0 then
    begin
      FunClientes.CarDCliente(VprDCliente);
      //carrega o nome do contato
      if (VprOperacao in [ocinsercao,ocedicao]) then
      begin
        VpfResultado := SituacaoFinanceiraOK(VprDCliente);
        if VpfResultado <> '' then
          aviso(VpfResultado);

        if (VprDCliente.CodTecnico <> 0) and (ETecnico.AInteiro = 0) then
        begin
          ETecnico.AInteiro := VprDCliente.CodTecnico;
          ETecnico.Atualiza;
        end;
      end;
      EValChamado.Clear;
      EValDeslocamento.clear;
      EValChamado.Clear;
      EValDeslocamento.clear;
      if not(VprDCliente.IndPossuiContrato) and not(VprDChamado.IndGarantia) then
      begin
        EValChamado.AValor := Varia.ValChamado;
        EValDeslocamento.AValor := FunClientes.RValDeslocamentoCliente(VprDCliente.DesCidade);
      end;
      if VprDCliente.DesObservacao <> '' then
      begin
        FMostraObservacaoCliente := TFMostraObservacaoCliente.CriarSDI(application , '', FPrincipal.VerificaPermisao('FMostraObservacaoCliente'));
        FMostraObservacaoCliente.MostraObservacaoCliente(VprDCliente);
        FMostraObservacaoCliente.free;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.CarregaFoto(VpaCaminho: String);
begin
  try
     Foto.Picture.LoadFromFile(VpaCaminho)
  except
     Foto.Picture := nil;
  end;
end;

{******************************************************************************}
function TFNovoChamado.SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : string;
begin
  if config.BloquearClienteEmAtraso then
  begin
    if VprDCliente.DuplicatasEmAtraso > 0 then
    begin
      if not Confirmacao('CLIENTE COM DUPLICATAS VENCIDAS!!!'#13'Este cliente possui duplicatas vencidas no valor de "'+FormatFloat('#,###,###,###,##0.00',VprDCliente.DuplicatasEmAtraso)+'". Deseja faturar para esse cliente ?') then
      begin
        ECliente.Clear;
        result := 'NÃO FOI POSSÍVEL GRAVAR O CLIENTE!!!'#13'Cliente com duplicatas vencidas.';
      end;
    end;
  end;
  if VprDCliente.IndBloqueado then
  begin
    result := 'CLIENTE BLOQUEADO!!!'#13'Este cliente encontra-se bloqueado, não é permitido fazer cotações para clientes bloqueados. Solicite o desbloqueio desse cliente.';
    ECliente.clear;
    VprDChamado.CodCliente := 0;
  end;

end;

{******************************************************************************}
procedure TFNovoChamado.EstadoBotoes(VpaEstado : Boolean);
begin
  BCadastrar.Enabled := VpaEstado;
  BFechar.Enabled := VpaEstado;
  BGravar.Enabled := not VpaEstado;
  BCancelar.Enabled := not VpaEstado;
  BImprimir.Enabled := VpaEstado;
  BAlteraEstagio.Enabled := VpaEstado;
  BEmailTecnico.Enabled := VpaEstado;
  BEnviarEmailCliente.Enabled := VpaEstado;
end;

{******************************************************************************}
procedure TFNovoChamado.LocalizaEstagio;
begin
  if VprDChamado.NumChamado <> 0 then
  begin
    AdicionaSQLAbreTabela(Estagios,'select CHA.CODESTAGIO,CHA.DATESTAGIO, CHA.DESMOTIVO, '+
                                 ' EST.NOMEST, '+
                                 ' USU.C_NOM_USU '+
                                 ' from ESTAGIOCHAMADO CHA, ESTAGIOPRODUCAO EST, CADUSUARIOS USU '+
                                 ' Where CHA.CODESTAGIO = EST.CODEST '+
                                 ' AND CHA.CODUSUARIO = USU.I_COD_USU '+
                                 ' AND CHA.CODFILIAL = '+IntToStr(VprDChamado.CodFilial)+
                                 ' AND CHA.NUMCHAMADO = '+IntToStr(VprDChamado.NumChamado)+
                                 ' order by CHA.SEQESTAGIO');
  end
  else
    Estagios.close;
end;

{******************************************************************************}
function TFNovoChamado.LocalizaProduto : Boolean;
begin
  result := false;
  if ECliente.AInteiro <> 0 then
  begin
    FLocalizaProdutoContrato := TFLocalizaProdutoContrato.CriarSDI(self,'',FPrincipal.VerificaPermisao('FLocalizaProdutoContrato'));
    result := FLocalizaProdutoContrato.LocalizaProdutoChamado(ECliente.AInteiro,VprDProdutoChamado);
    FLocalizaProdutoContrato.free;
    if result then
      GProdutosCarregaItemGrade(GProdutos,GProdutos.ALinha);
  end
  else
    aviso('FALTA PREENCHER O CLIENTE!!!'#13'Antes de localizar o produto é necessário preencher o cliente.');
end;

{******************************************************************************}
procedure TFNovoChamado.CarValChamado;
var
  VpfLaco : Integer;
  VpfPossuiContrato : Boolean;
begin
  VpfPossuiContrato := false;
  for Vpflaco := 0 to VprDChamado.Produtos.Count - 1 do
  begin
    if TRBDChamadoProduto(VprDChamado.Produtos.Items[VpfLaco]).SeqContrato <> 0 then
    begin
      VpfPossuiContrato := true;
      break;
    end;
  end;
  if not VpfPossuiContrato then
  begin
    VprDChamado.ValChamado := Varia.ValChamado;
    VprDChamado.ValDeslocamento := FunClientes.RValDeslocamentoCliente(VprDCliente.DesCidade);
    EValChamado.AValor := VprDChamado.ValChamado;
    EValDeslocamento.AValor := VprDChamado.ValDeslocamento;
  end;
end;

procedure TFNovoChamado.CEsticarClick(Sender: TObject);
begin
  Foto.Stretch := CEsticar.Checked;
end;

{******************************************************************************}
procedure TFNovoChamado.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  VpfResultado := CarDClasse;
  VpfTransacao.IsolationLevel :=xilDIRTYREAD;
  FPrincipal.BaseDados.StartTransaction(vpfTransacao);
  if VpfResultado = '' then
  begin
    VpfResultado := FunChamado.GravaDChamado(VprDChamado);
    if VpfResultado = '' then
    begin
      VprAcao := true;
      if VpfResultado = '' then
      begin
        if VprDProposta <> nil then
          VpfResultado := FunProposta.AdicionaPropostaChamado(VprDChamado.CodFilial,VprDProposta.SeqProposta,VprDChamado.NumChamado);
      end;
      EstadoBotoes(true);
    end;
  end;
  if vpfResultado <> '' then
  begin
    if FPrincipal.BaseDados.inTransaction then
      FPrincipal.BaseDados.Rollback(VpfTransacao);
    aviso(VpfResultado)
  end
  else
  begin
    FPrincipal.BaseDados.Commit(VpfTransacao);
    if VprOperacao = ocInsercao then
      if Config.EnviaChamadoEmailTecnico then
         BEmailTecnico.Click;
    ENumChamado.AInteiro := VprDChamado.NumChamado;
  end;
  sistema.SalvaTabelasAbertas;
end;

{******************************************************************************}
procedure TFNovoChamado.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoChamado.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovoChamado.BFotoClick(Sender: TObject);
Var
  VpfNomArquivo : string;
begin
  if VprOperacao in [ocEdicao, ocInsercao] then
    if OpenImagem.Execute then
      AdicionaCaminhoGradeAnexo(OpenImagem.FileName);
end;

{******************************************************************************}
procedure TFNovoChamado.EClienteRetorno(Retorno1, Retorno2: String);
begin
  CarregaDadosCliente;
end;

{******************************************************************************}
procedure TFNovoChamado.EClienteChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    Validagravacao.execute;
end;

{******************************************************************************}
procedure TFNovoChamado.BCadastrarClick(Sender: TObject);
begin
  InicializaTela;
  VprOperacao := ocInsercao;
end;

{******************************************************************************}
procedure TFNovoChamado.BImprimirClick(Sender: TObject);
begin
  if VprDChamado.NumChamado <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeChamado(VprDChamado.CodFilial,VprDChamado.NumChamado,false);
    dtRave.free;
  end;
end;

procedure TFNovoChamado.BitBtn1Click(Sender: TObject);
begin
  VisualizadorImagem.execute( Varia.DriveFoto+ '\Chamados\' +VprDAnexoImagemChamado.DesCaminho)
end;

{******************************************************************************}
procedure TFNovoChamado.BCopiarImagemClick(Sender: TObject);
var
  VpfNomArquivo, VpfResultado: String;
begin
  VpfResultado:= FunChamado.SalvaImagemdaAreaTransferenciaWindows(VprDChamado,VpfNomArquivo );
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AdicionaCaminhoGradeAnexo(VpfNomArquivo);
end;

{******************************************************************************}
procedure TFNovoChamado.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PEstagio then
    LocalizaEstagio
  else
    if Paginas.ActivePage = PEmails then
      PosEmails;
end;

{******************************************************************************}
procedure TFNovoChamado.PosEmails;
begin
  CHAMADOEMAIL.SQL.Clear;
  CHAMADOEMAIL.SQL.Add('SELECT CME.DATEMAIL, CME.DESEMAIL, USU.C_NOM_USU'+
                       ' FROM CHAMADOEMAIL CME, CADUSUARIOS USU'+
                       ' WHERE USU.I_COD_USU = CME.CODUSUARIO'+
                       ' AND CME.NUMCHAMADO = '+IntToStr(VprDChamado.NumChamado));
  CHAMADOEMAIL.SQL.Add(' ORDER BY CME.DATEMAIL');
  GEmails.ALinhaSQLOrderBy:= CHAMADOEMAIL.SQL.Count-1;
  CHAMADOEMAIL.Open;
end;

{******************************************************************************}
function TFNovoChamado.ExisteUM : Boolean;
begin
  result := (VprDProdutoChamado.UnidadeParentes.IndexOf(GProdutos.Cells[3,GProdutos.Alinha]) >= 0);
end;

{******************************************************************************}
procedure TFNovoChamado.BEmailTecnicoClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if VprDCliente.CodCliente = 0 then
  begin
    VprDCliente.CodCliente :=  VprDChamado.CodCliente;
    FunClientes.CarDCliente(VprDCliente);
  end;
  VpfResultado := FunChamado.EnviaEmailChamado(VprDChamado,VprDCliente,FunChamado.REmailTecnico(VprDChamado.CodTecnico));
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFNovoChamado.BEnviarEmailClienteClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunChamado.EnviaEmailChamadoCliente(VprDChamado, VprDCliente);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFNovoChamado.BAlteraEstagioClick(Sender: TObject);
begin
  FAlteraEstagioChamado := TFAlteraEstagioChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
  FAlteraEstagioChamado.AlteraEstagioChamados(IntToStr(VprDChamado.NumChamado));
  FAlteraEstagioChamado.free;
end;

{******************************************************************************}
procedure TFNovoChamado.GAnexosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDAnexoImagemChamado := TRBDChamadoAnexoImagem(VprDChamado.AnexoImagem.Items[VpaLinha-1]);
  GAnexos.Cells[RColunaGradeAnexos(clSequencial),VpaLinha] := IntToStr(VprDAnexoImagemChamado.SeqItem);
  GAnexos.Cells[RColunaGradeAnexos(clDesCaminho),VpaLinha] := VprDAnexoImagemChamado.DesCaminho;
end;

{******************************************************************************}
procedure TFNovoChamado.GAnexosMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDChamado.AnexoImagem.Count >0 then
  begin
    VprDAnexoImagemChamado := TRBDChamadoAnexoImagem(VprDChamado.AnexoImagem.Items[VpaLinhaAtual-1]);
    CarregaFoto(Varia.DriveFoto+ '\Chamados\'+ GAnexos.Cells[RColunaGradeAnexos(clDesCaminho), GAnexos.ALinha]);
  end;
end;


{******************************************************************************}
procedure TFNovoChamado.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProdutoChamado := TRBDChamadoProduto(VprDChamado.Produtos.Items[VpaLinha-1]);
  GProdutos.Cells[1,VpaLinha] := VprDProdutoChamado.CodProduto;
  GProdutos.Cells[2,VpaLinha] := VprDProdutoChamado.NomProduto;
  GProdutos.Cells[3,VpaLinha] := VprDProdutoChamado.DesUM;
  GProdutos.Cells[4,GProdutos.ALinha] := FormatFloat(Varia.MascaraQtd,VprDProdutoChamado.QtdProduto);
  if VprDProdutoChamado.NumContador <> 0 then
    GProdutos.Cells[5,VpaLinha] := IntToStr(VprDProdutoChamado.NumContador)
  else
    GProdutos.Cells[5,VpaLinha] := '';
  GProdutos.Cells[6,VpaLinha] := VprDProdutoChamado.DesContrato;
  IF VprDProdutoChamado.DatGarantia > MontaData(1,1,1990) then
    GProdutos.Cells[7,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDProdutoChamado.DatGarantia)
  else
    GProdutos.Cells[7,VpaLinha] := '';
  GProdutos.Cells[8,VpaLinha] := VprDProdutoChamado.NumSerie;
  GProdutos.Cells[9,VpaLinha] := VprDProdutoChamado.NumSerieInterno;
  GProdutos.Cells[10,VpaLinha] := VprDProdutoChamado.DesSetor;
  GProdutos.Cells[11,VpaLinha] := FormatFloat(Varia.MascaraValor,VprDProdutoChamado.ValBackup);
  CarDProblemaTela;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      LocalizaProduto;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosNovaLinha(Sender: TObject);
begin
  VprDProdutoChamado := VprDChamado.AddProdutoChamado;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GProdutos.Cells[1,GProdutos.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if (VprDProdutoChamado.UnidadeParentes.IndexOf(GProdutos.Cells[3,GProdutos.Alinha]) < 0) then
    begin
      VpaValidos := false;
      aviso(CT_UNIDADEVAZIA);
      GProdutos.col := 3;
    end
    else
      if (GProdutos.Cells[4,GProdutos.ALinha] = '') then
      begin
        VpaValidos := false;
        aviso(CT_QTDPRODUTOINVALIDO);
        GProdutos.Col := 4;
      end;

  if VpaValidos then
  begin
    CarDProdutoClasse;
    if (VprDProdutoChamado.QtdProduto = 0) then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GProdutos.col := 4;
    end
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    7 :  Value := '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  if GProdutos.col in [1,2,6] then  //
    key := #0;

end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDChamado.Produtos.Count >0 then
  begin
    VprDProdutoChamado := TRBDChamadoProduto(VprDChamado.Produtos.Items[VpaLinhaAtual-1]);
    CarDProblemaTela;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosDadosValidosForaGrade(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  VprDProdutoChamado.DesProblema := EDesProblema.Lines.text;
  VprDProdutoChamado.DesServicoExecutado := EServicoExecutado.Lines.text;
end;

{******************************************************************************}
procedure TFNovoChamado.EDesProblemaEnter(Sender: TObject);
begin
  if VprDChamado.Produtos.Count = 0 then
  begin
    aviso('CHAMADO SEM PRODUTOS!!!'#13'Antes de descrever o problema é necessário preencher o produto a que se refere.');
    ActiveControl := GProdutos;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.EDesProblemaExit(Sender: TObject);
var
  VpfValidos : Boolean;
begin
  GProdutosDadosValidosForaGrade(GProdutos,VpfValidos);
end;

procedure TFNovoChamado.EHotelCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.CadClientesC_IND_HOT.AsString := 'S';
  FNovoCliente.showmodal;
  FNovoCliente.free;
end;

procedure TFNovoChamado.ENumChamadoExit(Sender: TObject);
begin
  if FunChamado.VerificaSeNumeroChamadoExiste(ENumChamado.AInteiro, varia.CodigoEmpFil) then
    if not Confirmacao('O chamado ' + IntToStr(ENumChamado.AInteiro) + ' já está sendo utilizado, deseja alterar?' ) then
      ENumChamado.SetFocus;
end;

{******************************************************************************}
procedure TFNovoChamado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 115 then
  begin
    if ActiveControl = GProdutos then
      ActiveControl := EDesProblema
    else
      ActiveControl := GProdutos;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosDblClick(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    LocalizaProduto;
end;

{******************************************************************************}
procedure TFNovoChamado.GProdutosExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    CarValChamado;
end;

{******************************************************************************}
procedure TFNovoChamado.SpeedButton4Click(Sender: TObject);
begin
  if ECliente.AInteiro <> 0 then
  begin
    FNovoCliente := TFNovoCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    FNovoCliente.ConsultaCliente(ECliente.AInteiro);
    FNovoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.BAgendaClick(Sender: TObject);
begin
  FAgendaChamados := TFAgendaChamados.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendaChamados'));
  FAgendaChamados.AgendaChamados;
  FAgendaChamados.free;
end;


{******************************************************************************}
procedure TFNovoChamado.ProdutosOrados1Click(Sender: TObject);
begin
  FProdutosOrcados:= TFProdutosOrcados.CriarSDI(Application,'',True);
  FProdutosOrcados.CadastraProdutosOrcados(VprDChamado,VprDProdutoChamado);
  FProdutosOrcados.Free;
end;

{******************************************************************************}
function TFNovoChamado.RColunaGradeAnexos(VpaColuna: TRBDColunaGradeAnexo): integer;
begin
  case VpaColuna of
    clSequencial: Result:= 1;
    clDesCaminho: Result:= 2;
  end;
end;

{******************************************************************************}
procedure TFNovoChamado.ETipoChamadoCadastrar(Sender: TObject);
begin
  FTipoChamado := TFTipoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTipoChamado'));
  FTipoChamado.BotaoCadastrar1.Click;
  FTipoChamado.ShowModal;
  FTipoChamado.free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovoChamado.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        3 : if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              GProdutos.col := 3;
              abort;
            end;
      end;
    end;

end;

{******************************************************************************}
procedure TFNovoChamado.ETipoChamadoRetorno(Retorno1, Retorno2: String);
begin
  if VprDChamado.CodTipoChamado <> ETipoChamado.AInteiro then
  begin
    VprDChamado.IndGarantia := Retorno1 = 'S';
    VprDChamado.CodCliente := -1;
    CarregaDadosCliente;
    VprDChamado.CodTipoChamado := ETipoChamado.AInteiro;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoChamado]);
end.
