unit ACalendarioBase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Db, DBTables, Tabela, CBancoDados,
  Componentes1, ExtCtrls, PainelGradiente, Mask, DBCtrls, ComCtrls, Grids,
  DBGrids, DBKeyViolation, DBClient;

type
  TFCalendarioBase = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    CalendarioBase: TRBSQL;
    BFechar: TBitBtn;
    CalendarioBaseDATBASE: TDateField;
    DataCalendarioBase: TDataSource;
    GridIndice1: TGridIndice;
    BGerar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    CGerarSabado: TCheckBox;
    CGerarDomingo: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EDatInicioExit(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
    procedure GridIndice1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FCalendarioBase: TFCalendarioBase;

implementation

uses APrincipal, FunSql, FunData, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCalendarioBase.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.datetime := PrimeiroDiaMes(date);
  EDatFim.dateTime := UltimoDiaMes(date);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCalendarioBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CalendarioBase.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCalendarioBase.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCalendarioBase.AtualizaConsulta;
begin
  AdicionaSQLAbreTabela(CalendarioBase,'Select * from CALENDARIOBASE'+
                        ' Where ' +SQLTextoDataEntreAAAAMMDD('DATBASE',EDatInicio.Datetime,EDatFim.DateTime,false)+
                        ' order by DATBASE');
end;

{******************************************************************************}
procedure TFCalendarioBase.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCalendarioBase.BGerarClick(Sender: TObject);
var
  Vpfdata, VpfDatFim : TDateTime;
begin
  Vpfdata := date;
  if EntraData('Mês a ser gerado','Informe o Mês : ',Vpfdata) then
  begin
    Vpfdata := PrimeiroDiaMes(VpfData);
    VpfDatFim := UltimoDiaMes(VpfData);
    while VpfData <= VpfDatFim do
    begin
      if (CGerarSabado.Checked or (DiaSemanaNumerico(Vpfdata) <>7) ) and
         (CGerarDomingo.Checked  or (DiaSemanaNumerico(VpfData) <>1)) then
      begin
        CalendarioBase.Insert;
        CalendarioBaseDATBASE.AsDateTime := VpfData;
        try
          CalendarioBase.Post;
        except
        end;
      end;
      Vpfdata := IncDia(vpfData,1);
    end;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFCalendarioBase.GridIndice1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 46) then
    if CalendarioBase.State = dsbrowse then
      if Confirmacao(CT_DeletarItem) then
        CalendarioBase.Delete;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCalendarioBase]);
end.
