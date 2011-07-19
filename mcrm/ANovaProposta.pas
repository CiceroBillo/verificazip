unit ANovaProposta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, Localizacao,
  StdCtrls, Buttons, numericos, Mask, UnDados, Constantes, UnProspect, UnProposta,
  ConvUnidade, UnProdutos, DBKeyViolation,  UnSistema, Db,
  DBTables, DBGrids, Tabela, DBCtrls, ComCtrls, UnServicos, UnClientes, unChamado,
  UnDadosLocaliza, DBClient, SqlExpr;

type
  TRBDColunaGradeProdutos =(clCodProduto,clNomProduto,clCodCor,clNomCor,clUn,clQuantidade,clValUnitario, clValTotal, clOpcao, clValDesconto, clObs, clPerIPI, clValIpi, clPerMargemLucro);
  TRBDColunaGradeCondicoesPagamento = (clCodCondicao, clNomCondicao, clIndAprovado);
  TRBDColunaGradeMaterialAcabamento = (clMACodProduto, clMANomProduto,clMAUn,clMAQuantidade,clMAValUnitario, clMAValTotal);
  TRBDColunaGradeParcelas = (clFPValor, clFPCondicao, clFPDatPagamento, clFPFormaPagamento, clFPCodFormaPagamento);

  TFNovaProposta = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    ValidaUnidade: TValidaUnidade;
    BCadastrar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BImprimir: TBitBtn;
    BEmail: TBitBtn;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    Paginas: TPageControl;
    PProposta: TTabSheet;
    ScrollBox1: TScrollBox;
    PanelColor5: TPanelColor;
    PanelColor3: TPanelColor;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Bevel1: TBevel;
    Label7: TLabel;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    LNomProduto: TLabel;
    Label10: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton5: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    Label17: TLabel;
    SpeedButton7: TSpeedButton;
    Label18: TLabel;
    EFilial: TEditLocaliza;
    ESeqProposta: TEditColor;
    EDatProposta: TEditColor;
    EContato: TEditColor;
    EProduto: TEditLocaliza;
    EVendedor: TEditLocaliza;
    EProfissao: TEditLocaliza;
    EEmail: TEditColor;
    ECondicaoPagamento: TEditLocaliza;
    EFormaPagamento: TEditLocaliza;
    ECor: TEditLocaliza;
    PanelColor4: TPanelColor;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    SpeedButton8: TSpeedButton;
    Label25: TLabel;
    Bevel2: TBevel;
    SpeedButton9: TSpeedButton;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    EValidade: TMaskEditColor;
    EPrevisaoCompra: TMaskEditColor;
    EValTotal: Tnumerico;
    EObservacao: TMemoColor;
    EMotivoCompra: TEditLocaliza;
    EConcorrente: TEditLocaliza;
    EValConcorrente: Tnumerico;
    EPrazoEntrega: Tnumerico;
    PEstagio: TTabSheet;
    DBMemoColor1: TDBMemoColor;
    Splitter1: TSplitter;
    GridIndice1: TGridIndice;
    EstagiosProposta: TSQL;
    DataEstagiosProposta: TDataSource;
    EstagiosPropostaCODESTAGIO: TFMTBCDField;
    EstagiosPropostaDATESTAGIO: TSQLTimeStampField;
    EstagiosPropostaDESMOTIVO: TWideStringField;
    EstagiosPropostaNOMEST: TWideStringField;
    EstagiosPropostaC_NOM_USU: TWideStringField;
    PEmail: TTabSheet;
    GradeEmails: TGridIndice;
    PROPOSTAEMAIL: TSQL;
    DataPROPOSTAEMAIL: TDataSource;
    PROPOSTAEMAILDATEMAIL: TSQLTimeStampField;
    PROPOSTAEMAILDESEMAIL: TWideStringField;
    PROPOSTAEMAILC_NOM_USU: TWideStringField;
    CClienteDevolvera: TCheckBox;
    Label9: TLabel;
    ETipFrete: TComboBoxColor;
    ETelefone: TEditColor;
    Label31: TLabel;
    PaginasProdutoAmostra: TPageControl;
    PProdutos: TTabSheet;
    GProdutos: TRBStringGridColor;
    PAmostras: TTabSheet;
    GAmostras: TRBStringGridColor;
    EAmostra: TEditLocaliza;
    EAmostraCor: TEditLocaliza;
    PLocacao: TTabSheet;
    Splitter2: TSplitter;
    GLocacao: TRBStringGridColor;
    GLocacaoItem: TRBStringGridColor;
    Label32: TLabel;
    SpeedButton10: TSpeedButton;
    Label33: TLabel;
    ESetor: TEditLocaliza;
    PServicos: TTabSheet;
    GServicos: TRBStringGridColor;
    EServico: TEditLocaliza;
    CComprou: TCheckBox;
    CComprouConcorrente: TCheckBox;
    PProspect: TPanelColor;
    Label4: TLabel;
    EProspect: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    PCliente: TPanelColor;
    Label35: TLabel;
    ECliente: TEditLocaliza;
    SpeedButton11: TSpeedButton;
    Label34: TLabel;
    ETipoProposta: TEditLocaliza;
    Label36: TLabel;
    SpeedButton12: TSpeedButton;
    Label37: TLabel;
    PProdutoSemQtd: TTabSheet;
    GProSemQtd: TRBStringGridColor;
    PProdutosRotulados: TTabSheet;
    GProRotulados: TRBStringGridColor;
    EFormatoFrasco: TRBEditLocaliza;
    EMaterialFrasco: TRBEditLocaliza;
    EMaterialRotulo: TRBEditLocaliza;
    EMaterialLinerRotulo: TRBEditLocaliza;
    EMaterialContraRotulo: TRBEditLocaliza;
    EMaterialLinerContraRotulo: TRBEditLocaliza;
    EMaterialGargantilha: TRBEditLocaliza;
    ELinerGargantilha: TRBEditLocaliza;
    ECEP: TEditColor;
    Label38: TLabel;
    LNomAmostra: TLabel;
    PVendaAdicional: TTabSheet;
    GVendaAdicional: TRBStringGridColor;
    ECorVendaAdicional: TRBEditLocaliza;
    Label39: TLabel;
    EValFrete: Tnumerico;
    Label40: TLabel;
    EPrevisaoVisitaTec: TMaskEditColor;
    PObsCompras: TTabSheet;
    PanelColor6: TPanelColor;
    Label41: TLabel;
    EObservacaoCompras: TMemoColor;
    PProdutosCliente: TTabSheet;
    GMaquinaCliente: TRBStringGridColor;
    EProdutoCliente: TRBEditLocaliza;
    EEmbalagemCliente: TRBEditLocaliza;
    EAplicacaoCliente: TRBEditLocaliza;
    Label42: TLabel;
    ETipHorasInstalacao: TComboBoxColor;
    PDesconto: TPanelColor;
    EDesconto: Tnumerico;
    Label23: TLabel;
    CAcrescimoDesconto: TRadioGroup;
    CValorPercentual: TRadioGroup;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    EObsInstalacao: TEditLocaliza;
    SpeedButton13: TSpeedButton;
    Label46: TLabel;
    PObsInstalacao: TTabSheet;
    PanelColor7: TPanelColor;
    Label47: TLabel;
    EObsInstalacaoAba: TMemoColor;
    DBMemoColor2: TDBMemoColor;
    EstagiosPropostaDESLOG: TWideStringField;
    Label48: TLabel;
    Label49: TLabel;
    ETotalProdutos: Tnumerico;
    Label50: TLabel;
    ETotalIPI: Tnumerico;
    TabSheet1: TTabSheet;
    GCondicoes: TRBStringGridColor;
    ECondicao: TEditLocaliza;
    LCondicao: TLabel;
    PMaterialAcabamento: TTabSheet;
    GMaterialAcabamento: TRBStringGridColor;
    EGarantia: TEditColor;
    Label51: TLabel;
    EObsDataInstalacao: TEditColor;
    PFormaPagamento: TTabSheet;
    GParcelas: TRBStringGridColor;
    EFormaPagamentoParcelas: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EProspectCadastrar(Sender: TObject);
    procedure EProspectFimConsulta(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosDepoisExclusao(Sender: TObject);
    procedure GProdutosEnter(Sender: TObject);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorEnter(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDescontoChange(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BEmailClick(Sender: TObject);
    procedure EProspectChange(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure GAmostrasCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GAmostrasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GAmostrasGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GAmostrasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EAmostraRetorno(Retorno1, Retorno2: String);
    procedure EAmostraCorRetorno(Retorno1, Retorno2: String);
    procedure GAmostrasKeyPress(Sender: TObject; var Key: Char);
    procedure GAmostrasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GAmostrasNovaLinha(Sender: TObject);
    procedure GAmostrasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GLocacaoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GLocacaoDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GLocacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GLocacaoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GLocacaoNovaLinha(Sender: TObject);
    procedure GLocacaoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GLocacaoItemCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GLocacaoItemDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GLocacaoItemGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GLocacaoItemKeyPress(Sender: TObject; var Key: Char);
    procedure GLocacaoItemMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GLocacaoItemNovaLinha(Sender: TObject);
    procedure GServicosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GServicosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GServicosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GServicosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GServicosNovaLinha(Sender: TObject);
    procedure GServicosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EServicoRetorno(Retorno1, Retorno2: String);
    procedure GServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GServicosKeyPress(Sender: TObject; var Key: Char);
    procedure EServicoSelect(Sender: TObject);
    procedure EServicoCadastrar(Sender: TObject);
    procedure EMotivoCompraCadastrar(Sender: TObject);
    procedure EConcorrenteCadastrar(Sender: TObject);
    procedure CComprouClick(Sender: TObject);
    procedure CComprouConcorrenteClick(Sender: TObject);
    procedure EConcorrenteFimConsulta(Sender: TObject);
    procedure EClienteCadastrar(Sender: TObject);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure ESetorCadastrar(Sender: TObject);
    procedure EProfissaoCadastrar(Sender: TObject);
    procedure ESetorRetorno(Retorno1, Retorno2: String);
    procedure ETipoPropostaCadastrar(Sender: TObject);
    procedure GProSemQtdCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProSemQtdDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProSemQtdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProSemQtdKeyPress(Sender: TObject; var Key: Char);
    procedure GProSemQtdMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProSemQtdNovaLinha(Sender: TObject);
    procedure GProSemQtdSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GProRotuladosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProRotuladosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProRotuladosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFormatoFrascoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EMaterialFrascoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EMaterialRotuloRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EMaterialLinerRotuloRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EMaterialContraRotuloRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EMaterialLinerContraRotuloRetorno(
      VpaColunas: TRBColunasLocaliza);
    procedure EMaterialGargantilhaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ELinerGargantilhaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GProRotuladosKeyPress(Sender: TObject; var Key: Char);
    procedure GProRotuladosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProRotuladosNovaLinha(Sender: TObject);
    procedure GProRotuladosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GProRotuladosGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure EClienteSelect(Sender: TObject);
    procedure GVendaAdicionalCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GVendaAdicionalNovaLinha(Sender: TObject);
    procedure GVendaAdicionalDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GVendaAdicionalGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure GVendaAdicionalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GVendaAdicionalKeyPress(Sender: TObject; var Key: Char);
    procedure GVendaAdicionalMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GVendaAdicionalSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure ECorVendaAdicionalRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EValFreteExit(Sender: TObject);
    procedure EProdutoClienteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GMaquinaClienteDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GMaquinaClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GMaquinaClienteSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EEmbalagemClienteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EAplicacaoClienteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GMaquinaClienteCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GMaquinaClienteMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GMaquinaClienteNovaLinha(Sender: TObject);
    procedure EEmbalagemClienteCadastrar(Sender: TObject);
    procedure EAplicacaoClienteCadastrar(Sender: TObject);
    procedure EProdutoClienteCadastrar(Sender: TObject);
    procedure GCondicoesCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GCondicoesDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GCondicoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECondicaoRetorno(Retorno1, Retorno2: string);
    procedure GCondicoesMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCondicoesNovaLinha(Sender: TObject);
    procedure GCondicoesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GCondicoesCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure GMaterialAcabamentoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GMaterialAcabamentoDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GMaterialAcabamentoDepoisExclusao(Sender: TObject);
    procedure GMaterialAcabamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GMaterialAcabamentoKeyPress(Sender: TObject; var Key: Char);
    procedure GMaterialAcabamentoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GMaterialAcabamentoNovaLinha(Sender: TObject);
    procedure GMaterialAcabamentoSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure GProdutosClick(Sender: TObject);
    procedure ECondicaoPagamentoFimConsulta(Sender: TObject);
    procedure GParcelasCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GParcelasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GParcelasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure GParcelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFormaPagamentoParcelasRetorno(Retorno1, Retorno2: string);
    procedure GParcelasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GParcelasNovaLinha(Sender: TObject);
    procedure ESetorFimConsulta(Sender: TObject);
  private
    { Private declarations }
    VprDProdutoSemQtd : TRBDPropostaProdutoSemQtd;
    VprDProdutoProposta : TRBDPropostaProduto;
    VprDVendaAdicional : TRBDPropostaVendaAdicional;
    VprDAmostraProposta : TRBDPropostaAmostra;
    VprDLocacaoProposta : TRBDPropostaLocacaoCorpo;
    VprDServicoProposta: TRBDPropostaServico;
    VprDProASerRotulado : TRBDPropostaProdutoASerRotulado;
    VprDMaquinasCliente : TRBDPropostaMaquinaCliente;
    VprDMaterialAcabamento: TRBDPropostaMaterialAcabamento;
    VprDParcelas: TRBDPropostaParcelas;
    VprDLocacaoItemProposta: TRBDPropostaLocacaoFranquia;
    VprDCondicaoPagamentoProposta: TRBDPropostaCondicaoPagamento;
    VprDProposta : TRBDPropostaCorpo;
    VprDProspect : TRBDProspect;
    VprDCliente: TRBDCliente;
    VprProdutoAnteriorLocacao,
    VprProdutoAdicionalAnterior,
    VprProdutoAnterior,
    VprProdutoMaterialAcabamentoAnterior: String;
    VprCodFilialChamado,
    VprNumChamado,
    VprAmostraAnterior,
    VprCondicaoPagamentoAnterior,
    VprCodFormaPagamentoAnterior,
    VprOpcaoAtual: Integer;
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    FunProposta : TRBFuncoesProposta;
    FunServico: TFuncoesServico;
    procedure VerificaPermissaoUsuario;
    procedure InicializaTela;
    procedure CarTitulosGrade;
    procedure EstadoBotoes(VpaEstado : Boolean);
    function ExisteProduto : Boolean;
    function ExisteProdutoMaterialAcabamento: Boolean;
    function ExisteProdutoSemQtd : Boolean;
    function ExisteProdutoRotulado : Boolean;
    function ExisteProdutoVendaAdicional : Boolean;
    function ExisteServico: Boolean;
    function ExisteProdutoLocacao: Boolean;
    function ExisteAmostra: Boolean;
    function ExisteCondicaoPagamento: Boolean;
    function Existecor : Boolean;
    function ExisteCorAmostra : Boolean;
    function ExisteUM : Boolean;
    function ExisteUMVendaAdicional:Boolean;
    function ExisteFormaPagamento: Boolean;
    function LocalizaProduto : Boolean;
    function LocalizaProdutoMaterialAcabamento: Boolean;
    function LocalizaProdutoVendaAdicional : Boolean;
    function LocalizaProdutoSemQtd : Boolean;
    function LocalizaProdutoLocacao: Boolean;
    function LocalizaProdutoRotulado : Boolean;
    procedure CarDProspectTela(VpaDProspect : TRBDProspect);
    procedure CarDClienteTela(VpaDCliente: TRBDCliente);
    function CarDClasse : string;
    function CarDClasseAmostra: String;
    function CarDClasseCondicaoPagamento: String;
    function CarDClasseLocacao: String;
    function CarDClasseServicos: String;
    function CarDClasseLocacaoItem: String;
    procedure CarDClasseProdutosRotulados;
    procedure CadDClasseMaquinasCliente;
    procedure CarDChamadoProposta(VpaDChamado : TRBDChamado);
    procedure CarDChamadoExtraProposta(VpaDChamado : TRBDChamado);
    procedure CarDTela;
    procedure CarDGrades;
    procedure CarDProdutoTela;
    procedure CarDProdutoProposta;
    procedure CarDProdutoPropostaMaterialAcabamento;
    procedure CarDPropostaParcelas;
    procedure CarDProdutoSemQtd;
    procedure CarDProdutoVendaAdicinal;
    procedure CarDDesconto;
    procedure CarDFrete;
    procedure CarDDescontoTela;
    procedure CarDValorTotal;
    procedure CalculaValTotalAmostra;
    procedure CalculaValorTotalServico;
    procedure CalculaValorTotalProduto;
    procedure CalculaValorTotalProdutoMaterialAcabamento;
    procedure CalculaValorTotalVendaAdicional;
    procedure CalculaValorTotal;
    procedure DirecionaFoco;
    procedure PosEstagios;
    procedure PosEmails;
    function RColunaGrade(VpaColuna : TRBDColunaGradeProdutos):Integer;
    function RColunaGradeCondicaoPagamento(VpaColuna : TRBDColunaGradeCondicoesPagamento):Integer;
    function RColunaGradeMaterialAcabamento(VpaColuna : TRBDColunaGradeMaterialAcabamento): Integer;
    function RColunaGradeParcelas(VpaColuna: TRBDColunaGradeParcelas): Integer;
  public
    { Public declarations }
    function NovaProposta : Boolean;
    function NovaPropostaCliente(VpaCodCliente: Integer): Boolean;
    procedure ConsultaProposta(VpaCodFilial, VpaSeqProposta : Integer);
    function AlteraProposta(VpaCodfilial,VpaSeqProposta : Integer) : Boolean;
    function NovaPropostaChamado(VpaDChamado : trbdchamado) : Boolean;
    function NovaPropostaChamadoProdutoExtra(VpaDChamado : trbdchamado) : Boolean;
    function Duplicar(VpaCodFilial, VpaSeqProposta: Integer): Boolean;
  end;

var
  FNovaProposta: TFNovaProposta;

implementation

uses APrincipal, FunObjeto, funDAta, ANovoProspect, ConstMsg, FunString,
  ALocalizaProdutos, ACores, FunSql, ANovoServico, AMotivoVenda,
  AConcorrentes, ANovoConcorrente, ANovoCliente, ASetores, AProfissoes,
  ATipoProposta, dmRave, UnDadosProduto, AEmbalagem, AAplicacao,
  ANovoProdutoPro;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaProposta.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VerificaPermissaoUsuario;

  Paginas.ActivePageIndex := 0;
  ScrollBox1.VertScrollBar.Position := 0;
  PaginasProdutoAmostra.ActivePageIndex:= 0;
  if ConfigModulos.Amostra then
    PaginasProdutoAmostra.ActivePage := PAmostras;
  CarTitulosGrade;
  VprDProposta := TRBDPropostaCorpo.cria;
  VprDProspect := TRBDProspect.cria;
  VprDCliente:= TRBDCliente.cria;
  FunProposta := TRBFuncoesProposta.cria(FPrincipal.BaseDados);
  FunServico:= TFuncoesServico.Cria(FPrincipal.BaseDados);
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.Ainfo.UnidadeUN := varia.unidadeUN;
  ValidaUnidade.Ainfo.UnidadeKiT := varia.UnidadeKit;
  ValidaUnidade.Ainfo.UnidadeBarra := varia.UnidadeBarra;
  VprAcao := false;
  EPrevisaoCompra.EditMask := FPrincipal.CorFoco.AMascaraData;
  EPrevisaoVisitaTec.EditMask := FPrincipal.CorFoco.AMascaraData;
  EValidade.EditMask := FPrincipal.CorFoco.AMascaraData;
  if varia.QtdMaximaCaracteresObservacaoProposta > 0 then
    EObservacao.MaxLength := varia.QtdMaximaCaracteresObservacaoProposta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDProposta.free;
  VprDProspect.free;
  VprDCliente.Free;
  FunProposta.free;
  FunServico.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaProposta.VerificaPermissaoUsuario;
begin
  PAmostras.TabVisible := ConfigModulos.Amostra;
  PLocacao.TabVisible:= Config.ManutencaoImpressoras;
  PProdutosRotulados.TabVisible := config.ProdutosRotuladosnaProposta;
  PAmostras.TabVisible := ConfigModulos.Amostra;
  PObsCompras.TabVisible := Config.MostraObsComprasProposta;
  PObsInstalacao.TabVisible:= Config.MostraObsInstalacaoProposta;
  PLocacao.TabVisible := CONFIG.ManutencaoImpressoras;
  PProdutoSemQtd.TabVisible := not config.RotuladorasAutomatizadas;
  PProdutosCliente.TabVisible := config.ProdutosRotuladosnaProposta and Config.DetectoresMetal;
  PDesconto.Visible := config.PermitirDescontoNasPropostas;
end;

{******************************************************************************}
procedure TFNovaProposta.InicializaTela;
begin
  if Varia.EstagioInicialProposta = 0 then
    aviso('ESTAGIO INICIAL PROPOSTA NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações do sistema o estagio inicial da proposta.');
  VprOperacao := ocInsercao;
  VprDProposta.Free;
  VprDProposta := TRBDPropostaCorpo.cria;
  VprDProposta.CodSetor:= Varia.CodSetor;
  VprDProposta.DesObservacao:= Config.ObservacaoPadraoProposta;
  VprDProposta.DesGarantia:= Varia.CRMGarantiaPadrao;
  GProdutos.ADados := VprDProposta.Produtos;
  GProdutos.CarregaGrade;
  GAmostras.ADados:= VprDProposta.Amostras;
  GAmostras.CarregaGrade;
  GLocacao.ADados:= VprDProposta.Locacoes;
  GLocacao.CarregaGrade;
  GServicos.ADados:= VprDProposta.Servicos;
  GServicos.CarregaGrade;
  GProSemQtd.ADados := VprDProposta.ProdutosSemQtd;
  GProSemQtd.CarregaGrade;
  GProRotulados.ADados := VprDProposta.ProdutosASeremRotulados;
  GProRotulados.CarregaGrade;
  GMaquinaCliente.ADados := VprDProposta.MaquinasCliente;
  GMaquinaCliente.CarregaGrade;
  GVendaAdicional.ADados := VprDProposta.VendaAdicinal;
  GVendaAdicional.CarregaGrade;
  GCondicoes.ADados:= VprDProposta.CondicaoPagamento;
  GCondicoes.CarregaGrade;
  GMaterialAcabamento.ADados:= VprDProposta.MaterialAcabamento;
  GMaterialAcabamento.CarregaGrade;
  GParcelas.ADados:= VprDProposta.Parcelas;
  GParcelas.CarregaGrade;
  VprDProspect.free;
  VprDProspect :=  TRBDProspect.cria;
  VprDCliente.Free;
  VprDCliente:= TRBDCliente.cria;
  LimpaComponentes(PanelColor5,0);
  with VprDProposta do
  begin
    CodFilial := varia.CodigoEmpFil;
    CodUsuario := varia.CodigoUsuario;
    CodSetor:= Varia.CodSetor;
    IndComprou := false;
    IndComprouConcorrente := false;
    DatValidade := IncDia(date,Varia.DiasValidade);
    DatProposta := now;
    CodEstagio := Varia.EstagioInicialProposta;
    TipFrete := 1;
  end;
  EFilial.AInteiro := VprDProposta.CodFilial;
  EFilial.Atualiza;
  EDatProposta.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDProposta.DatProposta);
  EValidade.Text := FormatDateTime('DD/MM/YYYY',VprDProposta.DatValidade);
  EPrazoEntrega.AValor := 1;
  ESetor.AInteiro:= VprDProposta.CodSetor;
  ESetor.Atualiza;
  EObservacao.Text:= VprDProposta.DesObservacao;
  EGarantia.Text:= VprDProposta.DesGarantia;
  CAcrescimoDesconto.ItemIndex := 1;
  CValorPercentual.ItemIndex := 1;
  CClienteDevolvera.Checked := false;
  if ESetor.Text = '' then
    ActiveControl:= ESetor
  else
    ActiveControl:= ECliente;
  VprOpcaoAtual:= 1;
  EstadoBotoes(true);
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaProposta.CarTitulosGrade;
begin
  GProdutos.Cells[RColunaGrade(clCodProduto),0] := 'Código';
  GProdutos.Cells[RColunaGrade(clNomProduto),0] := 'Produto';
  GProdutos.Cells[RColunaGrade(clCodCor),0] := 'Cor';
  GProdutos.Cells[RColunaGrade(clNomCor),0] := 'Descrição';
  GProdutos.Cells[RColunaGrade(clUn),0] := 'Un';
  GProdutos.Cells[RColunaGrade(clQuantidade),0] := 'Quantidade';
  GProdutos.Cells[RColunaGrade(clValUnitario),0] := 'Valor Unitário';
  GProdutos.Cells[RColunaGrade(clPerMargemLucro),0] := '% Margem';
  GProdutos.Cells[RColunaGrade(clValTotal),0] := 'Valor Total';
  GProdutos.Cells[RColunaGrade(clOpcao),0] := 'Opção';
  GProdutos.Cells[RColunaGrade(clValDesconto),0] := 'Valor Desconto';
  GProdutos.Cells[RColunaGrade(clObs),0] := 'Observação';
  GProdutos.Cells[RColunaGrade(clPerIPI),0] := ' % IPI';
  GProdutos.Cells[RColunaGrade(clValIpi),0]:= 'Valor IPI';


  if not Config.EstoquePorCor then
  begin
    GProdutos.ColWidths[2] := 450;
    GProdutos.ColWidths[3] := -1;
    GProdutos.ColWidths[4] := -1;
    GProdutos.TabStops[3] := false;
    GProdutos.TabStops[4] := false;
  end;

  if not Config.CampoPercentualMargemGradeProdutos then
  begin
    GProdutos.ColWidths[8]:= -1;
    GProdutos.TabStops[8] := false;
  end;

  GAmostras.Cells[1,0]:= 'Código';
  GAmostras.Cells[2,0]:= 'Amostra';
  GAmostras.Cells[3,0]:= 'Código';
  GAmostras.Cells[4,0]:= 'Cor';
  GAmostras.Cells[5,0]:= 'Quantidade';
  GAmostras.Cells[6,0]:= 'Valor Unitário';
  GAmostras.Cells[7,0]:= 'Valor Total';

  GLocacao.Cells[1,0]:= 'Código';
  GLocacao.Cells[2,0]:= 'Produto';
  GLocacao.Cells[3,0]:= 'Descrição E-Mail';
  GLocacaoItem.Cells[1,0]:= 'Valor';
  GLocacaoItem.Cells[2,0]:= 'Franquia P/B';
  GLocacaoItem.Cells[3,0]:= 'Valor Excedente P/B';
  GLocacaoItem.Cells[4,0]:= 'Franquia Colorido';
  GLocacaoItem.Cells[5,0]:= 'Valor Excedente Colorido';

  GServicos.Cells[1,0]:= 'Código';
  GServicos.Cells[2,0]:= 'Serviço';
  GServicos.Cells[3,0]:= 'Quantidade';
  GServicos.Cells[4,0]:= 'Valor Unitário';
  GServicos.Cells[5,0]:= 'Valor Total';

  GProSemQtd.Cells[1,0] := 'Código';
  GProSemQtd.Cells[2,0] := 'Produto';
  GProSemQtd.Cells[3,0] := 'UM';
  GProSemQtd.Cells[4,0] := 'Valor Unitário';

  GProRotulados.Cells[1,0] := 'Código';
  GProRotulados.Cells[2,0] := 'Produto';
  GProRotulados.Cells[3,0] := 'Código';
  GProRotulados.Cells[4,0] := 'Formato';
  GProRotulados.Cells[5,0] := 'Frascos/Hora';
  GProRotulados.Cells[6,0] := 'Código';
  GProRotulados.Cells[7,0] := 'Material Frasco';
  GProRotulados.Cells[8,0] := 'Alt Frasco';
  GProRotulados.Cells[9,0] := 'Lar Frasco';
  GProRotulados.Cells[10,0] := 'Profund Frasco';
  GProRotulados.Cells[11,0] := 'Diametro Frasco';
  GProRotulados.Cells[12,0] := 'Lar Rótulo';
  GProRotulados.Cells[13,0] := 'Alt Rótulo';
  GProRotulados.Cells[14,0] := 'Código';
  GProRotulados.Cells[15,0] := 'Material Rótulo';
  GProRotulados.Cells[16,0] := 'Código';
  GProRotulados.Cells[17,0] := 'Material Liner Rotulo';
  GProRotulados.Cells[18,0] := 'Lar Contra Rótulo';
  GProRotulados.Cells[19,0] := 'Alt Contra Rótulo';
  GProRotulados.Cells[20,0] := 'Código';
  GProRotulados.Cells[21,0] := 'Material Contra Rótulo';
  GProRotulados.Cells[22,0] := 'Código';
  GProRotulados.Cells[23,0] := 'Material Liner Contra Rotulo';
  GProRotulados.Cells[24,0] := 'Lar Gargantilha';
  GProRotulados.Cells[25,0] := 'Alt Gargantilha';
  GProRotulados.Cells[26,0] := 'Código';
  GProRotulados.Cells[27,0] := 'Material Gargantilha';
  GProRotulados.Cells[28,0] := 'Código';
  GProRotulados.Cells[29,0] := 'Material Liner Gargantilha';
  GProRotulados.Cells[30,0] := 'Observação';


  GVendaAdicional.Cells[1,0] := 'Código';
  GVendaAdicional.Cells[2,0] := 'Produto';
  GVendaAdicional.Cells[3,0] := 'Cor';
  GVendaAdicional.Cells[4,0] := 'Descrição';
  GVendaAdicional.Cells[5,0] := 'UM';
  GVendaAdicional.Cells[6,0] := 'Quantidade';
  GVendaAdicional.Cells[7,0] := 'Valor Unitário';
  GVendaAdicional.Cells[8,0] := 'Valor Total';

  GMaquinaCliente.Cells[1,0] := 'Código';
  GMaquinaCliente.Cells[2,0] := 'Produto';
  GMaquinaCliente.Cells[3,0] := 'Código';
  GMaquinaCliente.Cells[4,0] := 'Embalagem';
  GMaquinaCliente.Cells[5,0] := 'Código';
  GMaquinaCliente.Cells[6,0] := 'Aplicação';
  GMaquinaCliente.Cells[7,0] := 'Produção';
  GMaquinaCliente.Cells[8,0] := 'Sentido Passagem';
  GMaquinaCliente.Cells[9,0] := 'Diâmetro Tubo Passagem';
  GMaquinaCliente.Cells[10,0] := 'Observação';

  GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),0] := 'Código';
  GCondicoes.Cells[RColunaGradeCondicaoPagamento(clNomCondicao),0] := 'Condição de Pagamento';

  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto), 0]:= 'Código';
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMANomProduto), 0]:= 'Produto';
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAUn), 0]:= 'UN';
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAQuantidade),0] := 'Quantidade';
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValUnitario),0] := 'Valor Unitário';
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValTotal),0] := 'Valor Total';

  GParcelas.Cells[RColunaGradeParcelas(clFPValor), 0] := 'Valor';
  GParcelas.Cells[RColunaGradeParcelas(clFPCondicao), 0] := 'Condição';
  GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento), 0] := 'Cod. Forma Pagamento';
  GParcelas.Cells[RColunaGradeParcelas(clFPFormaPagamento), 0] := 'Forma Pagamento';
