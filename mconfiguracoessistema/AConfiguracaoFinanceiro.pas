unit AConfiguracaoFinanceiro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formularios,  BotaoCadastro, Buttons, Componentes1, constantes,
  LabelCorMove, PainelGradiente,
  Localizacao, Db, DBTables, Mask, Tabela, DBCtrls, StdCtrls, ComCtrls,
  ExtCtrls, Grids, DBGrids, DBClient;

type
  TFConfiguracoesFinanceiro = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    localiza: TConsultaPadrao;
    kk0y: TPageControl;
    TabSheet7: TTabSheet;
    Label33: TLabel;
    Label37: TLabel;
    SpeedButton5: TSpeedButton;
    DBEditLocaliza5: TDBEditLocaliza;
    DBEditNumerico7: TDBEditNumerico;
    Label52: TLabel;
    TabSheet1: TTabSheet;
    DataCFG: TDataSource;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    ECondPagamento: TDBEditLocaliza;
    Label3: TLabel;
    TabSheet2: TTabSheet;
    DBRadioGroup2: TDBRadioGroup;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    Label25: TLabel;
    DBEditNumerico4: TDBEditNumerico;
    DBEditNumerico5: TDBEditNumerico;
    DBEditNumerico6: TDBEditNumerico;
    Label20: TLabel;
    EformaPgto: TDBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label28: TLabel;
    Label12: TLabel;
    EClienteFornecedor: TDBEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label16: TLabel;
    Label8: TLabel;
    SpeedButton8: TSpeedButton;
    Label9: TLabel;
    EFormaPagamentoCarteira: TDBEditLocaliza;
    CFilialControladora: TDBCheckBox;
    EFilialControladora: TDBEditLocaliza;
    LFilialControladora: TLabel;
    BFilialControladora: TSpeedButton;
    Label11: TLabel;
    ETipoBoleto: TComboBoxColor;
    Label10: TLabel;
    EReciboPadrao: TDBEditLocaliza;
    Label1: TLabel;
    SpeedButton9: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    SpeedButton10: TSpeedButton;
    Label15: TLabel;
    EFormapagamentoDinheiro: TDBEditLocaliza;
    Label17: TLabel;
    SpeedButton4: TSpeedButton;
    Label18: TLabel;
    TabSheet4: TTabSheet;
    Label19: TLabel;
    EHistoricoNaoLigado: TDBEditLocaliza;
    SpeedButton11: TSpeedButton;
    Label23: TLabel;
    Label24: TLabel;
    DBEditLocaliza3: TDBEditLocaliza;
    SpeedButton12: TSpeedButton;
    Label26: TLabel;
    PECobranca: TTabSheet;
    Label27: TLabel;
    CFG: TSQL;
    DBMemoColor1: TDBMemoColor;
    CFGN_PER_MUL: TFMTBCDField;
    CFGN_PER_JUR: TFMTBCDField;
    CFGN_PER_MOR: TFMTBCDField;
    CFGC_CAP_LOT: TWideStringField;
    CFGC_BAI_CHE: TWideStringField;
    CFGC_BAI_COP: TWideStringField;
    CFGI_CHE_PRE: TFMTBCDField;
    CFGC_DAT_INV: TWideStringField;
    CFGC_IND_MOE: TWideStringField;
    CFGC_PAR_ANT: TWideStringField;
    CFGC_DAT_BAI: TWideStringField;
    CFGC_DAT_VEN: TWideStringField;
    CFGC_JUR_ATU: TWideStringField;
    CFGC_COM_DIR: TWideStringField;
    CFGC_NRO_DUP: TWideStringField;
    CFGC_PER_PAR: TWideStringField;
    CFGC_DES_FIX: TWideStringField;
    CFGI_DIA_PTS: TFMTBCDField;
    CFGFLA_VARIOS_GERAIS: TWideStringField;
    CFGFLA_LOG_DIRETO: TWideStringField;
    CFGVAL_TOLERANCIA: TFMTBCDField;
    CFGCOD_OPERACAO_PADRAO_RECEBER: TFMTBCDField;
    CFGCOD_OPERACAO_PADRAO_PAGAR: TFMTBCDField;
    CFGD_ATU_DES: TSQLTimeStampField;
    CFGC_FLA_ATD: TWideStringField;
    CFGI_COD_PAG: TFMTBCDField;
    CFGC_FLA_BAN: TWideStringField;
    CFGC_FLA_CAX: TWideStringField;
    CFGC_BAI_COR: TWideStringField;
    CFGC_NRO_DOC: TWideStringField;
    CFGC_CON_GER: TWideStringField;
    CFGI_FRM_PAD: TFMTBCDField;
    CFGi_ser_tes: TFMTBCDField;
    CFGI_CLI_BAN: TFMTBCDField;
    CFGC_SEN_CAI: TWideStringField;
    CFGC_SEN_ALT: TWideStringField;
    CFGC_SEN_EST: TWideStringField;
    CFGC_PAR_DAT: TWideStringField;
    CFGC_ITE_DAT: TWideStringField;
    CFGI_FRM_CAR: TFMTBCDField;
    CFGI_FIL_CON: TFMTBCDField;
    CFGC_FIL_CON: TWideStringField;
    CFGC_LIM_CRE: TWideStringField;
    CFGC_BLO_CAT: TWideStringField;
    CFGC_TIP_BOL: TWideStringField;
    CFGI_REC_PAD: TFMTBCDField;
    CFGI_FRM_BOL: TFMTBCDField;
    CFGI_FRM_DIN: TFMTBCDField;
    CFGI_HIS_NLI: TFMTBCDField;
    CFGI_FRM_DEP: TFMTBCDField;
    CFGC_ROD_ECO: TWideStringField;
    CFGC_EMA_ECO: TWideStringField;
    DBEditColor1: TDBEditColor;
    Label29: TLabel;
    CFGC_REM_AUT: TWideStringField;
    CFGC_ECO_VAC: TWideStringField;
    CFGC_ECO_AVP: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    ScrollBox1: TScrollBox;
    FaltaIndice: TDBCheckBox;
    DataInvalida: TDBCheckBox;
    BaixaMovbancario: TDBCheckBox;
    BaixaContasapagar: TDBCheckBox;
    BaixaParcela: TDBCheckBox;
    DataVencimento: TDBCheckBox;
    DataBaixa: TDBCheckBox;
    MultaJuro: TDBCheckBox;
    ComissaoDireta: TDBCheckBox;
    NumeroDuplicata: TDBCheckBox;
    CapaLote: TDBCheckBox;
    PermitirParcial: TDBCheckBox;
    DespesasFixas: TDBCheckBox;
    AtualizarDespesas: TDBCheckBox;
    CLancaCaixa: TDBCheckBox;
    CConfirmaBancaria: TDBCheckBox;
    BaixaContasAReceber: TDBCheckBox;
    NumeroDocumento: TDBCheckBox;
    CLimiteCredito: TDBCheckBox;
    CBloquearCliente: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    CFGC_SAL_DAB: TWideStringField;
    DBCheckBox5: TDBCheckBox;
    CFGC_ECO_APE: TWideStringField;
    CFGC_CON_PAD: TWideStringField;
    Label30: TLabel;
    ETipoComissao: TComboBoxColor;
    CFGI_TIP_COM: TFMTBCDField;
    DBCheckBox6: TDBCheckBox;
    CFGC_JUR_AUT: TWideStringField;
    DBCheckBox7: TDBCheckBox;
    CFGC_IMB_AAR: TWideStringField;
    CFGC_EMA_DCO: TWideStringField;
    DBCheckBox8: TDBCheckBox;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    DBEditLocaliza4: TDBEditLocaliza;
    CFGI_FRM_CRE: TFMTBCDField;
    DBRadioGroup1: TDBRadioGroup;
    CFGI_TIP_VCO: TFMTBCDField;
    CFGC_CON_PRO: TWideStringField;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    CFGC_DEB_CRE: TWideStringField;
    PanelColor2: TPanelColor;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    DBEditLocaliza1: TDBEditLocaliza;
    CFGI_CON_PAD: TFMTBCDField;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    DBCheckBox11: TDBCheckBox;
    CFGC_IND_TEF: TWideStringField;
    DBCheckBox12: TDBCheckBox;
    CFGC_IMP_CHE: TWideStringField;
    DBCheckBox13: TDBCheckBox;
    CFGC_BOL_NOT: TWideStringField;
    DBCheckBox14: TDBCheckBox;
    CFGC_CLI_BLO: TWideStringField;
    Label31: TLabel;
    DBEditNumerico1: TDBEditNumerico;
    CFGI_QTD_VEN: TFMTBCDField;
    DBCheckBox15: TDBCheckBox;
    CFGC_CON_FIL: TWideStringField;
    CFGC_BCA_FIL: TWideStringField;
    DBCheckBox16: TDBCheckBox;
    CFGC_SOM_URC: TWideStringField;
    DBCheckBox17: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CFGAfterPost(DataSet: TDataSet);
    procedure FecharClick(Sender: TObject);
    procedure CFGAfterScroll(DataSet: TDataSet);
    procedure CadEmpresaAfterCancel(DataSet: TDataSet);
    procedure ECondPagamentoSelect(Sender: TObject);
    procedure DBEditNumerico5Exit(Sender: TObject);
    procedure DBEditNumerico6Exit(Sender: TObject);
    procedure EFilialControladoraSelect(Sender: TObject);
    procedure CFilialControladoraClick(Sender: TObject);
    procedure ETipoBoletoChange(Sender: TObject);
    procedure ETipoComissaoChange(Sender: TObject);
    procedure CFGAfterEdit(DataSet: TDataSet);
    procedure CFGAfterCancel(DataSet: TDataSet);
    procedure PainelGradiente1Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FConfiguracoesFinanceiro: TFConfiguracoesFinanceiro;

