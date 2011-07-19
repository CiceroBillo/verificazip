unit ACalendarioCelulaTrabalho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, ComCtrls, Db, DBTables;

type
  TFCalendarioCelulaTrabalho = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    BGerar: TBitBtn;
    BCancelar: TBitBtn;
    CalendarioBase: TQuery;
    CalendarioCelula: TQuery;
    CalendarioCelulaCODCELULA: TIntegerField;
    CalendarioCelulaDATCELULA: TDateField;
    DataCalendarioCelula: TDataSource;
    BInserir: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
    procedure EDatInicioChange(Sender: TObject);
    procedure GridIndice1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BInserirClick(Sender: TObject);
  private
    VprCodCelula : Integer;
    { Private declarations }
    procedure atualizaconsulta;
    function ExisteData(VpaData : tDateTime) : Boolean;
  public
    { Public declarations }
    procedure CalendarioCelulaTrabalho(VpaCodCelula : Integer);
  end;

var
  FCalendarioCelulaTrabalho: TFCalendarioCelulaTrabalho;

implementation

uses APrincipal, FunData, FunSql, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCalendarioCelulaTrabalho.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCalendarioCelulaTrabalho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Calendariocelula.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCalendarioCelulaTrabalho.atualizaconsulta;
begin
  AdicionaSQLAbreTabela(CalendarioCelula,'select * from CALENDARIOCELULATRABALHO '+
                                         ' Where ' +SQLTextoDataEntreAAAAMMDD('DATCELULA',EDatInicio.Datetime,EDatFim.Datetime,false)+
                                         ' and CODCELULA = '+ IntToStr(VprCodCelula)+
                                         ' order by DATCELULA');
end;

{******************************************************************************}
procedure TFCalendarioCelulaTrabalho.CalendarioCelulaTrabalho(VpaCodCelula : Integer);
begin
  VprCodCelula := VpaCodCelula;
  atualizaconsulta;
  Showmodal;
end;

{******************************************************************************}
function TFCalendarioCelulaTrabalho.ExisteData(VpaData : tDateTime) : Boolean;
begin
  AdicionaSqlabreTabela(CalendarioBase,'Select * from CALENDARIOCELULATRABALHO '+
                                       ' Where CODCELULA = '+Inttostr(VprCodCelula)+
                                       ' and DATCELULA = '+SQLTextoDataAAAAMMMDD(VpaData));
  result := not Calendariobase.eof;
  Calendariobase.close;
end;

{******************************************************************************}
procedure TFCalendarioCelulaTrabalho.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCalendarioCelulaTrabalho.BGerarClick(Sender: TObject);
begin
  ExecutaComandoSql(CalendarioBase,'Delete from CALENDARIOCELULATRABALHO '+
                                   ' Where '+SQLTextoDataEntreAAAAMMDD('DATCELULA',EDatInicio.DateTime,EDatFim.DateTime,false)+
                                   ' and CODCELULA = '+IntToStr(VprCodCelula) );
  AdicionaSQLAbreTabela(CalendarioBase,'Select * from CALENDARIOBASE'+
                                       ' Where '+SQLTextoDataEntreAAAAMMDD('DATBASE',EDatInicio.DateTime,EDatFim.DateTime,false));
  While not CalendarioBase.Eof do
  begin
    CalendarioCelula.insert;
    CalendarioCelulaCODCELULA.AsInteger := VprCodCelula;
    CalendarioCelulaDATCELULA.AsDatetime := CalendarioBase.FieldByName('DATBASE').AsDateTime;
    CalendarioCelula.post;
    CalendarioBase.Next;
  end;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCalendarioCelulaTrabalho.EDatInicioChange(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCalendarioCelulaTrabalho.GridIndice1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 46 then
    if Confirmacao(CT_DeletaRegistro) then
      CalendarioCelula.delete;
end;

{******************************************************************************}
procedure TFCalendarioCelulaTrabalho.BInserirClick(Sender: TObject);
var
  VpfData : TDatetime;
begin
  VpfData := date;
  if EntraData('Data da Celula de trabalho','Data : ',VpfData) then
  begin
    if not existeDAta(VpfData) then
    begin
      CalendarioCelula.Insert;
      CalendarioCelulaCODCELULA.AsInteger := VprCodCelula;
      CalendarioCelulaDATCELULA.AsDatetime := VpfData;
      CalendarioCelula.Post;
      AtualizaConsulta;
    end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCalendarioCelulaTrabalho]);
end.
