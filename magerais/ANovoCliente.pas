unit ANovoCliente;
{          Autor: Rafael Budag
    Data Criação: 25/03/1999;
          Função: Cadastrar um NOVO CLIENTE.
  Data Alteração: 14/12/1999;
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Tabela, Constantes,ConstMsg,
  StdCtrls, DBCtrls, Mask, Db, DBTables, DBCidade, BotaoCadastro, Buttons,
  Localizacao, ComCtrls, Grids, DBGrids, DBKeyViolation, UnDados, UnProspect,
  CGrades, UnProdutos, UnDadosLOcaliza, DBClient, FMTBcd, SqlExpr, UnVersoes, UnEmarketing;

type
  TFNovoCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DataCadClientes: TDataSource;
    MoveBasico1: TMoveBasico;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    CadClientes: TSQL;
    CadClientesI_COD_CLI: TFMTBCDField;
    CadClientesC_NOM_CLI: TWideStringField;
    CadClientesD_DAT_ALT: TSQLTimeStampField;
    CadClientesC_END_CLI: TWideStringField;
    CadClientesC_BAI_CLI: TWideStringField;
    CadClientesC_FON_RES: TWideStringField;
    CadClientesC_EST_CLI: TWideStringField;
    CadClientesC_END_ANT: TWideStringField;
    CadClientesC_CID_ANT: TWideStringField;
    CadClientesC_EST_ANT: TWideStringField;
    CadClientesD_DAT_NAS: TSQLTimeStampField;
    CadClientesC_REG_CLI: TWideStringField;
    CadClientesC_CPF_CLI: TWideStringField;
    CadClientesC_NAT_CLI: TWideStringField;
    CadClientesC_EST_NAT: TWideStringField;
    CadClientesC_NOM_EMP: TWideStringField;
    CadClientesC_END_EMP: TWideStringField;
    CadClientesC_BAI_EMP: TWideStringField;
    CadClientesC_FON_EMP: TWideStringField;
    CadClientesC_EST_EMP: TWideStringField;
    CadClientesC_CID_EMP: TWideStringField;
    CadClientesD_ADM_CLI: TSQLTimeStampField;
    CadClientesN_LIM_CLI: TFMTBCDField;
    CadClientesN_REN_CLI: TFMTBCDField;
    CadClientesC_PAI_CLI: TWideStringField;
    CadClientesC_MAE_CLI: TWideStringField;
    CadClientesC_NOM_CON: TWideStringField;
    CadClientesC_EMP_CON: TWideStringField;
    CadClientesC_FON_CON: TWideStringField;
    CadClientesD_DAT_CON: TSQLTimeStampField;
    CadClientesC_REF_PES: TWideStringField;
    CadClientesC_OBS_CLI: TWideStringField;
    CadClientesC_EST_CIV: TWideStringField;
    CadClientesC_SEX_CLI: TWideStringField;
    CadClientesC_TIP_END: TWideStringField;
    CadClientesC_TIP_RES: TWideStringField;
    CadClientesI_PRO_CON: TFMTBCDField;
    CadClientesC_END_ELE: TWideStringField;
    CadClientesI_NUM_END: TFMTBCDField;
    CadClientesI_NUM_ANT: TFMTBCDField;
    CadClientesI_NUM_EMP: TFMTBCDField;
    CadClientesI_COD_PRF: TFMTBCDField;
    CadClientesC_CGC_CLI: TWideStringField;
    CadClientesC_INS_CLI: TWideStringField;
    CadClientesC_WWW_CLI: TWideStringField;
    CadClientesC_TIP_PES: TWideStringField;
    CadClientesC_FO1_CLI: TWideStringField;
    CadClientesC_FO2_CLI: TWideStringField;
    CadClientesC_FO3_CLI: TWideStringField;
    CadClientesC_TIP_CAD: TWideStringField;
    CadClientesC_ORG_EXP: TWideStringField;
    CadClientesC_CON_CLI: TWideStringField;
    CadClientesC_FON_CEL: TWideStringField;
    CadClientesC_FON_FAX: TWideStringField;
    CadClientesC_NOM_REP: TWideStringField;
    CadClientesC_CON_REP: TWideStringField;
    CadClientesC_FAX_REP: TWideStringField;
    CadClientesC_FON_REP: TWideStringField;
    CadClientesC_COM_END: TWideStringField;
    CadClientesI_COD_SIT: TFMTBCDField;
    CadClientesCOD_CIDADE: TFMTBCDField;
    CadClientesC_CEP_CLI: TWideStringField;
    CadClientesC_CEP_EMP: TWideStringField;
    CadClientesC_CEP_ANT: TWideStringField;
    CadClientesC_PRA_CLI: TWideStringField;
    CadClientesC_ELE_REP: TWideStringField;
    CadClientesI_COD_REG: TFMTBCDField;
    CadClientesI_COD_VEN: TFMTBCDField;
    CadClientesI_COD_PAG: TFMTBCDField;
    CadClientesI_FRM_PAG: TFMTBCDField;
    CadClientesI_PER_COM: TFMTBCDField;
    CadClientesI_COD_RAM: TFMTBCDField;
    CadClientesN_COD_EAN: TFMTBCDField;
    CadClientesN_PER_DES: TFMTBCDField;
    CadClientesC_ACE_SPA: TWideStringField;
    CadClientesC_BAI_ANT: TWideStringField;
    CadClientesC_FON_ENT: TWideStringField;
    CadClientesC_RES_ENT: TWideStringField;
    CadClientesC_RES_INS: TWideStringField;
    CadClientesC_IND_REV: TWideStringField;
    CadClientesI_COD_TRA: TFMTBCDField;
    CadClientesI_COD_TEC: TFMTBCDField;
    CadClientesC_TIP_FAT: TWideStringField;
    CadClientesC_DES_ISS: TWideStringField;
    CadClientesC_CON_FIN: TWideStringField;
    CadClientesC_FON_FIN: TWideStringField;
    CadClientesC_ACE_TEL: TWideStringField;
    CadClientesI_PER_TEL: TFMTBCDField;
    CadClientesC_OBS_TEL: TWideStringField;
    CadClientesI_DIA_TEL: TFMTBCDField;
    CadClientesD_PRO_LIG: TSQLTimeStampField;
    CadClientesI_DIA_PLI: TFMTBCDField;
    CadClientesC_IND_CRA: TWideStringField;
    CadClientesI_QTD_COP: TFMTBCDField;
    CadClientesI_VEN_PRE: TFMTBCDField;
    CadClientesI_QTD_IMA: TFMTBCDField;
    CadClientesI_QTD_ILA: TFMTBCDField;
    CadClientesI_QTD_IJT: TFMTBCDField;
    CadClientesI_QTD_FUN: TFMTBCDField;
    CadClientesN_DES_COT: TFMTBCDField;
    CadClientesC_IND_AGR: TWideStringField;
    CadClientesD_CON_SER: TSQLTimeStampField;
    CadClientesC_IND_CON: TWideStringField;
    CadClientesC_NRO_CON: TWideStringField;
    CadClientesC_IND_SER: TWideStringField;
    CadClientesC_EMA_FIN: TWideStringField;
    CadClientesN_PER_ISS: TFMTBCDField;
    CadClientesI_DIA_PRO: TFMTBCDField;
    CadClientesC_IND_PRO: TWideStringField;
    CadClientesI_USU_ALT: TFMTBCDField;
    CadClientesI_COD_TAB: TFMTBCDField;
    CadClientesI_TIP_ORC: TFMTBCDField;
    CadClientesC_IND_BLO: TWideStringField;
    CadClientesC_EST_RG: TWideStringField;
    CadClientesC_COB_FRM: TWideStringField;
    CadClientesC_FIN_CON: TWideStringField;
    CadClientesC_END_COB: TWideStringField;
    CadClientesI_NUM_COB: TFMTBCDField;
    CadClientesC_BAI_COB: TWideStringField;
    CadClientesC_CEP_COB: TWideStringField;
    CadClientesC_CID_COB: TWideStringField;
    CadClientesC_EST_COB: TWideStringField;
    CadClientesI_CLI_MAS: TFMTBCDField;
    CadClientesI_COD_DES: TFMTBCDField;
    CadClientesN_COM_DES: TFMTBCDField;
    CadClientesD_ULT_COM: TSQLTimeStampField;
    CadClientesC_CON_COM: TWideStringField;
    CadClientesC_FON_COM: TWideStringField;
    CadClientesN_VAL_FRE: TFMTBCDField;
    CadClientesN_VAL_MFR: TFMTBCDField;
    CadClientesC_OBS_TCO: TWideStringField;
    CadClientesI_COD_PRC: TFMTBCDField;
    Localiza: TConsultaPadrao;
    Paginas: TPageControl;
    Basicos: TTabSheet;
    Label1: TLabel;
    Label4: TLabel;
    Label44: TLabel;
    Label54: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label43: TLabel;
    Label52: TLabel;
    Label48: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor9: TDBEditColor;
    DBComboBoxColor2: TDBComboBoxColor;
    DBEditPos21: TDBEditPos2;
    DBEditColor8: TDBEditColor;
    DBEditColor10: TDBEditColor;
    Crediario: TTabSheet;
    Label55: TLabel;
    Label13: TLabel;
    Label51: TLabel;
    Label14: TLabel;
    Label49: TLabel;
    Label15: TLabel;
    Label58: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label10: TLabel;
    Label35: TLabel;
    DBEditColor14: TDBEditColor;
    DBEditColor13: TDBEditColor;
    DBEditColor16: TDBEditColor;
    DBEditColor17: TDBEditColor;
    DBEditPos22: TDBEditPos2;
    DBEditColor20: TDBEditColor;
    DBEditColor18: TDBEditColor;
    Gerais1: TTabSheet;
    Label60: TLabel;
    Label30: TLabel;
    Label5: TLabel;
    LLimiteCreditoFisica: TLabel;
    Label6: TLabel;
    Label41: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label40: TLabel;
    Label19: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    DBEditColor34: TDBEditColor;
    DBEditColor33: TDBEditColor;
    DBComboBoxColor1: TDBComboBoxColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBComboBoxColor3: TDBComboBoxColor;
    DBEditColor6: TDBEditColor;
    DBEditColor30: TDBEditColor;
    DBEditColor31: TDBEditColor;
    Label59: TLabel;
    Label21: TLabel;
    DBEditColor21: TDBEditColor;
    Label22: TLabel;
    Label23: TLabel;
    DBEditColor24: TDBEditColor;
    Label27: TLabel;
    Label25: TLabel;
    DBEditPos23: TDBEditPos2;
    Label3: TLabel;
    Label28: TLabel;
    DBEditColor19: TDBEditColor;
    Label50: TLabel;
    DBEditColor23: TDBEditColor;
    DBEditColor25: TDBEditColor;
    Label24: TLabel;
    Label26: TLabel;
    DBEditColor27: TDBEditColor;
    Label33: TLabel;
    DBMemoColor1: TDBMemoColor;
    DBMemoColor3: TDBMemoColor;
    DBMemoColor2: TDBMemoColor;
    Label38: TLabel;
    Label39: TLabel;
    PanelColor3: TBevel;
    PanelColor4: TBevel;
    PanelColor5: TBevel;
    PanelColor6: TBevel;
    PanelColor7: TBevel;
    PanelColor8: TBevel;
    EProfissaoConjuge: TDBEditLocaliza;
    Label53: TLabel;
    SpeedButton1: TSpeedButton;
    EProfissao: TDBEditLocaliza;
    Label47: TLabel;
    SpeedButton2: TSpeedButton;
    Pessoa: TDBRadioGroup;
    Gerais2: TTabSheet;
    Label63: TLabel;
    PanelColor9: TBevel;
    Label65: TLabel;
    DBEditColor36: TDBEditColor;
    Label71: TLabel;
    DBEditColor40: TDBEditColor;
    Label72: TLabel;
    DBEditColor41: TDBEditColor;
    Label73: TLabel;
    DBMemoColor4: TDBMemoColor;
    Label74: TLabel;
    DBMemoColor5: TDBMemoColor;
    Label77: TLabel;
    DBEditColor43: TDBEditColor;
    DBEditPos24: TDBEditPos2;
    DBEditPos25: TDBEditPos2;
    Label68: TLabel;
    DBEditPos26: TDBEditPos2;
    rep: TGroupBox;
    Label56: TLabel;
    Label57: TLabel;
    DBEditColor37: TDBEditColor;
    DBEditColor38: TDBEditColor;
    Label69: TLabel;
    Label70: TLabel;
    DBEditPos29: TDBEditPos2;
    DBEditPos210: TDBEditPos2;
    DBEditColor39: TDBEditColor;
    Label75: TLabel;
    DBEditNumerico1: TDBEditNumerico;
    ELimiteCreditoFisica: TDBEditNumerico;
    ELimiteCreditoJuridico: TDBEditNumerico;
    LLimiteCreditoJuridico: TLabel;
    ECidade: TDBEditLocaliza;
    BCidade: TSpeedButton;
    DBEditColor28: TDBEditColor;
    DBEditColor11: TDBEditColor;
    DBEditColor29: TDBEditColor;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    ECidadeAnterior: TDBEditLocaliza;
    SpeedButton8: TSpeedButton;
    ECidadeEmpresa: TDBEditLocaliza;
    SpeedButton9: TSpeedButton;
    validagravacao: TValidaGravacao;
    BFechar: TBitBtn;
    CheckBox1: TCheckBox;
    Label80: TLabel;
    DBEditColor15: TDBEditColor;
    Label81: TLabel;
    DBEditColor26: TDBEditColor;
    Label82: TLabel;
    ERegiaoVenda: TDBEditLocaliza;
    SpeedButton10: TSpeedButton;
    Label83: TLabel;
    PainelRG: TPanelColor;
    Label17: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    Label62: TLabel;
    Label67: TLabel;
    DBEditColor5: TDBEditColor;
    DBEditCPF1: TDBEditCPF;
    DBEditColor2: TDBEditColor;
    DBEditColor32: TDBEditColor;
    DBEditPos28: TDBEditPos2;
    PainelCGC: TPanelColor;
    Label2: TLabel;
    Label42: TLabel;
    Label64: TLabel;
    Label66: TLabel;
    DBEditCGC1: TDBEditCGC;
    DBEditColor7: TDBEditInsEstadual;
    DBEditColor35: TDBEditColor;
    DBEditPos27: TDBEditPos2;
    PanelColor11: TBevel;
    Label84: TLabel;
    DBEditUF1: TDBEditUF;
    SpeedButton11: TSpeedButton;
    PAdicionais: TTabSheet;
    Label93: TLabel;
    DBEditColor42: TDBEditColor;
    PEnderecos: TTabSheet;
    Label98: TLabel;
    Label99: TLabel;
    DBEditColor46: TDBEditColor;
    DBEditColor47: TDBEditColor;
    ECidadeEntrega: TDBEditLocaliza;
    SpeedButton16: TSpeedButton;
    Label100: TLabel;
    DBEditColor48: TDBEditColor;
    DBEditColor49: TDBEditColor;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    DBEditColor50: TDBEditColor;
    DBEditColor51: TDBEditColor;
    Label104: TLabel;
    Label105: TLabel;
    ECidadeInstalacao: TDBEditLocaliza;
    SpeedButton17: TSpeedButton;
    DBEditColor52: TDBEditColor;
    DBEditColor53: TDBEditColor;
    DBEditColor54: TDBEditColor;
    DBEditPos211: TDBEditPos2;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    DBEditColor55: TDBEditColor;
    Label109: TLabel;
    DBEditPos212: TDBEditPos2;
    Label110: TLabel;
    DBEditColor56: TDBEditColor;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    DBEditColor57: TDBEditColor;
    Label115: TLabel;
    DBEditColor59: TDBEditColor;
    Label116: TLabel;
    Label122: TLabel;
    DBEditColor60: TDBEditColor;
    PTelemarketing: TTabSheet;
    CAceitaTelemarketing: TDBCheckBox;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    DBMemoColor6: TDBMemoColor;
    CDiaSemana: TComboBoxColor;
    CPeriodoLigacao: TComboBoxColor;
    DBEditColor61: TDBEditColor;
    Label127: TLabel;
    Label128: TLabel;
    DBEditColor62: TDBEditColor;
    PCopiadoras: TTabSheet;
    DBEditColor63: TDBEditColor;
    Label129: TLabel;
    Label132: TLabel;
    DBEditColor64: TDBEditColor;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    DBEditColor65: TDBEditColor;
    Label136: TLabel;
    DBEditColor66: TDBEditColor;
    Label137: TLabel;
    DBEditColor67: TDBEditColor;
    Label141: TLabel;
    DBEditColor71: TDBEditColor;
    ScrollBox1: TScrollBox;
    PanelColor12: TPanelColor;
    LVendedor: TLabel;
    BVendedor: TSpeedButton;
    LNomVendedor: TLabel;
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
    Label121: TLabel;
    Label130: TLabel;
    SpeedButton20: TSpeedButton;
    Label131: TLabel;
    Label138: TLabel;
    ECondicaoPagamento: TDBEditLocaliza;
    EFormaPagamento: TDBEditLocaliza;
    DBEditColor12: TDBEditColor;
    ECodSituacao: TDBEditLocaliza;
    ERamoAtividade: TDBEditLocaliza;
    DBEditColor45: TDBEditColor;
    CEmailPromocional: TDBCheckBox;
    ETransportadora: TDBEditLocaliza;
    ETecnico: TDBEditLocaliza;
    DBEditColor58: TDBEditColor;
    CDestacarISSQN: TDBCheckBox;
    CClienteRevenda: TDBCheckBox;
    CCracha: TDBCheckBox;
    EVendedorPreposto: TDBEditLocaliza;
    DBEditColor70: TDBEditColor;
    CClienteAgropecuario: TDBCheckBox;
    CPossuiContrato: TDBCheckBox;
    EContaBancaria: TDBEditLocaliza;
    Label96: TLabel;
    SpeedButton12: TSpeedButton;
    Label142: TLabel;
    DBEditUF2: TDBEditUF;
    Label143: TLabel;
    SpeedButton21: TSpeedButton;
    DBEditColor44: TDBEditColor;
    Label20: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBEditColor72: TDBEditColor;
    Label144: TLabel;
    DBEditColor73: TDBEditColor;
    Label145: TLabel;
    Label146: TLabel;
    DBEditColor74: TDBEditColor;
    CProtestarCliente: TDBCheckBox;
    DBEditLocaliza8: TDBEditLocaliza;
    Label147: TLabel;
    SpeedButton22: TSpeedButton;
    Label148: TLabel;
    Label149: TLabel;
    DBEditLocaliza9: TDBEditLocaliza;
    SpeedButton23: TSpeedButton;
    Label150: TLabel;
    ETabelaPreco: TDBEditLocaliza;
    Label151: TLabel;
    SpeedButton24: TSpeedButton;
    Label152: TLabel;
    Label153: TLabel;
    ETipoCotacao: TDBEditLocaliza;
    SpeedButton25: TSpeedButton;
    Label154: TLabel;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    Label155: TLabel;
    DBEditColor75: TDBEditColor;
    CCobrarFormaPagamento: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Label156: TLabel;
    Label157: TLabel;
    SpeedButton26: TSpeedButton;
    Label158: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Bevel3: TBevel;
    Label162: TLabel;
    DBEditColor76: TDBEditColor;
    DBEditColor77: TDBEditColor;
    ECidadecobranca: TDBEditLocaliza;
    DBEditColor78: TDBEditColor;
    DBEditColor79: TDBEditColor;
    DBEditColor80: TDBEditColor;
    Label163: TLabel;
    ECliMas: TDBEditLocaliza;
    SpeedButton27: TSpeedButton;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    ECodDesenvolvedor: TDBEditLocaliza;
    SpeedButton28: TSpeedButton;
    Label167: TLabel;
    DBEditColor81: TDBEditColor;
    Label168: TLabel;
    PFornecedor: TTabSheet;
    Label139: TLabel;
    Label140: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    DBEditColor68: TDBEditColor;
    DBEditColor69: TDBEditColor;
    DBEditColor82: TDBEditColor;
    DBEditColor83: TDBEditColor;
    DBEditColor84: TDBEditColor;
    DBEditColor85: TDBEditColor;
    Label173: TLabel;
    EProspect: TDBEditLocaliza;
    SpeedButton29: TSpeedButton;
    Label174: TLabel;
    Label175: TLabel;
    DBEditColor86: TDBEditColor;
    Label176: TLabel;
    SpeedButton30: TSpeedButton;
    Label177: TLabel;
    EConcorrente: TDBEditLocaliza;
    CadClientesI_COD_CON: TFMTBCDField;
    ECodigo: TDBKeyViolation;
    DBCheckBox6: TDBCheckBox;
    DBEditColor87: TDBEditColor;
    Label126: TLabel;
    Label178: TLabel;
    CadClientesC_ENV_ROM: TWideStringField;
    CadClientesN_VLR_MIP: TFMTBCDField;
    CCliente: TDBCheckBox;
    CProspect: TDBCheckBox;
    CFornecedor: TDBCheckBox;
    CadClientesC_IND_CLI: TWideStringField;
    CadClientesC_IND_FOR: TWideStringField;
    CadClientesC_IND_PRC: TWideStringField;
    DBEditColor22: TDBEditColor;
    Label61: TLabel;
    DBEditColor89: TDBEditColor;
    Label179: TLabel;
    CadClientesD_FUN_EMP: TSQLTimeStampField;
    PProspect: TTabSheet;
    Label180: TLabel;
    EProfissaoProspect: TDBEditLocaliza;
    SpeedButton31: TSpeedButton;
    Label181: TLabel;
    Label182: TLabel;
    SpeedButton32: TSpeedButton;
    Label183: TLabel;
    EMeioDivulgacao: TDBEditLocaliza;
    Bevel4: TBevel;
    Label184: TLabel;
    Label185: TLabel;
    SpeedButton33: TSpeedButton;
    ERamoAtividadeProspect: TDBEditLocaliza;
    Label186: TLabel;
    Label187: TLabel;
    EConcorrenteProspect: TDBEditLocaliza;
    SpeedButton34: TSpeedButton;
    Label188: TLabel;
    Label189: TLabel;
    EVendedorProspect: TDBEditLocaliza;
    SpeedButton35: TSpeedButton;
    Label190: TLabel;
    Label191: TLabel;
    DBEditColor90: TDBEditColor;
    CadClientesI_PRC_MDV: TFMTBCDField;
    CadClientesI_PRC_PRF: TFMTBCDField;
    DBMemoColor7: TDBMemoColor;
    CadClientesC_OBS_PRO: TWideStringField;
    Label192: TLabel;
    CadClientesI_PRA_ENT: TFMTBCDField;
    DBEditColor88: TDBEditColor;
    Label193: TLabel;
    CadClientesD_ULT_REC: TSQLTimeStampField;
    Label194: TLabel;
    DBEditColor91: TDBEditColor;
    Label195: TLabel;
    DBEditColor92: TDBEditColor;
    CadClientesC_EMA_INV: TWideStringField;
    CadClientesI_QTD_EMI: TFMTBCDField;
    CadClientesC_EXP_EFI: TWideStringField;
    DBCheckBox7: TDBCheckBox;
    GProdutosInteresse: TRBStringGridColor;
    Label196: TLabel;
    BDiretorio: TSpeedButton;
    PAGZ: TTabSheet;
    CadClientesC_IND_LOC: TWideStringField;
    CadClientesN_TAM_ATE: TFMTBCDField;
    CadClientesN_TAM_EST: TFMTBCDField;
    CadClientesI_HOR_ATE: TFMTBCDField;
    CadClientesN_FAT_ANU: TFMTBCDField;
    CadClientesI_PEC_VEC: TFMTBCDField;
    CadClientesI_PEC_VEA: TFMTBCDField;
    CadClientesC_PRI_CON: TWideStringField;
    CadClientesI_HAB_CID: TFMTBCDField;
    CadClientesC_REF_BAN: TWideStringField;
    CadClientesC_TIP_LOC: TWideStringField;
    CadClientesI_QTD_VEN: TFMTBCDField;
    CadClientesC_LGR_ANT: TWideStringField;
    CadClientesI_QTD_LSV: TFMTBCDField;
    CadClientesD_ULT_TEL: TSQLTimeStampField;
    CadClientesI_QTD_LCV: TFMTBCDField;
    CadClientesI_SEQ_CAM: TFMTBCDField;
    CadClientesI_TIP_FRE: TFMTBCDField;
    CadClientesD_ULT_EMA: TSQLTimeStampField;
    CadClientesD_NAS_CEM: TSQLTimeStampField;
    CadClientesC_NOM_CTD: TWideStringField;
    CadClientesC_FON_CTD: TWideStringField;
    CadClientesN_CAP_SOC: TFMTBCDField;
    CadClientesN_CAP_GIR: TFMTBCDField;
    ScrollBox2: TScrollBox;
    PanelColor13: TPanelColor;
    Label197: TLabel;
    Label198: TLabel;
    Label199: TLabel;
    Label200: TLabel;
    DBEditColor93: TDBEditColor;
    DBRadioGroup1: TDBRadioGroup;
    DBEditColor94: TDBEditColor;
    DBEditNumerico4: TDBEditNumerico;
    DBEditNumerico5: TDBEditNumerico;
    Label201: TLabel;
    DBEditPos213: TDBEditPos2;
    Label202: TLabel;
    Label203: TLabel;
    DBRadioGroup2: TDBRadioGroup;
    DBEditColor95: TDBEditColor;
    Label204: TLabel;
    Label205: TLabel;
    DBEditColor96: TDBEditColor;
    Label206: TLabel;
    Label207: TLabel;
    DBEditColor97: TDBEditColor;
    DBEditColor98: TDBEditColor;
    Label208: TLabel;
    SpeedButton36: TSpeedButton;
    Label209: TLabel;
    Label210: TLabel;
    EHorarioAtendimento: TDBEditLocaliza;
    Label211: TLabel;
    DBEditNumerico6: TDBEditNumerico;
    DBEditNumerico7: TDBEditNumerico;
    Label212: TLabel;
    Label213: TLabel;
    DBEditNumerico8: TDBEditNumerico;
    DBMemoColor8: TDBMemoColor;
    Label214: TLabel;
    DBEditColor99: TDBEditColor;
    Label215: TLabel;
    Label216: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label217: TLabel;
    CadClientesC_NOM_SO1: TWideStringField;
    CadClientesN_PAR_SO1: TFMTBCDField;
    CadClientesC_CPF_SO1: TWideStringField;
    CadClientesD_NAS_SO1: TSQLTimeStampField;
    CadClientesC_NOM_SO2: TWideStringField;
    CadClientesN_PAR_SO2: TFMTBCDField;
    CadClientesC_CPF_SO2: TWideStringField;
    CadClientesD_NAS_SO2: TSQLTimeStampField;
    DBEditColor100: TDBEditColor;
    Label218: TLabel;
    DBEditNumerico9: TDBEditNumerico;
    Label219: TLabel;
    DBEditCPF2: TDBEditCPF;
    Label220: TLabel;
    DBEditColor101: TDBEditColor;
    Label221: TLabel;
    DBEditColor102: TDBEditColor;
    Label222: TLabel;
    DBEditNumerico10: TDBEditNumerico;
    Label223: TLabel;
    DBEditCPF3: TDBEditCPF;
    Label224: TLabel;
    DBEditColor103: TDBEditColor;
    Label225: TLabel;
    Label228: TLabel;
    Bevel7: TBevel;
    Label229: TLabel;
    DBMemoColor9: TDBMemoColor;
    Label230: TLabel;
    Bevel8: TBevel;
    DBMemoColor10: TDBMemoColor;
    Label231: TLabel;
    Label226: TLabel;
    Bevel9: TBevel;
    GFaixaEtaria: TRBStringGridColor;
    GMarcas: TRBStringGridColor;
    Label227: TLabel;
    EFaixaEtaria: TEditLocaliza;
    EMarca: TRBEditLocaliza;
    CadClientesC_EMA_FOR: TWideStringField;
    CadClientesC_DES_ICM: TWideStringField;
    DBCheckBox8: TDBCheckBox;
    CadClientesC_CLA_PLA: TWideStringField;
    CadClientesC_IDE_BAN: TWideStringField;
    DBEditColor104: TDBEditColor;
    Label232: TLabel;
    Bevel10: TBevel;
    Label233: TLabel;
    Bevel11: TBevel;
    Label234: TLabel;
    Label235: TLabel;
    EPlano: TDBEditColor;
    BPlano: TSpeedButton;
    LPlano: TLabel;
    CadClientesD_DAT_CAD: TSQLTimeStampField;
    CadClientesC_NOM_FAN: TWideStringField;
    Aux: TSQLQuery;
    CadClientesI_COD_IBG: TFMTBCDField;
    CadClientesI_COD_PAI: TFMTBCDField;
    Label236: TLabel;
    DBEditColor105: TDBEditColor;
    CadClientesC_EMA_NFE: TWideStringField;
    CadClientesC_IND_VIS: TWideStringField;
    PanelColor10: TPanelColor;
    PanelColor14: TPanelColor;
    PanelColor15: TPanelColor;
    PanelColor16: TPanelColor;
    PanelColor17: TPanelColor;
    PanelColor18: TPanelColor;
    PanelColor19: TPanelColor;
    PanelColor20: TPanelColor;
    PanelColor21: TPanelColor;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    CadClientesC_OPT_SIM: TWideStringField;
    CadClientesC_FLA_EXP: TWideStringField;
    CadClientesC_VER_PED: TWideStringField;
    CadClientesC_COM_PED: TWideStringField;
    CHotel: TDBCheckBox;
    CadClientesC_IND_HOT: TWideStringField;
    DBCheckBox12: TDBCheckBox;
    CadClientesC_IND_ATI: TWideStringField;
    Label29: TLabel;
    EPerfilCliente: TDBEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label79: TLabel;
    CadClientesD_DAT_EXP: TSQLTimeStampField;
    CadClientesI_PER_CLI: TFMTBCDField;
    BMenuFiscal: TBitBtn;
    CadClientesN_PER_FRE: TFMTBCDField;
    DBEditColor106: TDBEditColor;
    Label85: TLabel;
    Label86: TLabel;
    Label237: TLabel;
    SpeedButton4: TSpeedButton;
    Label238: TLabel;
    ERedespacho: TDBEditLocaliza;
    CadClientesC_IND_CBA: TWideStringField;
    CadClientesC_IND_BUM: TWideStringField;
    CadClientesI_COD_EMB: TFMTBCDField;
    CadClientesI_COD_RED: TFMTBCDField;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    Label239: TLabel;
    SpeedButton37: TSpeedButton;
    Label240: TLabel;
    EEmbalagem: TDBEditLocaliza;
    CadClientesI_TIP_MAP: TFMTBCDField;
    Label241: TLabel;
    ETipoMateriaPrima: TDBEditLocaliza;
    SpeedButton38: TSpeedButton;
    Label242: TLabel;
    CadClientesC_CID_CLI: TWideStringField;
    CadClientesC_FOR_EAP: TWideStringField;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    CadClientesC_IND_TRA: TWideStringField;
    CadClientesI_COD_USU: TFMTBCDField;
    Label243: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    SpeedButton39: TSpeedButton;
    Label244: TLabel;
    CadClientesC_PRO_EMP: TWideStringField;
    Label245: TLabel;
    DBEditColor107: TDBEditColor;
    CadClientesC_REF_COM: TWideStringField;
    DBEditColor108: TDBEditColor;
    CadClientesC_TIP_FO1: TWideStringField;
    CadClientesC_TIP_FO2: TWideStringField;
    CadClientesC_TIP_FO3: TWideStringField;
    DBEditColor109: TDBEditColor;
    DBEditColor110: TDBEditColor;
    EVendedor: TRBDBEditLocaliza;
    DBEditColor111: TDBEditColor;
    Label246: TLabel;
    CadClientesC_SEN_ASS: TWideStringField;
    ScrollBox3: TScrollBox;
    Label247: TLabel;
    DBEditColor112: TDBEditColor;
    SpeedButton40: TSpeedButton;
    CadClientesC_IND_COF: TWideStringField;
    DBCheckBox16: TDBCheckBox;
    PTransportadora: TTabSheet;
    PanelColor22: TPanelColor;
    DBCheckBox17: TDBCheckBox;
    CadClientesC_VEI_PRO: TWideStringField;
    Label248: TLabel;
    EUfEmbarque: TDBEditUF;
    SpeedButton41: TSpeedButton;
    Label249: TLabel;
    DBEditColor113: TDBEditColor;
    CadClientesC_EST_EMB: TWideStringField;
    CadClientesC_LOC_EMB: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadClientesAfterInsert(DataSet: TDataSet);
    procedure CadClientesBeforeEdit(DataSet: TDataSet);
    procedure CadClientesBeforePost(DataSet: TDataSet);
    procedure CadClientesAfterEdit(DataSet: TDataSet);
    procedure EProfissaoConjugeCadastrar(Sender: TObject);
    procedure PessoaChange(Sender: TObject);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBEditPos26Exit(Sender: TObject);
    procedure DBEditColor19Exit(Sender: TObject);
    procedure ECodSituacaoCadastrar(Sender: TObject);
    procedure DBEditCGC1Exit(Sender: TObject);
    procedure DBEditColor5Exit(Sender: TObject);
    procedure ECidadeCadastrar(Sender: TObject);
    procedure ECidadeRetorno(Retorno1, Retorno2: String);
    procedure SpeedButton6Click(Sender: TObject);
    procedure ECidadeAnteriorRetorno(Retorno1, Retorno2: String);
    procedure ECidadeEmpresaRetorno(Retorno1, Retorno2: String);
    procedure SpeedButton7Click(Sender: TObject);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure ERegiaoVendaCadastrar(Sender: TObject);
    procedure DBEditColor12Exit(Sender: TObject);
    procedure EVendedorCadastrar(Sender: TObject);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
    procedure DBEditPos27Exit(Sender: TObject);
    procedure ERamoAtividadeCadastrar(Sender: TObject);
    procedure ECondicaoPagamentoCadastrar(Sender: TObject);
    procedure ETransportadoraCadastrar(Sender: TObject);
    procedure ETecnicoCadastrar(Sender: TObject);
    procedure CadClientesAfterScroll(DataSet: TDataSet);
    procedure DBEditColor10Exit(Sender: TObject);
    procedure EContaBancariaSelect(Sender: TObject);
    procedure ETabelaPrecoSelect(Sender: TObject);
    procedure ECidadecobrancaRetorno(Retorno1, Retorno2: String);
    procedure EProspectRetorno(Retorno1, Retorno2: String);
    procedure CadClientesAfterPost(DataSet: TDataSet);
    procedure EConcorrenteCadastrar(Sender: TObject);
    procedure DBEditColor40KeyPress(Sender: TObject; var Key: Char);
    procedure CClienteClick(Sender: TObject);
    procedure EMeioDivulgacaoCadastrar(Sender: TObject);
    procedure DBEditColor1Exit(Sender: TObject);
    procedure DBEditPos21Exit(Sender: TObject);
    procedure DBEditPos24Exit(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure GProdutosInteresseCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosInteresseDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosInteresseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosInteresseMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosInteresseNovaLinha(Sender: TObject);
    procedure GProdutosInteresseSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure BDiretorioClick(Sender: TObject);
    procedure EHorarioAtendimentoCadastrar(Sender: TObject);
    procedure GFaixaEtariaCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GFaixaEtariaDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GFaixaEtariaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GFaixaEtariaMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFaixaEtariaNovaLinha(Sender: TObject);
    procedure GFaixaEtariaSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EFaixaEtariaCadastrar(Sender: TObject);
    procedure EFaixaEtariaRetorno(Retorno1, Retorno2: String);
    procedure GMarcasCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GMarcasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GMarcasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GMarcasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GMarcasNovaLinha(Sender: TObject);
    procedure GMarcasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EMarcaCadastrar(Sender: TObject);
    procedure EMarcaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure BPlanoClick(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECondicaoPagamentoSelect(Sender: TObject);
    procedure PanelColor17Click(Sender: TObject);
    procedure DBEditUF1Retorno(Retorno1, Retorno2: string);
    procedure CadClientesBeforeCancel(DataSet: TDataSet);
    procedure BMenuFiscalClick(Sender: TObject);
    procedure EEmbalagemCadastrar(Sender: TObject);
    procedure ETipoMateriaPrimaCadastrar(Sender: TObject);
    procedure DBEditColor111DblClick(Sender: TObject);
    procedure SpeedButton40Click(Sender: TObject);
  private
    VprProspectImportado: Boolean;
    VprEmail,
    VprEmailFinanceiro : String;
    codigoEventos : TStringList;
    VprDProspect: TRBDProspect;
    VprDProInteresse : TRBDProdutoInteresseCliente;
    VprDFaixaEtaria : TRBDFaixaEtariaCliente;
    VprDMarca : TRBDMarcaCliente;
    VprProdutosInteresse,
    VprFaixasEtaria,
    VprMarcas : TList;
    FunEmarketing : TRBFuncoesEMarketing;
    procedure VerificaPermissaoUsuario;
    procedure AtualizaIndicadorCliente;
    procedure CarTitulosGrade;
    function LocalizaCodigoEvento( codigoEvento : string ) : Boolean;
    procedure CarRegiaoCliente;
    function LocalizaCliente( cgc_Cpf : string; cgc : Boolean) :  Boolean;
    function DadosValidos : boolean;
    procedure ConfiguraPermissaoUsuario;
    procedure ImportaProspect;
    procedure ImportaProdutosContatosProspect;
    procedure AtualizaTela;
    procedure CamposObrigatorios;
    procedure AtualizaTelaProspect;
    procedure AtualizaTelaAGZ;
    function ExisteProduto : Boolean;
    function ExisteFaixaEtaria : Boolean;
    function LocalizaProduto : Boolean;
  public
    { Public declarations }
    procedure AtualizasLocalizas;
    procedure ConsultaCliente(VpaCodCliente : Integer);
    procedure NovoProspect;
  end;

var
  FNovoCliente: TFNovoCliente;

implementation

uses APrincipal, AClientes, AProfissoes, ASituacoesClientes, funsql,
  AConsultaRuas, ACadCidades, Funstring, ARegiaoVenda, ANovoVendedor,
  AFormasPagamento, ARamoAtividade, FunObjeto,
  ANovoTecnico, UnClientes,
  ANovoConcorrente, Fundata, AMeioDivulgacao, ALocalizaProdutos, FunArquivos,
  AHorarioTrabalho, AFaixaEtaria, AMarcas, APlanoConta, ACondicaoPagamento, UnSistema, AMenuFiscalECF, AEmbalagem,
  ATipoMateriaPrima, ATelefonesCliente;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoCliente.FormCreate(Sender: TObject);
begin
  CarTitulosGrade;
  VerificaPermissaoUsuario;
  VprProdutosInteresse := TList.create;
  VprFaixasEtaria := TList.create;
  VprMarcas := TList.create;
  GProdutosInteresse.ADados := VprProdutosInteresse;
  GFaixaEtaria.ADados := VprFaixasEtaria;
  GMarcas.ADados := VprMarcas;
  VprDProspect:= TRBDProspect.cria;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1, 'S', 'N');
  CadClientes.open;
  CodigoEventos := TStringList.Create;
  Paginas.ActivePage := Basicos;
  PCopiadoras.TabVisible := config.ManutencaoImpressoras;
  ConfiguraPermissaoUsuario;
  VprProspectImportado:= False;
  FunEmarketing := TRBFuncoesEMarketing.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CadClientes);
  VprDProspect.Free;
  if CodigoEventos <> nil then
    codigoEventos.Free;
  FreeTObjectsList(VprFaixasEtaria);
  VprFaixasEtaria.free;
  FreeTObjectsList(VprMarcas);
  VprMarcas.free;
  FreeTObjectsList(VprProdutosInteresse);
  FunEmarketing.Free;
  VprProdutosInteresse.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Ações que controlam o Cadastro de Eventos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************Procura o codigo do evento**************************}
