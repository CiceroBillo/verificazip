Unit UnOrcamentoCompra;
{Verificado
-.edit;
-.post;
}
Interface

Uses Classes, DBTables, UnDadosProduto, SysUtils, IdMessage, IdSMTP, UnDados,IdAttachmentfile,
  idtext, SQLExpr,tabela, ZipMstr19;

//classe localiza
Type TRBLocalizaOrcamentoCompra = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesOrcamentoCompra = class(TRBLocalizaOrcamentoCompra)
  private
    Aux,
    Tabela,
    Pedidos : TSQLQuery;
    Cadastro : TSQL;
    VprMensagem: TidMessage;
    VprSMTP: TIdSMTP;
    ZM: TZipMaster19;
    function RSeqOrcamentoDisponivel(VpaCodFilial : Integer) : Integer;
    function RFornecedorPedidoCompra(VpadOrcamento : TRBDOrcamentoCompraCorpo;VpaCodFornecedor : Integer):TRBDOrcamentoCompraFornecedor;
    function GravaDOrcamentoProduto(VpadOrcamento : TRBDOrcamentoCompraCorpo):string;
    function GravaDOrcamentoFornecedor(VpadOrcamento : TRBDOrcamentoCompraCorpo):string;
    function GravaDOrcamentoFornecedorProduto(VpaDOrcamento : TRBDOrcamentoCompraCorpo):string;
    function GravaDOrcamentoFracaoOP(VpaDOrcamento : TRBDOrcamentoCompraCorpo):string;
    function GravaDOrcamentoSolicitacaoCompra(VpaDOrcamento : TRBDOrcamentoCompraCorpo) :string;
    procedure CarDOrcamentoProduto(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
    procedure CarDOrcamentoFornecedor(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
    procedure CarDOrcamentoProdutoAdicionadoFornecedor(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
    procedure CarDOrcamentoFracoes(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
    procedure MontaCabecalhoEmail(VpaTexto : TStrings; VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo;VpaDFilial : TRBDFilial);
    procedure MontaEmailOrcamentoCompraTexto(VpaTexto : TStrings; VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
    procedure MontaEmailOrcamentoCompra(VpaTexto : TStrings; VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo;VpaDOrcFornecedor :TRBDOrcamentoCompraFornecedor; VpaDCliente : TRBDCliente; VpaDComprador : TRBDComprador; VpaDFilial : TRBDFilial);
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDComprador : TRBDComprador) : string;
    procedure CopiaDProdutoOrcamento(VpaDProOrigem, VpaDProDestino : TRBDOrcamentoCompraProduto);
    function ExisteProdutoAdicionadoFornecedor(VpaDProOrcamento : TRBDOrcamentoCompraProduto;VpaProdutos : TList):boolean;
    function ExisteProdutonoOrcamento(VpaDOrcamento : TRBDOrcamentoCompraCorpo; VpaSeqProduto, VpaCodCor : Integer):Boolean;
    function ExisteSolicitacaoOrcamentoCompra(VpaDOrcamento : TRBDOrcamentoCompraCorpo;VpaDSolicitacaoCompra : TRBDSolicitacaoCompraCorpo):boolean;
    function RProdutoFornecedor(VpaDOrcamento :TRBDOrcamentoCompraCorpo;VpaCodFornecedor,VpaSeqProduto,VpaCodCor : Integer;VpaLarChapa, VpaComChapa : Double) : TRBDOrcamentoCompraProduto;
    function EstornaProdutosdoPedidoNoOrcamento(VpaDPedidoCompra : TRBDPedidoCompraCorpo;VpaDOrcamento : TRBDOrcamentoCompraCorpo) : string;
//    procedure AdicionaFornecedoresProdutoOrcamento( VpaDProOrcamento : TRBDOrcamentoCompraProduto
  public
    constructor cria(VpaBaseDados : TSQLConnection );
    destructor destroy;override;
    function GravaDOrcamento(VpaDOrcamento :TRBDOrcamentoCompraCorpo):string;
    function GravaVinculoOrcamentoPedidoCompra(VpaDPedidoCompra : TRBDPedidoCompraCorpo;VpaDOrcamento : TRBDOrcamentoCompraCorpo) :string;
    procedure CarDOrcamento(VpaCodFilial, VpaSeqOrcamento : Integer;VpaDOrcamento :TRBDOrcamentoCompraCorpo);
    procedure AdicionaProdutosFornecedor(VpaDOrcamento : TRBDOrcamentoCompraCorpo;VpaDOrcamentoFornecedor : TRBDOrcamentoCompraFornecedor);
    function EnviaEmailFornecedor(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo) : String;
    procedure AdicionaFornecedoresOrcamentoCompra(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
    procedure AdicionaProdutosNaoAdicionadosFornecedor(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
    procedure AdicionaSolicitacoesOrcamentoCompra(VpadOrcamentoCompra : TRBDOrcamentoCompraCorpo;VpaProdutosPendentes : TList);
    procedure ExcluiProdutoNosFornecedores(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
    procedure AdicionaProdutoNosFornecedores(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
    function RProdutoOrcamento(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo;VpaSeqProduto, VpaCodCor : Integer;VpaLarChapa, VpaComChapa : Double) : TRBDOrcamentoCompraProduto;
    function RProdutoOrcamentoFornecedor(VpaDOrcamentoFornecedor : TRBDOrcamentoCompraFornecedor;VpaSeqProduto, VpaCodCor : Integer;VpaLarChapa, VpaComChapa : Double) : TRBDOrcamentoCompraProduto;
    function ROrcamentoFornecedor(VpaCodFornecedor : Integer;VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo) : TRBDOrcamentoCompraFornecedor;
    procedure AtualizaMenorPreco(VpaDOrcamento : TRBDOrcamentoCompraCorpo;VpaUsarFrete,VpaUsarIPI, VpaUsarICMS : Boolean);
    procedure CarProdutoSelecionados(VpaProdutos : TList;VpaDOrcamento : TRBDOrcamentoCompraCorpo;VpaCodFornecedor : Integer);
    procedure MarcaProdutosComoComprado(VpaDMapaCompras, VpaDOrcamento : TRBDOrcamentoCompraCorpo);
    procedure ApagaProdutosComprados(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
    function EstornaProdutosComprados(VpaDPedidoCompra : TRBDPedidoCompraCorpo) : string;
    procedure AnexaArquivoProjetoEmailFornecedor(VpaDOrcamentoProduto :TRBDOrcamentoCompraCorpo);
end;



implementation

Uses FunSql, FunData, unProdutos, FunObjeto, Unsistema, UnClientes, Constantes, UnContasAreceber, UnNotaFiscal,
     FunString, ConstMsg;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaOrcamentoCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaOrcamentoCompra.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesOrcamentoCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesOrcamentoCompra.cria(VpaBaseDados : TSQLConnection );
begin
  inherited create;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SqlConnection := vpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SqlConnection := vpaBaseDados;
  Pedidos  := TSQLQuery.Create(nil);
  Pedidos.SQLConnection := VpaBaseDados;
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesOrcamentoCompra.destroy;
begin
  Cadastro.close;
  Cadastro.free;
  Pedidos.Close;
  Pedidos.Free;
  Tabela.Close;
  Tabela.Free;
  VprMensagem.free;
  VprSMTP.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.RSeqOrcamentoDisponivel(VpaCodFilial : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQORCAMENTO) ULTIMO from ORCAMENTOCOMPRACORPO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger+1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.RFornecedorPedidoCompra(VpadOrcamento : TRBDOrcamentoCompraCorpo;VpaCodFornecedor : Integer):TRBDOrcamentoCompraFornecedor;
var
  VpfLaco : Integer;
  VpfDCliente : trbdcliente;
begin
  result := nil;
  for VpfLaco := 0 to VpadOrcamento.Fornecedores.Count - 1 do
  begin
    if TRBDOrcamentoCompraFornecedor(VpadOrcamento.Fornecedores.Items[VpfLaco]).CodFornecedor = VpaCodFornecedor then
    begin
      result := TRBDOrcamentoCompraFornecedor(VpadOrcamento.Fornecedores.Items[VpfLaco]);
      break;
    end;
  end;
  if result = nil then
  begin
    Result := VpadOrcamento.addFornecedor;
    result.CodFornecedor := VpaCodFornecedor;
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpaCodFornecedor;
    FunClientes.CarDCliente(VpfDCliente);
    Result.NomContato := VpfDCliente.NomContatoFornecedor;
    Result.DesEmailFornecedor := VpfDCliente.DesEmailFornecedor;
    VpfDCliente.free;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.ROrcamentoFornecedor(VpaCodFornecedor: Integer;VpaDOrcamentoCompra: TRBDOrcamentoCompraCorpo): TRBDOrcamentoCompraFornecedor;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDOrcamentoCompra.Fornecedores.Count - 1 do
  begin
    if TRBDOrcamentoCompraFornecedor(VpaDOrcamentoCompra.Fornecedores.Items[Vpflaco]).CodFornecedor = VpaCodFornecedor then
    begin
      result := TRBDOrcamentoCompraFornecedor(VpaDOrcamentoCompra.Fornecedores.Items[Vpflaco]);
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.RProdutoFornecedor(VpaDOrcamento: TRBDOrcamentoCompraCorpo; VpaCodFornecedor,VpaSeqProduto, VpaCodCor: Integer;VpaLarChapa, VpaComChapa : Double): TRBDOrcamentoCompraProduto;
Var
  VpfDOrcamentoFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  VpfDOrcamentoFornecedor := ROrcamentoFornecedor(VpaCodFornecedor,VpaDOrcamento);
  if VpfDOrcamentoFornecedor <> nil then
    result := RProdutoOrcamentoFornecedor(VpfDOrcamentoFornecedor,VpaSeqProduto,VpaCodCor,VpaLarChapa,VpaComChapa);
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.RProdutoOrcamento(VpaDOrcamentoCompra: TRBDOrcamentoCompraCorpo; VpaSeqProduto,VpaCodCor: Integer; VpaLarChapa, VpaComChapa: Double): TRBDOrcamentoCompraProduto;
var
  VpfLaco : Integer;
  VpfDProdutoOrc : TRBDOrcamentoCompraProduto;
begin
  result := nil;
  for VpfLaco := 0 to VpaDOrcamentoCompra.Produtos.Count - 1 do
  begin
    VpfDProdutoOrc := TRBDOrcamentoCompraProduto(VpaDOrcamentoCompra.Produtos.Items[VpfLaco]);
    if (VpfDProdutoOrc.SeqProduto = VpaSeqProduto) and
       (VpfDProdutoOrc.CodCor =  VpaCodCor) and
       (VpfDProdutoOrc.LarChapa = VpaLarChapa) and
       (VpfDProdutoOrc.ComChapa = VpaComChapa)then
    begin
      result :=  VpfDProdutoOrc;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.RProdutoOrcamentoFornecedor(VpaDOrcamentoFornecedor: TRBDOrcamentoCompraFornecedor;VpaSeqProduto, VpaCodCor: Integer;VpaLarChapa, VpaComChapa : Double): TRBDOrcamentoCompraProduto;
var
  vpfLaco : Integer;
  VpfDProdutoOrc : TRBDOrcamentoCompraProduto;
begin
  result := nil;
  for VpfLaco := 0 to VpaDOrcamentoFornecedor.ProdutosAdicionados.Count - 1 do
  begin
    VpfDProdutoOrc := TRBDOrcamentoCompraProduto(VpaDOrcamentoFornecedor.ProdutosAdicionados.Items[VpfLaco]);
    if (VpfDProdutoOrc.SeqProduto = VpaSeqProduto) and
       (VpfDProdutoOrc.CodCor =  VpaCodCor) and
       (VpfDProdutoOrc.LarChapa = VpaLarChapa) and
       (VpfDProdutoOrc.ComChapa = VpaComChapa)then
    begin
      result :=  VpfDProdutoOrc;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.GravaDOrcamentoProduto(VpadOrcamento : TRBDOrcamentoCompraCorpo):string;
Var
  VpfLaco : Integer;
  VpfDProdutoCompra : TRBDOrcamentoCompraProduto;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from ORCAMENTOCOMPRAITEM '+
                        ' Where CODFILIAL = '+ IntToStr(VpadOrcamento.CodFilial)+
                        ' AND SEQORCAMENTO = '+IntToStr(VpadOrcamento.SeqOrcamento));
  AdicionaSQLAbreTabela(Cadastro,'Select * from ORCAMENTOCOMPRAITEM '+
                                  ' Where CODFILIAL = 0 AND SEQORCAMENTO = 0 AND SEQITEM = 0 ');
  for VpfLaco := 0 to VpadOrcamento.Produtos.Count - 1 do
  begin
    VpfDProdutoCompra := TRBDOrcamentoCompraProduto(VpadOrcamento.Produtos.Items[VpfLaco]);
    Cadastro.insert;
    VpfDProdutoCompra.SeqItem := VpfLaco + 1;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpadOrcamento.CodFilial;
    Cadastro.FieldByName('SEQORCAMENTO').AsInteger := VpadOrcamento.SeqOrcamento;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfDProdutoCompra.SeqItem;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProdutoCompra.SeqProduto;
    Cadastro.FieldByName('CODCOR').AsInteger := VpfDProdutoCompra.CodCor;
    Cadastro.FieldByName('DESUM').AsString := VpfDProdutoCompra.DesUM;
    Cadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDProdutoCompra.QtdProduto;
    if VpfDProdutoCompra.IndComprado then
      Cadastro.FieldByName('INDCOMPRADO').AsString := 'S'
    else
      Cadastro.FieldByName('INDCOMPRADO').AsString := 'N';
    Cadastro.FieldByName('QTDSOLICITADA').AsFloat := VpfDProdutoCompra.QtdSolicitada;
    Cadastro.FieldByName('QTDCOMPRADA').AsFloat := VpfDProdutoCompra.QtdComprado;
    if VpfDProdutoCompra.QtdChapa <> 0 then
      Cadastro.FieldByName('QTDCHAPA').AsFloat := VpfDProdutoCompra.QtdChapa;
    if VpfDProdutoCompra.LarChapa <> 0 then
      Cadastro.FieldByName('LARCHAPA').AsFloat := VpfDProdutoCompra.LarChapa;
    if VpfDProdutoCompra.ComChapa <> 0 then
      Cadastro.FieldByName('COMCHAPA').AsFloat := VpfDProdutoCompra.ComChapa;
    Cadastro.FieldByName('PERIPI').AsFloat := VpfDProdutoCompra.PerIPI;
    if VpfDProdutoCompra.DatAprovacao > montadata(1,1,1900) then
      Cadastro.FieldByName('DATAPROVACAO').AsDateTime := VpfDProdutoCompra.DatAprovacao
    else
      Cadastro.FieldByName('DATAPROVACAO').Clear;
    Cadastro.FieldByName('DESARQUIVOPROJETO').AsString:= VpfDProdutoCompra.DesArquivoProjeto;

    Cadastro.post;
    Result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.GravaDOrcamentoSolicitacaoCompra(VpaDOrcamento: TRBDOrcamentoCompraCorpo): string;
var
  VpfLaco : Integer;
  VpfDSolicitacao : TRBDSolicitacaoCompraCorpo;
begin
  result := '';
  for VpfLaco := 0 to VpaDOrcamento.SolicitacoesCompra.Count - 1 do
  begin
    VpfDSolicitacao := TRBDSolicitacaoCompraCorpo(VpaDOrcamento.SolicitacoesCompra.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Cadastro,'Select * from ORCAMENTOSOLICITACAOCOMPRA ' +
                                   ' Where CODFILIAL = '+IntToStr(VpaDOrcamento.CodFilial)+
                                   ' AND SEQORCAMENTO = '+IntToStr(VpaDOrcamento.SeqOrcamento)+
                                   ' AND CODFILIALSOLICITACAO = ' +IntToStr(VpfDSolicitacao.CodFilial)+
                                   ' AND SEQSOLICITACAO = ' +IntToStr(VpfDSolicitacao.SeqSolicitacao));
    if Cadastro.Eof then
    begin
      Cadastro.Insert;
      Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDOrcamento.CodFilial;
      Cadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaDOrcamento.SeqOrcamento;
      Cadastro.FieldByName('CODFILIALSOLICITACAO').AsInteger := VpfDSolicitacao.CodFilial;
      Cadastro.FieldByName('SEQSOLICITACAO').AsInteger := VpfDSolicitacao.SeqSolicitacao;
      Cadastro.Post;
      result := Cadastro.AMensagemErroGravacao;
      if result <> '' then
        break;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.GravaVinculoOrcamentoPedidoCompra(VpaDPedidoCompra: TRBDPedidoCompraCorpo;VpaDOrcamento: TRBDOrcamentoCompraCorpo): string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * FROM ORCAMENTOPEDIDOCOMPRA ' +
                          'Where CODFILIAL = 0 and SEQORCAMENTO = 0 and SEQPEDIDO = 0 ');
  Cadastro.insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDPedidoCompra.CodFilial;
  Cadastro.FieldByName('SEQPEDIDO').AsInteger := VpaDPedidoCompra.SeqPedido;
  Cadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaDOrcamento.SeqOrcamento;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.GravaDOrcamentoFornecedor(VpadOrcamento : TRBDOrcamentoCompraCorpo):string;
var
  VpfLaco : INteger;
  VpfDOrcFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  ExecutaComandoSql(Aux,'Delete from ORCAMENTOCOMPRAFORNECEDORITEM '+
                        ' Where CODFILIAL = '+IntToStr(VpadOrcamento.CodFilial)+
                        ' and SEQORCAMENTO = '+ IntToStr(VpadOrcamento.SeqOrcamento));
  ExecutaComandoSql(Aux,'Delete from ORCAMENTOCOMPRAFORNECEDORCORPO '+
                        ' Where CODFILIAL = '+IntToStr(VpadOrcamento.CodFilial)+
                        ' and SEQORCAMENTO = '+ IntToStr(VpadOrcamento.SeqOrcamento));
  AdicionaSQLAbreTabela(Cadastro,'Select * from ORCAMENTOCOMPRAFORNECEDORCORPO '+
                                 ' Where CODFILIAL = 0 AND SEQORCAMENTO = 0 AND CODCLIENTE = 0');
  for VpfLaco := 0 to VpadOrcamento.Fornecedores.Count - 1 do
  begin
    VpfDOrcFornecedor := TRBDOrcamentoCompraFornecedor(VpadOrcamento.Fornecedores.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger :=VpadOrcamento.CodFilial;
    Cadastro.FieldByName('SEQORCAMENTO').AsInteger :=VpadOrcamento.SeqOrcamento;
    Cadastro.FieldByName('CODCLIENTE').AsInteger :=VpfDOrcFornecedor.CodFornecedor;
    if VpfDOrcFornecedor.CodCondicaoPagamento <> 0 then
      Cadastro.FieldByName('CODCONDICAOPAGAMENTO').AsInteger := VpfDOrcFornecedor.CodCondicaoPagamento
    else
      Cadastro.FieldByName('CODCONDICAOPAGAMENTO').Clear;
    if VpfDOrcFornecedor.CodFormaPagamento <> 0 then
      Cadastro.FieldByName('CODFORMAPAGAMENTO').AsInteger := VpfDOrcFornecedor.CodFormaPagamento
    else
      Cadastro.FieldByName('CODFORMAPAGAMENTO').Clear;
    if VpfDOrcFornecedor.CodTransportadora <> 0 then
      Cadastro.FieldByName('CODTRANSPORTADORA').AsInteger := VpfDOrcFornecedor.CodTransportadora
    else
      Cadastro.FieldByName('CODTRANSPORTADORA').Clear;
    Cadastro.FieldByName('VALFRETE').AsFloat := VpfDOrcFornecedor.ValFrete;
    Cadastro.FieldByName('TIPFRETE').AsInteger := VpfDOrcFornecedor.TipFrete;
    Cadastro.FieldByName('NOMCONTATO').AsString := VpfDOrcFornecedor.NomContato;
    Cadastro.FieldByName('DESEMAIL').AsString := VpfDOrcFornecedor.DesEmailFornecedor;
    Cadastro.post;
    Result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.GravaDOrcamentoFornecedorProduto(VpaDOrcamento : TRBDOrcamentoCompraCorpo):string;
Var
  VpfLacoFornecedor, VpfLacoProdutos : Integer;
  VpfDOrcFornecedor : TRBDOrcamentoCompraFornecedor;
  VpfDOrcProduto : TRBDOrcamentoCompraProduto;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from ORCAMENTOCOMPRAFORNECEDORITEM '+
                                 ' Where CODFILIAL = 0 AND SEQORCAMENTO = 0 AND CODCLIENTE = 0 AND SEQITEM = 0');
  for VpfLacoFornecedor := 0 to VpadOrcamento.Fornecedores.Count - 1 do
  begin
    VpfDOrcFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamento.Fornecedores.Items[VpfLacoFornecedor]);
    for VpfLacoProdutos := 0 to VpfDOrcFornecedor.ProdutosAdicionados.Count - 1 do
    begin
      VpfDOrcProduto := TRBDOrcamentoCompraProduto(VpfDOrcFornecedor.ProdutosAdicionados.Items[VpfLacoProdutos]);
      VpfDOrcProduto.SeqItem := VpfLacoProdutos + 1;
      Cadastro.Insert;
      Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDOrcamento.CodFilial;
      Cadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaDOrcamento.SeqOrcamento;
      Cadastro.FieldByName('CODCLIENTE').AsInteger := VpfDOrcFornecedor.CodFornecedor;
      Cadastro.FieldByName('SEQITEM').AsInteger := VpfDOrcProduto.SeqItem;
      Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDOrcProduto.SeqProduto;
      if VpfDOrcProduto.CodCor <> 0 then
        Cadastro.FieldByName('CODCOR').AsInteger := VpfDOrcProduto.CodCor
      else
        Cadastro.FieldByName('CODCOR').clear;
      Cadastro.FieldByName('DESUM').AsString := VpfDOrcProduto.DesUM;
      Cadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDOrcProduto.QtdProduto;
      Cadastro.FieldByName('QTDCOMPRADA').AsFloat := VpfDOrcProduto.QtdComprado;
      Cadastro.FieldByName('VALUNITARIO').AsFloat := VpfDOrcProduto.ValUnitario;
      Cadastro.FieldByName('VALTOTAL').AsFloat := VpfDOrcProduto.ValTotal;
      Cadastro.FieldByName('PERIPI').AsFloat := VpfDOrcProduto.PerIPI;
      Cadastro.FieldByName('PERICMS').AsFloat := VpfDOrcProduto.PerICMS;
      if VpfDOrcProduto.QtdChapa <> 0 then
        Cadastro.FieldByName('QTDCHAPA').AsFloat := VpfDOrcProduto.QtdChapa;
      if VpfDOrcProduto.LarChapa <> 0 then
        Cadastro.FieldByName('LARCHAPA').AsFloat := VpfDOrcProduto.LarChapa;
      if VpfDOrcProduto.ComChapa <> 0 then
        Cadastro.FieldByName('COMCHAPA').AsFloat := VpfDOrcProduto.ComChapa;

      Cadastro.post;
      Result := Cadastro.AMensagemErroGravacao;
      if Cadastro.AErronaGravacao then
        break;
    end;
    if result <> '' then
      break;
  end;

  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.GravaDOrcamentoFracaoOP(VpaDOrcamento: TRBDOrcamentoCompraCorpo): string;
var
  VpfLaco : Integer;
  VpfDFracao : TRBDOrcamentoCompraFracaoOP;
begin
  ExecutaComandoSql(Aux,'Delete from ORCAMENTOCOMPRAFRACAOOP ' +
                        ' Where CODFILIAL = '+ IntToStr(VpaDOrcamento.CodFilial)+
                        ' AND SEQORCAMENTO = ' + IntToStr(VpaDOrcamento.SeqOrcamento));
  AdicionaSQLAbreTabela(Cadastro,'Select * from ORCAMENTOCOMPRAFRACAOOP ' +
                        ' Where CODFILIAL = 0 AND SEQORCAMENTO = 0 AND CODFILIALFRACAO = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0');
  for VpfLaco := 0 to VpaDOrcamento.FracaoOP.Count - 1 do
  begin
    VpfDFracao := TRBDOrcamentoCompraFracaoOP(VpaDOrcamento.FracaoOP.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDOrcamento.CodFilial;
    Cadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaDOrcamento.SeqOrcamento;
    Cadastro.FieldByName('CODFILIALFRACAO').AsInteger := VpfDFracao.CodFilialFracao;
    Cadastro.FieldByName('SEQORDEM').AsInteger := VpfDFracao.SeqOrdem;
    Cadastro.FieldByName('SEQFRACAO').AsInteger := VpfDFracao.SeqFracao;
    Cadastro.Post;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.CarDOrcamentoProduto(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
var
  VpfDProOrcamento : TRBDOrcamentoCompraProduto;
begin
  AdicionaSQLAbreTabela(Tabela,'Select ORI.SEQITEM, ORI.SEQPRODUTO, ORI.CODCOR, ORI.DESUM, ORI.QTDPRODUTO, '+
                               ' ORI.INDCOMPRADO, ORI.QTDSOLICITADA, ORI.QTDCOMPRADA, ORI.DATAPROVACAO, ORI.PERIPI, '+
                               ' ORI.QTDCHAPA, ORI.LARCHAPA, ORI.COMCHAPA,ORI.DESARQUIVOPROJETO, '+
                               ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL, PRO.L_DES_TEC,  '+
                               ' PRO.N_DEN_VOL, PRO.N_ESP_ACO, '+
                               ' COR.NOM_COR '+
                               ' from ORCAMENTOCOMPRAITEM ORI, CADPRODUTOS PRO, COR '+
                               ' Where ORI.CODFILIAL = '+IntToStr(VpaDOrcamento.CodFilial)+
                               ' and ORI.SEQORCAMENTO = '+IntToStr(VpaDOrcamento.SeqOrcamento)+
                               ' AND ORI.SEQPRODUTO = PRO.I_SEQ_PRO'+
                               ' AND '+SQLTextoRightJoin('ORI.CODCOR','COR.COD_COR')+
                               ' ORDER BY ORI.CODFILIAL,SEQORCAMENTO,SEQITEM');
  While not Tabela.eof do
  begin
    VpfDProOrcamento := VpaDOrcamento.addProduto;
    VpfDProOrcamento.CodFilial := VpaDOrcamento.CodFilial;
    VpfDProOrcamento.SeqOrcamento := VpaDOrcamento.SeqOrcamento;
    VpfDProOrcamento.SeqItem := Tabela.FieldByName('SEQITEM').AsInteger;
    VpfDProOrcamento.SeqProduto := Tabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDProOrcamento.CodCor := Tabela.FieldByName('CODCOR').AsInteger;
    VpfDProOrcamento.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDProOrcamento.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDProOrcamento.DesTecnica := Tabela.FieldByName('L_DES_TEC').AsString;
    VpfDProOrcamento.NomCor := Tabela.FieldByName('NOM_COR').AsString;
    VpfDProOrcamento.DesUM := Tabela.FieldByName('DESUM').AsString;
    VpfDProOrcamento.IndComprado := Tabela.FieldByName('INDCOMPRADO').AsString = 'S';
    VpfDProOrcamento.UnidadesParentes := FunProdutos.RUnidadesParentes(Tabela.FieldByName('UMORIGINAL').AsString);
    VpfDProOrcamento.QtdProduto := Tabela.FieldByName('QTDPRODUTO').AsFloat;
    VpfDProOrcamento.QtdSolicitada := Tabela.FieldByName('QTDSOLICITADA').AsFloat;
    VpfDProOrcamento.QtdComprado := Tabela.FieldByName('QTDCOMPRADA').AsFloat;
    VpfDProOrcamento.PerIPI := Tabela.FieldByName('PERIPI').AsFloat;
    VpfDProOrcamento.QtdChapa := Tabela.FieldByName('QTDCHAPA').AsFloat;
    VpfDProOrcamento.LarChapa := Tabela.FieldByName('LARCHAPA').AsFloat;
    VpfDProOrcamento.ComChapa := Tabela.FieldByName('COMCHAPA').AsFloat;
    VpfDProOrcamento.DatAprovacao := Tabela.FieldByName('DATAPROVACAO').AsDateTime;
    VpfDProOrcamento.DensidadeVolumetricaAco := Tabela.FieldByName('N_DEN_VOL').AsFloat;
    VpfDProOrcamento.EspessuraAco := Tabela.FieldByName('N_ESP_ACO').AsFloat;
    VpfDProOrcamento.DesArquivoProjeto:= Tabela.FieldByName('DESARQUIVOPROJETO').AsString;
    Tabela.next;
  end;
  Tabela.close;

end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.CarDOrcamentoFornecedor(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
var
  VpfDFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  AdicionaSQLAbreTabela(Tabela,'Select OCF.CODCLIENTE, OCF.CODCONDICAOPAGAMENTO, OCF.CODFORMAPAGAMENTO, '+
                               ' CODTRANSPORTADORA, VALFRETE, TIPFRETE, NOMCONTATO, DESEMAIL, OCF.VALFRETE, '+
                               ' CLI.C_NOM_CLI '+
                               ' from ORCAMENTOCOMPRAFORNECEDORCORPO OCF, CADCLIENTES CLI '+
                               ' Where OCF.CODFILIAL = '+IntToStr(VpaDOrcamento.CodFilial)+
                               ' and OCF.SEQORCAMENTO = '+IntToStr(VpaDOrcamento.SeqOrcamento)+
                               ' AND OCF.CODCLIENTE = CLI.I_COD_CLI '+
                               ' order by OCF.CODCLIENTE ');
  while not Tabela.eof do
  begin
    VpfDFornecedor := VpaDOrcamento.addFornecedor;
    VpfDFornecedor.CodFornecedor := Tabela.FieldByName('CODCLIENTE').AsInteger;
    VpfDFornecedor.CodCondicaoPagamento := Tabela.FieldByName('CODCONDICAOPAGAMENTO').AsInteger;
    VpfDFornecedor.CodFormaPagamento := Tabela.FieldByName('CODFORMAPAGAMENTO').AsInteger;
    VpfDFornecedor.CodTransportadora := Tabela.FieldByName('CODTRANSPORTADORA').AsInteger;
    VpfDFornecedor.TipFrete := Tabela.FieldByName('TIPFRETE').AsInteger;
    VpfDFornecedor.DesEmailFornecedor := Tabela.FieldByName('DESEMAIL').AsString;
    VpfDFornecedor.NomContato := Tabela.FieldByName('NOMCONTATO').AsString;
    VpfDFornecedor.NomFornecedor := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDFornecedor.ValFrete := Tabela.FieldByName('VALFRETE').AsFloat;
    Tabela.next;
  end;
  Tabela.close;
  CarDOrcamentoProdutoAdicionadoFornecedor(VpaDOrcamento);
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.CarDOrcamentoFracoes(VpaDOrcamento: TRBDOrcamentoCompraCorpo);
var
  VpfDFracaoOP: TRBDOrcamentoCompraFracaoOP;
begin
  FreeTObjectsList(VpaDOrcamento.FracaoOP);
  AdicionaSQLAbreTabela(Tabela,
                        ' SELECT OCF.CODFILIALFRACAO, OCF.SEQORDEM, OCF.SEQFRACAO,'+
                        ' CLI.C_NOM_CLI'+
                        ' FROM ORCAMENTOCOMPRAFRACAOOP OCF, CADCLIENTES CLI, ORDEMPRODUCAOCORPO OPC'+
                        ' WHERE OCF.CODFILIAL = '+IntToStr(VpaDOrcamento.CodFilial)+
                        ' AND OCF.SEQORCAMENTO = '+IntToStr(VpaDOrcamento.SeqOrcamento)+
                        ' AND OPC.EMPFIL = OCF.CODFILIALFRACAO'+
                        ' AND OPC.SEQORD = OCF.SEQORDEM'+
                        ' AND CLI.I_COD_CLI = OPC.CODCLI');
  while not Tabela.Eof do
  begin
    VpfDFracaoOP:= VpaDOrcamento.addFracao;

    VpfDFracaoOP.CodFilialFracao:= Tabela.FieldByName('CODFILIALFRACAO').AsInteger;
    VpfDFracaoOP.SeqOrdem:= Tabela.FieldByName('SEQORDEM').AsInteger;
    VpfDFracaoOP.SeqFracao:= Tabela.FieldByName('SEQFRACAO').AsInteger;
    VpfDFracaoOP.NomCliente:= Tabela.FieldByName('C_NOM_CLI').AsString;

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.CarDOrcamentoProdutoAdicionadoFornecedor(VpaDOrcamento : TRBDOrcamentoCompraCorpo);
var
  VpfDProOrcamento : TRBDOrcamentoCompraProduto;
  VpfLaco : Integer;
  VpfDProFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  for VpfLaco := 0 to VpaDOrcamento.Fornecedores.Count - 1 do
  begin
    VpfDProFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamento.Fornecedores.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Tabela,'Select ORI.SEQITEM, ORI.SEQPRODUTO, ORI.CODCOR, ORI.DESUM, ORI.QTDPRODUTO, '+
                               ' ORI.QTDCOMPRADA, ORI.PERIPI, ORI.QTDCHAPA, ORI.LARCHAPA, ORI.COMCHAPA, '+
                               ' ORI.VALUNITARIO, ORI.VALTOTAL, ORI.PERICMS,' +
                               ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL, PRO.L_DES_TEC,  '+
                               ' COR.NOM_COR, '+
                               ' PRF.DESREFERENCIA '+
                               ' from ORCAMENTOCOMPRAFORNECEDORITEM ORI, CADPRODUTOS PRO, COR, PRODUTOFORNECEDOR PRF '+
                               ' Where ORI.CODFILIAL = '+IntToStr(VpaDOrcamento.CodFilial)+
                               ' and ORI.SEQORCAMENTO = '+IntToStr(VpaDOrcamento.SeqOrcamento)+
                               ' and ORI.CODCLIENTE = '+IntToStr(VpfDProFornecedor.CodFornecedor)+
                               ' AND ORI.SEQPRODUTO = PRO.I_SEQ_PRO'+
                               ' AND '+SQLTextoRightJoin('ORI.SEQPRODUTO','PRF.SEQPRODUTO')+
                               ' AND '+SQLTextoRightJoin('ORI.CODCLIENTE','PRF.CODCLIENTE')+
                               ' AND '+SQLTextoRightJoin(SQLTextoIsNull('ORI.CODCOR','0'),'PRF.CODCOR')+
                               ' AND '+SQLTextoRightJoin('ORI.CODCOR','COR.COD_COR')+
                               ' ORDER BY ORI.CODFILIAL,SEQORCAMENTO,SEQITEM');
    While not Tabela.eof do
    begin
      VpfDProOrcamento := VpfDProFornecedor.addProdutoAdicionado;
      VpfDProOrcamento.CodFilial := VpaDOrcamento.CodFilial;
      VpfDProOrcamento.SeqOrcamento := VpaDOrcamento.SeqOrcamento;
      VpfDProOrcamento.SeqItem := Tabela.FieldByName('SEQITEM').AsInteger;
      VpfDProOrcamento.SeqProduto := Tabela.FieldByName('SEQPRODUTO').AsInteger;
      VpfDProOrcamento.CodCor := Tabela.FieldByName('CODCOR').AsInteger;
      VpfDProOrcamento.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
      VpfDProOrcamento.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
      VpfDProOrcamento.DesTecnica := Tabela.FieldByName('L_DES_TEC').AsString;
      VpfDProOrcamento.NomCor := Tabela.FieldByName('NOM_COR').AsString;
      VpfDProOrcamento.DesUM := Tabela.FieldByName('DESUM').AsString;
      VpfDProOrcamento.UnidadesParentes := FunProdutos.RUnidadesParentes(Tabela.FieldByName('UMORIGINAL').AsString);
      VpfDProOrcamento.QtdProduto := Tabela.FieldByName('QTDPRODUTO').AsFloat;
      VpfDProOrcamento.QtdSolicitada := Tabela.FieldByName('QTDPRODUTO').AsFloat;
      VpfDProOrcamento.ValUnitario := Tabela.FieldByName('VALUNITARIO').AsFloat;
      VpfDProOrcamento.ValTotal := Tabela.FieldByName('VALTOTAL').AsFloat;
      VpfDProOrcamento.QtdSolicitada := Tabela.FieldByName('QTDPRODUTO').AsFloat;
      VpfDProOrcamento.QtdComprado := Tabela.FieldByName('QTDCOMPRADA').AsFloat;
      VpfDProOrcamento.PerICMS := Tabela.FieldByName('PERICMS').AsFloat;
      VpfDProOrcamento.PerIPI := Tabela.FieldByName('PERIPI').AsFloat;
      VpfDProOrcamento.QtdChapa := Tabela.FieldByName('QTDCHAPA').AsFloat;
      VpfDProOrcamento.LarChapa := Tabela.FieldByName('LARCHAPA').AsFloat;
      VpfDProOrcamento.Comchapa := Tabela.FieldByName('COMCHAPA').AsFloat;
      VpfDProOrcamento.DesReferenciaFornecedor := Tabela.FieldByName('DESREFERENCIA').AsString;
      Tabela.next;
    end;
    Tabela.close;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.CarProdutoSelecionados(VpaProdutos: TList; VpaDOrcamento: TRBDOrcamentoCompraCorpo;VpaCodFornecedor : Integer);
var
  VpfLacoProduto : Integer;
  VpfDProdutoOrc, VpfDProdutoFornecedor : TRBDOrcamentoCompraProduto;
  VpfDProdutoPedidoCompra : TRBDProdutoPedidoCompra;
begin
  for VpfLacoProduto := 0 to VpaDOrcamento.Produtos.Count - 1 do
  begin
    VpfDProdutoOrc := TRBDOrcamentoCompraProduto(VpaDOrcamento.Produtos.Items[VpfLacoProduto]);
    if VpfDProdutoOrc.IndMarcado then
    begin
      VpfDProdutoPedidoCompra:= TRBDProdutoPedidoCompra.Cria;
      VpaProdutos.Add(VpfDProdutoPedidoCompra);
      VpfDProdutoPedidoCompra.SeqProduto:= VpfDProdutoOrc.SeqProduto;
      VpfDProdutoPedidoCompra.CodCor:= VpfDProdutoOrc.CodCor;
      VpfDProdutoPedidoCompra.CodProduto:= VpfDProdutoOrc.CodProduto;
      VpfDProdutoPedidoCompra.QtdChapa:= VpfDProdutoOrc.QtdChapa;
      VpfDProdutoPedidoCompra.LarChapa:= VpfDProdutoOrc.LarChapa;
      VpfDProdutoPedidoCompra.ComChapa:= VpfDProdutoOrc.ComChapa;
      VpfDProdutoPedidoCompra.QtdSolicitada:= VpfDProdutoOrc.QtdSolicitada;
      if VpfDProdutoPedidoCompra.QtdSolicitada < 0 then
        VpfDProdutoPedidoCompra.QtdSolicitada:= 0;
      VpfDProdutoPedidoCompra.DatAprovacao :=  VpfDProdutoOrc.DatAprovacao;
      VpfDProdutoFornecedor := RProdutoFornecedor(VpaDOrcamento,VpaCodFornecedor,VpfDProdutoOrc.SeqProduto,VpfDProdutoOrc.CodCor,VpfDProdutoOrc.LarChapa,VpfDProdutoOrc.ComChapa);
      VpfDProdutoPedidoCompra.QtdProduto := VpfDProdutoFornecedor.QtdProduto;
      VpfDProdutoPedidoCompra.ValUnitario := VpfDProdutoFornecedor.ValUnitario;
      VpfDProdutoPedidoCompra.PerIPI := VpfDProdutoFornecedor.PerIPI;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.MarcaProdutosComoComprado(VpaDMapaCompras, VpaDOrcamento: TRBDOrcamentoCompraCorpo);
var
  VpfLaco : Integer;
  VpfDProdutoMapa, VpfDProdutoOrc : TRBDOrcamentoCompraProduto;
begin
  for VpfLaco := 0 to VpaDMapaCompras.Produtos.Count - 1 do
  begin
    VpfDProdutoMapa := TRBDOrcamentoCompraProduto(VpaDMapaCompras.Produtos.Items[VpfLaco]);
    if VpfDProdutoMapa.IndMarcado then
    begin
      VpfDProdutoOrc := RProdutoOrcamento(VpaDOrcamento,VpfDProdutoMapa.SeqProduto,VpfDProdutoMapa.CodCor,VpfDProdutoMapa.LarChapa,VpfDProdutoMapa.ComChapa);
      if VpfDProdutoOrc <> nil then
        VpfDProdutoOrc.IndComprado := true;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.MontaCabecalhoEmail(VpaTexto : TStrings; VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo;VpaDFilial : TRBDFilial);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDOrcamentoCompra.CodFilial)+' - Orcamento de Compra : '+IntToStr(VpaDOrcamentoCompra.SeqOrcamento));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <a href="http://'+VpaDFilial.DesSite+ '">');
  VpaTexto.add('      <IMG src="cid:'+IntToStr(VpaDOrcamentoCompra.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+'border="0" >');
  VpaTexto.add('    </a></td> <td bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <b>'+VpaDFilial.NomFantasia+ '.</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesEndereco+'              Bairro : '+VpaDFilial.DesBairro);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF+ '                CEP : '+VpaDFilial.DesCep);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+VpaDFilial.DesFone +'         -             e-mail comercial :'+VpaDFilial.DesEmailComercial);
//  VpaTexto.add('    <br>');
//Nao é mais enviado o cnpj porque na premer estava dando confusao quando o forndecedor fazia o pedido;
//  VpaTexto.add('    CNPJ : '+VpaDFilial.DesCNPJ +'         -             Inscrição Estadual :'+VpaDFilial.DesInscricaoEstadual);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+VpaDFilial.DesSite+'">'+VpaDFilial.DesSite);
  VpaTexto.add('    </td><td bgcolor="#'+varia.CRMCorClaraEmail+'"> ');
  VpaTexto.add('    <center>');
  VpaTexto.add('    <h3> Cotação de Compra </h3>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <h2> '+formatFloat('###,###,##0',VpaDOrcamentoCompra.SeqOrcamento)+'</h2>');
  VpaTexto.add('    </center>');
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.MontaEmailOrcamentoCompraTexto(VpaTexto : TStrings; VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
begin
  VpaTexto.add('Erro na transmissão da proposta');
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.MontaEmailOrcamentoCompra(VpaTexto : TStrings; VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo;VpaDOrcFornecedor :TRBDOrcamentoCompraFornecedor; VpaDCliente : TRBDCliente; VpaDComprador : TRBDComprador; VpaDFilial : TRBDFilial);
var
  VpfLaco : Integer;
  Vpfbmppart : TIdAttachmentfile;
  VpfDItem : TRBDOrcamentoCompraProduto;
  VpfObservacoes : TStringList;
  VpfCamposRetorno : String;
  VpfDTransportadora : TRBDCliente;
  VpfColunaRefFornecedor, VpfColunaProduto, VpfColunaObs : Integer;
begin
  VpfDTransportadora := TRBDCliente.cria;
  VpfCamposRetorno := '';
  if not Config.NaoEnviarLogoNoOrcamentoePedidodeCompa then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDOrcamentoCompra.CodFilial)+'.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDOrcamentoCompra.CodFilial)+'.jpg';
    Vpfbmppart.DisplayName := inttoStr(VpaDOrcamentoCompra.CodFilial)+'.jpg';
  end;

  MontaCabecalhoEmail(VpaTexto,VpaDOrcamentoCompra,VpaDFilial);
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="100%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" align="center" size="4"><b>');
  VpaTexto.add('<center>COTAÇÃO DE PREÇOS!!!</center></font></b><br>');
  VpaTexto.add('<font face="Verdana" align="center" size="2">Prezado Fornecedor,<br>');
  VpaTexto.add('Solicitamos que as informações abaixo sejam respondidas nesse próprio e-mail e com a maior brevidade possível');
  VpaTexto.add('  </td></tr></table>');
  VpaTexto.add('<br>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="100%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="2"><b>');
  VpaTexto.add('ATENÇÃO FORNECEDOR!!!<br>');
  VpaTexto.add('RESPONDA ESSE EMAIL PREENCHENDO OS CAMPOS AMARELO ABAIXO.<br>');
  VpaTexto.add('  </td></tr></table>');
  VpaTexto.add('<br>');

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data</td><td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY',VpaDOrcamentoCompra.DatOrcamento)+ '</td>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Comprador</td><td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDComprador.NomComprador  +'</td>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Prazo</td><td width="20%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;<b>');
  if VpaDOrcamentoCompra.DatPrevista > MontaData(1,1,1900) then
    VpaTexto.add(FormatDateTime('DD/MM/YYYY',VpaDOrcamentoCompra.DatPrevista))
  else
    VpaTexto.add('      ');
  VpaTexto.add('</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  //fornecedor
  VpaTexto.add('    <br>');
  VpaTexto.add('<table width="100%" border=1 cellpadding="0" cellspacing="0" >');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fornecedor</td>');
  VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDCliente.CodCliente)+ '-'+VpaDCliente.NomCliente +' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Endere&ccedil;o</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesEndereco+'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Bairro</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesBairro +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cep</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CepCliente+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cidade</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesCidade+'/'+VpaDCliente.DesUF +'</td>');
  if VpaDCliente.TipoPessoa = 'F' Then
  begin
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CPF</td>');
    VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;RG</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.RG+'</td>');
  end
  else
  begin
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CNPJ</td>');
    VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Inscrição Estadual</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.InscricaoEstadual+'</td>');
  end;
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fone</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFone1 +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fax</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFax+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;contato</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+{VpaDOrcamentoCompra.NomContato+}'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%>');
  VpaTexto.add('  <tr>');
  if VpaDOrcamentoCompra.CodCondicaoPagto = 0 then
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Condição Pagamento</td><td width="35%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;<b>      </td>')
  else
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Condição Pagamento</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomCondicaoPagamento(VpaDOrcamentoCompra.CodCondicaoPagto)+'</td>');
  if VpaDOrcamentoCompra.CodFormaPagto = 0 then
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Forma Pagamento</td><td width="35%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;<b>      </td>')
  else
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Forma Pagamento</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomFormaPagamento(VpaDOrcamentoCompra.CodFormaPagto) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%" border=1 cellpadding="0" cellspacing="0">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=11 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Produtos</td>');
  VpaTexto.add('</tr><tr>');
  if config.ControlarEstoquedeChapas then
  begin
    VpfColunaRefFornecedor := 7;
    VpfColunaProduto := 25;
    VpfColunaObs := 10;
  end
  else
  begin
    VpfColunaRefFornecedor := 10;
    VpfColunaProduto := 30;
    VpfColunaObs := 15;
  end;
  VpaTexto.add('        <td width="'+IntToStr(VpfColunaRefFornecedor)+'%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Ref Fornecedor</td>');
  VpaTexto.add('        <td width="'+IntToStr(VpfColunaProduto)+'%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Produto</td>');
  if config.ControlarEstoquedeChapas then
  begin
    VpaTexto.add('        <td width="3%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Qtd Chapas</td>');
    VpaTexto.add('        <td width="5%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Lar Chapa (MM)</td>');
    VpaTexto.add('        <td width="5%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Cmp Chapa (MM)</td>');
  end;

  VpaTexto.add('        <td width="'+IntToStr(VpfColunaObs)+'%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Obs</td>');
  VpaTexto.add('        <td width="5%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;UM</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="5%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;%IPI</td>');
  for VpfLaco := 0 to VpaDOrcFornecedor.ProdutosAdicionados.Count - 1 do
  begin
    VpfDItem := TRBDOrcamentoCompraProduto(VpaDOrcFornecedor.ProdutosAdicionados.Items[VpfLaco]);
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('        <td width="'+IntToStr(VpfColunaRefFornecedor)+'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">&nbsp;'+VpfDItem.DesReferenciaFornecedor+ '</td>');

    if config.OrcamentodeCompraEnviarSempreNomedoProdutoEmail then
      VpaTexto.add('      <td width="'+IntToStr(VpfColunaProduto)+'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.CodProduto+'-'+VpfDItem.NomProduto+'</td>')
    else
    begin
      if VpfDItem.DesTecnica <> '' then
        VpaTexto.add('      <td width="'+IntToStr(VpfColunaProduto)+'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.CodProduto+'-'+VpfDItem.DesTecnica+'</td>')
      else
        VpaTexto.add('      <td width="'+IntToStr(VpfColunaProduto)+'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.CodProduto+'-'+VpfDItem.NomProduto+'</td>');
    end;
    if config.ControlarEstoquedeChapas then
    begin
      VpaTexto.add('      <td width="3%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">&nbsp;'+FormatFloat('#,###,###',VpfDItem.QtdChapa)+' </td>');
      VpaTexto.add('      <td width="5%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">&nbsp;'+FormatFloat('#,###,###',VpfDItem.LarChapa)+' </td>');
      VpaTexto.add('      <td width="5%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">&nbsp;'+FormatFloat('#,###,###',VpfDItem.ComChapa)+' </td>');
    end;
    VpaTexto.add('      <td width="'+IntToStr(VpfColunaObs)+'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">&nbsp;'+VpfDItem.NomCor+' </td>');
    VpaTexto.add('      <td width="5%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.DesUM+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraQtd,VpfDItem.QtdProduto)+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#FFFF00" align="center"><font face="Verdana" size="3">&nbsp; </td>');
    VpaTexto.add('	<td width="15%" bgcolor="#FFFF00" align="center"><font face="Verdana" size="3">&nbsp; </td>');
    VpaTexto.add('	<td width="15%" bgcolor="#FFFF00" align="center"><font face="Verdana" size="3">&nbsp; </td>');
  end;
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table><br>');

  if VpaDOrcFornecedor.CodTransportadora <> 0 then
  begin
    VpfDTransportadora.CodCliente := VpaDOrcFornecedor.CodTransportadora;
    FunClientes.CarDCliente(VpfDTransportadora)
  end;

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>Transportadora</td>');
  VpaTexto.add('	<td width="50%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">'+VpfDTransportadora.NomCliente +' </td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Frete por Conta</td>');
  if VpaDOrcFornecedor.TipFrete = 1 then
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp; </td>')
  else
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp; </td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table>');


  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">'+{RTextoAcrescismoDesconto(VpaDPedidoCompra) +}'</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">'+{RValorAcrescimoDesconto(VpaDPedidoCompra) +}'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Frete</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;    </td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  AnexaArquivoProjetoEmailFornecedor(VpaDOrcamentoCompra);

  VpfObservacoes := TStringList.create;
{  VpfObservacoes.Text := VpaDOrcFornecedor.DesObservacao;
  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>&nbsp;Observações</td>');
  VpaTexto.add('</tr><tr>');
  if VpfObservacoes.Count > 0 then
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="2">&nbsp;'+VpfObservacoes.Strings[0] +'<br>')
  else
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="2">&nbsp;');
  for Vpflaco := 1 to VpfObservacoes.count - 1 do
    VpaTexto.add(VpfObservacoes.strings[VpfLaco]+'<br>');
  VpaTexto.add('</td></tr>');
  VpaTexto.add('</table><br>');}

//  VpaTexto.add('<b><li>Obrigatório colocar o número da ordem de compra na nota fiscal, caso contrário será devolvido;</b>');
//  VpaTexto.add('<li>Favor confirmar o recebimento desse pedido por escrito;');
//  VpaTexto.add('<li>Mercadorias estão sujeitas a conferência de preço, qualidade e quantidade.');
{  VpfObservacoes.Text := RRodapePedidoCompra(VpaDPedidoCompra.CodFilial);
  for VpfLaco := 0 to VpfObservacoes.Count - 1 do
    VpaTexto.Add(VpfObservacoes.Strings[VpfLaco]);}

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  if Sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
  VpfObservacoes.free;
  VpfDTransportadora.free;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDComprador : TRBDComprador) : string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := VpaDComprador.DesEmail;

  VpaMensagem.From.Name := VpaDFilial.NomFantasia;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := varia.PortaSMTP;
  if config.ServidorInternetRequerAutenticacao then
    VpaSMTP.AuthType := satDefault
  else
    VpaSMTP.AuthType := satNone;

  VpaMensagem.ReceiptRecipient.Text  := VpaDComprador.DesEmail;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DO COMPRADOR !!!'#13'É necessário preencher o e-mail do comprador.';
  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    VpaSMTP.Connect;
    try
      VpaSMTP.Send(VpaMensagem);
    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
        VpaSMTP.Disconnect;
      end;
    end;
    VpaSMTP.Disconnect;
    VpaMensagem.Clear;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.CopiaDProdutoOrcamento(VpaDProOrigem, VpaDProDestino : TRBDOrcamentoCompraProduto);
begin
    VpaDProDestino.CodFilial := VpaDProOrigem.CodFilial;
    VpaDProDestino.SeqOrcamento := VpaDProOrigem.SeqOrcamento;
    VpaDProDestino.SeqItem := VpaDProOrigem.SeqItem;
    VpaDProDestino.SeqProduto := VpaDProOrigem.SeqProduto;
    VpaDProDestino.CodCor := VpaDProOrigem.CodCor;
    VpaDProDestino.CodProduto := VpaDProOrigem.CodProduto;
    VpaDProDestino.NomProduto := VpaDProOrigem.NomProduto;
    VpaDProDestino.DesTecnica := VpaDProOrigem.DesTecnica;
    VpaDProDestino.NomCor := VpaDProOrigem.NomCor;
    VpaDProDestino.DesUM := VpaDProOrigem.DesUM;
    VpaDProDestino.IndComprado := VpaDProOrigem.IndComprado;
    VpaDProDestino.UnidadesParentes := FunProdutos.RUnidadesParentes(VpaDProOrigem.DesUM); ;
    VpaDProDestino.QtdProduto := VpaDProOrigem.QtdProduto;
    VpaDProDestino.QtdSolicitada := VpaDProOrigem.QtdSolicitada;
    VpaDProDestino.QtdComprado := VpaDProOrigem.QtdComprado;
    VpaDProDestino.ValUnitario := VpaDProOrigem.ValUnitario;
    VpaDProDestino.QtdChapa := VpaDProOrigem.QtdChapa;
    VpaDProDestino.LarChapa := VpaDProOrigem.LarChapa;
    VpaDProDestino.ComChapa := VpaDProOrigem.ComChapa;
    VpaDProDestino.ValTotal := VpaDProOrigem.ValTotal;
    VpaDProDestino.PerIPI := VpaDProOrigem.PerIPI;
    VpaDProDestino.DatAprovacao := VpaDProOrigem.DatAprovacao;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.ExcluiProdutoNosFornecedores(VpaDOrcamentoCompra: TRBDOrcamentoCompraCorpo);
var
  VpfLacoNaoAdicionado, VpfLacoAdicionado, VpfLacoFornecedor : Integer;
  VpfDProdutoFor : TRBDOrcamentoCompraProduto;
  VpfDFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  for VpfLacoFornecedor := 0 to VpaDOrcamentoCompra.Fornecedores.Count - 1 do
  begin
    VpfDFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamentoCompra.Fornecedores.Items[VpfLacoFornecedor]);
    //produtos adicionados
    for VpfLacoAdicionado := VpfDFornecedor.ProdutosAdicionados.Count -1 downto 0 do
    begin
      VpfDProdutoFor := TRBDOrcamentoCompraProduto(VpfDFornecedor.ProdutosAdicionados.Items[VpfLacoAdicionado]);
      if not ExisteProdutonoOrcamento(VpaDOrcamentoCompra,VpfDProdutoFor.SeqProduto,VpfDProdutoFor.CodCor) then
      begin
        TRBDOrcamentoCompraProduto(VpfDFornecedor.ProdutosAdicionados.Items[VpfLacoAdicionado]).Free;
        VpfDFornecedor.ProdutosAdicionados.Delete(VpfLacoAdicionado);
      end;
    end;
    //produtos nao adicionados
    for VpfLacoNaoAdicionado := VpfDFornecedor.ProdutosNaoAdicionados.Count -1 downto 0 do
    begin
      VpfDProdutoFor := TRBDOrcamentoCompraProduto(VpfDFornecedor.ProdutosNaoAdicionados.Items[VpfLacoNaoAdicionado]);
      if not ExisteProdutonoOrcamento(VpaDOrcamentoCompra,VpfDProdutoFor.SeqProduto,VpfDProdutoFor.CodCor) then
      begin
        TRBDOrcamentoCompraProduto(VpfDFornecedor.ProdutosNaoAdicionados.Items[VpfLacoNaoAdicionado]).Free;
        VpfDFornecedor.ProdutosNaoAdicionados.Delete(VpfLacoNaoAdicionado);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.AdicionaProdutoNosFornecedores(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
var
  VpfLacoProduto, VpfLacoFornecedor : Integer;
  VpfDProduto,VpfDProFornecedor : TRBDOrcamentoCompraProduto;
  VpfDFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  for VpflacoProduto := 0 to VpaDOrcamentoCompra.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcamentoCompraProduto(VpaDOrcamentoCompra.Produtos.Items[VpfLacoProduto]);
    for VpfLacoFornecedor := 0 to VpaDOrcamentoCompra.Fornecedores.Count - 1 do
    begin
      VpfDFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamentoCompra.Fornecedores.Items[VpfLacoFornecedor]);
      if not ExisteProdutoAdicionadoFornecedor(VpfDProduto,VpfDFornecedor.ProdutosNaoAdicionados) then
      begin
        if not ExisteProdutoAdicionadoFornecedor(VpfDProduto,VpfDFornecedor.ProdutosAdicionados) then
        begin
          VpfDProFornecedor  := VpfDFornecedor.addProdutoAdicionado;
          CopiaDProdutoOrcamento(VpfDProduto,VpfDProFornecedor);
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.ExisteProdutoAdicionadoFornecedor(VpaDProOrcamento : TRBDOrcamentoCompraProduto;VpaProdutos : TList):boolean;
var
  VpfLaco : Integer;
  VpfDProFornecedor : TRBDOrcamentoCompraProduto;
begin
  result := false;
  for Vpflaco := 0 to VpaProdutos.Count - 1 do
  begin
    VpfDProFornecedor := TRBDOrcamentoCompraProduto(VpaProdutos.Items[VpfLaco]);
    if (VpfDProFornecedor.SeqProduto = VpaDProOrcamento.SeqProduto) and
       (VpfDProFornecedor.CodCor = VpaDProOrcamento.CodCor) then
      exit(true);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.ExisteProdutonoOrcamento(VpaDOrcamento : TRBDOrcamentoCompraCorpo; VpaSeqProduto, VpaCodCor : Integer):Boolean;
var
  VpfLaco : Integer;
  VpfDProduto : TRBDOrcamentoCompraProduto;
begin
  result := false;
  for VpfLaco := 0 to VpaDOrcamento.Produtos.Count - 1 do
  begin
    VpfDProduto:= TRBDOrcamentoCompraProduto(VpaDOrcamento.Produtos.Items[VpfLaco]);
    if (VpfDProduto.SeqProduto = VpaSeqProduto) and
       (VpfDProduto.CodCor = VpaCodCor) then
      exit(true);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.ExisteSolicitacaoOrcamentoCompra(VpaDOrcamento: TRBDOrcamentoCompraCorpo;
  VpaDSolicitacaoCompra: TRBDSolicitacaoCompraCorpo): boolean;
var
  VpfLaco : Integer;
  VpfDSolicitacao : TRBDSolicitacaoCompraCorpo;
begin
  result := false;
  for VpfLaco := 0 to VpaDOrcamento.SolicitacoesCompra.Count - 1 do
  begin
    VpfDSolicitacao := TRBDSolicitacaoCompraCorpo(VpaDOrcamento.SolicitacoesCompra.Items[VpfLaco]);
    if (VpfDSolicitacao.CodFilial = VpaDSolicitacaoCompra.CodFilial) and
       (VpfDSolicitacao.SeqSolicitacao = VpaDSolicitacaoCompra.SeqSolicitacao)  then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.GravaDOrcamento(VpaDOrcamento :TRBDOrcamentoCompraCorpo):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from ORCAMENTOCOMPRACORPO '+
                                 ' Where CODFILIAL = '+IntToStr(VpaDOrcamento.CodFilial)+
                                 ' and SEQORCAMENTO = '+IntToStr(VpaDOrcamento.SeqOrcamento));
  if VpaDOrcamento.SeqOrcamento = 0 then
    Cadastro.insert
  else
    Cadastro.Edit;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDOrcamento.CodFilial;
  Cadastro.FieldByName('CODFILIALFATURAMENTO').AsInteger := VpaDOrcamento.CodFilialFaturamento;
  Cadastro.FieldByName('DESSITUACAO').AsString := VpaDOrcamento.DesSituacao;
  if VpaDOrcamento.CodCondicaoPagto <> 0 then
    Cadastro.FieldByName('CODCONDICAOPAGAMENTO').AsInteger := VpaDOrcamento.CodCondicaoPagto
  else
    Cadastro.FieldByName('CODCONDICAOPAGAMENTO').clear;
  if VpaDOrcamento.CodFormaPagto <> 0 then
    Cadastro.FieldByName('CODFORMAPAGAMENTO').AsInteger := VpaDOrcamento.CodFormaPagto
  else
    Cadastro.FieldByName('CODFORMAPAGAMENTO').Clear;
  Cadastro.FieldByName('DATEMISSAO').AsDateTime := VpaDOrcamento.DatOrcamento;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDOrcamento.CodUsuario;
  if VpaDOrcamento.DatFinalizacao > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATFIM').AsDateTime := VpaDOrcamento.DatFinalizacao
  else
    Cadastro.FieldByName('DATFIM').Clear;
  if VpaDOrcamento.DatPrevista > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATPREVISAOFIM').AsDateTime := VpaDOrcamento.DatPrevista
  else
    Cadastro.FieldByName('DATPREVISAOFIM').Clear;
  Cadastro.FieldByName('DESOBSERVACAO').AsString := VpaDOrcamento.DesObservacao;
  Cadastro.FieldByName('CODESTAGIO').AsInteger := VpaDOrcamento.CodEstagio;
  if VpaDOrcamento.CodTransportadora <> 0 then
    Cadastro.FieldByName('CODTRANSPORTADORA').AsInteger := VpaDOrcamento.CodTransportadora
  else
    Cadastro.FieldByName('CODTRANSPORTADORA').Clear;
  Cadastro.FieldByName('TIPFRETE').AsInteger := VpaDOrcamento.TipFrete;
  Cadastro.FieldByName('CODCOMPRADOR').AsInteger := VpaDOrcamento.CodComprador;
  if VpaDOrcamento.SeqOrcamento = 0 then
    VpaDOrcamento.SeqOrcamento := RSeqOrcamentoDisponivel(VpaDOrcamento.CodFilial);
  Cadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaDOrcamento.SeqOrcamento;

  Cadastro.post;
  Result := Cadastro.AMensagemErroGravacao;
  if result = '' then
  begin
    result := GravaDOrcamentoProduto(VpaDOrcamento);
    if result = '' then
    begin
      Result := GravaDOrcamentoFornecedor(VpaDOrcamento);
      if result = '' then
      begin
        result := GravaDOrcamentoFornecedorProduto(VpaDOrcamento);
        if result = '' then
        begin
          result := GravaDOrcamentoFracaoOP(VpaDOrcamento);
          if result = '' then
          begin
            result := GravaDOrcamentoSolicitacaoCompra(VpaDOrcamento);
          end;
        end;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.CarDOrcamento(VpaCodFilial, VpaSeqOrcamento : Integer;VpaDOrcamento :TRBDOrcamentoCompraCorpo);
begin
  AdicionaSQLAbreTabela(Tabela,'Select ORC.CODFILIAL, ORC.SEQORCAMENTO, ORC.DESSITUACAO, ORC.CODFILIALFATURAMENTO, '+
                               ' ORC.CODCONDICAOPAGAMENTO, ORC.CODFORMAPAGAMENTO, ORC.DATEMISSAO, ORC.CODUSUARIO, '+
                               ' ORC.DATFIM, ORC.DESOBSERVACAO, ORC.CODESTAGIO, ORC.CODTRANSPORTADORA, ORC.VALFRETE,'+
                               ' ORC.TIPFRETE, ORC.CODCOMPRADOR, ORC.DATPREVISAOFIM '+
                               ' FROM ORCAMENTOCOMPRACORPO ORC '+
                               ' Where ORC.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' and ORC.SEQORCAMENTO = '+IntToStr(VpaSeqOrcamento));
  with VpaDOrcamento do
  begin
    CodFilial := Tabela.FieldByName('CODFILIAL').AsInteger;
    CodFilialFaturamento := Tabela.FieldByName('CODFILIALFATURAMENTO').AsInteger;
    SeqOrcamento := Tabela.FieldByName('SEQORCAMENTO').AsInteger;
    CodUsuario := Tabela.FieldByName('CODUSUARIO').AsInteger;
    CodCondicaoPagto := Tabela.FieldByName('CODCONDICAOPAGAMENTO').AsInteger;
    CodFormaPagto := Tabela.FieldByName('CODFORMAPAGAMENTO').AsInteger;
    CodTransportadora := Tabela.FieldByName('CODTRANSPORTADORA').AsInteger;
    CodEstagio := Tabela.FieldByName('CODESTAGIO').AsInteger;
    CodComprador := Tabela.FieldByName('CODCOMPRADOR').AsInteger;
    TipFrete := Tabela.FieldByName('TIPFRETE').AsInteger;
    DesSituacao := Tabela.FieldByName('DESSITUACAO').AsString;
    DesObservacao := Tabela.FieldByName('DESOBSERVACAO').AsString;
    DatOrcamento := Tabela.FieldByName('DATEMISSAO').AsDateTime;
    DatPrevista := Tabela.FieldByName('DATPREVISAOFIM').AsDateTime;
    DatFinalizacao := Tabela.FieldByName('DATFIM').AsDateTime;
  end;
  CarDOrcamentoProduto(VpaDOrcamento);
  CarDOrcamentoFornecedor(VpaDOrcamento);
  CarDOrcamentoFracoes(VpaDOrcamento);
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.AdicionaProdutosFornecedor(VpaDOrcamento : TRBDOrcamentoCompraCorpo;VpaDOrcamentoFornecedor : TRBDOrcamentoCompraFornecedor);
var
  VpfDProFornecedor, VpfDProOrcamento : TRBDOrcamentoCompraProduto;
  VpfLaco : Integer;
begin
  FreeTObjectsList(VpaDOrcamentoFornecedor.ProdutosAdicionados);
  FreeTObjectsList(VpaDOrcamentoFornecedor.ProdutosNaoAdicionados);
  for VpfLaco := 0 to VpaDOrcamento.Produtos.Count - 1 do
  begin
    VpfDProFornecedor  := VpaDOrcamentoFornecedor.addProdutoAdicionado;
    VpfDProOrcamento := TRBDOrcamentoCompraProduto(VpaDOrcamento.Produtos.Items[VpfLaco]);
    CopiaDProdutoOrcamento(VpfDProOrcamento,VpfDProFornecedor);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.EnviaEmailFornecedor(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo) : String;
var
  VpfLacoFornecedor : Integer;
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfDOrcFornecedor : TRBDOrcamentoCompraFornecedor;
  VpfEmailVendedor : String;
  VpfDFilial : TRBDFilial;
  VpfDCliente : TRBDCliente;
  VpfDComprador : TRBDComprador;
begin
  result := '';
  for VpfLacoFornecedor := 0 to VpaDOrcamentoCompra.Fornecedores.Count - 1 do
  begin
    VpfDOrcFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamentoCompra.Fornecedores.Items[VpfLacoFornecedor]);
    if VpfDOrcFornecedor.DesEmailFornecedor <> '' then
    begin
      VpfDFilial := TRBDFilial.cria;
      if VpaDOrcamentoCompra.CodFilialFaturamento <> 0 then
        Sistema.CarDFilial(VpfDFilial,VpaDOrcamentoCompra.CodFilialFaturamento)
      else
        Sistema.CarDFilial(VpfDFilial,VpaDOrcamentoCompra.CodFilial);

      VpfDCliente := TRBDCliente.cria;
      VpfDCliente.CodCliente := VpfDOrcFornecedor.CodFornecedor;
      FunClientes.CarDCliente(VpfDCliente,true);

      VpfDComprador := TRBDComprador.cria;
      FunClientes.CarDComprador(VpfDComprador,VpaDOrcamentoCompra.CodComprador);

      VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
      VpfEmailHTML.ContentType := 'text/html';

      MontaEmailOrcamentoCompra(VpfEmailHTML.Body,VpaDOrcamentoCompra,VpfDOrcFornecedor, VpfDCliente,VpfDComprador, VpfDFilial);
      VpfEmailHTML.Body.Text := RetiraAcentuacao(VpfEmailHTML.Body.Text);
//      VpfEmailHTML.Body.Text := RetiraAcentuacaoHTML(VpfEmailHTML.Body.Text);

      VprMensagem.Recipients.EMailAddresses := VpfDOrcFornecedor.DesEmailFornecedor;
      VprMensagem.ReplyTo.EMailAddresses := VpfDComprador.DesEmail;
      VprMensagem.Recipients.Add.Address := VpfDComprador.DesEmail;
      if (Varia.EmailGeralCompras <> '') and
         (UpperCase(varia.EmailGeralCompras) <> UpperCase(VpfDComprador.DesEmail)) then
        VprMensagem.Recipients.Add.Address := Varia.EmailGeralCompras;


      VprMensagem.Subject := VpfDFilial.NomFantasia+' - Cotação de preços nr. ' +IntToStr(VpaDOrcamentoCompra.SeqOrcamento);
      result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial,VpfDComprador);
  {    if Result = '' then
        result := AlteraEstagioPedidoCompra(VpaDPedidoCompra.CodFilial,VpaDPedidoCompra.SeqPedido,Varia.EstagioComprasAguardandoConfirmacaoRecebFornececedor,'E-mail enviado');}
      VpfDFilial.free;
      VpfDCliente.free;
      VpfDComprador.free;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.EstornaProdutosComprados(VpaDPedidoCompra: TRBDPedidoCompraCorpo): string;
var
  VpfDOrcamento : TRBDOrcamentoCompraCorpo;
begin
  AdicionaSQLAbreTabela(Pedidos,'Select CODFILIAL, SEQORCAMENTO ' +
                               ' FROM ORCAMENTOPEDIDOCOMPRA ' +
                               ' Where CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                               ' and SEQPEDIDO = ' +IntToStr(VpaDPedidoCompra.SeqPedido));
  while not Pedidos.Eof do
  begin
    VpfDOrcamento := TRBDOrcamentoCompraCorpo.cria;
    CarDOrcamento(Pedidos.FieldByName('CODFILIAL').AsInteger,Pedidos.FieldByName('SEQORCAMENTO').AsInteger,VpfDOrcamento);
    EstornaProdutosdoPedidoNoOrcamento(VpaDPedidoCompra,VpfDOrcamento);
    result := GravaDOrcamento(VpfDOrcamento);
    VpfDOrcamento.Free;
    Pedidos.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrcamentoCompra.EstornaProdutosdoPedidoNoOrcamento(VpaDPedidoCompra: TRBDPedidoCompraCorpo;VpaDOrcamento: TRBDOrcamentoCompraCorpo): string;
var
  VpfLacoPedido :Integer;
  VpfDProdutoPedido : TRBDProdutoPedidoCompra;
  VpfDProdutoOrcamento : TRBDOrcamentoCompraProduto;
begin
  for VpfLacoPedido := 0 to VpaDPedidoCompra.Produtos.Count - 1 do
  begin
    VpfDProdutoPedido := TRBDProdutoPedidoCompra(VpaDPedidoCompra.Produtos.Items[VpfLacoPedido]);
    VpfDProdutoOrcamento := RProdutoOrcamento(VpaDOrcamento,VpfDProdutoPedido.SeqProduto,VpfDProdutoPedido.CodCor,VpfDProdutoPedido.LarChapa,VpfDProdutoPedido.ComChapa);
    if VpfDProdutoOrcamento <> nil then
      VpfDProdutoOrcamento.IndComprado := false;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.AdicionaFornecedoresOrcamentoCompra(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
var
  VpfLaco : Integer;
  VpfDProOrcamento, VpfDProFornecedor : TRBDOrcamentoCompraProduto;
  VpfDFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  for VpfLaco := 0 to VpaDOrcamentoCompra.Produtos.Count - 1 do
  begin
    VpfDProOrcamento := TRBDOrcamentoCompraProduto(VpaDOrcamentoCompra.Produtos.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Tabela,'Select CODCLIENTE, DESREFERENCIA, CODCOR '+
                                 ' from PRODUTOFORNECEDOR '+
                                 ' Where SEQPRODUTO = '+IntToStr(VpfDProOrcamento.SeqProduto)+
                                 ' and CODCOR = '+IntToStr(VpfDProOrcamento.CodCor));
    While not Tabela.eof do
    begin
      if Tabela.FieldByName('CODCLIENTE').AsInteger <> 0 then
      begin
        VpfDFornecedor := RFornecedorPedidoCompra(VpaDOrcamentoCompra,Tabela.FieldByName('CODCLIENTE').AsInteger);
        VpfDProFornecedor := VpfDFornecedor.addProdutoAdicionado;
        CopiaDProdutoOrcamento(VpfDProOrcamento,VpfDProFornecedor);
      end;
      Tabela.next;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.AdicionaProdutosNaoAdicionadosFornecedor(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo);
var
  VpfLacoProdutos, VpfLacoFornecedor, VpfLacoProdutoFor : Integer;
  VpfDForOrcamento : TRBDOrcamentoCompraFornecedor;
  VpfdProduto, VpfDProNaoAdicionado : TRBDOrcamentoCompraProduto;
begin
  for VpfLacoFornecedor := 0 to VpaDOrcamentoCompra.Fornecedores.Count - 1 do
  begin
    VpfDForOrcamento := TRBDOrcamentoCompraFornecedor(VpaDOrcamentoCompra.Fornecedores.Items[VpfLacoFornecedor]);
    FreeTObjectsList(VpfDForOrcamento.ProdutosNaoAdicionados);
    for VpfLacoProdutos := 0 to VpaDOrcamentoCompra.Produtos.Count - 1 do
    begin
      VpfdProduto := TRBDOrcamentoCompraProduto(VpaDOrcamentoCompra.Produtos.Items[VpfLacoProdutos]);
      if not ExisteProdutoAdicionadoFornecedor(VpfdProduto,VpfDForOrcamento.ProdutosAdicionados) then
      begin
        VpfDProNaoAdicionado := VpfDForOrcamento.addProdutoNaoAdicionado;
        CopiaDProdutoOrcamento(VpfDProduto,VpfDProNaoAdicionado);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.AdicionaSolicitacoesOrcamentoCompra(VpadOrcamentoCompra: TRBDOrcamentoCompraCorpo;
  VpaProdutosPendentes: TList);
var
  VpfLacoProduto, VpfLacoSolicitacoes : Integer;
  VpfDProdutoPendente : TRBDProdutoPendenteCompra;
  VpfDSolicitacaoCompra : TRBDSolicitacaoCompraCorpo;
begin
  VpadOrcamentoCompra.SolicitacoesCompra.Free;
  VpadOrcamentoCompra.SolicitacoesCompra := TList.Create;
  for VpfLacoProduto := 0 to VpaProdutosPendentes.Count - 1 do
  begin
    VpfDProdutoPendente := TRBDProdutoPendenteCompra(VpaProdutosPendentes.Items[VpfLacoProduto]);
    for VpfLacoSolicitacoes := 0 to VpfDProdutoPendente.SolicitacoesCompra.Count - 1 do
    begin
      VpfDSolicitacaoCompra := TRBDSolicitacaoCompraCorpo(VpfDProdutoPendente.SolicitacoesCompra.Items[VpfLacoSolicitacoes]);
      if not ExisteSolicitacaoOrcamentoCompra(VpadOrcamentoCompra,VpfDSolicitacaoCompra) then
        VpadOrcamentoCompra.SolicitacoesCompra.Add(VpfDSolicitacaoCompra);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.AnexaArquivoProjetoEmailFornecedor(
  VpaDOrcamentoProduto: TRBDOrcamentoCompraCorpo);
var
  VpfLaco : Integer;
  VpfDProdutoOrc : TRBDOrcamentoCompraProduto;
  VpfAnexo : TIdAttachmentfile;
Begin
  exit;
  for VpfLaco := VpaDOrcamentoProduto.Produtos.Count - 1 downto 0 do
  begin
    VpfDProdutoOrc :=  TRBDOrcamentoCompraProduto(VpaDOrcamentoProduto.Produtos.Items[VpfLaco]);
    if VpfDProdutoOrc.DesArquivoProjeto <> '' then
    begin
      VpfAnexo := TIdAttachmentfile.Create(VprMensagem.MessageParts,VpfDProdutoOrc.DesArquivoProjeto);
      VpfAnexo.ContentType := 'image/jpg';
      VpfAnexo.ContentDisposition := 'inline';
      VpfAnexo.ExtraHeaders.Values['content-id'] := VpfDProdutoOrc.DesArquivoProjeto;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.ApagaProdutosComprados(VpaDOrcamento: TRBDOrcamentoCompraCorpo);
var
  VpfLaco : Integer;
  VpfDProdutoOrc : TRBDOrcamentoCompraProduto;
begin
  for VpfLaco := VpaDOrcamento.Produtos.Count - 1 downto 0 do
  begin
    VpfDProdutoOrc := TRBDOrcamentoCompraProduto(VpaDOrcamento.Produtos.Items[VpfLaco]);
    if VpfDProdutoOrc.IndComprado then
    begin
      VpfDProdutoOrc.Free;
      VpaDOrcamento.Produtos.Delete(VpfLaco);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrcamentoCompra.AtualizaMenorPreco(VpaDOrcamento: TRBDOrcamentoCompraCorpo;VpaUsarFrete,VpaUsarIPI, VpaUsarICMS : Boolean);
var
  VpfLacoFornecedor, VpfLacoProduto : Integer;
  VpfDFornecedor : TRBDOrcamentoCompraFornecedor;
  VpfDProOriginal,VpfDProFornecedor : TRBDOrcamentoCompraProduto;
  VpfMenorValor, VpfValLiquido : Double;
begin
  for VpfLacoFornecedor := 0 to VpaDOrcamento.Fornecedores.Count - 1 do
  begin
    VpfDFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamento.Fornecedores.Items[VpfLacoFornecedor]);
    for VpfLacoProduto := 0 to VpfDFornecedor.ProdutosAdicionados.Count- 1 do
    begin
      VpfDProFornecedor := TRBDOrcamentoCompraProduto(VpfDFornecedor.ProdutosAdicionados.Items[VpfLacoProduto]);
      VpfDProFornecedor.IndMenorPreco := false;
    end;
  end;

  for VpfLacoProduto := 0 to VpaDOrcamento.Produtos.Count - 1 do
  begin
    VpfDProOriginal := TRBDOrcamentoCompraProduto(VpaDOrcamento.Produtos.Items[VpfLacoProduto]);
    VpfMenorValor := 99999999999;
    for VpfLacoFornecedor := 0 to VpaDOrcamento.Fornecedores.Count - 1 do
    begin
      VpfDFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamento.Fornecedores.Items[VpfLacoFornecedor]);
      VpfDProFornecedor := RProdutoOrcamentoFornecedor(VpfDFornecedor,VpfDProOriginal.SeqProduto,VpfDProOriginal.CodCor,VpfDProOriginal.LarChapa,VpfDProOriginal.ComChapa);
      if VpfDProFornecedor <> nil then
      begin
        if VpfDProFornecedor.ValUnitario > 0 then
        begin
          VpfValLiquido := VpfDProFornecedor.ValUnitario;
          if VpaUsarIPI  then
            VpfValLiquido :=  VpfValLiquido + (VpfValLiquido *(VpfDProFornecedor.PerIPI /100));
          if VpaUsarICMS then
            VpfValLiquido := VpfValLiquido -  (VpfValLiquido *(VpfDProFornecedor.PerICMS /100));
          if VpfValLiquido < VpfMenorValor then
            VpfMenorValor := VpfValLiquido;
        end;
      end;
    end;
    for VpfLacoFornecedor := 0 to VpaDOrcamento.Fornecedores.Count - 1 do
    begin
      VpfDFornecedor := TRBDOrcamentoCompraFornecedor(VpaDOrcamento.Fornecedores.Items[VpfLacoFornecedor]);
      VpfDProFornecedor := RProdutoOrcamentoFornecedor(VpfDFornecedor,VpfDProOriginal.SeqProduto,VpfDProOriginal.CodCor,VpfDProOriginal.LarChapa,VpfDProOriginal.ComChapa);
      if VpfDProFornecedor <> nil then
      begin
        VpfValLiquido := VpfDProFornecedor.ValUnitario;
        if VpaUsarIPI  then
          VpfValLiquido :=  VpfValLiquido + (VpfValLiquido *(VpfDProFornecedor.PerIPI /100));
        if VpaUsarICMS then
          VpfValLiquido := VpfValLiquido -  (VpfValLiquido *(VpfDProFornecedor.PerICMS /100));
        if VpfValLiquido = VpfMenorValor then
          VpfDProFornecedor.IndMenorPreco := true;
      end;
    end;

  end;


end;

end.