end;

{******************************************************************************}
procedure TFNovaProposta.EstadoBotoes(VpaEstado : Boolean);
begin
  BCadastrar.Enabled := not VpaEstado;
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BImprimir.Enabled := not VpaEstado;
  BEmail.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
function TFNovaProposta.ExisteProduto : Boolean;
begin
  if (GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] <> '') then
  begin
    if GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunProposta.ExisteProduto(GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha],0, VprDProdutoProposta,VprDProposta);
      if result then
      begin
        VprDProdutoProposta.UnidadeParentes.free;
        VprDProdutoProposta.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProdutoProposta.UMOriginal);
        VprProdutoAnterior := VprDProdutoProposta.CodProduto;
        GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] := VprDProdutoProposta.CodProduto;
        GProdutos.Cells[RColunaGrade(clNomProduto),GProdutos.ALinha] := VprDProdutoProposta.NomProduto;
        GProdutos.Cells[RColunaGrade(clUn),GProdutos.ALinha] := VprDProdutoProposta.UM;
        CalculaValorTotalProduto;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaProposta.ExisteProdutoSemQtd : Boolean;
begin
  if (GProSemQtd.Cells[1,GProSemQtd.ALinha] <> '') then
  begin
    result := FunProdutos.ExisteProduto(GProSemQtd.Cells[1,GProSemQtd.ALinha],VprDProdutoSemQtd.SeqProduto,VprDProdutoSemQtd.NomProduto,
                                        VprDProdutoSemQtd.DesUM);
    if result then
    begin
      VprDProdutoSemQtd.UnidadesParentes.free;
      VprDProdutoSemQtd.UnidadesParentes := ValidaUnidade.UnidadesParentes(VprDProdutoSemQtd.DesUM);
      GProSemQtd.Cells[1,GProSemQtd.ALinha] := VprDProdutoSemQtd.CodProduto;
      GProSemQtd.Cells[2,GProSemQtd.ALinha] := VprDProdutoSemQtd.NomProduto;
      GProSemQtd.Cells[3,GProSemQtd.ALinha] := VprDProdutoSemQtd.DesUM;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaProposta.ExisteProdutoRotulado : Boolean;
var
  VpfDesUM : string;
begin
  if (GProRotulados.Cells[1,GProRotulados.ALinha] <> '') then
  begin
    result := FunProdutos.ExisteProduto(GProRotulados.Cells[1,GProRotulados.ALinha],VprDProASerRotulado.SeqProduto,VprDProASerRotulado.NomProduto,
                                        VpfDesUM);
    if result then
    begin
      GProRotulados.Cells[1,GProRotulados.ALinha] := VprDProASerRotulado.CodProduto;
      GProRotulados.Cells[2,GProRotulados.ALinha] := VprDProASerRotulado.NomProduto;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaProposta.ExisteProdutoVendaAdicional : Boolean;
begin
  if (GVendaAdicional.Cells[1,GVendaAdicional.ALinha] <> '') then
  begin
    if GVendaAdicional.Cells[1,GVendaAdicional.ALinha] = VprProdutoAdicionalAnterior then
      result := true
    else
    begin
      result := FunProposta.ExisteProduto(GVendaAdicional.Cells[1,GVendaAdicional.ALinha],VprDVendaAdicional);
      if result then
      begin
        VprDVendaAdicional.UnidadesParentes.free;
        VprDVendaAdicional.UnidadesParentes := ValidaUnidade.UnidadesParentes(VprDVendaAdicional.UMOriginal);
        VprProdutoAdicionalAnterior := VprDVendaAdicional.CodProduto;
        GVendaAdicional.Cells[1,GVendaAdicional.ALinha] := VprDVendaAdicional.CodProduto;
        GVendaAdicional.Cells[2,GVendaAdicional.ALinha] := VprDVendaAdicional.NomProduto;
        GVendaAdicional.Cells[5,GVendaAdicional.ALinha] := VprDVendaAdicional.DesUM;
        CalculaValorTotalVendaAdicional;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaProposta.ExisteAmostra: Boolean;
begin
  Result:= False;
  if GAmostras.Cells[1,GAmostras.ALinha] <> '' then
  begin
    if GAmostras.Cells[1,GAmostras.ALinha] = IntToStr(VprAmostraAnterior) then
      Result:= True
    else
    begin
      Result:= FunProposta.ExisteAmostra(StrToInt(GAmostras.Cells[1,GAmostras.ALinha]),VprDAmostraProposta);
      if Result then
      begin
        VprDAmostraProposta.CodAmostra:= StrToInt(GAmostras.Cells[1,GAmostras.ALinha]);
        VprAmostraAnterior := VprDAmostraProposta.CodAmostra;
        GAmostras.Cells[1,GAmostras.ALinha]:= IntToStr(VprDAmostraProposta.CodAmostra);
        GAmostras.Cells[2,GAmostras.ALinha]:= VprDAmostraProposta.NomAmostra;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.ExisteCondicaoPagamento: Boolean;
begin
  Result:= False;
  if GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha] <> '' then
  begin
    if GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha] = IntToStr(VprCondicaoPagamentoAnterior) then
      Result:= True
    else
    begin
      Result:= FunProposta.ExisteCondicaoPagamento(StrToInt(GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]),VprDCondicaoPagamentoProposta);
      if Result then
      begin
        VprDCondicaoPagamentoProposta.CodCondicao := StrToInt(GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]);
        VprCondicaoPagamentoAnterior := VprDCondicaoPagamentoProposta.CodCondicao;
        GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]:= IntToStr(VprDCondicaoPagamentoProposta.CodCondicao);
        GCondicoes.Cells[RColunaGradeCondicaoPagamento(clNomCondicao),GCondicoes.ALinha]:= VprDCondicaoPagamentoProposta.NomCondicao;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.Existecor : Boolean;
begin
  result := false;
  if (GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.Alinha]<> '') then
  begin
    result := FunProposta.Existecor(GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha],VprDProdutoProposta);
    if result then
    begin
      GProdutos.Cells[RColunaGrade(clNomCor),GProdutos.ALinha] := VprDProdutoProposta.DesCor;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.ExisteCorAmostra: Boolean;
begin
  Result:= False;
  if (GAmostras.Cells[3,GAmostras.Alinha]<> '') then
  begin
    Result:= FunProposta.ExisteCor(GAmostras.Cells[3,GAmostras.ALinha],VprDAmostraProposta.NomCor);
    if Result then
      GAmostras.Cells[4,GAmostras.ALinha]:= VprDAmostraProposta.NomCor;
  end;
end;

{******************************************************************************}
function TFNovaProposta.ExisteFormaPagamento: Boolean;
begin
  Result:= False;
  if GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),GParcelas.ALinha] <> '' then
  begin
    if GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),GParcelas.ALinha] = IntToStr(VprCodFormaPagamentoAnterior) then
      Result:= True
    else
    begin
      Result:= FunProposta.ExisteFormaPagamento(StrToInt(GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),GParcelas.ALinha]),VprDParcelas);
      if Result then
      begin
        VprDParcelas.CodFormaPagamento := StrToInt(GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),GParcelas.ALinha]);
        VprCodFormaPagamentoAnterior := VprDParcelas.CodFormaPagamento;
        GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),GParcelas.ALinha]:= IntToStr(VprDParcelas.CodFormaPagamento);
        GParcelas.Cells[RColunaGradeParcelas(clFPFormaPagamento),GParcelas.ALinha]:= VprDParcelas.DesFormaPagamento;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.ExisteUM : Boolean;
begin
  if (VprDProdutoProposta.UMAnterior = GProdutos.cells[RColunaGrade(clUn),GProdutos.ALinha]) then
    result := true
  else
  begin
    result := (VprDProdutoProposta.UnidadeParentes.IndexOf(GProdutos.Cells[RColunaGrade(clUn),GProdutos.Alinha]) >= 0);
    if result then
    begin
      VprDProdutoProposta.UM := GProdutos.Cells[RColunaGrade(clUn),GProdutos.Alinha];
      VprDProdutoProposta.UMAnterior := VprDProdutoProposta.UM;
      VprDProdutoProposta.ValUnitario := FunProdutos.ValorPelaUnidade(VprDProdutoProposta.UMOriginal,VprDProdutoProposta.UM,VprDProdutoProposta.SeqProduto,
                                               VprDProdutoProposta.ValUnitarioOriginal);
      CalculaValorTotalProduto;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.ExisteUMVendaAdicional:Boolean;
begin
  if (VprDVendaAdicional.UMAnterior = GVendaAdicional.cells[5,GVendaAdicional.ALinha]) then
    result := true
  else
  begin
    result := (VprDVendaAdicional.UnidadesParentes.IndexOf(GVendaAdicional.Cells[5,GVendaAdicional.Alinha]) >= 0);
    if result then
    begin
      VprDVendaAdicional.DesUM := GVendaAdicional.Cells[5,GVendaAdicional.Alinha];
      VprDVendaAdicional.UMAnterior := VprDVendaAdicional.DesUM;
      VprDVendaAdicional.ValUnitario := FunProdutos.ValorPelaUnidade(VprDVendaAdicional.UMOriginal,VprDVendaAdicional.DesUM,VprDVendaAdicional.SeqProduto,
                                               VprDVendaAdicional.ValUnitarioOriginal);
      CalculaValorTotalVendaAdicional;
    end;
  end;
end;


{******************************************************************************}
function  TFNovaProposta.LocalizaProduto : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDProdutoProposta,0); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
    begin
      with VprDProdutoProposta do
      begin
        if Config.CodigoBarras then
        begin
          VprDProdutoProposta.QtdProduto := 1;
          if (UpperCase(VprDProdutoProposta.UM) = 'CX') then
          begin
            VprDProdutoProposta.UM := 'pc';
            VprDProdutoProposta.ValUnitario := FunProdutos.CalculaValorPadrao('cx','pc',VprDProdutoProposta.ValUnitario,IntToStr(VprDProdutoProposta.SeqProduto));
          end;
        end;
        VprDProdutoProposta.UnidadeParentes.free;
        VprDProdutoProposta.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProdutoProposta.UMOriginal);
        VprProdutoAnterior := VprDProdutoProposta.CodProduto;
        GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] := CodProduto;
        GProdutos.Cells[RColunaGrade(clNomProduto),GProdutos.ALinha] := NomProduto;
        GProdutos.Cells[RColunaGrade(clUn),GProdutos.ALinha] := UM;
        if Config.ExportarDescricaoTecnicadoProdutoParaObservacaoGrade then
          GProdutos.Cells[RColunaGrade(clObs), GProdutos.ALinha]:= DesTecnica;
        CalculaValorTotalProduto;
      end;
    end;
end;