function TFNovoCliente.LocalizaCodigoEvento( codigoEvento : string ) : Boolean;
var
  laco : integer;
begin
  result := false;
  for laco := 0 to CodigoEventos.Count - 1 do
    if CodigoEventos.Strings[laco] = CodigoEvento then
      Result:= True;
end;

{******************************************************************************}
procedure TFNovoCliente.VerificaPermissaoUsuario;
begin
  if not(puAdministrador in varia.PermissoesUsuario) then
  begin
    if (puCRSomenteCadastraProspect in varia.PermissoesUsuario) then
    begin
      AlterarEnabledDet([CCliente,CProspect,CFornecedor,CHotel],false);
    end;
    if (puOcultarVendedor in varia.PermissoesUsuario) then
      AlterarVisibleDet([LVendedor,EVendedor,LNomVendedor,BVendedor],false);
  end;
  PAGZ.TabVisible := Varia.CNPJFilial = CNPJ_AGZ;
  BMenuFiscal.Visible := NomeModulo = 'PDV';

end;

{******************************************************************************}
procedure TFNovoCliente.AtualizaIndicadorCliente;
begin
  if CCliente.Checked then
    CadClientesC_IND_CLI.AsString := 'S'
  else
    CadClientesC_IND_CLI.AsString := 'N';
  if CFornecedor.Checked then
    CadClientesC_IND_FOR.AsString := 'S'
  else
    CadClientesC_IND_FOR.AsString := 'N';
  if CProspect.Checked then
    CadClientesC_IND_PRC.AsString := 'S'
  else
    CadClientesC_IND_PRC.AsString := 'N';
