unit AConfiguracaoEmpresa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Buttons, StdCtrls, Mask,Registry, Printers,
  DBCtrls, Tabela, Localizacao, Db, DBTables, ComCtrls, BotaoCadastro, UnClassificacao,
  DBClient;

type
  TFConfiguracaoEmpresa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    PageControl: TPageControl;
    PCotacao: TTabSheet;
    PFinanceiro: TTabSheet;
    DataEmpresa: TDataSource;
    localiza: TConsultaPadrao;
    Label1: TLabel;
    BPlano: TSpeedButton;
    EPlanoDevolucao: TDBEditColor;
    LPlano: TLabel;
    CadEmpresas: TSQL;
    CadEmpresasI_COD_EMP: TFMTBCDField;
    CadEmpresasC_NOM_EMP: TWideStringField;
    CadEmpresasC_MAS_PLA: TWideStringField;
    CadEmpresasC_PIC_CLA: TWideStringField;
    CadEmpresasC_PIC_PRO: TWideStringField;
    CadEmpresasC_MAS_BAR: TWideStringField;
    CadEmpresasC_CLA_SER: TWideStringField;
    CadEmpresasD_ULT_ALT: TSQLTimeStampField;
    CadEmpresasI_ULT_PRO: TFMTBCDField;
    CadEmpresasC_PLA_DEC: TWideStringField;
    DBEditColor1: TDBEditColor;
    Label2: TLabel;
    PProduto: TTabSheet;
    Label19: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    mascara: TDBEditColor;
    mascaraProdutos: TDBEditColor;
    DBEditColor2: TDBEditColor;
    Label3: TLabel;
    DBEditLocaliza9: TDBEditLocaliza;
    SpeedButton12: TSpeedButton;
    Label54: TLabel;
    CadEmpresasI_BOL_PAD: TFMTBCDField;
    CBaixarQtdCotacao: TDBCheckBox;
    CadEmpresasC_BAI_QCO: TWideStringField;
    CBloquearAlteracaoAposImpressao: TDBCheckBox;
    CadEmpresasC_BDI_COT: TWideStringField;
    CTecnicoCotacao: TDBCheckBox;
    CadEmpresasC_TEC_COT: TWideStringField;
    PCliente: TTabSheet;
    CCpfCliente: TDBCheckBox;
    CadEmpresasC_CPF_CLI: TWideStringField;
    CMostrarCotacaodaFilialAtiva: TDBCheckBox;
    CadEmpresasC_FIL_COT: TWideStringField;
    CTransportadoraNota: TDBCheckBox;
    CadEmpresasC_CTP_COT: TWideStringField;
    ConfigImpressoras: TPrinterSetupDialog;
    CDataFinanceiroiguacotacao: TDBCheckBox;
    CadEmpresasC_DAR_COT: TWideStringField;
    CImprimeAlmoxarifado: TDBCheckBox;
    CadEmpresasC_IMP_ALM: TWideStringField;
    EPlanoContasBancario: TDBEditColor;
    Label5: TLabel;
    BPlanoBancario: TSpeedButton;
    LPlanBancario: TLabel;
    CadEmpresasC_PLA_RET: TWideStringField;
    CadEmpresasC_CEP_CLI: TWideStringField;
    CCepCliente: TDBCheckBox;
    PContratos: TTabSheet;
    CImprimirRecibo: TDBCheckBox;
    CImprimirEnvelopesNotas: TDBCheckBox;
    CadEmpresasC_FME_ICO: TWideStringField;
    CadEmpresasC_FME_IEN: TWideStringField;
    TabSheet1: TTabSheet;
    CFarmacia: TDBCheckBox;
    CadEmpresasC_IND_FAR: TWideStringField;
    CadEmpresasC_IND_MIM: TWideStringField;
    CRamoManutencaoImpressora: TDBCheckBox;
    CAlterarCotacaoDataEmissao: TDBCheckBox;
    CadEmpresasC_ALC_SDE: TWideStringField;
    CTextoFiscalCotacao: TDBCheckBox;
    CadEmpresasC_COT_TFI: TWideStringField;
    Label7: TLabel;
    EPlanoDescontoDuplicata: TDBEditColor;
    BPlanoDesconto: TSpeedButton;
    LDescontoDuplicata: TLabel;
    CadEmpresasC_PLA_DES: TWideStringField;
    PTelemarketing: TTabSheet;
    ECampanhaVendas: TDBEditLocaliza;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Label10: TLabel;
    CadEmpresasI_SEQ_CAM: TFMTBCDField;
    CUtilizarMailing: TDBCheckBox;
    CadEmpresasC_IND_MAI: TWideStringField;
    CMensagemAntesImprimirNota: TDBCheckBox;
    CadEmpresasC_IND_AIN: TWideStringField;
    CAlterarVendedorcotacao: TDBCheckBox;
    DBEditLocaliza1: TDBEditLocaliza;
    Label11: TLabel;
    SpeedButton2: TSpeedButton;
    Label12: TLabel;
    CadEmpresasC_COT_CAV: TWideStringField;
    CadEmpresasI_VEN_COT: TFMTBCDField;
    PChamados: TTabSheet;
    CadEmpresasI_SER_CHA: TFMTBCDField;
    Label9: TLabel;
    EServicoCotacao: TDBEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    CadEmpresasC_ALT_COG: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    CadEmpresasC_IND_NSU: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    CadEmpresasC_IND_MRE: TWideStringField;
    DBCheckBox3: TDBCheckBox;
    CadEmpresasC_IND_GRA: TWideStringField;
    CadEmpresasN_VAL_ACE: TFMTBCDField;
    DBCheckBox4: TDBCheckBox;
    CadEmpresasC_TRA_OBR: TWideStringField;
    CadEmpresasC_NOT_QPR: TWideStringField;
    DBCheckBox5: TDBCheckBox;
    CadEmpresasC_IND_SOF: TWideStringField;
    DBCheckBox6: TDBCheckBox;
    CadEmpresasI_CAM_CEM: TFMTBCDField;
    Label15: TLabel;
    SpeedButton4: TSpeedButton;
    Label16: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    PEmpresasCartuchos: TTabSheet;
    CadEmpresasI_MOD_ETO: TFMTBCDField;
    CadEmpresasI_MOD_ETI: TFMTBCDField;
    EEtiquetaCartuchoToner: TComboBoxColor;
    Label61: TLabel;
    EEtiquetaCartuchoTinta: TComboBoxColor;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    SpeedButton5: TSpeedButton;
    Label24: TLabel;
    Label26: TLabel;
    CadEmpresasC_CLA_POT: TWideStringField;
    CadEmpresasC_CLA_CIL: TWideStringField;
    CadEmpresasC_CLA_CHI: TWideStringField;
    SpeedButton6: TSpeedButton;
    Label25: TLabel;
    SpeedButton7: TSpeedButton;
    Label27: TLabel;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    PCompras: TTabSheet;
    Label91: TLabel;
    SpeedButton34: TSpeedButton;
    Label92: TLabel;
    EFilialCompras: TDBEditLocaliza;
    CadEmpresasI_FIL_COM: TFMTBCDField;
    CadEmpresasI_SER_DPR: TFMTBCDField;
    CadEmpresasI_SER_CPR: TFMTBCDField;
    Label17: TLabel;
    SpeedButton8: TSpeedButton;
    DBEditLocaliza3: TDBEditLocaliza;
    Label18: TLabel;
    Label20: TLabel;
    SpeedButton9: TSpeedButton;
    DBEditLocaliza4: TDBEditLocaliza;
    Label28: TLabel;
    DBCheckBox7: TDBCheckBox;
    CadEmpresasC_IND_ROT: TWideStringField;
    DBCheckBox8: TDBCheckBox;
    CadEmpresasC_COT_ICS: TWideStringField;
    PanelColor2: TPanelColor;
    DBCheckBox9: TDBCheckBox;
    PanelColor4: TPanelColor;
    CadEmpresasC_IND_FCA: TWideStringField;
    DBCheckBox10: TDBCheckBox;
    CadEmpresasC_IND_REC: TWideStringField;
    DBCheckBox11: TDBCheckBox;
    CadEmpresasC_IND_DET: TWideStringField;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    PanelColor10: TPanelColor;
    PanelColor11: TPanelColor;
    PanelColor12: TPanelColor;
    Label29: TLabel;
    BPlanoCR: TSpeedButton;
    LPlanoCR: TLabel;
    EPlanoCR: TDBEditColor;
    CadEmpresasC_PLA_PAD: TWideStringField;
    PEmpresaCadarco: TTabSheet;
    PanelColor3: TPanelColor;
    Label46: TLabel;
    LClaFio: TLabel;
    SpeedButton20: TSpeedButton;
    EClaFio: TDBEditColor;
    CadEmpresasC_CLA_FIO: TWideStringField;
    DBCheckBox12: TDBCheckBox;
    CadEmpresasC_COT_MES: TWideStringField;
    DBRadioGroup2: TDBRadioGroup;
    CadEmpresasC_TMK_ORD: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BPlanoClick(Sender: TObject);
    procedure EPlanoDevolucaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FecharClick(Sender: TObject);
    procedure mascaraProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure mascaraExit(Sender: TObject);
    procedure mascaraKeyPress(Sender: TObject; var Key: Char);
    procedure EPlanoContasBancarioExit(Sender: TObject);
    procedure EPlanoContasBancarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BPlanoDescontoClick(Sender: TObject);
    procedure EPlanoDescontoDuplicataKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure CadEmpresasAfterScroll(DataSet: TDataSet);
    procedure EServicoCotacaoSelect(Sender: TObject);
    procedure EEtiquetaCartuchoTonerClick(Sender: TObject);
    procedure EEtiquetaCartuchoTintaClick(Sender: TObject);
    procedure DBEditColor4Exit(Sender: TObject);
    procedure DBEditColor4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure DBEditColor5Exit(Sender: TObject);
    procedure DBEditColor5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEditColor6Exit(Sender: TObject);
    procedure DBEditColor6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFilialComprasSelect(Sender: TObject);
    procedure CadEmpresasAfterPost(DataSet: TDataSet);
    procedure CadEmpresasBeforePost(DataSet: TDataSet);
    procedure BPlanoCRClick(Sender: TObject);
    procedure EClaFioExit(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure EClaFioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    VprCodClassificacao,
    VprNomClassificacao: String;
    FunClassificacao: TFuncoesClassificacao;
    function LocalizaClassificacao(var VpaCodClassificacao, VpaNomClassificacao: String): Boolean;
    procedure AtualizaPoTinta;
    procedure AtualizaCilindro;
    procedure AtualizaChip;
  public
    { Public declarations }
  end;

var
  FConfiguracaoEmpresa: TFConfiguracaoEmpresa;

implementation

uses APrincipal, APlanoConta, FunSql, Constantes, FunObjeto,
  ALocalizaClassificacao, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConfiguracaoEmpresa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunClassificacao:= TFuncoesClassificacao.criar(Self,FPrincipal.BaseDados);

  AdicionaSQLAbreTabela(CadEmpresas,'Select * from CADEMPRESAS '+
                                    ' Where I_COD_EMP = '+ IntToStr(varia.CodigoEmpresa));
  PageControl.ActivePageIndex := 0;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'T','F');

  EEtiquetaCartuchoToner.ItemIndex := Varia.ModeloEtiquetaCartuchoToner;
  EEtiquetaCartuchoTinta.ItemIndex := varia.ModeloEtiquetaCartuchoTinta;

  PTelemarketing.TabVisible := ConfigModulos.TeleMarketing;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfiguracaoEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunClassificacao.Free;
  CadEmpresas.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFConfiguracaoEmpresa.BPlanoClick(Sender: TObject);