{******************************************************************************}
function TFNovaProposta.LocalizaProdutoVendaAdicional : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDVendaAdicional); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
    begin
      with VprDVendaAdicional do
      begin
        UnidadesParentes.free;
        UnidadesParentes := ValidaUnidade.UnidadesParentes(UMOriginal);
        VprProdutoAdicionalAnterior := VprDVendaAdicional.CodProduto;
        GVendaAdicional.Cells[1,GVendaAdicional.ALinha] := CodProduto;
        GVendaAdicional.Cells[2,GVendaAdicional.ALinha] := NomProduto;
        GVendaAdicional.Cells[5,GVendaAdicional.ALinha] := DesUM;
        CalculaValorTotalVendaAdicional;
      end;
    end;
end;

{******************************************************************************}
function  TFNovaProposta.LocalizaProdutoSemQtd : Boolean;
Var
  VpfAux :string;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDProdutoSemQtd.SeqProduto,VprDProdutoSemQtd.CodProduto,
                                             VprDProdutoSemQtd.NomProduto,VprDProdutoSemQtd.DesUM,VpfAux); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    VprDProdutoSemQtd.UnidadesParentes.free;
    VprDProdutoSemQtd.UnidadesParentes := ValidaUnidade.UnidadesParentes(VprDProdutoSemQtd.DesUM);
    GProSemQtd.Cells[1,GProSemQtd.ALinha] := VprDProdutoSemQtd.CodProduto;
    GProSemQtd.Cells[2,GProSemQtd.ALinha] := VprDProdutoSemQtd.NomProduto;
    GProSemQtd.Cells[3,GProSemQtd.ALinha] := VprDProdutoSemQtd.DesUM;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDProspectTela(VpaDProspect : TRBDProspect);
begin
  EProfissao.AInteiro := VprDProspect.CodProfissao;
  EProfissao.Atualiza;
  EContato.Text := VprDProspect.NomContato;
  EEmail.Text := VprDProspect.DesEmailContato;
  EVendedor.AInteiro := VprDProspect.CodVendedor;
  EVendedor.Atualiza;
  ETelefone.Text := VprDProspect.DesFone;
end;

{******************************************************************************}
procedure TFNovaProposta.CalculaValorTotalProduto;
begin
  VprDProdutoProposta.ValIPI:= (((VprDProdutoProposta.ValUnitario * VprDProdutoProposta.QtdProduto) * VprDProdutoProposta.PerIPI) /100);
  GProdutos.Cells[RColunaGrade(clQuantidade),GProdutos.ALinha] := FormatFloat(Varia.MascaraQtd,VprDProdutoProposta.QtdProduto);
  if not Config.ValorUnitarioProdutodaUltimaCompra then
    GProdutos.Cells[RColunaGrade(clValUnitario),GProdutos.ALinha] := FormatFloat(Varia.MascaraValorUnitario,VprDProdutoProposta.ValUnitario)
  else
  begin
    GProdutos.Cells[RColunaGrade(clValUnitario),GProdutos.ALinha] := FormatFloat(Varia.MascaraValorUnitario,FunProdutos.RValorCompra(varia.CodigoEmpFil, VprDProdutoProposta.SeqProduto,VprDProdutoProposta.CodCor));
    VprDProdutoProposta.ValUnitario:= StrToFloat(GProdutos.Cells[RColunaGrade(clValUnitario),GProdutos.ALinha]);
  end;
  if not Config.CampoPercentualMargemGradeProdutos then
    VprDProdutoProposta.ValTotal := (VprDProdutoProposta.ValUnitario * VprDProdutoProposta.QtdProduto) +   VprDProdutoProposta.ValIPI
  else
    VprDProdutoProposta.ValTotal := VprDProdutoProposta.ValUnitario + ((VprDProdutoProposta.ValUnitario * VprDProdutoProposta.QtdProduto)+ VprDProdutoProposta.ValIPI) * VprDProdutoProposta.PerMargemLucro / 100;
  GProdutos.Cells[RColunaGrade(clValTotal),GProdutos.ALinha] := FormatFloat(varia.MascaraValor,VprDProdutoProposta.ValTotal);
  GProdutos.Cells[RColunaGrade(clValDesconto),GProdutos.ALinha] := FormatFloat(varia.MascaraValor,VprDProdutoProposta.ValDesconto);
  GProdutos.Cells[RColunaGrade(clValIpi),GProdutos.ALinha] := FormatFloat(varia.MascaraValor,VprDProdutoProposta.ValIPI);
end;

{******************************************************************************}
procedure TFNovaProposta.CalculaValorTotalProdutoMaterialAcabamento;
begin
  VprDMaterialAcabamento.ValTotal := (VprDMaterialAcabamento.ValUnitario * VprDMaterialAcabamento.Quantidade);
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAQuantidade),GMaterialAcabamento.ALinha] := IntToStr(VprDMaterialAcabamento.Quantidade);
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValUnitario),GMaterialAcabamento.ALinha] := FormatFloat(Varia.MascaraValorUnitario,VprDMaterialAcabamento.ValUnitario);
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValTotal),GMaterialAcabamento.ALinha] := FormatFloat(varia.MascaraValor,VprDMaterialAcabamento.ValTotal);
end;

{******************************************************************************}
procedure TFNovaProposta.CalculaValorTotalVendaAdicional;
begin
  VprDVendaAdicional.ValTotal := VprDVendaAdicional.ValUnitario * VprDVendaAdicional.QtdProduto;
  GVendaAdicional.Cells[6,GVendaAdicional.ALinha] := FormatFloat(Varia.MascaraQtd,VprDVendaAdicional.QtdProduto);
  GVendaAdicional.Cells[7,GVendaAdicional.ALinha] := FormatFloat(Varia.MascaraValorUnitario,VprDVendaAdicional.ValUnitario);
  GVendaAdicional.Cells[8,GVendaAdicional.ALinha] := FormatFloat(varia.MascaraValor,VprDVendaAdicional.ValTotal);
end;

{******************************************************************************}
function TFNovaProposta.CarDClasse : string;
begin
  result := '';
  if (VprDProposta.Produtos.Count = 0) and(VprDProposta.Amostras.Count = 0) and (VprDProposta.Servicos.Count =0)  then
    result := 'PROPOSTA SEM PRODUTOS/AMOSTRA/SERVIÇO!!!'#13'Não foi adicionado nenhum produto/amostra/serviço na proposta.';
  if result = '' then
  begin
    try
      StrToDate(EValidade.text);
    except
      result := 'DATA VALIDADE INVÁLIDA!!!'#13'A data de validade não é uma data válida ou não foi preenchida...';
    end;
    try
      StrToDate(EPrevisaoCompra.text);
    except
      result := 'DATA DE PREVISÃO DE COMPRA INVÁLIDA!!!'#13'A data de previsão de compra não é uma data válida ou não foi preenchida...';
    end;
    if result = '' then
    begin
      if ECondicaoPagamento.AInteiro = 0 then
      begin
        result := CT_CondicaoPagtoNulo;
      end;
    end;
  end;

  if result = '' then
  begin
    with VprDProposta do
    begin
      CodProspect := EProspect.AInteiro;
      CodCliente:= ECliente.AInteiro;
      CodCondicaoPagamento := ECondicaoPagamento.AInteiro;
      CodFormaPagamento := EFormaPagamento.AInteiro;
      CodVendedor := EVendedor.AInteiro;
      CodProfissao := EProfissao.AInteiro;
      CodSetor:= ESetor.AInteiro;
      CodTipoProposta := ETipoProposta.AInteiro;
      NomContato := EContato.Text;
      DesEmail := EEmail.Text;
      DatPrevisaoCompra := StrToDate(EPrevisaoCompra.text);
      if  (EPrevisaoVisitaTec.Text <> '  /  /  ')
      and (EPrevisaoVisitaTec.Text <> '  /  /    ') then
        DatPrevisaoVisitaTec := StrToDate(EPrevisaoVisitaTec.Text)
      else
        DatPrevisaoVisitaTec := 0;
      DatValidade := StrToDate(EValidade.text);
      DesObservacao := EObservacao.Lines.text;
      DesObservacaoComercial := EObservacaoCompras.Lines.Text;
      DesObservacaoInstalacao:= EObsInstalacaoAba.Lines.Text;
      DesObsDataInstalacao:= EObsDataInstalacao.Text;
      CodMotivoVenda := EMotivoCompra.AInteiro;
      CodConcorrente := EConcorrente.AInteiro;
      ValConcorrente := EValConcorrente.AValor;
      QtdPrazoEntrega := EPrazoEntrega.AsInteger;
      TipFrete := ETipFrete.ItemIndex + 1;
      TipHorasInstalacao := ETipHorasInstalacao.ItemIndex + 1;
      IndDevolveraVazio := CClienteDevolvera.Checked;
      IndComprou := CComprou.Checked;
      IndComprouConcorrente := CComprouConcorrente.Checked;
      DesGarantia:=EGarantia.Text;
      CodObsInstalacao:= EObsInstalacao.AInteiro;
      CarDValorTotal;
      CalculaValorTotal;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDTela;
begin
  with VprDProposta do
  begin
    EFilial.AInteiro := CodFilial;
    EFilial.Atualiza;
    ESetor.AInteiro:= CodSetor;
    ESetor.Atualiza;
    ESeqProposta.AInteiro := SeqProposta;
    EDatProposta.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',DatProposta);
    EProspect.AInteiro := CodProspect;
    EProspect.Atualiza;
    ETipoProposta.AInteiro := VprDProposta.CodTipoProposta;
    ETipoProposta.Atualiza;
    ECliente.AInteiro:= CodCliente;
    ECliente.Atualiza;
    EContato.Text := NomContato;
    EProfissao.AInteiro := CodProfissao;
    EProfissao.atualiza;
    EEmail.Text := DesEmail;
    EVendedor.AInteiro := CodVendedor;
    EVendedor.Atualiza;
    ECondicaoPagamento.AInteiro := CodCondicaoPagamento;
    ECondicaoPagamento.Atualiza;
    EFormaPagamento.AInteiro := CodFormaPagamento;
    EFormaPagamento.Atualiza;
    EValTotal.AValor := ValTotal;
    EPrevisaoCompra.Text := FormatDateTime('DD/MM/YYYY',DatPrevisaoCompra);
    if DatPrevisaoVisitaTec <> 0 then
      EPrevisaoVisitaTec.Text := FormatDateTime('DD/MM/YYYY', DatPrevisaoVisitaTec)
    else
      EPrevisaoVisitaTec.Text := '';
    EValidade.Text := FormatDateTime('DD/MM/YYYY',DatValidade);
    EObservacao.Lines.Text := DesObservacao;
    EObservacaoCompras.Lines.Text := DesObservacaoComercial;
    EObsInstalacaoAba.Lines.Text:= DesObservacaoInstalacao;
    EMotivoCompra.AInteiro := CodMotivoVenda;
    EMotivoCompra.Atualiza;
    EConcorrente.AInteiro := CodConcorrente;
    EConcorrente.Atualiza;
    EValConcorrente.AValor := ValConcorrente;
    EPrazoEntrega.AsInteger := QtdPrazoEntrega;
    ETipFrete.ItemIndex := TipFrete - 1;
    ETipHorasInstalacao.ItemIndex := TipHorasInstalacao - 1;
    CClienteDevolvera.Checked := IndDevolveraVazio;
    CComprou.Checked := IndComprou;
    CComprouConcorrente.Checked := IndComprouConcorrente;
    EGarantia.Text:= DesGarantia;
    EObsInstalacao.AInteiro:= CodObsInstalacao;
    EObsInstalacao.Atualiza;
    EObsDataInstalacao.Text:= DesObsDataInstalacao;
    GProdutos.ADados:= Produtos;
    GProdutos.CarregaGrade;
    GServicos.ADados:= Servicos;
    GServicos.CarregaGrade;
    GProRotulados.ADados:= ProdutosASeremRotulados;
    GProRotulados.CarregaGrade;
    GVendaAdicional.ADados:= VendaAdicinal;
    GVendaAdicional.CarregaGrade;
    GMaterialAcabamento.ADados:= MaterialAcabamento;
    GMaterialAcabamento.CarregaGrade;
    GParcelas.ADados:= Parcelas;
    GParcelas.CarregaGrade;
    CarDProdutoTela;
    CarDDescontoTela;
    EValFrete.AValor := ValFrete;
    ETotalProdutos.AValor:= ValTotalProdutos;
    ETotalIPI.AValor:= ValTotalIpi;

  end;
  FunProspect.CarDProspect(VprDProspect,EProspect.AInteiro);
  VprDCliente.CodCliente:= VprDProposta.CodCliente;
  FunClientes.CarDCliente(VprDCliente);
  if VprDProposta.CodCliente <> 0 then
  begin
    PCliente.Visible:= True;
    ActiveControl:= ECliente;
  end
  else
  begin
    PProspect.Visible:= True;
    ActiveControl:= EProspect;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDGrades;
begin
  GProdutos.ADados := VprDProposta.Produtos;
  GAmostras.ADados := VprDProposta.Amostras;
  GLocacao.ADados:= VprDProposta.Locacoes;
  GServicos.ADados:= VprDProposta.Servicos;
  GProSemQtd.ADados := VprDProposta.ProdutosSemQtd;
  GProRotulados.ADados := VprDProposta.ProdutosASeremRotulados;
  GMaquinaCliente.ADados := VprDProposta.MaquinasCliente;
  GVendaAdicional.ADados := VprDProposta.VendaAdicinal;
  GCondicoes.ADados:= VprDProposta.CondicaoPagamento;
  GMaterialAcabamento.ADados:= VprDProposta.MaterialAcabamento;
  GParcelas.ADados:= VprDProposta.Parcelas;
  GProdutos.CarregaGrade;
  GAmostras.CarregaGrade;
  GLocacao.CarregaGrade;
  GServicos.CarregaGrade;
  GProSemQtd.CarregaGrade;
  GProRotulados.CarregaGrade;
  GMaquinaCliente.CarregaGrade;
  GVendaAdicional.CarregaGrade;
  GCondicoes.CarregaGrade;
  GMaterialAcabamento.CarregaGrade;
  GParcelas.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDProdutoTela;
var
  VpfCodProduto, VpfNomProduto : String;
begin
  FunProdutos.CarCodNomProduto(VprDProposta.SeqProdutoInteresse,VpfCodProduto,VpfNomProduto);
  eproduto.Text := VpfCodProduto;
  LNomProduto.Caption := VpfNomProduto;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDProdutoProposta;
begin
  VprDProdutoProposta.CodProduto := GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.Alinha];
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDProdutoProposta.NomProduto := GProdutos.Cells[RColunaGrade(clNomProduto),GProdutos.ALinha];

  if GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha] <> '' then
    VprDProdutoProposta.CodCor := StrToInt(GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.Alinha])
  else
    VprDProdutoProposta.CodCor := 0;
  VprDProdutoProposta.DesCor := GProdutos.Cells[RColunaGrade(clNomCor),GProdutos.ALinha];
  VprDProdutoProposta.UM := GProdutos.Cells[RColunaGrade(clUn),GProdutos.ALinha];
  VprDProdutoProposta.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clQuantidade),GProdutos.ALinha],'.'));
  VprDProdutoProposta.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clValUnitario),GProdutos.ALinha],'.'));
  if Config.CampoPercentualMargemGradeProdutos then
    VprDProdutoProposta.PerMargemLucro:= StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clPerMargemLucro),GProdutos.ALinha],'.'))
  else
    VprDProdutoProposta.PerMargemLucro:= 0;
  VprDProdutoProposta.ValDesconto := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clValDesconto),GProdutos.ALinha],'.'));
  if GProdutos.Cells[RColunaGrade(clPerIPI),GProdutos.ALinha] <> '' then
    VprDProdutoProposta.PerIPI := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clPerIPI),GProdutos.ALinha],'.'))
  else
    VprDProdutoProposta.PerIPI := 0;

  if GProdutos.Cells[RColunaGrade(clValIpi),GProdutos.ALinha] <> '' then
    VprDProdutoProposta.ValIPI := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clValIpi),GProdutos.ALinha],'.'))
  else
    VprDProdutoProposta.ValIPI := 0;
  CalculaValorTotalProduto;
  if GProdutos.Cells[RColunaGrade(clOpcao),GProdutos.ALinha] <> '' then
    VprDProdutoProposta.NumOpcao := StrToInt(GProdutos.Cells[RColunaGrade(clOpcao),GProdutos.Alinha])
  else
    VprDProdutoProposta.NumOpcao := 0;
  VprOpcaoAtual := VprDProdutoProposta.NumOpcao;
  VprDProdutoProposta.DesObservacaoProduto := GProdutos.Cells[RColunaGrade(clObs),GProdutos.ALinha];
end;

{******************************************************************************}
procedure TFNovaProposta.CarDProdutoPropostaMaterialAcabamento;
begin
  VprDMaterialAcabamento.CodProduto := GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clmaCodProduto),GMaterialAcabamento.Alinha];
  VprDMaterialAcabamento.NomProduto := GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMANomProduto),GMaterialAcabamento.ALinha];
  VprDMaterialAcabamento.UM := GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAUn),GMaterialAcabamento.ALinha];
  VprDMaterialAcabamento.Quantidade := StrToInt(DeletaChars(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAQuantidade),GMaterialAcabamento.ALinha],'.'));
  VprDMaterialAcabamento.ValUnitario := StrToFloat(DeletaChars(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValUnitario),GMaterialAcabamento.ALinha],'.'));
  CalculaValorTotalProdutoMaterialAcabamento;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDProdutoSemQtd;
begin
  VprDProdutoSemQtd.CodProduto := GProSemQtd.Cells[1,GProSemQtd.Alinha];
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDProdutoSemQtd.NomProduto := GProSemQtd.Cells[2,GProSemQtd.ALinha];
  VprDProdutoSemQtd.DesUM := GProSemQtd.Cells[3,GProSemQtd.ALinha];
  VprDProdutoSemQtd.ValUnitario := StrToFloat(DeletaChars(GProSemQtd.Cells[4,GProSemQtd.ALinha],'.'));
end;

{******************************************************************************}
procedure TFNovaProposta.CarDProdutoVendaAdicinal;
begin
  VprDVendaAdicional.CodProduto := GVendaAdicional.Cells[1,GVendaAdicional.Alinha];

  if GVendaAdicional.Cells[3,GVendaAdicional.ALinha] <> '' then
    VprDVendaAdicional.CodCor := StrToInt(GVendaAdicional.Cells[3,GVendaAdicional.Alinha])
  else
    VprDVendaAdicional.CodCor := 0;
  VprDVendaAdicional.NomCor := GVendaAdicional.Cells[4,GVendaAdicional.ALinha];
  VprDVendaAdicional.DesUM := GVendaAdicional.Cells[5,GVendaAdicional.ALinha];
  VprDVendaAdicional.QtdProduto := StrToFloat(DeletaChars(GVendaAdicional.Cells[6,GVendaAdicional.ALinha],'.'));
  VprDVendaAdicional.ValUnitario := StrToFloat(DeletaChars(GVendaAdicional.Cells[7,GVendaAdicional.ALinha],'.'));
  CalculaValorTotalVendaAdicional;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDPropostaParcelas;
begin
  VprDParcelas.CodFormaPagamento:= StrToInt(GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),GParcelas.ALinha]);
  VprDParcelas.DesFormaPagamento := GParcelas.Cells[RColunaGradeParcelas(clFPFormaPagamento),GParcelas.ALinha];
end;

{******************************************************************************}
procedure TFNovaProposta.CarDDesconto;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    with VprDProposta do
    begin
      PerDesconto := 0;
      ValDesconto := 0;
      if CValorPercentual.ItemIndex = 0 then //valor
      begin
        ValDesconto := EDesconto.AValor;
        if (CAcrescimoDesconto.ItemIndex = 0) then
          ValDesconto := ValDesconto * (-1);
      end
      else
        if CValorPercentual.ItemIndex = 1 then //percentual
        begin
          PerDesconto := EDesconto.AValor;
          if (CAcrescimoDesconto.ItemIndex = 0) then
            PerDesconto := PerDesconto * (-1);
        end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDDescontoTela;
begin
  EDesconto.AValor := 0;
  if VprDProposta.ValDesconto > 0 then
  begin
    EDesconto.AValor := VprDProposta.ValDesconto;
    CAcrescimoDesconto.ItemIndex := 1;
    CValorPercentual.ItemIndex := 0;
  end
  else
    if VprDProposta.ValDesconto < 0 then
    begin
      EDesconto.AValor := VprDProposta.ValDesconto * -1;
      CAcrescimoDesconto.ItemIndex := 0;
      CValorPercentual.ItemIndex := 0;
    end
    else
      if VprDProposta.PerDesconto > 0 then
      begin
        EDesconto.AValor := VprDProposta.PerDesconto ;
        CAcrescimoDesconto.ItemIndex := 1;
        CValorPercentual.ItemIndex := 1;
      end
      else
        if VprDProposta.PerDesconto > 0 then
        begin
          EDesconto.AValor := VprDProposta.PerDesconto *-1;
          CAcrescimoDesconto.ItemIndex := 1;
          CValorPercentual.ItemIndex := 1;
        end;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDFrete;
