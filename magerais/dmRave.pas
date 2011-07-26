unit dmRave;

interface

uses
  SysUtils, Classes, DSServer, FMTBcd, RpDefine, RpCon, RpConDS, DB, SqlExpr,RPDevice, Windows,StdCtrls,
  RpRave, DBClient, Tabela, RpBase, RpSystem, UnRave, UnDados,RvLDCompiler, RpRender, RpRenderPDF,Graphics,
  UnProdutos, UnClassesImprimir, UnDadosProduto, UnCotacao, Messages, jpeg, RVClass, RVProj, RVCsStd,
  RpRenderRTF;

type
  TdtRave = class(TDataModule)
    Principal: TSQL;
    rvPrincipal: TRvDataSetConnection;
    Rave: TRvProject;
    RvSystem1: TRvSystem;
    PedidosPendentes: TSQL;
    rvPedidosPendentes: TRvDataSetConnection;
    PedidosPendentesI_EMP_FIL: TFMTBCDField;
    PedidosPendentesD_DAT_PRE: TSQLTimeStampField;
    PedidosPendentesD_DAT_ORC: TSQLTimeStampField;
    PedidosPendentesI_LAN_ORC: TFMTBCDField;
    PedidosPendentesI_COD_CLI: TFMTBCDField;
    PedidosPendentesT_HOR_ENT: TSQLTimeStampField;
    PedidosPendentesC_NOM_CLI: TWideStringField;
    PedidosPendentesC_ORD_COM: TWideStringField;
    PedidosPendentesN_QTD_PRO: TFMTBCDField;
    PedidosPendentesQTDREAL: TFMTBCDField;
    PedidosPendentesC_NOM_PRO: TWideStringField;
    PedidosPendentesC_COD_PRO: TWideStringField;
    PedidosPendentesC_COD_UNI: TWideStringField;
    PedidosPendentesC_DES_COR: TWideStringField;
    PedidosPendentesC_PRO_REF: TWideStringField;
    PedidosPendentesI_SEQ_MOV: TFMTBCDField;
    PedidosPendentesTOTAL: TFMTBCDField;
    Item: TSQL;
    rvItem: TRvDataSetConnection;
    Item2: TSQL;
    rvItem2: TRvDataSetConnection;
    Item3: TSQL;
    rvItem3: TRvDataSetConnection;
    PedidosPendentesI_SEQ_ORD: TFMTBCDField;
    PDF: TRvRenderPDF;
    PedidosPendentesN_QTD_BAI: TFMTBCDField;
    Item4: TSQL;
    rvItem4: TRvDataSetConnection;
    PedidosPendentesMESANO: TWideStringField;
    PedidosPendentesMESANOF: TWideStringField;
    VendaAdicional: TSQL;
    rvVendaAdicional: TRvDataSetConnection;
    PedidosPendentesI_COD_COR: TFMTBCDField;
    Item5: TSQL;
    rvItem5: TRvDataSetConnection;
    Item6: TSQL;
    rvItem6: TRvDataSetConnection;
    ChamadoProposta: TSQL;
    RvChamadoProposta: TRvDataSetConnection;
    ChamadoPropostaNUMCHAMADO: TFMTBCDField;
    RTF: TRvRenderRTF;
    Item7: TSQL;
    rvItem7: TRvDataSetConnection;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1Codigo: TIntegerField;
    ClientDataSet1Nome: TStringField;
    procedure f(Sender: TObject);
    procedure RaveBeforeOpen(Sender: TObject);
    procedure RvSystem2AfterPreviewPrint(Sender: TObject);
    procedure RVJPGGetRow(Connection: TRvCustomConnection);
    procedure ItemAfterExecute(Sender: TObject; var OwnerData: OleVariant);
    procedure rvItemGetRow(Connection: TRvCustomConnection);
  private
    { Private declarations }
    FunRave : TRBFunRave;
    VprDFilial : TRBDFilial;
    procedure ConfiguraRelatorioPDF;
    procedure ConfiguraRelatorioRTF;
    procedure salvaSql;
    procedure CarregaRaveImagem(rvPagina,rvImagemNome,bdArquivo:String);

  public
    { Public declarations }
    VplArquivoPDF,
    VplArquivoRTF : String;
    procedure ImprimeRetorno(VpaCodFilial, VpaSeqRetorno : Integer);
    procedure ImprimeRemessa(VpaCodFilial, VpaSeqRemessa : Integer);
    procedure ImprimePedidoPendente(VpaCodFilial,VpaCodCliente,VpaCodClienteMaster, VpaSeqProduto, VpaCodTipCotacao, VpaCodVendedorPreposto, VpaCodCor, VpaCodRepresentada: Integer;VpaCodClassificacao,VpaNomClassificacao,VpaNomCliente, VpaNomTipCotacao, VpaNomVendedorPreposto, VpaNomRepresentada  : String;VpaDatInicio,VpaDatFim : TDateTime;VpaClienteMaster : Boolean; VpaPedidoXBaixa : Boolean = false; VpaImpressaoEmbalagem : Boolean = false; VpaAlcaBolso : Boolean = false);
    procedure ImprimeProdutosPendenteaProduzir(VpaCodFilial : Integer;VpaDatInicio,VpaDatFim : TDateTime);
    procedure ImprimePedidoParcial(VpaCodFilial,VpaLanOrcamento, VpaSeqParcial : Integer);
    procedure ImprimeNotasFiscaisEmitidas(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodClienteMaster,VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaSituacaoNota : Integer);
    procedure ImprimeRecibosEmitidos(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente: String);
    procedure ImprimePedidosPorDia(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaSituacaoCotacao, VpaCodCondicaoPagamento, VpaSeqProduto, VpaCodRepresentada, VpaCodPresposto: Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor,VpaNomTipoCotacao,VpaNomSituacao, VpaNomCodicaoPagamento, VpaNomProduto, VpaNomRepresentada, VpaNomPreposto, VpaCodClassificacaoProduto, VpaNomClassificacaoProduto,VpaUF : String);
    procedure ImprimePedido(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean; VpaProtocoloCracha: Boolean = false);
    procedure ImprimeOrcamentoRoteiroEntrega(VpaCodFilial,VpaSeqRoteiro : Integer;VpaVisualizar, VpaIncluiData : Boolean; VpaDatIni, VpaDatFim : TDateTime);
    procedure ImprimeReciboLocacao(VpaCodFilial, VpaSeqReciboLocacao: Integer; VpaVisualizar,VpaIncluiData: Boolean; VpaDatIni, VpaDatFim: TDateTime);
    procedure ImprimeGarantia(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
    procedure ImprimeChamado(VpaCodFilial,VpaNumChamado : Integer;VpaVisualizar : Boolean);
    procedure ImprimeChamadoProducao(VpaCodFilial,VpaNumChamado : Integer;VpaVisualizar : Boolean);
    procedure ImprimeObservacoesChamado(VpaCodFilial,VpaNumChamado : Integer;VpaVisualizar : Boolean);
    procedure ImprimeSaidaMateriais(VpaCodFilial,VpaNumChamado,VpaSeqParcial : Integer);
    procedure ImprimeEntradaMateriais(VpaCodFilial,VpaNumChamado,VpaSeqParcial : Integer);
    procedure ImprimeEnvelope(VpaDCliente : TRBDCliente);
    procedure ImprimeEnvelopeEntrega(VpaDCliente : TRBDCliente);
    procedure ImprimeEnvelopeCobranca(VpaDCliente : TRBDCliente);
    procedure ImprimeExtratoLocacao(VpaCodFilial, VpaSeqLeitura : Integer;VpaVisualizar : Boolean);
    procedure ImprimeCaixa(VpaSeqCaixa : Integer);
    procedure ImprimeEspelhoNota(VpaCodFilial,VpaSeqNota : Integer);
    procedure ImprimeClientesSemPedido(VpaCodVendedor, VpaPreposto, VpaCodSituacaoCliente,VpaCodTipoCotacao, VpaCodRepresentada : Integer;VpaDatDesde, VpaDatInicio, VpaDatFim : TDateTime;VpaNomVendedor,VpaNomPreposto,VpaNomSituacaoCliente,VpaNomTipCotacao, VpaNomRepresentanda, VpaCaminhoRelatorio: String; VpaSomenteClientesAtivos, VpaIndPeriodoCadastro : Boolean);
    procedure ImprimeChamadodaCotacao(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
    procedure ImprimePedidoCompra(VpaCodFilial,VpaSeqPedido : Integer;VpaVisualizar : Boolean);
    procedure ImprimeLeituraContratos(VpaCodCliente,VpaCodTecnico,VpaCodTipoContrato, VpaNumDiaLeitura,VpaCodFilial, VpaSeqContrato: Integer;VpaCaminhoRelatorio,VpaNomCliente,VpaNomTecnico,VpaNomTipoContrato : String);
    procedure ImprimeFracaoOP(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer;VpaVisualizar : Boolean);
    procedure ImprimeOrdemCorteOP(VpaCodFilial, VpaSeqOrdem : Integer;VpaVisualizar : Boolean);
    procedure ImprimePedidoCompraPendente(VpaCodFornecedor : Integer);
    procedure ImprimeVendasAnalitico(VpaCodFilial,VpaCodCliente,VpaCodCondicaoPagamento, VpaCodTipoCotacao,VpaCodVendedor,VpaCodPreposto, VpaCodRepresentada : Integer;VpaDatInicio,VpaDatFim : TDatetime;VpaCaminhoRelatorio,VpaDesCidade,VpaUF,VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaNomVendedor,VpaNomFilial,VpaNomPreposto, VpaNomRepresentada : string);
    procedure ImprimePropostaAnalitico(VpaCodFilial,VpaCodCliente,VpaCodCondicaoPagamento, VpaCodVendedor, VpaCodSetor: Integer;VpaDatInicio,VpaDatFim : TDatetime;VpaCaminhoRelatorio,VpaDesCidade,VpaUF,VpaNomCliente,VpaNomCondicaoPagamento,VpaNomVendedor,VpaNomFilial, VpaNomSetor, VpaCodClassificacao, VpaNomClassificacao : string);
    procedure ImprimeProdutoFornecedor(VpaCodCliente : integer; VpaCaminho, VpaNomCliente : String);
    procedure ImprimeAmostrasEntregueseNaoAprovadas(VpaDatInicio, VpaDatFim : TDateTime; VpaCodCliente: integer; VpaCaminhoRelatorio, VpaNomCliente: string);
    procedure ImprimeConsistenciadeEstoque(VpaCodFilial, VpaSeProduto : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaCaminhoRelatorio,VpaNomFilial,VpaNomProduto : String;VpaIndSomenteMonitorados : Boolean);
    procedure ImprimeConsumoFracionada(VpaCodFilial, VpaSeqOrdemProduccao : Integer;VpaSomenteAReservar : Boolean);
    procedure ImprimeConsumoSubmontagem(VpaCodFilial, VpaSeqOrdemProduccao, VpaSeqFracao : Integer;VpaSomenteAReservar, VpaConsumoExcluir : Boolean);
    procedure ImprimeRecibo(VpaCodFilial : Integer;VpaDCliente : TRBDCliente;VpaDesDuplicata, VpaValDuplicata,VpaValExtenso,VpaLocaleData : String);
    procedure ImprimePromissoria(VpaDFilial: TRBDFilial; VpaDCliente : TRBDCliente; VpaDesDuplicata, VpaValDuplicata,VpaValExtenso,VpaLocaleData, VpaDiaVencimento,VpaDiaVencExtenso,VpaAnoVencimento,VpaDesMesVencimento : String;VpaVisualizar : Boolean);
    procedure ImprimeDevolucoesPendente(VpaCodFilial,VpaCodCliente,VpaCodTransportadora,VpaCodEstagio,VpaCodVendedor, VpaCodProduto : Integer; VpaData : TDatetime;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomTranportadora,VpaNomEstagio, VpaNomVendedor, VpaNomProduto : String);
    procedure ImprimeEstoqueFiscal(VpaCodFilial,VpaSeqProduto : integer;VpaCaminhoRelatorio,VpaNomFilial, VpaNomProduto : String);
    procedure ImprimeNotaFiscalEntrada(VpaCodFilial,VpaSeqNota : integer;VpaVisualizar : Boolean);
    procedure ImprimeOrdemSerra(VpaCodFilial, VpaSeqOrdemProducao : Integer);
    procedure ImprimeEtiquetaProduto10X3A4;
    procedure ImprimeEtiquetaProduto20X4A4;
    procedure ImprimePedidosEmAbertoPorEstagio(VpaCodEstagio, VpaCodTransportadora: Integer;VpaCaminho, VpaNomEstagio : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeFilaChamadosPorTecnico(VpaCodEstagio,VpaCodTecnico : Integer;VpaCaminhoRelatorio, VpaNomEstagio,VpaNomTecnico : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeFichaDesenvolvimento(VpaCodAmostra : Integer);
    procedure ImprimeExtratoColetaFracaoUsuario(VpaDatInicio, VpaDatFim : TDatetime;VpaCodCelula : Integer;VpaNomCelula : String);
    procedure ImprimeAutorizacaoPagamento(VpaCodFilial,VpaLanPagar, VpaNumParcela : Integer;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeTotalClientesAtendidoseProdutosVendidosporVendedor(VpaCodClienteMaster : INteger;VpaCaminho, VpaNomClienteMaster : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeEstoqueProdutoporTecnico(VpaCodTEcnico : Integer; VpaCaminho, VpaNomTecnico : String);
    procedure ImprimeProdutosRetornadosComDefeito(VpaCodTEcnico : Integer; VpaCaminho, VpaNomTecnico : String;VpaDatInicio,VpaDatFim : TDateTime);
    procedure ImprimeConsistenciaReservaEstoque(VpaSeProduto : Integer; VpaCaminho, VpaNomProduto : String;VpaDatInicio,VpaDatFim : TDateTime);
    procedure ImprimeVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao, VpaCodTransportadora : Integer;VpaCaminho, VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaCidade, VpaUF,VpaNomTransportadora : String;VpaDatInicio,VpaDatFim : TDatetime);
    procedure ImprimeTotalVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao, VpaCodTransportadora : Integer;VpaCaminho, VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaCidade, VpaUF, VpaNomTransportadora : String;VpaDatInicio,VpaDatFim : TDatetime);
    procedure ImprimeClientesPorVendedor(VpaCodVendedor,VpaCodVendedorPreposto,  VpaCodSituacao, VpaCodClienteMaster : Integer;VpaCaminho, VpaNomVendedor,VpaNomVendedorPreposto, VpaNOmSituacao,VpaCidade,VpaEstado : String;VpaIndCliente,VpaIndFornecedor, VpaIndProspect, VpaIndHotel : Boolean);
    procedure ImprimeTotalVendasCliente(VpaCodVendedor,VpaCodCondicaoPagamento,VpaCodTipoCotacao, VpaCodfilial, VpaCodSituacaoCliente, VpaCodRepresentada : Integer;VpaCaminho, VpaNomVendedor,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaNomfilial,VpaCidade, VpaUF, VpaNomSituacaoCliente, VpaNomRepresentada : String;VpaDatInicio,VpaDatFim : TDatetime;VpaCurvaABC,VpaSomenteClientesAtivos : Boolean);
    procedure ImprimeExtratoColetaFracaoOPProduto(VpaSeqProduto, VpaSeqEstagio : Integer;VpaNomProduto, VpaNomEstagio : String; VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeInventarioProduto(VpaCodFilial, VpaSeqInventario : Integer;VpaCaminho, VpaNomfilial: String);
    procedure ImprimeContasaReceberPorEmissao(VpaCodFilial, VpaCodVendedor : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial, VpaNomVendedor : String;VpaMostrarFrio, VpaSomenteFaturado : Boolean);
    procedure ImprimeTotalProspectPorRamoAtividade(VpaCaminho : string);
    procedure ImprimeProspectPorCeP(VpaSomenteNaoVisitados : boolean; VpaCaminho : string);
    procedure ImprimeNotasFiscaisEmitidasPorNaturezaOperacao(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodClienteMaster,VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaSituacaoNota : Integer);
    procedure ImprimeContasAReceberEmAbertoPorVendedor(VpaDatVencimento : TDateTime;VpaCodVendedor,VpaCodFilial : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomVendedor : String;VpaFundoPerdido, VpaMostrarFrio : Boolean);
    procedure ImprimeTermoImplantacao(VpaCodFilial,VpaNumChamado : Integer;VpaVisualizar : Boolean);
    procedure ImprimeVendasporVendedor(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor,VpaNomTipoCotacao: String);
    procedure ImprimeSolicitacaoCompra(VpaCodFilial, VpaSeqSolicitacao : Integer; VpaVisualizar : Boolean);
    procedure ImprimeProposta(VpaCodFilial, VpaSeqProposta : Integer; VpaVisualizar: Boolean);
    procedure ImprimeFichaTecnicaAmostra(VpaCodAmostra : Integer; VpaVisulizar : Boolean;VpaNomArquivo : String);
    procedure ImprimeFichaTecnicaAmostraCor(VpaCodAmostra, VpaCodCor : Integer; VpaVisulizar : Boolean;VpaNomArquivo : String);
    procedure ImprimeTotalClientesAtendidoseProdutosVendidos(VpaCodClienteMaster : INteger;VpaCaminho, VpaNomClienteMaster : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeCortePendente;
    procedure ImprimeDiasCorte(VpaDatInicio,VpaDatFim : TDateTime;VpaCaminho : String);
    procedure ImprimeHistoricoECobranca(VpaSeqEmail : Integer);
    procedure ImprimePedidosPorCliente(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaSituacaoCotacao, VpaCodCondicaoPagamento: Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor,VpaNomTipoCotacao,VpaNomSituacao, VpaNomCodicaoPagamento : String);
    procedure ImprimeProspectCadastradosporVendedor(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor, VpaCodRamoAtividade, VpaCodMeioDivulgacao : Integer; VpaCaminho,VpaNomVendedor, VpaNomRamoAtividade, VpaCidade, VpaNomMeioDivulgacao: String);
    procedure ImprimeAgenda(VpaCodUsuario,VpaSituacao : Integer;VpaCaminho, VpaNomUsuario,VpaDesSituacao : String;VpaDatInicio,VpaDatFim : TDateTime);
    procedure ImprimeVencimentoContratos(VpaDatInicio,VpaDatFim : TDatetime;VpaCaminho : String;VpaCodVendedor : Integer; VpaNomVendedor : String;VpaSomenteNaoCancelados, VpaFiltrarPeriodo : Boolean);
    procedure ImprimeDuplicata(VpaCodFilial,VpaLanReceber, VpaNumParcela : integer;vpaVisualizar : Boolean);
    procedure ImprimeDuplicataManual(VpaCodFilial: Integer; VpaDDuplicata: TDadosDuplicata);
    procedure ImprimeColetaOP(VpaCodFilial,VpaSeqOrdem,VpaSeqColeta : Integer;VpaVisualizar : Boolean);
    procedure ImprimeOPCadarcoTrancado(VpaCodFilial,VpaSeqOrdem : Integer;VpaVisualizar : Boolean);
    procedure ImprimeAmostrasqueFaltamFinalizar;
    procedure ImprimeQtdAmostrasPorDesenvolvedor(VpaCodDesenvolvedor : Integer;VpaCaminho, VpaNomDesenvolvedor : string;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeClientesPorSituacaoAnalitico(VpaCodVendedor: Integer; VpaCaminho, VpaCidade, VpaNomVendedor: String);
    procedure ImprimeClientesPorSituacaoSintetico(VpaCodVendedor: Integer; VpaCaminho, VpaCidade, VpaNomVendedor: String);
    procedure ImprimeContatoCliente(VpaCodVendedor, VpaCodSituacao: Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVendedor, VpaSituacao: String);
    procedure ImprimeContratosClientes(VpaCodFilial,VpaCodCliente,VpaCodTipoContrato: Integer; VpaCaminho, VpaNomFilial,VpaNomCidade, VpaNomCliente, VpaNomTipoContrato: String);
    procedure ImprimeClientesPorCidadeEEstadoAnalitico(VpaCodVendedor, VpaCodSituacao, VpaCodRamoAtividade: Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVendedor, VpaNomRamoAtividade, VpaSituacao: String);
    procedure ImprimeClientesPorCidadeEEstadoSintetico(VpaCodVendedor, VpaCodSituacao: Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVendedor, VpaSituacao: String);
    procedure ImprimeCartuchoPesadoPorCelula(VpaCodFilial: Integer; VpaDataIni, VpaDatFim: TDateTime; VpaNomFilial,VpaCaminhoRelatorio: String);
    procedure ImprimeEtiquetaMedia(VpaVisualizar : Boolean);
    procedure ImprimeEtiquetaPequena(VpaVisualizar : Boolean);
    procedure ImprimeEtiquetaComposicao(VpaVisualizar : Boolean);
    procedure ImprimeEtiquetaPequenaReferencia(VpaVisualizar : Boolean);
    procedure ImprimeEtiquetaCaixa(VpaVisualizar : boolean);
    procedure ImprimeEtiquetaAmostra(VpaVisualizar : boolean);
    procedure ImprimeNumerosPendentes(VpaCodFilial: Integer; VpaCaminhoRelatorio, VpaNomFilial : String);
    procedure ImprimeClientesCompletos(VpaCodVendedor, VpaSitCli, VpaCodRamoAtividade: Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVend, VpaNomCliente, VpaDescSit, VpaNomRamoAtividade : String);
    procedure ImprimeRequisicaoAmostrasqueFaltamFinalizar(VpaCodCliente,VpaCodVendedor: Integer; VpaCaminho, VpaNomCliente,VpaNomVendedor: String);
    procedure ImprimePagamentoFaccionista(VpaCodFaccionista : Integer;VpaCaminho, VpaNomFaccionista : string;VpaDatInicio, VpaDatFim : tDateTime);
    procedure ImprimeEstoqueChapa(VpaSeqProduto : Integer; VpaCaminho, VpaCodProduto, VpaNomProduto :String);
    procedure ImprimeEmailMedidores(VpaDMedidores : TRBDEmailMedidorCorpo);
    procedure ImprimeProdutosReservasPorCliente(VpaCodCliente: Integer; VpaCaminhoRelatorio, VpaNomCliente : String);
    procedure ImprimeAmostrasPorVendedor(VpaCodCliente, VpaCodVendedor : Integer; VpaCaminhoRelatorio, VpaNomCliente, VpaNomVendedor : String; VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeControleDespachoNota(VpaDNota: TRBDNotaFiscal;VpaDCliente,VpaDTransportadora :  TRBDCliente);
    procedure ImprimePedidoTerceirizacao(VpaCodfilial,VpaSeqPedidoCompra : Integer;VpaVisualizar : Boolean);
    procedure ImprimeClientesPorRegiaoSintetico(VpaCodSituacao : Integer;VpaCaminhoRelatorio, VpaNomSituacao : string);
    procedure ImprimeNotasXOrdemCompra(VpaCodFilial, VpaCodCliente : integer; VpaDataIni, VpaDataFim: TDateTime; VpaCaminhoRelatorio: String);
    procedure ImprimeDestinoProduto(VpaCodFilial, VpaCodCliente, VpaCodProduto, VpaSeqProduto : integer; VpaDataIni, VpaDataFim: TDateTime; VpaCaminhoRelatorio, VpaNomProduto, VpaNomCliente,VpaCodClassificacao, VpaNomClassificacao: String);
    procedure ImprimeClientesSemHistorico(VpaCodVendedor, VpaPreposto, VpaCodSituacaoCliente : Integer;VpaDatIni, VpaDatFim : TDateTime;VpaNomVendedor,VpaNomPreposto,VpaNomSituacaoCliente,VpaNomTipCotacao, VpaCaminhoRelatorio: String);
    procedure ImprimeControleFrete(VpaCodTransportadora, VpaCodCliente, VpaCodFilial : integer; VpaDatIni, VpaDatFim: TDateTime; VpaNomTransportadora, VpaNomCliente,VpaNomFilial ,VpaCaminho : string);
    procedure ImprimeFaturamentoProdutos(VpaCodProduto, VpaCodCliente, VpaCodFilial : integer; VpaDatIni, VpaDatFim: TDateTime; VpaDescProduto, VpaNomCliente,VpaNomFilial ,VpaCaminho : string);
    procedure ImprimeRelatorioPedidoCompra(VpaDatIni, VpaDatFim: TDateTime; VpaFilial: integer; VpaDescFilial, VpaCaminhoRelatorio: String);
    procedure ImprimeConsumoOrdemProducao(VpaCodFilial, VpaSeqOrdem : Integer);
    procedure ImprimeOPAgrupada(VpaCodFilial,VpaSeqOrdem : Integer);
    procedure ImprimeCotacaocomoOrdemProducao(VpaCodFilial,VpaLanOrcamento, VpaQtdVias : Integer);
    procedure ImprimeClientesCadastrados(VpaCodVendedor, VpaCodRamoAtividade : Integer;VpaCaminho,VpaNomVendedor, VpaNomRamoAtividade, VpaCidade : String;VpaIndFiltrarPeriodo, VpaIndCliente,VpaIndProspect,VpaIndFornecedor, VpaIndHotel : Boolean;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeClientesPerdidosPorVendedor(VpaSeqPerdido :Integer);
    procedure ImprimeClientesPerdidosClientes(VpaSeqPerdido : Integer);
    procedure ImprimeClientesPorMeioDivulgacao(VpaCodVendedor: Integer; VpaCaminho, VpaNomVendedor, VpaCidade, VpaUF: string;VpaIndCliente, VpaIndProspect, VpaIndPeriodo: Boolean;VpaDatInicio,VpaDatFim : TDateTime);
    procedure ImprimePedidosPorEstagio(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodVendedor, VpaCodEstagio: Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor : String);
    procedure ImprimeRomaneio(VpaCodFilial,VpaSeqRomaneio : Integer;VpaVisualizar : Boolean);
    procedure ImprimeRelacaoDeRepresentantes(VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomVendedor,VpaNomCidade,VpaNomEstado: String);
    procedure ImprimePedidosProdutosporPeriodo(VpaCodFilial, VpaCodCliente: integer; VpaDatIni, VpaDatFim: TDateTime; VpaCaminhoRelatorio, VpaDesFilial, VpaNomCliente: string);
    procedure ImprimeLimiteCredito(VpaCodCliente: Integer;VpaCaminho, VpaNomCliente: String;VpaLimiteInicial, VpaLimiteFinal : Double; VpaPdf: Boolean);
    procedure ImprimeTransferenciaExterna(VpaSeqTransferencia : integer);
    procedure ImprimeMotivoAtrasoAmostra(VpaDatInicio,VpaDatFim : TDatetime; VpaCaminhoRelatorio: String);
    procedure ImprimeNotasFiscaisdeEntrada(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente: Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente: String);
    procedure ImprimeConhecimentoTransporteEntrada(VpaDatInicio, VpaDatFim: TDateTime; VpaCodFilial, VpaCodTransportadora: Integer; VpaCaminhoRelatorio, VpaNomFilial, VpaNomTransportadora:String);
    procedure ImprimeConhecimentoTransporteSaida(VpaDatInicio, VpaDatFim: TDateTime; VpaCodFilial, VpaCodTransportadora: Integer; VpaCaminhoRelatorio, VpaNomFilial, VpaNomTransportadora:String);
    procedure TesteDataConection;
  end;


var
  dtRave: TdtRave;

implementation

uses APrincipal, FunSql, Constantes, UnSistema,FunData, FunString, funNumeros, funArquivos,
  UnProposta, constmsg;

{$R *.dfm}

{******************************************************************************}
procedure TdtRave.CarregaRaveImagem(rvPagina, rvImagemNome, bdArquivo: String);
var
  B: TRaveBitmap;
  P: TRavePage;
  Jpg: TJpegImage;
begin
  // Cria Objeto JPEGImage para carregar o arquivo Jpeg.
  Jpg := TJpegImage.Create;
  try
    // Pesquisa componentes dentro do projeto rave.
    P := Rave.ProjMan.FindRaveComponent(rvPagina, nil) as TRavePage;
    B := Rave.ProjMan.FindRaveComponent(rvImagemNome, P) as TRaveBitmap;
    B.Image := nil;
    // verifica se existe um JPG referente a imagem
    if FileExists(bdArquivo) then
       begin
          // Carrega o arquivo do disco.
          Jpg.LoadFromFile(bdArquivo);
          // Atribui ao Rave Bitmap component.
          B.Image.Assign(Jpg);
       end;
   finally
      Jpg.Free;
   end;
end;

{******************************************************************************}
procedure TdtRave.ConfiguraRelatorioPDF;
begin
  rvSystem1.DefaultDest := rdFile;
  rvSystem1.DoNativeOutput := false;
  rvSystem1.RenderObject := PDF;
  rvSystem1.OutputFileName := DeletaChars(VplArquivoPDF,'/');
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VplArquivoPDF),false);
end;

{******************************************************************************}
procedure TdtRave.ConfiguraRelatorioRTF;
begin
  rvSystem1.DefaultDest := rdFile;
  rvSystem1.DoNativeOutput := false;
  rvSystem1.RenderObject := RTF;
  rvSystem1.OutputFileName := DeletaChars(VplArquivoRTF,'/');
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VplArquivoRTF),false);
end;

{******************************************************************************}
procedure TdtRave.f(Sender: TObject);
begin
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  VprDFilial := TRBDFilial.Cria;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoParcial(VpaCodFilial, VpaLanOrcamento,  VpaSeqParcial: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Cotacao Parcial '+IntToStr(VpaLanOrcamento);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_COTACAOPARCIAL.rav';
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlabreTabeLa(Principal,'select PAR.CODFILIAL, PAR.LANORCAMENTO, PAR.SEQPARCIAL, PAR.DATPARCIAL, PAR.VALTOTAL, PAR.QTDVOLUME, PAR.PESLIQUIDO, '+
                                 ' ORC.D_DAT_ORC, ORC.T_HOR_ORC, ORC.C_CON_ORC, ORC.I_TIP_FRE, ORC.C_ORD_COM,'+
                                 ' ORC.L_OBS_ORC, ORC.D_DAT_PRE, '+
                                 ' CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_FO1_CLI, '+
                                 ' CLI.C_FON_FAX, CLI.C_END_ELE,CLI.I_COD_CLI, CLI.C_CGC_CLI, CLI.C_INS_CLI, '+
                                 ' CLI.C_CID_CLI, CLI.C_EST_CLI, '+
                                 ' TRA.C_NOM_CLI C_NOM_TRA , '+
                                 ' VEN.C_NOM_VEN, '+
                                 ' PAG.C_NOM_PAG '+
                                 ' from ORCAMENTOPARCIALCORPO PAR, CADORCAMENTOS ORC, CADCLIENTES CLI, CADCLIENTES TRA, CADVENDEDORES VEN, '+
                                 ' CADCONDICOESPAGTO PAG '+
                                 ' WHERE PAR.CODFILIAL = ORC.I_EMP_FIL '+
                                 ' AND PAR.LANORCAMENTO = ORC.I_LAN_ORC '+
                                 ' AND ORC.I_COD_CLI = CLI.I_COD_CLI '+
                                 ' AND '+SQLTextoRightJoin('ORC.I_COD_TRA','TRA.I_COD_CLI')+
                                 ' AND ORC.I_COD_VEN = VEN.I_COD_VEN '+
                                 ' AND ORC.I_COD_PAG = PAG.I_COD_PAG '+
                                 ' AND PAR.CODFILIAL =  '+IntToStr(VpaCodFilial)+
                                 ' AND PAR.LANORCAMENTO = '+IntToStr(VpaLanOrcamento)+
                                 ' and PAR.SEQPARCIAL = '+IntToSTr(VpaSEqParcial));
  AdicionaSqlabreTabela(Item,'select ITE.CODFILIAL, ITE.LANORCAMENTO, ITE.SEQPARCIAL, '+
                             ' ITE.VALPRODUTO, ITE.DESUM, ITE.VALTOTAL, ITE.QTDPARCIAL, '+
                             ' PRO.C_COD_PRO,  PRO.C_NOM_PRO, '+
                             ' COR.NOM_COR '+
                             ' from ORCAMENTOPARCIALITEM ITE, CADPRODUTOS PRO, COR '+
                             '  WHERE PRO.I_SEQ_PRO = ITE.SEQPRODUTO '+
                             '  AND '+SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                             '  AND ITE.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             '  AND ITE.LANORCAMENTO = '+IntToStr(VpaLanOrcamento)+
                             ' and ITE.SEQPARCIAL = '+IntToSTr(VpaSEqParcial));
  AdicionaSqlabreTabela(Item2,'select MOV.N_VLR_PAR, MOV.I_NRO_PAR, MOV.D_DAT_VEN '+
                              ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                              ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_REC = MOV.I_LAN_REC'+
                              ' AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND CAD.I_NRO_NOT = '+IntToStr(VpaLanOrcamento)+
                              ' and CAD.I_SEQ_PAR = '+IntToSTr(VpaSEqParcial));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotasFiscaisdeEntrada(VpaDatInicio,
  VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente: Integer;
  VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Notas Fiscais de Entrada Emitidas';
  Rave.projectfile := varia.PathRelatorios+'\Compra\0200ES_Notas de Entrada.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_EMI, CAD.C_COD_NAT, CAD.I_NRO_NOT, CAD.N_TOT_NOT,' +
                             ' CAD.N_VLR_ICM, CAD.N_TOT_IPI, ' +
                             ' CAD.N_TOT_PRO, '+
                             ' CLI.C_NOM_CLI ' +
                             ' from CADNOTAFISCAISFOR CAD, CADCLIENTES CLI ' +
                             ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                             ' AND CAD.D_DAT_EMI BETWEEN '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                             ' AND ' +SQLTextoDataAAAAMMMDD(VpaDatFim));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.D_DAT_EMI, CAD.I_NRO_NOT ');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotasFiscaisEmitidas(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodClienteMaster, VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaSituacaoNota : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Notas fiscais emitidas';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\1000FA_Notas Fiscais Emitidas.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_EMI, CAD.C_COD_NAT, CAD.I_NRO_NOT, CAD.N_TOT_NOT, CAD.C_TIP_NOT,' +
                             ' CAD.N_VLR_ICM, CAD.N_TOT_IPI, CAD.C_NOT_IMP, CAD.C_NOT_CAN, CAD.C_FIN_GER, ' +
                             ' CAD.N_TOT_PRO, CAD.C_NOT_INU, '+
                             ' CLI.C_NOM_CLI ' +
                             ' from CADNOTAFISCAIS CAD, CADCLIENTES CLI ' +
                             ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                             ' AND CAD.D_DAT_EMI BETWEEN '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                             ' AND ' +SQLTextoDataAAAAMMMDD(VpaDatFim));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  case VpaSituacaoNota of
    1 : Principal.sql.add('AND( CAD.C_NOT_CAN = ''S'' OR CAD.C_NOT_INU = ''S'') ');
    2 : Principal.sql.add('AND CAD.C_NOT_CAN = ''N''');
  end;
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodClienteMaster <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.D_DAT_EMI, CAD.I_NRO_NOT ');
  Principal.open;
//  salvasql;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotasFiscaisEmitidasPorNaturezaOperacao(VpaDatInicio, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente,
  VpaCodClienteMaster, VpaCodVendedor: Integer; VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente, VpaNomVendedor: String;
  VpaSituacaoNota: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Notas fiscais emitidas por Natureza Operacao';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\2000FA_Notas Fiscais Emitidas por Natureza Operacao.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_EMI, CAD.C_COD_NAT, CAD.I_NRO_NOT, CAD.N_TOT_NOT, CAD.C_TIP_NOT,' +
                             ' CAD.N_VLR_ICM,CAD.N_VLR_SUB, CAD.N_TOT_IPI, CAD.C_NOT_IMP, CAD.C_NOT_CAN, CAD.C_FIN_GER, ' +
                             ' CAD.N_TOT_PRO, '+
                             ' CLI.C_NOM_CLI,  ' +
                             ' NAT.C_NOM_NAT '+
                             ' from CADNOTAFISCAIS CAD, CADCLIENTES CLI, CADNATUREZA NAT ' +
                             ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                             ' AND CAD.C_COD_NAT = NAT.C_COD_NAT '+
                             ' AND CAD.D_DAT_EMI BETWEEN '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                             ' AND ' +SQLTextoDataAAAAMMMDD(VpaDatFim));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  case VpaSituacaoNota of
    1 : Principal.sql.add('AND CAD.C_NOT_CAN = ''S''');
    2 : Principal.sql.add('AND CAD.C_NOT_CAN = ''N''');
  end;
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodClienteMaster <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.C_COD_NAT, CAD.I_NRO_NOT');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotasXOrdemCompra(VpaCodFilial, VpaCodCliente: integer;
  VpaDataIni, VpaDataFim: TDateTime; VpaCaminhoRelatorio: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Notas X Ordem de Compras Sintético';
  Rave.projectfile := varia.PathRelatorios+'\Compra\0100ES_Notas X Ordem Compras Sintetico.rav'; //Verificar
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' select '+ SQLTextoAno('D_DAT_EMI') + 'Ano,' + SQLTextoMes('D_DAT_EMI') + ' Mes, COUNT(I_EMP_FIL), C_ORI_PEC ' +
                              ' from cadnotafiscaisfor ' +
                              ' WHERE ' + SQLTextoDataEntreAAAAMMDD('D_DAT_EMI', VpaDataIni, VpaDataFim, false) +
                              ' AND D_DAT_EMI <= to_date (''' + DateToStr(VpaDataFim) + ''', ''DD/MM/YYYY'') ');

  if VpaCodFilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,' AND I_EMP_FIL = '+ IntToStr(VpaCodFilial));
    Rave.SetParam('FILIAL', IntToStr(VpaCodFilial));
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,' AND I_COD_CLI = '''+ IntToStr(VpaCodCliente) + '''');
    Rave.SetParam('CODCLIENTE', IntToStr(VpaCodCliente));
  end;

  AdicionaSqlTabeLa(Principal,'GROUP BY EXTRACT(year FROM D_DAT_EMI), EXTRACT(MONTH FROM D_DAT_EMI), C_ORI_PEC');
  AdicionaSqlTabeLa(Principal,'order by 1,2');
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidosPorDia(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaSituacaoCotacao, VpaCodCondicaoPagamento, VpaSeqProduto, VpaCodRepresentada, VpaCodPresposto: Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor,VpaNomTipoCotacao,VpaNomSituacao, VpaNomCodicaoPagamento, VpaNomProduto, VpaNomRepresentada, VpaNomPreposto, VpaCodClassificacaoProduto, VpaNomClassificacaoProduto,VpaUF : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos por dia';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\1000PL_Pedidos por Dia.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'Select CAD.D_DAT_ORC, CAD.I_EMP_FIL, CAD.I_LAN_ORC, ' +
                        ' CAD.D_DAT_PRE,  CAD.D_DAT_ENT, CAD.I_COD_CLI , CAD.C_IND_CAN , '+
                        ' CLI.C_NOM_CLI, ' +
                        ' N_VLR_TOT, PAG.I_COD_PAG, PAG.C_NOM_PAG ' );
  AdicionaSqlTabeLa(Principal,'from cadorcamentos CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG ');
  AdicionaSqlTabeLa(Principal,'WHERE CAD.I_COD_CLI = CLI.I_COD_CLI '+
                        ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                        ' AND CAD.C_IND_CAN = ''N'''+
                        SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodPresposto <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_VEN_PRE = '+InttoStr(VpaCodPresposto));
    Rave.SetParam('CLIENTE',VpaNomPreposto);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+VpaUF+'''');
    Rave.SetParam('UF',VpaNomPreposto);
  end;
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,' AND EXISTS(SELECT * FROM MOVORCAMENTOS MOV          ' +
                                ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL             ' +
                                '   AND MOV.I_LAN_ORC = CAD.I_LAN_ORC             ' +
                                '   AND MOV.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) +
                                ' ) ');
    Rave.SetParam('PRODUTO',VpaNomProduto);
  end;

  if VpaCodClassificacaoProduto <> '' then
  begin
    AdicionaSqlTabeLa(Principal,' AND EXISTS(SELECT * FROM MOVORCAMENTOS MOV, CADPRODUTOS PRO ' +
                                ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL             ' +
                                '   AND MOV.I_LAN_ORC = CAD.I_LAN_ORC             ' +
                                '   AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                                ' AND PRO.C_COD_CLA = '''+VpaCodClassificacaoProduto+''''+
                                ' ) ');
    Rave.SetParam('CLASSIFICACAO',VpaNomClassificacaoProduto);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodRepresentada <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_REP = '+InttoStr(VpaCodRepresentada));
    Rave.SetParam('REPRESENTADA',VpaNomRepresentada);
  end;
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCodicaoPagamento);
  end;
  if VpaSituacaoCotacao = 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.C_FLA_SIT = ''A''');
    Rave.SetParam('SITUACAOCOTACAO','Em Aberto');
  end
  else
    if VpaSituacaoCotacao = 1 then
    begin
      AdicionaSqlTabeLa(Principal,'AND CAD.C_FLA_SIT = ''E''');
      Rave.SetParam('SITUACAOCOTACAO','Entregue');
    end
    else
      Rave.SetParam('SITUACAOCOTACAO','Todas');

  if (varia.CNPJFilial = CNPJ_Kairos) or (varia.CNPJFilial = CNPJ_AviamentosJaragua) then
    AdicionaSqlTabeLa(Principal,' and CAD.I_EMP_FIL <> 13 ');

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.D_DAT_ORC,CAD.I_LAN_ORC');
  Principal.open;

  Rave.Execute;
end;

procedure TdtRave.ImprimePedidosPorEstagio(VpaDatInicio, VpaDatFim: TDateTime;
  VpaCodFilial, VpaCodCliente, VpaCodVendedor, VpaCodEstagio: Integer;
  VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente, VpaNomVendedor: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos por estagio';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\7000PL_Pedidos por Estagio.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'Select CAD.D_DAT_ORC, CAD.I_EMP_FIL, CAD.I_LAN_ORC, ' +
                        ' CAD.D_DAT_PRE,  CAD.D_DAT_ENT, CAD.I_COD_CLI , CAD.C_IND_CAN , '+
                        ' CLI.C_NOM_CLI, ' +
                        ' N_VLR_TOT, PAG.I_COD_PAG, PAG.C_NOM_PAG, EST.DATESTAGIO, EST.CODESTAGIO  ' );
  AdicionaSqlTabeLa(Principal,'from cadorcamentos CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG, ESTAGIOORCAMENTO EST ');
  AdicionaSqlTabeLa(Principal,'WHERE CAD.I_COD_EST = ' + IntToStr(VpaCodEstagio)+ SQLTextoDataEntreAAAAMMDD('EST.DATESTAGIO',VpaDatInicio,VpaDatFim,true) +
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                              ' AND CAD.C_IND_CAN = ''N'''+
                        ' AND CAD.I_EMP_FIL = EST.CODFILIAL ' +
                        ' AND CAD.I_LAN_ORC = EST.LANORCAMENTO ' +
                        ' AND CAD.I_COD_EST = EST.CODESTAGIO '  );


  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.D_DAT_ORC,CAD.I_LAN_ORC');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidosProdutosporPeriodo(VpaCodFilial,
  VpaCodCliente: integer; VpaDatIni, VpaDatFim: TDateTime; VpaCaminhoRelatorio,
  VpaDesFilial, VpaNomCliente: string);
begin

end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoTerceirizacao(VpaCodfilial, VpaSeqPedidoCompra: Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedido Terceirizacao';
  Rave.projectfile := varia.PathRelatorios+'\Compra\xx_Pedido de Terceirizacao.rav';
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Rave.clearParams;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  LimpaSqlTabela(Principal);
  AdicionaSqlAbreTabeLa(Principal,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                                  ' ITE.LARCHAPA, ITE.COMCHAPA, ITE.QTDCHAPA , ITE.QTDPRODUTO, ITE.SEQITEM, '+
                                  ' PED.CODFILIAL, PED.SEQPEDIDO, PED.DATPEDIDO, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_FO1_CLI, '+
                                  ' COM.NOMCOMPRADOR '+
                                  ' from  PEDIDOCOMPRAITEM ITE, PEDIDOCOMPRACORPO PED, CADPRODUTOS PRO, '+
                                  '  CADCLIENTES CLI, COMPRADOR COM '+
                                  ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND ITE.CODFILIAL = PED.CODFILIAL '+
                                  ' AND ITE.SEQPEDIDO = PED.SEQPEDIDO '+
                                  ' AND PED.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND PED.CODCOMPRADOR = COM.CODCOMPRADOR '+
                                  ' and PED.CODFILIAL = '+IntToStr(VpaCodfilial)+
                                  ' AND PED.SEQPEDIDO = '+IntToStr(VpaSeqPedidoCompra));
  AdicionaSQLAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                             ' PMP.CODFILIAL, PMP.SEQPEDIDO, PMP.SEQITEM, PMP.CODCOR, '+
                             ' PMP.QTDPRODUTO, PMP.QTDCHAPA, PMP.LARCHAPA, PMP.COMCHAPA '+
                             ' from PEDIDOCOMPRAITEMMATERIAPRIMA PMP, CADPRODUTOS PRO '+
                             ' Where PMP.CODFILIAL = '+IntToStr(VpaCodfilial)+
                             ' AND PMP.SEQPEDIDO = '+IntToStr(VpaSeqPedidoCompra)+
                             ' AND PMP.SEQPRODUTO = PRO.I_SEQ_PRO');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProdutoFornecedor(VpaCodCliente: integer; VpaCaminho,
  VpaNomCliente: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Produtos Fornecedor';
  Rave.projectfile := varia.PathRelatorios+'\COMPRA\0300ES_Produtos Fornecedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT PRO.C_COD_PRO, PRO.C_NOM_PRO,  ' +
                              ' PFO.VALUNITARIO, PFO.PERIPI, PFO.DATULTIMACOMPRA, PFO.NUMDIAENTREGA, PFO.DESREFERENCIA, ' +
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_NOM_REP, CLI.C_FON_REP, CLI.C_COM_END, TRA.C_NOM_CLI C_NOM_TRA  ' +
                              ' FROM PRODUTOFORNECEDOR PFO, CADPRODUTOS PRO, CADCLIENTES CLI, CADCLIENTES TRA ' +
                              ' WHERE PFO.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                              ' AND PFO.CODCLIENTE = CLI.I_COD_CLI ' +
                              ' AND ' + SQLTextoRightJoin('CLI.I_COD_TRA', 'TRA.I_COD_CLI'));

  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND PFO.CODCLIENTE = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end
  else
    Rave.SetParam('CLIENTE','TODOS');

  AdicionaSqlTabeLa(Principal,' ORDER BY PRO.C_NOM_PRO');
  Principal.open;
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProdutosPendenteaProduzir(VpaCodFilial: integer; VpaDatInicio,
  VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Produtos Pendentes a Produzir ';
  Rave.projectfile := varia.PathRelatorios+'\Chamado\XX_PRODUTOSPENDENTESAPRODUZIR.rav';
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSQlAbreTabela(Principal,'SELECT CHM.DATCHAMADO, CHM.NUMCHAMADO, CLI.C_NOM_CLI, PRO.C_NOM_PRO, CHP.QTDPRODUTO, ' +
                                  ' CHP.DESUM, CPR.C_NOM_PRO, CPP.QTDPRODUTO, CPP.DESUM ' +
                                  ' FROM CHAMADOCORPO CHM, CADCLIENTES CLI, CHAMADOPRODUTO CHP, CADPRODUTOS PRO, ' +
                                  ' CHAMADOPRODUTOAPRODUZIR CPP, CADPRODUTOS CPR ' +
                                  ' WHERE CHM.CODFILIAL = ' + IntToStr(VpaCodFilial) +
                                  ' AND CHM.CODCLIENTE = CLI.I_COD_CLI ' +
                                  ' AND CHP.CODFILIAL = CHM.CODFILIAL ' +
                                  ' AND CHP.NUMCHAMADO = CHM.NUMCHAMADO ' +
                                  ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                  ' AND CPP.CODFILIAL = CHM.CODFILIAL ' +
                                  ' AND CPP.NUMCHAMADO = CHM.NUMCHAMADO ' +
                                  ' AND CPP.SEQITEM = CHP.SEQITEM ' +
                                  ' AND CPP.SEQPRODUTO  = CPR.I_SEQ_PRO' );
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProdutosReservasPorCliente(VpaCodCliente: Integer; VpaCaminhoRelatorio, VpaNomCliente: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Produtos Reservas por Cliente';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\3000ESPL_Produtos Reservas Por Cliente.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT PRV.CODCLIENTE, PRV.SEQRESERVA, CLI.C_NOM_CLI, ' +
                              '        PRV.DATULTIMACOMPRA, PRV.SEQPRODUTO, ' +
                              '        PRV.CODPRODUTO, PRO.C_NOM_PRO, ' +
                              '        PRV.QTDDIASCONSUMO, PRV.INDCLIENTE, ' +
                              '        PRV.QTDPRODUTO ' +
                              '   FROM PRODUTORESERVA PRV, CADPRODUTOS PRO, CADCLIENTES CLI ' +
                              '  WHERE PRV.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              '    AND CLI.I_COD_CLI = PRV.CODCLIENTE');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND PRV.CODCLIENTE = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY PRV.CODCLIENTE');
  Principal.open;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProdutosRetornadosComDefeito(VpaCodTEcnico: Integer; VpaCaminho, VpaNomTecnico: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Produtos Retornados com Defeito';
  Rave.projectfile := varia.PathRelatorios+'\Produto\2500ES_Produtos Retornados com Defeito.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select PRO.C_NOM_PRO, '+
                              ' PDE.DATMOVIMENTO, PDE.QTDPRODUTO, PDE.DESUM, PDE.DESDEFEITO, '+
                              ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                              ' From CADPRODUTOS PRO,  PRODUTODEFEITO PDE, TECNICO TEC '+
                              ' Where PDE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' AND PDE.CODTECNICO = TEC.CODTECNICO');
  if VpaCodTEcnico <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND TEC.CODTECNICO = '+InttoStr(VpaCodTecnico));
    Rave.SetParam('TECNICO','Técnico : '+VpaNomTecnico);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('PDE.DATMOVIMENTO',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' ORDER BY  TEC.NOMTECNICO, PDE.DATMOVIMENTO');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePromissoria(VpaDFilial: TRBDFilial; VpaDCliente : TRBDCliente; VpaDesDuplicata, VpaValDuplicata,VpaValExtenso,VpaLocaleData, VpaDiaVencimento,VpaDiaVencExtenso,VpaAnoVencimento,VpaDesMesVencimento : String;VpaVisualizar : Boolean);
var
   VpfComplemento: String;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Promissória';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\XX_Promissoria.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaDFilial.CodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  if deletaespaco(VpaDCliente.DesComplementoEndereco) = '' then
    VpfComplemento := ''
  else
    VpfComplemento := ' - '+VpaDCliente.DesComplementoEndereco;

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEndereco+', '+VpaDCliente.NumEndereco+ VpfComplemento);
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairro);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepCliente);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidade);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUF);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContato);
  Rave.SetParam('CPFCLIENTE',VpaDCliente.CGC_CPF);
  Rave.SetParam('DESDATADUPLICATA',VpaLocaleData);
  Rave.SetParam('DESDUPLICATA',VpaDesDuplicata);
  Rave.SetParam('VALDUPLICATA',VpaValDuplicata);
  Rave.SetParam('VALEXTENSO',VpaValExtenso);
  Rave.SetParam('DIAVENCIMENTO',VpaDiaVencimento);
  Rave.SetParam('DIAVENCIMENTOEXT',VpaDiaVencExtenso);
  Rave.SetParam('ANOVENCIMENTO',VpaAnoVencimento);
  Rave.SetParam('DESMESVENCIMENTO',VpaDesMesVencimento);
  Rave.SetParam('RESPONSAVEL',VpaDFilial.NomRepresentante);
  Rave.SetParam('CPFRESPONSAVEL',VpaDFilial.DesCPFRepresentante);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedido(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean; VpaProtocoloCracha: Boolean = false);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Cotação '+IntToStr(VpaNumPedido);
  if NomeModulo = 'PDV' then
  begin
    Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_DAV.rav';
  end
  else
  begin
    if not VpaProtocoloCracha then
      Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_Cotacao.rav'
    else
      Rave.projectfile := varia.PathRelatorios+'\Cotacao\xx_protocolo_cracha.rav';
  end;
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_CON_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, CAD.C_ORD_COM, CAD.N_VLR_TOT, '+
                                  ' CAD.D_DAT_PRE, CAD.L_OBS_ORC, CAD.I_TIP_FRE, CAD.N_VLR_PRO, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.T_HOR_ENT, C_OBS_FIS,'+
                                  ' CAD.N_VLR_TRO, CAD.N_QTD_TRA, CAD.C_ESP_TRA, CAD.C_MAR_TRA, CAD.N_PES_BRU, CAD.N_PES_LIQ, '+
                                  '  CAD.D_DAT_VAL, CAD.N_VAL_TAX, CAD.C_OBS_FIS, CAD.I_TIP_GRA, CAD.C_DES_SER,'+
                                  ' TIP.I_COD_TIP, TIP.C_NOM_TIP, TEC.NOMTECNICO, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, CLI.C_CPF_CLI, CLI.C_TIP_PES, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FO2_CLI, CLI.C_FON_CEL, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  '  CLI.C_END_COB, CLI.C_BAI_COB, CLI.I_NUM_COB, CLI.C_CID_COB, CLI.C_EST_COB, CLI.C_CEP_COB, CLI.C_CPF_CLI, CLI.C_TIP_PES, '+
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                                  ' TRA.C_NOM_CLI C_NOM_TRA, TRA.C_FO1_CLI C_FON_TRA, '+
                                  ' PAG.C_NOM_PAG, '+
                                  ' FRM.C_NOM_FRM, '+
                                  ' VEP.C_NOM_VEN VENDEDORPREPOSTO ' +
                                  ' from CADORCAMENTOS CAD, CADTIPOORCAMENTO TIP, CADCLIENTES CLI, CADVENDEDORES VEN, CADCLIENTES TRA, '+
                                  ' CADCONDICOESPAGTO PAG, CADFORMASPAGAMENTO FRM, CADVENDEDORES VEP, TECNICO TEC '+
                                  ' where CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                                  ' AND CAD.I_COD_TEC = TEC.CODTECNICO (+) ' +
                                  ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_CLI')+
                                  ' AND '+SQLTextoRightJoin('CAD.I_VEN_PRE','VEP.I_COD_VEN')+
                                  ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                                  ' AND CAD.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = ' +IntToStr(VpaNumPedido));
  AdicionaSqlAbreTabela(Item,'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, MOV.N_VLR_TOT, MOV.C_NOM_PRO PRODUTOCOTACAO, '+
                             ' MOV.C_IND_BRI, MOV.N_SAL_BRI, MOV.C_DES_COR, MOV.N_ALT_PRO, MOV.N_PER_DES, '+
                             ' MOV.C_DES_COR CORCOTACAO, MOV.C_PRO_REF, MOV.N_PER_DES, MOV.C_ORD_COM, MOV.I_COD_TAM, '+
                             ' COR.COD_COR, COR.NOM_COR, '+
                             ' PRO.C_NOM_PRO, '+
                             ' TAM.NOMTAMANHO, '+
                             ' CLA.C_COD_CLA, CLA.C_NOM_CLA '+
                             ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO, COR, TAMANHO TAM, CADCLASSIFICACAO CLA '+
                             ' where MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                             ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                             ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                             ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                             ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                             ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                             ' ORDER BY MOV.I_SEQ_MOV ');
  AdicionaSqlAbreTabela(Item2,'select SER.I_COD_SER, SER.C_NOM_SER,C_DES_ADI, '+
                             ' MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_VLR_TOT '+
                             ' from  MOVSERVICOORCAMENTO MOV, CADSERVICO SER '+
                             ' WHERE MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_COD_SER = SER.I_COD_SER'+
                             ' and SER.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
  AdicionaSqlAbreTabela(Item3,'SELECT MOV.C_NRO_DUP, MOV.N_VLR_PAR, MOV.D_DAT_VEN, MOV.C_NRO_AGE, MOV.C_NRO_CON, '+
                              ' FRM.I_COD_FRM, FRM.C_NOM_FRM, '+
                              ' BAN.I_COD_BAN, BAN.C_NOM_BAN, '+
                              ' CON.C_NOM_CRR '+
                              ' FROM MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADFORMASPAGAMENTO FRM, CADBANCOS BAN, CADCONTAS CON '+
                              ' WHERE CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND CAD.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                              ' AND MOV.I_COD_FRM = FRM.I_COD_FRM '+
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                              ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                              ' and MOV.D_DAT_PAG IS NULL '+
                              ' AND '+SQLTextoRightJoin('MOV.C_NRO_CON','CON.C_NRO_CON')+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_BAN','BAN.I_COD_BAN'));
  AdicionaSqlAbreTabela(Item4,'SELECT PRO.C_COD_PRO, PRO.C_NOM_PRO, ' +
                              ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, ' +
                              ' MOV.N_TOT_PRO ' +
                              ' FROM CADORCAMENTOS ORC, CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV, CADPRODUTOS PRO ' +
                              ' WHERE ORC.I_EMP_FIL = CAD.I_EMP_FIL ' +
                              ' AND ORC.I_NOT_ENT = CAD.I_SEQ_NOT ' +
                              ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                              ' AND ORC.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND ORC.I_LAN_ORC = '+IntToStr(VpaNumPedido));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeGarantia(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Formulario de Garantia '+IntToStr(VpaNumPedido);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_Garantia.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_CON_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, CAD.C_ORD_COM, CAD.N_VLR_TOT, '+
                                  ' CAD.D_DAT_PRE, CAD.L_OBS_ORC, '+
                                  ' TIP.I_COD_TIP, TIP.C_NOM_TIP, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                                  ' TRA.C_NOM_CLI C_NOM_TRA, '+
                                  ' PAG.C_NOM_PAG, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' from CADORCAMENTOS CAD, CADTIPOORCAMENTO TIP, CADCLIENTES CLI, CADVENDEDORES VEN, CADCLIENTES TRA, '+
                                  '           CADCONDICOESPAGTO PAG, CADFORMASPAGAMENTO FRM '+
                                  ' where CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                                  ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_CLI')+
                                  ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                                  ' AND CAD.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = ' +IntToStr(VpaNumPedido));
  AdicionaSqlAbreTabela(Item,'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, MOV.N_VLR_TOT, '+
                             ' MOV.C_IND_BRI, MOV.N_SAL_BRI, '+
                             ' PRO.C_NOM_PRO '+
                             ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                             ' where MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                             ' ORDER BY MOV.I_SEQ_MOV');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeChamado(VpaCodFilial,VpaNumChamado : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Chamado Técnico '+IntToStr(VpaNumChamado);
  Rave.projectfile := varia.PathRelatorios+'\Chamado\XX_Chamado.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.NOMCONTATO, CHA.NOMSOLICITANTE, CHA.DESENDERECOATENDIMENTO, '+
                                  ' CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.VALCHAMADO,CHA.VALDESLOCAMENTO, CHA.DESOBSERVACAOGERAL, CHA.DESTIPOCHAMADO,'+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' USU.C_NOM_USU, '+
                                  ' TEC.CODTECNICO, TEC.NOMTECNICO, '+
                                  ' HOT.I_COD_CLI CODHOTEL, HOT.C_NOM_CLI NOMHOTEL, HOT.C_END_CLI ENDHOTEL, '+
                                  ' HOT.I_NUM_END NUMHOTEL, HOT.C_COM_END COMENDERECOHOTEL, HOT.C_BAI_CLI BAIHOTEL, '+
                                  ' HOT.C_CID_CLI CIDHOTEL, HOT.C_FO1_CLI FONHOTEL, VEN.C_NOM_VEN '+
                                  ' FROM CHAMADOCORPO CHA, CADCLIENTES CLI, CADUSUARIOS USU, TECNICO TEC, CADCLIENTES HOT, CADVENDEDORES VEN '+
                                  ' Where CHA.CODFILIAL =  '+IntToStr(VpaCodFilial)+
                                  ' AND CHA.NUMCHAMADO = '+IntToStr(VpaNumChamado)+
                                  ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND CHA.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND CHA.CODTECNICO = TEC.CODTECNICO'+
                                  ' AND '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN') +
                                  ' AND '+SQLTextoRightJoin('CHA.CODHOTEL','HOT.I_COD_CLI'));
  AdicionaSqlAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_CTB,  '+
                             ' CHP.NUMSERIE, CHP.NUMCONTADOR, CHP.NUMSERIEINTERNO,CHP.DESSETOR, CHP.DESPROBLEMA, '+
                             ' CHP.DESSERVICOEXECUTADO, CHP.DATGARANTIA, CHP.VALBACKUP, '+
                             ' TIP.NOMTIPOCONTRATO '+
                             ' from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                             ' Where CHP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND CHP.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                             ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND '+SQLTEXTORightJoin('CHP.CODFILIALCONTRATO','CON.CODFILIAL')+
                             ' AND '+SQLTEXTORightJoin('CHP.SEQCONTRATO','CON.SEQCONTRATO')+
                             ' AND '+SQLTEXTORightJoin('CON.CODTIPOCONTRATO','TIP.CODTIPOCONTRATO'));

  AdicionaSqlAbreTabela(Item2, 'SELECT ORC.CODFILIAL, ORC.NUMCHAMADO, ORC.SEQITEM, ORC.SEQPRODUTO, ORC.DESNUMSERIE,' +
                               ' PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_PRO,ORC.QTDPRODUTO, ORC.VALUNITARIO, ORC.VALTOTAL, ORC.DESUM ' +
                               ' FROM CHAMADOPRODUTOORCADO ORC, CADPRODUTOS PRO ' +
                               ' WHERE ORC.CODFILIAL = ' + IntToStr(VpaCodFilial)+
                               ' AND ORC.NUMCHAMADO = ' + IntToStr(VpaNumChamado) +
                               ' AND ORC.SEQPRODUTO = PRO.I_SEQ_PRO ');
  Rave.Execute;
  salvaSql;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesSemHistorico(VpaCodVendedor, VpaPreposto,
  VpaCodSituacaoCliente: Integer; VpaDatIni, VpaDatFim: TDateTime;
  VpaNomVendedor, VpaNomPreposto, VpaNomSituacaoCliente, VpaNomTipCotacao,
  VpaCaminhoRelatorio: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes sem historico telemarketing';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0150PL_Clientes Sem Historico Telemarketing.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CON_CLI, CLI.C_CID_CLI,C_EST_CLI, CLI.C_FO1_CLI, CLI.I_COD_VEN , '+
                              ' VEN.C_NOM_VEN ');
  AdicionaSqlTabeLa(Principal,' from CADCLIENTES CLI, CADVENDEDORES VEN'+
                              ' Where CLI.I_COD_VEN = VEN.I_COD_VEN ');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_COD_VEN = '+IntTostr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaPreposto <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_VEN_PRE = '+IntTostr(VpaPreposto));
    Rave.SetParam('PREPOSTO',VpaNomPreposto);
  end;
  if VpaCodSituacaoCliente <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_COD_SIT = '+IntTostr(VpaCodSituacaoCliente));
    Rave.SetParam('SITUACAOCLIENTE',VpaNomSituacaoCliente);
  end;
  AdicionaSqlTabela(Principal,' AND not exists (select * from TELEMARKETING TEL '+
                              ' where TEL.CODCLIENTE = CLI.I_COD_CLI ');

  AdicionaSQLTabela(Principal,'and ' + SQLTextoDataEntreAAAAMMDD('TEL.DATLIGACAO', VpaDatIni, VpaDatFim, false)+ ')');
  Rave.SetParam('DATA',FormatDatetime('DD/MM/YYYY',VpaDatIni));
  Rave.SetParam('DATAFIM',FormatDatetime('DD/MM/YYYY',VpaDatFim));
  AdicionaSQLTabela(Principal,' and (c_ind_cli = ''S'' or c_ind_prc = ''S'')');
  AdicionaSQLTabela(Principal,'order by ven.i_cod_ven, cli.c_est_cli, cli.c_cid_cli, cli.c_nom_cli');
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Principal.open;
  Rave.Execute;

