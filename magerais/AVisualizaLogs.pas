unit AVisualizaLogs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, Db, DBTables, Grids, DBGrids,
  Tabela, DBKeyViolation, StdCtrls, DBCtrls, Buttons, ComCtrls, DBClient;

type
  TFVisualizaLogs = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    DBMemoColor1: TDBMemoColor;
    GridIndice1: TGridIndice;
    Log: TSQL;
    DataLog: TDataSource;
    LogSEQ_LOG: TFMTBCDField;
    LogDAT_LOG: TSQLTimeStampField;
    LogCOD_USUARIO: TFMTBCDField;
    LogDES_LOG: TWideStringField;
    LogNOM_TABELA: TWideStringField;
    LogNOM_CAMPO: TWideStringField;
    LogVAL_ANTERIOR: TWideStringField;
    LogVAL_ATUAL: TWideStringField;
    LogNOM_MODULO_SISTEMA: TWideStringField;
    LogDES_INFORMACOES: TWideStringField;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    ENomTabela: TComboBoxColor;
    Label3: TLabel;
    EObservacao: TEditColor;
    Label4: TLabel;
    LogNOM_COMPUTADOR: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EDatInicioChange(Sender: TObject);
    procedure EObservacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FVisualizaLogs: TFVisualizaLogs;

implementation

uses APrincipal,Funsql, Fundata;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFVisualizaLogs.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVisualizaLogs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Log.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFVisualizaLogs.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFVisualizaLogs.EDatInicioChange(Sender: TObject);
begin
  atualizaConsulta;
end;

{******************************************************************************}
procedure TFVisualizaLogs.AtualizaConsulta;
begin
  Log.Close;
  Log.Sql.Clear;
  Log.sql.Add('Select * from LOG ');
  Log.sql.add('Where ' +SQLTextoDataEntreAAAAMMDD('DAT_LOG',EDatInicio.Datetime,EDatFim.Datetime,false));
  if ENomTabela.ItemIndex > 0 then
    Log.sql.add('And NOM_TABELA = '''+ENomTabela.Text+'''');
  if EObservacao.text <> '' then
    Log.Sql.add('and DES_INFORMACOES LIKE ''%'+EObservacao.Text+'%''');  
  Log.Sql.add('order by DAT_LOG');
  Log.Open;
end;

procedure TFVisualizaLogs.EObservacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFVisualizaLogs]);
end.