begin
  VprDProposta.valFrete := EValFrete.AValor;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDValorTotal;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    with VprDProposta do
    begin
      CarDDesconto;
      CodCondicaoPagamento := ECondicaoPagamento.AInteiro;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.CalculaValTotalAmostra;
begin
  if GAmostras.Cells[5,GAmostras.ALinha] = '' then
    VprDAmostraProposta.QtdAmostra:= 0
  else
    VprDAmostraProposta.QtdAmostra:= StrToFloat(DeletaChars(GAmostras.Cells[5,GAmostras.ALinha],'.'));
  if GAmostras.Cells[6,GAmostras.ALinha] = '' then
    VprDAmostraProposta.ValUnitario:= 0
  else
    VprDAmostraProposta.ValUnitario:= StrToFloat(DeletaChars(GAmostras.Cells[6,GAmostras.ALinha],'.'));
  VprDAmostraProposta.ValTotal := VprDAmostraProposta.QtdAmostra * VprDAmostraProposta.ValUnitario;
  GAmostras.Cells[7,GAmostras.ALinha]:= FormatFloat(varia.MascaraValor,VprDAmostraProposta.ValTotal);
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaProposta.CadDClasseMaquinasCliente;
begin
  VprDMaquinasCliente.CodFilial := Varia.CodigoFilial;
  VprDMaquinasCliente.SeqProposta := ESeqProposta.AInteiro;
  VprDMaquinasCliente.SeqItem := GMaquinaCliente.ALinha;

  if GMaquinaCliente.Cells[1,GMaquinaCliente.ALinha] <> '' then
    VprDMaquinasCliente.SeqProduto := StrToInt(GMaquinaCliente.Cells[1,GMaquinaCliente.ALinha])
  else
    VprDMaquinasCliente.SeqProduto := 0;

  if GMaquinaCliente.Cells[3,GMaquinaCliente.ALinha] <> '' then
    VprDMaquinasCliente.CodEmbalagem := StrToInt(GMaquinaCliente.Cells[3,GMaquinaCliente.ALinha])
  else
    VprDMaquinasCliente.CodEmbalagem :=0;

  if GMaquinaCliente.Cells[5,GMaquinaCliente.ALinha] <> '' then
    VprDMaquinasCliente.CodAplicacao := StrToInt(GMaquinaCliente.Cells[5,GMaquinaCliente.ALinha])
  else
    VprDMaquinasCliente.CodAplicacao :=0;

  VprDMaquinasCliente.DesProducao := GMaquinaCliente.Cells[7,GMaquinaCliente.ALinha];
  VprDMaquinasCliente.DesSentidoPassagem := GMaquinaCliente.Cells[8,GMaquinaCliente.ALinha];
  VprDMaquinasCliente.DesDiametroCubo := GMaquinaCliente.Cells[9,GMaquinaCliente.ALinha];
  VprDMaquinasCliente.DesObservacao := GMaquinaCliente.Cells[10,GMaquinaCliente.ALinha];
end;

{******************************************************************************}
procedure TFNovaProposta.CalculaValorTotal;
begin
  CarDValorTotal;
  FunProposta.CalculaValorTotal(VprDProposta);
  if GParcelas.Cells[RColunaGradeParcelas(clFPValor), 1] <> '' then
    FunProposta.CalCulaValorParcelas(VprDProposta);
  EValTotal.text := FormatFloat(varia.MascaraValor,VprDProposta.ValTotal);
  ETotalProdutos.Text:= FormatFloat(varia.MascaraValor,VprDProposta.ValTotalProdutos);
  ETotalIPI.Text:= FormatFloat(varia.MascaraValor,VprDProposta.ValTotalIpi);
  GParcelas.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaProposta.DirecionaFoco;
begin
  if GProdutos.Focused then
    EPrazoEntrega.SetFocus
  else
    GProdutos.SetFocus;
end;
{******************************************************************************}
function TFNovaProposta.Duplicar(VpaCodFilial,
  VpaSeqProposta: Integer): Boolean;
begin
  VprOperacao:= ocConsulta;
  FunProposta.CarDProposta(VprDProposta,VpaCodFilial,VpaSeqProposta);
  VprDProposta.SeqProposta:= 0;
  VprDProposta.DatProposta:= now;
  VprDProposta.DatValidade:= 0;
  VprDProposta.DatPrevisaoCompra:= 0;
  VprDProposta.CodEstagio:= varia.EstagioInicialProposta;
  CarDTela;
  EstadoBotoes(true);
  VprOperacao:= ocInsercao;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaProposta.PosEstagios;
begin
  if VprDProposta.SeqProposta <> 0 then
  begin
    AdicionaSQLAbreTabela(EstagiosProposta,'select PRO.CODESTAGIO,PRO.DATESTAGIO, PRO.DESMOTIVO, PRO.DESLOG, ' +
                                          ' EST.NOMEST, '+
                                          ' USU.C_NOM_USU ' +
                                          ' from ESTAGIOPROPOSTA PRO, ESTAGIOPRODUCAO EST, CADUSUARIOS USU '+
                                          ' Where PRO.CODESTAGIO = EST.CODEST '+
                                          ' AND PRO.CODUSUARIO = USU.I_COD_USU '+
                                          ' AND PRO.CODFILIAL = ' +IntToStr(VprDProposta.CodFilial)+
                                          ' AND PRO.SEQPROPOSTA = '+IntToStr(VprDProposta.SeqProposta)+
                                          ' ORDER BY PRO.DATESTAGIO');
  end;
end;

{******************************************************************************}
function TFNovaProposta.RColunaGrade(VpaColuna: TRBDColunaGradeProdutos): Integer;
begin
  case VpaColuna of
    clCodProduto: result:=1;
    clNomProduto: result:=2;
    clCodCor: result:=3;
    clNomCor: result:=4;
    clUn: result:=5;
    clQuantidade: result:=6;
    clValUnitario: result:=7;
    clPerMargemLucro: result:=8;
    clValTotal: result:=9;
    clOpcao: result:=10;
    clValDesconto: result:=11;
    clPerIPI: result:=12;
    clValIpi: Result:= 13;
    clObs: result:=14;
  end;
end;

{******************************************************************************}
function TFNovaProposta.RColunaGradeCondicaoPagamento(
  VpaColuna: TRBDColunaGradeCondicoesPagamento): Integer;
begin
  case VpaColuna of
    clIndAprovado: result:= 1;
    clCodCondicao: result:= 2;
    clNomCondicao: result:= 3;
  end;
end;

{******************************************************************************}
function TFNovaProposta.RColunaGradeParcelas(VpaColuna: TRBDColunaGradeParcelas): Integer;
begin
  case VpaColuna of
    clFPValor: result := 1;
    clFPCondicao: result := 2;
//    clFPDatPagamento: result := 2;
    clFPCodFormaPagamento: result := 3;
    clFPFormaPagamento: result := 4;
  end;
end;

{******************************************************************************}
function TFNovaProposta.RColunaGradeMaterialAcabamento(VpaColuna: TRBDColunaGradeMaterialAcabamento): Integer;
begin
  case VpaColuna of
    clMACodProduto: result:= 1 ;
    clMANomProduto: result:= 2;
    clMAUn: result:= 3;
    clMAQuantidade: result:= 4;
    clMAValUnitario: result:=5;
    clMAValTotal: result:= 6;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.PosEmails;
begin
  PROPOSTAEMAIL.sql.clear;
  Propostaemail.sql.add('SELECT PPE.DATEMAIL, PPE.DESEMAIL, USU.C_NOM_USU'+
                                      ' FROM PROPOSTAEMAIL PPE, CADUSUARIOS USU'+
                                      ' WHERE USU.I_COD_USU = PPE.CODUSUARIO'+
                                      ' AND PPE.SEQPROPOSTA = '+IntToStr(VprDProposta.SeqProposta));
  Propostaemail.sql.add(' ORDER BY PPE.DATEMAIL');
  GradeEmails.ALinhaSQLOrderBy:= PROPOSTAEMAIL.SQL.Count-1;
  PROPOSTAEMAIL.Open;
end;

{******************************************************************************}
function TFNovaProposta.NovaProposta : Boolean;
begin
  PCliente.Visible:= True;
  InicializaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaProposta.ConsultaProposta(VpaCodFilial, VpaSeqProposta : Integer);
begin
  VprOperacao := ocConsulta;
  FunProposta.CarDProposta(VprDProposta,VpaCodFilial,VpaSeqProposta);
  CarDTela;
  CarDGrades;
  AlteraReadOnlyDet(ScrollBox1,0,true);
  EstadoBotoes(false);
  showmodal;
end;

{******************************************************************************}
function TFNovaProposta.AlteraProposta(VpaCodfilial,VpaSeqProposta : Integer) : Boolean;
begin
  VprOperacao := ocConsulta;
  FunProposta.CarDProposta(VprDProposta,VpaCodFilial,VpaSeqProposta);
  CarDTela;
  CarDGrades;
  VprOperacao := ocEdicao;
  EstadoBotoes(true);
  ValidaGravacao1.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovaProposta.NovaPropostaChamado(VpaDChamado : trbdchamado) : Boolean;
begin
  VprCodFilialChamado := VpaDChamado.CodFilial;
  VprNumChamado := VpaDChamado.NumChamado;
  if varia.CodSetorTecnica = 0 then
    aviso('SETOR TÉCNICA NÃO PREENCHIDO!!!'#13'É necessário preencher que o setor técnica nas configurações do sistema na página chamados.');
  PCliente.Visible:= True;
  InicializaTela;
  CarDChamadoProposta(VpaDChamado);
  GProdutos.CarregaGrade;
  GServicos.CarregaGrade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaProposta.NovaPropostaChamadoProdutoExtra(VpaDChamado : trbdchamado) : Boolean;
begin
  VprCodFilialChamado := VpaDChamado.CodFilial;
  VprNumChamado := VpaDChamado.NumChamado;
  if varia.CodSetorTecnica = 0 then
    aviso('SETOR TÉCNICA NÃO PREENCHIDO!!!'#13'É necessário preencher que o setor técnica nas configurações do sistema na página chamados.');
  PCliente.Visible:= True;
  InicializaTela;
  CarDChamadoExtraProposta(VpaDChamado);
  GProdutos.CarregaGrade;
  GServicos.CarregaGrade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaProposta.EProspectCadastrar(Sender: TObject);
begin
  FNovoProspect := TFNovoProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProspect'));
  FNovoProspect.Prospect.Insert;
  FNovoProspect.showmodal;
  FNovoProspect.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaProposta.EProspectFimConsulta(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VprDProposta.CodProspect <> EProspect.AInteiro then
    begin
      VprDProposta.CodProspect := EProspect.AInteiro;
      FunProspect.CarDProspect(VprDProspect,EProspect.AInteiro);
      CarDProspectTela(VprDProspect);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EProdutoClienteCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(Self, '', true);
  FNovoProdutoPro.BNovo.Click;
  FNovoProdutoPro.ShowModal;
  FNovoProdutoPro.Free;
end;

{******************************************************************************}
procedure TFNovaProposta.EProdutoClienteRetorno(VpaColunas: TRBColunasLocaliza);
begin
  VprDMaquinasCliente.SeqProduto := StrToIntDef(VpaColunas.items[0].AValorRetorno, 0);
  GMaquinaCliente.Cells[1,GMaquinaCliente.ALinha] := VpaColunas.items[0].AValorRetorno;
  GMaquinaCliente.Cells[2,GMaquinaCliente.ALinha] := VpaColunas.items[1].AValorRetorno;
end;

{******************************************************************************}
procedure TFNovaProposta.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if Retorno1 <> '' then
      VprDProposta.SeqProdutoInteresse := StrToInt(Retorno1)
    else
      VprDProposta.SeqProdutoInteresse := 0;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProdutoProposta := TRBDPropostaProduto(VprDProposta.Produtos.Items[VpaLinha-1]);
  GProdutos.Cells[RColunaGrade(clCodProduto),VpaLinha] := VprDProdutoProposta.CodProduto;
  GProdutos.Cells[RColunaGrade(clNomProduto),VpaLinha] := VprDProdutoProposta.NomProduto;
  if VprDProdutoProposta.CodCor <> 0 then
    GProdutos.Cells[RColunaGrade(clCodCor),VpaLinha] := IntToStr(VprDProdutoProposta.CodCor)
  else
    GProdutos.Cells[RColunaGrade(clCodCor),VpaLinha] := '';
  GProdutos.Cells[RColunaGrade(clNomCor),VpaLinha] := VprDProdutoProposta.DesCor;
  GProdutos.Cells[RColunaGrade(clUn),VpaLinha] := VprDProdutoProposta.UM;
  CalculaValorTotalProduto;
  if VprDProdutoProposta.NumOpcao <> 0 then
    GProdutos.Cells[RColunaGrade(clOpcao),VpaLinha] := IntToStr(VprDProdutoProposta.NumOpcao)
  else
    GProdutos.Cells[RColunaGrade(clOpcao),VpaLinha] := '';
  GProdutos.Cells[RColunaGrade(clPerIPI), VpaLinha]:= FloatToStr(VprDProdutoProposta.PerIPI);
  GProdutos.Cells[RColunaGrade(clValIpi), VpaLinha]:= FloatToStr(VprDProdutoProposta.ValIPI);
  GProdutos.Cells[RColunaGrade(clObs), VpaLinha]:= VprDProdutoProposta.DesObservacaoProduto;
end;

procedure TFNovaProposta.GProdutosClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GProdutos.col := RColunaGrade(clCodProduto);
    end
    else
      if (GProdutos.Cells[RColunaGrade(clNomProduto),GProdutos.ALinha] = '') then
      begin
        VpaValidos := false;
        aviso(CT_NOMEPRODUTOINVALIDO);
        GProdutos.Col := RColunaGrade(clNomProduto);
      end
      else
      if (GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha] <> '') then
      begin
        if not Existecor then
        begin
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          GProdutos.Col := RColunaGrade(clCodCor);
        end;
      end
      else
        if (VprDProdutoProposta.UnidadeParentes.IndexOf(GProdutos.Cells[RColunaGrade(clUn),GProdutos.Alinha]) < 0) then
        begin
          VpaValidos := false;
          aviso(CT_UNIDADEVAZIA);
          GProdutos.col := RColunaGrade(clUn);
        end
        else
          if (GProdutos.Cells[RColunaGrade(clQuantidade),GProdutos.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso(CT_QTDPRODUTOINVALIDO);
            GProdutos.Col := RColunaGrade(clQuantidade);
          end
          else
            if (GProdutos.Cells[RColunaGrade(clValUnitario),GProdutos.ALinha] = '') then
            begin
              VpaValidos := false;
              aviso(CT_VALORUNITARIOINVALIDO);
              GProdutos.Col := RColunaGrade(clValUnitario);
            end;

  if VpaValidos then
  begin
    CarDProdutoProposta;
    CalculaValorTotal;
    if (VprDProdutoProposta.QtdProduto = 0)  then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GProdutos.col := RColunaGrade(clQuantidade);
    end
    else
      if (VprDProdutoProposta.ValUnitario = 0)  then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        GProdutos.Col := RColunaGrade(clValUnitario);
      end
      else
        if not FunProdutos.VerificaEstoque( VprDProdutoProposta.UM,VprDProdutoProposta.UMOriginal,VprDProdutoProposta.QtdProduto,VprDProdutoProposta.SeqProduto,VprDProdutoProposta.CodCor,0) then
          VpaValidos := false;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosDepoisExclusao(Sender: TObject);
begin
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosEnter(Sender: TObject);
begin
  CarDClasse;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GProdutos.Col of
        1 :  LocalizaProduto;
        3 :  ECor.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.Showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaProposta.ECorEnter(Sender: TObject);
begin
  ECor.clear;
end;

{******************************************************************************}
procedure TFNovaProposta.ECorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha] := ECor.Text;
    GProdutos.Cells[RColunaGrade(clNomCor),GProdutos.ALinha] := Retorno1;
    GProdutos.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = '.') and  not(GProdutos.col in [RColunaGrade(clCodProduto)]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.Produtos.Count >0 then
  begin
    VprDProdutoProposta := TRBDPropostaProduto(VprDProposta.Produtos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDProdutoProposta.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosNovaLinha(Sender: TObject);
begin
  VprDProdutoProposta := VprDProposta.AddProduto;
  VprDProdutoProposta.NumOpcao := VprOpcaoAtual;
end;

{******************************************************************************}
procedure TFNovaProposta.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1: if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] := '';
               GProdutos.Col := RColunaGrade(clCodProduto);
             end;
           end;
        3 : if GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.Alinha] <> '' then
            begin
              if not Existecor then
              begin
                Aviso(CT_CORINEXISTENTE);
                GProdutos.Col := RColunaGrade(clCodCor);
                abort;
              end;
            end;
        5 : if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              GProdutos.col := RColunaGrade(clUn);
              abort;
            end;
        6,7,8,10 :
             begin
               if GProdutos.Cells[RColunaGrade(clQuantidade),GProdutos.ALinha] <> '' then
                 VprDProdutoProposta.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clQuantidade),GProdutos.ALinha],'.'))
               else
                 VprDProdutoProposta.QtdProduto := 0;
               if GProdutos.Cells[RColunaGrade(clValUnitario),GProdutos.ALinha] <> '' then
                 VprDProdutoProposta.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clValUnitario),GProdutos.ALinha],'.'))
               else
                 VprDProdutoProposta.ValUnitario := 0;
               if GProdutos.Cells[RColunaGrade(clPerMargemLucro),GProdutos.ALinha] <> '' then
                 VprDProdutoProposta.PerMargemLucro := StrToFloat(DeletaChars(GProdutos.Cells[RColunaGrade(clPerMargemLucro),GProdutos.ALinha],'.'))
               else
                 VprDProdutoProposta.PerMargemLucro := 0;
               CalculaValorTotalProduto;
             end;
        9 : begin
              if DeletaChars(DeletaChars(DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[RColunaGrade(clValTotal),GProdutos.ALinha],'R'),'$'),'0'),'.'),',') <> '' then
              begin
                if VprDProdutoProposta.ValTotal <> StrToFloat(DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[RColunaGrade(clValTotal),GProdutos.ALinha],'.'),'R'),'$')) then
                begin
                  VprDProdutoProposta.ValTotal := StrToFloat(DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[RColunaGrade(clValTotal),GProdutos.ALinha],'.'),'R'),'$'));
                  VprDProdutoProposta.ValUnitario := VprDProdutoProposta.ValTotal / VprDProdutoProposta.QtdProduto;
                  CalculaValorTotalProduto;
                end;
              end;
            end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaProposta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    Vk_F4 : DirecionaFoco;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EDescontoChange(Sender: TObject);
begin
  if (VprOperacao in [ocInsercao,ocEdicao]) then
  begin
    CarDDesconto;
    CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EEmbalagemClienteCadastrar(Sender: TObject);
begin
  FEmbalagem := TFEmbalagem.CriarSDI(Self, '', true);
  FEmbalagem.BotaoCadastrar1.Click;
  FEmbalagem.ShowModal;
  FEmbalagem.Free;
end;

{******************************************************************************}
procedure TFNovaProposta.EEmbalagemClienteRetorno(VpaColunas: TRBColunasLocaliza);
begin
  VprDMaquinasCliente.CodEmbalagem := StrToIntDef(VpaColunas.items[0].AValorRetorno, 0);
  GMaquinaCliente.Cells[3,GMaquinaCliente.ALinha] := VpaColunas.items[0].AValorRetorno;
  GMaquinaCliente.Cells[4,GMaquinaCliente.ALinha] := VpaColunas.items[1].AValorRetorno;
end;

{******************************************************************************}
procedure TFNovaProposta.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaProposta.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  VpfResultado := CarDClasse;
  if VpfResultado = '' then
  begin
    VpfTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDados.StartTransaction(vpfTransacao);
    VpfResultado := FunProposta.GravaDProposta(VprDProposta);
    if VpfResultado = '' then
    begin
      if VprNumChamado <> 0 then
        VpfREsultado := FunProposta.AdicionaPropostaChamado(VprDProposta.CodFilial,VprDProposta.SeqProposta,VprNumChamado);

    end;
  end;
  if VpfResultado <> '' then
  begin
    if FPrincipal.BaseDados.inTransaction then
      FPrincipal.BaseDados.Rollback(VpfTransacao);
    aviso(VpfResultado)
  end
  else
  begin
   if FPrincipal.BaseDados.inTransaction then
     FPrincipal.BaseDados.Commit(VpfTransacao);
    VprOperacao := ocConsulta;
    ESeqProposta.AInteiro:= VprDProposta.SeqProposta;
    EstadoBotoes(false);
    VprAcao := true;
  end;
  Sistema.SalvaTabelasAbertas;
end;

{******************************************************************************}
procedure TFNovaProposta.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovaProposta.BCadastrarClick(Sender: TObject);
begin
  InicializaTela;
end;

{******************************************************************************}
procedure TFNovaProposta.BEmailClick(Sender: TObject);
var
  VpfResultado : String;
  VpfListaPropostas: TList;
begin
  VpfListaPropostas := FunProposta.CarListaProposta(VprDProposta);
  VpfResultado := FunProposta.EnviaEmailCliente(VpfListaPropostas,VprDCliente);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  VpfListaPropostas.Free;
