unit AAlteraEstagioCotacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Localizacao, UnCotacao,
  DBKeyViolation;

type
  TFAlteraEstagioCotacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    EUsuario: TEditLocaliza;
    ECodEstagio: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    Label4: TLabel;
    ECotacao: TEditLocaliza;
    BCotacao: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    ValidaGravacao1: TValidaGravacao;
    EEstagioAtual: TEditLocaliza;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    EMotivo: TMemoColor;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure ECotacaoSelect(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ECodEstagioCadastrar(Sender: TObject);
    procedure ECotacaoRetorno(Retorno1, Retorno2: String);
    procedure ECodEstagioRetorno(Retorno1, Retorno2: String);
  private
    { Private declarations }
    VprCotacoes : String;
    VprAcao : Boolean;
    function DadosValidos : String;
    procedure LimpaCampos;
  public
    { Public declarations }
    function AlteraEstagio :boolean;
    function AlteraEstagioCotacoes(VpaCotacoes : String): Boolean;
  end;

var
  FAlteraEstagioCotacao: TFAlteraEstagioCotacao;

implementation

uses APrincipal, Constantes, ConstMsg, AEstagioProducao, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioCotacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{******************************************************************************}
procedure TFAlteraEstagioCotacao.LimpaCampos;
begin
   ECotacao.AInteiro:= 0;
   ECotacao.Atualiza;
   EEstagioAtual.AInteiro:= 0;
   EEstagioAtual.Atualiza;
   ECodEstagio.AInteiro:=0;
   ECodEstagio.Atualiza;
   EMotivo.Clear;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioCotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioCotacao.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAlteraEstagioCotacao.ECotacaoSelect(Sender: TObject);
begin
  ECotacao.ASelectLocaliza.Text := 'Select CLI.C_NOM_CLI, COT.I_LAN_ORC, COT.I_COD_EST '+
                                   ' from CADCLIENTES CLI, CADORCAMENTOS COT '+
                                   ' Where CLI.I_COD_CLI = COT.I_COD_CLI '+
                                   ' and COT.I_EMP_FIL = '+inttoStr(Varia.CodigoEmpFil)+
                                   ' and CLI.C_NOM_CLI LIKE ''@%''';
  ECotacao.ASelectValida.Text := 'Select CLI.C_NOM_CLI, COT.I_LAN_ORC, COT.I_COD_EST '+
                                   ' from CADCLIENTES CLI, CADORCAMENTOS COT '+
                                   ' Where CLI.I_COD_CLI = COT.I_COD_CLI '+
                                   ' and COT.I_EMP_FIL = '+inttoStr(Varia.CodigoEmpFil)+
                                   ' and COT.I_LAN_ORC = @';
end;

{******************************************************************************}
function TFAlteraEstagioCotacao.DadosValidos : String;
begin
  result := '';
  if EMotivo.ACampoObrigatorio then
    if EMotivo.Lines.Text = '' then
      result := 'MOTIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o motivo pelo qual se está mudando de estágio';
end;

{******************************************************************************}
procedure TFAlteraEstagioCotacao.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
function TFAlteraEstagioCotacao.AlteraEstagio :boolean;
begin
  EUsuario.Ainteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  showmodal;
  result := vpracao;
end;

{******************************************************************************}
function TFAlteraEstagioCotacao.AlteraEstagioCotacoes(VpaCotacoes : String): Boolean;
begin
  EUsuario.Ainteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  VprCotacoes := VpaCotacoes;
  AlterarEnabledDet([ECotacao,BCotacao],false);
  ECotacao.ACampoObrigatorio := false;
  showmodal;
  result := vpracao;
end;

{******************************************************************************}
procedure TFAlteraEstagioCotacao.BGravarClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    if VprCotacoes = '' then
      vpfResultado := FunCotacao.AlteraEstagioCotacao(Varia.CodigoEmpFil,EUsuario.AInteiro,ECotacao.AInteiro,ECodEstagio.AInteiro,EMotivo.Lines.text)
    else
      VpfResultado := FunCotacao.AlteraEstagioCotacoes(varia.CodigoEmpfil,EUsuario.AInteiro,ECodEstagio.AInteiro,VprCotacoes,EMotivo.lines.text);
  end;
  if vpfresultado = '' then
  begin
    VprAcao := true;
    LimpaCampos;
//    close;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFAlteraEstagioCotacao.ECodEstagioCadastrar(Sender: TObject);
begin
  FEstagioProducao := TFEstagioProducao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FEstagioProducao'));
  FEstagioProducao.BotaoCadastrar1.Click;
  FEstagioProducao.showmodal;
  FEstagioProducao.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAlteraEstagioCotacao.ECotacaoRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
    EEstagioAtual.Text := Retorno1
  else
    EEstagioAtual.clear;
  EEstagioAtual.Atualiza;
end;

{******************************************************************************}
procedure TFAlteraEstagioCotacao.ECodEstagioRetorno(Retorno1,
  Retorno2: String);
begin
  EMotivo.ACampoObrigatorio := false;
  if retorno1 <> '' then
  begin
    if Retorno1 = 'S' then
      EMotivo.ACampoObrigatorio := true;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioCotacao]);
end.





