unit ANovoProdutoPro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, UnDadosProduto,
  ComCtrls, DBCtrls, Tabela, Mask, numericos, Localizacao, DBKeyViolation, Constantes,
  UnProdutos, UnClassificacao, EditorImagem, Grids, CGrades, UnClientes,
  Spin, UnDadosLocaliza, UnContasaReceber, Menus, UnAmostra;

type
  TFNovoProdutoPro = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BCancelar: TBitBtn;
    BGravar: TBitBtn;
    BFechar: TBitBtn;
    Paginas: TPageControl;
    PGerais: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    LIPI: TLabel;
    LblClassificacaoFiscal: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    LblDescontoKit: TLabel;
    Label9: TLabel;
    Label21: TLabel;
    Label7: TLabel;
    LQtdCaixa: TLabel;
    LblQtdMin: TLabel;
    LblQtdPed: TLabel;
    Label14: TLabel;
    Label23: TLabel;
    LValVenda: TLabel;
    LValCusto: TLabel;
    Label73: TLabel;
    Label6: TLabel;
    LDescricaoTecnica: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    BFoto: TBitBtn;
    Label2: TLabel;
    LPatFoto: TLabel;
    EValVenda: Tnumerico;
    EPerMaxDesconto: Tnumerico;
    EQuantidade: Tnumerico;
    EPerIPI: Tnumerico;
    EReducaoICMS: Tnumerico;
    EPerDesconto: Tnumerico;
    EPerComissao: Tnumerico;
    EQtdEntregaFornecedor: Tnumerico;
    EQtdMinima: Tnumerico;
    EQtdPedido: Tnumerico;
    EValCusto: Tnumerico;
    ECodProduto: TEditColor;
    EDescricao: TEditColor;
    ECodMoeda: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Label5: TLabel;
    ECifraoMoeda: TEditColor;
    EClassificacaoFiscal: TMaskEditColor;
    LNomClassificacao: TLabel;
    EUnidadesPorCaixa: Tnumerico;
    EUnidadesVenda: TComboBoxColor;
    EDescricaoTecnica: TMemoColor;
    ValidaGravacao: TValidaGravacao;
    CProdutoAtivo: TCheckBox;
    EditorImagem: TEditorImagem;
    PCadarco: TTabSheet;
    Label40: TLabel;
    Label41: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label25: TLabel;
    Label58: TLabel;
    Label63: TLabel;
    Label24: TLabel;
    ENumFios: TEditColor;
    ETipMaquina: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    EMetrosMinuto: TEditColor;
    EEngEspPequena: TEditColor;
    EEngEspGrande: TEditColor;
    EQtdFuso: TEditColor;
    ETituloFio: TEditColor;
    EMetTabuaPequeno: TEditColor;
    EMetTabuaGrande: TEditColor;
    EMetTabuaTrans: TEditColor;
    EEnchimento: TEditColor;
    ELargProduto: TEditColor;
    PETiqueta: TTabSheet;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    Label26: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label59: TLabel;
    Label61: TLabel;
    Label22: TLabel;
    Label38: TLabel;
    Label88: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    ESumula: TEditColor;
    ELarguraProduto: TEditColor;
    EComprFigura: TEditColor;
    ENumeroFios: TEditColor;
    EPente: TEditColor;
    EBatidasTotais: TEditColor;
    EBatidasProduto: TEditColor;
    EBatidasTear: TEditColor;
    EIndiceProdutividade: TEditColor;
    ETipFundo: TEditLocaliza;
    Label12: TLabel;
    ETipEmenda: TEditLocaliza;
    Label15: TLabel;
    ETipCorte: TEditLocaliza;
    Label20: TLabel;
    CEngomagem: TCheckBox;
    EEngrenagem: TEditColor;
    EPrateleiraProduto: TEditColor;
    Panel1: TPanel;
    RTearConvencional: TRadioButton;
    RTearH: TRadioButton;
    Label28: TLabel;
    Label89: TLabel;
    CCalandragem: TCheckBox;
    EComprProduto: TEditColor;
    PCombinacao: TTabSheet;
    Label35: TLabel;
    Label37: TLabel;
    Label39: TLabel;
    GCombinacao: TRBStringGridColor;
    GFigura: TRBStringGridColor;
    PDadosAdicionais: TTabSheet;
    Label49: TLabel;
    Label50: TLabel;
    Label64: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label42: TLabel;
    Label86: TLabel;
    Label165: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Label87: TLabel;
    SpeedButton28: TSpeedButton;
    Label167: TLabel;
    Label77: TLabel;
    Label74: TLabel;
    EPesoLiquido: Tnumerico;
    EPesoBruto: Tnumerico;
    EPrateleiraPro: TEditColor;
    EEmbalagem: TEditLocaliza;
    EAcondicionamento: TEditLocaliza;
    ECodDesenvolvedor: TEditLocaliza;
    EAlturaProduto: TEditColor;
    CImprimeTabelaPreco: TCheckBox;
    CCracha: TCheckBox;
    CProdutoRetornavel: TCheckBox;
    ERendimento: TMemoColor;
    PCopiadoras: TTabSheet;
    Label46: TLabel;
    Label60: TLabel;
    Label62: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Panel2: TPanel;
    RColorida: TRadioButton;
    RMonoCromatica: TRadioButton;
    Panel3: TPanel;
    RMatricial: TRadioButton;
    RJatoTinta: TRadioButton;
    RLaser: TRadioButton;
    Panel4: TPanel;
    RMonoComponente: TRadioButton;
    RBiComponente: TRadioButton;
    Panel5: TPanel;
    RTonerComCilindro: TRadioButton;
    RTonerSemCilindro: TRadioButton;
    Panel6: TPanel;
    CCopiadora: TCheckBox;
    CMultiFuncional: TCheckBox;
    CImpressora: TCheckBox;
    EQtdCopiasToner: TEditColor;
    EQtdCopiasCilindro: TEditColor;
    EQtdCopiasTonerAltaCapacidade: TEditColor;
    EQtdPaginasPorMinuto: TEditColor;
    ECodCartucho: TEditColor;
    ECodCartuchoAltaCapacidade: TEditColor;
    EVolumeMensalCopias: TEditColor;
    Panel7: TPanel;
    CPlacaRede: TCheckBox;
    CPcl: TCheckBox;
    CFax: TCheckBox;
    CUSB: TCheckBox;
    CScanner: TCheckBox;
    CWireless: TCheckBox;
    CDuplex: TCheckBox;
    EDatAmostra: TMaskEditColor;
    EDatSaidaAmostra: TMaskEditColor;
    EDatFabricacao: TMaskEditColor;
    EDatEncerramentoProducao: TMaskEditColor;
    PCartuchos: TTabSheet;
    PEstagios: TTabSheet;
    GEstagios: TRBStringGridColor;
    PFornecedores: TTabSheet;
    GFornecedores: TRBStringGridColor;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label90: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    SpeedButton11: TSpeedButton;
    Label92: TLabel;
    ECodigoReduzido: TEditColor;
    EPesoCartuchoVazio: TEditColor;
    EPesoCartuchoCheio: TEditColor;
    EQtdPaginas: TEditColor;
    ECodCor: TEditLocaliza;
    Panel8: TPanel;
    RCartuchoTinta: TRadioButton;
    RCartuchoTonner: TRadioButton;
    Label91: TLabel;
    CChipNovo: TCheckBox;
    CCilindroNovo: TCheckBox;
    CProdutoOriginal: TCheckBox;
    CCartuchoTexto: TCheckBox;
    CProdutoCompativel: TCheckBox;
    Label85: TLabel;
    GImpressoras: TRBStringGridColor;
    EQtdML: TEditColor;
    EFornecedor: TEditLocaliza;
    ECor: TEditLocaliza;
    EEstagio: TEditLocaliza;
    ECodClassificacao: TMaskEditColor;
    SpeedButton8: TSpeedButton;
    Label4: TLabel;
    EValRevenda: Tnumerico;
    EPerLucro: Tnumerico;
    Label10: TLabel;
    Label32: TLabel;
    EMesesGarantia: TSpinEditColor;
    Label65: TLabel;
    SpeedButton12: TSpeedButton;
    Label66: TLabel;
    EUsuario: TRBEditLocaliza;
    Label17: TLabel;
    EMetCadarco: TEditColor;
    EDatCadastro: TEditColor;
    Label93: TLabel;
    PAcessorios: TTabSheet;
    GAcessorios: TRBStringGridColor;
    EAcessorio: TRBEditLocaliza;
    Label94: TLabel;
    EComposicao: TRBEditLocaliza;
    Label95: TLabel;
    SpeedButton13: TSpeedButton;
    Label96: TLabel;
    CMonitorarEstoque: TCheckBox;
    EOrigemProduto: TComboBoxColor;
    PTabelaPreco: TTabSheet;
    GPreco: TRBStringGridColor;
    ETabelaPreco: TRBEditLocaliza;
    ETamanho: TRBEditLocaliza;
    ECliPreco: TRBEditLocaliza;
    EMoeda: TRBEditLocaliza;
    PInstalacaoTear: TTabSheet;
    PanelColor3: TPanelColor;
    GInstalacao: TRBStringGridColor;
    EQtdQuadros: TSpinEditColor;
    Label97: TLabel;
    Label98: TLabel;
    EQtdColInstalacao: TSpinEditColor;
    ECapacidadeLiquida: Tnumerico;
    Label99: TLabel;
    Label100: TLabel;
    PanelColor4: TPanelColor;
    BRepeticaoDesenho: TSpeedButton;
    BZoomMenos: TSpeedButton;
    BCursor: TSpeedButton;
    BZoomMais: TSpeedButton;
    BNovo: TSpeedButton;
    PanelColor5: TPanelColor;
    EProdutoInstalacao: TRBEditLocaliza;
    SpeedButton14: TSpeedButton;
    LProdutoInstalacao: TLabel;
    LNomProdutoInstalacao: TLabel;
    LNomCorInstalacao: TLabel;
    LCorInstalacao: TLabel;
    ECorInstalacao: TRBEditLocaliza;
    SpeedButton15: TSpeedButton;
    LQtdFiosLico: TLabel;
    EQtdFiosLico: Tnumerico;
    LFuncaoFio: TLabel;
    EFuncaoFio: TComboBoxColor;
    ECorPreco: TRBEditLocaliza;
    CProduto: TRadioButton;
    CKit: TRadioButton;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    PanelColor10: TPanelColor;
    PanelColor11: TPanelColor;
    EDestinoProduto: TComboBoxColor;
    Label102: TLabel;
    GDPC: TRBStringGridColor;
    EQtdLinInstalacao: TSpinEditColor;
    Label8: TLabel;
    Splitter1: TSplitter;
    PanelColor12: TPanelColor;
    PCadarcoFita: TTabSheet;
    PanelColor13: TPanelColor;
    Label16: TLabel;
    SpeedButton2: TSpeedButton;
    Label103: TLabel;
    ETipoFundo: TEditLocaliza;
    Label107: TLabel;
    EEngrenagensBat: TEditColor;
    EEngrenagemTrama: TEditColor;
    Label108: TLabel;
    Label109: TLabel;
    ESistemaTear: TEditColor;
    Label110: TLabel;
    EBatidasPorCm: TEditColor;
    Label111: TLabel;
    EPenteCadarco: TEditColor;
    Label112: TLabel;
    ELargura: TEditColor;
    CCalandragemFita: TCheckBox;
    CPreEncolhido: TCheckBox;
    CAgruparBalancim: TCheckBox;
    GCombinacaoCadarco: TRBStringGridColor;
    ECorFioTrama: TRBEditLocaliza;
    ECorFioAjuda: TRBEditLocaliza;
    PAco: TTabSheet;
    PanelColor14: TPanelColor;
    Label113: TLabel;
    Label114: TLabel;
    EDensidadeVolumetrica: Tnumerico;
    EEspessuraAco: Tnumerico;
    Label115: TLabel;
    PopupMenu1: TPopupMenu;
    ImportarProduto1: TMenuItem;
    ScrollBox1: TScrollBox;
    Label116: TLabel;
    Label117: TLabel;
    PDetectoresMetal: TTabSheet;
    PanelColor15: TPanelColor;
    Bevel4: TBevel;
    Label184: TLabel;
    Label119: TLabel;
    EConsumoEletrico: TEditColor;
    Label120: TLabel;
    ETensaoAlimentacao: TEditColor;
    EGrauProtecao: TEditColor;
    Label121: TLabel;
    EAberturaCabeca: TEditColor;
    Label122: TLabel;
    EComunicacaoRede: TEditColor;
    Label123: TLabel;
    Label124: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label125: TLabel;
    EDescritivoFuncDetectoresMetal: TMemoColor;
    Bevel3: TBevel;
    LInfomDisplayDetectoresMetais: TLabel;
    Label126: TLabel;
    ESensibilidadeFerrosos: TEditColor;
    ESensibilidadeNaoFerrosos: TEditColor;
    Label127: TLabel;
    EAcoInoxidavel: TEditColor;
    Label128: TLabel;
    EInfDisplayDetectoresMetal: TMemoColor;
    CSubstituicaoTributaria: TCheckBox;
    CDescontoBaseICMS: TCheckBox;
    Label13: TLabel;
    EPerST: Tnumerico;
    BExcluir: TSpeedButton;
    POrcamentoCadarco: TTabSheet;
    PanelColor16: TPanelColor;
    ETipoCadarco: TComboBoxColor;
    Label31: TLabel;
    Label101: TLabel;
    EQtdBatidasOrcamentoCadarco: Tnumerico;
    GFioOrcamentoCadarco: TRBStringGridColor;
    EValUnitarioOrcamentoCadarco: Tnumerico;
    Label104: TLabel;
    Label105: TLabel;
    ELarguraOrcamentoCadarco: Tnumerico;
    PanelColor17: TPanelColor;
    CArredondamento: TRadioButton;
    CTruncamento: TRadioButton;
    ESituacaoTributaria: TComboBoxColor;
    PEmbalagemPvc: TTabSheet;
    PPVC: TPanelColor;
    LTipoEmb: TLabel;
    CTipo: TComboBoxColor;
    Label106: TLabel;
    SpeedButton16: TSpeedButton;
    Label118: TLabel;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    CAlca: TComboBoxColor;
    Label134: TLabel;
    ELocalAlca: TEditColor;
    LLaminaZiper: TLabel;
    LPlastico: TLabel;
    Label136: TLabel;
    LLaminaAba: TLabel;
    LInterno1: TLabel;
    LInterno2: TLabel;
    Label141: TLabel;
    CImpressao: TComboBoxColor;
    Label142: TLabel;
    ECoreslImp: TEditColor;
    Label143: TLabel;
    CCabide: TComboBoxColor;
    Label144: TLabel;
    CBotao: TComboBoxColor;
    LcorBotao: TLabel;
    Label146: TLabel;
    CBoline: TComboBoxColor;
    Label147: TLabel;
    CZiper: TComboBoxColor;
    Label148: TLabel;
    Label149: TLabel;
    SpeedButton20: TSpeedButton;
    LVies: TLabel;
    CVies: TComboBoxColor;
    Label152: TLabel;
    Label153: TLabel;
    EPlastico2: TEditLocaliza;
    BKit: TBitBtn;
    BMenuFiscal: TBitBtn;
    LFerramenta: TLabel;
    EFerramenta: TEditLocaliza;
    SpeedButton21: TSpeedButton;
    LFaca: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    LCorteObs: TLabel;
    ECorteObs: TEditColor;
    Label135: TLabel;
    CSimCabide: TComboBoxColor;
    Label137: TLabel;
    EObsBotao: TEditColor;
    CBotaoCor: TComboBoxColor;
    Label155: TLabel;
    LZIperCor: TLabel;
    Label150: TLabel;
    EAdicionais: TEditColor;
    ECorZiper: TEditLocaliza;
    Panel9: TPanel;
    PanelColor19: TPanelColor;
    PanelColor20: TPanelColor;
    EPreFaccao: Tnumerico;
    EPrecPvc: Tnumerico;
    ETamZiper: Tnumerico;
    EInternoPvc: TEditColor;
    EInternoPvc2: TEditColor;
    EPlastico: TEditLocaliza;
    CBolso: TCheckBox;
    CCorte: TCheckBox;
    Panel10: TPanel;
    RInterno: TRadioButton;
    RExterno: TRadioButton;
    Label138: TLabel;
    LLocalImp: TLabel;
    LCorZiper: TLabel;
    ELocalImp: TEditColor;
    LPlastico2: TLabel;
    EFolha2: TEditColor;
    EFolhaMarc: TEditColor;
    EFotolito: TEditColor;
    PRotuladoras: TTabSheet;
    PanelColor21: TPanelColor;
    Label145: TLabel;
    EDescComercial: TEditColor;
    Label151: TLabel;
    MInfoTecnica: TMemoColor;
    ELarPvc: TEditColor;
    EAltPvc: TEditColor;
    EFunPvc: TEditColor;
    EAbaPvc: TEditColor;
    EDiaPvc: TEditColor;
    EPenPvc: TEditColor;
    LLocalInt: TLabel;
    ELocalInt: TEditColor;
    CRecalcularPreco: TCheckBox;
    LICMS: TLabel;
    EPerICMS: Tnumerico;
    SPVC: TScrollBox;
    PFilial: TTabSheet;
    PanelColor18: TPanelColor;
    GFilial: TRBStringGridColor;
    EFilial: TRBEditLocaliza;
    MImagem: TPopupMenu;
    SalvarImagemAreaTranferenciaWindows1: TMenuItem;
    BLimpaFoto: TBitBtn;

    procedure PaginasChange(Sender: TObject);
    procedure PaginasChanging(Sender: TObject; var AllowChange: Boolean);

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BFecharClick(Sender: TObject);
    procedure ECodEmpresaChange(Sender: TObject);
    procedure ECodClassificacaoExit(Sender: TObject);
    procedure ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ECodMoedaRetorno(Retorno1, Retorno2: String);
    procedure ECodProdutoExit(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BKitClick(Sender: TObject);
    procedure EUnidadesVendaChange(Sender: TObject);
    procedure EBatidasTotaisExit(Sender: TObject);
    procedure ETipMaquinaCadastrar(Sender: TObject);
    procedure ETipFundoCadastrar(Sender: TObject);
    procedure ETipEmendaCadastrar(Sender: TObject);
    procedure ETipCorteCadastrar(Sender: TObject);
    procedure EEmbalagemCadastrar(Sender: TObject);
    procedure EAcondicionamentoCadastrar(Sender: TObject);
    procedure ECodCorCadastrar(Sender: TObject);
    procedure EEstagioCadastrar(Sender: TObject);
    procedure GFornecedoresCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GFornecedoresDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GFornecedoresGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure GFornecedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GFornecedoresKeyPress(Sender: TObject; var Key: Char);
    procedure GFornecedoresMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFornecedoresNovaLinha(Sender: TObject);
    procedure GFornecedoresSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GEstagiosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GEstagiosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GEstagiosDepoisExclusao(Sender: TObject);
    procedure GEstagiosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GEstagiosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GEstagiosKeyPress(Sender: TObject; var Key: Char);
    procedure GEstagiosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GEstagiosNovaLinha(Sender: TObject);
    procedure GEstagiosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EEstagioRetorno(Retorno1, Retorno2: String);
    procedure GCombinacaoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GCombinacaoDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GCombinacaoGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GCombinacaoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCombinacaoNovaLinha(Sender: TObject);
    procedure GFiguraCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GFiguraDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GFiguraGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GFiguraMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFiguraNovaLinha(Sender: TObject);
    procedure GImpressorasCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GImpressorasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GImpressorasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GImpressorasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GImpressorasNovaLinha(Sender: TObject);
    procedure GImpressorasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SpeedButton8Click(Sender: TObject);
    procedure EPerLucroChange(Sender: TObject);
    procedure GAcessoriosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GAcessoriosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure EAcessorioRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GAcessoriosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GAcessoriosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GAcessoriosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GAcessoriosNovaLinha(Sender: TObject);
    procedure GAcessoriosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECodClassificacaoEnter(Sender: TObject);
    procedure EDescricaoExit(Sender: TObject);
    procedure EComposicaoCadastrar(Sender: TObject);
    procedure GPrecoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GPrecoDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GPrecoGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GPrecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GPrecoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GPrecoNovaLinha(Sender: TObject);
    procedure GPrecoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ETabelaPrecoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ECliPrecoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EMoedaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ETabelaPrecoSelect(Sender: TObject);
    procedure EValVendaExit(Sender: TObject);
    procedure GInstalacaoClick(Sender: TObject);
    procedure GInstalacaoGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure EQtdQuadrosExit(Sender: TObject);
    procedure EQtdColInstalacaoExit(Sender: TObject);
    procedure GInstalacaoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GInstalacaoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BZoomMaisClick(Sender: TObject);
    procedure BZoomMenosClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure EProdutoInstalacaoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure BRepeticaoDesenhoClick(Sender: TObject);
    procedure ECorPrecoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GPrecoAntesExclusao(Sender: TObject; var VpaPermiteExcluir: Boolean);
    procedure EQtdMinimaExit(Sender: TObject);
    procedure EQtdPedidoExit(Sender: TObject);
    procedure EQuantidadeExit(Sender: TObject);
    procedure EValRevendaExit(Sender: TObject);
    procedure EValCustoExit(Sender: TObject);
    procedure GDPCGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GDPCClick(Sender: TObject);
    procedure EQtdLinInstalacaoExit(Sender: TObject);
    procedure GCombinacaoCadarcoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GCombinacaoCadarcoDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure ECorFioTramaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ECorFioAjudaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GCombinacaoCadarcoGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure GCombinacaoCadarcoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GCombinacaoCadarcoMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure GCombinacaoCadarcoNovaLinha(Sender: TObject);
    procedure GCombinacaoCadarcoSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure ECorCadastrar(Sender: TObject);
    procedure ImportarProduto1Click(Sender: TObject);
    procedure PanelColor15Click(Sender: TObject);
    procedure EAcessorioCadastrar(Sender: TObject);
    procedure BCursorClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure GFioOrcamentoCadarcoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GFioOrcamentoCadarcoMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure GFioOrcamentoCadarcoCellClick(Button: TMouseButton; Shift: TShiftState; VpaColuna, VpaLinha: Integer);
    procedure GFioOrcamentoCadarcoDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GFioOrcamentoCadarcoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GFioOrcamentoCadarcoKeyPress(Sender: TObject; var Key: Char);
    procedure ETipoCadarcoChange(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
    procedure CSubstituicaoTributariaClick(Sender: TObject);
    procedure EPlastico2Select(Sender: TObject);
    procedure CTipoClick(Sender: TObject);
    procedure EPlasticoSelect(Sender: TObject);
    procedure CBotaoChange(Sender: TObject);
    procedure CBolsoClick(Sender: TObject);
    procedure CCorteClick(Sender: TObject);
    procedure CCabideChange(Sender: TObject);
    procedure EPlastico2Retorno(Retorno1, Retorno2: string);
    procedure EPlasticoRetorno(Retorno1, Retorno2: string);
    procedure CTipoChange(Sender: TObject);
    procedure EFerramentaCadastrar(Sender: TObject);
    procedure ECorZiperChange(Sender: TObject);
    procedure GFilialCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GFilialDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GFilialGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GFilialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GFilialMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFilialNovaLinha(Sender: TObject);
    procedure GFilialSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GAcessoriosRowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure EFilialRetorno(VpaColunas: TRBColunasLocaliza);
    procedure SalvarImagemAreaTranferenciaWindows1Click(Sender: TObject);
    procedure BLimpaFotoClick(Sender: TObject);
  private
    VprCodClassificacao,
    VprCodClassificacaoAnterior : String;
    FunClassificacao: TFuncoesClassificacao;
    VprOperacao: TRBDOperacaoCadastro;
    VprAcao,
    VprImpressorasCarregadas,
    VprAcessoriosCarregados,
    VprImportandoAmostra : Boolean;
    VprImpressoraAnterior: String;
    VprLinhaInicial,VprLinhaFinal, VprColunaInicial, VprColunaFinal : Integer;
    VprSeqProdutoInstalacao,
    VprCodCorPreco,
    VprQtdRepeticao : Integer;
    VprNomCorPreco : String;

    VprDProduto: TRBDProduto;
    VprDFornecedor: TRBDProdutoFornecedor;
    VprDEstagio: TRBDEstagioProduto;
    VprDCombinacao: TRBDCombinacao;
    VprDProAcessorio : TRBDProdutoAcessorio;
    VprDProFilialFaturamento: TRBDFilialFaturamento;
    VprDProTabelaPreco : TRBDProdutoTabelaPreco;
    VprDFigura: TRBDCombinacaoFigura;
    VprRepeticoesInstalacao,
    VprListaImpressoras: TList;
    VprDProImpressora: TRBDProdutoImpressora;
    VprDFioOrcamentoCadarco : TRBDProdutoFioOrcamentoCadarco;
    VprDCombinacaoCadarco : TRBDCombinacaoCadarcoTear;
    VprDAmostra : TRBDAmostra;
    VprDProcessoAmostra: TRBDAmostraProcesso;
    FunAmostra : TRBFuncoesAmostra;

    // Verificar permissões e configurações ao criar uma nova página
    procedure ConfiguraPermissaoUsuario;
    procedure CarregaConfiguracoes;
    procedure ConfiguracoesCodigoBarra;
    procedure ConfiguracoesCadarco;
    procedure ConfiguracoesEtiqueta;
    procedure ConfiguracoesAdicionais;
    procedure ConfiguracoesCopiadora;
    procedure ConfiguracoesCartuchos;
    procedure ConfiguracoesEstagios;
    procedure ConfiguracoesFornecedores;
    procedure HabilitaTelaInstalacaoTearFios(VpaHabilitar : Boolean);

    function ExisteCor: Boolean;
    function ExisteCliente: Boolean;
    function ExisteEstagio(VpaCodEstagio: String): Boolean;
    function ExisteImpressora: Boolean;
    function ExisteProdutoFioTrama : Boolean;
    function ExisteProdutoFioAjuda : Boolean;
    function ImpressoraDuplicada: Boolean;
    function LocalizaImpressora: Boolean;
    function LocalizaProdutoFioTrama : Boolean;
    function LocalizaProdutoFioAjuda : Boolean;

    procedure CriaClasses;
    procedure InicializaClasseProduto;
    procedure InicializaGrades;
    procedure InicializaTela;
    procedure CarTitulosGrade;
    function LocalizaClassificacao: Boolean;
    procedure BloquearTela(VpaEstado: Boolean);
    procedure AlteraFoco;
    function ChamaRotinasGravacao: String;
    function GeraCodigoBarras : String;

    function DadosValidos : String;
    procedure CarDTela;
    procedure CarDInstalacaoTearTela;
    procedure PosDadosGerais;
    procedure PosDadosCadarcoTrancado;
    procedure PosDadosCadarco;
    procedure PosDadosEtiqueta;
    procedure PosDadosCombinacao;
    procedure PosDadosAdicionais;
    procedure PosDadosCopiadora;
    procedure PosDadosCartucho;
    procedure PosImpressoras;
    procedure PosDadosEstagios;
    procedure PosDadosFornecedores;
    procedure PosDadosAcessorios;
    procedure PosDadosTabelaPreco;
    procedure PosDadosInstalacaoTear;
    procedure PosDadosAco;
    procedure PosDadosDetectoresMetal;
    procedure PosDadosOrcamentoCadarco;
    procedure PosDadosEmbalagemPvc;
    procedure PosDadosRotuladoras;
    procedure PosDadosFilialFaturamento;

    procedure CarDClasseGerais;
    procedure CarDClasseCadarcoTrancado;
    procedure CarDClasseCadarco;
    procedure CarDClasseEtiqueta;
    procedure CadDClasseAdicionais;
    procedure CarDClasseCopiadora;
    procedure CarDClasseCartucho;
    procedure CarDClasseEmbalagemPvc;
    procedure CarDClasseAco;
    procedure CarDInstalacaoTear;
    procedure CarDDetectoresMetal;
    procedure CarDClasseOrcamentoCadarco;
    procedure CarDClasseRotuladoras;

    procedure CarDFornecedoresClasse;
    procedure CarDFilialFaturamento;
    procedure CarDCombinacaoCadarcoTear;
    procedure CarDEstagio;
    procedure CarDCombinacao;
    procedure CarDFigura;
    procedure CarDTabelaPreco;
    procedure CarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
    procedure CarInstalacaoRepeticaoGrade;

    procedure ConfiguraQtdQuadros(VpaQtdQuadros : Integer);
    procedure ConfiguraQtdColunaInstalcao(VpaQtdColunas : Integer);
    procedure ConfiguraQtdLinhaInstalacao(VpaQtdLinhas : Integer);
    procedure ZoomGradeInstalacao(VpaIndice : Double);
    procedure CarDProdutoInstalacao;
    procedure CarDProdutoInstalacaoTela;
    procedure CarGradeProcessoAmostra;
    function DadosProdutoInstalacaoValido : String;
    function ImportaAmostra(VpaCodAmostra : Integer):string;
    procedure CalculaOrcamentoCadarco;
    procedure AlteraVisibilidadeCampo(VpaLabel : TLabel; VpaCampo: TEditColor; VpaValor : Boolean);
  public
    function NovoProduto(VpaCodClassificacao: String): TRBDProduto;
    function AlterarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): TRBDProduto;
    function AlteraEstagioProdutos(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
    procedure ConsultarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
    procedure ConsultaFornecedores(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
    function DesativarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
  end;

var
  FNovoProdutoPro: TFNovoProdutoPro;

implementation
uses
  APrincipal, FunString, FunData, FunObjeto, FunNumeros, ALocalizaClassificacao, ConstMsg,
  AMaquinas, ATipoEmenda, ATipoFundo, ATipoCorte, AEmbalagem, AAcondicionamento,
  ACores, AEstagioProducao, ALocalizaProdutos, AMontaKit, ANovaComposicao, FunArquivos,
  AAcessorio, AMenuFiscalECF, AFacas;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoProdutoPro.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EditorImagem.DirServidor := varia.DriveFoto;
  VprAcao:= False;
  VprCodClassificacao := '';
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  EDatAmostra.EditMask := FPrincipal.CorFoco.AMascaraData;
  EDatSaidaAmostra.EditMask := FPrincipal.CorFoco.AMascaraData;
  VprImpressorasCarregadas:= False;
  VprAcessoriosCarregados := false;
  VprImportandoAmostra := false;
  CriaClasses;
  InicializaTela;
  ConfiguraPermissaoUsuario;
  CarregaConfiguracoes;
  PTabelaPreco.TabVisible := not(NomeModulo = 'PDV')
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EPlasticoSelect(Sender: TObject);
begin
  EPlastico.ASelectLocaliza.Text:= 'Select * from CADPRODUTOS ' +
                                 ' Where C_NOM_PRO like ''@%''' +
                                 ' AND C_COD_CLA like ''' + Varia.CodClassificacaoMateriaPrima + '%''' +
                                 ' order by C_NOM_PRO';

  EPlastico.ASelectValida.Text:= 'Select * from CADPRODUTOS ' +
                                 ' Where C_COD_PRO = ''@''';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoProdutoPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprListaImpressoras);
  VprListaImpressoras.Free;
  FreeTObjectsList(VprRepeticoesInstalacao);
  VprRepeticoesInstalacao.Free;
  FunClassificacao.Free;
  FunAmostra.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoProdutoPro.BZoomMenosClick(Sender: TObject);
begin
  ZoomGradeInstalacao(0.80);
end;

procedure TFNovoProdutoPro.BCursorClick(Sender: TObject);
begin
  HabilitaTelaInstalacaoTearFios(false);
end;

procedure TFNovoProdutoPro.BExcluirClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoProdutoPro.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraPermissaoUsuario;
begin
  if not ((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario) or
          (puESCompleto in varia.PermissoesUsuario) or (puFACompleto in varia.PermissoesUsuario)) then
  begin
    AlterarEnabledDet([EValVenda],false);
    AlterarVisibleDet([POrcamentoCadarco,EValCusto,EValVenda,LValVenda,LValCusto],False);
    AlterarVisibleDet([PEmbalagemPvc], False);


    AlteraCampoObrigatorioDet([EValCusto,EValVenda],False);
    if (puVerPrecoCustoProduto in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([EValCusto,LValCusto],True);
    end;
    if (puVerPrecoVendaProduto in varia.PermissoesUsuario) then
      AlterarVisibleDet([EValVenda,LValVenda],True);
    if (puAlterarValorVendaCadastroProduto in Varia.PermissoesUsuario) then
      AlterarEnabledDet([EValVenda],true);

  end;
  EValRevenda.ACampoObrigatorio := config.SugerirPrecoAtacado;
  EValCusto.ACampoObrigatorio:= Config.ExigirPrecoCustoProdutonoCadastro;
  EValVenda.ACampoObrigatorio:= Config.ExigirPrecoVendaProdutonoCadastro;
  PAcessorios.TabVisible := config.MostrarAcessoriosnoProduto;
  PAco.TabVisible := config.ControlarEstoquedeChapas;
  POrcamentoCadarco.TabVisible := config.FabricadeCadarcosdeFitas;

  AlterarEnabledDet([LIPI,EPerIPI],CONFIG.DestacarIPI);

  BMenuFiscal.Visible := (NomeModulo = 'PDV');
  AlterarVisibleDet([BKit],not(NomeModulo = 'PDV'));
  PTabelaPreco.TabVisible := not(NomeModulo = 'PDV');

end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraQtdColunaInstalcao(VpaQtdColunas: Integer);
var
  VpfLacoLinha, VpfLacoColuna, VpfDiferenca : Integer;
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
begin
  if VpaQtdColunas <=0 then
  begin
    aviso('QUANTIDADE DE COLUNAS INVÁLIDA!!!'#13'Quantidade de colunas não pode ser menor que zero.');
    EQtdColInstalacao.Value := GInstalacao.ColCount;
  end
  else
  begin
    VpfDiferenca := VpaQtdColunas - GInstalacao.ColCount;
    if VpfDiferenca > 0 then
    begin
      GInstalacao.ColCount := VpaQtdColunas;
      for VpfLacoColuna := VpaQtdColunas -1 downto 0 do
      begin
        for VpfLacoLinha := 0 to GInstalacao.RowCount - 1 do
        begin
          if VpfLacoColuna < VpfDiferenca then
          begin
            GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha] := '';
            GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha] := nil;
          end
          else
          begin
            GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha] := GInstalacao.Cells[VpfLacoColuna-VpfDiferenca,VpfLacoLinha];
            GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha] := GInstalacao.Objects[VpfLacoColuna-VpfDiferenca,VpfLacoLinha];
          end;
          GInstalacao.ColWidths[VpfLacoColuna] :=GInstalacao.ColWidths[0] ;
        end;
      end;
    end
    else
    begin
      for VpfLacoColuna := (VpfDiferenca *-1) to GInstalacao.ColCount - 1  do
      begin
        for VpfLacoLinha := 0 to GInstalacao.RowCount - 1 do
        begin
          GInstalacao.Cells[VpfLacoColuna+VpfDiferenca,VpfLacoLinha] := GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha];
          GInstalacao.Objects[VpfLacoColuna+VpfDiferenca,VpfLacoLinha] := GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha];
        end;
      end;
      GInstalacao.ColCount := VpaQtdColunas;
    end;


    for VpfLacoLinha := 0 to VprDProduto.DInstalacaoCorTear.Repeticoes.Count - 1 do
    begin
      VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VprDProduto.DInstalacaoCorTear.Repeticoes.Items[VpfLacoLinha]);
      VpfDRepeticao.NumColunaInicial := VpfDRepeticao.NumColunaInicial + VpfDiferenca;
      VpfDRepeticao.NumColunaFinal := VpfDRepeticao.NumColunaFinal + VpfDiferenca;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraQtdLinhaInstalacao(VpaQtdLinhas: Integer);