end;

{******************************************************************************}
procedure TFNovaProposta.EProspectChange(Sender: TObject);
begin
  if VprOperacao in [ocinsercao,ocedicao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaProposta.BImprimirClick(Sender: TObject);
begin
  if VprDProposta.CodFilial <> 0 then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeProposta(VprDProposta.CodFilial,vprDProposta.SeqProposta,true);
    dtRave.Free;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PEstagio then
    PosEstagios
  else
    if Paginas.ActivePage = PEmail then
      PosEmails;
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDAmostraProposta:= TRBDPropostaAmostra(VprDProposta.Amostras.Items[VpaLinha-1]);
  if VprDAmostraProposta.CodAmostra = 0 then
    GAmostras.Cells[1,GAmostras.ALinha]:= ''
  else
    GAmostras.Cells[1,GAmostras.ALinha]:= IntToStr(VprDAmostraProposta.CodAmostra);
  GAmostras.Cells[2,GAmostras.ALinha]:= VprDAmostraProposta.NomAmostra;
  if VprDAmostraProposta.CodCor = 0 then
    GAmostras.Cells[3,GAmostras.ALinha]:= ''
  else
    GAmostras.Cells[3,GAmostras.ALinha]:= IntToStr(VprDAmostraProposta.CodCor);
  GAmostras.Cells[4,GAmostras.ALinha]:= VprDAmostraProposta.NomCor;
  if VprDAmostraProposta.QtdAmostra = 0 then
    GAmostras.Cells[5,GAmostras.ALinha]:= ''
  else
    GAmostras.Cells[5,GAmostras.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDAmostraProposta.QtdAmostra);
  if VprDAmostraProposta.ValUnitario = 0 then
    GAmostras.Cells[6,GAmostras.ALinha]:= ''
  else
    GAmostras.Cells[6,GAmostras.ALinha]:= FormatFloat(varia.MascaraValorUnitario,VprDAmostraProposta.ValUnitario);
  if VprDAmostraProposta.ValTotal = 0 then
    GAmostras.Cells[7,GAmostras.ALinha]:= ''
  else
    GAmostras.Cells[7,GAmostras.ALinha]:= FormatFloat(varia.MascaraValor,VprDAmostraProposta.ValTotal);
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteAmostra then
  begin
    VpaValidos:= False;
    aviso('AMOSTRA NÃO CADASTRADA!!!'#13'É necessário selecionar uma amostra que esteja cadastrada.');
    GAmostras.Col:= 1;
  end
  else
    if not ExisteCorAmostra then
    begin
      VpaValidos:= False;
      aviso('COR NÃO CADASTRADA!!!'#13'É necessário selecionar uma cor que esteja cadastrada.');
      GAmostras.Col:= 3;
    end
    else
      if GAmostras.Cells[5,GAmostras.ALinha] = '' then
      begin
        VpaValidos:= False;
        aviso('QUANTIDADE DA AMOSTRA NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade da amostra.');
        GAmostras.Col:= 5;
      end;
  if VpaValidos then
  begin
    CarDClasseAmostra;
    if VprDAmostraProposta.QtdAmostra = 0 then
    begin
      VpaValidos:= False;
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade da amostra.');
      GAmostras.Col:= 5;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.CarDClasseAmostra: String;
begin
  VprDAmostraProposta.CodAmostra:= StrToInt(GAmostras.Cells[1,GAmostras.ALinha]);
  VprDAmostraProposta.NomAmostra:= GAmostras.Cells[2,GAmostras.ALinha];
  VprDAmostraProposta.CodCor:= StrToInt(GAmostras.Cells[3,GAmostras.ALinha]);
  VprDAmostraProposta.NomCor:= GAmostras.Cells[4,GAmostras.ALinha];
  CalculaValTotalAmostra;
  CalculaValorTotal;
end;

{******************************************************************************}
function TFNovaProposta.CarDClasseCondicaoPagamento: String;
begin
  if GCondicoes.Cells[RColunaGradeCondicaoPagamento(clIndAprovado),GCondicoes.ALinha] = 'S' then
    VprDCondicaoPagamentoProposta.IndAprovado:= True
  else
    VprDCondicaoPagamentoProposta.IndAprovado:= False;
  VprDCondicaoPagamentoProposta.CodCondicao:= StrToInt(GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]);
  VprDCondicaoPagamentoProposta.NomCondicao:= GCondicoes.Cells[RColunaGradeCondicaoPagamento(clNomCondicao),GCondicoes.ALinha];
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1, 3: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    114: case GAmostras.AColuna of
           1: EAmostra.AAbreLocalizacao;
           3: EAmostraCor.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EAmostraRetorno(Retorno1, Retorno2: String);
begin
  if EAmostra.AInteiro <> 0 then
  begin
    if GAmostras.ALinha > 0 then
    begin
      GAmostras.Cells[1,GAmostras.ALinha]:= EAmostra.Text;
      GAmostras.Cells[2,GAmostras.ALinha]:= LNomAmostra.Caption;
      VprDAmostraProposta.DesImagem := Retorno2;
      if Retorno1 <> '' then
        VprDAmostraProposta.CodAmostraIndefinida := StrToInt(Retorno1)
      else
        VprDAmostraProposta.CodAmostraIndefinida := 0;
    end;
  end
  else
    VprDAmostraProposta.CodAmostraIndefinida := 0;
end;

{******************************************************************************}
procedure TFNovaProposta.EAplicacaoClienteCadastrar(Sender: TObject);
begin
  FAplicacao := TFAplicacao.CriarSDI(Self, '', true);
  FAplicacao.BotaoCadastrar.Click;
  FAplicacao.ShowModal;
  FAplicacao.Free;
end;

{******************************************************************************}
procedure TFNovaProposta.EAplicacaoClienteRetorno(VpaColunas: TRBColunasLocaliza);
begin
  VprDMaquinasCliente.CodAplicacao := StrToIntDef(VpaColunas.items[0].AValorRetorno, 0);
  GMaquinaCliente.Cells[5,GMaquinaCliente.ALinha] := VpaColunas.items[0].AValorRetorno;
  GMaquinaCliente.Cells[6,GMaquinaCliente.ALinha] := VpaColunas.items[1].AValorRetorno;
end;

{******************************************************************************}
procedure TFNovaProposta.EAmostraCorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    if GAmostras.ALinha > 0 then
    begin
      GAmostras.Cells[3,GAmostras.ALinha]:= Retorno1;
      GAmostras.Cells[4,GAmostras.ALinha]:= Retorno2;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '.': case GAmostras.AColuna of
           5, 6, 7: Key:= DecimalSeparator;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.Amostras.Count > 0 then
  begin
    VprDAmostraProposta:= TRBDPropostaAmostra(VprDProposta.Amostras.Items[VpaLinhaAtual-1]);
    VprAmostraAnterior:= VprDAmostraProposta.CodAmostra;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasNovaLinha(Sender: TObject);
begin
  VprDAmostraProposta:= VprDProposta.addAmostra;
end;

{******************************************************************************}
procedure TFNovaProposta.GAmostrasSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GAmostras.AEstadoGrade in [egInsercao,EgEdicao] then
    if GAmostras.AColuna <> ACol then
    begin
      case GAmostras.AColuna of
        1: if not ExisteAmostra then
             if not EAmostra.AAbreLocalizacao then
             begin
               GAmostras.Cells[1,GAmostras.ALinha]:= '';
               GAmostras.Col:= 1;
             end;
        3: if not ExisteCorAmostra then
             if not EAmostraCor.AAbreLocalizacao then
             begin
               GAmostras.Cells[3,GAmostras.ALinha]:= '';
               GAmostras.Col:= 3;
             end;
        5,6 : CalculaValTotalAmostra;
        end;
    end;
end;

{******************************************************************************}
procedure TFNovaProposta.GCondicoesCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCondicaoPagamentoProposta:= TRBDPropostaCondicaoPagamento(VprDProposta.CondicaoPagamento.Items[VpaLinha-1]);
  if VprDCondicaoPagamentoProposta.IndAprovado then
    GCondicoes.Cells[RColunaGradeCondicaoPagamento(clIndAprovado),GCondicoes.ALinha]:= '1'
  else
    GCondicoes.Cells[RColunaGradeCondicaoPagamento(clIndAprovado),GCondicoes.ALinha]:= '0';
  if VprDCondicaoPagamentoProposta.CodCondicao = 0 then
    GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]:= ''
  else
    GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]:= IntToStr(VprDCondicaoPagamentoProposta.CodCondicao);
  GCondicoes.Cells[RColunaGradeCondicaoPagamento(clNomCondicao),GCondicoes.ALinha]:= VprDCondicaoPagamentoProposta.NomCondicao;
end;

procedure TFNovaProposta.GCondicoesCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if (GCondicoes.Cells[RColunaGradeCondicaoPagamento(clIndAprovado),VpaLinha] = '0')or (GCondicoes.Cells[RColunaGradeCondicaoPagamento(clIndAprovado),VpaLinha] = '') then
    begin
      GCondicoes.Cells[RColunaGradeCondicaoPagamento(clIndAprovado),VpaLinha] := '1';
      TRBDPropostaCondicaoPagamento(VprDProposta.CondicaoPagamento.Items[VpaLinha-1]).IndAprovado := true;
    end
    else
    begin
      GCondicoes.Cells[RColunaGradeCondicaoPagamento(clIndAprovado),VpaLinha] := '0';
      TRBDPropostaCondicaoPagamento(VprDProposta.CondicaoPagamento.Items[VpaLinha-1]).IndAprovado := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GCondicoesDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteCondicaoPagamento then
  begin
    VpaValidos:= False;
    aviso('CONDIÇÃO DE PAGAMENTO!!!'#13'É necessário selecionar uma condição de pagamento que esteja cadastrada.');
    GCondicoes.Col:= RColunaGradeCondicaoPagamento(clCodCondicao);
  end;

  if VpaValidos then
  begin
    CarDClasseCondicaoPagamento;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GCondicoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    114: case GCondicoes.AColuna of
           2: ECondicao.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GCondicoesMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDProposta.CondicaoPagamento.Count > 0 then
  begin
    VprDCondicaoPagamentoProposta:= TRBDPropostaCondicaoPagamento(VprDProposta.CondicaoPagamento.Items[VpaLinhaAtual-1]);
    VprCondicaoPagamentoAnterior:= VprDCondicaoPagamentoProposta.CodCondicao;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GCondicoesNovaLinha(Sender: TObject);
begin
  VprDCondicaoPagamentoProposta:= VprDProposta.addCondicaoPagamento;
end;

{******************************************************************************}
procedure TFNovaProposta.GCondicoesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GCondicoes.AEstadoGrade in [egInsercao,EgEdicao] then
    if GCondicoes.AColuna <> ACol then
    begin
      case GCondicoes.AColuna of
        2: if not ExisteCondicaoPagamento then
             if not ECondicao.AAbreLocalizacao then
             begin
               GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]:= '';
               GCondicoes.Col:= RColunaGradeCondicaoPagamento(clCodCondicao);
             end;
        end;
    end;
end;

{******************************************************************************}
procedure TFNovaProposta.GParcelasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDParcelas:= TRBDPropostaParcelas(VprDProposta.Parcelas.Items[VpaLinha-1]);
  GParcelas.Cells[RColunaGradeParcelas(clFPValor),VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDParcelas.ValPagamento);
  GParcelas.Cells[RColunaGradeParcelas(clFPCondicao),VpaLinha]:= VprDParcelas.DesCondicao;
  GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),VpaLinha]:= IntToStr(VprDParcelas.CodFormaPagamento);
  GParcelas.Cells[RColunaGradeParcelas(clFPFormaPagamento),VpaLinha]:= VprDParcelas.DesFormaPagamento;
end;

{******************************************************************************}
procedure TFNovaProposta.GParcelasDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteFormaPagamento then
  begin
    VpaValidos:= False;
    aviso('FORMA DE PAGAMENTO INVALIDA!!!'#13'É necessário selecionar uma forma de pagamento que esteja cadastrada.');
    GParcelas.Col:= RColunaGradeParcelas(clFPCodFormaPagamento);
  end;

  if VpaValidos then
    CarDPropostaParcelas;
end;

{******************************************************************************}
procedure TFNovaProposta.GParcelasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      if RColunaGradeParcelas(clFPCodFormaPagamento) =  GParcelas.Col then
      begin
        EFormaPagamentoParcelas.AAbreLocalizacao;
        GParcelas.AEstadoGrade:= egEdicao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if RColunaGradeParcelas(clFPValor)= GParcelas.Col then
    key := #0;
end;

{******************************************************************************}
procedure TFNovaProposta.GParcelasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.Parcelas.Count >0 then
  begin
    VprDParcelas := TRBDPropostaParcelas(VprDProposta.Parcelas.Items[VpaLinhaAtual-1]);
    VprCodFormaPagamentoAnterior:= VprDParcelas.CodFormaPagamento;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GParcelasNovaLinha(Sender: TObject);
begin
 VprDParcelas:= VprDProposta.addParcelas;
end;

{******************************************************************************}
procedure TFNovaProposta.GParcelasSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GParcelas.AEstadoGrade in [egInsercao,EgEdicao] then
    if GParcelas.AColuna <> ACol then
    begin
      if RColunaGradeParcelas(clFPCodFormaPagamento) = GParcelas.Col then
      begin
         if not ExisteFormaPagamento then
         begin
           if not EFormaPagamentoParcelas.AAbreLocalizacao then
           begin
              GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento),GParcelas.ALinha] := '';
              GParcelas.Col := RColunaGradeParcelas(clFPCodFormaPagamento);
           end;
         end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDLocacaoProposta:= TRBDPropostaLocacaoCorpo(VprDProposta.Locacoes.Items[VpaLinha-1]);
  GLocacao.Cells[1,VpaLinha]:= VprDLocacaoProposta.CodProduto;
  GLocacao.Cells[2,VpaLinha]:= VprDLocacaoProposta.NomProduto;
  GLocacao.Cells[3,VpaLinha]:= VprDLocacaoProposta.DesEmail;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteProdutoLocacao then
  begin
    aviso('PRODUTO NÃO CADASTRADO!!!'#13'Informe o código de um produto que esteja cadadastrado');
    VpaValidos:= False;
    GLocacao.Col:= 1;
  end;
  if VpaValidos then
    CarDClasseLocacao;
end;

{******************************************************************************}
function TFNovaProposta.ExisteProdutoLocacao: Boolean;
begin
  Result:= False;
  if GLocacao.Cells[1,GLocacao.ALinha] <> '' then
  begin
    if GLocacao.Cells[1,GLocacao.ALinha] = VprProdutoAnteriorLocacao then
      Result:= True
    else
    begin
      Result:= FunProposta.ExisteProduto(GLocacao.Cells[1,GLocacao.ALinha],VprDLocacaoProposta);
      if Result then
      begin
        VprProdutoAnteriorLocacao:= VprDLocacaoProposta.CodProduto;
        GLocacao.Cells[1,GLocacao.ALinha]:= VprDLocacaoProposta.CodProduto;
        GLocacao.Cells[2,GLocacao.ALinha]:= VprDLocacaoProposta.NomProduto;
        GLocacao.Cells[3,GLocacao.ALinha]:= VprDLocacaoProposta.DesEmail;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.ExisteProdutoMaterialAcabamento: Boolean;
begin
  if (GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto),GMaterialAcabamento.ALinha] <> '') then
  begin
    if GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto),GMaterialAcabamento.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunProposta.ExisteProdutoMaterialAcabamento(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto),GMaterialAcabamento.ALinha], VprDMaterialAcabamento);
      if result then
      begin
        VprProdutoMaterialAcabamentoAnterior := VprDMaterialAcabamento.CodProduto;
        GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clmaCodProduto),GMaterialAcabamento.ALinha] := VprDMaterialAcabamento.CodProduto;
        GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clmaNomProduto),GMaterialAcabamento.ALinha] := VprDMaterialAcabamento.NomProduto;
        GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clmaUn),GMaterialAcabamento.ALinha] := VprDMaterialAcabamento.UM;
        //CalculaValorTotalProdutoMaterialAcabamento;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaProposta.CarDClasseLocacao: String;
begin
  VprDLocacaoProposta.CodProduto:= GLocacao.Cells[1,GLocacao.ALinha];
  VprDLocacaoProposta.NomProduto:= GLocacao.Cells[2,GLocacao.ALinha];
  VprDLocacaoProposta.DesEmail:= GLocacao.Cells[3,GLocacao.ALinha];
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key  of
    114: if GLocacao.AColuna = 1 then
           LocalizaProdutoLocacao;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDProposta.Locacoes.Count > 0 then
  begin
    VprDLocacaoProposta:= TRBDPropostaLocacaoCorpo(VprDProposta.Locacoes.Items[VpaLinhaAtual-1]);
    VprProdutoAnteriorLocacao:= VprDLocacaoProposta.CodProduto;
    GLocacaoItem.Enabled:= True;
    GLocacaoItem.ADados:= VprDLocacaoProposta.Franquias;
    GLocacaoItem.CarregaGrade;
  end
  else
    GLocacaoItem.Enabled:= False;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoNovaLinha(Sender: TObject);
begin
  VprDLocacaoProposta:= VprDProposta.AddLocacao;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GLocacao.AEstadoGrade in [egEdicao, egInsercao] then
  begin
    if ACol <> GLocacao.AColuna then
    begin
      case GLocacao.AColuna of
        1: if not ExisteProdutoLocacao then
             if not LocalizaProdutoLocacao then
             begin
               GLocacao.Cells[1,GLocacao.ALinha]:= '';
               GLocacao.Cells[2,GLocacao.ALinha]:= '';
               GLocacao.Cells[3,GLocacao.ALinha]:= '';
               Abort;
             end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaquinaClienteCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDMaquinasCliente := TRBDPropostaMaquinaCliente(VprDProposta.MaquinasCliente.Items[VpaLinha-1]);
  GMaquinaCliente.Cells[1,VpaLinha] := IntToStr(VprDMaquinasCliente.SeqProduto);
  GMaquinaCliente.Cells[2,VpaLinha] := FunProposta.RNomProduto(VprDMaquinasCliente.SeqProduto);
  if VprDMaquinasCliente.CodEmbalagem <> 0 then
  begin
    GMaquinaCliente.Cells[3,VpaLinha] := IntToStr(VprDMaquinasCliente.CodEmbalagem);
    GMaquinaCliente.Cells[4,VpaLinha] := FunProposta.RNomeEmbalagem(VprDMaquinasCliente.CodEmbalagem);
  end;
  if VprDMaquinasCliente.CodAplicacao <> 0 then
  begin
    GMaquinaCliente.Cells[5,VpaLinha] := IntToStr(VprDMaquinasCliente.CodAplicacao);
    GMaquinaCliente.Cells[6,VpaLinha] := FunProposta.RNomAplicacao(VprDMaquinasCliente.CodAplicacao);
  end;
  GMaquinaCliente.Cells[7,VpaLinha] := VprDMaquinasCliente.DesProducao;
  GMaquinaCliente.Cells[8,VpaLinha] := VprDMaquinasCliente.DesSentidoPassagem;
  GMaquinaCliente.Cells[9,VpaLinha] := VprDMaquinasCliente.DesDiametroCubo;
  GMaquinaCliente.Cells[10,VpaLinha] := VprDMaquinasCliente.DesObservacao;
end;

