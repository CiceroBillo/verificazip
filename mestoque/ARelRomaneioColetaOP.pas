unit ARelRomaneioColetaOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ComCtrls, Componentes1, ExtCtrls, PainelGradiente;

type
  TFRelRomaneioColetaOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EData: TCalendario;
    Label1: TLabel;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    CVisualizar: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelRomaneioColetaOP: TFRelRomaneioColetaOP;

implementation

uses APrincipal, AImpOrdemProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRelRomaneioColetaOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EData.DateTime := Date;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRelRomaneioColetaOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFRelRomaneioColetaOP.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRelRomaneioColetaOP]);
end.
