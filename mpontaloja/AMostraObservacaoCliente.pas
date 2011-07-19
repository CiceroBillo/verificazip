unit AMostraObservacaoCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Buttons, ExtCtrls, PainelGradiente, UnDados;

type
  TFMostraObservacaoCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    EObservacao: TMemoColor;
    BGravar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprCodCliente : Integer;
  public
    { Public declarations }
    procedure MostraObservacaoCliente(VpaDCliente : TRBDCliente);
  end;

var
  FMostraObservacaoCliente: TFMostraObservacaoCliente;

implementation

uses APrincipal, UnClientes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraObservacaoCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraObservacaoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMostraObservacaoCliente.MostraObservacaoCliente(VpaDCliente : TRBDCliente);
begin
  EObservacao.Lines.Text := VpaDCliente.DesObservacao;
  VprCodCliente := VpaDCliente.CodCliente;
  Showmodal;
end;

{******************************************************************************}
procedure TFMostraObservacaoCliente.BOkClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMostraObservacaoCliente.BGravarClick(Sender: TObject);
begin
  FunClientes.AlteraObservacaoCliente(VprCodCliente,EObservacao.Lines.Text);
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraObservacaoCliente]);
end.
