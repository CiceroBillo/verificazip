unit ACriaDriversImpressora;

interface

uses
  Forms, LabelCorMove, SysUtils, Controls, StdCtrls, Db, DBTables, Classes,
  Componentes1, ExtCtrls;

type
  TFCriaDrivers = class(TForm)
    BaseDados: TDatabase;
    CAD_DRIVER: TQuery;
    LabelCorMove9: TLabelCorMove;
    EditColor1: TEditColor;
    Label1: TLabel;
    Button1: TButton;
    GroupBox1: TGroupBox;
    LabelCorMove5: TLabelCorMove;
    LabelCorMove2: TLabelCorMove;
    LabelCorMove3: TLabelCorMove;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Label2: TLabel;
    LabelCorMove1: TLabelCorMove;
    LabelCorMove4: TLabelCorMove;
    procedure GravarDriveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function ProximoCodigoSequencial: string;
    function ExisteDriver(CodigoDriver: string): Boolean;

    procedure AdicionaDriver(CodigoDriver, C_NOM_DRV, C_NOM_IMP, C_NEG_SIM,
      C_NEG_NAO, C_ITA_SIM, C_ITA_NAO, C_CND_SIM, C_CND_NAO, C_CPI_SIM, C_CPI_NAO,
      C_LIN_SIM, C_LIN_NAO, C_INI_IMP, C_MRG_ESQ, C_MRG_DIR, C_BEP_BEP, C_CHR_SEP,
      C_PAP_SIM, C_PAP_NAO,  TextoCaracteres : String ) ;
   public

  end;

var
  FCriaDrivers: TFCriaDrivers;

implementation

{$R *.DFM}

uses ConstMsg, FunSql, funObjeto;


function TFCriaDrivers.ProximoCodigoSequencial: string;
begin
  AdicionaSQLAbreTabela(CAD_DRIVER,
  ' SELECT MAX(I_SEQ_IMP) PROXIMO FROM CAD_DRIVER ');
  Result := IntToStr(CAD_DRIVER.FieldByName('PROXIMO').AsInteger + 1);
end;

function TFCriaDrivers.ExisteDriver(CodigoDriver: string): Boolean;
begin
  AdicionaSQLAbreTabela(CAD_DRIVER,
  ' SELECT I_COD_DRV FROM CAD_DRIVER ' +
  ' WHERE I_COD_DRV = ' + CodigoDriver);
  Result := (not CAD_DRIVER.EOF);
end;

procedure TFCriaDrivers.AdicionaDriver(CodigoDriver, C_NOM_DRV, C_NOM_IMP, C_NEG_SIM,
      C_NEG_NAO, C_ITA_SIM, C_ITA_NAO, C_CND_SIM, C_CND_NAO, C_CPI_SIM, C_CPI_NAO,
      C_LIN_SIM, C_LIN_NAO, C_INI_IMP, C_MRG_ESQ, C_MRG_DIR, C_BEP_BEP, C_CHR_SEP,
      C_PAP_SIM, C_PAP_NAO, TextoCaracteres : String );
//      I_AMI_TIO, I_AMA_TIO, I_AMI_AGU, I_AMA_AGU, I_AMI_CRA, I_AMA_CRA, I_AMI_CIR,
//      I_AMA_CIR, I_AMI_TRE, I_AMA_TRE, I_EMI_AGU, I_EMA_AGU, I_EMI_CIR, I_EMA_CIR,
//      I_IMI_AGU, I_IMA_AGU, I_OMI_TIO, I_OMA_TIO, I_OMI_AGU, I_OMA_AGU, I_OMI_CIR,
//      I_OMA_CIR, I_OMI_TRE, I_OMA_TRE, I_UMI_AGU, I_UMA_AGU, I_UMI_TRE, I_UMA_TRE,
//      I_CMI_CED, I_CMA_CED, I_AMI_NUM, I_OMA_NUM
var
  Proximo: string;