procedure TFNovaProposta.GMaquinaClienteDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  if not EProdutoCliente.AExisteCodigo(GMaquinaCliente.Cells[1,GMaquinaCliente.ALinha]) then
  begin
    aviso('PRODUTO NÃO CADASTRADO!!!'#13'É necessário informar o código do produto que esteja cadastrado.');
    VpaValidos := False;
    GMaquinaCliente.Col:= 1;
  end else
  begin
    if not EEmbalagemCliente.AExisteCodigo(GMaquinaCliente.Cells[3,GMaquinaCliente.ALinha]) then
    begin
      aviso('EMBALAGEM NÃO ENCONTRADA!!!'#13'É necessário informar o código da embalagem que esteja cadastrado.');
      VpaValidos := False;
      GMaquinaCliente.Col:= 3;
    end else
    begin
      if not EAplicacaoCliente.AExisteCodigo(GMaquinaCliente.Cells[5,GMaquinaCliente.ALinha]) then
      begin
        aviso('APLICAÇÃO NÃO ENCONTRADA!!!'#13'É necessário informar o código da aplicação que esteja cadastrado.');
        VpaValidos := False;
        GMaquinaCliente.Col:= 5;
      end else
      begin
        CadDClasseMaquinasCliente;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaquinaClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GMaquinaCliente.Col of
        1 : EProdutoCliente.AAbreLocalizacao;
        3 : EEmbalagemCliente.AAbreLocalizacao;
        5 : EAplicacaoCliente.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaquinaClienteMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.MaquinasCliente.Count > 0 then
    VprDMaquinasCliente := TRBDPropostaMaquinaCliente(VprDProposta.MaquinasCliente.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovaProposta.GMaquinaClienteNovaLinha(Sender: TObject);
begin
  VprDMaquinasCliente := VprDProposta.addMaquinaCliente;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaquinaClienteSelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
begin
  if GMaquinaCliente.AEstadoGrade in [egInsercao,EgEdicao] then
    if GMaquinaCliente.AColuna <> ACol then
    begin
      case GMaquinaCliente.AColuna of
        1: if not EProdutoCliente.AExisteCodigo(GMaquinaCliente.Cells[1,ARow]) then
           begin
             if not EProdutoCliente.AAbreLocalizacao then
             begin
               GMaquinaCliente.Cells[1,GMaquinaCliente.ALinha]:= '';
               GMaquinaCliente.Col:= 1;
             end;
           end;
        3: if not EEmbalagemCliente.AExisteCodigo(GMaquinaCliente.Cells[3,ARow]) then
           begin
             if not EEmbalagemCliente.AAbreLocalizacao then
             begin
               GMaquinaCliente.Cells[3,GMaquinaCliente.ALinha]:= '';
               GMaquinaCliente.Col:= 3;
             end;
           end;
        5: if not EAplicacaoCliente.AExisteCodigo(GMaquinaCliente.Cells[5,ARow]) then
           begin
             if not EAplicacaoCliente.AAbreLocalizacao then
             begin
               GMaquinaCliente.Cells[5,GMaquinaCliente.ALinha]:= '';
               GMaquinaCliente.Col:= 5;

             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaterialAcabamentoCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDMaterialAcabamento := TRBDPropostaMaterialAcabamento(VprDProposta.MaterialAcabamento.Items[VpaLinha-1]);
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto),VpaLinha] := VprDMaterialAcabamento.CodProduto;
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMANomProduto),VpaLinha] := VprDMaterialAcabamento.NomProduto;
  GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAUn),VpaLinha] := VprDMaterialAcabamento.UM;
  CalculaValorTotalProdutoMaterialAcabamento;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaterialAcabamentoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto),GMaterialAcabamento.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProdutoMaterialAcabamento then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GMaterialAcabamento.col := RColunaGradeMaterialAcabamento(clMACodProduto);
    end
    else
      if (GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMANomProduto),GMaterialAcabamento.ALinha] = '') then
      begin
        VpaValidos := false;
        aviso(CT_NOMEPRODUTOINVALIDO);
        GMaterialAcabamento.Col := RColunaGradeMaterialAcabamento(clMANomProduto);
      end
      else
          if (GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAQuantidade),GMaterialAcabamento.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso(CT_QTDPRODUTOINVALIDO);
            GMaterialAcabamento.Col := RColunaGradeMaterialAcabamento(clMAQuantidade);
          end
          else
            if (GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValUnitario),GMaterialAcabamento.ALinha] = '') then
            begin
              VpaValidos := false;
              aviso(CT_VALORUNITARIOINVALIDO);
              GMaterialAcabamento.Col := RColunaGradeMaterialAcabamento(clMAValUnitario);
            end;

  if VpaValidos then
  begin
    CarDProdutoPropostaMaterialAcabamento;
    CalculaValorTotal;
    if (VprDMaterialAcabamento.Quantidade = 0)  then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GMaterialAcabamento.col := RColunaGradeMaterialAcabamento(clMAQuantidade);
    end
    else
      if (VprDMaterialAcabamento.ValUnitario = 0)  then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        GMaterialAcabamento.Col := RColunaGradeMaterialAcabamento(clMAValUnitario);
      end;
  end;
end;

procedure TFNovaProposta.GMaterialAcabamentoDepoisExclusao(Sender: TObject);
begin
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaterialAcabamentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GMaterialAcabamento.Col of
        1 :  LocalizaProdutoMaterialAcabamento;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaterialAcabamentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = '.') and  not(GMaterialAcabamento.col in [RColunaGradeMaterialAcabamento(clMACodProduto)]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaterialAcabamentoMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.MaterialAcabamento.Count >0 then
  begin
    VprDMaterialAcabamento := TRBDPropostaMaterialAcabamento(VprDProposta.MaterialAcabamento.Items[VpaLinhaAtual-1]);
    VprProdutoMaterialAcabamentoAnterior := VprDMaterialAcabamento.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaterialAcabamentoNovaLinha(Sender: TObject);
begin
  VprDMaterialAcabamento := VprDProposta.addMaterialAcabamento;
end;

{******************************************************************************}
procedure TFNovaProposta.GMaterialAcabamentoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GMaterialAcabamento.AEstadoGrade in [egInsercao,EgEdicao] then
    if GMaterialAcabamento.AColuna <> ACol then
    begin
      case GMaterialAcabamento.AColuna of
        1: if not ExisteProdutoMaterialAcabamento then
           begin
             if not LocalizaProdutoMaterialAcabamento then
             begin
               GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto),GMaterialAcabamento.ALinha] := '';
               GMaterialAcabamento.Col := RColunaGradeMaterialAcabamento(clMACodProduto);
             end;
           end;
        4:
             begin
               if GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAQuantidade),GMaterialAcabamento.ALinha] <> '' then
                 VprDMaterialAcabamento.Quantidade := StrToInt(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAQuantidade),GMaterialAcabamento.ALinha])
               else
                 VprDMaterialAcabamento.Quantidade := 0;
             end;
        5: begin
             if GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValUnitario),GMaterialAcabamento.ALinha] <> '' then
               VprDMaterialAcabamento.ValUnitario := StrToFloat(DeletaChars(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValUnitario),GMaterialAcabamento.ALinha],'.'))
             else
               VprDMaterialAcabamento.ValUnitario := 0;
             CalculaValorTotalProdutoMaterialAcabamento;
           end;

        6 : begin
              if DeletaChars(DeletaChars(DeletaChars(DeletaChars(DeletaChars(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValTotal),GMaterialAcabamento.ALinha],'R'),'$'),'0'),'.'),',') <> '' then
              begin
                if VprDMaterialAcabamento.ValTotal <> StrToFloat(DeletaChars(DeletaChars(DeletaChars(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clmaValTotal),GMaterialAcabamento.ALinha],'.'),'R'),'$')) then
                begin
                  VprDMaterialAcabamento.ValTotal := StrToFloat(DeletaChars(DeletaChars(DeletaChars(GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAValTotal),GMaterialAcabamento.ALinha],'.'),'R'),'$'));
                  VprDMaterialAcabamento.ValUnitario := VprDMaterialAcabamento.ValTotal / VprDMaterialAcabamento.Quantidade;
                  CalculaValorTotalProdutoMaterialAcabamento;
                end;
              end;
            end;
      end;
    end;
end;

{******************************************************************************}
function TFNovaProposta.LocalizaProdutoLocacao: Boolean;
begin
  FLocalizaProduto:= TFlocalizaProduto.criarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDLocacaoProposta);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprProdutoAnteriorLocacao:= VprDLocacaoProposta.CodProduto;
    GLocacao.Cells[1,GLocacao.ALinha]:= VprDLocacaoProposta.CodProduto;
    GLocacao.Cells[2,GLocacao.ALinha]:= VprDLocacaoProposta.NomProduto;
    GLocacao.Cells[3,GLocacao.ALinha]:= VprDLocacaoProposta.DesEmail;
  end;
end;

{******************************************************************************}
function TFNovaProposta.LocalizaProdutoMaterialAcabamento: Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDMaterialAcabamento); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
    begin
      with VprDMaterialAcabamento do
      begin
        if (UpperCase(VprDMaterialAcabamento.UM) = 'CX') then
          begin
            VprDMaterialAcabamento.UM := 'pc';
            VprDMaterialAcabamento.ValUnitario := FunProdutos.CalculaValorPadrao('cx','pc',VprDMaterialAcabamento.ValUnitario,IntToStr(VprDMaterialAcabamento.SeqProduto));
          end;
        VprProdutoMaterialAcabamentoAnterior := VprDMaterialAcabamento.CodProduto;
        GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMACodProduto),GMaterialAcabamento.ALinha] := CodProduto;
        GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMANomProduto),GMaterialAcabamento.ALinha] := NomProduto;
        GMaterialAcabamento.Cells[RColunaGradeMaterialAcabamento(clMAUn),GMaterialAcabamento.ALinha] := UM;
        CalculaValorTotalProdutoMaterialAcabamento;
      end;
    end;
end;

