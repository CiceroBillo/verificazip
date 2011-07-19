unit AImportaProdutosSolidWorks;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Gauges, UnPremer;

type
  TFImportaProdutosSolidWork = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BImportar: TBitBtn;
    BFechar: TBitBtn;
    Progresso: TGauge;
    OpenDialog1: TOpenDialog;
    LStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImportarClick(Sender: TObject);
  private
    { Private declarations }
    FunPremer : TRBFuncoesPremer;
  public
    { Public declarations }
  end;

var
  FImportaProdutosSolidWork: TFImportaProdutosSolidWork;

implementation

uses APrincipal, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImportaProdutosSolidWork.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunPremer := TRBFuncoesPremer.cria(FPRINCIPAL.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImportaProdutosSolidWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunPremer.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImportaProdutosSolidWork.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFImportaProdutosSolidWork.BImportarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if OpenDialog1.Execute then
  begin
    VpfREsultado := FunPremer.ImportaProjeto(OpenDialog1.FileName,Progresso,LStatus);
    if VpfResultado <> '' then
     aviso(VpfREsultado)
    else
     Aviso('Importação realizada com sucesso!!!');
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImportaProdutosSolidWork]);
end.