end;

{******************************************************************************}
procedure TFNovoCliente.CarTitulosGrade;
begin
  GProdutosInteresse.Cells[1,0] := 'Código';
  GProdutosInteresse.Cells[2,0] := 'Produto';
  GProdutosInteresse.Cells[3,0] := 'Quantidade';

  GFaixaEtaria.Cells[1,0] := 'Código';
  GFaixaEtaria.Cells[2,0] := 'Descrição';

  GMarcas.Cells[1,0] := 'Código';
  GMarcas.Cells[2,0] := 'Descrição';
end;


{******************************************************************************}
procedure TFNovoCliente.CarRegiaoCliente;
begin
  if (CadClientesC_IND_FOR.AsString = 'N') or (CadClientesC_IND_CLI.AsString = 'S') then
  begin
    CadClientesI_COD_REG.AsInteger := FunClientes.RCodRegiaVendas(CadClientesC_CEP_CLI.AsString);
    if CadClientesI_COD_REG.AsInteger = 0 then
      CadClientesI_COD_REG.Clear;
    ERegiaoVenda.Atualiza;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.BotaoGravar1DepoisAtividade(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    CadClientes.Insert;
    ECodigo.SetFocus;
  end
  else
    BotaoGravar1.AFecharAposOperacao := True;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Eventos da Tabela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**********************Carrega os dados default do cadastro********************}
