unit AVersaoDesatualizada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, DB, DBClient, Tabela, StdCtrls,
  ExtCtrls, Componentes1, Buttons,ShellAPI;

type
  TFVersaoDesatualizada = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    LVersaoAtual: TLabel;
    Tabela: TSQL;
    BAtualizar: TBitBtn;
    Label3: TLabel;
    LNovaVesao: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BAtualizarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function VersaoSistemaPedidosValida : Boolean;
  end;

var
  FVersaoDesatualizada: TFVersaoDesatualizada;

implementation

uses APrincipal, FunSql, FunString, UnVersoes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFVersaoDesatualizada.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ *************************************************************************** }
function TFVersaoDesatualizada.VersaoSistemaPedidosValida: Boolean;
begin
  result := true;
  AdicionaSQLAbreTabela(Tabela,'Select C_SIP_OBR FROM CFG_GERAL ');
  if StrtoFloat(SubstituiStr(Tabela.FieldByName('C_SIP_OBR').AsString,'.',',')) > StrToFloat(SubstituiStr(VersaoSistemaPedido,'.',',')) then
  begin
    LVersaoAtual.Caption := VersaoSistemaPedido;
    LNovaVesao.Caption := Tabela.FieldByName('C_SIP_OBR').AsString;
    result := false;
    ShowModal;
  end;
end;

{ *************************************************************************** }
procedure TFVersaoDesatualizada.BAtualizarClick(Sender: TObject);
var
   URL : String;
begin
   URL := 'http://www.eficaciaconsultoria.com.br/downloads/Suporte/AtuSistemaPedido.exe';
   ShellExecute(handle, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
   close;
end;

{ *************************************************************************** }
procedure TFVersaoDesatualizada.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFVersaoDesatualizada.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFVersaoDesatualizada]);
end.
