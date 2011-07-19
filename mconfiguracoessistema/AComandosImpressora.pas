unit AComandosImpressora;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, Buttons, Componentes1,
  Mask, numericos, Grids, DBGrids, Tabela, Db, DBTables,
  DBCtrls, BotaoCadastro, UnImpressao, DBClient;

type
  TFComandosImpressora = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    CAD_DRIVER: TSQL;
    DATACAD_DRIVER: TDataSource;
    Label35: TLabel;
    PanelColor5: TPanelColor;
    PanelColor3: TPanelColor;
    BitBtn6: TBitBtn;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label49: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label12: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    DBEditColor12: TDBEditColor;
    DBEditColor11: TDBEditColor;
    DBEditColor08: TDBEditColor;
    DBEditColor07: TDBEditColor;
    DBEditColor06: TDBEditColor;
    DBEditColor05: TDBEditColor;
    DBEditColor04: TDBEditColor;
    DBEditColor03: TDBEditColor;
    DBEditColor09: TDBEditColor;
    DBEditColor10: TDBEditColor;
    DBEditColor01: TDBEditColor;
    DBEditColor13: TDBEditColor;
    DBEditColor14: TDBEditColor;
    DBEditColor02: TDBEditColor;
    DBEditColor15: TDBEditColor;
    DBEditColor16: TDBEditColor;
    DChar: TDBEditColor;
    GroupBox2: TGroupBox;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    DBEditColor2: TDBEditColor;
    Label3: TLabel;
    DBEditColor3: TDBEditColor;
    Label4: TLabel;
    DBEditColor4: TDBEditColor;
    Label5: TLabel;
    DBEditColor5: TDBEditColor;
    Label6: TLabel;
    DBEditColor6: TDBEditColor;
    Label7: TLabel;
    DBEditColor7: TDBEditColor;
    Label8: TLabel;
    DBEditColor8: TDBEditColor;
    Label13: TLabel;
    DBEditColor9: TDBEditColor;
    Label14: TLabel;
    DBEditColor17: TDBEditColor;
    Label15: TLabel;
    DBEditColor18: TDBEditColor;
    Label16: TLabel;
    DBEditColor19: TDBEditColor;
    Label17: TLabel;
    DBEditColor20: TDBEditColor;
    Label18: TLabel;
    DBEditColor21: TDBEditColor;
    Label19: TLabel;
    DBEditColor22: TDBEditColor;
    Label20: TLabel;
    DBEditColor23: TDBEditColor;
    Label21: TLabel;
    DBEditColor24: TDBEditColor;
    Label22: TLabel;
    DBEditColor25: TDBEditColor;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    DBEditColor26: TDBEditColor;
    DBEditColor27: TDBEditColor;
    DBEditColor28: TDBEditColor;
    Label26: TLabel;
    Label27: TLabel;
    Label33: TLabel;
    DBEditColor29: TDBEditColor;
    DBEditColor30: TDBEditColor;
    DBEditColor31: TDBEditColor;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    DBEditColor32: TDBEditColor;
    DBEditColor33: TDBEditColor;
    DBEditColor34: TDBEditColor;
    Label39: TLabel;
    DBEditColor35: TDBEditColor;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    DBEditColor36: TDBEditColor;
    DBEditColor37: TDBEditColor;
    DBEditColor38: TDBEditColor;
    Label50: TLabel;
    DBEditColor39: TDBEditColor;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ImprimeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    IMP : TFuncoesImpressao;
    Porta : String;
  public
    procedure CarregaComandos( SeqImp : Integer; PortaImpressao : String );
  end;

var
  FComandosImpressora: TFComandosImpressora;

implementation

uses APrincipal, Constantes, FunSql, FunString, UnClassesImprimir;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFComandosImpressora.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
  AdicionaSQLAbreTabela(CAD_DRIVER, 'SELECT * FROM CAD_DRIVER WHERE I_COD_DRV IS NULL');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFComandosImpressora.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IMP.Destroy;
  CAD_DRIVER.close;
  Action := CaFree;
end;

{**************** fecha o formulario **************************************** }
procedure TFComandosImpressora.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFComandosImpressora.CarregaComandos( SeqImp : Integer; PortaImpressao : String );
begin
  AdicionaSQLAbreTabela(CAD_DRIVER, ' Select * from cad_driver where i_seq_imp = ' + IntTostr(SeqImp) );
  porta := PortaImpressao;
  Self.ShowModal;
end;


