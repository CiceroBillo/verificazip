unit AAlteraEstagioOrcamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, DBKeyViolation, Localizacao, ExtCtrls,
  PainelGradiente, UnSolicitacaoCompra;

type
  TFAlteraEstagioOrcamentoCompra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    ValidaGravacao: TValidaGravacao;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BOrcamento: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    EUsuario: TEditLocaliza;
    ECodEstagio: TEditLocaliza;
    EOrcamento: TEditLocaliza;
    EEstagioAtual: TEditLocaliza;
    EMotivo: TMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure EOrcamentoRetorno(Retorno1, Retorno2: String);
    procedure ECodEstagioCadastrar(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EOrcamentoSelect(Sender: TObject);
    procedure ECodEstagioSelect(Sender: TObject);
  private
    VprAcao: Boolean;
    VprCodFilial,
    VprSeqSolicitacao: Integer;
    FunOrcamentoCompra: TRBFunSolicitacaoCompra;
    function DadosValidos: String;
  public
    function AlteraEstagio: Boolean;
    function AlteraEstagioOrcamento(VpaCodFilial, VpaSeqSolicitacao: Integer): Boolean;
  end;

var
  FAlteraEstagioOrcamentoCompra: TFAlteraEstagioOrcamentoCompra;

implementation
uses
  Constantes, ConstMsg, FunObjeto, APrincipal, AEstagioProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioOrcamentoCompra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra:= TRBFunSolicitacaoCompra.Cria(FPrincipal.BaseDados);
  VprAcao:= False;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioOrcamentoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFAlteraEstagioOrcamentoCompra.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFAlteraEstagioOrcamentoCompra.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioOrcamentoCompra.EOrcamentoRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
    EEstagioAtual.Text:= Retorno1
  else
    EEstagioAtual.Clear;
  if Retorno2 <> '' then
    VprSeqSolicitacao:= StrToInt(Retorno2);
  EEstagioAtual.Atualiza;
end;

{******************************************************************************}
procedure TFAlteraEstagioOrcamentoCompra.ECodEstagioCadastrar(
  Sender: TObject);
begin
  FEstagioProducao := TFEstagioProducao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FEstagioProducao'));
  FEstagioProducao.BotaoCadastrar1.Click;
  FEstagioProducao.Showmodal;
  FEstagioProducao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAlteraEstagioOrcamentoCompra.ECodEstagioSelect(Sender: TObject);
begin
  ECodEstagio.ASelectLocaliza.Text := ' Select * from ESTAGIOPRODUCAO ' +
                                      '  Where  TIPEST = ''S'' ';
  ECodEstagio.ASelectValida.Text   := ' Select * from ESTAGIOPRODUCAO  '+
                                      '  Where CODEST = @     ' +
                                      '    AND TIPEST = ''S'' ';
  if not (puAdministrador in varia.PermissoesUsuario)  then
    if (puCREstagiosAutorizados in varia.PermissoesUsuario) then
    begin
      // somente os estágios autorizados deste grupo de usuario
      ECodEstagio.ASelectLocaliza.Text := ECodEstagio.ASelectLocaliza.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
      ECodEstagio.ASelectValida.Text := ECodEstagio.ASelectValida.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
    end;
end;

{******************************************************************************}
function TFAlteraEstagioOrcamentoCompra.DadosValidos: String;
begin
  Result:= '';
  if VprSeqSolicitacao = 0 then
    Result:= 'NÚMERO DO ORÇÃMENTO NÃO PREENCHIDO!!!'#13'É necessário preencher o número do orçamento.'
  else
    if EMotivo.ACampoObrigatorio then
      if EMotivo.Lines.Text = '' then
        Result:= 'MOTIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o motivo pelo qual se está mudando de estágio.';
end;

{******************************************************************************}
function TFAlteraEstagioOrcamentoCompra.AlteraEstagio: Boolean;
begin
  EUsuario.AInteiro:= varia.CodigoUsuario;
  EUsuario.Atualiza;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioOrcamentoCompra.AlteraEstagioOrcamento(VpaCodFilial, VpaSeqSolicitacao: Integer): Boolean;
begin
  EUsuario.Ainteiro:= varia.CodigoUsuario;
  EUsuario.Atualiza;
  EOrcamento.AInteiro:= VpaSeqSolicitacao;
  EOrcamento.Atualiza;
  VprCodFilial:= VpaCodFilial;
  VprSeqSolicitacao:= VpaSeqSolicitacao;
  AlterarEnabledDet([EOrcamento,BOrcamento],False);
  EOrcamento.ACampoObrigatorio:= False;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFAlteraEstagioOrcamentoCompra.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= DadosValidos;
  if VpfResultado = '' then
  begin
    VprCodFilial:= Varia.CodigoEmpFil;
    VpfResultado:= FunOrcamentoCompra.AlteraEstagioOrcamento(VprCodFilial,VprSeqSolicitacao,ECodEstagio.AInteiro,EMotivo.Lines.Text);
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

{******************************************************************************}
procedure TFAlteraEstagioOrcamentoCompra.EOrcamentoSelect(Sender: TObject);
begin
  EOrcamento.ASelectValida.Add('SELECT *'+
                               ' FROM SOLICITACAOCOMPRACORPO'+
                               ' WHERE SEQSOLICITACAO = @'+
                               ' AND CODFILIAL = '+IntToStr(Varia.CodigoEmpFil));
  EOrcamento.ASelectLocaliza.Add('SELECT *'+
                                 ' FROM SOLICITACAOCOMPRACORPO'+
                                 ' WHERE SEQSOLICITACAO LIKE ''@%'''+
                                 ' AND CODFILIAL = '+IntToStr(Varia.CodigoEmpFil));
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioOrcamentoCompra]);
end.