implementation

uses APrincipal, funObjeto, funsql, constmsg, FUNDATA;

{$R *.DFM}

{ ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Modulo Básico
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ******************* Na Criacao do formulario ****************************** }
procedure TFConfiguracoesFinanceiro.FormCreate(Sender: TObject);
begin
  kk0y.ActivePage := TabSheet7;
   CFG.open;
   InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'T','F');
   ETipoComissao.ItemIndex := varia.TipComissao;
   CFilialControladoraClick(cfilialcontroladora);
   EFilialControladora.Atualiza;
   if CFGC_TIP_BOL.AsString = 'B' then
     ETipoBoleto.ItemIndex := 0
   else
     if CFGC_TIP_BOL.AsString = 'P' then
       ETipoBoleto.ItemIndex := 1;

end;

procedure TFConfiguracoesFinanceiro.PainelGradiente1Click(Sender: TObject);
begin

end;

{ ******************* No fechamento do formulário **************************** }
procedure TFConfiguracoesFinanceiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    FechaTabela(CFG);
    Action := cafree;
end;

{ *************** fecha o formulario *************************************** }
procedure TFConfiguracoesFinanceiro.FecharClick(Sender: TObject);
begin
  Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              configurações de Inicialização do Sistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******************* Apos Gravar as alterações na tabela CFG **************** }
