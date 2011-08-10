unit AOrdemProdutoEstoque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, Componentes1, Grids, CGrades, UnDados, UnDadosProduto;

type
  TRBDColunaGradeProduto =(clIndComprar, clCodProduto, clNomProduto, clQtdEstoque);

  TFOrdemProdutoEstoque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GProdutos: TRBStringGridColor;
    BBaixar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GProdutosCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BBaixarClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
  private
    VprProdutoComEstoque : TList;
    VprDProdutoNaoComprado : TRBDFracaoOPProdutoNaoComprado;
    VprAcao : Boolean;
    function RColunaGrade(VpaColuna : TRBDColunaGradeProduto):Integer;
    procedure CarTituloGrade;
    procedure InicializaTela(VpaProdutoOrdemProducao : TList);
    function ApagaProdutosNaoComprados(VpaProdutosSolicitacao, VpaProdutosNaoComprados : TList):string;
    function ApagaProdutosSolicitacaoCompra(VpaProdutosSolicitacao : TList;VpaCodFilial, VpaSeqFracao : Integer):string;
  public
    procedure CarListaProdutoEstoque(VpaProdutoOrdemProducao : TList);
  end;

var
  FOrdemProdutoEstoque: TFOrdemProdutoEstoque;

implementation

uses APrincipal, UnProdutos, FunObjeto, ANovaSolicitacaoCompra, Constantes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFOrdemProdutoEstoque.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
    VprAcao := false;
    CarTituloGrade;
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProdutoNaoComprado:= TRBDFracaoOPProdutoNaoComprado(VprProdutoComEstoque.Items[Vpalinha -1]);
  GProdutos.Cells[RColunaGrade(clCodProduto),VpaLinha] := VprDProdutoNaoComprado.CodProduto;
  GProdutos.Cells[RColunaGrade(clNomProduto),VpaLinha] := VprDProdutoNaoComprado.NomProduto;
  GProdutos.Cells[RColunaGrade(clQtdEstoque),VpaLinha] := FormatFloat(varia.MascaraQtd,VprDProdutoNaoComprado.QtdEstoque);
  if VprDProdutoNaoComprado.IndMarcado then
    GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha] := '1'
  else
    GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha] := '0'

end;

{******************************************************************************}
procedure TFOrdemProdutoEstoque.GProdutosCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VprProdutoComEstoque.Count > 0) then
  begin
    if GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha] = '0' then
    begin
      TRBDFracaoOPProdutoNaoComprado(VprProdutoComEstoque.Items[VpaLinha-1]).IndMarcado :=true;
      GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha]:= '1'
    end
    else
    begin
      GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha]:= '0';
      TRBDFracaoOPProdutoNaoComprado(VprProdutoComEstoque.Items[VpaLinha-1]).IndMarcado :=false;
    end;
  end;
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprProdutoComEstoque.Count > 0 then
    VprDProdutoNaoComprado:= TRBDFracaoOPProdutoNaoComprado(VprProdutoComEstoque.Items[VpaLinhaAtual-1]);
end;

procedure TFOrdemProdutoEstoque.GProdutosNovaLinha(Sender: TObject);
begin
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.InicializaTela(VpaProdutoOrdemProducao : TList);
var
  VpfLaco: Integer;
  VpfQtdProdutoEstoque: Integer;
  VpfDProdutoNaoComprado : TRBDFracaoOPProdutoNaoComprado;
  VpfDProdutoSolicitacao : TRBDSolicitacaoCompraItem;
