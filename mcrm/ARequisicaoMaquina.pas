unit ARequisicaoMaquina;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, ExtCtrls, PainelGradiente, Buttons, Localizacao, UnAmostra,
  DBKeyViolation;

type
  TFRequisicaoMaquina = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EDescricao: TEditColor;
    Label1: TLabel;
    Label2: TLabel;
    EMaquina: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EMaquinaChange(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprCodAmostra : Integer;
    FunAmostra : TRBFuncoesAmostra;
  public
    { Public declarations }
    function NovaRequisicaoMaquina(VpaCodAmostra : Integer):boolean;
  end;

var
  FRequisicaoMaquina: TFRequisicaoMaquina;

implementation

uses APrincipal, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRequisicaoMaquina.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRequisicaoMaquina.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFRequisicaoMaquina.NovaRequisicaoMaquina(VpaCodAmostra : Integer):boolean;
begin
  VprCodAmostra := VpaCodAmostra;
  ValidaGravacao1.execute;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFRequisicaoMaquina.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFRequisicaoMaquina.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunAmostra.GravaRequisicaoMAquina(VprCodAmostra,EMaquina.AInteiro,EDescricao.text);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    close;
  end;
end;

{******************************************************************************}
procedure TFRequisicaoMaquina.EMaquinaChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRequisicaoMaquina]);
end.
