unit AConfiguracaoProdutos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, formularios, constMsg, DBCtrls, Tabela,
  Mask, Db, DBTables, BotaoCadastro, Buttons, Componentes1, constantes,
  ColorGrd, LabelCorMove,  Grids, DBGrids, Registry, PainelGradiente,
  FileCtrl,printers, Localizacao, UnClassificacao, DBClient;

type
  TFConfiguracoesProdutos = class(TFormularioPermissao)
    CFG: TSQL;
    DataCFG: TDataSource;
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    kk0y: TPageControl;
    PGeral: TTabSheet;
    Label7: TLabel;
    Label8: TLabel;
    DBEditColor12: TDBEditColor;
    DBEditColor13: TDBEditColor;
    Label9: TLabel;
    DBEditNumerico1: TDBEditNumerico;
    TabSheet1: TTabSheet;
    CFGC_QTD_EST: TWideStringField;
    CFGC_QTD_MIN: TWideStringField;
    CFGI_EST_NEG: TFMTBCDField;
    CFGC_VER_PRO: TWideStringField;
    CFGC_MAS_PRO: TWideStringField;
    CFGI_DIA_ORC: TFMTBCDField;
    CFGC_UNI_PEC: TWideStringField;
    CFGC_UNI_CAX: TWideStringField;
    CFGC_COD_UNI: TWideStringField;
    ConsultaPadrao1: TConsultaPadrao;
    CFGC_ENT_REP: TWideStringField;
    DBEditLocaliza1: TDBEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    CFGI_OPE_INI: TFMTBCDField;
    DBEditNumerico2: TDBEditNumerico;
    Label3: TLabel;
    CFGC_CLA_FIS: TWideStringField;
    CFGI_MES_EST: TFMTBCDField;
    CFGI_ANO_EST: TFMTBCDField;
    CFGC_FLA_IPI: TWideStringField;
    PEstoque: TTabSheet;
    Label12: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    DBEditLocaliza3: TDBEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label15: TLabel;
    CFGI_INV_ENT: TFMTBCDField;
    CFGI_INV_SAI: TFMTBCDField;
    CFGC_IND_ETI: TWideStringField;
    TabSheet4: TTabSheet;
    CFGCODEST: TFMTBCDField;
    CFGC_IND_CAR: TWideStringField;
    CFGC_EST_COR: TWideStringField;
    POrcamento: TTabSheet;
    CFGI_TIP_ORC: TFMTBCDField;
    ETipoCotacao: TDBEditLocaliza;
    Label18: TLabel;
    SpeedButton5: TSpeedButton;
    Label20: TLabel;
    CFGC_PRC_AUT: TWideStringField;
    CFGC_EXI_DAP: TWideStringField;
    CFGC_EXC_CNF: TWideStringField;
    CFGI_OPE_ESA: TFMTBCDField;
    CFGI_OPE_EEN: TFMTBCDField;
    Label21: TLabel;
    SpeedButton6: TSpeedButton;
    Label22: TLabel;
    Label23: TLabel;
    SpeedButton7: TSpeedButton;
    Label24: TLabel;
    DBEditLocaliza5: TDBEditLocaliza;
    DBEditLocaliza6: TDBEditLocaliza;
    CFGC_DES_ICO: TWideStringField;
    Label4: TLabel;
    SpeedButton8: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton9: TSpeedButton;
    Label19: TLabel;
    DBEditLocaliza7: TDBEditLocaliza;
    DBEditLocaliza8: TDBEditLocaliza;
    CFGI_OPE_EXE: TFMTBCDField;
    CFGI_OPE_EXS: TFMTBCDField;
    Label10: TLabel;
    Label11: TLabel;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    CEstoqueCentralizado: TDBCheckBox;
    CFGC_EST_CEN: TWideStringField;
    CFGI_FIL_EST: TFMTBCDField;
    SFilialControladora: TSpeedButton;
    LFilialControladora: TLabel;
    LFilControladora: TLabel;
    EFilControladora: TDBEditLocaliza;
    CFGI_EST_FIN: TFMTBCDField;
    CFGC_SER_PRO: TWideStringField;
    DBEditLocaliza10: TDBEditLocaliza;
    Label27: TLabel;
    SpeedButton11: TSpeedButton;
    Label28: TLabel;
    Label29: TLabel;
    ETipoCotacaoGarantia: TDBEditLocaliza;
    SpeedButton12: TSpeedButton;
    Label30: TLabel;
    CFGI_ORC_FPO: TFMTBCDField;
    CFGI_ORC_CON: TFMTBCDField;
    CFGI_EST_ALM: TFMTBCDField;
    CFGI_COD_TRA: TFMTBCDField;
    SpeedButton14: TSpeedButton;
    Label33: TLabel;
    DBEditLocaliza13: TDBEditLocaliza;
    Label34: TLabel;
    DBEditLocaliza14: TDBEditLocaliza;
    Label35: TLabel;
    SpeedButton15: TSpeedButton;
    Label36: TLabel;
    CFGI_EST_ALT: TFMTBCDField;
    CFGC_IND_BRI: TWideStringField;
    CBrindeProduto: TDBCheckBox;
    CFGI_ORC_GAR: TFMTBCDField;
    CFGC_ALT_DPR: TWideStringField;
    Label39: TLabel;
    DBEditLocaliza11: TDBEditLocaliza;
    SpeedButton17: TSpeedButton;
    Label40: TLabel;
    CFGI_ORC_REV: TFMTBCDField;
    CFGI_EST_AST: TFMTBCDField;
    CFGC_CLA_MAP: TWideStringField;
    CFGC_CLA_PRO: TWideStringField;
    EClaProduto: TDBEditColor;
    Label43: TLabel;
    SpeedButton19: TSpeedButton;
    LClaProduto: TLabel;
    EClaMateriaPrima: TDBEditColor;
    SpeedButton20: TSpeedButton;
    LClaMateriaPrima: TLabel;
    Label46: TLabel;
    CFGI_EST_CFI: TFMTBCDField;
    CFGI_EST_CFA: TFMTBCDField;
    CFGI_FAT_PEN: TFMTBCDField;
    Label49: TLabel;
    SpeedButton23: TSpeedButton;
    Label50: TLabel;
    DBEditLocaliza19: TDBEditLocaliza;
    CFGC_VCO_FRE: TWideStringField;
    CFGI_EST_CAA: TFMTBCDField;
    CFGI_EST_FAC: TFMTBCDField;
    CFGI_EST_RFA: TFMTBCDField;
    CFGI_EST_AEN: TFMTBCDField;
    CFGI_EST_NEN: TFMTBCDField;
    PEtiquetas: TTabSheet;
    Label61: TLabel;
    EEtiquetaNotaEntrada: TComboBoxColor;
    CFGI_MOD_ENE: TFMTBCDField;
    Label62: TLabel;
    SpeedButton29: TSpeedButton;
    Label63: TLabel;
    DBEditLocaliza25: TDBEditLocaliza;
    CFGI_ORC_PED: TFMTBCDField;
    ScrollBox1: TScrollBox;
    PanelColor2: TPanelColor;
    Label16: TLabel;
    SpeedButton4: TSpeedButton;
    Label17: TLabel;
    Label25: TLabel;
    SpeedButton10: TSpeedButton;
    Label26: TLabel;
    Label31: TLabel;
    SpeedButton13: TSpeedButton;
    Label32: TLabel;
    Label37: TLabel;
    SpeedButton16: TSpeedButton;
    Label38: TLabel;
    Label41: TLabel;
    SpeedButton18: TSpeedButton;
    Label42: TLabel;
    Label44: TLabel;
    SpeedButton21: TSpeedButton;
    Label45: TLabel;
    Label57: TLabel;
    SpeedButton27: TSpeedButton;
    Label58: TLabel;
    Label59: TLabel;
    SpeedButton28: TSpeedButton;
    Label60: TLabel;
    DBEditLocaliza4: TDBEditLocaliza;
    DBEditLocaliza9: TDBEditLocaliza;
    DBEditLocaliza12: TDBEditLocaliza;
    DBEditLocaliza15: TDBEditLocaliza;
    DBEditLocaliza16: TDBEditLocaliza;
    DBEditLocaliza17: TDBEditLocaliza;
    DBEditLocaliza23: TDBEditLocaliza;
    DBEditLocaliza24: TDBEditLocaliza;
    Label47: TLabel;
    SpeedButton22: TSpeedButton;
    Label48: TLabel;
    Label51: TLabel;
    SpeedButton24: TSpeedButton;
    Label52: TLabel;
    Label53: TLabel;
    SpeedButton25: TSpeedButton;
    Label54: TLabel;
    Label55: TLabel;
    SpeedButton26: TSpeedButton;
    Label56: TLabel;
    DBEditLocaliza18: TDBEditLocaliza;
    DBEditLocaliza20: TDBEditLocaliza;
    DBEditLocaliza21: TDBEditLocaliza;
    DBEditLocaliza22: TDBEditLocaliza;
    Label64: TLabel;
    SpeedButton30: TSpeedButton;
    Label65: TLabel;
    DBEditLocaliza26: TDBEditLocaliza;
    Label66: TLabel;
    SpeedButton31: TSpeedButton;
    Label67: TLabel;
    DBEditLocaliza27: TDBEditLocaliza;
    CFGI_EST_CEX: TFMTBCDField;
    CFGI_EST_BCC: TFMTBCDField;
    Label68: TLabel;
    SpeedButton32: TSpeedButton;
    Label69: TLabel;
    DBEditLocaliza28: TDBEditLocaliza;
    CFGI_OPE_EIE: TFMTBCDField;
    CFGC_COD_MCD: TWideStringField;
    CFGC_COM_COR: TWideStringField;
    Label70: TLabel;
    SpeedButton33: TSpeedButton;
    Label71: TLabel;
    Label72: TLabel;
    SpeedButton34: TSpeedButton;
    Label73: TLabel;
    DBEditLocaliza29: TDBEditLocaliza;
    DBEditLocaliza30: TDBEditLocaliza;
    CFGI_OPE_REE: TFMTBCDField;
    CFGI_OPE_RES: TFMTBCDField;
    Label74: TLabel;
    SpeedButton35: TSpeedButton;
    Label75: TLabel;
    DBEditLocaliza31: TDBEditLocaliza;
    Label76: TLabel;
    SpeedButton36: TSpeedButton;
    Label77: TLabel;
    DBEditLocaliza32: TDBEditLocaliza;
    CFGI_EST_SER: TFMTBCDField;
    CFGI_EST_PAN: TFMTBCDField;
    CFGI_OPE_SBC: TFMTBCDField;
    CFGI_OPE_EBC: TFMTBCDField;
    Label78: TLabel;
    SpeedButton37: TSpeedButton;
    Label79: TLabel;
    Label80: TLabel;
    SpeedButton38: TSpeedButton;
    Label81: TLabel;
    DBEditLocaliza33: TDBEditLocaliza;
    DBEditLocaliza34: TDBEditLocaliza;
    DBEditColor1: TDBEditColor;
    Label82: TLabel;
    CFGC_VLV_AUT: TWideStringField;
    CFGC_UNI_KIT: TWideStringField;
    CFGC_COR_NOE: TWideStringField;
    CFGC_EST_LSA: TWideStringField;
    CFGC_PRE_OBR: TWideStringField;
    CFGC_CUS_OBR: TWideStringField;
    CFGC_DMT_OQC: TWideStringField;
    CFGI_QTD_LUF: TFMTBCDField;
    Label83: TLabel;
    DBEditColor4: TDBEditColor;
    Label84: TLabel;
    SpeedButton39: TSpeedButton;
    Label85: TLabel;
    DBEditLocaliza35: TDBEditLocaliza;
    CFGI_ORC_AMO: TFMTBCDField;
    CFGC_IND_ACE: TWideStringField;
    Label86: TLabel;
    DBEditColor5: TDBEditColor;
    CFGC_UNI_BAR: TWideStringField;
    CFGC_ALT_DPE: TWideStringField;
    CFGC_EST_TAM: TWideStringField;
    CFGC_UNI_PAD: TWideStringField;
    Label87: TLabel;
    DBEditColor6: TDBEditColor;
    SpeedButton40: TSpeedButton;
    LClaProdutoRotulado: TLabel;
    Label89: TLabel;
    EClaProdutoRotulado: TDBEditColor;
    CFGC_CLA_PRR: TWideStringField;
    CFGC_REF_CLI: TWideStringField;
    CFGC_ORP_ACE: TWideStringField;
    TabSheet2: TTabSheet;
    ERegraLote: TComboBoxColor;
    Label88: TLabel;
    CFGI_REG_LOT: TFMTBCDField;
    CFGC_EST_SER: TWideStringField;
    TabSheet3: TTabSheet;
    ETipoCodigoBarras: TComboBoxColor;
    Label90: TLabel;
    DBEditColor7: TDBEditColor;
    Label91: TLabel;
    CFGI_TIP_BAR: TFMTBCDField;
    CFGN_PRE_EAN: TFMTBCDField;
    CFGI_ULT_EAN: TFMTBCDField;
    DBEditColor8: TDBEditColor;
    Label92: TLabel;
    Label93: TLabel;
    EModeloEtiquetaPequena: TComboBoxColor;
    CFGI_MOD_EPE: TFMTBCDField;
    CFGC_EAN_ACE: TWideStringField;
    Label94: TLabel;
    SpeedButton41: TSpeedButton;
    Label95: TLabel;
    DBEditLocaliza36: TDBEditLocaliza;
    CFGI_EST_REI: TFMTBCDField;
    PanelColor3: TPanelColor;
    Label96: TLabel;
    DBEditLocaliza37: TDBEditLocaliza;
    SpeedButton42: TSpeedButton;
    Label97: TLabel;
    CFGI_ORC_LOC: TFMTBCDField;
    CFGC_IND_CAT: TWideStringField;
    Label98: TLabel;
    Label99: TLabel;
    SpeedButton43: TSpeedButton;
    DBEditLocaliza38: TDBEditLocaliza;
    CFGI_ORC_SLO: TFMTBCDField;
    CFGC_EST_CHA: TWideStringField;
    CFGC_VAP_OPC: TWideStringField;
    CFGD_ULT_ALT: TSQLTimeStampField;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    PanelColor8: TPanelColor;
    CFGC_ALT_GCA: TWideStringField;
    CFGI_MET_CUS: TFMTBCDField;
    CFGC_SAL_NMC: TWideStringField;
    EDestinoProduto: TComboBoxColor;
    Label102: TLabel;
    CFGI_DES_PRO: TFMTBCDField;
    Label100: TLabel;
    SpeedButton44: TSpeedButton;
    Label101: TLabel;
    DBEditLocaliza40: TDBEditLocaliza;
    CFGI_OPE_SBO: TFMTBCDField;
    Label103: TLabel;
    DBEditLocaliza39: TDBEditLocaliza;
    SpeedButton45: TSpeedButton;
    Label104: TLabel;
    CFGI_EST_IMPC: TFMTBCDField;
    CFGI_ORC_CHA: TFMTBCDField;
    DBEditLocaliza41: TDBEditLocaliza;
    SpeedButton46: TSpeedButton;
    Label105: TLabel;
    Label106: TLabel;
    CFGC_CUS_PPA: TWideStringField;
    Label107: TLabel;
    DBEditLocaliza42: TDBEditLocaliza;
    SpeedButton47: TSpeedButton;
    Label108: TLabel;
    DBEditLocaliza43: TDBEditLocaliza;
    SpeedButton48: TSpeedButton;
    Label109: TLabel;
    Label110: TLabel;
    CFGI_ORC_COL: TFMTBCDField;
    CFGI_ORC_ENT: TFMTBCDField;
    CFGC_IND_EMB: TWideStringField;
    Label111: TLabel;
    EEtiquetaRomaneioOrcamento: TComboBoxColor;
    CFGI_ETI_ROO: TFMTBCDField;
    Label112: TLabel;
    EClaMateriaPrimaAprovacao: TDBEditColor;
    SpeedButton49: TSpeedButton;
    LClaMateriaPrimaAprovacao: TLabel;
    CFGC_CLA_MPA: TWideStringField;
    ScrollBox2: TScrollBox;
    QtdMin: TDBCheckBox;
    QtdEst: TDBCheckBox;
    VerCodigpPro: TDBCheckBox;
    MascaraProduto: TDBCheckBox;
    QtdNeg: TDBRadioGroup;
    CodigoEmpresa: TDBCheckBox;
    DuplicaItemNFEntrada: TDBCheckBox;
    CUTILIZARIPI: TDBCheckBox;
    CCadastraEtiqueta: TDBCheckBox;
    CCadastraCadarco: TDBCheckBox;
    CEstoqueCor: TDBCheckBox;
    CPrecoPorClienteAutomatico: TDBCheckBox;
    CDataEntregaPrevista: TDBCheckBox;
    CExcluiCotacao: TDBCheckBox;
    CNomDesenhoIgualCodigo: TDBCheckBox;
    CNumeroSerieProduto: TDBCheckBox;
    CAlterarNomeProduto: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBCheckBox18: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    DBCheckBox20: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    DBCheckBox21: TDBCheckBox;
    DBCheckBox22: TDBCheckBox;
    DBCheckBox23: TDBCheckBox;
    ScrollBox3: TScrollBox;
    DBCheckBox24: TDBCheckBox;
    CFGC_FIL_FAT: TWideStringField;
    CFGC_LEI_SEF: TWideStringField;
    Label113: TLabel;
    DBEditColor9: TDBEditColor;
    Label114: TLabel;
    DBEditColor10: TDBEditColor;
    CFGC_UNI_QUI: TWideStringField;
    CFGC_UNI_MIL: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CFGAfterPost(DataSet: TDataSet);
    procedure FecharClick(Sender: TObject);
    procedure mascaraProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure mascaraExit(Sender: TObject);
    procedure mascaraKeyPress(Sender: TObject; var Key: Char);
    procedure DBEditNumerico2Exit(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure CEstoqueCentralizadoClick(Sender: TObject);
    procedure EClaProdutoExit(Sender: TObject);
    procedure EClaMateriaPrimaExit(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure EClaProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EClaMateriaPrimaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EEtiquetaNotaEntradaClick(Sender: TObject);
    procedure SpeedButton40Click(Sender: TObject);
    procedure EClaProdutoRotuladoExit(Sender: TObject);
    procedure EClaProdutoRotuladoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ERegraLoteClick(Sender: TObject);
    procedure ETipoCodigoBarrasClick(Sender: TObject);
    procedure EModeloEtiquetaPequenaClick(Sender: TObject);
    procedure CFGBeforePost(DataSet: TDataSet);
    procedure EDestinoProdutoChange(Sender: TObject);
    procedure EEtiquetaRomaneioOrcamentoClick(Sender: TObject);
    procedure EClaMateriaPrimaAprovacaoExit(Sender: TObject);
    procedure EClaMateriaPrimaAprovacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton49Click(Sender: TObject);
  private
    FunClassificacao : TFuncoesClassificacao;
    function LocalizaClassificacao(VpaCampo : tfield;VpaLabel : TLabel) : Boolean;

  public
    { Public declarations }
  end;

var
  FConfiguracoesProdutos: TFConfiguracoesProdutos;

implementation

uses APrincipal,funobjeto, funsql, ALocalizaClassificacao, UnSistema, UnProdutos;

{$R *.DFM}

{ ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Modulo Básico
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ******************* Na Criacao do formulario ****************************** }
procedure TFConfiguracoesProdutos.FormCreate(Sender: TObject);
begin
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
   kk0y.ActivePageIndex := 0;
   CFG.open;
   AtualizaLocalizas(PanelColor1);
   InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'T','F');
   EEtiquetaNotaEntrada.ItemIndex := Varia.ModeloEtiquetaNotaEntrada;
   ERegraLote.ItemIndex := CFGI_REG_LOT.AsInteger;
   ETipoCodigoBarras.ItemIndex := CFGI_TIP_BAR.AsInteger;
   EDestinoProduto.ItemIndex := FunProdutos.RNumDestinoProduto(varia.DestinoProduto);
   EEtiquetaRomaneioOrcamento.ItemIndex := CFGI_ETI_ROO.AsInteger;
end;

{ ******************* No fechamento do formulário **************************** }
procedure TFConfiguracoesProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    CFG.close;
    FunClassificacao.free;
    action := cafree;
end;

{ *************** fecha o formulario *************************************** }
procedure TFConfiguracoesProdutos.FecharClick(Sender: TObject);
begin
close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              configurações de Inicialização do Sistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFConfiguracoesProdutos.LocalizaClassificacao(VpaCampo : tfield;VpaLabel : TLabel) : Boolean;
var
  VpfCodcla, VpfNomeCla : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodcla,VpfNomeCla, 'P') then
  begin
    VpaCampo.AsString := VpfCodcla;
    VpaLabel.Caption := Vpfnomecla;
  end
  else
    result := false;
