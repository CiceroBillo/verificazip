unit AMostraObservacaoPedido;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons;

type
  TFMostraObservacaoPedido = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EObservacoes: TMemoColor;
    BOk: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MostraObservacao(VpaTexto : String);
  end;

var
  FMostraObservacaoPedido: TFMostraObservacaoPedido;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFMostraObservacaoPedido.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{******************************************************************************}
procedure TFMostraObservacaoPedido.MostraObservacao(VpaTexto: String);
begin
  EObservacoes.Lines.Text := VpaTexto;
  showmodal;
end;

{ *************************************************************************** }
procedure TFMostraObservacaoPedido.BOkClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMostraObservacaoPedido.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFMostraObservacaoPedido]);
end.