begin
  VprProdutoComEstoque := TList.Create;
  FreeTObjectsList(VprProdutoComEstoque);
  GProdutos.ADados:= VprProdutoComEstoque;

  for VpfLaco := VpaProdutoOrdemProducao.Count-1 downto 0 do
  begin
    VpfQtdProdutoEstoque:= 0;
    VpfDProdutoSolicitacao := TRBDSolicitacaoCompraItem(VpaProdutoOrdemProducao.Items[VpfLaco]);
    VpfQtdProdutoEstoque:= FunProdutos.RQuantidadeEstoqueProduto(VpfDProdutoSolicitacao.SeqProduto, VpfDProdutoSolicitacao.CodCor,0);
    if VpfQtdProdutoEstoque > 0 then
    begin
      VpfDProdutoNaoComprado := TRBDFracaoOPProdutoNaoComprado.cria;
      VprProdutoComEstoque.Add(VpfDProdutoNaoComprado);
      VpfDProdutoNaoComprado.SeqProduto := VpfDProdutoSolicitacao.SeqProduto;
      VpfDProdutoNaoComprado.CodProduto := VpfDProdutoSolicitacao.CodProduto;
      VpfDProdutoNaoComprado.CodFilialFracao := VpfDProdutoSolicitacao.CodFilialFracao;
      VpfDProdutoNaoComprado.SeqFracao := VpfDProdutoSolicitacao.SeqFracao;
      VpfDProdutoNaoComprado.QtdEstoque := VpfQtdProdutoEstoque;
      VpfDProdutoNaoComprado.IndMarcado := true;
    end;
  end;
  GProdutos.CarregaGrade;
end;

{ *************************************************************************** }
function TFOrdemProdutoEstoque.RColunaGrade(
  VpaColuna: TRBDColunaGradeProduto): Integer;
begin
  case VpaColuna of
    clIndComprar: result:= 1;
    clCodProduto: result:= 2;
    clNomProduto: result:= 3;
    clQtdEstoque: result:= 4;
  end;
end;

{ *************************************************************************** }
function TFOrdemProdutoEstoque.ApagaProdutosNaoComprados(VpaProdutosSolicitacao,VpaProdutosNaoComprados: TList): string;
var
  VpfLaco : Integer;
begin
  for VpfLaco := VpaProdutosNaoComprados.Count -1 downto 0  do
  begin
    VprDProdutoNaoComprado := TRBDFracaoOPProdutoNaoComprado(VpaProdutosNaoComprados.Items[VpfLaco]);
    if VprDProdutoNaoComprado.IndMarcado then
    begin
      ApagaProdutosSolicitacaoCompra(VpaProdutosSolicitacao,VprDProdutoNaoComprado.CodFilialFracao,VprDProdutoNaoComprado.SeqFracao);
      VpaProdutosNaoComprados.Delete(VpfLaco);
    end
  end;
end;

{******************************************************************************}
function TFOrdemProdutoEstoque.ApagaProdutosSolicitacaoCompra(VpaProdutosSolicitacao: TList; VpaCodFilial, VpaSeqFracao: Integer): string;
var
  VpfLaco : Integer;
  VpfDProdutoSolicitacao : TRBDSolicitacaoCompraItem;
begin
  for VpfLaco := 0 to VpaProdutosSolicitacao.Count - 1 do
  begin
    VpfDProdutoSolicitacao := TRBDSolicitacaoCompraItem(VpaProdutosSolicitacao.Items[VpfLaco]);
    if (VpfDProdutoSolicitacao.CodFilialFracao = VpaCodFilial) and (VpfDProdutoSolicitacao.SeqFracao = VpaSeqFracao) then
    begin
      VpaProdutosSolicitacao.Delete(VpfLaco);
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProdutoEstoque.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.BBaixarClick(Sender: TObject);
begin
  //grava produtos nao comprados
  VprAcao := true;
  close;
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.CarListaProdutoEstoque(VpaProdutoOrdemProducao: TList);
begin
  InicializaTela(VpaProdutoOrdemProducao);
  ShowModal;

  if vprAcao then
    ApagaProdutosNaoComprados(VpaProdutoOrdemProducao,VprProdutoComEstoque);
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.CarTituloGrade;
begin
  GProdutos.Cells[RColunaGrade(clCodProduto),0] := 'Codigo';
  GProdutos.Cells[RColunaGrade(clNomProduto),0] := 'Produto';
  GProdutos.Cells[RColunaGrade(clQtdEstoque),0] := 'Qtd';
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFOrdemProdutoEstoque]);
end.
