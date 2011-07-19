unit AHigienizarCadastros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, UnNfe, Buttons;

type
  TFHigienizarCadastros = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BarraStatus: TStatusBar;
    BHigienizar: TBitBtn;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    EErros: TMemoColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    ECorrigidos: TMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BHigienizarClick(Sender: TObject);
  private
    { Private declarations }
    FunNFE : TRBFuncoesNFe;
  public
    { Public declarations }
  end;

var
  FHigienizarCadastros: TFHigienizarCadastros;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHigienizarCadastros.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunNFE := TRBFuncoesNFe.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHigienizarCadastros.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFHigienizarCadastros.BHigienizarClick(Sender: TObject);
begin
  FunNFE.HigienizarCadastros(EErros.Lines,ECorrigidos.Lines,BarraStatus);
end;

{******************************************************************************}
procedure TFHigienizarCadastros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunNFE.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHigienizarCadastros]);
end.
