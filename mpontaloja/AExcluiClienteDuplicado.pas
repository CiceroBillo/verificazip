unit AExcluiClienteDuplicado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ComCtrls, Localizacao, Componentes1, ExtCtrls,
  PainelGradiente, UnClientes;

type
  TFExcluiClienteDuplicado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EClienteAExcluir: TEditLocaliza;
    Label1: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EClienteHistorico: TEditLocaliza;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FExcluiClienteDuplicado: TFExcluiClienteDuplicado;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFExcluiClienteDuplicado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFExcluiClienteDuplicado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFExcluiClienteDuplicado.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFExcluiClienteDuplicado.BExcluirClick(Sender: TObject);
begin
  FunClientes.ExcluiCliente(EClienteAExcluir.AInteiro,EClienteHistorico.AInteiro,StatusBar1);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFExcluiClienteDuplicado]);
end.