procedure TFNovoCliente.CadClientesAfterInsert(DataSet: TDataSet);
begin
  if varia.TipoBancoDados = bdMatrizSemRepresentante then
    ECodigo.ProximoCodigo
  else
    CadClientesI_COD_CLI.AsInteger := FunClientes.RProximoCodClienteRepresentanteDisponivel;
  if varia.TipoBancoDados = bdRepresentante then
    CadClientesC_FLA_EXP.AsString := 'N'
  else
    CadClientesC_FLA_EXP.AsString := 'S';
  CadClientesD_DAT_CAD.AsDateTime := Date;
  CadClientesC_TIP_PES.Value := 'J';
  CadClientesC_TIP_CAD.Value := 'C';
  CadClientesC_IND_CLI.Value := 'S';
  CadClientesC_IND_FOR.Value := 'N';
  CadClientesC_IND_PRC.Value := 'N';
  CadClientesC_IND_TRA.Value := 'N';
  CadClientesC_IND_HOT.Value := 'N';
  CadClientesC_IND_VIS.Value := 'N';
  CadClientesC_IND_ATI.AsString := 'S';
  CadClientesC_TIP_FAT.AsString := 'N';
  CadClientesC_IND_REV.AsString := 'N';
  CadClientesC_DES_ISS.AsString := 'N';
  CadClientesC_ACE_TEL.AsString := 'S';
  CadClientesC_IND_AGR.AsString := 'N';
  CadClientesC_IND_CRA.AsString := 'N';
  CadClientesC_IND_PRO.AsString := 'S';
  CadClientesC_IND_BLO.AsString := 'N';
  CadClientesC_ACE_SPA.AsString := 'S';
  CadClientesC_IND_CON.AsString := 'N';
  CadClientesC_IND_SER.AsString := 'N';
  CadClientesC_COB_FRM.AsString := 'S';
  CadClientesC_FIN_CON.AsString := 'S';
  CadClientesC_ENV_ROM.AsString:= 'N';
  CadClientesC_EMA_INV.AsString:= 'N';
  CadClientesC_EXP_EFI.AsString:= 'N';
  CadClientesC_IND_LOC.AsString := 'R';
  CadClientesC_TIP_LOC.AsString := 'C';
  CadClientesC_DES_ICM.AsString := 'S';
  CadClientesC_OPT_SIM.AsString := 'N';
  CadClientesC_IND_BUM.AsString := 'N';
  CadClientesC_IND_CBA.AsString := 'N';
  CadClientesC_VER_PED.AsString := VersaoSistemaPedido;
  CadClientesC_COM_PED.AsString := Varia.NomeComputador;
  CadClientesI_COD_USU.AsInteger := Varia.CodigoUsuario;

  if Varia.SituacaoPadraoCliente = 0 then
    aviso('SITUAÇÃO PADRÃO DO CLIENTE NÃO PREENCHIDA!!!'#13+
          'É necessário preencher nas configurações do sistema.')
  else
  begin
    CadClientesI_COD_SIT.AsInteger:= Varia.SituacaoPadraoCliente;
    ECodSituacao.Atualiza;
  end;
  if Varia.CodVendedor <> 0 then
    CadClientesI_COD_VEN.AsInteger := Varia.CodVendedor
  else
    if (varia.CNPJFilial <> CNPJ_Majatex)then
      AlterarEnabledDet([EVendedor,BVendedor],true);
  if varia.TipoBancoDados = bdRepresentante then
  begin
    CadClientesI_COD_VEN.AsInteger := varia.CodVendedorSistemaPedidos;
    AlterarEnabledDet([EVendedor,BVendedor],false);
  end;
  ECodigo.ReadOnly := False;
//  DBEditLocaliza1.Limpa;
//  DBEditLocaliza2.Limpa;
  CadClientesN_LIM_CLI.AsFloat := 0;
end;

