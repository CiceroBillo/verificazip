unit ACorpoEmailProposta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, UnDados;

type
  TFCorpoEmailProposta = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MCorpoEmail: TMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    VprAcao: Boolean;
  public
    { Public declarations }
    function ConfirmaCorpoEMail(var VpaCorpoEmail: String): boolean;
  end;

var
  FCorpoEmailProposta: TFCorpoEmailProposta;

implementation

uses APrincipal, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCorpoEmailProposta.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := False;

end;

{******************************************************************************}
procedure TFCorpoEmailProposta.BitBtn1Click(Sender: TObject);
begin
  VprAcao  := True;
end;

procedure TFCorpoEmailProposta.BitBtn2Click(Sender: TObject);
begin
  VprAcao := False;
end;

function TFCorpoEmailProposta.ConfirmaCorpoEMail(var VpaCorpoEmail: String): boolean;
begin
  MCorpoEmail.Lines.Text := VpaCorpoEmail;
  ShowModal;
  Result := VprAcao;
  if Result then
    VpaCorpoEmail := MCorpoEmail.Lines.Text;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCorpoEmailProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCorpoEmailProposta]);
end.
