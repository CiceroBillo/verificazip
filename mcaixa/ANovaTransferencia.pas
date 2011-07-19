unit ANovaTransferencia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, StdCtrls, Buttons,
  ComCtrls, Mask, numericos, UnDadosCR, UnCaixa,SqlExpr;

type
  TTipoTela = (ttTransferencia,ttAplicacao,ttResgate);
  TFNovaTransferencia = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    EDatTransferencia: TCalendario;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    EValor: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    EObservacao: TEditColor;
    PContaCaixaDestino: TPanelColor;
    Label28: TLabel;
    EContaCorrente: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label38: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprCaixaOrigem : String;
    VprTipoTela : TTipoTela;
    FunCaixa : TRBFuncoesCaixa;
    function DadosValidos : String;
    function GravaCaixaOrigem : String;
    function GravaCaixaDestino : String;
    function GravaAplicacao : string;
    function GravaResgate : string;
    procedure ConfiguraTela;
    function GravaTransferencia: String;
  public
    { Public declarations }
    function TransferenciaCaixa(VpaCaixaOrigem : String):Boolean;
    function AplicarDinheiro(VpaCaixa : String):Boolean;
    function ResgataDinheiro(VpaCaixa : String):Boolean;
  end;

var
  FNovaTransferencia: TFNovaTransferencia;

implementation

uses APrincipal, Constantes, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaTransferencia.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunCaixa := TRBFuncoesCaixa.cria(FPrincipal.BaseDados);
  EDatTransferencia.Date := date;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaTransferencia.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  VpfResultado := '';
  VpfTransacao.IsolationLevel :=xilDIRTYREAD;
  FPrincipal.BaseDados.StartTransaction(VpfTransacao);
  case VprTipoTela of
    ttTransferencia: VpfResultado := GravaTransferencia;
    ttAplicacao: VpfResultado := GravaAplicacao;
    ttResgate: VpfResultado := GravaResgate;
  end;
  if VpfResultado <> '' then
  begin
    if FPrincipal.BaseDados.inTransaction then
    	FPrincipal.BaseDados.Rollback(VpfTransacao);
    aviso(VpfResultado)
  end
  else
  begin
    FPrincipal.BaseDados.Commit(VpfTransacao);
    VprAcao := true;
    close;
  end;
end;

{******************************************************************************}
procedure TFNovaTransferencia.ConfiguraTela;
begin
  case VprTipoTela of
    ttAplicacao:
    begin
      Self.Caption := 'Aplicação';
      PainelGradiente1.Caption := '   Aplicação   ';
      PContaCaixaDestino.Visible := false;
      self.Height := PainelGradiente1.Height+PanelColor1.Height+PanelColor2.Height;
    end;
    ttResgate:
    begin
      Self.Caption := 'Resgate';
      PainelGradiente1.Caption := '   Resgate   ';
      PContaCaixaDestino.Visible := false;
      self.Height := PainelGradiente1.Height+PanelColor1.Height+PanelColor2.Height;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaTransferencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunCaixa.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovaTransferencia.TransferenciaCaixa(VpaCaixaOrigem : String):Boolean;
begin
  VprTipoTela := ttTransferencia;
  VprCaixaOrigem := VpaCaixaOrigem;
  showmodal;
  result := VprAcao;
end;


{******************************************************************************}
function TFNovaTransferencia.DadosValidos : String;
begin
  result := '';
  if VprCaixaOrigem = EContaCorrente.Text then
    result := 'CONTA CAIXA DESTINO IGUAL A CONTA ORIGEM!!!'#13'A conta caixa destino não pode ser igual a conta caixa origem.';
  if result = '' then
  begin
    if FunCaixa.RSeqCaixa(VprCaixaOrigem)= 0  then
      result := 'CAIXA ORIGEM NÃO ABERTO!!!'#13'É necessário abrir o caixa origem antes de fazer a transferência.';
    if result = '' then
    begin
      if FunCaixa.RSeqCaixa(EContaCorrente.Text)= 0  then
        result := 'CAIXA DESTINO NÃO ABERTO!!!'#13'É necessário abrir o caixa destino antes de fazer a transferência.';
    end;
  end;
end;

{******************************************************************************}
function TFNovaTransferencia.GravaCaixaOrigem : String;
var
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfSeqCaixaOrigem : Integer;
begin
  VpfDCaixa := TRBDCaixa.cria;
  VpfSeqCaixaOrigem := FunCaixa.RSeqCaixa(VprCaixaOrigem);
  FunCaixa.CarDCaixa(VpfDCaixa,VpfSeqCaixaOrigem);

  VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
  VpfDItemCaixa.CodUsuario := varia.codigoUsuario;
  VpfDItemCaixa.CodFormaPagamento := varia.FormaPagamentoDinheiro;
  VpfDItemCaixa.DesLancamento := 'Transferência entre caixa "'+EContaCorrente.Text+'" '+EObservacao.Text;
  VpfDItemCaixa.DesDebitoCredito := 'D';
  VpfDItemCaixa.ValLancamento := EValor.AValor;
  VpfDItemCaixa.DatPagamento := EDatTransferencia.Date;
  VpfDItemCaixa.DatLancamento :=EDatTransferencia.Date;
  result := FunCaixa.GravaDCaixa(VpfDCaixa);
