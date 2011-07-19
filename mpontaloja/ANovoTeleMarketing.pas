unit ANovoTeleMarketing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids,
  DBGrids, Tabela, DBKeyViolation, ComCtrls, Localizacao, UnClientes, UnDados,
  Db, DBTables, Constantes, UnTeleMarketing, Menus, DBCtrls, Uncontrato,
  Mask, unPedidoCompra, UnDadosProduto, FMTBcd, DBClient, SqlExpr, UnProposta;

type
  TFNovoTeleMarketing = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BProximo: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Ligacoes: TSQLQuery;
    ValidaGravacao1: TValidaGravacao;
    CadOrcamentos: TSQL;
    CadOrcamentosI_EMP_FIL: TFMTBCDField;
    CadOrcamentosI_LAN_ORC: TFMTBCDField;
    CadOrcamentosC_NRO_NOT: TWideStringField;
    CadOrcamentosD_DAT_ORC: TSQLTimeStampField;
    CadOrcamentosN_VLR_TOT: TFMTBCDField;
    CadOrcamentosC_NOM_VEN: TWideStringField;
    CadOrcamentosC_NOM_USU: TWideStringField;
    DataCadOrcamentos: TDataSource;
    MovOrcamentos: TSQL;
    DataMovOrcamentos: TDataSource;
    PopupMenu1: TPopupMenu;
    VerCotao1: TMenuItem;
    BCotacao: TBitBtn;
    PanelColor4: TPanelColor;
    Paginas: TPageControl;
    PClientes: TTabSheet;
    PLigacao: TTabSheet;
    PanelColor1: TPanelColor;
    Label12: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    SpeedButton1: TSpeedButton;
    Label17: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label13: TLabel;
    SpeedButton3: TSpeedButton;
    Label14: TLabel;
    EObservacoes: TMemoColor;
    ENomContato: TEditColor;
    EHistorico: TEditLocaliza;
    EProximaLigacao: TCalendario;
    EProximaObservacao: TEditColor;
    ECampanhaVendas: TEditLocaliza;
    PCompras: TTabSheet;
    GOrcamentos: TGridIndice;
    GProdutos: TGridIndice;
    PHistoricos: TTabSheet;
    PProdutos: TTabSheet;
    DataHistoricoLigacoes: TDataSource;
    HistoricoLigacoes: TSQL;
    LigacoesDATLIGACAO: TSQLTimeStampField;
    LigacoesLANORCAMENTO: TFMTBCDField;
    LigacoesDESFALADOCOM: TWideStringField;
    LigacoesDESOBSERVACAO: TWideStringField;
    LigacoesC_NOM_USU: TWideStringField;
    LigacoesDESHISTORICO: TWideStringField;
    Grade: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    PanelColor3: TPanelColor;
    PanelColor5: TPanelColor;
    Label23: TLabel;
    GridIndice1: TGridIndice;
    Label24: TLabel;
    GridIndice2: TGridIndice;
    BCadastrarProdutoCliente: TBitBtn;
    ProdutosSemContrato: TSQL;
    DataProdutosSemContrato: TDataSource;
    ProdutosSemContratoCODPRODUTO: TWideStringField;
    ProdutosSemContratoDESSETOR: TWideStringField;
    ProdutosSemContratoNUMSERIE: TWideStringField;
    ProdutosSemContratoNUMSERIEINTERNO: TWideStringField;
    ProdutosSemContratoQTDPRODUTO: TFMTBCDField;
    ProdutosSemContratoDESUM: TWideStringField;
    ProdutosSemContratoC_NOM_PRO: TWideStringField;
    ProdutosComContrato: TSQL;
    ProdutosComContratoSEQCONTRATO: TFMTBCDField;
    ProdutosComContratoNOMTIPOCONTRATO: TWideStringField;
    ProdutosComContratoCODPRODUTO: TWideStringField;
    ProdutosComContratoNUMSERIE: TWideStringField;
    ProdutosComContratoNUMSERIEINTERNO: TWideStringField;
    ProdutosComContratoQTDULTIMALEITURA: TFMTBCDField;
    ProdutosComContratoDESSETOR: TWideStringField;
    ProdutosComContratoC_NOM_PRO: TWideStringField;
    DataProdutosComContrato: TDataSource;
    BVisualizaContrato: TBitBtn;
    ProdutosComContratoCODFILIAL: TFMTBCDField;
    EHoraProximaLigacao: TMaskEditColor;
    Label26: TLabel;
    Label27: TLabel;
    EDatAgendado: TEditColor;
    Tempo: TTimer;
    Label28: TLabel;
    ETempoLigacao: TEditColor;
    HistoricoLigacoesDATTEMPOLIGACAO: TSQLTimeStampField;
    CadClientes: TSQL;
    ScrollBox1: TScrollBox;
    PanelColor6: TPanelColor;
    SpeedButton2: TSpeedButton;
    DataCadClientes: TDataSource;
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
    DBEditUF1: TDBEditUF;
    DBEditColor42: TDBEditColor;
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
    EVendedor: TDBEditLocaliza;
    ECondicaoPagamento: TDBEditLocaliza;
    EFormaPagamento: TDBEditLocaliza;
    DBEditColor12: TDBEditColor;
    DBEditLocaliza3: TDBEditLocaliza;
    DBEditLocaliza4: TDBEditLocaliza;
    DBEditColor45: TDBEditColor;
    ETecnico: TDBEditLocaliza;
    Label40: TLabel;
    Bevel4: TBevel;
    DBEditColor30: TDBEditColor;
    Label45: TLabel;
    DBEditColor31: TDBEditColor;
    Label46: TLabel;
    CData: TCheckBox;
    ProdutosSemContratoDATGARANTIA: TSQLTimeStampField;
    ProdutosSemContratoVALCONCORRENTE: TFMTBCDField;
    ProdutosSemContratoNOMDONO: TWideStringField;
    BAgendar: TBitBtn;
    CadOrcamentosC_NOM_TIP: TWideStringField;
    Aux: TSQL;
    DBEditColor3: TDBEditColor;
    Label15: TLabel;
    ProdutosSemContratoQTDCOPIAS: TFMTBCDField;
    PInadimplentes: TTabSheet;
    GridIndice3: TGridIndice;
    Inadimplentes: TSQL;
    InadimplentesD_DAT_VEN: TSQLTimeStampField;
    InadimplentesD_DAT_EMI: TSQLTimeStampField;
    InadimplentesN_VLR_PAR: TFMTBCDField;
    InadimplentesI_NRO_NOT: TFMTBCDField;
    InadimplentesC_NRO_DUP: TWideStringField;
    InadimplentesI_NRO_PAR: TFMTBCDField;
    InadimplentesI_QTD_PAR: TFMTBCDField;
    InadimplentesC_NOM_FRM: TWideStringField;
    InadimplentesI_QTD_LIG: TFMTBCDField;
    InadimplentesI_QTD_ATE: TFMTBCDField;
    InadimplentesI_COD_PAG: TFMTBCDField;
    InadimplentesC_NOM_PAG: TWideStringField;
    InadimplentesI_COD_FRM: TFMTBCDField;
    InadimplentesDiasAtraso: TFMTBCDField;
    InadimplentesParcela: TWideStringField;
    InadimplentesC_OBS_LIG: TWideStringField;
    InadimplentesI_EMP_FIL: TFMTBCDField;
    InadimplentesI_LAN_REC: TFMTBCDField;
    InadimplentesC_IND_CAD: TWideStringField;
    InadimplentesI_SEQ_NOT: TFMTBCDField;
    InadimplentesValorMora: TCurrencyField;
    InadimplentesValorCorrigido: TCurrencyField;
    InadimplentesN_PER_MOR: TFMTBCDField;
    InadimplentesN_TOT_TAR: TFMTBCDField;
    InadimplentesD_TIT_PRO: TSQLTimeStampField;
    InadimplentesD_ENV_CAR: TSQLTimeStampField;
    InadimplentesI_LAN_ORC: TFMTBCDField;
    DataParcelas: TDataSource;
    ProdutosComContratoDATDESATIVACAO: TSQLTimeStampField;
    PChamados: TTabSheet;
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
    DataChamadoTecnico: TDataSource;
    GridIndice4: TGridIndice;
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
    PanelColor7: TPanelColor;
    GridIndice5: TGridIndice;
    DBMemoColor2: TDBMemoColor;
    MovOrcamentosI_Emp_Fil: TFMTBCDField;
    MovOrcamentosI_Lan_Orc: TFMTBCDField;
    MovOrcamentosN_Qtd_Pro: TFMTBCDField;
    MovOrcamentosN_Vlr_Pro: TFMTBCDField;
    MovOrcamentosN_Vlr_Tot: TFMTBCDField;
    MovOrcamentosC_Cod_Uni: TWideStringField;
    MovOrcamentosC_Imp_Fot: TWideStringField;
    MovOrcamentosC_Fla_Res: TWideStringField;
    MovOrcamentosN_Qtd_Bai: TFMTBCDField;
    MovOrcamentosC_DES_COR: TWideStringField;
    MovOrcamentosPRODUTOCOTACAO: TWideStringField;
    MovOrcamentosC_Cod_PRo: TWideStringField;
    MovOrcamentosC_Nom_Pro: TWideStringField;
    MovOrcamentosI_Seq_Pro: TFMTBCDField;
    BitBtn1: TBitBtn;
    DBEditColor4: TDBEditColor;
    CONTATOS: TSQL;
    DataCONTATOS: TDataSource;
    PContatos: TTabSheet;
    GContatos: TGridIndice;
    PanelColor8: TPanelColor;
    BContatos: TBitBtn;
    CONTATOSNOMCONTATO: TWideStringField;
    CONTATOSDATNASCIMENTO: TSQLTimeStampField;
    CONTATOSDESTELEFONE: TWideStringField;
    CONTATOSDESEMAIL: TWideStringField;
    CONTATOSC_NOM_PRF: TWideStringField;
    CONTATOSINDACEITAEMARKETING: TWideStringField;
    PCliente: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    Label25: TLabel;
    Label21: TLabel;
    ECodCliente: TEditColor;
    ENomCliente: TEditColor;
    EContato: TEditColor;
    EFone1: TEditColor;
    EFone2: TEditColor;
    ELigarDiaSemana: TEditColor;
    ELigarPeriodo: TEditColor;
    CAceitaTeleMarketing: TCheckBox;
    EObsLigacaocliente: TMemoColor;
    EDatUltimaLigacacao: TEditColor;
    EQtdLigacoesComVenda: TEditColor;
    EQtdLigacoesSemVenda: TEditColor;
    EditColor1: TEditColor;
    EConcorrente: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label41: TLabel;
    PCotacoes: TPopupMenu;
    Proposta1: TMenuItem;
    Panel1: TPanel;
    Label47: TLabel;
    PPedidosCompra: TTabSheet;
    Splitter1: TSplitter;
    GPedidoProduto: TGridIndice;
    PEDIDOCOMPRACORPO: TSQL;
    PEDIDOCOMPRACORPOSEQPEDIDO: TFMTBCDField;
    PEDIDOCOMPRACORPODATPREVISTA: TSQLTimeStampField;
    PEDIDOCOMPRACORPOC_NOM_CLI: TWideStringField;
    PEDIDOCOMPRACORPOVALTOTAL: TFMTBCDField;
    PEDIDOCOMPRACORPOC_NOM_PAG: TWideStringField;
    PEDIDOCOMPRACORPOCODFILIAL: TFMTBCDField;
    PEDIDOCOMPRACORPODATAPROVACAO: TSQLTimeStampField;
    PEDIDOCOMPRACORPOC_NOM_USU: TWideStringField;
    PEDIDOCOMPRACORPODATENTREGA: TSQLTimeStampField;
    PEDIDOCOMPRACORPODATPAGAMENTOANTECIPADO: TSQLTimeStampField;
    PEDIDOCOMPRACORPONOMEST: TWideStringField;
    PEDIDOCOMPRACORPOCODESTAGIO: TFMTBCDField;
    PEDIDOCOMPRACORPOUSUAPROVACAO: TWideStringField;
    PEDIDOCOMPRACORPODATPEDIDO: TSQLTimeStampField;
    PEDIDOCOMPRACORPONOMCOMPRADOR: TWideStringField;
    DataPEDIDOCOMPRACORPO: TDataSource;
    PRODUTOPEDIDO: TSQL;
    PRODUTOPEDIDOC_NOM_PRO: TWideStringField;
    PRODUTOPEDIDONOM_COR: TWideStringField;
    PRODUTOPEDIDODESREFERENCIAFORNECEDOR: TWideStringField;
    PRODUTOPEDIDOQTDPRODUTO: TFMTBCDField;
    PRODUTOPEDIDODESUM: TWideStringField;
    PRODUTOPEDIDOVALUNITARIO: TFMTBCDField;
    PRODUTOPEDIDOVALTOTAL: TFMTBCDField;
    PRODUTOPEDIDOQTDSOLICITADA: TFMTBCDField;
    DataPRODUTOPEDIDO: TDataSource;
    GPedidoCorpo: TGridIndice;
    PopupMenu2: TPopupMenu;
    VerPedido1: TMenuItem;
    N1: TMenuItem;
    Alterar1: TMenuItem;
    PEDIDOCOMPRACORPODATRENEGOCIADO: TSQLTimeStampField;
    PEDIDOCOMPRACORPORenegociado: TSQLTimeStampField;
    PPropostas: TTabSheet;
    GPropostas: TGridIndice;
    PProAmoPropostas: TPageControl;
    PItens: TTabSheet;
    GProdutosProposta: TGridIndice;
    PAmostras: TTabSheet;
    GAmostraProposta: TGridIndice;
    PanelColor9: TPanelColor;
    Foto: TImage;
    DataMovITENSPROPOSTA: TDataSource;
    MovITENSPROPOSTA: TSQL;
    MovITENSPROPOSTANOMPRODUTO: TWideStringField;
    MovITENSPROPOSTANOMCOR: TWideStringField;
    MovITENSPROPOSTADESUM: TWideStringField;
    MovITENSPROPOSTAQTDPRODUTO: TFMTBCDField;
    MovITENSPROPOSTAVALUNITARIO: TFMTBCDField;
    MovITENSPROPOSTAVALTOTAL: TFMTBCDField;
    MovITENSPROPOSTANUMOPCAO: TFMTBCDField;
    DataMovAMOSTRAPROPOSTA: TDataSource;
    MovAMOSTRAPROPOSTA: TSQL;
    MovAMOSTRAPROPOSTANOMAMOSTRA: TWideStringField;
    MovAMOSTRAPROPOSTANOMCOR: TWideStringField;
    MovAMOSTRAPROPOSTAQTDAMOSTRA: TFMTBCDField;
    MovAMOSTRAPROPOSTAVALUNITARIO: TFMTBCDField;
    MovAMOSTRAPROPOSTAVALTOTAL: TFMTBCDField;
    MovAMOSTRAPROPOSTADESIMAGEM: TWideStringField;
    DataPROPOSTAS: TDataSource;
    PROPOSTAS: TSQL;
    PROPOSTASCODFILIAL: TFMTBCDField;
    PROPOSTASSEQPROPOSTA: TFMTBCDField;
    PROPOSTASDATPROPOSTA: TSQLTimeStampField;
    PROPOSTASDATPREVISAOCOMPRA: TSQLTimeStampField;
    PROPOSTASINDCOMPROU: TWideStringField;
    PROPOSTASINDCOMPROUCONCORRENTE: TWideStringField;
    PROPOSTASVALTOTAL: TFMTBCDField;
    PROPOSTASC_NOM_PAG: TWideStringField;
    PROPOSTASNOMEST: TWideStringField;
    PopupMenu3: TPopupMenu;
    NovaProposta1: TMenuItem;
    N3: TMenuItem;
    Consultar1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N2: TMenuItem;
    AlterarEstgio1: TMenuItem;
    N4: TMenuItem;
    AlterarEstgio2: TMenuItem;
    N5: TMenuItem;
    ConcluirPedidoCompra1: TMenuItem;
    PRODUTOPEDIDOQTDBAIXADO: TFMTBCDField;
    N6: TMenuItem;
    ConsultarNotasFiscais1: TMenuItem;
    PNotas: TTabSheet;
    GridIndice7: TGridIndice;
    NOTAS: TSQL;
    NOTASI_NRO_NOT: TFMTBCDField;
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
    DATANOTAS: TDataSource;
    NotaGrid: TGridIndice;
    MovNotas: TSQL;
    DataMovNotas: TDataSource;
    MovNotasC_COD_UNI: TWideStringField;
    MovNotasN_QTD_PRO: TFMTBCDField;
    MovNotasN_VLR_PRO: TFMTBCDField;
    MovNotasN_TOT_PRO: TFMTBCDField;
    MovNotasC_COD_PRO: TWideStringField;
    MovNotasPRODUTONOTA: TWideStringField;
    MovNotasC_NOM_PRO: TWideStringField;
    MovNotasPRODUTO: TWideStringField;
    PopupMenu4: TPopupMenu;
    VerNota1: TMenuItem;
    EVendedorHistorico: TRBEditLocaliza;
    Label49: TLabel;
    SpeedButton6: TSpeedButton;
    Label50: TLabel;
    MHistoricoTelemarketing: TPopupMenu;
    MExcluirHistorico: TMenuItem;
    HistoricoLigacoesCODFILIAL: TFMTBCDField;
    HistoricoLigacoesCODCLIENTE: TFMTBCDField;
    HistoricoLigacoesSEQTELE: TFMTBCDField;
    ProdutosComContratoDATINICIOVIGENCIA: TSQLTimeStampField;
    ProdutosComContratoDATFIMVIGENCIA: TSQLTimeStampField;
    ProdutosComContratoDATCANCELAMENTO: TSQLTimeStampField;
    RBDBEditLocaliza1: TRBDBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EHistoricoCadastrar(Sender: TObject);
    procedure EHistoricoChange(Sender: TObject);
    procedure EHistoricoRetorno(Retorno1, Retorno2: String);
    procedure BCancelarClick(Sender: TObject);
    procedure BProximoClick(Sender: TObject);
    procedure CadOrcamentosAfterScroll(DataSet: TDataSet);
    procedure VerCotao1Click(Sender: TObject);
    procedure BCotacaoClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure BCadastrarProdutoClienteClick(Sender: TObject);
    procedure BVisualizaContratoClick(Sender: TObject);
    procedure TempoTimer(Sender: TObject);
    procedure CDataClick(Sender: TObject);
    procedure BDiscararClick(Sender: TObject);
    procedure BAgendarClick(Sender: TObject);
    procedure GridIndice1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ChamadoTecnicoAfterScroll(DataSet: TDataSet);
    procedure GridIndice4DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BContatosClick(Sender: TObject);
    procedure GPedidoCorpoOrdem(Ordem: String);
    procedure PEDIDOCOMPRACORPOAfterScroll(DataSet: TDataSet);
    procedure VerPedido1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure PEDIDOCOMPRACORPOCalcFields(DataSet: TDataSet);
    procedure PROPOSTASAfterScroll(DataSet: TDataSet);
    procedure MovAMOSTRAPROPOSTAAfterScroll(DataSet: TDataSet);
    procedure NovaProposta1Click(Sender: TObject);
    procedure Consultar1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure AlterarEstgio1Click(Sender: TObject);
    procedure GProdutosPropostaOrdem(Ordem: String);
    procedure GPropostasOrdem(Ordem: String);
    procedure AlterarEstgio2Click(Sender: TObject);
    procedure ConcluirPedidoCompra1Click(Sender: TObject);
    procedure ConsultarNotasFiscais1Click(Sender: TObject);
    procedure MovNotasCalcFields(DataSet: TDataSet);
    procedure NOTASAfterScroll(DataSet: TDataSet);
    procedure VerNota1Click(Sender: TObject);
    procedure MExcluirHistoricoClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao,
    VprIndAtivo : Boolean;
    VprDCliente : TRBDCliente;
    VprDTeleMarketing : TRBDTelemarketing;
    VprOperacao : TRBDOperacaoCadastro;
    VprOrdemPedidoCompraCorpo,
    VprOrdemPedidoCompraItem,
    VprOrdemProposta,
    VprOrdemItensProposta: String;
    FunTeleMarketing :TRBFuncoesTeleMarketing;
    FunContrato : TRBFuncoesContrato;
    FunProposta : TRBFuncoesProposta;
    procedure VerificaPermissaoUsuario;
    procedure PosClientesTelemarketingAtivo;
    procedure ConfiguraTeleMarketingAtivo;
    procedure ProximaLigacao;
    procedure CarDClienteTela(VpaCodCliente : Integer);
    procedure PosPedidosCompra(VpaCodCliente : Integer);
    procedure PosCompras(VpaCodCliente : Integer);
    procedure PosItemsCompras(VpaCodFilial,VpaLanOrcamento : Integer);
    procedure PosHistoricoLigacao(VpaCodCliente : Integer);
    procedure PosProdutos(VpaCodCliente : Integer);
    procedure PosProdutoComContrato(VpaCodCliente : Integer);
    procedure PosProdutosSemContrato(VpaCodCliente : Integer);
    procedure PosInadimplencia(VpaCodCliente : Integer);
    procedure PosChamados(VpaCodCliente : Integer);
    procedure PosProdutosChamado;
    procedure PosContatos(VpaCodCliente: Integer);
    procedure PosCliente(VpaCodCliente : Integer);
    procedure PosPropostas(VpaCodCliente: Integer);
    procedure PosItensProposta(VpaCodFilial, VpaSeqProposta: Integer);
    procedure PosAmostrasProposta(VpaSeqProposta: Integer);
    procedure PosNotas(VpaCodCliente : Integer);
    procedure PosNotasItens(VpaCodFilial, VpaSeqNota : Integer);
    procedure NovaLigacao;
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure CarDClasse;
    function RTelefoneClliente :string;
    procedure ExcluirClienteMailing;
    procedure FecharTabelas;
  public
    { Public declarations }
    procedure EfetuaTeleMarketingAtivo;
    function TeleMarketingCliente(VpaCodCliente : Integer):boolean;
  end;

