unit AAtualizaDiasTeleMarketing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Gauges, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnTeleMarketing;

type
  TFAtualizaDiasTelemarketing = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BAtualizar: TBitBtn;
    Gauge1: TGauge;
    BFechar: TBitBtn;
    Label1: TLabel;
    LNomCliente: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BAtualizarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    FunTeleMarketing : TRBFuncoesTeleMarketing;
  public
    { Public declarations }
  end;

var
  FAtualizaDiasTelemarketing: TFAtualizaDiasTelemarketing;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAtualizaDiasTelemarketing.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunTeleMarketing := TRBFuncoesTeleMarketing.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAtualizaDiasTelemarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunTeleMarketing.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFAtualizaDiasTelemarketing.BAtualizarClick(Sender: TObject);
begin
  FunTeleMarketing.AtualizaDiasTelemarketing(Gauge1,LNomCliente);
end;

procedure TFAtualizaDiasTelemarketing.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAtualizaDiasTelemarketing]);
end.
