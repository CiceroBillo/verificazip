unit AExportaRPS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls,
  Localizacao, UnExportaRPS, UnDados;

type
  TFExportaRPS = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BExportar: TBitBtn;
    BFechar: TBitBtn;
    Label1: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label2: TLabel;
    EFilial: TRBEditLocaliza;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExportarClick(Sender: TObject);
  private
    { Private declarations }
    VprDExportaRPS : TRBDExportacaoRPS;
    FunExportaRPS : TRBFuncoesExportaRPS;
    procedure CarDClasse;
  public
    { Public declarations }
  end;

var
  FExportaRPS: TFExportaRPS;

implementation

uses APrincipal, Constantes, FunDAta;

{$R *.DFM}


{ **************************************************************************** }
procedure TFExportaRPS.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.date := incdia(Varia.DatUltimoRPS,1);
  EDatFim.Date := decDia(date,1);
  EFilial.AInteiro := varia.CodigoEmpFil;
  EFilial.Atualiza;
  FunExportaRPS := TRBFuncoesExportaRPS.cria(FPrincipal.BaseDados);
  VprDExportaRPS := TRBDExportacaoRPS.cria;
end;

{ *************************************************************************** }
procedure TFExportaRPS.BExportarClick(Sender: TObject);
begin
  CarDClasse;
  FunExportaRPS.ExportaRPS(VprDExportaRPS,StatusBar1);

end;

{******************************************************************************}
procedure TFExportaRPS.BFecharClick(Sender: TObject);
begin
  close;
end;
{******************************************************************************}
procedure TFExportaRPS.CarDClasse;
begin
  VprDExportaRPS.CodFilial := EFilial.AInteiro;
  VprDExportaRPS.DatInicio := EDatInicio.Date;
  VprDExportaRPS.DatFim := EDatFim.Date;
end;

{******************************************************************************}
procedure TFExportaRPS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDExportaRPS.Free;
  FunExportaRPS.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFExportaRPS]);
end.
