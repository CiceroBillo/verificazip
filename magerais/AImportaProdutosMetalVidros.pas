unit AImportaProdutosMetalVidros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, Gauges, UnMetalVidros;

type
  TFImportaProdutosMetalVidros = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Progresso: TGauge;
    LStatus: TLabel;
    BImportar: TBitBtn;
    BFechar: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BImportarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    FunMetalVidros : TRBFuncoesMetalVidros;
  public
    { Public declarations }
  end;

var
  FImportaProdutosMetalVidros: TFImportaProdutosMetalVidros;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFImportaProdutosMetalVidros.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunMetalVidros := TRBFuncoesMetalVidros.cria;
end;

{ *************************************************************************** }
procedure TFImportaProdutosMetalVidros.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFImportaProdutosMetalVidros.BImportarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if OpenDialog1.Execute then
  begin
    VpfResultado := FunMetalVidros.ImportaArquivo(OpenDialog1.FileName,Progresso,LStatus);
  end;
end;

{******************************************************************************}
procedure TFImportaProdutosMetalVidros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunMetalVidros.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImportaProdutosMetalVidros]);
end.
