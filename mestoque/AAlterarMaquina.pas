unit AAlterarMaquina;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnDados, UnOrdemProducao,
  Localizacao, UnDadosProduto;

type
  TFAlterarMaquina = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    EMaquina: TEditLocaliza;
    Label11: TLabel;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    Localiza: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDOrdemProducao : TRBDOrdemProducaoEtiqueta;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
  public
    { Public declarations }
    function AlteraMaquina(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta):Boolean;
  end;

var
  FAlterarMaquina: TFAlterarMaquina;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlterarMaquina.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlterarMaquina.FormClose(Sender: TObject; var Action: TCloseAction);
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
function TFAlterarMaquina.AlteraMaquina(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta):Boolean;
begin
  EMaquina.AInteiro := VpaDOrdemProducao.CodMaquina;
  EMaquina.Atualiza;
  VprDOrdemProducao := VpaDOrdemProducao;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFAlterarMaquina.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAlterarMaquina.BOkClick(Sender: TObject);
begin
  if EMaquina.AInteiro <> 0 then
  begin
    VprDOrdemProducao.CodMaquina := EMaquina.AInteiro;
    FunOrdemProducao.AlteraMaquina(VprDOrdemProducao);
  end;
  VprAcao := true;
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlterarMaquina]);
end.
