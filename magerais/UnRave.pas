unit UnRave;
{Verificado
-.edit;
}
interface
Uses SQLExpr, RpRave, UnDados, SysUtils, RpDefine, RpBase, RpSystem,RPDevice,
     Classes, forms, Graphics, unprodutos, UnClassificacao, UnAmostra, RpRenderPDF,
     unDadosProduto, windows, rpBars, UnSistema, UnordemProducao, UnDRave, UnClassesImprimir,
     UnClientes, Unvendedor, UnDadosCR, UnContasAPagar, UnNotasFiscaisFor, UnPedidoCompra;

type
  TRBFunRave = class
    private
      Aux,
      Tabela,
      Clientes : TSQLQuery;
      RvSystem: TRvSystem;
      RvPDF :  TRvRenderPDF;
      VprCabecalhoEsquerdo,
      VprCabecalhoDireito : TStringList;
      VprCaminhoRelatorio,
      VprNomeRelatorio,
      VprPrimeiraLinha,
      VprNomVendedor,
      VprUfAtual,
      VprCampoData,
      VprBairro,
      VprCodClassificacao : String;
      VprMes,
      VprAno,
      VprCodProjeto,
      VprFilial,
      VprClienteMaster,
      VprCliente,
      VprCodRepresentada,
      VprCodTipoCotacao,
      VprQtdLetras : Integer;
      VprDatInicio,
      VprDatFim : TDateTime;
      VprAgruparPorEstado,
      VprConverterKilo,
      VprTodosProdutos,
      VprAnalitico,
      VprNotasFiscais,
      VprImprimindoConsumoOP,
      VprImprimendoPlanoContas,
      VprResultadoFinanceiroConsolidado,
      VprServico,
      VprAgruparClassificacao,
      VprMostraClassificacao,
      VprIndEntrada,
      VprIndSomenteComQtdConsumida : Boolean;
      VprDOrdemProducao : TRBDOrdemProducao;
      VprDProduto : TRBDProduto;
      VprDOPEtikArt : TRBDOrdemProducaoEtiqueta;
      FunClassificacao : TFuncoesClassificacao;
      VprRomaneioProduto,
      VprCotacoes,
      VprNiveis,
      VprPedidosAtrasados : TList;
      VprConsumoAmostra : TList;
      VprDTotalPedidosAtrasados: TRBDRPedidosAtrasadosRave;
      VprDTotalConsumoAmostra: TRBDRConsumoEntregaAmostrasRave;
      VprDFilial : TRBDFilial;
      VprDFluxo : TRBDFluxoCaixaCorpo;
      VprBaseDados : TSQLConnection;
      function RValOrcadoTotal(VpaDatInicio, VpaDatFim : TDateTime) : Double;
      procedure DefineTabelaProdutosPorClassificacao(VpaObjeto : TObject);
      procedure DefineTabelaProdutosFaturadosPorPeriodo(VpaObjeto : TObject);
      procedure DefineTabelaProdutosComDefeito(VpaObjeto : TObject);
      procedure DefineTabelaResumoCaixas(VpaObjeto : TObject);
      procedure DefineTabelaProdutosVendidoseTrocados(VpaObjeto : TObject);
      procedure DefineTabelaEstoqueProdutos(VpaObjeto : TObject);
      procedure DefineTabelaDemandaCompra(VpaObjeto : TObject);
      procedure DefineTabelaQtdMinimas(VpaObjeto : TObject);
      procedure DefineTabelaAnaliseFaturamentoMensal(VpaObjeto : TObject);
      procedure DefineTabelaProdutosFaturadosSTcomTributacao(VpaObjeto : TObject);
      procedure DefineTabelaFechamentoEstoque(VpaObjeto : TObject);
      procedure DefineTabelaCPporPlanoContas(VpaObjeto : TObject);
      procedure DefineTabelaCPporPlanoContasSintetico(VpaObjeto : TObject);
      procedure DefineTabelaCPporPlanoContasSinteticoporMes(VpaObjeto : TObject);
      procedure DefineTabelaEntradaMetro(VpaObjeto : TObject);
      procedure DefineTabelaExtratoProdutividade(VpaObjeto : TObject);
      procedure DefineTabelaCustoProjeto(VpaObjeto : TObject);
      procedure DefineTabelaTabelaPreco(VpaObjeto : TObject);
      procedure DefineTabelaTotalAmostraporVendedor(VpaObjeto : TObject);
      procedure DefineTabelaTotalAmostraPorClienteVendedor(VpaObjeto: TObject);
      procedure DefineTabelaTotalTipoCotacaoXCusto(VpaObjeto : TObject);
      procedure DefineTabelaRomaneioEtikArt(VpaObjeto : TObject);
      procedure DefineTabelaOPEtikArt(VpaObjeto : TObject);
      procedure DefineTabelaOPFabricaCardarcodeFita(VpaObjeto : TObject);
      procedure DefineTabelaRomaneioSeparacaoCotacao(VpaObjeto : TObject);
      procedure DefineTabelaAnaliseLocacaoAnalitico(VpaObjeto : TObject);
      procedure DefineTabelaCartuchosPesadosPorCelula(VpaObjeto : TObject);
      procedure DefineTabelaPagamentoFaccionista(VpaObjeto : TObject);
      procedure DefineTabelaResultadoFinanceiroOrcado(VpaObjeto : TObject);
      procedure DefineTabelaClientesXCobrancaporBairro(VpaObjeto : TObject);
      procedure DefineTabelaServicosVendidosPorClassificacao(VpaObjeto : TObject);
      procedure DefineTabelaPedidosAtrasados(VpaObjeto : TObject);
      procedure DefineTabelaConsumoAmostras(VpaObjeto: TObject);
      procedure DefineTabelaLivroRegistroSaidas(VpaObjeto : TObject);
      procedure DefineTabelaFluxoCaixaDiario(VpaObjeto : TObject);
      procedure DefineTabelaAnaliseRenovacaoContrato(VpaObjeto : TObject);
      procedure DefineTabelaContratoAssinados(VpaObjeto : TObject);
      procedure DefineTabelaCreditoCliente(VpaObjeto : TObject);
      procedure DefineTabelaHistoricoConsumoProdutoProducao(VpaObjeto: TObject);
      procedure DefineTabelaValorFreteXValorConhecimento(VpaObjeto: TObject);
      procedure DefineTabelaProdutoFornecedor(VpaObjeto: TObject);
      procedure ImprimeProdutoPorClassificacao(VpaObjeto : TObject);
      procedure ImprimeProdutosFaturadoPorPeriodo(VpaObjeto : TObject);
      procedure SalvaTabelaProdutosPorCoreTamanho(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaProdutosDemandaCompra(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaProdutosFaturadosPorPeriodo(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaPrecoPorCoreTamanho(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaTrocasProdutos(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaProdutosComDefeito(VpaDProduto :TRBDProdutoRave);
      procedure ImprimeRelServicoVendidoPorClassificacao(VpaObjeto : TObject);
      procedure ImprimeRelEstoqueProdutos(VpaObjeto : TObject);
      procedure ImprimeRelPedidosAtrasados(VpaObjeto: TObject);
      procedure ImprimeRelConsumoAmostrasAtrasadas(VpaObjeto: TObject);
      procedure ImprimeRelAnalisePedidosClassificacao(VpaObjeto: TObject);
      procedure ImprimeRelProdutosFaturadosSTComTributacaoPorNota(VpaObjeto: TObject);
      procedure ImprimeRelProdutosFaturadosSTComTributacao(VpaObjeto: TObject);
      procedure ImprimeRelLivroRegistroSaidas(VpaObjeto : TObject);
      procedure ImprimeRelFluxoCaixaDiario(VpaObjeto : TObject);
      procedure ImprimeFluxoCaixaDiarioDias(VpaDContaFluxo : TRBDFluxoCaixaConta;VpaDiaInicio, vpaDiaFim : Integer);
      procedure ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo : TRBDFluxoCaixaConta;VpaDiaInicio, vpaDiaFim : Integer;VpaTipoLinha : TRBDTipoLinhaFluxo);
      procedure ImprimeTotaisNiveis(VpaNiveis : TList;VpaIndice : integer);
      procedure ImprimeTotaisNiveisPlanoContas(VpaNiveis : TList;VpaIndice : integer);
      procedure ImprimeTotalCelulaTrabalho(VpaValTotal : Double;VpaDiaAtua : Integer);
      procedure ImprimeTotalCFOPLivroSaida(VpaListaCFOP : TList);
      procedure ImprimeTotalUFLivroSaida(VpaListaUF : TList);
      procedure ImprimeCabecalhoEstoque;
      procedure ImprimeCabecalhoConsumoProdutoProducao;
      procedure ImprimeCabecalhoDemandaCompra;
      procedure ImprimeCabecalhoServicoVendido;
      procedure ImprimeCabecalhoTabelaPreco;
      procedure ImprimeCabecalhoProdutocomDefeito;
      procedure ImprimeCabecalhoTotalTipoPedidoXCusto;
      procedure ImprimeCabecalhoResumoCaixas;
      procedure ImprimeCabecalhoRomaneioEtikArt;
      procedure ImprimeCabecalhoRomaneioCotacao;
      procedure ImprimeCabecalhoAnaliseContrato;
      procedure ImprimeCabecalhoProdutosVendidoseTrocados;
      procedure ImprimeCabecalhoQtdMinima;
      procedure ImprimeCabecalhoAnaliseFaturamento;
      procedure ImprimeCabecalhoFechamentoEstoque;
      procedure ImprimeCabecalhoEntradaMetros;
      procedure ImprimeCabecalhoPlanoContas;
      procedure ImprimeCabecalhoPlanoContasCustoProjeto;
      procedure ImprimeCabecalhoExtratoProdutividade;
      procedure ImprimeCabecalhoCartuchosPesadosPorCelula;
      procedure ImprimeCabecalhoAmostrasPorDesenvolverdor;
      procedure ImprimeCabecalhoResultadoFinanceiroOrcado;
      procedure ImprimeCabecalhoCustoProjeto;
      procedure ImprimeCabecalhoTotalAmostrasVendedor;
      procedure ImprimeCabecalhoTotalAmostrasClientesVendedor;
      procedure ImprimeCabecalhoPorPlanoContasSintetico;
      procedure ImprimeCabecalhoPorPlanoContasSinteticoporMes;
      procedure ImprimeCabecalhoPagamentoFaccionista;
      procedure ImprimeCabecalhoClientesXCobrancaporBairro;
      procedure ImprimeCabecalhoPedidosAtrasados;
      procedure ImprimeCabecalhoConsumoAmostras;
      procedure ImprimeCabecalhoLivroRegistroSaida;
      procedure ImprimeCabecalhoFluxoCaixaDiario;
      procedure ImprimeCabecalhoProdutoFaturadosSTComTributacao;
      procedure ImprimeCabecalhoAnaliseRenovacaoContrato;
      procedure ImprimeCabecalhoCreditoCliente;
      procedure ImprimeCabecalhoPrazoEntregaRealProdutos;
      procedure ImprimeCabecalhoHistoricoConsumoProdutoProducao;
      procedure ImprimeCabecalhoValorFreteNotaXValorConhecimento;
      procedure ImprimeCabecalhoTotalFreteNotaXValorConhecimento;
      procedure ImprimeCabecalhoProdutoFornecedor;
      procedure ImprimeTituloUF(VpaCodUf : String);
      procedure ImprimeTituloClassificacao(VpaNiveis : TList;VpaTudo : boolean);
      procedure ImprimetituloPlanoContas(VpaNiveis : TList;VpaTudo : boolean);
      function RTamanhoProduto(VpaDCor : TRBDCorProdutoRave;VpaCodTamanho : Integer) : TRBDTamanhoProdutoRave;
      function RCorProduto(VpaDProduto : TRBDProdutoRave;VpaCodCor : Integer):TRBDCorProdutoRave;
      function RTotalCFOP(VpaLista : TList;VpaCodCfop : string):TRBDLivroSaidasTotalCFOPRave;
      function RTotalUFLivroSaida(VpaLista : TList;VpaDesUf : string):TRBDLivroSaidasTotalUFRave;
      function CarDNivel(VpaCodCompleto, VpaCodReduzido : String):TRBDClassificacaoRave;
      function CarregaNiveis(VpaNiveis : TList;VpaCodClassificacao : string):TRBDClassificacaoRave;
      function CarDNivelPlanoContas(VpaCodCompleto, VpaCodReduzido : String):TRBDPlanoContasRave;
      procedure CarVendaMesRelatorio(VpaDVendaAno : TRBDVendaClienteAno);
      function CarregaNiveisPlanoContas(VpaNiveis : TList;VpaCodPlanoContas : string;VpaImprimirTotal : Boolean):TRBDPlanoContasRave;
      function ImprimeRelCustoProjetoContasAPagar:double;
      procedure ImprimeTituloOPCustoProjeto(VpaCodFilial, VpaSeqOrdem : Integer);
      function ImprimeRelCustoProjetoConsumoMateriaPrima:Double;
      procedure ImprimeRelCustoTotalProjeto(VpaValor : Double);
      procedure ImprimeRelTabelaPreco(VpaObjeto : TObject);
      procedure ImprimeRelProdutosComDefeito(VpaObjeto : TObject);
      procedure ImprimeRelResumoCaixas(VpaObjeto : TObject);
      procedure ImprimeRelConsumoProdutoProducao(VpaObjeto : TObject);
      procedure ImprimeRelValorFreteNotaXValorConhecimento(VpaObjeto: TObject);
      procedure ImprimeRelProdutoFornecedor(VpaObjeto: TObject);
      function RProdutoRomaneio(VpaRomaneios : TList; VpaDProCotacao : TRBDOrcProduto) : TRBDOrcProduto;
      procedure PreparaRomaneioCotacoes(VpaCotacoes, VpaRomaneio : TList);
      procedure OrdenaRomaneioCotacoes(VpaRomaneio : TList);
      procedure OrdenaPedidosAtrasadosDia(VpaPedidosAtrasados: TList);
      procedure OrdenaPedidosAtrasadosQtdPedido(VpaPedidosAtrasados: TList);
      procedure OrdenaConsumoAmostrasQtdAmostra(VpaConsumoAmostras: TList);
      procedure AdicionaProdutoNota(VpaNotasEntrada : TList;VpaDProduto : TRBDProdutosTibFaturadosST;VpaDNota : TRBDNotaFiscalFor);
      procedure OrdenaConsumoAmostrasDia(VpaConsumoAmostras: TList);
      procedure ImprimeRelResutladoFinanceiroOrcadoReceitas(Var VpaValOrcado, VpaValRealizado, VpaValOutrasReceitas : Double);
      procedure ImprimeRelResultadoFinanceiroOrcadoDespesas(VpaValFaturado : Double;VpaCodCentroCusto : Integer;VpaNomCentroCusto : string);
      procedure ImprimeRelResultadoFinanceiroOrcadoFinal(VpaMetaVenda, VpaValFaturado, VpaValOutrasReceitas : Double);

      procedure InicializaVendaCliente(VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente);
      procedure InicializaMeses(VpaDVendaAno : TRBDVendaClienteAno);
      procedure InicializaVendaClienteRepresentada(VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente);
      function RMesTotal(VpaDVendaAno : TRBDVendaClienteAno;VpaMes: Integer):TRBDVendaClienteMes;
      function RMesVenda(VpaDVenda : TRBDVendaCliente;VpaMes, VpaAno : Integer) : TRBDVendaClienteMes;
      function RVendaClassificacao(VpaDVendaCliente: TRBDVendaCliente;VpaMes, VpaAno: Integer; VpaCodClassificacao : String) : TRBDVendaClienteMes;
      function RMesVendaRepresentada(VpaDVenda : TRBDVendaCliente;VpaNomRepresentada : String; VpaMes, VpaAno : Integer) : TRBDVendaClienteMes;
      procedure AtualizaTotalVenda(VpaDVenda, VpaDTotalVendedor, VpaDTotalGeral : TRBDVendaCliente);
      procedure AtualizaTotalVendaRepresentada(VpaDVenda :  TRBDVendaCliente);
      function CarValoresFaturadosCliente(VpaCodCliente,VpaCodFilial : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda, VpaDTotalVendedor, VpaDTotalGeral : TRBDVendaCliente):boolean;
      function CarValoresPedidosRepresentadaCliente(VpaCodCliente : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente):boolean;
      function CarValoresQtdProdutosCliente(VpaCodCliente : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente):boolean;
      function CarValoresPlanoContasMes(VpaCodFilial : Integer; VpaPlanoContas : String; VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente):boolean;
      procedure CarValoresContasAPagar(VpaCodFilial, VpaCodCentroCusto : Integer;VpaPlanoContas : String; VpaDatInicio,VpaDatFim : TDateTime;Var VpaValPago : Double;Var VpaValtotal : Double);
      procedure CarValorTrocasProdutos(VpaDProduto : TRBDProdutoRave; VpaDatInicio,VpaDatFim : TDateTime;VpaSeqProduto :Integer);
      function RValCustoCotacao(VpaCodFilial,VpaLanOrcamento : Integer) : Double;
      function REspula(VpaNumEspulas : Integer) : String;
      function RDPedidosAtrasados(VpaQtdDias: integer; VpaPedidosAtrasados: TList):TRBDRPedidosAtrasadosRave;
      function RDConsumoAmostrasAtrasadas(VpaQtdDias: integer; VpaConsumoAmostraAtrasadas: TList):TRBDRConsumoEntregaAmostrasRave;
      procedure RMetrosFitaManequim(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaLacoInicio,VpaLacoFim : Integer);
      procedure CarCombinacoesOPConvencional(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
      procedure CarCombinacoesOPH(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
      procedure CarManequinsOPConvencional(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
      procedure CarMetrosCombinacaoOPH(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
      procedure CarDContrato(VpaDContrato : TRBDContratoLocacaoRave;VpaCodFilial, VpaSeqContrato,VpaCodCliente  : Integer);
      procedure CarLeituraLocacao(VpaDContrato : TRBDContratoLocacaoRave;VpaCodFilial, VpaSeqContrato : Integer);
      procedure CarEquipamentosContrato(VpaDContrato : TRBDContratoLocacaoRave);
      procedure CarInsumosContrato(VpaDContrato : TRBDContratoLocacaoRave;VpaContabilizados : Boolean);
      procedure CarPecasContrato(VpaDContrato : TRBDContratoLocacaoRave);
      procedure CarDCartuchosPesadosCelula(VpaCodCelula: Integer; VpaDCelula: TRBDRCelulaTrabalho; VpaTabela: TSQLQuery);
      function RTotaisPedidosAtrasados(VpaPedidosAtrasados: TList): TRBDRPedidosAtrasadosRave;
      function RTotaisConsumoAmostraAtrasados(VpaConsumoAmostrasAtrasados: TList): TRBDRConsumoEntregaAmostrasRave;
      function RDataPedido(VpaCodFilial, VpaSeqNota,VpaSeqProduto : Integer;VpaCampoData : String;VpaDataEntrega : TDatetime) : Integer;
      function RDataAmostra(VpaCampoData : String;VpaDataEntrega : TDatetime; VpaCodAmostra: Integer) : Integer;
      procedure CarDPedidosAtrasados(VpaPedidosAtrasados: TList; VpaDatIni, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente, VpaCodVendedor:integer; VpaCampoPrimeiraData:String);
      procedure CarDConsumoEntregaAmostras(VpaConsumoEntregaAmostras: TList; VpaDatIni, VpaDatFim: TDateTime; VpaCampoPrimeiraData:String);
      procedure CarDPedidosAtrasadosOrcamentos(VpaPedidosAtrasados: TList; VpaDatIni, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente, VpaCodVendedor:integer; VpaCampoPrimeiraData:String);
      procedure CarDAmostrasDesenvolvedor(VpaCodDesenvolvedor: Integer; VpaDAmostraDesenvolvedor: TRBDRAmostraDesenvolvedor; VpaTabela: TSQLQuery);
      procedure ImprimeInstalacaoTearCadarcoFita(VpaDProduto : TRBDProduto);
      procedure CarregaValoresMesTabela(VpaDVenda : TRBDVendaCliente; VpaCodPlanoContas, VpaNomPlanoContas : String);
      procedure ImprimeTotalAnalisePedidoAnual(VpaDTotal : TRBDVendaCliente);
      procedure CarRenovacaoContrato(VpaCodCliente : Integer; VpaDatFimVigencia : TDateTime;Var VpaDatAssinatura : TDateTime; var VpaDatInicioNovoContrato, VpaDatFimNovoContrato : TDateTime;Var VpaValorContrato : Double);
      procedure ImprimeCabecalhoTotalAnaliseRenovacaoContratoTotalVendedor;
      procedure ImprimeTotalAnaliseRenovacaoContratoTotalVendedor(VpaTotalVendedores : TList);
      procedure CarQtdVendidaDemandaCompra(VpaDProdutoRave : TRBDProdutoRave;VpaDCorRave : TRBDCorProdutoRave;VpaDTamanho : TRBDTamanhoProdutoRave;VpaDaInicial,VpaDatFinal : Double);

      procedure ConfiguraRelatorioPDF;
      procedure ImprimeRelEstoqueMinimo(VpaObjeto : TObject);
      procedure ImprimeRelAnaliseFaturamentoAnual(VpaObjeto : TObject);
      procedure ImprimeRelAnalisePedidosRepresentadaAnual(VpaObjeto : TObject);
      procedure ImprimeRelFechamentoEstoque(VpaObjeto : TObject);
      procedure ImprimeRelCPporPlanoContas(VpaObjeto : TObject);
      procedure ImprimeRelCPporPlanoContasSintetico(VpaObjeto : TObject);
      procedure ImprimeRelCPPorPlanoContasSinteticoporMes(VpaObjeto : TObject);
      procedure ImprimeRelEntradaMetros(VpaObjeto : TObject);
      procedure ImprimeRelExtratoProdutividade(VpaObjeto : TObject);
      procedure ImprimeRelCustoProjeto(VpaObjeto : TObject);
      procedure ImprimeRelTotalAmostrasVendedor(VpaObjeto : TObject);
      procedure ImprimeRelTotalAmostrasClienteVendedor(VpaObjeto : TObject);
      procedure ImprimeRelTotalTipoCotacaoXCusto(VpaObjeto : TObject);
      procedure ImprimeRelRomaneioEtikArt(VpaObjeto : TObject);
      procedure ImprimeRelOPEtikArt(VpaObjeto : TObject);
      procedure ImprimeRelRomaneioSeparacaoCotacao(VpaObjeto : TObject);
      procedure ImprimeRelAnaliseContratosAnaliticoLeituras(VpaDContrato : TRBDContratoLocacaoRave);
      procedure ImprimeRelAnaliseContratosAnaliticoEquipamentos(VpaDContrato : TRBDContratoLocacaoRave);
      procedure ImprimeRelAnaliseContratosAnaliticoInsumos(VpaDContrato : TRBDContratoLocacaoRave; VpaInsumos : TList; VpaContabilizados : Boolean);
      procedure ImprimeRelAnaliseContratosAnaliticoPecas(VpaDContrato : TRBDContratoLocacaoRave);
      procedure ImprimeRelAnaliseContratosAnalitico(VpaDContrato : TRBDContratoLocacaoRave;VpaTabela :  TSQLQuery);
      procedure ImprimeRelAnaliseContratosSintetico(VpaDContrato : TRBDContratoLocacaoRave);
      procedure ImprimeRelAnaliseContratos(VpaObjeto : TObject);
      procedure ImprimeRelCartuchosPesadosPorCelula(VpaObjeto : TObject);
      procedure ImprimeRelAmostrasPorDesenvolvedor(VpaObjeto : TObject);
      procedure ImprimeRelPagamentoFaccionista(VpaObjeto : TObject);
      procedure ImprimerRelOPFabricaCardarcodeFita(VpaObjeto : TObject);
      procedure ImprimeRelResultadoFinanceiroOrcado(VpaObjeto : TObject);
      procedure ImprimeRelResultadoFinanceiroOrcadoPorCentroCusto(VpaObjeto : TObject);
      procedure ImprimeRelAnaliseRenovacaoContrato(VpaObjeto : TObject);
      procedure ImprimeRelCreditoCliente(VpaObjeto : TObject);
      procedure ImprimeRelHistoricoConsumoProdutoProducao(VpaObjeto : TObject);
      procedure ImprimeRelContratosAssinados(VpaObjeto : TObject);
      procedure ImprimeRelClientesXCobrancaPorBairro(VpaObjeto : TObject);
      procedure ImprimeRelDemandaCompra(VpaObjeto : TObject);
      procedure ImprimeCabecalho(VpaObjeto : TObject);
      procedure ImprimeRodape(VpaObjeto : TObject);

    public
      VplArquivoPDF,
      VplArquivoRTF : String;
      VplFunPedidoCompra : TRBFunPedidoCompra;
      constructor cria(VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      procedure EnviaParametrosFilial(VpaProjeto : TrvProject;VpaDFilial : TRBDFilial);
      procedure EnviaParametrosDuplicata(VpaProjeto : TrvProject; VpaDDuplicata: TDadosDuplicata);
      procedure ImprimeProdutoVendidosPorClassificacao(VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaCodClienteMaster  : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho,VpaNomFilial,VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao, VpaNomClienteMaster : String;VpaAgruparPorEstado, VpaConverterKilo, VpaPDF : Boolean);
      procedure ImprimeEstoqueProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados,VpaSomenteComQtd : Boolean;VpaOrdemRelatorio, VpaCodigoProduto : Integer);
      procedure ImprimeAnaliseFaturamentoMensal(VpaCodFilial,VpaCodCliente,VpaCodVendedor, VpaCodPreposto, VpaCodTipCotacao : Integer;VpaCaminho, VpaNomFilial,VpaNomCliente,VpaNomVendedor, VpaNomPreposto, VpaNomTipoCotacao : String;VpaDatInicio, VpaDatFim : TDateTime;VpaNotasFiscais : Boolean);
      procedure ImprimeQtdMinimasEstoque(VpaCodFilial, VpaCodFornecedor : Integer;VpaCaminho,VpaCodClassificacao,VpaNomFilial, VpaNomClassificacao, VpaNomFornecedor : String);
      procedure ImprimeEstoqueFiscalProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados : Boolean);
      procedure ImprimeFechamentoMes(VpaCodFilial : Integer;VpaCaminho, VpaNomFilial : String;VpaData : TDateTime;VpaMostarTodos : Boolean);
      procedure ImprimeContasAPagarPorPlanodeContas(VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : String;VpfTipoPeriodo : Integer);
      procedure ImprimeEntradaMetros(VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeExtratoProdutividade(VpaCaminho : String;VpaData : TDateTime);
      procedure ImprimeCustoProjeto(VpaCodProjeto : Integer;VpaCaminho, VpaNomProjeto : String);
      procedure ImprimeTabelaPreco(VpaCodCliente, VpaCodTabelaPreco : Integer;VpaCaminho,VpaNomCliente,VpaNomTabelaPreco,VpaCodClassificacao, VpaNomClassificacao : String;VpaAgruparClassificacao : Boolean;VpaOrdemRelatorio : Integer);
      procedure ImprimeEstoqueProdutosReservados(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados : Boolean);
      procedure ImprimeTotaAmostrasPorVendedor(VpaCodVendedor : Integer;VpaCaminho, VpaNomVendedor : String;VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeContasAPagarPorPlanoContasSintetico(VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho : String);
      procedure ImprimeFichaAmosta(VpaDAmostra : TRBDAmostra);
      procedure ImprimeProdutosVendidoseTrocacos(VpaCodFilial, VpaTipCotacao,VpaCodCliente,VpaCodVendedor,VpaCodClienteMaster : Integer;VpaCaminho,VpaNomFilial,VpaNomVendedor,VpaNomTipCotacao,VpaNomCliente,VpaNomClienteMaster:string ;VpaDatInicio,VpaDatFim : TDateTime);
      procedure ImprimeContasAPagarPorPlanoContasSinteticoMes(VpaTipoPeriodo, VpaCodFilial  : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : String);
      procedure ImprimeTotalTipoCotacaoXCusto(VpaCodFilial, VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao : Integer;VpaCaminho, VpaNomFilial, VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao : String;VpaDAtInicio, VpaDatFim : TDAteTime);
      procedure ImprimeProdutosVendidosComDefeito(VpaCodFilial,VpaCodCliente,VpaCodVendedor: Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho,VpaNomFilial,VpaNomCliente, VpaNomVendedor, VpaCodClassificao, VpaNomClassificacao : String;VpaPDF : Boolean);
      procedure ImprimeResumosCaixas(VpaCaminho : String;VpaPDF : Boolean);
      procedure ImprimeRomaneioEtikArt(VpaCodFilial, VpaSeqRomaneio : Integer;VpaVisualizar : Boolean);
      procedure ImprimeOrdemProducaoEtikArt(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaVisualizar : Boolean);
      procedure ImprimeRomaneioSeparacaoCotacao(VpaCotacoes : TList);
      procedure ImprimeAnaliseContratosLocacao(VpaCodTipoContrato, VpaCodCliente, VpaCodVendedor : Integer; VpaCaminho, VpaNomTipoCotrato, VpaNomVendedor, VpaNomCliente: string;VpaDatInicioAssinatura,VpaDatFimAssinatura : TDateTime; VpaSomenteNaoCancelados,VpaAnalitico : Boolean);
      procedure ImprimeAnalisePedidosMensal(VpaCodFilial,VpaCodCliente,VpaCodVendedor, VpaCodPreposto, VpaCodTipoCotacao,VpaCodRepresentada : Integer;VpaCaminho, VpaNomFilial,VpaNomCliente,VpaNomVendedor, VpaNomPreposto, VpaNomTipoCotacao, VpaNomRepresentada : String;VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeCartuchosPesadosPorCelulaTrabalho(VpaCodCelula, VpaSeqProduto: Integer; VpaCaminho, VpaNomCelula, VpaCodProduto, VpaNomProduto: String; VpaData: TDateTime);
      procedure ImprimePagamentoFaccionista(VpaCodFaccionista : Integer;VpaCaminho, VpaNomFaccionista : string;VpaDatInicio, VpaDatFim : tDateTime;VpaBuscanaEmpresa, VpaLevar, VpaTodos, VpaIndFuncionario,VpaIndNaoFuncionario : Boolean);
      procedure ImprimeAmostrasPorDesenvolverdor(VpaCodDesenvolvedor: Integer; VpaCaminho, VpaNomDesenvolvedor: String; VpaData: TDateTime);
      procedure ImprimeTotalAmostrasPorClienteVendedor(VpaCodVendedor, VpaCodCliente : Integer;VpaCaminho, VpaNomVendedor, VpaNomCliente : String;VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeOPFabricaCardarcodeFita(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao : Integer;VpaVisualizar : Boolean);
      procedure ImprimeResultadoFinanceiroOrcado(VpaTipoPeriodo, VpaCodFilial : Integer;VpaMes : TDateTime;VpaCaminho, VpaNomFilial : string);
      procedure ImprimeRelatorioClientesXCobrancaporBairro(VpaCodVendedor, VpaCodSituacao, VpaCodRamoAtividade : Integer;VpaCaminho, VpaNomVendedor,VpaNomSituacao, VpaNomRamoAtividade  : string);
      procedure ImprimeServicosVendidosPorClassificacao(VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaCodClienteMaster  : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho,VpaNomFilial,VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao, VpaNomClienteMaster : String;VpaPDF : Boolean);
      procedure ImprimePedidosAtrasados(VpaCodVendedor, VpaCodCliente, VpaCodFilial, VpaOrdena: integer; VpaNomVendedor, VpaNomCliente,VpaCaminho, VpaNomFilial: String; VpaDatInicio, VpaDatFim: TDateTime);
      procedure ImprimePrazoRealPedidos(VpaCodVendedor, VpaCodCliente, VpaCodFilial, VpaOrdena : integer; VpaNomVendedor, VpaNomCliente, VpaCaminho, VpaNomFilial: String; VpaDatInicio, VpaDatFim: TDateTime);
      procedure ImprimeConsumoEntregaAmostra(VpaOrdena: integer; VpaCaminho: String; VpaDatInicio, VpaDatFim: TDateTime;VpaAnalitico : Boolean);
      procedure ImprimeAnalisePedidoporClassificacao(VpaCodFilial,VpaCodCliente,VpaCodVendedor, VpaCodPreposto, VpaCodTipoCotacao : Integer;VpaCaminho, VpaCodClassificacao, VpaNomClassificacao, VpaNomFilial,VpaNomCliente,VpaNomVendedor, VpaNomPreposto, VpaNomTipoCotacao : String;VpaDatInicio, VpaDatFim : TDateTime;VpaMostrarClassificacao :Boolean);
      procedure ImprimeLivroRegistroSaidas(VpaCodFilial, VpaCodCliente : Integer; VpaNomFilial,VpaNomCliente, VpaCaminho : string; VpaDatInicio, VpaDatFim : TDatetime;VpaIndEntrada : Boolean);
      procedure ImprimeFluxoDiario(VpaDFluxo : TRBDFluxoCaixaCorpo);
      procedure ImprimeProdutosFaturadosSTcomTributacaoPorNota(VpaCodFilial : Integer; VpaDatInicio,VpaDatFim : TDateTime;VpaNomFilial, VpaCaminho : String;VpaAgruparPorNota : Boolean);
      procedure ImprimeProdutosFaturadosPorPeriodo(VpaCodFilial,VpaCodCliente,VpaCodVendedor: Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho,VpaNomFilial,VpaNomCliente, VpaNomVendedor: String; VpaPDF : Boolean);
      procedure ImprimeResultadoFinanceiroOrcadoConsolidado(VpaTipoPeriodo, VpaCodFilial : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : string);
      procedure ImprimeResultadoFinanceiroOrcadoConsolidadoPorCentroCusto(VpaTipoPeriodo, VpaCodFilial : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : string);
      procedure ImprimeAnaliseRenovacaoContrato(VpaCodVendedor : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaNomVendedor,VpaCaminho : string);
      procedure ImprimeContratosAssinados(VpaCodVendedor : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaNomVendedor,VpaCaminho : string);
      procedure ImprimeCreditoCliente(VpaCaminho : string);
      procedure ImprimeHistoricoConsumoProdutoProducao(VpaSeqProduto: Integer; VpaCodProduto, VpaNomProduto, VpaCodClassificacao, VpaNomClassificacao, VpaCaminhoRelatorio:String;VpaDatInicio,VpaDatFim : TDateTime);
      procedure ImprimeConsumoProdutoProducao(VpaCodFilial : Integer; VpaSeqProduto: Integer; VpaCodProduto, VpaNomProduto, VpaCodClassificacao, VpaNomClassificacao, VpaNomFilial,VpaCaminhoRelatorio:String;VpaDatInicio,VpaDatFim : TDateTime;VpaSomenteComQtdEstoque : Boolean;VpaOrdemRelatorio:Integer;VpaSomenteComQtdConsumida : Boolean);
      procedure ImprimeValorFreteNotaXValorConhecimento(VpaCodFilial, VpaCodTransportadora: Integer; VpaNomTransportadora, VpaNomFilial, VpaCaminhoRelatorio: String; VpaDatInicio,VpaDatFim : TDateTime);
      procedure ImprimeDemandaCompra(VpaCodFilial : Integer; VpaCodClassificacao,VpaNomClassificacao,VpaNomFilial, VpaCaminho : String;VpaDatInicio,VpaDatFim : TDateTime);
      procedure ImprimeProdutoFornecedor(VpaCodFornecedor : integer; VpaCaminho, VpaNomFornecedor : String);
  end;


implementation

Uses FunSql, constantes, funObjeto, funString, FunData, UnContasAReceber, FunNumeros,
  UnCotacao, constMsg;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes de impressao do relatorio
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ TRBFunRave }

{********************************************************************}
constructor TRBFunRave.cria(VpaBaseDados: TSQLConnection);
begin
  inherited create;
  VplFunPedidoCompra := TRBFunPedidoCompra.Cria(VpaBaseDados);
  VprBaseDados := VpaBaseDados;
  Aux := TSqlQuery.create(nil);
  Aux.SqlConnection := VpaBaseDAdos;
  Tabela := TSqlQuery.create(nil);
  Tabela.SqlConnection := VpaBaseDAdos;
  Clientes := TSqlQuery.create(nil);
  Clientes.SQLConnection := VpaBaseDados;
  VprCabecalhoEsquerdo := TStringList.Create;
  VprCabecalhoDireito := TStringList.create;
  VprPedidosAtrasados:= TList.Create;
  VprConsumoAmostra:= TList.Create;
  FunClassificacao := TFuncoesClassificacao.criar(NIL,VpaBaseDados);
  VprNiveis := TList.Create;

  RvSystem := TRvSystem.Create(nil);
  RVSystem.SystemPrinter.MarginBottom  := 1;
  RVSystem.SystemPrinter.MarginLeft    := 1;
  RVSystem.SystemPrinter.MarginTop     := 1;
  RVSystem.SystemPrinter.MarginBottom  := 1;
  RVSystem.SystemPrinter.Units         := unCM;
  RVSystem.SystemPrinter.UnitsFactor   := 2.54;
  rpDev.SelectPaper('A4',false);
  rpDev.Copies                          := 1;
  RvPDF := TRvRenderPDF.Create(nil);
  RVSystem.SystemPrinter.Copies        := rpDev.Copies;
  rpDev.Orientation                     := poPortrait;
  RVSystem.SystemPrinter.Orientation   := rpDev.Orientation;
  RVSystem.SystemPreview.RulerType     := rtBothCm;
  RVSystem.SystemSetups := RVSystem.SystemSetups - [ssAllowSetup];
  RVSystem.SystemPreview.FormState     := wsMaximized;
  VprServico := false;
  VprAgruparClassificacao := false;
  VprConverterKilo := false;
  VprResultadoFinanceiroConsolidado := false;
end;

{********************************************************************}
destructor TRBFunRave.destroy;
begin
  Tabela.close;
  Tabela.free;
  Aux.close;
  Aux.free;
  Clientes.close;
  Clientes.free;
  RVSystem.free;
  RvPDF.free;
  VprCabecalhoEsquerdo.free;
  VprCabecalhoDireito.free;
  FreeTObjectsList(VprPedidosAtrasados);
  FreeTObjectsList(VprConsumoAmostra);
  VprPedidosAtrasados.Free;
  VprConsumoAmostra.Free;
  FunClassificacao.free;
  FreeTObjectsList(VprNiveis);
  VplFunPedidoCompra.Free;
  inherited;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaPagamentoFaccionista(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,15,0.5,BoxlineNONE,0); //Codigo classificacao
     SaveTabs(1);
     clearTabs;
     if Varia.ModeloRelatorioFaccionista = mrModelo1Kairos then
     begin
       SetTab(1.5,pjcenter,1.7,0.1,Boxlinenone,0); //data revisao
       SetTab(NA,pjcenter,1.7,0.5,Boxlinenone,0); //data cadastro
       SetTab(NA,pjLeft,15,0,Boxlinenone,0); //produto
       SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Qtd Revisada
       SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Qtd Defeito
       SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Val Unitario
       SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Val Total
       SaveTabs(2);
     end
     else
       if Varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
       begin
         SetTab(1.5,pjcenter,1.7,0.1,Boxlinenone,0); //data revisao
         SetTab(NA,pjRight,1,0.5,Boxlinenone,0); //OP
         SetTab(NA,pjRight,1,0.5,Boxlinenone,0); //Pedido
         SetTab(NA,pjLeft,10,0,Boxlinenone,0); //produto
         SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Qtd Revisada
         SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Val Unitario
         SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Val Total
         SaveTabs(2);
       end
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaPedidosAtrasados(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjcenter,2.5,0.5,BOXLINEALL,0); //Quantidade Dias
     SetTab(NA,pjcenter,5,0.5,Boxlineall,0); //Pedido;
     SetTab(NA,pjcenter,5,0.5,Boxlineall,0); //Produtos;
     SetTab(NA,pjcenter,5,0.5,Boxlineall,0); //ValorProdutos;
     SaveTabs(1);
     clearTabs;
     SetTab(1.0,pjcenter,2.5,0.5,BOXLINEALL,0); //Quantidade Dias
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); // Qtd Pedido;
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); // % Pedidos
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); //Qtd Produtos
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); //% Produtos
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); //Valor Produtos
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); //% Valor Produtos
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaProdutoFornecedor(VpaObjeto: TObject);
begin
  with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1,pjLeft,1.5,0.1,BOXLINENONE,0); //Codigo
     SetTab(NA,pjLeft,10.5,0,BOXLINENONE,0); //Produto
     SetTab(NA,pjCenter,2,0,BOXLINENONE,0); //Valor Unitario
     SetTab(NA,pjCenter,1,0.2,BOXLINENONE,0); // %IPI
     SetTab(NA,pjCenter,1.5,0.2,BOXLINENONE,0); // ICMS
     SetTab(NA,pjCenter,1,0.2,BOXLINENONE,0); // MVA
     SetTab(NA,pjCenter,4,0.2,BOXLINENONE,0); // Classificacao fiscal
     SetTab(NA,pjCenter,1.5,0.2,BOXLINENONE,0); // %ST
     SetTab(NA,pjCenter,3,0.2,BOXLINENONE,0); // Ultima compra
     SetTab(NA,pjLeft,3,0.2,BOXLINENONE,0); // Referencia
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaProdutosComDefeito(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     SetTab(NA,pjLeft,7.6,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd Defeito
     SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Per Defeito
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Val Perdido
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaProdutosFaturadosPorPeriodo(
  VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,7.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,8.7,0.5,Boxlinenone,0) //nomeproduto
       else
         SetTab(NA,pjLeft,11.3,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) then
       SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0); //Cor
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SaveTabs(2);
   end;

end;

procedure TRBFunRave.DefineTabelaProdutosFaturadosSTcomTributacao(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     FontSize := 6;
     SetTab(1,pjRight,1.0,0.1,BOXLINENONE,0); //nota
     SetTab(NA,pjLeft,1.0,0,BOXLINENONE,0); //codigo produto
     SetTab(NA,pjLeft,4.5,0,BOXLINENONE,0); //nome produto
     SetTab(NA,pjCenter,1,0.2,BOXLINENONE,0); // um
     SetTab(NA,pjRight,1.5,0.2,BOXLINENONE,0); //total produto
     SetTab(NA,pjRight,1.5,0.2,BOXLINENONE,0); //Valor custo
     SetTab(NA,pjRight,1.0,0.2,BOXLINENONE,0); //percentual mva
     SetTab(NA,pjRight,1.5,0.2,BOXLINENONE,0); //base st
     SetTab(NA,pjRight,1.5,0.2,BOXLINENONE,0); //valor st
     SetTab(NA,pjRight,1.0,0.2,BOXLINENONE,0); //percentual icms
     SetTab(NA,pjRight,1.5,0.2,BOXLINENONE,0); //valor icms
     SaveTabs(1);
     ClearTabs;
     SetTab(3,pjLeft,5.0,0.1,BOXLINENONE,0); //fornecedor
     SetTab(NA,pjLeft,5,0,BOXLINENONE,0); //CNPJ
     SetTab(NA,pjRight,2,0,BOXLINENONE,0); //NRO NOTA
     SetTab(NA,pjCenter,2.5,0.2,BOXLINENONE,0); // data emissao
     SaveTabs(2);
   end;
end;

{******************************************************************************}
{******************************************************************************}
procedure TRBFunRave.DefineTabelaProdutosPorClassificacao(VpaObjeto :TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,7.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,8.7,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,10.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,11.3,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) then
       SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0); //Cor
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SaveTabs(2);
   end;
end;

(******************************************************************************)
procedure TRBFunRave.DefineTabelaProdutosVendidoseTrocados(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,8,0.1,Boxlinenone,0); //espaco vazio
     SetTab(NA,pjCenter,4.6,0.3,BOXLINEBOTTOM,0); //vendas
     SetTab(NA,pjCenter,0.2,0.3,BOXLINENONE,0); //
     SetTab(NA,pjCenter,4.6,0.3,BOXLINEBOTTOM,0); //Trocas
     SaveTabs(2);
     clearTabs;
     SetTab(1.2,pjLeft,2,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,4.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,5.7,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,7.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,5.8,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) then
       SetTab(NA,pjLeft,1.5,0.2,Boxlinenone,0); //Cor
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd vendida
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor total vendido
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd trocado
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor total trocado
     SetTab(NA,pjRight,2,0,Boxlinenone,0); //percentual
     SaveTabs(3);
   end;
end;

(******************************************************************************)
procedure TRBFunRave.DefineTabelaEstoqueProdutos(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,3.0,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,7.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,8.2,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,10.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,11.3,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) and (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0) //Cor
     else
       SetTab(NA,pjLeft,3.1,0.2,Boxlinenone,0); //Cor
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaQtdMinimas(VpaObjeto : TObject);
var
  VpfTamanhoColProduto : Double;
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.5,pjLeft,1.6,0.1,Boxlinenone,0); //Codigo Produto
     VpfTamanhoColProduto := 10;
     if not config.EstoquePorCor then
       VpfTamanhoColProduto := VpfTamanhoColProduto +1;
     if not config.EstoquePorTamanho then
       VpfTamanhoColProduto := VpfTamanhoColProduto +1;
     SetTab(NA,pjLeft,VpfTamanhoColProduto,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     if  config.EstoquePorCor then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Cor
     if config.EstoquePorTamanho then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Atal
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Minima
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Ideal
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Faltante
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Val Unitario
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor total
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaResultadoFinanceiroOrcado(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(2.0,pjRight,7,0.5,BOXLINEALL,0); //Vendedor
     SetTab(NA,pjRight,3,0.5,BOXLINEALL,0); //valor orcado
     SetTab(NA,pjRight,3,0.5,BOXLINEALL,0); //valor Realizado
     SetTab(NA,pjRight,3,0.5,BOXLINEALL,0); //Diferenca
     SaveTabs(1);
     clearTabs;
     SetTab(2.0,pjCenter,18,0.5,BoxlineNONE,0);
     SaveTabs(2);
     clearTabs;
     SetTab(1.0,pjRight,3,0.5,BOXLINEALL,0); //Cod Plano Contas
     SetTab(NA,pjRight,6,0.5,BOXLINEALL,0); //Nom Plano contas
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); //valor orcado
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); //valor Realizado
     SetTab(NA,pjRight,2,0.5,BOXLINEALL,0); //Diferenca
     SetTab(NA,pjRight,3,0.5,BOXLINEALL,0); //Perc em relacao ao faturamento
     SaveTabs(3);
     clearTabs;
     SetTab(4.0,pjRight,3,0.5,BOXLINEALL,0); //total receitas
     SetTab(NA,pjRight,3,0.5,BOXLINEALL,0); //total despesas
     SetTab(NA,pjRight,3,0.5,BOXLINEALL,0); //valor final
     SetTab(NA,pjRight,3,0.5,BOXLINEALL,0); //% final
     SaveTabs(4);
     clearTabs;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaResumoCaixas(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1,pjLeft,3.5,0.1,Boxlinenone,0); //Banco
     SetTab(NA,pjRight,2.4,0.4,Boxlinenone,0); //Conta
     SetTab(NA,pjLeft,5,0.4,Boxlinenone,0); //Correntista
     SetTab(NA,pjRight,2.7,0,Boxlinenone,0); //Saldo Conta
     SetTab(NA,pjRight,2.7,0,Boxlinenone,0); //Val Cheques
     SetTab(NA,pjRight,2.7,0,Boxlinenone,0); //Saldo Real
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaRomaneioEtikArt(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjcenter,1.8,0.5,BOXLINEALL,0); //nro Pedido
     SetTab(NA,pjCenter,2.5,0.5,BOXLINEALL,0); //codigo Produto
     SetTab(NA,pjCenter,3.5,0.5,BOXLINEALL,0); //manequim
     SetTab(NA,pjcenter,2.3,0.5,BOXLINEALL,0); //Combinacoes
     SetTab(NA,pjCenter,1.5,0.5,BOXLINEALL,0); //fitas
     SetTab(NA,pjright,1.8,0.5,BOXLINEALL,0); //Metros fita
     SetTab(NA,pjright,2,0.5,BOXLINEALL,0); //total KM
     SetTab(NA,pjright,2.3,0.5,BOXLINEALL,0); //Val Unitario
     SetTab(NA,pjright,2.3,0.5,BOXLINEALL,0); //Val total
     SetTab(NA,pjleft,8,0.5,BOXLINEALL,0); //Descricao
     SaveTabs(1);
     clearTabs;
     SetTab(12.5,pjLeft,2,0.1,BOXLINEALL,0); //icms
     SetTab(NA,pjRight,1.9,0.5,BOXLINEALL,0); //Val icms
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaRomaneioSeparacaoCotacao(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjLeft,0.6,0.5,BOXLINEALL,0);//Sequencial
     SetTab(NA,pjLeft,1.1,0.5,BOXLINEALL,0);//codigo Produto
     SetTab(NA,pjLeft,11,0.5,BOXLINEALL,0); //nomeProduto
     SetTab(NA,pjLeft,1.5,0.5,BOXLINEALL,0); //Localição
     SetTab(NA,pjCenter,1,0.5,BOXLINEALL,0); //UM
     SetTab(NA,pjright,1.8,0.5,BOXLINEALL,0); //Quantidade
     SetTab(NA,pjright,2,0.5,BOXLINEALL,0); //Altura
     SaveTabs(1);
     clearTabs;
     SetTab(1.0,pjLeft,2.5,0.5,BOXLINEALL,0);// Notas
     SetTab(NA,pjRight,2.0,0.5,BOXLINEALL,0); //Notas
     SetTab(NA,pjRight,2.0,0.5,BOXLINEALL,0); //Notas
     SetTab(NA,pjRight,2.0,0.5,BOXLINEALL,0); //Notas
     SetTab(NA,pjRight,2.0,0.5,BOXLINEALL,0); //Notas
     SetTab(NA,pjRight,2.0,0.5,BOXLINEALL,0); //Notas
     SetTab(NA,pjRight,2.0,0.5,BOXLINEALL,0); //Notas
     SetTab(NA,pjRight,2.0,0.5,BOXLINEALL,0); //Notas
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); //Notas
     SaveTabs(2);
     clearTabs;
     SetTab(12.0,pjRight,4,0.5,BOXLINENONE,0);//Sequencial
     SetTab(NA,pjLeft,4,0.5,BOXLINEBOTTOM,0);//codigo Produto
     SaveTabs(3);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaServicosVendidosPorClassificacao(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Servico
     SetTab(NA,pjLeft,7.8,0.5,Boxlinenone,0); //nomeServico
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Valor total
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaTabelaPreco(VpaObjeto: TObject);
Var
  VpfMaiorCodigo : Integer;
  VpfTamanhoColCodigo, VpfSobraCodigoProduto : Double;
  VpfMoldura : Byte;
begin
  VpfMaiorCodigo := FunProdutos.RTamanhoMaiorCodigoProduto;
  VpfTamanhoColCodigo := VpfMaiorCodigo *0.15+ 0.1;
  VpfSobraCodigoProduto := 3.6 - VpfTamanhoColCodigo;
  if VprAgruparClassificacao  then
    VpfMoldura := BOXLINENONE
  else
    VpfMoldura := BOXLINENONE;
  if VpfMaiorCodigo > 10 then
    VpfMaiorCodigo := 10;
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,3.0,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;

     SetTab(1.2,pjLeft,VpfTamanhoColCodigo,0.5,VpfMoldura,0); //Codigo Produto

     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,8.8+VpfSobraCodigoProduto,0.5,VpfMoldura,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,9.2+VpfSobraCodigoProduto,0.5,VpfMoldura,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,11.3+VpfSobraCodigoProduto,0.5,VpfMoldura,0) //nomeproduto
         else
           SetTab(NA,pjLeft,12.3+VpfSobraCodigoProduto,0.5,VpfMoldura,0); //nomeproduto
     if config.EstoquePorCor then
     begin
       if (config.EstoquePorCor) and (config.EstoquePorTamanho) then
         SetTab(NA,pjLeft,2.6,0.2,VpfMoldura,0) //Cor
       else
         SetTab(NA,pjLeft,3.1,0.2,VpfMoldura,0); //Cor
     end;
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,VpfMoldura,0); //Tamanho
     SetTab(NA,pjRight,2.6,0,VpfMoldura,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,VpfMoldura,0); //um
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaTotalAmostraPorClienteVendedor(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,13,0.5,BOXLINENONE,0); //Vendedor
     SaveTabs(1);
     clearTabs;
     SetTab(1.0,pjleft,7.0,0.5,BOXLINEALL,0); //Vendedor
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd solicitada
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Entregue
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Aprovadas
     //SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Clientes;
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Per Aprovacao;
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaTotalAmostraporVendedor(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     SetTab(1.0,pjleft,7.0,0.5,BOXLINEALL,0); //Vendedor
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd solicitada
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Entregue
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Aprovadas
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Clientes;
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Per Aprovacao;
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaTotalTipoCotacaoXCusto(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjRight,1.0,0.5,BOXLINEALL,0); //Codigo
     SetTab(NA,pjleft,7.0,0.2,BOXLINEALL,0); //Tipo Cotacao
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Qtd Pedidos
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Total Total
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Val Produtos
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Val Custo
     SetTab(NA,pjRight,1,0.2,BOXLINEALL,0); //%Produto
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaValorFreteXValorConhecimento(
  VpaObjeto: TObject);
begin
  with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1,pjRight,2.0,0.1,BOXLINENONE,0); //nota
     SetTab(NA,pjRight,2.5,0,BOXLINENONE,0); //Valor Frete
     SetTab(6,pjCenter,3.5,0,BOXLINENONE,0); //Numero conhecimento
     SetTab(NA,pjCenter,3.5,0.2,BOXLINENONE,0); // Valor Conhecimento
     SetTab(NA,pjCenter,3,0.2,BOXLINENONE,0); // Diferenca
     SetTab(NA+ 1,pjLeft,6,0.2,BOXLINENONE,0); // Transportadora
     SaveTabs(1);

     ClearTabs;
     SetTab(3.5,pjRight,2.5,0,BOXLINENONE,0); //Total Valor Frete
     SetTab(9,pjCenter,4,0.2,BOXLINENONE,0); // Total Valor Conhecimento
     SetTab(13,pjCenter,3.5,0.2,BOXLINENONE,0); // Total Diferenca
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaAnaliseFaturamentoMensal(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,10,0.5,BoxlineNONE,0); //Vendedor
     SaveTabs(1);
     clearTabs;
     SetTab(1,pjLeft,6.5,0.1,BOXLINEALL,0); //Cliente
     SetTab(NA,pjCenter,1,0,BOXLINEALL,0); //ano
     SetTab(NA,pjRight,1.5,0,BOXLINEALL,0); //Janeiro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Fevereiro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Março
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Abril
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Maio
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Junho
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Julho
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Agosto
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Setembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Outubro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Novembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Dezembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Total
     SaveTabs(2);
     clearTabs;
     SetTab(1,pjRight,6.5,0.1,BOXLINEALL,0); //Cliente
     SetTab(NA,pjCenter,1,0,BOXLINEALL,0); //ano
     SetTab(NA,pjRight,1.5,0,BOXLINEALL,0); //Janeiro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Fevereiro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Março
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Abril
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Maio
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Junho
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Julho
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Agosto
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Setembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Outubro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Novembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Dezembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Total
     SaveTabs(3);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaAnaliseLocacaoAnalitico(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,1.9,0.5,BoxlineNONE,0); //Codigo cliente
     SetTab(NA,pjleft,12.5,0.5,BoxlineNONE,0); //Nom cliente
     SetTab(NA,pjRight,2.5,0.5,BoxlineNONE,0); //Valor Final
     SetTab(NA,pjRight,2.5,0.5,BoxlineNONE,0); //Valor final
     SaveTabs(1);
     clearTabs;
     SetTab(1.0,pjRight,2.5,0.1,Boxlinenone,0); //Filial
     SetTab(NA,pjLeft,9,0.5,Boxlinenone,0); //Filial
     SetTab(NA,pjRight,2.3,0.2,Boxlinenone,0); //Vendedor
     SetTab(NA,pjLeft,6,0.2,Boxlinenone,0); //Venddor
     SaveTabs(2);
     clearTabs;
     SetTab(1.0,pjRight,2.5,0.1,Boxlinenone,0); //Filial
     SetTab(NA,pjLeft,2.5,0.5,Boxlinenone,0); //Filial
     SetTab(NA,pjRight,2.8,0.2,Boxlinenone,0); //Vendedor
     SetTab(NA,pjLeft,4,0.2,Boxlinenone,0); //Venddor
     SetTab(NA,pjRight,4,0.2,Boxlinenone,0); //Vendedor
     SetTab(NA,pjLeft,4,0.2,Boxlinenone,0); //Venddor
     SaveTabs(3);
     clearTabs;
     SetTab(1.0,pjRight,2.5,0.1,Boxlinenone,0); //Filial
     SetTab(NA,pjLeft,2.1,0.5,Boxlinenone,0); //Filial
     SetTab(NA,pjRight,3,0.2,Boxlinenone,0); //Vendedor
     SetTab(NA,pjLeft,2.5,0.2,Boxlinenone,0); //Venddor
     SetTab(NA,pjRight,3.5,0.2,Boxlinenone,0); //Vendedor
     SetTab(NA,pjLeft,2.5,0.2,Boxlinenone,0); //Venddor
     SetTab(NA,pjRight,3.5,0.2,Boxlinenone,0); //Vendedor
     SetTab(NA,pjLeft,2.5,0.2,Boxlinenone,0); //Venddor
     SaveTabs(4);
     clearTabs;
     SetTab(1.0,pjCenter,20,0.1,BoxlineALL,0); //Filial
     SaveTabs(5);
     clearTabs;
     SetTab(1.0,pjCenter,1.5,0.1,BoxlineALL,0); //MES
     SetTab(NA,pjCenter,2.1,0.5,BoxlineALL,0); //Dl Leitura
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Qtd Copias
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Qtd Excedente
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Val Excedente PB
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Val Excedente Color
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Val Total
     SaveTabs(6);
     clearTabs;
     SetTab(1.0,pjLeft,9,0.1,BoxlineALL,0); //Equipamento
     SetTab(NA,pjleft,3.1,0.5,BoxlineALL,0); //Serie
     SetTab(NA,pjleft,2.5,0.5,BoxlineALL,0); //Setor
     SetTab(NA,pjRight,3.5,0.5,BoxlineALL,0); //Valor equipamento
     SaveTabs(7);
     clearTabs;
     SetTab(1.0,pjLeft,9.5,0.1,BoxlineALL,0); //Insumo
     SetTab(NA,pjRight,2.1,0.5,BoxlineALL,0); //Qtd
     SetTab(NA,pjRight,3.5,0.5,BoxlineALL,0); //Valor Custo
     SetTab(NA,pjRight,3.5,0.5,BoxlineALL,0); //Valor Unitario Medio
     SaveTabs(8);
     clearTabs;
     SetTab(1.0,pjLeft,7.5,0.1,BoxlineALL,0); //Cliente
     SetTab(NA,pjRight,1.5,0.5,BoxlineALL,0); //SeqContrato
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Valor Leituras
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Valor Equipamentos
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Valor Insumos Contabilizados
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Valor Insumos nao contabili
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Valor Peças
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Valor Servicos
     SetTab(NA,pjRight,2.5,0.5,BoxlineALL,0); //Valor Final
     SaveTabs(9);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaAnaliseRenovacaoContrato(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjLeft,0.6,0.5,BOXLINENONE,0);//Cod Filial
     SetTab(NA,pjLeft,1.0,0.5,BOXLINENONE,0);//Seq contrato
     SetTab(NA,pjRight,2,0.5,BOXLINENONE,0); //Codigo Cliente
     SetTab(NA,pjLeft,7,0.5,BOXLINENONE,0); //Cliente
     SetTab(NA,pjLeft,1,0.5,BOXLINENONE,0); //uf
     SetTab(NA,pjCenter,1.7,0.5,BOXLINENONE,0); //Inicio Vigencia
     SetTab(NA,pjCenter,1.7,0.5,BOXLINENONE,0); //Fim Vigencia
     SetTab(NA,pjright,2.0,0.5,BOXLINENONE,0); //Valor
     SetTab(NA,pjright,2.0,0.5,BOXLINENONE,0); //Valor  novo contrato
     SetTab(NA,pjCenter,1.5,0.5,BOXLINENONE,0); //dt assinatura
     SetTab(NA,pjCenter,1.5,0.5,BOXLINENONE,0); //inicio Vigencia novo
     SetTab(NA,pjCenter,1.5,0.5,BOXLINENONE,0); //Fim Vigencia novo
     SetTab(NA,pjRight,3.5,0.5,BOXLINENONE,0); //Vendedor
     SaveTabs(1);

     clearTabs;
     SetTab(5.0,pjLeft,1,0.5,BOXLINENONE,0);//Cod Vendedor
     SetTab(NA,pjLeft,3.0,0.5,BOXLINENONE,0);//nom vendedor
     SetTab(NA,pjRight,3,0.5,BOXLINENONE,0); //VAl contratos
     SetTab(NA,pjRight,3,0.5,BOXLINENONE,0); //VAl renovacao
     SetTab(NA,pjRight,2,0.5,BOXLINENONE,0); //% renovacao
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCartuchosPesadosPorCelula(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjLeft,5.0,0.5,BoxlineALL,0); //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,0.7,0.5,BoxlineALL,0);  //Celula
     SetTab(NA,pjCenter,1.2,0.5,BoxlineALL,0);  //Total
     SaveTabs(1);
     clearTabs;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaClientesXCobrancaporBairro(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,7.5,0.5,BoxlineNONE,0); //Nome rua
     SetTab(NA,pjleft,2,0.5,BoxlineNONE,0); //nro rua
     SetTab(NA,pjleft,7,0.5,BoxlineNONE,0); //complemento
     SetTab(NA,pjleft,3,0.5,BoxlineNONE,0); //saldo total
     SaveTabs(1);
     clearTabs;
     SetTab(1.0,pjleft,8.5,0.5,BoxlineNONE,0); //Nome rua
     SetTab(NA,pjleft,3.5,0.5,BoxlineNONE,0); //nro rua
     SetTab(NA,pjleft,4.0,0.5,BoxlineNONE,0); //complemento
     SetTab(NA,pjleft,4,0.5,BoxlineNONE,0); //saldo total
     SaveTabs(2);
     clearTabs;
     SetTab(1.0,pjleft,9,0.5,BoxlineNONE,0); //Nome rua
     SetTab(NA,pjleft,3.5,0.5,BoxlineNONE,0); //saldo anterioor
     SetTab(NA,pjleft,4.0,0.5,BoxlineNONE,0); //saldo ultima compra
     SetTab(NA,pjleft,3,0.5,BoxlineNONE,0); //Cobranca
     SaveTabs(3);
     clearTabs;
     SetTab(15.0,pjleft,6,0.5,BoxlineNONE,0); //total
     SaveTabs(4);
   end;

end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaConsumoAmostras(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(5.0,pjcenter,2.5,0.5,BOXLINEALL,0); //Quantidade Dias
     SetTab(NA,pjcenter,2.5,0.5,Boxlineall,0); //Amostras;
     SaveTabs(1);
     clearTabs;
     SetTab(5.0,pjcenter,2.5,0.5,BOXLINEALL,0); //Quantidade Dias
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); // Qtd Amostras;
     SetTab(NA,pjright,2.5,0.5,Boxlineall,0); // % Amostras
     SaveTabs(2);
     clearTabs;
     SetTab(3.0,pjRight,2.5,0.5,BOXLINEALL,0); //Codigo
     SetTab(NA,pjLeft,5,0.5,Boxlineall,0); // Nome Amotra;
     SetTab(NA,pjLeft,1,0.5,Boxlineall,0); // COR;
     SetTab(NA,pjCenter,2.5,0.5,Boxlineall,0); // DatCadatro
     SetTab(NA,pjCenter,2.5,0.5,Boxlineall,0); // Dat entrega
     SaveTabs(3);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaHistoricoConsumoProdutoProducao(VpaObjeto: TObject);
begin
  with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjLeft,15,0.5,BOXLINENONE,0);//Data
     SaveTabs(1);

     clearTabs;
     SetTab(1.0,pjRight,2.5,0.5,BOXLINENONE,0);//Cod Produto
     SetTab(NA,pjLeft,8,0.5,BOXLINENONE,0);//Nom Produto
     SetTab(NA,pjLeft,3,0.5,BOXLINENONE,0); //Cor
     SetTab(NA,pjRight,1,0.5,BOXLINENONE,0); //UN
     SetTab(NA,pjRight,3,0.5,BOXLINENONE,0); //Quantidade
     SaveTabs(2);

     clearTabs;
     SetTab(5.0,pjRight,3,0.5,BOXLINENONE,0);//Total
     SetTab(NA,pjRight,3,0.5,BOXLINENONE,0);// Val Total
     SaveTabs(3);

     ClearTabs;
     SetTab(5.0,pjRight,3,0.5,BOXLINENONE,0);//Total
     SetTab(NA,pjRight,3,0.5,BOXLINENONE,0);// Val Total dia
     SaveTabs(4);

     ClearTabs;
     SetTab(1.0,pjRight,3,0.5,BOXLINENONE,0);//cod classificacao
     SetTab(NA,pjRight,8,0.5,BOXLINENONE,0);// Nom Classificacao
     SaveTabs(5);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaContratoAssinados(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjLeft,0.6,0.5,BOXLINENONE,0);//Cod Filial
     SetTab(NA,pjLeft,1.0,0.5,BOXLINENONE,0);//Seq contrato
     SetTab(NA,pjRight,2,0.5,BOXLINENONE,0); //Codigo Cliente
     SetTab(NA,pjLeft,7,0.5,BOXLINENONE,0); //Cliente
     SetTab(NA,pjLeft,1,0.5,BOXLINENONE,0); //uf
     SetTab(NA,pjCenter,1.7,0.5,BOXLINENONE,0); //Inicio Vigencia
     SetTab(NA,pjCenter,1.7,0.5,BOXLINENONE,0); //Fim Vigencia
     SetTab(NA,pjright,2.0,0.5,BOXLINENONE,0); //Valor
     SetTab(NA,pjright,2.0,0.5,BOXLINENONE,0); //Valor  novo contrato
     SetTab(NA,pjCenter,1.5,0.5,BOXLINENONE,0); //dt assinatura
     SetTab(NA,pjCenter,1.5,0.5,BOXLINENONE,0); //inicio Vigencia novo
     SetTab(NA,pjCenter,1.5,0.5,BOXLINENONE,0); //Fim Vigencia novo
     SetTab(NA,pjRight,3.5,0.5,BOXLINENONE,0); //Vendedor
     SaveTabs(1);

     clearTabs;
     SetTab(5.0,pjLeft,1,0.5,BOXLINENONE,0);//Cod Vendedor
     SetTab(NA,pjLeft,3.0,0.5,BOXLINENONE,0);//nom vendedor
     SetTab(NA,pjRight,3,0.5,BOXLINENONE,0); //VAl contratos
     SetTab(NA,pjRight,3,0.5,BOXLINENONE,0); //VAl renovacao
     SetTab(NA,pjRight,2,0.5,BOXLINENONE,0); //% renovacao
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCPporPlanoContas(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo planoContas
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomPlanoContas
     SaveTabs(1);
     clearTabs;
     SetTab(1.5,pjLeft,7.8,0.1,Boxlinenone,0); //Fornecedor
     SetTab(NA,pjRight,1.9,0.5,Boxlinenone,0); //nro Nota
     SetTab(NA,pjCenter,2.0,0.2,Boxlinenone,0); //vencimento
     SetTab(NA,pjRight,2.5,0.2,Boxlinenone,0); //Valor a pagar
     SetTab(NA,pjCenter,2.0,0,Boxlinenone,0); //DtPagamento
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor  PAGO
     SaveTabs(2);
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Valor Previsto
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total Pago
     SaveTabs(3);
     clearTabs;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCPporPlanoContasSintetico(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.8,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo planoContas
     SetTab(NA,pjleft,7.5,0.5,BoxlineNONE,0); //NomPlanoContas
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor a pagar
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor pago
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor total
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor previsto
     SetTab(NA,pjRight,1.7,0.5,Boxlinenone,0); //% diferenca
     SaveTabs(1);
   end;

end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCPporPlanoContasSinteticoporMes(VpaObjeto: TObject);
begin
  with RVSystem.BaseReport do begin
    clearTabs;
    SetTab(0.8,pjleft,2,0.5,BoxlineNONE,0); //Codigo planoContas
    SetTab(NA,pjleft,4.5,0.5,BoxlineNONE,0); //NomPlanoContas
    SetTab(NA,pjLeft,0.65,0.1,Boxlinenone,0); //Ano
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Janeiro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Fevereiro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Marco
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Abril
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Maio
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Junho
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Julho
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Agosto
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Setembro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Outubro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Novembro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Dezembro
    SetTab(NA,pjRight,1.65,0.1,Boxlinenone,0); //Total
    SaveTabs(1);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCreditoCliente(VpaObjeto: TObject);
begin
  with RVSystem.BaseReport do begin
    clearTabs;
    SetTab(0.8,pjleft,11,0.5,BoxlineNONE,0); //Cliente
    SetTab(NA,pjRight,2.5,0.5,BoxlineNONE,0); //Valor Credito
    SetTab(NA,pjRight,2.5,0.1,Boxlinenone,0); //Valor Debito
    SetTab(NA,pjRight,3.0,0.1,Boxlinenone,0); //Total
    SaveTabs(1);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCustoProjeto(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo planoContas
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomPlanoContas
     SaveTabs(1);
     clearTabs;
     SetTab(1.5,pjLeft,9,0.1,Boxlinenone,0); //Fornecedor
     SetTab(NA,pjRight,1.9,0.5,Boxlinenone,0); //nro Nota
     SetTab(NA,pjCenter,2.0,0.2,Boxlinenone,0); //Emissão
     SetTab(NA,pjRight,2.5,0.2,Boxlinenone,0); //Valor a pagar
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Percentual Conta
     SaveTabs(2);
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Valor Previsto
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total Pago
     SaveTabs(3);
     clearTabs;
     SetTab(2.0,pjCenter,18,0.5,BoxlineNONE,0);
     SaveTabs(4);
     clearTabs;
     SetTab(1.0,pjRight,1.3,0.5,BOXLINEALL,0);//FRACAO
     SetTab(NA,pjLeft,6.7,0.5,BOXLINEALL,0);//MATERIAPRIMA
     SetTab(NA,pjRight,1.3,0.5,BOXLINEALL,0);//ALTURA
     SetTab(NA,pjRight,1.5,0.5,BOXLINEALL,0);//LARGURA
     SetTab(NA,pjRight,1.1,0.5,BOXLINEALL,0);//PESO
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0);//QtdBaixado
     SetTab(NA,pjRight,2,0.5,BOXLINEALL,0);//Valor Unitario
     SetTab(NA,pjCenter,0.8,0.5,BOXLINEALL,0);//UM
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0);//Valor Total
     SaveTabs(5);
     clearTabs;
     SetTab(18.0,pjRight,2.3,0.5,BOXLINEALL,0);//FRACAO
     SaveTabs(6);
     clearTabs;
     SetTab(13.0,pjRight,5,0.5,BOXLINENONE,0);//FRACAO
     SetTab(18.0,pjRight,2.3,0.5,BOXLINENONE,0);//FRACAO
     SaveTabs(7);
     clearTabs;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaDemandaCompra(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,3.0,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,7.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,8.2,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,10.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,11.3,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) and (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0); //Cor
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd Mes 
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //QtdMes
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //QtdMes
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //QtdMes
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //QtdMes
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd Em Transito Pedido Compra
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Sugestao Compra

     SaveTabs(2);
   end;
  
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaEntradaMetro(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,5.0,0.5,BOXLINEALL,0); //Familia
     SetTab(NA,pjCenter,7,0.5,BOXLINEALL,0); //Amostra
     SetTab(NA,pjCenter,7,0.5,BOXLINEALL,0); //Pedido
     SetTab(NA,pjCenter,7,0.5,BOXLINEALL,0); //Total
     SaveTabs(1);
     clearTabs;
     SetTab(1.0,pjleft,5.0,0.5,BOXLINEALL,0); //Familia
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Qtd Metros Amostra
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Valor Amostra
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Qtd Metros Pedido
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Valor Pedidos
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Qtd Metros Total
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Valor Total
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaExtratoProdutividade(VpaObjeto : TObject);
var
  VpfLaco : Integer;
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.8,pjLeft,4,0.1,BOXLINEALL,0); //CelulaTrabalho
     for VpfLaco := 1 to 31 do
       SetTab(NA,pjRight,0.75,0,BOXLINEALL,0); //Dia do mes
     SetTab(NA,pjRight,1.3,0,BOXLINEALL,0); //Dia do mes
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaFechamentoEstoque(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,1.2,0.1,Boxlinenone,0); //Codigo Produto
     SetTab(NA,pjLeft,9.4,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjRight,2.2,0,Boxlinenone,0); //qtd vendas
     SetTab(NA,pjRight,2.2,0,Boxlinenone,0); //Valor Vendas
     SetTab(NA,pjRight,2.2,0,Boxlinenone,0); //custo
     SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //margem
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaFluxoCaixaDiario(VpaObjeto: TObject);
var
  VpfLaco : Integer;
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.7,pjLeft,19.6,0.5,BOXLINENONE,0);
     SaveTabs(1);
     clearTabs;
     SetTab(0.7,pjleft,2.5,0.5,BOXLINEALL,0); //titulo
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); // Aplicacao
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); // Saldo Atual
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); //Saldo Anterior
     for VpfLaco := 1 to 31 do
       SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); //dia 1
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaLivroRegistroSaidas(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.7,pjCenter,19.6,0.5,BOXLINEALL,0);
     SaveTabs(1);
     clearTabs;
     SetTab(0.7,pjLeft,11.6,0.5,BOXLINEALL,0);
     SetTab(NA,pjRight,8,0.5,BOXLINEALL,0); //
     SaveTabs(2);
     clearTabs;
     SetTab(0.7,pjCenter,0.5,0.5,BOXLINEALL,0); //especie
     SetTab(NA,pjleft,0.5,0.5,BOXLINEALL,0); // serie
     SetTab(NA,pjRight,1.3,0.5,BOXLINEALL,0); //numero
     SetTab(NA,pjCenter,0.75,0.5,BOXLINEALL,0); //dia
     SetTab(NA,pjCenter,0.75,0.5,BOXLINEALL,0); //uf
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); //valor contabio
     SetTab(NA,pjleft,0.5,0.5,BOXLINEALL,0); //chave
     SetTab(NA,pjCenter,1.0,0.5,BOXLINEALL,0); //cfop
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0); //base de calculos
     SetTab(NA,pjleft,0.6,0.5,BOXLINEALL,0); //aliquota
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0); //imposto debitado
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0);//isenta ou nao isentas
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0);  //outras
     SetTab(NA,pjleft,2.6,0.5,BOXLINEALL,0);//observacoes
     SaveTabs(3);
     clearTabs;
     SetTab(0.7,pjRight,3.80,0.5,BOXLINEALL,0); //especie
     SetTab(NA,pjRight,2.3,0.5,BOXLINEALL,0); //valor contabio
     SetTab(NA,pjleft,0.5,0.5,BOXLINEALL,0); //chave
     SetTab(NA,pjCenter,1.0,0.5,BOXLINEALL,0); //cfop
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0); //base de calculos
     SetTab(NA,pjleft,0.6,0.5,BOXLINEALL,0); //aliquota
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0); //imposto debitado
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0);//isenta ou nao isentas
     SetTab(NA,pjRight,2.2,0.5,BOXLINEALL,0);  //outras
     SetTab(NA,pjleft,2.6,0.5,BOXLINEALL,0);//observacoes
     SaveTabs(4);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaOPEtikArt(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.5,pjright,2.1,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,3.3,0.5,BoxlineNONE,0);
     SetTab(NA,pjright,2.2,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,1.9,0.5,BoxlineNONE,0);
     SaveTabs(1);
     clearTabs;
     SetTab(0.5,pjright,2.1,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,1.5,0.5,BoxlineNONE,0);
     SetTab(NA,pjright,1.5,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,1.5,0.5,BoxlineNONE,0);
     SetTab(NA,pjright,2.0,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,0.9,0.5,BoxlineNONE,0);
     SaveTabs(2);
     clearTabs;
     SetTab(0.5,pjright,2.1,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,7.4,0.5,BoxlineNONE,0);
     SaveTabs(3);
     clearTabs;
     SetTab(0.5,pjcenter,9.5,0.5,BoxlineNONE,0);
     SaveTabs(4);
     clearTabs;
     SetTab(0.5,pjCenter,0.7,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,0.7,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjleft,3.6,0.5,BoxlineNONE,0);//cor
     SetTab(NA,pjleft,2.5,0.5,BoxlineNONE,0);//titulo
     SetTab(NA,pjright,2.0,0.5,BoxlineNONE,0);//fundo
     SaveTabs(5);
     clearTabs;
     SetTab(0.5,pjCenter,0.7,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,0.7,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjleft,2.6,0.5,BoxlineNONE,0);//cor
     SetTab(NA,pjleft,2.0,0.5,BoxlineNONE,0);//titulo
     SetTab(NA,pjright,1.5,0.5,BoxlineNONE,0);//fundo
     SetTab(NA,pjright,2.0,0.5,BoxlineNONE,0);//Qtd Peças
     SaveTabs(6);
     clearTabs;
     SetTab(0.5,pjcenter,1.9,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SaveTabs(7);
     clearTabs;
     SetTab(0.5,pjCenter,0.7,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,1.2,0.5,BoxlineNONE,0); //manequim
     SetTab(NA,pjright,3,0.5,BoxlineNONE,0);//metros por fita;
     SetTab(NA,pjright,2.5,0.5,BoxlineNONE,0);//Qtd Fitas
     SaveTabs(8);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaOPFabricaCardarcodeFita(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     ClearAllTabs;
     clearTabs;
     SetTab(0.5,pjleft,19.5,0.5,BoxlineALL,0);
     SaveTabs(1);


     clearTabs;
     SetTab(0.5,pjLeft,9.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,9.8,0.5,BoxlineALL,0);
     SaveTabs(2);

     clearTabs;
     SetTab(0.5,pjLeft,1.5,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,5.0,0.5,BoxlineALL,0); // NOME CLIENTE
     SetTab(NA,pjLeft,1.2,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,2.0,0.5,BoxlineALL,0); // TEAR
     SetTab(NA,pjLeft,1.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,2.5,0.5,BoxlineALL,0); // NR PEDIDO
     SetTab(NA,pjLeft,3.0,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,2.4,0.5,BoxlineALL,0); // DATA ENTREGA
     SaveTabs(3);

     clearTabs;
     SetTab(0.5,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Pol Trama
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Alg Trama
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Polia Trama
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Polipr Trama
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Fio Costura Trama
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Pol Ajuda
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Alg Ajuda
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Polia Ajuda
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Polipr Ajuda
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0); // Fio Costura Ajuda
     SaveTabs(4);

     clearTabs;
     SetTab(0.5,pjLeft,1.5,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,4.2,0.5,BoxlineALL,0);  // Cod Produto
     SetTab(NA,pjLeft,2.5,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.9,0.5,BoxlineALL,0);  // NR FITAS
     SetTab(NA,pjLeft,2.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,2.0,0.5,BoxlineALL,0); // Nome Produto
     SetTab(NA,pjLeft,2.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.9,0.5,BoxlineALL,0); // Nr de Quadros
     SaveTabs(5);

     clearTabs;
     SetTab(0.5,pjLeft,3.2,0.5,BoxlineALL,0);  // Engrenagens Bat.
     SetTab(NA,pjCenter,2.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.6,0.5,BoxlineALL,0);
     SetTab(NA,pjCenter,0.9,0.5,BoxlineALL,0);  // Sistema 1
     SetTab(NA,pjCenter,0.9,0.5,BoxlineALL,0);  // x
     SetTab(NA,pjCenter,0.9,0.5,BoxlineALL,0);  // Sistema 2
     SetTab(NA,pjCenter,0.9,0.5,BoxlineALL,0);  // x
     SetTab(NA,pjLeft,3.5,0.5,BoxlineALL,0);
     SetTab(NA,pjCenter,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.5,0.5,BoxlineALL,0); // Engrenagens trama
     SetTab(NA,pjCenter,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.8,0.5,BoxlineALL,0); // Engrenagens trama
     SaveTabs(6);

     clearTabs;
     SetTab(0.5,pjLeft,2.5,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,2.0,0.5,BoxlineALL,0); // Bat. P/cm
     SetTab(NA,pjLeft,3.0,0.5,BoxlineALL,0); // Pente
     SaveTabs(7);

     clearTabs;
     SetTab(0.5,pjLeft,2.4,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);  // X
     SetTab(NA,pjLeft,1.4,0.5,BoxlineALL,0);  // Sim
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);  // X
     SetTab(NA,pjLeft,1.4,0.5,BoxlineALL,0);  // Nao
     SetTab(NA,pjLeft,2.5,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.4,0.5,BoxlineALL,0); // Nao
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.4,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,2.1,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,3.7,0.5,BoxlineALL,0);
     SaveTabs(8);

     clearTabs;
     SetTab(0.5,pjLeft,4.3,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.1,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.1,0.5,BoxlineALL,0); // n1
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.1,0.5,BoxlineALL,0); // n2
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.1,0.5,BoxlineALL,0); // n3
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.1,0.5,BoxlineALL,0); // n4
     SetTab(NA,pjLeft,0.8,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.1,0.5,BoxlineALL,0); // n5
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SaveTabs(9);

     clearTabs;
     SetTab(0.5,pjLeft,1.0,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.3,0.5,BoxlineALL,0); // n6
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.0,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.3,0.5,BoxlineALL,0); // n7
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.0,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.3,0.5,BoxlineALL,0); // n8
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.0,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.3,0.5,BoxlineALL,0); // n9
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.0,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.3,0.5,BoxlineALL,0); // n10
     SetTab(NA,pjLeft,0.9,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.0,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.3,0.5,BoxlineALL,0); // n11
     SetTab(NA,pjLeft,1.2,0.5,BoxlineALL,0);
     SaveTabs(10);


     clearTabs;
     SetTab(0.5,pjLeft,1.5,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SetTab(NA,pjLeft,1.7,0.5,BoxlineALL,0);
     SaveTabs(14);

     clearTabs;
     SetTab(0.5,pjLeft,1.7,0.5,BoxlineALL,0);
     SaveTabs(15);

   end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutoPorClassificacao(VpaObjeto : TObject);
var
  VpfQtdProduto,VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VprUfAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
          VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
          VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
        end;

        if VprAgruparPorEstado and (VprUFAtual <> Tabela.FieldByName('C_EST_CLI').AsString)  then
        begin
          ImprimeTotaisNiveis(VprNiveis,0);
          ImprimeTituloUF(Tabela.FieldByName('C_EST_CLI').AsString);
          VprUFAtual := Tabela.FieldByName('C_EST_CLI').AsString;
          VpfClassificacaoAtual := '';
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('UMPADRAO').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
      end;
      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('I_COD_TAM').AsInteger);

      if VprConverterKilo then
      begin
        VpfQtdProduto := FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
        VpfQtdProduto := VpfQtdProduto * Tabela.FieldByName('N_PES_BRU').AsFloat;
        VpfDProduto.DesUM := 'KG';
      end
      else
        VpfQtdProduto := FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdproduto;
      VpfDProduto.ValEstoque := VpfDProduto.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;

      vpfDCor.QtdEstoque := vpfDCor.QtdEstoque+ VpfQtdproduto;
      VpfDCor.ValEstoque := VpfDCor.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      VpfDTamanho.QtdEstoque := VpfDTamanho.QtdEstoque + VpfQtdproduto;
      VpfDTamanho.ValEstoque := VpfDTamanho.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;

      VpfQtdGeral := VpfQTdGeral + VpfQtdProduto;
      VpfValGeral := VpfValGeral + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);

    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
      VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
      VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    if config.EstoquePorCor then
      PrintTab('');
    if config.EstoquePorTamanho then
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaPrecoPorCoreTamanho(VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho : Integer;
  VpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(' '+VpaDProduto.NomProduto);
    VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[0]);
    VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count = 1) then
      begin
        if config.EstoquePorCor then
        begin
          if (VpfDCor.CodCor <> 0) then
            PrintTab(VpfDCor.NomCor)
          else
            PrintTab('');
        end;
        if config.EstoquePorTamanho then
        begin
          if (VpfDCor.Tamanhos.Count = 1) then
          begin
            if (VpfDTamanho.CodTamanho <> 0) then
              PrintTab(VpfDTamanho.NomTamanho)
            else
              PrintTab('');
          end;
        end;
      end
      else
      begin
        if config.EstoquePorCor then
          PrintTab('');
        if config.EstoquePorTamanho then
          PrintTab('');
      end;
    end;
    PrintTab(FormatFloat(VpaDProduto.DesCifraoMoeda+ ' '+ varia.MascaraValorTabelaPreco,VpaDProduto.ValEstoque));
    PrintTab('  '+VpaDProduto.DesUM);
    newline;
    If LinesLeft<=1 Then
      NewPage;
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count > 1) or (VpfDCor.Tamanhos.count > 1) then
      begin
        for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
        begin
          VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
          PrintTab('');//codigo produto
          PrintTab('');//nome produto
          PrintTab(IntToStr(VpfDCor.CodCor)+'-'+ VpfDCor.NomCor);
          if (VpfDCor.Tamanhos.Count = 1) and
              config.EstoquePorTamanho then
          begin
            VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
            PrintTab(VpfDTamanho.NomTamanho);
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
          end
          else
          begin
            if config.EstoquePorTamanho then
              PrintTab('');//tamanho
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDCor.QtdEstoque));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDCor.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
            if config.EstoquePorTamanho then
            begin
              for vpfLacoTamanho := 0 to VpfDCor.Tamanhos.Count - 1 do
              begin
                VpfDtamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[VpfLacoTamanho]);
                PrintTab('');//codigo produto
                PrintTab('');//nome produto
                PrintTab('');//cor
                PrintTab(VpfDTamanho.NomTamanho);
                PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
                PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
                newline;
                If LinesLeft<=1 Then
                  NewPage;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaProdutosComDefeito(VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho : Integer;
  VpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
  VpfPerDefeito : Double;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(VpaDProduto.NomProduto);
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdEstoque));
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.QtdTrocada));
    if (VpaDProduto.QtdEstoque > 0) and (VpaDProduto.QtdTrocada > 0) then
    begin
      vpfperDefeito := (VpaDProduto.QtdTrocada*100)/VpaDProduto.QtdEstoque;
      if VpfPerDefeito > 15 then
        FontColor := clred;
      if VpfPerDefeito > 50 then
        Bold := true;
      PrintTab(FormatFloat('0.00%',VpfPerDefeito));
      FontColor := clBlack;
      Bold := false;
    end
    else
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.ValTroca));
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaProdutosDemandaCompra(VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho, VpfLacoVenda : Integer;
  VpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
  VpfDVendaMes : TRBDVendaMesProduto;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(VpaDProduto.NomProduto);
    VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[0]);
    VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count = 1) then
      begin
        if config.EstoquePorCor then
        begin
          if (VpfDCor.CodCor <> 0) then
            PrintTab(VpfDCor.NomCor)
          else
            PrintTab('');
        end;
        if config.EstoquePorTamanho then
        begin
          if (VpfDCor.Tamanhos.Count = 1) then
          begin
            if (VpfDTamanho.CodTamanho <> 0) then
              PrintTab(VpfDTamanho.NomTamanho)
            else
              PrintTab('');
          end;
        end;
      end
      else
      begin
        if config.EstoquePorCor then
          PrintTab('');
        if config.EstoquePorTamanho then
          PrintTab('');
      end;
    end;
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdEstoque));
    PrintTab('  '+VpaDProduto.DesUM);
    for VpfLacoVenda := 0 to 2 do
    begin
      if VpfLacoVenda < VpaDProduto.Vendas.Count then
      begin
        VpfDVendaMes := TRBDVendaMesProduto(VpaDProduto.Vendas.Items[VpfLacoVenda]);
        PrintTab(FormatFloat(varia.MascaraQtd,VpfDVendaMes.QtdVendida));
      end
      else
        PrintTab('');
    end;
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdComprada));

    newline;
    If LinesLeft<=1 Then
      NewPage;
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count > 1) or (VpfDCor.Tamanhos.count > 1) then
      begin
        for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
        begin
          VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
          PrintTab('');//codigo produto
          PrintTab('');//nome produto
          PrintTab(IntToStr(VpfDCor.CodCor)+'-'+ VpfDCor.NomCor);
          if (VpfDCor.Tamanhos.Count = 1) and
              config.EstoquePorTamanho then
          begin
            VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
            PrintTab(VpfDTamanho.NomTamanho);
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
            if (RvSystem.Tag = 48) then //relatorio de consumo produto
              PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.QtdProduzido))
            else
              PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
          end
          else
          begin
            if config.EstoquePorTamanho then
              PrintTab('');//tamanho
            if (RvSystem.Tag = 48) then //relatorio de consumo produto
              PrintTab(FormatFloat(varia.MascaraQtd,VpfDCor.QtdEstoque))
            else
              PrintTab(FormatFloat(varia.MascaraQtd,VpfDCor.QtdProduzido));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDCor.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
            if config.EstoquePorTamanho then
            begin
              for vpfLacoTamanho := 0 to VpfDCor.Tamanhos.Count - 1 do
              begin
                VpfDtamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[VpfLacoTamanho]);
                PrintTab('');//codigo produto
                PrintTab('');//nome produto
                PrintTab('');//cor
                PrintTab(VpfDTamanho.NomTamanho);
                if (RvSystem.Tag = 48) then //relatorio de consumo produto
                  PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque))
                else
                  PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdProduzido));
                PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
                newline;
                If LinesLeft<=1 Then
                  NewPage;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaProdutosFaturadosPorPeriodo(
  VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho : Integer;
  VpfDCor : TRBDCorProdutoRave;
//  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(VpaDProduto.NomProduto);
    VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[0]);
    if config.EstoquePorCor  then
    begin
      if (VpaDProduto.Cores.Count = 1) then
      begin
        if config.EstoquePorCor then
        begin
          if (VpfDCor.CodCor <> 0) then
            PrintTab(VpfDCor.NomCor)
          else
            PrintTab('');
        end;
      end
      else
      begin
        if config.EstoquePorCor then
          PrintTab('');
      end;
    end;
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdEstoque));
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.ValEstoque));
    if (RvSystem.Tag = 16) then //relatorio de produtos vendidos e trocados
    begin                       //adiciona nas proximas colunas os valores das trocas;
      SalvaTabelaTrocasProdutos(VpaDProduto);
      exit;
    end;
    PrintTab('  '+VpaDProduto.DesUM);
    newline;
    If LinesLeft<=1 Then
      NewPage;
    if config.EstoquePorCor then
    begin
      if (VpaDProduto.Cores.Count > 1) then
      begin
        for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
        begin
          VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
          PrintTab('');//codigo produto
          PrintTab('');//nome produto
          PrintTab(IntToStr(VpfDCor.CodCor)+'-'+ VpfDCor.NomCor);
          PrintTab('');//codigo produto
          PrintTab('');//nome produto
          PrintTab('');//cor
          newline;
          If LinesLeft<=1 Then
           NewPage;
          end;
            end;
          end;
        end;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaProdutosPorCoreTamanho(VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho : Integer;
  VpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(VpaDProduto.NomProduto);
    VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[0]);
    VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count = 1) then
      begin
        if config.EstoquePorCor then
        begin
          if (VpfDCor.CodCor <> 0) then
            PrintTab(VpfDCor.NomCor)
          else
            PrintTab('');
        end;
        if config.EstoquePorTamanho then
        begin
          if (VpfDCor.Tamanhos.Count = 1) then
          begin
            if (VpfDTamanho.CodTamanho <> 0) then
              PrintTab(VpfDTamanho.NomTamanho)
            else
              PrintTab('');
          end;
        end;
      end
      else
      begin
        if config.EstoquePorCor then
          PrintTab('');
        if config.EstoquePorTamanho then
          PrintTab('');
      end;
    end;
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdEstoque));
    if (RvSystem.Tag = 48) then //relatorio de consumo produto
      PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdProduzido))
    else
      PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.ValEstoque));

    if (RvSystem.Tag = 16) then //relatorio de produtos vendidos e trocados
    begin                       //adiciona nas proximas colunas os valores das trocas;
      SalvaTabelaTrocasProdutos(VpaDProduto);
      exit;
    end;
    PrintTab('  '+VpaDProduto.DesUM);

    newline;
    If LinesLeft<=1 Then
      NewPage;
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count > 1) or (VpfDCor.Tamanhos.count > 1) then
      begin
        for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
        begin
          VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
          PrintTab('');//codigo produto
          PrintTab('');//nome produto
          PrintTab(IntToStr(VpfDCor.CodCor)+'-'+ VpfDCor.NomCor);
          if (VpfDCor.Tamanhos.Count = 1) and
              config.EstoquePorTamanho then
          begin
            VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
            PrintTab(VpfDTamanho.NomTamanho);
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
            if (RvSystem.Tag = 48) then //relatorio de consumo produto
              PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.QtdProduzido))
            else
              PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
          end
          else
          begin
            if config.EstoquePorTamanho then
              PrintTab('');//tamanho
            if (RvSystem.Tag = 48) then //relatorio de consumo produto
              PrintTab(FormatFloat(varia.MascaraQtd,VpfDCor.QtdEstoque))
            else
              PrintTab(FormatFloat(varia.MascaraQtd,VpfDCor.QtdProduzido));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDCor.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
            if config.EstoquePorTamanho then
            begin
              for vpfLacoTamanho := 0 to VpfDCor.Tamanhos.Count - 1 do
              begin
                VpfDtamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[VpfLacoTamanho]);
                PrintTab('');//codigo produto
                PrintTab('');//nome produto
                PrintTab('');//cor
                PrintTab(VpfDTamanho.NomTamanho);
                if (RvSystem.Tag = 48) then //relatorio de consumo produto
                  PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque))
                else
                  PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdProduzido));
                PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
                newline;
                If LinesLeft<=1 Then
                  NewPage;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
procedure TRBFunRave.SalvaTabelaTrocasProdutos(VpaDProduto: TRBDProdutoRave);
begin
  CarValorTrocasProdutos(VpaDProduto,VprDatInicio,VprDatFim,VpaDProduto.SeqProduto);
  with RVSystem.BaseReport do
  begin
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdTrocada));
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.ValTroca));
    if (VpaDProduto.QtdEstoque <> 0) and (VpaDProduto.QtdTrocada <> 0) then
      PrintTab(FormatFloat('#,##0.00 %',(VpaDProduto.QtdTrocada *100)/VpaDProduto.QtdEstoque ));
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelEstoqueProdutos(VpaObjeto : TObject);
var
  VpfQtdProduto, VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual, VpfUM : string;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VpfDClassificacao := nil;
  VpfDProduto := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        if VpfDProduto <> nil then
          VpfDProduto.free;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('C_COD_UNI').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
//       if varia.CNPJFilial = CNPJ_AtelierduCristal then
//         PrintTab(Tabela.FieldByName('C_BAR_FOR').AsString)
      end;

      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('I_COD_TAM').AsInteger);

      if RvSystem.Tag = 2 then
        VpfQtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat
      else
        if RvSystem.Tag = 12 then
          VpfQtdProduto := Tabela.FieldByName('N_QTD_RES').AsFloat;

      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdProduto;
      VpfDProduto.ValEstoque := VpfDProduto.ValEstoque + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      vpfDCor.QtdEstoque := vpfDCor.QtdEstoque+ VpfQtdProduto;
      VpfDCor.ValEstoque := VpfDCor.ValEstoque + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      VpfDTamanho.QtdEstoque := VpfDTamanho.QtdEstoque + VpfQtdProduto;
      VpfDTamanho.ValEstoque := VpfDTamanho.ValEstoque + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);

      VpfQtdGeral := VpfQTdGeral +VpfQtdProduto;
      VpfValGeral := VpfValGeral + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);
    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    if config.EstoquePorCor then
      PrintTab('');
    if config.EstoquePorTamanho then
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotaisNiveis(VpaNiveis : TList;VpaIndice : integer);
var
  VpfLaco : Integer;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfQtdProduto, VpfQtdConsumida, VpfValTotal,VpfQtdAnterior, VpfQtdVenda, VpfValAnterior,VpfValVenda, VpfValCustoVenda, VpfQtdTrocado,VpfValTrocado : Double;
begin
  VpfQtdproduto := 0;
  VpfQtdConsumida := 0;
  VpfValTotal := 0;
  VpfQtdAnterior := 0;
  VpfQtdVenda := 0;
  VpfValAnterior := 0;
  VpfValVenda := 0;
  VpfValCustoVenda := 0;
  for Vpflaco  := VpaNiveis.count -1 downto VpaIndice  do
  begin
    VpfDClassificacao := TRBDClassificacaoRave(VpaNiveis.items[VpfLaco]);
    with RVSystem.BaseReport do
    begin
      if VpfLaco = 0 then
      begin
        SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
        FillRect(CreateRect(MarginLeft-0.1,YPos+LineHeight-1+0.3,PageWidth-0.3,YPos+0.1));
      end;
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto + VpfQtdProduto;
      VpfDClassificacao.QtdConsumido := VpfDClassificacao.QtdConsumido + VpfQtdConsumida;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfValTotal;
      VpfDClassificacao.QtdMesAnterior := VpfDClassificacao.QtdMesAnterior + VpfQtdAnterior;
      VpfDClassificacao.ValAnterior := VpfDClassificacao.ValAnterior + VpfValAnterior;
      VpfDClassificacao.QtdVenda := VpfDClassificacao.QtdVenda + VpfQtdVenda;
      VpfDClassificacao.QtdTrocado  := VpfDClassificacao.QtdTrocado + VpfQtdTrocado;
      VpfDClassificacao.ValTrocado  := VpfDClassificacao.QtdTrocado + VpfValTrocado;
      VpfDClassificacao.ValVenda := VpfDClassificacao.ValVenda + VpfValVenda;
      VpfDClassificacao.ValCustoVenda := VpfDClassificacao.ValCustoVenda + VpfValCustoVenda;
      PrintTab('');
      if VpfLaco > 0 then
        PrintTab('Total Classificação : '+VpfDClassificacao.CodClassificacao+'-'+VpfDClassificacao.NomClassificacao)
      else
      begin
        if VprAgruparPorEstado then
          PrintTab('Total '+VprUfAtual)
        else
          PrintTab('');
      end;

      bold := true;
      if RvSystem.tag = 6 then
      begin
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QtdVenda));
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.ValVenda));
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.ValCustoVenda));
        if VpfDClassificacao.ValCustoVenda <> 0  then
          PrintTab(FormatFloat('#,##0.00%',(((VpfDClassificacao.ValVenda/VpfDClassificacao.ValCustoVenda)-1)*100)))
        else
          PrintTab(FormatFloat('0.00%',0));
      end
      else
        if RvSystem.tag = 19 then
        begin
          PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QTdProduto));
          PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QtdTrocado));
          if (VpfDClassificacao.QTdProduto <> 0) and  (VpfDClassificacao.QtdTrocado <> 0) then
            PrintTab(FormatFloat('0.00%',(VpfDClassificacao.QtdTrocado*100)/VpfDClassificacao.QTdProduto))
          else
            PrintTab('');
          PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.VAlTrocado));
        end
        else
          if RvSystem.tag = 33 then
          begin
            PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QTdProduto));
            PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.ValTotal));
          end
          else
            if RvSystem.tag = 48 then
            begin
              PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QTdProduto));
              PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QtdConsumido));
            end
            else
            begin
              if config.EstoquePorCor then
                PrintTab('');
              if config.EstoquePorTamanho then
                PrintTab('');
              if RvSystem.Tag = 4 then
              begin
                PrintTab('');
                PrintTab('');
              end;
              PrintTab(FormatFloat(varia.MascaraQtd,VpfDClassificacao.QtdProduto));
              if RvSystem.Tag = 4 then
                PrintTab('');
              PrintTab(FormatFloat(varia.MascaraValor,VpfDClassificacao.ValTotal));
              if RvSystem.tag = 16 then//produtos trocados
              begin
                PrintTab(FormatFloat(varia.MascaraQtd,VpfDClassificacao.QtdTrocado));
                PrintTab(FormatFloat(varia.MascaraQtd,VpfDClassificacao.VAlTrocado));
                if (VpfDClassificacao.QTdProduto <> 0) and (VpfDClassificacao.QtdTrocado <> 0) then
                  PrintTab(FormatFloat('#,##0.00 %',(VpfDClassificacao.QtdTrocado *100)/VpfDClassificacao.QTdProduto ));
              end;
              PrintTab('  ');
            end;
      VpfQtdProduto := VpfDClassificacao.QtdProduto;
      VpfQtdConsumida := VpfDClassificacao.QtdConsumido;
      VpfValTotal := VpfDClassificacao.ValTotal;
      VpfQtdAnterior := VpfDClassificacao.QtdMesAnterior;
      VpfValAnterior := VpfDClassificacao.ValAnterior;
      VpfQtdVenda := VpfDClassificacao.QtdVenda;
      VpfValVenda := VpfDClassificacao.ValVenda;
      VpfValCustoVenda := VpfDClassificacao.ValCustoVenda;
      VpfQtdTrocado := VpfDClassificacao.QtdTrocado;
      VpfValTrocado := VpfDClassificacao.VAlTrocado;

      newline;
      If LinesLeft<=1 Then
        NewPage;
      Bold := false;
    end;
    VpfDClassificacao.free;
    VpaNiveis.delete(VpfLaco);
  end;
  if VpaIndice > 0  then
  begin
    VpfDClassificacao := TRBDClassificacaoRave(VpaNiveis.items[VpaIndice-1]);
    VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto + VpfQtdProduto;
    VpfDClassificacao.QtdConsumido := VpfDClassificacao.QtdConsumido + VpfQtdConsumida;
    VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfValTotal;
    VpfDClassificacao.QtdMesAnterior := VpfDClassificacao.QtdMesAnterior + VpfQtdAnterior;
    VpfDClassificacao.ValAnterior := VpfDClassificacao.ValAnterior + VpfValAnterior;
    VpfDClassificacao.QtdVenda := VpfDClassificacao.QtdVenda + VpfQtdVenda;
    VpfDClassificacao.ValVenda := VpfDClassificacao.ValVenda + VpfValVenda;
    VpfDClassificacao.ValCustoVenda := VpfDClassificacao.ValCustoVenda + VpfValCustoVenda;
    VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado + VpfQtdTrocado;
    VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfValTrocado;
  end;
end;

procedure TRBFunRave.ImprimeTotaisNiveisPlanoContas(VpaNiveis : TList;VpaIndice : integer);
var
  VpfLaco : Integer;
  VpfDPlanoContas : TRBDPlanoContasRave;
  VpfValDuplicata, VpfValPago, VpfValPrevisto: Double;
begin
  VpfValDuplicata := 0;
  VpfValPrevisto := 0;
  VpfValPago := 0;
  for Vpflaco  := VpaNiveis.count -1 downto VpaIndice  do
  begin
    VpfDPlanoContas := TRBDPlanoContasRave(VpaNiveis.items[VpfLaco]);
    VpfDPlanoContas.free;
    VpaNiveis.delete(VpfLaco);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalCelulaTrabalho(VpaValTotal: Double;VpaDiaAtua: Integer);
var
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do begin
    for VpfLaco := VpaDiaAtua to 30 do
      PrintTab('');

    PrintTab(FormatFloat('0',VpaValTotal));
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalCFOPLivroSaida(VpaListaCFOP: TList);
var
  VpfDTotalCFOP : TRBDLivroSaidasTotalCFOPRave;
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;

    RestoreTabs(1);
    PrintTab('DEMONSTRATIVO POR NATUREZA DE OPERAÇÃO');
    Newline;
    Newline;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(4);

    for VpfLaco := 0 to VpaListaCFOP.Count - 1 do
    begin
      VpfDTotalCFOP := TRBDLivroSaidasTotalCFOPRave(VpaListaCFOP.Items[VpfLaco]);
      PrintTab(VpfDTotalCFOP.CodCFOP+' ');//Cfop
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalCFOP.ValContabil)+' ');
      PrintTab('');
      PrintTab(' ');//CFOP
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalCFOP.ValBaseICMS)+' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalCFOP.ValImposto)+' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalCFOP.ValOutras)+' ');
      PrintTab('');
      newline;
      If LinesLeft<=1 Then
      begin
        NewPage;
        RestoreTabs(4);
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoEstoque;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd');
      PrintTab('Valor');
      PrintTab('  UM');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoQtdMinima;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      PrintTab('  UM');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd Atual');
      PrintTab('Qtd Min');
      PrintTab('Qtd Ideal');
      PrintTab('Qtd Faltante');
      PrintTab('Val Unit');
      PrintTab('Val Total');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoResultadoFinanceiroOrcado;
begin
    with RVSystem.BaseReport do
    begin
      if VprImprimendoPlanoContas then
      begin
        bold := true;
        PrintTab('Plano de Contas ');
        PrintTab('  ');
        PrintTab('Orçado ');
        PrintTab('Realizado ');
        PrintTab('Diferença ');
        PrintTab('% Faturamento ');
        Bold := false;
        NewLine;
      end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoResumoCaixas;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Banco');
      PrintTab('Conta');
      PrintTab('  Correntista');
      PrintTab('Saldo Conta');
      PrintTab('Valor Cheques');
      PrintTab('Saldo Real');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoRomaneioCotacao;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('ITE');
      PrintTab('CÓDIGO');
      PrintTab('PRODUTO');
      PrintTab('LOCALIZAÇÃO');
      PrintTab('UM');
      PrintTab('QTD');
      PrintTab('ALTURA ');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoRomaneioEtikArt;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Nr. Pedido');
      PrintTab('Cod Produto');
      PrintTab('Manequim');
      PrintTab('Combinações');
      PrintTab('Fitas');
      PrintTab('Mts Fita ');
      PrintTab('Total KM ');
      PrintTab('Val Unitário ');
      PrintTab('Valor Total ');
      PrintTab(' Descrição');
      Bold := false;
  end;
end;

procedure TRBFunRave.ImprimeCabecalhoServicoVendido;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      PrintTab('Qtd');
      PrintTab('Valor');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTabelaPreco;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Valor');
      PrintTab('  UM');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTotalAmostrasClientesVendedor;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab(' Cliente');
      PrintTab('Qtd Solicitada ');
      PrintTab('Qtd Entregue ');
      PrintTab('Qtd Aprovadas ');
      PrintTab('% Aprovação ');
      bold := false;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTotalAmostrasVendedor;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Vendedor');
      PrintTab('Qtd Solicitada ');
      PrintTab('Qtd Entregue ');
      PrintTab('Qtd Aprovadas ');
      PrintTab('Qtd Clientes ');
      PrintTab('% Aprovação ');
      bold := false;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTotalAnaliseRenovacaoContratoTotalVendedor;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Vendedor');
      PrintTab('Val Contratos');
      PrintTab('Val Renovado ');
      PrintTab('% Fechamento');
      bold := false;
      newline;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTotalFreteNotaXValorConhecimento;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab(' Total Frete ');
      PrintTab(' Total Conhecimento ');
      PrintTab(' Total Diferenca ');
      bold := false;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTotalTipoPedidoXCusto;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Código');
      PrintTab('Tipo Cotação');
      PrintTab('Qtd');
      PrintTab('Val Total ');
      PrintTab('Total Produto ');
      PrintTab('Custo ');
      PrintTab('% ');
      bold := false;
      newline;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoValorFreteNotaXValorConhecimento;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Num Nota');
      PrintTab('Valor Frete');
      PrintTab('Num Conhecimento');
      PrintTab('Val Conhecimento ');
      PrintTab('Diferenca ');
      PrintTab('Transportadora ');
      bold := false;
      newline;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoAmostrasPorDesenvolverdor;
var
  Vpflaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab(' Desenvolvedor');
    for VpfLaco := 1 to 31 do
    begin
      if (Vpflaco <= Dia(UltimoDiaMes(MontaData(1,vprmes,VprAno)))) then
      begin
        if (DiaSemanaNumerico(MontaData(Vpflaco,VprMes,VprAno)) in [1,7]) then
          FontColor := clRed;
      end;
      PrintTab(IntToStr(VpfLaco));
      FontColor := clblack;
    end;
    PrintTab('Total');
    Bold := false;
    NewLine;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoAnaliseContrato;
begin
  if not VprAnalitico  then
  begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(9);
      bold := true;
      PrintTab('Cliente');
      PrintTab('Contrato');
      PrintTab('Valor Leituras');
      PrintTab('Val Equipamentos');
      PrintTab('Val Ins Cont');
      PrintTab('Val Ins Não Cont');
      PrintTab('Val Peças');
      PrintTab('Val Serviços');
      PrintTab('Valor Final');
      Bold := false;
      newline;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoAnaliseFaturamento;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab(VprNomVendedor);
      Bold := false;
      newline;
      RestoreTabs(2);
      bold := true;
      PrintTab('Cliente');
      PrintTab('Ano');
      PrintTab('Janeiro');
      PrintTab('Fevereiro');
      PrintTab('Março');
      PrintTab('Abril');
      PrintTab('Maio');
      PrintTab('Junho');
      PrintTab('Julho');
      PrintTab('Agosto');
      PrintTab('Setembro');
      PrintTab('Outubro');
      PrintTab('Novembro');
      PrintTab('Dezembro');
      PrintTab('Total');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoAnaliseRenovacaoContrato;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Fl ');
    PrintTab('Contrato ');
    PrintTab('Codigo ');
    PrintTab('Cliente ');
    PrintTab('UF');
    PrintTab('Inicio ');
    PrintTab('Fim ');
    PrintTab('Valor ');
    PrintTab('Novo Valor ');
    PrintTab('Assinatura ');
    PrintTab('Inicio ');
    PrintTab('Fim ');
    Bold := false;
    newline;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoCartuchosPesadosPorCelula;
var
  Vpflaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Celula Trabalho');
    for VpfLaco := 1 to 31 do
    begin
      if (Vpflaco <= Dia(UltimoDiaMes(MontaData(1,vprmes,VprAno)))) then
      begin
        if (DiaSemanaNumerico(MontaData(Vpflaco,VprMes,VprAno)) in [1,7]) then
          FontColor := clRed;
      end;
      PrintTab(IntToStr(VpfLaco));
      FontColor := clblack;
    end;
    PrintTab('Total');
    Bold := false;
    NewLine;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoClientesXCobrancaporBairro;
begin
    with RVSystem.BaseReport do
    begin
      FontSize := 8;
      SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
      FillRect(CreateRect(MarginLeft-0.1,YPos-0.4,PageWidth-0.3,YPos+0.1));
      RestoreTabs(2);
      BOLD := TRUE;
      PrintTab(VprBairro);
      Bold := false;
      NewLine;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoConsumoAmostras;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Dias');
    PrintTab('Amostras');
    NewLine;
    RestoreTabs(2);
    PrintTab(' ');
    PrintTab('Qtd ');
    PrintTab('% ');
    PrintTab('Qtd ');
    Bold := false;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoConsumoProdutoProducao;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd Estoque');
      PrintTab('Qtd Consumido');
      PrintTab('  UM');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoHistoricoConsumoProdutoProducao;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    PrintTab('Código ');
    PrintTab(' Produto');
    PrintTab(' Cor');
    PrintTab(' UM');
    PrintTab(' Quantidade');
    bold := false;
    Newline;
    If LinesLeft<=1 Then
      NewPage;

  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoCreditoCliente;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab(' Cliente ');
    PrintTab('Valor Credito ');
    PrintTab('Valor Debito ');
    PrintTab('Total  ');
    bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoCustoProjeto;
begin
  if VprImprimindoConsumoOP then
  begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(5);
      bold := true;
      PrintTab('Fração ');
      PrintTab(' Materia Prima');
      PrintTab('Altura ');
      PrintTab('Largura ');
      PrintTab('Peso ');
      PrintTab('Qtd Baixado ');
      PrintTab('Val Unitario ');
      PrintTab('UM');
      PrintTab('Custo Total ');
      Bold := false;
    end;
  end
  else
  begin
    ImprimetituloPlanoContas(VprNiveis,true);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoDemandaCompra;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd Estoque');
      PrintTab('  UM');
      PrintTab('Mes 1 ');
      PrintTab('Mes 2 ');
      PrintTab('Mes 3 ');
      PrintTab('Qtd Comprada ');
      PrintTab('Sugestao Compra ');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoFechamentoEstoque;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    PrintTab('Código');
    PrintTab('Nome');
    PrintTab('Qtd');
    PrintTab('Valor');
    PrintTab('Custo');
    PrintTab('Margem');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoFluxoCaixaDiario;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoLivroRegistroSaida;
begin
  with RVSystem.BaseReport do
  begin
    FontSize := 8;
    RestoreTabs(1);
    bold := true;
    if VprIndEntrada then
      PrintTab('REGISTRO DE ENTRADAS')
    else
      PrintTab('REGISTRO DE SAÍDAS');
    Newline;
    RestoreTabs(2);
    if VprDFilial <> nil then
      PrintTab(' EMPRESA : '+VprDFilial.NomFilial)
    else
      PrintTab('');
    PrintTab('Período : '+FormatDateTime('DD/MM/YYYY',VprDatInicio)+ ' até '+FormatDateTime('DD/MM/YYYY',VprDatFim)+' ');
    Newline;
    RestoreTabs(3);
    PrintTab('ESP');
    PrintTab('SER');
    PrintTab('NÚMERO');
    PrintTab('DIA');
    PrintTab('UF');
    PrintTab('VL CONTABIL');
    PrintTab('CHAVE');
    PrintTab('FISCAL');
    PrintTab('BASE CALCULO');
    PrintTab('ALIQ');
    PrintTab('IMPOSTO DEBITADO');
    PrintTab('ISENTAS ');
    PrintTab('OUTRAS ');
    PrintTab(' OBSERVACOES');
    Newline;
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPagamentoFaccionista;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    if varia.ModeloRelatorioFaccionista = mrModelo1Kairos then
    begin
      PrintTab('Retorno');
      PrintTab('Revisado');
      PrintTab('Produto');
      PrintTab('Qtd Rev');
      PrintTab('Qtd Def');
      PrintTab('Val Uni');
      PrintTab('Val Total');
    end
    else
      if varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
      begin
        PrintTab('Retorno');
        PrintTab('Pedido');
        PrintTab('OP');
        PrintTab('Produto');
        PrintTab('Qtd Rev');
        PrintTab('Val Uni');
        PrintTab('Val Total');
      end;
    Newline;
    RestoreTabs(1);
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.4,PageWidth-0.3,YPos+0.1));
    PrintTab(Tabela.FieldByName('NOMFACCIONISTA').AsString);
    Newline;
    if (Tabela.FieldByName('NOMTERCEIRO').AsString <> '') then
    begin
      PrintTab('   ' +Tabela.FieldByName('NOMTERCEIRO').AsString);
      Newline;
    end;
    Bold := false;
    if varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
      FontSize := 8;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPedidosAtrasados;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Qtd Dias');
    PrintTab('Qtd Entregas');
    PrintTab('Qtd Produtos');
    PrintTab('Valor Produtos');
    NewLine;
    RestoreTabs(2);
    PrintTab(' ');
    PrintTab('Qtd ');
    PrintTab('% ');
    PrintTab('Qtd ');
    PrintTab('% ');
    PrintTab('Valor ');
    PrintTab('% ');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPlanoContas;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    PrintTab('Fornecedor');
    PrintTab('Nro Nota');
    PrintTab('Vcto');
    PrintTab('Valor a Pagar');
    PrintTab('Pgto');
    PrintTab('Valor Pago');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPlanoContasCustoProjeto;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    PrintTab('Fornecedor');
    PrintTab('Nro Nota');
    PrintTab('Emissão');
    PrintTab('Valor');
    PrintTab('Percentual');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPorPlanoContasSintetico;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Código');
    PrintTab('Plano Contas');
    PrintTab('Val Aberto ');
    PrintTab('Valor Pago');
    PrintTab('Valor Total');
    PrintTab('Val Previsto');
    PrintTab('%');
    Bold := false;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

procedure TRBFunRave.ImprimeCabecalhoPorPlanoContasSinteticoporMes;
begin
  with RVSystem.BaseReport do
  begin
    SetFont('Arial',8);
    RestoreTabs(1);
    bold := true;
    PrintTab('Código');
    PrintTab('Plano Contas');
    PrintTab('Ano');
    PrintTab('Janeiro');
    PrintTab('Fevereiro');
    PrintTab('Março');
    PrintTab('Abril');
    PrintTab('Maio');
    PrintTab('Junho');
    PrintTab('Julho');
    PrintTab('Agosto');
    PrintTab('Setembro');
    PrintTab('Outubro');
    PrintTab('Novembro');
    PrintTab('Dezembro');
    PrintTab('Total');
    Bold := false;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPrazoEntregaRealProdutos;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Qtd Dias');
    PrintTab('Qtd Entregas');
    PrintTab('Qtd Produtos');
    PrintTab('Valor Produtos');
    NewLine;
    RestoreTabs(2);
    PrintTab(' ');
    PrintTab('Qtd ');
    PrintTab('% ');
    PrintTab('Qtd ');
    PrintTab('% ');
    PrintTab('Valor ');
    PrintTab('% ');
    Bold := false;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoProdutocomDefeito;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      PrintTab('Qtd Vendida');
      PrintTab('Qtd Defeitos');
      PrintTab('% Defeito ');
      PrintTab('Valor Perdido');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoProdutoFaturadosSTComTributacao;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    FontSize := 7;
    PrintTab('Nota ');
    PrintTab(' Codigo');
    PrintTab(' Produto ');
    PrintTab('UM ');
    PrintTab('Vlr Produto ');
    PrintTab('Vlr Compra ');
    PrintTab('% MVA ');
    PrintTab('Base ST ');
    PrintTab('Valor ST ');
    PrintTab('% ICMS ');
    PrintTab('Vlr ICMS Compra');
    Bold := false;
    newline;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoProdutoFornecedor;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Código ');
      PrintTab(' Produto');
      PrintTab(' Val. Unit.');
      PrintTab(' %IPI ');
      PrintTab(' ICMS ');
      PrintTab(' MVA ');
      PrintTab(' Classificação Fiscal ');
      PrintTab(' %ST ');
      PrintTab(' Última Compra ');
      PrintTab(' Referencia ');
      bold := false;
      newline;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoProdutosVendidoseTrocados;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('');
      PrintTab('Vendidos');
      PrintTab('');
      PrintTab('Trocados');
      newline;
      RestoreTabs(3);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd');
      PrintTab('Valor');
      PrintTab('Qtd');
      PrintTab('Valor');
      PrintTab('  Percentual');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoExtratoProdutividade;
var
  Vpflaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Celula Trabalho');
    for VpfLaco := 1 to 31 do
    begin
      if (Vpflaco <= Dia(UltimoDiaMes(MontaData(1,vprmes,VprAno)))) then
      begin
        if (DiaSemanaNumerico(MontaData(Vpflaco,VprMes,VprAno)) in [1,7]) then
          FontColor := clRed;
      end;
      PrintTab(IntToStr(VpfLaco));
      FontColor := clblack;
    end;
    PrintTab('Total');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoEntradaMetros;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('');
    PrintTab('AMOSTRA');
    PrintTab('PEDIDO');
    PrintTab('TOTAL');
    Bold := false;

    newline;
    RestoreTabs(2);
    bold := true;
    PrintTab('  FAMÍLIA');
    PrintTab('METROS');
    PrintTab('VALOR');
    PrintTab('METROS');
    PrintTab('VALOR');
    PrintTab('METROS');
    PrintTab('VALOR');
    Bold := false;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTituloUF(VpaCodUf : String);
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    FontColor := clRed;
    PrintTab(VpaCodUf);
    Bold := false;
    FontColor := clBlack;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTituloClassificacao(VpaNiveis : TList;VpaTudo : boolean);
var
  VpfLaco : Integer;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  for VpfLaco := 0 to VpaNiveis.Count - 1 do
  begin
    VpfDClassificacao := TRBDClassificacaoRave(Vpaniveis.Items[VpfLaco]);
    if (vpaTudo) or VpfDClassificacao.IndNovo  then
    begin
      VpfDClassificacao.Indnovo := false;
      with RVSystem.BaseReport do
      begin
        RestoreTabs(1);
        bold := true;
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDClassificacao.CodClassificacao);
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDClassificacao.NomClassificacao);
        Bold := false;
        newline;
        If LinesLeft<=1 Then
          NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
      end;
    end;
  end;
  if (VpaNiveis.Count > 0) or not(VprAgruparClassificacao) then
  begin
    with RVSystem.BaseReport do
    begin
      case RvSystem.Tag of
       1,2,12,41 : ImprimeCabecalhoEstoque;
       4 : ImprimeCabecalhoQtdMinima;
       6 : ImprimeCabecalhoFechamentoEstoque;
       16 : ImprimeCabecalhoProdutosVendidoseTrocados;
       11 : ImprimeCabecalhoTabelaPreco;
       19 : ImprimeCabecalhoProdutocomDefeito;
       33 : ImprimeCabecalhoServicoVendido;
       48 : ImprimeCabecalhoConsumoProdutoProducao;
       50 : ImprimeCabecalhoDemandaCompra;
      end;
      newline;
      If LinesLeft<=1 Then
        NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTituloOPCustoProjeto(VpaCodFilial, VpaSeqOrdem: Integer);
begin
  with RVSystem.BaseReport do begin
    RestoreTabs(4);
    newline;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    Bold := TRUE;
    FontSize := 12;
    PrintTab(IntToStr(VpaSeqOrdem)+'   -   ' + FunOrdemProducao.RNomProdutoFracao(VpaCodFilial,VpaSeqOrdem,1));
    NewLine;
    Bold := false;
    FontSize := 10;
    ImprimeCabecalhoCustoProjeto;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimetituloPlanoContas(VpaNiveis : TList;VpaTudo : boolean);
var
  VpfLaco : Integer;
  VpfDPlanoContas : TRBDPlanoContasRave;
begin
  for VpfLaco := 0 to VpaNiveis.Count - 1 do
  begin
    VpfDPlanoContas := TRBDPlanoContasRave(Vpaniveis.Items[VpfLaco]);
    if (vpaTudo) or VpfDPlanoContas.IndNovo  then
    begin
      VpfDPlanoContas.Indnovo := false;
      with RVSystem.BaseReport do
      begin
        RestoreTabs(1);
        bold := true;
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDPlanoContas.CodPlanoCotas);
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDPlanoContas.NomPlanoContas);
        Bold := false;
        newline;
        If LinesLeft<=1 Then
          NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
      end;
    end;
  end;
  if VpaNiveis.Count > 0 then
  begin
    with RVSystem.BaseReport do
    begin
      case RvSystem.Tag of
       7 : ImprimeCabecalhoPlanoContas;
      10 : ImprimeCabecalhoPlanoContasCustoProjeto;
      end;
      newline;
      If LinesLeft<=1 Then
        NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
    end;
  end;
end;

{******************************************************************************}
function TRBFunRave.RCorProduto(VpaDProduto: TRBDProdutoRave; VpaCodCor: Integer): TRBDCorProdutoRave;
var
  VpfLacoCor : Integer;
begin
  result := nil;
  for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
  begin
    if (TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]).CodCor = VpaCodCor) then
    begin
      result := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
      break;
    end;
  end;

  if result = nil then
  begin
    result := VpaDProduto.AddCor;
    result.CodCor := VpaCodCor;
    if result.CodCor = 0 then
      result.NomCor := 'SEM COR'
    else
      result.NomCor := FunProdutos.RNomeCor(IntTosTr(Result.CodCor));
    Result.QtdEstoque := 0;
  end;
end;

{******************************************************************************}
function TRBFunRave.RDataAmostra(VpaCampoData: String;
  VpaDataEntrega: TDatetime; VpaCodAmostra: integer): Integer;
var
  VpfQtdAmostras: Integer ;
begin
  result := 0;
  VpfQtdAmostras := 0;
  AdicionaSQLAbreTabela(Aux,'Select DATAMOSTRA' +
                        ' from  AMOSTRA '+
                        ' WHERE CODAMOSTRA = ' +IntToStr(VpaCodAmostra));

  while not Aux.Eof do
  begin
    result := result + DiasPorPeriodo(Aux.FieldByName(VpaCampoData).AsDateTime,VpaDataEntrega);
    if result = 40302 then
    result:= result;
    inc(VpfQtdAmostras);
    Aux.Next;
  end;
  if result <> 0 then
    result := result div VpfQtdAmostras;
  Aux.close;

end;

{******************************************************************************}
function TRBFunRave.RDataPedido(VpaCodFilial, VpaSeqNota, VpaSeqProduto: Integer;VpaCampoData: String;VpaDataEntrega : TDatetime): Integer;
var
  VpfQtdPedidos: Integer ;
begin
  result := 0;
  VpfQtdPedidos := 0;
  AdicionaSQLAbreTabela(Aux,'Select CAD.'+VpaCampoData +
                        ' from  MOVNOTAORCAMENTO MNO, CADORCAMENTOS CAD, MOVORCAMENTOS MOV '+
                        ' WHERE MNO.I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                        ' AND MNO.I_SEQ_NOT = ' +IntToStr(VpaSeqNota)+
                        ' AND MNO.I_FIL_ORC = CAD.I_EMP_FIL ' +
                        ' AND MNO.I_LAN_ORC = CAD.I_LAN_ORC ' +
                        ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                        ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC' +
                        ' AND MOV.I_SEQ_PRO = '+IntToStr(VpaSeqProduto) );
  while not Aux.Eof do
  begin
    result := result + DiasPorPeriodo(Aux.FieldByName(VpaCampoData).AsDateTime,VpaDataEntrega);
    inc(VpfQtdPedidos);
    Aux.Next;
  end;
  if result <> 0 then
    result := result div VpfQtdPedidos;
  Aux.close;
end;

{******************************************************************************}
function TRBFunRave.RDConsumoAmostrasAtrasadas(VpaQtdDias: integer;
  VpaConsumoAmostraAtrasadas: TList): TRBDRConsumoEntregaAmostrasRave;
Var
  VpfLaco : integer;
  VpfDConsumoAmostraAtrasados: TRBDRConsumoEntregaAmostrasRave;
begin
  Result:= nil;
  for VpfLaco := 0 to VpaConsumoAmostraAtrasadas.Count - 1 do
  begin
    VpfDConsumoAmostraAtrasados:= TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostraAtrasadas.Items[VpfLaco]);
    if VpfDConsumoAmostraAtrasados.QtdDias = VpaQtdDias then
    begin
      result:= VpfDConsumoAmostraAtrasados;
      break;
    end;
  end;
  if Result = nil then
  begin
    Result:= TRBDRConsumoEntregaAmostrasRave.cria;
    VpaConsumoAmostraAtrasadas.Add(Result);
    Result.QtdDias:= VpaQtdDias;
  end;
end;

{******************************************************************************}
function TRBFunRave.RDPedidosAtrasados(VpaQtdDias: integer;
  VpaPedidosAtrasados: TList): TRBDRPedidosAtrasadosRave;
Var
  VpfLaco : integer;
  VpfDPedidosAtrasados: TRBDRPedidosAtrasadosRave;
begin
  Result:= nil;
  for VpfLaco := 0 to VpaPedidosAtrasados.Count - 1 do
  begin
    VpfDPedidosAtrasados:= TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLaco]);
    if VpfDPedidosAtrasados.QtdDias = VpaQtdDias then
    begin
      result:= VpfDPedidosAtrasados;
      break;
    end;
  end;
  if Result = nil then
  begin
    Result:= TRBDRPedidosAtrasadosRave.cria;
    VpaPedidosAtrasados.Add(Result);
    Result.QtdDias:= VpaQtdDias;
  end;
end;

{******************************************************************************}
function TRBFunRave.REspula(VpaNumEspulas: Integer): String;
begin
  if VpaNumEspulas > 1 then
    result := ' X '+IntToStr(VpaNumEspulas)
  else
    result := '';
end;

{******************************************************************************}
function TRBFunRave.RTamanhoProduto(VpaDCor: TRBDCorProdutoRave; VpaCodTamanho: Integer): TRBDTamanhoProdutoRave;
var
  VpfLacoTamanho : Integer;
begin
  result := nil;
  for VpfLacoTamanho := 0 to VpaDCor.Tamanhos.Count - 1 do
  begin
    if TRBDTamanhoProdutoRave(VpaDCor.Tamanhos.Items[VpfLacoTamanho]).CodTamanho = VpaCodTamanho then
    begin
      result := TRBDTamanhoProdutoRave(VpaDCor.Tamanhos.Items[VpfLacoTamanho]);
      break;
    end;
  end;

  if result = nil then
  begin
    Result := VpaDCor.addTamanho;
    Result.CodTamanho := VpaCodTamanho;
    if Result.CodTamanho = 0 then
      Result.NomTamanho := 'SEM TAMANHO'
    else
      Result.NomTamanho := FunProdutos.RNomeTamanho(VpaCodTamanho);
  end;
end;

{******************************************************************************}
function TRBFunRave.RTotaisConsumoAmostraAtrasados(
  VpaConsumoAmostrasAtrasados: TList): TRBDRConsumoEntregaAmostrasRave;
var
  VpfLaco: integer;
  vpfDConsumoAmostraAtrasado: TRBDRConsumoEntregaAmostrasRave;
begin
  Result:= TRBDRConsumoEntregaAmostrasRave.cria;
  for VpfLaco := 0 to VpaConsumoAmostrasAtrasados.Count - 1 do
  begin
    vpfDConsumoAmostraAtrasado:= TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostrasAtrasados.Items[VpfLaco]);
    Result.QtdAmostras:= Result.QtdAmostras + vpfDConsumoAmostraAtrasado.QtdAmostras;
  end;

end;

{******************************************************************************}
function TRBFunRave.RTotaisPedidosAtrasados(
  VpaPedidosAtrasados: TList): TRBDRPedidosAtrasadosRave;
var
  VpfLaco: integer;
  vpfDPedidoAtrasado: TRBDRPedidosAtrasadosRave;
begin
  Result:= TRBDRPedidosAtrasadosRave.cria;
  for VpfLaco := 0 to VpaPedidosAtrasados.Count - 1 do
  begin
    vpfDPedidoAtrasado:= TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLaco]);
    Result.QtdPedidos:= Result.QtdPedidos + vpfDPedidoAtrasado.QtdDias;
    Result.QtdProdutos:= Result.QtdProdutos + vpfDPedidoAtrasado.QtdProdutos;
    Result.ValProdutos:= Result.ValProdutos + vpfDPedidoAtrasado.ValProdutos;
  end;

end;

{******************************************************************************}
function TRBFunRave.RTotalCFOP(VpaLista: TList;VpaCodCfop: string): TRBDLivroSaidasTotalCFOPRave;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaLista.Count - 1 do
  begin
    if TRBDLivroSaidasTotalCFOPRave(VpaLista.Items[VpfLaco]).CodCFOP = VpaCodCfop then
    begin
      result := TRBDLivroSaidasTotalCFOPRave(VpaLista.Items[VpfLaco]);
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDLivroSaidasTotalCFOPRave.cria;
    result.CodCFOP :=  VpaCodCfop;
    VpaLista.Add(result);
  end;
end;

{******************************************************************************}
function TRBFunRave.RTotalUFLivroSaida(VpaLista: TList;VpaDesUf: string): TRBDLivroSaidasTotalUFRave;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaLista.Count - 1 do
  begin
    if TRBDLivroSaidasTotalUFRave(VpaLista.Items[VpfLaco]).DesUF = VpaDesUf then
    begin
      result := TRBDLivroSaidasTotalUFRave(VpaLista.Items[VpfLaco]);
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDLivroSaidasTotalUFRave.cria;
    result.DesUF :=  VpaDesUf;
    VpaLista.Add(result);
  end;
end;

{******************************************************************************}
function TRBFunRave.RValCustoCotacao(VpaCodFilial, VpaLanOrcamento: Integer): Double;
Var
  VpfQtd, VpfValCusto : Double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Aux,'Select MOV.N_QTD_PRO, MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.I_EMP_FIL, MOV.C_COD_UNI, '+
                            ' PRO.C_COD_UNI UMORIGINAL '+
                           ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                           ' Where MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                           ' AND MOV.I_LAN_ORC = '+ IntToStr(VpaLanOrcamento)+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO');
  while not Aux.Eof do
  begin
    FunProdutos.CQtdValorCusto(VpaCodFilial,Aux.FieldByName('I_SEQ_PRO').AsInteger,Aux.FieldByName('I_COD_COR').AsInteger,Aux.FieldByName('I_COD_TAM').AsInteger, VpfQtd,VpfValCusto);
    result := result + FunProdutos.ValorPelaUnidade(Aux.FieldByName('UMORIGINAL').AsString,Aux.FieldByName('C_COD_UNI').AsString,Aux.FieldByName('I_SEQ_PRO').AsInteger,VpfValCusto );
    aux.Next;
  end;
  Aux.close;
end;

{******************************************************************************}
function TRBFunRave.RValOrcadoTotal(VpaDatInicio, VpaDatFim: TDateTime): Double;
var
  VpfMesAtual : TDatetime;
  VpfCampoMes : String;
begin
  VpfMesAtual := VpaDatInicio;
  result := 0;
  while VpfMesAtual <= VpaDatFim do
  begin
    case Mes(VpfMesAtual) of
      1 : VpfCampoMes := 'VALJANEIRO';
      2 : VpfCampoMes := 'VALFEVEREIRO';
      3 : VpfCampoMes := 'VALMARCO';
      4 : VpfCampoMes := 'VALABRIL';
      5 : VpfCampoMes := 'VALMAIO';
      6 : VpfCampoMes := 'VALJUNHO';
      7 : VpfCampoMes := 'VALJULHO';
      8 : VpfCampoMes := 'VALAGOSTO';
      9 : VpfCampoMes := 'VALSETEMBRO';
      10 : VpfCampoMes := 'VALOUTUBRO';
      11 : VpfCampoMes := 'VALNOVEMBRO';
      12 : VpfCampoMes := 'VALDEZEMBRO';
    end;
    AdicionaSQLAbreTabela(Aux,'Select SUM('+VpfCampoMes+') SOMA FROM PLANOCONTAORCADO  ' +
                              ' Where CODEMPRESA = ' +IntToStr(Varia.CodigoEmpresa)+
                              ' and ANOORCADO = '+IntToStr(Ano(VpfMesAtual))+
                              ' and LENGTH(CODPLANOCONTA) = '+IntToStr(Length(CopiaAteChar(Varia.MascaraPlanoConta,'.')))) ;
    result := Result + Aux.FieldByName('SOMA').AsFloat;
    VpfMesAtual := IncMes(VpfMesAtual,1);
  end;
  Aux.Close;
end;

{******************************************************************************}
function TRBFunRave.RVendaClassificacao(VpaDVendaCliente: TRBDVendaCliente;VpaMes, VpaAno: Integer; VpaCodClassificacao : String): TRBDVendaClienteMes;
var
  VpfLacoAno,VpfLacoMes, VpfLacoClassificacao : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfDVendaClassificacao : TRBDVendaClienteClassificacaoProduto;
begin
  result := nil;
  for VpflacoAno := 0 to VpaDVendaCliente.Anos.Count - 1 do
  begin
    VpfDVendaAno := TRBDVendaClienteAno(VpaDVendaCliente.Anos.Items[VpfLacoAno]);
    if VpfDVendaAno.Ano = VpaAno then
    begin
      for VpfLacoClassificacao := 0 to VpfDVendaAno.ClassificacoesProduto.Count - 1 do
      begin
        VpfDVendaClassificacao := TRBDVendaClienteClassificacaoProduto(VpfDVendaAno.ClassificacoesProduto.Items[VpfLacoClassificacao]);
        if VpfDVendaClassificacao.CodClassificacao = VpaCodClassificacao then
        begin
          for VpfLacoMes := 0 to VpfDVendaClassificacao.Meses.Count - 1 do
          begin
            VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaClassificacao.Meses.Items[VpfLacoMes]);
            if VpfDVendaMes.Mes = VpaMes then
              exit(VpfDVendaMes);
          end;
        end;
      end;
      if result = nil  then
      begin
        VpfDVendaClassificacao := TRBDVendaClienteClassificacaoProduto.cria;
        VpfDVendaAno.ClassificacoesProduto.Add(VpfDVendaClassificacao);
        VpfDVendaClassificacao.CodClassificacao := VpaCodClassificacao;
        VpfDVendaClassificacao.NomClassificacao := FunProdutos.RNomeClassificacao(Varia.CodigoEmpresa,VpaCodClassificacao);
        for VpfLacoMes := 1 to 12 do
        begin
          VpfDVendaMes := VpfDVendaClassificacao.addMes;
          VpfDVendaMes.Mes := VpfLacoMes;
          if VpfDVendaMes.Mes = VpaMes then
            result := VpfDVendaMes;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarCombinacoesOPConvencional(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta; VpaDProduto: TRBDProduto);
var
  VpfDCombinacao : TRBDCombinacao;
  vpfDCombinacaoFigura : TRBDCombinacaoFigura;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoFigura, VpfCodCombAnt,VpfQtdEtiquetas : Integer;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(5);
    VpfCodCombAnt := 0;
    VpfQtdEtiquetas := 0;
    PrintTab('CB');
    PrintTab('Fts');
    PrintTab('Cor ');
    PrintTab('Título');
    PrintTab('Fundo');
    newline;
    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]);
      if VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt then
      begin
        if VpfLaco <> 0 then
        begin
          PrintTab('');
          PrintTab('');
          PrintTab('   QTD = '+IntToStr(VpfQtdEtiquetas));
          newline;
          If LinesLeft<=1 Then
            NewPage;
          VpfQtdEtiquetas := 0;
        end;
        VpfDCombinacao := FunProdutos.RCombinacao(VpaDProduto,VpfDOrdemItem.CodCombinacao);
        //urdume
        PrintTab(IntToStr(VpfDCombinacao.CodCombinacao));
        PrintTab(IntToStr(VpfDOrdemItem.QtdFitas));
        PrintTab(VpfDCombinacao.CorFundo1+ ' URDUME ');
        PrintTab(VpfDCombinacao.TituloFundo1+REspula(VpfDCombinacao.Espula1));
        PrintTab(IntToStr(VpfDCombinacao.CorCartela));
        newline;
        If LinesLeft<=1 Then
           NewPage;
          //URDUME FIGURA
        IF VpfDCombinacao.CorUrdumeFigura <> '' then
        begin
          PrintTab('');
          PrintTab('');
          PrintTab(VpfDCombinacao.CorUrdumeFigura+' URDUMEFI ');
          PrintTab(VpfDCombinacao.TituloFundoFigura+REspula(VpfDCombinacao.EspulaUrdumeFigura));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        //trama
        PrintTab('');
        PrintTab('');
        PrintTab(VpfDCombinacao.CorFundo2);
        PrintTab(VpfDCombinacao.TituloFundo2+REspula(VpfDCombinacao.Espula2));
        PrintTab('');
        newline;
        If LinesLeft<=1 Then
          NewPage;
        for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
        begin
          vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
          PrintTab('');
          PrintTab('');
          PrintTab(vpfDCombinacaoFigura.CodCor);
          PrintTab(vpfDCombinacaoFigura.TitFio+REspula(vpfDCombinacaoFigura.NumEspula));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfCodCombAnt := VpfDOrdemItem.CodCombinacao;
      end;
      VpfQtdEtiquetas := VpfQtdEtiquetas + VpfDOrdemItem.QtdEtiquetas;
    end;
    PrintTab('');
    PrintTab('');
    PrintTab('   QTD = '+IntToStr(VpfQtdEtiquetas));
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarCombinacoesOPH(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta;VpaDProduto: TRBDProduto);
var
  VpfDCombinacao : TRBDCombinacao;
  vpfDCombinacaoFigura : TRBDCombinacaoFigura;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoFigura, VpfCodCombAnt : Integer;
  VpfQtdPecas : String;
begin
  VpfCodCombAnt := 0;
  with RVSystem.BaseReport do
  begin
    RestoreTabs(6);
    PrintTab('CB');
    PrintTab('Fts');
    PrintTab('Cor ');
    PrintTab('Título');
    PrintTab('Fundo');
    PrintTab('Qdade(PC)');
    newline;

    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]);
      if VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt then
      begin
        if VpfLaco <> 0 then
        begin
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfDCombinacao := FunProdutos.RCombinacao(VpaDProduto,VpfDOrdemItem.CodCombinacao);
        if VpfDOrdemItem.CodManequim = '' then
          VpfQtdPecas := FormatFloat('0',VpfDOrdemItem.MetrosFita)
        else
          VpfQtdPecas := '';
        //urdume
        PrintTab(IntToStr(VpfDCombinacao.CodCombinacao));
        PrintTab(IntToStr(VpfDOrdemItem.QtdFitas));
        PrintTab(VpfDCombinacao.CorFundo1+ ' URD ');
        PrintTab(VpfDCombinacao.TituloFundo1+REspula(VpfDCombinacao.Espula1));
        PrintTab(VpfQtdPecas);
        newline;
        If LinesLeft<=1 Then
          NewPage;
        //urdume figura
        if VpfDCombinacao.CorUrdumeFigura <> '' then         //urdume Figura
        begin
          PrintTab('');
          PrintTab('');
          PrintTab(VpfDCombinacao.CorUrdumeFigura+ ' URD2 ');
          PrintTab(VpfDCombinacao.TituloFundoFigura+REspula(VpfDCombinacao.EspulaUrdumeFigura));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        //trama
        PrintTab('');
        PrintTab('');
        PrintTab(VpfDCombinacao.CorFundo2+ ' ');
        PrintTab(VpfDCombinacao.TituloFundo2+REspula(VpfDCombinacao.Espula2));
        PrintTab('');
        newline;
        If LinesLeft<=1 Then
          NewPage;
        for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
        begin
          vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
          //figuras
          PrintTab('');
          PrintTab('');
          PrintTab(vpfDCombinacaoFigura.CodCor +' ');
          PrintTab(vpfDCombinacaoFigura.TitFio+REspula(vpfDCombinacaoFigura.NumEspula));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
          vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
        end;
        VpfCodCombAnt := VpfDOrdemItem.CodCombinacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarDAmostrasDesenvolvedor(VpaCodDesenvolvedor: Integer; VpaDAmostraDesenvolvedor: TRBDRAmostraDesenvolvedor; VpaTabela: TSQLQuery);
var
  VpfDDia: TRBDRAmostraDesenvolvedorDia;
begin
  VpaDAmostraDesenvolvedor.QtdTotal := 0;
  while (not VpaTabela.Eof) and (VpaTabela.FieldByName('CODDESENVOLVEDOR').AsInteger = VpaCodDesenvolvedor) do
  begin
    VpfDDia := VpaDAmostraDesenvolvedor.RDia(Dia(VpaTabela.FieldByName('DATAMOSTRA').AsDateTime));
    VpfDDia.Quantidade := VpaTabela.FieldByName('QTD').AsInteger;
    VpaDAmostraDesenvolvedor.QtdTotal := VpaDAmostraDesenvolvedor.QtdTotal + VpfDDia.Quantidade;
    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarDCartuchosPesadosCelula(VpaCodCelula: Integer; VpaDCelula: TRBDRCelulaTrabalho; VpaTabela: TSQLQuery);
var
  VpfDDia: TRBDRCelulaTrabalhoDia;
begin
  VpaDCelula.QtdTotal := 0;
  while (not VpaTabela.Eof) and (VpaTabela.FieldByName('CODCELULA').AsInteger = VpaCodCelula) do
  begin
    VpfDDia := VpaDCelula.RDia(Dia(VpaTabela.FieldByName('DATPESO').AsDateTime));
    VpfDDia.Quantidade := VpaTabela.FieldByName('QTD').AsInteger;
    VpaDCelula.QtdTotal := VpaDCelula.QtdTotal + VpfDDia.Quantidade;
    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarDConsumoEntregaAmostras(VpaConsumoEntregaAmostras: TList; VpaDatIni, VpaDatFim: TDateTime;VpaCampoPrimeiraData: String);
var
  VpfDConsumoAmostras: TRBDRConsumoEntregaAmostrasRave;
  VpfConsumoAmostraAnterior,VpfQtdDias: integer;
  VpfDAmostraEntrega : TRBDAmostraEntrega;
begin
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela, 'SELECT AMO.CODAMOSTRA, AMO.NOMAMOSTRA, '+
                            ' AMC.DATENTREGA DATENTREGA, '+
                            ' OD.DATAMOSTRA DATCADASTRO, '+
                            ' AMC.CODCOR '+
                            ' FROM  AMOSTRACOR AMC, AMOSTRA AMO, AMOSTRA OD '+
                            ' Where AMO.CODAMOSTRA = AMC.CODAMOSTRA '+
                            ' AND AMO.CODAMOSTRAINDEFINIDA = OD.CODAMOSTRA '+
                            ' AND AMO.CODDEPARTAMENTOAMOSTRA <> 5 ' +
                            SQLTextoDataEntreAAAAMMDD('AMC.DATENTREGA', VpaDatIni, VpaDatFim, TRUE));

  AdicionaSqlTabela(Tabela, ' ORDER BY AMC.CODAMOSTRA ');
  Tabela.open;

  FreeTObjectsList(VpaConsumoEntregaAmostras);
  VpfConsumoAmostraAnterior:= -99999;
  while not Tabela.Eof do
  begin

    VpfQtdDias := QdadeDiasUteis(Tabela.FieldByName('DATCADASTRO').AsDateTime,Tabela.FieldByName('DATENTREGA').AsDateTime);
    VpfDConsumoAmostras:= RDConsumoAmostrasAtrasadas(VpfQtdDias, VpaConsumoEntregaAmostras);
    VpfDConsumoAmostras.QtdAmostras := VpfDConsumoAmostras.QtdAmostras + 1;
    VpfDAmostraEntrega := VpfDConsumoAmostras.addAmostraEntrega;
    VpfDAmostraEntrega.CodAmostra := Tabela.FieldByName('CODAMOSTRA').AsInteger;
    VpfDAmostraEntrega.CodCor := Tabela.FieldByName('CODCOR').AsInteger;
    VpfDAmostraEntrega.NomAmostra := Tabela.FieldByName('NOMAMOSTRA').AsString;
    VpfDAmostraEntrega.DatCadastro := Tabela.FieldByName('DATCADASTRO').AsDateTime;
    VpfDAmostraEntrega.DatEntrega := Tabela.FieldByName('DATENTREGA').AsDateTime;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.CarDContrato(VpaDContrato: TRBDContratoLocacaoRave;VpaCodFilial, VpaSeqContrato, VpaCodCliente : Integer);
begin
  VpaDContrato.CodFilial := VpaCodFilial;
  VpaDContrato.SeqContrato := VpaSeqContrato;
  VpaDContrato.CodCliente := VpaCodCliente;
  CarLeituraLocacao(VpaDContrato,VpaCodFilial,VpaSeqContrato);
  CarEquipamentosContrato(VpaDContrato);
  CarInsumosContrato(VpaDContrato,true);
  CarInsumosContrato(VpaDContrato,false);
  CarPecasContrato(VpaDContrato);
  VpaDContrato.ValFinalContrato := VpaDContrato.ValTotalLeituras - VpaDContrato.ValTotalEquipamentos - VpaDContrato.ValTotalInsumosContabilizados - VpaDContrato.ValTotalPecas;
end;

{******************************************************************************}
function TRBFunRave.CarDNivel(VpaCodCompleto, VpaCodReduzido : String):TRBDClassificacaoRave;
var
  VpfTipoClassificacao : String;
begin
  Result := TRBDClassificacaoRave.create;
  Result.CodClassificacao := VpaCodCompleto;
  result.CodReduzido := VpaCodReduzido;
  if VprServico then
    VpfTipoClassificacao := 'S'
  else
    VpfTipoClassificacao := 'P';
  Result.NomClassificacao := FunClassificacao.RetornaNomeClassificacao(DeletaChars(result.CodClassificacao,'.'),VpfTipoClassificacao);
  Result.QTdProduto := 0;
  Result.ValTotal :=0;
  Result.IndNovo := true;
end;

{******************************************************************************}
function TRBFunRave.CarDNivelPlanoContas(VpaCodCompleto,VpaCodReduzido: String): TRBDPlanoContasRave;
begin
  Result := TRBDPlanoContasRave.create;
  Result.CodPlanoCotas := VpaCodCompleto;
  result.CodReduzido := VpaCodReduzido;
  Result.NomPlanoContas := FunContasAReceber.RNomPlanoContas(Varia.CodigoEmpresa,DeletaChars(result.CodPlanoCotas,'.'));
  Result.ValPago := 0;
  Result.ValDuplicata :=0;
  Result.ValPrevisto :=0;
  result.IndNovo := true;
end;

{******************************************************************************}
procedure TRBFunRave.CarDPedidosAtrasados(VpaPedidosAtrasados: TList; VpaDatIni, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente, VpaCodVendedor:integer; VpaCampoPrimeiraData:String);
var
  VpfDPedidos: TRBDRPedidosAtrasadosRave;
  VpfNotaAnterior, VpfQtdDias: integer;
begin
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela, 'SELECT NOTA.I_EMP_FIL, NOTA.I_SEQ_NOT, NOTA.D_DAT_EMI,  ' +
                    ' MOV.N_QTD_PRO, MOV.N_TOT_PRO,MOV.I_SEQ_PRO  ' +
                    ' FROM  CADNOTAFISCAIS NOTA, ' +
                    ' MOVNOTASFISCAIS MOV' +
                    ' WHERE ' + SQLTextoDataEntreAAAAMMDD('NOTA.D_DAT_EMI', VpaDatIni, VpaDatFim, false) +
                    ' AND NOTA.I_SEQ_NOT  = MOV.I_SEQ_NOT ' +
                    ' AND NOTA.I_EMP_FIL  = MOV.I_EMP_FIL ' +
                    ' AND NOTA.C_NOT_CAN = ''N''');

  if VpaCodFilial <> 0 then
    AdicionaSqlTabela(Tabela,' AND NOTA.I_EMP_FIL = '+InttoStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' AND NOTA.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor <> 0 then
    AdicionaSQLTabela(Tabela, ' AND NOTA.I_COD_VEN = '+ IntToStr(VpaCodVendedor));

  AdicionaSqlTabela(Tabela, ' ORDER BY I_SEQ_NOT ');
  Tabela.open;

  FreeTObjectsList(VpaPedidosAtrasados);
  VpfNotaAnterior:= -99999;
  while not Tabela.Eof do
  begin
    VpfQtdDias :=RDataPedido(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_NOT').AsInteger,Tabela.FieldByName('I_SEQ_PRO').AsInteger,VpaCampoPrimeiraData,Tabela.FieldByName('D_DAT_EMI').AsDateTime);
    VpfDPedidos:= RDPedidosAtrasados(VpfQtdDias, VpaPedidosAtrasados);
    if VpfNotaAnterior <> Tabela.FieldByName('I_SEQ_NOT').AsInteger then
      VpfDPedidos.QtdPedidos := VpfDPedidos.QtdPedidos + 1;

    VpfDPedidos.QtdProdutos:= VpfDPedidos.QtdProdutos + Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDPedidos.ValProdutos:= VpfDPedidos.ValProdutos + Tabela.FieldByName('N_TOT_PRO').AsFloat;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.CarDPedidosAtrasadosOrcamentos(VpaPedidosAtrasados: TList;
  VpaDatIni, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente,
  VpaCodVendedor: integer; VpaCampoPrimeiraData:String);
Var
  VpfNumPedidoAnterior:integer;
  VpfDPedidos: TRBDRPedidosAtrasadosRave;
begin
  Tabela.Close;
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela, 'SELECT CAD.I_EMP_FIL, CAD.' + VpaCampoPrimeiraData + ', CAD.I_LAN_ORC, ' +
                    ' MOV.QTDPARCIAL, MOV.VALTOTAL, ORC.DATPARCIAL ' +
                    ' FROM CADORCAMENTOS CAD, ORCAMENTOPARCIALCORPO ORC, ' +
                    ' ORCAMENTOPARCIALITEM MOV ' +
                    ' WHERE ' + SQLTextoDataEntreAAAAMMDD('ORC.DATPARCIAL', VpaDatIni, VpaDatFim, false) +
                    ' AND ORC.LANORCAMENTO  = MOV.LANORCAMENTO ' +
                    ' AND ORC.CODFILIAL  = MOV.CODFILIAL ' +
                    ' AND ORC.SEQPARCIAL = MOV.SEQPARCIAL '+
                    ' AND CAD.I_EMP_FIL  = ORC.CODFILIAL ' +
                    ' AND CAD.I_LAN_ORC  = ORC.LANORCAMENTO ');

  if VpaCodFilial <> 0 then
    AdicionaSqlTabela(Tabela,' AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor <> 0 then
    AdicionaSQLTabela(Tabela, ' AND CAD.I_COD_VEN = '+ IntToStr(VpaCodVendedor));

  AdicionaSqlTabela(Tabela, ' ORDER BY I_LAN_ORC ');
  Tabela.open;

  VpfNumPedidoAnterior:= -99999;
  while not Tabela.Eof do
  begin
    if Tabela.FieldByName('I_LAN_ORC').AsInteger <> VpfNumPedidoAnterior then
    begin
      VpfDPedidos:= RDPedidosAtrasados(DiasPorPeriodo(Tabela.FieldByName(VpaCampoPrimeiraData).AsDateTime, Tabela.FieldByName('DATPARCIAL').AsDateTime), VpaPedidosAtrasados);
      VpfNumPedidoAnterior:= Tabela.FieldByName('I_LAN_ORC').AsInteger;
      VpfDPedidos.QtdPedidos:= VpfDPedidos.QtdPedidos + 1;
    end;
    VpfDPedidos.QtdProdutos:= VpfDPedidos.QtdProdutos + Tabela.FieldByName('QTDPARCIAL').AsFloat;
    VpfDPedidos.ValProdutos:= VpfDPedidos.ValProdutos + Tabela.FieldByName('VALTOTAL').AsFloat;
    Tabela.Next;
  end;
  Tabela.Close;

end;

{******************************************************************************}
procedure TRBFunRave.CarEquipamentosContrato(VpaDContrato: TRBDContratoLocacaoRave);
var
  VpfDEquipamento : TRBDEquipamentoContratoLocacaoRave;
begin
  FreeTObjectsList(VpaDContrato.Equipamentos);
  VpaDContrato.ValTotalEquipamentos := 0;
  AdicionaSQLAbreTabela(Aux,'select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                            ' ITE.NUMSERIE, ITE.DESSETOR, '+
                            ' MOV.N_VLR_CUS '+
                            ' from CONTRATOITEM ITE, CADPRODUTOS PRO, MOVQDADEPRODUTO MOV '+
                            ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                            ' AND  ITE.SEQPRODUTO = MOV.I_SEQ_PRO '+
                            ' AND ITE.CODFILIAL = MOV.I_EMP_FIL ' +
                            ' AND MOV.I_COD_COR = 0 '+
                            ' AND MOV.I_COD_TAM = 0 ' +
                            ' AND ITE.CODFILIAL = ' + IntToStr(VpaDContrato.CodFilial)+
                            ' AND ITE.SEQCONTRATO = '+ IntToStr(VpaDContrato.SeqContrato)+
                            ' AND ITE.DATDESATIVACAO IS NULL '+
                            ' ORDER BY ITE.SEQITEM');
  while not Aux.Eof do
  begin
    VpfDEquipamento := VpaDContrato.addEquipamento;
    VpfDEquipamento.SeqProduto := Aux.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDEquipamento.CodProduto := Aux.FieldByName('C_COD_PRO').AsString;
    VpfDEquipamento.NomProduto := Aux.FieldByName('C_NOM_PRO').AsString;
    VpfDEquipamento.NumSerie := Aux.FieldByName('NUMSERIE').AsString;
    VpfDEquipamento.DesSetor := Aux.FieldByName('DESSETOR').AsString;
    VpfDEquipamento.ValorEquipamento := Aux.FieldByName('N_VLR_CUS').AsFloat;
    VpaDContrato.ValTotalEquipamentos := VpaDContrato.ValTotalEquipamentos + Aux.FieldByName('N_VLR_CUS').AsFloat;
    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFunRave.CarInsumosContrato(VpaDContrato: TRBDContratoLocacaoRave;VpaContabilizados: Boolean);
var
  VpfDInsumo : TRBDInsumoContratoLocacaoRave;
begin
  Aux.Close;
  Aux.SQL.Clear;
  AdicionaSQLTabela(Aux,'Select SUM(ITE.N_QTD_PRO) QTD, SUM(ITE.N_QTD_PRO * QTD.N_VLR_CUS) VALOR, PRO.I_SEQ_PRO, PRO.C_COD_PRO , PRO.C_NOM_PRO ' +
                            ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS ITE, MOVQDADEPRODUTO QTD, CADPRODUTOS PRO ' +
                            ' Where CAD.I_EMP_FIL = ITE.I_EMP_FIL ' +
                            ' AND CAD.I_LAN_ORC = ITE.I_LAN_ORC ' +
                            ' AND CAD.I_COD_CLI =  ' + IntToStr(VpaDContrato.CodCliente)+
                            ' AND ITE.I_SEQ_PRO = QTD.I_SEQ_PRO ' +
                            ' AND ITE.I_COD_COR = QTD.I_COD_COR ' +
                            ' AND QTD.I_EMP_FIL = ITE.I_EMP_FIL ' +
                            ' AND QTD.I_COD_TAM = 0 ' +
                            ' AND ITE.I_SEQ_PRO = PRO.I_SEQ_PRO ');
  if VpaContabilizados  then
  begin
    AdicionaSQLTabela(Aux,' AND CAD.I_TIP_ORC = ' + IntToStr(Varia.TipoCotacaoSuprimentoLocacao));
    VpaDContrato.ValTotalInsumosContabilizados := 0;
  end
  else
  begin
    AdicionaSQLTabela(Aux,' AND CAD.I_TIP_ORC <> ' + IntToStr(Varia.TipoCotacaoSuprimentoLocacao));
    VpaDContrato.ValTotalInsumosNAOContabilizados := 0;
  end;
  AdicionaSQLTabela(Aux,' GROUP BY PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO'+
                            ' ORDER BY 1 ' );
  Aux.Open;

  while not Aux.Eof do
  begin
    if VpaContabilizados then
    begin
      VpfDInsumo := VpaDContrato.addInsumoContabilizado;
      VpaDContrato.ValTotalInsumosContabilizados := VpaDContrato.ValTotalInsumosContabilizados + Aux.FieldByName('VALOR').AsFloat;
    end
    else
    begin
      VpfDInsumo := VpaDContrato.addInsumoNaoContabilizado;
      VpaDContrato.ValTotalInsumosNAOContabilizados := VpaDContrato.ValTotalInsumosNAOContabilizados + Aux.FieldByName('VALOR').AsFloat;
    end;
    VpfDInsumo.SeqProduto := Aux.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDInsumo.CodProduto := Aux.FieldByName('C_COD_PRO').AsString;
    VpfDInsumo.NomProduto := Aux.FieldByName('C_NOM_PRO').AsString;
    VpfDInsumo.QtdProduto := Aux.FieldByName('QTD').AsFloat;
    VpfDInsumo.ValCustoInsumo := Aux.FieldByName('VALOR').AsFloat;
    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFunRave.CarLeituraLocacao(VpaDContrato: TRBDContratoLocacaoRave;VpaCodFilial, VpaSeqContrato: Integer);
var
  VpfDLeituraContrato : TRBDLeiturasContratoLocacaoRave;
begin
  FreeTObjectsList(VpaDContrato.Leituras);
  VpaDContrato.ValTotalLeituras := 0;
  AdicionaSQLAbreTabela(Aux,'select MESLOCACAO, ANOLOCACAO, DATDIGITACAO, QTDCOPIA,  QTDEXCEDENTE, VALTOTALDESCONTO, VALEXECESSOFRANQUIA, '+
                            ' VALEXECESSOFRANQUIACOLOR '+
                            ' from LEITURALOCACAOCORPO  '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and SEQCONTRATO = '+IntToStr(VpaSeqContrato)+
                            ' order by DATDIGITACAO ');
  while not Aux.Eof do
  begin
    VpfDLeituraContrato := VpaDContrato.AddLeituraLocacao;
    VpfDLeituraContrato.MesLocacao := Aux.FieldByName('MESLOCACAO').AsInteger;
    VpfDLeituraContrato.AnoLocacao := Aux.FieldByName('ANOLOCACAO').AsInteger;
    VpfDLeituraContrato.DatDigitacao := Aux.FieldByName('DATDIGITACAO').AsDatetime;
    VpfDLeituraContrato.QtdCopia := Aux.FieldByName('QTDCOPIA').AsInteger;
    VpfDLeituraContrato.QtdExcedente := Aux.FieldByName('QTDEXCEDENTE').AsInteger;
    VpfDLeituraContrato.ValTotalDesconto := Aux.FieldByName('VALTOTALDESCONTO').AsFloat;
    VpfDLeituraContrato.ValExcessoFranquia := Aux.FieldByName('VALEXECESSOFRANQUIA').AsFloat;
    VpfDLeituraContrato.ValExcessoFranquiaColor := Aux.FieldByName('VALEXECESSOFRANQUIACOLOR').AsFloat;
    VpaDContrato.ValTotalLeituras := VpaDContrato.ValTotalLeituras + Aux.FieldByName('VALTOTALDESCONTO').AsFloat;
    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFunRave.CarManequinsOPConvencional(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta; VpaDProduto: TRBDProduto);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoInicio, VpfCodCombAnt, VpfQtdManequins : Integer;
begin
  VpfQtdManequins := 0;
  VpfLacoInicio := 0;
  VpfCodCombAnt := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[0]).CodCombinacao ;
  with RVSystem.BaseReport do
  begin
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    restoretabs(7);
    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]) ;
      if (VpfDOrdemItem.CodManequim = '') then
        exit;

      if (VpfQtdManequins > 4) or (VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt) then
      begin
        newline;
        VpfQtdManequins := 0;
        RMetrosFitaManequim(VpaDOPEtikArt,VpfLacoInicio,VpfLaco-1);
        newline;
        If LinesLeft<=1 Then
          NewPage;
        VpfLacoInicio := VpfLaco;
        if (VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt) then
          break;
      end;
      PrintTab(VpfDOrdemItem.CodManequim);
      inc(VpfQtdManequins);
    end;
    if (Vpflaco >= VpaDOPEtikArt.Items.Count) then
      dec(VpfLaco);
    if VpfQtdManequins <> 0 then
    begin
        Newline;
        RMetrosFitaManequim(VpaDOPEtikArt,VpfLacoInicio,vpflaco);
        newline;
        If LinesLeft<=1 Then
          NewPage;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarMetrosCombinacaoOPH(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    NewPage;
    SetFont('Arial',10);
    RestoreTabs(8);
    PrintTab('CB');
    PrintTab('Manequim');
    PrintTab('Metros por Fita');
    PrintTab('Qtd Fitas');
    newline;
    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]);
      PrintTab(IntTosTr(VpfDOrdemItem.CodCombinacao));
      PrintTab(VpfDOrdemItem.CodManequim);
      PrintTab(FormatFloat('##,##0.00',(VpfDOrdemItem.MetrosFita * VpaDProduto.CmpProduto)/1000));
      PrintTab(IntTostr(VpfDOrdemItem.QtdFitas));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarPecasContrato(VpaDContrato: TRBDContratoLocacaoRave);
Var
  VpfDPecaContrato : TRBDPecasContratoLocacaoRave;
begin
  VpaDContrato.ValTotalPecas := 0;
  AdicionaSQLAbreTabela(Aux,'select SUM(CPO.QTDPRODUTO) QTD, SUM(CPO.QTDPRODUTO * QTD.N_VLR_CUS) CUSTO, PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                            ' from CHAMADOPRODUTO CHP, CHAMADOPRODUTOORCADO CPO, CADPRODUTOS PRO, MOVQDADEPRODUTO QTD '+
                            ' WHERE CHP.CODFILIALCONTRATO = '+ IntToStr(VpaDContrato.CodFilial)+
                            ' AND  CHP.SEQCONTRATO =  '+ IntToStr(VpaDContrato.SeqContrato)+
                            ' AND CHP.CODFILIAL = CPO.CODFILIAL '+
                            ' AND CHP.NUMCHAMADO = CPO.NUMCHAMADO '+
                            ' AND CHP.SEQITEM = CPO.SEQITEM '+
                            ' AND CPO.SEQPRODUTO = PRO.I_SEQ_PRO '+
                            ' AND CPO.SEQPRODUTO = QTD.I_SEQ_PRO '+
                            ' AND QTD.I_EMP_FIL = CHP.CODFILIAL '+
                            ' AND QTD.I_COD_COR =0 '+
                            ' AND QTD.I_COD_TAM = 0 '+
                            ' GROUP BY PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                            ' order by 1');
  while not Aux.Eof do
  begin
    VpaDContrato.ValTotalPecas := VpaDContrato.ValTotalPecas + Aux.FieldByName('CUSTO').AsFloat;
    VpfDPecaContrato := VpaDContrato.addPeca;
    VpfDPecaContrato.SeqProduto := Aux.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDPecaContrato.CodProduto := Aux.FieldByName('C_COD_PRO').AsString;
    VpfDPecaContrato.NomProduto := Aux.FieldByName('C_NOM_PRO').AsString;
    VpfDPecaContrato.QtdPecas := Aux.FieldByName('QTD').AsFloat;
    VpfDPecaContrato.ValCusto := Aux.FieldByName('CUSTO').AsFloat;
    aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
Function TRBFunRave.CarregaNiveis(VpaNiveis : TList;VpaCodClassificacao : string):TRBDClassificacaoRave;
var
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfMascaraProduto : STring;
  VpfCodClaCompleto,
  VpfCodClassificacaoAtual : String;
  VpfNivel, VpfTamanhoAtual : Integer;
begin
  if VprServico  then
    VpfMascaraProduto := varia.MascaraClaSer
  else
    VpfMascaraProduto := varia.MascaraCla;
  VpfNivel := 0;
  VpfCodClaCompleto := '';

  while VpaCodClassificacao <> '' do
  begin
    inc(VpfNivel);
    VpfTamanhoAtual := length(CopiaAteChar(VpfMascaraProduto,'.'));
    vpfMascaraProduto := DeleteAteChar(VpfMascaraProduto,'.');
    VpfCodClassificacaoAtual := copy(VpaCodClassificacao,1,VpfTamanhoAtual);
    VpacodClassificacao := copy(VpaCodClassificacao,VpfTamanhoAtual+1,length(VpacodClassificacao)-VpfTamanhoAtual);
    if VpfCodClaCompleto <> '' then
      VpfCodClaCompleto := VpfCodClaCompleto +'.'+VpfCodClassificacaoAtual
    else
      VpfCodClaCompleto := VpfCodClassificacaoAtual;

    if VpfNivel > VpaNiveis.count then
    begin
      VpfDClassificacao := CarDNivel(VpfCodClaCompleto,VpfCodClassificacaoAtual);
      VpaNiveis.add(VpfDClassificacao);
    end
    else
      if VpfCodClassificacaoAtual <> TRBDClassificacaoRave(VpaNiveis.Items[VpfNivel-1]).CodReduzido then
      begin
        ImprimeTotaisNiveis(VpaNiveis,VpfNivel-1);
        VpfDClassificacao := CarDNivel(VpfCodClaCompleto,VpfCodClassificacaoAtual);
        VpaNiveis.add(VpfDClassificacao);
      end;
    result := VpfDClassificacao;
  end;
end;

{******************************************************************************}
function TRBFunRave.CarregaNiveisPlanoContas(VpaNiveis: TList;VpaCodPlanoContas: string;VpaImprimirTotal : Boolean): TRBDPlanoContasRave;
var
  VpfDPlanoContas : TRBDPlanoContasRave;
  VpfMascaraPlanoContas : STring;
  VpfCodPlanoCompleto,
  VpfCodPlanoContasAtual : String;
  VpfNivel, VpfTamanhoAtual : Integer;
begin
  VpfMascaraPlanoContas := varia.MascaraPlanoConta;
  VpfNivel := 0;
  VpfCodPlanoCompleto := '';

  while VpaCodPlanoContas <> '' do
  begin
    inc(VpfNivel);
    VpfTamanhoAtual := length(CopiaAteChar(VpfMascaraPlanoContas,'.'));
    VpfMascaraPlanoContas := DeleteAteChar(VpfMascaraPlanoContas,'.');
    VpfCodPlanoContasAtual := copy(VpaCodPlanoContas,1,VpfTamanhoAtual);
    VpaCodPlanoContas := copy(VpaCodPlanoContas,VpfTamanhoAtual+1,length(VpaCodPlanoContas)-VpfTamanhoAtual);
    if VpfCodPlanoCompleto <> '' then
      VpfCodPlanoCompleto := VpfCodPlanoCompleto +'.'+VpfCodPlanoContasAtual
    else
      VpfCodPlanoCompleto := VpfCodPlanoContasAtual;

    if VpfNivel > VpaNiveis.count then
    begin
      VpfDPlanoContas := CarDNivelPlanoContas(VpfCodPlanoCompleto,VpfCodPlanoContasAtual);
      VpaNiveis.add(VpfDPlanoContas);
    end
    else
      if VpfCodPlanoContasAtual <> TRBDPlanoContasRave(VpaNiveis.Items[VpfNivel-1]).CodReduzido then
      begin
        ImprimeTotaisNiveisPlanoContas(VpaNiveis,VpfNivel-1);
        VpfDPlanoContas := CarDNivelPlanoContas(VpfCodPlanoCompleto,VpfCodPlanoContasAtual);
        VpaNiveis.add(VpfDPlanoContas);
      end;
    result := VpfDPlanoContas;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarregaValoresMesTabela(VpaDVenda: TRBDVendaCliente; VpaCodPlanoContas, VpaNomPlanoContas : String);
var
  VpfLacoAno,VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  with RVSystem.BaseReport do
  begin
      for VpfLacoAno := 0 to VpaDVenda.Anos.Count - 1 do
      begin
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
        VpfDVendaAno := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno]);
        PrintTab(VpaCodPlanoContas);
        PrintTab(VpaNomPlanoContas);
        VpaCodPlanoContas := '';
        VpaNomPlanoContas := '';
        PrintTab(IntToStr(VpfDVendaAno.Ano));
        for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
        begin
          VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
          if VpfDVendaMes.ValVenda <> 0 then
          begin
            PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDVendaMes.ValVenda))
          end
          else
            PrintTab('');
        end;
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDVendaAno.ValVenda));
      end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarRenovacaoContrato(VpaCodCliente: Integer;VpaDatFimVigencia: TDateTime; var VpaDatAssinatura, VpaDatInicioNovoContrato,VpaDatFimNovoContrato: TDateTime; var VpaValorContrato: Double);
begin
  AdicionaSQLAbreTabela(Aux,'Select DATINICIOVIGENCIA, DATFIMVIGENCIA, DATASSINATURA, VALCONTRATO ' +
                            ' FROM CONTRATOCORPO ' +
                            ' WHERE CODCLIENTE = '+IntToStr(VpaCodCliente)+
                            ' AND DATINICIOVIGENCIA >= '+SQLTextoDataAAAAMMMDD(DecMes(VpaDatFimVigencia,5)));
  VpaDatAssinatura := Aux.FieldByName('DATASSINATURA').AsDateTime;
  VpaDatInicioNovoContrato := Aux.FieldByName('DATINICIOVIGENCIA').AsDateTime;
  VpaDatFimNovoContrato := Aux.FieldByName('DATFIMVIGENCIA').AsDateTime;
  VpaValorContrato := 0;
  while not Aux.Eof do
  begin
    VpaValorContrato := VpaValorContrato + Aux.FieldByName('VALCONTRATO').AsFloat;
    Aux.next;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.InicializaMeses(VpaDVendaAno: TRBDVendaClienteAno);
var
  VpfLacoMes : Integer;
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  for VpfLacoMes := 1 to 12 do
  begin
    VpfDVendaMes := VpaDVendaAno.addMes;
    VpfDVendaMes.Mes := VpfLacoMes;
    VpfDVendaMes.ValVenda := 0;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.InicializaVendaCliente(VpaDatInicio,VpaDatFim : TDateTime; VpaDVenda : TRBDVendaCliente);
var
  VpfLacoAno : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
begin
  VpaDVenda.Free;
  VpaDVenda := TRBDVendaCliente.cria;
  for VpfLacoAno := Ano(VpaDatInicio) to Ano(VpaDatFim) do
  begin
    VpfDVendaAno := VpaDVenda.addAno;
    VpfDVendaAno.Ano := VpfLacoAno;
    VpfDVendaAno.ValVenda := 0;
    InicializaMeses(VpfDVendaAno);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.InicializaVendaClienteRepresentada(VpaDatInicio,VpaDatFim: TDateTime; VpaDVenda: TRBDVendaCliente);
var
  VpfLacoAno, VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfDRepresentada : TRBDVendaClienteRepresentada;
begin
  VpaDVenda.Free;
  VpaDVenda := TRBDVendaCliente.cria;
  AdicionaSQLAbreTabela(Tabela,'Select CODREPRESENTADA, NOMFANTASIA '+
                               ' from REPRESENTADA '+
                               ' ORDER BY NOMFANTASIA ');
  while not Tabela.eof do
  begin
    VpfDRepresentada := VpaDVenda.addRepresentada;
    VpfDRepresentada.NomRepresentada := Tabela.FieldByName('NOMFANTASIA').AsString;
    for VpfLacoAno := Ano(VpaDatInicio) to Ano(VpaDatFim) do
    begin
      VpfDVendaAno := VpfDRepresentada.addAno;
      VpfDVendaAno.Ano := VpfLacoAno;
      for VpfLacoMes := 1 to 12 do
      begin
        VpfDVendaMes := VpfDVendaAno.addMes;
        VpfDVendaMes.Mes := VpfLacoMes;
      end;
    end;
    Tabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.OrdenaConsumoAmostrasDia(VpaConsumoAmostras: TList);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDConsumoAmostraExt, vpfDConsumoAmostraInt : TRBDRConsumoEntregaAmostrasRave;
begin
  for VpfLacoExterno := 0 to VpaConsumoAmostras.Count -2  do
  begin
    VpfDConsumoAmostraExt := TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostras.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaConsumoAmostras.Count - 1 do
    begin
      vpfDConsumoAmostraInt := TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostras.Items[VpfLacoInterno]);
      if VpfDConsumoAmostraExt.QtdDias > vpfDConsumoAmostraInt.QtdDias then
      begin
        VpaConsumoAmostras.Items[VpflacoExterno] := VpaConsumoAmostras.Items[VpflacoInterno];
        VpaConsumoAmostras.Items[VpfLacoInterno] := VpfDConsumoAmostraExt;
        VpfDConsumoAmostraExt := TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostras.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.OrdenaConsumoAmostrasQtdAmostra(VpaConsumoAmostras: TList);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDConsumoAmostraExt, vpfDConsumoAmostraInt : TRBDRConsumoEntregaAmostrasRave;
begin
  for VpfLacoExterno := 0 to VpaConsumoAmostras.Count -2  do
  begin
    VpfDConsumoAmostraExt := TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostras.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaConsumoAmostras.Count - 1 do
    begin
      vpfDConsumoAmostraInt := TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostras.Items[VpfLacoInterno]);
      if VpfDConsumoAmostraExt.QtdAmostras < vpfDConsumoAmostraInt.QtdAmostras then
      begin
        VpaConsumoAmostras.Items[VpflacoExterno] := VpaConsumoAmostras.Items[VpflacoInterno];
        VpaConsumoAmostras.Items[VpfLacoInterno] := VpfDConsumoAmostraExt;
        VpfDConsumoAmostraExt := TRBDRConsumoEntregaAmostrasRave(VpaConsumoAmostras.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.OrdenaPedidosAtrasadosDia(VpaPedidosAtrasados: TList);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDPedidosAtrasadosExt, vpfDPedidosAtrasadosInt : TRBDRPedidosAtrasadosRave;
begin
  for VpfLacoExterno := 0 to VpaPedidosAtrasados.Count -2  do
  begin
    VpfDPedidosAtrasadosExt := TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaPedidosAtrasados.Count - 1 do
    begin
      vpfDPedidosAtrasadosInt := TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLacoInterno]);
      if VpfDPedidosAtrasadosExt.QtdDias > vpfDPedidosAtrasadosInt.QtdDias then
      begin
        VpaPedidosAtrasados.Items[VpflacoExterno] := VpaPedidosAtrasados.Items[VpflacoInterno];
        VpaPedidosAtrasados.Items[VpfLacoInterno] := VpfDPedidosAtrasadosExt;
        VpfDPedidosAtrasadosExt := TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.OrdenaPedidosAtrasadosQtdPedido(
  VpaPedidosAtrasados: TList);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDPedidosAtrasadosExt, vpfDPedidosAtrasadosInt : TRBDRPedidosAtrasadosRave;
begin
  for VpfLacoExterno := 0 to VpaPedidosAtrasados.Count -2  do
  begin
    VpfDPedidosAtrasadosExt := TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaPedidosAtrasados.Count - 1 do
    begin
      vpfDPedidosAtrasadosInt := TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLacoInterno]);
      if VpfDPedidosAtrasadosExt.QtdPedidos < vpfDPedidosAtrasadosInt.QtdPedidos then
      begin
        VpaPedidosAtrasados.Items[VpflacoExterno] := VpaPedidosAtrasados.Items[VpflacoInterno];
        VpaPedidosAtrasados.Items[VpfLacoInterno] := VpfDPedidosAtrasadosExt;
        VpfDPedidosAtrasadosExt := TRBDRPedidosAtrasadosRave(VpaPedidosAtrasados.Items[VpfLacoExterno]);
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.OrdenaRomaneioCotacoes(VpaRomaneio: TList);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDProExterno, vpfDProInterno : TRBDOrcProduto;
begin
  for VpfLacoExterno := 0 to VpaRomaneio.Count -2  do
  begin
    VpfDProExterno := TRBDOrcProduto(VpaRomaneio.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaRomaneio.Count - 1 do
    begin
      VpfDProInterno := TRBDOrcProduto(VpaRomaneio.Items[VpfLacoInterno]);
      if (VpfDProExterno.DesPrateleira > vpfDProInterno.DesPrateleira) then
      begin
        if (VpfDProExterno.DesPrateleira = vpfDProInterno.DesPrateleira) then
          begin
            if (VpfDProExterno.NomProduto > vpfDProInterno.NomProduto) then
             begin
               VpaRomaneio.Items[VpflacoExterno] := VpaRomaneio.Items[VpflacoInterno];
               VpaRomaneio.Items[VpfLacoInterno] := VpfDProExterno;
               VpfDProExterno := TRBDOrcProduto(VpaRomaneio.Items[VpfLacoExterno]);
             end;
          end;
          VpaRomaneio.Items[VpflacoExterno] := VpaRomaneio.Items[VpflacoInterno];
          VpaRomaneio.Items[VpfLacoInterno] := VpfDProExterno;
          VpfDProExterno := TRBDOrcProduto(VpaRomaneio.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.PreparaRomaneioCotacoes(VpaCotacoes, VpaRomaneio: TList);
var
  VpfLacoCotacao, VpfLacoProduto : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao, VpfDProRomaneio : TRBDOrcProduto;
begin
  FreeTObjectsList(VpaRomaneio);
  for VpfLacoCotacao := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoCotacao]);
    for VpfLacoProduto := 0 to VpfDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
      VpfDProRomaneio := RProdutoRomaneio(VpaRomaneio,VpfDProCotacao);
      VpfDProRomaneio.QtdProduto := VpfDProRomaneio.QtdProduto + FunProdutos.CalculaQdadePadrao(VpfDProCotacao.UM,VpfDProRomaneio.UM,VpfDProCotacao.QtdProduto,InttoStr(VpfDProCotacao.SeqProduto));//Verificar aqui
    end;
  end;
  OrdenaRomaneioCotacoes(VpaRomaneio);
end;

{******************************************************************************}
function TRBFunRave.RMesTotal(VpaDVendaAno: TRBDVendaClienteAno; VpaMes: Integer): TRBDVendaClienteMes;
var
  VpfLaco : Integer;
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  for VpfLaco := 0 to VpaDVendaAno.Meses.Count - 1 do
  begin
    VpfDVendaMes := TRBDVendaClienteMes(VpaDVendaAno.Meses.Items[VpfLaco]);
    if VpfDVendaMes.Mes = VpaMes then
    begin
      Result := VpfDVendaMes;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFunRave.RMesVenda(VpaDVenda : TRBDVendaCliente;VpaMes, VpaAno : Integer) : TRBDVendaClienteMes;
var
  VpfLacoAno, VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  result := nil;
  for VpflacoAno := 0 to VpaDVenda.Anos.Count - 1 do
  begin
    VpfDVendaAno := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno]);
    if VpfDVendaAno.Ano = VpaAno then
    begin
      for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
      begin
        VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
        if VpfDVendaMes.Mes = VpaMes then
          exit(VpfDVendaMes);
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFunRave.RMesVendaRepresentada(VpaDVenda: TRBDVendaCliente; VpaNomRepresentada: String; VpaMes, VpaAno: Integer): TRBDVendaClienteMes;
var
  VpfLacoRepresentada, VpfLacoAno, VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfDVendaRepresentada : TRBDVendaClienteRepresentada;
begin
  result := nil;
  for VpfLacoRepresentada := 0 to VpaDVenda.Representadas.Count - 1 do
  begin
    VpfDVendaRepresentada := TRBDVendaClienteRepresentada(VpaDVenda.Representadas.Items[VpflacoRepresentada]);
    if VpfDVendaRepresentada.NomRepresentada = VpaNomRepresentada then
    begin
      for VpflacoAno := 0 to VpfDVendaRepresentada.Anos.Count - 1 do
      begin
        VpfDVendaAno := TRBDVendaClienteAno(VpfDVendaRepresentada.Anos.Items[VpfLacoAno]);
        if VpfDVendaAno.Ano = VpaAno then
        begin
          for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
          begin
            VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
            if VpfDVendaMes.Mes = VpaMes then
              exit(VpfDVendaMes);
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.RMetrosFitaManequim(VpaDOrdemProducao: TRBDOrdemProducaoEtiqueta; VpaLacoInicio,VpaLacoFim: Integer);
var
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    for VpfLaco := VpaLacoInicio to VpaLacoFim do
      printTab(FloatToStr(TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]).MetrosFita));
    newline;
  end;
end;

{******************************************************************************}
function TRBFunRave.RProdutoRomaneio(VpaRomaneios: TList; VpaDProCotacao : TRBDOrcProduto): TRBDOrcProduto;
var
  VpfLaco : Integer;
  VpfDProRomaneio : TRBDOrcProduto;
begin
  result := nil;
  for VpfLaco := 0 to VpaRomaneios.Count - 1 do
  begin
    VpfDProRomaneio := TRBDOrcProduto(VpaRomaneios.Items[Vpflaco]);
    if (VpfDProRomaneio.NomProduto = VpaDProCotacao.NomProduto) and
       (VpfDProRomaneio.CodCor = VpaDProCotacao.CodCor) and
       (VpfDProRomaneio.CodTamanho = VpaDProCotacao.CodTamanho) and
       (VpfDProRomaneio.AltProdutonaGrade = VpaDProCotacao.AltProdutonaGrade) and
       (VpfDProRomaneio.DesCor = VpaDProCotacao.DesCor)   then
    begin
      result := VpfDProRomaneio;
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDOrcProduto.cria;
    FunCotacao.CopiaDProdutoCotacao(VpaDProCotacao,result);
    Result.QtdProduto := 0;
    VpaRomaneios.Add(result);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.AdicionaProdutoNota(VpaNotasEntrada: TList;VpaDProduto: TRBDProdutosTibFaturadosST;VpaDNota : TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDNotaCompra : TRBDNotaEntradaProdutosTibFaturadosST;
  VpfAdicionou : Boolean;
begin
  VpfAdicionou := false;
  for VpfLaco := 0 to VpaNotasEntrada.Count - 1 do
  begin
    VpfDNotaCompra := TRBDNotaEntradaProdutosTibFaturadosST(VpaNotasEntrada.Items[VpfLaco]);
    if (VpfDNotaCompra.NumNota = VpaDNota.NumNota) and (VpfDNotaCompra.DesCNPJ = VpaDNota.CGC_CPFFornecedor) then
    begin
      VpfAdicionou := true;
      VpfDNotaCompra.ProdutoFaturados.Add(VpaDProduto);
      break;
    end;
    if VpfDNotaCompra.NumNota > VpaDNota.NumNota then
    begin
      VpfDNotaCompra := TRBDNotaEntradaProdutosTibFaturadosST.cria;
      VpfDNotaCompra.NumNota := VpaDNota.NumNota;
      VpfDNotaCompra.NomForncedore := VpaDNota.NomFornecedor;
      VpfDNotaCompra.DesCNPJ := VpaDNota.CGC_CPFFornecedor;
      VpfDNotaCompra.DatEmissao := VpaDNota.DatEmissao;
      VpaNotasEntrada.Insert(VpfLaco,VpfDNotaCompra);
      VpfAdicionou := true;
      break;
    end;
  end;
  if not VpfAdicionou then
  begin
    VpfDNotaCompra := TRBDNotaEntradaProdutosTibFaturadosST.cria;
    VpfDNotaCompra.NumNota := VpaDNota.NumNota;
    VpfDNotaCompra.NomForncedore := VpaDNota.NomFornecedor;
    VpfDNotaCompra.DesCNPJ := VpaDNota.CGC_CPFFornecedor;
    VpfDNotaCompra.DatEmissao := VpaDNota.DatEmissao;
    VpaNotasEntrada.add(VpfDNotaCompra);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.AtualizaTotalVenda(VpaDVenda, VpaDTotalVendedor, VpaDTotalGeral : TRBDVendaCliente);
var
  VpfLacoAno, VpfLacoMes, VpfLacoClassificacao : Integer;
  VpfDVendaAno,VpfDVendaAnoAnterior, VpfDVendaAnoTotalVendedor, VpfDVendaAnoTotalGeral : TRBDVendaClienteAno;
  VpfDVendaMes, VpfDVendaMesAnterior, VpfDVendaMesTotalVendedor, VpfDVendaMesTotalGeral : TRBDVendaClienteMes;
  VpfDVendaClassificacao : TRBDVendaClienteClassificacaoProduto;
begin
  for VpflacoAno := 0 to VpaDVenda.Anos.Count - 1 do
  begin
    VpfDVendaAno := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno]);
    if VpaDTotalVendedor <> nil then
      VpfDVendaAnoTotalVendedor := TRBDVendaClienteAno(VpaDTotalVendedor.Anos.Items[VpfLacoAno]);
    if VpaDTotalGeral <> nil then
      VpfDVendaAnoTotalGeral := TRBDVendaClienteAno(VpaDTotalGeral.Anos.Items[VpfLacoAno]);
    VpfDVendaAno.ValVenda := 0;
    for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
    begin
      VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
      VpfDVendaAno.ValVenda := VpfDVendaAno.ValVenda + VpfDVendaMes.ValVenda;
      //total mes vendedor
      if VpaDTotalVendedor <> nil then
      begin
        VpfDVendaMesTotalVendedor := TRBDVendaClienteMes(VpfDVendaAnoTotalVendedor.Meses.Items[VpfLacoMes]);
        VpfDVendaMesTotalVendedor.ValVenda := VpfDVendaMesTotalVendedor.ValVenda + VpfDVendaMes.ValVenda;
        VpfDVendaAnoTotalVendedor.ValVenda := VpfDVendaAnoTotalVendedor.ValVenda + VpfDVendaMes.ValVenda;
      end;
      if VpaDTotalGeral <> nil then
      begin
        VpfDVendaMesTotalGeral := TRBDVendaClienteMes(VpfDVendaAnoTotalGeral.Meses.Items[VpfLacoMes]);
        VpfDVendaMesTotalGeral.ValVenda := VpfDVendaMesTotalGeral.ValVenda + VpfDVendaMes.ValVenda;
        VpfDVendaAnoTotalGeral.ValVenda := VpfDVendaAnoTotalGeral.ValVenda + VpfDVendaMes.ValVenda;
      end;
    end;
    for VpfLacoClassificacao := 0 to VpfDVendaAno.ClassificacoesProduto.Count - 1 do
    begin
      VpfDVendaClassificacao := TRBDVendaClienteClassificacaoProduto(VpfDVendaAno.ClassificacoesProduto.Items[VpfLacoClassificacao]);
      VpfDVendaClassificacao.ValTotal := 0;
      for VpfLacoMes := 0 to VpfDVendaClassificacao.Meses.Count - 1 do
      begin
        VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaClassificacao.Meses.Items[VpfLacoMes]);
        VpfDVendaClassificacao.ValTotal := VpfDVendaClassificacao.ValTotal + VpfDVendaMes.ValVenda;
      end;
    end;
  end;
  for VpfLacoAno := 1 to VpaDVenda.Anos.Count - 1 do
  begin
    VpfDVendaAnoAnterior := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno -1]);
    VpfDVendaAno := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno]);
    for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
    begin
      VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
      VpfDVendaMesAnterior := TRBDVendaClienteMes(VpfDVendaAnoAnterior.Meses.Items[VpfLacoMes]);
      if VpfDVendaMes.ValVenda = 0  then
        VpfDVendaMes.IndReducaoVenda := true
      else
        if ((VpfDVendaMes.ValVenda * 0.9) < VpfDVendaMesAnterior.ValVenda) then
          VpfDVendaMes.IndReducaoVenda := true;
    end;
    if VpfDVendaAno.ValVenda = 0 then
      VpfDVendaAno.IndReducaoVenda := true
    else
      if ((VpfDVendaAno.ValVenda * 0.9) < VpfDVendaAnoAnterior.ValVenda) then
        VpfDVendaAno.IndReducaoVenda := true;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.AtualizaTotalVendaRepresentada(VpaDVenda: TRBDVendaCliente);
var
  VpfLacoRepresentada, VpfLacoAno, VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfDVendaRepresentada : TRBDVendaClienteRepresentada;
begin
  for VpfLacoRepresentada := 0 to VpaDVenda.Representadas.Count - 1 do
  begin
    VpfDVendaRepresentada := TRBDVendaClienteRepresentada(VpaDVenda.Representadas.Items[VpflacoRepresentada]);
    VpfDVendaRepresentada.ValVenda := 0;
    for VpflacoAno := 0 to VpfDVendaRepresentada.Anos.Count - 1 do
    begin
      VpfDVendaAno := TRBDVendaClienteAno(VpfDVendaRepresentada.Anos.Items[VpfLacoAno]);
      VpfDVendaAno.ValVenda := 0;
      for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
      begin
        VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
        VpfDVendaAno.ValVenda := VpfDVendaAno.ValVenda + VpfDVendaMes.ValVenda;
        VpfDVendaRepresentada.ValVenda := VpfDVendaRepresentada.ValVenda + VpfDVendaMes.ValVenda;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarValoresContasAPagar(VpaCodFilial, VpaCodCentroCusto : Integer;VpaPlanoContas: String; VpaDatInicio, VpaDatFim: TDateTime; var VpaValPago, VpaValTotal: Double);

begin
  LimpaSQLTabela(Aux);
  AdicionaSQLTabela(Aux,'SELECT SUM(N_VLR_PAG) TOTALPAGO ,  SUM(NVL(N_VLR_PAG,N_VLR_DUP)) TOTAL ' +
                            ' FROM CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV ' +
                            ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                            ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+

                            ' AND CAD.C_CLA_PLA LIKE '''+VpaPlanoContas+'%'''+
                             SQLTextoDataEntreAAAAMMDD(VprCampoData,VpaDatInicio,VpaDatFim,TRUE));
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(Aux,'AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial))
  else
    AdicionaSQLTabela(Aux,' AND CAD.I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa));
  if VpaCodCentroCusto <> 0 then
    AdicionaSQLTabela(Aux,'and CAD.I_COD_CEN = '+IntToStr(VpaCodCentroCusto));
  AbreTabela(Aux);
  VpaValPago := Aux.FieldByName('TOTALPAGO').AsFloat;
  VpaValtotal := Aux.FieldByName('TOTAL').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TRBFunRave.CarValoresFaturadosCliente(VpaCodCliente,VpaCodFilial : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda, VpaDTotalVendedor, VpaDTotalGeral : TRBDVendaCliente):Boolean ;
var
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  InicializaVendaCliente(VpaDatInicio,VpaDatFim,VpaDVenda);
  if VprNotasFiscais then
  begin
    Tabela.Close;
    Tabela.SQL.Clear;
    Tabela.SQL.Add('select SUM(N_TOT_NOT) TOTAL, EXTRACT(Year FROM D_DAT_EMI) ANO, EXTRACT(MONTH FROM D_DAT_EMI) MES '+
                               ' from CADNOTAFISCAIS NOF '+
                               ' Where NOF.I_COD_CLI = '+IntToStr(VpaCodCliente)+
                               ' AND NOF.C_NOT_CAN = ''N'''+
                               ' AND NOF.C_FIN_GER = ''S'''+
                               SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
    if VprFilial <> 0 then
      Tabela.SQL.Add('and NOF.I_EMP_FIL = '+ IntToStr(VprFilial));
    Tabela.SQL.Add(' GROUP BY EXTRACT(Year FROM D_DAT_EMI), EXTRACT(MONTH FROM D_DAT_EMI) '+
                               ' ORDER BY 2,3');
    Tabela.Open;
  end
  else
  begin
    Tabela.Close;
    Tabela.SQL.Clear;
    Tabela.SQL.Add('select SUM(N_VLR_TOT) TOTAL, EXTRACT(Year FROM D_DAT_ORC) ANO, EXTRACT(MONTH FROM D_DAT_ORC) MES '+
                               ' from CADORCAMENTOS ORC '+
                               ' Where ORC.I_COD_CLI = '+IntToStr(VpaCodCliente)+
                               ' AND ORC.C_IND_CAN = ''N'''+
                               SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
    if VprCodTipoCotacao <> 0 then
      Tabela.SQL.Add('and ORC.I_TIP_ORC = '+ IntToStr(VprCodTipoCotacao));
    if VprFilial <> 0 then
      Tabela.SQL.Add('and ORC.I_EMP_FIL = '+ IntToStr(VprFilial));
    Tabela.SQL.Add(' GROUP BY EXTRACT(Year FROM D_DAT_ORC), EXTRACT(MONTH FROM D_DAT_ORC) '+
                               ' ORDER BY 2,3');
    Tabela.Open;
  end;
  result := not Tabela.Eof;
  while not Tabela.Eof do
  begin
    VpfDVendaMes := RMesVenda(VpaDVenda,Tabela.FieldByName('MES').AsInteger,Tabela.FieldByName('ANO').AsInteger);
    VpfDVendaMes.ValVenda := Tabela.FieldByName('TOTAL').AsFloat;
    Tabela.next;
  end;
  AtualizaTotalVenda(VpaDVenda,VpaDTotalVendedor,VpaDTotalGeral);
end;

{******************************************************************************}
function TRBFunRave.CarValoresPedidosRepresentadaCliente(VpaCodCliente: Integer;VpaDatInicio, VpaDatFim: TDateTime; VpaDVenda: TRBDVendaCliente): boolean;
var
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  InicializaVendaClienteRepresentada(VpaDatInicio,VpaDatFim,VpaDVenda);
  Tabela.Close;
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,'select SUM(N_VLR_TOT) TOTAL, REP.NOMFANTASIA, EXTRACT(Year FROM D_DAT_ORC) ANO, EXTRACT(MONTH FROM D_DAT_ORC) MES '+
                               ' from CADORCAMENTOS ORC, REPRESENTADA REP  '+
                               ' Where ORC.I_COD_CLI = '+IntToStr(VpaCodCliente)+
                               ' AND ORC.C_IND_CAN = ''N'''+
                               ' AND '+ SQLTextoRightJoin('ORC.I_COD_REP','REP.CODREPRESENTADA')+
                               SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VprCodTipoCotacao <> 0  then
    AdicionaSQLTabela(Tabela,'and ORC.I_TIP_ORC = '+IntToStr(VprCodTipoCotacao));
  if VprCodRepresentada <> 0 then
    AdicionaSQLTabela(Tabela,'AND ORC.I_COD_REP = ' +IntToStr(VprCodRepresentada));
  AdicionaSQLTabela(Tabela,' GROUP BY  REP.NOMFANTASIA, EXTRACT(Year FROM D_DAT_ORC), EXTRACT(MONTH FROM D_DAT_ORC) '+
                           ' ORDER BY 2,3,4');
  Tabela.Open;
  result := not Tabela.Eof;
  while not Tabela.Eof do
  begin
    VpfDVendaMes := RMesVendaRepresentada(VpaDVenda,Tabela.FieldByName('NOMFANTASIA').AsString,Tabela.FieldByName('MES').AsInteger,Tabela.FieldByName('ANO').AsInteger);
    VpfDVendaMes.ValVenda := Tabela.FieldByName('TOTAL').AsFloat;
    Tabela.next;
  end;
  AtualizaTotalVendaRepresentada(VpaDVenda);
end;

{******************************************************************************}
function TRBFunRave.CarValoresPlanoContasMes(VpaCodFilial : Integer; VpaPlanoContas: String; VpaDatInicio, VpaDatFim: TDateTime; VpaDVenda: TRBDVendaCliente): boolean;
var
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  InicializaVendaCliente(VpaDatInicio,VpaDatFim,VpaDVenda);
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,'SELECT   SUM(NVL(N_VLR_PAG,N_VLR_DUP)) TOTAL ,EXTRACT(Year FROM '+VprCampoData+') ANO, EXTRACT(MONTH FROM '+VprCampoData+') MES '+
                               ' FROM CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+
                               ' AND CAD.I_COD_EMP =  '+IntToStr(varia.CodigoEmpresa)+
                               ' AND CAD.C_CLA_PLA like '''+VpaPlanoContas+'%'''+
                               SQLTextoDataEntreAAAAMMDD(VprCampoData,VpaDatInicio,VpaDatFim,true));
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(Tabela,'and MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial));
  AdicionaSQLTabela(Tabela,'group by EXTRACT(Year FROM '+VprCampoData+'), EXTRACT(MONTH FROM '+VprCampoData+') '+
                               ' ORDER BY 2,3');
  Tabela.Open;
  result := not Tabela.Eof;
  while not Tabela.Eof do
  begin
    VpfDVendaMes := RMesVenda(VpaDVenda,Tabela.FieldByName('MES').AsInteger,Tabela.FieldByName('ANO').AsInteger);
    VpfDVendaMes.ValVenda := Tabela.FieldByName('TOTAL').AsFloat;
    Tabela.next;
  end;
  AtualizaTotalVenda(VpaDVenda,nil,nil);
end;

{******************************************************************************}
function TRBFunRave.CarValoresQtdProdutosCliente(VpaCodCliente: Integer; VpaDatInicio, VpaDatFim: TDateTime;VpaDVenda: TRBDVendaCliente): boolean;
var
  VpfDVendaMes, VpfDVendaClassificacao : TRBDVendaClienteMes;
begin
  InicializaVendaCliente(VpaDatInicio,VpaDatFim,VpaDVenda);
  Tabela.Close;
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,'SELECT EXTRACT(Year FROM CAD.D_DAT_ORC) ANO, EXTRACT(MONTH FROM CAD.D_DAT_ORC) MES, SUBSTR(CLA.C_COD_CLA,1,'+IntToStr(VprQtdLetras)+') C_COD_CLA, SUM(N_QTD_PRO)TOTAL '+
                           ' FROM MOVORCAMENTOS MOV , CADORCAMENTOS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA '+
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                           ' AND CLA.I_COD_EMP = PRO.I_COD_EMP '+
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CLA.C_COD_CLA  = PRO.C_COD_CLA '+
                           ' AND CLA.C_TIP_CLA = PRO.C_TIP_CLA '+
                           ' AND CAD.I_COD_CLI = '+ IntToStr(VpaCodCliente)+
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VprCodClassificacao <> '' then
    AdicionaSQLTabela(Tabela,'and PRO.C_COD_CLA LIKE '''+ VprCodClassificacao+'%''');

  if VprCodTipoCotacao <> 0  then
    AdicionaSQLTabela(Tabela,'and CAD.I_TIP_ORC = '+IntToStr(VprCodTipoCotacao));
  AdicionaSQLTabela(Tabela,' GROUP BY  SUBSTR(CLA.C_COD_CLA,1,'+IntToStr(VprQtdLetras)+'), CLA.C_NOM_CLA, EXTRACT(Year FROM CAD.D_DAT_ORC), EXTRACT(MONTH FROM CAD.D_DAT_ORC)'+
                           ' ORDER BY 1,2,3 ');
  Tabela.Open;
  result := not Tabela.Eof;
  while not Tabela.Eof do
  begin
    VpfDVendaMes := RMesVenda(VpaDVenda,Tabela.FieldByName('MES').AsInteger,Tabela.FieldByName('ANO').AsInteger);
    VpfDVendaMes.ValVenda := VpfDVendaMes.ValVenda + Tabela.FieldByName('TOTAL').AsFloat;
    VpfDVendaClassificacao := RVendaClassificacao(VpaDVenda,Tabela.FieldByName('MES').AsInteger,Tabela.FieldByName('ANO').AsInteger,Tabela.FieldByName('C_COD_CLA').AsString);
    VpfDVendaClassificacao.ValVenda := VpfDVendaClassificacao.ValVenda + Tabela.FieldByName('TOTAL').AsFloat;
    Tabela.next;
  end;
  AtualizaTotalVenda(VpaDVenda,nil,nil);
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.CarValorTrocasProdutos(VpaDProduto: TRBDProdutoRave; VpaDatInicio, VpaDatFim: TDateTime; VpaSeqProduto: Integer);
begin
  Aux.Close;
  Aux.sql.clear;
  AdicionaSqlTabela(Aux,'Select sum(MOV.N_QTD_PRO) QTDPRODUTO, SUM(MOV.N_TOT_PRO) TOTAL '+
                            ' from CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV, CADCLIENTES CLI '+
                            ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                            ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                            ' AND MOV.I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                            ' and CAD.I_COD_CLI = CLI.I_COD_CLI '+
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  if VprClienteMaster <> 0  then
    AdicionaSqlTabela(Aux,' and CLI.I_CLI_MAS = '+InttoStr(VprClienteMaster));
  if VprCliente <> 0  then
    AdicionaSqlTabela(Aux,' and CLI.I_COD_CLI = '+InttoStr(VprCliente));
  if VprFilial <> 0  then
    AdicionaSqlTabela(Aux,' and CAD.I_EMP_FIL = '+InttoStr(VprFilial));
  Aux.open;
  VpaDProduto.QtdTrocada := Aux.FieldByName('QTDPRODUTO').AsFloat;
  VpaDProduto.ValTroca := Aux.FieldByName('TOTAL').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFunRave.CarQtdVendidaDemandaCompra(VpaDProdutoRave: TRBDProdutoRave;VpaDCorRave: TRBDCorProdutoRave; VpaDTamanho: TRBDTamanhoProdutoRave;VpaDaInicial, VpaDatFinal: Double);
var
  VpfDVendaMEsCor, VpfDVendaMesTamanho, VpfDVendaMesProduto : TRBDVendaMesProduto;
  VpfQtdVendida : DOUBLe;
begin
  AdicionaSQLAbreTabela(Clientes,'Select MOV.N_QTD_PRO,  MOV.C_COD_UNI, ' +
                                 ' CAD.D_DAT_ORC, '+
                                 ' PRO.C_COD_UNI UMORIGINAL '+
                                 ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                                 ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                 ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC  '+
                                 ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                 SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDaInicial,VpaDatFinal,true)+
                                 ' and '+SQLTextoIsNull('MOV.I_COD_TAM','0')+' = ' +IntToStr(VpaDTamanho.CodTamanho)+
                                 ' and MOV.I_COD_COR = ' +IntToStr(VpaDCorRave.CodCor)+
                                 ' and MOV.I_SEQ_PRO = '+IntToStr(VpaDProdutoRave.SeqProduto)+
                                 ' ORDER BY CAD.D_DAT_ORC');
  while not Clientes.Eof do
  begin
    VpfQtdVendida := FunProdutos.CalculaQdadePadrao(Clientes.FieldByName('C_COD_UNI').AsString,Clientes.FieldByName('UMORIGINAL').AsString,Clientes.FieldByName('N_QTD_PRO').AsFloat,IntToStr(VpaDProdutoRave.SeqProduto));
    VpfDVendaMEsCor := VpaDCorRave.RVendaMes(Mes(Clientes.FieldByName('D_DAT_ORC').AsDateTime),Ano(Clientes.FieldByName('D_DAT_ORC').AsDateTime));
    VpfDVendaMesTamanho := VpaDTamanho.RVendaMes(Mes(Clientes.FieldByName('D_DAT_ORC').AsDateTime),Ano(Clientes.FieldByName('D_DAT_ORC').AsDateTime));
    VpfDVendaMesProduto := VpaDProdutoRave.RVendaMes(Mes(Clientes.FieldByName('D_DAT_ORC').AsDateTime),Ano(Clientes.FieldByName('D_DAT_ORC').AsDateTime));
    VpfDVendaMEsCor.QtdVendida := VpfDVendaMEsCor.QtdVendida + VpfQtdVendida;
    VpfDVendaMesTamanho.QtdVendida := VpfDVendaMesTamanho.QtdVendida + VpfQtdVendida;
    VpfDVendaMesProduto.QtdVendida := VpfDVendaMesProduto.QtdVendida + VpfQtdVendida;
    Clientes.Next;
  end;
  Clientes.Close;
end;

{******************************************************************************}
procedure TRBFunRave.CarVendaMesRelatorio(VpaDVendaAno: TRBDVendaClienteAno);
var
  VpfLacoMes : Integer;
  VpfDvendaMes : TRBDVendaClienteMes;
begin
  with RVSystem.BaseReport do begin
    for VpfLacoMes := 0 to VpaDVendaAno.Meses.Count - 1 do
    begin
      VpfDVendaMes := TRBDVendaClienteMes(VpaDVendaAno.Meses.Items[VpfLacoMes]);
      if VpfDVendaMes.ValVenda <> 0 then
      begin
        if VpfDVendaMes.IndReducaoVenda then
          Italic := true;
        PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaMes.ValVenda))
      end
      else
        PrintTab('');
      Italic := false;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ConfiguraRelatorioPDF;
begin
  RpDev.DevMode.dmPaperSize := DMPAPER_A4;
  if VplArquivoPDF <> '' then
  begin
    rvSystem.DefaultDest := rdFile;
    rvSystem.DoNativeOutput := false;
    rvSystem.RenderObject := rvPDF;
    rvSystem.OutputFileName := VplArquivoPDF;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelEstoqueMinimo(VpaObjeto : TObject);
var
  VpfQtdProduto, VpfQtdMinima,VpfQtdIdeal,VpfQtdFaltante, VpfTotalProduto, VpfQtdGeral,VpfValUnitario, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual, VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
        begin
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdProduto));
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdMinima));
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdIdeal));
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdFaltante));
          PrintTab(FormatFloat('#,###,##0.00',VpfValUnitario)); //valor unitario;
          PrintTab(FormatFloat('#,###,##0.00',VpfTotalProduto));
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfQtdFaltante;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfTotalProduto;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
       VpfQtdproduto := 0;
       VpfQtdMinima := 0;
       VpfQtdIdeal := 0;
       VpfQtdFaltante := 0;
       VpfTotalProduto := 0;
       VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
       PrintTab(Tabela.FieldByName('C_COD_PRO').AsString);
       PrintTab(Tabela.FieldByName('C_NOM_PRO').AsString);
       PrintTab('  '+Tabela.FieldByname('C_COD_UNI').AsString);
       if config.EstoquePorCor then
         PrintTab('');
       if config.EstoquePorTamanho then
         PrintTab('');
      end;
      VpfQtdProduto := VpfQtdProduto + Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfQtdMinima := VpfQtdMinima + Tabela.FieldByName('N_QTD_MIN').AsFloat;
      VpfQtdIdeal := VpfQtdIdeal + Tabela.FieldByName('N_QTD_PED').AsFloat;
      VpfQtdFaltante := VpfQtdFaltante + (Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat);
      VpfTotalProduto := VpfTotalProduto + ((Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat) * Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfValUnitario := Tabela.FieldByName('N_VLR_COM').AsFloat;
      VpfQtdGeral := VpfQTdGeral +(Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat);
      VpfValGeral := VpfValGeral + ((Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat) * Tabela.FieldByName('N_VLR_COM').AsFloat);
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
    begin
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdProduto));
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdMinima));
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdIdeal));
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdFaltante));
      PrintTab(FormatFloat('#,###,##0.00',VpfValUnitario)); //valor unitario;
      PrintTab(FormatFloat('#,###,##0.00',VpfTotalProduto));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfQtdFaltante;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfTotalProduto;
    end;
    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAmostrasPorDesenvolvedor(VpaObjeto: TObject);
var
  VpfDAmostra, VpfDAmostraTotais: TRBDRAmostraDesenvolvedor;
  VpfDDia, VpfDDiaT : TRBDRAmostraDesenvolvedorDia;
  VpfLaco: Integer;
begin
  with RVSystem.BaseReport do
  begin
    VpfDAmostraTotais := TRBDRAmostraDesenvolvedor.cria;
    while not Tabela.Eof  do
    begin
      RestoreTabs(1);
      VpfDAmostra := TRBDRAmostraDesenvolvedor.cria;
      PrintTab(' ' + Tabela.FieldByName('CODDESENVOLVEDOR').AsString + '-' +Tabela.FieldByName('NOMDESENVOLVEDOR').AsString);
      CarDAmostrasDesenvolvedor(Tabela.FieldByName('CODDESENVOLVEDOR').AsInteger, VpfDAmostra, Tabela);

      for VpfLaco := 0 to VpfDAmostra.Dias.Count-1 do
      begin
        VpfDDia := TRBDRAmostraDesenvolvedorDia(VpfDAmostra.Dias.Items[VpfLaco]);
        if VpfDDia.Quantidade = 0 then
          PrintTab('')
        else
          PrintTab(IntToStr(VpfDDia.Quantidade));
        VpfDDiaT := TRBDRAmostraDesenvolvedorDia(VpfDAmostraTotais.Dias.Items[VpfLaco]);
        VpfDDiaT.Quantidade := VpfDDiaT.Quantidade + VpfDDia.Quantidade;
      end;
      PrintTab(IntToStr(VpfDAmostra.QtdTotal));
      VpfDAmostraTotais.QtdTotal := VpfDAmostraTotais.QtdTotal + VpfDAmostra.QtdTotal;

      NewLine;
      if LinesLeft<=1 Then
        NewPage;

      VpfDAmostra.Free;
    end;
    Bold := True;
    PrintTab(' Total');
    Bold := False;
    for VpfLaco := 0 to VpfDAmostraTotais.Dias.Count-1 do
    begin
      VpfDDiaT := TRBDRAmostraDesenvolvedorDia(VpfDAmostraTotais.Dias.Items[VpfLaco]);
      if VpfDDiaT.Quantidade = 0 then
        PrintTab('')
      else
        PrintTab(IntToStr(VpfDDiaT.Quantidade));
    end;
    PrintTab(IntToStr(VpfDAmostraTotais.QtdTotal));
    VpfDAmostraTotais.Free;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseContratos(VpaObjeto: TObject);
var
  VpfDContrato :  TRBDContratoLocacaoRave;
begin
  while not Tabela.Eof  do
  begin
    VpfDContrato := TRBDContratoLocacaoRave.cria;
    CarDContrato(VpfDContrato,Tabela.FieldByName('CODFILIAL').AsInteger,Tabela.FieldByName('SEQCONTRATO').AsInteger,Tabela.FieldByName('I_COD_CLI').AsInteger);
    VpfDContrato.NomCliente :=Tabela.FieldByName('C_NOM_CLI').AsString;
    if VprAnalitico  then
      ImprimeRelAnaliseContratosAnalitico(VpfDContrato,Tabela)
    else
      ImprimeRelAnaliseContratosSintetico(VpfDContrato);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseContratosAnalitico(VpaDContrato : TRBDContratoLocacaoRave;VpaTabela :  TSQLQuery);
begin
  with RVSystem.BaseReport do
  begin
      RestoreTabs(1);
      FontSize := 12;
      PrintTab(' Cliente :');
      PrintTab(VpaTabela.FieldByName('I_COD_CLI').AsString+'-'+VpaTabela.FieldByName('C_NOM_CLI').AsString);
      PrintTab(' Valor Final :');
      if VpaDContrato.ValFinalContrato > 0  then
        FontColor := clBlack
      else
        FontColor := clred;
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValFinalContrato));
      FontColor := clBlack;
      newline;
      If LinesLeft<=1 Then
        NewPage;
      FontSize := 10;
      RestoreTabs(2);
      PrintTab(' Filial :');
      PrintTab(' '+VpaTabela.FieldByName('CODFILIAL').AsString+'-'+VpaTabela.FieldByName('C_NOM_FIL').AsString);
      PrintTab(' Vendedor :');
      PrintTab(' '+VpaTabela.FieldByName('I_COD_VEN').AsString+'-'+VpaTabela.FieldByName('C_NOM_VEN').AsString);
      newline;
      If LinesLeft<=1 Then
        NewPage;
      PrintTab('Tipo Contrato :');
      PrintTab(' '+ VpaTabela.FieldByName('CODTIPOCONTRATO').AsString+'-'+VpaTabela.FieldByName('NOMTIPOCONTRATO').AsString);
      PrintTab(' Modalidade :');
      PrintTab(' '+VpaTabela.FieldByName('DESNOTACUPOM').AsString);
      newline;
      If LinesLeft<=1 Then
        NewPage;
      RestoreTabs(3);
      PrintTab('Qtd Meses :');
      PrintTab(' '+ VpaTabela.FieldByName('QTDMESES').AsString);
      PrintTab('Data Assinatura :');
      PrintTab(' '+FormatDateTime('DD/MM/YYYY',VpaTabela.FieldByName('DATASSINATURA').AsDateTime));
      PrintTab('Data Cancelamento :');
      if not VpaTabela.FieldByName('DATCANCELAMENTO').IsNull then
        PrintTab(' '+FormatDateTime('DD/MM/YYYY',VpaTabela.FieldByName('DATCANCELAMENTO').AsDateTime));
      newline;
      If LinesLeft<=1 Then
        NewPage;
      PrintTab('Seq Contrato :');
      PrintTab(' '+ VpaTabela.FieldByName('SEQCONTRATO').AsString);
      PrintTab('Nro Contrato :');
      PrintTab(' '+ VpaTabela.FieldByName('NUMCONTRATO').AsString);
      PrintTab('Valor Contrato :');
      PrintTab(FormatFloat('#,###,###,##0.00',VpaTabela.FieldByName('VALCONTRATO').AsFloat));
      newline;
      If LinesLeft<=1 Then
        NewPage;
      RestoreTabs(4);
      PrintTab('Val Exc. PB :');
      PrintTab(' '+FormatFloat('#,###,###,##0.00',VpaTabela.FieldByName('VALEXCESSOFRANQUIA').AsFloat));
      PrintTab('Qtd Franquia PB :');
      PrintTab(' '+IntToStr(VpaTabela.FieldByName('QTDFRANQUIA').AsInteger));
      PrintTab('Val Excedente Color :');
      PrintTab(' '+FormatFloat('#,###,###,##0.00',VpaTabela.FieldByName('VALEXCESSOFRANQUIACOLOR').AsFloat));
      PrintTab('Qtd Franquia Color :');
      PrintTab(' '+IntToStr(VpaTabela.FieldByName('QTDFRANQUIACOLOR').AsInteger));
      newline;
      If LinesLeft<=1 Then
        NewPage;

      ImprimeRelAnaliseContratosAnaliticoLeituras(VpaDContrato);
      ImprimeRelAnaliseContratosAnaliticoEquipamentos(VpaDContrato);
      ImprimeRelAnaliseContratosAnaliticoInsumos(VpaDContrato,VpaDContrato.InsumosContabilizados,true);
      if VpaDContrato.InsumosNaoContabilizados.Count > 0 then
        ImprimeRelAnaliseContratosAnaliticoInsumos(VpaDContrato,VpaDContrato.InsumosNaoContabilizados,false);
      ImprimeRelAnaliseContratosAnaliticoPecas(VpaDContrato);

      newline;
      newline;
      If LinesLeft<=1 Then
        NewPage;
  end;
end;

procedure TRBFunRave.ImprimeRelAnaliseContratosAnaliticoEquipamentos(VpaDContrato: TRBDContratoLocacaoRave);
Var
  VpfLaco : Integer;
  VpfDEquipamento : TRBDEquipamentoContratoLocacaoRave;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(5);
    FontSize := 14;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' Equipamentos ');
    newline;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(7);
    FontSize := 10;
    PrintTab('Equipamento');
    PrintTab('Serie');
    PrintTab('Setor');
    PrintTab('Valor Equipamento');
    newline;
    If LinesLeft<=1 Then
      NewPage;
    for Vpflaco := 0 to VpaDContrato.Equipamentos.Count - 1 do
    begin
      VpfDEquipamento :=  TRBDEquipamentoContratoLocacaoRave(VpaDContrato.Equipamentos.Items[VpfLaco]);
      PrintTab(' '+VpfDEquipamento.CodProduto+' - '+VpfDEquipamento.NomProduto);
      PrintTab(' '+VpfDEquipamento.NumSerie);
      PrintTab(' '+VpfDEquipamento.DesSetor);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDEquipamento.ValorEquipamento));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
    PrintTab('');
    PrintTab('');
    PrintTab('Total');
    PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalEquipamentos));
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseContratosAnaliticoInsumos(VpaDContrato: TRBDContratoLocacaoRave; VpaInsumos : TList; VpaContabilizados: Boolean);
Var
  VpfLaco : Integer;
  VpfDInsumo : TRBDInsumoContratoLocacaoRave;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(5);
    FontSize := 14;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    if VpaContabilizados then
      PrintTab(' Insumos Contabilizados ')
    else
      PrintTab(' Insumos NÃO Contabilizados ');
    newline;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(8);
    FontSize := 10;
    PrintTab('Produto');
    PrintTab('Quantidade');
    PrintTab('Valor Custo Total');
    PrintTab('Custo Medio Unitario');
    newline;
    If LinesLeft<=1 Then
      NewPage;
    for Vpflaco := 0 to VpaInsumos.Count - 1 do
    begin
      VpfDInsumo :=  TRBDInsumoContratoLocacaoRave(VpaInsumos.Items[VpfLaco]);
      PrintTab(' '+VpfDInsumo.CodProduto+' - '+VpfDInsumo.NomProduto);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDInsumo.QtdProduto));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDInsumo.ValCustoInsumo));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDInsumo.ValCustoInsumo / VpfDInsumo.QtdProduto));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
    PrintTab('');
    PrintTab('Total');
    if VpaContabilizados then
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalInsumosContabilizados))
    else
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalInsumosNaoContabilizados));
    PrintTab('');
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseContratosAnaliticoLeituras(VpaDContrato: TRBDContratoLocacaoRave);
Var
  VpfLaco : Integer;
  VpfDLeitura : TRBDLeiturasContratoLocacaoRave;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(5);
    FontSize := 14;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' Leituras Locação ');
    newline;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(6);
    FontSize := 10;
    PrintTab('Mes/Ano');
    PrintTab('Dt Leitura');
    PrintTab('Qtd Copias');
    PrintTab('Qtd Exc PB');
    PrintTab('Val Exc PB');
    PrintTab('Val Exc Color');
    PrintTab('Valor total');
    newline;
    If LinesLeft<=1 Then
        NewPage;
    for Vpflaco := 0 to VpaDContrato.Leituras.Count - 1 do
    begin
      VpfDLeitura :=  TRBDLeiturasContratoLocacaoRave(VpaDContrato.Leituras.Items[VpfLaco]);
      PrintTab(IntToStr(VpfDLeitura.MesLocacao)+'/'+IntToStr(VpfDLeitura.AnoLocacao));
      PrintTab(FormatDateTime('DD/MM/YYYY',VpfDLeitura.DatDigitacao));
      PrintTab(IntToStr(VpfDLeitura.QtdCopia));
      PrintTab(IntToStr(VpfDLeitura.QtdExcedente));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDLeitura.ValExcessoFranquia));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDLeitura.ValExcessoFranquiaColor));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDLeitura.ValTotalDesconto));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab('Total');
    PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalLeituras));
  end;
end;

procedure TRBFunRave.ImprimeRelAnaliseContratosAnaliticoPecas( VpaDContrato: TRBDContratoLocacaoRave);
Var
  VpfLaco : Integer;
  VpfDPeca : TRBDPecasContratoLocacaoRave;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(5);
    FontSize := 14;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' Peças ');
    newline;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(8);
    FontSize := 10;
    PrintTab('Peça');
    PrintTab('Qtd');
    PrintTab('Custo Total');
    PrintTab('Custo Medio Unitario');
    newline;
    If LinesLeft<=1 Then
      NewPage;
    for Vpflaco := 0 to VpaDContrato.Pecas.Count - 1 do
    begin
      VpfDPeca :=  TRBDPecasContratoLocacaoRave(VpaDContrato.Pecas.Items[VpfLaco]);
      PrintTab(' '+VpfDPeca.CodProduto+' - '+VpfDPeca.NomProduto);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDPeca.QtdPecas));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDPeca.ValCusto));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDPeca.ValCusto / VpfDPeca.QtdPecas));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
    PrintTab('');
    PrintTab('Total');
    PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalPecas));
    PrintTab('');
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseContratosSintetico(VpaDContrato: TRBDContratoLocacaoRave);
begin
  with RVSystem.BaseReport do
  begin
      RestoreTabs(9);
      FontSize := 10;
      PrintTab(' ' +IntToStr(VpaDContrato.CodCliente)+'-'+VpaDContrato.nomCliente);
      PrintTab(IntToStr(VpaDContrato.SeqContrato));
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalLeituras)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalEquipamentos)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalInsumosContabilizados)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalInsumosNaoContabilizados)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValTotalPecas)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',0)+' ');
      if VpaDContrato.ValFinalContrato > 0  then
        FontColor := clBlack
      else
        FontColor := clred;
      PrintTab(FormatFloat('#,###,###,##0.00',VpaDContrato.ValFinalContrato)+' ');
      FontColor := clBlack;
      newline;
      If LinesLeft<=1 Then
        NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseFaturamentoAnual(VpaObjeto : TObject);
var
  VpfVendedorAnterior : Integer;
  VpfDVenda, VpfDTotalVendedor, VpfDTotalGeral : TRBDVendaCliente;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfLacoAno,VpfLacoMes : Integer;
  VpfNomCliente : String;
begin
  VpfVendedorAnterior := 0;
  VpfDVenda := TRBDVendaCliente.cria;
  VpfDTotalVendedor := TRBDVendaCliente.cria;
  VpfDTotalGeral := TRBDVendaCliente.cria;
  InicializaVendaCliente(VprDatInicio,VprDatFim,VpfDTotalGeral);//inicializa os totais do vendedor;
  with RVSystem.BaseReport do begin
    while not Clientes.Eof  do
    begin
      if VpfVendedorAnterior <> Clientes.FieldByName('I_COD_VEN').AsInteger then
      begin
        if VpfVendedorAnterior <> 0  then
        begin
          ImprimeTotalAnalisePedidoAnual(VpfDTotalVendedor);
          VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
          NewPage;
        end;
        VpfVendedorAnterior := Clientes.FieldByName('I_COD_VEN').AsInteger;
        InicializaVendaCliente(VprDatInicio,VprDatFim,VpfDTotalVendedor);//inicializa os totais do vendedor;
      end;
      if CarValoresFaturadosCliente(Clientes.FieldByName('I_COD_CLI').AsInteger,VprFilial,VprDatInicio,VprDatFim,VpfDVenda,VpfDTotalVendedor, VpfDTotalGeral) then
      begin
        VpfNomCliente := ' '+Clientes.FieldByName('C_NOM_CLI').AsString;
        for VpfLacoAno := 0 to VpfDVenda.Anos.Count - 1 do
        begin
          NewLine;
          If LinesLeft<=1 Then
            NewPage;
          VpfDVendaAno := TRBDVendaClienteAno(VpfDVenda.Anos.Items[VpfLacoAno]);
          PrintTab(VpfNomCliente);
          PrintTab(IntToStr(VpfDVendaAno.Ano));
          for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
          begin
            VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
            if VpfDVendaMes.ValVenda <> 0 then
            begin
              if VpfDVendaMes.IndReducaoVenda then
                Italic := true;
              PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaMes.ValVenda))
            end
            else
              PrintTab('');
            Italic := false;
          end;
          if VpfDVendaAno.IndReducaoVenda  then
            bold := true;
          PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaAno.ValVenda));
          Bold := false;
          VpfNomCliente := '';
        end;
      end;
      Clientes.next;
    end;
    if VpfVendedorAnterior <> 0  then
      ImprimeTotalAnalisePedidoAnual(VpfDTotalVendedor);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    ImprimeTotalAnalisePedidoAnual(VpfDTotalGeral);
  end;
  Clientes.Close;
  VpfDVenda.free;
  VpfDTotalVendedor.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnalisePedidosClassificacao(VpaObjeto: TObject);
var
  VpfVendedorAnterior, VpfQtdClientesVendedor : Integer;
  VpfDVenda : TRBDVendaCliente;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes, VpfDTotalVendedorMes  : TRBDVendaClienteMes;
  VpfDVendaClassificacao : TRBDVendaClienteClassificacaoProduto;
  VpfLacoAno,VpfLacoMes, VpfLacoClassificacao : Integer;
  VpfNomCliente : String;
  VpfTotalMesVendedor, vpfTotalMesAno : TRBDVendaClienteAno;
begin
  VpfVendedorAnterior := 0;
  VpfQtdClientesVendedor := 0;
  VpfDVenda := TRBDVendaCliente.cria;
  with RVSystem.BaseReport do begin
    while not Clientes.Eof  do
    begin
      if VpfVendedorAnterior <> Clientes.FieldByName('I_COD_VEN').AsInteger then
      begin
        if VpfVendedorAnterior <> 0  then
        begin
          VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
          newline;
          PrintTab('Total');
          PrintTab('');
          CarVendaMesRelatorio(VpfTotalMesVendedor);
          VpfDTotalVendedorMes.Free;
          NewPage;
        end;
        VpfVendedorAnterior := Clientes.FieldByName('I_COD_VEN').AsInteger;
        VpfQtdClientesVendedor := 0;
        VpfTotalMesVendedor := TRBDVendaClienteAno.cria;
        InicializaMeses(VpfTotalMesVendedor);
      end;
      if CarValoresQtdProdutosCliente(Clientes.FieldByName('I_COD_CLI').AsInteger,VprDatInicio,VprDatFim,VpfDVenda) then
      begin
        inc(VpfQtdClientesVendedor);
        VpfNomCliente := ' '+Clientes.FieldByName('C_NOM_CLI').AsString;
        for VpfLacoAno := 0 to VpfDVenda.Anos.Count - 1 do
        begin
          NewLine;
          If LinesLeft<=1 Then
          begin
            NewPage;
            newline;
          end;
          VpfDVendaAno := TRBDVendaClienteAno(VpfDVenda.Anos.Items[VpfLacoAno]);
          RestoreTabs(2);
          Bold := true;
          if not VprMostraClassificacao  then
            bold := false;
          PrintTab(VpfNomCliente);
          PrintTab(IntToStr(VpfDVendaAno.Ano));
          CarVendaMesRelatorio(VpfDVendaAno);

          for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
          begin
            VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
            VpfDTotalVendedorMes := RMesTotal(VpfTotalMesVendedor,VpfDVendaMes.Mes);
            VpfDTotalVendedorMes.ValVenda := VpfDTotalVendedorMes.ValVenda + VpfDVendaMes.ValVenda;
          end;
          if VpfDVendaAno.IndReducaoVenda  then
            bold := true;
          PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaAno.ValVenda));
          Bold := false;

          if VprMostraClassificacao then
          begin
            for VpfLacoClassificacao := 0 to VpfDVendaAno.ClassificacoesProduto.Count - 1 do
            begin
              NewLine;
              If LinesLeft<=1 Then
              begin
                NewPage;
                NewLine;
              end;
              RestoreTabs(3);
              VpfDVendaClassificacao := TRBDVendaClienteClassificacaoProduto(VpfDVendaAno.ClassificacoesProduto.Items[VpfLacoClassificacao]);
              PrintTab(VpfDVendaClassificacao.NomClassificacao);
              PrintTab('');
              for VpfLacoMes := 0 to VpfDVendaClassificacao.Meses.Count - 1 do
              begin
                VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaClassificacao.Meses.Items[VpfLacoMes]);
                if VpfDVendaMes.ValVenda <> 0 then
                begin
                  if VpfDVendaMes.IndReducaoVenda then
                    Italic := true;
                  PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaMes.ValVenda))
                end
                else
                  PrintTab('');
                Italic := false;
              end;
              PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaClassificacao.ValTotal));
            end;
          end;

          VpfNomCliente := '';
        end;
      end;
      Clientes.next;
    end;

    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
  Clientes.Close;
  VpfDVenda.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnalisePedidosRepresentadaAnual(VpaObjeto: TObject);
var
  VpfVendedorAnterior : Integer;
  VpfDVenda : TRBDVendaCliente;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfDVendaRepresentada : TRBDVendaClienteRepresentada;
  VpfLacoRepresentada, VpfLacoAno,VpfLacoMes : Integer;
  VpfNomCliente, VpfNomRepresentada : String;
begin
  VpfVendedorAnterior := 0;
  VpfDVenda := TRBDVendaCliente.cria;
  with RVSystem.BaseReport do begin
    while not Clientes.Eof  do
    begin
      if VpfVendedorAnterior <> Clientes.FieldByName('I_COD_VEN').AsInteger then
      begin
        if VpfVendedorAnterior <> 0  then
        begin
          VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
          NewPage;
        end;
        VpfVendedorAnterior := Clientes.FieldByName('I_COD_VEN').AsInteger;
      end;
      if CarValoresPedidosRepresentadaCliente(Clientes.FieldByName('I_COD_CLI').AsInteger,VprDatInicio,VprDatFim,VpfDVenda) then
      begin
            NewLine;
            If LinesLeft<=1 Then
              NewPage;
        VpfNomCliente := ' '+Clientes.FieldByName('C_NOM_CLI').AsString;
        PrintTab(VpfNomCliente);
        for VpfLacoRepresentada := 0 to VpfDVenda.Representadas.Count - 1 do
        begin
          VpfDVendaRepresentada := TRBDVendaClienteRepresentada(VpfDVenda.Representadas.Items[VpfLacoRepresentada]);
          VpfNomRepresentada :=  AdicionaCharE(' ',VpfDVendaRepresentada.NomRepresentada,15);
          if VpfDVendaRepresentada.ValVenda > 0 then
          begin
            for VpfLacoAno := 0 to VpfDVendaRepresentada.Anos.Count - 1 do
            begin
              VpfDVendaAno := TRBDVendaClienteAno(VpfDVendaRepresentada.Anos.Items[VpfLacoAno]);

              NewLine;
              If LinesLeft<=1 Then
                NewPage;
              PrintTab(VpfNomRepresentada);
              PrintTab(IntToStr(VpfDVendaAno.Ano));
              for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
              begin
                VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
                if VpfDVendaMes.ValVenda <> 0 then
                begin
                  if VpfDVendaMes.IndReducaoVenda then
                    Italic := true;
                  PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaMes.ValVenda))
                end
                else
                  PrintTab('');
                Italic := false;
              end;
              if VpfDVendaAno.IndReducaoVenda  then
                bold := true;
              PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaAno.ValVenda));
              Bold := false;
              VpfNomRepresentada := '';
            end;
          end;
        end;
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
      end;
      Clientes.next;
    end;

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    bold := true;
    PrintTab('');
    PrintTab('');
    PrintTab('  ');
    bold := false;
  end;
  Clientes.Close;
  VpfDVenda.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseRenovacaoContrato(VpaObjeto: TObject);
Var
  VpfDatInicioNovoContrato, VpfDatFimNovoContrato, VpfDatAssinatura : TDateTime;
  VpfValContrato, vpfTotalContratos, VpfTotalNovosContratos : Double;
  VpfClienteAtual, VpfCodVendedorAtual : Integer;
  VpfTotalVendedores : TList;
  VpfDTotalvendedor : TRBDTotalVendedorRave;
begin
  VpfTotalVendedores := TList.Create;
  vpfTotalContratos :=0;
  VpfClienteAtual := -1;
  VpfCodVendedorAtual := -1;
  VpfTotalNovosContratos :=0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      if VpfCodVendedorAtual <> Tabela.FieldByName('I_COD_VEN').AsInteger then
      begin
        VpfDTotalvendedor := TRBDTotalVendedorRave.cria;
        VpfTotalVendedores.Add(VpfDTotalvendedor);
        VpfDTotalvendedor.CodVendedor := Tabela.FieldByName('I_COD_VEN').AsInteger;
        VpfDTotalvendedor.NomVendedor := Tabela.FieldByName('C_NOM_VEN').AsString;
        VpfCodVendedorAtual := Tabela.FieldByName('I_COD_VEN').AsInteger
      end;

      PrintTab(Tabela.FieldByName('CODFILIAL').AsString+' ');
      PrintTab(Tabela.FieldByName('SEQCONTRATO').AsString+' ');
      PrintTab(Tabela.FieldByName('I_COD_CLI').AsString+' ');
      PrintTab(' '+Tabela.FieldByName('C_NOM_CLI').AsString);
      PrintTab(' '+Tabela.FieldByName('C_EST_CLI').AsString);
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATINICIOVIGENCIA').AsDateTime));
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATFIMVIGENCIA').AsDateTime));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALCONTRATO').AsFloat));
      if VpfClienteAtual <> Tabela.FieldByName('I_COD_CLI').AsInteger then
      begin
        CarRenovacaoContrato(Tabela.FieldByName('I_COD_CLI').AsInteger,Tabela.FieldByName('DATFIMVIGENCIA').AsDateTime,VpfDatAssinatura,VpfDatInicioNovoContrato,VpfDatFimNovoContrato,VpfValContrato);
        VpfTotalNovosContratos := VpfTotalNovosContratos + VpfValContrato;
        VpfDTotalvendedor.ValRenovado := VpfDTotalvendedor.ValRenovado + VpfValContrato;
        VpfClienteAtual := Tabela.FieldByName('I_COD_CLI').AsInteger;
      end
      else
        VpfValContrato := 0;

      PrintTab(FormatFloat('#,###,###,##0.00',VpfValContrato));
      if VpfDatInicioNovoContrato > MontaData(1,1,1900) then
      begin
        PrintTab(FormatDateTime('DD/MM/YY',VpfDatAssinatura));
        PrintTab(FormatDateTime('DD/MM/YY',VpfDatInicioNovoContrato));
        PrintTab(FormatDateTime('DD/MM/YY',VpfDatFimNovoContrato));
      end
      else
      begin
        PrintTab('');
        PrintTab('');
        PrintTab('');
      end;
      PrintTab(Tabela.FieldByName('I_COD_VEN').AsString +' - ' +Tabela.FieldByName('C_NOM_VEN').AsString);


      vpfTotalContratos := vpfTotalContratos + Tabela.FieldByName('VALCONTRATO').AsFloat;
      VpfDTotalvendedor.ValContratos := VpfDTotalvendedor.ValContratos + Tabela.FieldByName('VALCONTRATO').AsFloat;

      newline;
      If LinesLeft<=1 Then
        NewPage;
      Tabela.Next;
    end;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' ');
    PrintTab(' ');
    PrintTab(' ');
    PrintTab(' TOTAL');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab(FormatFloat('#,###,###,##0.00',vpfTotalContratos));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalNovosContratos));
    newline;
  end;
  ImprimeTotalAnaliseRenovacaoContratoTotalVendedor(VpfTotalVendedores);
  FreeTObjectsList(VpfTotalVendedores);
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelFechamentoEstoque(VpaObjeto : TObject);
Var
  VpfClassificacaoAtual : String;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfQtdVendaMes, VpfValVendaMes, VpfQtdGeralAnterior,VpfQtdGeralVenda, VpfQtdGeralProduto,VpfValGeralAnterior,
  VpfValGeralVenda, VpfValGeralProduto, VpfValGeralCustoVenda : Double;
begin
  VpfClassificacaoAtual := '';
  VpfQtdGeralAnterior := 0;
  VpfQtdGeralVenda := 0;
  VpfQtdGeralProduto := 0;
  VpfValGeralAnterior := 0;
  VpfValGeralVenda := 0;
  VpfValGeralProduto := 0;
  VpfValGeralCustoVenda := 0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      VpfQtdVendaMes := Tabela.FieldByName('N_QTD_VEN_MES').AsFloat - Tabela.FieldByName('N_QTD_DEV_VEN').AsFloat;
      VpfValVendaMes := Tabela.FieldByName('N_VLR_VEN_MES').AsFloat - Tabela.FieldByName('N_VLR_DEV_VEN').AsFloat;
      if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
      begin
        VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
        ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
        VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
      end;
      if (VprTodosProdutos) or (VpfQtdVendaMes <> 0)  then
      begin
        VpfDClassificacao.ValCustoVenda := VpfDClassificacao.ValCustoVenda + Tabela.FieldByName('N_VLR_CMV').AsFloat;
        VpfValGeralCustoVenda := VpfValGeralCustoVenda + Tabela.FieldByName('N_VLR_CMV').AsFloat;
        PrintTab(Tabela.FieldByName('C_COD_PRO').AsString);
        PrintTab(Tabela.FieldByName('C_NOM_PRO').AsString);
        PrintTab(FormatFloat('#,###,###,##0.00',VpfQtdVendaMes));
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValVendaMes));
        PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_CMV').AsFloat));
        if Tabela.FieldByName('N_VLR_CMV').AsFloat <> 0  then
          PrintTab(FormatFloat('#,##0.00%',((((Tabela.FieldByName('N_VLR_VEN_MES').AsFloat - Tabela.FieldByName('N_VLR_DEV_VEN').AsFloat)/Tabela.FieldByName('N_VLR_CMV').AsFloat)-1)*100)))
        else
          PrintTab(FormatFloat('0.00%',0));
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
      end;
      VpfDClassificacao.QtdMesAnterior := VpfDClassificacao.QtdMesAnterior + Tabela.FieldByName('N_QTD_ANT').AsFloat;
      VpfDClassificacao.ValAnterior := VpfDClassificacao.ValAnterior +(Tabela.FieldByName('N_QTD_ANT').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfDClassificacao.QtdVenda := VpfDClassificacao.QtdVenda + VpfQtdVendaMes;
      VpfDClassificacao.ValVenda := VpfDClassificacao.ValVenda + VpfValVendaMes;
      VpfDClassificacao.QTdProduto := VpfDClassificacao.QTdProduto + Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal +(Tabela.FieldByName('N_QTD_PRO').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfQtdGeralAnterior := VpfQtdGeralAnterior + Tabela.FieldByName('N_QTD_ANT').AsFloat;
      VpfQtdGeralVenda := VpfQtdGeralVenda + VpfQtdVendaMes;
      VpfQtdGeralProduto := VpfQtdGeralProduto + Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfValGeralAnterior := VpfValGeralAnterior+(Tabela.FieldByName('N_QTD_ANT').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfValGeralVenda := VpfValGeralVenda + VpfValVendaMes;
      VpfValGeralProduto := VpfValGeralProduto + (Tabela.FieldByName('N_QTD_PRO').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      Tabela.next;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfQtdGeralVenda));
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValGeralVenda));
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValGeralCustoVenda));
    if VpfValGeralVenda <> 0  then
      PrintTab(FormatFloat('#,##0.00%',(100 - ((VpfValGeralCustoVenda*100)/VpfValGeralVenda))))
    else
      PrintTab(FormatFloat('0.00%',0));
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelFluxoCaixaDiario(VpaObjeto: TObject);
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
begin
  for VpfLacoContas := 0 to VprDFluxo.ContasCaixa.Count - 1 do
  begin
    with RVSystem.BaseReport do
    begin
      VpfDContaFluxo := TRBDFluxoCaixaConta(VprDFluxo.ContasCaixa.Items[VpfLacoContas]);
      ImprimeFluxoCaixaDiarioDias(VpfDContaFluxo,1,8);
      newpage;
      ImprimeFluxoCaixaDiarioDias(VpfDContaFluxo,9,19);
      newpage;
      ImprimeFluxoCaixaDiarioDias(VpfDContaFluxo,20,30);
      newpage;
      ImprimeFluxoCaixaDiarioDias(VpfDContaFluxo,31,31);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelLivroRegistroSaidas(VpaObjeto: TObject);
var
  VpfValContabil, VpfValBaseCalculo, VpfValICMS, VpfValOutras : Double;
  VpfTotContabil, VpfTotBaseCalculo, VpfTotICMS, VpfTotOutras :double;
  VpfListaTotalCFOP, VpfListaTotalUF : TList;
  VpfDTotalCFOP : TRBDLivroSaidasTotalCFOPRave;
  VpfDTotalUF : TRBDLivroSaidasTotalUFRave;
begin
  VpfListaTotalCFOP := TList.Create;
  VpfListaTotalUF := TList.Create;
  VpfTotContabil := 0;
  VpfTotBaseCalculo := 0;
  VpfTotICMS := 0;
  VpfTotOutras := 0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
      begin
        VpfValContabil := 0;
        VpfValBaseCalculo := 0;
        VpfValICMS := 0;
        VpfValOutras := 0;
      end
      else
      begin
        VpfValContabil := Tabela.FieldByName('N_TOT_NOT').AsFloat;
        VpfValBaseCalculo := Tabela.FieldByName('N_BAS_CAL').AsFloat;
        VpfValICMS := Tabela.FieldByName('N_VLR_ICM').AsFloat;
        VpfValOutras := Tabela.FieldByName('N_TOT_NOT').AsFloat - Tabela.FieldByName('N_BAS_CAL').AsFloat;
      end;
      PrintTab(''); //Especie documento
      PrintTab(' ' +Tabela.FieldByName('C_SER_NOT').AsString);//SERIE
      PrintTab(Tabela.FieldByName('I_NRO_NOT').AsString+' ' );   //NUMERO
      PrintTab(' '+IntToStr(Dia(Tabela.FieldByName('D_DAT_EMI').AsDateTime)));//DIA
      PrintTab(' '+TABELA.FieldByName('C_EST_CLI').AsString);//uf
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValContabil)+' ');
      PrintTab('');
      PrintTab(' '+TABELA.FieldByName('C_COD_NAT').AsString);//CFOP
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValBaseCalculo)+' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValICMS)+' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValOutras)+' ');
      if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
        PrintTab('CANCELADA')
      else
        PrintTab('');
      newline;
      If LinesLeft<=1 Then
        NewPage;
      VpfTotContabil := VpfTotContabil + VpfValContabil;
      VpfTotBaseCalculo := VpfTotBaseCalculo +VpfValBaseCalculo;
      VpfTotICMS := VpfTotICMS + VpfValICMS;
      VpfTotOutras := VpfTotOutras + VpfValOutras;

      //totais da cfop
      VpfDTotalCFOP := RTotalCFOP(VpfListaTotalCFOP,Tabela.FieldByName('C_COD_NAT').AsString);
      VpfDTotalCFOP.ValContabil := VpfDTotalCFOP.ValContabil + VpfValContabil;
      VpfDTotalCFOP.ValBaseICMS := VpfDTotalCFOP.ValBaseICMS + VpfValBaseCalculo;
      VpfDTotalCFOP.ValImposto := VpfDTotalCFOP.ValImposto + VpfValICMS;
      VpfDTotalCFOP.ValOutras := VpfDTotalCFOP.ValOutras + VpfValOutras;

      //totais da UF
      VpfDTotalUF := RTotalUFLivroSaida(VpfListaTotalUF,Tabela.FieldByName('C_EST_CLI').AsString);
      VpfDTotalUF.ValContabil := VpfDTotalUF.ValContabil + VpfValContabil;
      VpfDTotalUF.ValBaseICMS := VpfDTotalUF.ValBaseICMS + VpfValBaseCalculo;
      VpfDTotalUF.ValImposto := VpfDTotalUF.ValImposto + VpfValICMS;
      VpfDTotalUF.ValOutras := VpfDTotalUF.ValOutras + VpfValOutras;

      Tabela.next;
    end;
    Bold := true;
    PrintTab(''); //Especie documento
    PrintTab(' ');//SERIE
    PrintTab('TOTAIS ' );   //NUMERO
    PrintTab(' ');//DIA
    PrintTab(' ');//uf
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfTotContabil)+' ');
    PrintTab('');
    PrintTab(' ');//CFOP
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfTotBaseCalculo)+' ');
    PrintTab('');
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfTotICMS)+' ');
    PrintTab('');
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfTotOutras)+' ');
    PrintTab('');
    Bold := false;
  end;

  ImprimeTotalCFOPLivroSaida(VpfListaTotalCFOP);
  ImprimeTotalUFLivroSaida(VpfListaTotalUF);

  FreeTObjectsList(VpfListaTotalCFOP);
  VpfListaTotalCFOP.Free;
  FreeTObjectsList(VpfListaTotalUF);
  VpfListaTotalUF.Free;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelOPEtikArt(VpaObjeto: TObject);
Var
  VpfDProduto : TRBDProduto;
  VpfPosicaoFinalLinha : Double;
  VpfObservacoes : TStringList;
  VpfLaco : Integer;
begin
  VpfDProduto := TRBDProduto.Cria;
  FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VprDOPEtikArt.CodEmpresafilial,VprDOPEtikArt.SeqProduto);
  FunProdutos.CarDCombinacao(VpfDProduto);

  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    PrintTab('Número OP :');
    PrintTab(' '+ intToStr(VprDOPEtikArt.SeqOrdem));
    PrintTab('Pedido :');
    PrintTab(' '+intToStr(VprDOPEtikArt.NumPedido));
    newline;
    PrintTab('OP Cliente :');
    PrintTab(' '+intToStr(VprDOPEtikArt.NroOPCliente));
    PrintTab('Entrega :');
    PrintTab(' '+FormatDateTime('DD/MM/YYYY',VprDOPEtikArt.DatEntregaPrevista));
    newline;
    PrintTab('Data :');
    PrintTab(' '+FormatDateTime('DD/MM/YYYY',VprDOPEtikArt.DatEmissao));
    PrintTab('Programad :');
    PrintTab(' '+Sistema.RNomUsuario(VprDOPEtikArt.CodProgramador));
    newline;
    PrintTab('Faturar :');
    if VprDOPEtikArt.TipPedido in [0,3] then
      PrintTab(' N')
    else
      PrintTab(' S');
    newline;
    PrintTab('Tear :');
    PrintTab(' '+IntToStr(VprDOPEtikArt.CodMaquina) +' - ' +FunOrdemProducao.RNomeMaquina(IntToStr(VprDOPEtikArt.CodMaquina)));
    PrintTab('Fitas :');
    PrintTab(' '+intTostr(VprDOPEtikArt.QtdFita));
    newline;
    PrintTab('Mts Total :');
    PrintTab(' '+FloattoStr(VprDOPEtikArt.TotMetros));
    PrintTab('Acréscimo :');
    PrintTab(' '+IntToStr(VprDOPEtikArt.PerAcrescimo)+'%');
    newline;
    RestoreTabs(2);
    PrintTab('Mts Fita :');
    PrintTab(' '+FloattoStr(VprDOPEtikArt.MetFita));
    PrintTab('Súmula :');
    if VprDOPEtikArt.TipPedido = 0 then
      PrintTab(' A'+IntToStr(VpfDProduto.CodSumula))
    else
      if VprDOPEtikArt.TipPedido = 1 then
        PrintTab(' V'+IntToStr(VpfDProduto.CodSumula))
      else
        PrintTab(' '+IntToStr(VpfDProduto.CodSumula));
    PrintTab('UM Pedido :');
    PrintTab(' '+VprDOPEtikArt.UMPedido);
    SetPen(clBlack,psDashDot,2,pmCopy);
    moveto(0.5,YPos+0.1);
    lineto(10.2,YPos+0.1);
    newline;
    RestoreTabs(3);
    PrintTab('Produto :');
    PrintTab(' '+VprDOPEtikArt.CodProduto+' - '+VpfDProduto.NomProduto);
    newline;
    RestoreTabs(2);
    PrintTab('Largura :');
    PrintTab(' '+IntToStr(VpfDProduto.LarProduto));
    PrintTab('Comp. :');
    PrintTab(' '+IntToStr(VpfDProduto.CmpProduto));
    PrintTab('Comp. Fig :');
    PrintTab(' '+IntToStr(VpfDProduto.CmpFigura));
    newline;
    RestoreTabs(1);
    PrintTab('Tipo Fundo :');
    if VpfDProduto.CodTipoFundo <> 0 then
      PrintTab(' '+IntToStr(VpfDProduto.CodTipoFundo) +' - ' + FunProdutos.RNomeFundo(IntToStr(VpfDProduto.CodTipoFundo)))
    else
      PrintTab(' ');
    PrintTab('Calandragem:');
    PrintTab(' '+VpfDProduto.IndCalandragem);
    newline;
    PrintTab('Tp Emenda :');
    if VpfDProduto.CodTipoEmenda <> 0 then
      PrintTab(' '+IntToStr(VpfDProduto.CodTipoEmenda) + ' - '+ FunProdutos.RNomeTipoEmenda(IntToStr(VpfDProduto.CodTipoEmenda)))
    else
      PrintTab(' ');
    PrintTab('Engomagem:');
    PrintTab(' '+VpfDProduto.IndEngomagem);
    newline;
    RestoreTabs(2);
    PrintTab('Pente :');
    PrintTab(' '+VpfDProduto.Pente);
    PrintTab('Bat P :');
    PrintTab(' '+VpfDProduto.BatProduto);
    PrintTab('Bat Tear :');
    PrintTab(' '+VpfDProduto.NumBatidasTear);
    newline;
    RestoreTabs(1);
    PrintTab('Tipo Corte :');
    if VprDOPEtikArt.CodTipoCorte <> 0 then
      PrintTab(' '+IntToStr(VprDOPEtikArt.CodTipoCorte)+ ' - '+FunProdutos.RNomeTipoCorte(VprDOPEtikArt.CodTipoCorte))
    else
      PrintTab(' ');
    PrintTab('Prod Novo:');
    PrintTab(' '+VprDOPEtikArt.IndProdutoNovo);
    SetPen(clBlack,psSolid,2,pmCopy);
    moveto(0.5,YPos+0.1);
    lineto(10.2,YPos+0.1);
    newline;
    RestoreTabs(4);
    PrintTab('NR Fios ' + VpfDProduto.NumFios);
    moveto(0.5,YPos+0.1);
    lineto(10.2,YPos+0.1);
    newline;

    if YPos > 14 then
      VpfPosicaoFinalLinha := PageHeight - 1
    else
      VpfPosicaoFinalLinha := 14;
    if VprDOPEtikArt.TipTear = 0 then
    begin
      CarCombinacoesOPConvencional(VprDOPEtikArt,VpfDProduto);
      CarManequinsOPConvencional(VprDOPEtikArt,VpfDProduto);
      FontSize := 14;
      if YPos > 14 then
        VpfPosicaoFinalLinha := PageHeight - 1
      else
        VpfPosicaoFinalLinha := 14;
      PrintXY(2,VpfPosicaoFinalLinha-0.9,FloattoStr(VprDOPEtikArt.MetFita) + ' MTS');


      FontSize := 10;
    end
    else
    begin
      CarCombinacoesOPH(VprDOPEtikArt,VpfDProduto);
      CarManequinsOPConvencional(VprDOPEtikArt,VpfDProduto);
    end;

    SetPen(clBlack,psSolid,3,pmCopy);
    //quadrado grando do lado esquerdo
    moveto(0.5,0.5);
    lineto(10.2,0.5);
    moveto(0.5,0.5);
    lineto(0.5,VpfPosicaoFinalLinha-0.4);
    moveto(10.2,0.5);
    lineto(10.2,VpfPosicaoFinalLinha-0.4);
    moveto(0.5,VpfPosicaoFinalLinha-0.4);
    lineto(10.2,VpfPosicaoFinalLinha-0.4);
    //quadrado grando do lado direito
    moveto(10.5,0.5);
    lineto(21,0.5);
    moveto(10.5,0.5);
    lineto(10.5,VpfPosicaoFinalLinha-0.4);
    moveto(21,0.5);
    lineto(21,VpfPosicaoFinalLinha-0.4);
    moveto(10.5,VpfPosicaoFinalLinha-0.4);
    lineto(21,VpfPosicaoFinalLinha-0.4);
    //Linhas internas do quadrado
    moveto(10.5,1.5);
    lineto(21,1.5);
    PrintXY(10.7,0.9,'Horas Produção :');
    PrintXY(13.7,0.9,VprDOPEtikArt.HorProducao);
    PrintXY(15.5,0.9,'Preço Unitário :');
    PrintXY(19,0.9,FormatFloat('R$ ###,###,##0.00',VprDOPEtikArt.ValUnitario));
    PrintXY(10.7,1.3,'Data Prevista Termino :');
    PrintXY(17,1.3,'Unid :');
    PrintXY(10.7,1.9,'ANOT');
    PrintXY(12.7,1.9,'INICIO');
    PrintXY(15,1.9,'FIM');
    PrintXY(18.5,1.9,'C.Q.');
    moveto(10.5,2.0);
    lineto(21,2.0);
    PrintXY(10.7,3.1,'Data');
    moveto(10.5,3.15);
    lineto(16.5,3.15);
    moveto(11.8,1.5);
    lineto(11.8,7);
    moveto(14.3,1.5);
    lineto(14.3,7);
    moveto(16.5,1.5);
    lineto(16.5,7);
    PrintXY(10.7,3.7,'Horas');
    moveto(10.5,3.75);
    lineto(16.5,3.75);
    PrintXY(10.7,4.2,'Rel. A');
    moveto(10.5,4.25);
    lineto(16.5,4.25);
    PrintXY(10.7,4.7,'Rel. B');
    moveto(10.5,4.75);
    lineto(16.5,4.75);
    PrintXY(10.7,5.3,'Rel. C');
    moveto(10.5,5.35);
    lineto(16.5,5.35);
    PrintXY(10.7,5.8,'Rel. D');
    moveto(10.5,5.85);
    lineto(16.5,5.85);
    PrintXY(10.7,6.4,'Engre');
    PrintXY(12.7,6.3,VpfDProduto.Engrenagem);
    moveto(10.5,7);
    lineto(21,7);

    PrintXY(18,3.7,'Aprovação');
    PrintXY(17.5,4.5,'____/____/____');

    PrintXY(18,5.5,'____:____hrs');
    PrintXY(16.7,6.5,'Ass :');
    moveto(10.5,7);
    lineto(21,7);
    PrintXY(10.7,7.4,'Data');
    PrintXY(12.5,7.4,'Relogio');
    PrintXY(14.5,7.4,'P. Tr');
    moveto(10.5,7.45);
    lineto(21,7.45);
    PrintXY(14.5,7.9,'Nome');
    moveto(10.5,7.95);
    lineto(21,7.95);
    PrintXY(14.5,8.5,'Batida');
    moveto(10.5,8.55);
    lineto(21,8.55);
    PrintXY(14.5,9.1,'Comp');
    moveto(10.5,9.15);
    lineto(21,9.15);
    PrintXY(14.5,9.7,'Oper');
    moveto(10.5,9.75);
    lineto(21,9.75);
    PrintXY(14.5,10.3,'Disk');
    moveto(10.5,10.35);
    lineto(21,10.35);
    PrintXY(14.5,10.9,'Obs');
    VpfObservacoes := DivideString(VprDOPEtikArt.DesObservacoes,30);
    for vpflaco:= 0 to VpfObservacoes.Count - 1 do
      PrintXY(15.6,10.9+(0.5 *VpfLaco),VpfObservacoes.Strings[VpfLaco]);

    PrintXY(12.1,13.9,'Prateleira');
    PrintXY(14.4,13.9,VpfDProduto.PraProduto);
    moveto(12,7);
    lineto(12,14);
    moveto(14.3,7);
    lineto(14.3,14);
    moveto(15.5,7);
    lineto(15.5,14);
    if VprDOPEtikArt.TipPedido = 4 then
      PrintXY(6,VpfPosicaoFinalLinha-0.5,'PEDIDO DE ESTOQUE - NÃO PRODUZIR')
    else
      if VprDOPEtikArt.TipPedido > 1 then
        PrintXY(6,VpfPosicaoFinalLinha-0.5,'Reprogramação');
    With TRPBars2of5.Create(RVSystem.BaseReport) do
    Begin
     BarHeight  := 1;
     BarWidth   := 0.05;
     WideFactor := BarWidth;
     Text := '*'+IntToStr(VprDOPEtikArt.SeqOrdem)+'*';
     PrintXY(4.3,0.7);
     Free;
   end;

    if VprDOPEtikArt.TipTear = 1 then
      CarMetrosCombinacaoOPH(VprDOPEtikArt,VpfDProduto);
  end;
  VpfDProduto.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelPagamentoFaccionista(VpaObjeto: TObject);
var
  VpfCodFaccionista : Integer;
  VpfNomTerceiro : String;
  VpfQtdRevisadoFaccionista, vpfQtdDefeitoFaccionista, VpfValTotalFaccionista, VpfQtdRevisadoTerceiro, vpfQtdDefeitoTerceiro,
  VpfValTotalTerceiro, VpfQtdTotalRevisado, vpfQtdTotalDefeito, VpfValTotal : Double;
begin
  VpfCodFaccionista := -1;
  VpfNomTerceiro := '';
  VpfQtdTotalRevisado := 0;
  vpfQtdTotalDefeito := 0;
  VpfValTotal := 0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      if (VpfCodFaccionista <> Tabela.FieldByName('CODFACCIONISTA').AsInteger) then
      begin
        if VpfCodFaccionista <> -1 then
        begin
          if VpfQtdRevisadoTerceiro <> 0 then
          begin
            bold := true;
            PrintTab('');
            PrintTab('');
            PrintTab('Total Terceiro');
            PrintTab(FormatFloat('#,###,##0',VpfQtdRevisadoTerceiro)+' ');
            PrintTab(FormatFloat('#,###,##0',vpfQtdDefeitoTerceiro)+' ');
            PrintTab(' ');
            PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotalTerceiro)+' ');
            Bold := false;
            newline;
            If LinesLeft<=1 Then
              NewPage;
          end;

          bold := true;
          SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
          FillRect(CreateRect(MarginLeft+17,YPos-0.3,PageWidth-0.3,YPos+0.1));
          if varia.ModeloRelatorioFaccionista = mrModelo1Kairos then
          begin
            PrintTab('');
            PrintTab('');
            PrintTab('');
            PrintTab(FormatFloat('#,###,##0',VpfQtdRevisadoFaccionista)+' ');
            PrintTab(FormatFloat('#,###,##0',vpfQtdDefeitoFaccionista)+' ');
            PrintTab(' ');
            PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotalFaccionista)+' ');
          end
          else
            if Varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
            begin
              PrintTab('');
              PrintTab('');
              PrintTab('');
              PrintTab('');
              PrintTab(FormatFloat('#,###,##0',VpfQtdRevisadoFaccionista)+' ');
              PrintTab(' ');
              PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotalFaccionista)+' ');
            end;

          Bold := false;
          newline;
          newline;
          If LinesLeft<=1 Then
            NewPage;

          if Varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
          begin
            newline;
            newline;
            If LinesLeft<=1 Then
              NewPage;
            RestoreTabs(1);
            PrintTab('Recebido em : ___/___/_______                     __________________________________');
            NewPage;

          end
          else
          begin
            RestoreTabs(1);
            SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
            FillRect(CreateRect(MarginLeft-0.1,YPos-0.4,PageWidth-0.3,YPos+0.1));

            bold := true;
            PrintTab(Tabela.FieldByName('NOMFACCIONISTA').AsString);
            Bold := false;
            newline;
            If LinesLeft<=1 Then
              NewPage;
          end;
        end;
        VpfQtdRevisadoFaccionista := 0;
        vpfQtdDefeitoFaccionista := 0;
        VpfQtdRevisadoTerceiro := 0;
        vpfQtdDefeitoTerceiro := 0;
        VpfValTotalFaccionista := 0;
        VpfValTotalTerceiro := 0;
        VpfCodFaccionista := Tabela.FieldByName('CODFACCIONISTA').AsInteger;
      end;
      if (VpfNomTerceiro <> Tabela.FieldByName('NOMTERCEIRO').AsString) then
      begin
        if VpfNomTerceiro <> '' then
        begin
          bold := true;
          PrintTab('');
          PrintTab('');
          PrintTab('Total Terceiro');
          PrintTab(FormatFloat('#,###,##0',VpfQtdRevisadoTerceiro)+' ');
          PrintTab(FormatFloat('#,###,##0',vpfQtdDefeitoTerceiro)+' ');
          PrintTab(' ');
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotalTerceiro)+' ');
          Bold := false;
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        RestoreTabs(1);
        bold := true;
        PrintTab('    '+Tabela.FieldByName('NOMTERCEIRO').AsString);
        Bold := false;
        newline;
        If LinesLeft<=1 Then
          NewPage;
        VpfNomTerceiro := Tabela.FieldByName('NOMTERCEIRO').AsString;
        VpfQtdRevisadoTerceiro := 0;
        vpfQtdDefeitoTerceiro := 0;
        VpfValTotalTerceiro := 0;
      end;

      RestoreTabs(2);
      if Varia.ModeloRelatorioFaccionista = mrModelo1Kairos then
      begin
        PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATREAL').AsDateTime));
        if Tabela.FieldByName('DATREVISADO').AsDateTime  > MontaData(1,1,1900) then
          PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATREVISADO').AsDateTime))
        else
          PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATREVISADO').AsDateTime));
        PrintTab('  ' +Tabela.FieldByName('C_COD_PRO').AsString+' - ' + Tabela.FieldByName('C_NOM_PRO').AsString);
        if Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat <> 0 then
        begin
          VpfQtdTotalRevisado := VpfQtdTotalRevisado + Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat;
          vpfQtdTotalDefeito := vpfQtdTotalDefeito + Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat;
          VpfValTotal := VpfValTotal + ((Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat - Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
          VpfQtdRevisadoTerceiro := VpfQtdRevisadoTerceiro + Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat;
          vpfQtdDefeitoTerceiro := vpfQtdDefeitoTerceiro +  Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat;
          VpfValTotalTerceiro := VpfValTotalTerceiro + ((Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat - Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
          PrintTab(Tabela.FieldByName('QTDREVISADOTERCEIRO').AsString+' ');
          PrintTab(Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsString+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',(Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat - Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
        end
        else
        begin
          VpfQtdTotalRevisado := VpfQtdTotalRevisado + Tabela.FieldByName('QTDREVISADO').AsFloat;
          vpfQtdTotalDefeito := vpfQtdTotalDefeito + Tabela.FieldByName('QTDDEFEITO').AsFloat;
          VpfValTotal := VpfValTotal + ((Tabela.FieldByName('QTDREVISADO').AsFloat - Tabela.FieldByName('QTDDEFEITO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
          VpfQtdRevisadoFaccionista := VpfQtdRevisadoFaccionista + Tabela.FieldByName('QTDREVISADO').AsFloat;
          vpfQtdDefeitoFaccionista := vpfQtdDefeitoFaccionista + Tabela.FieldByName('QTDDEFEITO').AsFloat;
          VpfValTotalFaccionista := VpfValTotalFaccionista + ((Tabela.FieldByName('QTDREVISADO').AsFloat - Tabela.FieldByName('QTDDEFEITO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
          PrintTab(Tabela.FieldByName('QTDREVISADO').AsString+' ');
          PrintTab(Tabela.FieldByName('QTDDEFEITO').AsString+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',(Tabela.FieldByName('QTDREVISADO').AsFloat - Tabela.FieldByName('QTDDEFEITO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
        end;
      end
      else
        if Varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
        begin
          PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATREAL').AsDateTime));
          PrintTab(Tabela.FieldByName('NUMPED').AsString+' ');
          PrintTab(Tabela.FieldByName('SEQORD').AsString+' ');
          PrintTab('  '  + Tabela.FieldByName('C_NOM_PRO').AsString);
          if Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat <> 0 then
          begin
            VpfQtdTotalRevisado := VpfQtdTotalRevisado + Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat;
            vpfQtdTotalDefeito := vpfQtdTotalDefeito + Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat;
            VpfValTotal := VpfValTotal + ((Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat - Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
            VpfQtdRevisadoTerceiro := VpfQtdRevisadoTerceiro + Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat;
            vpfQtdDefeitoTerceiro := vpfQtdDefeitoTerceiro +  Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat;
            VpfValTotalTerceiro := VpfValTotalTerceiro + ((Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat - Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
            PrintTab(Tabela.FieldByName('QTDREVISADOTERCEIRO').AsString+' ');
            PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
            PrintTab(FormatFloat('#,###,###,##0.00',(Tabela.FieldByName('QTDREVISADOTERCEIRO').AsFloat - Tabela.FieldByName('QTDDEFEITOTERCEIRO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
          end
          else
          begin
            VpfQtdTotalRevisado := VpfQtdTotalRevisado + Tabela.FieldByName('QTDREVISADO').AsFloat;
            vpfQtdTotalDefeito := vpfQtdTotalDefeito + Tabela.FieldByName('QTDDEFEITO').AsFloat;
            VpfValTotal := VpfValTotal + ((Tabela.FieldByName('QTDREVISADO').AsFloat - Tabela.FieldByName('QTDDEFEITO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
            VpfQtdRevisadoFaccionista := VpfQtdRevisadoFaccionista + Tabela.FieldByName('QTDREVISADO').AsFloat;
            vpfQtdDefeitoFaccionista := vpfQtdDefeitoFaccionista + Tabela.FieldByName('QTDDEFEITO').AsFloat;
            VpfValTotalFaccionista := VpfValTotalFaccionista + ((Tabela.FieldByName('QTDREVISADO').AsFloat - Tabela.FieldByName('QTDDEFEITO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat);
            PrintTab(Tabela.FieldByName('QTDREVISADO').AsString+' ');
            PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
            PrintTab(FormatFloat('#,###,###,##0.00',(Tabela.FieldByName('QTDREVISADO').AsFloat - Tabela.FieldByName('QTDDEFEITO').AsFloat)*Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
          end;
        end;

      NewLine;
      if LinesLeft<=1 Then
        NewPage;

      Tabela.Next;
    end;
    if VpfCodFaccionista <> -1 then
    begin
      if VpfQtdRevisadoTerceiro <> 0 then
      begin
        bold := true;
        PrintTab('');
        PrintTab('');
        PrintTab('Total Terceiro');
        PrintTab(FormatFloat('#,###,##0',VpfQtdRevisadoTerceiro)+' ');
        PrintTab(FormatFloat('#,###,##0',vpfQtdDefeitoTerceiro)+' ');
        PrintTab(' ');
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotalTerceiro)+' ');
        Bold := false;
        newline;
        If LinesLeft<=1 Then
          NewPage;
      end;
      bold := true;
      RestoreTabs(2);
      SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
      FillRect(CreateRect(MarginLeft+17,YPos-0.4,PageWidth-0.3,YPos+0.1));
      PrintTab('');
      PrintTab('');
      PrintTab('');
      PrintTab(FormatFloat('#,###,##0',VpfQtdRevisadoFaccionista)+' ');
      PrintTab(FormatFloat('#,###,##0',vpfQtdDefeitoFaccionista)+' ');
      PrintTab(' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotalFaccionista)+' ');
      Bold := false;
      newline;
      newline;
      If LinesLeft<=1 Then
        NewPage;
      bold := true;

      if Varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
      begin
        newline;
        newline;
        If LinesLeft<=1 Then
          NewPage;
        RestoreTabs(1);
        PrintTab('Recebido em : ___/___/_______                     __________________________________');
      end;

      newline;
      If LinesLeft<=1 Then
        NewPage;
      newline;
      newline;
      SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
      FillRect(CreateRect(MarginLeft+1,YPos-0.4,PageWidth-0.3,YPos+0.1));
      RestoreTabs(2);
      PrintTab('');
      PrintTab('');
      PrintTab('Total Geral');
      PrintTab(FormatFloat('#,###,##0',VpfQtdTotalRevisado)+' ');
      PrintTab(FormatFloat('#,###,##0',vpfQtdTotalDefeito)+' ');
      PrintTab(' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotal)+' ');
      Bold := false;
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;

  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelPedidosAtrasados(VpaObjeto: TObject);
var
  VpfLaco:integer;
  VpfDPedidosAtrasados: TRBDRPedidosAtrasadosRave;
begin
  with RVSystem.BaseReport do
  begin
    NewLine;
    RestoreTabs(2);
    for VpfLaco := 0 to VprPedidosAtrasados.Count - 1 do
    begin
      VpfDPedidosAtrasados:= TRBDRPedidosAtrasadosRave(VprPedidosAtrasados.Items[VpfLaco]);
      PrintTab(IntToStr(VpfDPedidosAtrasados.QtdDias));
      PrintTab(IntToStr(VpfDPedidosAtrasados.QtdPedidos));
      PrintTab(FormatFloat('0.00 %', (VpfDPedidosAtrasados.QtdPedidos * 100)/ VprDTotalPedidosAtrasados.QtdPedidos));
      PrintTab(FormatFloat('#,###,###,##0.00', VpfDPedidosAtrasados.QtdProdutos));
      PrintTab(FormatFloat('0.00 %', (VpfDPedidosAtrasados.QtdProdutos * 100)/ VprDTotalPedidosAtrasados.QtdProdutos));
      PrintTab(FormatFloat('#,###,###,##0.00', VpfDPedidosAtrasados.ValProdutos));
      PrintTab(FormatFloat('0.00 %', (VpfDPedidosAtrasados.ValProdutos * 100)/ VprDTotalPedidosAtrasados.ValProdutos));
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
    end;
    NewLine;
    Bold:= true;
    PrintTab('Totais ');
    PrintTab(IntToStr(VprDTotalPedidosAtrasados.QtdPedidos));
    PrintTab('');
    PrintTab(FormatFloat('#,###,###,##0.00', VprDTotalPedidosAtrasados.QtdProdutos));
    PrintTab('');
    PrintTab(FormatFloat('#,###,###,##0.00', VprDTotalPedidosAtrasados.ValProdutos));
    PrintTab('');
    Bold:= false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelProdutoFornecedor(VpaObjeto: TObject);
begin
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof do
    begin
      PrintTab(Tabela.FieldByName('C_COD_PRO').AsString);
      PrintTab(Tabela.FieldByName('C_NOM_PRO').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00', Tabela.FieldByName('VALUNITARIO').AsFloat)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00', Tabela.FieldByName('PERIPI').AsFloat)+' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
//      PrintTab(FormatFloat('#,###,###,##0.00', Tabela.FieldByName('ICMS').AsFloat)+' ');
//      PrintTab(FormatFloat('#,###,###,##0.00', Tabela.FieldByName('MVA').AsFloat)+' ');
//      PrintTab(Tabela.FieldByName('CLASSIFICACAOFISCAL').AsString);
//      PrintTab(FormatFloat('#,###,###,##0.00', Tabela.FieldByName('CST').AsFloat)+' ');
      PrintTab(DateToStr(Tabela.FieldByName('DATULTIMACOMPRA').AsDateTime));
      PrintTab(Tabela.FieldByName('DESREFERENCIA').AsString);
      Tabela.Next;
      NewLine;
      if LinesLeft<=1 Then
        NewPage;
    end;
    NewLine;
    if LinesLeft<=1 Then
      NewPage;
    ImprimeCabecalhoTotalFreteNotaXValorConhecimento;
    NewLine;
    if LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelProdutosComDefeito(VpaObjeto: TObject);
var
  VpfQtdProduto,VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VprUfAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaProdutosComDefeito(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
          VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
          VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('UMPADRAO').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
      end;
      VpfQtdProduto := FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdproduto;
      VpfDProduto.ValEstoque := VpfDProduto.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      if Tabela.FieldByName('I_TIP_ORC').AsInteger = Varia.TipoCotacaoGarantia then
      begin
        VpfDProduto.QtdTrocada := VpfDProduto.QtdTrocada + VpfQtdproduto;
        VpfDProduto.ValTroca := VpfDProduto.ValTroca + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      end;

      VpfQtdGeral := VpfQTdGeral + VpfQtdProduto;
      VpfValGeral := VpfValGeral + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosComDefeito(VpfDProduto);

    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
      VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
      VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
{    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;}
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelProdutosFaturadosSTComTributacao(VpaObjeto: TObject);
var
VpfValCompraProduto, VpfBaseST, VpfValST, VpfTotalCompra, VpfTotalST, VpfTotalVendaContabilizado, VpfTotalVendaNaoContabilizado,
  VpfValICMSCompra, VpfTotalICMSCompra, VpfPerICMSInterno : Double;
  VpfDNotaFiscal : TRBDNotaFiscalFor;
  VpfFunNotaFiscalFor : TFuncoesNFFor;
begin
  VpfFunNotaFiscalFor := TFuncoesNFFor.criar(NIL,VprBaseDados);
  VpfDNotaFiscal := TRBDNotaFiscalFor.cria;
  VpfTotalST := 0;
  VpfTotalVendaContabilizado := 0;
  VpfTotalVendaNaoContabilizado := 0;
  VpfPerICMSInterno := FunClientes.RPerICMSUF(Varia.UFFilial);
  VpfTotalICMSCompra := 0;
  with RVSystem.BaseReport do begin
    FontSize := 7;
    while not Tabela.Eof  do
    begin
      VpfDNotaFiscal.Free;
      VpfDNotaFiscal := TRBDNotaFiscalFor.cria;
      VpfFunNotaFiscalFor.CarUltimaNotafiscalProduto(Tabela.FieldByName('D_DAT_EMI').AsDateTime, Varia.CodigoEmpFil,Tabela.FieldByName('I_SEQ_PRO').AsInteger,VpfDNotaFiscal);
      VpfValCompraProduto := FunProdutos.RValorCompra(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_PRO').AsInteger,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfTotalCompra := FunProdutos.CalculaValorPadrao(Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat * VpfValCompraProduto,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfBaseST := VpfTotalCompra +((VpfTotalCompra * Tabela.FieldByName('N_PER_SUT').AsFloat)/100);
      VpfValST := ((VpfBaseST *VpfPerICMSInterno)/100) - ((VpfTotalCompra * Tabela.FieldByName('N_PER_ICM').AsFloat)/100);
      VpfTotalST := VpfTotalST + VpfValST;
      VpfValICMSCompra := (VpfTotalCompra *Tabela.FieldByName('N_PER_ICM').AsFloat)/100;
      VpfTotalICMSCompra := VpfTotalICMSCompra + VpfValICMSCompra;

      if (VpfValCompraProduto = 0) or (Tabela.FieldByName('N_PER_SUT').AsFloat = 0) then
      begin
        FontColor := clred;
        VpfTotalVendaNaoContabilizado := VpfTotalVendaNaoContabilizado + Tabela.FieldByName('N_TOT_PRO').AsFloat;
      end
      else
      begin
        FontColor := clBlack;
        VpfTotalVendaContabilizado := VpfTotalVendaContabilizado + Tabela.FieldByName('N_TOT_PRO').AsFloat;
      end;
      if VpfDNotaFiscal.NumNota = 0 then
      begin
        if fontcolor = clred then
          FontColor := clblue
        else
          FontColor := clSkyBlue;
      end;
      PrintTab(Tabela.FieldByName('I_NRO_NOT').AsString + ' ');
      PrintTab(' ' +Tabela.FieldByName('C_COD_PRO').AsString);
      PrintTab(' ' +Tabela.FieldByName('C_NOM_PRO').AsString);
      PrintTab(Tabela.FieldByName('C_COD_UNI').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_TOT_PRO').AsFloat)+ ' ');
      PrintTab(Formatfloat('#,###,###,##0.00',VpfTotalCompra)+ ' ');
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_PER_SUT').AsFloat)+ ' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfBaseST)+ ' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValST)+ ' ');
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_PER_ICM').AsFloat)+ ' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValICMSCompra)+ ' ');
      newline;
      If LinesLeft<=1 Then
      begin
        NewPage;
        FontSize := 7;
      end;

      if VpfDNotaFiscal.NumNota <> 0 then
      begin
        RestoreTabs(2);
        PrintTab(' '+VpfDNotaFiscal.NomFornecedor);
        PrintTab(VpfDNotaFiscal.CGC_CPFFornecedor);
        PrintTab(IntToStr(VpfDNotaFiscal.NumNota));
        PrintTab(FormatDateTime('DD/MM/YY',VpfDNotaFiscal.DatEmissao));
        newline;
        If LinesLeft<=1 Then
        begin
          NewPage;
          FontSize := 7;
        end;
        RestoreTabs(1);
      end;
      Tabela.Next;
    end;
    if VpfTotalST > 0 then
    begin
      newline;
      If LinesLeft<=1 Then
        NewPage;
      bold := true;
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' Total Contabilizado');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalVendaContabilizado)+ ' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalST)+ ' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalICMSCompra)+ ' ');

      newline;
      If LinesLeft<=1 Then
        NewPage;
      bold := true;
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' Total NÃO Contabilizado');
      PrintTab(' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalVendaNaoContabilizado)+ ' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab('');
      PrintTab(' ');
    end;
  end;
  VpfDNotaFiscal.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelProdutosFaturadosSTComTributacaoPorNota(VpaObjeto: TObject);
var
  VpfValCompraProduto, VpfTotalST, VpfTotalVendaContabilizado, VpfTotalVendaNaoContabilizado,
  VpfTotalICMSCompra, VpfPerICMSInterno : Double;
  VpfDNotaFiscal : TRBDNotaFiscalFor;
  VpfFunNotaFiscalFor : TFuncoesNFFor;
  VpfDProdutoVenda : TRBDProdutosTibFaturadosST;
  VpfDNotaCompra : TRBDNotaEntradaProdutosTibFaturadosST;
  VpfLacoNotas, VpfLacoProdutos : Integer;
  VpfNotasEntrada : TList;
begin
  VpfNotasEntrada := TList.Create;
  VpfFunNotaFiscalFor := TFuncoesNFFor.criar(NIL,VprBaseDados);
  VpfDNotaFiscal := TRBDNotaFiscalFor.cria;
  VpfTotalST := 0;
  VpfTotalVendaContabilizado := 0;
  VpfTotalVendaNaoContabilizado := 0;
  VpfPerICMSInterno := FunClientes.RPerICMSUF(Varia.UFFilial);
  VpfTotalICMSCompra := 0;
  while not Tabela.Eof  do
  begin
    VpfDProdutoVenda := TRBDProdutosTibFaturadosST.cria;
    VpfDNotaFiscal.Free;
    VpfDNotaFiscal := TRBDNotaFiscalFor.cria;
    VpfFunNotaFiscalFor.CarUltimaNotafiscalProduto(Tabela.FieldByName('D_DAT_EMI').AsDateTime,Varia.CodigoEmpFil,Tabela.FieldByName('I_SEQ_PRO').AsInteger,VpfDNotaFiscal);
    if VpfDNotaFiscal.NumNota <> 0 then
    begin
      AdicionaProdutoNota(VpfNotasEntrada,VpfDProdutoVenda,VpfDNotaFiscal);
      VpfValCompraProduto := FunProdutos.RValorCompra(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_PRO').AsInteger,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfDProdutoVenda.ValTotalCompra := FunProdutos.CalculaValorPadrao(Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat * VpfValCompraProduto,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfDProdutoVenda.ValBaseST := VpfDProdutoVenda.ValTotalCompra +((VpfDProdutoVenda.ValTotalCompra * Tabela.FieldByName('N_PER_SUT').AsFloat)/100);
      VpfDProdutoVenda.ValICMSST := ((VpfDProdutoVenda.ValBaseST *VpfPerICMSInterno)/100) - ((VpfDProdutoVenda.ValTotalCompra * Tabela.FieldByName('N_PER_ICM').AsFloat)/100);
      VpfTotalST := VpfTotalST + VpfDProdutoVenda.ValICMSST;
      VpfDProdutoVenda.ValICMSCompra := (VpfDProdutoVenda.ValTotalCompra *Tabela.FieldByName('N_PER_ICM').AsFloat)/100;
      VpfTotalICMSCompra := VpfTotalICMSCompra + VpfDProdutoVenda.ValICMSCompra;

        if (VpfValCompraProduto = 0) or (Tabela.FieldByName('N_PER_SUT').AsFloat = 0) then
          VpfTotalVendaNaoContabilizado := VpfTotalVendaNaoContabilizado + Tabela.FieldByName('N_TOT_PRO').AsFloat
        else
          VpfTotalVendaContabilizado := VpfTotalVendaContabilizado + Tabela.FieldByName('N_TOT_PRO').AsFloat;

      VpfDProdutoVenda.NumNota := Tabela.FieldByName('I_NRO_NOT').AsInteger;
      VpfDProdutoVenda.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
      VpfDProdutoVenda.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
      VpfDProdutoVenda.CodUnidade := Tabela.FieldByName('C_COD_UNI').AsString;
      VpfDProdutoVenda.ValTotalProduto := Tabela.FieldByName('N_TOT_PRO').AsFloat;
      VpfDProdutoVenda.PerSubstituicao := Tabela.FieldByName('N_PER_SUT').AsFloat;
      VpfDProdutoVenda.PerICMS := Tabela.FieldByName('N_PER_ICM').AsFloat;
    end;

    Tabela.Next;
  end;

  with RVSystem.BaseReport do begin
    FontSize := 7;
    for VpfLacoNotas := 0 to VpfNotasEntrada.Count - 1 do
    begin
      VpfDNotaCompra := TRBDNotaEntradaProdutosTibFaturadosST(VpfNotasEntrada.Items[VpfLacoNotas]);
      RestoreTabs(2);
      FontColor := clBlue;
      PrintTab(' Fornecedor : '+VpfDNotaCompra.NomForncedore);
      PrintTab(VpfDNotaCompra.DesCNPJ);
      PrintTab(' NF Entr. :'+IntToStr(VpfDNotaCompra.NumNota));
      PrintTab(FormatDateTime('DD/MM/YY',VpfDNotaCompra.DatEmissao));
      newline;
      If LinesLeft<=1 Then
      begin
        NewPage;
        FontSize := 7;
      end;
      RestoreTabs(1);
      FontColor := clBlack;

      for VpfLacoProdutos := 0 to VpfDNotaCompra.ProdutoFaturados.Count - 1 do
      begin
        VpfDProdutoVenda := TRBDProdutosTibFaturadosST(VpfDNotaCompra.ProdutoFaturados.Items[VpfLacoProdutos]);
        if (VpfDProdutoVenda.ValTotalCompra = 0) or (VpfDProdutoVenda.PerSubstituicao = 0) then
          FontColor := clred
        else
          FontColor := clBlack;
        PrintTab(IntToStr(VpfDProdutoVenda.NumNota) + ' ');
        PrintTab(' ' +VpfDProdutoVenda.CodProduto);
        PrintTab(' ' +VpfDProdutoVenda.NomProduto);
        PrintTab(VpfDProdutoVenda.CodUnidade);
        PrintTab(FormatFloat('#,###,###,##0.00',VpfDProdutoVenda.ValTotalProduto)+ ' ');
        PrintTab(Formatfloat('#,###,###,##0.00',VpfDProdutoVenda.ValTotalCompra)+ ' ');
        PrintTab(FormatFloat('#,###,###,##0.00',VpfDProdutoVenda.PerSubstituicao)+ ' ');
        PrintTab(FormatFloat('#,###,###,##0.00',VpfDProdutoVenda.ValBaseST)+ ' ');
        PrintTab(FormatFloat('#,###,###,##0.00',VpfDProdutoVenda.ValICMSST)+ ' ');
        PrintTab(FormatFloat('#,###,###,##0.00',VpfDProdutoVenda.PerICMS)+ ' ');
        PrintTab(FormatFloat('#,###,###,##0.00',VpfDProdutoVenda.ValICMSCompra)+ ' ');
        newline;
        If LinesLeft<=1 Then
        begin
          NewPage;
          FontSize := 7;
        end;
      end;
    end;
    if VpfTotalST > 0 then
    begin
      newline;
      If LinesLeft<=1 Then
        NewPage;
      bold := true;
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' Total Contabilizado');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalVendaContabilizado)+ ' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalST)+ ' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalICMSCompra)+ ' ');

      newline;
      If LinesLeft<=1 Then
        NewPage;
      bold := true;
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' Total NÃO Contabilizado');
      PrintTab(' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalVendaNaoContabilizado)+ ' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab(' ');
      PrintTab('');
      PrintTab(' ');
    end;
  end;
  VpfDNotaFiscal.Free;
  VpfFunNotaFiscalFor.Free;
  FreeTObjectsList(VpfNotasEntrada);
  VpfNotasEntrada.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelResultadoFinanceiroOrcado(VpaObjeto: TObject);
var
  VpfTotOrcado, VpfTotRealizado, VpfValOutrasReceitas : Double;
begin
  ImprimeRelResutladoFinanceiroOrcadoReceitas(VpfTotOrcado,VpfTotRealizado,VpfValOutrasReceitas);
  VprImprimendoPlanoContas := true;
  ImprimeRelResultadoFinanceiroOrcadoDespesas(VpfTotRealizado,0,'');
  ImprimeRelResultadoFinanceiroOrcadoFinal(VpfTotOrcado, VpfTotRealizado + VpfValOutrasReceitas,VpfValOutrasReceitas);
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelResultadoFinanceiroOrcadoDespesas(VpaValFaturado : Double;VpaCodCentroCusto : Integer;VpaNomCentroCusto : string);
var
  VpfValPago, VpfValDuplicata, VpfPerDiferenca, VpfValPrevisto : Double;
  VpfDClassificacao : TRBDPlanoContasRave;
  VpfQtdNiveisAnterior : Integer;
  VpfUltimoPlanocontasImpresso : String;
begin
  VpfValDuplicata := 0;
  with RVSystem.BaseReport do begin
    RestoreTabs(2);
    NewLine;
    NewLine;
    If LinesLeft<=3 Then
      NewPage;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    if VpaCodCentroCusto = 0 then
      PrintTab('DESPESAS')
    else
      PrintTab('DESPESAS CENTRO CUSTO '+IntToStr(VpaCodCentroCusto)+'-'+VpaNomCentroCusto);
    FontSize := 10;
    RestoreTabs(3);
    NewLine;
    NewLine;
    bold := true;
    PrintTab('Plano de Contas ');
    PrintTab('  ');
    PrintTab('Orçado ');
    PrintTab('Realizado ');
    PrintTab('Diferença ');
    PrintTab('% Faturamento ');
    Bold := false;
    If LinesLeft<=2 Then
      NewPage;

    FreeTObjectsList(VprNiveis);
    LimpaSQlTabela(Tabela);
    AdicionaSqltabela(Tabela,'SELECT * FROM CAD_PLANO_CONTA '+
                           ' WHERE C_TIP_PLA = ''D'''+
                           ' and I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                           ' ORDER BY C_CLA_PLA');
    NewLine;
    Tabela.open;
    VpfUltimoPlanocontasImpresso := '';
    while not Tabela.Eof  do
    begin
      VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString,false);
      CarValoresContasAPagar(VprFilial,VpaCodCentroCusto, Tabela.FieldByName('C_CLA_PLA').AsString,VprDatInicio,VprDatFim,VpfValPago,VpfValDuplicata);
      if VprResultadoFinanceiroConsolidado then
        VpfValPrevisto :=  FunContasAPagar.RValPrevistoPlanoContas(Tabela.FieldByName('I_COD_EMP').AsInteger,VpaCodCentroCusto,Tabela.FieldByName('C_CLA_PLA').AsString,VprDatInicio,VprDatFim)
      else
        VpfValPrevisto := Tabela.FieldByName('N_VLR_PRE').AsFloat;
      if (VpfValPrevisto > 0)or
         (VpfValDuplicata > 0) then
      begin
        if ContaLetra(VpfDClassificacao.CodPlanoCotas,'.') < ContaLetra(VpfUltimoPlanocontasImpresso,'.') then
            NewLine;
        VpfUltimoPlanocontasImpresso := VpfDClassificacao.CodPlanoCotas;
        PrintTab(AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.'))+ VpfDClassificacao.CodPlanoCotas);
        PrintTab(AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.')*2)+VpfDClassificacao.NomPlanoContas);
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValPrevisto));
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValDuplicata));
        VpfPerDiferenca := 0;
        if VpfValPrevisto <> 0 then
          VpfPerDiferenca := ((VpfValDuplicata * 100)/ VpfValPrevisto) - 100;
        if  VpfPerDiferenca > 0 then
          FontColor := clRed;
        PrintTab(FormatFloat('#,###,###,##0.00 %',VpfPerDiferenca));
        FontColor := clBlack;
        VpfPerDiferenca := 0;
        if VpaValFaturado > 0 then
          VpfPerDiferenca := ((VpfValDuplicata * 100)/VpaValFaturado);
        PrintTab(FormatFloat('#,###,###,##0.00 %',VpfPerDiferenca));

        NewLine;
        If LinesLeft<=1 Then
          NewPage;
      end;
      Tabela.next;
    end;

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    bold := false;
  end;
  Tabela.Close;
  FreeTObjectsList(VprNiveis);

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelResultadoFinanceiroOrcadoFinal(VpaMetaVenda, VpaValFaturado,VpaValOutrasReceitas: Double);
var
  VpfValPago, VpfValDuplicata, VpfPerDiferenca, VpfTotalDespesaOrcada : Double;
  VpfDClassificacao : TRBDPlanoContasRave;
  VpfQtdNiveisAnterior : Integer;
begin
  VpfValDuplicata := 0;
  with RVSystem.BaseReport do begin
    RestoreTabs(2);
    NewLine;
    NewLine;
    If LinesLeft<=3 Then
      NewPage;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('ORÇADO');
    FontSize := 10;
    RestoreTabs(4);
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    bold := true;
    PrintTab('Total Receitas ');
    PrintTab('Total Despesas  ');
    PrintTab('Valor Final ');
    PrintTab('% Final ');
    Bold := false;
    VpfTotalDespesaOrcada := RValOrcadoTotal(VprDatInicio,VprDatFim);
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(FormatFloat('#,###,###,##0.00',VpaMetaVenda));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalDespesaOrcada));
    PrintTab(FormatFloat('#,###,###,##0.00',VpaMetaVenda - VpfTotalDespesaOrcada));
    VpfPerDiferenca := 0;
    if VpaMetaVenda > 0 then
      VpfPerDiferenca := ((VpaMetaVenda-VpfTotalDespesaOrcada) * 100)/VpaMetaVenda;
    if VpfPerDiferenca < 0 then
      FontColor := clred;
    PrintTab(FormatFloat('#,###,###,##0.00 %',VpfPerDiferenca));
    FontColor := clBlack;

    RestoreTabs(2);
    NewLine;
    NewLine;
    If LinesLeft<=3 Then
      NewPage;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('Resultado - Outras Receitas');
    FontSize := 10;
    RestoreTabs(4);
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    bold := true;
    PrintTab('Total Receitas ');
    PrintTab('Total Despesas  ');
    PrintTab('Valor Final ');
    PrintTab('% Final ');
    Bold := false;
    CarValoresContasAPagar(VprFilial,0, '',VprDatInicio,VprDatFim,VpfValPago,VpfValDuplicata);
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(FormatFloat('#,###,###,##0.00',VpaValFaturado-VpaValOutrasReceitas));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfValDuplicata));
    PrintTab(FormatFloat('#,###,###,##0.00',VpaValFaturado-VpaValOutrasReceitas - VpfValDuplicata));
    VpfPerDiferenca := 0;
    if (VpaValFaturado-VpaValOutrasReceitas) > 0 then
      VpfPerDiferenca := ((VpaValFaturado-VpaValOutrasReceitas-VpfValDuplicata) * 100)/VpaValFaturado;
    if VpfPerDiferenca < 0 then
      FontColor := clred;
    PrintTab(FormatFloat('#,###,###,##0.00 %',VpfPerDiferenca));
    FontColor := clBlack;

    RestoreTabs(2);
    NewLine;
    NewLine;
    If LinesLeft<=3 Then
      NewPage;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('Resultado');
    FontSize := 10;
    RestoreTabs(4);
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    bold := true;
    PrintTab('Total Receitas ');
    PrintTab('Total Despesas  ');
    PrintTab('Valor Final ');
    PrintTab('% Final ');
    Bold := false;
    CarValoresContasAPagar(VprFilial,0, '',VprDatInicio,VprDatFim,VpfValPago,VpfValDuplicata);
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(FormatFloat('#,###,###,##0.00',VpaValFaturado));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfValDuplicata));
    PrintTab(FormatFloat('#,###,###,##0.00',VpaValFaturado - VpfValDuplicata));
    VpfPerDiferenca := 0;
    if VpaValFaturado > 0 then
      VpfPerDiferenca := ((VpaValFaturado-VpfValDuplicata) * 100)/VpaValFaturado;
    if VpfPerDiferenca < 0 then
      FontColor := clred;
    PrintTab(FormatFloat('#,###,###,##0.00 %',VpfPerDiferenca));
    FontColor := clBlack;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelResultadoFinanceiroOrcadoPorCentroCusto(VpaObjeto: TObject);
var
  VpfTotOrcado, VpfTotRealizado, VpfValOutrasReceitas : Double;
begin
  ImprimeRelResutladoFinanceiroOrcadoReceitas(VpfTotOrcado,VpfTotRealizado,VpfValOutrasReceitas);
  VprImprimendoPlanoContas := true;
  AdicionaSQLAbreTabela(Clientes,'Select * from CENTROCUSTO ');
  while not Clientes.Eof do
  begin
    ImprimeRelResultadoFinanceiroOrcadoDespesas(VpfTotRealizado,Clientes.FieldByName('CODCENTRO').AsInteger,Clientes.FieldByName('NOMCENTRO').AsString);
    Clientes.Next;
  end;

  ImprimeRelResultadoFinanceiroOrcadoFinal(VpfTotOrcado,VpfTotRealizado + VpfValOutrasReceitas,VpfValOutrasReceitas);
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelResumoCaixas(VpaObjeto: TObject);
VAR
  VpfSaldoTotal, VpfTotalCheques, VpfValCheque: Double;
  VpfZebrado : Boolean;
begin
  VpfSaldoTotal := 0;
  VpfTotalCheques := 0;
  with RVSystem.BaseReport do begin
    RestoreTabs(1);
    NewLine;
    while not Tabela.Eof  do
    begin
      if VpfZebrado then
      begin
        SetBrush(ShadeToColor(clSilver,20),bsSolid,nil);
        FillRect(CreateRect(MarginLeft-0.1,YPos+LineHeight-1+0.3,PageWidth-0.3,YPos+0.1));
      end;
      VpfZebrado := not VpfZebrado;
      PrintTab(Tabela.FieldByName('I_COD_BAN').AsString+'-'+Tabela.FieldByName('C_NOM_BAN').AsString);
      PrintTab(Tabela.FieldByName('C_NRO_CON').AsString);
      PrintTab('  '+Tabela.FieldByName('C_NOM_CRR').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_SAL_ATU').AsFloat));
      VpfValCheque := FunContasAReceber.RValChequesNaoCompesadosContaCaixa(Tabela.FieldByName('C_NRO_CON').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValCheque));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_SAL_ATU').AsFloat+VpfValCheque));

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      VpfSaldoTotal := VpfSaldoTotal + Tabela.FieldByName('N_SAL_ATU').AsFloat;
      VpfTotalCheques := VpfTotalCheques +VpfValCheque;
      Tabela.next;
    end;

    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab(FormatFloat(varia.MascaraQtd,VpfSaldoTotal));
    PrintTab(FormatFloat(varia.MascaraQtd,VpfTotalCheques));
    PrintTab(FormatFloat(varia.MascaraQtd,VpfSaldoTotal + VpfTotalCheques));
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelResutladoFinanceiroOrcadoReceitas(var VpaValOrcado, VpaValRealizado, VpaValOutrasReceitas: Double);
var
  VpfValOrcado, VpfValRealizado, vpfDiferenca : Double;
begin
  VpaValOrcado := 0;
  VpaValRealizado := 0;
  AdicionaSQLAbreTabela(Clientes,'Select I_COD_VEN, C_NOM_VEN '+
                                 ' from CADVENDEDORES '+
                                 ' Where C_IND_ATI = ''S'''+
                                 ' order by C_NOM_VEN ');
  with RVSystem.BaseReport do begin
    RestoreTabs(2);
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('RECEITAS');
    FontSize := 10;
    RestoreTabs(1);
    NewLine;
    NewLine;
    bold := true;
    PrintTab('Vendedor ');
    PrintTab('Orçado ');
    PrintTab('Realizado ');
    PrintTab('Diferença ');
    Bold := false;
    Bold := false;
    NewLine;
    while not Clientes.Eof do
    begin
      PrintTab(Clientes.FieldByName('C_NOM_VEN').AsString +' ');
      VpfValOrcado := FunVendedor.RValMetaVendedor(Clientes.FieldByName('I_COD_VEN').AsInteger,VprDatInicio,VprDatFim);
      VpfValRealizado := FunVendedor.RValContasaReceberEmissaoVendedor(VprFilial, Clientes.FieldByName('I_COD_VEN').AsInteger,VprDatInicio,VprDatFim);
      if VpfValOrcado > 0 then
        vpfDiferenca :=  ((VpfValRealizado * 100)/VpfValOrcado) - 100
      else
        vpfDiferenca := 0;
      VpaValOrcado := VpaValOrcado + VpfValOrcado;
      VpaValRealizado :=  VpaValRealizado + VpfValRealizado;

      PrintTab(FormatFloat('#,###,###,##0.00',VpfValOrcado));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValRealizado));
      if vpfDiferenca < 0 then
        FontColor := clRed;
      PrintTab(FormatFloat('#,###,###,##0.00 %',vpfDiferenca));
      FontColor := clBlack;
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      Clientes.Next;
    end;
    VpfValRealizado := FunVendedor.RValContasaReceberEmissaoVendedoresInativos(VprFilial,VprDatInicio,VprDatFim);
    if VpfValRealizado <> 0 then
    begin
      VpaValRealizado :=  VpaValRealizado + VpfValRealizado;
      PrintTab('VENDEDORES INATIVOS ');
      PrintTab(FormatFloat('#,###,###,##0.00',0));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValRealizado));
      PrintTab(FormatFloat('#,###,###,##0.00 %',0));
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
    end;

    Bold := true;
    PrintTab('TOTAL DAS RECEITAS  - VENDAS ');
    PrintTab(FormatFloat('#,###,###,##0.00',VpaValOrcado));
    PrintTab(FormatFloat('#,###,###,##0.00',VpaValRealizado));
    if VpaValOrcado > 0 then
      vpfDiferenca :=  ((VpaValRealizado * 100)/VpaValOrcado) - 100
    else
      vpfDiferenca := 0;
    if vpfDiferenca < 0 then
      FontColor := clRed;
    PrintTab(FormatFloat('#,###,###,##0.00 %',vpfDiferenca));
    FontColor := clBlack;
    bold := false;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;

    VpaValOutrasReceitas := FunVendedor.RValContasaReceberEmissaoSemVendedor(VprFilial,VprDatInicio,VprDatFim);
    if VpaValOutrasReceitas <> 0 then
    begin
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      PrintTab('**** OUTRAS RECEITAS ******* ');
      PrintTab(FormatFloat('#,###,###,##0.00',0));
      PrintTab(FormatFloat('#,###,###,##0.00',VpaValOutrasReceitas));
      PrintTab(FormatFloat('#,###,###,##0.00 %',0));
      NewLine;
      NewLine;
      If LinesLeft<=1 Then
        NewPage;

      Bold := true;
      PrintTab('TOTAL DAS RECEITAS');
      PrintTab(FormatFloat('#,###,###,##0.00',VpaValOrcado));
      PrintTab(FormatFloat('#,###,###,##0.00',VpaValRealizado +VpaValOutrasReceitas ));
      if VpaValOrcado > 0 then
        vpfDiferenca :=  (((VpaValRealizado + VpaValOutrasReceitas) * 100)/VpaValOrcado) - 100
      else
        vpfDiferenca := 0;
      if vpfDiferenca < 0 then
        FontColor := clRed;
      PrintTab(FormatFloat('#,###,###,##0.00 %',vpfDiferenca));
      FontColor := clBlack;
      bold := false;
    end;

  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelRomaneioEtikArt(VpaObjeto: TObject);
var
  VpfValUnitario, VpfTotalKM, VpfTotalGeralKM, VpfValTotalGeral, VpfMetFita : Double;
  VpfCodCombinacao, VpfNumFitas, VpfNumPedido, VpfNumFitasPedido, VpfSeqOrdemProducao : Integer;
  VpfSegundaCombinacao : Boolean;
  VpfCombinacoes, VpfManequins, VpfCodProduto, VpfNomProduto : String;
begin
  VpfValTotalGeral := 0;
  VpfTotalGeralKM := 0;
  with RVSystem.BaseReport do begin
    RestoreTabs(1);
    NewLine;
    while not Tabela.eof do
    begin
      if (VpfNumPedido  <> Tabela.FieldByName('NUMPED').AsInteger) or
         ( VpfCodCombinacao <> Tabela.FieldByName('CODCOM').AsInteger) or
         (VpfNumFitasPedido <> Tabela.FieldByName('NROFIT').AsInteger ) or
         (VpfSeqOrdemProducao <> Tabela.FieldByName('SEQORD').AsInteger) then
      begin
        if VpfSeqOrdemProducao <> 0 then
        begin
          PrintTab(IntToStr(VpfNumPedido));
          PrintTab(VpfCodProduto);
          if length(VpfManequins) >= 30 then
             PrintTab('Vários')
          else
             PrintTab(copy(VpfManequins,1,length(VpfManequins)-2));
          PrintTab(copy(VpfCombinacoes,1,length(VpfCombinacoes)-2));
          PrintTab(IntToStr(VpfNumFitas));
          PrintTab(FormatFloat('###,###,##0.00',VpfMetFita)+' ');
          PrintTab(FormatFloat(varia.mascaraqtd,VpfTotalKm)+' ');
          PrintTab(FormatFloat('###,###,##0.00',VpfValUnitario)+' ');
          PrintTab(FormatFloat('###,###,##0.00',ArredondaDecimais(VpfTotalKm,3) * VpfValUnitario)+' ');
          PrintTab(' '+VpfNomProduto);
          VpfValTotalGeral := VpfValTotalGeral +(ArredondaDecimais(VpfTotalKm,4) * VpfValUnitario);
          VpfTotalGeralKM := VpfTotalGeralKM + VpfTotalKm;
          NewLine;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfCombinacoes := '';
        VpfManequins :='';
        VpfCodCombinacao := 0;
        VpfNumFitas := 0;
        VpfMetFita := 0;
        VpfTotalKm := 0;
        VpfSegundaCombinacao := false;
        VpfCodProduto := Tabela.FieldByName('CODPRO').AsString;
        VpfNomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
        VpfNumPedido := Tabela.FieldByName('NUMPED').AsInteger;
        VpfNumFitasPedido := Tabela.FieldByName('NROFIT').AsInteger;
        VpfSeqOrdemProducao := Tabela.FieldByName('SEQORD').AsInteger;
      end;

      VpfValUnitario := Tabela.FieldByName('VALUNI').AsFloat;
      VpfTotalKm := VpfTotalKm + (Tabela.FieldByName('METCOL').AsFloat * Tabela.FieldByName('NROFIT').AsInteger) /1000;
      if (Tabela.FieldByName('TIPTEA').AsInteger in [0,1]) then
      begin
        if ((VpfCodCombinacao = Tabela.FieldByName('CODCOM').AsInteger) or
           (VpfCodCombinacao = 0)) and not(VpfSegundaCombinacao) then
          VpfMetFita := VpfMetFita + Tabela.FieldByName('METCOL').AsFloat;
      end
      else
        VpfMetFita := VpfMetFita + Tabela.FieldByName('METCOL').AsFloat; //tear H sempre soma os metros porque as combinações não rodam paralelamente

      if VpfCodCombinacao <> Tabela.FieldByName('CODCOM').AsInteger then
      begin
        if VpfCodCombinacao <> 0 then
          VpfSegundaCombinacao := true;
        VpfCodCombinacao := Tabela.FieldByName('CODCOM').AsInteger;
        if Tabela.FieldByName('TIPTEA').AsInteger in [0,1] then //tear convencional
          VpfNumFitas := VpfNumFitas + Tabela.FieldByName('NROFIT').AsInteger
        else
          VpfNumFitas := Tabela.FieldByName('NROFIT').AsInteger; //tear H não soma o número de fitas porque as combinações não correm paralelamente.
        VpfCombinacoes := VpfCombinacoes + Tabela.FieldByName('CODCOM').AsString + ', ';
      end;

      if Tabela.FieldByName('CODMAN').AsString <> '' then
        VpfManequins := VpfManequins + Tabela.FieldByName('CODMAN').AsString+ ', ';

      Tabela.next;
    end;
    if VpfSeqOrdemProducao <> 0 then
    begin
      PrintTab(IntToStr(VpfNumPedido));
      PrintTab(VpfCodProduto);
      if length(VpfManequins) >= 30 then
         PrintTab('Vários')
      else
         PrintTab(copy(VpfManequins,1,length(VpfManequins)-2));
      PrintTab(copy(VpfCombinacoes,1,length(VpfCombinacoes)-2));
      PrintTab(IntToStr(VpfNumFitas));
      PrintTab(FormatFloat('###,###,##0.00',VpfMetFita)+' ');
      PrintTab(FormatFloat(varia.mascaraqtd,VpfTotalKm)+' ');
      PrintTab(FormatFloat('###,###,##0.00',VpfValUnitario)+' ');
      PrintTab(FormatFloat('###,###,##0.00',ArredondaDecimais(VpfTotalKm,3) * VpfValUnitario)+' ');
      PrintTab(' '+VpfNomProduto);
      VpfValTotalGeral := VpfValTotalGeral +(ArredondaDecimais(VpfTotalKm,4) * VpfValUnitario);
      VpfTotalGeralKM := VpfTotalGeralKM + VpfTotalKm;
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
    end;
    Bold := true;
    PrintTab('');
    PrintTab('');
    PrintTab('TOTAL');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab(FormatFloat('###,###,##0.00',VpfTotalGeralKm)+' ');
    PrintTab('');
    PrintTab(FormatFloat('###,###,##0.00',vpfValTotalGeral)+' ');
    PrintTab('');
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(2);
    PrintTab('ICMS');
    PrintTab(FormatFloat('###,###,##0.00',vpfValTotalGeral*0.17)+' ');
    bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelRomaneioSeparacaoCotacao(VpaObjeto: TObject);
var
  VpfLaco, VpfQtdCotacao : Integer;
  VpfDProRomaneio : TRBDOrcProduto;
  VpfDCotacao : TRBDOrcamento;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    for vpfLaco := 0 to VprRomaneioProduto.Count - 1 do
    begin
      VpfDProRomaneio := TRBDOrcProduto(VprRomaneioProduto.Items[Vpflaco]);
      PrintTab(IntToStr(VpfLaco+1));
      PrintTab(' '+VpfDProRomaneio.CodProduto);
      PrintTab(' '+VpfDProRomaneio.NomProduto+ ' -  '+VpfDProRomaneio.DesCor+ ' - '+VpfDProRomaneio.DesEmbalagem);
      PrintTab(' '+VpfDProRomaneio.DesPrateleira);
      PrintTab(VpfDProRomaneio.UM);
      PrintTab(FormatFloat(varia.MascaraQtd,VpfDProRomaneio.QtdProduto));
      PrintTab(FormatFloat('#,##0.00',VpfDProRomaneio.AltProdutonaGrade));
      NewLine;
      If LinesLeft<=1 Then
      begin
        NewPage;
        NewLine;
      end;
    end;

    VpfQtdCotacao := 0;
    RestoreTabs(2);
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' Notas');
    VpfQtdCotacao := 0;
    for VpfLaco := 0 to VprCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[vpfLaco]);
      PrintTab(' '+IntToStr(VpfDCotacao.LanOrcamento)+' ');
      inc(VpfQtdCotacao);
      if VpfQtdCotacao > 7 then
      begin
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
        PrintTab('');
        VpfQtdCotacao := 0;
      end;
    end;
    if VpfQtdCotacao > 0 then
    begin
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
    end;

    RestoreTabs(3);
    PrintTab(' HORARIO');
    PrintTab('                     até');
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' SEPARADOR');
    PrintTab('');
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' JAMES');
    PrintTab('');
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' RALF/ZE');
    PrintTab('');
    NewLine;
    If LinesLeft<=1 Then
      NewPage;

  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelServicoVendidoPorClassificacao(VpaObjeto: TObject);
var
  VpfQtdGeral, VpfValGeral : Double;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VprUfAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
      begin
        VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
        ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
        VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
      end;
      PrintTab(Tabela.FieldByName('I_COD_SER').AsString);
      PrintTab(Tabela.FieldByName('C_NOM_SER').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('QTDSERVICO').AsFloat));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALSERVICO').AsFloat));
      newline;
      If LinesLeft<=1 Then
        NewPage;
      if VpfDClassificacao <> nil then
      begin
        VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +Tabela.FieldByName('QTDSERVICO').AsFloat;
        VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + Tabela.FieldByName('VALSERVICO').AsFloat;
      end;


      VpfQtdGeral := VpfQTdGeral + Tabela.FieldByName('QTDSERVICO').AsFloat;
      VpfValGeral := VpfValGeral + Tabela.FieldByName('VALSERVICO').AsFloat;
      Tabela.next;
    end;


    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelTabelaPreco(VpaObjeto: TObject);
var
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  VpfProdutoAtual := 0;
  VpfClassificacaoAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaPrecoPorCoreTamanho(VpfDProduto);

        if (VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString) and
           VprAgruparClassificacao  then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesCifraoMoeda := Tabela.FieldByname('C_CIF_MOE').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('C_COD_UNI').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.ValEstoque := Tabela.FieldByName('VLRVENDA').AsFloat;
      end;
      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('CODTAMANHO').AsInteger);


      VpfDCor.ValEstoque := Tabela.FieldByName('VLRVENDA').AsFloat;
      VpfDTamanho.ValEstoque := Tabela.FieldByName('VLRVENDA').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaPrecoPorCoreTamanho(VpfDProduto);
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelTotalAmostrasClienteVendedor(VpaObjeto: TObject);
Var
  VpfQtdSolicitada, VpfQtdEntregue, VpfQtdAprovada, VpfQtdCliente, VpfCodUltimoVendedor : Integer;
  VpfTotSolicitada, VpfTotEntregue, VpfTotAprovada, VpfTotCliente : Integer;
  VpfVendedorTotSolicitada, VpfVendedorTotEntregue, VpfVendedorTotAprovada, VpfVendedorTotCliente : Integer;
  VpfFunAmostra : TRBFuncoesAmostra;
begin
  VpfFunAmostra := TRBFuncoesAmostra.cria(Tabela.SQLConnection);
  VpfTotSolicitada :=0;
  VpfTotEntregue := 0;
  VpfTotAprovada := 0;
  VpfTotCliente :=0;
  VpfCodUltimoVendedor := 0;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      LimpaSQLTabela(Aux);
      AdicionaSQLTabela(Aux, ' SELECT CLI.I_COD_CLI, CLI.C_NOM_CLI ' +
                                 '   FROM AMOSTRA AMO, CADCLIENTES CLI ' +
                                 '  WHERE AMO.CODCLIENTE = CLI.I_COD_CLI ' +
                                 '    AND (' + SQLTextoDataEntreAAAAMMDD('AMO.DATAMOSTRA', VprDatInicio, VprDatFim, False) +
                                 '     OR ' +  SQLTextoDataEntreAAAAMMDD('AMO.DATENTREGA', VprDatInicio, VprDatFim, False) +
                                 '     OR ' +  SQLTextoDataEntreAAAAMMDD('AMO.DATAPROVACAO', VprDatInicio, VprDatFim, False) +
                                 '     ) AND AMO.CODVENDEDOR = ' + IntToStr(Tabela.FieldByName('I_COD_VEN').AsInteger));
      if VprCliente <> 0 then
        AdicionaSQLTabela(Aux,'and AMO.CODCLIENTE = '+IntToStr(VprCliente));
      AdicionaSQLTabela(Aux,' GROUP BY CLI.I_COD_CLI, CLI.C_NOM_CLI ' +
                                 ' ORDER BY 1');
      AbreTabela(Aux);
      VpfVendedorTotSolicitada := 0;
      VpfVendedorTotEntregue := 0;
      VpfVendedorTotAprovada := 0;
      VpfVendedorTotCliente := 0;
      while not Aux.Eof do
      begin
        VpfQtdSolicitada := VpfFunAmostra.RQtdAmostraSolicitada(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger, Aux.FieldByName('I_COD_CLI').AsInteger);
        VpfQtdEntregue := VpfFunAmostra.RQtdAmostraEntregue(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger, Aux.FieldByName('I_COD_CLI').AsInteger);
        VpfQtdAprovada := VpfFunAmostra.RQtdAmostraAprovada(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger, Aux.FieldByName('I_COD_CLI').AsInteger);
        if (VpfQtdSolicitada <> 0) or (VpfQtdEntregue <> 0) or
           (VpfQtdAprovada <> 0) then
        begin
          if VpfCodUltimoVendedor <> Tabela.FieldByName('I_COD_VEN').AsInteger then
          begin
            If VpfCodUltimoVendedor <> 0 Then
              NewPage;
            RestoreTabs(1);
            Bold := True;
            PrintTab(' Vendedor : ' + Tabela.FieldByName('C_NOM_VEN').AsString);
            Bold := False;
            newline;
            VpfCodUltimoVendedor := Tabela.FieldByName('I_COD_VEN').AsInteger;
            ImprimeCabecalhoTotalAmostrasClientesVendedor;
            NewLine;
          end;
          RestoreTabs(2);
          PrintTab('  ' +Aux.FieldByName('C_NOM_CLI').AsString);
          PrintTab(IntToStr(VpfQtdSolicitada)+' ');
          PrintTab(IntToStr(VpfQtdEntregue)+' ');
          PrintTab(IntToStr(VpfQtdAprovada)+' ');
          if VpfQtdSolicitada <> 0 then
            PrintTab(FormatFloat('#,##0 %',(VpfQtdAprovada *100)/VpfQtdSolicitada))
          else
            PrintTab(FormatFloat('#,##0 %',0));
          newline;
          If LinesLeft<=1 Then
          begin
            NewPage;
            ImprimeCabecalhoTotalAmostrasClientesVendedor;
            NewLine;
          end;
        end;
        VpfTotSolicitada := VpfTotSolicitada + VpfQtdSolicitada;
        VpfTotEntregue := VpfTotEntregue +VpfQtdEntregue;
        VpfTotAprovada := VpfTotAprovada + VpfQtdAprovada;
        VpfTotCliente := VpfTotCliente + VpfQTDCliente;
        VpfVendedorTotSolicitada := VpfVendedorTotSolicitada + VpfQtdSolicitada;
        VpfVendedorTotEntregue := VpfVendedorTotEntregue + VpfQtdEntregue;
        VpfVendedorTotAprovada := VpfVendedorTotAprovada + VpfQtdAprovada;
        VpfVendedorTotCliente := VpfVendedorTotCliente + VpfQTDCliente;
        Aux.Next;  // Tabela Cliente

      end;
      if not Aux.IsEmpty then
      begin
        // total vendedor
        Bold := true;
        PrintTab('  TOTAL:');
        PrintTab(IntToStr(VpfVendedorTotSolicitada)+' ');
        PrintTab(IntToStr(VpfVendedorTotEntregue)+' ');
        PrintTab(IntToStr(VpfVendedorTotAprovada)+' ');
        //PrintTab(IntToStr(VpfVendedorTotCliente)+' ');
        if VpfVendedorTotSolicitada <> 0 then
          PrintTab(FormatFloat('#,##0 %',(VpfVendedorTotAprovada *100)/VpfVendedorTotSolicitada))
        else
          PrintTab(FormatFloat('#,##0 %',0));
        Bold := false;

        newline;
        If LinesLeft<=1 Then
        begin
          NewPage;
          ImprimeCabecalhoTotalAmostrasClientesVendedor;
          NewLine;
        end;
      end;
      Tabela.next; // Tabela Vendedor
    end;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    Bold := true;
    PrintTab('  TOTAL GERAL:');
    PrintTab(IntToStr(VpfTotSolicitada)+' ');
    PrintTab(IntToStr(VpfTotEntregue)+' ');
    PrintTab(IntToStr(VpfTotAprovada)+' ');
    //PrintTab(IntToStr(VpfTotCliente)+' ');
    if VpfTotSolicitada <> 0 then
      PrintTab(FormatFloat('#,##0 %',(VpfTotAprovada *100)/VpfTotSolicitada))
    else
      PrintTab(FormatFloat('#,##0 %',0));
    Bold := false;
  end;
  Tabela.close;
  VpfFunAmostra.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelTotalAmostrasVendedor(VpaObjeto: TObject);
Var
  VpfQtdSolicitada, VpfQtdEntregue, VpfQtdAprovada, VpfQtdCliente : Integer;
  VpfTotSolicitada, VpfTotEntregue, VpfTotAprovada, VpfTotCliente : Integer;
  VpfFunAmostra : TRBFuncoesAmostra;
begin
  VpfFunAmostra := TRBFuncoesAmostra.cria(Tabela.SQLConnection);
  VpfTotSolicitada :=0;
  VpfTotEntregue := 0;
  VpfTotAprovada := 0;
  VpfTotCliente :=0;
  with RVSystem.BaseReport do begin
    newline;
    while not Tabela.Eof  do
    begin
      VpfQtdSolicitada := VpfFunAmostra.RQtdAmostraSolicitada(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      VpfQtdEntregue :=VpfFunAmostra.RQtdAmostraEntregue(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      VpfQtdAprovada :=VpfFunAmostra.RQtdAmostraAprovada(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      VpfQtdCliente :=VpfFunAmostra.RQtdClientesAmostra(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      if (VpfQtdSolicitada <> 0) or (VpfQtdEntregue <> 0) or
         (VpfQtdAprovada <> 0) then
      begin
        PrintTab('  ' +Tabela.FieldByName('C_NOM_VEN').AsString);
        PrintTab(IntToStr(VpfQtdSolicitada)+' ');
        PrintTab(IntToStr(VpfQtdEntregue)+' ');
        PrintTab(IntToStr(VpfQtdAprovada)+' ');
        PrintTab(IntToStr(VpfQtdCliente)+' ');
        if VpfQtdSolicitada <> 0 then
          PrintTab(FormatFloat('#,##0.00 %',(VpfQtdAprovada *100)/VpfQtdSolicitada))
        else
          PrintTab(FormatFloat('#,##0.00 %',0));
        newline;
        If LinesLeft<=1 Then
          NewPage;
      end;
      VpfTotSolicitada := VpfTotSolicitada + VpfQtdSolicitada;
      VpfTotEntregue := VpfTotEntregue +VpfQtdEntregue;
      VpfTotAprovada := VpfTotAprovada + VpfQtdAprovada;
      VpfTotCliente := VpfTotCliente + VpfQTDCliente;
      Tabela.next;
    end;
    Bold := true;
    PrintTab('  TOTAL');
    PrintTab(IntToStr(VpfTotSolicitada)+' ');
    PrintTab(IntToStr(VpfTotEntregue)+' ');
    PrintTab(IntToStr(VpfTotAprovada)+' ');
    PrintTab(IntToStr(VpfTotCliente)+' ');
    if VpfTotSolicitada <> 0 then
      PrintTab(FormatFloat('#,##0.00 %',(VpfTotAprovada *100)/VpfTotSolicitada))
    else
      PrintTab(FormatFloat('#,##0.00 %',0));
    Bold := false;
  end;
  Tabela.close;
  VpfFunAmostra.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelTotalTipoCotacaoXCusto(VpaObjeto: TObject);
var
  VpfCodTipAtual : Integer;
  VpfValTotal, VpfValProdutos, VpfValCusto : Double;
  VpfQtdPedidos : Integer;
  VpfNomTipo : String;
begin
  VpfCodTipAtual := -1;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfCodTipAtual <> Tabela.FieldByName('I_COD_TIP').AsInteger then
      begin
        if VpfCodTipAtual <> -1 then
        begin
          PrintTab(IntToStr(VpfCodTipAtual));
          PrintTab('  '+VpfNomTipo);
          PrintTab(IntToStr(VpfQtdPedidos));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotal )+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValProdutos)+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValCusto)+' ');
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfValTotal := 0; VpfValProdutos := 0; VpfValCusto := 0; VpfQtdPedidos := 0;
        VpfCodTipAtual := Tabela.FieldByName('I_COD_TIP').AsInteger;
        VpfNomTipo := Tabela.FieldByName('C_NOM_TIP').AsString;
      end;
      inc(VpfQTdPedidos);
      VpfValTotal := VpfValTotal + Tabela.FieldByName('N_VLR_LIQ').AsFloat;
      VpfValProdutos := VpfValProdutos + Tabela.FieldByName('N_VLR_PRO').AsFloat;
      VpfValCusto := VpfValCusto + RValCustoCotacao(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_LAN_ORC').AsInteger);
      Tabela.Next;
    end;
    if VpfCodTipAtual <> -1 then
    begin
      PrintTab(IntToStr(VpfCodTipAtual));
      PrintTab('  '+VpfNomTipo);
      PrintTab(IntToStr(VpfQtdPedidos));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotal )+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValProdutos)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValCusto)+' ');
      PrintTab('');
      newline;
    end;
  end;
  Tabela.Close;
end;


{******************************************************************************}
procedure TRBFunRave.ImprimeRelValorFreteNotaXValorConhecimento(VpaObjeto: TObject);
var
  VpfValorDiferenca, VpfValTotalFrete, VpfValTotalConhecimento,
  VpfValTotalDiferenca: Double;
begin
  VpfValTotalFrete:= 0;
  VpfValTotalConhecimento:= 0;
  VpfValTotalDiferenca:= 0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof do
    begin
      VpfValorDiferenca:= 0;
      PrintTab(Tabela.FieldByName('I_NRO_NOT').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00', Tabela.FieldByName('N_VLR_FRE').AsFloat)+' ');
      PrintTab(Tabela.FieldByName('NUMCONHECIMENTO').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00', Tabela.FieldByName('VALCONHECIMENTO').AsFloat)+' ');
      VpfValorDiferenca:= Tabela.FieldByName('N_VLR_FRE').AsFloat - Tabela.FieldByName('VALCONHECIMENTO').AsFloat;
      PrintTab(FormatFloat('#,###,###,##0.00', VpfValorDiferenca)+' ');
      PrintTab(Tabela.FieldByName('C_NOM_CLI').AsString);

      VpfValTotalConhecimento:= VpfValTotalConhecimento + Tabela.FieldByName('VALCONHECIMENTO').AsFloat;
      VpfValTotalFrete:= VpfValTotalFrete + Tabela.FieldByName('N_VLR_FRE').AsFloat;
      VpfValTotalDiferenca:= VpfValTotalDiferenca + VpfValorDiferenca;

      Tabela.Next;
      NewLine;
      if LinesLeft<=1 Then
        NewPage;
    end;
    NewLine;
    if LinesLeft<=1 Then
      NewPage;
    ImprimeCabecalhoTotalFreteNotaXValorConhecimento;
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      NewLine;
      if LinesLeft<=1 Then
        NewPage;
      PrintTab(FormatFloat('#,###,###,##0.00', VpfValTotalFrete)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00', VpfValTotalConhecimento)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00', VpfValTotalDiferenca)+' ');
      NewLine;
      if LinesLeft<=1 Then
        NewPage;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCartuchosPesadosPorCelula(VpaObjeto: TObject);
var
  VpfDCelula, VpfDCelulaT: TRBDRCelulaTrabalho;
  VpfDDia, VpfDDiaT: TRBDRCelulaTrabalhoDia;
  VpfLaco: Integer;
begin
  with RVSystem.BaseReport do
  begin
    VpfDCelulaT := TRBDRCelulaTrabalho.cria;
    while not Tabela.Eof  do
    begin
      RestoreTabs(1);
      VpfDCelula := TRBDRCelulaTrabalho.cria;
      PrintTab(' ' + Tabela.FieldByName('CODCELULA').AsString + '-' +Tabela.FieldByName('NOMCELULA').AsString);
      CarDCartuchosPesadosCelula(Tabela.FieldByName('CODCELULA').AsInteger, VpfDCelula, Tabela);

      for VpfLaco := 0 to VpfDCelula.Dias.Count-1 do
      begin
        VpfDDia := TRBDRCelulaTrabalhoDia(VpfDCelula.Dias.Items[VpfLaco]);
        if VpfDDia.Quantidade = 0 then
          PrintTab('')
        else
          PrintTab(IntToStr(VpfDDia.Quantidade));

        VpfDDiaT := TRBDRCelulaTrabalhoDia(VpfDCelulaT.Dias.Items[VpfLaco]);
        VpfDDiaT.Quantidade := VpfDDiaT.Quantidade + VpfDDia.Quantidade;
        VpfDCelulaT.QtdTotal := VpfDCelulaT.QtdTotal + VpfDDia.Quantidade;
      end;
      PrintTab(IntToStr(VpfDCelula.QtdTotal));

      NewLine;
      if LinesLeft<=1 Then
        NewPage;

      VpfDCelula.Free;
    end;
    RestoreTabs(1);
    Bold := True;
    PrintTab(' Total');
    for VpfLaco := 0 to VpfDCelulaT.Dias.Count-1 do // totais por dia
    begin
      VpfDDiaT := TRBDRCelulaTrabalhoDia(VpfDCelulaT.Dias.Items[VpfLaco]);
      if VpfDDiaT.Quantidade = 0 then
        PrintTab('')
      else
        PrintTab(IntToStr(VpfDDiaT.Quantidade));
    end;
    PrintTab(IntToStr(VpfDCelulaT.QtdTotal));
    VpfDCelulaT.Free;
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelClientesXCobrancaPorBairro(VpaObjeto: TObject);
var
  vpfBairro : String;
  VpfValSaldoAnterior, vpfValUltimaCompra, vpfValSaldoTotal, VpfTotalBairro, vpfTotalGeral : double;
begin
  VpfTotalBairro := 0;
  vpfTotalGeral := 0;
  with RVSystem.BaseReport do begin
    FontSize := 8;
    vpfBairro := '-sembairro-';
    while not Tabela.Eof  do
    begin
      if vpfBairro <> Tabela.FieldByName('C_BAI_CLI').AsString then
      begin
        VprBairro :=Tabela.FieldByName('C_BAI_CLI').AsString;
        if vpfBairro <> '-sembairro-' then
        begin
          NewLine;
          If LinesLeft<=1 Then
            NewPage;
          RestoreTabs(4);
          bold := true;
          PrintTab('Total Bairro : '+FormatFloat('R$ #,###,###,###,##0.00',VpfTotalBairro));
          bold := false;
        end
        else
          ImprimeCabecalhoClientesXCobrancaporBairro;
        VpfTotalBairro := 0;
        vpfBairro := Tabela.FieldByName('C_BAI_CLI').AsString;
      end;

      VpfValSaldoAnterior := FunContasAReceber.RValAbertoCliente(Tabela.FieldByName('I_COD_CLI').AsInteger,MontaData(1,1,1900),DecMes(DATE,1));
      vpfValUltimaCompra := FunContasAReceber.RValAbertoCliente(Tabela.FieldByName('I_COD_CLI').AsInteger,incdia(DecMes(DATE,1),1),IncAno(date,1));
      vpfValSaldoTotal := VpfValSaldoAnterior +vpfValUltimaCompra;
      VpfTotalBairro := VpfTotalBairro +vpfValSaldoTotal;
      vpfTotalGeral := vpfTotalGeral + vpfValSaldoTotal;

      RestoreTabs(1);
      PrintTab('  ' +Tabela.FieldByName('C_END_CLI').AsString);
      PrintTab('Nro  ' +Tabela.FieldByName('I_NUM_END').AsString);
      PrintTab(' '+Tabela.FieldByName('C_COM_END').AsString);
      PrintTab(' Saldo Total R$ '+FormatFloat('#,###,###,##0.00',vpfValSaldoTotal));
      newline;
      If LinesLeft<=1 Then
        NewPage;
      RestoreTabs(2);
      bold := true;
      PrintTab('  ' +Tabela.FieldByName('I_COD_CLI').AsString+' - '+Tabela.FieldByName('C_NOM_CLI').AsString);
      Bold := false;
      PrintTab('Telefone  ' +Tabela.FieldByName('C_FO1_CLI').AsString);
      PrintTab(' Comprou R$ ____________');
      PrintTab(' Pagou R$ ______________');
      newline;
      If LinesLeft<=1 Then
        NewPage;
      RestoreTabs(3);
      PrintTab(' Mudou-se ( )      Para Entregar ( )    Repasse ( )');
      PrintTab('Saldo Anterior R$ '+FormatFloat('#,###,###,##0.00',VpfValSaldoAnterior));
      PrintTab(' Saldo Ult Compra R$ '+FormatFloat('#,###,###,##0.00',vpfValUltimaCompra));
      PrintTab(' Cobrança ___/___/____');
      newline;
      moveto(0.5,YPos+0);
      lineto(22,YPos+0);
      newline;
      If LinesLeft<=1 Then
        NewPage;
      Tabela.next;
    end;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(4);
    bold := true;
    PrintTab('Total Bairro : '+FormatFloat('R$ #,###,###,###,##0.00',VpfTotalBairro));
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('Total Geral : '+FormatFloat('R$ #,###,###,###,##0.00',vpfTotalGeral));
    bold := false;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelConsumoAmostrasAtrasadas(VpaObjeto: TObject);
var
  VpfLacoEntrega, VpfLacoAmostra :integer;
  VpfDConsumoAmostrasAtrasados: TRBDRConsumoEntregaAmostrasRave;
  VpfDAmostra : TRBDAmostraEntrega;
begin
  with RVSystem.BaseReport do
  begin
    NewLine;
    RestoreTabs(2);
    for VpfLacoEntrega := 0 to VprConsumoAmostra.Count - 1 do
    begin
      VpfDConsumoAmostrasAtrasados:= TRBDRConsumoEntregaAmostrasRave(VprConsumoAmostra.Items[VpfLacoEntrega]);
      PrintTab(IntToStr(VpfDConsumoAmostrasAtrasados.QtdDias));
      PrintTab(IntToStr(VpfDConsumoAmostrasAtrasados.QtdAmostras));
      PrintTab(FormatFloat('0.00 %', (VpfDConsumoAmostrasAtrasados.QtdAmostras * 100)/ VprDTotalConsumoAmostra.QtdAmostras));
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      if VprAnalitico then
      begin
        RestoreTabs(3);
        for VpfLacoAmostra := 0 to VpfDConsumoAmostrasAtrasados.Amostras.Count - 1 do
        begin
          VpfDAmostra := TRBDAmostraEntrega(VpfDConsumoAmostrasAtrasados.Amostras.Items[VpfLacoAmostra]);
          PrintTab(IntToStr(VpfDAmostra.CodAmostra)+' ');
          PrintTab(' '+VpfDAmostra.NomAmostra);
          PrintTab(IntToStr(VpfDAmostra.CodCor)+' ');
          PrintTab(FormatDateTime('DD/MM/YY',VpfDAmostra.DatCadastro));
          PrintTab(FormatDateTime('DD/MM/YY',VpfDAmostra.DatEntrega));
          NewLine;
          If LinesLeft<=1 Then
            NewPage;
        end;
        RestoreTabs(2);
      end;
    end;
    NewLine;
    Bold:= true;
    PrintTab('Totais ');
    PrintTab(IntToStr(VprDTotalConsumoAmostra.QtdAmostras));
    PrintTab('');
    Bold:= false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelConsumoProdutoProducao(VpaObjeto: TObject);
var
  VpfQtdProduto, VpfQtdConsumido, VpfQtdGeral, VpfQtdConsumidoGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual, VpfUM : string;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfQtdConsumidoGeral := 0;
  VpfClassificacaoAtual := '';
  VpfDClassificacao := nil;
  VpfDProduto := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if (VpfProdutoAtual <> 0) then
        begin
          if not VprIndSomenteComQtdConsumida or (VprIndSomenteComQtdConsumida and (VpfDProduto.QtdProduzido > 0)) then
            SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);
        end;

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.QtdConsumido := VpfDClassificacao.QtdConsumido + VpfDProduto.QtdProduzido;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        if VpfDProduto <> nil then
          VpfDProduto.free;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('C_COD_UNI').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
      end;

      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('I_COD_TAM').AsInteger);

      VpfQtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfQtdConsumido := FunProdutos.RQtdConsumidoProducao(VprFilial,VpfDProduto.SeqProduto,Tabela.FieldByName('I_COD_COR').AsInteger,Tabela.FieldByName('I_COD_TAM').AsInteger,VprDatInicio,VprDatFim);

      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdProduto;
      VpfDProduto.QtdProduzido := VpfDProduto.QtdProduzido + VpfQtdConsumido;
      vpfDCor.QtdEstoque := vpfDCor.QtdEstoque+ VpfQtdProduto;
      VpfDCor.QtdProduzido := VpfDCor.QtdProduzido + VpfQtdConsumido;
      VpfDTamanho.QtdEstoque := VpfDTamanho.QtdEstoque + VpfQtdProduto;
      VpfDTamanho.QtdProduzido := VpfDTamanho.QtdProduzido + VpfQtdConsumido;

      VpfQtdGeral := VpfQTdGeral +VpfQtdProduto;
      VpfQtdConsumidoGeral := VpfQtdConsumidoGeral + VpfQtdConsumido;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);
    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.QtdConsumido := VpfDClassificacao.QtdConsumido + VpfDProduto.QtdProduzido;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    if config.EstoquePorCor then
      PrintTab('');
    if config.EstoquePorTamanho then
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfQtdConsumidoGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelHistoricoConsumoProdutoProducao(VpaObjeto: TObject);
var
  VpfDatAtual: TDateTime;
  VpfOperacaoAtual, VpfCodClassificacaoAtual: Integer;
  VpfQtdConsumoTotal, VpfQtdConsumoTotalDia: Double;
begin
  VpfDatAtual:= 0;
  VpfOperacaoAtual:= 0;
  VpfQtdConsumoTotal:= 0;
  VpfQtdConsumoTotalDia:= 0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      if VpfDatAtual <> tabela.FieldByName('D_DAT_MOV').AsDateTime then
      begin
        if VpfDatAtual <> 0 then
        begin
          RestoreTabs(4);
          bold:= true;
          newline;
          If LinesLeft<=1 Then
            NewPage;
          printtab('Total Consumido : ');
          printtab(FormatFloat('#,###,###,##0.00',VpfQtdConsumoTotalDia));
          VpfQtdConsumoTotalDia:= 0;
          newline;
          If LinesLeft<=1 Then
            NewPage;

          restoretabs(3);
          If LinesLeft<=1 Then
            NewPage;
          bold:= true;
          printtab('Total Acumulado : ');
          printtab(FormatFloat('#,###,###,##0.00',VpfQtdConsumoTotal));
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        restoretabs(1);
        bold:= true;
        prinTtab(FormatDateTime('DD/MM/YYYY', tabela.FieldByName('D_DAT_MOV').AsDateTime));
        newline;
        bold:= false;
        If LinesLeft<=1 Then
          NewPage;
        VpfDatAtual := tabela.FieldByName('D_DAT_MOV').AsDateTime;
        VpfOperacaoAtual:= 0;
      end;
      if VpfOperacaoAtual <> Tabela.FieldByName('I_COD_OPE').AsInteger then
      begin
        restoretabs(1);
        bold:= true;
        printtab(Tabela.FieldByName('I_COD_OPE').AsString + ' - ' + Tabela.FieldByName('C_NOM_OPE').AsString);
        newline;
        If LinesLeft<=1 Then
          NewPage;
        ImprimeCabecalhoHistoricoConsumoProdutoProducao;
        VpfOperacaoAtual:= Tabela.FieldByName('I_COD_OPE').AsInteger;
      end;
      printtab(Tabela.FieldByName('C_COD_PRO').AsString + ' ');
      printtab(' ' + Tabela.FieldByName('C_NOM_PRO').AsString);
      if Tabela.FieldByName('I_COD_COR').AsInteger  <> 0 then
        printtab(Tabela.FieldByName('I_COD_COR').AsString)
      else
        printtab(' ');
      printtab(Tabela.FieldByName('C_COD_UNI').AsString);
      printtab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_QTD_MOV').AsFloat));
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      if Tabela.FieldByName('C_TIP_OPE').AsString = 'S' then
      begin
        VpfQtdConsumoTotal:= VpfQtdConsumoTotal + FunProdutos.CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString, tABELA.FieldByName('UNORIGINAL').AsString, Tabela.FieldByName('N_QTD_MOV').AsFloat, Tabela.FieldByName('I_SEQ_PRO').AsString);
        VpfQtdConsumoTotalDia:= VpfQtdConsumoTotalDia + FunProdutos.CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString, tABELA.FieldByName('UNORIGINAL').AsString, Tabela.FieldByName('N_QTD_MOV').AsFloat, Tabela.FieldByName('I_SEQ_PRO').AsString);
      end
      else
      begin
        VpfQtdConsumoTotal:= VpfQtdConsumoTotal - FunProdutos.CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString, tABELA.FieldByName('UNORIGINAL').AsString, Tabela.FieldByName('N_QTD_MOV').AsFloat, Tabela.FieldByName('I_SEQ_PRO').AsString);
        VpfQtdConsumoTotalDia:= VpfQtdConsumoTotalDia - FunProdutos.CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString, tABELA.FieldByName('UNORIGINAL').AsString, Tabela.FieldByName('N_QTD_MOV').AsFloat, Tabela.FieldByName('I_SEQ_PRO').AsString);
      end;
      Tabela.next;
    end;
    RestoreTabs(4);
    bold:= true;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    printtab('Total Consumido : ');
    printtab(FormatFloat('#,###,###,##0.00',VpfQtdConsumoTotalDia));
    VpfQtdConsumoTotalDia:= 0;
    newline;
    If LinesLeft<=1 Then
      NewPage;

    restoretabs(3);
    newline;
    newline;
    If LinesLeft<=1 Then
        NewPage;
    bold:= true;
    printtab('Total Consumido : ');
    printtab(FormatFloat('#,###,###,##0.00',VpfQtdConsumoTotal));
  end;



end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelContratosAssinados(VpaObjeto: TObject);
Var
  VpfDatInicioNovoContrato, VpfDatFimNovoContrato, VpfDatAssinatura : TDateTime;
  VpfValContrato, vpfTotalContratos, VpfTotalNovosContratos : Double;
  VpfClienteAtual, VpfCodVendedorAtual : Integer;
  VpfTotalVendedores : TList;
  VpfDTotalvendedor : TRBDTotalVendedorRave;
begin
  VpfTotalVendedores := TList.Create;
   vpfTotalContratos :=0;
  VpfClienteAtual := -1;
  VpfCodVendedorAtual := -1;
  VpfTotalNovosContratos :=0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      if VpfCodVendedorAtual <> Tabela.FieldByName('I_COD_VEN').AsInteger then
      begin
        VpfDTotalvendedor := TRBDTotalVendedorRave.cria;
        VpfTotalVendedores.Add(VpfDTotalvendedor);
        VpfDTotalvendedor.CodVendedor := Tabela.FieldByName('I_COD_VEN').AsInteger;
        VpfDTotalvendedor.NomVendedor := Tabela.FieldByName('C_NOM_VEN').AsString;
        VpfCodVendedorAtual := Tabela.FieldByName('I_COD_VEN').AsInteger
      end;

      PrintTab(Tabela.FieldByName('CODFILIAL').AsString+' ');
      PrintTab(Tabela.FieldByName('SEQCONTRATO').AsString+' ');
      PrintTab(Tabela.FieldByName('I_COD_CLI').AsString+' ');
      PrintTab(' '+Tabela.FieldByName('C_NOM_CLI').AsString);
      PrintTab(' '+Tabela.FieldByName('C_EST_CLI').AsString);
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATINICIOVIGENCIA').AsDateTime));
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('DATFIMVIGENCIA').AsDateTime));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALCONTRATO').AsFloat));
      if VpfClienteAtual <> Tabela.FieldByName('I_COD_CLI').AsInteger then
      begin
        CarRenovacaoContrato(Tabela.FieldByName('I_COD_CLI').AsInteger,Tabela.FieldByName('DATFIMVIGENCIA').AsDateTime,VpfDatAssinatura,VpfDatInicioNovoContrato,VpfDatFimNovoContrato,VpfValContrato);
        VpfTotalNovosContratos := VpfTotalNovosContratos + VpfValContrato;
        VpfDTotalvendedor.ValRenovado := VpfDTotalvendedor.ValRenovado + VpfValContrato;
        VpfClienteAtual := Tabela.FieldByName('I_COD_CLI').AsInteger;
      end
      else
        VpfValContrato := 0;

      PrintTab(FormatFloat('#,###,###,##0.00',VpfValContrato));
      if VpfDatInicioNovoContrato > MontaData(1,1,1900) then
      begin
        PrintTab(FormatDateTime('DD/MM/YY',VpfDatAssinatura));
        PrintTab(FormatDateTime('DD/MM/YY',VpfDatInicioNovoContrato));
        PrintTab(FormatDateTime('DD/MM/YY',VpfDatFimNovoContrato));
      end
      else
      begin
        PrintTab('');
        PrintTab('');
        PrintTab('');
      end;
      PrintTab(Tabela.FieldByName('I_COD_VEN').AsString +' - ' +Tabela.FieldByName('C_NOM_VEN').AsString);


      vpfTotalContratos := vpfTotalContratos + Tabela.FieldByName('VALCONTRATO').AsFloat;
      VpfDTotalvendedor.ValContratos := VpfDTotalvendedor.ValContratos + Tabela.FieldByName('VALCONTRATO').AsFloat;

      newline;
      If LinesLeft<=1 Then
        NewPage;
      Tabela.Next;
    end;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' ');
    PrintTab(' ');
    PrintTab(' ');
    PrintTab(' TOTAL');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab(FormatFloat('#,###,###,##0.00',vpfTotalContratos));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalNovosContratos));
    newline;
  end;
  ImprimeTotalAnaliseRenovacaoContratoTotalVendedor(VpfTotalVendedores);
  FreeTObjectsList(VpfTotalVendedores);
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCPporPlanoContas(VpaObjeto : TObject);
var
  VpfValPago, VpfValDuplicata, VpfTotalPago,VpfTotalDuplicata : Double;
  VpfPlanoContasAtual : string;
  VpfDClassificacao : TRBDPlanoContasRave;
begin
  VpfValPago := 0;
  VpfValDuplicata := 0;
  VpfTotalPago := 0;
  VpfTotalDuplicata := 0;
  VpfPlanoContasAtual := '';
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfPlanoContasAtual <> Tabela.FieldByName('C_CLA_PLA').AsString then
      begin
        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.ValPago := VpfDClassificacao.ValPago +VpfValPago;
          VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;
        end;

        VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString,true);
        ImprimetituloPlanoContas(VprNiveis,VpfPlanoContasAtual = '');
        VpfPlanoContasAtual := Tabela.FieldByName('C_CLA_PLA').AsString;
        VpfValPago := 0;
        VpfValDuplicata := 0;
      end;
      PrintTab(Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString);
      PrintTab(Tabela.FieldByName('I_NRO_NOT').AsString);
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_VEN').AsDatetime));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_DUP').AsFloat));
      if Tabela.FieldByName('D_DAT_PAG').IsNull then
        PrintTab('')
      else
        PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_PAG').AsDatetime));
      if Tabela.FieldByName('N_VLR_PAG').IsNull then
        PrintTab('')
      else
        PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_PAG').AsFloat));

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      VpfValPago := VpfValPago + Tabela.FieldByName('N_VLR_PAG').AsFloat;
      VpfValDuplicata := VpfValDuplicata + Tabela.FieldByName('N_VLR_DUP').AsFloat;
      VpfTotalPago := VpfTotalPago + Tabela.FieldByName('N_VLR_PAG').AsFloat;
      VpfTotalDuplicata := VpfTotalDuplicata + Tabela.FieldByName('N_VLR_DUP').AsFloat;
      Tabela.next;
    end;

    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.ValPago := VpfDClassificacao.ValPago +VpfValPago;
      VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;
    end;
    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveisPlanoContas(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfTotalDuplicata));
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraValor,VpfTotalPago));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCPporPlanoContasSintetico(VpaObjeto: TObject);
var
  VpfValPago, VpfValDuplicata, VpfValEmAberto, VpfPerDiferenca : Double;
  VpfDClassificacao : TRBDPlanoContasRave;
  VpfQtdNiveisAnterior : Integer;
begin
  VpfValDuplicata := 0;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString,false);
      if ContaLetra(VpfDClassificacao.CodPlanoCotas,'.') < VpfQtdNiveisAnterior then
        NewLine;
      VpfQtdNiveisAnterior := ContaLetra(VpfDClassificacao.CodPlanoCotas,'.');
      PrintTab(AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.'))+ VpfDClassificacao.CodPlanoCotas);
      PrintTab(AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.')*2)+VpfDClassificacao.NomPlanoContas);
      CarValoresContasAPagar(VprFilial,0, Tabela.FieldByName('C_CLA_PLA').AsString,VprDatInicio,VprDatFim,VpfValPago,VpfValDuplicata);
      VpfValEmAberto := VpfValDuplicata - VpfValPago;
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValEmAberto));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValPago));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValDuplicata));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_PRE').AsFloat));
      VpfPerDiferenca := 0;
      if Tabela.FieldByName('N_VLR_PRE').AsFloat >  0 then
        VpfPerDiferenca := ((VpfValDuplicata * 100)/Tabela.FieldByName('N_VLR_PRE').AsFloat) -100;

      if VpfPerDiferenca > 0 then
        FontColor := clred;
      PrintTab(FormatFloat('#,###,###,##0.00 %',VpfPerDiferenca));
      FontColor := clBlack;

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      Tabela.next;
    end;

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    bold := false;
  end;
  Tabela.Close;
  FreeTObjectsList(VprNiveis);
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCPPorPlanoContasSinteticoporMes(VpaObjeto : TObject);
var
  VpfDVenda : TRBDVendaCliente;
  VpfLacoAno,VpfLacoMes : Integer;
  VpfDClassificacao : TRBDPlanoContasRave;
  VpfQtdNiveisAnterior : Integer;
  VpfCodPlanoConta, VpfNomPlanoContas : string;
begin
  VpfDVenda := TRBDVendaCliente.cria;
  with RVSystem.BaseReport do begin
    CarValoresPlanoContasMes(VprFilial,'',VprDatInicio,VprDatFim,VpfDVenda);
    Bold := true;
    CarregaValoresMesTabela(VpfDVenda,'TOTAL','');
    Bold := false;
    NewLine;
    while not  Clientes.Eof  do
    begin
      VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Clientes.FieldByName('C_CLA_PLA').AsString,false);
      if ContaLetra(VpfDClassificacao.CodPlanoCotas,'.') < VpfQtdNiveisAnterior then
        NewLine;
      VpfQtdNiveisAnterior := ContaLetra(VpfDClassificacao.CodPlanoCotas,'.');
      VpfCodPlanoConta :=AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.'))+ VpfDClassificacao.CodPlanoCotas;
      VpfNomPlanoContas := AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.')*2)+VpfDClassificacao.NomPlanoContas;
      CarValoresPlanoContasMes(VprFilial,Clientes.FieldByName('C_CLA_PLA').AsString,VprDatInicio,VprDatFim,VpfDVenda);
      CarregaValoresMesTabela(VpfDVenda,VpfCodPlanoConta,VpfNomPlanoContas);
      Clientes.next;
    end;

  end;
  Clientes.Close;
  VpfDVenda.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCreditoCliente(VpaObjeto: TObject);
VAR
  VpfCodCliente : Integer;
  VpfNomCliente : string;
  VpfValCredito, VpfValDebito, VpfValCliente, VpfTotCredito, VpfTotDebito : Double;
begin
  VpfCodCliente := 0;
  VpfTotCredito := 0;
  VpfTotDebito := 0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      if VpfCodCliente <> Tabela.FieldByName('I_COD_CLI').AsInteger then
      begin
        if VpfCodCliente <> 0 then
        begin
          newline;
          If LinesLeft<=1 Then
            NewPage;
          VpfValCliente := VpfValCredito - VpfValDebito;
          PrintTab(' '+IntToStr(VpfCodCliente)+' - '+VpfNomCliente);
          if VpfValCredito > 0 then
            PrintTab(FormatFloat('#,###,###,##0.00',VpfValCredito)+' ')
          else
            PrintTab(' ');
          if VpfValDebito > 0 then
            PrintTab(FormatFloat('#,###,###,##0.00',VpfValDebito)+' ')
          else
            PrintTab(' ');
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValCliente)+' ');
        end;
        VpfCodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
        VpfNomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
        VpfValCredito := 0;
        VpfValDebito := 0;
      end;
      if Tabela.FieldByName('TIPCREDITO').AsString = 'C' then
      begin
        VpfValCredito := VpfValCredito + Tabela.FieldByName('VALCREDITO').AsFloat;
        VpfTotCredito := VpfTotCredito + Tabela.FieldByName('VALCREDITO').AsFloat;
      end
      else
      begin
        VpfValDebito := VpfValDebito + Tabela.FieldByName('VALCREDITO').AsFloat;
        VpfTotDebito := VpfTotDebito + Tabela.FieldByName('VALCREDITO').AsFloat;
      end;
      Tabela.Next;
    end;
    if VpfCodCliente <> 0 then
    begin
      newline;
      If LinesLeft<=1 Then
        NewPage;
      VpfValCliente := VpfValCredito - VpfValDebito;
      PrintTab(' '+IntToStr(VpfCodCliente)+' - '+VpfNomCliente);
      if VpfValCredito > 0 then
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValCredito)+' ')
      else
        PrintTab(' ');
      if VpfValDebito > 0 then
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValDebito)+' ')
      else
        PrintTab(' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValCliente)+' ');
    end;
    Bold := true;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab(' TOTAL ');
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotCredito)+' ');
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotDebito)+' ');
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotCredito - VpfTotDebito)+' ');
    Bold := false;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCustoProjeto(VpaObjeto: TObject);
var
  VpfValCustoProjeto : Double;
begin
  VpfValCustoProjeto := ImprimeRelCustoProjetoContasAPagar;
  VpfValCustoProjeto := VpfValCustoProjeto + ImprimeRelCustoProjetoConsumoMateriaPrima;
  ImprimeRelCustoTotalProjeto(VpfValCustoProjeto);
end;

{******************************************************************************}
function TRBFunRave.ImprimeRelCustoProjetoConsumoMateriaPrima:Double;
var
  VpfSeqOrdem : Integer;
  VpfTotalOP, VpfValCustoUnitario: Double;
begin
  VprImprimindoConsumoOP := true;
  result := 0;
  AdicionaSQLAbreTabela(Tabela,'select FOP.CODFILIAL, FOP.SEQORDEM, FOP.SEQFRACAO, FOP.QTDBAIXADO, FOP.DESUM, FOP.PESPRODUTO,  ' +
                               '  FOP.ALTMOLDE, FOP.LARMOLDE, FOP.VALCUSTOTOTAL, ' +
                               '   PRO.C_COD_PRO, PRO.C_NOM_PRO ' +
                               '  from FRACAOOPCONSUMO FOP, CADPRODUTOS PRO, ORDEMPRODUCAOCORPO OP ' +
                               '  where FOP.CODFILIAL = OP.EMPFIL ' +
                               '  AND FOP.SEQORDEM = OP.SEQORD ' +
                               '  AND OP.CODPRJ = ' + IntToStr(VprCodProjeto)+
                               '  and qtdbaixado > 0 ' +
                               '  AND FOP.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                               '  ORDER BY FOP.CODFILIAL, FOP.SEQORDEM,PRO.C_NOM_PRO, FOP.SEQFRACAO' );
  with RVSystem.BaseReport do begin
    RestoreTabs(4);
    NewLine;
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('ORDENS PRODUÇÃO');
    NewLine;
    NewLine;
    Bold := false;
    FontSize := 10;
    VpfSeqOrdem := 0;
    if NOT Tabela.Eof then
    begin
      ImprimeTituloOPCustoProjeto(Tabela.FieldByName('CODFILIAL').AsInteger,Tabela.FieldByName('SEQORDEM').AsInteger);
      while not Tabela.Eof  do
      begin
        if VpfSeqOrdem <> Tabela.FieldByName('SEQORDEM').AsInteger then
        begin
          if VpfSeqOrdem <> 0 then
          begin
            RestoreTabs(6);
            PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalOP)+' ');
            ImprimeTituloOPCustoProjeto(Tabela.FieldByName('CODFILIAL').AsInteger,Tabela.FieldByName('SEQORDEM').AsInteger);
          end;
          VpfSeqOrdem := Tabela.FieldByName('SEQORDEM').AsInteger;
          VpfTotalOP := 0;
          RestoreTabs(5);
        end;

        VpfValCustoUnitario := 0;
        if Tabela.FieldByName('VALCUSTOTOTAL').AsFloat <> 0 then
        begin
          if Tabela.FieldByName('ALTMOLDE').AsFloat <> 0 then
            VpfValCustoUnitario := Tabela.FieldByName('VALCUSTOTOTAL').AsFloat / Tabela.FieldByName('PESPRODUTO').AsFloat
          else
            VpfValCustoUnitario := Tabela.FieldByName('VALCUSTOTOTAL').AsFloat / Tabela.FieldByName('QTDBAIXADO').AsFloat;
        end;

        PrintTab(Tabela.FieldByName('SEQFRACAO').AsString+' ');
        PrintTab(' '+ Tabela.FieldByName('C_COD_PRO').AsString+'-'+Tabela.FieldByName('C_NOM_PRO').AsString);
        PrintTab(FloattoStr(Tabela.FieldByName('ALTMOLDE').AsFloat*10)+' ');
        PrintTab(FloattoStr(Tabela.FieldByName('LARMOLDE').AsFloat*10)+' ');
        PrintTab(FloattoStr(Tabela.FieldByName('PESPRODUTO').AsFloat)+' ');
        PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('QTDBAIXADO').AsFloat)+' ');
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValCustoUnitario)+' ');
        PrintTab(Tabela.FieldByName('DESUM').AsString);
        PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALCUSTOTOTAL').AsFloat)+' ');
        VpfTotalOP := VpfTotalOP +Tabela.FieldByName('VALCUSTOTOTAL').AsFloat;
        result := result +Tabela.FieldByName('VALCUSTOTOTAL').AsFloat;
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
        Tabela.next;
      end;
    end;
    if VpfSeqOrdem <> 0 then
    begin
      RestoreTabs(6);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfTotalOP)+' ');
    end;

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(7);
    bold := true;
    PrintTab('Total Materia Prima');
    PrintTab(FormatFloat(varia.MascaraQtd,result));
    bold := false;
    newline;
  end;

  Tabela.Close;
end;

{******************************************************************************}
function TRBFunRave.ImprimeRelCustoProjetoContasAPagar:double;
var
  VpfValDuplicata: Double;
  VpfPlanoContasAtual : string;
  VpfDClassificacao : TRBDPlanoContasRave;
begin
  VpfValDuplicata := 0;
  result := 0;
  VpfPlanoContasAtual := '';
  with RVSystem.BaseReport do begin
    RestoreTabs(4);
    NewLine;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('CONTAS A PAGAR');
    NewLine;
    NewLine;
    Bold := false;
    FontSize := 10;
    while not Tabela.Eof  do
    begin
      if VpfPlanoContasAtual <> Tabela.FieldByName('C_CLA_PLA').AsString then
      begin
        if VpfDClassificacao <> nil then
          VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;

        VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString,true);
        ImprimetituloPlanoContas(VprNiveis,VpfPlanoContasAtual = '');
        VpfPlanoContasAtual := Tabela.FieldByName('C_CLA_PLA').AsString;
        VpfValDuplicata := 0;
      end;
      PrintTab(Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString);
      PrintTab(Tabela.FieldByName('I_NRO_NOT').AsString);
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_EMI').AsDatetime));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALDESPESA').AsFloat));
      PrintTab(FormatFloat('##0.00 %',Tabela.FieldByName('PERDESPESA').AsFloat));

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      VpfValDuplicata := VpfValDuplicata + Tabela.FieldByName('VALDESPESA').AsFloat;
      result := result + Tabela.FieldByName('VALDESPESA').AsFloat;
      Tabela.next;
    end;

    if VpfDClassificacao <> nil then
      VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;
    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveisPlanoContas(VprNiveis,0);

    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    bold := true;
    PrintTab('Total Contas a Pagar');
    PrintTab('');
    bold := true;
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,result));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCustoTotalProjeto(VpaValor: Double);
begin
  with RVSystem.BaseReport do begin
    RestoreTabs(4);
    NewLine;
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('CUSTO TOTAL PROJETO : ' + FormatFloat('#,###,###,##0.00',VpaValor));
    NewLine;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelDemandaCompra(VpaObjeto: TObject);
var
  VpfQtdProduto,  VpfQtdGeral, VpfQtdConsumidoGeral, VpfQtdComprada : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual, VpfUM : string;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfQtdConsumidoGeral := 0;
  VpfClassificacaoAtual := '';
  VpfDClassificacao := nil;
  VpfDProduto := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if (VpfProdutoAtual <> 0) then
          SalvaTabelaProdutosDemandaCompra(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.QtdConsumido := VpfDClassificacao.QtdConsumido + VpfDProduto.QtdProduzido;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        if VpfDProduto <> nil then
          VpfDProduto.free;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('C_COD_UNI').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
      end;

      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('I_COD_TAM').AsInteger);

      VpfQtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
      CarQtdVendidaDemandaCompra(VpfDProduto,vpfDCor,VpfDTamanho,VprDatInicio,VprDatFim);
      VpfQtdComprada := VplFunPedidoCompra.RQtdProdutoAReceber(Tabela.FieldByname('I_SEQ_PRO').AsInteger,Tabela.FieldByname('I_COD_COR').AsInteger,Tabela.FieldByname('I_COD_TAM').AsInteger);

      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdProduto;
      VpfDProduto.QtdComprada := VpfDProduto.QtdComprada + VpfQtdComprada;
      vpfDCor.QtdEstoque := vpfDCor.QtdEstoque+ VpfQtdProduto;
      VpfDTamanho.QtdEstoque := VpfDTamanho.QtdEstoque + VpfQtdProduto;

      VpfQtdGeral := VpfQTdGeral +VpfQtdProduto;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosDemandaCompra(VpfDProduto);
    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.QtdConsumido := VpfDClassificacao.QtdConsumido + VpfDProduto.QtdProduzido;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    if config.EstoquePorCor then
      PrintTab('');
    if config.EstoquePorTamanho then
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfQtdConsumidoGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelEntradaMetros(VpaObjeto : TObject);
var
  VpfMetroAmostra, VpfMetrosPedido, VpfMetrosItem : Double;
  VpfTotMetroAmostra, VpfTotMetPedido, VpfMetrosTotal : Double;
  VpfValAmostra, VpfValPedido, VpfValItem  : Double;
  VpfTotValAmostra,VpfTotValPedido,VpfValTotal : Double;
  VpfCodClassificacao, VpfNomClassificacao : String;
begin
  VpfTotMetroAmostra :=0; VpfTotMetPedido :=0;VpfMetrosTotal:=0;
  VpfTotValAmostra := 0; VpfTotValPedido :=0;VpfValTotal:=0;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfCodClassificacao <> Tabela.FieldByName('CODCLASSIFICACAO').AsString then
      begin
        if VpfCodClassificacao <> '' then
        begin
          PrintTab('  '+VpfNomClassificacao);
          PrintTab(FormatFloat('#,###,###,##0.00',VpfMetroAmostra));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValAmostra));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosPedido));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValPedido));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosItem));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValItem));
        end;
        VpfMetroAmostra :=0;
        VpfMetrosPedido :=0;
        VpfMetrosItem := 0;
        VpfValAmostra := 0;
        VpfValPedido :=0;
        VpfValItem := 0;
        VpfCodClassificacao := Tabela.FieldByName('CODCLASSIFICACAO').AsString;
        VpfNomClassificacao := Tabela.FieldByName('C_NOM_CLA').AsString;
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
      end;
      VpfMetroAmostra := VpfMetroAmostra + Tabela.FieldByName('QTDMETROAMOSTRA').AsFloat;
      VpfMetrosPedido := VpfMetrosPedido + Tabela.FieldByName('QTDMETROPEDIDO').AsFloat;
      VpfMetrosItem := VpfMetrosItem + Tabela.FieldByName('QTDMETROTOTAL').AsFloat;
      VpfValAmostra := VpfValAmostra + Tabela.FieldByName('VALAMOSTRA').AsFloat;
      VpfValPedido := VpfValPedido + Tabela.FieldByName('VALPEDIDO').AsFloat;
      VpfValItem := VpfValItem + Tabela.FieldByName('VALTOTAL').AsFloat;
      VpfTotMetroAmostra := VpfTotMetroAmostra + Tabela.FieldByName('QTDMETROAMOSTRA').AsFloat;
      VpfTotMetPedido := VpfTotMetPedido + Tabela.FieldByName('QTDMETROPEDIDO').AsFloat;
      VpfMetrosTotal := VpfMetrosTotal + Tabela.FieldByName('QTDMETROTOTAL').AsFloat;
      VpfTotValAmostra := VpfTotValAmostra + Tabela.FieldByName('VALAMOSTRA').AsFloat;
      VpfTotValPedido := VpfTotValPedido + Tabela.FieldByName('VALPEDIDO').AsFloat;
      VpfValTotal := VpfValTotal + Tabela.FieldByName('VALTOTAL').AsFloat;
      Tabela.next;
    end;
    if VpfCodClassificacao <> '' then
    begin
      PrintTab('  '+VpfNomClassificacao);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfMetroAmostra));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValAmostra));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosPedido));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValPedido));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosItem));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValItem));
      NewLine;
    end;
    bold := true;
    PrintTab('  TOTAL');
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotMetroAmostra));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotValAmostra));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotMetPedido));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotValPedido));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosTotal));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotal));
    NewLine;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelExtratoProdutividade(VpaObjeto : TObject);
var
  VpfDia, VpfCelulaTrabalhoAtual, VpfLaco,VpfQtdColetas : Integer;
  VpfValTotal : Double;
begin
  VpfDia := 1;
  VpfCelulaTrabalhoAtual := 0;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfCelulaTrabalhoAtual <> Tabela.FieldByName('CODCELULA').AsInteger then
      begin
        if VpfCelulaTrabalhoAtual <> 0 then
        begin
          ImprimeTotalCelulaTrabalho(VpfValTotal/VpfQtdColetas,VpfDia);
        end;
        VpfDia := 0;
        VpfQtdColetas := 0;
        VpfValTotal := 0;
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
        VpfCelulaTrabalhoAtual := Tabela.FieldByName('CODCELULA').AsInteger;
        PrintTab('  '+Tabela.FieldByName('NOMCELULA').AsString );
      end;
      inc(VpfQtdColetas);
      VpfValTotal := VpfValTotal +Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat;

      if (VpfDia +1) = DIA(Tabela.FieldByName('DATPRODUTIVIDADE').AsDateTime) then
        inc(VpfDia);
      for VpfDia := VpfDia to DIA(Tabela.FieldByName('DATPRODUTIVIDADE').AsDateTime)-2 do
        PrintTab('');
      VpfDia := DIA(Tabela.FieldByName('DATPRODUTIVIDADE').AsDateTime);
      if (Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat < 50) then
        FontColor := clRed
      else
        if (Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat > 100) then
          FontColor := clGreen;
      PrintTab(FormatFloat('0',Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat));
      FontColor := clBlack;
      Tabela.next;
    end;
    if VpfCelulaTrabalhoAtual <> 0 then
    begin
      ImprimeTotalCelulaTrabalho(VpfValTotal/VpfQtdColetas,VpfDia);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalho(VpaObjeto : TObject);
var
  VpfLaco : Integer;
  VpfQtdLinhasCabecalho : Integer;
begin
   with RVSystem.BaseReport do begin
    SetFont('Arial',16);
    MarginTop := 0.5;
    Home;
    Bold := true;
    PrintHeader(VprNomeRelatorio, pjCenter);
    Bold := false;
    if VprCabecalhoDireito.count > VprCabecalhoEsquerdo.count then
      VpfQtdLinhasCabecalho := VprCabecalhoDireito.count
    else
      VpfQtdLinhasCabecalho := VprCabecalhoEsquerdo.count;

    SetFont('Arial',10);
    for VpfLaco := 0 to VpfQtdLinhasCabecalho - 1 do
    begin
      MarginTop := MarginTop+LineHeight;
      Home;
       if VpfLaco <= VprCabecalhoEsquerdo.count -1 then
         PrintHeader(VprCabecalhoEsquerdo.Strings[VpfLaco], pjLeft);
       if VpfLaco <= VprCabecalhoDireito.count -1 then
         PrintHeader(VprCabecalhoDireito.Strings[VpfLaco], pjRight);
    end;
    // Traca uma linha
    Canvas.Pen.Width := 7;
    Canvas.Pen.Color := clBlack;
    MoveTo(MarginLeft,YPos+0.1);
    LineTo(PageWidth-MarginRight,YPos+0.1);
     MarginTop := MarginTop+LineHeight+0.2;
     Home;
     AdjustLine;
     case RvSystem.Tag of
       1,2,4,6,11,19,41,48 : ImprimeTituloClassificacao(VprNiveis,true);
       3,25,37 : ImprimeCabecalhoAnaliseFaturamento;
       8 : ImprimeCabecalhoEntradaMetros;
       9 : ImprimeCabecalhoExtratoProdutividade;
      10 : ImprimeCabecalhoCustoProjeto;
      13 : ImprimeCabecalhoTotalAmostrasVendedor;
      14 : ImprimeCabecalhoPorPlanoContasSintetico;
      17 : ImprimeCabecalhoPorPlanoContasSinteticoporMes;
      18 : ImprimeCabecalhoTotalTipoPedidoXCusto;
      20 : ImprimeCabecalhoResumoCaixas;
      21 : ImprimeCabecalhoRomaneioEtikArt;
      23 : ImprimeCabecalhoRomaneioCotacao;
      24 : ImprimeCabecalhoAnaliseContrato;
      26 : ImprimeCabecalhoCartuchosPesadosPorCelula;
      27 : ImprimeCabecalhoPagamentoFaccionista;
      28 : ImprimeCabecalhoAmostrasPorDesenvolverdor;
      31 : ImprimeCabecalhoResultadoFinanceiroOrcado;
      32 : ImprimeCabecalhoClientesXCobrancaporBairro;
      34 : ImprimeCabecalhoPedidosAtrasados;
      35 : ImprimeCabecalhoPrazoEntregaRealProdutos;
      36 : ImprimeCabecalhoConsumoAmostras;
      38 : ImprimeCabecalhoLivroRegistroSaida;
      39 : ImprimeCabecalhoFluxoCaixaDiario;
      40 : ImprimeCabecalhoProdutoFaturadosSTComTributacao;
      44 : ImprimeCabecalhoAnaliseRenovacaoContrato;
      46 : ImprimeCabecalhoCreditoCliente;
      49 : ImprimeCabecalhoValorFreteNotaXValorConhecimento;
      51 : ImprimeCabecalhoProdutoFornecedor;
     end;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRodape(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do
  begin
    if RvSystem.SystemPrinter.Orientation = poPortrait then
    begin
      MoveTo(0,28.5);
      LineTo(21,28.5);
      YPos := 29.0;
    end
    else
    begin
      MoveTo(0,20);
      LineTo(30,20);
      YPos := 20.5;
    end;
    SetFont('Arial',10);
    Bold := False;
    PrintLeft('Data Impressao : '  + FormatDatetime('DD/MM/YYYY - HH:MM:SS',NOW),0.3);
    Printright('Página ' + Macro(midCurrentPage) + ' de ' +
                Macro(midTotalPages),PageWidth-0.5);
    SetFont('Arial',4);
    PrintCenter(VprCaminhorelatorio,PageWidth/2);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.EnviaParametrosDuplicata(VpaProjeto: TrvProject; VpaDDuplicata: TDadosDuplicata);
begin
  VpaProjeto.SetParam('VALEXTENSO',VpaDDuplicata.DescValor1 + ' ' + VpaDDuplicata.DescValor2);
  VpaProjeto.SetParam('NRODUPLICATA',VpaDDuplicata.Numero);
  VpaProjeto.SetParam('VALORTOTAL',FormatFloat('#,##0.00', VpaDDuplicata.ValorTotal));
  VpaProjeto.SetParam('NRORDEM',VpaDDuplicata.NroOrdem);
  VpaProjeto.SetParam('VALOR',FormatFloat('#,##0.00', VpaDDuplicata.Valor));
  VpaProjeto.SetParam('EMISSAO',FormatDateTime('dd/mm/yyyy', VpaDDuplicata.DataEmissao));
  VpaProjeto.SetParam('VENCIMENTO',FormatDateTime('dd/mm/yyyy', VpaDDuplicata.DataVencimento));
  VpaProjeto.SetParam('CODSACADO', VpaDDuplicata.Cod_Sacado);
  VpaProjeto.SetParam('NOMESACADO', VpaDDuplicata.NomeSacado);
  VpaProjeto.SetParam('ENDSACADO', VpaDDuplicata.EnderecoSacado);
  VpaProjeto.SetParam('BAISACADO', VpaDDuplicata.Bairro);
  VpaProjeto.SetParam('CEPSACADO', VpaDDuplicata.CEP);
  VpaProjeto.SetParam('UFSACADO', VpaDDuplicata.EstadoSacado);
  VpaProjeto.SetParam('MUNICIPIOSACADO', VpaDDuplicata.CidadeSacado);
  VpaProjeto.SetParam('PRACAPAGTOSACADO', VpaDDuplicata.PracaPagto);
  VpaProjeto.SetParam('CPFCNPJ', VpaDDuplicata.InscricaoCGC);
  VpaProjeto.SetParam('IE', VpaDDuplicata.InscricaoEstadual);
end;

{******************************************************************************}
procedure TRBFunRave.EnviaParametrosFilial(VpaProjeto: TrvProject;VpaDFilial : TRBDFilial );
begin
  vpaProjeto.clearParams;
  VpaProjeto.SetParam('CODFILIAL',IntToStr(VpaDFilial.CodFilial));
  VpaProjeto.SetParam('NOMFILIAL',VpaDFilial.NomFantasia);
  VpaProjeto.SetParam('ENDFILIAL',VpaDFilial.DesEndereco);
  VpaProjeto.SetParam('BAIFILIAL',VpaDFilial.DesBairro);
  VpaProjeto.SetParam('CIDFILIAL',VpaDFilial.DesCidade+'/'+VpaDFilial.DesUF);
  VpaProjeto.SetParam('CEPFILIAL',VpaDFilial.DesCEP);
  VpaProjeto.SetParam('FONFILIAL',VpaDFilial.DesFone);
  VpaProjeto.SetParam('FAXFILIAL',VpaDFilial.DesFax);
  VpaProjeto.SetParam('SITFILIAL',Lowercase(VpaDFilial.DesSite));
  VpaProjeto.SetParam('EMAFILIAL',Lowercase(VpaDFilial.DESEMAIL));
  VpaProjeto.SetParam('CGCFILIAL',Lowercase(VpaDFilial.DesCNPJ));
  VpaProjeto.SetParam('IESFILIAL',Lowercase(VpaDFilial.DesInscricaoEstadual));
  VpaProjeto.SetParam('DATEMISSAO', DateToStr(now));
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutoVendidosPorClassificacao(VpaCodFilial,VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao, VpaCodClienteMaster : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial,VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao, VpaNomClienteMaster : String;VpaAgruparPorEstado,VpaConverterKilo, VpaPDF : Boolean);
begin
  RvSystem.Tag := 1;
  VprAgruparPorEstado := VpaAgruparPorEstado;
  VprConverterKilo := VpaConverterKilo;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UMPADRAO, PRO.N_PES_BRU,' +
                           ' MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.C_COD_UNI, MOV.I_SEQ_PRO, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' CLI.C_EST_CLI, '+
                           ' COR.NOM_COR ' +
                           ' FROM MOVORCAMENTOS MOV, CADORCAMENTOS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if VpaCodTipoCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
  if VpaCodClienteMaster <> 0  then
    AdicionaSqlTabela(Tabela,' and CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));

  if VpaAgruparPorEstado then
    AdicionaSqlTabela(Tabela,' ORDER BY CLI.C_EST_CLI, CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ')
  else
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaProdutosPorClassificacao;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeProdutoporClassificacao;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Vendidos por Classificação';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);
  if DeletaChars(VpaNomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);
  if VpaCodClienteMaster <> 0 then
    VprCabecalhoEsquerdo.add('Cliente Master : ' +VpaNomClienteMaster);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEstoqueProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados,VpaSomenteComQtd : Boolean;VpaOrdemRelatorio, VpaCodigoProduto : Integer);
begin
  RvSystem.Tag := 2;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, PRO.C_BAR_FOR, ' +
                           ' MOV.N_QTD_PRO,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');

  if VpaIndProdutosMonitorados  then
    AdicionaSQLTabela(Tabela,'and PRO.C_IND_MON = ''S''');
  if VpaSomenteComQtd then
    AdicionaSQLTabela(Tabela,' and MOV.N_QTD_PRO <> 0 ');
  if VpaCodigoProduto <> 0 then
    AdicionaSQLTabela(Tabela,' and PRO.I_SEQ_PRO = ' + IntToStr(VpaCodigoProduto));

  if VpaOrdemRelatorio = 0 then
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO ')
  else
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaEstoqueProdutos;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueProdutos;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Atual Produtos';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeAnaliseFaturamentoMensal(VpaCodFilial,VpaCodCliente,VpaCodVendedor, VpaCodPreposto, VpaCodTipCotacao: Integer;VpaCaminho, VpaNomFilial,VpaNomCliente,VpaNomVendedor, VpaNomPreposto, VpaNomTipoCotacao : String;VpaDatInicio, VpaDatFim : TDateTime;VpaNotasFiscais : Boolean);
begin
  RvSystem.Tag := 3;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprNotasFiscais := VpaNotasFiscais;
  VprCodTipoCotacao := VpaCodTipCotacao;
  VprFilial := VpaCodFilial;
  LimpaSQlTabela(Clientes);
  AdicionaSqltabela(Clientes,'SELECT VEN.C_NOM_VEN, VEN.I_COD_VEN, I_COD_CLI, C_NOM_CLI '+
                             ' FROM CADCLIENTES CLI, CADVENDEDORES VEN '+
                             ' WHERE '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN')+
                             ' AND CLI.C_IND_CLI = ''S''' +
                             ' AND VEN.C_IND_ATI = ''S''');
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_CLI = '+InttoStr(VpaCodCliente));

  if VpaCodVendedor <> 0  then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));

  if VpaCodPreposto <> 0  then
    AdicionaSqlTabela(Clientes,' and CLI.I_VEN_PRE = '+InttoStr(VpaCodPreposto));

  AdicionaSqlTabela(Clientes,'ORDER BY C_NOM_VEN, C_NOM_CLI');
  Clientes.open;
  VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
  RvSystem.SystemPrinter.Orientation := poLandScape;

  rvSystem.onBeforePrint := DefineTabelaAnaliseFaturamentoMensal;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAnaliseFaturamentoAnual;

  VprCaminhoRelatorio := VpaCaminho;
  if VpaNotasFiscais then
    VprNomeRelatorio := 'Analise Faturamento Anual'
  else
    VprNomeRelatorio := 'Analise Pedido Anual';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodCliente <> 0  then
    VprCabecalhoDireito.add('Cliente : ' +VpaNomCliente);
  if VpaCodTipCotacao <> 0 then
    VprCabecalhoDireito.Add('Tipo Cotação : '+VpaNomTipoCotacao);

  if VpaCodPreposto <> 0  then
    VprCabecalhoDireito.add('Preposto : ' +VpaNomPreposto);
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeQtdMinimasEstoque(VpaCodFilial, VpaCodFornecedor : Integer;VpaCaminho,VpaCodClassificacao,VpaNomFilial, VpaNomClassificacao, VpaNomFornecedor : String);
begin
  RvSystem.Tag := 4;
  FreeTObjectsList(VprNiveis);
  RvSystem.SystemPrinter.Orientation := poLandScape;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, ' +
                           ' MOV.N_QTD_PRO, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_COM, ' +
                           ' MOV.N_QTD_MIN, MOV.N_QTD_PED, '+
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR '+
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ');
  if VpaCodFornecedor <> 0 then
    AdicionaSqltabela(Tabela,', PRODUTOFORNECEDOR PFO');

  AdicionaSqltabela(Tabela,' WHERE PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND MOV.N_QTD_MIN > 0 '+
                           ' AND MOV.N_QTD_PRO < MOV.N_QTD_MIN');
  if VpaCodFornecedor <> 0 then
    AdicionaSqltabela(Tabela,' AND MOV.I_SEQ_PRO = PFO.SEQPRODUTO '+
                             ' AND MOV.I_COD_COR = PFO.CODCOR '+
                             ' AND PFO.CODCLIENTE = '+IntToStr(VpaCodFornecedor));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');


  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaQtdMinimas;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueMinimo;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Minimo';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
{  if DeletaChars(VpaomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);}

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);
  if VpaNomFornecedor <> ''  then
    VprCabecalhoDireito.add('Fornecedor : ' +VpaNomFornecedor+ '   ');
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEstoqueFiscalProdutos(VpaCodFilial: Integer;VpaCaminho, VpaCodClassificacao, VpaTipoRelatorio, VpaNomFilial, VpaNomClassificacao: String; VpaIndProdutosMonitorados: Boolean);
begin
  RvSystem.Tag := 5;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, ' +
                           ' MOV.N_QTD_PRO,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' MOV.N_QTD_FIS, '+
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');

  if VpaIndProdutosMonitorados  then
    AdicionaSQLTabela(Tabela,'and PRO.C_IND_MON = ''S''');

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaEstoqueProdutos;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueProdutos;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Atual Produtos';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeFechamentoMes(VpaCodFilial: Integer; VpaCaminho,VpaNomFilial: String; VpaData: TDateTime;VpaMostarTodos : Boolean);
begin
  RvSystem.Tag := 6;
  VprTodosProdutos := VpaMostarTodos;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select CLA.C_COD_CLA, CLA.C_NOM_CLA, '+
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                           ' MOV.N_VLR_COM, '+
                           ' SUE.I_EMP_FIL, SUE.N_QTD_PRO, SUE.N_VLR_CMV, SUE.N_VLR_VEN_MES, '+
                           ' SUE.N_QTD_VEN_MES, SUE.N_VLR_DEV_VEN, SUE.N_QTD_DEV_VEN, '+
                           ' SUE.I_MES_FEC, SUE.I_ANO_FEC, SUE.N_QTD_ANT, SUE.C_REL_PRO, '+
                           ' SUE.N_VLR_VEN_LIQ '+
                           ' FROM CADCLASSIFICACAO CLA, CADPRODUTOS PRO, MOVQDADEPRODUTO MOV, MOVSUMARIZAESTOQUE SUE '+
                           ' Where PRO.I_COD_EMP = CLA.I_COD_EMP '+
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND PRO.I_SEQ_PRO = MOV.I_SEQ_PRO '+
                           ' AND SUE.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                           ' AND SUE.C_REL_PRO = ''S'''+
//                           ' and cla.c_cod_cla like ''02308%'''+
                           ' AND SUE.I_MES_FEC = '+IntToStr(Mes(VpaData))+
                           ' AND SUE.I_ANO_FEC = '+IntToStr(Ano(VpaData))+
                           ' AND SUE.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                           ' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO ');

  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaFechamentoEstoque;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelFechamentoEstoque;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Fechamento Mensal';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeContasAPagarPorPlanodeContas(VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : String;VpfTipoPeriodo : Integer);
var
  VpfCampoData : String;
begin
  case VpfTipoPeriodo of
    0 : VpfCampoData := 'CAD.D_DAT_EMI';
    1 : VpfCampoData := 'MOV.D_DAT_VEN';
    2 : VpfCampoData := 'MOV.D_DAT_PAG';
  else
    VpfCampoData := 'CAD.D_DAT_EMI';
  end;
  RvSystem.Tag := 7;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select  PLA.N_VLR_PRE, PLA.C_CLA_PLA, PLA.C_NOM_PLA, '+
                           ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                           ' CAD.I_NRO_NOT , '+
                           ' MOV.I_EMP_FIL , MOV.D_DAT_VEN, MOV.N_VLR_DUP, MOV.D_DAT_PAG, MOV.N_VLR_PAG , MOV.I_NRO_PAR '+
                           ' from CAD_PLANO_CONTA PLA, CADCLIENTES CLI, CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
                           ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                           ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND CAD.C_CLA_PLA = PLA.C_CLA_PLA '+
                           SQLTextoDataEntreAAAAMMDD(VpfCampoData,VpaDatInicio,VpaDatFim,true));

  if VpaCodFilial <> 0 then
    AdicionaSqlTabela(Tabela,'and MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial));

  AdicionaSqlTabela(Tabela,' ORDER BY PLA.C_CLA_PLA, CLI.C_NOM_CLI');

  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContas;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContas;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Contas a Pagar Analítico por Plano de Contas';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEntradaMetros(VpaDatInicio, VpaDatFim : TDateTime);
begin
  RvSystem.Tag := 8;
  RvSystem.SystemPrinter.Orientation := poLandScape;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqlAbreTabela(Tabela,'SELECT MET.DATENTRADA, MET.CODCLASSIFICACAO, MET.QTDMETROAMOSTRA, MET.QTDMETROPEDIDO, MET.QTDMETROTOTAL, '+
                                  ' MET.VALAMOSTRA, MET.VALPEDIDO, MET.VALTOTAL, '+
                                  ' CLA.C_NOM_CLA '+
                                  ' FROM  ENTRADAMETRODIARIO MET, CADCLASSIFICACAO CLA '+
                                  ' WHERE MET.CODCLASSIFICACAO = CLA.C_COD_CLA '+
                                  ' AND CLA.C_TIP_CLA = ''P'''+
                                  ' ORDER BY CODCLASSIFICACAO');


  rvSystem.onBeforePrint := DefineTabelaEntradaMetro;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEntradaMetros;

//  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Entrada de Metros';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Período : ' +FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' - '+FormatDateTime('DD/MM/YYYY',VpaDatFim));

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeExtratoProdutividade(VpaCaminho : String;VpaData : TDateTime);
begin
  RvSystem.Tag := 9;
  VprMes := Mes(VpaData);
  VprAno := Ano(VpaData);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select CEL.CODCELULA, CEL.NOMCELULA, '+
                             ' TRA.DATPRODUTIVIDADE, TRA.PERPRODUTIVIDADE '+
                             ' from CELULATRABALHO CEL, PRODUTIVIDADECELULATRABALHO TRA '+
                             ' Where CEL.CODCELULA = TRA.CODCELULA'+
                              SQLTextoDataEntreAAAAMMDD('TRA.DATPRODUTIVIDADE',PrimeiroDiaMes(VpaData),UltimoDiaMes(VpaData),true));

  AdicionaSqlTabela(Tabela,'ORDER BY CEL.NOMCELULA, TRA.DATPRODUTIVIDADE');
  Tabela.open;
  RvSystem.SystemPrinter.Orientation := poLandScape;

  rvSystem.onBeforePrint := DefineTabelaExtratoProdutividade;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelExtratoProdutividade;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtividade Diária';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Mês : ' +IntToStr(Mes(VpaData)));

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCustoProjeto(VpaCodProjeto: Integer; VpaCaminho, VpaNomProjeto: String);
begin
  RvSystem.Tag := 10;
  VprCodProjeto := VpaCodProjeto;
  VprImprimindoConsumoOP := false;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select  PLA.C_CLA_PLA, PLA.C_NOM_PLA, '+
                           ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                           ' CAD.I_NRO_NOT , CAD.D_DAT_EMI, '+
                           ' CPR.VALDESPESA, CPR.PERDESPESA '+
                           ' from CAD_PLANO_CONTA PLA, CADCLIENTES CLI, CADCONTASAPAGAR CAD, CONTAAPAGARPROJETO CPR '+
                           ' Where CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND CAD.C_CLA_PLA = PLA.C_CLA_PLA '+
                           ' AND CAD.I_EMP_FIL = CPR.CODFILIAL '+
                           ' AND CAD.I_LAN_APG = CPR.LANPAGAR '+
                           ' AND CPR.CODPROJETO = '+IntToStr(VpaCodProjeto));
  AdicionaSqlTabela(Tabela,' ORDER BY PLA.C_CLA_PLA, CLI.C_NOM_CLI');
  Tabela.open;
  RvSystem.SystemPrinter.Orientation := poPortrait;

  rvSystem.onBeforePrint := DefineTabelaCustoProjeto;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCustoProjeto;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Custo Projeto';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Projeto : ' +IntToStr(VpaCodProjeto)+'-'+VpaNomProjeto);
  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTabelaPreco(VpaCodCliente, VpaCodTabelaPreco: Integer; VpaCaminho, VpaNomCliente, VpaNomTabelaPreco,VpaCodClassificacao, VpaNomClassificacao: String;VpaAgruparClassificacao : Boolean;VpaOrdemRelatorio : Integer);
begin
  RvSystem.Tag := 11;
  FreeTObjectsList(VprNiveis);
  VprAgruparClassificacao := VpaAgruparClassificacao;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, '+
                           ' PRE.C_CIF_MOE, PRE.N_VLR_VEN VLRVENDA, '+
                           ' TAM.CODTAMANHO, TAM.NOMTAMANHO, '+
                           ' COR.COD_COR, COR.NOM_COR '+
                           ' from MOVTABELAPRECO PRE, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR '+
                           ' Where PRE.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND PRO.I_COD_EMP = PRE.I_COD_EMP '+
                           ' AND PRO.C_ATI_PRO = ''S'''+
                           ' AND PRO.IMPPRE = ''S'''+
                           ' AND '+SQLTextoRightJoin('PRE.I_COD_TAM','TAM.CODTAMANHO')+
                           ' AND '+SQLTextoRightJoin('PRE.I_COD_COR','COR.COD_COR')+
                           ' AND PRE.I_COD_EMP =  '+IntTostr(Varia.CodigoEmpresa)+
                           ' AND PRE.I_COD_CLI =  '+IntToStr(VpaCodCliente)+
                           ' AND PRE.I_COD_TAB = '+IntToStr(VpaCodTabelaPreco));
  if VpaCodClassificacao <> '' then
    AdicionaSqltabela(Tabela,'AND PRO.C_COD_CLA LIKE '''+VpaCodClassificacao+'%''');

  if VpaAgruparClassificacao then
  begin
    if VpaOrdemRelatorio = 1  then
      AdicionaSqltabela(Tabela,' ORDER BY PRO.C_COD_CLA, PRO.C_COD_PRO, COR.COD_COR, TAM.CODTAMANHO')
    else
      AdicionaSqltabela(Tabela,' ORDER BY PRO.C_COD_CLA, PRO.C_NOM_PRO, COR.COD_COR, TAM.CODTAMANHO');
  end
  else
  begin
    if VpaOrdemRelatorio = 1  then
      AdicionaSqltabela(Tabela,' ORDER BY PRO.C_COD_PRO, COR.COD_COR, TAM.CODTAMANHO')
    else
      AdicionaSqltabela(Tabela,' ORDER BY PRO.C_NOM_PRO, COR.COD_COR, TAM.CODTAMANHO');
  end;

  Tabela.open;
  RvSystem.SystemPrinter.Orientation := poPortrait;

  rvSystem.onBeforePrint := DefineTabelaTabelaPreco;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelTabelaPreco;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Tabela de Preço';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Tabela : ' +IntToStr(VpaCodTabelaPreco)+'-'+VpaNomTabelaPreco);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> '' then
    VprCabecalhoDireito.Add(VpaNomClassificacao);
  if (VpaCodCliente <> 0) then
    VprCabecalhoDireito.Add(VpaNomCliente);
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEstoqueProdutosReservados(VpaCodFilial: Integer; VpaCaminho, VpaCodClassificacao, VpaTipoRelatorio, VpaNomFilial,VpaNomClassificacao: String; VpaIndProdutosMonitorados: Boolean);
begin
  RvSystem.Tag := 12;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, PRO.C_BAR_FOR, ' +
                           ' MOV.N_QTD_RES,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND MOV.N_QTD_RES <> 0 ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');

  if VpaIndProdutosMonitorados  then
    AdicionaSQLTabela(Tabela,'and PRO.C_IND_MON = ''S''');

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaEstoqueProdutos;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueProdutos;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Atual Produtos Reservados';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotaAmostrasPorVendedor(VpaCodVendedor: Integer; VpaCaminho, VpaNomVendedor: String; VpaDatInicio,VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 13;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  VprDatInicio :=  VpaDatInicio;
  VprDatFim :=  VpaDatFim;
  AdicionaSqltabela(Tabela,'Select I_COD_VEN, C_NOM_VEN '+
                           ' FROM CADVENDEDORES '+
                           ' Where C_IND_ATI = ''S''');
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(Tabela,' and I_COD_VEN = '+InttoStr(VpaCodVendedor));

  AdicionaSqlTabela(Tabela,' ORDER BY C_NOM_VEN ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaTotalAmostraporVendedor;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelTotalAmostrasVendedor;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Amostras por Vendedor';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Periodo de ' + FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+ FormatDateTime('DD/MM/YYYY',VpaDatFim));
  if  VpaCodVendedor <> 0 then
    VprCabecalhoEsquerdo.add('Vendedor : ' +VpaNomVendedor);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;


{******************************************************************************}
procedure TRBFunRave.ImprimeContasAPagarPorPlanoContasSintetico(VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho : String);
begin
  VprCampoData := 'CAD.D_DAT_EMI';
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  RvSystem.Tag := 14;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT * FROM CAD_PLANO_CONTA '+
                           ' WHERE C_TIP_PLA = ''D'''+
                           ' and I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                           ' ORDER BY C_CLA_PLA');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContasSintetico;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContasSintetico;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Contas a Pagar Sintetico por Plano de Contas';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de ' +FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim)+'  ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeFichaAmosta(VpaDAmostra: TRBDAmostra);
begin
  RvSystem.Tag := 15;
  FreeTObjectsList(VprNiveis);

  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContasSintetico;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContasSintetico;

  VprNomeRelatorio := 'Ficha Amostra';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeInstalacaoTearCadarcoFita(VpaDProduto: TRBDProduto);
Var
  VpfTamanhoLinha, VpfLinhaInicial, VpfLinhaFinal, VpfColunaInicial, VpfAlturaLinha : double;
  VpfDInstalacao : TRBDProdutoInstalacaoTear;
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
  VpfLaco : Integer;
begin
  FunProdutos.CarDProdutoInstalacaoTear(VpaDProduto,nil);
  if VpaDProduto.InstalacaoTear.Count > 0 then
  begin
    VpfDInstalacao := TRBDProdutoInstalacaoTear(VpaDProduto.InstalacaoTear.Items[VpaDProduto.InstalacaoTear.Count -1]);
    VpfTamanhoLinha := (VpfDInstalacao.NumColuna * 0.5)+0.5;
    with RVSystem.BaseReport do
    begin
      newline;
      newline;
      VpfColunaInicial := PageWidth-MarginRight - VpfTamanhoLinha-1;
      VpfLinhaInicial := YPos;
      VpfAlturaLinha := LineHeight;
      for VpfLaco := 1 to VpaDProduto.QtdQuadros do
      begin
        MoveTo(VpfColunaInicial,YPos+0.1);
        LineTo(PageWidth-MarginRight-1,YPos+0.1);
        PrintXY(PageWidth-MarginRight-1.3,YPos,AdicionaCharE(' ',IntToStr(VpaDProduto.QtdQuadros - VpfLaco+1),2));
        if VpfLaco = VpaDProduto.QtdQuadros then
          VpfLinhaFinal := YPos;
        newline;
      end;

      for VpfLaco := 0 to VpaDProduto.InstalacaoTear.Count - 1 do
      begin
        VpfDInstalacao := TRBDProdutoInstalacaoTear(VpaDProduto.InstalacaoTear.Items[VpfLaco]);
        SetBrush(clBlack, bsSolid, nil);
        Ellipse(VpfColunaInicial-0.2+(VpfDInstalacao.NumColuna*0.5),VpfLinhaInicial - VpfAlturaLinha +(VpfDInstalacao.NumLinha *VpfAlturaLinha )-0.1,VpfColunaInicial+(VpfDInstalacao.NumColuna*0.5)+0.05,VpfLinhaInicial - VpfAlturaLinha+(VpfDInstalacao.NumLinha *VpfAlturaLinha)+0.2);
        MoveTo(VpfColunaInicial+(VpfDInstalacao.NumColuna*0.5),VpfLinhaInicial - VpfAlturaLinha +(VpfDInstalacao.NumLinha *VpfAlturaLinha ));
        LineTo(VpfColunaInicial+(VpfDInstalacao.NumColuna*0.5),VpfLinhaFinal);
      end;

      for VpfLaco := 0 to VpaDProduto.DInstalacaoCorTear.Repeticoes.Count - 1 do
      begin
        VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VpaDProduto.DInstalacaoCorTear.Repeticoes.Items[VpfLaco]);
        MoveTo(VpfColunaInicial+((VpfDRepeticao.NumColunaInicial +1)*0.5)-0.15,VpfLinhaFinal-0.1);
        LineTo(VpfColunaInicial+((VpfDRepeticao.NumColunaInicial+1)*0.5),VpfLinhaFinal+0.3);
        MoveTo(VpfColunaInicial+((VpfDRepeticao.NumColunaInicial+1)*0.5),VpfLinhaFinal+0.3);
        LineTo(VpfColunaInicial+((VpfDRepeticao.NumColunaFinal +1)*0.5),VpfLinhaFinal+0.3);
        MoveTo(VpfColunaInicial+((VpfDRepeticao.NumColunaFinal+1)*0.5),VpfLinhaFinal+0.3);
        LineTo(VpfColunaInicial+((VpfDRepeticao.NumColunaFinal +1)*0.5)+0.15,VpfLinhaFinal-0.1);
        PrintXY(VpfColunaInicial+((VpfDRepeticao.NumColunaInicial+(VpfDRepeticao.NumColunaFinal - VpfDRepeticao.NumColunaInicial))*0.5),VpfLinhaFinal+0.7,IntToStr(VpfDRepeticao.QtdRepeticao)+'X');
      end;

    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutosVendidoseTrocacos(VpaCodFilial, VpaTipCotacao, VpaCodCliente, VpaCodVendedor, VpaCodClienteMaster: Integer;
  VpaCaminho, VpaNomFilial, VpaNomVendedor, VpaNomTipCotacao, VpaNomCliente, VpaNomClienteMaster : string; VpaDatInicio, VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 16;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprClienteMaster := VpaCodClienteMaster;
  VprCliente :=  VpaCodCliente;
  VprFilial := VpaCodFilial;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UMPADRAO, ' +
                           ' MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.C_COD_UNI, MOV.I_SEQ_PRO, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' CLI.C_EST_CLI, '+
                           ' COR.NOM_COR ' +
                           ' FROM MOVORCAMENTOS MOV, CADORCAMENTOS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaTipCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and CAD.I_TIP_ORC = '+InttoStr(VpaTipCotacao));
  if VpaCodClienteMaster <> 0  then
    AdicionaSqlTabela(Tabela,' and CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));


  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaProdutosVendidoseTrocados;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeProdutoporClassificacao;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Vendidos e Trocados';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);
  if DeletaChars(VpaNomTipCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipCotacao);
  if VpaCodClienteMaster <> 0 then
    VprCabecalhoEsquerdo.add('Cliente Master : ' +VpaNomClienteMaster);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeContasAPagarPorPlanoContasSinteticoMes(VpaTipoPeriodo, VpaCodFilial : Integer; VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho, VpaNomFilial: String);
begin
  case VpaTipoPeriodo of
    0 : VprCampoData := 'CAD.D_DAT_EMI';
    1 : VprCampoData := 'MOV.D_DAT_VEN';
    2 : VprCampoData := 'MOV.D_DAT_PAG';
  else
    VprCampoData := 'CAD.D_DAT_EMI';
  end;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprFilial := VpaCodFilial;
  RvSystem.Tag := 17;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Clientes);
  AdicionaSqltabela(Clientes,'SELECT * FROM CAD_PLANO_CONTA '+
                           ' WHERE C_TIP_PLA = ''D'''+
                           ' and I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                           ' ORDER BY C_CLA_PLA');
  Clientes.open;

  RvSystem.SystemPrinter.Orientation := poLandScape;
  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContasSinteticoporMes;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContasSinteticoporMes;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Contas a Pagar Sintetico por Mes e Plano de Contas';
  VprCabecalhoEsquerdo.Clear;
  if VpaCodFilial = 0 then
    VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa)
  else
    VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  case VpaTipoPeriodo of
    0 : VprCabecalhoEsquerdo.add('Periodo : Por Emissão');
    1 : VprCabecalhoEsquerdo.add('Periodo : Por Vencimento');
  else
    VprCabecalhoEsquerdo.add('Periodo : Por Emissão');
  end;

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de ' +FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim)+'  ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalTipoCotacaoXCusto(VpaCodFilial, VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao: Integer; VpaCaminho, VpaNomFilial, VpaNomCliente, VpaNomVendedor, VpaNomTipoCotacao: String; VpaDAtInicio, VpaDatFim: TDAteTime);
begin
  RvSystem.Tag := 18;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'select ORC.I_EMP_FIL, ORC.I_LAN_ORC, TIP.I_COD_TIP, N_VLR_LIQ, N_VLR_PRO, ORC.I_LAN_ORC QTD,  TIP.C_NOM_TIP  '+
                           ' from CADORCAMENTOS ORC, CADTIPOORCAMENTO TIP '+
                           ' Where ORC.I_TIP_ORC = TIP.I_COD_TIP '+
                            SQLTextoDataEntreAAAAMMDD('ORC.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and ORC.I_EMP_FIL = '+InttoStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and ORC.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and ORC.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if VpaCodTipoCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and ORC.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));

  AdicionaSqlTabela(Tabela,' ORDER BY TIP.I_COD_TIP ');

  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaTotalTipoCotacaoXCusto;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelTotalTipoCotacaoXCusto;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Valor ';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);
  if DeletaChars(VpaNomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalUFLivroSaida(VpaListaUF: TList);
var
  VpfDTotalUF : TRBDLivroSaidasTotalUFRave;
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;

    RestoreTabs(1);
    PrintTab('DEMONSTRATIVO POR ESTADO');
    Newline;
    Newline;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(4);

    for VpfLaco := 0 to VpaListaUF.Count - 1 do
    begin
      VpfDTotalUF := TRBDLivroSaidasTotalUFRave(VpaListaUF.Items[VpfLaco]);
      PrintTab(VpfDTotalUF.DesUF+' ');//Cfop
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalUF.ValContabil)+' ');
      PrintTab('');
      PrintTab(' ');//CFOP
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalUF.ValBaseICMS)+' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalUF.ValImposto)+' ');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDTotalUF.ValOutras)+' ');
      PrintTab('');
      newline;
      If LinesLeft<=1 Then
      begin
        NewPage;
        RestoreTabs(4);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutosFaturadoPorPeriodo(VpaObjeto: TObject);
var
  VpfQtdProduto,VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VprUfAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaProdutosFaturadosPorPeriodo(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
          VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
          VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
        end;

        if VprAgruparPorEstado and (VprUFAtual <> Tabela.FieldByName('C_EST_CLI').AsString)  then
        begin
          ImprimeTotaisNiveis(VprNiveis,0);
          ImprimeTituloUF(Tabela.FieldByName('C_EST_CLI').AsString);
          VprUFAtual := Tabela.FieldByName('C_EST_CLI').AsString;
          VpfClassificacaoAtual := '';
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('UMPADRAO').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
      end;
      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('I_COD_COR').AsInteger);

      if VprConverterKilo then
      begin
        VpfQtdProduto := FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
        VpfQtdProduto := VpfQtdProduto * Tabela.FieldByName('N_PES_BRU').AsFloat;
        VpfDProduto.DesUM := 'KG';
      end
      else
        VpfQtdProduto := FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdproduto;
      VpfDProduto.ValEstoque := VpfDProduto.ValEstoque + Tabela.FieldByName('N_TOT_PRO').AsFloat;

      vpfDCor.QtdEstoque := vpfDCor.QtdEstoque+ VpfQtdproduto;
      VpfDCor.ValEstoque := VpfDCor.ValEstoque + Tabela.FieldByName('N_TOT_PRO').AsFloat;

      VpfQtdGeral := VpfQTdGeral + VpfQtdProduto;
      VpfValGeral := VpfValGeral + Tabela.FieldByName('N_TOT_PRO').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosFaturadosPorPeriodo(VpfDProduto);

    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
      VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
      VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    if config.EstoquePorCor then
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutosVendidosComDefeito(VpaCodFilial, VpaCodCliente, VpaCodVendedor: Integer; VpaDatInicio, VpaDatFim: TDateTime;VpaCaminho, VpaNomFilial, VpaNomCliente, VpaNomVendedor, VpaCodClassificao, VpaNomClassificacao: String; VpaPDF: Boolean);
begin
  RvSystem.Tag := 19;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UMPADRAO, ' +
                           ' MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.C_COD_UNI, MOV.I_SEQ_PRO, ' +
                           ' CAD.I_TIP_ORC, '+
                           ' TAM.NOMTAMANHO, ' +
                           ' CLI.C_EST_CLI, '+
                           ' COR.NOM_COR ' +
                           ' FROM MOVORCAMENTOS MOV, CADORCAMENTOS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if VpaCodClassificao <> '' then
    AdicionaSqlTabela(Tabela,' and PRO.C_COD_CLA LIKE '''+VpaCodClassificao+'%''');

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaProdutosComDefeito;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelProdutosComDefeito;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Com Defeito';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;


{******************************************************************************}
procedure TRBFunRave.ImprimeResumosCaixas(VpaCaminho : String;VpaPDF: Boolean);
begin
  RvSystem.Tag := 20;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqlAbretabela(Tabela,'select CON.C_NRO_CON, CON.I_COD_BAN, CON.C_NOM_CRR, CON.C_NRO_AGE, CON.C_TIP_CON, CON.N_SAL_ATU, '+
                           ' BAN.C_NOM_BAN '+
                           ' from CADCONTAS CON, CADBANCOS BAN '+
                           ' WHERE CON.C_IND_ATI = ''T'''+
                           ' AND CON.I_COD_BAN = BAN.I_COD_BAN '+
                           ' ORDER BY I_COD_BAN, C_NOM_CRR');

  rvSystem.onBeforePrint := DefineTabelaResumoCaixas;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelResumoCaixas;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Resumo Caixas';
  VprCabecalhoEsquerdo.Clear;

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRomaneioEtikArt(VpaCodFilial, VpaSeqRomaneio: Integer; VpaVisualizar: Boolean);
begin
  RvSystem.Tag := 21;
  RvSystem.SystemPrinter.Orientation := poLandScape;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqlAbretabela(Tabela,'select PRO.C_NOM_PRO, ' +
                               ' OP.NUMPED, OP.CODPRO, OP.VALUNI, OP.TIPTEA, OP.SEQORD, '+
                               ' OPI.CODCOM, OPI.CODMAN, OPI.NROFIT, OPI.METCOL, (OPI.METCOL * OPI.NROFIT) / 1000 TOTALKM '+
                               ' from ORDEMPRODUCAOCORPO OP, COLETAOPITEM opi, CADPRODUTOS PRO, ROMANEIOITEM RIT '+
                               ' WHERE OPI.EMPFIL = OP.EMPFIL '+
                               ' AND OPI.SEQORD = OP.SEQORD '+
                               ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                               ' AND RIT.EMPFIL = OPI.EMPFIL '+
                               ' AND RIT.SEQORD = OPI.SEQORD '+
                               ' AND RIT.SEQCOL = OPI.SEQCOL '+
                               ' AND RIT.EMPFIL = '+IntToStr(VpaCodFilial)+
                               ' and rit.SEQROM = '+IntToStr(VpaSeqRomaneio)+
                               ' order by OP.NUMPED, OPI.CODCOM, OPI.CODMAN');

  rvSystem.onBeforePrint := DefineTabelaRomaneioEtikArt;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelRomaneioEtikArt;

  VprNomeRelatorio := 'Romaneio de Faturamento';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Romaneio : ' + inttoStr(VpaSeqRomaneio));

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeOrdemProducaoEtikArt(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta; VpaVisualizar: Boolean);
begin
  RvSystem.Tag := 22;
  VprDOPEtikArt := VpaDOrdemProducao;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);

  rvSystem.onBeforePrint := DefineTabelaOPEtikArt;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelOPEtikArt;

  VprNomeRelatorio := 'Romaneio de Faturamento';
  VprCabecalhoEsquerdo.Clear;

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRomaneioSeparacaoCotacao(VpaCotacoes: TList);
begin
  RvSystem.Tag := 23;
  FreeTObjectsList(VprNiveis);
  VprRomaneioProduto := TList.Create;
  VprCotacoes := VpaCotacoes;
  PreparaRomaneioCotacoes(VpaCotacoes,VprRomaneioProduto);

  rvSystem.onBeforePrint := DefineTabelaRomaneioSeparacaoCotacao;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelRomaneioSeparacaoCotacao;

  VprNomeRelatorio := 'Romaneio de Separação';
  VprCabecalhoEsquerdo.Clear;

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
  FreeTObjectsList(VprRomaneioProduto);
  VprRomaneioProduto.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimerRelOPFabricaCardarcodeFita(VpaObjeto: TObject);
var
  VpfEspacosCentraliza : String;
begin
  with RVSystem.BaseReport do
  begin
    NewLine;
    SetFont('Arial',12);
    RestoreTabs(1);
    bold := true;
    PrintTab('  INSTALAR NO TEAR N°:');

    NewLine;
    RestoreTabs(1);
    SetFont('Impact',10);
    VpfEspacosCentraliza := '                                                                               ';
    PrintTab(VpfEspacosCentraliza + VpfEspacosCentraliza  + ' FICHA PROGRAMAÇÃO');
    bold := false;
    SetFont('Arial',10);

    RestoreTabs(3);
    NewLine;
    PrintTab(' O.P.:');
    PrintTab(IntToStr(VprDOrdemProducao.SeqOrdem));  // NR OP
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab('  Entrada Pedido: ');
    PrintTab(' '+FormatDateTime('dd/mm/yyyy', VprDOrdemProducao.DatEmissao));

    NewLine;
    RestoreTabs(3);
    PrintTab(' Cliente:');
    PrintTab(' '+FunClientes.RNomCliente(IntToStr(VprDOrdemProducao.CodCliente)));  // NOME CLIENTE
    PrintTab(' Tear:');
    PrintTab('  ');

    PrintTab(' N° Ped.:');
    PrintTab(IntToStr(VprDOrdemProducao.NumPedido));  // Nr Pedido
    PrintTab(' Data de Entrega:');
    PrintTab(FormatDateTime('dd/mm/yyyy', VprDOrdemProducao.DatEntregaPrevista));  // Data Entrega

    NewLine;
    RestoreTabs(5);
    PrintTab(' Código:');
    PrintTab(VprDProduto.NomProduto);  // Cod Produto
    PrintTab(' N° de Fitas:');
    PrintTab(' ');
    PrintTab(' Tipo de Fundo: ');
    PrintTab(FunProdutos.RNomeFundo(IntToStr(VprDProduto.CodTipoFundo))); // fundo produto;
    PrintTab(' N° de Quadros:');
    PrintTab(IntToStr(VprDProduto.QtdQuadros)); // Nr de Quadros

    NewLine;
    RestoreTabs(6);
    PrintTab(' Engrenagens Bat.:');
    PrintTab('(1) ' + VprDProduto.Engrenagem + ' (2) 0'); //Engrenagens Bat.
    PrintTab(' Sistema');
    PrintTab('(1)'); // Sistema 1
    PrintTab('X');
    PrintTab('(2)'); // Sistema 2
    PrintTab(' ');
    PrintTab('Engrenagens Trama:');
    PrintTab('(1)');
    PrintTab('0'); // Engrenagens trama
    PrintTab('(2)');
    PrintTab('0'); // Engrenagens trama

    NewLine;
    RestoreTabs(7);
    PrintTab(' Bat. P/cm:');
    PrintTab(' 0'); // Bat. P/cm
    PrintTab(' Pente: ' + ''); // Pente

    NewLine;
    RestoreTabs(7);
    PrintTab(' N° de Liços:');
    PrintTab(' 0');  // Licos

    NewLine;
    RestoreTabs(9);
    PrintTab(' Largura da Fita em Baixo:');
    PrintTab(' ');
    PrintTab(' N° 1');
    PrintTab(' '); // n1
    PrintTab(' mm');
    PrintTab(' N° 2');
    PrintTab(' '); // n2
    PrintTab(' mm');
    PrintTab(' N° 3');
    PrintTab(' '); // n3
    PrintTab(' mm');
    PrintTab(' N° 4');
    PrintTab(' '); // n4
    PrintTab(' mm');
    PrintTab(' N° 5');
    PrintTab(' '); // n5
    PrintTab(' mm');

    NewLine;
    RestoreTabs(10);
    PrintTab(' N° 6');
    PrintTab(' '); // n6
    PrintTab(' mm');
    PrintTab(' N° 7');
    PrintTab(' '); // n7
    PrintTab(' mm');
    PrintTab(' N° 8');
    PrintTab(' '); // n8
    PrintTab(' mm');
    PrintTab(' N° 9');
    PrintTab(' '); // n9
    PrintTab(' mm');
    PrintTab(' N° 10');
    PrintTab(' '); // n10
    PrintTab(' mm');
    PrintTab(' N° 11');
    PrintTab(' '); // n11
    PrintTab(' mm');

    NewLine;
    RestoreTabs(8);
    PrintTab(' Calandrado:');
    PrintTab(' X');  // Sim
    PrintTab(' Sim');
    PrintTab(' ');
    PrintTab(' Não'); // Nao
    PrintTab(' Pré-Encolhido:');
    PrintTab(' '); // Sim
    PrintTab(' Sim');
    PrintTab(' X'); // Nao
    PrintTab(' Não');
    PrintTab(' Conferente:');
    PrintTab(' ');

    NewLine;
    RestoreTabs(2);
    PrintTab(' Fio Trama');
    PrintTab(' Fio Ajuda');

    NewLine;
    RestoreTabs(2);
    PrintTab(' Pol. [ ] Alg. [ ] Polia [ ] Polipr. [ ] Fio Costura [ ]');
    PrintTab(' Pol. [ ] Alg. [ ] Polia [ ] Polipr. [ ] Fio Costura [ ]');

    NewLine;
    RestoreTabs(2);
    PrintTab(' Fita N°                      |               ');
    PrintTab('                             |             ');

    NewLine;
    RestoreTabs(2);
    PrintTab(' Fita N°                      |               ');
    PrintTab('                             |             ');

    NewLine;
    RestoreTabs(2);
    PrintTab(' Fita N°                      |               ');
    PrintTab('                             |             ');

    NewLine;
    RestoreTabs(1);
    PrintTab(' OBS:');
  end;
  ImprimeInstalacaoTearCadarcoFita(VprDProduto);
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeAnaliseContratosLocacao(VpaCodTipoContrato, VpaCodCliente, VpaCodVendedor : Integer; VpaCaminho, VpaNomTipoCotrato, VpaNomVendedor, VpaNomCliente: string;VpaDatInicioAssinatura,VpaDatFimAssinatura : TDateTime; VpaSomenteNaoCancelados, VpaAnalitico : Boolean);
begin
  RvSystem.Tag := 24;
  VprAnalitico := VpaAnalitico;
  if VpaAnalitico then
    RvSystem.SystemPrinter.Orientation := poPortrait
  else
    RvSystem.SystemPrinter.Orientation := poLandScape;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                               ' FIL.C_NOM_FIL, '+
                               ' TIP.CODTIPOCONTRATO, TIP.NOMTIPOCONTRATO, '+
                               ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                               ' CON.CODFILIAL, CON.SEQCONTRATO, CON.NUMCONTRATO, CON.VALCONTRATO, CON.QTDMESES, '+
                               ' CON.DATASSINATURA, CON.DATCANCELAMENTO, CON.DATULTIMAEXECUCAO, CON.QTDFRANQUIA, '+
                               ' CON.VALEXCESSOFRANQUIA, CON.DESNOTACUPOM, CON.QTDFRANQUIACOLOR, CON.VALEXCESSOFRANQUIACOLOR '+
                               ' FROM CONTRATOCORPO CON, CADCLIENTES CLI, CADFILIAIS FIL, TIPOCONTRATO TIP, CADVENDEDORES VEN '+
                               ' WHERE CLI.I_COD_CLI = CON.CODCLIENTE '+
                               ' AND CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                               ' AND CON.CODFILIAL = FIL.I_EMP_FIL '+
                               ' AND CON.CODVENDEDOR = VEN.I_COD_VEN '+
                               SQLTextoDataEntreAAAAMMDD('CON.DATASSINATURA',VpaDatInicioAssinatura,VpaDatFimAssinatura,true));
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoDireito.Clear;
  VprCabecalhoEsquerdo.Add('Período de '+FormatDateTime('DD/MM/YYYY',VpaDatInicioAssinatura)+ ' até '+FormatDateTime('DD/MM/YYYY',VpaDatFimAssinatura));
  if VpaCodTipoContrato <> 0  then
  begin
    VprCabecalhoDireito.Add('Tipo Contrato : '+VpaNomTipoCotrato);
    AdicionaSqltabela(Tabela,'AND CON.CODTIPOCONTRATO = '+IntToStr(VpaCodTipoContrato));
  end;
  if VpaCodCliente <> 0  then
  begin
    VprCabecalhoEsquerdo.Add('Cliente : '+VpaNomCliente);
    AdicionaSqltabela(Tabela,'AND CON.CODCLIENTE = '+IntToStr(VpaCodCliente));
  end;
  if VpaCodVendedor <> 0  then
  begin
    VprCabecalhoDireito.Add('Vendedor : '+VpaNomVendedor);
    AdicionaSqltabela(Tabela,'AND CON.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
  end;
  if VpaCodCliente <> 0  then
  begin
    VprCabecalhoEsquerdo.Add('Cliente : '+VpaNomCliente);
    AdicionaSqltabela(Tabela,'AND CON.CODCLIENTE = '+IntToStr(VpaCodCliente));
  end;
  if VpaSomenteNaoCancelados  then
  begin
    VprCabecalhoEsquerdo.Add('Situação : Somente não Cancelados');
    AdicionaSqltabela(Tabela,'AND CON.DATCANCELAMENTO IS NULL ');
  end;

  AdicionaSqltabela(Tabela,'order by CLI.C_NOM_CLI, CON.CODTIPOCONTRATO, CON.CODVENDEDOR');
  Tabela.Open;
  rvSystem.onBeforePrint := DefineTabelaAnaliseLocacaoAnalitico;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAnaliseContratos;

  VprCaminhoRelatorio := VpaCaminho;
  if VpaAnalitico then
    VprNomeRelatorio := 'Analise Contratos Analítico'
  else
    VprNomeRelatorio := 'Analise Contratos Sintético';

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;


{******************************************************************************}
procedure TRBFunRave.ImprimeAnalisePedidosMensal(VpaCodFilial, VpaCodCliente,VpaCodVendedor, VpaCodPreposto, VpaCodTipoCotacao,VpaCodRepresentada: Integer; VpaCaminho,VpaNomFilial, VpaNomCliente, VpaNomVendedor, VpaNomPreposto, VpaNomTipoCotacao, VpaNomRepresentada: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 25;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprCodTipoCotacao := VpaCodTipoCotacao;
  VprCodRepresentada := VpaCodRepresentada;
  LimpaSQlTabela(Clientes);
  AdicionaSqltabela(Clientes,'SELECT VEN.C_NOM_VEN, VEN.I_COD_VEN, I_COD_CLI, C_NOM_CLI '+
                             ' FROM CADCLIENTES CLI, CADVENDEDORES VEN '+
                             ' WHERE '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN')+
                             ' AND CLI.C_IND_CLI = ''S''');
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_CLI = '+InttoStr(VpaCodCliente));

  if VpaCodVendedor <> 0  then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));

  if VpaCodPreposto <> 0  then
    AdicionaSqlTabela(Clientes,' and CLI.I_VEN_PRE = '+InttoStr(VpaCodPreposto));

  AdicionaSqlTabela(Clientes,'ORDER BY C_NOM_VEN, C_NOM_CLI');
  Clientes.open;
  VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
  RvSystem.SystemPrinter.Orientation := poLandScape;

  rvSystem.onBeforePrint := DefineTabelaAnaliseFaturamentoMensal;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAnalisePedidosRepresentadaAnual;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Analise Pedidos Representada Anual';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodTipoCotacao <> 0 then
    VprCabecalhoEsquerdo.Add('Tipo Cotação :'+ VpaNomTipoCotacao);
  VprCabecalhoDireito.Clear;
  if VpaCodCliente <> 0  then
    VprCabecalhoDireito.add('Cliente : ' +VpaNomCliente);

  if VpaCodPreposto <> 0  then
    VprCabecalhoDireito.add('Preposto : ' +VpaNomPreposto);
  if VpaCodVendedor <> 0 then
    VprCabecalhoDireito.Add('Vendedor : '+VpaNomVendedor);
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCartuchosPesadosPorCelulaTrabalho(VpaCodCelula, VpaSeqProduto: Integer; VpaCaminho, VpaNomCelula, VpaCodProduto, VpaNomProduto: String; VpaData: TDateTime);
begin
  RvSystem.Tag := 26;
  VprMes := Mes(VpaData);
  VprAno := Ano(VpaData);
  RvSystem.SystemPrinter.Orientation := poLandScape;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,' SELECT TRUNC(PES.DATPESO) DATPESO, CEL.CODCELULA,CEL.NOMCELULA, COUNT(*) QTD '+
                           '   FROM PESOCARTUCHO PES, CELULATRABALHO CEL '+
                           '  WHERE CEL.CODCELULA = PES.CODCELULA '+
                           SQLTextoDataEntreAAAAMMDD('PES.DATPESO', PrimeiroDiaMes(VpaData), incdia(UltimoDiaMes(VpaData),1), True));

  if VpaCodCelula <> 0 then
    AdicionaSqlTabela(Tabela,' AND CEL.CODCELULA = '+InttoStr(VpaCodCelula));
  if (VpaSeqProduto <> 0) then
    AdicionaSqlTabela(Tabela,' AND CEL.SEQPRODUTO = '+InttoStr(VpaSeqProduto));


  AdicionaSqlTabela(Tabela,'  GROUP BY' +
                           '  TRUNC(PES.DATPESO), CEL.CODCELULA, CEL.NOMCELULA ' +
                           '  ORDER BY ' +
                           '  3');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaCartuchosPesadosPorCelula;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCartuchosPesadosPorCelula;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Tabela Cartuchos Pesados por Celula';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Mês : ' +IntToStr(VprMes)+'/'+IntToStr(VprAno));
  if VpaCodCelula <> 0 then
    VprCabecalhoEsquerdo.Add('Celula Trabalho : '+ VpaNomCelula);

  VprCabecalhoDireito.Clear;
  if VpaSeqProduto <> 0  then
    VprCabecalhoDireito.add('Produto : ' +VpaNomProduto);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimePagamentoFaccionista(VpaCodFaccionista: Integer; VpaCaminho,VpaNomFaccionista: string; VpaDatInicio, VpaDatFim: tDateTime;VpaBuscanaEmpresa, VpaLevar, VpaTodos , VpaIndFuncionario,VpaIndNaoFuncionario: Boolean);
begin
  RvSystem.Tag := 27;
  if Varia.ModeloRelatorioFaccionista = mrModelo1Kairos then
    RvSystem.SystemPrinter.Orientation := poLandScape
  else
    if Varia.ModeloRelatorioFaccionista = mrModelo2Rafthel then
      RvSystem.SystemPrinter.Orientation := poPortrait;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'select RFF.SEQRETORNO, RFF.DATCADASTRO DATREAL, RFF.QTDRETORNO,  RFF.VALUNITARIO, FRF.DATRETORNO, '+
                              ' RFF.DATREVISADO, RFF.CODUSUARIOREVISAO, RFF.QTDREVISADO, RFF.QTDDEFEITO, '+
                              ' FRF.DATCADASTRO, FRF.CODFILIAL, FRF.SEQORDEM,FRF.SEQFRACAO, FRF.SEQESTAGIO, FRF.QTDENVIADO, '+
                              ' FRF.DESUM, FRF.CODFACCIONISTA, FRF.SEQITEM, FRF.INDDEFEITO, '+
                              ' FAC.NOMFACCIONISTA, '+
                              ' PRO.C_NOM_PRO, PRO.C_COD_PRO, '+
                              ' COR.NOM_COR, '+
                              ' ORD.SEQORD, ORD.NUMPED, '+
                              ' RFT.NOMTERCEIRO, RFT.QTDREVISADO QTDREVISADOTERCEIRO, RFT.QTDDEFEITO QTDDEFEITOTERCEIRO '+
                              ' from RETORNOFRACAOOPFACCIONISTA RFF, FRACAOOPFACCIONISTA FRF, FACCIONISTA FAC, ORDEMPRODUCAOCORPO ORD, RETORNOFRACAOOPFACTERCEIRO RFT, '+
                              ' CADPRODUTOS PRO, COR '+
                              ' Where RFF.CODFACCIONISTA = FRF.CODFACCIONISTA '+
                              ' AND RFF.SEQITEM = FRF.SEQITEM '+
                              ' AND FRF.CODFACCIONISTA = FAC.CODFACCIONISTA '+
                              ' AND FRF.CODFILIAL = ORD.EMPFIL '+
                              ' AND FRF.SEQORDEM = ORD.SEQORD '+
                              ' AND ORD.SEQPRO = PRO.I_SEQ_PRO '+
                              ' AND '+SQLTextoRightJoin('ORD.CODCOM','COR.COD_COR')+
                              ' AND '+SQLTextoRightJoin('RFF.CODFACCIONISTA','RFT.CODFACCIONISTA')+
                              ' AND '+SQLTextoRightJoin('RFF.SEQITEM','RFT.SEQITEM')+
                              ' AND '+SQLTextoRightJoin('RFF.SEQRETORNO','RFT.SEQRETORNO')+
                              SQLTextoDataEntreAAAAMMDD('RFF.DATCADASTRO',VpaDatInicio,incdia(VpaDatFim,1),true) );
  if VpaCodFaccionista <> 0 then
    AdicionaSqlTabeLa(Tabela,'AND FAC.CODFACCIONISTA = '+InttoStr(VpaCodFaccionista));
  if VpaBuscanaEmpresa then
    AdicionaSqlTabeLa(Tabela,'AND FAC.TIPDISTRIBUICAO = ''B''')
  else
    if VpaLevar then
      AdicionaSqlTabeLa(Tabela,'AND FAC.TIPDISTRIBUICAO = ''L''');
  if VpaIndFuncionario then
    AdicionaSqlTabeLa(Tabela,'AND FAC.INDFUNCIONARIO = ''S''')
  else
    if VpaIndNaoFuncionario then
      AdicionaSqlTabeLa(Tabela,'AND FAC.INDFUNCIONARIO = ''N''');

  AdicionaSqlTabeLa(Tabela,' ORDER BY FAC.NOMFACCIONISTA, RFT.NOMTERCEIRO, RFF.DATCADASTRO');
  Tabela.Open;

  rvSystem.onBeforePrint := DefineTabelaPagamentoFaccionista;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelPagamentoFaccionista;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Pagamento Faccionista';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Periodo de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));

  VprCabecalhoDireito.Clear;
  if VpaCodFaccionista <> 0 then
    VprCabecalhoDireito.add('Faccionista : ' +VpaNomFaccionista);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeAmostrasPorDesenvolverdor(VpaCodDesenvolvedor: Integer; VpaCaminho, VpaNomDesenvolvedor: String; VpaData: TDateTime);
begin
  RvSystem.Tag := 28;
  VprMes := Mes(VpaData);
  VprAno := Ano(VpaData);
  RvSystem.SystemPrinter.Orientation := poLandScape;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,' SELECT DES.NOMDESENVOLVEDOR, DES.CODDESENVOLVEDOR, ' +
                           '   TRUNC(AMO.DATAMOSTRA) DATAMOSTRA,' +
                           '   COUNT(AMO.CODAMOSTRA) QTD ' +
                           ' FROM AMOSTRA AMO, DESENVOLVEDOR DES ' +
                           ' WHERE AMO.TIPAMOSTRA =  ''D'' ' +
                           ' and DES.CODDESENVOLVEDOR <> '+IntToStr(varia.CodDesenvolvedorRequisicaoAmostra)+
                           'AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR '+
                           SQLTextoDataEntreAAAAMMDD('AMO.DATAMOSTRA', PrimeiroDiaMes(VpaData), incDia(UltimoDiaMes(VpaData),1), True));

  if VpaCodDesenvolvedor <> 0 then
    AdicionaSqlTabela(Tabela,' AND DES.CODDESENVOLVEDOR = '+InttoStr(VpaCodDesenvolvedor));

  AdicionaSqlTabela(Tabela,'  GROUP BY ' +
                           '  TRUNC(AMO.DATAMOSTRA), DES.NOMDESENVOLVEDOR, DES.CODDESENVOLVEDOR ' +
                           '  ORDER BY ' +
                           '  1');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaCartuchosPesadosPorCelula;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAmostrasPorDesenvolvedor;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Tabela Amostras por Desenvolvedor';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Mês : ' +IntToStr(VprMes)+'/'+IntToStr(VprAno));
  if VpaCodDesenvolvedor <> 0 then
    VprCabecalhoEsquerdo.Add('Desenvolvedor : '+ VpaNomDesenvolvedor);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalAmostrasPorClienteVendedor(VpaCodVendedor, VpaCodCliente: Integer; VpaCaminho, VpaNomVendedor, VpaNomCliente: String; VpaDatInicio,VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 29;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  VprDatInicio :=  VpaDatInicio;
  VprDatFim :=  VpaDatFim;
  VprCliente := VpaCodCliente;
  AdicionaSqltabela(Tabela,'Select I_COD_VEN, C_NOM_VEN '+
                           ' FROM CADVENDEDORES '+
                           ' Where C_IND_ATI = ''S''');
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(Tabela,' and I_COD_VEN = '+InttoStr(VpaCodVendedor));

  AdicionaSqlTabela(Tabela,' ORDER BY C_NOM_VEN ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaTotalAmostraPorClienteVendedor;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelTotalAmostrasClienteVendedor;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Amostras por Clientes X Vendedor';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Periodo de ' + FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+ FormatDateTime('DD/MM/YYYY',VpaDatFim));
  if  VpaCodVendedor <> 0 then
    VprCabecalhoEsquerdo.add('Vendedor : ' +VpaNomVendedor);

  VprCabecalhoDireito.Clear;
  if  VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalAnalisePedidoAnual(VpaDTotal: TRBDVendaCliente);
var
  VpfLacoAno,VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  with RVSystem.BaseReport do
  begin
    Bold := true;
    for VpfLacoAno := 0 to VpaDTotal.Anos.Count - 1 do
    begin
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      VpfDVendaAno := TRBDVendaClienteAno(VpaDTotal.Anos.Items[VpfLacoAno]);
      if VpfLacoAno = 0 then
        PrintTab('Total')
      else
        PrintTab('');
      PrintTab(IntToStr(VpfDVendaAno.Ano));
      for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
      begin
        VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
        if VpfDVendaMes.ValVenda <> 0 then
        begin
          if VpfDVendaMes.IndReducaoVenda then
            Italic := true;
          PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaMes.ValVenda))
        end
        else
          PrintTab('');
        Italic := false;
      end;
      if VpfDVendaAno.IndReducaoVenda  then
        bold := true;
      PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaAno.ValVenda));
      Bold := false;
    end;
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalAnaliseRenovacaoContratoTotalVendedor(VpaTotalVendedores: TList);
var
  VpfDTotalVendedor : TRBDTotalVendedorRave;
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    NewLine;
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    ImprimeCabecalhoTotalAnaliseRenovacaoContratoTotalVendedor;
    for VpfLaco := 0 to VpaTotalVendedores.Count - 1 do
    begin
      VpfDTotalVendedor := TRBDTotalVendedorRave(VpaTotalVendedores.Items[VpfLaco]);
      PrintTab(IntToStr(VpfDTotalVendedor.CodVendedor));
      PrintTab(VpfDTotalVendedor.NomVendedor);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDTotalVendedor.ValContratos));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfDTotalVendedor.ValRenovado));
      if VpfDTotalVendedor.ValContratos > 0 then
        PrintTab(FormatFloat('#,###,###,##0.00 %',(VpfDTotalVendedor.ValRenovado * 100)/VpfDTotalVendedor.ValContratos))
      else
        PrintTab('');
      NewLine;
      If LinesLeft<=1 Then
      begin
        NewPage;
        NewLine;
        NewLine;
        ImprimeCabecalhoTotalAnaliseRenovacaoContratoTotalVendedor;
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeOPFabricaCardarcodeFita(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer;VpaVisualizar: Boolean);
begin
  RvSystem.Tag := 30;
  VprDOrdemProducao := TRBDOrdemProducao.cria;
  FunOrdemProducao.CarDOrdemProducaoBasica(VpaCodFilial,VpaSeqOrdem,VprDOrdemProducao);

  VprDProduto := TRBDProduto.Cria;
  FunProdutos.CarDProduto(VprDProduto,Varia.CodigoEmpresa,VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqProduto);

  rvSystem.onBeforePrint := DefineTabelaOPFabricaCardarcodeFita;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimerRelOPFabricaCardarcodeFita;

  VprCaminhoRelatorio := '';
  VprNomeRelatorio := 'Ordem Produção';

  RvSystem.execute;

  VprDProduto.Free;
  VprDOrdemProducao.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeResultadoFinanceiroOrcado(VpaTipoPeriodo, VpaCodFilial : Integer;VpaMes: TDateTime; VpaCaminho, VpaNomFilial: string);
begin
  case VpaTipoPeriodo of
    0 : VprCampoData := 'CAD.D_DAT_EMI';
    1 : VprCampoData := 'MOV.D_DAT_VEN';
    2 : VprCampoData := 'MOV.D_DAT_PAG';
  else
    VprCampoData := 'CAD.D_DAT_EMI';
  end;
  VprDatInicio := PrimeiroDiaMes(VpaMes);
  VprDatFim := UltimoDiaMes(VpaMes);
  VprFilial := VpaCodFilial;
  RvSystem.Tag := 31;
  FreeTObjectsList(VprNiveis);

  RvSystem.SystemPrinter.Orientation := poPortrait;
  rvSystem.onBeforePrint := DefineTabelaResultadoFinanceiroOrcado;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelResultadoFinanceiroOrcado;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Resultado Financeiro Orçado';
  VprCabecalhoEsquerdo.Clear;
  case VpaTipoPeriodo of
    0 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Emissao');
    1 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Vencimento');
    2 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Pagamento');
  else
    VprCabecalhoEsquerdo.add('Periodo : Por Emissao');;
  end;
  if VpaCodFilial <> 0 then
    VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial)
  else
    VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Mes : '+ TextoMes(VpaMes,false)+' de '+InttoStr(Ano(VpaMes))+'   ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelatorioClientesXCobrancaporBairro(VpaCodVendedor, VpaCodSituacao, VpaCodRamoAtividade : Integer; VpaCaminho,   VpaNomVendedor, VpaNomSituacao, VpaNomRamoAtividade: string);
begin
  RvSystem.Tag := 32;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,' SELECT CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_COM_END, ' +
                           ' CLI.C_FO1_CLI, CLI.C_BAI_CLI '+
                           ' FROM CADCLIENTES CLI '+
                           ' WHERE C_IND_CLI = ''S''');

  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(Tabela,' AND CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if (VpaCodSituacao <> 0) then
    AdicionaSqlTabela(Tabela,' AND CLI.I_COD_SIT = '+InttoStr(VpaCodSituacao));
  if (VpaCodRamoAtividade <> 0) then
    AdicionaSqlTabela(Tabela,' AND CLI.I_COD_RAM = '+InttoStr(VpaCodRamoAtividade));


  AdicionaSqlTabela(Tabela,'  ORDER BY CLI.C_BAI_CLI, CLI.C_END_CLI, I_NUM_END');
  Tabela.open;


  RvSystem.SystemPrinter.Orientation := poPortrait;
  rvSystem.onBeforePrint := DefineTabelaClientesXCobrancaporBairro;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelClientesXCobrancaPorBairro;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Relação Cobrança';
  VprCabecalhoEsquerdo.Clear;
  if VpaCodVendedor <> 0 then
    VprCabecalhoEsquerdo.add('Vendedor : ' +VpaNomVendedor);
  if VpaCodRamoAtividade <> 0 then
    VprCabecalhoEsquerdo.add('Ramo Atividade : ' +VpaNomRamoAtividade);

  VprCabecalhoDireito.Clear;
  if VpaCodSituacao <> 0 then
    VprCabecalhoDireito.add('Situação Cliente : '+VpaNomSituacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeServicosVendidosPorClassificacao(VpaCodFilial, VpaCodCliente, VpaCodVendedor,VpaCodTipoCotacao, VpaCodClienteMaster: Integer; VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho, VpaNomFilial,VpaNomCliente, VpaNomVendedor, VpaNomTipoCotacao, VpaNomClienteMaster: String; VpaPDF: Boolean);
begin
  RvSystem.Tag := 33;
  VprServico := true;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' SER.I_COD_SER, SER.C_NOM_SER, ' +
                           ' SUM(MOV.N_QTD_SER) QTDSERVICO, SUM(MOV.N_VLR_TOT) VALSERVICO ' +
                           ' FROM MOVSERVICOORCAMENTO MOV, CADORCAMENTOS CAD, CADSERVICO SER, CADCLASSIFICACAO CLA, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_COD_SER = SER.I_COD_SER ' +
                           ' AND SER.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND SER.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND SER.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and SER.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if VpaCodTipoCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
  if VpaCodClienteMaster <> 0  then
    AdicionaSqlTabela(Tabela,' and CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));

  AdicionaSqlTabela(Tabela,' GROUP BY CLA.C_COD_CLA, CLA.C_NOM_CLA, SER.I_COD_SER, SER.C_NOM_SER '+
                           ' ORDER BY 1,3'  );
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaServicosVendidosPorClassificacao;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelSErvicoVendidoporClassificacao;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Vendidos por Classificação';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);
  if DeletaChars(VpaNomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);
  if VpaCodClienteMaster <> 0 then
    VprCabecalhoEsquerdo.add('Cliente Master : ' +VpaNomClienteMaster);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimePedidosAtrasados(VpaCodVendedor,
  VpaCodCliente, VpaCodFilial, VpaOrdena: integer; VpaNomVendedor, VpaNomCliente, VpaCaminho, VpaNomFilial: String; VpaDatInicio,
  VpaDatFim: TDateTime);
begin
  RvSystem.Tag:= 34;
  RvSystem.SystemPrinter.Orientation:= poPortrait;
  CarDPedidosAtrasados(VprPedidosAtrasados,VpaDatInicio,VpaDatFim,VpaCodFilial,VpaCodCliente,VpaCodVendedor, 'D_DAT_PRE');
  CarDPedidosAtrasadosOrcamentos(VprPedidosAtrasados,VpaDatInicio,VpaDatFim,VpaCodFilial,VpaCodCliente,VpaCodVendedor,'D_DAT_PRE');
  VprDTotalPedidosAtrasados := RTotaisPedidosAtrasados(VprPedidosAtrasados);

  if VpaOrdena = 0 then
    OrdenaPedidosAtrasadosDia(VprPedidosAtrasados)
  else
    OrdenaPedidosAtrasadosQtdPedido(VprPedidosAtrasados);
  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Entrega Produtos';
  rvSystem.onBeforePrint := DefineTabelaPedidosAtrasados;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelPedidosAtrasados;

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Periodo : ' +FormatDateTime('dd/mm/yyyy', VpaDatInicio) + ' ate ' + FormatDateTime('dd/mm/yyyy', VpaDatFim));
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);

  VprCabecalhoDireito.Clear;
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);
  if VpaCodFilial <> 0 then
    VprCabecalhoDireito.Add(('Filial : ' + VpaNomFilial));


  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimePrazoRealPedidos(VpaCodVendedor,
  VpaCodCliente, VpaCodFilial, VpaOrdena: integer; VpaNomVendedor, VpaNomCliente, VpaCaminho, VpaNomFilial: String; VpaDatInicio,
  VpaDatFim: TDateTime);
begin
  RvSystem.Tag:= 35;
  RvSystem.SystemPrinter.Orientation:= poPortrait;
  CarDPedidosAtrasados(VprPedidosAtrasados,VpaDatInicio,VpaDatFim,VpaCodFilial,VpaCodCliente,VpaCodVendedor, 'D_DAT_ORC');
  CarDPedidosAtrasadosOrcamentos(VprPedidosAtrasados,VpaDatInicio,VpaDatFim,VpaCodFilial,VpaCodCliente,VpaCodVendedor,'D_DAT_ORC');
  VprDTotalPedidosAtrasados := RTotaisPedidosAtrasados(VprPedidosAtrasados);

  if VpaOrdena = 0 then
    OrdenaPedidosAtrasadosDia(VprPedidosAtrasados)
  else
    OrdenaPedidosAtrasadosQtdPedido(VprPedidosAtrasados);
  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Prazo entrega real produtos ';
  rvSystem.onBeforePrint := DefineTabelaPedidosAtrasados;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelPedidosAtrasados;

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Periodo : ' +FormatDateTime('dd/mm/yyyy', VpaDatInicio) + ' ate ' + FormatDateTime('dd/mm/yyyy', VpaDatFim));
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);

  VprCabecalhoDireito.Clear;
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);
  if VpaCodFilial <> 0 then
    VprCabecalhoDireito.Add(('Filial : ' + VpaNomFilial));


  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeConsumoEntregaAmostra(VpaOrdena: integer;VpaCaminho: String; VpaDatInicio, VpaDatFim: TDateTime;VpaAnalitico : Boolean);
begin
  RvSystem.Tag:= 36;
  VprAnalitico := VpaAnalitico;
  RvSystem.SystemPrinter.Orientation:= poPortrait;
  CarDConsumoEntregaAmostras(VprConsumoAmostra,VpaDatInicio,VpaDatFim,'DATAMOSTRA');
  VprDTotalConsumoAmostra := RTotaisConsumoAmostraAtrasados(VprConsumoAmostra);

  if VpaOrdena = 0 then
    OrdenaConsumoAmostrasDia(VprConsumoAmostra)
  else
    OrdenaConsumoAmostrasQtdAmostra(VprConsumoAmostra);

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Consumo Entrega Amostras'; //
  rvSystem.onBeforePrint := DefineTabelaConsumoAmostras;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelConsumoAmostrasAtrasadas;

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Periodo : ' +FormatDateTime('dd/mm/yyyy', VpaDatInicio) + ' ate ' + FormatDateTime('dd/mm/yyyy', VpaDatFim));

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeAnalisePedidoporClassificacao(VpaCodFilial, VpaCodCliente, VpaCodVendedor, VpaCodPreposto,VpaCodTipoCotacao: Integer; VpaCaminho, VpaCodClassificacao, VpaNomClassificacao, VpaNomFilial, VpaNomCliente,VpaNomVendedor, VpaNomPreposto, VpaNomTipoCotacao: String; VpaDatInicio, VpaDatFim: TDateTime;VpaMostrarClassificacao :Boolean);
begin
  RvSystem.Tag := 37;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprCodTipoCotacao := VpaCodTipoCotacao;
  VprCodClassificacao := VpaCodClassificacao;
  VprMostraClassificacao := VpaMostrarClassificacao;
  VprQtdLetras := 3;
  LimpaSQlTabela(Clientes);
  AdicionaSqltabela(Clientes,'SELECT VEN.C_NOM_VEN, VEN.I_COD_VEN, I_COD_CLI, C_NOM_CLI '+
                             ' FROM CADCLIENTES CLI, CADVENDEDORES VEN '+
                             ' WHERE '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN')+
                             ' AND CLI.C_IND_CLI = ''S''');
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_CLI = '+InttoStr(VpaCodCliente));

  if VpaCodVendedor <> 0  then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));

  if VpaCodPreposto <> 0  then
    AdicionaSqlTabela(Clientes,' and CLI.I_VEN_PRE = '+InttoStr(VpaCodPreposto));

  AdicionaSqlTabela(Clientes,'ORDER BY C_NOM_VEN, C_NOM_CLI');
  Clientes.open;
  VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
  RvSystem.SystemPrinter.Orientation := poLandScape;

  rvSystem.onBeforePrint := DefineTabelaAnaliseFaturamentoMensal;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAnalisePedidosClassificacao;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Analise Pedidos por Classificação Produto';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodTipoCotacao <> 0 then
    VprCabecalhoEsquerdo.Add('Tipo Cotação :'+ VpaNomTipoCotacao);
  VprCabecalhoDireito.Clear;
  if VpaCodCliente <> 0  then
    VprCabecalhoDireito.add('Cliente : ' +VpaNomCliente);
  if VpaCodClassificacao <> '' then
    VprCabecalhoDireito.add('Classificação : ' +VpaNomClassificacao);
  if VpaCodPreposto <> 0  then
    VprCabecalhoDireito.add('Preposto : ' +VpaNomPreposto);
  if VpaCodVendedor <> 0 then
    VprCabecalhoDireito.Add('Vendedor : '+VpaNomVendedor);
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeLivroRegistroSaidas(VpaCodFilial,VpaCodCliente: Integer; VpaNomFilial, VpaNomCliente, VpaCaminho: string; VpaDatInicio,VpaDatFim: TDatetime;VpaIndEntrada : Boolean);
begin
  RvSystem.Tag := 38;
  RvSystem.SystemPrinter.Orientation:= poPortrait;
  if VpaCodFilial <> 0 then
  begin
    VprDFilial := TRBDFilial.cria;
    Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  end
  else
    VprDFilial := nil;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprIndEntrada := VpaIndEntrada;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT NF.I_EMP_FIL, NF.I_SEQ_NOT, NF.C_SER_NOT, NF.I_NRO_NOT, ' +
                           ' NF.I_COD_CLI, NF.C_COD_NAT, NF.C_TIP_NOT, NF.D_DAT_EMI, NF.D_DAT_SAI, ' +
                           ' NF.N_BAS_CAL, NF.N_VLR_ICM, NF.N_TOT_PRO, NF.N_TOT_NOT, NF.C_NOT_CAN,' +
                           ' NF.I_ITE_NAT, '+
                           ' MNA.C_NOM_MOV, '+
                           ' CLI.C_NOM_CLI, CLI.C_EST_CLI '+
                           ' FROM CADNOTAFISCAIS NF, CADCLIENTES CLI, MOVNATUREZA MNA '+
                           ' WHERE NF.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MNA.C_COD_NAT = NF.C_COD_NAT' +
                           ' AND MNA.I_SEQ_MOV = NF.I_ITE_NAT ' +
                           SQLTextoDataEntreAAAAMMDD('NF.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  if VpaIndEntrada then
    AdicionaSqlTabela(Tabela,' AND NF.C_TIP_NOT = ''E'' ')
  else
    AdicionaSqlTabela(Tabela,' AND NF.C_TIP_NOT = ''S'' ');

  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and NF.I_COD_CLI = '+InttoStr(VpaCodCliente));

  if VpaCodFilial <> 0  then
    AdicionaSqlTabela(Tabela,' and NF.I_EMP_FIL = '+InttoStr(VpaCodFilial));


  AdicionaSqlTabela(Tabela,'ORDER BY NF.I_NRO_NOT');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaLivroRegistroSaidas;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelLivroRegistroSaidas;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := '';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoDireito.Clear;
  ConfiguraRelatorioPDF;
  RvSystem.execute;
  if VprDFilial <> nil then
    VprDFilial.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeFluxoCaixaDiarioDias(VpaDContaFluxo: TRBDFluxoCaixaConta; VpaDiaInicio, vpaDiaFim: Integer);
var
  VpfLacoDia : Integer;
  VpfDDiaFluxo : TRBDFluxoCaixaDia;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(' ');
    if VpaDiaInicio = 1 then
    begin
      PrintTab('Aplicação ');
      PrintTab('Saldo Atual ');
      PrintTab('Saldo Anterior ');
    end;

    for VpfLacoDia := VpaDiaInicio to vpaDiaFim  do
    begin
      if VpfLacoDia <= Dia(UltimoDiaMes(MontaData(1,VprDFluxo.Mes,VprDFluxo.Ano))) then
      begin
        if DiaSemanaNumerico(MontaData(VpfLacoDia,VprDFluxo.Mes,VprDFluxo.Ano)) in [1,7] then
          FontColor := clRed;
        PrintTab(IntToStr(VpfLacoDia)+ ' ');
        FontColor := clBlack;
      end;
    end;

    if vpaDiaFim = 31 then
    begin
      Bold := true;
      PrintTab('Total');
      bold := false;
    end;

    NewLine;
    NewLine;
    RestoreTabs(1);
    FontSize := 12;
    PrintTab('Entradas ');
    NewLine;
    RestoreTabs(2);
    FontSize := 10;

    PrintTab('Entrada Prevista  ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCRPrevisto);
    PrintTab('Entrada Duvidosa  ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCRDuvidoso);
    PrintTab('Cheques CR ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCRCheques);
    NewLine;
    PrintTab('Total Entradas ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCRTotalDia);
    PrintTab('Entrada Acumulada ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCRTotalAcumulado);
    NewLine;
    NewLine;

    RestoreTabs(1);
    FontSize := 12;
    PrintTab('Saidas ');
    NewLine;
    RestoreTabs(2);
    FontSize := 10;
    PrintTab('Saidas Prevista ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCPPrevisto);
    PrintTab('Cheques Emitidos');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCPCheques);
    NewLine;
    PrintTab('Total Saidas');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCPTotalDia);
    PrintTab('Saidas Acumuladas ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfCPTotalAcumaldo);
    NewLine;
    NewLine;
    PrintTab('Total Conta ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfTotalConta);
    PrintTab('Acumulado Conta ');
    ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo,VpaDiaInicio,vpaDiaFim,lfTotalContaAcumulada);

  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeFluxoCaixaDiarioLinha(VpaDContaFluxo: TRBDFluxoCaixaConta; VpaDiaInicio, vpaDiaFim: Integer;VpaTipoLinha: TRBDTipoLinhaFluxo);
var
  VpfLacoDia  : Integer;
  VpfDDiaFluxo : TRBDFluxoCaixaDia;
  VpfDMes : TRBDFluxoCaixaMes;
  VpfValor : Double;
begin
  with RVSystem.BaseReport do
  begin
    if VpaDiaInicio = 1 then
    begin
      case VpaTipoLinha of
        lfTotalConta :
        begin
          PrintTab('  ');
          PrintTab(FormatFloat('#,###,###,##0.00',VpaDContaFluxo.ValSaldoAtual));
        end;
        lfTotalContaAcumulada :
        begin
          PrintTab(FormatFloat('#,###,###,##0.00',VpaDContaFluxo.ValAplicado));
          PrintTab(FormatFloat('#,###,###,##0.00',VpaDContaFluxo.ValSaldoAtual+VpaDContaFluxo.ValAplicado));
        end;
      else
        PrintTab('  ');
        PrintTab('  ');
      end;
      VpfValor := 0;
      case VpaTipoLinha of
        lfCRPrevisto: VpfValor := VpaDContaFluxo.ValSaldoAnteriorCR ;
        lfCRCheques : VpfValor := VpaDContaFluxo.ValChequeCRSaldoAnterior;
        lfCRTotalDia, lfCRTotalAcumulado: VpfValor := VpaDContaFluxo.ValSaldoAnteriorCR+VpaDContaFluxo.ValChequeCRSaldoAnterior;
        lfCPPrevisto: VpfValor := VpaDContaFluxo.ValSaldoAnteriorCP ;
        lfCPCheques: VpfValor := VpaDContaFluxo.ValChequeCPSaldoAnterior ;
        lfCPTotalDia,lfCPTotalAcumaldo : VpfValor := VpaDContaFluxo.ValSaldoAnteriorCP+VpaDContaFluxo.ValChequeCPSaldoAnterior;
        lfTotalConta : VpfValor := VpaDContaFluxo.ValSaldoAnteriorCR+VpaDContaFluxo.ValChequeCRSaldoAnterior-VpaDContaFluxo.ValSaldoAnteriorCP-VpaDContaFluxo.ValChequeCPSaldoAnterior;
        lfTotalContaAcumulada : VpfValor := VpaDContaFluxo.ValSaldoAnteriorCR+VpaDContaFluxo.ValAplicado+VpaDContaFluxo.ValSaldoAtual+VpaDContaFluxo.ValChequeCRSaldoAnterior-VpaDContaFluxo.ValSaldoAnteriorCP-VpaDContaFluxo.ValChequeCPSaldoAnterior;
      end;
      if VpfValor <> 0 then
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValor))
      else
        PrintTab('');
    end;

    for VpfLacoDia := VpaDiaInicio to vpaDiaFim  do
    begin
      if VpfLacoDia <= Dia(UltimoDiaMes(MontaData(1,VprDFluxo.Mes,VprDFluxo.Ano))) then
      begin
        if DiaSemanaNumerico(MontaData(VpfLacoDia,VprDFluxo.Mes,VprDFluxo.Ano)) in [1,7] then
        begin
          PrintTab('');
          Continue;
        end;

        VpfDDiaFluxo := VpaDContaFluxo.RDia(MontaData(VpfLacoDia,VprDFluxo.Mes,VprDFluxo.Ano),false);
        if VpfDDiaFluxo <> nil then
        begin
          case VpaTipoLinha of
            lfCRPrevisto: VpfValor := VpfDDiaFluxo.ValCRPrevisto;
            lfCRDuvidoso: VpfValor := VpfDDiaFluxo.ValCRDuvidoso ;
            lfCRCheques: VpfValor := VpfDDiaFluxo.ValChequesCR ;
            lfCRTotalDia : VpfValor := VpfDDiaFluxo.ValTotalReceita;
            lfCRTotalAcumulado : VpfValor := VpfDDiaFluxo.ValTotalReceitaAcumulada;
            lfCPPrevisto : VpfValor := VpfDDiaFluxo.ValCP;
            lfCPCheques : VpfValor := VpfDDiaFluxo.ValChequesCP;
            lfCPTotalDia : VpfValor := VpfDDiaFluxo.ValTotalDespesa;
            lfCPTotalAcumaldo : VpfValor := VpfDDiaFluxo.ValTotalDespesaAcumulada;
            lfTotalConta : VpfValor := VpfDDiaFluxo.Valtotal;
            lfTotalContaAcumulada : VpfValor := VpfDDiaFluxo.ValTotalAcumulado;
          end;
          if VpfValor <> 0 then
            PrintTab(FormatFloat('#,###,###,##0.00',VpfValor))
          else
            PrintTab('');
        end
        else
          PrintTab('');
        VpfDDiaFluxo := nil;
      end;
    end;

    //imprime o total da linha
    if vpaDiaFim = 31 then
    begin
      VpfValor := 0;
      VpfDMes := VpaDContaFluxo.RMes(VprDFluxo.Mes,VprDFluxo.Ano);
      case VpaTipoLinha of
        lfCRPrevisto: VpfValor := VpfDMes.ValCRPrevisto;
        lfCRDuvidoso: VpfValor := VpfDMes.ValCRDuvidoso;
        lfCRCheques: VpfValor := VpfDMes.ValChequesCR;
        lfCRTotalDia : VpfValor := VpfDMes.ValTotalReceita;
        lfCRTotalAcumulado : VpfValor := VpfDMes.ValTotalReceitaAcumulada;
        lfCPPrevisto : VpfValor := VpfDMes.ValCP;
        lfCPCheques : VpfValor := VpfDMes.ValChequesCP;
        lfCPTotalDia : VpfValor := VpfDMes.ValTotalDespesa;
        lfCPTotalAcumaldo : VpfValor := VpfDMes.ValTotalDespesaAcumulada;
        lfTotalConta : VpfValor := VpfDMes.Valtotal;
        lfTotalContaAcumulada : VpfValor := VpfDMes.ValTotalAcumulado;
      end;
      if VpfValor <> 0 then
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValor))
      else
        PrintTab('');

    end;
    NewLine;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeFluxoDiario(VpaDFluxo: TRBDFluxoCaixaCorpo);
begin
  RvSystem.Tag := 39;
  VprDFluxo := VpaDFluxo;
  RvSystem.SystemPrinter.Orientation:= poLandScape;

  rvSystem.onBeforePrint := DefineTabelaFluxoCaixaDiario;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelFluxoCaixaDiario;

  VprNomeRelatorio := 'Fluxo Diario : '+IntToStr(VprDFluxo.Mes)+'/'+IntToStr(VprDFluxo.Ano);

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoDireito.Clear;
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutosFaturadosSTcomTributacaoPorNota(VpaCodFilial: Integer; VpaDatInicio, VpaDatFim: TDateTime;VpaNomFilial, VpaCaminho: String;VpaAgruparPorNota : Boolean);
begin
  RvSystem.Tag := 40;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'select CAD.I_EMP_FIL, CAD.I_NRO_NOT, CAD.D_DAT_EMI, '+
                           ' CLI.C_EST_CLI, '+
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.N_PER_SUT, PRO.C_COD_UNI UMPADRAO, '+
                           ' PRO.I_SEQ_PRO, '+
                           ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_PER_ICM, MOV.N_TOT_PRO, '+
                           ' MOV.C_COD_CST, MOV.I_COD_CFO, MOV.N_VLR_ICM, MOV.N_BAS_ICM, MOV.I_COD_COR '+
                           ' from CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADPRODUTOS PRO, CADCLIENTES CLI '+
                           ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                           ' and CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                           ' AND CAD.C_NOT_CAN = ''N'''+
                           SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true)+
                           ' AND (PRO.N_PER_SUT > 0 OR C_SUB_TRI = ''S'') '+
                           ' AND MOV.N_VLR_ICM > 0 ');

  if VpaCodFilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));

  AdicionaSqlTabela(Tabela,'ORDER BY CAD.D_DAT_EMI,CAD.I_NRO_NOT');
  Tabela.Open;

  RvSystem.SystemPrinter.Orientation := poPortrait;

  rvSystem.onBeforePrint := DefineTabelaProdutosFaturadosSTcomTributacao;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  if VpaAgruparPorNota then
    rvSystem.onPrint := ImprimeRelProdutosFaturadosSTComTributacaoPorNota
  else
    rvSystem.onPrint := ImprimeRelProdutosFaturadosSTComTributacao;
  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Faturados ST com Tributação';

  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  VprCabecalhoDireito.Clear;
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutosFaturadosPorPeriodo(VpaCodFilial,VpaCodCliente, VpaCodVendedor: Integer; VpaDatInicio, VpaDatFim: TDateTime;VpaCaminho, VpaNomFilial, VpaNomCliente, VpaNomVendedor: String;
  VpaPDF: Boolean);
begin
  RvSystem.Tag := 41;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UMPADRAO, PRO.N_PES_BRU,' +
                           ' MOV.N_QTD_PRO, MOV.N_TOT_PRO, MOV.I_COD_COR, MOV.C_COD_UNI, MOV.I_SEQ_PRO, ' +
                           ' CLI.C_EST_CLI, '+
                           ' COR.NOM_COR ' +
                           ' FROM MOVNOTASFISCAIS MOV, CADNOTAFISCAIS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, COR, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_SEQ_NOT = CAD.I_SEQ_NOT ' +
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND CAD.C_NOT_CAN = ''N'''+
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaProdutosFaturadosPorPeriodo;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeProdutosFaturadoPorPeriodo;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Faturados por Periodo';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeResultadoFinanceiroOrcadoConsolidado(VpaTipoPeriodo,VpaCodFilial: Integer; VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho,VpaNomFilial: string);
begin
  case VpaTipoPeriodo of
    0 : VprCampoData := 'CAD.D_DAT_EMI';
    1 : VprCampoData := 'MOV.D_DAT_VEN';
    2 : VprCampoData := 'MOV.D_DAT_PAG';
  else
    VprCampoData := 'CAD.D_DAT_EMI';
  end;
  VprDatInicio := PrimeiroDiaMes(VpaDatInicio);
  VprDatFim := UltimoDiaMes(VpaDatFim);
  VprFilial := VpaCodFilial;
  VprResultadoFinanceiroConsolidado := true;
  RvSystem.Tag := 42;
  FreeTObjectsList(VprNiveis);

  RvSystem.SystemPrinter.Orientation := poPortrait;
  rvSystem.onBeforePrint := DefineTabelaResultadoFinanceiroOrcado;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelResultadoFinanceiroOrcado;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Resultado Financeiro Orçado Consolidado';
  VprCabecalhoEsquerdo.Clear;
  case VpaTipoPeriodo of
    0 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Emissao');
    1 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Vencimento');
    2 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Pagamento');
  else
    VprCabecalhoEsquerdo.add('Periodo : Por Emissao');;
  end;
  if VpaCodFilial <> 0 then
    VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial)
  else
    VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período : '+ FormatDateTime('DD/MM/YYYY',VprDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VprDatFim)+'   ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeResultadoFinanceiroOrcadoConsolidadoPorCentroCusto( VpaTipoPeriodo, VpaCodFilial: Integer; VpaDatInicio, VpaDatFim: TDateTime;VpaCaminho, VpaNomFilial: string);
begin
  case VpaTipoPeriodo of
    0 : VprCampoData := 'CAD.D_DAT_EMI';
    1 : VprCampoData := 'MOV.D_DAT_VEN';
    2 : VprCampoData := 'MOV.D_DAT_PAG';
  else
    VprCampoData := 'CAD.D_DAT_EMI';
  end;
  VprDatInicio := PrimeiroDiaMes(VpaDatInicio);
  VprDatFim := UltimoDiaMes(VpaDatFim);
  VprFilial := VpaCodFilial;
  VprResultadoFinanceiroConsolidado := true;
  RvSystem.Tag := 43;
  FreeTObjectsList(VprNiveis);

  RvSystem.SystemPrinter.Orientation := poPortrait;
  rvSystem.onBeforePrint := DefineTabelaResultadoFinanceiroOrcado;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelResultadoFinanceiroOrcadoPorCentroCusto;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Resultado Financeiro Orçado Consolidado por Centro Custo';
  VprCabecalhoEsquerdo.Clear;
  case VpaTipoPeriodo of
    0 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Emissao');
    1 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Vencimento');
    2 : VprCabecalhoEsquerdo.add('Periodo : Contas a Pagar por Pagamento');
  else
    VprCabecalhoEsquerdo.add('Periodo : Por Emissao');;
  end;
  if VpaCodFilial <> 0 then
    VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial)
  else
    VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período : '+ FormatDateTime('DD/MM/YYYY',VprDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VprDatFim)+'   ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeAnaliseRenovacaoContrato(VpaCodVendedor : Integer;VpaDatInicio,VpaDatFim: TDateTime; VpaNomVendedor, VpaCaminho: string);
begin
  RvSystem.Tag := 44;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_EST_CLI, ' +
                           ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                           ' CON.DATINICIOVIGENCIA, CON.DATFIMVIGENCIA, CON.VALCONTRATO, CON.CODVENDEDOR, ' +
                           ' CON.CODFILIAL, CON.SEQCONTRATO '+
                           ' FROM CONTRATOCORPO CON, CADCLIENTES CLI, CADVENDEDORES VEN' +
                           ' WHERE CON.CODCLIENTE = CLI.I_COD_CLI ' +
                           ' AND CON.CODVENDEDOR = VEN.I_COD_VEN '+
                           SQLTextoDataEntreAAAAMMDD('CON.DATFIMVIGENCIA',VpaDatInicio,VpaDatFim,true));
  if VpaCodVendedor <> 0 then
    AdicionaSQLTabela(Tabela,'AND CON.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
  AdicionaSqlTabela(Tabela,'ORDER BY VEN.C_NOM_VEN, CLI.C_NOM_CLI');
  Tabela.open;

  RvSystem.SystemPrinter.Orientation := poLandScape;
  rvSystem.onBeforePrint := DefineTabelaAnaliseRenovacaoContrato;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAnaliseRenovacaoContrato;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Analise Renovação Contratos';
  VprCabecalhoEsquerdo.Clear;
  if VpaCodVendedor <> 0 then
    VprCabecalhoEsquerdo.Add(VpaNomVendedor);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Fim Vigência : '+ FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim)+'   ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeContratosAssinados(VpaCodVendedor: Integer;VpaDatInicio, VpaDatFim: TDateTime; VpaNomVendedor, VpaCaminho: string);
begin
  RvSystem.Tag := 45;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_EST_CLI, ' +
                           ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                           ' CON.DATINICIOVIGENCIA, CON.DATFIMVIGENCIA, CON.VALCONTRATO, CON.CODVENDEDOR, ' +
                           ' CON.CODFILIAL, CON.SEQCONTRATO '+
                           ' FROM CONTRATOCORPO CON, CADCLIENTES CLI, CADVENDEDORES VEN' +
                           ' WHERE CON.CODCLIENTE = CLI.I_COD_CLI ' +
                           ' AND CON.CODVENDEDOR = VEN.I_COD_VEN '+
                           SQLTextoDataEntreAAAAMMDD('CON.DATASSINATURA',VpaDatInicio,VpaDatFim,true));
  if VpaCodVendedor <> 0 then
    AdicionaSQLTabela(Tabela,'AND CON.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
  AdicionaSqlTabela(Tabela,'ORDER BY VEN.C_NOM_VEN, CLI.C_NOM_CLI');
  Tabela.open;

  RvSystem.SystemPrinter.Orientation := poLandScape;
  rvSystem.onBeforePrint := DefineTabelaContratoAssinados;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAnaliseRenovacaoContrato;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Contratos Assinados';
  VprCabecalhoEsquerdo.Clear;
  if VpaCodVendedor <> 0 then
    VprCabecalhoEsquerdo.Add(VpaNomVendedor);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Fim Vigência : '+ FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim)+'   ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCreditoCliente(VpaCaminho : string);
begin
  RvSystem.Tag := 46;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT CRE.*, CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                           ' FROM  CREDITOCLIENTE CRE, CADCLIENTES CLI '+
                           ' Where CLI.I_COD_CLI = CRE.CODCLIENTE '+
                           ' ORDER BY CLI.C_NOM_CLI, CLI.I_COD_CLI');
  Tabela.open;

  RvSystem.SystemPrinter.Orientation := poPortrait;
  rvSystem.onBeforePrint := DefineTabelaCreditoCliente;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCreditoCliente;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Crédito Cliente';
  VprCabecalhoEsquerdo.Clear;

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeHistoricoConsumoProdutoProducao(VpaSeqProduto: Integer; VpaCodProduto, VpaNomProduto, VpaCodClassificacao, VpaNomClassificacao, VpaCaminhoRelatorio: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rvsystem.Tag:= 47;
  LimpaSQLTabela(Tabela);
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoDireito.Clear;
  AdicionaSqlTabela(Tabela, 'SELECT OPE.I_COD_OPE, OPE.C_NOM_OPE, OPE.C_TIP_OPE, ' +
                            ' MOV.D_DAT_MOV, MOV.I_SEQ_PRO, MOV.N_QTD_MOV, MOV.C_COD_UNI, MOV.I_COD_COR, ' +
                            ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UNORIGINAL ' +
                            ' FROM MOVESTOQUEPRODUTOS MOV, CADOPERACAOESTOQUE OPE, CADPRODUTOS PRO ' +
                            ' WHERE MOV.I_COD_OPE = OPE.I_COD_OPE ' +
                            ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                            ' AND (C_FUN_OPE = ''SP'' OR C_FUN_OPE = ''EP'')' +
                            SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_MOV', VpaDatInicio, VpaDatFim, true));
  VprCabecalhoEsquerdo.Add('Período : ' + FormatDateTime('DD/MM/YYYY', VpaDatInicio) + ' - ' + FormatDateTime('DD/MM/YYYY', VpaDatFim));
  if VpaSeqProduto <> 0 then
  begin
    Tabela.SQL.Add('AND MOV.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));
    VprCabecalhoDireito.Add('Produto : ' + VpaCodProduto + ' - ' + VpaNomProduto);
  end;

  if VpaCodClassificacao <> '' then
  begin
    Tabela.SQL.Add('AND PRO.C_COD_CLA LIKE ''' + VpaCodClassificacao + '%''');
    VprCabecalhoDireito.Add('Classificação : ' + VpaCodClassificacao + ' - ' + VpaNomClassificacao);
  end;
  Tabela.SQL.Add('ORDER BY MOV.D_DAT_MOV, MOV.I_COD_OPE, MOV.I_SEQ_PRO');
  Tabela.Open;

  RvSystem.SystemPrinter.Orientation := poPortrait;
  rvSystem.onBeforePrint := DefineTabelaHistoricoConsumoProdutoProducao;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelHistoricoConsumoProdutoProducao;

  VprCaminhoRelatorio := VpaCaminhoRelatorio;
  VprNomeRelatorio := 'Consumo Produto Produção';


  ConfiguraRelatorioPDF;
  RvSystem.execute;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeConsumoProdutoProducao(VpaCodFilial : Integer; VpaSeqProduto: Integer;VpaCodProduto, VpaNomProduto, VpaCodClassificacao, VpaNomClassificacao,VpaNomFilial, VpaCaminhoRelatorio: String; VpaDatInicio, VpaDatFim: TDateTime;VpaSomenteComQtdEstoque : Boolean; VpaOrdemRelatorio:Integer;VpaSomenteComQtdConsumida : Boolean);
begin
  RvSystem.Tag := 48;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprIndSomenteComQtdConsumida := VpaSomenteComQtdConsumida;
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, PRO.C_BAR_FOR, ' +
                           ' MOV.N_QTD_PRO,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');

  if VpaSomenteComQtdEstoque then
    AdicionaSQLTabela(Tabela,' and MOV.N_QTD_PRO <> 0 ');
  if VpaSeqProduto <> 0 then
    AdicionaSQLTabela(Tabela,' and PRO.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));

  if VpaOrdemRelatorio = 0 then
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO ')
  else
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaEstoqueProdutos;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelConsumoProdutoProducao;

  VprCaminhoRelatorio := VpaCaminhoRelatorio;
  VprNomeRelatorio := 'Consumo Produto Produção';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeValorFreteNotaXValorConhecimento(VpaCodFilial,VpaCodTransportadora: Integer; VpaNomTransportadora, VpaNomFilial,VpaCaminhoRelatorio: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 49;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT CON.NUMCONHECIMENTO, CON.VALCONHECIMENTO, ' +
                           ' CAD.I_NRO_NOT, CAD.N_VLR_FRE, TRA.C_NOM_CLI ' +
                           ' FROM CONHECIMENTOTRANSPORTE CON, CADNOTAFISCAIS CAD, CADCLIENTES TRA ' +
                           ' WHERE CON.SEQNOTASAIDA = CAD.I_SEQ_NOT ' +
                           ' AND CON.CODTRANSPORTADORA = TRA.I_COD_CLI' +
                           ' AND CON.CODFILIALNOTA = CAD.I_EMP_FIL '+
                           SQLTextoDataEntreAAAAMMDD('CON.DATCONHECIMENTO', VpaDatInicio, VpaDatFim, true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CON.CODFILIALNOTA = '+InttoStr(VpaCodFilial));



  if VpaCodTransportadora <> 0 then
    AdicionaSqlTabela(Tabela,'And TRA.I_COD_CLI = '+InttoStr(VpaCodTransportadora));

  AdicionaSqlTabela(Tabela,' ORDER BY CON.NUMCONHECIMENTO, TRA.I_COD_CLI');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaValorFreteXValorConhecimento;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelValorFreteNotaXValorConhecimento;

  VprCaminhoRelatorio := VpaCaminhoRelatorio;
  VprNomeRelatorio := 'Valor Frete Nota X Valor Conhecimento Frete';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodTransportadora <> 0  then
    VprCabecalhoEsquerdo.add('Transportadora : ' +VpaNomTransportadora);

  VprCabecalhoDireito.add('Periodo : ' + DateToStr(VpaDatInicio) + ' Ate ' + DateToStr(VpaDatFim));

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeDemandaCompra(VpaCodFilial: Integer;VpaCodClassificacao, VpaNomClassificacao, VpaNomFilial, VpaCaminho: String;VpaDatInicio, VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 50;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, PRO.C_BAR_FOR, ' +
                           ' MOV.N_QTD_PRO,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');
 { if VpaSomenteComQtdEstoque then
    AdicionaSQLTabela(Tabela,' and MOV.N_QTD_PRO <> 0 ');
{  if VpaSeqProduto <> 0 then
    AdicionaSQLTabela(Tabela,' and PRO.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));

  if VpaOrdemRelatorio = 0 then
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO ')
  else}
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;
  RvSystem.SystemPrinter.Orientation := poLandScape;
  rvSystem.onBeforePrint := DefineTabelaDemandaCompra;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelDemandaCompra;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Demanda Compra';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutoFornecedor(VpaCodFornecedor: integer;
  VpaCaminho, VpaNomFornecedor: String);
begin
  RvSystem.Tag := 51;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela, ' SELECT PRO.C_COD_PRO, PRO.C_NOM_PRO,  ' +
                            ' PFO.VALUNITARIO, PFO.PERIPI, PFO.DATULTIMACOMPRA, PFO.NUMDIAENTREGA, PFO.DESREFERENCIA, ' +
                            ' CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_NOM_REP, CLI.C_FON_REP, CLI.C_COM_END, TRA.C_NOM_CLI C_NOM_TRA  ' +
                            ' FROM PRODUTOFORNECEDOR PFO, CADPRODUTOS PRO, CADCLIENTES CLI, CADCLIENTES TRA ' +
                            ' WHERE PFO.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                            ' AND PFO.CODCLIENTE = CLI.I_COD_CLI ' +
                            ' AND ' + SQLTextoRightJoin('CLI.I_COD_TRA', 'TRA.I_COD_CLI'));
  if VpaCodFornecedor <> 0 then
    AdicionaSqlTabela(Tabela,' AND PFO.CODCLIENTE = '+InttoStr(VpaCodFornecedor));

  AdicionaSqlTabela(Tabela,' ORDER BY PRO.C_NOM_PRO');
  Tabela.open;

  RvSystem.SystemPrinter.Orientation:= poLandScape;
  rvSystem.onBeforePrint := DefineTabelaProdutoFornecedor;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelProdutoFornecedor;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := ' Relação de Produtos Fornecedor';
  VprCabecalhoEsquerdo.Clear;

  if VpaCodFornecedor <> 0 then
  begin
    VprCabecalhoEsquerdo.add('Fornecedor : ' +VpaNomFornecedor);
    VprCabecalhoDireito.Clear;
    VprCabecalhoDireito.add('Representante : ' + Tabela.FieldByName('C_NOM_REP').AsString);
    VprCabecalhoDireito.add('Fone : ' + Tabela.FieldByName('C_FON_REP').AsString);
  end;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

end.
