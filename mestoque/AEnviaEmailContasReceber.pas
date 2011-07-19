unit AEnviaEmailContasReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Gauges;

type
  TFEmailContasReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BEnviar: TBitBtn;
    Gauge1: TGauge;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
  private
  public
    procedure EnviarEmails(VpaCodFilial, VpaSeqEmail: Integer);
  end;

var
  FEmailContasReceber: TFEmailContasReceber;

implementation
uses
  APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEmailContasReceber.FormCreate(Sender: TObject);
begin
  { abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEmailContasReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEmailContasReceber.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFEmailContasReceber.BEnviarClick(Sender: TObject);
begin
  Label1.Visible:= True;
  // Falar com o rafael para fazer a rotina de enviar os emails.
end;

{******************************************************************************}
procedure TFEmailContasReceber.EnviarEmails(VpaCodFilial, VpaSeqEmail: Integer);
begin
  ShowModal;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEmailContasReceber]);
end.