{******************************************************************************}
function TFNovaProposta.LocalizaProdutoRotulado : Boolean;
begin
  FLocalizaProduto:= TFlocalizaProduto.criarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDProASerRotulado);
  FLocalizaProduto.Free;
  if Result then
  begin
    GProRotulados.Cells[1,GProRotulados.ALinha]:= VprDProASerRotulado.CodProduto;
    GProRotulados.Cells[2,GProRotulados.ALinha]:= VprDProASerRotulado.NomProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoItemCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDLocacaoItemProposta:= TRBDPropostaLocacaoFranquia(VprDLocacaoProposta.Franquias.Items[VpaLinha-1]);

  if VprDLocacaoItemProposta.ValFranquia <> 0 then
    GLocacaoItem.Cells[1,GLocacaoItem.ALinha]:= FormatFloat(Varia.MascaraValor,VprDLocacaoItemProposta.ValFranquia)
  else
    GLocacaoItem.Cells[1,GLocacaoItem.ALinha]:= '';
  if VprDLocacaoItemProposta.QtdFranquiaPB <> 0 then
    GLocacaoItem.Cells[2,GLocacaoItem.ALinha]:= IntToStr(VprDLocacaoItemProposta.QtdFranquiaPB)
  else
    GLocacaoItem.Cells[2,GLocacaoItem.ALinha]:= '';
  if VprDLocacaoItemProposta.ValExcedentePB <> 0 then
    GLocacaoItem.Cells[3,GLocacaoItem.ALinha]:= FormatFloat(Varia.MascaraValor,VprDLocacaoItemProposta.ValExcedentePB)
  else
    GLocacaoItem.Cells[3,GLocacaoItem.ALinha]:= '';
  if VprDLocacaoItemProposta.QtdFranquiaColor <> 0 then
    GLocacaoItem.Cells[4,GLocacaoItem.ALinha]:= IntToStr(VprDLocacaoItemProposta.QtdFranquiaColor)
  else
    GLocacaoItem.Cells[4,GLocacaoItem.ALinha]:= '';
  if VprDLocacaoItemProposta.ValExcedenteColor <> 0 then
    GLocacaoItem.Cells[5,GLocacaoItem.ALinha]:= FormatFloat(Varia.MascaraValor,VprDLocacaoItemProposta.ValExcedenteColor)
  else
    GLocacaoItem.Cells[5,GLocacaoItem.ALinha]:= '';
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoItemDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;

  if GLocacaoItem.Cells[3,GLocacaoItem.ALinha] = '' then
  begin
    if GLocacaoItem.Cells[1,GLocacaoItem.ALinha] = '' then
    begin
      aviso('VALOR DA FRANQUIA NÃO PREENCHIDO!!!'#13'É necessário preencher o valor da franquia.');
      VpaValidos:= False;
      GLocacaoItem.Col:= 1;
    end
    else
      if GLocacaoItem.Cells[2,GLocacaoItem.ALinha] = '' then
      begin
        aviso('QUANTIDADE DA FRANQUIA PB NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade da franquia PB.');
        VpaValidos:= False;
        GLocacaoItem.Col:= 2;
      end
      else
        if GLocacaoItem.Cells[3,GLocacaoItem.ALinha] = '' then
        begin
          aviso('VALOR EXCEDENTE PB NÃO PREENCHIDO!!!'#13'É necessário preencher o valor da franquia de cópias PB.');
          VpaValidos:= False;
          GLocacaoItem.Col:= 3;
        end;
  end
  else
  begin
    if GLocacaoItem.Cells[1,GLocacaoItem.ALinha] <> '' then
      if GLocacaoItem.Cells[2,GLocacaoItem.ALinha] = '' then
      begin
        aviso('QUANTIDADE DA FRANQUIA PB NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade da franquia PB.');
        VpaValidos:= False;
        GLocacaoItem.Col:= 2;
      end;
    if GLocacaoItem.Cells[2,GLocacaoItem.ALinha] <> '' then
      if GLocacaoItem.Cells[1,GLocacaoItem.ALinha] = '' then
      begin
        aviso('VALOR DA FRANQUIA NÃO PREENCHIDO!!!'#13'É necessário preencher o valor da franquia.');
        VpaValidos:= False;
        GLocacaoItem.Col:= 1;
      end;
  end;

  if VpaValidos then
    CarDClasseLocacaoItem;
end;

{******************************************************************************}
function TFNovaProposta.CarDClasseLocacaoItem: String;
begin
  if GLocacaoItem.Cells[1,GLocacaoItem.ALinha] <> '' then
    VprDLocacaoItemProposta.ValFranquia:= StrToFloat(DeletaChars(GLocacaoItem.Cells[1,GLocacaoItem.ALinha],'.'))
  else
    VprDLocacaoItemProposta.ValFranquia:= 0;
  if GLocacaoItem.Cells[2,GLocacaoItem.ALinha] <> '' then
    VprDLocacaoItemProposta.QtdFranquiaPB:= StrToInt(GLocacaoItem.Cells[2,GLocacaoItem.ALinha])
  else
    VprDLocacaoItemProposta.QtdFranquiaPB:= 0;
  if GLocacaoItem.Cells[3,GLocacaoItem.ALinha] <> '' then
    VprDLocacaoItemProposta.ValExcedentePB:= StrToFloat(DeletaChars(GLocacaoItem.Cells[3,GLocacaoItem.ALinha],'.'))
  else
    VprDLocacaoItemProposta.ValExcedentePB:= 0;
  if GLocacaoItem.Cells[4,GLocacaoItem.ALinha] <> '' then
    VprDLocacaoItemProposta.QtdFranquiaColor:= StrToInt(GLocacaoItem.Cells[4,GLocacaoItem.ALinha])
  else
    VprDLocacaoItemProposta.QtdFranquiaColor:= 0;
  if GLocacaoItem.Cells[5,GLocacaoItem.ALinha] <> '' then
    VprDLocacaoItemProposta.ValExcedenteColor:= StrToFloat(DeletaChars(GLocacaoItem.Cells[5,GLocacaoItem.ALinha],'.'))
  else
    VprDLocacaoItemProposta.ValExcedenteColor:= 0;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDClasseProdutosRotulados;
begin
  if GProRotulados.Cells[5,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.QtdFrascosHora := StrToFloat(DeletaChars(GProRotulados.Cells[5,GProRotulados.ALinha],'.'))
  else
    VprDProASerRotulado.QtdFrascosHora :=0;

  if GProRotulados.Cells[8,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.AltFrasco := StrToInt(GProRotulados.Cells[8,GProRotulados.ALinha])
  else
    VprDProASerRotulado.AltFrasco:= 0;
  if GProRotulados.Cells[9,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.LarFrasco := StrToInt(GProRotulados.Cells[9,GProRotulados.ALinha])
  else
    VprDProASerRotulado.LarFrasco := 0;
  if GProRotulados.Cells[10,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.ProfundidadeFrasco := StrToInt(GProRotulados.Cells[10,GProRotulados.ALinha])
  else
    VprDProASerRotulado.ProfundidadeFrasco := 0;
  if GProRotulados.Cells[11,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.DiametroFrasco := StrToInt(GProRotulados.Cells[11,GProRotulados.ALinha])
  else
    VprDProASerRotulado.DiametroFrasco := 0;
  if GProRotulados.Cells[12,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.LarRotulo := StrToInt(GProRotulados.Cells[12,GProRotulados.ALinha])
  else
    VprDProASerRotulado.LarRotulo := 0;
  if GProRotulados.Cells[13,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.AltRotulo := StrToInt(GProRotulados.Cells[13,GProRotulados.ALinha])
  else
    VprDProASerRotulado.AltRotulo := 0;
  if GProRotulados.Cells[18,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.LarContraRotulo := StrToInt(GProRotulados.Cells[18,GProRotulados.ALinha])
  else
    VprDProASerRotulado.LarContraRotulo := 0;
  if GProRotulados.Cells[19,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.AltContraRotulo := StrToInt(GProRotulados.Cells[19,GProRotulados.ALinha])
  else
    VprDProASerRotulado.AltContraRotulo := 0;
  if GProRotulados.Cells[24,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.LarGargantilha := StrToInt(GProRotulados.Cells[24,GProRotulados.ALinha])
  else
    VprDProASerRotulado.LarGargantilha := 0;
  if GProRotulados.Cells[25,GProRotulados.ALinha] <> '' then
    VprDProASerRotulado.AltGargantilha := StrToInt(GProRotulados.Cells[25,GProRotulados.ALinha])
  else
    VprDProASerRotulado.AltGargantilha := 0;
    VprDProASerRotulado.ObsProduto:= GProRotulados.Cells[30, GProRotulados.ALinha];
end;

{******************************************************************************}
procedure TFNovaProposta.CarDChamadoProposta(VpaDChamado : TRBDChamado);
Var
  VpfLacoChamadoItem, VpfLacoProduto : Integer;
  VpfDProChamado : trbdchamadoproduto;
  VpfDProOrcado : TRBDChamadoProdutoOrcado;
  VpfDSerOrcado : TRBDChamadoServicoOrcado;
begin
  with VprDProposta do
  begin
    ESetor.AInteiro := varia.CodSetorTecnica;
    ESetor.Atualiza;
    ECliente.AInteiro := VpaDChamado.CodCliente;
    ECliente.Atualiza;
    NomContato := VpaDChamado.NomSolicitante;
    EObsInstalacaoAba.Lines.Text:= VpaDChamado.DesObservacaoGeral;
  end;
  for VpfLacoChamadoItem := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLacoChamadoItem]);
    for VpfLacoProduto := 0 to VpfDProChamado.ProdutosOrcados.Count - 1 do
    begin
      VpfDProOrcado := TRBDChamadoProdutoOrcado(VpfDProChamado.ProdutosOrcados.Items[VpfLacoProduto]);
      VprDProdutoProposta := VprDProposta.addProduto;
      VprDProdutoProposta.SeqProduto := VpfDProOrcado.SeqProduto;
      VprDProdutoProposta.CodProduto := VpfDProOrcado.CodProduto;
      VprDProdutoProposta.NomProduto := VpfDProOrcado.NomProduto;
      VprDProdutoProposta.UM := VpfDProOrcado.DesUM;
      VprDProdutoProposta.UMAnterior := VpfDProOrcado.DesUM;
      VprDProdutoProposta.UMOriginal := VpfDProOrcado.DesUM;
      VprDProdutoProposta.QtdProduto := VpfDProOrcado.Quantidade;
      VprDProdutoProposta.ValUnitario := VpfDProOrcado.ValUnitario;
      VprDProdutoProposta.ValUnitarioOriginal := VpfDProOrcado.ValUnitario;
      VprDProdutoProposta.ValTotal := VpfDProOrcado.ValTotal;
      VprDProdutoProposta.UnidadeParentes := VpfDProOrcado.UnidadesParentes;
      VprDProdutoProposta.SeqItemChamado:= VpfDProChamado.SeqItem;
      VprDProdutoProposta.SeqProdutoChamado:= VpfDProChamado.SeqProduto;
    end;

    for VpfLacoProduto := 0 to VpfDProChamado.ServicosOrcados.Count - 1 do
    begin
      VpfDSerOrcado := TRBDChamadoServicoOrcado(VpfDProChamado.ServicosOrcados.Items[VpfLacoProduto]);
      VprDServicoProposta := VprDProposta.AddServico;
      VprDServicoProposta.CodEmpresaServico := VpfDSerOrcado.CodEmpresaServico;
      VprDServicoProposta.CodServico := VpfDSerOrcado.CodServico;
      VprDServicoProposta.NomServico := VpfDSerOrcado.NomServico;
      VprDServicoProposta.QtdServico := VpfDSerOrcado.QtdServico;
      VprDServicoProposta.ValUnitario := VpfDSerOrcado.ValUnitario;
      VprDServicoProposta.ValTotal := VpfDSerOrcado.ValTotal;
      VprDServicoProposta.SeqItemChamado:= VpfDProChamado.SeqItem;
      VprDServicoProposta.SeqProdutoChamado:= VpfDProChamado.SeqProduto;
    end;
  end;
  if (VpaDChamado.ValChamado <> 0) then
  begin
    if Varia.CodServicoChamado = 0 then
      aviso('CODIGO DO SERVIÇO DO CHAMADO NÃO CONFIGURADO!!!'+#13+'É necessário preencher o codigo do serviço do chamado nas configurações da empresa.')
    else
    begin
      VprDServicoProposta := VprDProposta.AddServico;
      VprDServicoProposta.CodEmpresaServico := varia.CodigoEmpresa;
      FunServico.ExisteServico(Varia.CodServicoChamado,VprDServicoProposta);
      VprDServicoProposta.QtdServico := 1;
      VprDServicoProposta.ValUnitario := VpaDChamado.ValChamado;
      VprDServicoProposta.ValTotal := VpaDChamado.ValChamado;
    end;
  end;
  if (VpaDChamado.ValDeslocamento <> 0) then
  begin
    if Varia.CodServicoDeslocamento = 0 then
      aviso('CODIGO DO SERVIÇO DO DESLOCAMENTO NÃO CONFIGURADO!!!'+#13+'É necessário preencher o codigo do serviço do deslocamento nas configurações da empresa.')
    else
    begin
      VprDServicoProposta := VprDProposta.AddServico;
      VprDServicoProposta.CodEmpresaServico := varia.CodigoEmpresa;
      FunServico.ExisteServico(Varia.CodServicoDeslocamento,VprDServicoProposta);
      VprDServicoProposta.QtdServico := 1;
      VprDServicoProposta.ValUnitario := VpaDChamado.ValDeslocamento;
      VprDServicoProposta.ValTotal := VpaDChamado.ValDeslocamento;
    end;
  end;
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDChamadoExtraProposta(VpaDChamado : TRBDChamado);
Var
  VpfLaco : Integer;
  VpfDProExtra : TRBDChamadoProdutoExtra;
begin
  with VprDProposta do
  begin
    ESetor.AInteiro := varia.CodSetorTecnica;
    ESetor.Atualiza;
    ECliente.AInteiro := VpaDChamado.CodCliente;
    ECliente.Atualiza;
    NomContato := VpaDChamado.NomSolicitante;
  end;
  for VpfLaco := 0 to VpaDChamado.ProdutosExtras.Count - 1 do
  begin
    VpfDProExtra := TRBDChamadoProdutoExtra(VpaDChamado.ProdutosExtras.Items[VpfLaco]);
    VprDProdutoProposta := VprDProposta.addProduto;
    VprDProdutoProposta.SeqProduto := VpfDProExtra.SeqProduto;
    VprDProdutoProposta.CodProduto := VpfDProExtra.CodProduto;
    VprDProdutoProposta.NomProduto := VpfDProExtra.NomProduto;
    VprDProdutoProposta.UM := VpfDProExtra.UM;
    VprDProdutoProposta.UMAnterior := VpfDProExtra.UM;
    VprDProdutoProposta.UMOriginal := VpfDProExtra.UMOriginal;
    VprDProdutoProposta.QtdProduto := VpfDProExtra.QtdBaixado;
//    VprDProdutoProposta.ValUnitario := ;
//    VprDProdutoProposta.ValUnitarioOriginal := VpfDProExtra.ValUnitario;
//    VprDProdutoProposta.ValTotal := VpfDProExtra.ValTotal;
    VprDProdutoProposta.UnidadeParentes := FunProdutos.RUnidadesParentes(VpfDProExtra.UM);
  end;
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoItemGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    2,4: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoItemKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = '.' then
    Key:= DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoItemMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDLocacaoProposta.Franquias.Count > 0 then
    VprDLocacaoItemProposta:= TRBDPropostaLocacaoFranquia(VprDLocacaoProposta.Franquias.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovaProposta.GLocacaoItemNovaLinha(Sender: TObject);
begin
  if VprDLocacaoProposta <> nil then
    VprDLocacaoItemProposta:= VprDLocacaoProposta.AddFranquia;
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDServicoProposta:= TRBDPropostaServico(VprDProposta.Servicos.Items[VpaLinha-1]);
  if VprDServicoProposta.CodServico <> 0 then
    GServicos.Cells[1,VpaLinha]:= IntToStr(VprDServicoProposta.CodServico)
  else
    GServicos.Cells[1,VpaLinha]:= '';
  GServicos.Cells[2,VpaLinha]:= VprDServicoProposta.NomServico;

  if VprDServicoProposta.QtdServico <> 0 then
    GServicos.Cells[3,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDServicoProposta.QtdServico)
  else
    GServicos.Cells[3,VpaLinha]:= '';

  if VprDServicoProposta.ValUnitario <> 0 then
    GServicos.Cells[4,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDServicoProposta.ValUnitario)
  else
    GServicos.Cells[4,VpaLinha]:= '';
  if VprDServicoProposta.ValTotal <> 0 then
    GServicos.Cells[5,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDServicoProposta.ValTotal)
  else
    GServicos.Cells[5,VpaLinha]:= '';
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteServico then
  begin
    aviso('SERVIÇO NÃO CADASTRADO!!!'#13'É necessário informar o código de um serviço que esteja cadastrado.');
    VpaValidos:= False;
    GServicos.Col:= 1;
  end
  else
    if GServicos.Cells[3,GServicos.ALinha] = '' then
    begin
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário informar a quantidade.');
      VpaValidos:= False;
      GServicos.Col:= 3;
    end
    else
      if GServicos.Cells[4,GServicos.ALinha] = '' then
      begin
        aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário informar o valor unitário.');
        VpaValidos:= False;
        GServicos.Col:= 4;
      end;

  if VpaValidos then
  begin
    CarDClasseServicos;
    if VprDServicoProposta.QtdServico = 0 then
    begin
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário informar a quantidade.');
      VpaValidos:= False;
      GServicos.Col:= 3;
    end
    else
      if VprDServicoProposta.ValUnitario = 0 then
      begin
        aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário informar o valor unitário.');
        VpaValidos:= False;
        GServicos.Col:= 4;
      end;      
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.Servicos.Count > 0 then
    VprDServicoProposta:= TRBDPropostaServico(VprDProposta.Servicos.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosNovaLinha(Sender: TObject);
begin
  VprDServicoProposta:= VprDProposta.AddServico;
end;

{******************************************************************************}
function TFNovaProposta.CarDClasseServicos: String;
begin
  if GServicos.Cells[1,GServicos.ALinha] <> '' then
    VprDServicoProposta.CodServico:= StrToInt(GServicos.Cells[1,GServicos.ALinha])
  else
    VprDServicoProposta.CodServico:= 0;
  VprDServicoProposta.NomServico:= GServicos.Cells[2,GServicos.ALinha];

  if GServicos.Cells[3,GServicos.ALinha] <> '' then
    VprDServicoProposta.QtdServico:= StrToFloat(DeletaChars(GServicos.Cells[3,GServicos.ALinha],'.'))
  else
    VprDServicoProposta.QtdServico:= 0;

  if GServicos.Cells[4,GServicos.ALinha] <> '' then
    VprDServicoProposta.ValUnitario:= StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'))
  else
    VprDServicoProposta.ValUnitario:= 0;
  VprDServicoProposta.ValTotal:= VprDServicoProposta.QtdServico * VprDServicoProposta.ValUnitario;
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GServicos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GServicos.AColuna <> ACol then
    begin
      case GServicos.AColuna of
        1: if not ExisteServico then
           begin
             if not EServico.AAbreLocalizacao then
             begin
               GServicos.Cells[1,GServicos.ALinha]:= '';
               GServicos.Col:= 1;
               Abort;
             end;
           end;
        3,4: CalculaValorTotalServico;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaProposta.CalculaValorTotalServico;
begin
  if GServicos.Cells[3,GServicos.ALinha] = '' then
    VprDServicoProposta.QtdServico:= 0
  else
    VprDServicoProposta.QtdServico:= StrToFloat(DeletaChars(GServicos.Cells[3,GServicos.ALinha],'.'));
  if GServicos.Cells[4,GServicos.ALinha] = '' then
    VprDServicoProposta.ValUnitario:= 0
  else
    VprDServicoProposta.ValUnitario:= StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'));
  VprDServicoProposta.ValTotal:= VprDServicoProposta.QtdServico * VprDServicoProposta.ValUnitario;
  GServicos.Cells[5,GServicos.ALinha]:= FormatFloat(varia.MascaraValor,VprDServicoProposta.ValTotal);
  CalculaValorTotal;
end;

{******************************************************************************}
function TFNovaProposta.ExisteServico: Boolean;
begin
  Result:= False;
  if GServicos.Cells[1,GServicos.ALinha] <> '' then
  begin
    Result:= FunServico.ExisteServico(StrToInt(GServicos.Cells[1,GServicos.ALinha]),VprDServicoProposta);
    if Result then
    begin
      GServicos.Cells[2,GServicos.ALinha]:= VprDServicoProposta.NomServico;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EServicoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    // aqui é feita a chamada para a rotina FunServico.ExisteProduto,
    // para poder carregar a classe com dados restantes que não podem ser
    // retornados pelo retorno do EServico
    FunServico.ExisteServico(EServico.AInteiro,VprDServicoProposta);
    GServicos.Cells[1,GServicos.ALinha]:= EServico.Text;
    GServicos.Cells[2,GServicos.ALinha]:= Retorno1;
    if VprDServicoProposta.ValUnitario <> 0 then
      GServicos.Cells[4,GServicos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDServicoProposta.ValUnitario)
    else
      GServicos.Cells[4,GServicos.ALinha]:= '';
    GServicos.AEstadoGrade:= egEdicao;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    114: case GProdutos.Col of
           1: EServico.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GServicosKeyPress(Sender: TObject; var Key: Char);
begin
  case GServicos.AColuna of
    3,4,5: if Key in [',','.'] then
             Key:= DecimalSeparator;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EServicoSelect(Sender: TObject);
begin
  EServico.ASelectValida.Text:= 'SELECT * FROM CADSERVICO'+
                                ' WHERE I_COD_SER = @'+
                                ' AND I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa);
  EServico.ASelectLocaliza.Text:= 'SELECT * FROM CADSERVICO'+
                                  ' WHERE C_NOM_SER LIKE ''@%'''+
                                  ' AND I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                  ' ORDER BY C_NOM_SER';
end;

{******************************************************************************}
procedure TFNovaProposta.EServicoCadastrar(Sender: TObject);
var
  VpfCodClassificacao,
  VpfCodServico,
  VpfDescricao: String;
begin
  FNovoServico:= TFNovoServico.CriarSDI(Application,'',True);
  FNovoServico.InsereNovoServico(VpfCodClassificacao,VpfCodServico,VpfDescricao,True);
  FNovoServico.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaProposta.EMotivoCompraCadastrar(Sender: TObject);
begin
  FMotivoVenda:= TFMotivoVenda.CriarSDI(Application,'',True);
  FMotivoVenda.ShowModal;
  FMotivoVenda.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaProposta.EConcorrenteCadastrar(Sender: TObject);
begin
  FNovoConcorrente := TFNovoConcorrente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoConcorrente'));
  FNovoConcorrente.Concorrente.Insert;
  FNovoConcorrente.showmodal;
  FNovoConcorrente.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaProposta.CComprouClick(Sender: TObject);
begin
  if CComprou.Checked then
    CComprouConcorrente.Checked := false;
end;

{******************************************************************************}
procedure TFNovaProposta.CComprouConcorrenteClick(Sender: TObject);
begin
  if CComprouConcorrente.Checked then
    CComprou.Checked := false;
end;

{******************************************************************************}
procedure TFNovaProposta.EConcorrenteFimConsulta(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    if EConcorrente.AInteiro <> 0 then
      CComprouConcorrente.Checked := true;
end;

{******************************************************************************}
procedure TFNovaProposta.ECondicaoPagamentoFimConsulta(Sender: TObject);
begin
  if VprOperacao in [ocinsercao,ocedicao] then
  begin
    FreeTObjectsList(VprDProposta.Parcelas);
    VprDProposta.CodFormaPagamento := EFormaPagamento.AInteiro;
    FunProposta.CalculaParcelas(ECondicaoPagamento.AInteiro, VprDProposta);
    GParcelas.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.ECondicaoRetorno(Retorno1, Retorno2: string);
begin
  if ECondicao.AInteiro <> 0 then
  begin
    if GCondicoes.ALinha > 0 then
    begin
      GCondicoes.Cells[RColunaGradeCondicaoPagamento(clCodCondicao),GCondicoes.ALinha]:= ECondicao.Text;
      GCondicoes.Cells[RColunaGradeCondicaoPagamento(clNomCondicao),GCondicoes.ALinha]:= LCondicao.Caption;
    end;
  end;
end;

{******************************************************************************}
function TFNovaProposta.NovaPropostaCliente(VpaCodCliente: Integer): Boolean;
begin
  PCliente.Visible:= True;
  InicializaTela;
  ECliente.AInteiro:= VpaCodCliente;
  ECliente.Atualiza;
  Showmodal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovaProposta.EClienteCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.NovoProspect;
  Localiza.AtualizaConsulta;
  FNovoCliente.free;
end;

{******************************************************************************}
procedure TFNovaProposta.EClienteFimConsulta(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VprDProposta.CodCliente <> ECliente.AInteiro then
    begin
      VprDProposta.CodCliente:= ECliente.AInteiro;
      VprDCliente.CodCliente:= ECliente.AInteiro;
      FunClientes.CarDCliente(VprDCliente);
      CarDClienteTela(VprDCliente);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.CarDClienteTela(VpaDCliente: TRBDCliente);
begin
  EProfissao.AInteiro:= VprDCliente.CodProfissao;
  EProfissao.Atualiza;
  EContato.Text:= VprDCliente.NomContato;
  EEmail.Text:= VprDCliente.DesEmail;
  EVendedor.AInteiro:= VprDCliente.CodVendedor;
  EVendedor.Atualiza;
  ETelefone.Text := VprDCliente.DesFone1;
  ECondicaoPagamento.AInteiro:= VprDCliente.CodCondicaoPagamento;
  ECondicaoPagamento.Atualiza;
  EFormaPagamento.AInteiro:= VprDCliente.CodFormaPagamento;
  EFormaPagamento.Atualiza;
  if length(VprDCliente.CepCliente) > 6 then
    insert('-',VprDCliente.CepCliente,6);
  ECEP.Text := VpaDCliente.CepCliente;
end;

{******************************************************************************}
procedure TFNovaProposta.ESetorCadastrar(Sender: TObject);
begin
  FSetores := TFSetores.CriarSDI(self,'',FPrincipal.VerificaPermisao('FSetores'));
  FSetores.BotaoCadastrar1.click;
  FSetores.showmodal;
  FSetores.free;
  Localiza.atualizaconsulta;
end;

{******************************************************************************}
procedure TFNovaProposta.ESetorFimConsulta(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaProposta.EProfissaoCadastrar(Sender: TObject);
begin
  FProfissoes := TFProfissoes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProfissoes'));
  FProfissoes.BotaoCadastrar1.Click;
  FProfissoes.showmodal;
  FProfissoes.free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovaProposta.ESetorRetorno(Retorno1, Retorno2: String);
begin
  if ESetor.AInteiro <> 0 then
  begin
    VprDProposta.CodSetor := ESetor.AInteiro;
    FunProposta.CarDSetorProposta(VprDProposta);
  end;
  if Retorno1 <> '' then
  begin
    EGarantia.Text:= Retorno1;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.ETipoPropostaCadastrar(Sender: TObject);
begin
  FTipoProposta := TFTipoProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTipoProposta'));
  FTipoProposta.BotaoCadastrar1.Click;
  FTipoProposta.showmodal;
  FTipoProposta.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaProposta.EValFreteExit(Sender: TObject);
begin
  if (VprOperacao in [ocInsercao,ocEdicao]) then
  begin
    CarDFrete;
    CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProSemQtdCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProdutoSemQtd := TRBDPropostaProdutoSemQtd(VprDProposta.ProdutosSemQtd.Items[VpaLinha-1]);
  GProSemQtd.Cells[1,VpaLinha] := VprDProdutoSemQtd.CodProduto;
  GProSemQtd.Cells[2,VpaLinha] := VprDProdutoSemQtd.NomProduto;
  GProSemQtd.Cells[3,VpaLinha] := VprDProdutoSemQtd.DesUM;
  GProSemQtd.Cells[4,VpaLinha] := FormatFloat(Varia.MascaraValorUnitario,VprDProdutoSemQtd.ValUnitario);
end;

{******************************************************************************}
procedure TFNovaProposta.GProSemQtdDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GProSemQtd.Cells[1,GProSemQtd.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProdutoSemQtd then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GProSemQtd.col := 1;
    end
    else
      if (GProSemQtd.Cells[2,GProSemQtd.ALinha] = '') then
      begin
        VpaValidos := false;
        aviso(CT_NOMEPRODUTOINVALIDO);
        GProSemQtd.Col := 2;
      end
      else
        if (VprDProdutoSemQtd.UnidadesParentes.IndexOf(GProSemQtd.Cells[3,GProSemQtd.Alinha]) < 0) then
        begin
          VpaValidos := false;
          aviso(CT_UNIDADEVAZIA);
          GProSemQtd.col := 3;
        end
        else
          if (GProSemQtd.Cells[4,GProSemQtd.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso(CT_VALORUNITARIOINVALIDO);
            GProSemQtd.Col := 4;
          end;
  if VpaValidos then
  begin
    CarDProdutoSemQtd;
    if (VprDProdutoSemQtd.ValUnitario = 0)  then
    begin
      VpaValidos := false;
      aviso(CT_VALORUNITARIOINVALIDO);
      GProSemQtd.Col := 4;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProSemQtdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GProSemQtd.Col of
        1 :  LocalizaProdutoSemQtd;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProSemQtdKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = '.') and  not(GProSemQtd.col in [1]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaProposta.GProSemQtdMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.ProdutosSemQtd.Count >0 then
  begin
    VprDProdutoSemQtd := TRBDPropostaProdutoSemQtd(VprDProposta.ProdutosSemQtd.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProSemQtdNovaLinha(Sender: TObject);
begin
  VprDProdutoSemQtd := VprDProposta.addProdutoSemQtd;
end;

{******************************************************************************}
procedure TFNovaProposta.GProSemQtdSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProSemQtd.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProSemQtd.AColuna <> ACol then
    begin
      case GProSemQtd.AColuna of
        1 :if not ExisteProdutoSemQtd then
           begin
             if not LocalizaProdutoSemQtd then
             begin
               GProSemQtd.Cells[1,GProSemQtd.ALinha] := '';
               GProSemQtd.Col := 1;
             end;
           end;
      end;
    end;
end;

procedure TFNovaProposta.GProRotuladosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProASerRotulado := TRBDPropostaProdutoASerRotulado(VprDProposta.ProdutosASeremRotulados.Items[VpaLinha-1]);
  GProRotulados.Cells[1,VpaLinha] := VprDProASerRotulado.CodProduto;
  GProRotulados.Cells[2,VpaLinha] := VprDProASerRotulado.NomProduto;
  if VprDProASerRotulado.CodFormatoFrasco <> 0 then
    GProRotulados.Cells[3,VpaLinha] := IntToStr(VprDProASerRotulado.CodFormatoFrasco)
  else
    GProRotulados.Cells[3,VpaLinha] := '';
  GProRotulados.Cells[4,VpaLinha] := VprDProASerRotulado.NomFormatoFrasco;

  if VprDProASerRotulado.QtdFrascosHora <> 0 then
    GProRotulados.Cells[5,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProASerRotulado.QtdFrascosHora)
  else
    GProRotulados.Cells[5,VpaLinha] := '';
  if VprDProASerRotulado.CodMaterialFrasco <> 0 then
    GProRotulados.Cells[6,VpaLinha] := IntToStr(VprDProASerRotulado.CodMaterialFrasco)
  else
    GProRotulados.Cells[6,VpaLinha] := '';
  GProRotulados.Cells[7,VpaLinha] := VprDProASerRotulado.NomMaterialFrasco;
  if VprDProASerRotulado.AltFrasco <> 0 then
    GProRotulados.Cells[8,VpaLinha] := IntToStr(VprDProASerRotulado.AltFrasco)
  else
    GProRotulados.Cells[8,VpaLinha] := '';
  if VprDProASerRotulado.LarFrasco <> 0 then
    GProRotulados.Cells[9,VpaLinha] := IntToStr(VprDProASerRotulado.LarFrasco)
  else
    GProRotulados.Cells[9,VpaLinha] := '';
  if VprDProASerRotulado.ProfundidadeFrasco <> 0 then
    GProRotulados.Cells[10,VpaLinha] := IntToStr(VprDProASerRotulado.ProfundidadeFrasco)
  else
    GProRotulados.Cells[10,VpaLinha] := '';
  if VprDProASerRotulado.DiametroFrasco <> 0 then
    GProRotulados.Cells[11,VpaLinha] := IntToStr(VprDProASerRotulado.DiametroFrasco)
  else
    GProRotulados.Cells[11,VpaLinha] := '';
  if VprDProASerRotulado.LarRotulo <> 0 then
    GProRotulados.Cells[12,VpaLinha] := IntToStr(VprDProASerRotulado.LarRotulo)
  else
    GProRotulados.Cells[12,VpaLinha] := '';
  if VprDProASerRotulado.AltRotulo <> 0 then
    GProRotulados.Cells[13,VpaLinha] := IntToStr(VprDProASerRotulado.AltRotulo)
  else
    GProRotulados.Cells[13,VpaLinha] := '';
  if VprDProASerRotulado.CodMaterialRotulo <> 0 then
    GProRotulados.Cells[14,VpaLinha] := IntToStr(VprDProASerRotulado.CodMaterialRotulo)
  else
    GProRotulados.Cells[14,VpaLinha] := '';
  GProRotulados.Cells[15,VpaLinha] := VprDProASerRotulado.NomMaterialRotulo;
  if VprDProASerRotulado.CodLinerRotulo <> 0 then
    GProRotulados.Cells[16,VpaLinha] := IntToStr(VprDProASerRotulado.CodLinerRotulo)
  else
    GProRotulados.Cells[16,VpaLinha] := '';
  GProRotulados.Cells[17,VpaLinha] := VprDProASerRotulado.NomLinerRotulo;
  if VprDProASerRotulado.LarContraRotulo <> 0 then
    GProRotulados.Cells[18,VpaLinha] := IntToStr(VprDProASerRotulado.LarContraRotulo)
  else
    GProRotulados.Cells[18,VpaLinha] := '';
  if VprDProASerRotulado.AltContraRotulo <> 0 then
    GProRotulados.Cells[19,VpaLinha] := IntToStr(VprDProASerRotulado.AltContraRotulo)
  else
    GProRotulados.Cells[19,VpaLinha] := '';
  if VprDProASerRotulado.CodMaterialContraRotulo <> 0 then
    GProRotulados.Cells[20,VpaLinha] := IntToStr(VprDProASerRotulado.CodMaterialContraRotulo)
  else
    GProRotulados.Cells[20,VpaLinha] := '';
  GProRotulados.Cells[21,VpaLinha] := VprDProASerRotulado.NomMaterialContraRotulo;
  if VprDProASerRotulado.CodLinerContraRotulo <> 0 then
    GProRotulados.Cells[22,VpaLinha] := IntToStr(VprDProASerRotulado.CodMaterialContraRotulo)
  else
    GProRotulados.Cells[22,VpaLinha] := '';
  GProRotulados.Cells[23,VpaLinha] := VprDProASerRotulado.NomLinerContraRotulo;
  if VprDProASerRotulado.LarGargantilha <> 0 then
    GProRotulados.Cells[24,VpaLinha] := IntToStr(VprDProASerRotulado.LarGargantilha)
  else
    GProRotulados.Cells[24,VpaLinha] := '';
  if VprDProASerRotulado.AltGargantilha <> 0 then
    GProRotulados.Cells[25,VpaLinha] := IntToStr(VprDProASerRotulado.AltGargantilha)
  else
    GProRotulados.Cells[25,VpaLinha] := '';
  if VprDProASerRotulado.CodMaterialGargantilha <> 0 then
    GProRotulados.Cells[26,VpaLinha] := IntToStr(VprDProASerRotulado.CodMaterialGargantilha)
  else
    GProRotulados.Cells[26,VpaLinha] := '';
  GProRotulados.Cells[27,VpaLinha] := VprDProASerRotulado.NomMaterialGargantilha;
  if VprDProASerRotulado.CodLinerGargantilha <> 0 then
    GProRotulados.Cells[28,VpaLinha] := IntToStr(VprDProASerRotulado.CodLinerGargantilha)
  else
    GProRotulados.Cells[28,VpaLinha] := '';
  GProRotulados.Cells[29,VpaLinha] := VprDProASerRotulado.NomLinerGargantilha;
  GProRotulados.Cells[30,VpaLinha] := VprDProASerRotulado.ObsProduto;
end;

{******************************************************************************}
procedure TFNovaProposta.GProRotuladosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteProdutoRotulado then
  begin
    aviso('PRODUTO NÃO CADASTRADO!!!'#13'É necessário informar o código de um produto que esteja cadastrado.');
    VpaValidos:= False;
    GProRotulados.Col:= 1;
  end
  else
    if not EFormatoFrasco.AExisteCodigo(GProRotulados.Cells[3,GProRotulados.ALinha]) then
    begin
      aviso('FORMATO FRASCO NÃO CADASTRADO!!!'#13'É necessário informar o código do formato que esteja cadastrado.');
      VpaValidos:= False;
      GProRotulados.Col:= 3;
    end
    else
      if not EMaterialFrasco.AExisteCodigo(GProRotulados.Cells[6,GProRotulados.ALinha]) then
      begin
        aviso('MATERIAL FRASCO NÃO CADASTRADO!!!'#13'É necessário informar o código de um material de frasco que esteja cadastrado.');
        VpaValidos:= False;
        GProRotulados.Col:= 6;
      end
      else
        if not EMaterialRotulo.AExisteCodigo(GProRotulados.Cells[14,GProRotulados.ALinha]) then
        begin
          aviso('MATERIAL ROTULO NÃO CADASTRADO!!!'#13'É necessário informar o código de um material de rotulo que esteja cadastrado.');
          VpaValidos:= False;
          GProRotulados.Col:= 14;
        end
        else
          if not EMaterialLinerRotulo.AExisteCodigo(GProRotulados.Cells[16,GProRotulados.ALinha]) then
          begin
            aviso('MATERIAL LINER NÃO CADASTRADO!!!'#13'É necessário informar o código de um material de liner que esteja cadastrado.');
            VpaValidos:= False;
            GProRotulados.Col:= 16;
          end
          else
            if not EMaterialContraRotulo.AExisteCodigo(GProRotulados.Cells[20,GProRotulados.ALinha]) then
            begin
              aviso('MATERIAL CONTRA-RÓTULO NÃO CADASTRADO!!!'#13'É necessário informar o código do contra-rotulo  que esteja cadastrado.');
              VpaValidos:= False;
              GProRotulados.Col:= 20;
            end
            else
              if not EMaterialLinerContraRotulo.AExisteCodigo(GProRotulados.Cells[22,GProRotulados.ALinha]) then
              begin
                aviso('MATERIAL LINER CONTRA-RÓTULO NÃO CADASTRADO!!!'#13'É necessário informar o código do liner do contra-rotulo  que esteja cadastrado.');
                VpaValidos:= False;
                GProRotulados.Col:= 22;
              end
              else
                if not EMaterialGargantilha.AExisteCodigo(GProRotulados.Cells[26,GProRotulados.ALinha]) then
                begin
                  aviso('MATERIAL GARGANTILHA NÃO CADASTRADO!!!'#13'É necessário informar o código do material da gargantilha que esteja cadastrado.');
                  VpaValidos:= False;
                  GProRotulados.Col:= 26;
                end
                else
                  if not ELinerGargantilha.AExisteCodigo(GProRotulados.Cells[28,GProRotulados.ALinha]) then
                  begin
                    aviso('MATERIAL GARGANTILHA NÃO CADASTRADO!!!'#13'É necessário informar o código do liner da gargantilha que esteja cadastrado.');
                    VpaValidos:= False;
                    GProRotulados.Col:= 28;
                  end;
  if VpaValidos then
  begin
    CarDClasseProdutosRotulados;
{    if VprDProASerRotulado.QtdFrascosHora = 0 then
    begin
      aviso('QUANTIDADE FRASCOS POR HORA NÃO PREENCHIDA!!!'#13'É necessário informar a quantidade de frasco por hora.');
      VpaValidos:= False;
      GProRotulados.Col:= 5;
    end
    else
      if VprDProASerRotulado.AltFrasco = 0 then
      begin
        aviso('ALTURA DO FRASCO NÃO PREENCHIDA!!!'#13'É necessário informar a altura do frasco.');
        VpaValidos:= False;
        GProRotulados.Col:= 8;
      end
      else
        if VprDProASerRotulado.LarFrasco = 0 then
        begin
          aviso('LARGURA DO FRASCO NÃO PREENCHIDO!!!'#13'É necessário informar a largura do frasco.');
          VpaValidos:= False;
          GProRotulados.Col:= 9;
        end
        else
          if VprDProASerRotulado.LarRotulo = 0 then
          begin
            aviso('LARGURA DO ROTULO NÃO PREENCHIDO!!!'#13'É necessário informar a largura do rotulo.');
            VpaValidos:= False;
            GProRotulados.Col:= 12;
          end
          else
            if VprDProASerRotulado.AltRotulo = 0 then
            begin
              aviso('ALTURA DO ROTULO NÃO PREENCHIDO!!!'#13'É necessário informar a altura do rotulo.');
              VpaValidos:= False;
              GProRotulados.Col:= 13;
            end;}
  end;

end;

procedure TFNovaProposta.GProRotuladosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GProRotulados.Col of
        1 : LocalizaProdutoRotulado;
        3 : EFormatoFrasco.AAbreLocalizacao;
        6 : EMaterialFrasco.AAbreLocalizacao;
       14 : EMaterialRotulo.AAbreLocalizacao;
       16 : EMaterialLinerRotulo.AAbreLocalizacao;
       20 : EMaterialContraRotulo.AAbreLocalizacao;
       22 : EMaterialLinerContraRotulo.AAbreLocalizacao;
       26 : EMaterialGargantilha.AAbreLocalizacao;
       28 : ELinerGargantilha.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EFormaPagamentoParcelasRetorno(Retorno1,
  Retorno2: string);
begin
  if Retorno1 <> '' then
  begin
    GParcelas.Cells[RColunaGradeParcelas(clFPFormaPagamento), GParcelas.ALinha]:= Retorno1;
    GParcelas.Cells[RColunaGradeParcelas(clFPCodFormaPagamento), GParcelas.ALinha]:= EFormaPagamentoParcelas.Text;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EFormatoFrascoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodFormatoFrasco := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomFormatoFrasco := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[3,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[4,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodFormatoFrasco := 0;
    VprDProASerRotulado.NomFormatoFrasco := '';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EMaterialFrascoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodMaterialFrasco := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomMaterialFrasco := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[6,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[7,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodMaterialFrasco := 0;
    VprDProASerRotulado.NomMaterialFrasco := '';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EMaterialRotuloRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodMaterialRotulo := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomMaterialRotulo := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[14,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[15,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodMaterialRotulo := 0;
    VprDProASerRotulado.NomMaterialRotulo := '';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EMaterialLinerRotuloRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodLinerRotulo := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomLinerRotulo := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[16,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[17,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodLinerRotulo := 0;
    VprDProASerRotulado.NomLinerRotulo := '';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EMaterialContraRotuloRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodMaterialContraRotulo := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomMaterialContraRotulo := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[20,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[21,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodMaterialContraRotulo := 0;
    VprDProASerRotulado.NomMaterialContraRotulo := '';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EMaterialLinerContraRotuloRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodLinerContraRotulo := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomLinerContraRotulo := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[22,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[23,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodLinerContraRotulo := 0;
    VprDProASerRotulado.NomLinerContraRotulo := '';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EMaterialGargantilhaRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodMaterialGargantilha := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomMaterialGargantilha := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[26,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[27,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodMaterialGargantilha := 0;
    VprDProASerRotulado.NomMaterialGargantilha := '';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.ELinerGargantilhaRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProASerRotulado.CodLinerGargantilha := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProASerRotulado.NomLinerGargantilha := VpaColunas.items[1].AValorRetorno;
    GProRotulados.Cells[28,GProRotulados.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProRotulados.Cells[29,GProRotulados.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProASerRotulado.CodLinerGargantilha := 0;
    VprDProASerRotulado.NomLinerGargantilha := '';
  end;

end;

{******************************************************************************}
procedure TFNovaProposta.GProRotuladosKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GProRotulados.AColuna of
    5: if Key in [',','.'] then
             Key:= DecimalSeparator;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GProRotuladosMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.ProdutosASeremRotulados.Count > 0 then
    VprDProASerRotulado:= TRBDPropostaProdutoASerRotulado(VprDProposta.ProdutosASeremRotulados.Items[VpaLinhaAtual-1]);

end;

{******************************************************************************}
procedure TFNovaProposta.GProRotuladosNovaLinha(Sender: TObject);
begin
  VprDProASerRotulado := VprDProposta.addProdutoAseremRotulados;
end;

{******************************************************************************}
procedure TFNovaProposta.GProRotuladosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProRotulados.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProRotulados.AColuna <> ACol then
    begin
      case GProRotulados.AColuna of
        1: if not ExisteProdutoRotulado then
           begin
             if not LocalizaProdutoRotulado then
             begin
               GProRotulados.Cells[1,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 1;
               Abort;
             end;
           end;
        3: if not EFormatoFrasco.AExisteCodigo(GProRotulados.Cells[3,GProRotulados.ALinha]) then
           begin
             if not EFormatoFrasco.AAbreLocalizacao then
             begin
               GProRotulados.Cells[3,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 3;
               Abort;
             end;
           end;
        6: if not EMaterialFrasco.AExisteCodigo(GProRotulados.Cells[6,GProRotulados.ALinha]) then
           begin
             if not EMaterialFrasco.AAbreLocalizacao then
             begin
               GProRotulados.Cells[6,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 6;
               Abort;
             end;
           end;
       14 : if not EMaterialRotulo.AExisteCodigo(GProRotulados.Cells[14,GProRotulados.ALinha]) then
           begin
             if not EMaterialRotulo.AAbreLocalizacao then
             begin
               GProRotulados.Cells[14,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 14;
               Abort;
             end;
           end;
       16 : if not EMaterialLinerRotulo.AExisteCodigo(GProRotulados.Cells[16,GProRotulados.ALinha]) then
           begin
             if not EMaterialLinerRotulo.AAbreLocalizacao then
             begin
               GProRotulados.Cells[16,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 16;
               Abort;
             end;
           end;
       20 : if not EMaterialContraRotulo.AExisteCodigo(GProRotulados.Cells[20,GProRotulados.ALinha]) then
           begin
             if not EMaterialContraRotulo.AAbreLocalizacao then
             begin
               GProRotulados.Cells[20,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 20;
               Abort;
             end;
           end;
       22 : if not EMaterialLinerContraRotulo.AExisteCodigo(GProRotulados.Cells[22,GProRotulados.ALinha]) then
           begin
             if not EMaterialLinerContraRotulo.AAbreLocalizacao then
             begin
               GProRotulados.Cells[22,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 22;
               Abort;
             end;
           end;
       26 : if not EMaterialGargantilha.AExisteCodigo(GProRotulados.Cells[26,GProRotulados.ALinha]) then
           begin
             if not EMaterialGargantilha.AAbreLocalizacao then
             begin
               GProRotulados.Cells[26,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 26;
               Abort;
             end;
           end;
       28 : if not ELinerGargantilha.AExisteCodigo(GProRotulados.Cells[28,GProRotulados.ALinha]) then
           begin
             if not ELinerGargantilha.AAbreLocalizacao then
             begin
               GProRotulados.Cells[28,GProRotulados.ALinha]:= '';
               GProRotulados.Col:= 28;
               Abort;
             end;
           end;
      end;
    end;

end;

{******************************************************************************}
procedure TFNovaProposta.GProRotuladosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3,6,8,9,10,11,12,13,14,16,18,19,20,22,24,25,26,28: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.EClienteSelect(Sender: TObject);
begin
  ECliente.ASelectValida.Text := 'Select I_COD_CLI, C_NOM_CLI, C_CID_CLI from CADCLIENTES '+
                                 ' where I_Cod_Cli = @ ' +
                                 ' and (C_IND_CLI = ''S'''+
                                 ' or C_IND_PRC = ''S'') ';
  ECliente.ASelectLocaliza.Text := 'Select I_COD_CLI, C_NOM_CLI, C_CID_CLI from CADCLIENTES '+
                                 ' where C_NOM_CLI LIKE ''@%'' ' +
                                 ' and (C_IND_CLI = ''S'''+
                                 ' or C_IND_PRC = ''S'') ';


  if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
  begin
    ECliente.ASelectValida.Text := ECliente.ASelectValida.Text + 'and I_COD_VEN in '+varia.CodigosVendedores;
    ECliente.ASelectLocaliza.Text := ECliente.ASelectLocaliza.Text + 'and I_COD_VEN in '+varia.CodigosVendedores;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDVendaAdicional := TRBDPropostaVendaAdicional(VprDProposta.VendaAdicinal.Items[VpaLinha-1]);
  GVendaAdicional.Cells[1,VpaLinha] := VprDVendaAdicional.CodProduto;
  GVendaAdicional.Cells[2,VpaLinha] := VprDVendaAdicional.NomProduto;
  if VprDVendaAdicional.CodCor <> 0 then
    GVendaAdicional.Cells[3,VpaLinha] := IntToStr(VprDVendaAdicional.CodCor)
  else
    GVendaAdicional.Cells[3,VpaLinha] := '';
  GVendaAdicional.Cells[4,VpaLinha] := VprDVendaAdicional.NomCor;
  GVendaAdicional.Cells[5,VpaLinha] := VprDVendaAdicional.DESUM;
  CalculaValorTotalVendaAdicional;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalNovaLinha(Sender: TObject);
begin
  VprDVendaAdicional := VprDProposta.addVendaAdicional;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GVendaAdicional.Cells[1,GVendaAdicional.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProdutoVendaAdicional then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GVendaAdicional.col := 1;
    end
    else
      if (GVendaAdicional.Cells[3,GVendaAdicional.ALinha] <> '') then
      begin
        if not ECorVendaAdicional.AExisteCodigo(GVendaAdicional.Cells[3,GVendaAdicional.ALinha]) then
        begin
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          GVendaAdicional.Col := 3;
        end;
      end
      else
        if (VprDVendaAdicional.UnidadesParentes.IndexOf(GVendaAdicional.Cells[5,GVendaAdicional.Alinha]) < 0) then
        begin
          VpaValidos := false;
          aviso(CT_UNIDADEVAZIA);
          GVendaAdicional.col := 5;
        end
        else
          if (GVendaAdicional.Cells[6,GVendaAdicional.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso(CT_QTDPRODUTOINVALIDO);
            GVendaAdicional.Col := 6;
          end
          else
            if (GVendaAdicional.Cells[7,GVendaAdicional.ALinha] = '') then
            begin
              VpaValidos := false;
              aviso(CT_VALORUNITARIOINVALIDO);
              GVendaAdicional.Col := 7;
            end;

  if VpaValidos then
  begin
    CarDProdutoVendaAdicinal;
    if (VprDVendaAdicional.QtdProduto = 0)  then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GVendaAdicional.col := 6
    end
    else
      if (VprDVendaAdicional.ValUnitario = 0)  then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        GVendaAdicional.Col := 7;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GVendaAdicional.Col of
        1 :  LocalizaProdutoVendaAdicional;
        3 :  ECorVendaAdicional.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = '.') and  not(GProdutos.col in [1]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProposta.VendaAdicinal.Count >0 then
  begin
    VprDVendaAdicional := TRBDPropostaVendaAdicional(VprDProposta.VendaAdicinal.Items[VpaLinhaAtual-1]);
    VprProdutoAdicionalAnterior := VprDVendaAdicional.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaProposta.GVendaAdicionalSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GVendaAdicional.AEstadoGrade in [egInsercao,EgEdicao] then
    if GVendaAdicional.AColuna <> ACol then
    begin
      case GVendaAdicional.AColuna of
        1 :if not ExisteProdutoVendaAdicional then
           begin
             if not LocalizaProdutoVendaAdicional then
             begin
               GVendaAdicional.Cells[1,GVendaAdicional.ALinha] := '';
               GVendaAdicional.Col := 1;
             end;
           end;
        3 : if not ECorVendaAdicional.AExisteCodigo(GVendaAdicional.Cells[3,GVendaAdicional.ALinha]) then
            begin
              Aviso(CT_CORINEXISTENTE);
              GVendaAdicional.Col := 3;
              abort;
            end;
        5 : if not ExisteUMVendaAdicional then
            begin
              aviso(CT_UNIDADEVAZIA);
              GVendaAdicional.col := 5;
              abort;
            end;
        6,7 :
             begin
               if GVendaAdicional.Cells[6,GVendaAdicional.ALinha] <> '' then
                 VprDVendaAdicional.QtdProduto := StrToFloat(DeletaChars(GVendaAdicional.Cells[6,GVendaAdicional.ALinha],'.'))
               else
                 VprDVendaAdicional.QtdProduto := 0;
               if GVendaAdicional.Cells[7,GVendaAdicional.ALinha] <> '' then
                 VprDVendaAdicional.ValUnitario := StrToFloat(DeletaChars(GVendaAdicional.Cells[7,GVendaAdicional.ALinha],'.'))
               else
                 VprDVendaAdicional.ValUnitario := 0;
               CalculaValorTotalVendaAdicional;
             end;
        8 : begin
              if DeletaChars(DeletaChars(DeletaChars(DeletaChars(DeletaChars(GVendaAdicional.Cells[8,GVendaAdicional.ALinha],'R'),'$'),'0'),'.'),',') <> '' then
              begin
                if VprDVendaAdicional.ValTotal <> StrToFloat(DeletaChars(DeletaChars(DeletaChars(GVendaAdicional.Cells[8,GVendaAdicional.ALinha],'.'),'R'),'$')) then
                begin
                  VprDVendaAdicional.ValTotal := StrToFloat(DeletaChars(DeletaChars(DeletaChars(GVendaAdicional.Cells[8,GVendaAdicional.ALinha],'.'),'R'),'$'));
                  VprDVendaAdicional.ValUnitario := VprDVendaAdicional.ValTotal / VprDVendaAdicional.QtdProduto;
                end;
              end;
            end;
      end;
    end;
end;

procedure TFNovaProposta.ECorVendaAdicionalRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDVendaAdicional.CodCor := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDVendaAdicional.NomCor := VpaColunas.items[1].AValorRetorno;
    GVendaAdicional.Cells[3,GVendaAdicional.ALinha] := VpaColunas.items[0].AValorRetorno;
    GVendaAdicional.Cells[4,GVendaAdicional.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDVendaAdicional.CodCor := 0;
    VprDVendaAdicional.NomCor := '';
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaProposta]);
end.

