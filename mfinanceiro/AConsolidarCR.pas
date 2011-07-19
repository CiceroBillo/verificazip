unit AConsolidarCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, DBKeyViolation, StdCtrls,
  Buttons, Localizacao, ComCtrls, Mask, numericos, UnDados, UnContasAReceber;

type
  TFConsolidarCR = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    Localiza: TConsultaPadrao;
    ECliente: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label18: TLabel;
    EDatVencimento: TCalendario;
    Label1: TLabel;
    EPerDesconto: Tnumerico;
    EValDesconto: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    EValTotal: Tnumerico;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EPerDescontoChange(Sender: TObject);
    procedure EValDescontoChange(Sender: TObject);
    procedure EClienteChange(Sender: TObject);
  private
    { Private declarations }
    VprDContas : TRBDContasConsolidadasCR;
    VprAcao : Boolean;
    VprOperacao : Integer;
    procedure InicializaTela;
    procedure CarDClasse;
    procedure CarDTela;
  public
    { Public declarations }
    function ConsolidarContas: Boolean;
  end;

var
  FConsolidarCR: TFConsolidarCR;

implementation

uses APrincipal, AContasAConsolidarCR,Constantes, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsolidarCR.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprDContas := TRBDContasConsolidadasCR.cria;
  VprOperacao := 1;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsolidarCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDContas.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFConsolidarCR.ConsolidarContas: Boolean;
begin
  InicializaTela;
  VprOperacao := 1;
  Showmodal;
end;

{******************************************************************************}
procedure TFConsolidarCR.BCancelarClick(Sender: TObject);
begin
  VprAcao := False;
  close;
end;

{******************************************************************************}
procedure TFConsolidarCR.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VprAcao := true;
  CarDClasse;
  VpfResultado :=  FunContasAReceber.GravaDContaConsolidada(VprDContas);
  if Vpfresultado = '' then
    close
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFConsolidarCR.InicializaTela;
begin
  EDatVencimento.DateTime := date;
end;

{******************************************************************************}
procedure TFConsolidarCR.CarDClasse;
begin
  VprDContas.CodFilial := varia.CodigoEmpFil;
  VprDContas.CodCliente := ECliente.AInteiro;
  VprDContas.DatVencimento := EDatVencimento.DateTime;
  VprDContas.PerDesconto := EPerDesconto.AValor;
  VprDContas.ValDesconto := EValDesconto.AValor;
  VprDContas.ValConsolidacao := EValTotal.AValor;
  FunContasAReceber.CarNroNotas(VprDContas);
end;

{******************************************************************************}
procedure TFConsolidarCR.CarDTela;
begin
  EDatVencimento.DateTime := VprDContas.DatVencimento;
  EValTotal.AValor := VprDContas.ValConsolidacao;
  ECliente.AInteiro := VprDContas.CodCliente;
  ECliente.Atualiza;
  EValDesconto.AValor := VprDContas.ValDesconto;
  EPerDesconto.AValor := VprDContas.PerDesconto;
end;

{******************************************************************************}
procedure TFConsolidarCR.BitBtn1Click(Sender: TObject);
begin
  CarDClasse;
  FContasAConsolidarCR := TFContasAConsolidarCR.criarSDI(Application,'',FPrincipal.VerificaPermisao('FContasAConsolidarCR'));
  FContasAConsolidarCR.AdicionarContas(VprDContas);
  FContasAConsolidarCR.free;
  CarDTela;
end;

{******************************************************************************}
procedure TFConsolidarCR.EPerDescontoChange(Sender: TObject);
begin
  VprDContas.PerDesconto := EPerDesconto.AValor;
  VprDContas.ValConsolidacao := FunContasAReceber.RValTotalContas(VprDContas);
  EValTotal.AValor := VprDContas.ValConsolidacao;
end;

{******************************************************************************}
procedure TFConsolidarCR.EValDescontoChange(Sender: TObject);
begin
  VprDContas.ValDesconto := EValDesconto.AValor;
  VprDContas.ValConsolidacao := FunContasAReceber.RValTotalContas(VprDContas);
  EValTotal.AValor := VprDContas.ValConsolidacao;
end;

{******************************************************************************}
procedure TFConsolidarCR.EClienteChange(Sender: TObject);
begin
  if VprOperacao in [1,2] then
    ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsolidarCR]);
end.

