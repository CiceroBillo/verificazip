unit AAlteraVendedorCadastroCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  DBKeyViolation;

type
  TFAlteraVendedorCadastroCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BAlterar: TBitBtn;
    BFechar: TBitBtn;
    EVendedorOrigem: TRBEditLocaliza;
    BVendedor: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EVendedorDestino: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    ValidaGravacao1: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EVendedorOrigemChange(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAlteraVendedorCadastroCliente: TFAlteraVendedorCadastroCliente;

implementation

uses APrincipal, UnClientes, constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFAlteraVendedorCadastroCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ValidaGravacao1.execute;
end;

{ *************************************************************************** }
procedure TFAlteraVendedorCadastroCliente.BAlterarClick(Sender: TObject);
begin
  FunClientes.AlteraVendedorCadastroCliente(EVendedorOrigem.AInteiro,EVendedorDestino.AInteiro);
  aviso('Clientes Alterados com Sucesso!!!');
end;

{******************************************************************************}
procedure TFAlteraVendedorCadastroCliente.BFecharClick(Sender: TObject);
begin
  close;
end;


procedure TFAlteraVendedorCadastroCliente.EVendedorOrigemChange(
  Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

procedure TFAlteraVendedorCadastroCliente.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFAlteraVendedorCadastroCliente]);
end.