var
  FNovoTeleMarketing: TFNovoTeleMarketing;

implementation

uses APrincipal, ANovoCliente, FunSql, FunData, FunObjeto, UnProspect,
  AHistoricoLigacao, ConstMsg, ANovaCotacao, ATeleMarketings,
  AProdutosCliente, ANovoContratoCliente, FunString, ANovoAgendamento,
  ANovoChamadoTecnico, AChamadosTecnicos, AContatosCliente, ANovaProposta,
  ANovoPedidoCompra, AAlteraEstagioProposta, AAlteraEstagioPedidoCompra,
  ANovaNotaFiscalNota, UnNotaFiscal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoTeleMarketing.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VerificaPermissaoUsuario;
  VprDCliente := TRBDCliente.cria;
  VprDTeleMarketing := TRBDTelemarketing.cria;
  VprINdAtivo := false;
  VprAcao := false;
  FunTeleMarketing := TRBFuncoesTeleMarketing.cria(FPrincipal.BaseDados);
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  FunProposta := TRBFuncoesProposta.cria(FPrincipal.BaseDados);
  Paginas.ActivePageIndex := 0;
  VprOrdemPedidoCompraCorpo:= ' ORDER BY PCC.DATPREVISTA DESC';
  VprOrdemPedidoCompraItem:= ' ORDER BY PCI.SEQITEM';
  VprOrdemProposta:= ' ORDER BY PRO.DATPROPOSTA DESC';
  VprOrdemItensProposta:= ' ';
  if ConfigModulos.Amostra then
    PProAmoPropostas.ActivePage := PAmostras
  else
    PProAmoPropostas.ActivePage := PItens;

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoTeleMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FecharTabelas;
  Ligacoes.close;
  VprDCliente.free;
  FunTeleMarketing.free;
  FunContrato.free;
  VprDTeleMarketing.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoTeleMarketing.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.SpeedButton2Click(Sender: TObject);
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
procedure TFNovoTeleMarketing.CarDClienteTela(VpaCodCliente : Integer);
begin
  VprDCliente.CodCliente := VpaCodCliente;
  FunClientes.CarDCliente(VprDCliente);

  with VprDCliente do
  begin
    ECodCliente.AInteiro := CodCliente;
    ENomCliente.Text := NomCliente;
    EContato.Text := NomContato;
    EFone1.Text := DesFone1;
    EFone2.Text := DesFone2;
    ELigarPeriodo.Text := DesLigarPeriodo;
    ELigarDiaSemana.Text := DesLigarDiaSemana;
    CAceitaTeleMarketing.Checked := IndAceitaTeleMarketing;
    EConcorrente.AInteiro:= CodConcorrente;
    if EConcorrente.AInteiro <> 0 then
      EConcorrente.Atualiza;
    if DatUltimoTeleMarketing > MontaData(1,1,1990) then
      EDatUltimaLigacacao.text := FormatDateTime('DD/MM/YYYY HH:MM',DatUltimoTeleMarketing)
    else
      EDatUltimaLigacacao.clear;
    EQtdLigacoesComVenda.AInteiro := QtdLigacoesComVenda;
    EQtdLigacoesSemVenda.AInteiro := QtdLigacoesSemVenda;
    EObsLigacaocliente.Lines.Text := DesObsTeleMarketing;
    if (config.UtilizarMailing) and (VprIndAtivo) then
      EDatAgendado.Text := FormatDateTime('DD/MM/YYYY HH:MM',Ligacoes.FieldByName('DATLIGACAO').AsDateTime)
    else
      EDatAgendado.Text := FormatDateTime('DD/MM/YYYY HH:MM',DatProximaLigacao);
    if ECampanhaVendas.AInteiro = 0 then
    begin
      ECampanhaVendas.AInteiro := SeqCampanha;
      ECampanhaVendas.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.ProximaLigacao;