end;

{ ******************* Apos Gravar as alterações na tabela CFG **************** }
procedure TFConfiguracoesProdutos.CFGAfterPost(DataSet: TDataSet);
begin
   CarregaCFG(FPrincipal.BaseDados);
   FPrincipal.AlteraNomeEmpresa;
   Sistema.MarcaTabelaParaImportar('CFG_PRODUTO');
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.CFGBeforePost(DataSet: TDataSet);
begin
  CFGD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.ERegraLoteClick(Sender: TObject);
begin
  IF CFG.State in [dsedit,dsinsert] then
  begin
    CFGI_REG_LOT.AsInteger := ERegraLote.ItemIndex;
  end;
end;

procedure TFConfiguracoesProdutos.ETipoCodigoBarrasClick(Sender: TObject);
begin
  IF CFG.State in [dsedit,dsinsert] then
  begin
    CFGI_TIP_BAR.AsInteger := ETipoCodigoBarras.ItemIndex;
  end
  else
    ETipoCodigoBarras.ItemIndex := CFGI_TIP_BAR.AsInteger;
end;

{ ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   Produtos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
procedure TFConfiguracoesProdutos.mascaraProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
if (not (key in [#57, #8])) then
 key := #0;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.mascaraExit(Sender: TObject);
begin
   if (sender as TDBEditColor).Text <> '' then
   if ((sender as TDBEditColor).Text[Length((sender as TDBEditColor).Text)] = '.') then
     (sender as TDBEditColor).Field.Value := copy((sender as TDBEditColor).Text,0, Length((sender as TDBEditColor).Text)-1);
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.mascaraKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key in [ #46, #57, #8]) then
   begin
      if ((sender as TDBEditColor).Text <> '') then
      begin
         if ((sender as TDBEditColor).Text[Length((sender as TDBEditColor).Text)] = '.') and (Key = '.') then
           key := #0;
      end
      else
        if ((sender as TDBEditColor).Text = '') and (Key = '.') then
          key := #0;
   end
   else
       key := #0;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.DBEditNumerico2Exit(Sender: TObject);
begin
if not((Sender as TDBEditNumerico).Field.AsInteger in [2,3]) then
   (Sender as TDBEditNumerico).Field.AsInteger := 2;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.CEstoqueCentralizadoClick(
  Sender: TObject);
begin
  AlterarEnabledDet([EFilControladora,LFilControladora,LFilialControladora,SFilialControladora],CEstoqueCentralizado.Checked);
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EClaProdutoExit(Sender: TObject);
var
 VpfNomeCla : string;
begin
  if not  FunClassificacao.ValidaClassificacao(CFGC_CLA_PRO.AsString, VpfNomeCla, 'P') then
  begin
     if not LocalizaClassificacao(EClaProduto.Field,LClaProduto)  then
       EClaProduto.SetFocus;
  end
  else
  begin
    LClaProduto.Caption := Vpfnomecla;
  end;
end;


{******************************************************************************}
procedure TFConfiguracoesProdutos.EClaMateriaPrimaAprovacaoExit(
  Sender: TObject);
var
 VpfNomeCla : string;
begin
  if not  FunClassificacao.ValidaClassificacao(CFGC_CLA_PRR.AsString, VpfNomeCla, 'P') then
  begin
     if not LocalizaClassificacao(EClaMateriaPrimaAprovacao.Field,LClaMateriaPrimaAprovacao)  then
       EClaMateriaPrimaAprovacao.SetFocus;
  end
  else
  begin
    LClaMateriaPrimaAprovacao.Caption := Vpfnomecla;
  end;
end;

procedure TFConfiguracoesProdutos.EClaMateriaPrimaAprovacaoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao(EClaMateriaPrimaAprovacao.Field,LClaMateriaPrimaAprovacao);
end;

procedure TFConfiguracoesProdutos.EClaMateriaPrimaExit(Sender: TObject);
var
 VpfNomeCla : string;
begin
  if not  FunClassificacao.ValidaClassificacao(CFGC_CLA_MAP.AsString, VpfNomeCla, 'P') then
  begin
     if not LocalizaClassificacao(EClaMateriaPrima.Field,LClaMateriaPrima)  then
       EClaMateriaPrima.SetFocus;
  end
  else
  begin
    LClaMateriaPrima.Caption := Vpfnomecla;
  end;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.SpeedButton19Click(Sender: TObject);
begin
  if CFG.State = dsedit then
     LocalizaClassificacao(EClaProduto.Field,LClaProduto);
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.SpeedButton20Click(Sender: TObject);
begin
  if CFG.State = dsedit then
    LocalizaClassificacao(EClaMateriaPrima.Field,LClaMateriaPrima)
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EClaProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
     LocalizaClassificacao(EClaProduto.Field,LClaProduto);
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EClaMateriaPrimaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao(EClaMateriaPrima.Field,LClaMateriaPrima)
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EEtiquetaNotaEntradaClick(
  Sender: TObject);
begin
  IF CFG.State in [dsedit,dsinsert] then
  begin
    Varia.ModeloEtiquetaNotaEntrada := EEtiquetaNotaEntrada.ItemIndex;
    CFGI_MOD_ENE.AsInteger := Varia.ModeloEtiquetaNotaEntrada;
  end
  else
    EEtiquetaNotaEntrada.ItemIndex := varia.ModeloEtiquetaNotaEntrada;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EEtiquetaRomaneioOrcamentoClick(
  Sender: TObject);
begin
  IF CFG.State in [dsedit,dsinsert] then
  begin
    CFGI_ETI_ROO.AsInteger := EEtiquetaRomaneioOrcamento.ItemIndex;
  end
  else
    EEtiquetaRomaneioOrcamento.ItemIndex := CFGI_ETI_ROO.AsInteger;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EModeloEtiquetaPequenaClick(Sender: TObject);
begin
  IF CFG.State in [dsedit,dsinsert] then
  begin
    Varia.ModeloEtiquetaPequena := EModeloEtiquetaPequena.ItemIndex;
    CFGI_MOD_EPE.AsInteger := Varia.ModeloEtiquetaPequena;
  end
  else
    EModeloEtiquetaPequena.ItemIndex := varia.ModeloEtiquetaPequena;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.SpeedButton40Click(Sender: TObject);
begin
  if CFG.State = dsedit then
    LocalizaClassificacao(EClaProdutoRotulado.Field,LClaProdutoRotulado)
end;

procedure TFConfiguracoesProdutos.SpeedButton49Click(Sender: TObject);
begin
  if CFG.State = dsedit then
    LocalizaClassificacao(EClaMateriaPrimaAprovacao.Field,LClaMateriaPrimaAprovacao)
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EClaProdutoRotuladoExit(Sender: TObject);
var
 VpfNomeCla : string;
begin
  if not  FunClassificacao.ValidaClassificacao(CFGC_CLA_PRR.AsString, VpfNomeCla, 'P') then
  begin
     if not LocalizaClassificacao(EClaProdutoRotulado.Field,LClaProdutoRotulado)  then
       EClaProdutoRotulado.SetFocus;
  end
  else
  begin
    LClaProdutoRotulado.Caption := Vpfnomecla;
  end;
end;

{******************************************************************************}
procedure TFConfiguracoesProdutos.EClaProdutoRotuladoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao(EClaProdutoRotulado.Field,LClaProdutoRotulado);
end;

procedure TFConfiguracoesProdutos.EDestinoProdutoChange(Sender: TObject);
begin
  if CFG.State in [dsedit] then
  begin
    Varia.DestinoProduto := FunProdutos.RTipoDestinoProduto(EDestinoProduto.ItemIndex);
    CFGI_DES_PRO.AsInteger := FunProdutos.RNumDestinoProduto(Varia.DestinoProduto);
  end;
end;

Initialization
{*****************Registra a Classe para Evitar duplicidade********************}
   RegisterClasses([TFConfiguracoesProdutos]);
end.
