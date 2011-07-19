unit ACompensaCheque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ComCtrls, Componentes1, Localizacao, ExtCtrls, sqlexpr,
  PainelGradiente, unDadosCR;

type
  TFCompensaCheque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    Label28: TLabel;
    SpeedButton3: TSpeedButton;
    Label38: TLabel;
    EContaCorrente: TEditLocaliza;
    EDatCompensacao: TCalendario;
    Label1: TLabel;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDCheque : TRBDCheque;
    procedure CarDTela;
    procedure CarDClasse;
  public
    { Public declarations }
    function CompensaCheque(VpaDCheque : TRBDCheque):Boolean;
  end;

var
  FCompensaCheque: TFCompensaCheque;

implementation

uses APrincipal, UncontasAreceber, constMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCompensaCheque.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCompensaCheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCompensaCheque.CarDTela;
begin
  EContaCorrente.Text := VprDCheque.NumContaCaixa;
  EContaCorrente.Atualiza;
  EDatCompensacao.DateTime := date;
end;

{******************************************************************************}
procedure TFCompensaCheque.CarDClasse;
begin
  VprDCheque.NumContaCaixa := EContaCorrente.Text;
  VprDCheque.DatCompensacao := EDatCompensacao.DateTime;
end;

{******************************************************************************}
function TFCompensaCheque.CompensaCheque(VpaDCheque : TRBDCheque):boolean;
begin
  VprDCheque := VpaDCheque;
  CarDTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFCompensaCheque.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFCompensaCheque.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  CarDClasse;
  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(VpfTransacao);
  VpfResultado := FunContasAReceber.CompensaCheque(VprDCheque,VprDCheque.TipCheque,true);
  if VpfResultado <> '' then
  begin
    FPrincipal.BaseDados.Rollback(VpfTransacao);
    aviso(VpfResultado)
  end
  else
  begin
    FPrincipal.BaseDados.commit(VpfTransacao);
    VprAcao := true;
    Close;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCompensaCheque]);
end.



