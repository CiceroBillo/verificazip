unit AAlteraEstagioAgendamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Undados, Localizacao, ExtCtrls, Buttons, StdCtrls, Componentes1,
  PainelGradiente;

type
  TFAlteraEstagioAgendamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ECliente: TEditLocaliza;
    Label2: TLabel;
    BCliente: TSpeedButton;
    Label10: TLabel;
    EUsuario: TEditLocaliza;
    Label13: TLabel;
    BUsuario: TSpeedButton;
    Label14: TLabel;
    Bevel1: TBevel;
    EEstagio: TEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDAgenda : TRBDAgendaSisCorp;
    procedure CarDTela;
    function GravaDEstagio : string;
  public
    { Public declarations }
    function AlteraEstagioAgenda(VpaDAgenda : TRBDAgendaSisCorp) : Boolean;
  end;

var
  FAlteraEstagioAgendamento: TFAlteraEstagioAgendamento;

implementation

uses APrincipal, UnClientes, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioAgendamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioAgendamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioAgendamento.CarDTela;
begin
  ECliente.AInteiro := VprDAgenda.CodCliente;
  EUsuario.AInteiro := VprDAgenda.CodUsuario;
  ECliente.Atualiza;
  EUsuario.Atualiza;
end;

{******************************************************************************}
function TFAlteraEstagioAgendamento.GravaDEstagio : string;
begin
  if EEstagio.AInteiro = 0 then
    result := 'ESTAGIO NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo do estagio.';

  if result = '' then
  begin
    result := FunClientes.AlteraEstagioAgenda(VprDAgenda,EEstagio.AInteiro);
  end;
end;

{******************************************************************************}
function TFAlteraEstagioAgendamento.AlteraEstagioAgenda(VpaDAgenda : TRBDAgendaSisCorp) : Boolean;
begin
  VprDAgenda := VpaDAgenda;
  CarDTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFAlteraEstagioAgendamento.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := GravaDEstagio;
  if VpfResultado = '' then
  begin
    Vpracao := true;
    close;
  end
  else
    Aviso(VpfResultado);
end;

procedure TFAlteraEstagioAgendamento.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioAgendamento]);
end.