var
  VpfCodigo : String;
begin
  if CadEmpresas.State = dsedit then
  begin
    FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
    VpfCodigo := CadEmpresasC_PLA_DEC.Asstring;
    if not FPlanoConta.VerificaCodigo(VpfCodigo,'D', LPlano, False, (Sender is TSpeedButton)) then
      EPlanoDevolucao.SetFocus;
    CadEmpresasC_PLA_DEC.AsString := VpfCodigo;
  end;
end;

procedure TFConfiguracaoEmpresa.BPlanoCRClick(Sender: TObject);
var
  VpfCodigo : String;
begin
  if CadEmpresas.State = dsedit then
  begin
    FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
    VpfCodigo := CadEmpresasC_PLA_PAD.AsString;
    if not FPlanoConta.VerificaCodigo(VpfCodigo,'C', LPlanoCR, False, (Sender is TSpeedButton)) then
      EPlanoCR.SetFocus;
    CadEmpresasC_PLA_PAD.AsString :=VpfCodigo;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.EPlanoDevolucaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.FecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.mascaraProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in [#57, #8])) then
    key := #0;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.mascaraExit(Sender: TObject);
begin
   if (sender as TDBEditColor).Text <> '' then
   if ((sender as TDBEditColor).Text[Length((sender as TDBEditColor).Text)] = '.') then
     (sender as TDBEditColor).Field.Value := copy((sender as TDBEditColor).Text,0, Length((sender as TDBEditColor).Text)-1);
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.mascaraKeyPress(Sender: TObject;
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
procedure TFConfiguracaoEmpresa.EPlanoContasBancarioExit(Sender: TObject);
var
  VpfCodigo : String;
begin
  if CadEmpresas.State = dsedit then
  begin
    FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
    VpfCodigo := CadEmpresasC_PLA_RET.AsString;
    if not FPlanoConta.VerificaCodigo(VpfCodigo,'D', LPlanBancario, False, (Sender is TSpeedButton)) then
      EPlanoContasBancario.SetFocus;
    CadEmpresasC_PLA_RET.AsString :=VpfCodigo;
  end;
end;

procedure TFConfiguracaoEmpresa.EPlanoContasBancarioKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 114) then
    BPlanoBancario.Click;
end;

procedure TFConfiguracaoEmpresa.BPlanoDescontoClick(Sender: TObject);
var
  VpfCodigo : String;
begin
  if CadEmpresas.State = dsedit then
  begin
    FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
    VpfCodigo := CadEmpresasC_PLA_DES.AsString;
    if not FPlanoConta.VerificaCodigo(VpfCodigo,'D', LDescontoDuplicata, False, (Sender is TSpeedButton)) then
      EPlanoDescontoDuplicata.SetFocus;
    CadEmpresasC_PLA_DES.AsString :=VpfCodigo;
  end;
end;

procedure TFConfiguracaoEmpresa.EPlanoDescontoDuplicataKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 114) then
    BPlanoDesconto.Click;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.CadEmpresasAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADEMPRESAS');
