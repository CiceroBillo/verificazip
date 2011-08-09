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
    BComprar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GProdutosCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BComprarClick(Sender: TObject);
  private
    VprProdutoComEstoque,
    VprProdutoOrdemProducao : TList;
    VprDProdutoFracao : TRBDSolicitacaoCompraItem;
    VprDFracaoOp: TRBDFracaoOrdemProducao;
    function RColunaGrade(VpaColuna : TRBDColunaGradeProduto):Integer;
    procedure CarTituloGrade;
    procedure InicializaTela;
  public
    procedure CarListaProdutoEstoque(VpaProdutoOrdemProduto : TList; VpaDFracaoOp: TRBDFracaoOrdemProducao);
  end;

var
  FOrdemProdutoEstoque: TFOrdemProdutoEstoque;

implementation

uses APrincipal, UnProdutos, FunObjeto, ANovaSolicitacaoCompra;

{$R *.DFM}


{ **************************************************************************** }
procedure TFOrdemProdutoEstoque.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.GProdutosCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VprProdutoComEstoque.Count > 0) then
  begin
    if GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha] = '0' then
      GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha]:= '1'
    else
      GProdutos.Cells[RColunaGrade(clIndComprar),VpaLinha]:= '0';
    end;
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprProdutoComEstoque.Count > 0 then
    VprDProdutoFracao:= TRBDSolicitacaoCompraItem(VprProdutoComEstoque.Items[VpaLinhaAtual-1]);
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.InicializaTela;
begin
  VprProdutoComEstoque := TList.Create;
  VprProdutoOrdemProducao:= TList.Create;
  FreeTObjectsList(VprProdutoComEstoque);
  FreeTObjectsList(VprProdutoOrdemProducao);
  CarTituloGrade;
  GProdutos.ADados:= VprProdutoComEstoque;
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
procedure TFOrdemProdutoEstoque.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.BComprarClick(Sender: TObject);
var
  VpfLaco: Integer;
begin
  for VpfLaco := 0 to VprProdutoComEstoque.Count -1 do
  begin
    if GProdutos.Cells[RColunaGrade(clIndComprar), VpfLaco + 1] = '0' then
      VprProdutoComEstoque.Delete(VpfLaco)
    else
      VprProdutoOrdemProducao.add(VprProdutoComEstoque.Items[VpfLaco]);
  end;
  FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
  FNovaSolicitacaoCompras.NovoOrcamentoConsumo(VprDFracaoOp.CodFilial,VprDFracaoOp.SeqOrdemProducao,VprDFracaoOp.SeqFracao,VprProdutoOrdemProducao);
  FNovaSolicitacaoCompras.free;
end;

{ *************************************************************************** }
procedure TFOrdemProdutoEstoque.CarListaProdutoEstoque(VpaProdutoOrdemProduto: TList; VpaDFracaoOp: TRBDFracaoOrdemProducao);
var
  VpfLaco: Integer;
  VpfQtdProdutoEstoque: Integer;
begin
  InicializaTela;
  VprProdutoOrdemProducao:= VpaProdutoOrdemProduto;
  VprDFracaoOp:= VpaDFracaoOp;
  VpfLaco:= 0;
  for VpfLaco := 0 to VprProdutoOrdemProducao.Count-1 do
  begin
    VpfQtdProdutoEstoque:= 0;
    VprDProdutoFracao:= TRBDSolicitacaoCompraItem(VprProdutoOrdemProducao.Items[VpfLaco]);
    VpfQtdProdutoEstoque:= FunProdutos.RQuantidadeEstoqueProduto(VprDProdutoFracao.SeqProduto, VprDProdutoFracao.CodCor,0);
    if VpfQtdProdutoEstoque > 0 then
    begin
      VprProdutoComEstoque.Add(VprProdutoOrdemProducao.Items[VpfLaco]);
      VprProdutoOrdemProducao.Delete(VpfLaco);
      GProdutos.Cells[RColunaGrade(clIndComprar), GProdutos.ALinha+1]:= '1';
      GProdutos.Cells[RColunaGrade(clCodProduto), GProdutos.ALinha+1]:= VprDProdutoFracao.CodProduto;
      GProdutos.Cells[RColunaGrade(clNomProduto), GProdutos.ALinha+1]:= VprDProdutoFracao.NomProduto;
      GProdutos.Cells[RColunaGrade(clQtdEstoque), GProdutos.ALinha+1]:= IntToStr(VpfQtdProdutoEstoque);
      GProdutos.NovaLinha;
    end;
  end;
  ShowModal;
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
