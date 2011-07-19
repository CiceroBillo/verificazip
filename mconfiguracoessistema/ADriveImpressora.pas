unit ADriveImpressora;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, Buttons, Componentes1,
  Mask, numericos, Grids, DBGrids, Tabela, Db, DBTables, DBKeyViolation,
  DBCtrls, BotaoCadastro, UnImpressao, Geradores,
  Localizacao, Registry, DBClient;

type
  TFDriveImpressora = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    CAD_DRIVER: TSQL;
    DATACAD_DRIVER: TDataSource;
    Label35: TLabel;
    PanelColor3: TPanelColor;
    BitBtn6: TBitBtn;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BitBtn2: TBitBtn;
    GridIndice1: TGridIndice;
    Label6: TLabel;
    ENomeImpressora: TDBEditColor;
    Drivers: TComponenteMove;
    Label13: TLabel;
    PanelColor6: TPanelColor;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    GridIndice2: TGridIndice;
    BAvancado: TBitBtn;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    CAD_DRIVERI_SEQ_IMP: TFMTBCDField;
    CAD_DRIVERI_COD_DRV: TFMTBCDField;
    CAD_DRIVERC_NOM_DRV: TWideStringField;
    CAD_DRIVERC_NOM_IMP: TWideStringField;
    CAD_DRIVERC_NEG_SIM: TWideStringField;
    CAD_DRIVERC_NEG_NAO: TWideStringField;
    CAD_DRIVERC_ITA_SIM: TWideStringField;
    CAD_DRIVERC_ITA_NAO: TWideStringField;
    CAD_DRIVERC_CND_SIM: TWideStringField;
    CAD_DRIVERC_CND_NAO: TWideStringField;
    CAD_DRIVERC_CPI_SIM: TWideStringField;
    CAD_DRIVERC_CPI_NAO: TWideStringField;
    CAD_DRIVERC_LIN_SIM: TWideStringField;
    CAD_DRIVERC_LIN_NAO: TWideStringField;
    CAD_DRIVERC_INI_IMP: TWideStringField;
    CAD_DRIVERC_MRG_ESQ: TWideStringField;
    CAD_DRIVERC_MRG_DIR: TWideStringField;
    CAD_DRIVERC_BEP_BEP: TWideStringField;
    CAD_DRIVERC_CHR_SEP: TWideStringField;
    CAD_DRIVERC_PAP_SIM: TWideStringField;
    CAD_DRIVERC_PAP_NAO: TWideStringField;
    CAD_DRIVERI_DRI_PAI: TFMTBCDField;
    CAD_DRIVERI_AMI_TIO: TFMTBCDField;
    CAD_DRIVERI_AMA_TIO: TFMTBCDField;
    CAD_DRIVERI_AMI_AGU: TFMTBCDField;
    CAD_DRIVERI_AMA_AGU: TFMTBCDField;
    CAD_DRIVERI_AMI_CRA: TFMTBCDField;
    CAD_DRIVERI_AMA_CRA: TFMTBCDField;
    CAD_DRIVERI_AMI_CIR: TFMTBCDField;
    CAD_DRIVERI_AMA_CIR: TFMTBCDField;
    CAD_DRIVERI_AMI_TRE: TFMTBCDField;
    CAD_DRIVERI_AMA_TRE: TFMTBCDField;
    CAD_DRIVERI_EMI_AGU: TFMTBCDField;
    CAD_DRIVERI_EMA_AGU: TFMTBCDField;
    CAD_DRIVERI_EMI_CIR: TFMTBCDField;
    CAD_DRIVERI_EMA_CIR: TFMTBCDField;
    CAD_DRIVERI_IMI_AGU: TFMTBCDField;
    CAD_DRIVERI_IMA_AGU: TFMTBCDField;
    CAD_DRIVERI_OMI_TIO: TFMTBCDField;
    CAD_DRIVERI_OMA_TIO: TFMTBCDField;
    CAD_DRIVERI_OMI_AGU: TFMTBCDField;
    CAD_DRIVERI_OMA_AGU: TFMTBCDField;
    CAD_DRIVERI_OMI_CIR: TFMTBCDField;
    CAD_DRIVERI_OMA_CIR: TFMTBCDField;
    CAD_DRIVERI_OMI_TRE: TFMTBCDField;
    CAD_DRIVERI_OMA_TRE: TFMTBCDField;
    CAD_DRIVERI_UMI_AGU: TFMTBCDField;
    CAD_DRIVERI_UMA_AGU: TFMTBCDField;
    CAD_DRIVERI_UMI_TRE: TFMTBCDField;
    CAD_DRIVERI_UMA_TRE: TFMTBCDField;
    CAD_DRIVERI_CMI_CED: TFMTBCDField;
    CAD_DRIVERI_CMA_CED: TFMTBCDField;
    CAD_DRIVERI_AMI_NUM: TFMTBCDField;
    CAD_DRIVERI_OMA_NUM: TFMTBCDField;
    Label24: TLabel;
    EditColor3: TEditColor;
    BitBtn5: TBitBtn;
    ConfigImpressora: TPrinterSetupDialog;
    ComboBoxColor1: TComboBoxColor;
    Label3: TLabel;
    EImpressoraAlmoxarifado: TEditColor;
    Label9: TLabel;
    BitBtn7: TBitBtn;
    EImpressoraAssistencia: TEditColor;
    Label4: TLabel;
    BitBtn8: TBitBtn;
    DBEditColor1: TDBEditColor;
    CAD_DRIVERC_CAM_IMP: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CAD_DRIVERAfterInsert(DataSet: TDataSet);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure CAD_DRIVERBeforePost(DataSet: TDataSet);
    procedure CAD_DRIVERAfterPost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BAvancadoClick(Sender: TObject);
    procedure ElocalImpressaoExit(Sender: TObject);
    procedure CAD_DRIVERAfterScroll(DataSet: TDataSet);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EImpressoraAlmoxarifadoExit(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure EImpressoraAssistenciaExit(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
  private
    { Private declarations }
    ini : TRegIniFile;
    IMP : TFuncoesImpressao;
    procedure CopiaDriverImpressora;
  public
    { Public declarations }
  end;

var
  FDriveImpressora: TFDriveImpressora;

implementation

uses APrincipal, funObjeto,Constantes, FunSql, ConstMsg, FunString, UnClassesImprimir,
     AConfiguracaoImpressao, AComandosImpressora, Printers;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFDriveImpressora.FormCreate(Sender: TObject);
begin
  ini := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  ComboBoxColor1.ItemIndex :=  varia.ImpressoraCheque;
  IMP := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
  AdicionaSQLAbreTabela(CAD_DRIVER, 'SELECT * FROM CAD_DRIVER WHERE I_COD_DRV IS NULL');
  EditColor3.Text := varia.ImpressoraRelatorio;
  EImpressoraAlmoxarifado.Text := varia.ImpressoraAlmoxarifado;
  EImpressoraAssistencia.Text := varia.ImpressoraAssitenciaTecnica;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDriveImpressora.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IMP.Destroy;
  CAD_DRIVER.close;
  Ini.free;
  Action := CaFree;
end;

{**************** fecha o formulario **************************************** }
procedure TFDriveImpressora.BFecharClick(Sender: TObject);
begin
  Close;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Instalacao de um novo drive
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********* cancela a instalacao de um novo drive *************************** }
procedure TFDriveImpressora.BCancelarClick(Sender: TObject);
begin
  Drivers.Visible := False;
  CAD_DRIVER.Cancel;
end;

{*** continua a instalacao de um novo drive apos o usuario escolher o drive ** }
procedure TFDriveImpressora.BContinuarClick(Sender: TObject);
var
  Nome: string;
begin
  CopiaDriverImpressora;
{d5  CAD_DRIVER.FieldByname('I_DRI_PAI').AsInteger := CAD_DRIVER_AUX.fieldByName('I_COD_DRV').AsInteger;
  Drivers.Visible := False;
  Nome := CAD_DRIVER_AUX.FieldByName('C_NOM_DRV').AsString;
  Entrada('Instalação de Impressora', 'Informe o nome da impressora a ser instalada : ',
     Nome, False, clWhite, clBtnFace);
  CAD_DRIVER.FieldByname('C_NOM_IMP').AsString := NOME;
  ENomeImpressora.SetFocus;
  if CAD_DRIVER.State = dsInsert then
    CAD_DRIVER.Post;}
end;


{************ Mostra uma lista de drives para instalacao ********************* }
procedure TFDriveImpressora.BotaoCadastrar1DepoisAtividade(
  Sender: TObject);
begin
  // Somente os registros que são drivers.
{d5  AdicionaSQLAbreTabela(CAD_DRIVER_AUX,
    ' SELECT * FROM CAD_DRIVER ' +
    ' WHERE NOT I_COD_DRV IS NULL');
  if CAD_DRIVER_AUX.EOF then
    Aviso(CT_Drivers_Nao_Instalados)
  else
    Drivers.Visible  := True;}
end;

{************** copia o drive do sistema para o drive do cliente ************* }
procedure TFDriveImpressora.CopiaDriverImpressora;
var
  Laco: Integer;
begin
{d5    for Laco:=0 to (CAD_DRIVER.FieldCount -1) do
    begin
      if (CAD_DRIVER.Fields[Laco].FieldName <> 'I_SEQ_IMP') and
         (CAD_DRIVER.Fields[Laco].FieldName <> 'I_COD_DRV') and
         (CAD_DRIVER.Fields[Laco].FieldName <> 'C_NOM_IMP') and
         (CAD_DRIVER.Fields[Laco].FieldName <> 'I_DRI_PAI') then
        CAD_DRIVER.Fields[Laco].Value := CAD_DRIVER_AUX.Fields[Laco].Value;
    end;}
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Funcoes das tabela
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************* gera proximo codigo ****************************************** }
procedure TFDriveImpressora.CAD_DRIVERAfterInsert(DataSet: TDataSet);
begin
//d5  ProximoCodigoDriver.Execute('CAD_DRIVER');
end;