{**********************Não permite alterar o código do cliente*****************}
procedure TFNovoCliente.CadClientesBeforeCancel(DataSet: TDataSet);
begin
  if CadClientes.State = dsinsert then
  begin
    if Varia.TipoBancoDados in [bdMatrizComRepresentante,bdRepresentante] then
    begin
      FunClientes.IncluiCodigoCliente(CadClientesI_COD_CLI.AsInteger);
    end;
  end;
end;

{**********************Não permite alterar o código do cliente*****************}
procedure TFNovoCliente.CadClientesBeforeEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := True;
end;

{**********Verifica se o codigo já foi utilizado por outro usuario na rede*****}
procedure TFNovoCliente.CadClientesBeforePost(DataSet: TDataSet);
begin
  CadClientesD_DAT_ALT.AsDateTime := Sistema.RDataServidor;
  if CadClientes.State = dsinsert then
  begin
    if varia.TipoBancoDados = bdMatrizSemRepresentante then
      ECodigo.VerificaCodigoUtilizado
    else
      if FunClientes.ExisteCliente(CadClientesI_COD_CLI.AsInteger) then
        CadClientesI_COD_CLI.AsInteger := FunClientes.RProximoCodClienteRepresentanteDisponivel;

    CarRegiaoCliente;
  end
  else
    if CadClientes.State = dsedit then
    begin
      if (CadClientesC_END_ELE.AsString <> VprEmail) or
         (CadClientesC_EMA_FIN.AsString <> VprEmailFinanceiro) then
        CadClientesC_EXP_EFI.AsString := 'N';
    end;
  if not DadosValidos then
    abort;
  CadClientesI_DIA_TEL.AsInteger := CDiaSemana.ItemIndex;
  CadClientesI_PER_TEL.AsInteger := CPeriodoLigacao.ItemIndex;
  CadClientesI_USU_ALT.AsInteger := Varia.CodigoUsuario;
end;

{*************Atualiza os localiza e carrega os Eventos************************}
procedure TFNovoCliente.CadClientesAfterEdit(DataSet: TDataSet);
begin
//  DBEditLocaliza1.Atualiza;
//  DBEditLocaliza2.Atualiza;
  VprEmail := CadClientesC_END_ELE.AsString;
  VprEmailFinanceiro := CadClientesC_EMA_FIN.AsString;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações dos Localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**********************Cadastra uma nova profissão*****************************}
procedure TFNovoCliente.EProfissaoConjugeCadastrar(Sender: TObject);
begin
  FProfissoes := TFProfissoes.criarSDI(Application,'',FPrincipal.VerificaPermisao('FProfissoes'));
  FProfissoes.BotaoCadastrar1.Click;
  FProfissoes.ShowModal;
  Localiza.AtualizaConsulta;
end;

{***********************Cadastra uma nova situação*****************************}
procedure TFNovoCliente.ECodSituacaoCadastrar(Sender: TObject);
begin
  FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FSituacoesClientes'));
  FSituacoesClientes.BotaoCadastrar1.Click;
  FSituacoesClientes.ShowModal;
  Localiza.AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovoCliente.DadosValidos : boolean;