procedure TFConfiguracoesFinanceiro.CFGAfterPost(DataSet: TDataSet);
begin
   CarregaCFG(FPrincipal.BaseDados);
  FPrincipal.AlteraNomeEmpresa;
  AlterarEnabledDet([ETipoComissao,ETipoBoleto],false);
end;


{ (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Financeiro
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{*****************Chama a rotina para atualizar os localizas*******************}
procedure TFConfiguracoesFinanceiro.CFGAfterScroll(DataSet: TDataSet);
begin
   AtualizaLocalizas(PanelColor1);
   AlterarEnabledDet([ETipoComissao,ETipoBoleto],false);
end;

procedure TFConfiguracoesFinanceiro.CadEmpresaAfterCancel(
  DataSet: TDataSet);
begin
if not BotaoAlterar1.Visible then
  AlterarVisible([BotaoAlterar1,BotaoGravar1,BotaoCancelar1, Fechar]);
end;

procedure TFConfiguracoesFinanceiro.ECondPagamentoSelect(Sender: TObject);
begin
  ECondPagamento.ASelectValida.Clear;
  ECondPagamento.ASelectValida.Add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From CadCondicoesPagto ' +
                                   ' where I_Cod_Pag = @ ' );
  ECondPagamento.ASelectLocaliza.Clear;
  ECondPagamento.ASelectLocaliza.add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From CadCondicoesPagto ' +
                                     ' where c_Nom_Pag like ''@%'''+
                                     ' order by c_Nom_Pag asc');