Var
  VpfDiferenca : Integer;
  VpfLacoLinha, VpfLacoColuna : Integer;
begin
  if VpaQtdLinhas <=0  then
  begin
    aviso('QUANTIDADE DE LINHAS INVÁLIDAS!!!'#13'A quantidade de linhas não pode ser menor que zero.');
    EQtdLinInstalacao.Value := GDPC.rowcount;
  end
  else
  begin
    VpfDiferenca := VpaQtdLinhas - GDPC.RowCount;
    if VpfDiferenca > 0 then
    begin
      GDPC.Rowcount := VpaQtdLinhas;
      for VpflacoLInha := VpaQtdLinhas  downto 0 do
      begin
        for VpfLacoColuna := 0 to GDPC.ColCount -1 do
        begin
          if VpfLacoLinha < VpfDiferenca then
            GDPC.Cells[VpfLacoColuna,VpfLacoLinha] := ''
          else
            GDPC.Cells[VpfLacoColuna,VpfLacoLinha] := GDPC.Cells[VpfLacoColuna,VpfLacoLinha-VpfDiferenca];
        end;
      end;
    end
    else
    begin
      for VpfLacoLinha := (VpfDiferenca *-1) to GDPC.RowCount - 1  do
      begin
        for VpfLacoColuna := 0 to GDPC.ColCount - 1 do
        begin
          GDPC.Cells[VpfLacoColuna,VpfLacoLinha+VpfDiferenca] := GDPC.Cells[VpfLacoColuna,VpfLacoLinha];
        end;
      end;
      GDPC.RowCount := VpaQtdLinhas;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraQtdQuadros(VpaQtdQuadros: Integer);
var
  VpfLacoLinha,VpfLacoColuna, VpfDiferenca : Integer;
begin
  if VpaQtdQuadros <= 0 then
  begin
    aviso('QUANTIDADE DE QUADROS INVÁLIDA!!!'#13'Quantidade de quadros não pode ser menor que zero.');
    EQtdQuadros.Value := GInstalacao.RowCount - 3;
  end
  else
  begin
    VpfDiferenca := VpaQtdQuadros - (GInstalacao.RowCount-3);
    if VpfDiferenca > 0 then
    begin
      GInstalacao.RowCount := VpaQtdQuadros + 3;
      for VpfLacoLinha := VpaQtdQuadros -1 downto 0 do
      begin
        for VpfLacoColuna := 0 to GInstalacao.ColCount - 2 do
        begin
          if VpfLacoLinha < VpfDiferenca then
          begin
            GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha] := '';
            GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha] := nil;
          end
          else
          begin
            GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha] := GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha-VpfDiferenca];
            GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha] := GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha-VpfDiferenca];
          end;
          GInstalacao.ColWidths[VpfLacoColuna] :=GInstalacao.ColWidths[0] ;
        end;
      end;
    end
    else
    begin
      for VpfLacoLinha := (VpfDiferenca *-1) to GInstalacao.RowCount - 1  do
      begin
        for VpfLacoColuna := 0 to GInstalacao.ColCount - 1 do
        begin
          GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha+VpfDiferenca] := GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha];
          GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha+VpfDiferenca] := GInstalacao.Objects[VpfLacoColuna,VpfLacoLinha];
        end;
      end;
      GInstalacao.RowCount := VpaQtdQuadros + 3;
    end;
  end;
  GDPC.ColCount := VpaQtdQuadros;
  for VpfLacoLinha := 0 to VpaQtdQuadros - 1 do
  begin
    GInstalacao.Cells[GInstalacao.ColCount-1,VpfLacoLinha] := IntToStr(VpaQtdQuadros - VpflacoLinha);
    GDPC.Cells[VpfLacoLinha,GDPC.RowCount-1] := IntToStr(VpflacoLinha+1);
    gdpc.ColWidths[VpfLacoLinha]:=GDPC.ColWidths[0];
  end;
  CarInstalacaoRepeticaoGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarregaConfiguracoes;
begin
  ConfiguracoesCodigoBarra;
  ConfiguracoesCadarco;
  ConfiguracoesEtiqueta;
  ConfiguracoesAdicionais;
  ConfiguracoesCopiadora;
  ConfiguracoesCartuchos;
  ConfiguracoesEstagios;
  ConfiguracoesFornecedores;
  PCadarcoFita.TabVisible :=  config.CadastroCadarcoFita;
  PInstalacaoTear.TabVisible := Config.CadastroCadarcoFita;
  PDetectoresMetal.TabVisible := Config.DetectoresMetal;
  PEmbalagemPvc.TabVisible:= Config.CadastroEmbalagemPvc;
  PRotuladoras.TabVisible:= Config.RotuladorasAutomatizadas;
  PFilial.TabVisible:= Config.FilialFaturamento;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCodigoBarra;
begin
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCadarco;
begin
  PCadarco.TabVisible:= Config.CadastroCadarco;
//  EMetrosMinuto.ACampoObrigatorio:= Config.CadastroCadarco;
//  ETipMaquina.ACampoObrigatorio:= Config.CadastroCadarco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesEtiqueta;
begin
  PEtiqueta.TabVisible:= Config.CadastroEtiqueta;
  PCombinacao.TabVisible:= Config.CadastroEtiqueta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesAdicionais;
begin
  // Sem configurações encontradas
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCopiadora;
begin
  PCopiadoras.TabVisible:= Config.ManutencaoImpressoras;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCartuchos;
begin
  PCartuchos.TabVisible:= Config.ManutencaoImpressoras;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesEstagios;
begin
  // Sem configurações encontradas
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesFornecedores;
begin
  // Sem configurações encontradas
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CriaClasses;
begin
  VprDProduto:= TRBDProduto.Cria;
  VprDFornecedor:= TRBDProdutoFornecedor.Cria;
  VprDEstagio:= TRBDEstagioProduto.Cria;
  VprDCombinacao:= TRBDCombinacao.Cria;
  VprListaImpressoras:= TList.Create;
  VprRepeticoesInstalacao := TList.Create;
  FunClassificacao:= TFuncoesClassificacao.criar(Self,FPrincipal.BaseDados);
end;

procedure TFNovoProdutoPro.CSubstituicaoTributariaClick(Sender: TObject);
begin
  if (CSubstituicaoTributaria.Checked) or (EPerST.AValor > 0) then
    VprDProduto.SituacaoTributaria := stSubstituicaoTributaria;
end;

procedure TFNovoProdutoPro.CTipoChange(Sender: TObject);
begin
  if (CTipo.ItemIndex = 2) or (CTipo.ItemIndex = 3)  then //Solda
  begin
    LFerramenta.Visible:= True;
    EFerramenta.Visible:= True;
    LFaca.Visible:= True;
    SpeedButton21.Visible:= True;
    CCorte.Visible:= True;
    LCorteObs.Visible:=true;
    ECorteObs.Visible:= true;

    Label106.Visible:= true;
      EPlastico.Visible:= true;
      SpeedButton16.Visible:= true;
      Label118.Visible:= true;
      EPlastico2.Visible:= true;
      speedbutton18.Visible:= true;
      label129.Visible:= true;
      ELarPvc.Visible:= true;
      Label130.Visible:= true;
      EAltPvc.Visible:= true;
      Label131.Visible:= true;
      EFunPvc.Visible:= true;
      label132.Visible:= true;
      EAbaPvc.Visible:= true;
      Label139.Visible:= true;
      EDiaPvc.Visible:= true;
      label133.Visible:= true;
      CAlca.Visible:= true;
      Label134.Visible:= true;
      ELocalAlca.Visible:= true;
      CCorte.Visible:= true;
      LCorteObs.Visible:= true;
      ECorteObs.Visible:= true;
      CBolso.Visible:= true;
      LInterno1.Visible:= true;
      EInternoPvc.Visible:= true;
      LInterno2.Visible:= true;
      EInternoPvc2.Visible:= true;
      Label141.Visible:= true;
      CImpressao.Visible:= true;
      label142.Visible:= true;
      ECoreslImp.Visible:= true;
      label135.Visible:= true;
      EFotolito.Visible:= true;
      Panel10.Visible:= true;
      Label143.Visible:= true;
      CCabide.Visible:= true;
      CSimCabide.Visible:= true;
      Label144.Visible:= true;
      CBotao.Visible:= true;
      Label146.Visible:= true;
      CBoline.Visible:= true;
      label147.Visible:= true;
      CZiper.Visible:= true;
      label148.Visible:= true;
      ETamZiper.Visible:= true;
      label155.Visible:= true;
      label149.Visible:= true;
      ECorZiper.Visible:= true;
      SpeedButton20.Visible:= true;
      label150.Visible:= true;
      EAdicionais.Visible:= true;
      label152.Visible:= true;
      EPreFaccao.Visible:= true;
      label153.Visible:= true;
      EPrecPvc.Visible:= true;
      LFerramenta.Visible:= true;
      EFerramenta.Visible:= true;
      LFaca.Visible:= true;
      SpeedButton21.Visible:= true;
      Label140.Visible:= true;
      EPenPvc.Visible:= true;
      LPlastico.Visible:= true;
      LPlastico2.Visible:= true;
      LLocalImp.Visible:= true;
      ELocalImp.Visible:= true;

    LLaminaZiper.Visible:= False;
    EFolha2.Visible:= False;
    LLaminaAba.Visible:= False;
    EFolhaMarc.Visible:= False;
    LVies.Visible:= False;
    CVies.Visible:= False;
    RExterno.Checked:= true;
  end
  else
  begin
    if (CTipo.ItemIndex = 1) then     //Costura
    begin
      LLaminaZiper.Visible:= true;
      EFolha2.Visible:= True;
      LLaminaAba.Visible:= true;
      EFolhaMarc.Visible:= true;
      LVies.Visible:= True;
      CVies.Visible:= True;

      Label106.Visible:= true;
      EPlastico.Visible:= true;
      SpeedButton16.Visible:= true;
      Label118.Visible:= true;
      EPlastico2.Visible:= true;
      speedbutton18.Visible:= true;
      label129.Visible:= true;
      ELarPvc.Visible:= true;
      Label130.Visible:= true;
      EAltPvc.Visible:= true;
      Label131.Visible:= true;
      EFunPvc.Visible:= true;
      label132.Visible:= true;
      EAbaPvc.Visible:= true;
      Label139.Visible:= true;
      EDiaPvc.Visible:= true;
      label133.Visible:= true;
      CAlca.Visible:= true;
      Label134.Visible:= true;
      ELocalAlca.Visible:= true;
      CCorte.Visible:= true;
      LCorteObs.Visible:= true;
      ECorteObs.Visible:= true;
      CBolso.Visible:= true;
      //LInterno1.Visible:= true;
      //EInternoPvc.Visible:= true;
      //LInterno2.Visible:= true;
      //EInternoPvc2.Visible:= true;
      Label141.Visible:= true;
      CImpressao.Visible:= true;
      label142.Visible:= true;
      ECoreslImp.Visible:= true;
      label135.Visible:= true;
      EFotolito.Visible:= true;
      Panel10.Visible:= true;
      Label143.Visible:= true;
      CCabide.Visible:= true;
      CSimCabide.Visible:= true;
      Label144.Visible:= true;
      CBotao.Visible:= true;
      LcorBotao.Visible:= true;
      CBotaoCor.Visible:= true;
      label137.Visible:= true;
      EObsBotao.Visible:= true;
      Label146.Visible:= true;
      CBoline.Visible:= true;
      label147.Visible:= true;
      CZiper.Visible:= true;
      label148.Visible:= true;
      ETamZiper.Visible:= true;
      label155.Visible:= true;
      label149.Visible:= true;
      ECorZiper.Visible:= true;
      SpeedButton20.Visible:= true;
      label150.Visible:= true;
      EAdicionais.Visible:= true;
      label152.Visible:= true;
      EPreFaccao.Visible:= true;
      label153.Visible:= true;
      EPrecPvc.Visible:= true;
      LFerramenta.Visible:= true;
      EFerramenta.Visible:= true;
      LFaca.Visible:= true;
      SpeedButton21.Visible:= true;
      Label140.Visible:= true;
      EPenPvc.Visible:= true;
      LPlastico.Visible:= true;
      LPlastico2.Visible:= true;
        LLocalImp.Visible:= true;
      ELocalImp.Visible:= true;

      LFerramenta.Visible:= False;
      EFerramenta.Visible:= False;
      LFaca.Visible:= False;
      SpeedButton21.Visible:= False;
      CCorte.Visible:= False;
      LCorteObs.Visible:= False;
      ECorteObs.Visible:= False;
      RInterno.Checked:= true;
    end
    else
    begin
      if (CTipo.ItemIndex = 5) then     //Materia Prima
    begin
      Label106.Visible:= false;
      EPlastico.Visible:= false;
      SpeedButton16.Visible:= false;
      Label118.Visible:= false;
      EPlastico2.Visible:= false;
      speedbutton18.Visible:= false;
      label129.Visible:= false;
      ELarPvc.Visible:= false;
      Label130.Visible:= false;
      EAltPvc.Visible:= false;
      Label131.Visible:= false;
      EFunPvc.Visible:= false;
      label132.Visible:= false;
      EAbaPvc.Visible:= false;
      Label139.Visible:= false;
      EDiaPvc.Visible:= false;
      label133.Visible:= false;
      CAlca.Visible:= false;
      Label134.Visible:= false;
      ELocalAlca.Visible:= false;
      CCorte.Visible:= False;
      LCorteObs.Visible:= False;
      ECorteObs.Visible:= False;
      LLaminaZiper.Visible:= false;
      EFolha2.Visible:= false;
      LLaminaAba.Visible:= false;
      EFolhaMarc.Visible:= False;
      CBolso.Visible:= false;
      LInterno1.Visible:= false;
      EInternoPvc.Visible:= false;
      LInterno2.Visible:= false;
      EInternoPvc2.Visible:= false;
      Label141.Visible:= false;
      CImpressao.Visible:= false;
      label142.Visible:= false;
      ECoreslImp.Visible:= false;
      label135.Visible:= false;
      EFotolito.Visible:= false;
      Panel10.Visible:= false;
      Label143.Visible:= false;
      CCabide.Visible:= false;
      CSimCabide.Visible:= false;
      Label144.Visible:= false;
      CBotao.Visible:= false;
      LcorBotao.Visible:= false;
      CBotaoCor.Visible:= false;
      label137.Visible:= false;
      EObsBotao.Visible:= false;
      Label146.Visible:= false;
      CBoline.Visible:= false;
      label147.Visible:= false;
      CZiper.Visible:= false;
      label148.Visible:= false;
      ETamZiper.Visible:= false;
      label155.Visible:= false;
      label149.Visible:= false;
      ECorZiper.Visible:= false;
      SpeedButton20.Visible:= false;
      LVies.Visible:= false;
      CVies.Visible:= false;
      label150.Visible:= false;
      EAdicionais.Visible:= false;
      label152.Visible:= false;
      EPreFaccao.Visible:= false;
      label153.Visible:= false;
      EPrecPvc.Visible:= false;
      LFerramenta.Visible:= False;
      EFerramenta.Visible:= False;
      LFaca.Visible:= False;
      SpeedButton21.Visible:= False;
      Label140.Visible:= false;
      EPenPvc.Visible:= false;
      LPlastico.Visible:= false;
      LPlastico2.Visible:= false;
        LLocalImp.Visible:= false;
      ELocalImp.Visible:= false;
      CSimCabide.Visible:= false;
      LcorBotao.Visible:= false;
      CBotaoCor.Visible:= false;
    end
    else
    begin
      EFotolito.Visible:= true;
      LFerramenta.Visible:= False;
      EFerramenta.Visible:= False;
      LFaca.Visible:= False;
      SpeedButton21.Visible:= False;
      CCorte.Visible:= False;
       LLaminaZiper.Visible:= False;
      EFolha2.Visible:= False;
      LLaminaAba.Visible:= False;
      EFolhaMarc.Visible:= False;
      LVies.Visible:= false;
      CVies.Visible:= false;
    end;
  end;
  end;

  if VprOperacao in[ocInsercao, ocEdicao] then
    ValidaGravacao.execute;