begin
  if ExisteDriver(CodigoDriver) then
  begin
    LimpaSQLTabela(CAD_DRIVER);
    AdicionaSQLTabela(CAD_DRIVER,'DELETE CAD_DRIVER WHERE I_COD_DRV = ' + CodigoDriver);
    CAD_DRIVER.ExecSQL;
  end;

  if Confirmacao('Deseja Realmente Importar este DRIVER ( ' + C_NOM_DRV + ' ) para seu arquivo de configurações ?') then
  begin
    Proximo := ProximoCodigoSequencial;
    LimpaSQLTabela(CAD_DRIVER);
    AdicionaSQLTabela(CAD_DRIVER,
    ' INSERT INTO CAD_DRIVER ' +
    ' (I_SEQ_IMP, I_COD_DRV, C_NOM_DRV, C_NOM_IMP, C_NEG_SIM, ' +
    ' C_NEG_NAO, C_ITA_SIM, C_ITA_NAO, C_CND_SIM, C_CND_NAO, ' +
    ' C_CPI_SIM, C_CPI_NAO, C_LIN_SIM, C_LIN_NAO, C_INI_IMP, ' +
    ' C_MRG_ESQ, C_MRG_DIR, C_BEP_BEP, C_CHR_SEP, C_PAP_SIM, C_PAP_NAO,  ' +
    ' I_AMI_TIO, I_AMA_TIO, I_AMI_AGU, I_AMA_AGU, I_AMI_CRA, I_AMA_CRA, I_AMI_CIR, ' +
    ' I_AMA_CIR, I_AMI_TRE, I_AMA_TRE, I_EMI_AGU, I_EMA_AGU, I_EMI_CIR, I_EMA_CIR, ' +
    ' I_IMI_AGU, I_IMA_AGU, I_OMI_TIO, I_OMA_TIO, I_OMI_AGU, I_OMA_AGU, I_OMI_CIR, ' +
    ' I_OMA_CIR, I_OMI_TRE, I_OMA_TRE, I_UMI_AGU, I_UMA_AGU, I_UMI_TRE, I_UMA_TRE, ' +
    ' I_CMI_CED, I_CMA_CED, I_AMI_NUM, I_OMA_NUM ) VALUES ( ' +
    Proximo +
    ',' + CodigoDriver + ',' +
    '''' + C_NOM_DRV + ''',' +     '''' + C_NOM_IMP + ''',' +     '''' + C_NEG_SIM + ''',' +
    '''' + C_NEG_NAO + ''',' +     '''' + C_ITA_SIM + ''',' +     '''' + C_ITA_NAO + ''',' +
    '''' + C_CND_SIM + ''',' +     '''' + C_CND_NAO + ''',' +     '''' + C_CPI_SIM + ''',' +
    '''' + C_CPI_NAO + ''',' +     '''' + C_LIN_SIM + ''',' +     '''' + C_LIN_NAO + ''',' +
    '''' + C_INI_IMP + ''',' +     '''' + C_MRG_ESQ + ''',' +     '''' + C_MRG_DIR + ''',' +
    '''' + C_BEP_BEP + ''',' +     '''' + C_CHR_SEP + ''',' +     '''' + C_PAP_SIM + ''',' +
    '''' + C_PAP_NAO + ''',' +  TextoCaracteres + ' )' );

    CAD_DRIVER.ExecSQL;
    Informacao('Importação driver ( ' + C_NOM_DRV + ' )  efetuada com sucesso!!!');
  end;

end;

