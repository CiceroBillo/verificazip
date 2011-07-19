unit AEnvioEmarketing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  UnDados, ExtCtrls, StdCtrls, Buttons, Componentes1, ComCtrls, PainelGradiente, UnEmarketing;

type
  TFEnvioEmarketing = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    LNomeContaEmail: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LEmailDestino: TLabel;
    Label5: TLabel;
    LStatus: TLabel;
    Label4: TLabel;
    LQtdEmail: TLabel;
    BarraProgresso: TProgressBar;
    EEmails: TListBoxColor;
    PanelColor2: TPanelColor;
    BEnviar: TBitBtn;
    BFechar: TBitBtn;
    BInterromper: TBitBtn;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BEnviarClick(Sender: TObject);
    procedure BInterromperClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprSeqTarefa : Integer;
    VprDTarefa : TRBDTarefaEMarketing;
    FunEMarketing : TRBFuncoesEMarketing;
  public
    { Public declarations }
    procedure EnviaEmail(VpaSeqTarefa : Integer);
  end;

var
  FEnvioEmarketing: TFEnvioEmarketing;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFEnvioEmarketing.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEMarketing := TRBFuncoesEMarketing.cria(FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFEnvioEmarketing.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  VprDTarefa := TRBDTarefaEMarketing.cria;
  FunEmarketing.CarDTarefaEMarkegting(VprDTarefa,VprSeqTarefa);
  FunEmarketing.EnviaEMarketingCliente(VprDTarefa,LStatus,LNomeContaEmail,LEmailDestino,LQtdEmail, BarraProgresso,EEmails);
  VprDTarefa.Free;
end;

{ *************************************************************************** }
procedure TFEnvioEmarketing.BEnviarClick(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TFEnvioEmarketing.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFEnvioEmarketing.BInterromperClick(Sender: TObject);
begin
  VprDTarefa.IndInterromper := true;
end;

{******************************************************************************}
procedure TFEnvioEmarketing.EnviaEmail(VpaSeqTarefa: Integer);
begin
  VprSeqTarefa := VpaSeqTarefa;
  showmodal;
end;

{******************************************************************************}
procedure TFEnvioEmarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunEMarketing.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEnvioEmarketing]);
end.