begin
  Ligacoes.Next;
  if Ligacoes.Eof then
    aviso('TELEMARKETING FINALIZADO!!!'#13'Não existe mais clientes agendados para serem ligados.')
  else
  begin
    NovaLigacao;
    CarDClienteTela(Ligacoes.FieldByName('I_COD_CLI').AsInteger);
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosClientesTelemarketingAtivo;
begin
  if config.UtilizarMailing then
  begin
    AdicionaSQLAbreTabela(Ligacoes,'Select TAR.SEQTAREFA,TAR.CODUSUARIO,TAR.SEQCAMPANHA,TAR.DATLIGACAO, CLI.I_COD_CLI '+
                                   ' FROM CADCLIENTES CLI, TAREFATELEMARKETINGITEM TAR '+
                                   ' Where CLI.I_COD_CLI = TAR.CODCLIENTE '+
                                   ' AND TAR.CODUSUARIO = '+IntToStr(Varia.CodigoUsuario)+
//                                   ' and TAR.DATLIGACAO <' +SQLTextoDataAAAAMMMDD(INCDIA(Date,1))+
                                   ' order by TAR.DATLIGACAO, TAR.INDREAGENDADO DESC, CLI.C_NOM_CLI');
  end
  else
  begin
    Ligacoes.sql.Clear;
    Ligacoes.sql.Add('Select I_SEQ_CAM SEQCAMPANHA, I_COD_CLI from CADCLIENTES '+
                     ' Where D_PRO_LIG < '+SQLTextoDataAAAAMMMDD(INCDIA(Date,1))+
                     ' and C_ACE_TEL = ''S'''+
                     ' and (C_TIP_CAD = ''C'' or C_TIP_CAD = ''A'')');
    if Varia.CodRegiaoVenda <> 0 then
      Ligacoes.sql.add(' and I_COD_REG = '+IntToStr(varia.CodRegiaoVenda));
    Ligacoes.sql.add(' ORDER BY D_PRO_LIG');
    Ligacoes.open;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.ConfiguraTeleMarketingAtivo;
begin
  ECodCliente.ReadOnly := true;
  ENomCliente.ReadOnly := true;
  ECodCliente.TabStop := false;
  ENomCliente.TabStop := false;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosCompras(VpaCodCliente : Integer);
begin
  //Falta posicionar as cotacoes do cliente.
  CadOrcamentos.close;
  CadOrcamentos.Sql.Clear;
  CadOrcamentos.Sql.add('Select ORC.I_EMP_FIL, ORC.I_LAN_ORC, ORC.C_NRO_NOT, D_DAT_ORC, N_VLR_TOT,'+
                        ' VEN.C_NOM_VEN, USU.C_NOM_USU, TIP.C_NOM_TIP '+
                        ' FROM CADORCAMENTOS ORC, CADVENDEDORES VEN, CADUSUARIOS USU, CADTIPOORCAMENTO TIP '+
                        ' Where ORC.I_COD_VEN = VEN.I_COD_VEN '+
                        ' AND ORC.I_COD_USU = USU.I_COD_USU '+
                        ' AND ORC.I_TIP_ORC = TIP.I_COD_TIP '+
                        ' AND ORC.I_COD_CLI = '+IntToStr(VpaCodCliente));
  CadOrcamentos.sql.add('order by ORC.D_DAT_ORC desc');
  GOrcamentos.ALinhaSQLOrderBy := CadOrcamentos.sql.count -1 ;
  CadOrcamentos.open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosItemsCompras(VpaCodFilial,VpaLanOrcamento : Integer);
begin
   MovOrcamentos.close;
   MovOrcamentos.sql.clear;
   if CadOrcamentosI_EMP_FIL.AsInteger <> 0 then
   begin
     MovOrcamentos.sql.add('Select Mov.I_Emp_Fil, Mov.I_Lan_Orc,Mov.N_Qtd_Pro, Mov.N_Vlr_Pro, Mov.N_Vlr_Tot, Mov.C_Cod_Uni, '+
                           ' C_Imp_Fot, C_Fla_Res, Mov.N_Qtd_Bai,MOV.C_DES_COR, Pro.C_Nom_Pro, Pro.I_Seq_Pro, MOV.I_SEQ_MOV, MOV.C_NOM_PRO PRODUTOCOTACAO,');
     if UpperCase(Varia.CodigoProduto) = 'C_COD_PRO' Then
       MovOrcamentos.Sql.add('Pro.'+Varia.CodigoProduto + ' C_Cod_Pro')
     else
       MovOrcamentos.Sql.add('QTD.'+Varia.CodigoProduto + ' C_Cod_Pro');

     MovOrcamentos.sql.add(' from MovOrcamentos Mov, CadProdutos Pro, MovQdadeProduto QTD' +
                           ' Where mov.I_Emp_Fil = ' + CadOrcamentosI_EMP_FIL.AsString +
                           ' and Mov.I_Lan_Orc = ' + CadOrcamentosI_LAN_ORC.AsString  +
                           ' and Mov.I_Seq_Pro = Pro.I_Seq_Pro '+
                           ' and Mov.I_Seq_Pro = Qtd.I_Seq_Pro '+
                           ' and Mov.I_Emp_Fil = QTd.I_Emp_Fil '+
                           ' union ' +
                           ' Select Orc.I_Emp_Fil, Orc.I_Lan_Orc,Orc.N_Qtd_Ser, '+
                           ' Orc.N_Vlr_Ser,Orc.N_Vlr_Tot, ''SE''  Unis,  ''-'' Foto, '+
                           ' ''-'' Res, N_QTD_BAI,'' '' ,Ser.C_Nom_Ser, Ser.I_Cod_ser,ORC.I_COD_SER,SER.C_NOM_SER, Cast(Ser.I_Cod_Ser as VARChar2(20)) C_Cod_Pro '+
                           ' from movservicoorcamento orc, cadservico ser ' +
                           ' Where orc.I_Emp_Fil = ' + CadOrcamentosI_EMP_FIL.AsString +
                           ' and Orc.I_Lan_Orc = ' + CadOrcamentosI_LAN_ORC.AsString  +
                           ' and Orc.I_Cod_Ser = Ser.I_Cod_Ser ');
    MovOrcamentos.open;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosHistoricoLigacao(VpaCodCliente : Integer);
begin
  HistoricoLigacoes.close;
  HistoricoLigacoes.Sql.clear;
  HistoricoLigacoes.sql.add('select TEL.SEQTELE, TEL.DATLIGACAO,TEL.LANORCAMENTO, TEL.DESFALADOCOM, TEL.DESOBSERVACAO, '+
                   ' TEL.DATTEMPOLIGACAO, CODFILIAL, CODCLIENTE,'+
                   ' USU.C_NOM_USU, '+
                   ' HIS.DESHISTORICO '+
                   ' from TELEMARKETING TEL,  CADUSUARIOS USU, HISTORICOLIGACAO HIS '+
                   ' Where TEL.CODUSUARIO = USU.I_COD_USU '+
                   ' and TEL.CODHISTORICO = HIS.CODHISTORICO '+
                   ' and TEL.CODCLIENTE = '+IntToStr(VpaCodCliente));

  if Varia.OrdenacaoHistoricoTeleMarketing = ohData then
    HistoricoLigacoes.sql.add('order by TEL.DATLIGACAO DESC')
  else
    HistoricoLigacoes.sql.add('order by TEL.SEQTELE DESC');
  HistoricoLigacoes.open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosProdutos(VpaCodCliente : Integer);
begin
  PosProdutoComContrato(VpaCodCliente);
  PosProdutosSemContrato(VpaCodCliente);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosProdutoComContrato(VpaCodCliente : Integer);
begin
  ProdutosComContrato.close;
  ProdutosComContrato.Sql.Clear;
  ProdutosComContrato.Sql.add('Select CON.CODFILIAL, CON.SEQCONTRATO, CON.DATINICIOVIGENCIA, CON.DATFIMVIGENCIA,'+
                              ' CON.DATCANCELAMENTO, '+
                              ' TIP.NOMTIPOCONTRATO, '+
                              ' ITE.CODPRODUTO, ITE.NUMSERIE, ITE.NUMSERIEINTERNO, ITE.QTDULTIMALEITURA, ITE.DESSETOR, '+
                              ' ITE.DATDESATIVACAO,'+
                              ' PRO.C_NOM_PRO '+
                              ' from contratoitem ITE, contratocorpo CON, tipocontrato TIP, CADPRODUTOS PRO '+
                              ' Where CON.CODFILIAL = ITE.CODFILIAL '+
                              ' and CON.SEQCONTRATO = ITE.SEQCONTRATO '+
                              ' and CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                              ' and ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' and CON.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                              ' ORDER BY CON.DATCANCELAMENTO, CON.DATFIMVIGENCIA DESC');
  ProdutosComContrato.open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosProdutosSemContrato(VpaCodCliente : Integer);
begin
  ProdutosSemContrato.close;
  ProdutosSemContrato.SQL.Clear;
  ProdutosSemContrato.sql.add('select PCL.CODPRODUTO, PCL.DESSETOR, PCL.NUMSERIE, PCL.NUMSERIEINTERNO, '+
                              ' PCL.QTDPRODUTO, PCL.DESUM, PCL.DATGARANTIA, PCL.VALCONCORRENTE,PCL.QTDCOPIAS,'+
                              ' PRO.C_NOM_PRO, '+
                              ' DON.NOMDONO ' +
                              ' from PRODUTOCLIENTE PCL, CADPRODUTOS PRO, DONOPRODUTO DON ' +
                              ' WHERE PCL.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' AND '+SQLTextoRightJoin('PCL.CODDONO','DON.CODDONO') +
                              ' AND PCL.CODCLIENTE = '+IntToStr(VpaCodCliente));
  ProdutosSemContrato.Open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosInadimplencia(VpaCodCliente : Integer);
begin
  Inadimplentes.close;
  Inadimplentes.Sql.Clear;
  Inadimplentes.Sql.add('select MOV.D_DAT_VEN,CAD.D_DAT_EMI, MOV.N_VLR_PAR, CAD.I_LAN_REC,  '+
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
                   ' AND MOV.D_DAT_PAG IS NULL '+
                   ' AND CAD.I_COD_CLI = '+IntToStr(VpaCodCliente));
  Inadimplentes.Sql.add(' and MOV.D_DAT_VEN <= '+SQLTextoDataAAAAMMMDD(DATE));

  Inadimplentes.Sql.add(' ORDER BY MOV.D_DAT_VEN ');
  Inadimplentes.Open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosChamados(VpaCodCliente : Integer);
begin
  ChamadoTecnico.close;
  ChamadoTecnico.Sql.clear;
  ChamadoTecnico.Sql.add('select  CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.NOMSOLICITANTE, '+
                         ' CHA.VALCHAMADO, CHA.VALDESLOCAMENTO, CHA.CODESTAGIO, CHA.CODTECNICO, '+
                         ' CLI.C_NOM_CLI, '+
                         ' TEC.NOMTECNICO, '+
                         ' USU.C_NOM_USU, '+
                         ' EST.NOMEST '+
                         ' from CHAMADOCORPO CHA, CADCLIENTES CLI, TECNICO TEC, CADUSUARIOS USU, ESTAGIOPRODUCAO EST '+
                         ' Where CHA.CODCLIENTE = CLI.I_COD_CLI '+
                         ' AND CHA.CODTECNICO = TEC.CODTECNICO '+
                         ' AND CHA.CODUSUARIO = USU.I_COD_USU'+
                         ' AND CHA.CODESTAGIO = EST.CODEST '+
                         ' AND CHA.CODCLIENTE = '+IntToStr(VpaCodCliente));
  ChamadoTecnico.sql.add('order by CHA.DATCHAMADO DESC');
  GridIndice4.ALinhaSQLOrderBy := ChamadoTecnico.SQL.count - 1;
  ChamadoTecnico.open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosProdutosChamado;
begin
  ChamadoProduto.Close;
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
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
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosCliente(VpaCodCliente : Integer);
begin
  AdicionaSQLAbreTabela(CadClientes,'Select * from CADCLIENTES '+
                                    ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));
  AtualizaLocalizas(PanelColor6);
  PainelCGC.Visible := (CadClientes.FieldByname('C_TIP_PES').AsString = 'J');
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosContatos(VpaCodCliente: Integer);
begin
  CONTATOS.close;
  CONTATOS.SQL.Clear;
  CONTATOS.SQL.Add('SELECT'+
                   ' CCL.NOMCONTATO, CCL.DATNASCIMENTO, CCL.DESTELEFONE,'+
                   ' CCL.DESEMAIL, PRF.C_NOM_PRF, CCL.INDACEITAEMARKETING'+
                   ' FROM'+
                   ' CONTATOCLIENTE CCL, CADPROFISSOES PRF'+
                   ' WHERE'+SQLTextoRightJoin('CCL.CODPROFISSAO','PRF.I_COD_PRF')+
                   ' AND CCL.CODCLIENTE = '+IntToStr(VpaCodCliente));
  CONTATOS.SQL.Add(' ORDER BY CCL.NOMCONTATO');
  CONTATOS.Open;
  GContatos.ALinhaSQLOrderBy:= CONTATOS.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosPropostas(VpaCodCliente: Integer);
begin
  PROPOSTAS.close;
  PROPOSTAS.SQL.Clear;
  PROPOSTAS.SQL.Add('SELECT'+
                    ' PRO.CODFILIAL, PRO.SEQPROPOSTA, PRO.DATPROPOSTA, PRO.DATPREVISAOCOMPRA,'+
                    ' PRO.INDCOMPROU, PRO.INDCOMPROUCONCORRENTE, PRO.VALTOTAL,'+
                    ' CON.C_NOM_PAG, EST.NOMEST'+
                    ' FROM PROPOSTA PRO, CADCONDICOESPAGTO CON, ESTAGIOPRODUCAO EST'+
                    ' WHERE'+
                    ' PRO.CODCONDICAOPAGAMENTO = CON.I_COD_PAG'+
                    ' AND PRO.CODESTAGIO = EST.CODEST'+
                    ' AND PRO.CODCLIENTE = '+IntToStr(VpaCodCliente));
  PROPOSTAS.SQL.Add(VprOrdemProposta);
  GPropostas.ALinhaSQLOrderBy:= PROPOSTAS.SQL.Count-1;
  PROPOSTAS.Open;
  PosItensProposta(PROPOSTASCODFILIAL.AsInteger,PROPOSTASSEQPROPOSTA.AsInteger);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosItensProposta(VpaCodFilial,VpaSeqProposta: Integer);
begin
  MovITENSPROPOSTA.close;
  MovITENSPROPOSTA.SQL.Clear;
  MovITENSPROPOSTA.SQL.Add('SELECT'+
                           ' PPR.NOMPRODUTO, PPR.NOMCOR, PPR.DESUM,'+
                           ' PPR.QTDPRODUTO, PPR.VALUNITARIO, PPR.VALTOTAL, '+
                           ' PPR.NUMOPCAO '+
                           ' FROM PROPOSTAPRODUTO PPR'+
                           ' WHERE PPR.SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                           ' and PPR.CODFILIAL = ' +IntToStr(VpaCodFilial));
  MovITENSPROPOSTA.SQL.Add(VprOrdemItensProposta);
  GProdutosProposta.ALinhaSQLOrderBy:= MovITENSPROPOSTA.SQL.Count-1;
  MovITENSPROPOSTA.Open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosAmostrasProposta(VpaSeqProposta: Integer);
begin
  MovAMOSTRAPROPOSTA.close;
  MovAMOSTRAPROPOSTA.SQL.Clear;
  MovAMOSTRAPROPOSTA.SQL.Add('SELECT'+
                             ' APR.NOMAMOSTRA, APR.NOMCOR, APR.QTDAMOSTRA,'+
                             ' APR.VALUNITARIO, APR.VALTOTAL, '+
                             ' AMO.DESIMAGEM '+
                             ' FROM PROPOSTAAMOSTRA APR, AMOSTRA AMO'+
                             ' WHERE APR.SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                             ' AND APR.CODAMOSTRA = AMO.CODAMOSTRA');
  GAmostraProposta.ALinhaSQLOrderBy:= MovAMOSTRAPROPOSTA.SQL.Count-1;
  MovAMOSTRAPROPOSTA.Open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosNotas(VpaCodCliente : Integer);
begin
  Notas.Close;
  Notas.Sql.Clear;
  Notas.Sql.Add(' select NF.I_EMP_FIL,' +
    ' NF.I_NRO_NOT, CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_TIP_CAD, NF.C_FLA_ECF, NF.c_not_can, ' +
    ' NF.L_OBS_NOT, NF.N_TOT_PRO, NF.N_TOT_NOT, NF.I_NRO_LOJ, NF.I_NRO_CAI, CLI.D_DAT_CAD, ' +
    ' CLI.D_DAT_ALT, CLI.C_END_CLI, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_EST_CLI, CLI.C_CPF_CLI, ' +
    ' CLI.C_CGC_CLI, CLI.C_FON_FAX, NF.D_DAT_SAI, NF.T_HOR_SAI, NF.I_QTD_VOL, NF.N_VLR_ICM, ' +
    ' NF.N_BAS_SUB, NF.N_VLR_SUB, NF.N_VLR_FRE, NF.N_VLR_SEG, NF.N_OUT_DES, NF.N_TOT_IPI, ' +
    ' NF.N_PES_BRU, NF.N_PES_LIQ, NF.N_TOT_SER, NF.N_VLR_ISQ, NF.I_SEQ_NOT, NF.C_COD_NAT, '+
    ' NF.C_NOT_IMP, NF.I_ITE_NAT, NF.C_SER_NOT, NF.D_DAT_EMI , ' +
    ' USU.C_NOM_USU '+
    ' from CADNOTAFISCAIS NF, CADCLIENTES CLI, CADUSUARIOS USU ');
  Notas.Sql.Add( ' Where NF.I_COD_CLI = '+IntToStr(VpaCodCliente)+
                 ' and '+SQLTextoRightJoin('NF.I_COD_CLI','CLI.I_COD_CLI') +
                 ' and NF.I_COD_USU = USU.I_COD_USU '+
                 ' and NF.I_NRO_NOT is not null ' );
  Notas.Sql.add('order by NF.D_DAT_EMI desc');
  Notas.Open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosNotasItens(VpaCodFilial, VpaSeqNota : Integer);
begin
  if VpaCodFilial <> 0 then
  begin
    AdicionaSQLAbreTabela(MovNotas,'Select MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, '+
                                 '  MOV.N_TOT_PRO, MOV.C_COD_PRO, MOV.C_NOM_PRO PRODUTONOTA, '+
                                 ' PRO.C_NOM_PRO '+
                                 ' FROM MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                                 ' WHERE MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                 ' AND MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                                 ' AND MOV.I_SEQ_NOT = '+IntToStr(VpaSeqNota)+
                                 ' order by MOV.I_SEQ_MOV ');  

  end
  else
    MovNotas.close;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.NovaLigacao;
begin
  EHistorico.Clear;
  ECampanhaVendas.Clear;
  ENomContato.Clear;
  EObservacoes.Clear;
  EProximaLigacao.DateTime := date;
  EProximaObservacao.Clear;
  ECampanhaVendas.AInteiro := varia.SeqCampanhaTelemarketing;
  if varia.CodCampanhaVendas <> 0 then
    ECampanhaVendas.AInteiro := varia.CodCampanhaVendas;

  ECampanhaVendas.Atualiza;
  CData.Checked := false;
  CDataClick(CData);
  Paginas.ActivePageIndex := 0;
  ActiveControl := EHistorico;
  EstadoBotoes(true);
  ValidaGravacao1.Execute;
  VprOperacao := ocInsercao;
  VprDTeleMarketing.free;
  VprDTeleMarketing := TRBDTelemarketing.cria;
  VprDTeleMarketing.DatLigacao := now;
  VprDTeleMarketing.QtdSegundosLigacao := 0;
  Tempo.Enabled := true;
  if (VprIndAtivo) then
    if Ligacoes.FieldByName('SEQCAMPANHA').AsInteger <> 0 then
    begin
      ECampanhaVendas.AInteiro := Ligacoes.FieldByName('SEQCAMPANHA').AsInteger;
      ECampanhaVendas.Atualiza;
    end;

end;

{******************************************************************************}
procedure TFNovoTeleMarketing.EstadoBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BCotacao.Enabled := VpaEstado;
  BProximo.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.CarDClasse;
begin
  with VprDTeleMarketing do
  begin
    CodFilial := varia.CodigoEmpFil;
    CodCliente := Ligacoes.FieldByName('I_COD_CLI').AsInteger;
    SeqTele := 0;
    CodUsuario := Varia.CodigoUsuario;
    CodHistorico := EHistorico.AInteiro;
    CodVendedor := EVendedorHistorico.AInteiro;
    SeqCampanha := ECampanhaVendas.AInteiro;
    DesFaladoCom := ENomContato.Text;
    DesObservacao := EObservacoes.Lines.text;
    DatProximaLigacao := MontaData(dia(EProximaLigacao.Date),mes(EProximaLigacao.Date),ano(EProximaLigacao.Date));
    if DeletaChars(DeletaChars(DeletaChars(EHoraProximaLigacao.Text,'_'),':'),' ') <> ''then
      DatProximaLigacao := DatProximaLigacao + StrToTime(EHoraProximaLigacao.text);
    DesObsProximaLigacao := EProximaObservacao.Text;
    CodUsuario := varia.CodigoUsuario;
    DatTempoLigacao := now - DatLigacao;
    IndProximaLigacao :=  CData.Checked;
    Tempo.Enabled := false;
  end;
end;

{******************************************************************************}
function TFNovoTeleMarketing.RTelefoneClliente :string;
begin
  result := DeleteAteChar(EFone1.Text,')');
  result := DeletaChars(result,'-');
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.ExcluirClienteMailing;
begin
  if VprIndAtivo then
  Begin
    if Ligacoes.FieldByName('SEQTAREFA').AsInteger <> 0 then
    begin
      if CData.Checked then
        ExecutaComandoSql(Aux,'UPDATE TAREFATELEMARKETINGITEM'+
                          ' Set DATLIGACAO = '+SQLTextoDataAAAAMMMDD(EProximaLigacao.DateTime)+
                          ' , INDREAGENDADO = ''S'''+
                          ' Where SEQTAREFA = '+Ligacoes.FieldByName('SEQTAREFA').AsString+
                          ' and CODUSUARIO = '+Inttostr(varia.CodigoUsuario)+
                          ' and CODCLIENTE = '+Ligacoes.FieldByName('I_COD_CLI').AsString)
      else
        ExecutaComandoSql(Aux,'DELETE FROM TAREFATELEMARKETINGITEM'+
                          ' Where CODUSUARIO = '+Inttostr(varia.CodigoUsuario)+
                          ' and CODCLIENTE = '+Ligacoes.FieldByName('I_COD_CLI').AsString);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.FecharTabelas;
begin
  CadOrcamentos.close;
  MovOrcamentos.close;
  CadClientes.close;
  HistoricoLigacoes.close;
  ProdutosSemContrato.close;
  ProdutosComContrato.close;
  Aux.close;
  Inadimplentes.close;
  ChamadoTecnico.close;
  ChamadoProduto.close;
  Propostas.close;
  MovAMOSTRAPROPOSTA.close;
  MovITENSPROPOSTA.close;
  PEDIDOCOMPRACORPO.close;
  PRODUTOPEDIDO.close;
  CONTATOS.close;
  NOTAS.Close;
  MovNotas.close;
end;

{******************************************************************************}
function TFNovoTeleMarketing.TeleMarketingCliente(VpaCodCliente : Integer):boolean;
begin
  AdicionaSQLAbreTabela(Ligacoes,'Select * from CADCLIENTES WHERE I_COD_CLI = '+IntToStr(VpaCodCliente));
  CarDClienteTela(VpaCodCliente);
  NovaLigacao;

  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.EfetuaTeleMarketingAtivo;
begin
  VprIndAtivo := true;
  ConfiguraTeleMarketingAtivo;
  PosClientesTelemarketingAtivo;
  NovaLigacao;
  CarDClienteTela(Ligacoes.FieldByName('I_COD_CLI').AsInteger);
  if Ligacoes.Eof then
    aviso('TELEMARKETING FINALIZADO!!!'#13'Não existe mais clientes agendados para serem ligados.');
  showmodal;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.BGravarClick(Sender: TObject);
var
  VpfREsultado : String;
begin
  VprAcao := true;
  CarDClasse;
  VpfResultado := FunTeleMarketing.GravaDTeleMarketing(VprDTeleMarketing);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    EstadoBotoes(false);
    VprOperacao := ocConsulta;
    if config.UtilizarMailing then
      ExcluirClienteMailing;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.EHistoricoCadastrar(Sender: TObject);
begin
  FHistoricoLigacao := TFHistoricoLigacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHistoricoLigacao'));
  FHistoricoLigacao.BotaoCadastrar1.Click;
  FHistoricoLigacao.ShowModal;
  FHistoricoLigacao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.EHistoricoChange(Sender: TObject);
begin
  if VprOperacao in [ocinsercao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.EHistoricoRetorno(Retorno1,
  Retorno2: String);
begin
  VprDTeleMarketing.IndAtendeu := Retorno1 = 'S';
  if not VprDTeleMarketing.IndAtendeu then
    AlteraCampoObrigatorioDet([ENomContato],false)
  else
    AlteraCampoObrigatorioDet([ENomContato],true);
  if VprOperacao in [ocinsercao] then
    ValidaGravacao1.execute;
end;

procedure TFNovoTeleMarketing.BCancelarClick(Sender: TObject);
begin
  if Confirmacao('Tem certeza que deseja cancelar a ligação em processo?') then
  begin
    if (Varia.CodigoUsuario = 1006) and (varia.CNPJFilial = CNPJ_MKJ) then
      if not Confirmacao('Cumpadi Júlio se você pressionar o botão cancelar ali em baixo você irá perder essa ligação, tem certeza que é isso que voce quer?') then
        exit;
    Tempo.Enabled := false;
    LimpaComponentes(PanelColor1,0);
    EstadoBotoes(false);
    VprOperacao := ocConsulta;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.BProximoClick(Sender: TObject);
begin
  ProximaLigacao;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.CadOrcamentosAfterScroll(DataSet: TDataSet);
begin
  PosItemsCompras(CadOrcamentosI_EMP_FIL.AsInteger,CadOrcamentosI_LAN_ORC.AsInteger);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.VerCotao1Click(Sender: TObject);
begin
  if CadOrcamentosI_EMP_FIL.AsInteger <> 0 then
  begin
    FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
    FNovaCotacao.ConsultaCotacao(CadOrcamentosI_EMP_FIL.AsString,CadOrcamentosI_LAN_ORC.AsString);
    FNovaCotacao.free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.VerificaPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([MExcluirHistorico],false);
    if (puExcluirHistoricoTelemarketing in Varia.PermissoesUsuario) then
      AlterarVisibleDet([MExcluirHistorico],true);


  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.BCotacaoClick(Sender: TObject);
begin
  FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
  VprDTeleMarketing.LanOrcamento := FNovaCotacao.NovaCotacaoCliente(VprDCliente.CodCliente) ;
  if VprDTeleMarketing.LanOrcamento <> 0 then
  begin
    VprDTeleMarketing.QtdDiasProximaLigacao := FunTeleMarketing.RQtdDiasProximaLigacao(VprDCliente.CodCliente);
    EProximaLigacao.DateTime :=  IncDia(date,VprDTeleMarketing.QtdDiasProximaLigacao);
  end;
  FNovaCotacao.free;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PaginasChange(Sender: TObject);
begin
  FecharTabelas;
  if Paginas.ActivePage = PPedidosCompra then
    PosPedidosCompra(ECodCliente.Ainteiro)
  else
    if Paginas.ActivePage = PCompras then
      PosCompras(ECodCliente.Ainteiro)
    else
      if Paginas.ActivePage = PHistoricos then
        PosHistoricoLigacao(ECodCliente.Ainteiro)
      else
        if Paginas.ActivePage = PProdutos then
          PosProdutos(ECodCliente.AInteiro)
        else
          if Paginas.ActivePage = PClientes then
            PosCliente(ECodCliente.AInteiro)
          else
            if Paginas.ActivePage = PInadimplentes then
              PosInadimplencia(ECodCliente.AInteiro)
            else
              if Paginas.ActivePage = PChamados then
                PosChamados(ECodCliente.AInteiro)
              else
                if Paginas.ActivePage = PContatos then
                  PosContatos(ECodCliente.AInteiro)
                else
                  if Paginas.ActivePage = PPropostas then
                    PosPropostas(ECodCliente.AInteiro)
                  else
                    if Paginas.ActivePage = PNotas then
                      PosNotas(ECodCliente.AInteiro);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.BCadastrarProdutoClienteClick(
  Sender: TObject);
begin
  FProdutosCliente := TFProdutosCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProdutosCliente'));
  if FProdutosCliente.CadastraProdutos(ECodCliente.AInteiro) then
    PosProdutosSemContrato(ECodCliente.Ainteiro);
  FProdutosCliente.free;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.BVisualizaContratoClick(Sender: TObject);
var
  VpfDContrato : TRBDContratoCorpo;
begin
  if ProdutosComContratoSEQCONTRATO.AsInteger <> 0 then
  begin
    VpfDContrato := TRBDContratoCorpo.cria;
    FunContrato.CarDContrato(VpfDContrato,ProdutosComContratoCODFILIAL.AsInteger,ProdutosComContratoSEQCONTRATO.AsInteger);
    FNovoContratoCliente := TFNovoContratoCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoContratoCliente'));
    FNovoContratoCliente.ConsultaContrato(VpfDContrato);
    FNovoContratoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.TempoTimer(Sender: TObject);
begin
  inc(VprDTeleMarketing.QtdSegundosLigacao);
  ETempoLigacao.Text := FormatDateTime('HH:MM:SS',now - VprDTeleMarketing.DatLigacao);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.CDataClick(Sender: TObject);
begin
  EProximaLigacao.Enabled := CData.Checked;
end;

procedure TFNovoTeleMarketing.BDiscararClick(Sender: TObject);
begin
end;


{******************************************************************************}
procedure TFNovoTeleMarketing.BAgendarClick(Sender: TObject);
begin
  FNovoAgedamento := TFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
  FNovoAgedamento.AgendaPeloTelemarketing(ECodCliente.AInteiro,varia.CodigoUsuario);
  FNovoAgedamento.free;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.GridIndice1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if not ProdutosComContratoDATDESATIVACAO.IsNull then
  begin
    GridIndice1.Canvas.brush.Color:= clYellow; // coloque aqui a cor desejada
    GridIndice1.Canvas.Font.Color:= clWhite;
    GridIndice1.DefaultDrawDataCell(Rect, GridIndice1.columns[datacol].field, State);
  end;
  if not ProdutosComContratoDATCANCELAMENTO.IsNull then
  begin
    GridIndice1.Canvas.brush.Color:= clRed; // coloque aqui a cor desejada
    GridIndice1.Canvas.Font.Color:= clWhite;
    GridIndice1.DefaultDrawDataCell(Rect, GridIndice1.columns[datacol].field, State);
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.ChamadoTecnicoAfterScroll(DataSet: TDataSet);
begin
  PosProdutosChamado;
end;

procedure TFNovoTeleMarketing.GridIndice4DblClick(Sender: TObject);
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
    FNovoChamado.ConsultaChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
    FNovoChamado.free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.BitBtn1Click(Sender: TObject);
begin
  FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('TFNovoChamado'));
  FNovoChamado.NovoChamadoCliente(ECodCliente.AInteiro);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.BContatosClick(Sender: TObject);
begin
  if VprDCliente.CodCliente <> 0 then
  begin
    FContatosCliente:= TFContatosCliente.CriarSDI(Application,'',True);
    FContatosCliente.CadastraContatos(VprDCliente.CodCliente);
    FContatosCliente.Free;
    PosContatos(VprDCliente.CodCliente);    
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.GPedidoCorpoOrdem(Ordem: String);
begin
  VprOrdemPedidoCompraCorpo:= Ordem;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PosPedidosCompra(VpaCodCliente: Integer);
begin
  PEDIDOCOMPRACORPO.Close;
  PEDIDOCOMPRACORPO.SQL.Clear;
  PEDIDOCOMPRACORPO.SQL.Add('SELECT'+
                            ' PCC.SEQPEDIDO, PCC.DATPEDIDO, PCC.DATPREVISTA, PCC.DATENTREGA,'+
                            ' PCC.DATRENEGOCIADO, '+
                            ' CLI.C_NOM_CLI, PCC.VALTOTAL, CPA.C_NOM_PAG,'+
                            ' PCC.CODFILIAL, PCC.DATAPROVACAO,'+
                            ' EST.NOMEST, PCC.CODESTAGIO, PCC.DATPAGAMENTOANTECIPADO,'+
                            ' USUAPR.C_NOM_USU USUAPROVACAO,'+
                            ' USU.C_NOM_USU, COM.NOMCOMPRADOR'+
                            ' FROM'+
                            ' PEDIDOCOMPRACORPO PCC, CADCLIENTES CLI, CADCONDICOESPAGTO CPA,'+
                            ' CADUSUARIOS USUAPR, ESTAGIOPRODUCAO EST, CADUSUARIOS USU,'+
                            ' COMPRADOR COM'+
                            ' WHERE'+
                            ' PCC.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                            ' AND '+SQLTextoRightJoin('PCC.CODCLIENTE','CLI.I_COD_CLI')+
                            ' AND '+SQLTextoRightJoin('PCC.CODCONDICAOPAGAMENTO','CPA.I_COD_PAG')+
                            ' AND '+SQLTextoRightJoin('PCC.CODUSUARIOAPROVACAO','USUAPR.I_COD_USU')+
                            ' AND USU.I_COD_USU = PCC.CODUSUARIO'+
                            ' AND '+SQLTextoRightJoin('PCC.CODESTAGIO','EST.CODEST')+
                            ' AND '+SQLTextoRightJoin('PCC.CODCOMPRADOR','COM.CODCOMPRADOR'));
  PEDIDOCOMPRACORPO.SQL.Add(VprOrdemPedidoCompraCorpo);
  GPedidoCorpo.ALinhaSQLOrderBy:= PEDIDOCOMPRACORPO.SQL.Count-1;
  PEDIDOCOMPRACORPO.Open;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PEDIDOCOMPRACORPOAfterScroll(
  DataSet: TDataSet);
begin
  PRODUTOPEDIDO.Close;
  if not PEDIDOCOMPRACORPOSEQPEDIDO.IsNull then
  begin
    PRODUTOPEDIDO.SQL.Clear;
    PRODUTOPEDIDO.SQL.Add('SELECT'+
                          ' PRO.C_NOM_PRO, COR.NOM_COR, PCI.DESREFERENCIAFORNECEDOR,'+
                          ' PCI.QTDPRODUTO, PCI.DESUM, PCI.VALUNITARIO, PCI.VALTOTAL, PCI.QTDSOLICITADA, '+
                          ' PCI.QTDBAIXADO '+
                          ' FROM PEDIDOCOMPRAITEM PCI, CADPRODUTOS PRO, COR COR'+
                          ' WHERE'+
                          ' PRO.I_SEQ_PRO = PCI.SEQPRODUTO'+
                          ' AND '+SQLTextoRightJoin('PCI.CODCOR','COR.COD_COR')+
                          ' AND PCI.CODFILIAL = '+PEDIDOCOMPRACORPOCODFILIAL.AsString+
                          ' AND PCI.SEQPEDIDO = '+PEDIDOCOMPRACORPOSEQPEDIDO.AsString);
    PRODUTOPEDIDO.SQL.Add(VprOrdemPedidoCompraItem);
    GPedidoProduto.ALinhaSQLOrderBy:= PRODUTOPEDIDO.SQL.Count-1;
    PRODUTOPEDIDO.Open;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.VerPedido1Click(Sender: TObject);
begin
  if PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger <> 0 then
  begin
    FNovoPedidoCompra:= TFNovoPedidoCompra.CriarSDI(Application,'',True);
    FNovoPedidoCompra.Consultar(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,
                                PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
    FNovoPedidoCompra.Free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.Alterar1Click(Sender: TObject);
begin
  if PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger <> 0 then
  begin
    FNovoPedidoCompra:= TFNovoPedidoCompra.CriarSDI(Application,'',True);
    if FNovoPedidoCompra.Alterar(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,
                                PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger) then
      PosPedidosCompra(ECodCliente.Ainteiro);
    FNovoPedidoCompra.Free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PEDIDOCOMPRACORPOCalcFields(
  DataSet: TDataSet);
begin
  if PEDIDOCOMPRACORPODATPREVISTA.AsDateTime <> PEDIDOCOMPRACORPODATRENEGOCIADO.AsDateTime then
    PEDIDOCOMPRACORPORenegociado.AsDateTime := PEDIDOCOMPRACORPODATRENEGOCIADO.AsDateTime
  else
    PEDIDOCOMPRACORPORenegociado.Clear;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.PROPOSTASAfterScroll(DataSet: TDataSet);
begin
  if PProAmoPropostas.ActivePage = PItens then
    PosItensProposta(PROPOSTASCODFILIAL.AsInteger,PROPOSTASSEQPROPOSTA.AsInteger)
  else
    PosAmostrasProposta(PROPOSTASSEQPROPOSTA.AsInteger);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.MovAMOSTRAPROPOSTAAfterScroll(DataSet: TDataSet);
begin
  if MovAMOSTRAPROPOSTADESIMAGEM.AsString <> '' then
    Foto.Picture.LoadFromFile(varia.DriveFoto + MovAMOSTRAPROPOSTADESIMAGEM.AsString)
  else
    Foto.Picture:= nil;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.NovaProposta1Click(Sender: TObject);
begin
  FNovaProposta:= TFNovaProposta.CriarSDI(Application,'',True);
  FNovaProposta.NovaPropostaCliente(ECodCliente.AInteiro);
  FNovaProposta.Free;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.Consultar1Click(Sender: TObject);
begin
  if PropostasSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta:= TFNovaProposta.CriarSDI(Application,'',True);
    FNovaProposta.ConsultaProposta(PropostasCODFILIAL.AsInteger,PropostasSEQPROPOSTA.AsInteger);
    FNovaProposta.Free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.MenuItem2Click(Sender: TObject);
begin
  if PropostasSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta:= TFNovaProposta.CriarSDI(Application,'',True);
    FNovaProposta.AlteraProposta(PropostasCODFILIAL.AsInteger,PropostasSEQPROPOSTA.AsInteger);
    FNovaProposta.Free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.MExcluirHistoricoClick(Sender: TObject);
begin
  if Confirmacao(CT_DeletarItem) then
  begin
    FunTeleMarketing.ExcluiTelemarketing(HistoricoLigacoesCODFILIAL.AsInteger,HistoricoLigacoesCODCLIENTE.AsInteger,HistoricoLigacoesSEQTELE.AsInteger);
    PosHistoricoLigacao(ECodCliente.AInteiro);
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.AlterarEstgio1Click(Sender: TObject);
var
  VpfDProposta : TRBDPropostaCorpo;
begin
  if PROPOSTASSEQPROPOSTA.AsInteger <> 0 then
  begin
    VpfDProposta := TRBDPropostaCorpo.cria;
    FunProposta.CarDProposta(VpfDProposta,PROPOSTASCODFILIAL.AsInteger,PROPOSTASSEQPROPOSTA.AsInteger);
    FAlteraEstagioProposta:= TFAlteraEstagioProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioProposta'));
    if FAlteraEstagioProposta.AlteraEstagioPropostaCliente(VpfDProposta) then
      PosPropostas(ECodCliente.AInteiro);
    FAlteraEstagioProposta.free;
    VpfDProposta.Free;
  end;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.GProdutosPropostaOrdem(Ordem: String);
begin
  VprOrdemItensProposta:= Ordem;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.GPropostasOrdem(Ordem: String);
begin
  VprOrdemProposta:= Ordem;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.AlterarEstgio2Click(Sender: TObject);
begin
  FAlteraEstagioPedidoCompra := TFAlteraEstagioPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioPedidoCompra'));
  if FAlteraEstagioPedidoCompra.AlteraEstagioPedido(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger) then
    PosPedidosCompra(ECodCliente.Ainteiro);
  FAlteraEstagioPedidoCompra.free;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.ConcluirPedidoCompra1Click(Sender: TObject);
var
  VpfResultado: String;
  VpfFunPedidoCompra: TRBFunPedidoCompra;
begin
  if PEDIDOCOMPRACORPODATENTREGA.IsNull then
  begin
    if Confirmacao('Tem certeza que deseja concluir o pedido?') then
    begin
      VpfFunPedidoCompra := TRBFunPedidoCompra.cria(FPrincipal.BaseDados);
      VpfResultado:= VpfFunPedidoCompra.ConcluiPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
      if VpfResultado = '' then
      begin
        Informacao('Pedido concluído com sucesso.');
        PosPedidosCompra(ECodCliente.Ainteiro);
      end
      else
        aviso(VpfResultado);
      VpfFunPedidoCompra.free;
    end;
  end
  else
    Informacao('Pedido já concluído.');
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.ConsultarNotasFiscais1Click(Sender: TObject);
var
  VpfFunPedidoCompra: TRBFunPedidoCompra;
begin
  VpfFunPedidoCompra := TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  VpfFunPedidoCompra.ConsultaNotasFiscais(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
  VpfFunPedidoCompra.free;
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.MovNotasCalcFields(DataSet: TDataSet);
begin
  if MovNotasPRODUTONOTA.AsString = '' then
    MovNotasPRODUTO.AsString := MovNotasC_NOM_PRO.AsString
  else
    MovNotasPRODUTO.AsString := MovNotasPRODUTONOTA.AsString
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.NOTASAfterScroll(DataSet: TDataSet);
begin
  PosNotasItens(NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger);
end;

{******************************************************************************}
procedure TFNovoTeleMarketing.VerNota1Click(Sender: TObject);
var
  VpfDNota : TRBDNotaFiscal;
begin
  if NOTASI_EMP_FIL.AsInteger <> 0 then
  begin
    VpfDNota := TRBDNotaFiscal.cria;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota,NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger);
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
    FNovaNotaFiscalNota.ConsultaNota(VpfDNota);
    FNovaNotaFiscalNota.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoTeleMarketing]);
end.