{ ************** evita nome de drive de impressora sem nome ****************** }
procedure TFDriveImpressora.CAD_DRIVERBeforePost(DataSet: TDataSet);
begin
  if CAD_DRIVER.FieldByname('C_NOM_IMP').AsString = '' then
  begin
    Aviso('Informe o nome da Impressora Instalada.');
    ENomeImpressora.SetFocus;
    Abort;
  end;

end;

{*********** apos o post atualiza a tabela de drive ************************* }
procedure TFDriveImpressora.CAD_DRIVERAfterPost(DataSet: TDataSet);
begin
  AtualizaSQLTabela(CAD_DRIVER);
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


procedure TFDriveImpressora.BitBtn1Click(Sender: TObject);
begin
{d5  if not CAD_DRIVER.Eof then
  begin
   AdicionaSQLAbreTabela(CAD_DRIVER_AUX,
                         ' SELECT * FROM CAD_DRIVER ' +
                         ' WHERE I_COD_DRV = ' + CAD_DRIVER.FieldByname('I_DRI_PAI').AsString );

    CAD_DRIVER.edit;
    CopiaDriverImpressora;
    CAD_DRIVER.post;
  end;}
end;

procedure TFDriveImpressora.BAvancadoClick(Sender: TObject);
begin
  FComandosImpressora := TFComandosImpressora. CriarSDI(application, '', true);
  FComandosImpressora.CarregaComandos(CAD_DRIVER.FieldByname('I_SEQ_IMP').AsInteger, CAD_DRIVERC_CAM_IMP.AsString);
