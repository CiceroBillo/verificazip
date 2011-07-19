unit UnImpressaoEtiquetaCotacao;
{Verificado
-.edit;
}

interface
Uses Classes, UnDados, SysUtils, UnDadosproduto;

Const
  CT_QtdProdutoEtiqueta = 4;


Type
  TRBDFunEtiCotacao = class
    private
      function REtiProduto(VpaCodProduto : String;VpaEtiquetas : TList): TRBDEtiProduto;
      function REtiCor(VpaDEtiProduto : TRBDEtiProduto;VpaCodCor : Integer) : TRBDEtiCor;
      function RNomProdutoAbreviado(VpaNomProduto : String) :String;
    public
      constructor cria;
      destructor destroy;override;
      procedure CarEtiModelo1(VpaEtiquetas, VpaCotacoes : TList);
      procedure CarEtiPequenas(VpaDModelo1 : TRBDEtiModelo1;VpaSeparaMM : Boolean);
      function RQtdEtiquetaModelo1(VpaDModelo1 : TRBDEtiModelo1) : Integer;
      procedure AlteraQtdEmbalagemCores(VpaDProduto : TRBDEtiProduto);
end;

implementation

Uses FunObjeto, FunString, UnProdutos, Constmsg;

{******************************************************************************}
constructor TRBDFunEtiCotacao.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFunEtiCotacao.destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
function TRBDFunEtiCotacao.REtiProduto(VpaCodProduto : String;VpaEtiquetas : TList): TRBDEtiProduto;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaEtiquetas.Count - 1 do
  begin
    if TRBDEtiProduto(VpaEtiquetas.Items[VpfLaco]).CodProduto = VpaCodProduto then
    begin
      result := TRBDEtiProduto(VpaEtiquetas.Items[VpfLaco]);
      exit;
    end;
  end;
end;

{******************************************************************************}
function TRBDFunEtiCotacao.REtiCor(VpaDEtiProduto : TRBDEtiProduto;VpaCodCor : Integer) : TRBDEtiCor;
var
  VpfLaco : Integer;
begin
  result := nil;
  for Vpflaco := 0 to VpaDEtiProduto.Cores.Count - 1 do
  begin
    if TRBDEtiCor(VpaDEtiProduto.Cores.Items[Vpflaco]).CodCor = VpaCodCor then
    begin
      result := TRBDEtiCor(VpaDEtiProduto.Cores.Items[Vpflaco]);
      exit;
    end;
  end;
end;

{******************************************************************************}
function TRBDFunEtiCotacao.RNomProdutoAbreviado(VpaNomProduto : String) :String;
begin
  VpaNomProduto := RetiraAcentuacao(VpaNomProduto);
  result := SubstituiStr(VpaNomProduto,'Cadarco','cad');
  result := SubstituiStr(result,'polipropileno','polip');
  result := SubstituiStr(result,'agulhado','agu');
end;

{******************************************************************************}
procedure TRBDFunEtiCotacao.CarEtiModelo1(VpaEtiquetas, VpaCotacoes : TList);
var
  VpfLacoCotacoes, VpfLacoProdutos : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDCotacaoItem : TRBDOrcProduto;
  VpfDEtiProduto : TRBDEtiProduto;
  VpfDEtiCor : TRBDEtiCor;
begin
  FreeTObjectsList(VpaEtiquetas);
  for VpfLacoCotacoes := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoCotacoes]);
    for VpfLacoProdutos := 0 to VpfDCotacao.Produtos.Count - 1 do
    begin
      VpfDCotacaoItem := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProdutos]);
      VpfDEtiProduto := REtiProduto(VpfDCotacaoItem.CodProduto,VpaEtiquetas);
      if VpfDEtiProduto = nil then
      begin
        VpfDEtiProduto := TRBDEtiProduto.cria;
        VpaEtiquetas.Add(VpfDEtiProduto);
        VpfDEtiProduto.CodProduto := VpfDCotacaoItem.CodProduto;
        VpfDEtiProduto.NomProduto := VpfDCotacaoItem.NomProduto;
        VpfDEtiProduto.QtdEmbalagem := 100;
        VpfDEtiProduto.QtdEmbalagemAnterior := 100;
      end;
      VpfDEtiCor := REtiCor(VpfDEtiProduto,VpfDCotacaoItem.CodCor);
      if VpfDEtiCor = nil then
      begin
        VpfDEtiCor := VpfDEtiProduto.AddCor;
        VpfDEtiCor.CodCor := VpfDCotacaoItem.CodCor;
        VpfDEtiCor.DesReferenciaCliente := VpfDCotacaoItem.DesRefCliente;
        VpfDEtiCor.NomCor := VpfDCotacaoItem.DesCor;
        VpfDEtiCor.UM := VpfDCotacaoItem.UM;
        VpfDEtiCor.QtdEmbalagem := 100;
        VpfDEtiCor.QtdCotacao := 0;
      end;
      VpfDEtiCor.QtdCotacao := VpfDEtiCor.QtdCotacao + (VpfDCotacaoItem.QtdProduto -VpfDCotacaoItem.QtdBaixadoNota) ;
      VpfDEtiCor.QtdEtiqueta := VpfDEtiCor.QtdCotacao
    end;
  end;
