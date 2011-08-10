unit ANovaNotaFiscaisFor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Tabela, StdCtrls, Mask, DBCtrls, Componentes1, ExtCtrls,
  PainelGradiente,  Buttons, Grids, DBGrids, Constantes,ConstMsg, UnDados,
  BotaoCadastro, DBKeyViolation, Localizacao, ConvUnidade, UnProdutos, UnNotasFiscaisFor,
  Spin, numericos, UnContasapagar, CGrades, UnDadosProduto, UnContasAReceber,
  UnDadosLocaliza, FMTBcd, SqlExpr, unPedidoCompra, ComCtrls, DBClient,
  CBancoDados;

Const
  CT_FALTAMPRODUTOS = 'FALTAM PRODUTOS!!! Falta digitar os produtos da nota fiscal...';
  CT_DATAMENORULTIMOFECHAMENTO='DATA NÃO PODE SER MENOR QUE A DO ULTIMO FECHAMENTO!!!A data de digitação do produto não ser menor que a data do ultimo fechamento...';

type
  TRBDColunaGrade =(clCodProduto,clNomProduto,clCodCor,clNomCor,clCodTamanho,clNomTamanho,clCFOP,clClassificacaoFiscal,clCST,clQtdChapas,clLargura,clComprimento,clUm,clQtdPro,ClValUnitarioPro,clValTotalPro,clPerIcms,clPerIpi,clPerMva,clPerMvaAjustado,clBaseSt,clValST,clPerAcumulado,clValorVenda,clNumSerie,clNumLote,clRefFornecedor,clEtiquetas,clBaseIcms,clValIcms,clPerReducaoICMS);
  TRBDColunaGradeServicos =(clCodServico,clDescServico,clDescAdicional,clQtd,clValUnitario, clValTotal,clserCodCFOP);

  TFNovaNotaFiscaisFor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Tempo: TPainelTempo;
    ValidaGravacao1: TValidaGravacao;
    Localiza: TConsultaPadrao;
    Aux: TSQLQuery;
    ScrollBox1: TScrollBox;
    PanelColor1: TPanelColor;
    Shape3: TShape;
    Shape2: TShape;
    Shape1: TShape;
    Label6: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Shape4: TShape;
    Label12: TLabel;
    Shape5: TShape;
    Label8: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Shape6: TShape;
    LFilial: TLabel;
    Label13: TLabel;
    Label30: TLabel;
    Label11: TLabel;
    Label21: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape15: TShape;
    Label7: TLabel;
    Shape7: TShape;
    Label25: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    Label14: TLabel;
    Shape17: TShape;
    Label26: TLabel;
    LNatureza: TLabel;
    Shape20: TShape;
    SpeedButton4: TSpeedButton;
    Label32: TLabel;
    SpeedButton5: TSpeedButton;
    Label33: TLabel;
    Shape21: TShape;
    ENumNota: TEditColor;
    ESerieNota: TEditColor;
    EObservacoes: TMemoColor;
    ECodFornecedor: TEditLocaliza;
    ENatureza: TEditLocaliza;
    ECodTransportadora: TRBEditLocaliza;
    CFreteEmitente: TRadioButton;
    des: TRadioButton;
    AutoCalculo: TCheckBox;
    EFormaPagamento: TEditLocaliza;
    EPlano: TEditColor;
    ECor: TEditLocaliza;
    EDatEntrada: TMaskEditColor;
    Panel1: TPanelColor;
    BCancela: TBitBtn;
    BFechar: TBitBtn;
    Grade: TRBStringGridColor;
    EValTotalProdutos: Tnumerico;
    EBaseICMS: Tnumerico;
    EValICMS: Tnumerico;
    EValFrete: Tnumerico;
    EValSeguro: Tnumerico;
    EValOutrasDespesas: Tnumerico;
    EValTotIpi: Tnumerico;
    EValTotal: Tnumerico;
    ValidaUnidade: TValidaUnidade;
    BCadastrar: TBitBtn;
    BGravar: TBitBtn;
    Label4: TLabel;
    Shape14: TShape;
    EDatRecebimento: TMaskEditColor;
    BEtiqueta: TBitBtn;
    PEtiqueta: TPanelColor;
    PanelColor3: TPanelColor;
    Label10: TLabel;
    BOK: TBitBtn;
    BCancelar: TBitBtn;
    Label27: TLabel;
    EPosInicial: Tnumerico;
    EBaseIcmsSubs: Tnumerico;
    EValICMSSubs: Tnumerico;
    PDevolucao: TPanelColor;
    Shape16: TShape;
    Label28: TLabel;
    SpeedButton6: TSpeedButton;
    Label29: TLabel;
    EVendedor: TRBEditLocaliza;
    Label34: TLabel;
    EPerComissao: Tnumerico;
    Label35: TLabel;
    BImprimir: TBitBtn;
    Label36: TLabel;
    ETamanho: TRBEditLocaliza;
    ETipoDocumentoFiscal: TRBEditLocaliza;
    Shape22: TShape;
    SpeedButton7: TSpeedButton;
    Label37: TLabel;
    Label23: TLabel;
    SpeedButton8: TSpeedButton;
    Label38: TLabel;
    ECondicaoPagamento: TRBEditLocaliza;
    Shape23: TShape;
    PDesconto: TPanelColor;
    Shape19: TShape;
    Label31: TLabel;
    EDesconto: Tnumerico;
    Shape18: TShape;
    CValorPercentual: TRadioGroup;
    Shape24: TShape;
    Label39: TLabel;
    EPerICMSSuperSimples: Tnumerico;
    Label40: TLabel;
    EValICMSSuperSimples: Tnumerico;
    Label41: TLabel;
    PanelColor2: TPanelColor;
    Paginas: TPageControl;
    PGEral: TTabSheet;
    PEstagio: TTabSheet;
    PanelColor4: TPanelColor;
    GridIndice1: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    DBMemoColor2: TDBMemoColor;
    Estagios: TRBSQL;
    EstagiosCODESTAGIO: TFMTBCDField;
    EstagiosDATESTAGIO: TSQLTimeStampField;
    EstagiosDESMOTIVO: TWideStringField;
    EstagiosDESLOG: TWideStringField;
    EstagiosNOMEST: TWideStringField;
    EstagiosC_NOM_USU: TWideStringField;
    DataEstagios: TDataSource;
    Shape25: TShape;
    Label42: TLabel;
    Shape26: TShape;
    Label43: TLabel;
    GradeServicos: TRBStringGridColor;
    Shape27: TShape;
    Shape28: TShape;
    Label44: TLabel;
    EValTotalServicos: Tnumerico;
    CSimplesNacional: TCheckBox;
    BConhecimento: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EValFreteExit(Sender: TObject);
    procedure ECodFornecedorRetorno(Retorno1, Retorno2: String);
    procedure CFreteEmitenteClick(Sender: TObject);
    procedure BCancelaClick(Sender: TObject);
    procedure AutoCalculoClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure ECodFornecedorCadastrar(Sender: TObject);
    procedure ECodTransportadoraCadastrar(Sender: TObject);
    procedure ENumNotaChange(Sender: TObject);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
    procedure ENaturezaCadastrar(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENaturezaRetorno(Retorno1, Retorno2: String);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure ECorEnter(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure EDatEntradaExit(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure GradeEnter(Sender: TObject);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure BCadastrarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeGetCellAlignment(sender: TObject; ARow, ACol: Integer;
      var HorAlignment: TAlignment; var VerAlignment: TVerticalAlignment);
    procedure BCancelarClick(Sender: TObject);
    procedure BEtiquetaClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure ECodFornecedorSelect(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GradeGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure GradeContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ECodFornecedorAlterar(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure PanelColor2Click(Sender: TObject);
    procedure GradeServicosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeServicosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GradeServicosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GradeServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeServicosKeyPress(Sender: TObject; var Key: Char);
    procedure GradeServicosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeServicosNovaLinha(Sender: TObject);
    procedure GradeServicosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeServicosEnter(Sender: TObject);
    procedure Shape5ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ECodTransportadoraRetorno(VpaColunas: TRBColunasLocaliza);
    procedure BConhecimentoClick(Sender: TObject);
  private
    FunNotaFor : TFuncoesNFFor;
    FunContasPagar : TFuncoesContasAPagar;
    VprOperacao : TRBDOperacaoCadastro;
    VprProdutoAnterior : String;
    VprNotaPedido,
    VprAcao: Boolean;
    VprIndTroca : Boolean;
    VprListaPedidos : TList;
    VprDNotaFor : TRBDNotaFiscalFor;
    VprDItemNota : TRBDNotaFiscalForItem;
    VprDItemServico: TRBDNotaFiscalForServico;
    VprDCliente : TRBDCliente;
    VprDCotacao : TRBDOrcamento;
    VprTransacao : TTransactionDesc;
    VprServicoAnterior : String;
    FunPedidoCompra: TRBFunPedidoCompra;
    procedure ConfiguraPermissaoUsuario;
    procedure CarTitulosGrade;
    procedure InicializaTela;
    procedure InicializaTelaTroca;
    procedure CalculaValorTotalProduto;
    procedure CalculaValorTotalServico;
    procedure CalculaNota;
    procedure CarDTela;
    procedure CarDClasse;
    procedure CarDesconto;
    procedure CarDescontoTela;
    procedure CarDItem;
    procedure CarDItemServico;
    procedure CarregaDadosCliente;
    function LocalizaProduto : Boolean;
    procedure CarregaDesNatureza;
    function ExisteProduto : Boolean;
    function ExisteCor(VpaCodCor :Integer ) : Boolean;
    function ExisteUM : Boolean;
    procedure AlteraEnabledBotao(VpaAcao : Boolean);
    function DadosNotaFiscalValidos : Boolean;
    procedure ImpressaoEtiquetaBarras;
    procedure AlteraProduto;
    procedure CarDChapaClasse;
    procedure CalculaKilosChapa;
    function DadosNFEValidos : string;
    function DadosItensSpedValidos : String;
    function DadosServicosSpedValidos : String;
    function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
    function RColunaGradeServicos(VpaColuna : TRBDColunaGradeServicos):Integer;
    procedure PosEstagios;
    function ExisteServico : Boolean;
    function LocalizaServico : Boolean;
    procedure InicializaDadosProdutoSpedFiscal;
    procedure AssociaNaturezaItens;
    procedure CarICMSPadrao;
  public
    function Cadastrar : Boolean;
    function NovaNotaPedido(VpaDNota: TRBDNotaFiscalFor;VpaListaPedidos : TList): Boolean;
    function Alterar(VpaDNota : TRBDNotaFiscalFor):Boolean;
    function GeraTroca(VpaDCliente : TRBDCliente;VpaDCotacao :TRBDOrcamento):Boolean;
    procedure ConsultaNota(VpaCodFilial, VpaSeqNota : Integer);
    function GeraNotaDevolucao(VpaNotas : TList):string;
  end;

var
  FNovaNotaFiscaisFor: TFNovaNotaFiscaisFor;

implementation

uses APrincipal, fundata, funstring, ANovoCliente,FunObjeto,
     AOperacoesEstoques, funsql, FunNumeros,
   ANovaNatureza, APlanoConta, ACores,
  ANaturezas, ALocalizaProdutos, UnClientes, AFormasPagamento,
  ANovoProdutoPro, dmRave, AMostraEstoqueChapas, alocalizaservico, UnNotaFiscal,
  AConhecimentoTransporteEntrada;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaNotaFiscaisFor.FormCreate(Sender: TObject);
begin
  PDevolucao.Visible := false;
  Paginas.ActivePage := PGEral;
  VprNotaPedido:= False;
  VprIndTroca := false;
  VprListaPedidos := nil;
  LFilial.Caption := 'Filial : '+IntToStr(varia.CodigoEmpFil)+'-'+Varia.NomeFilial;
  VprDNotaFor := TRBDNotaFiscalFor.Cria;
  FunNotaFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  ConfiguraPermissaoUsuario;
  CarTitulosGrade;
  Grade.ADados := VprDNotaFor.ItensNota;
  GradeServicos.ADados:= VprDNotaFor.ItensServicos;
  FunContasPagar := TFuncoesContasAPagar.criar(self,FPrincipal.BaseDados);
  FunPedidoCompra:= TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.AInfo.UnidadeUN := Varia.UnidadeUN;
  ValidaUnidade.AInfo.UnidadeKiT := Varia.UnidadeKit;
  ValidaUnidade.AInfo.UnidadeBarra := Varia.UnidadeBarra;
end;

{*********************Quando o formulario e fechado****************************}
procedure TFNovaNotaFiscaisFor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunNotaFor.free;
  FunContasPagar.Free;
  FunPedidoCompra.Free;
  if not VprNotaPedido then
    VprDNotaFor.Free;
  VprDCliente.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           cabecalho da nota fiscal for
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFNovaNotaFiscaisFor.Cadastrar : Boolean;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.NovaNotaPedido(VpaDNota: TRBDNotaFiscalFor;VpaListaPedidos : TList): Boolean;
begin
  VprNotaPedido:= True;
  VprOperacao := ocInsercao;
  VprListaPedidos := VpaListaPedidos;
  InicializaTela;
  VprDNotaFor:= VpaDNota;
  if Varia.CodFormaPagamentoNotaEntrada <> 0 then
    VpaDNota.CodFormaPagamento := Varia.CodFormaPagamentoNotaEntrada;
  VprDNotaFor.DatEmissao:= DecDia(Now,1);
  VprDNotaFor.DatRecebimento:= Now;
  VprDNotaFor.IndOrigemPedidoCompra := true;
  VprOperacao := ocConsulta;
  CarDTela;
  Grade.ADados:= VpaDNota.ItensNota;
  Grade.CarregaGrade;
  VprOperacao := ocEdicao;
  //forcado passar na rotina de retorno cliente;
  VpaDNota.CodFornecedor := 0;
  ECodFornecedor.Atualiza;
  CalculaNota;
  AlteraEnabledBotao(true);
  ValidaGravacao1.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PEstagio then
    PosEstagios;
end;

procedure TFNovaNotaFiscaisFor.PanelColor2Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.PosEstagios;
begin
  AdicionaSQLAbreTabela(Estagios,'select PRO.CODESTAGIO,PRO.DATESTAGIO, PRO.DESMOTIVO, PRO.DESLOG, '+
                                 ' EST.NOMEST, '+
                                 ' USU.C_NOM_USU '+
                                 ' from ESTAGIONOTAFISCALENTRADA PRO, ESTAGIOPRODUCAO EST, CADUSUARIOS USU '+
                                 ' Where PRO.CODESTAGIO = EST.CODEST '+
                                 ' AND PRO.CODUSUARIO = USU.I_COD_USU '+
                                 ' AND PRO.CODFILIAL = '+ IntToStr(VprDNotaFor.CodFilial)+
                                 ' AND PRO.SEQNOTAFISCAL = '+ IntToStr(VprDNotaFor.SeqNota)+
                                 ' ORDER BY PRO.SEQESTAGIO' )
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.RColunaGrade(VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clCodProduto: result:=1;
    clNomProduto: result:=2;
    clCodCor: result:=3;
    clNomCor: result:=4;
    clCodTamanho: result:=5;
    clNomTamanho: result:=6;
    clCFOP: result:=7;
    clClassificacaoFiscal: result:=8;
    clCST: result:=9;
    clQtdChapas: result:=10;
    clLargura: result:=11;
    clComprimento: result:=12;
    clUm: result:=13;
    clQtdPro: result:=14;
    ClValUnitarioPro: result:=15;
    clValTotalPro: result:=16;
    clPerIcms: result:=17;
    clPerIpi: result:=18;
    clBaseIcms: result:=19;
    clValIcms: result:=20;
    clPerMva: result:=21;
    clPerMvaAjustado: result:=22;
    clBaseSt: result:=23;
    clValST: result:=24;
    clPerAcumulado: result:=25;
    clValorVenda: result:=26;
    clNumSerie: result:=27;
    clNumLote: result:=28;
    clRefFornecedor: result:=29;
    clPerReducaoICMS : result := 30;
    clEtiquetas: result:=31;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.RColunaGradeServicos(
  VpaColuna: TRBDColunaGradeServicos): Integer;
begin
  case VpaColuna of
    clCodServico: result:=1;
    clDescServico: result:=2 ;
    clDescAdicional: result:=3;
    clQtd: result:=4;
    clValUnitario: result:=5;
    clValTotal: result:=6;
    clserCodCFOP: result:=7;
  end;
end;

procedure TFNovaNotaFiscaisFor.Shape5ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.Alterar(VpaDNota : TRBDNotaFiscalFor):Boolean;
begin
  BConhecimento.Enabled:= true;
  VprDNotaFor := VpaDNota;
  if  FunContasPagar.NotaPossuiParcelaPaga(VpaDNota.CodFilial, VpaDNota.SeqNota) then
  begin
    aviso('NOTA POSSUI PARCELA NO CONTAS A PAGAR PAGA!!!'#13'Antes de alterar a nota é necessário extonar as parcelas pagas.');
    result := false;
    close;
    exit;
  end;
  Grade.ADados := VpaDNota.ItensNota;
  Grade.CarregaGrade;
  GradeServicos.ADados:= VpaDNota.ItensServicos;
  GradeServicos.CarregaGrade;
  VprOperacao := ocConsulta;
  CarDTela;
  CarregaDesNatureza;
  VprOperacao := ocEdicao;
  AlteraEnabledBotao(true);
  ValidaGravacao1.execute;
  ShowModal;
  result := vprAcao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.AssociaNaturezaItens;
var
  VpfLaco : Integer;
  VpfCFOPProduto : Integer;
  VpfDProNota : TRBDNotaFiscalForItem;
  VpfDProduto : TRBDProduto;
begin
  VpfCFOPProduto := 0;
  if VprDNotaFor.DNaturezaOperacao.CFOPProdutoIndustrializacao <> 0 then
    VpfCFOPProduto := VprDNotaFor.DNaturezaOperacao.CFOPProdutoIndustrializacao
  else
    if length(VprDNotaFor.CodNatureza) = 4 then
      VpfCFOPProduto := StrToInt(VprDNotaFor.CodNatureza);
  if VpfCFOPProduto <> 0 then
  begin
    for VpfLaco := 0 to VprDNotaFor.ItensNota.Count - 1 do
    begin
      VpfDProNota := TRBDNotaFiscalForItem(VprDNotaFor.ItensNota.Items[VpfLaco]);
      VpfDProNota.CodCFOP := VpfCFOPProduto;
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,VprDNotaFor.CodFilial,VpfDProNota.SeqProduto);
      VpfDProNota.CodCST := FunNotaFor.RCSTICMSProduto(VprDCliente,VprDNotaFor.DNaturezaOperacao,VpfDProNota);
      VpfDProNota.PerICMS := VprDNotaFor.PerICMSPadrao;
      FunNotaFor.CarMVAAjustado(VprDNotaFor,VpfDProNota,VprDCliente);
      VpfDProduto.Free;
    end;
    Grade.CarregaGrade;
    CalculaNota;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.GeraTroca(VpaDCliente : TRBDCliente;VpaDCotacao :TRBDOrcamento ):Boolean;
begin
  VprIndTroca := true;
  VprDCotacao := VpaDCotacao;
  VprOperacao := ocInsercao;
  InicializaTela;
  IF not VpaDCliente.IndFornecedor then
    FunClientes.SetaClienteComoFornecedor(VpaDCliente.CodCliente);
  ECodFornecedor.AInteiro := VpaDCliente.CodCliente;
  ECodFornecedor.Atualiza;
  InicializaTelaTroca;
  ActiveControl := Grade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ConsultaNota(VpaCodFilial, VpaSeqNota : Integer);
begin
  BConhecimento.Enabled:= true;
  VprDNotaFor.CodFilial := VpaCodFilial;
  VprDNotaFor.SeqNota := VpaSeqNota;
  FunNotaFor.CarDNotaFor(VprDNotaFor);
  Grade.ADados := VprDNotaFor.ItensNota;
  Grade.CarregaGrade;
  GradeServicos.ADados:= VprDNotaFor.ItensServicos;
  GradeServicos.CarregaGrade;
  VprOperacao := ocConsulta;
  CarDTela;
  CarregaDesNatureza;
  AlteraEnabledBotao(false);
  AlterarEnabledDet(PanelColor1,0,false);
  AlterarEnabledDet(PEtiqueta,0,true);
  Grade.Enabled := true;
  ShowModal;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.GeraNotaDevolucao(VpaNotas : TList):string;
begin
  VprOperacao := ocInsercao;
  PDevolucao.Visible := true;
  InicializaTela;
  VprDNotaFor.IndNotaDevolucao := true;
  result := FunNotaFor.GeraNotaDevolucao(VpaNotas,VprDNotaFor);
  CarDTela;
  VprDNotaFor.CodFornecedor := 0;
  ECodFornecedor.Atualiza;
  CalculaNota;
  showmodal;
end;

{************* cadastra nova natureza de operacao *************************** }
procedure TFNovaNotaFiscaisFor.ENaturezaCadastrar(Sender: TObject);
begin
  FNaturezas := TFNaturezas.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNaturezas'));
  FNaturezas.ShowModal;
  FNaturezas.free;
  Localiza.AtualizaConsulta;
end;

{************************Cadastra um novo cliente******************************}
procedure TFNovaNotaFiscaisFor.ECodFornecedorAlterar(Sender: TObject);
begin
  if ECodFornecedor.ALocaliza.Loca.Tabela.FieldByName(ECodFornecedor.AInfo.CampoCodigo).AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+ECodFornecedor.ALocaliza.Loca.Tabela.FieldByName(ECodFornecedor.AInfo.CampoCodigo).asString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    Localiza.AtualizaConsulta;
    FNovoCliente.free;
    VprDNotaFor.CodFornecedor := -1;
  end;
end;

{************************Cadastra um novo cliente******************************}
procedure TFNovaNotaFiscaisFor.ECodFornecedorCadastrar(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
   FNovoCliente.CadClientes.Insert;
   FNovoCliente.CadClientesC_TIP_CAD.AsString := 'F';
   FNovoCliente.ShowModal;
   Localiza.AtualizaConsulta;
end;

{****************Retorna se o fornecedor é fisico ou jurídico******************}
procedure TFNovaNotaFiscaisFor.ECodFornecedorRetorno(Retorno1,
  Retorno2: String);
begin
  CarregaDadosCliente;
end;

{***************************Valida a gravacao**********************************}
procedure TFNovaNotaFiscaisFor.ENumNotaChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{**********************Cadastra uma nova operação de Estoque*******************}
procedure TFNovaNotaFiscaisFor.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.click;
  FFormasPagamento.showmodal;
  FFormasPagamento.free;
  Localiza.AtualizaConsulta;
end;


{***************************localiza codigo de produto*************************}
function TFNovaNotaFiscaisFor.LocalizaProduto : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDItemNota); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    if config.Farmacia then
      result := FunNotaFor.ValidaMedicamentoControlado(VprDNotaFor,VprDItemNota);
    if result then
    begin
      with VprDItemNota do
      begin
        VprDItemNota.UnidadeParentes.free;
        VprDItemNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(UMOriginal);
        VprProdutoAnterior := VprDItemNota.CodProduto;
        VprDItemNota.CodCST := FunNotaFor.RCSTICMSProduto(VprDCliente,VprDNotaFor.DNaturezaOperacao,VprDItemNota);
        FunNotaFor.CarMVAAjustado(VprDNotaFor,VprDItemNota,VprDCliente);
        QtdProduto := 1;
        Grade.Cells[RColunaGrade(clCodProduto),Grade.ALinha] := CodProduto;
        Grade.Cells[RColunaGrade(clNomProduto),Grade.ALinha] := NomProduto;
        Grade.Cells[RColunaGrade(clClassificacaoFiscal),Grade.ALinha] := CodClassificacaoFiscal;
        Grade.Cells[RColunaGrade(clUm),Grade.ALinha] := UM;
        Grade.Cells[RColunaGrade(clPerMva),Grade.ALinha] := FormatFloat('#,##0.00',VprDItemNota.PerMVA);
        Grade.Cells[RColunaGrade(clPerMvaAjustado),Grade.ALinha] := FormatFloat('#,##0.00',VprDItemNota.PerMVAAjustado);
        Grade.Cells[RColunaGrade(clCST),Grade.ALinha] := VprDItemNota.CodCST;
        if VprIndTroca then
          VprDItemNota.ValUnitario := VprDItemNota.ValRevenda;
        if config.EstoquePorTamanho then
        begin
          ETamanho.AInteiro := CodTamanho;
          ETamanho.Atualiza;
        end;

        CalculaValorTotalProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.LocalizaServico: Boolean;
begin
  FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
  result := FlocalizaServico.LocalizaServico(VprDItemServico);
  FlocalizaServico.free; // destroi a classe;

  if result then  // se o usuario nao cancelou a consulta
  begin
    VprDItemServico.QtdServico := 1;
    GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] := IntToStr(VprDItemServico.CodServico);
    GradeServicos.Cells[RColunaGradeServicos(clDescServico),GradeServicos.ALinha] := VprDItemServico.NomServico;
    GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] :=  FormatFloat(varia.mascaraQtd,VprDItemServico.QtdServico);
    GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDItemServico.ValUnitario);
    {if VprDNota.IndCalculaIS then
    begin
      if VprDServicoNota.PerISSQN <> 0 then
        EPerISSQN.AValor := VprDServicoNota.PerISSQN
      else
        EPerISSQN.AValor := VprPerISSQN;
    end;}
    CalculaValorTotalServico;
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarregaDesNatureza;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_MOV from MOVNATUREZA '+
                            ' Where C_COD_NAT = '''+ VprDNotaFor.CodNatureza+''''+
                            ' AND I_SEQ_MOV = '+IntToStr(VprDNotaFor.DNaturezaOperacao.SeqNatureza));
  LNatureza.Caption := Aux.FieldByName('C_NOM_MOV').AsString;
  Aux.Close;
end;

{******************** verifica se o produto existe ****************************}
function TFNovaNotaFiscaisFor.ExisteProduto : Boolean;
begin
  if (Grade.Cells[RColunaGrade(clCodProduto),Grade.ALinha] <> '') then
  begin
    if Grade.Cells[RColunaGrade(clCodProduto),Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunNotaFor.ExisteProduto(Grade.Cells[RColunaGrade(clCodProduto),Grade.ALinha],VprDNotaFor, VprDItemNota);
      if result then
      begin
        if config.Farmacia then
          result := FunNotaFor.ValidaMedicamentoControlado(VprDNotaFor,VprDItemNota);
        if result then
        begin
          VprDItemNota.UnidadeParentes.free;
          VprDItemNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDItemNota.UMOriginal);
          VprProdutoAnterior := VprDItemNota.CodProduto;
          VprDItemNota.CodCST := FunNotaFor.RCSTICMSProduto(VprDCliente,VprDNotaFor.DNaturezaOperacao,VprDItemNota);
          FunNotaFor.CarMVAAjustado(VprDNotaFor,VprDItemNota,VprDCliente);
          Grade.Cells[RColunaGrade(clCodProduto),Grade.ALinha] := VprDItemNota.CodProduto;
          Grade.Cells[RColunaGrade(clNomProduto),Grade.ALinha] := VprDItemNota.NomProduto;
          Grade.Cells[RColunaGrade(clClassificacaoFiscal),Grade.ALinha] := VprDItemNota.CodClassificacaoFiscal;
          Grade.Cells[RColunaGrade(clUm),Grade.ALinha] := VprDItemNota.UM;
          Grade.Cells[RColunaGrade(clPerMva),Grade.ALinha] := FormatFloat('#,##0.00',VprDItemNota.PerMVA);
          Grade.Cells[RColunaGrade(clPerMvaAjustado),Grade.ALinha] := FormatFloat('#,##0.00',VprDItemNota.PerMVAAjustado);
          Grade.Cells[RColunaGrade(clCST),Grade.ALinha] := VprDItemNota.CodCST;
          if VprIndTroca then
            VprDItemNota.ValUnitario := VprDItemNota.ValRevenda;

          CalculaValorTotalProduto;
        end;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.ExisteServico: Boolean;
begin
  if (GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] <> '') then
  begin
    if (GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] = VprServicoAnterior)  then
      result := true
    else
    begin
      result := FunNotaFor.ExisteServico(GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha],VprDNotaFor,VprDItemServico);
      if result then
      begin
        VprServicoAnterior := GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha];
        GradeServicos.Cells[RColunaGradeServicos(clDescServico),GradeServicos.Alinha] := VprDItemServico.NomServico;
        GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] :=  FormatFloat(varia.MascaraQtd,VprDItemServico.QtdServico);
        GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDItemServico.ValUnitario);
        //if VprDNotaFor.IndCalculaISS then
        //begin
        //  if VprDServicoNota.PerISSQN <> 0 then
        //    EPerISSQN.AValor := VprDServicoNota.PerISSQN
        //  else
        //    EPerISSQN.AValor := VprPerISSQN;
        //end;
        CalculaValorTotalServico;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.ExisteCor(VpaCodCor :Integer ) : Boolean;
begin
  Result:= not Config.EstoquePorCor;
  // o retorno padrão da função funciona de acordo com a configuração do estoque.
  // se configurado para utilizar a cor no estoque, ela retorna false,
  // deixando a cor como obrigatória. caso contrario, se não utilizar a cor,
  // ele retorna true, dizendo que uma cor "existe"
  if VpaCodCor <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              ' Where COD_COR = '+IntToStr(VpacodCor));
    result := not Aux.eof;
    if result then
    begin
      Grade.Cells[RColunaGrade(clNomCor),Grade.ALinha] := Aux.FieldByName('NOM_COR').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.ExisteUM : Boolean;
begin
  if (VprDItemNota.UMAnterior = Grade.cells[RColunaGrade(clUm),Grade.ALinha]) then
    result := true
  else
  begin
    result := (VprDItemNota.UnidadeParentes.IndexOf(Grade.Cells[RColunaGrade(clum),Grade.Alinha]) >= 0);
    if result then
    begin
      VprDItemNota.UM := Grade.Cells[RColunaGrade(clUm),Grade.Alinha];
      VprDItemNota.UMAnterior := VprDItemNota.UM;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.AlteraEnabledBotao(VpaAcao : Boolean);
begin
  BCancela.Enabled := VpaAcao;
  BCadastrar.Enabled := not VpaAcao;
  BFechar.Enabled := not VpaAcao;
  BGravar.Enabled := false;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.DadosItensSpedValidos: String;
begin
  result := '';
  if config.EmiteSped then
  begin
    if VprDItemNota.CodCFOP = 0 then
    begin
      result := 'CFOP NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo CFOP.';
      Grade.col := RColunaGrade(clCFOP);
    end
    else
      if VprDItemNota.CodCST = '' then
      begin
        result := 'CST NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo CST(Codigo Situação Tributaria)';
        Grade.col := RColunaGrade(clCST);;
      end
      else
        if length(VprDItemNota.CodCST) <> 3 then
        begin
          result := 'PREENCHIMENTO DO CST INVÁLIDO!!!'#13'O codigo CST tem que possuir 3 caracteres e foram digitados somente '+IntTostr(length(VprDItemNota.CodCST))+' caracteres';
          Grade.col := RColunaGrade(clCST);;
        end;

    if result = '' then
    begin
      if (COPY(IntTostr(VprDItemNota.CodCFOP),1,1) <> '1') and
         (COPY(IntTostr(VprDItemNota.CodCFOP),1,1) <> '2') and
         (COPY(IntTostr(VprDItemNota.CodCFOP),1,1) <> '3') then
      begin
        result := 'PREENCHIMENTO DO CFOP INVÁLIDO!!!'#13'O codigo do CFOP para entrada de mercadorias tem que começar com "1","2" ou "3"';
        grade.Col := RColunaGrade(clCFOP);;
      end;
    end;

    if result = '' then
    begin
      if (copy(VprDItemNota.CodCST,2,2) = '00') or
         (copy(VprDItemNota.CodCST,2,2) = '20') then
      begin
        if VprDItemNota.PerICMS = 0 then
        begin
          result := 'ICMS NÃO PREENCHIDO!!!'#13'É necessário preencher o percentual do ICMS quando o CST terminar com [00,20]';
          Grade.col := RColunaGrade(clPerIcms);;
        end;
      end;
      if (copy(VprDItemNota.CodCST,2,2) = '20') then
      begin
        if VprDItemNota.PerReducaoBaseICMS = 0 then
        begin
          result := '% REDUÇÃO ICMS NÃO PREENCHIDO!!!'#13'É necessário preencher o percentual do redução do ICMS quando o CST terminar com [20]';
          Grade.col := RColunaGrade(clPerReducaoICMS);;
        end;
      end;

    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.DadosNFEValidos: string;
var
  VpfLaco : Integer;
begin
  result :='';
  if (config.EmiteNFe) or (config.EmiteSped)  then
  begin
    result := FunClientes.DadosSpedClienteValido(VprDCliente);
    if result = '' then
    begin
      for vpflaco := 0 to VprDNotaFor.ItensNota.Count - 1 do
      begin
        VprDItemNota := TRBDNotaFiscalForItem(VprDNotaFor.ItensNota.Items[VpfLaco]);
        if DeletaChars(VprDItemNota.CodClassificacaoFiscal,' ') = '' then
        begin
          result := 'CODIGO NCM/CLASSIFICAÇÃO FISCAL NÃO PREENHCIDO!!!'#13'O produto "'+VprDItemNota.CodProduto+'" não possui o código NCM cadastrado';
          break;
        end
        else
          if VprDItemNota.CodClassificacaoFiscal <> ''  then
          begin
            if length(DeletaChars(VprDItemNota.CodClassificacaoFiscal,' ')) < 8 then
            begin
              result := 'CODIGO NCM/CLASSIFICAÇÃO FISCAL INVÁLIDO!!!'#13'O produto "'+VprDItemNota.CodProduto+'" possui o código NCM cadastrado errado "'+VprDItemNota.CodClassificacaoFiscal+'"';
              break;
            end;
          end;
        if result = '' then
        begin
          result := DadosItensSpedValidos;
          if result <> '' then
          begin
            result := 'PRODUTO '''+VprDItemNota.CodProduto+'-'+VprDItemNota.NomProduto+''''+#13+result;
            break;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.DadosNotaFiscalValidos : Boolean;
begin
  result := true;
  if ENumNota.AInteiro = 0 then
  begin
    result := false;
    aviso('NUMERO DA NOTA INVÁLIDO!!!'#13'É necessário digitar um número para a nota fiscal.');
    ActiveControl := ENumNota;
  end
  else
    if ESerieNota.Text = '' then
    begin
      result := false;
      aviso('SÉRIE DA NOTA INVÁLIDA!!!'#13'É necessário digitar a série da nota fiscal.');
      ActiveControl := ESerieNota;
    end
    else
      if ENatureza.Text = '' then
      begin
        result := false;
        aviso('NATUREZA OPERAÇÃO INVÁLIDA!!!'#13'É necessário digitar a natureza de operação da nota fiscal.');
        ActiveControl := ENatureza;
      end
      else
        if ECodFornecedor.AInteiro = 0 then
        begin
          result := false;
          aviso('FORNECEDOR INVÁLID0!!!'#13'É necessário digitar o fornecedor da nota fiscal.');
          ActiveControl := ECodFornecedor;
        end
        else
        if VprDNotaFor.DNaturezaOperacao.IndFinanceiro then
        begin
          if EPlano.Text = '' then
          begin
            result := false;
            aviso('PLANO DE CONTAS INVÁLIDO!!!'#13'É necessário digitar o plano de contas da nota fiscal.');
            ActiveControl := EPlano;
          end
          else
            if EFormaPagamento.AInteiro = 0 then
            begin
              result := false;
              aviso('FORMA DE PAGAMENTO INVÁLIDA!!!'#13'É necessário digitar a forma de pagamento da nota fiscal.');
              ActiveControl := EFormaPagamento;
            end
            else
              if ECondicaoPagamento.AInteiro = 0 then
              begin
                result := false;
                aviso('CONDIÇÃO DE PAGAMENTO INVÁLIDA!!!'#13'É necessário informar a condição de pagamento');
                ActiveControl := ECondicaoPagamento;
              end;
        end;

  if not varia.AceitaNotadeEntradaSemProduto then
  begin
    if result then
    begin
      if VprDNotaFor.ItensNota.Count = 0 then
      begin
        result := false;
        aviso('NOTA FISCAL SEM PRODUTOS!!!'#13'É necessário digitar os produtos da nota fiscal.');
        ActiveControl := Grade;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.DadosServicosSpedValidos: String;
begin
  result := '';
  if config.EmiteSped then
  begin
    if VprDItemServico.CodCFOP = 0 then
    begin
      result := 'CFOP NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo CFOP.';
      GradeServicos.col := RColunaGradeServicos(clserCodCFOP);
    end
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ImpressaoEtiquetaBarras;
begin
  case varia.ModeloEtiquetaNotaEntrada of
    0 : begin // etiqueta 10 X 3 - A4(25mm x 67mm)
          FunNotaFor.PreparaEtiqueta(VprDNotaFor,EPosInicial.AsInteger);
          dtRave := TdtRave.create(self);
          dtRave.ImprimeEtiquetaProduto10X3A4;
          dtRave.free;
        end;
    2,3,4 :  FunNotaFor.ImprimeEtiquetaNota(VprDNotaFor);
    5 : begin
          FunNotaFor.PreparaEtiqueta(VprDNotaFor,EPosInicial.AsInteger);
          dtRave := TdtRave.create(self);
          dtRave.ImprimeEtiquetaProduto20X4A4;
          dtRave.free;
        end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.AlteraProduto;
begin
  if ExisteProduto then
  begin
    FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
    if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprDItemNota.SeqProduto) <> nil then
    begin
      VprProdutoAnterior := '-1';
      ExisteProduto;
    end;
    FNovoProdutoPro.free;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            calculos da nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    Grade.ColWidths[3] := -1;
    Grade.ColWidths[4] := -1;
    Grade.TabStops[3] := false;
    Grade.TabStops[4] := false;
    Grade.ColWidths[2] := RetornaInteiro(Grade.ColWidths[2] *1.9);
  end;
  if not config.EstoquePorTamanho then
  begin
    Grade.ColWidths[5] := -1;
    Grade.ColWidths[6] := -1;
    Grade.TabStops[5] := false;
    Grade.TabStops[6] := false;
  end;
  if not config.ControlarEstoquedeChapas then
  begin
    Grade.ColWidths[10] := -1;
    Grade.ColWidths[11] := -1;
    Grade.ColWidths[12] := -1;
    Grade.TabStops[10] := false;
    Grade.TabStops[11] := false;
    Grade.TabStops[12] := false;
  end;
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    PDesconto.Visible := (puESPermiteAcrescimoDescontoNotaEntrada in varia.PermissoesUsuario);
  end;
  Grade.ColWidths[RColunaGrade(clNomProduto)] := varia.LarguraColunaProdutoConsulta;
  Grade.ColWidths[RColunaGrade(clNomCor)] := varia.LarguraColunaCorConsulta;


end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarTitulosGrade;
begin
  grade.Cells[RColunaGrade(clCodProduto),0] := 'Código';
  grade.Cells[RColunaGrade(clNomProduto),0] := 'Produto';
  grade.Cells[RColunaGrade(clCodCor),0] := 'Cor';
  grade.Cells[RColunaGrade(clNomCor),0] := 'Descrição';
  grade.Cells[RColunaGrade(clCodTamanho),0] := 'Tamanho';
  grade.Cells[RColunaGrade(clNomTamanho),0] := 'Descrição';
  grade.Cells[RColunaGrade(clCFOP),0] := 'CFOP';
  grade.Cells[RColunaGrade(clClassificacaoFiscal),0] := 'Cl Fisc.';
  if VprDCliente.IndSimplesNacional then
    grade.Cells[RColunaGrade(clCST),0] := 'CSOSN'
  else
    grade.Cells[RColunaGrade(clCST),0] := 'CST';
  grade.Cells[RColunaGrade(clQtdChapas),0] := 'Qtd Chapas';
  grade.Cells[RColunaGrade(clLargura),0] := 'Largura';
  grade.Cells[RColunaGrade(clComprimento),0] := 'Comprimento';
  grade.Cells[RColunaGrade(clUm),0] := 'UM';
  grade.Cells[RColunaGrade(clQtdPro),0] := 'Qtd';
  grade.Cells[RColunaGrade(ClValUnitarioPro),0] := 'Valor Unitário';
  grade.Cells[RColunaGrade(clValTotalPro),0] := 'Valor Total';
  grade.Cells[RColunaGrade(clPerIcms),0] := '%ICMS';
  grade.Cells[RColunaGrade(clPerIpi),0] := '%IPI';
  grade.Cells[RColunaGrade(clBaseIcms),0] := 'Base Icms';
  grade.Cells[RColunaGrade(clValIcms),0] := 'Valor Icms';
  grade.Cells[RColunaGrade(clPerMva),0] := '%MVA';
  grade.Cells[RColunaGrade(clPerMvaAjustado),0] := '%MVA Ajustado';
  grade.Cells[RColunaGrade(clBaseSt),0] := 'Base ST';
  grade.Cells[RColunaGrade(clValST),0] := 'Valor ST';
  grade.Cells[RColunaGrade(clPerAcumulado),0] := '% Acr. ST';
  grade.Cells[RColunaGrade(clValorVenda),0] := 'Valor Venda';
  grade.Cells[RColunaGrade(clNumSerie),0] := 'Número Série';
  if config.Farmacia then
    grade.Cells[RColunaGrade(clNumLote),0] := 'Numero Lote';
  grade.Cells[RColunaGrade(clRefFornecedor),0] := 'Ref Fornecedor';
  grade.Cells[RColunaGrade(clPerReducaoICMS),0] := '% Red ICMS';
  grade.Cells[RColunaGrade(clEtiquetas),0] := 'Etiquetas';

  GradeServicos.Cells[RColunaGradeServicos(clCodServico),0] := 'Código';
  GradeServicos.Cells[RColunaGradeServicos(clDescServico),0] := 'Descrição';
  GradeServicos.Cells[RColunaGradeServicos(clDescAdicional),0] := 'Descrição Adicional';
  GradeServicos.Cells[RColunaGradeServicos(clQtd),0] := 'Qtd';
  GradeServicos.Cells[RColunaGradeServicos(clValUnitario),0] := 'Val Unitário';
  GradeServicos.Cells[RColunaGradeServicos(clValTotal),0] := 'Valor Total';
  GradeServicos.Cells[RColunaGradeServicos(clserCodCFOP),0] := 'CFOP';
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.InicializaDadosProdutoSpedFiscal;
begin
  if config.EmiteSped then
  begin
    if VprDNotaFor.DNaturezaOperacao.IndCalcularICMS then
      VprDItemNota.CodCST := '000'
    else
      VprDItemNota.CodCST := '090'
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.InicializaTela;
begin
  VprOperacao := ocInsercao;
  LimpaComponentes(ScrollBox1,0);
  VprDNotaFor.Free;
  VprDNotaFor := TRBDNotaFiscalFor.cria;
  VprDNotaFor.IndNotaDevolucao := false;
  VprDNotaFor.IndOrigemPedidoCompra := false;
  Grade.ADados := VprDNotaFor.ItensNota;
  Grade.CarregaGrade;
  Grade.col := 1;
  GradeServicos.ADados:= VprDNotaFor.ItensServicos;
  GradeServicos.CarregaGrade;
  GradeServicos.Col:= 1;
  LFilial.Caption := 'Filial : '+IntToStr(varia.CodigoEmpFil)+'-'+Varia.NomeFilial;
  EDatEntrada.Text := DataToStrFormato(DDMMAA,DecDia(Now,1),'/');
  EDatRecebimento.Text := DataToStrFormato(DDMMAA,Now,'/');
  CValorPercentual.ItemIndex := 0;
  CFreteEmitente.Checked := true;
  AutoCalculo.Checked := true;
  if Varia.CodFormaPagamentoNotaEntrada <> 0 then
  begin
    EFormaPagamento.AInteiro := Varia.CodFormaPagamentoNotaEntrada;
    EFormaPagamento.Atualiza;
    EFormaPagamento.Enabled := false;
  end;

  AlteraEnabledBotao(true);
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.InicializaTelaTroca;
begin
  ENumNota.AInteiro := 1;
  ESerieNota.AInteiro := 1;
  EFormaPagamento.AInteiro := varia.FormaPagamentoDinheiro;
  ENatureza.Text := varia.NaturezaOperacaoTroca;
  ENatureza.Atualiza;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CalculaValorTotalProduto;
begin
  if (VprDItemNota.ValUnitario = 0) and (VprDItemNota.ValTotal <> 0) then
    VprDItemNota.ValUnitario := VprDItemNota.ValTotal / VprDItemNota.QtdProduto
  else
//    if (VprDItemNota.ValUnitario <> 0) and (VprDItemNota.ValTotal = 0) then
    VprDItemNota.ValTotal := ArredondaDecimais((VprDItemNota.ValUnitario * VprDItemNota.QtdProduto),2);
  Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha] := FormatFloat(varia.MascaraQtd,VprDItemNota.QtdProduto);
  Grade.Cells[RColunaGrade(ClValUnitarioPro),Grade.ALinha] := FormatFloat('###,###,###,##0.0000',VprDItemNota.ValUnitario);
  Grade.Cells[RColunaGrade(clValTotalPro),Grade.ALinha] := FormatFloat(Varia.MascaraValor,VprDItemNota.ValTotal);
  Grade.Cells[RColunaGrade(clValorVenda),Grade.ALinha] := FormatFloat(Varia.MascaraValorUnitario,VprDItemNota.ValNovoVenda);
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CalculaValorTotalServico;
begin
  if (VprDItemServico.ValUnitario = 0) and (VprDItemServico.ValTotal <> 0) then
    VprDItemServico.ValUnitario := VprDItemServico.ValTotal / VprDItemServico.QtdServico
  else
    VprDItemServico.ValTotal := VprDItemServico.ValUnitario * VprDItemServico.QtdServico;
  GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] := FormatFloat(varia.MascaraQtd,VprDItemServico.QtdServico);
  GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] := FormatFloat('###,###,###,##0.0000',VprDItemServico.ValUnitario);
  GradeServicos.Cells[RColunaGradeServicos(clValTotal),GradeServicos.ALinha] := FormatFloat(Varia.MascaraValor,VprDItemServico.ValTotal);
end;

{**************************Calcula o valor da nota*****************************}
procedure TFNovaNotaFiscaisFor.CalculaKilosChapa;
begin
  if (Grade.Cells[RColunaGrade(clQtdChapas),Grade.ALinha] <> '') and
     (Grade.Cells[RColunaGrade(clLargura),Grade.ALinha] <> '') and
     (Grade.Cells[RColunaGrade(clComprimento),Grade.ALinha] <> '') then
  begin
    CarDChapaClasse;
    VprDItemNota.QtdProduto := FunProdutos.RQuilosChapa(VprDItemNota.EspessuraAco,VprDItemNota.LarChapa,VprDItemNota.ComChapa,
                                                          VprDItemNota.QtdChapa,VprDItemNota.DensidadeVolumetricaAco );
    if VprDItemNota.QtdProduto <> 0 then
      Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDItemNota.QtdProduto)
    else
      Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha]:= '';
  end;
end;

{**************************Calcula o valor da nota*****************************}
procedure TFNovaNotaFiscaisFor.CalculaNota;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    CarDClasse;
    FunNotaFor.CalculaNota(VprDNotaFor);
    EBaseICms.AValor := VprDNotaFor.ValBaseICMS;
    EValIcms.AValor := VprDNotaFor.ValICMS;
    EBaseIcmsSubs.AValor := VprDNotaFor.ValBaseICMSSubstituicao;
    EValICMSSubs.AValor := VprDNotaFor.ValICMSSubstituicao;
    EValTotalProdutos.AValor := VprDNotaFor.ValTotalProdutos;
    EValTotal.AValor := VprDNotaFor.ValTotal;
    EValTotIpi.AValor := VprDNotaFor.ValIPI;
    EValTotalServicos.AValor:= VprDNotaFor.ValTotalServicos;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDTela;
Var
  VpfCodPlanoContas : string;
begin
  VpfCodPlanoContas := VprDNotaFor.DNaturezaOperacao.CodPlanoContas;
  if VprDNotaFor.CodNatureza <> '' then
    FunNotaFiscal.CarDNaturezaOperacao(VprDNotaFor.DNaturezaOperacao,VprDNotaFor.CodNatureza,VprDNotaFor.DNaturezaOperacao.SeqNatureza);
  VprDNotaFor.DNaturezaOperacao.CodPlanoContas := VpfCodPlanoContas;
  with VprDNotaFor do
  begin
    ENumNota.AInteiro := NumNota;
    ESerieNota.Text := SerNota;
    ENatureza.Text := CodNatureza;

    EDatEntrada.Text := FormatDateTime('DD/MM/YY',DatEmissao);
    EDatRecebimento.Text := FormatDateTime('DD/MM/YY',DatRecebimento);
    ECodFornecedor.AInteiro := CodFornecedor;
    ETipoDocumentoFiscal.Text := CodModeloDocumento;
    ETipoDocumentoFiscal.Atualiza;
    EFormaPagamento.AInteiro := CodFormaPagamento;
    ECondicaoPagamento.Ainteiro := CodCondicaoPagamento;
    EValICMS.Avalor := ValICMS;
    EValICMSSubs.Avalor := ValICMSSubstituicao;
    EBaseIcmsSubs.Avalor := ValBaseICMSSubstituicao;
    EValTotal.Avalor := ValTotal;
    EValFrete.AValor := ValFrete;
    EValSeguro.AValor := ValSeguro;
    EValTotIpi.AValor := ValIPI;
    EValTotalProdutos.AValor := ValTotalProdutos;
    EValTotalServicos.AValor:= ValTotalServicos;
    EBaseICMS.AValor := ValBaseICMS;
    EValOutrasDespesas.AValor := ValOutrasDespesas;
    EValICMSSuperSimples.AValor := ValICMSSuperSimples;
    EPerICMSSuperSimples.AValor := PerICMSSuperSimples;
    CFreteEmitente.Checked := IndFreteEmitente;
    ECodTransportadora.AInteiro := CodTransportadora;
    EObservacoes.Lines.Text := DesObservacao;
    EVendedor.AInteiro := CodVendedor;
    EVendedor.Atualiza;
    EPerComissao.AValor := PerComissao;
  end;
  CarDescontoTela;
  AtualizaLocalizas([ENatureza,ECodFornecedor,EFormaPagamento,EPlano,ECodTransportadora, ECondicaoPagamento]);
  EPlano.text := VprDNotaFor.DNaturezaOperacao.CodPlanoContas;
  VprDNotaFor.CodFornecedor := 0;
  ECodFornecedor.Atualiza;
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarICMSPadrao;
begin
  if VprDCliente.CodCliente <> 0 then
  begin
    if (Config.SimplesFederal) or not(VprDNotaFor.DNaturezaOperacao.IndCalcularICMS) then
      VprDNotaFor.PerICMSPadrao := 0
    else
      VprDNotaFor.PerICMSPadrao := FunNotaFor.RValICMSFornecedor(VprDCliente.DesUF);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDChapaClasse;
begin
  if Grade.Cells[RColunaGrade(clQtdChapas),Grade.ALinha] <> '' then
    VprDItemNota.QtdChapa := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clQtdChapas),Grade.ALinha],'.'))
  else
    VprDItemNota.QtdChapa:= 0;
  if Grade.Cells[RColunaGrade(clLargura),Grade.ALinha] <> '' then
    VprDItemNota.LarChapa := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clLargura),Grade.ALinha],'.'))
  else
    VprDItemNota.LarChapa:= 0;
  if Grade.Cells[RColunaGrade(clComprimento),Grade.ALinha] <> '' then
    VprDItemNota.ComChapa := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clComprimento),Grade.ALinha],'.'))
  else
    VprDItemNota.ComChapa:= 0;
end;

{**************************Calcula o valor da nota*****************************}
procedure TFNovaNotaFiscaisFor.CarDClasse;
begin
  with VprDNotaFor do
  begin
    CodFilial := varia.CodigoEmpFil;
    NumNota := ENumNota.AInteiro;
    SerNota := ESerieNota.Text;
    CodNatureza := ENatureza.Text;
    DatEmissao := StrtoDate(EDatEntrada.text);
    DatRecebimento := StrtoDate(EDatRecebimento.text);
    CodFornecedor := ECodFornecedor.Ainteiro;
    CodFormaPagamento := EFormaPagamento.AInteiro;
    DNaturezaOperacao.CodPlanoContas := EPlano.Text;
    CodCondicaoPagamento := ECondicaoPagamento.AInteiro;
    CodModeloDocumento := ETipoDocumentoFiscal.Text;
    ValICMS := EValICMS.AValor;
    ValTotal := EValTotal.AValor;
    ValFrete := EValFrete.Avalor;
    ValSeguro := EValSeguro.Avalor;
    ValIPI := EValTotIpi.AValor;
    ValBaseICMSSubstituicao := EBaseIcmsSubs.AValor;
    ValICMSSubstituicao := EValICMSSubs.AValor;
    ValOutrasDespesas := EValOutrasDespesas.Avalor;
    ValICMSSuperSimples := EValICMSSuperSimples.AValor;
    PerICMSSuperSimples := EPerICMSSuperSimples.AValor;
    IndFreteEmitente := CFreteEmitente.Checked;
    CodTransportadora := ECodTransportadora.AInteiro;
    DesObservacao := EObservacoes.Lines.Text;
    PerComissao := EPerComissao.AValor;
    CodUsuario:= Varia.CodigoUsuario;
    CarDesconto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDesconto;
begin
  with VprDNotaFor do
  begin
    PerDesconto := 0;
    ValDesconto := 0;
    if CValorPercentual.ItemIndex = 0 then //valor
    begin
      ValDesconto := EDesconto.AValor;
    end
    else
      if CValorPercentual.ItemIndex = 1 then //percentual
      begin
        PerDesconto := EDesconto.AValor;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDescontoTela;
begin
  CValorPercentual.ItemIndex := -1;

  if VprDNotaFor.PerDesconto <> 0 then
  begin
    CValorPercentual.ItemIndex := 1;
    if VprDNotaFor.PerDesconto > 0 then
    begin
      EDesconto.AValor := VprDNotaFor.PerDesconto;
    end
    else
    begin
      EDesconto.AValor := VprDNotaFor.PerDesconto * (-1);
    end;
  end
  else
    if VprDNotaFor.ValDesconto <> 0 then
    begin
      CValorPercentual.ItemIndex := 0;
      if VprDNotaFor.ValDesconto > 0 then
      begin
        EDesconto.AValor := VprDNotaFor.ValDesconto;
      end
      else
      begin
        EDesconto.AValor := VprDNotaFor.ValDesconto *(-1);
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDItem;
begin
  VprDItemNota.CodProduto := Grade.Cells[RColunaGrade(clCodProduto),Grade.Alinha];
  if config.PermiteAlteraNomeProdutonaNotaEntrada then
    VprDItemNota.NomProduto := Grade.Cells[RColunaGrade(clNomProduto),Grade.Alinha];
  if Grade.Cells[RColunaGrade(clCodCor),Grade.ALinha] <> '' then
    VprDItemNota.CodCor := StrToInt(Grade.Cells[RColunaGrade(clCodCor),Grade.Alinha])
  else
    VprDItemNota.CodCor := 0;
  VprDItemNota.DesCor := Grade.Cells[RColunaGrade(clNomCor),Grade.ALinha];
  if Grade.Cells[RColunaGrade(clCodTamanho),Grade.ALinha] <> '' then
    VprDItemNota.CodTamanho := StrToInt(Grade.Cells[RColunaGrade(clCodTamanho),Grade.Alinha])
  else
    VprDItemNota.CodTamanho := 0;
  VprDItemNota.DesTamanho := Grade.Cells[RColunaGrade(clNomTamanho),Grade.ALinha];
  if Grade.Cells[RColunaGrade(clCFOP),Grade.ALinha] <> '' then
    VprDItemNota.CodCFOP := StrToInt(Grade.Cells[RColunaGrade(clCFOP),Grade.ALinha])
  else
    VprDItemNota.CodCFOP := 0;
  VprDItemNota.CodClassificacaoFiscal := Grade.Cells[RColunaGrade(clClassificacaoFiscal),Grade.ALinha];
  VprDItemNota.CodCST := Grade.Cells[RColunaGrade(clCST),Grade.ALinha];

  if Grade.Cells[RColunaGrade(clQtdChapas),Grade.ALinha] <> '' then
    VprDItemNota.QtdChapa:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clQtdChapas),Grade.ALinha],'.'))
  else
    VprDItemNota.QtdChapa := 0;
  if Grade.Cells[RColunaGrade(clLargura),Grade.ALinha] <> '' then
    VprDItemNota.LarChapa:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clLargura),Grade.ALinha],'.'))
  else
    VprDItemNota.LarChapa := 0;
  if Grade.Cells[RColunaGrade(clComprimento),Grade.ALinha] <> '' then
    VprDItemNota.ComChapa:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clComprimento),Grade.ALinha],'.'))
  else
    VprDItemNota.ComChapa := 0;

  VprDItemNota.UM := UpperCase(Grade.Cells[RColunaGrade(clUm),Grade.ALinha]);
  VprDItemNota.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha],'.'));
  if DeletaChars(DeletaChars(Grade.Cells[RColunaGrade(ClValUnitarioPro),Grade.ALinha],'0'),',') <> '' then
    VprDItemNota.ValUnitario := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(ClValUnitarioPro),Grade.ALinha],'.'))
  else
    if DeletaChars(DeletaChars(Grade.Cells[RColunaGrade(clValTotalPro),Grade.ALinha],'0'),',') <> '' then
      VprDItemNota.ValTotal := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValTotalPro),Grade.ALinha],'.'));
  VprDItemNota.PerICMS := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clPerIcms),Grade.ALinha],'.'));
  VprDItemNota.PerIPI := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clPerIpi),Grade.ALinha],'.'));
  VprDItemNota.ValBaseIcms:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clBaseIcms),Grade.ALinha],'.'));
  VprDItemNota.ValICMS:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValIcms),Grade.ALinha],'.'));
  VprDItemNota.PerMVA:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clPerMva),Grade.ALinha],'.'));
  VprDItemNota.ValBaseST := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clBaseSt),Grade.ALinha],'.'));
  VprDItemNota.ValST:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValST),Grade.ALinha],'.'));
  VprDItemNota.PerAcrescimoST := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clPerAcumulado),Grade.ALinha],'.'));
  VprDItemNota.ValNovoVenda := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValorVenda),Grade.ALinha],'.'));
  VprDItemNota.DesNumSerie := Grade.Cells[RColunaGrade(clNumSerie),Grade.ALinha];
  VprDItemNota.DesReferenciaFornecedor := Grade.Cells[RColunaGrade(clRefFornecedor),Grade.ALinha];
  if DeletaChars(DeletaChars(Grade.Cells[RColunaGrade(clPerReducaoICMS),Grade.ALinha],'0'),',') <> '' then
    VprDItemNota.PerReducaoBaseICMS := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clPerReducaoICMS),Grade.ALinha],'.'))
  else
    VprDItemNota.PerReducaoBaseICMS := 0;

  if Grade.Cells[RColunaGrade(clEtiquetas),Grade.ALinha] <> '' then
    VprDItemNota.QtdEtiquetas := StrToInt(Grade.Cells[RColunaGrade(clEtiquetas),Grade.Alinha])
  else
    VprDItemNota.QtdEtiquetas := 0;

  CalculaValorTotalProduto;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDItemServico;
begin
  VprDItemServico.CodServico := StrToInt(GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.Alinha]);
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDItemServico.NomServico := GradeServicos.Cells[RColunaGradeServicos(clDescServico),GradeServicos.ALinha];
  VprDItemServico.DesAdicional := GradeServicos.Cells[RColunaGradeServicos(clDescAdicional),GradeServicos.ALinha];
  VprDItemServico.QtdServico := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha],'.'));
  VprDItemServico.ValUnitario := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha],'.'));
  if GradeServicos.Cells[RColunaGradeServicos(clserCodCFOP),GradeServicos.ALinha] <> '' then
    VprDItemServico.CodCFOP := StrToInt(GradeServicos.Cells[RColunaGradeServicos(clserCodCFOP),GradeServicos.Alinha])
  else
    VprDItemServico.CodCFOP := 0;
  CalculaValorTotalServico;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarregaDadosCliente;
var
  VpfResultado : String;
begin
  if ECodFornecedor.Ainteiro <> VprDNotaFor.CodFornecedor then
  begin
    VprDNotaFor.CodFornecedor := ECodFornecedor.AInteiro;
    VprDCliente.CodCliente :=  VprDNotaFor.CodFornecedor;
    if VprDCliente.CodCliente <> 0 then
    begin
      FunClientes.CarDCliente(VprDCliente,true);
      //carrega o nome do contato
      if (VprOperacao in [ocinsercao,ocEdicao]) then
      begin
        VpfResultado :=FunClientes.DadosSpedClienteValido(VprDCliente);
        if VpfResultado = '' then
        begin
          CSimplesNacional.Checked := VprDCliente.IndSimplesNacional;
          VprDNotaFor.CGC_CPFFornecedor := VprDCliente.CGC_CPF;
          CarICMSPadrao;
        end;
      end;
    end;
    if VpfResultado = '' then
      AssociaNaturezaItens;

  end;
  if VpfResultado <> '' then
  begin
    aviso(VpfResultado);
    ECodFornecedor.Clear;
    ECodFornecedor.Atualiza;
  end
  else
    CarTitulosGrade;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Ações dos botões Inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Quando for clicado no autoCalculo**********************}
procedure TFNovaNotaFiscaisFor.AutoCalculoClick(Sender: TObject);
begin
   if autocalculo.Checked then
     CalculaNota;
   EBaseICms.ReadOnly := Autocalculo.Checked;
   EValIcms.ReadOnly := Autocalculo.Checked;
   EValTotalProdutos.ReadOnly := Autocalculo.Checked;
   EValTotalServicos.ReadOnly:= AutoCalculo.Checked;
   EValTotal.ReadOnly := Autocalculo.Checked;
   EValTotIPI.ReadOnly := Autocalculo.Checked;
end;

{***********************Quando é cancelado a nota******************************}
procedure TFNovaNotaFiscaisFor.BCancelaClick(Sender: TObject);
begin
  VprAcao:= False;
  LimpaComponentes(ScrollBox1,0);
  FreeTObjectsList(VprDNotaFor.ItensNota);
  Grade.CarregaGrade;
  VprOperacao := ocConsulta;
  AlteraEnabledBotao(false);
  if VprNotaPedido then
    Close;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFNovaNotaFiscaisFor.BFecharClick(Sender: TObject);
begin
  close;
end;

{*******************Cadastra uma nova transportadora***************************}
procedure TFNovaNotaFiscaisFor.ECodTransportadoraCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.CadClientesC_IND_TRA.AsString := 'S';
  FNovoCliente.CadClientesC_IND_CLI.AsString := 'N';
  FNovoCliente.showmodal;
  FNovoCliente.free;
end;

procedure TFNovaNotaFiscaisFor.ECodTransportadoraRetorno(
  VpaColunas: TRBColunasLocaliza);
begin

end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************************Chama o calcla nota********************************}
procedure TFNovaNotaFiscaisFor.EValFreteExit(Sender: TObject);
begin
   CalculaNota;
end;

{********************Quando é alterado quem pagara o frete*********************}
procedure TFNovaNotaFiscaisFor.CFreteEmitenteClick(Sender: TObject);
begin
  VprDNotaFor.IndFreteEmitente := CFreteEmitente.Checked;
  CalculaNota;
end;

{****** pemite alterar o foco com f4 **************************************** }
procedure TFNovaNotaFiscaisFor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  laco, tag : integer;
begin
  tag := 0;
  if key = 115 then
  begin
    for laco := 0 to PanelColor1.ControlCount - 1 do
     if (PanelColor1.Controls[laco] is TWinControl) then
       if (PanelColor1.Controls[laco] as TWinControl).Focused then
         tag := (PanelColor1.Controls[laco] as TWinControl).Tag;
    case tag of
      1 : Grade.SetFocus;
      2 : GradeServicos.SetFocus;
      3 : ENumNota.SetFocus;
      4 : EBaseICMS.SetFocus;
    end
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ENaturezaRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    if VprOperacao in [ocInsercao,ocEdicao] then
    begin
      VprDNotaFor.CodNatureza := Retorno1;
      FunNotaFor.CarDNaturezaOperacao(VprDNotaFor);
      EPlano.Text := VprDNotaFor.DNaturezaOperacao.CodPlanoContas;
      CarICMSPadrao;
      EPlanoExit(EPlano);
      LNatureza.Caption := VprDNotaFor.DNaturezaOperacao.NomOperacaoEstoque;
      AssociaNaturezaItens;
      CalculaNota;
   end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EPlanoExit(Sender: TObject);
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VprDNotaFor.DNaturezaOperacao.CodPlanoContas := EPlano.text;
  if not FPlanoConta.verificaCodigo( VprDNotaFor.DNaturezaOperacao.CodPlanoContas, 'D', Label33, false,(Sender is TSpeedButton) ) then
    EPlano.SetFocus;
  EPlano.text := VprDNotaFor.DNaturezaOperacao.CodPlanoContas;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 114 then
    EPlanoExit(SpeedButton5);
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EFormaPagamentoRetorno(Retorno1,
  Retorno2: String);
begin
  VprDNotaFor.TipFormaPagamento := retorno1;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ECorEnter(Sender: TObject);
begin
  ECor.Clear;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application , '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
  Localiza.Atualizaconsulta;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EDatEntradaExit(Sender: TObject);
begin
  if (StrToDate(EDatEntrada.text) <= varia.DataUltimoFechamento) then
  begin
    Aviso(CT_DATAMENORULTIMOFECHAMENTO);
    EDatEntrada.Clear;
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemNota := TRBDNotaFiscalForItem(VprDNotaFor.ItensNota.Items[VpaLinha-1]);
  Grade.Cells[RColunaGrade(clCodProduto),VpaLinha] := VprDItemNota.CodProduto;
  Grade.Cells[RColunaGrade(clNomProduto),VpaLinha] := VprDItemNota.NomProduto;
  if VprDItemNota.CodCor <> 0 then
    Grade.Cells[RColunaGrade(clCodCor),VpaLinha] := IntToStr(VprDItemNota.CodCor)
  else
    Grade.Cells[RColunaGrade(clCodCor),VpaLinha] := '';
  Grade.Cells[RColunaGrade(clNomCor),VpaLinha] := VprDItemNota.DesCor;

  if VprDItemNota.CodTamanho <> 0 then
    Grade.Cells[RColunaGrade(clCodTamanho),VpaLinha] := IntToStr(VprDItemNota.CodTamanho)
  else
    Grade.Cells[RColunaGrade(clCodTamanho),VpaLinha] := '';
  Grade.Cells[RColunaGrade(clNomTamanho),VpaLinha] := VprDItemNota.DesTamanho;
  if (VprDItemNota.CodCFOP <> 0) then
    Grade.Cells[RColunaGrade(clCFOP),VpaLinha] := IntToStr(VprDItemNota.CodCFOP)
  else
    Grade.Cells[RColunaGrade(clCFOP),VpaLinha] := '';
  Grade.Cells[RColunaGrade(clClassificacaoFiscal),VpaLinha] := VprDItemNota.CodClassificacaoFiscal;
  Grade.Cells[RColunaGrade(clCST),VpaLinha] := VprDItemNota.CodCST;
  if VprDItemNota.QtdChapa <> 0 then
    Grade.Cells[RColunaGrade(clQtdChapas),Grade.ALinha]:= FormatFloat('#,###,###0',VprDItemNota.QtdChapa)
  else
    Grade.Cells[RColunaGrade(clQtdChapas),Grade.ALinha]:= '';
  if VprDItemNota.LarChapa <> 0 then
    Grade.Cells[RColunaGrade(clLargura),Grade.ALinha]:= FormatFloat('#,###,###0',VprDItemNota.LarChapa)
  else
    Grade.Cells[RColunaGrade(clLargura),Grade.ALinha]:= '';
  if VprDItemNota.ComChapa <> 0 then
    Grade.Cells[RColunaGrade(clComprimento),Grade.ALinha]:= FormatFloat('#,###,###0',VprDItemNota.ComChapa)
  else
    Grade.Cells[RColunaGrade(clComprimento),Grade.ALinha]:= '';
  Grade.Cells[RColunaGrade(clPerIcms),VpaLinha] := FormatFloat('0.00',VprDItemNota.PerICMS);
  Grade.Cells[RColunaGrade(clUm),VpaLinha] := VprDItemNota.UM;
  Grade.Cells[RColunaGrade(clPerIcms),VpaLinha] := FormatFloat('0.00',VprDItemNota.PerICMS);
  Grade.Cells[RColunaGrade(clPerIpi),VpaLinha] := FormatFloat('0.00',VprDItemNota.PerIPI);

  Grade.Cells[RColunaGrade(clBaseIcms),VpaLinha] := FormatFloat('#,###,###,##0.00',VprDItemNota.ValBaseIcms);
  Grade.Cells[RColunaGrade(clValIcms),VpaLinha] := FormatFloat('#,###,###,##0.00',VprDItemNota.ValICMS);
  if VprDItemNota.PerReducaoBaseICMS <> 0 then
    Grade.Cells[RColunaGrade(clPerReducaoICMS),VpaLinha] := FormatFloat('#,###,###,##0.00',VprDItemNota.PerReducaoBaseICMS)
  else
    Grade.Cells[RColunaGrade(clPerReducaoICMS),VpaLinha] := '';

  CalculaValorTotalProduto;

  Grade.Cells[RColunaGrade(clPerMva),VpaLinha] := FormatFloat('#,##0.00',VprDItemNota.PerMVA);
  Grade.Cells[RColunaGrade(clPerMvaAjustado),VpaLinha] := FormatFloat('#,##0.00',VprDItemNota.PerMVAAjustado);
  Grade.Cells[RColunaGrade(clBaseSt),VpaLinha] := FormatFloat(Varia.MascaraValor,VprDItemNota.ValBaseST);
  Grade.Cells[RColunaGrade(clValST),VpaLinha] := FormatFloat(Varia.MascaraValor,VprDItemNota.ValST);
  Grade.Cells[RColunaGrade(clPerAcumulado),VpaLinha] := FormatFloat('0.00',VprDItemNota.PerAcrescimoST);

  Grade.Cells[RColunaGrade(clNumSerie),VpaLinha] := VprDItemNota.DesNumSerie;
  Grade.Cells[RColunaGrade(clRefFornecedor),VpaLinha] := VprDItemNota.DesReferenciaFornecedor;
  Grade.Cells[RColunaGrade(clEtiquetas),VpaLinha] := IntToStr(VprDItemNota.QtdEtiquetas);
end;

procedure TFNovaNotaFiscaisFor.GradeContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeDepoisExclusao(Sender: TObject);
begin
  CalculaNota;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeEnter(Sender: TObject);
begin
  CarDClasse;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  if (RColunaGrade(clCodCor) = ACol) or
     (RColunaGrade(clCodTamanho)= ACol) or
     (RColunaGrade(clClassificacaoFiscal)= ACol) or
     (RColunaGrade(clEtiquetas)= ACol) then
    Value := '00000000;0; ';
  if (RColunaGrade(clCFOP) = ACol)then
    Value := '0000;0; ';
  if (RColunaGrade(clCST) = ACol)then
  begin
    if VprDCliente.IndSimplesNacional then
      Value := '0000;0; '
    else
      Value := '000;0; '
  end;
end;

procedure TFNovaNotaFiscaisFor.GradeGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case Grade.Col of
        1 :  LocalizaProduto;
        3 :  ECor.AAbreLocalizacao;
        5 :  ETamanho.AAbreLocalizacao;
      end;
    end;
    vk_f6 : AlteraProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  IF (Grade.Col = 4) or ((Grade.Col = 2) and not config.PermiteAlteraNomeProdutonaNotaEntrada) then
    key := #0;

  if (key = '.') and (Grade.col <> 1) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNotaFor.ItensNota.Count >0 then
  begin
    VprDItemNota := TRBDNotaFiscalForItem(VprDNotaFor.ItensNota.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDItemNota.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeNovaLinha(Sender: TObject);
begin
  VprDItemNota := VprDNotaFor.AddNotaItem;
  VprDItemNota.PerICMS := VprDNotaFor.PerICMSPadrao;
  VprDItemNota.PerIPI := 0;
  VprDItemNota.CodCFOP := VprDNotaFor.DNaturezaOperacao.CFOPProdutoIndustrializacao;
  Grade.Cells[RColunaGrade(clPerIcms),Grade.ALinha] := FormatFloat('0.00',VprDItemNota.PerICMS);
  Grade.Cells[RColunaGrade(clPerIpi),Grade.ALinha] := FormatFloat('0.00',VprDItemNota.PerIPI);
  InicializaDadosProdutoSpedFiscal;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
  begin
    case Varia.TipFonte of
     ecUpperCase : Grade.Cells[grade.AColuna,Grade.ALinha] := UpperCase(Grade.Cells[grade.AColuna,Grade.ALinha]);
     ecLowerCase : Grade.Cells[grade.AColuna,Grade.ALinha] := lowerCase(Grade.Cells[grade.AColuna,Grade.ALinha]);
    end;
    if Grade.AColuna <> ACol then
    begin
      if RColunaGrade(clCodProduto) = Grade.AColuna then
      begin
        if not ExisteProduto then
        begin
          if not LocalizaProduto then
          begin
            Grade.Cells[RColunaGrade(clCodProduto),Grade.ALinha] := '';
            Grade.Col := RColunaGrade(clCodProduto);
          end;
        end;
      end;
      if RColunaGrade(clCodCor) = Grade.AColuna then
      begin
        if Grade.Cells[RColunaGrade(clCodCor),Grade.Alinha] <> '' then
        begin
          if not ExisteCor(StrToInt(Grade.Cells[RColunaGrade(clCodCor),Grade.Alinha])) then
          begin
            if not ECor.AAbreLocalizacao then
            begin
              Aviso(CT_CORINEXISTENTE);
              Grade.Col := RColunaGrade(clCodCor);
              abort;
            end;
          end;
        end;
      end;
      if RColunaGrade(clCodTamanho) = Grade.AColuna then
      begin
        if not ETamanho.AExisteCodigo(Grade.Cells[RColunaGrade(clCodTamanho),Grade.ALinha]) then
        begin
          if not ETamanho.AAbreLocalizacao then
          begin
            aviso('TAMANHO INEXISTENTE!!!'#13'É necessário digitar um tamanho cadatrado');
            abort;
            Grade.Col := RColunaGrade(clCodTamanho);
          end;
        end;
      end;
      if (RColunaGrade(clQtdChapas) = Grade.AColuna) or
         (RColunaGrade(clLargura) = Grade.AColuna) or
         (RColunaGrade(clComprimento) = Grade.AColuna) then
      begin
        CalculaKilosChapa;
      end;
      if RColunaGrade(clUm) = Grade.AColuna then
      begin
        if not ExisteUM then
        begin
          aviso(CT_UNIDADEVAZIA);
          Grade.col := 13;
          abort;
        end;
      end;
      if RColunaGrade(clQtdPro) = Grade.AColuna then
      begin
        if Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha] <> '' then
         VprDItemNota.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha],'.'))
        else
         VprDItemNota.QtdProduto := 0;
        CalculaValorTotalProduto;
        VprDItemNota.QtdEtiquetas := ArredondaPraMaior(VprDItemNota.QtdProduto);
        Grade.Cells[RColunaGrade(clEtiquetas),Grade.ALinha] := IntToStr(VprDItemNota.QtdEtiquetas);
      end;
      if RColunaGrade(ClValUnitarioPro) = Grade.AColuna then
      begin
        if Grade.Cells[RColunaGrade(ClValUnitarioPro),Grade.ALinha] <> '' then
        begin
          VprDItemNota.ValTotal := 0;
          VprDItemNota.ValUnitario := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(ClValUnitarioPro),Grade.ALinha],'.'));
        end
        else
          VprDItemNota.ValUnitario := 0;
        CalculaValorTotalProduto;
      end;
      if RColunaGrade(clValTotalPro) = Grade.AColuna then
      begin
        if Grade.Cells[RColunaGrade(clValTotalPro),Grade.ALinha] <> '' then
        begin
          VprDItemNota.ValUnitario := 0;
          VprDItemNota.ValTotal := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValTotalPro),Grade.ALinha],'.'));
        end
        else
          VprDItemNota.ValTotal := 0;
        CalculaValorTotalProduto;
      end;
      if RColunaGrade(clPerMva) = Grade.AColuna then
      begin
        VprDItemNota.PerMVA:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clPerMva),Grade.ALinha],'.'));
        FunNotaFor.CarMVAAjustado(VprDNotaFor,VprDItemNota,VprDCliente);
        Grade.Cells[RColunaGrade(clPerMvaAjustado),Grade.ALinha] := FormatFloat('#,##0.00',VprDItemNota.PerMVAAjustado);
      end;

    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeServicosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemServico := TRBDNotaFiscalForServico(VprDNotaFor.ItensServicos.Items[VpaLinha-1]);
  if VprDItemServico.CodServico <> 0 then
    GradeServicos.Cells[RColunaGradeServicos(clCodServico),VpaLinha] := IntToStr(VprDItemServico.CodServico)
  else
    GradeServicos.Cells[RColunaGradeServicos(clCodServico),VpaLinha] := '';
  GradeServicos.Cells[RColunaGradeServicos(clDescServico),VpaLinha] := VprDItemServico.NomServico;
  GradeServicos.Cells[RColunaGradeServicos(clDescAdicional),VpaLinha] := VprDItemServico.DesAdicional;
  GradeServicos.Cells[RColunaGradeServicos(clQtd),VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDItemServico.QtdServico);
  GradeServicos.cells[RColunaGradeServicos(clValUnitario),VpaLinha] := FormatFloat(Varia.MascaraValorUnitario,VprDItemServico.ValUnitario);
  GradeServicos.Cells[RColunaGradeServicos(clValTotal),VpaLinha] := FormatFloat(Varia.MascaraValor,VprDItemServico.ValTotal);
  if VprDItemServico.CodCFOP <> 0 then
    GradeServicos.Cells[RColunaGradeServicos(clserCodCFOP),VpaLinha] := IntToStr(VprDItemServico.CodCFOP)
  else
    GradeServicos.Cells[RColunaGradeServicos(clserCodCFOP),VpaLinha] := '';
  CalculaValorTotalServico;
end;

procedure TFNovaNotaFiscaisFor.GradeServicosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
var
  VpfResultado : String;
begin
  VpaValidos := false;
  if not ExisteServico then
  begin
    GradeServicos.col := RColunaGradeServicos(clCodServico);
    aviso('SERVIÇO NÃO PREENCHIDO!!!'#13'É necessário preencher o código do serviço.');
  end
  else
    if GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] = '' then
    begin
      GradeServicos.col := RColunaGradeServicos(clQtd);
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] = '' then
      begin
        GradeServicos.col := RColunaGradeServicos(clValUnitario);
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
     end
      else
        VpaValidos := true;
  if VpaValidos then
  begin
    CarDItemServico;
    CalculaNota;

    if VprDItemServico.QtdServico = 0 then
    begin
      VpaValidos := false;
      GradeServicos.col := RColunaGradeServicos(clQtd);
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if VprDItemServico.ValUnitario = 0 then
      begin
        VpaValidos := false;
        GradeServicos.col := RColunaGradeServicos(clValUnitario);
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
      end;
    if VpaValidos then
    begin
      VpfResultado := DadosServicosSpedValidos;
      if VpfResultado <>'' then
      begin
        aviso(VpfResultado);
        VpaValidos := false;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeServicosEnter(Sender: TObject);
begin
  CarDClasse;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeServicosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if ACol = RColunaGradeServicos(clCodServico) then
    Value := '0000000;0; '
  else
    if ACol = RColunaGradeServicos(clserCodCFOP) then
      Value := '0000;0; '
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeServicosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GradeServicos.Col of
        1 :  LocalizaServico;
      end;
    end;
  end;
end;

procedure TFNovaNotaFiscaisFor.GradeServicosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = '.')  then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeServicosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNotaFor.ItensServicos.Count >0 then
  begin
    VprDItemServico := TRBDNotaFiscalForServico(VprDNotaFor.ItensServicos.Items[VpaLinhaAtual-1]);
    VprServicoAnterior := InttoStr(VprDItemServico.CodServico);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeServicosNovaLinha(Sender: TObject);
begin
  VprDItemServico:= VprDNotaFor.AddNotaServico;
  VprServicoAnterior := '-10';
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeServicosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   if GradeServicos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GradeServicos.AColuna <> ACol then
    begin
      case GradeServicos.AColuna of
        1 :if not ExisteServico then
           begin
             if not LocalizaServico then
             begin
               GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] := '';
               GradeServicos.Col := RColunaGradeServicos(clCodServico);
             end;
           end;
        4,5 :
             begin
               if GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] <> '' then
                 VprDItemServico.QtdServico := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha],'.'))
               else
                 VprDItemServico.QtdServico := 0;
               if GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] <> '' then
                 VprDItemServico.ValUnitario := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha],'.'))
               else
                 VprDItemServico.ValUnitario := 0;
               CalculaValorTotalServico;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ECorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[RColunaGrade(clCodCor),Grade.ALinha] := ECor.Text;
    Grade.Cells[RColunaGrade(clNomCor),Grade.ALinha] := Retorno1;
    Grade.AEstadoGrade := egEdicao;
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
Var
  VpfResultado : string;
begin
  VpaValidos := true;
  if Grade.Cells[RColunaGrade(clCodProduto),Grade.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      Grade.col := RColunaGrade(clCodProduto);
    end
    else
      if (Grade.Cells[RColunaGrade(clCodCor),Grade.ALinha] <> '') then
      begin
        if not Existecor(StrToInt(Grade.Cells[RColunaGrade(clCodCor),Grade.ALinha])) then
        begin
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          Grade.Col := RColunaGrade(clCodCor);
        end;
      end
      else
        if config.ExigirCorNotaEntrada then
        begin
          // se a cor for igual a '' e estiver configurado para controlar estoque
          // pela cor, entao fazer checagem direta.
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          Grade.Col := RColunaGrade(clCodCor);
        end;
  if vpavalidos then
  begin
    if not ETamanho.AExisteCodigo(Grade.Cells[RColunaGrade(clCodTamanho),Grade.ALInha]) then
    begin
      VpaValidos := false;
      Aviso('TAMANHO INEXISTENTE!!!'#13'É necessário digitar um tamanho válido.');
      Grade.Col := RColunaGrade(clCodTamanho);
    end
    else
      if (VprDItemNota.UnidadeParentes.IndexOf(Grade.Cells[RColunaGrade(clUm),Grade.Alinha]) < 0) then
      begin
        VpaValidos := false;
        aviso(CT_UNIDADEVAZIA);
        Grade.col := RColunaGrade(clUm);
      end
      else
        if (Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha] = '') then
        begin
          VpaValidos := false;
          aviso(CT_QTDPRODUTOINVALIDO);
          Grade.Col := RColunaGrade(clQtdPro);
        end
        else
          if ((Grade.Cells[RColunaGrade(ClValUnitarioPro),Grade.ALinha] = '') and (Grade.Cells[RColunaGrade(clValTotalPro),Grade.ALinha] = '')) then
          begin
            VpaValidos := false;
            aviso(CT_VALORUNITARIOINVALIDO);
            Grade.Col := RColunaGrade(ClValUnitarioPro);
          end;
  end;

  if VpaValidos then
  begin
    CarDItem;
    CalculaNota;
    if VprDItemNota.QtdProduto = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      Grade.col := RColunaGrade(clQtdPro)
    end
    else
      if VprDItemNota.ValUnitario = 0 then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        Grade.Col := RColunaGrade(ClValUnitarioPro);
      end;
  end;
  if VpaValidos then
  begin
    if config.Farmacia then
    begin
      if (VprDItemNota.IndMedicamentoControlado) and (VprDItemNota.DesNumSerie = '') then
      begin
        VpaValidos := false;
        aviso('NUMERO DO LOTE NÃO PREENCHIDO!!!'#13'É necessário preencher o numero do lote quando o medicamento é controlado.');
        Grade.Col := RColunaGrade(clNumSerie);
      end;
    end;
  end;
  if VpaValidos  then
  begin
    VpfResultado := DadosItensSpedValidos;
    if VpfResultado <>'' then
    begin
      aviso(VpfResultado);
      VpaValidos := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BCadastrarClick(Sender: TObject);
begin
  InicializaTela;
  ENumNota.SetFocus;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if DadosNotaFiscalValidos then
  begin
    VpfResultado := DadosNFEValidos;
    try
      if VpfResultado = '' then
      begin
        CarDClasse;
        if FPrincipal.BaseDados.InTransaction then
          FPrincipal.BaseDados.Rollback(VprTransacao);
        VprTransacao.IsolationLevel := xilREADCOMMITTED;
        FPrincipal.BaseDados.StartTransaction(VprTransacao);
        if (VprOperacao = ocEdicao) then//se é alteraçao da nota fiscal de entrada
        begin
          if FunContasPagar.ExcluiContaNotaFiscal(VprDNotaFor.SeqNota ) then
          begin
            FunNotaFor.EstornaNotaEntrada(VprDNotaFor.CodFilial,VprDNotaFor.SeqNota);
          end
          else
            VpfResultado :='NÃO FOI POSSÍVEL EXCLUIR O CONTAS A PAGAR.';
        end;

        if VpfResultado = '' then
        begin
          VpfResultado := FunNotaFor.GravaDNotaFor(VprDNotaFor);
          if VpfResultado <>'' then
            aviso(VpfResultado)
          else
          begin
            Tempo.execute('Atualizando Estoque Produto...');
            FunNotaFor.BaixaProdutosEstoque(VprDNotaFor);
            Tempo.fecha;
            Tempo.execute('Gerando o Contas a Pagar...');
            VpfResultado :=  FunNotaFor.GeraContasaPagar(VprDNotaFor);
            BConhecimento.Enabled:= true;
            if VpfResultado = '' then
            begin
              if VprDNotaFor.IndNotaDevolucao then
              begin
                if VprDNotaFor.PerComissao > 0 then
                  VpfResultado := FunContasAReceber.GeraComissaoNegativa(VprDNotaFor);
              end;
              if VpfResultado = '' then
              begin
                if VprListaPedidos <> nil then
                begin
                  VpfResultado := FunPedidoCompra.GravaVinculoNotaFiscal(VprDNotaFor, VprListaPedidos);
                  if VpfResultado = '' then
                  begin
                     FunPedidoCompra.BaixarQtdeProdutoPedido(VprDNotaFor, VprListaPedidos);
                  end;
                end;
              end;
            end;
            Tempo.fecha;
          end;
        end;
      end;
      if VpfResultado = '' then
      begin
        FPrincipal.BaseDados.Commit(VprTransacao);
        VprAcao:= True;
        AlteraEnabledBotao(false);
      end
      else
      begin
        aviso(VpfResultado);
        if FPrincipal.BaseDados.InTransaction then
          FPrincipal.BaseDados.Rollback(VprTransacao);
      end;
    except
      on e : Exception do
      begin
        FPrincipal.BaseDados.Rollback(VprTransacao);
        aviso(e.message);
      end;
    end;
    if VprAcao then
    begin
      if VprIndTroca then
      begin
        VprDCotacao.ValTroca := VprDNotaFor.ValTotal;
        VprDCotacao.SeqNotaEntrada := VprDNotaFor.SeqNota;
      end;
    end;
    if VpfResultado = '' then
    begin
      if VprDNotaFor.IndGerouEstoqueChapa then
      begin
        FMostraEstoqueChapas := TFMostraEstoqueChapas.CriarSDI(self,'',true);
        FMostraEstoqueChapas.MostraEstoqueChapasNota(VprDNotaFor.CodFilial,VprDNotaFor.SeqNota);
        FMostraEstoqueChapas.Free;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeGetCellAlignment(sender: TObject; ARow,
  ACol: Integer; var HorAlignment: TAlignment;
  var VerAlignment: TVerticalAlignment);
begin
  if ACol = 19 then
    HorAlignment :=  taRightJustify;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BCancelarClick(Sender: TObject);
begin
  PEtiqueta.Visible := false;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BConhecimentoClick(Sender: TObject);
begin
  FConhecimentoTransporteEntrada := TFConhecimentoTransporteEntrada.CriarSDI(self,'',true);
  FConhecimentoTransporteEntrada.ConsultarConhecimento(VprDNotaFor.CodTransportadora, VprDNotaFor.CodFilial, VprDNotaFor.SeqNota, true);
  FConhecimentoTransporteEntrada.Free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BEtiquetaClick(Sender: TObject);
begin
  case varia.ModeloEtiquetaNotaEntrada of
    0, 5 : PEtiqueta.Visible := true;
    2,3,4,6,7,10 :  FunNotaFor.ImprimeEtiquetaNota(VprDNotaFor);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BOKClick(Sender: TObject);
begin
  ImpressaoEtiquetaBarras;
  PEtiqueta.Visible := false;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ECodFornecedorSelect(Sender: TObject);
begin
  ECodFornecedor.ASelectLocaliza.Text := 'Select * from CadClientes where c_nom_Cli like ''@%'' AND C_IND_ATI = ''S''';
  ECodFornecedor.ASelectValida.Text := 'select * from CadClientes where I_COD_CLI = @ AND C_IND_ATI = ''S''';
  if not VprDNotaFor.IndNotaDevolucao then
  begin
   ECodFornecedor.ASelectLocaliza.Text := ECodFornecedor.ASelectLocaliza.Text +' and c_ind_for = ''S''';
   ECodFornecedor.ASelectValida.Text := ECodFornecedor.ASelectValida.Text +' and c_ind_for = ''S''';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeNotaFiscalEntrada(VprDNotaFor.CodFilial,VprDNotaFor.SeqNota,false);
  dtRave.free;
end;

procedure TFNovaNotaFiscaisFor.BitBtn1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ETamanhoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if (VprOperacao in [ocinsercao,ocedicao]) and
     (VprDItemNota <> nil) then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDItemNota.CodTamanho := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDItemNota.DesTamanho := VpaColunas.items[1].AValorRetorno;
      Grade.Cells[RColunaGrade(clCodTamanho),Grade.ALinha] := VpaColunas.items[0].AValorRetorno;
      Grade.Cells[RColunaGrade(clNomTamanho),Grade.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDItemNota.CodTamanho := 0;
      VprDItemNota.DesTamanho := '';
    end;
  end;
end;

Initialization
{***************Registra a classe para evitar duplicidade**********************}
   RegisterClasses([TFNovaNotaFiscaisFor]);
end.

