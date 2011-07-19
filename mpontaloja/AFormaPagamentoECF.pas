unit AFormaPagamentoECF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Buttons, StdCtrls, Localizacao,
  Mask, numericos, DBKeyViolation, UnECF, ComCtrls, UnDadosCR, UnContasaReceber;

type
  TFFormaPagamentoECF = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EFormaPagamento: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    Label1: TLabel;
    LFormaPagamento: TLabel;
    SpeedButton1: TSpeedButton;
    EValPago: Tnumerico;
    Label3: TLabel;
    Label4: TLabel;
    EValTroco: Tnumerico;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    Label5: TLabel;
    EValTotal: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EFormaPagamentoChange(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EValPagoChange(Sender: TObject);
    procedure EValPagoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprAcao : Boolean;
    FunECF : TRBFuncoesECF;
    VprBarraStatus : TStatusBar;
    function DadosValidos : String;
  public
    { Public declarations }
    function MostraFormaPagamento(VpaDFormaPagamento : TRBDFormaPagamento; Var VpaValPago :Double; VpaValTotal : Double;VpaFunECF : TRBFuncoesECF):boolean;
  end;

var
  FFormaPagamentoECF: TFFormaPagamentoECF;

implementation

uses APrincipal, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFormaPagamentoECF.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormaPagamentoECF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFormaPagamentoECF.EFormaPagamentoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFFormaPagamentoECF.BOkClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado <> '' then
    aviso(VpfREsultado)
  else
  begin
    VprAcao := true;
    close;
  end;
end;

{******************************************************************************}
function TFFormaPagamentoECF.DadosValidos: String;
begin
  if EValTroco.AValor < 0 then
    result := 'VALOR DO TROCO INVÁLIDO!!!'#13'O valor do troco não pode ser menor que 0(zero)';
end;

{******************************************************************************}
procedure TFFormaPagamentoECF.BCancelarClick(Sender: TObject);
begin
  vprAcao := false;
  close;
end;

{******************************************************************************}
function TFFormaPagamentoECF.MostraFormaPagamento(VpaDFormaPagamento : TRBDFormaPagamento; Var VpaValPago :Double; VpaValTotal : Double;VpaFunECF : TRBFuncoesECF):Boolean;
begin
  FunECF := VpaFunECF;
  EValTotal.AValor := VpaValTotal;
  EFormaPagamento.AInteiro :=  VpaDFormaPagamento.CodForma;
  EFormaPagamento.Atualiza;
  Showmodal;
  result := VprAcao;
  if VprAcao then
  begin
    FunContasAReceber.CarDFormaPagamento(VpaDFormaPagamento,EFormaPagamento.AInteiro);
    VpaValPago := EValPago.AValor;
  end;
end;

{******************************************************************************}
procedure TFFormaPagamentoECF.EValPagoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
  if EValPago.Avalor <> 0 then
    EValTroco.AValor := EValPago.AValor - EValTotal.AValor
  else
    EValTroco.Clear;
end;

procedure TFFormaPagamentoECF.EValPagoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    FunECF.AbreGaveta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFormaPagamentoECF]);
end.
