unit AHistoricoECobranca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, FMTBcd, SqlExpr, DBClient;

type
  TFHistoricoECobranca = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    GridIndice1: TGridIndice;
    ECOBRANCAITEM: TSQL;
    DataECOBRANCAITEM: TDataSource;
    ECOBRANCAITEMDATENVIO: TSQLTimeStampField;
    ECOBRANCAITEMNOMFINANCEIRO: TWideStringField;
    ECOBRANCAITEMDESEMAIL: TWideStringField;
    ECOBRANCAITEMDESSTATUS: TWideStringField;
    ECOBRANCAITEMINDENVIADO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
  public
    { Public declarations }
    procedure HistoricoECobranca(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
  end;

var
  FHistoricoECobranca: TFHistoricoECobranca;

implementation

uses APrincipal, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHistoricoECobranca.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHistoricoECobranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFHistoricoECobranca.AtualizaConsulta(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
begin
  AdicionaSQLAbreTabela(ECOBRANCAITEM,'Select ITE.DATENVIO, ITE.NOMFINANCEIRO, ITE.DESEMAIL, ITE.DESSTATUS, ITE.INDENVIADO '+
                                      ' from ECOBRANCAITEM ITE '+
                                      ' Where ITE.CODFILIAL = '+IntToStr(VpaCodFilial)+
                                      ' and ITE.LANRECEBER = ' +IntToStr(VpaLanReceber)+
                                      ' and ITE.NUMPARCELA = '+InttoStr(VpaNumParcela)+
                                      ' order by ITE.DATENVIO');
end;

{******************************************************************************}
procedure TFHistoricoECobranca.HistoricoECobranca(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
begin
  AtualizaConsulta(VpaCodFilial,VpaLanReceber,VpaNumParcela);
  Showmodal;
end;

{******************************************************************************}
procedure TFHistoricoECobranca.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHistoricoECobranca]);
end.
