unit ASangriaSuprimento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, Mask, numericos, UnECF;

type
  TFSangriaSuprimento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOK: TBitBtn;
    BCancelar: TBitBtn;
    Label1: TLabel;
    EValor: Tnumerico;
    Label2: TLabel;
    EMotivo: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
    VprIndSuprimento,
    VprAcao : Boolean;
    FunECF : TRBFuncoesECF;
  public
    { Public declarations }
    function RetiradaCaixa : boolean;
    function SuprimentoCaixa : boolean;
  end;

var
  FSangriaSuprimento: TFSangriaSuprimento;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFSangriaSuprimento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao :=false;
  VprIndSuprimento := false;
  FunECF := TRBFuncoesECF.cria(nil,FPrincipal.BaseDados);
end;

{******************************************************************************}
function TFSangriaSuprimento.RetiradaCaixa: boolean;
begin
  self.Caption := 'Retirada Caixa';
  PainelGradiente1.Caption := '   '+self.Caption;
  VprIndSuprimento := false;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFSangriaSuprimento.SuprimentoCaixa: boolean;
begin
  self.Caption := 'Suprimento Caixa';
  PainelGradiente1.Caption := '   '+self.Caption;
  VprIndSuprimento := true;
  showmodal;
  result := VprAcao;
end;

{ *************************************************************************** }
procedure TFSangriaSuprimento.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  Close;
end;

{******************************************************************************}
procedure TFSangriaSuprimento.BOKClick(Sender: TObject);
begin
  if VprIndSuprimento then
    FunECF.Suprimento(EValor.AValor,EMotivo.Text)
  else
    FunECF.Sangria(EValor.AValor,EMotivo.Text);
  VprAcao := true;
  Close;
end;

procedure TFSangriaSuprimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunECF.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSangriaSuprimento]);
end.
