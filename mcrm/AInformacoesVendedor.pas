unit AInformacoesVendedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao, UnVendedor,
  ComCtrls;

type
  TFInformacoesVendedor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    EVendedor: TRBEditLocaliza;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    ELog: TMemoColor;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label4: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    FunVendedor : TRBFuncoesVendedor;
  public
    { Public declarations }
  end;

var
  FInformacoesVendedor: TFInformacoesVendedor;

implementation

uses APrincipal, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFInformacoesVendedor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunVendedor := TRBFuncoesVendedor.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := Date;
  EDatFim.DateTime := date;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFInformacoesVendedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunVendedor.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFInformacoesVendedor.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFInformacoesVendedor.SpeedButton2Click(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := FunVendedor.EnviaPosicaoEstoqueEmail(EVendedor.AInteiro,ELog.Lines);
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFInformacoesVendedor.SpeedButton3Click(Sender: TObject);
Var
  VpfResultado : string;
begin
  VpfResultado := FunVendedor.EnviaResumoDiarioEmail(EVendedor.AInteiro,EDatInicio.DateTime,EDatFim.DateTime, ELog.Lines);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFInformacoesVendedor]);
end.