begin
  result := true;
  if (CadClientesC_IND_CLI.AsString = 'S') then
  begin
    if config.ExigirCPFCNPJCliente then
    begin
      if CadClientesC_TIP_PES.AsString = 'F' then
      begin
        if DeletaChars(DeletaChars(DeletaChars(CadClientesC_CPF_CLI.AsString,'.'),'-'),' ') = '' then
        begin
          result := false;
          aviso('CPF VAZIO!!!'#13'É necessário digitar o CPF do cliente.');
        end;
      end
      else
        if CadClientesC_TIP_PES.AsString = 'J' then
        begin
          if DeletaChars(DeletaChars(DeletaChars(DeletaChars(CadClientesC_CGC_CLI.AsString,'.'),'/'),'-'), ' ') = '' then
          begin
            result := false;
            aviso('CNPJ VAZIO!!!'#13'É necessário digitar o CNPJ do cliente.');
          end;
        end;
      if result  then
      begin
        if DeletaChars(DeletaChars(DeletaChars(CadClientesC_FO1_CLI.AsString,'('),')'),' ') = '' then
        begin
          result := false;
          aviso('TELEFONE VAZIO!!!'#13'É necessário digitar o telefone do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if config.ExigirCEPCliente then
      begin
        if DeletaChars(DeletaChars(DeletaChars(CadClientesC_CEP_CLI.AsString,'-'),' '),'0') = '' then
        begin
          result := false;
          aviso('CEP VAZIO!!!'#13'É necessário digitar o CEP do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if Config.ExigirTransportadoraCliente then
      begin
        if CadClientesI_COD_TRA.AsInteger = 0 then
        begin
          result := false;
          aviso('TRANSPORTADORA VAZIA!!!'#13'É necessário preencher a transportadora do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if Config.ExigirCondicaoPagamentoCliente then
      begin
        if CadClientesI_COD_PAG.AsInteger = 0 then
        begin
          result := false;
          aviso('CONDIÇÃO DE PAGAMENTO VAZIA!!!'#13'É necessário preencher a condição de pagamento do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if Config.ExigirFormaPagamentoCliente then
      begin
        if CadClientesI_FRM_PAG.AsInteger = 0 then
        begin
          result := false;
          aviso('FORMA DE PAGAMENTO VAZIA!!!'#13'É necessário preencher a forma de pagamento do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if Config.ExigirVendedorCliente then
      begin
        if CadClientesI_COD_VEN.AsInteger = 0 then
        begin
          result := false;
          aviso('VENDEDOR VAZIO!!!'#13'É necessário preencher o vendedor do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if Config.ExigirPrepostoCliente then
      begin
        if CadClientesI_VEN_PRE.AsInteger = 0 then
        begin
          result := false;
          aviso('VENDEDOR PREPOSTO VAZIO!!!'#13'É necessário preencher o vendedor preposto do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if Config.ExigirContatoCliente AND (CadClientesC_TIP_PES.AsString = 'J') then
      begin
        if CadClientesC_CON_CLI.AsString = '' then
        begin
          result := false;
          aviso('NOME DO CONTATO VAZIO!!!'#13'É necessário preencher o nome do contato do cliente.');
        end;
      end;
    end;
    if result then
    begin
      if Config.ExigirEmailCliente then
      begin
        if CadClientesC_END_ELE.AsString = '' then
        begin
          result := false;
          aviso('E-MAIL DO CLIENTE VAZIO!!!'#13'É necessário preencher a e-mail do cliente.');
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.ConfiguraPermissaoUsuario;
begin
  if not (puAdministrador in varia.PermissoesUsuario) then
  begin
    AlterarEnabledDet([EVendedor,BVendedor],config.PermitirAlterarVendedornaCotacao);
    if not (puAlterarLimiteCredito in varia.PermissoesUsuario) then
      AlterarEnabledDet([ELimiteCreditoFisica,ELimiteCreditoJuridico,LLimiteCreditoFisica,LLimiteCreditoJuridico],false);
  end;
  BDiretorio.Visible := Varia.PathCliente <> '';
  if varia.TipoBancoDados = bdRepresentante then
  begin
    EVendedorPreposto.AInfo.Cadastrar := false;
    ECidade.AInfo.Cadastrar := false;
    ECodDesenvolvedor.AInfo.Cadastrar := false;
    ECondicaoPagamento.AInfo.Cadastrar := false;
    EFormaPagamento.AInfo.Cadastrar := false;
    ETecnico.AInfo.Cadastrar := false;
    ECodSituacao.AInfo.Cadastrar := false;
    ERamoAtividade.AInfo.Cadastrar := false;
    ETransportadora.AInfo.Cadastrar := false;
    EConcorrente.AInfo.Cadastrar := false;
    ETabelaPreco.AInfo.Cadastrar := false;
    ETipoCotacao.AInfo.Cadastrar := false;
    ECliMas.AInfo.Cadastrar := false;
    EContaBancaria.AInfo.Cadastrar := false;
    EMeioDivulgacao.AInfo.Cadastrar := false;
    EProfissaoProspect.AInfo.Cadastrar := false;
    ERamoAtividadeProspect.AInfo.Cadastrar := false;
    EConcorrenteProspect.AInfo.Cadastrar := false;
    EVendedorProspect.AInfo.Cadastrar := false;
    ECidadeAnterior.AInfo.Cadastrar := false;
    EProfissaoConjuge.AInfo.Cadastrar := false;
    ECidadeEmpresa.AInfo.Cadastrar := false;
    EProfissao.AInfo.Cadastrar := false;
    ECidadeEntrega.AInfo.Cadastrar := false;
    ECidadecobranca.AInfo.Cadastrar := false;
    ECidadeInstalacao.AInfo.Cadastrar := false;
    EHorarioAtendimento.AInfo.Cadastrar := false;
  end;

end;

{************* verifica cgc ou cpf repetidos na base ************************ }
function TFNovoCliente.LocalizaCliente( cgc_Cpf : string; cgc : Boolean) :  Boolean;
begin
result := false;
if cgc_Cpf <> '' then
begin
  LimpaSQLTabela(aux);
  AdicionaSQLTabela(aux,'Select * from cadClientes');
  if cgc then
    AdicionaSQLTabela(aux,' where c_cgc_cli = ''' + cgc_Cpf + '''')
  else
    AdicionaSQLTabela(aux,' where c_cpf_cli = ''' + cgc_Cpf + '''');

  if CadClientes.State = dsedit then
    AdicionaSQLTabela(Aux,'and I_COD_CLI <> '+CadClientesI_COD_CLI.AsString);
  AbreTabela(aux);

  if not Aux.eof then
  begin
   result := true;
   aviso('Ja existe um cadastro com este cgc/cpf, Código ' +
          aux.fieldByName('I_COD_CLI').AsString + ' - Nome ' +
          aux.fieldByName('C_NOM_CLI').AsString );
  end;
  Aux.close;
end;
end;

{******************************************************************************}
procedure TFNovoCliente.AtualizaSLocalizas;
begin
//  DBEditLocaliza1.Atualiza;
//  DBEditLocaliza2.Atualiza;
//  DBEditLocaliza3.Atualiza;
  ERegiaoVenda.Atualiza;
  EVendedor.Atualiza;
  ECondicaoPagamento.Atualiza;
  EFormaPagamento.Atualiza;
  ETecnico.Atualiza;
  Paginas.ActivePage := Basicos;
end;

{******************************************************************************}
procedure TFNovoCliente.ConsultaCliente(VpaCodCliente : Integer);
begin
  AdicionaSqlAbreTabela(CadClientes,'Select * from CADCLIENTES '+
                        ' Where I_COD_CLI = ' +IntToStr(Vpacodcliente));
  showmodal;
end;

{******************************************************************************}
procedure TFNovoCliente.NovoProspect;
begin
  CadClientes.Insert;
  CProspect.Checked := true;
  CCliente.Checked := false;
  showmodal;
end;

{***************Modifica os cadastro conforme o tipo de pessoa*****************}
procedure TFNovoCliente.PessoaChange(Sender: TObject);
begin
  if pessoa.ItemIndex = 1 then
  begin
    PainelCGC.Visible := false;
    PainelRG.Visible := true;
    crediario.TabVisible := true;
    gerais1.TabVisible := true;
    gerais2.TabVisible := false;
  end
  else
  begin
    try
      PainelCGC.Visible := true;
      PainelRG.Visible := false;
      crediario.TabVisible := false;
      gerais1.TabVisible := false;
      gerais2.TabVisible := true;
    except
    end;
  end;
end;

{**********************Abre o movimento dos eventos do cliente*****************}
procedure TFNovoCliente.FormShow(Sender: TObject);
begin
end;

{*******Dependendo do tipo de pessoa F ou J pula para paginas diferentes*******}
procedure TFNovoCliente.DBEditPos26Exit(Sender: TObject);
begin

end;

{******************Pula para a pagina geral da pessoal física******************}
procedure TFNovoCliente.DBEditColor19Exit(Sender: TObject);
begin
  paginas.ActivePage := Gerais1;
  DBEditNumerico1.SetFocus;
end;

{ ************* Verifica cgc repetido *************************************** }
procedure TFNovoCliente.DBEditCGC1Exit(Sender: TObject);
begin
LocalizaCliente(DBEditCGC1.Field.AsString, true);
end;

{ ************* Verifica cpf repetido *************************************** }
procedure TFNovoCliente.DBEditColor5Exit(Sender: TObject);
begin
  LocalizaCliente(DBEditCPF1.Field.AsString, false);
end;

{******************************************************************************}
procedure TFNovoCliente.EEmbalagemCadastrar(Sender: TObject);
begin
  FEmbalagem := TFEmbalagem.criarSDI(Application,'',FPrincipal.VerificaPermisao('FEmbalagem'));
  FEmbalagem.BotaoCadastrar1.Click;
  FEmbalagem.showmodal;
  FEmbalagem.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCliente.ECidadeCadastrar(Sender: TObject);
begin
  FCidades := TFCidades.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FCidades'));
  FCidades.ShowModal;
  FCidades.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCliente.ECidadeRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno2 <> '') then
    if (CadClientes.State in [dsInsert, dsEdit]) then
    begin
      if Retorno1 <> '' then
        CadClientesI_COD_IBG.AsInteger:=StrToInt(Retorno1)
      else
        CadClientesI_COD_IBG.clear;
      CadClientesC_EST_CLI.AsString:=Retorno2; // Grava o Estado;
      CadClientesI_COD_PAI.AsInteger := FunClientes.RCodPais(Retorno2);
    end;
end;

{******************************************************************************}
procedure TFNovoCliente.SpeedButton40Click(Sender: TObject);
begin
 FTelefoneCliente := TFTelefoneCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FTelefoneCliente'));
 FTelefoneCliente.TelefoneCliente(CadClientesI_COD_CLI.AsInteger);
 FTelefoneCliente.free;
end;

procedure TFNovoCliente.SpeedButton6Click(Sender: TObject);
var
  VpfCodCidade,
  VpfCEP,
  VpfRua,
  VpfBairro,
  VpfDesCidade: string;
begin
 VpfCEP := SubstituiStr( VpfCEP,'-','');
  FConsultaRuas := TFConsultaRuas.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FConsultaRuas'));
  if FConsultaRuas.BuscaEndereco(VpfCodCidade, VpfCEP,
       VpfRua, VpfBairro, VpfDesCidade)
  then
  begin
    // Preenche os campos;
    CadClientesC_CEP_ANT.AsString := VpfCEP;
    CadClientesC_END_ANT.AsString := VpfRua + ' - ' + VpfBairro;
  end;
  ECidadeAnterior.Atualiza;
end;

procedure TFNovoCliente.ECidadeAnteriorRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 <> '') then
    if (CadClientes.State in [dsInsert, dsEdit]) then
      CadClientesC_EST_ANT.AsString:=Retorno2; // Grava o Estado;
end;

procedure TFNovoCliente.ECidadeEmpresaRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 <> '') then
    if (CadClientes.State in [dsInsert, dsEdit]) then
      CadClientesC_EST_EMP.AsString:=Retorno2; // Grava o Estado;
end;

procedure TFNovoCliente.SpeedButton7Click(Sender: TObject);
var
  VpfCodCidade,
  VpfCEP,
  VpfRua,
  VpfBairro,
  VpfDesCidade: string;
begin
  VpfCEP := SubstituiStr( VpfCEP,'-','');
  FConsultaRuas := TFConsultaRuas.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FConsultaRuas'));
  if FConsultaRuas.BuscaEndereco(VpfCodCidade, VpfCEP,
       VpfRua, VpfBairro, VpfDesCidade)
  then
  begin
    // Preenche os campos;
    CadClientesC_CEP_EMP.AsString := VpfCEP;
    CadClientesC_END_EMP.AsString := VpfRua;
    CadClientesC_BAI_EMP.AsString := VpfBairro;
    ECidadeEmpresa.Atualiza;
  end;
end;

procedure TFNovoCliente.DBKeyViolation1Change(Sender: TObject);
begin
  if CadClientes.state in [dsEdit, dsInsert] then
    ValidaGravacao.Execute;
end;

{****************** fecha formulario *************************************** }
procedure TFNovoCliente.BFecharClick(Sender: TObject);
begin
self.close;
end;

{******************************************************************************}
procedure TFNovoCliente.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFNovoCliente.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFNovoCliente.ERegiaoVendaCadastrar(Sender: TObject);
begin
  FRegiaoVenda := TFRegiaoVenda.criarSDI(Application,'',FPrincipal.VerificaPermisao('FRegiaoVenda'));
  FRegiaoVenda.ShowModal;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCliente.DBEditColor12Exit(Sender: TObject);
begin
  if Pessoa.ItemIndex = 1 then
    paginas.ActivePage := Crediario
  else
    paginas.ActivePage := Gerais2;
end;

{******************************************************************************}
procedure TFNovoCliente.EVendedorCadastrar(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoVendedor'));
  FNovoVendedor.CadVendedores.Insert;
  FNovoVendedor.Showmodal;
  FNovoVendedor.free;
end;

procedure TFNovoCliente.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.click;
  FFormasPagamento.showmodal;
end;

{******************************************************************************}
procedure TFNovoCliente.DBEditPos27Exit(Sender: TObject);
begin
  Paginas.ActivePage := PAdicionais;
  ActiveControl := EVendedor;
end;

{******************************************************************************}
procedure TFNovoCliente.DBEditUF1Retorno(Retorno1, Retorno2: string);
begin
  if (CadClientes.State in [dsInsert, dsEdit]) then
  begin
     if CadClientesC_EST_CLI.AsString = '' then
       CadClientesI_COD_IBG.clear
     else
       CadClientesI_COD_IBG.AsInteger:= FunClientes.RCodCidade(CadClientesC_CID_CLI.AsString,CadClientesC_EST_CLI.AsString);
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.ERamoAtividadeCadastrar(Sender: TObject);
begin
  FRamoAtividade := TFRamoAtividade.criarSDI(Application,'',FPrincipal.VerificaPermisao('FRamoAtividade'));
  FRamoAtividade.BotaoCadastrar1.Click;
  FRamoAtividade.ShowModal;
  FRamoAtividade.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCliente.ECondicaoPagamentoCadastrar(Sender: TObject);
begin
  FCondicaoPagamento := TFCondicaoPagamento.CriarSDI(application , '', FPrincipal.VerificaPermisao('FCondicaoPagamento'));
  FCondicaoPagamento.ShowModal;
  FCondicaoPagamento.free;
end;

procedure TFNovoCliente.ECondicaoPagamentoSelect(Sender: TObject);
begin
  ECondicaoPagamento.ASelectValida.Text := 'select * from cadcondicoespagto '+
                                       ' where I_Cod_pag = @ ' +
                                       ' and D_VAl_Con >= ' + SQLTextoDataAAAAMMMDD(Date);
  ECondicaoPagamento.ASelectLocaliza.Text := 'select * from cadcondicoespagto '+
                                         ' where c_nom_pag like ''@%''' +
                                         ' and D_VAl_Con >= ' + SQLTextoDataAAAAMMMDD(Date);
 if (puSomenteCondicoesPgtoAutorizadas in varia.PermissoesUsuario) then
 begin
    ECondicaoPagamento.ASelectValida.Text := ECondicaoPagamento.ASelectValida.Text + ' and I_COD_PAG IN '+varia.CodigosCondicaoPagamento;
    ECondicaoPagamento.ASelectLocaliza.Text := ECondicaoPagamento.ASelectLocaliza.Text + ' and I_COD_PAG IN '+varia.CodigosCondicaoPagamento;
 end;
end;

{******************************************************************************}
procedure TFNovoCliente.ETransportadoraCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.CadClientesC_IND_TRA.AsString := 'S';
  FNovoCliente.CadClientesC_IND_CLI.AsString := 'N';
  FNovoCliente.showmodal;
  FNovoCliente.free;
end;

{******************************************************************************}
procedure TFNovoCliente.ETecnicoCadastrar(Sender: TObject);
begin
  FNovoTecnico := TFNovoTecnico.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTecnico'));
  FNovoTecnico.Tecnico.Insert;
  FNovoTecnico.showmodal;
  FNovoTecnico.free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovoCliente.ETipoMateriaPrimaCadastrar(Sender: TObject);
begin
  FTipoMateriaPrima := TFTipoMateriaPrima.criarSDI(Application,'',FPrincipal.VerificaPermisao('FTipoMateriaPrima'));
  FTipoMateriaPrima.BotaoCadastrar1.Click;
  FTipoMateriaPrima.showmodal;
  FTipoMateriaPrima.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCliente.CadClientesAfterScroll(DataSet: TDataSet);
begin
   AtualizaTela;
end;

{******************************************************************************}
procedure TFNovoCliente.DBEditColor10Exit(Sender: TObject);
begin
  if CadClientes.State in [dsedit,dsinsert] then
    CarRegiaoCliente;
end;

procedure TFNovoCliente.DBEditColor111DblClick(Sender: TObject);
Var
  VpfFinalEmail : string;
begin
  if CadClientes.State in [dsedit,dsinsert] then
  begin
    CadClientesC_SEN_ASS.AsString := CadClientesC_EST_CLI.AsString;
    if CadClientesC_END_ELE.AsString <> '' then
    begin
      if not FunEmarketing.EmailDominioProvedores(CadClientesC_END_ELE.AsString) then
      begin
        VpfFinalEmail := DeleteAteChar(CadClientesC_END_ELE.AsString,'@');
        VpfFinalEmail := CopiaAteChar(VpfFinalEmail,'.');
        VpfFinalEmail := Copy(VpfFinalEmail,length(VpfFinalEmail)-3,4);
        CadClientesC_SEN_ASS.AsString := CadClientesC_SEN_ASS.AsString+VpfFinalEmail;
      end
      else
      begin
        VpfFinalEmail := CopiaAteChar(CadClientesC_END_ELE.AsString,'@');
        VpfFinalEmail := Copy(VpfFinalEmail,length(VpfFinalEmail)-3,4);
        CadClientesC_SEN_ASS.AsString := CadClientesC_SEN_ASS.AsString+VpfFinalEmail;
      end
    end;
  end;

end;

{******************************************************************************}
procedure TFNovoCliente.EContaBancariaSelect(Sender: TObject);
begin
  EContaBancaria.ASelectValida.Text := 'Select * from CADCONTAS CON, CADBANCOS BAN '+
                                       ' Where CON.I_EMP_FIL = '+ IntTostr(varia.CodigoEmpfil)+
                                       ' and CON.C_NRO_CON = ''@'''+
                                       ' AND CON.I_COD_BAN = BAN.I_COD_BAN ';
  EContaBancaria.ASelectLocaliza.Text := 'Select * from CADCONTAS CON, CADBANCOS BAN '+
                                       ' Where CON.I_EMP_FIL = '+ IntTostr(varia.CodigoEmpfil)+
                                       ' and CON.C_NOM_CRR LIKE ''@%'''+
                                       ' AND CON.I_COD_BAN = BAN.I_COD_BAN '+
                                       ' order by CON.C_NOM_CRR';
end;

{******************************************************************************}
procedure TFNovoCliente.ETabelaPrecoSelect(Sender: TObject);
begin
  ETabelaPreco.ASelectValida.text := 'Select I_COD_TAB, C_NOM_TAB FROM CADTABELAPRECO '+
                                ' Where I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa) +
                                ' and I_COD_TAB = @';
  ETabelaPreco.ASelectLocaliza.text := 'Select I_COD_TAB, C_NOM_TAB FROM CADTABELAPRECO '+
                                ' Where I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa)+
                                ' and C_NOM_TAB LIKE  ''@%''';
end;

procedure TFNovoCliente.ECidadecobrancaRetorno(Retorno1,
  Retorno2: String);
begin
  if (CadClientes.State in [dsInsert, dsEdit]) then
    if (Retorno1 <> '') then
      CadClientesC_EST_COB.AsString:=Retorno2 // Grava o Estado;
    else
      CadClientesC_EST_COB.Clear;
end;

{******************************************************************************}
procedure TFNovoCliente.EProspectRetorno(Retorno1,
  Retorno2: String);
begin
  VprProspectImportado:= False;
  if EProspect.Text <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'SELECT I_COD_CLI, C_NOM_CLI FROM CADCLIENTES WHERE I_COD_PRC = '+EProspect.Text);
    if Aux.Eof then
    begin
      if Confirmacao('Esta operação fará com que este suspect se torne Prospect e todos os produtos e contatos serão importados para o prospect gerado assim que ele for gravado.'#13+
                     'Tem certeza de que deseja continuar?') then
        ImportaProspect;
    end
    else
      aviso('Este prospect já existe cadastrado para o cliente"'+Aux.FieldByname('I_COD_CLI').AsString+'-'+Aux.FieldByname('C_NOM_CLI').AsString+'"');
    Aux.Close;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.ImportaProspect;
begin
  VprDProspect.Free;
  VprDProspect:= TRBDProspect.cria;
  FunProspect.CarDProspect(VprDProspect,StrToInt(EProspect.Text));

  CadClientesI_COD_CLI.AsInteger:= VprDProspect.CodProspect;
  CadClientesC_NOM_CLI.AsString:= VprDProspect.NomProspect;
  CadClientesD_DAT_CAD.AsDateTime:= Now;
  CadClientesD_DAT_ALT.AsDateTime:= Now;
  CadClientesC_END_CLI.AsString:= VprDProspect.DesEndereco;
  CadClientesI_NUM_END.AsInteger := VprDProspect.NumEndereco;
  CadClientesC_COM_END.AsString := VprDProspect.DesComplementoEndereco;
  CadClientesC_BAI_CLI.AsString:= VprDProspect.DesBairro;
  CadClientesC_FON_RES.AsString:= VprDProspect.DesFone;
  CadClientesC_EST_CLI.AsString:= VprDProspect.DesUF;
  CadClientesC_CID_CLI.AsString:= VprDProspect.DesCidade;
  CadClientesC_REG_CLI.AsString:= VprDProspect.DesRG;
  CadClientesC_CPF_CLI.AsString:= VprDProspect.DesCPF;
  CadClientesC_FO1_CLI.AsString:= VprDProspect.DesFone1;
  CadClientesC_FO2_CLI.AsString:= VprDProspect.DesFone2;
  CadClientesC_END_ELE.AsString := VprDProspect.DesEmailContato;
  CadClientesC_IND_PRC.AsString:= 'S';
  CadClientesC_IND_CLI.AsString:= 'N';
  CadClientesC_CON_CLI.AsString:= VprDProspect.NomContato;
  CadClientesC_FON_FAX.AsString:= VprDProspect.DesFax;
  CadClientesC_CEP_CLI.AsString:= VprDProspect.DesCep;
  CadClientesI_COD_VEN.AsInteger:= VprDProspect.CodVendedor;
  CadClientesC_NOM_FAN.AsString:= VprDProspect.NomFantasia;
  CadClientesC_CGC_CLI.AsString:= VprDProspect.DesCNPJ;
  if VprDProspect.CodRamoAtividade <> 0 then
    CadClientesI_COD_RAM.AsInteger:= VprDProspect.CodRamoAtividade
  else
    CadClientesI_COD_RAM.Clear;
  if VprDProspect.IndAceitaSpam then
    CadClientesC_ACE_SPA.AsString:= 'S'
  else
    CadClientesC_ACE_SPA.AsString:= 'N';
  if VprDProspect.IndAceitaTeleMarketing then
    CadClientesC_ACE_TEL.AsString:= 'S'
  else
    CadClientesC_ACE_TEL.AsString:= 'N';
  if VprDProspect.DatNascimento > montadata(1,1,1900) then
    CadClientesD_DAT_NAS.AsDateTime:= VprDProspect.DatNascimento;
  CadClientesC_OBS_CLI.AsString:= VprDProspect.DesObservacoes;

  ECidade.Atualiza;
  EVendedor.Atualiza;
  ERamoAtividade.Atualiza;
  VprProspectImportado:= True;
end;

{******************************************************************************}
procedure TFNovoCliente.CadClientesAfterPost(DataSet: TDataSet);
var
  VpfResultado : String;
begin
  if CadClientesI_COD_PRC.AsInteger <> 0 then
    if VprProspectImportado then
    // foi criada a variável VprProspectImportado porque não podemos verificar
    // o CadClientes.State = dsInsert, já que este depois do Post vai para dsBrowse
    // então a finalidade desta variável é controlar se o prospect está ou não sendo importado
    // ela inicia como False no FormCreate e depois é alterada no OnRetorno do EProspect
    // de acordo se o prospect foi ou não importado.
    begin
      ImportaProdutosContatosProspect;
    end;

  VpfResultado := FunClientes.GravadProdutoInteresseCliente(CadClientesI_COD_CLI.AsInteger,VprProdutosInteresse);
  if VpfResultado = '' then
  begin
    VpfResultado := FunClientes.GravaDFaixaEtariaCliente(CadClientesI_COD_CLI.AsInteger,VprFaixasEtaria);
    if VpfResultado = '' then
    begin
      VpfResultado := FunClientes.GravaDMarcaCliente(CadClientesI_COD_CLI.AsInteger,VprMarcas);
    end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
  Sistema.MarcaTabelaParaImportar('CADCLIENTES');
  FunClientes.GravaLogCliente(CadClientesI_COD_CLI.AsInteger);
end;

{******************************************************************************}
procedure TFNovoCliente.ImportaProdutosContatosProspect;
var
  VpfResultado: String;
begin
  VpfResultado := FunClientes.ImportaProdutosProspect(CadClientesI_COD_PRC.AsInteger,CadClientesI_COD_CLI.AsInteger);
  if VpfResultado = '' then
  begin
    VpfResultado:= FunClientes.ImportaContatosProspect(CadClientesI_COD_PRC.AsInteger,CadClientesI_COD_CLI.AsInteger);
    if VpfResultado = '' then
    begin
      VpfResultado := FunClientes.ImportaTelemarketingProspect(CadClientesI_COD_PRC.AsInteger,CadClientesI_COD_CLI.AsInteger);
      if VpfResultado = '' then
      begin
        VpfResultado := FunClientes.ImportaVisitaProspect(CadClientesI_COD_PRC.AsInteger,CadClientesI_COD_CLI.AsInteger);
        if VpfResultado = '' then
        begin
          FunClientes.ExcluiSuspect(CadClientesI_COD_PRC.AsInteger);
        end;
      end;
    end;
  end;

  if VpfResultado <> '' then
    aviso(VpfResultado)
end;

{******************************************************************************}
procedure TFNovoCliente.AtualizaTela;
begin
  CPeriodoLigacao.ItemIndex := CadClientesI_PER_TEL.AsInteger;
  CDiaSemana.ItemIndex := CadClientesI_DIA_TEL.AsInteger;
  try
    AtualizaLocalizas(PanelColor1);
  except
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.CamposObrigatorios;
begin
  AlteraCampoObrigatorioDet([EMeioDivulgacao,EVendedorProspect],false);
  if CProspect.Checked then
    AlteraCampoObrigatorioDet([EMeioDivulgacao,EVendedorProspect],true);
  validagravacao.execute;
end;

{******************************************************************************}
procedure TFNovoCliente.AtualizaTelaProspect;
begin
  FunClientes.CarProdutoInteresseCliente(VprProdutosInteresse,CadClientesI_COD_CLI.AsInteger);
  GProdutosInteresse.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoCliente.AtualizaTelaAGZ;
begin
  FunClientes.CarDFaixaEtaria(CadClientesI_COD_CLI.AsInteger,VprFaixasEtaria);
  GFaixaEtaria.CarregaGrade;
  FunClientes.CarDMarca(CadClientesI_COD_CLI.AsInteger,VprMarcas);
  GMarcas.CarregaGrade;
end;

{******************************************************************************}
function TFNovoCliente.ExisteProduto : Boolean;
var
  VpfUM : String;
begin
  if (GProdutosInteresse.Cells[1,GProdutosInteresse.ALinha] <> '') then
  begin
    VprDProInteresse.CodProduto := GProdutosInteresse.Cells[1,GProdutosInteresse.ALinha];
    result := FunProdutos.ExisteProduto(VprDProInteresse.CodProduto,VprDProInteresse.SeqProduto,VprDProInteresse.NomProduto,VpfUM);
    if result then
    begin
      GProdutosInteresse.Cells[1,GProdutosInteresse.ALinha] := VprDProInteresse.CodProduto;
      GProdutosInteresse.Cells[2,GProdutosInteresse.ALinha] := VprDProInteresse.NomProduto;
      VprDProInteresse.QtdProduto := 1;
      GProdutosInteresse.Cells[3,GProdutosInteresse.ALinha] := FormatFloat(varia.MascaraQTd,VprDProInteresse.Qtdproduto);
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoCliente.ExisteFaixaEtaria : Boolean;
begin
  result := false;
  if (GFaixaEtaria.Cells[1,GFaixaEtaria.ALinha] <> '') then
  begin
    result := FunClientes.ExisteFaixaEtaria(StrToInt(GFaixaEtaria.Cells[1,GFaixaEtaria.ALinha]),VprDFaixaEtaria.NomFaixaEtaria);
    if result then
    begin
      GFaixaEtaria.Cells[2,GFaixaEtaria.ALinha] := VprDFaixaEtaria.NomFaixaEtaria;
      VprDFaixaEtaria.CodFaixaEtaria := StrToInt(GFaixaEtaria.Cells[1,GFaixaEtaria.ALinha]);
    end;
  end
end;

{******************************************************************************}
function TFNovoCliente.LocalizaProduto : Boolean;
var
  VpfClaFiscal : String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));

  Result := FlocalizaProduto.LocalizaProduto(VprDProInteresse.SeqProduto,VprDProInteresse.CodProduto,VprDProInteresse.NomProduto,vpfClaFiscal,VpfClaFiscal);
  FlocalizaProduto.free;
  if result then  // se o usuario nao cancelou a consulta
  begin
    GProdutosInteresse.Cells[1,GProdutosInteresse.ALinha] := VprDProInteresse.CodProduto;
    GProdutosInteresse.Cells[2,GProdutosInteresse.ALinha] := VprDProInteresse.NomProduto;
    VprDProInteresse.QtdProduto := 1;
    GProdutosInteresse.Cells[3,GProdutosInteresse.ALinha] := FormatFloat(varia.MascaraQTd,VprDProInteresse.Qtdproduto);
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.EConcorrenteCadastrar(Sender: TObject);
begin
  FNovoConcorrente:= TFNovoConcorrente.CriarSDI(Application,'',True);
  FNovoConcorrente.Concorrente.Insert;
  FNovoConcorrente.ShowModal;
  FNovoConcorrente.Free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovoCliente.DBEditColor40KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key in [' ',',','/','ç','\','ã',':'] then
    key := #0;
end;

{******************************************************************************}
procedure TFNovoCliente.CClienteClick(Sender: TObject);
begin
  if CadClientes.State in [dsInsert, dsEdit] then
  begin
    rep.Visible := CFornecedor.Checked;
    CamposObrigatorios;
    AtualizaIndicadorCliente;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.EMeioDivulgacaoCadastrar(Sender: TObject);
begin
  FMeioDivulgacao := TFMeioDivulgacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMeioDivulgacao'));
  FMeioDivulgacao.BotaoCadastrar1.Click;
  FMeioDivulgacao.ShowModal;
  FMeioDivulgacao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCliente.DBEditColor1Exit(Sender: TObject);
var
  VpfCodCliente : Integer;
begin
  if CadClientes.State in [dsedit,dsinsert] then
  begin
    if (CProspect.Checked) and not(CCliente.Checked) then
    begin
      VpfCodCliente := FunClientes.RCodCliente(CadClientesC_NOM_CLI.AsString);
      if (VpfCodCliente <> 0) and (VpfCodCliente <> CadClientesI_COD_CLI.AsInteger) then
        aviso('CLIENTE JÁ CADASTRADO!!!'#13+'Esse cliente já existe cadastrado com o código '+IntTostr(VpfCodCliente));
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.DBEditPos21Exit(Sender: TObject);
var
  VpfCodCliente : Integer;
begin
  if CadClientes.State in [dsedit,dsinsert] then
  begin
    if (CProspect.Checked) and not(CCliente.Checked) then
    begin
      VpfCodCliente := FunClientes.RCodClientePeloTelefone(CadClientesC_FO1_CLI.AsString);
      if (VpfCodCliente <> 0) and (VpfCodCliente <> CadClientesI_COD_CLI.AsInteger) then
        aviso('CLIENTE JÁ CADASTRADO!!!'#13+'Esse cliente já existe cadastrado com o código '+IntTostr(VpfCodCliente));
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.DBEditPos24Exit(Sender: TObject);
var
  VpfCodCliente : Integer;
begin
  if CadClientes.State in [dsedit,dsinsert] then
  begin
    if (CProspect.Checked) and not(CCliente.Checked) then
    begin
      VpfCodCliente := FunClientes.RCodClientePeloTelefone(CadClientesC_FO2_CLI.AsString);
      if (VpfCodCliente <> 0) and (VpfCodCliente <> CadClientesI_COD_CLI.AsInteger) then
        aviso('CLIENTE JÁ CADASTRADO!!!'#13+'Esse cliente já existe cadastrado com o código '+IntTostr(VpfCodCliente));
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PAdicionais then
    AtualizaLocalizas(PAdicionais)
  else
    if Paginas.activepage = PProspect then
      AtualizaTelaProspect
    else
      if Paginas.ActivePage = PAGZ then
        AtualizaTelaAGZ;
end;

procedure TFNovoCliente.PanelColor17Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoCliente.GProdutosInteresseCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProInteresse:= TRBDProdutoInteresseCliente(VprProdutosInteresse.Items[VpaLinha-1]);
  GProdutosInteresse.Cells[1,VpaLinha]:= VprDProInteresse.CodProduto;
  GProdutosInteresse.Cells[2,VpaLinha]:= VprDProInteresse.NomProduto;
  if VprDProInteresse.QtdProduto <> 0 then
    GProdutosInteresse.Cells[3,VpaLinha]:= FormatFloat(varia.MascaraQtd,VprDProInteresse.QtdProduto)
  else
    GProdutosInteresse.Cells[3,VpaLinha]:= '';
end;

{******************************************************************************}
procedure TFNovoCliente.GProdutosInteresseDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GProdutosInteresse.Cells[1,GProdutosInteresse.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTONAOCADASTRADO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GProdutosInteresse.Col := 1;
    end
    else
      if (GProdutosInteresse.Cells[3,GProdutosInteresse.ALinha] = '') then
      begin
        VpaValidos := false;
        aviso(CT_QTDPRODUTOINVALIDO);
        GProdutosInteresse.Col := 3;
      end;
  if Vpavalidos then
  begin
    VprDProInteresse.QtdProduto := StrToFloat(DeletaChars(GProdutosInteresse.Cells[3,GProdutosInteresse.ALinha],'.'));
    if (VprDProInteresse.QtdProduto = 0)  then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GProdutosInteresse.col :=3;
    end;
    if VpaValidos then
    begin
      if FunClientes.ProdutoInteresseDuplicado(VprProdutosInteresse) then
      begin
        VpaValidos := false;
        aviso('PRODUTO DUPLICADO!!!'#13'Esse produto já foi digitado.');
      end;
    end;
  end;


end;

{******************************************************************************}
procedure TFNovoCliente.GProdutosInteresseKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GProdutosInteresse.AColuna of
        1: LocalizaProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GProdutosInteresseMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprProdutosInteresse.Count >0 then
  begin
    VprDProInteresse := TRBDProdutoInteresseCliente(VprProdutosInteresse.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GProdutosInteresseNovaLinha(Sender: TObject);
begin
  VprDProInteresse := TRBDProdutoInteresseCliente.cria;
  VprProdutosInteresse.add(VprDProInteresse);
end;

{******************************************************************************}
procedure TFNovoCliente.GProdutosInteresseSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutosInteresse.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutosInteresse.AColuna <> ACol then
    begin
      case GProdutosInteresse.AColuna of
        1 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutosInteresse.Cells[1,GProdutosInteresse.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoCliente.BDiretorioClick(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja criar o diretorio?') then
  begin
    if CadClientesC_NOM_FAN.AsString <> '' then
    begin
      NaoExisteCriaDiretorio(varia.PathCliente+'\'+CadClientesC_NOM_FAN.AsString+'\Diversos',false);
      NaoExisteCriaDiretorio(varia.PathCliente+'\'+CadClientesC_NOM_FAN.AsString+'\Fotos',false);
      NaoExisteCriaDiretorio(varia.PathCliente+'\'+CadClientesC_NOM_FAN.AsString+'\Projetos',false);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.EHorarioAtendimentoCadastrar(Sender: TObject);
begin
  FHorarioTrabalho := TFHorarioTrabalho.CriarSDI(self,'',FPrincipal.VerificaPermisao('FHorarioTrabalho'));
  FHorarioTrabalho.BotaoCadastrar1.Click;
  FHorarioTrabalho.showmodal;
  FHorarioTrabalho.free;
end;

{******************************************************************************}
procedure TFNovoCliente.GFaixaEtariaCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFaixaEtaria := TRBDFaixaEtariaCliente(VprFaixasEtaria.Items[VpaLinha-1]);
  if VprDFaixaEtaria.CodFaixaEtaria <> 0 then
    GFaixaEtaria.Cells[1,VpaLinha]:= InttoStr(VprDFaixaEtaria.CodFaixaEtaria)
  else
    GFaixaEtaria.Cells[1,VpaLinha]:= '';
  GFaixaEtaria.Cells[2,VpaLinha]:= VprDFaixaEtaria.NomFaixaEtaria;
end;

{******************************************************************************}
procedure TFNovoCliente.GFaixaEtariaDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteFaixaEtaria then
  begin
    VpaValidos := false;
    aviso('FAIXA ETARIA NÃO CADASTRADA!!!'#13'A faixa etaria digitada não existe cadastrada.');
    GFaixaEtaria.Col := 1;
  end;
  if Vpavalidos then
  begin
    if FunClientes.FaixaEtariaDuplicada(VprFaixasEtaria) then
    begin
      VpaValidos := false;
      aviso('FAIXA ETARIA DUPLICADA!!!'#13'Essa faixa etaria já foi digitada.');
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GFaixaEtariaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GFaixaEtaria.AColuna of
        1: EFaixaEtaria.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GFaixaEtariaMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprFaixasEtaria.Count >0 then
  begin
    VprDFaixaEtaria := TRBDFaixaEtariaCliente(VprFaixasEtaria.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GFaixaEtariaNovaLinha(Sender: TObject);
begin
  VprDFaixaEtaria := TRBDFaixaEtariaCliente.cria;
  VprFaixasEtaria.add(VprDFaixaEtaria);
end;

{******************************************************************************}
procedure TFNovoCliente.GFaixaEtariaSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GFaixaEtaria.AEstadoGrade in [egInsercao,EgEdicao] then
    if GFaixaEtaria.AColuna <> ACol then
    begin
      case GFaixaEtaria.AColuna of
        1 :if not ExisteFaixaEtaria then
           begin
             if not EFaixaEtaria.AAbreLocalizacao then
             begin
               GFaixaEtaria.Cells[1,GFaixaEtaria.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoCliente.EFaixaEtariaCadastrar(Sender: TObject);
begin
  FFaixaEtaria := tFFaixaEtaria.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFaixaEtaria'));
  FFaixaEtaria.BotaoCadastrar1.Click;
  FFaixaEtaria.Showmodal;
  FFaixaEtaria.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCliente.EFaixaEtariaRetorno(Retorno1, Retorno2: String);
begin
  if VprDFaixaEtaria <> nil then
  begin
    if Retorno1 <> ''then
    begin
      VprDFaixaEtaria.CodFaixaEtaria := EFaixaEtaria.AInteiro;
      VprDFaixaEtaria.NomFaixaEtaria := Retorno1;
      GFaixaEtaria.Cells[1,GFaixaEtaria.ALinha] := EFaixaEtaria.Text;
      GFaixaEtaria.Cells[2,GFaixaEtaria.ALinha] := Retorno1;
    end
    else
    begin
      VprDFaixaEtaria.CodFaixaEtaria := 0;
      VprDFaixaEtaria.NomFaixaEtaria := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GMarcasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDMarca := TRBDMarcaCliente(VprMarcas.Items[VpaLinha-1]);
  if VprDMarca.CodMarca <> 0 then
    GMarcas.Cells[1,VpaLinha]:= InttoStr(VprDMarca.CodMarca)
  else
    GMarcas.Cells[1,VpaLinha]:= '';
  GMarcas.Cells[2,VpaLinha]:= VprDMarca.NomMarca;
end;

{******************************************************************************}
procedure TFNovoCliente.GMarcasDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not EMarca.AExisteCodigo(GMarcas.Cells[1,GMarcas.ALinha]) then
  begin
    VpaValidos := false;
    aviso('MARCA NÃO CADASTRADA!!!'#13'A marca digitada não existe cadastrada.');
    GMarcas.Col := 1;
  end;
  if Vpavalidos then
  begin
    if FunClientes.MarcaDuplicada(VprMarcas) then
    begin
      VpaValidos := false;
      aviso('MARCA DUPLICADA!!!'#13'Essa marca já foi digitada.');
    end;
  end;

end;

procedure TFNovoCliente.GMarcasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GMarcas.AColuna of
        1: EMarca.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GMarcasMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprMarcas.Count >0 then
  begin
    VprDMarca := TRBDMarcaCliente(VprMarcas.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.GMarcasNovaLinha(Sender: TObject);
begin
  VprDMarca := TRBDMarcaCliente.cria;
  VprMarcas.add(VprDMarca);
end;

procedure TFNovoCliente.GMarcasSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GMarcas.AEstadoGrade in [egInsercao,EgEdicao] then
    if GMarcas.AColuna <> ACol then
    begin
      case GMarcas.AColuna of
        1 :if not EMarca.AExisteCodigo(GMarcas.Cells[1,GMarcas.ALinha]) then
           begin
             if not EMarca.AAbreLocalizacao then
             begin
               GMarcas.Cells[1,GMarcas.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

procedure TFNovoCliente.EMarcaCadastrar(Sender: TObject);
begin
  FMarca := tFMarca.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMarca'));
  FMarca.BotaoCadastrar1.Click;
  FMarca.Showmodal;
  FMarca.free;
end;

{******************************************************************************}
procedure TFNovoCliente.EMarcaRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDMarca.CodMarca := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDMarca.NomMarca := VpaColunas.items[1].AValorRetorno;
    GMarcas.Cells[1,GMarcas.ALinha] := VpaColunas.items[0].AValorRetorno;
    GMarcas.Cells[2,GMarcas.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDMarca.CodMarca := 0;
    VprDMarca.NomMarca := '';
  end;
end;

{******************************************************************************}
procedure TFNovoCliente.BPlanoClick(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := CadClientesC_CLA_PLA.AsString;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;

{******************************************************************************}
procedure TFNovoCliente.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoCliente]);
end.
