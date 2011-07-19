unit ARegistroSistema;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, ExtCtrls, PainelGradiente, numericos, Mask,
  DBCtrls, Tabela, Db, DBTables, BotaoCadastro, Buttons, UnRegistro;

type
  TFRegistroSistema = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    EditColor1: TEditColor;
    EditColor2: TEditColor;
    EditColor3: TEditColor;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn4: TBitBtn;
    EditColor4: TEditColor;
    Label6: TLabel;
    Label7: TLabel;
    EditColor5: TEditColor;
    BitBtn5: TBitBtn;
    BBAjuda: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
    Reg : TRegistro;
    procedure carregaDadosRegistro;
    procedure Habilita( acao : Boolean );
  public
    { Public declarations }
  end;

var
  FRegistroSistema: TFRegistroSistema;

implementation

uses APrincipal, funHardware, funvalida, constmsg, fundata, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRegistroSistema.FormCreate(Sender: TObject);
begin
   Reg := TRegistro.Create;
   carregaDadosRegistro;
   Label2.Caption := NumeroSerie('C:\');
end;

{*************** carrega informacoes do registro ***************************** }
procedure TFRegistroSistema.CarregaDadosRegistro;
var
   Versao, Registro, Data, DataReg : string;
begin
reg.LeRegistroTexto(registro,versao,datareg,data);
EditColor1.Text := registro;
EditColor2.Text := data;
EditColor3.Text := DataReg;
EditColor5.Text := versao;
end;

{*********** habilita e desabilita os botoes do formulario ****************** }
procedure TFRegistroSistema.Habilita( acao : Boolean );
begin
 EditColor1.ReadOnly := acao;
 BitBtn1.Enabled := acao;
 BitBtn3.Enabled := not acao;
 BitBtn5.Enabled := not acao;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRegistroSistema.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Reg.Free;
 Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFRegistroSistema.BitBtn2Click(Sender: TObject);
begin
self.close;
end;

{********** inicia a alteracao do registro ********************************** }
procedure TFRegistroSistema.BitBtn1Click(Sender: TObject);
begin
Habilita(false);
EditColor1.clear;
EditColor1. SetFocus;
end;

{ ********************** Grava Novo Registro e atualiza o principal **********}
procedure TFRegistroSistema.BitBtn3Click(Sender: TObject);
begin
  if Reg.ValidaRegistro(EditColor1.text) then
  begin
    Habilita(true);
    Reg.GravaRegistro(EditColor1.text);
    carregaDadosRegistro;
    reg.ValidaModulo( FPrincipal.TipoSistema, [] );
    FPrincipal.MEmpresa.Enabled := true;
    FPrincipal.MMoeda.Enabled := true;
    FPrincipal.AlteraNomeEmpresa;
  end
  else
    EditColor1.SetFocus;
end;

{********** limpa o registro da maquina ************************************ }
procedure TFRegistroSistema.BitBtn4Click(Sender: TObject);
begin
 if reg.LimpaRegistro(editcolor4.Text) then
 begin
   EditColor4.Clear;
   EditColor1.Clear;
   EditColor2.Clear;
   EditColor3.Clear;
   EditColor5.Clear;
   reg.ValidaModulo( FPrincipal.TipoSistema, [FPrincipal.MEmpresa,FPrincipal.MMoeda] );
   FPrincipal.AlteraNomeEmpresa;
 end;
end;

{ ************* cancela uma alteracao de registro ************************** }
procedure TFRegistroSistema.BitBtn5Click(Sender: TObject);
begin
carregaDadosRegistro;
Habilita(true);
end;

procedure TFRegistroSistema.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FRegistroSistema.HelpContext);
end;

Initialization
 RegisterClasses([TFRegistroSistema]);
end.