end;

procedure TFNovoProdutoPro.CTipoClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoProdutoPro.InicializaTela;
begin
  CarTitulosGrade;
  FunProdutos.CarUnidadesVenda(EUnidadesVenda.Items);
  EUnidadesVenda.ItemIndex:= EUnidadesVenda.Items.IndexOf(Varia.UnidadeUN);
  EUnidadesVendaChange(Self);
  InicializaGrades;
  Paginas.ActivePage:= PGerais;
  ActiveControl:= ECodClassificacao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarTitulosGrade;
begin
  GCombinacao.Cells[1,0]:= 'Comb.';
  GCombinacao.Cells[2,0]:= 'Urdume';
  GCombinacao.Cells[3,0]:= 'Título ';
  GCombinacao.Cells[4,0]:= 'Espula ';
  GCombinacao.Cells[5,0]:= 'Trama';
  GCombinacao.Cells[6,0]:= 'Título';
  GCombinacao.Cells[7,0]:= 'Espula';
  GCombinacao.Cells[8,0]:= 'Cartela';
  GCombinacao.Cells[9,0]:= 'Urd Figura';
  GCombinacao.Cells[10,0]:= 'Título';
  GCombinacao.Cells[11,0]:= 'Nro Fios';
  GCombinacao.ColWidths[8]:= 0;

  GFigura.Cells[1,0]:= 'Figura';
  GFigura.Cells[2,0]:= 'Cor';
  GFigura.Cells[3,0]:= 'Título';
  GFigura.Cells[4,0]:= 'Espula';

  GImpressoras.Cells[1,0] := 'Código';
  GImpressoras.Cells[2,0] := 'Impressora';

  GEstagios.Cells[0,0] := 'ID';
  GEstagios.Cells[1,0] := 'Ordem';
  GEstagios.Cells[2,0] := 'Código';
  GEstagios.Cells[3,0] := 'Estágio';
  GEstagios.Cells[4,0] := 'Descrição';
  GEstagios.Cells[5,0] := 'Qtd Pro. Hora';
  GEstagios.Cells[6,0] := 'Est. Anterior(ID)';
  GEstagios.Cells[7,0] := 'Qtd Estágio Ant';
  GEstagios.Cells[8,0] := 'Config.';
  GEstagios.Cells[9,0] := 'Tempo Config';

  GFornecedores.Cells[1,0]:= 'Código';
  GFornecedores.Cells[2,0]:= 'Cor';
  GFornecedores.Cells[3,0]:= 'Código';
  GFornecedores.Cells[4,0]:= 'Fornecedor';
  GFornecedores.Cells[5,0]:= 'Valor Unitário';
  GFornecedores.Cells[6,0]:= 'Ref Fornecedor';
  GFornecedores.Cells[7,0]:= 'Última Compra';
  GFornecedores.Cells[8,0]:= 'Dias Entrega';
  GFornecedores.Cells[9,0]:= 'Qtd. Mín. Compra';
  GFornecedores.Cells[10,0]:= '% IPI';

  GAcessorios.Cells[1,0]:= 'Código';
  GAcessorios.Cells[2,0]:= 'Descrição';

  GPreco.Cells[1,0] := 'Código';
  GPreco.Cells[2,0] := 'Tabela Preço';
  GPreco.Cells[3,0] := 'Valor Venda';
  GPreco.Cells[4,0] := 'Valor Revenda';
  GPreco.Cells[5,0] := '%Max Deconto';
  GPreco.Cells[6,0] := 'Valor Compra';
  GPreco.Cells[7,0] := 'Valor Custo';
  GPreco.Cells[8,0] := 'Código';
  GPreco.Cells[9,0] := 'Cor';
  GPreco.Cells[10,0] := 'Código';
  GPreco.Cells[11,0] := 'Tamanho';
  GPreco.Cells[12,0] := 'Código';
  GPreco.Cells[13,0] := 'Cliente';
  GPreco.Cells[14,0] := 'Código';
  GPreco.Cells[15,0] := 'Moeda';
  GPreco.Cells[16,0] := 'Qtd Minima';
  GPreco.Cells[17,0] := 'Qtd Pedido';
  GPreco.Cells[18,0] := 'Código de Barra';

  GCombinacaoCadarco.Cells[1,0] := 'Combinação';
  GCombinacaoCadarco.Cells[2,0] := 'Código';
  GCombinacaoCadarco.Cells[3,0] := 'Fio Trama';
  GCombinacaoCadarco.Cells[4,0] := 'Código';
  GCombinacaoCadarco.Cells[5,0] := 'Cor';
  GCombinacaoCadarco.Cells[6,0] := 'Código';
  GCombinacaoCadarco.Cells[7,0] := 'Fio Ajuda';
  GCombinacaoCadarco.Cells[8,0] := 'Código';
  GCombinacaoCadarco.Cells[9,0] := 'Cor';

  GFioOrcamentoCadarco.Cells[2,0] := 'Fio';
  GFioOrcamentoCadarco.Cells[3,0] := 'Peso';

  GFilial.Cells[1,0] := 'Código';
  GFilial.Cells[2,0] := 'Filial';

end;

procedure TFNovoProdutoPro.CBolsoClick(Sender: TObject);
begin
  if CBolso.Checked then
    begin
      AlteraVisibilidadeCampo(LInterno1, EInternoPvc, True);
      AlteraVisibilidadeCampo(LInterno2, EInternoPvc2, True);
      AlteraVisibilidadeCampo(LLocalInt, ELocalInt, True);
    end
    else
    begin
      AlteraVisibilidadeCampo(LInterno1, EInternoPvc, false);
      AlteraVisibilidadeCampo(LInterno2, EInternoPvc2, false);
      AlteraVisibilidadeCampo(LLocalInt, ELocalInt, false);
    end;
end;

procedure TFNovoProdutoPro.CBotaoChange(Sender: TObject);
begin
  CBotaoCor.Visible:= CBotao.ItemIndex > 1;
  LcorBotao.Visible:= CBotao.ItemIndex > 1;
  Label137.Visible:= CBotao.ItemIndex > 1;
  EObsBotao.Visible:= CBotao.ItemIndex > 1;

  if VprOperacao in [ocEdicao,ocInsercao] then
    ValidaGravacao.execute;
end;


procedure TFNovoProdutoPro.CCabideChange(Sender: TObject);
begin
  CSimCabide.Visible:= CCabide.ItemIndex > 1;

  if VprOperacao in [ocEdicao,ocInsercao] then
    ValidaGravacao.execute;
end;

procedure TFNovoProdutoPro.CCorteClick(Sender: TObject);
begin
  if ccorte.Checked then
    begin
      AlteraVisibilidadeCampo(LCorteObs, ECorteObs, True);
    end
    else
    begin
      AlteraVisibilidadeCampo(LCorteObs, ECorteObs, false);
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.InicializaClasseProduto;
begin
  VprImportandoAmostra := false;
  try
    VprDProduto.Free;
  finally
    VprDProduto:= TRBDProduto.Cria;
  end;
  VprDProduto.CodEmpresa:= Varia.CodigoEmpresa;
  VprDProduto.CodEmpFil:= Varia.CodigoEmpFil;
  VprDProduto.CodClassificacao:= VprCodClassificacao;
  VprDProduto.CodProduto:= FunProdutos.ProximoCodigoProduto(VprDProduto.CodClassificacao,Length(varia.MascaraPro));
  VprDProduto.CodMoeda := varia.MoedaBase;
  VprDProduto.CodUsuario := Varia.CodigoUsuario;
  VprDProduto.NumDestinoProduto := Varia.DestinoProduto;

  VprDProduto.SeqProduto:= 0;
  VprDProduto.CodUnidade:= varia.UnidadePadrao;
  VprDProduto.IndProdutoAtivo:= True;
  if copy(VprDProduto.CodClassificacao,1,length(varia.CodClassificacaoMateriaPrima)) <> varia.CodClassificacaoMateriaPrima then
    VprDProduto.DesClassificacaoFiscal := varia.ClassificacaoFiscal;
  VprDProduto.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDProduto.CodUnidade);
  VprDProduto.IndCalandragem:= 'N';
  VprDProduto.IndEngomagem:= 'N';
  VprDProduto.IndCilindro:= 'S';
  VprDProduto.IndComponente:= 'N';
  VprDProduto.IndColorida:= 'S';
  VprDProduto.DesTipTear:= 'M';
  VprDProduto.IndImprimeNaTabelaPreco := 'S';
  VprDProduto.QtdMesesGarantia := 12;
  VprDProduto.IndMonitorarEstoque := false;
  VprDProduto.IndKit := false;
  VprDProduto.ArredondamentoTruncamento := atArredondamento;
  VprDProduto.SituacaoTributaria := stTributadoICMS;
  InicializaGrades;
  // Iniciar os campos de marcação multipla para a tela não ficar suja
end;

{******************************************************************************}
procedure TFNovoProdutoPro.InicializaGrades;
begin
  GCombinacao.ADados:= VprDProduto.Combinacoes;
  GFigura.ADados:= VprDCombinacao.Figuras;
  GEstagios.ADados:= VprDProduto.Estagios;
  GImpressoras.ADados:= VprListaImpressoras;
  GFornecedores.ADados:= VprDProduto.Fornecedores;
  GAcessorios.ADados := VprDProduto.Acessorios;
  GPreco.ADados := VprDProduto.TabelaPreco;
  GCombinacaoCadarco.ADados := VprDProduto.CombinacoesCadarcoTear;
  GFilial.ADados:= VprDProduto.FilialFaturamento;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodEmpresaChange(Sender: TObject);
begin
  if VprOperacao in [ocEdicao,ocInsercao] then
  begin
    ValidaGravacao.execute;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EUnidadesVendaChange(Sender: TObject);
var
  VpfUnidadesParentes : TStringList;