end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesSemPedido(VpaCodVendedor, VpaPreposto,  VpaCodSituacaoCliente, VpaCodTipoCotacao, VpaCodRepresentada : Integer; VpaDatDesde, VpaDatInicio, VpaDatFim: TDateTime;  VpaNomVendedor, VpaNomPreposto, VpaNomSituacaoCliente, VpaNomTipCotacao, VpaNomRepresentanda,VpaCaminhoRelatorio: String; VpaSomenteClientesAtivos,VpaIndPeriodoCadastro : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes sem pedido';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0100PL_Clientes Sem Pedido.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CON_CLI, CLI.C_CID_CLI,C_EST_CLI, CLI.C_FO1_CLI, CLI.I_COD_VEN , '+
                              ' VEN.C_NOM_VEN ');
  AdicionaSqlTabeLa(Principal,' from CADCLIENTES CLI, CADVENDEDORES VEN '+
                              ' Where CLI.I_COD_VEN = VEN.I_COD_VEN '+
                              ' AND CLI.C_IND_CLI = ''S''');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_COD_VEN = '+IntTostr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaPreposto <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_VEN_PRE = '+IntTostr(VpaPreposto));
    Rave.SetParam('PREPOSTO',VpaNomPreposto);
  end;
  if VpaCodSituacaoCliente <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_COD_SIT = '+IntTostr(VpaCodSituacaoCliente));
    Rave.SetParam('SITUACAOCLIENTE',VpaNomSituacaoCliente);
  end;
  if VpaSomenteClientesAtivos then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_IND_ATI = ''S''');
  end;
  if VpaIndPeriodoCadastro then
  begin
    AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CLI.D_DAT_CAD',VpaDatInicio,VpaDatFim,true));
    Rave.SetParam('DATACADASTRO',FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até : '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  end;

  AdicionaSqlTabela(Principal,' AND not exists (select * from CADORCAMENTOS CAD '+
                              ' where CAD.I_COD_CLI = CLI.I_COD_CLI ');
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSQLTabela(Principal,'and CAD.I_TIP_ORC ='+IntToStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipCotacao);
  end;
  if VpaCodSituacaoCliente <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_COD_SIT = '+IntTostr(VpaCodSituacaoCliente));
    Rave.SetParam('SITUACAOCLIENTE',VpaNomSituacaoCliente);
  end;
  if VpaCodRepresentada <> 0  then
  begin
    AdicionaSqlTabela(Principal,'and CAD.I_COD_REP = '+IntTostr(VpaCodRepresentada));
    Rave.SetParam('REPRESENTADA',VpaNomRepresentanda);
  end;
  AdicionaSQLTabela(Principal,'and CAD.D_DAT_ORC >='+SQLTextoDataAAAAMMMDD(VpaDatDesde)+')');
  Rave.SetParam('DATA',FormatDatetime('DD/MM/YYYY',VpaDatDesde));
  //AdicionaSQLTabela(Principal,' and c_ind_cli = ''S'')');
  AdicionaSQLTabela(Principal,'order by ven.i_cod_ven, cli.c_est_cli, cli.c_cid_cli, cli.c_nom_cli');
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);


  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeChamadodaCotacao(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Chamado '+IntToStr(VpaNumPedido);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_Chamado.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_CON_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, CAD.C_ORD_COM, CAD.N_VLR_TOT, '+
                                  ' CAD.D_DAT_PRE, CAD.L_OBS_ORC, CAD.I_TIP_FRE,  CAD.C_DES_CHA, '+
                                  ' TIP.I_COD_TIP, TIP.C_NOM_TIP, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                                  ' USU.C_NOM_USU '+
                                  ' from CADORCAMENTOS CAD, CADTIPOORCAMENTO TIP, CADCLIENTES CLI, CADVENDEDORES VEN, CADUSUARIOS USU '+
                                  ' where CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                                  ' AND CAD.I_COD_USU = USU.I_COD_USU '+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = ' +IntToStr(VpaNumPedido));
  AdicionaSqlAbreTabela(Item,'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, MOV.N_VLR_TOT, '+
                             ' MOV.C_IND_BRI, MOV.N_SAL_BRI, MOV.C_DES_COR, '+
                             ' PRO.C_NOM_PRO '+
                             ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                             ' where MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                             ' ORDER BY MOV.I_SEQ_MOV');
  AdicionaSqlAbreTabela(Item2,'select SER.I_COD_SER, SER.C_NOM_SER,'+
                             ' MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_VLR_TOT '+
                             ' from  MOVSERVICOORCAMENTO MOV, CADSERVICO SER '+
                             ' WHERE MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_COD_SER = SER.I_COD_SER');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeChamadoProducao(VpaCodFilial, VpaNumChamado: Integer;
  VpaVisualizar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Chamado Técnico '+IntToStr(VpaNumChamado);
  Rave.projectfile := varia.PathRelatorios+'\Chamado\XX_ChamadoProducao.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.NOMCONTATO, CHA.NOMSOLICITANTE, CHA.DESENDERECOATENDIMENTO, '+
                                  ' CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.VALCHAMADO,CHA.VALDESLOCAMENTO, CHA.DESOBSERVACAOGERAL,'+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' USU.C_NOM_USU, '+
                                  ' TEC.CODTECNICO, TEC.NOMTECNICO, '+
                                  ' HOT.I_COD_CLI CODHOTEL, HOT.C_NOM_CLI NOMHOTEL, HOT.C_END_CLI ENDHOTEL, '+
                                  ' HOT.I_NUM_END NUMHOTEL, HOT.C_COM_END COMENDERECOHOTEL, HOT.C_BAI_CLI BAIHOTEL, '+
                                  ' HOT.C_CID_CLI CIDHOTEL, HOT.C_FO1_CLI FONHOTEL, VEN.C_NOM_VEN '+
                                  ' FROM CHAMADOCORPO CHA, CADCLIENTES CLI, CADUSUARIOS USU, TECNICO TEC, CADCLIENTES HOT, CADVENDEDORES VEN '+
                                  ' Where CHA.CODFILIAL =  '+IntToStr(VpaCodFilial)+
                                  ' AND CHA.NUMCHAMADO = '+IntToStr(VpaNumChamado)+
                                  ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND CHA.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND CHA.CODTECNICO = TEC.CODTECNICO'+
                                  ' AND '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN') +
                                  ' AND '+SQLTextoRightJoin('CHA.CODHOTEL','HOT.I_COD_CLI'));
  AdicionaSqlAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                             ' CHP.NUMSERIE, CHP.NUMCONTADOR, CHP.NUMSERIEINTERNO,CHP.DESSETOR, CHP.DESPROBLEMA, '+
                             ' CHP.DESSERVICOEXECUTADO, CHP.DATGARANTIA, CHP.VALBACKUP, '+
                             ' TIP.NOMTIPOCONTRATO '+
                             ' from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                             ' Where CHP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND CHP.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                             ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND '+SQLTEXTORightJoin('CHP.CODFILIALCONTRATO','CON.CODFILIAL')+
                             ' AND '+SQLTEXTORightJoin('CHP.SEQCONTRATO','CON.SEQCONTRATO')+
                             ' AND '+SQLTEXTORightJoin('CON.CODTIPOCONTRATO','TIP.CODTIPOCONTRATO'));

  AdicionaSqlAbreTabela(Item2, 'SELECT ORC.CODFILIAL, ORC.NUMCHAMADO, ORC.SEQITEM, ORC.SEQPRODUTO, ' +
                               ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, ORC.QTDPRODUTO, ORC.VALUNITARIO, ORC.VALTOTAL, ORC.DESUM ' +
                               ' FROM CHAMADOPRODUTOORCADO ORC, CADPRODUTOS PRO ' +
                               ' WHERE ORC.CODFILIAL = ' + IntToStr(VpaCodFilial)+
                               ' AND ORC.NUMCHAMADO = ' + IntToStr(VpaNumChamado) +
                               ' AND ORC.SEQPRODUTO = PRO.I_SEQ_PRO ');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoCompra(VpaCodFilial,VpaSeqPedido : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedido Compra '+IntToStr(VpaSeqPedido);
  Rave.projectfile := varia.PathRelatorios+'\Compra\XX_Pedido de Compra.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  AdicionaSqlAbreTabela(Principal,'Select COR.SEQPEDIDO, COR.CODFILIALFATURAMENTO, COR.CODFILIAL, COR.SEQPEDIDO, COR.DATPEDIDO, COR.HORPEDIDO, COR.DATPREVISTA, COR.NOMCONTATO, '+
                                  ' COR.CODCONDICAOPAGAMENTO, COR.VALTOTAL, COR.PERDESCONTO, COR.VALDESCONTO, COR.DESOBSERVACAO, '+
                                  ' COR.VALFRETE, COR.TIPFRETE, '+
                                  ' CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_FO1_CLI, '+
                                  ' CLI.C_FON_FAX, CLI.C_END_ELE,CLI.I_COD_CLI, CLI.C_CGC_CLI, CLI.C_INS_CLI, '+
                                  ' CLI.C_CID_CLI, CLI.C_EST_CLI,CLI.C_COM_END, CLI.C_FON_COM, '+
                                  ' COM.NOMCOMPRADOR , '+
                                  ' USU.C_NOM_USU, '+
                                  ' TRA.C_NOM_CLI C_NOM_TRA, '+
                                  ' FRM.C_NOM_FRM, '+
                                  ' PAG.C_NOM_PAG '+
                                  ' from PEDIDOCOMPRACORPO COR, CADCLIENTES CLI, COMPRADOR COM, '+
                                  ' CADUSUARIOS USU, CADCLIENTES TRA, CADFORMASPAGAMENTO FRM, CADCONDICOESPAGTO PAG '+
                                  ' Where COR.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND COR.CODCOMPRADOR = COM.CODCOMPRADOR '+
                                  ' AND COR.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND '+ SQLTextoRightJoin('COR.CODTRANSPORTADORA','TRA.I_COD_CLI')+
                                  ' AND '+ SQLTextoRightJoin('COR.CODFORMAPAGAMENTO','FRM.I_COD_FRM')+
                                  ' AND '+ SQLTextoRightJoin('COR.CODCONDICAOPAGAMENTO','PAG.I_COD_PAG')+
                                  ' and COR.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                  ' and COR.SEQPEDIDO = ' +IntToStr(VpaSeqPedido));
  AdicionaSqlAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.L_DES_TEC, '+
                             ' ITE.QTDPRODUTO,ITE.VALUNITARIO,ITE.VALTOTAL, ITE.CODCOR, ITE.CODTAMANHO, '+
                             ' ITE.DESUM, ITE.DESREFERENCIAFORNECEDOR, ITE.QTDCHAPA, ITE.COMCHAPA, ITE.LARCHAPA, ITE.PERIPI, ITE.VALIPI,'+
                             ' COR.NOM_COR, '+
                             ' TAM.NOMTAMANHO '+
                             ' from  PEDIDOCOMPRAITEM ITE, CADPRODUTOS PRO, COR COR, TAMANHO TAM '+
                             ' WHERE ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' and ITE.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                             ' and ITE.SEQPEDIDO = ' +IntToStr(VpaSeqPedido)+
                             ' AND '+SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                             ' AND '+SQLTextoRightJoin('ITE.CODTAMANHO','TAM.CODTAMANHO')+
                             ' ORDER BY SEQITEM ');
  Sistema.CarDFilial(VprDFilial,Principal.FieldByName('CODFILIALFATURAMENTO').AsInteger);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEmailMedidores(VpaDMedidores : TRBDEmailMedidorCorpo);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Email''s Medidores';
  Rave.projectfile := varia.PathRelatorios+'\Contrato\xx_Email Medidores.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,' SELECT EMA.DATENVIO, USU.C_NOM_USU' +
                                  '   FROM EMAILMEDIDORCORPO EMA, CADUSUARIOS USU' +
                                  '  WHERE EMA.CODUSUARIO = USU.I_COD_USU ' +
                                  '    AND EMA.SEQEMAIL = ' + IntToStr(VpaDMedidores.SeqEmail));
  AdicionaSqlAbreTabeLa(Item,' SELECT ITE.CODFILIAL, ITE.SEQCONTRATO, ITE.INDENVIADO, ' +
                             '        ITE.DESSTATUS, CLI.C_NOM_CLI ' +
                             '   FROM EMAILMEDIDORITEM ITE, CONTRATOCORPO CON, CADCLIENTES CLI ' +
                             '  WHERE CON.CODCLIENTE = CLI.I_COD_CLI AND ' +
                             '        CON.SEQCONTRATO = ITE.SEQCONTRATO ' +
                             '        AND CON.CODFILIAL = ITE.CODFILIAL ' +
                             '        AND ITE.SEQEMAIL = ' + IntToStr(VpaDMedidores.SeqEmail) +
                             ' ORDER BY ITE.INDENVIADO DESC  ');

  //Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

procedure TdtRave.ImprimeEntradaMateriais(VpaCodFilial, VpaNumChamado,VpaSeqParcial: Integer);
begin
  // Chamado Parcial
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Saida de Material. Chamado Técnico '+IntToStr(VpaNumChamado);
  Rave.projectfile := varia.PathRelatorios+'\Chamado\3000CH_Entrada de Material.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.NOMCONTATO, CHA.NOMSOLICITANTE, CHA.DESENDERECOATENDIMENTO, '+
                                  ' CHA.DATCHAMADO, CHA.DATPREVISAO, CPC.SEQPARCIAL, CPC.DATPARCIAL, CPC.INDFATURADO, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' USU.C_NOM_USU, '+
                                  ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                                  'FROM CHAMADOCORPO CHA, CHAMADOPARCIALCORPO CPC, CADCLIENTES CLI, CADUSUARIOS USU, TECNICO TEC '+
                                  ' Where CHA.CODFILIAL =  ' + IntToStr(VpaCodFilial)+
                                  ' AND CHA.NUMCHAMADO = ' + IntToStr(VpaNumChamado)+
                                  ' AND CPC.SEQPARCIAL = ' + IntToStr(VpaSeqParcial)+
                                  ' AND CHA.CODFILIAL = CPC.CODFILIAL AND CHA.NUMCHAMADO = CPC.NUMCHAMADO ' +
                                  ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND CHA.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND CPC.CODTECNICO = TEC.CODTECNICO'+
                                  ' AND CPC.INDRETORNO = ''S''');
  AdicionaSqlAbreTabela(Item,'select CPP.CODFILIAL, CPP.NUMCHAMADO, CPP.SEQPARCIAL, CPP.QTDPRODUTO, CPP.DESUM, CPP.INDPRODUTOEXTRA, CPP.INDFATURADO, ' +
                             '       PRO.C_COD_PRO, PRO.C_NOM_PRO ' +
                             'from CHAMADOPARCIALPRODUTO CPP, CADPRODUTOS PRO ' +
                             'Where CPP.SEQPRODUTO = PRO.I_SEQ_PRO'+
                             ' AND CPP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND CPP.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                             ' AND CPP.SEQPARCIAL = ' + IntToStr(VpaSeqParcial)+
                             ' ORDER BY SEQITEM');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEnvelope(VpaDCliente : TRBDCliente);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Envelope "'+VpaDCliente.NomCliente+'"';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\XX_Envelope.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,Varia.CodigoEmpFil);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEndereco+', '+VpaDCliente.NumEndereco+ ' - '+VpaDCliente.DesComplementoEndereco);
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairro);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepCliente);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidade);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUF);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContato);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEnvelopeEntrega(VpaDCliente : TRBDCliente);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Envelope "'+VpaDCliente.NomCliente+'"';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\XX_Envelope.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,Varia.CodigoEmpFil);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEnderecoEntrega+', '+VpaDCliente.NumEnderecoEntrega );
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairroEntrega);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepEntrega);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidadeEntrega);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUFEntrega);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContatoEntrega);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEnvelopeCobranca(VpaDCliente : TRBDCliente);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Envelope "'+VpaDCliente.NomCliente+'"';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\XX_Envelope.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,Varia.CodigoEmpFil);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEnderecoCobranca+', '+VpaDCliente.NumEnderecoCobranca );
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairroCobranca);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepClienteCobranca);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidadeCobranca);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUFCobranca);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContatoFinanceiro);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeExtratoColetaFracaoUsuario(VpaDatInicio,VpaDatFim: TDatetime; VpaCodCelula: Integer; VpaNomCelula: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Extrato Coleta Fração Celula '+VpaNomCelula;
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_Extrato Coleta Fracao Celula.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;

  AdicionaSqlAbreTabela(Principal,'SELECT PRO.C_NOM_PRO, ' +
                                  ' COL.CODFILIAL, COL.SEQORDEM, COL.SEQFRACAO, COL.SEQESTAGIO, ' +
                                  ' COL.SEQCOLETA, COL.CODCELULA, COL.DESUM, COL.QTDCOLETADO, ' +
                                  ' COL.QTDPRODUCAOHORA, COL.QTDPRODUCAOIDEAL, ' +
                                  ' COL.PERPRODUTIVIDADE, COL.DATINICIO, COL.DATFIM, ' +
                                  ' to_char(substr(COL.DATINICIO,1,8)) DATA, '+
                                  ' PRE.DESESTAGIO ' +
                                  ' FROM CADPRODUTOS PRO, COLETAFRACAOOP COL, PRODUTOESTAGIO PRE, FRACAOOPESTAGIO FRA ' +
                                  ' WHERE FRA.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                  ' AND FRA.SEQPRODUTO = PRE.SEQPRODUTO ' +
                                  ' AND FRA.SEQESTAGIO = PRE.SEQESTAGIO ' +
                                  ' AND COL.CODFILIAL = FRA.CODFILIAL ' +
                                  ' AND COL.SEQORDEM = FRA.SEQORDEM ' +
                                  ' AND COL.SEQFRACAO = FRA.SEQFRACAO ' +
                                  ' AND COL.SEQESTAGIO = FRA.SEQESTAGIO'+
                                   SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',VpaDatInicio,IncDia(VpaDatFim,1),true)+
                                   ' AND COL.CODCELULA = '+IntToStr(VpaCodCelula)+
                                   ' ORDER BY COL.DATINICIO');
  Rave.SetParam('NOMCELULA',VpaNomCelula);
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeAutorizacaoPagamento(VpaCodFilial,VpaLanPagar, VpaNumParcela : Integer;VpaDatInicio, VpaDatFim : TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Autorização Pagamento '+IntToStr(VpaLanPagar);
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\xx_AutorizacaoPagamento.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Principal.close;
  Principal.sql.clear;
  AdicionaSqlTabela(Principal,'select   CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' CAD.I_LAN_APG, CAD.D_DAT_EMI, CAD.I_QTD_PAR, '+
                              ' MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_DUP, MOV.L_OBS_APG, MOV.I_NRO_PAR, '+
                              ' CLA.C_NOM_PLA '+
                              ' from CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV, CADCLIENTES CLI, CAD_PLANO_CONTA CLA '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND CLA.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                              ' AND CAD.C_CLA_PLA = CLA.C_CLA_PLA '+
                              ' AND CAD.I_EMP_FIL =  '+IntToStr(VpaCodFilial));
  if VpaLanPagar <> 0  then
  begin
    AdicionaSQLTabela(Principal,' AND CAD.I_LAN_APG = ' +IntToStr(VpaLanPagar));
    if VpaNumParcela <> 0  then
      AdicionaSQLTabela(Principal,'AND MOV.I_NRO_PAR = '+IntTosTr(VpaNumParcela));
  end
  else
    AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  AdicionaSQLTabela(Principal,'ORDER BY MOV.I_EMP_FIL, MOV.I_LAN_APG, MOV.I_NRO_PAR ');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeExtratoLocacao(VpaCodFilial, VpaSeqLeitura : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Extrato locação '+IntToStr(VpaSeqLeitura);
  Rave.projectfile := varia.PathRelatorios+'\Contrato\XX_ExtratoLocacao.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'Select  LEI.CODFILIAL, LEI.SEQLEITURA, LEI.DATLEITURA, LEI.VALTOTALDESCONTO, LEI.QTDCOPIA, '+
                                  ' LEI.QTDDEFEITO, LEI.QTDEXCEDENTE, LEI.QTDCOPIACOLOR, LEI.QTDFRANQUIACOLOR, '+
                                  ' LEI.QTDEXCEDENTECOLOR, LEI.VALEXECESSOFRANQUIA, LEI.VALEXECESSOFRANQUIACOLOR, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE , '+
                                  ' CON.QTDFRANQUIA '+
                                  ' from LEITURALOCACAOCORPO LEI, CADCLIENTES CLI, CONTRATOCORPO CON '+
                                  ' Where LEI.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND LEI.CODFILIAL = CON.CODFILIAL '+
                                  ' AND LEI.SEQCONTRATO = CON.SEQCONTRATO '+
                                  ' AND LEI.CODFILIAL = '+InttoStr(VpaCodFilial)+
                                  ' AND LEI.SEQLEITURA = '+IntToStr(VpaSeqLeitura));
  AdicionaSqlAbreTabela(Item,'select ITE.CODFILIAL, ITE.SEQLEITURA, ITE.SEQITEM, ITE.CODPRODUTO, ITE.NUMSERIE, ITE.NUMSERIEINTERNO, ITE.DESSETOR, '+
                             ' ITE.QTDULTIMALEITURA, ITE.QTDLEITURA, ITE.QTDCOPIAS, ITE.QTDULTIMALEITURACOLOR, ITE.QTDLEITURACOLOR, '+
                             ' ITE.QTDCOPIASCOLOR, '+
                             ' PRO.C_COD_CTB, PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                             ' from LEITURALOCACAOITEM ITE, CADPRODUTOS PRO '+
                             ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ITE.CODFILIAL = '+InttoStr(VpaCodFilial)+
                             ' AND ITE.SEQLEITURA = '+IntToStr(VpaSeqLeitura)+
                             ' order by ITE.SEQITEM');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeCaixa(VpaSeqCaixa : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Caixa '+IntToStr(VpaSeqCaixa);
  Rave.projectfile := varia.PathRelatorios+'\Caixa\XX_Caixa.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'SELECT COR.SEQCAIXA, COR.NUMCONTA, COR.DATABERTURA, COR.DATFECHAMENTO, COR.VALINICIAL, COR.VALATUAL, '+
                                  ' ITE.SEQITEM, ITE.VALLANCAMENTO, ITE.DESDEBITOCREDITO, ITE.DESLANCAMENTO, ITE.DATLANCAMENTO, '+
                                  ' ITE.DATPAGAMENTO, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' FROM CAIXACORPO COR, CAIXAITEM ITE, CADFORMASPAGAMENTO FRM '+
                                  ' WHERE '+SQLTextoRightJoin('COR.SEQCAIXA','ITE.SEQCAIXA')+
                                  ' AND '+SQLTextoRightJoin('ITE.CODFORMAPAGAMENTO','FRM.I_COD_FRM')+
                                  ' AND COR.SEQCAIXA = '+IntToStr(VpaSeqCaixa)+
                                  ' ORDER BY ITE.DATPAGAMENTO, ITE.SEQITEM ' );
  AdicionaSQLAbreTabela(Item,'SELECT CAF.CODFORMAPAGAMENTO, CAF.VALINICIAL, CAF.VALATUAL, CAF.VALFINAL, '+
                             ' FRM.C_NOM_FRM '+
                             ' FROM CAIXAFORMAPAGAMENTO CAF, CADFORMASPAGAMENTO FRM '+
                             ' Where CAF.CODFORMAPAGAMENTO = FRM.I_COD_FRM '+
                             ' AND CAF.SEQCAIXA = '+IntToStr(VpaSeqCaixa));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEspelhoNota(VpaCodFilial,VpaSeqNota : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Espelho nota fiscal '+IntToStr(VpaSeqNota);
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\8000FA_Espelho da Nota Fiscal.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CAD.I_EMP_FIL ,CAD.I_SEQ_NOT, CAD.C_TIP_NOT, CAD.I_NRO_NOT, CAD.C_SER_NOT, '+
                                  ' CAD.D_DAT_EMI, CAD.D_DAT_SAI, CAD.L_OBS_NOT,  CAD.N_BAS_CAL, CAD.N_VLR_ICM, '+
                                  ' CAD.N_BAS_SUB, CAD.N_TOT_PRO, CAD.N_VLR_FRE, CAD.N_VLR_SEG, CAD.N_OUT_DES, '+
                                  ' CAD.N_TOT_IPI, CAD.N_TOT_NOT, CAD.I_TIP_FRE, CAD.C_NRO_PLA, CAD.C_EST_PLA, '+
                                  ' CAD.I_QTD_VOL, CAD.C_TIP_EMB, CAD.C_MAR_PRO, CAD.C_NRO_PAC, CAD.N_PES_BRU, '+
                                  ' CAD.N_PES_LIQ, CAD.C_NUM_PED, CAD.C_ORD_COM, CAD.L_OB1_NOT, '+
                                  ' NAT.C_COD_NAT, NAT.C_NOM_NAT, '+
                                  ' TRA.C_NOM_CLI C_NOM_TRA, TRA.C_CGC_CLI C_CGC_TRA, TRA.C_END_CLI C_END_TRA, TRA.C_CID_CLI C_CID_TRA, '+
                                  ' TRA.C_EST_CLI C_EST_TRA, TRA.C_INS_CLI C_INS_TRA, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE '+
                                  ' FROM CADNOTAFISCAIS  CAD, CADNATUREZA NAT, CADCLIENTES CLI, CADCLIENTES TRA '+
                                  ' WHERE CAD.C_COD_NAT = NAT.C_COD_NAT '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_CLI')+
                                  ' AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND CAD.I_SEQ_NOT = '+IntToSTr(VpaSEqNOta));
  AdicionaSqlAbreTabela(Item,'Select MOV.C_COD_PRO,  MOV.C_COD_CST, MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_TOT_PRO, MOV.N_PER_ICM, '+
                             ' MOV.N_PER_IPI, MOV.N_VLR_IPI, '+
                             ' PRO.C_NOM_PRO, '+
                             ' COR.COD_COR, COR.NOM_COR '+
                             ' FROM MOVNOTASFISCAIS MOV, CADPRODUTOS PRO, COR '+
                             ' Where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                             ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                             ' AND MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                             ' AND MOV.I_SEQ_NOT = '+IntToSTr(VpaSEqNOta)+
                             ' order by MOV.I_SEQ_MOV');
  AdicionaSqlAbreTabela(Item3,'SELECT MOV.C_NRO_DUP, MOV.N_VLR_PAR, MOV.D_DAT_VEN, MOV.C_NRO_AGE, MOV.C_NRO_CON,'+
                              ' FRM.I_COD_FRM, FRM.C_NOM_FRM, '+
                              ' BAN.I_COD_BAN, BAN.C_NOM_BAN '+
                              ' FROM MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADFORMASPAGAMENTO FRM, CADBANCOS BAN '+
                              ' WHERE CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND  CAD.I_SEQ_NOT = '+IntToSTr(VpaSEqNOta)+
                              ' AND MOV.I_COD_FRM = FRM.I_COD_FRM '+
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                              ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                              ' AND MOV.I_COD_BAN = BAN.I_COD_BAN');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoPendente(VpaCodFilial, VpaCodCliente,VpaCodClienteMaster, VpaSeqProduto, VpaCodTipCotacao, VpaCodVendedorPreposto, VpaCodCor, VpaCodRepresentada : Integer; VpaCodClassificacao,VpaNomClassificacao,VpaNomCliente, VpaNomTipCotacao, VpaNomVendedorPreposto, VpaNomRepresentada : String;VpaDatInicio,VpaDatFim : TDateTime;VpaClienteMaster : Boolean; VpaPedidoXBaixa : Boolean = false; VpaImpressaoEmbalagem: Boolean = false; VpaAlcaBolso : Boolean = false);
begin
  Rave.close;
  if  not VpaPedidoXBaixa then
  begin
    RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos Pendentes';
    Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_PedidosPendentes.rav';
  end else
  begin
    RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos Pendentes X Baixa';
    Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_PedidosPendentesXBaixa.rav';
  end;
  PedidosPendentes.sql.clear;
  PedidosPendentes.sql.add('select Extract(YEAR FROM  cad.d_dat_pre)  || Extract(MONTH FROM cad.d_dat_pre) MESANO,'+
                             ' Extract(MONTH FROM cad.d_dat_pre) || ''/'' || Extract(YEAR FROM  cad.d_dat_pre) MESANOF,'+
                             ' CAD.I_EMP_FIL, cad.d_dat_pre, cad.d_dat_orc, cad.i_lan_orc, cad.i_cod_cli, CAD.T_HOR_ENT, cli.c_nom_cli, '+
                             ' CAD.C_ORD_COM, '+
                             ' mov.n_qtd_pro, MOV.N_QTD_PRO - '+SQLTextoIsnull('MOV.N_QTD_BAI','0')+' - '+SQLTextoIsnull('MOV.N_QTD_CAN','0')+' QTDREAL, ' +
                             ' (MOV.N_QTD_PRO - '+SQLTextoIsnull('MOV.N_QTD_BAI','0')+'-'+SQLTextoIsnull('MOV.N_QTD_CAN','0')+')  * MOV.N_VLR_PRO TOTAL, ' +
                             ' pro.c_nom_pro,PRO.C_COD_PRO, mov.c_cod_uni, mov.n_vlr_pro, MOV.N_QTD_BAI, '+
                             ' MOV.C_DES_COR, MOV.I_COD_COR, MOV.C_PRO_REF, MOV.I_SEQ_MOV, MOV.I_SEQ_ORD,  MOV.N_QTD_BAI '+
                             ' from cadorcamentos cad, movorcamentos mov, cadclientes cli, cadprodutos pro '+
                             ' where cad.i_emp_fil = mov.i_emp_fil '+
                             ' and cad.i_lan_orc = mov.i_lan_orc '+
                             ' and cad.i_cod_cli = cli.i_cod_cli '+
                             ' and mov.i_seq_pro = pro.i_seq_pro ');
  if not VpaPedidoXBaixa then
    PedidosPendentes.SQL.Add(' and cad.c_fla_sit = ''A''' +
                             ' and (MOV.N_QTD_PRO - '+SqlTextoIsNull('MOV.N_QTD_BAI','0')+'-'+SQLTextoIsnull('MOV.N_QTD_CAN','0')+') > 0 ');

  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (VpaCodFilial = 0) then
    PedidosPendentes.sql.add(' and CAD.I_EMP_FIL <> 13');

  if (puPLImprimirValoresRelatorioPedidosPendentes in varia.PermissoesUsuario) or
     (puPLCompleto in varia.PermissoesUsuario) or
     (puAdministrador in varia.PermissoesUsuario) then
    Rave.SetParam('IMPRIMEVALOR','S')
  else
    Rave.SetParam('IMPRIMEVALOR','N');
  if VpaCodFilial <> 0 then
    PedidosPendentes.sql.add(' and cad.i_emp_fil = '+ IntToStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
  begin
    Rave.SetParam('CLIENTE','Cliente : '+IntToStr(VpaCodCliente)+' - ' +VpaNomCliente);
    PedidosPendentes.sql.add(' and CAD.I_COD_CLI = '+ IntToStr(VpaCodCliente));
  end;
  if VpaCodRepresentada <> 0 then
  begin
    Rave.SetParam('REPRESENTADA','Representada : '+IntToStr(VpaCodRepresentada)+' - ' +VpaNomRepresentada);
    PedidosPendentes.sql.add(' and CAD.I_COD_REP = '+ IntToStr(VpaCodRepresentada));
  end;
  if VpaCodTipCotacao <> 0 then
  begin
    Rave.SetParam('TIPOCOTACAO','Tipo Cotação : '+IntToStr(VpaCodTipCotacao)+' - ' +VpaNomTipCotacao);
    PedidosPendentes.sql.add(' and CAD.I_TIP_ORC = '+ IntToStr(VpaCodTipCotacao));
  end;
  if (VpaCodVendedorPreposto <> 0) then
  begin
    Rave.SetParam('PREPOSTO','Preposto : '+IntToStr(VpaCodVendedorPreposto)+' - ' +VpaNomVendedorPreposto);
    PedidosPendentes.sql.add(' and CAD.I_VEN_PRE = '+ IntToStr(VpaCodVendedorPreposto));
  end;
  if (VpaCodCor <> 0) then
  begin
    PedidosPendentes.sql.add(' and MOV.I_COD_COR = '+ IntToStr(VpaCodCor));
  end;

  if not VpaClienteMaster then
    PedidosPendentes.sql.add(' and CLI.I_CLI_MAS IS NULL');

  if VpaCodClienteMaster <> 0 then
    PedidosPendentes.sql.add(' and CLI.I_CLI_MAS = '+ IntToStr(VpaCodClienteMaster));
  if VpaSeqProduto <> 0 then
    PedidosPendentes.sql.add(' and MOV.I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  if VpaCodClassificacao <> '' then
  begin
    Rave.SetParam('CLASSIFICACAO','Classificacao : '+VpaCodClassificacao+' - ' +VpaNomClassificacao);
    PedidosPendentes.sql.add(' and PRO.C_COD_CLA like '''+VpaCodClassificacao+'%''');
  end;

  if VpaImpressaoEmbalagem then
  begin
    Rave.SetParam('IMPRESSAO','Impressao: SIM');
    PedidosPendentes.sql.add(' and PRO.I_IMP_EMB >= 2');
  end;

  if VpaAlcaBolso then
  begin
    PedidosPendentes.sql.add(' and (PRO.I_ALC_EMB IN (2,3,4,7) OR PRO.C_IND_BOL = ''S'')');
  end;


  if Config.ImprimirPedidoPendentesPorPeriodo then
  begin
    Rave.SetParam('PERIODO','Período de '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+  ' até ' +FormatDateTime('DD/MM/YYYY',VpaDatFim));
    PedidosPendentes.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_PRE',VpaDatInicio,VpaDatFim,true));
  end;

  if (VARIA.CNPJFilial = CNPJ_MetalVidros) or (varia.CNPJFilial =  CNPJ_VIDROMAX) then
    PedidosPendentes.sql.add(' and CAD.I_TIP_ORC = '+ IntToStr(Varia.TipoCotacaoPedido));

  PedidosPendentes.sql.add(' and CAD.C_IND_CAN = ''N''');
  PedidosPendentes.sql.add(' order by cad.d_dat_pre, CAD.T_HOR_ENT, CAD.I_LAN_ORC ');
  PedidosPendentes.open;
  Rave.Execute;
end;

{procedure TdtRave.ImprimePedidoPendenteXBaixa(VpaCodFilial, VpaCodCliente, VpaCodClienteMaster, VpaSeqProduto: Integer; VpaCodClassificacao, VpaNomClassificacao, VpaNomCliente: String; VpaDatInicio,VpaDatFim: TDateTime; VpaClienteMaster: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos Pendentes';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_PedidosPendentes.rav';
  PedidosPendentes.sql.clear;
  PedidosPendentes.sql.add('select  CAD.I_EMP_FIL, cad.d_dat_pre, cad.d_dat_orc, cad.i_lan_orc, cad.i_cod_cli, CAD.T_HOR_ENT, cli.c_nom_cli, '+
                             ' CAD.C_ORD_COM, '+
                             ' mov.n_qtd_pro, MOV.N_QTD_PRO - '+SQLTextoIsnull('MOV.N_QTD_BAI','0')+' QTDREAL, ' +
                             ' (MOV.N_QTD_PRO - '+SQLTextoIsnull('MOV.N_QTD_BAI','0')+')  * MOV.N_VLR_PRO TOTAL, ' +
                             ' pro.c_nom_pro,PRO.C_COD_PRO, mov.c_cod_uni, mov.n_vlr_pro, '+
                             ' MOV.C_DES_COR, MOV.C_PRO_REF, MOV.I_SEQ_MOV, MOV.I_SEQ_ORD,  MOV.N_QTD_BAI '+
                             ' from cadorcamentos cad, movorcamentos mov, cadclientes cli, cadprodutos pro '+
                             ' where cad.i_emp_fil = mov.i_emp_fil '+
                             ' and cad.i_lan_orc = mov.i_lan_orc '+
                             ' and cad.i_cod_cli = cli.i_cod_cli '+
                             ' and mov.i_seq_pro = pro.i_seq_pro '+
                             ' and cad.c_fla_sit = ''A'''+
                             ' and (MOV.N_QTD_PRO - '+SqlTextoIsNull('MOV.N_QTD_BAI','0')+') > 0 ');

  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (VpaCodFilial = 0) then
    PedidosPendentes.sql.add(' and CAD.I_EMP_FIL <> 13');

  if (puPLImprimirValoresRelatorioPedidosPendentes in varia.PermissoesUsuario) or
     (puPLCompleto in varia.PermissoesUsuario) or
     (puAdministrador in varia.PermissoesUsuario) then
    Rave.SetParam('IMPRIMEVALOR','S')
  else
    Rave.SetParam('IMPRIMEVALOR','N');
  if VpaCodFilial <> 0 then
    PedidosPendentes.sql.add(' and cad.i_emp_fil = '+ IntToStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
  begin
    Rave.SetParam('CLIENTE','Cliente : '+IntToStr(VpaCodCliente)+' - ' +VpaNomCliente);
    PedidosPendentes.sql.add(' and CAD.I_COD_CLI = '+ IntToStr(VpaCodCliente));
  end;
  if not VpaClienteMaster then
    PedidosPendentes.sql.add(' and CLI.I_CLI_MAS IS NULL');

  if VpaCodClienteMaster <> 0 then
    PedidosPendentes.sql.add(' and CLI.I_CLI_MAS = '+ IntToStr(VpaCodClienteMaster));
  if VpaSeqProduto <> 0 then
    PedidosPendentes.sql.add(' and MOV.I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  if VpaCodClassificacao <> '' then
  begin
    Rave.SetParam('CLASSIFICACAO','Classificacao : '+VpaCodClassificacao+' - ' +VpaNomClassificacao);
    PedidosPendentes.sql.add(' and PRO.C_COD_CLA like '''+VpaCodClassificacao+'%''');
  end;
  if Config.ImprimirPedidoPendentesPorPeriodo then
  begin
    Rave.SetParam('PERIODO','Período de '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+  ' até ' +FormatDateTime('DD/MM/YYYY',VpaDatFim));
    PedidosPendentes.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_PRE',VpaDatInicio,VpaDatFim,true));
  end;

  if (VARIA.CNPJFilial = CNPJ_MetalVidros) or (varia.CNPJFilial =  CNPJ_VIDROMAX) then
    PedidosPendentes.sql.add(' and CAD.I_TIP_ORC = '+ IntToStr(Varia.TipoCotacaoPedido));

  PedidosPendentes.sql.add(' and CAD.C_IND_CAN = ''N''');
  PedidosPendentes.sql.add(' order by cad.d_dat_pre, CAD.T_HOR_ENT, CAD.I_LAN_ORC ');
  PedidosPendentes.open;
  Rave.Execute;
end; }

{******************************************************************************}
procedure TdtRave.ImprimeRemessa(VpaCodFilial, VpaSeqRemessa: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Remessa Bancaria';
  AdicionaSQlAbreTabela(Principal,'select BAN.I_COD_BAN, BAN.C_NOM_BAN, '+
                                  ' COR.NUMCONTA, COR.DATINICIO, COR.DATENVIO, COR.CODFILIAL,COR.SEQREMESSA, '+
                                  ' ITE.NOMMOTIVO, '+
                                  ' CON.C_NOM_CRR, '+
                                  ' MOV.C_NRO_DUP, MOV.D_DAT_VEN, MOV.N_VLR_PAR, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                                  ' from REMESSACORPO COR, CADCONTAS CON, CADBANCOS BAN, REMESSAITEM ITE, MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, '+
                                  ' CADCLIENTES CLI '+
                                  ' Where COR.NUMCONTA = CON.C_NRO_CON '+
                                  ' AND  CON.I_COD_BAN = BAN.I_COD_BAN '+
                                  ' AND COR.CODFILIAL = ITE.CODFILIAL '+
                                  ' AND COR.SEQREMESSA = ITE.SEQREMESSA '+
                                  ' AND ITE.CODFILIAL= MOV.I_EMP_FIL '+
                                  ' AND ITE.LANRECEBER = MOV.I_LAN_REC '+
                                  ' AND ITE.NUMPARCELA = MOV.I_NRO_PAR '+
                                  ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND COR.CODFILIAL = '+ Inttostr(VpaCodFilial)+
                                  ' AND COR.SEQREMESSA = '+InttoStr(VpaSeqRemessa));

  Rave.projectfile := varia.PathRelatorios+'\Financeiro\XX_Remessa.rav';
  Rave.Execute;
end;


{*******************************************************************************}
procedure TdtRave.ImprimeRetorno(VpaCodFilial, VpaSeqRetorno: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Retorno Bancario';
  AdicionaSQlAbreTabela(Principal,'Select  * ' +
                          ' from RETORNOCORPO COR, RETORNOITEM ITE '+
                          ' Where COR.CODFILIAL = ITE.CODFILIAL '+
                          ' AND COR.SEQRETORNO = ITE.SEQRETORNO ' +
                          ' AND COR.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' AND COR.SEQRETORNO = '+IntToSTr(VpaSeqRetorno)+
                          ' AND ITE.INDPOSSUIERRO = ''N'''+
                          ' ORDER BY ITE.INDPOSSUIERRO, ITE.CODOCORRENCIA, ITE.DESDISPONIVEL');
  AdicionaSQlAbreTabela(Item,'Select  * ' +
                          ' from RETORNOCORPO COR, RETORNOITEM ITE '+
                          ' Where COR.CODFILIAL = ITE.CODFILIAL '+
                          ' AND COR.SEQRETORNO = ITE.SEQRETORNO ' +
                          ' AND COR.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' AND COR.SEQRETORNO = '+IntToSTr(VpaSeqRetorno)+
                          ' AND ITE.INDPOSSUIERRO = ''S'''+
                          ' ORDER BY ITE.INDPOSSUIERRO, ITE.CODOCORRENCIA');

  Rave.projectfile := varia.PathRelatorios+'\Financeiro\XX_Retorno.rav';
  Rave.Execute;
end;


{*******************************************************************************}
procedure TdtRave.ImprimeRomaneio(VpaCodFilial, VpaSeqRomaneio: Integer;
  VpaVisualizar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Romaneio '+IntToStr(VpaSeqRomaneio);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_Romaneio.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  AdicionaSqlAbreTabela(Principal,'SELECT ROM.CODFILIAL, ROM.SEQROMANEIO, ROM.VALTOTAL, ROM.QTDVOLUME, ROM.PESBRUTO, ' +
                                  ' CLI.C_NOM_CLI, CLI.C_END_CLI, '+
                                  ' NTA.I_NRO_NOT, NTA.D_DAT_EMI,  ' +
                                  ' CON.C_NOM_PAG ' +
                                  ' FROM ROMANEIOORCAMENTO ROM, CADCLIENTES CLI, CADNOTAFISCAIS NTA, CADCONDICOESPAGTO CON ' +
                                  ' WHERE ROM.CODCLIENTE = CLI.I_COD_CLI ' +
                                  ' AND '+ SQLTextoRightJoin('ROM.CODFILIAL','NTA.I_EMP_FIL') +
                                  ' AND '+ SQLTextoRightJoin('ROM.SEQNOTA','NTA.I_SEQ_NOT ') +
                                  ' AND '+ SQLTextoRightJoin('NTA.I_COD_PAG','CON.I_COD_PAG') +
                                  ' AND ROM.CODFILIAL = ' + IntToStr(VpaCodFilial)+
                                  ' AND ROM.SEQROMANEIO = ' + IntToStr(VpaSeqRomaneio));

  AdicionaSqlAbreTabela(Item,' SELECT ROM.QTDPRODUTO, ROM.QTDPEDIDO,' +
                             ' ROM.DESUM, ROM.CODCOR, ROM.DESORDEMCORTE, ROM.CODTAMANHO,' +
                             ' ROM.VALUNITARIO, ROM.VALTOTAL, ROM.DESREFERENCIACLIENTE, ROM.DESORDEMCOMPRA, ' +
                             ' PRO.C_NOM_PRO, PRO.C_COD_PRO,  '+
                             ' COR.NOM_COR, '+
                             ' MOV.C_COD_BAR '+
                             ' FROM ROMANEIOORCAMENTOITEM ROM, CADPRODUTOS PRO, COR, MOVQDADEPRODUTO MOV ' +
                             ' WHERE ROM.CODFILIAL = ' + IntToStr(VpaCodFilial) +
                             ' AND ROM.SEQROMANEIO= ' + IntToStr(VpaSeqRomaneio) +
                             ' AND '+SQLTextoRightJoin('ROM.CODCOR','COR.COD_COR')+
                             ' AND ROM.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                             ' AND '+SQLTextoRightJoin('ROM.SEQPRODUTO','MOV.I_SEQ_PRO')+
                             ' AND '+SQLTextoRightJoin('ROM.CODCOR','MOV.I_COD_COR')+
                             ' AND '+SQLTextoRightJoin('ROM.CODTAMANHO','MOV.I_COD_TAM')+
                             ' AND '+SQLTextoRightJoin('ROM.CODFILIAL','MOV.I_EMP_FIL'));
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  Rave.Execute;
end;

{*******************************************************************************}
procedure TdtRave.ImprimeLeituraContratos(VpaCodCliente,VpaCodTecnico,VpaCodTipoContrato, VpaNumDiaLeitura, VpaCodFilial, VpaSeqContrato: Integer;VpaCaminhoRelatorio,VpaNomCliente,VpaNomTecnico,VpaNomTipoContrato : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Leitura dos Contratos ';
  Principal.close;
  Principal.sql.clear;
  AdicionaSQlTabela(Principal,'select  CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_FO1_CLI, ' +
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' CON.CODFILIAL, CON.SEQCONTRATO, CON.CODTIPOCONTRATO, CON.DATASSINATURA, CON.DATCANCELAMENTO, '+
                              ' CON.QTDFRANQUIA, CON.NOMCONTATO, CON.NUMDIALEITURA, CON.DESEMAIL, '+
                              ' TEC.CODTECNICO, TEC.NOMTECNICO, '+
                              ' TIP.NOMTIPOCONTRATO '+
                              ' FROM CONTRATOCORPO CON, CADCLIENTES CLI, CADVENDEDORES VEN, TECNICO TEC, TIPOCONTRATO TIP '+
                              ' Where CON.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND CON.CODVENDEDOR = VEN.I_COD_VEN '+
                              ' AND '+SQLTextoRightJoin('CON.CODTECNICOLEITURA','TEC.CODTECNICO')+
                              ' AND CON.CODTIPOCONTRATO =  TIP.CODTIPOCONTRATO '+
                              ' AND CON.DATCANCELAMENTO IS NULL');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODCLIENTE = '+Inttostr(VpacodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodTipoContrato <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODTIPOCONTRATO = '+Inttostr(VpacodTipoContrato));
    Rave.SetParam('TIPOCONTRATO',VpaNomTipoContrato);
  end;
  if VpaCodTecnico <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODTECNICOLEITURA = '+Inttostr(VpacodTecnico));
    Rave.SetParam('TECNICO',VpaNomTecnico);
  end;
  if VpaNumDiaLeitura <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.NUMDIALEITURA = '+Inttostr(VpaNumDiaLeitura));
    Rave.SetParam('DIALEITURA',Inttostr(VpaNumdiaLeitura));
  end;
  if VpaCodFilial <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODFILIAL = '+Inttostr(VpaCodFilial));
  end;
  if VpaSeqContrato <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.SEQCONTRATO = '+Inttostr(VpaSeqContrato));
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  AdicionaSqlTabela(Principal,' ORDER BY TEC.CODTECNICO, CLI.C_NOM_CLI');
  Principal.open;
  AdicionaSQlAbreTabela(Item,'select ITE.CODFILIAL, ITE.SEQCONTRATO, ITE.SEQITEM, ITE.NUMSERIE, ITE.DATULTIMALEITURA, ITE.QTDULTIMALEITURA, ' +
                             ' ITE.DESSETOR, ITE.NUMSERIEINTERNO, ITE.DATDESATIVACAO, ITE.QTDULTIMALEITURACOLOR, '+
                             ' PRO.C_NOM_PRO '+
                             ' from CONTRATOITEM ITE, CADPRODUTOS PRO '+
                             ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ITE.DATDESATIVACAO IS NULL'+
                             ' ORDER BY ITE.CODFILIAL, ITE.SEQCONTRATO,ITE.SEQITEM');
  Rave.projectfile := varia.PathRelatorios+'\Contrato\0200PL_Leitura dos Contratos.rav';
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeLimiteCredito(VpaCodCliente: Integer;VpaCaminho, VpaNomCliente: String;VpaLimiteInicial, VpaLimiteFinal : Double; VpaPdf: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Limite de Credito';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\1200PLFAFI_Limite de Credito.rav';
  Rave.clearParams;
  if VpaPdf then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  LimpaSQLTabela(Principal);
  AdicionaSqlTabela(Principal,'Select I_COD_CLI, C_NOM_CLI, N_LIM_CLI  '+
                              ' FROM CADCLIENTES '+
                              ' Where (C_IND_CLI = ''S'' OR C_IND_FOR = ''S'')');

  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaLimiteInicial > 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND N_LIM_CLI >= '+SubstituiStr(FloatToStr(VpaLimiteInicial),',','.'));
    Rave.SetParam('LIMITEINICIAL',FormatFloat('#,###,##0.00',VpaLimiteInicial));
  end;
  if VpaLimiteFinal > 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND N_LIM_CLI <= '+SubstituiStr(FloatToStr(VpaLimiteFinal),',','.'));
    Rave.SetParam('LIMITEFINAL',FormatFloat('#,###,##0.00',VpaLimiteFinal));
  end;

  AdicionaSqlTabeLa(Principal,'ORDER BY C_NOM_CLI' );

  Principal.Open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeMotivoAtrasoAmostra(VpaDatInicio, VpaDatFim: TDatetime;
  VpaCaminhoRelatorio: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Motivo Atraso Amostra por Periodo';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\8000CR_Motivo Atraso Amostra por Periodo.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSQLAbreTabela(Item, ' SELECT COUNT(AMO.CODAMOSTRA) QTD ' +
                                   ' FROM AMOSTRACORMOTIVOATRASO AMO' +
                                   ' WHERE ' +
                                   SQLTextoDataEntreAAAAMMDD('TRUNC(AMO.DATCADASTRO)', VpaDatInicio, VpaDatFim, False));

  AdicionaSQLAbreTabela(Principal, ' SELECT COUNT(AMO.CODAMOSTRA) QTD, MOT.DESMOTIVOATRASO   ' +
                                   ' FROM AMOSTRACORMOTIVOATRASO AMO, MOTIVOATRASO MOT' +
                                   ' WHERE AMO.CODMOTIVOATRASO = MOT.CODMOTIVOATRASO' +
                                   SQLTextoDataEntreAAAAMMDD('TRUNC(AMO.DATCADASTRO)', VpaDatInicio, VpaDatFim, True) +
                                   ' GROUP BY MOT.DESMOTIVOATRASO'+
                                   ' order by 1 desc');

  Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YY',VpaDatFim));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeFracaoOP(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Fração Op '+IntToStr(VpaSeqOrdem);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_FracaoOP.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  AdicionaSqlAbreTabela(Principal,'Select  CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                                  ' ORC.I_LAN_ORC, ORC.D_DAT_ORC, T_HOR_ORC, ORC.I_TIP_FRE, '+
                                  ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.I_PLA_EMB, PRO.I_PLS_EMB, '+
                                  ' PRO.I_FER_EMB, PRO.C_LAR_EMB, PRO.C_ALT_EMB, PRO.C_FUN_EMB, ' +
                                  ' PRO.C_ABA_EMB, PRO.C_DIA_EMB, PRO.C_PEN_EMB, PRO.I_ALC_EMB, PRO.C_LOC_ALC, ' +
                                  ' PRO.C_IND_CRT, PRO.C_OBS_COR, PRO.C_LAM_ZIP, PRO.C_LAM_ABA, PRO.C_LAM_ABA, PRO.C_IND_BOL, '+
                                  ' PRO.C_INT_EMB, PRO.C_INU_EMB, PRO.I_IMP_EMB, PRO.C_LOC_IMP, PRO.C_COR_IMP, PRO.C_FOT_NRO, '+
                                  ' PRO.C_IND_IEX, PRO.I_CBD_EMB, PRO.I_SIM_CAB, PRO.I_BOT_EMB, PRO.I_COR_BOT, PRO.C_OBS_BOT, ' +
                                  ' PRO.I_BOL_EMB, PRO.I_ZPE_EMB, PRO.I_TAM_ZIP, PRO.I_COR_ZIP, PRO.I_COD_VIE, PRO.I_PRE_FAC,'+
                                  ' PRO.C_ADI_EMB, ' +
                                  ' OPC.EMPFIL, OPC.SEQORD,  OPC.CODCOM, OPC.QTDFRA, OPC.ORDCLI, OPC.DESOBS, OPC.UNMPED, OPC.PROREF, OPC.DESCOR,OPC.CODTRA,'+
                                  ' COR.NOM_COR, COZ.NOM_COR CORZIPER, PRO.C_LOC_INT, '+
                                  ' FRA.SEQFRACAO, FRA.QTDPRODUTO, FRA.DATENTREGA, FRA.CODBARRAS, '+
                                  ' TRA.C_NOM_CLI C_NOM_TRA, CPR.I_PLA_EMB, CPR.C_NOM_PRO, FAC.NOMFACA, FAC.CODFACA, CAP.I_PLA_EMB, CAP.C_NOM_PRO  '+
                                  ' from ORDEMPRODUCAOCORPO OPC, CADCLIENTES CLI, CADORCAMENTOS ORC, CADPRODUTOS PRO, COR, FRACAOOP FRA, CADCLIENTES TRA, CADPRODUTOS CPR, COR COZ, '+
                                  ' FACA FAC, CADPRODUTOS CAP ' +
                                  ' Where OPC.CODCLI = CLI.I_COD_CLI '+
                                  ' AND OPC.SEQPRO = PRO.I_SEQ_PRO '+
                                  ' AND OPC.EMPFIL = ORC.I_EMP_FIL '+
                                  ' AND OPC.NUMPED = ORC.I_LAN_ORC '+
                                  ' AND '+SQLTextoRightJoin('OPC.CODCOM','COR.COD_COR')+
                                  ' AND '+SQLTextoRightJoin('OPC.CODTRA','TRA.I_COD_CLI')+
                                  ' AND '+SQLTextoRightJoin('PRO.I_PLA_EMB','CPR.I_SEQ_PRO')+
                                  ' AND '+SQLTextoRightJoin('PRO.I_PLS_EMB','CAP.I_SEQ_PRO')+
                                  ' AND '+SQLTextoRightJoin('PRO.I_FER_EMB','FAC.CODFACA')+
                                  ' AND '+SQLTextoRightJoin('PRO.I_COR_ZIP','COZ.COD_COR')+
                                  ' AND OPC.EMPFIL = FRA.CODFILIAL '+
                                  ' AND OPC.SEQORD = FRA.SEQORDEM '+
                                  ' AND FRA.CODFILIAL = '+IntTosTr(VpaCodFilial)+
                                  ' AND FRA.SEQORDEM = '+IntTosTr(VpaSeqOrdem)+
                                  ' AND FRA.SEQFRACAO = '+IntTosTr(VpaSEqFracao));
  AdicionaSqlAbreTabela(Item,'select FRE.SEQESTAGIO, FRE.INDPRODUCAO, '+
                             ' PRE.DESESTAGIO, '+
                             ' EST.CODEST, EST.NOMEST '+
                             ' from FRACAOOPESTAGIO FRE, PRODUTOESTAGIO PRE, ESTAGIOPRODUCAO EST '+
                             ' Where FRE.SEQPRODUTO = PRE.SEQPRODUTO '+
                             ' AND FRE.SEQESTAGIO = PRE.SEQESTAGIO '+
                             ' AND PRE.CODESTAGIO = EST.CODEST '+
                             ' AND FRE.CODFILIAL = '+IntTosTr(VpaCodFilial)+
                             ' AND FRE.SEQORDEM = '+IntTosTr(VpaSeqOrdem)+
                             ' AND FRE.SEQFRACAO = '+IntTosTr(VpaSEqFracao)+
                             ' ORDER BY FRE.SEQESTAGIO');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeOrcamentoRoteiroEntrega(VpaCodFilial,
  VpaSeqRoteiro: Integer; VpaVisualizar, VpaIncluiData: Boolean; VpaDatIni, VpaDatFim : TDateTime);
begin
Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Roteiro Entrega ';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\8000PL_Roteiro Entrega.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  AdicionaSqlAbreTabela(Principal,' select ORC.SEQORCAMENTOROTEIRO,  TRA.C_NOM_CLI, ORC.DATABERTURA, ORC.DATFECHAMENTO, orc.codentregador ' +
                                  ' from ORCAMENTOROTEIROENTREGA ORC, CADCLIENTES TRA ' +
                                  ' WHERE ORC.CODENTREGADOR = TRA.I_COD_CLI ' +
                                  ' and ORC.SEQORCAMENTOROTEIRO = ' +  IntToStr(VpaSeqRoteiro) +
                                  ' order by ORC.SEQORCAMENTOROTEIRO ' );
  AdicionaSqlAbreTabela(Item, ' select ITE.SEQORCAMENTOROTEIRO, ITE.SEQORCAMENTO, CLI.C_NOM_CLI, ITE.CODFILIALORCAMENTO ' +
                              ' from ORCAMENTOROTEIROENTREGAITEM ITE, CADORCAMENTOS ORC, CADCLIENTES CLI ' +
                              ' WHERE ITE.SEQORCAMENTO = ORC.I_LAN_ORC AND ' +
                              ' oRC.I_COD_CLI = CLI.I_COD_CLI AND ' +
                              ' ITE.SEQORCAMENTOROTEIRO = ' + IntToStr(VpaSeqRoteiro) + '  AND ' +
                              ' ITE.CODFILIALORCAMENTO = ' + IntToStr(VpaCodfilial)+
                              ' order by ITE.SEQORCAMENTOROTEIRO ');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeOrdemCorteOP(VpaCodFilial, VpaSeqOrdem : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ordem Corte '+IntToStr(VpaSeqOrdem);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_OrdemCorte.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  AdicionaSqlAbreTabela(Principal,'select BAS.LARBASTIDOR, BAS.ALTBASTIDOR, '+
                                  ' CLI.C_NOM_CLI, '+
                                  ' PRO.C_NOM_PRO, '+
                                  ' MAP.C_COD_PRO CODMATPRIMA, MAP.C_NOM_PRO NOMMATPRIMA, '+
                                  ' ENT.C_COD_PRO CODENTRETELA, ENT.C_NOM_PRO NOMENTRETELA, '+
                                  ' TER.C_COD_PRO CODTERMOCOLANTE, TER.C_NOM_PRO NOMTERMOCOLANTE, '+
                                  ' COR.NOM_COR, '+
                                  ' COM.NOM_COR CORMATPRIMA, '+
                                  ' FAC.NOMFACA,  FAC.ALTFACA, FAC.LARFACA, FAC.QTDPROVA, '+
                                  ' MAQ.NOMMAQ, '+
                                  ' OCI.CODMAQUINA, OCI.CODFACA, OCI.DESOBSERVACAO, OCI.LARMOLDE, OCI.ALTMOLDE, OCI.QTDPRODUTO, '+
                                  ' OCI.SEQTERMOCOLANTE, OCI.SEQENTRETELA, OCI.QTDTERMOCOLANTE, OCI.QTDENTRETELA, '+
                                  ' OCI.CODBASTIDOR, OCI.QTDPECASBASTIDOR, OCI.LARENFESTO, OCI.ALTENFESTO, OCI.QTDENFESTO, OCI.POSFACA, OCI.QTDMETROPRODUTO,'+
                                  ' ORD.EMPFIL, ORD.SEQORD, ORD.DATEMI, ORD.DATENP, ORD.CODPRO, ORD.CODCOM, ORD.DESOBS, '+
                                  ' ORD.UNMPED, ORD.QTDORP, ORD.QTDFRA '+
                                  ' from ORDEMCORTEITEM OCI, ORDEMPRODUCAOCORPO ORD, BASTIDOR BAS,  CADCLIENTES CLI, CADPRODUTOS PRO, CADPRODUTOS MAP, CADPRODUTOS ENT, '+
                                  '         CADPRODUTOS TER, COR, COR COM, FACA FAC, MAQUINA MAQ '+
                                  ' WHERE OCI.CODFILIAL = ORD.EMPFIL '+
                                  ' AND OCI.SEQORDEMPRODUCAO = ORD.SEQORD '+
                                  ' AND OCI.SEQPRODUTO = MAP.I_SEQ_PRO '+
                                  ' AND OCI.CODCOR = COM.COD_COR '+
                                  ' AND '+ SQLTextoRightJoin('OCI.CODFACA','FAC.CODFACA')+
                                  ' AND '+ SQLTextoRightJoin('OCI.CODMAQUINA','MAQ.CODMAQ')+
                                  ' AND '+ SQLTextoRightJoin('OCI.SEQENTRETELA','ENT.I_SEQ_PRO')+
                                  ' AND '+ SQLTextoRightJoin('OCI.SEQTERMOCOLANTE','TER.I_SEQ_PRO')+
                                  ' AND '+ SQLTextoRightJoin('OCI.CODBASTIDOR','BAS.CODBASTIDOR')+
                                  ' AND ORD.CODCLI = CLI.I_COD_CLI '+
                                  ' AND ORD.SEQPRO = PRO.I_SEQ_PRO '+
                                  ' AND ORD.CODCOM = COR.COD_COR '+
                                  ' AND ORD.EMPFIL = '+IntTosTr(VpaCodFilial)+
                                  ' AND ORD.SEQORD = '+IntTosTr(VpaSeqOrdem)+
                                  ' ORDER BY OCI.SEQITEM');
  AdicionaSqlAbreTabela(Item,'Select CODFILIAL, SEQORDEM, SEQFRACAO, QTDPRODUTO, CODBARRAS '+
                             ' from FRACAOOP '+
                             ' WHERE CODFILIAL = '+IntTosTr(VpaCodFilial)+
                             ' AND SEQORDEM = '+IntTosTr(VpaSeqOrdem)+
                             ' ORDER BY SEQFRACAO ');
  Rave.Execute;
//  salvasql;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoCompraPendente(VpaCodFornecedor : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos Compras Pendentes';
  Rave.projectfile := varia.PathRelatorios+'\Compra\xx_PedidoPendente.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.Close;
  LimpaSQLTabela(Principal);
  AdicionaSqlTabela(Principal,'select CLI.C_NOM_CLI, '+
                                  ' PRO.C_NOM_PRO, '+
                                  ' COR.NOM_COR, '+
                                  ' COP.CODFILIAL, COP.SEQPEDIDO, COP.DATPEDIDO, COP.CODCLIENTE, COP.DATPREVISTA, COP.DATENTREGA, COP.DATRENEGOCIADO, '+
                                  ' ITE.DESUM, ITE.QTDPRODUTO, ITE.QTDBAIXADO, ITE.VALTOTAL '+
                                  ' from PEDIDOCOMPRAITEM ITE, PEDIDOCOMPRACORPO COP, CADCLIENTES CLI, CADPRODUTOS PRO, COR '+
                                  ' WHERE COP.CODFILIAL = ITE.CODFILIAL '+
                                  ' AND COP.SEQPEDIDO = ITE.SEQPEDIDO '+
                                  ' AND COP.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND ' +SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                                  ' AND COP.DATENTREGA IS NULL '+
                                  ' AND NVL(ITE.QTDBAIXADO,0) < ITE.QTDPRODUTO ');
  if VpaCodFornecedor <> 0 then
    AdicionaSQLTabela(Principal,'AND COP.CODCLIENTE = '+IntToStr(VpaCodFornecedor));

  AdicionaSqlTabela(Principal,' ORDER BY COP.DATPREVISTA');
  Principal.Open;
  Rave.Execute;
end;


{******************************************************************************}
procedure TdtRave.ImprimeVendasAnalitico(VpaCodFilial,VpaCodCliente,VpaCodCondicaoPagamento, VpaCodTipoCotacao,VpaCodVendedor,VpaCodPreposto, VpaCodRepresentada : Integer;VpaDatInicio,VpaDatFim : TDatetime;VpaCaminhoRelatorio,VpaDesCidade,VpaUF,VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaNomVendedor,VpaNomFilial,VpaNomPreposto, VpaNomRepresentada : string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Vendas Analitico';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0100PL_Venda Analitico.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  Principal.sql.add('SELECT CAD.I_EMP_FIL , CAD.I_LAN_ORC, CAD.D_DAT_ORC, CAD.N_VLR_TOT, CAD.C_NRO_NOT, CAD.I_TIP_ORC, '+
                    ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                    ' PAG.I_COD_PAG, PAG.C_NOM_PAG, '+
                    ' VEN.C_NOM_VEN '+
                    ' FROM CADORCAMENTOS CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG, CADVENDEDORES VEN '+
                    ' Where CAD.I_COD_CLI = CLI.I_COD_CLI '+
                    ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                    ' AND CAD.I_COD_VEN = VEN.I_COD_VEN ');
  Item.Close;
  Item.sql.clear;
  Item.sql.add('SELECT CAD.I_EMP_FIL , CAD.I_LAN_ORC, '+
                              ' MOV.C_COD_PRO, MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_VLR_TOT, '+
                              ' PRO.C_NOM_PRO '+
                              ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO, CADCLIENTES CLI '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');
  Item2.Close;
  Item2.sql.clear;
  Item2.sql.add('SELECT CAD.I_EMP_FIL , CAD.I_LAN_ORC, '+
                              ' MOV.I_COD_SER, ''SE'', MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_VLR_TOT, '+
                              ' SER.C_NOM_SER '+
                              ' FROM CADORCAMENTOS CAD, MOVSERVICOORCAMENTO MOV, CADSERVICO SER, CADCLIENTES CLI '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND MOV.I_COD_SER = SER.I_COD_SER ');


  if VpaCodFilial <> 0  then
  begin
   Principal.sql.add('AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial));
   Item.sql.add('AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial));
   Item2.sql.add('AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial));
   Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
   Principal.sql.add('AND CAD.I_COD_CLI = '+IntToStr(VpaCodCliente));
   Item.sql.add('AND CAD.I_COD_CLI = '+IntToStr(VpaCodCliente));
   Item2.sql.add('AND CAD.I_COD_CLI = '+IntToStr(VpaCodCliente));
   Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodCondicaoPagamento <> 0  then
  begin
   Principal.sql.add('AND CAD.I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
   Item.sql.add('AND CAD.I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
   Item2.sql.add('AND CAD.I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
   Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaCodTipoCotacao <> 0  then
  begin
   Principal.sql.add('AND CAD.I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao));
   Item.sql.add('AND CAD.I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao));
   Item2.sql.add('AND CAD.I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao));
   Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodRepresentada <> 0  then
  begin
   Principal.sql.add('AND CAD.I_COD_REP = '+IntToStr(VpaCodRepresentada));
   Item.sql.add('AND CAD.I_COD_REP = '+IntToStr(VpaCodRepresentada));
   Item2.sql.add('AND CAD.I_COD_REP = '+IntToStr(VpaCodRepresentada));
   Rave.SetParam('REPRESENTADA',VpaNomRepresentada);
  end;
  if VpaCodVendedor <> 0  then
  begin
   Principal.sql.add('AND CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
   Item.sql.add('AND CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
   Item2.sql.add('AND CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
   Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodPreposto <> 0  then
  begin
   Principal.sql.add('AND CAD.I_VEN_PRE = '+IntToStr(VpaCodPreposto));
   Item.sql.add('AND CAD.I_VEN_PRE = '+IntToStr(VpaCodPreposto));
   Item2.sql.add('AND CAD.I_VEN_PRE = '+IntToStr(VpaCodPreposto));
   Rave.SetParam('PREPOSTO',VpaNomPreposto);
  end;
  if DeletaEspaco(VpaDesCidade) <>  ''  then
  begin
   Principal.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Item.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Item2.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Rave.SetParam('CIDADE',VpaDesCidade);
  end;
  if VpaUF <> ''  then
  begin
   Principal.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Item.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Item2.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Rave.SetParam('UF',VpaUF);
  end;
  Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YY',VpaDatFim));
  Principal.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                    ' and CAD.C_IND_CAN = ''N''');
  Item.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                    ' and CAD.C_IND_CAN = ''N''');
  Item2.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                    ' and CAD.C_IND_CAN = ''N''');

  Principal.sql.add(' ORDER BY CAD.D_DAT_ORC, CAD.I_LAN_ORC');
  Item.sql.add(' ORDER BY CAD.I_EMP_FIL, CAD.I_LAN_ORC');
  Item2.sql.Add(' ORDER BY CAD.I_EMP_FIL, CAD.I_LAN_ORC');
  Principal.Open;
  Item.Open;
  Item2.Open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConhecimentoTransporteEntrada(VpaDatInicio,
  VpaDatFim: TDateTime; VpaCodFilial, VpaCodTransportadora: Integer;
  VpaCaminhoRelatorio, VpaNomFilial, VpaNomTransportadora: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Conhecimento de Transporte';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\2000ES_Conhecimento de Transporte Entrada.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal, 'SELECT CON.NUMCONHECIMENTO, CON.DATCONHECIMENTO, CON.VALCONHECIMENTO, ' +
                               ' CON.VALBASEICMS, CON.VALICMS, CON.PESFRETE, CON.VALNAOTRIBUTADO, ' +
                               ' CLI.C_NOM_CLI, ' +
                               ' NOF.I_NRO_NOT, ' +
                               ' TIP.NOMTIPODOCUMENTOFISCAL ' +
                               ' FROM CONHECIMENTOTRANSPORTE CON, CADCLIENTES CLI, CADNOTAFISCAISFOR NOF, TIPODOCUMENTOFISCAL TIP ' +
                               ' WHERE CON.CODTRANSPORTADORA = CLI.I_COD_CLI ' +
                               ' AND CON.SEQNOTAENTRADA = NOF.I_SEQ_NOT ' +
                               ' AND CON.CODMODELODOCUMENTO = TIP.CODTIPODOCUMENTOFISCAL ' +
                               ' AND CON.SEQNOTAENTRADA IS NOT NULL ' +
                               SQLTextoDataEntreAAAAMMDD('CON.DATCONHECIMENTO',VpaDatInicio,VpaDatFim,True));
  if VpaCodFILIAL <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CON.CODFILIALNOTA = '+IntTostr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CON.CODTRANSPORTADORA = '+IntTostr(VpaCodTransportadora));
    Rave.SetParam('TRANSPORTADORA',VpaNomTransportadora);
  end;
  AdicionaSqlTabela(Principal,'ORDER BY CON.DATCONHECIMENTO, CON.NUMCONHECIMENTO');
  Rave.SetParam('PERIODO',FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConhecimentoTransporteSaida(VpaDatInicio,
  VpaDatFim: TDateTime; VpaCodFilial, VpaCodTransportadora: Integer;
  VpaCaminhoRelatorio, VpaNomFilial, VpaNomTransportadora: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Conhecimento de Transporte';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\3000FA_Conhecimento de Transporte Saida.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal, 'SELECT CON.NUMCONHECIMENTO, CON.DATCONHECIMENTO, CON.VALCONHECIMENTO, ' +
                               ' CON.VALBASEICMS, CON.VALICMS, CON.PESFRETE, CON.VALNAOTRIBUTADO, ' +
                               ' CLI.C_NOM_CLI, ' +
                               ' NOF.I_NRO_NOT, ' +
                               ' TIP.NOMTIPODOCUMENTOFISCAL ' +
                               ' FROM CONHECIMENTOTRANSPORTE CON, CADCLIENTES CLI, CADNOTAFISCAIS NOF, TIPODOCUMENTOFISCAL TIP ' +
                               ' WHERE CON.CODTRANSPORTADORA = CLI.I_COD_CLI ' +
                               ' AND CON.SEQNOTASAIDA = NOF.I_SEQ_NOT ' +
                               ' AND CON.CODMODELODOCUMENTO = TIP.CODTIPODOCUMENTOFISCAL ' +
                               ' AND CON.SEQNOTASAIDA IS NOT NULL ' +
                               SQLTextoDataEntreAAAAMMDD('CON.DATCONHECIMENTO',VpaDatInicio,VpaDatFim,True));
  if VpaCodFILIAL <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CON.CODFILIALNOTA = '+IntTostr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CON.CODTRANSPORTADORA = '+IntTostr(VpaCodTransportadora));
    Rave.SetParam('TRANSPORTADORA',VpaNomTransportadora);
  end;
  AdicionaSqlTabela(Principal,'ORDER BY CON.DATCONHECIMENTO, CON.NUMCONHECIMENTO');
  Rave.SetParam('PERIODO',FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConsistenciadeEstoque(VpaCodFilial, VpaSeProduto : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaCaminhoRelatorio,VpaNomFilial,VpaNomProduto : String;VpaIndSomenteMonitorados : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consistencia Estoque';
  Rave.projectfile := varia.PathRelatorios+'\Produto\1000ESPLFA_Consistencia de Estoque.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT  OPE.C_NOM_OPE, '+
                              ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                              ' MOV.I_EMP_FIL, MOV.I_COD_OPE, MOV.D_DAT_MOV, MOV.N_QTD_MOV, '+
                              ' MOV.N_VLR_MOV, MOV.I_NRO_NOT, MOV.C_COD_UNI,MOV.I_LAN_ORC, MOV.I_SEQ_ORD, '+
                              ' MOV.I_COD_COR, MOV.I_COD_TAM,MOV.I_NRO_NOT, MOV.N_QTD_INI, MOV.N_QTD_FIN, '+
                              ' COR.NOM_COR, '+
                              ' TAM.NOMTAMANHO, '+
                              ' TEC.NOMTECNICO ');
  AdicionaSqlTabeLa(Principal,' FROM  MOVESTOQUEPRODUTOS MOV, CADOPERACAOESTOQUE OPE, CADPRODUTOS PRO, COR , TAMANHO TAM, TECNICO TEC '+
                              ' Where MOV.I_COD_OPE = OPE.I_COD_OPE '+
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_TEC','TEC.CODTECNICO')+
                              SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_MOV',VpaDatInicio,VpaDatFim,True));
  if VpaCodFILIAL <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and MOV.I_EMP_FIL = '+IntTostr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaSeProduto <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and MOV.I_SEQ_PRO = '+IntTostr(VpaSeProduto));
    Rave.SetParam('PRODUTO',VpaNomProduto);
  end;
  if VpaIndSomenteMonitorados then
  begin
    AdicionaSqlTabela(Principal,'and PRO.C_IND_MON = ''S''');
  end;
  AdicionaSqlTabela(Principal,'ORDER BY MOV.D_DAT_MOV, MOV.I_COD_OPE');
  Rave.SetParam('PERIODO',FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConsistenciaReservaEstoque(VpaSeProduto: Integer; VpaCaminho, VpaNomProduto: String; VpaDatInicio,  VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consistencia Reserva Produto';
  Rave.projectfile := varia.PathRelatorios+'\Produto\Reserva Estoque\1100ES_Consistencia Reserva Estoque.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT PRE.SEQPRODUTO, PRE.TIPMOVIMENTO, PRE.DATRESERVA, PRE.QTDRESERVADA , PRE.QTDINICIAL, '+
                              ' PRE.QTDFINAL, PRE.SEQORDEMPRODUCAO, PRE.DESUM, '+
                              ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                              '  USU.C_NOM_USU '+
                              ' FROM RESERVAPRODUTO PRE, CADUSUARIOS USU, CADPRODUTOS PRO '+
                              ' Where PRE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' AND PRE.CODUSUARIO = USU.I_COD_USU');
  if VpaSeProduto <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND PRO.I_SEQ_PRO = '+InttoStr(VpaSeProduto));
    Rave.SetParam('PRODUTO','Produto : '+VpaNomProduto);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('PRE.DATRESERVA',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' ORDER BY  PRE.DATRESERVA, PRE.TIPMOVIMENTO');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConsumoFracionada(VpaCodFilial,VpaSeqOrdemProduccao: Integer; VpaSomenteAReservar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consumo Fracionada op '+IntToStr(VpaSeqOrdemProduccao);
  Rave. projectfile := varia.PathRelatorios+'\Ordem Producao\xx_ConsumoFracionada.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.Close;
  Principal.SQL.clear;
  AdicionaSqlTabela(Principal,'select CLA.C_COD_CLA, CLA.C_NOM_CLA, '+
                                  ' MP.C_COD_PRO CODMP, MP.C_NOM_PRO NOMMP, '+
                                  ' IMP.DESUM, IMP.QTDPRODUTO, IMP.QTDBAIXADO, IMP.QTDRESERVADA, '+
                                  ' IMP.QTDARESERVAR, IMP.INDMATERIALEXTRA, IMP.CODFILIAL, IMP.SEQORDEM, '+
                                  ' COR.COD_COR, COR.NOM_COR '+
                                  ' from CADCLASSIFICACAO CLA, CADPRODUTOS MP, IMPRESSAOCONSUMOFRACAO IMP, COR '+
                                  ' Where MP.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND MP.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND MP.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' AND IMP.CODCOR = COR.COD_COR '+
                                  ' AND MP.I_SEQ_PRO = IMP.SEQMATERIAPRIMA ');
  if VpaSomenteAReservar  then
    AdicionaSQLTabela(Principal,'AND IMP.QTDARESERVAR > 0 ');

  AdicionaSqlTabela(Principal,' ORDER BY CLA.C_COD_CLA, MP.C_NOM_PRO');
  Principal.open;
  Rave.SetParam('CODFILIAL',IntToStr(VpaCodFilial));
  Rave.SetParam('OP',IntToStr(VpaSeqOrdemProduccao));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConsumoOrdemProducao(VpaCodFilial, VpaSeqOrdem: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consumo Ordem Produção '+IntToStr(VpaSeqOrdem);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_ConsumoOrdemProducao.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.Close;
  Principal.SQL.clear;
  AdicionaSqlTabela(Principal,'select CON.QTDABAIXAR, CON.QTDBAIXADO, NVL(QTDABAIXAR,0) - NVL(QTDBAIXADO,0) QTDREAL, CON.CODFILIAL, CON.SEQORDEM, CON.SEQCONSUMO, '+
                              ' CON.DESUM, '+
                              ' PRO.C_NOM_PRO, '+
                              ' COR.NOM_COR '+
                              ' FROM ORDEMPRODUCAOCONSUMO CON, CADPRODUTOS PRO, COR '+
                              ' Where CON.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' AND CON.CODCOR = COR.COD_COR'+
                              ' AND CON.CODFILIAL = '+Inttostr(VpaCodFilial)+
                              ' and CON.SEQORDEM = '+IntToStr(VpaSeqOrdem));
  AdicionaSqlTabela(Principal,' ORDER BY PRO.C_NOM_PRO, COR.NOM_COR');
  Principal.open;
  Rave.SetParam('CODFILIAL',IntToStr(VpaCodFilial));
  Rave.SetParam('OP',IntToStr(VpaSeqOrdem));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConsumoSubmontagem(VpaCodFilial, VpaSeqOrdemProduccao, VpaSeqFracao : Integer;VpaSomenteAReservar, VpaConsumoExcluir : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consumo Submontagem op '+IntToStr(VpaSeqOrdemProduccao);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_ConsumoSubmontagem.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.Close;
  Principal.SQL.clear;
  AdicionaSqlTabela(Principal,'select CLA.C_COD_CLA, CLA.C_NOM_CLA, '+
                                  '  PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                                  ' MP.C_COD_PRO CODMP, MP.C_NOM_PRO NOMMP, '+
                                  ' IMP.DESUM, IMP.QTDPRODUTO, IMP.QTDBAIXADO, IMP.QTDRESERVADA, '+
                                  ' IMP.QTDARESERVAR, IMP.INDMATERIALEXTRA, IMP.DESLOCALIZACAO, '+
                                  ' FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO '+
                                  ' from CADCLASSIFICACAO CLA, CADPRODUTOS PRO, CADPRODUTOS MP, FRACAOOP FRA, IMPRESSAOCONSUMOFRACAO IMP '+
                                  ' Where MP.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND MP.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND MP.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' AND MP.I_SEQ_PRO = IMP.SEQMATERIAPRIMA '+
                                  ' AND IMP.CODFILIAL = FRA.CODFILIAL '+
                                  ' AND IMP.SEQORDEM = FRA.SEQORDEM '+
                                  ' AND IMP.SEQFRACAO = FRA.SEQFRACAO '+
                                  ' AND IMP.SEQPRODUTO = PRO.I_SEQ_PRO ');
  if VpaSomenteAReservar  then
    AdicionaSQLTabela(Principal,'AND IMP.QTDARESERVAR > 0 ');

  AdicionaSqlTabela(Principal,' ORDER BY PRO.C_COD_PRO, CLA.C_COD_CLA, MP.C_NOM_PRO');
  Principal.open;
  if not  VpaConsumoExcluir then
    AdicionaSqlAbreTabela(Item,'select  FRA.QTDPRODUTO, FRA.DESUM, '+
                             ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_PRA_PRO '+
                             ' from FRACAOOP FRA, CADPRODUTOS PRO '+
                             ' Where FRA.INDPOSSUIEMESTOQUE = ''S'''+
                             ' AND PRO.I_SEQ_PRO = FRA.SEQPRODUTO '+
                             ' AND FRA.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND SEQORDEM =  '+IntToStr(VpaSeqOrdemProduccao)+
                             ' ORDER BY PRO.C_COD_PRO ');
  if  VpaConsumoExcluir then
    Rave.SetParam('DESTITULO','PRODUTOS A EXCLUIR');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeDestinoProduto(VpaCodFilial, VpaCodCliente,VpaCodProduto, VpaSeqProduto: integer; VpaDataIni, VpaDataFim: TDateTime;
  VpaCaminhoRelatorio, VpaNomProduto, VpaNomCliente, VpaCodClassificacao, VpaNomClassificacao: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Destino Produto';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Produtos\1200ESPLFA_Destino Produto.rav'; //Verificar
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT MOV.C_COD_PRO, PRO.C_NOM_PRO, ORC.D_DAT_ORC, ORC.I_LAN_ORC, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_VLR_TOT, ' +
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_FO1_CLI, CLI.C_END_ELE ' +
                              ' FROM CADORCAMENTOS ORC, CADCLIENTES CLI, MOVORCAMENTOS MOV, CADPRODUTOS PRO ' +
                              ' WHERE ORC.I_EMP_FIL = MOV.I_EMP_FIL ' +
                              ' AND ORC.I_LAN_ORC = MOV.I_LAN_ORC ' +
                              ' AND ORC.I_COD_CLI = CLI.I_COD_CLI ' +
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO');

  if DateToStr(VpaDataIni) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,' AND ' + SQLTextoDataEntreAAAAMMDD('ORC.D_DAT_ORC', VpaDataIni, VpaDataFim, false));
    Rave.SetParam('DATAINI', DateToStr(VpaDataIni));
    Rave.SetParam('DATAFIM', DateToStr(VpaDataFim));
  end;

  if VpaCodProduto <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,' AND MOV.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));
    Rave.SetParam('CODPRODUTO', IntToStr(VpaCodProduto));
    Rave.SetParam('PRODUTO', VpaNomProduto);
  end;

  if VpaCodFilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,' AND ORC.I_EMP_FIL = '+ IntToStr(VpaCodFilial));
    Rave.SetParam('FILIAL', IntToStr(VpaCodFilial));
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,' AND ORC.I_COD_CLI = '''+ IntToStr(VpaCodCliente) + '''');
    Rave.SetParam('CODCLIENTE', IntToStr(VpaCodCliente));
    Rave.SetParam('NOMCLIENTE', VpaNomCliente);
  end;
  if VpaCodClassificacao <> '' then
  begin
    AdicionaSqlTabeLa(Principal,' AND PRO.C_COD_CLA LIKE '''+ VpaCodClassificacao + '%''');
    Rave.SetParam('CLASSIFICACAO', VpaNomClassificacao);
  end;

  AdicionaSqlTabeLa(Principal,'ORDER BY PRO.I_SEQ_PRO,ORC.D_DAT_ORC');
  Principal.Open;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeDevolucoesPendente(VpaCodFilial, VpaCodCliente,  VpaCodTransportadora, VpaCodEstagio, VpaCodVendedor, VpaCodProduto: Integer; VpaData: TDatetime;  VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente, VpaNomTranportadora,  VpaNomEstagio, VpaNomVendedor, VpaNomProduto: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Devoluções pendentes';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\0300PL_Devolucoes Pendentes.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  AdicionaSQlTabela(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.D_DAT_ORC, CAD.I_COD_TRA, CAD.I_COD_EST, CAD.C_IND_PEN, '+
                              ' PRO.C_NOM_PRO, PRO.C_IND_RET, '+
                              ' MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.C_COD_PRO, MOV.N_QTD_DEV, '+
                              ' (MOV.N_QTD_PRO - NVL(N_QTD_DEV,0)) QTDPENDENTE '+
                              ' FROM CADCLIENTES CLI, CADORCAMENTOS CAD, CADPRODUTOS PRO, MOVORCAMENTOS MOV '+
                              ' Where CLI.I_COD_CLI = CAD.I_COD_CLI '+
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                              ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC '+
                              ' AND CAD.C_IND_PEN = ''S'' '+
                              ' AND PRO.C_IND_RET = ''S'' '+
                              ' AND CAD.I_TIP_ORC <> '+IntToStr(Varia.TipoCotacaoColeta)+
                              ' AND CAD.I_TIP_ORC <> '+IntToStr(Varia.TipoCotacaoEntrega)+
                              ' AND CAD.D_DAT_ORC > '+SQLTextoDataAAAAMMMDD(VpaData)+
                              ' AND MOV.N_QTD_PRO > NVL(MOV.N_QTD_DEV,0) ');
  if VpaCodFilial <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_EMP_FIL =  '+IntTostr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;

  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_COD_TRA =  '+IntTostr(VpaCodTransportadora));
    Rave.SetParam('TRANSPORTADORA',VpaNomTranportadora);
  end;

  if VpaCodEstagio <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_COD_EST =  '+IntTostr(VpaCodEstagio));
    Rave.SetParam('ESTAGIO',VpaNomEstagio);
  end;

  if VpaCodCliente <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CAD.I_COD_CLI = '+Inttostr(VpacodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CAD.I_COD_VEN = '+Inttostr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodProduto <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND PRO.I_SEQ_PRO = '+Inttostr(VpaCodProduto));
    Rave.SetParam('PRODUTO',VpaNomProduto);
  end;

  Rave.SetParam('DATFINAL',FormatDateTime('DD/MM/YYYY',VpaData));

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  AdicionaSqlTabela(Principal,' ORDER BY CAD.I_EMP_FIL , CAD.I_LAN_ORC');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeRecibo(VpaCodFilial : Integer ;VpaDCliente : TRBDCliente;VpaDesDuplicata, VpaValDuplicata,VpaValExtenso,VpaLocaleData : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Recibo';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\XX_Recibo.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEndereco+', '+VpaDCliente.NumEndereco+ ' - '+VpaDCliente.DesComplementoEndereco);
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairro);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepCliente);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidade);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUF);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContato);
  Rave.SetParam('DESDATADUPLICATA',VpaLocaleData);
  Rave.SetParam('DESDUPLICATA',VpaDesDuplicata);
  Rave.SetParam('VALDUPLICATA',VpaValDuplicata);
  Rave.SetParam('VALEXTENSO',VpaValExtenso);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeReciboLocacao(VpaCodFilial,
  VpaSeqReciboLocacao: Integer; VpaVisualizar, VpaIncluiData: Boolean;
  VpaDatIni, VpaDatFim: TDateTime);
begin
Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Roteiro Entrega ';
  Rave.projectfile := varia.PathRelatorios+'\Contrato\XX_Recibo Locacao.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  AdicionaSQLAbreTabela(Principal,'SELECT REC.SEQRECIBO, REC.DATEMISSAO, REC.DESOBSERVACAO,  REC.VALTOTAL, ' +
                                  ' REC.CODFILIAL, REC.DESOBSERVACAOCOTACAO, REC.DESORDEMCOMPRA,' +
                                  ' CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_EST_CLI, ' +
                                  ' CLI.C_CID_CLI, CLI.C_CGC_CLI, CLI.I_COD_CLI,' +
                                  ' CLI.C_INS_CLI, CLI.I_NUM_END, CLI.C_COM_END, CLI.C_END_COB, CLI.I_NUM_COB, ' +
                                  ' CLI.C_BAI_COB, CLI.C_CEP_COB, CLI.C_CID_COB, CLI.C_EST_COB, ' +
                                  ' LEI.SEQCONTRATO '+
                                  ' FROM RECIBOLOCACAOCORPO REC, CADCLIENTES CLI, LEITURALOCACAOCORPO  LEI' +
                                  ' WHERE REC.CODCLIENTE = CLI.I_COD_CLI ' +
                                  ' AND '+SQLTextoRightJoin('REC.LANORCAMENTO','LEI.LANORCAMENTO') +
                                  ' and '+SQLTextoRightJoin('REC.CODFILIAL','LEI.CODFILIAL') +
                                  ' AND REC.CODFILIAL = ' + IntToStr(VpaCodFilial) +
                                  ' AND REC.SEQRECIBO = ' + IntToStr(VpaSeqReciboLocacao));
  AdicionaSqlAbreTabela(Item, 'SELECT REC.SEQITEM, REC.QTDSERVICO, REC.VALUNITARIO, REC.VALTOTAL, ' +
                              ' SER.C_NOM_SER '+
                              ' FROM RECIBOLOCACAOSERVICO REC, CADSERVICO SER ' +
                              ' WHERE REC.CODSERVICO = SER.I_COD_SER ' +
                              ' AND REC.CODFILIAL = ' + IntToStr(VpaCodFilial) +
                              ' AND REC.SEQRECIBO = ' + IntToStr(VpaSeqReciboLocacao));

  AdicionaSqlAbreTabela(Item2, 'SELECT REC.LANORCAMENTO, ' +
                               ' CAD.I_LAN_REC, CAD.N_VLR_TOT, ' +
                               ' MOV.I_LAN_REC MOVDUPLICATA, CAD.N_VLR_TOT MOVVALOR, MOV.D_DAT_VEN, MOV.C_NRO_DUP, ' +
                               ' FRM.C_NOM_FRM ' +
                               ' FROM RECIBOLOCACAOCORPO REC, CADCONTASARECEBER CAD, CADFORMASPAGAMENTO FRM, '+
                               ' MOVCONTASARECEBER MOV ' +
                               ' WHERE REC.LANORCAMENTO = CAD.I_LAN_ORC ' +
                               ' AND MOV.I_COD_FRM =  FRM.I_COD_FRM ' +
                               ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                               ' AND REC.CODFILIAL = CAD.I_EMP_FIL ' +
                               ' AND REC.CODFILIAL = ' + IntToStr(VpaCodFilial) +
                               ' AND REC.SEQRECIBO = ' + IntToStr(VpaSeqReciboLocacao));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeRecibosEmitidos(VpaDatInicio, VpaDatFim: TDateTime;
  VpaCodFilial, VpaCodCliente: Integer; VpaCaminhoRelatorio, VpaNomFilial,
  VpaNomCliente: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Recibos Emitidos';
  Rave.projectfile := varia.PathRelatorios+'\Contrato\0600PL_Recibos Emitidos.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select REC.DATEMISSAO, REC.SEQRECIBO, REC.VALTOTAL, ' +
                             ' REC.INDCANCELADO,' +
                             ' CLI.C_NOM_CLI ' +
                             ' from RECIBOLOCACAOCORPO REC, CADCLIENTES CLI ' +
                             ' WHERE REC.CODCLIENTE = CLI.I_COD_CLI ' +
                             ' AND REC.DATEMISSAO BETWEEN '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                             ' AND ' +SQLTextoDataAAAAMMMDD(VpaDatFim));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND REC.CODFILIAL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND REC.CODCLIENTE = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY REC.DATEMISSAO, REC.SEQRECIBO ');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeRelacaoDeRepresentantes(VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomVendedor,VpaNomCidade,VpaNomEstado: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Relação de Representantes';
  Rave.projectfile := varia.PathRelatorios+'\Vendedor\0200PLESFACR_Vendedores.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT I_COD_VEN, C_NOM_VEN,  C_END_VEN, C_BAI_VEN, C_CID_VEN,  C_CEP_VEN, C_EST_VEN, C_FON_VEN,  C_FAX_VEN, C_CEL_VEN, ' +
                              ' C_CPF_VEN, N_PER_COM, C_DES_EMA FROM CADVENDEDORES' +
                              ' WHERE C_IND_ATI = ''S'' ');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if DeletaChars(VpaNomCidade,' ')<> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND C_CID_VEN = '''+ VpaNomCidade + '''');
    Rave.SetParam('CIDADE',VpaNomCidade);
  end;
  if VpaNomEstado <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND C_EST_VEN = '''+VpaNomEstado + '''');
    Rave.SetParam('ESTADO',VpaNomEstado);
  end;

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY I_COD_VEN,C_NOM_VEN');
  Principal.open;

  Rave.Execute;

end;

{******************************************************************************}
procedure TdtRave.ImprimeRelatorioPedidoCompra(VpaDatIni, VpaDatFim: TDateTime;
  VpaFilial: integer; VpaDescFilial, VpaCaminhoRelatorio: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedido Compra';
  Rave.projectfile := varia.PathRelatorios+'\Compra\0200ES_Pedido Compra.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  AdicionaSQlTabela(Principal,'SELECT PED.SEQPEDIDO, PED.TIPFRETE, PED.DATPEDIDO, CLI.C_NOM_CLI, PGT.C_NOM_PAG, PED.VALTOTAL, ' +
                              ' PED.DATPEDIDO, PED.DATENTREGA ' +
                              ' FROM PEDIDOCOMPRACORPO PED, CADCLIENTES CLI, CADUSUARIOS USU, CADCONDICOESPAGTO PGT ' +
                              ' WHERE ' + SQLTextoDataEntreAAAAMMDD('Trunc(DATPEDIDO)',VpaDatIni,VpaDatFim,false) +
                              ' AND PED.CODCLIENTE = CLI.I_COD_CLI ' +
                              ' AND PED.CODUSUARIO = USU.I_COD_USU ' +
                              ' AND ' + SQLTextoRightJoin('PED.CODCONDICAOPAGAMENTO', 'PGT.I_COD_PAG '));
 if VpaFilial <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND PED.CODFILIAL =  '+IntTostr(Vpafilial));
    Rave.SetParam('FILIAL',VpaDESCFilial);
  end;
  Rave.SetParam('DATAINI',DateToStr(VpaDatIni));
  Rave.SetParam('DATAFIM',DateToStr(VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  AdicionaSqlTabela(Principal,' ORDER BY PED.SEQPEDIDO');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEstoqueFiscal(VpaCodFilial, VpaSeqProduto: integer; VpaCaminhoRelatorio, VpaNomFilial,  VpaNomProduto: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Estoque Fiscal';
  Rave.projectfile := varia.PathRelatorios+'\Produto\Estoque\3000ESPL_Estoque Fiscal.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  AdicionaSQlTabela(Principal,'select  PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_ATI_PRO, '+
                              ' MOV.I_EMP_FIL, MOV.N_VLR_COM, MOV.I_COD_COR, NVL(MOV.N_QTD_FIS,0) N_QTD_FIS '+
                              ' from CADPRODUTOS PRO, MOVQDADEPRODUTO MOV '+
                              ' Where PRO.I_SEQ_PRO = MOV.I_SEQ_PRO '+
                              ' AND PRO.C_ATI_PRO = ''S'' ');
  if VpaCodFilial <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND MOV.I_EMP_FIL =  '+IntTostr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;

  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND PRO.I_SEQ_PRO =  '+IntTostr(VpaSeqProduto));
    Rave.SetParam('PRODUTO',VpaNomProduto);
  end;

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  AdicionaSqlTabela(Principal,' ORDER BY MOV.N_QTD_FIS');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEstoqueProdutoporTecnico(VpaCodTEcnico: Integer; VpaCaminho, VpaNomTecnico: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Estoque de produtos por tecnico';
  Rave.projectfile := varia.PathRelatorios+'\Produto\2000ES_Estoque de Produtos Por Tecnico.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select PRO.C_COD_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, '+
                              ' EST.QTDPRODUTO, '+
                              ' TEC.NOMTECNICO '+
                              ' from CADPRODUTOS PRO, ESTOQUETECNICO EST, TECNICO TEC '+
                              ' Where PRO.I_SEQ_PRO = EST.SEQPRODUTO '+
                              ' AND EST.CODTECNICO = TEC.CODTECNICO '+
                              ' AND EST.QTDPRODUTO <> 0');
  if VpaCodTEcnico <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND TEC.CODTECNICO = '+InttoStr(VpaCodTecnico));
    Rave.SetParam('TECNICO','Técnico : '+VpaNomTecnico);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY  TEC.NOMTECNICO');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotaFiscalEntrada(VpaCodFilial,VpaSeqNota : integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Nota fiscal de Entrada '+IntToStr(VpaSeqNota);
  Rave.projectfile := varia.PathRelatorios+'\Nota Entrada\XX_NotaEntrada.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'Select CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  '  CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, CLI.C_CON_COM, CLI.C_EMA_FOR, CLI.C_FON_COM,  '+
                                  '  CAD.I_EMP_FIL, CAD.I_SEQ_NOT, CAD.N_TOT_NOT, CAD.N_TOT_PRO TOTALPRODUTO, CAD.I_NRO_NOT, CAD.D_DAT_EMI, CAD.D_DAT_REC, '+
                                  '  CAD.N_TOT_IPI, CAD.I_TIP_FRE, CAD.N_VLR_SUB, CAD.N_BAS_SUB, '+
                                  '  PRO.C_COD_PRO, PRO.C_NOM_PRO NOMEORIGINAL, '+
                                  '  MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_TOT_PRO, MOV.C_NOM_PRO, MOV.N_PER_IPI, '+
                                  '  CON.I_COD_PAG, CON.C_NOM_PAG, ' +
                                  '  FRM.I_COD_FRM, FRM.C_NOM_FRM, ' +
                                  '  TRA.I_COD_CLI I_COD_TRA, TRA.C_NOM_CLI C_NOM_TRA ' +
                                  '  FROM CADCLIENTES CLI, CADNOTAFISCAISFOR CAD, CADPRODUTOS PRO, MOVNOTASFISCAISFOR MOV, CADCONDICOESPAGTO CON, CADFORMASPAGAMENTO FRM, '+
                                  '  CADCLIENTES TRA ' +
                                  '  Where CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  '  AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  '  AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                                  '  AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                  '  AND '+ SQLTextoRightJoin('CAD.I_COD_PAG','CON.I_COD_PAG')+
                                  '  AND '+ SQLTextoRightJoin('CAD.I_COD_FRM','FRM.I_COD_FRM') +
                                  '  AND '+ SQLTextoRightJoin('CAD.I_COD_TRA', 'TRA.I_COD_CLI')+
                                  '  AND CAD.I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                                  '  AND CAD.I_SEQ_NOT = ' + IntToStr(VpaSeqNota));
  Rave.Execute;
end;


{******************************************************************************}
procedure TdtRave.ImprimeOrdemSerra(VpaCodFilial, VpaSeqOrdemProducao : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ordem Serra op '+IntToStr(VpaSeqOrdemProducao);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\XX_OrdemSerra.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT PRO.I_SEQ_PRO, PRO.C_COD_PRO, '+
                                  ' MAP.C_NOM_PRO NOMMATERIAPRIMA, MAP.L_DES_TEC DESTECNICAMATERIAPRIMA, '+
                                  ' POP.C_NOM_PRO NOMPRODUTOOP, '+
                                  ' OP.EMPFIL, OP.SEQORD, '+
                                  ' ORS.SEQORDEMSERRA, ORS.SEQPRODUTO, ORS.COMMATERIAPRIMA, ORS.QTDPRODUTO '+
                                  ' FROM CADPRODUTOS PRO, CADPRODUTOS MAP, CADPRODUTOS POP, ORDEMPRODUCAOCORPO OP, ORDEMSERRA ORS '+
                                  ' WHERE OP.SEQPRO = POP.I_SEQ_PRO '+
                                  ' AND ORS.CODFILIAL = OP.EMPFIL '+
                                  ' AND ORS.SEQORDEMPRODUCAO = OP.SEQORD '+
                                  ' AND ORS.SEQMATERIAPRIMA = MAP.I_SEQ_PRO '+
                                  ' AND ORS.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND ORS.CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' AND ORS.SEQORDEMPRODUCAO  = '+IntToStr(VpaSeqOrdemProducao)+
                                  ' ORDER BY MAP.C_NOM_PRO, ORS.SEQORDEMSERRA');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaPequena(VpaVisualizar: Boolean);
begin
  Rave.close;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Etiqueta Pequena';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\xx_EtiquetaPequena.rav';
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,'SELECT * FROM ETIQUETAPRODUTO ' +
                                  ' ORDER BY SEQETIQUETA ');
  Rave.SetParam('NOMFILIAL',Varia.NomeFilial);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaPequenaReferencia(VpaVisualizar: Boolean);
begin
  Rave.close;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Etiqueta Pequena Referencia';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\xx_PequenaReferencia.rav';
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,'SELECT * FROM ETIQUETAPRODUTO ' +
                                  ' ORDER BY SEQETIQUETA ');
  Rave.SetParam('NOMFILIAL',Varia.NomeFilial);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaProduto10X3A4;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Etiqueta Produto';
  Rave.projectfile := varia.PathRelatorios+'\Etiqueta\XX_Produtos 10 X 3 - A4(25mm x 67mm).rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'Select * from ETIQUETAPRODUTO order by CODPRODUTO');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaProduto20X4A4;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Etiqueta Produto';
  Rave.projectfile := varia.PathRelatorios+'\Etiqueta\XX_Produtos 20 X 4 - A4(12mm x 44mm).rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'Select * from ETIQUETAPRODUTO order by CODPRODUTO');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidosEmAbertoPorEstagio(VpaCodEstagio, VpaCodTransportadora : Integer; VpaCaminho, VpaNomEstagio: String;VpaDatInicio, VpaDatFim : TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos em Aberto por Estagio';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\2000PL_Cotacoes em Aberto por Estagio.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT  CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' ORC.I_EMP_FIL, ORC.I_LAN_ORC, ORC.D_DAT_ORC, ORC.T_HOR_ORC,'+
                              ' ORC.D_DAT_PRE, ORC.I_COD_EST, '+
                              ' EST.NOMEST '+
                              'FROM CADCLIENTES CLI, CADORCAMENTOS ORC, ESTAGIOPRODUCAO EST '+
                              ' Where ORC.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND ORC.I_COD_EST = EST.CODEST'+
                               SQLTextoDataEntreAAAAMMDD('ORC.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodEstagio <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND ORC.I_COD_EST = '+InttoStr(VpaCodEstagio));
    Rave.SetParam('ESTAGIO',VpaNomEstagio);
  end;
  if VpaCodTransportadora <> 0 then
    AdicionaSqlTabeLa(Principal,'AND ORC.I_COD_TRA = '+InttoStr(VpaCodTransportadora));

  AdicionaSqlTabeLa(Principal,'ORDER BY EST.NOMEST, ORC.D_DAT_ORC');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeFilaChamadosPorTecnico(VpaCodEstagio,  VpaCodTecnico: Integer; VpaCaminhoRelatorio, VpaNomEstagio,  VpaNomTecnico: String;VpaDatInicio, VpaDatFim : TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Fila chamados por tecnico';
  Rave.projectfile := varia.PathRelatorios+'\Chamado\1000CH_Fila Chamados por Tecnico.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CID_CLI, '+
                              ' CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.DATPREVISAO HORA, CHA.NOMSOLICITANTE, '+
                              ' CHA.CODESTAGIO, '+
                              ' CHP.DESPROBLEMA, '+
                              ' EST.CODEST, EST.NOMEST, '+
                              ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                              ' from CADCLIENTES CLI, CHAMADOCORPO CHA, CHAMADOPRODUTO CHP, ESTAGIOPRODUCAO EST, TECNICO TEC '+
                              ' WHERE CHA.CODFILIAL= CHP.CODFILIAL '+
                              ' AND CHA.NUMCHAMADO = CHP.NUMCHAMADO '+
                              ' AND CHA.CODTECNICO = TEC.CODTECNICO '+
                              ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND CHA.CODESTAGIO = EST.CODEST ');

  if VpaCodEstagio <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CHA.CODESTAGIO = '+InttoStr(VpaCodEstagio));
    Rave.SetParam('ESTAGIO',VpaNomEstagio);
  end;
  if VpaCodTecnico <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CHA.CODTECNICO = '+InttoStr(VpaCodTecnico));
    Rave.SetParam('TECNICO',VpaNomTecnico);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CHA.DATPREVISAO',VpaDatInicio,IncDia(VpaDatFim,1),true));
  Rave.SetParam('PERIODO','Período de '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));

  AdicionaSqlTabeLa(Principal,'ORDER BY TEC.NOMTECNICO,EST.CODEST, CHA.DATPREVISAO');

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeFaturamentoProdutos(VpaCodProduto, VpaCodCliente,
  VpaCodFilial: integer; VpaDatIni, VpaDatFim: TDateTime; VpaDescProduto,
  VpaNomCliente, VpaNomFilial, VpaCaminho: string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Faturamento Produtos';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\4000PLFA_Faturamento Produtos.rav'; //Verificar
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT PRO.C_COD_PRO, PRO.C_NOM_PRO, MOV.N_VLR_CUS, NOTA.N_QTD_PRO, NOTA.N_VLR_PRO, NOTA.N_TOT_PRO,CAD.I_NRO_NOT ' +
                              ' FROM CADPRODUTOS PRO, MOVNOTASFISCAIS NOTA, CADNOTAFISCAIS CAD, MOVQDADEPRODUTO MOV ' +
                              ' WHERE PRO.I_SEQ_PRO = NOTA.I_SEQ_PRO ' +
                              ' AND CAD.I_SEQ_NOT = NOTA.I_SEQ_NOT ' +
                              ' AND ' + SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI', VpaDatIni, VpaDatFim, false)+
                              ' AND NOTA.I_EMP_FIL = MOV.I_EMP_FIL ' +
                              ' AND NOTA.I_SEQ_PRO = MOV.I_SEQ_PRO ' +
                              ' and NOTA.I_COD_COR = MOV.I_COD_COR ');
  if VpaCodFilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND NOTA.I_EMP_FIL = '+ IntToStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND NOTA.C_COD_CLI = '+ IntToStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;

  if VpaCodProduto <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND PRO.I_SEQ_PRO = '+ IntToStr(VpaCodProduto));
  end;

  rave.SetParam('PERIODO', DateToStr(VpaDatIni) + ' ate ' + DateToStr(VpaDatFim));

  AdicionaSQLTabela(Principal,'ORDER BY CAD.I_NRO_NOT ');
  Rave.SetParam('PRODUTO',VpaDescProduto);
  Rave.SetParam('CAMINHO',VpaCaminho);
  Principal.open;
  Rave.Execute;

end;

{******************************************************************************}
procedure TdtRave.ImprimeFichaDesenvolvimento(VpaCodAmostra: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ficha Desenvolvimento';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\xx_FichaDesenvolvimento.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlAbreTabeLa(Principal,'select AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGACLIENTE, AMO.INDCOPIA, '+
                              ' AMO.TIPAMOSTRA, AMO.DESOBSERVACAO, AMO.QTDAMOSTRA, AMO.DESIMAGEM, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' COL.NOMCOLECAO, '+
                              ' DES.NOMDESENVOLVEDOR '+
                              ' from AMOSTRA AMO, CADCLIENTES CLI, CADVENDEDORES VEN, COLECAO COL, DESENVOLVEDOR DES '+
                              ' Where AMO.CODCOLECAO = COL.CODCOLECAO '+
                              ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR '+
                              ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                              ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND AMO.CODAMOSTRA = '+IntToStr(VpaCodAmostra));

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalClientesAtendidoseProdutosVendidos(VpaCodClienteMaster: INteger; VpaCaminho, VpaNomClienteMaster: String;VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes atendidos e produtos vendidos';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Vendedor\0500PL_Total Clientes Atendidos e Produtos Vendidos.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select VEN.C_NOM_VEN, CLI.C_NOM_CLI, SUM(MOV.N_VLR_TOT) VALPRODUTO, SUM(MOV.N_QTD_PRO) QTDPRODUTO, COUNT(DISTINCT(CAD.I_COD_CLI))QTDCLIENTE, COUNT(DISTINCT(MOV.I_SEQ_PRO))PRODUTOS '+
                              ' From CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADVENDEDORES VEN, CADCLIENTES CLI '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' and CAD.C_IND_CAN = ''N''');
  if VpaCodClienteMaster <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
    Rave.SetParam('CLIENTEMASTER','Cliente Master : '+VpaNomClienteMaster);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' GROUP BY VEN.C_NOM_VEN, CLI.C_NOM_CLI '+
                              ' ORDER BY 1, 2');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalClientesAtendidoseProdutosVendidosporVendedor(VpaCodClienteMaster: INteger; VpaCaminho, VpaNomClienteMaster: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes atendidos e produtos vendidos por vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Vendedor\1000PL_Total Clientes Atendidos e Produtos Vendidos por Vendedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select VEN.C_NOM_VEN, SUM(MOV.N_VLR_TOT) VALPRODUTO, SUM(MOV.N_QTD_PRO) QTDPRODUTO, COUNT(DISTINCT(CAD.I_COD_CLI))QTDCLIENTE, COUNT(DISTINCT(MOV.I_SEQ_PRO))PRODUTOS '+
                              ' From CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADVENDEDORES VEN, CADCLIENTES CLI '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' and CAD.C_IND_CAN = ''N''');
  if VpaCodClienteMaster <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
    Rave.SetParam('CLIENTEMASTER','Cliente Master : '+VpaNomClienteMaster);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' GROUP BY VEN.C_NOM_VEN '+
                              ' ORDER BY 1');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao, VpaCodTransportadora : Integer; VpaCaminho, VpaNomCliente, VpaNomCondicaoPagamento, VpaNomTipoCotacao, VpaCidade, VpaUF, VpaNomTransportadora: String; VpaDatInicio, VpaDatFim: TDatetime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Vendas por Estado e Cidade';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0200PL_Vendas por Estado e Cidade.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_EST_CLI, CLI.C_CID_CLI, '+
                              ' PAG.C_NOM_PAG, '+
                              ' CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.I_COD_PAG, CAD.D_DAT_ORC, CAD.I_COD_VEN, '+
                              ' CAD.N_VLR_TOT, CAD.C_NRO_NOT, CAD.I_TIP_ORC '+
                              ' from CADCLIENTES CLI, CADCONDICOESPAGTO PAG, CADORCAMENTOS CAD '+
                              ' WHERE CLI.I_COD_CLI = CAD.I_COD_CLI '+
                              ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                              SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                              ' AND CAD.C_IND_CAN = ''N''');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaUF+'''');
    Rave.SetParam('ESTADO',VpaUF);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaTipCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaTipCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_TRA = '+InttoStr(VpaCodTransportadora));
  end;

  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' ORDER BY CLI.C_EST_CLI, CLI.C_CID_CLI');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

procedure TdtRave.RaveBeforeOpen(Sender: TObject);
begin
  RpDev.DevMode.dmPaperSize := DMPAPER_A4;
  RPDev.DeviceIndex := RPDev.Printers.IndexOf(varia.ImpressoraRelatorio);
  if VplArquivoPDF <> '' then
    ConfiguraRelatorioPDF
  else
    if VplArquivoRTF <> '' then
      ConfiguraRelatorioRTF
end;

{******************************************************************************}
procedure TdtRave.rvItemGetRow(Connection: TRvCustomConnection);
begin
  if UpperCase(Rave.ProjectFile) =  Uppercase(varia.PathRelatorios+'\Proposta\XX_Proposta.rav') then
  begin
    if (varia.CNPJFilial = CNPJ_Reloponto) or
       (varia.CNPJFilial = CNPJ_Relopoint) then
      CarregaRaveImagem('Vendas.page1','IProduto',VARIA.DriveFoto+Item.FieldByName('C_PAT_FOT').AsString);
  end;
  Connection.DoGetRow
end;

{******************************************************************************}
procedure TdtRave.RVJPGGetRow(Connection: TRvCustomConnection);
begin
{  CarregaRaveImagem('Vendas.page1','Bitmap2',VARIA.DriveFoto+Item.FieldByName('C_PAT_FOT').AsString);
  Connection.DoGetRow}
 end;

{******************************************************************************}
procedure TdtRave.RvSystem2AfterPreviewPrint(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TdtRave.salvaSql;
begin
  Principal.SQL.SaveToFile('principal.sql');
  Item.SQL.SaveToFile('item.sql');
  Item2.SQL.SaveToFile('item2.sql');
  Item3.SQL.SaveToFile('item3.sql');
  Item4.SQL.SaveToFile('item4.sql');
  Item5.SQL.SaveToFile('item5.sql');
  Item6.SQL.SaveToFile('item6.sql');
end;

{******************************************************************************}
procedure TdtRave.TesteDataConection;
begin

end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao, VpaCodTransportadora : Integer; VpaCaminho, VpaNomCliente,VpaNomCondicaoPagamento, VpaNomTipoCotacao, VpaCidade, VpaUF, VpaNomTransportadora: String; VpaDatInicio, VpaDatFim: TDatetime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Total Vendas por Estado e Cidade';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0250PL_Total Vendas por Estado e Cidade.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.C_EST_CLI, CLI.C_CID_CLI, SUM(CAD.N_VLR_TOT)VALOR ' +
                              ' from CADCLIENTES CLI, CADORCAMENTOS CAD ' +
                              ' WHERE CLI.I_COD_CLI = CAD.I_COD_CLI ' +
                              SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                              ' AND CAD.C_IND_CAN = ''N''');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaUF+'''');
    Rave.SetParam('ESTADO',VpaUF);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaTipCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaTipCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_TRA = '+InttoStr(VpaCodTransportadora));
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' GROUP BY CLI.C_EST_CLI, CLI.C_CID_CLI ' +
                              ' ORDER BY 1,3 DESC ');
  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTransferenciaExterna(VpaSeqTransferencia : integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Transferencia Externa';
  Rave.projectfile := varia.PathRelatorios+'\Caixa\XX_Transferencia Externa.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  LimpaSqlTabela(Item);
  LimpaSqlTabela(Item2);
  AdicionaSQLAbreTabela(Principal, 'SELECT TRA.SEQTRANSFERENCIA, TRA.DATTRANSFERENCIA, TRA.CODUSUARIO, TRA.VALTOTAL, TRA.SEQCAIXA, ' +
                                   ' USU.C_NOM_USU, USU.I_COD_USU ' +
                                   ' FROM TRANSFERENCIAEXTERNACORPO TRA, CADUSUARIOS USU ' +
                                   ' WHERE TRA.CODUSUARIO = USU.I_COD_USU' +
                                   ' AND TRA.SEQTRANSFERENCIA = ' + IntToStr(VpaSeqTransferencia) +
                                   ' order by TRA.SEQTRANSFERENCIA');
  AdicionaSQLAbreTabela(Item,'SELECT TRA.SEQTRANSFERENCIA, TRA.SEQITEM, TRA.VALATUAL,  ' +
                             ' FRM.I_COD_FRM, FRM.C_NOM_FRM ' +
                             ' FROM TRANSFERENCIAEXTERNAITEM TRA, CADFORMASPAGAMENTO FRM ' +
                             ' WHERE TRA.CODFORMAPAGAMENTO = FRM.I_COD_FRM' +
                             ' AND TRA.SEQTRANSFERENCIA = ' + IntToStr(VpaSeqTransferencia)+
                             ' order by TRA.SEQITEM ');
  AdicionaSQLAbreTabela(Item2,'SELECT TRA.SEQTRANSFERENCIA, TRA.SEQITEM, TRA.SEQITEMCHEQUE, TRA.SEQCHEQUE,  ' +
                              ' CHE.SEQCHEQUE, CHE.NOMEMITENTE, CHE.NUMCHEQUE, CHE.VALCHEQUE ' +
                              ' FROM TRANSFERENCIAEXTERNACHEQUE TRA, CHEQUE CHE ' +
                              ' WHERE TRA.SEQCHEQUE = CHE.SEQCHEQUE' +
                              ' AND TRA.SEQTRANSFERENCIA = ' + IntToStr(VpaSeqTransferencia)+
                              ' order by TRA.SEQITEM, TRA.SEQITEMCHEQUE');
  salvasql;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorVendedor(VpaCodVendedor,VpaCodVendedorPreposto,  VpaCodSituacao, VpaCodClienteMaster: Integer; VpaCaminho, VpaNomVendedor, VpaNomVendedorPreposto, VpaNOmSituacao, VpaCidade,VpaEstado: String;VpaIndCliente,VpaIndFornecedor, VpaIndProspect, VpaIndHotel : Boolean);
var
  VpfLinha : string;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0200PL_Clientes por Vendedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_FO1_CLI, CLI.C_END_CLI, '+
                              ' CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.C_EST_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN '+
                              ' from CADCLIENTES CLI, CADVENDEDORES VEN '+
                              ' Where '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN'));

  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaEstado <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaEstado+'''');
    Rave.SetParam('ESTADO',VpaEstado);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodSituacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_SIT = '+InttoStr(VpaCodSituacao));
    Rave.SetParam('SITUACAO',VpaNOmSituacao);
  end;
  if VpaCodVendedorPreposto <> 0  then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_VEN_PRE = '+InttoStr(VpaCodVendedorPreposto));
    Rave.SetParam('PREPOSTO',VpaNomVendedorPreposto);
  end;

  if VpaCodClienteMaster <> 0  then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
  end;

  if VpaIndCliente or VpaIndProspect or VpaIndFornecedor or VpaIndHotel then
  begin
    AdicionaSqlTabeLa(Principal,'and ( ');
    VpfLinha := '';
    if VpaIndCliente then
      VpfLinha := 'or CLI.C_IND_CLI = ''S''';
    if VpaIndProspect then
      VpfLinha := VpfLinha + 'or CLI.C_IND_PRC = ''S''';
    if VpaIndFornecedor then
      VpfLinha := VpfLinha + 'or CLI.C_IND_FOR = ''S''';
    if VpaIndHotel then
      VpfLinha := VpfLinha + 'or CLI.C_IND_HOT = ''S''';
    VpfLinha := copy(VpfLinha,3,length(VpfLinha))+')';

    AdicionaSqlTabeLa(Principal,VpfLinha);
  end;


  AdicionaSqlTabeLa(Principal,'ORDER BY VEN.C_NOM_VEN, CLI.C_EST_CLI, CLI.C_NOM_CLI');
  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalVendasCliente(VpaCodVendedor, VpaCodCondicaoPagamento, VpaCodTipoCotacao, VpaCodfilial, VpaCodSituacaoCliente, VpaCodRepresentada: Integer; VpaCaminho,  VpaNomVendedor, VpaNomCondicaoPagamento, VpaNomTipoCotacao, VpaNomfilial, VpaCidade, VpaUF, VpaNomSituacaoCliente, VpaNomRepresentada: String; VpaDatInicio, VpaDatFim: TDatetime;VpaCurvaABC,VpaSomenteClientesAtivos: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Total Vendas Clientes';
  if VpaCurvaABC then
    Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0301PL_Total Vendas por Cliente(Curva ABC).rav'
  else
    Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0300PL_Total Vendas por Cliente.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, SUM(CAD.N_VLR_TOT)VALOR '+
                              ' from CADCLIENTES CLI, CADORCAMENTOS CAD '+
                              ' WHERE CLI.I_COD_CLI = CAD.I_COD_CLI '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true) +
                              ' AND CAD.C_IND_CAN = ''N''');

  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaUf+'''');
    Rave.SetParam('ESTADO',VpaUF);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaCodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomfilial );
  end;
  if VpaCodSituacaoCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_SIT = '+InttoStr(VpaCodSituacaoCliente));
    Rave.SetParam('SITUACAO',VpaNomSituacaoCliente );
  end;
  if (VpaCodRepresentada <> 0) then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_REP = '+InttoStr(VpaCodRepresentada));
    Rave.SetParam('REPRESENTADA',VpaNomRepresentada );
  end;

  if VpaSomenteClientesAtivos then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_IND_ATI = ''S''');
  end;
  Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  if VpaCurvaABC then
    AdicionaSqlTabeLa(Principal,'GROUP BY CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                                'ORDER BY 3 DESC')
  else
    AdicionaSqlTabeLa(Principal,'GROUP BY CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                                'ORDER BY 2');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeExtratoColetaFracaoOPProduto(VpaSeqProduto, VpaSeqEstagio: Integer; VpaNomProduto, VpaNomEstagio: String; VpaDatInicio,  VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Extrato Coleta Fracao Produto - '+VpaNomProduto;
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_Extrato Coleta Fracao Produto.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'select CEL.CODCELULA, CEL.NOMCELULA, '+
                                  ' COL.CODFILIAL, COL.SEQORDEM, COL.SEQFRACAO, COL.SEQESTAGIO, COL.SEQCOLETA, COL.DESUM, COL.QTDCOLETADO, COL.QTDPRODUCAOHORA, '+
                                  ' COL.QTDPRODUCAOIDEAL, COL.PERPRODUTIVIDADE, COL.DATINICIO, COL.DATINICIO HORAINICIO, COL.DATFIM '+
                                  ' from CELULATRABALHO CEL, COLETAFRACAOOP COL, FRACAOOPESTAGIO FOE '+
                                  ' Where FOE.CODFILIAL = COL.CODFILIAL '+
                                  ' AND FOE.SEQORDEM = COL.SEQORDEM '+
                                  ' AND FOE.SEQFRACAO = COL.SEQFRACAO '+
                                  ' AND FOE.SEQESTAGIO = COL.SEQESTAGIO '+
                                  ' AND COL.CODCELULA = CEL.CODCELULA '+
                                  ' AND FOE.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                                  ' AND COL.SEQESTAGIO = '+ IntTosTr(VpaSeqEstagio)+
                                  SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',VpaDatInicio,IncDia(VpaDatFim,1),true)+
                                  ' order by CEL.CODCELULA, COL.DATINICIO' );
  AdicionaSqlAbreTabela(Item,'select MAX(COL.PERPRODUTIVIDADE) PERCENTUAL, CEL.NOMCELULA '+
                                  ' from CELULATRABALHO CEL, COLETAFRACAOOP COL, FRACAOOPESTAGIO FOE '+
                                  ' Where FOE.CODFILIAL = COL.CODFILIAL '+
                                  ' AND FOE.SEQORDEM = COL.SEQORDEM '+
                                  ' AND FOE.SEQFRACAO = COL.SEQFRACAO '+
                                  ' AND FOE.SEQESTAGIO = COL.SEQESTAGIO '+
                                  ' AND COL.CODCELULA = CEL.CODCELULA '+
                                  ' AND FOE.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                                  ' AND COL.SEQESTAGIO = '+ IntTosTr(VpaSeqEstagio)+
                                  SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',VpaDatInicio,IncDia(VpaDatFim,1),true)+
                                  ' GROUP BY CEL.NOMCELULA '+
                                  ' ORDER BY 1 DESC ' );
  Rave.SetParam('PRODUTO',VpaNomProduto);
  Rave.SetParam('ESTAGIO',VpaNomEstagio);
  Rave.SetParam('PERIODO','Período de  '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYY',VpaDatFim));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeInventarioProduto(VpaCodFilial, VpaSeqInventario: Integer; VpaCaminho, VpaNomfilial: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Inventario Produto';
  Rave.projectfile := varia.PathRelatorios+'\Produto\xx_Inventario Produto.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'select  PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                                  ' COR.NOM_COR, '+
                                  ' ITE.COD_FILIAL, ITE.SEQ_INVENTARIO, ITE.COD_UNIDADE, ITE.QTD_PRODUTO, '+
                                  ' TAM.NOMTAMANHO '+
                                  ' from CADPRODUTOS PRO, COR, TAMANHO TAM, INVENTARIOITEM ITE '+
                                  ' Where ITE.SEQ_PRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND ' +SQLTextoRightJoin('ITE.COD_COR','COR.COD_COR')+
                                  ' AND ' +SQLTextoRightJoin('ITE.COD_TAMANHO','TAM.CODTAMANHO')+
                                  ' AND ITE.COD_FILIAL = ' + IntToStr(VpaCodFilial)+
                                  ' AND ITE.SEQ_INVENTARIO = '+IntToStr(VpaSeqInventario)+
                                  ' ORDER BY PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO');
  Rave.SetParam('FILIAL',VpaNomfilial);
  Rave.SetParam('INVENTARIO',IntToStr(VpaSeqInventario));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeContasaReceberPorEmissao(VpaCodFilial, VpaCodVendedor: Integer; VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho, VpaNomFilial, VpaNomVendedor: String;VpaMostrarFrio, VpaSomenteFaturado: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Contas a Receber por Emissao';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\Contas a Receber\0100PLFI_Contas a Receber por Emissao.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT REC.I_EMP_FIL, REC.D_DAT_EMI, REC.I_NRO_NOT, REC.N_VLR_TOT, REC.I_QTD_PAR, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                              ' FROM CADCONTASARECEBER REC, CADCLIENTES CLI '+
                              ' Where REC.I_COD_CLI = CLI.I_COD_CLI'+
                               SQLTextoDataEntreAAAAMMDD('REC.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND REC.I_EMP_FIL = '+InttoStr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomfilial );
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  end;
  if not VpaMostrarFrio then
    AdicionaSqlTabeLa(Principal,'and C_IND_CAD = ''N''');
  if VpaSomenteFaturado then
    AdicionaSqlTabeLa(Principal,'and not(REC.I_SEQ_NOT IS NULL and REC.I_LAN_ORC IS NULL)');
  AdicionaSqlTabeLa(Principal,'order BY REC.D_DAT_EMI, REC.I_NRO_NOT');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Rave.SetParam('PERIODO','Período de  '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYY',VpaDatFim));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeCortePendente;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Corte Pendente';
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_OrdemCortePendente.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, FRA.QTDPRODUTO, FRA.DATENTREGA, '+
                                      ' OP.DATEMI, '+
                                      ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                                      ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                                      ' from FRACAOOP FRA, ORDEMPRODUCAOCORPO OP, CADCLIENTES CLI, CADPRODUTOS PRO, ORDEMCORTECORPO OCP '+
                                      ' where FRA.DATCORTE IS NULL '+
                                      ' AND OP.EMPFIL = FRA.CODFILIAL '+
                                      ' AND OP.SEQORD = FRA.SEQORDEM '+
                                      ' AND OP.CODCLI = CLI.I_COD_CLI '+
                                      ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                                      ' AND OP.EMPFIL = OCP.CODFILIAL ' +
                                      ' AND OP.SEQORD = OCP.SEQORDEMPRODUCAO '+
                                      ' ORDER BY FRA.DATENTREGA, FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeCotacaocomoOrdemProducao(VpaCodFilial, VpaLanOrcamento, VpaQtdVias: Integer);
var
  VpfLaco : Integer;
  VpfDOrcamento : TRBDOrcamento;
  VpfOps : TList;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - OP '+IntToStr(VpaLanOrcamento);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_OrdemProducao.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_CON_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, CAD.C_ORD_COM, CAD.N_VLR_TOT, '+
                                  ' CAD.D_DAT_PRE, CAD.L_OBS_ORC, CAD.I_TIP_FRE, CAD.N_VLR_PRO, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.T_HOR_ENT, C_OBS_FIS,'+
                                  ' CAD.N_VLR_TRO, CAD.N_QTD_TRA, CAD.C_ESP_TRA, CAD.C_MAR_TRA, CAD.N_PES_BRU, CAD.N_PES_LIQ, '+
                                  '  CAD.D_DAT_VAL, CAD.N_VAL_TAX, CAD.I_TIP_GRA, CAD.C_DES_SER,'+
                                  ' TIP.I_COD_TIP, TIP.C_NOM_TIP, TEC.NOMTECNICO, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, CLI.C_CPF_CLI, CLI.C_TIP_PES, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FO2_CLI, CLI.C_FON_CEL, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  '  CLI.C_END_COB, CLI.C_BAI_COB, CLI.I_NUM_COB, CLI.C_CID_COB, CLI.C_EST_COB, CLI.C_CEP_COB, '+
                                  ' CLI.C_IND_CBA, CLI.C_IND_BUM, CLI.I_COD_EMB, CLI.I_TIP_MAP, '+
                                  ' EMB.NOM_EMBALAGEM, '+
                                  ' TIP.NOMTIPOMATERIAPRIMA, ' +
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                                  ' TRA.C_NOM_CLI C_NOM_TRA, TRA.C_FO1_CLI C_FON_TRA, '+
                                  ' PAG.C_NOM_PAG, '+
                                  ' FRM.C_NOM_FRM, '+
                                  ' VEP.C_NOM_VEN VENDEDORPREPOSTO ' +
                                  ' from CADORCAMENTOS CAD, CADTIPOORCAMENTO TIP, CADCLIENTES CLI, CADVENDEDORES VEN, CADCLIENTES TRA, '+
                                  ' CADCONDICOESPAGTO PAG, CADFORMASPAGAMENTO FRM, CADVENDEDORES VEP, TECNICO TEC, TIPOMATERIAPRIMA TIP, EMBALAGEM EMB '+
                                  ' where CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                                  ' AND CAD.I_COD_TEC = TEC.CODTECNICO (+) ' +
                                  ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_CLI')+
                                  ' AND '+SQLTextoRightJoin('CAD.I_VEN_PRE','VEP.I_COD_VEN')+
                                  ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                                  ' AND '+SQLTextoRightJoin('CLI.I_TIP_MAP','TIP.CODTIPOMATERIAPRIMA')+
                                  ' AND '+SQLTextoRightJoin('CLI.I_COD_EMB','EMB.COD_EMBALAGEM')+
                                  ' AND CAD.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = ' +IntToStr(VpaLanOrcamento));
  LimpaSQLTabela(Item);
  AdicionaSqlTabela(Item,'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, MOV.N_VLR_TOT, MOV.C_NOM_PRO PRODUTOCOTACAO, '+
                             ' MOV.C_IND_BRI, MOV.N_SAL_BRI, MOV.C_DES_COR, MOV.N_ALT_PRO, '+
                             ' MOV.C_DES_COR CORCOTACAO, MOV.C_PRO_REF, MOV.N_PER_DES, MOV.C_ORD_COM, MOV.I_COD_TAM, '+
                             ' N_QTD_PRO - NVL(N_Qtd_Bai,0) - NVL(N_QTD_CAN,0) QTDPRO, '+
                             ' COR.COD_COR, COR.NOM_COR, '+
                             ' PRO.C_NOM_PRO, '+
                             ' TAM.NOMTAMANHO, '+
                             ' EMB.NOM_EMBALAGEM, '+
                             ' CLA.C_COD_CLA, CLA.C_NOM_CLA  '+
                             ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO, COR, TAMANHO TAM, CADCLASSIFICACAO CLA, EMBALAGEM EMB  '+
                             ' where MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                             ' AND PRO.I_COD_EMP = CLA.I_COD_EMP  ' +
                             ' and ' + SQLTextoRightJoin('MOV.I_COD_EMB','EMB.COD_EMBALAGEM')+
                             ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                             ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                             ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                             ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                             ' AND N_QTD_PRO - NVL(N_Qtd_Bai,0) - NVL(N_QTD_CAN,0) > 0 '+
                             ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO'));
  case varia.OrdemImpressaoOPCotacao of
    oiSequenciaDigitacao :  AdicionaSQLTabela(Item, ' ORDER BY MOV.I_SEQ_MOV');
    oiNomeProduto :  AdicionaSQLTabela(Item,' ORDER BY PRO.C_NOM_PRO');
  end;
  Item.Open;
  RPDev.DeviceIndex := RPDev.Printers.IndexOf(varia.ImpressoraRelatorio);
  RpDev.DevMode.dmPaperSize := DMPAPER_A4;
  for VpfLaco := 1 to VpaQtdVias do
    Rave.Execute;

  VpfOps := TList.Create;
  VpfDOrcamento := TRBDOrcamento.cria;
  FunCotacao.CarDOrcamento(VpfDOrcamento,VpaCodFilial,VpaLanOrcamento);
  VpfOps.Add(VpfDOrcamento);
  FunCotacao.SetaOPImpressa(VpfOps);
  VpfOps.Free;
  VpfDOrcamento.Free;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalProspectPorRamoAtividade(VpaCaminho : string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Total Prospect por Ramo Atividade';
  Rave.projectfile := varia.PathRelatorios+'\Prospect\0300PLCRES_Total Prospects por Ramo Atividade.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT  RAM.NOM_RAMO_ATIVIDADE, COUNT(I_COD_CLI) QTD '+
                              ' FROM CADCLIENTES CLI, RAMO_ATIVIDADE RAM '+
                              ' Where CLI.C_IND_PRC = ''S'''+
                              ' AND CLI.I_COD_RAM = RAM.COD_RAMO_ATIVIDADE (+) '+
                              ' GROUP BY RAM.NOM_RAMO_ATIVIDADE '+
                              ' ORDER BY 1 ');
  Rave.SetParam('CAMINHO',VpaCaminho);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProspectPorCeP(VpaSomenteNaoVisitados : boolean; VpaCaminho: string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Prospect por CEP';
  Rave.projectfile := varia.PathRelatorios+'\Prospect\0100CRPL_Prospects por CEP.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'Select CLI.I_COD_CLI, CLI.C_NOM_CLI, C_END_CLI, CLI.C_COM_END, CLI.C_BAI_CLI, ' +
                              ' CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_IND_VIS, ' +
                              ' RAM.NOM_RAMO_ATIVIDADE ' +
                              ' FROM CADCLIENTES CLI, RAMO_ATIVIDADE RAM ' +
                              ' Where '+SQLTextoRightJoin('CLI.I_COD_RAM','RAM.COD_RAMO_ATIVIDADE')+
                              ' AND CLI.C_IND_PRC = ''S''');
  if VpaSomenteNaoVisitados then
    AdicionaSqlTabeLa(Principal,'AND CLI.C_IND_VIS = ''N''');
  AdicionaSqlTabeLa(Principal,' ORDER BY CLI.C_CEP_CLI, C_END_CLI');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeContasAReceberEmAbertoPorVendedor(VpaDatVencimento: TDateTime; VpaCodVendedor, VpaCodFilial: Integer;
  VpaCaminhoRelatorio, VpaNomFilial, VpaNomVendedor: String; VpaFundoPerdido, VpaMostrarFrio: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Contas a Receber em Aberto por Vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\Contas a Receber\Inadimplencia\0300PLFI_Em Aberto por Vendedor.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_FO1_CLI, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CID_CLI, '+
                              ' CAD.D_DAT_EMI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' MOV.C_NRO_DUP, MOV.D_DAT_VEN, MOV.N_VLR_PAR '+
                              ' from CADCLIENTES CLI, CADCONTASARECEBER CAD, CADVENDEDORES VEN, MOVCONTASARECEBER MOV '+
                              ' Where CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND ' + SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN')+
                              ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                              ' AND MOV.D_DAT_VEN < '+SQLTextoDataAAAAMMMDD(VpaDatVencimento)+
                              ' AND MOV.D_DAT_PAG IS NULL '+
                              ' AND CAD.C_IND_DEV = ''N''');
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if not VpaMostrarFrio then
    AdicionaSqlTabeLa(Principal,'and CAD.C_IND_CAD = ''N''');
  if not VpaFundoPerdido then
  Begin
    AdicionaSqlTabeLa(Principal,' AND MOV.C_FUN_PER  = ''N''');
    Rave.SetParam('FUNDOPERDIDO','N');
  End
  else
    Rave.SetParam('FUNDOPERDIDO','S');


  Rave.SetParam('VENCIMENTO', FormatDateTime('DD/MM/YYYY',VpaDatVencimento));

  AdicionaSqlTabeLa(Principal,' ORDER BY VEN.C_NOM_VEN, CLI.C_NOM_CLI, MOV.D_DAT_VEN');
  Principal.open;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTermoImplantacao(VpaCodFilial, VpaNumChamado: Integer; VpaVisualizar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Termo Implantacao '+IntToStr(VpaNumChamado);
  Rave.projectfile := varia.PathRelatorios+'\Chamado\XX_TermoImplantacao.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.NOMCONTATO, CHA.NOMSOLICITANTE, CHA.DESENDERECOATENDIMENTO, '+
                                  ' CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.DESOBSERVACAOGERAL, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' USU.C_NOM_USU, '+
                                  ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                                  'FROM CHAMADOCORPO CHA, CADCLIENTES CLI, CADUSUARIOS USU, TECNICO TEC '+
                                  ' Where CHA.CODFILIAL =  '+IntToStr(VpaCodFilial)+
                                  ' AND CHA.NUMCHAMADO = '+IntToStr(VpaNumChamado)+
                                  ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND CHA.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND CHA.CODTECNICO = TEC.CODTECNICO');
  AdicionaSqlAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_PRA_PRO, '+
                             ' CHP.NUMSERIE, CHP.NUMCONTADOR, CHP.NUMSERIEINTERNO,CHP.DESSETOR, CHP.DESPROBLEMA, '+
                             ' CHP.DESSERVICOEXECUTADO, CHP.DATGARANTIA, CHP.QTDPRODUTO, CHP.DESUM,  '+
                             ' TIP.NOMTIPOCONTRATO '+
                             ' from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                             ' Where CHP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND CHP.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                             ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND '+SQLTEXTORightJoin('CHP.CODFILIALCONTRATO','CON.CODFILIAL')+
                             ' AND '+SQLTEXTORightJoin('CHP.SEQCONTRATO','CON.SEQCONTRATO')+
                             ' AND '+SQLTEXTORightJoin('CON.CODTIPOCONTRATO','TIP.CODTIPOCONTRATO'));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeVendasporVendedor(VpaDatInicio, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente, VpaCodVendedor,
  VpaCodTipoCotacao: Integer; VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente, VpaNomVendedor, VpaNomTipoCotacao: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Vendas por Vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Vendedor\0100PL_Vendas por Vendedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_ORC, CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_NRO_NOT,  ' +
                        ' CAD.D_DAT_PRE,  CAD.D_DAT_ENT, CAD.I_COD_CLI , CAD.C_IND_CAN ,CAD.I_TIP_ORC, '+
                        ' CLI.C_NOM_CLI, ' +
                        ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                        ' N_VLR_TOT, PAG.I_COD_PAG, PAG.C_NOM_PAG ' );
  AdicionaSqlTabeLa(Principal,'from cadorcamentos CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG, CADVENDEDORES VEN ');
  AdicionaSqlTabeLa(Principal,'WHERE CAD.I_COD_CLI = CLI.I_COD_CLI '+
                        ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                        ' AND CAD.C_IND_CAN = ''N'''+
                        ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                        SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;

  if (varia.CNPJFilial = CNPJ_Kairos) or (varia.CNPJFilial = CNPJ_AviamentosJaragua) then
    AdicionaSqlTabeLa(Principal,' and CAD.I_EMP_FIL <> 13 ');

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.I_COD_VEN,CAD.D_DAT_ORC,CAD.I_LAN_ORC');
  Principal.open;

  Rave.Execute;
end;

procedure TdtRave.ItemAfterExecute(Sender: TObject; var OwnerData: OleVariant);
begin
end;

{*******************************************************************************}
procedure TdtRave.ImprimeSaidaMateriais(VpaCodFilial, VpaNumChamado, VpaSeqParcial: Integer);
begin
  // Chamado Parcial
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Saida de Material. Chamado Técnico '+IntToStr(VpaNumChamado);
  Rave.projectfile := varia.PathRelatorios+'\Chamado\2000CH_Saida de Material.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.NOMCONTATO, CHA.NOMSOLICITANTE, CHA.DESENDERECOATENDIMENTO, '+
                                  ' CHA.DATCHAMADO, CHA.DATPREVISAO, CPC.SEQPARCIAL, CPC.DATPARCIAL, CPC.INDFATURADO, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' USU.C_NOM_USU, '+
                                  ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                                  'FROM CHAMADOCORPO CHA, CHAMADOPARCIALCORPO CPC, CADCLIENTES CLI, CADUSUARIOS USU, TECNICO TEC '+
                                  ' Where CHA.CODFILIAL =  ' + IntToStr(VpaCodFilial)+
                                  ' AND CHA.NUMCHAMADO = ' + IntToStr(VpaNumChamado)+
                                  ' AND CPC.SEQPARCIAL = ' + IntToStr(VpaSeqParcial)+
                                  ' AND CHA.CODFILIAL = CPC.CODFILIAL AND CHA.NUMCHAMADO = CPC.NUMCHAMADO ' +
                                  ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND CPC.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND CPC.CODTECNICO = TEC.CODTECNICO'+
                                  ' AND CPC.INDRETORNO = ''N''');
  AdicionaSqlAbreTabela(Item,'select CPP.CODFILIAL, CPP.NUMCHAMADO, CPP.SEQPARCIAL, CPP.QTDPRODUTO, CPP.DESUM, CPP.INDPRODUTOEXTRA, CPP.INDFATURADO, ' +
                             '       PRO.C_COD_PRO, PRO.C_NOM_PRO ' +
                             'from CHAMADOPARCIALPRODUTO CPP, CADPRODUTOS PRO ' +
                             'Where CPP.SEQPRODUTO = PRO.I_SEQ_PRO'+
                             ' AND CPP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND CPP.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                             ' AND CPP.SEQPARCIAL = ' + IntToStr(VpaSeqParcial)+
                             ' ORDER BY SEQITEM');
  Rave.Execute;
end;

{*******************************************************************************}
procedure TdtRave.ImprimeSolicitacaoCompra(VpaCodFilial, VpaSeqSolicitacao: Integer; VpaVisualizar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Solicitacao Compra '+IntToStr(VpaSeqSolicitacao);
  Rave.projectfile := varia.PathRelatorios+'\Solicitacao Compra\XX_Solicitacao Compra.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT SOL.CODFILIAL, SOL.SEQSOLICITACAO, SOL.DATEMISSAO, SOL.HOREMISSAO, SOL.DESOBSERVACAO, '+
                                  '   SOL.CODESTAGIO, SOL.DATPREVISTA, SOL.DATAPROVACAO, '+
                                  ' USU.C_NOM_USU, '+
                                  '  EST.NOMEST '+
                                  ' FROM SOLICITACAOCOMPRACORPO SOL, CADUSUARIOS USU, ESTAGIOPRODUCAO EST '+
                                  ' WHERE SOL.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                  ' AND SOL.SEQSOLICITACAO = '+INtToSTr(VpaSeqSolicitacao)+
                                  ' AND USU.I_COD_USU = SOL.CODUSUARIO '+
                                  ' AND SOL.CODESTAGIO = EST.CODEST');
  AdicionaSqlAbreTabela(Item,'Select PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                             ' COR.NOM_COR, '+
                             ' ITE.QTDPRODUTO, ITE.DESUM '+
                             ' from CADPRODUTOS PRO, COR, SOLICITACAOCOMPRAITEM ITE '+
                             ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND '+SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                             ' AND ITE.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                             '  AND ITE.SEQSOLICITACAO = '+INtToSTr(VpaSeqSolicitacao)+
                             ' ORDER BY ITE.SEQITEM ');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProposta(VpaCodFilial, VpaSeqProposta: Integer; VpaVisualizar: Boolean);
var
  VpfDataExtenso,
  VpfNomFilialCurto,
  VpfProdutoRotulados, VpfModeloRelatorio: String;
  VpfQtdRotulados,
  VpfIndice: integer;
  VpfProdutosRotuladosClasse: TRBFuncoesProposta;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Proposta '+IntToStr(VpaSeqProposta);
  Rave.projectfile := varia.PathRelatorios+'\Proposta\XX_Proposta.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'Select CLI.I_COD_CLI, C_NOM_CLI, C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.C_CID_CLI, '+
                                  ' CLI.C_EST_CLI, CLI.C_FO1_CLI,CLI.C_CEP_CLI,CLI.C_CGC_CLI,CLI.C_INS_CLI,CLI.C_FON_FAX, '+
                                  ' PAG.I_COD_PAG, PAG.C_NOM_PAG, PRP.TIPHORASINSTALACAO, '+
                                  ' FRM.I_COD_FRM, FRM.C_NOM_FRM, '+
                                  ' PRF.I_COD_PRF, PRF.C_NOM_PRF, '+
                                  ' USU.I_COD_USU, USU.C_NOM_USU, VEN.C_DES_EMA, VEN.C_DES_MSN, VEN.C_FON_VEN, VEN.C_CEL_VEN, VEN.I_COD_PRF, '+
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, VEN.C_CON_VEN, PRP.QTDPRAZOENTREGA, PRP.INDDEVOLVERAVAZIO, PRP.TIPFRETE, '+
                                  ' PRP.CODFILIAL, PRP.SEQPROPOSTA, PRP.DATPROPOSTA, PRP.DATVALIDADE, PRP.PERDESCONTO, '+
                                  ' PRP.VALDESCONTO, PRP.NOMCONTATO, PRP.DESEMAIL, PRP.DESOBSERVACAO, PRP.DESTEMPOGARANTIA, '+
                                  ' PRP.VALTOTAL, PRP.CODSETOR, PRP.VALFRETE, PRP.DATPREVISAOVISITATEC, PRP.DESOBSDATAINSTALACAO,'+
                                  ' TIP.CODTIPOPROPOSTA, TIP.NOMTIPOPROPOSTA, '+
                                  ' SEO.DESMODELORELATORIO, SEO.DESDIRETORIOSALVARPDF, ' +
                                  ' PRV.C_NOM_PRF PROFISSAOVENDEDOR,  '+
                                  ' OBS.CODOBSINSTALACAOPROPOSTA, OBS.DESOBSINSTALACAOPROPOSTA, PRP.CODOBSINSTALACAO ' +
                                  ' FROM CADCLIENTES CLI, CADCONDICOESPAGTO PAG, CADFORMASPAGAMENTO FRM, CADPROFISSOES PRF, CADPROFISSOES PRV,CADUSUARIOS USU, '+
                                  '       CADVENDEDORES VEN, PROPOSTA PRP, TIPOPROPOSTA TIP, SETOR SEO, OBSERVACAOINSTALACAOPROPOSTA OBS '+
                                  ' WHERE '+SQLTextoRightJoin('PRP.CODCONDICAOPAGAMENTO','PAG.I_COD_PAG')+
                                  ' AND '+SQLTextoRightJoin('PRP.CODFORMAPAGAMENTO','FRM.I_COD_FRM')+
                                  ' AND '+SQLTextoRightJoin('PRP.CODPROFISSAO','PRF.I_COD_PRF')+
                                  ' AND '+SQLTextoRightJoin('PRP.CODOBSINSTALACAO','OBS.CODOBSINSTALACAOPROPOSTA')+
                                  ' AND PRP.CODVENDEDOR = VEN.I_COD_VEN '+
                                  ' AND PRP.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND PRP.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND PRP.CODSETOR = SEO.CODSETOR '+
                                  ' AND '+SQLTextoRightJoin('VEN.I_COD_PRF', 'PRV.I_COD_PRF') +
                                  ' AND '+SQLTextoRightJoin('PRP.CODTIPOPROPOSTA','TIP.CODTIPOPROPOSTA')+
                                  ' AND PRP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' AND PRP.SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
  if Principal.FieldByName('INDDEVOLVERAVAZIO').AsString = 'S' then
    Rave.SetParam('DEVOLUCAOVAZIO','Sim')
  else
    Rave.SetParam('DEVOLUCAOVAZIO','Nao');

  VpfDataExtenso := VprDFilial.DesCidade + '/' + VprDFilial.DesUF + ', ' + IntToStr(dia(Principal.FieldByName('DATPROPOSTA').AsDateTime)) + ' de ' +
                    TextoMes(Principal.FieldByName('DATPROPOSTA').AsDateTime,false) + ' de ' + IntToStr(ano(Principal.FieldByName('DATPROPOSTA').AsDateTime));
  Rave.SetParam('DATPROPOSTAEXTENSO',VpfDataExtenso);
  Rave.SetParam('NOMFILIALCURTO', CopiaAteChar(VprDFilial.NomFilial,' '));
  Rave.SetParam('DIASVALIDADE', IntToStr(DiasPorPeriodo(Principal.FieldByName('DATPROPOSTA').AsDateTime,
       Principal.FieldByName('DATPROPOSTA').AsDateTime)));
  Rave.SetParam('CEPFILIAL', VprDFilial.DesCep);
  Rave.SetParam('FONEFILIAL',VprDFilial.DesFone);
  Rave.SetParam('NOMPROFISSAO', Principal.FieldByName('PROFISSAOVENDEDOR').AsString);
  Rave.SetParam('DESEMAIL',Principal.FieldByName('C_DES_EMA').AsString);
  Rave.SetParam('DESMSN',Principal.FieldByName('C_DES_MSN').AsString);

  AdicionaSqlAbreTabela(Item,'Select ITE.SEQITEM, ITE.CODPRODUTO, ITE.CODCOR, ITE.DESUM, ITE.NOMCOR NOMECORITEM, '+
                             ' ITE.NOMPRODUTO NOMEPRODUTOITE, ITE.QTDPRODUTO, ITE.VALUNITARIO, ITE.VALTOTAL, '+
                             ' ITE.NUMOPCAO, ITE.VALDESCONTO, ITE.SEQITEMCHAMADO, ITE.SEQPRODUTOCHAMADO, ITE.DESOBSERVACAO,'+
                             ' ITE.PERIPI, ITE.VALIPI, ' +
                             ' PRO.C_NOM_PRO,PRO.L_DES_TEC, PRO.C_PAT_FOT, '+
                             ' COR.NOM_COR, PRO.C_ABE_CAB, PRO.C_CON_ELE, '+
                             ' PRO.C_TEN_ALI, PRO.C_COM_RED, PRO.C_GRA_PRO, '+
                             ' PRO.C_SEN_FER, PRO.C_SEN_NFE, PRO.C_ACO_INO, '+
                             ' PRO.L_DES_FUN, PRO.L_DES_TEC, PRO.L_INF_DIS, PRO.C_CLA_FIS, PRO.N_RED_ICM, PRO.C_DES_COM, PRO.C_INF_TEC, ' +
                             ' PRC.C_COD_PRO CODPRODUTOCHAMADO, PRC.C_NOM_PRO NOMPRODUTOCHAMADO '+
                             ' FROM PROPOSTAPRODUTO ITE, CADPRODUTOS PRO, CADPRODUTOS PRC, COR '+
                             ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ITE.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                             ' AND ITE.SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                             ' AND ' +SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                             ' AND ' +SQLTextoRightJoin('ITE.SEQPRODUTOCHAMADO','PRC.I_SEQ_PRO')+
                             ' ORDER BY ITE.SEQITEM ');
  AdicionaSqlAbreTabela(Item2,'Select ITE.SEQITEM, ITE.CODSERVICO, ITE.QTDSERVICO, ITE.VALUNITARIO, ITE.VALTOTAL, '+
                              ' ITE.SEQITEMCHAMADO, ITE.SEQPRODUTOCHAMADO, '+
                              ' SER.C_NOM_SER '+
                              ' from PROPOSTASERVICO ITE, CADSERVICO SER '+
                              ' Where ITE.CODEMPRESASERVICO = SER.I_COD_EMP '+
                              ' AND ITE.CODSERVICO = SER.I_COD_SER '+
                              ' AND ITE.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                              ' AND ITE.SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                              ' ORDER BY ITE.SEQITEM ');
    AdicionaSqlAbreTabela(Item3,' Select ppr.seqproposta,  PPR.SeqItem, PPR.SeqProduto, PPR.CodFormatoFrasco, PPR.CodMaterialFrasco,  PPR.AltFrasco, ' +
                                ' PPR.LarFrasco, PPR.ProFrasco, PPR.DiaFrasco, PPR.LarRotulo,  PPR.LarContraRotulo, PPR.LarGargantilha, PPR.AltRotulo, PPR.AltContraRotulo, PPR.OBSPRODUTO, PPR.DESPROROTULADO, ' +
                                ' PPR.AltGargantilha,  PPR.CodMaterialRotulo, PPR.CodLinerRotulo, PPR.CodMaterialContraRotulo, PPR.CodLinerContraRotulo,  ' +
                                ' PPR.CodMaterialGargantilha, PPR.CodLinerGargantilha, PPR.QTDFRASCOHORA,  PRO.C_COD_PRO, PRO.C_NOM_PRO,  FOF.NomFormato,  ' +
                                ' MAF.NomMaterialFrasco, PRO.C_NOM_PRO ' +
                                ' FROM PROPOSTAPRODUTOROTULADO PPR, FORMATOFRASCO FOF, MATERIALFRASCO MAF, CADPRODUTOS PRO ' +
                                ' WHERE '+SQLTextoRightJoin('PPR.CODFORMATOFRASCO','MAF.CODMATERIALFRASCO') +
                                '       AND '+SQLTextoRightJoin('PPR.CODFORMATOFRASCO','FOF.CODFORMATO') +
                                '       AND PPR.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                '       AND PPR.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                '       AND PPR.SEQPROPOSTA = '+IntToStr(VpaSeqProposta) +
                                ' ORDER BY PPR.SEQITEM ');
    AdicionaSqlAbreTabela(Item4,' Select ACE.CODACESSORIO, ACE.NOMACESSORIO ' +
                                '   from ACESSORIO ACE, PRODUTOACESSORIO PAC, PROPOSTAPRODUTO ITE ' +
                                '  Where ACE.CODACESSORIO = PAC.CODACESSORIO ' +
                                '       and PAC.SEQPRODUTO = ITE.SEQPRODUTO ' +
                                '       AND ITE.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                '       AND ITE.SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                                '       order by PAC.SEQITEM');
    if Varia.CNPJFilial = CNPJ_PERFOR then
      AdicionaSqlAbreTabela(Item5,' SELECT PRP.CODFILIAL, PRP.SEQPROPOSTA, PRP.SEQITEM, PRP.SEQPRODUTO, PRP.CODEMBALAGEM, '  +
                                  '        PRP.CODAPLICACAO, PRP.DESPRODUCAO, PRP.DESSENTIDOPASSAGEM, PRP.DESDIAMETROTUBO, ' +
                                  '        PRP.DESOBSERVACAO, PRO.C_NOM_PRO, EMB.NOM_EMBALAGEM, APL.NOMAPLICACAO ' +
                                  '   FROM PROPOSTAPRODUTOCLIENTE PRP, CADPRODUTOS PRO, EMBALAGEM EMB, APLICACAO APL ' +
                                  ' WHERE PRP.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                  '       AND PRP.CODEMBALAGEM = EMB.COD_EMBALAGEM ' +
                                  '       AND PRP.CODAPLICACAO = APL.CODAPLICACAO ' +
                                  '       AND PRP.SEQPROPOSTA = ' + IntToStr(VpaSeqProposta)+
                                  '       AND PRP.CODFILIAL = ' + IntToStr(VpaCodFilial));
    AdicionaSqlAbreTabela(VendaAdicional,' Select DISTINCT PRP.VALTOTAL, PRO.C_NOM_PRO' +
                                         ' from PROPOSTAVENDAADICIONAL PRP, CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe' +
                                         ' Where Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                         '       and Pre.I_Cod_Moe = Moe.I_Cod_Moe ' +
                                         '       and Pro.c_ven_avu = ''S'' ' +
                                         '       and PRE.I_COD_CLI  = 0 ' +
                                         '       and PRE.I_COD_TAM  = 0 ' +
                                         '       AND PRP.CODFILIAL = ' + IntToStr(VpaCodFilial)+
                                         '       and PRP.SEQPROPOSTA = ' + IntToStr(VpaSeqProposta)+
                                         '       AND PRP.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                         ' --ORDER BY PRP.SEQITEM ');
    AdicionaSqlAbreTabela(Item6,' Select PC.SEQPRODUTOCHAMADO, PC.SEQITEMCHAMADO, PC.VALTOTAL, ' +
                                ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                                ' from PROPOSTAPRODUTOSCHAMADO PC, CADPRODUTOS PRO ' +
                                ' Where PC.SEQPRODUTOCHAMADO = PRO.I_SEQ_PRO '+
                                ' AND PC.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                ' AND PC.SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                                '  ORDER BY PC.SEQITEMCHAMADO ');

    AdicionaSqlAbreTabela(ChamadoProposta,' Select NUMCHAMADO' +
                                ' from CHAMADOPROPOSTA' +
                                ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));

   AdicionaSqlAbreTabela(Item7,' Select PRO.VALPAGAMENTO, PRO.DESCONDICAO, PRO.CODFORMAPAGAMENTO, ' +
                                ' CAD.C_NOM_FRM DESFORMAPAGAMENTO, CAD.I_COD_FRM ' +
                                ' from PROPOSTAPARCELAS PRO, CADFORMASPAGAMENTO CAD' +
                                ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                                ' AND PRO.CODFORMAPAGAMENTO = CAD.I_COD_FRM'+
                                ' order by PRO.SEQITEM');

  if Principal.FieldByName('DESMODELORELATORIO').AsString <> '' then
    VpfModeloRelatorio := Principal.FieldByName('DESMODELORELATORIO').AsString
  else
    VpfModeloRelatorio :='Report1';
//  salvaSql;

  Rave.ExecuteReport(VpfModeloRelatorio);

  if Principal.FieldByName('DESDIRETORIOSALVARPDF').AsString <> '' then
  begin
    VplArquivoPDF := Principal.FieldByName('DESDIRETORIOSALVARPDF').AsString +'\' + Principal.FieldByName('SEQPROPOSTA').AsString + ' - ' + Principal.FieldByName('C_NOM_CLI').AsString + ' - ' + Item.FieldByName('NOMEPRODUTOITE').AsString +'.pdf';
    ConfiguraRelatorioPDF;
    Rave.ExecuteReport(VpfModeloRelatorio);
  end
end;

{******************************************************************************}
procedure TdtRave.ImprimePropostaAnalitico(VpaCodFilial, VpaCodCliente,VpaCodCondicaoPagamento, VpaCodVendedor, VpaCodSetor : Integer; VpaDatInicio,VpaDatFim: TDatetime; VpaCaminhoRelatorio, VpaDesCidade, VpaUF, VpaNomCliente,VpaNomCondicaoPagamento, VpaNomVendedor, VpaNomFilial, VpaNomSetor, VpaCodClassificacao, VpaNomClassificacao: string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Propostas Analitico';
  Rave.projectfile := varia.PathRelatorios+'\Proposta\0200CR_Propostas Analitico.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  Principal.sql.add('SELECT PRP.CODFILIAL, PRP.SEQPROPOSTA, PRP.CODCLIENTE, PRP.DATPROPOSTA, PRP.VALTOTAL, PRP.CODCONDICAOPAGAMENTO, PRP.CODVENDEDOR,' +
                    ' VEN.C_NOM_CLI, ' +
                    ' CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI' +
                    ' FROM PROPOSTA PRP, CADCLIENTES CLI, CADCLIENTES VEN '+
                    ' Where PRP.CODCLIENTE = CLI.I_COD_CLI '+
                    ' AND PRP.CODVENDEDOR = VEN.I_COD_CLI ');
  Item.Close;
  Item.sql.clear;
  Item.sql.add('SELECT PRP.CODFILIAL , PRP.SEQPROPOSTA, PRP.CODCONDICAOPAGAMENTO, PRP.CODVENDEDOR, '+
               ' MOV.CODPRODUTO, MOV.DESUM, MOV.QTDPRODUTO, MOV.VALUNITARIO, MOV.VALTOTAL, '+
               ' MOV.NOMPRODUTO, CLI.C_CID_CLI, CLI.C_EST_CLI '+
               ' FROM PROPOSTA PRP, PROPOSTAPRODUTO MOV, CADCLIENTES CLI '+
               ' Where PRP.CODFILIAL = MOV.CODFILIAL '+
               ' AND PRP.SEQPROPOSTA = MOV.SEQPROPOSTA '+
               ' AND PRP.CODCLIENTE = CLI.I_COD_CLI');

  Item2.Close;
  Item2.sql.clear;
  Item2.sql.add('SELECT PRP.CODFILIAL , PRP.SEQPROPOSTA, PRP.CODCONDICAOPAGAMENTO, PRP.CODVENDEDOR, '+
               ' MOV.CODSERVICO, MOV.QTDSERVICO, MOV.VALUNITARIO, MOV.VALTOTAL, '+
               ' SER.C_NOM_SER, CLI.C_CID_CLI, CLI.C_EST_CLI  '+
               ' FROM PROPOSTA PRP, PROPOSTASERVICO MOV, CADSERVICO SER, CADCLIENTES CLI '+
               ' Where PRP.CODFILIAL = MOV.CODFILIAL '+
               ' AND PRP.SEQPROPOSTA = MOV.SEQPROPOSTA '+
               ' AND MOV.CODSERVICO = SER.I_COD_SER'+
               ' AND PRP.CODCLIENTE = CLI.I_COD_CLI');

  if VpaCodFilial <> 0  then
  begin
   Principal.sql.add('AND PRP.CODFILIAL = '+IntToStr(VpaCodFilial));
   Item.sql.add('AND PRP.CODFILIAL = '+IntToStr(VpaCodFilial));
   Item2.sql.add('AND PRP.CODFILIAL = '+IntToStr(VpaCodFilial));
   Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
   Principal.sql.add('AND PRP.CODCLIENTE = '+IntToStr(VpaCodCliente));
   Item.sql.add('AND PRP.CODCLIENTE = '+IntToStr(VpaCodCliente));
   Item2.sql.add('AND PRP.CODCLIENTE = '+IntToStr(VpaCodCliente));
   Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0  then
  begin
   Principal.sql.add('AND PRP.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
   Item.sql.add('AND PRP.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
   Item2.sql.add('AND PRP.CODVENDEDOR = '+IntToStr(VpaCodCondicaoPagamento));
   Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if DeletaEspaco(VpaDesCidade) <>  ''  then
  begin
   Principal.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Item.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Item2.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Rave.SetParam('CIDADE',VpaDesCidade);
  end;
  if VpaUF <> ''  then
  begin
   Principal.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Item.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Item2.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Rave.SetParam('UF',VpaUF);
  end;
  if VpaCodSetor <> 0 then
  begin
   Principal.sql.add('AND PRP.CODSETOR = '+IntToStr(VpaCodSetor));
   Item.sql.add('AND PRP.CODSETOR = '+IntToStr(VpaCodSetor));
   Item2.sql.add('AND PRP.CODSETOR = '+IntToStr(VpaCodSetor));
   Rave.SetParam('SETOR',VpaNomSetor);
  end;

  if VpaCodClassificacao <> '' then
  begin
   Principal.sql.add('AND EXISTS( SELECT 1 FROM PROPOSTAPRODUTO ITE, CADPRODUTOS PRO ' +
                     ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                     ' AND PRO.C_COD_CLA LIKE '''+VpaCodClassificacao+'%'''+
                     ' AND PRO.I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa)+
                     ' AND PRO.C_TIP_CLA = ''P'''+
                     ' AND ITE.CODFILIAL = PRP.CODFILIAL ' +
                     ' AND ITE.SEQPROPOSTA = PRP.SEQPROPOSTA )');
   Rave.SetParam('CLASSIFICACAO',VpaNomClassificacao);
  end;

  Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YY',VpaDatFim));
  Principal.sql.add(SQLTextoDataEntreAAAAMMDD('PRP.DATPROPOSTA',VpaDatInicio,VpaDatFim,true));

  Item.sql.add(SQLTextoDataEntreAAAAMMDD('PRP.DATPROPOSTA',VpaDatInicio,VpaDatFim,true));
  Item2.sql.add(SQLTextoDataEntreAAAAMMDD('PRP.DATPROPOSTA',VpaDatInicio,VpaDatFim,true));

  Principal.sql.add(' ORDER BY PRP.DATPROPOSTA, PRP.SEQPROPOSTA');
  Item.sql.add(' ORDER BY PRP.CODFILIAL, PRP.SEQPROPOSTA');
  Item2.sql.add(' ORDER BY PRP.CODFILIAL, PRP.SEQPROPOSTA');
  Principal.Open;
  Item.Open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeFichaTecnicaAmostra(VpaCodAmostra : Integer; VpaVisulizar: Boolean;VpaNomArquivo : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ficha Tecnica Amostra';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\xx_FichaTecnica.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlAbreTabeLa(Principal,'select AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGACLIENTE, AMO.INDCOPIA, '+
                              ' AMO.TIPAMOSTRA, AMO.DESOBSERVACAO, AMO.QTDAMOSTRA, '''+varia.DriveFoto+'''|| AMO.DESIMAGEM DESIMAGEM, '+
                              ' AMO.CODAMOSTRAINDEFINIDA, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' COL.NOMCOLECAO, '+
                              ' DES.NOMDESENVOLVEDOR, '+
                              ' CLA.C_COD_CLA, CLA.C_NOM_CLA '+
                              ' from AMOSTRA AMO, CADCLIENTES CLI, CADVENDEDORES VEN, COLECAO COL, DESENVOLVEDOR DES, CADCLASSIFICACAO CLA '+
                              ' Where AMO.CODCOLECAO = COL.CODCOLECAO '+
                              ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR '+
                              ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                              ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND AMO.CODEMPRESA = CLA.I_COD_EMP '+
                              ' AND AMO.CODCLASSIFICACAO = CLA.C_COD_CLA '+
                              ' AND AMO.DESTIPOCLASSIFICACAO = CLA.C_TIP_CLA '+
                              ' AND AMO.CODAMOSTRA = '+IntToStr(VpaCodAmostra));

  AdicionaSqlAbreTabeLa(Item,'select  CON.SEQCONSUMO, CON.QTDPRODUTO, CON.VALUNITARIO, CON.VALTOTAL, CON.DESOBSERVACAO, '+
                             ' CON.DESUM, CON.CODFACA, CON.ALTMOLDE, CON.LARMOLDE, CON.CODMAQUINA, CON.QTDPECAEMMETRO, '+
                             ' CON.VALINDICEMETRO, CON.DESLEGENDA, '+
                             ' PRO.C_NOM_PRO,I_ALT_PRO, '+
                             ' COR.COD_COR, COR.NOM_COR, '+
                             ' FAC.NOMFACA,' +
                             ' CON.CODTIPOMATERIAPRIMA, TIP.NOMTIPOMATERIAPRIMA '+
                             ' from AMOSTRACONSUMO CON, CADPRODUTOS PRO, COR, FACA FAC, TIPOMATERIAPRIMA TIP '+
                             ' Where CON.CODAMOSTRA = '+IntToStr(VpaCodAmostra)+
                             ' AND CON.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ' +SQLTextoRightJoin('CON.CODCOR','COR.COD_COR')+
                             ' AND ' +SQLTextoRightJoin('CON.CODFACA','FAC.CODFACA')+
                             ' AND ' +SQLTextoRightJoin('CON.CODTIPOMATERIAPRIMA','TIP.CODTIPOMATERIAPRIMA')+
                             ' ORDER BY CON.CODTIPOMATERIAPRIMA, CON.NUMSEQUENCIA, CON.DESLEGENDA');
  if VpaNomArquivo <> '' then
    VplArquivoPDF := VpaNomArquivo;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeFichaTecnicaAmostraCor(VpaCodAmostra, VpaCodCor: Integer; VpaVisulizar: Boolean; VpaNomArquivo: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ficha Tecnica Amostra';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\xx_FichaTecnicaCor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlAbreTabeLa(Principal,'select AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGACLIENTE, AMO.INDCOPIA, '+
                              ' AMO.TIPAMOSTRA, AMO.DESOBSERVACAO, AMO.QTDAMOSTRA, '''+varia.DriveFoto+'''|| AMC.DESIMAGEM DESIMAGEM, '+
                              ' AMO.CODAMOSTRAINDEFINIDA, AMO.INDPRECOESTIMADO, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' COL.NOMCOLECAO, '+
                              ' DES.NOMDESENVOLVEDOR, '+
                              ' CLA.C_COD_CLA, CLA.C_NOM_CLA '+
                              ' from AMOSTRA AMO, CADCLIENTES CLI, CADVENDEDORES VEN, COLECAO COL, DESENVOLVEDOR DES, CADCLASSIFICACAO CLA, AMOSTRACOR AMC '+
                              ' Where AMO.CODCOLECAO = COL.CODCOLECAO '+
                              ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR '+
                              ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                              ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND AMO.CODEMPRESA = CLA.I_COD_EMP '+
                              ' AND AMO.CODCLASSIFICACAO = CLA.C_COD_CLA '+
                              ' AND AMO.DESTIPOCLASSIFICACAO = CLA.C_TIP_CLA '+
                              ' AND AMO.CODAMOSTRA = AMC.CODAMOSTRA ' +
                              ' AND AMC.CODCOR = '+IntToStr(VpaCodCor)+
                              ' AND AMO.CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  AdicionaSqlAbreTabeLa(Item,'select  CON.NUMSEQUENCIA, CON.SEQCONSUMO, CON.QTDPRODUTO, CON.VALUNITARIO, CON.VALTOTAL, CON.DESOBSERVACAO, '+
                             ' CON.DESUM, CON.CODFACA, CON.ALTMOLDE, CON.LARMOLDE, CON.CODMAQUINA, CON.QTDPECAEMMETRO, '+
                             ' CON.VALINDICEMETRO, CON.DESLEGENDA, '+
                             ' PRO.C_NOM_PRO,I_ALT_PRO, '+
                             ' COR.COD_COR, COR.NOM_COR, '+
                             ' FAC.NOMFACA,FAC.ALTPROVA,FAC.LARPROVA,' +
                             ' CON.CODTIPOMATERIAPRIMA, TIP.NOMTIPOMATERIAPRIMA '+
                             ' from AMOSTRACONSUMO CON, CADPRODUTOS PRO, COR, FACA FAC, TIPOMATERIAPRIMA TIP '+
                             ' Where CON.CODAMOSTRA = '+IntToStr(VpaCodAmostra)+
                             ' AND CON.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ' +SQLTextoRightJoin('CON.CODCOR','COR.COD_COR')+
                             ' AND ' +SQLTextoRightJoin('CON.CODFACA','FAC.CODFACA')+
                             ' AND ' +SQLTextoRightJoin('CON.CODTIPOMATERIAPRIMA','TIP.CODTIPOMATERIAPRIMA')+
                             ' AND CON.CODCORAMOSTRA = '+IntToStr(VpaCodCor)+
                             ' ORDER BY CON.CODTIPOMATERIAPRIMA, CON.NUMSEQUENCIA, CON.DESLEGENDA');
  Rave.SetParam('NOMCOR',FunProdutos.RNomeCor(IntToStr(VpaCodCor)));

  if VpaNomArquivo <> '' then
    VplArquivoPDF := VpaNomArquivo;
  Rave.Execute;
  Rave.ClearRaveBlob;
end;

{******************************************************************************}
procedure TdtRave.ImprimeDiasCorte(VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Dias Corte ';
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\2300ES_Dias Ordem de Corte.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT EXTRACT(DAY FROM FRA.DATCORTE - OP.DATEMI)DIAS, COUNT(FRA.SEQFRACAO) QTD '+
                              ' FROM FRACAOOP FRA , ORDEMPRODUCAOCORPO OP '+
                              ' Where FRA.CODFILIAL = OP.EMPFIL '+
                              SQLTextoDataEntreAAAAMMDD('FRA.DATCORTE',VpaDatInicio,VpaDatFim,true)+
                              ' AND FRA.SEQORDEM = OP.SEQORD '+
                              ' AND FRA.DATCORTE IS NOT NULL '+
                              ' GROUP BY EXTRACT(DAY FROM FRA.DATCORTE - OP.DATEMI) '+
                              ' ORDER BY 2 DESC');
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeHistoricoECobranca(VpaSeqEmail: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Historico e-Cobranca';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\Cobranca\xx_ECobranca.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, ' +
                              ' COR.SEQEMAIL, COR.DATENVIO, COR.QTDENVIADOS, COR.QTDERROS, ' +
                              ' ITE.DESSTATUS, ITE.INDENVIADO, ' +
                              ' MOV.D_DAT_VEN, MOV.N_VLR_PAR, MOV.C_NRO_DUP ' +
                              ' FROM CADCLIENTES CLI, ECOBRANCACORPO COR, ECOBRANCAITEM ITE, MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD ' +
                              ' WHERE COR.SEQEMAIL = ITE.SEQEMAIL ' +
                              ' AND ITE.CODFILIAL = MOV.I_EMP_FIL ' +
                              ' AND ITE.LANRECEBER = MOV.I_LAN_REC ' +
                              ' AND ITE.NUMPARCELA = MOV.I_NRO_PAR ' +
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                              ' AND MOV.I_LAN_REC = CAD.I_LAN_REC ' +
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                              ' AND COR.SEQEMAIL = '+ IntToStr(VpaSeqEmail)+
                              ' ORDER BY ITE.INDENVIADO, CLI.I_COD_CLI');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidosPorCliente(VpaDatInicio, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao,VpaSituacaoCotacao, VpaCodCondicaoPagamento: Integer; VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente, VpaNomVendedor, VpaNomTipoCotacao,VpaNomSituacao, VpaNomCodicaoPagamento: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos por dia';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0275PL_Pedidos por Cliente.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_ORC, CAD.I_EMP_FIL, CAD.I_LAN_ORC, ' +
                        ' CAD.D_DAT_PRE,  CAD.D_DAT_ENT, CAD.I_COD_CLI , CAD.C_IND_CAN , '+
                        ' CLI.C_NOM_CLI, ' +
                        ' N_VLR_TOT, PAG.I_COD_PAG, PAG.C_NOM_PAG ' );
  AdicionaSqlTabeLa(Principal,'from cadorcamentos CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG ');
  AdicionaSqlTabeLa(Principal,'WHERE CAD.I_COD_CLI = CLI.I_COD_CLI '+
                        ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                        ' AND CAD.C_IND_CAN = ''N'''+
                        SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCodicaoPagamento);
  end;
  if VpaSituacaoCotacao = 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.C_FLA_SIT = ''A''');
    Rave.SetParam('SITUACAOCOTACAO','Em Aberto');
  end
  else
    if VpaSituacaoCotacao = 1 then
    begin
      AdicionaSqlTabeLa(Principal,'AND CAD.C_FLA_SIT = ''E''');
      Rave.SetParam('SITUACAOCOTACAO','Entregue');
    end
    else
      Rave.SetParam('SITUACAOCOTACAO','Todas');

  if (varia.CNPJFilial = CNPJ_Kairos) or (varia.CNPJFilial = CNPJ_AviamentosJaragua) then
    AdicionaSqlTabeLa(Principal,' and CAD.I_EMP_FIL <> 13 ');

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CLI.C_NOM_CLI, CAD.D_DAT_ORC,CAD.I_LAN_ORC');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProspectCadastradosporVendedor(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor, VpaCodRamoAtividade, VpaCodMeioDivulgacao : Integer; VpaCaminho,VpaNomVendedor, VpaNomRamoAtividade, VpaCidade, VpaNomMeioDivulgacao: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Prospect Cadastrados por Vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Prospect\0200CRPL_Prospects Cadastrados por Vendedor.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'Select CLI.I_COD_CLI, CLI.C_NOM_CLI, C_END_CLI, CLI.C_COM_END, CLI.C_BAI_CLI, ' +
                              ' CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_IND_VIS, CLI.D_DAT_CAD, CLI.C_FO1_CLI, ' +
                              ' VEN.C_NOM_VEN '+
                              ' FROM CADCLIENTES CLI, CADVENDEDORES VEN ' +
                              ' Where '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN')+
                              ' AND CLI.C_IND_PRC = ''S'''+
                              SQLTextoDataEntreAAAAMMDD('CLI.D_DAT_CAD',VpaDatInicio,VpaDatFim,true));
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_VEN = '+IntToStr(VpaCodVendedor));
  if VpaCodRamoAtividade <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_RAM = '+IntToStr(VpaCodRamoAtividade));
    Rave.SetParam('RAMOATIVIDADE',VpaNomRamoAtividade);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaCodMeioDivulgacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_PRC_MDV = '+IntToStr(VpaCodMeioDivulgacao));
    Rave.SetParam('MEIODIVULGACAO',VpaNomMeioDivulgacao);
  end;


  AdicionaSqlTabeLa(Principal,' ORDER BY VEN.C_NOM_VEN, CLI.C_NOM_CLI ');
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeAgenda(VpaCodUsuario,VpaSituacao: Integer; VpaCaminho, VpaNomUsuario,VpaDesSituacao: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Agenda Usuario';
  Rave.projectfile := varia.PathRelatorios+'\Agenda\0100CRPLFAFICH_AGENDA USUARIO.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT AGE.CODUSUARIO, AGE.CODCLIENTE, AGE.DATCADASTRO, AGE.DATINICIO DATA, AGE.DATINICIO, AGE.DATFIM, AGE.INDREALIZADO, '+
                              ' AGE.DESOBSERVACAO, '+
                              ' CLI.C_NOM_CLI, '+
                              ' USU.C_NOM_USU, '+
                              ' TIP.NOMTIPOAGENDAMENTO, '+
                              ' USA.C_NOM_USU USUARIOAGENDOU '+
                              ' '+
                              ' FROM AGENDA AGE, CADCLIENTES CLI, CADUSUARIOS USU, TIPOAGENDAMENTO TIP, CADUSUARIOS USA '+
                              ' Where AGE.CODUSUARIO = USU.I_COD_USU '+
                              ' AND AGE.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND AGE.CODTIPOAGENDAMENTO = TIP.CODTIPOAGENDAMENTO '+
                              ' AND AGE.CODUSUARIOAGENDOU = USA.I_COD_USU '+
                              SQLTextoDataEntreAAAAMMDD('AGE.DATINICIO',VpaDatInicio,INCDIA(VpaDatFim,1),true));
  if VpaCodUsuario <> 0 then
    AdicionaSqlTabeLa(Principal,'AND AGE.CODUSUARIO = '+IntToStr(VpaCodUsuario));
  case VpaSituacao of
    1 : AdicionaSqlTabeLa(Principal,'AND AGE.INDREALIZADO = ''S'' AND INDCANCELADO = ''N''');
    2 : AdicionaSqlTabeLa(Principal,'AND AGE.INDREALIZADO = ''N'' AND INDCANCELADO = ''N''');
    3 : AdicionaSqlTabeLa(Principal,'AND INDCANCELADO = ''S''');
  end;
  Rave.SetParam('SITUACAOAGENDA',VpaDesSituacao);

  AdicionaSqlTabeLa(Principal,'ORDER BY USU.C_NOM_USU, AGE.DATINICIO ');
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeVencimentoContratos(VpaDatInicio, VpaDatFim: TDatetime; VpaCaminho: String;VpaCodVendedor : Integer; VpaNomVendedor : String;VpaSomenteNaoCancelados, VpaFiltrarPeriodo : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Vencimento Contratos';
  Rave.projectfile := varia.PathRelatorios+'\Contrato\0300CHPL_Vencimento dos Contratos.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' CON.CODFILIAL, CON.SEQCONTRATO, CON.NUMCONTRATO, CON.DATASSINATURA, CON.QTDMESES, '+
                              ' CON.DATINICIOVIGENCIA, CON.DATFIMVIGENCIA, '+
                              ' CON.DATCANCELAMENTO, '+
                              ' TIP.NOMTIPOCONTRATO '+
                              ' FROM CADCLIENTES CLI, CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                              ' Where CON.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                              ' AND CON.DATCANCELAMENTO IS NULL ');
  if VpaFiltrarPeriodo then
    AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('DATFIMVIGENCIA',VpaDatInicio,VpaDatFim,true));

  if VpaSomenteNaoCancelados then
    AdicionaSQLTabela(Principal,'AND CON.DATCANCELAMENTO IS NULL');

  if VpaCodVendedor <> 0then
    AdicionaSQLTabela(Principal,'AND CLI.I_COD_VEN = '+IntToStr(VpaCodVendedor));

  AdicionaSQLTabela(Principal,'order by DATFIMVIGENCIA ' );

  Principal.Open;
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('Vendedor',IntToStr(VpaCodVendedor)+'-'+VpaNomVendedor);
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeDuplicata(VpaCodFilial, VpaLanReceber, VpaNumParcela: integer; vpaVisualizar: Boolean);
Var
  VpfValExtenso : String;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Duplicata';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\xx_Duplicata.rav';
  if vpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_EST_CLI, CLI.C_CID_CLI, '+
                              ' CLI.C_REG_CLI, CLI.C_CPF_CLI, CLI.C_CGC_CLI, CLI.C_INS_CLI, CLI.C_TIP_PES, CLI.I_NUM_END, CLI.C_PRA_CLI, '+
                              ' CLI.C_END_COB, CLI.I_NUM_COB, CLI.C_BAI_COB, CLI.C_CEP_COB, CLI.C_CID_COB, CLI.C_EST_COB, '+
                              ' CAD.D_DAT_EMI, CAD.I_NRO_NOT, CAD.I_QTD_PAR, CAD.N_VLR_TOT, '+
                              ' MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR, MOV.D_DAT_VEN, MOV.N_VLR_PAR, '+
                              ' MOV.C_NRO_DUP '+
                              ' FROM CADCLIENTES CLI, CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                              ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                              ' AND MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND MOV.I_LAN_REC =  '+IntToStr(VpaLanReceber)+
                              ' AND MOV.I_NRO_PAR = '+IntToStr(VpaNumParcela));
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  Rave.SetParam('VALEXTENSO',Extenso(Principal.FieldByName('N_VLR_PAR').AsFloat,'reais','real'));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeDuplicataManual(VpaCodFilial: Integer; VpaDDuplicata: TDadosDuplicata);
Var
  VpfValExtenso : String;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Duplicata';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\xx_DuplicataManual.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  FunRave.EnviaParametrosDuplicata(Rave,VpaDDuplicata);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeColetaOP(VpaCodFilial, VpaSeqOrdem, VpaSeqColeta: Integer; VpaVisualizar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Coleta OP';
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_ColetaOP.rav';
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select OP.SEQORD, OP.CODPRO, OP.ORDCLI, OP.NUMPED,  OP.CODMAQ, OP.UNMPED, '+
                              ' OP.DATENP, OP.TIPPED, '+
                              ' PRO.CODEME, PRO.INDCAL, PRO.INDENG, PRO.I_LRG_PRO, PRO.I_CMP_PRO, '+
                              ' COP.INDFIN, COP.INDREP, COP.QTDTOT, '+
                              ' CIT.METCOL, CIT.NROFIT, CIT.CODCOM, CIT.CODMAN '+
                              ' from  COLETAOPCORPO COP, ORDEMPRODUCAOCORPO OP, CADPRODUTOS PRO,  COLETAOPITEM CIT '+
                              ' WHERE COP.EMPFIL = OP.EMPFIL '+
                              ' AND COP.SEQORD = OP.SEQORD '+
                              ' AND COP.EMPFIL = CIT.EMPFIL '+
                              ' AND COP.SEQORD = CIT.SEQORD '+
                              ' AND COP.SEQCOL = CIT.SEQCOL '+
                              ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                              ' AND COP.EMPFIL =  '+ IntToStr(VpaCodFilial)+
                              ' AND COP.SEQORD =  '+ IntTostr(VpaSeqOrdem)+
                              ' AND COP.SEQCOL = '+IntToStr(VpaSeqColeta));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeObservacoesChamado(VpaCodFilial,VpaNumChamado: Integer; VpaVisualizar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Chamado Técnico '+IntToStr(VpaNumChamado);
  Rave.projectfile := varia.PathRelatorios+'\Chamado\XX_Observacoes Chamado.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.NOMCONTATO, CHA.NOMSOLICITANTE, CHA.DESENDERECOATENDIMENTO, '+
                                  ' CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.VALCHAMADO,CHA.VALDESLOCAMENTO,'+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' USU.C_NOM_USU, CLI.C_OBS_CLI, '+
                                  ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                                  'FROM CHAMADOCORPO CHA, CADCLIENTES CLI, CADUSUARIOS USU, TECNICO TEC '+
                                  ' Where CHA.CODFILIAL =  '+IntToStr(VpaCodFilial)+
                                  ' AND CHA.NUMCHAMADO = '+IntToStr(VpaNumChamado)+
                                  ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND CHA.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND CHA.CODTECNICO = TEC.CODTECNICO');
  AdicionaSqlAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                             ' CHP.NUMSERIE, CHP.NUMCONTADOR, CHP.NUMSERIEINTERNO,CHP.DESSETOR, CHP.DESPROBLEMA, '+
                             ' CHP.DESSERVICOEXECUTADO, CHP.DATGARANTIA, '+
                             ' TIP.NOMTIPOCONTRATO '+
                             ' from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                             ' Where CHP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND CHP.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                             ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND '+SQLTEXTORightJoin('CHP.CODFILIALCONTRATO','CON.CODFILIAL')+
                             ' AND '+SQLTEXTORightJoin('CHP.SEQCONTRATO','CON.SEQCONTRATO')+
                             ' AND '+SQLTEXTORightJoin('CON.CODTIPOCONTRATO','TIP.CODTIPOCONTRATO'));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeOPAgrupada(VpaCodFilial, VpaSeqOrdem: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ordem Produção '+IntToStr(VpaSeqOrdem);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_OPAgrupada.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.Close;
  Principal.SQL.clear;
  AdicionaSqlTabela(Principal,'select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, FRA.QTDPRODUTO, FRA.DESOBSERVACAO, '+
                              ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                              ' OP.DATEMI, '+
                              ' TAM.CODTAMANHO, TAM.NOMTAMANHO '+
                              ' from  ORDEMPRODUCAOCORPO OP, FRACAOOP FRA, CADPRODUTOS PRO, TAMANHO TAM '+
                              ' Where OP.EMPFIL = FRA.CODFILIAL '+
                              ' and OP.SEQORD = FRA.SEQORDEM '+
                              ' and FRA.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' and '+SQLTextoRightJoin('FRA.CODTAMANHO','TAM.CODTAMANHO')+
                              ' AND OP.EMPFIL = '+Inttostr(VpaCodFilial)+
                              ' and OP.SEQORD = '+IntToStr(VpaSeqOrdem));
  AdicionaSqlTabela(Principal,' ORDER BY PRO.C_COD_PRO');
// 19/11/2010 -Ana solicitou que ordenasse pelo codigo do produto
//   AdicionaSqlTabela(Principal,' ORDER BY FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO');
  Principal.open;
  AdicionaSQLAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.I_SEQ_PRO, '+
                             ' COR.COD_COR, COR.NOM_COR, '+
                             ' FRC.CODFILIAL, FRC.SEQORDEM, FRC.SEQFRACAO, FRC.CORREFERENCIA '+
                             ' from CADPRODUTOS PRO, COR, FRACAOOPCOMPOSE FRC '+
                             ' Where FRC.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND FRC.CODCOR = COR.COD_COR ' +
                             ' AND FRC.CODFILIAL = '+Inttostr(VpaCodFilial)+
                             ' and FRC.SEQORDEM = '+IntToStr(VpaSeqOrdem) +
                             ' order by FRC.CODFILIAL, FRC.SEQORDEM, FRC.SEQFRACAO, FRC.CORREFERENCIA');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeOPCadarcoTrancado(VpaCodFilial, VpaSeqOrdem: Integer;VpaVisualizar: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - OP Cadarço Trançado';
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_OPCadarcoTrancado.rav';
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlAbreTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, ' +
                                  ' OP.EMPFIL, OP.TIPPED, OP.DATEMI, OP.DATENP, OP.SEQORD, OP.DESOBS,' +
                                  ' ITE.QTDMET, ITE.INDALG, ITE.INDPOL, ITE.GROPRO, ITE.CODCOR, ITE.DESENG, '+
                                  ' ITE.QTDFUS, ITE.NROFIO, ITE.TITFIO, ITE.DESENC, ITE.NUMTAB, ITE.NROMAQ, '+
                                  ' ITE.DESTAB, '+
                                  ' PRO.C_NOM_PRO, '+
                                  ' COR.NOM_COR, '+
                                  ' USU.I_COD_USU, USU.C_NOM_USU '+
                                  ' from ORDEMPRODUCAOCORPO OP, OPITEMCADARCO ITE, CADCLIENTES CLI, CADPRODUTOS PRO, CADUSUARIOS USU, COR '+
                                  ' WHERE OP.EMPFIL = ITE.EMPFIL '+
                                  ' AND OP.SEQORD = ITE.SEQORD '+
                                  ' AND OP.CODCLI = CLI.I_COD_CLI '+
                                  ' AND ITE.SEQPRO = PRO.I_SEQ_PRO '+
                                  ' AND OP.CODUSU = USU.I_COD_USU '+
                                  ' AND '+SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                                  ' and OP.EMPFIL = '+ IntToStr(VpaCodFilial)+
                                  ' AND OP.SEQORD = '+ IntToStr(VpaSeqOrdem)+
                                  ' ORDER BY SEQITE');
  case Principal.FieldByName('TIPPED').AsInteger of
    0 : Rave.SetParam('TIPOESPULA','ESPULA GRANDE');
    1 : Rave.SetParam('TIPOESPULA','ESPULA PEQUENA');
    2 : Rave.SetParam('TIPOESPULA','ESPULA TRANSILIN');
  end;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeAmostrasEntregueseNaoAprovadas(VpaDatInicio, VpaDatFim: TDateTime; VpaCodCliente: integer; VpaCaminhoRelatorio,  VpaNomCliente: string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Amostras Entregues e Nao Aprovadas';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\1700CR_Amostras Entregues e Nao Aprovadas.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, '+
                              ' AMO.DATAPROVACAO, AMO.QTDAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGA,  '+
                              ' AMO.VALCUSTO, AMO.VALVENDA, ' +
                              ' COL.CODCOLECAO, COL.NOMCOLECAO, DES.CODDESENVOLVEDOR, DES.NOMDESENVOLVEDOR, ' +
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN '+
                              ' from AMOSTRA AMO, CADCLIENTES CLI, CADVENDEDORES VEN, COLECAO COL, DESENVOLVEDOR DES '+
                              ' WHERE AMO.TIPAMOSTRA = ''D'''+
                                SQLTextoDataEntreAAAAMMDD('AMO.DATAMOSTRA',VpaDatInicio,INCDIA(VpaDatFim,1),true)+
                              ' AND AMO.DATENTREGA IS NOT NULL ' +
                              ' AND AMO.DATAPROVACAO IS NULL ' +
                              ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN ' +
                              ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR ' +
                              ' AND AMO.CODCOLECAO = COL.CODCOLECAO');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND AMO.CODCLIENTE = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY AMO.CODAMOSTRA');
  Principal.open;
  Rave.SetParam('PERIODO','Periodo de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
//  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeAmostrasPorVendedor(VpaCodCliente, VpaCodVendedor: Integer; VpaCaminhoRelatorio, VpaNomCliente,VpaNomVendedor: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Amostras por Vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\1150CR_Amostras por Vendedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select REC.DATAMOSTRA, REC.CODAMOSTRA CODREQUISICAO, '+
                              ' AMO.DATENTREGA,  AMO.DATAPROVACAO, AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.QTDAMOSTRA, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN '+
                              ' from AMOSTRA REC, AMOSTRA AMO, CADCLIENTES CLI, CADVENDEDORES VEN '+
                              ' WHERE AMO.CODAMOSTRAINDEFINIDA = REC.CODAMOSTRA '+
                              ' AND AMO.TIPAMOSTRA = ''D'''+
                                SQLTextoDataEntreAAAAMMDD('REC.DATAMOSTRA',VpaDatInicio,INCDIA(VpaDatFim,1),true)+
                              ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN ');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND AMO.CODCLIENTE = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND AMO.CODVENDEDOR = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY VEN.C_NOM_VEN, CLI.C_NOM_CLI');
  Principal.open;
  Rave.SetParam('PERIODO','Periodo de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Rave.Execute;

end;

{******************************************************************************}
procedure TdtRave.ImprimeAmostrasqueFaltamFinalizar;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Amostras que faltam finalizar';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\1300CR_Amostras Faltam Finalizar.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlAbreTabeLa(Principal,'SELECT  OD.CODAMOSTRA CODOD, OD.DATENTREGACLIENTE, OD.DATAMOSTRA , ' +
                                  ' AMO.CODAMOSTRA, AMO.NOMAMOSTRA, ' +
                                  ' CLI.C_NOM_CLI, ' +
                                  ' CLA.C_NOM_CLA, ' +
                                  ' COR.NOM_COR '+
                                  ' FROM AMOSTRA OD,  AMOSTRA AMO, CADCLIENTES CLI, CADCLASSIFICACAO CLA, COR, AMOSTRACOR AMC ' +
                                  ' WHERE OD.CODAMOSTRA = AMO.CODAMOSTRAINDEFINIDA ' +
                                  ' AND AMO.CODCLIENTE = CLI.I_COD_CLI ' +
                                  ' AND AMO.CODCLASSIFICACAO = CLA.C_COD_CLA ' +
                                  ' AND AMC.DATFICHACOR IS NULL '+
                                  ' AND AMC.CODAMOSTRA = AMO.CODAMOSTRA  ' +
                                  ' AND AMC.CODCOR = COR.COD_COR' +
                                  ' ORDER BY OD.DATENTREGACLIENTE, AMO.CODAMOSTRA');
//  salvaSql;
//  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;


{******************************************************************************}
procedure TdtRave.ImprimeQtdAmostrasPorDesenvolvedor(VpaCodDesenvolvedor: Integer; VpaCaminho, VpaNomDesenvolvedor: string;VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Amostras por Desenvolvedor';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\1100CR_Amostras por Desenvolvedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select EXTRACT(DAY FROM DATAMOSTRA) DIA, EXTRACT(DAY FROM DATAMOSTRA) ||''/''|| EXTRACT(MONTH FROM DATAMOSTRA) DATAMOSTRA, DES.NOMDESENVOLVEDOR, COUNT(AMO.CODAMOSTRA) QTD '+
                              ' from AMOSTRA AMO, DESENVOLVEDOR DES '+
                              ' WHERE AMO.TIPAMOSTRA = ''D'''+
                              ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR '+
                              SQLTextoDataEntreAAAAMMDD('AMO.DATAMOSTRA',VpaDatInicio,incDia(VpaDatFim,1),true));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if VpaCodDesenvolvedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND AMO.CODDESENVOLVEDOR = '+InttoStr(VpaCodDesenvolvedor));
    Rave.SetParam('DESENVOLVEDOR',VpaNomDesenvolvedor);
  end;

  Rave.SetParam('CAMINHO',VpaCaminho);

  AdicionaSqlTabeLa(Principal,' GROUP BY EXTRACT(DAY FROM DATAMOSTRA) , EXTRACT(DAY FROM DATAMOSTRA) ||''/''|| EXTRACT(MONTH FROM DATAMOSTRA), DES.NOMDESENVOLVEDOR '+
                              ' ORDER BY 1');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorSituacaoAnalitico(VpaCodVendedor: Integer; VpaCaminho, VpaCidade, VpaNomVendedor: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Situação Analítico';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0300PLFAFI_Clientes Por Situacao Analitico.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT CLI.C_NOM_CLI, CLI.C_BAI_CLI, CLI.C_CID_CLI, CLI.C_END_CLI, '+
                              ' CLI.C_FON_COM, CLI.I_COD_SIT, SIT.C_NOM_SIT '+
                              ' FROM CADCLIENTES CLI ,   CADSITUACOESCLIENTES SIT '+
                              ' WHERE CLI.I_COD_SIT = SIT.I_COD_SIT ');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_VEN = '+IntToStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade + '''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  AdicionaSqlTabeLa(Principal,'ORDER BY CLI.I_COD_SIT, CLI.C_NOM_CLI ');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorSituacaoSintetico(VpaCodVendedor: Integer; VpaCaminho, VpaCidade, VpaNomVendedor: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Situação Sintético';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0400PLFAFI_Clientes Por Situacao Sintetico.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT COUNT(CLI.I_COD_CLI) QTD, CLI.I_COD_SIT, SIT.C_NOM_SIT ' +
                              '  FROM CADCLIENTES CLI , CADSITUACOESCLIENTES SIT             ' +
                              ' WHERE CLI.I_COD_SIT = SIT.I_COD_SIT                          ');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CLI.I_COD_VEN = '+IntToStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade + '''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  AdicionaSqlTabeLa(Principal,' GROUP BY CLI.I_COD_SIT, SIT.C_NOM_SIT                       ' +
                              ' ORDER BY SIT.C_NOM_SIT                                      ');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeContatoCliente(VpaCodVendedor, VpaCodSituacao: Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVendedor, VpaSituacao: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Contato Cliente';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0500PLFAFI_Contato Cliente.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_FO1_CLI, CLI.C_BAI_CLI,   ' +
                              '       CLI.C_CID_CLI, CLI.C_END_CLI, CON.NOMCONTATO, CON.DESTELEFONE,' +
                              '       CON.DESEMAIL,                                                 ' +
                              '       (SELECT Min(PRF.C_NOM_PRF) FROM CADPROFISSOES PRF WHERE  PRF.I_COD_PRF = CON.CODPROFISSAO) C_NOM_PRF ' +
                              '  FROM CADCLIENTES CLI, CONTATOCLIENTE CON                           ' +
                              ' WHERE CLI.I_COD_CLI (+)= CON.CODCLIENTE                             ');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CLI.I_COD_VEN = '+IntToStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade + '''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if DeletaEspaco(VpaEstado) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaEstado + '''');
    Rave.SetParam('ESTADO',VpaEstado);
  end;
  if VpaCodSituacao <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CLI.I_COD_SIT = '+IntToStr(VpaCodSituacao));
    Rave.SetParam('SITUACAO',VpaSituacao);
  end;

  AdicionaSqlTabeLa(Principal,' ORDER BY CLI.C_NOM_CLI,CLI.I_COD_CLI, CLI.C_FO1_CLI, CLI.C_BAI_CLI, ' +
                              '      CLI.C_CID_CLI, CLI.C_END_CLI, CON.NOMCONTATO, CON.DESTELEFONE, ' +
                              '      CON.DESEMAIL                                                   ');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

procedure TdtRave.ImprimeContratosClientes(VpaCodFilial,VpaCodCliente,VpaCodTipoContrato: Integer; VpaCaminho, VpaNomFilial,VpaNomCidade, VpaNomCliente, VpaNomTipoContrato: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Situação Analítico';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0800PLFAFI_Contratos Clientes.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT CLI.C_NOM_CLI, TIP.NOMTIPOCONTRATO, CON.VALCONTRATO ' +
                              '   FROM CONTRATOCORPO CON,TIPOCONTRATO TIP,CADCLIENTES CLI  ' +
                              '  WHERE CLI.I_COD_CLI = CON.CODCLIENTE                      ' +
                              '    AND CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO           ' +
                              '    AND CON.DATCANCELAMENTO IS NULL                         ');
  if VpaCodFilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CON.CODFILIAL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if (VpaCodCliente <> 0) then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_CLI = '+IntToStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if DeletaEspaco(VpaNomCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaNomCidade + '''');
    Rave.SetParam('CIDADE',VpaNomCidade);
  end;
  if VpaCodTipoContrato <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODTIPOCONTRATO = '+Inttostr(VpacodTipoContrato));
    Rave.SetParam('TIPOCONTRATO',VpaNomTipoContrato);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY CLI.C_NOM_CLI ');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeControleDespachoNota(VpaDNota: TRBDNotaFiscal;VpaDCliente,VpaDTransportadora :  TRBDCliente);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Controle Despacho';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\xx_ControleDespacho.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  Sistema.CarDFilial(VprDFilial,VpaDNota.CodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  Rave.SetParam('CLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('CIDADE',VpaDCliente.DesCidade);
  Rave.SetParam('UF',VpaDCliente.DesUF);
  Rave.SetParam('NOTA',IntToStr(VpaDNota.NumNota));
  Rave.SetParam('EMISSAO',FormatDateTime('DD/MM/YYYY',VpaDNota.DatEmissao));
  Rave.SetParam('VOLUMES',IntToStr(VpaDNota.QtdEmbalagem));
  Rave.SetParam('PESO',FormatFloat('#,###,##0.00',VpaDNota.PesBruto));
  Rave.SetParam('TRANSPORTADORA',VpaDTransportadora.NomCliente);
  Rave.SetParam('COTACAOTRANSPORTADORA',VpaDNota.NumCotacaoTransportadora);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeControleFrete(VpaCodTransportadora, VpaCodCliente,
  VpaCodFilial: integer; VpaDatIni, VpaDatFim: TDateTime;VpaNomTransportadora, VpaNomCliente,VpaNomFilial ,VpaCaminho : string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Controle Frete';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\3000PLFA_Controle Frete.rav'; //Verificar
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select  NOTA.I_EMP_FIL, NOTA.D_DAT_EMI,NOTA.I_NRO_NOT,  CLI.C_NOM_CLI, '+
                              ' TRA.C_NOM_CLI C_NOM_TRA, '+
                              ' NOTA.N_TOT_NOT ' +
                              ' from cadnotafiscais nota, cadclientes cli, CADCLIENTES tra ' +
                              ' where ' + SQLTextoDataEntreAAAAMMDD('NOTA.D_DAT_EMI', VpaDatIni, VpaDatFim,false) +
                              ' AND NOTA.I_COD_CLI = CLI.I_COD_CLI ' +
                              ' AND NOTA.I_COD_TRA = TRA.I_COD_CLI ');
  if VpaCodFilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND NOTA.I_EMP_FIL = '+ IntToStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND NOTA.I_COD_TRA = '+IntToStr(VpaCodTransportadora));
    Rave.SetParam('TRANSPORTADORA',VpaNomTransportadora);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND NOTA.C_COD_CLI = '+ IntToStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;

  rave.SetParam('PERIODO', DateToStr(VpaDatIni) + ' ate ' + DateToStr(VpaDatFim));

  AdicionaSQLTabela(Principal,'ORDER BY NOTA.I_NRO_NOT ');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesCadastrados(VpaCodVendedor, VpaCodRamoAtividade: Integer; VpaCaminho, VpaNomVendedor,
  VpaNomRamoAtividade, VpaCidade: String; VpaIndFiltrarPeriodo, VpaIndCliente, VpaIndProspect, VpaIndFornecedor, VpaIndHotel: Boolean;VpaDatInicio, VpaDatFim : TDateTime);
var
  VpfLinha : string;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Prospect por CEP';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\1000PLFAFIESCR_Clientes Cadastrados.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'Select CLI.I_COD_CLI, CLI.C_NOM_CLI, C_END_CLI, CLI.C_COM_END, CLI.C_BAI_CLI, ' +
                              ' CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_IND_VIS, CLI.D_DAT_CAD, CLI.C_FO1_CLI ' +
                              ' FROM CADCLIENTES CLI ' +
                              ' Where 1 = 1 ');
  if VpaIndFiltrarPeriodo then
    AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CLI.D_DAT_CAD',VpaDatInicio,VpaDatFim,true));
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_VEN = '+IntToStr(VpaCodVendedor));
  if VpaCodRamoAtividade <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_RAM = '+IntToStr(VpaCodRamoAtividade));
    Rave.SetParam('RAMOATIVIDADE',VpaNomRamoAtividade);
  end;
  if VpaCidade <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaIndCliente or VpaIndProspect or VpaIndFornecedor or VpaIndHotel then
  begin
    AdicionaSqlTabeLa(Principal,'and ( ');
    VpfLinha := '';
    if VpaIndCliente then
      VpfLinha := 'or C_IND_CLI = ''S''';
    if VpaIndProspect then
      VpfLinha := VpfLinha + 'or C_IND_PRC = ''S''';
    if VpaIndFornecedor then
      VpfLinha := VpfLinha + 'or C_IND_FOR = ''S''';
    if VpaIndHotel then
      VpfLinha := VpfLinha + 'or C_IND_HOT = ''S''';
    VpfLinha := copy(VpfLinha,3,length(VpfLinha))+')';

    AdicionaSqlTabeLa(Principal,VpfLinha);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY CLI.C_NOM_CLI ');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesCompletos(VpaCodVendedor, VpaSitCli, VpaCodRamoAtividade: Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVend, VpaNomCliente, VpaDescSit, VpaNomRamoAtividade : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes Completos';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0900PLFAFIES_Clientes Completos.rav'; //Verificar
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT I_COD_CLI, C_NOM_CLI, C_NOM_FAN, C_END_CLI,  ' +
                              ' C_BAI_CLI, C_CID_CLI, C_CEP_CLI, C_EST_CLI, ' +
                              ' C_CGC_CLI, C_INS_CLI, C_CPF_CLI, C_REG_CLI, C_NOM_CON,  ' +
                              ' C_END_ELE, C_FO1_CLI, C_FO2_CLI, C_FO3_CLI, C_FON_FAX, C_TIP_PES ' +
                              ' FROM CADCLIENTES WHERE I_COD_CLI = I_COD_CLI');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND I_COD_VEN = '+IntToStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVend);
  end
  else
    Rave.SetParam('VENDEDOR','Todos');
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND C_CID_CLI = '''+ VpaCidade + '''');
    Rave.SetParam('CIDADE',VpaCidade);
  end
  else
    Rave.SetParam('CIDADE','Todas');
  if VpaCodRamoAtividade <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND I_COD_RAM = '+ IntToStr(VpaCodRamoAtividade));
    Rave.SetParam('RAMOATIVIDADE',VpaNomRamoAtividade);
  end;
  if DeletaEspaco(VpaEstado) <> '' then
  begin
    if VpaEstado = 'SANTA CATARINA' then
    begin
      VpaEstado := 'SC';
    end;
    AdicionaSqlTabeLa(Principal,'AND C_EST_CLI = '''+ VpaEstado + '''');
    Rave.SetParam('UF',VpaEstado);
  end
  else
    Rave.SetParam('UF','Todos');
  if VpaSitCli <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND I_COD_SIT = '''+ IntToStr(VpaSitCli) + '''');
    Rave.SetParam('SIT',VpaDescSit);
  end
  else
    Rave.SetParam('SIT','Todas');
  if DeletaEspaco(VpaNomCliente) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND C_NOM_CLI = '''+ VpaNomCliente + '''');
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end
  else
  Rave.SetParam('CLIENTE','Todos');

  AdicionaSqlTabeLa(Principal,'ORDER BY I_COD_SIT, C_NOM_CLI ');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;


{******************************************************************************}
procedure TdtRave.ImprimeClientesPerdidosClientes(VpaSeqPerdido: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes perdidos por vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\xx_ClientesPerdidosClientes.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                              ' from CLIENTEPERDIDOVENDEDORCLIENTE CPC, CADCLIENTES CLI, CADVENDEDORES VEN '+
                              ' WHERE CLI.I_COD_CLI = CPC.CODCLIENTE '+
                              ' AND CPC.CODVENDEDOR = VEN.I_COD_VEN '+
                              ' and CPC.SEQPERDIDO = '+IntToStr(VpaSeqPerdido)+
                              ' ORDER BY VEN.C_NOM_VEN, CLI.C_NOM_CLI');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPerdidosPorVendedor(VpaSeqPerdido: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes perdidos por vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\xx_ClientesPerdidosPorVendedor.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select PVI.CODVENDEDOR, PVI.QTDCLIENTE, PVI.QTDCLIENTEPERDIDO, '+
                              ' VEN.C_NOM_VEN '+
                              ' from CLIENTEPERDIDOVENDEDORITEM PVI, CADVENDEDORES VEN '+
                              ' WHERE PVI.SEQPERDIDO = '+IntToStr(VpaSeqPerdido)+
                              ' AND ' +SQLTextoRightJoin('PVI.CODVENDEDOR','VEN.I_COD_VEN')+
                              ' ORDER BY VEN.C_NOM_VEN ');

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorCidadeEEstadoAnalitico(VpaCodVendedor, VpaCodSituacao, VpaCodRamoAtividade : Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVendedor, VpaNomRamoAtividade, VpaSituacao: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Cidade e Estado Analitico';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0600PLFAFI_Clientes por Cidade e Estado Analitico.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_FO1_CLI, ' +
                              '        CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.I_COD_VEN, ' +
                              '        VEN.C_NOM_VEN, CLI.C_EST_CLI                                ' +
                              '   FROM CADCLIENTES CLI, CADVENDEDORES VEN                          ' +
                              '  WHERE CLI.I_COD_VEN = VEN.I_COD_VEN                               '+
                              '  AND CLI.C_IND_CLI = ''S''');

  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CLI.I_COD_VEN = '+IntToStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade + '''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaCodRamoAtividade <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_RAM = '+IntToStr(VpaCodRamoAtividade));
    Rave.SetParam('RAMOATIVIDADE',VpaCidade);
  end;

  if DeletaEspaco(VpaEstado) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaEstado + '''');
    Rave.SetParam('ESTADO',VpaEstado);
  end;
  if VpaCodSituacao <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND CLI.I_COD_SIT = '+IntToStr(VpaCodSituacao));
    Rave.SetParam('SITUACAO',VpaSituacao);
  end;

  AdicionaSQLTabela(Principal,'  ORDER BY CLI.C_EST_CLI, CLI.C_CID_CLI, CLI.C_NOM_CLI,CLI.I_COD_CLI' +
                              '  ,CLI.C_FO1_CLI,CLI.C_END_CLI,CLI.I_NUM_END,CLI.C_BAI_CLI,         ' +
                              '   VEN.C_NOM_VEN,CLI.I_COD_VEN                                      ');

  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorCidadeEEstadoSintetico(VpaCodVendedor, VpaCodSituacao: Integer; VpaCaminho, VpaCidade, VpaEstado, VpaNomVendedor,VpaSituacao: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Cidade e Estado Sintético';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0700PLFAFI_Clientes por Cidade e Estado Sintetico.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT C_EST_CLI, C_CID_CLI, COUNT(*) QTD      ' +
                              '   FROM CADCLIENTES                             ' +
                              '  Where C_IND_CLI = ''S''');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND I_COD_VEN = '+IntToStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND C_CID_CLI = '''+ VpaCidade + '''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if DeletaEspaco(VpaEstado) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND C_EST_CLI = '''+ VpaEstado + '''');
    Rave.SetParam('ESTADO',VpaEstado);
  end;
  if VpaCodSituacao <> 0 then
  begin
    AdicionaSqlTabela(Principal,'AND I_COD_SIT = '+IntToStr(VpaCodSituacao));
    Rave.SetParam('SITUACAO',VpaSituacao);
  end;
  AdicionaSqlTabeLa(Principal,'  GROUP BY C_EST_CLI, C_CID_CLI                 ' +
                              '  ORDER BY C_EST_CLI, C_CID_CLI                 ' );
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorMeioDivulgacao(VpaCodVendedor: Integer; VpaCaminho, VpaNomVendedor, VpaCidade, VpaUF: string;VpaIndCliente, VpaIndProspect, VpaIndPeriodo: Boolean;VpaDatInicio,VpaDatFim : TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Meio de Divulgação';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0950PLFAESCR_Clientes por Meio Divulgacao Sintetico.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select  COUNT(*) QTD,  MEI.DESMEIODIVULGACAO ' +
                              ' from CADCLIENTES CLI, MEIODIVULGACAO MEI '+
                              ' Where '+ SQLTextoRightJoin('CLI.I_PRC_MDV','MEI.CODMEIODIVULGACAO')+
                              SQLFiltroCliente('CLI',VpaIndCliente,VpaIndProspect));
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CLI.I_COD_VEN = '+Inttostr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaIndPeriodo then
  begin
    AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CLI.D_DAT_CAD',VpaDatInicio,VpaDatFim,true));
    Rave.SetParam('PERIODO','Periodo de : ' +FormatDateTime('DD/MM/YY',VpaDatInicio)+' ate ' +FormatDateTime('DD/MM/YY',VpaDatFim));
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSQlTabela(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSQlTabela(Principal,'AND CLI.C_EST_CLI = '''+ VpaUF+'''');
    Rave.SetParam('UF',VpaUF);
  end;

  AdicionaSqlTabeLa(Principal,' GROUP BY MEI.DESMEIODIVULGACAO ');

  Principal.open;
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorRegiaoSintetico(VpaCodSituacao: Integer; VpaCaminhoRelatorio,  VpaNomSituacao: string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Regiao Sintetico';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\1000PLFAFIES_Clientes por Regiao Sintetico.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' Select  REG.C_NOM_REG, COUNT(I_COD_CLI) QTD ' +
                              ' from CADCLIENTES CLI, CADREGIAOVENDA REG '+
                              ' WHERE CLI.I_COD_REG = REG.I_COD_REG ');
  if VpaCodSituacao <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CLI.I_COD_SIT = '+Inttostr(VpaCodSituacao));
    Rave.SetParam('NOMSITUACAO',VpaNomSituacao);
  end;
  AdicionaSqlTabeLa(Principal,' GROUP BY REG.C_NOM_REG ');
  Principal.open;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeCartuchoPesadoPorCelula(VpaCodFilial: Integer; VpaDataIni, VpaDatFim: TDateTime; VpaNomFilial,VpaCaminhoRelatorio: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Cartucho Pesado por Célula';
  Rave.projectfile := varia.PathRelatorios+'\Cartucho\0100PLFAFI_Cartucho Pesado por Celula.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,' SELECT EXTRACT(DAY FROM DATPESO) DIA, EXTRACT(DAY FROM DATPESO)||''/'' ' +
                              '        || EXTRACT(MONTH FROM DATPESO) DATAPESO, CEL.NOMCELULA,         ' +
                              '        COUNT(CEL.NOMCELULA) QTD                                        ' +
                              ' FROM PESOCARTUCHO PES, CELULATRABALHO CEL                              ' +
                              '  WHERE PES.CODCELULA = CEL.CODCELULA                                   ' +
                        SQLTextoDataEntreAAAAMMDD('PES.DATPESO',VpaDataIni,VpaDatFim,true));
  Rave.SetParam('DATPESO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDataIni)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,' AND PES.CODFILIAL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,' GROUP BY EXTRACT(DAY FROM DATPESO), EXTRACT(DAY FROM DATPESO)||''/''|| ' +
                              '          EXTRACT(MONTH FROM DATPESO), CEL.NOMCELULA                    ' +
                              ' ORDER BY 1                                                             ');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaAmostra(VpaVisualizar: boolean);
begin
  Rave.close;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Etiqueta Amostra';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\xx_EtiquetaAmostra.rav';
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,'SELECT * FROM ETIQUETAPRODUTO ' +
                                  ' ORDER BY SEQETIQUETA ');
  Rave.SetParam('NOMFILIAL',Varia.NomeFilial);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaCaixa(VpaVisualizar: boolean);
begin
  Rave.close;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Etiqueta Caixa';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\xx_EtiquetaCaixa.rav';
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,'SELECT * FROM ETIQUETAPRODUTO ' +
                                  ' ORDER BY SEQETIQUETA ');
  Rave.SetParam('NOMFILIAL',Varia.NomeFilial);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaComposicao(VpaVisualizar: Boolean);
begin
  Rave.close;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Etiqueta Composicao';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\xx_Composicao.rav';
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,'SELECT * FROM ETIQUETAPRODUTO ' +
                                  ' ORDER BY SEQETIQUETA ');
  Rave.SetParam('NOMFILIAL',Varia.NomeFilial);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaMedia(VpaVisualizar : Boolean);
begin
  Rave.close;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Etiqueta Media';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\xx_EtiquetaMedia.rav';
  Rave.clearParams;
  AdicionaSqlAbreTabeLa(Principal,'SELECT * FROM ETIQUETAPRODUTO ' +
                                  ' ORDER BY SEQETIQUETA ');
  Rave.SetParam('NOMFILIAL',Varia.NomeFilial);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNumerosPendentes(VpaCodFilial: Integer; VpaCaminhoRelatorio, VpaNomFilial : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos por dia';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\4000PL_Numeros Pendentes.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_ORC, CAD.I_EMP_FIL, CAD.I_LAN_ORC, ' +
                        ' CAD.D_DAT_PRE,  CAD.D_DAT_ENT, CAD.I_COD_CLI , CAD.C_IND_CAN , '+
                        ' CLI.C_NOM_CLI, ' +
                        ' N_VLR_TOT, PAG.I_COD_PAG, PAG.C_NOM_PAG ' +
                        ' from cadorcamentos CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG '+
                        ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI '+
                        ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                        ' AND CAD.C_IND_CAN = ''N''' +
                        ' AND CAD.C_NUM_BAI = ''N''');
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY CAD.I_LAN_ORC,CAD.D_DAT_ORC');
  Principal.open;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Rave.Execute;
end;

{*******************************************************************************}
procedure TdtRave.ImprimeRequisicaoAmostrasqueFaltamFinalizar(VpaCodCliente, VpaCodVendedor: Integer; VpaCaminho,VpaNomCliente, VpaNomVendedor: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Amostras que faltam finalizar';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\1400CR_Requisicao Amostra Faltam Finalizar.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT  OD.CODAMOSTRA CODOD, OD.DATENTREGACLIENTE, OD.DATAMOSTRA , OD.QTDAMOSTRA, '+
                                  ' AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA DATFICHA, '+
                                  ' CLI.C_NOM_CLI, '+
                                  ' VEN.C_NOM_VEN '+
                                  ' FROM AMOSTRA OD,  AMOSTRA AMO, CADCLIENTES CLI, CADCLASSIFICACAO CLA, CADVENDEDORES VEN '+
                                  ' WHERE OD.CODAMOSTRA = AMO.CODAMOSTRAINDEFINIDA '+
                                  ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND AMO.CODCLASSIFICACAO = CLA.C_COD_CLA '+
                                  ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                                  ' AND AMO.DATENTREGA IS NULL ');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'and AMO.CODCLIENTE = '+IntToStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'and AMO.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;

  AdicionaSqlTabeLa(Principal,' ORDER BY VEN.C_NOM_VEN, CLI.C_NOM_CLI, OD.DATENTREGACLIENTE, AMO.CODAMOSTRA');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePagamentoFaccionista(VpaCodFaccionista: Integer; VpaCaminho, VpaNomFaccionista: string;VpaDatInicio, VpaDatFim: tDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pagamento Faccionista';
  Rave.projectfile := varia.PathRelatorios+'\Faccionista\0100FIES_Pagamento Faccionista.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select RFF.SEQRETORNO, RFF.DATCADASTRO DATREAL, RFF.QTDRETORNO,  RFF.VALUNITARIO, FRF.DATRETORNO, '+
                              ' RFF.DATREVISADO, RFF.CODUSUARIOREVISAO, RFF.QTDREVISADO, RFF.QTDDEFEITO, '+
                              ' FRF.DATCADASTRO, FRF.CODFILIAL, FRF.SEQORDEM,FRF.SEQFRACAO, FRF.SEQESTAGIO, FRF.QTDENVIADO, '+
                              ' FRF.DESUM, FRF.CODFACCIONISTA, FRF.SEQITEM, FRF.INDDEFEITO, '+
                              ' FAC.NOMFACCIONISTA, '+
                              ' PRO.C_NOM_PRO, PRO.C_COD_PRO, '+
                              ' COR.NOM_COR, '+
                              ' RFT.NOMTERCEIRO, RFT.QTDREVISADO QTDREVISADOTERCEIRO, RFT.QTDDEFEITO QTDDEFEITOTERCEIRO '+
                              ' from RETORNOFRACAOOPFACCIONISTA RFF, FRACAOOPFACCIONISTA FRF, FACCIONISTA FAC, ORDEMPRODUCAOCORPO ORD, RETORNOFRACAOOPFACTERCEIRO RFT, '+
                              ' CADPRODUTOS PRO, COR '+
                              ' Where RFF.CODFACCIONISTA = FRF.CODFACCIONISTA '+
                              ' AND RFF.SEQITEM = FRF.SEQITEM '+
                              ' AND FRF.CODFACCIONISTA = FAC.CODFACCIONISTA '+
                              ' AND FRF.CODFILIAL = ORD.EMPFIL '+
                              ' AND FRF.SEQORDEM = ORD.SEQORD '+
                              ' AND ORD.SEQPRO = PRO.I_SEQ_PRO '+
                              ' AND ORD.CODCOM = COR.COD_COR '+
                              ' AND '+SQLTextoRightJoin('RFF.CODFACCIONISTA','RFT.CODFACCIONISTA')+
                              ' AND '+SQLTextoRightJoin('RFF.SEQITEM','RFT.SEQITEM')+
                              ' AND '+SQLTextoRightJoin('FRF.SEQRETORNO','RFT.SEQRETORNO'));
  if VpaCodFaccionista <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND FAC.CODFACCIONISTA = '+InttoStr(VpaCodFaccionista));
    Rave.SetParam('NOMFACCIONISTA',VpaNomFaccionista);
  end;
  AdicionaSqlTabeLa(Principal,SQLTextoDataEntreAAAAMMDD('FRF.DATRETORNO',VpaDatInicio,incdia(VpaDatFim,1),true));
  Rave.SetParam('PERIODO','Periodo de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' ORDER BY FAC.NOMFACCIONISTA, RFT.NOMTERCEIRO, RFF.DATRETORNO');
  Principal.Open;
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEstoqueChapa(VpaSeqProduto: Integer; VpaCaminho, VpaCodProduto, VpaNomProduto: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Estoque Chapa';
  Rave.projectfile := varia.PathRelatorios+'\Produto\Estoque\5000ES_Estoque Chapa.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, ' +
                              ' CHA.SEQCHAPA, CHA.LARCHAPA, CHA.COMCHAPA, CHA.PERCHAPA, CHA.PESCHAPA ' +
                              ' FROM ESTOQUECHAPA CHA, CADPRODUTOS PRO ' +
                              '  WHERE CHA.SEQPRODUTO = PRO.I_SEQ_PRO ');
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND PRO.I_SEQ_PRO = '+InttoStr(VpaSeqProduto));
    Rave.SetParam('PRODUTO',VpaNomProduto);
  end;
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;


end.

