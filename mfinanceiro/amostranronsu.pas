unit AMostraNroNSU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Buttons, ExtCtrls, PainelGradiente;

type
  TFMostraNroNSU = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    EditColor1: TEditColor;
    EditColor2: TEditColor;
    EditColor3: TEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AbreTela( NroNsu, data, hora : string );
  end;

var
  FMostraNroNSU: TFMostraNroNSU;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraNroNSU.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraNroNSU.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFMostraNroNSU.BitBtn1Click(Sender: TObject);
begin
  self.close;
end;

procedure TFMostraNroNSU.AbreTela( NroNsu, data, hora : string );
begin
  EditColor1.Text := NroNsu;
  EditColor2.Text := data;
  EditColor3.Text := hora;
  self.Show;
end;

Initialization
 RegisterClasses([TFMostraNroNSU]);
end.
