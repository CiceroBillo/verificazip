unit AAlteraEstagioPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, StdCtrls, Buttons, Componentes1, Localizacao, ExtCtrls,
  DBKeyViolation, UnPedidoCompra;

type
  TFAlteraEstagioPedidoCompra = class(TFormularioPermissao)
    Localiza: TConsultaPadrao;
    ValidaGravacao: TValidaGravacao;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BPedido: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    EUsuario: TEditLocaliza;
    ECodEstagio: TEditLocaliza;
    EPedido: TEditLocaliza;
    EEstagioAtual: TEditLocaliza;
    EMotivo: TMemoColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure EPedidoRetorno(Retorno1, Retorno2: String);
    procedure ECodEstagioCadastrar(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ECodEstagioSelect(Sender: TObject);
  private
    VprCodFilial,
    VprSeqPedido: Integer;
    VprAcao: Boolean;
    FunPedidoCompra: TRBFunPedidoCompra;
    function DadosValidos: String;
  public
    function AlteraEstagio: Boolean;
    function AlteraEstagioPedido(VpaCodFilial, VpaSeqPedido: Integer): Boolean;
  end;

var
  FAlteraEstagioPedidoCompra: TFAlteraEstagioPedidoCompra;

implementation
uses
  AEstagioProducao, FunObjeto, Constantes, ConstMsg, APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioPedidoCompra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra:= TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  VprAcao:= False;
  VprCodFilial:= Varia.CodigoEmpFil;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioPedidoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioPedidoCompra.BCancelarClick(Sender: TObject);
begin
  VprAcao:= False;
  Close;
end;

{******************************************************************************}
procedure TFAlteraEstagioPedidoCompra.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioPedidoCompra.EPedidoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno2 <> '' then
    VprSeqPedido:= StrToInt(Retorno2);
  if retorno1 <> '' then
    EEstagioAtual.Text := Retorno1
  else
    EEstagioAtual.clear;
  EEstagioAtual.Atualiza;
end;

{******************************************************************************}
procedure TFAlteraEstagioPedidoCompra.ECodEstagioCadastrar(
  Sender: TObject);
begin
  FEstagioProducao := TFEstagioProducao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FEstagioProducao'));
  FEstagioProducao.BotaoCadastrar1.Click;
  FEstagioProducao.Showmodal;
  FEstagioProducao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAlteraEstagioPedidoCompra.ECodEstagioSelect(Sender: TObject);
begin
  ECodEstagio.ASelectLocaliza.Text := ' Select * from ESTAGIOPRODUCAO ' +
                                      '  Where  TIPEST = ''M'' ';
  ECodEstagio.ASelectValida.Text   := ' Select * from ESTAGIOPRODUCAO  '+
                                      '  Where CODEST = @     ' +
                                      '    AND TIPEST = ''M'' ';
  if not (puAdministrador in varia.PermissoesUsuario)  then
    if (puCREstagiosAutorizados in varia.PermissoesUsuario) then
    begin
      // somente os estágios autorizados deste grupo de usuario
      ECodEstagio.ASelectLocaliza.Text := ECodEstagio.ASelectLocaliza.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
      ECodEstagio.ASelectValida.Text := ECodEstagio.ASelectValida.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
    end;
end;

{******************************************************************************}
function TFAlteraEstagioPedidoCompra.DadosValidos: String;
begin
  Result:= '';
  if VprSeqPedido = 0 then
    Result:= 'NÚMERO DO PEDIDO NÃO PREENCHIDO!!!'#13'É necessário preencher o número do pedido.'
  else
    if EMotivo.ACampoObrigatorio then
      if EMotivo.Lines.Text = '' then
        Result:= 'MOTIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o motivo pelo qual se está mudando de estágio.';
end;

{******************************************************************************}
function TFAlteraEstagioPedidoCompra.AlteraEstagio: Boolean;
begin
  EUsuario.AInteiro:= varia.CodigoUsuario;
  EUsuario.Atualiza;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioPedidoCompra.AlteraEstagioPedido(VpaCodFilial, VpaSeqPedido: Integer): Boolean;
begin
  EUsuario.Ainteiro:= varia.CodigoUsuario;
  EUsuario.Atualiza;
  EPedido.AInteiro:= VpaSeqPedido;
  EPedido.Atualiza;
  VprCodFilial:= VpaCodFilial;
  VprSeqPedido:= VpaSeqPedido;
  AlterarEnabledDet([EPedido,BPedido],False);
  EPedido.ACampoObrigatorio:= False;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFAlteraEstagioPedidoCompra.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= DadosValidos;
  if VpfResultado = '' then
  begin
    VpfResultado:= FunPedidoCompra.AlteraEstagioPedidoCompra(VprCodFilial,VprSeqPedido,ECodEstagio.AInteiro,EMotivo.Lines.Text);
    if VpfResultado = '' then
    begin
      VprAcao:= True;
      Close;
    end
    else
      aviso(VpfResultado);
  end
  else
    aviso(VpfResultado);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioPedidoCompra]);
end.

