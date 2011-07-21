unit AConfiguracaoFilial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Buttons, StdCtrls, Mask,
  DBCtrls, Tabela, Localizacao, Db, DBTables, ComCtrls, BotaoCadastro, DBClient;

type
  TFConfiguracaoFilial = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    PageControl: TPageControl;
    PCotacao: TTabSheet;
    DataFiliais: TDataSource;
    localiza: TConsultaPadrao;
    CadFiliais: TSQL;
    PProduto: TTabSheet;
    CCondicaoPagamentoCotacao: TDBCheckBox;
    CadFiliaisC_FIN_COT: TWideStringField;
    CodigoTabela: TDBEditLocaliza;
    ETabelaServico: TDBEditLocaliza;
    CadFiliaisI_COD_TAB: TFMTBCDField;
    CadFiliaisI_TAB_SER: TFMTBCDField;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    CadFiliaisI_COD_EMP: TFMTBCDField;
    CExcluiFinaceiroCotacao: TDBCheckBox;
    CadFiliaisC_EXC_FIC: TWideStringField;
    CRegerarFinanceiroQuandoAltera: TDBCheckBox;
    CadFiliaisC_FIN_ACO: TWideStringField;
    PFinanceiro: TTabSheet;
    EContaPadrao: TDBEditLocaliza;
    Label29: TLabel;
    SpeedButton4: TSpeedButton;
    Label38: TLabel;
    CadFiliaisC_CON_BAN: TWideStringField;
    CadFiliaisC_CON_BOL: TWideStringField;
    Label17: TLabel;
    SpeedButton11: TSpeedButton;
    Label18: TLabel;
    EContaBoletoPadrao: TDBEditLocaliza;
    TabSheet1: TTabSheet;
    CEmiteECF: TDBCheckBox;
    CadFiliaisC_IND_ECF: TWideStringField;
    CCorFiscal: TDBCheckBox;
    CadFiliaisC_EST_FIS: TWideStringField;
    PFiscal: TTabSheet;
    CadFiliaisN_PER_ISQ: TFMTBCDField;
    DBEditColor1: TDBEditColor;
    Label5: TLabel;
    PContratos: TTabSheet;
    DBEditLocaliza1: TDBEditLocaliza;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    CadFiliaisC_CON_CON: TWideStringField;
    CadFiliaisN_VAL_CHA: TFMTBCDField;
    CadFiliaisN_VAL_DKM: TFMTBCDField;
    PAssistenciaTecnica: TTabSheet;
    EValChamado: TDBEditNumerico;
    EValKM: TDBEditNumerico;
    Label8: TLabel;
    Label9: TLabel;
    CadFiliaisC_IND_CLA: TWideStringField;
    CUtilizarClassificacao: TDBCheckBox;
    CadFiliaisC_IND_NSU: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    CadFiliaisC_SIM_FED: TWideStringField;
    PCRM: TTabSheet;
    Label10: TLabel;
    DBEditColor2: TDBEditColor;
    DBMemoColor1: TDBMemoColor;
    CadFiliaisC_EMA_COM: TWideStringField;
    CadFiliaisL_ROD_EMA: TWideStringField;
    Label11: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    DBEditColor8: TDBEditColor;
    DBEditColor9: TDBEditColor;
    CadFiliaisC_CRM_CES: TWideStringField;
    CadFiliaisC_CRM_CCL: TWideStringField;
    DBCheckBox3: TDBCheckBox;
    CadFiliaisC_COB_FRM: TWideStringField;
    DBCheckBox4: TDBCheckBox;
    CadFiliaisC_COT_BEC: TWideStringField;
    CadFiliaisC_COT_COM: TWideStringField;
    DBCheckBox5: TDBCheckBox;
    DBEditColor3: TDBEditColor;
    Label12: TLabel;
    CadFiliaisC_SEN_EMC: TWideStringField;
    TabSheet2: TTabSheet;
    CadFiliaisL_OBS_COM: TWideStringField;
    DBMemoColor2: TDBMemoColor;
    Label13: TLabel;
    CadFiliaisC_CAB_EMA: TWideStringField;
    CadFiliaisC_MEI_EMA: TWideStringField;
    DBMemoColor3: TDBMemoColor;
    Label14: TLabel;
    DBMemoColor4: TDBMemoColor;
    Label15: TLabel;
    CadFiliaisN_PER_CSS: TFMTBCDField;
    DBEditColor5: TDBEditColor;
    CadFiliaisC_DIR_ECF: TWideStringField;
    Label19: TLabel;
    PNFE: TTabSheet;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    DBComboBoxColor1: TDBComboBoxColor;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    CadFiliaisC_UFD_NFE: TWideStringField;
    CadFiliaisC_AMH_NFE: TWideStringField;
    CadFiliaisC_MOM_NFE: TWideStringField;
    RDANFE: TDBRadioGroup;
    DBEditColor6: TDBEditColor;
    Label21: TLabel;
    CadFiliaisC_DAN_NFE: TWideStringField;
    CadFiliaisC_CER_NFE: TWideStringField;
    CadFiliaisC_IND_NFE: TWideStringField;
    DBCheckBox8: TDBCheckBox;
    ENotaPAdrao: TDBEditLocaliza;
    Label23: TLabel;
    SpeedButton5: TSpeedButton;
    Label24: TLabel;
    DBMemoColor5: TDBMemoColor;
    Label25: TLabel;
    CadFiliaisC_DAD_ADI: TWideStringField;
    CadFiliaisC_TEX_RED: TWideStringField;
    DBMemoColor6: TDBMemoColor;
    Label26: TLabel;
    DBEditColor10: TDBEditColor;
    Label27: TLabel;
    DBEditColor11: TDBEditColor;
    Label28: TLabel;
    CadFiliaisC_SER_NOT: TWideStringField;
    CadFiliaisC_SER_SER: TWideStringField;
    PanelColor2: TPanelColor;
    DBCheckBox1: TDBCheckBox;
    Label16: TLabel;
    DBEditColor4: TDBEditColor;
    CadFiliaisI_DOC_NOT: TFMTBCDField;
    DBCheckBox10: TDBCheckBox;
    CadFiliaisC_NOT_CON: TWideStringField;
    PSpedFiscal: TTabSheet;
    PanelColor3: TPanelColor;
    Label22: TLabel;
    EPerfilSped: TDBComboBoxColor;
    Label30: TLabel;
    EIndicadorAtividadeSped: TComboBoxColor;
    CadFiliaisC_PER_SPE: TWideStringField;
    CadFiliaisI_ATI_SPE: TFMTBCDField;
    CadFiliaisI_CON_SPE: TFMTBCDField;
    CadFiliaisC_CPC_SPE: TWideStringField;
    CadFiliaisC_CRC_SPE: TWideStringField;
    Label31: TLabel;
    EContabilidade: TDBEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label32: TLabel;
    CadFiliaisC_NCO_SPE: TWideStringField;
    DBEditColor7: TDBEditColor;
    Label33: TLabel;
    DBEditCPF1: TDBEditCPF;
    Label34: TLabel;
    DBEditColor12: TDBEditColor;
    Label35: TLabel;
    DBCheckBox9: TDBCheckBox;
    CadFiliaisC_IND_SPE: TWideStringField;
    CadFiliaisN_PER_COF: TFMTBCDField;
    CadFiliaisN_PER_PIS: TFMTBCDField;
    CadFiliaisC_CST_IPI: TWideStringField;
    Label36: TLabel;
    DBEditColor13: TDBEditColor;
    Label37: TLabel;
    DBEditColor14: TDBEditColor;
    DBEditColor15: TDBEditColor;
    Label39: TLabel;
    CadFiliaisD_ULT_ALT: TSQLTimeStampField;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    PanelColor10: TPanelColor;
    PanelColor11: TPanelColor;
    PanelColor12: TPanelColor;
    PanelColor13: TPanelColor;
    CadFiliaisC_EMA_NFE: TWideStringField;
    Label40: TLabel;
    DBEditColor16: TDBEditColor;
    CadFiliaisC_COD_REC: TWideStringField;
    CadFiliaisI_DIA_VIC: TFMTBCDField;
    Label41: TLabel;
    DBEditColor17: TDBEditColor;
    Label42: TLabel;
    DBEditColor18: TDBEditColor;
    CadFiliaisC_COT_CSP: TWideStringField;
    DBCheckBox16: TDBCheckBox;
    CadFiliaisC_DES_IPI: TWideStringField;
    DBCheckBox11: TDBCheckBox;
    Label43: TLabel;
    DBEditColor19: TDBEditColor;
    CadFiliaisC_COP_ENF: TWideStringField;
    DBCheckBox12: TDBCheckBox;
    CadFiliaisI_EMP_FIL: TFMTBCDField;
    CadFiliaisI_COD_FIL: TFMTBCDField;
    CadFiliaisC_NOM_FIL: TWideStringField;
    CadFiliaisC_END_FIL: TWideStringField;
    CadFiliaisI_NUM_FIL: TFMTBCDField;
    CadFiliaisC_BAI_FIL: TWideStringField;
    CadFiliaisC_CID_FIL: TWideStringField;
    CadFiliaisC_EST_FIL: TWideStringField;
    CadFiliaisI_CEP_FIL: TFMTBCDField;
    CadFiliaisC_CGC_FIL: TWideStringField;
    CadFiliaisC_INS_FIL: TWideStringField;
    CadFiliaisC_GER_FIL: TWideStringField;
    CadFiliaisC_DIR_FIL: TWideStringField;
    CadFiliaisC_FON_FIL: TWideStringField;
    CadFiliaisC_FAX_FIL: TWideStringField;
    CadFiliaisC_OBS_FIL: TWideStringField;
    CadFiliaisD_DAT_MOV: TSQLTimeStampField;
    CadFiliaisC_WWW_FIL: TWideStringField;
    CadFiliaisC_END_ELE: TWideStringField;
    CadFiliaisD_DAT_INI_ATI: TSQLTimeStampField;
    CadFiliaisD_DAT_FIM_ATI: TSQLTimeStampField;
    CadFiliaisC_NOM_FAN: TWideStringField;
    CadFiliaisC_PIC_CLA: TWideStringField;
    CadFiliaisC_PIC_PRO: TWideStringField;
    CadFiliaisCOD_CIDADE: TFMTBCDField;
    CadFiliaisC_CEP_FIL: TWideStringField;
    CadFiliaisC_NOT_PAD: TFMTBCDField;
    CadFiliaisD_ULT_FEC: TSQLTimeStampField;
    CadFiliaisI_SEQ_ROM: TFMTBCDField;
    CadFiliaisC_JUN_COM: TWideStringField;
    CadFiliaisC_CPF_RES: TWideStringField;
    CadFiliaisI_NRO_NSU: TFMTBCDField;
    CadFiliaisD_DAT_SNG: TSQLTimeStampField;
    CadFiliaisI_COD_FIS: TFMTBCDField;
    CadFiliaisC_COD_CNA: TWideStringField;
    CadFiliaisC_INS_MUN: TWideStringField;
    CadFiliaisI_ULT_PED: TFMTBCDField;
    CadFiliaisI_ULT_SEN: TFMTBCDField;
    CadFiliaisC_MEN_BOL: TWideStringField;
    Label44: TLabel;
    DBEditColor20: TDBEditColor;
    CadFiliaisI_ULT_REC: TFMTBCDField;
    CadFiliaisI_ULT_COM: TFMTBCDField;
    CadFiliaisD_DAT_CER: TSQLTimeStampField;
    DBRadioGroup1: TDBRadioGroup;
    CadFiliaisC_MOT_NFE: TWideStringField;
    ScrollBox1: TScrollBox;
    Label45: TLabel;
    DBEditColor21: TDBEditColor;
    CadFiliaisC_END_COT: TWideStringField;
    DBCheckBox13: TDBCheckBox;
    CadFiliaisC_ROM_ABE: TWideStringField;
    DBCheckBox14: TDBCheckBox;
    CadFiliaisC_CRM_EPC: TWideStringField;
    Label46: TLabel;
    DBEditColor22: TDBEditColor;
    Label47: TLabel;
    DBEditColor23: TDBEditColor;
    Label48: TLabel;
    DBEditColor24: TDBEditColor;
    Label49: TLabel;
    DBEditColor25: TDBEditColor;
    Label50: TLabel;
    DBEditColor26: TDBEditColor;
    CadFiliaisC_CST_IPE: TWideStringField;
    CadFiliaisC_CST_PIS: TWideStringField;
    CadFiliaisC_CST_PIE: TWideStringField;
    CadFiliaisC_CST_COS: TWideStringField;
    CadFiliaisC_CST_COE: TWideStringField;
    DBEditColor27: TDBEditColor;
    Label100: TLabel;
    CadFiliaisD_ULT_RPS: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FecharClick(Sender: TObject);
    procedure CodigoTabelaSelect(Sender: TObject);
    procedure ETabelaServicoSelect(Sender: TObject);
    procedure EContaPadraoSelect(Sender: TObject);
    procedure EIndicadorAtividadeSpedClick(Sender: TObject);
    procedure CadFiliaisAfterPost(DataSet: TDataSet);
    procedure CadFiliaisBeforePost(DataSet: TDataSet);
    procedure PanelColor5Click(Sender: TObject);
    procedure DBEditColor7Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfiguracaoFilial: TFConfiguracaoFilial;

