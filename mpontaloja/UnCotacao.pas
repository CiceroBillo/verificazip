unit UnCotacao;
{Verificado
-.edit;
-post
}
{ autor: rafael budag
  data : 05/04/2000
 funcao: unidade que faz as acoes da cotacao}

interface
uses classes, DBTables, Db, dbClient,SysUtils, ConvUnidade, UnDados, UnContasAReceber, UnProdutos, UnDadosCR, UnDadosProduto,
     Parcela, UnContasAPagar, UnSistema, UnImpressaoBoleto, Registry, IdMessage, IdSMTP, UnVendedor, windows,comctrls, variants,
     IdAttachmentfile, idText, SQLExpr, tabela, UnArgox, UnVersoes;

type TCalculosCotacao = class
  private
  public
end;

// classe com as localizacoes das funcoes
Type TLocalizaCotacao = class(TCalculosCotacao)
  private
  public
    procedure LocalizaMovOrcamento(VpaTabela : TDataSet;VpaCodFilial, VpaLanOrcamento : String);
    function ExisteProdutoOrcamento(VpaMovOrcamento : TDataSet;VpaCodFilial,VpaLanOrcamento,VpaSeqProduto : Integer):Boolean;
    procedure LocalizaCadOrcamento(VpaTabela : TDataSet;VpaCodfilial,VpaLanOrcamento : String);
    procedure LocalizaMovServicoOrcamento(VpaTabela : TDataSet;VpaCodFilial,VpaLanOrcamento : String);
    procedure LocalizaCliente(VpaTabela : TDataSet;VpaCodCliente : String);
    procedure LocalizaEntradaMetrosDiario(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime);
end;

// classe com as funcoes da cotacao
type TFuncoesCotacao = class(TLocalizaCotacao)
  private
    Aux,
    Aux1,
    Kit,
    ProdutosNota : TSQLQuery;
    Orcamento,
    CotCadastro,
    CotCadastro2  : TSQL;
    VprBaseDados : TSQLConnection;
    IndiceUnidade : TConvUnidade;
    ValidaUnidade : TValidaUnidade;
    CriaParcelas : TCriaParcelasReceber;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    FunVendedor : TRBFuncoesVendedor;
    function RProximoLanOrcamento(VpaCodFilial : Integer) : Integer;
    function RProximoSeqParcialOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
    function RProximoSeqEstagioOrcamento(VpaCodfilial,VpaLanOrcamento : integer) : Integer;
    function RProximoSeqRomaneioDisponivel(VpaCodFilial : Integer) : integer;
    function RProximoOrcamentoRoteiroDisponivel: integer;
    function REstagioAtualCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
    function RNomeEstagioAtualCotacao(VpaCodEstagio : Integer):String;
    function RQtdBrindeProdutoCliente(VpaCodCliente,VpaSeqProduto : Integer;VpaUM : String) : Double;
    function REmailTransportadora(VpaCodTransportadora : Integer):string;
    function RTextoAcrescimoDesconto(VpaDCotacao : TRBDORcamento):String;
    function RValorAcrescimodesconto(VpaDCotacao : TRBDORcamento):String;
    procedure CarDComposeProduto(VpaDCotacao : trbdorcamento;VpaDProdutoOrc : TRBDOrcProduto);
    procedure CarDOrcamentoProduto(VpaDCotacao : TRBDOrcamento);
    procedure CarDOrcamentoServico(VpaDCotacao : TRBDOrcamento);
    procedure CarDTipoOrcamento(VpaDCotacao : TRBDOrcamento);
    procedure CarDRomaneioOrcamentoProdutos(VpaDRomaneio : TRBDRomaneioOrcamento);
    procedure CarFlaSituacao(VpaDCotacao : TRBDOrcamento);
    procedure CarFlaPendente(VpaDCotacao : TrBDOrcamento);
    procedure CarParcelasContasAReceber(VpaDOrcamento : TRBDOrcamento);
    procedure ExcluiMovOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
    procedure VerificaPrecoCliente(VpaDCotacao : TRBDOrcamento;VpaDProCotacao : TRBDOrcProduto);
    function ExtornaNotaOrcamento(VpaCodFilial,VpaLanOrcamento : Integer):String;
    function EstornaEstoqueOrcamento(VpaDCotacao : TRBDOrcamento) : String;
    function ExtornaBrindeCliente(VpaDCotacao : TRBDOrcamento) : String;
    function EstagioFinal(VpaCodEstagio : Integer) : Boolean;
    function BaixaProdutosDevolvidos(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;Var VpaValoraDevolver : Double): String;
    function BaixaProdutosOrcamentoQueVirouVenda(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento) : string;
    function GravaDBaixaParcialOrcamentoCorpo(VpaDCotacao : TRBDorcamento) : TRBDOrcamentoParcial;
    function GravaDBaixaParcialOrcamentoItem(VpaDBaixaCorpo : TRBDOrcamentoParcial;VpaDBaixaItem : TRBDProdutoOrcParcial):String;
    function GravaDEmail(VpaDCotacao: TRBDOrcamento; VpaDesEmail : String): String;
    function GravaDRomaneioCotacaoItem(VpaDRomaneioCotacao : TRBDRomaneioOrcamento):string;
    procedure CopiaDCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento;VpaCopiarItems : Boolean);
    procedure CopiaDProdutoCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento);overload;
    function GeraFinanceiroEstagio(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer):String;
    procedure DuplicaDadosItemOrcamento(VpaDItemOrigem,VpaDItemDestino : TRBDOrcProduto);
    procedure MontaEmailCotacaoTexto(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente);
    procedure MontaCabecalhoEmail(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaEnviarImagem : Boolean);
    procedure MontaEmailCotacao(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaDRepresentada : TRBDRepresentada; VpaEnviarImagem : Boolean);
    procedure MontaEmailCotacaoEstagio(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaDRepresentada : TRBDRepresentada; VpaEnviarImagem : Boolean);
    procedure MontaEmailCotacaoEstagioModificado(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaDRepresentada : TRBDRepresentada; VpaEnviarImagem : Boolean);
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP) : string;
    function VerificaSeparacaoTotal(VpaDCotacao : TRBDOrcamento;Var VpaIndTotal : Boolean):string;
    function BaixaEstoqueCartuchoAssociado(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
    function BaixaProdutosASeparar(VpaDCotacao, VpaDCotacaoNova : TRBDOrcamento):String;
    function BaixaEstoqueSaldoAlteracao(VpaDSaldo : TRBDOrcamento) :string;
    function RSeqEmailDisponivel(VpaCodFilial, VpaLanOrcamento : Integer ): Integer;
    function RDescontoAcrescimoComissao(VpaDProdutocotacao : TRBDOrcProduto;VpaPerComissao : Double):Double;
    function RValComissao(VpaDCotacao : TRBDOrcamento;VpaTipComissao : Integer;VpaPerComissao, VpaPerComissaoPreposto : Double;VpaDCliente : TRBDCliente):Double;
    function RProdutoPendente(VpaProdutos : TList;VpaSeqProduto : Integer) : TRBDProdutoPendenteMetalVidros;
    procedure CarDProdutoPendenteMetalVidros(VpaProdutos : TList;VpaDatInicio, VpaDatFim : TDateTime);
    procedure OrdenaProdutosPendentes(VpaProdutos : TList);
    procedure SalvaArquivoProdutoPendente(VpaProduto : TList);
    procedure SubtraiQtdAlteradaCotacaoInicial(VpaDSaldoCotacao, VpaDCotacaoAlterada : TRBDOrcamento);
    function AprovaAmostraOrcamento(VpaSeqProduto : Integer) : string;
    function CancelaSaldoCotacaoRomaneioBloqueado(VpaDRomaneio : TRBDRomaneioOrcamento) : string;
    function EstornaSaldoCanceladoCotacaoRomaneioBloqueado(VpaDRomaneio : TRBDRomaneioOrcamento) : string;
    function RSeqRomaneioEmAberto(VpaCodFilial, VpaCodCliente : Integer) : Integer;
    function AgrupaRomaneioOrcamento(VpaCodFilial,VpaSeqRomaneio : Integer; VpaDRomaneioAgrupado : TRBDRomaneioOrcamento):string;
    function RMandaEmailEstagio(VpaDCodEstagio: integer): boolean;
    function DiminuiQtdProdutoCotacao(VpaCodFilial, VpaLanOrcamento, VpaSeqParcial : Integer):string;
  public
    constructor Cria(VpaBaseDados : TSQLConnection);
    destructor Destroy;override;
    procedure RetornaDadosTransportadora(CodTrans: integer; var Nome, CNPJ_CPF,
      Endereco, Cidade, UF, IE: string);
    function RCodCliente(VpaCodFilial, VpaLanOrcamento : Integer):Integer;
    procedure InseriNovoOrcamento(VpaMovOrcamento : TDataSet;VpaCodFilial, VpaLanOrcamento,VpaSeqProduto : Integer;
                                               VpaValorVenda : Double; VpaCodUnidade : String);
    function AdicionaFinanceiroArqRemessa(VpaDCotacao : TRBDOrcamento):String;
    procedure AdicionaDescontoCotacaoDePara(VpaDCotacaoDE,VpaDCotacaoPara : TRBDOrcamento);
    procedure AdicionaPaginasLogAlteracao(VpaDCotacao : TRBDOrcamento;VpaPaginas : TpageControl);
    procedure CarDOrcamento(VpaDOrcamento : TRBDOrcamento;VpaCodFilial : Integer = 0;VpaLanOrcamento : Integer = 0);
    procedure CarDRomaneioOrcamento(VpaDRomaneio : TRBDRomaneioOrcamento;VpaCodFilial, VpaSeqRomaneio : Integer);
    procedure CarDParcelaOrcamento(VpaDOrcamento : TRBDOrcamento);
    procedure CarDtipoCotacao(VpaDTipoCotacao : TRBDTipoCotacao;VpaCodTipoCotacao : Integer);
    procedure CarComposeCombinacao(VpaDProCotacao : TRBDOrcProduto);
    procedure CarPrecosProdutosRevenda(VpaDCotacao : TRBDOrcamento);
    procedure CarServicoExecutadonaObsdaCotacao(VpaDCotacao : TRBDOrcamento;VpaDChamado : TRBDChamado);
    procedure CarDRepresentada(VpaDRepresentada : TRBDRepresentada;VpaCodRepresentada : Integer);
    function CarRomaneioOrcamentoBaixaCotacao(VpaCodFilial, VpaCodRomaneio : Integer): TRBDOrcamento;
    function RProdutoCotacao(VpaDCotacao : TRBDOrcamento;VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer;VpaValUnitario : Double):TRBDOrcProduto;
    function RServicoCotacao(VpaDCotacao : TRBDOrcamento; VpaCodServico : Integer): TRBDOrcServico;
    function RSeqNotaFiscalCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
    function RTipoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
    function RNomeTipoOrcamento(VpaTipCotacao : Integer) : string;
    function RVendedorUltimaCotacao : Integer;
    function RNomTransportadora(VpaCodTransportadora : Integer) : string;
    function RNomVendedor(VpaCodVendedor : Integer):string;
    function RNomClassificacao(VpaCodClassificacao: string): string;
    function RPastaFTPVendedor(VpaCodVendedor : Integer) : string;
    function RNomFantasiaRepresentada(VpaCodRepresentada : Integer) : String;
    function REmailVencedor(VpaCodVendedor : Integer) : string;
    function RFoneVendedor(VpaCodVendedor : Integer) : string;
    function ROrdemProducao(VpaCodFilial,VpaLanOrcamento, VpaItemOrcamento : Integer) : Integer;
    function RValTotalCotacaoParcial(VpaDCotacao : TRBDOrcamento) : Double;
    function RQtdNumeroPedido(VpaCodFilial : Integer):integer;
    function RAliquotaICMSUF(VpaDesUF : String):Double;
    function RCotacao(VpaCotacoes : TList;VpaCodFilial, VpaLanOrcamento : Integer) :TRBDOrcamento;
    function RSeqOrcamentoRoteiroEntrega(VpaCodEntregador:integer):integer;
    function RRomaneioemAbertoCliente( VpaCodFilial, VpaCodCliente : Integer) : Integer;
    function RSeqRomaneioBloqueado(VpaCodFilial, VpaCodCliente : Integer) : Integer;
    function RPrecoProdutoTabelaCliente(VpaSeqProduto, VpaCodCliente, VpaCodCor, VpaCodTamanho: Integer): Double;
    procedure VerificaBrindeCliente(VpadCotacao : TRBDOrcamento;VpaDItemCotacao :TRBDOrcProduto);
    function RObservacaoCotacao(VpaNumCotacao, VpaCodFilial: Integer): String;
    function VerificaProdutoDuplicado(VpaDCotacao : TRBDOrcamento;VpaDItemCotacao : TRBDOrcProduto):Boolean;
    function ExisteProduto(VpaCodProduto : String;VpaCodTabelaPreco : Integer;VpaDProCotacao : TRBDOrcProduto;VpaDCotacao : TRBDOrcamento):Boolean;
    function ExisteProdutoTabPreco(VpaCodProduto : String;VpaCodTabelaPreco : Integer;VpaDProCotacao : TRBDOrcProduto;VpaDCotacao : TRBDOrcamento):Boolean;
    function ExisteServico(VpaCodServico : String;VpaDSerCotacao : TRBDOrcServico):Boolean;
    function Existecor(VpaCodCor :String;VpaDProCotacao : TRBDOrcProduto):Boolean;
    function ExisteTamanho(VpaCodTamanho : String;var VpaNomTamanho : string):Boolean;
    function ExisteEmbalagem(VpaCodEmbalagem :String;VpaDProCotacao : TRBDOrcProduto):Boolean;
    function ExisteBaixaParcial(VpaDCotacao : TRBDOrcamento) : Boolean;
    function ExisteCotacao(VpaCodFilial, VpaLanOrcamento : Integer) : boolean;
    function ExtornaOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) :String;
    procedure CancelaOrcamento(VpacodFilial,VpaLanOrcamento : Integer);
    function CancelaSaldoItemOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento : Integer):string;
    function EstornaCancelaSaldoItemOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento : Integer):string;
    function AprovaAmostra(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento : Integer):string;
    function ExtornaAprovacaoAmostra(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento : Integer):string;
    procedure cancelaFinanceiroNota(VpaCodigoFilial, VpaLanOrcamento : integer);
    procedure ReservaProduto(VpaSeqProduto, VpaUnidade : String; VpaCodfilial: Integer; VpaQtd : Double);
    procedure BaixaReservaProdutoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
    procedure BaixaReserva(VpaCodFilial, VpaSeqProduto : Integer; VpaUnidade : String; VpaQtd : Double);
    function BaixaProdutosEtiquetadosSeparados(VpaDCotacao : TRBDOrcamento):String;
    function BaixaProdutosParcialCotacao(VpaDCotacao : TRBDOrcamento):String;
    function RetornaValorTotalOrcamento(VpaMovOrcamento : TDataSet): Double;
    procedure BaixaEstoqueOrcamento(VpaDOrcamento : TRBDOrcamento);overload;
    procedure ExcluiOrcamento(VpaCodFilial,VpaLanOrcamento : Integer;VpaEstornarEstoque : Boolean = true);
    function ExcluiBaixaParcialCotacao(VpaCodFilial, VpaLanOrcamento, VpaSeqParcial : Integer) : string;
    function ExcluiFinanceiroOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqParcial : Integer;VpaFazerVerificacoes : boolean=true) : String;
    function ExcluiFinanceiroCotacoes(VpaCotacoes : TList):String;
    function GeraFinanceiro(VpaDOrcamento : TRBDOrcamento; VpaDCliente : TRBDCliente; VpaDContaReceber : TRBDContasCR; VpaFunContaAReceber : TFuncoesContasAReceber;var VpaResultado : String;VpaGravarRegistro, VpaSinalPagamento : Boolean;VpaMostrarParcela :Boolean=true):Boolean;
    function GeraFinanceiroParcial(VpaDOrcamento : TRBDOrcamento;VpaFunContaAReceber : TFuncoesContasAReceber;VpaSeqParcial : Integer;var VpaResultado : String):Boolean;
    function GeraEstoqueProdutos(VpaDOrcamento : TRBDOrcamento; FunProduto : TFuncoesProduto;VpaGravarCotacao : Boolean=true):String;
    function GeraContasaPagarDevolucaoCotacao(VpaDCotacao : TRBDOrcamento; VpaValor : Double):String;
    function GeraContasAReceberDevolucaoCotacao(VpaDOrcamento : TRBDOrcamento; VpaValor : Double):String;
    procedure SetaFinanceiroGerado(VpaDOrcamento : TRBDOrcamento);
    function SetaSinalPagamentoGerado(VpaDOrcamento : TRBDOrcamento):string;
    procedure SetaOPImpressa(VpaCotacoes : TList);
    procedure SetaOrcamentoImpresso1(VpaCodFilial,VpaLanOrcamento : Integer);
    function RSePedidoFoiImpresso(VpaCodFilial, VpaLanOrcamento: Integer): boolean;
    procedure SetaOrcamentoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
    procedure SetaOrcamentoNaoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
    procedure SetaDataOpGeradaProduto(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento, VpaSeqOrdemProducao : Integer);
    procedure AtualizaDCliente(VpaDCotacao :TRBDOrcamento;VpaDCliente : TRBDCliente);
    function GravaDCotacao(VpaDCotacao : TRBDOrcamento;VpaDCliente:TRBDCliente) : String;
    function GravaDRomaneioCotacao(VpaDRomaneio : TRBDRomaneioOrcamento) : string;
    function GravaDProdutoCotacao(VpaDCotacao : TRBDOrcamento):String;
    function GravaDServicoCotacao(VpaDCotacao : TRBDOrcamento):String;
    function GravaBaixaParcialCotacao(VpaDCotacao : TRBDOrcamento;Var VpaSeqParcial : Integer) : String;
    function GravaDCompose(VpaDCotacao : TRBDOrcamento) : string;
    function GravaVinculoCotacaoProposta(VpaDCotacao : TRBDOrcamento;VpaListaPropostas : TList):string;
    function GeraComplementoCotacao(VpaDCotacao : TRBDOrcamento;Var VpaLanOrcamentoRetorno : Integer) : string;
    function GravaLogEstagio(VpaCodFilial,VpaLanOrcamento,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String) :string;
    function GravaCartuchoCotacao(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
    function GravaRoteiroEntrega(VpaDCotacao: TRBDOrcamento): string;
    procedure GravaVendedorUltimaCotacao(VpaCodVendedor : Integer);
    procedure CalculaValorTotal(VpaDCotacao : TRBDOrcamento);
    procedure CalculaPesoLiquidoeBruto(VpaDCotacao : TRBDOrcamento);
    procedure CalculaValorTotalRomaneio(VpaDRomaneio : TRBDRomaneioOrcamento);
    procedure AlteraPrecoProdutosPorCliente(VpaDCotacao : TRBDOrcamento);
    function AlteraEstagioCotacao(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer;VpaDesMotivo : String):String;
    Procedure BaixaCotacaoRoteiroEntrega(VpaCodFilial, VpaLanOrcamento: integer);
    function AlteraEstagioCotacoes(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaCotacoes, VpaDesMotivo : String):String;overload;
    function AlteraEstagioCotacoes(VpaCotacoes : TList;VpaCodUsuario, VpaCodEstagio : Integer) : string;overload;
    procedure AlteraVendedor(VpaDCotacao : trbdorcamento);
    procedure AlteraPreposto(VpaDCotacao : trbdorcamento);
    procedure AlteraTipoCotacao(VpaDCotacao : TRBDOrcamento;VpaCodTipoCotacao : Integer);
    procedure AlteraTransportadora(VpaDCotacao : TRBDOrcamento;VpaCodTransportadora : Integer);
    function AlteraCotacaoParaPedido(VpaDCotacao : TRBDOrcamento):String;
    function BaixaAlteracaoCotacao(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : String;
    function BaixaNumero(VpaCodFilial,VpaLanOrcamento : Integer):boolean;
    procedure CarCotacoesParaBaixarRomaneio(VpaDRomaneio : TRBDRomaneioOrcamento;VpaCotacoes : TList);
    function RValTotalOrcamentoNoMovEstoque(VpaCodFilial,VpaLanOrcamento : Integer) : Double;
    function RValTotalOrcamento(VpaCodFilial, VpaLanOrcamento : Integer):Double;
    procedure ZeraQtdBaixada(VpaDOrcamento : trbdorcamento);
    function FaturarTodosProdutos(VpaDCotacao : TRBDOrcamento):Boolean;
    procedure ImprimirBoletos(VpaCodFilial, VpaLanOrcamento : Integer;VpaDCliente : TRBDCliente;VpaImpressora : String);
    function ExisteOpGerada(VpaCodFilial, VpaLanOrcamento : Integer;VpaAvisar : Boolean):Boolean;
    function EnviaEmailCotacaoTransportadora(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
    function EnviaEmailCliente(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
    function EnviaEmailClienteEstagio(VpaDCotacao: TRBDOrcamento;VpaDCliente: TRBDCliente): string;
    function VerificacoesMedicamentoControlado(VpaDCotacao : TRBDOrcamento;VpaDProCotacao : TRBDOrcProduto):boolean;
    function ExisteProdutoSemBaixar(VpaCotacoes : TList): Boolean;
    function ExisteRomaneioAdicionado(VpaCotacoes : TList;VpaCodFilial, VpaLanOrcamento : Integer):boolean;
    function AgrupaCotacoes(VpaCotacoes : TList;VpaIndCopia : Boolean) : TRBDOrcamento;
    function AgrupaTodasCotacoesComProdutosConferidos(VpaCodCliente : Integer) : string;
    function ExcluiCotacoesAgrupadas(VpaCotacoes : TList) : string;
    function ExcluiRomaneioOrcamento(VpaCodFilial,VpaSeqRomaneio : Integer):string;
    function TodosCartuchosAssociados(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):Boolean;
    procedure CopiaDCotacaoProposta(VpaPropostas : TList;  VpaDCotacao: TRBDOrcamento);
    procedure CopiaDProdutoCotacao(VpaDProCotacaoDe, VpaDProCotacaoPara : TRBDOrcProduto);overload;
    function DuplicaProduto(VpaDCotacao : TRBDOrcamento; VpaDProCotacao : TRBDOrcProduto): TRBDOrcProduto;
    procedure ExportaProdutosPendentes(VpaDatInicio, VpaDatFim : TDateTime);
    procedure AtualizaEntradaMetrosDiario(VpaDatInicio, VpaDatFim : TDatetime);
    procedure ImprimeEtiquetaSeparacaoPedido(VpaDCotacao : TRBDOrcamento);
    function ClienteItemRomaneioValido(VpaDRomaneio : TRBDRomaneioOrcamento;VpaDRomaneioItem : TRBDRomaneioOrcamentoItem):Boolean;
    function ProdutoRomaneioExistenoPedido(VpaDRomaneioItem : TRBDRomaneioOrcamentoItem):boolean;
    procedure ImprimeEtiquetaProdutoComCodigoBarra(VpaDCotacao: TRBDOrcamento);
    procedure ImprimeEtiquetaVolume(VpaDCotacao : TRBDOrcamento);
    function AsssociaCotacaoParcialRomaneioOrcamento(VpaCodFilial,VpaSeqRomaneio,VpaCodFilialCotacao,VpaLanOrcamento,VpaSeqParcial : Integer):string;
    function BloqueiaRomaneio(VpaCodFilial, VpaSeqRomaneio : Integer;VpaMotivo : String):string;
    function DesBloqueiaRomaneio(VpaCodFilial, VpaSeqRomaneio : Integer):string;
end;

var
  FunCotacao : TFuncoesCotacao;

implementation

uses FunSql, Constantes, FunString,FunObjeto, UnNotaFiscal, ConstMsg, unClientes, FunData,
     FunNumeros, dmRave, FunArquivos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos da classe localiza
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************* localiza o orcamento *******************************}
procedure TLocalizaCotacao.LocalizaMovOrcamento(VpaTabela : TDataSet;VpaCodFilial, VpaLanOrcamento : String);
begin
  AdicionaSQLAbreTabela( VpaTabela,'Select * from MovOrcamentos '+
                         ' Where I_emp_fil = ' + VpaCodFilial +
                         ' and I_Lan_Orc = ' + VpaLanOrcamento +
                         ' order by C_Cod_Pro');
end;

{*************** verifica se o produto ja existe no orcamento *****************}
function TLocalizaCotacao.ExisteProdutoOrcamento(VpaMovOrcamento : TDataSet;VpaCodFilial,VpaLanOrcamento,VpaSeqProduto : Integer):Boolean;
begin
  result := VpaMovOrcamento.Locate('I_Emp_fil;I_Lan_Orc;I_Seq_Pro',VarArrayOf([VpaCodFilial,VpaLanOrcamento,VpaSeqProduto]),[locaseinsensitive]);
end;

{************************* localiza o cadorcamento ****************************}
procedure TLocalizaCotacao.LocalizaCadOrcamento(VpaTabela : TDataSet;VpaCodFilial,VpaLanOrcamento : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CadOrcamentos'+
                                  ' Where I_Emp_Fil = ' + VpaCodfilial +
                                  ' and I_Lan_Orc = ' + VpaLanOrcamento);
end;

{******************* localiza o movservico orcamento **************************}
procedure TLocalizaCotacao.LocalizaMovServicoOrcamento(VpaTabela : TDataSet;VpaCodfilial,VpaLanOrcamento : String);
begin
  AdicionaSQLAbreTabela( VpaTabela,'Select * from MovServicoOrcamento '+
                         ' Where I_emp_fil = ' + VpaCodFilial +
                         ' and I_Lan_Orc = ' + VpaLanOrcamento +
                         ' order by I_Cod_Ser');
end;

{******************************************************************************}
procedure TLocalizaCotacao.LocalizaCliente(VpaTabela : TDataSet;VpaCodCliente : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CADCLIENTES '+
                                  'Where I_COD_CLI = '+VpaCodCliente);
end;

{******************************************************************************}
procedure TLocalizaCotacao.LocalizaEntradaMetrosDiario(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'SELECT  CAD.D_DAT_ORC, CAD.I_TIP_ORC, CAD.I_COD_CLI, '+
                    ' CAD.I_COD_VEN, CAD.I_VEN_PRE,  '+
                    ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.C_COD_PRO, MOV.N_VLR_TOT, '+
                    ' PRO.C_COD_CLA, PRO.C_NOM_PRO, PRO.I_CMP_PRO, PRO.I_COD_EMP '+
                    ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                    ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                    ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                    ' AND CAD.C_IND_CAN = ''N'''+
                    ' AND CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                    ' AND CAD.D_DAT_ORC <= '+SQLTextoDataAAAAMMMDD(VpaDatFim)+
                    'ORDER BY PRO.C_COD_CLA, CAD.I_COD_CLI, CAD.I_COD_VEN, CAD.I_VEN_PRE ');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos da classe funcoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************************** cria a classe **********************************}
constructor TFuncoesCotacao.Cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  VprBaseDados := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Aux1 := TSQLQuery.Create(nil);
  Aux1.SQLConnection := VpaBaseDados;
  Kit := TSQLQuery.Create(nil);
  Kit.SQLConnection := VpaBaseDados;
  ProdutosNota := TSQLQuery.Create(nil);
  ProdutosNota.SQLConnection := VpaBaseDados;
  IndiceUnidade :=  TConvUnidade.create(nil);
  IndiceUnidade.ADataBase := VpaBaseDados;
  Orcamento := TSQL.Create(nil);
  Orcamento.ASQLConnection := VpaBaseDados;
  CotCadastro := TSQL.Create(nil);
  CotCadastro.ASQLConnection := VpaBaseDados;
  CotCadastro2 := TSQL.Create(nil);
  CotCadastro2.ASQLConnection := VpaBaseDados;
  IndiceUnidade.AInfo.UniNomeTabela := 'MovIndiceConversao';
  IndiceUnidade.AInfo.UniCampoDE := 'C_Uni_Atu';
  IndiceUnidade.AInfo.UniCampoPARA := 'C_Uni_Cov';
  IndiceUnidade.AInfo.UniCampoIndice := 'N_Ind_Cov';
  IndiceUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  IndiceUnidade.AInfo.UnidadeUN := Varia.UnidadeUN;
  IndiceUnidade.AInfo.UnidadeKit := Varia.UnidadeKit;
  IndiceUnidade.AInfo.Unidadebarra := Varia.Unidadebarra;
  IndiceUnidade.AInfo.ProCampoIndice := 'I_Ind_Cov';
  IndiceUnidade.AInfo.ProCampoCodigo := 'I_Seq_Pro';
  IndiceUnidade.AInfo.ProCampoFilial := 'I_Cod_Emp';
  IndiceUnidade.AInfo.ProNomeTabela := 'CadProdutos';
  //cria a valida unidade;
  ValidaUnidade := TValidaUnidade.create(nil);
  ValidaUnidade.ADataBase := VpaBaseDados;
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.Ainfo.UnidadeUN := varia.unidadeUN;
  ValidaUnidade.Ainfo.UnidadeKit := varia.unidadeKit;
  ValidaUnidade.Ainfo.UnidadeBarra := varia.unidadeBarra;
  ValidaUnidade.AInfo.CampoIndice := 'N_IND_COV';
  ValidaUnidade.AInfo.CampoUnidadeDE := 'C_UNI_ATU';
  ValidaUnidade.AInfo.CampoUnidadePARA := 'C_UNI_COV';
  ValidaUnidade.AInfo.NomeTabelaIndice  := 'MOVINDICECONVERSAO';
  //criar parcelas
  CriaParcelas := TCriaParcelasReceber.create(nil);
  CriaParcelas.info.ConCampoCodigoCondicao := 'I_COD_PAG';
  CriaParcelas.info.ConCampoQdadeParcelas := 'I_QTD_PAR';
  CriaParcelas.info.ConIndiceReajuste := 'N_IND_REA';
  CriaParcelas.info.ConNomeTabelaCondicao := 'CADCONDICOESPAGTO';
  CriaParcelas.info.ConPercAteVencimento := 'N_PER_DES';
  CriaParcelas.info.MovConCampoCreDeb := 'C_CRE_DEB';
  CriaParcelas.info.MovConCampoDataFixa := 'D_DAT_FIX';
  CriaParcelas.info.MOvConCampoDiaFixo := 'I_DIA_FIX';
  CriaParcelas.info.MovConCampoNumeroDias := 'I_NUM_DIA';
  CriaParcelas.info.MovConCampoNumeroParcela := 'I_NRO_PAR';
  CriaParcelas.info.MovConCampoPercentualCon := 'N_PER_CON';
  CriaParcelas.info.MovConCampoPercPagamento := 'N_PER_PAG';
  CriaParcelas.info.MovConCaracterCrePer := 'C';
  CriaParcelas.info.MovConCaracterDebPer := 'D';
  CriaParcelas.info.MovConNomeTabela := 'MOVCONDICAOPAGTO';
  CriaParcelas.ADataBase := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);

  FunVendedor := TRBFuncoesVendedor.cria(VpaBaseDados);
end;

{******************************************************************************}
function TFuncoesCotacao.DesBloqueiaRomaneio(VpaCodFilial,VpaSeqRomaneio: Integer): string;
var
  VpfDRomaneio : TRBDRomaneioOrcamento;
  VpfTransacao : TTransactionDesc;
  VpfSeqRomaneioEmAberto : Integer;
begin
  VpfDRomaneio := TRBDRomaneioOrcamento.cria;
  CarDRomaneioOrcamento(VpfDRomaneio,VpaCodFilial,VpaSeqRomaneio);
  VpfSeqRomaneioEmAberto := RSeqRomaneioEmAberto(VpaCodFilial,VpfDRomaneio.CodCliente);

  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  VprBaseDados.StartTransaction(VpfTransacao);


  AdicionaSQLAbreTabela(CotCadastro,'Select * from ROMANEIOORCAMENTO ' +
                                    ' WHERE CODFILIAL = ' + IntToStr(VpaCodFilial)+
                                    ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio));
  CotCadastro.Edit;
  CotCadastro.FieldByName('INDBLOQUEADO').AsString := 'N';
  CotCadastro.FieldByName('DESMOTIVOBLOQUEIO').Clear;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.Close;
  if result = '' then
  begin
    result :=  EstornaSaldoCanceladoCotacaoRomaneioBloqueado(VpfDRomaneio);
    if result = '' then
    begin
      if VpfSeqRomaneioEmAberto <> 0 then
      begin
        result := AgrupaRomaneioOrcamento(VpaCodFilial,VpfSeqRomaneioEmAberto,VpfDRomaneio);
      end;
    end;
  end;
  if result = '' then
    VprBaseDados.Commit(VpfTransacao);
end;

{******************************************************************************}
destructor TFuncoesCotacao.Destroy;
begin
  Aux.free;
  Kit.free;
  Orcamento.free;
  ProdutosNota.free;
  IndiceUnidade.free;
  CotCadastro.free;
  CotCadastro2.free;
  ValidaUnidade.Free;
  CriaParcelas.free;
  VprMensagem.free;
  VprSMTP.free;
  FunVendedor.free;
  inherited destroy;
end;

{******************************************************************************}
function TFuncoesCotacao.DiminuiQtdProdutoCotacao(VpaCodFilial, VpaLanOrcamento,VpaSeqParcial: Integer): string;
var
  VpfLacoProduto : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDCotacaoProduto : TRBDOrcProduto;
  VpfQtdProduto : Double;
begin
  result := '';
  VpfDCotacao := TRBDOrcamento.cria;
  CarDOrcamento(VpfDCotacao,VpaCodFilial,VpaLanOrcamento);
  AdicionaSQLAbreTabela(Orcamento,'Select ITE.QTDPARCIAL, '+
                                      ' MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_VLR_PRO, MOV.C_COD_UNI, '+
                                      ' MOV.C_PRO_REF, PRO.C_COD_UNI UNIORIGINAL '+
                                      ' from ORCAMENTOPARCIALITEM ITE, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                                      ' Where ITE.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                      ' and ITE.LANORCAMENTO = '+ IntToStr(VpaLanOrcamento)+
                                      ' and ITE.SEQPARCIAL = '+IntToStr(VpaSeqParcial)+
                                      ' AND ITE.CODFILIAL = MOV.I_EMP_FIL '+
                                      ' AND ITE.LANORCAMENTO = MOV.I_LAN_ORC '+
                                      ' AND ITE.SEQMOVORCAMENTO = MOV.I_SEQ_MOV'+
                                      ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');
  While not Orcamento.eof do
  begin
    VpfQtdProduto := Orcamento.FieldByName('QTDPARCIAL').AsFloat;
    for VpfLacoProduto := VpfDCotacao.Produtos.Count - 1 downto 0 do
    begin
      VpfDCotacaoProduto := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
      if (VpfDCotacaoProduto.SeqProduto = Orcamento.FieldByName('I_SEQ_PRO').AsInteger) then
      begin
        if ((config.EstoquePorCor) and (VpfDCotacaoProduto.CodCor <> Orcamento.FieldByName('I_COD_COR').AsInteger)) or
           (VpfDCotacaoProduto.QtdBaixadoNota = 0) then
          continue;

        if (VpfDCotacaoProduto.QtdBaixadoNota - VpfQtdProduto) <= 0 then
        begin
          VpfQtdProduto := VpfQtdProduto - VpfDCotacaoProduto.QtdBaixadoNota;
          VpfDCotacaoProduto.QtdBaixadoNota := 0;
        end
        else
        begin
          VpfDCotacaoProduto.QtdBaixadoNota := VpfDCotacaoProduto.QtdBaixadoNota - VpfQtdProduto;
          VpfDCotacaoProduto.ValTotal := VpfDCotacaoProduto.QtdProduto * VpfDCotacaoProduto.ValUnitario;
          VpfQtdProduto := 0;
        end;
        if VpfQtdProduto <= 0 then
          break;
      end;
    end;
    if VpfQtdProduto <= 0 then
      break;

    Orcamento.Next;
  end;
  Orcamento.Close;
  result := GravaDCotacao(VpfDCotacao,nil);
  VpfDCotacao.Free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.RetornaDadosTransportadora(CodTrans: integer; var Nome,
CNPJ_CPF, Endereco, Cidade, UF, IE: string);
begin
  AdicionaSQLAbreTabela(Aux, ' select * from CADCLIENTES ' +
                             ' where I_COD_CLI = ' + IntToStr(CodTrans));

  Nome     := Aux.fieldbyname('C_NOM_CLI').AsString;
  CNPJ_CPF := Aux.fieldbyname('C_CGC_CLI').AsString;
  Endereco := Aux.fieldbyname('C_END_CLI').AsString + ' ' + Aux.fieldbyname('I_NUM_CLI').AsString;
  Cidade   := Aux.fieldbyname('C_CID_CLI').AsString;
  UF       := Aux.fieldbyname('C_EST_CLI').AsString;
  IE       := Aux.fieldbyname('C_INS_CLI').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RProximoLanOrcamento(VpaCodFilial : Integer) : Integer;
begin
  if (varia.TipoBancoDados = bdMatrizSemRepresentante) then
  begin
    AdicionaSQLAbreTabela(Aux,'Select MAX(I_LAN_ORC) ULTIMO from CADORCAMENTOS '+
                              ' where I_EMP_FIL = '+IntToStr(VpaCodFilial));
    result := Aux.FieldByName('ULTIMO').AsInteger + 1;
    Aux.close;
  end
  else
  begin
    repeat
      AdicionaSQLAbreTabela(Aux,'Select NUMPEDIDO FROM NUMEROPEDIDO '+
                                ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' order by NUMPEDIDO');
      result := Aux.FieldByName('NUMPEDIDO').AsInteger;
      if result = 0 then
        aviso('FINAL NUMERO PEDIDO!!!'#13'Não existem mais numeros de pedidos disponiveis, é necessário gerar mais numeros.');
      Aux.Close;
      ExecutaComandoSql(Aux,'Delete from NUMEROPEDIDO ' +
                            ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and NUMPEDIDO = '+IntToStr(result));
    until (not ExisteCotacao(VpaCodFilial,result));
  end;
end;


{******************************************************************************}
function TFuncoesCotacao.RProximoOrcamentoRoteiroDisponivel: integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQORCAMENTOROTEIRO) ULTIMO from ORCAMENTOROTEIROENTREGA ');
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RProximoSeqParcialOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQPARCIAL) ULTIMO from ORCAMENTOPARCIALCORPO '+
                            ' Where CODFILIAL = '+ IntTostr(VpaCodFilial)+
                            ' and LANORCAMENTO = '+ IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
end;

{******************************************************************************}
function TFuncoesCotacao.RProximoSeqRomaneioDisponivel(VpaCodFilial: Integer): integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQROMANEIO) ULTIMO FROM ROMANEIOORCAMENTO ' +
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RProximoSeqEstagioOrcamento(VpaCodfilial,VpaLanOrcamento : integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQESTAGIO) ULTIMO from ESTAGIOORCAMENTO '+
                            ' Where CODFILIAL = '+InttoStr(VpaCodfilial)+
                            ' and SEQORCAMENTO = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RValTotalCotacaoParcial(VpaDCotacao : TRBDOrcamento) : Double;
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
begin
  result := 0;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDItemCotacao.QtdABaixar <> 0 then
    begin
      result := result + (VpfdItemCotacao.qtdABaixar * VpfDItemCotacao.ValUnitario);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.REstagioAtualCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_EST from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_COD_EST').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RQtdBrindeProdutoCliente(VpaCodCliente,VpaSeqProduto : Integer;VpaUM : String) : Double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Aux,'Select QTDPRODUTO, DESUM from BRINDECLIENTE '+
                            ' Where CODCLIENTE = '+IntToStr(VpaCodCliente)+
                            ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto));
  if not Aux.Eof then
    result := FunProdutos.CalculaQdadePadrao(Aux.FieldByName('DESUM').AsString,VpaUM,Aux.FieldByName('QTDPRODUTO').AsFloat,IntToStr(VpaSeqproduto));
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RQtdNumeroPedido(VpaCodFilial: Integer): integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(*) QTD FROM NUMEROPEDIDO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RRomaneioemAbertoCliente( VpaCodFilial, VpaCodCliente: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select SEQROMANEIO '+
                              ' FROM ROMANEIOORCAMENTO ' +
                              ' Where CODFILIAL = ' + IntToStr(VpaCodFilial)+
                              ' AND CODCLIENTE = ' +IntToStr(VpaCodCliente)+
                              ' AND DATFIM IS NULL ' +
                              ' AND INDBLOQUEADO = ''N''');
  result := aux.FieldByName('SEQROMANEIO').AsInteger;
  aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.REmailTransportadora(VpaCodTransportadora : Integer):string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_END_ELE from CADCLIENTES'+
                            ' Where I_COD_CLI = '+IntToStr(VpaCodTransportadora));
  result := Aux.FieldByname('C_END_ELE').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RTextoAcrescimoDesconto(VpaDCotacao : TRBDOrcamento):String;
begin
  result := '';
  if (VpaDCotacao.PerDesconto > 0) or (VpaDCotacao.ValDesconto > 0) then
    result := 'Desconto'
  else
    if (VpaDCotacao.PerDesconto < 0) or (VpaDCotacao.PerDesconto < 0) then
      result := 'Acréscimo';
end;

{******************************************************************************}
function TFuncoesCotacao.RValorAcrescimodesconto(VpaDCotacao : TRBDORcamento):String;
begin
  result := '';
  if VpaDCotacao.PerDesconto > 0 then
    result := FormatFloat('0%',VpaDCotacao.PerDesconto)
  else
    if VpaDCotacao.PerDesconto < 0 then
      result := FormatFloat('0%',VpaDCotacao.PerDesconto*-1);
  if VpaDCotacao.ValDesconto > 0 then
    Result := FormatFloat(varia.MascaraValor,VpaDCotacao.ValDesconto)
  else
    if VpaDCotacao.ValDesconto > 0 then
      Result := FormatFloat(varia.MascaraValor,VpaDCotacao.ValDesconto*-1);

end;

{******************************************************************************}
function TFuncoesCotacao.VerificacoesMedicamentoControlado(VpaDCotacao : TRBDOrcamento;VpaDProCotacao : TRBDOrcProduto):boolean;
begin
  result := true;
  if VpaDProCotacao.IndMedicamentoControlado then
  begin
    if VpaDCotacao.CodCliente = 0 then
    begin
      aviso('CLIENTE NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o cliente.');
      result := false;
    end;
    if result then
    begin
      if VpaDProCotacao.DesRegistroMSM = '' then
      begin
        aviso('REGISTRO DO MSM NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher no cadastro do produto o registro do MSM.');
        result := false;
      end;
      if result then
      begin
        if VpaDProCotacao.CodPrincipioAtivo = 0 Then
        begin
          result := false;
          aviso('PRINCIPIO ATIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o principio ativo do medicamento.');
        end;
        if result then
        begin
          if VpaDCotacao.CodMedico = 0 then
          begin
            aviso('MÉDICO NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o médico.');
            result := false;
          end;
          if result then
          begin
            if VpaDCotacao.TipReceita <= 0 then
            begin
              aviso('TIPO RECEITA NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o tipo da receita.');
              result := false;
            end;
            if result then
            begin
              if VpaDCotacao.NumReceita = '' then
              begin
                aviso('NUMERO DA RECEITA NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o número da receita.');
                result := false;
              end;
              if result then
              begin
                if VpaDCotacao.DatReceita < montadata(1,1,1900) then
                begin
                  aviso('DATA DA RECEITA NÃO PREENCHIDA!!!'#13'Antes de vender um produto controlado é necessário preencher a data da receita.');
                  result := false;
                end;
                if result then
                begin
                  if VpaDCotacao.RGCliente = '' then
                  begin
                    aviso('RG DO CLIENTE NÃO PREENCHIDO!!!'#13'É necessario informar o RG do cliente.');
                    result := false;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.BaixaCotacaoRoteiroEntrega(VpaCodFilial,
  VpaLanOrcamento: integer);
begin
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ORCAMENTOROTEIROENTREGAITEM '+
                                    ' Where CODFILIALORCAMENTO = '+IntToStr(VpaCodFilial)+
                                    ' AND SEQORCAMENTO = '+IntToStr(VpaLanOrcamento)+
                                    ' AND DATFECHAMENTO IS NULL ');
  if not CotCadastro.Eof then
  begin
    CotCadastro.edit;
    CotCadastro.FieldByName('DATFECHAMENTO').AsDateTime := now;
    CotCadastro.post;
    CotCadastro.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteProdutoSemBaixar(VpaCotacoes : TList): Boolean;
var
  VpfLacoCotacao, VpfLacoProduto : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao : TRBDOrcProduto;
begin
  result := false;
  for VpfLacoCotacao := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoCotacao]);
    for VpfLacoProduto := 0 to VpfDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
      if VpfDProCotacao.QtdBaixadoNota < VpfDProCotacao.QtdProduto then
      begin
        aviso('EXISTEM PRODUTOS NÃO BAIXADOS!!!'#13'Não é possivel agrupar esse pedidos pois existe produtos não baixados');
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteProdutoTabPreco(VpaCodProduto: String;
  VpaCodTabelaPreco: Integer; VpaDProCotacao: TRBDOrcProduto;
  VpaDCotacao: TRBDOrcamento): Boolean;
begin
begin
  result := false;
  if VpaCodTabelaPreco = 0 then
    VpaCodTabelaPreco := Varia.TabelaPreco;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, PRO.N_RED_ICM,'+
                                  ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_KIT, PRO.C_IND_RET, PRO.C_IND_CRA, '+
                                  ' PRO.C_REG_MSM , PRO.I_PRI_ATI, PRO.N_PER_COM, PRO.I_IND_COV, PRO.I_MES_GAR, PRO.C_PRA_PRO, '+
                                  ' PRO.C_PAT_FOT, PRO.C_SUB_TRI, PRO.N_PER_ICM,  '+
                                  ' PRE.I_COD_CLI, (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                                  ' (Pre.N_Vlr_REV * Moe.N_Vlr_Dia) VlrReVENDA, ' +
                                  ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                                  ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, QTD.N_QTD_FIS, ' +
                                  ' CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, CLA.C_ALT_QTD '+
                                  ' from CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                                  ' MOVQDADEPRODUTO Qtd, CADCLASSIFICACAO CLA ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                                  ' and PRE.I_COD_TAB = '+IntToStr(VpaCodTabelaPreco)+
                                  ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                  ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(VpaDCotacao.CodEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and PRO.C_ATI_PRO = ''S'' '+
                                  ' and Pro.c_ven_avu = ''S'''+
                                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' and PRE.I_COD_CLI IN (0,'+IntToStr(VpaDCotacao.CodCliente)+')'+
                                  ' order by PRE.I_COD_CLI DESC',true);

    result := not Aux.Eof;
    if result then
    begin
      with VpaDProCotacao do
      begin
        UMOriginal := Aux.FieldByName('C_Cod_Uni').Asstring;
        UM := Aux.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := UM;
        ValUnitarioOriginal := Aux.FieldByName('VlrReal').AsFloat;
        QtdEstoque := Aux.FieldByName('QdadeReal').AsFloat;
        QtdMinima := Aux.FieldByName('N_QTD_Min').AsFloat;
        QtdPedido := Aux.FieldByName('N_QTD_Ped').AsFloat;
        QtdFiscal := Aux.FieldByName('N_QTD_FIS').AsFloat;
        CodProduto := Aux.FieldByName(Varia.CodigoProduto).Asstring;
        CodClassificacao := Aux.FieldByName('C_COD_CLA').Asstring;
        if (VpaDCotacao.IndRevenda or  VpaDCotacao.IndClienteRevenda) and (Aux.FieldByName('VlrRevenda').AsFloat <> 0) then
          ValUnitario := Aux.FieldByName('VlrRevenda').AsFloat
        else
          ValUnitario := Aux.FieldByName('VlrReal').AsFloat;
        //if Config.RetornarPrecoProdutoUltimaTabelaPreco then
        //  ValUnitario:= RPrecoProdutoTabelaCliente(VpaDProCotacao.SeqProduto, VpaDCotacao.CodCliente, VpaDProCotacao.CodCor, VpaDProCotacao.CodTamanho);

        ValRevenda := Aux.FieldByName('VlrRevenda').AsFloat;
        QtdProduto := 1;
        QtdBaixadoNota := 0;
        QtdBaixadoEstoque := 0;
        QtdCancelado := 0;
        QtdKit := Aux.FieldByName('I_IND_COV').AsInteger;
        SeqProduto := Aux.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Aux.FieldByName('C_NOM_PRO').AsString;
        PesLiquido := Aux.FieldByName('N_PES_LIQ').AsFloat;
        PesBruto := Aux.FieldByName('N_PES_BRU').AsFloat;
        PerDesconto := Aux.FieldByName('N_PER_KIT').AsFloat;
        PerComissao := Aux.FieldByName('N_PER_COM').AsFloat;
        PerComissaoClassificacao := Aux.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
        PerICMS:= Aux.FieldByName('N_PER_ICM').AsFloat;
        RedICMS := Aux.FieldByName('N_RED_ICM').AsFloat;
        IndFaturar := (QtdFiscal > (QtdPedido * 2));
        IndRetornavel  := (Aux.FieldByName('C_IND_RET').AsString = 'S');
        IndCracha  := (Aux.FieldByName('C_IND_CRA').AsString = 'S');
        IndPermiteAlterarQtdnaSeparacao  := (Aux.FieldByName('C_ALT_QTD').AsString = 'S');
        IndSubstituicaoTributaria  := (Aux.FieldByName('C_SUB_TRI').AsString = 'S');
        IndBrinde := false;
        DesRegistroMSM := Aux.FieldByName('C_REG_MSM').AsString;
        QtdMesesGarantia := Aux.FieldByName('I_MES_GAR').AsInteger;
        CodPrincipioAtivo := Aux.FieldByName('I_PRI_ATI').AsInteger;
        PathFoto := Aux.FieldByName('C_PAT_FOT').AsString;
        DesPrateleira := Aux.FieldByName('C_PRA_PRO').AsString;
        if config.Farmacia then
        begin
          IndMedicamentoControlado := FunProdutos.PrincipioAtivoControlado(CodPrincipioAtivo);
        end;
        while not Aux.Eof do
        begin
          if Aux.FieldByName('I_COD_CLI').AsInteger = 0 then
            if Config.RetornarPrecoProdutoUltimaTabelaPreco then
              ValUnitario:= RPrecoProdutoTabelaCliente(VpaDProCotacao.SeqProduto, VpaDCotacao.CodCliente, VpaDProCotacao.CodCor, VpaDProCotacao.CodTamanho)
            else
              ValTabelaPreco := Aux.FieldByName('VlrReal').AsFloat;
          Aux.Next;
        end;
      end;
    end;
    Aux.close;
  end;
end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteRomaneioAdicionado(VpaCotacoes: TList;VpaCodFilial, VpaLanOrcamento: Integer): boolean;
var
  VpfLaco : integer;
  VpfDCotacao : TRBDOrcamento;
begin
  result := false;
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento( VpaCotacoes.Items[vpfLaco]);
    if (VpaCodFilial = VpfDCotacao.CodEmpFil) and
       (VpaLanOrcamento = VpfDCotacao.LanOrcamento) then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RSeqRomaneioBloqueado(VpaCodFilial, VpaCodCliente: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select SEQROMANEIO FROM ROMANEIOORCAMENTO ' +
                            ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                            ' and CODCLIENTE = ' +IntToStr(VpaCodCliente) +
                            ' and DATFIM IS NULL ' +
                            ' AND INDBLOQUEADO = ''S''');
  result := Aux.FieldByName('SEQROMANEIO').AsInteger;
  aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RSeqRomaneioEmAberto(VpaCodFilial,VpaCodCliente: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select SEQROMANEIO FROM ROMANEIOORCAMENTO ' +
                            ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                            ' and CODCLIENTE = ' +IntToStr(VpaCodCliente) +
                            ' and DATFIM IS NULL ' +
                            ' AND INDBLOQUEADO = ''N''');
  result := Aux.FieldByName('SEQROMANEIO').AsInteger;
  aux.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDComposeProduto(VpaDCotacao : trbdorcamento;VpaDProdutoOrc : TRBDOrcProduto);
var
  VpfDCompose : TRBDOrcCompose;
begin
  AdicionaSQLAbreTabela(Kit,'Select COM.SEQCOMPOSE, COM.CORREFERENCIA, COM.SEQPRODUTO, COM.CODCOR, '+
                            ' PRO.C_NOM_PRO, PRO.C_COD_PRO, '+
                            ' COR.NOM_COR '+
                            ' from ORCAMENTOITEMCOMPOSE COM, CADPRODUTOS PRO, COR '+
                            ' Where COM.CODFILIAL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                            ' and COM.LANORCAMENTO = '+IntToStr(VpaDCotacao.LanOrcamento)+
                            ' and COM.SEQMOVIMENTO = '+IntToStr(VpaDProdutoOrc.SeqMovimento)+
                            ' and COM.SEQPRODUTO = PRO.I_SEQ_PRO '+
                            ' AND COM.CODCOR = COR.COD_COR '+
                            ' ORDER BY COM.CORREFERENCIA');
  While not kit.eof do
  begin
    VpfDCompose := VpaDProdutoOrc.AddCompose;
    VpfDCompose.SeqCompose := Kit.FieldByname('SEQCOMPOSE').AsInteger;
    VpfDCompose.CorRefencia := Kit.FieldByname('CORREFERENCIA').AsInteger;
    VpfDCompose.SeqProduto := Kit.FieldByname('SEQPRODUTO').AsInteger;
    VpfDCompose.CodCor := Kit.FieldByname('CODCOR').AsInteger;
    VpfDCompose.CodProduto := Kit.FieldByname('C_COD_PRO').AsString;
    VpfDCompose.NomProduto := Kit.FieldByname('C_NOM_PRO').AsString;
    VpfDCompose.NomCor := Kit.FieldByname('NOM_COR').AsString;
    kit.next;
  end;
  kit.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDOrcamentoProduto(VpaDCotacao : TRBDOrcamento);
Var
  VpfDProCotacao :TRBDOrcProduto;
begin
  AdicionaSQLAbreTabela(Orcamento,'Select COT.I_SEQ_MOV, COT.I_SEQ_PRO, COT.C_COD_PRO, COT.N_VLR_PRO, '+
                                  ' COT.N_QTD_PRO, COT.N_VLR_TOT, COT.C_COD_UNI, '+
                                  ' COT.C_IMP_FOT, COT.C_OBS_ORC, COT.C_FLA_RES, '+
                                  ' COT.C_IMP_DES, COT.N_PER_DES, N_QTD_BAI, COT.N_QTD_CON, C_DES_COR, '+
                                  ' COT.I_SEQ_MOV, COT.I_COD_COR, COT.D_ULT_ALT, COT.C_PRO_REF,'+
                                  ' COT.I_COD_EMB, COT.C_DES_EMB,COT.N_QTD_DEV, COT.C_IND_FAT, '+
                                  ' COT.C_IND_BRI, COT.N_SAL_BRI, COT.C_NOM_PRO PRODUTOCOTACAO, '+
                                  ' COT.D_DAT_ORC, COT.N_ALT_PRO ALTURAPRODUTOGRADE, '+
                                  ' COT.C_ORD_COM, COT.I_COD_TAM, COT.D_DAT_GOP, COT.D_APR_AMO, '+
                                  ' COT.N_QTD_PEC, COT.N_COM_PRO, COT.N_BAI_EST, '+
                                  ' COT.I_SEQ_ORD, COT.N_CUS_TOT, '+
                                  ' PRO.C_NOM_PRO, PRO.N_PES_LIQ, PRO.N_PES_BRU, PRO.C_IND_RET, PRO.C_IND_CRA,  '+
                                  ' PRO.C_COD_UNI UNIORIGINAL, PRO.C_COD_CLA, PRO.N_PER_COM, I_IND_COV, PRO.I_MES_GAR, PRO.C_PRA_PRO,  '+
                                  ' PRO.C_SUB_TRI, PRO.N_PER_ICM, PRO.N_PER_MAX,  '+
                                  ' CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, CLA.C_ALT_QTD , CLA.C_IMP_ETI, CLA.N_PER_MAX DESCONTOMAXIMOCLASSIFICACAO, '+
                                  ' TAM.NOMTAMANHO, COT.N_QTD_CAN '+
                                  ' FROM MOVORCAMENTOS COT, CADPRODUTOS PRO, TAMANHO TAM, CADCLASSIFICACAO CLA '+
                                  ' Where COT.I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                                  ' AND  COT.I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                  ' AND PRO.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa)+
                                  ' AND PRO.I_SEQ_PRO = COT.I_SEQ_PRO' +
                                  ' AND '+SQLTextoRightJoin('COT.I_COD_TAM','TAM.CODTAMANHO')+
                                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' order by COT.I_SEQ_MOV');
  while not Orcamento.eof do
  begin
    VpfDProCotacao := VpaDCotacao.AddProduto;
    with VpfDProCotacao do
    begin
      SeqMovimento := Orcamento.FieldByName('I_SEQ_MOV').AsInteger;
      SeqProduto := Orcamento.FieldByName('I_SEQ_PRO').AsInteger;
      CodCor := Orcamento.FieldByName('I_COD_COR').AsInteger;
      CodTamanho := Orcamento.FieldByname('I_COD_TAM').AsInteger;
      SeqOrdemProducao := Orcamento.FieldByname('I_SEQ_ORD').AsInteger;
      NomTamanho := Orcamento.FieldByname('NOMTAMANHO').AsString;
      CodProduto := Orcamento.FieldByName('C_COD_PRO').AsString;
      CodClassificacao := Orcamento.FieldByName('C_COD_CLA').AsString;
      if (config.PermiteAlteraNomeProdutonaCotacao) and (Orcamento.FieldByName('PRODUTOCOTACAO').AsString <> '' )then
        NomProduto := Orcamento.FieldByName('PRODUTOCOTACAO').AsString
      else
        NomProduto := Orcamento.FieldByName('C_NOM_PRO').AsString;
      DesCor := Orcamento.FieldByName('C_DES_COR').AsString;
      CodEmbalagem := Orcamento.FieldByName('I_COD_EMB').AsInteger;
      DesEmbalagem := Orcamento.FieldByName('C_DES_EMB').AsString;
      DesOrdemCompra := Orcamento.FieldByName('C_ORD_COM').AsString;
      DesObservacao := Orcamento.FieldByName('C_OBS_ORC').AsString;
      DesPrateleira := Orcamento.FieldByName('C_PRA_PRO').AsString;
      UM := Orcamento.FieldByName('C_COD_UNI').AsString;
      UMAnterior := UM;
      UMOriginal := Orcamento.FieldByName('UNIORIGINAL').AsString;
      IndImpFoto := Orcamento.FieldByName('C_IMP_FOT').AsString;
      IndImpDescricao := Orcamento.FieldByName('C_IMP_DES').AsString;
      IndFaturar := Orcamento.FieldByName('C_IND_FAT').AsString = 'S';
      IndCracha := Orcamento.FieldByName('C_IND_CRA').AsString = 'S';
      IndPermiteAlterarQtdnaSeparacao := Orcamento.FieldByName('C_ALT_QTD').AsString = 'S';
      IndImprimirEtiquetaSeparacao := Orcamento.FieldByName('C_IMP_ETI').AsString = 'S';
      IndSubstituicaoTributaria := Orcamento.FieldByName('C_SUB_TRI').AsString = 'S';
      ValCustoUnitario := FunProdutos.RValorCusto(VpaDCotacao.CodEmpFil,VpfDProCotacao.SeqProduto,VpfDProCotacao.CodCor,VpfDProCotacao.CodTamanho);
      QtdEstoque := 0;
      QtdMinima := 0;
      QtdPedido := 0;
      QtdBaixadoNota := Orcamento.FieldByName('N_QTD_BAI').AsFloat;
      QtdBaixadoEstoque := Orcamento.FieldByName('N_BAI_EST').AsFloat;
      QtdConferidoSalvo := Orcamento.FieldByName('N_QTD_CON').AsFloat;
      QtdProduto := Orcamento.FieldByName('N_QTD_PRO').AsFloat;
      QtdCancelado := Orcamento.FieldByName('N_QTD_CAN').AsFloat;
      QtdKit := Orcamento.FieldByName('I_IND_COV').AsInteger;
      CmpProduto := Orcamento.FieldByName('N_COM_PRO').AsFloat;
      QtdPecas := Orcamento.FieldByName('N_QTD_PEC').AsFloat;
      AltProdutonaGrade := Orcamento.FieldByName('ALTURAPRODUTOGRADE').AsFloat;
      PerDesconto := Orcamento.FieldByName('N_PER_DES').AsFloat;
      PerComissao := Orcamento.FieldByName('N_PER_COM').AsFloat;
      PerComissaoClassificacao := Orcamento.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
      PerICMS:= Orcamento.FieldByName('N_PER_ICM').AsFloat;
      QtdDevolvido := Orcamento.FieldByName('N_QTD_DEV').AsFloat;
 {     QtdEstoque := Orcamento.FieldByName('QTDREAL').AsFloat;
      QtdMinima := Orcamento.FieldByName('N_QTD_MIN').AsFloat;
      QtdPedido := Orcamento.FieldByName('N_QTD_PED').AsFloat;}
      ValUnitario := Orcamento.FieldByName('N_VLR_PRO').AsFloat;
      ValTotal := Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      ValCustoTotal := Orcamento.FieldByName('N_CUS_TOT').AsFloat;
      DesRefClienteOriginal := Orcamento.FieldByName('C_PRO_REF').AsString;
      DesRefCliente := Orcamento.FieldByName('C_PRO_REF').AsString;
      PesLiquido := Orcamento.FieldByName('N_PES_LIQ').AsFloat;
      PesBruto := Orcamento.FieldByName('N_PES_BRU').AsFloat;
      UnidadeParentes.free;
      UnidadeParentes := ValidaUnidade.UnidadesParentes(UMOriginal) ;
      IndRetornavel := (Orcamento.FieldByName('C_IND_RET').AsString = 'S');
      IndBrinde := (Orcamento.FieldByName('C_IND_BRI').AsString = 'S');
      QtdSaldoBrinde := Orcamento.FieldByName('N_SAL_BRI').AsFloat;
      DatOpGerada := Orcamento.FieldByName('D_DAT_GOP').AsDateTime;
      DatAmostraAprovada := Orcamento.FieldByName('D_APR_AMO').AsDateTime;
      DatOrcamento := Orcamento.FieldByName('D_DAT_ORC').AsDateTime;
      QtdMesesGarantia := Orcamento.FieldByName('I_MES_GAR').AsInteger;
      if Orcamento.FieldByName('N_PER_MAX').AsFloat > 0 then
        PerDescontoMaximoPermitido := Orcamento.FieldByName('N_PER_MAX').AsFloat
      else
        if Orcamento.FieldByName('DESCONTOMAXIMOCLASSIFICACAO').AsFloat > 0 then
          PerDescontoMaximoPermitido := Orcamento.FieldByName('DESCONTOMAXIMOCLASSIFICACAO').AsFloat
        else
          PerDescontoMaximoPermitido := varia.DescontoMaximoNota;


      FunProdutos.CarValVendaeRevendaProduto(VpaDCotacao.CodTabelaPreco,VpfDProCotacao.SeqProduto,VpfDProCotacao.CodCor,VpfDProCotacao.CodTamanho,
                                             VpaDCotacao.CodCliente,VpfDProCotacao.ValUnitarioOriginal,VpfDProCotacao.ValRevenda,VpfDProCotacao.ValTabelaPreco,VpfDProCotacao.PerDescontoMaximoPermitido);

      //ExisteProdutoTabPreco(CodProduto,0, VpfDProCotacao,VpaDCotacao);
    end;
    CarDComposeProduto(VpaDCotacao,VpfDProCotacao);
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDOrcamentoServico(VpaDCotacao : TRBDOrcamento);
var
  VpfDSErCotacao : TRBDOrcServico;
begin
  AdicionaSQLAbreTabela(Orcamento,'Select MOV.I_COD_SER, MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.C_DES_ADI, '+
                                  ' MOV.N_VLR_TOT, '+
                                  ' CAD.C_NOM_SER, CAD.N_PER_ISS, CAD.I_COD_FIS, '+
                                  ' CLA.C_COD_CLA, CLA.N_PER_COM COMISSAOCLASSIFICACAO '+
                                  ' from MOVSERVICOORCAMENTO MOV, CADSERVICO CAD, CADCLASSIFICACAO CLA ' +
                                   ' WHERE CAD.I_COD_EMP = '+ IntToStr(varia.CodigoEmpresa)+
                                   ' AND CAD.I_COD_SER = MOV.I_COD_SER '+
                                   ' AND MOV.I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                                   ' AND MOV.I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                   ' and MOV.I_COD_SER = CAD.I_COD_SER ' +
                                   ' and CLA.I_COD_EMP = CAD.I_COD_EMP ' +
                                   ' AND CLA.C_COD_CLA = CAD.C_COD_CLA ' +
                                   ' AND CLA.C_TIP_CLA = CAD.C_TIP_CLA ');
  while not Orcamento.Eof do
  begin
    VpfDSErCotacao := VpaDCotacao.AddServico;
    with VpfDSErCotacao do
    begin
      CodServico := Orcamento.FieldByName('I_COD_SER').AsInteger;
      CodFiscal := Orcamento.FieldByName('I_COD_FIS').AsInteger;
      NomServico := Orcamento.FieldByName('C_NOM_SER').AsString;
      DesAdicional := Orcamento.FieldByName('C_DES_ADI').AsString;
      QtdServico := Orcamento.FieldByName('N_QTD_SER').AsFloat;
      ValUnitario := Orcamento.FieldByName('N_VLR_SER').AsFloat;
      ValTotal := Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      PerISSQN := Orcamento.FieldByName('N_PER_ISS').AsFloat;
      CodClassificacao := Orcamento.FieldByName('C_COD_CLA').AsString;
      PerComissaoClassificacao := Orcamento.FieldByName('COMISSAOCLASSIFICACAO').AsFloat;
    end;
    orcamento.Next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDTipoOrcamento(VpaDCotacao : TRBDOrcamento);
begin
  if VpaDCotacao.CodTipoOrcamento <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADTIPOORCAMENTO '+
                              ' Where I_COD_TIP = '+IntToStr(VpaDCotacao.CodTipoOrcamento));
    VpaDCotacao.CodPlanoContas := Aux.FieldByName('C_CLA_PLA').AsString;
    VpaDCotacao.CodOperacaoEstoque := Aux.FieldByName('I_COD_OPE').AsInteger;;
    Aux.close;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarFlaSituacao(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDProCotacao : TRBDOrcProduto;
  VpfQtdBaixado : Double;
begin
//10/11/2008 - colocado em comentario porque os pedidos da filial 13 edson estava deixando em aberto.
//  if not config.GerarFinanceiroCotacao then
//  begin
    VpaDCotacao.FlaSituacao := 'E';
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      VpfQtdBaixado := (VpfDProCotacao.QtdBaixadoNota + VpfDProCotacao.QtdCancelado);
      if (VpfDProCotacao.QtdProduto > VpfQtdBaixado) then
      begin
        VpaDCotacao.FlaSituacao := 'A';
        break;
      end;
    end;
    if VpaDCotacao.Produtos.Count = 0 then
    begin
      if VpaDCotacao.FinanceiroGerado or VpaDCotacao.IndNotaGerada then
        VpaDCotacao.FlaSituacao := 'E'
      else
        VpaDCotacao.FlaSituacao := 'A';
    end;

//  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarFlaPendente(VpaDCotacao : TrBDOrcamento);
var
  VpfLaco : Integer;
begin
  VpaDCotacao.IndPendente := false;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    if (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).IndRetornavel) and (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto > TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdDevolvido) then
    begin
      VpaDCotacao.IndPendente := true;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarParcelasContasAReceber(VpaDOrcamento : TRBDOrcamento);
VAR
  VpfValParcela : Double;
begin
  AdicionaSQLAbreTabela(Aux,'select MOV.I_NRO_PAR, MOV.D_DAT_VEN, MOV.N_VLR_PAR, MOV.N_VLR_PAG '+
                                  ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                  ' where CAD.I_EMP_FIL = '+IntToStr(VpaDOrcamento.CodEmpFil)+
                                  ' and CAD.I_LAN_ORC = '+IntToStr(VpaDOrcamento.LanOrcamento) +
                                  ' and CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' and CAD.I_LAN_REC = MOV.I_LAN_REC'+
                                  ' order by I_NRO_PAR');
  while not  Aux.eof do
  begin
    if Aux.FieldByName('N_VLR_PAG').AsFloat <> 0 then
      VpfValParcela := Aux.FieldByName('N_VLR_PAG').AsFloat
    else
      VpfValParcela := Aux.FieldByName('N_VLR_PAR').AsFloat;
    VpaDOrcamento.Parcelas.add('*  '+CentraStr(Aux.FieldByName('I_NRO_PAR').AsString,6) + ' - '+
                           CentraStr(FormatDateTime('DD/MM/YYYY',Aux.FieldByName('D_DAT_VEN').AsDateTime) ,10) + ' - ' +
                           AdicionaBrancoE(Formatfloat(Varia.MascaraMoeda,VpfValParcela),17));

    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ExcluiMovOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
begin
  if (VpaLanOrcamento <> 0) then
  begin
    BaixaReservaProdutoOrcamento(VpaCodFilial,VpaLanOrcamento);
    sistema.GravaLogExclusao('MOVSERVICOORCAMENTO','Select * from MOVSERVICOORCAMENTO '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from MovServicoOrcamento '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
    sistema.GravaLogExclusao('MOVORCAMENTOS','Select * from MOVORCAMENTOS '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from MovOrcamentos '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));

  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.VerificaPrecoCliente(VpaDCotacao : TRBDOrcamento;VpaDProCotacao : TRBDOrcProduto);
begin
  if not Config.SalvarPrecosProdutosTabelaCliente then
  begin
    if VpaDProCotacao.ValUnitarioOriginal <> FunProdutos.CalculaValorPadrao(VpaDProCotacao.UM,VpaDProCotacao.UMOriginal,VpaDProCotacao.ValUnitario,InttoStr(VpaDProCotacao.SeqProduto)) then
    begin
      AdicionaSQLAbreTabela(CotCadastro2,'Select * from MOVTABELAPRECO PRE '+
                                ' Where PRE.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa) +
                                ' and PRE.I_COD_TAB = '+IntToStr(Varia.TabelaPreco)+
                                ' and PRE.I_SEQ_PRO = ' + IntToStr(VpaDProCotacao.SeqProduto) +
                                ' and PRE.I_COD_CLI = '+ Inttostr(VpaDCotacao.CodCliente));
      if CotCadastro2.Eof then
      begin
        CotCadastro2.Insert;
        CotCadastro2.FieldByName('I_COD_EMP').AsInteger := Varia.CodigoEmpresa;
        CotCadastro2.FieldByName('I_COD_TAB').AsInteger := varia.TabelaPreco;
        CotCadastro2.FieldByName('I_SEQ_PRO').AsInteger := VpaDProCotacao.SeqProduto;
        CotCadastro2.FieldByName('I_COD_TAM').AsInteger := VpaDProCotacao.CodTamanho;
        CotCadastro2.FieldByName('I_COD_COR').AsInteger := VpaDProCotacao.CodCor;
        CotCadastro2.FieldByName('I_COD_CLI').AsInteger := VpaDCotacao.CodCliente;
        CotCadastro2.FieldByName('I_COD_MOE').AsInteger := VARIA.MoedaBase;
        CotCadastro2.FieldByName('C_CIF_MOE').AsString := CurrencyString;
      end
      else
        if not (VpaDCotacao.DatOrcamento < CotCadastro2.FieldByName('D_ULT_ALT').AsDateTime) then
        begin
          CotCadastro2.Edit;
          CotCadastro2.FieldByName('N_VLR_VEN').AsFloat := FunProdutos.CalculaValorPadrao(VpaDProCotacao.UMOriginal,VpaDProCotacao.UM,VpaDProCotacao.ValUnitario,InttoStr(VpaDProCotacao.SeqProduto));
          CotCadastro2.FieldByName('D_ULT_ALT').AsDateTime := date;
          CotCadastro2.FieldByName('N_VVE_ANT').AsFloat:= VpaDProCotacao.ValUnitarioOriginal;
          CotCadastro2.post;
        end;
    end;
  end
  else   //Salva na Tabela do cliente sempre
  begin
     AdicionaSQLAbreTabela(CotCadastro2,'Select * from MOVTABELAPRECO PRE '+
                                ' Where PRE.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa) +
                                ' and PRE.I_COD_TAB = '+IntToStr(Varia.TabelaPreco)+
                                ' and PRE.I_SEQ_PRO = ' + IntToStr(VpaDProCotacao.SeqProduto) +
                                ' and PRE.I_COD_CLI = '+ Inttostr(VpaDCotacao.CodCliente));
      if CotCadastro2.Eof then
      begin
        CotCadastro2.Insert;
        CotCadastro2.FieldByName('I_COD_EMP').AsInteger := Varia.CodigoEmpresa;
        CotCadastro2.FieldByName('I_COD_TAB').AsInteger := varia.TabelaPreco;
        CotCadastro2.FieldByName('I_SEQ_PRO').AsInteger := VpaDProCotacao.SeqProduto;
        CotCadastro2.FieldByName('I_COD_TAM').AsInteger := VpaDProCotacao.CodTamanho;
        CotCadastro2.FieldByName('I_COD_COR').AsInteger := VpaDProCotacao.CodCor;
        CotCadastro2.FieldByName('I_COD_CLI').AsInteger := VpaDCotacao.CodCliente;
        CotCadastro2.FieldByName('I_COD_MOE').AsInteger := VARIA.MoedaBase;
        CotCadastro2.FieldByName('C_CIF_MOE').AsString := CurrencyString;
      end
      else
        if VpaDProCotacao.ValUnitarioOriginal <> FunProdutos.CalculaValorPadrao(VpaDProCotacao.UM,VpaDProCotacao.UMOriginal,VpaDProCotacao.ValUnitario,InttoStr(VpaDProCotacao.SeqProduto)) then
        begin
          if not (VpaDCotacao.DatOrcamento < CotCadastro2.FieldByName('D_ULT_ALT').AsDateTime) then
          begin
            CotCadastro2.Edit;
            CotCadastro2.FieldByName('N_VLR_VEN').AsFloat := FunProdutos.CalculaValorPadrao(VpaDProCotacao.UMOriginal,VpaDProCotacao.UM,VpaDProCotacao.ValUnitario,InttoStr(VpaDProCotacao.SeqProduto));
            CotCadastro2.FieldByName('D_ULT_ALT').AsDateTime := date;
            CotCadastro2.FieldByName('N_VVE_ANT').AsFloat:= VpaDProCotacao.ValUnitarioOriginal;
            CotCadastro2.post;
          end;
        end;
  end;
    CotCadastro2.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExtornaNotaOrcamento(VpaCodFilial,VpaLanOrcamento : Integer):String;
var
  VpfDNota : TRBDNotaFiscal;
begin
  result := '';
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_NOT from MOVNOTAORCAMENTO '+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                            ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  While not Aux.eof do
  begin
    VpfDNota := TRBDNotaFiscal.cria;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota,VpaCodFilial,Aux.FieldByName('I_SEQ_NOT').AsInteger);

    result := FunNotaFiscal.CancelaNotaFiscal(VpfDNota,false,true);
    VpfDNota.Free;
    if result <> '' then
      exit;
    Aux.Next;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiFinanceiroOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqParcial : Integer;VpaFazerVerificacoes : boolean=true) : String;
Var
  VpfFiltroParcial : String;
begin
  result := '';
  if VpaSeqParcial <> 0 then
    VpfFiltroParcial := ' and CAD.I_SEQ_PAR = '+IntToStr(VpaSeqParcial)
  else
    VpfFiltroParcial := '';
  AdicionaSQLAbreTabela(Orcamento,'select CAD.I_LAN_REC '+
                                  ' from CADCONTASARECEBER CAD'+
                                  ' where CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = '+IntToStr(VpaLanOrcamento) +
                                  VpfFiltroParcial);
  if VpaFazerVerificacoes then
    result :=  FunContasAReceber.ContaAdicionadaRemessa(VpaCodFilial,Orcamento.FieldByName('I_LAN_REC').AsiNTEGER);
  if result = '' then
  begin
    While not Orcamento.Eof do
    begin
      result := FunContasAReceber.ExcluiConta(VpaCodFilial,Orcamento.FieldByName('I_LAN_REC').AsiNTEGER,false,true);
      if result <> '' then
      begin
        Orcamento.Close;
        exit;
      end;
      Orcamento.next;
    end;
  end;
  Orcamento.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiFinanceiroCotacoes(VpaCotacoes : TList):String;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    result := FunCotacao.ExcluiFinanceiroOrcamento(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento,0);
    if result <> ''then
      exit;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EstornaCancelaSaldoItemOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento: Integer): string;
var
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  CotCadastro.Edit;
  CotCadastro.FieldByname('N_QTD_CAN').clear;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
  if result = '' then
  begin
    //forcado gravar a cotaca para atualizar o c_fla_sit que controla a situacao do pedido se esta em aberto ou ja foi entregue;
    VpfDCotacao := TRBDOrcamento.cria;
    CarDOrcamento(VpfDCotacao,VpaCodFilial,VpaLanOrcamento);
    GravaDCotacao(VpfDCotacao,nil);
    VpfDCotacao.Free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EstornaEstoqueOrcamento(VpaDCotacao : TRBDOrcamento):String;
var
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  result := funprodutos.OperacoesEstornoValidas;
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacao.Produtos.Items[vpflaco]);
      if VpfDProdutoOrc.QtdBaixadoEstoque > 0 then
      begin
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,0,VpaDCotacao.CodEmpFil,VpfDProdutoOrc.SeqProduto);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDCotacao.CodEmpFil, varia.OperacaoEstoqueEstornoEntrada,0,
                                      VpaDCotacao.LanOrcamento,VpaDCotacao.LanOrcamento,varia.MoedaBase,VpfDProdutoOrc.CodCor,
                                      VpfDProdutoOrc.CodTamanho, date,VpfDProdutoOrc.QtdBaixadoEstoque,VpfDProdutoOrc.ValTotal,
                                      VpfDProdutoOrc.UM,
                                      VpfDProdutoOrc.DesRefCliente, false,VpfSeqEstoqueBarra);
        VpfDProdutoOrc.QtdBaixadoEstoque := 0;
        VpfDProduto.free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EstornaSaldoCanceladoCotacaoRomaneioBloqueado(VpaDRomaneio: TRBDRomaneioOrcamento): string;
var
  VpfDItemRomaneio : TRBDRomaneioOrcamentoItem;
  VpfLaco : Integer;
begin
  result := '';
  for VpfLaco := 0 to VpaDRomaneio.Produtos.Count -1 do
  begin
    VpfDItemRomaneio := TRBDRomaneioOrcamentoItem(VpaDRomaneio.Produtos.Items[VpfLaco]);
    AdicionaSQLAbreTabela(CotCadastro,'Select I_EMP_FIL, I_LAN_ORC, I_SEQ_MOV, N_QTD_CAN ' +
                                      ' from MOVORCAMENTOS ' +
                                      ' Where I_EMP_FIL = '+IntToStr(VpfDItemRomaneio.CodFilialOrcamento)+
                                      ' AND I_LAN_ORC = '+IntToStr(VpfDItemRomaneio.LanOrcamento)+
                                      ' AND I_SEQ_PRO = '+IntToStr(VpfDItemRomaneio.SeqProduto)+
                                      ' AND I_COD_COR = '+IntToStr(VpfDItemRomaneio.CodCor)+
                                      ' AND '+SQLTextoIsNull('I_COD_TAM','0')+' = '+IntToStr(VpfDItemRomaneio.CodTamanho));
    if  not CotCadastro.Eof then
    begin
      CotCadastro.Edit;
      if VpfDItemRomaneio.QtdProduto > CotCadastro.FieldByName('N_QTD_CAN').AsFloat then
        CotCadastro.FieldByName('N_QTD_CAN').clear
      else
        CotCadastro.FieldByName('N_QTD_CAN').AsFloat := CotCadastro.FieldByName('N_QTD_CAN').AsFloat - VpfDItemRomaneio.QtdProduto;
      CotCadastro.Post;
      if CotCadastro.AErronaGravacao then
      begin
        Result := CotCadastro.AMensagemErroGravacao;
        break;
      end;
    end;
    CotCadastro.Close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExtornaAprovacaoAmostra(VpaCodFilial, VpaLanOrcamento,VpaSeqMovimento: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  CotCadastro.Edit;
  CotCadastro.FieldByname('D_APR_AMO').clear;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExtornaBrindeCliente(VpaDCotacao : TRBDOrcamento) : String;
var
  VpfLaco : Integer;
  VpfDItem : TRBDOrcProduto;
begin
  result := '';
  for Vpflaco := 0 to VpaDCotacao.Produtos.Count -1 do
  begin
    VpfDItem := TRBDOrcProduto(vpadCotacao.Produtos.Items[Vpflaco]);
    if VpfDItem.IndBrinde then
    begin
      result := FunClientes.BaixaEstoqueBrinde(VpaDCotacao.CodCliente,VpfDItem.SeqProduto,VpfDItem.QtdProduto,VpfDItem.UM,false);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EstagioFinal(VpaCodEstagio : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from ESTAGIOPRODUCAO '+
                            ' Where CODEST = '+IntToStr(VpaCodEstagio));
  result := (Aux.FieldByName('INDFIN').AsString = 'S');
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosDevolvidos(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;Var VpaValoraDevolver : Double): String;
var
  VpfDCotacaoSaldo : TRBDOrcamento;
  VpfBaixouProduto : Boolean;
  VpfDProdutoOrcInicial, VpfDProdutoOrc : TRBDOrcProduto;
  VpfQtdInicial, VpfQtdAtual, VpfPerDesconto : Double;
begin
  result := FunProdutos.OperacoesEstornoValidas;
  VpaValoraDevolver := 0;
  if result = '' then
  begin
    VpfDCotacaoSaldo := TRBDOrcamento.cria;
    CopiaDCotacao(VpaDCotacaoInicial,VpfDCotacaoSaldo,true);
    VpfDCotacaoSaldo.LanOrcamento := VpaDCotacaoInicial.LanOrcamento;
    SubtraiQtdAlteradaCotacaoInicial(VpfDCotacaoSaldo,VpaDCotacao);
    result := BaixaEstoqueSaldoAlteracao(VpfDCotacaoSaldo);
    VpfDCotacaoSaldo.free;
    if result = '' then
      result := GravaDCotacao(VpaDCotacao,nil);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosOrcamentoQueVirouVenda(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento) : string;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfDProduto : TRBDProduto;
begin
  result := FunProdutos.OperacoesEstornoValidas;
  if result = '' then
  begin
    if (VpaDCotacaoInicial.CodOperacaoEstoque <> 0)  and (VpaDCotacao.CodOperacaoEstoque = 0) then
    begin
      for VpfLaco := 0 to VpaDCotacaoInicial.Produtos.Count - 1 do
      begin
        VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacaoInicial.Produtos.Items[VpfLaco]);
        if VpfDProdutoOrc.QtdBaixadoEstoque <> 0 then
        begin
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,0,VpaDCotacao.CodEmpFil,VpfDProdutoOrc.SeqProduto);
          FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDCotacaoInicial.CodEmpFil,Varia.OperacaoEstoqueEstornoEntrada,0,
                                              VpaDCotacaoInicial.LanOrcamento,VpaDCotacaoInicial.LanOrcamento,varia.MoedaBase,VpfDProdutoOrc.CodCor, VpfDProdutoOrc.CodTamanho,
                                              date,VpfDProdutoOrc.QtdBaixadoEstoque,VpfDProdutoOrc.ValTotal,
                                              VpfDProdutoOrc.UM,VpfDProdutoOrc.DesRefCliente, false,VpfSeqEstoqueBarra,false);
          VpfDProduto.free;
        end;
      end;
      for VpfLaco := 0 to VpaDCotacao.Produtos.Count -1 do
        TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdBaixadoEstoque := 0;
    end
    else
      if (VpaDCotacaoInicial.CodOperacaoEstoque = 0)  and (VpaDCotacao.CodOperacaoEstoque <> 0) then
      begin
        for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
        begin
          VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
          VpfDProdutoOrc.QtdBaixadoEstoque := VpfDProdutoOrc.QtdProduto;
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,0,VpaDCotacao.CodEmpFil,VpfDProdutoOrc.SeqProduto);
          FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDCotacao.CodEmpFil,Varia.OperacaoEstoqueEstornoSaida,0,
                                            VpaDCotacaoInicial.LanOrcamento,VpaDCotacaoInicial.LanOrcamento,varia.MoedaBase,VpfDProdutoOrc.CodCor,VpfDProdutoOrc.CodTamanho,
                                            date,VpfDProdutoOrc.QtdBaixadoEstoque,VpfDProdutoOrc.ValTotal,
                                            VpfDProdutoOrc.UM,VpfDProdutoOrc.DesRefCliente, false,VpfSeqEstoqueBarra,true);
          VpfDProduto.free;
        end;
      end;
    result := GravaDCotacao(VpaDCotacao,nil);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDBaixaParcialOrcamentoCorpo(VpaDCotacao : TRBDorcamento) : TRBDOrcamentoParcial;
begin
  result := TRBDOrcamentoParcial.cria;
  result.CodFilial := VpaDCotacao.CodEmpFil;
  result.LanOrcamento := VpaDCotacao.LanOrcamento;
  result.DatParcial := now;
  result.ValTotal := RValTotalCotacaoParcial(VpaDCotacao);
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ORCAMENTOPARCIALCORPO '+
                                    ' Where CODFILIAL = 0 AND LANORCAMENTO = 0 AND SEQPARCIAL = 0');
  CotCadastro.Insert;
  CotCadastro.FieldByName('CODFILIAL').AsInteger := Result.CodFilial;
  CotCadastro.FieldByName('LANORCAMENTO').AsInteger := Result.LanOrcamento;
  CotCadastro.FieldByName('DATPARCIAL').AsDateTime := Result.DatParcial;
  CotCadastro.FieldByName('CODUSUARIO').AsInteger := varia.CodigoUsuario;
  if VpaDCotacao.PerDesconto <> 0 then
    CotCadastro.FieldByname('PERDESCONTO').AsFloat := VpaDCotacao.PerDesconto;
  CotCadastro.FieldByName('VALTOTAL').AsFloat := Result.ValTotal;
  result.SeqParcial := RProximoSeqParcialOrcamento(result.CodFilial,result.Lanorcamento);
  CotCadastro.FieldByName('SEQPARCIAL').AsInteger := Result.SeqParcial;
  CotCadastro.FieldByName('QTDVOLUME').AsInteger := VpaDCotacao.QtdVolumesTransportadora;
  CotCadastro.FieldByName('PESLIQUIDO').AsFloat := VpaDCotacao.PesLiquido;

  CotCadastro.post;
  if CotCadastro.AErronaGravacao then
  begin
    result.free;
    result := nil;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDBaixaParcialOrcamentoItem(VpaDBaixaCorpo : TRBDOrcamentoParcial;VpaDBaixaItem : TRBDProdutoOrcParcial):String;
begin
  result := '';
  AdicionaSqlAbreTabela(CotCadastro2,'Select * from ORCAMENTOPARCIALITEM'+
                                     ' Where CODFILIAL = 0 AND LANORCAMENTO = 0 '+
                                     ' AND SEQPARCIAL = 0 AND SEQMOVORCAMENTO = 0');
  CotCadastro2.Insert;
  CotCadastro2.FieldByName('CODFILIAL').AsInteger := VpaDBaixaCorpo.Codfilial;
  CotCadastro2.FieldByName('LANORCAMENTO').AsInteger := VpaDBaixaCorpo.LanOrcamento;
  CotCadastro2.FieldByName('SEQPARCIAL').AsInteger := VpaDBaixaCorpo.SeqParcial;
  CotCadastro2.FieldByName('SEQMOVORCAMENTO').AsInteger := VpaDBaixaItem.SeqMovOrcamento;
  CotCadastro2.FieldByName('SEQPRODUTO').AsInteger := VpaDBaixaItem.SeqProduto;
  if VpaDBaixaItem.CodCor <> 0  then
    CotCadastro2.FieldByName('CODCOR').AsInteger := VpaDBaixaItem.CodCor;
  CotCadastro2.FieldByName('DESUM').AsString := VpaDBaixaItem.DesUM;
  CotCadastro2.FieldByName('QTDPARCIAL').AsFloat := VpaDBaixaItem.QtdParcial;
  CotCadastro2.FieldByName('QTDCONFERIDO').AsFloat := VpaDBaixaItem.QtdConferido;
  CotCadastro2.FieldByName('VALPRODUTO').AsFloat := VpaDBaixaItem.ValProduto;
  CotCadastro2.FieldByName('VALTOTAL').AsFloat := VpaDBaixaItem.ValTotal;
  cotcadastro2.post;
  result :=  CotCadastro2.AMensagemErroGravacao;
  CotCadastro2.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraFinanceiroEstagio(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer):String;
var
  VpfDCotacao : TRBDorcamento;
  VpfDCliente : TRBDCliente;
  VpfDContaReceber : TRBDContasCR;
begin
  result := '';
  VpfDContaReceber := TRBDContasCR.Cria;
  AdicionaSQLAbreTabela(aux,'Select * from ESTAGIOPRODUCAO '+
                            ' Where CODEST = '+IntToStr(VpaCodEstagio));
  if Aux.FieldByName('CODPLA').AsString <> '' then
  begin
    VpfDCotacao := TRBDOrcamento.cria;
    VpfDCotacao.CodEmpFil := VpaCodFilial;
    VpfDCotacao.LanOrcamento := VpaLanOrcamento;
    cardorcamento(VpfDCotacao);
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpfDCotacao.CodCliente;
    FunClientes.CarDCliente(VpfDCliente);
    if not GeraFinanceiro(VpfDCotacao,VpfDCliente, VpfDContaReceber,FunContasAReceber,result,true,false) then
      if result = '' then
        result := 'FINANCEIRO CANCELADO!!!'#13'Não foi possível alterar o estágio da cotação porque o financeiro foi cancelado.';
    VpfDCotacao.free;
  end;
  VpfDContaReceber.free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento;VpaCopiarItems : Boolean);
begin
    VpaDCotacaoPara.CodEmpFil := VpaDCotacaoDe.CodEmpFil;
    VpaDCotacaoPara.CodTipoOrcamento := VpaDCotacaoDe.CodTipoOrcamento;
    VpaDCotacaoPara.CodOperacaoEstoque := VpaDCotacaoDe.CodOperacaoEstoque;
    VpaDCotacaoPara.CodPlanoContas := VpaDCotacaoDe.CodPlanoContas;
    VpaDCotacaoPara.CodCliente := VpaDCotacaoDe.CodCliente;
    VpaDCotacaoPara.CodVendedor := VpaDCotacaoDe.CodVendedor;
    VpaDCotacaoPara.CodPreposto := VpaDCotacaoDe.CodPreposto;
    VpaDCotacaoPara.CodCondicaoPagamento := VpaDCotacaoDe.CodCondicaoPagamento;
    VpaDCotacaoPara.CodFormaPaqamento := VpaDCotacaoDe.CodFormaPaqamento;
    VpaDCotacaoPara.CodEstagio := varia.EstagioOrdemProducao;
    VpaDCotacaoPara.CodUsuario := varia.CodigoUsuario;
    VpaDCotacaoPara.TipFrete := VpaDCotacaoDe.TipFrete;
    VpaDCotacaoPara.TipGrafica := VpaDCotacaoDe.TipGrafica;
    VpaDCotacaoPara.CodTecnico := VpaDCotacaoDe.CodTecnico;
    VpaDCotacaoPara.CodTabelaPreco := VpaDCotacaoDe.CodTabelaPreco;
    VpaDCotacaoPara.FlaSituacao := 'A';
    VpaDCotacaoPara.NomContato := VpaDCotacaoDe.NomContato;
    VpaDCotacaoPara.NomSolicitante := VpaDCotacaoDe.NomSolicitante;
    VpaDCotacaoPara.PerComissao := VpaDCotacaoDe.PerComissao;
    VpaDCotacaoPara.PerComissaoPreposto := VpaDCotacaoDe.PerComissaoPreposto;
    VpaDCotacaoPara.CodTransportadora := VpaDCotacaoDe.CodTransportadora;
    VpaDCotacaoPara.PlaVeiculo := VpaDCotacaoDe.PlaVeiculo;
    VpaDCotacaoPara.UFVeiculo := VpaDCotacaoDe.UFVeiculo;
    VpaDCotacaoPara.DatOrcamento := date;
    VpaDCotacaoPara.HorOrcamento := now;
    VpaDCotacaoPara.datPrevista := date;
    VpaDCotacaoPara.PerDesconto := VpaDCotacaoDe.PerDesconto;
    if VpaCopiarItems then
      CopiaDProdutoCotacao(VpaDCotacaoDe,VpaDCotacaoPara);
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDProdutoCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento);
var
  VpfDProdutoDe, VpfDProdutoPara : TRBDOrcProduto;
  VpfLaco : Integer;
begin
  FreeTObjectsList(VpaDCotacaoPara.Produtos);
  for VpfLaco := 0 to VpaDCotacaoDe.Produtos.count - 1 do
  begin
    VpfDProdutoDe := TRBDOrcProduto(VpaDCotacaoDe.Produtos.Items[VpfLaco]);
    VpfDProdutoPara := VpaDCotacaoPara.AddProduto;
    CopiaDProdutoCotacao(VpfDProdutoDe,VpfDProdutoPara);
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDProdutoCotacao(VpaDProCotacaoDe, VpaDProCotacaoPara : TRBDOrcProduto);
begin
  VpaDProCotacaoPara.LanOrcamentoOrigem := VpaDProCotacaoDe.LanOrcamentoOrigem;
  VpaDProCotacaoPara.SeqMovimento := VpaDProCotacaoDe.SeqMovimento;
  VpaDProCotacaoPara.SeqProduto := VpaDProCotacaoDe.SeqProduto;
  VpaDProCotacaoPara.CodCor := VpaDProCotacaoDe.CodCor;
  VpaDProCotacaoPara.CodTamanho := VpaDProCotacaoDe.CodTamanho;
  VpaDProCotacaoPara.CodEmbalagem := VpaDProCotacaoDe.CodEmbalagem;
  VpaDProCotacaoPara.CodPrincipioAtivo := VpaDProCotacaoDe.CodPrincipioAtivo;
  VpaDProCotacaoPara.CodProduto := VpaDProCotacaoDe.CodProduto;
  VpaDProCotacaoPara.CodClassificacao := VpaDProCotacaoDe.CodClassificacao;
  VpaDProCotacaoPara.NomProduto := VpaDProCotacaoDe.NomProduto;
  VpaDProCotacaoPara.NomTamanho := VpaDProCotacaoDe.NomTamanho;
  VpaDProCotacaoPara.DesCor := VpaDProCotacaoDe.DesCor;
  VpaDProCotacaoPara.DesEmbalagem := VpaDProCotacaoDe.DesEmbalagem;
  VpaDProCotacaoPara.DesObservacao := VpaDProCotacaoDe.DesObservacao;
  VpaDProCotacaoPara.DesRefCliente := VpaDProCotacaoDe.DesRefCliente;
  VpaDProCotacaoPara.DesOrdemCompra := VpaDProCotacaoDe.DesOrdemCompra;
  VpaDProCotacaoPara.DesPrateleira := VpaDProCotacaoDe.DesPrateleira;
  VpaDProCotacaoPara.UM := VpaDProCotacaoDe.UM;
  VpaDProCotacaoPara.UMAnterior := VpaDProCotacaoDe.UMAnterior;
  VpaDProCotacaoPara.UMOriginal := VpaDProCotacaoDe.UMOriginal;
  VpaDProCotacaoPara.IndImpFoto := VpaDProCotacaoDe.IndImpFoto;
  VpaDProCotacaoPara.IndImpDescricao := VpaDProCotacaoDe.IndImpDescricao;
  VpaDProCotacaoPara.DesRegistroMSM := VpaDProCotacaoDe.DesRegistroMSM;
  VpaDProCotacaoPara.IndFaturar := VpaDProCotacaoDe.IndFaturar;
  VpaDProCotacaoPara.IndRetornavel := VpaDProCotacaoDe.IndRetornavel;
  VpaDProCotacaoPara.IndBrinde := VpaDProCotacaoDe.IndBrinde;
  VpaDProCotacaoPara.IndCracha := VpaDProCotacaoDe.IndCracha;
  VpaDProCotacaoPara.IndMedicamentoControlado := VpaDProCotacaoDe.IndMedicamentoControlado;
  VpaDProCotacaoPara.IndPermiteAlterarQtdnaSeparacao := VpaDProCotacaoDe.IndPermiteAlterarQtdnaSeparacao;
  VpaDProCotacaoPara.PerDesconto := VpaDProCotacaoDe.PerDesconto;
  VpaDProCotacaoPara.PesLiquido := VpaDProCotacaoDe.PesLiquido;
  VpaDProCotacaoPara.PesBruto := VpaDProCotacaoDe.PesBruto;
  VpaDProCotacaoPara.QtdBaixadoNota := VpaDProCotacaoDe.QtdBaixadoNota;
  VpaDProCotacaoPara.QtdBaixadoEstoque := VpaDProCotacaoDe.QtdBaixadoEstoque;
  VpaDProCotacaoPara.QtdABaixar := VpaDProCotacaoDe.QtdABaixar;
  VpaDProCotacaoPara.QtdEstoque := VpaDProCotacaoDe.QtdEstoque;
  VpaDProCotacaoPara.QtdMinima := VpaDProCotacaoDe.QtdMinima;
  VpaDProCotacaoPara.QtdPedido := VpaDProCotacaoDe.QtdPedido;
  VpaDProCotacaoPara.QtdProduto := VpaDProCotacaoDe.QtdProduto;
  VpaDProCotacaoPara.QtdFiscal := VpaDProCotacaoDe.QtdFiscal;
  VpaDProCotacaoPara.QtdDevolvido := VpaDProCotacaoDe.QtdDevolvido;
  VpaDProCotacaoPara.QtdSaldoBrinde := VpaDProCotacaoDe.QtdSaldoBrinde;
  VpaDProCotacaoPara.ValUnitario := VpaDProCotacaoDe.ValUnitario;
  VpaDProCotacaoPara.ValUnitarioOriginal := VpaDProCotacaoDe.ValUnitarioOriginal;
  VpaDProCotacaoPara.ValTotal := VpaDProCotacaoDe.ValTotal;
  VpaDProCotacaoPara.RedICMS := VpaDProCotacaoDe.RedICMS;
  VpaDProCotacaoPara.PerComissao := VpaDProCotacaoDe.PerComissao;
  VpaDProCotacaoPara.PerComissaoClassificacao := VpaDProCotacaoDe.PerComissaoClassificacao;
  VpaDProCotacaoPara.AltProdutonaGrade := VpaDProCotacaoDe.AltProdutonaGrade;
  VpaDProCotacaoPara.UnidadeParentes.Assign(VpaDProCotacaoDe.UnidadeParentes);
end;

{******************************************************************************}
procedure TFuncoesCotacao.DuplicaDadosItemOrcamento(VpaDItemOrigem,VpaDItemDestino : TRBDOrcProduto);
begin
  VpaDItemDestino.SeqProduto := VpaDItemOrigem.SeqProduto;
  VpaDItemDestino.CodCor := VpaDItemOrigem.CodCor;
  VpaDItemDestino.CodEmbalagem := VpaDItemOrigem.CodEmbalagem;
  VpaDItemDestino.CodProduto := VpaDItemOrigem.CodProduto;
  VpaDItemDestino.NomProduto := VpaDItemOrigem.NomProduto;
  VpaDItemDestino.DesCor := VpaDItemOrigem.DesCor;
  VpaDItemDestino.DesEmbalagem := VpaDItemOrigem.DesEmbalagem;
  VpaDItemDestino.DesObservacao := VpaDItemOrigem.DesObservacao;
  VpaDItemDestino.DesRefCliente := VpaDItemOrigem.DesRefCliente;
  VpaDItemDestino.UM := VpaDItemOrigem.UM;
  VpaDItemDestino.UMAnterior := VpaDItemOrigem.UMAnterior;
  VpaDItemDestino.UMOriginal := VpaDItemOrigem.UMOriginal;
  VpaDItemDestino.IndImpFoto := VpaDItemOrigem.IndImpFoto;
  VpaDItemDestino.DesOrdemCompra := VpaDItemOrigem.DesOrdemCompra;
  VpaDItemDestino.IndImpDescricao := VpaDItemOrigem.IndImpDescricao;
  VpaDItemDestino.IndFaturar := VpaDItemOrigem.IndFaturar;
  VpaDItemDestino.IndRetornavel := VpaDItemOrigem.IndRetornavel;
  VpaDItemDestino.IndBrinde := VpaDItemOrigem.IndBrinde;
  VpaDItemDestino.PerDesconto := VpaDItemOrigem.PerDesconto;
  VpaDItemDestino.PesLiquido := VpaDItemOrigem.PesLiquido;
  VpaDItemDestino.PesBruto := VpaDItemOrigem.PesBruto;
  VpaDItemDestino.QtdBaixadoNota := 0;
  VpaDItemDestino.QtdBaixadoEstoque := 0;
  VpaDItemDestino.QtdABaixar := 0;
  VpaDItemDestino.QtdEstoque := VpaDItemOrigem.QtdEstoque;
  VpaDItemDestino.QtdMinima := VpaDItemOrigem.QtdMinima;
  VpaDItemDestino.QtdPedido := VpaDItemOrigem.QtdPedido;
  VpaDItemDestino.QtdProduto := VpaDItemOrigem.QtdProduto;
  VpaDItemDestino.QtdFiscal := VpaDItemOrigem.QtdFiscal;
  VpaDItemDestino.QtdDevolvido := 0;
  VpaDItemDestino.ValUnitario := VpaDItemOrigem.ValUnitario;
  VpaDItemDestino.ValUnitarioOriginal := VpaDItemOrigem.ValUnitarioOriginal;
  VpaDItemDestino.ValTotal := VpaDItemOrigem.ValTotal;
  VpaDItemDestino.UnidadeParentes.Assign(VpaDItemOrigem.UnidadeParentes);
end;

{******************************************************************************}
procedure TFuncoesCotacao.MontaEmailCotacaoTexto(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente);
var
  VpfDProduto : TRBDOrcProduto;
  VpfLaco : Integer;
begin
  VpaTexto.add('Cotação '+IntToStr(VpaDCotacao.LanOrcamento));
  VpaTexto.add('Tipo');
  VpaTexto.add(UpperCase(IntToStr(VpaDCotacao.CodTipoOrcamento))+'-'+ RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento));
  VpaTexto.add('Cliente');
  VpaTexto.add(UpperCase(IntToStr(VpaDCliente.CodCliente)+'-'+VpaDCliente.NomCliente));
  VpaTexto.add('Nome Fantasia');
  VpaTexto.add(UpperCase(VpaDCliente.NomFantasia));
  VpaTexto.add('Endereço');
  VpaTexto.add(UpperCase(VpaDCliente.DesEndereco+','+VpaDCliente.NumEndereco+'-'+VpaDCliente.DesComplementoEndereco));
  VpaTexto.add('Bairro');
  VpaTexto.add(UPPERCASE(VpaDCliente.DesBairro));
  VpaTexto.add('Cidade');
  VpaTexto.add(UpperCase(VpaDCliente.DesCidade+' / '+VpaDCliente.DesUF));
  VpaTexto.add('Fone');
  VpaTexto.add(VpaDCliente.DesFone1);
  VpaTexto.add('Contato');
  VpaTexto.add(UpperCase(VpaDCotacao.NomContato));
  VpaTexto.add('');
  VpaTexto.add('Data');
  VpaTexto.add(FormatDateTime('DD/MM/YY',VpaDCotacao.DatOrcamento)+FormatDateTime('HH:MM:SS',VpaDCotacao.HorOrcamento));
  VpaTexto.add('');
  VpaTexto.add('Transportadora');
  VpaTexto.add(RNomTransportadora(VpaDCotacao.CodTransportadora));
  VpaTexto.add('');
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    VpaTexto.add('Produto '+IntToStr(VpfLaco+1)+' de '+IntToStr(VpaDCotacao.Produtos.Count));
    VpaTexto.add(VpfDProduto.CodProduto+'-'+VpfDProduto.NomProduto);
    VpaTexto.add('Qtd');
    VpaTexto.add(FormatFloat('###,###,##0.00',VpfDProduto.QtdProduto));
    VpaTexto.add('Valor Unitario');
    VpaTexto.add(FormatFloat('###,###,##0.00',VpfDProduto.ValUnitario));
    VpaTexto.add('Valor Total');
    VpaTexto.add(FormatFloat('###,###,##0.00',VpfDProduto.ValTotal));
    VpaTexto.add('');
  end;
  VpaTexto.add('Observações');
  VpaTexto.add(VpaDCotacao.desobservacao.Text);
  VpaTexto.add('');
  VpaTexto.add('Valor Total Pedido');
  VpaTexto.add(FormatFloat('###,###,##0.00',VpaDCotacao.ValTotal));
  VpaTexto.add('Forma de Pagamento');
  VpaTexto.add(FunContasAReceber.RNomFormaPagamento(VpaDCotacao.CodFormaPaqamento));
  VpaTexto.add('Condição de Pagamento');
  VpaTexto.add(FunContasAReceber.RNomCondicaoPagamento(VpaDCotacao.CodCondicaoPagamento));

  VpaDCotacao.Parcelas.Clear;
  CarParcelasContasAReceber(VpaDCotacao);
  VpaTexto.add('Parcelas');
  for VpfLaco := 0 to VpaDCotacao.Parcelas.Count - 1 do
  begin
    VpaTexto.add(VpaDCotacao.Parcelas.Strings[vpflaco]);
  end;
  VpaTexto.add('');
  VpaTexto.add('Usuário');
  VpaTexto.add(Sistema.RNomUsuario(VpaDCotacao.CodUsuario));
end;

{******************************************************************************}
procedure TFuncoesCotacao.MontaCabecalhoEmail(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaEnviarImagem : Boolean);
begin
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <a href="http://'+varia.SiteFilial+'">');
  VpaTexto.add('      <IMG src="cid:'+intToStr(VpaDCotacao.CodEmpFil)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+'>');
  VpaTexto.add('    </a></td> <td bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <b>'+varia.NomeFilial+ '.</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+Varia.EnderecoFilial+'              Bairro : '+Varia.BairroFilial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+Varia.CidadeFilial +' / '+Varia.UFFilial+ '                CEP : '+Varia.CepFilial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+varia.FoneFilial +'         -             e-mail :'+Varia.EMailFilial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+varia.SiteFilial+'">'+varia.SiteFilial);
  VpaTexto.add('    </td><td bgcolor="#'+varia.CRMCorClaraEmail+'"> ');
  VpaTexto.add('    <center>');
  VpaTexto.add('    <h3> Número </h3>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <h2> '+formatFloat('###,###,##0',VpadCotacao.LanOrcamento)+'</h2>');
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
procedure TFuncoesCotacao.MontaEmailCotacao(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaDRepresentada : TRBDRepresentada;VpaEnviarImagem : Boolean);
var
  VpfDProduto : TRBDOrcProduto;
  VpfDServico : TRBDOrcServico;
  VpfLaco : Integer;
  VpfValUnitario,VpfValTotal : Double;
begin

  VpaTexto.Clear;
  VpaTexto.Add('<html>');
  VpaTexto.Add('<head>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDCotacao.CodEmpFil)+' - '+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+' : '+IntToStr(VpaDCotacao.LanOrcamento));
  VpaTexto.Add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.Add('<center>');
  VpaTexto.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
  VpaTexto.Add('<tr>');
  VpaTexto.add('<td>');
  VpaTexto.Add('<table width=100%  border=0 >');
  VpaTexto.add(' <tr>');
  VpaTexto.Add('  <td width=40%>');
  VpaTexto.add('    <a > <img src="cid:'+IntToStr(VpaDCotacao.CodEmpFil)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  <td width=20% align="center" > <font face="Verdana" size="5"><b>'+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+' '+IntToStr(VpaDCotacao.LanOrcamento));
  if not Sistema.PodeDivulgarEficacia then
    VpaTexto.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="" href="http://www..com.br"> <img src="cid:R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg" border="0"')
  else
    VpaTexto.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="Sistema de Gestao Desenvolvido por Eficacia Sistemas e Consultoria" href="http://www.eficaciaconsultoria.com.br"> <img src="cid:efi.jpg" border="0"');
  VpaTexto.add('  </td>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<br>');
  VpaTexto.Add('<br>');
  VpaTexto.add('<table width=100%  border=0 cellpadding="0" cellspacing="0" >');
  VpaTexto.Add(' <tr>');
  VpaTexto.add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
  VpaTexto.Add('   <br> <center>');
  VpaTexto.add('   <br>Esta mensagem refere-se ao Pedido "'+IntToStr(VpaDCotacao.LanOrcamento)+'"');
  VpaTexto.Add('   <br></center>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.Add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="3">');
  VpaTexto.add('   <br><center>');
  VpaTexto.Add('   <br>Cliente : '+RetiraAcentuacao(VpaDCliente.NomCliente) );
  VpaTexto.add('   <br>CNPJ :'+VpaDCliente.CGC_CPF);
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.Add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
  VpaTexto.add('   <br><center>');
  VpaTexto.Add('   <br>Data Emissao : '+FormatDateTime('DD/MM/YYY',VpaDCotacao.DatOrcamento));
  if (varia.CNPJFilial = CNPJ_HORNBURG) then
    VpaTexto.Add('   <br>Vendedor : ALCI HORNBURG')
  else
    VpaTexto.Add('   <br>Vendedor : '+RNomVendedor(VpaDCotacao.CodVendedor));
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr>');
  VpaTexto.Add(' </tr><tr>');
  VpaTexto.add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="3">');
  VpaTexto.Add('   <br><center>');
  if config.RepresentanteComercial then
  begin
    VpaTexto.Add('<br>'+VpaDRepresentada.NomFantasia);
  end;
  VpaTexto.add('   <br><address><a href="http://'+varia.SiteFilial+'">'+Varia.NomeFilial+'</a>  </address>');
  VpaTexto.Add('   <br> '+Varia.FoneFilial);
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add(' </tr><tr>');
  VpaTexto.add('</table>');
  VpaTexto.Add('</td>');
  VpaTexto.add('</tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<hr>');
  VpaTexto.Add('<center>');
  if sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.Add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.Add('');
  VpaTexto.add('</html>');

{  Vpfbmppart := TIdAttachmentFile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+intToStr(VpaDCotacao.CodEmpFil)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := intToStr(VpaDCotacao.CodEmpFil)+'.jpg';
  Vpfbmppart.DisplayName := intToStr(VpaDCotacao.CodEmpFil)+'.jpg';

  MontaCabecalhoEmail(VpaTexto,VpaDCotacao,VpaDCliente,VpaEnviarImagem);
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Tipo</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDCotacao.CodTipoOrcamento)+'-'+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+'</td>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY',VpaDCotacao.DatOrcamento)+' - '+FormatDateTime('HH:MM:SS',VpaDCotacao.HorOrcamento) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('    <br>');
//  VpaTexto.add('    <P>Número e cadastro: <input TYPE="text" name="cadastro" size="8" maxlength="8"><br> ');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  if VpaDCliente.NomFantasia <> ''  then
    VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.NomFantasia+' </td>')
  else
    VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.NomCliente+' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Endere&ccedil;o</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadcliente.DesEndereco+','+VpaDCliente.NumEndereco+' - '+VpaDCliente.DesComplementoEndereco +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Bairro</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadCliente.DesBairro +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cep</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CepCliente+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cidade</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesCidade+'/'+VpaDCliente.DesUF +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CNPJ</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Inscrição Estadual</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.InscricaoEstadual+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fone</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFone1+'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fax</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFax+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;e-mail</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesEmail+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Contato</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadcliente.NomContato+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Atendente</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+Sistema.RNomUsuario(VpaDCotacao.CodUsuario) +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=5 align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Produtos</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('        <td width="45%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Produto</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');

  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpaDCotacao.PerDesconto <> 0 then
    begin
      VpfValUnitario := VpfDProduto.ValUnitario - ((VpfDProduto.ValUnitario * VpaDCotacao.PerDesconto)/100);
      VpfValTotal := VpfDProduto.ValTotal - ((VpfDProduto.ValTotal * VpaDCotacao.PerDesconto)/100);
    end
    else
    begin
      VpfValUnitario := VpfDProduto.ValUnitario;
      VpfValTotal := VpfDProduto.ValTotal;
    end;

    VpaTexto.add('</tr><tr>');
    VpaTexto.add('      <td width="45%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProduto.CodProduto+'-'+VpfDProduto.NomProduto+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProduto.QtdProduto) +'</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfValUnitario)+'</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfValTotal) +'</td>');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  if VpaDCotacao.Servicos.Count > 0 then
  begin
    VpaTexto.add('<table width="100%">');
    VpaTexto.add('<tr>');
    VpaTexto.add('	<td colspan=4 align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Servi&ccedil;os</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Servi&ccedil;o</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
    for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
    begin
      VpfDServico:= TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
      VpaTexto.add('</tr><tr>');
      VpaTexto.add('      <td width="40%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="left"><font face="Verdana" size="-1">&nbsp;'+IntToStr(VpfDServico.CodServico)+'-'+VpfDServico.NomServico+'-'+VpfDServico.DesAdicional+'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDServico.QtdServico) +'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfDServico.ValUnitario)+'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDServico.ValTotal) +'</td>');
    end;
    VpaTexto.add('</tr>');
    VpaTexto.add('</table><br>');
  end;

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Transportadora</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomTransportadora(VpaDCotacao.CodTransportadora) +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Vendedor</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomVendedor(VpaDCotacao.CodVendedor) +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Ordem de Compra</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCotacao.OrdemCompra +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>Observa&ccedil;oes</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCotacao.DesObservacao.Text+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+RTextoAcrescimoDesconto(VpaDCotacao) +'</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RValorAcrescimodesconto(VpaDCotacao)+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="4">&nbsp;<b>'+FormatFloat(varia.MascaraValor,VpaDCotacao.ValTotal) +'</b></td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<table width="40%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Parcelas</td>');
  VpaTexto.add('</tr><tr>');
  for VpfLaco := 0 to VpaDCotacao.Parcelas.Count - 1 do
  begin
    VpaTexto.add('	<td align="center" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+VpaDCotacao.Parcelas.Strings[vpflaco]+'</td>');
    VpaTexto.add('</tr><tr>');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');


  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  if Varia.CNPJFilial <>  CNPJ_REELTEX then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');}
//  VpaTExto.saveToFile('c:\marcelo.html');
end;

{******************************************************************************}
procedure TFuncoesCotacao.MontaEmailCotacaoEstagio(VpaTexto: TStrings;
  VpaDCotacao: TRBDOrcamento; VpaDCliente : TRBDCliente;VpaDRepresentada: TRBDRepresentada;
  VpaEnviarImagem: Boolean);
var
  VpfDProduto : TRBDOrcProduto;
  VpfDServico : TRBDOrcServico;
  VpfLaco : Integer;
  VpfValUnitario,VpfValTotal : Double;
begin

  VpaTexto.Clear;
  VpaTexto.Add('<html>');
  VpaTexto.Add('<head>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDCotacao.CodEmpFil)+' - '+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+' : '+IntToStr(VpaDCotacao.LanOrcamento));
  VpaTexto.Add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.Add('<center>');
  VpaTexto.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
  VpaTexto.Add('<tr>');
  VpaTexto.add('<td>');
  VpaTexto.Add('<table width=100%  border=0 >');
  VpaTexto.add(' <tr>');
  VpaTexto.Add('  <td width=40%>');
  VpaTexto.add('    <a > <img src="cid:'+IntToStr(VpaDCotacao.CodEmpFil)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  <td width=20% align="center" > <font face="Verdana" size="5"><b>'+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+' '+IntToStr(VpaDCotacao.LanOrcamento));
  if not Sistema.PodeDivulgarEficacia then
    VpaTexto.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="" href="http://www..com.br"> <img src="cid:R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg" border="0"')
  else
    VpaTexto.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="Sistema de Gestao Desenvolvido por Eficacia Sistemas e Consultoria" href="http://www.eficaciaconsultoria.com.br"> <img src="cid:efi.jpg" border="0"');
  VpaTexto.add('  </td>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<br>');
  VpaTexto.Add('<br>');
  VpaTexto.add('<table width=100%  border=0 cellpadding="0" cellspacing="0" >');
  VpaTexto.Add(' <tr>');
  VpaTexto.add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
  VpaTexto.Add('   <br> <center>');
  VpaTexto.add('   <br>Esta mensagem refere-se ao Pedido "'+IntToStr(VpaDCotacao.LanOrcamento)+'"');
  VpaTexto.Add('   <br></center>');
  VpaTexto.Add('   <br> <center>');
  VpaTexto.add('   <br>O seu pedido está no estágio: "'+ RNomeEstagioAtualCotacao(VpaDCotacao.CodEstagio) +'"');
  VpaTexto.Add('   <br></center>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.Add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="3">');
  VpaTexto.add('   <br><center>');
  VpaTexto.Add('   <br>Cliente : '+RetiraAcentuacao(VpaDCliente.NomCliente) );
  VpaTexto.add('   <br>CNPJ :'+VpaDCliente.CGC_CPF);
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.Add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
  VpaTexto.add('   <br><center>');
  VpaTexto.Add('   <br>Data Emissao : '+FormatDateTime('DD/MM/YYY',VpaDCotacao.DatOrcamento));
  if (varia.CNPJFilial = CNPJ_HORNBURG) then
    VpaTexto.Add('   <br>Vendedor : ALCI HORNBURG')
  else
    VpaTexto.Add('   <br>Vendedor : '+RNomVendedor(VpaDCotacao.CodVendedor));
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr>');
  VpaTexto.Add(' </tr><tr>');
  VpaTexto.add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="3">');
  VpaTexto.Add('   <br><center>');
  if config.RepresentanteComercial then
  begin
    VpaTexto.Add('<br>'+VpaDRepresentada.NomFantasia);
  end;
  VpaTexto.add('   <br><address><a href="http://'+varia.SiteFilial+'">'+Varia.NomeFilial+'</a>  </address>');
  VpaTexto.Add('   <br> '+Varia.FoneFilial);
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add(' </tr><tr>');
  VpaTexto.add('</table>');
  VpaTexto.Add('</td>');
  VpaTexto.add('</tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<hr>');
  VpaTexto.Add('<center>');
  if Sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.Add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.Add('');
  VpaTexto.add('</html>');

{  Vpfbmppart := TIdAttachmentFile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+intToStr(VpaDCotacao.CodEmpFil)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := intToStr(VpaDCotacao.CodEmpFil)+'.jpg';
  Vpfbmppart.DisplayName := intToStr(VpaDCotacao.CodEmpFil)+'.jpg';

  MontaCabecalhoEmail(VpaTexto,VpaDCotacao,VpaDCliente,VpaEnviarImagem);
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Tipo</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDCotacao.CodTipoOrcamento)+'-'+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+'</td>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY',VpaDCotacao.DatOrcamento)+' - '+FormatDateTime('HH:MM:SS',VpaDCotacao.HorOrcamento) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('    <br>');
//  VpaTexto.add('    <P>Número e cadastro: <input TYPE="text" name="cadastro" size="8" maxlength="8"><br> ');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  if VpaDCliente.NomFantasia <> ''  then
    VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.NomFantasia+' </td>')
  else
    VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.NomCliente+' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Endere&ccedil;o</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadcliente.DesEndereco+','+VpaDCliente.NumEndereco+' - '+VpaDCliente.DesComplementoEndereco +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Bairro</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadCliente.DesBairro +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cep</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CepCliente+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cidade</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesCidade+'/'+VpaDCliente.DesUF +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CNPJ</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Inscrição Estadual</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.InscricaoEstadual+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fone</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFone1+'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fax</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFax+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;e-mail</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesEmail+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Contato</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadcliente.NomContato+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Atendente</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+Sistema.RNomUsuario(VpaDCotacao.CodUsuario) +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=5 align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Produtos</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('        <td width="45%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Produto</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');

  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpaDCotacao.PerDesconto <> 0 then
    begin
      VpfValUnitario := VpfDProduto.ValUnitario - ((VpfDProduto.ValUnitario * VpaDCotacao.PerDesconto)/100);
      VpfValTotal := VpfDProduto.ValTotal - ((VpfDProduto.ValTotal * VpaDCotacao.PerDesconto)/100);
    end
    else
    begin
      VpfValUnitario := VpfDProduto.ValUnitario;
      VpfValTotal := VpfDProduto.ValTotal;
    end;

    VpaTexto.add('</tr><tr>');
    VpaTexto.add('      <td width="45%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProduto.CodProduto+'-'+VpfDProduto.NomProduto+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProduto.QtdProduto) +'</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfValUnitario)+'</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfValTotal) +'</td>');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  if VpaDCotacao.Servicos.Count > 0 then
  begin
    VpaTexto.add('<table width="100%">');
    VpaTexto.add('<tr>');
    VpaTexto.add('	<td colspan=4 align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Servi&ccedil;os</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Servi&ccedil;o</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
    for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
    begin
      VpfDServico:= TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
      VpaTexto.add('</tr><tr>');
      VpaTexto.add('      <td width="40%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="left"><font face="Verdana" size="-1">&nbsp;'+IntToStr(VpfDServico.CodServico)+'-'+VpfDServico.NomServico+'-'+VpfDServico.DesAdicional+'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDServico.QtdServico) +'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfDServico.ValUnitario)+'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDServico.ValTotal) +'</td>');
    end;
    VpaTexto.add('</tr>');
    VpaTexto.add('</table><br>');
  end;

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Transportadora</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomTransportadora(VpaDCotacao.CodTransportadora) +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Vendedor</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomVendedor(VpaDCotacao.CodVendedor) +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Ordem de Compra</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCotacao.OrdemCompra +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>Observa&ccedil;oes</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCotacao.DesObservacao.Text+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+RTextoAcrescimoDesconto(VpaDCotacao) +'</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RValorAcrescimodesconto(VpaDCotacao)+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="4">&nbsp;<b>'+FormatFloat(varia.MascaraValor,VpaDCotacao.ValTotal) +'</b></td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<table width="40%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Parcelas</td>');
  VpaTexto.add('</tr><tr>');
  for VpfLaco := 0 to VpaDCotacao.Parcelas.Count - 1 do
  begin
    VpaTexto.add('	<td align="center" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+VpaDCotacao.Parcelas.Strings[vpflaco]+'</td>');
    VpaTexto.add('</tr><tr>');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');


  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  if Varia.CNPJFilial <>  CNPJ_REELTEX then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');}
//  VpaTExto.saveToFile('c:\marcelo.html');

end;

{******************************************************************************}
procedure TFuncoesCotacao.MontaEmailCotacaoEstagioModificado(VpaTexto: TStrings;
  VpaDCotacao: TRBDOrcamento; VpaDCliente: TRBDCliente;
  VpaDRepresentada: TRBDRepresentada; VpaEnviarImagem: Boolean);
var
  VpfDProduto : TRBDOrcProduto;
  VpfDServico : TRBDOrcServico;
  VpfLaco : Integer;
  VpfValUnitario,VpfValTotal : Double;
begin
  VpaTexto.Clear;
  VpaTexto.Add('<html>');
  VpaTexto.Add('<head>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDCotacao.CodEmpFil)+' - '+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+' : '+IntToStr(VpaDCotacao.LanOrcamento));
  VpaTexto.Add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.Add('<center>');
  VpaTexto.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
  VpaTexto.Add('<tr>');
  VpaTexto.add('<td>');
  VpaTexto.Add('<table width=100%  border=0 >');
//  VpaTexto.add(' <tr>');
  VpaTexto.Add('  <td width=20%> <center>');
  VpaTexto.add('    <a > <img src="cid:'+IntToStr(VpaDCotacao.CodEmpFil)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
  VpaTexto.Add('  </td> </center>');
  VpaTexto.add('  </td>');
  VpaTexto.Add('  </td>');
//  VpaTexto.add('  </tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<table width=100%  border=0 cellpadding="0" cellspacing="0" >');
//  VpaTexto.Add(' <tr>');
  VpaTexto.add('  <td width=100% ><font face="Verdana" size="3">');
  VpaTexto.add('   <br><B><center> Olá, '+VpaDCliente.NomCliente);
  VpaTexto.Add('   </B><br>');
  VpaTexto.add('   <br><center> O seu pedido está no estágio: "'+ RNomeEstagioAtualCotacao(VpaDCotacao.CodEstagio) +'"');
  VpaTexto.add('   <br><center> Pedido Nro.: "'+ IntToStr(VpaDCotacao.LanOrcamento) +'"');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.Add('  <td width=100% ><font face="Verdana" size="3">');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br><center> '+ Varia.NomeFilial + ' - ' + varia.FoneFilial + ' - ' + varia.BairroFilial);
  VpaTexto.add(' </tr><tr>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr>');
  VpaTexto.add('</table>');
  VpaTexto.Add('</td>');
  VpaTexto.add('</tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<hr>');
  VpaTexto.Add('<center>');
  if sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.Add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.Add('');
  VpaTexto.add('</html>');
end;

{******************************************************************************}
function TFuncoesCotacao.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP) : string;
var
  VpfEmailUsuario : String;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  if VpaMensagem.From.Address = '' then
    VpaMensagem.From.Address := varia.UsuarioSMTP;
  VpaMensagem.From.Name := varia.NomeFilial;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := varia.PortaSMTP;
  if config.ServidorInternetRequerAutenticacao then
    VpaSMTP.AuthType := satDefault
  else
    VpaSMTP.AuthType := satNone;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    VpaMensagem.ReceiptRecipient.Text  :=VpaMensagem.From.Text;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DA FILIAL !!!'#13'É necessário preencher o e-mail da transportadora.';
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
function TFuncoesCotacao.VerificaSeparacaoTotal(VpaDCotacao : TRBDOrcamento;Var VpaIndTotal : Boolean):string;
var
  VpfLaco : Integer;
  VpfSeparacaoSuperior : Boolean;
  VpfDProCotacao : TRBDOrcProduto;
begin
  result := '';
  VpaIndTotal := true;
  VpfSeparacaoSuperior := false;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if ((VpfDProCotacao.QtdBaixadoNota < VpfDProCotacao.QtdProduto) and not config.ConferirAQuantidadeSeparada) or
       ((VpfDProCotacao.QtdConferido < VpfDProCotacao.QtdProduto) and config.ConferirAQuantidadeSeparada) then
      VpaIndTotal := false
    else
      if VpfDProCotacao.QtdBaixadoNota > VpfDProCotacao.QtdProduto then
      begin
        VpfSeparacaoSuperior := true;
        result := #13'"'+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto+ '" COR '+VpfDProCotacao.DesCor;
      end;
  end;
  if VpfSeparacaoSuperior and VpaIndTotal then
    result := 'OS PRODUTOS ABAIXO FORAM SEPARADOS COM A SUAS QUANTIDADE A MAIOR DO QUE A DO PEDIDO:'+result
  else
    result := '';
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaEstoqueCartuchoAssociado(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDCartucho : TRBDCartuchoCotacao;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if Varia.OperacaoAcertoEstoqueEntrada = 0 then
    result := 'OPERAÇÃO ACERTO ESTOQUE ENTRADA NÃO PREENCHIDA!!!'#13'É necessário preencher nas configurações do sistema a operação de acerto de estoque';
  if Varia.OperacaoAcertoEstoqueSaida = 0 then
    result := 'OPERAÇÃO ACERTO ESTOQUE SAÍDA NÃO PREENCHIDA!!!'#13'É necessário preencher nas configurações do sistema a operação de acerto de estoque';
  if result = '' then
  begin
    for VpfLaco := 0 to VpaCartuchos.Count - 1 do
    begin
      VpfDCartucho := TRBDCartuchoCotacao(VpaCartuchos.Items[VpfLaco]);
      if VpfDCartucho.SeqProdutoTrocado <> 0 then
      begin
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaDCotacao.CodEmpFil,VpfDCartucho.SeqProdutoTrocado);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDCotacao.CodEmpFil,varia.OperacaoAcertoEstoqueEntrada,
                                         0,VpaDCotacao.LanOrcamento,VpaDCotacao.LanOrcamento,
                                         varia.MoedaBase,0,0,now,1,0,VpfDProduto.CodUnidade,
                                         '',false,VpfSeqEstoqueBarra,true);
        FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaDCotacao.CodEmpFil,VpfDCartucho.SeqProduto);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDCotacao.CodEmpFil,varia.OperacaoAcertoEstoqueSaida,
                                         0,VpaDCotacao.LanOrcamento,VpaDCotacao.LanOrcamento,
                                         varia.MoedaBase,0,0,now,1,0,VpfDProduto.CodUnidade,
                                         '',false,VpfSeqEstoqueBarra,true);
        VpfDProduto.free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosASeparar(VpaDCotacao, VpaDCotacaoNova : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfdProdutoDE, VpfDProdutoPara : TRBDOrcProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProdutoDE :=TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if ((VpfDProdutoDE.QtdBaixadoNota <> 0) and not config.ConferirAQuantidadeSeparada) or
       ((VpfDProdutoDE.QtdConferidoSalvo <> 0) and  config.ConferirAQuantidadeSeparada)  then
    begin
      VpfDProdutoPara := VpaDCotacaoNova.AddProduto;
      if config.ConferirAQuantidadeSeparada then
      begin
        VpfDProdutoPara.QtdProduto := VpfdProdutoDE.QtdConferidoSalvo;
        VpfDProdutoPara.QtdBaixadoNota := VpfdProdutoDE.QtdConferidoSalvo;
      end
      else
      begin
        VpfDProdutoPara.QtdProduto := VpfDProdutoDE.QtdBaixadoNota;
        VpfDProdutoPara.QtdBaixadoNota := VpfDProdutoDE.QtdBaixadoNota;
      end;
      VpfDProdutoPara.QtdConferidoSalvo := VpfDProdutoDE.QtdConferidoSalvo;
      VpfDProdutoPara.ValUnitario := VpfDProdutoDE.ValUnitario;
      VpfDProdutoPara.ValTotal := VpfDProdutoPara.ValUnitario * VpfDProdutoPara.QtdProduto;
      VpfDProdutoPara.PerDesconto := VpfDProdutoDE.PerDesconto;
      if Config.DescontoNosProdutodaCotacao then
        VpfDProdutoPara.ValTotal := VpfDProdutoPara.ValTotal - ((VpfDProdutoPara.ValTotal *VpfDProdutoPara.PerDesconto)/100);
      VpfDProdutoPara.SeqProduto := VpfDProdutoDE.SeqProduto;
      VpfDProdutoPara.CodCor := VpfDProdutoDE.CodCor;
      VpfDProdutoPara.CodEmbalagem := VpfDProdutoDE.CodEmbalagem;
      VpfDProdutoPara.CodPrincipioAtivo := VpfDProdutoDE.CodPrincipioAtivo;
      VpfDProdutoPara.CodProduto := VpfDProdutoDE.CodProduto;
      VpfDProdutoPara.NomProduto := VpfDProdutoDE.NomProduto;
      VpfDProdutoPara.DesCor := VpfDProdutoDE.DesCor;
      VpfDProdutoPara.DesEmbalagem := VpfDProdutoDE.DesEmbalagem;
      VpfDProdutoPara.DesObservacao := VpfDProdutoDE.DesObservacao;
      VpfDProdutoPara.DesRefCliente := IntToStr(VpaDCotacao.LanOrcamento);
      VpfDProdutoPara.DesOrdemCompra := VpfDProdutoDE.DesOrdemCompra;
      VpfDProdutoPara.UM := VpfDProdutoDE.UM;
      VpfDProdutoPara.UMAnterior := VpfDProdutoDE.UMAnterior;
      VpfDProdutoPara.UMOriginal := VpfDProdutoDE.UMOriginal;
      VpfDProdutoPara.IndImpFoto := VpfDProdutoDE.IndImpFoto;
      VpfDProdutoPara.IndImpDescricao := VpfDProdutoDE.IndImpDescricao;

      if config.ConferirAQuantidadeSeparada then
      begin
        VpfDProdutoDE.QtdProduto := VpfDProdutoDE.QtdProduto - VpfDProdutoDE.QtdConferidoSalvo;
        VpfdProdutoDE.QtdBaixadoNota := VpfdProdutoDE.QtdBaixadoNota - VpfDProdutoDE.QtdConferidoSalvo;
      end
      else
      begin
        VpfDProdutoDE.QtdProduto := VpfDProdutoDE.QtdProduto - VpfDProdutoDE.QtdBaixadoNota;
        VpfdProdutoDE.QtdBaixadoNota := 0;
      end;
      VpfDProdutoDE.ValTotal := VpfDProdutoDE.ValUnitario * VpfDProdutoDE.QtdProduto;
      if Config.DescontoNosProdutodaCotacao then
        VpfDProdutoDE.ValTotal := VpfDProdutoDE.ValTotal - ((VpfDProdutoDE.ValTotal *VpfDProdutoDE.PerDesconto)/100);
      VpfdProdutoDE.QtdConferidoSalvo := 0;
    end;
  end;

  //deletas os produtos que ficaram com a quantidade zero.
  for VpfLaco := VpaDCotacao.Produtos.Count - 1 downto 0 do
  begin
    VpfDProdutoDE := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDProdutoDE.QtdProduto <= 0 then
    begin
      VpfDProdutoDE.free;
      VpaDCotacao.Produtos.Delete(VpfLaco);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaEstoqueSaldoAlteracao(VpaDSaldo : TRBDOrcamento) :string;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDProCotacao : TRBDOrcProduto;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDSaldo.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDSaldo.Produtos.Items[VpfLaco]);
    VpfDProduto := TRBDProduto.Cria;
    if VpfDProCotacao.QtdBaixadoEstoque > 0 then
    begin
      FunProdutos.CarDProduto(VpfDProduto,0,VpaDSaldo.CodEmpFil, VpfDProCotacao.SeqProduto);
      FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDSaldo.CodEmpFil, varia.OperacaoEstoqueEstornoEntrada,0,
                                    VpaDSaldo.LanOrcamento,VpaDSaldo.LanOrcamento,varia.MoedaBase,VpfDProCotacao.CodCor,VpfDProCotacao.CodTamanho,
                                    date,VpfDProCotacao.QtdBaixadoEstoque ,VpfDProCotacao.QtdBaixadoEstoque *VpfDProCotacao.ValUnitario,
                                    VpfDProCotacao.UM,VpfDProCotacao.DesRefCliente, false,VpfSeqEstoqueBarra)
    end
    else
      if VpfDProCotacao.QtdBaixadoEstoque < 0 then
      begin
        FunProdutos.CarDProduto(VpfDProduto,0,VpaDSaldo.CodEmpFil, VpfDProCotacao.SeqProduto);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDSaldo.CodEmpFil,varia.OperacaoEstoqueEstornoSaida,0,
                                    VpaDSaldo.LanOrcamento,VpaDSaldo.LanOrcamento,varia.MoedaBase,VpfDProCotacao.CodCor,VpfDProCotacao.CodTamanho,
                                    date,VpfDProCotacao.QtdBaixadoEstoque*-1 ,(VpfDProCotacao.QtdBaixadoEstoque *-1) *VpfDProCotacao.ValUnitario,
                                    VpfDProCotacao.UM,VpfDProCotacao.DesRefCliente, false,VpfSeqEstoqueBarra)
      end;
    VpfDProduto.free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AdicionaFinanceiroArqRemessa(VpaDCotacao : TRBDOrcamento):String;
begin
  Result := '';
  if ConfigModulos.Bancario then
  begin
    AdicionaSQLAbreTabela(Orcamento,'Select MOV.I_COD_FRM, MOV.C_NRO_CON, MOV.I_EMP_FIL,MOV.I_LAN_REC, '+
                                    ' MOV.I_NRO_PAR '+
                                    ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                    ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                    ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                    ' AND CAD.I_EMP_FIL = '+IntTostr(VpaDCotacao.CodEmpFil)+
                                    ' AND CAD.I_LAN_ORC = '+Inttostr(VpaDCotacao.LanOrcamento),true);
    While not Orcamento.Eof do
    begin
      if (Orcamento.FieldByName('I_COD_FRM').AsInteger = varia.FormaPagamentoBoleto) then
        result :=   FunContasAReceber.AdicionaRemessa(Orcamento.FieldByName('I_EMP_FIL').AsInteger,Orcamento.FieldByName('I_LAN_REC').AsInteger,Orcamento.FieldByName('I_NRO_PAR').AsInteger,1,'Remessa');
      if result <> '' then
        break;
      Orcamento.next;
    end;
    Orcamento.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RAliquotaICMSUF(VpaDesUF: String): Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select N_ICM_INT from CADICMSESTADOS ' +
                            ' Where C_COD_EST = '''+VpaDesUF+'''');
  result := Aux.FieldByName('N_ICM_INT').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RCodCliente(VpaCodFilial, VpaLanOrcamento : Integer):Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select I_COD_CLI from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_COD_CLI').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RCotacao(VpaCotacoes: TList; VpaCodFilial, VpaLanOrcamento: Integer): TRBDOrcamento;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  Result := nil;
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    if (VpfDCotacao.CodEmpFil = VpaCodFilial) and
       (VpfDCotacao.LanOrcamento = VpaLanOrcamento) then
    begin
      result := VpfDCotacao;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RDescontoAcrescimoComissao(VpaDProdutocotacao: TRBDOrcProduto; VpaPerComissao: Double): Double;
Var
  VpfPerAcrescimo, VpfPerDesconto : Double;
begin
  result := VpaPerComissao;
  if (result <> 0) and (VpaDProdutocotacao.ValTabelaPreco > 0) then
  begin
    if (VpaDProdutocotacao.ValUnitario > VpaDProdutocotacao.ValTabelaPreco) then
    begin
      VpfPerAcrescimo := ((VpaDProdutocotacao.ValUnitario * 100)/ VpaDProdutocotacao.ValTabelaPreco) -100;
      AdicionaSQLAbreTabela(Aux,'Select PERCOMISSAO FROM TABELAPERCOMISSAO '+
                                ' Where INDACRESDESC = ''A'''+
                                ' AND PERDESCONTO >= '+SubstituiStr(FormatFloat('###0.00',VpfPerAcrescimo),',','.')+
                                ' ORDER BY PERDESCONTO');
      if not aux.eof then
        result := result + ((VpaPerComissao * Aux.FieldByName('PERCOMISSAO').AsFloat)/100)
    end
    else
      if (VpaDProdutocotacao.ValUnitario < VpaDProdutocotacao.ValTabelaPreco) then
      begin
        VpfPerDesconto := 100- ((VpaDProdutocotacao.ValUnitario * 100)/ VpaDProdutocotacao.ValTabelaPreco);
        AdicionaSQLAbreTabela(Aux,'Select PERCOMISSAO FROM TABELAPERCOMISSAO '+
                                ' Where INDACRESDESC = ''D'''+
                                ' AND PERDESCONTO >= '+SubstituiStr(FormatFloat('#,##0.00',VpfPerDesconto),',','.')+
                                ' ORDER BY PERDESCONTO');
        if not aux.eof then
          result := result - ((VpaPerComissao * Aux.FieldByName('PERCOMISSAO').AsFloat)/100)
      end;
  end;
end;

{******** carrega os dados default na insercao do movimento do orcamento ******}
procedure TFuncoesCotacao.InseriNovoOrcamento(VpaMovOrcamento : TDataSet;VpaCodFilial,VpaLanOrcamento,VpaSeqProduto : Integer;
                                               VpaValorVenda : Double; VpaCodUnidade : String);
begin
  VpaMovOrcamento.insert;
  VpaMovOrcamento.FieldByName('I_EMP_FIL').AsInteger := VpaCodFilial;
  VpaMovOrcamento.FieldByName('I_LAN_ORC').AsInteger := VpaLanOrcamento;
  VpaMovOrcamento.FieldByName('I_Seq_Pro').AsInteger := VpaSeqProduto;
  VpaMovOrcamento.FieldByName('N_Vlr_Pro').AsFloat := VpaValorVenda;
  VpaMovOrcamento.FieldByName('N_QTD_PRO').AsFloat := 1;
  VpaMovOrcamento.FieldByName('C_COD_UNI').AsString := VpaCodUnidade;
  VpaMovOrcamento.FieldByname('D_ULT_ALT').AsDateTime := Date;
  VpaMovOrcamento.Post;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AdicionaDescontoCotacaoDePara(VpaDCotacaoDE,VpaDCotacaoPara : TRBDOrcamento);
begin
  if VpaDCotacaoDE.ValDesconto <> 0 then
    VpaDCotacaoPara.ValDesconto := VpaDCotacaoPara.ValDesconto + VpaDCotacaoDE.ValDesconto;
  if VpaDCotacaoDE.PerDesconto <> 0 then
    VpaDCotacaoPara.ValDesconto := VpaDCotacaoPara.ValDesconto +((VpaDCotacaoDE.ValTotalProdutos * VpaDCotacaoDE.PerDesconto)/100);
end;

{******************************************************************************}
procedure TFuncoesCotacao.AdicionaPaginasLogAlteracao(VpaDCotacao : TRBDOrcamento;VpaPaginas : TpageControl);
var
  VpfPagina : TTabSheet;
begin
  AdicionaSQLAbreTabela(Orcamento,'Select SEQESTAGIO FROM ESTAGIOORCAMENTO '+
                                  ' Where CODFILIAL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                                  ' AND SEQORCAMENTO = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                  ' AND CODESTAGIO = '+IntToStr(VARIA.EstagioCotacaoAlterada)+
                                  ' order by SEQESTAGIO');
  While not Orcamento.eof do
  begin
    VpfPagina := TTabSheet.Create(VpaPaginas);
    VpaPaginas.InsertControl(VpfPagina);
    VpfPagina.PageControl := VpaPaginas;
    VpfPagina.Tag := 9;
    VpfPagina.Caption := Orcamento.FieldByName('SEQESTAGIO').AsString;
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDOrcamento(VpaDOrcamento : TRBDOrcamento;VpaCodFilial : Integer = 0;VpaLanOrcamento : Integer = 0);
begin
  if VpaCodFilial <> 0 then
    VpaDOrcamento.CodEmpFil := VpaCodFilial;
  if VpaLanOrcamento <> 0 then
    VpaDOrcamento.LanOrcamento := VpaLanOrcamento;
  FreeTObjectsList(VpaDOrcamento.Produtos);
  FreeTObjectsList(VpaDOrcamento.Servicos);
  VpaDOrcamento.Produtos.Clear;
  VpaDOrcamento.Servicos.Clear;
  if VpaDOrcamento.CodEmpFil = 0 then
    VpaDOrcamento.CodEmpFil := varia.CodigoEmpFil;
  AdicionaSQLAbreTabela(Orcamento,'Select * from CADORCAMENTOS ORC, CADCLIENTES CLI '+
                                  ' Where ORC.I_EMP_FIL = '+IntToStr(VpaDOrcamento.CodEmpFil) +
                                  ' and ORC.I_LAN_ORC = '+ IntToStr(VpaDOrcamento.LanOrcamento)+
                                  ' AND ORC.I_COD_CLI = CLI.I_COD_CLI');
  with VpaDOrcamento do
  begin
    CodEmpFil := Orcamento.FieldByName('I_EMP_FIL').AsInteger;
    CodTipoOrcamento := Orcamento.FieldByName('I_TIP_ORC').AsInteger;
    CodRepresentada := Orcamento.FieldByName('I_COD_REP').AsInteger;
    CodUsuario := Orcamento.FieldByName('I_COD_USU').AsInteger;
    CodCliente := Orcamento.FieldByName('I_COD_CLI').AsInteger;
    CodClienteFaccionista := Orcamento.FieldByName('I_CLI_FAC').AsInteger;
    CodFormaPaqamento := Orcamento.FieldByName('I_COD_FRM').AsInteger;
    if CodFormaPaqamento = 0 then
      CodFormaPaqamento := Orcamento.FieldByName('I_FRM_PAG').AsInteger;
    IF CodFormaPaqamento = 0 then
      CodFormaPaqamento := Varia.FormaPagamentoPadrao;
    CodTecnico := Orcamento.FieldByName('I_COD_TEC').AsInteger;
    CodTabelaPreco := Orcamento.FieldByName('I_COD_TAB').AsInteger;
    CodVendedor := Orcamento.FieldByName('I_COD_VEN').AsInteger;
    CodPreposto := Orcamento.FieldByName('I_VEN_PRE').AsInteger;
    CodCondicaoPagamento := Orcamento.FieldByName('I_COD_PAG').AsInteger;
    CodEstagio := Orcamento.FieldByName('I_COD_EST').AsInteger;
    SeqNotaEntrada := Orcamento.FieldByName('I_NOT_ENT').AsInteger;
    PerComissao := Orcamento.FieldByName('N_PER_COM').AsFloat;
    PerComissaoPreposto := Orcamento.FieldByName('N_COM_PRE').AsFloat;
    ValTotal := Orcamento.FieldByName('N_VLR_TOT').AsFloat;
    ValTotalProdutos := Orcamento.FieldByName('N_VLR_PRO').AsFloat;
    ValTotalLiquido := Orcamento.FieldByName('N_VLR_LIQ').AsFloat;
    QtdProduto:= Orcamento.FieldByName('N_QTD_TPR').AsFloat;
    IndProcessada := NOT(Orcamento.FieldByName('C_IND_PRO').AsString = 'N');
    FinanceiroGerado := (Orcamento.FieldByName('C_GER_FIN').AsString = 'S');
    IndNotaGerada := (Orcamento.FieldByName('C_NOT_GER').AsString = 'S');
    NomContato := Orcamento.FieldByName('C_CON_ORC').AsString;
    NomSolicitante := Orcamento.FieldByName('C_NOM_SOL').AsString;
    DesEmail := Orcamento.FieldByName('C_DES_EMA').AsString;
    NomComputador := Orcamento.FieldByName('C_NOM_MIC').AsString;
    OrdemCompra := Orcamento.FieldByName('C_ORD_COM').AsString;
    OrdemCorte:= Orcamento.FieldByName('C_ORD_COR').AsString;
    NumCupomfiscal := Orcamento.FieldByName('C_NUM_CUF').AsString;
    DatOrcamento := Orcamento.FieldByName('D_DAT_ORC').AsDateTime;
    HorOrcamento := Orcamento.FieldByName('T_HOR_ORC').AsDateTime;
    DatPrevista := Orcamento.FieldByName('D_DAT_PRE').AsDateTime;
    HorPrevista :=  Orcamento.FieldByName('T_HOR_ENT').AsDateTime;
    DatValidade := Orcamento.FieldByName('D_DAT_VAL').AsDateTime;
    DesObservacao.Text := Orcamento.FieldByName('L_OBS_ORC').AsString;
    DesObservacaoFiscal := Orcamento.FieldByName('C_OBS_FIS').AsString;
    FlaSituacao := Orcamento.FieldByName('C_FLA_SIT').Asstring;
    NumNotas    := Orcamento.FieldByName('C_NRO_NOT').Asstring;
    CodTransportadora  := Orcamento.FieldByName('I_COD_TRA').AsInteger;
    CodRedespacho := Orcamento.FieldByName('I_COD_RED').AsInteger;
    PlaVeiculo := Orcamento.FieldByName('C_PLA_VEI').AsString;
    UFVeiculo    := Orcamento.FieldByName('C_EST_VEI').AsString;
    QtdVolumesTransportadora := Orcamento.FieldByName('N_QTD_TRA').AsInteger;
    EspTransportadora := Orcamento.FieldByName('C_ESP_TRA').AsString;
    MarTransportadora := Orcamento.FieldByName('C_MAR_TRA').AsString;
    NumTransportadora := Orcamento.FieldByName('I_NRO_TRA').AsInteger;
    PesBruto := Orcamento.FieldByName('N_PES_BRU').AsFloat;
    PesLiquido := Orcamento.FieldByName('N_PES_LIQ').AsFloat;
    OPImpressa := Orcamento.FieldByName('C_ORP_IMP').AsString = 'S';
    IndPendente := Orcamento.FieldByName('C_IND_PEN').AsString = 'S';
    IndRevenda := Orcamento.FieldByName('C_IND_REV').AsString = 'S';
    IndImpresso := Orcamento.FieldByName('C_IND_IMP').AsString = 'S';
    IndSinalPagamentoGerado := Orcamento.FieldByName('C_SIN_PAG').AsString = 'S';
    PerDesconto := Orcamento.FieldByName('N_PER_DES').AsFloat;
    ValDesconto := Orcamento.FieldByName('N_VLR_DES').AsFloat;
    TipFrete := Orcamento.FieldByName('I_TIP_FRE').AsInteger;
    ValTotalComDesconto := Orcamento.FieldByName('N_VLR_TTD').AsFloat;
    TipGrafica := Orcamento.FieldByName('I_TIP_GRA').AsInteger;
    ValTaxaEntrega := Orcamento.FieldByName('N_VAL_TAX').AsFloat;
    DesServico := Orcamento.FieldByName('C_DES_SER').AsString;
    IndNumeroBaixado := Orcamento.FieldByName('C_NUM_BAI').AsString = 'S';
    DesProblemaChamado := Orcamento.FieldByName('C_DES_CHA').AsString;
    DesServicoExecutado := Orcamento.FieldByName('C_SER_EXE').AsString;
    DesEnderecoAtendimento := Orcamento.FieldByName('C_END_ATE').AsString;
    ValDeslocamento := Orcamento.FieldByName('N_VLR_DSL').AsFloat;
    ValChamado := Orcamento.FieldByName('N_VLR_CHA').AsFloat;
    ValTroca := Orcamento.FieldByName('N_VLR_TRO').AsFloat;
    CodMedico := Orcamento.FieldByName('I_COD_MED').AsInteger;
    NumReceita := Orcamento.FieldByName('C_NUM_REC').AsString;
    DatReceita := Orcamento.FieldByName('D_DAT_REC').AsDateTime;
    TipReceita := Orcamento.FieldByName('I_TIP_REC').AsInteger;
    NumContadorOrdemOperacao := Orcamento.FieldByName('I_NUM_COO').AsInteger;
    UfEmbarque := Orcamento.FieldByName('C_EST_EMB').AsString;
    DesLocalEmbarque:= Orcamento.FieldByName('C_LOC_EMB').AsString;

    if Orcamento.FieldByName('C_ORI_PED').AsString = 'C'  then
      OrigemPedido := opCliente
    else
      if Orcamento.FieldByName('C_ORI_PED').AsString = 'C'  then
        OrigemPedido := opRepresentante
      else
        OrigemPedido := opNaoDigitado;

    if Orcamento.FieldByName('D_DAT_ENT').IsNull then
      DatEntrega := 0
    else
    begin
      DatEntrega := Orcamento.FieldByName('D_DAT_ENT').AsDateTime;
      HorPrevista := Orcamento.FieldByName('T_HOR_ENT').AsDateTime;
    end;
  end;
  CarDTipoOrcamento(VpaDOrcamento);
  VpaDOrcamento.CodOperacaoEstoque := Orcamento.FieldByName('I_COD_OPE').AsInteger;
  CarDOrcamentoProduto(VpaDOrcamento);
  CarDOrcamentoServico(VpaDOrcamento);

  Orcamento.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDParcelaOrcamento(VpaDOrcamento : TRBDOrcamento);
var
  VpfLaco : Integer;
begin
  VpaDOrcamento.Parcelas.Clear;
  if (VpaDOrcamento.FinanceiroGerado) and ((VpaDOrcamento.NumNotas = '') or (config.GerarFinanceiroCotacao)) then
  begin
     CarParcelasContasaReceber(VpaDOrcamento);
   end
   else
   begin
     CriaParcelas.Parcelas(VpaDOrcamento.ValTotalLiquido,VpaDOrcamento.CodCondicaoPagamento,true,Date);
     for VpfLaco := 0 to CriaParcelas.TextoParcelas.Count - 1 do
     begin
        VpaDOrcamento.Parcelas.Add(CentraStr(InttoStr(Vpflaco + 1),6) + ' - '+
                           CentraStr(CriaParcelas.TextoVencimentos.Strings[Vpflaco],10) + ' - ' +
                           AdicionaBrancoE(Formatfloat(Varia.MascaraMoeda,StrToFloat(DeletaChars(CriaParcelas.TextoParcelas.Strings[Vpflaco],'.'))),17));
     end;
   end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDtipoCotacao(VpaDTipoCotacao : TRBDTipoCotacao;VpaCodTipoCotacao : Integer);
begin
  AdicionaSQLAbreTabela(Orcamento,'Select * from CADTIPOORCAMENTO '+
                                  ' Where I_COD_TIP = '+IntToStr(VpaCodTipoCotacao));
  with VpaDTipoCotacao do
  begin
    CodTipo := VpaCodTipoCotacao;
    CodOperacaoEstoque := Orcamento.FieldByName('I_COD_OPE').AsInteger;
    CodVendedor := Orcamento.FieldByName('I_COD_VEN').AsInteger;
    NomTipo := Orcamento.FieldByName('C_NOM_TIP').AsString;
    CodPlanoContas := Orcamento.FieldByName('C_CLA_PLA').AsString;
    IndExigirDataEntregaPrevista := (Orcamento.FieldByName('C_IND_DAP').AsString = 'S');
    IndChamado := (Orcamento.FieldByName('C_IND_CHA').AsString = 'S');
    IndRevenda := (Orcamento.FieldByName('C_IND_REV').AsString = 'S');
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarComposeCombinacao(VpaDProCotacao : TRBDOrcProduto);
var
  VpfDCompose : TRBDOrcCompose;
begin
  FreeTObjectsList(VpaDProCotacao.Compose);
  AdicionaSQLAbreTabela(Orcamento,'select KIT.I_COR_REF, KIT.N_QTD_PRO, KIT.I_COD_COR, ' +
                                 ' PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_PRO, '+
                                 ' COR.COD_COR, NOM_COR ' +
                                 ' from MOVKIT KIT, CADPRODUTOS PRO, COR '+
                                 ' Where KIT.I_PRO_KIT = '+IntToStr(VpaDProCotacao.SeqProduto)+
                                 ' and KIT.I_COR_KIT = '+IntToStr(VpaDProCotacao.CodCor)+
                                 ' and KIT.I_COR_REF IS NOT NULL '+
                                 ' AND KIT.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                 ' AND KIT.I_COD_COR = COR.COD_COR '+
                                 ' ORDER BY KIT.I_COR_REF ');
  While not Orcamento.eof do
  begin
    if Orcamento.FieldByname('I_COR_REF').AsInteger <> 0 then
    begin
      VpfDCompose := VpaDProCotacao.AddCompose;
      VpfDCompose.SeqProduto := Orcamento.FieldByname('I_SEQ_PRO').AsInteger;
      VpfDCompose.CorRefencia := Orcamento.FieldByname('I_COR_REF').AsInteger;
      VpfDCompose.CodCor := Orcamento.FieldByname('COD_COR').AsInteger;
      VpfDCompose.CodProduto := Orcamento.FieldByname('C_COD_PRO').AsString;
      VpfDCompose.NomProduto := Orcamento.FieldByname('C_NOM_PRO').AsString;
      VpfDCompose.NomCor := Orcamento.FieldByname('NOM_COR').AsString;
    end;
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarCotacoesParaBaixarRomaneio(VpaDRomaneio: TRBDRomaneioOrcamento; VpaCotacoes: TList);
Var
  VpfLacoRomaneio, VpfLacoCotacao : Integer;
  VpfDItemRomaneio : TRBDRomaneioOrcamentoItem;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao : TRBDOrcProduto;
begin
  FreeTObjectsList(VpaCotacoes);
  for VpfLacoRomaneio := 0 to VpaDRomaneio.Produtos.Count - 1 do
  begin
    VpfDItemRomaneio := TRBDRomaneioOrcamentoItem(VpaDRomaneio.Produtos.Items[VpfLacoRomaneio]);
    VpfDCotacao := RCotacao(VpaCotacoes,VpfDItemRomaneio.CodFilialOrcamento,VpfDItemRomaneio.LanOrcamento);
    if VpfDCotacao = nil then
    begin
      VpfDCotacao := TRBDOrcamento.cria;
      FunCotacao.CarDOrcamento(VpfDCotacao,VpfDItemRomaneio.CodFilialOrcamento,VpfDItemRomaneio.LanOrcamento);
      VpaCotacoes.Add(VpfDCotacao);
    end;
    for VpfLacoCotacao := 0 to VpfDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoCotacao]);
      if (VpfDProCotacao.SeqProduto = VpfDItemRomaneio.SeqProduto) and
         (VpfDProCotacao.CodCor = VpfDItemRomaneio.CodCor) and
         (VpfDProCotacao.CodTamanho = VpfDItemRomaneio.CodTamanho) then
      begin
        VpfDProCotacao.QtdBaixadoNota := VpfDProCotacao.QtdBaixadoNota + VpfDItemRomaneio.QtdProduto;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarPrecosProdutosRevenda(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDProduto : TRBDOrcProduto;
begin
  for vpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpaDCotacao.IndRevenda then
      VpfDProduto.ValUnitario := VpfDProduto.ValRevenda
    else
      VpfDProduto.ValUnitario := VpfDProduto.ValUnitarioOriginal;
    VpfDProduto.ValTotal := VpfDProduto.QtdProduto * VpfDProduto.ValUnitario;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.CarRomaneioOrcamentoBaixaCotacao(VpaCodFilial,VpaCodRomaneio: Integer): TRBDOrcamento;
var
  VpfDCotacao, VpfDCotacaoRetorno : TRBDOrcamento;
  VpfDProdutoCotacao, VpfDProdutoDestino : TRBDOrcProduto;
  VpfCodFilialAtual,VpfLanOrcamentoAtual : Integer;
  VpfLaco : Integer;
  VpfDItemProduto : TRBDOrcProduto;
begin
  VpfDCotacaoRetorno := nil;
  VpfDCotacao := nil;
  AdicionaSQLAbreTabela(ProdutosNota,'Select ITE.CODFILIALORCAMENTO, ITE.LANORCAMENTO, ITE.SEQPRODUTO, ITE.CODCOR, '+
                                  ' ITE.CODTAMANHO, ITE.QTDPRODUTO '+
                                  ' FROM ROMANEIOORCAMENTOITEM ITE '+
                                  ' Where ITE.CODFILIAL = '+IntToStr(VpaCodFilial) +
                                  ' AND ITE.SEQROMANEIO = '+ IntToStr(VpaCodRomaneio)+
                                  ' ORDER BY CODFILIALORCAMENTO, LANORCAMENTO');
  VpfCodFilialAtual :=0;
  VpfLanOrcamentoAtual := 0;
  while not ProdutosNota.Eof do
  begin
    if VpfDCotacaoRetorno = nil then
    begin
      VpfDCotacaoRetorno := TRBDOrcamento.cria;
      CarDOrcamento(VpfDCotacaoRetorno,ProdutosNota.FieldByName('CODFILIALORCAMENTO').AsInteger,ProdutosNota.FieldByName('LANORCAMENTO').AsInteger);
      FreeTObjectsList(VpfDCotacaoRetorno.Produtos);
      VpfDCotacaoRetorno.OrdemCompra := '';
    end;
    if (VpfCodFilialAtual <> ProdutosNota.FieldByName('CODFILIALORCAMENTO').AsInteger) or
       (VpfLanOrcamentoAtual <> ProdutosNota.FieldByName('LANORCAMENTO').AsInteger)  then
    begin
      if VpfDCotacao <> nil then
        VpfDCotacao.Free;
      VpfDCotacao := TRBDOrcamento.cria;
      CarDOrcamento(VpfDCotacao,ProdutosNota.FieldByName('CODFILIALORCAMENTO').AsInteger,ProdutosNota.FieldByName('LANORCAMENTO').AsInteger);
      VpfCodFilialAtual := ProdutosNota.FieldByName('CODFILIALORCAMENTO').AsInteger;
      VpfLanOrcamentoAtual := ProdutosNota.FieldByName('LANORCAMENTO').AsInteger;
      VpfDCotacaoRetorno.OrdemCompra := VpfDCotacaoRetorno.OrdemCompra + VpfDCotacao.OrdemCompra;
    end;

    VpfDProdutoCotacao :=  RProdutoCotacao(VpfDCotacao,ProdutosNota.FieldByName('SEQPRODUTO').AsInteger,ProdutosNota.FieldByName('CODCOR').AsInteger,
                                  ProdutosNota.FieldByName('CODTAMANHO').AsInteger,0);
    if VpfDProdutoCotacao <> nil then
    begin
      VpfDProdutoDestino := VpfDCotacaoRetorno.AddProduto;
      CopiaDProdutoCotacao(VpfDProdutoCotacao,VpfDProdutoDestino);
      VpfDProdutoDestino.QtdABaixar := ProdutosNota.FieldByName('QTDPRODUTO').AsFloat;
    end;

    ProdutosNota.Next;
  end;
  ProdutosNota.Close;
  if VpfDCotacao <> nil then
    VpfDCotacao.Free;
  Result := VpfDCotacaoRetorno;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarServicoExecutadonaObsdaCotacao(VpaDCotacao: TRBDOrcamento;VpaDChamado : TRBDChamado);
var
  VpfLaco : Integer;
  VpfDProdutoChamado : TRBDChamadoProduto;
begin
  for Vpflaco := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProdutoChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
    if CONFIG.ObservacaoFiscalNaCotacao then
      VpaDCotacao.DesObservacaoFiscal := VpaDCotacao.DesObservacaoFiscal+VpfDProdutoChamado.DesServicoExecutado+#13
    else
      VpaDCotacao.DesObservacao.add(VpfDProdutoChamado.DesServicoExecutado)
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ClienteItemRomaneioValido(VpaDRomaneio: TRBDRomaneioOrcamento;VpaDRomaneioItem: TRBDRomaneioOrcamentoItem): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_CLI, C_ORD_COM FROM CADORCAMENTOS ' +
                            ' WHERE I_EMP_FIL = '+IntToStr(VpaDRomaneioItem.CodFilialOrcamento)+
                            ' AND I_LAN_ORC = '+IntToStr(VpaDRomaneioItem.LanOrcamento));
  VpaDRomaneioItem.DesOrdemCompraPedido := Aux.FieldByName('C_ORD_COM').AsString;
  if (VpaDRomaneioItem.DesOrdemCompra = '') and ( VpaDRomaneioItem.DesOrdemCompraPedido <> '') then
    VpaDRomaneioItem.DesOrdemCompra := VpaDRomaneioItem.DesOrdemCompraPedido;

  VpaDRomaneio.CodCliente := Aux.FieldByName('I_COD_CLI').AsInteger;
  if VpaDRomaneio.CodCliente <> 0 then
   result := True
  else
   result := false;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RPastaFTPVendedor(VpaCodVendedor: Integer): string;
begin
  result := '';
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select C_PAS_FTP from CADVENDEDORES '+
                              ' Where I_COD_VEN = ' +IntToStr(VpaCodVendedor));
    result := Aux.FieldByname('C_PAS_FTP').AsString;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RPrecoProdutoTabelaCliente(VpaSeqProduto,
  VpaCodCliente, VpaCodCor, VpaCodTamanho: Integer): Double;
begin
  AdicionaSQLAbreTabela(AUX1,'Select PRE.I_COD_CLI,  (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                            ' (Pre.N_VLR_REV * Moe.N_Vlr_Dia) VlrRevenda ' +
                            ' from MOVTABELAPRECO PRE, CADMOEDAS MOE '+
                            ' Where PRE.I_COD_MOE = MOE.I_COD_MOE '+
                            ' AND PRE.I_COD_MOE = '+IntToStr(Varia.MoedaBase) +
                            ' and PRE.I_COD_EMP = ' + IntToStr(VARIA.CodigoEmpresa)+
                            ' and PRE.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and PRE.I_COD_CLI in (0,'+ IntToStr(VpaCodCliente)+')'+
                            ' and PRE.I_COD_COR = ' + IntToStr(VpaCodCor)+
                            ' and PRE.I_COD_TAM = ' + IntToStr(VpaCodTamanho)+
                            ' ORDER BY PRE.I_COD_CLI DESC');
  Result := AUX1.FieldByName('VLRREAL').AsFloat;
  Aux1.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RProdutoCotacao(VpaDCotacao : TRBDOrcamento;VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer;VpaValUnitario : Double):TRBDOrcProduto;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDCotacao.Produtos.count - 1 do
  begin
    if (TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).SeqProduto = VpaSeqProduto) and
       (TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).CodCor = VpaCodCor) and
       (TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).CodTamanho = VpaCodTamanho) and
       ((TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).ValUnitario = VpaValUnitario) or (VpaValUnitario = 0))  then
      result := TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RServicoCotacao(VpaDCotacao : TRBDOrcamento; VpaCodServico : Integer): TRBDOrcServico;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
  begin
    if  TRBDOrcServico(VpaDCotacao.Servicos.Items[Vpflaco]).CodServico = VpaCodServico then
      result := TRBDOrcServico(VpaDCotacao.Servicos.Items[Vpflaco]);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RSeqNotaFiscalCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_NOT from MOVNOTAORCAMENTO '+
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_SEQ_NOT').AsInteger;
  aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RSeqOrcamentoRoteiroEntrega(
  VpaCodEntregador: integer): integer;
begin
  AdicionaSQLAbreTabela(CotCadastro, 'SELECT SEQORCAMENTOROTEIRO, CODENTREGADOR, DATABERTURA, DATBLOQUEIO '+
                                     ' FROM ORCAMENTOROTEIROENTREGA ' +
                                     ' WHERE CODENTREGADOR = ' + IntToStr(VpaCodEntregador) +
                                     ' AND DATFECHAMENTO IS NULL' +
                                     ' AND DATBLOQUEIO IS NULL ');

  if CotCadastro.FieldByName('SEQORCAMENTOROTEIRO').AsInteger = 0 then
  begin
    CotCadastro.insert;
    CotCadastro.FieldByName('SEQORCAMENTOROTEIRO').AsInteger := RProximoOrcamentoRoteiroDisponivel;
    CotCadastro.FieldByName('CODENTREGADOR').AsInteger := VpaCodEntregador;
    CotCadastro.FieldByName('DATABERTURA').AsDateTime := now;
    CotCadastro.post;
  end;
  result:= CotCadastro.FieldByName('SEQORCAMENTOROTEIRO').AsInteger;
  cotcadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RTipoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select I_TIP_ORC from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = ' +IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_TIP_ORC').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomClassificacao(
  VpaCodClassificacao: string): string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_CLA from CADCLASSIFICACAO '+
                            ' Where C_COD_CLA = ''' + VpaCodClassificacao+ '''');
  Result := aux.FieldByName('C_NOM_CLA').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomeEstagioAtualCotacao(VpaCodEstagio: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMEST from ESTAGIOPRODUCAO '+
                            ' Where CODEST = ' +IntToStr(VpaCodEstagio));
  result := Aux.FieldByName('NOMEST').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomeTipoOrcamento(VpaTipCotacao : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_TIP from CADTIPOORCAMENTO '+
                            ' Where I_COD_TIP = ' +IntToStr(VpaTipCotacao));
  Result := aux.FieldByName('C_NOM_TIP').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomFantasiaRepresentada(VpaCodRepresentada: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMFANTASIA FROM REPRESENTADA '+
                            ' Where CODREPRESENTADA = '+IntToStr(VpaCodRepresentada));
  Result := Aux.FieldByName('NOMFANTASIA').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RVendedorUltimaCotacao : Integer;
var
  VpfIni : TRegIniFile;
begin
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  result := VpfIni.ReadInteger('COTACAO','ULTIMOVENDEDOR',0);
  VpfIni.free;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomTransportadora(VpaCodTransportadora : Integer) : string;
begin
  Result := '';
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select C_NOM_CLI from CADCLIENTES ' +
                            ' Where I_COD_CLI = ' +IntToStr(VpaCodTransportadora));
    result := Aux.FieldByname('C_NOM_CLI').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomVendedor(VpaCodVendedor : Integer):string;
begin
  result := '';
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select C_NOM_VEN from CADVENDEDORES '+
                              ' Where I_COD_VEN = ' +IntToStr(VpaCodVendedor));
    result := Aux.FieldByname('C_NOM_VEN').AsString;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.REmailVencedor(VpaCodVendedor : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_DES_EMA from CADVENDEDORES '+
                            ' Where I_COD_VEN = '+IntToStr(VpaCodVendedor));
  result := Aux.FieldByname('C_DES_EMA').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RObservacaoCotacao(VpaNumCotacao, VpaCodFilial: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'Select L_OBS_ORC from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaNumCotacao));
  result := Aux.FieldByname('L_OBS_ORC').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ROrdemProducao(VpaCodFilial,VpaLanOrcamento, VpaItemOrcamento : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select SEQORD from ORDEMPRODUCAOCORPO '+
                            ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                            ' and NUMPED = '+IntToStr(VpaLanOrcamento)+
                            ' and ITEORC = '+IntToStr(VpaItemOrcamento));
  result := Aux.FieldByname('SEQORD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.VerificaBrindeCliente(VpadCotacao : TRBDOrcamento;VpaDItemCotacao :TRBDOrcProduto);
var
  VpfQtdBrinde : Double;
  VpfDItem : TRBDOrcProduto;
begin
  if (VpadCotacao.CodTipoOrcamento <> varia.TipoCotacaoContrato) and
     (VpadCotacao.CodTipoOrcamento <> varia.TipoCotacaoGarantia) and
     (VpadCotacao.CodTipoOrcamento <> varia.TipoCotacaoGarantia) THEN
  begin
    VpfQtdBrinde := RQtdBrindeProdutoCliente(VpadCotacao.CodCliente,VpaDItemCotacao.SeqProduto,VpaDItemCotacao.UM);
    if VpfQtdBrinde > 0 then
    begin
      VpaDItemCotacao.IndBrinde := true;
      if VpfQtdBrinde < VpaDItemCotacao.QtdProduto then
      begin
        VpfDItem := VpadCotacao.AddProduto;
        DuplicaDadosItemOrcamento(VpaDItemCotacao,VpfDItem);
        VpfDItem.IndBrinde := false;
        VpfDItem.QtdProduto := VpaDItemCotacao.QtdProduto - VpfQtdBrinde;
        if VpfDItem.ValUnitario = 0 then
          VpfDItem.ValUnitario := VpaDItemCotacao.ValUnitarioOriginal;
        VpaDItemCotacao.QtdProduto := VpfQtdBrinde;
      end;
      VpaDItemCotacao.QtdSaldoBrinde := VpfQtdBrinde - VpaDItemCotacao.QtdProduto;
      VpaDItemCotacao.ValUnitario := 0;
      VpaDItemCotacao.ValTotal := 0;
    end;
  end;

end;

{******************************************************************************}
function TFuncoesCotacao.VerificaProdutoDuplicado(VpaDCotacao : TRBDOrcamento;VpaDItemCotacao : TRBDOrcProduto):Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  if config.CodigoBarras then   //essa rotina funciona somente para leitor de codigo de barras, pois só testa a ultima inserção, se for alterado um item ele nào controla. Não tirar esse if, analisar beeeem a rotina antes.
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count -2 do
    begin
      if (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).SeqProduto = VpaDItemCotacao.SeqProduto) and
         (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).UM = VpaDItemCotacao.UM) and
         (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).DesRefCliente = VpaDItemCotacao.DesRefCliente)  then
      begin
        result := true;
        TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto +VpaDItemCotacao.QtdProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteProduto(VpaCodProduto : String;VpaCodTabelaPreco : Integer; VpaDProCotacao : TRBDOrcProduto;VpaDCotacao : TRBDOrcamento):Boolean;
begin
  result := false;
  if VpaCodTabelaPreco = 0 then
    VpaCodTabelaPreco := Varia.TabelaPreco;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Orcamento,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, PRO.N_RED_ICM,'+
                                  ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_KIT, PRO.C_IND_RET, PRO.C_IND_CRA, '+
                                  ' PRO.C_REG_MSM , PRO.I_PRI_ATI, PRO.N_PER_COM, PRO.I_IND_COV, PRO.I_MES_GAR, PRO.C_PRA_PRO, '+
                                  ' PRO.C_PAT_FOT, PRO.C_SUB_TRI, PRO.N_PER_ICM, PRO.N_PER_MAX,  '+
                                  ' PRE.I_COD_CLI, (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                                  ' (Pre.N_Vlr_REV * Moe.N_Vlr_Dia) VlrReVENDA, PRE.N_PER_MAX DESCONTOMAXIMOTABELAPRECO,' +
                                  ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                                  ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, QTD.N_QTD_FIS, QTD.N_VLR_CUS, ' +
                                  ' CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, CLA.C_ALT_QTD, CLA.N_PER_MAX DESCONTOMAXIMOCLASSIFICACAO '+
                                  ' from CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                                  ' MOVQDADEPRODUTO Qtd, CADCLASSIFICACAO CLA ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                                  ' and PRE.I_COD_TAB = '+IntToStr(VpaCodTabelaPreco)+
                                  ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                  ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(VpaDCotacao.CodEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and PRO.C_ATI_PRO = ''S'' '+
                                  ' and Pro.c_ven_avu = ''S'''+
                                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' and PRE.I_COD_CLI IN (0,'+IntToStr(VpaDCotacao.CodCliente)+')'+
                                  ' order by PRE.I_COD_CLI DESC',true);

    result := not Orcamento.Eof;
    if result then
    begin
      with VpaDProCotacao do
      begin
        UMOriginal := Orcamento.FieldByName('C_Cod_Uni').Asstring;
        UM := Orcamento.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := UM;
        ValUnitarioOriginal := Orcamento.FieldByName('VlrReal').AsFloat;
        QtdEstoque := Orcamento.FieldByName('QdadeReal').AsFloat;
        QtdMinima := Orcamento.FieldByName('N_QTD_Min').AsFloat;
        QtdPedido := Orcamento.FieldByName('N_QTD_Ped').AsFloat;
        QtdFiscal := Orcamento.FieldByName('N_QTD_FIS').AsFloat;
        CodProduto := Orcamento.FieldByName(Varia.CodigoProduto).Asstring;
        CodClassificacao := Orcamento.FieldByName('C_COD_CLA').Asstring;
        if (VpaDCotacao.IndRevenda or  VpaDCotacao.IndClienteRevenda) and (Orcamento.FieldByName('VlrRevenda').AsFloat <> 0) then
          ValUnitario := Orcamento.FieldByName('VlrRevenda').AsFloat
        else
          ValUnitario := Orcamento.FieldByName('VlrReal').AsFloat;
        if Config.RetornarPrecoProdutoUltimaTabelaPreco then
          ValUnitario:= RPrecoProdutoTabelaCliente(VpaDProCotacao.SeqProduto, VpaDCotacao.CodCliente, VpaDProCotacao.CodCor, VpaDProCotacao.CodTamanho);

        ValCustoUnitario := Orcamento.FieldByName('N_VLR_CUS').AsFloat;
        if (VpaDProCotacao.CodCor <> 0) or
           (VpaDProCotacao.CodTamanho <> 0)  then
          ValCustoUnitario := FunProdutos.RValorCusto(VpaDCotacao.CodEmpFil,VpaDProCotacao.SeqProduto,VpaDProCotacao.CodCor,VpaDProCotacao.CodTamanho);

        ValRevenda := Orcamento.FieldByName('VlrRevenda').AsFloat;
        QtdProduto := 1;
        QtdBaixadoNota := 0;
        QtdBaixadoEstoque := 0;
        QtdCancelado := 0;
        QtdKit := Orcamento.FieldByName('I_IND_COV').AsInteger;
        SeqProduto := Orcamento.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Orcamento.FieldByName('C_NOM_PRO').AsString;
        PesLiquido := Orcamento.FieldByName('N_PES_LIQ').AsFloat;
        PesBruto := Orcamento.FieldByName('N_PES_BRU').AsFloat;
        PerDesconto := Orcamento.FieldByName('N_PER_KIT').AsFloat;
        PerComissao := Orcamento.FieldByName('N_PER_COM').AsFloat;
        PerComissaoClassificacao := Orcamento.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
        PerICMS:= Orcamento.FieldByName('N_PER_ICM').AsFloat;
        RedICMS := Orcamento.FieldByName('N_RED_ICM').AsFloat;
        IndFaturar := (QtdFiscal > (QtdPedido * 2));
        IndRetornavel  := (Orcamento.FieldByName('C_IND_RET').AsString = 'S');
        IndCracha  := (Orcamento.FieldByName('C_IND_CRA').AsString = 'S');
        IndPermiteAlterarQtdnaSeparacao  := (Orcamento.FieldByName('C_ALT_QTD').AsString = 'S');
        IndSubstituicaoTributaria  := (Orcamento.FieldByName('C_SUB_TRI').AsString = 'S');
        IndBrinde := false;
        DesRegistroMSM := Orcamento.FieldByName('C_REG_MSM').AsString;
        QtdMesesGarantia := Orcamento.FieldByName('I_MES_GAR').AsInteger;
        CodPrincipioAtivo := Orcamento.FieldByName('I_PRI_ATI').AsInteger;
        PathFoto := Orcamento.FieldByName('C_PAT_FOT').AsString;
        DesPrateleira := Orcamento.FieldByName('C_PRA_PRO').AsString;

        if Orcamento.FieldByName('DESCONTOMAXIMOTABELAPRECO').AsFloat > 0 then
          PerDescontoMaximoPermitido := Orcamento.FieldByName('DESCONTOMAXIMOTABELAPRECO').AsFloat
        else
          if Orcamento.FieldByName('N_PER_MAX').AsFloat > 0 then
            PerDescontoMaximoPermitido := Orcamento.FieldByName('N_PER_MAX').AsFloat
          else
            if Orcamento.FieldByName('DESCONTOMAXIMOCLASSIFICACAO').AsFloat > 0 then
              PerDescontoMaximoPermitido := Orcamento.FieldByName('DESCONTOMAXIMOCLASSIFICACAO').AsFloat
            else
              PerDescontoMaximoPermitido := varia.DescontoMaximoNota;
        UnidadeParentes.free;
        UnidadeParentes := ValidaUnidade.UnidadesParentes(VpaDProCotacao.UMOriginal);
        if config.Farmacia then
          IndMedicamentoControlado := FunProdutos.PrincipioAtivoControlado(CodPrincipioAtivo);

        while not Orcamento.Eof do
        begin
          if Orcamento.FieldByName('I_COD_CLI').AsInteger = 0 then
            ValTabelaPreco := Orcamento.FieldByName('VlrReal').AsFloat;
          Orcamento.Next;
        end;
      end;
    end;
    Orcamento.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteServico(VpaCodServico : String;VpaDSerCotacao : TRBDOrcServico):Boolean;
begin
  result := false;
  if VpaCodServico <> '' then
  begin
    AdicionaSQLAbreTabela(Orcamento,'Select (Moe.N_Vlr_dia * Pre.N_Vlr_Ven) Valor, SER.C_NOM_SER, SER.I_COD_SER, '+
                           ' SER.N_PER_ISS, CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, '+
                           ' SER.I_COD_FIS '+
                           ' from cadservico Ser, MovTabelaPrecoServico Pre, CadMoedas Moe, CADCLASSIFICACAO CLA ' +
                           ' where Ser.I_Cod_ser = ' + VpaCodServico +
                           ' and Pre.I_Cod_ser = Ser.I_Cod_Ser ' +
                           ' and Pre.i_cod_emp = ' + IntToStr(varia.codigoEmpresa) +
                           ' and Pre.I_Cod_tab = '+ IntToStr(Varia.TabelaPrecoServico)+
                           ' and SER.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' and SER.C_COD_CLA = CLA.C_COD_CLA '+
                           ' and SER.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' and Moe.I_cod_Moe = Pre.I_Cod_Moe');

    result := not Orcamento.Eof;
    if result then
    begin
      with VpaDSerCotacao do
      begin
        NomServico := Orcamento.FieldByName('C_NOM_SER').AsString;
        CodFiscal := Orcamento.FieldByName('I_COD_FIS').AsInteger;
        CodClassificacao := Orcamento.FieldByName('C_COD_CLA').AsString;
        CodServico := Orcamento.FieldByName('I_COD_SER').AsInteger;
        QtdServico := 1;
        ValUnitario := Orcamento.FieldByName('Valor').AsFloat;
        PerISSQN := Orcamento.FieldByName('N_PER_ISS').AsFloat;
        PerComissaoClassificacao := Orcamento.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
      end;
    end;
    Orcamento.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.Existecor(VpaCodCor :String;VpaDProCotacao : TRBDOrcProduto) :Boolean;
begin
  result := false;
  if VpaCodCor <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              ' Where COD_COR = '+VpaCodCor );
    result := not Aux.eof;
    if result then
    begin
      VpaDProCotacao.CodCor := Aux.FieldByName('COD_COR').AsInteger;
      VpaDProCotacao.DesCor := Aux.FieldByName('NOM_COR').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteCotacao(VpaCodFilial, VpaLanOrcamento: Integer): boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_EMP_FIL FROM CADORCAMENTOS ' +
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  result := not Aux.Eof;
  aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteTamanho(VpaCodTamanho : String;var VpaNomTamanho : string):Boolean;
begin
  result := false;
  if VpaCodTamanho <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select CODTAMANHO, NOMTAMANHO FROM TAMANHO '+
                              ' Where CODTAMANHO = ' +VpaCodTamanho);
    Result := not Aux.Eof;
    if result then
      VpaNomTamanho := Aux.FieldByname('NOMTAMANHO').AsString;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteEmbalagem(VpaCodEmbalagem :String;VpaDProCotacao : TRBDOrcProduto):Boolean;
begin
  result := false;
  if VpaCodEmbalagem <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from EMBALAGEM '+
                              ' Where COD_EMBALAGEM = '+VpaCodEmbalagem );
    result := not Aux.eof;
    if result then
    begin
      VpaDProCotacao.CodEmbalagem := Aux.FieldByName('COD_EMBALAGEM').AsInteger;
      VpaDProCotacao.DesEmbalagem := Aux.FieldByName('NOM_EMBALAGEM').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteBaixaParcial(VpaDCotacao : TRBDOrcamento) : Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    if (TRBDOrcProduto(VpaDCotacao.produtos.Items[VpfLaco]).QtdABaixar <> 0) or
       (TRBDOrcProduto(VpaDCotacao.produtos.Items[VpfLaco]).QtdConferido <> 0) then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExtornaOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) :string;
var
  VpfAbriuTransacao : boolean;
  VpfDCotacao : TRBDOrcamento;
  VpfT : TTransactionDesc;
begin
  VpfDCotacao := TRBDOrcamento.cria;
  cardorcamento(VpfDCotacao,VpaCodFilial,VpaLanOrcamento);
  result := '';
  VpfAbriuTransacao := false;
  if not VprBaseDados.InTransaction then
  begin
    VpfT.IsolationLevel := xilREADCOMMITTED;
    VprBaseDados.StartTransaction(vpfT);
    VpfAbriuTransacao := true;
  end;
//Foi colocado em comentario pois na work quando é para extornar o orcamento não é para cancelar a nota.
//  result := ExtornaNotaOrcamento(VpaLanOrcamento);
  if result = '' then
  begin
    result := ExcluiFinanceiroOrcamento(VpaCodFilial,VpaLanOrcamento,0);
    if result = '' then
    begin
      IF VpfDCotacao.CodOperacaoEstoque <> 0 then
        result := EstornaEstoqueOrcamento(VpfDCotacao);
      if Result = '' then
      begin
        result := ExtornaBrindeCliente(VpfDCotacao);
        if result = '' then
        begin
          if Varia.EstagioCotacaoExtornada <> 0 then
            result := AlteraEstagioCotacao(VpfDCotacao.CodEmpFil,varia.CodigoUsuario,VpfDCotacao.LanOrcamento,varia.EstagioCotacaoExtornada,'Cotacao Extornada');
        end;
      end;
    end;
  end;

  if result = '' then
  begin
    BaixaReservaProdutoOrcamento(VpaCodFilial,VpaLanOrcamento);
    ExecutaComandoSql(Aux,'Update MovOrcamentos '+
                             ' Set C_Fla_Res = ''N''' +
                             ' , N_QTD_BAI = NULL '+
                             ' , N_BAI_EST = NULL '+
                             ' , N_QTD_CAN = NULL ' +
                             ' , D_DAT_GOP = NULL '+
                             ' , N_QTD_CON = NULL '+
                             ' Where I_Emp_Fil = '+ IntToStr(VpaCodFilial) +
                             ' and I_Lan_Orc = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                             ' Set C_GER_FIN = NULL ' +
                             ' , C_FLA_SIT = ''A'''+
                             ' , C_IND_CAN = ''N'''+
                             ' , D_DAT_ENT = NULL '+
                             ' , T_HOR_ENT = NULL '+
                             ' , C_NOT_GER = NULL '+
                             ' Where I_Emp_Fil = '+ IntToStr(VpaCodFilial) +
                             ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
  end;
  if result = '' then
  begin
    if VpfAbriuTransacao then
      VprBaseDados.Commit(vpfT);
  end
  else
  begin
    if  VpfAbriuTransacao then
      VprBaseDados.Rollback(VpfT);
    aviso(result);
  end;
  VpfDCotacao.free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CancelaOrcamento(VpacodFilial,VpaLanOrcamento : Integer);
var
  VpfResultado : String;
begin
  VpfResultado := ExtornaOrcamento(VpacodFilial,VpaLanOrcamento);
  if VpfResultado = '' then
  begin
    if Varia.EstagioCotacaoExtornada <> 0 then
      AlteraEstagioCotacao(VpaCodFilial,varia.CodigoUsuario,VpaLanOrcamento,varia.EstagioCotacaoExtornada,'Cotacao Cancelada');
    ExecutaComandoSql(Aux,'Update CadOrcamentos '+
                          ' Set C_IND_CAN = ''S''' +
                          ' Where I_Emp_Fil = ' + IntToStr(VpacodFilial)+
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFuncoesCotacao.CancelaSaldoCotacaoRomaneioBloqueado(VpaDRomaneio : TRBDRomaneioOrcamento): string;
var
  VpfDItemRomaneio : TRBDRomaneioOrcamentoItem;
  VpfLaco : Integer;
begin
  result := '';
  for VpfLaco := 0 to VpaDRomaneio.Produtos.Count -1 do
  begin
    VpfDItemRomaneio := TRBDRomaneioOrcamentoItem(VpaDRomaneio.Produtos.Items[VpfLaco]);
    AdicionaSQLAbreTabela(CotCadastro,'Select I_EMP_FIL, I_LAN_ORC, I_SEQ_MOV, N_QTD_CAN ' +
                                      ' from MOVORCAMENTOS ' +
                                      ' Where I_EMP_FIL = '+IntToStr(VpfDItemRomaneio.CodFilialOrcamento)+
                                      ' AND I_LAN_ORC = '+IntToStr(VpfDItemRomaneio.LanOrcamento)+
                                      ' AND I_SEQ_PRO = '+IntToStr(VpfDItemRomaneio.SeqProduto)+
                                      ' AND I_COD_COR = '+IntToStr(VpfDItemRomaneio.CodCor)+
                                      ' AND '+SQLTextoIsNull('I_COD_TAM','0')+' = '+IntToStr(VpfDItemRomaneio.CodTamanho));
    if  not CotCadastro.Eof then
    begin
      CotCadastro.Edit;
      CotCadastro.FieldByName('N_QTD_CAN').AsFloat := CotCadastro.FieldByName('N_QTD_CAN').AsFloat +VpfDItemRomaneio.QtdProduto;
      CotCadastro.Post;
      if CotCadastro.AErronaGravacao then
      begin
        Result := CotCadastro.AMensagemErroGravacao;
        break;
      end;
    end;
    CotCadastro.Close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.CancelaSaldoItemOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento : Integer):string;
var
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  CotCadastro.Edit;
  if (VARIA.CNPJFilial = CNPJ_MetalVidros) or (varia.CNPJFilial =  CNPJ_VIDROMAX) then
    CotCadastro.FieldByname('N_QTD_BAI').AsFloat := CotCadastro.FieldByname('N_QTD_PRO').AsFloat
  else
    CotCadastro.FieldByname('N_QTD_CAN').AsFloat := CotCadastro.FieldByname('N_QTD_PRO').AsFloat - CotCadastro.FieldByname('N_QTD_BAI').AsFloat;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
  if result = '' then
  begin
    //forcado gravar a cotaca para atualizar o c_fla_sit que controla a situacao do pedido se esta em aberto ou ja foi entregue;
    VpfDCotacao := TRBDOrcamento.cria;
    CarDOrcamento(VpfDCotacao,VpaCodFilial,VpaLanOrcamento);
    GravaDCotacao(VpfDCotacao,nil);
    VpfDCotacao.Free;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.cancelaFinanceiroNota(VpaCodigoFilial, VpaLanOrcamento : integer);
begin
  ExecutaComandoSql(Aux,'Update CADCONTASARECEBER '+
                        ' Set I_SEQ_NOT = NULL '+
                        ' , C_IND_CAD = ''S'''+
                        ' Where I_EMP_FIL = '+IntToStr(VpaCodigoFilial)+
                        ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
end;

{************************ reserva o produto ***********************************}
procedure TFuncoesCotacao.ReservaProduto(VpaSeqProduto, VpaUnidade : String;VpaCodfilial: Integer; VpaQtd : Double);
begin
   AdicionaSQLAbreTabela(aux,'Select N_Qtd_Res, Pro.C_Cod_Uni '+
                             ' from MovQdadeProduto Qtd, CadProdutos Pro' +
                             ' Where Qtd.I_Emp_Fil = ' + intToStr(VpaCodFilial) +
                             ' and Qtd.I_Seq_Pro = ' + VpaSeqProduto+
                             ' and Qtd.I_Seq_Pro =  Pro.I_Seq_Pro');
   ExecutaComandoSql(Aux,'Update MovQdadeProduto ' +
                         ' set N_Qtd_Res = ' + SubstituiStr(FormatFloat('##0.00',Aux.FieldByName('N_Qtd_Res').AsFloat +
                                              (VpaQtd * IndiceUnidade.Indice(VpaUnidade,Aux.FieldByName('C_Cod_Uni').Asstring,StrToInt(VpaSeqProduto),Varia.CodigoEmpresa))),',','.')+
                         ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(date) +
                         ' where I_Emp_Fil = ' + IntToStr(VpaCodfilial) +
                         ' and I_Seq_Pro = '+ VpaSeqProduto);
end;

{*************** baixa as reservas dos produtos orcamento *********************}
procedure TFuncoesCotacao.BaixaReservaProdutoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
begin
  AdicionaSQLAbreTabela(Orcamento,'Select * from MOVORCAMENTOS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_LAN_ORC = '+ Inttostr(VpaLanOrcamento));

  while not Orcamento.eof do
  begin
    if Uppercase(Orcamento.FieldByName('C_Fla_Res').Asstring) = 'S' Then
      Baixareserva(VpaCodFilial, Orcamento.FieldByName('I_Seq_Pro').AsInteger,Orcamento.FieldByName('C_Cod_Uni').Asstring,Orcamento.FieldByName('N_Qtd_Pro').AsFloat);
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
function TFuncoesCotacao.BloqueiaRomaneio(VpaCodFilial,VpaSeqRomaneio: Integer;VpaMotivo : String): string;
var
  VpfDRomaneio : TRBDRomaneioOrcamento;
  VpfTransacao : TTransactionDesc;
  VpfSeqRomaneioBloqueado : Integer;
begin
  VpfDRomaneio := TRBDRomaneioOrcamento.cria;
  CarDRomaneioOrcamento(VpfDRomaneio,VpaCodFilial,VpaSeqRomaneio);
  VpfSeqRomaneioBloqueado := RSeqRomaneioBloqueado(VpaCodFilial,VpfDRomaneio.CodCliente);

  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  VprBaseDados.StartTransaction(VpfTransacao);

  AdicionaSQLAbreTabela(CotCadastro,'Select * from ROMANEIOORCAMENTO ' +
                                    ' WHERE CODFILIAL = ' + IntToStr(VpaCodFilial)+
                                    ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio));
  CotCadastro.Edit;
  CotCadastro.FieldByName('INDBLOQUEADO').AsString := 'S';
  CotCadastro.FieldByName('DESMOTIVOBLOQUEIO').AsString := VpaMotivo;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.Close;
  if result = '' then
  begin
    result :=  CancelaSaldoCotacaoRomaneioBloqueado(VpfDRomaneio);
    if result = '' then
    begin
      if VpfSeqRomaneioBloqueado <> 0 then
      begin
        result := AgrupaRomaneioOrcamento(VpaCodFilial,VpfSeqRomaneioBloqueado,VpfDRomaneio);
      end;
    end;
  end;
  if result = '' then
    VprBaseDados.Commit(VpfTransacao);
  VpfDRomaneio.Free;
end;

{************************ baixa reserva dos produto ***************************}
procedure TFuncoesCotacao.BaixaReserva(VpaCodFilial, VpaSeqProduto : Integer; VpaUnidade : String; VpaQtd : Double);
begin
   AdicionaSQLAbreTabela(aux,'Select N_Qtd_Res, Pro.C_Cod_Uni '+
                             ' from MovQdadeProduto Qtd, CadProdutos Pro' +
                             ' Where Qtd.I_Emp_Fil = ' + intToStr(VpaCodFilial) +
                             ' and Qtd.I_Seq_Pro = ' + IntToStr(VpaSeqProduto)+
                             ' and Qtd.I_Seq_Pro =  Pro.I_Seq_Pro');
   ExecutaComandoSql(Aux,'Update MovQdadeProduto ' +
                         ' set N_Qtd_Res = ' + SubstituiStr(FormatFloat('##0.00',Aux.FieldByName('N_Qtd_Res').AsFloat -
                                              (VpaQtd * IndiceUnidade.Indice(VpaUnidade,Aux.FieldByName('C_Cod_Uni').Asstring,VpaSeqProduto,Varia.CodigoEmpresa))),',','.')+
                         ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE) +
                         ' where I_Emp_Fil = ' + IntToStr(VpaCodFilial) +
                         ' and I_Seq_Pro = '+ IntTostr(VpaSeqProduto));
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosEtiquetadosSeparados(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDItemCotacao.QtdABaixar <> 0 then
    begin
      if ((VpfDItemCotacao.QtdBaixadoNota + VpfDItemCotacao.QtdABaixar) >= VpfDItemCotacao.QtdProduto) then
      begin
        try
          ExecutaComandoSql(Aux,'Delete from PRODUTOETIQUETADOCOMPEDIDO ' +
                                ' Where CODFILIAL = '+ IntToStr(VpaDCotacao.CodEmpFil)+
                                 ' and LANORCAMENTO = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                ' and SEQMOVIMENTO = '+IntToStr(VpfDItemCotacao.SeqMovimento));
        except
          on e : exception do result :='ERRO NA BAIXA DOS PRODUTOS ETIQUETADOS!!!'#13+e.message;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosParcialCotacao(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
  VpfQtdBaixar : Double;
begin
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if (VpfDItemCotacao.QtdABaixar <> 0) or (VpfDItemCotacao.QtdConferido <> 0) then
    begin
      Aux.sql.clear;
      Aux.sql.add( 'UPDATE MOVORCAMENTOS ');
      if VpfDItemCotacao.QtdABaixar <> 0 then
        Aux.sql.add(' Set N_QTD_BAI = '+SqlTextoIsNull('N_QTD_BAI','0')+' + '+SubstituiStr(FormatFloat('0.00',VpfDItemCotacao.QtdABaixar),',','.'))
      else
        Aux.sql.add(' Set N_QTD_CON = '+SqlTextoIsNull('N_QTD_CON','0')+' + ' + SubstituiStr(FormatFloat('0.00',VpfDItemCotacao.QtdConferido),',','.'));
      Aux.sql.add(' WHERE I_EMP_FIL = '+ IntToStr(VpadCotacao.CodEmpFil)+
                  ' and I_LAN_ORC = '+ IntToStr(VpaDCotacao.LanOrcamento)+
                  ' AND I_SEQ_MOV = '+ IntToStr(VpfDItemCotacao.SeqMovimento));
      try
        Aux.ExecSQL;
      except
        on e : exception do
        begin
          result := 'ERRO NA BAIXA DA COTACAO!!!'#13+e.message;
        end;
      end;
    end;
  end;
end;

{***************** retorna o valor total do orcamento *************************}
function TFuncoesCotacao.RetornaValorTotalOrcamento(VpaMovOrcamento : TDataSet): Double;
begin
  result := 0;
  VpaMovOrcamento.first;
  while not VpaMovOrcamento.eof do
  begin
    Result := result + VpaMovOrcamento.FieldByName('N_Vlr_Tot').AsFloat;
    VpaMovOrcamento.next;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RFoneVendedor(VpaCodVendedor: Integer): string;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT C_FON_VEN FROM  CADVENDEDORES '+
                            ' Where I_COD_VEN = '+IntToStr(VpaCodVendedor));
  if Aux.FieldByname('C_FON_VEN').IsNull then
    Result := ''
  else
    Result := Aux.FieldByname('C_FON_VEN').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RMandaEmailEstagio(VpaDCodEstagio: integer): boolean;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT INDEMAIL FROM ESTAGIOPRODUCAO '+
                            ' Where CODEST = ' +IntToStr(VpaDCodEstagio));
  if aux.FieldByName('INDEMAIL').AsString = 'S' then
    Result:= true
  else
    Result:= false;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.BaixaEstoqueOrcamento(VpaDOrcamento : TRBDOrcamento);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDOrcamento.Produtos.count - 1 do
  begin
    TRBDOrcProduto(VpaDOrcamento.Produtos.Items[VpfLaco]).QtdBaixadoEstoque := TRBDOrcProduto(VpaDOrcamento.Produtos.Items[VpfLaco]).QtdProduto;
  end;
  if VpaDOrcamento.DatEntrega = 0 then
  begin
    VpaDOrcamento.DatEntrega := date;
  end;
  GravaDCotacao(VpaDOrcamento,nil);
end;

{************************* exclui o orcamento *********************************}
procedure TFuncoesCotacao.ExcluiOrcamento(VpaCodFilial, VpaLanOrcamento : Integer;VpaEstornarEstoque : Boolean = true);
var
  VpfResultado : String;
begin
  VpfResultado := '';
  if VpaEstornarEstoque then
    vpfResultado := ExtornaOrcamento(VpaCodFilial,VpaLanOrcamento);


  if VpfResultado = '' then
  begin
    ExcluiMovOrcamento(VpaCodFilial,VpaLanOrcamento);
    ExecutaComandoSql(Aux,'Delete from PROPOSTACOTACAO '+
                          ' Where CODFILIALORCAMENTO = '+ InttoStr(VpaCodFilial)+
                          ' and LANORCAMENTO = '+ IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from MOVNOTAORCAMENTO '+
                          ' Where I_EMP_FIL = '+ InttoStr(VpaCodFilial)+
                          ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ESTAGIOORCAMENTO '+
                          ' Where CODFILIAL = '+ InttoStr(VpaCodFilial)+
                          ' and SEQORCAMENTO = '+ IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALITEM '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from CONTRATOPROCESSADOITEM '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete FROM LEITURALOCACAOCORPO '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOEMAIL '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,' Update  PESOCARTUCHO '+
                          ' SET CODFILIAL = NULL '+
                          ' , LANORCAMENTO = NULL '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALCORPO '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOROTEIROENTREGAITEM '+
                          ' Where CODFILIALORCAMENTO = ' + InttoStr(VpaCodFilial) +
                          ' and SEQORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    sistema.GravaLogExclusao('CADORCAMENTOS','Select * from CadOrcamentos '+
                          ' Where I_Emp_Fil = ' + InttoStr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from CadOrcamentos '+
                          ' Where I_Emp_Fil = ' + InttoStr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntToStr(VpaLanOrcamento));
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiRomaneioOrcamento(VpaCodFilial,VpaSeqRomaneio: Integer): string;
begin
  result := '';
  sistema.GravaLogExclusao('ROMANEIOORCAMENTOITEM','Select * FROM ROMANEIOORCAMENTOITEM ' +
                        ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                        ' AND SEQROMANEIO =' +IntToStr(VpaSeqRomaneio)+
                        ' ORDER BY SEQITEM');
  sistema.GravaLogExclusao('ROMANEIOORCAMENTOITEM','Select * FROM ROMANEIOORCAMENTO ' +
                        ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                        ' AND SEQROMANEIO =' +IntToStr(VpaSeqRomaneio));
  ExecutaComandoSql(Aux,'DELETE FROM ROMANEIOORCAMENTOITEM ' +
                        ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                        ' AND SEQROMANEIO =' +IntToStr(VpaSeqRomaneio));
  ExecutaComandoSql(Aux,'DELETE FROM ROMANEIOORCAMENTO ' +
                        ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                        ' AND SEQROMANEIO =' +IntToStr(VpaSeqRomaneio));
end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiBaixaParcialCotacao(VpaCodFilial, VpaLanOrcamento, VpaSeqParcial : Integer) : string;
var
  VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
  VpfTransacao : TTransactionDesc;
begin
  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  VprBaseDados.StartTransaction(VpfTransacao);
  result := FunProdutos.OperacoesEstornoValidas;
  if result = '' then
  begin
    result := ExcluiFinanceiroOrcamento(VpaCodFilial,VpaLanOrcamento,VpaSeqParcial);
    if result = '' then
      result := DiminuiQtdProdutoCotacao(VpaCodFilial,VpaLanOrcamento,VpaSeqParcial);
    if result = '' then
    begin
      AdicionaSQLAbreTabela(Orcamento,'Select ITE.QTDPARCIAL, '+
                                      ' MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_VLR_PRO, MOV.C_COD_UNI, '+
                                      ' MOV.C_PRO_REF, PRO.C_COD_UNI UNIORIGINAL '+
                                      ' from ORCAMENTOPARCIALITEM ITE, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                                      ' Where ITE.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                      ' and ITE.LANORCAMENTO = '+ IntToStr(VpaLanOrcamento)+
                                      ' and ITE.SEQPARCIAL = '+IntToStr(VpaSeqParcial)+
                                      ' AND ITE.CODFILIAL = MOV.I_EMP_FIL '+
                                      ' AND ITE.LANORCAMENTO = MOV.I_LAN_ORC '+
                                      ' AND ITE.SEQMOVORCAMENTO = MOV.I_SEQ_MOV'+
                                      ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');
      While not Orcamento.eof do
      begin
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,0,VpaCodFilial,Orcamento.FieldByName('I_SEQ_PRO').AsInteger);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaCodFilial, varia.OperacaoEstoqueEstornoEntrada,0,
                                        VpaLanOrcamento ,VpaLanOrcamento ,varia.MoedaBase,Orcamento.FieldByName('I_COD_COR').AsInteger,
                                        Orcamento.FieldByName('I_COD_TAM').AsInteger,
                                        date,Orcamento.FieldByName('QTDPARCIAL').AsFloat,Orcamento.FieldByName('QTDPARCIAL').AsFloat * Orcamento.FieldByName('N_VLR_PRO').AsFloat,
                                        Orcamento.FieldByName('C_COD_UNI').AsString ,Orcamento.FieldByName('C_PRO_REF').AsString, false,VpfSeqEstoqueBarra);
        VpfDProduto.free;
        Orcamento.next;
      end;
      Orcamento.Close;
      ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALITEM '+
                            ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                            ' and LANORCAMENTO = '+ IntToStr(VpaLanOrcamento)+
                            ' and SEQPARCIAL = '+IntToStr(VpaSeqParcial));
      ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALCORPO '+
                            ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                            ' and LANORCAMENTO = '+ IntToStr(VpaLanOrcamento)+
                            ' and SEQPARCIAL = '+IntToStr(VpaSeqParcial));
    end;
  end;
  if result <> '' then
    VprBaseDados.Rollback(VpfTransacao)
  else
    VprBaseDados.Commit(VpfTransacao);

end;

{******************************************************************************}
function TFuncoesCotacao.GeraFinanceiro(VpaDOrcamento : TRBDOrcamento; VpaDCliente : TRBDCliente; VpaDContaReceber : TRBDContasCR;VpaFunContaAReceber : TFuncoesContasAReceber;var VpaResultado : String;VpaGravarRegistro, VpaSinalPagamento : Boolean;VpaMostrarParcela :Boolean=true):Boolean;
Var
  VpfClienteCriado : Boolean;
  VpfDVendedor : TRBDVendedor;
begin
  VpfClienteCriado := false;
  VpaResultado := '';
  if (VpaDOrcamento.CodPlanoContas <> '') and (VpaDOrcamento.ValTotal > 0) then
  begin
    if VpaDCliente = nil then
    begin
      VpaDCliente := TRBDCliente.cria;
      VpaDCliente.CodCliente := VpaDOrcamento.CodCliente;
      FunClientes.CarDCliente(VpaDCliente);
      VpfClienteCriado := true;
    end;

    VpaDContaReceber.CodEmpFil := VpaDOrcamento.CodEmpFil;
    VpaDContaReceber.NroNota := VpaDOrcamento.LanOrcamento;
    VpaDContaReceber.LanOrcamento := VpaDOrcamento.LanOrcamento;
    VpaDContaReceber.IndSinalPagamento := VpaSinalPagamento;
    VpaDContaReceber.SeqNota := 0;
    VpaDContaReceber.SeqParcialCotacao := 0;
    VpaDContaReceber.CodCondicaoPgto := VpaDOrcamento.CodCondicaoPagamento;
    VpaDContaReceber.CodCliente := VpaDOrcamento.CodCliente;
    VpaDContaReceber.CodFrmPagto := VpaDOrcamento.CodFormaPaqamento;
    VpaDContaReceber.NomCliente := VpaDCliente.NomCliente;
    VpaDContaReceber.NumContaCorrente := VpaDOrcamento.NumContaCorrente;
    if (VpaDOrcamento.CodFormaPaqamento = Varia.FormaPagamentoDeposito)and (VpaDCliente.ContaBancariaDeposito <> '') and
       (VpaDOrcamento.NumContaCorrente = '')then
      VpaDContaReceber.NumContaCorrente := VpaDCliente.ContaBancariaDeposito;
    VpaDContaReceber.CodMoeda :=  varia.MoedaBase;
    VpaDContaReceber.CodUsuario := varia.CodigoUsuario;
    VpaDContaReceber.DatMov := date; //VpaDOrcamento.DatOrcamento;
    if config.DataFinanceiroIgualDataCotacao then
      VpaDContaReceber.DatEmissao := VpaDOrcamento.DatOrcamento
    else
      VpaDContaReceber.DatEmissao := date;
    VpaDContaReceber.PlanoConta := VpaDOrcamento.CodPlanoContas;
    VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido;
    if not VpaSinalPagamento then
    begin
      if config.QuandoForQuartodeNotanoRomaneioFazeroValorFaltante then
      begin
        if VpaDCliente.IndQuarto then
          VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido * 0.75
        else
          if VpaDCliente.IndMeia then
            VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido * 0.5
          else
            if VpaDCliente.IndVintePorcento then
              VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido * 0.8
            else
              if VpaDCliente.IndDecimo then
                VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido * 0.9
              else
                VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido;
      end;
    end;
    VpaDContaReceber.PercentualDesAcr := 0;
    VpaDContaReceber.MostrarParcelas := VpaMostrarParcela;
    VpaDContaReceber.IndGerarComissao := true;
    VpaDContaReceber.CodVendedor := VpaDOrcamento.CodVendedor;

    // comissao
    if VpaDOrcamento.CodPreposto <> 0 then
    begin
      VpaDContaReceber.TipComissaoPreposto := 0;
      VpaDContaReceber.CodPreposto := VpaDOrcamento.CodPreposto;
      VpaDContaReceber.PerComissaoPreposto := VpaDOrcamento.PerComissaoPreposto;
      VpaDContaReceber.ValComissaoPreposto := RValComissao(VpaDOrcamento,VpaDContaReceber.TipComissaoPreposto,VpaDOrcamento.PerComissaoPreposto,0,VpaDCliente);
    end;

    // comissao
    if VpaDOrcamento.CodVendedor <> 0 then
    begin
      VpfDVendedor := TRBDVendedor.cria;
      FunVendedor.CarDVendedor(VpfDVendedor,VpaDOrcamento.CodVendedor);
      VpaDContaReceber.TipComissao := VpfDVendedor.TipComissao;
      VpaDContaReceber.TipValorComissao := VpfDVendedor.TipValorComissao;
      VpaDContaReceber.PerComissao := VpaDOrcamento.PerComissao;
      VpaDContaReceber.ValComissao := RValComissao(VpaDOrcamento,VpaDContaReceber.TipComissao,VpaDOrcamento.PerComissao,VpaDOrcamento.PerComissaoPreposto,VpaDCliente);
      if VpaDContaReceber.ValComissao = 0 then
        VpaDContaReceber.ValComissaoPreposto := 0;
      VpfDVendedor.Free;
    end;
    if VpaSinalPagamento  then
      VpaDContaReceber.EsconderConta := false
    else
      VpaDContaReceber.EsconderConta := true;
    result := VpaFunContaAReceber.CriaContasaReceber(VpaDContaReceber,VpaResultado,VpaGravarRegistro);
    VpaDOrcamento.CodFormaPaqamento := VpaDContaReceber.CodFrmPagto;
    //quando for para gerar o financeiro do valor faltante do 1/4 de nota inicializa novamente o valor total da cotaçao porque em seguida é chamada a rotina para salvar o valor total;
    if config.QuandoForQuartodeNotanoRomaneioFazeroValorFaltante then
      VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido
    else
      VpaDOrcamento.ValTotal := VpaDContaReceber.ValTotal;
    if result then
    begin
      VpaDOrcamento.FinanceiroGerado := true;
      VpaDOrcamento.IndCancelado := false;
      if VpaDContaReceber.ValUtilizadoCredito > 0 then
      begin
        VpaDOrcamento.DesObservacao.add('Abatido do Crédito "'+FormatFloat('R$ #,###,###,###,##0.00',VpaDContaReceber.ValUtilizadoCredito)+'". Saldo Crédito "'+FormatFloat('R$ #,###,###,###,##0.00',VpaDContaReceber.ValSaldoCreditoCliente)+'" - '+FormatDateTime('DD/MM/YYYY - HH:MM',now));
      end;
    end;

  end
  else
    result := true;
  if VpfClienteCriado then
    VpaDCliente.free;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraFinanceiroParcial(VpaDOrcamento : TRBDOrcamento;VpaFunContaAReceber : TFuncoesContasAReceber;VpaSeqParcial : Integer;var VpaResultado : String):Boolean;
Var
  VpfDContaReceber : TRBDContasCR;
  VpfDCliente : TRBDCliente;
begin
  VpaResultado := '';
  if VpaDOrcamento.CodPlanoContas <> '' then
  begin
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpaDOrcamento.CodCliente;
    FunClientes.CarDCliente(VpfDCliente,false,false);
    VpfDContaReceber := TRBDContasCR.Cria;
    VpfDContaReceber.CodEmpFil := VpaDOrcamento.CodEmpFil;
    VpfDContaReceber.NroNota := VpaDOrcamento.LanOrcamento;
    VpfDContaReceber.LanOrcamento := VpaDOrcamento.LanOrcamento;
    VpfDContaReceber.SeqNota := 0;
    VpfDContaReceber.SeqParcialCotacao := VpaSeqParcial;
    VpfDContaReceber.CodCondicaoPgto := VpaDOrcamento.CodCondicaoPagamento;
    VpfDContaReceber.CodCliente := VpaDOrcamento.CodCliente;
    VpfDContaReceber.CodFrmPagto := VpaDOrcamento.CodFormaPaqamento;
    VpfDContaReceber.CodMoeda :=  varia.MoedaBase;
    VpfDContaReceber.CodUsuario := varia.CodigoUsuario;
    VpfDContaReceber.DatMov := date; //VpaDOrcamento.DatOrcamento;
    VpfDContaReceber.DatEmissao := date;
    VpfDContaReceber.PlanoConta := VpaDOrcamento.CodPlanoContas;
    VpfDContaReceber.DesObservacao := 'Parcial "'+ IntToStr(VpaSeqParcial) +'" do Romaneio "'+IntToStr(VpaDOrcamento.LanOrcamento)+'"';
    if config.QuandoForQuartodeNotanoRomaneioFazeroValorFaltante then
    begin
      if VpfdCliente.IndQuarto then
        VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal * 0.75
      else
        if VpfDCliente.IndMeia then
          VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal * 0.5
        else
          if VpfDCliente.IndVintePorcento then
            VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal * 0.8
          else
            if VpfDCliente.IndDecimo then
              VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal * 0.9
            else
              VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal;
    end
    else
      VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal;

    VpfDContaReceber.PercentualDesAcr := 0;
    VpfDContaReceber.MostrarParcelas := true;
    VpfDContaReceber.IndGerarComissao := true;
    VpfDContaReceber.EsconderConta := true;
    VpfDContaReceber.CodVendedor := VpaDOrcamento.CodVendedor;

    if VpaDOrcamento.CodPreposto <> 0 then
    begin
      VpfDContaReceber.TipComissaoPreposto := 0;
      VpfDContaReceber.CodPreposto := VpaDOrcamento.CodPreposto;
      VpfDContaReceber.PerComissaoPreposto := VpaDOrcamento.PerComissaoPreposto;
      VpfDContaReceber.ValComissaoPreposto := RValComissao(VpaDOrcamento,VpfDContaReceber.TipComissaoPreposto,VpaDOrcamento.PerComissaoPreposto,0,VpfDCliente);
    end;

    // comissao
    if VpaDOrcamento.CodVendedor <> 0 then
    begin
      VpfDContaReceber.TipComissao := FunVendedor.RTipComissao(VpaDOrcamento.CodVendedor) ;
      VpfDContaReceber.PerComissao := VpaDOrcamento.PerComissao;
      VpfDContaReceber.ValComissao := RValComissao(VpaDOrcamento,VpfDContaReceber.TipComissao,VpaDOrcamento.PerComissao,VpaDOrcamento.PerComissaoPreposto,VpfDCliente);
    end
    else
    VpfDContaReceber.EsconderConta := true;
    if VpfDContaReceber.ValTotal <> 0 then
      result := VpaFunContaAReceber.CriaContasaReceber(VpfDContaReceber,VpaResultado,true);
    VpfDCliente.free;
  end
  else
    result := true;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraEstoqueProdutos(VpaDOrcamento : TRBDOrcamento; FunProduto : TFuncoesProduto;VpaGravarCotacao : Boolean=true):String;
var
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfLaco, VpfSeqEstoqueBarra : Integer;
  VpfIndice,VpfValTotalItem : Double;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if VpaDOrcamento.CodOperacaoEstoque <> 0 then
  begin
    if VpaDOrcamento.ValTotalProdutos > 0 then
      VpfIndice := ((VpaDOrcamento.ValTotal *100)/VpaDOrcamento.ValTotalProdutos)-100
    else
      VpfIndice := 0;
    for VpfLaco := 0 to VpaDOrcamento.Produtos.Count - 1 do
    begin
      VpfDProdutoOrc := TRBDOrcProduto(VpaDOrcamento.Produtos.Items[Vpflaco]);
      if (VpfDProdutoOrc.QtdProduto - VpfDProdutoOrc.QtdBaixadoEstoque) > 0 then
      begin
        VpfValTotalItem := (VpfDProdutoOrc.ValTotal);
        //adicina indide de acrescimo ou desconto conforme a cotacao
        VpfValTotalItem := VpfValTotalItem + ((VpfValTotalItem*VpfIndice)/100);
        VpfDProduto := TRBDProduto.Cria;
        FunProduto.CarDProduto(VpfDProduto,0,VpaDOrcamento.CodEmpFil,VpfDProdutoOrc.SeqProduto);
        FunProduto.BaixaProdutoEstoque(VpfDProduto, VpaDOrcamento.CodEmpFil,
                                        VpaDOrcamento.CodOperacaoEstoque,
                                        0,
                                        VpaDOrcamento.LanOrcamento,VpaDOrcamento.LanOrcamento,
                                        varia.MoedaBase, VpfDProdutoOrc.CodCor,VpfDProdutoOrc.CodTamanho, Date,
                                        (VpfDProdutoOrc.QtdProduto - VpfDProdutoOrc.QtdBaixadoEstoque),
                                        VpfValTotalItem,
                                        VpfDProdutoOrc.UM,
                                        VpfDProdutoOrc.DesRefCliente,false,VpfSeqEstoqueBarra);
        VpfDProdutoOrc.QtdBaixadoEstoque := VpfDProdutoOrc.QtdProduto;
        VpfDProduto.free;
      end;
    end;

    if VpaDOrcamento.DatEntrega = 0 then
    begin
      VpaDOrcamento.DatEntrega := date;
    end;
    if VpaGravarCotacao then
      GravaDCotacao(VpaDOrcamento,nil);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraContasAReceberDevolucaoCotacao(VpaDOrcamento : TRBDOrcamento; VpaValor : Double):String;
Var
  VpfDContaReceber : TRBDContasCR;
  VpfDCliente : TRBDCliente;
begin
  result := '';
  if VpaDOrcamento.CodPlanoContas <> '' then
  begin
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpaDOrcamento.CodCliente;
    FunClientes.CarDCliente(VpfDCliente);
    VpfDContaReceber := TRBDContasCR.Cria;
    VpfDContaReceber.CodEmpFil := VpaDOrcamento.CodEmpFil;
    VpfDContaReceber.NroNota := VpaDOrcamento.LanOrcamento;
    VpfDContaReceber.SeqNota := 0;
    VpfDContaReceber.CodCondicaoPgto := VpaDOrcamento.CodCondicaoPagamento;
    VpfDContaReceber.CodCliente := VpaDOrcamento.CodCliente;
    VpfDContaReceber.CodFrmPagto := VpaDOrcamento.CodFormaPaqamento;
    VpfDContaReceber.CodMoeda :=  varia.MoedaBase;
    VpfDContaReceber.CodUsuario := varia.CodigoUsuario;
    VpfDContaReceber.DatMov := VpaDOrcamento.DatOrcamento;
    VpfDContaReceber.DatEmissao := date;
    VpfDContaReceber.PlanoConta := VpaDOrcamento.CodPlanoContas;
    VpfDContaReceber.ValTotal := VpaValor;
    VpfDContaReceber.PercentualDesAcr := 0;
    VpfDContaReceber.MostrarParcelas := true;
    VpfDContaReceber.IndGerarComissao := true;
    VpfDContaReceber.DesObservacao := 'Conta gerada pelas trocas';
    VpfDContaReceber.CodVendedor := VpaDOrcamento.CodVendedor;

    // comissao
    if VpaDOrcamento.CodVendedor <> 0 then
    begin
      VpfDContaReceber.TipComissao := FunVendedor.RTipComissao(VpaDOrcamento.CodVendedor);
      VpfDContaReceber.PerComissao := VpaDOrcamento.PerComissao;
      VpfDContaReceber.ValComissao := RValComissao(VpaDOrcamento,VpfDContaReceber.TipComissao,VpaDOrcamento.PerComissao,0,VpfDCliente);
    end;
    VpfDContaReceber.EsconderConta := true;
    FunContasAReceber.CriaContasaReceber(VpfDContaReceber,result,true);
    VpfDCliente.Free;
  end;
end;


{******************************************************************************}
function TFuncoesCotacao.GeraContasaPagarDevolucaoCotacao(VpaDCotacao : TRBDOrcamento; VpaValor : Double):String;
var
  VpfDContasAPagar : TRBDContasaPagar;
begin
  result := '';
  VpfDContasAPagar := TRBDContasaPagar.create;
  VpfDContasAPagar.CodFilial := VpaDCotacao.CodEmpFil;
  VpfDContasAPagar.NumNota := VpaDCotacao.LanOrcamento;
  VpfDContasAPagar.SeqNota := 0;
  VpfDContasAPagar.CodFornecedor := VpaDCotacao.CodCliente;
  VpfDContasAPagar.CodFormaPagamento := varia.FormaPagamentoPadrao;
  VpfDContasAPagar.CodMoeda := varia.MoedaBase;
  VpfDContasAPagar.CodUsuario := varia.CodigoUsuario;
  VpfDContasAPagar.DatEmissao := date;
  VpfDContasAPagar.CodPlanoConta := varia.PlanoContasDevolucaoCotacao;
  VpfDContasAPagar.CodCondicaoPagamento := varia.CondPagtoVista;
  VpfDContasAPagar.ValParcela := VpaValor;
  VpfDContasAPagar.PerDescontoAcrescimo := 0;
  VpfDContasAPagar.IndBaixarConta := true;
  VpfDContasAPagar.IndMostrarParcelas := false;
  VpfDContasAPagar.IndEsconderConta := false;
  VpfDContasAPagar.DesTipFormaPAgamento := 'D';
  result :=  FunContasAPagar.CriaContaPagar(VpfDContasAPagar,nil);
  VpfDContasAPagar.Free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaFinanceiroGerado(VpaDOrcamento : TRBDOrcamento);
begin
  AdicionaSQLAbreTabela(CotCadastro,'Select * from CADORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDOrcamento.CodEmpFil)+
                                    ' AND I_LAN_ORC = '+IntToStr(VpaDOrcamento.LanOrcamento));
  CotCadastro.Edit;
  CotCadastro.FieldByName('C_GER_FIN').AsString := 'S';
  CotCadastro.FieldByName('I_COD_FRM').AsInteger := VpaDOrcamento.CodFormaPaqamento;
  CotCadastro.FieldByName('N_VLR_TOT').AsFloat := VpaDOrcamento.ValTotal;
  CotCadastro.FieldByName('C_ORP_IMP').AsString := 'S';
  CotCadastro.FieldByName('L_OBS_ORC').AsString := VpaDOrcamento.DesObservacao.Text;
  CotCadastro.Post;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOPImpressa(VpaCotacoes : TList);
var
  VpfLaco : Integer;
  VpfCotacoes : String;
begin
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_ORP_IMP = ''S'''+
                        ' Where I_EMP_FIL = '+InttoStr(TRBDOrcamento(VpaCotacoes.Items[VpfLaco]).CodEmpFil)+
                        ' and I_LAN_ORC = ' +InttoStr(TRBDOrcamento(VpaCotacoes.Items[VpfLaco]).LanOrcamento));
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOrcamentoImpresso1(VpaCodFilial,VpaLanOrcamento : Integer);
begin
  ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_IND_IMP = ''S'''+
                        ' Where I_EMP_FIL =  '+IntToStr(VpaCodfilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOrcamentoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
begin
  ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_IND_PRO = ''S'''+
                        ' Where I_EMP_FIL =  '+IntToStr(VpaCodfilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));

end;

{******************************************************************************}
function TFuncoesCotacao.SetaSinalPagamentoGerado(VpaDOrcamento: TRBDOrcamento): string;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from CADORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDOrcamento.CodEmpFil)+
                                    ' AND I_LAN_ORC = '+IntToStr(VpaDOrcamento.LanOrcamento));
  CotCadastro.Edit;
  CotCadastro.FieldByName('C_SIN_PAG').AsString := 'S';
  CotCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  CotCadastro.Post;
  CotCadastro.Close;
  Sistema.MarcaTabelaParaImportar('CADORCAMENTOS');
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOrcamentoNaoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
begin
  ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_IND_PRO = ''N'''+
                        ' Where I_EMP_FIL =  '+IntToStr(VpaCodfilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaDataOpGeradaProduto(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento, VpaSeqOrdemProducao : Integer);
begin
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' AND I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  CotCadastro.edit;
  CotCadastro.FieldByName('D_DAT_GOP').AsDateTime := now;
  CotCadastro.FieldByName('I_SEQ_ORD').AsInteger := VpaSeqOrdemProducao;
  CotCadastro.post;
  CotCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AtualizaDCliente(VpaDCotacao :TRBDOrcamento;VpaDCliente : TRBDCliente);
begin
  if ((VpaDCliente.NomContato = '') and (VpaDCotacao.NomContato <>  '')) or
     ((VpaDCliente.CodVendedor = 0) and (VpaDCotacao.CodVendedor <> 0)) or
     ((VpaDCliente.PerComissao = 0) and (VpaDCotacao.PerComissao <> 0)) or
     ((VpaDCliente.CodTecnico = 0 ) and (VpaDCotacao.CodTecnico <> 0)) then
  begin
    LocalizaCliente(CotCadastro,IntToStr(VpaDCotacao.CodCliente));
    CotCadastro.Edit;
    if (VpaDCliente.NomContato = '') and (VpaDCotacao.NomContato <>  '') then
      CotCadastro.FieldByName('C_CON_CLI').AsString := VpaDCotacao.NomContato;
    if (VpaDCliente.CodVendedor = 0) and (VpaDCotacao.CodVendedor <> 0) then
      CotCadastro.FieldByName('I_COD_VEN').AsInteger := VpaDCotacao.CodVendedor;
    if (VpaDCliente.PerComissao = 0) and (VpaDCotacao.PerComissao <> 0) then
      CotCadastro.FieldByName('I_PER_COM').AsFloat := VpaDCotacao.PerComissao;
    if (VpaDCliente.CodTecnico = 0 ) and (VpaDCotacao.CodTecnico <> 0) then
      CotCadaStro.FieldByName('I_COD_TEC').AsInteger := VpaDCotacao.CodTecnico;
    CotCadastro.post;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDCotacao(VpaDCotacao : TRBDOrcamento;VpaDCliente:TRBDCliente):String;
var
  VpfQtdGravacao : Integer;
begin
  result := '';
  ExcluiMovOrcamento(VpaDCotacao.CodEmpFil, VpaDCotacao.LanOrcamento);
  LocalizaCadOrcamento(CotCadastro,IntToStr(VpaDCotacao.CodEmpFil), IntToStr(VpaDCotacao.LanOrcamento));
  with VpaDCotacao do
  begin
    if LanOrcamento = 0 then
      CotCadastro.Insert
    else
    begin
      if CotCadastro.Eof then
        CotCadastro.Insert
      else
        CotCadastro.edit;
    end;
    if result = '' then
    begin
      with CotCadastro do
      begin
        FieldByName('I_EMP_FIL').AsInteger := CodEmpFil;
        FieldByName('I_TIP_ORC').AsInteger := CodTipoOrcamento;
        FieldByName('I_COD_USU').AsInteger := CodUsuario;
        FieldByName('I_COD_CLI').AsInteger := CodCliente;
        if CodClienteFaccionista <> 0 then
          FieldByName('I_CLI_FAC').AsInteger := CodClienteFaccionista;
        FieldByName('I_COD_TAB').AsInteger := CodTabelaPreco;
        FieldByName('I_COD_PAG').AsInteger := CodCondicaoPagamento;
        if CodEstagio <> 0 then
          FieldByName('I_COD_EST').AsInteger := CodEstagio
        else
          FieldByName('I_COD_EST').Clear;
        FieldByName('D_DAT_ORC').AsDateTime := DatOrcamento;
        FieldByName('T_HOR_ORC').AsDateTime := HorOrcamento;
        if FlaSituacao <> 'C' Then
          CarFlaSituacao(VpaDCotacao);
        if CodFormaPaqamento <> 0 then
          FieldByName('I_COD_FRM').AsInteger := CodFormaPaqamento
        else
          FieldByName('I_COD_FRM').Clear;
        if CodTecnico <> 0 then
          FieldByName('I_COD_TEC').AsInteger := CodTecnico
        else
          FieldByName('I_COD_TEC').Clear;
        if SeqNotaEntrada <> 0 then
          FieldByName('I_NOT_ENT').AsInteger := SeqNotaEntrada
        else
          FieldByName('I_NOT_ENT').Clear;
        FieldByName('C_FLA_SIT').Asstring := FlaSituacao;
        FieldByName('D_DAT_PRE').AsDateTime := DatPrevista;
        FieldByName('T_HOR_ENT').AsDateTime := HorPrevista;
        FieldByName('D_DAT_VAL').AsDateTime := DatValidade;
        if DatEntrega <> 0 then
        begin
          FieldByName('D_DAT_ENT').AsDateTime := DatEntrega;
        end;
        FieldByName('C_CON_ORC').Asstring := NomContato;
        FieldByName('C_NOM_SOL').Asstring := NomSolicitante;
        FieldByName('C_DES_EMA').Asstring := DesEmail;
        FieldByName('C_DES_SER').Asstring := DesServico;
        FieldByName('L_OBS_ORC').Asstring := DeletaChars(DesObservacao.Text,#9);
        FieldByName('C_OBS_FIS').Asstring := DeletaChars(DesObservacaoFiscal,#9);
        FieldByName('I_COD_VEN').AsInteger := CodVendedor;
        if CodPreposto <> 0 then
          FieldByName('I_VEN_PRE').AsInteger := CodPreposto
        else
          FieldByName('I_VEN_PRE').Clear;
        FieldByName('N_VLR_TOT').AsFloat := ValTotal;
        FieldByName('N_VLR_PRO').AsFloat := ValTotalProdutos;
        FieldByName('N_VLR_LIQ').AsFloat := ValTotalLiquido;
        FieldByName('N_QTD_TPR').AsFloat:= QtdProduto;
        FieldByName('N_PER_COM').AsFloat := PerComissao;
        FieldByName('N_COM_PRE').AsFloat := PerComissaoPreposto;

        FieldByName('C_ORD_COM').Asstring := OrdemCompra;
        FieldByName('C_ORD_COR').Asstring := OrdemCorte;
        FieldByName('C_NUM_CUF').Asstring := NumCupomfiscal;
        FieldByName('I_COD_OPE').AsInteger := CodOperacaoEstoque;
        FieldByName('I_TIP_GRA').AsInteger := TipGrafica;
        FieldByName('N_VAL_TAX').AsFloat := ValTaxaEntrega;
        FieldByName('C_DES_CHA').AsString := DesProblemaChamado;
        FieldByName('C_SER_EXE').AsString := DesServicoExecutado;
        FieldByName('C_END_ATE').AsString := DesEnderecoAtendimento;
        FieldByName('C_NOM_MIC').AsString := NomComputador;
        FieldByName('N_VLR_CHA').AsFloat := ValChamado;
        FieldByName('N_VLR_DSL').AsFloat := ValDeslocamento;

        if NumNotas <> '' then
          FieldByName('C_NRO_NOT').Asstring := NumNotas
        else
          FieldByName('C_NRO_NOT').Clear;

        if IndCancelado then
          FieldByName('C_IND_CAN').AsString := 'S'
        else
          FieldByName('C_IND_CAN').AsString := 'N';

        if IndProcessada then
          FieldByName('C_IND_PRO').AsString := 'S'
        else
          FieldByName('C_IND_PRO').AsString := 'N';

        if FinanceiroGerado then
          FieldByName('C_GER_FIN').AsString := 'S'
        else
          FieldByName('C_GER_FIN').clear;

        if IndNotaGerada then
          FieldByName('C_NOT_GER').AsString := 'S'
        else
          FieldByName('C_NOT_GER').Clear;

        if OPImpressa then
          FieldByName('C_ORP_IMP').AsString := 'S'
        else
          FieldByName('C_ORP_IMP').AsString := 'N';
        if IndImpresso then
          FieldByName('C_IND_IMP').AsString := 'S'
        else
          FieldByName('C_IND_IMP').AsString := 'N';
        CarFlaPendente(VpaDCotacao);
        if IndPendente then
          FieldByName('C_IND_PEN').AsString := 'S'
        else
          FieldByName('C_IND_PEN').AsString := 'N';
        if IndNumeroBaixado then
          FieldByName('C_NUM_BAI').AsString := 'S'
        else
          FieldByName('C_NUM_BAI').AsString := 'N';
        if IndRevenda then
          FieldByName('C_IND_REV').AsString := 'S'
        else
          FieldByName('C_IND_REV').AsString := 'N';
        if IndSinalPagamentoGerado then
          FieldByName('C_SIN_PAG').AsString := 'S'
        else
          FieldByName('C_SIN_PAG').AsString := 'N';

        FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;

        if CodTransportadora <> 0 then
          FieldByName('I_COD_TRA').AsInteger := CodTransportadora
        else
          FieldByName('I_COD_TRA').Clear;
        if CodRedespacho <> 0 then
          FieldByName('I_COD_RED').AsInteger := CodRedespacho
        else
          FieldByName('I_COD_RED').Clear;
        FieldByName('C_PLA_VEI').AsString := PlaVeiculo;
        FieldByName('C_EST_VEI').AsString := UFVeiculo;
        FieldByName('N_QTD_TRA').AsFloat := QtdVolumesTransportadora;
        FieldByName('C_ESP_TRA').AsString := EspTransportadora;
        FieldByName('C_MAR_TRA').AsString := MarTransportadora;
        FieldByName('I_NRO_TRA').AsInteger := NumTransportadora;
        FieldByName('N_PES_BRU').AsFloat := PesBruto;
        FieldByName('N_PES_LIQ').AsFloat := PesLiquido;
        FieldByName('N_PER_DES').AsFloat := PerDesconto;
        FieldByName('N_VLR_DES').AsFloat := ValDesconto;
        FieldByName('I_TIP_FRE').AsInteger := TipFrete;
        FieldByName('N_VLR_TTD').AsFloat := ValTotalComDesconto;
        FieldByName('N_VLR_TRO').AsFloat := ValTroca;
        if CodMedico <> 0 then
          FieldByName('I_COD_MED').AsInteger := CodMedico
        else
          FieldByName('I_COD_MED').Clear;
        FieldByName('C_NUM_REC').AsString := NumReceita;
        FieldByName('I_TIP_REC').AsInteger := TipReceita;
        if DatReceita > montadata(1,1,1900) then
          FieldByName('D_DAT_REC').AsDateTime := DatReceita
        else
          FieldByName('D_DAT_REC').Clear;
        if CodRepresentada <> 0 then
          FieldByName('I_COD_REP').AsInteger := CodRepresentada
        else
          FieldByName('I_COD_REP').Clear;

        FieldByName('C_VER_PED').AsString := VersaoSistemaPedido;
        FieldByName('C_COM_PED').AsString := Varia.NomeComputador;
        if VpaDCotacao.NumContadorOrdemOperacao <> 0 then
          FieldByName('I_NUM_COO').AsInteger := VpaDCotacao.NumContadorOrdemOperacao
        else
          FieldByName('I_NUM_COO').clear;
        case VpaDCotacao.OrigemPedido of
          opCliente: FieldByName('C_ORI_PED').AsString := 'C';
          opRepresentante: FieldByName('C_ORI_PED').AsString := 'R';
          opNaoDigitado: FieldByName('C_ORI_PED').AsString := 'N';
        end;

        if LanOrcamento = 0 then
        begin
          LanOrcamento := RProximoLanOrcamento(CodEmpFil);
          if varia.TipoBancoDados = bdRepresentante then
            FieldByName('C_FLA_EXP').AsString := 'N'
          else
            FieldByName('C_FLA_EXP').AsString := 'S';
        end;
        FieldByName('I_LAN_ORC').AsInteger := LanOrcamento;
        FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(CotCadastro);
        FieldByName('C_EST_EMB').AsString := UfEmbarque;
        FieldByName('C_LOC_EMB').AsString := DesLocalEmbarque;
        post;
        result := AMensagemErroGravacao;
        if not AErronaGravacao then
          LanOrcamento := FieldByName('I_LAN_ORC').AsInteger;
      end;
    end;
  end;
  CotCadastro.Close;
  Sistema.MarcaTabelaParaImportar('CADORCAMENTOS');
  if result = '' then
  begin
    result := GravaDProdutoCotacao(VpaDCotacao);
    if result = '' then
    begin
      result := GravaDServicoCotacao(VpaDCotacao);
      if result = '' then
      begin
        result := GravaDCompose(VpaDCotacao);
        if result = '' then
        begin
          result := FunClientes.CadastraProdutosCliente(VpaDCotacao);
          if result = '' then
          begin
            result := FunClientes.CadastraReferenciaCliente(VpaDCotacao);
          end;
        end;
      end;
    end;
  end;

  if result = '' then
    if VpaDCliente <> nil then
      AtualizaDCliente(VpaDCotacao,VpaDCliente);
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDProdutoCotacao(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDProCotacao : TRBDOrcProduto;
begin
  result := '';

  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = 11 AND I_LAN_ORC = 0');

  for VpfLaco := 0 to VpaDCotacao.Produtos.count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    CotCadastro.insert;
    if VpfDProCotacao.DatOrcamento < MontaData(1,1,1900) then
      VpfDProCotacao.DatOrcamento := VpaDCotacao.DatOrcamento+VpaDCotacao.HorOrcamento;
    CotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDCotacao.CodEmpFil;
    CotCadastro.FieldByName('I_LAN_ORC').AsInteger := VpaDCotacao.LanOrcamento;
    VpfDProCotacao.SeqMovimento := VpfLaco +1;
    CotCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfDProCotacao.SeqMovimento;
    CotCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfDProCotacao.SeqProduto;
    CotCadastro.FieldByName('N_VLR_PRO').AsFloat := VpfDProCotacao.ValUnitario;
    CotCadastro.FieldByName('N_QTD_PRO').AsFloat := VpfDProCotacao.QtdProduto;
    CotCadastro.FieldByName('N_QTD_CAN').AsFloat := VpfDProCotacao.QtdCancelado;
    CotCadastro.FieldByName('N_CUS_TOT').AsFloat := VpfDProCotacao.ValCustoTotal;
    CotCadastro.FieldByName('N_PER_DES').AsFloat := VpfDProCotacao.PerDesconto;
    If VpfDProCotacao.QtdBaixadoNota <> 0 then
      CotCadastro.FieldByName('N_QTD_BAI').AsFloat := VpfDProCotacao.QtdBaixadoNota
    else
      CotCadastro.FieldByName('N_QTD_BAI').Clear;
    If VpfDProCotacao.SeqOrdemProducao <> 0 then
      CotCadastro.FieldByName('I_SEQ_ORD').AsInteger := VpfDProCotacao.SeqOrdemProducao
    else
      CotCadastro.FieldByName('I_SEQ_ORD').Clear;
    If VpfDProCotacao.QtdBaixadoEstoque <> 0 then
      CotCadastro.FieldByName('N_BAI_EST').AsFloat := VpfDProCotacao.QtdBaixadoEstoque
    else
      CotCadastro.FieldByName('N_BAI_EST').Clear;

    if VpfDProCotacao.QtdConferidoSalvo <> 0 then
      CotCadastro.FieldByName('N_QTD_CON').AsFloat := VpfDProCotacao.QtdConferidoSalvo
    else
      CotCadastro.FieldByName('N_QTD_CON').Clear;

    if VpfDProCotacao.AltProdutonaGrade <> 0 then
      CotCadastro.FieldByName('N_ALT_PRO').AsFloat := VpfDProCotacao.AltProdutonaGrade
    else
      CotCadastro.FieldByName('N_ALT_PRO').Clear;
    CotCadastro.FieldByName('N_VLR_TOT').AsFloat := VpfDProCotacao.ValTotal;
    CotCadastro.FieldByName('C_COD_UNI').AsString := upperCase(VpfDProCotacao.UM);
    CotCadastro.FieldByName('C_IMP_FOT').AsString := VpfDProCotacao.IndImpFoto;
    CotCadastro.FieldByName('C_OBS_ORC').AsString := copy(VpfDProCotacao.DesObservacao,1,98);
    CotCadastro.FieldByName('C_COD_PRO').AsString := VpfDProCotacao.CodProduto;
    CotCadastro.FieldByName('C_ORD_COM').AsString := VpfDProCotacao.DesOrdemCompra;
    CotCadastro.FieldByName('C_ORD_COR').AsString := VpaDCotacao.OrdemCorte;
    CotCadastro.FieldByName('C_IMP_DES').AsString := VpfDProCotacao.IndImpDescricao;
    CotCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    CotCadastro.FieldByName('C_DES_COR').AsString := VpfDProCotacao.DesCor;
    CotCadastro.FieldByName('I_COD_COR').AsInteger := VpfDProCotacao.CodCor;
    CotCadastro.FieldByName('I_COD_EMB').AsInteger := VpfDProCotacao.CodEmbalagem;
    CotCadastro.FieldByName('C_DES_EMB').AsString := VpfDProCotacao.DesEmbalagem;
    CotCadastro.FieldByName('C_PRO_REF').AsString := VpfDProCotacao.DesRefCliente;
    CotCadastro.FieldByName('N_QTD_DEV').AsFloat := VpfDProCotacao.QtdDevolvido;
    CotCadastro.FieldByName('N_SAL_BRI').AsFloat := VpfDProCotacao.QtdSaldoBrinde;
    CotCadastro.FieldByName('D_DAT_ORC').AsDateTime := VpfDProCotacao.DatOrcamento;
    if VpfDProCotacao.CodTamanho <> 0 then
      CotCadastro.FieldByname('I_COD_TAM').AsInteger := VpfDProCotacao.CodTamanho
    else
      CotCadastro.FieldByname('I_COD_TAM').Clear;
    if VpfDProCotacao.IndFaturar then
      CotCadastro.FieldByName('C_IND_FAT').AsString := 'S'
    else
      CotCadastro.FieldByName('C_IND_FAT').AsString := 'N';
    if VpfDProCotacao.IndBrinde then
      CotCadastro.FieldByName('C_IND_BRI').AsString := 'S'
    else
      CotCadastro.FieldByName('C_IND_BRI').AsString := 'N';
    if VpfDProCotacao.DatOpGerada > MontaData(1,1,1900) then
      CotCadastro.FieldByName('D_DAT_GOP').AsDateTime := VpfDProCotacao.DatOpGerada
    else
      CotCadastro.FieldByName('D_DAT_GOP').clear;
    if VpfDProCotacao.DatAmostraAprovada > MontaData(1,1,1900) then
      CotCadastro.FieldByName('D_APR_AMO').AsDateTime := VpfDProCotacao.DatAmostraAprovada
    else
      CotCadastro.FieldByName('D_APR_AMO').clear;
    if config.PermiteAlteraNomeProdutonaCotacao then
      CotCadastro.FieldByName('C_NOM_PRO').AsString := copy(VpfDProCotacao.NomProduto,1,98);
    if VpfDProCotacao.CmpProduto <> 0 then
      CotCadastro.FieldByName('N_COM_PRO').AsFloat := VpfDProCotacao.CmpProduto
    else
      CotCadastro.FieldByName('N_COM_PRO').Clear;
    if VpfDProCotacao.QtdPecas <> 0 then
      CotCadastro.FieldByName('N_QTD_PEC').AsFloat := VpfDProCotacao.QtdPecas
    else
      CotCadastro.FieldByName('N_QTD_PEC').Clear;

    CotCadastro.post;
    Sistema.MarcaTabelaParaImportar('MOVORCAMENTOS');
    result := CotCadastro.AMensagemErroGravacao;
//Rotina colocada em comentário dia 23/05/2007 por não estar mais usando o indicador de reserva.
//    if (VpfDProCotacao.IndReservar = 'S') then
//      reservaProduto(IntToStr(VpfDProCotacao.SeqProduto),VpfDProCotacao.UM,VpfDProCotacao.QtdProduto);

    if (config.PrecoPorClienteAutomatico) and not(VpfDProCotacao.IndBrinde) then
      VerificaPrecoCliente(VpaDCotacao,VpfDProCotacao);
    if (VpaDCotacao.CodTipoOrcamento = VARIA.TipoCotacaoPedido) and
       (config.AprovarAutomaticamentoAmostrasnasVendas)  then
    begin
      result := AprovaAmostraOrcamento(VpfDProCotacao.SeqProduto);
    end;
    if result <> '' then
    begin
      cotCadastro.Close;
      break;
    end;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDRomaneioCotacao(VpaDRomaneio: TRBDRomaneioOrcamento): string;
begin
  result := '';
  if VpaDRomaneio.SeqRomaneio <> 0 then
  begin
    ExecutaComandoSql(Aux,'Delete from ROMANEIOORCAMENTOITEM ' +
                        ' Where CODFILIAL = ' +IntToStr(VpaDRomaneio.CodFilial)+
                        ' AND SEQROMANEIO = '+IntToStr(VpaDRomaneio.SeqRomaneio));
  end;
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ROMANEIOORCAMENTO ' +
                                    ' Where CODFILIAL = '+IntToStr(VpaDRomaneio.CodFilial)+
                                    ' and SEQROMANEIO = '+IntToStr(VpaDRomaneio.SeqRomaneio));
  if CotCadastro.Eof then
    CotCadastro.Insert
  else
    CotCadastro.Edit;
  CotCadastro.FieldByName('CODFILIAL').AsInteger := VpaDRomaneio.CodFilial;
  CotCadastro.FieldByName('DATINICIO').AsDateTime := VpaDRomaneio.DatInicio;
  if VpaDRomaneio.DatFim > MontaData(1,1,1900) then
    CotCadastro.FieldByName('DATFIM').AsDateTime := VpaDRomaneio.DatFim
  else
    CotCadastro.FieldByName('DATFIM').Clear;
  if VpaDRomaneio.NumNota <> 0 then
    CotCadastro.FieldByName('NUMNOTA').AsInteger := VpaDRomaneio.NumNota
  else
    CotCadastro.FieldByName('NUMNOTA').clear;
  if VpaDRomaneio.CodFilialNota <> 0 then
    CotCadastro.FieldByName('CODFILIALNOTA').AsInteger := VpaDRomaneio.CodFilialNota
  else
    CotCadastro.FieldByName('CODFILIALNOTA').clear;
  if VpaDRomaneio.SeqNota <> 0 then
    CotCadastro.FieldByName('SEQNOTA').AsInteger := VpaDRomaneio.SeqNota
  else
    CotCadastro.FieldByName('SEQNOTA').clear;
  CotCadastro.FieldByName('CODCLIENTE').AsInteger := VpaDRomaneio.CodCliente;
  CotCadastro.FieldByName('CODUSUARIO').AsInteger := VpaDRomaneio.CodUsuario;
  CotCadastro.FieldByName('QTDVOLUME').AsInteger := VpaDRomaneio.QtdVolume;
  CotCadastro.FieldByName('PESBRUTO').AsFloat := VpaDRomaneio.PesBruto;
  CotCadastro.FieldByName('VALTOTAL').AsFloat := VpaDRomaneio.ValTotal;
  if VpaDRomaneio.IndBloqueado then
    CotCadastro.FieldByName('INDBLOQUEADO').AsString := 'S'
  else
    CotCadastro.FieldByName('INDBLOQUEADO').AsString := 'N';
  if VpaDRomaneio.SeqRomaneio = 0 then
    VpaDRomaneio.SeqRomaneio := RProximoSeqRomaneioDisponivel(VpaDRomaneio.CodFilial);
  CotCadastro.FieldByName('SEQROMANEIO').AsInteger := VpaDRomaneio.SeqRomaneio;
  CotCadastro.Post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.Close;
  if result = ''  then
    result := GravaDRomaneioCotacaoItem(VpaDRomaneio);
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDRomaneioCotacaoItem(VpaDRomaneioCotacao: TRBDRomaneioOrcamento): string;
var
  VpfDItem : TRBDRomaneioOrcamentoItem;
  VpfLaco : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ROMANEIOORCAMENTOITEM ' +
                                ' Where CODFILIAL = 0 AND SEQROMANEIO = 0 AND SEQITEM = 0');
  result := '';
  for VpfLaco := 0 to VpaDRomaneioCotacao.Produtos.Count - 1 do
  begin
    VpfDItem := TRBDRomaneioOrcamentoItem(VpaDRomaneioCotacao.Produtos.Items[VpfLaco]);
    VpfDItem.SeqItem := VpfLaco + 1;
    CotCadastro.Insert;
    CotCadastro.FieldByName('CODFILIAL').AsInteger := VpaDRomaneioCotacao.CodFilial;
    CotCadastro.FieldByName('SEQROMANEIO').AsInteger := VpaDRomaneioCotacao.SeqRomaneio;
    CotCadastro.FieldByName('SEQITEM').AsInteger := VpfDItem.SeqItem;
    CotCadastro.FieldByName('CODFILIALORCAMENTO').AsInteger := VpfDItem.CodFilialOrcamento;
    CotCadastro.FieldByName('LANORCAMENTO').AsInteger := VpfDItem.LanOrcamento;
    CotCadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDItem.SeqProduto;
    if VpfDItem.CodCor <> 0 then
      CotCadastro.FieldByName('CODCOR').AsInteger := VpfDItem.CodCor;
    if VpfDItem.CodTamanho <> 0 then
      CotCadastro.FieldByName('CODTAMANHO').AsInteger := VpfDItem.CodTamanho;
    if VpfDItem.CodEmbalagem <> 0 then
      CotCadastro.FieldByName('CODEMBALAGEM').AsInteger := VpfDItem.CodEmbalagem;
    CotCadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDItem.QtdProduto;
    CotCadastro.FieldByName('QTDPEDIDO').AsFloat := VpfDItem.QtdPedido;
    CotCadastro.FieldByName('VALUNITARIO').AsFloat := VpfDItem.ValUnitario;
    CotCadastro.FieldByName('VALTOTAL').AsFloat := VpfDItem.ValTotal;
    CotCadastro.FieldByName('DESUM').AsString := VpfDItem.DesUM;
    CotCadastro.FieldByName('DESORDEMCOMPRA').AsString := VpfDItem.DesOrdemCompra;
    CotCadastro.FieldByName('DESREFERENCIACLIENTE').AsString := VpfDItem.DesReferenciaCliente;
    CotCadastro.FieldByName('DESORDEMCORTE').AsString := VpfDItem.DesOrdemCorte;
    CotCadastro.post;
    result := CotCadastro.AMensagemErroGravacao;
    if Result = '' then
    begin
      if VpfDItem.DesCodBarra <> '' then
       Result:= FunProdutos.GravaCodigoBarraProdutos(VpfDItem.CodFilialOrcamento, VpfDItem.SeqProduto, VpfDItem.CodCor, VpfDItem.CodTamanho, VpfDItem.DesCodBarra);
    end;
    if result <> ''  then
      break;
  end;
  CotCadastro.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDServicoCotacao(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDSerCotacao : TRBDOrcServico;
begin
  result := '';
  if VpaDCotacao.Servicos.count > 0  then
  begin

    AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVSERVICOORCAMENTO '+
                                    ' Where I_EMP_FIL = 11 AND I_LAN_ORC = 0 and I_SEQ_MOV = 0');

    for VpfLaco := 0 to VpaDCotacao.Servicos.count - 1 do
    begin
      VpfDSerCotacao := TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
      CotCadastro.insert;
      CotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDCotacao.CodEmpFil;
      CotCadastro.FieldByName('I_LAN_ORC').AsInteger := VpaDCotacao.LanOrcamento;
      CotCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfLaco+1;
      CotCadastro.FieldByName('I_COD_SER').AsInteger := VpfDSerCotacao.CodServico;
      CotCadastro.FieldByName('C_DES_ADI').AsString := VpfDSerCotacao.DesAdicional;
      CotCadastro.FieldByName('N_VLR_SER').AsFloat := VpfDSerCotacao.ValUnitario;
      CotCadastro.FieldByName('N_QTD_SER').AsFloat := VpfDSerCotacao.QtdServico;
      CotCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
      CotCadastro.FieldByName('N_VLR_TOT').AsFloat := VpfDSerCotacao.ValTotal;
      CotCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
      CotCadastro.post;
    end;
    CotCadastro.close;
    Sistema.MarcaTabelaParaImportar('MOVSERVICOORCAMENTO');
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaBaixaParcialCotacao(VpaDCotacao : TRBDOrcamento;Var VpaSeqParcial : Integer) : String;
var
  VpfLaco :Integer;
  VpfDItemProduto : TRBDOrcProduto;
  VpfDBaixaCorpo : TRBDOrcamentoParcial;
  VpfDBaixaItem : TRBDProdutoOrcParcial;
  VpfQtdBaixar : Double;
begin
  result := '';
  VpaSeqParcial := 0;
  if ExisteBaixaParcial(VpaDCotacao) then
  begin
    VpfDBaixaCorpo := GravaDBaixaParcialOrcamentoCorpo(VpaDCotacao);
    if VpfDBaixaCorpo = nil then
    begin
      result := 'ERRO NA GRAVAÇÃO DA TABELA ORCAMENTOPARCIALCORPO!!!'#13'Não foi possivel gravar a baixa parcial do produto.';
      exit;
    end;
    VpaSeqParcial := VpfDBaixaCorpo.SeqParcial;
    VpaDCotacao.ValTotalLiquido := VpfDBaixaCorpo.ValTotal;
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      vpfDItemProduto := TRBDOrcProduto(VpaDCotacao.Produtos.items[Vpflaco]);
      if (vpfDItemProduto.QtdABaixar <> 0) or (vpfDItemProduto.QtdConferido <> 0) then
      begin
        VpfDBaixaItem := VpaDCotacao.addProdutoBaixaParcial;
        VpfDBaixaItem.SeqMovOrcamento := VpfLaco +1 ;
        VpfDBaixaItem.SeqProduto := VpfDItemProduto.SeqProduto;
        VpfDBaixaItem.CodCor := VpfDItemProduto.CodCor;
        VpfDBaixaItem.DesUM := VpfDItemProduto.UM;
        VpfDBaixaItem.QtdParcial := VpfDItemProduto.QtdABaixar;
        VpfDBaixaItem.QtdConferido := VpfDItemProduto.QtdConferido;
        VpfDBaixaItem.ValProduto := VpfDItemProduto.ValUnitario;
        VpfDBaixaItem.ValTotal := VpfDItemProduto.QtdABaixar * VpfDItemProduto.ValUnitario;
        result := GravaDBaixaParcialOrcamentoItem(VpfDBaixaCorpo,VpfDBaixaItem);
        if result <> '' then
          exit;
      end;
    end;
    VpfDBaixaCorpo.free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDCompose(VpaDCotacao : TRBDOrcamento) : string;
var
  VpfLacoProduto, VpfLacoCompose : Integer;
  VpfDProduto : TRBDOrcProduto;
  VpfDCompose : TRBDOrcCompose;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from ORCAMENTOITEMCOMPOSE '+
                        ' Where CODFILIAL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and LANORCAMENTO = ' +IntToStr(VpaDCotacao.LanOrcamento));
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ORCAMENTOITEMCOMPOSE'+
                                    ' Where CODFILIAL = 11 AND LANORCAMENTO = 0');
  for VpfLacoProduto := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoProduto]);
    for VpfLacoCompose := 0 to VpfDProduto.Compose.Count - 1 do
    begin
      VpfDCompose := TRBDOrcCompose(VpfDProduto.Compose.Items[VpfLacoCompose]);
      VpfDCompose.SeqCompose := VpfLacoCompose +1;
      CotCadastro.insert;
      CotCadastro.FieldByname('CODFILIAL').AsInteger := VpaDCotacao.CodEmpFil;
      CotCadastro.FieldByname('LANORCAMENTO').AsInteger := VpaDCotacao.LanOrcamento;
      CotCadastro.FieldByname('SEQMOVIMENTO').AsInteger := VpfDProduto.SeqMovimento;
      CotCadastro.FieldByname('SEQCOMPOSE').AsInteger := VpfDCompose.SeqCompose;
      CotCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDCompose.SeqProduto;
      CotCadastro.FieldByname('CODCOR').AsInteger := VpfDCompose.CodCor;
      CotCadastro.FieldByname('CORREFERENCIA').AsInteger := VpfDCompose.CorRefencia;
      CotCadastro.post;
      result := CotCadastro.AMensagemErroGravacao;
      if CotCadastro.AErronaGravacao then
        break;
    end;
    if result <> '' then
      break;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraComplementoCotacao(VpaDCotacao : TRBDOrcamento;Var VpaLanOrcamentoRetorno : Integer) : string;
var
  VpfDCotacaoNova : TRBDOrcamento;
  VpfSeparacaoTotal : Boolean;
begin
  result := VerificaSeparacaoTotal(VpaDCotacao,VpfSeparacaoTotal);
  if result = '' then
  begin
    if VpfSeparacaoTotal then
    begin
      result := GravaDCotacao(VpaDCotacao,nil);
      VpaLanOrcamentoRetorno := VpaDCotacao.LanOrcamento;
      if result = ''then
        result := AlteraEstagioCotacao(VpaDCotacao.CodEmpFil,varia.CodigoUsuario,VpaDCotacao.LanOrcamento,varia.EstagioAguardandoEntrega,'');
    end
    else
    begin
      VpfDCotacaoNova := TRBDOrcamento.cria;
      CopiaDCotacao(VpaDCotacao,VpfDCotacaoNova,false);
      VpfDCotacaoNova.DatOrcamento := VpaDCotacao.DatOrcamento;
      VpfDCotacaoNova.HorOrcamento := VpaDCotacao.HorOrcamento;
      VpfDCotacaoNova.CodEstagio := varia.EstagioAguardandoEntrega;
      VpfDCotacaoNova.DesObservacao.Text := VpfDCotacaoNova.DesObservacao.Text+' Entrega Parcial do pedido '+IntToStr(VpaDCotacao.LanOrcamento);
      VpfDCotacaoNova.IndNotaGerada := false;
      VpfDCotacaoNova.IndCancelado := false;
      VpfDCotacaoNova.IndImpresso := false;

      result := BaixaProdutosASeparar(VpaDCotacao,VpfDCotacaoNova);
      if result = '' then
      begin
        if VpfDCotacaoNova.Produtos.Count > 0 then
        begin
          CalculaValorTotal(VpaDCotacao);
          CalculaValorTotal(VpfDCotacaoNova);
          if VpaDCotacao.Produtos.Count = 0 then
            ExcluiOrcamento(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento)
          else
            result := GravaDCotacao(VpaDCotacao,nil);

          if result = '' then
            Result := GravaDCotacao(VpfDCotacaoNova,nil);
          VpaLanOrcamentoRetorno := VpfDCotacaoNova.LanOrcamento;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaLogEstagio(VpaCodFilial,VpaLanOrcamento,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String) :string;
Var
  VpfLaco, VpfLacoItem : Integer;
  VpfNomArquivo : String;
begin
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ESTAGIOORCAMENTO '+
                                    ' Where CODFILIAL = 0 AND SEQORCAMENTO = 0 AND CODESTAGIO = 0 ' );
  CotCadastro.insert;
  CotCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  CotCadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaLanOrcamento;
  CotCadastro.FieldByName('CODESTAGIO').AsInteger := VpaCodEstagio;
  CotCadastro.FieldByName('DATESTAGIO').AsDateTime := Sistema.RDataServidor;
  CotCadastro.FieldByName('CODUSUARIO').AsInteger := VpaCodUsuario;
  if VpaDesMotivo <> '' then
    CotCadastro.FieldByName('DESMOTIVO').AsString := VpaDesMotivo;

  AdicionaSQLAbreTabela(Orcamento,'Select * from CADORCAMENTOS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  VpfNomArquivo := varia.PathVersoes+'\LOG\COTACAO\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaLanOrcamento)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'CAB.xml';
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  CotCadastro.FieldByname('LOGALTERACAO').AsString := CotCadastro.FieldByname('LOGALTERACAO').AsString+'CADORCAMENTOS="'+VpfNomArquivo+'"'+ #13;
  Orcamento.SAVETOFILE(VpfNomArquivo,dfxml);

  VpfNomArquivo := varia.PathVersoes+'\LOG\COTACAO\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaLanOrcamento)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'ITE.xml';
  AdicionaSQLAbreTabela(Orcamento,'Select * from MOVORCAMENTOS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  Orcamento.SAVETOFILE(VpfNomArquivo,dfxml);
  CotCadastro.FieldByname('LOGALTERACAO').AsString := CotCadastro.FieldByname('LOGALTERACAO').AsString+'MOVORCAMENTOS="'+VpfNomArquivo+'"'+ #13;

  CotCadastro.FieldByname('LOGALTERACAO').AsString := copy(CotCadastro.FieldByname('LOGALTERACAO').AsString,1,3500);
  CotCadastro.FieldByName('SEQESTAGIO').AsInteger := RProximoSeqEstagioOrcamento(VpaCodFilial,VpaLanOrcamento);
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaRoteiroEntrega(
  VpaDCotacao: TRBDOrcamento): string;
var
  VpfSeqRoteiroEntrega: integer;
begin
  VpfSeqRoteiroEntrega:= RSeqOrcamentoRoteiroEntrega(VpaDCotacao.CodTransportadora);

  AdicionaSQLAbreTabela(CotCadastro, 'SELECT * FROM ORCAMENTOROTEIROENTREGAITEM '+
                                     ' WHERE SEQORCAMENTOROTEIRO = 0 AND SEQORCAMENTO = 0 AND CODFILIALORCAMENTO = 0');
  CotCadastro.insert;
  CotCadastro.FieldByName('SEQORCAMENTOROTEIRO').AsInteger := VpfSeqRoteiroEntrega;
  CotCadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaDCotacao.LanOrcamento;
  CotCadastro.FieldByName('CODFILIALORCAMENTO').AsInteger:= VpaDCotacao.CodEmpFil;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaCartuchoCotacao(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
var
  VpfLaco : Integer;
  VpfDCartucho : TRBDCartuchoCotacao;
begin
  result := '';
  if varia.EstagioNaEntrega = 0 then
    result := 'ESTAGIO COTAÇÃO NA ENTREGA NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações do sistema o estágio da cotação que está na entrega.';
  if result = '' then
  begin
    for VpfLaco := 0 to  VpaCartuchos.Count - 1 do
    begin
      VpfDCartucho := TRBDCartuchoCotacao(VpaCartuchos.Items[Vpflaco]);
      AdicionaSQLAbreTabela(CotCadastro,'Select * from PESOCARTUCHO '+
                                        ' Where SEQCARTUCHO = '+IntToStr(VpfDCartucho.SeqCartucho));
      CotCadastro.edit;
      CotCadastro.FieldByname('CODFILIAL').AsInteger := VpfDCartucho.CodFilial;
      CotCadastro.FieldByname('LANORCAMENTO').AsInteger := VpfDCartucho.LanOrcamento;
      CotCadastro.post;
      result := CotCadastro.AMensagemErroGravacao;
      if CotCadastro.AErronaGravacao then
        break;
    end;
    CotCadastro.close;
    if result = '' then
    begin
      AlteraEstagioCotacao(VpaDCotacao.CodEmpFil,varia.CodigoUsuario,VpaDCotacao.LanOrcamento,Varia.EstagioAguardandoEntrega,'');
      if Result = '' then
      begin
        Result := BaixaEstoqueCartuchoAssociado(VpaDCotacao,VpaCartuchos);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.GravaVendedorUltimaCotacao(VpaCodVendedor : Integer);
var
  VpfIni : TRegIniFile;
begin
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  VpfIni.WriteInteger('COTACAO','ULTIMOVENDEDOR',VpaCodVendedor);
  VpfIni.free;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaVinculoCotacaoProposta(VpaDCotacao: TRBDOrcamento; VpaListaPropostas: TList): string;
var
  VpfLaco : Integer;
  VpfDProposta : TRBDPropostaCorpo;
begin
  result := '';
  for VpfLaco := 0 to VpaListaPropostas.Count - 1 do
  begin
    VpfDProposta := TRBDPropostaCorpo(VpaListaPropostas.Items[VpfLaco]);
    AdicionaSQLAbreTabela(CotCadastro,'Select * from PROPOSTACOTACAO ' +
                                      ' Where CODFILIALPROPOSTA = '+IntToStr(VpfDProposta.CodFilial)+
                                      ' AND SEQPROPOSTA = ' +IntToStr(VpfDProposta.SeqProposta)+
                                      ' AND CODFILIALORCAMENTO = ' +IntToStr(VpaDCotacao.CodEmpFil)+
                                      ' AND LANORCAMENTO = '+ IntToStr(VpaDCotacao.LanOrcamento));
    if CotCadastro.Eof then
      CotCadastro.Insert
    else
      CotCadastro.Edit;
    CotCadastro.FieldByName('CODFILIALPROPOSTA').AsInteger := VpfDProposta.CodFilial;
    CotCadastro.FieldByName('SEQPROPOSTA').AsInteger := VpfDProposta.SeqProposta;
    CotCadastro.FieldByName('CODFILIALORCAMENTO').AsInteger := VpaDCotacao.CodEmpFil;
    CotCadastro.FieldByName('LANORCAMENTO').AsInteger := VpaDCotacao.LanOrcamento;
    CotCadastro.Post;
    result := CotCadastro.AMensagemErroGravacao;
    if CotCadastro.AErronaGravacao then
      break;
  end;
  CotCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CalculaValorTotal(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfQtdBaixado : Double;
begin
  VpaDCotacao.ValTotal := 0;
  VpaDCotacao.ValTotalProdutos := 0;
  VpaDCotacao.ValTotalComDesconto := 0;
  VpaDCotacao.QtdProduto := 0;
  VpfQtdBaixado := 0;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacao.Produtos.items[VpfLaco]);
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal + VpfDProdutoOrc.ValTotal;
    VpaDCotacao.ValTotalProdutos := VpaDCotacao.ValTotalProdutos + VpfDProdutoOrc.ValTotal;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto + (VpfDProdutoOrc.ValTotal - ((VpfDProdutoOrc.ValTotal * VpfDProdutoOrc.PerDesconto)/100));
    VpaDCotacao.QtdProduto := VpaDCotacao.QtdProduto + VpfDProdutoOrc.QtdProduto;
    VpfQtdBaixado := VpfQtdBaixado + VpfDProdutoOrc.QtdBaixadoNota;
    VpfDProdutoOrc.ValCustoTotal := FunProdutos.CalculaValorPadrao(VpfDProdutoOrc.UM,VpfDProdutoOrc.UMOriginal,VpfDProdutoOrc.ValCustoUnitario,IntToStr(VpfDProdutoOrc.SeqProduto)) * VpfDProdutoOrc.QtdProduto;
  end;
  if VpfQtdBaixado = 0 then
    VpaDCotacao.IndNotaGerada := false;

  for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal + TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]).ValTotal;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto + TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]).ValTotal;
  end;
  VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotal;

  if VpaDCotacao.ValTaxaEntrega <> 0 then
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal + VpaDCotacao.ValTaxaEntrega;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto + VpaDCotacao.ValTaxaEntrega;
    VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido + VpaDCotacao.ValTaxaEntrega;
  end;
  if VpaDCotacao.ValTroca <> 0 then
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal - VpaDCotacao.ValTroca;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto - VpaDCotacao.ValTroca;
    VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido - VpaDCotacao.ValTroca;
  end;

  if VpaDCotacao.PerDesconto <> 0 then
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal - ((VpaDCotacao.ValTotal * VpaDCotacao.PerDesconto)/100);
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto - ((VpaDCotacao.ValTotalComDesconto * VpaDCotacao.PerDesconto)/100);
    VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido - ((VpaDCotacao.ValTotalLiquido * VpaDCotacao.PerDesconto)/100);
  end
  else
    if VpaDCotacao.ValDesconto <> 0 then
    begin
      VpaDCotacao.ValTotal := VpaDCotacao.ValTotal - VpaDCotacao.ValDesconto;
      VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto - VpaDCotacao.ValDesconto;
      VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido - VpaDCotacao.ValDesconto;
    end;

  if VpaDCotacao.CodCondicaoPagamento <> 0 then
  begin
    CriaParcelas.Parcelas(VpaDCotacao.ValTotal,VpaDCotacao.CodCondicaoPagamento,false,date);
    VpaDCotacao.ValTotal := CriaParcelas.valorTotal;
  end;
  if Config.DescontoNosProdutodaCotacao then
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotal;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CalculaValorTotalRomaneio(VpaDRomaneio: TRBDRomaneioOrcamento);
var
  VpfLaco : Integer;
  VpfDProRomaneio : TRBDRomaneioOrcamentoItem;
begin
  VpaDRomaneio.ValTotal := 0;
  for VpfLaco := 0 to VpaDRomaneio.Produtos.Count - 1 do
  begin
    VpfDProRomaneio := TRBDRomaneioOrcamentoItem(VpaDRomaneio.Produtos.Items[VpfLaco]);
    VpaDRomaneio.ValTotal := VpaDRomaneio.ValTotal + VpfDProRomaneio.ValTotal;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CalculaPesoLiquidoeBruto(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
begin
  VpaDCotacao.PesBruto := 0;
  VpaDCotacao.PesLiquido := 0;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpaDCotacao.PesBruto := VpaDCotacao.PesBruto + (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).PesBruto * TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto);
    VpaDCotacao.PesLiquido := VpaDCotacao.PesLiquido + (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).PesLiquido * TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto);
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraPrecoProdutosPorCliente(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
begin
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    FunProdutos.CarValVendaeRevendaProduto(VpaDCotacao.CodTabelaPreco,VpfDItemCotacao.SeqProduto,VpfDItemCotacao.CodCor,VpfDItemCotacao.CodTamanho,
                                                      VpaDCotacao.CodCliente,VpfDItemCotacao.ValUnitario,VpfDItemCotacao.ValRevenda,VpfDItemCotacao.ValTabelaPreco,VpfDItemCotacao.PerDescontoMaximoPermitido);
    VpfDItemCotacao.ValTotal :=  VpfDItemCotacao.ValUnitario * VpfDItemCotacao.QtdProduto;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AlteraEstagioCotacao(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer;VpaDesMotivo : String):String;
Var
  VpfDCotacao : trbdorcamento;
  VpfDCliente : TRBDCliente;
  VpfCodEstagioAtual : Integer;
begin
  result := '';
  VpfCodEstagioAtual := REstagioAtualCotacao(VpaCodFilial,VpaLanOrcamento);
//19/07/2011 - colocado em comentario pois na MLR estava gerando financeiro quando cancelava ou exclui a cotacao;
//  if VpaCodEstagio <> VpfCodEstagioAtual then
//    result := GeraFinanceiroEstagio(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio);

  if result = '' then
    result := GravaLogEstagio(VpaCodFilial,VpaLanOrcamento,VpaCodEstagio,VpaCodUsuario,VpaDesMotivo);

  if (result = '') and (VpaCodEstagio <> VpfCodEstagioAtual) then
  begin
    if (VpaCodEstagio = varia.EstagioFinalOrdemProducao) or EstagioFinal(VpaCodEstagio) then
    begin
      VpfDCotacao := TRBDOrcamento.cria;
      VpfDCotacao.CodEmpFil := VpaCodFilial;
      VpfDCotacao.LanOrcamento := VpaLanOrcamento;
      cardorcamento(VpfDCotacao);
      AdicionaFinanceiroArqRemessa(VpfDCotacao);
      VpfDCotacao.free;
    end;
    if (VpaCodEstagio = varia.EstagioOrdemProducao) then
      SetaOrcamentoNaoProcessado(VpaCodFilial,VpaLanOrcamento);
    ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS  set I_COD_EST = '+ IntToStr(VpaCodEstagio)+
                          ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                          ' AND I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  end;
    if (VpaCodEstagio = varia.EstagioFinalOrdemProducao) and (VpaCodEstagio <> VpfCodEstagioAtual) then
      BaixaCotacaoRoteiroEntrega(VpaCodFilial, VpaLanOrcamento);

    VpfDCotacao := TRBDOrcamento.cria;
    VpfDCotacao.CodEmpFil := VpaCodFilial;
    VpfDCotacao.LanOrcamento := VpaLanOrcamento;
    cardorcamento(VpfDCotacao);

    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpfDCotacao.CodCliente;
    FunClientes.CarDCliente(VpfDCliente,true);
    EnviaEmailClienteEstagio(VpfDCotacao, VpfDCliente);
end;

{******************************************************************************}
function TFuncoesCotacao.AlteraEstagioCotacoes(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaCotacoes, VpaDesMotivo : String):String;
Var
  VpfCotacao : Integer;
begin
  While length(VpaCotacoes) > 0 do
  begin
    VpfCotacao := strtoInt(CopiaAteChar(VpaCotacoes,','));
    VpaCotacoes := DeleteAteChar(VpaCotacoes,',');
    result := AlteraEstagioCotacao(VpaCodFilial,VpaCodUsuario,VpfCotacao,VpaCodEstagio,VpaDesMotivo);
    if result <> '' then
      exit;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AlteraEstagioCotacoes(VpaCotacoes: TList;VpaCodUsuario, VpaCodEstagio: Integer): string;
var
  VpfDCotacao : TRBDOrcamento;
  VpfLaco : Integer;
begin
  for Vpflaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    AlteraEstagioCotacao(VpfDCotacao.CodEmpFil,VpaCodUsuario, VpfDCotacao.LanOrcamento,VpaCodEstagio,'');
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraVendedor(VpaDCotacao : trbdorcamento);
begin
  ExecutaComandoSql(Aux,'update CADORCAMENTOS '+
                        ' set I_COD_VEN = '+IntToStr(VpaDCotacao.CodVendedor)+
                        ' Where I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento));
end;

{******************************************************************************}
function TFuncoesCotacao.AprovaAmostra(VpaCodFilial, VpaLanOrcamento, VpaSeqMovimento: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  CotCadastro.Edit;
  CotCadastro.FieldByname('D_APR_AMO').AsDateTime := Date;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
end;

function TFuncoesCotacao.AprovaAmostraOrcamento(VpaSeqProduto: Integer): string;
begin
  result := '';
end;

{******************************************************************************}
function TFuncoesCotacao.AsssociaCotacaoParcialRomaneioOrcamento(VpaCodFilial,VpaSeqRomaneio, VpaCodFilialCotacao, VpaLanOrcamento,VpaSeqParcial: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ROMANEIOORCAMENTO ' +
                                    ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                    ' AND SEQROMANEIO = ' +IntToStr(VpaSeqRomaneio));
  CotCadastro.Edit;
  CotCadastro.FieldByName('CODFILIALORCAMENTOBAIXA').AsInteger :=  VpaCodFilialCotacao;
  CotCadastro.FieldByName('LANORCAMENTOBAIXA').AsInteger := VpaLanOrcamento;
  CotCadastro.FieldByName('SEQORCAMENTOPARCIALBAIXA').AsInteger := VpaSeqParcial;
  CotCadastro.Post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraPreposto(VpaDCotacao : trbdorcamento);
var
  VpfComando : string;
begin
  if VpaDCotacao.CodPreposto <> 0 then
    VpfComando := ' set I_VEN_PRE = '+IntToStr(VpaDCotacao.CodPreposto)
  else
    VpfComando := ' SET I_VEN_PRE = NULL ';
  ExecutaComandoSql(Aux,'update CADORCAMENTOS '+
                         VpfComando +
                        ' Where I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraTipoCotacao(VpaDCotacao : TRBDOrcamento;VpaCodTipoCotacao : Integer);
begin
  ExecutaComandoSql(Aux,'update CADORCAMENTOS '+
                        ' set I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao)+
                        ' Where I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraTransportadora(VpaDCotacao : TRBDOrcamento;VpaCodTransportadora : Integer);
begin
  if (VpaCodTransportadora <> VpaDCotacao.CodTransportadora) and
     (VpaCodTransportadora <> 0) then
  begin
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                          ' SET I_COD_TRA = ' +IntToStr(VpaCodTransportadora)+
                          ' Where I_EMP_FIL = ' +IntToStr(VpaDCotacao.CodEmpFil)+
                          ' and I_LAN_ORC = ' +IntToStr(VpaDCotacao.LanOrcamento));

    VpaDCotacao.CodTransportadora:= VpaCodTransportadora;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AlteraCotacaoParaPedido(VpaDCotacao : TRBDOrcamento):string;
var
  VpfDTipoCotacao : TRBDTipoCotacao;
begin
  result := '';
  if Varia.TipoCotacaoPedido = 0 then
    result := 'TIPO COTAÇÃO PEDIDO NÃO PREENCHIDO!!!'#13'É necessário configurar o tipo da cotação pedido nas configurações dos produtos.';
  if result = '' then
  begin
    VpfDTipoCotacao := TRBDTipoCotacao.cria;

    VpaDCotacao.CodTipoOrcamento := varia.TipoCotacaoPedido;
    CarDtipoCotacao(VpfDTipoCotacao,varia.TipoCotacaoPedido);
    VpaDCotacao.CodOperacaoEstoque := VpfDTipoCotacao.CodOperacaoEstoque;
    VpaDCotacao.CodPlanoContas := VpfDTipoCotacao.CodPlanoContas;
    VpaDCotacao.DatOrcamento := date;
    VpaDCotacao.DatPrevista := date;
    result := GravaDCotacao(VpaDCotacao,nil);

    VpfDTipoCotacao.free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaAlteracaoCotacao(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : String;
var
  VpfValoraDevolver : Double;
  VpfDContasAReceber : TRBDContasCR;
begin

  VpfValoraDevolver := 0;
  if (VpaDCotacaoInicial.CodOperacaoEstoque <> 0) and (VpaDCotacao.CodOperacaoEstoque <> 0) then
    result := BaixaProdutosDevolvidos(VpaDCotacaoInicial, VpaDCotacao,VpfValoraDevolver) //baixas as devoluções e trocas
  else
    result := BaixaProdutosOrcamentoQueVirouVenda(VpaDCotacaoInicial, VpaDCotacao);    //baixa os produtos da cotacao que foi alterada de orcamento para venda ou vice versa
  if result = '' then
  begin
    if config.GerarFinanceiroCotacao then
    begin
      if (VpaDCotacao.ValTotal <> VpaDCotacaoInicial.ValTotal) or
         (VpaDCotacao.CodTipoOrcamento <> VpaDCotacaoInicial.CodTipoOrcamento) or
         (VpaDCotacao.CodCondicaoPagamento <> VpaDCotacaoInicial.CodCondicaoPagamento) or
         (VpaDCotacao.CodVendedor <> VpaDCotacaoInicial.CodVendedor) or
         (VpaDCotacao.CodCliente <> VpaDCotacaoInicial.CodCliente) or
         (config.RegerarFinanceiroQuandoCotacaoAlterada) or
         (VpaDCotacao.CodOperacaoEstoque <> VpaDCotacaoInicial.CodOperacaoEstoque) then
      begin
        result := ExcluiFinanceiroOrcamento(VpaDCotacaoInicial.CodEmpFil,VpaDCotacaoInicial.LanOrcamento,0);
        if (result = '') then
        begin
          if VpaDCotacao.CodPlanoContas <> '' then  //só gera financeiro se a cotação gerou estoque, senão é apenas um orcamento
          begin
            VpfDContasAReceber := TRBDContasCR.cria;
            if GeraFinanceiro(VpaDCotacao,VpaDCliente, VpfDContasAReceber,FunContasAReceber,result,true,false) then
            begin
              if Result = '' then
                SetaFinanceiroGerado(VpaDCotacao);
            end
            else
              result := 'FINANCEIRO NÃO GERADO!!!'#13'O contas a receber não foi gerado por cancelamento do usuário.';
            VpfDContasAReceber.free;
          end;
        end
        else
        begin
          if VpfValoraDevolver > 0 then
          begin
            if confirmacao('COTAÇÃO JÁ FOI PAGA!!!'#13'Esta cotação já foi paga, deseja devolver o dinheiro"'+FormatFloat('R$ #,###,###,##0.00',VpfValoraDevolver)+'"?') then
            begin
              result := '';
              GeraContasaPagarDevolucaoCotacao(VpaDCotacaoInicial,VpfValoraDevolver);
            end;
          end;
{ 15/11/2006
  Foi colocado em comentario pois o Anisio solicitou que se a parcela esteja paga nao permitir alterar a cotacao, antes
  é necessario extornar o contas a receber
        else
          if VpfValoraDevolver < 0 then
          begin
            if (VpaDCotacao.CodOperacaoEstoque <>  0)then //só gera financeiro se a cotação gerou estoque, senão é apenas um orcamento
              result := GeraContasAReceberDevolucaoCotacao(VpaDCotacaoInicial,VpfValoraDevolver * -1);
          end;}
        end;
      end; 
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaNumero(VpaCodFilial,VpaLanOrcamento : Integer):Boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(Aux,'Select C_NUM_BAI from CADORCAMENTOS '+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  if aux.FieldByName('C_NUM_BAI').AsString = 'S' then
    aviso('NUMERO JÁ SE ENCONTRA BAIXADO!!!'#13'Não foi possivel baixar o número pois o mesmo já foi baixado.')
  else
  begin
    result := true;
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' set C_NUM_BAI = ''S'''+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RValTotalOrcamento(VpaCodFilial,VpaLanOrcamento: Integer): Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select N_VLR_TOT from CADORCAMENTOS ' +
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = ' + IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('N_VLR_TOT').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RValTotalOrcamentoNoMovEstoque(VpaCodFilial,VpaLanOrcamento : Integer) : Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select SUM(N_VLR_MOV) TOTAL from MOVESTOQUEPRODUTOS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' AND I_LAN_ORC = '+ IntToStr(VpaLanOrcamento),true);
  result := Aux.FieldByName('TOTAL').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ZeraQtdBaixada(VpaDOrcamento : trbdorcamento);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDOrcamento.Produtos.count - 1 do
  begin
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).QtdBaixadoNota := 0;
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).QtdBaixadoEstoque := 0;
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).QtdDevolvido := 0;
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).DatOpGerada := 0;
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).DatAmostraAprovada := 0;
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).DatOrcamento := VpaDOrcamento.DatOrcamento;
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).QtdCancelado := 0;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.FaturarTodosProdutos(VpaDCotacao : TRBDOrcamento):Boolean;
var
  VpfLaco : Integer;
begin
  result := true;
  if config.EstoqueFiscal then
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.count - 1 do
    begin
      if TRBDOrcProduto(vpadCotacao.Produtos.Items[VpfLaco]).IndFaturar then
      begin
        result := false;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ImprimirBoletos(VpaCodFilial, VpaLanOrcamento : Integer;VpaDCliente : TRBDCliente;VpaImpressora : String);
var
  VpfFunImpressao : TImpressaoBoleto;
begin
  VpfFunImpressao := TImpressaoBoleto.cria(CotCadastro.ASQlConnection);
  AdicionaSQLAbreTabela(Orcamento,'Select MOV.I_EMP_FIL, MOV.I_COD_FRM, MOV.I_LAN_REC, MOV.I_NRO_PAR, CON.C_EMI_BOL '+
                                  ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV, CADCONTAS CON '+
                                  ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                  ' AND MOV.C_NRO_CON = CON.C_NRO_CON '+
                                  ' AND MOV.D_DAT_PAG IS NULL '+
                                  ' AND CAD.I_EMP_FIL = '+IntToStr(VpaCodfilial)+
                                  ' and CAD.I_LAN_ORC = '+IntToStr(VpaLanOrcamento));

  while not(Orcamento.Eof) and (Orcamento.FieldByName('C_EMI_BOL').AsString = 'T') do
  begin
    if (Orcamento.FieldByName('I_COD_FRM').AsInteger = varia.FormaPagamentoBoleto)then
      VpfFunImpressao.ImprimeBoleto(VpaCodFilial,Orcamento.FieldByName('I_LAN_REC').AsInteger,Orcamento.FieldByName('I_NRO_PAR').AsInteger,
                                  VpaDCliente,false,VpaImpressora,False);
    Orcamento.Next;
  end;
  VpfFunImpressao.free;
  orcamento.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteOpGerada(VpaCodFilial, VpaLanOrcamento : Integer;VpaAvisar : Boolean):Boolean;
begin
  result := false;
  if not config.AlterarCotacaoComOPGerada then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from ORDEMPRODUCAOCORPO '+
                              ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                              ' and LANORC = '+IntToStr(VpaLanOrcamento));
    result := not Aux.Eof;
    if result and VpaAvisar then
      aviso('ORDEM DE PRODUÇÃO GERADA!!!'#13'Não é possível completar a operação porque esta cotação possui ordens de produção geradas.');
    aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EnviaEmailCotacaoTransportadora(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
begin
  result := '';
  VpfEmailTexto := TIdText.Create(VprMensagem.MessageParts);
  VpfEmailTexto.ContentType := 'text/plain';
  MontaEmailCotacaoTexto(VpfEmailTexto.Body,VpaDCotacao,VpaDCliente);

  VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
  VpfEmailHTML.ContentType := 'text/html';
  MontaEmailCotacaoTexto(VpfEmailHTML.Body,VpaDCotacao,VpaDCliente);
  VpfEmailHTML.Body.Insert(0,'<html> <pre>');
  VpfEmailHTML.Body.Insert(VpfEmailHTML.Body.Count -1,'</pre></html>');

  VprMensagem.Recipients.EMailAddresses := FunClientes.REmailCliente(VpaDCotacao.CodTransportadora) ;
  VprMensagem.Subject := 'Cotação ' +IntToStr(VpaDCotacao.LanOrcamento);
  result := EnviaEmail(VprMensagem,VprSMTP);
  if result = '' then
    Result:= GravaDEmail(VpaDCotacao,REmailTransportadora(VpaDCotacao.CodTransportadora));
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDEmail(VpaDCotacao: TRBDOrcamento;VpaDesEmail : String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CotCadastro,'SELECT * FROM ORCAMENTOEMAIL');
  CotCadastro.Insert;

  CotCadastro.FieldByName('CODFILIAL').AsInteger:= VpaDCotacao.CodEmpFil;
  CotCadastro.FieldByName('LANORCAMENTO').AsInteger:= VpaDCotacao.LanOrcamento;
  CotCadastro.FieldByName('SEQEMAIL').AsInteger:= RSeqEmailDisponivel(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento);
  CotCadastro.FieldByName('DATEMAIL').AsDateTime:= Now;
  CotCadastro.FieldByName('DESEMAIL').AsString:= VpaDesEmail;
  CotCadastro.FieldByName('CODUSUARIO').AsInteger:= Varia.CodigoUsuario;

  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
function TFuncoesCotacao.RSePedidoFoiImpresso(VpaCodFilial,
  VpaLanOrcamento: Integer): boolean;
begin
  aux.SQL.Clear;
  AdicionaSQLAbreTabela(Aux,'Select C_IND_IMP FROM CADORCAMENTOS '+
                            ' Where I_EMP_FIL =  '+IntToStr(VpaCodfilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  if aux.FieldByName('C_IND_IMP').AsString = 'S' then
    result:= true
  else
    result:= false;

  aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RSeqEmailDisponivel(VpaCodFilial, VpaLanOrcamento : Integer ): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQEMAIL) PROXIMO '+
                            ' FROM ORCAMENTOEMAIL'+
                            ' Where CODFILIAL = ' + IntToStr(VpaCodFilial)+
                            ' and LANORCAMENTO = ' +IntToStr(VpaLanOrcamento));
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
end;

{******************************************************************************}
function TFuncoesCotacao.RValComissao(VpaDCotacao : TRBDOrcamento;VpaTipComissao : Integer;VpaPerComissao, VpaPerComissaoPreposto : Double;VpaDCliente : TRBDCliente):Double;
var
  VpfLaco : Integer;
  VpfDProdutoCotacao : TRBDOrcProduto;
  VpfDServicoCotacao : TRBDOrcServico;
  VpfCodClassificacao : String;
  VpfPerComissaoVendedor, VpfValTotalProdutos : Double;
begin
  result := 0;
  if VpaTipComissao = 0 then //comissao direta;
    result := (VpaDCotacao.ValTotalLiquido * (VpaPerComissao - VpaPerComissaoPreposto))/100
  else
  begin
    VpfCodClassificacao := '';
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProdutoCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      if VpfDProdutoCotacao.PerComissao <> 0 then
        VpfPerComissaoVendedor := VpfDProdutoCotacao.PerComissao
      else
      begin
        if VpfCodClassificacao <> VpfDProdutoCotacao.CodClassificacao then
        begin
          VpfCodClassificacao := VpfDProdutoCotacao.CodClassificacao;
          VpfPerComissaoVendedor := FunVendedor.RPerComissaoVendedorClassificacao(varia.CodigoEmpresa,VpaDCotacao.CodVendedor,VpfDProdutoCotacao.CodClassificacao,'P');
        end;
        if VpfPerComissaoVendedor = 0 then
          VpfPerComissaoVendedor := VpfDProdutoCotacao.PerComissaoClassificacao;
      end;
      VpfPerComissaoVendedor := RDescontoAcrescimoComissao(VpfDProdutoCotacao,VpfPerComissaoVendedor);

      if config.QuandoForQuartodeNotanoRomaneioFazeroValorFaltante then
      begin
        if VpaDCliente.IndQuarto then
          VpfValTotalProdutos := VpfDProdutoCotacao.ValTotal * 0.75
        else
          if VpaDCliente.IndMeia then
            VpfValTotalProdutos := VpfDProdutoCotacao.ValTotal * 0.5
          else
            if VpaDCliente.IndVintePorcento then
              VpfValTotalProdutos := VpfDProdutoCotacao.ValTotal * 0.8
            else
              if VpaDCliente.IndDecimo then
                VpfValTotalProdutos := VpfDProdutoCotacao.ValTotal * 0.9
              else
                VpfValTotalProdutos := VpfDProdutoCotacao.ValTotal;
      end
      else
        VpfValTotalProdutos := VpfDProdutoCotacao.ValTotal;
      Result := result + ((VpfValTotalProdutos * (VpfPerComissaoVendedor - VpaPerComissaoPreposto))/100);
    end;
    VpfCodClassificacao := '';
    VpfPerComissaoVendedor := 0;
    for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
    begin
      VpfDServicoCotacao := TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
      if VpfCodClassificacao <> VpfDServicoCotacao.CodClassificacao then
      begin
        VpfCodClassificacao := VpfDServicoCotacao.CodClassificacao;
        VpfPerComissaoVendedor := FunVendedor.RPerComissaoVendedorClassificacao(varia.CodigoEmpresa,VpaDCotacao.CodVendedor,VpfDServicoCotacao.CodClassificacao,'S');
      end;
      if VpfPerComissaoVendedor <> 0 then
        Result := result + ((VpfDServicoCotacao.ValTotal * (VpfPerComissaoVendedor - VpaPerComissaoPreposto))/100)
      else
        if VpfDServicoCotacao.PerComissaoClassificacao <> 0 then
          Result := result + ((VpfDServicoCotacao.ValTotal * (VpfDServicoCotacao.PerComissaoClassificacao - VpaPerComissaoPreposto))/100);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RProdutoPendente(VpaProdutos : TList;VpaSeqProduto : Integer) : TRBDProdutoPendenteMetalVidros;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaProdutos.Count - 1 do
  begin
    if TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLaco]).SeqProduto = VpaSeqProduto then
    begin
      result := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLaco]);
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDProdutoPendenteMetalVidros.cria;
    result.SeqProduto := VpaSeqProduto;
    result.QtdProduto := 0;
    Result.DatPrimeiraEntrega := MontaData(1,1,2500);
    VpaProdutos.add(result);
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDProdutoPendenteMetalVidros(VpaProdutos : TList;VpaDatInicio, VpaDatFim : TDateTime);
Var
  VpfDProdutoPendente : TRBDProdutoPendenteMetalVidros;
  VpfDPedidoPendente : TRBDOrcamentoProdutoPendenteMetalVidros;
begin
  Orcamento.close;
  Orcamento.sql.clear;
  AdicionaSQLTabela(Orcamento,'Select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UNIORIGINAL, '+
                                  ' CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.D_DAT_PRE, '+
                                  ' mov.n_qtd_pro, mov.n_qtd_bai, MOV.N_QTD_CAN, mov.c_cod_uni '+
                             ' from cadorcamentos cad, movorcamentos mov, cadclientes cli, cadprodutos pro '+
                             ' where cad.i_emp_fil = mov.i_emp_fil '+
                             ' and cad.i_lan_orc = mov.i_lan_orc '+
                             ' and cad.i_cod_cli = cli.i_cod_cli '+
                             ' and mov.i_seq_pro = pro.i_seq_pro '+
                             ' and cad.c_fla_sit = ''A'''+
                             ' and (MOV.N_QTD_PRO - '+SqlTextoIsNull('MOV.N_QTD_BAI','0')+' - '+SqlTextoIsNull('MOV.N_QTD_CAN','0')+') > 0 '+
                             ' and CAD.I_TIP_ORC = '+ IntToStr(Varia.TipoCotacaoPedido)+
                             ' and CAD.C_IND_CAN = ''N''');
  if config.ImprimirPedidoPendentesPorPeriodo then
    AdicionaSQLTabela(Orcamento,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_PRE',VpaDatInicio,VpaDatFim,true));
  Orcamento.open;
  while not Orcamento.eof do
  begin
    VpfDProdutoPendente := RProdutoPendente(VpaProdutos,Orcamento.FieldByname('I_SEQ_PRO').AsInteger);
    VpfDProdutoPendente.CodProduto := Orcamento.FieldByname('C_COD_PRO').AsString;
    VpfDProdutoPendente.NomProduto := Orcamento.FieldByname('C_NOM_PRO').AsString;
    VpfDProdutoPendente.DesUM := Orcamento.FieldByname('UNIORIGINAL').AsString;
    VpfDProdutoPendente.QtdProduto := VpfDProdutoPendente.QtdProduto + FunProdutos.CalculaQdadePadrao(Orcamento.FieldByname('C_COD_UNI').AsString,VpfDProdutoPendente.DesUM,
                                       Orcamento.FieldByname('N_QTD_PRO').AsFloat - Orcamento.FieldByname('N_QTD_BAI').AsFloat- Orcamento.FieldByname('N_QTD_CAN').AsFloat,Orcamento.FieldByname('I_SEQ_PRO').AsString);
    if Orcamento.FieldByname('D_DAT_PRE').AsDateTime < VpfDProdutoPendente.DatPrimeiraEntrega then
      VpfDProdutoPendente.DatPrimeiraEntrega := Orcamento.FieldByname('D_DAT_PRE').AsDateTime;
    VpfDPedidoPendente := VpfDProdutoPendente.AddOrcamentoProdutoPendente(Orcamento.FieldByname('D_DAT_PRE').AsDateTime);
    VpfDPedidoPendente.CodFilial := Orcamento.FieldByname('I_EMP_FIL').AsInteger;
    VpfDPedidoPendente.LanOrcamento := Orcamento.FieldByname('I_LAN_ORC').AsInteger;
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDRepresentada(VpaDRepresentada: TRBDRepresentada;VpaCodRepresentada: Integer);
begin
  AdicionaSQLAbreTabela(Aux,'Select * from REPRESENTADA '+
                            ' Where CODREPRESENTADA = '+IntToStr(VpaCodRepresentada));
  VpaDRepresentada.CodRepresentada := VpaCodRepresentada;
  VpaDRepresentada.NomRepresentada := Aux.FieldByName('NOMREPRESENTADA').AsString;
  VpaDRepresentada.NomFantasia := Aux.FieldByName('NOMFANTASIA').AsString;
  VpaDRepresentada.DesEmail :=  Aux.FieldByName('DESEMAIL').AsString;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDRomaneioOrcamento(VpaDRomaneio: TRBDRomaneioOrcamento; VpaCodFilial,VpaSeqRomaneio: Integer);
begin
  FreeTObjectsList(VpaDRomaneio.Produtos);
  AdicionaSQLAbreTabela(Orcamento,'Select ROM.CODFILIAL, ROM.SEQROMANEIO, ROM.DATINICIO, ROM.DATFIM, ROM.NUMNOTA, ROM.CODFILIALNOTA, '+
                                ' ROM.SEQNOTA, ROM.CODCLIENTE, ROM.VALTOTAL, ROM.CODUSUARIO, ROM.PESBRUTO, ROM.QTDVOLUME, ROM.INDBLOQUEADO '+
                                ' from ROMANEIOORCAMENTO ROM '+
                                ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' AND SEQROMANEIO = '+IntToStr(VpaSeqRomaneio));
  VpaDRomaneio.CodFilial := VpaCodFilial;
  VpaDRomaneio.SeqRomaneio := VpaSeqRomaneio;
  VpaDRomaneio.NumNota := Orcamento.FieldByName('NUMNOTA').AsInteger;
  VpaDRomaneio.CodFilialNota := Orcamento.FieldByName('CODFILIALNOTA').AsInteger;
  VpaDRomaneio.SeqNota := Orcamento.FieldByName('SEQNOTA').AsInteger;
  VpaDRomaneio.CodCliente := Orcamento.FieldByName('CODCLIENTE').AsInteger;
  VpaDRomaneio.CodUsuario := Orcamento.FieldByName('CODUSUARIO').AsInteger;
  VpaDRomaneio.DatInicio := Orcamento.FieldByName('DATINICIO').AsDateTime;
  VpaDRomaneio.DatFim := Orcamento.FieldByName('DATFIM').AsDateTime;
  VpaDRomaneio.ValTotal := Orcamento.FieldByName('VALTOTAL').AsFloat;
  VpaDRomaneio.QtdVolume := Orcamento.FieldByName('QTDVOLUME').AsInteger;
  VpaDRomaneio.PesBruto := Orcamento.FieldByName('PESBRUTO').AsFloat;
  VpaDRomaneio.IndBloqueado := Orcamento.FieldByName('INDBLOQUEADO').AsString = 'S';

  CarDRomaneioOrcamentoProdutos(VpaDRomaneio);
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDRomaneioOrcamentoProdutos(VpaDRomaneio: TRBDRomaneioOrcamento);
Var
  VpfDItem : TRBDRomaneioOrcamentoItem;
begin
  AdicionaSQLAbreTabela(Orcamento,'Select  ITE.CODFILIAL, ITE.SEQROMANEIO, ITE.SEQITEM, ITE.CODFILIALORCAMENTO, ITE.LANORCAMENTO,  '+
                                  ' ITE.SEQPRODUTO, ITE.CODCOR, ITE.CODTAMANHO, ITE.QTDPRODUTO, ITE.VALUNITARIO, ITE.VALTOTAL, ITE.CODEMBALAGEM, '+
                                  ' ITE.DESUM, ITE.DESORDEMCOMPRA, ITE.DESREFERENCIACLIENTE, ITE.QTDPEDIDO, '+
                                  ' TAM.NOMTAMANHO, '+
                                  ' COR.NOM_COR, '+
                                  ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                                  ' from ROMANEIOORCAMENTOITEM ITE, TAMANHO TAM, COR, CADPRODUTOS PRO '+
                                  ' WHERE ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND '+SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                                  ' AND '+SQLTextoRightJoin('ITE.CODTAMANHO','TAM.CODTAMANHO')+
                                  ' AND ITE.CODFILIAL = ' +IntToStr(VpaDRomaneio.CodFilial)+
                                  ' AND ITE.SEQROMANEIO = '+IntToStr(VpaDRomaneio.SeqRomaneio)+
                                  ' ORDER BY ITE.SEQITEM');
  while not Orcamento.eof do
  begin
    VpfDItem := VpaDRomaneio.addProduto;
    VpfDItem.SeqItem := Orcamento.FieldByName('SEQITEM').AsInteger;
    VpfDItem.SeqProduto := Orcamento.FieldByName('SEQPRODUTO').AsInteger;
    VpfDItem.CodFilialOrcamento := Orcamento.FieldByName('CODFILIALORCAMENTO').AsInteger;
    VpfDItem.LanOrcamento := Orcamento.FieldByName('LANORCAMENTO').AsInteger;
    VpfDItem.CodCor := Orcamento.FieldByName('CODCOR').AsInteger;
    VpfDItem.CodTamanho := Orcamento.FieldByName('CODTAMANHO').AsInteger;
    VpfDItem.CodEmbalagem := Orcamento.FieldByName('CODEMBALAGEM').AsInteger;
    VpfDItem.CodProduto := Orcamento.FieldByName('C_COD_PRO').AsString;
    VpfDItem.NomProduto := Orcamento.FieldByName('C_NOM_PRO').AsString;
    VpfDItem.NomCor := Orcamento.FieldByName('NOM_COR').AsString;
    VpfDItem.NomTamanho := Orcamento.FieldByName('NOMTAMANHO').AsString;
    VpfDItem.QtdProduto := Orcamento.FieldByName('QTDPRODUTO').AsFloat;
    VpfDItem.QtdPedido := Orcamento.FieldByName('QTDPEDIDO').AsFloat;
    VpfDItem.ValUnitario := Orcamento.FieldByName('VALUNITARIO').AsFloat;
    VpfDItem.ValTotal := Orcamento.FieldByName('VALTOTAL').AsFloat;
    VpfDItem.DesUM := Orcamento.FieldByName('DESUM').AsString;
    VpfDItem.DesOrdemCompra := Orcamento.FieldByName('DESORDEMCOMPRA').AsString;
    VpfDItem.DesReferenciaCliente := Orcamento.FieldByName('DESREFERENCIACLIENTE').AsString;
    VpfDItem.DesCodBarra := FunProdutos.RCodigoBarraProduto(VpfDItem.CodFilialOrcamento, VpfDItem.SeqProduto, VpfDItem.CodCor, VpfDItem.CodTamanho);
    Orcamento.Next;
  end;
  Orcamento.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.OrdenaProdutosPendentes(VpaProdutos : TList);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDProPendenteExterno, VpfDProPendenteInterno, VpfProPendenteAux : TRBDProdutoPendenteMetalVidros;
begin
  for VpfLacoExterno := 0 to VpaProdutos.Count - 2 do
  begin
    VpfDProPendenteExterno := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaProdutos.Count - 1 do
    begin
      VpfDProPendenteInterno := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLacoInterno]);
      if VpfDProPendenteInterno.DatPrimeiraEntrega <  VpfDProPendenteExterno.DatPrimeiraEntrega then
      begin
        VpaProdutos.Items[VpfLacoExterno] := VpaProdutos.Items[VpfLacoInterno];
        VpaProdutos.Items[VpfLacoInterno] := VpfDProPendenteExterno;
        VpfDProPendenteExterno := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ProdutoRomaneioExistenoPedido(VpaDRomaneioItem: TRBDRomaneioOrcamentoItem): boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from MOVORCAMENTOS ' +
                            ' Where I_EMP_FIL = ' +IntToStr(VpaDRomaneioItem.CodFilialOrcamento)+
                            ' AND I_LAN_ORC = ' +IntToStr(VpaDRomaneioItem.LanOrcamento)+
                            ' AND I_SEQ_PRO = ' +IntToStr(VpaDRomaneioItem.SeqProduto)+
                            ' AND '+SQLTextoIsNull('I_COD_COR','0')+' = ' +IntToStr(VpaDRomaneioItem.CodCor)+
                            ' AND '+SQLTextoIsNull('I_COD_TAM','0')+ ' = ' +IntToStr(VpaDRomaneioItem.CodTamanho));
  VpaDRomaneioItem.ValUnitario := Aux.FieldByName('N_VLR_PRO').AsFloat;
  VpaDRomaneioItem.DesUM := Aux.FieldByName('C_COD_UNI').AsString;
  if Aux.FieldByName('C_ORD_COM').AsString <> '' then
    VpaDRomaneioItem.DesOrdemCompra := Aux.FieldByName('C_ORD_COM').AsString
  else
    VpaDRomaneioItem.DesOrdemCompra := VpaDRomaneioItem.DesOrdemCompraPedido;
  VpaDRomaneioItem.DesOrdemCorte := AUX.FieldByName('C_ORD_COR').AsString;
  VpaDRomaneioItem.DesReferenciaCliente := AUX.FieldByName('C_PRO_REF').AsString;
  VpaDRomaneioItem.QtdPedido := Aux.FieldByName('N_QTD_PRO').AsFloat;
  result := not Aux.Eof;
  aux.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SalvaArquivoProdutoPendente(VpaProduto : TList);
var
  VpfLacoProduto, VpfLacoPedido : Integer;
  VpfArquivo : TStringLIst;
  VpfDProdutoPendente : TRBDProdutoPendenteMetalVidros;
  VpfDPedidoPendente : TRBDOrcamentoProdutoPendenteMetalVidros;
  VpfLinha : String;
begin
  VpfArquivo := TStringList.Create;
  for VpfLacoProduto := 0 to VpaProduto.Count - 1 do
  begin
    VpfDProdutoPendente := TRBDProdutoPendenteMetalVidros(VpaProduto.Items[VpfLacoProduto]);
    VpfLinha :=  AdicionaCharD(' ',VpfDProdutoPendente.CodProduto,12)+' '+AdicionaCharE(' ',FormatFloat('##,###,##0.00',VpfDProdutoPendente.QtdProduto),20)+
                                    ' '+FormatDateTime('DD/MM/YYYY',VpfDProdutoPendente.DatPrimeiraEntrega)+ ' *** ';
    for VpfLacoPedido := 0 to VpfDProdutoPendente.Orcamentos.Count - 1 do
    begin
      VpfDPedidoPendente := TRBDOrcamentoProdutoPendenteMetalVidros(VpfDProdutoPendente.Orcamentos.Items[VpfLacoPedido]);
      VpfLinha := VpfLinha + IntToStr(VpfDPedidoPendente.LanOrcamento)+'; ';
    end;
    VpfArquivo.Add(VpfLinha);
  end;
  VpfARquivo.SaveToFile('ProdutosPendentes.txt');
  WinExec(PAnsiChar('NOTEPAD.EXE ProdutosPendentes.txt'), SW_ShowNormal);
  VpfArquivo.Free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SubtraiQtdAlteradaCotacaoInicial(VpaDSaldoCotacao, VpaDCotacaoAlterada : TRBDOrcamento);
var
  VpfLacoCotacaoAlterada, VpfLacoSaldo : Integer;
  VpfDProAlterado, VpfDProSaldo : TRBDOrcProduto;
begin
  for VpfLacoCotacaoAlterada := 0 to VpaDCotacaoAlterada.Produtos.Count - 1 do
  begin
    VpfDProAlterado := TRBDOrcProduto(VpaDCotacaoAlterada.Produtos.Items[VpfLacoCotacaoAlterada]);
    VpfDProSaldo := RProdutoCotacao(VpaDSaldoCotacao,VpfDProAlterado.SeqProduto,VpfDProAlterado.CodCor,VpfDProAlterado.CodTamanho, VpfDProAlterado.ValUnitario);
    if VpfDProSaldo = nil then
    begin
      VpfDProSaldo := VpaDSaldoCotacao.AddProduto;
      CopiaDProdutoCotacao(VpfDProAlterado,VpfDProSaldo);
      VpfDProSaldo.QtdBaixadoEstoque := 0;
    end;
    VpfDProSaldo.QtdBaixadoEstoque := VpfDProSaldo.QtdBaixadoEstoque - FunProdutos.CalculaQdadePadrao(VpfDProAlterado.UM ,VpfDProSaldo.UM,VpfDProAlterado.QtdProduto,InttoStr(VpfDProAlterado.SeqProduto));
    VpfDProAlterado.QtdBaixadoEstoque := VpfDProAlterado.QtdProduto;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EnviaEmailCliente(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfEmailVendedor,VpfEmailCliente, VpfNomAnexo, VpfEmailUsuario : String;
  VpfPDF, Vpfbmppart : TIdAttachmentFile;
  VpfChar : Char;
  VpfDRepresentada : TRBDRepresentada;
begin
  result := '';
  VpfDRepresentada := TRBDRepresentada.cria;
  if VpaDCotacao.CodRepresentada <> 0 then
    CarDRepresentada(VpfDRepresentada,VpaDCotacao.CodRepresentada);
  if VpaDCotacao.DesEmail = '' then
    if VpaDCliente.DesEmail = '' then
      result := 'E-MAIL DO CLIENTE NÃO PREENCHIDO!!!'#13'Falta preencher o e-mail do cliente.'
    else
      VpaDCotacao.DesEmail := VpaDCliente.DesEmail;
  if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';
  if result = '' then
  begin
{    VpfEmailTexto := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailTexto.ContentType := 'text/plain';
    MontaEmailCotacaoTexto(VpfEmailTexto.Body,VpaDCotacao,VpaDCliente);}
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDCotacao.CodEmpFil)+'.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDCotacao.CodEmpFil)+'.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    if config.RepresentanteComercial and (VpaDCotacao.CodRepresentada <> 0) then
    begin
      if ExisteArquivo(varia.PathVersoes+'\R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg') then
        Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg')
      else
        Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDCotacao.CodEmpFil)+'.jpg');
      Vpfbmppart.ContentType := 'image/jpg';
      Vpfbmppart.ContentDisposition := 'inline';
      Vpfbmppart.ExtraHeaders.Values['content-id'] := 'R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg';
      Vpfbmppart.FileName := '';
      Vpfbmppart.DisplayName := '';
    end
    else
    begin
      Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\efi.jpg');
      Vpfbmppart.ContentType := 'image/jpg';
      Vpfbmppart.ContentDisposition := 'inline';
      Vpfbmppart.ExtraHeaders.Values['content-id'] := 'efi.jpg';
      Vpfbmppart.FileName := '';
      Vpfbmppart.DisplayName := '';
    end;

    try
    dtRave := TdtRave.Create(nil);
      VpfNomAnexo := varia.PathVersoes+'\ANEXOS\COTACAO'+IntToStr(VpaDCotacao.CodEmpFil)+'_'+IntToStr(VpaDCotacao.LanOrcamento)+'.PDF';
      dtRave.VplArquivoPDF := VpfNomAnexo ;
      dtRave.ImprimePedido(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento,false);
    finally
      dtRave.Free;
    end;
    VpfPDF := TIdAttachmentFile.Create(VprMensagem.MessageParts,VpfNomAnexo);
    VpfPDF.ContentType := 'application/pdf;Cotacao';
    VpfPDF.ContentDisposition := 'inline';
    VpfPDF.ExtraHeaders.Values['content-id'] := VpfNomAnexo;
    VpfPDF.DisplayName := RetornaNomeSemExtensao(VpfNomAnexo)+'.pdf';


    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    MontaEmailCotacao(VpfEmailHTML.Body,VpaDCotacao,VpaDCliente,VpfDRepresentada, true);

    VpfEmailCliente := VpaDCotacao.DesEmail;
    VpfChar := ',';
    if ExisteLetraString(';',VpfEmailCliente) then
      VpfChar := ';';
    while Length(VpfEmailCliente) > 0 do
    begin
      VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
      VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
    end;
    if VpfDRepresentada.DesEmail <> '' then
    begin
      VpfEmailCliente := VpfDRepresentada.DesEmail;
      if ExisteLetraString(';',VpfEmailCliente) then
        VpfChar := ';';
      while Length(VpfEmailCliente) > 0 do
      begin
        VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
        VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
      end;
    end;
    if Varia.EmailCopiaCotacao <> '' then
      VprMensagem.Recipients.Add.Address := varia.EmailCopiaCotacao;

    VprMensagem.Subject := Varia.NomeFilial+' - Cotação ' +IntToStr(VpaDCotacao.LanOrcamento);
    VpfEmailVendedor := REmailVencedor(VpaDCotacao.CodVendedor);
    if VpfEmailVendedor <> '' then
    begin
      VprMensagem.ReplyTo.EMailAddresses := VpfEmailVendedor;
      if Config.EnviarCopiaPedidoparaVendedor then
      begin
        VpfEmailCliente := VpfEmailVendedor;
        if ExisteLetraString(';',VpfEmailCliente) then
          VpfChar := ';';
        while Length(VpfEmailCliente) > 0 do
        begin
          VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
          VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
        end;
      end;
    end;

    //verifica se é para enviar o retorno para o usuario que digitou o pedido;
    VpfEmailUsuario := sistema.REmailUsuario(VpaDCotacao.CodUsuario);
    if config.ConfirmacaoEmailCotacaoParaoUsuario and (VpfEmailUsuario <> '') then
    begin
      VprMensagem.From.Address := VpfEmailUsuario;
      VprMensagem.ReceiptRecipient.Address  := VpfEmailUsuario;
      VprMensagem.ReplyTo.EMailAddresses := VpfEmailUsuario;
      VprMensagem.ReceiptRecipient.Name  := varia.NomeFilial;
    end
    else
      VprMensagem.ReceiptRecipient.Text  :='';

    result := EnviaEmail(VprMensagem,VprSMTP);
    if result = '' then
      Result:= GravaDEmail(VpaDCotacao,VpaDCliente.DesEmail);
  end;
  VpfDRepresentada.Free;
end;

{******************************************************************************}
function TFuncoesCotacao.EnviaEmailClienteEstagio(
  VpaDCotacao: TRBDOrcamento; VpaDCliente: TRBDCliente): string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfEmailVendedor,VpfEmailCliente, VpfNomAnexo, VpfEmailUsuario : String;
  VpfPDF, Vpfbmppart : TIdAttachmentFile;
  VpfChar : Char;
  VpfDRepresentada : TRBDRepresentada;
begin
  if RMandaEmailEstagio(VpaDCotacao.CodEstagio) then
  begin
    result := '';
    VpfDRepresentada := TRBDRepresentada.cria;
    if VpaDCotacao.CodRepresentada <> 0 then
      CarDRepresentada(VpfDRepresentada,VpaDCotacao.CodRepresentada);
    if VpaDCotacao.DesEmail = '' then
    if VpaDCliente.DesEmail = '' then
      result := 'E-MAIL DO CLIENTE NÃO PREENCHIDO!!!'#13'Falta preencher o e-mail do cliente.'
    else
      VpaDCotacao.DesEmail := VpaDCliente.DesEmail;
    if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
      result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';
    if result = '' then
    begin
      Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDCotacao.CodEmpFil)+'.jpg');
      Vpfbmppart.ContentType := 'image/jpg';
      Vpfbmppart.ContentDisposition := 'inline';
      Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDCotacao.CodEmpFil)+'.jpg';
      Vpfbmppart.FileName := '';
      Vpfbmppart.DisplayName := '';

      if config.RepresentanteComercial and (VpaDCotacao.CodRepresentada <> 0) then
      begin
        if ExisteArquivo(varia.PathVersoes+'\R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg') then
          Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg')
        else
          Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDCotacao.CodEmpFil)+'.jpg');
        Vpfbmppart.ContentType := 'image/jpg';
        Vpfbmppart.ContentDisposition := 'inline';
        Vpfbmppart.ExtraHeaders.Values['content-id'] := 'R'+IntToStr(VpaDCotacao.CodRepresentada)+'.jpg';
        Vpfbmppart.FileName := '';
        Vpfbmppart.DisplayName := '';
      end
      else
      begin
        Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\efi.jpg');
        Vpfbmppart.ContentType := 'image/jpg';
        Vpfbmppart.ContentDisposition := 'inline';
        Vpfbmppart.ExtraHeaders.Values['content-id'] := 'efi.jpg';
        Vpfbmppart.FileName := '';
        Vpfbmppart.DisplayName := '';
      end;

      dtRave := TdtRave.Create(nil);
      VpfNomAnexo := varia.PathVersoes+'\ANEXOS\COTACAO'+IntToStr(VpaDCotacao.CodEmpFil)+'_'+IntToStr(VpaDCotacao.LanOrcamento)+'.PDF';
      dtRave.VplArquivoPDF := VpfNomAnexo ;
      dtRave.ImprimePedido(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento,false);
      dtRave.Free;
      VpfPDF := TIdAttachmentFile.Create(VprMensagem.MessageParts,VpfNomAnexo);
      VpfPDF.ContentType := 'application/pdf;Cotacao';
      VpfPDF.ContentDisposition := 'inline';
      VpfPDF.ExtraHeaders.Values['content-id'] := VpfNomAnexo;
      VpfPDF.DisplayName := RetornaNomeSemExtensao(VpfNomAnexo)+'.pdf';


      VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
      VpfEmailHTML.ContentType := 'text/html';

      if Config.LayoutModificadoEmailCotacaoEstagio then
        MontaEmailCotacaoEstagioModificado(VpfEmailHTML.Body,VpaDCotacao,VpaDCliente,VpfDRepresentada, true)
      else
        MontaEmailCotacaoEstagio(VpfEmailHTML.Body,VpaDCotacao,VpaDCliente,VpfDRepresentada, true);

      VpfEmailCliente := VpaDCotacao.DesEmail;
      VpfChar := ',';
      if ExisteLetraString(';',VpfEmailCliente) then
        VpfChar := ';';
      while Length(VpfEmailCliente) > 0 do
      begin
        VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
        VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
      end;
      if VpfDRepresentada.DesEmail <> '' then
      begin
        VpfEmailCliente := VpfDRepresentada.DesEmail;
        if ExisteLetraString(';',VpfEmailCliente) then
          VpfChar := ';';
        while Length(VpfEmailCliente) > 0 do
        begin
          VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
          VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
        end;
      end;
      if Varia.EmailCopiaCotacao <> '' then
        VprMensagem.Recipients.Add.Address := varia.EmailCopiaCotacao;


      VprMensagem.Subject := Varia.NomeFilial+' - Cotação ' +IntToStr(VpaDCotacao.LanOrcamento);
      VpfEmailVendedor := REmailVencedor(VpaDCotacao.CodVendedor);
      if VpfEmailVendedor <> '' then
      begin
        VprMensagem.ReplyTo.EMailAddresses := VpfEmailVendedor;
        if Config.EnviarCopiaPedidoparaVendedor then
        begin
          VpfEmailCliente := VpfEmailVendedor;
          if ExisteLetraString(';',VpfEmailCliente) then
            VpfChar := ';';
          while Length(VpfEmailCliente) > 0 do
          begin
            VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
            VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
          end;
        end;
      end;

      //verifica se é para enviar o retorno para o usuario que digitou o pedido;
      VpfEmailUsuario := sistema.REmailUsuario(VpaDCotacao.CodUsuario);
      if config.ConfirmacaoEmailCotacaoParaoUsuario and (VpfEmailUsuario <> '') then
      begin
        VprMensagem.From.Address := VpfEmailUsuario;
        VprMensagem.ReceiptRecipient.Address  := VpfEmailUsuario;
        VprMensagem.ReplyTo.EMailAddresses := VpfEmailUsuario;
        VprMensagem.ReceiptRecipient.Name  := varia.NomeFilial;
      end
      else
        VprMensagem.ReceiptRecipient.Text  :='';

      result := EnviaEmail(VprMensagem,VprSMTP);
      if result = '' then
        Result:= GravaDEmail(VpaDCotacao,VpaDCliente.DesEmail);
    end;
    VpfDRepresentada.Free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AgrupaCotacoes(VpaCotacoes : TList;VpaIndCopia : Boolean) : TRBDOrcamento;
var
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacaoDe, VpfDProCotacaoPara : TRBDOrcProduto;
  vpfdSerCotacaoDe, VpfDSerCotacaoPara : TRBDOrcServico;
  VpfLaco, VpfLacoProduto, VpfLacoUM, VpfLacoServico  : Integer;
  VpfNumCotacoes : String;
begin
  VpfNumCotacoes := '';
  if VpaIndCopia then
  begin
    result := TRBDOrcamento.cria;
    Cardorcamento(result,TRBDOrcamento(VpaCotacoes.Items[0]).CodEmpFil,TRBDOrcamento(VpaCotacoes.Items[0]).LanOrcamento);
  end
  else
  begin
    result := TRBDOrcamento(VpaCotacoes.Items[0]);
  end;
  if VpaCotacoes.Count > 0 then
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[0]);
    if Result.PerDesconto <> 0 then
      AdicionaDescontoCotacaoDePara(result,result); //converto o percentual de desconto em valor de desconto.
    result.PerDesconto := 0;

    for VpfLaco := 1 to VpaCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
      VpfNumCotacoes := VpfNumCotacoes+IntToStr(VpfDCotacao.LanOrcamento)+',';
      if VpfDCotacao.DesObservacaoFiscal <> '' then
        result.DesObservacaoFiscal := Result.DesObservacaoFiscal + #13+VpfDCotacao.DesObservacaoFiscal;
      if VpfDCotacao.DesObservacao.Text <> '' then
        result.DesObservacao.Text := Result.DesObservacao.Text +#13+ VpfDCotacao.DesObservacao.Text;
      AdicionaDescontoCotacaoDePara(VpfDCotacao,result);
      for VpfLacoProduto := 0 to VpfDCotacao.Produtos.count - 1 do
      begin
        VpfDProCotacaoDe := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
        VpfDProCotacaoPara := result.AddProduto;
        VpfDProCotacaoPara.LanOrcamentoOrigem := VpfDCotacao.LanOrcamento;
        VpfDProCotacaoPara.SeqProduto := VpfDProCotacaoDe.SeqProduto;
        VpfDProCotacaoPara.CodCor := VpfDProCotacaoDe.CodCor;
        VpfDProCotacaoPara.CodEmbalagem := VpfDProCotacaoDe.CodEmbalagem;
        VpfDProCotacaoPara.CodPrincipioAtivo := VpfDProCotacaoDe.CodPrincipioAtivo;
        VpfDProCotacaoPara.CodProduto := VpfDProCotacaoDe.CodProduto;
        VpfDProCotacaoPara.NomProduto := VpfDProCotacaoDe.NomProduto;
        VpfDProCotacaoPara.DesCor := VpfDProCotacaoDe.DesCor;
        VpfDProCotacaoPara.DesEmbalagem := VpfDProCotacaoDe.DesEmbalagem;
        VpfDProCotacaoPara.DesObservacao := VpfDProCotacaoDe.DesObservacao;
        VpfDProCotacaoPara.DesRefCliente := IntToStr(VpfDCotacao.LanOrcamento);
        VpfDProCotacaoPara.DesOrdemCompra := IntTostr(VpfDCotacao.LanOrcamento);
        VpfDProCotacaoPara.UM := VpfDProCotacaoDe.UM;
        VpfDProCotacaoPara.UMAnterior := VpfDProCotacaoDe.UMAnterior;
        VpfDProCotacaoPara.UMOriginal := VpfDProCotacaoDe.UMOriginal;
        VpfDProCotacaoPara.IndImpFoto := VpfDProCotacaoDe.IndImpFoto;
        VpfDProCotacaoPara.IndImpDescricao := VpfDProCotacaoDe.IndImpDescricao;
        VpfDProCotacaoPara.IndFaturar := VpfDProCotacaoDe.IndFaturar;
        VpfDProCotacaoPara.IndRetornavel := VpfDProCotacaoDe.IndRetornavel;
        VpfDProCotacaoPara.IndBrinde := VpfDProCotacaoDe.IndBrinde;
        VpfDProCotacaoPara.IndCracha := VpfDProCotacaoDe.IndCracha;
        VpfDProCotacaoPara.PerDesconto := VpfDProCotacaoDe.PerDesconto;
        VpfDProCotacaoPara.PesLiquido := VpfDProCotacaoDe.PesLiquido;
        VpfDProCotacaoPara.PesBruto := VpfDProCotacaoDe.PesBruto;
        VpfDProCotacaoPara.QtdEstoque := VpfDProCotacaoDe.QtdEstoque;
        VpfDProCotacaoPara.QtdBaixadoNota := VpfDProCotacaoDe.QtdBaixadoNota;
        VpfDProCotacaoPara.QtdBaixadoEstoque := VpfDProCotacaoDe.QtdBaixadoEstoque;
        VpfDProCotacaoPara.QtdConferido := VpfDProCotacaoDe.QtdConferido;
        VpfDProCotacaoPara.QtdConferidoSalvo := VpfDProCotacaoDe.QtdConferidoSalvo;
        VpfDProCotacaoPara.QtdMinima := VpfDProCotacaoDe.QtdMinima;
        VpfDProCotacaoPara.QtdPedido := VpfDProCotacaoDe.QtdPedido;
        VpfDProCotacaoPara.QtdProduto := VpfDProCotacaoDe.QtdProduto;
        VpfDProCotacaoPara.QtdFiscal := VpfDProCotacaoDe.QtdFiscal;
        VpfDProCotacaoPara.QtdDevolvido := VpfDProCotacaoDe.QtdDevolvido;
        VpfDProCotacaoPara.QtdSaldoBrinde := VpfDProCotacaoDe.QtdSaldoBrinde;
        VpfDProCotacaoPara.ValUnitario := VpfDProCotacaoDe.ValUnitario;
        VpfDProCotacaoPara.ValUnitarioOriginal := VpfDProCotacaoDe.ValUnitarioOriginal;
        VpfDProCotacaoPara.ValTotal := VpfDProCotacaoDe.ValTotal;
        VpfDProCotacaoPara.RedICMS := VpfDProCotacaoDe.RedICMS;
        for VpfLacoUM := 0 to VpfDProCotacaoDe.UnidadeParentes.Count - 1 do
          VpfDProCotacaoPara.UnidadeParentes.add(VpfDProCotacaoDe.UnidadeParentes.Strings[VpfLacoUM]);
      end;
      for VpfLacoServico := 0 to VpfDCotacao.Servicos.count - 1 do
      begin
        vpfdSerCotacaoDe := TRBDOrcServico(VpfDCotacao.servicos.Items[VpfLacoServico]);
        VpfDSerCotacaoPara := result.AddServico;
        VpfDSerCotacaoPara.CodServico := vpfdSerCotacaoDe.CodServico;
        VpfDSerCotacaoPara.NomServico := vpfdSerCotacaoDe.NomServico;
        VpfDSerCotacaoPara.DesAdicional := vpfdSerCotacaoDe.DesAdicional;
        VpfDSerCotacaoPara.QtdServico := vpfdSerCotacaoDe.QtdServico;
        VpfDSerCotacaoPara.ValUnitario := vpfdSerCotacaoDe.ValUnitario;
        VpfDSerCotacaoPara.ValTotal := vpfdSerCotacaoDe.ValTotal;
        VpfDSerCotacaoPara.PerISSQN := vpfdSerCotacaoDe.PerISSQN;
      end;
    end;
    result.DesObservacao.Text := 'Agrupado cotações : '+ copy(VpfNumCotacoes,1,length(VpfNumCotacoes)-1)+#13+ result.DesObservacao.Text;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AgrupaRomaneioOrcamento(VpaCodFilial,VpaSeqRomaneio: Integer; VpaDRomaneioAgrupado: TRBDRomaneioOrcamento) :string;
var
  VpfDRomaneioAAgrupar : TRBDRomaneioOrcamento;
  VpfLaco : Integer;
begin
  VpfDRomaneioAAgrupar := TRBDRomaneioOrcamento.cria;
  CarDRomaneioOrcamento(VpfDRomaneioAAgrupar,VpaCodFilial,VpaSeqRomaneio);

  for VpfLaco := 0 to VpaDRomaneioAgrupado.Produtos.Count - 1 do
    VpfDRomaneioAAgrupar.Produtos.Add(VpaDRomaneioAgrupado.Produtos.Items[VpfLaco]);
  result := GravaDRomaneioCotacao(VpfDRomaneioAAgrupar);
  if result = '' then
    ExcluiRomaneioOrcamento(VpaDRomaneioAgrupado.CodFilial,VpaDRomaneioAgrupado.SeqRomaneio);
end;

{******************************************************************************}
function TFuncoesCotacao.AgrupaTodasCotacoesComProdutosConferidos(VpaCodCliente: Integer): string;
begin
  result := '';

end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiCotacoesAgrupadas(VpaCotacoes : TList):string;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
  if VpaCotacoes.Count > 0 then
  begin
    for VpfLaco := 1 to VpaCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
      result := ExcluiFinanceiroOrcamento(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento,0);
      if result <> '' then
        break;
      ExcluiOrcamento(VpfDCotacao.CodEmpFil, VpfDCotacao.LanOrcamento,false);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.TodosCartuchosAssociados(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):boolean;
var
  VpfLacoCartuchos,VpfLacoCotacao : Integer;
  VpfDCartucho : TRBDCartuchoCotacao;
  VpfDProCotacao : TRBDOrcProduto;
  VpfProdutoAMenos,VpfProdutoAMais, VpfResultado : String;
begin
  for VpfLacoCotacao := 0 to  VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoCotacao]);
    VpfDProCotacao.QtdABaixar := 0;
  end;

  for VpfLacoCartuchos := 0 to VpaCartuchos.Count - 1 do
  begin
    VpfDCartucho := TRBDCartuchoCotacao(VpaCartuchos.Items[VpfLacoCartuchos]);
    for VpfLacoCotacao := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoCotacao]);
      if VpfDCartucho.SeqProdutoTrocado <> 0 then
      begin
        if (VpfDProCotacao.SeqProduto = VpfDCartucho.SeqProdutoTrocado) then
          VpfDProCotacao.QtdABaixar := VpfDProCotacao.QtdABaixar + 1;
      end
      else
        if (VpfDProCotacao.SeqProduto = VpfDCartucho.SeqProduto) then
          VpfDProCotacao.QtdABaixar := VpfDProCotacao.QtdABaixar + 1;
    end;
  end;
  VpfProdutoAMenos := '';
  VpfProdutoAMais := '';
  for VpfLacoCotacao := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoCotacao]);
    if (VpfDProCotacao.QtdABaixar < VpfDProCotacao.QtdProduto) then
      VpfProdutoAMenos := VpfProdutoAMenos + #13'"'+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto+'" ('+FormatFloat('0',VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdABaixar)+') ' +VpfDProCotacao.UM
    else
      if (VpfDProCotacao.QtdABaixar > VpfDProCotacao.QtdProduto) then
      VpfProdutoAMais := VpfProdutoAMais + #13'"'+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto+'" ('+FormatFloat('0',VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdABaixar)+') ' +VpfDProCotacao.UM
  end;
  result := true;
  if (VpfProdutoAMenos <> '') or (VpfProdutoAMais <> '' ) then
  begin
    if VpfProdutoAMenos <> '' then
      VpfResultado := 'Falta associar o produtos abaixo:'+VpfProdutoAMenos+#13;
    if VpfProdutoAMais <> '' then
      VpfResultado := VpfResultado +'Os o produtos abaixo foram associados a mais:'+VpfProdutoAMais+#13;
    result := Confirmacao(VpfResultado+'Deseja gravar a cotação?');
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDCotacaoProposta(VpaPropostas : TList; VpaDCotacao: TRBDOrcamento);
var
  VpfLaco, VpfLacoProposta: Integer;
  VpfProdutoProposta: TRBDPropostaProduto;
  VpfProdutoCotacao: TRBDOrcProduto;
  VpfDServicoProposta : TRBDPropostaServico;
  VpfDServicoCotacao : TRBDOrcServico;
  VpfDProposta : TRBDPropostaCorpo;
  VpfDMaterialAcabamento: TRBDPropostaMaterialAcabamento;
begin
  if VpaPropostas.Count > 0 then
  begin
    FreeTObjectsList(VpaDCotacao.Produtos);
    VpfDProposta := TRBDPropostaCorpo(VpaPropostas.Items[0]);
    VpaDCotacao.CodCliente:= VpfDProposta.CodCliente;
    VpaDCotacao.CodVendedor:= VpfDProposta.CodVendedor;
    VpaDCotacao.NomContato:= VpfDProposta.NomContato;
    VpaDCotacao.CodCondicaoPagamento := VpfDProposta.CodCondicaoPagamento;
    VpaDCotacao.CodFormaPaqamento := VpfDProposta.CodFormaPagamento;
    VpaDCotacao.CodTipoOrcamento := varia.TipoCotacao;
    // 07/07/2011 -Maqmundi Ricardo Depiné - foi colocado sempre fixo o tipo do frete 1, pois existe um campo na prosposta que é Frente por conta:(Cliente/Empresa), essa campo informa ao cliente se será ou não cobrado frete e na cotacao esse campo informa a transportadora de quem é para cobrar o frete;
    VpaDCotacao.TipFrete := 1;
    for VpfLacoProposta := 0 to VpaPropostas.Count - 1 do
    begin
      VpfDProposta := TRBDPropostaCorpo(VpaPropostas.items[VpfLacoProposta]);
      VpaDCotacao.DesObservacao.Text := VpaDCotacao.DesObservacao.Text + VpfDProposta.DesObservacao;
      VpaDCotacao.ValTaxaEntrega :=  VpaDCotacao.ValTaxaEntrega + VpfDProposta.ValFrete;
      if VpfDProposta.ValDesconto > 0 then
        VpaDCotacao.ValDesconto := VpaDCotacao.ValDesconto + VpfDProposta.ValDesconto
      else
        if VpfDProposta.PerDesconto > 0 then
          VpaDCotacao.PerDesconto := VpfDProposta.PerDesconto;
      for VpfLaco:= 0 to VpfDProposta.Produtos.Count - 1 do
      begin
         VpfProdutoCotacao:= VpaDCotacao.AddProduto;
         VpfProdutoProposta:= TRBDPropostaProduto(VpfDProposta.Produtos.Items[VpfLaco]);

         VpfProdutoCotacao.SeqProduto:= VpfProdutoProposta.SeqProduto;
         VpfProdutoCotacao.CodProduto:= VpfProdutoProposta.CodProduto;
         ExisteProduto(VpfProdutoCotacao.CodProduto,0,VpfProdutoCotacao,VpaDCotacao);
         VpfProdutoCotacao.CodCor:= VpfProdutoProposta.CodCor;
         VpfProdutoCotacao.DesCor:= VpfProdutoProposta.DesCor;
         VpfProdutoCotacao.DesObservacao:= VpfProdutoProposta.DesTecnica;
         VpfProdutoCotacao.UM:= VpfProdutoProposta.UM;
         VpfProdutoCotacao.QtdProduto:= VpfProdutoProposta.QtdProduto;
         VpfProdutoCotacao.QtdEstoque:= VpfProdutoProposta.QtdEstoque;
         VpfProdutoCotacao.ValUnitario:= VpfProdutoProposta.ValUnitario;
         VpfProdutoCotacao.ValUnitarioOriginal:= VpfProdutoProposta.ValUnitarioOriginal;
         VpfProdutoCotacao.ValTotal:= VpfProdutoProposta.ValTotal;
      end;
      for VpfLaco := 0 to VpfDProposta.Servicos.Count - 1 do
      begin
        VpfDServicoProposta := TRBDPropostaServico(VpfDProposta.Servicos.Items[VpfLaco]);
        VpfDServicoCotacao := VpaDCotacao.AddServico;
        VpfDServicoCotacao.CodServico := VpfDServicoProposta.CodServico;
        ExisteServico(IntToStr(VpfDServicoProposta.CodSErvico),VpfDServicoCotacao);
        VpfDServicoCotacao.NomServico := VpfDServicoProposta.NomServico;
        VpfDServicoCotacao.QtdServico := VpfDServicoProposta.QtdServico;
        VpfDServicoCotacao.ValUnitario := VpfDServicoProposta.ValUnitario;
        VpfDServicoCotacao.ValTotal := VpfDServicoProposta.ValTotal;
      end;
      for VpfLaco := 0 to VpfDProposta.MaterialAcabamento.Count - 1 do
      begin
         VpfProdutoCotacao:= VpaDCotacao.AddProduto;
         VpfDMaterialAcabamento:= TRBDPropostaMaterialAcabamento(VpfDProposta.MaterialAcabamento.Items[VpfLaco]);

         VpfProdutoCotacao.SeqProduto:= VpfDMaterialAcabamento.SeqProduto;
         VpfProdutoCotacao.CodProduto:= VpfDMaterialAcabamento.CodProduto;
         ExisteProduto(VpfDMaterialAcabamento.CodProduto,0,VpfProdutoCotacao,VpaDCotacao);
         VpfProdutoCotacao.UM:= VpfDMaterialAcabamento.UM;
         VpfProdutoCotacao.QtdProduto:= VpfDMaterialAcabamento.Quantidade;
         VpfProdutoCotacao.ValUnitario:= VpfDMaterialAcabamento.ValUnitario;
         VpfProdutoCotacao.ValTotal:= VpfDMaterialAcabamento.ValTotal;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.DuplicaProduto(VpaDCotacao : TRBDOrcamento; VpaDProCotacao : TRBDOrcProduto): TRBDOrcProduto;
begin
  result := VpaDCotacao.AddProduto;
  result.SeqMovimento := 0;
  result.SeqProduto := VpaDProCotacao.SeqProduto;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ExportaProdutosPendentes(VpaDatInicio, VpaDatFim : TDateTime);
var
  VpfProdutos : TList;
begin
  VpfProdutos := TList.Create;
  CarDProdutoPendenteMetalVidros(VpfProdutos,VpaDatINicio,VpaDatFim);
  OrdenaProdutosPendentes(VpfProdutos);
  SalvaArquivoProdutoPendente(VpfProdutos);
  FreeTObjectsList(VpfProdutos);
  VpfProdutos.free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AtualizaEntradaMetrosDiario(VpaDatInicio, VpaDatFim : TDatetime);
Var
  VpfCodClassificacao, VpfErro : String;
  VpfCodVendedor, VpfCodCliente, VpfCodPreposto, VpfCodEmpresa : Integer;
  VpfSeqEntrada : Integer;
  VpfDatPedido : TDateTime;
begin
  VpfCodClassificacao := '';
  VpfSeqEntrada := 0;

  ExecutaComandoSql(Aux,'Delete from ENTRADAMETRODIARIO');
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ENTRADAMETRODIARIO');
  LocalizaEntradaMetrosDiario(Orcamento,VpaDatInicio,VpaDatFim);
  while not Orcamento.eof do
  begin
    if (VpfCodClassificacao <> copy(Orcamento.FieldByName('C_COD_CLA').AsString,1,Varia.QuantidadeLetrasClassificacaProdutoUnidadeFabricacao))or
       (VpfCodVendedor <> Orcamento.FieldByName('I_COD_VEN').AsInteger) or
       (VpfCodCliente <> Orcamento.FieldByName('I_COD_CLI').AsInteger) or
       (VpfCodPreposto <> Orcamento.FieldByName('I_VEN_PRE').AsInteger) then
    begin
     if VpfCodClassificacao <> '' then
      begin
        VpfSeqEntrada := VpfSeqEntrada + 1;
        CotCadastro.FieldByName('SEQENTRADA').AsInteger := VpfSeqEntrada;
        CotCadastro.post;
      end;
      VpfCodClassificacao := copy(Orcamento.FieldByName('C_COD_CLA').AsString,1,Varia.QuantidadeLetrasClassificacaProdutoUnidadeFabricacao);
      CotCadastro.insert;
      CotCadastro.FieldByName('DATENTRADA').AsDateTime := Orcamento.FieldByName('D_DAT_ORC').AsDateTime;
      CotCadastro.FieldByName('CODCLASSIFICACAO').AsString := VpfCodClassificacao;
      CotCadastro.FieldByName('CODCLIENTE').AsInteger := Orcamento.FieldByName('I_COD_CLI').AsInteger;
      CotCadastro.FieldByName('CODVENDEDOR').AsInteger := Orcamento.FieldByName('I_COD_VEN').AsInteger;
      CotCadastro.FieldByName('CODPREPOSTO').AsInteger := Orcamento.FieldByName('I_VEN_PRE').AsInteger;

      VpfCodVendedor := Orcamento.FieldByName('I_COD_VEN').AsInteger;
      VpfCodCliente := Orcamento.FieldByName('I_COD_CLI').AsInteger;
      VpfCodPreposto :=  Orcamento.FieldByName('I_VEN_PRE').AsInteger;
      VpfCodEmpresa := Orcamento.FieldByName('I_COD_EMP').AsInteger;
    end;
    if Orcamento.FieldByName('I_TIP_ORC').AsInteger = Varia.TipoCotacaoAmostra then
    begin
      CotCadastro.FieldByName('VALAMOSTRA').AsFloat := CotCadastro.FieldByName('VALAMOSTRA').AsFloat + Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      CotCadastro.FieldByName('QTDMETROAMOSTRA').AsFloat := CotCadastro.FieldByName('QTDMETROAMOSTRA').AsFloat +FunProdutos.RQtdMetrosFita(Orcamento.FieldByName('C_COD_PRO').AsString,Orcamento.FieldByName('C_NOM_PRO').AsString,Orcamento.FieldByName('C_COD_UNI').AsString,Orcamento.FieldByName('N_QTD_PRO').AsFloat,Orcamento.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    end
    else
    begin
      CotCadastro.FieldByName('VALPEDIDO').AsFloat := CotCadastro.FieldByName('VALPEDIDO').AsFloat + Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      CotCadastro.FieldByName('QTDMETROPEDIDO').AsFloat := CotCadastro.FieldByName('QTDMETROPEDIDO').AsFloat +FunProdutos.RQtdMetrosFita(Orcamento.FieldByName('C_COD_PRO').AsString,Orcamento.FieldByName('C_NOM_PRO').AsString,Orcamento.FieldByName('C_COD_UNI').AsString,Orcamento.FieldByName('N_QTD_PRO').AsFloat,Orcamento.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    end;

    CotCadastro.FieldByName('VALTOTAL').AsFloat := CotCadastro.FieldByName('VALTOTAL').AsFloat + Orcamento.FieldByName('N_VLR_TOT').AsFloat;
    CotCadastro.FieldByName('QTDMETROTOTAL').AsFloat := CotCadastro.FieldByName('QTDMETROTOTAL').AsFloat +FunProdutos.RQtdMetrosFita(Orcamento.FieldByName('C_COD_PRO').AsString,Orcamento.FieldByName('C_NOM_PRO').AsString,Orcamento.FieldByName('C_COD_UNI').AsString,Orcamento.FieldByName('N_QTD_PRO').AsFloat,Orcamento.FieldByName('I_CMP_PRO').AsFloat, VpfErro);

    if VpfErro <> '' then
      Aviso(VpfErro);
    Orcamento.Next;
  end;
  if VpfCodClassificacao <> '' then
  begin
    VpfSeqEntrada := VpfSeqEntrada + 1;
    CotCadastro.FieldByName('SEQENTRADA').AsInteger := VpfSeqEntrada;
    CotCadastro.post;
  end;
  Orcamento.close;
  CotCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ImprimeEtiquetaProdutoComCodigoBarra(
  VpaDCotacao: TRBDOrcamento);
var
  VpfFunArgox: TRBFuncoesArgox;
begin
   VpfFunArgox:=  TRBFuncoesArgox.cria(Varia.PortaComunicacaoImpTermica);
   VpfFunArgox.ImprimeEtiquetaProdutoComCodigoBarra10x3e5(VpaDCotacao);
   VpfFunArgox.Free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ImprimeEtiquetaSeparacaoPedido(VpaDCotacao : TRBDOrcamento);
var
  VpfEtiquetas : TList;
  VpfLaco : Integer;
  VpfDProCotacao : TRBDOrcProduto;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfDProduto : TRBDProduto;
  VpfFunArgox : TRBFuncoesArgox;
begin
  if varia.PortaComunicacaoImpTermica <> '' then
  begin
    VpfEtiquetas := TList.create;
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      if VpfDProCotacao.IndImprimirEtiquetaSeparacao then
      begin
        if VpfDProCotacao.QtdBaixadoNota < VpfDProCotacao.QtdProduto then
        begin
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,VpaDCotacao.CodEmpFil,VpfDProCotacao.SeqProduto);
          VpfDEtiqueta := TRBDEtiquetaProduto.cria;
          VpfEtiquetas.Add(VpfDEtiqueta);
          VpfDEtiqueta.Produto := VpfDProduto;
          VpfDEtiqueta.CodCor := VpfDProCotacao.CodCor;
          VpfDEtiqueta.QtdOriginalEtiquetas := RetornaInteiro(VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota);
          VpfDEtiqueta.QtdEtiquetas := RetornaInteiro(VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota);
//          VpfDEtiqueta.QtdOriginalEtiquetas := RetornaInteiro(VpfDProCotacao.QtdProduto);
//          VpfDEtiqueta.QtdEtiquetas := RetornaInteiro(VpfDProCotacao.QtdProduto);
          VpfDEtiqueta.NomCor := VpfDProCotacao.DesCor;
          VpfDEtiqueta.NumPedido := VpaDCotacao.LanOrcamento;
          VpfDEtiqueta.Cliente := IntToStr(VpaDCotacao.CodCliente)+ ' - '+ FunClientes.RNomCliente(IntTosTr(VpaDCotacao.CodCliente));
        end;
      end;
    end;
    if VpfEtiquetas.Count > 0  then
    begin
      VpfFunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
      VpfFunArgox.ImprimeEtiquetaProduto100X38(VpfEtiquetas);
      VpfFunArgox.free;
    end;

    FreeTObjectsList(VpfEtiquetas);
    VpfEtiquetas.free;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ImprimeEtiquetaVolume(VpaDCotacao: TRBDOrcamento);
var
  VpfFunArgox: TRBFuncoesArgox;
begin
  if varia.TipoModeloEtiquetaVolume = me5X2Argox then
    begin
       VpfFunArgox:=  TRBFuncoesArgox.cria(Varia.PortaComunicacaoImpTermica);
       VpfFunArgox.ImprimeEtiquetaVolumeCotacao5x2e5(VpaDCotacao);
       VpfFunArgox.Free;
    end;
end;

end.


