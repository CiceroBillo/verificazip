unit ANovaMaquina;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ComCtrls, PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons,
  BotaoCadastro, Db, DBTables, Tabela, CBancoDados, Mask, DBCtrls,
  DBKeyViolation, DBClient;

type
  TFNovaMaquina = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BFechar: TBitBtn;
    MAQUINA: TRBSQL;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    MAQUINACODMAQ: TFMTBCDField;
    MAQUINANOMMAQ: TWideStringField;
    MAQUINAQTDFIO: TFMTBCDField;
    MAQUINAINDATI: TWideStringField;
    MAQUINACONKWH: TFMTBCDField;
    MAQUINAQTDRPM: TFMTBCDField;
    MAQUINAQTDBAR: TFMTBCDField;
    MAQUINAQTDLAN: TFMTBCDField;
    MAQUINALARBOC: TFMTBCDField;
    MAQUINAQTDCAR: TFMTBCDField;
    MAQUINAALTBOC: TFMTBCDField;
    PanelColor2: TPanelColor;
    DataMAQUINA: TDataSource;
    ValidaGravacao1: TValidaGravacao;
    PageControl1: TPageControl;
    PgBasico: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    DBEdit2: TDBEditColor;
    ECodigo: TDBKeyViolation;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor8: TDBEditColor;
    DBCheckBox1: TDBCheckBox;
    PgTear: TTabSheet;
    Label3: TLabel;
    DBEdit3: TDBEditColor;
    Label8: TLabel;
    DBEditColor4: TDBEditColor;
    Label9: TLabel;
    DBEditColor5: TDBEditColor;
    Label11: TLabel;
    DBEditColor7: TDBEditColor;
    MAQUINAINDDES: TWideStringField;
    CExigeDesenho: TDBCheckBox;
    MAQUINADATALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MAQUINAAfterEdit(DataSet: TDataSet);
    procedure MAQUINAAfterInsert(DataSet: TDataSet);
    procedure MAQUINABeforePost(DataSet: TDataSet);
    procedure PainelGradiente1Click(Sender: TObject);
    procedure ECodigoChange(Sender: TObject);
    procedure MAQUINAAfterPost(DataSet: TDataSet);
  private
  public
  end;

var
  FNovaMaquina: TFNovaMaquina;

implementation
uses
  APrincipal, AMaquinas, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaMaquina.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PageControl1.ActivePage:= PgBasico;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaMaquina.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaMaquina.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovaMaquina.MAQUINAAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= True;
end;

{******************************************************************************}
procedure TFNovaMaquina.MAQUINAAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.Readonly:= False;
  DBCheckBox1.Checked:= True;
  MAQUINAINDDES.AsString := 'N';
end;

{******************************************************************************}
procedure TFNovaMaquina.MAQUINAAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('MAQUINA');
end;

{******************************************************************************}
procedure TFNovaMaquina.MAQUINABeforePost(DataSet: TDataSet);
begin
  if MAQUINA.State = dsInsert then
    ECodigo.VerificaCodigoUtilizado;
  MAQUINADATALT.AsDateTime := Sistema.RDataServidor;
end;

procedure TFNovaMaquina.PainelGradiente1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaMaquina.ECodigoChange(Sender: TObject);
begin
  if MAQUINA.State in [dsinsert,dsedit] then
     ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaMaquina]);
end.
