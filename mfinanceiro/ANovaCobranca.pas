unit ANovaCobranca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Mask, numericos,
  Buttons, UnDados, UnClientes, Db, DBTables, Grids, DBGrids, Tabela,Constantes,
  DBKeyViolation, ComCtrls, Localizacao, Menus, UnDadosProduto,
  DBCtrls, UnDadosCR, UnImpressaoBoleto, DBClient;

type
  TFNovaCobranca = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BProximo: TBitBtn;
    Ligacoes: TSQL;
    Parcelas: TSQL;
    ParcelasD_DAT_VEN: TSQLTimeStampField;
    ParcelasD_DAT_EMI: TSQLTimeStampField;
    ParcelasN_VLR_PAR: TFMTBCDField;
    ParcelasI_NRO_NOT: TFMTBCDField;
    ParcelasC_NRO_DUP: TWideStringField;
    ParcelasI_NRO_PAR: TFMTBCDField;
    ParcelasI_QTD_PAR: TFMTBCDField;
    ParcelasC_NOM_FRM: TWideStringField;
    ParcelasI_QTD_LIG: TFMTBCDField;
    ParcelasI_QTD_ATE: TFMTBCDField;
    ParcelasI_COD_PAG: TFMTBCDField;
    ParcelasC_NOM_PAG: TWideStringField;
    ParcelasI_COD_FRM: TFMTBCDField;
    DataParcelas: TDataSource;
    ParcelasDiasAtraso: TFMTBCDField;
    ParcelasParcela: TWideStringField;
    Localiza: TConsultaPadrao;
    ParcelasC_OBS_LIG: TWideStringField;
    ParcelasI_EMP_FIL: TFMTBCDField;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    ParcelasI_LAN_REC: TFMTBCDField;
    PopupMenu1: TPopupMenu;
    VerNota1: TMenuItem;
    ParcelasC_IND_CAD: TWideStringField;
    ParcelasI_SEQ_NOT: TFMTBCDField;
    HistricoLigao1: TMenuItem;
    N1: TMenuItem;
    BaixarTitulo1: TMenuItem;
    BEmail: TBitBtn;
    BRecibo: TBitBtn;
    ParcelasValorMora: TCurrencyField;
    ParcelasValorCorrigido: TCurrencyField;
    ParcelasN_PER_MOR: TFMTBCDField;
    ParcelasN_TOT_TAR: TFMTBCDField;
    ParcelasD_TIT_PRO: TSQLTimeStampField;
    ParcelasD_ENV_CAR: TSQLTimeStampField;
    ParcelasI_LAN_ORC: TFMTBCDField;
    N2: TMenuItem;
    Histricosemailsecobrana1: TMenuItem;
    BContasReceber: TBitBtn;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PCobranca: TTabSheet;
    ScroolBox1: TScrollBox;
    PCliente: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    ECodCliente: TEditColor;
    ENomCliente: TEditColor;
    EContato: TEditColor;
    EContatoFinanceiro: TEditColor;
    EFone1: TEditColor;
    EFone2: TEditColor;
    EFax: TEditColor;
    ETotAtraso: Tnumerico;
    ETotCorrigido: Tnumerico;
    EFonFinanceiro: TEditColor;
    GridIndice1: TGridIndice;
    PanelColor3: TPanelColor;
    Label15: TLabel;
    Label16: TLabel;
    SpeedButton1: TSpeedButton;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    SpeedButton3: TSpeedButton;
    Label24: TLabel;
    EHistorico: TEditLocaliza;
    CDatPromessa: TCheckBox;
    EDatPromessa: TCalendario;
    ENomContato: TEditColor;
    EObservacoes: TMemoColor;
    EProximaLigacao: TCalendario;
    EProximaObservacao: TEditColor;
    EMotivo: TEditLocaliza;
    PgCliente: TTabSheet;
    DataCADCLIENTES: TDataSource;
    CADCLIENTES: TSQL;
    ScrollBox1: TScrollBox;
    PanelColor6: TPanelColor;
    SpeedButton4: TSpeedButton;
    Label29: TLabel;
    Label30: TLabel;
    Label44: TLabel;
    Label54: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label43: TLabel;
    Label52: TLabel;
    Label48: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label68: TLabel;
    Label75: TLabel;
    BCidade: TSpeedButton;
    Label80: TLabel;
    Label82: TLabel;
    SpeedButton10: TSpeedButton;
    Label83: TLabel;
    Label84: TLabel;
    SpeedButton11: TSpeedButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    PanelColor11: TBevel;
    Label93: TLabel;
    Label85: TLabel;
    SpeedButton12: TSpeedButton;
    Label86: TLabel;
    Label87: TLabel;
    SpeedButton13: TSpeedButton;
    Label88: TLabel;
    Label89: TLabel;
    SpeedButton14: TSpeedButton;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label76: TLabel;
    SpeedButton5: TSpeedButton;
    Label78: TLabel;
    Label94: TLabel;
    SpeedButton15: TSpeedButton;
    Label95: TLabel;
    Label97: TLabel;
    Label117: TLabel;
    SpeedButton18: TSpeedButton;
    Label118: TLabel;
    Label119: TLabel;
    SpeedButton19: TSpeedButton;
    Label120: TLabel;
    Bevel4: TBevel;
    Label45: TLabel;
    Label46: TLabel;
    Label6: TLabel;
    Label40: TLabel;
    PainelRG: TPanelColor;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label62: TLabel;
    Label67: TLabel;
    DBEditColor5: TDBEditColor;
    DBEditCPF1: TDBEditCPF;
    DBEditColor2: TDBEditColor;
    DBEditColor32: TDBEditColor;
    DBEditPos28: TDBEditPos2;
    PainelCGC: TPanelColor;
    Label61: TLabel;
    Label39: TLabel;
    Label42: TLabel;
    Label64: TLabel;
    Label66: TLabel;
    DBEditCGC1: TDBEditCGC;
    DBEditColor35: TDBEditColor;
    DBEditColor22: TDBEditColor;
    DBEditPos27: TDBEditPos2;
    DBEditColor4: TDBEditColor;
    DBEditColor1: TDBEditColor;
    DBEditColor9: TDBEditColor;
    DBComboBoxColor2: TDBComboBoxColor;
    DBEditPos21: TDBEditPos2;
    DBEditColor8: TDBEditColor;
    DBEditColor10: TDBEditColor;
    Pessoa: TDBRadioGroup;
    DBEditPos24: TDBEditPos2;
    DBEditPos25: TDBEditPos2;
    DBEditPos26: TDBEditPos2;
    TipoCad: TDBRadioGroup;
    DBEditColor39: TDBEditColor;
    ECidade: TDBEditLocaliza;
    DBEditColor28: TDBEditColor;
    DBEditColor15: TDBEditColor;
    DBFilialColor1: TDBFilialColor;
    ERegiaoVenda: TDBEditLocaliza;
    DBEditUF1: TDBEditUF;
    DBEditColor42: TDBEditColor;
    EVendedor: TDBEditLocaliza;
    ECondicaoPagamento: TDBEditLocaliza;
    EFormaPagamento: TDBEditLocaliza;
    DBEditColor12: TDBEditColor;
    DBEditLocaliza3: TDBEditLocaliza;
    DBEditLocaliza4: TDBEditLocaliza;
    DBEditColor45: TDBEditColor;
    DBEditLocaliza7: TDBEditLocaliza;
    ETecnico: TDBEditLocaliza;
    DBEditColor30: TDBEditColor;
    DBEditColor31: TDBEditColor;
    DBEditColor3: TDBEditColor;
    PCotacao: TTabSheet;
    PChamados: TTabSheet;
    PNotaFiscal: TTabSheet;
    PHistorico: TTabSheet;
    CADORCAMENTO: TSQL;
    CADORCAMENTOI_Lan_Orc: TFMTBCDField;
    CADORCAMENTOD_Dat_Orc: TSQLTimeStampField;
    CADORCAMENTOC_Nom_Cli: TWideStringField;
    CADORCAMENTOC_Nom_Pag: TWideStringField;
    CADORCAMENTOT_Hor_Orc: TSQLTimeStampField;
    CADORCAMENTOD_Dat_Ent: TSQLTimeStampField;
    CADORCAMENTOC_Fla_Sit: TWideStringField;
    CADORCAMENTOD_Dat_Pre: TSQLTimeStampField;
    CADORCAMENTOL_Obs_Orc: TWideStringField;
    CADORCAMENTOC_Nom_Ven: TWideStringField;
    CADORCAMENTOC_Nro_Not: TWideStringField;
    CADORCAMENTOI_COD_CLI: TFMTBCDField;
    CADORCAMENTOI_COD_VEN: TFMTBCDField;
    CADORCAMENTOI_EMP_FIL: TFMTBCDField;
    CADORCAMENTON_Vlr_TOT: TFMTBCDField;
    CADORCAMENTOI_COD_USU: TFMTBCDField;
    CADORCAMENTOC_NOM_USU: TWideStringField;
    CADORCAMENTOC_IND_IMP: TWideStringField;
    CADORCAMENTOI_COD_EST: TFMTBCDField;
    CADORCAMENTONOMEST: TWideStringField;
    CADORCAMENTOI_COD_TRA: TFMTBCDField;
    CADORCAMENTOC_NOM_TRA: TWideStringField;
    CADORCAMENTOI_TIP_ORC: TFMTBCDField;
    CADORCAMENTOC_NOM_TIP: TWideStringField;
    CADORCAMENTOC_ORD_COM: TWideStringField;
    CADORCAMENTON_VAL_TAX: TFMTBCDField;
    CADORCAMENTOC_NOT_GER: TWideStringField;
    CADORCAMENTOC_GER_FIN: TWideStringField;
    CADORCAMENTOC_IND_CAN: TWideStringField;
    DataCADORCAMENTO: TDataSource;
    GOrcamento: TGridIndice;
    ChamadoTecnico: TSQL;
    ChamadoTecnicoCODFILIAL: TFMTBCDField;
    ChamadoTecnicoNUMCHAMADO: TFMTBCDField;
    ChamadoTecnicoDATCHAMADO: TSQLTimeStampField;
    ChamadoTecnicoDATPREVISAO: TSQLTimeStampField;
    ChamadoTecnicoNOMSOLICITANTE: TWideStringField;
    ChamadoTecnicoVALCHAMADO: TFMTBCDField;
    ChamadoTecnicoVALDESLOCAMENTO: TFMTBCDField;
    ChamadoTecnicoC_NOM_CLI: TWideStringField;
    ChamadoTecnicoNOMTECNICO: TWideStringField;
    ChamadoTecnicoC_NOM_USU: TWideStringField;
    ChamadoTecnicoNOMEST: TWideStringField;
    ChamadoTecnicoCODESTAGIO: TFMTBCDField;
    ChamadoTecnicoCODTECNICO: TFMTBCDField;
    ChamadoTecnicoNOMTIPOCHAMADO: TWideStringField;
    ChamadoTecnicoLANORCAMENTO: TFMTBCDField;
    DataChamadoTecnico: TDataSource;
    GChamados: TGridIndice;
    NOTAS: TSQL;
    NOTASI_NRO_NOT: TFMTBCDField;
    NOTASC_NOM_CLI: TWideStringField;
    NOTASC_CID_CLI: TWideStringField;
    NOTASC_TIP_CAD: TWideStringField;
    NOTASC_FLA_ECF: TWideStringField;
    NOTASc_not_can: TWideStringField;
    NOTASL_OBS_NOT: TWideStringField;
    NOTASN_TOT_PRO: TFMTBCDField;
    NOTASN_TOT_NOT: TFMTBCDField;
    NOTASI_NRO_LOJ: TFMTBCDField;
    NOTASI_NRO_CAI: TFMTBCDField;
    NOTASC_NOT_IMP: TWideStringField;
    NOTASD_DAT_CAD: TSQLTimeStampField;
    NOTASD_DAT_ALT: TSQLTimeStampField;
    NOTASC_END_CLI: TWideStringField;
    NOTASC_BAI_CLI: TWideStringField;
    NOTASC_CEP_CLI: TWideStringField;
    NOTASC_EST_CLI: TWideStringField;
    NOTASC_CPF_CLI: TWideStringField;
    NOTASC_CGC_CLI: TWideStringField;
    NOTASC_FON_FAX: TWideStringField;
    NOTASD_DAT_SAI: TSQLTimeStampField;
    NOTAST_HOR_SAI: TSQLTimeStampField;
    NOTASI_QTD_VOL: TFMTBCDField;
    NOTASN_VLR_ICM: TFMTBCDField;
    NOTASN_BAS_SUB: TFMTBCDField;
    NOTASN_VLR_SUB: TFMTBCDField;
    NOTASN_VLR_FRE: TFMTBCDField;
    NOTASN_VLR_SEG: TFMTBCDField;
    NOTASN_OUT_DES: TFMTBCDField;
    NOTASN_TOT_IPI: TFMTBCDField;
    NOTASN_PES_BRU: TFMTBCDField;
    NOTASN_PES_LIQ: TFMTBCDField;
    NOTASN_TOT_SER: TFMTBCDField;
    NOTASN_VLR_ISQ: TFMTBCDField;
    NOTASI_SEQ_NOT: TFMTBCDField;
    NOTASC_COD_NAT: TWideStringField;
    NOTASI_ITE_NAT: TFMTBCDField;
    NOTASC_SER_NOT: TWideStringField;
    NOTASD_DAT_EMI: TSQLTimeStampField;
    NOTASI_EMP_FIL: TFMTBCDField;
    NOTASC_NOM_USU: TWideStringField;
    DataNOTAS: TDataSource;
    GNotasFiscais: TGridIndice;
    HISTORICO: TSQL;
    HISTORICOSEQCOBRANCA: TFMTBCDField;
    HISTORICODATCOBRANCA: TSQLTimeStampField;
    HISTORICOC_NOM_CLI: TWideStringField;
    HISTORICODESHISTORICO: TWideStringField;
    HISTORICODESFALADOCOM: TWideStringField;
    HISTORICOC_NOM_USU: TWideStringField;
    HISTORICODESOBSERVACAO: TWideStringField;
    HISTORICODATPROXIMALIGACAO: TSQLTimeStampField;
    HISTORICODATPROMESSAPAGAMENTO: TSQLTimeStampField;
    HISTORICODESOBSPROXIMALIGACAO: TWideStringField;
    DataHISTORICO: TDataSource;
    GHistorico: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    HISTORICOITEM: TSQL;
    HISTORICOITEMI_EMP_FIL: TFMTBCDField;
    HISTORICOITEMI_LAN_REC: TFMTBCDField;
    HISTORICOITEMI_NRO_PAR: TFMTBCDField;
    HISTORICOITEMD_DAT_VEN: TSQLTimeStampField;
    HISTORICOITEMN_VLR_PAR: TFMTBCDField;
    HISTORICOITEMC_NRO_DUP: TWideStringField;
    HISTORICOITEMI_QTD_LIG: TFMTBCDField;
    HISTORICOITEMI_QTD_ATE: TFMTBCDField;
    HISTORICOITEMC_NOM_FRM: TWideStringField;
    DataHISTORICOITEM: TDataSource;
    GridIndice2: TGridIndice;
    GridMov: TDBGridColor;
    Splitter1: TSplitter;
    MovOrcamentos: TSQL;
    MovOrcamentosI_EMP_FIL: TFMTBCDField;
    MovOrcamentosI_LAN_ORC: TFMTBCDField;
    MovOrcamentosC_COD_PRO: TWideStringField;
    MovOrcamentosN_VLR_PRO: TFMTBCDField;
    MovOrcamentosN_QTD_PRO: TFMTBCDField;
    MovOrcamentosN_VLR_TOT: TFMTBCDField;
    MovOrcamentosC_COD_UNI: TWideStringField;
    MovOrcamentosC_IMP_FOT: TWideStringField;
    MovOrcamentosC_Fla_Res: TWideStringField;
    MovOrcamentosC_Nom_Pro: TWideStringField;
    MovOrcamentosI_Seq_Pro: TFMTBCDField;
    MovOrcamentosN_Qtd_Bai: TFMTBCDField;
    MovOrcamentosC_DES_COR: TWideStringField;
    MovOrcamentosPRODUTOCOTACAO: TWideStringField;
    DataMovOrcamentos: TDataSource;
    GridIndice3: TGridIndice;
    ChamadoProduto: TSQL;
    ChamadoProdutoSEQITEM: TFMTBCDField;
    ChamadoProdutoSEQPRODUTO: TFMTBCDField;
    ChamadoProdutoNUMCONTADOR: TFMTBCDField;
    ChamadoProdutoNUMSERIE: TWideStringField;
    ChamadoProdutoNUMSERIEINTERNO: TWideStringField;
    ChamadoProdutoDESSETOR: TWideStringField;
    ChamadoProdutoDATGARANTIA: TSQLTimeStampField;
    ChamadoProdutoC_NOM_PRO: TWideStringField;
    ChamadoProdutoSEQCONTRATO: TFMTBCDField;
    ChamadoProdutoCODTIPOCONTRATO: TFMTBCDField;
    ChamadoProdutoTIPOCONTRATO: TWideStringField;
    ChamadoProdutoDESPROBLEMA: TWideStringField;
    ChamadoProdutoCODFILIALCONTRATO: TFMTBCDField;
    DataChamadoProduto: TDataSource;
    Splitter2: TSplitter;
    DBMemoColor2: TDBMemoColor;
    NOTASPRODUTOS: TSQL;
    DataNOTASPRODUTOS: TDataSource;
    Splitter3: TSplitter;
    GProdutosNota: TDBGridColor;
    NOTASPRODUTOSC_COD_PRO: TWideStringField;
    NOTASPRODUTOSC_NOM_PRO: TWideStringField;
    NOTASPRODUTOSI_COD_COR: TFMTBCDField;
    NOTASPRODUTOSNOM_COR: TWideStringField;
    NOTASPRODUTOSC_COD_UNI: TWideStringField;
    NOTASPRODUTOSN_QTD_PRO: TFMTBCDField;
    NOTASPRODUTOSN_VLR_PRO: TFMTBCDField;
    NOTASPRODUTOSN_TOT_PRO: TFMTBCDField;
    PConsultarOrcamento: TPopupMenu;
    Consultar1: TMenuItem;
    PConsultaNotaFiscal: TPopupMenu;
    MenuItem1: TMenuItem;
    PConsultarChamado: TPopupMenu;
    MenuItem2: TMenuItem;
    EMailFinanceiro: TEditColor;
    Label7: TLabel;
    Label8: TLabel;
    ETotAberto: Tnumerico;
    CPendenciaSerasa: TCheckBox;
    Label10: TLabel;
    EUltimoRecebimento: TEditColor;
    PEmail: TPopupMenu;
    EnviarBoletoEmail1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BProximoClick(Sender: TObject);
    procedure ParcelasCalcFields(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CDatPromessaClick(Sender: TObject);
    procedure EHistoricoCadastrar(Sender: TObject);
    procedure EDatPromessaChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EHistoricoChange(Sender: TObject);
    procedure EHistoricoRetorno(Retorno1, Retorno2: String);
    procedure SpeedButton2Click(Sender: TObject);
    procedure VerNota1Click(Sender: TObject);
    procedure HistricoLigao1Click(Sender: TObject);
    procedure BaixarTitulo1Click(Sender: TObject);
    procedure BEmailClick(Sender: TObject);
    procedure BReciboClick(Sender: TObject);
    procedure EMotivoCadastrar(Sender: TObject);
    procedure Histricosemailsecobrana1Click(Sender: TObject);
    procedure BContasReceberClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure GOrcamentoOrdem(Ordem: String);
    procedure GChamadosOrdem(Ordem: String);
    procedure GNotasFiscaisOrdem(Ordem: String);
    procedure GHistoricoOrdem(Ordem: String);
    procedure HISTORICOAfterScroll(DataSet: TDataSet);
    procedure CADORCAMENTOAfterScroll(DataSet: TDataSet);
    procedure ChamadoTecnicoAfterScroll(DataSet: TDataSet);
    procedure NOTASAfterScroll(DataSet: TDataSet);
    procedure Consultar1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure EnviarBoletoEmail1Click(Sender: TObject);
  private
    { Private declarations }
    VprOperacao : TRBDOperacaoCadastro;
    VprDCliente : TRBDCliente;
    VprDCobranca : TRBDCobrancoCorpo;
    VprOrdemCotacao,
    VprOrdemChamado,
    VprOrdemNotaFiscal,
    VprOrdemHistorico: String;
    FunImpBoleto : TImpressaoBoleto;
    procedure CarDClienteTela(VpaCodCliente : Integer);
    procedure CarDClasse;
    procedure CarDItemsClasse;
    procedure PosClientes(VpaDatCobranca : TDateTime;VpaCodCliente : Integer);
    procedure PosCliente(VpaCodCliente: Integer);
    procedure PosCotacao(VpaCodCliente: Integer);
    procedure PosChamado(VpaCodCliente: Integer);
    procedure PosNotaFiscal(VpaCodCliente: Integer);
    procedure PosHistoricoLigacao(VpaCodCliente: Integer);
    procedure PosHistoricoItem;
    function PosParcelas(VpaCodCliente : Integer):boolean;
    procedure ProximoInadimplente;
    procedure NovaCobranca;
    procedure EstadoBotoes(VpaEstado : boolean);
    function RValorCorrigido : Double;
    procedure PosMovOrcamento(VpaCodfilial, VpaOrcamento: String);
    procedure PosProdutosChamado;
    procedure PosItensNotaFiscal;
    procedure ConsultaChamado;
    procedure ConsultaNotaFiscal;
    procedure ConsultaOrcamento;
    procedure FechaTabelas;
  public
    { Public declarations }
    function EfetuaCobrancas : Boolean;
    function CobrancaCliente(VpaCodcliente :Integer):Boolean;
  end;

var
  FNovaCobranca: TFNovaCobranca;

implementation

uses APrincipal, FunData, FunSql, ConstMsg, AHistoricoLigacao, UnContasaReceber, funObjeto,
  ANovoCliente, ANovaCotacao, ANovaNotaFiscalNota, UnNotaFiscal, ACobrancas,
  AMotivoInadimplencia, FunArquivos,
  AHistoricoECobranca, AContasAReceber, ANovoChamadoTecnico,
  ABaixaContasAReceberOO, ANovoEmailContasAReceber, dmRave, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaCobranca.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Paginas.ActivePage := PCobranca;
  VprDCliente := TRBDCliente.cria;
  VprDCobranca := TRBDCobrancoCorpo.cria;
  FunImpBoleto := TImpressaoBoleto.cria(FPrincipal.BaseDados);
  VprOrdemCotacao:= 'ORDER BY D_DAT_ORC DESC';
  VprOrdemChamado:= 'ORDER BY DATCHAMADO DESC';
  VprOrdemNotaFiscal:= 'ORDER BY D_DAT_EMI DESC';
  VprOrdemHistorico:= 'ORDER BY DATCOBRANCA DESC';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaCobranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDCliente.free;
  VprDCobranca.free;
  FunImpBoleto.Free;
  Ligacoes.close;
  Parcelas.close;
  FechaTabelas;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovaCobranca.EfetuaCobrancas : Boolean;
begin
  VprDCobranca.IndCobrarCliente := false;
  PosClientes(date,0);
  if not PosParcelas(Ligacoes.FieldByName('I_COD_CLI').AsInteger) then
    ProximoInadimplente;
  showmodal;
end;

{******************************************************************************}
function TFNovaCobranca.CobrancaCliente(VpaCodcliente :Integer):Boolean;
begin
  VprDCobranca.IndCobrarCliente := true;
  PosClientes(date,VpaCodCliente);
  if not PosParcelas(Ligacoes.FieldByName('I_COD_CLI').AsInteger) then
    ProximoInadimplente;
  showmodal;
end;

{******************************************************************************}
procedure TFNovaCobranca.CarDClienteTela(VpaCodCliente : Integer);
begin
  VprDCliente.CodCliente := VpaCodCliente;
  FunClientes.CarDCliente(VprDCliente);

  with VprDCliente do
  begin
    ECodCliente.AInteiro := CodCliente;
    ENomCliente.Text := NomCliente;
    EContato.Text := NomContato;
    EContatoFinanceiro.Text := NomContatoFinanceiro;
    EFonFinanceiro.Text := DesFoneFinanceiro;
    EMailFinanceiro.Text := DesEmailFinanceiro;
    EFone1.Text := DesFone1;
    EFone2.Text := DesFone2;
    EFAX.Text := DesFax;
    IF DatUltimoRecebimento > MontaData(1,1,1900) then
      EUltimoRecebimento.Text := FormatDateTime('DD/MM/YYYY',DatUltimoRecebimento)
    else
      EUltimoRecebimento.Clear;
    ETotAberto.AValor:= DuplicatasEmAberto;
    ETotAtraso.AValor:= DuplicatasEmAtraso;
    ETotCorrigido.AValor := RValorCorrigido;
    CPendenciaSerasa.Checked := IndPendenciaSerasa;
  end;
//  if (varia.CNPJFilial = CNPJ_FELDMANN) then
//    ETotAberto.AValor :=
end;

{******************************************************************************}
procedure TFNovaCobranca.CarDClasse;
begin
  with VprDCobranca do
  begin
    SeqCobranca :=0;
    CodHistorico := EHistorico.AInteiro;
    CodMotivo := EMotivo.AInteiro;
    if CDatPromessa.Checked then
      DatPromessa := EDatPromessa.DateTime
    else
      DatPromessa := MontaData(1,1,1900);
    DesFaladoCom := ENomContato.Text;
    DesObservacao := EObservacoes.Lines.text;
    DatProximaLigacao := EProximaLigacao.DateTime;
    DesObsProximaLigacao := EProximaObservacao.Text;
    CodCliente := Ligacoes.FieldByName('I_COD_CLI').AsInteger;
    CodUsuario := varia.CodigoUsuario;
    DatCobranca := now;
  end;
  CarDItemsClasse;
end;

{******************************************************************************}
procedure TFNovaCobranca.CarDItemsClasse;
var
  vpfDItem: TRBDCobrancaItem;
begin
  FreeTObjectsList(VprDCobranca.Items);
  Parcelas.first;
  while not Parcelas.eof do
  begin
    vpfDItem := VprDCobranca.addItem;
    vpfDItem.CodFilial := ParcelasI_EMP_FIL.AsInteger;
    vpfDItem.LanReceber := ParcelasI_LAN_REC.AsInteger;
    vpfDItem.NumParcela := ParcelasI_NRO_PAR.AsInteger;
    Parcelas.next;
  end;
end;

{******************************************************************************}
procedure TFNovaCobranca.PosClientes(VpaDatCobranca : TDateTime;VpaCodCliente : Integer);
begin
  Ligacoes.close;
  Ligacoes.Sql.Clear;
  Ligacoes.Sql.add('SELECT * FROM CADCLIENTES CLI ');

  if VpaCodCliente <> 0 then
    Ligacoes.Sql.add('where CLI.I_COD_CLI = '+IntToStr(VpaCodcliente))
  else
  begin
    Ligacoes.Sql.add(' WHERE EXISTS '+
                     ' (SELECT MOV.I_COD_CLI FROM  CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                     ' WHERE MOV.D_PRO_LIG <= '+SQLTextoDataAAAAMMMDD(VpaDatCobranca)+
                     ' AND MOV.I_COD_CLI = CLI.I_COD_CLI'+
                     ' AND MOV.D_DAT_PAG IS NULL '+
                     ' AND MOV.C_FUN_PER = ''N'''+
                     ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                     ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ');
    if varia.CNPJFilial = CNPJ_LATICINIOSPOMERODE then
      Ligacoes.sql.add(' and CAD.C_IND_CAD = ''N''');

    Ligacoes.sql.add(')');
  end;
  Ligacoes.SQL.add('order by CLI.C_NOM_CLI');
 Ligacoes.open;
end;

{******************************************************************************}
function TFNovaCobranca.PosParcelas(VpaCodCliente : Integer):Boolean;
begin
  Parcelas.Sql.Clear;
  Parcelas.close;
  Parcelas.Sql.add('select MOV.D_DAT_VEN,CAD.D_DAT_EMI, MOV.N_VLR_PAR, CAD.I_LAN_REC,  '+
                   ' MOV.N_PER_MOR, MOV.N_TOT_TAR, MOV.D_TIT_PRO, MOV.D_ENV_CAR,'+
                   ' CAD.I_NRO_NOT, MOV.C_NRO_DUP, MOV.I_NRO_PAR, CAD.I_QTD_PAR, CAD.C_IND_CAD, CAD.I_SEQ_NOT, '+
                   ' CAD.I_LAN_ORC, '+
                   ' FRM.C_NOM_FRM,  MOV.I_QTD_LIG, I_QTD_ATE, MOV.C_OBS_LIG, '+
                   ' PAG.I_COD_PAG, PAG.C_NOM_PAG, FRM.I_COD_FRM, MOV.I_EMP_FIL '+
                   ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV, CADCONDICOESPAGTO PAG, CADFORMASPAGAMENTO FRM '+
                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                   ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                   ' AND CAD.I_COD_PAG = PAG.I_COD_PAG ' +
                   ' AND MOV.I_COD_FRM = FRM.I_COD_FRM '+
                   ' AND CAD.C_IND_CON IS NULL '+
                   ' AND MOV.C_FUN_PER = ''N'''+
                   ' AND MOV.D_DAT_PAG IS NULL '+
                   ' AND MOV.I_COD_CLI = '+IntToStr(VpaCodCliente));
  if VprDCobranca.IndCobrarCliente then
   Parcelas.Sql.add(' and MOV.D_DAT_VEN <= '+SQLTextoDataAAAAMMMDD(DATE))
  else
   Parcelas.Sql.add(' and MOV.D_PRO_LIG <= '+SQLTextoDataAAAAMMMDD(DATE));

  if varia.CNPJFilial = CNPJ_LATICINIOSPOMERODE then
    Parcelas.sql.add(' and CAD.C_IND_CAD = ''N''');

  Parcelas.Sql.add(' ORDER BY MOV.D_DAT_VEN ');
  Parcelas.Open;
  result := not Parcelas.Eof;
  if result then
  begin
    CarDClienteTela(VpaCodCliente);
    NovaCobranca;
  end;
end;


{******************************************************************************}
procedure TFNovaCobranca.ProximoInadimplente;
begin
  while not Ligacoes.Eof do
  begin
   Ligacoes.next;
   PosCliente(Ligacoes.FieldByName('I_COD_CLI').AsInteger);
   if PosParcelas(Ligacoes.FieldByName('I_COD_CLI').AsInteger) then
     break;
  end;
  if Ligacoes.Eof then
    aviso('COBRANÇA FINALIZADA!!!'#13'Não existe mais inadimplente para serem cobrados.');
end;

{******************************************************************************}
procedure TFNovaCobranca.NovaCobranca;
begin
  Paginas.ActivePage:= PCobranca;
  CDatPromessa.Checked := true;
  EDatPromessa.DateTime := incdia(date,7);
  EProximaLigacao.DateTime := incdia(date,9);
  EHistorico.Clear;
  EHistorico.Atualiza;
  ENomContato.Clear;
  EObservacoes.Clear;
  EProximaObservacao.clear;
  ActiveControl:= EHistorico;
  EstadoBotoes(true);
  ValidaGravacao1.Execute;
  VprOperacao := ocInsercao;
end;

{******************************************************************************}
procedure TFNovaCobranca.EstadoBotoes(VpaEstado : boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BProximo.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
function TFNovaCobranca.RValorCorrigido : Double;
begin
  result := 0;
  Parcelas.First;
  while not Parcelas.Eof do
  begin
    result := result + ParcelasValorCorrigido.AsFloat;
    Parcelas.next;
  end;
  Parcelas.first;
end;

{******************************************************************************}
procedure TFNovaCobranca.BProximoClick(Sender: TObject);
begin
  ProximoInadimplente;
end;

{******************************************************************************}
procedure TFNovaCobranca.ParcelasCalcFields(DataSet: TDataSet);
var
  VpfValMoraMes, VpfValJurosMes, VpfValMulta : Double;
begin
  ParcelasDiasAtraso.AsInteger := DiasPorPeriodo(ParcelasD_DAT_VEN.AsDateTime,date);
  ParcelasParcela.AsString := ParcelasI_NRO_PAR.AsString + ' de '+ParcelasI_QTD_PAR.AsString;
  VpfValMoraMes := (ParcelasN_VLR_PAR.AsFloat * Varia.Mora)/100;
  VpfValJurosMes := (ParcelasN_VLR_PAR.AsFloat * Varia.Juro)/100;
  
  ParcelasValorMora.AsFloat := ((VpfValMoraMes * ParcelasDiasAtraso.AsInteger)/30) + (VpfValJurosMes * ParcelasDiasAtraso.AsInteger)/30;
  ParcelasValorCorrigido.AsFloat := ParcelasN_VLR_PAR.AsFloat + ParcelasValorMora.AsFloat + ParcelasN_TOT_TAR.AsFloat;
end;

{******************************************************************************}
procedure TFNovaCobranca.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaCobranca.CDatPromessaClick(Sender: TObject);
begin
  EDatPromessa.Enabled := CDatPromessa.Checked;
  if not CDatPromessa.Checked then
    EProximaLigacao.DateTime := date;
end;

{******************************************************************************}
procedure TFNovaCobranca.EHistoricoCadastrar(Sender: TObject);
begin
  FHistoricoLigacao := TFHistoricoLigacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHistoricoLigacao'));
  FHistoricoLigacao.BotaoCadastrar1.Click;
  FHistoricoLigacao.ShowModal;
  FHistoricoLigacao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCobranca.EDatPromessaChange(Sender: TObject);
begin
  EProximaLigacao.DateTime := incdia(EDatPromessa.datetime,2);
end;

{******************************************************************************}
procedure TFNovaCobranca.BGravarClick(Sender: TObject);
var
  vpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunContasAReceber.GravaDCobranca(VprDCobranca);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    EstadoBotoes(false);
    VprOperacao := ocConsulta;
  end;
end;

{******************************************************************************}
procedure TFNovaCobranca.BCancelarClick(Sender: TObject);
begin
  LimpaComponentes(PanelColor1,0);
  EstadoBotoes(false);
  VprOperacao := ocConsulta;
end;

{******************************************************************************}
procedure TFNovaCobranca.EHistoricoChange(Sender: TObject);
begin
  if VprOperacao in [ocinsercao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaCobranca.EHistoricoRetorno(Retorno1, Retorno2: String);
begin
  VprDCobranca.IndAtendeu := Retorno1 = 'S';
  if not VprDCobranca.IndAtendeu then
  begin
    EProximaLigacao.Datetime := date;
    AlteraCampoObrigatorioDet([ENomContato],false);
  end
  else
  begin
    EProximaLigacao.Datetime := incdia(EDatPromessa.Datetime,2);
    AlteraCampoObrigatorioDet([ENomContato],true);
  end;
  CDatPromessa.Checked := VprDCobranca.IndAtendeu;
  if VprOperacao in [ocinsercao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaCobranca.SpeedButton2Click(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));

  AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                 ' Where I_COD_CLI = '+IntToStr(Ligacoes.FieldByName('I_COD_CLI').AsInteger));
  FNovoCliente.CadClientes.Edit;
  FNovoCliente.showmodal;
  CarDClienteTela(Ligacoes.FieldByName('I_COD_CLI').AsInteger);
end;

{******************************************************************************}
procedure TFNovaCobranca.VerNota1Click(Sender: TObject);
var
  VpfDNota : TRBDNotaFiscal;
begin
    if ParcelasC_IND_CAD.AsString = 'S' then //mostra a cotação do CR
    begin
      FNovaCotacao := TFNovaCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCotacao'));
      FNovaCotacao.ConsultaCotacao(ParcelasI_EMP_FIL.AsString,ParcelasI_LAN_ORC.AsString);
      FNovaCotacao.free;
    end
    else
    begin
      if not(ParcelasI_SEQ_NOT.IsNull) then
      begin
        VpfDNota := TRBDNotaFiscal.cria;
        VpfDNota.CodFilial := ParcelasI_EMP_FIL.AsInteger;
        VpfDNota.SeqNota := ParcelasI_SEQ_NOT.AsInteger;
        FunNotaFiscal.CarDNotaFiscal(VpfDNota);
        FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
        FNovaNotaFiscalNota.ConsultaNota(VpfDNota);
        FNovaNotaFiscalNota.free;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaCobranca.HistricoLigao1Click(Sender: TObject);
begin
  FCobrancas := tFCobrancas.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCobrancas'));
  FCobrancas.HistoricoCobranca(ParcelasI_EMP_FIL.AsInteger,ParcelasI_LAN_REC.AsInteger,ParcelasI_NRO_PAR.asInteger);
  FCobrancas.free;
end;

{******************************************************************************}
procedure TFNovaCobranca.BaixarTitulo1Click(Sender: TObject);
var
  VpfDBaixaCR : TRBDBaixaCR;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  if ParcelasI_EMP_FIL.AsInteger <> 0 then
  begin
    VpfDBaixaCR := TRBDBaixaCR.Cria;
    VpfDParcela := VpfDBaixaCR.AddParcela;
    FunContasAReceber.CarDParcelaBaixa(VpfDParcela,ParcelasI_EMP_FIL.AsInteger,ParcelasI_LAN_REC.AsInteger,ParcelasI_NRO_PAR.AsInteger);
    FBaixaContasaReceberOO := TFBaixaContasaReceberOO.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaContasaReceberOO'));
    if FBaixaContasaReceberOO.BaixarContasAReceber(VpfDBaixaCR) then
    begin
      PosParcelas(Ligacoes.FieldByName('I_COD_CLI').AsInteger);
    end;
    FBaixaContasaReceberOO.free;
    VpfDBaixaCR.free;
  end;
end;

{******************************************************************************}
procedure TFNovaCobranca.BEmailClick(Sender: TObject);
begin
  if VprDCliente.DesEmailFinanceiro = '' then
    aviso('E-MAIL DO FINANCEIRO NÃO PREENCHIDO!!!'#13'É necessário preencher o e-mail do financeiro.')
  else
  begin
    FNovoEmailContasAReceber := tFNovoEmailContasAReceber.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoEmailContasAReceber'));
    FNovoEmailContasAReceber.EnviaHistoricoCobrancaCliente(ECodCliente.AInteiro);
    FNovoEmailContasAReceber.free;
  end;
end;

procedure TFNovaCobranca.BReciboClick(Sender: TObject);
var
  VpfValor, VpfDescricao : String;
begin
  Parcelas.First;
  while not Parcelas.Eof do
  begin
    VpfDescricao := VpfDescricao +ParcelasC_NRO_DUP.AsString + ', ';
    Parcelas.Next;
  end;
  VpfDescricao := copy(VpfDescricao,1,length(VpfDescricao)-2);
  VpfValor := ETotCorrigido.Text;
  if Entrada('Texto de referencia do recibo','Referente : ',vpfDescricao,false,ECodCliente.color,PanelColor2.color) then
    if EntradaNumero('Valor Recibo','Valor',VpfValor,false,ECodCliente.Color,PanelColor2.Color,true) then
    begin
      dtRave := TdtRave.create(self);
      dtRave.ImprimeRecibo(varia.CodigoEmpFil,VprDCliente,VpfDescricao,FormatFloat('#,###,##0.00',StrToFloat(VpfValor)),Extenso(StrToFloat(VpfValor),'reais','real'),varia.CidadeFilial+' '+ IntTostr(dia(date))+', de ' + TextoMes(date,false)+ ' de '+Inttostr(ano(date)));
      dtRave.free;
    end;
end;

{******************************************************************************}
procedure TFNovaCobranca.EMotivoCadastrar(Sender: TObject);
begin
  FMotivoInadimplencia := TFMotivoInadimplencia.CriarSDI(application,'', FPrincipal.VerificaPermisao('FMotivoInadimplencia'));
  FMotivoInadimplencia.BotaoCadastrar1.Click;
  FMotivoInadimplencia.showmodal;
  FMotivoInadimplencia.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCobranca.Histricosemailsecobrana1Click(Sender: TObject);
begin
  if ParcelasI_EMP_FIL.AsInteger <> 0 then
  begin
    FHistoricoECobranca := TFHistoricoECobranca.CriarSDI(self,'',FPrincipal.VerificaPermisao('FHistoricoECobranca'));
    FHistoricoECobranca.HistoricoECobranca(ParcelasI_EMP_FIL.AsInteger,ParcelasI_LAN_REC.AsInteger,ParcelasI_NRO_PAR.AsInteger);
    FHistoricoECobranca.free;
  end;
end;

{******************************************************************************}
procedure TFNovaCobranca.BContasReceberClick(Sender: TObject);
begin
  FContasaReceber := TFContasaReceber.CriarSDI(self,'',FPrincipal.VerificaPermisao('FContasaReceber'));
  FContasaReceber.ConsultaContasReceberCliente(ECodCliente.AInteiro);
  FContasaReceber.free;
end;

{******************************************************************************}
procedure TFNovaCobranca.SpeedButton4Click(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));

  AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+IntToStr(Ligacoes.FieldByName('I_COD_CLI').AsInteger));
  FNovoCliente.CadClientes.Edit;
  FNovoCliente.showmodal;
  CarDClienteTela(Ligacoes.FieldByName('I_COD_CLI').AsInteger);
  PosCliente(ECodCliente.AInteiro);
end;

{******************************************************************************}
procedure TFNovaCobranca.PosCliente(VpaCodCliente: Integer);
begin
  AdicionaSQLAbreTabela(CadClientes,'SELECT * FROM CADCLIENTES'+
                                    ' WHERE I_COD_CLI = '+IntToStr(VpaCodCliente));
  AtualizaLocalizas(PanelColor6);
  PainelCGC.Visible:= (CadClientes.FieldByname('C_TIP_PES').AsString = 'J');
end;

{******************************************************************************}
procedure TFNovaCobranca.PosCotacao(VpaCodCliente: Integer);
begin
  CADORCAMENTO.Close;
  CADORCAMENTO.SQL.Clear;
  CADORCAMENTO.SQL.Add('Select Orc.I_Lan_Orc, Orc.D_Dat_Orc, Cli.C_Nom_Cli, Pag.C_Nom_Pag,'+
                       ' Orc.T_Hor_Orc, Orc.D_Dat_Ent, Orc.C_Fla_Sit,'+
                       ' ORC.C_NOT_GER, ORC.C_GER_FIN, ORC.C_IND_CAN,'+
                       ' Orc.I_TIP_ORC, ORC.C_ORD_COM, Orc.N_VAL_TAX,'+
                       ' Orc.D_Dat_Pre, Orc.L_Obs_Orc, Orc.N_Vlr_TOT, Ven.C_Nom_Ven,'+
                       ' Orc.C_Nro_Not, Orc.I_COD_CLI, ORC.I_COD_VEN, ORC.I_EMP_FIL,'+
                       ' USU.I_COD_USU, USU.C_NOM_USU, ORC.C_IND_IMP,'+
                       ' ORC.I_COD_EST, EST.NOMEST, ORC.I_COD_TRA, '+
                       ' TRA.C_NOM_CLI C_NOM_TRA,'+
                       ' TIP.C_NOM_TIP'+
                       ' from CadOrcamentos Orc, CadClientes Cli, CadCondicoesPagto Pag,'+
                       ' CadVendedores Ven, CADUSUARIOS USU,'+
                       ' ESTAGIOPRODUCAO EST, CADCLIENTES TRA,'+
                       ' CADTIPOORCAMENTO TIP'+
                       ' Where cli.I_Cod_Cli = '+IntToStr(VpaCodCliente)+
                       ' and Cli.I_Cod_Cli = Orc.I_Cod_Cli'+
                       ' and Pag.I_Cod_Pag = Orc.i_Cod_Pag'+
                       ' And ven.I_cod_Ven = Orc.I_Cod_Ven'+
                       ' AND USU.I_COD_USU = ORC.I_COD_USU'+
                       ' AND '+SQLTextoRightJoin('ORC.I_COD_EST','EST.CODEST')+
                       ' AND '+SQLTextoRightJoin('ORC.I_COD_TRA','TRA.I_COD_CLI')+
                       ' and TIP.I_COD_TIP = ORC.I_TIP_ORC');
  CADORCAMENTO.SQL.Add(VprOrdemCotacao);
  CADORCAMENTO.Open;
  GOrcamento.ALinhaSQLOrderBy:= CADORCAMENTO.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovaCobranca.PosChamado(VpaCodCliente: Integer);
begin
  ChamadoTecnico.Close;
  ChamadoTecnico.SQL.Clear;
  ChamadoTecnico.SQL.Add('SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.NOMSOLICITANTE,'+
                         ' CHA.VALCHAMADO, CHA.VALDESLOCAMENTO, CHA.CODESTAGIO, CHA.LANORCAMENTO,'+
                         ' CHA.CODTECNICO,'+
                         ' CLI.C_NOM_CLI,'+
                         ' TEC.NOMTECNICO,'+
                         ' USU.C_NOM_USU,'+
                         ' EST.NOMEST,'+
                         ' TIC.NOMTIPOCHAMADO'+
                         ' FROM CHAMADOCORPO CHA, CADCLIENTES CLI, TECNICO TEC, CADUSUARIOS USU, ESTAGIOPRODUCAO EST,'+
                         ' TIPOCHAMADO TIC'+
                         ' WHERE CHA.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                         ' AND CHA.CODCLIENTE = CLI.I_COD_CLI'+
                         ' AND CHA.CODTECNICO = TEC.CODTECNICO'+
                         ' AND CHA.CODUSUARIO = USU.I_COD_USU'+
                         ' AND CHA.CODESTAGIO = EST.CODEST'+
                         ' AND CHA.CODTIPOCHAMADO = TIC.CODTIPOCHAMADO');
  ChamadoTecnico.SQL.Add(VprOrdemChamado);
  ChamadoTecnico.Open;
  GChamados.ALinhaSQLOrderBy:= ChamadoTecnico.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovaCobranca.PosNotaFiscal(VpaCodCliente: Integer);
begin
  NOTAS.Close;
  NOTAS.SQL.Clear;
  NOTAS.SQL.Add('select NF.I_EMP_FIL,'+
                ' NF.I_NRO_NOT, CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_TIP_CAD, NF.C_FLA_ECF, NF.c_not_can,'+
                ' NF.L_OBS_NOT, NF.N_TOT_PRO, NF.N_TOT_NOT, NF.I_NRO_LOJ, NF.I_NRO_CAI, CLI.D_DAT_CAD,'+
                ' CLI.D_DAT_ALT, CLI.C_END_CLI, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_EST_CLI, CLI.C_CPF_CLI,'+
                ' CLI.C_CGC_CLI, CLI.C_FON_FAX, NF.D_DAT_SAI, NF.T_HOR_SAI, NF.I_QTD_VOL, NF.N_VLR_ICM,'+
                ' NF.N_BAS_SUB, NF.N_VLR_SUB, NF.N_VLR_FRE, NF.N_VLR_SEG, NF.N_OUT_DES, NF.N_TOT_IPI,'+
                ' NF.N_PES_BRU, NF.N_PES_LIQ, NF.N_TOT_SER, NF.N_VLR_ISQ, NF.I_SEQ_NOT, NF.C_COD_NAT,'+
                ' NF.C_NOT_IMP, NF.I_ITE_NAT, NF.C_SER_NOT, NF.D_DAT_EMI ,'+
                ' USU.C_NOM_USU '+
                ' from CADNOTAFISCAIS NF, CADCLIENTES CLI, CADUSUARIOS USU'+
                ' WHERE NF.I_COD_CLI = '+IntToStr(VpaCodCliente)+
                ' AND '+SQLTextoRightJoin('NF.I_COD_CLI','CLI.I_COD_CLI')+
                ' AND '+SQLTextoRightJoin('NF.I_COD_USU','USU.I_COD_USU'));
  NOTAS.SQL.Add(VprOrdemNotaFiscal);
  NOTAS.Open;
  GNotasFiscais.ALinhaSQLOrderBy:= NOTAS.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovaCobranca.PosHistoricoLigacao(VpaCodCliente: Integer);
begin
  HISTORICO.Close;
  HISTORICO.SQL.Clear;
  HISTORICO.SQL.Add('select SEQCOBRANCA, DATCOBRANCA, CLI.C_NOM_CLI, HIS.DESHISTORICO,'+
                    ' COB.DESFALADOCOM, USU.C_NOM_USU, COB.DESOBSERVACAO,'+
                    ' COB.DATPROXIMALIGACAO, COB.DATPROMESSAPAGAMENTO,'+
                    ' DESOBSPROXIMALIGACAO'+
                    ' from COBRANCACORPO COB, HISTORICOLIGACAO HIS, CADUSUARIOS USU, CADCLIENTES CLI'+
                    ' WHERE COB.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                    ' AND HIS.CODHISTORICO = COB.CODHISTORICO'+
                    ' AND COB.CODUSUARIO = USU.I_COD_USU'+
                    ' AND COB.CODCLIENTE = CLI.I_COD_CLI');
  HISTORICO.SQL.Add(VprOrdemHistorico);
  HISTORICO.Open;
  GHistorico.ALinhaSQLOrderBy:= HISTORICO.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovaCobranca.PaginasChange(Sender: TObject);
begin
  FechaTabelas;
  if Paginas.ActivePage = PCotacao then
    PosCotacao(Ligacoes.FieldByName('I_COD_CLI').AsInteger)
  else
    if Paginas.ActivePage = PChamados then
      PosChamado(Ligacoes.FieldByName('I_COD_CLI').AsInteger)
    else
      if Paginas.ActivePage = PNotaFiscal then
        PosNotaFiscal(Ligacoes.FieldByName('I_COD_CLI').AsInteger)
      else
        if Paginas.ActivePage = PHistorico then
          PosHistoricoLigacao(Ligacoes.FieldByName('I_COD_CLI').AsInteger)
        else
          if Paginas.ActivePage = PgCliente then
            PosCliente(Ligacoes.FieldByName('I_COD_CLI').AsInteger);
end;

{******************************************************************************}
procedure TFNovaCobranca.GOrcamentoOrdem(Ordem: String);
begin
  VprOrdemCotacao:= Ordem;
end;

{******************************************************************************}
procedure TFNovaCobranca.GChamadosOrdem(Ordem: String);
begin
  VprOrdemChamado:= Ordem;
end;

{******************************************************************************}
procedure TFNovaCobranca.GNotasFiscaisOrdem(Ordem: String);
begin
  VprOrdemNotaFiscal:= Ordem;
end;

{******************************************************************************}
procedure TFNovaCobranca.GHistoricoOrdem(Ordem: String);
begin
  VprOrdemHistorico:= Ordem;
end;

{******************************************************************************}
procedure TFNovaCobranca.HISTORICOAfterScroll(DataSet: TDataSet);
begin
  PosHistoricoItem;
end;

{******************************************************************************}
procedure TFNovaCobranca.PosHistoricoItem;
begin
  AdicionaSQLAbreTabela(HISTORICOITEM,'select MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR, MOV.D_DAT_VEN, MOV.N_VLR_PAR, '+
                                      ' MOV.C_NRO_DUP, MOV.I_QTD_LIG, MOV.I_QTD_ATE, FRM.C_NOM_FRM '+
                                      ' from MOVCONTASARECEBER MOV, CADFORMASPAGAMENTO FRM, COBRANCAITEM ITE '+
                                      ' WHERE MOV.I_COD_FRM = FRM.I_COD_FRM '+
                                      ' AND MOV.I_EMP_FIL = ITE.CODFILIAL '+
                                      ' AND MOV.I_LAN_REC = ITE.LANRECEBER '+
                                      ' AND MOV.I_NRO_PAR = ITE.NUMPARCELA '+
                                      ' AND ITE.SEQCOBRANCA = '+HISTORICOSEQCOBRANCA.AsString);
end;

{******************************************************************************}
procedure TFNovaCobranca.CADORCAMENTOAfterScroll(DataSet: TDataSet);
begin
  PosMovOrcamento(CADORCAMENTOI_EMP_FIL.AsString, CADORCAMENTOI_Lan_Orc.AsString);
end;

{******************************************************************************}
procedure TFNovaCobranca.PosMovOrcamento(VpaCodfilial, VpaOrcamento : String);
begin
  MovOrcamentos.close;
  MovOrcamentos.sql.clear;
  MovOrcamentos.sql.add('Select Mov.I_Emp_Fil, Mov.I_Lan_Orc,Mov.N_Qtd_Pro, Mov.N_Vlr_Pro, Mov.N_Vlr_Tot, Mov.C_Cod_Uni, '+
                        ' C_Imp_Fot, C_Fla_Res, Mov.N_Qtd_Bai,MOV.C_DES_COR, Pro.C_Nom_Pro, Pro.I_Seq_Pro, MOV.I_SEQ_MOV, MOV.C_NOM_PRO PRODUTOCOTACAO,');
  if UpperCase(Varia.CodigoProduto) = 'C_COD_PRO' Then
    MovOrcamentos.Sql.add('Pro.'+Varia.CodigoProduto + ' C_Cod_Pro')
  else
    MovOrcamentos.Sql.add('QTD.'+Varia.CodigoProduto + ' C_Cod_Pro');

  MovOrcamentos.sql.add(' from MovOrcamentos Mov, CadProdutos Pro, MovQdadeProduto QTD' +
                        ' Where mov.I_Emp_Fil = ' + VpaCodfilial +
                        ' and Mov.I_Lan_Orc = ' + VpaOrcamento +
                        ' and Mov.I_Seq_Pro = Pro.I_Seq_Pro '+
                        ' and Mov.I_Seq_Pro = Qtd.I_Seq_Pro '+
                        ' and Mov.I_Emp_Fil = QTd.I_Emp_Fil '+
                        ' union ' +
                        ' Select Orc.I_Emp_Fil, Orc.I_Lan_Orc,Orc.N_Qtd_Ser, '+
                        ' Orc.N_Vlr_Ser,Orc.N_Vlr_Tot, ''SE''  Unis,  ''-'' Foto, '+
                        ' ''-'' Res, N_QTD_BAI,'' '' ,Ser.C_Nom_Ser, Ser.I_Cod_ser,ORC.I_COD_SER,SER.C_NOM_SER, Cast(Ser.I_Cod_Ser as VARChar2(20)) C_Cod_Pro '+
                        ' from movservicoorcamento orc, cadservico ser ' +
                        ' Where orc.I_Emp_Fil = ' + VpaCodfilial +
                        ' and Orc.I_Lan_Orc = ' + VpaOrcamento +
                        ' and Orc.I_Cod_Ser = Ser.I_Cod_Ser ');
  MovOrcamentos.sql.add(' order by 13 ');
  MovOrcamentos.open;
end;

{******************************************************************************}
procedure TFNovaCobranca.ChamadoTecnicoAfterScroll(DataSet: TDataSet);
begin
  PosProdutosChamado;
end;

{******************************************************************************}
procedure TFNovaCobranca.PosProdutosChamado;
begin
  AdicionaSQLAbreTabela(ChamadoProduto,'select CHP.SEQITEM, CHP.SEQPRODUTO,  CHP.NUMCONTADOR, CHP.NUMSERIE, CHP.NUMSERIEINTERNO, CHP.DESSETOR, CHP.DATGARANTIA, '+
                                       ' CHP.DESPROBLEMA, CHP.CODFILIALCONTRATO, '+
                                       ' PRO.C_NOM_PRO, '+
                                       ' COC.SEQCONTRATO, COC.CODTIPOCONTRATO '+
                                       ' from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO COC '+
                                       ' Where CHP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                       ' AND '+SQLTextoRightJoin('CHP.SEQCONTRATO','COC.SEQCONTRATO')+
                                       ' AND '+SQLTextoRightJoin('CHP.CODFILIALCONTRATO','COC.CODFILIAL')+
                                       ' AND CHP.CODFILIAL = '+ChamadoTecnicoCODFILIAL.AsString+
                                       ' AND CHP.NUMCHAMADO = '+ChamadoTecnicoNUMCHAMADO.AsString);
end;

{******************************************************************************}
procedure TFNovaCobranca.NOTASAfterScroll(DataSet: TDataSet);
begin
  PosItensNotaFiscal;
end;

{******************************************************************************}
procedure TFNovaCobranca.PosItensNotaFiscal;
begin
  AdicionaSQLAbreTabela(NOTASPRODUTOS,'SELECT'+
                                      ' PRO.C_COD_PRO, PRO.C_NOM_PRO,'+
                                      ' MNF.I_COD_COR, COR.NOM_COR, MNF.C_COD_UNI, MNF.N_QTD_PRO, MNF.N_VLR_PRO, MNF.N_TOT_PRO'+
                                      ' FROM'+
                                      ' MOVNOTASFISCAIS MNF, CADPRODUTOS PRO, COR COR'+
                                      ' WHERE'+
                                      ' MNF.I_EMP_FIL = '+NOTASI_EMP_FIL.AsString+
                                      ' AND MNF.I_SEQ_NOT = '+NOTASI_SEQ_NOT.AsString+
                                      ' AND PRO.I_SEQ_PRO = MNF.I_SEQ_PRO'+
                                      ' AND '+SQLTextoRightJoin('MNF.I_COD_COR','COR.COD_COR'));
end;

{******************************************************************************}
procedure TFNovaCobranca.Consultar1Click(Sender: TObject);
begin
  ConsultaOrcamento;
end;

{******************************************************************************}
procedure TFNovaCobranca.ConsultaOrcamento;
begin
  FNovaCotacao:= TFNovaCotacao.CriarSDI(Application,'',True);
  FNovaCotacao.ConsultaCotacao(CADORCAMENTOI_EMP_FIL.AsString,CADORCAMENTOI_Lan_Orc.AsString);
  FNovaCotacao.Free;
end;

{******************************************************************************}
procedure TFNovaCobranca.FechaTabelas;
begin
  CADCLIENTES.close;
  CADORCAMENTO.close;
  ChamadoTecnico.close;
  NOTAS.close;
  HISTORICO.close;
  HISTORICOITEM.close;
  MovOrcamentos.close;
  ChamadoProduto.close;
  NOTASPRODUTOS.close;
end;

{******************************************************************************}
procedure TFNovaCobranca.ConsultaChamado;
begin
  FNovoChamado:= TFNovoChamado.CriarSDI(Application,'',True);
  FNovoChamado.Consultachamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
  FNovoChamado.Free;
end;

{******************************************************************************}
procedure TFNovaCobranca.ConsultaNotaFiscal;
var
  VpfNotaFiscal: TRBDNotaFiscal;
begin
  VpfNotaFiscal:= TRBDNotaFiscal.cria;
  VpfNotaFiscal.CodFilial:= NOTASI_EMP_FIL.AsInteger;
  VpfNotaFiscal.SeqNota:= NOTASI_SEQ_NOT.AsInteger;
  FunNotaFiscal.CarDNotaFiscal(VpfNotaFiscal);
  FNovaNotaFiscalNota:= TFNovaNotaFiscalNota.criarSDI(Application,'',True);
  FNovaNotaFiscalNota.ConsultaNota(VpfNotaFiscal);
  FNovaNotaFiscalNota.Free;
end;

{******************************************************************************}
procedure TFNovaCobranca.MenuItem2Click(Sender: TObject);
begin
  ConsultaChamado;
end;

{******************************************************************************}
procedure TFNovaCobranca.MenuItem1Click(Sender: TObject);
begin
  ConsultaNotaFiscal;
end;

{******************************************************************************}
procedure TFNovaCobranca.EnviarBoletoEmail1Click(Sender: TObject);
begin
  Parcelas.First;
  while not Parcelas.Eof do
  begin
    FunImpBoleto.ImprimeBoleto(ParcelasI_EMP_FIL.AsInteger, ParcelasI_LAN_REC.AsInteger,ParcelasI_NRO_PAR.AsInteger,
                                    VprDCliente, false,'',true);
    Parcelas.next;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaCobranca]);
end.