end;

{******************************************************************************}
procedure TRBDFunEtiCotacao.CarEtiPequenas(VpaDModelo1 : TRBDEtiModelo1;VpaSeparaMM : Boolean);
var
  VpfLacoProdutos, VpfLacoCores : Integer;
  VpfDProduto : TRBDEtiProduto;
  VpfDCor : TRBDETiCor;
  VpfDEtiPequena : TRBDEtiPequena;
  VpfNomProduto, VpfDesMM : String;
  VpfQtdPedido : Double;
begin
  FreeTObjectsList(VpaDModelo1.EtiPequenas);
  for VpfLacoProdutos := 0 to VpaDModelo1.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDEtiProduto(VpaDModelo1.Produtos.Items[VpfLacoProdutos]);
    VpfNomProduto := VpfDProduto.NomProduto;
    if VpaSeparaMM then //retira os mm do nome do produto
      VpfDesMM := FunProdutos.RDesMMProduto(VpfNomProduto);
    VpfNomProduto := RNomProdutoAbreviado(VpfNomProduto);
    for VpfLacoCores := 0 to VpfDProduto.Cores.Count - 1 do
    begin
      VpfDCor := TRBDEtiCor(VpfDProduto.Cores.Items[VpfLacoCores]);
      VpfQtdPedido := VpfDCor.QtdEtiqueta;
      while (VpfQtdPedido > 0) do
      begin
        VpfDEtiPequena := VpaDModelo1.AddEtiPequena;
        VpfDEtiPequena.DesOrdemCompra := VpaDModelo1.OrdemCompra;
        VpfDEtiPequena.DesDestino := VpaDModelo1.DesDestino;
        VpfDEtiPequena.DesMM := VpfDesMM;
        VpfDEtiPequena.DesProduto := VpfDProduto.CodProduto+'-'+ VpfNomProduto;
        VpfDEtiPequena.DesComposicao := VpfDProduto.DesComposicao;
        VpfDEtiPequena.DesReferencia := VpfDCor.DesReferenciaCliente;
        VpfDEtiPequena.DesCor := VpfDCor.NomCor;
        if (VpfQtdpedido - VpfDCor.QtdEmbalagem) >= 0 then
          VpfDEtiPequena.Qtd := FormatFloat('#,###,###,##0.####',VpfDCor.QtdEmbalagem)
        else
          VpfDEtiPequena.Qtd := FormatFloat('#,###,###,##0.####',VpfQtdPedido);
        VpfDEtiPequena.Qtd := VpfDEtiPequena.Qtd +' '+ VpfDCor.UM;
        VpfQtdPedido := VpfQtdPedido - VpfDCor.QtdEmbalagem;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBDFunEtiCotacao.RQtdEtiquetaModelo1(VpaDModelo1 : TRBDEtiModelo1) : Integer;
var
  VpfLaco : Integer;
  VpfDProduto : TRBDEtiProduto;
begin
  result := 0;
  for VpfLaco := 0 to VpaDModelo1.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDEtiPRoduto(VpaDModelo1.Produtos.Items[VpfLaco]);
    result := result + (VpfDProduto.cores.Count div CT_QtdProdutoEtiqueta);
    if (VpfDProduto.cores.Count mod CT_QtdProdutoEtiqueta) <> 0 then
      inc(result);
  end;
end;

{******************************************************************************}
procedure TRBDFunEtiCotacao.AlteraQtdEmbalagemCores(VpaDProduto : TRBDEtiProduto);
Var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDProduto.Cores.Count - 1 do
  begin
    TRBDEtiCor(VpaDProduto.Cores.Items[Vpflaco]).QtdEmbalagem := VpaDProduto.QtdEmbalagem;
  end;
end;

end.
