unit AAlteraEstagioChamado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, PainelGradiente, ExtCtrls, Componentes1,
  DBKeyViolation, Localizacao, UnChamado;

type
  TFAlteraEstagioChamado = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ConsultaPadrao1: TConsultaPadrao;
    EUsuario: TEditLocaliza;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    BChamado: TSpeedButton;
    Label1: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    ECodEstagio: TEditLocaliza;
    EChamado: TEditLocaliza;
    EEstagioAtual: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    EMotivo: TMemoColor;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure EChamadoRetorno(Retorno1, Retorno2: String);
    procedure EChamadoSelect(Sender: TObject);
    procedure EChamadoChange(Sender: TObject);
    procedure ECodEstagioRetorno(Retorno1, Retorno2: String);
    procedure ECodEstagioSelect(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprChamados : String;
    FunChamado : TRBFuncoesChamado;
    function DadosValidos : String;
  public
    { Public declarations }
    function AlteraEstagioChamado:Boolean;
    function AlteraEstagioChamados(VpaChamados : String):Boolean;
    function AlteraEstagio(VpaNumChamado : Integer):Boolean;
  end;

var
  FAlteraEstagioChamado: TFAlteraEstagioChamado;

implementation

uses APrincipal,Constantes, ConstMsg, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioChamado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunChamado := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
  VprChamados := '';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioChamado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunChamado.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioChamado.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAlteraEstagioChamado.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    if VprChamados = '' then
      VpfResultado := FunChamado.AlteraEstagioChamado(varia.CodigoEmpfil,EChamado.AInteiro,EUsuario.AInteiro,ECodEstagio.AInteiro,EMotivo.Lines.text)
    else
      VpfResultado := FunChamado.AlteraEstagioChamados(varia.CodigoEmpfil,EUsuario.AInteiro,ECodEstagio.AInteiro,VprChamados,EMotivo.Lines.Text);
    if VpfResultado = '' then
    begin
      VprAcao := true;
      close;
    end
  end;
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFAlteraEstagioChamado.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioChamado.EChamadoRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
    EEstagioAtual.Text := Retorno1
  else
    EEstagioAtual.clear;
  EEstagioAtual.Atualiza;

end;

{******************************************************************************}
procedure TFAlteraEstagioChamado.EChamadoSelect(Sender: TObject);
begin
  EChamado.ASelectValida.Text := 'Select CHA.NUMCHAMADO, CHA.CODESTAGIO, CLI.C_NOM_CLI '+
                                 ' from CHAMADOCORPO CHA, CADCLIENTES CLI '+
                                 ' Where CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                 ' AND CHA.NUMCHAMADO = @ '+
                                 ' AND CHA.CODFILIAL = ' +IntToStr(varia.CodigoEmpFil);
  EChamado.ASelectLocaliza.Text := 'Select CHA.NUMCHAMADO, CHA.CODESTAGIO, CLI.C_NOM_CLI '+
                                 ' from CHAMADOCORPO CHA, CADCLIENTES CLI '+
                                 ' Where CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                 ' AND CLI.C_NOM_CLI LIKE ''@%'''+
                                 ' AND CHA.CODFILIAL = ' +IntToStr(varia.CodigoEmpFil);
end;

{******************************************************************************}
function TFAlteraEstagioChamado.AlteraEstagioChamado:Boolean;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioChamado.AlteraEstagioChamados(VpaChamados : String):Boolean;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  VprChamados := VpaChamados;
  AlterarEnabledDet([EChamado,BChamado],false);
  EChamado.ACampoObrigatorio := false;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioChamado.AlteraEstagio(VpaNumChamado : Integer):Boolean;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  EChamado.AInteiro := VpaNumChamado;
  EChamado.Atualiza;
  ActiveControl := ECodEstagio;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioChamado.DadosValidos : String;
begin
  result := '';
  if EMotivo.ACampoObrigatorio then
    if EMotivo.Lines.Text = '' then
      result := 'MOTIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o motivo pelo qual se está mudando de estágio';
end;

{******************************************************************************}
procedure TFAlteraEstagioChamado.EChamadoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioChamado.ECodEstagioRetorno(Retorno1,Retorno2: String);
begin
  EMotivo.ACampoObrigatorio := false;
  if retorno1 <> '' then
  begin
    if Retorno1 = 'S' then
      EMotivo.ACampoObrigatorio := true;
  end;
end;

{******************************************************************************}
procedure TFAlteraEstagioChamado.ECodEstagioSelect(Sender: TObject);
begin
  ECodEstagio.ASelectLocaliza.Text := ' Select * from ESTAGIOPRODUCAO ' +
                                      '  Where  TIPEST = ''A'' '+
                                      ' AND NOMEST LIKE ''@%''';
  ECodEstagio.ASelectValida.Text   := ' Select * from ESTAGIOPRODUCAO  '+
                                      '  Where CODEST = @     ' +
                                      '    AND TIPEST = ''A'' ';
  if not (puAdministrador in varia.PermissoesUsuario)  then
    if (puCREstagiosAutorizados in varia.PermissoesUsuario) then
    begin
      // somente os estágios autorizados deste grupo de usuario
      ECodEstagio.ASelectLocaliza.Text := ECodEstagio.ASelectLocaliza.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
      ECodEstagio.ASelectValida.Text := ECodEstagio.ASelectValida.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
    end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioChamado]);
end.