end;

procedure TFConfiguracaoEmpresa.CadEmpresasAfterScroll(DataSet: TDataSet);
begin
  AtualizaLocalizas(PanelColor1);
  AtualizaPoTinta;
  AtualizaCilindro;
  AtualizaChip;
end;

procedure TFConfiguracaoEmpresa.CadEmpresasBeforePost(DataSet: TDataSet);
begin
  CadEmpresasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.AtualizaPoTinta;
begin
  VprCodClassificacao:= CadEmpresasC_CLA_POT.AsString;
  FunClassificacao.ValidaClassificacao(VprCodClassificacao, VprNomClassificacao, 'P');
  Label23.Caption:= VprNomClassificacao;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.AtualizaCilindro;
begin
  VprCodClassificacao:= CadEmpresasC_CLA_CIL.AsString;
  FunClassificacao.ValidaClassificacao(VprCodClassificacao, VprNomClassificacao, 'P');
  Label25.Caption:= VprNomClassificacao;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.AtualizaChip;
begin
  VprCodClassificacao:= CadEmpresasC_CLA_CHI.AsString;
  FunClassificacao.ValidaClassificacao(VprCodClassificacao, VprNomClassificacao, 'P');
  Label27.Caption:= VprNomClassificacao;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.EServicoCotacaoSelect(Sender: TObject);
