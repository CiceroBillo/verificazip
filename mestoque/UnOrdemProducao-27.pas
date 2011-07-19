Unit UnOrdemProducao;
{Verificado
-.edit;
-*= e =*
-post
}
Interface

Uses Classes, DBTables, UnDados,SysUtils, CGrades, UnDadosProduto, UnSistema, comctrls,
     SQLExpr, tabela, db, Unzebra  ;

//classe localiza
Type TRBLocalizaOrdemProducao = class
  private
  public
    constructor cria;
    procedure LocalizaOrdemProducao(VpaTabela : TDataSet;VpaCodFilial, VpaSeqOrdem : String);
    procedure LocalizaColetaOP(VpaTabela : TDataSet;VpaCodFilial, VpaSeqOrdem,VpaSeqColeta : String);
    procedure LocalizaRevisaoExternaOP(VpaTabela : TDataSet;VpaCodFilial,VpaSeqOrdem,VpaSeqColeta : String);
    procedure LocalizaOPProduto(VpaTabela : TDataSet;VpaSeqProduto : Integer);
    procedure LocalizaRomaneioProduto(VpaTabela : TDataSet;VpaCodFilial,VpaSeqRomaneio,VpaSeqItem : Integer);
    procedure LocalizaRomaneio(VpaTabela : TDataSet;VpaCodFilial,VpaSeqRomaneio : Integer);
end;
//classe funcoes
Type TRBFuncoesOrdemProducao = class(TRBLocalizaOrdemProducao)
  private
    OrdAux,
    OrdTabela,
    OrdOrdemProducao : TSQLQUERY;
    OrdCadastro,
    OrdCadastro2 : TSQL;
    function verificaOperacoesEstoque : string;
    procedure CarTipoFundoCadarco(VpaDOpItem : TRBDOPItemCadarco);
    procedure CarGrossuraCadarco(VpaDOpItem : TRBDOPItemCadarco);
    function RSeqOrdemDisponivel(VpaFilial : String):Integer;
    function RSeqColetaOPDisponivel(VpaFilial, VpaSeqOrdem  : String) : Integer;
    function RSeqRomaneioDisponivel(VpaFilial : String) :Integer;
    function RSeqRomaneio(VpaSeqFilial : String) : Integer;
    function RSeqMaquinaDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqItem : String):Integer;
    function RSeqEstagioFracaoOpDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqFracao : Integer):Integer;
    function RSeqColetaFracaoOPDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqEstagio : Integer):Integer;
    function RSeqColetaRomaneioOPDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqFracao : Integer):Integer;
    function RSeqRomaneioProdutoDisponivel(VpaFilial,VpaSeqRomaneio : Integer):Integer;
    function RSeqFracaoFaccionistaDisponivel(VpaCodFaccionista : Integer) : Integer;
    function RSeqRetornoFracaoFaccionistaDisponivel(VpaCodFaccionista, VpaSeqItem : Integer):Integer;
    function RSeqDevolucaoFracaoFaccionistaDisponivel(VpaCodFaccionista, VpaSeqItem : Integer) : Integer;
    function RSeqOrdemCorteDisponivel(VpaCodFilial,VpaSeqOrdemProducao : Integer) : Integer;
    function RSeqPlanoCorteDisponivel(VpaCodFilial : Integer) : Integer;
    function RSeqImpressaoDisponivel : Integer;
    function RQtdItemRomaneio(VpaFilial, VpaSeqRomaneio : String) : Integer;
    function RQtdRomaneioProdutoItem(VpaCodFilial,VpaSeqRomaneio,VpaSeqItem : Integer) : Integer;
    function RQtdRomaneioProduto(VpaCodFilial,VpaSeqRomaneio : Integer) : Integer;
    function RProdutividadeCelula(VpaData : TDateTime;VpaCodCelula : Integer) : Integer;
    function REstagioProducao(VpaDFracao : TRBDFracaoOrdemProducao;VpaSeqEstagio : Integer): TRBDordemProducaoEstagio;
    function RItemRomaneioProduto(VpaSeqRomaneio : Integer;VpaDColeta : TRBDColetaRomaneioOp):Integer;
    function RConsumoOP(VpaDOrdemProducao : TRBDOrdemProducao; VpaDFracaoOp : TRBDFracaoOrdemProducao; VpaDConsumoProduto : TRBDConsumoMP) : TRBDConsumoOrdemProducao;
    function RTextoEstagiosFracao(VpaDFracao : TRBDFracaoOrdemProducao) : string;
    function RComprimentoOrdemSerra(VpaComprimento : Double):Double;
    function ROrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao; VpaSeqMateriaPrima, VpaSeqProduto : Integer;VpaComMateriaPrima : Double;VpaNomMateriaPrima : string) : TRBDOrdemSerra;
    procedure CarBastidorOrdemCorte(VpaDConsumo : TRBDConsumoMP;VpaDOrdemCorteItem :TRBDOrdemCorteItem);
    function AdicionaConsumoOrdemCorte(VpaDOrdemProducao : TRBDOrdemProducao; VpaDFracaoOp : TRBDFracaoOrdemProducao) : TRBDConsumoOrdemProducao;
    procedure AdicionaCosumoOrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao; VpaDFracaoOp : TRBDFracaoOrdemProducao; VpaDConsumoProduto : TRBDConsumoMP);
    procedure FinalizaRomaneio(VpaFilial,VpaSeqRomaneio : String);
    function GravaOrdemProducaoItem(VpaDOrdem : TRBDOrdemProducaoEtiqueta):string;
    function GravaDOPItemCadarco(VpaDOrdem : TRBDOrdemProducaoEtiqueta):string;
    function GravaDOpItemMaquina(VpaDOrdem : TRBDOrdemProducaoEtiqueta):String;
    function GravaDColetaOPItem(VpaDColetaOP : TRBDColetaOP): String;
    function GravaDFracoesOP(VpaDOrdemProducao : TRBDOrdemProducao):string;
    function GravaDFracaoOPCompose(VpaDOrdemProducao : TRBDOrdemProducao):string;
    function GravaDFracaoOPEstagio(VpaDOrdemProducao : TRBDOrdemProducao):string;overload;
    function GravaDFracaoOPEstagio(VpaDFracao : TRBDFracaoOrdemProducao;VpaCodFilial,VpaSeqOrdem,VpaSeqProduto : Integer;VpaExcluirAntes : Boolean):string;overload;
    function GravaDFracaoOpEstagioReal(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;
    function GravaDConsumoOPAgrupada(VpaDOrdemProducao : TRBDOrdemProducao) :String;
    function GravaDConsumoFracoes(VpaDOrdemProducao : TRBDOrdemProducao) :String;overload;
    function GravaDConsumoFracoes(VpaCodFilial, VpaSeqOrdem : Integer; VpaDFracao : TRBDFracaoOrdemProducao) :String;overload;
    function GravaDOrdemCorteItem(VpaDOrdemCorte : TRBDOrdemCorte) : string;
    function GravaDOrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao) :String;
    function GravaDOrdemSerraFracao(VpaDOrdemProducao : TRBDOrdemProducao) :String;
    function GravaDPlanoCorteItem(VpaDPlanoCorte : TRBDPlanoCorteCorpo) : string;
    function GravaDPlanoCorteFracao(VpaDPlanoCorte : TRBDPlanoCorteCorpo) : string;
    function GravaDImpressaoConsumoFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaConsumo : TList):string;
    function GeraOrdemCortedaOP(VpaDOrdemProducao : TRBDordemProducao) : TRBDOrdemCorte;
    function GeraOrdemCorteItemdaOP(VpaDOrdemCorte : TRBDOrdemCorte; VpaDOrdemProducao : TRBDordemProducao) : String;
    function GeraConsumoFracaoOrdemCorte(VpaDFracaoOP : TRBDFracaoOrdemProducao; VpaDConsumoProduto : TRBDConsumoMP):string;
    procedure CarDOrdemProducaoItem(VpaDOrdem : TRBDOrdemProducaoEtiqueta);
    procedure CarDOpItemCadarco(VpaDOrdem : TRBDOrdemProducaoEtiqueta);
    procedure CarDColetaOPItem(VpaDColeta : TRBDColetaOP);
    procedure CarDEstagioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho);
    procedure CarDHorarioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho);
    procedure CarDOPBasicaTabela(VpaDOrdem : TRBDOrdemProducao;VpaTabela : TDataSet);
    procedure CarDOPBasicaClasse(VpaDOrdem : TRBDOrdemProducao;VpaTabela : TDataSet);
    procedure CarDOrdemSerraFracao(VpaDOrdemProducao : TRBDOrdemProducao);
    procedure CarDPlanoCorteFracoes(VpaDPlanoCorte : TRBDPlanoCorteCorpo;VpaDItemPlano : TRBDPlanoCorteItem);
    procedure CarDPlanoCorteItem(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
    procedure CarDOrdemCorteItem(VpaDOrdemProducao : TRBDordemProducao);
    procedure CarComposeFracaoParaConsumoProduto(VpaDProduto : TRBDProduto;VpaDFracaoOP : TRBDFracaoOrdemProducao);
    procedure CarDConsumoFracao(VpaDFracao : TRBDFracaoOrdemProducao);
    function AtualizaDatasOP(VpaDColetaOP : TRBDColetaOP) : String;
    function AtualizaDColetadosOP(VpaDColetaOP : TRBDColetaOP ) : String;
    function AtualizaDFracoesEnviadasFaccionista(VpaDFracaoFaccionista : TRBDFracaoFaccionista):String;
    function AtualizaDFracaoOpFaccionista(VpaDRetornoFracao : TRBDRetornoFracaoFaccionista):String;
    function AtulaizaDevolucaFracaoFaccionista(VpaDDevolucaoFracao : TRBDDevolucaoFracaoFaccionista) : String;
    procedure AlteraEstagiosFracoesPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
    function ExtornaAtualizacoesRetornoFaccionista(VpaCodFaccionista,VpaSeqItem, VpaSeqRetorno : Integer):String;
    function ExtornaAtualizacoesDevolucaoFaccionista(VpaCodFaccionista,VpaSeqItem, VpaSeqDevolucao : Integer):String;
    function ExtornaAtualizacaoEnvioFaccionista(VpaCodFaccionista, VpaSeqItem : Integer):string;
    function CadastraNovoRomaneioFilial(VpaSeqFilial : String) : Integer;
    function MarcaColetaAdicionada(VpaFilial,VpaSeqOrdem,VpaSeqColeta : String):String;
    function MarcaConsumoFracaoBaixado(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao : Integer):string;
    procedure MarcaEstagioNaoProcessado(VpaDFracao : TRBDFracaoOrdemProducao;VpaCodEstagio : Integer);
    procedure ApagaProdutividadeCelula(VpaCodCelula : Integer;VpaData : TDateTime);
    procedure ExcluiProdutoRomaneioItem(VpaSeqRomaneio,VpaSeqItem : Integer; VpaDColetaRomaneio : TRBDColetaRomaneioOp);
    procedure BaixaQtdFracaoOPEstagio(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio : Integer;VpaQtd : Double;VpaIndExtornar : Boolean);
    function ExtornaColetadoRomaneioProduto(VpaSeqRomaneio,VpaSeqItem : Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp; VpaDOrdemProducao : TRBDordemProducao;VpaQtdProduto : Double):string;
    function ExtornaColetadoRomaneio(VpaSeqRomaneio: Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp; VpaDOrdemProducao : TRBDordemProducao;VpaQtdProduto : Double):string;
    procedure CopiaQtdColetadoEstagio(VpaDFracaoOrigem, VpaDFracaoDestino : TRBDFracaoOrdemProducao);
    procedure ArrumaQtdProduzidaEstagio(VpaDFracaoAntiga, VpaDFracaoNova : TRBDFracaoOrdemProducao);
    function AdicionaProdutoRomaneioItem(VpaSeqRomaneio,VpaSeqItem : Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao):String;
    function AdicionaProdutoRomaneio(VpaSeqRomaneio : Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao;VpaQtdProduto : Double):String;
    function AdicionaColetaFracaoOpRomaneio(VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao):String;
    function AdicionaNotaRomaneionoOrcamento(VpaCodfilial,VpaSeqNota, VpaLanOrcamento : Integer;VpaNumNota : string):string;
    function EliminaColetaFracaoOPRomaneio(VpaSeqRomaneio : Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao):String;
    procedure ZeraQtdaFaturarFracao(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao : Integer);
    function BaixaRomaneioMovOrcamento(VpaCodfilial, VpaLanOrcamento, VpaIteOrcamento,VpaSeqProduto : Integer;VpaDesUMColeta,VpaDesUMPEDIDO : String;VpaQtdColetado : Double;VpaEstornar : Boolean):string;
    function ComposeIgual(VpaCompose1, VpaCompose2 : TList):Boolean;
    function ExisteProdutoGerarOP(VpaDProduto : TRBDOrcProduto;VpaGerarOp : TList) : TRBDGerarOp;
    procedure GeraConsumoOPAgrupada(VpaDOrdemProducao : TRBDordemProducao);
    procedure GeraConsumoFracao(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao : TRBDFracaoOrdemProducao;VpaDProduto : TRBDProduto);
    procedure OrdenaOrdemSerra(VpaDOrdemProducao : TRBDordemProducao);
    procedure ExcluiProdutoOrdemSerra(VpaDOrdemProducao : TRBDordemProducao;VpaDFracao : TRBDFracaoOrdemProducao;VpaDConsumoFracao : TRBDConsumoOrdemProducao);
    function ReImportaFracaoVerificaEstagioFracao(VpaDFracao : TRBDFracaoOrdemProducao;VpaDProduto : TRBDProduto):string;
    function ReImportaFracaoConsumoOP(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao : TRBDFracaoOrdemProducao;VpaDProduto : TRBDProduto):string;
    function ReImportaFracoesFilhas(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao : TRBDFracaoOrdemProducao;VpaDProduto : TRBDProduto):string;
    function AdicionaLogReimportacaoFracao(VpaDFracao : TRBDFracaoOrdemProducao):string;
//    procedure AlteraQtdReservadaFracaoOPConsumo(VpaDOP : TRBDordemProducao;VpaDFracao : TRBDFracaoOP;VpaDConsumo : TRBDConsumoFracaoOP
  public
    VplQtdFracoes : Integer;
    constructor cria(VpaBaseDados : TSQLConnection );
    destructor destroy;override;
    function GravaDOrdemProducaoBasicao(VpaDOrdem : TRBDOrdemProducao) :String;
    function GravaOrdemProducao(VpaDOrdem : TRBDOrdemProducaoEtiqueta):String;
    function GravaDOrdemCorte(VpaDOrdemCorte : TRBDOrdemCorte) : string;
    function GravaDColetaOP(VpaDColetaOP : TRBDColetaOP):String;
    function GravaDRevisaoExternaOP(VpaDColetaOP : TRBDColetaOP;VpaCodUsuario : Integer):String;
    function GravaDEstagioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho) : String;
    function GravaDHorarioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho) : String;
    function GravaDColetaFracaoOP(VpaDColetaFracao : TRBDColetaFracaoOp) : String;
    function GravaDColetaRomaneioOP(VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao) : string;
    function GravaDFracaoFaccionista(VpaDFracaoFaccionista : TRBDFracaoFaccionista) : string;
    function GravaDRetornoFracaoFaccionista(VpaDRetornoFracao : TRBDRetornoFracaoFaccionista):string;
    function GravaDDevolucaoFracaoFaccionista(VpaDDevolucaoFracao : TRBDDevolucaoFracaoFaccionista) : string;
    function GravaDRevisaoFracaoFaccionista(VpaDRevisaoFracao : TRBDRevisaoFracaoFaccionista) : string;
    function GravaConsumoOP(VpaDOrdemProducao : TRBDordemProducao):String;
    function GravaDPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo) : string;
    function GeraOrdemCorte(VpaDOrdemProducao : TRBDOrdemProducao):string;
    function AlteraEstagio(VpaDOrdem : TRBDOrdemProducaoEtiqueta):String;
    function AlteraCliente(VpaCodFilial,VpaSeqOrdem, VpaCodCliente : Integer):string;
    function AlteraMaquina(VpaDOrdem : TRBDOrdemProducaoEtiqueta) : String;
    function AlteraValorUnitario(VpaDOrdem : TRBDOrdemProducaoEtiqueta) : String;
    function AlteraEstagioFracaoOP(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;overload;
    function AlteraEstagioFracaoOp(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer; VpaCodEstagio : Integer) :String;overload;
    function AlteraDataRenegociacaoFracaoFaccionista(VpaCodFaccionista, VpaSeqItem : Integer; VpaIndRenegociado : Boolean; VpaNovaData : TDAteTime):String;
    function AtteraDataEntregaFracao(VpaDFracao : TRBDFracaoOrdemProducao):string;
    function ConcluiEstagioFracao(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;
    function ConcluiEstagioRealFracao(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;
    function CarDOrdemProducaoBasica(VpaCodfilial,VpaSeqOrdem : Integer; VpaDOrdem : TRBDOrdemProducao) : boolean;
    procedure CarDFracaoOpAgrupada(VpaDFracao :TRBDFracaoOrdemProducao;VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer);
    function CarDOrdemProducao(VpaDOrdem : TRBDOrdemProducaoEtiqueta):Boolean;
    procedure CarDColetaOP(VpaDColetaOP : TRBDColetaOP);
    procedure CarDTecnicosCadarco(VpaDOp : TRBDOrdemProducaoEtiqueta; VpaDOPItem : TRBDOPItemCadarco);
    procedure CarDCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho);
    procedure CarDColetaRomaneioOP(VpaDColeta : TRBDColetaRomaneioOp;VpaCodFilial,VpaSeqOrdem, VpaSeqFracao,VpaSeqColeta : Integer);
    procedure CarDPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo;VpaCodFilial, VpaSeqPlano : Integer);
    procedure CarDFracaoOPEstagio(VpaDFracao : TRBDFracaoOrdemProducao;VpaCodFilial,VpaSeqOrdemProducao : Integer);overload;
    procedure CarDFracaoOPEstagio(VpaDOrdem : TRBDOrdemProducao); overload;
    procedure CarQtdMetrosMaquina(VpaDOPItem : TRBDOPItemCadarco);
    procedure CarItensColetaOP(VpaDColetaOP : TRBDColetaOP;VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
    procedure CarGerarOP(VpaCotacoes, VpaProdutos : TList);
    function CarDFracaoOP(VpaDOrdem : TRBDOrdemProducao;VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer): TRBDFracaoOrdemProducao;
    procedure CarDOrdemCorte(VpaDOrdem : TRBDordemProducao);
    procedure CarDOrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao;VpaSeqOrdemInicial, VpaSeqOrdemFinal : Integer);
    procedure CarFracoesProduto(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqProduto : Integer;VpaFracoes : TList);
    procedure CopiaCompose(VpaComposeDe, VpaComposePara : TList);
    function CombinacaoManequimDuplicado(VpaDOrdem : TRBDOrdemProducaoEtiqueta):Boolean;
    function RNomeMaquina(VpaCodMaquina : String):String;
    function RNomeEstagio(VpaCodEstagio : Integer) : String;
    function RNumTabuasExtenso(VpaTipoOP : Integer;VpaNumTabuas, VpaQtdMetros : Double):String;
    function EstagioFinal(VpaCodEstagio : Integer) : Boolean;
    procedure CalculaTotaisMetros(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
    function ArredondaMetroFita(VpaMetros : Double) : Double;
    function RQtdHoras(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta; VpaDProduto : TRBDProduto):String;
    function RQtdHorasEstagio(VpaDEstagioOP : TRBDordemProducaoEstagio;VpaDEstagioProduto : TRBDEstagioProduto;VpaQtdProduto : Double):string;
    function RTotalHorasOP(VpaDFracaoOP : TRBDFracaoOrdemProducao):String;
    function RFracaoOP(VpaDOrdemProducao : TRBDordemProducao;VpaSeqFracao : Integer):TRBDFracaoOrdemProducao;
    function RProximoEstagioFracao(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao,VpaEstagioAtual : Integer):Integer;
    procedure CarValoreSeqItemFaccionista(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio, VpaCodFaccionista : Integer;VpaIndDefeito : Boolean;VpaDRetornoFaccionista : TRBDRetornoFracaoFaccionista);
    procedure ConfigGradeTearConvencional(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaGrade : TRBStringGridColor);
    procedure ConfigGradeTearH(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaGrade : TRBStringGridColor);
    procedure AtualizaQtdMetrosColetadoOP(VpaDColetaOP : TRBDColetaOP);
    function AtualizaQtdRenegociacoesFaccionista(VpaCodFaccionista : Integer;VpaIndRenegociado : Boolean):string;
    function AdicionaColetaRomaneio(VpaEmpFil,VpaSeqOrdem, VpaSeqColeta : String): String;
    function AdicionaEstoqueColetaOP(VpaDOrdemProducao :TRBDOrdemProducaoEtiqueta;VpaDColetaOP : TRBDColetaOP):String;
    procedure AdicionaEstagiosOP(VpaDProduto : TRBDProduto;VpaDFracao :TRBDFracaoOrdemProducao;VpaProducaoExterna : Boolean);
    function AdicionaQtdAFaturarFracao(VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao;VpaExtornar : Boolean):string;
    procedure AdicionaProdutosSubMontagem(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracaoPrincipal : TRBDFracaoOrdemProducao;VpaBarraStatus : TStatusBar;VpaCarregarTodosFilhos : Boolean);
    function AdicionaFracaoPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo;VpaSeProduto : Integer;VpaCodProduto,VpaNomProduto : string):TRBDPlanoCorteFracao;
    procedure RecalculaHorasEstagio(VpaDOrdemProducao : TRBDordemProducao; VpaDFracao : TRBDFracaoOrdemProducao);
    function BaixaEstoqueRomaneio(VpaCodFilial,VpaSeqRomaneio : Integer;VpaEstornar : boolean) : String;
    function BaixaRomaneioComoFaturado(VpaEmpFil, VpaSeqRomaneio,VpaSeqNota, VpaCodFilialNota : Integer) : String;
    function BaixaRomaneioGenerico(VpaCodFilial, VpaSeqRomaneio, VpaSeqNota : Integer;VpaNumNota : string) : string;
    function BaixaConsumoFracaoAlteraEstagio(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer):string;
    function BaixaEstoqueConsumoFracaoOP(VpaCodFilial : Integer;VpaConsumos : TList):string;
    function ExtornaRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio : Integer):String;
    procedure ExtornaPlanoCortecomImpresso(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
    procedure FinalizarRomaneio(VpaFilial, VpaSeqRomaneio : String);
    function FinalizaFracaoFraccionista(VpaCodFaccionista,VpaSeqItem : Integer):string;
    procedure GeraOPdaCotacao(VpaDCotacao : TRBDOrcamento;VpaDOP : TRBDOrdemProducao);
    procedure GeraFracoesOP(VpaDOrdemProducao : TRBDOrdemProducao);
    procedure GeraConsumoOP(VpaDOrdemProducao : TRBDordemProducao);
    procedure GeraImpressaoConsumoFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaListaAExcluir : Boolean);
    procedure SetaRomaneioGeradoNota(VpaEmpFil, VpaSeqRomaneio: String);
    procedure SetaRomaneioImpresso(VpaEmpFil, VpaSeqRomaneio : String);
    procedure SetaFichaConsumoImpressa(VpaCodFilial, VpaSeqOrdem : Integer);
    procedure SetaPlanoCorteGerado(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaGerado : Boolean);
    procedure ExcluiRevisaoExterna(VpaEmpFil,VpaSeqOrdem, VpaSeqColeta,VpaCodUsuario : String);
    function ExcluiOrdemProducao(VpaCodFilial, VpaSeqOrdem : Integer):String;
    function ExcluiFracaoOP(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer):String;
    procedure ExcluiColetaFracaoOP(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqEstagio, VpaSeqColeta : Integer);
    function ExcluiColetaRomaneioOP(VpaCodFilial,VpaSeqRomaneio,VpaSeqOrdem,VpaSeqFracao,VpaSeqColeta : Integer):string;
    procedure ExcluiFracaoFaccionista(VpaCodFaccionista,VpaSeqItem : Integer);
    procedure ExcluiRetornoFracaoFaccionista(VpaCodFaccionista,VpaSeqItem, VpaSeqRetorno : Integer);
    function ExcluiDevolucaoFracaoFaccionista(VpaCodFaccionista,VpaSeqItem,VpaSeqDevolucao : Integer):string;
    procedure ExcluiPlanoCorte(VpaCodFilial, VpaSeqPlanoCorte : Integer);
    function ExisteMaquina(VpaCodMaquina : String;VpaDMaquina : TRBDOPItemMaquina) : Boolean;
    function ExisteEstoqueCombinacao(VpaSeqProduto : Integer):Boolean;
    function ExisteEstagioCelulaDuplicado(VpaDCelula : TRBDCelulaTrabalho):Boolean;
    function ExisteHorarioCelulaDuplicado(VpaDCelula : TRBDCelulaTrabalho) : Boolean;
    function ExisteHorarioTrabalho(VpaCodHorario : string;var VpaDesHoraInicio, VpaDesHoraFim : String):Boolean;
    function ExisteFracaoFaccionista(VpaDFracaoFaccionista : TRBDFracaoFaccionista) : Boolean;
    function ExisteBastidor(VpaCodBastidor : Integer; VpaDOrdemCorteItem : TRBDOrdemCorteItem) : Boolean;
    procedure ProcessaProdutividadeCelula(VpaCodCelula : Integer;VpaData : TDateTime);
    procedure RegeraFracaoOPEstagio(VpaSeqProduto : Integer);
    function ReImportaFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer) : string;
    procedure ImprimeEtiquetaFracao(VpaDOrdemProducao : TRBDordemProducao);
    procedure ImprimeEtiquetaOrdemSerra(VpaDOrdemProducao : TRBDordemProducao);
    procedure ImprimeEtiquetasFracaoPremer(VpaEtiquetas : TList);
    procedure ImprimeEtiquetasPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
    procedure ImprimeEtiquetaNroOP(VpaSeqOrdem : INteger;VpaNomCiente : String);
    procedure CarIconeNoFracao(VpaNo : TTreeNode;VpaDFracao : TRBDFracaoOrdemProducao);
    procedure AdicionaNoFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaNoPai : TTreeNode;VpaArvore : TTreeView);
    procedure CarregaArvoreSubMontagem(VpaTabela : TDataSet;VpaArvore : TTreeView);
    procedure ReservaQtdEstoqueFracao(VpaDOP : TRBDordemProducao);
end;

var
  FunOrdemProducao : TRBFuncoesOrdemProducao;

implementation

Uses FunSql, FunObjeto, FunNumeros, ConstMsg, Constantes, Funstring, UnProdutos, FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaOrdemProducao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaOrdemProducao.cria;
begin
  inherited create;
end;

{******************************************************************************}
procedure TRBLocalizaOrdemProducao.LocalizaOrdemProducao(VpaTabela : TDataSet;VpaCodFilial, VpaSeqOrdem : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from ORDEMPRODUCAOCORPO '+
                                  ' Where EMPFIL = '+VpaCodFilial +
                                  ' AND SEQORD = '+ VpaSeqOrdem);
end;

{******************************************************************************}
procedure TRBLocalizaOrdemProducao.LocalizaColetaOP(VpaTabela : TDataSet;VpaCodFilial, VpaSeqOrdem,VpaSeqColeta : String);
begin
  AdicionaSqlAbreTabela(VpaTabela,'Select * from COLETAOPCORPO ' +
                                  ' Where EMPFIL = '+VpaCodFilial +
                                  ' AND SEQORD = '+ VpaSeqOrdem+
                                  ' and SEQCOL = '+ VpaSeqColeta);

end;

{******************************************************************************}
procedure TRBLocalizaOrdemProducao.LocalizaRevisaoExternaOP(VpaTabela : TDataSet;VpaCodFilial,VpaSeqOrdem,VpaSeqColeta : String);
begin
  AdicionaSqlAbreTabela(VpaTabela,'Select * from REVISAOOPEXTERNA '+
                                  ' Where EMPFIL = '+VpaCodFilial +
                                  ' AND SEQORD = '+ VpaSeqOrdem+
                                  ' and SEQCOL = '+ VpaSeqColeta);
end;

{******************************************************************************}
procedure TRBLocalizaOrdemProducao.LocalizaOPProduto(VpaTabela : TDataSet;VpaSeqProduto : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select ORD.EMPFIL, ORD.SEQORD '+
                                  ' from ORDEMPRODUCAOCORPO ORD '+
                                  ' Where ORD.SEQPRO = '+IntToStr(VpaSeqProduto));
end;

{******************************************************************************}
procedure TRBLocalizaOrdemProducao.LocalizaRomaneioProduto(VpaTabela : TDataSet;VpaCodFilial,VpaSeqRomaneio,VpaSeqItem : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from ROMANEIOPRODUTO '+
                                    ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                    ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio)+
                                    ' and SEQITEM = ' + IntToStr(VpaSeqItem));
end;

{******************************************************************************}
procedure TRBLocalizaOrdemProducao.LocalizaRomaneio(VpaTabela : TDataSet;VpaCodFilial,VpaSeqRomaneio : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from ROMANEIOCORPO '+
                                    ' Where EMPFIL = ' +IntToStr(VpaCodFilial)+
                                    ' and SEQROM = ' + IntToStr(VpaSeqRomaneio));
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesOrdemProducao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesOrdemProducao.cria(VpaBaseDados : TSQLConnection );
begin
  inherited create;
  OrdAux := TSQLQuery.Create(nil);
  OrdAux.SQLConnection := VpaBaseDados;
  OrdTabela := TSQLQuery.Create(nil);
  OrdTabela.SQLConnection := VpaBaseDados;
  OrdCadastro := TSQL.Create(nil);
  OrdCadastro.ASQLConnection := VpaBaseDados;
  OrdCadastro2 := TSQL.Create(nil);
  OrdCadastro2.ASQLConnection := VpaBaseDados;
  OrdOrdemProducao := TSQLQuery.Create(nil);
  OrdOrdemProducao.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesOrdemProducao.destroy;
begin
  OrdAux.free;
  OrdTabela.free;
  ordCadastro.free;
  OrdCadastro2.free;
  OrdOrdemProducao.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqOrdemDisponivel(VpaFilial : String):Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select max(SEQORD) ULTIMO from ORDEMPRODUCAOCORPO '+
                               ' Where EMPFIL = '+VpaFilial);
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarTipoFundoCadarco(VpaDOpItem : TRBDOPItemCadarco);
var
  VpfNomProduto: string;
begin
  VpfNomProduto := RetiraAcentuacao(VpaDOPItem.NomProduto);
  VpfNomProduto := UpperCase(VpfNomProduto);
  if ExistePalavra(VpfNomProduto,'ALGODAO') or ExistePalavra(VpfNomProduto,'ALG') then
  begin
    VpaDOPItem.IndAlgodao := 'S';
  end
  else
    if ExistePalavra(VpfNomProduto,'POLIESTER') or ExistePalavra(VpfNomProduto,'POLIES') then
      VpaDOPItem.IndPoliester := 'S';
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.verificaOperacoesEstoque : string;
begin
  result := '';
  if varia.OperacaoEstoqueEstornoEntrada = 0 then
    result := 'OPERAÇÃO ESTOQUE ESTORNO ENTRADA VAZIA!!!'#13'A operação de estoque de estorno de entrada não foi preenchida.'
  else
    if varia.OperacaoEstoqueEstornoSaida = 0 then
      result := 'OPERAÇÃO ESTOQUE ESTORNO SAIDA VAZIA!!!'#13'A operação de estoque de estorno de saida não foi preenchida.';
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarGrossuraCadarco(VpaDOpItem : TRBDOPItemCadarco);
var
  VpfNomProduto,VpfDesGrossura : string;
begin
  VpfNomProduto := UpperCase(VpaDOPItem.NomProduto);
  VpfDesGrossura := FunProdutos.RDesMMProduto(VpfNomProduto);
  if VpfDesGrossura <> '' then
  begin
    VpfDesGrossura := DeletaChars(DeletaChars(VpfDesGrossura,'M'),' ');
    VpaDOPItem.Grossura := StrToFloat(VpfDesGrossura);
  end;
end;
{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqColetaOPDisponivel(VpaFilial, VpaSeqOrdem  : String) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select max(SEQCOL) ULTIMO from COLETAOPCORPO '+
                               ' Where EMPFIL = '+VpaFilial+
                               ' and SEQORD = '+VpaSeqOrdem );
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqRomaneioDisponivel(VpaFilial : String) :Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select MAX(SEQROM) ULTIMO from ROMANEIOCORPO '+
                               ' Where EMPFIL = '+ VpaFilial);
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RQtdItemRomaneio(VpaFilial, VpaSeqRomaneio : String) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select COUNT(DISTINCT(SEQORD)) QTD from ROMANEIOITEM '+
                               ' Where EMPFIL = '+ VpaFilial+
                               ' and SEQROM = '+ VpaSeqRomaneio);
  result := OrdAux.FieldByName('QTD').AsInteger;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RQtdRomaneioProdutoItem(VpaCodFilial,VpaSeqRomaneio,VpaSeqItem : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select COUNT(CODFILIAL) QTD FROM ROMANEIOPRODUTOITEM '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio)+
                               ' and SEQITEM = '+IntToStr(VpaSeqItem));
  result := OrdAux.FieldByName('QTD').AsInteger;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RQtdRomaneioProduto(VpaCodFilial,VpaSeqRomaneio : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select COUNT(CODFILIAL) QTD FROM ROMANEIOPRODUTO '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio));
  result := OrdAux.FieldByName('QTD').AsInteger;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RProdutividadeCelula(VpaData : TDateTime;VpaCodCelula : Integer) : Integer;
VAR
  VpfQtdTotalMinutos : Integer;
  VpfPerTempo, VpfProdutividade : Double;
begin
  VpfProdutividade := 0;
  AdicionaSQLAbreTabela(OrdAux,'Select SUM(QTDMINUTOS) TOTAL from COLETAFRACAOOP '+
                               ' Where '+SQLTextoDataEntreAAAAMMDD('DATINICIO',VpaData,IncDIA(VpaData,1),false)+
                               ' and CODCELULA = ' +IntToStr(VpaCodCelula));
  VpfQtdTotalMinutos := OrdAux.FieldByName('TOTAL').AsInteger;
  OrdAux.Close;

  AdicionaSQLAbreTabela(OrdTabela,'Select * from COLETAFRACAOOP '+
                               ' Where '+SQLTextoDataEntreAAAAMMDD('DATINICIO',VpaData,IncDIA(VpaData,1),false)+
                               ' and CODCELULA = ' +IntToStr(VpaCodCelula));
  While not ordTabela.Eof do
  begin
    VpfPerTempo := (OrdTabela.FieldByName('QTDMINUTOS').AsInteger * 100)/VpfQtdTotalMinutos;
    VpfProdutividade := VpfProdutividade + (OrdTabela.FieldByName('PERPRODUTIVIDADE').AsInteger * VpfperTempo)/100;
    Ordtabela.next;
  end;
  result := RetornaInteiro(VpfProdutividade);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.REstagioProducao(VpaDFracao : TRBDFracaoOrdemProducao;VpaSeqEstagio : Integer): TRBDordemProducaoEstagio;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDFracao.Estagios.Count - 1 do
  begin
    if TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLaco]).SeqEstagio = VpaSeqEstagio then
    begin
      result := TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLaco]);
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RItemRomaneioProduto(VpaSeqRomaneio : Integer; VpaDColeta : TRBDColetaRomaneioOp):Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select SEQITEM from ROMANEIOPRODUTOITEM '+
                               ' Where CODFILIAL = '+IntToStr(VpaDColeta.CodFilial)+
                               ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio)+
                               ' and SEQORDEM = '+IntToStr(VpaDColeta.NumOrdemProducao)+
                               ' and SEQFRACAO = '+IntToStr(VpaDColeta.SeqFracao)+
                               ' AND SEQCOLETA = '+IntToStr(VpaDColeta.SeqColeta));
  Result := OrdAux.FieldByName('SEQITEM').AsInteger;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RComprimentoOrdemSerra(VpaComprimento: Double): Double;
begin
  Result := ArredondaPraMaior(VpaComprimento*10)/10;//multiplicado por 10 para arrendodar apenas os milimetros, se a medida for 5,12 cm é para ficar 5,2cm
end;

function TRBFuncoesOrdemProducao.RConsumoOP(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracaoOP : TRBDFracaoOrdemProducao; VpaDConsumoProduto : TRBDConsumoMP) : TRBDConsumoOrdemProducao;
var
  VpfLaco : Integer;
  VpfDConsumoOp : TRBDConsumoOrdemProducao;
begin
  result := nil;
  if varia.TipoOrdemProducao = toAgrupada then
  begin
    for VpfLaco := 0 to VpaDOrdemProducao.Consumo.Count - 1 do
    begin
      VpfDConsumoOp := TRBDConsumoOrdemProducao(VpaDOrdemProducao.Consumo.Items[VpfLaco]);
      if (VpaDConsumoProduto.SeqProduto = VpfDConsumoOp.SeqProduto) and
         (VpaDConsumoProduto.CodCor = VpfDConsumoOp.CodCor) and
         (VpaDConsumoProduto.CodFaca = VpfDConsumoOp.CodFaca) and
         (VpaDConsumoProduto.AlturaMolde = VpfDConsumoOp.AltMolde) and
         (VpaDConsumoProduto.LarguraMolde = VpfDConsumoOp.LarMolde) then
      begin
        result := VpfDConsumoOp;
        break;
      end;
    end;
  end;
  if result = nil then
  begin
    if Varia.TipoOrdemProducao = toAgrupada then
      result := VpaDOrdemProducao.AddConsumo
    else
      result := vpadFracaoOp.AddConsumo;
    Result.SeqProduto := VpaDConsumoProduto.SeqProduto;
    result.CodCor := VpaDConsumoProduto.CodCor;
    Result.CodFaca := VpaDConsumoProduto.CodFaca;
    Result.AltMolde := VpaDConsumoProduto.AlturaMolde;
    Result.LarMolde := VpaDConsumoProduto.LarguraMolde;
    result.DesObservacoes := VpaDConsumoProduto.DesObservacoes;
    Result.QtdABaixar := 0;
    Result.QtdBaixado := 0;
    Result.QtdUnitario := VpaDConsumoProduto.QtdProduto;
    Result.UMUnitario := VpaDConsumoProduto.UM ;
    Result.UMOriginal := VpaDConsumoProduto.UMOriginal;
    if (VpaDConsumoProduto.CodFaca <> 0) or (VpaDConsumoProduto.LarguraMolde <> 0) or
       (VpaDConsumoProduto.AlturaMolde <> 0) then
    begin
      result.UM := 'PC';
      result.QtdABaixar := (VpaDConsumoProduto.QtdProduto * VpaDFracaoOp.QtdProduto); ;
      result.IndOrigemCorte := true;
    end
    else
      result.UM := VpaDConsumoProduto.UM;
    if result.UM = 'CM' then
      result.um := 'MT';
    result.IndBaixado := false;
    Result.IndOrdemCorte := false;
    Result.IndMaterialExtra := false;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RTextoEstagiosFracao(VpaDFracao : TRBDFracaoOrdemProducao) : string;
var
  VpfDEStagio : TRBDordemProducaoEstagio;
  VpfLaco : Integer;
begin
  result := '';
  if VpaDFracao.Estagios <> nil then
  begin
    for VpfLaco := 0 to VpaDFracao.Estagios.Count - 1 do
    begin
      VpfDEStagio := TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLaco]);
      Result := result + VpfDEStagio.NomEstagio+ '-';
    end;
    if result <> '' then
      result := copy(result,1,length(result)-1);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ROrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao; VpaSeqMateriaPrima, VpaSeqProduto : Integer;VpaComMateriaPrima : Double;VpaNomMateriaPrima : string) : TRBDOrdemSerra;
var
  VpfLaco : Integer;
  VpfDOrdemSerra : TRBDOrdemSerra;
begin
  result := nil;
  VpaComMateriaPrima := RComprimentoOrdemSerra(VpaComMateriaPrima);

  for VpfLaco := 0 to VpaDOrdemProducao.OrdensSerra.Count - 1 do
  begin
    VpfDOrdemSerra := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLaco]);
    if (VpfDOrdemSerra.SeqMateriaPrima = VpaSeqMateriaPrima) and
       (VpfDOrdemSerra.SeqProduto = VpaSeqProduto) and
       (VpfDOrdemSerra.ComMateriaPrima = VpaComMateriaPrima) then
    begin
      result := VpfDOrdemSerra;
      break;
    end;
  end;
  if result = nil then
  begin
    Result := VpaDOrdemProducao.AddOrdemSerra;
    Result.SeqMateriaPrima := VpaSeqMateriaPrima;
    result.NomMateriaPrima := VpaNomMateriaPrima;
    Result.SeqProduto := VpaSeqProduto;
    Result.QtdProduto := 0;
    Result.ComMateriaPrima := VpaComMateriaPrima;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarBastidorOrdemCorte(VpaDConsumo : TRBDConsumoMP;VpaDOrdemCorteItem :TRBDOrdemCorteItem);
var
  VpfDBastidor : TRBDConsumoMPBastidor;
begin
  if VpaDConsumo.Bastidores.Count = 1 then
  begin
    VpfDBastidor := TRBDConsumoMPBastidor(VpaDConsumo.Bastidores.Items[0]);
    VpaDOrdemCorteItem.CodBastidor := VpfDBastidor.CodBastidor;
    VpaDOrdemCorteItem.NomBastidor := VpfDBastidor.NomBastidor;
    VpaDOrdemCorteItem.QtdPecasBastidor := VpfDBastidor.QtdPecas;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaConsumoOrdemCorte(VpaDOrdemProducao : TRBDOrdemProducao; VpaDFracaoOp : TRBDFracaoOrdemProducao) : TRBDConsumoOrdemProducao;
var
   VpfIndice : Double;
   VpfLacoOrdemCorteItem, VpfQtdPecasEmMetro : Integer;
   VpfDOrdemCorteItem : TRBDOrdemCorteItem;
   VpfDConsumo :  TRBDConsumoOrdemProducao;
begin

  if (varia.TipoOrdemProducao in [toFracionada,toSubMontagem]) then
  begin
    for VpfLacoOrdemCorteItem := 0 to VpaDOrdemProducao.OrdemCorte.Itens.Count - 1 do
    begin
      VpfDOrdemCorteItem := TRBDOrdemCorteItem(VpaDOrdemProducao.OrdemCorte.Itens[VpfLacoOrdemCorteItem]);
      //gera o consumo do produto principal
      VpfDConsumo := vpadFracaoOp.AddConsumo;
      VpfDConsumo.SeqProduto := VpfDOrdemCorteItem.SeqProduto;
      VpfDConsumo.CodCor := VpfDOrdemCorteItem.CodCor;
      VpfDConsumo.CodFaca := VpfDOrdemCorteItem.CodFaca;
      VpfDConsumo.DesObservacoes := VpfDOrdemCorteItem.DesObservacao;
      VpfDConsumo.QtdUnitario := VpfDOrdemCorteItem.QtdProduto;
      VpfDConsumo.QtdABaixar := 0;
      VpfDConsumo.QtdBaixado := 0;
      VpfDConsumo.UM := 'mt';
      VpfDConsumo.UMOriginal := 'mt';
      VpfDConsumo.IndBaixado := false;
      VpfDConsumo.IndMaterialExtra := false;
      VpfDConsumo.IndOrdemCorte := true;
      if (varia.TipoOrdemProducao in [toFracionada,toAgrupada]) then
      begin
        VpfQtdPecasEmMetro := FunProdutos.CalculaQtdPecasemMetro(VpfIndice,VpfDOrdemCorteItem.AltProduto,VpfDOrdemCorteItem.CodFaca,VpfDOrdemCorteItem.CodMaquina,VpfDOrdemCorteItem.CodBastidor,VpfDOrdemCorteItem.QtdPecasBastidor,VpfDOrdemCorteItem.AltMolde,VpfDOrdemCorteItem.LarMolde);
        if VpfQtdPecasEmMetro <> 0 then
          VpfDConsumo.QtdABaixar := ((VpaDFracaoOp.QtdProduto *VpfIndice)/VpfQtdPecasEmMetro)*VpfDOrdemCorteItem.QtdProduto
        else
          VpfDConsumo.QtdABaixar := -1;
      end
      else
        VpfDConsumo.QtdABaixar := 1;//futuramente calcular o qtd de quilos.

      if VpfDOrdemCorteItem.SeqEntretela <> 0 then
      begin
        VpfDConsumo := vpadFracaoOp.AddConsumo;
        VpfDConsumo.SeqProduto := VpfDOrdemCorteItem.SeqEntretela;
        VpfDConsumo.CodFaca := VpfDOrdemCorteItem.CodFaca;
        VpfDConsumo.DesObservacoes := VpfDOrdemCorteItem.DesObservacao;
        VpfDConsumo.QtdABaixar := 0;
        VpfDConsumo.QtdBaixado := 0;
        VpfDConsumo.QtdUnitario := VpfDOrdemCorteItem.QtdProduto;
        VpfDConsumo.UM := 'mt';
        VpfDConsumo.IndBaixado := false;
        VpfDConsumo.IndOrdemCorte := true;
        VpfDConsumo.IndMaterialExtra := false;
        VpfQtdPecasEmMetro := FunProdutos.CalculaQtdPecasemMetro(VpfIndice,FunProdutos.RAlturaProduto(VpfDOrdemCorteItem.SeqEntretela),VpfDOrdemCorteItem.CodFaca,VpfDOrdemCorteItem.CodMaquina,VpfDOrdemCorteItem.CodBastidor,VpfDOrdemCorteItem.QtdPecasBastidor,VpfDOrdemCorteItem.AltMolde,VpfDOrdemCorteItem.LarMolde);
        if VpfQtdPecasEmMetro <> 0 then
          VpfDConsumo.QtdABaixar := ((VpaDFracaoOp.QtdProduto *VpfIndice)/VpfQtdPecasEmMetro)*VpfDOrdemCorteItem.QtdEntretela
        else
          VpfDConsumo.QtdABaixar := -1;
      end;
      if VpfDOrdemCorteItem.SeqTermocolante <> 0 then
      begin
        VpfDConsumo := vpadFracaoOp.AddConsumo;
        VpfDConsumo.SeqProduto := VpfDOrdemCorteItem.SeqTermoColante;
        VpfDConsumo.CodFaca := VpfDOrdemCorteItem.CodFaca;
        VpfDConsumo.DesObservacoes := VpfDOrdemCorteItem.DesObservacao;
        VpfDConsumo.QtdABaixar := 0;
        VpfDConsumo.QtdBaixado := 0;
        VpfDConsumo.QtdUnitario := VpfDOrdemCorteItem.QtdProduto;
        VpfDConsumo.UM := 'mt';
        VpfDConsumo.IndBaixado := false;
        VpfDConsumo.IndOrdemCorte := true;
        VpfDConsumo.IndMaterialExtra := false;
        VpfQtdPecasEmMetro := FunProdutos.CalculaQtdPecasemMetro(VpfIndice,FunProdutos.RAlturaProduto(VpfDOrdemCorteItem.SeqTermoColante),VpfDOrdemCorteItem.CodFaca,VpfDOrdemCorteItem.CodMaquina,VpfDOrdemCorteItem.CodBastidor,VpfDOrdemCorteItem.QtdPecasBastidor,VpfDOrdemCorteItem.AltMolde,VpfDOrdemCorteItem.LarMolde);
        if VpfQtdPecasEmMetro <> 0 then
          VpfDConsumo.QtdABaixar := ((VpaDFracaoOp.QtdProduto *VpfIndice)/VpfQtdPecasEmMetro)*VpfDOrdemCorteItem.QtdTermocolante
        else
          VpfDConsumo.QtdABaixar := -1;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.AdicionaCosumoOrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao; VpaDFracaoOp : TRBDFracaoOrdemProducao; VpaDConsumoProduto : TRBDConsumoMP);
var
  VpfDOrdemSerra : TRBDOrdemSerra;
begin
  if (varia.TipoOrdemProducao = toSubMontagem) then
  begin
    VpfDOrdemSerra := ROrdemSerra(VpaDOrdemProducao,VpaDConsumoProduto.SeqProduto,VpaDFracaoOp.SeqProduto,VpaDConsumoProduto.QtdProduto,VpaDConsumoProduto.NomProduto);
    VpfDOrdemSerra.QtdProduto := VpfDOrdemSerra.QtdProduto + 1;
    VpfDOrdemSerra.Fracoes.add(VpaDFracaoOp);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.FinalizaRomaneio(VpaFilial,VpaSeqRomaneio : String);
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOCORPO '+
                                    ' Where EMPFIL = '+ VpaFilial+
                                    ' and SEQROM = '+ VpaSeqRomaneio);
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('DATFIM').AsDateTime := now;
  Ordcadastro.Post;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaOrdemProducaoItem(VpaDOrdem : TRBDOrdemProducaoEtiqueta):string;
var
  VpfLaco : Integer;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from ORDEMPRODUCAOITEM '+
                           ' Where EMPFIL = '+IntToStr(VpaDOrdem.CodEmpresafilial)+
                           ' AND SEQORD = ' +IntToStr(VpaDOrdem.SeqOrdem));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ORDEMPRODUCAOITEM ');
  for VpfLaco := 0 to VpaDOrdem.Items.Count - 1 do
  begin
    VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOrdem.Items.Items[VpfLaco]);
    if VpfDOrdemItem.SeqItem = 0 then
    begin
      VpfDOrdemItem.SeqItem := VpfLaco +1;
      VpfDOrdemItem.QtdFaltante := VpfDOrdemItem.MetrosFita * VpfDOrdemItem.QtdFitas;
      VpfDOrdemItem.QtdProduzido := 0;
    end;
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaDOrdem.CodEmpresafilial;
    OrdCadastro.FieldByName('SEQORD').AsInteger := VpaDOrdem.SeqOrdem;
    OrdCadastro.FieldByName('SEQITE').AsInteger := VpfDOrdemItem.SeqItem;
    OrdCadastro.FieldByName('CODCOM').AsInteger := VpfDOrdemItem.CodCombinacao;
    OrdCadastro.FieldByName('CODMAN').AsString := VpfDOrdemItem.CodManequim;
    OrdCadastro.FieldByName('QTDFIT').AsInteger := VpfDOrdemItem.QtdFitas;
    OrdCadastro.FieldByName('METFIT').AsFloat := ArredondaDecimais(VpfDOrdemItem.MetrosFita,1);
    OrdCadastro.FieldByName('QTDCOM').AsInteger := VpfDOrdemItem.QtdEtiquetas;
    OrdCadastro.FieldByName('QTDPRO').AsFloat := ArredondaDecimais(VpfDOrdemItem.QtdProduzido,1);
    OrdCadastro.FieldByName('QTDFAL').AsFloat := ArredondaDecimais(VpfDOrdemItem.QtdFaltante,1);
    OrdCadastro.Post;
    result :=  OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      exit;
  end;
end;


{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDOPItemCadarco(VpaDOrdem : TRBDOrdemProducaoEtiqueta):string;
var
  VpfLaco : Integer;
  VpfDOPItem : TRBDOPItemCadarco;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from OPITEMCADARCO '+
                           ' Where EMPFIL = '+IntToStr(VpaDOrdem.CodEmpresafilial)+
                           ' AND SEQORD = ' +IntToStr(VpaDOrdem.SeqOrdem));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from OPITEMCADARCO ');
  for VpfLaco := 0 to VpaDOrdem.ItemsCadarco.Count - 1 do
  begin
    VpfDOPItem := TRBDOPItemCadarco(VpaDOrdem.ItemsCadarco.Items[VpfLaco]);
    VpfDOPItem.SeqItem := VpfLaco +1;
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaDOrdem.CodEmpresafilial;
    OrdCadastro.FieldByName('SEQORD').AsInteger := VpaDOrdem.SeqOrdem;
    OrdCadastro.FieldByName('SEQITE').AsInteger := VpfDOPItem.SeqItem;
    OrdCadastro.FieldByName('SEQPRO').AsInteger := VpfDOPItem.SeqProduto;
    OrdCadastro.FieldByName('CODCOR').AsInteger:= VpfDOPItem.CodCor;
    OrdCadastro.FieldByName('GROPRO').AsFloat:= VpfDOPItem.Grossura;
    OrdCadastro.FieldByName('QTDFUS').AsInteger:= VpfDOPItem.QtdFusos;
    OrdCadastro.FieldByName('NROFIO').AsInteger := VpfDOPItem.NroFios;
    OrdCadastro.FieldByName('NROMAQ').AsInteger := VpfDOPItem.NroMaquinas;
    OrdCadastro.FieldByName('CODPRO').AsString := VpfDOPItem.CodProduto;
    OrdCadastro.FieldByName('INDALG').AsString := VpfDOPItem.IndAlgodao;
    OrdCadastro.FieldByName('INDPOL').AsString := VpfDOPItem.IndPoliester;
    OrdCadastro.FieldByName('DESENG').AsString := VpfDOPItem.DesEngrenagem;
    OrdCadastro.FieldByName('TITFIO').AsString := VpfDOPItem.TitFios;
    OrdCadastro.FieldByName('DESENC').AsString := VpfDOPItem.DesEnchimento;
    OrdCadastro.FieldByName('QTDMET').AsFloat := VpfDOPItem.QtdMetrosProduto;
    OrdCadastro.FieldByName('QTDPRO').AsFloat := VpfDOPItem.QtdProduto;
    OrdCadastro.FieldByName('NUMTAB').AsFloat := VpfDOPItem.NumTabuas;

    OrdCadastro.Post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      exit;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDOpItemMaquina(VpaDOrdem : TRBDOrdemProducaoEtiqueta):String;
var
  VpfDOpItem : TRBDOPItemCadarco;
  VpfDOpMaquina : TRBDOPItemMaquina;
  VpfLacoItem, VpfLacoMaquina : Integer;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from OPITEMCADARCOMAQUINA '+
                           ' Where EMPFIL = '+IntToStr(VpaDOrdem.CodEmpresafilial)+
                           ' AND SEQORD = ' +IntToStr(VpaDOrdem.SeqOrdem));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from OPITEMCADARCOMAQUINA ');
  for VpfLacoItem := 0 to  VpaDOrdem.ItemsCadarco.Count - 1 do
  begin
    VpfDOPItem := TRBDOPItemCadarco(VpaDOrdem.ItemsCadarco.Items[VpfLacoItem]);
    for VpfLacoMaquina := 0 to VpfDOpItem.Maquinas.Count - 1 do
    begin
      VpfDOpMaquina := TRBDOPItemMaquina(VpfDOpItem.Maquinas.Items[VpfLacoMaquina]);
      OrdCadastro.Insert;
      OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaDOrdem.CodEmpresafilial;
      OrdCadastro.FieldByName('SEQORD').AsInteger := VpaDOrdem.SeqOrdem;
      OrdCadastro.FieldByName('SEQITE').AsInteger := VpfDOPItem.SeqItem;
      OrdCadastro.FieldByName('SEQMAQ').AsInteger := RSeqMaquinaDisponivel(IntToStr(VpaDOrdem.CodEmpresafilial),IntToStr(VpaDOrdem.SeqOrdem),IntToStr(VpfDOpItem.SeqItem)) ;
      OrdCadastro.FieldByName('CODMAQ').AsInteger := VpfDOpMaquina.CodMaquina;
      OrdCadastro.FieldByName('QTDMET').AsFloat := VpfDOpMaquina.QtdMetros;
      OrdCadastro.Post;
      result := OrdCadastro.AMensagemErroGravacao;
      if OrdCadastro.AErronaGravacao then
        exit;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDColetaOPItem(VpaDColetaOP : TRBDColetaOP): String;
Var
  VpfDColetaOPItem : TRBDColetaOPItem;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from COLETAOPITEM '+
                           ' Where EMPFIL = '+IntToStr(VpaDColetaOP.CodEmpresafilial)+
                           ' AND SEQORD = ' +IntToStr(VpaDColetaOP.SeqOrdemProducao)+
                           ' and SEQCOL = ' + IntToStr(VpaDColetaOP.SeqColeta));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from COLETAOPITEM ');
  for VpfLaco := 0 to VpaDColetaOP.ItensColeta.Count - 1 do
  begin
    VpfDColetaOPItem := TRBDColetaOPItem(VpaDColetaOP.ItensColeta.Items[VpfLaco]);
    if VpfDColetaOPItem.MetrosColetados <> 0 then
    begin
      OrdCadastro.Insert;
      OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaDColetaOP.CodEmpresafilial;
      OrdCadastro.FieldByName('SEQORD').AsInteger := VpaDColetaOP.SeqOrdemProducao;
      OrdCadastro.FieldByName('SEQCOL').AsInteger := VpaDColetaOP.SeqColeta;
      OrdCadastro.FieldByName('SEQITE').AsInteger := VpfDColetaOPItem.SeqItem;
      OrdCadastro.FieldByName('CODCOM').AsInteger := VpfDColetaOPItem.CodCombinacao;
      OrdCadastro.FieldByName('CODMAN').AsString := VpfDColetaOPItem.CodManequim;
      OrdCadastro.FieldByName('NROFIT').AsInteger := VpfDColetaOPItem.NroFitas;
      OrdCadastro.FieldByName('METPRO').AsFloat := VpfDColetaOPItem.MetrosProduzidos;
      OrdCadastro.FieldByName('METCOL').AsFloat := VpfDColetaOPItem.MetrosColetados;
      OrdCadastro.FieldByName('METAPR').AsFloat := VpfDColetaOPItem.MetrosAProduzir;
      OrdCadastro.FieldByName('METFAL').AsFloat := VpfDColetaOPItem.MetrosFaltante;
      OrdCadastro.Post;
      result := OrdCadastro.AMensagemErroGravacao;
      if OrdCadastro.AErronaGravacao then
        exit;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDFracoesOP(VpaDOrdemProducao : TRBDOrdemProducao):string;
Var
  VpfLaco : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from FRACAOOPESTAGIO '+
                           ' Where CODFILIAL = ' +IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                           ' AND SEQORDEM = '+IntToStr(VpaDOrdemProducao.SeqOrdem));
  ExecutaComandoSql(OrdAux,'Delete from FRACAOOPCOMPOSE '+
                           ' Where CODFILIAL = ' +IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                           ' AND SEQORDEM = '+IntToStr(VpaDOrdemProducao.SeqOrdem));
  ExecutaComandoSql(OrdAux,'Delete from FRACAOOP '+
                           ' Where CODFILIAL = ' +IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                           ' AND SEQORDEM = '+IntToStr(VpaDOrdemProducao.SeqOrdem));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOP'+
                                    ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0');
  for Vpflaco := 0 to VpaDOrdemProducao.Fracoes.Count -1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLaco]);
    if VpfDFracao.SeqFracao = 0 then
      VpfDFracao.SeqFracao := VpfLaco+1;
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDOrdemProducao.CodEmpresafilial;
    OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaDOrdemProducao.SeqOrdem;
    OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpfDFracao.SeqFracao;
    if VpfDFracao.SeqFracaoPai <> 0 then
      OrdCadastro.FieldByName('SEQFRACAOPAI').AsInteger := VpfDFracao.SeqFracaoPai;
    OrdCadastro.FieldByName('QTDCELULA').AsInteger := VpfDFracao.QtdCelula;
    OrdCadastro.FieldByName('DESHORAS').AsString := VpfDFracao.HorProducao;
    if VpfDFracao.DesObservacao <> '' then
      OrdCadastro.FieldByName('DESOBSERVACAO').AsString := VpfDFracao.DesObservacao;
    OrdCadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDFracao.QtdProduto;
    OrdCadastro.FieldByName('CODESTAGIO').AsInteger := VpfDFracao.CodEstagio;
    if VpfDFracao.SeqProduto <> 0 then
      OrdCadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDFracao.SeqProduto;
    if VpfDFracao.CodCor <> 0 then
      OrdCadastro.FieldByName('CODCOR').AsInteger := VpfDFracao.CodCor;
    if VpfDFracao.CodTamanho <> 0 then
      OrdCadastro.FieldByName('CODTAMANHO').AsInteger := VpfDFracao.CodTamanho;
    if VpfDFracao.UM <> '' then
      OrdCadastro.FieldByName('DESUM').AsString := VpfDFracao.UM;
    OrdCadastro.FieldByName('DATENTREGA').AsDateTime := VpfDFracao.DatEntrega;
    if  VpfDFracao.DatImpressaoFicha > montaData(1,1,1900) then
      OrdCadastro.FieldByName('DATIMPRESSAOFICHA').AsDateTime := VpfDFracao.DatImpressaoFicha
    else
      OrdCadastro.FieldByName('DATIMPRESSAOFICHA').clear;
    VpfDFracao.CodBarras := StrToFloat(IntToStr(VpaDOrdemProducao.CodEmpresafilial)+AdicionaCharE('0',IntToStr(VpaDOrdemProducao.SeqOrdem),6)+ AdicionaCharE('0',IntToStr(VpfDFracao.SeqFracao),4));
    OrdCadastro.FieldByName('CODBARRAS').AsFloat := VpfDFracao.CodBarras;
    OrdCadastro.FieldByName('DATENTREGA').AsDateTime := VpfDFracao.DatEntrega;
    if VpfDFracao.IndPlanoCorte then
      OrdCadastro.FieldByName('INDPLANOCORTE').AsString := 'S'
    else
      OrdCadastro.FieldByName('INDPLANOCORTE').AsString := 'N';

    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDFracaoOPCompose(VpaDOrdemProducao : TRBDOrdemProducao):string;
var
  VpfLacoFracao, VpfLacoCompose :Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfDCompose : TRBDOrcCompose;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPCOMPOSE '+
                                    ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0 AND SEQCOMPOSE = 0 ');
  for VpfLacofracao := 0 to VpaDOrdemProducao.Fracoes.Count -1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLacoFracao]);
    for VpfLacoCompose := 0 to VpfDFracao.Compose.Count - 1 do
    begin
      VpfDCompose := TRBDOrcCompose(VpfDFracao.Compose.Items[VpfLacoCompose]);
      OrdCadastro.Insert;
      OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDOrdemProducao.CodEmpresafilial;
      OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaDOrdemProducao.SeqOrdem;
      OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpfDFracao.SeqFracao;
      if VpfDCompose.SeqCompose = 0 then
        VpfDCompose.SeqCompose := VpfLacoCompose;
      OrdCadastro.FieldByName('SEQCOMPOSE').AsInteger := VpfDCompose.SeqCompose;
      OrdCadastro.FieldByName('CORREFERENCIA').AsInteger := VpfDCompose.CorRefencia;
      OrdCadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDCompose.SeqProduto;
      OrdCadastro.FieldByName('CODCOR').AsInteger := VpfDCompose.CodCor;
      OrdCadastro.post;
      result := OrdCadastro.AMensagemErroGravacao;
      if OrdCadastro.AErronaGravacao then
        exit;
    end;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDFracaoOPEstagio(VpaDFracao: TRBDFracaoOrdemProducao; VpaCodFilial, VpaSeqOrdem,
  VpaSeqProduto: Integer;VpaExcluirAntes : Boolean): string;
Var
  VpfDEstagio : TRBDordemProducaoEstagio;
  VpfLacoEstagio : Integer;
begin
  if VpaExcluirAntes  then
    ExecutaComandoSql(OrdAux,'Delete from FRACAOOPESTAGIO '+
                              ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                              ' AND SEQORDEM = '+ IntToStr(VpaSeqOrdem)+
                              ' AND SEQFRACAO = '+IntToStr(VpaDFracao.SeqFracao));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPESTAGIO '+
                                    ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0 AND SEQESTAGIO = 0');
  for VpfLacoEstagio := 0 to VpaDFracao.Estagios.Count - 1 do
  begin
    VpfDEstagio := TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLacoEstagio]);
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
    OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaSeqOrdem;
    OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDFracao.SeqFracao;
    OrdCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
    OrdCadastro.FieldByName('SEQESTAGIO').AsInteger := VpfDEstagio.SeqEstagio;
    OrdCadastro.FieldByName('CODESTAGIO').AsInteger := VpfDEstagio.CodEstagio;
    OrdCadastro.FieldByName('QTDCELULA').AsInteger := VpfDEstagio.QtdCelula;
    OrdCadastro.FieldByName('DESHORAS').AsString := VpfDEstagio.QtdHoras;
    OrdCadastro.FieldByName('INDPRODUCAO').AsString := VpfDEstagio.IndProducaoInterna;
    OrdCadastro.FieldByName('VALUNITARIOFACCAO').AsFloat := VpfDEstagio.ValUnitarioFaccao;
    OrdCadastro.FieldByName('QTDPRODUZIDO').AsFloat := VpfDEstagio.QtdProduzido;
    if VpfDEstagio.IndFinalizado then
      OrdCadastro.FieldByName('INDFINALIZADO').AsString := 'S'
    else
      OrdCadastro.FieldByName('INDFINALIZADO').AsString := 'N';
    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDFracaoOPEstagio(VpaDOrdemProducao : TRBDOrdemProducao):string;
var
  VpfLacoFracao, VpfLacoEstagio :Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfSeqProduto : Integer;
begin
  result := '';
  for VpfLacofracao := 0 to VpaDOrdemProducao.Fracoes.Count -1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLacoFracao]);
    if (varia.TipoOrdemProducao = toFracionada) then
      VpfSeqProduto := VpaDOrdemProducao.SeqProduto
    else
      VpfSeqProduto := VpfDFracao.SeqProduto;
    result := GravaDFracaoOPEstagio(VpfDFracao,VpaDOrdemProducao.CodEmpresafilial,VpaDOrdemProducao.SeqOrdem,VpfSeqProduto,False);
    if result <> '' then
      break;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDFracaoOpEstagioReal(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPESTAGIOREAL ' +
                                   ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0 AND SEQESTAGIO = 0 ');
  OrdCadastro.insert;
  OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDEstagio.CodFilial;
  OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaDEstagio.SeqOrdem;
  OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDEstagio.SeqFracao;
  OrdCadastro.FieldByName('CODESTAGIO').AsInteger := VpaDEstagio.CodEstagio;
  OrdCadastro.FieldByName('CODUSUARIO').AsInteger := VpaDEstagio.CodUsuario;
  OrdCadastro.FieldByName('CODUSUARIOLOGADO').AsInteger := VpaDEstagio.CodUsuarioLogado;
  OrdCadastro.FieldByName('DESOBSERVACAO').AsString := VpaDEstagio.DesObservacao;
  OrdCadastro.FieldByName('INDFINALIZADO').AsString := 'N';
  OrdCadastro.FieldByName('DATCADASTRO').AsDatetime := now;
  if VpaDEstagio.IndDatFim then
  begin
    OrdCadastro.FieldByName('INDDATAFIM').AsString := 'S';
    OrdCadastro.FieldByName('DATFIM').AsDateTime := VpaDEstagio.DatFim;
  end
  else
  begin
    OrdCadastro.FieldByName('INDDATAFIM').AsString := 'N';
    OrdCadastro.FieldByName('DATFIM').Clear;
  end;
  OrdCadastro.FieldByName('SEQESTAGIO').AsInteger := RSeqEstagioFracaoOpDisponivel(VpaDEstagio.CodFilial,VpaDEstagio.SeqOrdem,VpaDEstagio.SeqFracao);
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GeraOrdemCortedaOP(VpaDOrdemProducao : TRBDordemProducao) : TRBDOrdemCorte;
begin
  result := TRBDOrdemCorte.Cria;
  Result.CodFilial := VpaDOrdemProducao.CodEmpresafilial;
  Result.SeqOrdemProducao := VpaDOrdemProducao.SeqOrdem;
  Result.SeqCorte := 0;
  result.QtdFracao := VpaDOrdemProducao.Fracoes.Count;
  Result.QtdProduto := VpaDOrdemProducao.QtdProduto;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GeraOrdemCorteItemdaOP(VpaDOrdemCorte : TRBDOrdemCorte; VpaDOrdemProducao : TRBDordemProducao) : String;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoMP;
  VpfDCorteItem : TRBDOrdemCorteItem;
begin
  result := '';
  FunProdutos.CarConsumoProduto(VpaDOrdemProducao.DProduto,VpaDOrdemProducao.CodCor);
  for VpfLaco := 0 to VpaDOrdemProducao.DProduto.ConsumosMP.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDOrdemProducao.DProduto.ConsumosMP.Items[VpfLaco]);
    if (VpfDConsumo.CodFaca <> 0) or (VpfDConsumo.LarguraMolde <> 0) or
       (VpfDConsumo.AlturaMolde <> 0)  then
    begin
      VpfDCorteItem := VpaDOrdemCorte.AddCorteItem;
      VpfDCorteItem.SeqProduto := VpfDConsumo.SeqProduto;
      VpfDCorteItem.CodProduto := VpfDConsumo.CodProduto;
      VpfDCorteItem.SeqEntretela := VpfDConsumo.SeqProdutoEntretela;
      VpfDCorteItem.QtdEntretela := VpfDConsumo.QtdEntretela;
      VpfDCorteItem.SeqTermocolante := VpfDConsumo.SeqProdutoTermoColante;
      VpfDCorteItem.QtdTermocolante := VpfDConsumo.QtdTermoColante;
      VpfDCorteItem.NomProduto := FunProdutos.RNomeProduto(VpfDConsumo.SeqProduto);
      VpfDCorteItem.CodCor := VpfDConsumo.CodCor;
      if VpfDConsumo.CodCor <> 0 then
        VpfDCorteItem.NomCor := FunProdutos.RNomeCor(InttoStr(VpfDConsumo.codcor));
      VpfDCorteItem.CodFaca := VpfDConsumo.CodFaca;
      VpfDCorteItem.NomFaca := VpfDConsumo.Faca.NomFaca;
      VpfDCorteItem.CodMaquina := VpfDConsumo.CodMaquina;
      VpfDCorteItem.DMaquina.NomMaquina := VpfDConsumo.Maquina.NomMaquina;
      VpfDCorteItem.DesUm := VpfDConsumo.UM;
      VpfDCorteItem.DesObservacao := VpfDConsumo.DesObservacoes;
      VpfDCorteItem.LarMolde := VpfDConsumo.LarguraMolde;
      VpfDCorteItem.AltMolde := VpfDConsumo.AlturaMolde;
      VpfDCorteItem.QtdProduto := VpfDConsumo.QtdProduto;
      VpfDCorteItem.AltProduto := VpfDConsumo.AltProduto;
      VpfDCorteItem.QtdPecasemMetro := VpfDConsumo.PecasMT;
      VpfDCorteItem.ValIndiceMetro := VpfDConsumo.IndiceMT;
      VpfDCorteItem.SeqProdutoKit := VpaDOrdemProducao.SeqProduto;
      VpfDCorteItem.SeqCorKit := VpaDOrdemProducao.CodCor;
      VpfDCorteItem.SeqMovimentoKit := VpfDConsumo.SeqMovimento;
      CarBastidorOrdemCorte(VpfDConsumo,VpfDCorteItem);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.GeraConsumoFracao(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao: TRBDFracaoOrdemProducao; VpaDProduto: TRBDProduto);
var
  VpfLacoConsumoProduto : Integer;
  VpfDConsumoOP : TRBDConsumoOrdemProducao;
  VpfDConsumoProduto : TRBDConsumoMP;
  VpfQtdProdutoUmOriginal : Double;
begin
  VpfQtdProdutoUmOriginal := FunProdutos.CalculaQdadePadrao(VpaDFracao.UM,VpaDFracao.UMOriginal,VpaDFracao.QtdProduto,IntToStr(VpaDProduto.SeqProduto));
  for VpfLacoConsumoProduto := 0 to VpaDProduto.ConsumosMP.Count - 1 do
  begin
    VpfDConsumoProduto := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoConsumoProduto]);
    VpfDConsumoOP := RConsumoOP(VpaDOrdemProducao,VpaDFracao, VpfDConsumoProduto);
    if not VpfDConsumoOP.IndOrigemCorte then
      VpfDConsumoOP.QtdABaixar := VpfDConsumoOP.QtdABaixar + FunProdutos.CalculaQdadePadrao(VpfDConsumoProduto.UM,VpfDConsumoOP.UM,VpfDConsumoProduto.QtdProduto * VpfQtdProdutoUmOriginal,IntToStr(VpfDConsumoProduto.SeqProduto));
    if ((UpperCase(VpfDConsumoProduto.UM) = 'MT') or (UpperCase(VpfDConsumoProduto.UM) = 'CM')) and
       (VpfDConsumoProduto.LarguraMolde = 0) and (VpfDConsumoProduto.AlturaMolde = 0) and
       (VpfDConsumoProduto.CodFaca = 0)  then
      AdicionaCosumoOrdemSerra(VpaDOrdemProducao,VpaDFracao,VpfDConsumoProduto);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GeraConsumoFracaoOrdemCorte(VpaDFracaoOP : TRBDFracaoOrdemProducao; VpaDConsumoProduto : TRBDConsumoMP):string;
Var
  VpfDConsumoFracao : TRBDConsumoOrdemProducao;
begin
  result := '';
  VpfDConsumoFracao := vpadFracaoOp.AddConsumo;
  VpfDConsumoFracao.SeqProduto := VpaDConsumoProduto.SeqProduto;
  VpfDConsumoFracao.CodCor := VpaDConsumoProduto.CodCor;
  VpfDConsumoFracao.QtdABaixar := 0;
  VpfDConsumoFracao.QtdBaixado := 0;
  VpfDConsumoFracao.QtdUnitario := VpaDConsumoProduto.QtdProduto;
  VpfDConsumoFracao.UM := VpaDConsumoProduto.UM;
  VpfDConsumoFracao.IndBaixado := false;
  VpfDConsumoFracao.IndMaterialExtra := false;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDConsumoFracoes(VpaCodFilial, VpaSeqOrdem: Integer; VpaDFracao: TRBDFracaoOrdemProducao): String;
Var
  VpfLacoConsumo : Integer;
  VpfDConsumoOp : TRBDConsumoOrdemProducao;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from FRACAOOPCONSUMO '+
                           ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                           ' and SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                           ' AND SEQFRACAO = '+IntToStr(VpaDFracao.SeqFracao));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPCONSUMO '+
                           ' Where CODFILIAL = 0 and SEQORDEM = 0 AND SEQFRACAO = 0 AND SEQCONSUMO = 0' );
  for VpfLacoConsumo := 0 to VpaDFracao.Consumo.Count - 1 do
  begin
    VpfDConsumoOp := TRBDConsumoOrdemProducao(VpaDFracao.Consumo.Items[VpfLacoConsumo]);
    VpfDConsumoOp.SeqConsumo := VpfLacoConsumo + 1;
    OrdCadastro.Insert;
    OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaCodFilial;
    OrdCadastro.FieldByname('SEQORDEM').AsInteger := VpaSeqOrdem;
    OrdCadastro.FieldByname('SEQFRACAO').AsInteger := VpaDFracao.SeqFracao;
    OrdCadastro.FieldByname('SEQCONSUMO').AsInteger := VpfDConsumoOp.SeqConsumo;
    OrdCadastro.FieldByname('QTDBAIXADO').AsFloat := VpfDConsumoOp.QtdBaixado;
    OrdCadastro.FieldByname('QTDPRODUTO').AsFloat := VpfDConsumoOp.QtdABaixar;
    OrdCadastro.FieldByname('QTDRESERVADAESTOQUE').AsFloat := VpfDConsumoOp.QtdReservada;
    OrdCadastro.FieldByname('QTDARESERVAR').AsFloat := VpfDConsumoOp.QtdAReservar;
    OrdCadastro.FieldByname('QTDUNITARIO').AsFloat := VpfDConsumoOp.QtdUnitario;
    OrdCadastro.FieldByname('DESUMUNITARIO').AsString := VpfDConsumoOp.UMUnitario;
    OrdCadastro.FieldByname('DESOBSERVACAO').AsString := VpfDConsumoOp.DesObservacoes;
    OrdCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDConsumoOp.SeqProduto;
    if VpfDConsumoOp.CodCor <> 0 then
      OrdCadastro.FieldByname('CODCOR').AsInteger := VpfDConsumoOp.CodCor;
    if VpfDConsumoOp.CodFaca <> 0 then
      OrdCadastro.FieldByname('CODFACA').AsInteger := VpfDConsumoOp.CodFaca;
    OrdCadastro.FieldByname('DESUM').AsString := VpfDConsumoOp.UM;
    if VpfDConsumoOp.IndBaixado then
      OrdCadastro.FieldByname('INDBAIXADO').AsString := 'S'
    else
      OrdCadastro.FieldByname('INDBAIXADO').AsString := 'N';
    if VpfDConsumoOp.IndOrdemCorte then
      OrdCadastro.FieldByname('INDORDEMCORTE').AsString := 'S'
    else
      OrdCadastro.FieldByname('INDORDEMCORTE').AsString := 'N';
    if VpfDConsumoOp.IndOrigemCorte then
      OrdCadastro.FieldByname('INDORIGEMCORTE').AsString := 'S'
    else
      OrdCadastro.FieldByname('INDORIGEMCORTE').AsString := 'N';
    if VpfDConsumoOp.IndMaterialExtra then
      OrdCadastro.FieldByname('INDMATERIALEXTRA').AsString := 'S'
    else
      OrdCadastro.FieldByname('INDMATERIALEXTRA').AsString := 'N';
    if VpfDConsumoOp.IndExcluir then
      OrdCadastro.FieldByname('INDEXCLUIR').AsString := 'S'
    else
      OrdCadastro.FieldByname('INDEXCLUIR').AsString := 'N';
    OrdCadastro.FieldByName('ALTMOLDE').AsFloat := VpfDConsumoOp.AltMolde;
    OrdCadastro.FieldByName('LARMOLDE').AsFloat := VpfDConsumoOp.LarMolde;
    ordCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDConsumoOPAgrupada(VpaDOrdemProducao : TRBDOrdemProducao) :String;
Var
  VpfDConsumoOp : TRBDConsumoOrdemProducao;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from ORDEMPRODUCAOCONSUMO '+
                           ' Where CODFILIAL = ' +IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                           ' and SEQORDEM = ' +IntToStr(VpaDOrdemProducao.SeqOrdem));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ORDEMPRODUCAOCONSUMO '+
                                    ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQCONSUMO = 0');
  for VpfLaco := 0 to VpaDOrdemProducao.Consumo.Count - 1 do
  begin
    VpfDConsumoOp := TRBDConsumoOrdemProducao(VpaDOrdemProducao.Consumo.Items[VpfLaco]);
    VpfDConsumoOp.SeqConsumo := VpfLaco + 1;
    OrdCadastro.Insert;
    OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDOrdemProducao.CodEmpresafilial;
    OrdCadastro.FieldByname('SEQORDEM').AsInteger := VpaDOrdemProducao.SeqOrdem;
    OrdCadastro.FieldByname('SEQCONSUMO').AsInteger := VpfDConsumoOp.SeqConsumo;
    OrdCadastro.FieldByname('QTDBAIXADO').AsFloat := VpfDConsumoOp.QtdBaixado;
    OrdCadastro.FieldByname('QTDABAIXAR').AsFloat := VpfDConsumoOp.QtdABaixar;
    OrdCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDConsumoOp.SeqProduto;
    if VpfDConsumoOp.CodCor <> 0 then
      OrdCadastro.FieldByname('CODCOR').AsInteger := VpfDConsumoOp.CodCor;
    OrdCadastro.FieldByname('DESUM').AsString := VpfDConsumoOp.UM;
    if VpfDConsumoOp.IndBaixado then
      OrdCadastro.FieldByname('INDBAIXADO').AsString := 'S'
    else
      OrdCadastro.FieldByname('INDBAIXADO').AsString := 'N';
    if VpfDConsumoOp.IndMaterialExtra then
      OrdCadastro.FieldByname('INDMATERIALEXTRA').AsString := 'S'
    else
      OrdCadastro.FieldByname('INDMATERIALEXTRA').AsString := 'N';

    ordCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDConsumoFracoes(VpaDOrdemProducao : TRBDOrdemProducao) :String;
Var
  VpfLacoFracao, VpfLacoConsumo : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  result := '';
  ReservaQtdEstoqueFracao(VpaDOrdemProducao);

  for VpfLacoFracao := 0 to VpaDOrdemProducao.Fracoes.count - 1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLacoFracao]);
    result := GravaDConsumoFracoes(VpaDOrdemProducao.CodEmpresafilial,VpaDOrdemProducao.SeqOrdem,VpfDFracao);
    if result <> ''  then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDOrdemCorteItem(VpaDOrdemCorte : TRBDOrdemCorte) : string;
var
  VpfDCorteItem : TRBDOrdemCorteItem;
  VpfLaco : Integer;
begin
  ExecutaComandoSql(OrdAux,'Delete from ORDEMCORTEITEM '+
                           ' Where CODFILIAL = '+IntToStr(VpaDOrdemCorte.CodFilial)+
                           ' AND SEQORDEMPRODUCAO = '+IntToStr(VpaDOrdemCorte.SeqOrdemProducao)+
                           ' AND SEQORDEMCORTE = '+IntToStr(VpaDOrdemCorte.SeqCorte));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ORDEMCORTEITEM '+
                                    ' WHERE CODFILIAL = 0 AND SEQORDEMPRODUCAO = 0 AND SEQORDEMCORTE = 0 AND SEQITEM = 0 ');
  for VpfLaco := 0 to VpaDOrdemCorte.Itens.Count - 1 do
  begin
    OrdCadastro.Insert;
    VpfDCorteItem := TRBDOrdemCorteItem(VpaDOrdemCorte.Itens.Items[VpfLaco]);
    VpfDCorteItem.SeqItem := VpfLaco + 1;
    OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDOrdemCorte.CodFilial;
    OrdCadastro.FieldByname('SEQORDEMPRODUCAO').AsInteger := VpaDOrdemCorte.SeqOrdemProducao;
    OrdCadastro.FieldByname('SEQORDEMCORTE').AsInteger := VpaDOrdemCorte.SeqCorte;
    OrdCadastro.FieldByname('SEQITEM').AsInteger := VpfDCorteItem.SeqItem;
    OrdCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDCorteItem.SeqProduto;
    if VpfDCorteItem.CodCor <> 0 then
      OrdCadastro.FieldByname('CODCOR').AsInteger := VpfDCorteItem.CodCor;
    if VpfDCorteItem.CodFaca <> 0 then
      OrdCadastro.FieldByname('CODFACA').AsInteger := VpfDCorteItem.CodFaca;
    if VpfDCorteItem.CodMaquina <> 0 then
      OrdCadastro.FieldByname('CODMAQUINA').AsInteger := VpfDCorteItem.CodMaquina;
    OrdCadastro.FieldByname('DESUM').AsString := VpfDCorteItem.DesUm;
    OrdCadastro.FieldByname('DESOBSERVACAO').AsString := VpfDCorteItem.DesObservacao;
    OrdCadastro.FieldByname('LARMOLDE').AsFloat := VpfDCorteItem.LarMolde;
    OrdCadastro.FieldByname('ALTMOLDE').AsFloat := VpfDCorteItem.AltMolde;
    OrdCadastro.FieldByname('ALTPRODUTO').AsFloat := VpfDCorteItem.AltProduto;
    OrdCadastro.FieldByname('QTDPRODUTO').AsFloat := VpfDCorteItem.QtdProduto;
    OrdCadastro.FieldByname('QTDPECAEMMETRO').AsFloat := VpfDCorteItem.QtdPecasemMetro;
    OrdCadastro.FieldByname('VALINDICEMETRO').AsFloat := VpfDCorteItem.ValIndiceMetro;
    if VpfDCorteItem.SeqEntretela <> 0 then
      OrdCadastro.FieldByname('SEQENTRETELA').AsInteger := VpfDCorteItem.SeqEntretela;
    if VpfDCorteItem.SeqTermocolante <> 0 then
      OrdCadastro.FieldByname('SEQTERMOCOLANTE').AsInteger := VpfDCorteItem.SeqTermocolante;
    if VpfDCorteItem.QtdEntretela <> 0 then
      OrdCadastro.FieldByname('QTDENTRETELA').AsInteger := VpfDCorteItem.QtdEntretela;
    if VpfDCorteItem.QtdTermocolante <> 0 then
      OrdCadastro.FieldByname('QTDTERMOCOLANTE').AsInteger := VpfDCorteItem.QtdTermocolante;
    if VpfDCorteItem.CodBastidor <> 0 then
      OrdCadastro.FieldByname('CODBASTIDOR').AsInteger := VpfDCorteItem.CodBastidor;
    if VpfDCorteItem.QtdPecasBastidor <> 0 then
      OrdCadastro.FieldByname('QTDPECASBASTIDOR').AsInteger := VpfDCorteItem.QtdPecasBastidor;
    if VpfDCorteItem.SeqProdutoKit <> 0 then
      OrdCadastro.FieldByname('SEQPRODUTOKIT').AsInteger := VpfDCorteItem.SeqProdutoKit;
    if VpfDCorteItem.SeqCorKit <> 0 then
      OrdCadastro.FieldByname('SEQCORKIT').AsInteger := VpfDCorteItem.SeqCorKit;
    if VpfDCorteItem.SeqMovimentoKit <> 0 then
      OrdCadastro.FieldByname('SEQMOVIMENTOKIT').AsInteger := VpfDCorteItem.SeqMovimentoKit;

    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDOrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao) :String;
var
  VpfLaco : Integer;
  VpfDOrdemSerra : TRBDOrdemSerra;
begin
  result := '';
  OrdenaOrdemSerra(VpaDOrdemProducao);
  ExecutaComandoSql(OrdAux,'Delete from ORDEMSERRAFRACAO'+
                           ' Where CODFILIAL = '+IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                           ' and SEQORDEMPRODUCAO = ' +IntToStr(VpaDOrdemProducao.SeqOrdem));
  ExecutaComandoSql(OrdAux,'Delete from ORDEMSERRA'+
                           ' Where CODFILIAL = '+IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                           ' and SEQORDEMPRODUCAO = ' +IntToStr(VpaDOrdemProducao.SeqOrdem));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ORDEMSERRA');
  for VpfLaco := 0 to VpaDOrdemProducao.OrdensSerra.Count - 1 do
  begin
    VpfDOrdemSerra := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLaco]);
    OrdCadastro.Insert;
    OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDOrdemProducao.CodEmpresafilial;
    OrdCadastro.FieldByname('SEQORDEMPRODUCAO').AsInteger := VpaDOrdemProducao.SeqOrdem;
    OrdCadastro.FieldByname('SEQORDEMSERRA').AsInteger := VpfDOrdemSerra.SeqOrdemSerra;
    OrdCadastro.FieldByname('SEQMATERIAPRIMA').AsInteger := VpfDOrdemSerra.SeqMateriaPrima;
    OrdCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDOrdemSerra.SeqProduto;
    OrdCadastro.FieldByname('COMMATERIAPRIMA').AsFloat := VpfDOrdemSerra.ComMateriaPrima;
    OrdCadastro.FieldByname('QTDPRODUTO').AsInteger := VpfDOrdemSerra.QtdProduto;
    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
  OrdCadastro.close;
  if result = '' then
    GravaDOrdemSerraFracao(VpaDOrdemProducao);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDOrdemSerraFracao(VpaDOrdemProducao : TRBDOrdemProducao) :String;
var
  VpfLacoOrdemSerra,VpfLacoFracao : Integer;
  VpfDOrdemSerra : TRBDOrdemSerra;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ORDEMSERRAFRACAO');
  for VpfLacoOrdemSerra := 0 to VpaDOrdemProducao.OrdensSerra.Count - 1 do
  begin
    VpfDOrdemSerra := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLacoOrdemSerra]);
    for VpfLacoFracao := 0 to VpfDOrdemSerra.Fracoes.Count - 1 do
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(VpfDOrdemSerra.Fracoes.Items[VpfLacoFracao]);
      OrdCadastro.insert;
      OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDOrdemProducao.CodEmpresafilial;
      OrdCadastro.FieldByname('SEQORDEMPRODUCAO').AsInteger := VpaDOrdemProducao.SeqOrdem;
      OrdCadastro.FieldByname('SEQORDEMSERRA').AsInteger := VpfDOrdemSerra.SeqOrdemSerra;
      OrdCadastro.FieldByname('SEQFRACAO').AsInteger := VpfDFracao.SeqFracao;
      OrdCadastro.post;
      result := OrdCadastro.AMensagemErroGravacao;
      if OrdCadastro.AErronaGravacao then
        break;
    end;
    if result <> '' then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDPlanoCorteItem(VpaDPlanoCorte : TRBDPlanoCorteCorpo) : string;
var
  VpfLaco : Integer;
  VpfDItemPlano : TRBDPlanoCorteItem;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from PLANOCORTEITEM '+
                           ' Where CODFILIAL = '+IntToStr(VpaDPlanoCorte.CodFilial)+
                           ' AND SEQPLANOCORTE = '+ IntToStr(VpaDPlanoCorte.SeqPlanoCorte));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from PLANOCORTEITEM ');
  for VpfLaco := 0 to VpaDPlanoCorte.Itens.Count - 1 do
  begin
    VpfDItemPlano := TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLaco]);
    VpfDItemPlano.SeqItem := VpfLaco + 1;
    OrdCadastro.Insert;
    OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDPlanoCorte.CodFilial;
    OrdCadastro.FieldByname('SEQPLANOCORTE').AsInteger := VpaDPlanoCorte.SeqPlanoCorte;
    OrdCadastro.FieldByname('SEQPLANOCORTEITEM').AsInteger := VpfDItemPlano.SeqItem;
    OrdCadastro.FieldByname('SEQIDENTIFICACAO').AsInteger := VpfDItemPlano.SeqIdentificacao;
    OrdCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDItemPlano.SeqProduto;
    OrdCadastro.FieldByname('QTDPRODUTO').AsInteger := VpfDItemPlano.QtdProduto;
    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDPlanoCorteFracao(VpaDPlanoCorte : TRBDPlanoCorteCorpo) : string;
var
  VpfLacoItem, VpfLacoFracao : Integer;
  VpfDItemPlano : TRBDPlanoCorteItem;
  vpfDFracaoPlano : TRBDPlanoCorteFracao;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from PLANOCORTEFRACAO '+
                           ' Where CODFILIAL = '+IntToStr(VpaDPlanoCorte.CodFilial)+
                           ' AND SEQPLANOCORTE = '+ IntToStr(VpaDPlanoCorte.SeqPlanoCorte));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from PLANOCORTEFRACAO ');
  for VpfLacoItem := 0 to VpaDPlanoCorte.Itens.Count - 1 do
  begin
    VpfDItemPlano := TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLacoItem]);
    for VpfLacoFracao := 0 to VpfDItemPlano.Fracoes.Count - 1 do
    begin
      vpfDFracaoPlano := TRBDPlanoCorteFracao(VpfDItemPlano.Fracoes[VpfLacoFracao]);
      OrdCadastro.Insert;
      OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDPlanoCorte.CodFilial;
      OrdCadastro.FieldByname('SEQPLANOCORTE').AsInteger := VpaDPlanoCorte.SeqPlanoCorte;
      OrdCadastro.FieldByname('SEQPLANOCORTEITEM').AsInteger := VpfDItemPlano.SeqItem;
      OrdCadastro.FieldByname('CODFILIALFRACAO').AsInteger := vpfDFracaoPlano.CodFilial;
      OrdCadastro.FieldByname('SEQORDEMPRODUCAO').AsInteger := vpfDFracaoPlano.SeqOrdem;
      OrdCadastro.FieldByname('SEQFRACAO').AsInteger := vpfDFracaoPlano.SeqFracao;
      OrdCadastro.post;
      result := OrdCadastro.AMensagemErroGravacao;
      if OrdCadastro.AErronaGravacao then
        break;
    end;
    if result <> '' then
      break;
  end;
  OrdCadastro.close;

  for VpfLacoItem := 0 to VpaDPlanoCorte.Itens.Count - 1 do
  begin
    VpfDItemPlano := TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLacoItem]);
    for VpfLacoFracao := 0 to VpfDItemPlano.Fracoes.Count - 1 do
    begin
      vpfDFracaoPlano := TRBDPlanoCorteFracao(VpfDItemPlano.Fracoes[VpfLacoFracao]);
      AlteraEstagioFracaoOP(VpfdFracaoPlano.CodFilial,vpfDFracaoPlano.SeqOrdem,VpfDFracaoPlano.SeqFracao,varia.EstagioPantografo);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDImpressaoConsumoFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaConsumo : TList):string;
var
  VpfLaco, VpfSeqImpressao : Integer;
  VpfDConsumo : TRBDConsumoFracaoOP;
begin
  result := '';
  VpfSeqImpressao := RSeqImpressaoDisponivel;
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from IMPRESSAOCONSUMOFRACAO');
  for VpfLaco := 0 to VpaConsumo.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoFracaoOP(VpaConsumo.Items[VpfLaco]);
    OrdCadastro.insert;
    OrdCadastro.FieldByName('SEQIMPRESSAO').AsInteger := VpfSeqImpressao;
    inc(VpfSeqImpressao);
    OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
    OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaSeqOrdem;
    OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpaSeqFracao;
    OrdCadastro.FieldByName('SEQMATERIAPRIMA').AsInteger := VpfDConsumo.SeqProduto;
    OrdCadastro.FieldByName('CODCORMATERIAPRIMA').AsInteger := VpfDConsumo.CodCor;
    OrdCadastro.FieldByName('DESUM').AsString := VpfDConsumo.DesUM;
    OrdCadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDConsumo.QtdProduto;
    OrdCadastro.FieldByName('QTDBAIXADO').AsFloat := VpfDConsumo.QtdBaixado;
    OrdCadastro.FieldByName('QTDRESERVADA').AsFloat := VpfDConsumo.QtdReservado;
    OrdCadastro.FieldByName('QTDARESERVAR').AsFloat := VpfDConsumo.QtdAReservar;
    if VpfDConsumo.IndMaterialExtra then
      OrdCadastro.FieldByName('INDMATERIALEXTRA').AsString := 'S'
    else
      OrdCadastro.FieldByName('INDMATERIALEXTRA').AsString := 'N';
    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    if OrdCadastro.AErronaGravacao then
      break;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOrdemProducaoItem(VpaDOrdem : TRBDOrdemProducaoEtiqueta);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select * from ORDEMPRODUCAOITEM '+
                               ' Where EMPFIL = '+ IntToStr(VpaDOrdem.CodEmpresafilial)+
                               ' and SEQORD = ' + IntToStr(VpaDOrdem.SeqOrdem) +
                               ' order by SEQITE' );
  While not OrdAux.Eof do
  begin
    VpfDOrdemItem := VpaDOrdem.AddItems;
    VpfDOrdemItem.SeqItem := OrdAux.FieldByName('SEQITE').AsInteger;
    VpfDOrdemItem.CodCombinacao := OrdAux.FieldByName('CODCOM').AsInteger;
    VpfDOrdemItem.CodManequim := OrdAux.FieldByName('CODMAN').AsString;
    VpfDOrdemItem.QtdFitas := OrdAux.FieldByName('QTDFIT').AsInteger;
    VpfDOrdemItem.MetrosFita := ArredondaDecimais(OrdAux.FieldByName('METFIT').AsFloat,1);
    VpfDOrdemItem.QtdEtiquetas := OrdAux.FieldByName('QTDCOM').AsInteger;
    VpfDOrdemItem.QtdProduzido := ArredondaDecimais(OrdAux.FieldByName('QTDPRO').AsFloat,1);
    VpfDOrdemItem.QtdFaltante := ArredondaDecimais(OrdAux.FieldByName('QTDFAL').AsFloat,1);

    OrdAux.Next;
  end;
  OrdAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOpItemCadarco(VpaDOrdem : TRBDOrdemProducaoEtiqueta);
var
  VpfDItemCadarco : TRBDOPItemCadarco;
begin
  FreeTObjectsList(VpaDOrdem.ItemsCadarco);
  AdicionaSqlAbreTabela(OrdTabela,'Select * from OPITEMCADARCO ITE, CADPRODUTOS PRO ' +
                                  ' Where ITE.SEQPRO = PRO.I_SEQ_PRO '+
                                  ' AND ITE.EMPFIL = '+InttoStr(VpaDOrdem.CodEmpresafilial)+
                                  ' and ITE.SEQORD = '+IntToStr(VpaDOrdem.SeqOrdem)+
                                  ' order by ITE.SEQITE');
  while not OrdTabela.Eof do
  begin
    VpfDItemCadarco := VpaDOrdem.AddItemsCadarco;
    VpfDItemCadarco.SeqItem := OrdTabela.FieldByName('SEQITE').AsInteger;
    VpfDItemCadarco.SeqProduto := OrdTabela.FieldByName('SEQPRO').AsInteger;
    VpfDItemCadarco.CodCor := OrdTabela.FieldByName('CODCOR').AsInteger;
    if VpfDItemCadarco.CodCor <> 0 then
      VpfDItemCadarco.NomCor := FunProdutos.RNomeCor(InttoStr(VpfDItemCadarco.CodCor));
    VpfDItemCadarco.QtdFusos := OrdTabela.FieldByName('QTDFUS').AsInteger;
    VpfDItemCadarco.NroFios := OrdTabela.FieldByName('NROFIO').AsInteger;

    case VpaDOrdem.TipPedido of
      0 : VpfDItemCadarco.MetporTabua := OrdTabela.FieldByName('I_TAB_GRA').AsInteger;
      1 : VpfDItemCadarco.MetporTabua := OrdTabela.FieldByName('I_TAB_PED').AsInteger;
      2 : VpfDItemCadarco.MetporTabua := OrdTabela.FieldByName('I_TAB_TRA').AsInteger;
    end;
    VpfDItemCadarco.NroMaquinas := OrdTabela.FieldByName('NROMAQ').AsInteger;
    VpfDItemCadarco.CodProduto := OrdTabela.FieldByName('C_COD_PRO').AsString;
    VpfDItemCadarco.NomProduto := OrdTabela.FieldByName('C_NOM_PRO').AsString;
    VpfDItemCadarco.IndAlgodao := OrdTabela.FieldByName('INDALG').AsString;
    VpfDItemCadarco.IndPoliester := OrdTabela.FieldByName('INDPOL').AsString;
    VpfDItemCadarco.DesEngrenagem := OrdTabela.FieldByName('DESENG').AsString;
    VpfDItemCadarco.TitFios := OrdTabela.FieldByName('TITFIO').AsString;
    VpfDItemCadarco.DesEnchimento := OrdTabela.FieldByName('DESENC').AsString;
    VpfDItemCadarco.DesTecnica := OrdTabela.FieldByName('L_DES_TEC').AsString;
    VpfDItemCadarco.UM := OrdTabela.FieldByName('C_COD_UNI').AsString;
    VpfDItemCadarco.Grossura := OrdTabela.FieldByName('GROPRO').AsFloat;
    VpfDItemCadarco.MetMinuto := OrdTabela.FieldByName('METMIN').AsFloat;
    VpfDItemCadarco.QtdMetrosProduto := OrdTabela.FieldByName('QTDMET').AsFloat;
    VpfDItemCadarco.QtdProduto := OrdTabela.FieldByName('QTDPRO').AsFloat;
    VpfDItemCadarco.NumTabuas := OrdTabela.FieldByName('NUMTAB').AsFloat;
    OrdTabela.Next;
  end;
  OrdTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDColetaOPItem(VpaDColeta : TRBDColetaOP);
var
  VpfDColetaItem : TRBDColetaOPItem;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select * from COLETAOPITEM '+
                               ' Where EMPFIL = '+ IntToStr(VpaDColeta.CodEmpresafilial)+
                               ' and SEQORD = ' + IntToStr(VpaDColeta.SeqOrdemProducao) +
                               ' and SEQCOL = '+ IntToStr(VpaDColeta.SeqColeta)+
                               ' order by SEQITE' );
  While not OrdAux.Eof do
  begin
    VpfDColetaItem := VpaDColeta.AddItemColeta;
    with VpfDColetaItem do
    begin
      SeqItem := OrdAux.FieldByName('SEQITE').AsInteger;
      CodCombinacao := OrdAux.FieldByName('CODCOM').AsInteger;
      CodManequim := OrdAux.FieldByName('CODMAN').AsString;
      NroFitas := OrdAux.FieldByName('NROFIT').AsInteger;
      NroFitasAnterior := NroFitas;
      MetrosProduzidos := OrdAux.FieldByName('METPRO').AsFloat;
      MetrosColetados := OrdAux.FieldByName('METCOL').AsFloat;
      MetrosAProduzir := OrdAux.FieldByName('METAPR').AsFloat;
      MetrosFaltante := OrdAux.FieldByName('METFAL').AsFloat;
    end;
    OrdAux.Next;
  end;
  OrdAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDEstagioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho);
Var
  VpfDEstagio : TRBDEstagioCelula;
begin
  FreeTObjectsList(VpaDCelula.Estagios);
  AdicionaSQLAbreTabela(OrdTabela,'Select CEL.CODESTAGIO, CEL.INDPRINCIPAL, CEL.VALPRODUTIVIDADE, '+
                                  ' EST.NOMEST '+
                                  ' from ESTAGIOCELULATRABALHO CEL, ESTAGIOPRODUCAO EST '+
                                  ' Where CEL.CODESTAGIO = EST.CODEST '+
                                  ' and CEL.CODCELULA = '+IntToStr(VpaDCelula.CodCelula));
  while not OrdTabela.Eof do
  begin
    VpfDEstagio := VpaDCelula.addEstagio;
    VpfDEstagio.CodEstagio := OrdTabela.FieldByName('CODESTAGIO').AsInteger;
    VpfDEstagio.NomEstagio := OrdTabela.FieldByName('NOMEST').AsString;
    VpfDEstagio.IndPrincipal := (UpperCase(OrdTabela.FieldByName('INDPRINCIPAL').AsString) = 'S');
    VpfDEstagio.ValCapacidadeProdutiva := OrdTabela.FieldByName('VALPRODUTIVIDADE').AsInteger;
    OrdTabela.Next;
  end;
  OrdTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDHorarioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho);
Var
  VpfDHorario : TRBDHorarioCelula;
begin
  FreeTObjectsList(VpaDCelula.Horarios);
  AdicionaSQLAbreTabela(OrdTabela,'Select HOR.CODHORARIO, HOR.DESHORAINICIO, HOR.DESHORAFIM '+
                                  ' FROM HORARIOTRABALHO HOR, HORARIOCELULATRABALHO CEL '+
                                  ' Where HOR.CODHORARIO = CEL.CODHORARIO '+
                                  ' AND CEL.CODCELULA = '+IntToStr(VpaDCelula.CodCelula));
  while not OrdTabela.eof do
  begin
    VpfDHorario := VpaDCelula.addHorario;
    VpfDHorario.CodHorario := OrdTabela.FieldByName('CODHORARIO').AsInteger;
    VpfDHorario.DesHoraInicio := OrdTabela.FieldByName('DESHORAINICIO').AsString;
    VpfDHorario.DesHoraFim := OrdTabela.FieldByName('DESHORAFIM').AsString;
    OrdTabela.next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOPBasicaTabela(VpaDOrdem : TRBDOrdemProducao;VpaTabela : TDataSet);
begin
  VpaTabela.FieldByName('EMPFIL').AsInteger := VpaDOrdem.CodEmpresafilial;
  VpaTabela.FieldByName('DATEMI').AsDateTime := VpaDOrdem.DatEmissao;
  VpaTabela.FieldByName('DATENP').AsDateTime := VpaDOrdem.DatEntregaPrevista;
  VpaTabela.FieldByName('SEQPRO').AsInteger := VpaDOrdem.SeqProduto;
  VpaTabela.FieldByName('CODPRO').AsString := VpaDOrdem.CodProduto;
  VpaTabela.FieldByName('QTDORP').AsFloat := VpaDOrdem.QtdProduto;
  VpaTabela.FieldByName('CODCLI').AsInteger := VpaDOrdem.CodCliente;
  VpaTabela.FieldByName('VALUNI').AsFloat := VpaDOrdem.ValUnitario;
  if VpaDOrdem.LanOrcamento <> 0 then
    VpaTabela.FieldByName('LANORC').AsInteger := VpaDOrdem.LanOrcamento
  else
    VpaTabela.FieldByName('LANORC').Clear;
  if VpaDOrdem.SeqItemOrcamento <> 0 then
    VpaTabela.FieldByName('ITEORC').AsInteger := VpaDOrdem.SeqItemOrcamento
  else
    VpaTabela.FieldByName('ITEORC').Clear;
  VpaTabela.FieldByName('QTDFRA').AsInteger := VpaDOrdem.QtdFracoes;

  if VpaDOrdem.NumPedido <> 0 then
    VpaTabela.FieldByName('NUMPED').AsInteger := VpaDOrdem.NumPedido
  else
    VpaTabela.FieldByName('NUMPED').Clear;
  if VpaDOrdem.CodCor <> 0 then
    VpaTabela.FieldByName('CODCOM').AsInteger := VpaDOrdem.CodCor
  else
    VpaTabela.FieldByName('CODCOM').Clear;
  VpaTabela.FieldByName('HORPRO').AsString := VpaDOrdem.HorProducao;
  if VpaDOrdem.CodEstagio <> 0 then
    VpaTabela.FieldByName('CODEST').AsInteger := VpaDOrdem.CodEstagio
  else
    VpaTabela.FieldByName('CODEST').Clear;
  VpaTabela.FieldByName('UNMPED').AsString := VpaDOrdem.UMPedido;
  VpaTabela.FieldByName('CODUSU').AsInteger := VpaDOrdem.CodProgramador;
  if VpaDOrdem.DesObservacoes <> '' then
    VpaTabela.FieldByName('DESOBS').AsString := VpaDOrdem.DesObservacoes
  else
    VpaTabela.FieldByName('DESOBS').Clear;
  if VpaDOrdem.DesReferenciaCliente <> '' then
    VpaTabela.FieldByName('PROREF').AsString := VpaDOrdem.DesReferenciaCliente
  else
    VpaTabela.FieldByName('PROREF').Clear;
  if VpaDOrdem.DesOrdemCompra <> '' then
    VpaTabela.FieldByName('ORDCLI').AsString := VpaDOrdem.DesOrdemCompra
  else
    VpaTabela.FieldByName('ORDCLI').Clear;

  if VpaDOrdem.SeqOrdem = 0 then
    VpaDOrdem.SeqOrdem := RSeqOrdemDisponivel(IntToStr(VpaDOrdem.CodEmpresafilial));
  VpaDOrdem.OrdemCorte.CodFilial := VpaDOrdem.CodEmpresafilial;
  VpaDOrdem.OrdemCorte.SeqOrdemProducao := VpaDOrdem.SeqOrdem;

  VpaTabela.FieldByName('SEQORD').AsInteger := VpaDOrdem.SeqOrdem;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOPBasicaClasse(VpaDOrdem : TRBDOrdemProducao;VpaTabela : TDataSet);
begin
  VpaDOrdem.CodEmpresafilial := VpaTabela.FieldByName('EMPFIL').AsInteger;
  VpaDOrdem.SeqOrdem := VpaTabela.FieldByName('SEQORD').AsInteger;
  VpaDOrdem.SeqProduto := VpaTabela.FieldByName('SEQPRO').AsInteger;
  VpaDOrdem.DatEmissao := VpaTabela.FieldByName('DATEMI').AsDateTime;
  VpaDOrdem.DatEntregaPrevista := VpaTabela.FieldByName('DATENP').AsDateTime;
  VpaDOrdem.CodProduto := VpaTabela.FieldByName('CODPRO').AsString;
  VpaDOrdem.QtdProduto := VpaTabela.FieldByName('QTDORP').AsFloat;
  VpaDOrdem.CodCliente := VpaTabela.FieldByName('CODCLI').AsInteger;
  VpaDOrdem.LanOrcamento := VpaTabela.FieldByName('LANORC').AsInteger;
  VpaDOrdem.SeqItemOrcamento := VpaTabela.FieldByName('ITEORC').AsInteger;
  VpaDOrdem.QtdFracoes := VpaTabela.FieldByName('QTDFRA').AsInteger;
  VpaDOrdem.NumPedido := VpaTabela.FieldByName('NUMPED').AsInteger;
  VpaDOrdem.CodCor := VpaTabela.FieldByName('CODCOM').AsInteger;
  VpaDOrdem.HorProducao := VpaTabela.FieldByName('HORPRO').AsString;
  VpaDOrdem.CodEstagio :=  VpaTabela.FieldByName('CODEST').AsInteger;
  VpaDOrdem.UMPedido := VpaTabela.FieldByName('UNMPED').AsString;
  VpaDOrdem.CodProgramador := VpaTabela.FieldByName('CODUSU').AsInteger;
  VpaDOrdem.DesObservacoes := VpaTabela.FieldByName('DESOBS').AsString;
  VpaDOrdem.DesReferenciaCliente := VpaTabela.FieldByName('PROREF').AsString;
  VpaDOrdem.DesOrdemCompra := VpaTabela.FieldByName('ORDCLI').AsString;
  VpaDOrdem.ValUnitario := VpaTabela.FieldByName('VALUNI').AsFloat;

  VpaDOrdem.DProduto.CodEmpresa := varia.CodigoEmpresa;
  VpaDOrdem.DProduto.CodEmpFil := VpaDOrdem.CodEmpresafilial;
  VpaDOrdem.DProduto.SeqProduto := VpaDOrdem.SeqProduto;
  FunProdutos.CarDProduto(VpaDOrdem.DProduto);
  FunProdutos.CarDEstagio(VpaDOrdem.DProduto);
  VpaDOrdem.NomProduto := VpaDOrdem.DProduto.NomProduto;

  VpaDOrdem.NomCor := FunProdutos.RNomeCor(InttoStr(VpaDOrdem.CodCor));
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.CarDFracaoOP(VpaDOrdem : TRBDOrdemProducao;VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer): TRBDFracaoOrdemProducao;
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  OrdTabela.close;
  OrdTabela.sql.clear;
  OrdTabela.sql.add('Select FRA.SEQFRACAO, FRA.SEQFRACAOPAI, FRA.SEQPRODUTO, FRA.CODBARRAS, '+
                    ' FRA.QTDCELULA, FRA.DESHORAS, FRA.QTDPRODUTO, FRA.CODESTAGIO, FRA.DATENTREGA, '+
                    ' FRA.DATIMPRESSAOFICHA, FRA.DATFINALIZACAO, FRA.INDPLANOCORTE, FRA.INDCONSUMOBAIXADO, FRA.DESUM,  '+
                    ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL, '+
                    ' EST.NOMEST '+
                    ' from FRACAOOP FRA, CADPRODUTOS PRO, ESTAGIOPRODUCAO EST'+
                    ' Where FRA.CODFILIAL = '+IntToStr(VpaCodFilial)+
                    ' and FRA.SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                    ' AND '+SQLTextoRightJoin('FRA.SEQPRODUTO','PRO.I_SEQ_PRO')+
                    ' AND '+SQLTextoRightJoin('FRA.CODESTAGIO','EST.CODEST'));
  if VpaSeqFracao <> 0 then
    OrdTabela.sql.add('and SEQFRACAO = '+ IntToStr(VpaSeqFracao))
  else
    OrdTabela.sql.add(' order by SEQFRACAO');
  OrdTabela.open;
  While not OrdTabela.Eof do
  begin
    if VpaDOrdem <> nil then
      VpfDFracao := VpaDOrdem.AddFracao
    else
      VpfDFracao := TRBDFracaoOrdemProducao.cria;
    VpfDFracao.CodFilial := VpaCodFilial;
    VpfDFracao.SeqOrdemProducao := VpaSeqOrdem;
    VpfDFracao.SeqFracao := OrdTabela.FieldByName('SEQFRACAO').AsInteger;
    VpfDFracao.SeqFracaoPai := OrdTabela.FieldByName('SEQFRACAOPAI').AsInteger;
    VpfDFracao.SeqProduto := OrdTabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDFracao.CodProduto := OrdTabela.FieldByName('C_COD_PRO').AsString;
    VpfDFracao.NomProduto := OrdTabela.FieldByname('C_NOM_PRO').AsString;
    VpfDFracao.CodBarras := OrdTabela.FieldByName('CODBARRAS').AsFloat;
    VpfDFracao.QtdCelula := OrdTabela.FieldByName('QTDCELULA').AsInteger;
    VpfDFracao.HorProducao := OrdTabela.FieldByName('DESHORAS').AsString;
    VpfDFracao.QtdProduto :=  OrdTabela.FieldByName('QTDPRODUTO').AsFloat;
    VpfDFracao.CodEstagio :=  OrdTabela.FieldByName('CODESTAGIO').AsInteger;
    VpfDFracao.NomEstagio := OrdTabela.FieldByName('NOMEST').AsString;
    VpfDFracao.DatEntrega := OrdTabela.FieldByName('DATENTREGA').AsDateTime;
    VpfDFracao.DatFinalizacao := OrdTabela.FieldByName('DATFINALIZACAO').AsDateTime;
    VpfDFracao.UM := OrdTabela.FieldByName('DESUM').AsString;
    VpfDFracao.UMOriginal := OrdTabela.FieldByName('UMORIGINAL').AsString;
    VpfDFracao.DatImpressaoFicha := OrdTabela.FieldByName('DATIMPRESSAOFICHA').AsDateTime;
    VpfDFracao.IndPlanoCorte := OrdTabela.FieldByName('INDPLANOCORTE').AsString = 'S';
    VpfDFracao.IndConsumoBaixado := OrdTabela.FieldByName('INDCONSUMOBAIXADO').AsString = 'S';
    VpfDFracao.IndEstagioGerado := true;
    result := VpfDFracao;
    OrdTabela.next;
  end;
  Ordtabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOrdemCorte(VpaDOrdem : TRBDordemProducao);
begin
  FreeTObjectsList(VpaDOrdem.OrdemCorte.Itens);
  AdicionaSQLAbreTabela(OrdTabela,'Select * from ORDEMCORTECORPO '+
                                  ' Where CODFILIAL = ' + IntToStr(VpaDOrdem.CodEmpresafilial)+
                                  ' AND SEQORDEMPRODUCAO = '+IntToStr(VpaDOrdem.SeqOrdem));
  VpaDOrdem.OrdemCorte.CodFilial := OrdTabela.FieldByName('CODFILIAL').AsInteger;
  VpaDOrdem.OrdemCorte.SeqOrdemProducao := OrdTabela.FieldByName('SEQORDEMPRODUCAO').AsInteger;
  VpaDOrdem.OrdemCorte.SeqCorte := OrdTabela.FieldByName('SEQORDEMCORTE').AsInteger;
  VpaDOrdem.OrdemCorte.QtdFracao := OrdTabela.FieldByName('QTDFRACAO').AsInteger;
  VpaDOrdem.OrdemCorte.QtdProduto := OrdTabela.FieldByName('QTDPRODUTO').AsFloat;
  OrdTabela.Close;
  CarDOrdemCorteItem(VpaDOrdem);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOrdemSerra(VpaDOrdemProducao : TRBDOrdemProducao;VpaSeqOrdemInicial, VpaSeqOrdemFinal : Integer);
var
  VpfDOrdemSerra : TRBDOrdemSerra;
begin
  FreeTObjectsList(VpaDOrdemProducao.OrdensSerra);
  OrdOrdemProducao.sql.clear;
  OrdOrdemProducao.sql.add('Select * from ORDEMSERRA '+
                                         ' Where CODFILIAL = '+IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                                         ' and SEQORDEMPRODUCAO = '+IntToStr(VpaDOrdemProducao.SeqOrdem));
  if VpaSeqOrdemInicial <> 0 then
    OrdOrdemProducao.sql.add('and SEQORDEMSERRA >= '+IntToStr(VpaSeqOrdemInicial));
  if VpaSeqOrdemFinal <> 0 then
    OrdOrdemProducao.sql.add('and SEQORDEMSERRA <= '+IntToStr(VpaSeqOrdemFinal));
  OrdOrdemProducao.sql.add('order by SEQORDEMSERRA');
  OrdOrdemProducao.Open;
  while not OrdOrdemProducao.Eof do
  begin
    VpfDOrdemSerra := VpaDOrdemProducao.AddOrdemSerra;
    VpfDOrdemSerra.SeqOrdemSerra := OrdOrdemProducao.FieldByname('SEQORDEMSERRA').AsInteger;
    VpfDOrdemSerra.SeqMateriaPrima := OrdOrdemProducao.FieldByname('SEQMATERIAPRIMA').AsInteger;
    VpfDOrdemSerra.SeqProduto := OrdOrdemProducao.FieldByname('SEQPRODUTO').AsInteger;
    VpfDOrdemSerra.QtdProduto := OrdOrdemProducao.FieldByname('QTDPRODUTO').AsInteger;
    VpfDOrdemSerra.ComMateriaPrima := OrdOrdemProducao.FieldByname('COMMATERIAPRIMA').AsFloat;

    OrdOrdemProducao.next;
  end;
  OrdOrdemProducao.close;
  CarDOrdemSerraFracao(VpaDOrdemProducao);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarFracoesProduto(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqProduto : Integer;VpaFracoes : TList);
begin
  FreeTObjectsList(VpaFracoes);
  AdicionaSQLAbreTabela(OrdOrdemProducao,'Select CODFILIAL,SEQORDEM,SEQFRACAO from FRACAOOP '+
                                         ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                         ' AND SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                                         ' AND SEQPRODUTO = '+IntToStr(VpaSeqProduto));
  While not OrdOrdemProducao.eof do
  begin
    VpaFracoes.add(cardfracaoop(nil,OrdOrdemProducao.FieldByName('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByName('SEQORDEM').AsInteger,
                     OrdOrdemProducao.FieldByName('SEQFRACAO').AsInteger));
    OrdOrdemProducao.next;
  end;
  OrdOrdemProducao.close;
end;


{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDFracaoOPEstagio(VpaDFracao : TRBDFracaoOrdemProducao;VpaCodFilial,VpaSeqOrdemProducao : Integer);
var
  VpfDEstagioFracao : TRBDordemProducaoEstagio;
begin
  FreeTObjectsList(VpaDFracao.Estagios);
  VpaDFracao.IndEstagiosCarregados := true;
  AdicionaSQLAbreTabela(OrdTabela,'Select OPE.SEQESTAGIO, OPE.QTDCELULA, OPE.DESHORAS, OPE.QTDPRODUZIDO, '+
                        ' OPE.INDPRODUCAO, OPE.VALUNITARIOFACCAO, OPE.INDFINALIZADO, ' +
                        ' OPE.CODESTAGIO, '+
                        ' EST.NOMEST '+
                        ' from FRACAOOPESTAGIO OPE, ESTAGIOPRODUCAO EST '+
                        ' Where OPE.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                        ' and OPE.SEQORDEM = ' + IntToStr(VpaSeqOrdemProducao)+
                        ' and OPE.SEQFRACAO = ' +IntToStr(VpaDFracao.SeqFracao)+
                        ' and OPE.CODESTAGIO  = EST.CODEST ' +
                        ' order by OPE.SEQESTAGIO ');
  While not OrdTabela.Eof do
  begin
    VpfDEstagioFracao := VpaDFracao.AddEstagio;
    VpfDEstagioFracao.SeqEstagio := OrdTabela.FieldByName('SEQESTAGIO').AsInteger;
    VpfDEstagioFracao.CodEstagio := OrdTabela.FieldByName('CODESTAGIO').AsInteger;
    VpfDEstagioFracao.QtdCelula := OrdTabela.FieldByName('QTDCELULA').AsInteger;
//    VpfDEstagioFracao.NumOrdem := OrdTabela.FieldByName('NUMORDEM').AsInteger;
    VpfDEstagioFracao.NomEstagio := OrdTabela.FieldByName('NOMEST').AsString;
    VpfDEstagioFracao.QtdHoras := OrdTabela.FieldByName('DESHORAS').AsString;
    VpfDEstagioFracao.IndProducaoInterna := OrdTabela.FieldByName('INDPRODUCAO').AsString;
    VpfDEstagioFracao.ValUnitarioFaccao := OrdTabela.FieldByName('VALUNITARIOFACCAO').AsFloat;
    VpfDEstagioFracao.QtdProduzido := OrdTabela.FieldByName('QTDPRODUZIDO').AsFloat;
    VpfDEstagioFracao.IndFinalizado := OrdTabela.FieldByName('INDFINALIZADO').AsString = 'S';
    OrdTabela.Next;
  end;
  ordTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDFracaoOPEstagio(VpaDOrdem : TRBDOrdemProducao);
var
  VpfLaco : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  for VpfLaco := 0 to VpaDOrdem.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDOrdem.Fracoes.Items[VpfLaco]);
    CarDFracaoOPEstagio(VpfDFracao,VpaDOrdem.CodEmpresafilial,VpaDOrdem.SeqOrdem);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOrdemSerraFracao(VpaDOrdemProducao : TRBDOrdemProducao);
var
  VpfDOrdemSerra : TRBDOrdemSerra;
  VpfLaco : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  for VpfLaco := 0 to VpaDOrdemProducao.OrdensSerra.Count - 1 do
  begin
    VpfDOrdemSerra := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLaco]);
    AdicionaSQLAbreTabela(OrdOrdemProducao,'Select CODFILIAL, SEQORDEMPRODUCAO, SEQFRACAO '+
                                           ' from ORDEMSERRAFRACAO '+
                                           ' Where CODFILIAL = '+IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                                           ' and SEQORDEMPRODUCAO = '+IntToStr(VpaDOrdemProducao.SeqOrdem)+
                                           ' and SEQORDEMSERRA = '+IntToStr(VpfDOrdemSerra.SeqOrdemSerra));
    while not OrdOrdemProducao.eof do
    begin
      VpfDFracao :=Cardfracaoop(nil,OrdOrdemProducao.FieldByname('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByname('SEQORDEMPRODUCAO').AsInteger,
                                     OrdOrdemProducao.FieldByname('SEQFRACAO').AsInteger);
      CarDFracaoOPEstagio(VpfDFracao,OrdOrdemProducao.FieldByname('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByname('SEQORDEMPRODUCAO').AsInteger);
      VpfDOrdemSerra.Fracoes.add(VpfDFracao);
      OrdOrdemProducao.Next;
    end;
  end;
  OrdOrdemProducao.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDPlanoCorteFracoes(VpaDPlanoCorte : TRBDPlanoCorteCorpo;VpaDItemPlano : TRBDPlanoCorteItem);
var
  VpfDFracao : TRBDPlanoCorteFracao;
begin
  AdicionaSQLAbreTabela(OrdTabela,'Select CODFILIALFRACAO, SEQORDEMPRODUCAO, SEQFRACAO '+
                                  ' FROM PLANOCORTEFRACAO '+
                                  ' Where CODFILIAL = '+IntToStr(VpaDPlanoCorte.CodFilial)+
                                  ' AND SEQPLANOCORTE = '+IntToStr(VpaDPlanoCorte.SeqPlanoCorte)+
                                  ' AND SEQPLANOCORTEITEM = '+IntToStr(VpaDItemPlano.SeqItem));
  While not OrdTabela.Eof do
  begin
    VpfDFracao := VpaDItemPlano.AddFracao;
    VpfDFracao.CodFilial := OrdTabela.FieldByname('CODFILIALFRACAO').AsInteger;
    VpfDFracao.SeqOrdem := OrdTabela.FieldByname('SEQORDEMPRODUCAO').AsInteger;
    VpfDFracao.SeqFracao := OrdTabela.FieldByname('SEQFRACAO').AsInteger;
    OrdTabela.next;
  end;
  OrdTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDPlanoCorteItem(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
Var
  VpfDItemPlano : TRBDPlanoCorteItem;
begin
  AdicionaSQLAbreTabela(OrdOrdemProducao,'Select PCI.CODFILIAL, PCI.SEQPLANOCORTE, PCI.SEQPLANOCORTEITEM, '+
                                         ' PCI.SEQIDENTIFICACAO, PCI.SEQPRODUTO, PCI.QTDPRODUTO, '+
                                         ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                                         ' from PLANOCORTEITEM PCI, CADPRODUTOS PRO '+
                                         ' Where PCI.CODFILIAL = '+ IntToStr(VpaDPlanoCorte.CodFilial)+
                                         ' and PCI.SEQPLANOCORTE = '+IntToStr(VpaDPlanoCorte.SeqPlanoCorte)+
                                         ' and PCI.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                         ' ORDER BY PCI.SEQPLANOCORTEITEM ');
  While not OrdOrdemProducao.Eof do
  begin
    VpfDItemPlano := VpaDPlanoCorte.AddPlanoCorteItem;
    VpfDItemPlano.SeqItem := OrdOrdemProducao.FieldByname('SEQPLANOCORTEITEM').AsInteger;
    VpfDItemPlano.SeqIdentificacao := OrdOrdemProducao.FieldByname('SEQIDENTIFICACAO').AsInteger;
    VpfDItemPlano.SeqProduto := OrdOrdemProducao.FieldByname('SEQPRODUTO').AsInteger;
    VpfDItemPlano.QtdProduto := OrdOrdemProducao.FieldByname('QTDPRODUTO').AsInteger;
    VpfDItemPlano.CodProduto := OrdOrdemProducao.FieldByname('C_COD_PRO').AsString;
    VpfDItemPlano.NomProduto := OrdOrdemProducao.FieldByname('C_NOM_PRO').AsString;
    CarDPlanoCorteFracoes(VpaDPlanoCorte,VpfDItemPlano);
    OrdOrdemProducao.next;
  end;
  OrdOrdemProducao.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDOrdemCorteItem(VpaDOrdemProducao : TRBDordemProducao);
var
  VpfDOrdemCorteItem : TRBDOrdemCorteItem;
begin
  AdicionaSQLAbreTabela(OrdTabela,'Select * from ORDEMCORTEITEM '+
                                  ' Where CODFILIAL = '+IntToStr(VpaDOrdemProducao.CodEmpresafilial)+
                                  ' and SEQORDEMPRODUCAO = '+IntToStr(VpaDOrdemProducao.SeqOrdem)+
                                  ' and SEQORDEMCORTE = '+IntToStr(VpaDOrdemProducao.OrdemCorte.SeqCorte)+
                                  ' order by SEQITEM ');
  While not OrdTabela.eof do
  begin
    VpfDOrdemCorteItem := VpaDOrdemProducao.OrdemCorte.AddCorteItem;
    VpfDOrdemCorteItem.SeqItem := OrdTabela.FieldByName('SEQITEM').AsInteger;
    VpfDOrdemCorteItem.SeqProduto := OrdTabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDOrdemCorteItem.SeqProdutoKit := OrdTabela.FieldByName('SEQPRODUTOKIT').AsInteger;
    VpfDOrdemCorteItem.SeqCorKit := OrdTabela.FieldByName('SEQCORKIT').AsInteger;
    VpfDOrdemCorteItem.SeqMovimentoKit := OrdTabela.FieldByName('SEQMOVIMENTOKIT').AsInteger;
    VpfDOrdemCorteItem.SeqEntretela := OrdTabela.FieldByName('SEQENTRETELA').AsInteger;
    VpfDOrdemCorteItem.SeqTermocolante := OrdTabela.FieldByName('SEQTERMOCOLANTE').AsInteger;
    VpfDOrdemCorteItem.CodCor := OrdTabela.FieldByName('CODCOR').AsInteger;
    VpfDOrdemCorteItem.CodFaca := OrdTabela.FieldByName('CODFACA').AsInteger;
    VpfDOrdemCorteItem.CodMaquina := OrdTabela.FieldByName('CODMAQUINA').AsInteger;
    VpfDOrdemCorteItem.AltProduto := OrdTabela.FieldByName('ALTPRODUTO').AsInteger;
    VpfDOrdemCorteItem.QtdEntretela := OrdTabela.FieldByName('QTDENTRETELA').AsInteger;
    VpfDOrdemCorteItem.QtdTermocolante := OrdTabela.FieldByName('QTDTERMOCOLANTE').AsInteger;
    VpfDOrdemCorteItem.CodBastidor := OrdTabela.FieldByName('CODBASTIDOR').AsInteger;
    VpfDOrdemCorteItem.QtdPecasBastidor := OrdTabela.FieldByName('QTDPECASBASTIDOR').AsInteger;
    VpfDOrdemCorteItem.DesUm := OrdTabela.FieldByName('DESUM').AsString;
    VpfDOrdemCorteItem.DesObservacao := OrdTabela.FieldByName('DESOBSERVACAO').AsString;
    VpfDOrdemCorteItem.LarMolde := OrdTabela.FieldByName('LARMOLDE').AsFloat;
    VpfDOrdemCorteItem.AltMolde := OrdTabela.FieldByName('ALTMOLDE').AsFloat;
    VpfDOrdemCorteItem.QtdProduto := OrdTabela.FieldByName('QTDPRODUTO').AsFloat;
    VpfDOrdemCorteItem.QtdPecasemMetro := OrdTabela.FieldByName('QTDPECAEMMETRO').AsFloat;
    VpfDOrdemCorteItem.ValIndiceMetro := OrdTabela.FieldByName('VALINDICEMETRO').AsFloat;
    OrdTabela.next;
  end;
  OrdTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarComposeFracaoParaConsumoProduto(VpaDProduto : TRBDProduto;VpaDFracaoOP : TRBDFracaoOrdemProducao);
var
  VpfLacoFracao, VpfLacoConsumo : Integer;
  VpfDComposeFracao : TRBDOrcCompose;
  VpfDConsumo : TRBDConsumoMP;
begin
  if config.UtilizarCompose then
  begin
    for VpfLacoFracao := 0 to VpaDFracaoOP.Compose.Count - 1 do
    begin
      VpfDComposeFracao := TRBDOrcCompose(VpaDFracaoOP.Compose.Items[VpfLacoFracao]);
      for VpfLacoConsumo := 0 to VpaDProduto.ConsumosMP.Count - 1 do
      begin
        VpfDConsumo := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoConsumo]);
        if VpfDComposeFracao.CorRefencia = VpfDConsumo.CorReferencia then
        begin
          VpfDConsumo.SeqProduto := VpfDComposeFracao.SeqProduto;
          VpfDConsumo.CodCor := VpfDComposeFracao.CodCor;
          break;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AtualizaDatasOP(VpaDColetaOP : TRBDColetaOP) : String;
begin
  result := '';
  adicionaSqlabreTabela(OrdCadastro,'Select * from ORDEMPRODUCAOCORPO '+
                                        ' Where EMPFIL = '+IntToStr(VpaDColetaOP.CodEmpresaFilial) +
                                        ' AND SEQORD = '+IntToStr(VpaDColetaOP.SeqOrdemProducao));
  OrdCadastro.Edit;
  if OrdCadastro.FieldByName('DATPCO').IsNull Then
    OrdCadastro.FieldByName('DATPCO').AsDateTime := now;
  if VpaDColetaOP.IndFinal then
    OrdCadastro.FieldByName('DATFIM').AsDatetime := now;

  Ordcadastro.Post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AtualizaDColetadosOP(VpaDColetaOP : TRBDColetaOP) : String;
var
  VpfLaco : Integer;
  VpfDColetaItem : TRBDColetaOPItem;
begin
  result := AtualizaDatasOP(VpaDColetaOP);
  if result = '' then
  begin

    for VpfLaco := 0 to VpaDColetaOP.ItensColeta.count - 1 do
    begin
      VpfDColetaItem := TRBDColetaOPItem(VpaDColetaOP.ItensColeta.Items[Vpflaco]);
      if VpfDColetaItem.MetrosColetados <> 0 then
      begin
        AdicionaSQLAbreTabela(OrdCadastro,'Select * from ORDEMPRODUCAOITEM '+
                                          ' Where EMPFIL = '+IntToStr(VpaDColetaOP.CodEmpresaFilial) +
                                          ' AND SEQORD = '+IntToStr(VpaDColetaOP.SeqOrdemProducao)+
                                          ' and SEQITE = ' +InTToStr(VpfDColetaItem.SeqItem));
        OrdCadastro.Edit;
        OrdCadastro.FieldByName('QTDPRO').AsFloat := OrdCadastro.FieldByName('QTDPRO').AsFloat + (VpfDColetaItem.MetrosColetados *VpfDColetaItem.NroFitas) ;
        OrdCadastro.FieldByName('QTDFAL').AsFloat := OrdCadastro.FieldByName('QTDFAL').AsFloat - (VpfDColetaItem.MetrosColetados * VpfDColetaItem.NroFitas);
        ordCadastro.post;
        result := OrdCadastro.AMensagemErroGravacao;
        if OrdCadastro.AErronaGravacao then
          exit;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AtualizaDFracoesEnviadasFaccionista(VpaDFracaoFaccionista : TRBDFracaoFaccionista):String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaDFracaoFaccionista.CodFaccionista));
  OrdCadastro.edit;
  OrdCadastro.FieldByname('QTDPRODUTO').AsFloat := OrdCadastro.FieldByname('QTDPRODUTO').AsFloat + VpaDFracaoFaccionista.QtdEnviado;
  OrdCadastro.FieldByname('QTDFRACAO').AsInteger := OrdCadastro.FieldByname('QTDFRACAO').AsInteger + 1; 
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AtualizaDFracaoOpFaccionista(VpaDRetornoFracao : TRBDRetornoFracaoFaccionista):String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaDRetornoFracao.CodFaccionista)+
                                    ' and SEQITEM = '+IntToStr(VpaDRetornoFracao.SeqItem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByname('QTDPRODUZIDO').AsFloat := OrdCadastro.FieldByname('QTDPRODUZIDO').AsFloat + VpaDRetornoFracao.QtdRetorno;
  if VpaDRetornoFracao.IndFinalizar then
    OrdCadastro.FieldByname('DATFINALIZACAO').AsDateTime := now;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
  begin
    AdicionaSQLAbreTabela(OrdCadastro,'Select * FROM FACCIONISTA '+
                                      ' Where CODFACCIONISTA = '+IntToStr(VpaDRetornoFracao.CodFaccionista));
    OrdCadastro.edit;
    if VpaDRetornoFracao.DatCadastro < IncDia(VpaDRetornoFracao.DatNegociado,1) then
      OrdCadastro.FieldByname('QTDENTREGASNOPRAZO').AsInteger := OrdCadastro.FieldByname('QTDENTREGASNOPRAZO').AsInteger + 1
    else
      OrdCadastro.FieldByname('QTDENTREGAATRASADO').AsInteger := OrdCadastro.FieldByname('QTDENTREGAATRASADO').AsInteger + 1;
    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    OrdCadastro.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AtulaizaDevolucaFracaoFaccionista(VpaDDevolucaoFracao : TRBDDevolucaoFracaoFaccionista) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaDDevolucaoFracao.CodFaccionista)+
                                    ' and SEQITEM = '+IntToStr(VpaDDevolucaoFracao.SeqItem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByname('QTDDEVOLUCAO').AsFloat := OrdCadastro.FieldByname('QTDDEVOLUCAO').AsFloat + VpaDDevolucaoFracao.QtdDevolvido;
  OrdCadastro.FieldByname('DATFINALIZACAO').AsDateTime := now;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;

  if result = '' then
  begin
    AdicionaSQLAbreTabela(OrdCadastro,'Select * from FACCIONISTA '+
                                      ' Where CODFACCIONISTA = '+ IntToStr(VpaDDevolucaoFracao.CodFaccionista));
    OrdCadastro.edit;
    OrdCadastro.FieldByname('QTDDEVOLUCOES').AsInteger := OrdCadastro.FieldByname('QTDDEVOLUCOES').AsInteger + 1;
    OrdCadastro.FieldByname('QTDPRODUTODEVOLVIDO').AsFloat := OrdCadastro.FieldByname('QTDPRODUTODEVOLVIDO').AsFloat + VpaDDevolucaoFracao.QtdDevolvido;
    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.AlteraEstagiosFracoesPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
var
  VpfLacoItem, VpfLacoFracao : Integer;
  VpfDItemPlano : TRBDPlanoCorteItem;
  vpfDFracaoPlano : TRBDPlanoCorteFracao;
begin
  for VpfLacoItem := 0 to VpaDPlanoCorte.Itens.Count - 1 do
  begin
    VpfDItemPlano := TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLacoItem]);
    for VpfLacoFracao := 0 to VpfDItemPlano.Fracoes.Count - 1 do
    begin
      vpfDFracaoPlano := TRBDPlanoCorteFracao(VpfDItemPlano.Fracoes[VpfLacoFracao]);
      AlteraEstagioFracaoOp(vpfDFracaoPlano.CodFilial,vpfDFracaoPlano.SeqOrdem,vpfDFracaoPlano.SeqFracao,varia.EstagioPantografo);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExtornaAtualizacoesRetornoFaccionista(VpaCodFaccionista,VpaSeqItem, VpaSeqRetorno : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdAux,'Select * FROM RETORNOFRACAOOPFACCIONISTA '+
                               ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                               ' and SEQITEM = ' +IntToStr(VpaSeqItem)+
                               ' and SEQRETORNO = '+IntToStr(VpaSeqRetorno));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                                    ' and SEQITEM = '+IntToStr(VpaSeqItem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByname('QTDPRODUZIDO').AsFloat := OrdCadastro.FieldByname('QTDPRODUZIDO').AsFloat - OrdAux.FieldByname('QTDRETORNO').AsFloat;
  if OrdAux.FieldByname('INDFINALIZARFRACAO').AsString = 'S' then
    OrdCadastro.FieldByname('DATFINALIZACAO').Clear;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExtornaAtualizacoesDevolucaoFaccionista(VpaCodFaccionista,VpaSeqItem, VpaSeqDevolucao : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdAux,'Select * FROM DEVOLUCAOFRACAOOPFACCIONISTA '+
                               ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                               ' and SEQITEM = ' +IntToStr(VpaSeqItem)+
                               ' and SEQDEVOLUCAO = '+IntToStr(VpaSeqDevolucao));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                                    ' and SEQITEM = '+IntToStr(VpaSeqItem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByname('QTDDEVOLUCAO').AsFloat := OrdCadastro.FieldByname('QTDDEVOLUCAO').AsFloat - OrdAux.FieldByname('QTDDEVOLVIDO').AsFloat;
  OrdCadastro.FieldByname('DATFINALIZACAO').Clear;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
  begin
    AdicionaSQLAbreTabela(OrdCadastro,'Select * from FACCIONISTA '+
                                      ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista));
    OrdCadastro.edit;
    OrdCadastro.FieldByname('QTDDEVOLUCOES').AsInteger := OrdCadastro.FieldByname('QTDDEVOLUCOES').AsInteger - 1;
    OrdCadastro.FieldByname('QTDPRODUTODEVOLVIDO').AsFloat := OrdCadastro.FieldByname('QTDPRODUTODEVOLVIDO').AsFloat - OrdAux.FieldByname('QTDDEVOLVIDO').AsFloat;

    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
    OrdCadastro.close;
  end;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExtornaAtualizacaoEnvioFaccionista(VpaCodFaccionista, VpaSeqItem : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdAux,'Select * FROM FRACAOOPFACCIONISTA '+
                               ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                               ' and SEQITEM = ' +IntToStr(VpaSeqItem));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista));
  OrdCadastro.edit;
  OrdCadastro.FieldByname('QTDFRACAO').AsInteger := OrdCadastro.FieldByname('QTDFRACAO').AsInteger - 1;
  OrdCadastro.FieldByname('QTDPRODUTO').AsFloat := OrdCadastro.FieldByname('QTDPRODUTO').AsFloat - OrdAux.FieldByname('QTDENVIADO').AsFloat;

  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.CadastraNovoRomaneioFilial(VpaSeqFilial : String) : Integer;
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOCORPO');
  OrdCadastro.Insert;
  OrdCadastro.FieldByName('EMPFIL').AsString := VpaSeqFilial;
  OrdCadastro.FieldByName('DATINI').AsDateTime := now;
  OrdCadastro.FieldByName('NOTGER').AsString := 'N';
  OrdCadastro.FieldByName('INDIMP').AsString := 'N';
  OrdCadastro.FieldByName('INDIMP').AsString := 'N';
  result := RSeqRomaneioDisponivel(VpaSeqFilial);
  OrdCadastro.FieldByName('SEQROM').AsInteger := result;
  OrdCadastro.Post;
  OrdCadastro.Close;
  ExecutaComandoSql(OrdAux,'UPDATE CADFILIAIS '+
                           ' Set I_SEQ_ROM = '+ IntToStr(result)+
                           ' Where I_EMP_FIL = '+ VpaSeqFilial);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.MarcaColetaAdicionada(VpaFilial,VpaSeqOrdem,VpaSeqColeta : String):String;
begin
  result := '';
  try
    ExecutaComandoSql(OrdAux,'UPDATE COLETAOPCORPO '+
                             ' SET INDROM = ''S'''+
                             ' Where EMPFIL = '+VpaFilial+
                             ' and SEQORD = '+ VpaSeqOrdem+
                             ' and SEQCOL = '+ VpaSeqColeta);
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO STATUS DA COLETA DA OP COMO ADICIONADA NO ROMANEIO!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.MarcaConsumoFracaoBaixado(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao : Integer):string;
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOP '+
                                    ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                    ' and SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                                    ' and SEQFRACAO = '+IntToStr(VpaSeqFracao));
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('INDCONSUMOBAIXADO').AsString := 'S';

  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.MarcaEstagioNaoProcessado(VpaDFracao: TRBDFracaoOrdemProducao; VpaCodEstagio: Integer);
var
  VpfLaco : Integer;
  VpfDEstagio : TRBDordemProducaoEstagio;
begin
  for VpfLaco := 0 to VpaDFracao.Estagios.Count - 1 do
  begin
    VpfDEstagio := TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLaco]);
    if VpfDEstagio.CodEstagio = VpaCodEstagio then
      VpfDEstagio.IndFinalizado := false;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ApagaProdutividadeCelula(VpaCodCelula : Integer;VpaData : TDateTime);
begin
  ExecutaComandoSql(OrdAux,'Delete from PRODUTIVIDADECELULATRABALHO'+
                        ' Where DATPRODUTIVIDADE = ' +SQLTextoDataAAAAMMMDD(VpaData)+
                        ' and CODCELULA = '+IntToStr(VpaCodCelula));
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExcluiProdutoOrdemSerra(VpaDOrdemProducao: TRBDordemProducao;VpaDFracao : TRBDFracaoOrdemProducao;  VpaDConsumoFracao : TRBDConsumoOrdemProducao);
var
  VpfLaco, VpfLacoFracao : Integer;
  VpfDOrdemSerra : TRBDOrdemSerra;
  VpfDFracaoOrdemSerra : TRBDFracaoOrdemProducao;
  VpfComMateriaPrima : Double;
  VpfEncontrouOrdemSerra : Boolean;
begin
  VpfEncontrouOrdemSerra := false;
  VpfComMateriaPrima := RComprimentoOrdemSerra(VpaDConsumoFracao.QtdUnitario);

  for VpfLaco := VpaDOrdemProducao.OrdensSerra.Count - 1 downto 0 do
  begin
    VpfDOrdemSerra := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLaco]);
    if (VpfDOrdemSerra.SeqMateriaPrima = VpaDConsumoFracao.SeqProduto) and
       (VpfDOrdemSerra.SeqProduto = VpaDFracao.SeqProduto) and
       (VpfDOrdemSerra.ComMateriaPrima = VpfComMateriaPrima) then
    begin
      VpfDOrdemSerra.QtdProduto := VpfDOrdemSerra.QtdProduto - 1;
      if VpfDOrdemSerra.QtdProduto  = 0 then
        VpaDOrdemProducao.OrdensSerra.Delete(VpfLaco)
      else
      begin
        //exclui a fracao da ordem de serra;
        for VpfLacoFracao := 0 to VpfDOrdemSerra.Fracoes.Count - 1 do
        begin
          VpfDFracaoOrdemSerra := TRBDFracaoOrdemProducao(VpfDOrdemSerra.Fracoes.Items[VpfLacoFracao]);
          if (VpfDFracaoOrdemSerra.CodFilial = VpaDFracao.CodFilial) and
             (VpfDFracaoOrdemSerra.CodFilial = VpaDFracao.SeqOrdemProducao) and
             (VpfDFracaoOrdemSerra.CodFilial = VpaDFracao.SeqFracao) then
          begin
            VpfDOrdemSerra.Fracoes.Delete(VpfLacoFracao);
            break;
          end;
        end;
      end;
      VpfEncontrouOrdemSerra := true;
      break;
    end;
  end;

  if not VpfEncontrouOrdemSerra then
    aviso('não encontrou ordem de serra para excluir');

  MarcaEstagioNaoProcessado(VpaDFracao,Varia.EstagioSerra);
  AlteraEstagioFracaoOP(VpaDFracao.CodFilial,VpaDFracao.SeqOrdemProducao,VpaDFracao.SeqFracao,varia.EstagioOrdemProducao);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExcluiProdutoRomaneioItem(VpaSeqRomaneio,VpaSeqItem : Integer; VpaDColetaRomaneio : TRBDColetaRomaneioOp);
begin
  ExecutaComandoSql(OrdAux,'Delete from ROMANEIOPRODUTOITEM '+
                           ' Where CODFILIAL = '+IntToStr(VpaDColetaRomaneio.CodFilial)+
                           ' AND SEQROMANEIO = '+IntToStr(VpaSeqRomaneio)+
                           ' AND SEQITEM = '+IntToStr(VpaSeqItem)+
                           ' AND SEQORDEM = '+IntToStr(VpaDColetaRomaneio.NumOrdemProducao)+
                           ' AND SEQFRACAO = '+IntToStr(VpaDColetaRomaneio.SeqFracao)+
                           ' AND SEQCOLETA = '+IntToStr(VpaDColetaRomaneio.SeqColeta));
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.BaixaQtdFracaoOPEstagio(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio : Integer;VpaQtd : Double;VpaIndExtornar : Boolean);
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPESTAGIO '+
                                    ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                    ' and SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                                    ' and SEQFRACAO = ' +IntToStr(VpaSeqFracao)+
                                    ' and SEQESTAGIO = '+ IntToStr(VpaSeqEstagio));
  OrdCadastro.Edit;
  if VpaIndExtornar then
    OrdCadastro.FieldByName('QTDPRODUZIDO').AsFloat := OrdCadastro.FieldByName('QTDPRODUZIDO').AsFloat - VpaQtd
  else
    OrdCadastro.FieldByName('QTDPRODUZIDO').AsFloat := OrdCadastro.FieldByName('QTDPRODUZIDO').AsFloat + VpaQtd;
  OrdCadastro.Post;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExtornaColetadoRomaneioProduto(VpaSeqRomaneio,VpaSeqItem : Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp; VpaDOrdemProducao : TRBDordemProducao;VpaQtdProduto : Double):string;
begin
  result := '';
  LocalizaRomaneioProduto(OrdCadastro,VpaDColetaRomaneio.CodFilial,VpaSeqRomaneio,VpaSeqItem);
  if not OrdCadastro.eof then
  begin
    if RQtdRomaneioProdutoItem(VpaDColetaRomaneio.CodFilial,VpaSeqRomaneio,VpaSeqItem) = 0 then
      OrdCadastro.delete
    else
    begin
      OrdCadastro.Edit;
      OrdCadastro.FieldByName('QTDPRODUTO').AsFloat := OrdCadastro.FieldByName('QTDPRODUTO').AsFloat - VpaQtdProduto;
      OrdCadastro.FieldByName('VALTOTAL').AsFloat := OrdCadastro.FieldByName('QTDPRODUTO').AsFloat * VpaDOrdemProducao.ValUnitario;

      OrdCadastro.post;
      result := OrdCadastro.AMensagemErroGravacao;
    end;
  end;
  ordCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExtornaColetadoRomaneio(VpaSeqRomaneio: Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp; VpaDOrdemProducao : TRBDordemProducao;VpaQtdProduto : Double):string;
begin
  LocalizaRomaneio(OrdCadastro,VpaDColetaRomaneio.CodFilial,VpaSeqRomaneio);
  if not OrdCadastro.Eof Then
  begin
    if RQtdRomaneioProduto(VpaDColetaRomaneio.CodFilial,VpaSeqRomaneio) = 0 then
      OrdCadastro.delete
    else
    begin
      OrdCadastro.Edit;
      OrdCadastro.FieldByName('VALTOT').AsFloat := OrdCadastro.FieldByName('VALTOT').AsFloat -(VpaQtdProduto * VpaDOrdemProducao.ValUnitario);
      OrdCadastro.post;
      result := OrdCadastro.AMensagemErroGravacao;
    end;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CopiaQtdColetadoEstagio(VpaDFracaoOrigem, VpaDFracaoDestino : TRBDFracaoOrdemProducao);
var
  VpfLaco : Integer;
  VpfDEstagioOrigem, VpfDEstagioDestino : TRBDordemProducaoEstagio;
begin
  for VpfLaco := 0 to VpaDFracaoOrigem.Estagios.Count - 1 do
  begin
    VpfDEstagioOrigem := TRBDordemProducaoEstagio(VpaDFracaoOrigem.Estagios.Items[VpfLaco]);
    VpfDEstagioDestino := VpaDFracaoDestino.AddEstagio;
    VpfDEstagioDestino.SeqEstagio := VpfDEstagioOrigem.SeqEstagio;
    VpfDEstagioDestino.QtdProduzido := VpfDEstagioOrigem.QtdProduzido;
    VpfDEstagioDestino.IndProducaoInterna := VpfDEstagioOrigem.IndProducaoInterna;
    VpfDEstagioDestino.ValUnitarioFaccao := VpfDEstagioOrigem.ValUnitarioFaccao;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ArrumaQtdProduzidaEstagio(VpaDFracaoAntiga, VpaDFracaoNova : TRBDFracaoOrdemProducao);
var
  VpfLaco : Integer;
  VpfDEstagioAntigo, VpfDEstagioNovo : TRBDordemProducaoEstagio;
begin
  for Vpflaco := 0 to VpaDFracaoAntiga.Estagios.Count - 1 do
  begin
    VpfDEstagioAntigo := TRBDordemProducaoEstagio(VpaDFracaoAntiga.Estagios[Vpflaco]);
    VpfDEstagioNovo := REstagioProducao(VpaDFracaoNova,VpfDEstagioAntigo.SeqEstagio);
    if VpfDEstagioNovo <> nil then
    begin
      VpfDEstagioNovo.QtdProduzido := VpfDEstagioAntigo.QtdProduzido;
      VpfDEstagioNovo.IndProducaoInterna := VpfDEstagioAntigo.IndProducaoInterna;
      VpfDEstagioNovo.ValUnitarioFaccao := VpfDEstagioAntigo.ValUnitarioFaccao;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaProdutoRomaneioItem(VpaSeqRomaneio,VpaSeqItem : Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao):String;
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOPRODUTOITEM');
  OrdCadastro.Insert;

  OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDColetaRomaneio.CodFilial;
  OrdCadastro.FieldByName('SEQROMANEIO').AsInteger := VpaSeqRomaneio;
  OrdCadastro.FieldByName('SEQITEM').AsInteger := VpaSeqItem;
  OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaDColetaRomaneio.NumOrdemProducao;
  OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDColetaRomaneio.SeqFracao;
  OrdCadastro.FieldByName('SEQCOLETA').AsInteger := VpaDColetaRomaneio.SeqColeta;

  ordCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaProdutoRomaneio(VpaSeqRomaneio : Integer; VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao;VpaQtdProduto : Double):String;
var
  VpfDesOrdemCompra : String;
  VpfSeqitem : Integer;
begin
  result := '';
  if VpaDOrdemProducao.DesOrdemCompra <> '' then
    VpfDesOrdemCompra := ' and DESORDEMCOMPRA = '''+VpaDOrdemProducao.DesOrdemCompra+''''
  else
    VpfDesOrdemCompra := ' and DESORDEMCOMPRA is NULL';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOPRODUTO '+
                                    ' Where CODFILIAL = '+ IntToStr(VpaDColetaRomaneio.CodFilial)+
                                    ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio)+
                                    ' and SEQPRODUTO = ' +IntToStr(VpaDOrdemProducao.SeqProduto)+
                                    ' and CODCOR = ' + IntToStr(VpaDOrdemProducao.CodCor)+
                                    VpfDesOrdemCompra);
  if OrdCadastro.Eof then
  begin
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDColetaRomaneio.CodFilial;
    OrdCadastro.FieldByName('SEQROMANEIO').AsInteger := VpaSeqRomaneio;
    OrdCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDOrdemProducao.SeqProduto;
    OrdCadastro.FieldByName('CODCOR').AsInteger := VpaDOrdemProducao.CodCor;
    if VpaDOrdemProducao.DesOrdemCompra <> '' then
      OrdCadastro.FieldByName('DESORDEMCOMPRA').AsString := VpaDOrdemProducao.DesOrdemCompra;
    OrdCadastro.FieldByName('DESREFERENCIAPRODUTO').AsString := VpaDOrdemProducao.DesReferenciaCliente;
    OrdCadastro.FieldByName('DESUM').AsString := VpaDOrdemProducao.UMPedido;
    OrdCadastro.FieldByName('SEQITEM').AsInteger :=RSeqRomaneioProdutoDisponivel(VpaDColetaRomaneio.CodFilial,VpaSeqRomaneio) ;
  end
  else
    OrdCadastro.Edit;
  VpfSeqitem := OrdCadastro.FieldByName('SEQITEM').AsInteger;
  OrdCadastro.FieldByName('QTDPRODUTO').AsFloat := OrdCadastro.FieldByName('QTDPRODUTO').AsFloat + VpaQtdProduto;
  OrdCadastro.FieldByName('VALTOTAL').AsFloat := OrdCadastro.FieldByName('QTDPRODUTO').AsFloat * VpaDOrdemProducao.ValUnitario;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
    result := AdicionaProdutoRomaneioItem(VpaSeqRomaneio,VpfSeqItem,VpaDColetaRomaneio,VpaDOrdemProducao);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaColetaFracaoOpRomaneio(VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao):String;
var
  VpfQtdProduto : Double;
  VpfSeqRomaneio : Integer;
begin
  result := '';
  VpfQtdProduto := FunProdutos.CalculaQdadePadrao(VpaDColetaRomaneio.DesUM,VpaDOrdemProducao.UMPedido,VpaDColetaRomaneio.QtdColetado,IntToStr(VpaDOrdemProducao.SeqProduto));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOCORPO '+
                                    ' Where EMPFIL = ' +IntToStr(VpaDColetaRomaneio.CodFilial)+
                                    ' and CODCLI = ' + IntToStr(VpaDOrdemProducao.CodCliente)+
                                    ' and DATFIM is null');
  if OrdCadastro.Eof Then
  begin
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaDColetaRomaneio.CodFilial;
    OrdCadastro.FieldByName('DATINI').AsDateTime := now;
    OrdCadastro.FieldByName('NOTGER').AsString := 'N';
    OrdCadastro.FieldByName('INDIMP').AsString := 'N';
    OrdCadastro.FieldByName('CODCLI').AsInteger := VpaDOrdemProducao.CodCliente;
    OrdCadastro.FieldByName('SEQROM').AsInteger := RSeqRomaneioDisponivel(IntToStr(VpaDColetaRomaneio.CodFilial));
  end
  else
  begin
    OrdCadastro.edit;
  end;
  VpfSeqRomaneio := OrdCadastro.FieldByName('SEQROM').AsInteger;
  OrdCadastro.FieldByName('VALTOT').AsFloat := OrdCadastro.FieldByName('VALTOT').AsFloat +(VpfQtdProduto * VpaDOrdemProducao.ValUnitario);
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
    result := AdicionaProdutoRomaneio(VpfSeqRomaneio,VpaDColetaRomaneio,VpaDOrdemProducao,VpfQtdProduto);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaNotaRomaneionoOrcamento(VpaCodfilial,VpaSeqNota, VpaLanOrcamento : Integer;VpaNumNota : string):string;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from CADORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  ordCadastro.edit;
  if OrdCadastro.FieldByName('C_NRO_NOT').AsString <> '' then
    OrdCadastro.FieldByName('C_NRO_NOT').AsString := OrdCadastro.FieldByName('C_NRO_NOT').AsString+'/'+VpaNumNota
  else
    OrdCadastro.FieldByName('C_NRO_NOT').AsString := VpaNumNota;
  OrdCadastro.FieldByName('C_NOT_GER').AsString := 'S';
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;

  if result = '' then
    ExecutaComandoSql(OrdAux,'insert into MOVNOTAORCAMENTO (I_EMP_FIL, I_SEQ_NOT,I_LAN_ORC) VALUES'+
                             ' ('+IntToStr(VpaCodfilial)+','+
                             IntToStr(VpaSeqNota)+ ','+
                             IntToStr(VpaLanOrcamento)+')');
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.AdicionaNoFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaNoPai : TTreeNode;VpaArvore : TTreeView);
var
  VpfNo : TTreeNode;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTabela : TSQLQuery;
begin
  VpfTabela := TSQLQUERY.Create(nil);
  VpfTabela.SQLConnection := ordCadastro.ASqlConnection;
  AdicionaSQLAbreTabela(VpfTabela,'Select CODFILIAL, SEQORDEM, SEQFRACAO '+
                                  ' from FRACAOOP '+
                                  ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                  ' and SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                                  ' and SEQFRACAOPAI = '+IntToStr(VpaSeqFracao));
  While not VpfTabela.Eof do
  begin
    VpfDFracao :=  cardfracaoOP(nil,VpfTabela.FieldByName('CODFILIAL').AsInteger,VpfTabela.FieldByName('SEQORDEM').AsInteger,VpfTabela.FieldByName('SEQFRACAO').AsInteger);
    VpfDFracao.IndEstagiosCarregados := false;
    VpfNo := VpaArvore.Items.AddChildObject(VpaNoPai,VpfTabela.FieldByName('SEQFRACAO').AsString+
                                         ' '+VpfDFracao.CodProduto+'-'+
                                          VpfDFracao.NomProduto, VpfDFracao);
    CarIconeNoFracao(VpfNo,VpfDFracao);
    VpfTabela.next;
  end;
  VpfTabela.close;
  VpfTabela.free;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.EliminaColetaFracaoOPRomaneio(VpaSeqRomaneio : Integer;VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao):String;
Var
  VpfItemRomaneio : Integer;
  VpfQtdProduto : Double;
begin
  result := '';
  VpfQtdProduto := FunProdutos.CalculaQdadePadrao(VpaDColetaRomaneio.DesUM,VpaDOrdemProducao.UMPedido,VpaDColetaRomaneio.QtdColetado,IntToStr(VpaDOrdemProducao.SeqProduto));
  VpfItemRomaneio := RItemRomaneioProduto(VpaSeqRomaneio,VpaDColetaRomaneio);

  ExcluiProdutoRomaneioItem(VpaSeqRomaneio,VpfItemRomaneio,VpaDColetaRomaneio);
  //subtrai a qtd do romaneioproduto
  result := ExtornaColetadoRomaneioProduto(VpaSeqRomaneio,VpfItemRomaneio,VpaDColetaRomaneio,VpaDOrdemProducao,VpfQtdProduto);
  if result = '' then
  begin
    //subtrai a qtd do romaneiocorpo
    result := ExtornaColetadoRomaneio(VpaSeqRomaneio,VpaDColetaRomaneio,VpaDOrdemProducao,VpfQtdProduto);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ZeraQtdaFaturarFracao(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao : Integer);
begin
  ExecutaComandoSql(OrdAux,'UPDATE FRACAOOP '+
                           ' set QTDAFATURAR = NULL '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                           ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.BaixaRomaneioMovOrcamento(VpaCodfilial, VpaLanOrcamento, VpaIteOrcamento,VpaSeqProduto : Integer;VpaDesUMColeta,VpaDesUMPEDIDO : String;VpaQtdColetado : Double;VpaEstornar : Boolean):string;
var
  VpfQtdProdutos : Double;
begin
  result := '';
  if VpaEstornar then
    VpaQtdColetado := VpaQtdColetado * -1;
  VpfQtdProdutos := FunProdutos.CalculaQdadePadrao(VpaDesUMColeta,VpaDesUMPEDIDO,VpaQtdColetado,InttoStr(VpaSeqProduto));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial)+
                                    ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' AND I_SEQ_MOV = '+IntToStr(VpaIteOrcamento));
  OrdCadastro.edit;
  OrdCadastro.FieldByName('N_QTD_BAI').AsFloat := OrdCadastro.FieldByName('N_QTD_BAI').AsFloat + VpfQtdProdutos;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CopiaCompose(VpaComposeDe, VpaComposePara : TList);
var
  VpfLaco : Integer;
  VpfDComposeDe, VpfDComposePara : TRBDOrcCompose;
begin
  for VpfLaco := 0 to VpaComposeDe.Count - 1 do
  begin
    VpfDComposeDe := TRBDOrcCompose(VpaComposeDe.Items[VpfLaco]);
    VpfDComposePara := TRBDOrcCompose.cria;
    VpaComposePara.add(VpfDComposePara);
    VpfDComposePara.SeqCompose := VpfDComposeDe.SeqCompose;
    VpfDComposePara.CorRefencia := VpfDComposeDe.CorRefencia;
    VpfDComposePara.SeqProduto := VpfDComposeDe.SeqProduto;
    VpfDComposePara.CodCor := VpfDComposeDe.CodCor;
    VpfDComposePara.CodProduto := VpfDComposeDe.CodProduto;
    VpfDComposePara.NomProduto := VpfDComposeDe.NomProduto;
    VpfDComposePara.NomCor := VpfDComposeDe.NomCor;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ComposeIgual(VpaCompose1, VpaCompose2 : TList):Boolean;
var
  VpfLaco : integer;
  VpfDCompose1,VpfDCompose2 : TRBDOrcCompose;
begin
  result := true;
  if VpaCompose1.Count <> VpaCompose2.Count then
    result := false
  else
  begin
    for VpfLaco := 0 to VpaCompose1.Count - 1 do
    begin
      VpfDCompose1 := TRBDOrcCompose(VpaCompose1.Items[VpfLaco]);

      VpfDCompose2 := TRBDOrcCompose(VpaCompose2.Items[VpfLaco]);
      if (VpfDCompose1.SeqProduto <> VpfDCompose2.SeqProduto) or
         (VpfDCompose1.CodCor <> VpfDCompose2.CodCor) then
      begin
        result := false;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteProdutoGerarOP(VpaDProduto : TRBDOrcProduto;VpaGerarOp : TList) : TRBDGerarOp;
var
  VpfLaco : Integer;
  VpfDGerarOP : TRBDGerarOp;
begin
  result := nil;
  for VpfLaco := 0 to VpaGerarOp.Count - 1 do
  begin
    VpfDGerarOP := TRBDGerarOp(VpaGerarOP.Items[VpfLaco]);
    if (VpfDGerarOP.SeqProduto = VpaDProduto.SeqProduto) and (VpfDGerarOP.CodCor = VpaDProduto.CodCor) and
       (VpfDGerarOP.CodTamanho = VpaDProduto.CodTamanho) then
    begin
      if config.UtilizarCompose then
      begin
        if ComposeIgual(VpaDProduto.Compose,VpfDGerarOP.Compose) then
          result := VpfDGerarOP;
      end
      else
        result := VpfDGerarOP;
      if result <> nil then
        break;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.GeraConsumoOPAgrupada(VpaDOrdemProducao : TRBDordemProducao);
var
  VpfLacoFracao,VpfLacoConsumoProduto : Integer;
  VpfDFracao : TRBdfracaoOrdemProducao;
  VpfDProduto : TRBDProduto;
  VpfSeqProduto, VpfCodCor : INteger;
begin
  VpfDProduto := nil;
  VpfSeqProduto := VpaDOrdemProducao.SeqProduto;
  VpfCodCor := VpaDOrdemProducao.CodCor;
  FreeTObjectsList(VpaDOrdemProducao.Consumo);
  for VpfLacoFracao := 0 to VpaDOrdemProducao.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLacoFracao]);
    if (varia.TipoOrdemProducao in [toSubMontagem,toAgrupada]) then
    begin
      VpfSeqProduto := VpfDFracao.SeqProduto;
      VpfCodCor := VpfDFracao.CodCor;
    end;

    //carrega o consumo do produto
    if VpfDProduto <> nil then
      VpfDProduto.free;
    VpfDProduto := TRBDProduto.cria;
    VpfDProduto.CodEmpresa := varia.CodigoEmpresa;
    VpfDProduto.SeqProduto := VpfSeqProduto;
    FunProdutos.CarConsumoProduto(VpfDProduto,VpfCodCor);
    FunProdutos.ApagaSubMontagensdaListaConsumo(VpfDProduto);

    CarComposeFracaoParaConsumoProduto(VpfDProduto,VpfDFracao);
    //gera o consumo da fracao;
    GeraConsumoFracao(VpaDOrdemProducao,VpfDFracao,VpfDProduto);
    //adiciona o consumo do da ordem e corte;
    AdicionaConsumoOrdemCorte(VpaDOrdemProducao,VpfDFracao);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.OrdenaOrdemSerra(VpaDOrdemProducao : TRBDordemProducao);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDOrdemSerraInterno, VpfDOrdemSerraExterno : TRBDOrdemSerra;
begin
  for VpfLacoExterno := 0 to VpaDOrdemProducao.OrdensSerra.Count - 2 do
  begin
    VpfDOrdemSerraExterno := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDOrdemProducao.OrdensSerra.Count - 1 do
    begin
      VpfDOrdemSerraInterno := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLacoInterno]);
      if VpfDOrdemSerraExterno.NomMateriaPrima > VpfDOrdemSerraInterno.NomMateriaPrima then
      begin
        VpaDOrdemProducao.OrdensSerra[VpfLacoExterno] := VpfDOrdemSerraInterno;
        VpaDOrdemProducao.OrdensSerra[VpfLacoInterno] := VpfDOrdemSerraExterno;
        VpfDOrdemSerraExterno := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLacoExterno]);
      end;
    end;
  end;
  for VpfLacoInterno := 0 to VpaDOrdemProducao.OrdensSerra.Count - 1 do
    TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLacoInterno]).SeqOrdemSerra := VpfLacoInterno + 1;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqRomaneio(VpaSeqFilial : String) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select I_SEQ_ROM from CADFILIAIS '+
                               ' Where I_EMP_FIL = ' + VpaSeqFilial);
  result := OrdAux.FieldByName('I_SEQ_ROM').AsInteger;
  if result = 0 then
  begin
    if confirmacao('Não existe nenhum romaneio ativo para esta filial. Deseja cadastrar um novo romaneio e torná-lo ativo?') then
    begin
      result := CadastraNovoRomaneioFilial(VpaSeqFilial);
    end;
  end
  else
  begin
    if (RQtdItemRomaneio(VpaSeqFilial,IntToStr(result)) >= 22) then
    begin
      if confirmacao('O romaneio atual já possui 22 itens. Deseja iniciar outro romaneio?') then
      begin
        FinalizaRomaneio(VpaSeqFilial,IntToStr(result));
        result := CadastraNovoRomaneioFilial(VpaSeqFilial);
      end
      else
        result := 0;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqMaquinaDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqItem : String):Integer;
begin
  AdicionaSqlAbreTabela(OrdAux,'Select MAX(SEQMAQ) ULTIMO  from OPITEMCADARCOMAQUINA '+
                               ' Where EMPFIL = '+ VpaFilial+
                               ' and SEQORD = '+ VpaSeqOrdem+
                               ' and SEQITE = '+ VpaSeqItem);
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqEstagioFracaoOpDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqFracao : Integer):Integer;
begin
  AdicionaSqlAbreTabela(OrdAux,'Select max(SEQESTAGIO) ULTIMO from FRACAOOPESTAGIOREAL '+
                               ' Where CODFILIAL = '+IntToStr(VpaFilial)+
                               ' and SEQORDEM = '+ IntToStr(VpaSeqOrdem)+
                               ' and SEQFRACAO = '+IntTostr(VpaSeqFracao));
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqColetaFracaoOPDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqEstagio : Integer):Integer;
begin
  AdicionaSqlAbreTabela(OrdAux,'Select MAX(SEQCOLETA) ULTIMO from COLETAFRACAOOP '+
                               ' Where CODFILIAL = '+IntToStr(VpaFilial)+
                               ' and SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                               ' and SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                               ' and SEQESTAGIO = '+IntToStr(VpaSeqEstagio));
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqColetaRomaneioOPDisponivel(VpaFilial,VpaSeqOrdem,VpaSeqFracao : Integer):Integer;
begin
  AdicionaSqlAbreTabela(OrdAux,'Select MAX(SEQCOLETA) ULTIMO from COLETAROMANEIOOP '+
                               ' Where CODFILIAL = '+IntToStr(VpaFilial)+
                               ' and SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                               ' and SEQFRACAO = '+IntToStr(VpaSeqFracao));
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqRomaneioProdutoDisponivel(VpaFilial,VpaSeqRomaneio : Integer):Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select max(SEQITEM) ULTIMO from ROMANEIOPRODUTO '+
                               ' Where CODFILIAL = '+IntToStr(VpaFilial)+
                               ' and SEQROMANEIO = '+IntToStr(VpaSeqRomaneio));
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqFracaoFaccionistaDisponivel(VpaCodFaccionista : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select MAX(SEQITEM) ULTIMO from FRACAOOPFACCIONISTA '+
                               ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista));
  result := OrdAux.FieldByName('ULTIMO').AsInteger + 1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqRetornoFracaoFaccionistaDisponivel(VpaCodFaccionista, VpaSeqItem : Integer):Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select MAX(SEQRETORNO) ULTIMO from RETORNOFRACAOOPFACCIONISTA '+
                               ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                               ' AND SEQITEM = ' +IntToStr(VpaSeqItem));
  result := OrdAux.FieldByname('ULTIMO').AsInteger + 1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqDevolucaoFracaoFaccionistaDisponivel(VpaCodFaccionista, VpaSeqItem : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select MAX(SEQDEVOLUCAO) ULTIMO from DEVOLUCAOFRACAOOPFACCIONISTA '+
                               ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                               ' AND SEQITEM = ' +IntToStr(VpaSeqItem));
  result := OrdAux.FieldByname('ULTIMO').AsInteger + 1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqOrdemCorteDisponivel(VpaCodFilial,VpaSeqOrdemProducao : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select MAX(SEQORDEMCORTE) ULTIMO FROM ORDEMCORTECORPO '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND SEQORDEMPRODUCAO = '+IntToStr(VpaSeqOrdemProducao));
  result := OrdAux.FieldByname('ULTIMO').AsInteger+1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqPlanoCorteDisponivel(VpaCodFilial : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select MAX(SEQPLANOCORTE) ULTIMO  from PLANOCORTECORPO '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := OrdAux.FieldByname('ULTIMO').AsInteger + 1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RSeqImpressaoDisponivel : Integer;
begin
  AdicionaSqlAbreTabela(OrdAux,'Select MAX(SEQIMPRESSAO) ULTIMO from IMPRESSAOCONSUMOFRACAO ');
  result := OrdAux.FieldByName('ULTIMO').AsInteger +1;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDOrdemProducaoBasicao(VpaDOrdem : TRBDOrdemProducao) :String;
begin
  result := '';
  LocalizaOrdemProducao(OrdCadastro,IntToStr(VpaDOrdem.CodEmpresafilial),IntToStr(VpaDOrdem.SeqOrdem));
  if VpaDOrdem.SeqOrdem = 0 then
    OrdCadastro.Insert
  else
  begin
    if OrdCadastro.Eof then
      result :=  'ORDEM DE PRODUÇÃO NÃO ENCONTRADA!!!'#13'A ordem de produção "'+IntToStr(VpaDOrdem.SeqOrdem)+'" não foi encontrada.'
    else
      OrdCadastro.edit;
  end;
  if result = '' then
  begin
    CarDOPBasicaTabela(VpaDOrdem,OrdCadastro);
    OrdCadastro.Post;
    result := OrdCadastro.AMensagemErroGravacao;
    OrdCadastro.close;
  end;
  if result = '' then
  begin
    result := GravaDFracoesOP(VpaDOrdem);
    if result = '' then
    begin
      result := GravaDFracaoOPEstagio(VpaDOrdem);
      if result = '' then
      begin
        result := GravaDFracaoOPCompose(VpaDOrdem);
        if result = '' then
        begin
{            VpaDOrdem.OrdemCorte.CodFilial := VpaDOrdem.CodEmpresafilial;
          VpaDOrdem.OrdemCorte.SeqOrdemProducao := VpaDOrdem.SeqOrdem;
          result := GravaDOrdemCorte(VpaDOrdem.OrdemCorte);}
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaOrdemProducao(VpaDOrdem : TRBDOrdemProducaoEtiqueta):String;
begin
  result := '';
  LocalizaOrdemProducao(OrdCadastro,IntToStr(VpaDOrdem.CodEmpresafilial),IntToStr(VpaDOrdem.SeqOrdem));
  if VpaDOrdem.SeqOrdem = 0 then
    OrdCadastro.Insert
  else
  begin
    if OrdCadastro.Eof then
      result :=  'ORDEM DE PRODUÇÃO NÃO ENCONTRADA!!!'#13'A ordem de produção "'+IntToStr(VpaDOrdem.SeqOrdem)+'" não foi encontrada.'
    else
      OrdCadastro.edit;
  end;
  if result = '' then
  begin
    CarDOPBasicaTabela(VpaDOrdem,OrdCadastro);
    if VpaDOrdem.CodCliente <> 0 then
      OrdCadastro.FieldByName('CODCLI').AsInteger := VpaDOrdem.CodCliente
    else
      OrdCadastro.FieldByName('CODCLI').Clear;
    if VpaDOrdem.NroOPCliente <> 0 then
      OrdCadastro.FieldByName('ORDCLI').AsInteger := VpaDOrdem.NroOPCliente
    else
      OrdCadastro.FieldByName('ORDCLI').Clear;
    if VpaDOrdem.CodMotivoReprogramacao <> 0 then
      OrdCadastro.FieldByName('CODMOT').AsInteger := VpaDOrdem.CodMotivoReprogramacao
    else
      OrdCadastro.FieldByName('CODMOT').Clear;
    if VpaDOrdem.CodMaquina <> 0 then
      OrdCadastro.FieldByName('CODMAQ').AsInteger := VpaDOrdem.CodMaquina
    else
      OrdCadastro.FieldByName('CODMAQ').clear;
    if VpaDOrdem.CodTipoCorte <> 0 then
      OrdCadastro.FieldByName('CODCRT').AsInteger := VpaDOrdem.CodTipoCorte
    else
      OrdCadastro.FieldByName('CODCRT').clear;
    OrdCadastro.FieldByName('TIPPED').AsInteger := VpaDOrdem.TipPedido;
    OrdCadastro.FieldByName('TIPTEA').AsInteger := VpaDOrdem.TipTear;
    OrdCadastro.FieldByName('QTDFIT').AsFloat := VpaDOrdem.QtdFita;
    OrdCadastro.FieldByName('METTOT').AsFloat := VpaDOrdem.TotMetros;
    OrdCadastro.FieldByName('METFIT').AsFloat := VpaDOrdem.MetFita;
    OrdCadastro.FieldByName('PERACR').AsFloat := VpaDOrdem.PerAcrescimo;
    OrdCadastro.FieldByName('INDPNO').AsString := VpaDOrdem.IndProdutoNovo;

    if VpaDOrdem.SeqOrdem = 0 then
      VpaDOrdem.SeqOrdem := RSeqOrdemDisponivel(IntToStr(VpaDOrdem.CodEmpresafilial));

    OrdCadastro.Post;
    result := OrdCadastro.AMensagemErroGravacao;
    if result = '' then
    begin
      if config.CadastroCadarco then
      begin
        result := GravaDOPItemCadarco(VpaDOrdem);
        if result = '' then
          result := GravaDOpItemMaquina(VpaDOrdem);
      end
      else
        result := GravaOrdemProducaoItem(VpaDOrdem);
    end;
    OrdCadastro.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDOrdemCorte(VpaDOrdemCorte : TRBDOrdemCorte) : string;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from ORDEMCORTEITEM'+
                             ' Where CODFILIAL = '+IntToStr(VpaDOrdemCorte.CodFilial)+
                             ' and SEQORDEMPRODUCAO = '+IntTostr(VpaDOrdemCorte.SeqOrdemProducao));
  ExecutaComandoSql(OrdAux,'Delete from ORDEMCORTECORPO'+
                             ' Where CODFILIAL = '+IntToStr(VpaDOrdemCorte.CodFilial)+
                             ' and SEQORDEMPRODUCAO = '+IntTostr(VpaDOrdemCorte.SeqOrdemProducao));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ORDEMCORTECORPO '+
                                    ' WHERE CODFILIAL = 0 AND SEQORDEMPRODUCAO = 0 AND SEQORDEMCORTE = 0');
  OrdCadastro.insert;
  OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDOrdemCorte.CodFilial;
  OrdCadastro.FieldByname('SEQORDEMPRODUCAO').AsInteger := VpaDOrdemCorte.SeqOrdemProducao;
  OrdCadastro.FieldByname('QTDFRACAO').AsInteger := VpaDOrdemCorte.QtdFracao;
  OrdCadastro.FieldByname('QTDPRODUTO').AsFloat := VpaDOrdemCorte.QtdProduto;
  if VpaDOrdemCorte.SeqCorte = 0 then
    VpaDOrdemCorte.SeqCorte := RSeqOrdemCorteDisponivel(VpaDOrdemCorte.CodFilial,VpaDOrdemCorte.SeqOrdemProducao);
  OrdCadastro.FieldByname('SEQORDEMCORTE').AsInteger := VpaDOrdemCorte.SeqCorte;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
    result := GravaDOrdemCorteItem(VpaDOrdemCorte);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDColetaOP(VpaDColetaOP : TRBDColetaOP):String;
begin
  result := '';
  LocalizaColetaOP(OrdCadastro,IntToStr(VpaDColetaOP.CodEmpresafilial),IntToStr(VpaDColetaOP.SeqOrdemProducao),IntToStr(VpaDColetaOp.SeqColeta));
  if VpaDColetaOP.SeqColeta = 0 then
    OrdCadastro.Insert
  else
  begin
    if OrdCadastro.Eof then
      result :=  'COLETA ORDEM DE PRODUÇÃO NÃO ENCONTRADA!!!'#13'A coleta "'+IntToStr(VpaDColetaOP.SeqColeta)+'" da ordem de produção "'+IntToStr(VpaDColetaOP.SeqOrdemProducao)+'" não foi encontrada.'
    else
      OrdCadastro.edit;
  end;
  if result = '' then
  begin
    OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaDColetaOP.CodEmpresaFilial;
    OrdCadastro.FieldByName('SEQORD').AsInteger := VpaDColetaOP.SeqOrdemProducao;
    OrdCadastro.FieldByName('DATCOL').AsDateTime := VpaDColetaOP.DatColeta;
    OrdCadastro.FieldByName('CODUSU').AsInteger := VpaDColetaOP.CodUsuario;
    OrdCadastro.FieldByName('QTDTOT').AsFloat := VpaDColetaOP.QtdTotalColetado;
    if VpaDColetaOP.IndFinal then
      OrdCadastro.FieldByName('INDFIN').AsString := 'S'
    else
      OrdCadastro.FieldByName('INDFIN').AsString := 'N';

    if VpaDColetaOP.IndReprogramacao then
      OrdCadastro.FieldByName('INDREP').AsString := 'S'
    else
      OrdCadastro.FieldByName('INDREP').AsString := 'N';

    if VpaDColetaOP.IndGeradoRomaneio then
      OrdCadastro.FieldByName('INDROM').AsString := 'S'
    else
      OrdCadastro.FieldByName('INDROM').AsString := 'N';

    if VpaDColetaOP.SeqColeta = 0 then
      VpaDColetaOP.SeqColeta := RSeqColetaOPDisponivel(IntToStr(VpaDColetaOP.CodEmpresafilial),IntToStr(VpaDColetaOP.SeqOrdemProducao));


    OrdCadastro.FieldByName('SEQCOL').AsInteger := VpaDColetaOP.SeqColeta;
    OrdCadastro.Post;
    result := OrdCadastro.AMensagemErroGravacao;
    if result = '' then
    begin
      result := GravaDColetaOPItem(VpaDColetaOP);
      if result = '' then
        result := AtualizaDColetadosOP(VpaDColetaOP);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDRevisaoExternaOP(VpaDColetaOP : TRBDColetaOP;VpaCodUsuario : Integer):String;
begin
  result := '';
  LocalizaRevisaoExternaOP(OrdCadastro,IntToStr(VpaDColetaOP.CodEmpresaFilial),IntToStr(VpaDColetaOP.SeqOrdemProducao),IntToStr(VpaDColetaOP.SeqColeta));
  if not OrdCadastro.Eof then
  begin
    if not Confirmacao('REVISÃO EXTERNA DUPLICADA!!!'#13'Essa coleta já foi enviada para a revisão externa no usuário "'+Sistema.RNomUsuario(OrdCadastro.FieldByName('CODUSU').AsInteger)+'".'
                       +#13+'Deseja continuar?') then
      result := 'Revisão externa duplicada.';
  end;
  if result = '' then
  begin
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaDColetaOP.CodEmpresaFilial;
    OrdCadastro.FieldByName('SEQORD').AsInteger := VpaDColetaOP.SeqOrdemProducao;
    OrdCadastro.FieldByName('SEQCOL').AsInteger := VpaDColetaOP.SeqColeta;
    OrdCadastro.FieldByName('CODUSU').AsInteger := VpaCodUsuario;
    OrdCadastro.FieldByName('DATREV').AsDateTime := Date;
    OrdCadastro.Post;
    result := OrdCadastro.AMensagemErroGravacao;
  end;
  OrdCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDEstagioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho) : String;
Var
  VpfLaco : Integer;
  VpfDEstagio : TRBDEstagioCelula;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from ESTAGIOCELULATRABALHO '+
                           ' where CODCELULA = '+IntToStr(VpaDCelula.CodCelula));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ESTAGIOCELULATRABALHO ');
  for VpfLaco := 0 to VpaDCelula.Estagios.Count - 1 do
  begin
    VpfDEstagio := TRBDEstagioCelula(VpaDCelula.Estagios.Items[VpfLaco]);
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('CODCELULA').AsInteger := VpaDCelula.CodCelula;
    OrdCadastro.FieldByName('CODESTAGIO').AsInteger := VpfDEstagio.CodEstagio;
    OrdCadastro.FieldByName('VALPRODUTIVIDADE').AsInteger := VpfDEstagio.ValCapacidadeProdutiva;
    if VpfDEstagio.IndPrincipal then
      OrdCadastro.FieldByName('INDPRINCIPAL').AsString := 'S'
    else
      OrdCadastro.FieldByName('INDPRINCIPAL').AsString := 'N';

    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDHorarioCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho) : String;
Var
  VpfDHorario : TRBDHorarioCelula;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(OrdAux,'Delete from HORARIOCELULATRABALHO '+
                           ' where CODCELULA = '+IntToStr(VpaDCelula.CodCelula));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from HORARIOCELULATRABALHO ');
  for VpfLaco := 0 to VpaDCelula.Horarios.Count - 1 do
  begin
    VpfDHorario := TRBDHorarioCelula(VpaDCelula.Horarios.Items[VpfLaco]);
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('CODCELULA').AsInteger := VpaDCelula.CodCelula;
    OrdCadastro.FieldByName('CODHORARIO').AsInteger := VpfDHorario.CodHorario;
    OrdCadastro.post;
    result := OrdCadastro.AMensagemErroGravacao;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDColetaFracaoOP(VpaDColetaFracao : TRBDColetaFracaoOp) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from COLETAFRACAOOP '+
                                    ' Where CODFILIAL = 0 AND SEQORDEM = 0 AND SEQFRACAO = 0 AND SEQCOLETA = 0 ');
  OrdCadastro.Insert;
  OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDColetaFracao.CodFilial;
  OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaDColetaFracao.NumOrdemProducao;
  OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDColetaFracao.SeqFracao;
  OrdCadastro.FieldByName('SEQESTAGIO').AsInteger := VpaDColetaFracao.SeqEstagio;
  OrdCadastro.FieldByName('CODUSUARIO').AsInteger := VpaDColetaFracao.CodUsuario;
  OrdCadastro.FieldByName('CODCELULA').AsInteger := VpaDColetaFracao.CodCelula;
  OrdCadastro.FieldByName('DESUM').AsString := VpaDColetaFracao.DesUM;
  OrdCadastro.FieldByName('QTDCOLETADO').AsFloat := VpaDColetaFracao.QtdColetado;
  OrdCadastro.FieldByName('QTDDEFEITO').AsFloat := VpaDColetaFracao.QtdDefeito;
  OrdCadastro.FieldByName('QTDPRODUCAOHORA').AsFloat := VpaDColetaFracao.QtdProducaoHora;
  OrdCadastro.FieldByName('QTDPRODUCAOIDEAL').AsFloat := VpaDColetaFracao.QtdProducaoIdeal;
  OrdCadastro.FieldByName('PERPRODUTIVIDADE').AsInteger := VpaDColetaFracao.PerProdutividade;
  OrdCadastro.FieldByName('QTDMINUTOS').AsInteger := VpaDColetaFracao.QtdMinutos;
  OrdCadastro.FieldByName('DATINICIO').AsDateTime := VpaDColetaFracao.DatInicio;
  OrdCadastro.FieldByName('DATFIM').AsDateTime := VpaDColetaFracao.DatFim;

  OrdCadastro.FieldByName('SEQCOLETA').AsInteger := RSeqColetaFracaoOPDisponivel(VpaDColetaFracao.CodFilial,VpaDColetaFracao.NumOrdemProducao,VpaDColetaFracao.SeqFracao,VpaDColetaFracao.SeqEstagio);
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  ProcessaProdutividadeCelula(VpaDColetaFracao.CodCelula,VpaDColetaFracao.DatInicio);
  BaixaQtdFracaoOPEstagio(VpaDColetaFracao.CodFilial,VpaDColetaFracao.NumOrdemProducao,VpaDColetaFracao.SeqFracao,VpaDColetaFracao.SeqEstagio,VpaDColetaFracao.QtdColetado,false);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDColetaRomaneioOP(VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from COLETAROMANEIOOP');
  OrdCadastro.Insert;
  OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDColetaRomaneio.CodFilial;
  OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaDColetaRomaneio.NumOrdemProducao;
  OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDColetaRomaneio.SeqFracao;
  OrdCadastro.FieldByName('CODUSUARIO').AsInteger := VpaDColetaRomaneio.CodUsuario;
  OrdCadastro.FieldByName('DESUM').AsString := VpaDColetaRomaneio.DesUM;
  OrdCadastro.FieldByName('QTDCOLETADO').AsFloat := VpaDColetaRomaneio.QtdColetado;
  OrdCadastro.FieldByName('DATCOLETA').AsDateTime := VpaDColetaRomaneio.DatColeta;

  VpaDColetaRomaneio.SeqColeta := RSeqColetaRomaneioOPDisponivel(VpaDColetaRomaneio.CodFilial,VpaDColetaRomaneio.NumOrdemProducao,VpaDColetaRomaneio.SeqFracao);
  OrdCadastro.FieldByName('SEQCOLETA').AsInteger := VpaDColetaRomaneio.SeqColeta;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
  begin
    result := AdicionaQtdAFaturarFracao(VpaDColetaRomaneio,VpaDOrdemProducao,false);
    if result = '' then
      result := AdicionaColetaFracaoOpRomaneio(VpaDColetaRomaneio,VpaDOrdemProducao);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDFracaoFaccionista(VpaDFracaoFaccionista : TRBDFracaoFaccionista) : string;
var
  VpfDEstagioOP : TRBDEstagioFracaoOPReal;
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = 0 AND SEQITEM = 0');
  OrdCadastro.insert;
  OrdCadastro.FieldByName('CODFACCIONISTA').AsInteger := VpaDFracaoFaccionista.CodFaccionista;
  OrdCadastro.FieldByName('CODFILIAL').AsInteger := VpaDFracaoFaccionista.CodFilial;
  OrdCadastro.FieldByName('SEQORDEM').AsInteger := VpaDFracaoFaccionista.SeqOrdem;
  OrdCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDFracaoFaccionista.SeqFracao;
  if VpaDFracaoFaccionista.SeqIDEstagio <> 0 then
    OrdCadastro.FieldByName('SEQESTAGIO').AsInteger := VpaDFracaoFaccionista.SeqIDEstagio
  else
    OrdCadastro.FieldByName('SEQESTAGIO').Clear;
  OrdCadastro.FieldByName('CODUSUARIO').AsInteger := VpaDFracaoFaccionista.CodUsuario;
  OrdCadastro.FieldByName('QTDENVIADO').AsFloat := VpaDFracaoFaccionista.QtdEnviado;
  OrdCadastro.FieldByName('VALUNITARIO').AsFloat := VpaDFracaoFaccionista.ValUnitario;
  OrdCadastro.FieldByName('VALUNITARIOPOSTERIOR').AsFloat := VpaDFracaoFaccionista.ValUnitarioPosterior;
  if VpaDFracaoFaccionista.ValTaxaEntrega <> 0 then
    OrdCadastro.FieldByName('VALENTREGA').AsFloat := VpaDFracaoFaccionista.ValTaxaEntrega;
  OrdCadastro.FieldByName('DESUM').AsString := VpaDFracaoFaccionista.DesUM;
  OrdCadastro.FieldByName('DATCADASTRO').AsDateTime := VpaDFracaoFaccionista.DatCadastro;
  OrdCadastro.FieldByName('DATRETORNO').AsDatetime := VpaDFracaoFaccionista.DatRetorno;
  OrdCadastro.FieldByName('DATRENEGOCIADO').AsDatetime := VpaDFracaoFaccionista.DatRetorno;
  if VpaDFracaoFaccionista.IndDefeito then
    OrdCadastro.FieldByName('INDDEFEITO').AsString := 'S'
  else
    OrdCadastro.FieldByName('INDDEFEITO').AsString := 'N';
  OrdCadastro.FieldByName('SEQITEM').AsInteger := RSeqFracaoFaccionistaDisponivel(VpaDFracaoFaccionista.CodFaccionista);
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
  begin
    result := AtualizaDFracoesEnviadasFaccionista(VpaDFracaoFaccionista);
    if result = '' then
    begin
      if Varia.EstagioEnviadoFaccionista <> 0 then
      begin
        VpfDEstagioOP := TRBDEstagioFracaoOPReal.cria;
        VpfDEstagioOP.CodFilial := VpaDFracaoFaccionista.CodFilial;
        VpfDEstagioOP.SeqOrdem := VpaDFracaoFaccionista.SeqOrdem;
        VpfDEstagioOP.SeqFracao := VpaDFracaoFaccionista.SeqFracao;
        VpfDEstagioOP.CodEstagio := varia.EstagioEnviadoFaccionista;
        VpfDEstagioOP.CodUsuario := varia.CodigoUsuario;
        VpfDEstagioOP.CodUsuarioLogado := Varia.CodigoUsuario;
        result := AlteraEstagioFracaoOP(VpfDEstagioOP);
        VpfDEstagioOP.Free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDRetornoFracaoFaccionista(VpaDRetornoFracao : TRBDRetornoFracaoFaccionista):string;
var
  VpfDEstagioOP : TRBDEstagioFracaoOPReal;
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from RETORNOFRACAOOPFACCIONISTA'+
                                    ' Where CODFACCIONISTA = 0 AND SEQITEM = 0 AND SEQRETORNO = 0');
  OrdCadastro.insert;
  OrdCadastro.FieldByname('CODFACCIONISTA').AsInteger := VpaDRetornoFracao.CodFaccionista;
  OrdCadastro.FieldByname('SEQITEM').AsInteger := VpaDRetornoFracao.SeqItem;
  OrdCadastro.FieldByname('QTDRETORNO').AsFloat := VpaDRetornoFracao.QtdRetorno;
  OrdCadastro.FieldByname('VALUNITARIO').AsFloat := VpaDRetornoFracao.ValUnitario;
  OrdCadastro.FieldByname('DATCADASTRO').AsDateTime  := VpaDRetornoFracao.DatCadastro;
  OrdCadastro.FieldByname('CODUSUARIO').AsInteger := VpaDRetornoFracao.CodUsuario;
  OrdCadastro.FieldByname('INDREVISADO').AsString := 'N';
  if VpaDRetornoFracao.IndFinalizar then
    OrdCadastro.FieldByname('INDFINALIZARFRACAO').AsString := 'S'
  else
    OrdCadastro.FieldByname('INDFINALIZARFRACAO').AsString := 'N';
  if VpaDRetornoFracao.IndValorMenor then
    OrdCadastro.FieldByname('INDVALORMENOR').AsString := 'S'
  else
    OrdCadastro.FieldByname('INDVALORMENOR').AsString := 'N';
  VpaDRetornoFracao.SEqRetorno := RSeqRetornoFracaoFaccionistaDisponivel(VpaDRetornoFracao.CodFaccionista,VpaDRetornoFracao.SeqItem);
  OrdCadastro.FieldByname('SEQRETORNO').AsInteger := VpaDRetornoFracao.SEqRetorno;
  OrdCadastro.Post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
  begin
    AtualizaDFracaoOpFaccionista(VpaDRetornoFracao);
    if result = '' then
    begin
      if Varia.EstagioEnviadoFaccionista <> 0 then
      begin
        VpfDEstagioOP := TRBDEstagioFracaoOPReal.cria;
        VpfDEstagioOP.CodFilial := VpaDRetornoFracao.CodFilial;
        VpfDEstagioOP.SeqOrdem := VpaDRetornoFracao.SeqOrdem;
        VpfDEstagioOP.SeqFracao := VpaDRetornoFracao.SeqFracao;
        VpfDEstagioOP.CodEstagio := varia.EstagioRetornoFaccionista;
        VpfDEstagioOP.CodUsuario := varia.CodigoUsuario;
        VpfDEstagioOP.CodUsuarioLogado := Varia.CodigoUsuario;
        result := AlteraEstagioFracaoOP(VpfDEstagioOP);
        VpfDEstagioOP.Free;
      end;
    end;
  end;

end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDDevolucaoFracaoFaccionista(VpaDDevolucaoFracao : TRBDDevolucaoFracaoFaccionista) : string;
var
  VpfDEstagioOP : TRBDEstagioFracaoOPReal;
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from DEVOLUCAOFRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = 0 AND SEQITEM = 0 AND SEQDEVOLUCAO = 0 ');
  OrdCadastro.insert;
  OrdCadastro.FieldByname('CODFACCIONISTA').AsInteger := VpaDDevolucaoFracao.CodFaccionista;
  OrdCadastro.FieldByname('SEQITEM').AsInteger := VpaDDevolucaoFracao.SeqItem;
  OrdCadastro.FieldByname('QTDDEVOLVIDO').AsFloat := VpaDDevolucaoFracao.QtdDevolvido;
  OrdCadastro.FieldByname('DATCADASTRO').AsDateTime  := VpaDDevolucaoFracao.DatCadastro;
  OrdCadastro.FieldByname('CODUSUARIO').AsInteger := VpaDDevolucaoFracao.CodUsuario;
  OrdCadastro.FieldByname('CODMOTIVO').AsInteger := VpaDDevolucaoFracao.CodMotivo;
  OrdCadastro.FieldByname('DESMOTIVO').AsString := VpaDDevolucaoFracao.DesMotivo;
  VpaDDevolucaoFracao.SeqDevolucao := RSeqDevolucaoFracaoFaccionistaDisponivel(VpaDDevolucaoFracao.CodFaccionista,VpaDDevolucaoFracao.SeqItem);
  OrdCadastro.FieldByname('SEQDEVOLUCAO').AsInteger := VpaDDevolucaoFracao.SeqDevolucao;
  OrdCadastro.Post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
  begin
    AtulaizaDevolucaFracaoFaccionista(VpaDDevolucaoFracao);
    if result = '' then
    begin
      if Varia.EstagioEnviadoFaccionista <> 0 then
      begin
        VpfDEstagioOP := TRBDEstagioFracaoOPReal.cria;
        VpfDEstagioOP.CodFilial := VpaDDevolucaoFracao.CodFilial;
        VpfDEstagioOP.SeqOrdem := VpaDDevolucaoFracao.SeqOrdem;
        VpfDEstagioOP.SeqFracao := VpaDDevolucaoFracao.SeqFracao;
        VpfDEstagioOP.CodEstagio := varia.EstagioRetornoFaccionista;
        VpfDEstagioOP.CodUsuario := varia.CodigoUsuario;
        VpfDEstagioOP.CodUsuarioLogado := Varia.CodigoUsuario;
        result := AlteraEstagioFracaoOP(VpfDEstagioOP);
        VpfDEstagioOP.Free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDRevisaoFracaoFaccionista(VpaDRevisaoFracao : TRBDRevisaoFracaoFaccionista) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from RETORNOFRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaDRevisaoFracao.CodFaccionista)+
                                    ' AND SEQITEM = '+IntToStr(VpaDRevisaoFracao.SeqItem)+
                                    ' AND SEQRETORNO = '+IntToStr(VpaDRevisaoFracao.SEqRetorno));
  OrdCadastro.edit;
  OrdCadastro.FieldByname('QTDREVISADO').AsFloat := VpaDRevisaoFracao.QtdRevisado;
  OrdCadastro.FieldByname('QTDDEFEITO').AsFloat := VpaDRevisaoFracao.QtdDefeito;
  OrdCadastro.FieldByname('DATREVISADO').AsDateTime := VpaDRevisaoFracao.DatRevisao;
  OrdCadastro.FieldByname('INDREVISADO').AsString := 'S';
  OrdCadastro.FieldByname('CODUSUARIOREVISAO').AsFloat := VpaDRevisaoFracao.CodUsuario;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaConsumoOP(VpaDOrdemProducao : TRBDordemProducao):String;
begin
  if varia.TipoOrdemProducao = toAgrupada then
    result := GravaDConsumoOPAgrupada(VpaDOrdemProducao)
  else
    result := GravaDConsumoFracoes(VpaDOrdemProducao);

  if result = '' then
  begin
    result := GravaDOrdemSerra(VpaDOrdemProducao);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GravaDPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from PLANOCORTECORPO '+
                                    ' Where CODFILIAL = '+IntToStr(VpaDPlanoCorte.CodFilial)+
                                    ' and SEQPLANOCORTE = '+IntToStr(VpaDPlanoCorte.SeqPlanoCorte));
  if OrdCadastro.Eof then
    OrdCadastro.Insert
  else
    OrdCadastro.Edit;
  OrdCadastro.FieldByname('CODFILIAL').AsInteger := VpaDPlanoCorte.CodFilial;
  if VpaDPlanoCorte.SeqMateriaPrima <> 0 then
    OrdCadastro.FieldByname('SEQMATERIAPRIMA').AsInteger := VpaDPlanoCorte.SeqMateriaPrima
  else
    OrdCadastro.FieldByname('SEQMATERIAPRIMA').clear;
  OrdCadastro.FieldByname('DATEMISSAO').AsDateTime := VpaDPlanoCorte.DatEmissao;
  OrdCadastro.FieldByname('NUMCNC').AsInteger := VpaDPlanoCorte.NumCNC;
  OrdCadastro.FieldByname('CODUSUARIO').AsInteger := VpaDPlanoCorte.CodUsuario;
  if VpaDPlanoCorte.SeqPlanoCorte = 0 then
    VpaDPlanoCorte.SeqPlanoCorte := RSeqPlanoCorteDisponivel(VpaDPlanoCorte.CodFilial);
  OrdCadastro.FieldByname('SEQPLANOCORTE').AsInteger := VpaDPlanoCorte.SeqPlanoCorte;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
  if result = '' then
  begin
    Result := GravaDPlanoCorteItem(VpaDPlanoCorte);
    if result = '' then
      Result := GravaDPlanoCorteFracao(VpaDPlanoCorte);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.GeraOrdemCorte(VpaDOrdemProducao : TRBDOrdemProducao):string;
begin
  result := '';
  if (Varia.TipoOrdemProducao = toFracionada) then
  begin
    VpaDOrdemProducao.OrdemCorte.free;
    VpaDOrdemProducao.OrdemCorte := GeraOrdemCortedaOP(VpaDOrdemProducao);
    GeraOrdemCorteItemdaOP(VpaDOrdemProducao.OrdemCorte,VpaDOrdemProducao);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AlteraEstagio(VpaDOrdem : TRBDOrdemProducaoEtiqueta):String;
begin
  result := '';
  LocalizaOrdemProducao(OrdCadastro,IntToStr(VpaDOrdem.CodEmpresafilial),IntToStr(VpaDOrdem.SeqOrdem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('CODEST').AsInteger := VpaDOrdem.CodEstagio;
  OrdCadastro.Post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AlteraCliente(VpaCodFilial,VpaSeqOrdem, VpaCodCliente : Integer):string;
begin
  result := '';
  LocalizaOrdemProducao(OrdCadastro,IntToStr(VpaCodFilial),IntToStr(VpaSeqOrdem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('CODCLI').AsInteger := VpaCodCliente;
  OrdCadastro.Post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AlteraMaquina(VpaDOrdem : TRBDOrdemProducaoEtiqueta) : String;
begin
  result := '';
  try
    ExecutaComandoSql(OrdAux,'update ORDEMPRODUCAOCORPO '+
                             ' Set CODMAQ = '+ IntToStr(VpaDOrdem.CodMaquina)+
                             ' Where EMPFIL = '+ IntToStr(VpaDOrdem.CodEmpresafilial)+
                             ' and SEQORD = '+ IntToStr(VpaDOrdem.SeqOrdem));
  except
    on e : exception do result := 'ERRO NA ALTERAÇÃO DA MÁQUINA!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AlteraValorUnitario(VpaDOrdem : TRBDOrdemProducaoEtiqueta) : String;
begin
  result := '';
  LocalizaOrdemProducao(OrdCadastro,IntToStr(VpaDOrdem.CodEmpresafilial),IntToStr(VpaDOrdem.SeqOrdem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('VALUNI').AsFloat := VpaDOrdem.ValUnitario;
  OrdCadastro.Post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDFracaoOpAgrupada(VpaDFracao :TRBDFracaoOrdemProducao;VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer);
begin
  AdicionaSQLAbreTabela(OrdTabela,'Select FRA.SEQFRACAO, FRA.QTDCELULA, FRA.DESHORAS, FRA.QTDPRODUTO, ' +
                                  ' FRA.CODESTAGIO, FRA.DATENTREGA, FRA.DATIMPRESSAOFICHA, FRA.DESUM, '+
                                  ' FRA.SEQPRODUTO, FRA.DESUM, FRA.CODCOR, FRA.INDPLANOCORTE, '+
                                  ' PRO.C_NOM_PRO, PRO.C_COD_PRO, '+
                                  ' from FRACAOOP FRA, CADPRODUTOS PRO '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' and FRA.SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                                  ' and FRA.SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                                  ' and FRA.SEQPRODUTO = PRO.I_SEQ_PRO ');
  VpaDFracao.SeqFracao := OrdTabela.FieldByName('SEQFRACAO').AsInteger;
  VpaDFracao.QtdCelula := OrdTabela.FieldByName('QTDCELULA').AsInteger;
  VpaDFracao.HorProducao := OrdTabela.FieldByName('DESHORAS').AsString;
  VpaDFracao.QtdProduto :=  OrdTabela.FieldByName('QTDPRODUTO').AsFloat;
  VpaDFracao.CodEstagio :=  OrdTabela.FieldByName('CODESTAGIO').AsInteger;
  VpaDFracao.DatEntrega := OrdTabela.FieldByName('DATENTREGA').AsDateTime;
  VpaDFracao.DatImpressaoFicha := OrdTabela.FieldByName('DATIMPRESSAOFICHA').AsDateTime;
  VpaDFracao.SeqProduto := OrdTabela.FieldByname('SEQPRODUTO').AsInteger;
  VpaDFracao.CodCor := OrdTabela.FieldByname('CODCOR').AsInteger;
  VpaDFracao.UM := OrdTabela.FieldByname('DESUM').AsString;
  VpaDFracao.IndPlanoCorte := OrdTabela.FieldByname('INDPLANOCORTE').AsString = 'S';

  VpADFracao.IndEstagioGerado := true;
  Ordtabela.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.CarDOrdemProducaoBasica(VpaCodfilial,VpaSeqOrdem : Integer; VpaDOrdem : TRBDOrdemProducao) : boolean;
begin
  result := false;
  FreeTObjectsList(VpaDOrdem.Fracoes);
  FreeTObjectsList(VpaDOrdem.Estagios);
  VpaDOrdem.CodEmpresafilial := VpaCodfilial;
  VpaDOrdem.SeqOrdem := VpaSeqOrdem;
  LocalizaOrdemProducao(OrdTabela,IntToStr(VpaDOrdem.CodEmpresafilial),IntToStr(VpaDOrdem.SeqOrdem));
  if not OrdTabela.Eof then
  begin
    result := true;
    CarDOPBasicaClasse(VpaDOrdem,OrdTabela);
    //02/09/2009 adicionado para carregar as fraçoes quando o tipo for submontagem porque quando alterava o estagio do produto náo estava recalculando  e estava apagando as frações;
    if varia.TipoOrdemProducao in [toAgrupada,toFracionada,toSubMontagem] then
    begin
      CarDFracaoOP(VpaDOrdem,VpaDOrdem.CodEmpresafilial,VpaDOrdem.SeqOrdem,0);
      CarDFracaoOPEstagio(VpaDOrdem);
    end;
  end;
  OrdTabela.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AlteraEstagioFracaoOP(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;
begin
  OrdOrdemProducao.Sql.clear;
  OrdOrdemProducao.SQL.add('Select * from FRACAOOP '+
                           ' Where CODFILIAL = '+IntToStr(VpaDEstagio.CodFilial)+
                           ' AND SEQORDEM = '+IntToStr(VpaDEstagio.SeqOrdem));
  OrdOrdemProducao.SQL.add(' and SEQFRACAO = '+IntToStr(VpaDEstagio.SeqFracao));
  OrdOrdemProducao.open;
  while (not OrdOrdemProducao.Eof) and (result = '') do
  begin
    VpaDEstagio.SeqFracao := OrdOrdemProducao.FieldByname('SEQFRACAO').AsInteger;
    result := GravaDFracaoOpEstagioReal(VpaDEstagio);
    if result = '' then
    begin
      AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOP '+
                               ' Where CODFILIAL = '+IntToStr(VpaDEstagio.CodFilial)+
                               ' and SEQORDEM = '+IntToStr(VpaDEstagio.SeqOrdem)+
                               ' and SEQFRACAO = '+IntToStr(OrdOrdemProducao.FieldByName('SEQFRACAO').AsInteger));
      OrdCadastro.Edit;
      OrdCadastro.FieldByName('CODESTAGIO').AsInteger := VpaDEstagio.CodEstagio;
      if VpaDEstagio.IndEstagioFinal then
        OrdCadastro.FieldByName('DATFINALIZACAO').AsDateTime := now
      else
        OrdCadastro.FieldByName('DATFINALIZACAO').Clear;
      OrdCadastro.Post;

      result := ConcluiEstagioFracao(VpaDEstagio);
      if result = '' then
        ConcluiEstagioRealFracao(VpaDEstagio);
    end;
    OrdOrdemProducao.next;
  end;
  OrdCadastro.close;
  OrdOrdemProducao.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AlteraEstagioFracaoOp(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer; VpaCodEstagio : Integer) :String;
var
  VpfDEstagio : TRBDEstagioFracaoOPReal;
begin
  VpfDEstagio := TRBDEstagioFracaoOPReal.cria;
  VpfDEstagio.CodFilial := VpaCodFilial;
  VpfDEstagio.SeqOrdem := VpaSeqOrdem;
  VpfDEstagio.SeqFracao := VpaSeqFracao;
  VpfDEstagio.CodEstagio := VpaCodEstagio;
  VpfDEstagio.CodUsuario := varia.CodigoUsuario;
  VpfDEstagio.CodUsuarioLogado := Varia.CodigoUsuario;
  VpfDEstagio.IndEstagioFinal := EstagioFinal(VpaCodEstagio);
  AlteraEstagioFracaoOP(VpfDEstagio);
  VpfDEstagio.free;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AlteraDataRenegociacaoFracaoFaccionista(VpaCodFaccionista, VpaSeqItem : Integer; VpaIndRenegociado : Boolean; VpaNovaData : TDAteTime):String;
var
  VpfNovaData : String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * ' +
                                  ' from FRACAOOPFACCIONISTA '+
                           ' Where CODFACCIONISTA = '+ IntToStr(VpaCodFaccionista)+
                           ' AND SEQITEM = ' +IntToStr(VpaSeqItem));
  OrdCadastro.Edit;
  OrdCadastro.FieldByname('QTDLIGACAO').AsInteger := OrdCadastro.FieldByname('QTDLIGACAO').AsInteger + 1;
  if VpaIndRenegociado then
  begin
    OrdCadastro.FieldByname('DATRENEGOCIADO').AsDateTime := VpaNovaData;
    OrdCadastro.FieldByname('QTDRENEGOCIACAO').AsInteger := OrdCadastro.FieldByname('QTDRENEGOCIACAO').AsInteger + 1;
  end;
  ordCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  Ordcadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AtteraDataEntregaFracao(VpaDFracao : TRBDFracaoOrdemProducao):string;
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOP '+
                                    ' Where CODFILIAL = '+IntToStr(VpaDFracao.CodFilial)+
                                    ' and SEQORDEM = '+IntToStr(VpaDFracao.SeqOrdemProducao)+
                                    ' and SEQFRACAO = ' +IntToStr(VpaDFracao.SeqFracao));
  OrdCadastro.edit;
  OrdCadastro.FieldByName('DATENTREGA').AsDateTime := VpaDFracao.DatEntrega;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ConcluiEstagioFracao(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;
begin
  result := '';
  OrdCadastro2.sql.clear;
  OrdCadastro2.sql.add('Select  * '+
                      ' from FRACAOOPESTAGIO '+
                      ' Where CODFILIAL = '+IntToStr(VpaDEstagio.CodFilial)+
                      ' AND SEQORDEM = '+IntToStr(VpaDEstagio.SeqOrdem)+
                      ' AND SEQFRACAO = '+IntToStr(VpaDEstagio.SeqFracao));
  if VpaDEstagio.SeqEstagio <> 0 then
    OrdCadastro2.sql.add(' AND SEQESTAGIO = '+IntToStr(VpaDEstagio.SeqEstagio))
  else
    OrdCadastro2.sql.add(' AND INDFINALIZADO = ''N''');

  if not VpaDEstagio.IndEstagioFinal then
    OrdCadastro2.sql.add(' AND CODESTAGIO = '+ IntToStr(VpaDEstagio.CodEstagioAtual));

  OrdCadastro2.sql.add(' ORDER BY SEQESTAGIO ');
  OrdCadastro2.open;
  while  not OrdCadastro2.eof do
  begin
    OrdCadastro2.Edit;
    OrdCadastro2.FieldByname('INDFINALIZADO').AsString := 'S';
    OrdCadastro2.post;
    result := OrdCadastro2.AMensagemErroGravacao;
    OrdCadastro2.next;
  end;
  OrdCadastro2.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ConcluiEstagioRealFracao(VpaDEstagio : TRBDEstagioFracaoOPReal) : String;
begin
  result := '';
  OrdCadastro2.sql.clear;
  OrdCadastro2.sql.add('Select  * '+
                      ' from FRACAOOPESTAGIOREAL '+
                      ' Where CODFILIAL = '+IntToStr(VpaDEstagio.CodFilial)+
                      ' AND SEQORDEM = '+IntToStr(VpaDEstagio.SeqOrdem)+
                      ' AND SEQFRACAO = '+IntToStr(VpaDEstagio.SeqFracao)+
                      ' AND INDFINALIZADO = ''N'''+
                      ' AND CODESTAGIO = '+ IntToStr(VpaDEstagio.CodEstagioAtual)+
                      ' ORDER BY SEQESTAGIO ');
  OrdCadastro2.open;
  if not OrdCadastro2.eof then
  begin
    OrdCadastro2.Edit;
    OrdCadastro2.FieldByname('INDFINALIZADO').AsString := 'S';
    OrdCadastro2.post;
    result := OrdCadastro2.AMensagemErroGravacao;
  end;
  OrdCadastro2.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.CarDOrdemProducao(VpaDOrdem : TRBDOrdemProducaoEtiqueta) : Boolean;
begin
  result := false;
  FreeTObjectsList(VpaDOrdem.Items);
  VpaDOrdem.Items.Clear;
  LocalizaOrdemProducao(OrdAux,IntToStr(VpaDOrdem.CodEmpresafilial),IntToStr(VpaDOrdem.SeqOrdem));
  if not OrdAux.Eof then
  begin
    result := true;
    with VpaDOrdem do
    begin
      CarDOPBasicaClasse(VpaDOrdem,OrdAux);

      if OrdAux.FieldByName('ORDCLI').AsString <> '' then
        NroOPCliente := OrdAux.FieldByName('ORDCLI').AsInteger;
      CodMotivoReprogramacao := OrdAux.FieldByName('CODMOT').AsInteger;
      CodTipoCorte := OrdAux.FieldByName('CODCRT').AsInteger;
      VpaDOrdem.CodMaquina := OrdAux.FieldByName('CODMAQ').AsInteger;
      VpaDOrdem.TipPedido := OrdAux.FieldByName('TIPPED').AsInteger;
      VpaDOrdem.TipTear := OrdAux.FieldByName('TIPTEA').AsInteger;
      VpaDOrdem.PerAcrescimo := OrdAux.FieldByName('PERACR').AsInteger;
      VpaDOrdem.MetFita := OrdAux.FieldByName('METFIT').AsFloat;
      VpaDOrdem.TotMetros := OrdAux.FieldByName('METTOT').AsFloat;
      VpaDOrdem.QtdFita := OrdAux.FieldByName('QTDFIT').AsInteger;
      VpaDOrdem.ValUnitario := OrdAux.FieldByName('VALUNI').AsFloat;
      VpaDOrdem.IndProdutoNovo := OrdAux.FieldByName('INDPNO').AsString;
    end;
    OrdAux.close;
    if config.CadastroCadarco then
      CarDOpItemCadarco(VpadOrdem)
    else
      CarDOrdemProducaoItem(VpaDOrdem);
  end;
  OrdAux.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDColetaOP(VpaDColetaOP : TRBDColetaOP);
begin
  FreeTObjectsList(VpaDColetaOP.ItensColeta);
  VpaDColetaOP.ItensColeta.Clear;
  LocalizaColetaOP(OrdAux,IntToStr(VpaDColetaOP.CodEmpresafilial),IntToStr(VpaDColetaOP.SeqOrdemProducao),IntTostr(VpadColetaOp.SeqColeta));
  if not OrdAux.Eof then
  begin
    with VpaDColetaOP do
    begin
      CodUsuario := OrdAux.FieldByName('CODUSU').AsInteger;
      DatColeta := OrdAux.FieldByName('DATCOL').AsDateTime;
      IndFinal := (OrdAux.FieldByName('INDFIN').AsString = 'S');
      IndReprogramacao := (OrdAux.FieldByName('INDREP').AsString = 'S');
      IndGeradoRomaneio := (OrdAux.FieldByName('INDROM').AsString = 'S');
      QtdTotalColetado := OrdAux.FieldByName('QTDTOT').AsFloat;
    end;
    OrdAux.close;
    CarDColetaOPItem(VpaDColetaOP);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDTecnicosCadarco(VpaDOp : TRBDOrdemProducaoEtiqueta; VpaDOPItem : TRBDOPItemCadarco);
begin
  CarTipoFundoCadarco(VpaDOPItem);

  AdicionaSQLAbreTabela(OrdAux,'Select * from CADPRODUTOS '+
                               ' Where I_SEQ_PRO = '+ IntToStr(VpaDOPItem.SeqProduto));
  VpaDOPItem.DesEngrenagem := OrdAux.FieldByName('ENGPRO').AsString;
  VpaDOPItem.Grossura := OrdAux.FieldByName('I_LRG_PRO').AsFloat;
  if VpaDOPItem.Grossura = 0 then
    CarGrossuraCadarco(VpaDOpItem);

  if OrdAux.FieldByName('C_NUM_FIO').AsString <> '' then
    VpaDOPItem.NroFios := OrdAux.FieldByName('C_NUM_FIO').AsInteger
  else
    VpaDOPItem.NroFios := 0;
  VpaDOPItem.MetMinuto := OrdAux.FieldByName('METMIN').AsFloat;

  FunProdutos.ConvUnidade.AMostrarMensagemErro := false;
  if VpaDOPItem.TitFios = '' then
    if OrdAux.FieldByName('C_TIT_FIO').AsString <> '' then
      VpaDOPItem.TitFios := OrdAux.FieldByName('C_TIT_FIO').AsString;

  if VpaDOPItem.QtdMetrosProduto = 0 then
  begin
    VpaDOPItem.QtdMetrosProduto := FunProdutos.CalculaQdadePadrao(VpaDOPItem.UM,'mt',VpaDOPItem.QtdProduto, IntToStr(VpaDOPItem.SeqProduto));
    if VpaDOPItem.QtdMetrosProduto = 0 then
      VpaDOPItem.QtdMetrosProduto :=(VpaDOPItem.QtdProduto * OrdAux.FieldByName('I_CMP_PRO').AsInteger)/100;
  end;
  VpaDOPItem.QtdFusos := OrdAux.FieldByName('I_QTD_FUS').AsInteger;
  VpaDOPItem.DesTecnica := OrdAux.FieldByName('L_DES_TEC').AsString;
  VpaDOPItem.DesEnchimento := OrdAux.FieldByName('C_DES_ENC').AsString;


  VpaDOPItem.MetporTabua := 0;
  case VpaDOp.TipPedido of
    0 : begin
          VpaDOPItem.MetporTabua := OrdAux.FieldByName('I_TAB_GRA').AsInteger; //espula grande
          VpaDOPItem.DesEngrenagem := OrdAux.FieldByName('ENGPRO').AsString;
        end;
    1 : begin
          VpaDOPItem.MetporTabua := OrdAux.FieldByName('I_TAB_PED').AsInteger; //espula pequena
          VpaDOPItem.DesEngrenagem := OrdAux.FieldByName('C_ENG_EPE').AsString;
        end;
    2 : begin
          VpaDOpItem.MetporTabua := OrdAux.FieldByName('I_TAB_TRA').AsInteger; //espula Transilin
          VpaDOPItem.DesEngrenagem := OrdAux.FieldByName('C_ENG_EPE').AsString;
        end;
  end;

  if VpaDOPItem.MetporTabua <> 0 then
      VpaDOPItem.NumTabuas := ArredondaDecimais(VpaDOPItem.QtdMetrosProduto / VpaDOPItem.MetporTabua,1);

  VpaDOPItem.NroMaquinas := RetornaInteiro(VpaDOPItem.NumTabuas);
  if not(DeleteAteChar(FormatFloat('0.0',VpaDOPItem.NumTabuas),',') = '0') then
    inc(VpaDOPItem.NroMaquinas);
  IF VpaDOPItem.NroMaquinas = 0 then
    VpaDOPItem.NroMaquinas := 1;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDCelulaTrabalho(VpaDCelula : TRBDCelulaTrabalho);
begin
  AdicionaSQLAbreTabela(OrdTabela,'Select * from CELULATRABALHO '+
                                  ' Where CODCELULA = '+IntToStr(VpaDCelula.CodCelula));
  VpaDCelula.NomCelula := OrdTabela.FieldByName('NOMCELULA').AsString;
  VpaDCelula.IndAtiva := UpperCase(OrdTabela.FieldByName('INDATIVA').AsString) = 'S';
  CarDEstagioCelulaTrabalho(VpaDCelula);
  CarDHorarioCelulaTrabalho(VpaDCelula);

  OrdTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDColetaRomaneioOP(VpaDColeta : TRBDColetaRomaneioOp;VpaCodFilial,VpaSeqOrdem, VpaSeqFracao,VpaSeqColeta : Integer);
begin
  AdicionaSQLAbreTabela(OrdAux,'Select * from COLETAROMANEIOOP '+
                               ' Where CODFILIAL = ' + IntToStr(VpaCodFilial)+
                               ' AND SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                               ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                               ' AND SEQCOLETA = '+IntToStr(VpaSeqColeta));
  VpaDColeta.CodFilial :=  VpaCodFilial;
  VpaDColeta.NumOrdemProducao := VpaSeqOrdem;
  VpaDColeta.SeqFracao := VpaSeqFracao;
  VpaDColeta.SeqColeta := VpaSeqColeta;
  VpaDColeta.DesUM := OrdAux.FieldByName('DESUM').AsString;
  VpaDColeta.QtdColetado := OrdAux.FieldByName('QTDCOLETADO').AsFloat;
  VpaDColeta.DatColeta := OrdAux.FieldByName('DATCOLETA').AsDateTime;
  OrdAux.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDConsumoFracao(VpaDFracao: TRBDFracaoOrdemProducao);
var
  VpfDConsumoOp : TRBDConsumoOrdemProducao;
begin
  AdicionaSQLAbreTabela(OrdTabela,'Select * from FRACAOOPCONSUMO '+
                           ' Where CODFILIAL = '+IntToStr(VpaDFracao.CodFilial)+
                           ' and SEQORDEM = '+ IntToStr(VpaDFracao.SeqOrdemProducao)+
                           ' AND SEQFRACAO = '+IntToStr(VpaDFracao.SeqFracao)+
                           ' order by SEQCONSUMO ');
  while not OrdTabela.eof do
  begin
    VpfDConsumoOp := VpaDFracao.addConsumo;
    VpfDConsumoOp.SeqConsumo := OrdTabela.FieldByName('SEQCONSUMO').AsInteger;
    VpfDConsumoOp.QtdBaixado := OrdTabela.FieldByname('QTDBAIXADO').AsFloat;
    VpfDConsumoOp.QtdABaixar := OrdTabela.FieldByname('QTDPRODUTO').AsFloat;
    VpfDConsumoOp.QtdReservada := OrdTabela.FieldByname('QTDRESERVADAESTOQUE').AsFloat;
    VpfDConsumoOp.QtdAReservar := OrdTabela.FieldByname('QTDARESERVAR').AsFloat;
    VpfDConsumoOp.QtdUnitario := OrdTabela.FieldByname('QTDUNITARIO').AsFloat;
    VpfDConsumoOp.UMUnitario := OrdTabela.FieldByname('DESUMUNITARIO').AsString;
    VpfDConsumoOp.DesObservacoes := OrdTabela.FieldByname('DESOBSERVACAO').AsString;
    VpfDConsumoOp.SeqProduto := OrdTabela.FieldByname('SEQPRODUTO').AsInteger;
    VpfDConsumoOp.CodCor := OrdTabela.FieldByname('CODCOR').AsInteger;
    VpfDConsumoOp.CodFaca := OrdTabela.FieldByname('CODFACA').AsInteger;
    VpfDConsumoOp.UM := OrdTabela.FieldByname('DESUM').AsString;
    VpfDConsumoOp.IndBaixado := OrdTabela.FieldByname('INDBAIXADO').AsString = 'S';
    VpfDConsumoOp.IndOrdemCorte := OrdTabela.FieldByname('INDORDEMCORTE').AsString = 'S';
    VpfDConsumoOp.IndOrigemCorte := OrdTabela.FieldByname('INDORIGEMCORTE').AsString = 'S';
    VpfDConsumoOp.IndMaterialExtra := OrdTabela.FieldByname('INDMATERIALEXTRA').AsString = 'S';
    VpfDConsumoOp.IndExcluir := OrdTabela.FieldByname('INDEXCLUIR').AsString = 'S';
    VpfDConsumoOp.AltMolde := OrdTabela.FieldByName('ALTMOLDE').AsFloat;
    VpfDConsumoOp.LarMolde := OrdTabela.FieldByName('LARMOLDE').AsFloat;
    OrdTabela.Next;
  end;
  OrdTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarDPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo;VpaCodFilial, VpaSeqPlano : Integer);
begin
  AdicionaSQLAbreTabela(OrdTabela,'Select * from PLANOCORTECORPO '+
                                  ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' and SEQPLANOCORTE = '+ IntToStr(VpaSeqPlano));
  VpaDPlanoCorte.CodFilial := VpaCodFilial;
  VpaDPlanoCorte.SeqPlanoCorte := VpaSeqPlano;
  VpaDPlanoCorte.SeqMateriaPrima := OrdTabela.FieldByname('SEQMATERIAPRIMA').AsInteger;
  VpaDPlanoCorte.NumCNC := OrdTabela.FieldByname('NUMCNC').AsInteger;
  VpaDPlanoCorte.CodUsuario := OrdTabela.FieldByname('CODUSUARIO').AsInteger;
  VpaDPlanoCorte.DatEmissao := OrdTabela.FieldByname('DATEMISSAO').AsDateTime;
  OrdTabela.close;
  CarDPlanoCorteItem(VpaDPlanoCorte);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarQtdMetrosMaquina(VpaDOPItem : TRBDOPItemCadarco);
var
  VpfLaco : Integer;
  VpfDMaquina : TRBDOPItemMaquina;
  VpfQtdMetros, VpfQtdMetrosporVez, VpfIndice : Double;
begin
  FreeTObjectsList(VpaDOPItem.Maquinas);
  if VpaDOPItem.NroMaquinas = 0 then
    VpaDOPItem.NroMaquinas := 1;
  if VpaDOPItem.MetporTabua <> 0 then
  begin
    if ((VpaDOPItem.MetporTabua * VpaDOPItem.NumTabuas) >  (VpaDOPItem.QtdMetrosProduto)) then
    begin
      VpfIndice := VpaDOPItem.QtdMetrosProduto / (VpaDOPItem.MetporTabua * VpaDOPItem.NumTabuas);
      VpfQtdMetrosporVez :=  trunc(VpaDOPItem.MetporTabua * VpfIndice);
    end
    else
      VpfQtdMetrosporVez := VpaDOPItem.MetporTabua;
  end
  else
  begin
    VpaDOPItem.NroMaquinas := 1;
    VpfQtdMetrosporVez := VpaDOPItem.QtdMetrosProduto;
  end;

  for VpfLaco := 1 to VpaDOPItem.NroMaquinas do
  begin
    VpfDMaquina := VpaDOPItem.addMaquina;
    VpfDMaquina.CodMaquina := 0;
    VpfDMaquina.QtdMetros := 0;
  end;

  VpfQtdMetros := VpaDOPItem.QtdMetrosProduto;
  While VpfQtdMetros > 0 do
  begin
    for VpfLaco := 0 to VpaDOPItem.Maquinas.Count - 1 do
    begin
      VpfDMaquina := TRBDOPItemMaquina(VpaDOPItem.Maquinas.Items[VpfLaco]);
      if VpfQtdMetros  > VpfQtdMetrosporVez  then
        VpfDMaquina.QtdMetros := VpfDMaquina.QtdMetros + VpfQtdMetrosporVez
      else
        VpfDMaquina.QtdMetros := VpfDMaquina.QtdMetros + VpfQtdMetros;
      VpfQtdMetros := VpfQtdMetros - VpfQtdMetrosporVez;
      if VpfQtdMetros < 0 then
        break;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarItensColetaOP(VpaDColetaOP : TRBDColetaOP;VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfDColetaItem : TRBDColetaOPItem;
  VpfLaco : Integer;
begin
  FreeTObjectsList(VpaDColetaOP.ItensColeta);
  for VpfLaco := 0 to VpaDOrdemProducao.Items.Count - 1 do
  begin
    VpfDColetaItem := VpaDColetaOP.AddItemColeta;
    VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]);
    VpfDColetaItem.SeqItem := VpfDOrdemItem.SeqItem;
    VpfDColetaItem.CodCombinacao := VpfDOrdemItem.CodCombinacao;
    VpfDColetaItem.CodManequim := VpfDOrdemItem.CodManequim;
    VpfDColetaItem.NroFitas := VpfDOrdemItem.QtdFitas;
    VpfDColetaItem.NroFitasAnterior := VpfDOrdemItem.QtdFitas;
    VpfDColetaItem.MetrosProduzidos := VpfDOrdemItem.QtdProduzido;
    VpfDColetaItem.MetrosColetados := 0;
    VpfDColetaItem.MetrosAProduzir := VpfDOrdemItem.MetrosFita;
    VpfDColetaItem.MetrosFaltante := VpfDOrdemItem.QtdFaltante;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarGerarOP(VpaCotacoes, VpaProdutos : TList);
var
  VpfLacoCotacao,VpfLacoProduto : Integer;
  VpfDProCotacao : TRBDOrcProduto;
  VpfDCompose : TRBDOrcCompose;
  VpfDCotacao : TRBDOrcamento;
  VpfDGerarOp : TRBDGerarOp;
begin
  for VpfLacoCotacao := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoCotacao]);
    for VpfLacoProduto := 0 to VpfDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
      if (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado > 0) and
         (VpfDProCotacao.DatOpGerada < MontaData(1,1,1900)) then
      begin
        VpfDGerarOp := ExisteProdutoGerarOP(VpfDProCotacao,VpaProdutos);
        if VpfDGerarOp = nil then
        begin
          VpfDGerarOp := TRBDGerarOp.cria;
          VpaProdutos.add(VpfDGerarOp);
          VpfDGerarOp.IndGerar := varia.TipoOrdemProducao = toAgrupada;
          VpfDGerarOp.SeqItemOrcamento := VpfDProCotacao.SeqMovimento;
          VpfDGerarOp.CodProduto := VpfDProCotacao.CodProduto;
          VpfDGerarOp.NomProduto := VpfDProCotacao.NomProduto;
          VpfDGerarOp.NomCor := VpfDProCotacao.DesCor;
          VpfDGerarOp.NomTamanho := VpfDProCotacao.NomTamanho;
          VpfDGerarOp.UM := VpfDProCotacao.UM;
          VpfDGerarOp.UMOriginal := VpfDProCotacao.UMOriginal;
          VpfDGerarOp.DesReferenciaCliente := VpfDProCotacao.DesRefCliente;
          VpfDGerarOp.DesObservacao := VpfDProCotacao.DesObservacao;
          VpfDGerarOp.SeqProduto := VpfDProCotacao.SeqProduto;
          VpfDGerarOp.CodCor := VpfDProCotacao.CodCor;
          VpfDGerarOp.CodTamanho := VpfDProCotacao.CodTamanho;
          VpfDGerarOp.QtdProduto := VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado;
          VpfDGerarOp.QtdKit := VpfDProCotacao.QtdKit;
          VpfDGerarOp.DatEntrega := VpfDCotacao.DatPrevista;
          VpfDGerarOp.ValUnitario := VpfDProCotacao.ValUnitario;
          CopiaCompose(VpfDProCotacao.Compose,VpfDGerarOp.Compose);
        end
        else
        begin
          VpfDGerarOp.QtdProduto := VpfDGerarOp.QtdProduto + FunProdutos.CalculaQdadePadrao(VpfDProCotacao.UM, VpfDGerarOp.UM,VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado ,IntToStr(VpfDProCotacao.SeqProduto));
          if VpfDProCotacao.DesObservacao <> '' then
            VpfDGerarOp.DesObservacao := VpfDGerarOp.DesObservacao+ #13+ VpfDProCotacao.DesObservacao;
          if VpfDGerarOp.DatEntrega > VpfDCotacao.DatPrevista then
            VpfDGerarOp.DatEntrega := VpfDCotacao.DatPrevista;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.CombinacaoManequimDuplicado(VpaDOrdem : TRBDOrdemProducaoEtiqueta):Boolean;
var
  VpfLaco, VpfLaco2 : Integer;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
begin
  result := false;
  for VpfLaco := 0 to VpaDOrdem.Items.Count - 1 do
  begin
    VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOrdem.Items.Items[VpfLaco]);
    for VpfLaco2 := VpfLaco + 1 to VpaDOrdem.Items.Count - 1 do
    begin
      if (VpfDOrdemItem.CodCombinacao = TRBDOrdemProducaoItem(VpaDOrdem.Items.Items[VpfLaco2]).CodCombinacao) and
         (VpfDOrdemItem.CodManequim = TRBDOrdemProducaoItem(VpaDOrdem.Items.Items[VpfLaco2]).CodManequim) then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RNomeMaquina(VpaCodMaquina : String):String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdAux,'Select NOMMAQ from MAQUINA '+
                               ' Where CODMAQ = '+VpaCodMaquina);
  result := OrdAux.FieldByName('NOMMAQ').AsString;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RNomeEstagio(VpaCodEstagio : Integer) : String;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select NOMEST from ESTAGIOPRODUCAO '+
                               ' Where CODEST = '+IntToStr(VpaCodEstagio));
  result := OrdAux.FieldByName('NOMEST').AsString;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RNumTabuasExtenso(VpaTipoOP : Integer; VpaNumTabuas, VpaQtdMetros : Double):String;
var
  VpfLaco, VpfQtdTabuas : Integer;
  VpfFracao : String;
begin
  result := '';
  VpfQtdTabuas :=  StrToInt(CopiaAteChar(FloatToStr(VpaNumTabuas),DecimalSeparator));

  for VpfLaco := 1 to VpfQtdTabuas do
  begin
    result := result +'|  ';
  end;

  VpfFracao :=  DeleteAteChar(FloatToStr(VpaNumTabuas),DecimalSeparator);
  if VpfFracao <> '' then
  begin
    VpfQtdTabuas := StrToInt(VpfFracao);
    case VpfQtdTabuas of
      2,3 : result := result + '1/4';
      4,5,6 : result := result + '1/2';
      7,8 : result := result + '3/4';
      9 : result := result + '|';
    end;
    if result = '' then
      if VpfQtdTabuas = 1 then
      begin
        case VpaTipoOP of
          0 : result := FormatFloat('0',(VpaQtdMetros/4)); //espula grande
          1 : result := FormatFloat('0',VpaQtdMetros/2); //espula pequena
          2 : result := FormatFloat('0',VpaQtdMetros); //espula transilin
        end;
        result := result + ' VOLTAS';
      end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.EstagioFinal(VpaCodEstagio : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select INDFIN from ESTAGIOPRODUCAO '+
                               ' Where CODEST = '+IntToStr(VpaCodEstagio));
  result := OrdAux.FieldByName('INDFIN').AsString = 'S';
  ordAux.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CalculaTotaisMetros(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
var
  VpfLaco, VpfCodCombinacao : Integer;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfMetFita : Double;
begin
  if VpaDOrdemProducao.Items.Count > 0 then
  begin
    VpfCodCombinacao := TRBDOrdemProducaoItem(VpaDOrdemProducao.Items[0]).CodCombinacao;
    VpaDOrdemProducao.TotMetros := 0;
    VpaDOrdemProducao.MetFita := 0;
    VpfMetFita := 0;
    for VpfLaco := 0 to VpaDOrdemProducao.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]);
      if VpfDOrdemItem.CodCombinacao = VpfCodCombinacao then
        VpfMetFita := VpfMetFita + VpfDOrdemItem.MetrosFita
      else
      begin
        VpfCodCombinacao := VpfDOrdemItem.CodCombinacao;
        if VpfMetFita > VpaDOrdemProducao.MetFita then
          VpaDOrdemProducao.MetFita := VpfMetFita;
        VpfMetFita := VpfDOrdemItem.MetrosFita;
      end;

      VpaDOrdemProducao.TotMetros := VpaDOrdemProducao.TotMetros + (VpfDOrdemItem.MetrosFita * VpfDOrdemItem.QtdFitas) ;
    end;
    if VpfMetFita > VpaDOrdemProducao.MetFita then
      VpaDOrdemProducao.MetFita := VpfMetFita;
  end
  else
  begin
    VpaDOrdemProducao.TotMetros := 0;
    VpaDOrdemProducao.MetFita := 0;
  end;
  if VpaDOrdemProducao.TipTear = 1 then //tear H, tem que converter de peças para metros.
  begin
    VpaDOrdemProducao.TotMetros := ((VpaDOrdemProducao.TotMetros * VpaDProduto.CmpProduto)/1000);
    VpaDOrdemProducao.MetFita := (VpaDOrdemProducao.TotMetros / VpaDOrdemProducao.QtdFita);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ArredondaMetroFita(VpaMetros : Double) : Double;
var
  VpfMetros : Double;
begin
  result := 0;
  VpaMetros := ArredondaDecimais(VpaMetros,1);
  VpfMetros := VpaMetros - RetornaInteiro(VpaMetros);
  VpfMetros := VpfMetros * 10;
  VpaMetros := RetornaInteiro(VpaMetros);
  case Trunc(VpfMetros) of
    0 : Result := VpaMetros;
    1,2,3,4,5 : result := VpaMetros + 0.5;
    6,7,8,9 : result := VpaMetros + 1;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RQtdHoras(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto):String;
var
  VpfX1, VpfX2, VpfX3 : Double;
  VpfIndiceProdutividade : Double;
begin
  if VpaDProduto.PerProdutividade = 0 then
    VpfIndiceProdutividade := 0.80
  else
    VpfIndiceProdutividade := VpaDProduto.PerProdutividade/100;
  result := '';
  if VpaDProduto.BatProduto <> '' then
    if (StrToInt(VpaDProduto.BatProduto) > 0) and (VpaDProduto.CmpProduto > 0) and
       (VpaDOrdemProducao.QtdRPMMaquina > 0) then
    begin
      try
//        VpfX1 := (VpaDOrdemProducao.QtdProduto
        result := FormatFloat('0.00',((VpaDOrdemProducao.MetFita* (1000/VpaDProduto.CmpProduto) / (VpaDOrdemProducao.QtdRPMMaquina * 60 / StrToInt(VpaDProduto.BatProduto)))/VpfIndiceProdutividade));
      except
        result := '';
      end;
    end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RQtdHorasEstagio(VpaDEstagioOP : TRBDordemProducaoEstagio;VpaDEstagioProduto : TRBDEstagioProduto;VpaQtdProduto : Double):string;
var
  VpfQtdHoras : String;
  VpfMinutos : Double;
  VpfConfigMinutos, VpfConfigHoras : Integer;
begin
  result := '';
  if (VpaDEstagioProduto.QtdProducaoHora <> 0) and (UpperCase(VpaDEstagioProduto.IndConfig) = 'N') then
  begin
    VpfQtdHoras := FloatTostr((VpaQtdProduto/ VpaDEstagioProduto.QtdProducaoHora)/VpaDEstagioOP.QtdCelula);
    result := AdicionaCharE('0',CopiaAteChar(VpfQtdHoras,','),2)+':';
    VpfQtdHoras := DeleteAteChar(VpfQtdHoras,',');
    VpfMinutos := (StrToInt(AdicionaCharD('0',copy(VpfQtdHoras,1,2),2)) *60)/100;
    result := result+AdicionaCharE('0',IntTostr(RetornaInteiro(VpfMinutos)),2);
  end
  else//é setup de maquina
  begin
    VpfConfigHoras := 0;
    VpfConfigMinutos := StrToInt(AdicionaCharE('0',DeleteAteChar(VpaDEstagioProduto.DesTempoConfig,':'),1));
    VpfConfigMinutos := VpfConfigMinutos * VpaDEstagioOP.QtdCelula;
    if VpfConfigMinutos >= 60 then
    begin
      VpfConfigHoras := VpfConfigHoras + (VpfConfigMinutos div 60);
      VpfConfigMinutos := VpfConfigMinutos - ((VpfConfigMinutos div 60) *60);
    end;
    VpfConfigHoras := VpfConfigHoras + (StrtoInt(AdicionaCharE('0',CopiaAteChar(VpaDEstagioProduto.DesTempoConfig,':'),1))*VpaDEstagioOP.QTdCelula);
    result := AdicionaCharE('0',IntToStr(VpfConfigHoras),2)+':'+AdicionaCharE('0',IntToStr(VpfConfigMinutos),2)
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RTotalHorasOP(VpaDFracaoOP : TRBDFracaoOrdemProducao):String;
var
  VpfLaco : Integer;
  VpfDEstagio : TRBDordemProducaoEstagio;
  VpfQtdHoras, VpfQtdMinutos : Integer;
begin
  VpfQtdHoras := 0;
  VpfQtdMinutos := 0;
  for VpfLaco := 0 to VpaDFracaoOP.Estagios.Count - 1 do
  begin
    VpfDEstagio := TRBDordemProducaoEstagio(VpaDFracaoOp.Estagios.Items[VpfLaco]);
    VpfQtdHoras := VpfQtdHoras + StrtoInt(CopiaAteChar(VpfDEstagio.QtdHoras,':'));
    VpfQtdMinutos := VpfQtdMinutos + StrtoInt(DeleteAteChar(VpfDEstagio.QtdHoras,':'));
  end;
  VpfQtdHoras := VpfQtdHoras + (VpfQtdMinutos div 60);
  VpfQtdMinutos := VpfQtdMinutos - ((VpfQtdMinutos div 60) * 60);
  result := IntToStr(VpfQtdHoras)+':'+AdicionaCharE('0',Inttostr(VpfQtdMinutos),2);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RFracaoOP(VpaDOrdemProducao : TRBDordemProducao;VpaSeqFracao : Integer):TRBDFracaoOrdemProducao;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDOrdemProducao.Fracoes.Count -1 do
  begin
    if TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLaco]).SeqFracao = VpaSeqFracao then
    begin
      result := TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLaco]);
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.RProximoEstagioFracao(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao,VpaEstagioAtual : Integer):Integer;
Var
  VpfTipEstagioAtual : Integer;
begin
  AdicionaSQLAbreTabela(OrdAux,'Select FRE.CODESTAGIO, EST.CODTIP '+
                               ' from FRACAOOPESTAGIO FRE, ESTAGIOPRODUCAO EST '+
                               ' Where FRE.CODFILIAL = ' + IntToStr(VpaCodFilial)+
                               ' and FRE.SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                               ' and FRE.SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                               ' and FRE.INDFINALIZADO = ''N'''+
                               ' and FRE.CODESTAGIO = EST.CODEST '+
                               ' order by SEQESTAGIO ');
  VpfTipEstagioAtual := OrdAux.FieldByName('CODTIP').AsInteger;
  if VpaEstagioAtual = OrdAux.FieldByname('CODESTAGIO').AsInteger then
    OrdAux.next;
  result := OrdAux.FieldByname('CODESTAGIO').AsInteger;
//  OrdAux.next;
  if (OrdAux.eof) and (result = VpaEstagioAtual) then
    result := varia.EstagioFinalOrdemProducao;
  if result <> varia.EstagioFinalOrdemProducao then
  begin
    if config.AlterarEstagioFracaoPeloTipoEstagio then
    begin
      while not OrdAux.eof do
      begin
        if VpfTipEstagioAtual = OrdAux.FieldByName('CODTIP').AsInteger then
          ordAux.next
        else
          break;
      end;
      if VpfTipEstagioAtual = OrdAux.FieldByName('CODTIP').AsInteger then
        result := varia.EstagioFinalOrdemProducao
      else
        result := OrdAux.FieldByname('CODESTAGIO').AsInteger;
    end;
  end;
  OrdAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarValoreSeqItemFaccionista(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio, VpaCodFaccionista : Integer;VpaIndDefeito : Boolean;VpaDRetornoFaccionista : TRBDRetornoFracaoFaccionista);
begin
  OrdAux.sql.clear;
  OrdAux.sql.add('Select SEQITEM, VALUNITARIO, QTDENVIADO, QTDDEVOLUCAO, QTDPRODUZIDO, QTDDEFEITO, DATFINALIZACAO, ' +
                  ' DATRETORNO, VALUNITARIOPOSTERIOR  '+
              ' from FRACAOOPFACCIONISTA '+
              ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
              ' and SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
              ' and SEQFRACAO = ' +IntToStr(VpaSeqFracao)+
              ' and CODFACCIONISTA = '+IntToStr(VpaCodFaccionista));
  if VpaIndDefeito then
    OrdAux.sql.add('and INDDEFEITO = ''S''')
  else
    OrdAux.sql.add('and INDDEFEITO = ''N''');
  if VpaSeqEstagio = 0 then
    OrdAux.sql.add(' and SEQESTAGIO IS NULL')
  else
    OrdAux.Sql.Add(' and SEQESTAGIO = ' +IntToStr(VpaSeqEstagio));
  OrdAux.open;
  while not ordaux.eof do
  begin
    VpaDRetornoFaccionista.SeqItem := OrdAux.FieldByname('SEQITEM').AsInteger;
    VpaDRetornoFaccionista.ValUnitario := OrdAux.FieldByname('VALUNITARIO').AsFloat;
    VpaDRetornoFaccionista.ValUnitarioEnviado := OrdAux.FieldByname('VALUNITARIO').AsFloat;
    VpaDRetornoFaccionista.ValUnitarioPosteriorEnviado := OrdAux.FieldByname('VALUNITARIOPOSTERIOR').AsFloat;
    VpaDRetornoFaccionista.DatNegociado := OrdAux.FieldByname('DATRETORNO').AsDateTime;
    VpaDRetornoFaccionista.QtdFaltante := OrdAux.FieldByname('QTDENVIADO').AsFloat -
                                          OrdAux.FieldByname('QTDDEVOLUCAO').AsFloat -
                                          OrdAux.FieldByname('QTDPRODUZIDO').AsFloat -
                                          OrdAux.FieldByname('QTDDEFEITO').AsFloat;
    VpaDRetornoFaccionista.DatFinalizacaoFracao := OrdAux.FieldByname('DATFINALIZACAO').AsDateTime;
    if OrdAux.FieldByname('DATFINALIZACAO').IsNull then
      break;
    OrdAux.next;
  end;
  OrdAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ConfigGradeTearConvencional(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaGrade : TRBStringGridColor);
begin
//  VpaGrade.ColCount := 6;
  VpaGrade.Cells[1,0] := 'Combinação';
  VpaGrade.Cells[2,0] := 'Manequim';
  if UpperCase(VpaDOrdemProducao.UMPedido) = 'PC' then
    VpaGrade.Cells[3,0] := 'Qtd Etiquetas'
  else
    VpaGrade.Cells[3,0] := 'Qtd Metros';
  VpaGrade.Cells[4,0] := 'Qtd Fitas';
  VpaGrade.Cells[5,0] := 'Metros Fita';
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ConfigGradeTearH(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaGrade : TRBStringGridColor);
begin
//  VpaGrade.ColCount := 6;
  VpaGrade.Cells[1,0] := 'Combinação';
  VpaGrade.Cells[2,0] := 'Manequim';
  if UpperCase(VpaDOrdemProducao.UMPedido) = 'PC' then
    VpaGrade.Cells[3,0] := 'Qtd Etiquetas'
  else
    VpaGrade.Cells[3,0] := 'Qtd Metros';
  VpaGrade.Cells[4,0] := 'Qtd Fitas';
  VpaGrade.Cells[5,0] := 'Peças Fita';

end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.AtualizaQtdMetrosColetadoOP(VpaDColetaOP : TRBDColetaOP);
var
  VpfLaco : Integer;
begin
  VpaDColetaOP.QtdTotalColetado := 0;
  for Vpflaco := 0 to VpaDColetaOP.ItensColeta.Count - 1 do
  begin
    VpaDColetaOP.QtdTotalColetado := VpaDColetaOP.QtdTotalColetado + (TRBDColetaOPItem(VpaDColetaOP.ItensColeta.Items[Vpflaco]).MetrosColetados * TRBDColetaOPItem(VpaDColetaOP.ItensColeta.Items[Vpflaco]).NroFitas);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AtualizaQtdRenegociacoesFaccionista(VpaCodFaccionista : Integer;VpaIndRenegociado : Boolean):string;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista));
  OrdCadastro.edit;
  OrdCadastro.FieldByname('QTDLIGACAO').AsInteger := OrdCadastro.FieldByname('QTDLIGACAO').AsInteger + 1;
  if VpaIndRenegociado then
    OrdCadastro.FieldByname('QTDRENEGOCIACAO').AsInteger := OrdCadastro.FieldByname('QTDRENEGOCIACAO').AsInteger + 1;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaColetaRomaneio(VpaEmpFil,VpaSeqOrdem, VpaSeqColeta : String): String;
var
  VpfSeqRomaneio : Integer;
begin
  result := '';
  VpfSeqRomaneio := RSeqRomaneio(VpaEmpFil);
  if VpfSeqRomaneio = 0 then
    result := 'NÃO FOI POSSÍVEL ADICIONAR A COLETA AO ROMANEIO!!!'#13'Não existe nenhum romaneio ativo, ou o romaneio já possui 22 itens.';

  if result = '' then
  begin
    AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOITEM ' +
                                      ' Where EMPFIL = '+VpaEmpFil+
                                      ' and SEQROM = ' + IntTostr(VpfSeqRomaneio)+
                                      ' and SEQORD = '+ VpaSeqOrdem +
                                      ' and SEQCOL = '+ VpaSeqColeta);
    if not OrdCadastro.Eof then
      result := 'COLETA DUPLICADA NO ROMANEIO!!!'#13'Esta coleta já foi adicionada no romaneio atualmente ativo.';

    if result = '' then
    begin
      OrdCadastro.Insert;
      OrdCadastro.FieldByName('EMPFIL').AsString := VpaEmpFil;
      OrdCadastro.FieldByName('SEQROM').AsInteger := VpfSeqRomaneio;
      OrdCadastro.FieldByName('SEQORD').AsString := VpaSeqOrdem;
      OrdCadastro.FieldByName('SEQCOL').AsString := VpaSeqColeta;
      OrdCadastro.Post;
      result := OrdCadastro.AMensagemErroGravacao;
      if result = '' then
        result := MarcaColetaAdicionada(VpaEmpFil,VpaSeqOrdem,VpaSeqColeta);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaEstoqueColetaOP(VpaDOrdemProducao :TRBDOrdemProducaoEtiqueta; VpaDColetaOP : TRBDColetaOP):String;
var
  VpfDColetaItem : TRBDColetaOPItem;
  VpfLaco,VpfSeqBarra : Integer;
  VpfQtdProduto : Double;
  VpfDProduto : TRBDProduto;
begin
  result := verificaOperacoesEstoque;
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDColetaOP.ItensColeta.Count - 1 do
    begin
      VpfDColetaItem := TRBDColetaOPItem(VpaDColetaOP.ItensColeta.Items[Vpflaco]);
      if VpfDColetaItem.MetrosColetados <> 0 then
      begin
        VpfQtdProduto := (VpfDColetaItem.MetrosColetados * VpfDColetaItem.NroFitas) / 1000;
        if config.EstoqueCentralizado then
        begin
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaDOrdemProducao.CodEmpresafilial,VpaDOrdemProducao.SeqProduto);
          FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDOrdemProducao.CodEmpresafilial, varia.OperacaoAcertoEstoqueEntrada,0,0,0,varia.MoedaBase,VpfDColetaItem.CodCombinacao,0,
                                          date,VpfQtdProduto,10,VpfDProduto.CodUnidade,'',false,VpfSeqBarra);
          VpfDProduto.free;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.AdicionaEstagiosOP(VpaDProduto : TRBDProduto;VpaDFracao :TRBDFracaoOrdemProducao;VpaProducaoExterna : Boolean);
var
  VpfLaco : Integer;
  VpfDEstagioOP : TRBDordemProducaoEstagio;
  VpfDEstagioProduto : TRBDEstagioProduto;
begin
  FreeTObjectsList(VpaDFracao.Estagios);
  for VpfLaco := 0 to VpaDProduto.Estagios.Count -1 do
  begin
    VpfDEstagioOP := VpaDFracao.AddEstagio;
    VpfDEstagioProduto := TRBDEstagioProduto(VpaDProduto.Estagios.Items[VpfLaco]);
    VpfDEstagioOP.CodEstagio := VpfDEstagioProduto.CodEstagio;
    VpfDEstagioOP.SeqEstagio := VpfDEstagioProduto.SeqEstagio;
    VpfDEstagioOP.DesEstagio := VpfDEstagioProduto.DesEstagio;
    if VpfDEstagioOP.CodEstagio = 204 then
      VpfDEstagioOP.IndProducaoInterna := 'E';
    VpfDEstagioOP.SeqEstagioAnterior := VpfDEstagioProduto.CodEstagioAnterior;
    VpfDEstagioOP.QtdCelula := 1;
    VpfDEstagioOP.NumOrdem := VpfDEstagioProduto.NumOrdem;
    FunProdutos.ExisteEstagio(IntToStr(VpfDEstagioOP.CodEstagio),VpfDEstagioOP.NomEstagio);
    VpfDEstagioOP.QtdHoras := RQtdHorasEstagio(VpfDEstagioOP,VpfDEstagioProduto,VpaDFracao.QtdProduto);
  end;
  VpaDFracao.IndEstagiosCarregados := true;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaQtdAFaturarFracao(VpaDColetaRomaneio : TRBDColetaRomaneioOp;VpaDOrdemProducao : TRBDOrdemProducao;VpaExtornar : Boolean):string;
var
  VpfQtd : Double;
begin
  result := '';
  VpfQtd := FunProdutos.CalculaQdadePadrao(VpaDColetaRomaneio.DesUM,VpaDOrdemProducao.UMPedido,VpaDColetaRomaneio.QtdColetado,IntToStr(VpaDOrdemProducao.SeqProduto));
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOP '+
                                    ' Where CODFILIAL = '+IntToStr(VpaDColetaRomaneio.CodFilial)+
                                    ' and SEQORDEM = ' +IntToStr(VpaDColetaRomaneio.NumOrdemProducao)+
                                    ' and SEQFRACAO = '+IntToStr(VpaDColetaRomaneio.SeqFracao));
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('QTDAFATURAR').AsFloat := OrdCadastro.FieldByName('QTDAFATURAR').AsFloat + VpfQtd;
  if not VpaExtornar then
    OrdCadastro.FieldByName('QTDREVISADO').AsFloat := OrdCadastro.FieldByName('QTDREVISADO').AsFloat + VpfQtd;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.AdicionaProdutosSubMontagem(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracaoPrincipal : TRBDFracaoOrdemProducao;VpaBarraStatus : TStatusBar;VpaCarregarTodosFilhos : Boolean);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfDProduto : TRBDProduto;
  VpfTabela : TSQLQUERY;
  VpfLaco : Integer;
begin
  inc(VplQtdFracoes);
  if VpaBarraStatus <> nil then
  begin
    VpaBarraStatus.Panels[0].Text := 'Fração '+IntToStr(VplQtdFracoes) +' - Adicionando submontagem do produto "'+VpaDFracaoPrincipal.CodProduto+'-'+VpaDFracaoPrincipal.NomProduto+'"';
    VpaBarraStatus.Refresh;
  end;
  if VpaCarregarTodosFilhos then //se nao é para carregar todos os filhos o estagio da fracao principal ja esta preenchido;
  begin
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,VpaDOrdemProducao.CodEmpresafilial,VpaDFracaoPrincipal.SeqProduto);
    AdicionaEstagiosOP(VpfDProduto,VpaDFracaoPrincipal,false);
    VpfDProduto.Free;
  end;
  VpfTabela := TSQLQuery.create(nil);
  VpfTabela.SQLConnection := OrdCadastro.ASQLConnection;
  AdicionaSQLAbreTabela(VpfTabela,'Select MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.C_COD_UNI, ' +
                                         ' MOV.N_QTD_PRO,  '+
                                         ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                                         ' COR.NOM_COR '+
                                         ' from MOVKIT MOV, CADPRODUTOS PRO, COR '+
                                         ' Where MOV.I_PRO_KIT = '+IntToStr(VpaDFracaoPrincipal.SeqProduto)+
                                         ' AND MOV.I_COR_KIT = '+IntToStr(VpaDFracaoPrincipal.CodCor)+
                                         ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                         ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                                         ' ORDER BY I_SEQ_MOV ');
  while not VpfTabela.Eof do
  begin
    if FunProdutos.ExisteConsumoProdutoCor(VpfTabela.FieldByname('I_SEQ_PRO').AsInteger,
                                            VpfTabela.FieldByname('I_COD_COR').AsInteger) then
    begin
      for VpfLaco := 1 to RetornaInteiro(VpfTabela.FieldByname('N_QTD_PRO').AsFloat) do
      begin
        VpfDFracao := VpaDOrdemProducao.AddFracao;
        VpfDFracao.SeqFracaoPai := VpaDFracaoPrincipal.SeqFracao;
        VpfDFracao.SeqProduto := VpfTabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDFracao.CodCor := VpfTabela.FieldByname('I_COD_COR').AsInteger;
        VpfDFracao.CodProduto := VpfTabela.FieldByname('C_COD_PRO').AsString;
        VpfDFracao.NomProduto := VpfTabela.FieldByname('C_NOM_PRO').AsString;
        VpfDFracao.DesObservacao := VpaDOrdemProducao.DesObservacoes;
        VpfDFracao.NomCor := VpfTabela.FieldByname('NOM_COR').AsString;
        VpfDFracao.UM := VpfTabela.FieldByname('C_COD_UNI').AsString;
        VpfDFracao.UMOriginal := VpfTabela.FieldByname('C_COD_UNI').AsString;
        VpfDFracao.QtdUtilizada := 1;// VpfTabela.FieldByname('N_QTD_PRO').AsFloat;
        VpfDFracao.QtdProduto :=  1;//VpfTabela.FieldByname('N_QTD_PRO').AsFloat;
        VpfDFracao.DatEntrega := VpaDOrdemProducao.DatEntregaPrevista;
        VpfDFracao.CodEstagio := Varia.EstagioOrdemProducao;
        VpfDFracao.IndEstagioGerado := true;
        VpfDFracao.IndEstagiosCarregados := true;
        VpfDProduto := TRBDProduto.Cria;
        if VpaCarregarTodosFilhos then
          AdicionaProdutosSubMontagem(VpaDOrdemProducao,VpfDFracao,VpaBarraStatus,true);
      end;
    end;
    VpfTabela.Next;
  end;
  VpfTabela.Close;
  VpfTabela.free;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaFracaoPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo;VpaSeProduto : Integer;VpaCodProduto,VpaNomProduto : string):TRBDPlanoCorteFracao;
var
  VpfDPlanoItem : TRBDPlanoCorteItem;
  VpfLaco : Integer;
begin
  VpfDPlanoItem := nil;
  for VpfLaco := 0 to VpaDPlanoCorte.Itens.Count - 1 do
  begin
    if TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLaco]).SeqProduto = VpaSeProduto then
    begin
      VpfDPlanoItem := TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLaco]);
      break;
    end;
  end;
  if VpfDPlanoItem = nil then
  begin
    VpfDPlanoItem := VpaDPlanoCorte.AddPlanoCorteItem;
    VpfDPlanoItem.SeqProduto := VpaSeProduto;
    VpfDPlanoItem.QtdProduto := 0 ;
    VpfDPlanoItem.CodProduto := VpaCodProduto;
    VpfDPlanoItem.NomProduto := VpaNomProduto;
  end;
  VpfDPlanoItem.QtdProduto := VpfDPlanoItem.QtdProduto + 1;
  result := VpfDPlanoItem.AddFracao;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.AdicionaLogReimportacaoFracao(VpaDFracao: TRBDFracaoOrdemProducao): string;
var
  VpfDEstagioReal : TRBDEstagioFracaoOPReal;
begin
  VpfDEstagioReal := TRBDEstagioFracaoOPReal.cria;
  VpfDEstagioReal.CodFilial := VpaDFracao.CodFilial;
  VpfDEstagioReal.SeqOrdem := VpaDFracao.SeqOrdemProducao;
  VpfDEstagioReal.SeqFracao := VpaDFracao.SeqFracao;
  VpfDEstagioReal.CodEstagio := varia.EstagioOPReimportada;
  VpfDEstagioReal.CodUsuario := varia.CodigoUsuario;
  VpfDEstagioReal.CodUsuarioLogado := varia.CodigoUsuario;
  VpfDEstagioReal.IndDatFim := false;
  result := GravaDFracaoOpEstagioReal(VpfDEstagioReal);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.RecalculaHorasEstagio(VpaDOrdemProducao : TRBDordemProducao;VpaDFracao : TRBDFracaoOrdemProducao);
var
  VpfDEstagio : TRBDordemProducaoEstagio;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDFracao.Estagios.Count - 1 do
  begin
    VpfDEstagio := TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLaco]);
    VpfDEstagio.QtdHoras := RQtdHorasEstagio(VpfDEstagio,FunProdutos.REstagioProduto(VpaDOrdemProducao.DProduto,VpfDEstagio.SeqEstagio),VpaDFracao.QtdProduto);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.BaixaEstoqueRomaneio(VpaCodFilial,VpaSeqRomaneio : Integer;VpaEstornar : boolean) : String;
var
  vpfQtdProduto : Double;
  VpfOperacaoEstoque,VpfSeqBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  result := verificaOperacoesEstoque;
  if result = '' then
  begin
    if VpaEstornar then
      VpfOperacaoEstoque := Varia.OperacaoEstoqueEstornoEntrada
    else
      VpfOperacaoEstoque := varia.OperacaoEstoqueEstornoSaida;

    AdicionaSQLAbreTabela(OrdTabela,'select ORD.EMPFIL, ORD.SEQPRO, COL.CODCOM, COL.NROFIT, COL.METCOL, PRO.I_CMP_PRO '+
                                   ' from ROMANEIOITEM ROM, COLETAOPITEM COL, ORDEMPRODUCAOCORPO ORD, CADPRODUTOS PRO '+
                                   ' WHERE ROM.EMPFIL = COL.EMPFIL '+
                                   ' AND ROM.SEQORD = COL.SEQORD ' +
                                   ' AND ROM.SEQCOL = COL.SEQCOL '+
                                   ' AND ROM.EMPFIL = ORD.EMPFIL '+
                                   ' AND ROM.SEQORD = ORD.SEQORD '+
                                   ' and ROM.EMPFIL = '+IntToStr(VpaCodFilial)+
                                   ' AND ROM.SEQROM = ' + IntToStr(VpaSeqRomaneio)+
                                   ' AND ORD.SEQPRO = PRO.I_SEQ_PRO ');
    While not ordTabela.Eof do
    begin
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,OrdTabela.FieldByName('EMPFIL').AsInteger,OrdTabela.FieldByName('SEQPRO').AsInteger);
      vpfQtdProduto := (OrdTabela.FieldByName('NROFIT').AsInteger * OrdTabela.FieldByName('METCOL').AsFloat)/1000;
      FunProdutos.BaixaProdutoEstoque(VpfDProduto,OrdTabela.FieldByName('EMPFIL').AsInteger, VpfOperacaoEstoque,0,0,0,varia.Moedabase,
                                      OrdTabela.FieldByName('CODCOM').AsInteger,0,date,vpfQtdProduto,10,VpfDProduto.CodUnidade,'',false,VpfSeqBarra );
      VpfDProduto.Free;
      OrdTabela.Next;
    end;
    OrdTabela.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.BaixaRomaneioComoFaturado(VpaEmpFil, VpaSeqRomaneio,VpaSeqNota, VpaCodFilialNota : Integer) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from METROFATURADOITEM '+
                                    'Where EMPFIL = '+IntToStr(VpaEmpFil)+
                                    ' and SEQROM = '+IntToStr(VpaSeqRomaneio)+
                                    ' and SEQNOT = '+IntToStr(VpaSeqNota)+
                                    ' and FILNOT = '+IntToStr(VpaCodFilialNota));
  if OrdCadastro.eof then
  begin
    OrdCadastro.Insert;
    OrdCadastro.FieldByName('EMPFIL').AsInteger := VpaEmpfil;
    OrdCadastro.FieldByName('SEQROM').AsInteger := VpaSeqRomaneio;
    OrdCadastro.FieldByName('SEQNOT').AsInteger := VpaSeqNota;
    OrdCadastro.FieldByName('FILNOT').AsInteger := VpaCodFilialNota;
    OrdCadastro.Post;
    result := OrdCadastro.AMensagemErroGravacao;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.BaixaRomaneioGenerico(VpaCodFilial, VpaSeqRomaneio, VpaSeqNota : Integer;VpaNumNota : string) : string;
var
  VpfOP, VpfSeqFracao : Integer;
  VpfCotacoes : TStringList;
begin
  result := '';
  VpfCotacoes := TStringList.Create;
  AdicionaSQLAbreTabela(OrdOrdemProducao,'select ROI.CODFILIAL, ROI.SEQORDEM, ROI.SEQFRACAO, '+
                                         ' OP.LANORC, OP.ITEORC,  OP.UNMPED,OP.SEQPRO, '+
                                         ' COL.QTDCOLETADO, COL.DESUM '+
                                         ' from ROMANEIOPRODUTOITEM ROI, ORDEMPRODUCAOCORPO OP, COLETAROMANEIOOP COL '+
                                         ' WHERE ROI.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                         ' AND ROI.SEQROMANEIO = '+ IntToStr(VpaSeqRomaneio)+
                                         ' AND ROI.CODFILIAL = OP.EMPFIL '+
                                         ' AND ROI.SEQORDEM = OP.SEQORD '+
                                         ' AND ROI.CODFILIAL = COL.CODFILIAL '+
                                         ' AND ROI.SEQORDEM = COL.SEQORDEM '+
                                         ' AND ROI.SEQFRACAO = COL.SEQFRACAO '+
                                         ' AND ROI.SEQCOLETA = COL.SEQCOLETA '+
                                         ' ORDER BY ROI.CODFILIAL, ROI.SEQORDEM, ROI.SEQFRACAO');
  VpfOp := -1;
  While not OrdOrdemProducao.Eof do
  begin
    if (VpfOP <>OrdOrdemProducao.FieldByName('SEQORDEM').AsInteger) or (VpfSeqFracao <>OrdOrdemProducao.FieldByName('SEQFRACAO').AsInteger) then
    begin
      VpfOP := OrdOrdemProducao.FieldByName('SEQORDEM').AsInteger;
      VpfSeqFracao := OrdOrdemProducao.FieldByName('SEQFRACAO').AsInteger;
      ZeraQtdaFaturarFracao(OrdOrdemProducao.FieldByName('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByName('SEQORDEM').AsInteger,OrdOrdemProducao.FieldByName('SEQFRACAO').AsInteger);
    end;
    if OrdOrdemProducao.FieldByName('ITEORC').AsInteger <> 0 then
    begin
      if VpfCotacoes.IndexOf(OrdOrdemProducao.FieldByName('LANORC').AsString)< 0 then
      begin
        VpfCotacoes.Add(OrdOrdemProducao.FieldByName('LANORC').AsString);
        result := AdicionaNotaRomaneionoOrcamento(VpaCodFilial,VpaSeqNota,OrdOrdemProducao.FieldByName('LANORC').AsInteger,VpaNumNota);
      end;
      if result = '' then
        Result := BaixaRomaneioMovOrcamento(VpaCodFilial,OrdOrdemProducao.FieldByName('LANORC').AsInteger,OrdOrdemProducao.FieldByName('ITEORC').AsInteger,
                                            OrdOrdemProducao.FieldByName('SEQPRO').AsInteger,OrdOrdemProducao.FieldByName('DESUM').AsString,
                                            OrdOrdemProducao.FieldByName('UNMPED').AsString,OrdOrdemProducao.FieldByName('QTDCOLETADO').AsFloat,false);
    end;
    if result <> '' then
      OrdOrdemProducao.last;
    OrdOrdemProducao.next;
  end;
  VpfCotacoes.free;
  if result = '' then
  begin
    AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOCORPO '+
                                    ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                                    ' and SEQROM = '+IntToStr(VpaSeqRomaneio));
    OrdCadastro.Edit;
    OrdCadastro.FieldByName('DATFIM').AsDateTime := now;
    OrdCadastro.FieldByName('NOTGER').AsString := 'S';
    OrdCadastro.FieldByName('NRONOT').AsString := VpaNumNota;
    OrdCadastro.FieldByName('SEQNOT').AsInteger := VpaSeqNota;
    OrdCadastro.FieldByName('DATNOT').AsDateTime := now;
    OrdCadastro.post;
    OrdCadastro.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.BaixaConsumoFracaoAlteraEstagio(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer):string;
var
  VpfFracao : TRBDFracaoOrdemProducao;
  VpfConsumos : Tlist;
  VpfLaco : Integer;
  VpfDConsumoFracao : TRBDConsumoFracaoOP;
begin
  result := '';
  if config.BaixarConsumonaAlteracaoEstagioOP then
  begin
    VpfFracao := cardfracaoop(nil,VpaCodFilial,VpaSeqOrdemProducao,VpaSeqFracao);
    if not VpfFracao.IndConsumoBaixado then
    begin
      VpfConsumos := TList.create;
      FunProdutos.CarDBaixaConsumoProduto(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqFracao,true,VpfConsumos);
      for VpfLaco := 0 to VpfConsumos.Count - 1 do
      begin
        VpfDConsumoFracao := TRBDConsumoFracaoOP(VpfConsumos.Items[VpfLaco]);
        VpfDConsumoFracao.QtdABaixar := VpfDConsumoFracao.QtdProduto - VpfDConsumoFracao.QtdBaixado;
      end;
      FunProdutos.GravaBaixaConsumoProduto1(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqFracao,varia.CodigoUsuario, true,VpfConsumos);

      FreeTObjectsList(VpfConsumos);
      FunProdutos.CarDBaixaConsumoProduto(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqFracao,false,VpfConsumos);
      for VpfLaco := 0 to VpfConsumos.Count - 1 do
      begin
        VpfDConsumoFracao := TRBDConsumoFracaoOP(VpfConsumos.Items[VpfLaco]);
        if not VpfDConsumoFracao.IndOrigemCorte then
          VpfDConsumoFracao.QtdABaixar := VpfDConsumoFracao.QtdProduto - VpfDConsumoFracao.QtdBaixado;
      end;
      FunProdutos.GravaBaixaConsumoProduto1(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqFracao,varia.CodigoUsuario, false,VpfConsumos);

      FreeTObjectsList(VpfConsumos);
      VpfConsumos.free;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.BaixaEstoqueConsumoFracaoOP(VpaCodFilial : Integer;VpaConsumos : TList):string;
var
  VpfLaco : Integer;
  VpfDConsumoFracao : TRBDConsumoFracaoOP;
begin
  for VpfLaco := 0 to VpaConsumos.Count - 1 do
  begin
    VpfDConsumoFracao := TRBDConsumoFracaoOP(VpaConsumos.Items[VpfLaco]);
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExtornaRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio : Integer):String;
var
  VpfDOrdemProducao : TRBDordemProducao;
  VpfDColetaRomaneio : TRBDColetaRomaneioOp;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdOrdemProducao,'select ROI.CODFILIAL, ROI.SEQORDEM, ROI.SEQFRACAO, '+
                                         ' OP.LANORC, OP.ITEORC,  OP.UNMPED,OP.SEQPRO, '+
                                         ' COL.QTDCOLETADO, COL.DESUM, COL.SEQCOLETA '+
                                         ' from ROMANEIOPRODUTOITEM ROI, ORDEMPRODUCAOCORPO OP, COLETAROMANEIOOP COL '+
                                         ' WHERE ROI.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                         ' AND ROI.SEQROMANEIO = '+ IntToStr(VpaSeqRomaneio)+
                                         ' AND ROI.CODFILIAL = OP.EMPFIL '+
                                         ' AND ROI.SEQORDEM = OP.SEQORD '+
                                         ' AND ROI.CODFILIAL = COL.CODFILIAL '+
                                         ' AND ROI.SEQORDEM = COL.SEQORDEM '+
                                         ' AND ROI.SEQFRACAO = COL.SEQFRACAO '+
                                         ' AND ROI.SEQCOLETA = COL.SEQCOLETA ');
  While not OrdOrdemProducao.Eof do
  begin
    VpfDOrdemProducao := TRBDOrdemProducao.cria;
    CarDOrdemProducaoBasica(OrdOrdemProducao.FieldByName('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByName('SEQORDEM').AsInteger,VpfDOrdemProducao);
    VpfDColetaRomaneio := TRBDColetaRomaneioOp.cria;
    CarDColetaRomaneioOP(VpfDColetaRomaneio,OrdOrdemProducao.FieldByName('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByName('SEQORDEM').AsInteger,
                         OrdOrdemProducao.FieldByName('SEQFRACAO').AsInteger,OrdOrdemProducao.FieldByName('SEQCOLETA').AsInteger);
    AdicionaQtdAFaturarFracao(VpfDColetaRomaneio,VpfDOrdemProducao,true);
    VpfDOrdemProducao.free;
    VpfDColetaRomaneio.free;
    if OrdOrdemProducao.FieldByName('ITEORC').AsInteger <> 0 then
    begin
      if result = '' then
        Result := BaixaRomaneioMovOrcamento(VpaCodFilial,OrdOrdemProducao.FieldByName('LANORC').AsInteger,OrdOrdemProducao.FieldByName('ITEORC').AsInteger,
                                            OrdOrdemProducao.FieldByName('SEQPRO').AsInteger,OrdOrdemProducao.FieldByName('DESUM').AsString,
                                            OrdOrdemProducao.FieldByName('UNMPED').AsString,OrdOrdemProducao.FieldByName('QTDCOLETADO').AsFloat,true);
    end;
    if result <> '' then
      OrdOrdemProducao.last;
    OrdOrdemProducao.next;
  end;
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOCORPO '+
                                  ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                                  ' and SEQROM = '+IntToStr(VpaSeqRomaneio));
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('DATFIM').AsDateTime := now;
  OrdCadastro.FieldByName('NOTGER').AsString := 'N';
  OrdCadastro.FieldByName('NRONOT').Clear;
  OrdCadastro.FieldByName('SEQNOT').Clear;
  OrdCadastro.FieldByName('DATNOT').Clear;
  OrdCadastro.post;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExtornaPlanoCortecomImpresso(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
var
  VpfLacoItem, VpfLacoFracao : Integer;
  VpfDItemPlanoCorte : TRBDPlanoCorteItem;
  vpfdFracao : TRBDPlanoCorteFracao;
begin
  for VpfLacoItem := 0 to VpaDPlanoCorte.Itens.Count - 1 do
  begin
    VpfDItemPlanoCorte := TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLacoItem]);
    for VpfLacoFracao := 0 to VpfDItemPlanoCorte.Fracoes.Count - 1 do
    begin
      VpfDFracao := TRBDPlanoCorteFracao(VpfDItemPlanoCorte.Fracoes.Items[VpfLacoFracao]);
      FunOrdemProducao.SetaPlanoCorteGerado(VpfDFracao.CodFilial,VpfDFracao.SeqOrdem,VpfDFracao.SeqFracao,false);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.FinalizarRomaneio(VpaFilial, VpaSeqRomaneio : String);
begin
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from ROMANEIOCORPO '+
                                    ' Where EMPFIL = '+VpaFilial+
                                    ' AND SEQROM = '+ VpaSeqRomaneio);
  OrdCadastro.Edit;
  OrdCadastro.FieldByName('DATFIM').AsDateTime := now;
  OrdCadastro.Post;
  OrdCadastro.close;
  ExecutaComandoSql(OrdAux,'Update CADFILIAIS '+
                           ' Set I_SEQ_ROM = 0 '+
                           ' Where I_EMP_FIL = '+ VpaFilial);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.FinalizaFracaoFraccionista(VpaCodFaccionista,VpaSeqItem : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from FRACAOOPFACCIONISTA '+
                                    ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                                    ' AND SEQITEM = '+IntToStr(VpaSeqItem));
  OrdCadastro.edit;
  OrdCadastro.FieldByname('DATFINALIZACAO').AsDateTime := now;
  OrdCadastro.post;
  result := OrdCadastro.AMensagemErroGravacao;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.GeraOPdaCotacao(VpaDCotacao : TRBDOrcamento;VpaDOP : TRBDOrdemProducao);
begin
  with VpaDOp do
  begin
    CodEmpresafilial := VpaDCotacao.CodEmpFil;
    CodEstagio := varia.EstagioOrdemProducao;
    if varia.TipoOrdemProducao = toAgrupada then
      codCliente := Varia.CODCLIENTEOP
    else
    begin
      CodCliente := VpaDCotacao.CodCliente;
      NumPedido := VpaDCotacao.LanOrcamento;
      LanOrcamento := VpaDCotacao.LanOrcamento;
      DesOrdemCompra := VpaDCotacao.OrdemCompra;
      DesObservacoes := VpaDCotacao.DesObservacao.text;
    end;
    DatEmissao := now;
    DatEntregaPrevista := VpaDCotacao.DatPrevista;
    CodProgramador := varia.CodigoUsuario;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.GeraFracoesOP(VpaDOrdemProducao : TRBDOrdemProducao);
var
  VpfLaco : Integer;
  VpfDFracaoOP : TRBDFracaoOrdemProducao;
begin
  FreeTObjectsList(VpaDOrdemProducao.Fracoes);
  For VpfLaco := 1 to VpaDOrdemProducao.QtdFracoes do
  begin
    VpfDFracaoOP := VpaDOrdemProducao.AddFracao;
    VpfDFracaoOP.DatEntrega := VpaDOrdemProducao.DatEntrega;
    VpfDFracaoOP.QtdProduto :=  VpaDOrdemProducao.QtdProduto / VpaDOrdemProducao.QtdFracoes;
    VpfDFracaoOP.CodEstagio := Varia.EstagioOrdemProducao;
    VpfDFracaoOP.SeqFracao := VpfLaco;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.GeraConsumoOP(VpaDOrdemProducao : TRBDordemProducao);
begin                              
  GeraConsumoOPAgrupada(VpaDOrdemProducao);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.GeraImpressaoConsumoFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaListaAExcluir : Boolean);
var
  VpfConsumo : TList;
  VpfResultado : String;
begin
  ExecutaComandoSql(OrdAux,'DELETE FROM IMPRESSAOCONSUMOFRACAO');
  //carrega o consumo de materiais da fracao principal
  VpfConsumo := TList.create;
  FunProdutos.CarDBaixaFracaoConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,false,VpfConsumo,false,VpaListaAExcluir);
  if VpfConsumo.Count > 0 then
    VpfResultado := GravaDImpressaoConsumoFracao(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpfConsumo);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  FreeTObjectsList(VpfConsumo);
  VpfConsumo.free;
  //carrega o consumo das fracoes filhas
  AdicionaSQLAbreTabela(OrdTabela,'Select * from FRACAOOP '+
                                  ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                                  ' AND SEQFRACAOPAI = '+IntToStr(VpaSeqFracao));
  while not OrdTabela.eof do
  begin
    VpfConsumo := TList.create;
    FunProdutos.CarDBaixaFracaoConsumoProduto(OrdTabela.FieldByName('CODFILIAL').AsInteger,OrdTabela.FieldByName('SEQORDEM').AsInteger,OrdTabela.FieldByName('SEQFRACAO').AsInteger,false,VpfConsumo,true,VpaListaAExcluir);
    VpfResultado := GravaDImpressaoConsumoFracao(OrdTabela.FieldByName('CODFILIAL').AsInteger,OrdTabela.FieldByName('SEQORDEM').AsInteger,OrdTabela.FieldByName('SEQFRACAO').AsInteger,VpfConsumo);
    if VpfResultado <> '' then
      aviso(VpfResultado);
    FreeTObjectsList(VpfConsumo);
    VpfConsumo.free;
    OrdTabela.Next;
  end;
  OrdTabela.next;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ReImportaFracao(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer): string;
var
  VpfDOrdemProducao : TRBDOrdemProducao;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if varia.EstagioOPReimportada = 0  then
    result := 'FALTA PREENCHER O ESTAGIO DE REIMPORTAÇÃO DO PROJETO!!!'#13'É necessário informar o estagio de reimportação do projeto nas configurações do produto.';
  if result = '' then
  begin
    VpfDOrdemProducao := TRBDOrdemProducao.cria;
    VpfDOrdemProducao.CodEmpresafilial := VpaCodFilial;
    VpfDOrdemProducao.SeqOrdem := VpaSeqOrdem;
    VpfDProduto := TRBDProduto.Cria;
    VpfDFracao := CarDFracaoOP(nil,VpaCodFilial,VpaSeqOrdem,VpaSeqFracao);
    CarDOrdemSerra(VpfDOrdemProducao,0,0);
    FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaCodFilial,VpfDFracao.SeqProduto);
    CarDFracaoOPEstagio(VpfDFracao,VpaCodFilial,VpaSeqOrdem);
    FunProdutos.CarDEstagio(VpfDProduto);

    result := ReImportaFracaoVerificaEstagioFracao(VpfDFracao,VpfDProduto);
    if result = '' then
    begin
      result := ReImportaFracaoConsumoOP(VpfDOrdemProducao,VpfDFracao,VpfDProduto);
      if result = '' then
      begin
        result := ReImportaFracoesFilhas(VpfDOrdemProducao,VpfDFracao,VpfDProduto);
      end;

    end;



    if result = '' then
    begin
      AdicionaLogReimportacaoFracao(VpfDFracao);
      result := GravaDFracaoOPEstagio(VpfDFracao,VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqProduto,true);
      if result = '' then
      begin
        result := GravaDConsumoFracoes(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao);
        if result = '' then
          result := GravaDOrdemSerra(VpfDOrdemProducao);
      end;
    end;
    VpfDProduto.Free;
    VpfDFracao.Free;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ReImportaFracaoConsumoOP(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao: TRBDFracaoOrdemProducao; VpaDProduto: TRBDProduto): string;
var
  VpfLacoFracao, VpfLacoProduto : Integer;
  VpfDConsumoFracao : TRBDConsumoOrdemProducao;
  VpfDConsumoProduto : TRBDConsumoMP;
begin
  result := '';

  CarDConsumoFracao(VpaDFracao);
  FunProdutos.CarConsumoProduto(VpaDProduto,VpaDFracao.CodCor);
  FunProdutos.ApagaSubMontagensdaListaConsumo(VpaDProduto);

  for VpfLacoFracao := VpaDFracao.Consumo.Count - 1 downto 0 do
  begin
    VpfDConsumoFracao := TRBDConsumoOrdemProducao(VpaDFracao.Consumo.Items[VpfLacoFracao]);
    if not VpfDConsumoFracao.IndExcluir then
    begin
      VpfDConsumoFracao.IndExcluir := true;
      for VpfLacoProduto := VpaDProduto.ConsumosMP.Count - 1 downto 0 do
      begin
        VpfDConsumoProduto := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoProduto]);
        if (VpfDConsumoFracao.SeqProduto = VpfDConsumoProduto.SeqProduto) and
           (VpfDConsumoFracao.CodCor = VpfDConsumoProduto.CodCor) and
           (VpfDConsumoFracao.LarMolde = VpfDConsumoProduto.LarguraMolde) and
           (VpfDConsumoFracao.AltMolde = VpfDConsumoProduto.AlturaMolde) and
           (VpfDConsumoFracao.QtdUnitario = VpfDConsumoProduto.QtdProduto)  then
        begin
          VpfDConsumoFracao.IndExcluir := false;
          VpaDProduto.ConsumosMP.Delete(VpfLacoProduto);
          break;
        end;
      end;
      if VpfDConsumoFracao.IndExcluir then
      begin
        if (VpfDConsumoFracao.QtdReservada = 0) and
           (VpfDConsumoFracao.QtdBaixado = 0)  then
        begin
          //estorna qtd a reserver do estoque;
          if VpfDConsumoFracao.QtdAReservar > 0 then
          begin
            FunProdutos.BaixaQtdAReservarProduto(VpaDFracao.Codfilial,VpfDConsumoFracao.SeqProduto,VpfDConsumoFracao.CodCor,0,
                                           VpfDConsumoFracao.QtdAReservar,VpfDConsumoFracao.UM,VpfDConsumoFracao.UMOriginal,
                                           'S');
          end;
          VpaDFracao.Consumo.Delete(VpfLacoFracao);
          //tem que excluir da ordem de serra e da ordem do pantografo
        end;
        if ((UpperCase(VpfDConsumoFracao.UM) = 'MT') or (UpperCase(VpfDConsumoFracao.UM) = 'CM') or (UpperCase(VpfDConsumoFracao.UM) = 'MM')) and
           (VpfDConsumoFracao.LarMolde = 0) and (VpfDConsumoFracao.AltMolde = 0) and
           (VpfDConsumoFracao.CodFaca = 0)  then
           ExcluiProdutoOrdemSerra(VpaDOrdemProducao,VpaDFracao,VpfDConsumoFracao);
      end;
    end;
  end;
  //adiciona as materia prima a mais;
  if VpaDProduto.ConsumosMP.Count > 0 then
    GeraConsumoFracao(VpaDOrdemProducao,VpaDFracao,VpaDProduto);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ReImportaFracaoVerificaEstagioFracao(VpaDFracao: TRBDFracaoOrdemProducao; VpaDProduto: TRBDProduto): string;
var
  VpfLacoProduto : Integer;
  VpfDEstagioProduto : TRBDEstagioProduto;
  VpfDEstagioFracao : TRBDordemProducaoEstagio;
begin
  result := '';
  //compara se os estagios da fracao são os mesmos dos estagios do produto;
  for VpflacoProduto := 0 to VpaDProduto.Estagios.Count - 1 do
  begin
    VpfDEstagioProduto := TRBDEstagioProduto(VpaDProduto.Estagios.Items[VpfLacoProduto]);
    if VpfLacoProduto < VpaDFracao.Estagios.Count then
    begin
      VpfDEstagioFracao := TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLacoProduto]);
      While (VpfDEstagioProduto.CodEstagio <> VpfDEstagioFracao.CodEstagio) and
            ( VpfLacoProduto < VpaDFracao.Estagios.Count) do
        VpaDFracao.Estagios.Delete(VpfLacoProduto);
    end;
  end;
  //Se no novo produto possui menos estagios, exclui os estagios a mais da fracao;
  while VpaDFracao.Estagios.Count > VpaDProduto.Estagios.Count do
    VpaDFracao.Estagios.Delete(VpaDProduto.Estagios.Count - 1);
  //adiciona os estagios do produto que foram colocados a mais;
  while VpaDFracao.Estagios.Count < VpaDProduto.Estagios.Count do
  begin
    VpfDEstagioProduto := TRBDEstagioProduto(VpaDProduto.Estagios.Items[VpaDFracao.Estagios.Count]);
    VpfDEstagioFracao := VpaDFracao.AddEstagio;
    VpfDEstagioFracao.CodEstagio := VpfDEstagioProduto.CodEstagio;
    VpfDEstagioFracao.SeqEstagio := VpfDEstagioProduto.SeqEstagio;
    VpfDEstagioFracao.DesEstagio := VpfDEstagioProduto.DesEstagio;
    VpfDEstagioFracao.SeqEstagioAnterior := VpfDEstagioProduto.CodEstagioAnterior;
    VpfDEstagioFracao.QtdCelula := 1;
    VpfDEstagioFracao.NumOrdem := VpfDEstagioProduto.NumOrdem;
    FunProdutos.ExisteEstagio(IntToStr(VpfDEstagioFracao.CodEstagio),VpfDEstagioFracao.NomEstagio);
    VpfDEstagioFracao.QtdHoras := RQtdHorasEstagio(VpfDEstagioFracao,VpfDEstagioProduto,VpaDFracao.QtdProduto);
  end;
  //reordena o seqestagio da fracao;
  for VpfLacoProduto := 0 to VpaDFracao.Estagios.Count - 1 do
  begin
    VpfDEstagioProduto := TRBDEstagioProduto(VpaDProduto.Estagios.Items[VpfLacoProduto]);
    VpfDEstagioFracao := TRBDordemProducaoEstagio(VpaDFracao.Estagios.Items[VpfLacoProduto]);
    VpfDEstagioFracao.SeqEstagio := VpfDEstagioProduto.SeqEstagio;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ReImportaFracoesFilhas(VpaDOrdemProducao: TRBDOrdemProducao; VpaDFracao: TRBDFracaoOrdemProducao;
  VpaDProduto: TRBDProduto): string;
Var
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTabela : TSQLQuery;
  VpfDOPProduto : TRBDOrdemProducao;
  VpfLaco : Integer;
  VpfExcluir : Boolean;
begin
  VpfTabela := TSQLQUERY.Create(nil);
  VpfTabela.SQLConnection := ordCadastro.ASqlConnection;

  AdicionaProdutosSubMontagem(VpaDOrdemProducao,VpaDFracao,nil,false);


  AdicionaSQLAbreTabela(VpfTabela,'Select CODFILIAL, SEQORDEM, SEQFRACAO '+
                                  ' From FRACAOOP '+
                                  ' Where CODFILIAL = '+IntToStr(VpaDFracao.CodFilial)+
                                  ' AND SEQORDEM = '+IntToStr(VpaDFracao.SeqOrdemProducao)+
                                  ' AND SEQFRACAOPAI = '+IntToStr(VpaDFracao.SeqFracao));
  while not VpfTabela.Eof do
  begin
    VpfExcluir := true;
    for VpfLaco := VpfDOPProduto.Fracoes.Count - 1 downto  0 do
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(VpfDOPProduto.Fracoes.Items[VpfLaco]);
      if (VpfDFracao.SeqProduto = VpfTabela.FieldByName('SEQPRODUTO').AsInteger) AND
         (VpfDFracao.CodCor = VpfTabela.FieldByName('CODCOR').AsInteger) then
      begin
        VpfExcluir := false;
        ReImportaFracao(VpfTabela.FieldByName('CODFILIAL').AsInteger,VpfTabela.FieldByName('SEQORDEM').AsInteger,VpfTabela.FieldByName('SEQFRACAO').AsInteger);
        VpfDOPProduto.Fracoes.Delete(VpfLaco);
        Break;
      end;
    end;
    if VpfExcluir then
    begin
      result := ExcluiFracaoOP(VpfTabela.FieldByName('CODFILIAL').AsInteger,VpfTabela.FieldByName('SEQORDEM').AsInteger,VpfTabela.FieldByName('SEQFRACAO').AsInteger);
    end;


    VpfTabela.next;
  end;
  VpfTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.SetaRomaneioGeradoNota(VpaEmpFil, VpaSeqRomaneio: String);
begin
  ExecutaComandoSql(OrdAux,'Update ROMANEIOCORPO '+
                           ' Set NOTGER = ''S'''+
                           ' Where EMPFIL = '+ VpaEmpFil+
                           ' and SEQROM = '+ VpaSeqRomaneio);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.SetaRomaneioImpresso(VpaEmpFil, VpaSeqRomaneio : String);
begin
  ExecutaComandoSql(OrdAux,'Update ROMANEIOCORPO '+
                           ' Set INDIMP = ''S'''+
                           ' Where EMPFIL = '+ VpaEmpFil+
                           ' and SEQROM = '+ VpaSeqRomaneio);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.SetaFichaConsumoImpressa(VpaCodFilial, VpaSeqOrdem : Integer);
begin
  AdicionaSqlAbreTabela(OrdCadastro,'Select * from FRACAOOP '+
                                    ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                    ' and SEQORDEM = '+ IntToStr(VpaSeqOrdem));
  While not OrdCadastro.eof do
  begin
    OrdCadastro.edit;
    OrdCadastro.FieldByName('DATIMPRESSAOFICHA').AsDateTime := Now;
    OrdCadastro.post;
    OrdCadastro.next;
  end;
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.SetaPlanoCorteGerado(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaGerado : Boolean);
begin
  AdicionaSqlAbreTabela(OrdCadastro,'Select * from FRACAOOP '+
                                    ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                    ' and SEQORDEM = '+ IntToStr(VpaSeqOrdem)+
                                    ' and SEQFRACAO = '+IntToStr(VpaSeqFracao));
  OrdCadastro.edit;
  if VpaGerado then
    OrdCadastro.FieldByname('INDPLANOCORTE').AsString := 'S'
  else
    OrdCadastro.FieldByname('INDPLANOCORTE').AsString := 'N';
  OrdCadastro.post;
  if OrdCadastro.AErronaGravacao then
    aviso(OrdCadastro.AMensagemErroGravacao);
  OrdCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExcluiRevisaoExterna(VpaEmpFil,VpaSeqOrdem, VpaSeqColeta,VpaCodUsuario : String);
begin
  ExecutaComandoSql(OrdAux,'Delete from REVISAOOPEXTERNA '+
                           ' Where EMPFIL = '+ VpaEmpFil+
                           ' and SEQORD = '+ VpaSeqOrdem+
                           ' and SEQCOL = '+VpaSeqColeta+
                           ' AND CODUSU = '+ VpaCodUsuario);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExcluiOrdemProducao(VpaCodFilial, VpaSeqOrdem : Integer):String;
begin
  result := '';
   ExecutaComandoSql(OrdAux,'DELETE FROM ORDEMCORTEITEM '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEMPRODUCAO = '+IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM ORDEMCORTECORPO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEMPRODUCAO = '+IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM ORDEMSERRAFRACAO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEMPRODUCAO = '+IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM ORDEMSERRA '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEMPRODUCAO = '+IntToStr(VpaSeqOrdem));
  Sistema.GravaLogExclusao('ORDEMPRODUCAOCORPO','Select * From ORDEMPRODUCAOCORPO '+
                           ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                           ' AND SEQORD = ' +IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOPESTAGIOREAL '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEM = '+IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOPESTAGIO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEM = '+IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOPCOMPOSE '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEM = '+IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOP '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORDEM = '+IntToStr(VpaSeqOrdem));
   ExecutaComandoSql(OrdAux,'DELETE FROM ORDEMPRODUCAOCORPO '+
                            ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                            '  AND SEQORD = '+IntToStr(VpaSeqOrdem));
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExcluiFracaoOP(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer):String;
begin
  result := '';
  Sistema.GravaLogExclusao('ORDEMPRODUCAOCORPO','Select * From FRACAOOP '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' AND SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                           ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOPESTAGIOREAL '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' AND SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                           ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOPESTAGIO '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' AND SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                           ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOPCOMPOSE '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' AND SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                           ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
   ExecutaComandoSql(OrdAux,'DELETE FROM FRACAOOP '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' AND SEQORDEM = ' +IntToStr(VpaSeqOrdem)+
                           ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExcluiColetaFracaoOP(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqEstagio, VpaSeqColeta : Integer);
var
  VpfCodCelula : Integer;
  VpfDatColeta : TDateTime;
begin
  Sistema.GravaLogExclusao('COLETAFRACAOOP','Select * from COLETAFRACAOOP '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                           ' and SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                           ' and SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                           ' and SEQESTAGIO = '+IntToStr(VpaSeqEstagio)+
                           ' and SEQCOLETA = '+IntToStr(VpaSeqColeta));
  AdicionaSqlAbreTabela(OrdCadastro2,'Select * from COLETAFRACAOOP '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                           ' and SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                           ' and SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                           ' and SEQESTAGIO = '+IntToStr(VpaSeqEstagio)+
                           ' and SEQCOLETA = '+IntToStr(VpaSeqColeta));
  VpfCodCelula := OrdCadastro2.FieldByName('CODCELULA').AsInteger;
  VpfDatColeta := OrdCadastro2.FieldByName('DATINICIO').AsDateTime;
  BaixaQtdFracaoOPEstagio(OrdCadastro2.FieldByName('CODFILIAL').AsInteger,OrdCadastro2.FieldByName('SEQORDEM').AsInteger,OrdCadastro2.FieldByName('SEQFRACAO').AsInteger,
                          OrdCadastro2.FieldByName('SEQESTAGIO').AsInteger,OrdCadastro2.FieldByName('QTDCOLETADO').AsFloat,true);
  OrdCadastro2.Delete;
  OrdCadastro2.close;
  ProcessaProdutividadeCelula(VpfCodCelula,VpfDatColeta);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExcluiColetaRomaneioOP(VpaCodFilial,VpaSeqRomaneio,VpaSeqOrdem,VpaSeqFracao,VpaSeqColeta : Integer):string;
var
  VpfDColetaRomaneio : TRBDColetaRomaneioOp;
  VpfDOP : TRBDOrdemProducao;
begin
  result := '';
  VpfDColetaRomaneio := TRBDColetaRomaneioOp.cria;
  CarDColetaRomaneioOP(VpfDColetaRomaneio,VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqColeta);
  VpfDOP := TRBDOrdemProducao.cria;
  CarDOrdemProducaoBasica(VpaCodFilial,VpaSeqOrdem,VpfDOP);
  result := AdicionaQtdAFaturarFracao(VpfDColetaRomaneio,VpfDOP,true);
  if result = '' then
    result := EliminaColetaFracaoOPRomaneio(VpaSeqRomaneio,VpfDColetaRomaneio,VpfDOP);


  VpfDOP.free;
  VpfDColetaRomaneio.free;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExcluiFracaoFaccionista(VpaCodFaccionista,VpaSeqItem : Integer);
var
  VpfResultado : String;
begin
  VpfResultado := ExtornaAtualizacaoEnvioFaccionista(VpaCodFaccionista,VpaSeqItem);
  if VpfResultado = '' then
  begin
    ExecutaComandoSql(OrdAux,'Delete from FRACAOOPFACCIONISTA '+
                           ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                           ' and SEQITEM = '+IntToStr(VpaSeqItem));
  end
  else
    aviso(vpfREsultado);
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExcluiRetornoFracaoFaccionista(VpaCodFaccionista,VpaSeqItem, VpaSeqRetorno : Integer);
var
  VpfResultado : String;
begin
  VpfResultado := ExtornaAtualizacoesRetornoFaccionista(VpaCodFaccionista,VpaSeqItem,VpaSeqRetorno);
  if VpfResultado = '' then
  begin
    ExecutaComandoSql(OrdAux,'Delete from RETORNOFRACAOOPFACCIONISTA '+
                           ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                           ' and SEQITEM = '+IntToStr(VpaSeqItem)+
                           ' and SEQRETORNO = '+IntToStr(VpaSeqRetorno));
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExcluiDevolucaoFracaoFaccionista(VpaCodFaccionista,VpaSeqItem,VpaSeqDevolucao : Integer):string;
var
  VpfResultado : String;
begin
  VpfResultado := ExtornaAtualizacoesDevolucaoFaccionista(VpaCodFaccionista,VpaSeqItem,VpaSeqDevolucao);
  if VpfResultado = '' then
  begin
    ExecutaComandoSql(OrdAux,'Delete from DEVOLUCAOFRACAOOPFACCIONISTA '+
                           ' Where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista)+
                           ' and SEQITEM = '+IntToStr(VpaSeqItem)+
                           ' and SEQDEVOLUCAO = '+IntToStr(VpaSeqDevolucao));
  end
  else
    aviso(VpfResultado);
  result := VpfResultado;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ExcluiPlanoCorte(VpaCodFilial, VpaSeqPlanoCorte : Integer);
var
  VpfDPlanoCorte : TRBDPlanoCorteCorpo;
begin
  VpfDPlanoCorte := TRBDPlanoCorteCorpo.cria;
  CarDPlanoCorte(VpfDPlanoCorte,VpaCodFilial,VpaSeqPlanoCorte);
  ExtornaPlanoCortecomImpresso(VpfDPlanoCorte);

  ExecutaComandoSql(OrdAux,'Delete FROM PLANOCORTEFRACAO '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQPLANOCORTE = '+IntToStr(VpaSeqPlanoCorte));
  ExecutaComandoSql(OrdAux,'Delete FROM PLANOCORTEITEM '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQPLANOCORTE = '+IntToStr(VpaSeqPlanoCorte));
  ExecutaComandoSql(OrdAux,'Delete FROM PLANOCORTECORPO '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQPLANOCORTE = '+IntToStr(VpaSeqPlanoCorte));
  VpfDPlanoCorte.free;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteMaquina(VpaCodMaquina : String;VpaDMaquina : TRBDOPItemMaquina) : Boolean;
begin
  result := false;
  if VpaCodMaquina <> '' then
  begin
    AdicionaSqlAbreTabela(OrdAux,'Select * from MAQUINA '+
                                 ' Where CODMAQ = '+ VpaCodMaquina);
    if not OrdAux.Eof then
    begin
      result := true;
      VpaDMaquina.CodMaquina := StrToInt(VpaCodMaquina);
      VpaDMaquina.NomMaquina := OrdAux.FieldByName('NOMMAQ').AsString;
    end;
    OrdAux.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteEstoqueCombinacao(VpaSeqProduto : Integer):Boolean;
begin
  OrdAux.Sql.Clear;
  OrdAux.Sql.Add('Select sum(abs(N_QTD_PRO)) QTD from MOVQDADEPRODUTO '+
                               ' Where I_SEQ_PRO = '+InttoStr(VpaSeqProduto));
  if config.EstoqueCentralizado then
    OrdAux.Sql.Add('and I_EMP_FIL = '+IntToStr(Varia.CodFilialControladoraEstoque))
  else
    OrdAux.Sql.Add('and I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil));
  OrdAux.Open;
  result := OrdAux.FieldByName('QTD').AsFloat <> 0;
  OrdAux.close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteEstagioCelulaDuplicado(VpaDCelula : TRBDCelulaTrabalho):Boolean;
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDEstagio : TRBDEstagioCelula;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDCelula.Estagios.Count - 2 do
  begin
    VpfDEstagio := TRBDEstagioCelula(VpaDCelula.Estagios.Items[VpfLacoexterno]);
    for VpfLacoInterno := VpfLacoExterno +1 to VpaDCelula.Estagios.count -1 do
    begin
      if VpfDEstagio.CodEstagio = TRBDEstagioCelula(VpaDCelula.Estagios.Items[VpfLacoInterno]).CodEstagio then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteHorarioCelulaDuplicado(VpaDCelula : TRBDCelulaTrabalho) : Boolean;
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDHorario : TRBDHorarioCelula;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDCelula.Horarios.Count - 2 do
  begin
    VpfDHorario := TRBDHorarioCelula(VpaDCelula.Horarios.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDCelula.Horarios.Count - 1 do
    begin
      if VpfDHorario.CodHorario = TRBDHorarioCelula(VpaDCelula.Horarios.Items[VpfLacoInterno]).CodHorario then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteHorarioTrabalho(VpaCodHorario : string;var VpaDesHoraInicio, VpaDesHoraFim : String):Boolean;
begin
  result := false;
  if VpaCodHorario <> '' then
  begin
    AdicionaSQLAbreTabela(OrdAux,'Select * from HORARIOTRABALHO '+
                                ' Where CODHORARIO = '+VpaCodHorario);
    result := not OrdAux.Eof;
    if result then
    begin
      VpaDesHoraInicio := OrdAux.FieldByName('DESHORAINICIO').AsString;
      VpaDesHoraFim := OrdAux.FieldByName('DESHORAFIM').AsString;
    end;
    OrdAux.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteFracaoFaccionista(VpaDFracaoFaccionista : TRBDFracaoFaccionista) : Boolean;
begin
  OrdAux.Sql.Clear;
  OrdAux.sql.add('Select CODFILIAL FROM FRACAOOPFACCIONISTA '+
                 ' Where CODFILIAL = ' +  IntToStr(VpaDFracaoFaccionista.CodFilial)+
                 ' and SEQORDEM = ' +IntToStr(VpaDFracaoFaccionista.SeqOrdem)+
                 ' and SEQFRACAO = ' +InttoStr(VpaDFracaoFaccionista.SeqFracao)+
                 ' and CODFACCIONISTA = '+IntToStr(VpaDFracaoFaccionista.CodFaccionista) );
  if VpaDFracaoFaccionista.SeqIDEstagio <> 0 then
    OrdAux.Sql.add('and SEQESTAGIO = ' +IntToStr(VpaDFracaoFaccionista.SeqIDEstagio))
  else
    OrdAux.SQL.ADD(' and SEQESTAGIO IS NULL');
  OrdAux.open;
  result := not ordAux.Eof;
  OrdAux.Close;
end;

{******************************************************************************}
function TRBFuncoesOrdemProducao.ExisteBastidor(VpaCodBastidor : Integer; VpaDOrdemCorteItem : TRBDOrdemCorteItem) : Boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(OrdAux,'Select BAS.CODBASTIDOR, BAS.NOMBASTIDOR, ' +
                                  ' MOB.QTDPECAS '+
                                  ' FROM BASTIDOR BAS, MOVKITBASTIDOR MOB '+
                                  ' Where BAS.CODBASTIDOR = MOB.CODBASTIDOR '+
                                  ' AND MOB.SEQPRODUTOKIT = '+IntToStr(VpaDOrdemCorteItem.SeqProdutoKit)+
                                  ' AND MOB.SEQCORKIT = '+ IntToStr(VpaDOrdemCorteItem.SeqCorKit)+
                                  ' AND MOB.SEQMOVIMENTO = '+IntToStr(VpaDOrdemCorteItem.SeqMovimentoKit)+
                                  ' AND MOB.CODBASTIDOR = '+IntToStr(VpaCodBastidor));
  result := not OrdAux.eof;
  if result then
  begin
    VpaDOrdemCorteItem.CodBastidor := VpaCodBastidor;
    VpaDOrdemCorteItem.NomBastidor := OrdAux.FieldByname('NOMBASTIDOR').AsString;
    VpaDOrdemCorteItem.QtdPecasBastidor := OrdAux.FieldByname('QTDPECAS').AsInteger;
  end;
  OrdAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ProcessaProdutividadeCelula(VpaCodCelula : Integer;VpaData : TDateTime);
begin
  ApagaProdutividadeCelula(VpaCodCelula,VpaData);
  AdicionaSQLAbreTabela(OrdCadastro,'Select * from PRODUTIVIDADECELULATRABALHO '+
                                    ' Where CODCELULA = 0' );
  OrdCadastro.Insert;
  OrdCadastro.FieldByName('DATPRODUTIVIDADE').AsDateTime := DataSemHora(VpaDAta);
  OrdCadastro.FieldByName('CODCELULA').AsInteger := VpaCodCelula;
  OrdCadastro.FieldByName('PERPRODUTIVIDADE').AsInteger := RProdutividadeCelula(VpaData,VpaCodCelula); ;
  if OrdCadastro.FieldByName('PERPRODUTIVIDADE').AsInteger = 0 then
    OrdCadastro.cancel
  else
    OrdCadastro.post;
  ordCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.RegeraFracaoOPEstagio(VpaSeqProduto : Integer);
var
  VpfDOP : TRBDOrdemProducao;
  VpfDNovaFracao, VpfDFracaoOP : TRBDFracaoOrdemProducao;
  VpfLacoFracao : Integer;
begin
  if varia.TipoOrdemProducao = toFracionada then
  begin
    LocalizaOPProduto(OrdOrdemProducao,VpaSeqProduto);
    While not OrdOrdemProducao.Eof do
    begin
      VpfDOP.free;
      VpfDOP := TRBDOrdemProducao.cria;
      CarDOrdemProducaoBasica(OrdOrdemProducao.FieldByName('EMPFIL').AsInteger,OrdOrdemProducao.FieldByName('SEQORD').AsInteger,VpfDOP);
      //se a quantidade de estagios do produto é a mesma quantidade da fracao, significa que não houve alteração na quantidade estagio e não é necessário reorganizar.
      for VpfLacoFracao := 0 to  VpfDOP.Fracoes.Count - 1 do
      begin
        VpfDFracaoOP := TRBDFracaoOrdemProducao(VpfDOP.Fracoes.Items[VpfLacoFracao]);
        VpfDNovaFracao := TRBDFracaoOrdemProducao.cria;
        CopiaQtdColetadoEstagio(VpfDFracaoOP,VpfDNovaFracao);
        AdicionaEstagiosOP(VpfDOP.DProduto,VpfDFracaoOP,false);
        ArrumaQtdProduzidaEstagio(VpfDNovaFracao,VpfDFracaoOP);
      end;
      GravaDOrdemProducaoBasicao(VpfDOP);
      OrdOrdemProducao.Next;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ImprimeEtiquetaFracao(VpaDOrdemProducao: TRBDordemProducao);
Var
  VpfFunZebra : TRBFuncoesZebra;
  VpfLaco, VpfPosicaoX, VpfColuna : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfEstagios : String;
begin
  if varia.ModeloEtiquetaNotaEntrada in [6] then
    VpfFunZebra := TRBFuncoesZebra.cria(varia.PortaComunicacaoImpTermica,176,lzEPL);
  VpfPosicaoX := 0;
  VpfColuna := 0;
  for VpfLaco := 0 to VpaDOrdemProducao.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDOrdemProducao.Fracoes.Items[VpfLaco]);
//     VpfPosicaoX := (VpfColuna * 276);
     VpfPosicaoX := (VpfColuna * 260);
     VpfFunZebra.ImprimeCodigoBarras(VpfPosicaoX+35,0,0,'2',2,4,40,true,FloatToStr(VpfDFracao.CodBarras));
     VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,70,0,1,1,2,false,VpfDFracao.CodProduto);
     VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,95,0,1,1,1,false,VpfDFracao.NomProduto);
     VpfEstagios := RTextoEstagiosFracao(VpfDFracao);
     VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,120,0,1,1,1,false,copy(VpfEstagios,1,25));
     if length(VpfEstagios) > 26 then
       VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,136,0,1,1,1,false,copy(VpfEstagios,26,length(VpfEstagios)-24));
     VpfFunZebra.ImprimeTexto(VpfPosicaoX+237,0,1,1,1,1,false,FormatDateTime('DD/MM',date));

     inc(VpfColuna);
     if  VpfColuna >= 3 then
     begin
       VpfColuna := 0;
       VpfFunZebra.FechaImpressao;
     end;
//     if VpfLaco > 50 then
//       Break;
  end;
  if VpfColuna <> 0 then
    VpfFunZebra.FechaImpressao;
  VpfFunZebra.free;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ImprimeEtiquetaOrdemSerra(VpaDOrdemProducao : TRBDordemProducao);
Var
  VpfFunZebra : TRBFuncoesZebra;
  VpfLacoOrdemSerra, VpfLacoFracao, VpfPosicaoX, VpfColuna : Integer;
  VpfDOrdemSerra : TRBDOrdemSerra;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfEstagios : String;
begin
  if varia.ModeloEtiquetaNotaEntrada in [6] then
    VpfFunZebra := TRBFuncoesZebra.cria(varia.PortaComunicacaoImpTermica,176,lzEPL);
  VpfPosicaoX := 0;
  VpfColuna := 0;
  for VpfLacoOrdemSerra := 0 to VpaDOrdemProducao.OrdensSerra.Count - 1 do
  begin
    VpfDOrdemSerra := TRBDOrdemSerra(VpaDOrdemProducao.OrdensSerra.Items[VpfLacoOrdemSerra]);
    for VpfLacoFracao := 0 to VpfDOrdemSerra.Fracoes.Count - 1 do
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(VpfDOrdemSerra.Fracoes.Items[VpfLacoFracao]);
      VpfPosicaoX := (VpfColuna * 284);
      VpfFunZebra.ImprimeCodigoBarras(VpfPosicaoX+35,0,0,'2',2,4,40,true,FloatToStr(VpfDFracao.CodBarras));
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,70,0,1,1,2,false,VpfDFracao.CodProduto);
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,95,0,1,1,1,false,VpfDFracao.NomProduto);
      VpfEstagios := RTextoEstagiosFracao(VpfDFracao);
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,120,0,1,1,1,false,copy(VpfEstagios,1,25));
      if length(VpfEstagios) > 26 then
        VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,136,0,1,1,1,false,copy(VpfEstagios,26,length(VpfEstagios)-24));
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+245,0,1,1,1,1,false,FormatDateTime('DD/MM/YY',VpaDOrdemProducao.DatEmissao));
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+195,145,0,1,2,2,false,IntToStr(VpfDOrdemSerra.SeqOrdemSerra));
       inc(VpfColuna);
      if  VpfColuna >= 3 then
      begin
        VpfColuna := 0;
        VpfFunZebra.FechaImpressao;
      end;
      AlteraEstagioFracaoOP(VpaDOrdemProducao.CodEmpresafilial,VpaDOrdemProducao.SeqOrdem,VpfdFracao.SeqFracao,varia.EstagioSerra);
    end;
  end;
  VpfFunZebra.FechaImpressao;
  VpfFunZebra.free;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ImprimeEtiquetasFracaoPremer(VpaEtiquetas : TList);
var
  VpfLaco : integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfDOrdemProducao : TRBDordemProducao;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  VpfDOrdemProducao := TRBDOrdemProducao.cria;
  for VpfLaco := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLaco]);
    AdicionaSQLAbreTabela(OrdOrdemProducao,'Select * from FRACAOOP '+
                                    ' Where SEQPRODUTO = '+IntToStr(VpfDEtiqueta.Produto.SeqProduto));
    while not OrdOrdemProducao.eof do
    begin
      VpfDFracao := cardfracaoop(nil,OrdOrdemProducao.FieldByname('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByname('SEQORDEM').AsInteger,
                   OrdOrdemProducao.FieldByname('SEQFRACAO').AsInteger);
      CarDFracaoOPEstagio(VpfDFracao,OrdOrdemProducao.FieldByname('CODFILIAL').AsInteger,OrdOrdemProducao.FieldByname('SEQORDEM').AsInteger);
      VpfDOrdemProducao.Fracoes.Add(VpfDFracao);
      OrdOrdemProducao.Next;
    end;
    OrdOrdemProducao.close;
  end;
  ImprimeEtiquetaFracao(VpfDOrdemProducao);
  VpfDOrdemProducao.free;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ImprimeEtiquetasPlanoCorte(VpaDPlanoCorte : TRBDPlanoCorteCorpo);
Var
  VpfFunZebra : TRBFuncoesZebra;
  VpfLacoItem, VpfLacoFracao, VpfPosicaoX, VpfColuna : Integer;
  VpfDItemPlanoCorte : TRBDPlanoCorteItem;
  VpfDPlanoCorteFracao : TRBDPlanoCorteFracao;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfEstagios : String;
begin
  if varia.ModeloEtiquetaNotaEntrada in [6] then
    VpfFunZebra := TRBFuncoesZebra.cria(varia.PortaComunicacaoImpTermica,176,lzEPL);
  VpfPosicaoX := 0;
  VpfColuna := 0;
  for VpfLacoItem := 0 to VpaDPlanoCorte.Itens.Count - 1 do
  begin
    VpfDItemPlanoCorte := TRBDPlanoCorteItem(VpaDPlanoCorte.Itens[VpfLacoItem]);
    for VpfLacoFracao := 0 to VpfDItemPlanoCorte.Fracoes.Count - 1 do
    begin
      VpfDPlanoCorteFracao := TRBDPlanoCorteFracao(VpfDItemPlanoCorte.Fracoes[VpfLacoFracao]);
      VpfDFracao := CarDFracaoOP(nil,VpfDPlanoCorteFracao.CodFilial,VpfDPlanoCorteFracao.SeqOrdem,VpfDPlanoCorteFracao.SeqFracao);
      CarDFracaoOPEstagio(VpfDFracao,VpfDPlanoCorteFracao.CodFilial,VpfDPlanoCorteFracao.SeqOrdem);
//      VpfPosicaoX := (VpfColuna * 272);
      VpfPosicaoX := (VpfColuna * 284);
      VpfFunZebra.ImprimeCodigoBarras(VpfPosicaoX+35,0,0,'2',2,4,40,true,FloatToStr(VpfDFracao.CodBarras));
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,70,0,1,1,2,false,VpfDFracao.CodProduto);
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,95,0,1,1,1,false,VpfDFracao.NomProduto);
      VpfEstagios := RTextoEstagiosFracao(VpfDFracao);
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,120,0,1,1,1,false,copy(VpfEstagios,1,25));
      if length(VpfEstagios) > 26 then
        VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,136,0,1,1,1,false,copy(VpfEstagios,26,length(VpfEstagios)-24));
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+245,0,1,1,1,1,false,FormatDateTime('DD/MM',date));
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+20,152,0,1,1,1,false,'CNC: '+IntToStr(VpaDPlanoCorte.NumCNC));
      VpfFunZebra.ImprimeTexto(VpfPosicaoX+185,152,0,1,2,2,false,IntToStr(VpfDItemPlanoCorte.SeqIdentificacao));

      inc(VpfColuna);
      if  VpfColuna >= 3 then
      begin
        VpfColuna := 0;
        VpfFunZebra.FechaImpressao;
      end;
      VpfDFracao.free;
    end;
  end;
  VpfFunZebra.FechaImpressao;
  VpfFunZebra.free;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ImprimeEtiquetaNroOP(VpaSeqOrdem : INteger;VpaNomCiente : String);
Var
  VpfFunZebra : TRBFuncoesZebra;
begin
  if varia.ModeloEtiquetaNotaEntrada in [6] then
    VpfFunZebra := TRBFuncoesZebra.cria(varia.PortaComunicacaoImpTermica,176,lzEPL);
  VpfFunZebra.ImprimeCodigoBarras(90,0,0,'2',2,5,50,true,AdicionaCharE('0',FloatToStr(VpaSeqOrdem),5));
  VpfFunZebra.ImprimeTexto(20,95,0,1,2,3,false,copy(VpaNomCiente,1,13));
  if Length(VpaNomCiente) > 15 then
    VpfFunZebra.ImprimeTexto(20,135,0,1,2,3,false,copy(VpaNomCiente,14,13));
  VpfFunZebra.FechaImpressao;
  VpfFunZebra.free;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarIconeNoFracao(VpaNo : TTreeNode;VpaDFracao : TRBDFracaoOrdemProducao);
begin
  if VpaDFracao.DatFinalizacao > MontaData(1,1,1900) then
    VpaNo.ImageIndex := 4
  else
    if VpaDFracao.DatEntrega < date then
    begin
      if VpaDFracao.CodEstagio = varia.EstagioOrdemProducao then
        VpaNo.ImageIndex := 3
      else
        VpaNo.ImageIndex := 5;
    end
    else
      if VpaDFracao.DatEntrega = date then
      begin
        if VpaDFracao.CodEstagio = varia.EstagioOrdemProducao then
          VpaNo.ImageIndex := 2
        else
          VpaNo.ImageIndex := 6;
      end
      else
        if VpaDFracao.CodEstagio = varia.EstagioOrdemProducao then
          VpaNo.ImageIndex := 0
        else
          VpaNo.ImageIndex := 1;
  VpaNo.SelectedIndex := VpaNo.ImageIndex;
end;

{******************************************************************************}
procedure TRBFuncoesOrdemProducao.CarregaArvoreSubMontagem(VpaTabela : TDataSet;VpaArvore : TTreeView);
var
  VpfNo : TTreeNode;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  VpaArvore.Items.Clear;

  While not VpaTabela.Eof do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao.cria;
    VpfDFracao.CodFilial := VpaTabela.FieldByName('CODFILIAL').AsInteger;
    VpfDFracao.SeqOrdemProducao := VpaTabela.FieldByName('SEQORDEM').AsInteger;
    VpfDFracao.SeqFracao := VpaTabela.FieldByName('SEQFRACAO').AsInteger;
    VpfDFracao.CodEstagio := VpaTabela.FieldByName('CODESTAGIO').AsInteger;
    VpfDFracao.DatEntrega := VpaTabela.FieldByName('DATENTREGA').AsDateTime;
    VpfDFracao.DatFinalizacao := VpaTabela.FieldByName('DATFINALIZACAO').AsDateTime;
    VpfDFracao.IndEstagiosCarregados := false;
    VpfNo := VpaArvore.Items.AddObject(VpaArvore.Selected,'OP - '+VpaTabela.FieldByname('SEQORDEM').AsString+ '  Produto : '+
                                      VpaTabela.FieldByName('C_COD_PRO').AsString+'-'+VpaTabela.FieldByName('C_NOM_PRO').AsString,VpfDFracao);

    AdicionaNoFracao(VpaTabela.FieldByname('CODFILIAL').AsInteger,VpaTabela.FieldByname('SEQORDEM').AsInteger,
                   VpaTabela.FieldByname('SEQFRACAO').AsInteger,VpfNo,VpaArvore);
    CarIconeNoFracao(VpfNo,VpfDFracao);
    VpaTabela.next;
  end;
end;


{******************************************************************************}
procedure TRBFuncoesOrdemProducao.ReservaQtdEstoqueFracao(VpaDOP : TRBDordemProducao);
var
  VpfLacoFracao, VpfLacoConsumo : Integer;
  vpfDFracao : TRBDFracaoOrdemProducao;
  VpfDConsumoFracao : TRBDConsumoOrdemProducao;
  VpfDProduto : TRBDProduto;
  VpfQtdConsumo : Double;
begin
  if varia.OperacaoAdicionaReservaSaidaEstoque <> 0 then
  begin
    VpfDProduto := TRBDProduto.cria;
    for VpfLacoFracao := 0 to VpaDOP.Fracoes.Count - 1 do
    begin
      vpfDFracao := TRBDFracaoOrdemProducao(VpaDOP.Fracoes.Items[VpfLacoFracao]);
      for VpfLacoConsumo := 0 to vpfDFracao.Consumo.Count - 1 do
      begin
        VpfDConsumoFracao := TRBDConsumoOrdemProducao(vpfDFracao.Consumo.Items[VpfLacoConsumo]);
        if VpfDConsumoFracao.QtdaReservar = 0 then
        begin
          FunProdutos.CarDEstoque1(VpfDProduto,VpaDOP.CodEmpresafilial,VpfDConsumoFracao.SeqProduto,VpfDConsumoFracao.CodCor);
          VpfQtdConsumo := FunProdutos.CalculaQdadePadrao(VpfDConsumoFracao.UM,VpfDConsumoFracao.UMOriginal,VpfDConsumoFracao.QtdABaixar,IntToStr(VpfDConsumoFracao.SeqProduto));
          if VpfDProduto.QtdRealEstoque >= VpfQtdConsumo then
            VpfDConsumoFracao.QtdAReservar := VpfDConsumoFracao.QtdABaixar
          else
            if VpfDProduto.QtdRealEstoque > 0 then
            begin
              VpfDConsumoFracao.QtdAReservar := FunProdutos.CalculaQdadePadrao(VpfDConsumoFracao.UMOriginal,VpfDConsumoFracao.UM,VpfDProduto.QtdRealEstoque ,IntToStr(VpfDConsumoFracao.SeqProduto));
            end;
          if VpfDConsumoFracao.QtdAReservar > 0 then
            FunProdutos.BaixaQtdAReservarProduto(VpaDOP.CodEmpresafilial,VpfDConsumoFracao.SeqProduto,VpfDConsumoFracao.CodCor,0,
                                           VpfDConsumoFracao.QtdAReservar,VpfDConsumoFracao.UM,VpfDConsumoFracao.UMOriginal,
                                           'E');
        end;
      end;
    end;
    VpfDProduto.free;
  end;
end;


end.
