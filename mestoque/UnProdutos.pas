unit UnProdutos;
//revisado o as
//           =*
//           *=
//          .edit;
//          .post;

interface

uses
    Windows, Db, DBTables, classes, sysUtils, painelGradiente, ConvUnidade, UnAmostra,
    UnMoedas, UnCodigoBarra, UnClassificacao, Graphics, UnDados, UnDadosProduto,
    SQLExpr, tabela, CGrades, constantes,Clipbrd, Jpeg;

// FUNÇÕES DAS OPERAÇÕES DE ESTOQUE
//-----------------------------------
// VE  Venda
// CO  Compra
// DV  Devolução de Venda
// DC  Devolução de Compra
// TS  Transferência Saída
// TE  Transferência Entrada
// OS  Outros Saída
// OE  Outro Entrada
//-------------------------------------


// calculos
type
  TCalculosProduto = class
  private
    calcula : TSQLQuery;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection); virtual;
    destructor destroy; override;
    function CalculaQdadeEstoqueProduto( VpaSeqProduto,VpaCodCor,VpaCodTamanho :Integer) : Double;
    Function UnidadePadrao( SequencialProduto : Integer ) : string;
    Function MoedaPadrao( SequencialProduto : Integer ) : Integer;
    function ValorDeVenda( SequencialProduto, CodigoTabela,VpaCodTamanho : Integer ) : double;
    function PercMaxDesconto( SequencialProduto, CodigoTabela : Integer ) : double;
    function CalculaEstoqueProduto( SequencialProduto : Integer; CodigoEmpFil : Integer ) : integer;
    function MascaraBarra( codBarra : Integer ) : string;
end;

// localizacao
Type
  TLocalizaProduto = class(TCalculosProduto)
  public
    procedure LocalizaProduto(Tabela : TDataSet; CodProduto : string);
    procedure LocalizaProdutoClassificacao(Tabela : TDataSet; CodProduto, CodClassificacaoBase : string);
    procedure LocalizaSeqProdutoClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
    procedure LocalizaSeqProdutoQdadeClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
    procedure LocalizaProdutoSequencial(Tabela : TDataSet; SequencialProduto : string);
    procedure LocalizaProdutoSequencialQdade(Tabela : TDataSet; VpaSeqProduto, VpaCodCor,VpaCodTamanho : Integer);
    procedure LocalizaMovQdadeSequencial(VpaTabela : TDataSet; VpaCodFilial, VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer);
    procedure LocalizaOperacaoEstoque(VpaTabela : TDataSet; VpaCodOperacao : integer );
    procedure LocalizaEstoque(Tabela : TDataSet; Lancamento : string);
    procedure LocalizaEstoqueProduto(Tabela : TDataSet; SeqPro : Integer);
    procedure LocalizaProdutoEmpresa(Tabela : TDataSet);
    procedure LocalizaProdutoTabelaPreco(Tabela : TDataSet;  VpaCodTabela,VpaSeqProduto,VpaCodCliente : string );
    procedure LocalizaNotaEntradaEstoque(VpaTabela : TDataSet;  VpaCodFilial,VpaSeqNota : integer );
    procedure LocalizaNotaSaidaEstoque(Tabela : TDataSet;  VpaCodFilial, VpaSeqNota : integer );
    procedure LocalizaCadTabelaPreco(Tabela : TDataSet;  CodTabela : Integer);
end;

// funcoes
type
  TFuncoesProduto = class(TLocalizaProduto)
  private
      AUX,
      Tabela,
      Tabela2,
      ProProduto : TSQLQUERY;
      ProCadastro,
      ProCadastro2 : TSQL;
      DataBase : TSQLCONNECTION;
      FunAmostra: TRBFuncoesAmostra;
    function RSeqEtiquetadoDisponivel(VpaCodFilial,VpaLanOrcamento : Integer) : Integer;
    function RSeqLogFracaoOpConsumo(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqConsumo : Integer):Integer;
    function REtiquetaPedido(VpaDEtiquetaOriginal : TRBDEtiquetaProduto;VpaNumPedido, VpaQtdEtiquetado : Integer):TRBDEtiquetaProduto;
    function RSeqConsumoFracaoOpDisponivel(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer):Integer;
    function RSeqEstoqueNumeroSerieDisponivel(VpaCodFilial, VpaSeqProduto, VpaCodCor,VpaCodTamanho : Integer):Integer;
    function RSeqDefeitoDisponivel : Integer;
    function RSeqLog : Integer;
    function RSeqConsumoLog : Integer;
    function RSeqBarraDisponivel(VpaSeqProduto : Integer):Integer;
    function RSeqReservaExcessoDisponivel : Integer;
    function RSeqReservaProdutoDisponivel : Integer;
    function RDBaixaConsumoOp(VpaBaixas : TList;VpaSeqProduto,VpaCodCor : Integer; VpaIndMaterialExtra : Boolean):TRBDConsumoFracaoOP;
    function RCodProdutoDisponivelpelaClassificacao(VpaCodClassificacao : String):String;
    function RQtdMetrosBarraProduto(VpaSeqProduto : Integer):Double;
    function RPrecoVendaeCustoProduto(VpaDProduto : TRBDProduto;VpaCodCor,VpaCodTamanho : Integer):TList;
    procedure CKitsProdutos(VpaSeqProduto : String; VpaSeqKit : TStringList);
    procedure CarDOperacaoEstoque(VpaDOperacao : TRBDOperacaoEstoque;VpaCodOperacao: Integer);
    procedure CarDBaixaOPConsumoProduto(VpaCodFilial, VpaSeqOrdem : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
    procedure CarConsumoProdutoBastidor(VpaSeqProduto : Integer; VpaDConsumo :TRBDConsumoMP);
    procedure CarQtdMinimaProduto(VpaCodFilial, VpaSeqProduto, VpaCor, VpaCodTamanho : Integer; var VpaQtdMinima, VpaQtdPedido, VpaValCusto : Double); overload;
    procedure CarQtdMinimaProduto(VpaCodFilial, VpaCor: Integer; VpaDProduto: TRBDProduto); overload;
    function GravaDBaixaConsumoFracaoLog(VpaDBaixa : TRBDConsumoFracaoOP; VpaCodUsuario : Integer): String;
    function GravaDBaixaConsumoFracaoProduto(VpaCodigoFilial, VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario: Integer; VpaBaixas: TList): String;
    function GravaDBaixaConsumoOPProduto(VpaCodigoFilial, VpaSeqOrdem, VpaCodUsuario : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
    function GravaDConsumoMPBastidor(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
    function GravaLogProduto(VpaSeqProduto : Integer; VpaCodProduto :String): String;
    function GravaLogConsumoProduto(VpaSeqProduto,VpaCodCor: Integer;VpaCodProduto : string): String;
    procedure ExcluiMovimentoEstoquePorData(VpaDatInicial, VpaDatFinal : TDateTime);
    function ReprocessaEstoqueCotacao(VpaDatInicial, VpaDatFinal : TDateTime) : String;
    function ReprocessaEstoqueCompras(VpaDatInicial, VpaDatFinal : TDateTime) : String;
    function AdicionaConsumoExtraFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):string;
    procedure CopiaDEtiqueta(VpaDEtiquetaOrigem, VpaDEtiquetaDestino : TRBDEtiquetaProduto);
    procedure SincronizarConsumoAmostraProduto(VpaDProduto: TRBDProduto; VpaConsumosAmostra: TList);
    procedure ImportaEstoqueProdutAExcluir(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
    procedure ImportaProdutofornecedor(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
    procedure ImportaEstoqueTecnico(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
    function BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;Var VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):Boolean;
    function GeraCodigoBarrasEAN13 : string;
    procedure OrdenaTabelaPrecoProduto(VpaDProduto : TRBDProduto);
    function RValMateriaPrimaCadarco(VpaDProduto : TRBDProduto):Double;
    function RValCustoTear(VpaDProduto : TRBDProduto) : Double;
    function RMateriPrimaOrcamentoCadarco(VpadProduto : TRBDProduto;VpaSeqMateriaPrima : Integer):TRBDProdutoFioOrcamentoCadarco;
    function ExcluiEstoqueReservaProduto(VpaSeqProduto, VpaCodCor: Integer; VpaQtdProduto: Double): String;
    function RPrecoVenda(VpaNomServico: String): Double;
    function RSeqProdutoPeloNome(VpaNomProduto:String): integer;
  public
    ConvUnidade : TConvUnidade;
    ValidaUnidade : TValidaUnidade;
    UnMoeda : TFuncoesMoedas;
    UnCla : TFuncoesClassificacao;
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); override;
    destructor Destroy; override;
    function RSeqProdutoDisponivel: Integer;
    function RSeqChapaDisponivel : Integer;
    function RTamanhoMaiorCodigoProduto : Integer;
    function RCodigoClassificacaoProduto(VpaSeqProduto: integer): String;
    function RQuantidadeEstoqueProduto(VpaSeqProduto, VpaCodCor, VpaCodTamanho: integer):integer;
    function OperacoesEstornoValidas : String;
    function ProximoCodigoProduto( CodClassificacao : String; tamanhoPicture : Integer ) : string;
    procedure EstornaProximoCodigoProduto;
    function ProdutoExistente(CodigoPro, CodClassificacao : string) : Boolean;
    function VerificaMascaraClaPro : Boolean;
    function CalculaQdadePadrao( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; SequencialProduto : string) : Double;
    function CalculaValorPadrao( unidadeAtual, UnidadePadrao : string; ValorTotal : double; SequencialProduto : string) : Double;
    function CalculaQtdPecasemMetro(Var VpaIndice : Double;VpaAltProduto,VpaCodFaca,VpaCodMaquina,VpaCodBastidor,VpaQtdPcBastidor : Integer;VpaAltMolde,VpaLarMolde : Double) : Integer;
    function ValorPelaUnidade(VpaUnidadeDe,VpaUnidadePara : String;VpaSeqProduto : Integer; VpaValorUnitario : Double):Double;
    function TextoPossuiEstoque( QdadeVendidade, QdadeEstoque : double; UnidadePadrao : string ) : Boolean;
    function VerificaEstoque( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer) : Boolean;
    procedure TextoQdadeMinimaPedido(QdadeMin, QdadePed, QdadeBaixa : double);
    procedure VerificaPontoPedido(VpaCodFilial, VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer; VpaQtdBaixar : Double );
    function BaixaProdutoEstoque(VpaDProduto : TRBDProduto;VpaCodFilial, VpaCodOperacao,VpaSeqNotaF, VpaNroNota,VpaLanOrcamento, VpaCodigoMoeda, VpaCodCor,VpaCodTamanho : Integer;
                                  VpaDataMov : TdateTime; VpaQdadeVendida, VpaValorTotal : Double;
                                  VpaunidadeAtual, VpaNumSerie : string; VpaNotaFornecedor : Boolean;Var VpaSeqBarra : Integer;VpaGerarMovimentoEstoque : Boolean = true;VpaCodTecnico : Integer = 0;VpaSeqOrdemProducao : Integer = 0;VpaQtdChapas : Double = 0; VpaLarChapa : Double = 0;VpaComChapa  : Double = 0) : Boolean;overload;
    function BaixaEstoqueFiscal(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaUnidadeAtual,vpaUnidadePadrao,VpaTipoOperacao : String) : String;
    function BaixaEstoqueTecnicoouConsumoFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaDProduto : TRBDProduto;VpaQtdProduto : Double;VpaTipOperacao,VpaDesUM : String) : string;
    function BaixaEstoqueTecnico(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaTipOperacao : String) : string;
    function BaixaEstoqueDefeito(VpaSeqProduto,VpaCodTecnico : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesOperacaoEstoque, VpaDesDefeito : string):string;
    function BaixaEstoqueBarra(VpaSeqProduto,VpaCodCor,VpaSeqBarra : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesUMOriginal, VpaDesOperacaoEstoque : string):string;
    function BaixaEstoqueChapa(VpaDProduto : TRBDProduto;VpaCodCor,VpaCodTamanho, VpaCodfilial, VpaSeqNotaFor : Integer; VpaQtdChapas, VpaLarChapa,VpaComChapa, VpaPesoTotal: Double):string;
    function BaixaEstoqueNumeroSerie(VpaDProduto : TRBDProduto;VpaCodCor,VpaCodTamanho, VpaCodfilial : Integer; VpaNumSerie : String; VpaQtdProduto: Double; VpaTipoOperacaoEstoque: TRBDTipoOperacaoEstoque):string;
    function AtualizaEstoqueChapa(VpaDPlanoCorte : TRBDPlanoCorteCorpo) : string;
    function BaixaConsumoFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaCodCor : Integer;VpaDProduto : TRBDProduto; VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):string;
    function BaixaQtdAReservarProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
    function ReservaEstoqueProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
    function BaixaQtdReservadoOP(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao,  VpaTipOperacao :String):string;
    function BaixaProdutoReservadoSubmontagemOP(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer; var VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao,  VpaTipOperacao :String):string;
    function AtualizaQtdKit(VpaSeqProduto : String;VpaKit : Boolean):Boolean;
    function EstornaEstoque(VpaDMovimento : TRBDMovEstoque) : String;
    function AdicionaProdutoNaTabelaPreco(VpaCodTabela: Integer; VpaDProduto: TRBDProduto;VpaCodTamanho, VpaCodCor : Integer): String;
    function VerificaItemKit( codigoPro : string ) : Boolean;
    procedure ConverteMoedaTabela( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
    procedure ConverteMoedaProduto( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
    procedure AlteraAtividadeProduto( SequencialProduto : integer);
    function AlteraClassificacaoProduto(VpaSeqProduto : Integer;VpaNovaClassificacao : String) : String;
    function AlteraClassificacaoProdutoFamilia(VpaSeqProduto : Integer) : String;
    function AlteraProdutoParaSubstituicaoTributaria(VpaSeqProduto : Integer; VpaCodST: string) : string;
    function AlteraClassificacaoFiscalProduto(VpaSeqProduto : Integer;VpaCodClassificacao : string;VpaPerMVA : Double):string;
    function AlteraPrateleiraProduto(VpaSeqProduto: Integer; VpaDesPrateleira:String): String;
    function AlteraValorVendaProduto(VpaSeqProduto, VpaCodTamanho : Integer;VpaNovoValor :Double):String;
    procedure OrganizaTabelaPreco(VpaCodTabela, VpaCodCliente : integer; VpaSomenteAtividade : Boolean );
    procedure AtualizaValorKit( SeqProdutoKit, CodTabelaPreco : integer );
    procedure InseriProdutoClassificacaoFilial(Vpa_SeqPro_CodCla, VpaFilial, VpaEmpresa: string; NQtdMin, NQtdPed, VpaValCusto: Double; Classificacao : Boolean);
    procedure InsereProdutoFilial(VpaSeqProduto, VpaCodFilial, VpaCodCor, VpaCodTamanho: Integer; VpaQtdEstoque, VpaQtdMinima, VpaQtdPedido, VpaValCusto, VpaValCompra: Double; VpaCodBarra: String); overload;
    function InsereProdutoFilial(VpaCodFilial,VpaCodCor, VpaCodTamanho : Integer; VpaDProduto: TRBDProduto): String; overload;
    procedure AdicionaProdutosFilialAtiva;
    procedure AdicionaProdutoEtiquetado(VpaEtiquetas : TList);
    function InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaDProduto: TRBDProduto;VpaProdutoNovo : Boolean): String;overload;
    function InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaSeqProduto : Integer): String;overload;
    procedure InserePrecoProdutoCliente(VpaSeqProduto, VpaCodTabela, VpaCodCliente, VpaCodTamanho, VpaCodCor : Integer);
    function ExisteProduto(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;overload;
    function ExisteProduto(VpaCodProduto : String;var VpaSeqProduto : Integer;var VpaNomProduto, VpaUM : String):boolean;overload;
    function ExisteProduto(VpaCodProduto : String;var VpaSeqProduto : Integer;var VpaNomProduto : String):boolean;overload;
    function ExisteProduto(VpaCodProduto : String;var VpaSeqProduto : Integer;var VpaNomProduto : String;Var VpaDensidadeVolumetrica : Double;Var VpaEspessuraChapa : Double):boolean;overload;
    function ExisteProduto(VpaSeqProduto : Integer;Var VpaCodProduto, VpaNomProduto : String):Boolean;overload;
    function ExisteProduto(VpaCodProduto: String; VpaDProAmostra: TRBDConsumoAmostra): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String; VpaDProEspecialAmostra: TRBDItensEspeciaisAmostra): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String): Boolean; overload;
    function ExisteProduto(VpaCodProduto : String;VpaDProdutoPedido: TRBDProdutoPedidoCompra): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDSolicitacaoCompraItem): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDOrcamentoCompraProduto): Boolean; overload;
    function ExisteProduto(VpaCodProduto : string; VpaDProdutoOrcado : TRBDChamadoProdutoOrcado):Boolean;overload;
    function ExisteProduto(VpaCodProduto : string; VpaDProdutoaProduzir : TRBDChamadoProdutoaProduzir):Boolean;overload;
    function ExisteEntretela(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
    function ExisteTermoColante(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
    function ExisteCodigoProduto(Var VpaSeqProduto : Integer; Var VpaCodProduto, VpaNomProduto : String) : Boolean;
    function ExisteCodigoProdutoDuplicado(VpaSeqProduto : Integer;VpaCodProduto : String):Boolean;
    function ExisteNomeProduto(Var VpaSeqProduto : Integer;VpaNomProduto : string):Boolean;
    function ExisteCombinacao(VpaSeqProduto, VpaCodCombinacao : Integer):Boolean;
    function ExisteCor(VpaCodCor : String) : Boolean;overload;
    function ExisteCor(VpaCodCor : String;VpaDConcumoMP : TRBDConsumoMP) : Boolean;overload;
    function Existecor(VpaCodCor : String;var VpaNomCor : String):Boolean;overload;
    function ExisteEstagio(VpaCodEstagio : String;Var VpaNomEstagio :string):Boolean;
    function ExisteEstoqueCor(VpaSeqProduto, VpaCodCor : Integer):String;
    function ExisteProdutosDevolvidos(VpaCodCliente : String):Boolean;
    function ExisteDonoProduto(VpaCodDono : Integer):Boolean;
    function ExisteFaca(VpaCodFaca : Integer; VpaDFaca : TRBDFaca):Boolean;
    function ExisteMaquina(VpaCodMaquina : Integer;VpaDMaquina : TRBDMaquina):Boolean;
    function ExisteConsumo(VpaSeqProduto : Integer) : Boolean;
    function ExisteConsumoProdutoCor(VpaSeqProduto, VpaCodCor : Integer):Boolean;
    function ExisteBastidor(VpaCodBastidor : Integer;VpaDBastidor : TRBDBastidor):boolean;overload;
    function ExisteBastidor(VpaCodBastidor : String;Var VpaNomBastidor : String):boolean;overload;
    function ExisteBastidorDuplicado(VpaDConsumo : TRBDConsumoMP):boolean;
    function ExisteAcessorioDuplicado(VpaDProduto : TRBDProduto) : Boolean;
    function ExisteTabelaPrecoDuplicado(VpaDProduto : TRBDProduto) : Boolean;
    function ValidaAlterarValorUnitario( CorForm, CorCaixa : TColor ) : boolean;
    function ValidaDesconto( ValorProdutos,  Desconto : double; percentual : Boolean; CorForm, CorCaixa : TColor ) : boolean;
    function ColocaProdutoEmAtividade(VpaSequencial : String):string;
    procedure TiraProdutoAtividade(VpaSequencial : String);
    function CQtdValorCusto(VpaCodFilial, VpaSeqProduto, VpaCodCor, VpaCodTamanho : Integer; Var VpaQtdProduto, VpaValCusto : Double):Boolean;
    function RFreteRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaTotFrete : Double) : Double;
    function RDescontoRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaValDesconto : Double) : Double;
    function RFuncaoOperacaoEstoque(VpaCodOperacao : String):String;
    function RIcmsEstado(VpaEstado:String):Double;
    function RValorCusto(VpaCodEmpFil, VpaSeqProduto : Integer):Double;overload;
    function RValorCusto(VpaCodEmpFil, VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer):Double;overload;
    function RValorCompra(VpaCodEmpFil, VpaSeqProduto,VpaCodCor : Integer):Double;
    function RNomeFundo(VpaCodFundo : String):String;
    function RNomeTipoEmenda(VpaCodEmenda : String):String;
    function RNomeCor(VpaCodCor : String): String;
    function RNomeTamanho(VpaCodTamanho : Integer) : string;
    function RNomeTipoCorte(VpaCodTipoCorte : Integer) : String;
    function RSeqProduto(VpaCodProduto: string): Integer;
    function RNomeEmbalagem(VpaCodEmbalagem : Integer) : String;
    function RSeProdutoEstaAtivo(VpaSeqProduto: Integer): boolean;
    function RNomAcondicionamento(VpaCodAcondicionamento : Integer) : string;
    function RCodigoBarraProduto(VpaCodFilial, VpaSeqProduto, VpaCodCor, VpaCodTamanho : Integer) : string;
    function RQtdEmbalagem(VpaCodEmbalagem: integer): integer;
    function RNomTabelaPreco(VpaCodTabelaPreco : Integer) : String;
    function RQtdPecaemMetro(VpaAltProduto, VpaLarProduto, VpaQtdProvas : Integer;VpaAltMolde, VpaLarMolde : double;VpaIndAltFixa : Boolean; Var VpaIndice : double):Integer;
    function RCodBarrasEAN13Disponivel : String;
    function ExportaProdutosParaServicos: String;
    function ExportaProdutosParaServicosTabelaPreco: String;
    function AdicionarProdutosFilial: String;
    function RUMMTCMBR(VpaCodUnidade : String):string;
    function PrincipioAtivoControlado(VpaCodPrincipio : Integer) : boolean;
    procedure AtualizaValorCusto(VpaSeqProduto,VpaCodFilial, VpaCodMoeda : Integer; VpaUniPadrao, VpaUniProduto,VpaFuncaoOperacao : String;VpaCodCor,VpaCodTamanho : Integer;VpaQtdProduto, VpaVlrCompra,VpaTotCompra,VpaVlrFrete,VpaPerIcms, VpaPerIPI, VpaValDescontoNota, VpaValSubstituicaoTributaria: Double;VpaIndFreteEmitente : Boolean);
    function AtualizaCodEan(VpaSeqProduto,VpaCodCor : Integer;VpaCodBarras : String):String;
    function AtualizaValorVendaAutomatico(VpaSeqProduto : Integer;VpaValCusto : Double):string;
    function AtualizaEmbalagem(VpaSeqProduto,VpaCodEmbalagem : Integer):string;
    function AtualizaComposicao(VpaSeqProduto,VpaCodComposicao : Integer):string;
    procedure CarDMovimentoEstoque(VpaTabela : TDataSet;VpaDMovimento : TRBDMovEstoque);
    procedure CarDProduto(VpaDProduto: TRBDProduto; VpaCodEmpresa: Integer = 0; VpaCodFilial: Integer = 0; VpaSeqProduto: Integer = 0);
    procedure CarCodNomProduto(VpaSeqproduto : Integer;var VpaCodProduto,VpaNomProduto : string);
    procedure CarProdutoFaturadosnoMes(VpaDatInicio, VpaDatFim : TDateTime;VpaFilial : Integer);
    procedure CarDCombinacao(VpaDProduto : TRBDProduto);
    procedure CarDEstagio(VpaDProduto : TRBDProduto);
    procedure CarDFornecedores(VpaDProduto : TRBDProduto);
    procedure CarDEstoque1(VpaDProduto: TRBDProduto; VpaCodFilial, VpaSeqProduto: Integer;VpaCodCor : Integer = 0;VpaCodTamanho : Integer = 0);
    procedure CarDPreco(VpaDProduto: TRBDProduto; VpaCodEmpresa, VpaSeqProduto: Integer);
    procedure CarDValCusto(VpaDProduto: TRBDProduto; VpaCodFilial : Integer);
    procedure CarDProdutoFornecedor(VpaCodFornecedor: Integer;VpaDProtudoPedido: TRBDProdutoPedidoCompra);
    procedure CarDFilialFaturamento(VpaDProduto: TRBDProduto);
    procedure CarFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList);
    procedure CarConsumoProduto(VpaDProduto : TRBDProduto;VpaCorKit : Integer);
    procedure ApagaSubMontagensdaListaConsumo(VpaDProduto : TRBDProduto);
    procedure CarProdutoImpressoras(VpaSeqProduto : Integer;VpaImpresoras : TList);
    procedure CarAcessoriosProduto(VpaDProduto : TRBDProduto);
    procedure CarDBaixaConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
    procedure CarDBaixaFracaoConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList;VpaCarregarSubMontagem, VpaConsumoAExcluir : Boolean);
    procedure CarDEstoqueChapa(VpaSeqProduto : Integer;VpaChapas : TList);
    procedure CarDProdutoInstalacaoTear(VpaDProduto : TRBDProduto;VpaGrade : TRBStringGridColor);
    procedure CarDProdutoInstalacaoTearRepeticoes(VpaDProduto : TRBDProduto);
    procedure CarPerComissoesProduto(VpaSeqProduto,VpaCodVendedor : Integer;Var VpaPerComissaoProduto : Double;Var VpaPerComissaoClassificacao : Double;var VpaPerComissaoVendedor : Double);
    procedure CarValVendaeRevendaProduto(VpaCodTabelaPreco, VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaCodCliente : Integer;Var VpaValVenda : Double;Var VpaValRevenda : Double;Var VpaValTabelaPreco, VpaPerMaximoDesconto : Double);
    procedure CarFiosOrcamentoCadarco(VpaDProduto : TRBDProduto);
    procedure CarMateriaPrimaOrcamentoCadarco(VpaDProduto : TRBDProduto);
    function RMoedaProduto(VpaCodEmpresa, VpaSeqProduto : String) : integer;
    function RCombinacao(VpaDProduto : TRBDProduto;VpaCodCombinacao : Integer):TRBDCombinacao;
    function RSeqReferenciaDisponivel(VpaSeqProduto, VpaCodCliente : Integer): Integer;
    function RReferenciaProduto(VpaSeqProduto,VpaCodCliente : Integer; VpaCodCor : String):String;
    function CarProdutodaReferencia(VpaDesReferencia : String;VpaCodCliente : Integer;Var VpaCodProduto : String; Var VpaCodCor : Integer) : Boolean;
    function RDesMMProduto(var VpaNomProduto : String) :String;
    function RComprimentoProduto(VpaSeqProduto : Integer):Integer;
    function REstagioProduto(VpaDProduto : TRBDProduto;VpaSeqEstagio : Integer):TRBDEstagioProduto;
    function RNomePrincipioAtivo(VpaCodPrincipio : Integer) : String;
    function RNomeProduto(VpaSeqProduto : Integer) : String;
    function RNomeClassificacao(VpaCodEmpresa : Integer;VpaCodClasssificacao : String):string;
    function RNomeComposicao(VpaCodComposicao : Integer):string;
    function RAlturaProduto(VpaSeqProduto : Integer) : Integer;
    function RValVendaTamanhoeCor(VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaCodCliente : Integer;Var ValPrecoTabela : Double):Double;
    procedure CarUnidadesVenda(VpaUnidades: TStrings);
    function RUnidadesParentes(VpaUM : String):TStringList;
    function RSeqCartuchoDisponivel : Integer;
    function RQtdIdealEstoque(VpaCodFilial, VpaSeqProduto, VpaCodCor : Integer): Double;
    function RQtdMetrosFita(VpaCodProduto,VpaNomProduto, VpaCodUM : string;VpaQtdProduto,VpaComprimentoProduto : Double; Var VpfErro : string):Double;
    function RTabelaPreco(VpaDProduto : TRBDProduto;VpaCodTabela,VpaCodCliente,VpaCodTamanho,VpaCodMoeda : Integer): TRBDProdutoTabelaPreco;
    function RQuilosChapa(VpaEspessuraChapa, VpaLarguraChapa, vpaComprimentoChapa,VpaQtdChapas, VpaIndiceVolumetrico : Double):double;
    function RCodProduto(VpaSeqProduto : integer): string;
    function CombinacaoDuplicada(VpaDProduto : TRBDProduto):Boolean;
    function FiguraGRFDuplicada(VpaFiguras : TList) : Boolean;
    function ExcluiProduto(VpaSeqProduto : Integer) : string;
    procedure ExcluiCombinacoes(VpaSeqProduto : String);
    procedure ExcluiEstoqueChapa(VpaCodFilial, VpaSeqNota : Integer);
    function ExcluiProdutoTabelaPreco(VpaCodtabela,VpaSeqProduto,VpaCodCliente : Integer):Boolean;
    procedure ExcluiMovimentoEstoque(VpaCodFilial,VpaLanEstoque,VpaSeqProduto : Integer);
    procedure ExcluiProdutoDuplicado(VpaSeqProdutoExcluir, VpaSeqProdutoDestino : Integer;VpaLog : TStrings);
    procedure ExcluiComposicaoFiguraGRF(VpaCodComposicao : Integer);
    procedure ExcluiInstalacaoRepeticao(VpaDProduto : TRBDProduto;VpaColuna : Integer);
    function GravaDProduto(VpaDProduto: TRBDProduto): String;
    function GravaDCombinacao(VpaDProduto: TRBDProduto):String;
    function GravaDMovimentoEstoque(VpaDMovimento : TRBDMovEstoque): String;
    function GravaDConsumoMP(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
    function GravaDEstagio(VpaDProduto : TRBDProduto) : String;
    function GravaDFornecedor(VpaDProduto: TRBDProduto): String;
    function GravaDAcessorio(VpaDProduto : TRBDProduto):string;
    function GravaDTabelaPreco(VpaDProduto : TRBDProduto):string;
    function GravaDEstoqueChapa(VpaSeqProduto : Integer;VpaChapas : TList) : string;
    function GravaDProdutoInstalacaoTear(VpaDProduto : TRBDProduto;VpaGrade : TRBStringGridColor):string;
    function GravaDProdutoInstalacaoTearRepeticao(VpaDProduto : TRBDProduto):string;
    function GravaDMateriaPrimaOrcamentoCadarco(VpaDProduto :TRBDProduto) : string;
    function GravaDFilialFaturamento(VpaDProduto: TRBDProduto): String;
    function GravaProdutoImpressoras(VpaSeqProduto : Integer; VpaImpressoras : TList):string;
    function GravaPesoCartucho(VpaDPesoCartucho : TRBDPesoCartucho;VpaDProduto : TRBDProduto):string;
    function GravaBaixaConsumoProduto(VpaCodigoFilial, VpaSeqOrdem, VpaSeqFracao, VpaCodUsuario : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
    function GravaFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList) : string;
    function GravaProdutoReservadoEmExcesso(VpaSeqProduto, VpaCodFilial,VpaSeqOrdem : Integer;VpaDesUM : String;VpaQtdEstoque, VpaQtdReservado, VpaQtdExcesso : Double):String;
    function GravaMovimentoProdutoReservado(VpaSeqProduto, VpaCodFilial,VpaSeqOrdem : Integer;VpaDesUM : String; VpaQtdReservado,VpaQtdInicial,VpaQtdAtual: Double;VpaTipMovimento : String):String;
    function ReferenciaProdutoDuplicada(VpaCodCliente,VpaSeqProduto, VpaSeqReferencia,VpaCodCor : Integer):Boolean;
    function ReprocessaEstoque(VpaMes, VpaAno : Integer): String;
    procedure ReAbrirMes(VpaData : TDateTime);
    procedure ReorganizaSeqEstagio(VpaDProduto : TRBDProduto);
    function CorReferenciaDuplicada(VpaDProduto : TRBDProduto):Boolean;
    function ConcluiDesenho(VpaSeqProduto, VpaCodCor, VpaSeqMovimento : Integer) : string;
    function ConcluiFichaTecnica(VpaCodFilial,VpaLanOrcamento, VpaSeqItem : Integer):string;
    procedure PreparaImpressaoEtiqueta(VpaEtiquetas : TList;VpaPosInicial : Integer);
    function CalculaNumeroSerie(VpaNumSerie : Integer) :string;
    function GeraCodigosBArras : String;
    procedure ConverteNomesProdutosSemAcento;
    procedure AdicionaTodasTabelasdePreco(VpaDProduto : TRBDProduto);
    function AdicionaRepeticaoInstalacaoTear(VpaDProduto : TRBDProduto; VpaColunaInicial, VpaColunaFinal,VpaQtdRepeticao : Integer) : String;
    procedure ImprimeEtiquetaPrateleira(VpaEstante, VpaPrateleiraInicial, VpaPrateleiraFinal : String;VpaNumeroInicial, VpaNumeroFinal : Integer);
    function ProdutoCadastradonaTabeladePreco(VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer):Boolean;
    function ExisteSeqChapaDuplicadoClasse(VpaChapas : TList):boolean;
    function ExisteSeqChapaDuplicado(VpaSeqProduto, VpaSeqChapa : Integer):string;
    function RecalculaCustoMateriaPrimaProjeto(VpaCodProjeto : Integer;VpaSomenteZerados : boolean;VpaSeqMateriaPrima : Integer) : string;
    function ImportaPrecoAmostra(VpaDProduto : TRBDProduto;VpaDAmostra : TRBDAmostra):string;
    function ImportaConsumoAmostra(VpaDProduto : TRBDProduto;VpaDAmostra : TRBDAmostra):string;
    function RTipoDestinoProduto(VpaNumDestinoProduto : Integer):TRBDDestinoProduto;
    function RTipoEmbalagemPVC(VpaNumEmbalagemPvc : Integer):TRBDTipoEmbalagemPvc;
    function RAlcaEmbalagemPvc(VpaAlcaEmbalagemPvc : integer) : TRBDAlcaEmbalagemPvc;
    function RImpEmbalagemPvc(VpaImpEmbalagemPvc : integer) : TRBDImpEmbalagemPvc;
    function RCabEmbalagemPvc(VpaCabEmbalagemPvc : integer) : TRBDCabEmbalagemPvc;
    function RSimCabEmbalagemPvc(VpaSimEmbalagemPvc : integer) : TRBDSimCabEmbalagemPvc;
    function RBotaoEmbalagemPvc(VpaBotaoEmbalagemPvc : integer) : TRBDBotaoEmbalagemPvc;
    function RCorBotaoEmbalagemPvc(VpaCorBotaoEmbalagem : integer): TRBDCorBotaoEmbalagemPvc;
    function RBolineEmbalagemPvc(VpaBolineEmbalagem : integer) : TRBDBolineEmbalagemPvc;
    function RZiperEmbalagemPvc(VpaZiperEmbalagem : integer) : TRBDZiperEmbalagemPvc;
    function RViesEmbalagemPvc(VpaViesEmbalagem : integer) : TRBDViesEmbalagemPvc;

    function RNumDestinoProduto(VpaTipoDestino : TRBDDestinoProduto) : Integer;
    function RNumEmbalagemPvc(VpaTipoEmbalagem : TRBDTipoEmbalagemPvc) : Integer;
    function RNumAlcaEmbalagemPvc(VpaAlcaEmbalagem: TRBDAlcaEmbalagemPvc) : integer;
    function RNumImpEmbalagemPvc(VpaImpEmbalagem : TRBDImpEmbalagemPvc) : integer;
    function RNumCabEmbalagemPvc(VpaCabEmbalagem : TRBDCabEmbalagemPvc) : integer;
    function RNumCorCabEmbalagemPvc(VpaSimEmbalagem : TRBDSimCabEmbalagemPvc) : integer;
    function RNumBotaoEmbalagemPvc(VpaBotaoEmbalagem : TRBDBotaoEmbalagemPvc) : integer;
    function RNumCorBotaoEmbalagemPvc(VpaCorBotaoEmbalagem : TRBDCorBotaoEmbalagemPvc) : integer;
    function RNumBolineEmbalagemPvc(VpaBolineEmbalagem : TRBDBolineEmbalagemPvc) : integer;
    function RNumZiperEmbalagemPvc(VpaZiperEmbalagem : TRBDZiperEmbalagemPvc): integer;
    function RNumViesEmbalagemPvc(VpaViesEmbalagemPvc : TRBDViesEmbalagemPvc): integer;
    function CalculaValorVendaCadarco(VpadProduto : TRBDProduto) : Double;
    function ProdutoTributado(VpaCodCST : String) : boolean;
    function ProdutoDestacaST(VpaCodCST : String) : boolean;
    function SalvaImagemdaAreaTransferenciaWindows(VpaDProduto : TRBDProduto) : string;
    function GravaCodigoBarraProdutos(VpaCodFilial, VpaSeqProduto, VpaCodCor, VpaCodTamanho: Integer; VpaCodBarra: String):String;
    function RQtdConsumidoProducao(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer;VpaDatInicio,VpaDatFim : TDateTime):double;
    function RQtdProdutosEmbalagem(VpaSeqProduto : Integer):integer;
 end;
Var
  FunProdutos : TFuncoesProduto;

implementation

uses constMsg, funSql, funstring, fundata, funnumeros, FunObjeto, UnOrdemProducao,
     FunValida, unContasAreceber , UnZebra, UnSistema, Funarquivos, dbclient;


{#############################################################################
                        TCalculo Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosProduto.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  calcula := TSQLQuery.Create(nil);
  calcula.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosProduto.destroy;
begin
  calcula.Destroy;
  inherited;
end;

{******************************************************************************}
function TCalculosProduto.CalculaQdadeEstoqueProduto(VpaSeqProduto,VpaCodCor,VpaCodTamanho :Integer ) : Double;
begin
  result := 0;
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQLAbreTabela(calcula, ' select N_QTD_PRO from MOVQDADEPRODUTO ' +
                                   ' where I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) +
                                   ' and I_COD_COR = '+IntToStr(VpaCodCor)+
                                   ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho)+
                                   ' and I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil));
    result := calcula.fieldByName('N_QTD_PRO').AsFloat;
    FechaTabela(calcula);
  end;
end;


{******************************************************************************}
Function TCalculosProduto.UnidadePadrao( SequencialProduto : Integer ) : string;
begin
  AdicionaSQLAbreTabela(calcula, ' Select C_COD_UNI from CadProdutos where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) );
  result := calcula.fieldByName('C_COD_UNI').AsString;
  FechaTabela(calcula);
end;

{****************** retorna a moeda padrao do produto *************************}
Function TCalculosProduto.MoedaPadrao( SequencialProduto : Integer ) : Integer;
begin
  AdicionaSQLAbreTabela(calcula, ' Select I_COD_MOE from CadProdutos where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) );
  result := calcula.fieldByName('I_COD_MOE').AsInteger;
  calcula.Close;
end;

{******************************************************************************}
function TCalculosProduto.ValorDeVenda( SequencialProduto, CodigoTabela,VpaCodTamanho : Integer ) : double;
begin
  AdicionaSQLAbreTabela(calcula, ' Select N_VLR_VEN from MovTabelaPreco where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) +
                                ' and i_cod_tab = ' + IntToStr(CodigoTabela) +
                                ' and I_COD_CLI = 0 '+
                                ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho));
  result := calcula.fieldByName('n_vlr_ven').AsCurrency;
  FechaTabela(calcula);
end;

function TCalculosProduto.PercMaxDesconto( SequencialProduto, CodigoTabela : Integer ) : double;
begin
  AdicionaSQLAbreTabela(calcula, ' Select N_PER_MAX from MovTabelaPreco where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) +
                                ' and i_cod_tab = ' + IntToStr(CodigoTabela)+
                                ' and I_COD_CLI = 0');
  result := calcula.fieldByName('n_per_max').AsCurrency;
  FechaTabela(calcula);
end;

function TCalculosProduto.CalculaEstoqueProduto( SequencialProduto : Integer; CodigoEmpFil : Integer ) : integer;
var
  MenorValor : double;
begin
  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula, ' select  sum(mov.n_qtd_pro) / max( kit.n_qtd_pro)  valor ' +
                             ' from MovQdadeProduto mov, Movkit Kit ' +
                             ' where  kit.i_pro_kit = ' + IntTostr(SequencialProduto) +
                             ' and '+SQLTextoRightJoin('mov.i_seq_pro', 'kit.i_seq_pro ') );

  if CodigoEmpFil > 10 then
    AdicionaSQLTabela(calcula,' and mov.i_emp_fil = ' + IntToStr(CodigoEmpFil) );

  AdicionaSQLTabela(calcula,' group by kit.i_seq_pro ');
  AbreTabela(calcula);

  MenorValor := calcula.fieldByname('valor').AsCurrency;
  while not Calcula.Eof do
  begin
    if MenorValor > calcula.fieldByname('valor').AsCurrency then
      MenorValor := calcula.fieldByname('valor').AsCurrency;
    calcula.Next;
  end;
  result := Trunc(MenorValor);
  if result < 0 then
    result := 0;
end;

function TCalculosProduto.MascaraBarra( codBarra : Integer ) : string;
begin
  AdicionaSQLAbreTabela(calcula, 'select c_cod_bar from cad_codigo_barra where i_cod_bar = ' +
                                 IntTostr(codBarra) );
  result := calcula.fieldByName('c_cod_bar').AsString;
end;

{#############################################################################
                        TLocaliza Produtos
#############################################################################  }

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProduto(Tabela : TDataSet; CodProduto : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where C_Cod_Pro = ''' + CodProduto + ''''+
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoClassificacao(Tabela : TDataSet; CodProduto, CodClassificacaoBase : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where C_Cod_Pro = ''' + CodProduto + ''''+
                               ' and C_Cod_Cla = ''' + CodClassificacaoBase + '''' +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaSeqProdutoClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where C_Cod_Cla = ''' + CodClassificacaoBase + '''' +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa));
end;


{******************************************************************************}
procedure TLocalizaProduto.LocalizaSeqProdutoQdadeClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos pro, ' +
                                ' MovQdadeProduto mov ' +
                                ' Where C_Cod_Cla like ''' + CodClassificacaoBase + '%''' +
                                ' and pro.I_seq_pro = mov.I_seq_pro ' +
                                ' and Mov.I_Emp_Fil = ' + IntToStr(varia.CodigoEmpFil) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoSequencial(Tabela : TDataSet; SequencialProduto : string);
begin
  AdicionaSQLAbreTabela(tabela, ' Select * from CADPRODUTOS ' +
                                ' Where I_SEQ_PRO = ' + SequencialProduto );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoSequencialQdade(Tabela : TDataSet; VpaSeqProduto, VpaCodCor,VpaCodTamanho : Integer);
begin
  AdicionaSQLAbreTabela(tabela, ' Select * ' +
                                ' From cadprodutos pro, ' +
                                ' MovQdadeProduto mov ' +
                                ' Where pro.i_seq_pro = ' +IntToStr(VpaSeqProduto) +
                                ' and pro.I_seq_pro = mov.I_seq_pro ' +
                                ' and Mov.I_Emp_Fil = ' + IntToStr(varia.CodigoEmpFil) +
                                ' and MOV.I_COD_COR = '+ IntToStr(VpaCodCor)+
                                ' and MOV.I_COD_TAM = '+IntToStr(VpaCodTamanho));
end;


{******************************************************************************}
procedure TLocalizaProduto.LocalizaMovQdadeSequencial(VpaTabela : TDataSet; VpaCodFilial, VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer);
begin
  if config.EstoqueCentralizado then
    VpaCodFilial := Varia.CodFilialControladoraEstoque;
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVQDADEPRODUTO'+
                               ' where I_EMP_FIL = ' + InttoStr(VpaCodFilial) +
                                ' and I_SEQ_PRO = ' + InttoStr(VpaSeqProduto) +
                                ' and I_COD_COR = '+ InttoStr(VpaCodCor)+
                                ' and I_COD_TAM = '+IntToStr(VpaCodTamanho));
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaOperacaoEstoque(VpaTabela : TDataSet; VpaCodOperacao : integer );
begin
  AdicionaSQLAbreTabela(VpaTabela, ' Select * from CADOPERACAOESTOQUE ' +
                                ' Where I_COD_OPE = ' + IntToStr(VpaCodOperacao) );
end;


procedure TLocalizaProduto.LocalizaEstoque(Tabela : TDataSet; Lancamento : string);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MovEstoqueProdutos where I_emp_fil = ' +
                                intToStr(Varia.CodigoEmpFil)  +
                                ' and i_lan_est = ' + lancamento );
end;

procedure TLocalizaProduto.LocalizaEstoqueProduto(Tabela : TDataSet; SeqPro : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MovEstoqueProdutos where I_emp_fil = ' +
                                intToStr(Varia.CodigoEmpFil)  +
                                ' and i_seq_pro = ' + IntToStr(SeqPro) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoEmpresa(Tabela : TDataSet );
begin
  AdicionaSQLAbreTabela(Tabela, ' SELECT * FROM CADPRODUTOS ' +
                                ' WHERE I_COD_EMP =  ' + IntTostr(varia.CodigoEmpresa));
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoTabelaPreco(Tabela : TDataSet;  VpaCodTabela,VpaSeqProduto,VpaCodCliente : string );
begin
  AdicionaSQLAbreTabela(Tabela, ' SELECT * FROM MovTabelaPreco' +
                                ' WHERE i_cod_emp =  ' + IntTostr(varia.CodigoEmpresa) +
                                ' and i_cod_tab = ' + VpaCodTabela +
                                ' and i_seq_pro = ' + VpaSeqProduto +
                                ' and I_COD_CLI = ' + VpaCodCliente);
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaNotaEntradaEstoque(VpaTabela : TDataSet; VpaCodFilial,VpaSeqNota : integer );
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVESTOQUEPRODUTOS ' +
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                        ' and I_NOT_ENT = ' + IntToStr(VpaSeqNota))
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaNotaSaidaEstoque(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : integer );
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVESTOQUEPRODUTOS Where ' +
                        ' I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                        ' and I_NOT_SAI = ' + IntToStr(VpaSeqNota))
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaCadTabelaPreco(Tabela : TDataSet;  CodTabela : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADTABELAPRECO ' +
                        ' Where I_COD_EMP = '+ IntToStr(varia.CodigoEmpresa) +
                        ' and I_COD_TAB = ' + IntToStr(CodTabela));
end;

{#############################################################################
                        TFuncoes Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesProduto.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  UnMoeda := TFuncoesMoedas.criar(nil,VpaBaseDados);
  UnCla := TFuncoesClassificacao.criar(nil,VpaBaseDados);
  DataBase := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := vpaBaseDados;
  Tabela2 := TSQLQuery.Create(nil);
  Tabela2.SQLConnection := vpaBaseDados;
  AUX := TSQLQuery.Create(nil);
  AUX.SQLConnection := vpaBaseDados;
  ProProduto := TSQLQuery.Create(nil);
  ProProduto.SQLConnection := vpaBaseDados;
  ProCadastro := TSQL.Create(nil);
  ProCadastro.ASQLConnection := vpaBaseDados;
  ProCadastro2 := TSQL.Create(nil);
  ProCadastro2.ASQLConnection := vpaBaseDados;
  ConvUnidade := TConvUnidade.create(nil);
  ConvUnidade.ADataBase := VpaBaseDados;
  ConvUnidade.AInfo.UniNomeTabela := 'MOVINDICECONVERSAO';
  ConvUnidade.AInfo.UniCampoDE := 'C_UNI_ATU';
  ConvUnidade.AInfo.UniCampoPARA := 'C_UNI_COV';
  ConvUnidade.AInfo.UniCampoIndice := 'N_IND_COV';
  ConvUnidade.AInfo.ProCampoIndice := 'I_IND_COV';
  ConvUnidade.AInfo.ProCampoCodigo := 'I_SEQ_PRO';
  ConvUnidade.AInfo.ProCampoFilial := 'I_COD_EMP';
  ConvUnidade.AInfo.ProNomeTabela := 'CADPRODUTOS';
  ConvUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ConvUnidade.AInfo.UnidadeUN := varia.UnidadeUN;
  ConvUnidade.AInfo.UnidadeKit := varia.UnidadeKit;
  ConvUnidade.AInfo.UnidadeBarra := varia.UnidadeBarra;
  ConvUnidade.AInfo.UnidadeQuilo := varia.UnidadeQuilo;
  ConvUnidade.AInfo.UnidadeMilheiro := varia.UnidadeMilheiro;

  ValidaUnidade := TValidaUnidade.create(nil);
  ValidaUnidade.ADataBase := VpaBaseDados;
  ValidaUnidade.AInfo.NomeTabelaIndice := 'MOVINDICECONVERSAO';
  ValidaUnidade.AInfo.CampoUnidadeDE := 'C_UNI_ATU';
  ValidaUnidade.AInfo.CampoUnidadePARA := 'C_UNI_COV';
  ValidaUnidade.AInfo.CampoIndice := 'N_IND_COV';
  ValidaUnidade.AInfo.UnidadeCX :=  Varia.UnidadeCX;
  ValidaUnidade.AInfo.UnidadeUN := Varia.UnidadeUN;
  ValidaUnidade.AInfo.UnidadeKit := Varia.UnidadeKit;
  ValidaUnidade.AInfo.UnidadeBarra := Varia.UnidadeBarra;
  ValidaUnidade.AInfo.UnidadeQuilo := Varia.UnidadeQuilo;
  ValidaUnidade.AInfo.UnidadeMilheiro := Varia.UnidadeMilheiro;

  FunAmostra:= TRBFuncoesAmostra.cria(ProCadastro.ASQLConnection);
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesProduto.Destroy;
begin
  UnMoeda.free;
  UnCla.Free;
  ConvUnidade.free;
  ValidaUnidade.free;
  FechaTabela(AUX);
  AUX.Destroy;
  FechaTabela(tabela);
  Tabela.Destroy;
  FechaTabela(tabela2);
  Tabela2.Destroy;
  ProCadastro.free;
  ProProduto.free;
  FunAmostra.Free;
  ProCadastro2.free;
  inherited;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeCor(VpaCodCor: String): String;
begin
  result := '';
  if (VpaCodCor <> '') and (VpaCodCor <> '0') then
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                              ' Where COD_COR = '+ VpaCodCor);
    result := Aux.FieldByName('NOM_COR').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeTamanho(VpaCodTamanho : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMTAMANHO FROM TAMANHO '+
                            ' Where CODTAMANHO = '+IntToStr(VpaCodTamanho));
  result := Aux.FieldByName('NOMTAMANHO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeTipoCorte(VpaCodTipoCorte : Integer) : String;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from TIPOCORTE '+
                            ' Where CODCORTE = '+ IntToStr(VpaCodTipoCorte));
  result := Aux.FieldByName('NOMCORTE').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeEmbalagem(VpaCodEmbalagem : Integer) : String;
begin
  AdicionaSQLAbreTabela(AUX,'Select NOM_EMBALAGEM FROM EMBALAGEM '+
                            ' Where COD_EMBALAGEM = '+ IntToStr(VpaCodEmbalagem));
  result := Aux.FieldByName('NOM_EMBALAGEM').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomAcondicionamento(VpaCodAcondicionamento : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMACONDICIONAMENTO FROM ACONDICIONAMENTO ' +
                            ' Where CODACONDICIONAMENTO = ' + IntToStr(VpaCodAcondicionamento));
  result := Aux.FieldByName('NOMACONDICIONAMENTO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomTabelaPreco(VpaCodTabelaPreco : Integer) : String;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_TAB FROM CADTABELAPRECO ' +
                            ' Where I_COD_TAB = ' + IntToStr(VpaCodTabelaPreco));
  result := Aux.FieldByName('C_NOM_TAB').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNumAlcaEmbalagemPvc(
  VpaAlcaEmbalagem: TRBDAlcaEmbalagemPvc): integer;
begin
  case VpaAlcaEmbalagem of
    aeEmBranco: result:= 0;
    aeSemAlca: result:= 1;
    aePadrao: result:= 2;
    aePequeno: result:= 3;
    aeGrande: result:= 4;
    aeCosturada: result:= 5;
    aeAlcaFita: result:= 6;
    aeAlcaSilicone: result:= 7;
  else
    result := -1;
  end;
end;

{******************************************************************************}
 function TFuncoesProduto.RNumBolineEmbalagemPvc(
  VpaBolineEmbalagem: TRBDBolineEmbalagemPvc): integer;
begin
  case VpaBolineEmbalagem of
    boEmBranco: result:= 0 ;
    boNao: result:= 1 ;
    bo1: result:= 2;
    bo2: result:= 3;
    bo3: result:= 4;
    boLiner: result:= 5;
  else
    result := -1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumBotaoEmbalagemPvc(
  VpaBotaoEmbalagem: TRBDBotaoEmbalagemPvc): integer;
begin
  case VpaBotaoEmbalagem of
    beEmBranco: result:= 0;
    beNao: result:= 1;
    be1: result:= 2;
    be2: result:= 3;
    be3: result:= 4;
  else
    result := -1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumCabEmbalagemPvc(
  VpaCabEmbalagem: TRBDCabEmbalagemPvc): integer;
begin
  case VpaCabEmbalagem of
    ceEmbranco: result := 0;
    ceNao: result:= 1 ;
    ce8Cm: result:= 2;
    ce10Cm: result:= 3 ;
    ce14Cm: result:= 4;
    ceGancheira: result:= 5;
  else
    result := -1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumCorBotaoEmbalagemPvc(
  VpaCorBotaoEmbalagem: TRBDCorBotaoEmbalagemPvc): integer;
begin
 case VpaCorBotaoEmbalagem of
   cbEmBranco: result:= 0 ;
   cbeBranco: result:= 1 ;
   cbePreto: result:= 2;
 else
    result := -1;
 end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumCorCabEmbalagemPvc(
  VpaSimEmbalagem: TRBDSimCabEmbalagemPvc): integer;
begin
  case VpaSimEmbalagem of
    seEmBranco: result := 0;
    seLado: result := 1;
    seOposto: result := 2;
    seLateral: result := 3;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumDestinoProduto(VpaTipoDestino: TRBDDestinoProduto): Integer;
begin
  case VpaTipoDestino of
    dpRevenda: result := 0;
    dpMateriaPrima: result := 1;
    dpEmbalagem: result := 2;
    dpProdutoEmProcesso: result := 3;
    dpProdutoAcabado: result := 4;
    dpSubProduto: result := 5;
    dpProdutoIntermediario: result := 6;
    dpMaterialdeUsoeConsumo: result := 7;
    dpAtivoImobilizado: result := 8;
    dpServicos: result := 9;
    dpOutrosInsumo: result := 10;
    dpOutras: result := 11;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumEmbalagemPvc(
  VpaTipoEmbalagem: TRBDTipoEmbalagemPvc): Integer;
begin
  case VpaTipoEmbalagem of
    teEmBranco: Result:= 0;
    teCosturado: result := 1;
    teSoldada: result := 2;
    teSoldadaZiper: result := 3;
    teTnt : Result := 4;
    teMateriaPrima : Result := 5;
  else
    result := -1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumImpEmbalagemPvc(
  VpaImpEmbalagem: TRBDImpEmbalagemPvc): integer;
begin
  case VpaImpEmbalagem of
    ieEmBranco: result := 0;
    ieNao: result := 1 ;
    ie1: result := 2;
    ie2: result := 3;
    ie3: result := 4;
    ie4: result := 5;
    ie5: result := 6;
    ie6: result := 7;
    ie7: result := 8;
    ie8: result := 9;
  else
    result := -1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumViesEmbalagemPvc(
  VpaViesEmbalagemPvc: TRBDViesEmbalagemPvc): integer;
begin
  case VpaViesEmbalagemPvc of
    veEmBranco: result := 0;
    vePvcTran: result := 1;
    vePvcCol: result := 2;
    veViesTn: result := 3;
    veViesAl: result := 4;
    veViesLi: result := 5;
  else
    result := -1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNumZiperEmbalagemPvc(
  VpaZiperEmbalagem: TRBDZiperEmbalagemPvc): integer;
begin
  case VpaZiperEmbalagem of
    zeEmBranco: result := 0;
    zeNao: result := 1;
    zeNylon3: result := 2;
    zeNylon6: result := 3;
    zePvc: result := 4;
    zeZiper: result := 5;
  else
    result := -1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqEstoqueNumeroSerieDisponivel(VpaCodFilial,VpaSeqProduto, VpaCodCor, VpaCodTamanho: Integer): Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQESTOQUE) ULTIMO from ESTOQUENUMEROSERIE ' +
                            ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                            ' AND SEQPRODUTO = ' +IntToStr(VpaSeqProduto)+
                            ' AND CODCOR = ' +IntToStr(VpaCodCor)+
                            ' AND CODTAMANHO = ' +IntToStr(VpaCodTamanho));
  Result := AUX.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqEtiquetadoDisponivel(VpaCodFilial,VpaLanOrcamento : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQETIQUETA) ULTIMO FROM PRODUTOETIQUETADOCOMPEDIDO '+
                            ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                            ' and LANORCAMENTO = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqLog: Integer;
begin
  AdicionaSQLAbreTabela(AUX, ' SELECT COUNT(SEQLOG) ULTIMO FROM PRODUTOLOG');
  Result := AUX.FieldByName('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqLogFracaoOpConsumo(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqConsumo : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQLOG) ULTIMO From FRACAOOPCONSUMOLOG '+
                            ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                            ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                            ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                            ' and SEQCONSUMO = '+IntToStr(VpaSeqConsumo));
  result := AUX.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.REtiquetaPedido(VpaDEtiquetaOriginal : TRBDEtiquetaProduto;VpaNumPedido, VpaQtdEtiquetado : Integer):TRBDEtiquetaProduto;
begin
  Result := TRBDEtiquetaProduto.cria;
  CopiaDEtiqueta(VpaDEtiquetaOriginal,result);
  result.NumPedido := VpaNumPedido;

  result.IndParaEstoque := false;
  result.QtdOriginalEtiquetas := VpaQtdEtiquetado;
  result.QtdEtiquetas := result.QtdOriginalEtiquetas;
  result.QtdProduto := result.QtdOriginalEtiquetas;

  VpaDEtiquetaOriginal.QtdOriginalEtiquetas := VpaDEtiquetaOriginal.QtdOriginalEtiquetas - VpaQtdEtiquetado;
  VpaDEtiquetaOriginal.QtdEtiquetas := VpaDEtiquetaOriginal.QtdOriginalEtiquetas;
  VpaDEtiquetaOriginal.QtdProduto := VpaDEtiquetaOriginal.QtdOriginalEtiquetas;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqConsumoFracaoOpDisponivel(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer):Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQCONSUMO) ULTIMO from FRACAOOPCONSUMO '+
                            ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                            ' AND SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                            ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
  result := AUX.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqConsumoLog: Integer;
begin
  AdicionaSQLAbreTabela(AUX, ' SELECT MAX(SEQLOG) ULTIMO FROM CONSUMOPRODUTOLOG');
  Result := AUX.FieldByName('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqDefeitoDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQDEFEITO) ULTIMO from PRODUTODEFEITO ');
  Result := AUX.FieldByName('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeProdutoEstaAtivo(VpaSeqProduto: Integer): boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select C_ATI_PRO FROM CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  if AUX.FieldByName('C_ATI_PRO').AsString = 'S' then
    Result:= true
  else
    Result:= false;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqBarraDisponivel(VpaSeqProduto : Integer):Integer;
begin
  AdicionaSQLAbreTabela(ProCadastro2,'Select * from CADPRODUTOS '+
                                    ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  ProCadastro2.edit;
  ProCadastro2.FieldByName('I_ULT_BAR').AsInteger := ProCadastro2.FieldByName('I_ULT_BAR').AsInteger +1;
  result := ProCadastro2.FieldByName('I_ULT_BAR').AsInteger;
  ProCadastro2.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro2);
  ProCadastro2.post;
  ProCadastro2.close;
end;

{******************************************************************************}
function TFuncoesProduto.RDBaixaConsumoOp(VpaBaixas : TList;VpaSeqProduto,VpaCodCor : Integer;VpaIndMaterialExtra : Boolean):TRBDConsumoFracaoOP;
var
  VpfLaco : Integer;
  VpfDBaixa : TRBDConsumoFracaoOP;
begin
  result := nil;
  for VpfLaco := 0 to VpaBaixas.Count - 1 do
  begin
    VpfDBaixa := TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if (VpfDBaixa.SeqProduto = VpaSeqProduto) and (VpfDBaixa.CodCor = VpaCodCor) and
       (VpfDBaixa.IndMaterialExtra = VpaIndMaterialExtra) then
    begin
      result := VpfDBaixa;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RCodProduto(VpaSeqProduto: integer): string;
begin
  AdicionaSQLAbreTabela(Aux, 'SELECT C_COD_PRO FROM CADPRODUTOS ' +
                             ' WHERE I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));
  result:= aux.FieldByName('C_COD_PRO').AsString;
  aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RCodProdutoDisponivelpelaClassificacao(VpaCodClassificacao : String):String;
var
  VpfUltimoCodigo : String;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(C_COD_PRO) ULTIMO from CADPRODUTOS '+
                            ' Where C_COD_CLA = '''+VpaCodClassificacao+'''');
  if AUX.FieldByname('ULTIMO').AsString = '' then
    Result := VpaCodClassificacao + AdicionaCharE('0','1',length(Varia.MascaraPro))
  else
  begin
    VpfUltimoCodigo := DeletaEspaco(AUX.FieldByname('ULTIMO').AsString);
    if (varia.CNPJFilial = CNPJ_PERFOR) then
    begin
      if ExisteLetraString('R',VpfUltimoCodigo) then
        VpfUltimoCodigo := CopiaAteChar(VpfUltimoCodigo,'R');
    end;

    result := AdicionaCharE('0',IntToStr(StrtoInt(VpfUltimoCodigo)+1),length(Varia.MascaraPro));
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdMetrosBarraProduto(VpaSeqProduto : Integer):Double;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_IND_COV from CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  result := AUX.FieldByName('I_IND_COV').AsFloat;
end;

{******************************************************************************}
function TFuncoesProduto.RPrecoVenda(VpaNomServico: String): Double;
var
  VpfNomServico: String;
  VpfSeqProduto: Integer;
begin
  VpfNomServico := copy(VpaNomServico,8,43);
  VpfSeqProduto:= RSeqProdutoPeloNome(VpfNomServico);
  AdicionaSQLAbreTabela(Tabela2,'Select N_VLR_VEN from MOVTABELAPRECO '+
                            ' Where I_SEQ_PRO = '+IntToStr(VpfSeqProduto));
  result := Tabela2.FieldByName('N_VLR_VEN').AsFloat;
end;

{******************************************************************************}
function TFuncoesProduto.RPrecoVendaeCustoProduto(VpaDProduto : TRBDProduto;VpaCodCor,VpaCodTamanho : Integer):TList;
var
  vpfLaco : Integer;
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  result := TList.create;
  for vpfLaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDTabelaPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[Vpflaco]);
    if  (VpfDTabelaPreco.CodCor = VpaCodCor) and
        (VpfDTabelaPreco.CodTamanho = VpaCodTamanho) then
      Result.add(VpfDTabelaPreco);
  end;
end;

{********************* carrega os kits do produto *****************************}
function TFuncoesProduto.RCabEmbalagemPvc(
  VpaCabEmbalagemPvc: integer): TRBDCabEmbalagemPvc;
begin
  case VpaCabEmbalagemPvc of
    0 : result := ceEmBranco;
    1 : result := ceNao;
    2 : result := ce8Cm;
    3 : result := ce10Cm;
    4 : Result := ce14Cm;
    5 : Result := ceGancheira;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RCodBarrasEAN13Disponivel : String;
begin
  result := FloatToStr(varia.NumPrefixoCodEAN)+AdicionaCharE('0',FloatToSTr(Varia.NumUltimoCodigoEAN+1),2);
  result := result+DigitoVerificadEAN13(result);
  if length(Result) > 13  then
    result := 'FIM FAIXA';

  Varia.NumUltimoCodigoEAN := Varia.NumUltimoCodigoEAN+1;
  ExecutaComandoSql(AUX,'UPDATE CFG_PRODUTO SET I_ULT_EAN = '+IntToStr(Varia.NumUltimoCodigoEAN));
end;

{******************************************************************************}
function TFuncoesProduto.RCodigoBarraProduto(VpaCodFilial, VpaSeqProduto, VpaCodCor,VpaCodTamanho: Integer): string;
begin
  if Config.CodigodeBarraCodCorETamanhoZero then
  begin
    AdicionaSQLAbreTabela(Aux,'SELECT C_COD_BAR FROM MOVQDADEPRODUTO ' +
                              ' WHERE I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                              ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) +
                              ' AND I_COD_COR = 0' +
                              ' AND I_COD_TAM = 0');
  end
  else
  begin
    AdicionaSQLAbreTabela(Aux,'SELECT C_COD_BAR FROM MOVQDADEPRODUTO ' +
                              ' WHERE I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                              ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) +
                              ' AND I_COD_COR = ' + IntToStr(VpaCodCor) +
                              ' AND I_COD_TAM = ' + IntToStr(VpaCodTamanho));
  end;
  result := Aux.FieldByName('C_COD_BAR').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RCodigoClassificacaoProduto(VpaSeqProduto: integer): String;
begin
  AdicionaSQLAbreTabela(AUX,'Select C_COD_CLA from CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  Result := AUX.FieldByname('C_COD_CLA').AsString;
  AUX.close;
end;

{********************* carrega os kits do produto *****************************}
procedure TFuncoesProduto.CKitsProdutos(VpaSeqProduto : String; VpaSeqKit : TStringList);
begin
  VpaSeqKit.Clear;

  AdicionaSQLAbreTabela(ProProduto,'select I_PRO_KIT  from MOVKIT '+
                                   ' WHERE I_SEQ_PRO = ' + VpaSeqProduto+
                                   ' AND I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa));
  ProProduto.First;
  While not ProProduto.Eof do
  begin
    VpaSeqKit.Add(ProProduto.FieldByName('I_PRO_KIT').AsString);
    ProProduto.next;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDBaixaFracaoConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean;  VpaBaixas: TList;VpaCarregarSubMontagem,VpaConsumoAExcluir : Boolean);
var
  VpfDBaixaConsumo: TRBDConsumoFracaoOP;
  VpfTabela : TSQLQUERY;
begin
  Tabela.sql.clear;
  Tabela.sql.add('SELECT FOC.SEQCONSUMO, FOC.QTDPRODUTO, FOC.QTDBAIXADO, FOC.QTDUNITARIO, '+
                               ' FOC.SEQPRODUTO, FOC.DESUMUNITARIO,FOC.DESOBSERVACAO, FOC.INDMATERIALEXTRA,  '+
                               ' FOC.INDEXCLUIR, FOC.ALTMOLDE, FOC.LARMOLDE, FOC.PESPRODUTO, '+
                               ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL,'+
                               ' PRO.C_PRA_PRO, '+
                               ' FOC.CODCOR, COR.NOM_COR,'+
                               ' FOC.DESUM, FOC.INDBAIXADO, FOC.CODFACA, FOC.QTDRESERVADAESTOQUE, '+
                               ' FOC.INDORIGEMCORTE, FOC.QTDARESERVAR,  '+
                               ' FAC.NOMFACA '+
                               ' FROM FRACAOOPCONSUMO FOC, COR, CADPRODUTOS PRO, FACA FAC, FRACAOOP FRA '+
                               ' WHERE FOC.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND FOC.SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                               ' AND '+SQLTextoRightJoin('FOC.CODCOR','COR.COD_COR')+
                               ' AND '+SQLTextoRightJoin('FOC.CODFACA','FAC.CODFACA')+
                               ' AND FOC.CODFILIAL = FRA.CODFILIAL '+
                               ' AND FOC.SEQORDEM = FRA.SEQORDEM '+
                               ' AND FOC.SEQFRACAO = FRA.SEQFRACAO '+
                               ' AND PRO.I_SEQ_PRO = FOC.SEQPRODUTO');
  if VpaIndConsumoOrdemCorte then
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''S''')
  else
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''N''');
  if VpaConsumoAExcluir then
    Tabela.sql.add(' AND FOC.INDEXCLUIR = ''S''')
  else
    Tabela.sql.add(' AND FOC.INDEXCLUIR = ''N''');

{ 17/03/2010 foi colocado em comentario porque quando alterava o estagio é para baixar as pecas do pantografo automaticamente, e
             com essa condiçao náo estava baixando os produtos;
 if varia.TipoOrdemProducao = toSubMontagem then
    Tabela.sql.add('AND FRA.DATFINALIZACAO IS NULL');}

  if VpaSeqFracao > 0 then
    Tabela.sql.add(' AND FOC.SEQFRACAO = '+IntToStr(VpaSeqFracao));
  Tabela.Open;

  while not Tabela.Eof do
  begin
    VpfDBaixaConsumo := RDBaixaConsumoOp(VpaBaixas,Tabela.FieldByName('I_SEQ_PRO').AsInteger,Tabela.FieldByName('CODCOR').AsInteger,Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S');
    if (VpfDBaixaConsumo = nil) then
    begin
      VpfDBaixaConsumo:= TRBDConsumoFracaoOP.Create;
      VpaBaixas.Add(VpfDBaixaConsumo);
      VpfDBaixaConsumo.CodFilial:= VpaCodFilial;
      VpfDBaixaConsumo.SeqOrdem:= VpaSeqOrdem;
      VpfDBaixaConsumo.SeqFracao:= VpaSeqFracao;
      VpfDBaixaConsumo.SeqConsumo:= Tabela.FieldByName('SEQCONSUMO').AsInteger;
      VpfDBaixaConsumo.SeqProduto:= Tabela.FieldByName('I_SEQ_PRO').AsInteger;
      VpfDBaixaConsumo.CodCor:= Tabela.FieldByName('CODCOR').AsInteger;
      VpfDBaixaConsumo.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
      VpfDBaixaConsumo.IndMaterialExtra := Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S';
      if config.ConverterMTeCMparaMM and
        ((Tabela.FieldByName('DESUM').AsString = 'CM') OR
         (Tabela.FieldByName('DESUM').AsString = 'MT')) then
      begin
        VpfDBaixaConsumo.DesUM:= 'MM';
        VpfDBaixaConsumo.DesUMUnitario:= 'MM';
        VpfDBaixaConsumo.DesUMOriginal := 'MM';
        if (Tabela.FieldByName('DESUM').AsString = 'CM') then
          VpfDBaixaConsumo.QtdUnitario:= Tabela.FieldByName('QTDUNITARIO').AsFloat*10
        else
          if (Tabela.FieldByName('DESUM').AsString = 'MT') then
            VpfDBaixaConsumo.QtdUnitario:= Tabela.FieldByName('QTDUNITARIO').AsFloat*1000;
      end
      else
      begin
        VpfDBaixaConsumo.DesUM:= UPPERCASE(Tabela.FieldByName('DESUM').AsString);
        VpfDBaixaConsumo.QtdUnitario:= Tabela.FieldByName('QTDUNITARIO').AsFloat;
        VpfDBaixaConsumo.DesUMUnitario:= UPPERCASE(Tabela.FieldByName('DESUMUNITARIO').AsString);
        VpfDBaixaConsumo.DesUMOriginal := Tabela.FieldByName('UMORIGINAL').AsString;
      end;
      VpfDBaixaConsumo.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
      VpfDBaixaConsumo.NomCor:= Tabela.FieldByName('NOM_COR').AsString;
      VpfDBaixaConsumo.DesLocalizacaoProduto := Tabela.FieldByName('C_PRA_PRO').AsString;
      VpfDBaixaConsumo.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpfDBaixaConsumo.DesUM);
      VpfDBaixaConsumo.DesObservacao:= Tabela.FieldByName('DESOBSERVACAO').AsString;
      VpfDBaixaConsumo.IndOrigemCorte:= Tabela.FieldByName('INDORIGEMCORTE').AsString = 'S';
      VpfDBaixaConsumo.IndExcluir:= Tabela.FieldByName('INDEXCLUIR').AsString = 'S';
      VpfDBaixaConsumo.CodFaca:= Tabela.FieldByName('CODFACA').AsInteger;
      VpfDBaixaConsumo.NomFaca:= Tabela.FieldByName('NOMFACA').AsString;
      VpfDBaixaConsumo.LarMolde := Tabela.FieldByName('LARMOLDE').AsFloat;
      VpfDBaixaConsumo.AltMolde := Tabela.FieldByName('ALTMOLDE').AsFloat;
      VpfDBaixaConsumo.PesProduto := Tabela.FieldByName('PESPRODUTO').AsFloat;
    end
    else
    begin
      VpfDBaixaConsumo.SeqFracao:= 0;
      VpfDBaixaConsumo.SeqConsumo:= 0;
      VpfDBaixaConsumo.QtdUnitario:= 0;
    end;
    VpfDBaixaConsumo.QtdProduto:= VpfDBaixaConsumo.QtdProduto + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDPRODUTO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdBaixado:= VpfDBaixaConsumo.QtdBaixado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDBAIXADO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdReservado:= VpfDBaixaConsumo.QtdReservado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDRESERVADAESTOQUE').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdAReservar:= VpfDBaixaConsumo.QtdAReservar + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDARESERVAR').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.DesObservacao := VpfDBaixaConsumo.DesObservacao +' ' + Tabela.FieldByName('DESOBSERVACAO').AsString;

    VpfDBaixaConsumo.IndBaixado:=  VpfDBaixaConsumo.QtdBaixado >= VpfDBaixaConsumo.QtdProduto;
    Tabela.Next;
  end;
  Tabela.Close;

  if (varia.TipoOrdemProducao = toSubMontagem) and (VpaCarregarSubMontagem) then
  begin
    //carrega o consumo das submontagens
    VpfTabela := TSQLQUERY.Create(nil);
    VpfTabela.SQLConnection := DataBase;
    AdicionaSQLAbreTabela(VpfTabela,'Select CODFILIAL, SEQORDEM, SEQFRACAO '+
                                     ' from FRACAOOP '+
                                     ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                     ' AND SEQORDEM = '+ IntToStr(VpaSeqOrdem)+
                                     ' and SEQFRACAOPAI = '+IntToStr(VpaSeqFracao));
    while not VpfTabela.eof do
    begin
      CarDBaixaFracaoConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpfTabela.FieldByName('SEQFRACAO').AsInteger,VpaIndConsumoOrdemCorte,VpaBaixas,true,VpaConsumoAExcluir);
      VpfTabela.next;
    end;
    VpfTabela.close;
    VpfTabela.free;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDBaixaOPConsumoProduto(VpaCodFilial, VpaSeqOrdem : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
var
  VpfDBaixaConsumo: TRBDConsumoFracaoOP;
begin
  FreeTObjectsList(VpaBaixas);
  Tabela.sql.clear;
  Tabela.sql.add('SELECT FOC.SEQCONSUMO, FOC.QTDPRODUTO, FOC.QTDBAIXADO, FOC.SEQFRACAO,  '+
                               ' FOC.SEQPRODUTO, FOC.DESUMUNITARIO, FOC.DESOBSERVACAO, FOC.INDMATERIALEXTRA, '+
                               ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL,'+
                               ' FOC.CODCOR, COR.NOM_COR,'+
                               ' FOC.DESUM, FOC.INDBAIXADO, FOC.CODFACA, FOC.QTDRESERVADAESTOQUE '+
                               ' FROM FRACAOOPCONSUMO FOC, COR, CADPRODUTOS PRO'+
                               ' WHERE FOC.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND FOC.SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                               ' AND '+SQLTextoRightJoin('FOC.CODCOR','COR.COD_COR')+
                               ' AND PRO.I_SEQ_PRO = FOC.SEQPRODUTO');
  if VpaIndConsumoOrdemCorte then
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''S''')
  else
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''N''');
  Tabela.Open;

  while not Tabela.Eof do
  begin
    VpfDBaixaConsumo := RDBaixaConsumoOp(VpaBaixas,Tabela.FieldByName('I_SEQ_PRO').AsInteger,Tabela.FieldByName('CODCOR').AsInteger,Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S');
    if VpfDBaixaConsumo = nil then
    begin
      VpfDBaixaConsumo:= TRBDConsumoFracaoOP.Create;
      VpaBaixas.Add(VpfDBaixaConsumo);
      VpfDBaixaConsumo.CodFilial:= VpaCodFilial;
      VpfDBaixaConsumo.SeqOrdem:= VpaSeqOrdem;
      VpfDBaixaConsumo.SeqFracao:= 0;
      VpfDBaixaConsumo.SeqConsumo:= 0;
      VpfDBaixaConsumo.SeqProduto:= Tabela.FieldByName('I_SEQ_PRO').AsInteger;
      VpfDBaixaConsumo.CodCor:= Tabela.FieldByName('CODCOR').AsInteger;
      VpfDBaixaConsumo.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
      VpfDBaixaConsumo.IndMaterialExtra := Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S';
      if config.ConverterMTeCMparaMM and
         ((Tabela.FieldByName('DESUM').AsString = 'CM') OR
         (Tabela.FieldByName('DESUM').AsString = 'MT')) then
      begin
        VpfDBaixaConsumo.DesUM:= 'MM';
        VpfDBaixaConsumo.DesUMUnitario:= 'MM';
        VpfDBaixaConsumo.DesUMOriginal := 'MM';
      end
      else
      begin
        VpfDBaixaConsumo.DesUM:= Tabela.FieldByName('DESUM').AsString;
        VpfDBaixaConsumo.DesUMUnitario:= Tabela.FieldByName('DESUMUNITARIO').AsString;
        VpfDBaixaConsumo.DesUMOriginal := Tabela.FieldByName('UMORIGINAL').AsString;
      end;

      VpfDBaixaConsumo.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
      VpfDBaixaConsumo.NomCor:= Tabela.FieldByName('NOM_COR').AsString;
      VpfDBaixaConsumo.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpfDBaixaConsumo.DesUM);
    end;
    VpfDBaixaConsumo.QtdProduto:= VpfDBaixaConsumo.QtdProduto + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDPRODUTO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdBaixado:= VpfDBaixaConsumo.QtdBaixado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDBAIXADO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdReservado:= VpfDBaixaConsumo.QtdReservado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDRESERVADAESTOQUE').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);;
    VpfDBaixaConsumo.DesObservacao := VpfDBaixaConsumo.DesObservacao +' ' + Tabela.FieldByName('DESOBSERVACAO').AsString;
    VpfDBaixaConsumo.IndBaixado:=  VpfDBaixaConsumo.QtdBaixado >= VpfDBaixaConsumo.QtdProduto;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarConsumoProdutoBastidor(VpaSeqProduto : Integer;VpaDConsumo :TRBDConsumoMP);
var
  VpfDBastidor : TRBDConsumoMPBastidor;
begin
  AdicionaSQLAbreTabela(Tabela2,'Select MOB.CODBASTIDOR, MOB.QTDPECAS, '+
                                ' BAS.NOMBASTIDOR '+
                                ' FROM MOVKITBASTIDOR MOB, BASTIDOR BAS '+
                                ' Where MOB.CODBASTIDOR = BAS.CODBASTIDOR '+
                                ' and MOB.SEQPRODUTOKIT = '+ IntToStr(VpaSeqProduto)+
                                ' and MOB.SEQCORKIT = ' + IntToStr(VpaDConsumo.CorKit)+
                                ' AND MOB.SEQMOVIMENTO = '+IntToStr(VpaDConsumo.SeqMovimento)+
                                ' ORDER BY MOB.CODBASTIDOR ');
  While not Tabela2.eof do
  begin
    VpfDBastidor := VpaDConsumo.addBastidor;
    VpfDBastidor.CodBastidor := Tabela2.FieldByname('CODBASTIDOR').AsInteger;
    VpfDBastidor.QtdPecas := Tabela2.FieldByname('QTDPECAS').AsInteger;
    VpfDBastidor.NomBastidor := Tabela2.FieldByname('NOMBASTIDOR').AsString;
    Tabela2.next;
  end;
  Tabela2.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDOperacaoEstoque(VpaDOperacao : TRBDOperacaoEstoque;VpaCodOperacao: Integer);
begin
  LocalizaOperacaoEstoque(AUX, VpaCodOperacao);
  VpaDOperacao.CodOperacao := VpaCodOperacao;
  VpaDOperacao.NomOperacao := Aux.FieldByName('C_NOM_OPE').AsString;
  VpaDOperacao.DesTipo_E_S := Aux.FieldByName('C_TIP_OPE').AsString;
  VpaDOperacao.DesFuncao := Aux.FieldByName('C_FUN_OPE').AsString;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarConsumoProduto(VpaDProduto : TRBDProduto;VpaCorKit : Integer);
Var
  VpfDConsumo : TRBDConsumoMP;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.I_ALT_PRO, MOV.I_COD_COR, MOV.C_COD_UNI, '+
                               ' MOV.N_QTD_PRO, MOV.I_SEQ_PRO, PRO.C_COD_UNI UNIORI, PRO.C_PRA_PRO, '+
                               ' MOV.I_COD_FAC, MOV.I_ALT_MOL, MOV.I_LAR_MOL, MOV.I_SEQ_MOV, '+
                               ' MOV.I_COD_MAQ, MOV.I_COR_REF, MOV.N_VLR_UNI, MOV.N_VLR_TOT, MOV.N_PEC_MET, MOV.N_IND_MET, '+
                               ' MOV.C_DES_OBS, MOV.I_SEQ_ENT, MOV.I_SEQ_TER, MOV.I_QTD_ENT, MOV.I_QTD_TER, '+
                               ' MOV.D_DAT_DES  '+
                               ' from MOVKIT MOV, CADPRODUTOS PRO' +
                               ' Where MOV.I_PRO_KIT = '+ IntToStr(VpaDProduto.SeqProduto)+
                               ' and MOV.I_COR_KIT = ' + IntToStr(VpaCorKit)+
                               ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO' +
                               ' order by MOV.I_SEQ_MOV');

  FreeTObjectsList(VpaDProduto.ConsumosMP);
  While not Tabela.eof do
  begin
    VpfDConsumo := VpaDProduto.AddConsumoMP;
    VpfDConsumo.CorKit := VpaCorKit;
    VpfDConsumo.SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDConsumo.CodCor := Tabela.FieldByName('I_COD_COR').AsInteger;
    VpfDConsumo.SeqMovimento := Tabela.FieldByName('I_SEQ_MOV').AsInteger;
    VpfDConsumo.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDConsumo.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDConsumo.AltProduto := Tabela.FieldByName('I_ALT_PRO').AsInteger;
    VpfDConsumo.UMOriginal := Tabela.FieldByName('UNIORI').AsString;
    VpfDConsumo.UM := Tabela.FieldByName('C_COD_UNI').AsString;
    VpfDConsumo.UnidadeParentes := ValidaUnidade.UnidadesParentes(VpfDConsumo.UMOriginal);
    VpfDConsumo.QtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDConsumo.DesPrateleira := Tabela.FieldByName('C_PRA_PRO').AsString;
    if VpfDConsumo.CodCor <> 0 then
      VpfDConsumo.NomCor := RNomeCor(Tabela.FieldByName('I_COD_COR').AsString);

    VpfDConsumo.ValorUnitario := Tabela.FieldByName('N_VLR_UNI').AsFloat;
    VpfDConsumo.ValorTotal := Tabela.FieldByName('N_VLR_TOT').AsFloat;
    VpfDConsumo.PecasMT := Tabela.FieldByName('N_PEC_MET').AsFloat;
    VpfDConsumo.IndiceMT := Tabela.FieldByName('N_IND_MET').AsFloat;

    VpfDConsumo.CodFaca:= Tabela.FieldByName('I_COD_FAC').AsInteger;
    VpfDConsumo.AlturaMolde:= Tabela.FieldByName('I_ALT_MOL').AsFloat;
    VpfDConsumo.LarguraMolde:= Tabela.FieldByName('I_LAR_MOL').AsFloat;
    VpfDConsumo.CodMaquina:= Tabela.FieldByName('I_COD_MAQ').AsInteger;
    VpfDConsumo.DatDesenho:= Tabela.FieldByName('D_DAT_DES').AsDateTime;
    VpfDConsumo.CorReferencia:= Tabela.FieldByName('I_COR_REF').AsInteger;
    if VpfDConsumo.CodFaca <> 0 then
      ExisteFaca(VpfDConsumo.CodFaca,VpfDConsumo.Faca);
    if VpfDConsumo.CodMaquina <> 0 then
      ExisteMaquina(VpfDConsumo.CodMaquina,VpfDConsumo.Maquina);
    VpfDConsumo.DesObservacoes := Tabela.FieldByName('C_DES_OBS').AsString;
    VpfDConsumo.SeqProdutoEntretela := Tabela.FieldByName('I_SEQ_ENT').AsInteger;
    VpfDConsumo.SeqProdutoTermoColante := Tabela.FieldByName('I_SEQ_TER').AsInteger;
    VpfDConsumo.QtdEntretela := Tabela.FieldByName('I_QTD_ENT').AsInteger;
    VpfDConsumo.QtdTermoColante := Tabela.FieldByName('I_QTD_TER').AsInteger;
    if VpfDConsumo.SeqProdutoEntretela <> 0 then
      FunProdutos.ExisteProduto(VpfDConsumo.SeqProdutoEntretela,VpfDConsumo.CodProdutoEntretela,VpfDConsumo.NomProdutoEntretela);
    if VpfDConsumo.SeqProdutoTermoColante <> 0 then
      FunProdutos.ExisteProduto(VpfDConsumo.SeqProdutoTermoColante,VpfDConsumo.CodProdutoTermoColante,VpfDConsumo.NomProdutoTermoColante);
    CarConsumoProdutoBastidor(VpaDProduto.SeqProduto,VpfDConsumo);
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarProdutoImpressoras(VpaSeqProduto : Integer;VpaImpresoras : TList);
Var
  VpfProImpressora : TRBDProdutoImpressora;
begin
  FreeTObjectsList(VpaImpresoras);
  AdicionaSQLAbreTabela(Tabela,'Select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                               ' from CADPRODUTOS PRO, PRODUTOIMPRESSORA IMP '+
                               ' Where IMP.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                               ' and PRO.I_SEQ_PRO = IMP.SEQIMPRESSORA');
  While not Tabela.eof do
  begin
    VpfProImpressora := TRBDProdutoImpressora.Create;
    VpaImpresoras.add(VpfProImpressora);
    VpfProImpressora.SeqImpressora := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
    VpfProImpressora.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
    VpfProImpressora.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarAcessoriosProduto(VpaDProduto : TRBDProduto);
Var
  VpfDAcessorio :  TRBDProdutoAcessorio;
begin
  FreeTObjectsList(VpaDProduto.Acessorios);
  AdicionaSQLAbreTabela(Tabela,'Select ACE.CODACESSORIO, ACE.NOMACESSORIO '+
                               ' from ACESSORIO ACE, PRODUTOACESSORIO PAC '+
                               ' Where ACE.CODACESSORIO = PAC.CODACESSORIO'+
                               ' and PAC.SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto)+
                               ' order by PAC.SEQITEM');
  while not Tabela.eof do
  begin
    VpfDAcessorio := VpaDProduto.AddAcessorio;
    VpfDAcessorio.CodAcessorio := Tabela.FieldByName('CODACESSORIO').AsInteger;
    VpfDAcessorio.NomAcessorio := Tabela.FieldByName('NOMACESSORIO').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDBaixaConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
begin
  FreeTObjectsList(VpaBaixas);
  if VpaSeqFracao <> 0 then
    CarDBaixaFracaoConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaIndConsumoOrdemCorte, VpaBaixas,true,false)
  else
    CarDBaixaOPConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpaIndConsumoOrdemCorte, VpaBaixas);
end;

{******************************************************************************}
procedure TFuncoesProduto.CarPerComissoesProduto(VpaSeqProduto, VpaCodVendedor : Integer;Var VpaPerComissaoProduto : Double;Var VpaPerComissaoClassificacao : Double;var VpaPerComissaoVendedor : Double);
begin
  AdicionaSQLAbreTabela(Aux,'Select PRO.N_PER_COM, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, '+
                            ' COM.PERCOMISSAO '+
                            ' From CADPRODUTOS PRO, CADCLASSIFICACAO CLA, COMISSAOCLASSIFICACAOVENDEDOR COM '+
                            ' Where PRO.I_SEQ_PRO = ' +IntToStr(VpaSeqProduto)+
                            ' and PRO.I_COD_EMP = CLA.I_COD_EMP '+
                            ' and PRO.C_COD_CLA = CLA.C_COD_CLA '+
                            ' and PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                            ' and '+SQLTextoRightJoin('COM.CODEMPRESA','CLA.I_COD_EMP') +
                            ' and '+SQLTextoRightJoin('COM.CODCLASSIFICACAO','CLA.C_COD_CLA')+
                            ' and '+SQLTextoRightJoin('COM.TIPCLASSIFICACAO','CLA.C_TIP_CLA')+
                            ' AND COM.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
  VpaPerComissaoProduto := AUX.FieldByname('N_PER_COM').AsFloat;
  VpaPerComissaoClassificacao := AUX.FieldByname('PERCOMISSAOCLASSIFICACAO').AsFloat;
  VpaPerComissaoVendedor := AUX.FieldByname('PERCOMISSAO').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarQtdMinimaProduto(VpaCodFilial, VpaSeqProduto, VpaCor, VpaCodTamanho : Integer; var VpaQtdMinima, VpaQtdPedido, VpaValCusto : Double);
begin
  AdicionaSQLAbreTabela(AUX,'Select N_QTD_MIN, N_QTD_PED, N_VLR_CUS from MOVQDADEPRODUTO '+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                            ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' AND I_COD_COR = '+ IntToStr(VpaCor)+
                            ' AND I_COD_TAM = '+ IntToStr(VpaCodTamanho));
  VpaQtdMinima := AUX.FieldByName('N_QTD_MIN').AsFloat;
  VpaQtdPedido := AUX.FieldByName('N_QTD_PED').AsFloat;
  VpaValCusto := AUX.FieldByName('N_VLR_CUS').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarQtdMinimaProduto(VpaCodFilial, VpaCor: Integer; VpaDProduto: TRBDProduto);
begin
  AdicionaSQLAbreTabela(AUX,'SELECT N_QTD_MIN, N_QTD_PED, N_VLR_CUS FROM MOVQDADEPRODUTO '+
                            ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' AND I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                            ' AND I_COD_COR = '+IntToStr(VpaCor));
  VpaDproduto.QtdMinima:= AUX.FieldByName('N_QTD_MIN').AsFloat;
  VpaDProduto.QtdPedido:= AUX.FieldByName('N_QTD_PED').AsFloat;
  VpaDProduto.VlrCusto:= AUX.FieldByName('N_VLR_CUS').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDBaixaConsumoFracaoLog(VpaDBaixa : TRBDConsumoFracaoOP;VpaCodUsuario : Integer): String;
begin
  AdicionaSQLAbreTabela(ProCadastro,'Select * from FRACAOOPCONSUMOLOG '+
                                    ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0 AND SEQCONSUMO = 0 AND SEQLOG = 0');
  ProCadastro.Insert;
  ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaDBaixa.CodFilial;
  ProCadastro.FieldByName('SEQORDEM').AsInteger := VpaDBaixa.SeqOrdem;
  ProCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDBaixa.SeqFracao;
  ProCadastro.FieldByName('SEQCONSUMO').AsInteger := VpaDBaixa.SeqConsumo;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDBaixa.SeqProduto;
  ProCadastro.FieldByName('CODCOR').AsInteger := VpaDBaixa.CodCor;
  ProCadastro.FieldByName('CODUSUARIO').AsInteger := VpaCodUsuario;
  ProCadastro.FieldByName('DATLOG').AsDateTime := Now;
  ProCadastro.FieldByName('QTDBAIXADO').AsFloat := VpaDBaixa.QtdABaixar;
  ProCadastro.FieldByName('DESUM').AsString := VpaDBaixa.DesUM;
  ProCadastro.FieldByName('SEQLOG').AsInteger := RSeqLogFracaoOpConsumo(VpaDBaixa.CodFilial,VpaDBaixa.SeqOrdem,VpaDBaixa.SeqFracao,VpaDBaixa.SeqConsumo);
  ProCadastro.post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDBaixaConsumoFracaoProduto(VpaCodigoFilial, VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario : Integer;  VpaBaixas: TList): String;
var
  VpfLaco: Integer;
  VpfBaixaConsumo: TRBDConsumoFracaoOP;
  VpfDProduto : TRBDProduto;
  VpfSeqBarra : Integer;
begin
  Result:= '';
  for VpfLaco:= 0 to VpaBaixas.Count-1 do
  begin
    VpfBaixaConsumo:= TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfBaixaConsumo.QtdABaixar <> 0 then
    begin
      AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM FRACAOOPCONSUMO'+
                          ' WHERE CODFILIAL = '+IntToStr(VpaCodigoFilial)+
                          ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                          ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                          ' AND SEQCONSUMO = '+IntToStr(VpfBaixaConsumo.SeqConsumo));
      ProCadastro.Edit;
      ProCadastro.FieldByName('CODFILIAL').AsInteger:= VpfBaixaConsumo.CodFilial;
      ProCadastro.FieldByName('SEQORDEM').AsInteger:= VpfBaixaConsumo.SeqOrdem;
      ProCadastro.FieldByName('SEQFRACAO').AsInteger:= VpfBaixaConsumo.SeqFracao;
      ProCadastro.FieldByName('SEQCONSUMO').AsInteger:= VpfBaixaConsumo.SeqConsumo;
      ProCadastro.FieldByName('QTDPRODUTO').AsFloat:= VpfBaixaConsumo.QtdProduto;
      VpfBaixaConsumo.QtdBaixado := VpfBaixaConsumo.QtdBaixado + VpfBaixaConsumo.QtdaBaixar;
      ProCadastro.FieldByName('QTDBAIXADO').AsFloat:= VpfBaixaConsumo.QtdBaixado;
      VpfBaixaConsumo.QtdReservado := VpfBaixaConsumo.QtdReservado - VpfBaixaConsumo.QtdABaixar;
      if VpfBaixaConsumo.QtdReservado  < 0 then
        VpfBaixaConsumo.QtdReservado := 0;
      ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat:= VpfBaixaConsumo.QtdReservado;
      ExcluiEstoqueReservaProduto(VpfBaixaConsumo.SeqProduto, VpfBaixaConsumo.CodCor, VpfBaixaConsumo.QtdProduto);
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger:= VpfBaixaConsumo.SeqProduto;
      ProCadastro.FieldByName('CODCOR').AsInteger:= VpfBaixaConsumo.CodCor;
      ProCadastro.FieldByName('DESUM').AsString:= VpfBaixaConsumo.DesUM;
      VpfBaixaConsumo.IndBaixado := VpfBaixaConsumo.QtdBaixado >=  VpfBaixaConsumo.QtdProduto;
      if VpfBaixaConsumo.IndBaixado then
        ProCadastro.FieldByName('INDBAIXADO').AsString:= 'S'
      else
        ProCadastro.FieldByName('INDBAIXADO').AsString:= 'N';

      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;

      if ProCadastro.AErronaGravacao then
        Break;
      if (VpfBaixaConsumo.QtdABaixar > 0) and not(VpfBaixaConsumo.IndOrigemCorte) then
      begin
        Result := GravaDBaixaConsumoFracaoLog(VpfBaixaConsumo,VpaCodUsuario);
        if result = '' then
        begin
          if varia.OperacaoEstoqueBaixaOPSaidaAlmoxarifado <> 0 then
          begin
            if not VpfBaixaConsumo.IndOrigemCorte then // as pecas que originaram do corte foi baixado o consumo do tecido na baixa do tecido;
            begin
              VpfDProduto := TRBDProduto.Cria;
              CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaCodigoFilial,VpfBaixaConsumo.SeqProduto);
              BaixaProdutoEstoque(VpfDProduto,VpaCodigoFilial,varia.OperacaoEstoqueBaixaOPSaidaAlmoxarifado,0,0,0,varia.MoedaBase,VpfBaixaConsumo.CodCor,
                                  0,date,VpfBaixaConsumo.QtdABaixar,0,VpfBaixaConsumo.DesUM,'',false,VpfSeqBarra,true,0,VpaSeqOrdem);
              VpfDProduto.Free;
            end;
          end
          else
            aviso('OPERACAO DE ESTOQUE BAIXA OP NÃO CONFIGURADO!!!'+#13+'Para que funcione a baixa da OP integrado a baixa do estoque é necessário configurar a operação de estoque da "BAIXA ESTOQUE OP" na pagina "ESTOQUE", nas configurações do produto no modulo de configurações do sistema');
        end;
      end;
    end;
    if result <> '' then
      break;
  end;

  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDBaixaConsumoOPProduto(VpaCodigoFilial, VpaSeqOrdem, VpaCodUsuario: Integer;VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
var
  VpfLaco: Integer;
  VpfDBaixaConsumo: TRBDConsumoFracaoOP;
  VpfDProduto : TRBDproduto;
  VpfSeqBarra : Integer;
begin
  Result:= '';
  for VpfLaco:= 0 to VpaBaixas.Count-1 do
  begin
    VpfDBaixaConsumo:= TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfDBaixaConsumo.QtdABaixar <> 0 then
    begin
      result :=  GravaDBaixaConsumoFracaoLog(VpfDBaixaConsumo,VpaCodUsuario);
      if result = '' then
      begin
        if not VpfDBaixaConsumo.IndOrigemCorte then // as pecas que originaram do corte foi baixado o consumo do tecido na baixa do tecido;
        begin
          VpfDProduto := TRBDProduto.Cria;
          CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaCodigoFilial,VpfDBaixaConsumo.SeqProduto);
          BaixaProdutoEstoque(VpfDProduto,VpaCodigoFilial,varia.OperacaoEstoqueBaixaOPSaidaAlmoxarifado,0,0,0,varia.MoedaBase,VpfDBaixaConsumo.CodCor,
                              0,date,VpfDBaixaConsumo.QtdABaixar,0,VpfDBaixaConsumo.DesUM,'',false,VpfSeqBarra,true,0,VpaSeqOrdem);
          VpfDProduto.Free;
        end;
      end;

      if result = '' then
      begin
        ProCadastro.sql.clear;
        ProCadastro.sql.add('SELECT * FROM FRACAOOPCONSUMO'+
                            ' WHERE CODFILIAL = '+IntToStr(VpaCodigoFilial)+
                            ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                            ' AND SEQPRODUTO = '+IntToStr(VpfDBaixaConsumo.SeqProduto)+
                            ' AND CODCOR = ' +IntToStr(VpfDBaixaConsumo.CodCor));
        if VpaIndConsumoOrdemCorte then
          ProCadastro.sql.add(' AND INDORDEMCORTE = ''S''')
        else
          ProCadastro.sql.add(' AND INDORDEMCORTE = ''N''');
        ProCadastro.Open;

        While not (ProCadastro.eof) and (VpfDBaixaConsumo.QtdABaixar > 0) do
        begin
          if ((ProCadastro.FieldByname('QTDPRODUTO').AsFloat - ProCadastro.FieldByname('QTDBAIXADO').AsFloat) > 0) then
          begin
            ProCadastro.Edit;
            ProCadastro.FieldByName('CODFILIAL').AsInteger:= VpfDBaixaConsumo.CodFilial;
            ProCadastro.FieldByName('SEQORDEM').AsInteger:= VpfDBaixaConsumo.SeqOrdem;

            if (VpfDBaixaConsumo.QtdABaixar > (ProCadastro.FieldByname('QTDPRODUTO').AsFloat - ProCadastro.FieldByname('QTDBAIXADO').AsFloat)) then
            begin
              VpfDBaixaConsumo.QtdABaixar := VpfDBaixaConsumo.QtdABaixar - (ProCadastro.FieldByname('QTDPRODUTO').AsFloat - ProCadastro.FieldByname('QTDBAIXADO').AsFloat);
              ProCadastro.FieldByname('QTDBAIXADO').AsFloat := ProCadastro.FieldByname('QTDPRODUTO').AsFloat;
            end
            else
            begin
              ProCadastro.FieldByname('QTDBAIXADO').AsFloat := ProCadastro.FieldByname('QTDBAIXADO').AsFloat+VpfDBaixaConsumo.QtdABaixar;
              VpfDBaixaConsumo.QtdABaixar := 0;
            end;
            VpfDBaixaConsumo.IndBaixado := ProCadastro.FieldByname('QTDBAIXADO').AsFloat >= ProCadastro.FieldByname('QTDPRODUTO').AsFloat;
            if VpfDBaixaConsumo.IndBaixado then
              ProCadastro.FieldByName('INDBAIXADO').AsString:= 'S'
            else
              ProCadastro.FieldByName('INDBAIXADO').AsString:= 'N';

            if VpfDBaixaConsumo.QtdReservado  < 0 then
              VpfDBaixaConsumo.QtdReservado := 0;
            ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat:= VpfDBaixaConsumo.QtdReservado;
            ExcluiEstoqueReservaProduto(VpfDBaixaConsumo.SeqProduto, VpfDBaixaConsumo.CodCor, VpfDBaixaConsumo.QtdProduto);


            ProCadastro.Post;
            result := ProCadastro.AMensagemErroGravacao;
            if ProCadastro.AErronaGravacao then
              Break;
          end;
          ProCadastro.next;
        end;
      end;
    end;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDConsumoMPBastidor(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
var
  VpfLacoConsumo, VpfLacoBastidor : Integer;
  VpfDConsumo : TRBDConsumoMP;
  VpfDConsumoBastidor : TRBDConsumoMPBastidor;
begin
  result := '';
  AdicionaSqlAbreTabela(ProCadastro,'Select * from MOVKITBASTIDOR'+
                                    ' Where SEQPRODUTOKIT = 0 AND SEQCORKIT = 0 AND SEQMOVIMENTO = 0 AND CODBASTIDOR = 0 ');
  for VpfLacoConsumo := 0 to VpaDProduto.ConsumosMP.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoConsumo]);
    for VpfLacoBastidor := 0 to VpfDConsumo.Bastidores.Count - 1 do
    begin
      VpfDConsumoBastidor := TRBDConsumoMPBastidor(VpfDConsumo.Bastidores.Items[VpfLacoBastidor]);
      ProCadastro.Insert;
      ProCadastro.FieldByName('SEQPRODUTOKIT').AsInteger := VpaDProduto.SeqProduto;
      ProCadastro.FieldByName('SEQCORKIT').AsInteger := VpaCorKit;
      ProCadastro.FieldByName('SEQMOVIMENTO').AsInteger := VpfDConsumo.SeqMovimento;
      ProCadastro.FieldByName('CODBASTIDOR').AsInteger := VpfDConsumoBastidor.CodBastidor;
      ProCadastro.FieldByName('QTDPECAS').AsInteger := VpfDConsumoBastidor.QtdPecas;
      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
      if ProCadastro.AErronaGravacao then
        break;
    end;
    if result <> '' then
      break;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiMovimentoEstoquePorData(VpaDatInicial, VpaDatFinal : TDateTime);
begin
  ExecutaComandoSql(AUX,'DELETE FROM MOVESTOQUEPRODUTOS '+
                        ' Where D_DAT_MOV >= '+ SQLTextoDataAAAAMMMDD(VpaDatInicial)+
                        ' and D_DAT_MOV <= '+ SQLTextoDataAAAAMMMDD(VpaDatFinal)+
                        ' and I_EMP_FIL = ' + IntToStr(Varia.CodigoempFil)+
                        ' and I_COD_OPE not in ('+ IntToStr(Varia.OperacaoEstoqueInicial)+
                        ','+IntTostr(Varia.InventarioEntrada)+
                        ','+IntToStr(varia.InventarioSaida)+
                        ','+IntTostr(Varia.OperacaoAcertoEstoqueEntrada)+
                        ','+IntToStr(varia.OperacaoAcertoEstoqueSaida)+')');
  ExecutaComandoSql(AUX,'DELETE FROM MOVSUMARIZAESTOQUE '+
                        ' Where I_MES_FEC = '+ IntToStr(Mes(VpaDatInicial)) +
                        ' and I_ANO_FEC = '+ InttoStr(Ano(VpaDatInicial))+
                        ' and I_EMP_FIL = ' + IntToStr(Varia.CodigoempFil));
end;

{******************************************************************************}
function TFuncoesProduto.ReprocessaEstoqueCotacao(VpaDatInicial, VpaDatFinal : TDateTime) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVESTOQUEPRODUTOS');
  AdicionaSQLAbreTabela(ProProduto,'Select MOV.I_SEQ_PRO, MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_LAN_ORC, MOV.C_COD_UNI, '+
                                   ' CAD.D_DAT_ORC '+
                                   ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV '+
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                   ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                                   ' AND CAD.D_DAT_ORC >= '+ SQLTextoDataAAAAMMMDD(VpaDatInicial)+
                                   ' AND CAD.D_DAT_ORC <= '+ SQLTextoDataAAAAMMMDD(VpaDatFinal)+
                                   ' AND CAD.I_EMP_FIL = '+ IntTostr(varia.CodigoEmpFil)+
                                   ' ORDER BY CAD.D_DAT_ORC');
  While not ProProduto.Eof do
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := Varia.CodigoEmpFil;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
    ProCadastro.FieldByName('I_COD_OPE').AsInteger := 1101;
    ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := ProProduto.FieldByName('D_DAT_ORC').AsDateTime;
    ProCadastro.FieldByName('N_QTD_MOV').AsFloat := ProProduto.FieldByName('N_QTD_PRO').AsFloat;
    ProCadastro.FieldByName('C_TIP_MOV').AsString := 'S';
    ProCadastro.FieldByName('N_VLR_MOV').AsFloat := ProProduto.FieldByName('N_VLR_TOT').AsFloat;
    ProCadastro.FieldByName('I_NRO_NOT').AsInteger := ProProduto.FieldByName('I_LAN_ORC').AsInteger;
    ProCadastro.FieldByName('C_COD_UNI').AsString := ProProduto.FieldByName('C_COD_UNI').AsString;
    ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := ProProduto.FieldByName('D_DAT_ORC').AsDateTime;
    ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil, false,ProCadastro.ASQlConnection );
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      exit;
    ProProduto.Next;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ReprocessaEstoqueCompras(VpaDatInicial, VpaDatFinal : TDateTime) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVESTOQUEPRODUTOS');
  AdicionaSQLAbreTabela(ProProduto,'Select MOV.I_SEQ_PRO, MOV.N_QTD_PRO, MOV.N_TOT_PRO, MOV.I_SEQ_NOT, MOV.C_COD_UNI, '+
                                   ' CAD.D_DAT_EMI, I_NRO_NOT '+
                                   ' FROM CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV '+
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                   ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                                   ' AND CAD.D_DAT_EMI >= '+ SQLTextoDataAAAAMMMDD(VpaDatInicial)+
                                   ' AND CAD.D_DAT_EMI <= '+ SQLTextoDataAAAAMMMDD(VpaDatFinal)+
                                   ' AND CAD.I_EMP_FIL = '+ IntTostr(varia.CodigoEmpFil)+
                                   ' ORDER BY CAD.D_DAT_EMI');
  While not ProProduto.Eof do
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := Varia.CodigoEmpFil;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
    ProCadastro.FieldByName('I_COD_OPE').AsInteger := 1102;
    ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := ProProduto.FieldByName('D_DAT_EMI').AsDateTime;
    ProCadastro.FieldByName('N_QTD_MOV').AsFloat := ProProduto.FieldByName('N_QTD_PRO').AsFloat;
    ProCadastro.FieldByName('C_TIP_MOV').AsString := 'E';
    ProCadastro.FieldByName('N_VLR_MOV').AsFloat := ProProduto.FieldByName('N_TOT_PRO').AsFloat;
    ProCadastro.FieldByName('I_NRO_NOT').AsInteger := ProProduto.FieldByName('I_NRO_NOT').AsInteger;
    ProCadastro.FieldByName('I_NOT_ENT').AsInteger := ProProduto.FieldByName('I_SEQ_NOT').AsInteger;
    ProCadastro.FieldByName('C_COD_UNI').AsString := ProProduto.FieldByName('C_COD_UNI').AsString;
    ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := ProProduto.FieldByName('D_DAT_EMI').AsDateTime;
    ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil,false,ProCadastro.ASqlconnection );
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      exit;
    ProProduto.Next;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AdicionaConsumoExtraFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;VpaQtdProduto : Double;VpaUM,VpaTipOperacao : String):string;
begin
  if VpaTipOperacao = 'E' then
    VpaQtdProduto := VpaQtdProduto *-1;
  AdicionaSQLAbreTabela(ProCadastro,'Select * from FRACAOOPCONSUMO '+
                                    ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0');
  ProCadastro.Insert;
  ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  ProCadastro.FieldByName('SEQORDEM').AsInteger := VpaSeqOrdemProducao;
  ProCadastro.FieldByName('SEQFRACAO').AsInteger := 1;
  ProCadastro.FieldByName('QTDBAIXADO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  IF VpaCodCor <> 0 then
    ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;

  ProCadastro.FieldByName('DESUM').AsString := UpperCase(VpaUM);
  ProCadastro.FieldByName('INDBAIXADO').AsString := 'S';
  ProCadastro.FieldByName('QTDPRODUTO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('QTDUNITARIO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('INDORDEMCORTE').AsString := 'N';
  ProCadastro.FieldByName('DESUMUNITARIO').AsString := VpaUM;
  ProCadastro.FieldByName('INDORIGEMCORTE').AsString := 'N';
  ProCadastro.FieldByName('INDMATERIALEXTRA').AsString := 'S';
//AQUI ADICIONAR O CUSTO;
  ProCadastro.FieldByName('SEQCONSUMO').AsInteger := RSeqConsumoFracaoOpDisponivel(VpaCodFilial,VpaSeqOrdemProducao,ProCadastro.FieldByName('SEQFRACAO').AsInteger);
  ProCadastro.post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CopiaDEtiqueta(VpaDEtiquetaOrigem, VpaDEtiquetaDestino : TRBDEtiquetaProduto);
begin
//  VpaDEtiquetaDestino.Produto := TRBDProduto.cria;
  VpaDEtiquetaDestino.Produto := VpaDEtiquetaOrigem.Produto;
{  VpaDEtiquetaDestino.Produto.NomProduto := VpaDEtiquetaDestino.Produto.NomProduto;
  VpaDEtiquetaDestino.Produto.CODProduto := VpaDEtiquetaDestino.Produto.CODProduto;
  VpaDEtiquetaDestino.Produto.SeqProduto := VpaDEtiquetaDestino.Produto.SeqProduto;}
  VpaDEtiquetaDestino.CodCor := VpaDEtiquetaOrigem.CodCor;
  VpaDEtiquetaDestino.QtdOriginalEtiquetas := VpaDEtiquetaOrigem.QtdOriginalEtiquetas;
  VpaDEtiquetaDestino.QtdEtiquetas := VpaDEtiquetaOrigem.QtdEtiquetas;
  VpaDEtiquetaDestino.QtdProduto := VpaDEtiquetaOrigem.QtdProduto;
  VpaDEtiquetaDestino.NomCor := VpaDEtiquetaOrigem.NomCor;
  VpaDEtiquetaDestino.IndParaEstoque := VpaDEtiquetaOrigem.IndParaEstoque;
end;

{******************************************************************************}
function TFuncoesProduto.OperacoesEstornoValidas : String;
begin
  result := '';
  if Varia.OperacaoEstoqueEstornoEntrada = 0 then
    result := 'OPERAÇÃO DE ESTORNO DE ESTOQUE DE ENTRADA VAZIO!!!'#13'É necessário preencher a operação de estoque de estorno de entrada nas configurações dos produtos.'
  else
    if Varia.OperacaoEstoqueEstornoSaida = 0 then
      result := 'OPERAÇÃO DE ESTORNO DE ESTOQUE DE SAÍDA VAZIO!!!'#13'É necessário preencher a operação de estoque de estorno de entrada nas configurações dos produtos.'
    else
      if varia.PlanoContasDevolucaoCotacao = '' then
        result := 'PLANO DE CONTAS DEVOLUÇÃO COTAÇÃO VAZIO!!!'#13'É necessário preencher o plano de contas devolução da cotação, nas configurações da empresa.';
end;

{**************** gera o proximo codigo para o produto ********************** }
function TFuncoesProduto.ProximoCodigoProduto( CodClassificacao : String; tamanhoPicture : Integer ) : string;
begin
  if config.CodigoProdutoCompostopelaClasificacao then
    result := RCodProdutoDisponivelpelaClassificacao(CodClassificacao)
  else
  begin
    LimpaSQLTabela(tabela);
    AdicionaSQLAbreTabela(tabela, ' select max(I_ULT_PRO)  ULTIMO ' +
                              ' from CADEMPRESAS '+
                              ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );

    result := IntTostr(Tabela.FieldByName('ULTIMO').AsInteger+1);
    Tabela.Close;
    ExecutaComandoSql(Tabela,'update CADEMPRESAS '+
                             ' Set I_ULT_PRO = I_ULT_PRO + 1'+
                              ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );
    if config.MascaraProdutoPadrao then
      result := AdicionaCharE('0', result, tamanhoPicture);
   end;
end;

{******************************************************************************}
procedure TFuncoesProduto.EstornaProximoCodigoProduto;
begin
  ExecutaComandoSql(Tabela,'update CADEMPRESAS '+
                           ' Set I_ULT_PRO = I_ULT_PRO - 1'+
                            ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );
end;

{************************* Verifica se o produto ja foi cadastrado *********** }
function TFuncoesProduto.ProdutoCadastradonaTabeladePreco(VpaSeqProduto,VpaCodCor, VpaCodTamanho: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_VLR_VEN FROM MOVTABELAPRECO '+
                           ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                           ' AND I_COD_TAB = '+IntToStr(VARIA.TabelaPreco)+
                           ' AND I_COD_CLI =  0 ' +
                           ' AND I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                           ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho)+
                           ' AND I_COD_COR = ' + IntToStr(VpaCodCor));
  result := not AUX.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ProdutoDestacaST(VpaCodCST: String): boolean;
begin
  result := false;
  if (Length(VpaCodCST) = 3) then
    if(copy(VpaCodCST,2,2) = '10') or
      (copy(VpaCodCST,2,2) = '70') then
      result := true;
end;

{************************* Verifica se o produto ja foi cadastrado *********** }
function TFuncoesProduto.ProdutoExistente(CodigoPro, CodClassificacao : string) : Boolean;
begin
  result := true;
  if Config.CodigoUnicoProduto then
    LocalizaProduto(tabela, CodigoPro)
  else
    LocalizaProdutoClassificacao(tabela,CodigoPro,CodClassificacao);

     if not tabela.eof then
     begin
        erro('PRODUTO DUPLICADO - Este código do produto já existe nesta classificação');
        result := false;
     end;
end;

{******************************************************************************}
function TFuncoesProduto.ProdutoTributado(VpaCodCST: String): boolean;
begin
  result := false;
  if (Length(VpaCodCST) = 3) then
    if (copy(VpaCodCST,2,2) = '00') or
       (copy(VpaCodCST,2,2) = '10') or
       (copy(VpaCodCST,2,2) = '20') or
       (copy(VpaCodCST,2,2) = '70') then
      result := true;
end;

{**************** carrega mascara do produto e classificacao ***************** }
function TFuncoesProduto.VerificaMascaraClaPro : Boolean;
begin
  result := true;
  if Varia.MascaraCla = '0' then
  begin
    Aviso(CT_FilialSemMascara);   // caso a mascara seje 0
    Result := false;
  end;
end;

{************** calcula qdade de poduto para a unidade padrao do mesmo ******* }
function TFuncoesProduto.CalculaQdadePadrao( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; SequencialProduto : string) : Double;
var
  VpfIndice, VpfIndiceMetro : double;
  VpfQtdMetros : Double;
begin
  // indice para calculo de qdade / valor *
  VpfIndice := ConvUnidade.Indice(UnidadeAtual,UnidadePadrao,StrToInt(SequencialProduto),varia.CodigoEmpresa);
  if VpfIndice = 0 then
    result := 0
  else
  begin
    if (UnidadeAtual = varia.UnidadeCX ) or (UnidadeAtual =  varia.UnidadeUN ) then
      result := ArredondaDecimais((QdadeVendida * VpfIndice),4)
    else
    if (UnidadePadrao = varia.UnidadeBarra ) and (unidadeAtual <> Varia.UnidadeBarra) then
    begin
      VpfIndiceMetro := ConvUnidade.Indice(UnidadeAtual,'mt',StrToInt(SequencialProduto),varia.CodigoEmpresa);
      VpfQtdMetros := ArredondaDecimais((QdadeVendida / VpfIndiceMetro),4);
      Result := VpfQtdMetros * VpfIndice;
    end
      else
        result := ArredondaDecimais((QdadeVendida / Vpfindice),4);
  end;
end;

{************** calcula valor do poduto para a unidade padrao do mesmo ******* }
function TFuncoesProduto.CalculaValorPadrao( unidadeAtual, UnidadePadrao : string; ValorTotal : double; SequencialProduto : string) : Double;
var
  indice : double;
begin
  // indice para calculo de qdade / valor *  indice 0.1 * 0.9 = 9 reais  0.9 preco unidade
  indice := ConvUnidade.Indice(UnidadeAtual,UnidadePadrao,StrToInt(SequencialProduto),varia.CodigoEmpresa);
  if indice = 0 then
    indice := 1;
  result := ArredondaDecimais((ValorTotal / indice),4)
end;

{******************************************************************************}
function TFuncoesProduto.CalculaValorVendaCadarco(VpadProduto: TRBDProduto): Double;
var
  VpfValMateriaPrima, VpfValCustoTear  : Double;
begin
  result := 0;
  VpfValMateriaPrima := RValMateriaPrimaCadarco(VpadProduto);
  VpfValCustoTear := RValCustoTear(VpadProduto);
  result := VpfValMateriaPrima + VpfValCustoTear;
  result := result + (result *0.6);
end;

{******************************************************************************}
function TFuncoesProduto.CalculaQtdPecasemMetro(Var VpaIndice : Double;VpaAltProduto,VpaCodFaca,VpaCodMaquina,VpaCodBastidor,VpaQtdPcBastidor : Integer;VpaAltMolde,VpaLarMolde : Double) : Integer;
var
  VpfDFaca : TRBDFaca;
  VpfDBastidor : TRBDBastidor;
begin
  Result := 0;
  if VpaAltProduto = 0 then
  begin
    aviso('ALTURA DO PRODUTO NÃO PREENCHIDA!!!'#13'É necessário informar a altura do produto');
  end;
  VpfDFaca := TRBDFaca.cria;
  if VpaCodFaca <> 0 then
  begin
    ExisteFaca(VpaCodFaca,VpfDFaca);
    result:= RQtdPecaemMetro(VpaAltProduto,100,VpfDFaca.QtdProvas,VpfDFaca.AltFaca,VpfDFaca.LarFaca,false,VpaIndice);
  end
  else
    if VpaCodMaquina <> 0 then
    begin
      VpfDBastidor := TRBDBastidor.cria;
      ExisteBastidor(VpaCodBastidor,VpfDBastidor);
      result := RQtdPecaemMetro(VpaAltProduto,100,VpaQtdPcBastidor,VpfDBastidor.AltBastidor,VpfDBastidor.LarBastidor,false,VpaIndice);
      VpfDBastidor.free;
    end
    else
    if (VpaLarMolde <> 0 )and
       (VpaAltMolde <> 0) then
    begin
      result:= RQtdPecaemMetro(VpaAltProduto,100,1,VpaAltMolde,VpaLarMolde,false,VpaIndice);
    end;
  VpfDFaca.free;
end;

{********************* retorna o valor pela unidade ***************************}
Function TFuncoesProduto.ValorPelaUnidade(VpaUnidadeDe,VpaUnidadePara : String;VpaSeqProduto: Integer; VpaValorUnitario : Double): Double;
begin
  if ((UpperCase(VpaUnidadeDe) = 'CX') and (UpperCase(VpaUnidadePara) = 'PC'))or ((UpperCase(VpaUnidadeDe) = 'KT') and (UpperCase(VpaUnidadePara) = 'PC')) Then
     result := VpaValorUnitario * ConvUnidade.Indice(VpaUnidadePara,VpaUnidadede,VpaSeqProduto,Varia.CodigoEmpresa)
  else
     result := VpaValorUnitario * ConvUnidade.Indice(VpaUnidadede,VpaUnidadePara,VpaSeqProduto,Varia.CodigoEmpresa)
end;


{******************************************************************************}
function  TFuncoesProduto.TextoPossuiEstoque( QdadeVendidade, QdadeEstoque : double; UnidadePadrao : string ) : Boolean;
begin
  result := true;
  if ArredondaDecimais(QdadeVendidade,2) >  ArredondaDecimais(QdadeEstoque,2)  then
    case  config.QtdNegativa of
      0 : begin
            aviso(CT_SemEstoqueTranca + FloatToStr(QdadeEstoque) + '  ' + UnidadePadrao);
            result := false;
          end;
      1 : begin
            if not confirmacao(CT_FaltaEstoque + FloatToStr(QdadeEstoque) + '  ' + UnidadePadrao) then
              result := false;
          end;
    end;
end;

{ *************** Verifica se um produto tem ou naum estoque **************** }
function TFuncoesProduto.VerificaEstoque( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer) : Boolean;
var
  qdadeConvertida, EstoqueProduto : Double;
begin
  QdadeConvertida := CalculaQdadePadrao( unidadeAtual, UnidadePadrao, QdadeVendida, IntTostr(VpaSeqProduto));
  EstoqueProduto := CalculaQdadeEstoqueProduto(VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  result := TextoPossuiEstoque(QdadeConvertida,EstoqueProduto, UnidadePadrao);
end;

{********* texto de qdade minima e ponto de pedido ************************** }
procedure TFuncoesProduto.TextoQdadeMinimaPedido(QdadeMin, QdadePed, QdadeBaixa : double);
begin
    // avisa quando chegar ponto de pedido ou qdade minima.
  if ( Config.AvisaQtdMinima ) and ( QdadeBaixa <= QdadeMin ) then
       aviso(CT_EstoqueProdutoMinimo)
  else
    if ( Config.AvisaQtdPedido ) and ( QdadeBaixa <= QdadePed ) then
        aviso(CT_ProdutoPontoPedido);
end;


{*************** verifica qdade de ponto de pedido ************************** }
procedure TFuncoesProduto.VerificaPontoPedido(VpaCodFilial, VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer; VpaQtdBaixar : Double );
begin
   LocalizaMovQdadeSequencial(tabela,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);

    // avisa quando chegar ponto de pedido ou qdade minima.
   TextoQdadeMinimaPedido(  tabela.FieldByName('N_QTD_MIN').AsFloat,
                            tabela.FieldByName('N_QTD_PED').AsFloat,
                           ( ArredondaDecimais(tabela.FieldByName('N_QTD_PRO').AsFloat - VpaQtdBaixar,2) ));
end;

{ *************** efetua baixa de estoque ************************************ }
function TFuncoesProduto.BaixaProdutoEstoque( VpaDProduto : TRBDProduto;VpaCodFilial, VpaCodOperacao,VpaSeqNotaF, VpaNroNota,VpaLanOrcamento, VpaCodigoMoeda, VpaCodCor,VpaCodTamanho : Integer;
                                              VpaDataMov : TdateTime; VpaQdadeVendida, VpaValorTotal : Double;
                                              VpaunidadeAtual, VpaNumSerie : string; VpaNotaFornecedor : Boolean;Var VpaSeqBarra : Integer;VpaGerarMovimentoEstoque : Boolean = true;VpaCodTecnico : Integer = 0;
                                              VpaSeqOrdemProducao : Integer = 0; VpaQtdChapas : Double = 0; VpaLarChapa : Double = 0;VpaComChapa  : Double = 0) : Boolean;
var
  VpfQdadeBaixa,VpfQtdInicialEstoque,VpfQtdFinalEstoque : double;
  VpfCodFilialParametro, VpfLaco : Integer;
  VpfCifrao: string;
  VpfValCusto : double;
  VpfBaixouMovimento : Boolean;
  VpfDOperacaoEstoque : TRBDOperacaoEstoque;
  VpfResultado : String;
  VpfDProdutoKit : TRBDProduto;
  VpfDConsumoMP : TRBDConsumoMP;
  VpfTipoOperacao : TRBDTipoOperacaoEstoque;
begin
  VpaDProduto.IndGerouEstoqueChapa := false;
  // qdade conforme unidade
  VpfQdadeBaixa := CalculaQdadePadrao( VpaunidadeAtual, VpaDProduto.CodUnidade, VpaQdadeVendida, IntTostr(VpaDProduto.SeqProduto));

  if VpaDProduto.IndKit then
  begin
    CarConsumoProduto(VpaDProduto,VpaCodCor);
    for vpflaco := 0 to VpaDProduto.ConsumosMP.Count - 1 do
    begin
      VpfDConsumoMP := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLaco]);
      VpfDProdutoKit := TRBDProduto.cria;
      CarDProduto(VpfDProdutoKit,0,VpaCodFilial,VpfDConsumoMP.SeqProduto);
      BaixaProdutoEstoque(VpfDProdutoKit,VpaCodFilial,VpaCodOperacao,VpaSeqNotaF,
                          VpaNroNota,VpaLanOrcamento,VpaCodigoMoeda,VpaCodCor,
                          VpaCodTamanho,VpaDataMov,VpfQdadeBaixa * VpfDConsumoMP.QtdProduto,
                          0,VpfDConsumoMP.UM,VpaNumSerie,VpaNotaFornecedor,VpaSeqBarra,VpaGerarMovimentoEstoque,
                          VpaCodTecnico,VpaSeqOrdemProducao);
    end;
    exit;
  end;

  VpfCodFilialParametro := VpaCodFilial;
  if config.EstoqueCentralizado then
    VpaCodFilial := Varia.CodFilialControladoraEstoque;
   // informacoes sobre a operacao estoque
  result := true;
  VpfDOperacaoEstoque := TRBDOperacaoEstoque.cria;
  CarDOperacaoEstoque(VpfDOperacaoEstoque,VpaCodOperacao);
  if VpfDOperacaoEstoque.DesTipo_E_S = 'E' then
    VpfTipoOperacao := toEntrada
  else
    VpfTipoOperacao := toSaida;

  VpfQdadeBaixa := CalculaQdadePadrao( VpaunidadeAtual, VpaDProduto.CodUnidade, VpaQdadeVendida, IntTostr(VpaDProduto.SeqProduto));


  // coloca o produto em ativade
  if not VpaDProduto.IndProdutoAtivo then
    ColocaProdutoEmAtividade(IntToStr(VpaDProduto.SeqProduto));

  // valor conforme moeda
  VpaValorTotal := UnMoeda.ConverteValor( VpfCifrao, VpaCodigoMoeda, VpaDProduto.CodMoeda, VpaValorTotal );

  //posiciona a tabela de movqdadeproduto
  LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaDProduto.SeqProduto,VpaCodCor,VpaCodTamanho);
  if ProCadastro.eof then
  begin
    InsereProdutoFilial(VpaDProduto.SeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0, '');
    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaDProduto.SeqProduto,VpaCodCor,VpaCodTamanho);
  end;

  ProCadastro.Edit;

  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  VpfValCusto := ProCadastro.FieldByname('N_VLR_CUS').AsFloat;

  VpfQtdInicialEstoque := ProCadastro.FieldByName('N_QTD_PRO').AsFloat;
  // atualiza a qdade produtos em estoque
  if  VpfDOperacaoEstoque.DesTipo_E_S = 'E' then  // entrada de produto
    ProCadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat + VpfQdadeBaixa
  else  // saida de produto
    ProCadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat - VpfQdadeBaixa;

  VpfQtdFinalEstoque := ProCadastro.FieldByName('N_QTD_PRO').AsFloat;
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.post;
  if ProCadastro.AErronaGravacao then
    aviso(ProCadastro.AMensagemErroGravacao);
  ProCadastro.close;
  sistema.MarcaTabelaParaImportar('MOVQDADEPRODUTO');
  // inseri novo registro na movimentacao de estoque.
  if VpaGerarMovimentoEstoque then
  begin
    AdicionaSQLAbreTabela(ProCadastro, ' Select * From MovEstoqueProdutos '+
                                         ' WHERE I_EMP_FIL = 0 '+
                                         ' AND I_LAN_EST = 0 '+
                                         ' AND I_SEQ_PRO = 0');
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := VpfCodFilialParametro;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COD_OPE').AsInteger := VpaCodOperacao;
    ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := VpaDataMov;
    ProCadastro.FieldByName('N_QTD_MOV').AsFloat := VpaQdadeVendida;
    ProCadastro.FieldByName('N_QTD_INI').AsFloat := VpfQtdInicialEstoque;
    ProCadastro.FieldByName('N_QTD_FIN').AsFloat := VpfQtdFinalEstoque;
    ProCadastro.FieldByName('C_TIP_MOV').AsString := VpfDOperacaoEstoque.DesTipo_E_S;
    ProCadastro.FieldByName('N_VLR_MOV').AsFloat := VpaValorTotal;
    ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := now;
    ProCadastro.FieldByName('C_COD_UNI').AsString := UpperCase(VpaunidadeAtual);
    ProCadastro.FieldByName('I_COD_COR').AsInteger := VpaCodCor;
    if VpaCodTamanho <> 0 then
      ProCadastro.FieldByName('I_COD_TAM').AsInteger := VpaCodTamanho;
    if VpaCodTecnico <> 0 then
      ProCadastro.FieldByName('I_COD_TEC').AsInteger := VpaCodTecnico;
    if VpaSeqOrdemProducao <> 0 then
      ProCadastro.FieldByName('I_SEQ_ORD').AsInteger := VpaSeqOrdemProducao;
    ProCadastro.FieldByName('N_VLR_CUS').AsFloat := CalculaValorPadrao(VpaunidadeAtual,VpaDProduto.CodUnidade,VpfValCusto * VpaQdadeVendida,IntToStr(VpaDProduto.SeqProduto));
    if VpaNumSerie <> '' then
      ProCadastro.FieldByName('C_PRO_REF').AsString := VpaNumSerie;

    if VpaNroNota <> 0 then
      ProCadastro.FieldByName('I_NRO_NOT').AsInteger := VpaNroNota;
    if VpaLanOrcamento <> 0 then
      ProCadastro.FieldByName('I_LAN_ORC').AsInteger := VpaLanOrcamento;

    if VpaSeqNotaF <> 0 then
    begin
      if VpaNotaFornecedor then
        ProCadastro.FieldByName('I_NOT_ENT').AsInteger := VpaSeqNotaF
      else
        ProCadastro.FieldByName('I_NOT_SAI').AsInteger := VpaSeqNotaF;
    end;
    ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil, false,ProCadastro.ASQLConnection );
    ProCadastro.post;
    if ProCadastro.AErronaGravacao then
    begin
      // caso erro na ProCadastro de codigos sequencial a o proximo do movProCadastro
      ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil, true,ProCadastro.ASQLConnection );
      ProCadastro.post;
    end;
  end;
  //Atualiza as qtd dos kit's
//    AtualizaQtdKit(IntToStr(SequencialProduto),false);
  VpfResultado := BaixaEstoqueTecnicoouConsumoFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaCodCor,VpaCodTecnico,0,VpaDProduto,VpfQdadeBaixa,VpfDOperacaoEstoque.DesTipo_E_S,VpaDProduto.CodUnidade);
  if VpfResultado = '' then
  begin
    VpfResultado := BaixaEstoqueBarra(VpaDProduto.SeqProduto,VpaCodCor,VpaSeqBarra,VpaQdadeVendida,VpaunidadeAtual,VpaDProduto.CodUnidade,VpfDOperacaoEstoque.DesTipo_E_S);
    if VpfResultado = '' then
    begin
      if VpaNotaFornecedor then
        VpfResultado := BaixaEstoqueChapa(VpaDProduto,VpaCodCor,VpaCodTamanho,VpaCodFilial,VpaSeqNotaF,VpaQtdChapas, VpaLarChapa, VpaComChapa,VpfQdadeBaixa)
    end;
    if VpfResultado = '' then
      VpfResultado := BaixaEstoqueNumeroSerie(VpaDProduto,VpaCodCor,VpaCodTamanho,VpaCodFilial,VpaNumSerie,VpfQdadeBaixa,VpfTipoOperacao);
  end;

  VpfDOperacaoEstoque.free;
  ProCadastro.close;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFuncoesProduto.BaixaProdutoReservadoSubmontagemOP(VpaCodFilial, VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer;
  var VpaQtdProduto: Double; VpaUnidadeAtual, VpaUnidadePadrao, VpaTipOperacao: String): string;
begin
  if VpaTipOperacao = 'E' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select * ' +
                                 ' from FRACAOOP '+
                                 ' Where SEQPRODUTO = ' +IntToStr(VpaSeqProduto)+
                                 ' and CODFILIAL = '+IntToStr(VpaCodFilial)+
                                 ' and SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                                 ' AND NVL(CODCOR,0) = '+IntToStr(VpaCodCor)+
                                 ' AND NVL(CODTAMANHO,0) = ' +IntToStr(VpaCodTamanho)+
                                 ' AND DATFINALIZACAO IS NULL ' +
                                 ' ORDER BY INDPOSSUIEMESTOQUE DESC');
    while not Tabela.Eof and
          (VpaQtdProduto > 0) do
    begin
      VpaQtdProduto := VpaQtdProduto -1;
      FunOrdemProducao.AlteraEstagioFracaoOP(Tabela.FieldByName('CODFILIAL').AsInteger,Tabela.FieldByName('SEQORDEM').AsInteger,
                                             Tabela.FieldByName('SEQFRACAO').AsInteger,varia.EstagioFinalOrdemProducao);
      Tabela.next;
    end;
    Tabela.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueFiscal(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaUnidadeAtual,vpaUnidadePadrao, VpaTipoOperacao : String) : String;
var
  VpfQtdBaixa : Double;
begin
  result := '';
  if config.EstoqueCentralizado then
  VpaCodFilial := Varia.CodFilialControladoraEstoque;

  VpfQtdBaixa := CalculaQdadePadrao( VpaunidadeAtual, VpaUnidadePadrao, VpaQtdProduto, IntTostr(VpaSeqProduto));

  LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  if ProCadastro.eof then
  begin
    InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0, '');
    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  end;
  ProCadastro.Edit;

  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  // atualiza a qdade produtos em estoque
  if  VpaTipoOperacao = 'E' then  // entrada de produto
   ProCadastro.FieldByName('N_QTD_FIS').AsFloat := ProCadastro.FieldByName('N_QTD_FIS').AsFloat + VpfQtdBaixa
  else  // saida de produto
    ProCadastro.FieldByName('N_QTD_FIS').AsFloat := ProCadastro.FieldByName('N_QTD_FIS').AsFloat - VpfQtdBaixa;

  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.post;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueNumeroSerie(VpaDProduto: TRBDProduto;VpaCodCor, VpaCodTamanho, VpaCodfilial: Integer; VpaNumSerie: String;VpaQtdProduto: Double; VpaTipoOperacaoEstoque: TRBDTipoOperacaoEstoque): string;
begin
  AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUENUMEROSERIE ' +
                                    ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto)+
                                    ' AND CODFILIAL = ' +IntToStr(VpaCodfilial)+
                                    ' AND CODCOR = ' +IntToStr(VpaCodCor)+
                                    ' AND CODTAMANHO = ' + IntToStr(VpaCodTamanho)+
                                    ' AND DESNUMEROSERIE = '''+VpaNumSerie+'''');
  if ProCadastro.Eof then
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodfilial;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;
    ProCadastro.FieldByName('CODTAMANHO').AsInteger := VpaCodTamanho;
    ProCadastro.FieldByName('DESNUMEROSERIE').AsString := VpaNumSerie;
  end
  else
    ProCadastro.Edit;
  if VpaTipoOperacaoEstoque = toEntrada then
    ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat + VpaQtdProduto
  else
    ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat - VpaQtdProduto;
  if ProCadastro.FieldByName('SEQESTOQUE').AsInteger = 0 then
    ProCadastro.FieldByName('SEQESTOQUE').AsInteger := RSeqEstoqueNumeroSerieDisponivel(VpaCodfilial,VpaDProduto.SeqProduto,VpaCodCor,VpaCodTamanho);
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueTecnicoouConsumoFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaDProduto : TRBDProduto; VpaQtdProduto : Double;VpaTipOperacao,VpaDesUM : String) : string;
begin
  AdicionaSQLAbreTabela(AUX,'Select C_IND_FER from CADCLASSIFICACAO CLA, CADPRODUTOS PRO '+
                              ' Where PRO.I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                              ' and PRO.I_COD_EMP = CLA.I_COD_EMP '+
                              ' and PRO.C_COD_CLA = CLA.C_COD_CLA '+
                              ' and PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if AUX.FieldByName('C_IND_FER').AsString = 'S' then //so adiciona para o estoque do tecnico as ferramentas
    result := BaixaEstoqueTecnico(VpaCodFilial,VpaDProduto.SeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho,VpaQtdProduto,VpaTipOperacao)
  else
    result := BaixaConsumoFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,VpaCodCor,VpaDProduto, VpaQtdProduto,VpaDesUM,VpaTipOperacao);

end;
{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueTecnico(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaTipOperacao : String) : string;
begin
  if VpaCodTecnico <> 0 then
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUETECNICO '+
                                      ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                      ' and CODTECNICO = '+IntToStr(VpaCodTecnico)+
                                      ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                                      ' and CODCOR = '+IntToStr(VpaCodCor)+
                                      ' and CODTAMANHO = '+IntToStr(VpaCodTamanho));
    if ProCadastro.Eof then
    begin
      ProCadastro.insert;
      ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
      ProCadastro.FieldByName('CODTECNICO').AsInteger := VpaCodTecnico;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
      ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;
      ProCadastro.FieldByName('CODTAMANHO').AsInteger := VpaCodTamanho;
    end
    else
      ProCadastro.Edit;

    if VpaTipOperacao = 'S' then //esta saindo do estoque e entrando no estoque do tecnico por isso a operação será sempre o contrario .
      ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat + VpaQtdProduto
    else
      ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat - VpaQtdProduto;
    ProCadastro.FieldByName('DATALTERACAO').AsDateTime := now;
    ProCadastro.post;
    result := ProCadastro.AMensagemErroGravacao;
    ProCadastro.close;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueDefeito(VpaSeqProduto,VpaCodTecnico : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesOperacaoEstoque, VpaDesDefeito : string):string;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTODEFEITO ');
  ProCadastro.Insert;
  ProCadastro.FieldByName('DATMOVIMENTO').AsDateTime := now;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  ProCadastro.FieldByName('QTDPRODUTO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('DESUM').AsString := VpaDesUM;
  ProCadastro.FieldByName('CODTECNICO').AsInteger := VpaCodTecnico;
  ProCadastro.FieldByName('DESDEFEITO').AsString := VpaDesDefeito;
  ProCadastro.FieldByName('DESOPERACAOESTOQUE').AsString := VpaDesOperacaoEstoque;
  ProCadastro.FieldByName('SEQDEFEITO').AsInteger := RSeqDefeitoDisponivel;
  ProCadastro.post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueBarra(VpaSeqProduto,VpaCodCor,VpaSeqBarra : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesUMOriginal, VpaDesOperacaoEstoque : string):string;
var
  VpfQtdBarras, VpfQtdMetrosBarra, VpfQtdBaixar : Double;
  VpfSeqBarra : Integer;
begin
  result := '';
  if UpperCase(VpaDesUMOriginal) = UPPERCASE(VARIA.UnidadeBarra) Then
  begin
    if VpaDesUM <> varia.UnidadeBarra then
      VpfQtdBarras := 1
    else
      VpfQtdBarras := VpaQtdProduto;
    if VpaDesUM = varia.UnidadeBarra then
      VpfQtdMetrosBarra := RQtdMetrosBarraProduto(VpaSeqProduto);
    while (VpfQtdBarras > 0) and (Result = '') do
    begin
      AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUEBARRA '+
                                        ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProduto)+
                                        ' AND CODCOR = '+IntToStr(VpaCodCor)+
                                        ' AND SEQBARRA = '+IntToStr(VpaSeqBarra));
      if ProCadastro.Eof then
        ProCadastro.Insert
      else
        ProCadastro.Edit;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
      ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;

      if VpaDesUM = varia.UnidadeBarra then
      begin
        if VpfQtdBarras >= 1 then
          VpfQtdBaixar := VpfQtdMetrosBarra
        else
          VpfQtdBaixar := (VpfQtdMetrosBarra * VpfQtdBarras);
      end
      else
        VpfQtdBaixar := CalculaQdadePadrao(VpaDesUM,'mt',VpaQtdProduto,IntToStr(VpaSeqProduto));
      if VpaDesOperacaoEstoque = 'E' then
        ProCadastro.FieldByName('QTDMETRO').AsFloat := ProCadastro.FieldByName('QTDMETRO').AsFloat+ VpfQtdBaixar
      else
        ProCadastro.FieldByName('QTDMETRO').AsFloat := ProCadastro.FieldByName('QTDMETRO').AsFloat- VpfQtdBaixar;

      if ProCadastro.State = dsinsert then
        ProCadastro.FieldByName('SEQBARRA').AsInteger := RSeqBarraDisponivel(VpaSeqProduto);

      if ProCadastro.FieldByName('QTDMETRO').AsFloat <= 0 then
      begin
        if (ProCadastro.State = dsedit) then
        begin
          ProCadastro.cancel;
          ProCadastro.delete;
        end
        else
          ProCadastro.cancel;
      end
      else
      begin
        ProCadastro.Post;
        result := ProCadastro.AMensagemErroGravacao;
      end;
      VpfQtdBarras := VpfQtdBarras - 1;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueChapa(VpaDProduto : TRBDProduto; VpaCodCor,VpaCodTamanho, VpaCodfilial, VpaSeqNotaFor: Integer; VpaQtdChapas, VpaLarChapa,VpaComChapa, VpaPesoTotal: Double): string;
var
  VpfPesoChapa : Double;
begin
  result := '';
  if VpaQtdChapas <> 0 then
  begin
    VpaDProduto.IndGerouEstoqueChapa := true;
    VpfPesoChapa := VpaPesoTotal / VpaQtdChapas;
    AdicionaSQLAbreTabela(ProCadastro,'Select * from  ESTOQUECHAPA '+
                                      ' Where SEQCHAPA = 0 ');
    while (VpaQtdChapas > 0)and (result = '') do
    begin
      ProCadastro.Insert;
      ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodfilial;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
      ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;
      ProCadastro.FieldByName('CODTAMANHO').AsInteger := VpaCodTamanho;
      ProCadastro.FieldByName('LARCHAPA').AsFloat := VpaLarChapa;
      ProCadastro.FieldByName('COMCHAPA').AsFloat := VpaComChapa;
      ProCadastro.FieldByName('PERCHAPA').AsFloat := 100;
      ProCadastro.FieldByName('PESCHAPA').AsFloat := VpfPesoChapa;
      ProCadastro.FieldByName('SEQNOTAFORNECEDOR').AsInteger := VpaSeqNotaFor;
      ProCadastro.FieldByName('SEQCHAPA').AsInteger := RSeqChapaDisponivel;

      ProCadastro.Post;
      result :=  ProCadastro.AMensagemErroGravacao;
      VpaQtdChapas := VpaQtdChapas - 1;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaConsumoFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaCodCor : Integer;VpaDProduto : TRBDProduto;VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):string;
var
  VpfValCustoProduto : Double;
begin
  result := '';
  if VpaSeqOrdemProducao <> 0 then
  begin
    if VpaTipOperacao = 'S' then
      BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaDProduto.SeqProduto,VpaCodCor,VpaQtdProduto,VpaUM,VpaTipOperacao);
    if VpaQtdProduto > 0 then
    begin
      ProCadastro.close;
      ProCadastro.sql.clear;
      ProCadastro.sql.add('Select * from FRACAOOPCONSUMO '+
                                        ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                        ' and SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                                        ' and SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
      if VpaTipOperacao = 'S' then
        ProCadastro.sql.add(' and INDBAIXADO = ''N''')
      else
        ProCadastro.sql.add(' and QTDBAIXADO > 0');
      if VpaCodCor <> 0 then
        ProCadastro.sql.add('and CODCOR = '+IntToStr(VpaCodCor))
      else
        ProCadastro.sql.add('and CODCOR IS NULL');
      ProCadastro.sql.add('order by INDMATERIALEXTRA DESC');
      ProCadastro.Open;
      while not ProCadastro.eof and (VpaQtdProduto > 0) and (result = '') do
      begin
        ProCadastro.Edit;
        VpaQtdProduto := CalculaQdadePadrao(VpaUM,ProCadastro.FieldByName('DESUM').AsString,VpaQtdProduto,IntToStr(VpaDProduto.SeqProduto));
        VpaUM := ProCadastro.FieldByName('DESUM').AsString;
        if VpaTipOperacao = 'S' then
        begin
          if VpaQtdProduto > (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat) then
          begin
            VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat);
            ProCadastro.FieldByName('QTDBAIXADO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat;
            ProCadastro.FieldByName('INDBAIXADO').AsString := 'S';
          end
          else
            if VpaQtdProduto <= (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat) then
            begin
              ProCadastro.FieldByName('QTDBAIXADO').AsFloat := ProCadastro.FieldByName('QTDBAIXADO').AsFloat + VpaQtdProduto;
              VpaQtdProduto := 0;
            end;
        end
        else
          if VpaTipOperacao = 'E' then
          begin
            if VpaQtdProduto >= (ProCadastro.FieldByName('QTDBAIXADO').AsFloat) then
            begin
              VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDBAIXADO').AsFloat);
              ProCadastro.FieldByName('QTDBAIXADO').AsFloat := 0;
              ProCadastro.FieldByName('INDBAIXADO').AsString := 'N';
            end
            else
              if VpaQtdProduto < (ProCadastro.FieldByName('QTDBAIXAD0').AsFloat) then
              begin
                ProCadastro.FieldByName('QTDBAIXADO').AsFloat := ProCadastro.FieldByName('QTDBAIXADO').AsFloat - VpaQtdProduto;
                VpaQtdProduto := 0;
              end;
          end;
        VpfValCustoProduto := CalculaValorPadrao(VpaUM,VpaDProduto.CodUnidade,VpaDProduto.VlrCusto,IntToStr(VpaDProduto.SeqProduto));
        ProCadastro.FieldByName('VALCUSTOTOTAL').AsFloat := ProCadastro.FieldByName('QTDBAIXADO').AsFloat * VpfValCustoProduto;
        try
          //estorno de um produto extra enviado para a maquina, tem que excluir o material extra;
          if (ProCadastro.FieldByName('INDMATERIALEXTRA').AsString = 'S') and
             (ProCadastro.FieldByName('QTDBAIXADO').AsFloat = 0) then
          begin
            ProCadastro.cancel;
            ProCadastro.Delete;
          end
          else
          ProCadastro.post;
        except
          on e : exception do result := 'ERRO NA GRAVAÇÃO DA FRACAOOPCONSUMO!!!'#13+e.message;
        end;
        ProCadastro.next;
      end;
      ProCadastro.close;
      if result = '' then
      begin
        if VpaQtdProduto > 0 then
        begin
          if VpaTipOperacao = 'S' Then
            result := AdicionaConsumoExtraFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,VpaDProduto.SeqProduto,VpaCodCor,VpaQtdProduto,VpaUM,VpaTipOperacao)
          else
            BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaDProduto.SeqProduto,VpaCodCor,VpaQtdProduto,VpaUM,VpaTipOperacao);
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaQtdAReservarProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
var
  VpfQtdAReservar : Double;
begin
  result := '';

  if config.EstoqueCentralizado then
    VpaCodFilial := Varia.CodFilialControladoraEstoque;

  VpfQtdAReservar := CalculaQdadePadrao( VpaunidadeAtual, VpaUnidadePadrao, VpaQtdProduto, IntTostr(VpaSeqProduto));

  LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  if ProCadastro.eof then
  begin
    InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0, '');
    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  end;
  ProCadastro.Edit;

  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  // atualiza a qdade produtos em estoque
  if  VpaTipOperacao = 'E' then  // adiciona o produto reservado e diminui a quantidade de estoque
    ProCadastro.FieldByName('N_QTD_ARE').AsFloat := ProCadastro.FieldByName('N_QTD_ARE').AsFloat + VpfQtdAReservar
  else  // diminui a quantidade reservado e aumenta a quantidade de estoque
    ProCadastro.FieldByName('N_QTD_ARE').AsFloat := ProCadastro.FieldByName('N_QTD_ARE').AsFloat - VpfQtdAReservar;
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.post;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaQtdReservadoOP(VpaCodFilial, VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer; VpaQtdProduto: Double; VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao: String): string;
var
  VpfQtdInicial, VpfQtdAReservarBaixada : Double;
  VpfUmInicial,VpfOperacaoQtdAReservar : String;
begin
  result :='';
  VpfQtdInicial := VpaQtdProduto;
  VpfUmInicial := VpaUnidadeAtual;
  VpfQtdAReservarBaixada := 0;
  AdicionaSQLAbreTabela(ProCadastro,'Select * from FRACAOOPCONSUMO '+
                                    ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                    ' AND SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                                    ' AND SEQPRODUTO = '+ IntToStr(VpaSeqProduto)+
                                    ' ORDER BY SEQFRACAO ');
  while not(ProCadastro.Eof) and
        (result = '') and
        (VpaQtdProduto > 0)  do
  begin
    if ((ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat
       - ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat) > 0) then
    begin
      VpaQtdProduto := CalculaQdadePadrao( VpaunidadeAtual,ProCadastro.FieldByName('DESUM').AsString, VpaQtdProduto, IntTostr(VpaSeqProduto));
      VpaunidadeAtual := ProCadastro.FieldByName('DESUM').AsString;
      ProCadastro.Edit;
      if VpaQtdProduto >= (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat
       - ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat) THEN
      begin
        VpfQtdAReservarBaixada := VpfQtdAReservarBaixada + ProCadastro.FieldByName('QTDARESERVAR').AsFloat;
        ProCadastro.FieldByName('QTDARESERVAR').AsFloat := 0;
        VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat- ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat);
        ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat;
      end
      else
      begin
        if VpaQtdProduto > ProCadastro.FieldByName('QTDARESERVAR').AsFloat then
          VpfQtdAReservarBaixada := VpfQtdAReservarBaixada + ProCadastro.FieldByName('QTDARESERVAR').AsFloat
        else
          VpfQtdAReservarBaixada := VpfQtdAReservarBaixada + VpaQtdProduto;

        ProCadastro.FieldByName('QTDARESERVAR').AsFloat := ProCadastro.FieldByName('QTDARESERVAR').AsFloat-VpaQtdProduto;
        if ProCadastro.FieldByName('QTDARESERVAR').AsFloat < 0  then
          ProCadastro.FieldByName('QTDARESERVAR').AsFloat := 0;
        ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat := ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat +VpaQtdProduto;
      end;
      ProCadastro.post;
      result := ProCadastro.AMensagemErroGravacao;
    end;
    ProCadastro.next;
  end;
  if result = '' then
  begin
    if VpaQtdProduto > 0  then
    begin
      result := BaixaProdutoReservadoSubmontagemOP(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho,VpaSeqOrdemProducao,VpaQtdProduto,VpaUnidadeAtual,
                                                   VpaUnidadePadrao,VpaTipOperacao);
      if (result = '') and (VpaQtdProduto > 0) then
      begin
        Result := GravaProdutoReservadoEmExcesso(VpaSeqProduto,VpaCodFilial,VpaSeqOrdemProducao,VpfUmInicial,0,VpfQtdInicial,VpaQtdProduto);
      end;
    end;
    if result = ''  then
    begin
      if VpaTipOperacao = 'E' then
        VpfOperacaoQtdAReservar := 'S'
      else
        VpfOperacaoQtdAReservar := 'E';
      result := BaixaQtdAReservarProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho,VpfQtdAReservarBaixada,VpaUnidadeAtual,
                                        VpaUnidadePadrao,VpfOperacaoQtdAReservar);
    end;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ReservaEstoqueProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao : Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
var
  VpfQtdReservar, VpfQtdInicial : Double;
begin
  result := '';

  if RQuantidadeEstoqueProduto(VpaSeqProduto, VpaCodCor, VpaCodTamanho) > 0 then
  begin
    if config.EstoqueCentralizado then
      VpaCodFilial := Varia.CodFilialControladoraEstoque;

    VpfQtdReservar := CalculaQdadePadrao( VpaunidadeAtual, VpaUnidadePadrao, VpaQtdProduto, IntTostr(VpaSeqProduto));

    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
    if ProCadastro.eof then
    begin
      InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0, '');
      LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
    end;
    ProCadastro.Edit;
    VpfQtdInicial := ProCadastro.FieldByName('N_QTD_RES').AsFloat;

    //atualiza a data de alteracao para poder exportar
    ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

    // atualiza a qdade produtos em estoque
    if  VpaTipOperacao = 'E' then  // adiciona o produto reservado
    begin
      ProCadastro.FieldByName('N_QTD_RES').AsFloat := ProCadastro.FieldByName('N_QTD_RES').AsFloat + VpfQtdReservar;
      if ProCadastro.FieldByName('N_QTD_RES').AsFloat > ProCadastro.FieldByName('N_QTD_PRO').AsFloat then
        result := GravaProdutoReservadoEmExcesso(VpaSeqProduto,0,0,VpaUnidadeAtual,ProCadastro.FieldByName('N_QTD_PRO').AsFloat,VpaQtdProduto,0);
    end
    else  // diminui a quantidade reservado
    begin
      ProCadastro.FieldByName('N_QTD_RES').AsFloat := ProCadastro.FieldByName('N_QTD_RES').AsFloat - VpfQtdReservar;
    end;
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.post;
    Result := ProCadastro.AMensagemErroGravacao;

    if Result = ''  then
      result := GravaMovimentoProdutoReservado(VpaSeqProduto,VpaCodFilial,VpaSeqOrdemProducao,VpaUnidadeAtual, VpaQtdProduto,VpfQtdInicial,ProCadastro.FieldByName('N_QTD_RES').AsFloat,VpaTipOperacao);

    if result = ''  then
    begin
      if VpaSeqOrdemProducao <> 0 then
      begin
        Result := BaixaQtdReservadoOP(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho,VpaSeqOrdemProducao,VpaQtdProduto,VpaUnidadeAtual,VpaUnidadePadrao,VpaTipOperacao);
      end;
    end;
    ProCadastro.close;
  end
  else
    aviso('Produto não possui estoque!');
end;

{************************ atualiza a qtd do kit *******************************}
function TFuncoesProduto.AtualizaQtdKit(VpaSeqProduto : String;VpaKit :Boolean):Boolean;
Var
  VpfKits : TStringList;
  VpfLaco : Integer;
begin
  // cria a lista de string que contera os codigos dos kits que serão atualizados
  VpfKits := TStringList.Create;
  VpfKits.CLEAR;

   //carrega os kit's que serao atualizados
  if VpaKit then
    VpfKits.Add(VpaSeqProduto)
  else
  begin
    CKitsProdutos(VpaSeqProduto,VpfKits);
  end;

  //atualiza a quantidade de estoque dos kit's
  for VpfLaco := 0 to VpfKits.Count -1 do
  begin
    ExecutaComandoSql(AUX,'update MOVQDADEPRODUTO MOV '+
                    ' set MOV.N_QTD_PRO = (select min(QTD.N_QTD_PRO / KIT.N_QTD_PRO) QDADE '+
                    ' FROM MOVQDADEPRODUTO QTD, MOVKIT KIT '+
                    ' WHERE KIT.I_SEQ_PRO = QTD.I_SEQ_PRO '+
                    ' AND KIT.I_PRO_KIT = '+ VpfKits.Strings[VpfLaco] +
                    ' AND KIT.I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa) +
                    ' AND  QTD.I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil) +')'+
                    ' WHERE I_SEQ_PRO = '+ VpfKits.Strings[VpfLaco] +
                    ' AND I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil));
  end;
  VpfKits.free;
  result := true;
end;

{******************************************************************************}
function TFuncoesProduto.EstornaEstoque(VpaDMovimento : TRBDMovEstoque) : String;
var
  VpfQtdEstorno : double;
begin
  result := OperacoesEstornoValidas;
  if result = '' then
  begin
    if VpaDMovimento.SeqProduto <> 0 then
    begin
      // localiza o produto
      LocalizaProdutoSequencial(calcula, IntToStr(VpaDMovimento.SeqProduto));
      VpfQtdEstorno := CalculaQdadePadrao(VpaDMovimento.CodUnidade,
                                         Calcula.fieldByName('C_COD_UNI').AsString,
                                         VpaDMovimento.QtdProduto,
                                          IntTostr(VpaDMovimento.SeqProduto) );
      Calcula.close;
      LocalizaMovQdadeSequencial(ProCadastro,VpaDMovimento.CodFilial,VpaDMovimento.SeqProduto ,VpaDMovimento.CodCor,VpaDMovimento.CodTamanho);
      if ProCadastro.eof then
      begin
        InsereProdutoFilial(VpaDMovimento.SeqProduto ,VpaDMovimento.CodFilial,VpaDMovimento.CodCor,VpaDMovimento.CodTamanho,0,0,0,0,0, '');
        LocalizaMovQdadeSequencial(ProCadastro,VpaDMovimento.CodFilial,VpaDMovimento.SeqProduto ,VpaDMovimento.CodCor,VpaDMovimento.CodTamanho);
      end;

       // atualiza a qdade produtos
      ProCadastro.Edit;

      if  VpaDMovimento.TipMovimento = 'S' then  // entrada de produto
        Procadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat + VpfQtdEstorno
      else  // saida de produto
        ProCadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat - VpfQtdEstorno;

      //atualiza a data de alteracao para poder exportar
      Procadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

      ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
      ProCadastro.post;
      ProCadastro.Close;

      if VpaDMovimento.DatMovimento > varia.DataUltimoFechamento then
        ExcluiMovimentoEstoque(VpaDMovimento.CodFilial,VpaDMovimento.LanEstoque,VpaDMovimento.SeqProduto)
      else
      begin
        VpaDMovimento.LanEstoque := 0;
        VpaDMovimento.DatMovimento := Date;
        if VpaDMovimento.TipMovimento = 'S' then
        begin
          VpaDMovimento.TipMovimento := 'E';
          VpaDMovimento.CodOperacaoEstoque := varia.OperacaoEstoqueEstornoEntrada;
        end
        else
        begin
          VpaDMovimento.TipMovimento := 'S';
          VpaDMovimento.CodOperacaoEstoque := varia.OperacaoEstoqueEstornoSaida;
        end;
        result := GravaDMovimentoEstoque(VpaDMovimento);
      end;
    end;
  end;
end;

{************ insere um novo produto na tabela de preco ***********************}
function TFuncoesProduto.AdicionaProdutoNaTabelaPreco(VpaCodTabela: Integer; VpaDProduto: TRBDProduto;VpaCodTamanho, VpaCodCor : Integer): String;
begin
  LocalizaCadTabelaPreco(Tabela, VpaCodTabela);
  if not Tabela.Eof then
  begin
    LimpaSQLTabela(ProCadastro);
    AdicionaSQLTabela(ProCadastro,'SELECT *'+
                                      ' FROM MOVTABELAPRECO'+
                                      ' WHERE I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                                      ' AND I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                      ' AND I_COD_TAB = '+IntToStr(VpaCodTabela)+
                                      ' AND I_COD_CLI = 0');
   if VpaCodTamanho <> 0 then
     ProCadastro.SQL.Add(' AND I_COD_TAM = ' + IntToStr(VpaCodTamanho))
   else
     ProCadastro.SQL.Add(' AND I_COD_TAM = 0 ');

   if VpaCodCor <> 0 then
     ProCadastro.SQL.Add(' AND I_COD_COR = ' + IntToStr(VpaCodCor))
   else
     ProCadastro.SQL.Add(' AND I_COD_COR = 0');

    ProCadastro.Open;

    if ProCadastro.Eof then
      ProCadastro.Insert
    else
      ProCadastro.Edit;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger:= Varia.CodigoEmpresa;
    ProCadastro.FieldByName('I_COD_TAB').AsInteger:= VpaCodTabela;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger:= VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger:= VpaCodTamanho;
    ProCadastro.FieldByName('I_COD_COR').AsInteger:= VpaCodCor;
    ProCadastro.FieldByName('I_COD_MOE').AsInteger:= VpaDProduto.CodMoeda;
    ProCadastro.FieldByName('N_VLR_VEN').AsFloat:= VpaDProduto.VlrVenda;
    ProCadastro.FieldByName('N_VLR_REV').AsFloat:= VpaDProduto.VlrRevenda;
    ProCadastro.FieldByName('N_PER_MAX').AsFloat:= VpaDProduto.PerMaxDesconto;
    ProCadastro.FieldByName('C_CIF_MOE').AsString:= VpaDProduto.CifraoMoeda;
    ProCadastro.FieldByName('I_COD_CLI').AsInteger:= 0;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= Now;
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
  end;
  Tabela.Close;
  ProCadastro.Close;
end;

{****************** Verifica item pertence a um kit ************************** }
function TFuncoesProduto.VerificaItemKit( codigoPro : string ) : Boolean;
begin
  AdicionaSQLAbreTabela(calcula, 'select * from MovKit where i_seq_pro = ' + codigoPro );
  result := calcula.Eof;
  FechaTabela(calcula);
end;


{********** converte a moeda de um produto na tabela de preco *****************}
procedure TFuncoesProduto.ConverteMoedaTabela( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
var
  CifraoNovaTabela : string;
begin
  AdicionaSQLAbreTabela(ProCadastro, ' select * from MovTabelaPreco ' +
                                ' where i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                ' and i_cod_tab = ' + intToStr(TabelaPreco) +
                                ' and i_seq_pro = ' + intToStr(SequencialProduto)+
                                ' and I_COD_CLI = 0 ' );
  ProCadastro.edit;
  ProCadastro.FieldByName('n_vlr_ven').AsCurrency := UnMoeda.ConverteValor( CifraoNovaTabela,ProCadastro.fieldByname('i_cod_moe').AsInteger,
                                                NovaMoeda, ProCadastro.fieldByname('n_vlr_ven').AsFloat);
  ProCadastro.fieldByName('i_cod_moe').AsInteger := NovaMoeda;
  ProCadastro.FieldByName('c_cif_moe').AsString := CifraoNovaTabela;
  ProCadastro.FieldByName('D_Ult_Alt').AsDateTime := Date;
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.Post;
  ProCadastro.Close;
end;


{********** converte a moeda de um produto, tabela de preco e custo, compra ***}
procedure TFuncoesProduto.ConverteMoedaProduto( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
var
  MoedaAtual : Integer;
  CifraoNovaTabela : string;
begin
  AdicionaSQLAbreTabela(ProCadastro, ' select * from CadProdutos ' +
                                ' where i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                ' and i_seq_pro = ' + intToStr(SequencialProduto) );

  MoedaAtual := ProCadastro.fieldByName('i_cod_moe').AsInteger;

  ProCadastro.edit;
  ProCadastro.fieldbyName('i_cod_moe').AsInteger := NovaMoeda;
  ProCadastro.fieldbyName('c_cif_moe').AsString := UnMoeda.UnidadeMonetaria(NovaMoeda);
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.post;
  ProCadastro.close;


  AdicionaSQLAbreTabela(ProCadastro, ' select * from MovQdadeProduto ' +
                                ' where i_emp_fil = ' + intToStr(varia.CodigoEmpFil) +
                                ' and i_seq_pro = ' + intToStr(SequencialProduto) );

  ProCadastro.edit;
  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  ProCadastro.fieldbyName('n_vlr_com').AsFloat := UnMoeda.ConverteValor( CifraoNovaTabela, MoedaAtual,
                                               NovaMoeda, ProCadastro.fieldByname('n_vlr_com').AsFloat);
  ProCadastro.fieldbyName('n_vlr_cus').AsFloat := UnMoeda.ConverteValor( CifraoNovaTabela, MoedaAtual,
                                               NovaMoeda, ProCadastro.fieldByname('n_vlr_cus').AsFloat);
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.post;
  ProCadastro.close;
end;

{******** alterar a atividade de um produto ******************************* }
Procedure TFuncoesProduto.AlteraAtividadeProduto( SequencialProduto : integer);
begin
  LocalizaProdutoSequencial(ProCadastro, IntToStr(SequencialProduto));
  ProCadastro.edit;
  if ProCadastro.fieldByName('C_ATI_PRO').AsString = 'S' then
    ProCadastro.fieldByName('C_ATI_PRO').AsString := 'N'
  else
    ProCadastro.fieldByName('C_ATI_PRO').AsString := 'S';
  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_Ult_Alt').AsDateTime := Date;
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.post;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraClassificacaoFiscalProduto(VpaSeqProduto : Integer; VpaCodClassificacao: string;VpaPerMVA : Double): string;
begin
  AdicionaSQLAbreTabela(ProCadastro,'Select * from CADPRODUTOS '+
                                    ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto) );
  ProCadastro.Edit;
  ProCadastro.FieldByName('C_CLA_FIS').AsString := VpaCodClassificacao;
  ProCadastro.FieldByName('N_PER_SUT').AsFloat := VpaPerMVA;
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraClassificacaoProduto(VpaSeqProduto : Integer;VpaNovaClassificacao : String) : String;
begin
  result := '';
  try
    ExecutaComandoSql(AUX,'UPDATE CADPRODUTOS '+
                        ' Set C_COD_CLA = '''+ VpaNovaClassificacao+'''' +
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  except
    on e : exception do result := 'ERRO NA ALTERAÇÃO DA CLASSIFICAÇÃO!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraClassificacaoProdutoFamilia(VpaSeqProduto: Integer): String;
var
  VpfCodigoClassificacao: string;
begin
  if varia.CodClassificacaoMateriaPrimaemAprovacao <> '' then
  begin
    VpfCodigoClassificacao:= RCodigoClassificacaoProduto(VpaSeqProduto);

    if VpfCodigoClassificacao = varia.CodClassificacaoMateriaPrimaemAprovacao then
    begin
      try
        ExecutaComandoSql(AUX,'UPDATE CADPRODUTOS '+
                          ' Set C_COD_CLA = '''+ Varia.CodClassificacaoMateriaPrima+'''' +
                          ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
      except
      on e : exception do result := 'ERRO NA ALTERAÇÃO DA CLASSIFICAÇÃO!!!'#13+e.message;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraPrateleiraProduto(VpaSeqProduto: Integer;
  VpaDesPrateleira: String): String;
begin
  ExecutaComandoSql(ProCadastro, 'UPDATE CADPRODUTOS SET C_PRA_PRO = '''+ VpaDesPrateleira + ''''+
                         ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));

  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraProdutoParaSubstituicaoTributaria(VpaSeqProduto: Integer; VpaCodST: string): string;
begin
  RESULT:= '';
  if (Copy(VpaCodST,2,2) = '10') or ((Copy(VpaCodST,2,2) = '60') or (Copy(VpaCodST,2,2) = '70')) then
  begin
    Try
      ExecutaComandoSql(AUX,'Update CADPRODUTOS SET C_SUB_TRI = ''S''' +
                          ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
    except
      on e: exception do result := 'ERRO NA ATUALIZAÇÃO DO CAMPO SUBSTITUICAO TRIBUTARIA.'#13+e.message;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraValorVendaProduto(VpaSeqProduto, VpaCodTamanho : Integer;VpaNovoValor :Double):String;
begin
  result := '';
  try
    ExecutaComandoSql(AUX,'Update MOVTABELAPRECO ' +
                        'SET N_VLR_VEN = '+ SubstituiStr(DeletaChars(FloatToStr(VpaNovoValor),'.'),',','.') +
                        ' Where I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa)+
                        ' and I_COD_TAB = '+ IntTostr(varia.tabelaPreco)+
                        ' and I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                        ' and I_COD_TAM = '+IntToStr(VpaCodTamanho)+
                        ' and I_COD_MOE = '+ IntToStr(Varia.MoedaBase));
  except
    on e: exception do result := 'ERRO NA ATUALIZAÇÃO DO VALOR DE VENDA DO PRODUTO.'#13'Sequencial do Produto = '+IntToStr(VpaSeqProduto)+' Valor Venda = '+FloatToStr(VpaNovoValor)+#13+e.message;
  end;

end;

{******* inseri uma classificacao toda em uma determinada filial ************* }
procedure TFuncoesProduto.InseriProdutoClassificacaoFilial(Vpa_SeqPro_CodCla, VpaFilial, VpaEmpresa: string; NQtdMin, NQtdPed, VpaValCusto : Double; Classificacao : Boolean);
//var
//  VpfCodigoBarra : String;
begin
{ Colocado em comentario dia 11/05/2008  por nao saber se ainda é util
    CodBrra := TCodigoBarra.Create;
    if Classificacao then
      LocalizaSeqProdutoQdadeClassificacao(TABELA, Vpa_SeqPro_CodCla)
    else
      LocalizaProdutoSequencialQdade(tabela,Vpa_SeqPro_CodCla,'0');

    if TABELA.EOF then
      Aviso(CT_Cassificacao_Vazia)
    else
    begin
      TABELA.First;
      while not TABELA.EOF do
      begin
        VpfCodigoBarra := CodBrra.GeraCodigoBarra( MascaraBarra(TABELA.FieldByName('I_COD_BAR').AsInteger),
                                                   VpaEmpresa,
                                                   VpaFilial,
                                                   TABELA.FieldByName('C_COD_CLA').AsString,
                                                   TABELA.FieldByName('C_COD_PRO').AsString,
                                                   TABELA.FieldByName('C_COD_REF').AsString,
                                                   TABELA.FieldByName('I_SEQ_PRO').AsString,
                                                   TABELA.FieldByName('C_BAR_FOR').AsString);

        InsereProdutoFilial( TABELA.FieldByName('I_SEQ_PRO').AsInteger,
                             VpaFilial, Tabela.FieldByName('I_COD_COR').AsString, VpfCodigoBarra,  TABELA.FieldByName('I_COD_BAR').AsString,
                             NQtdMin,  NQtdPed, VpaValCusto);
        TABELA.Next;
      end;
    end;
  CodBrra.Free;}
end;

{************** inseri um produto em uma determinada filial *************** }
procedure TFuncoesProduto.InsereProdutoFilial(VpaSeqProduto, VpaCodFilial,VpaCodCor, VpaCodTamanho  : Integer;VpaQtdEstoque, VpaQtdMinima, VpaQtdPedido,VpaValCusto, VpaValCompra: Double; VpaCodBarra : String);
begin

  // Verifica se o produto  ja existe.
  AdicionaSQLAbreTabela(ProCadastro,' SELECT * FROM MOVQDADEPRODUTO ' +
                            ' WHERE I_EMP_FIL = ' +IntToStr(VpaCodFilial) +
                            ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and I_COD_COR = '+ InttoStr(VpaCodCor)+
                            ' and I_COD_TAM = '+IntToStr(VpaCodTamanho));
  if ProCadastro.EOF then // Se não existe - adiciona.
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaCodFilial;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaSeqProduto;
    ProCadastro.FieldByName('I_COD_COR').AsInteger := VpaCodCor;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger := VpaCodTamanho;
    ProCadastro.FieldByName('N_QTD_PRO').AsFloat := VpaQtdEstoque;
    ProCadastro.FieldByName('N_QTD_FIS').AsFloat := 0;
    ProCadastro.FieldByName('N_QTD_MIN').AsFloat := VpaQtdMinima;
    ProCadastro.FieldByName('N_QTD_PED').AsFloat := VpaQtdPedido;
    ProCadastro.FieldByName('N_VLR_COM').AsFloat := VpaValCompra;
    ProCadastro.FieldByName('N_VLR_CUS').AsFloat := VpaValCusto;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.FieldByName('C_COD_BAR').AsString:= VpaCodBarra;
    ProCadastro.Post;
    Sistema.MarcaTabelaParaImportar('MOVQDADEPRODUTO');
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.InsereProdutoFilial(VpaCodFilial, VpaCodCor, VpaCodTamanho: Integer; VpaDProduto: TRBDProduto): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM MOVQDADEPRODUTO'+
                                    ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' AND I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                                    ' AND I_COD_COR = '+InttoStr(VpaCodCor)+
                                    ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho));
  if (ProCadastro.Eof) or (VpaCodFilial = varia.CodigoEmpFil)  then
  begin
    if (ProCadastro.Eof) then
    begin
      ProCadastro.Insert;
      if (VpaCodFilial = Varia.CodigoEmpFil) then //somente coloca o estoque na filial ativa
      begin
        ProCadastro.FieldByName('N_QTD_PRO').AsFloat:= VpaDProduto.QtdEstoque;
        ProCadastro.FieldByName('N_QTD_FIS').AsFloat:= VpaDProduto.QtdEstoque;
      end
      else
      begin
        ProCadastro.FieldByName('N_QTD_PRO').AsFloat:= 0;
        ProCadastro.FieldByName('N_QTD_FIS').AsFloat:= 0;
      end;
    end
    else
      ProCadastro.Edit;

    ProCadastro.FieldByName('I_EMP_FIL').AsInteger:= VpaCodFilial;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger:= VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger:= VpaCodTamanho;
    ProCadastro.FieldByName('I_COD_COR').AsInteger:= VpaCodCor;
    ProCadastro.FieldByName('N_QTD_MIN').AsFloat:= VpaDProduto.QtdMinima;
    ProCadastro.FieldByName('N_QTD_PED').AsFloat:= VpaDProduto.QtdPedido;
    ProCadastro.FieldByName('N_VLR_COM').AsFloat:= VpaDProduto.VlrCusto;
    ProCadastro.FieldByName('N_VLR_CUS').AsFloat:= VpaDProduto.VlrCusto;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= Now;

    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.Post;
    result :=  ProCadastro.AMensagemErroGravacao;
  end;

  ProCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.AdicionaProdutosFilialAtiva;
begin
  AdicionaSQLAbreTabela(Tabela,'select * from CADPRODUTOS PRO '+
                               ' where PRO.I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa)+
                               ' and not exists (select * from MOVQDADEPRODUTO QTD ' +
                               ' Where QTD.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                               ' and QTD.I_COD_COR = 0 '+
                               ' and QTD.I_COD_TAM = 0 '+
                               ' and QTD.I_EMP_FIL = '+ IntToStr(varia.CodigoEmpFil)+')');
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVQDADEPRODUTO'+
                                    ' WHERE I_EMP_FIL = 0 AND I_SEQ_PRO = 0' );
  While not Tabela.Eof do
  begin
    ProCadastro.insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := varia.CodigoEmpFil;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
    ProCadastro.FieldByName('N_QTD_PRO').AsInteger := 0;
    ProCadastro.FieldByName('N_QTD_MIN').AsInteger := 0;
    ProCadastro.FieldByName('N_QTD_PED').AsInteger := 0;
    ProCadastro.FieldByName('N_VLR_CUS').AsInteger := 0;
    ProCadastro.FieldByName('I_COD_COR').AsInteger := 0;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger := 0;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := date;
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.Post;
    Tabela.Next;
  end;

  AdicionaSQLAbreTabela(Tabela,'select * from MOVQDADEPRODUTO PRO '+
                               ' where PRO.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil)+
                               ' and not exists (select * from MOVTABELAPRECO MOV ' +
                               ' Where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                               ' and MOV.I_COD_TAM = PRO.I_COD_TAM '+
                               ' and MOV.I_COD_COR = PRO.I_COD_COR '+
                               ' and MOV.I_COD_TAB = '+IntToStr(VARIA.TabelaPreco)+
                               ' and MOV.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+' )');
  While not Tabela.Eof do
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVTABELAPRECO '+
                                      ' Where I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa)+
                                      ' and I_SEQ_PRO = '+Tabela.FieldByName('I_SEQ_PRO').AsString+
                                      ' and I_COD_TAB = '+IntToStr(VARIA.TabelaPreco)+
                                      ' and I_COD_TAM = '+IntToStr(Tabela.FieldByName('I_COD_TAM').AsInteger));
    if ProCadastro.eof then
    begin
      ProCadastro.Insert;
      ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
      ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
      ProCadastro.FieldByName('I_COD_TAM').AsInteger := Tabela.FieldByName('I_COD_TAM').AsInteger;
      ProCadastro.FieldByName('I_COD_COR').AsInteger := Tabela.FieldByName('I_COD_COR').AsInteger;
      ProCadastro.FieldByName('I_COD_TAB').AsInteger := Varia.TabelaPreco;
      ProCadastro.FieldByName('I_COD_MOE').AsInteger := Varia.MoedaBase;
      ProCadastro.FieldByName('N_VLR_VEN').AsInteger := 0;
      ProCadastro.FieldByName('N_PER_MAX').AsInteger := 0;
      ProCadastro.FieldByName('C_CIF_MOE').AsString := varia.MascaraMoeda;
      ProCadastro.FieldByName('I_COD_CLI').AsInteger := 0;
      ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := date;
      ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
      ProCadastro.Post;
    end;
    Tabela.Next;
  end;
  ProCadastro.close;
  Aviso('Produtos Adicionados com sucesso');
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesProduto.AdicionaRepeticaoInstalacaoTear(VpaDProduto: TRBDProduto; VpaColunaInicial, VpaColunaFinal, VpaQtdRepeticao: Integer): String;
var
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
  VpfLaco,VpfAux : Integer;
begin
  result := '';
  if VpaColunaInicial > VpaColunaFinal then
  begin
    VpfAux := VpaColunaInicial;
    VpaColunaInicial := VpaColunaFinal;
    VpaColunaFinal := VpfAux;
  end;
  for VpfLaco := 0 to VpaDProduto.DInstalacaoCorTear.Repeticoes.count - 1 do
  begin
    VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VpaDProduto.DInstalacaoCorTear.Repeticoes.Items[VpfLaco]);
    if ((VpaColunaInicial >= VpfDRepeticao.NumColunaInicial) and
       (VpaColunaInicial <= VpfDRepeticao.NumColunaFinal))or
       ((VpaColunaFinal >= VpfDRepeticao.NumColunaInicial) and
       (VpaColunaFinal <= VpfDRepeticao.NumColunaFinal)) then
    begin
      result := 'COLUNA INICIAL E FINAL INVÁLIDAS!!!'#13'Já existe repetição selecinada para esse intervalo.';
      break;
    end;
  end;
  if result = ''  then
  begin
    VpfDRepeticao := VpaDProduto.DInstalacaoCorTear.AddRepeticoes;
    VpfDRepeticao.NumColunaInicial := VpaColunaInicial;
    VpfDRepeticao.NumColunaFinal := VpaColunaFinal;
    VpfDRepeticao.QtdRepeticao := VpaQtdRepeticao;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AdicionarProdutosFilial: String;
var
  VpfLaco: Integer;
begin
  VpfLaco:= 5085;
  result := '';
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_PRO from CADPRODUTOS '+
                            ' Where C_COD_CLA = ''301''');

  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOFILIALFATURAMENTO ');

  while not aux.Eof do
  begin
      ProCadastro.Insert;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger:= Aux.FieldByName('I_SEQ_PRO').AsInteger;
      ProCadastro.FieldByName('SEQITEM').AsInteger:= VpfLaco + 1;
      ProCadastro.FieldByName('CODFILIAL').AsInteger:= 11;
      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
      if result <> '' then
        break;
      aux.Next;
      VpfLaco:= VpfLaco+1;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.AdicionaTodasTabelasdePreco(VpaDProduto: TRBDProduto);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  FreeTObjectsList(VpaDProduto.TabelaPreco);
  AdicionaSQLAbreTabela(Tabela,'Select * from CADTABELAPRECO ');
  while not Tabela.eof do
  begin
    VpfDTabelaPreco := VpaDProduto.AddTabelaPreco;
    VpfDTabelaPreco.CodTabelaPreco := Tabela.FieldByName('I_COD_TAB').AsInteger;
    VpfDTabelaPreco.NomTabelaPreco := Tabela.FieldByName('C_NOM_TAB').AsString;
    VpfDTabelaPreco.CodTamanho := 0;
    VpfDTabelaPreco.CodCliente := 0;
    VpfDTabelaPreco.CodMoeda := Varia.MoedaBase;
    VpfDTabelaPreco.NomMoeda := FunContasAReceber.RNomMoeda(Varia.MoedaBase);
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.AdicionaProdutoEtiquetado(VpaEtiquetas : TList);
var
  VpfLaco : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfQtdEtiqueta : Integer;
  VpfEtiquetasPedido : TList;
begin
  VpfEtiquetasPedido := TList.create;
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOETIQUETADOCOMPEDIDO '+
                                   ' Where CODFILIAL = 0 AND LANORCAMENTO = 0 AND SEQETIQUETA = 0');
  for VpfLaco := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLaco]);
    VpfQtdEtiqueta := VpfDEtiqueta.QtdOriginalEtiquetas;
    AdicionaSQLAbreTabela(ProProduto,'Select CAD.I_EMP_FIL, CAD.I_LAN_ORC, MOV.I_SEQ_MOV, MOV.N_QTD_PRO, MOV.N_QTD_BAI '+
                              ' from CADORCAMENTOS CAD, MOVORCAMENTOS MOV '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' and CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' and CAD.I_TIP_ORC = '+IntToStr(Varia.TipoCotacaoPedido) +
                              ' and CAD.C_FLA_SIT = ''A'''+
                              ' and CAD.C_IND_CAN = ''N'''+
                              ' AND MOV.N_QTD_PRO > '+SQLTextoIsNull('MOV.N_QTD_BAI','0')+
                              ' AND MOV.I_SEQ_PRO = '+IntToStr(VpfDEtiqueta.Produto.SeqProduto)+
                              ' order by CAD.I_LAN_ORC');
    while not ProProduto.eof and (VpfQtdEtiqueta > 0) do
    begin
      VpfQtdEtiqueta := VpfQtdEtiqueta - (RetornaInteiro(ProProduto.FieldByname('N_QTD_PRO').AsFloat)- RetornaInteiro(ProProduto.FieldByname('N_QTD_BAI').AsFloat));
      ProCadastro.insert;
      if VpfQtdEtiqueta <= 0 then
      begin
        ProCadastro.FieldByname('QTDETIQUETADO').AsInteger := VpfDEtiqueta.QtdOriginalEtiquetas;
        VpfDEtiqueta.NumPedido := ProProduto.FieldByname('I_LAN_ORC').AsInteger;
        VpfDEtiqueta.IndParaEstoque :=false;
        VpfQtdEtiqueta := 0;
      end
      else
      begin
        ProCadastro.FieldByname('QTDETIQUETADO').AsInteger := RetornaInteiro(ProProduto.FieldByname('N_QTD_PRO').AsFloat)- RetornaInteiro(ProProduto.FieldByname('N_QTD_BAI').AsFloat);
        VpfEtiquetasPedido.add(REtiquetaPedido(VpfDEtiqueta,ProProduto.FieldByname('I_LAN_ORC').AsInteger,ProCadastro.FieldByname('QTDETIQUETADO').AsInteger));
      end;

      ProCadastro.FieldByname('CODFILIAL').AsInteger := ProProduto.FieldByname('I_EMP_FIL').AsInteger;
      ProCadastro.FieldByname('LANORCAMENTO').AsInteger := ProProduto.FieldByname('I_LAN_ORC').AsInteger;
      ProCadastro.FieldByname('SEQMOVIMENTO').AsInteger := ProProduto.FieldByname('I_SEQ_MOV').AsInteger;
      ProCadastro.FieldByname('DATIMPRESSAO').AsDateTime := now;
      ProCadastro.FieldByname('SEQETIQUETA').AsInteger := RSeqEtiquetadoDisponivel(ProProduto.FieldByname('I_EMP_FIL').AsInteger,ProProduto.FieldByname('I_LAN_ORC').AsInteger);
      ProCadastro.post;
      if ProCadastro.AErronaGravacao then
        aviso(ProCadastro.AMensagemErroGravacao);

      ProProduto.next;
    end;
  end;

  for VpfLaco := 0 to VpfEtiquetasPedido.Count - 1 do
  begin
    VpaEtiquetas.Add(VpfEtiquetasPedido.Items[VpfLAco]);
  end;

  ProCadastro.close;
  ProProduto.close;
  VpfEtiquetasPedido.free;
end;

{******************************************************************************}
function TFuncoesProduto.InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaDProduto: TRBDProduto;VpaProdutoNovo : Boolean): String;
var
  VpfLaco : Integer;
  VpfDPreco : TRBDProdutoTabelaPreco;
  VpfFiltroFilial : String;
begin
  Result:= '';
  if not VpaProdutoNovo  then
    VpfFiltroFilial :=  'and I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil);

  ExecutaComandoSql(AUX,'Delete from MOVQDADEPRODUTO '+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                        VpfFiltroFilial);
  AdicionaSQLAbreTabela(Tabela,'SELECT I_EMP_FIL '+
                               ' FROM CADFILIAIS '+
                               ' WHERE I_COD_EMP = '+IntTostr(VpaCodEmpresa)+
                               VpfFiltroFilial);
  for VpfLaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLaco]);
    if VpfDPreco.CodCliente = 0 then
    begin
      Tabela.close;
      Tabela.Open;
      while not Tabela.eof do
      begin
        InsereProdutoFilial(VpaDProduto.SeqProduto,Tabela.FieldByName('I_EMP_FIL').AsInteger,VpfDPreco.CodCor,VpfDPreco.CodTamanho, VpfDPreco.QtdEstoque,VpfDPreco.QtdMinima,VpfDPreco.QtdIdeal,VpfDPreco.ValCusto,VpfDPreco.ValCompra, VpfDPreco.DesCodigodeBarra);
        Tabela.next;
      end;
    end;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesProduto.InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaSeqProduto : Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Tabela,'SELECT I_EMP_FIL '+
                               ' FROM CADFILIAIS '+
                               ' WHERE I_COD_EMP = '+IntTostr(VpaCodEmpresa));

  while not Tabela.eof do
  begin
    InsereProdutoFilial(VpaSeqProduto,Tabela.FieldByName('I_EMP_FIL').AsInteger,0,0, 0,0,0,0,0,'');
    Tabela.next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.InserePrecoProdutoCliente(VpaSeqProduto, VpaCodTabela, VpaCodCliente, VpaCodTamanho,VpaCodCor : Integer);
begin
  LocalizaProdutoTabelaPreco(ProCadastro, IntToStr(VpaCodTabela),
                             IntToStr(VpaSeqProduto),IntToStr(VpaCodCliente) );

  if ProCadastro.Eof then
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
    ProCadastro.FieldByName('I_COD_TAB').AsInteger := VpaCodTabela;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaSeqproduto;
    ProCadastro.FieldByName('I_COD_MOE').Value := Varia.MoedaBase;
    ProCadastro.FieldByName('C_CIF_MOE').Value := CurrencyString;
    ProCadastro.FieldByName('I_COD_CLI').AsInteger := VpaCodCliente;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger := VpaCodTamanho;
    ProCadastro.FieldByName('I_COD_COR').AsInteger := VpaCodTamanho;
    ProCadastro.FieldByname('D_Ult_Alt').AsDateTime :=Date;
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.Post;
  end;

  ProCadastro.Close;
end;
{-******************** verifica se produto existe *****************************}
function TFuncoesProduto.ExisteCodigoProduto(Var VpaSeqProduto : Integer; Var VpaCodProduto, VpaNomProduto : String) : Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select pro.I_Seq_Pro, C_Cod_Pro, '+
                            ' Pro.C_Nom_Pro'  +
                            ' from CadProdutos Pro,  '+
                            ' MovQdadeProduto Qtd ' +
                            ' Where C_COD_PRO = ''' + VpaCodProduto +''''+
                            ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                            ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro ');
  result := not Aux.eof;
  if Result then
  begin
    VpaSeqProduto := AUX.FieldByName('I_Seq_Pro').AsInteger;
    VpaCodProduto := AUX.FieldByName('C_Cod_Pro').Asstring;
    VpaNomProduto := Aux.FieldByName('C_Nom_Pro').Asstring;
  end
  else
  begin
    VpaSeqProduto := 0;
    VpaCodProduto := '';
    VpaNomProduto := '';
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCodigoProdutoDuplicado(VpaSeqProduto : Integer;VpaCodProduto : String):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from CADPRODUTOS '+
                           ' Where C_COD_PRO = '''+VpaCodProduto+''''+
                           ' and I_SEQ_PRO <> '+IntToStr(VpaSeqProduto));
  Result := not Aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteNomeProduto(Var VpaSeqProduto : Integer;VpaNomProduto : string):Boolean;
begin
  if VpaNomProduto <> '' then
  begin
    AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from CADPRODUTOS '+
                              ' Where C_NOM_PRO like '''+VpaNomProduto+'''');
    result := not Aux.eof;
    VpaSeqProduto := AUX.FieldByname('I_SEQ_PRO').AsInteger;
    Aux.close;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, PRO.I_ALT_PRO, '+
                                  ' MOV.N_VLR_CUS '+
                                  ' from CADPRODUTOS PRO, MOVQDADEPRODUTO MOV  '+
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDConsumoMP do
      begin
        UMOriginal := ProProduto.FieldByName('C_Cod_Uni').Asstring;
        UM := ProProduto.FieldByName('C_Cod_Uni').Asstring;
        QtdProduto := 1;
        SeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
        AltProduto := ProProduto.FieldByName('I_ALT_PRO').AsInteger;
        ValorUnitario := ProProduto.FieldByName('N_VLR_CUS').AsFloat;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : String;var VpaSeqProduto : Integer;var VpaNomProduto, VpaUM : String):boolean;
begin
  result := false;
  VpaSeqProduto := 0;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where C_COD_PRO  = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      VpaNomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaUM := ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaSeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaSeqProduto : Integer;Var VpaCodProduto, VpaNomProduto : String):Boolean;
begin
  result := false;
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, PRO.C_COD_PRO, '+
                                  ' PRO.C_NOM_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));

    result := not ProProduto.Eof;
    if result then
    begin
      VpaCodProduto := ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaNomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; VpaDProAmostra: TRBDConsumoAmostra): Boolean;
begin
  result:= false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                     ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, I_ALT_PRO, '+
                                     ' QTD.N_VLR_CUS,  '+
                                     ' CLA.N_PER_PER '+
                                     ' from CADPRODUTOS PRO, MOVQDADEPRODUTO QTD, CADCLASSIFICACAO CLA '+
                                     ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                     ' AND PRO.I_SEQ_PRO = QTD.I_SEQ_PRO '+
                                     ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                                     ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                                     ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDProAmostra do
      begin
        DesUM := ProProduto.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := DesUM;
        QtdProduto := 1;
        SeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
        ValUnitario:= ProProduto.FieldByName('N_VLR_CUS').AsFloat;
        AltProduto := ProProduto.FieldByName('I_ALT_PRO').AsInteger;
        PerAcrescimoPerda := ProProduto.FieldByName('N_PER_PER').AsFloat;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT * FROM CADPRODUTOS'+
                                     ' WHERE C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : String;VpaDProdutoPedido: TRBDProdutoPedidoCompra): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, PRO.N_PER_IPI, '+
                                     ' PRO.L_DES_TEC, PRO.N_DEN_VOL, PRO.N_ESP_ACO, PRO.C_CLA_FIS, '+
                                     ' QTD.N_VLR_COM '+
                                     ' FROM CADPRODUTOS PRO, MOVQDADEPRODUTO QTD'+
                                     ' WHERE QTD.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                                     ' AND PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDProdutoPedido.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDProdutoPedido.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDProdutoPedido.DesUM:= RUMMTCMBR(ProProduto.FieldByName('C_COD_UNI').AsString);

      VpaDProdutoPedido.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDProdutoPedido.DesTecnica := ProProduto.FieldByName('L_DES_TEC').AsString;
      VpaDProdutoPedido.ValUnitario:= ProProduto.FieldByName('N_VLR_COM').AsFloat;
      VpaDProdutoPedido.PerIPI := ProProduto.FieldByName('N_PER_IPI').AsFloat;
      VpaDProdutoPedido.DensidadeVolumetricaAco := ProProduto.FieldByName('N_DEN_VOL').AsFloat;
      VpaDProdutoPedido.EspessuraAco := ProProduto.FieldByName('N_ESP_ACO').AsFloat;
      VpaDProdutoPedido.CodClassificacaoFiscal := ProProduto.FieldByName('C_CLA_FIS').AsString;

      VpaDProdutoPedido.UnidadesParentes.Free;
      VpaDProdutoPedido.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProdutoPedido.DesUM);
      VpaDProdutoPedido.QtdProduto:= 1;
      VpaDProdutoPedido.CodCor:= 0;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDSolicitacaoCompraItem): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    ProProduto.Close;
    ProProduto.sql.clear;
    AdicionaSQLTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, '+
                                     ' PRO.C_COD_CLA, PRO.N_ESP_ACO, PRO.N_DEN_VOL '+
                                     ' FROM CADPRODUTOS PRO, CADCLASSIFICACAO CLA'+
                                     ' WHERE PRO.C_COD_PRO = '''+VpaCodProduto+''''+
                                     ' and CLA.I_COD_EMP = PRO.I_COD_EMP '+
                                     ' AND CLA.C_COD_CLA = PRO.C_COD_CLA '+
                                     ' AND CLA.C_TIP_CLA = PRO.C_TIP_CLA ');
    if (puESSomenteSolicitacaodeComprasdeInsumos in Varia.PermissoesUsuario) then
      AdicionaSQLTabela(ProProduto,'and CLA.C_IND_INS = ''S''');
    ProProduto.Open;
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDOrcamentoItem.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDOrcamentoItem.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDOrcamentoItem.CodClassificacao := ProProduto.FieldByName('C_COD_CLA').AsString;
      VpaDOrcamentoItem.UMOriginal := ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDOrcamentoItem.DesUM:= ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDOrcamentoItem.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDOrcamentoItem.DensidadeVolumetricaAco := ProProduto.FieldByName('N_DEN_VOL').AsFloat;
      VpaDOrcamentoItem.EspessuraAco := ProProduto.FieldByName('N_ESP_ACO').AsFloat;

      VpaDOrcamentoItem.UnidadesParentes.Free;
      VpaDOrcamentoItem.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDOrcamentoItem.DesUM);
      VpaDOrcamentoItem.QtdProduto:= 1;
      VpaDOrcamentoItem.CodCor:= 0;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDOrcamentoCompraProduto): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, PRO.L_DES_TEC,  '+
                                     ' PRO.N_ESP_ACO, PRO.N_DEN_VOL ' +
                                     ' FROM CADPRODUTOS PRO'+
                                     ' WHERE PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDOrcamentoItem.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDOrcamentoItem.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDOrcamentoItem.DesUM:= RUMMTCMBR(ProProduto.FieldByName('C_COD_UNI').AsString);
      VpaDOrcamentoItem.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDOrcamentoItem.DesTecnica:= ProProduto.FieldByName('L_DES_TEC').AsString;
      VpaDOrcamentoItem.EspessuraAco := ProProduto.FieldByName('N_ESP_ACO').AsFloat;
      VpaDOrcamentoItem.DensidadeVolumetricaAco := ProProduto.FieldByName('N_DEN_VOL').AsFloat;

      VpaDOrcamentoItem.UnidadesParentes.Free;
      VpaDOrcamentoItem.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDOrcamentoItem.DesUM);
      VpaDOrcamentoItem.QtdSolicitada:= 1;
      VpaDOrcamentoItem.QtdProduto:= 1;
      VpaDOrcamentoItem.CodCor:= 0;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : string; VpaDProdutoOrcado : TRBDChamadoProdutoOrcado):Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO,  '+
                                     ' PRE.N_VLR_VEN '+
                                     ' FROM CADPRODUTOS PRO, MOVTABELAPRECO PRE'+
                                     ' WHERE PRE.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                                     ' AND PRE.I_COD_TAB = '+ IntToStr(Varia.TabelaPreco)+
                                     ' and PRE.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                     ' AND PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDProdutoOrcado.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDProdutoOrcado.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDProdutoOrcado.DesUM:= ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDProdutoOrcado.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDProdutoOrcado.ValUnitario := ProProduto.FieldByName('N_VLR_VEN').AsFloat;

      VpaDProdutoOrcado.UnidadesParentes.Free;
      VpaDProdutoOrcado.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProdutoOrcado.DesUM);
      VpaDProdutoOrcado.Quantidade:= 1;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; var VpaSeqProduto: Integer;var VpaNomProduto: String): boolean;
begin
  result := false;
  VpaSeqProduto := 0;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', PRO.C_NOM_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where C_COD_PRO  = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      VpaNomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaSeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; var VpaSeqProduto: Integer; var VpaNomProduto: String;  var VpaDensidadeVolumetrica, VpaEspessuraChapa: Double): boolean;
begin
  result := false;
  VpaSeqProduto := 0;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ' , PRO.C_NOM_PRO, PRO.N_DEN_VOL, PRO.N_ESP_ACO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where C_COD_PRO  = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      VpaNomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaSeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDensidadeVolumetrica := ProProduto.FieldByName('N_DEN_VOL').AsFloat;
      VpaEspessuraChapa := ProProduto.FieldByName('N_ESP_ACO').AsFloat;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; VpaDProEspecialAmostra: TRBDItensEspeciaisAmostra): Boolean;
begin
  result:= false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                     ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, I_ALT_PRO, '+
                                     ' QTD.N_VLR_CUS,  '+
                                     ' CLA.N_PER_PER '+
                                     ' from CADPRODUTOS PRO, MOVQDADEPRODUTO QTD, CADCLASSIFICACAO CLA '+
                                     ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                     ' AND PRO.I_SEQ_PRO = QTD.I_SEQ_PRO '+
                                     ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                                     ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                                     ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDProEspecialAmostra do
      begin
        SeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
        ValProduto:= ProProduto.FieldByName('N_VLR_CUS').AsFloat;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteEntretela(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, PRO.I_ALT_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDConsumoMP do
      begin
        QtdEntretela := 1;
        SeqProdutoEntretela := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProdutoEntretela := ProProduto.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteTermoColante(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, PRO.I_ALT_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDConsumoMP do
      begin
        QtdTermoColante := 1;
        SeqProdutoTermoColante := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProdutoTermoColante := ProProduto.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExportaProdutosParaServicos: String;
var
  VpfLaco: Integer;
begin
  VpfLaco:= 179;
  result := '';
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_PRO from CADPRODUTOS '+
                                    'Where C_COD_CLA = ''1117''');
  while not aux.Eof do
  begin
      AdicionaSQLAbreTabela(ProCadastro,'Select * from CADSERVICO '+
                                'Where C_COD_CLA = ''1''');
      ProCadastro.Insert;
      ProCadastro.FieldByName('I_COD_SER').AsInteger:= VpfLaco + 1;
      ProCadastro.FieldByName('C_NOM_SER').AsString:= 'REC. - ' + Aux.FieldByName('C_NOM_PRO').AsString;
      ProCadastro.FieldByName('I_COD_EMP').AsInteger:= 1;
      ProCadastro.FieldByName('C_COD_CLA').AsString:= '1';
      ProCadastro.FieldByName('C_TIP_CLA').AsString:= 'S';
      ProCadastro.FieldByName('C_ATI_SER').AsString:= 'S';
      ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= now;
      ProCadastro.FieldByName('I_COD_FIS').AsInteger:= 1401;
      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
      if result <> '' then
        break;
      aux.Next;
      VpfLaco:= VpfLaco+1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExportaProdutosParaServicosTabelaPreco: String;
var
  VpfLaco: Integer;
begin
  VpfLaco:= 0;
  result := '';
  AdicionaSQLAbreTabela(Aux,'Select * from CADSERVICO ');
//                                    'Where C_COD_CLA = ''1117''');
  while not aux.Eof do
  begin
      AdicionaSQLAbreTabela(ProCadastro,'Select * from MovTabelaPrecoServico ');
//                                'Where C_COD_CLA = ''1''');
      ProCadastro.Insert;
      ProCadastro.FieldByName('I_COD_EMP').AsInteger:= 1;
      ProCadastro.FieldByName('I_COD_TAB').AsInteger:= 1101;
      ProCadastro.FieldByName('I_COD_SER').AsInteger:= Aux.FieldByName('I_COD_SER').AsInteger;
      ProCadastro.FieldByName('I_COD_MOE').AsInteger:= 1101;
      ProCadastro.FieldByName('N_VLR_VEN').AsFloat:= RPrecoVenda(Aux.FieldByName('C_NOM_SER').AsString);
      ProCadastro.FieldByName('C_CIF_MOE').AsString:= 'R$';
      ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= now;
      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
      if result <> '' then
        break;
      aux.Next;
      VpfLaco:= VpfLaco+1;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.FiguraGRFDuplicada(VpaFiguras: TList): Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDFiguraInterna, VpfDFiguraExterna : TRBDFiguraGRF;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaFiguras.Count - 2 do
  begin
    VpfDFiguraExterna := TRBDFiguraGRF(VpaFiguras.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaFiguras.Count - 1 do
    begin
      VpfDFiguraInterna := TRBDFiguraGRF(VpaFiguras.Items[VpfLacoInterno]);
      if VpfDFiguraInterna.CodFiguraGRF = VpfDFiguraExterna.CodFiguraGRF then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCombinacao(VpaSeqProduto, VpaCodCombinacao : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select * from COMBINACAO '+
                            ' Where SEQPRO = '+IntToStr(VpaSeqProduto)+
                            ' and CODCOM = ' +IntToStr(VpaCodCombinacao));
  result := not Aux.eof;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCor(VpaCodCor : String) : Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                            ' Where COD_COR = '+VpaCodCor);
  result := not Aux.eof;
  AUX.close;
end;

{************* ************************************************ ************ }
procedure TFuncoesProduto.OrdenaTabelaPrecoProduto(VpaDProduto: TRBDProduto);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDPrecoInterno, VpfDPrecoExterno : TRBDProdutoTabelaPreco;
begin
  for VpfLacoExterno := 0 to VpaDProduto.TabelaPreco.Count - 2 do
  begin
    VpfDPrecoExterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDProduto.TabelaPreco.Count - 1 do
    begin
      VpfDPrecoInterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoInterno]);
      if (VpfDPrecoInterno.CodCor <  VpfDPrecoExterno.CodCor)or
        ((VpfDPrecoInterno.CodCor =  VpfDPrecoExterno.CodCor)and
         (VpfDPrecoInterno.CodTamanho < VpfDPrecoExterno.CodTamanho)) then
      begin
        VpaDProduto.TabelaPreco.Items[VpfLacoExterno] := VpaDProduto.TabelaPreco.Items[VpfLacoInterno];
        VpaDProduto.TabelaPreco.Items[VpfLacoInterno] := VpfDPrecoExterno;
        VpfDPrecoExterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{************* adiciona os produtos faltantes na tabela de preco ************ }
procedure TFuncoesProduto.OrganizaTabelaPreco(VpaCodTabela, VpaCodCliente : integer; VpaSomenteAtividade : Boolean );
begin
  LocalizaProdutoEmpresa( calcula );

  while not calcula.Eof do
  begin
    LocalizaProdutoTabelaPreco( ProCadastro, IntToStr(VpaCodTabela),
                                calcula.FieldByName('I_SEQ_PRO').AsString,IntToStr(VpaCodCliente) );

    if ProCadastro.eof then
    begin
      if (calcula.FieldByName('C_ATI_PRO').AsString = 'S') or (VpaSomenteAtividade) then
      begin
        ProCadastro.Insert;
        ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
        ProCadastro.FieldByName('I_COD_TAB').AsInteger := VpaCodTabela;
        ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := calcula.fieldByName('I_SEQ_PRO').AsInteger;
        ProCadastro.FieldByName('N_PER_MAX').AsFloat := calcula.fieldByName('N_PER_MAX').AsFloat;
        ProCadastro.FieldByName('I_COD_MOE').Value := Varia.MoedaBase;
        ProCadastro.FieldByName('C_CIF_MOE').Value := CurrencyString;
        ProCadastro.FieldByName('I_COD_CLI').AsInteger := VpaCodCliente;
        ProCadastro.FieldByname('D_Ult_Alt').AsDateTime :=Date;
        ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
        ProCadastro.post;
      end;
    end;
    calcula.next;
    ProCadastro.close;
  end;
end;

{************ atualiza o valor do kit conforme o preco dos seus produtos ***** }
procedure TFuncoesProduto.AtualizaValorKit( SeqProdutoKit, CodTabelaPreco : integer );
begin
  LimpaSQLTabela(tabela);
  AdicionaSQLTabela(tabela, ' update MovTabelaPreco ' +
                    ' set n_vlr_ven =  ( select sum((n_vlr_ven * (1 - (isnull(pro.n_per_kit,0) / 100)))* kit.n_qtd_pro) ' +
                                       ' from movkit  kit, MovTabelaPreco tab, cadprodutos  pro  ' +
                                       ' where i_pro_kit =  ' + IntToStr( SeqProdutoKit ) +
                                       ' and tab.i_cod_tab = ' + IntToStr(CodTabelaPreco)  +
                                       ' and tab.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa)  +
                                       ' and tab.i_cod_cli = 0 '+
                                       ' and kit.i_seq_pro = tab.i_seq_pro ' +
                                       ' and kit.i_seq_pro = pro.i_seq_pro ' +
                                       ' and pro.i_cod_emp = ' + IntToStr(varia.codigoEmpresa) + ' ), ' +
                    ' d_ult_alt = ' + SQLTextoDataAAAAMMMDD(Date) +
                    ' where i_seq_pro = ' + IntToStr( SeqProdutoKit ) +
                    ' and i_cod_tab = ' + IntToStr(CodTabelaPreco)  +
                    ' and i_cod_emp = ' + IntToStr(varia.CodigoEmpresa)+
                    ' and I_COD_CLI = 0');
  tabela.ExecSQL;
end;

{****************** valida a alteracao do valor unitario ********************* }
function TFuncoesProduto.ValidaAlterarValorUnitario( CorForm, CorCaixa : TColor ) : boolean;
var
  senha : string;
begin
  result := true;
  if  config.AlterarValorUnitarioComSenha then
     if Entrada( 'Digite senha', 'Digite a senha de permissão', senha,true, CorCaixa, CorForm) then  // senha de permissao para liberar o desconto
      begin
         if varia.SenhaLiberacao <> senha then     // verifica a senha de autorizacao....
         begin
           aviso(CT_SenhaInvalida);
           result := false;
         end;
      end
      else
        result := false;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCor(VpaCodCor : String;VpaDConcumoMP : TRBDConsumoMP) : Boolean;
begin
  VpaDConcumoMP.NomProduto := '';
  AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                            ' Where COD_COR = '+VpaCodCor);
  result := not Aux.eof;
  if result then
  begin
    VpaDConcumoMP.NomCor := Aux.FieldByName('NOM_COR').AsString;
  end;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.Existecor(VpaCodCor : String;var VpaNomCor : String):Boolean;
begin
  VpaNomCor := '';
  AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                            ' Where COD_COR = '+VpaCodCor);
  result := not Aux.eof;
  if result then
  begin
    VpaNomCor := Aux.FieldByName('NOM_COR').AsString;
  end;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteEstagio(VpaCodEstagio : String;Var VpaNomEstagio :string): Boolean;
begin
  AdicionaSQlAbreTabela(AUX,'Select * from ESTAGIOPRODUCAO '+
                            ' Where CODEST = '+ VpaCodEstagio);
  result := not aux.eof;
  if result then
    VpaNomEstagio := Aux.FieldByName('NOMEST').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteEstoqueCor(VpaSeqProduto, VpaCodCor : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(AUX,'Select MOV.N_QTD_PRO, PRO.C_COD_UNI from MOVQDADEPRODUTO MOV, CADPRODUTOS PRO '+
                            ' Where MOV.I_EMP_FIL = '+ IntToStr(Varia.CodigoEmpFil)+
                            ' and MOV.I_SEQ_PRO = '+ IntToStr(VpaSeqProduto)+
                            ' and MOV.I_COD_COR = '+ IntToStr(VpaCodCor)+
                            ' and PRO.I_SEQ_PRO = MOV.I_SEQ_PRO ');
  if  not Aux.Eof then
  begin
    if Aux.FieldByName('N_QTD_PRO').AsFloat > 0 then
    begin
      result := 'COMBINAÇÃO POSSUI ESTOQUE!!!'#13'A combinação digitada possui "'+FormatFloat(varia.mascaraqtd,AUX.FieldByName('N_QTD_PRO').AsFloat)+ '" '+ AUX.FieldByName('C_COD_UNI').AsString +' em estoque.';
    end;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProdutosDevolvidos(VpaCodCliente : String):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select * from CADNOTAFISCAISFOR '+
                            ' Where I_COD_CLI = '+ VpaCodCliente+
                            ' and I_EMP_FIL = '+IntToStr(varia.CodigoFilial));
  result := not aux.eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteSeqChapaDuplicado(VpaSeqProduto, VpaSeqChapa: Integer): string;
begin
  result := '';
  AdicionaSqlAbreTabela(AUX,'Select PRO.C_COD_PRO, PRO.C_NOM_PRO ' +
                            ' FROM CADPRODUTOS PRO, ESTOQUECHAPA CHA ' +
                            ' WHERE PRO.I_SEQ_PRO = CHA.SEQPRODUTO ' +
                            ' AND CHA.SEQPRODUTO <> '+IntToStr(VpaSeqProduto)+
                            ' AND CHA.SEQCHAPA = '+IntToStr(VpaSeqChapa));
  if not AUX.Eof then
    result := 'ID CHAPA DUPLICADO!!!'#13'Já existe uma chapa cadastrado com esse ID para o produto "'+AUX.FieldByName('C_COD_PRO').AsString+'-'+AUX.FieldByName('C_NOM_PRO').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteSeqChapaDuplicadoClasse(VpaChapas: TList): boolean;
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDChapaExterno, VpfDChapaInterno : TRBDEStoqueChapa;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaChapas.Count - 2 do
  begin
    VpfDChapaExterno := TRBDEStoqueChapa(VpaChapas.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno +1 to VpaChapas.Count - 1 do
    begin
      VpfDChapaInterno := TRBDEStoqueChapa(VpaChapas.Items[VpfLacoInterno]);
      if VpfDChapaExterno.SeqChapa = VpfDChapaInterno.SeqChapa then
      begin
        result := true;
        break;
      end;
    end;
    if result then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteDonoProduto(VpaCodDono : Integer):Boolean;
begin
  AdicionaSqlAbreTabela(Aux,'Select * from DONOPRODUTO '+
                            ' Where CODDONO = '+inttoStr(VpaCodDono));
  result := not aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteFaca(VpaCodFaca : Integer; VpaDFaca : TRBDFaca):Boolean;
begin
  AdicionaSqlAbreTabela(Tabela2,'Select CODFACA, NOMFACA, ALTFACA, LARFACA, QTDPROVA from FACA '+
                                ' Where CODFACA = '+inttoStr(VpaCodFaca));
  result := not Tabela2.eof;
  if result then
  begin
    VpaDFaca.CodFaca := Tabela2.FieldByname('CODFACA').AsInteger;
    if config.ConverterMTeCMparaMM then
      VpaDFaca.LarFaca := Tabela2.FieldByname('LARFACA').AsFloat/10
    else
      VpaDFaca.LarFaca := Tabela2.FieldByname('LARFACA').AsFloat;
    if config.ConverterMTeCMparaMM then
      VpaDFaca.AltFaca := Tabela2.FieldByname('ALTFACA').AsFloat/10
    else
      VpaDFaca.AltFaca := Tabela2.FieldByname('ALTFACA').AsFloat;
    VpaDFaca.QtdProvas := Tabela2.FieldByname('QTDPROVA').AsInteger;
    VpaDFaca.NomFaca := Tabela2.FieldByname('NOMFACA').AsString;
  end;
  Tabela2.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteMaquina(VpaCodMaquina : Integer;VpaDMaquina : TRBDMaquina):Boolean;
begin
  AdicionaSQLAbreTabela(Tabela2,'Select CODMAQ, NOMMAQ, ALTBOC, LARBOC '+
                               ' from MAQUINA '+
                               ' Where CODMAQ = '+IntToStr(VpaCodMaquina));
  result := not Tabela2.Eof;
  if result then
  begin
    VpaDMaquina.CodMaquina := VpaCodMaquina;
    VpaDMaquina.NomMaquina := Tabela2.FieldByname('NOMMAQ').AsString;
    VpaDMaquina.AltBoca := Tabela2.FieldByname('ALTBOC').AsInteger;
    VpaDMaquina.LarBoca := Tabela2.FieldByname('LARBOC').AsInteger;
  end;
  Tabela2.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteConsumo(VpaSeqProduto : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from MOVKIT  '+
                            ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto));
  result := not Aux.eof;
  Aux.close;
end;

function TFuncoesProduto.ExisteConsumoProdutoCor(VpaSeqProduto, VpaCodCor : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from MOVKIT  '+
                            ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto)+
                            ' and I_COR_KIT = '+IntToStr(VpaCodCor));
  result := not Aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteBastidor(VpaCodBastidor : Integer;VpaDBastidor : TRBDBastidor):boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(AUX,'Select * from BASTIDOR '+
                            ' Where CODBASTIDOR = '+InttoStr(VpaCodBastidor));
  result := not Aux.eof;
  if result then
  begin
    VpaDBastidor.CodBastidor := VpaCodBastidor;
    VpaDBastidor.NomBastidor := AUX.FieldByName('NOMBASTIDOR').AsString;
    VpaDBastidor.LarBastidor := Aux.FieldByName('LARBASTIDOR').AsFloat;
    VpaDBastidor.AltBastidor := AUX.FieldByName('ALTBASTIDOR').AsFloat;
  end;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteBastidor(VpaCodBastidor : String;Var VpaNomBastidor : String):boolean;
begin
  result := false;
  if VpaCodBastidor <> '' then
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from BASTIDOR '+
                              ' Where CODBASTIDOR = '+VpaCodBastidor);
    result := not Aux.eof;
    VpaNomBastidor := AUX.FieldByname('NOMBASTIDOR').AsString;
    AUX.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteBastidorDuplicado(VpaDConsumo : TRBDConsumoMP):Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDBastidorInterno, vpfDBastidorExterno : TRBDConsumoMPBastidor;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDConsumo.Bastidores.Count - 2 do
  begin
    vpfDBastidorExterno := TRBDConsumoMPBastidor(VpaDConsumo.Bastidores.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDConsumo.Bastidores.Count - 1 do
    begin
      VpfDBastidorInterno := TRBDConsumoMPBastidor(VpaDConsumo.Bastidores.Items[VpfLacoInterno]);
      if VpfDBastidorInterno.CodBastidor = vpfDBastidorExterno.CodBastidor then
      begin
        Result := true;
        break;
      end;
    end;
    if result then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteAcessorioDuplicado(VpaDProduto : TRBDProduto) : Boolean;
var
  VpfDAcessorioExterno, VpfDAcessorioInterno : TRBDProdutoAcessorio;
  VpfLacoExterno, VpfLacoInterno : Integer;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDProduto.Acessorios.Count -2 do
  begin
    VpfDAcessorioExterno := TRBDProdutoAcessorio(VpaDProduto.Acessorios.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno +1 to VpaDProduto.Acessorios.Count - 1 do
    begin
      VpfDAcessorioInterno := TRBDProdutoAcessorio(VpaDProduto.Acessorios.Items[VpfLacoInterno]);
      if VpfDAcessorioExterno.CodAcessorio = VpfDAcessorioInterno.CodAcessorio then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{*************** valida Desconto somente com senha *************************** }
function TFuncoesProduto.ExisteTabelaPrecoDuplicado(VpaDProduto : TRBDProduto) : Boolean;
var
  VpfDTabelaPrecoExterno, VpfDTabelaPrecoInterno : TRBDProdutoTabelaPreco;
  VpfLacoExterno, VpfLacoInterno : Integer;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDProduto.TabelaPreco.Count -2 do
  begin
    VpfDTabelaPrecoExterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno +1 to VpaDProduto.TabelaPreco.Count - 1 do
    begin
      VpfDTabelaPrecoInterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoInterno]);
      if (VpfDTabelaPrecoExterno.CodTabelaPreco = VpfDTabelaPrecoInterno.CodTabelaPreco) and
         (VpfDTabelaPrecoExterno.CodTamanho = VpfDTabelaPrecoInterno.CodTamanho)and
         (VpfDTabelaPrecoExterno.CodCliente = VpfDTabelaPrecoInterno.CodCliente) and
         (VpfDTabelaPrecoExterno.CodMoeda = VpfDTabelaPrecoInterno.CodMoeda)and
         (VpfDTabelaPrecoExterno.CodCor = VpfDTabelaPrecoInterno.CodCor) then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{*************** valida Desconto somente com senha *************************** }
function TFuncoesProduto.ValidaDesconto( ValorProdutos, Desconto : double; percentual : Boolean; CorForm, CorCaixa : TColor ) : boolean;
var
  senha : string;
begin
  result := true;
  if ValorProdutos = 0 then
    exit;
  if not percentual then
    Desconto :=  (Desconto / ValorProdutos) * 100; // verifica o desconto concedido

   if Desconto > varia.DescontoMaximoNota  then  // se o desconto for maior
   begin
    case varia.MaiorDescontoPermitido of
    2 : begin
           if ConfirmacaoFormato(CT_DescontoInvalido, [FormatFloat(varia.mascaraMoeda, (varia.DescontoMaximoNota / 100) * ValorProdutos)] ) then  // mensagem de desconto maior
               result := false
            else
                if Entrada( 'Digite senha', 'Digite a senha de permissão', senha,true, CorCaixa, CorForm) then  // senha de permissao para liberar o desconto
                begin
                   if varia.SenhaLiberacao <> senha then     // verifica a senha de autorizacao....
                   begin
                     aviso('permissao negada');
                     result := false;
                   end
                end
                else
                  result := false;
        end;
    3 : begin
          avisoFormato(CT_DescontoInvalido, [FormatFloat(varia.mascaraMoeda, (varia.DescontoMaximoNota / 100) * ValorProdutos)] );
          result := false;
        end;
    end;
  end;
end;

{****************** coloca o produto em ativadade ******************************}
function TFuncoesProduto.ColocaProdutoEmAtividade(VpaSequencial : String):string;
begin
  AdicionaSQLAbreTabela(ProCadastro,'Select * from CadProdutos ' +
                        ' Where I_Seq_Pro = ' + VpaSequencial);
  ProCadastro.Edit;
  ProCadastro.FieldByName('C_ATI_PRO').AsString := 'S';
  ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
end;

{******************** tira o produto de atividade *****************************}
procedure TFuncoesProduto.TiraProdutoAtividade(VpaSequencial : String);
begin
  ExecutaComandoSql(aux,'Update CadProdutos ' +
                        ' set C_Ati_Pro = ''N''' +
                        ' Where I_Seq_Pro = ' + VpaSequencial);
end;

{******************* carrega o valor de custo do produto **********************}
function TFuncoesProduto.CQtdValorCusto(VpaCodFilial, VpaSeqProduto, VpaCodCor, VpaCodTamanho :Integer; Var VpaQtdProduto, VpaValCusto : Double):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_VLR_CUS,N_QTD_PRO from MOVQDADEPRODUTO '+
                            ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and I_COD_COR = '+ IntToStr(VpaCodCor)+
                            ' and I_COD_TAM = '+IntToStr(VpaCodTamanho));
  result := not Aux.Eof;
  VpaValCusto := AUX.FieldByname('N_VLR_CUS').AsFloat;
  VpaQtdProduto := AUX.FieldByname('N_QTD_PRO').AsFloat;
  Aux.close;
end;

{*********** retorna o valor do frete rateado pela media ponderada ************}
function TFuncoesProduto.RFreteRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaTotFrete : Double) : Double;
var
  VpfPerCompra : Double;
begin
  result := 0;
  if VpaTotFrete >0 then
  begin
    VpfPerCompra := ((VpaVlrCompra * VpaQtdComprado) * 100) / VpaTotCompra;
    Result := (VpaTotFrete * VpfPerCompra) / 100;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RDescontoRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaValDesconto : Double) : Double;
var
  VpfPerCompra : Double;
begin
  result := 0;
  if VpaValDesconto <>0 then
  begin
    VpfPerCompra := ((VpaVlrCompra * VpaQtdComprado) * 100) / (VpaTotCompra + VpaValDesconto);
    Result := (VpaValDesconto * VpfPerCompra) / 100;
    result := result /VpaQtdComprado;
  end;
end;

{***************** retorna a funcao da operacao de estoque ********************}
function TFuncoesProduto.RFuncaoOperacaoEstoque(VpaCodOperacao : String):String;
begin
  AdicionaSQLAbreTabela(AUX,'Select C_FUN_OPE from CADOPERACAOESTOQUE '+
                            ' where I_COD_OPE = '+ VpaCodOperacao);
  if Aux.Eof then
    result := ''
  else
    result := Aux.FieldByName('C_FUN_OPE').AsString;
  Aux.close;
end;

{******************** retorna o icms do estado ********************************}
function TFuncoesProduto.RIcmsEstado(VpaEstado:String):Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select N_ICM_INT FROM CADICMSESTADOS ' +
                            ' Where C_COD_EST = '''+ VpaEstado + '''');
  result := Aux.FieldByname('N_ICM_INT').AsFloat;
end;

function TFuncoesProduto.RImpEmbalagemPvc(
  VpaImpEmbalagemPvc: integer): TRBDImpEmbalagemPvc;
begin
  case VpaImpEmbalagemPvc of
    0 : result := ieEmBranco;
    1 : result := ieNao;
    2 : result := ie1;
    3 : result := ie2;
    4 : Result := ie3;
    5 : Result := ie4;
    6 : Result := ie5;
    7 : result := ie6;
    8 : result := ie7;
    9 : result := ie8;
  end;
end;


{****************** retorna o valor de custo do produto ***********************}
function TFuncoesProduto.RValCustoTear(VpaDProduto: TRBDProduto): Double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Tabela,'Select * from PRECOLARGURATEAR '+
                               ' Where NUMLARGURA >= '+IntToStr(VpaDProduto.LarProduto)+
                               ' ORDER BY NUMLARGURA');
  if VpaDProduto.TipoCadarco = tcConvencional then
  begin
    result := Tabela.FieldByName('VALCONVENCIONAL').AsFloat;
    if VpaDProduto.NumBatidasTear <> '' then
    begin
      if StrToInt(VpaDProduto.NumBatidasTear) <> 11 then
        result := (StrToInt(VpaDProduto.NumBatidasTear)* result)/11;
    end;
  end
  else
  begin
    case VpaDProduto.TipoCadarco of
      tcCroche,tcElastico : result := Tabela.FieldByName('VALCROCHE').AsFloat;
      tcRenda : result := Tabela.FieldByName('VALCROCHE').AsFloat * 2;
    end;

  end;
end;

{******************************************************************************}
function TFuncoesProduto.RValMateriaPrimaCadarco(VpaDProduto: TRBDProduto): Double;
var
  VpfLaco : Integer;
  VpfDFio : TRBDProdutoFioOrcamentoCadarco;
begin
  for VpfLaco := 0 to VpaDProduto.FiosOrcamentoCadarco.Count - 1 do
  begin
    VpfDFio := TRBDProdutoFioOrcamentoCadarco(VpaDProduto.FiosOrcamentoCadarco.Items[VpfLaco]);
    if VpfDFio.IndSelecionado then
    begin
      result := result + (VpfDFio.PesFio * VpfDFio.ValCustoFio);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RValorCompra(VpaCodEmpFil, VpaSeqProduto,VpaCodCor: Integer): Double;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_VLR_COM from MOVQDADEPRODUTO'+
                            ' WHERE I_EMP_FIL = '+ IntToStr(VpaCodEmpFil) +
                            ' AND I_SEQ_PRO =  ' + IntToStr(VpaSeqProduto)+
                            ' AND I_COD_COR = ' +IntToStr(VpaCodCor)+
                            ' order by I_COD_TAM' );
  Result := Aux.FieldByName('N_VLR_COM').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RValorCusto(VpaCodEmpFil, VpaSeqProduto, VpaCodCor,VpaCodTamanho: Integer): Double;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_VLR_CUS from MOVQDADEPRODUTO'+
                            ' WHERE I_EMP_FIL = '+ IntToStr(VpaCodEmpFil) +
                            ' AND I_SEQ_PRO =  ' + IntToStr(VpaSeqProduto)+
                            ' AND I_COD_COR = ' +IntToStr(VpaCodCor)+
                            ' AND I_COD_TAM = ' +IntToStr(VpaCodTamanho)+
                            ' order by I_COD_COR, I_COD_TAM' );
  Result := Aux.FieldByName('N_VLR_CUS').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RValorCusto(VpaCodEmpFil, VpaSeqProduto: Integer):Double;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_VLR_CUS from MOVQDADEPRODUTO'+
                            ' WHERE I_EMP_FIL = '+ IntToStr(VpaCodEmpFil) +
                            ' AND I_SEQ_PRO =  ' + IntToStr(VpaSeqProduto)+
                            ' order by I_COD_COR, I_COD_TAM' );
  Result := Aux.FieldByName('N_VLR_CUS').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RValVendaTamanhoeCor(VpaSeqProduto, VpaCodCor,VpaCodTamanho, VpaCodCliente: Integer;Var ValPrecoTabela : Double): Double;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_COD_CLI, N_VLR_VEN FROM MOVTABELAPRECO '+
                           ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                           ' AND I_COD_TAB = '+IntToStr(VARIA.TabelaPreco)+
                           ' AND I_COD_CLI in (0, ' +IntToStr(VpaCodCliente)+')'+
                           ' AND I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                           ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho)+
                           ' AND I_COD_COR = ' + IntToStr(VpaCodCor)+
                           ' order by I_COD_CLI DESC');
  result := AUX.FieldByName('N_VLR_VEN').AsFloat;
  while not AUX.Eof do
  begin
    if AUX.FieldByName('I_COD_CLI').AsInteger = 0 then
      ValPrecoTabela := AUX.FieldByName('N_VLR_VEN').AsFloat;
    aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RViesEmbalagemPvc(
  VpaViesEmbalagem: integer): TRBDViesEmbalagemPvc;
begin
  case VpaViesEmbalagem of
    0 : result := veEmBranco;
    1 : result := vePvcTran;
    2 : result := vePvcCol;
    3 : result := veViesTn;
    4 : result := veViesAl;
    5 : result := veViesLi;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RZiperEmbalagemPvc(
  VpaZiperEmbalagem: integer): TRBDZiperEmbalagemPvc;
begin
  case VpaZiperEmbalagem of
    0 : result := zeEmBranco;
    1 : result := zeNao;
    2 : result := zeNylon3;
    3 : result := zeNylon6;
    4 : result := zePvc;
    5 : result := zeZiper;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeFundo(VpaCodFundo : String):String;
begin
  result := '';
  if VpaCodFundo <> '' then;
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from CADTIPOFUNDO '+
                              ' Where I_COD_FUN = '+ VpaCodFundo);
    result := AUX.FieldByName('C_NOM_FUN').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeTipoEmenda(VpaCodEmenda : String):String;
begin
  result := '';
  if VpaCodEmenda <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select NOMEME from TIPOEMENDA '+
                              ' Where CODEME = '+ VpaCodEmenda);
    result := Aux.FieldByName('NOMEME').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdPecaemMetro(VpaAltProduto, VpaLarProduto, VpaQtdProvas : Integer;VpaAltMolde, VpaLarMolde : double;VpaIndAltFixa : Boolean;Var VpaIndice :Double):Integer;
var
  VpfQtdAltura, VpfQtdLargura : Integer;
  VpfQtdMedida1 : Integer;
  VpfIndice1 : Double;
begin
  VpfQtdAltura :=RetornaInteiro(VpaAltProduto/VpaAltMolde);
  if VpfQtdAltura = 0 then
     VpfQtdAltura := 1;
  VpfQtdLargura := RetornaInteiro(VpaLarProduto/VpaLarMolde);
  if VpfQtdLargura = 0 then
  begin
    VpfQtdLargura := 1;
    VpaIndice := VpaLarMolde /100;
  end
  else
    VpaIndice := RetornaInteiro(VpfQtdLargura * VpaLarMolde +(Varia.AcrescimoCMEnfesto *2))/100;
  result := VpfQtdAltura * VpfQtdLargura * VpaQtdProvas;
  if not VpaIndAltFixa then
  begin
    VpfQtdAltura := RetornaInteiro(VpaLarProduto/VpaAltMolde);
    if VpfQtdAltura = 0 then
    begin
      VpfQtdAltura := 1;
      VpfIndice1 := VpaAltMolde / 100;
    end
    else
      VpfIndice1 := RetornaInteiro(VpfQtdAltura * VpaAltMolde +(Varia.AcrescimoCMEnfesto *2))/100;
    VpfQtdLargura := RetornaInteiro(VpaAltProduto/VpaLarMolde);
    VpfQtdMedida1 := VpfQtdAltura * VpfQtdLargura * VpaQtdProvas;
    if VpfQtdMedida1 > 0  then
    begin
      if ((100 * VpfIndice1)/VpfQtdMedida1) < ((100 * VpaIndice)/result) then
      begin
        Result := VpfQtdMedida1;
        VpaIndice := VpfIndice1;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdProdutosEmbalagem(VpaSeqProduto: Integer): integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select QTD_EMBALAGEM '+
                            ' FROM CADPRODUTOS PRO, EMBALAGEM EMB ' +
                            ' Where PRO.I_SEQ_PRO = ' +IntToStr(VpaSeqProduto)+
                            ' AND PRO.I_COD_EMB = EMB.COD_EMBALAGEM ');
  result := AUX.FieldByName('QTD_EMBALAGEM').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RQuantidadeEstoqueProduto(
  VpaSeqProduto, VpaCodCor, VpaCodTamanho: integer): Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_QTD_PRO from MOVQDADEPRODUTO '+
                            ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto) +
                            ' and I_COD_COR = '+ IntToStr(VpaCodCor) +
                            ' and I_COD_TAM = '+ IntToStr(VpaCodTamanho));
  Result := AUX.FieldByname('N_QTD_PRO').AsInteger;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.RQuilosChapa(VpaEspessuraChapa, VpaLarguraChapa,vpaComprimentoChapa, VpaQtdChapas, VpaIndiceVolumetrico: Double): double;
var
  VpfVolume : Double;
begin
  VpfVolume := VpaEspessuraChapa * VpaLarguraChapa * vpaComprimentoChapa * VpaQtdChapas;
  result :=  VpfVolume * (((VpaIndiceVolumetrico /1000)/1000)/1000) ;
end;

{******************************************************************************}
function TFuncoesProduto.PrincipioAtivoControlado(VpaCodPrincipio : Integer) : boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select INDCONTROLADO from PRINCIPIOATIVO '+
                            ' Where CODPRINCIPIO = ' +IntToStr(VpaCodPrincipio));
  result := Aux.FieldByname('INDCONTROLADO').AsString = 'T';
  Aux.Close;
end;

{********************* atualiza o valor de compra do produto ******************}
procedure TFuncoesProduto.AtualizaValorCusto(VpaSeqProduto,VpaCodFilial, VpaCodMoeda : Integer; VpaUniPadrao, VpaUniProduto, VpaFuncaoOperacao: String;VpaCodCor,VpaCodTamanho : Integer;VpaQtdProduto, VpaVlrCompra,VpaTotCompra,VpaVlrFrete,VpaPerIcms, VpaPerIPI,VpaValDescontoNota, VpaValSubstituicaoTributaria : Double;VpaIndFreteEmitente : Boolean);
Var
  VpfValCusto, VpfQtdEstoque, VpfValCustoEstoque, VpfQtdCompra, VpfValFrete, VpfValDesconto, VpfValCompraUMPadrao, VpfTotCompra : Double;
  VpfMoedaProduto : Integer;
  VpfCifrao : String;
begin
  if VpaFuncaoOperacao = 'CO' then
  begin
    VpfMoedaProduto := MoedaPadrao(VpaSeqProduto);  // localiza a moeda do produto
    VpaVlrCompra := UnMoeda.ConverteValor( Vpfcifrao, VpaCodMoeda, VpfMoedaProduto, VpaVlrCompra);
    VpaTotCompra := UnMoeda.ConverteValor( Vpfcifrao, VpaCodMoeda, VpfMoedaProduto, VpaTotCompra);
    VpfQtdCompra := CalculaQdadePadrao( VpaUniProduto, VpaUniPadrao, VpaQtdProduto, IntToStr(VpaSeqProduto));
    if Varia.UtilizarIpi then
      VpaVlrCompra := VpaVlrCompra +((VpaVlrCompra * VpaPerIPI)/100)  ;
    VpaVlrCompra := VpaVlrCompra + (VpaValSubstituicaoTributaria / VpaQtdProduto);

    if VpaIndFreteEmitente then
      VpfTotCompra := VpaTotCompra - VpaVlrFrete
    else
      VpfTotCompra := VpaTotCompra;

    VpfValFrete :=  RFreteRateado(VpaQtdProduto,VpaVlrCompra,VpfTotCompra,VpaVlrFrete);
    VpfValDesconto := RDescontoRateado(VpaQtdProduto,VpaVlrCompra,VpfTotCompra,VpaValDescontoNota);

    VpfValCompraUMPadrao := (VpaVlrCompra * ConvUnidade.Indice(VpaUniProduto,VpaUniPadrao,VpaSeqProduto,Varia.CodigoEmpresa));

    VpfValfrete := VpfValfrete / VpfQtdCompra;

    VpfValCusto := VpfValCompraUMPadrao + VpfValFrete - VpfValDesconto;
    if config.ValordeCompraComFrete then
      VpfValCompraUMPadrao := VpfValCompraUMPadrao + VpfValFrete;
    VpfValCompraUMPadrao := VpfValCompraUMPadrao - VpfValDesconto;
    if CQtdValorCusto(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho, VpfQtdEstoque,VpfValCustoEstoque) then
    begin
      if Varia.MetodoCustoProduto = mcPMP then
      begin
        if (VpfQtdEstoque > 0) and (VpfValCustoEstoque> 0) then
          VpfValCusto := ((VpfQtdEstoque * VpfValCustoEstoque) + (VpfQtdCompra * VpfValCusto))/(VpfQtdCompra + VpfQtdEstoque)
      end
      else
        if Varia.MetodoCustoProduto = mcUEPS then
        begin
          if Config.ManterValordeCustoMaisAlto then
          begin
            if VpfValCusto < VpfValCustoEstoque then
              VpfValCusto := VpfValCustoEstoque;
          end;
        end;
    end
    else
      InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,VpfValCusto,VpfValCompraUMPadrao, '');

    ExecutaComandoSql(Aux,'Update MOVQDADEPRODUTO '+
                            ' Set N_VLR_CUS = '+ SubstituiStr(FloatToStr(VpfValCusto),',','.')+
                            ' , N_VLR_COM = '+ SubstituiStr(FloatToStr(VpfValCompraUMPadrao),',','.')+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' AND I_COD_COR = '+ IntToStr(VpaCodCor));
    if config.ValorVendaProdutoAutomatico then
      AtualizaValorVendaAutomatico(VpaSeqProduto,VpfValCusto);
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaCodEan(VpaSeqProduto,VpaCodCor : Integer;VpaCodBarras : String):String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVQDADEPRODUTO '+
                                    ' Where C_COD_BAR = ''' + VpaCodBarras+'''');
  if ProCadastro.Eof then
  begin
    LocalizaMovQdadeSequencial(ProCadastro,Varia.CodigoEmpFil,VpaSeqProduto,VpaCodCor,0);
    if ProProduto.eof then
    begin
      InsereProdutoFilial(VpaSeqProduto,varia.CodigoEmpFil,VpaCodCor,0, 0,0,0,0,0, '');
      LocalizaMovQdadeSequencial(ProCadastro,Varia.CodigoEmpFil,VpaSeqProduto,VpaCodCor,0);
    end;

    ProCadastro.Edit;
    ProCadastro.FieldByName('C_COD_BAR').AsString := VpaCodBarras;
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
  end
  else
  begin
    if (ProCadastro.FieldByName('I_SEQ_PRO').AsInteger <> VpaSeqProduto) AND
       (ProCadastro.FieldByName('I_COD_COR').AsInteger <> VpaCodCor) Then
    Begin
      AdicionaSQLAbreTabela(AUX,'Select C_COD_PRO, C_NOM_PRO FROM CADPRODUTOS '+
                              ' Where I_SEQ_PRO = '+ ProCadastro.FieldByName('I_SEQ_PRO').AsString);
      result := 'CODIGO DE BARRAS DUPLICADO!!!'#13'Esse código de barras já existe cadastrado para o produto "'+AUX.FieldByName('C_COD_PRO').AsString+'-'+AUX.FieldByName('C_NOM_PRO').AsString+'"';
      Aux.close;
    End;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaValorVendaAutomatico(VpaSeqProduto : Integer;VpaValCusto : Double):string;
begin
  if config.ValorVendaProdutoAutomatico then
  begin
    AdicionaSQLAbreTabela(AUX,'Select N_PER_LUC from CADPRODUTOS '+
                              ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
    if Aux.FieldByName('N_PER_LUC').AsFloat <> 0 then
    begin
      ExecutaComandoSql(Aux,'Update MOVTABELAPRECO '+
                            ' Set N_VLR_VEN = '+ SubstituiStr(FloatToStr((AUX.FieldByName('N_PER_LUC').AsFloat/100)*VpaValCusto),',','.')+
                            ' Where I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa) +
                            ' and I_COD_TAB = '+IntToStr(varia.TabelaPreco)+
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaEmbalagem(VpaSeqProduto,VpaCodEmbalagem : Integer):string;
begin
  LocalizaProdutoSequencial(ProCadastro,IntToStr(VpaSeqProduto));
  ProCadastro.Edit;
  if VpaCodEmbalagem <> 0 then
    ProCadastro.FieldByName('I_COD_EMB').AsInteger := VpaCodEmbalagem
  else
    ProCadastro.FieldByName('I_COD_EMB').clear;

  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaEstoqueChapa(VpaDPlanoCorte: TRBDPlanoCorteCorpo): string;
begin
  result := '';
  if VpaDPlanoCorte.SeqChapa <> 0 then
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from  ESTOQUECHAPA '+
                                      ' Where SEQCHAPA = '+IntToStr(VpaDPlanoCorte.SeqChapa));
    ProCadastro.Edit;
    ProCadastro.FieldByName('PESCHAPA').AsFloat := ProCadastro.FieldByName('PESCHAPA').AsFloat - ((ProCadastro.FieldByName('PESCHAPA').AsFloat * VpaDPlanoCorte.PerChapa)/100);
    ProCadastro.Post;
    result :=  ProCadastro.AMensagemErroGravacao;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaComposicao(VpaSeqProduto,VpaCodComposicao : Integer):string;
begin
  LocalizaProdutoSequencial(ProCadastro,IntToStr(VpaSeqProduto));
  ProCadastro.Edit;
  if VpaCodComposicao <> 0 then
    ProCadastro.FieldByName('I_COD_COM').AsInteger := VpaCodComposicao
  else
    ProCadastro.FieldByName('I_COD_COM').clear;
  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDMovimentoEstoque(VpaTabela : TDataSet;VpaDMovimento : TRBDMovEstoque);
begin
  with VpaDMovimento do
  begin
    CodFilial := VpaTabela.FieldByName('I_EMP_FIL').AsInteger;
    LanEstoque := VpaTabela.FieldByName('I_LAN_EST').AsInteger;
    LanOrcamento := VpaTabela.FieldByName('I_LAN_ORC').AsInteger;
    SeqProduto := VpaTabela.FieldByName('I_SEQ_PRO').AsInteger;
    CodCor := VpaTabela.FieldByName('I_COD_COR').AsInteger;
    CodTamanho := VpaTabela.FieldByName('I_COD_TAM').AsInteger;
    CodOperacaoEstoque := VpaTabela.FieldByName('I_COD_OPE').AsInteger;
    SeqNotaEntrada := VpaTabela.FieldByName('I_NOT_ENT').AsInteger;
    SeqNotaSaida := VpaTabela.FieldByName('I_NOT_SAI').AsInteger;
    NumNota := VpaTabela.FieldByName('I_NRO_NOT').AsInteger;
    TipMovimento := VpaTabela.FieldByName('C_TIP_MOV').AsString;
    CodUnidade := VpaTabela.FieldByName('C_COD_UNI').AsString;
    QtdProduto := VpaTabela.FieldByName('N_QTD_MOV').AsFloat;
    ValMovimento := VpaTabela.FieldByName('N_VLR_MOV').AsFloat;
    DatMovimento := VpaTabela.FieldByName('D_DAT_MOV').AsDateTime;
    ValCusto :=  VpaTabela.FieldByName('N_VLR_CUS').AsFloat;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDProduto(VpaDProduto: TRBDProduto; VpaCodEmpresa: Integer = 0; VpaCodFilial: Integer = 0; VpaSeqProduto: Integer = 0);
begin
  if VpaCodEmpresa <> 0 then
    VpaDProduto.CodEmpresa:= VpaCodEmpresa;
  if VpaCodFilial <> 0 then
    VpaDProduto.CodEmpFil:= VpaCodFilial;
  if VpaSeqProduto <> 0 then
    VpaDProduto.SeqProduto:= VpaSeqProduto;

  AdicionaSQLAbreTabela(Tabela,'SELECT '+
                            ' CAD.I_PES_CVA, CAD.I_QTD_PAG, CAD.C_IND_ORI,'+
                            ' CAD.C_IND_COP, CAD.C_IND_MUL, CAD.C_IND_IMP,'+
                            ' CAD.C_IND_RED, CAD.C_IND_PCL, CAD.C_IND_FAX,'+
                            ' CAD.C_IND_USB, CAD.C_IND_SCA, CAD.C_IND_WIR,'+
                            ' CAD.C_IND_SCR, CAD.C_IMP_COL ,CAD.C_COM_REV,'+
                            ' CAD.C_COM_CIL, CAD.I_QTD_CTB, CAD.I_QTD_CCI,'+
                            ' CAD.I_QTD_CTA, CAD.C_COD_CTA, CAD.I_QTD_PPM,'+
                            ' CAD.I_VOL_MEN, CAD.D_DAT_FAB, CAD.D_DAT_ENC,'+
                            ' CAD.N_PES_BRU, CAD.I_COD_EMB, CAD.N_PES_LIQ,'+
                            ' CAD.I_COD_ACO, CAD.I_ALT_PRO, CAD.I_COD_DES,'+
                            ' CAD.IMPPRE, CAD.C_IND_CRA, CAD.C_IND_RET,'+
                            ' CAD.C_REN_PRO, CAD.CODMAQ, CAD.I_QTD_FUS,'+
                            ' CAD.I_TAB_GRA, CAD.I_TAB_TRA, CAD.C_TIT_FIO,'+
                            ' CAD.C_DES_ENC, CAD.I_COD_SUM, CAD.D_ENT_AMO,'+
                            ' CAD.D_SAI_AMO, CAD.C_TIP_IMP, CAD.METMIN,'+
                            ' CAD.C_ENG_EPE, CAD.I_COD_MOE, CAD.I_IND_COV,'+
                            ' CAD.C_COD_CLA, CAD.C_CLA_FIS, CAD.L_DES_TEC,'+
                            ' CAD.C_COD_REF, CAD.C_BAR_FOR, CAD.C_CIF_MOE,'+
                            ' CAD.N_PER_IPI, CAD.N_PER_ICM, CAD.I_DIA_FOR,'+
                            ' CAD.N_RED_ICM,'+
                            ' CAD.N_PER_LUC, CAD.I_MES_GAR, CAD.I_COD_USU,'+
                            ' CAD.N_PER_KIT, CAD.N_PER_COM, CAD.C_COD_PRO,'+
                            ' CAD.C_COD_UNI, CAD.C_NOM_PRO, CAD.C_PAT_FOT,'+
                            ' CAD.I_LRG_PRO, CAD.C_BAT_TEA, CAD.I_CMP_PRO,'+
                            ' CAD.I_CMP_FIG, CAD.C_BAT_PRO, CAD.I_COD_FUN,'+
                            ' CAD.I_IND_PRO, CAD.C_NUM_FIO, CAD.C_PEN_PRO,'+
                            ' CAD.C_PRA_PRO, CAD.INDCAL, CAD.INDENG, CAD.CODEME,'+
                            ' CAD.L_DES_TEC, CAD.ENGPRO, CAD.I_COD_CRT,'+
                            ' CAD.C_TIP_CAR, CAD.I_QTD_MLC, CAD.C_CHI_NOV,'+
                            ' CAD.C_CIL_NOV, CAD.I_PES_CCH, CAD.C_COD_CTB,'+
                            ' CAD.I_COD_COR, CAD.C_IND_COM, CAD.C_ATI_PRO,'+
                            ' CAD.I_TAB_PED, CAD.I_QTD_CTA, CAD.C_CAR_TEX,'+
                            ' CAD.D_DAT_CAD, CAD.I_COD_COM, CAD.C_IND_MON, '+
                            ' CAD.I_ORI_PRO, CAD.N_CAP_LIQ, CAD.C_KIT_PRO,  '+
                            ' CAD.I_DES_PRO, CAD.C_AGR_BAL, CAD.N_DEN_VOL, '+
                            ' CAD.N_ESP_ACO, CAD.I_QTD_QUA, CAD.I_QTD_COL,  '+
                            ' CAD.I_QTD_LIN, CAD.C_ABE_CAB, CAD.C_CON_ELE, '+
                            ' CAD.C_TEN_ALI, CAD.C_COM_RED, CAD.C_GRA_PRO, '+
                            ' CAD.C_SEN_FER, CAD.C_SEN_NFE, CAD.C_ACO_INO, '+
                            ' CAD.L_DES_FUN, CAD.L_INF_DIS, CAD.C_SIS_TEA, '+
                            ' CAD.C_BCM_TEA, CAD.C_IND_PRE, CAD.C_SUB_TRI,  '+
                            ' CAD.C_DES_BCI, CAD.N_PER_SUT, CAD.C_ENG_TRA, '+
                            ' CAD.I_TIP_PRO, CAD.C_ARE_TRU, C_SIT_TRI, CAD.I_TIP_EMB, '+
                            ' I_PLA_EMB, I_PLS_EMB, I_FER_EMB, C_LAR_EMB, C_ALT_EMB, C_FUN_EMB, '+
                            ' C_ABA_EMB, C_DIA_EMB, C_PEN_EMB, C_LAM_ZIP, '+
                            ' C_LAM_ABA, C_FOT_NRO, I_TAM_ZIP, I_COR_ZIP, I_ALC_EMB, I_IMP_EMB, '+
                            ' I_CBD_EMB, I_SIM_CAB, I_BOT_EMB, I_COR_BOT, I_BOL_EMB, I_ZPE_EMB, I_COD_VIE, '+
                            ' C_LOC_ALC, C_OBS_COR, C_INT_EMB, C_INU_EMB, C_COR_IMP, C_OBS_BOT, '+
                            ' C_ADI_EMB, I_PRE_FAC, I_PRC_EMB, C_IND_CRT, C_IND_BOL, C_IND_IEX, C_LOC_IMP, '+
                            ' C_DES_COM, C_INF_TEC, C_LOC_INT, CAD.C_REC_PRE ' +
                            ' FROM CADPRODUTOS CAD'+
                            ' WHERE CAD.I_SEQ_PRO = '+IntToStr(vpadproduto.Seqproduto));

// Gerais
  VpaDProduto.CodMoeda:= Tabela.FieldByName('I_COD_MOE').AsInteger;
  VpaDProduto.CodUsuario:= Tabela.FieldByName('I_COD_USU').AsInteger;
  VpaDProduto.QtdUnidadesPorCaixa:= Tabela.FieldByName('I_IND_COV').AsInteger;
  VpaDProduto.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
  VpaDProduto.CodUnidade:= Tabela.FieldByName('C_COD_UNI').AsString;
  VpaDProduto.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProduto.CodUnidade);
  VpaDProduto.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
  VpaDProduto.PatFoto:= Tabela.FieldByName('C_PAT_FOT').AsString;
  VpaDProduto.DesObservacao:= Tabela.FieldByName('L_DES_TEC').AsString;
  VpaDProduto.CodClassificacao:= Tabela.FieldByName('C_COD_CLA').AsString;
  VpaDProduto.DesClassificacaoFiscal:= Tabela.FieldByName('C_CLA_FIS').AsString;
  VpaDProduto.DesDescricaoTecnica:= Tabela.FieldByName('L_DES_TEC').AsString;
  VpaDProduto.NumOrigemProduto:= Tabela.FieldByName('I_ORI_PRO').AsInteger;
  VpaDProduto.NumDestinoProduto := RTipoDestinoProduto(Tabela.FieldByName('I_DES_PRO').AsInteger);
  VpaDProduto.CodBarraFornecedor:= Tabela.FieldByName('C_BAR_FOR').AsString;
  VpaDProduto.CifraoMoeda:= Tabela.FieldByName('C_CIF_MOE').AsString;
  VpaDProduto.PerIPI:= Tabela.FieldByName('N_PER_IPI').AsFloat;
  VpaDProduto.PerICMS:= Tabela.FieldByName('N_PER_ICM').AsFloat;
  VpaDProduto.QtdDiasEntregaFornecedor:= Tabela.FieldByName('I_DIA_FOR').AsFloat;
  VpaDProduto.PerReducaoICMS:= Tabela.FieldByName('N_RED_ICM').AsFloat;
  VpaDProduto.PerDesconto:= Tabela.FieldByName('N_PER_KIT').AsFloat;
  VpaDProduto.PerComissao:= Tabela.FieldByName('N_PER_COM').AsFloat;
  VpaDProduto.PerLucro:= Tabela.FieldByName('N_PER_LUC').AsFloat;
  VpaDProduto.PerSubstituicaoTributaria:= Tabela.FieldByName('N_PER_SUT').AsFloat;
  VpaDProduto.IndProdutoAtivo:= (Tabela.FieldByName('C_ATI_PRO').AsString = 'S');
  VpaDProduto.IndSubstituicaoTributaria:= (Tabela.FieldByName('C_SUB_TRI').AsString = 'S');
  VpaDProduto.IndDescontoBaseICMSConfEstado:= (Tabela.FieldByName('C_DES_BCI').AsString = 'S');
  VpaDProduto.IndKit := (Tabela.FieldByName('C_KIT_PRO').AsString = 'K');

// Cadarço
  VpaDProduto.CodMaquina:= Tabela.FieldByName('CODMAQ').AsInteger;
  VpaDProduto.QuantidadeFusos:= Tabela.FieldByName('I_QTD_FUS').AsInteger;
  VpaDProduto.MetrosTabuaPequena:= Tabela.FieldByName('I_TAB_PED').AsInteger;
  VpaDProduto.MetrosTabuaGrande:= Tabela.FieldByName('I_TAB_GRA').AsInteger;
  VpaDProduto.MetrosTabuaTrans:= Tabela.FieldByName('I_TAB_TRA').AsInteger;
  VpaDProduto.Engrenagem:= Tabela.FieldByName('ENGPRO').AsString;
  VpaDProduto.DesTituloFio:= Tabela.FieldByName('C_TIT_FIO').AsString;
  VpaDProduto.DesEnchimento:= Tabela.FieldByName('C_DES_ENC').AsString;
  if Tabela.FieldByName('C_ARE_TRU').AsString = 'T' then
    VpaDProduto.ArredondamentoTruncamento := atTruncamento
  else
    VpaDProduto.ArredondamentoTruncamento := atArredondamento;

// Etiqueta
  VpaDProduto.CodSumula:= Tabela.FieldByName('I_COD_SUM').AsInteger;
  VpaDProduto.DatEntradaAmostra:= Tabela.FieldByName('D_ENT_AMO').AsDateTime;
  VpaDProduto.DatSaidaAmostra:= Tabela.FieldByName('D_SAI_AMO').AsDateTime;
  VpaDProduto.CmpFigura:= Tabela.FieldByName('I_CMP_FIG').AsInteger;
  VpaDProduto.Pente:= Tabela.FieldByName('C_PEN_PRO').AsString;
  VpaDProduto.BatProduto:= Tabela.FieldByName('C_BAT_PRO').AsString;
  VpaDProduto.NumBatidasTear:= Tabela.FieldByName('C_BAT_TEA').AsString;
  VpaDProduto.CodTipoFundo:=  Tabela.FieldByName('I_COD_FUN').AsInteger;
  VpaDProduto.CodTipoEmenda:= Tabela.FieldByName('CODEME').AsInteger;
  VpaDProduto.CodTipoCorte:= Tabela.FieldByName('I_COD_CRT').AsInteger;
  VpaDProduto.PerProdutividade:= Tabela.FieldByName('I_IND_PRO').AsInteger;
  VpaDProduto.IndCalandragem:= Tabela.FieldByName('INDCAL').AsString;
  VpaDProduto.IndEngomagem:= Tabela.FieldByName('INDENG').AsString;

// Adicionais
  VpaDProduto.PesoLiquido:= Tabela.FieldByName('N_PES_LIQ').AsFloat;
  VpaDProduto.PesoBruto:= Tabela.FieldByName('N_PES_BRU').AsFloat;
  VpaDProduto.QtdMesesGarantia := Tabela.FieldByName('I_MES_GAR').AsInteger;
  VpaDProduto.CodEmbalagem:= Tabela.FieldByName('I_COD_EMB').AsInteger;
  VpaDProduto.CodAcondicionamento:= Tabela.FieldByName('I_COD_ACO').AsInteger;
  VpaDProduto.AltProduto:= Tabela.FieldByName('I_ALT_PRO').AsInteger;
  VpaDProduto.CapLiquida := Tabela.FieldByName('N_CAP_LIQ').AsFloat;
  VpaDProduto.CodDesenvolvedor:= Tabela.FieldByName('I_COD_DES').AsInteger;
  VpaDProduto.CodComposicao := Tabela.FieldByName('I_COD_COM').AsInteger;
  VpaDProduto.IndImprimeNaTabelaPreco:= Tabela.FieldByName('IMPPRE').AsString;
  VpaDProduto.IndCracha:= Tabela.FieldByName('C_IND_CRA').AsString;
  VpaDProduto.IndProdutoRetornavel:= Tabela.FieldByName('C_IND_RET').AsString;
  VpaDProduto.DesRendimento:= Tabela.FieldByName('C_REN_PRO').AsString;
  VpaDProduto.DatCadastro := Tabela.FieldByName('D_DAT_CAD').AsDateTime;
  VpaDProduto.IndMonitorarEstoque:= Tabela.FieldByName('C_IND_MON').AsString = 'S';
  VpaDProduto.IndAgruparCorteBalancim := Tabela.FieldByName('C_AGR_BAL').AsString = 'S';
  VpaDProduto.IndRecalcularPreco := Tabela.FieldByName('C_REC_PRE').AsString = 'S';
  if Length(Tabela.FieldByName('C_SIT_TRI').AsString) > 0 then
  begin
    case Tabela.FieldByName('C_SIT_TRI').AsString[1] of
      'I' : VpaDProduto.SituacaoTributaria := stIsento;
      'N' : VpaDProduto.SituacaoTributaria := stNaoTributado;
      'F' : VpaDProduto.SituacaoTributaria := stSubstituicaoTributaria;
      'T' : VpaDProduto.SituacaoTributaria := stTributadoICMS;
    end;
  end
  else
    VpaDProduto.SituacaoTributaria := stTributadoICMS;

// Copiadora
  VpaDProduto.IndCopiadora:= Tabela.FieldByName('C_IND_COP').AsString;
  VpaDProduto.IndMultiFuncional:= Tabela.FieldByName('C_IND_MUL').AsString;
  VpaDProduto.IndImpressora:= Tabela.FieldByName('C_IND_IMP').AsString;
  VpaDProduto.IndColorida:= Tabela.FieldByName('C_IMP_COL').AsString;
  VpaDProduto.IndComponente:= Tabela.FieldByName('C_COM_REV').AsString;
  VpaDProduto.IndCilindro:= Tabela.FieldByName('C_COM_CIL').AsString;
  VpaDProduto.IndPlacaRede:= Tabela.FieldByName('C_IND_RED').AsString;
  VpaDProduto.IndPCL:= Tabela.FieldByName('C_IND_PCL').AsString;
  VpaDProduto.IndFax:= Tabela.FieldByName('C_IND_FAX').AsString;
  VpaDProduto.IndUSB:= Tabela.FieldByName('C_IND_USB').AsString;
  VpaDProduto.IndScanner:= Tabela.FieldByName('C_IND_SCA').AsString;
  VpaDProduto.IndWireless:= Tabela.FieldByName('C_IND_WIR').AsString;
  VpaDProduto.IndDuplex:= Tabela.FieldByName('C_IND_SCR').AsString;
  VpaDProduto.CodCartuchoAltaCapac:= Tabela.FieldByName('C_COD_CTA').AsString;
  VpaDProduto.QtdCopiasTonner:= Tabela.FieldByName('I_QTD_CTB').AsInteger;
  VpaDProduto.QtdCopiasTonnerAltaCapac:= Tabela.FieldByName('I_QTD_CTA').AsInteger;
  VpaDProduto.QtdCopiasCilindro:= Tabela.FieldByName('I_QTD_CCI').AsInteger;
  VpaDProduto.QtdPagPorMinuto:= Tabela.FieldByName('I_QTD_PPM').AsInteger;
  VpaDProduto.VolumeMensal:= Tabela.FieldByName('I_VOL_MEN').AsInteger;
  VpaDProduto.DatFabricacao:= Tabela.FieldByName('D_DAT_FAB').AsDateTime;
  VpaDProduto.DatEncerProducao:= Tabela.FieldByName('D_DAT_ENC').AsDateTime;

// aco
  VpaDProduto.DensidadeVolumetrica:= Tabela.FieldByName('N_DEN_VOL').AsFloat;
  VpaDProduto.EspessuraAco := Tabela.FieldByName('N_ESP_ACO').AsFloat;

  //instalacao tear
  VpaDProduto.QtdQuadros := Tabela.FieldByName('I_QTD_QUA').AsInteger;
  VpaDProduto.QtdColunas := Tabela.FieldByName('I_QTD_COL').AsInteger;
  VpaDProduto.QtdLinhas := Tabela.FieldByName('I_QTD_LIN').AsInteger;

  // Cartuchos
  VpaDProduto.QtdPaginas:= Tabela.FieldByName('I_QTD_PAG').AsInteger;
  VpaDProduto.PesCartucho:= Tabela.FieldByName('I_PES_CCH').AsInteger;
  VpaDProduto.PesCartuchoVazio:= Tabela.FieldByName('I_PES_CVA').AsInteger;
  VpaDProduto.QtdMlCartucho:= Tabela.FieldByName('I_QTD_MLC').AsInteger;
  VpaDProduto.CodCorCartucho:= Tabela.FieldByName('I_COD_COR').AsInteger;
  VpaDProduto.DesTipoCartucho:= Tabela.FieldByName('C_TIP_CAR').AsString;
  VpaDProduto.IndChipNovo:= (Tabela.FieldByName('C_CHI_NOV').AsString = 'S');
  VpaDProduto.IndCilindroNovo:= (Tabela.FieldByName('C_CIL_NOV').AsString = 'S');
  VpaDProduto.IndProdutoCompativel:= (Tabela.FieldByName('C_IND_COM').AsString = 'S');
  VpaDProduto.IndProdutoOriginal:= (Tabela.FieldByName('C_IND_ORI').AsString = 'S');
  VpaDProduto.IndCartuchoTexto:= (Tabela.FieldByName('C_CAR_TEX').AsString = 'S');

// Dados que se repetem para várias páginas. Ex.: Largura Produto
  VpaDProduto.LarProduto:= Tabela.FieldByName('I_LRG_PRO').AsInteger;
  VpaDProduto.CmpProduto:= Tabela.FieldByName('I_CMP_PRO').AsInteger;
  VpaDProduto.NumFios:= Tabela.FieldByName('C_NUM_FIO').AsString;
  VpaDProduto.MetrosPorMinuto:= Tabela.FieldByName('METMIN').AsInteger;
  VpaDProduto.EngrenagemEspPequena:= Tabela.FieldByName('C_ENG_EPE').AsString;
  VpaDProduto.PraProduto:= Tabela.FieldByName('C_PRA_PRO').AsString;
  VpaDProduto.DesTipTear:= Tabela.FieldByName('C_TIP_IMP').AsString;
  VpaDProduto.CodReduzidoCartucho:= Tabela.FieldByName('C_COD_CTB').AsString;

 // Detectores de Metal
  VpaDProduto.AberturaCabeca := Tabela.FieldByName('C_ABE_CAB').AsString;
  VpaDProduto.ConsumoEletrico := Tabela.FieldByName('C_CON_ELE').AsString;
  VpaDProduto.TensaoAlimentacao := Tabela.FieldByName('C_TEN_ALI').AsString;
  VpaDProduto.ComunicacaoRede := Tabela.FieldByName('C_COM_RED').AsString;
  VpaDProduto.GrauProtecao := Tabela.FieldByName('C_GRA_PRO').AsString;
  VpaDProduto.SensibilidadeFerrosos := Tabela.FieldByName('C_SEN_FER').AsString;
  VpaDProduto.SensibilidadeNaoFerrosos := Tabela.FieldByName('C_SEN_NFE').AsString;
  VpaDProduto.AcoInoxidavel := Tabela.FieldByName('C_ACO_INO').AsString;
  VpaDProduto.DescritivoFuncDetectoresMetal := Tabela.FieldByName('L_DES_FUN').AsString;
  VpaDProduto.InfDisplayDetectoresMetal := Tabela.FieldByName('L_INF_DIS').AsString;

  // Cadarço de fitas
  VpaDProduto.SistemaTear := Tabela.FieldByName('C_SIS_TEA').AsString;
  VpaDProduto.BatidasPorCm := Tabela.FieldByName('C_BCM_TEA').AsString;
  VpaDProduto.IndPreEncolhido := Tabela.FieldByName('C_IND_PRE').AsString;
  VpaDProduto.EngrenagemTrama := Tabela.FieldByName('C_ENG_TRA').AsString;

  //Orcamento Cadarço
  case Tabela.FieldByName('I_TIP_PRO').AsInteger of
    0 : VpaDProduto.TipoCadarco := tcConvencional;
    1 : VpaDProduto.TipoCadarco := tcCroche;
    2 : VpaDProduto.TipoCadarco := tcRenda;
    3 : VpaDProduto.TipoCadarco := tcElastico;
  end;

  //Embalagem PVC
  case Tabela.FieldByName('I_TIP_EMB').AsInteger of
    0 : VpaDProduto.TipEmbalagem := teEmBranco;
    1 : VpaDProduto.TipEmbalagem := teCosturado;
    2 : VpaDProduto.TipEmbalagem := teSoldada;
    3 : VpaDProduto.TipEmbalagem := teSoldadaZiper;
    4 : VpaDProduto.TipEmbalagem := teTnt;
    5 : VpaDProduto.TipEmbalagem := teMateriaPrima;
  end;
  VpaDProduto.SeqProdutoPlastico:= Tabela.FieldByName('I_PLA_EMB').AsInteger;
  VpaDProduto.SeqProdutoPlastico2:= Tabela.FieldByName('I_PLS_EMB').AsInteger;
  VpaDProduto.CodFerramentaFaca:= Tabela.FieldByName('I_FER_EMB').AsInteger;
  VpaDProduto.DesLarPvc:= Tabela.FieldByName('C_LAR_EMB').AsString;
  VpaDProduto.DesAltPvc:= Tabela.FieldByName('C_ALT_EMB').AsString;
  VpaDProduto.DesComFunPvc:= Tabela.FieldByName('C_FUN_EMB').AsString;
  VpaDProduto.DesComAbaPvc:= Tabela.FieldByName('C_ABA_EMB').AsString;
  VpaDProduto.DesComDiametroPvc:= Tabela.FieldByName('C_DIA_EMB').AsString;
  VpaDProduto.DesComPendurico:= Tabela.FieldByName('C_PEN_EMB').AsString;
  case Tabela.FieldByName('I_ALC_EMB').AsInteger of
    0 : VpaDProduto.Alca := aeEmBranco;
    1 : VpaDProduto.Alca := aeSemAlca;
    2 : VpaDProduto.Alca := aePadrao;
    3 : VpaDProduto.Alca := aePequeno;
    4 : VpaDProduto.Alca := aeGrande;
    5 : VpaDProduto.Alca := aeCosturada;
    6 : VpaDProduto.Alca := aeAlcaFita;
    7 : VpaDProduto.Alca := aeAlcaSilicone;
  end;
  VpaDProduto.DesLocalAlca:= Tabela.FieldByName('C_LOC_ALC').AsString;
  VpaDProduto.IndCorte:= Tabela.FieldByName('C_IND_CRT').AsString='S';
  VpaDProduto.ObsCorte:= Tabela.FieldByName('C_OBS_COR').AsString;
  VpaDProduto.ComLaminaZiper:= Tabela.FieldByName('C_LAM_ZIP').Asstring;
  VpaDProduto.ComLaminaAba:= Tabela.FieldByName('C_LAM_ABA').AsString;
  VpaDProduto.ComLaminaAba:= Tabela.FieldByName('C_LAM_ABA').AsString;
  VpaDProduto.IndBolso:= Tabela.FieldByName('C_IND_BOL').AsString='S';
  VpaDProduto.DesInterno:= Tabela.FieldByName('C_INT_EMB').AsString;
  VpaDProduto.DesInterno2:= Tabela.FieldByName('C_INU_EMB').AsString;
  VpaDProduto.DesLocalInt:= Tabela.FieldByName('C_LOC_INT').AsString;
  case Tabela.FieldByName('I_IMP_EMB').AsInteger of
    0 : VpaDProduto.Impressao := ieEmBranco;
    1 : VpaDProduto.Impressao := ieNao;
    2 : VpaDProduto.Impressao := ie1;
    3 : VpaDProduto.Impressao := ie2;
    4 : VpaDProduto.Impressao := ie3;
    5 : VpaDProduto.Impressao := ie4;
    6 : VpaDProduto.Impressao := ie5;
    7 : VpaDProduto.Impressao := ie6;
    8 : VpaDProduto.Impressao := ie7;
    9 : VpaDProduto.Impressao := ie8;
  end;
  VpaDProduto.DesLocalImp:= Tabela.FieldByName('C_LOC_IMP').AsString;
  VpaDProduto.DesCoresImp:= Tabela.FieldByName('C_COR_IMP').AsString;
  VpaDProduto.DesFotolito:= Tabela.FieldByName('C_FOT_NRO').AsString;
  if Tabela.FieldByName('C_IND_IEX').AsString = 'I' then
    VpaDProduto.InternoExterno:= inInterno
  else
    if Tabela.FieldByName('C_IND_IEX').AsString = 'E' then
      VpaDProduto.InternoExterno:= inExterno;

  case Tabela.FieldByName('I_CBD_EMB').AsInteger of
    0 : VpaDProduto.Cabide := ceEmBranco;
    1 : VpaDProduto.Cabide := ceNao;
    2 : VpaDProduto.Cabide := ce8Cm;
    3 : VpaDProduto.Cabide := ce10Cm;
    4 : VpaDProduto.Cabide := ce14Cm;
    5 : VpaDProduto.Cabide := ceGancheira;
  end;
  case Tabela.FieldByName('I_SIM_CAB').AsInteger of
    0 : VpaDProduto.SimCabide := seEmBranco;
    1 : VpaDProduto.SimCabide := seLado;
    2 : VpaDProduto.SimCabide := seOposto;
    3 : VpaDProduto.SimCabide := seLateral;
  end;
  case Tabela.FieldByName('I_BOT_EMB').AsInteger of
    0 : VpaDProduto.Botao := beEmBranco;
    1 : VpaDProduto.Botao := beNao;
    2 : VpaDProduto.Botao := be1;
    3 : VpaDProduto.Botao := be2;
    4 : VpaDProduto.Botao := be3;
  end;
  case Tabela.FieldByName('I_COR_BOT').AsInteger of
    0 : VpaDProduto.CorBotao := cbEmBranco;
    1 : VpaDProduto.CorBotao := cbeBranco;
    2 : VpaDProduto.CorBotao := cbePreto;
  end;
  VpaDProduto.ObsBotao:= Tabela.FieldByName('C_OBS_BOT').AsString;
  case Tabela.FieldByName('I_BOL_EMB').AsInteger of
    0 : VpaDProduto.Boline := boEmBranco;
    1 : VpaDProduto.Boline := boNao;
    2 : VpaDProduto.Boline := bo1;
    3 : VpaDProduto.Boline := bo2;
    4 : VpaDProduto.Boline := bo3;
    5 : VpaDProduto.Boline := boLiner;
  end;
  case Tabela.FieldByName('I_ZPE_EMB').AsInteger of
    0 : VpaDProduto.Ziper := zeEmBranco;
    1 : VpaDProduto.Ziper := zeNao;
    2 : VpaDProduto.Ziper := zeNylon3;
    3 : VpaDProduto.Ziper := zeNylon6;
    4 : VpaDProduto.Ziper := zePvc;
    5 : VpaDProduto.Ziper := zeZiper;
  end;
  VpaDProduto.TamZiper:= Tabela.FieldByName('I_TAM_ZIP').AsInteger;
  VpaDProduto.CodCorZiper:= Tabela.FieldByName('I_COR_ZIP').AsInteger;
  case Tabela.FieldByName('I_COD_VIE').AsInteger of
    0 : VpaDProduto.Vies := veEmBranco;
    1 : VpaDProduto.Vies := vePvcTran;
    2 : VpaDProduto.Vies := vePvcCol;
    3 : VpaDProduto.Vies := veViesTn;
    4 : VpaDProduto.Vies := veViesAl;
    5 : VpaDProduto.Vies := veViesLi;
  end;

  // Maquinas Rotuladoras
  VpaDProduto.DesComercial:= Tabela.FieldByName('C_DES_COM').AsString;
  VpaDProduto.DesInfoTecnica:= Tabela.FieldByName('C_INF_TEC').AsString;

  VpaDProduto.DesAdicionaisPvc:= Tabela.FieldByName('C_ADI_EMB').AsString;
  VpaDProduto.ValPrecoFaccionista:= Tabela.FieldByName('I_PRE_FAC').AsFloat;
  VpaDProduto.ValPrecoPvc:= Tabela.FieldByName('I_PRC_EMB').AsFloat;

  Tabela.close;
//  CarDCombinacao(VpaDProduto);
//  CarDEstagio(VpaDProduto);
//  CarDFornecedores(VpaDProduto);
  CarDEstoque1(VpaDProduto, VpaDProduto.CodEmpFil, VpaDProduto.SeqProduto);
  CarDPreco(VpaDProduto, VpaDProduto.CodEmpresa, VpaDProduto.SeqProduto);
  CarDValCusto(VpaDProduto,VpaDProduto.CodEmpFil);
  CarDFilialFaturamento(VpaDProduto);
//  CarAcessoriosProduto(VpaDProduto);
end;


{******************************************************************************}
procedure TFuncoesProduto.CarDEstoque1(VpaDProduto: TRBDProduto; VpaCodFilial, VpaSeqProduto: Integer;VpaCodCor : Integer = 0;VpaCodTamanho : Integer = 0);
var
  VpfCodFilial : Integer;
begin
  if config.EstoqueCentralizado then
    VpfCodFilial := varia.CodFilialControladoraEstoque
  else
    VpfCodFilial := VpaCodFilial;
  AdicionaSQLAbreTabela(Tabela,'SELECT MOV.I_COD_BAR, MOV.N_QTD_MIN, MOV.N_QTD_PED,'+
                               ' MOV.N_QTD_PRO, MOV.N_VLR_CUS, MOV.N_QTD_RES, MOV.N_QTD_ARE '+
                               ' FROM MOVQDADEPRODUTO MOV'+
                               ' WHERE '+
                               ' MOV.I_EMP_FIL = '+IntToStr(VpfCodFilial)+
                               ' AND MOV.I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                               ' AND MOV.I_COD_COR = '+IntToStr(VpaCodCor)+
                               ' and MOV.I_COD_TAM = '+IntToStr(VpaCodTamanho));

  VpaDProduto.CodTipoCodBarra:= Tabela.FieldByName('I_COD_BAR').AsInteger;
  VpaDProduto.QtdMinima:= Tabela.FieldByName('N_QTD_MIN').AsFloat;
  VpaDProduto.QtdPedido:= Tabela.FieldByName('N_QTD_PED').AsFloat;
  VpaDProduto.QtdEstoque:= Tabela.FieldByName('N_QTD_PRO').AsFloat;
  VpaDProduto.QtdReservado := Tabela.FieldByName('N_QTD_RES').AsFloat;
  VpaDProduto.QtdAReservar := Tabela.FieldByName('N_QTD_ARE').AsFloat;
  VpaDProduto.QtdRealEstoque := VpaDProduto.QtdEstoque - VpaDProduto.QtdReservado - VpaDProduto.QtdAReservar;
  VpaDProduto.VlrCusto:= Tabela.FieldByName('N_VLR_CUS').AsFloat;

  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDEstoqueChapa(VpaSeqProduto: Integer; VpaChapas: TList);
Var
  VpfDChapa : TRBDEStoqueChapa;
begin
  FreeTObjectsList(VpaChapas);
  AdicionaSQLAbreTabela(Tabela,'Select * from ESTOQUECHAPA '+
                               ' Where SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                               ' order by SEQCHAPA ');
  while not Tabela.eof do
  begin
    VpfDChapa := TRBDEStoqueChapa.cria;
    VpaChapas.Add(VpfDChapa);
    VpfDChapa.SeqChapa := Tabela.FieldByName('SEQCHAPA').AsInteger;
    VpfDChapa.LarChapa := Tabela.FieldByName('LARCHAPA').AsFloat;
    VpfDChapa.ComChapa := Tabela.FieldByName('COMCHAPA').AsFloat;
    VpfDChapa.PerChapa := Tabela.FieldByName('PERCHAPA').AsFloat;
    VpfDChapa.PesChapa := Tabela.FieldByName('PESCHAPA').AsFloat;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDPreco(VpaDProduto: TRBDProduto; VpaCodEmpresa, VpaSeqProduto: Integer);
Var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  FreeTObjectsList(VpaDProduto.TabelaPreco);
  AdicionaSQLAbreTabela(Tabela,'SELECT MOV.N_PER_MAX, MOV.N_VLR_VEN, MOV.N_VLR_REV, '+
                               ' CAD.I_COD_TAB, CAD.C_NOM_TAB, '+
                               ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                               ' MOE.I_COD_MOE, MOE.C_NOM_MOE, '+
                               ' TAM.CODTAMANHO, TAM.NOMTAMANHO, '+
                               ' COR.COD_COR, COR.NOM_COR ' +
                               ' FROM MOVTABELAPRECO MOV, CADCLIENTES CLI, TAMANHO TAM, CADMOEDAS MOE, CADTABELAPRECO CAD, COR '+
                               ' WHERE MOV.I_COD_EMP = '+IntToStr(VpaCodEmpresa)+
                               ' AND MOV. I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_CLI','CLI.I_COD_CLI')+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                               ' AND MOV.I_COD_MOE = MOE.I_COD_MOE '+
                               ' AND MOV.I_COD_TAB = CAD.I_COD_TAB');
  while not Tabela.Eof do
  begin
    VpfDTabelaPreco := VpaDProduto.AddTabelaPreco;
    VpfDTabelaPreco.CodTabelaPreco := Tabela.FieldByName('I_COD_TAB').AsInteger;
    VpfDTabelaPreco.NomTabelaPreco := Tabela.FieldByName('C_NOM_TAB').AsString;
    VpfDTabelaPreco.CodTamanho := Tabela.FieldByName('CODTAMANHO').AsInteger;
    VpfDTabelaPreco.NomTamanho := Tabela.FieldByName('NOMTAMANHO').AsString;
    VpfDTabelaPreco.CodCor := Tabela.FieldByName('COD_COR').AsInteger;
    VpfDTabelaPreco.NomCor := Tabela.FieldByName('NOM_COR').AsString;
    VpfDTabelaPreco.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
    VpfDTabelaPreco.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDTabelaPreco.CodMoeda := Tabela.FieldByName('I_COD_MOE').AsInteger;
    VpfDTabelaPreco.NomMoeda := Tabela.FieldByName('C_NOM_MOE').AsString;
    VpfDTabelaPreco.ValVenda := Tabela.FieldByName('N_VLR_VEN').AsFloat;
    VpfDTabelaPreco.ValReVenda := Tabela.FieldByName('N_VLR_REV').AsFloat;
    VpfDTabelaPreco.PerMaximoDesconto := Tabela.FieldByName('N_PER_MAX').AsFloat;
    if (Tabela.FieldByName('I_COD_TAB').AsInteger = VARIA.TabelaPreco) and
       (Tabela.FieldByName('I_COD_MOE').AsInteger = VARIA.MoedaBase) and
       (Tabela.FieldByName('CODTAMANHO').AsInteger = 0) and
       (Tabela.FieldByName('COD_COR').AsInteger = 0) and
       (Tabela.FieldByName('I_COD_CLI').AsInteger = 0) then
    begin
      VpaDProduto.PerMaxDesconto:= Tabela.FieldByName('N_PER_MAX').AsFloat;
      VpaDProduto.VlrVenda:= Tabela.FieldByName('N_VLR_VEN').AsFloat;
      VpaDProduto.VlrRevenda := Tabela.FieldByName('N_VLR_REV').AsFloat;
    end;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDProduto(VpaDProduto: TRBDProduto): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM CADPRODUTOS'+
                                    ' WHERE I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto));
  if ProCadastro.Eof then
    ProCadastro.Insert
  else
    ProCadastro.Edit;

// Gerais
  ProCadastro.FieldByName('I_COD_EMP').AsInteger:= VpaDProduto.CodEmpresa;
  ProCadastro.FieldByName('I_COD_MOE').AsInteger:= VpaDProduto.CodMoeda;
  if VpaDProduto.CodUsuario <> 0 then
    ProCadastro.FieldByName('I_COD_USU').AsInteger:= VpaDProduto.CodUsuario;
  ProCadastro.FieldByName('I_IND_COV').AsInteger:= VpaDProduto.QtdUnidadesPorCaixa;
  ProCadastro.FieldByName('N_PER_IPI').AsFloat:= VpaDProduto.PerIPI;
  ProCadastro.FieldByName('N_PER_ICM').AsFloat:= VpaDProduto.PerICMS;
  ProCadastro.FieldByName('I_DIA_FOR').AsFloat:= VpaDProduto.QtdDiasEntregaFornecedor;
  ProCadastro.FieldByName('N_RED_ICM').AsFloat:= VpaDProduto.PerReducaoICMS;
  ProCadastro.FieldByName('N_PER_KIT').AsFloat:= VpaDProduto.PerDesconto;
  ProCadastro.FieldByName('N_PER_MAX').AsFloat:= VpaDProduto.PerMaxDesconto;
  ProCadastro.FieldByName('N_PER_COM').AsFloat:= VpaDProduto.PerComissao;
  ProCadastro.FieldByName('N_PER_LUC').AsFloat:= VpaDProduto.PerLucro;
  ProCadastro.FieldByName('N_PER_SUT').AsFloat:= VpaDProduto.PerSubstituicaoTributaria;
  ProCadastro.FieldByName('C_COD_PRO').AsString:= VpaDProduto.CodProduto;
  ProCadastro.FieldByName('C_COD_UNI').AsString:= VpaDProduto.CodUnidade;
  ProCadastro.FieldByName('C_NOM_PRO').AsString:= VpaDProduto.NomProduto;
  ProCadastro.FieldByName('C_COD_CLA').AsString:= VpaDProduto.CodClassificacao;
  ProCadastro.FieldByName('C_CLA_FIS').AsString:= VpaDProduto.DesClassificacaoFiscal;
  ProCadastro.FieldByName('L_DES_TEC').AsString:= VpaDProduto.DesDescricaoTecnica;
  ProCadastro.FieldByName('I_ORI_PRO').AsInteger:= VpaDProduto.NumOrigemProduto;
  ProCadastro.FieldByName('I_DES_PRO').AsInteger:=  RNumDestinoProduto(VpaDProduto.NumDestinoProduto);
  ProCadastro.FieldByName('C_BAR_FOR').AsString:= VpaDProduto.CodBarraFornecedor;
  ProCadastro.FieldByName('C_PAT_FOT').AsString:= VpaDProduto.PatFoto;
  ProCadastro.FieldByName('C_CIF_MOE').AsString:= VpaDProduto.CifraoMoeda;
  if VpaDProduto.IndProdutoAtivo then
    ProCadastro.FieldByName('C_ATI_PRO').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_ATI_PRO').AsString:= 'N';
  if VpaDProduto.IndSubstituicaoTributaria then
    ProCadastro.FieldByName('C_SUB_TRI').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_SUB_TRI').AsString:= 'N';
  if VpaDProduto.IndDescontoBaseICMSConfEstado then
    ProCadastro.FieldByName('C_DES_BCI').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_DES_BCI').AsString:= 'N';
  ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= Sistema.RDataServidor;

// Cadarço trancado
  if VpaDProduto.CodMaquina <> 0 then
    ProCadastro.FieldByName('CODMAQ').AsInteger:= VpaDProduto.CodMaquina
  else
    ProCadastro.FieldByName('CODMAQ').Clear;
  ProCadastro.FieldByName('C_ENG_EPE').AsString:= VpaDProduto.EngrenagemEspPequena;
  ProCadastro.FieldByName('I_QTD_FUS').AsInteger:= VpaDProduto.QuantidadeFusos;
  ProCadastro.FieldByName('C_TIT_FIO').AsString:= VpaDProduto.DesTituloFio;
  ProCadastro.FieldByName('I_TAB_PED').AsInteger:= VpaDProduto.MetrosTabuaPequena;
  ProCadastro.FieldByName('I_TAB_GRA').AsInteger:= VpaDProduto.MetrosTabuaGrande;
  ProCadastro.FieldByName('I_TAB_TRA').AsInteger:= VpaDProduto.MetrosTabuaTrans;
  ProCadastro.FieldByName('C_DES_ENC').AsString:= VpaDProduto.DesEnchimento;

// Etiqueta
  if VpaDProduto.CodSumula <> 0 then
    ProCadastro.FieldByName('I_COD_SUM').AsInteger:= VpaDProduto.CodSumula
  else
    ProCadastro.FieldByName('I_COD_SUM').Clear;
  ProCadastro.FieldByName('D_ENT_AMO').AsDateTime:= VpaDProduto.DatEntradaAmostra;
  ProCadastro.FieldByName('D_SAI_AMO').AsDateTime:= VpaDProduto.DatSaidaAmostra;
  ProCadastro.FieldByName('I_CMP_FIG').AsInteger:= VpaDProduto.CmpFigura;
  ProCadastro.FieldByName('C_PEN_PRO').AsString:= VpaDProduto.Pente;
  ProCadastro.FieldByName('C_BAT_PRO').AsString:= VpaDProduto.BatProduto;
  ProCadastro.FieldByName('C_BAT_TEA').AsString:= VpaDProduto.NumBatidasTear;
  if VpaDProduto.CodTipoFundo <> 0 then
    ProCadastro.FieldByName('I_COD_FUN').AsInteger:= VpaDProduto.CodTipoFundo
  else
    ProCadastro.FieldByName('I_COD_FUN').Clear;
  if VpaDProduto.CodTipoEmenda <> 0 then
    ProCadastro.FieldByName('CODEME').AsInteger:= VpaDProduto.CodTipoEmenda
  else
    ProCadastro.FieldByName('CODEME').Clear;
  if VpaDProduto.CodTipoCorte <> 0 then
    ProCadastro.FieldByName('I_COD_CRT').AsInteger:= VpaDProduto.CodTipoCorte
  else
    ProCadastro.FieldByName('I_COD_CRT').Clear;
  ProCadastro.FieldByName('I_IND_PRO').AsInteger:= VpaDProduto.PerProdutividade;
  ProCadastro.FieldByName('INDCAL').AsString:= VpaDProduto.IndCalandragem;
  ProCadastro.FieldByName('INDENG').AsString:= VpaDProduto.IndEngomagem;

// Adicionais
  ProCadastro.FieldByName('N_PES_LIQ').AsFloat:= VpaDProduto.PesoLiquido;
  ProCadastro.FieldByName('N_PES_BRU').AsFloat:= VpaDProduto.PesoBruto;
  ProCadastro.FieldByName('I_MES_GAR').AsInteger:= VpaDProduto.QtdMesesGarantia;
  if VpaDProduto.CodEmbalagem <> 0 then
    ProCadastro.FieldByName('I_COD_EMB').AsInteger:= VpaDProduto.CodEmbalagem
  else
    ProCadastro.FieldByName('I_COD_EMB').Clear;
  if VpaDProduto.CodAcondicionamento <> 0 then
    ProCadastro.FieldByName('I_COD_ACO').AsInteger:= VpaDProduto.CodAcondicionamento
  else
    ProCadastro.FieldByName('I_COD_ACO').Clear;
  ProCadastro.FieldByName('I_ALT_PRO').AsInteger:= VpaDProduto.AltProduto;
  if VpaDProduto.CodDesenvolvedor <> 0 then
    ProCadastro.FieldByName('I_COD_DES').AsInteger:= VpaDProduto.CodDesenvolvedor
  else
    ProCadastro.FieldByName('I_COD_DES').Clear;
  if VpaDProduto.CodComposicao <> 0 then
    ProCadastro.FieldByName('I_COD_COM').AsInteger:= VpaDProduto.CodComposicao
  else
    ProCadastro.FieldByName('I_COD_COM').Clear;
  ProCadastro.FieldByName('IMPPRE').AsString:= VpaDProduto.IndImprimeNaTabelaPreco;
  ProCadastro.FieldByName('C_IND_CRA').AsString:= VpaDProduto.IndCracha;
  ProCadastro.FieldByName('C_IND_RET').AsString:= VpaDProduto.IndProdutoRetornavel;
  ProCadastro.FieldByName('C_REN_PRO').AsString:= VpaDProduto.DesRendimento;
  if VpaDProduto.IndMonitorarEstoque then
    ProCadastro.FieldByName('C_IND_MON').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_IND_MON').AsString:= 'N';
  if VpaDProduto.IndAgruparCorteBalancim then
    ProCadastro.FieldByName('C_AGR_BAL').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_AGR_BAL').AsString:= 'N';
  ProCadastro.FieldByName('N_CAP_LIQ').AsFloat := VpaDProduto.CapLiquida;
  if VpaDProduto.IndRecalcularPreco then
    ProCadastro.FieldByName('C_REC_PRE').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_REC_PRE').AsString:= 'N';

  case VpaDProduto.ArredondamentoTruncamento of
    atArredondamento: ProCadastro.FieldByName('C_ARE_TRU').AsString := 'A' ;
    atTruncamento: ProCadastro.FieldByName('C_ARE_TRU').AsString := 'T';
  end;
  case VpaDProduto.SituacaoTributaria of
    stIsento: ProCadastro.FieldByName('C_SIT_TRI').AsString := 'I';
    stNaoTributado: ProCadastro.FieldByName('C_SIT_TRI').AsString := 'N' ;
    stSubstituicaoTributaria: ProCadastro.FieldByName('C_SIT_TRI').AsString := 'F';
    stTributadoICMS: ProCadastro.FieldByName('C_SIT_TRI').AsString := 'T';
  end;

// Copiadoras
  ProCadastro.FieldByName('C_IND_COP').AsString:= VpaDProduto.IndCopiadora;
  ProCadastro.FieldByName('C_IND_MUL').AsString:= VpaDProduto.IndMultiFuncional;
  ProCadastro.FieldByName('C_IND_IMP').AsString:= VpaDProduto.IndImpressora;
  ProCadastro.FieldByName('C_IMP_COL').AsString:= VpaDProduto.IndColorida;
  ProCadastro.FieldByName('C_COM_REV').AsString:= VpaDProduto.IndComponente;
  ProCadastro.FieldByName('C_COM_CIL').AsString:= VpaDProduto.IndCilindro;
  ProCadastro.FieldByName('C_IND_RED').AsString:= VpaDProduto.IndPlacaRede;
  ProCadastro.FieldByName('C_IND_PCL').AsString:= VpaDProduto.IndPCL;
  ProCadastro.FieldByName('C_IND_FAX').AsString:= VpaDProduto.IndFax;
  ProCadastro.FieldByName('C_IND_USB').AsString:= VpaDProduto.IndUSB;
  ProCadastro.FieldByName('C_IND_SCA').AsString:= VpaDProduto.IndScanner;
  ProCadastro.FieldByName('C_IND_WIR').AsString:= VpaDProduto.IndWireless;
  ProCadastro.FieldByName('C_IND_SCR').AsString:= VpaDProduto.IndDuplex;
  ProCadastro.FieldByName('C_COD_CTA').AsString:= VpaDProduto.CodCartuchoAltaCapac;
  ProCadastro.FieldByName('I_QTD_CTB').AsInteger:= VpaDProduto.QtdCopiasTonner;
  ProCadastro.FieldByName('I_QTD_CTA').AsInteger:=VpaDProduto.QtdCopiasTonnerAltaCapac;
  ProCadastro.FieldByName('I_QTD_CCI').AsInteger:= VpaDProduto.QtdCopiasCilindro;
  ProCadastro.FieldByName('I_QTD_PPM').AsInteger:= VpaDProduto.QtdPagPorMinuto;
  ProCadastro.FieldByName('I_VOL_MEN').AsInteger:= VpaDProduto.VolumeMensal;
  ProCadastro.FieldByName('D_DAT_FAB').AsDateTime:= VpaDProduto.DatFabricacao;
  ProCadastro.FieldByName('D_DAT_ENC').AsDateTime:= VpaDProduto.DatEncerProducao;

// aco
  ProCadastro.FieldByName('N_DEN_VOL').Value := VpaDProduto.DensidadeVolumetrica;
  ProCadastro.FieldByName('N_ESP_ACO').AsFloat:= VpaDProduto.EspessuraAco;

//instalacao tear;
  ProCadastro.FieldByName('I_QTD_QUA').AsInteger := VpaDProduto.QtdQuadros;
  ProCadastro.FieldByName('I_QTD_LIN').AsInteger := VpaDProduto.QtdLinhas;
  ProCadastro.FieldByName('I_QTD_COL').AsInteger := VpaDProduto.QtdColunas;

//detectores de metal
  ProCadastro.FieldByName('C_ABE_CAB').AsString := VpaDProduto.AberturaCabeca;
  ProCadastro.FieldByName('C_CON_ELE').AsString := VpaDProduto.ConsumoEletrico;
  ProCadastro.FieldByName('C_TEN_ALI').AsString := VpaDProduto.TensaoAlimentacao;
  ProCadastro.FieldByName('C_COM_RED').AsString := VpaDProduto.ComunicacaoRede;
  ProCadastro.FieldByName('C_GRA_PRO').AsString := VpaDProduto.GrauProtecao;
  ProCadastro.FieldByName('C_SEN_FER').AsString := VpaDProduto.SensibilidadeFerrosos;
  ProCadastro.FieldByName('C_SEN_NFE').AsString := VpaDProduto.SensibilidadeNaoFerrosos;
  ProCadastro.FieldByName('C_ACO_INO').AsString := VpaDProduto.AcoInoxidavel;
  ProCadastro.FieldByName('L_DES_FUN').AsString := VpaDProduto.DescritivoFuncDetectoresMetal;
  ProCadastro.FieldByName('L_INF_DIS').AsString := VpaDProduto.InfDisplayDetectoresMetal;

// Cartuchos
  ProCadastro.FieldByName('I_PES_CVA').AsInteger:= VpaDProduto.PesCartuchoVazio;
  ProCadastro.FieldByName('I_PES_CCH').AsInteger:= VpaDProduto.PesCartucho;
  ProCadastro.FieldByName('I_QTD_MLC').AsInteger:= VpaDProduto.QtdMlCartucho;
  ProCadastro.FieldByName('I_QTD_PAG').AsInteger:= VpaDProduto.QtdPaginas;

// Embalagem PVC
  ProCadastro.FieldByName('I_TIP_EMB').AsInteger:= RNumEmbalagemPvc(VpaDProduto.TipEmbalagem);
  ProCadastro.FieldByName('I_PLA_EMB').AsInteger:= VpaDProduto.SeqProdutoPlastico;
  ProCadastro.FieldByName('I_PLS_EMB').AsInteger:= VpaDProduto.SeqProdutoPlastico2;
  ProCadastro.FieldByName('I_FER_EMB').AsInteger:= VpaDProduto.CodFerramentaFaca;
  ProCadastro.FieldByName('C_LAR_EMB').AsString:= VpaDProduto.DesLarPvc;
  ProCadastro.FieldByName('C_ALT_EMB').AsString:= VpaDProduto.DesAltPvc;
  ProCadastro.FieldByName('C_FUN_EMB').AsString:= VpaDProduto.DesComFunPvc;
  ProCadastro.FieldByName('C_ABA_EMB').AsString:= VpaDProduto.DesComAbaPvc;
  ProCadastro.FieldByName('C_DIA_EMB').AsString:= VpaDProduto.DesComDiametroPvc;
  ProCadastro.FieldByName('C_PEN_EMB').AsString:= VpaDProduto.DesComPendurico;
  ProCadastro.FieldByName('C_LAM_ZIP').AsString:= VpaDProduto.ComLaminaZiper;
  ProCadastro.FieldByName('C_LAM_ABA').AsString:= VpaDProduto.ComLaminaAba;
  ProCadastro.FieldByName('C_FOT_NRO').AsString:= VpaDProduto.desFotolito;
  case VpaDProduto.InternoExterno of
    inInterno : ProCadastro.FieldByName('C_IND_IEX').AsString:= 'I';
    inExterno : ProCadastro.FieldByName('C_IND_IEX').AsString:= 'E';
  end;
  ProCadastro.FieldByName('I_TAM_ZIP').AsInteger:= VpaDProduto.TamZiper;
  ProCadastro.FieldByName('I_COR_ZIP').AsInteger:= VpaDProduto.CodCorZiper;
  ProCadastro.FieldByName('I_ALC_EMB').AsInteger:= RNumAlcaEmbalagemPvc(VpaDProduto.Alca);
  ProCadastro.FieldByName('I_IMP_EMB').AsInteger:= RNumImpEmbalagemPvc(VpaDProduto.Impressao);
  ProCadastro.FieldByName('I_CBD_EMB').AsInteger:= RNumCabEmbalagemPvc(VpaDProduto.Cabide);
  ProCadastro.FieldByName('I_SIM_CAB').AsInteger:= RNumCorCabEmbalagemPvc(VpaDProduto.SimCabide);
  ProCadastro.FieldByName('I_BOT_EMB').AsInteger:= RNumBotaoEmbalagemPvc(VpaDProduto.Botao);
  ProCadastro.FieldByName('I_COR_BOT').AsInteger:= RNumCorBotaoEmbalagemPvc(VpaDProduto.CorBotao);
  ProCadastro.FieldByName('I_BOL_EMB').AsInteger:= RNumBolineEmbalagemPvc(VpaDProduto.Boline);
  ProCadastro.FieldByName('I_ZPE_EMB').AsInteger:= RNumZiperEmbalagemPvc(VpaDProduto.Ziper);
  ProCadastro.FieldByName('I_COD_VIE').AsInteger:= RNumViesEmbalagemPvc(VpaDProduto.Vies);
  ProCadastro.FieldByName('C_LOC_ALC').AsString:= VpaDProduto.DesLocalAlca;
  ProCadastro.FieldByName('C_OBS_COR').AsString:= VpaDProduto.ObsCorte;
  ProCadastro.FieldByName('C_INT_EMB').AsString:= VpaDProduto.DesInterno;
  ProCadastro.FieldByName('C_INU_EMB').AsString:= VpaDProduto.DesInterno2;
  ProCadastro.FieldByName('C_LOC_INT').AsString:= VpaDProduto.DesLocalInt;
  ProCadastro.FieldByName('C_COR_IMP').AsString:= VpaDProduto.DesCoresImp;
  ProCadastro.FieldByName('C_OBS_BOT').AsString:= VpaDProduto.ObsBotao;
  ProCadastro.FieldByName('C_ADI_EMB').AsString:= VpaDProduto.DesAdicionaisPvc;
  ProCadastro.FieldByName('I_PRE_FAC').AsFloat:= VpaDProduto.ValPrecoFaccionista;
  ProCadastro.FieldByName('I_PRC_EMB').AsFloat:= VpaDProduto.ValPrecoPvc;
  ProCadastro.FieldByName('C_LOC_IMP').AsString:= VpaDProduto.DesLocalImp;
  if VpaDProduto.IndCorte then
    ProCadastro.FieldByName('C_IND_CRT').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_IND_CRT').AsString:= 'N';
  if VpaDProduto.IndBolso then
    ProCadastro.FieldByName('C_IND_BOL').AsString:='S'
  else
    ProCadastro.FieldByName('C_IND_BOL').AsString:='N';


  if VpaDProduto.CodCorCartucho <> 0 then
    ProCadastro.FieldByName('I_COD_COR').AsInteger:= VpaDProduto.CodCorCartucho
  else
    ProCadastro.FieldByName('I_COD_COR').Clear;

  ProCadastro.FieldByName('C_TIP_CAR').AsString:= VpaDProduto.DesTipoCartucho;
  if VpaDProduto.IndChipNovo then
    ProCadastro.FieldByName('C_CHI_NOV').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_CHI_NOV').AsString:= 'N';
  if VpaDProduto.IndCilindroNovo then
    ProCadastro.FieldByName('C_CIL_NOV').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_CIL_NOV').AsString:= 'N';
  if VpaDProduto.IndProdutoOriginal then
    ProCadastro.FieldByName('C_IND_ORI').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_IND_ORI').AsString:= 'N';
  if VpaDProduto.IndCartuchoTexto then
    ProCadastro.FieldByName('C_CAR_TEX').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_CAR_TEX').AsString:= 'N';
  if VpaDProduto.IndProdutoCompativel then
    ProCadastro.FieldByName('C_IND_COM').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_IND_COM').AsString:= 'N';

//Maquinas Rotuladoras
  ProCadastro.FieldByName('C_DES_COM').AsString:= VpaDProduto.DesComercial;
  ProCadastro.FieldByName('C_INF_TEC').AsString:= VpaDProduto.DesInfoTecnica;

// Dados que se repetem para várias páginas. Ex.: Largura Produto
  ProCadastro.FieldByName('I_LRG_PRO').AsInteger:= VpaDProduto.LarProduto;
  ProCadastro.FieldByName('I_CMP_PRO').AsInteger:= VpaDProduto.CmpProduto;
  ProCadastro.FieldByName('C_NUM_FIO').AsString:= VpaDProduto.NumFios;
  ProCadastro.FieldByName('METMIN').AsInteger:= VpaDProduto.MetrosPorMinuto;
  ProCadastro.FieldByName('ENGPRO').AsString:= VpaDProduto.Engrenagem;
  ProCadastro.FieldByName('C_PRA_PRO').AsString:= VpaDProduto.PraProduto;
  ProCadastro.FieldByName('C_ENG_EPE').AsString:= VpaDProduto.EngrenagemEspPequena;
  ProCadastro.FieldByName('C_TIP_IMP').AsString:= VpaDProduto.DesTipTear;
  ProCadastro.FieldByName('C_COD_CTB').AsString:= VpaDProduto.CodReduzidoCartucho;

// Campos inicializados manualmente
  ProCadastro.FieldByName('C_VEN_AVU').AsString:= 'S';
  if VpaDProduto.IndKit then
    ProCadastro.FieldByName('C_KIT_PRO').AsString:= 'K'
  else
    ProCadastro.FieldByName('C_KIT_PRO').AsString:= 'P';
  ProCadastro.FieldByName('C_FLA_PRO').AsString:= 'N';
  ProCadastro.FieldByName('C_IND_GEN').AsString:= 'N';
  ProCadastro.FieldByName('C_TIP_CLA').AsString:= 'P';

// Novo Cadastro
  if ProCadastro.State = dsInsert then
  begin
    ProCadastro.FieldByName('D_DAT_CAD').AsDateTime:= Now;
    VpaDProduto.SeqProduto:= FunProdutos.RSeqProdutoDisponivel;
  end;

  ProCadastro.FieldByName('I_SEQ_PRO').AsInteger:= VpaDProduto.SeqProduto;
  Sistema.MarcaTabelaParaImportar('CADPRODUTOS');

  // Cadarço de Fitas
  ProCadastro.FieldByName('C_SIS_TEA').AsString := VpaDProduto.SistemaTear;
  ProCadastro.FieldByName('C_BCM_TEA').AsString := VpaDProduto.BatidasPorCm;
  ProCadastro.FieldByName('C_IND_PRE').AsString := VpaDProduto.IndPreEncolhido;
  ProCadastro.FieldByName('C_ENG_TRA').AsString := VpaDProduto.EngrenagemTrama;

  //Orcamento cadarco
  case VpaDProduto.TipoCadarco of
    tcConvencional: ProCadastro.FieldByName('I_TIP_PRO').AsInteger := 0;
    tcCroche: ProCadastro.FieldByName('I_TIP_PRO').AsInteger := 1;
    tcRenda: ProCadastro.FieldByName('I_TIP_PRO').AsInteger := 2;
    tcElastico: ProCadastro.FieldByName('I_TIP_PRO').AsInteger := 3;
  end;

  ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
  ProCadastro.Post;
  result:= ProCadastro.AMensagemErroGravacao;
  if Result = '' then
  begin
    Result:= GravaLogProduto(VpaDProduto.SeqProduto, VpaDProduto.CodProduto);
  end;
  ProCadastro.Close;
end;
{******************************************************************************}
function TFuncoesProduto.GravaDProdutoInstalacaoTear(VpaDProduto: TRBDProduto; VpaGrade: TRBStringGridColor): string;
var
  vpfLacoColuna, VpfLacoLinha, VpfSeqInstalacao : Integer;
  VpfDInstalacaoTear : TRBDProdutoInstalacaoTear;
begin
  result := '';
  VpfSeqInstalacao := 0;
  ExecutaComandoSql(AUX,'Delete from PRODUTOINSTALACAOTEAR '+
                        ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOINSTALACAOTEAR '+
                                    ' WHERE SEQPRODUTO = 0 AND SEQINSTALACAO = 0');
  for vpfLacoColuna := 0 to VpaGrade.ColCount - 1 do
  begin
    for VpfLacoLinha := 0 to VpaGrade.RowCount - 1 do
    begin
      if VpaGrade.Objects[vpfLacoColuna,VpfLacoLinha] is TRBDProdutoInstalacaoTear then
      begin
        VpfDInstalacaoTear := TRBDProdutoInstalacaoTear(VpaGrade.Objects[vpfLacoColuna,VpfLacoLinha]);
        inc(VpfSeqInstalacao);
        ProCadastro.Insert;
        ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
        ProCadastro.FieldByName('SEQINSTALACAO').AsInteger := VpfSeqInstalacao;
        ProCadastro.FieldByName('SEQMATERIAPRIMA').AsInteger := VpfDInstalacaoTear.SeqProduto;
        if VpfDInstalacaoTear.CodCor <> 0 then
          ProCadastro.FieldByName('CODCOR').AsInteger := VpfDInstalacaoTear.CodCor;
        ProCadastro.FieldByName('QTDFIOLICO').AsInteger := VpfDInstalacaoTear.QtdFiosLico;
        ProCadastro.FieldByName('NUMLINHA').AsInteger := VpfLacoLinha+1;
        ProCadastro.FieldByName('NUMCOLUNA').AsInteger := vpfLacoColuna + 1;
        case VpfDInstalacaoTear.FuncaoFio of
          ffUrdume: ProCadastro.FieldByName('DESFUNCAOFIO').AsString := 'U';
          ffAjuda: ProCadastro.FieldByName('DESFUNCAOFIO').AsString := 'J';
          ffAmarracao:ProCadastro.FieldByName('DESFUNCAOFIO').AsString := 'M';
        end;
        ProCadastro.post;
        result := ProCadastro.AMensagemErroGravacao;
        if ProCadastro.AErronaGravacao then
          break;
      end;
    end;
  end;
  ProCadastro.Close;
  if result = '' then
  begin
    Result := GravaDProdutoInstalacaoTearRepeticao(VpaDProduto);
  end;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDProdutoInstalacaoTearRepeticao(VpaDProduto: TRBDProduto): string;
var
  VpfLaco : Integer;
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
begin
  result := '';
  ExecutaComandoSql(AUX,'DELETE FROM PRODUTOINSTALACAOTEARREPETICAO ' +
                        ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM PRODUTOINSTALACAOTEARREPETICAO ' +
                                    ' Where SEQPRODUTO = 0 AND SEQREPETICAO = 0 ');

  for VpfLaco := 0 to VpaDProduto.DInstalacaoCorTear.Repeticoes.Count - 1 do
  begin
    VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VpaDProduto.DInstalacaoCorTear.Repeticoes.Items[VpfLaco]);
    VpfDRepeticao.SeqRepeticao :=  VpfLaco + 1;
    ProCadastro.Insert;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('SEQREPETICAO').AsInteger := VpfDRepeticao.SeqRepeticao;
    ProCadastro.FieldByName('COLINICIAL').AsInteger := VpfDRepeticao.NumColunaInicial;
    ProCadastro.FieldByName('COLFINAL').AsInteger := VpfDRepeticao.NumColunaFinal;
    ProCadastro.FieldByName('QTDREPETICAO').AsInteger := VpfDRepeticao.QtdRepeticao;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarCodNomProduto(VpaSeqproduto : Integer;var VpaCodProduto,VpaNomProduto : string);
begin
  AdicionaSQLAbreTabela(Aux,'Select C_COD_PRO, C_NOM_PRO from CADPRODUTOS ' +
                            '  Where I_SEQ_PRO = ' +IntToStr(VpaSeqproduto));
  VpaCodProduto := Aux.FieldByname('C_COD_PRO').AsString;
  VpaNomProduto := Aux.FieldByname('C_NOM_PRO').AsString;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarProdutoFaturadosnoMes(VpaDatInicio, VpaDatFim : TDateTime;VpaFilial : Integer);
var
  VpfSeqProdutoAtual : Integer;
begin
  ExecutaComandoSql(Aux,'Delete from REL_PRODUTO_VENDIDO_MES');
  AdicionaSQLAbreTabela(ProCadastro,'Select * from REL_PRODUTO_VENDIDO_MES');
  AdicionaSqlAbreTabela(ProProduto,'select SUM(MOV.N_QTD_PRO) QTD, MOV.I_SEQ_PRO, MOV.C_COD_UNI,  PRO.C_COD_UNI UNIORIGINAL '+
                                   ' from CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                                   ' and CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                                   ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                   ' AND CAD.I_EMP_FIL = '+IntToStr(VpaFilial)+
                                   ' AND CAD.D_DAT_EMI >= ' + SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                   ' AND CAD.D_DAT_EMI <= ' + SQLTextoDataAAAAMMMDD(VpaDatFim)+
                                   ' GROUP BY MOV.I_SEQ_PRO, MOV.C_COD_UNI, PRO.C_COD_UNI ');
  VpfSeqProdutoAtual := -1;
  While not ProProduto.Eof do
  begin
    if ProProduto.FieldByName('I_SEQ_PRO').AsInteger <> VpfSeqProdutoAtual then
    begin
      if VpfSeqProdutoAtual <> - 1 then
      begin
        ProCadastro.Post;
      end;
      ProCadastro.Insert;
      ProCadastro.FieldByName('SEQ_PRODUTO').AsInteger := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      ProCadastro.FieldByName('QTD_VENDIDA').AsFloat := 0;
      ProCadastro.FieldByName('UM_PRODUTO').AsString := ProProduto.FieldByName('UNIORIGINAL').AsString;
    end;
    ProCadastro.FieldByName('QTD_VENDIDA').AsFloat := ProCadastro.FieldByName('QTD_VENDIDA').AsFloat + CalculaQdadePadrao(ProProduto.FieldByName('C_COD_UNI').AsString,ProProduto.FieldByName('UNIORIGINAL').AsString,ProProduto.FieldByName('QTD').AsFloat,ProProduto.FieldByName('I_SEQ_PRO').AsString);
    ProProduto.Next;
  end;
  if ProCadastro.State = dsinsert then
    ProCadastro.Post;
end;

{******************************************************************************}
function TFuncoesProduto.RMateriPrimaOrcamentoCadarco(VpadProduto: TRBDProduto;VpaSeqMateriaPrima : Integer): TRBDProdutoFioOrcamentoCadarco;
var
  VpfLaco : Integer;
  VpfDFio : TRBDProdutoFioOrcamentoCadarco;
begin
  result := nil;
  for VpfLaco := 0 to VpadProduto.FiosOrcamentoCadarco.Count - 1 do
  begin
    VpfDFio := TRBDProdutoFioOrcamentoCadarco(VpadProduto.FiosOrcamentoCadarco.Items[VpfLaco]);
    if VpaSeqMateriaPrima = VpfDFio.SeqProduto then
    begin
      result := VpfDFio;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RMoedaProduto(VpaCodEmpresa, VpaSeqProduto : String) : integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_MOE from CADPRODUTOS '+
                            ' WHERE I_COD_EMP = '+ VpaCodEmpresa +
                            ' and I_SEQ_PRO = ' + VpaSeqProduto);
  RESUlt := aux.FieldByName('I_COD_MOE').AsInteger;
end;

{******************************************************************************}
function TFuncoesProduto.RCombinacao(VpaDProduto : TRBDProduto;VpaCodCombinacao : Integer):TRBDCombinacao;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDProduto.Combinacoes.Count - 1 do
  begin
    if TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]).CodCombinacao = VpaCodCombinacao then
    begin
      result := TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]);
      exit;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqReferenciaDisponivel(VpaSeqProduto, VpaCodCliente : Integer): Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQ_REFERENCIA) ULTIMO from PRODUTO_REFERENCIA '+
                            ' Where SEQ_PRODUTO = '+IntTostr(VpaSeqProduto)+
                            ' and COD_CLIENTE = '+IntToStr(VpaCodCliente));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqReservaExcessoDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQRESERVA) ULTIMO from PRODUTORESERVADOEMEXCESSO');
  result :=  Aux.FieldByName('ULTIMO').AsInteger+1;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqReservaProdutoDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQRESERVA) ULTIMO from RESERVAPRODUTO');
  result :=  Aux.FieldByName('ULTIMO').AsInteger+1;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSimCabEmbalagemPvc(
  VpaSimEmbalagemPvc: integer): TRBDSimCabEmbalagemPvc;
begin
  case VpaSimEmbalagemPvc of
    0 : result := seEmBranco;
    1 : result := seLado;
    2 : result := seOposto;
    3 : result := seLateral;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RReferenciaProduto(VpaSeqProduto,VpaCodCliente : Integer; VpaCodCor : String):String;
begin
  Aux.Sql.Clear;
  Aux.Sql.Add('Select DES_REFERENCIA from PRODUTO_REFERENCIA '+
              ' Where SEQ_PRODUTO = '+ IntToStr(VpaSeqProduto)+
              ' and COD_CLIENTE = '+ IntToStr(VpaCodCliente));
  if (VpaCodCor <> '0') and (VpaCodCor <> '') then
    Aux.Sql.Add('and COD_COR = '+ VpaCodCor)
  else
    Aux.Sql.Add('and '+SQLTextoIsnull('COD_COR','0')+ '= 0');

  Aux.Open;
  result := Aux.FieldByName('DES_REFERENCIA').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.CarProdutodaReferencia(VpaDesReferencia : String;VpaCodCliente : Integer;Var VpaCodProduto : String; Var VpaCodCor : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select PRO.C_COD_PRO, COD_COR ' +
                            ' FROM CADPRODUTOS PRO, PRODUTO_REFERENCIA REF  '+
                            ' Where REF.DES_REFERENCIA = '''+VpaDesReferencia+''''+
                            ' and REF.COD_CLIENTE = '+IntToStr(VpaCodCliente)+
                            ' and PRO.I_SEQ_PRO = REF.SEQ_PRODUTO');
  result := not Aux.Eof;
  if result then
  begin
    VpaCodProduto := AUX.FieldByName('C_COD_PRO').AsString;
    VpaCodCor := Aux.FieldByName('COD_COR').AsInteger;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RDesMMProduto(var VpaNomProduto : String) :String;
var
  VpfPosicao, VpfPosFinal : Integer;
begin
  result := '';
  VpfPosicao := pos('MM',UpperCase(VpaNomProduto));
  if VpfPosicao <= 0 then
    VpfPosicao := length(vpanomProduto);
  if VpfPosicao > 0 then
  begin
    VpfPosFinal := VpfPosicao + 1;
    dec(VpfPosicao);
    While (VpfPosicao > 1) and (VpaNomProduto[VpfPosicao] = ' ') do //retira os espacos entre o numero e o mm exemplo = 1 mm
      Dec(VpfPosicao);

    While (VpfPosicao > 1) and (VpaNomProduto[VpfPosicao] in ['0'..'9',',']) do //procura o inicio dos numeros
      Dec(VpfPosicao);

    result := copy(VpaNomProduto,VpfPosicao+1,VpfPosFinal - VpfPosicao); //retorna os mm

    if VpaNomProduto[VpfPosicao] = '(' then
    begin
      dec(VpfPosicao);
      inc(VpfPosFinal);
    end;
    delete(VpaNomProduto,VpfPosicao+1,VpfPosfinal-VpfPosicao);
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RComprimentoProduto(VpaSeqProduto : Integer):Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_CMP_PRO  from CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  result := Aux.FieldByName('I_CMP_PRO').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RCorBotaoEmbalagemPvc(
  VpaCorBotaoEmbalagem: integer): TRBDCorBotaoEmbalagemPvc;
begin
  case VpaCorBotaoEmbalagem of
    0 : result := cbEmBranco;
    1 : result := cbeBranco;
    2 : result := cbePreto;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.REstagioProduto(VpaDProduto : TRBDProduto;VpaSeqEstagio : Integer):TRBDEstagioProduto;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDProduto.Estagios.Count - 1 do
  begin
    result := TRBDEstagioProduto(VpaDProduto.Estagios.Items[Vpflaco]);
    if Result.SeqEstagio = VpaSeqEstagio then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomePrincipioAtivo(VpaCodPrincipio : Integer) : String;
begin
  if VpaCodPrincipio <> 0 then
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from PRINCIPIOATIVO '+
                              ' Where CODPRINCIPIO = '+IntToStr(VpaCodPrincipio));
    result := Aux.FieldByName('NOMPRINCIPIO').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeProduto(VpaSeqProduto : Integer) : String;
begin
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQLAbreTabela(AUX,'Select C_NOM_PRO from CADPRODUTOS '+
                              ' where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
    result := Aux.FieldByname('C_NOM_PRO').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeClassificacao(VpaCodEmpresa : Integer;VpaCodClasssificacao : String):string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_CLA from CADCLASSIFICACAO '+
                            ' Where I_COD_EMP = '+IntToStr(VpaCodEmpresa)+
                            ' and C_COD_CLA = '''+VpaCodClasssificacao+'''');
  Result := Aux.FieldByName('C_NOM_CLA').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeComposicao(VpaCodComposicao : Integer):string;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMCOMPOSICAO from COMPOSICAO '+
                            ' Where CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
  Result := Aux.FieldByName('NOMCOMPOSICAO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RAlcaEmbalagemPvc(
  VpaAlcaEmbalagemPvc: integer): TRBDAlcaEmbalagemPvc;
begin
  case VpaAlcaEmbalagemPvc of
    0 : result := aeEmBranco;
    1 : result := aeSemAlca;
    2 : result := aePadrao;
    3 : result := aePequeno;
    4 : Result := aeGrande;
    5 : Result := aeCosturada;
    6 : Result := aeAlcaFita;
    7 : result := aeAlcaSilicone;
  end;
end;
{******************************************************************************}
function TFuncoesProduto.RAlturaProduto(VpaSeqProduto : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_ALT_PRO from CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  result := Aux.FieldByname('I_ALT_PRO').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RBolineEmbalagemPvc(
  VpaBolineEmbalagem: integer): TRBDBolineEmbalagemPvc;
begin
  case VpaBolineEmbalagem of
    0 : result := boEmBranco;
    1 : result := boNao;
    2 : result := bo1;
    3 : result := bo2;
    4 : result := bo3;
    5 : result := boLiner;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RBotaoEmbalagemPvc(
  VpaBotaoEmbalagemPvc: integer): TRBDBotaoEmbalagemPvc;
begin
  case VpaBotaoEmbalagemPvc of
    0 : result := beEmBranco;
    1 : result := beNao;
    2 : result := be1;
    3 : result := be2;
    4 : result := be3;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarUnidadesVenda(VpaUnidades: TStrings);
begin
  AdicionaSQLAbreTabela(AUX,'SELECT * FROM CADUNIDADE');
  while not AUX.Eof do
  begin
    VpaUnidades.Add(AUX.FieldByName('C_COD_UNI').AsString);
    AUX.Next;
  end;
  AUX.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarValVendaeRevendaProduto(VpaCodTabelaPreco, VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaCodCliente : Integer; var VpaValVenda,VpaValRevenda: Double;Var VpaValTabelaPreco, VpaPerMaximoDesconto : Double);
begin
  AdicionaSQLAbreTabela(AUX,'Select PRE.I_COD_CLI,  (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                            ' (Pre.N_VLR_REV * Moe.N_Vlr_Dia) VlrRevenda, PRE.N_PER_MAX ' +
                            ' from MOVTABELAPRECO PRE, CADMOEDAS MOE '+
                            ' Where PRE.I_COD_MOE = MOE.I_COD_MOE '+
                            ' AND PRE.I_COD_MOE = '+IntToStr(Varia.MoedaBase) +
                            ' and PRE.I_COD_EMP = ' + IntToStr(VARIA.CodigoEmpresa)+
                            ' and PRE.I_COD_TAB = ' + IntToStr(VpaCodTabelaPreco)+
                            ' and PRE.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and PRE.I_COD_CLI in (0,'+ IntToStr(VpaCodCliente)+')'+
                            ' and PRE.I_COD_COR = ' + IntToStr(VpaCodCor)+
                            ' and PRE.I_COD_TAM = ' + IntToStr(VpaCodTamanho)+
                            ' ORDER BY PRE.I_COD_CLI DESC');
  VpaValVenda := AUX.FieldByName('VLRREAL').AsFloat;
  VpaValRevenda := AUX.FieldByName('VlrRevenda').AsFloat;
  if AUX.FieldByName('N_PER_MAX').AsFloat > 0 then

  VpaPerMaximoDesconto := AUX.FieldByName('N_PER_MAX').AsFloat;
  while not AUX.Eof  do
  begin
    if AUX.FieldByName('I_COD_CLI').AsInteger = 0 then
    begin
        VpaValTabelaPreco := AUX.FieldByName('VLRREAL').AsFloat;
        break;
    end;
    aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RUMMTCMBR(VpaCodUnidade: String): string;
begin
  result := VpaCodUnidade;
  if config.ConverterMTeCMparaMM then
    if (VpaCodUnidade = varia.UnidadeBarra) or
       (VpaCodUnidade = 'MT') then
      result := 'MM';
end;

{******************************************************************************}
function TFuncoesProduto.RUnidadesParentes(VpaUM : String):TStringList;
begin
  result := ValidaUnidade.UnidadesParentes(VpaUM);
end;

{******************************************************************************}
function TFuncoesProduto.RSeqCartuchoDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_CAR from CFG_GERAL');
  Result := Aux.FieldByname('I_SEQ_CAR').AsInteger + 1;
  Aux.close;
  ExecutaComandoSql(AUX,'UPDATE CFG_GERAL SET I_SEQ_CAR = '+IntToStr(Result));
end;

{******************************************************************************}
function TFuncoesProduto.RSeqChapaDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQCHAPA) ULTIMO  from ESTOQUECHAPA');
  result := AUX.FieldByName('ULTIMO').AsInteger+1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdConsumidoProducao(VpaCodFilial, VpaSeqProduto,VpaCodCor, VpaCodTamanho: Integer; VpaDatInicio,VpaDatFim: TDateTime): double;
begin
  result := 0;
  LimpaSQLTabela(Tabela);
  AdicionaSqlTabela(Tabela, 'SELECT OPE.I_COD_OPE, OPE.C_NOM_OPE, OPE.C_TIP_OPE, ' +
                            ' MOV.D_DAT_MOV, MOV.N_QTD_MOV, MOV.C_COD_UNI, MOV.I_COD_COR, MOV.I_COD_TAM, ' +
                            ' PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UNORIGINAL ' +
                            ' FROM MOVESTOQUEPRODUTOS MOV, CADOPERACAOESTOQUE OPE, CADPRODUTOS PRO ' +
                            ' WHERE MOV.I_COD_OPE = OPE.I_COD_OPE ' +
                            ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                            ' AND (C_FUN_OPE = ''SP'' OR C_FUN_OPE = ''EP'')' +
                            SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_MOV', VpaDatInicio, VpaDatFim, true)+
                            ' AND MOV.I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                            ' AND MOV.I_COD_COR = ' +IntToStr(VpaCodCor)+
                            ' AND '+SQLTextoIsNull('MOV.I_COD_TAM','0')+' = ' +IntToStr(VpaCodTamanho));
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(Tabela,'AND MOV.I_EMP_FIL = ' + IntToStr(VpaCodFilial));
  Tabela.Open;
  while not Tabela.Eof do
  begin
    if Tabela.FieldByName('C_TIP_OPE').AsString = 'S' then
      result := result + FunProdutos.CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString, tABELA.FieldByName('UNORIGINAL').AsString, Tabela.FieldByName('N_QTD_MOV').AsFloat, Tabela.FieldByName('I_SEQ_PRO').AsString)
    else
      result := result - FunProdutos.CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString, tABELA.FieldByName('UNORIGINAL').AsString, Tabela.FieldByName('N_QTD_MOV').AsFloat, Tabela.FieldByName('I_SEQ_PRO').AsString);
    Tabela.Next;
  end;
  Tabela.close;
end;

function TFuncoesProduto.RQtdEmbalagem(VpaCodEmbalagem: integer): integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select QTD_EMBALAGEM from EMBALAGEM '+
                            ' Where COD_EMBALAGEM = '+ IntToStr(VpaCodEmbalagem));
  result := Aux.FieldByname('QTD_EMBALAGEM').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdIdealEstoque(VpaCodFilial, VpaSeqProduto, VpaCodCor : Integer): Double;
begin
  AdicionaSqlAbreTabela(Aux,'Select N_QTD_PED from MOVQDADEPRODUTO '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                            ' and I_COD_COR = '+IntToStr(VpaCodCor));
  result := Aux.FieldByname('N_QTD_PED').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdMetrosFita(VpaCodProduto,VpaNomProduto, VpaCodUM : string;VpaQtdProduto,VpaComprimentoProduto : Double; Var VpfErro : string):Double;
begin
  result := 0;
  VpfErro := '';
  if UpperCase(VpaCodUM) = 'MT' then
    result := VpaQtdProduto
  else
    if UpperCase(VpaCodUM) = 'KM' then
      result := (VpaQtdProduto * 1000)
    else
      if UpperCase(VpaCodUM) = 'CM' then
        result := (VpaQtdProduto /100)
      else
      begin
        if VpaComprimentoProduto = 0 then
          VpfErro := 'Produto "'+VpaCodProduto+'-'+ VpaNomProduto+'", está cadastrado em "'+VpaCodUM+'", e não possui a quantidade de metros do cadastrada'
        else
          result := ((VpaQtdProduto * VpaComprimentoProduto)  /100);
      end;
end;

{******************************************************************************}
function TFuncoesProduto.RTabelaPreco(VpaDProduto : TRBDProduto;VpaCodTabela,VpaCodCliente,VpaCodTamanho,VpaCodMoeda : Integer): TRBDProdutoTabelaPreco;
var
  VpfLaco : Integer;
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  result := nil;
  for Vpflaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDTabelaPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLaco]);
    if (VpfDTabelaPreco.CodTabelaPreco = VpaCodTabela) and
       (VpfDTabelaPreco.CodTamanho = VpaCodTamanho) and
       (VpfDTabelaPreco.CodCliente = VpaCodCliente) and
       (VpfDTabelaPreco.CodMoeda = VpaCodMoeda) then
    begin
      result := VpfDTabelaPreco;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RTamanhoMaiorCodigoProduto: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'select max(length(c_cod_pro)) QTD from CADPRODUTOS');
  result := AUX.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RTipoDestinoProduto(VpaNumDestinoProduto: Integer): TRBDDestinoProduto;
begin
  case VpaNumDestinoProduto of
    0 : result := dpRevenda;
    1 : result := dpMateriaPrima;
    2 : result := dpEmbalagem;
    3 : result := dpProdutoEmProcesso;
    4 : result := dpProdutoAcabado;
    5 : result := dpSubProduto;
    6 : result := dpProdutoIntermediario;
    7 : result := dpMaterialdeUsoeConsumo;
    8 : result := dpAtivoImobilizado;
    9 : result := dpServicos;
    10 : result := dpOutrosInsumo;
    11 : result := dpOutras;
  end;
  if Config.FilialeUmaRevenda then
    result := dpRevenda;
end;

{******************************************************************************}
function TFuncoesProduto.RTipoEmbalagemPVC(
  VpaNumEmbalagemPvc: Integer): TRBDTipoEmbalagemPvc;
begin
  case VpaNumEmbalagemPvc of
    0 : result := teEmBranco;
    1 : result := teCosturado;
    2 : result := teSoldada;
    3 : result := teSoldadaZiper;
    4 : Result := teTnt;
    5 : Result := teMateriaPrima;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.CombinacaoDuplicada(VpaDProduto : TRBDProduto):Boolean;
var
  VpfLaco, VpfLaco2 : Integer;
  VpfDCombinacao : TRBDCombinacao;
begin
  result := false;
  for VpfLaco := 0 to VpaDProduto.Combinacoes.count - 1 do
  begin
    VpfDCombinacao := TRBDCombinacao(VpaDProduto.Combinacoes.Items[Vpflaco]);
    for VpfLaco2 := VpfLaco + 1 to VpaDProduto.Combinacoes.Count - 1 do
    begin
      if VpfDCombinacao.CodCombinacao = TRBDCombinacao(VpaDProduto.Combinacoes.Items[Vpflaco2]).CodCombinacao then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiCombinacoes(VpaSeqProduto : String);
begin
  ExecutaComandoSql(AUX,'Delete from COMBINACAOFIGURA '+
                        ' Where SEQPRO = '+VpaSeqProduto);
  ExecutaComandoSql(Aux,'Delete from COMBINACAO '+
                        ' Where SEQPRO = '+VpaSeqProduto);
end;

{******************************************************************************}
function TFuncoesProduto.ExcluiProdutoTabelaPreco(VpaCodtabela,VpaSeqProduto,VpaCodCliente : Integer):Boolean;
begin
  result :=  Confirmacao(CT_DeletaRegistro);
  if result then
  begin
    if VpaCodTabela = 0 then
    begin
      aviso('CODIGO DA TABELA DE PREÇO INVÁLIDA!!!'#13'É necessário informar o código da tabela de preço.');
      result := false;
    end;
    if result then
    begin
      ExecutaComandoSql(Aux,'Delete from MOVTABELAPRECO '+
                            ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                            ' and I_COD_TAB = '+ IntToStr(VpaCodTabela)+
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and I_COD_CLI = ' + IntToStr(VpaCodCliente));
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiMovimentoEstoque(VpaCodFilial,VpaLanEstoque,VpaSeqProduto : Integer);
begin
  ExecutaComandoSql(AUX,'Delete from movestoqueprodutos '+
                        ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                        ' and I_LAN_EST = '+ IntToStr(VpaLanEstoque)+
                        ' and I_SEQ_PRO = ' +IntToStr(VpaSeqProduto));
end;

{******************************************************************************}
function TFuncoesProduto.ExcluiProduto(VpaSeqProduto: Integer): string;
begin
   ExecutaComandoSql(Tabela,' DELETE FROM MOVESTOQUEPRODUTOS WHERE ' +
                       ' I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));
   ExecutaComandoSql(Tabela,' DELETE FROM MOVSUMARIZAESTOQUE WHERE ' +
                       ' I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));

   Sistema.GravaLogExclusao('MOVQDADEPRODUTO','Select * from MOVQDADEPRODUTO '+
                             ' Where I_SEQ_PRO =  '+ IntToStr(VpaSeqProduto));
   ExecutaComandoSql(Tabela,' DELETE FROM MOVQDADEPRODUTO WHERE ' +
                       ' I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) );

   ExecutaComandoSql(Tabela,' DELETE FROM MOVTABELAPRECO WHERE ' +
                       ' I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) );

   Sistema.GravaLogExclusao('MOVKIT','Select * from MOVKIT '+
                             ' Where I_PRO_KIT =  ' +IntToStr(VpaSeqProduto));
   ExecutaComandoSql(Tabela,'DELETE FROM MOVKIT '+
                                 ' Where I_PRO_KIT = '+ IntToStr(VpaSeqProduto));
   ExecutaComandoSql(Tabela,'DELETE FROM BRINDECLIENTE '+
                                 ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProduto));

   Sistema.GravaLogExclusao('CADPRODUTOS','Select * from CADPRODUTOS '+
                             ' Where I_SEQ_PRO =  ' +IntToStr(VpaSeqProduto));
   ExecutaComandoSql(Tabela,' DELETE FROM CADPRODUTOS WHERE ' +
                       ' I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) );
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiProdutoDuplicado(VpaSeqProdutoExcluir, VpaSeqProdutoDestino : Integer;VpaLog : TStrings);
begin
  VpaLog.Insert(0,'IMPORTANDO MOVKIT');
  ExecutaComandoSql(AUX,'UPDATE MOVKIT '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO MOVKITBASTIDOR');
  ExecutaComandoSql(AUX,'DELETE MOVKITBASTIDOR '+
                        ' Where SEQPRODUTOKIT = '+IntToStr(VpaSeqProdutoDestino));
  ExecutaComandoSql(AUX,'UPDATE MOVKITBASTIDOR '+
                        ' SET SEQPRODUTOKIT = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTOKIT = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO MOVIMENTAÇÃO DE ESTOQUE');
  ExecutaComandoSql(AUX,'UPDATE MOVESTOQUEPRODUTOS '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO ORCAMENTO');
  ExecutaComandoSql(AUX,'UPDATE MOVORCAMENTOS '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DA NOTA FISCAL');
  ExecutaComandoSql(AUX,'UPDATE MOVNOTASFISCAIS '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS NOTA FISCAL ENTRADA');
  ExecutaComandoSql(AUX,'UPDATE MOVNOTASFISCAISFOR '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORDEM PRODUCAO');
  ExecutaComandoSql(AUX,'UPDATE ORDEMPRODUCAOCORPO '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO COMBINACAO FIGURA');
  ExecutaComandoSql(AUX,'UPDATE COMBINACAOFIGURA '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO COMBINACAO');
  ExecutaComandoSql(AUX,'UPDATE COMBINACAO '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO OPITEMCADARCO');
  ExecutaComandoSql(AUX,'UPDATE OPITEMCADARCO '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO AMOSTRACONSUMO');
  ExecutaComandoSql(AUX,'UPDATE AMOSTRACONSUMO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORCAMENTOPARCIALITEM');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOPARCIALITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS ROTULADOS');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTAPRODUTOROTULADO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORDEM SERRA');
  ExecutaComandoSql(AUX,'UPDATE ORDEMSERRA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  ExecutaComandoSql(AUX,'UPDATE ORDEMSERRA '+
                        ' SET SEQMATERIAPRIMA = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQMATERIAPRIMA = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO FRACAO CONSUMO LOG');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPCONSUMOLOG '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO PLANO DE CORTE');
  ExecutaComandoSql(AUX,'UPDATE PLANOCORTEITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO ORCAMENTO COMPRA');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOCOMPRAITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS SEM QUANTIDADE DA PROPOSTA');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTAPRODUTOSEMQTD '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO CONTRATO');
  ExecutaComandoSql(AUX,'UPDATE CONTRATOITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO BRINDE CLIENTE');
  ExecutaComandoSql(AUX,'UPDATE BRINDECLIENTE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS LEITURA LOCAÇÃO');
  ExecutaComandoSql(AUX,'UPDATE LEITURALOCACAOITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS CLIENTE');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOCLIENTE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA TELEMARKETING');
  ExecutaComandoSql(AUX,'UPDATE TAREFATELEMARKETING '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ESTAGIO DA FRACAOOP');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPESTAGIO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO DO ROMANEIO');
  ExecutaComandoSql(AUX,'UPDATE ROMANEIOPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS DO CHAMADO');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PESO DO CARTUCHO');
  ExecutaComandoSql(AUX,'UPDATE PESOCARTUCHO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS DA PROPOSTA');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTAPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS DA IMPRESSORA');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOIMPRESSORA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO RESERVA');
  ExecutaComandoSql(AUX,'UPDATE PRODUTORESERVA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO DO PROSPECT');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOPROSPECT '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CONSUMO DA FRACAO');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPCONSUMO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORCAMENTOITEMCOMPOSE');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOITEMCOMPOSE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITEM PEDIDO COMPRA');
  ExecutaComandoSql(AUX,'UPDATE PEDIDOCOMPRAITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA TELEMARKETING');
  ExecutaComandoSql(AUX,'UPDATE TAREFAEMARKETING '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA TELEMARKETING PROSPECT');
  ExecutaComandoSql(AUX,'UPDATE TAREFATELEMARKETINGPROSPECT '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA EMARKETING PROSPECT');
  ExecutaComandoSql(AUX,'UPDATE TAREFAEMARKETINGPROSPECT '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITEM DA SOLICITAÇÃO DE COMPRA');
  ExecutaComandoSql(AUX,'UPDATE SOLICITACAOCOMPRAITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PROPOSTA LOCACACAO');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTALOCACAO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO FRACAOOP');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOP '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO FRACAOOPCOMPOSE');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPCOMPOSE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CHAMADOPRODUTOORCADO');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPRODUTOORCADO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CONSUMO ORDEM PRODUCAO');
  ExecutaComandoSql(AUX,'UPDATE ORDEMPRODUCAOCONSUMO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO FUSO');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOFUSO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PEDIDOCOMPRANOTAFISCALITEM');
  ExecutaComandoSql(AUX,'UPDATE PEDIDOCOMPRANOTAFISCALITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORDEMCOMPRAITEM');
  ExecutaComandoSql(AUX,'UPDATE ORDEMCORTEITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOINTERESSE');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOINTERESSECLIENTE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CHAMADOPRODUTOEXTRA');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPRODUTOEXTRA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CHAMADOPARCIALPRODUTO');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPARCIALPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORCAMENTOCOMRAFORNECEDORITEM');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOCOMPRAFORNECEDORITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO DEFEITO');
  ExecutaComandoSql(AUX,'UPDATE PRODUTODEFEITO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ESTOQUE CHAPA');
  ExecutaComandoSql(AUX,'UPDATE ESTOQUECHAPA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));

  //atualiza quantidade em estoque
  VpaLog.Insert(0,'IMPORTANDO AS QUANTIDADES DE ESTOQUE');
  ImportaEstoqueProdutAExcluir(VpaSeqProdutoExcluir,VpaSeqProdutoDestino);
  VpaLog.Insert(0,'IMPORTANDO OS PRODUTOS FORNECEDOR');
  ImportaProdutofornecedor(VpaSeqProdutoExcluir,VpaSeqProdutoDestino);
  VpaLog.Insert(0,'IMPORTANDO AS QUANTIDADES DO ESTOQUE DO TECNICO');
  ImportaEstoqueTecnico(VpaSeqProdutoExcluir,VpaSeqProdutoDestino);

  VpaLog.Insert(0,'EXCLUINDO ESTOQUE DO TECNICO');
  ExecutaComandoSql(Aux,'DELETE FROM ESTOQUETECNICO '+
                        ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO MOVKIT');
  ExecutaComandoSql(Aux,'DELETE FROM MOVKIT '+
                        ' Where I_PRO_KIT = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO QUANTIDADE DE ESTOQUE');
  ExecutaComandoSql(Aux,'DELETE FROM MOVQDADEPRODUTO '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO TABELA DE PREÇO');
  ExecutaComandoSql(Aux,'DELETE FROM MOVTABELAPRECO '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO ESTOQUE DO MOVSUMARIZAESTOQUE');
  ExecutaComandoSql(Aux,'DELETE FROM MOVSUMARIZAESTOQUE '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO ESTOQUE DO PRODUTOESTAGIO');
  ExecutaComandoSql(Aux,'DELETE FROM PRODUTOESTAGIO '+
                        ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO O PRODUTO');
  ExecutaComandoSql(Aux,'DELETE FROM CADPRODUTOS '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTAÇÃO REALIZADA COM SUCESSO.');
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiComposicaoFiguraGRF(VpaCodComposicao : Integer);
begin
  ExecutaComandoSql(AUX,'DELETE from COMPOSICAOFIGURAGRF ' +
                                     ' Where CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiEstoqueChapa(VpaCodFilial, VpaSeqNota: Integer);
begin
  ExecutaComandoSql(AUX,'Delete from ESTOQUECHAPA ' +
                        ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND SEQNOTAFORNECEDOR = '+IntToStr(VpaSeqNota));
end;

{******************************************************************************}
function TFuncoesProduto.ExcluiEstoqueReservaProduto(VpaSeqProduto,
  VpaCodCor: Integer; VpaQtdProduto: Double): String;
var
  VpfQtdReservada: Integer;
begin
  ProCadastro2.close;
  ProCadastro2.sql.clear;
  ProCadastro2.sql.add('Select * from movqdadeproduto '+
                      ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  if VpaCodCor <> 0 then
    ProCadastro2.sql.add('and I_COD_COR = '+IntToStr(VpaCodCor));
  ProCadastro2.open;
  VpfQtdReservada:= ProCadastro2.FieldByName('N_QTD_RES').AsInteger;
  if not ProCadastro2.eof then
  begin
    ProCadastro2.edit;
    ProCadastro2.FieldByName('N_QTD_RES').AsFloat := VpfQtdReservada - VpaQtdProduto;
    ProCadastro2.Post;
  end;
  ProCadastro2.close;
  result := '';
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiInstalacaoRepeticao(VpaDProduto: TRBDProduto; VpaColuna: Integer);
var
  VpfLaco : Integer;
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
begin
  for VpfLaco := VpaDProduto.DInstalacaoCorTear.Repeticoes.Count -1 downto 0 do
  begin
    VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VpaDProduto.DInstalacaoCorTear.Repeticoes.Items[VpfLaco]);
    if (VpaColuna >= VpfDRepeticao.NumColunaInicial) and
       (VpaColuna <= VpfDRepeticao.NumColunaFinal) then
    begin
      VpaDProduto.DInstalacaoCorTear.Repeticoes.Delete(VpfLaco);
      VpfDRepeticao.Free;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDCombinacao(VpaDProduto : TRBDProduto):String;
Var
  VpfLaco, VpfLacoFigura : Integer;
  VpfDCombinacao : TRBDCombinacao;
  VpfDFigura : TRBDCombinacaoFigura;
begin
  result := '';
  ExcluiCombinacoes(IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * FROM COMBINACAO'+
                                    ' where SEQPRO = 0 AND CODCOM = 0');
  for VpfLaco := 0 to VpaDProduto.Combinacoes.count - 1 do
  begin
    VpfDCombinacao := TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('SEQPRO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODCOM').AsInteger := VpfDCombinacao.CodCombinacao;
    ProCadastro.FieldByName('CORFU1').AsString := VpfDCombinacao.CorFundo1;
    ProCadastro.FieldByName('CORFU2').AsString := VpfDCombinacao.CorFundo2;
    ProCadastro.FieldByName('TITFU1').AsString := VpfDCombinacao.TituloFundo1;
    ProCadastro.FieldByName('TITFU2').AsString := VpfDCombinacao.TituloFundo2;
    ProCadastro.FieldByName('ESPFU1').AsInteger := VpfDCombinacao.Espula1;
    ProCadastro.FieldByName('ESPFU2').AsInteger := VpfDCombinacao.Espula2;
    ProCadastro.FieldByName('CORCAR').AsInteger := VpfDCombinacao.CorCartela;
    ProCadastro.FieldByName('CORFUF').AsString := VpfDCombinacao.CorUrdumeFigura;
    ProCadastro.FieldByName('ESPFUF').AsInteger := VpfDCombinacao.EspulaUrdumeFigura;
    ProCadastro.FieldByName('TITFUF').AsString := VpfDCombinacao.TituloFundoFigura;

    ProCadastro.post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      exit;
  end;

  AdicionaSQLAbreTabela(ProCadastro,'Select * FROM COMBINACAOFIGURA'+
                                    ' Where SEQPRO = 0 AND CODCOM = 0 AND SEQCOR = 0');
  for VpfLaco := 0 to VpaDProduto.Combinacoes.count - 1 do
  begin
    VpfDCombinacao := TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]);
    for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
    begin
      VpfDFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);

      ProCadastro.Insert;
      ProCadastro.FieldByName('SEQPRO').AsInteger := VpaDProduto.SeqProduto;
      ProCadastro.FieldByName('CODCOM').AsInteger := VpfDCombinacao.CodCombinacao;
      ProCadastro.FieldByName('SEQCOR').AsInteger := VpfDFigura.SeqFigura;
      ProCadastro.FieldByName('CODCOR').AsString := VpfDFigura.CodCor;
      ProCadastro.FieldByName('TITFIO').AsString := VpfDFigura.TitFio;
      ProCadastro.FieldByName('NUMESP').AsInteger := VpfDFigura.NumEspula;
      ProCadastro.post;
      result := ProCadastro.AMensagemErroGravacao;
      if ProCadastro.AErronaGravacao then
        exit;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDMateriaPrimaOrcamentoCadarco(VpaDProduto: TRBDProduto): string;
Var
  VpfDFio : TRBDProdutoFioOrcamentoCadarco;
  VpfLaco : Integer;
begin
  if config.FabricadeCadarcosdeFitas then
  begin
    ExecutaComandoSql(AUX,'Delete FROM MATERIAPRIMAORCAMENTOCADARCO ' +
                          ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
    AdicionaSQLAbreTabela(ProCadastro,'Select * from MATERIAPRIMAORCAMENTOCADARCO ' +
                                      ' Where SEQPRODUTO = 0 AND SEQMATERIAPRIMA = 0');
    for VpfLaco := 0 to VpaDProduto.FiosOrcamentoCadarco.Count - 1 do
    begin
      VpfDFio := TRBDProdutoFioOrcamentoCadarco(VpaDProduto.FiosOrcamentoCadarco.Items[VpfLaco]);
      if VpfDFio.IndSelecionado then
      begin
        ProCadastro.Insert;
        ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
        ProCadastro.FieldByName('SEQMATERIAPRIMA').AsInteger := VpfDFio.SeqProduto;
        ProCadastro.FieldByName('QTDFIO').AsFloat := VpfDFio.PesFio;
        ProCadastro.Post;
        result := ProCadastro.AMensagemErroGravacao;
        if result <> '' then
          break;
      end;
    end;
    ProCadastro.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDMovimentoEstoque(VpaDMovimento : TRBDMovEstoque): String;
begin
  AdicionaSQLAbreTabela(ProCadastro, ' Select * From MovEstoqueProdutos '+
                                ' Where I_EMP_FIL = '+ IntToStr(VpaDMovimento.CodFilial)+
                                ' and I_LAN_EST = '+ IntToStr(VpaDMovimento.LanEstoque));
  if VpaDMovimento.LanEstoque = 0 then
    ProCadastro.Insert
  else
    ProCadastro.edit;
  ProCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDMovimento.CodFilial;
  ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaDMovimento.SeqProduto;
  ProCadastro.FieldByName('I_COD_OPE').AsInteger := VpaDMovimento.CodOperacaoEstoque;
  ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := VpaDMovimento.DatMovimento;
  ProCadastro.FieldByName('N_QTD_MOV').AsFloat := VpaDMovimento.QtdProduto;
  ProCadastro.FieldByName('C_TIP_MOV').AsString := VpaDMovimento.TipMovimento;
  ProCadastro.FieldByName('N_VLR_MOV').AsFloat := VpaDMovimento.ValMovimento;
  ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := date;
  ProCadastro.FieldByName('C_COD_UNI').AsString := VpaDMovimento.CodUnidade;
  ProCadastro.FieldByName('I_COD_COR').AsInteger := VpaDMovimento.CodCor;
  ProCadastro.FieldByName('N_VLR_CUS').AsFloat := VpaDMovimento.valCusto;

  if VpaDMovimento.NumNota <> 0 then
    ProCadastro.FieldByName('I_NRO_NOT').AsInteger := VpaDMovimento.NumNota
  else
    ProCadastro.FieldByName('I_NRO_NOT').clear;

  if VpaDMovimento.SeqNotaEntrada <> 0 then
      ProCadastro.FieldByName('I_NOT_ENT').AsInteger := VpaDMovimento.SeqNotaEntrada
  else
    if VpaDMovimento.SeqNotaSaida <> 0 then
      ProCadastro.FieldByName('I_NOT_SAI').AsInteger := VpaDMovimento.SeqNotaSaida;
  ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', VpaDMovimento.CodFilial, false,ProCadastro.ASQLConnection );
  ProCadastro.post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDCombinacao(VpaDProduto : TRBDProduto);
Var
  VpfDCombinacao : TRBDCombinacao;
  VpfDFigura : TRBDCombinacaoFigura;
begin
  AdicionaSQLAbreTabela(ProProduto,'Select * from COMBINACAO '+
                                   ' Where SEQPRO = '+ IntToStr(VpaDProduto.SeqProduto)+
                                   ' order by CODCOM');
  While not ProProduto.Eof do
  begin
    VpfDCombinacao := VpaDProduto.AddCombinacao;
    VpfDCombinacao.CodCombinacao := ProProduto.FieldByName('CODCOM').AsInteger;
    VpfDCombinacao.CorFundo1 := ProProduto.FieldByName('CORFU1').AsString;
    VpfDCombinacao.CorFundo2 := ProProduto.FieldByName('CORFU2').AsString;
    VpfDCombinacao.TituloFundo1 := ProProduto.FieldByName('TITFU1').AsString;
    VpfDCombinacao.TituloFundo2 := ProProduto.FieldByName('TITFU2').AsString;
    VpfDCombinacao.Espula1 := ProProduto.FieldByName('ESPFU1').AsInteger;
    VpfDCombinacao.Espula2 := ProProduto.FieldByName('ESPFU2').AsInteger;
    VpfDCombinacao.CorCartela := ProProduto.FieldByName('CORCAR').AsInteger;
    VpfDCombinacao.CorUrdumeFigura := ProProduto.FieldByName('CORFUF').AsString;
    VpfDCombinacao.EspulaUrdumeFigura := ProProduto.FieldByName('ESPFUF').AsInteger;
    VpfDCombinacao.TituloFundoFigura := ProProduto.FieldByName('TITFUF').AsString;

    AdicionaSQLAbreTabela(Tabela,'Select * from COMBINACAOFIGURA '+
                                 ' Where SEQPRO = '+ IntToStr(VpaDProduto.SeqProduto)+
                                 ' and CODCOM = '+IntToStr(VpfDCombinacao.CodCombinacao) +
                                 ' order by SEQCOR');
    While not Tabela.eof do
    begin
      VpfDFigura := VpfDCombinacao.AddFigura;
      VpfDFigura.SeqFigura := Tabela.FieldByName('SEQCOR').AsInteger;
      VpfDFigura.CodCor := Tabela.FieldByName('CODCOR').AsString;
      VpfDFigura.TitFio := Tabela.FieldByName('TITFIO').AsString;
      VpfDFigura.NumEspula := Tabela.FieldByName('NUMESP').AsInteger;
      Tabela.Next;
    end;
    ProProduto.next;
  end;
  ProProduto.close;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDEstagio(VpaDProduto : TRBDProduto);
Var
  VpfDEstagio :TRBDEstagioProduto;
begin
  FreeTObjectsList(VpaDProduto.Estagios);
  AdicionaSQLAbreTabela(ProProduto,'Select * from PRODUTOESTAGIO PRO, ESTAGIOPRODUCAO EST'+
                                   ' Where SEQPRODUTO = '+InttoStr(VpaDProduto.SeqProduto)+
                                   ' and PRO.CODESTAGIO = EST.CODEST'+
                                   ' order by PRO.SEQESTAGIO');
  While not ProProduto.Eof do
  begin
    VpfDEstagio := VpaDProduto.AddEstagio;
    VpfDEstagio.SeqEstagio := ProProduto.FieldByName('SEQESTAGIO').AsInteger;
    VpfDEstagio.NumOrdem := ProProduto.FieldByName('NUMORDEM').AsInteger;
    VpfDEstagio.CodEstagio := ProProduto.FieldByName('CODESTAGIO').AsInteger;
    VpfDEstagio.NomEstagio := ProProduto.FieldByName('NOMEST').AsString;
    VpfDEstagio.CodEstagioAnterior := ProProduto.FieldByName('CODESTAGIOANTERIOR').AsInteger;
    if VpfDEstagio.CodEstagioAnterior <> 0 then
      ExisteEstagio(IntTostr(VpfDEstagio.CodEstagioAnterior),VpfDEstagio.NomEstagioAnterior);
    VpfDEstagio.QtdEstagioAnterior := ProProduto.FieldByName('QTDESTAGIOANTERIOR').AsInteger;
    VpfDEstagio.DesEstagio := ProProduto.FieldByName('DESESTAGIO').AsString;
    VpfDEstagio.IndConfig := ProProduto.FieldByName('INDCONFIG').AsString;
    VpfDEstagio.DesTempoConfig := ProProduto.FieldByName('DESTEMPOCONFIG').AsString;
    VpfDEstagio.QtdProducaoHora := ProProduto.FieldByName('QTDPRODUCAOHORA').AsFloat;
    ProProduto.next;
  end;
  ProProduto.close;
end;

{******************************************************************************}
function TFuncoesProduto.ReferenciaProdutoDuplicada(VpaCodCliente,VpaSeqProduto,VpaSeqReferencia, VpaCodCor : Integer):Boolean;
begin
  Aux.Close;
  Aux.Sql.Clear;
  Aux.Sql.Add('Select * from PRODUTO_REFERENCIA '+
              ' Where SEQ_PRODUTO = '+IntToStr(VpaSeqProduto) +
              ' and COD_CLIENTE = '+ IntToStr(VpaCodCliente)+
              ' and SEQ_REFERENCIA <> '+ IntToStr(VpaSeqReferencia));
  if VpaCodCor <> 0 then
    Aux.Sql.Add(' and COD_COR = '+IntToStr(VpaCodCor));
  Aux.Open;
  result := not Aux.eof;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDConsumoMP(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoMP;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from MOVKITBASTIDOR '+
                        ' Where SEQPRODUTOKIT = '+ IntToStr(VpaDProduto.SeqProduto)+
                        ' and SEQCORKIT = '+IntToStr(VpaCorkit));
  ExecutaComandoSql(Aux,'Delete from MOVKIT '+
                        ' Where I_PRO_KIT = '+ IntToStr(VpaDProduto.SeqProduto)+
                        ' and I_COD_EMP = '+InttoStr(VpaDProduto.CodEmpresa)+
                        ' and I_COR_KIT = '+IntToStr(VpaCorkit));
  AdicionaSqlAbreTabela(ProCadastro,'Select * from MOVKIT '+
                                    ' Where I_PRO_KIT = 0 AND I_SEQ_MOV = 0 AND I_COR_KIT = 0 ');
  for VpfLaco := 0 to VpaDProduto.ConsumosMP.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_PRO_KIT').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COR_KIT').AsInteger := VpaCorKit;
    VpfDConsumo.SeqMovimento := VpfLaco + 1;
    ProCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfDConsumo.SeqMovimento;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfDConsumo.SeqProduto;
    procadastro.FieldByName('N_QTD_PRO').AsFloat := VpfDConsumo.QtdProduto;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger := VpaDProduto.CodEmpresa;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    if VpfDConsumo.CodCor <> 0 then
      ProCadastro.FieldByName('I_COD_COR').AsInteger := VpfDConsumo.CodCor;
    if VpfDConsumo.CodCor <> 0 then
      ProCadastro.FieldByName('I_COR_REF').AsInteger := VpfDConsumo.CorReferencia;

    ProCadastro.FieldByName('C_COD_UNI').AsString := UpperCase(VpfdConsumo.UM);

    ProCadastro.FieldByName('N_VLR_UNI').AsFloat:= VpfDConsumo.ValorUnitario;
    ProCadastro.FieldByName('N_VLR_TOT').AsFloat:= VpfDConsumo.ValorTotal;
    ProCadastro.FieldByName('N_PEC_MET').AsFloat:= VpfDConsumo.PecasMT;
    ProCadastro.FieldByName('N_IND_MET').AsFloat:= VpfDConsumo.IndiceMT;

    if VpfDConsumo.Faca.CodFaca <> 0 then
      ProCadastro.FieldByName('I_COD_FAC').AsInteger:= VpfDConsumo.Faca.CodFaca;

    if VpfDConsumo.AlturaMolde <> 0 then
      ProCadastro.FieldByName('I_ALT_MOL').AsFloat:= VpfDConsumo.AlturaMolde;
    if VpfDConsumo.LarguraMolde <> 0 then
      ProCadastro.FieldByName('I_LAR_MOL').AsFloat:= VpfDConsumo.LarguraMolde;
    if VpfDConsumo.Maquina.CodMaquina <> 0 then
      ProCadastro.FieldByName('I_COD_MAQ').AsInteger:= VpfDConsumo.Maquina.CodMaquina;
    if VpfDConsumo.SeqProdutoEntretela <> 0 then
      ProCadastro.FieldByName('I_SEQ_ENT').AsInteger:= VpfDConsumo.SeqProdutoEntretela;
    if VpfDConsumo.SeqProdutoTermoColante <> 0 then
      ProCadastro.FieldByName('I_SEQ_TER').AsInteger:= VpfDConsumo.SeqProdutoTermoColante;
    if VpfDConsumo.QtdEntretela <> 0 then
      ProCadastro.FieldByName('I_QTD_ENT').AsInteger:= VpfDConsumo.QtdEntretela;
    if VpfDConsumo.QtdTermoColante <> 0 then
      ProCadastro.FieldByName('I_QTD_TER').AsInteger:= VpfDConsumo.QtdTermoColante;
    if VpfDConsumo.DatDesenho > MontaData(1,1,1900) then
      ProCadastro.FieldByName('D_DAT_DES').AsDateTime := VpfDConsumo.DatDesenho;


    ProCadastro.FieldByName('C_DES_OBS').AsString := VpfdConsumo.DesObservacoes;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      exit;
  end;
  GravaLogConsumoProduto(VpaDProduto.SeqProduto, VpaCorKit,VpaDProduto.CodProduto);
  ProCadastro.Close;
  Sistema.MarcaTabelaParaImportar('MOVKIT');
  if Result = '' then
    GravaDConsumoMPBastidor(VpaDProduto,VpaCorKit);
end;

{******************************************************************************}
function TFuncoesProduto.GravaDEstagio(VpaDProduto : TRBDProduto) : String;
Var
  VpfLaco : Integer;
  VpfDEstagio : TRBDEstagioProduto;
begin
  result := '';
  ExecutaComandoSql(AUX,'DELETE FROM PRODUTOESTAGIO '+
                        ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOESTAGIO '+
                                    ' Where SEQPRODUTO = 0 AND SEQESTAGIO = 0');
  for VpfLaco := 0 to VpaDProduto.Estagios.Count - 1 do
  begin
    VpfDEstagio := TRBDEstagioProduto(VpaDProduto.Estagios.Items[VpfLaco]);
    ProCadastro.Insert;
    Procadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
    Procadastro.FieldByName('SEQESTAGIO').AsInteger := VpfDEstagio.SeqEstagio;
    Procadastro.FieldByName('NUMORDEM').AsInteger := VpfDEstagio.NumOrdem;
    Procadastro.FieldByName('CODESTAGIO').AsInteger := VpfDEstagio.CodEstagio;
    Procadastro.FieldByName('DESESTAGIO').AsString := VpfDEstagio.DesEstagio;
    Procadastro.FieldByName('QTDPRODUCAOHORA').AsFloat := VpfDEstagio.QtdProducaoHora;
    if VpfDEstagio.CodEstagioAnterior <> 0 then
      Procadastro.FieldByName('CODESTAGIOANTERIOR').AsInteger := VpfDEstagio.CodEstagioAnterior
    else
      Procadastro.FieldByName('CODESTAGIOANTERIOR').clear;
    Procadastro.FieldByName('INDCONFIG').AsString := VpfDEstagio.IndConfig;
    Procadastro.FieldByName('DESTEMPOCONFIG').AsString := VpfDEstagio.DesTempoConfig;
    Procadastro.FieldByName('QTDESTAGIOANTERIOR').AsInteger := VpfDEstagio.QtdEstagioAnterior;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDEstoqueChapa(VpaSeqProduto: Integer; VpaChapas: TList): string;
var
  vpfLaco : Integer;
  VpfDChapa : TRBDEStoqueChapa;
begin
  ExecutaComandoSql(AUX,'delete from ESTOQUECHAPA '+
                        ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUECHAPA '+
                                    ' Where SEQCHAPA = 0');
  for Vpflaco := 0 to VpaChapas.Count - 1 do
  begin
    VpfDChapa := TRBDEStoqueChapa(VpaChapas.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('SEQCHAPA').AsInteger := VpfDChapa.SeqChapa;
    ProCadastro.FieldByName('CODFILIAL').AsInteger := VpfDChapa.Codfilial;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
    ProCadastro.FieldByName('CODCOR').AsInteger := VpfDChapa.CodCor;
    ProCadastro.FieldByName('CODTAMANHO').AsInteger := VpfDChapa.CodTamanho;
    if VpfDChapa.SeqNotafornecedor <> 0 then
      ProCadastro.FieldByName('SEQNOTAFORNECEDOR').AsInteger := VpfDChapa.SeqNotafornecedor;
    ProCadastro.FieldByName('LARCHAPA').AsFloat := VpfDChapa.LarChapa;
    ProCadastro.FieldByName('COMCHAPA').AsFloat := VpfDChapa.ComChapa;
    ProCadastro.FieldByName('PERCHAPA').AsFloat := VpfDChapa.PerChapa;
    ProCadastro.FieldByName('PESCHAPA').AsFloat := VpfDChapa.PesChapa;
    ProCadastro.post;
    result := ProCadastro.AMensagemErroGravacao;
    if result <> '' then
      break;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaProdutoImpressoras(VpaSeqProduto : Integer; VpaImpressoras : TList):string;
var
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete PRODUTOIMPRESSORA '+
                        ' Where SEQPRODUTO = ' +IntToStr(VpaSeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOIMPRESSORA ');
  for VpfLaco := 0 to VpaImpressoras.count - 1 do
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByname('SEQPRODUTO').AsInteger := VpaSeqProduto;
    ProCadastro.FieldByname('SEQIMPRESSORA').AsInteger := TRBDProdutoImpressora(VpaImpressoras.Items[Vpflaco]).SeqImpressora;
    ProCadastro.FieldByname('DATULTIMAALTERACAO').AsDateTime := Sistema.RDataServidor;
    ProCadastro.post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  Sistema.MarcaTabelaParaImportar('PRODUTOIMPRESSORA');
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaProdutoReservadoEmExcesso(VpaSeqProduto, VpaCodFilial, VpaSeqOrdem: Integer; VpaDesUM: String; VpaQtdEstoque, VpaQtdReservado, VpaQtdExcesso: Double): String;
begin
  AdicionaSQLAbreTabela(ProCadastro2,'Select * from PRODUTORESERVADOEMEXCESSO '+
                                    ' Where SEQRESERVA = 0 ');
  ProCadastro2.Insert;
  ProCadastro2.FieldByName('DATRESERVA').AsDateTime := now;
  ProCadastro2.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  ProCadastro2.FieldByName('QTDESTOQUEPRODUTO').AsFloat := VpaQtdEstoque;
  ProCadastro2.FieldByName('QTDRESERVADO').AsFloat := VpaQtdReservado;
  ProCadastro2.FieldByName('QTDEXCESSO').AsFloat := VpaQtdExcesso;
  if VpaSeqOrdem <> 0 then
  begin
    ProCadastro2.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
    ProCadastro2.FieldByName('SEQORDEMPRODUCAO').AsInteger := VpaSeqOrdem;
  end;
  ProCadastro2.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  ProCadastro2.FieldByName('DESUM').AsString := VpaDesUM;
  ProCadastro2.FieldByName('SEQRESERVA').AsInteger := RSeqReservaExcessoDisponivel;
  ProCadastro2.Post;
  Result := ProCadastro2.AMensagemErroGravacao;
  ProCadastro2.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaPesoCartucho(VpaDPesoCartucho : TRBDPesoCartucho;VpaDProduto : TRBDProduto):string;
var
  VpfSeqBarra : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PESOCARTUCHO '+
                                    'Where SEQCARTUCHO = 0');
  ProCadastro.insert;
  ProCadastro.FieldByname('SEQCARTUCHO').AsInteger := VpaDPesoCartucho.SeqCartucho;
  ProCadastro.FieldByname('SEQPRODUTO').AsInteger := VpaDPesoCartucho.SeqProduto;
  ProCadastro.FieldByname('DATPESO').AsDateTime := VpaDPesoCartucho.DatPeso;
  ProCadastro.FieldByname('PESCARTUCHO').AsFloat := VpaDPesoCartucho.PesCartucho;
  ProCadastro.FieldByname('CODUSUARIO').AsInteger := VpaDPesoCartucho.CodUsuario;
  ProCadastro.FieldByname('CODCELULA').AsInteger := VpaDPesoCartucho.CodCelula;
  if VpaDPesoCartucho.SeqPo <> 0 then
    ProCadastro.FieldByname('SEQPRODUTOPO').AsInteger := VpaDPesoCartucho.SeqPo;
  if VpaDPesoCartucho.SeqCilindro <> 0 then
    ProCadastro.FieldByname('SEQPRODUTOCILINDRO').AsInteger := VpaDPesoCartucho.SeqCilindro;
  if VpaDPesoCartucho.SeqChip <> 0 then
    ProCadastro.FieldByname('SEQPRODUTOCHIP').AsInteger := VpaDPesoCartucho.SeqChip;

  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
  if result = '' then
    if not VpaDProduto.IndProdutoCompativel then
      BaixaProdutoEstoque(VpaDProduto,varia.CodigoEmpFil,varia.OperacaoEstoqueImpressaoEtiqueta,0,0,0,varia.MoedaBase,0,0,date,1,0,VpaDProduto.CodUnidade,'',false,VpfSeqBarra,true);
end;

{******************************************************************************}
function TFuncoesProduto.GravaBaixaConsumoProduto(VpaCodigoFilial, VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario: Integer;VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
begin
  if (VpaSeqFracao <> 0) and not(varia.TipoOrdemProducao = toSubMontagem) then
    result := GravaDBaixaConsumoFracaoProduto(VpaCodigoFilial,VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario, VpaBaixas)
  else
    result := GravaDBaixaConsumoOPProduto(VpaCodigoFilial,VpaSeqOrdem,VpaCodUsuario, VpaIndConsumoOrdemCorte, VpaBaixas);
end;

{******************************************************************************}
function TFuncoesProduto.GravaCodigoBarraProdutos(VpaCodFilial, VpaSeqProduto,VpaCodCor, VpaCodTamanho: Integer; VpaCodBarra: String): String;
var
  VpfResultado: String;
begin
  result := '';

  if Config.CodigodeBarraCodCorETamanhoZero then
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVQDADEPRODUTO '+
                                   ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                                   ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) +
                                   ' AND I_COD_COR = 0' +
                                   ' AND I_COD_TAM = 0');
  end
  else
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVQDADEPRODUTO '+
                                       ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                                       ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) +
                                       ' AND I_COD_COR = ' + IntToStr(VpaCodCor) +
                                       ' AND I_COD_TAM = ' + IntToStr(VpaCodTamanho));
  end;
  ProCadastro.Edit;
  ProCadastro.FieldByName('C_COD_BAR').AsString := VpaCodBarra;
  ProCadastro.FieldByName('D_ULT_ALT').AsDateTime :=  sistema.RDataServidor;
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  Sistema.MarcaTabelaParaImportar('MOVQDADEPRODUTO');
end;

{******************************************************************************}
function TFuncoesProduto.GravaFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList) : string;
var
  VpfLaco : Integer;
  VpfDFigura : TRBDFiguraGRF;
begin
  result := '';
  ExecutaComandoSql(AUX,'DELETE from COMPOSICAOFIGURAGRF ' +
                                     ' Where CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from COMPOSICAOFIGURAGRF '+
                                     ' Where CODCOMPOSICAO = 0 AND CODFIGURAGRF = 0 ');
  for Vpflaco := 0 to VpaFiguras.count - 1 do
  begin
    ProCadastro.Insert;
    VpfDFigura := TRBDFiguraGRF(VpaFiguras.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('CODCOMPOSICAO').AsInteger := VpaCodComposicao;
    ProCadastro.FieldByName('CODFIGURAGRF').AsInteger := VpfDFigura.CodFiguraGRF;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaLogConsumoProduto(VpaSeqProduto,
   VpaCodCor: Integer;VpaCodProduto : string): String;
var
  VpfSeqLog : Integer;
  VpfNomArquivo : String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM CONSUMOPRODUTOLOG '+
                                 ' Where SEQPRODUTO = 0 AND SEQLOG = 0');


  ProCadastro.Insert;

  ProCadastro.FieldByName('SEQPRODUTO').AsInteger:= VpaSeqProduto;
  VpfSeqLog:= RSeqConsumoLog;
  ProCadastro.FieldbyName('SEQLOG').asInteger:= VpfSeqLog;
  ProCadastro.FieldByName('DATLOG').AsDateTime:= Now;
  ProCadastro.FieldByName('CODUSUARIO').AsInteger:= varia.CodigoUsuario;

  VpfNomArquivo := varia.PathVersoes+'\LOG\PRODUTO\'+FormatDateTime('YYYYMM',date)+'\' +IntToStr(VpaSeqProduto)+ '_' + VpaCodProduto+ '_' +'_u'+IntToStr(Varia.CodigoUsuario)+'_'+FormatDateTime('YYMMDDHHMMSSMM',NOW)+'CONSUMO'+'.xml';

  ProCadastro.FieldByname('DESCAMINHOLOG').AsString := VpfNomArquivo;

  ProCadastro.Post;
  Result := ProCadastro.AMensagemErroGravacao;

  AdicionaSQLAbreTabela(ProCadastro2,'Select * from MOVKIT '+
                                     ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                                     ' and I_COR_KIT = '+IntToStr(VpaCodCor));

  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  ProCadastro2.SaveToFile(VpfNomArquivo,dfxml);
  ProCadastro.close;
  ProCadastro2.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaLogProduto(VpaSeqProduto : Integer; VpaCodProduto :String): String;
var
  VpfSeqLog : Integer;
  VpfNomArquivo : String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM PRODUTOLOG '+
                                 ' Where SEQPRODUTO = 0 AND SEQLOG = 0');
  ProCadastro.Insert;

  ProCadastro.FieldByName('SEQPRODUTO').AsInteger:= VpaSeqProduto;
  VpfSeqLog:= RSeqLog;
  ProCadastro.FieldbyName('SEQLOG').asInteger:= VpfSeqLog;
  ProCadastro.FieldByName('DATLOG').AsDateTime:= Now;
  ProCadastro.FieldByName('CODUSUARIO').AsInteger:= varia.CodigoUsuario;

  VpfNomArquivo := varia.PathVersoes+'\LOG\PRODUTO\'+FormatDateTime('YYYYMM',date)+'\' +IntToStr(VpaSeqProduto)+ '_' + SubstituiStr(SubstituiStr(VpaCodProduto,'/','_'),'\','_')+ '_' +'_u'+IntToStr(Varia.CodigoUsuario)+'_'+FormatDateTime('YYMMDDHHMMSSMM',NOW)+'.xml';

  ProCadastro.FieldByname('DESCAMINHOLOG').AsString := VpfNomArquivo;

  ProCadastro.Post;
  Result := ProCadastro.AMensagemErroGravacao;

  AdicionaSQLAbreTabela(ProCadastro2,'Select * from CADPRODUTOS '+
                               ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));

  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  ProCadastro2.SaveToFile(VpfNomArquivo,dfxml);
  ProCadastro.close;
  ProCadastro2.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaMovimentoProdutoReservado(VpaSeqProduto, VpaCodFilial, VpaSeqOrdem: Integer; VpaDesUM : String;VpaQtdReservado, VpaQtdInicial,VpaQtdAtual: Double;VpaTipMovimento : String): String;
begin
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM RESERVAPRODUTO '+
                                    ' Where SEQRESERVA = 0 ');
  ProCadastro.Insert;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  ProCadastro.FieldByName('DESUM').AsString := VpaDesUM;
  ProCadastro.FieldByName('TIPMOVIMENTO').AsString := VpaTipMovimento;
  ProCadastro.FieldByName('DATRESERVA').AsDateTime := now;
  ProCadastro.FieldByName('QTDRESERVADA').AsFloat := VpaQtdReservado;
  ProCadastro.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  ProCadastro.FieldByName('QTDINICIAL').AsFloat := VpaQtdInicial;
  ProCadastro.FieldByName('QTDFINAL').AsFloat := VpaQtdAtual;
  if VpaSeqOrdem <> 0 then
  begin
    ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
    ProCadastro.FieldByName('SEQORDEMPRODUCAO').AsInteger := VpaSeqOrdem;
  end;

  ProCadastro.FieldByName('SEQRESERVA').AsFloat := RSeqReservaProdutoDisponivel;
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.ReprocessaEstoque(VpaMes, VpaAno : Integer): String;
Var
  VpfDatInicial, VpfDatFinal : TDateTime;
begin
  result := '';
  VpfDatInicial := MontaData(1,VpaMes,VpaAno);
  VpfDatFinal := UltimoDiaMes(VpfDatInicial);
  ExcluiMovimentoEstoquePorData(VpfDatInicial,VpfDatFinal);
  result := ReprocessaEstoqueCotacao(VpfDatInicial,VpfDatFinal);
  if result = '' then
    result := ReprocessaEstoqueCompras(VpfDatInicial,VpfDatFinal);
end;

{******************************************************************************}
procedure TFuncoesProduto.ReAbrirMes(VpaData : TDateTime);
begin
  ExecutaComandoSql(AUX,'Update CADFILIAIS '+
                        ' Set D_ULT_FEC = '+ SQLTextoDataAAAAMMMDD(UltimoDiaMes(VpaData))+
                        ' Where I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil));
end;

function TFuncoesProduto.RecalculaCustoMateriaPrimaProjeto(VpaCodProjeto: Integer; VpaSomenteZerados: boolean;VpaSeqMateriaPrima: Integer): string;
var
  VpfDProduto : TRBDProduto;
begin
  VpfDProduto := TRBDProduto.Cria;
  VpfDProduto.SeqProduto := 0;
  ProProduto.Close;
  LimpaSQLTabela(ProProduto);
  AdicionaSQLTabela(ProProduto,'Select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, FRC.SEQCONSUMO, FRC.SEQPRODUTO ' +
                               ' FROM FRACAOOP FRA, FRACAOOPCONSUMO FRC, ORDEMPRODUCAOCORPO OP ' +
                               ' WHERE FRA.CODFILIAL = FRC.CODFILIAL ' +
                               ' AND FRA.SEQORDEM = FRC.SEQORDEM ' +
                               ' AND FRA.SEQFRACAO = FRC.SEQFRACAO ' +
                               ' AND FRA.CODFILIAL = OP.EMPFIL ' +
                               ' AND FRA.SEQORDEM = OP.SEQORD'+
                               ' AND OP.CODPRJ = '+ IntToStr(VpaCodProjeto));
  if VpaSomenteZerados  then
    AdicionaSQLTabela(ProProduto,'AND NVL(FRC.VALCUSTOTOTAL,0) = 0 ');
  if VpaSeqMateriaPrima <> 0 then
    AdicionaSQLTabela(ProProduto,'AND FRC.SEQPRODUTO = '+IntToStr(VpaSeqMateriaPrima));
  AdicionaSQLTabela(ProProduto,'ORDER BY FRC.SEQPRODUTO');
  ProProduto.Open;
  while not ProProduto.Eof do
  begin
    if ProProduto.FieldByName('SEQPRODUTO').AsInteger <> VpfDProduto.SeqProduto then
    begin
      VpfDProduto.Free;
      VpfDProduto := TRBDProduto.Cria;
      CarDProduto(VpfDProduto,varia.CodigoEmpresa,ProProduto.FieldByName('CODFILIAL').AsInteger,ProProduto.FieldByName('SEQPRODUTO').AsInteger);
    end;

    AdicionaSQLAbreTabela(ProCadastro,'Select * from FRACAOOPCONSUMO '+
                                      ' Where CODFILIAL = '+ProProduto.FieldByName('CODFILIAL').AsString +
                                      ' and SEQORDEM = '+ProProduto.FieldByName('SEQORDEM').AsString+
                                      ' and SEQFRACAO = '+ProProduto.FieldByName('SEQFRACAO').AsString+
                                      ' and SEQCONSUMO = '+ProProduto.FieldByName('SEQCONSUMO').AsString);
    ProCadastro.Edit;

    if ProCadastro.FieldByName('ALTMOLDE').AsFloat <> 0 then
      ProCadastro.FieldByName('VALCUSTOTOTAL').AsFloat := ProCadastro.FieldByName('PESPRODUTO').AsFloat * VpfDProduto.VlrCusto
    else
      ProCadastro.FieldByName('VALCUSTOTOTAL').AsFloat := ProCadastro.FieldByName('QTDBAIXADO').AsFloat * (CalculaValorPadrao(ProCadastro.FieldByName('DESUM').AsString,VpfDProduto.CodUnidade,VpfDProduto.VlrCusto,IntToStr(VpfDProduto.SeqProduto)));
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      exit;
    ProProduto.Next;
  end;
  ProProduto.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ReorganizaSeqEstagio(VpaDProduto : TRBDProduto);
var
  VpflacoExterno, VpfLacoInterno : integer;
  VpfPrimeiraTroca : Boolean;
  VpfDEstagio : TRBDEstagioProduto;
begin
  VpfPrimeiraTroca := true;
  for VpfLacoExterno := 0 to VpaDProduto.Estagios.count - 1 do
  begin
    VpfDEstagio := TRBDEstagioProduto(VpaDproduto.Estagios.Items[VpfLacoexterno]);
    if VpfDEstagio.SeqEstagio <> VpflacoExterno + 1 then
    begin
      for VpflacoInterno := 0 to VpaDProduto.Estagios.count - 1 do
      begin
        if VpfPrimeiraTroca then
          if TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior = VpfLacoexterno+1 then
            TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior :=0;

        if TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior = VpfDEstagio.SeqEstagio then
          TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior := VpfLacoexterno+1;
      end;
      VpfDEstagio.SeqEstagio := VpfLacoExterno +1;
      VpfPrimeiraTroca := false;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.CorReferenciaDuplicada(VpaDProduto : TRBDProduto):Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDConsumoExterno, VpfDConsumoInterno : TRBDConsumoMP;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDProduto.ConsumosMP.Count - 2 do
  begin
    VpfDConsumoExterno := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoExterno]);
    if VpfDConsumoExterno.CorReferencia <> 0 then
    begin
      for VpfLacoInterno := VpfLacoExterno + 1 to VpaDProduto.ConsumosMP.Count - 1 do
      begin
        VpfDConsumoInterno := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoInterno]);
        if VpfDConsumoInterno.CorReferencia <> 0 then
        begin
          if VpfDConsumoExterno.CorReferencia = VpfDConsumoInterno.CorReferencia then
          begin
            result := true;
            exit;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ConcluiDesenho(VpaSeqProduto, VpaCodCor, VpaSeqMovimento : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVKIT '+
                                    ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto)+
                                    ' and I_COR_KIT = '+IntToStr(VpaCodCor)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  ProCadastro.edit;
  ProCadastro.FieldByName('D_DAT_DES').AsDateTime := now;
  ProCadastro.post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.ConcluiFichaTecnica(VpaCodFilial,VpaLanOrcamento, VpaSeqItem : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqItem));
  ProCadastro.edit;
  ProCadastro.FieldByName('D_DAT_GOP').AsDateTime := date;
  ProCadastro.post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.PreparaImpressaoEtiqueta(VpaEtiquetas : TList;VpaPosInicial : Integer);
Var
  VpfSequencial, Vpflaco, VpfLacoQtd : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
begin
  VpfSequencial := 0;
  ExecutaComandoSql(Tabela,'Delete from ETIQUETAPRODUTO');
  AdicionaSQLAbreTabela(ProCadastro,'Select * from ETIQUETAPRODUTO');
  for vpfLaco := 1 to VpaPosInicial - 1 do
  begin
    inc(VpfSequencial);
    ProCadastro.Insert;
    ProCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
    ProCadastro.FieldByname('INDIMPRIMIR').AsString := 'N';
    ProCadastro.Post;
  end;

  for vpflaco := 0 to VpaEtiquetas.count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLaco]);
    for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
    begin
      inc(VpfSequencial);
      ProCadastro.insert;
      ProCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
      ProCadastro.FieldByname('CODPRODUTO').AsString := VpfDEtiqueta.Produto.CodProduto;
      ProCadastro.FieldByname('NOMPRODUTO').AsString := VpfDEtiqueta.Produto.NomProduto;
      ProCadastro.FieldByname('INDIMPRIMIR').AsString := 'S';
      ProCadastro.post;
      if ProCadastro.AErronaGravacao then
      begin
        aviso(ProCadastro.AMensagemErroGravacao);
        ProCadastro.close;
        exit;
      end;
    end;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.CalculaNumeroSerie(VpaNumSerie : Integer) :string;
VAR
  VpfDAta : String;
begin
  VpfData := FormatDateTime('DDMMYYYY',Date);
  result := '';
  case Varia.RegraNumeroSerie of
    rnNNNNNDDMAAD : result := IntToStr(VpaNumSerie)+copy(VpfData,2,1)+copy(VpfData,1,1)+copy(VpfData,3,1)+copy(VpfData,7,2)+copy(VpfData,4,1);
  end;
end;

{******************************************************************************}
function TFuncoesProduto.GeraCodigosBArras : String;
begin
  result := '';
  case Varia.TipCodBarras of
    cbEAN13 : result := GeraCodigoBarrasEAN13;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDFilialFaturamento(VpaDProduto: TRBDProduto);
Var
  VpfDFilialFaturamento :  TRBDFilialFaturamento;
begin
  FreeTObjectsList(VpaDProduto.FilialFaturamento);
  AdicionaSQLAbreTabela(Tabela,'Select PRO.CODFILIAL, '+
                               ' FIL.C_NOM_FAN '+
                               ' from PRODUTOFILIALFATURAMENTO PRO, CADFILIAIS FIL '+
                               ' Where PRO.CODFILIAL = FIL.I_EMP_FIL'+
                               ' and PRO.SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto)+
                               ' order by PRO.CODFILIAL');
  while not Tabela.eof do
  begin
    VpfDFilialFaturamento := VpaDProduto.AddFilialFaturamento;
    VpfDFilialFaturamento.CodFilial := Tabela.FieldByName('CODFILIAL').AsInteger;
    VpfDFilialFaturamento.NomFilial := Tabela.FieldByName('C_NOM_FAN').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDFornecedores(VpaDProduto: TRBDProduto);
var
  VpfDFornecedor: TRBDProdutoFornecedor;
begin
  FreeTObjectsList(VpaDProduto.Fornecedores);
  AdicionaSQLAbreTabela(ProProduto,'SELECT PRF.CODCOR,PRF.CODCLIENTE, PRF.DATULTIMACOMPRA, PRF.QTDMINIMACOMPRA,'+
                                   ' PRF.DESREFERENCIA, PRF.VALUNITARIO, PRF.NUMDIAENTREGA, PRF.PERIPI, CLI.C_NOM_CLI'+
                                   ' FROM PRODUTOFORNECEDOR PRF, CADCLIENTES CLI'+
                                   ' WHERE PRF.SEQPRODUTO = '+InttoStr(VpaDProduto.SeqProduto)+
                                   ' AND CLI.I_COD_CLI = PRF.CODCLIENTE');
  while not ProProduto.Eof do
  begin
    VpfDFornecedor:= VpaDProduto.AddFornecedor;
    VpfDFornecedor.CodCOR:= ProProduto.FieldByName('CODCOR').AsInteger;
    VpfDFornecedor.NomCor := RNomeCor(InttoStr(VpfDFornecedor.CodCor));
    VpfDFornecedor.CodCliente:= ProProduto.FieldByName('CODCLIENTE').AsInteger;
    VpfDFornecedor.NomCliente:= ProProduto.FieldByName('C_NOM_CLI').AsString;
    VpfDFornecedor.NumDiaEntrega:= ProProduto.FieldByName('NUMDIAENTREGA').AsInteger;
    VpfDFornecedor.DatUltimaCompra:= ProProduto.FieldByName('DATULTIMACOMPRA').AsDateTime;
    VpfDFornecedor.QtdMinimaCompra:= ProProduto.FieldByName('QTDMINIMACOMPRA').AsFloat;
    VpfDFornecedor.ValUnitario:= ProProduto.FieldByName('VALUNITARIO').AsFloat;
    VpfDFornecedor.PerIPI:= ProProduto.FieldByName('PERIPI').AsFloat;
    VpfDFornecedor.DesReferencia:= ProProduto.FieldByName('DESREFERENCIA').AsString;
    ProProduto.Next;
  end;
  VpaDProduto.IndFornecedoresCarregados:= True;
  ProProduto.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDProdutoFornecedor(VpaCodFornecedor: Integer; VpaDProtudoPedido: TRBDProdutoPedidoCompra);
begin
  AdicionaSQLAbreTabela(ProProduto,'SELECT'+
                                   ' PRF.DESREFERENCIA, PRF.VALUNITARIO, PRF.PERIPI '+
                                   ' FROM PRODUTOFORNECEDOR PRF'+
                                   ' WHERE PRF.SEQPRODUTO = '+InttoStr(VpaDProtudoPedido.SeqProduto)+
                                   ' AND PRF.CODCLIENTE = '+IntToStr(VpaCodFornecedor)+
                                   ' AND PRF.CODCOR = '+IntToStr(VpaDProtudoPedido.CodCor));
  if not ProProduto.Eof then
  begin
    if ProProduto.FieldByName('VALUNITARIO').AsFloat <> 0 then
      VpaDProtudoPedido.ValUnitario:= ProProduto.FieldByName('VALUNITARIO').AsFloat;
    VpaDProtudoPedido.DesReferenciaFornecedor:= ProProduto.FieldByName('DESREFERENCIA').AsString;
    VpaDProtudoPedido.PerIPI := ProProduto.FieldByName('PERIPI').AsFloat;
  end;
  ProProduto.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDProdutoInstalacaoTear(VpaDProduto: TRBDProduto; VpaGrade: TRBStringGridColor);
var
  VpfDInstalacaoTear : TRBDProdutoInstalacaoTear;
begin
  FreeTObjectsList(VpaDProduto.InstalacaoTear);
  AdicionaSQLAbreTabela(Tabela,'Select * from PRODUTOINSTALACAOTEAR '+
                                    ' WHERE SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto)+
                                    ' order by NUMCOLUNA, NUMLINHA');
  while not Tabela.eof do
  begin
    VpfDInstalacaoTear := VpaDProduto.AddInstalacaoTear;
    VpfDInstalacaoTear.NumLinha := Tabela.FieldByName('NUMLINHA').AsInteger;
    VpfDInstalacaoTear.NumColuna := Tabela.FieldByName('NUMCOLUNA').AsInteger;
    VpfDInstalacaoTear.CodCor := Tabela.FieldByName('CODCOR').AsInteger;
    if VpfDInstalacaoTear.CodCor <> 0  then
       VpfDInstalacaoTear.NomCor := RNomeCor(InttoStr(VpfDInstalacaoTear.CodCor));

    if Tabela.FieldByName('DESFUNCAOFIO').AsString = 'U' then
      VpfDInstalacaoTear.FuncaoFio := ffUrdume
    else
      if Tabela.FieldByName('DESFUNCAOFIO').AsString = 'J' then
        VpfDInstalacaoTear.FuncaoFio := ffAjuda
      else
        if Tabela.FieldByName('DESFUNCAOFIO').AsString = 'M' then
          VpfDInstalacaoTear.FuncaoFio := ffAmarracao;
    VpfDInstalacaoTear.SeqProduto := Tabela.FieldByName('SEQMATERIAPRIMA').AsInteger;
    ExisteProduto(VpfDInstalacaoTear.SeqProduto,VpfDInstalacaoTear.CodProduto,VpfDInstalacaoTear.NomProduto);
    VpfDInstalacaoTear.QtdFiosLico := Tabela.FieldByName('QTDFIOLICO').AsInteger;
    if VpaGrade <> nil then
    begin
      if VpaGrade.RowCount < Tabela.FieldByName('NUMLINHA').AsInteger then
        VpaGrade.RowCount := Tabela.FieldByName('NUMLINHA').AsInteger;
      if VpaGrade.ColCount < Tabela.FieldByName('NUMCOLUNA').AsInteger then
        VpaGrade.ColCount := Tabela.FieldByName('NUMCOLUNA').AsInteger;

      VpaGrade.Objects[Tabela.FieldByName('NUMCOLUNA').AsInteger - 1,Tabela.FieldByName('NUMLINHA').AsInteger - 1] := VpfDInstalacaoTear;
      VpaGrade.Cells[Tabela.FieldByName('NUMCOLUNA').AsInteger - 1,Tabela.FieldByName('NUMLINHA').AsInteger - 1] := '*';
    end;
    Tabela.Next;
  end;
  CarDProdutoInstalacaoTearRepeticoes(VpaDProduto);
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDProdutoInstalacaoTearRepeticoes(VpaDProduto: TRBDProduto);
var
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
begin
  FreeTObjectsList(VpaDProduto.DInstalacaoCorTear.Repeticoes);
  AdicionaSQLAbreTabela(Tabela,'Select * from PRODUTOINSTALACAOTEARREPETICAO ' +
                               ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto)+
                               ' ORDER BY SEQREPETICAO ');
  while not Tabela.Eof do
  begin
    VpfDRepeticao := VpaDProduto.DInstalacaoCorTear.AddRepeticoes;
    VpfDRepeticao.SeqRepeticao := Tabela.FieldByName('SEQREPETICAO').AsInteger;
    VpfDRepeticao.NumColunaInicial := Tabela.FieldByName('COLINICIAL').AsInteger;
    VpfDRepeticao.NumColunaFinal := Tabela.FieldByName('COLFINAL').AsInteger;
    VpfDRepeticao.QtdRepeticao := Tabela.FieldByName('QTDREPETICAO').AsInteger;
    Tabela.Next
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDValCusto(VpaDProduto: TRBDProduto; VpaCodFilial : Integer);
var
  VpfDPreco : TRBDProdutoTabelaPreco;
  VpfPrecosVenda : TList;
  VpfLaco : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'select  MOV.N_QTD_PRO, MOV.N_QTD_MIN, MOV.N_QTD_PED, MOV.N_VLR_CUS, MOV.N_VLR_COM, MOV.C_COD_BAR, '+
                               ' COR.COD_COR, COR.NOM_COR, '+
                               ' TAM.CODTAMANHO, TAM.NOMTAMANHO '+
                               ' from MOVQDADEPRODUTO MOV, COR, TAMANHO TAM '+
                               ' Where MOV.I_SEQ_PRO = ' + IntToStr(VpaDProduto.SeqProduto)+
                               ' AND MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                               ' ORDER BY COR.COD_COR, TAM.CODTAMANHO');
  while not Tabela.eof do
  begin
    VpfPrecosVenda := RPrecoVendaeCustoProduto(VpaDProduto,Tabela.FieldByName('COD_COR').AsInteger,Tabela.FieldByName('CODTAMANHO').AsInteger);
    if VpfPrecosVenda.Count = 0   then
    begin
      VpfDPreco := VpaDProduto.AddTabelaPreco;
      VpfDPreco.CodTabelaPreco := varia.TabelaPreco;
      VpfDPreco.NomTabelaPreco := RNomTabelaPreco(Varia.TabelaPreco);
      VpfDPreco.CodMoeda := VARIA.MoedaBase;
      VpfDPreco.NomMoeda := FunContasAReceber.RNomMoeda(Varia.MoedaBase);
      VpfDPreco.CodTamanho := Tabela.FieldByName('CODTAMANHO').AsInteger;
      VpfDPreco.NomTamanho := Tabela.FieldByName('NOMTAMANHO').AsString;
      VpfDPreco.CodCliente := 0;
      VpfDPreco.CodCor := Tabela.FieldByName('COD_COR').AsInteger;
      VpfDPreco.NomCor := Tabela.FieldByName('NOM_COR').AsString;
      VpfDPreco.ValVenda := 0;
      VpfDPreco.ValRevenda := 0;
      VpfDPreco.DesCodigodeBarra:= Tabela.FieldByName('C_COD_BAR').AsString;
      VpfPrecosVenda.Add(VpfDPreco);
    end;
    if (Tabela.FieldByName('CODTAMANHO').AsInteger = 0) and
       (Tabela.FieldByName('COD_COR').AsInteger = 0) then
    begin
      VpaDProduto.VlrCusto := Tabela.FieldByName('N_VLR_CUS').AsFloat;
    end;


    for VpfLaco := 0 to VpfPrecosVenda.Count - 1 do
    begin
      VpfDPreco := TRBDProdutoTabelaPreco(VpfPrecosVenda.Items[VpfLaco]);
      VpfDPreco.ValCompra := Tabela.FieldByName('N_VLR_COM').AsFloat;
      VpfDPreco.ValCusto := Tabela.FieldByName('N_VLR_CUS').AsFloat;
      VpfDPreco.QtdEstoque := Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfDPreco.QtdMinima := Tabela.FieldByName('N_QTD_MIN').AsFloat;
      VpfDPreco.DesCodigodeBarra:= Tabela.FieldByName('C_COD_BAR').AsString;

      VpfDPreco.QtdIdeal := Tabela.FieldByName('N_QTD_PED').AsFloat;
    end;
    VpfPrecosVenda.free;
    Tabela.next;
  end;
  Tabela.close;
  OrdenaTabelaPrecoProduto(VpaDProduto);
end;

{******************************************************************************}
procedure TFuncoesProduto.CarFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList);
var
  VpfDFigura : TRBDFiguraGRF;
begin
  FreeTObjectsList(VpaFiguras);
  AdicionaSQLAbreTabela(Tabela,'select FIG.CODFIGURAGRF, FIG.NOMFIGURAGRF, FIG.DESFIGURAGRF '+
                               ' from  FIGURAGRF FIG, COMPOSICAOFIGURAGRF CFI '+
                               ' WHERE FIG.CODFIGURAGRF = CFI.CODFIGURAGRF '+
                               ' AND CFI.CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
  while not Tabela.eof  do
  begin
    VpfDFigura := TRBDFiguraGRF.cria;
    VpaFiguras.Add(VpfDFigura);
    VpfDFigura.CodFiguraGRF := Tabela.FieldByName('CODFIGURAGRF').AsInteger;
    VpfDFigura.NOMFiguraGRF := Tabela.FieldByName('NOMFIGURAGRF').AsString;
    VpfDFigura.DESIMAGEM := Tabela.FieldByName('DESFIGURAGRF').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarFiosOrcamentoCadarco(VpaDProduto: TRBDProduto);
Var
  VpfDFio : TRBDProdutoFioOrcamentoCadarco;
begin
  if Varia.CodClassificacaoMateriaPrimaFio <> '' then
  begin
    FreeTObjectsList(VpaDProduto.FiosOrcamentoCadarco);
    AdicionaSqlAbreTabela(ProProduto,'Select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, ' +
                                     ' MOV.N_VLR_CUS ' +
                                     ' FROM CADPRODUTOS PRO, MOVQDADEPRODUTO MOV ' +
                                     ' Where PRO.I_SEQ_PRO = MOV.I_SEQ_PRO ' +
                                     ' AND MOV.I_EMP_FIL = ' + IntToStr(VARIA.CodigoEmpFil)+
                                     ' AND PRO.C_COD_CLA  LIKE '''+Varia.CodClassificacaoMateriaPrimaFio+'%'''+
                                     ' AND MOV.I_COD_COR = 0 ' +
                                     ' AND MOV.I_COD_TAM = 0'+
                                     ' and PRO.C_ATI_PRO = ''S'''+
                                     ' order by PRO.C_NOM_PRO ');
    while not ProProduto.Eof do
    begin
      VpfDFio := VpaDProduto.addFioOrcamentoCadarco;
      VpfDFio.SeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpfDFio.CodProduto := ProProduto.FieldByName('C_COD_PRO').AsString;
      VpfDFio.NomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpfDFio.ValCustoFio := ProProduto.FieldByName('N_VLR_CUS').AsFloat;
      VpfDFio.IndSelecionado := false;
      VpfDFio.PesFio :=0;
      ProProduto.Next;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarMateriaPrimaOrcamentoCadarco(VpaDProduto: TRBDProduto);
var
  VpfDFio : TRBDProdutoFioOrcamentoCadarco;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, ' +
                               ' MOV.N_VLR_CUS,  ' +
                               ' ORC.QTDFIO  ' +
                               ' FROM CADPRODUTOS PRO, MOVQDADEPRODUTO MOV,  MATERIAPRIMAORCAMENTOCADARCO ORC  ' +
                               ' Where PRO.I_SEQ_PRO = MOV.I_SEQ_PRO  ' +
                               ' AND MOV.I_EMP_FIL = 11  ' +
                               ' AND MOV.I_COD_COR = 0  ' +
                               ' AND MOV.I_COD_TAM = 0  ' +
                               ' AND ORC.SEQMATERIAPRIMA = PRO.I_SEQ_PRO  ' +
                               ' AND ORC.SEQPRODUTO = ' + IntToStr(VpaDProduto.SeqProduto)+
                               ' order by PRO.C_NOM_PRO ');
  while not Tabela.Eof do
  begin
    VpfDFio :=  RMateriPrimaOrcamentoCadarco(VpaDProduto,Tabela.FieldByName('I_SEQ_PRO').AsInteger);
    if VpfDFio = nil then
    begin
      VpfDFio := VpaDProduto.addFioOrcamentoCadarco;
      VpfDFio.SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
      VpfDFio.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
      VpfDFio.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
      VpfDFio.ValCustoFio := Tabela.FieldByName('N_VLR_CUS').AsFloat;
    end;
    VpfDFio.IndSelecionado := true;
    VpfDFio.PesFio := Tabela.FieldByName('QTDFIO').AsFloat;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDFilialFaturamento(VpaDProduto: TRBDProduto): String;
var
  VpfLaco : Integer;
  VpfDFilialFaturamento : TRBDFilialFaturamento;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from PRODUTOFILIALFATURAMENTO '+
                        ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSqlAbreTabela(ProCadastro,'Select * from PRODUTOFILIALFATURAMENTO' +
                                    ' WHERE SEQPRODUTO = 0 AND CODFILIAL = 0');
  for VpfLaco := 0 to VpaDProduto.FilialFaturamento.Count - 1 do
  begin
    VpfDFilialFaturamento := TRBDFilialFaturamento(VpaDProduto.FilialFaturamento.Items[VpfLaco]);
    ProCadastro.insert;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODFILIAL').AsInteger := VpfDFilialFaturamento.CodFilial;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDFornecedor(
  VpaDProduto: TRBDProduto): String;
Var
  VpfLaco: Integer;
  VpfDFornecedor: TRBDProdutoFornecedor;
begin
  Result:= '';
  ExecutaComandoSql(AUX,'DELETE FROM PRODUTOFORNECEDOR '+
                        ' WHERE SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM PRODUTOFORNECEDOR '+
                                    ' WHERE SEQPRODUTO = 0 AND CODCLIENTE = 0 AND CODCOR = 0');
  for VpfLaco:= 0 to VpaDProduto.Fornecedores.Count - 1 do
  begin
    VpfDFornecedor:= TRBDProdutoFornecedor(VpaDProduto.Fornecedores.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger:= VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODCLIENTE').AsInteger:= VpfDFornecedor.CodCliente;
    ProCadastro.FieldByName('CODCOR').AsInteger:= VpfDFornecedor.CodCor;
    ProCadastro.FieldByName('QTDMINIMACOMPRA').AsFloat:= VpfDFornecedor.QtdMinimaCompra;
    ProCadastro.FieldByName('DATULTIMACOMPRA').AsDateTime:= VpfDFornecedor.DatUltimaCompra;
    ProCadastro.FieldByName('VALUNITARIO').AsFloat:= VpfDFornecedor.ValUnitario;
    ProCadastro.FieldByName('NUMDIAENTREGA').AsInteger:= VpfDFornecedor.NumDiaEntrega;
    ProCadastro.FieldByName('PERIPI').AsFloat:= VpfDFornecedor.PerIPI;
    ProCadastro.FieldByName('DESREFERENCIA').AsString := VpfDFornecedor.DesReferencia;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDAcessorio(VpaDProduto : TRBDProduto):string;
var
  VpfLaco : Integer;
  VpfDAcessorio : TRBDProdutoAcessorio;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from PRODUTOACESSORIO '+
                        ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSqlAbreTabela(ProCadastro,'Select * from PRODUTOACESSORIO');
  for VpfLaco := 0 to VpaDProduto.Acessorios.Count - 1 do
  begin
    VpfDAcessorio := TRBDProdutoAcessorio(VpaDProduto.Acessorios.Items[VpfLaco]);
    ProCadastro.insert;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODACESSORIO').AsInteger := VpfDAcessorio.CodAcessorio;
    ProCadastro.FieldByName('SEQITEM').AsInteger := VpfLaco + 1;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDTabelaPreco(VpaDProduto : TRBDProduto):string;
Var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(AUX,'Delete from MOVTABELAPRECO '+
                        ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                        ' AND I_SEQ_PRO = '+ IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVTABELAPRECO'+
                                    ' Where I_COD_EMP = 0 AND I_SEQ_PRO = 0 AND I_COD_TAB = 0 AND I_COD_CLI = 0 AND I_COD_MOE = 0 AND I_COD_TAM = 0');
  for VpfLaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDTabelaPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[Vpflaco]);
    ProCadastro.insert;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
    ProCadastro.FieldByName('I_COD_TAB').AsInteger := VpfDTabelaPreco.CodTabelaPreco;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COD_MOE').AsInteger := VpfDTabelaPreco.CodMoeda;
    ProCadastro.FieldByName('N_VLR_VEN').AsFloat := VpfDTabelaPreco.ValVenda;
    ProCadastro.FieldByName('N_PER_MAX').AsFloat := VpfDTabelaPreco.PerMaximoDesconto;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    ProCadastro.FieldByName('I_COD_CLI').AsInteger := VpfDTabelaPreco.CodCliente;
    ProCadastro.FieldByName('N_VLR_REV').AsFloat := VpfDTabelaPreco.ValReVenda;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger := VpfDTabelaPreco.CodTamanho;
    ProCadastro.FieldByName('I_COD_COR').AsInteger := VpfDTabelaPreco.CodCor;
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  ProCadastro.close;
  sistema.MarcaTabelaParaImportar('MOVTABELAPRECO');
end;

{******************************************************************************}
function TFuncoesProduto.SalvaImagemdaAreaTransferenciaWindows(VpaDProduto : TRBDProduto): string;
var
  VpfClipImage: TJpegImage;
  VpfBitmap: TBitmap;
begin
  result := '';
  if VpaDProduto.CodProduto = '' then
    result := 'CÓDIGO DO PRODUTO NÃO PREENCHIDO!!!'#13'Para salvar a imagem é necessário que o codigo do produto esteja preenchido';
  if result = '' then
    if varia.DriveFoto = '' then
      result := 'DIRETÓRIO DAS IMAGENS NÃO PREENCHIDO!!!'#13'Para salvar a imagem é necessário nas configuracoes gerais preencher o diretorio das imagens';
  if result = '' then
  begin
    try
    // Crio as instâncias
    VpfClipImage := TJpegImage.Create;
    VpfBitmap := TBitmap.Create;
    // Nivel de compressão JPEG
    VpfClipImage.CompressionQuality := 50;
    // Aqui verifico se tem alguma imagem
    // no clipboard
    if ClipBoard.HasFormat(CF_BITMAP) then
    begin
    // Clipboard sempre tranforma a
    // imagem em bitmap entao tneho
    // de convertê-la para jpeg...
      VpfBitmap.Assign(ClipBoard);
      VpfClipImage.Assign(VpfBitmap);
      VpaDProduto.PatFoto :='\'+VpaDProduto.CodProduto+'.jpg';
      VpfClipImage.SaveToFile(Varia.DriveFoto+ VpaDProduto.PatFoto);
    end
    else
      result := 'NÃO EXISTE IMAGEM NA AREA DE TRANSFERENCIA!!!'#13'Para salvar a imagem é necessário copiá-la antes para a área de transferencia.';
    finally
      VpfClipImage.Free;
      VpfBitmap.Free;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.SincronizarConsumoAmostraProduto(VpaDProduto: TRBDProduto; VpaConsumosAmostra: TList);
var
  VpfLaco: Integer;
  VpfDConsumoAmostra: TRBDConsumoAmostra;
  VpfDConsumoProduto: TRBDConsumoMP;
begin
  for VpfLaco:= 0 to VpaConsumosAmostra.Count-1 do
  begin
    VpfDConsumoAmostra:= TRBDConsumoAmostra(VpaConsumosAmostra.Items[VpfLaco]);
    VpfDConsumoProduto:= VpaDProduto.AddConsumoMP;

    VpfDConsumoProduto.CorKit:= 1;
    VpfDConsumoProduto.SeqProduto:= VpfDConsumoAmostra.SeqProduto;
    VpfDConsumoProduto.CodCor:= VpfDConsumoAmostra.CodCor;
    VpfDConsumoProduto.CodFaca:= VpfDConsumoAmostra.CodFaca;
    VpfDConsumoProduto.CodMaquina:= VpfDConsumoAmostra.CodMaquina;
    VpfDConsumoProduto.AltProduto:= VpfDConsumoAmostra.AltProduto;
    VpfDConsumoProduto.AlturaMolde:= Round(VpfDConsumoAmostra.AltMolde);
    VpfDConsumoProduto.LarguraMolde:= Round(VpfDConsumoAmostra.LarMolde);
    VpfDConsumoProduto.CodProduto:= VpfDConsumoAmostra.CodProduto;
    VpfDConsumoProduto.NomProduto:= VpfDConsumoAmostra.NomProduto;
    VpfDConsumoProduto.NomCor:= VpfDConsumoAmostra.NomCor;
    VpfDConsumoProduto.UMOriginal:= VpfDConsumoAmostra.DesUM;
    VpfDConsumoProduto.UM:= VpfDConsumoAmostra.DesUM;
    VpfDConsumoProduto.QtdProduto:= VpfDConsumoAmostra.Qtdproduto;
    VpfDConsumoProduto.PecasMT:= VpfDConsumoAmostra.QtdPecasemMetro;
    VpfDConsumoProduto.IndiceMT:= VpfDConsumoAmostra.ValIndiceConsumo;
    VpfDConsumoProduto.ValorUnitario:= VpfDConsumoAmostra.ValUnitario;
    VpfDConsumoProduto.ValorTotal:= VpfDConsumoAmostra.ValTotal;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ImportaConsumoAmostra(VpaDProduto: TRBDProduto; VpaDAmostra: TRBDAmostra): string;
begin
  result := FunAmostra.CopiaConsumoAmostraProduto(VpaDAmostra.CodAmostra,VpaDProduto.SeqProduto);
end;

{******************************************************************************}
procedure TFuncoesProduto.ImportaEstoqueProdutAExcluir(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
var
  VpfSeqBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.I_EMP_FIL, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_QTD_PRO, PRO.C_COD_UNI FROM MOVQDADEPRODUTO MOV, CADPRODUTOS PRO'+
                            ' Where PRO.I_SEQ_PRO = MOV.I_SEQ_PRO '+
                            ' AND PRO.I_SEQ_PRO = '+IntToStr(VpaSeqProdutoaExcluir));
  VpfDProduto := TRBDProduto.Cria;
  CarDProduto(VpfDProduto,varia.CodigoEmpresa,0,VpaSeqProdutoDestino);
  while not Tabela.eof do
  begin
    BaixaProdutoEstoque(VpfDProduto,TABELA.FieldByName('I_EMP_FIL').AsInteger,VARIA.OperacaoAcertoEstoqueEntrada,
                        0,0,0,VARIA.MoedaBase,Tabela.FieldByName('I_COD_COR').AsInteger,Tabela.FieldByName('I_COD_TAM').AsInteger,date,Tabela.FieldByName('N_QTD_PRO').AsFloat,
                        0,Tabela.FieldByName('C_COD_UNI').AsString,'',false,VpfSeqBarra);
    Tabela.next;
  end;
  VpfDProduto.free;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesProduto.ImportaPrecoAmostra(VpaDProduto: TRBDProduto; VpaDAmostra: TRBDAmostra): string;
Var
  VpfLaco, VpfCodCliente: Integer;
  VpfDPrecoAmostra : TRBDPrecoClienteAmostra;
  VpfDPrecoProduto : TRBDProdutoTabelaPreco;
begin
  result := '';
  AdicionaSQLAbreTabela(Tabela,'Select CODAMOSTRA, CODCOR ' +
                               ' FROM AMOSTRACOR ' +
                               ' WHERE CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                               ' ORDER BY CODCOR ');
  while not Tabela.Eof do
  begin
    FunAmostra.CarPrecosClienteAmostra(VpaDAmostra,Tabela.FieldByName('CODCOR').AsInteger);
    VpfCodCliente := -999;
    for VpfLaco := 0 to VpaDAmostra.PrecosClientes.Count - 1 do
    begin
      VpfDPrecoAmostra := TRBDPrecoClienteAmostra(VpaDAmostra.PrecosClientes.Items[Vpflaco]);
      if (VpfDPrecoAmostra.CodCliente <> VpfCodCliente) then
      begin
        VpfCodCliente := VpfDPrecoAmostra.CodCliente;
        VpfDPrecoProduto := VpaDProduto.AddTabelaPreco;
        VpfDPrecoProduto.CodTabelaPreco := varia.TabelaPreco;
        VpfDPrecoProduto.CodTamanho := 0;
        VpfDPrecoProduto.CodCliente := VpfDPrecoAmostra.CodCliente;
        VpfDPrecoProduto.CodMoeda := varia.MoedaBase;
        VpfDPrecoProduto.CodCor := Tabela.FieldByName('CODCOR').AsInteger;
        VpfDPrecoProduto.NomTabelaPreco := RNomTabelaPreco(VpfDPrecoProduto.CodTabelaPreco);
        VpfDPrecoProduto.NomMoeda := FunContasAReceber.RNomMoeda(VpfDPrecoProduto.CodMoeda);
        VpfDPrecoProduto.NomTamanho := '';
        VpfDPrecoProduto.NomCor := RNomeCor(IntToStr(VpfDPrecoProduto.CodCor));
        VpfDPrecoProduto.NomCliente := VpfDPrecoAmostra.NomCliente;
        VpfDPrecoProduto.ValVenda := VpfDPrecoAmostra.ValVenda;
        if (VpaDProduto.PerComissao = 0) or (VpaDProduto.PerComissao > VpfDPrecoAmostra.PerComissao) then
          VpaDProduto.PerComissao := VpfDPrecoAmostra.PerComissao;
      end
      else
      begin
        aviso('AMOSTRA COM VARIAS OPÇÕES DE QUANTIDADE !!!'#13'A amostra importada possui várias opções de quantidade');
        break;
      end;
    end;
    Tabela.Next;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ImportaProdutofornecedor(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
var
  VpfLaco : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from PRODUTOFORNECEDOR'+
                               ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoAExcluir) );
  While not tabela.eof do
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOFORNECEDOR '+
                            ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                            ' and CODCLIENTE = '+IntToStr(Tabela.FieldByName('CODCLIENTE').AsInteger)+
                            ' AND CODCOR = '+Tabela.FieldByName('CODCOR').AsString );
    IF ProCadastro.eof then
    begin
      ProCadastro.insert;
      for VpfLaco := 0 to Tabela.FieldCount - 1 do
        ProCadastro.FieldByName(Tabela.Fields[VpfLaco].DisplayName).AsVariant := Tabela.FieldByName(Tabela.Fields[VpfLaco].DisplayName).AsVariant;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProdutoDestino;
      ProCadastro.post;
    end;
    Tabela.next;
  end;
  Tabela.close;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ImprimeEtiquetaPrateleira(VpaEstante, VpaPrateleiraInicial, VpaPrateleiraFinal: String; VpaNumeroInicial,VpaNumeroFinal: Integer);
var
  VpfEtiquetaPrateleira : TStringList;
  VpfLacoPrateleira, VpfLacoNumero : Integer;
  VpfFunZebra : TRBFuncoesZebra;
begin
  VpfEtiquetaPrateleira := TStringList.create;
  VpfEtiquetaPrateleira.add(VpaEstante);
  for VpfLacoPrateleira := ord(VpaPrateleiraINicial[1]) to ord(vpaPrateleiraFinal[1]) do
  begin
    VpfEtiquetaPrateleira.add(VpaEstante+char(VpfLacoPrateleira));
    for VpfLacoNumero := VpaNumeroInicial to VpaNumeroFinal do
    begin
      VpfEtiquetaPrateleira.add(char(VpfLacoPrateleira)+AdicionaCharE('0',IntToStr(VpfLacoNumero),2));
    end;
  end;
  if varia.ModeloEtiquetaNotaEntrada in [6] then
  begin
    VpfFunZebra := TRBFuncoesZebra.cria(varia.PortaComunicacaoImpTermica,176,lzEPL);
    VpfFunZebra.ImprimeEtiquetaPrateleira33X22(VpfEtiquetaPrateleira);
    VpfFunZebra.Free;
  end;
  VpfEtiquetaPrateleira.free;
end;

{******************************************************************************}
procedure TFuncoesProduto.ImportaEstoqueTecnico(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select TEC.SEQPRODUTO, TEC.CODTECNICO, TEC.CODFILIAL, '+
                               ' TEC.CODCOR, TEC.CODTAMANHO, TEC.QTDPRODUTO, '+
                               ' PRO.C_COD_UNI '+
                               ' from ESTOQUETECNICO TEC, CADPRODUTOS PRO '+
                               ' Where TEC.SEQPRODUTO = '+IntToStr(VpaSeqProdutoAExcluir)+
                               ' AND TEC.SEQPRODUTO = PRO.I_SEQ_PRO');
  While not Tabela.eof do
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUETECNICO '+
                                   ' Where SEQPRODUTO = '+IntTostr(VpaSeqProdutoDestino)+
                                   ' and CODCOR = '+TABELA.FieldByName('CODCOR').AsString+
                                   ' AND CODFILIAL = '+Tabela.FieldByName('CODFILIAL').AsString+
                                   ' AND CODTAMANHO = '+Tabela.FieldByName('CODTAMANHO').AsString+
                                   ' AND CODTECNICO = '+Tabela.FieldByName('CODTECNICO').AsString);
    if ProCadastro.eof then
    begin
      ProCadastro.insert;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProdutoDestino;
      ProCadastro.FieldByName('CODTECNICO').AsInteger := Tabela.FieldByName('CODTECNICO').AsInteger;
      ProCadastro.FieldByName('CODFILIAL').AsInteger := Tabela.FieldByName('CODFILIAL').AsInteger;
      ProCadastro.FieldByName('CODCOR').AsInteger := Tabela.FieldByName('CODCOR').AsInteger;
      ProCadastro.FieldByName('CODTAMANHO').AsInteger := Tabela.FieldByName('CODTAMANHO').AsInteger;
      ProCadastro.FieldByName('DATALTERACAO').AsDateTime;
    end
    else
      ProCadastro.Edit;
    ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat +
                          CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString,UnidadePadrao(VpaSeqProdutoDestino),
                                 Tabela.FieldByName('QTDPRODUTO').AsFloat,IntToStr(VpaSeqProdutoDestino));
    ProCadastro.post;
    Tabela.next;
  end;
  Tabela.close;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;var VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):Boolean;
begin
  ProCadastro.close;
  ProCadastro.sql.clear;
  ProCadastro.sql.add('Select * from FRACAOOP '+
                      ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                      ' and SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                      ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto));
  if VpaTipOperacao = 'S' then
    ProCadastro.sql.add(' and CODESTAGIO = '+IntToStr(VARIA.EstagioOrdemProducao))
  else
    ProCadastro.sql.add(' and CODESTAGIO = '+IntToStr(VARIA.EstagioFinalOrdemProducao));
  if VpaCodCor <> 0 then
    ProCadastro.sql.add('and CODCOR = '+IntToStr(VpaCodCor));
  ProCadastro.open;
  While not ProCadastro.eof and (VpaQtdProduto > 0) do
  begin
    if VpaTipOperacao = 'S' then
    begin
      ProCadastro.edit;
      if (VpaQtdProduto >= (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDAFATURAR').AsFloat)) then
      begin
        VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDAFATURAR').AsFloat);
        ProCadastro.FieldByName('QTDAFATURAR').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat;
      end
      else
      begin
        ProCadastro.FieldByName('QTDAFATURAR').AsFloat := ProCadastro.FieldByName('QTDAFATURAR').AsFloat + VpaQtdProduto;
        VpaQtdProduto := 0;
      end;
      ProCadastro.Post;
      if ProCadastro.FieldByName('QTDAFATURAR').AsFloat >= ProCadastro.FieldByName('QTDPRODUTO').AsFloat then
        FunOrdemProducao.AlteraEstagioFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,ProCadastro.FieldByName('SEQFRACAO').AsInteger,
                                                Varia.EstagioFinalOrdemProducao);
    end
    else
      if VpaTipOperacao = 'E' then
      begin
        ProCadastro.edit;
        if (VpaQtdProduto >= (ProCadastro.FieldByName('QTDAFATURAR').AsFloat)) then
        begin
          VpaQtdProduto := VpaQtdProduto - ProCadastro.FieldByName('QTDAFATURAR').AsFloat;
          ProCadastro.FieldByName('QTDAFATURAR').Clear;
        end
        else
        begin
          ProCadastro.FieldByName('QTDAFATURAR').AsFloat := ProCadastro.FieldByName('QTDAFATURAR').AsFloat - VpaQtdProduto;
          VpaQtdProduto := 0;
        end;
        ProCadastro.Post;
        if ProCadastro.FieldByName('QTDAFATURAR').AsFloat = 0 then
          FunOrdemProducao.AlteraEstagioFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,ProCadastro.FieldByName('SEQFRACAO').AsInteger,
                                                  VARIA.EstagioOrdemProducao);
      end;
    ProCadastro.next;
  end;
  ProCadastro.close;
  result := VpaQtdProduto = 0;
end;

{******************************************************************************}
function TFuncoesProduto.GeraCodigoBarrasEAN13 : string;
var
  VpfCodBarras : String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from CADPRODUTOS '+
                                   ' Where C_BAR_FOR IS null' );
  while not ProCadastro.Eof do
  begin
    VpfCodBarras := RCodBarrasEAN13Disponivel;
    if VpfCodBarras = 'FIM FAIXA' then
      result := 'FINAL FAIXA CODIGO EAN!!!'#13'A faixa do código EAN foi esgotado.'
    else
    begin
      ProCadastro.Edit;
      ProCadastro.FieldByName('C_BAR_FOR').AsString := VpfCodBarras;
      ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
    end;
    ProCadastro.Next;
    if result <> '' then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqProduto(VpaCodProduto: string): Integer;
begin
  AdicionaSQLAbreTabela(AUX,'SELECT I_SEQ_PRO FROM CADPRODUTOS' +
                            ' WHERE C_COD_PRO = '''+ VpaCodProduto + '''');
  Result:= aux.FieldByName('I_SEQ_PRO').AsInteger;
  AUX.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqProdutoDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'SELECT MAX(I_SEQ_PRO) ULTIMO FROM CADPRODUTOS');
  Result:= AUX.FieldByName('ULTIMO').AsInteger+1;
  AUX.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqProdutoPeloNome(VpaNomProduto: String): integer;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT I_SEQ_PRO FROM CADPRODUTOS' +
                            ' WHERE C_NOM_PRO = '''+ VpaNomProduto + '''');
  Result:= Tabela.FieldByName('I_SEQ_PRO').AsInteger;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ApagaSubMontagensdaListaConsumo(VpaDProduto : TRBDProduto);
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoMP;
begin
  for VpfLaco := VpaDProduto.ConsumosMP.Count - 1 downto 0 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLaco]);
    if ExisteConsumoProdutoCor(VpfDConsumo.SeqProduto,VpfDConsumo.CodCor) then
    begin
      VpfDConsumo.Free;
      VpaDProduto.ConsumosMP.Delete(VpfLaco);
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ConverteNomesProdutosSemAcento;
begin
  AdicionaSQLAbreTabela(ProCadastro,'Select * from CADPRODUTOS ');
  while not ProCadastro.eof do
  begin
    ProCadastro.Edit;
    ProCadastro.FieldByName('C_NOM_PRO').AsString := RetiraAcentuacao(UpperCase(ProCadastro.FieldByName('C_NOM_PRO').AsString));
    ProCadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(ProCadastro);
    ProCadastro.Post;
    ProCadastro.next;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: string;
  VpaDProdutoaProduzir: TRBDChamadoProdutoaProduzir): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO,  '+
                                     ' PRE.N_VLR_VEN '+
                                     ' FROM CADPRODUTOS PRO, MOVTABELAPRECO PRE'+
                                     ' WHERE PRE.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                                     ' AND PRE.I_COD_TAB = '+ IntToStr(Varia.TabelaPreco)+
                                     ' and PRE.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                     ' AND PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDProdutoaProduzir.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDProdutoaProduzir.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDProdutoaProduzir.DesUM:= ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDProdutoaProduzir.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDProdutoaProduzir.ValUnitario := ProProduto.FieldByName('N_VLR_VEN').AsFloat;

      VpaDProdutoaProduzir.UnidadesParentes.Free;
      VpaDProdutoaProduzir.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProdutoaProduzir.DesUM);
      VpaDProdutoaProduzir.Quantidade:= 1;
    end;
    ProProduto.Close;
  end;
end;

end.


