unit AVisualizaLogReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, DBCtrls, Tabela, Grids, DBGrids, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, Buttons, Db, DBTables, DBClient;

type
  TFVisualizaLogReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Log: TSQL;
    DataLog: TDataSource;
    LogSEQLOG: TFMTBCDField;
    LogDATLOG: TSQLTimeStampField;
    LogDESLOG: TWideStringField;
    LogDESMODULO: TWideStringField;
    LogNOMCOMPUTADOR: TWideStringField;
    LogDESINFORMACOES: TWideStringField;
    LogC_NOM_USU: TWideStringField;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprCodFilial,
    VprLanreceber,
    VprNumParcela : Integer;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    procedure VisualizaLog(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
  end;

var
  FVisualizaLogReceber: TFVisualizaLogReceber;

implementation

uses APrincipal, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFVisualizaLogReceber.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVisualizaLogReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFVisualizaLogReceber.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFVisualizaLogReceber.AtualizaConsulta;
begin
  AdicionaSQLAbreTabela(Log,'select LOG.SEQLOG, LOG.DATLOG, LOG.DESLOG, LOG.DESMODULO, '+
                           ' LOG.NOMCOMPUTADOR, LOG.DESINFORMACOES, USU.C_NOM_USU '+
                           ' from LOGCONTASARECEBER LOG, CADUSUARIOS USU '+
                           ' Where LOG.CODUSUARIO = USU.I_COD_USU'+
                           ' and LOG.CODFILIAL = '+IntTostr(VprCodfilial)+
                           ' and LOG.LANRECEBER = '+IntToStr(VprLanreceber)+
                           ' and LOG.NUMPARCELA = '+IntToStr(VprNumParcela)+
                           ' order by LOG.SEQLOG');
end;

{******************************************************************************}
procedure TFVisualizaLogReceber.VisualizaLog(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprLanReceber := VpaLanReceber;
  VprNumParcela := VpaNumparcela;
  AtualizaConsulta;
  Showmodal;
end;


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFVisualizaLogReceber]);
end.