procedure TFCriaDrivers.GravarDriveClick(Sender: TObject);
begin
  case (Sender as TComponent).Tag of
    01 : AdicionaDriver('1', 'Driver Default', 'Impressora Driver Default' ,'27|69', '27|70', '27|52', '27|53', '27|15', '27|18', '27|77', '27|80', '27|48', '27|50', '27|64', '27|108|0', '27|81|80', '27/07', '|', '27|57', '27|56',
        //  ã    Ã    á    Á    à    À    â    Â    ä    Ä    é    É    ê    Ê    í    Í
         ' 097, 065, 097, 065, 097, 065, 097, 065, 097, 065, 101, 069, 101, 069, 105, 073, ' +
       //  õ    Õ    ó    Ó    ô    Ô    ö    Ö    ú    Ú    ü    Ü    ç    Ç    ª    º
        ' 111, 079, 111, 079, 111, 079, 111, 079, 117, 085, 117, 085, 099, 067,  null, null ' );

    02 : AdicionaDriver('2', 'EPSON LX 300',  'Impressora EPSON LX 300'  ,'27|69', '27|70', '27|52', '27|53', '27|120|0|27|15', '27|120|0|27|18', '27|77', '27|80', '27|48', '27|50', '27|64', '27|108|0', '27|81|80', '27/07', '|', '27|57', '27|56',
        //  ã    Ã    á    Á    à    À    â    Â    ä    Ä    é    É    ê    Ê    í    Í
         ' 198, 199, 160, 181, 133, 183, 131, 182, 132, 142, 130, 144, 136, 210, 161, 214, ' +
        //  õ    Õ    ó    Ó    ô    Ô    ö    Ö    ú    Ú    ü    Ü    ç    Ç    ª    º
         ' 228, 229, 149, 224, 147, 226, 148, 153, 163, 233, 129, 154, 135, 128, 166, 167  '  );

    03 : AdicionaDriver('3', 'EPSON LX 800',  'Impressora EPSON LX 800'  ,'27|69', '27|70', '27|52', '27|53', '27|15', '27|18', '27|77', '27|80', '27|48', '27|50', '27|64', '27|108|0', '27|81|80', '27/07', '|', '27|57', '27|56',
        //  ã    Ã    á    Á    à    À    â    Â    ä    Ä    é    É    ê    Ê    í    Í
         ' 097, 065, 097, 065, 097, 065, 097, 065, 097, 065, 101, 069, 101, 069, 105, 073, ' +
       //  õ    Õ    ó    Ó    ô    Ô    ö    Ö    ú    Ú    ü    Ü    ç    Ç    ª    º
        ' 111, 079, 111, 079, 111, 079, 111, 079, 117, 085, 117, 085, 099, 067,  null, null ' );

    04 : AdicionaDriver('4', 'HP LASERJET',  'Impressora HP LARSERJET'  ,'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ' ', '0', '0',
        //  ã    Ã    á    Á    à    À    â    Â    ä    Ä    é    É    ê    Ê    í    Í
         ' 097, 065, 160, 160, 133, 133, 131, 131, 132, 142, 130, 130, 136, 144, 161, 161, ' +
       //  õ    Õ    ó    Ó    ô    Ô    ö    Ö    ú    Ú    ü    Ü    ç    Ç    ª    º
        ' 111, 079, 162, 162, 147, 147, 148, 153, 163, 163, 129, 154, 135, 128, 166, 167 ' );

    05 : AdicionaDriver('5', 'HP DESKJET 670/690/692',  'Impressora HP DESKJET 670/690/692'  ,'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ' ', '0', '0',
        //  ã    Ã    á    Á    à    À    â    Â    ä    Ä    é    É    ê    Ê    í    Í
         ' 097, 065, 160, 160, 133, 133, 131, 131, 132, 142, 130, 130, 136, 144, 161, 161, ' +
       //  õ    Õ    ó    Ó    ô    Ô    ö    Ö    ú    Ú    ü    Ü    ç    Ç    ª    º
        ' 111, 079, 162, 162, 147, 147, 148, 153, 163, 163, 129, 154, 135, 128, 166, 167 ' );


  end;
end;

procedure TFCriaDrivers.Button1Click(Sender: TObject);
begin
  if BaseDados.Connected then
    BaseDados.Connected := false;

  BaseDados.AliasName := EditColor1.text;
  try
    BaseDados.Connected := true;
    GroupBox1.Visible := true;
    LabelCorMove9.Enabled := true;
  except
    aviso('Não foi possível conectar ao banco de dados ou o nome do alias é inválido.');
    GroupBox1.Visible := false;
    LabelCorMove9.Enabled := false;
  end;
end;

procedure TFCriaDrivers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if BaseDados.Connected then
   BaseDados.Connected := false;
end;

end.
