unit AGeraXMLSNGCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,UnSNGPC,
  ComCtrls;

type
  TFGeraXMLSNGPC = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
  private
    { Private declarations }
    FunSNGPC : TRBFuncoesSNGPC;
  public
    { Public declarations }
  end;

var
  FGeraXMLSNGPC: TFGeraXMLSNGPC;

implementation

uses APrincipal, Constmsg,Constantes, FunData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraXMLSNGPC.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunSNGPC := TRBFuncoesSNGPC.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := incdia(Varia.DatSNGPC,1);
  EDatFim.DateTime := decdia(date,1);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGeraXMLSNGPC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunSNGPC.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFGeraXMLSNGPC.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFGeraXMLSNGPC.BGerarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunSNGPC.GeraXMLSNGPC(EDatInicio.DateTime,EDatFim.DateTime);
  if VpfResultado <> '' then
    aviso(vpfresultado);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGeraXMLSNGPC]);
end.