{************ testa os comandos avancados *********************************** }
procedure TFComandosImpressora.ImprimeClick(Sender: TObject);
begin
  with IMP do
  begin
    case (Sender as TComponent).Tag of
      01 : ImprimeComando(DBEditColor01.Text, DChar.Text, '', Porta);
      02 : ImprimeComando(DBEditColor02.Text, DChar.Text, '', Porta);
      03 : ImprimeComando(DBEditColor03.Text, DChar.Text, 'TESTE. ATIVA NEGRITO.', Porta);
      04 : ImprimeComando(DBEditColor04.Text, DChar.Text, 'TESTE. DESATIVA NEGRITO.', Porta);
      05 : ImprimeComando(DBEditColor05.Text, DChar.Text, 'TESTE. ATIVA ITALICO.', Porta);
      06 : ImprimeComando(DBEditColor06.Text, DChar.Text, 'TESTE. DESATIVA ITALICO.', Porta);
      07 : ImprimeComando(DBEditColor07.Text, DChar.Text, 'TESTE. ATIVA CONDENSADO.', Porta);
      08 : ImprimeComando(DBEditColor08.Text, DChar.Text, 'TESTE. DESATIVA CONDENSADO.', Porta);
      09 : ImprimeComando(DBEditColor09.Text, DChar.Text, 'TESTE. ATIVA LINHA REDUZIDA.', Porta);
      10 : ImprimeComando(DBEditColor10.Text, DChar.Text, 'TESTE. DESATIVA LINHA REDUZIDA', Porta);
      11 : ImprimeComando(DBEditColor11.Text, DChar.Text, 'TESTE. ATIVA CARACTERE REDUZIDO', Porta);
      12 : ImprimeComando(DBEditColor12.Text, DChar.Text, 'TESTE. DESATIVA CARACTERE REDUZIDO', Porta);
      13 : ImprimeComando(DBEditColor14.Text, DChar.Text, ' ', Porta);
      14 : ImprimeComando(DBEditColor14.Text, DChar.Text, ' ', Porta);
      15 : ImprimeComando(DBEditColor15.Text, DChar.Text, ' ', Porta);
      16 : ImprimeComando(DBEditColor16.Text, DChar.Text, ' ', Porta);
    end;
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


procedure TFComandosImpressora.BitBtn1Click(Sender: TObject);
var
  Texto : TextFile;
  I: Integer;
  caracter : string;
begin
    AssignFile(Texto, Porta);
    Rewrite(Texto);
    writeln(texto, '   Mapa de Caracteres');
    writeln(texto, '------------------------------------------------------------------------');
    for I := 0  to 50 do
    begin
      if not (i in [0..32]) then
        caracter := AdicionaCharE('0', InttoStr(i),3) + ' - ' + char(i) + '       '
      else
        caracter := AdicionaCharE('0', InttoStr(i),3) + ' - ' + ' ' + '       ';

      caracter := caracter + AdicionaCharE('0',InttoStr(i+50),3) + ' - ' + char(i+50) + '       '  +
                               AdicionaCharE('0',InttoStr(i+100),3) + ' - ' + char(i+100) + '      '  +
                               AdicionaCharE('0',InttoStr(i+150),3) + ' - ' + char(i+150) + '      '  +
                               AdicionaCharE('0',InttoStr(i+200),3) + ' - ' + char(i+200) ;
        writeln(texto, caracter);
    end;
    CloseFile(Texto);
end;

procedure TFComandosImpressora.BitBtn3Click(Sender: TObject);
var
  Texto : TextFile;
begin
    AssignFile(Texto, Porta);
    Rewrite(Texto);
    writeln(texto, '   Caracteres Configurado  -  '  + CAD_DRIVER.FieldByName('c_nom_imp').asstring );
    writeln(texto, '------------------------------------------------------------------------');

    writeln(texto, Char(CAD_DRIVER.FieldByName('I_AMI_TIO').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMI_TIO').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_AMA_TIO').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMA_TIO').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_AMI_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMI_AGU').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_AMA_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMA_AGU').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_AMI_CRA').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMI_CRA').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_AMA_CRA').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMA_CRA').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_AMI_CIR').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMI_CIR').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_AMA_CIR').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMA_CIR').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_AMI_TRE').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMI_TRE').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_AMA_TRE').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMA_TRE').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_EMI_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_EMI_AGU').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_EMA_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_EMA_AGU').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_EMI_CIR').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_EMI_CIR').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_EMA_CIR').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_EMA_CIR').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_IMI_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_IMI_AGU').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_IMA_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_IMA_AGU').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_OMI_TIO').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMI_TIO').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_OMA_TIO').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMA_TIO').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_OMI_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMI_AGU').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_OMI_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMA_AGU').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_OMI_CIR').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMI_CIR').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_OMA_CIR').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMA_CIR').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_OMI_TRE').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMI_TRE').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_OMA_TRE').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMA_TRE').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_UMI_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_UMI_AGU').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_UMA_AGU').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_UMA_AGU').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_UMI_TRE').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_UMI_TRE').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_UMA_TRE').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_UMA_TRE').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_CMI_CED').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_CMI_CED').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_CMA_CED').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_CMA_CED').AsString );
    writeln(texto, Char(CAD_DRIVER.FieldByName('I_AMI_NUM').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_AMI_NUM').AsString +  '           ' +
                   Char(CAD_DRIVER.FieldByName('I_OMA_NUM').asinteger) + ' : ' + CAD_DRIVER.FieldByName('I_OMA_NUM').AsString );
    writeln(texto, ' ');
  CloseFile(texto);

end;

Initialization
  RegisterClasses([TFComandosImpressora]);
end.


