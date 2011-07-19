unit AVisualizaEstatisticaConsulta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, Db, DBTables, DBCtrls, ComCtrls,
  Localizacao;

type
  TFVisualizaEstatisticaConsulta = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    PageControl1: TPageControl;
    PConsulta: TTabSheet;
    GridIndice1: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    Splitter1: TSplitter;
    Estatistica: TQuery;
    EstatisticaCODUSUARIO: TIntegerField;
    EstatisticaC_NOM_USU: TStringField;
    EstatisticaDATCONSULTA: TDateTimeField;
    EstatisticaNOMMODULO: TStringField;
    EstatisticaNOMTELA: TStringField;
    DataEstatistica: TDataSource;
    BFechar: TBitBtn;
    Label8: TLabel;
    Label10: TLabel;
    Data1: TCalendario;
    data2: TCalendario;
    PUsuarios: TTabSheet;
    GridIndice2: TGridIndice;
    UsuarioConsulta: TQuery;
    DataUsuarioConsulta: TDataSource;
    UsuarioConsultaQTD: TIntegerField;
    UsuarioConsultaC_NOM_USU: TStringField;
    Localiza: TConsultaPadrao;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    Label1: TLabel;
    EUsuario: TEditLocaliza;
    EstatisticaDESSQL: TMemoField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsultaGeral;
    procedure AdicionaFiltros(VpaConsulta : TStrings);
    procedure AtualizaConsultaUsuario;
  public
    { Public declarations }
  end;

var
  FVisualizaEstatisticaConsulta: TFVisualizaEstatisticaConsulta;

implementation

uses APrincipal, funSql, funData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFVisualizaEstatisticaConsulta.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Data1.DateTime := date;
  data2.DateTime := date;
  AtualizaconsultaGeral;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVisualizaEstatisticaConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Estatistica.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFVisualizaEstatisticaConsulta.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFVisualizaEstatisticaConsulta.AtualizaConsultaGeral;
begin
  Estatistica.Sql.clear;
  Estatistica.sql.add('select  EST.CODUSUARIO, USU.C_NOM_USU, EST.DATCONSULTA, EST.NOMMODULO, EST.NOMTELA, EST.DESSQL ' +
                      ' from ESTATISTICACONSULTA EST, CADUSUARIOS USU '+
                      ' Where USU.I_COD_USU = EST.CODUSUARIO ');
  AdicionaFiltros(Estatistica.sql);
  Estatistica.sql.ADD('order by DATCONSULTA');
  estatistica.open;
end;

{******************************************************************************}
procedure TFVisualizaEstatisticaConsulta.AdicionaFiltros(VpaConsulta : TStrings);
begin
  VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('DATCONSULTA',Data1.DateTime,INCdia(data2.DATETIME,1),true));
  if EUsuario.AInteiro <> 0 then
    VpaConsulta.add('and CODUSUARIO = '+EUsuario.Text);
end;

{******************************************************************************}
procedure TFVisualizaEstatisticaConsulta.AtualizaConsultaUsuario;
begin
  UsuarioConsulta.sql.clear;
  UsuarioConsulta.sql.add('select COUNT(SEQESTATISTICA) QTD, C_NOM_USU '+
                          ' from estatisticaconsulta EST, CADUSUARIOS USU '+
                          ' Where EST.CODUSUARIO = USU.I_COD_USU ');
  AdicionaFiltros(UsuarioConsulta.sql);
  UsuarioConsulta.sql.add('GROUP BY USU.C_NOM_USU '+
                          ' order by 1');
  UsuarioConsulta.open;
end;

{******************************************************************************}
procedure TFVisualizaEstatisticaConsulta.Data1CloseUp(Sender: TObject);
begin
  AtualizaConsultaGeral;
end;

{******************************************************************************}
procedure TFVisualizaEstatisticaConsulta.PageControl1Change(
  Sender: TObject);
begin
  if PageControl1.ActivePage = PConsulta then
    AtualizaConsultaGeral
  else
    if PageControl1.ActivePage = PUsuarios then
      AtualizaConsultaUsuario;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFVisualizaEstatisticaConsulta]);
end.
