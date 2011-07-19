unit AReprocessaEstoque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Spin, UnProdutos;

type
  TFReprocessaEstoque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BReprocessar: TBitBtn;
    BFechar: TBitBtn;
    EMes: TSpinEditColor;
    EAno: TSpinEditColor;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BReprocessarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FReprocessaEstoque: TFReprocessaEstoque;

implementation

uses APrincipal, FunData, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFReprocessaEstoque.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EAno.Value := Ano(date);
  EMes.Value := mes(date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFReprocessaEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFReprocessaEstoque.BFecharClick(Sender: TObject);
begin
  close;
end;


{******************************************************************************}
procedure TFReprocessaEstoque.BReprocessarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunProdutos.ReprocessaEstoque(EMes.Value,EAno.Value);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    aviso('Reprocessado com sucesso!!!');
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFReprocessaEstoque]);
end.