begin
  if VprOperacao in [ocEdicao,ocInsercao] then
  begin
    LQtdCaixa.Visible:= (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeCX) or(EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeKit)
                  or(EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeBarra) or(EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeKilo);
    if (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeKit) then
      LQtdCaixa.Caption := 'Unidades por Kit : '
    else
      if (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeCX) then
        LQtdCaixa.Caption := 'Unidades por Caixa : '
      else
        if (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeBarra) then
          LQtdCaixa.Caption := 'Qtd Metros Barra : '
        else
        if (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeKilo) then
          LQtdCaixa.Caption := 'Peso Milheiro : ';

    EUnidadesPorCaixa.Visible:= LQtdCaixa.Visible;
    EUnidadesPorCaixa.ACampoObrigatorio:= LQtdCaixa.Visible;

    if config.ExigirQdMetrosQuandoDiferenteMT then
    begin
      VpfUnidadesParentes := FunProdutos.RUnidadesParentes('mt');
      EMetCadarco.ACampoObrigatorio := (VpfUnidadesParentes.IndexOf(EUnidadesVenda.TExt) = -1);
    end;

    ValidaGravacao.execute;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EValCustoExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EValCusto.AValor <> VprDProduto.VlrCusto then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.ValCusto := EValCusto.AValor;
      VprDProduto.VlrCusto := EValCusto.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EValRevendaExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EValRevenda.AValor <> VprDProduto.VlrRevenda then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.ValReVenda := EValReVenda.AValor;
      VprDProduto.VlrReVenda := EValReVenda.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EValVendaExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EValVenda.AValor <> VprDProduto.VlrVenda then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.ValVenda := EValVenda.AValor;
      VprDProduto.VlrVenda := EValVenda.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECliPrecoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodCliente := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomCliente := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[8,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[9,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodCliente := 0;
      VprDProTabelaPreco.NomCliente := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodClassificacaoEnter(Sender: TObject);
begin
  VprCodClassificacaoAnterior := EcodClassificacao.text;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodClassificacaoExit(Sender: TObject);
var
  VpfNomeClassificacao: string;
begin
  if ECodClassificacao.Text <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(ECodClassificacao.Text, VpfNomeClassificacao, 'P') then
    begin
      if not LocalizaClassificacao then
        ECodClassificacao.SetFocus;
    end
    else
      LNomClassificacao.Caption:= VpfNomeClassificacao;

    if VprOperacao in [ocinsercao,ocedicao] then
    begin
      if VprCodClassificacaoAnterior <> ECodClassificacao.Text then
      begin
        VprCodClassificacao := ECodClassificacao.Text;
        if Config.QuandoAlteraClassificacaodoProdutoGerarNovoCodigo and config.CodigoProdutoCompostopelaClasificacao then
          ECodProduto.Text := FunProdutos.ProximoCodigoProduto(ECodClassificacao.Text,Length(varia.MascaraPro));
      end;
    end;
  end
  else
    LNomClassificacao.Caption:= '';
end;

{******************************************************************************}
function TFNovoProdutoPro.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomeClassificacao: string;
begin
  Result:= True;
  FLocalizaClassificacao:= TFLocalizaClassificacao.CriarSDI(Application,'',True);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomeClassificacao,'P') then
  begin
    ECodClassificacao.Text:= VpfCodClassificacao;
    LNomClassificacao.Caption:= VpfNomeClassificacao;
    if Config.QuandoAlteraClassificacaodoProdutoGerarNovoCodigo and config.CodigoProdutoCompostopelaClasificacao then
      ECodProduto.Text := FunProdutos.ProximoCodigoProduto(ECodClassificacao.Text,Length(varia.MascaraPro));
  end
  else
    Result:= False;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodClassificacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BZoomMaisClick(Sender: TObject);
begin
  ZoomGradeInstalacao(1.2);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.SalvarImagemAreaTranferenciaWindows1Click(
  Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunProdutos.SalvaImagemdaAreaTransferenciaWindows(VprDProduto);
  LPatFoto.Caption := VprDProduto.PatFoto;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

procedure TFNovoProdutoPro.SpeedButton1Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodMoedaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    ECifraoMoeda.Text:= Retorno1;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodProdutoExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao] then
    if FunProdutos.ExisteProduto(ECodProduto.Text) then
    begin
      ECodProduto.SetFocus;
      aviso('PRODUTO JÁ CADASTRADO!!!'#13'Informe um código que ainda não esteja cadastrado.');
    end;
end;

procedure TFNovoProdutoPro.EComposicaoCadastrar(Sender: TObject);
begin
  FNovaComposicao := TFNovaComposicao.CriarSDI(application,'',true);
  FNovaComposicao.Composicao.Insert;
  FNovaComposicao.showmodal;
  FNovaComposicao.free;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BFotoClick(Sender: TObject);
Var
  VpfNomArquivo : string;
begin
  if VprOperacao in [ocEdicao, ocInsercao] then
  if ExisteArquivo(varia.DriveFoto + LPatFoto.Caption) then
    VpfNomArquivo := varia.DriveFoto + LPatFoto.Caption
  else
    VpfNomArquivo := varia.DriveFoto;

    if EditorImagem.execute(VpfNomArquivo) then
      LPatFoto.Caption:= EditorImagem.PathImagem;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BloquearTela(VpaEstado: Boolean);
begin
  AlteraReadOnlyDet(PanelColor1,0,VpaEstado);
  EQuantidade.ReadOnly:= True;
  if VprOperacao in [ocEdicao,ocInsercao] then
  begin
    if VprOperacao in [ocInsercao] then
    begin
      BKit.Enabled:= False;
      EQuantidade.ReadOnly:= False;      
    end;
    ValidaGravacao.Execute;
  end
  else
  begin
    BGravar.Enabled:= False;
    BFoto.Enabled:= False;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BNovoClick(Sender: TObject);
begin
  HabilitaTelaInstalacaoTearFios(true);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BRepeticaoDesenhoClick(Sender: TObject);
var
  VpfQtdRepeticao : String;
begin
  if EntradaNumero('Quantidade de repetições Desenho','Qtd Repetições : ',VpfqtdRepeticao,false,EValVenda.Color,PanelColor1.Color,false) then
    VprQtdRepeticao := StrToInt(VpfQtdRepeticao)
  else
    BCursor.Down := true;

end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipMaquinaCadastrar(Sender: TObject);
begin
  FMaquinas:= TFMaquinas.CriarSDI(Application,'',True);
  FMaquinas.BotaoCadastrar1.Click;
  FMaquinas.ShowModal;
  FMaquinas.Free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovoProdutoPro.ETipoCadarcoChange(Sender: TObject);
begin
  CalculaOrcamentoCadarco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipFundoCadastrar(Sender: TObject);
begin
  FTipoFundo:= TFTipoFundo.CriarSDI(Application,'',True);
  FTipoFundo.BotaoCadastrar1.Click;
  FTipoFundo.ShowModal;
  FTipoFundo.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipEmendaCadastrar(Sender: TObject);
begin
  FTipoEmenda:= TFTipoEmenda.CriarSDI(Application,'',True);
  FTipoEmenda.BotaoCadastrar1.Click;
  FTipoEmenda.ShowModal;
  FTipoEmenda.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETabelaPrecoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodTabelaPreco := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomTabelaPreco := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[1,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[2,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodTabelaPreco := 0;
      VprDProTabelaPreco.NomTabelaPreco := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETabelaPrecoSelect(Sender: TObject);
begin
  ETabelaPreco.ASelectValida.Text := 'Select I_COD_TAB, C_NOM_TAB '#13+
                          ' from CADTABELAPRECO '#13 +
                          ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                          ' and I_COD_TAB = @';
  ETabelaPreco.ASelectLocaliza.Text := 'Select I_COD_TAB, C_NOM_TAB '#13+
                          ' from CADTABELAPRECO '#13 +
                          ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodTamanho := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomTamanho := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[10,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[11,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodTamanho := 0;
      VprDProTabelaPreco.NomTamanho := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipCorteCadastrar(Sender: TObject);
begin
  FTipoCorte:= TFTipoCorte.CriarSDI(Application,'', True);
  FTipoCorte.BotaoCadastrar1.Click;
  FTipoCorte.ShowModal;
  FTipoCorte.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EEmbalagemCadastrar(Sender: TObject);
begin
  FEmbalagem:= TFEmbalagem.CriarSDI(Application,'',True);
  FEmbalagem.BotaoCadastrar1.Click;
  FEmbalagem.ShowModal;
  FEmbalagem.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EAcondicionamentoCadastrar(Sender: TObject);
begin
  FAcondicionamento:= TFAcondicionamento.CriarSDI(Application,'',True);
  FAcondicionamento.BotaoCadastrar1.Click;
  FAcondicionamento.ShowModal;
  FAcondicionamento.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodCorCadastrar(Sender: TObject);
begin
  FCores:= TFCores.CriarSDI(Application,'',True);
  FCores.BotaoCadastrar1.Click;
  FCores.ShowModal;
  FCores.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EEstagioCadastrar(Sender: TObject);
begin
  FEstagioProducao := TFEstagioProducao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FEstagioProducao'));
  FEstagioProducao.BotaoCadastrar1.Click;
  FEstagioProducao.Showmodal;
  FEstagioProducao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EBatidasTotaisExit(Sender: TObject);
begin
  try
    EBatidasProduto.AInteiro:= RetornaInteiro(EBatidasTotais.AInteiro / (1000 / EComprProduto.AInteiro));
  except
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 115 then
    AlteraFoco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.AlteraFoco;
begin
  if GCombinacao.Focused then
    ActiveControl:= GFigura
  else
    if GFigura.Focused then
      ActiveControl:= GCombinacao;
end;

{******************************************************************************}
function TFNovoProdutoPro.NovoProduto(VpaCodClassificacao: String): TRBDProduto;
begin
  VprCodClassificacao := VpaCodClassificacao;
  VprOperacao:= ocConsulta;
  InicializaClasseProduto;
  VprDProduto.CodClassificacao:= VpaCodClassificacao;
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  VprOperacao:= ocInsercao;
  BloquearTela(False);
  FunProdutos.AdicionaTodasTabelasdePreco(VprDProduto);
  ShowModal;
  if VprAcao then
    Result:= VprDProduto
  else
  begin
    Result:= nil;
    VprDProduto.Free;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.AlterarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): TRBDProduto;
begin
//  EUnidadesVenda.Enabled := false;
  CarProduto(VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  ShowModal;
  Result:= VprDProduto;
end;
{******************************************************************************}
procedure TFNovoProdutoPro.AlteraVisibilidadeCampo(VpaLabel: TLabel;
  VpaCampo: TEditColor; VpaValor: Boolean);
begin
  VpaLabel.Visible:= VpaValor;
  VpaCampo.Visible:= VpaValor;
end;

{******************************************************************************}
function TFNovoProdutoPro.AlteraEstagioProdutos(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
begin
  CarProduto(VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  Paginas.ActivePage := PEstagios;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConsultaFornecedores(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
begin
  VprOperacao:= ocConsulta;
  CarProduto(VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  BloquearTela(True);
  Paginas.ActivePage := PFornecedores;
  ShowModal;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConsultarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
begin
  VprOperacao:= ocConsulta;
  CarProduto(VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  BloquearTela(True);
  ShowModal;
end;

{******************************************************************************}
function TFNovoProdutoPro.DesativarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
var
  VpfResultado: String;
begin
  Result:= False;
  VpfResultado:= '';
  VprOperacao:= ocConsulta;
  FunProdutos.CarDProduto(VprDProduto,VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  VprOperacao:= ocEdicao;
  BloquearTela(True);
  Show;
  if Confirmacao('Deseja desativar o produto "'+VprDProduto.NomProduto+'"?') then
  begin
    VprDProduto.IndProdutoAtivo:= False;
    VpfResultado:= FunProdutos.GravaDProduto(VprDProduto);
    if VpfResultado <> '' then
      aviso(VpfResultado);
    Result:= True;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
  VpfPermiteTrocaPagina: Boolean;
begin
  VpfResultado:= '';
  VpfPermiteTrocaPagina:= False;
  // Carregar os dados da página atual já que os outros são carregados sempre
  // quando saimos da página
  PaginasChanging(Self,VpfPermiteTrocaPagina);
  VpfResultado:= ChamaRotinasGravacao;
  if VpfResultado = '' then
  begin
    if VprImportandoAmostra then
      VpfResultado := FunProdutos.ImportaConsumoAmostra(VprDProduto,VprDAmostra)
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao:= True;
    Close;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BKitClick(Sender: TObject);
begin
  VprDProduto.CodEmpFil:= Varia.CodigoEmpFil;
  FunProdutos.CarDProduto(VprDProduto);
  FMontaKit:= TFMontaKit.CriarSDI(Application,'',True);
  FMontaKit.ConsumoMP(VprDProduto);
  FMontaKit.Free;
end;

procedure TFNovoProdutoPro.BLimpaFotoClick(Sender: TObject);
begin
  LPatFoto.Caption:= '';
end;

{******************************************************************************}
function TFNovoProdutoPro.ChamaRotinasGravacao: String;
begin
  Result:= DadosValidos;
  if result = '' then
  begin
    result := GeraCodigoBarras;
    if result = '' then
    begin
      Result:= FunProdutos.GravaDProduto(VprDProduto);
      if Result = '' then
      begin
        Result:= FunProdutos.GravaDCombinacao(VprDProduto);
        if Result = '' then
        begin
          Result:= FunProdutos.GravaDEstagio(VprDProduto);
          if Result = '' then
          begin
            Result:= FunProdutos.GravaDFornecedor(VprDProduto);
            if VprImpressorasCarregadas then
            begin
              Result:= FunProdutos.GravaProdutoImpressoras(VprDProduto.SeqProduto,VprListaImpressoras);
              if Result = '' then
              begin
                Result:= FunProdutos.InsereProdutoEmpresa(Varia.CodigoEmpresa, VprDProduto,VprOperacao = ocInsercao);
                if Result = '' then
                begin
                  Result:= FunProdutos.GravaDTabelaPreco(VprDProduto);
                  if result = '' then
                  begin
                    result := FunProdutos.GravaDAcessorio(VprDProduto);
                    if result = '' then
                    begin
                      result := FunProdutos.GravaDProdutoInstalacaoTear(VprDProduto,GInstalacao);
                      if result = '' then
                      begin
                        result := FunProdutos.GravaDMateriaPrimaOrcamentoCadarco(VprDProduto);
                        if result = '' then
                        begin
                          result := FunProdutos.GravaDFilialFaturamento(VprDProduto);
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PGerais then
    PosDadosGerais
  else
    if Paginas.ActivePage = PCadarco then
      PosDadosCadarcoTrancado
    else
      if Paginas.ActivePage = PETiqueta then
        PosDadosEtiqueta
      else
        if Paginas.ActivePage = PCombinacao then
          PosDadosCombinacao
        else
          if Paginas.ActivePage = PDadosAdicionais then
            PosDadosAdicionais
          else
            if Paginas.ActivePage = PCopiadoras then
              PosDadosCopiadora
            else
              if Paginas.ActivePage = PCartuchos then
                PosDadosCartucho
              else
                if Paginas.ActivePage = PEstagios then
                  PosDadosEstagios
                else
                  if Paginas.ActivePage = PFornecedores then
                    PosDadosFornecedores
                  else
                    if Paginas.ActivePage = PAcessorios then
                      PosDadosAcessorios
                    else
                      if Paginas.ActivePage = PTabelaPreco then
                        PosDadosTabelaPreco
                      else
                        if Paginas.ActivePage = PInstalacaoTear then
                          PosDadosInstalacaoTear
                        else
                          if Paginas.ActivePage = PAco then
                            PosDadosAco
                          else
                            if Paginas.ActivePage = PDetectoresMetal then
                              PosDadosDetectoresMetal
                            else
                              if Paginas.ActivePage = PCadarcoFita then
                                PosDadosCadarco
                              else
                                if Paginas.ActivePage = POrcamentoCadarco then
                                  PosDadosOrcamentoCadarco
                                else
                                if Paginas.ActivePage = PEmbalagemPvc then
                                  PosDadosEmbalagemPvc;
end;

{******************************************************************************}
function TFNovoProdutoPro.DadosValidos : String;
begin
  result := '';
  if VprOperacao in [ocInsercao] then
  begin
    if FunProdutos.ExisteProduto(ECodProduto.Text) then
    begin
      ECodProduto.SetFocus;
      result := 'PRODUTO JÁ CADASTRADO!!!'#13'Informe um código que ainda não esteja cadastrado.';
    end;
  end
  else
  begin
    if FunProdutos.ExisteCodigoProdutoDuplicado(VprDProduto.SeqProduto,VprDProduto.CodProduto) then
    begin
      Result := 'PRODUTO JÁ CADASTRADO!!!'#13'Informe um código que ainda não esteja cadastrado.';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDTela;
begin
  PosDadosGerais;
  PosDadosCadarcoTrancado;
  PosDadosEtiqueta;
  PosDadosAdicionais;
  PosDadosCopiadora;
  PosDadosCartucho;
  PosDadosOrcamentoCadarco;
  PosDadosEmbalagemPvc;
  PosDadosRotuladoras;
  Paginas.ActivePage:= PGerais;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarGradeProcessoAmostra;
Var
  VpfLaco: Integer;
begin
  VprDAmostra.Processos.First;
  for VpfLaco := 0 to VprDAmostra.Processos.Count - 1 do
  begin
    GEstagios.NovaLinha;
    GEstagios.Cells[0,VpfLaco+1] := IntToStr(VprDProcessoAmostra.SeqProcesso);
    if VprDProcessoAmostra.SeqProcesso <> 0 then
      GEstagios.Cells[1,VpfLaco+1] := IntToStr(VprDProcessoAmostra.SeqProcesso)
    else
      GEstagios.Cells[1,VpfLaco+1] := '';
    if VprDProcessoAmostra.CodEstagio <> 0 then
      GEstagios.Cells[2,VpfLaco+1] := IntTostr(VprDProcessoAmostra.CodEstagio)
    else
      GEstagios.Cells[2,VpfLaco+1] := '';
//    GEstagios.Cells[3,VpfLaco] := VprDProcessoAmostra.NomEstagio;
    GEstagios.Cells[4,VpfLaco+1] := VprDProcessoAmostra.DesObservacoes;

    GEstagios.Cells[5,VpfLaco+1] := FormatFloat('0.0000',VprDProcessoAmostra.QtdProducaoHora);
//    GEstagios.Cells[8,VpfLaco] := VprDProcessoAmostra.Configuracao;
    GEstagios.Cells[9,VpfLaco+1] := VprDProcessoAmostra.DesTempoConfiguracao;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarInstalacaoRepeticaoGrade;
var
  VpfLinha, VpfLacoRepeticao, VpfLacoColuna, VpfLacoLinha : Integer;
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
begin
  for VpfLacoLinha := GInstalacao.RowCount -3 to GInstalacao.RowCount - 1 do
    for VpfLacoColuna := 0 to GInstalacao.ColCount - 2 do
      GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha] := '';

  for VpfLacoRepeticao := 0 to VprDProduto.DInstalacaoCorTear.Repeticoes.Count - 1 do
  begin
    VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VprDProduto.DInstalacaoCorTear.Repeticoes.Items[VpfLacoRepeticao]);
    if (VpfLacoRepeticao mod 2) = 0 then
      VpfLinha := GInstalacao.RowCount-2
    else
      VpfLinha := GInstalacao.RowCount-1;
    GInstalacao.Cells[VpfDRepeticao.NumColunaInicial +((VpfDRepeticao.NumColunaFinal - VpfDRepeticao.NumColunaInicial)div 2),VpfLinha] := IntToStr(VpfDRepeticao.QtdRepeticao);
    for VpflacoColuna := VpfDRepeticao.NumColunaInicial to VpfDRepeticao.NumColunaFinal do
      GInstalacao.Cells[VpflacoColuna,VpfLinha-1] := '&';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosGerais;
begin
  VprCodClassificacaoAnterior := VprDProduto.CodClassificacao;
  ECodClassificacao.Text:= VprDProduto.CodClassificacao;
  ECodProduto.Text:= VprDProduto.CodProduto;
  EDescricao.Text:= VprDProduto.NomProduto;
  ECodMoeda.AInteiro:= VprDProduto.CodMoeda;
  EUsuario.AInteiro := VprDProduto.CodUsuario;
  EUsuario.Atualiza;
  ECifraoMoeda.Text:= VprDProduto.CifraoMoeda;
  EUnidadesVenda.ItemIndex:= EUnidadesVenda.Items.IndexOf(VprDProduto.CodUnidade);
  EClassificacaoFiscal.Text:= VprDProduto.DesClassificacaoFiscal;
  EUnidadesPorCaixa.AValor:= VprDProduto.QtdUnidadesPorCaixa;
  EPerIPI.AValor:= VprDProduto.PerIPI;
  EPerICMS.AValor:= VprDProduto.PerICMS;
  EQtdEntregaFornecedor.AValor:= VprDProduto.QtdDiasEntregaFornecedor;
  EReducaoICMS.AValor:= VprDProduto.PerReducaoICMS;
  EQtdMinima.AValor:= VprDProduto.QtdMinima;
  EPerDesconto.AValor:= VprDProduto.PerDesconto;
  EPerST.AValor:= VprDProduto.PerSubstituicaoTributaria;
  EQtdPedido.AValor:= VprDProduto.QtdPedido;
  EPerComissao.AValor:= VprDProduto.PerComissao;
  EQuantidade.AValor:= VprDProduto.QtdEstoque;
  EOrigemProduto.ItemIndex := VprDProduto.NumOrigemProduto;
  EDestinoProduto.ItemIndex :=  FunProdutos.RNumDestinoProduto(VprDProduto.NumDestinoProduto);
  EPerMaxDesconto.AValor:= VprDProduto.PerMaxDesconto;
  EValCusto.AValor:= VprDProduto.VlrCusto;
  EValVenda.AValor:= VprDProduto.VlrVenda;
  EPerLucro.AValor := VprDProduto.PerLucro;
  CProdutoAtivo.Checked:= VprDProduto.IndProdutoAtivo;
  CSubstituicaoTributaria.Checked := VprDProduto.IndSubstituicaoTributaria;
  CDescontoBaseICMS.Checked := VprDProduto.IndDescontoBaseICMSConfEstado;

  LPatFoto.Caption:= VprDProduto.PatFoto;
  EDescricaoTecnica.Text:= VprDProduto.DesDescricaoTecnica;
  if VprDProduto.IndKit then
    CKit.Checked := true
  else
    CProduto.Checked := true;

  ECodClassificacaoExit(Self);
  ECodMoeda.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosInstalacaoTear;
begin
  GCombinacaoCadarco.CarregaGrade;
  EQtdQuadros.Value := VprDProduto.QtdQuadros;
  EQtdLinInstalacao.Value := VprDProduto.QtdLinhas;
  EQtdColInstalacao.Value := VprDProduto.QtdColunas;
  if EQtdQuadros.Value > 0 then
    ConfiguraQtdQuadros(EQtdQuadros.Value);
  if EQtdColInstalacao.Value > 0 then
    ConfiguraQtdColunaInstalcao(EQtdColInstalacao.Value);
  if EQtdLinInstalacao.Value > 0 then
    ConfiguraQtdLinhaInstalacao(EQtdLinInstalacao.Value);
  CarInstalacaoRepeticaoGrade;
  BCursor.Down := true;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosOrcamentoCadarco;
begin
  if VprDProduto.FiosOrcamentoCadarco.Count = 0 then
  begin
    FunProdutos.CarFiosOrcamentoCadarco(VprDProduto);
    FunProdutos.CarMateriaPrimaOrcamentoCadarco(VprDProduto);
    GFioOrcamentoCadarco.ADados := VprDProduto.FiosOrcamentoCadarco;
    GFioOrcamentoCadarco.CarregaGrade;
    GFioOrcamentoCadarco.Row := 1;
  end;
  ELarguraOrcamentoCadarco.AValor := VprDProduto.LarProduto;
  EQtdBatidasOrcamentoCadarco.Text := VprDProduto.NumBatidasTear;
  case VprDProduto.TipoCadarco of
    tcConvencional: ETipoCadarco.ItemIndex := 0;
    tcCroche: ETipoCadarco.ItemIndex := 1;
    tcRenda : ETipoCadarco.ItemIndex := 2;
    tcElastico : ETipoCadarco.ItemIndex :=3;
  end;
  if VprDProduto.CodUnidade = 'MT' then
    EValUnitarioOrcamentoCadarco.AValor := VprDProduto.VlrVenda*1000
  else
    EValUnitarioOrcamentoCadarco.AValor := VprDProduto.VlrVenda;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosRotuladoras;
begin
  EDescComercial.Text:= VprDProduto.DesComercial;
  MInfoTecnica.Text:= VprDProduto.DesInfoTecnica;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCadarco;
begin
  ETipoFundo.AInteiro :=  VprDProduto.CodTipoFundo;
  ETipoFundo.Atualiza;
  EEngrenagensBat.Text := VprDProduto.Engrenagem;
  ESistemaTear.Text := VprDProduto.SistemaTear;
  EBatidasPorCm.Text := VprDProduto.BatidasPorCm;
  EEngrenagemTrama.Text := VprDProduto.EngrenagemTrama;
  EPenteCadarco.Text := VprDProduto.Pente;
  ELargura.AInteiro := VprDProduto.LarProduto;
  CCalandragemFita.Checked := (VprDProduto.IndCalandragem = 'S');
  CPreEncolhido.Checked := (VprDProduto.IndPreEncolhido = 'S');
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCadarcoTrancado;
begin
  ETipMaquina.AInteiro:= VprDProduto.CodMaquina;
  EMetrosMinuto.AInteiro:= VprDProduto.MetrosPorMinuto;
  EEngEspPequena.Text:= VprDProduto.EngrenagemEspPequena;
  EQtdFuso.AInteiro:= VprDProduto.QuantidadeFusos;
  EMetTabuaPequeno.AInteiro:= VprDProduto.MetrosTabuaPequena;
  EMetTabuaGrande.AInteiro:= VprDProduto.MetrosTabuaGrande;
  EMetTabuaTrans.AInteiro:= VprDProduto.MetrosTabuaTrans;
  EMetCadarco.AInteiro:= VprDProduto.CmpProduto;
  ELargProduto.AInteiro:= VprDProduto.LarProduto;
  EEngEspGrande.Text:= VprDProduto.Engrenagem;
  ENumFios.Text:= VprDProduto.NumFios;
  ETituloFio.Text:= VprDProduto.DesTituloFio;
  EEnchimento.Text:= VprDProduto.DesEnchimento;

  ETipMaquina.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosEtiqueta;
begin
  ESumula.AInteiro:= VprDProduto.CodSumula;
  ELarguraProduto.AInteiro:= VprDProduto.LarProduto;
  EComprProduto.AInteiro:= VprDProduto.CmpProduto;
  if VprDProduto.DatEntradaAmostra > MontaData(1,1,1900) then
    EDatAmostra.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatEntradaAmostra)
  else
    EDatAmostra.Text:= '';
  if VprDProduto.DatSaidaAmostra > MontaData(1,1,1900) then
    EDatSaidaAmostra.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatSaidaAmostra)
  else
    EDatSaidaAmostra.Text:= '';
  EComprFigura.AInteiro:= VprDProduto.CmpFigura;
  ENumeroFios.Text:= VprDProduto.NumFios;
  EPente.Text:= VprDProduto.Pente;
  EBatidasTotais.AInteiro:= VprDProduto.MetrosPorMinuto;
  EBatidasProduto.Text:= VprDProduto.BatProduto;
  EBatidasTear.Text:= VprDProduto.NumBatidasTear;
  ETipFundo.AInteiro:= VprDProduto.CodTipoFundo;
  ETipEmenda.AInteiro:= VprDProduto.CodTipoEmenda;
  ETipCorte.AInteiro:= VprDProduto.CodTipoCorte;
  EIndiceProdutividade.AInteiro:= VprDProduto.PerProdutividade;
  CCalandragem.Checked:= (VprDProduto.IndCalandragem = 'S');
  CEngomagem.Checked:= (VprDProduto.IndEngomagem = 'S');
  EEngrenagem.Text:= VprDProduto.Engrenagem;
  EPrateleiraProduto.Text:= VprDProduto.PraProduto;
  RTearConvencional.Checked:= (VprDProduto.DesTipTear = 'C');
  RTearH.Checked:= not RTearConvencional.Checked;
  ETipFundo.Atualiza;
  ETipEmenda.Atualiza;
  ETipCorte.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCombinacao;
begin
  GCombinacao.ADados := VprDProduto.Combinacoes;
  GCombinacao.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosAdicionais;
begin
  EPesoLiquido.AValor:= VprDProduto.PesoLiquido;
  EPesoBruto.AValor:= VprDProduto.PesoBruto;
  EMesesGarantia.Value := VprDProduto.QtdMesesGarantia;
  EPrateleiraPro.Text:= VprDProduto.PraProduto;
  EEmbalagem.AInteiro:= VprDProduto.CodEmbalagem;
  EAcondicionamento.AInteiro:= VprDProduto.CodAcondicionamento;
  EAlturaProduto.AInteiro:= VprDProduto.AltProduto;
  ECapacidadeLiquida.AValor := VprDProduto.CapLiquida;
  ECodDesenvolvedor.AInteiro:= VprDProduto.CodDesenvolvedor;
  CImprimeTabelaPreco.Checked:= VprDProduto.IndImprimeNaTabelaPreco = 'S';
  CCracha.Checked:= VprDProduto.IndCracha = 'S';
  CProdutoRetornavel.Checked:= VprDProduto.IndProdutoRetornavel = 'S';
  CAgruparBalancim.Checked := VprDProduto.IndAgruparCorteBalancim;
  CMonitorarEstoque.Checked := VprDProduto.IndMonitorarEstoque;
  CRecalcularPreco.Checked := VprDProduto.IndRecalcularPreco;
  ERendimento.Text:= VprDProduto.DesRendimento;
  EDatCadastro.Text := FormatDateTime('DD/MM/YYYY',VprDProduto.DatCadastro);
  EComposicao.AInteiro := VprDProduto.CodComposicao;
  if VprDProduto.ArredondamentoTruncamento = atTruncamento then
    CTruncamento.Checked := true
  else
    CArredondamento.Checked := true;
  case VprDProduto.SituacaoTributaria of
    stIsento : ESituacaoTributaria.ItemIndex := 0;
    stNaoTributado : ESituacaoTributaria.ItemIndex := 1;
    stSubstituicaoTributaria :ESituacaoTributaria.ItemIndex := 2;
    stTributadoICMS : ESituacaoTributaria.ItemIndex := 3 ;
  end;

  EEmbalagem.Atualiza;
  EAcondicionamento.Atualiza;
  ECodDesenvolvedor.Atualiza;
  EComposicao.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCopiadora;
begin
  RMatricial.Checked:= False;
  RJatoTinta.Checked:= False;
  RLaser.Checked:= False;
  if VprDProduto.DesTipTear = 'M' then
    RMatricial.Checked:= True
  else
    if VprDProduto.DesTipTear =  'J' then
      RJatoTinta.Checked:= True
    else
      if VprDProduto.DesTipTear = 'L' then
        RLaser.Checked:= True;
  CCopiadora.Checked:= VprDProduto.IndCopiadora = 'S';
  CMultiFuncional.Checked:= VprDProduto.IndMultiFuncional = 'S';
  CImpressora.Checked:= VprDProduto.IndImpressora = 'S';

  RColorida.Checked:= VprDProduto.IndColorida = 'S';
  RMonoCromatica.Checked:= not RColorida.Checked;
  RMonoComponente.Checked:= VprDProduto.IndComponente = 'N';
  RBiComponente.Checked:= not RMonoComponente.Checked;
  RTonerComCilindro.Checked:= VprDProduto.IndCilindro = 'S';
  RTonerSemCilindro.Checked:= not RTonerComCilindro.Checked;
  CPlacaRede.Checked:= VprDProduto.IndPlacaRede = 'S';
  CPcl.Checked:= VprDProduto.IndPCL = 'S';
  CFax.Checked:= VprDProduto.IndFax = 'S';
  CUSB.Checked:= VprDProduto.IndUSB = 'S';
  CScanner.Checked:= VprDProduto.IndScanner = 'S';
  CWireless.Checked:= VprDProduto.IndWireless = 'S';
  CDuplex.Checked:= VprDProduto.IndDuplex = 'S';
  ECodCartucho.Text:= VprDProduto.CodReduzidoCartucho;
  ECodCartuchoAltaCapacidade.Text:= VprDProduto.CodCartuchoAltaCapac;
  EQtdCopiasToner.AInteiro:= VprDProduto.QtdCopiasTonner;
  EQtdCopiasTonerAltaCapacidade.AInteiro:= VprDProduto.QtdCopiasTonnerAltaCapac;
  EQtdCopiasCilindro.AInteiro:= VprDProduto.QtdCopiasCilindro;
  EQtdPaginasPorMinuto.AInteiro:= VprDProduto.QtdPagPorMinuto;
  EVolumeMensalCopias.AInteiro:= VprDProduto.VolumeMensal;
  if VprDProduto.DatFabricacao > MontaData(1,1,1900) then
    EDatFabricacao.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatFabricacao)
  else
    EDatFabricacao.Text:= '';
  if VprDProduto.DatEncerProducao > MontaData(1,1,1900) then
    EDatEncerramentoProducao.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatEncerProducao)
  else
    EDatEncerramentoProducao.Text:= '';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosDetectoresMetal;
begin
  EAberturaCabeca.Text := VprDProduto.AberturaCabeca;
  EConsumoEletrico.Text := VprDProduto.ConsumoEletrico;
  ETensaoAlimentacao.Text := VprDProduto.TensaoAlimentacao;
  EComunicacaoRede.Text := VprDProduto.ComunicacaoRede;
  EGrauProtecao.Text := VprDProduto.GrauProtecao;
  ESensibilidadeFerrosos.Text := VprDProduto.SensibilidadeFerrosos;
  ESensibilidadeNaoFerrosos.Text := VprDProduto.SensibilidadeNaoFerrosos;
  EAcoInoxidavel.Text := VprDProduto.AcoInoxidavel;
  EDescritivoFuncDetectoresMetal.Lines.Text := VprDProduto.DescritivoFuncDetectoresMetal;
  EInfDisplayDetectoresMetal.Lines.Text := VprDProduto.InfDisplayDetectoresMetal;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCartucho;
begin
  ECodigoReduzido.Text:= VprDProduto.CodReduzidoCartucho;
  EPesoCartuchoVazio.AInteiro:= VprDProduto.PesCartuchoVazio;
  EPesoCartuchoCheio.AInteiro:= VprDProduto.PesCartucho;
  EQtdMl.AInteiro:= VprDProduto.QtdMlCartucho;
  EQtdPaginas.AInteiro:= VprDProduto.QtdPaginas;
  ECodCor.AInteiro:= VprDProduto.CodCorCartucho;
  RCartuchoTinta.Checked:= VprDProduto.DesTipoCartucho = 'TI';
  RCartuchoTonner.Checked:= VprDProduto.DesTipoCartucho= 'TO';
  CChipNovo.Checked:= VprDProduto.IndChipNovo;
  CCilindroNovo.Checked:= VprDProduto.IndCilindroNovo;
  CProdutoOriginal.Checked:= VprDProduto.IndProdutoOriginal;
  CCartuchoTexto.Checked:= VprDProduto.IndCartuchoTexto;
  CProdutoCompativel.Checked:= VprDProduto.IndProdutoCompativel;
  PosImpressoras;

  ECodCor.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosImpressoras;
begin
  if not VprImpressorasCarregadas then
  begin
    FunProdutos.CarProdutoImpressoras(VprDProduto.SeqProduto,VprListaImpressoras);
    VprImpressorasCarregadas:= True;
  end;
  GImpressoras.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosEmbalagemPvc;
begin
  CTipo.ItemIndex:= FunProdutos.RNumEmbalagemPvc(VprDProduto.TipEmbalagem);
  if CTipo.ItemIndex = 0  then
    CTipo.ItemIndex:= - 1;
  CTipoChange(CTipo);
  EPlastico.Text:= FunProdutos.RCodProduto(VprDProduto.SeqProdutoPlastico);
  EPlastico2.Text:= FunProdutos.RCodProduto(VprDProduto.SeqProdutoPlastico2);
  EPlastico.Atualiza;
  EPlastico2.Atualiza;
  EFerramenta.AInteiro:= VprDProduto.CodFerramentaFaca;
  EFerramenta.Atualiza;
  ELarPvc.Text:= VprDProduto.DesLarPvc;
  EAltPvc.Text:= VprDProduto.DesAltPvc;
  EFunPvc.Text:= VprDProduto.DesComFunPvc;
  EAbaPvc.Text:= VprDProduto.DesComAbaPvc;
  EDiaPvc.Text:= VprDProduto.DesComDiametroPvc;
  EPenPvc.Text:= VprDProduto.DesComPendurico;

  CAlca.ItemIndex:= FunProdutos.RNumAlcaEmbalagemPvc(VprDProduto.Alca);
  if CAlca.ItemIndex = 0 then
    CAlca.ItemIndex:= - 1;

  ELocalAlca.Text:= VprDProduto.DesLocalAlca;
  CCorte.Checked:= VprDProduto.IndCorte;
  ECorteObs.Text:= VprDProduto.ObsCorte;
  EFolha2.text:= VprDProduto.ComLaminaZiper;
  EFolhaMarc.Text:= VprDProduto.comLaminaAba;
  CBolso.Checked:= VprDProduto.IndBolso;

  EInternoPvc.Text:= VprDProduto.DesInterno;
  EInternoPvc2.Text:= VprDProduto.DesInterno2;
  ELocalInt.Text:= VprDProduto.DesLocalInt;

  CImpressao.ItemIndex:= FunProdutos.RNumImpEmbalagemPvc(VprDProduto.Impressao);
  if CImpressao.ItemIndex = 0 then
    CImpressao.ItemIndex:= -1;

  ELocalImp.Text:= VprDProduto.DesLocalImp;
  ECoreslImp.Text:= VprDProduto.DesCoresImp;
  EFotolito.Text:= VprDProduto.desFotolito;

  if VprDProduto.InternoExterno = inInterno then
    RInterno.Checked:= true
  else
    if VprDProduto.InternoExterno = inExterno then
      RExterno.Checked:= true;

  CCabide.ItemIndex:= FunProdutos.RNumCabEmbalagemPvc(VprDProduto.Cabide);
  if CCabide.ItemIndex = 0 then
    CCabide.ItemIndex:= - 1;

  CCabideChange(CSimCabide);

  CSimCabide.ItemIndex:= FunProdutos.RNumCorCabEmbalagemPvc(VprDProduto.SimCabide);
  if  CSimCabide.ItemIndex = 0 then
    CSimCabide.ItemIndex:= - 1;

  CBotao.ItemIndex:= FunProdutos.RNumBotaoEmbalagemPvc(VprDProduto.Botao);
  if CBotao.ItemIndex = 0 then
    CBotao.ItemIndex:= - 1;

  CBotaoCor.ItemIndex:= FunProdutos.RNumCorBotaoEmbalagemPvc(VprDProduto.CorBotao);
  if  CBotaoCor.ItemIndex = 0 then
    CBotaoCor.ItemIndex:= - 1;

  CBotaoChange(CBotaoCor);
  EObsBotao.Text:= VprDProduto.ObsBotao;

  CBoline.ItemIndex:= FunProdutos.RNumBolineEmbalagemPvc(VprDProduto.Boline);
  if CBoline.ItemIndex = 0 then
    CBoline.ItemIndex:= - 1;

  CZiper.ItemIndex:= FunProdutos.RNumZiperEmbalagemPvc(VprDProduto.Ziper);
  if CZiper.ItemIndex = 0 then
    CZiper.ItemIndex:= - 1;

  ETamZiper.AValor:= VprDProduto.TamZiper;
  ECorZiper.AInteiro:= VprDProduto.CodCorZiper;
  ECorZiper.Atualiza;

  CVies.ItemIndex:= FunProdutos.RNumViesEmbalagemPvc(VprDProduto.Vies);
  if CVies.ItemIndex = 0 then
    CVies.ItemIndex:= - 1;

  EAdicionais.Text:= VprDProduto.DesAdicionaisPvc;
  EPreFaccao.AValor:= VprDProduto.ValPrecoFaccionista;
  EPrecPvc.AValor:= VprDProduto.ValPrecoPvc;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosEstagios;
begin
  GEstagios.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosFilialFaturamento;
begin
  GFilial.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosFornecedores;
begin
  GFornecedores.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosAcessorios;
begin
  GAcessorios.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosAco;
begin
  EDensidadeVolumetrica.AValor := VprDProduto.DensidadeVolumetrica;
  EEspessuraAco.AValor:= VprDProduto.EspessuraAco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosTabelaPreco;
begin
  GPreco.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PaginasChanging(Sender: TObject; var AllowChange: Boolean);
begin
  // Antes de trocar de página, carrega os dados especificos de determinada página
  // para não haver problema de o usuário perder informação
  // já que quando uma página é selecionada os dados que estão na classe vão para a tela
  if Paginas.ActivePage = PGerais then
    CarDClasseGerais
  else
    if Paginas.ActivePage = PCadarco then
      CarDClasseCadarcoTrancado
    else
      if Paginas.ActivePage = PETiqueta then
        CarDClasseEtiqueta
      else
        if Paginas.ActivePage = PDadosAdicionais then
          CadDClasseAdicionais
        else
          if Paginas.ActivePage = PCopiadoras then
            CarDClasseCopiadora
          else
            if Paginas.ActivePage = PCartuchos then
              CarDClasseCartucho
            else
              if Paginas.ActivePage = PAco then
                CarDClasseAco
              else
                if Paginas.ActivePage = PInstalacaoTear then
                  CarDInstalacaoTear
                else
                  if Paginas.ActivePage = PDetectoresMetal then
                    CarDDetectoresMetal
                  else
                    if Paginas.ActivePage = PCadarcoFita then
                       CarDClasseCadarco
                    else
                      if Paginas.ActivePage = POrcamentoCadarco then
                        CarDClasseOrcamentoCadarco
                    else
                      if Paginas.ActivePage = PEmbalagemPvc then
                        CarDClasseEmbalagemPvc
                      else
                      if Paginas.ActivePage = PRotuladoras then
                        CarDClasseRotuladoras;





  // Obs.: Não precisa carregar as páginas que trabalham apenas com grades.
end;

procedure TFNovoProdutoPro.PanelColor15Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseGerais;
begin
  VprDProduto.CodClassificacao:= ECodClassificacao.Text;
  VprDProduto.CodProduto:= ECodProduto.Text;
  VprDProduto.NomProduto:= EDescricao.Text;
  VprDProduto.CodMoeda:= ECodMoeda.AInteiro;
  VprDProduto.CifraoMoeda:= ECifraoMoeda.Text;
  VprDProduto.CodUnidade:= EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex];
  VprDProduto.DesClassificacaoFiscal:= EClassificacaoFiscal.Text;
  VprDProduto.QtdUnidadesPorCaixa:= Round(EUnidadesPorCaixa.AValor);
  VprDProduto.PerIPI:= EPerIPI.AValor;
  VprDProduto.QtdDiasEntregaFornecedor:= EQtdEntregaFornecedor.AValor;
  VprDProduto.PerReducaoICMS:= EReducaoICMS.AValor;
  VprDProduto.PerICMS:= EPerICMS.AValor;
  VprDProduto.PerSubstituicaoTributaria:= EPerST.AValor;
  VprDProduto.QtdMinima:= EQtdMinima.AValor;
  VprDProduto.PerDesconto:= EPerDesconto.AValor;
  VprDProduto.QtdPedido:= EQtdPedido.AValor;
  VprDProduto.PerComissao:= EPerComissao.AValor;
  VprDProduto.QtdEstoque:= EQuantidade.AValor;
  VprDProduto.NumOrigemProduto:= EOrigemProduto.ItemIndex;

  VprDProduto.NumDestinoProduto := FunProdutos.RTipoDestinoProduto(EDestinoProduto.ItemIndex);

  VprDProduto.PerMaxDesconto:= EPerMaxDesconto.AValor;
  VprDProduto.VlrCusto:= EValCusto.AValor;
  VprDProduto.VlrVenda := EValVenda.AValor;
  VprDProduto.VlrReVenda := EValRevenda.AValor;
  VprDProduto.PerLucro := EPerLucro.AValor;

  VprDProduto.IndProdutoAtivo:= CProdutoAtivo.Checked;
  VprDProduto.IndSubstituicaoTributaria := CSubstituicaoTributaria.Checked;
  VprDProduto.IndDescontoBaseICMSConfEstado := CDescontoBaseICMS.Checked;

  VprDProduto.PatFoto:= LPatFoto.Caption;
  VprDProduto.DesDescricaoTecnica:= EDescricaoTecnica.Text;
  VprDProduto.IndKit := CKit.Checked;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseAco;
begin
  VprDProduto.DensidadeVolumetrica:= EDensidadeVolumetrica.AValor;
  VprDProduto.EspessuraAco := EEspessuraAco.AValor;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseCadarcoTrancado;
begin
  VprDProduto.CodMaquina:= ETipMaquina.AInteiro;
  VprDProduto.MetrosPorMinuto:= EMetrosMinuto.AInteiro;
  VprDProduto.EngrenagemEspPequena:= EEngEspPequena.Text;
  VprDProduto.QuantidadeFusos:= EQtdFuso.AInteiro;
  VprDProduto.MetrosTabuaPequena:= EMetTabuaPequeno.AInteiro;
  VprDProduto.MetrosTabuaGrande:= EMetTabuaGrande.AInteiro;
  VprDProduto.MetrosTabuaTrans:= EMetTabuaTrans.AInteiro;
  VprDProduto.LarProduto:= ELargProduto.AInteiro;
  VprDProduto.Engrenagem:= EEngEspGrande.Text;
  VprDProduto.NumFios:= ENumFios.Text;
  VprDProduto.DesTituloFio:= ETituloFio.Text;
  VprDProduto.DesEnchimento:= EEnchimento.Text;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseCadarco;
begin
  VprDProduto.CodTipoFundo := ETipoFundo.AInteiro;
  VprDProduto.Engrenagem     := EEngrenagensBat.Text;
  VprDProduto.SistemaTear    := ESistemaTear.Text;
  VprDProduto.BatidasPorCm   := EBatidasPorCm.Text;
  VprDProduto.EngrenagemTrama := EEngrenagemTrama.Text;
  VprDProduto.Pente := EPenteCadarco.Text;
  VprDProduto.LarProduto := ELargura.AInteiro;
  if CCalandragemFita.Checked then
    VprDProduto.IndCalandragem := 'S'
  else
    VprDProduto.IndCalandragem := 'N';
  if CPreEncolhido.Checked then
    VprDProduto.IndPreEncolhido := 'S'
  else
    VprDProduto.IndPreEncolhido := 'N';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseEmbalagemPvc;
begin
  VprDProduto.TipEmbalagem:= FunProdutos.RTipoEmbalagemPVC(CTipo.ItemIndex);
  VprDProduto.CodFerramentaFaca:= EFerramenta.AInteiro;
  VprDProduto.DesLarPvc:= ELarPvc.Text;
  VprDProduto.DesAltPvc:= EAltPvc.Text;
  VprDProduto.DesComFunPvc:= EFunPvc.Text;
  VprDProduto.DesComAbaPvc:= EAbaPvc.Text;
  VprDProduto.DesComDiametroPvc:= EDiaPvc.Text;
  VprDProduto.DesComPendurico:= EPenPvc.Text;
  VprDProduto.Alca:= FunProdutos.RAlcaEmbalagemPvc(CAlca.ItemIndex);
  VprDProduto.DesLocalAlca:= ELocalAlca.Text;
  VprDProduto.IndCorte:= CCorte.Checked;
  VprDProduto.ObsCorte:= ECorteObs.Text;
  VprDProduto.ComLaminaZiper:= EFolha2.Text;
  VprDProduto.ComLaminaAba:= EFolhaMarc.Text;
  VprDProduto.IndBolso:=CBolso.Checked;
  VprDProduto.DesInterno:= EInternoPvc.Text;
  VprDProduto.DesInterno2:= EInternoPvc2.Text;
  VprDProduto.DesLocalInt:= ELocalInt.Text;
  VprDProduto.Impressao:= FunProdutos.RImpEmbalagemPvc(CImpressao.ItemIndex);
  VprDProduto.DesLocalImp:= ELocalImp.Text;
  VprDProduto.DesCoresImp:= ECoreslImp.Text;
  VprDProduto.DesFotolito:= EFotolito.Text;
  if RInterno.Checked then
    VprDProduto.InternoExterno:= inInterno
  else
    VprDProduto.InternoExterno:= inExterno;

  VprDProduto.Cabide:= FunProdutos.RCabEmbalagemPvc(CCabide.ItemIndex);
  VprDProduto.SimCabide:= FunProdutos.RSimCabEmbalagemPvc(CSimCabide.ItemIndex);
  VprDProduto.Botao:= FunProdutos.RBotaoEmbalagemPvc(CBotao.ItemIndex);
  VprDProduto.CorBotao:= FunProdutos.RCorBotaoEmbalagemPvc(CBotaoCor.ItemIndex);
  VprDProduto.ObsBotao:= EObsBotao.Text;
  VprDProduto.Boline:= FunProdutos.RBolineEmbalagemPvc(CBoline.ItemIndex);
  VprDProduto.Ziper:= FunProdutos.RZiperEmbalagemPvc(CZiper.ItemIndex);
  VprDProduto.TamZiper:= ETamZiper.AsInteger;
  VprDProduto.CodCorZiper:= ECorZiper.AInteiro;
  VprDProduto.Vies:= FunProdutos.RViesEmbalagemPvc(CVies.ItemIndex);
  VprDProduto.DesAdicionaisPvc:= EAdicionais.Text;
  VprDProduto.ValPrecoFaccionista:= EPreFaccao.AValor;
  VprDProduto.ValPrecoPvc:= EPrecPvc.AValor;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseEtiqueta;
begin
  VprDProduto.CodSumula:= ESumula.AInteiro;
  VprDProduto.LarProduto:= ELarguraProduto.AInteiro;
  if Config.CadastroEtiqueta and not Config.CadastroCadarco then
    VprDProduto.CmpProduto:= EComprProduto.AInteiro
  else
    VprDProduto.CmpProduto:= EMetCadarco.AInteiro;

  if DeletaEspaco(DeletaChars(EDatAmostra.Text,'/')) <> '' then
    VprDProduto.DatEntradaAmostra:= StrToDate(EDatAmostra.Text)
  else
    VprDProduto.DatEntradaAmostra:= MontaData(1,1,1900);
  if DeletaEspaco(DeletaChars(EDatSaidaAmostra.Text,'/')) <> '' then
    VprDProduto.DatSaidaAmostra:= StrToDate(EDatSaidaAmostra.Text)
  else
    VprDProduto.DatSaidaAmostra:= MontaData(1,1,1900);
  VprDProduto.CmpFigura:= EComprFigura.AInteiro;
  VprDProduto.NumFios:= ENumeroFios.Text;
  VprDProduto.Pente:= EPente.Text;
  VprDProduto.MetrosPorMinuto:= EBatidasTotais.AInteiro;
  VprDProduto.BatProduto:= EBatidasProduto.Text;
  VprDProduto.NumBatidasTear:= EBatidasTear.Text;
  VprDProduto.CodTipoFundo:= ETipFundo.AInteiro;
  VprDProduto.CodTipoEmenda:= ETipEmenda.AInteiro;
  VprDProduto.CodTipoCorte:= ETipCorte.AInteiro;
  VprDProduto.PerProdutividade:= EIndiceProdutividade.AInteiro;
  if CCalandragem.Checked then
    VprDProduto.IndCalandragem:= 'S'
  else
    VprDProduto.IndCalandragem:= 'N';
  if CEngomagem.Checked then
    VprDProduto.IndEngomagem:= 'S'
  else
    VprDProduto.IndEngomagem:= 'N';
  VprDProduto.Engrenagem:= EEngrenagem.Text;
  VprDProduto.PraProduto:= EPrateleiraProduto.Text;
  if RTearConvencional.Checked then
    VprDProduto.DesTipTear:= 'C'
  else
    VprDProduto.DesTipTear:= 'H';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CadDClasseAdicionais;
begin
  VprDProduto.PesoLiquido:= EPesoLiquido.AValor;
  VprDProduto.PesoBruto:= EPesoBruto.AValor;
  VprDProduto.QtdMesesGarantia := EMesesGarantia.Value;
  VprDProduto.PraProduto:= EPrateleiraPro.Text;
  VprDProduto.CodEmbalagem:= EEmbalagem.AInteiro;
  VprDProduto.CodAcondicionamento:= EAcondicionamento.AInteiro;
  VprDProduto.CodComposicao := EComposicao.AInteiro;
  VprDProduto.AltProduto:= EAlturaProduto.AInteiro;
  VprDProduto.CapLiquida := ECapacidadeLiquida.AValor;
  VprDProduto.CodDesenvolvedor:= ECodDesenvolvedor.AInteiro;

  if CImprimeTabelaPreco.Checked then
    VprDProduto.IndImprimeNaTabelaPreco:= 'S'
  else
    VprDProduto.IndImprimeNaTabelaPreco:= 'N';
  if CCracha.Checked then
    VprDProduto.IndCracha:= 'S'
  else
    VprDProduto.IndCracha:= 'N';
  if CProdutoRetornavel.Checked then
    VprDProduto.IndProdutoRetornavel:= 'S'
  else
    VprDProduto.IndProdutoRetornavel:= 'N';
  VprDProduto.DesRendimento:= ERendimento.Text;
  if Config.CadastroEtiqueta and not Config.CadastroCadarco then
    VprDProduto.CmpProduto:= EComprProduto.AInteiro
  else
    VprDProduto.CmpProduto:= EMetCadarco.AInteiro;
  VprDProduto.IndMonitorarEstoque := CMonitorarEstoque.Checked;
  VprDProduto.IndAgruparCorteBalancim := CAgruparBalancim.Checked;
  VprDProduto.IndRecalcularPreco := CRecalcularPreco.Checked;
  if CTruncamento.Checked then
    VprDProduto.ArredondamentoTruncamento := atTruncamento
  else
    VprDProduto.ArredondamentoTruncamento := atArredondamento;
  case ESituacaoTributaria.ItemIndex of
     0 : VprDProduto.SituacaoTributaria := stIsento;
     1 : VprDProduto.SituacaoTributaria := stNaoTributado;
     2 : VprDProduto.SituacaoTributaria := stSubstituicaoTributaria;
     3 : VprDProduto.SituacaoTributaria := stTributadoICMS;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CalculaOrcamentoCadarco;
begin
  if (VprOperacao in [ocInsercao,ocEdicao]) then
  begin
    CarDClasseOrcamentoCadarco;
    EValVenda.AValor := FunProdutos.CalculaValorVendaCadarco(VprDProduto);
    EValUnitarioOrcamentoCadarco.AValor := EValVenda.AValor;
    if VprDProduto.CodUnidade = 'MT' then
      EValVenda.AValor := EValVenda.AValor / 1000;
    EValVendaExit(self);
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseCopiadora;
begin
  VprDProduto.DesTipTear:= '';
  if RMatricial.Checked then
    VprDProduto.DesTipTear:= 'M'
  else
    if RJatoTinta.Checked then
      VprDProduto.DesTipTear:= 'J'
    else
      if RLaser.Checked then
        VprDProduto.DesTipTear:= 'L';
  if CCopiadora.Checked then
    VprDProduto.IndCopiadora:= 'S'
  else
    VprDProduto.IndCopiadora:= 'N';
  if CMultiFuncional.Checked then
    VprDProduto.IndMultiFuncional:= 'S'
  else
    VprDProduto.IndMultiFuncional:= 'N';
  if CImpressora.Checked then
    VprDProduto.IndImpressora:= 'S'
  else
    VprDProduto.IndImpressora:= 'N';
  if RColorida.Checked then
    VprDProduto.IndColorida:= 'S'
  else
    VprDProduto.IndColorida:= 'N';
  if RMonoComponente.Checked then
    VprDProduto.IndComponente:= 'N'
  else
    VprDProduto.IndComponente:= 'S';
  if RTonerComCilindro.Checked then
    VprDProduto.IndCilindro:= 'S'
  else
    VprDProduto.IndCilindro:= 'N';
  if CPlacaRede.Checked then
    VprDProduto.IndPlacaRede:= 'S'
  else
    VprDProduto.IndPlacaRede:= 'N';
  if CPcl.Checked then
    VprDProduto.IndPCL:= 'S'
  else
    VprDProduto.IndPCL:= 'N';
  if CFax.Checked then
    VprDProduto.IndFax:= 'S'
  else
    VprDProduto.IndFax:= 'N';
  if CUSB.Checked then
    VprDProduto.IndUSB:= 'S'
  else
    VprDProduto.IndUSB:= 'N';
  if CScanner.Checked then
    VprDProduto.IndScanner:= 'S'
  else
    VprDProduto.IndScanner:= 'N';
  if CWireless.Checked then
    VprDProduto.IndWireless:= 'S'
  else
    VprDProduto.IndWireless:= 'N';
  if CDuplex.Checked then
    VprDProduto.IndDuplex:= 'S'
  else
    VprDProduto.IndDuplex:= 'N';
  VprDProduto.CodReduzidoCartucho:= ECodCartucho.Text;
  VprDProduto.CodCartuchoAltaCapac:= ECodCartuchoAltaCapacidade.Text;
  VprDProduto.QtdCopiasTonner:= EQtdCopiasToner.AInteiro;
  VprDProduto.QtdCopiasTonnerAltaCapac:= EQtdCopiasTonerAltaCapacidade.AInteiro;
  VprDProduto.QtdCopiasCilindro:= EQtdCopiasCilindro.AInteiro;
  VprDProduto.QtdPagPorMinuto:= EQtdPaginasPorMinuto.AInteiro;
  VprDProduto.VolumeMensal:= EVolumeMensalCopias.AInteiro;
  if DeletaEspaco(DeletaChars(EDatFabricacao.Text,'/')) <> '' then
    VprDProduto.DatFabricacao:= StrToDate(EDatFabricacao.Text)
  else
    VprDProduto.DatFabricacao:= MontaData(1,1,1900);
  if DeletaEspaco(DeletaChars(EDatEncerramentoProducao.Text,'/')) <> '' then
    VprDProduto.DatEncerProducao:= StrToDate(EDatEncerramentoProducao.Text)
  else
    VprDProduto.DatEncerProducao:= MontaData(1,1,1900);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseCartucho;
begin
  VprDProduto.CodReduzidoCartucho:= ECodigoReduzido.Text;
  VprDProduto.PesCartuchoVazio:= EPesoCartuchoVazio.AInteiro;
  VprDProduto.PesCartucho:= EPesoCartuchoCheio.AInteiro;
  VprDProduto.QtdMlCartucho:= EQtdMl.AInteiro;
  VprDProduto.QtdPaginas:= EQtdPaginas.AInteiro;
  VprDProduto.CodCorCartucho:= ECodCor.AInteiro;
  if RCartuchoTinta.Checked then
    VprDProduto.DesTipoCartucho := 'TI'
  else
    if RCartuchoTonner.Checked then
      VprDProduto.DesTipoCartucho := 'TO';
  VprDProduto.IndChipNovo:= CChipNovo.Checked;
  VprDProduto.IndCilindroNovo:= CCilindroNovo.Checked;
  VprDProduto.IndProdutoOriginal:= CProdutoOriginal.Checked;
  VprDProduto.IndCartuchoTexto:= CCartuchoTexto.Checked;
  VprDProduto.IndProdutoCompativel:= CProdutoCompativel.Checked;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFornecedor:= TRBDProdutoFornecedor(VprDProduto.Fornecedores.Items[VpaLinha-1]);

  if VprDFornecedor.CodCor = 0 then
    GFornecedores.Cells[1,VpaLinha]:= ''
  else
    GFornecedores.Cells[1,VpaLinha]:= IntToStr(VprDFornecedor.CodCor);
  GFornecedores.Cells[2,VpaLinha]:= VprDFornecedor.NomCor;
  if VprDFornecedor.CodCliente = 0 then
    GFornecedores.Cells[3,VpaLinha]:= ''
  else
    GFornecedores.Cells[3,VpaLinha]:= IntToStr(VprDFornecedor.CodCliente);
  GFornecedores.Cells[4,VpaLinha]:= VprDFornecedor.NomCliente;
  if VprDFornecedor.ValUnitario = 0 then
    GFornecedores.Cells[5,VpaLinha]:= ''
  else
    GFornecedores.Cells[5,VpaLinha]:= FormatFloat(Varia.MascaraValorUnitario,VprDFornecedor.ValUnitario);
  GFornecedores.Cells[6,VpaLinha]:= VprDFornecedor.DesReferencia;

  if VprDFornecedor.DatUltimaCompra > MontaData(1,1,1900) then
    GFornecedores.Cells[7,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDFornecedor.DatUltimaCompra)
  else
    GFornecedores.Cells[7,VpaLinha]:= '';
  if VprDFornecedor.NumDiaEntrega = 0 then
    GFornecedores.Cells[8,VpaLinha]:= ''
  else
    GFornecedores.Cells[8,VpaLinha]:= IntToStr(VprDFornecedor.NumDiaEntrega);
  if VprDFornecedor.QtdMinimaCompra = 0 then
    GFornecedores.Cells[9,VpaLinha]:= ''
  else
    GFornecedores.Cells[9,VpaLinha]:= FloatToStr(VprDFornecedor.QtdMinimaCompra);
  if VprDFornecedor.PerIPI = 0 then
    GFornecedores.Cells[10,VpaLinha]:= ''
  else
    GFornecedores.Cells[10,VpaLinha]:= FormatFloat('##0.00 %',VprDFornecedor.PerIPI);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDFornecedoresClasse;
begin
  if GFornecedores.Cells[1,GFornecedores.ALinha] <> '' then
    VprDFornecedor.CodCor := StrToInt(DeletaChars(GFornecedores.Cells[1,GFornecedores.ALinha],'.'))
  else
    VprDFornecedor.CodCor := 0;
  VprDFornecedor.CodCliente:= StrToInt(GFornecedores.Cells[3,GFornecedores.ALinha]);
  VprDFornecedor.NomCliente:= GFornecedores.Cells[4,GFornecedores.ALinha];
  if GFornecedores.Cells[5,GFornecedores.ALinha] <> '' then
    VprDFornecedor.ValUnitario:= StrToFloat(DeletaChars(GFornecedores.Cells[5,GFornecedores.ALinha],'.'))
  else
    VprDFornecedor.ValUnitario:= 0;
  VprDFornecedor.DesReferencia:= GFornecedores.Cells[6,GFornecedores.ALinha];
  try
    if DeletaChars(DeletaChars(GFornecedores.Cells[7,GFornecedores.ALinha],'/'),' ') <> '' then
      VprDFornecedor.DatUltimaCompra:= StrToDate(GFornecedores.Cells[7,GFornecedores.ALinha]);
  except
    VprDFornecedor.DatUltimaCompra:= MontaData(1,1,1900);
    aviso('DATA INVÁLIDA!!!'#13'Preencha corretamente a data.');
  end;
  if GFornecedores.Cells[8,GFornecedores.ALinha] <> '' then
    VprDFornecedor.NumDiaEntrega:= StrToInt(GFornecedores.Cells[8,GFornecedores.ALinha])
  else
    VprDFornecedor.NumDiaEntrega:= 0;
  if GFornecedores.Cells[9,GFornecedores.ALinha] <> '' then
    VprDFornecedor.QtdMinimaCompra:= StrToFloat(DeletaChars(GFornecedores.Cells[9,GFornecedores.ALinha],'.'))
  else
    VprDFornecedor.QtdMinimaCompra:= 0;
  if GFornecedores.Cells[10,GFornecedores.ALinha] <> '' then
    VprDFornecedor.PerIPI:= StrToFloat(DeletaChars(DeletaChars(DeletaChars(GFornecedores.Cells[10,GFornecedores.ALinha],'%'),'.'),' '))
  else
    VprDFornecedor.PerIPI:= 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDInstalacaoTear;
begin
  VprDProduto.QtdQuadros := EQtdQuadros.Value;
  VprDProduto.QtdLinhas := EQtdLinInstalacao.Value;
  VprDProduto.QtdColunas := EQtdColInstalacao.Value;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDInstalacaoTearTela;
begin
  PosDadosInstalacaoTear;
  FunProdutos.CarDProdutoInstalacaoTear(VprDProduto,GInstalacao);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseOrcamentoCadarco;
begin
  VprDProduto.LarProduto := ELarguraOrcamentoCadarco.AsInteger;
  VprDProduto.NumBatidasTear := EQtdBatidasOrcamentoCadarco.Text;
  case ETipoCadarco.ItemIndex of
    0 : VprDProduto.TipoCadarco := tcConvencional;
    1 : VprDProduto.TipoCadarco := tcCroche;
    2 : VprDProduto.TipoCadarco := tcRenda;
    3 : VprDProduto.TipoCadarco := tcElastico;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseRotuladoras;
begin
  VprDProduto.DesComercial:= EDescComercial.Text;
  VprDProduto.DesInfoTecnica:= MInfoTecnica.Text;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteCor then
  begin
    Aviso('CÓDIGO DA COR NÃO PREENCHIDA!'#13'É necessário preencher o código da cor.');
    VpaValidos:= False;
    GFornecedores.Col:= 1;
  end
  else
    if not ExisteCliente then
    begin
      Aviso('CÓDIGO DO FORNECEDOR NÃO PREENCHIDO!'#13'É necessário preencher o código do fornecedor.');
      VpaValidos:= False;
      GFornecedores.Col:= 3;
    end;

  if VpaValidos then
    CarDFornecedoresClasse;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1, 3, 8, 9: Value:= '0000000;0; ';
    7: Value:= FPrincipal.CorFoco.AMascaraData;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: begin
           case GFornecedores.Col of
             1: ECor.AAbreLocalizacao;
             3: EFornecedor.AAbreLocalizacao;
           end;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GFornecedores.Col of
    6: if Key = '.' then
         Key:= ',';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Fornecedores.Count > 0 then
    VprDFornecedor:= TRBDProdutoFornecedor(VprDProduto.Fornecedores.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresNovaLinha(Sender: TObject);
begin
  VprDFornecedor:= VprDProduto.AddFornecedor;
  VprDFornecedor.CodCliente:= 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GFornecedores.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    if GFornecedores.AColuna <> ACol then
      case GFornecedores.AColuna of
        1: if not ExisteCor then
             if not ECor.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DA COR INVALIDO !!!'#13'É necessário informar o código da cor.');
               GFornecedores.Col:= 1;
             end;
        3: if not ExisteCliente then
             if not EFornecedor.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DO FORNECEDOR INVALIDO !!!'#13'É necessário informar o código do fornecedor.');
               GFornecedores.Col:= 3;
             end;
      end;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteCor: Boolean;
begin
  Result:= True;
  if GFornecedores.Cells[1,GFornecedores.ALinha] <> '' then
  begin
    Result:= FunProdutos.ExisteCor(GFornecedores.Cells[1,GFornecedores.ALinha],VprDFornecedor.NomCor);
    if Result then
    begin
      VprDFornecedor.CodCor:= StrToInt(GFornecedores.Cells[1,GFornecedores.ALinha]);
      GFornecedores.Cells[2,GFornecedores.ALinha]:= VprDFornecedor.NomCor;
    end;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteCliente: Boolean;
begin
  Result:= False;
  if GFornecedores.Cells[3,GFornecedores.ALinha] <> '' then
  begin
    Result:= FunClientes.ExisteCliente(StrToInt(GFornecedores.Cells[3,GFornecedores.ALinha]));
    if Result then
    begin
      EFornecedor.Text:= GFornecedores.Cells[3,GFornecedores.ALinha];
      EFornecedor.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EFerramentaCadastrar(Sender: TObject);
begin
  FFacas:= TFFacas.CriarSDI(Application,'',True);
  FFacas.BotaoCadastrar1.Click;
  FFacas.ShowModal;
  FFacas.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EFilialRetorno(VpaColunas: TRBColunasLocaliza);
begin
  GFilial.Cells[1, GFilial.ALinha]:= VpaColunas[0].AValorRetorno;
  GFilial.Cells[2, GFilial.ALinha]:= VpaColunas[1].AValorRetorno;
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    VprDProFilialFaturamento.CodFilial:= StrToInt(VpaColunas[0].AValorRetorno);
    VprDProFilialFaturamento.NomFilial:= VpaColunas[1].AValorRetorno;
  end
  else
  begin
    VprDProFilialFaturamento.CodFilial:= 0;
    VprDProFilialFaturamento.NomFilial:= '';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EFornecedorRetorno(Retorno1, Retorno2: String);
begin
  if GFornecedores.ALinha > 0 then
  begin
    GFornecedores.Cells[3,GFornecedores.ALinha]:= Retorno1;
    GFornecedores.Cells[4,GFornecedores.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EMoedaRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodMoeda := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomMoeda := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[14,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[15,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodMoeda := 0;
      VprDProTabelaPreco.NomMoeda := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(SELF,'',true);
  FCores.ShowModal;
  FCores.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECorFioAjudaRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDCombinacaoCadarco.CodCorFioAjuda := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDCombinacaoCadarco.NomCorFioAjuda := VpaColunas.items[1].AValorRetorno;
    GCombinacaoCadarco.Cells[8,GCombinacaoCadarco.ALinha] := VpaColunas.items[0].AValorRetorno;
    GCombinacaoCadarco.Cells[9,GCombinacaoCadarco.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDCombinacaoCadarco.CodCorFioAjuda := 0;
    VprDCombinacaoCadarco.NomCorFioAjuda := '';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECorFioTramaRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDCombinacaoCadarco.CodCorFioTrama := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDCombinacaoCadarco.NomCorFioTrama := VpaColunas.items[1].AValorRetorno;
    GCombinacaoCadarco.Cells[4,GCombinacaoCadarco.ALinha] := VpaColunas.items[0].AValorRetorno;
    GCombinacaoCadarco.Cells[5,GCombinacaoCadarco.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDCombinacaoCadarco.CodCorFioTrama := 0;
    VprDCombinacaoCadarco.NomCorFioTrama := '';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECorPrecoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodCor := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomCor := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[8,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[9,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodCor := 0;
      VprDProTabelaPreco.NomCor := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECorRetorno(Retorno1, Retorno2: String);
begin
  if GFornecedores.ALinha > 0 then
  begin
    GFornecedores.Cells[1,GFornecedores.ALinha]:= Retorno1;
    GFornecedores.Cells[2,GFornecedores.ALinha]:= Retorno2;
    if GFornecedores.AEstadoGrade = egNavegacao then
      GFornecedores.AEstadoGrade := egEdicao;
  end;
end;

procedure TFNovoProdutoPro.ECorZiperChange(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoProdutoPro.EDescricaoExit(Sender: TObject);
begin
  if (varia.CNPJFilial = CNPJ_Majatex) then
  begin
    if LPatFoto.Caption = '' then
    begin
      LPatFoto.Caption := CopiaAteChar(CopiaAteChar(EDescricao.Text,'/'),'=')+'0001.jpg';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDEstagio := TRBDEstagioProduto(VprDProduto.Estagios.Items[VpaLinha-1]);
  GEstagios.Cells[0,VpaLinha] := IntToStr(VprDEstagio.SeqEstagio);
  if VprDEstagio.NumOrdem <> 0 then
    GEstagios.Cells[1,VpaLinha] := IntToStr(VprDEstagio.NumOrdem)
  else
    GEstagios.Cells[1,VpaLinha] := '';
  if VprDEstagio.CodEstagio <> 0 then
    GEstagios.Cells[2,VpaLinha] := IntTostr(VprDEstagio.CodEstagio)
  else
    GEstagios.Cells[2,VpaLinha] := '';
  GEstagios.Cells[3,VpaLinha] := VprDEstagio.NomEstagio;
  GEstagios.Cells[4,VpaLinha] := VprDEstagio.DesEstagio;

  GEstagios.Cells[5,VpaLinha] := FormatFloat('0.0000',VprDEstagio.QtdProducaoHora);
  if VprDEstagio.CodEstagioAnterior <> 0 then
    GEstagios.Cells[6,VpaLinha] := InttoStr(VprDEstagio.CodEstagioAnterior)
  else
    GEstagios.Cells[6,VpaLinha] := '';
  if VprDEstagio.QtdEstagioAnterior <> 0 then
    GEstagios.Cells[7,VpaLinha] := IntToStr(VprDEstagio.QtdEstagioAnterior)
  else
    GEstagios.cells[7,VpaLinha] := '';
  GEstagios.Cells[8,VpaLinha] := VprDEstagio.IndConfig;
  GEstagios.Cells[9,VpaLinha] := VprDEstagio.DesTempoConfig;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDEstagio;
begin
  if GEstagios.Cells[1,GEstagios.ALinha] <> '' then
    VprDEstagio.NumOrdem := StrtoInt(Gestagios.Cells[1,GEstagios.ALinha])
  else
    VprDEstagio.Numordem := GEstagios.ALinha;
  VprDEstagio.CodEstagio := StrToInt(GEstagios.Cells[2,GEstagios.ALinha]);
  VprDEstagio.NomEstagio := GEstagios.Cells[3,GEstagios.ALinha];
  VprDEstagio.DesEstagio := GEstagios.Cells[4,GEstagios.ALinha];

  if GEstagios.Cells[5,GEstagios.ALinha] <> '' then
    VprDEstagio.QtdProducaoHora := StrToFloat(GEstagios.Cells[5,GEstagios.ALinha])
  else
    VprDEstagio.QtdproducaoHora := 0;
  if GEstagios.Cells[6,GEstagios.ALinha] <> '' then
    VprDEstagio.CodEstagioAnterior := StrToInt(GEstagios.Cells[6,GEstagios.ALinha])
  else
    VprDEstagio.CodEstagioAnterior := 0;
  if GEstagios.Cells[7,GEstagios.ALinha] <> '' then
    VprDEstagio.QtdEstagioAnterior := StrToInt(GEstagios.Cells[7,GEstagios.Alinha])
  else
    VprDEstagio.QtdEstagioAnterior := 0;
  VprDEstagio.IndConfig := UpperCase(GEstagios.cells[8,GEstagios.ALinha]);
  VprDEstagio.DesTempoConfig := GEstagios.Cells[9,Gestagios.ALinha];
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if GEstagios.Cells[2,GEstagios.ALinha] = '' then
  begin
    aviso('ESTÁGIO NÃO PREENCHIDO!!!'#13'É necessário digitar o código do estagio.');
    GEstagios.col := 2;
  end
  else
    if (GEstagios.Cells[5,GEstagios.ALinha] = '') and (GEstagios.Cells[10,GEstagios.ALinha] = '') then
    begin
      aviso('QUANTIDADE PRODUÇÃO HORA OU TEMPO CONFIGURAÇÃO NÃO PREENCHIDO!!!'#13'É necessário digitar a quantidade produzida por hora ou o tempo de configuração.');
      GEstagios.col := 5;
    end
    else
      if not ExisteEstagio(GEstagios.Cells[2,GEstagios.ALinha]) then
      begin
        aviso('ESTÁGIO INVÁLIDO!!!'#13'O estágio preenchido não existe cadastrado.');
        GEstagios.col := 2;
      end
      else
        VpaValidos := true;
  if VpaValidos then
  begin
    CarDEstagio;

    if VpaValidos then
    begin
      if VprDEstagio.CodEstagio = 0 then
      begin
        aviso('ESTÁGIO NÃO PREENCHIDO!!!'#13'É necessário digitar o código do estagio.');
        GEstagios.col := 2;
        VpaValidos := false;
      end
      else
        if (VprDEstagio.IndConfig = 'N') and (VprDEstagio.QtdProducaoHora = 0) then
        begin
          aviso('QUANTIDADE PRODUÇÃO HORA NÃO PREENCHIDO!!!'#13'É necessário preencher a quantidade produzida em 1 hora.');
          Vpavalidos := false;
          GEstagios.col := 5;
        end
        else
          if (VprDEstagio.IndConfig = 'S') and (DeletaChars(DeletaChars(VprDEstagio.DesTempoConfig,' '),':') = '') then
          begin
            aviso('TEMPO DE CONFIGURAÇÃO NÃO PREENCHIDO!!!'#13'É necessário preencher o tempo de configuração.');
            Vpavalidos := false;
            GEstagios.col := 10;
          end
          else
            if (VprDEstagio.IndConfig <> 'S') and (VprDEstagio.IndConfig <> 'N') then
            begin
              aviso('INDICADOR SE O ESTÁGIO É UMA CONFIGURAÇÃO ESTÁ INVÁLIDO!!!'#13'É necessário preencher o indicador se o estagio é uma configuração ou não com os valores (S/N).');
              Vpavalidos := false;
              GEstagios.col := 9;
            end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosDepoisExclusao(Sender: TObject);
begin
  FunProdutos.ReorganizaSeqEstagio(VprDProduto);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1,2,6,7:  Value := '00000;0; ';
    9: value := '000:00;1;_';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114:
    begin
      case GEstagios.Col of
        2: EEstagio.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GEstagios.Col of
    3: key := #0;
    5: if key = '.' then
          key := ',';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Estagios.Count >0 then
    VprDEstagio:= TRBDEstagioProduto(VprDProduto.Estagios.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosNovaLinha(Sender: TObject);
begin
  VprDEstagio := VprDProduto.AddEstagio;
  VprDEstagio.SeqEstagio := VprDProduto.Estagios.count;
  VprDEstagio.NumOrdem := VprDProduto.Estagios.count;
  VprDEstagio.IndConfig := 'N';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GEstagios.AEstadoGrade in [egInsercao,EgEdicao] then
    if GEstagios.AColuna <> ACol then
    begin
      case GEstagios.AColuna of
        2 : if GEstagios.Cells[2,GEstagios.Alinha] <> '' then
            begin
              if not existeEstagio(GEstagios.Cells[2,GEstagios.Alinha]) then
              begin
                if not EEstagio.AAbreLocalizacao then
                begin
                  Aviso('ESTÁGIO INVÁLIDO!!!'#13'O estágio digitado não existe cadastrado.');
                  GEstagios.Col := 2;
                  abort;
                end;
              end;
            end
            else
              EEstagio.AAbreLocalizacao;
      end;
    end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteEstagio(VpaCodEstagio: String): Boolean;
var
  VpfNomEstagio: String;
begin
  Result:= False;
  if VpaCodEstagio <> '' then
  begin
    Result:= FunProdutos.ExisteEstagio(VpaCodEstagio,VpfNomEstagio);
    if Result then
      GEstagios.Cells[3,GEstagios.ALinha]:= VpfNomEstagio;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EEstagioRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GEstagios.Cells[2,GEstagios.ALinha] := EEstagio.Text;
    GEstagios.Cells[3,GEstagios.ALinha] := retorno1;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCadarcoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDCombinacaoCadarco := TRBDCombinacaoCadarcoTear(VprDProduto.CombinacoesCadarcoTear.Items[VpaLinha-1]);

  if VprDCombinacaoCadarco.CodCombinacao <> 0 then
    GCombinacaoCadarco.Cells[1,VpaLinha]:= IntToStr(VprDCombinacaoCadarco.CodCombinacao)
  else
    GCombinacaoCadarco.Cells[1,VpaLinha]:= '';
  GCombinacaoCadarco.Cells[2,VpaLinha]:= VprDCombinacaoCadarco.CodProdutoFioTrama;
  GCombinacaoCadarco.Cells[3,VpaLinha]:= VprDCombinacaoCadarco.NomProdutoFioTrama;
  if VprDCombinacaoCadarco.CodCorFioTrama <> 0 then
    GCombinacaoCadarco.Cells[4,VpaLinha]:= IntToStr(VprDCombinacaoCadarco.CodCorFioTrama)
  else
    GCombinacaoCadarco.Cells[4,VpaLinha]:= '';
  GCombinacaoCadarco.Cells[5,VpaLinha]:= VprDCombinacaoCadarco.NomCorFioTrama;
  GCombinacaoCadarco.Cells[6,VpaLinha]:= VprDCombinacaoCadarco.CodProdutoFioAjuda;
  GCombinacaoCadarco.Cells[7,VpaLinha]:= VprDCombinacaoCadarco.NomProdutoFioAjuda;
  if VprDCombinacaoCadarco.CodCorFioAjuda <> 0 then
    GCombinacaoCadarco.Cells[8,VpaLinha]:= IntToStr(VprDCombinacaoCadarco.CodCorFioAjuda)
  else
    GCombinacaoCadarco.Cells[8,VpaLinha]:= '';
  GCombinacaoCadarco.Cells[9,VpaLinha]:= VprDCombinacaoCadarco.NomCorFioAjuda;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCadarcoDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if GCombinacaoCadarco.Cells[1,GCombinacaoCadarco.ALinha] = '' then
  begin
    aviso('COMBINAÇÃO NÃO PREENCHIDA!!!'#13'É necessário digitar o código do combinação.');
    GCombinacaoCadarco.col := 1;
  end
  else
    if not ExisteProdutoFioTrama then
    begin
      Aviso('CÓDIGO DO PRODUTO FIO TRAMA NÃO PREENCHIDO!'#13'É necessário preencher o código do produto fio trama.');
      VpaValidos:= False;
      GCombinacaoCadarco.Col:= 2;
    end
    else
      if not ECorFioTrama.AExisteCodigo(GCombinacaoCadarco.Cells[4,GCombinacaoCadarco.ALinha]) then
      begin
        Aviso('CÓDIGO DA COR DO FIO DE TRAMA NÃO PREENCHIDO!'#13'É necessário preencher o código da cor do fio de trama.');
        VpaValidos:= False;
        GFornecedores.Col:= 4;
      end
      else
        if not ExisteProdutoFioAjuda then
        begin
          Aviso('CÓDIGO DO PRODUTO FIO AJUDA NÃO PREENCHIDO!'#13'É necessário preencher o código do produto fio ajuda.');
          VpaValidos:= False;
          GCombinacaoCadarco.Col:= 6;
        end
        else
          if not ECorFioAjuda.AExisteCodigo(GCombinacaoCadarco.Cells[8,GCombinacaoCadarco.ALinha]) then
          begin
            Aviso('CÓDIGO DA COR DO FIO DE AJUDA NÃO PREENCHIDO!'#13'É necessário preencher o código da cor do fio de ajuda.');
            VpaValidos:= False;
            GFornecedores.Col:= 8;
          end;
  if VpaValidos then
    CarDCombinacaoCadarcoTear;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCadarcoGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
  case ACol of
    1 : Value:= '000;0; ';
    4, 8 : Value:= '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCadarcoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: begin
           case GCombinacaoCadarco.Col of
             2: LocalizaProdutoFioTrama;
             4: ECorFioTrama .AAbreLocalizacao;
             6: LocalizaProdutoFioAjuda;
             8: ECorFioAjuda.AAbreLocalizacao;
           end;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCadarcoMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.CombinacoesCadarcoTear.Count > 0 then
    VprDCombinacaoCadarco:= TRBDCombinacaoCadarcoTear(VprDProduto.CombinacoesCadarcoTear.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCadarcoNovaLinha(Sender: TObject);
begin
  VprDCombinacaoCadarco := VprDProduto.AddCombinacaoCadarcoTear;
  VprDCombinacaoCadarco.CodCombinacao := VprDProduto.CombinacoesCadarcoTear.Count;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCadarcoSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GCombinacaoCadarco.AEstadoGrade in [egInsercao,EgEdicao] then
    if GCombinacaoCadarco.AColuna <> ACol then
    begin
      case GCombinacaoCadarco.AColuna of
        2 :if not ExisteProdutoFioTrama then
             if not LocalizaProdutoFioTrama then
             begin
               GCombinacaoCadarco.Cells[2,GCombinacaoCadarco.ALinha] := '';
               GCombinacaoCadarco.Col := 2;
             end;
        4 :if not ECorFioTrama.AExisteCodigo(GCombinacaoCadarco.Cells[4,GCombinacaoCadarco.ALinha]) then
             if not ECorFioTrama.AAbreLocalizacao then
             begin
               GCombinacaoCadarco.Cells[4,GCombinacaoCadarco.ALinha] := '';
               GCombinacaoCadarco.Col := 4;
             end;
        6 :if not ExisteProdutoFioAjuda then
             if not LocalizaProdutoFioAjuda then
             begin
               GCombinacaoCadarco.Cells[6,GCombinacaoCadarco.ALinha] := '';
               GCombinacaoCadarco.Col := 6;
             end;
        8 :if not ECorFioAjuda.AExisteCodigo(GCombinacaoCadarco.Cells[8,GCombinacaoCadarco.ALinha]) then
             if not ECorFioAjuda.AAbreLocalizacao then
             begin
               GCombinacaoCadarco.Cells[8,GCombinacaoCadarco.ALinha] := '';
               GCombinacaoCadarco.Col := 8;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCombinacao := TRBDCombinacao(VprDProduto.Combinacoes.Items[VpaLinha-1]);
  if VprDCombinacao.CodCombinacao <> 0 then
    GCombinacao.Cells[1,VpaLinha] := IntToStr(VprDCombinacao.CodCombinacao)
  else
    GCombinacao.Cells[1,VpaLinha] := '';
  if VprDCombinacao.CorFundo1 <> '' then
    GCombinacao.Cells[2,VpaLinha] := VprDCombinacao.CorFundo1
  else
    GCombinacao.Cells[2,VpaLinha] := '';
  if VprDCombinacao.TituloFundo1 <> '' then
    GCombinacao.Cells[3,VpaLinha] := VprDCombinacao.TituloFundo1
  else
    GCombinacao.Cells[3,VpaLinha] := '';
  if VprDCombinacao.Espula1 <> 0 then
    GCombinacao.Cells[4,VpaLinha] := IntToStr(VprDCombinacao.Espula1)
  else
    GCombinacao.Cells[4,VpaLinha] := '';
  if VprDCombinacao.CorFundo2 <> '' then
    GCombinacao.Cells[5,VpaLinha] := VprDCombinacao.CorFundo2
  else
    GCombinacao.Cells[5,VpaLinha] := '';
  if VprDCombinacao.TituloFundo2 <> '' then
    GCombinacao.Cells[6,VpaLinha] := VprDCombinacao.TituloFundo2
  else
    GCombinacao.Cells[6,VpaLinha] := '';
  if VprDCombinacao.Espula2 <> 0 then
    GCombinacao.Cells[7,VpaLinha] := IntToStr(VprDCombinacao.Espula2)
  else
    GCombinacao.Cells[7,VpaLinha] := '';
  if VprDCombinacao.CorCartela <> 0 then
    GCombinacao.Cells[8,VpaLinha] := IntToStr(VprDCombinacao.CorCartela)
  else
    GCombinacao.Cells[8,VpaLinha] := '';
  if VprDCombinacao.CorUrdumeFigura <> '' then
    GCombinacao.Cells[9,VpaLinha] := VprDCombinacao.CorUrdumeFigura
  else
    GCombinacao.Cells[9,VpaLinha] := '';
  if VprDCombinacao.TituloFundoFigura <> '' then
    GCombinacao.Cells[10,VpaLinha] := VprDCombinacao.TituloFundoFigura
  else
    GCombinacao.Cells[10,VpaLinha] := '';
  if VprDCombinacao.EspulaUrdumeFigura <> 0 then
    GCombinacao.Cells[11,VpaLinha] := IntToStr(VprDCombinacao.EspulaUrdumeFigura)
  else
    GCombinacao.Cells[11,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDCombinacao;
begin
  VprDCombinacao.CodCombinacao := StrToInt(GCombinacao.Cells[1,GCombinacao.ALinha]);
  VprDCombinacao.CorFundo1 := GCombinacao.Cells[2,GCombinacao.ALinha];
  VprDCombinacao.TituloFundo1 := GCombinacao.Cells[3,GCombinacao.ALinha];
  VprDCombinacao.Espula1 :=  StrToInt(GCombinacao.Cells[4,GCombinacao.ALinha]);
  VprDCombinacao.CorFundo2 := GCombinacao.Cells[5,GCombinacao.ALinha];
  VprDCombinacao.TituloFundo2 := GCombinacao.Cells[6,GCombinacao.ALinha];
  VprDCombinacao.Espula2 := StrToInt(GCombinacao.Cells[7,GCombinacao.ALinha]);
  if GCombinacao.Cells[8,GCombinacao.ALinha] <> '' then
    VprDCombinacao.CorCartela := StrToInt(GCombinacao.Cells[8,GCombinacao.ALinha])
  else
    VprDCombinacao.CorCartela := 0;
  if GCombinacao.Cells[9,GCombinacao.ALinha] <> '' then
    VprDCombinacao.CorUrdumeFigura := GCombinacao.Cells[9,GCombinacao.ALinha]
  else
    VprDCombinacao.CorUrdumeFigura := '';
  VprDCombinacao.TituloFundoFigura := GCombinacao.Cells[10,GCombinacao.ALinha];
  if GCombinacao.Cells[11,GCombinacao.ALinha] <> '' then
    VprDCombinacao.EspulaUrdumeFigura := StrToInt(GCombinacao.Cells[11,GCombinacao.ALinha])
  else
    VprDCombinacao.EspulaUrdumeFigura := 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDCombinacaoCadarcoTear;
begin
  if GCombinacaoCadarco.Cells[1,GCombinacaoCadarco.ALinha] <> '' then
    VprDCombinacaoCadarco.CodCombinacao := StrToInt(DeletaChars(GCombinacaoCadarco.Cells[1,GCombinacaoCadarco.ALinha],'.'))
  else
    VprDCombinacaoCadarco.CodCombinacao := 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDDetectoresMetal;
begin
  VprDProduto.AberturaCabeca := EAberturaCabeca.Text;
  VprDProduto.ConsumoEletrico := EConsumoEletrico.Text;
  VprDProduto.TensaoAlimentacao := ETensaoAlimentacao.Text;
  VprDProduto.ComunicacaoRede := EComunicacaoRede.Text;
  VprDProduto.GrauProtecao := EGrauProtecao.Text;
  VprDProduto.SensibilidadeFerrosos := ESensibilidadeFerrosos.Text;
  VprDProduto.SensibilidadeNaoFerrosos := ESensibilidadeNaoFerrosos.Text;
  VprDProduto.AcoInoxidavel := EAcoInoxidavel.Text;
  VprDProduto.DescritivoFuncDetectoresMetal := EDescritivoFuncDetectoresMetal.Lines.Text;
  VprDProduto.InfDisplayDetectoresMetal := EInfDisplayDetectoresMetal.Lines.Text;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if  GCombinacao.Cells[1,GCombinacao.ALinha] = '' then
  begin
    Aviso('COMBINAÇÃO INVÁLIDA!!!'#13'É necessário preencher o código da combinação');
    GCombinacao.Col := 1;
    VpaValidos := false;
  end
  else
    if  GCombinacao.Cells[2,GCombinacao.ALinha] = '' then
    begin
      Aviso('COR FUNDO 1 INVÁLIDA!!!'#13'É necessário preencher a cor de fundo 1');
      GCombinacao.Col := 2;
      VpaValidos := false;
    end
    else
      if  GCombinacao.Cells[3,GCombinacao.ALinha] = '' then
      begin
        Aviso('TÍTULO FUNDO 1 INVÁLIDO!!!'#13'É necessário preencher o título do fundo 1');
        GCombinacao.Col := 3;
        VpaValidos := false;
      end
      else
        if  GCombinacao.Cells[4,GCombinacao.ALinha] = '' then
        begin
          Aviso('ESPULA 1 INVÁLIDO!!!'#13'É necessário preencher a espúla da cor de fundo 1');
          GCombinacao.Col := 4;
          VpaValidos := false;
        end
        else
          if  GCombinacao.Cells[5,GCombinacao.ALinha] = '' then
          begin
            Aviso('COR FUNDO 2 INVÁLIDO!!!'#13'É necessário preencher a cor de fundo 2');
            GCombinacao.Col := 5;
            VpaValidos := false;
          end
          else
            if  GCombinacao.Cells[6,GCombinacao.ALinha] = '' then
            begin
              Aviso('TÍTULO FUNDO 2 INVÁLIDO!!!'#13'É necessário preencher o título do fundo 2');
              GCombinacao.Col := 6;
              VpaValidos := false;
            end
            else
              if  GCombinacao.Cells[7,GCombinacao.ALinha] = '' then
              begin
                Aviso('ESPULA FUNDO 2 INVÁLIDO!!!'#13'É necessário preencher a espúla do  fundo 2');
                GCombinacao.Col := 7;
                VpaValidos := false;
              end;

  if VpaValidos then
  begin
    CarDCombinacao;

    if FunProdutos.CombinacaoDuplicada(VprDProduto) then
    begin
      Aviso('COMBINAÇÃO DUPLICADA!!!'#13'A combinação "'+ InttoStr(VprDCombinacao.CodCombinacao)+'" está duplicada.');
      VpaValidos := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value := '0000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Combinacoes.Count > 0 then
  begin
    VprDCombinacao:= TRBDCombinacao(VprDProduto.Combinacoes.Items[VpaLinhaAtual-1]);
    GFigura.ADados:= VprDCombinacao.Figuras;
    GFigura.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoNovaLinha(Sender: TObject);
begin
  VprDCombinacao := VprDProduto.AddCombinacao;
  VprDCombinacao.Espula1 := 1;
  VprDCombinacao.Espula2 := 1;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GDPCClick(Sender: TObject);
begin
  if BNovo.Down then
  begin
    if (GDPC.row < GDPC.RowCount - 1)then
    begin
      if GDPC.Cells[GDPC.col,GDPC.Row] = '' then
        GDPC.Cells[GDPC.col,GDPC.Row] := '*'
      else
        GDPC.Cells[GDPC.col,GDPC.Row] := '';
    end;
  end
  else
    if BCursor.Down then
    begin
      CarDProdutoInstalacaoTela;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GDPCGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ARow < GDPC.RowCount -1 then
  begin
    if GDPC.Cells[Acol,ARow] = '' then
      ABrush.Color := clInfoBk
    else
      if GDPC.Cells[Acol,ARow] = '*' then
        ABrush.Color := clBlack;
  end
  else
    ABrush.Color := clGray;
end;

{******************************************************************************}
function TFNovoProdutoPro.GeraCodigoBarras: String;
begin
  result := '';
  if (VprOperacao = ocInsercao) then
  begin
    case Varia.TipCodBarras of
      cbEAN13 : VprDProduto.CodBarraFornecedor :=  FunProdutos.RCodBarrasEAN13Disponivel;
    end;
    if VprDProduto.CodBarraFornecedor = 'FIM FAIXA' then
      result :='FINAL DA FAIXA DO CODIGO DE BARRAS!!!'#13'Não existe mais codigo de barras disponivel.'
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFigura := TRBDCombinacaoFigura(VprDCombinacao.Figuras.Items[VpaLinha-1]);
  if VprDFigura.SeqFigura <> 0 then
    GFigura.Cells[1,VpaLinha] := IntToStr(VprDFigura.SeqFigura)
  else
    GFigura.Cells[1,VpaLinha] := '';
  if VprDFigura.CodCor <> '' then
    GFigura.Cells[2,VpaLinha] := VprDFigura.CodCor
  else
    GFigura.Cells[2,VpaLinha] := '';
  if VprDFigura.TitFio <> '' then
    GFigura.Cells[3,VpaLinha] := VprDFigura.TitFio
  else
    GFigura.Cells[3,VpaLinha] := '';
  if VprDFigura.NumEspula <> 0 then
    GFigura.Cells[4,VpaLinha] := IntToStr(VprDFigura.NumEspula)
  else
    GFigura.Cells[4,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDFigura;
begin
  VprDFigura.SeqFigura := StrToInt(GFigura.Cells[1,GFigura.Alinha]);
  VprDFigura.CodCor := GFigura.Cells[2,GFigura.Alinha];
  VprDFigura.TitFio := GFigura.Cells[3,GFigura.Alinha];
  VprDFigura.NumEspula := StrToInt(GFigura.Cells[4,GFigura.Alinha]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDFilialFaturamento;
begin
  VprDProFilialFaturamento.CodFilial:= StrToInt(GFilial.Cells[1, GFilial.ALinha]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDTabelaPreco;
begin
  VprDProTabelaPreco.ValVenda := StrToFloat(DeletaChars(GPreco.Cells[3,GPreco.ALinha],'.'));
  VprDProTabelaPreco.ValReVenda := StrToFloat(DeletaChars(GPreco.Cells[4,GPreco.ALinha],'.'));
  VprDProTabelaPreco.PerMaximoDesconto := StrToFloat(DeletaChars(DeletaChars(DeletaChars(GPreco.Cells[5,GPreco.ALinha],'.'),'%'),' '));
  VprDProTabelaPreco.ValCompra := StrToFloat(DeletaChars(GPreco.Cells[6,GPreco.ALinha],'.'));
  VprDProTabelaPreco.ValCusto := StrToFloat(DeletaChars(GPreco.Cells[7,GPreco.ALinha],'.'));
  VprDProTabelaPreco.QtdMinima := StrToFloat(DeletaChars(GPreco.Cells[16,GPreco.ALinha],'.'));
  VprDProTabelaPreco.QtdIdeal := StrToFloat(DeletaChars(GPreco.Cells[17,GPreco.ALinha],'.'));
  VprDProTabelaPreco.DesCodigodeBarra:= GPreco.Cells[18,GPreco.ALinha];
  VprCodCorPreco := VprDProTabelaPreco.CodCor;
  VprNomCorPreco := VprDProTabelaPreco.NomCor;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
begin
  VprOperacao:= ocConsulta;
  FunProdutos.CarDProduto(VprDProduto,VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  FunProdutos.CarDCombinacao(VprDProduto);
  FunProdutos.CarDEstagio(VprDProduto);
  FunProdutos.CarDFornecedores(VprDProduto);
  FunProdutos.CarAcessoriosProduto(VprDProduto);
  CarDInstalacaoTearTela;
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  VprOperacao:= ocEdicao;
  EUnidadesVendaChange(EUnidadesVenda);
  ConfiguracoesEstagios;
  BloquearTela(False);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if GFigura.Cells[1,GFigura.ALinha] = '' then
  begin
    aviso('SEQUÊNCIA DA FIGURA INVÁLIDA!!!'#13'É necessário preencher o sequencial da figura.');
    GFigura.col := 1;
  end
  else
    if GFigura.Cells[2,GFigura.ALinha] = '' then
    begin
      aviso('COR INVÁLIDA!!!'#13'É necessário preencher a cor da figura.');
      GFigura.col := 2;
    end
    else
      if GFigura.Cells[3,GFigura.ALinha] = '' then
      begin
        aviso('TÍTULO INVÁLIDO!!!'#13'É necessário preencher o título do fio.');
        GFigura.col := 3;
      end
      else
        if GFigura.Cells[4,GFigura.ALinha] = '' then
        begin
          aviso('ESPULA INVÁLIDA!!!'#13'É necessário preencher a espula da figura.');
          GFigura.col := 4;
        end
        else
          VpaValidos := true;
  if VpaValidos then
  begin
    CarDFigura;
    if VprDFigura.SeqFigura = 0 then
    begin
      aviso('SEQUÊNCIA DA FIGURA INVÁLIDA!!!'#13'É necessário preencher o sequencial da figura.');
      GFigura.col := 1;
      VpaValidos := false;
    end
    else
      if VprDFigura.CodCor = '' then
      begin
        aviso('COR INVÁLIDA!!!'#13'É necessário preencher a cor da figura.');
        GFigura.col := 2;
        VpaValidos := false;
      end
      else
        if VprDFigura.TitFio = '' then
        begin
          aviso('TÍTULO INVÁLIDO!!!'#13'É necessário preencher o título do fio.');
          GFigura.col := 3;
          VpaValidos := false;
        end
        else
          if VprDFigura.NumEspula = 0 then
          begin
            aviso('ESPULA INVÁLIDA!!!'#13'É necessário preencher a espula da figura.');
            GFigura.col := 4;
            VpaValidos := false;
          end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value:= '000;0; ';
    4: Value:= '00;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCombinacao <> nil then
    if VprDCombinacao.Figuras.Count >0 then
    begin
      VprDFigura := TRBDCombinacaoFigura(VprDCombinacao.Figuras.Items[VpaLinhaAtual-1]);
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraNovaLinha(Sender: TObject);
begin
  VprDFigura := VprDCombinacao.AddFigura;
  VprDFigura.SeqFigura := VprDCombinacao.Figuras.Count + 1;
  VprDFigura.NumEspula := 1;
  GFigura.Col := 2;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFilialCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProFilialFaturamento:= TRBDFilialFaturamento(VprDProduto.FilialFaturamento.Items[VpaLinha-1]);
  if VprDProFilialFaturamento.CodFilial <> 0 then
    GFilial.Cells[1,VpaLinha] := IntToStr(VprDProFilialFaturamento.CodFilial)
  else
    GFilial.Cells[1,VpaLinha] := '';
  GFilial.Cells[2,VpaLinha] := VprDProFilialFaturamento.NomFilial;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFilialDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not EFilial.AExisteCodigo(GFilial.Cells[1,GFilial.ALinha]) then
  begin
    aviso('FILIAL NÃO PREENCHIDA!!!'#13'É necessário informar o código da filial correta.');
    VpaValidos:= False;
    GFilial.Col:= 1;
  end;
  if VpaValidos then
    CarDFilialFaturamento;
  if VpaValidos then
  BEGIN
    if VprDProFilialFaturamento.CodFilial = 0 then
    begin
      aviso('FILIAL NÃO PREENCHIDA!!!'#13'É necessário informar o código da filial correta.');
      VpaValidos:= False;
      GFilial.Col:= 1;
    end;
  END;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFilialGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  case ACol of
    1: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFilialKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GFilial.Col of
        1 : EFilial.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFilialMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDProduto.FilialFaturamento.Count > 0 then
    VprDProFilialFaturamento := TRBDFilialFaturamento(VprDProduto.FilialFaturamento.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFilialNovaLinha(Sender: TObject);
begin
  VprDProFilialFaturamento := VprDProduto.AddFilialFaturamento;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFilialSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GFilial.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    if GFilial.AColuna <> ACol then
      case GFilial.AColuna of
        1: if not EFilial.AExisteCodigo(GFilial.Cells[1,GFilial.ALinha]) then
             if not EFilial.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DA FILIAL INVALIDA !!!'#13'É necessário informar o código da filial.');
               GFilial.Col:= 1;
             end;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFioOrcamentoCadarcoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDFioOrcamentoCadarco := TRBDProdutoFioOrcamentoCadarco(VprDProduto.FiosOrcamentoCadarco.Items[VpaLinha-1]);
  if VprDFioOrcamentoCadarco.IndSelecionado then
    GFioOrcamentoCadarco.Cells[1,VpaLinha] := '1'
  else
    GFioOrcamentoCadarco.Cells[1,VpaLinha] := '0';

  GFioOrcamentoCadarco.Cells[2,VpaLinha] := VprDFioOrcamentoCadarco.NomProduto;
  if VprDFioOrcamentoCadarco.PesFio <> 0 then
    GFioOrcamentoCadarco.Cells[3,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDFioOrcamentoCadarco.PesFio)
  else
    GFioOrcamentoCadarco.Cells[3,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFioOrcamentoCadarcoCellClick(Button: TMouseButton; Shift: TShiftState; VpaColuna,
  VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) and (VprDProduto.FiosOrcamentoCadarco.Count > 0) then
  begin
    if GFioOrcamentoCadarco.Cells[1,VpaLinha] = '0' then
    begin
      GFioOrcamentoCadarco.Cells[1,VpaLinha]:= '1';
      TRBDProdutoFioOrcamentoCadarco(VprDProduto.FiosOrcamentoCadarco.Items[VpaLinha-1]).IndSelecionado := true;
    end
    else
    begin
      TRBDProdutoFioOrcamentoCadarco(VprDProduto.FiosOrcamentoCadarco.Items[VpaLinha-1]).IndSelecionado := false;
      TRBDProdutoFioOrcamentoCadarco(VprDProduto.FiosOrcamentoCadarco.Items[VpaLinha-1]).PesFio := 0;
      GFioOrcamentoCadarco.Cells[1,VpaLinha]:= '0';
      GFioOrcamentoCadarco.Cells[3,VpaLinha]:= '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFioOrcamentoCadarcoDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if GFioOrcamentoCadarco.Cells[3,GFioOrcamentoCadarco.ALinha] <> '' then
    VprDFioOrcamentoCadarco.PesFio := StrToFloat(DeletaChars(GFioOrcamentoCadarco.Cells[3,GFioOrcamentoCadarco.ALinha],'.'))
  else
    VprDFioOrcamentoCadarco.PesFio := 0;
  if VpaValidos then
    CalculaOrcamentoCadarco;
end;

procedure TFNovoProdutoPro.GFioOrcamentoCadarcoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFioOrcamentoCadarcoKeyPress(Sender: TObject; var Key: Char);
begin
  if not VprDFioOrcamentoCadarco.IndSelecionado then
    key := #0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFioOrcamentoCadarcoMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.FiosOrcamentoCadarco.Count > 0 then
  begin
    VprDFioOrcamentoCadarco := TRBDProdutoFioOrcamentoCadarco(VprDProduto.FiosOrcamentoCadarco.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProImpressora:= TRBDProdutoImpressora(VprListaImpressoras.Items[VpaLinha-1]);
  GImpressoras.Cells[1,VpaLinha] := VprDProImpressora.CodProduto;
  GImpressoras.Cells[2,VpaLinha] := VprDProImpressora.NomProduto;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GImpressoras.Cells[1,GImpressoras.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteImpressora then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GImpressoras.col := 1;
    end;
    if VpaValidos then
    begin
      VpaValidos := not ImpressoraDuplicada;
    end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteImpressora : boolean;
var
  VpfTemp : string;
begin
  if (GImpressoras.Cells[1,GImpressoras.ALinha] <> '') then
  begin
    if GImpressoras.Cells[1,GImpressoras.ALinha] = VprImpressoraAnterior then
      result := true
    else
    begin
      result := FunProdutos.ExisteProduto(GImpressoras.Cells[1,GImpressoras.ALinha],VprDProImpressora.SeqImpressora , VprDProImpressora.NomProduto,VpfTemp);
      if result then
      begin
        VprDProImpressora.CodProduto := GImpressoras.Cells[1,GImpressoras.ALinha];
        GImpressoras.Cells[2,GImpressoras.ALinha] := VprDProImpressora.NomProduto;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteProdutoFioAjuda: Boolean;
var
  VpfTemp : string;
begin
  if (GCombinacaoCadarco.Cells[6,GCombinacaoCadarco.ALinha] <> '') then
  begin
    result := FunProdutos.ExisteProduto(GCombinacaoCadarco.Cells[6,GCombinacaoCadarco.ALinha],VprDCombinacaoCadarco.SeqProdutoFioAjuda, VprDCombinacaoCadarco.NomProdutoFioAjuda,VpfTemp);
    if result then
    begin
      VprDCombinacaoCadarco.CodProdutoFioAjuda := GCombinacaoCadarco.Cells[6,GCombinacaoCadarco.ALinha];
      GCombinacaoCadarco.Cells[7,GCombinacaoCadarco.ALinha] := VprDCombinacaoCadarco.NomProdutoFioAjuda;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteProdutoFioTrama: Boolean;
var
  VpfTemp : string;
begin
  if (GCombinacaoCadarco.Cells[2,GCombinacaoCadarco.ALinha] <> '') then
  begin
    result := FunProdutos.ExisteProduto(GCombinacaoCadarco.Cells[2,GCombinacaoCadarco.ALinha],VprDCombinacaoCadarco.SeqProdutoFioTrama, VprDCombinacaoCadarco.NomProdutoFioTrama,VpfTemp);
    if result then
    begin
      VprDCombinacaoCadarco.CodProdutoFioTrama := GCombinacaoCadarco.Cells[2,GCombinacaoCadarco.ALinha];
      GCombinacaoCadarco.Cells[3,GCombinacaoCadarco.ALinha] := VprDCombinacaoCadarco.NomProdutoFioTrama;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoProdutoPro.ImportaAmostra(VpaCodAmostra: Integer): string;
begin
  result := '';
  VprImportandoAmostra := true;
  VprDAmostra := TRBDAmostra.cria;
  FunAmostra.CarDAmostra(VprDAmostra,VpaCodAmostra);
  ECodClassificacao.Text := VprDAmostra.CodClassificacao;
  ECodProduto.Text := IntToStr(VprDAmostra.CodAmostra);
  EDescricao.Text := VprDAmostra.NomAmostra;
  EUnidadesVenda.ItemIndex := EUnidadesVenda.Items.IndexOf(varia.UnidadeUN);
  result := FunProdutos.ImportaPrecoAmostra(VprDProduto,VprDAmostra);
  EPerComissao.AValor := VprDProduto.PerComissao;
  ECodEmpresaChange(Self);
  //VprDProcessoAmostra:= FunAmostra.CarProcessoAmostraImportacao(VprDAmostra);
  //CarGradeProcessoAmostra;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ImportarProduto1Click(Sender: TObject);
Var
  VpfCodAmostra : String;
begin
  if Entrada('Amostra','Amostra : ',VpfCodAmostra,false,ECor.Color,PanelColor1.Color) then
  begin
    ImportaAmostra(StrToInt(VpfcodAmostra));
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ImpressoraDuplicada: Boolean;
var
  VpfLacoExterno, vpfLacoInterno : Integer;
begin
  result := false;
  for VpfLacoExterno := 0 to VprListaImpressoras.Count -2 do
  begin
    for vpfLacoInterno := VpfLacoExterno +1 to VprListaImpressoras.count -1 do
    begin
      if TRBDProdutoImpressora(VprListaImpressoras.Items[VpfLacoExterno]).SeqImpressora = TRBDProdutoImpressora(VprListaImpressoras.Items[vpfLacoInterno]).SeqImpressora then
      begin
        result := true;
        aviso('IMPRESSORA DUPLICADA!!!'#13'Essa impressora já foi adicionada para esse cartucho');
        exit;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.LocalizaImpressora: Boolean;
var
  VpfTemp, VpfTemp1 : string;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDProImpressora.SeqImpressora,VprDProImpressora.CodProduto,VprDProImpressora.NomProduto,VpfTemp,vpfTemp1); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    GImpressoras.Cells[1,GImpressoras.ALinha] := VprDProImpressora.CodProduto;
    GImpressoras.Cells[2,GImpressoras.ALinha] := VprDProImpressora.NomProduto;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.LocalizaProdutoFioAjuda: Boolean;
var
  VpfTemp, VpfTemp1 : string;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDCombinacaoCadarco.SeqProdutoFioAjuda,VprDCombinacaoCadarco.CodProdutoFioAjuda,VprDCombinacaoCadarco.NomProdutoFioAjuda,VpfTemp,vpfTemp1); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    GCombinacaoCadarco.Cells[6,GCombinacaoCadarco.ALinha] := VprDCombinacaoCadarco.CodProdutoFioAjuda;
    GCombinacaoCadarco.Cells[7,GCombinacaoCadarco.ALinha] := VprDCombinacaoCadarco.NomProdutoFioAjuda;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.LocalizaProdutoFioTrama: Boolean;
var
  VpfTemp, VpfTemp1 : string;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDCombinacaoCadarco.SeqProdutoFioTrama,VprDCombinacaoCadarco.CodProdutoFioTrama,VprDCombinacaoCadarco.NomProdutoFioTrama,VpfTemp,vpfTemp1); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    GCombinacaoCadarco.Cells[2,GCombinacaoCadarco.ALinha] := VprDCombinacaoCadarco.CodProdutoFioTrama;
    GCombinacaoCadarco.Cells[3,GCombinacaoCadarco.ALinha] := VprDCombinacaoCadarco.NomProdutoFioTrama;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114: LocalizaImpressora;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprListaImpressoras.Count > 0 then
  begin
    VprDProImpressora := TRBDProdutoImpressora(VprListaImpressoras.Items[VpaLinhaAtual-1]);
    VprImpressoraAnterior := VprDProImpressora.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasNovaLinha(Sender: TObject);
begin
  VprDProImpressora:= TRBDProdutoImpressora.Create;
  VprListaImpressoras.Add(VprDProImpressora);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GImpressoras.AEstadoGrade in [egInsercao,EgEdicao] then
    if GImpressoras.AColuna <> ACol then
    begin
      case GImpressoras.AColuna of
        1 :if not ExisteImpressora then
           begin
             if not LocalizaImpressora then
             begin
               GImpressoras.Cells[1,GImpressoras.ALinha] := '';
               GImpressoras.Col := 1;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GInstalacaoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if BNovo.Down then
  begin
    if (GInstalacao.Col < GInstalacao.ColCount - 1) and
       (GInstalacao.Row < GInstalacao.RowCount -3) then
    begin
      VpfResultado := DadosProdutoInstalacaoValido;
      if VpfResultado = '' then
      begin
        CarDProdutoInstalacao;
        GInstalacao.Cells[GInstalacao.col,GInstalacao.Row] := '*'
      end
      else
        aviso(VpfResultado);
    end;
  end
  else
    if BCursor.Down then
    begin
      CarDProdutoInstalacaoTela;
    end
    else
      if BExcluir.Down then
      begin
        if (GInstalacao.Row > GInstalacao.RowCount -4) then
        begin
          FunProdutos.ExcluiInstalacaoRepeticao(VprDProduto,GInstalacao.Col);
          CarInstalacaoRepeticaoGrade;
        end
        else
        begin
          GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row].Free;
          GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row] := nil;
          GInstalacao.cells[GInstalacao.Col,GInstalacao.Row] := '';
          CarDProdutoInstalacaoTela;
        end;
      end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GInstalacaoGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ACol < GInstalacao.ColCount -1 then
  begin
    if GInstalacao.Cells[Acol,ARow] = '' then
      ABrush.Color := clInfoBk
    else
      if GInstalacao.Cells[Acol,ARow] = '*' then
        ABrush.Color := clBlack
      else
        if GInstalacao.Cells[Acol,ARow] = '&' then
          ABrush.Color := clBlue;
  end
  else
    ABrush.Color := clGray;
end;

procedure TFNovoProdutoPro.GInstalacaoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  GInstalacao.MouseToCell(x,y,VprColunaInicial,VprLinhaInicial);
  if (VprLinhaInicial = GInstalacao.RowCount -3) then
  begin

  end;
end;

{***********************************************************************}
procedure TFNovoProdutoPro.GInstalacaoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Vpfqtd : String;
  VpfResultado : String;
begin
  if BRepeticaoDesenho.Down then
  begin
    GInstalacao.MouseToCell(x,y,VprColunaFinal,VprLinhaFinal);
    VpfResultado := FunProdutos.AdicionaRepeticaoInstalacaoTear(VprDProduto,VprColunaInicial,VprColunaFinal,VprQtdRepeticao);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      CarInstalacaoRepeticaoGrade;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoAntesExclusao(Sender: TObject; var VpaPermiteExcluir: Boolean);
begin
  if VprOperacao = ocEdicao then
  begin
    if VprDProTabelaPreco.QtdEstoque <> 0 then
    begin
      VpaPermiteExcluir := false;
      aviso('NÃO É PERMITIDO EXCLUIR O ITEM DO ESTOQUE!!!'#13'Esse item possui "'+FormatFloat('#,###,##0.00',VprDProTabelaPreco.QtdEstoque)+'" itens em estoque, é necessário antes zerar o estoque para depois excluir.');
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDProTabelaPreco := TRBDProdutoTabelaPreco(VprDProduto.TabelaPreco.Items[VpaLinha-1]);
  if VprDProTabelaPreco.CodTabelaPreco <> 0 then
    GPreco.Cells[1,VpaLinha] := IntToStr(VprDProTabelaPreco.CodTabelaPreco)
  else
    GPreco.Cells[1,VpaLinha] := '';
  GPreco.Cells[2,VpaLinha] := VprDProTabelaPreco.NomTabelaPreco;
  GPreco.Cells[3,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValVenda);
  GPreco.Cells[4,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValReVenda);
  GPreco.Cells[5,VpaLinha] := FormatFloat('0.00%',VprDProTabelaPreco.PerMaximoDesconto);
  GPreco.Cells[6,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValCompra);
  GPreco.Cells[7,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValCusto);
  if VprDProTabelaPreco.CodCor <> 0 then
    GPreco.Cells[8,VpaLinha] := IntToStr(VprDProTabelaPreco.CodCor)
  else
    GPreco.Cells[8,VpaLinha] := '';
  GPreco.Cells[9,VpaLinha] := VprDProTabelaPreco.NomCor;
  if VprDProTabelaPreco.CodTamanho <> 0 then
    GPreco.Cells[10,VpaLinha] := IntToStr(VprDProTabelaPreco.CodTamanho)
  else
    GPreco.Cells[10,VpaLinha] := '';
  GPreco.Cells[11,VpaLinha] := VprDProTabelaPreco.NomTamanho;
  if VprDProTabelaPreco.CodCliente <> 0 then
    GPreco.Cells[12,VpaLinha] := IntToStr(VprDProTabelaPreco.CodCliente)
  else
    GPreco.Cells[12,VpaLinha] := '';
  GPreco.Cells[13,VpaLinha] := VprDProTabelaPreco.NomCliente;
  if VprDProTabelaPreco.CodMoeda <> 0 then
    GPreco.Cells[14,VpaLinha] := IntToStr(VprDProTabelaPreco.CodMoeda)
  else
    GPreco.Cells[14,VpaLinha] := '';
  GPreco.Cells[15,VpaLinha] := VprDProTabelaPreco.NomMoeda;
  GPreco.Cells[16,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDProTabelaPreco.QtdMinima);
  GPreco.Cells[17,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDProTabelaPreco.QtdIdeal);
  GPreco.Cells[18,VpaLinha] := VprDProTabelaPreco.DesCodigodeBarra;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ETabelaPreco.AExisteCodigo(GPreco.Cells[1,GPreco.ALinha]) then
  begin
    aviso('TABELA DE PREÇO NÃO CADASTRADA!!!'#13'É necessário preencher a tabela de preço.');
    VpaValidos:= False;
    GPreco.Col:= 1;
  end
  else
    if not ECorPreco.AExisteCodigo(GPreco.Cells[8,GPreco.ALinha]) then
    begin
      aviso('COR NÃO CADASTRADA!!!'#13'A cor digitada não existe cadastrada');
      VpaValidos:= False;
      GPreco.Col:= 8;
    end
    else
      if not ETamanho.AExisteCodigo(GPreco.Cells[10,GPreco.ALinha]) then
      begin
        aviso('TAMANHO NÃO CADASTRADO!!!'#13'O tamanho digitado não existe cadastrado');
        VpaValidos:= False;
        GPreco.Col:= 10;
      end
      else
        if not ECliPreco.AExisteCodigo(GPreco.Cells[12,GPreco.ALinha]) then
        begin
          aviso('CLIENTE NÃO CADASTRADO!!!'#13'O cliente digitado não existe cadastrado');
          VpaValidos:= False;
          GPreco.Col:= 12;
        end
        else
          if not EMoeda.AExisteCodigo(GPreco.Cells[14,GPreco.ALinha]) then
          begin
            aviso('MOEDA NÃO CADASTRADA!!!'#13'A moeda digitada não existe cadastrada');
            VpaValidos:= False;
            GPreco.Col:= 14;
          end;

  if VpaValidos then
  begin
    CarDTabelaPreco;
    if FunProdutos.ExisteTabelaPrecoDuplicado(VprDProduto) then
    begin
      aviso('TABELA DE PREÇO DUPLICADO!!!'#13'A tabela de preço digitado já existe digitado para essa cor e tamanho');
      VpaValidos:= False;
      GPreco.Col:= 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  case ACol of
    1,8,10,12,14: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GPreco.Col of
        1 : ETabelaPreco.AAbreLocalizacao;
        6 : ECorPreco.AAbreLocalizacao;
        10 : ETamanho.AAbreLocalizacao;
        12 : ECliPreco.AAbreLocalizacao;
        14: EMoeda.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.TabelaPreco.Count > 0 then
    VprDProTabelaPreco := TRBDProdutoTabelaPreco(VprDProduto.TabelaPreco.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoNovaLinha(Sender: TObject);
begin
  VprDProTabelaPreco := VprDProduto.AddTabelaPreco;
  VprDProTabelaPreco.CodTabelaPreco := varia.TabelaPreco;
  VprDProTabelaPreco.NomTabelaPreco := FunProdutos.RNomTabelaPreco(Varia.TabelaPreco);
  VprDProTabelaPreco.CodMoeda := VARIA.MoedaBase;
  VprDProTabelaPreco.NomMoeda := FunContasAReceber.RNomMoeda(Varia.MoedaBase);
  VprDProTabelaPreco.CodCor := VprCodCorPreco;
  VprDProTabelaPreco.NomCor := VprNomCorPreco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoSelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
begin
  if GPreco.AEstadoGrade in [egInsercao,EgEdicao] then
    if GPreco.AColuna <> ACol then
    begin
      case GPreco.AColuna of
        1: if not ETabelaPreco.AExisteCodigo(GPreco.Cells[1,GPreco.ALinha]) then
           begin
             if not ETabelaPreco.AAbreLocalizacao then
             begin
               GPreco.Cells[1,GPreco.ALinha]:= '';
               GPreco.Col:= 1;
               Abort;
             end;
           end;
        8: if not ECorPreco.AExisteCodigo(GPreco.Cells[8,GPreco.ALinha]) then
           begin
             if not ECorPreco.AAbreLocalizacao then
             begin
               GPreco.Cells[8,GPreco.ALinha]:= '';
               GPreco.Col:= 8;
               Abort;
             end;
           end;
        10: if not ETamanho.AExisteCodigo(GPreco.Cells[10,GPreco.ALinha]) then
           begin
             if not ETamanho.AAbreLocalizacao then
             begin
               GPreco.Cells[10,GPreco.ALinha]:= '';
               GPreco.Col:= 10;
               Abort;
             end;
           end;
        12: if not ECliPreco.AExisteCodigo(GPreco.Cells[12,GPreco.ALinha]) then
           begin
             if not ECliPreco.AAbreLocalizacao then
             begin
               GPreco.Cells[12,GPreco.ALinha]:= '';
               GPreco.Col:= 12;
               Abort;
             end;
           end;
       14: if not EMoeda.AExisteCodigo(GPreco.Cells[14,GPreco.ALinha]) then
           begin
             if not EMoeda.AAbreLocalizacao then
             begin
               GPreco.Cells[14,GPreco.ALinha]:= '';
               GPreco.Col:= 14;
               Abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.HabilitaTelaInstalacaoTearFios(VpaHabilitar: Boolean);
begin
  AlteraReadOnlyDet([LProdutoInstalacao,EProdutoInstalacao,LCorInstalacao,ECorInstalacao,LQtdFiosLico,EQtdFiosLico,LFuncaoFio,EFuncaoFio],not VpaHabilitar);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.SpeedButton8Click(Sender: TObject);
begin
  EDatAmostra.Clear;
  EDatSaidaAmostra.clear;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ZoomGradeInstalacao(VpaIndice: Double);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to GInstalacao.RowCount - 1 do
    GInstalacao.RowHeights[Vpflaco] := RetornaInteiro(GInstalacao.RowHeights[Vpflaco] * VpaIndice);
  for VpfLaco := 0 to GInstalacao.ColCount - 1 do
    GInstalacao.ColWidths[Vpflaco] := RetornaInteiro(GInstalacao.ColWidths[Vpflaco] * VpaIndice);
end;


{******************************************************************************}
procedure TFNovoProdutoPro.CarDProdutoInstalacao;
var
  VpfDProdutoInstalacao : TRBDProdutoInstalacaoTear;
begin
  if GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row] <> nil then
    GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row].Free;
  VpfDProdutoInstalacao := TRBDProdutoInstalacaoTear.cria;
  GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row] := VpfDProdutoInstalacao;
  VpfDProdutoInstalacao.CodProduto := EProdutoInstalacao.Text;
  VpfDProdutoInstalacao.NomProduto := LNomProdutoInstalacao.Caption;
  VpfDProdutoInstalacao.CodCor := ECorInstalacao.AInteiro;
  VpfDProdutoInstalacao.NomCor := LNomCorInstalacao.Caption;
  VpfDProdutoInstalacao.QtdFioslIco := EQtdFiosLico.AsInteger;
  VpfDProdutoInstalacao.SeqProduto := VprSeqProdutoInstalacao;
  case EFuncaoFio.ItemIndex of
    0 : VpfDProdutoInstalacao.Funcaofio := ffUrdume;
    1 : VpfDProdutoInstalacao.Funcaofio := ffAjuda;
    2 : VpfDProdutoInstalacao.Funcaofio := ffAmarracao;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDProdutoInstalacaoTela;
var
  VpfDProdutoInstalacao : TRBDProdutoInstalacaoTear;
begin
  if GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row] <> nil then
  begin
    VpfDProdutoInstalacao :=TRBDProdutoInstalacaoTear(GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row]);
    EProdutoInstalacao.Text := VpfDProdutoInstalacao.CodProduto;
    LNomProdutoInstalacao.Caption := VpfDProdutoInstalacao.NomProduto;
    ECorInstalacao.AInteiro := VpfDProdutoInstalacao.CodCor;
    LNomCorInstalacao.Caption := VpfDProdutoInstalacao.NomCor;
    EQtdFiosLico.AsInteger := VpfDProdutoInstalacao.QtdFioslIco;
    VprSeqProdutoInstalacao := VpfDProdutoInstalacao.SeqProduto;
    EFuncaoFio.ItemIndex := -1;
    case VpfDProdutoInstalacao.FuncaoFio of
      ffUrdume: EFuncaoFio.ItemIndex := 0;
      ffAjuda: EFuncaoFio.ItemIndex := 1;
      ffAmarracao: EFuncaoFio.ItemIndex := 2;
    end;
  end
  else
  begin
    EProdutoInstalacao.clear;
    LNomProdutoInstalacao.Caption := '';
    ECorInstalacao.clear;
    LNomCorInstalacao.Caption := '';
    EQtdFiosLico.clear;
  end;

end;

{******************************************************************************}
function TFNovoProdutoPro.DadosProdutoInstalacaoValido : String;
begin
  result := '';
  if EProdutoInstalacao.Text = '' then
    result := 'PRODUTO NÃO PREENCHIDO!!!'#13'É necessário selecionar o produto';
  if result = '' then
  begin
    if ECorInstalacao.AInteiro = 0 then
      result := 'COR NÃO PREENCHIDA!!!'#13'A cor do produto de instalação não foi preenchido.';
    if result = '' then
    begin
      if EQtdFiosLico.AsInteger = 0 then
        result := 'QUANTIDADE DE FIOS NO LIÇO NÃO PREENHCIDO!!!'#13'É necessário preenhcer a quantidade de fios no liço.';
      if result = '' then
      begin
        if EFuncaoFio.ItemIndex < 0 then
          result := 'FUNÇÃO FIO NÃO PREENCHIDO!!!'#13'É necessário preenhcer a função do fio.';
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EPerLucroChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if config.ValorVendaProdutoAutomatico then
    begin
      if EPerLucro.AValor <> 0 then
        EValVenda.AValor := ((EPerLucro.AValor/100)*EValCusto.AValor)
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EPlastico2Retorno(Retorno1, Retorno2: string);
begin
  if Retorno1 <> '' then
  begin
    VprDProduto.SeqProdutoPlastico2:= StrToInt(Retorno1);
  end
  else
    VprDProduto.SeqProdutoPlastico2:= 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EPlastico2Select(Sender: TObject);
begin
  EPlastico2.ASelectLocaliza.Text:= ('Select * from CADPRODUTOS ' +
                                 ' Where C_NOM_PRO like ''@%''' +
                                 ' AND C_COD_CLA like ''' + Varia.CodClassificacaoMateriaPrima + '%''' +
                                 ' order by C_NOM_PRO');

  EPlastico2.ASelectValida.Text:= 'Select * from CADPRODUTOS ' +
                                 ' Where C_COD_PRO = ''@''';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EPlasticoRetorno(Retorno1, Retorno2: string);
begin
  if Retorno1 <> '' then
    VprDProduto.SeqProdutoPlastico:= StrToInt(Retorno1)
  else
    VprDProduto.SeqProdutoPlastico:= 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EProdutoInstalacaoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[2].AValorRetorno <> '' then
      VprSeqProdutoInstalacao := StrToINt(VpaColunas.items[2].AValorRetorno)
    else
      VprSeqProdutoInstalacao := 0;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdColInstalacaoExit(Sender: TObject);
begin
  ConfiguraQtdColunaInstalcao(EQtdColInstalacao.Value);
end;

procedure TFNovoProdutoPro.EQtdLinInstalacaoExit(Sender: TObject);
begin
  ConfiguraQtdLinhaInstalacao(EQtdLinInstalacao.Value);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdMinimaExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EQtdMinima.AValor <> VprDProduto.QtdMinima then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.QtdMinima := EQtdMinima.AValor;
      VprDProduto.QtdMinima := EQtdMinima.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdPedidoExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EQtdPedido.AValor <> VprDProduto.QtdPedido then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.QtdIdeal := EQtdPedido.AValor;
      VprDProduto.QtdPedido := EQtdPedido.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdQuadrosExit(Sender: TObject);
begin
  ConfiguraQtdQuadros(EQtdQuadros.Value);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQuantidadeExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EQuantidade.AValor <> VprDProduto.QtdEstoque then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.QtdEstoque := EQuantidade.AValor;
      VprDProduto.QtdEstoque := EQuantidade.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProAcessorio := TRBDProdutoAcessorio(VprDProduto.Acessorios.Items[VpaLinha-1]);
  if VprDProAcessorio.CodAcessorio <> 0 then
    GAcessorios.Cells[1,VpaLinha] := IntToStr(VprDProAcessorio.CodAcessorio)
  else
    GAcessorios.Cells[1,VpaLinha] := '';
  GAcessorios.Cells[2,VpaLinha] := VprDProAcessorio.NomAcessorio;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not EAcessorio.AExisteCodigo(GAcessorios.Cells[1,GAcessorios.ALinha]) then
  begin
    aviso('ACESSÓRIO NÃO CADASTRADO!!!'#13'É necessário informar o código de um acessório que esteja cadastrado.');
    VpaValidos:= False;
    GAcessorios.Col:= 1;
  end;
  if VpaValidos then
  begin
    if FunProdutos.ExisteAcessorioDuplicado(VprDProduto) then
    begin
      aviso('ACESSÓRIO DUPLICADO!!!'#13'O acessório digitado já existe digitado para esse produto');
      VpaValidos:= False;
      GAcessorios.Col:= 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EAcessorioCadastrar(Sender: TObject);
begin
  FAcessorio := TFAcessorio.CriarSDI(Self, '', true);
  FAcessorio.BotaoCadastrar1.Click;
  FAcessorio.ShowModal;
  FAcessorio.Free;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EAcessorioRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProAcessorio.CodAcessorio := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProAcessorio.NomAcessorio := VpaColunas.items[1].AValorRetorno;
    GAcessorios.Cells[1,GAcessorios.ALinha] := VpaColunas.items[0].AValorRetorno;
    GAcessorios.Cells[2,GAcessorios.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProAcessorio.CodAcessorio := 0;
    VprDProAcessorio.NomAcessorio := '';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GAcessorios.Col of
        1 : EAcessorio.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Acessorios.Count > 0 then
    VprDProAcessorio := TRBDProdutoAcessorio(VprDProduto.Acessorios.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosNovaLinha(Sender: TObject);
begin
  VprDProAcessorio := VprDProduto.AddAcessorio;
end;

procedure TFNovoProdutoPro.GAcessoriosRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin

end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GAcessorios.AEstadoGrade in [egInsercao,EgEdicao] then
    if GAcessorios.AColuna <> ACol then
    begin
      case GAcessorios.AColuna of
        1: if not EAcessorio.AExisteCodigo(GAcessorios.Cells[1,GAcessorios.ALinha]) then
           begin
             if not EAcessorio.AAbreLocalizacao then
             begin
               GAcessorios.Cells[1,GAcessorios.ALinha]:= '';
               GAcessorios.Col:= 1;
               Abort;
             end;
           end;
      end;
    end;
end;
end.