implementation

uses APrincipal, FunSql, Constantes,funobjeto, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConfiguracaoFilial.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AdicionaSQLAbreTabela(CadFiliais,'Select * from CADFILIAIS '+
                                    ' Where I_EMP_FIL = '+ IntToStr(varia.CodigoEmpFil));
  PageControl.ActivePageIndex := 0;
  EIndicadorAtividadeSped.ItemIndex := Varia.TipoAtividadeSped;

  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'T','F');
  AtualizaLocalizas([ETabelaServico,CodigoTabela,EContaPadrao,EContaBoletoPadrao,EContabilidade]);
end;

procedure TFConfiguracaoFilial.PanelColor5Click(Sender: TObject);
begin

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfiguracaoFilial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CadFiliais.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFConfiguracaoFilial.FecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConfiguracaoFilial.CadFiliaisAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADFILIAIS');
end;

{******************************************************************************}
procedure TFConfiguracaoFilial.CadFiliaisBeforePost(DataSet: TDataSet);
begin
  CadFiliaisD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFConfiguracaoFilial.CodigoTabelaSelect(Sender: TObject);
begin
  CodigoTabela.ASelectValida.Clear;
  CodigoTabela.ASelectValida.Add(' select I_cod_tab, c_nom_tab  from cadtabelapreco ' +
                                  ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                  ' and i_cod_tab = @' );
  CodigoTabela.ASelectLocaliza.Clear;
  CodigoTabela.ASelectLocaliza.Add(' select I_cod_tab, c_nom_tab  from cadtabelapreco '+
                                    ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                    ' and i_cod_tab like ''@%''');
