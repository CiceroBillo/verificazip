unit AAlteraEstagioProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Localizacao,
  DBKeyViolation, UnDados, UnOrdemProducao, Mask, numericos, UnDadosProduto;

type
  TFAlteraEstagioProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    EEstagio: TEditLocaliza;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    ENumeroOP: Tnumerico;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EEstagioChange(Sender: TObject);
    procedure ENumeroOPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDOrdem : TRBDOrdemProducaoEtiqueta;
    FunOrdem : TRBFuncoesOrdemProducao;
  public
    { Public declarations }
    function AlteraEstagio(VpaDOrdem : TRBDOrdemProducaoEtiqueta):Boolean;overload;
    function AlteraEstagio : Boolean;overload;
  end;

var
  FAlteraEstagioProducao: TFAlteraEstagioProducao;

implementation

uses APrincipal, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := False;
  FunOrdem := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdem.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioProducao.BGravarClick(Sender: TObject);
begin
  VprAcao := true;
  VprDOrdem.SeqOrdem := ENumeroOP.AsInteger;
  VprDOrdem.CodEstagio := EEstagio.AInteiro;
  FunOrdem.AlteraEstagio(VprDOrdem);
  close;
end;

{******************************************************************************}
procedure TFAlteraEstagioProducao.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAlteraEstagioProducao.EEstagioChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
function TFAlteraEstagioProducao.AlteraEstagio(VpaDOrdem : TRBDOrdemProducaoEtiqueta):Boolean;
begin
  VprDOrdem := VpaDOrdem;
  ENumeroOP.AValor := VpaDOrdem.SeqOrdem;
  ENumeroOP.ReadOnly := true;
  EEstagio.AInteiro := VpaDOrdem.CodEstagio;
  EEstagio.Atualiza;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioProducao.AlteraEstagio : Boolean;
begin
  VprDOrdem := TRBDOrdemProducaoEtiqueta.cria;
  VprDOrdem.CodEmpresafilial := varia.CodigoEmpFil;
  ENumeroOP.clear;
  EEstagio.clear;
  Showmodal;
  VprDOrdem.free;
  result := VprAcao;
end;

procedure TFAlteraEstagioProducao.ENumeroOPKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    ENumeroOP.Text := copy(ENumeroOP.Text,1,length(ENumeroOP.Text)-1);
    EEstagio.SetFocus;
  end;
end;

procedure TFAlteraEstagioProducao.EEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    EEstagio.Text := copy(EEstagio.Text,1,length(EEstagio.Text)-1);
    BGravar.Click;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioProducao]);
end.
