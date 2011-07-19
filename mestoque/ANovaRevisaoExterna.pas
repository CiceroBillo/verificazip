unit ANovaRevisaoExterna;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Localizacao, UnDadosProduto, UnordemProducao,
  DBKeyViolation;

type
  TFNovaRevisaoExterna = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    ECodUsuario: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure ECodUsuarioChange(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDColetaOP : TRBDColetaOP;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
  public
    { Public declarations }
    function NovaRevisaoExterna(VpaDColetaOP : TRBDColetaOP):Boolean;
  end;

var
  FNovaRevisaoExterna: TFNovaRevisaoExterna;

implementation

uses APrincipal,ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaRevisaoExterna.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaRevisaoExterna.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaRevisaoExterna.BOkClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if ECodUsuario.AInteiro <> 0 then
  begin
    VpfResultado := FunOrdemProducao.GravaDRevisaoExternaOP(VprDColetaOP,ECodUsuario.AInteiro);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      VprAcao := true;
      close;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaRevisaoExterna.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
function TFNovaRevisaoExterna.NovaRevisaoExterna(VpaDColetaOP : TRBDColetaOP):Boolean;
begin
  VprDColetaOP := VpaDColetaOP;
  ValidaGravacao1.execute;
  showmodal;
  result := vpracao;
end;

{******************************************************************************}
procedure TFNovaRevisaoExterna.ECodUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaRevisaoExterna]);
end.