end;

procedure TFConfiguracaoFilial.DBEditColor7Change(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFConfiguracaoFilial.ETabelaServicoSelect(Sender: TObject);
begin
  ETabelaServico.ASelectValida.Clear;
  ETabelaServico.ASelectValida.Add(' select I_cod_tab, c_nom_tab  from cadtabelapreco ' +
                                  ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                  ' and i_cod_tab = @' );
  ETabelaServico.ASelectLocaliza.Clear;
  ETabelaServico.ASelectLocaliza.Add(' select I_cod_tab, c_nom_tab from cadtabelapreco '+
                                    ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                    ' and i_cod_tab like ''@%''');
end;

{******************************************************************************}
procedure TFConfiguracaoFilial.EContaPadraoSelect(Sender: TObject);
begin

  TDBEditLocaliza(sender).ASelectLocaliza.Text := 'Select * from cadbancos Ban, CadContas Co'+
                                       ' where  Ban.I_COD_BAN = Co.I_COD_BAN  '+
//                                       ' and CO.I_EMP_FIL = '+IntTostr(varia.CodigoempFil)+
                                       ' and Co.C_NRO_CON like ''@%'''+
                                       ' AND CO.C_IND_ATI = ''T''';
  TDBEditLocaliza(sender).ASelectValida.Text := 'Select * from cadbancos Ban, CadContas Co'+
                                       ' where  Ban.I_COD_BAN = Co.I_COD_BAN  '+
//                                       ' and CO.I_EMP_FIL = '+IntTostr(varia.CodigoempFil)+
                                       ' and Co.C_NRO_CON = ''@'''+
                                       ' AND CO.C_IND_ATI = ''T''';
end;

{******************************************************************************}
procedure TFConfiguracaoFilial.EIndicadorAtividadeSpedClick(Sender: TObject);
begin
  IF CadFiliais.State in [dsedit,dsinsert] then
  begin
    Varia.TipoAtividadeSped := EIndicadorAtividadeSped.ItemIndex;
    CadFiliaisI_ATI_SPE.AsInteger := Varia.TipoAtividadeSped;
  end
  else
    EIndicadorAtividadeSped.ItemIndex := Varia.TipoAtividadeSped;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConfiguracaoFilial]);
end.
