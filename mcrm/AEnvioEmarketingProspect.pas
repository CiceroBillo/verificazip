unit AEnvioEmarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, ComCtrls, UnEMarketingProspect, UnDados;

type
  TFEnvioEMarketingProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BEnviar: TBitBtn;
    BFechar: TBitBtn;
    BarraProgresso: TProgressBar;
    LNomeContaEmail: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LEmailDestino: TLabel;
    Label5: TLabel;
    LStatus: TLabel;
    EEmails: TListBoxColor;
    Label4: TLabel;
    LQtdEmail: TLabel;
    BInterromper: TBitBtn;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
    procedure BInterromperClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    VpfDTarefa : TRBDTarefaEMarketingProspect;
    FunEmarketingProspect : TRBFuncoesEMarketingProspect;
    VprSeqTarefa : Integer;
  public
    { Public declarations }
    procedure EnviaEmail(VpaSeqTarefa : Integer);
  end;

var
  FEnvioEMarketingProspect: TFEnvioEMarketingProspect;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFEnvioEMarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEmarketingProspect := TRBFuncoesEMarketingProspect.cria(FPrincipal.bASEdADOS);
end;

{******************************************************************************}
procedure TFEnvioEMarketingProspect.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  VpfDTarefa := TRBDTarefaEMarketingProspect.cria;
  FunEmarketingProspect.CarDTarefaEMarkegting(VpfDTarefa,VprSeqTarefa);
  FunEmarketingProspect.EnviaEMarketingProspect(VpfDTarefa,LStatus,LNomeContaEmail,LEmailDestino,LQtdEmail, BarraProgresso,EEmails);
  VpfDTarefa.Free;
end;

{ *************************************************************************** }
procedure TFEnvioEMarketingProspect.BEnviarClick(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

{******************************************************************************}
procedure TFEnvioEMarketingProspect.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFEnvioEMarketingProspect.BInterromperClick(Sender: TObject);
begin
  VpfDTarefa.IndInterromper := true;
end;

{******************************************************************************}
procedure TFEnvioEMarketingProspect.EnviaEmail(VpaSeqTarefa: Integer);
begin
  VprSeqTarefa := VpaSeqTarefa;
  showmodal;
end;

{******************************************************************************}
procedure TFEnvioEMarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunEmarketingProspect.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEnvioEMarketingProspect]);
end.