end;

procedure TFConfiguracoesFinanceiro.DBEditNumerico5Exit(Sender: TObject);
begin
  if CFG.State in [ dsEdit, dsInsert ] then
    if CFGN_PER_MOr.AsCurrency <> 0 then
      CFGN_PER_JUR.AsCurrency := 0;
end;

procedure TFConfiguracoesFinanceiro.DBEditNumerico6Exit(Sender: TObject);
begin
 if CFG.State in [ dsEdit, dsInsert ] then
    if CFGN_PER_JUR.AsCurrency <> 0 then
      CFGN_PER_MOR.AsCurrency := 0;
end;

procedure TFConfiguracoesFinanceiro.EFilialControladoraSelect(Sender: TObject);
begin
  EFilialControladora.ASelectValida.Clear;
  EFilialControladora.ASelectValida.Add('select * from CadFiliais where I_COD_EMP = ' + IntToStr(Varia.codigoEmpresa) +
                                ' and I_EMP_FIL = @');
  EFilialControladora.ASelectLocaliza.Clear;
  EFilialControladora.ASelectLocaliza.Add('select * from CadFiliais where I_COD_EMP = ' + IntToStr(Varia.codigoEmpresa) +
                                  ' and C_NOM_FIL like ''@%''');
end;

{*********************** altera a filial controladora *************************}
procedure TFConfiguracoesFinanceiro.CFilialControladoraClick(
  Sender: TObject);
begin
  AlterarEnabledDet([EFilialControladora,LFilialControladora,BFilialControladora],CFilialControladora.Checked);
end;

{******************************************************************************}
procedure TFConfiguracoesFinanceiro.ETipoBoletoChange(Sender: TObject);
begin
  if CFG.state = dsedit then
    case ETipoBoleto.ItemIndex of
      0 : CFGC_TIP_BOL.AsString := 'B';
      1 : CFGC_TIP_BOL.AsString := 'P';
    end;
end;

{******************************************************************************}
procedure TFConfiguracoesFinanceiro.ETipoComissaoChange(Sender: TObject);
begin
  if CFG.state = dsedit then
    CFGI_TIP_COM.AsInteger := ETipoComissao.ItemIndex;
end;

{******************************************************************************}
procedure TFConfiguracoesFinanceiro.CFGAfterEdit(DataSet: TDataSet);
begin
  AlterarEnabledDet([ETipoComissao,ETipoBoleto],true);
end;

{******************************************************************************}
procedure TFConfiguracoesFinanceiro.CFGAfterCancel(DataSet: TDataSet);
begin
  AlterarEnabledDet([ETipoComissao,ETipoBoleto],false);
end;

Initialization
{*****************Registra a Classe para Evitar duplicidade********************}
   RegisterClasses([TFConfiguracoesFinanceiro]);
end.