end;


procedure TFDriveImpressora.ElocalImpressaoExit(Sender: TObject);
//var
//  ini : TRegIniFile;
begin
//22/04/2009 as configuracos do caminho da impressora não sao mais salvos no regedit e sim no banco de dados.
//  if ElocalImpressao.text <> '' then
//  begin
//    ini := TRegIniFile.Create('Software\Systec\Sistema');
//    ini.WriteString('IMPRESSORA',CAD_DRIVER.FieldByname('i_seq_imp').AsString,ElocalImpressao.Text);
//    ini.free;
//  end;
end;

procedure TFDriveImpressora.CAD_DRIVERAfterScroll(DataSet: TDataSet);
//var
//  ini : TRegIniFile;
begin
//22/04/2009 as configuracos do caminho da impressora não sao mais salvos no regedit e sim no banco de dados.
//  ini := TRegIniFile.Create('Software\Systec\Sistema');
//  ElocalImpressao.Text := ini.ReadString('IMPRESSORA',CAD_DRIVER.FieldByname('i_seq_imp').AsString,'');
//  ini.free;
end;

procedure TFDriveImpressora.BitBtn5Click(Sender: TObject);
begin
   if ConfigImpressora.Execute then
   begin
     ini.WriteString('IMPRESSORA','RELATORIO',printer.Printers[printer.PrinterIndex]);
   end;
   EditColor3.Text := printer.Printers[printer.PrinterIndex];
   varia.ImpressoraRelatorio := printer.Printers[printer.PrinterIndex];
end;

procedure TFDriveImpressora.FormShow(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFDriveImpressora.EImpressoraAlmoxarifadoExit(Sender: TObject);
begin
  ini.WriteString('IMPRESSORA','ALMOXARIFADO',EImpressoraAlmoxarifado.text);
  varia.ImpressoraAlmoxarifado := EImpressoraAlmoxarifado.Text;
end;

{******************************************************************************}
procedure TFDriveImpressora.BitBtn7Click(Sender: TObject);
begin
  if ConfigImpressora.Execute then
  begin
    EImpressoraAlmoxarifado.Text := printer.Printers[printer.PrinterIndex];
    ini.WriteString('IMPRESSORA','ALMOXARIFADO',EImpressoraAlmoxarifado.text);
    varia.ImpressoraAlmoxarifado := EImpressoraAlmoxarifado.Text;
  end;
end;

{******************************************************************************}
procedure TFDriveImpressora.EImpressoraAssistenciaExit(Sender: TObject);
begin
  ini.WriteString('IMPRESSORA','ASSISTENCIA',EImpressoraAssistencia.text);
  varia.ImpressoraAssitenciaTecnica := EImpressoraAssistencia.Text;
end;

{******************************************************************************}
procedure TFDriveImpressora.BitBtn8Click(Sender: TObject);
begin
  if ConfigImpressora.Execute then
  begin
    EImpressoraAssistencia.Text := printer.Printers[printer.PrinterIndex];
    ini.WriteString('IMPRESSORA','ASSISTENCIA',EImpressoraAssistencia.text);
    varia.ImpressoraAssitenciaTecnica := EImpressoraAssistencia.Text;
  end;
end;

Initialization
  RegisterClasses([TFDriveImpressora]);
end.