end;

{******************************************************************************}
function TFNovaTransferencia.GravaResgate: string;
var
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfSeqCaixaOrigem : Integer;
begin
  VpfDCaixa := TRBDCaixa.cria;
  VpfSeqCaixaOrigem := FunCaixa.RSeqCaixa(VprCaixaOrigem);
  FunCaixa.CarDCaixa(VpfDCaixa,VpfSeqCaixaOrigem);

  VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
  VpfDItemCaixa.CodUsuario := varia.codigoUsuario;
  VpfDItemCaixa.CodFormaPagamento := varia.FormaPagamentoDinheiro;
  VpfDItemCaixa.DesLancamento := 'Valor resgatado da aplicação na conta "'+EContaCorrente.Text+'" '+EObservacao.Text;
  VpfDItemCaixa.DesDebitoCredito := 'C';
  VpfDItemCaixa.ValLancamento := EValor.AValor;
  VpfDItemCaixa.DatPagamento := EDatTransferencia.Date;
  VpfDItemCaixa.DatLancamento := EDatTransferencia.Date;
  result := FunCaixa.GravaDCaixa(VpfDCaixa);
  if result = '' then
    result := FunCaixa.ResgataValor(VpfDCaixa,VpfDItemCaixa);
end;

{******************************************************************************}
function TFNovaTransferencia.GravaTransferencia: String;
begin
  result := DadosValidos;
  if result = ''  then
  begin
    result :=  GravaCaixaOrigem;
    if result = '' then
      result := GravaCaixaDestino;
  end;
end;

{******************************************************************************}
function TFNovaTransferencia.ResgataDinheiro(VpaCaixa: String): Boolean;
begin
  VprCaixaOrigem := VpaCaixa;
  VprTipoTela := ttResgate;
  ConfiguraTela;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaTransferencia.GravaAplicacao: string;
var
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfSeqCaixaOrigem : Integer;
begin
  VpfDCaixa := TRBDCaixa.cria;
  VpfSeqCaixaOrigem := FunCaixa.RSeqCaixa(VprCaixaOrigem);
  FunCaixa.CarDCaixa(VpfDCaixa,VpfSeqCaixaOrigem);

  VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
  VpfDItemCaixa.CodUsuario := varia.codigoUsuario;
  VpfDItemCaixa.CodFormaPagamento := varia.FormaPagamentoDinheiro;
  VpfDItemCaixa.DesLancamento := 'Valor aplicado na conta "'+EContaCorrente.Text+'" '+EObservacao.Text;
  VpfDItemCaixa.DesDebitoCredito := 'D';
  VpfDItemCaixa.ValLancamento := EValor.AValor;
  VpfDItemCaixa.DatPagamento := Date;
  VpfDItemCaixa.DatLancamento := Date;
  result := FunCaixa.GravaDCaixa(VpfDCaixa);
  if result = '' then
    result := FunCaixa.AplicaValor(VpfDCaixa,VpfDItemCaixa);
end;

{******************************************************************************}
function TFNovaTransferencia.GravaCaixaDestino : String;
var
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfSeqCaixaDestino : Integer;
begin
  VpfDCaixa := TRBDCaixa.cria;
  VpfSeqCaixaDestino := FunCaixa.RSeqCaixa(EContaCorrente.Text);
  FunCaixa.CarDCaixa(VpfDCaixa,VpfSeqCaixaDestino);

  VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
  VpfDItemCaixa.CodUsuario := varia.codigoUsuario;
  VpfDItemCaixa.CodFormaPagamento := varia.FormaPagamentoDinheiro;
  VpfDItemCaixa.DesLancamento := 'Transferência entre caixa "'+VprCaixaOrigem+'" '+EObservacao.Text;
  VpfDItemCaixa.DesDebitoCredito := 'C';
  VpfDItemCaixa.ValLancamento := EValor.AValor;
  VpfDItemCaixa.DatPagamento := Date;
  VpfDItemCaixa.DatLancamento := Date;
  result := FunCaixa.GravaDCaixa(VpfDCaixa);
end;

{******************************************************************************}
function TFNovaTransferencia.AplicarDinheiro(VpaCaixa: String): Boolean;
begin
  VprCaixaOrigem := VpaCaixa;
  VprTipoTela := ttAplicacao;
  ConfiguraTela;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaTransferencia.BCancelarClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTransferencia]);
end.