begin
  TDBEditLocaliza(Sender).ASelectValida.Text := 'Select * from CADSERVICO '+
                                        ' Where I_COD_SER = @ '+
                                        ' and I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa);
  TDBEditLocaliza(Sender).ASelectLocaliza.Text := 'Select * from CADSERVICO '+
                                          ' Where C_NOM_SER like ''@%'''+
                                          ' and I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa);
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.EEtiquetaCartuchoTonerClick(Sender: TObject);
begin
  IF CadEmpresas.State in [dsedit,dsinsert] then
  begin
    Varia.ModeloEtiquetaCartuchoToner := EEtiquetaCartuchoToner.ItemIndex;
    CadEmpresasI_MOD_ETO.AsInteger := Varia.ModeloEtiquetaCartuchoToner;
  end
  else
    EEtiquetaCartuchoToner.ItemIndex := varia.ModeloEtiquetaCartuchoToner;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.EClaFioExit(Sender: TObject);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    VprCodClassificacao:= CadEmpresasC_CLA_FIO.AsString;
    VprNomClassificacao:= LClaFio.Caption;
    if not FunClassificacao.ValidaClassificacao(VprCodClassificacao, VprNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_FIO.AsString:= '';
        LClaFio.Caption:= '';
      end
      else
      begin
        CadEmpresasC_CLA_FIO.AsString:= VprCodClassificacao;
        LClaFio.Caption:= VprNomClassificacao;
      end;
    end
    else
    begin
      CadEmpresasC_CLA_FIO.AsString:= VprCodClassificacao;
      LClaFio.Caption:= VprNomClassificacao;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.EClaFioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    if Key = 114 then
    begin
      VprCodClassificacao:= CadEmpresasC_CLA_FIO.AsString;
      VprNomClassificacao:= LClaFio.Caption;
      if LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_FIO.AsString:= VprCodClassificacao;
        LClaFio.Caption:= VprNomClassificacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.EEtiquetaCartuchoTintaClick(
  Sender: TObject);
begin
  IF CadEmpresas.State in [dsedit,dsinsert] then
  begin
    Varia.ModeloEtiquetaCartuchoTinta := EEtiquetaCartuchoTinta.ItemIndex;
    CadEmpresasI_MOD_ETI.AsInteger := Varia.ModeloEtiquetaCartuchoTinta;
  end
  else
    EEtiquetaCartuchoTinta.ItemIndex := varia.ModeloEtiquetaCartuchoTinta;
end;

{******************************************************************************}
function TFConfiguracaoEmpresa.LocalizaClassificacao(var VpaCodClassificacao, VpaNomClassificacao: String): Boolean;
begin
  Result:= True;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VprCodClassificacao,VprNomClassificacao, 'P') then
  begin
    VpaCodClassificacao:= VprCodClassificacao;
    VpaNomClassificacao:= VprNomClassificacao;
  end
  else
    Result:= False;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.DBEditColor4Exit(Sender: TObject);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    VprCodClassificacao:= CadEmpresasC_CLA_POT.AsString;
    VprNomClassificacao:= Label23.Caption;
    if not FunClassificacao.ValidaClassificacao(VprCodClassificacao, VprNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_POT.AsString:= '';
        Label23.Caption:= '';
      end
      else
      begin
        CadEmpresasC_CLA_POT.AsString:= VprCodClassificacao;
        Label23.Caption:= VprNomClassificacao;
      end;
    end
    else
    begin
      CadEmpresasC_CLA_POT.AsString:= VprCodClassificacao;
      Label23.Caption:= VprNomClassificacao;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.DBEditColor4KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    if Key = 114 then
    begin
      VprCodClassificacao:= CadEmpresasC_CLA_POT.AsString;
      VprNomClassificacao:= Label23.Caption;
      if LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_POT.AsString:= VprCodClassificacao;
        Label23.Caption:= VprNomClassificacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.SpeedButton20Click(Sender: TObject);
var
  Key: Word;
  Shift: TShiftState;
begin
  Key:= 114;
  EClaFioKeyDown(Sender,Key,Shift);
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.SpeedButton5Click(Sender: TObject);
var
  Key: Word;
  Shift: TShiftState;
begin
  Key:= 114;
  DBEditColor4KeyDown(Sender,Key,Shift);
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.SpeedButton6Click(Sender: TObject);
var
  Key: Word;
  Shift: TShiftState;
begin
  Key:= 114;
  DBEditColor5KeyDown(Sender,Key,Shift);
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.SpeedButton7Click(Sender: TObject);
var
  Key: Word;
  Shift: TShiftState;
begin
  Key:= 114;
  DBEditColor6KeyDown(Sender,Key,Shift);
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.DBEditColor5Exit(Sender: TObject);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    VprCodClassificacao:= CadEmpresasC_CLA_CIL.AsString;
    VprNomClassificacao:= Label25.Caption;
    if not FunClassificacao.ValidaClassificacao(VprCodClassificacao, VprNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_CIL.AsString:= '';
        Label25.Caption:= '';
      end
      else
      begin
        CadEmpresasC_CLA_CIL.AsString:= VprCodClassificacao;
        Label25.Caption:= VprNomClassificacao;
      end;
    end
    else
    begin
      CadEmpresasC_CLA_CIL.AsString:= VprCodClassificacao;
      Label25.Caption:= VprNomClassificacao;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.DBEditColor5KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    if Key = 114 then
    begin
      VprCodClassificacao:= CadEmpresasC_CLA_CIL.AsString;
      VprNomClassificacao:= Label25.Caption;
      if LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_CIL.AsString:= VprCodClassificacao;
        Label25.Caption:= VprNomClassificacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.DBEditColor6Exit(Sender: TObject);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    VprCodClassificacao:= CadEmpresasC_CLA_CHI.AsString;
    VprNomClassificacao:= Label27.Caption;
    if not FunClassificacao.ValidaClassificacao(VprCodClassificacao, VprNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_CHI.AsString:= '';
        Label27.Caption:= '';
      end
      else
      begin
        CadEmpresasC_CLA_CHI.AsString:= VprCodClassificacao;
        Label27.Caption:= VprNomClassificacao;
      end;
    end
    else
    begin
      CadEmpresasC_CLA_CHI.AsString:= VprCodClassificacao;
      Label27.Caption:= VprNomClassificacao;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.DBEditColor6KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if CadEmpresas.State in [dsInsert,dsEdit] then
  begin
    if Key = 114 then
    begin
      VprCodClassificacao:= CadEmpresasC_CLA_CHI.AsString;
      VprNomClassificacao:= Label27.Caption;
      if LocalizaClassificacao(VprCodClassificacao, VprNomClassificacao) then
      begin
        CadEmpresasC_CLA_CHI.AsString:= VprCodClassificacao;
        Label27.Caption:= VprNomClassificacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoEmpresa.EFilialComprasSelect(Sender: TObject);
begin
  EFilialCompras.ASelectValida.Text := 'Select * from CADFILIAIS ' +
                                       ' Where I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                                       ' and I_EMP_FIL = @ ';
  EFilialCompras.ASelectLocaliza.Text := 'Select * from CADFILIAIS '+
                                       ' Where I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                                       ' and C_NOM_FIL like ''@%''';
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConfiguracaoEmpresa]);
end.
