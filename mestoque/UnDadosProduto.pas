unit UnDadosProduto;

interface
Uses Classes, UnDados, Constantes;

Type
  TRBDTipoOperacaoEstoque = (toEntrada,toSaida);
  TRBDEtiquetaProdutoOP = class
    public
      SeqProduto,
      CodFilial,
      SeqOrdemProducao,
      QtdProdutos : Integer;
      CodProduto,
      NomProduto : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDEStoqueChapa = class
    public
      SeqChapa,
      Codfilial,
      CodCor,
      CodTamanho,
      SeqNotafornecedor : Integer;
      LarChapa,
      ComChapa,
      PerChapa,
      PesChapa : Double;
      constructor cria;
      destructor destroy;override;

end;

Type
  TRBDRepeticaoInstalacaoTear = class
    public
      SeqRepeticao,
      NumColunaInicial,
      NumColunaFinal,
      QtdRepeticao : Integer;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDFuncaoFioInstalacaoTear = (ffUrdume,ffAjuda,ffAmarracao);
  TRBDProdutoInstalacaoTear = class
    public
      NumLinha,
      NumColuna,
      SeqProduto,
      CodCor,
      QtdFiosLico : Integer;
      CodProduto,
      NomProduto,
      NomCor : String;
      FuncaoFio : TRBDFuncaoFioInstalacaoTear;
    constructor cria;
     destructor destroy;override;
  end;

Type
  TRBDFiguraGRF = class
    public
      CodFiguraGRF : Integer;
      NomFiguraGRF,
      DesImagem : String;
      constructor cria;
      destructor destroy;override;
  end;

type
  TRBDOrcamentoCompraFracaoOP = class
    public
      CodFilialFracao,
      SeqOrdem,
      SeqFracao: Integer;
      NomCliente: String;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDOrcamentoCompraProduto = class
    public
      CodFilial,
      SeqOrcamento,
      SeqItem,
      SeqProduto,
      CodCor: Integer;
      CodProduto,
      NomProduto,
      DesReferenciaFornecedor,
      DesTecnica,
      NomCor,
      DesArquivoProjeto,
      DesUM: String;
      IndComprado,
      IndMenorPreco,
      IndMarcado,
      IndArquivoProjetoLocalizado : Boolean;
      UnidadesParentes: TStringList;
      QtdProduto,
      QtdSolicitada,
      QtdComprado,
      QtdChapa,
      LarChapa,
      ComChapa,
      ValUnitario,
      ValTotal,
      PerIPI,
      PerICMS,
      EspessuraAco,
      DensidadeVolumetricaAco : Double;
      DatAprovacao : TDateTime;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDOrcamentoCompraFornecedor = class
    public
      CodFornecedor,
      CodCondicaoPagamento,
      CodFormaPagamento,
      CodTransportadora,
      TipFrete : Integer;
      NomFornecedor,
      NomContato,
      DesEmailFornecedor : string;
      DatPrevisao : TDatetime;
      ValFrete : Double;
      ProdutosAdicionados,
      ProdutosNaoAdicionados : TList;
      constructor cria;
      destructor destroy;override;
      function addProdutoAdicionado : TRBDOrcamentoCompraProduto;
      function addProdutoNaoAdicionado : TRBDOrcamentoCompraProduto;
end;

Type
  TRBDOrcamentoCompraCorpo = class
    public
      CodFilial,
      CodFilialFaturamento,
      SeqOrcamento,
      CodUsuario,
      NumDiasAtraso,
      CodCondicaoPagto,
      CodFormaPagto,
      CodTransportadora,
      CodEstagio,
      CodComprador,
      TipFrete: Integer;
      DesSituacao,
      DesObservacao: String;
      DatOrcamento,
      HorOrcamento,
      DatPrevista,
      DatFinalizacao: TDateTime;
      Produtos,
      FracaoOP,
      Fornecedores,
      SolicitacoesCompra : TList;
      constructor cria;
      destructor destroy;override;
      function addProduto : TRBDOrcamentoCompraProduto;
      function addFornecedor : TRBDOrcamentoCompraFornecedor;
      function addFracao : TRBDOrcamentoCompraFracaoOP;
end;

Type
  TRBDMovimentacaoEstoque = class
    public
      CodFilial,
      SeqProduto,
      CodCor,
      CodOperacaoEstoque,
      SeqNotaFornecedor,
      SeqNotaCliente,
      NumNota,
      LanOrcamento,
      CodMoeda,
      CodTecnico : Integer;
      UMAtual,
      UMPadrao,
      NumSerie,
      RefCliente:String;
      QtdProduto,
      ValTotal : double;
      DatMovimento : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDPlanoCorteFracao = class
    public
      CodFilial,
      SeqOrdem,
      SeqFracao : Integer;
      PesProduto : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDPlanoCorteItem = class
    public
      SeqItem,
      SeqIdentificacao,
      SeqProduto,
      QtdProduto : Integer;
      CodProduto,
      NomProduto : String;
      Fracoes : TList;
      constructor cria;
      destructor destroy;override;
      function AddFracao : TRBDPlanoCorteFracao;
end;

Type
  TRBDPlanoCorteCorpo = class
    public
      CodFilial,
      SeqPlanoCorte,
      SeqMateriaPrima,
      NumCNC,
      SeqChapa,
      CodUsuario : Integer;
      CodMateriaPrima,
      NomMateriaPrima : string;
      PerChapa,
      PesoChapa,
      DensidadeVolumetricaMP,
      EspessuraChapaMP : Double;
      DatEmissao : TDateTime;
      Itens : tlist;
      constructor cria;
      destructor destroy;override;
      function AddPlanoCorteItem : TRBDPlanoCorteItem ;
end;


Type
  TRBDOrcamentoProdutoPendenteMetalVidros = class
    public
      CodFilial,
      LanOrcamento : Integer;
      DatEntrega : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDProdutoPendenteMetalVidros = class
    public
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesUM : String;
      QtdProduto : Double;
      DatPrimeiraEntrega : TDateTime;
      Orcamentos : TList;
      constructor cria;
      destructor destroy;override;
      function AddOrcamentoProdutoPendente(VpaDatEntrega : TDateTime) : TRBDOrcamentoProdutoPendenteMetalVidros;
end;


Type
  TRBDPesoCartucho = class
    public
      SeqCartucho,
      SeqProduto,
      SeqPo,
      SeqCilindro,
      SeqChip,
      CodUsuario,
      CodCelula : Integer;
      CodProduto,
      NomProduto,
      CodReduzidoCartucho,
      DesTipoCartucho,
      NomCorCartucho : String;
      IndCilindroNovo,
      IndChipNovo : Boolean;
      DatPeso : TDateTime;
      PesCartucho,
      QtdMLCartucho : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDOperacaoEstoque = class
    public
      CodOperacao : Integer;
      NomOperacao,
      DesTipo_E_S,
      DesFuncao : String;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDConsumoFracaoOP = class
    public
      CodFilial,
      SeqOrdem,
      SeqFracao,
      SeqConsumo,
      SeqProduto,
      CodCor,
      CodFaca: Integer;
      QtdUnitario,
      QtdProduto,
      QtdBaixado,
      QtdABaixar,
      QtdReservado,
      QtdAReservar,
      LarMolde,
      AltMolde,
      PesProduto : Double;
      CodProduto,
      DesObservacao,
      DesUM,
      DesUMUnitario,
      DesUMOriginal,
      NomProduto,
      NomCor,
      NomFaca,
      DesLocalizacaoProduto : String;
      IndBaixado,
      IndOrigemCorte,
      IndMaterialExtra,
      IndExcluir  : Boolean;
      UnidadesParentes: TStringList;
      constructor Cria;
      destructor Destroy; override;
end;


Type TRBDMaquina = class
  public
    CodMaquina,
    AltBoca,
    LarBoca : Integer;
    NomMaquina : String;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDBastidor = class
  public
    codBastidor : Integer;
    NomBastidor : String;
    LarBastidor,
    AltBastidor : Double;
    constructor cria;
    destructor destroy;override;
end;


Type TRBDFaca = class
  public
    CodFaca,
    QtdProvas : Integer;
    AltFaca,
    LarFaca : Double;
    NomFaca : String;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDProdutoReserva = class
  public
    CodCliente,
    SeqReserva,
    SeqProduto,
    QtdDiasConsumo : Integer;
    CodProduto,
    NomProduto,
    IndCliente : String;
    QtdProduto : Double;
    DatUltimaCompra : TDateTime;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDPrecoClienteAmostra = class
    public
      SeqPreco,
      CodTabela,
      CodCliente : Integer;
      NomTabela,
      NomCliente : String;
      ValVenda,
      QtdVenda,
      PerLucro,
      PerComissao : Double;
      constructor cria;
      destructor destroy;override;
end;


Type
  TRBDValorVendaAmostra = class
    public
      CodTabela : Integer;
      NomTabela : String;
      Quantidade,
      ValVenda : Double;
      PerComissao,
      PerLucro,
      PerVendaPrazo,
      PerCoeficientes,
      CustoComImposto : Double;
      constructor cria;
      destructor destroy;override;
end;

Type TRBDServicoFixoAmostra = class
  public
    SeqConsumo,
    CodCorAmostra,
    CodEmpresaServico,
    CodServico : Integer;
    NomServico,
    DesAdicional : String;
    QtdServico,
    ValUnitario,
    ValTotal : Double;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDAmostraProcesso = class
    public
      CodAmostra,
      SeqProcesso,
      CodEstagio,
      CodProcessoProducao: Integer;
      QtdProducaoHora: Double;
      Configuracao: Boolean;
      DesTempoConfiguracao,
      DesObservacoes: String;
      ValUnitario : Double;
      constructor cria;
      destructor destroy; override;
  end;

Type
  TRBDQuantidadeAmostra = class
    public
      Quantidade : Double;
      constructor cria;
      destructor destroy;override;
end;

Type TRBDConsumoAmostra = class
  public
    SeqConsumo,
    CodCorAmostra,
    SeqProduto,
    SeqEntretela,
    CodCor,
    CodFaca,
    CodMaquina,
    CodTipoMateriaPrima,
    NumSequencia,
    AltProduto,
    QtdPontos : Integer;
    CodProduto,
    CodEntretela,
    NomProduto,
    NomEntretela,
    NomCor,
    NomTipoMateriaPrima,
    UMAnterior,
    DesLegenda,
    DesUM,
    DesObservacao : String;
    UnidadeParentes : TStringList;
    AltMolde,
    LarMolde,
    Qtdproduto,
    QtdPecasemMetro,
    PerAcrescimoPerda,
    ValUnitario,
    ValTotal,
    ValIndiceConsumo : Double;
    Faca : TRBDFaca;
    Maquina : TRBDMaquina;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDItensEspeciaisAmostra = class
    public
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesObservacao : string;
      ValProduto : double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDCorAmostra = class
    public
      CodCor : Integer;
      DatCadastro,
      DatFicha,
      DatEntrega  : TDateTime;
      DesImagemCor : String;
      ValPrecoEstimado: Double;
      Consumos : Tlist;
      constructor cria;
      destructor destroy;override;
      function addConsumo : TRBDConsumoAmostra;
  end;


Type TRBDAmostra = class
  public
    CodAmostra,
    CodColecao,
    CodDesenvolvedor,
    CodDepartamento,
    CodProspect,
    CodVendedor,
    CodAmostraIndefinida,
    QtdAmostra,
    QtdTotalPontos,
    QtdTrocasLinhaBordado,
    QtdCortesBordado,
    QtdAplique,
    CodEmpresa : Integer;

    CodClassificacao,
    DesTipoClassificacao,
    NomAmostra,
    DesImagem,
    DesImagemCliente,
    IndCopia,
    TipAmostra,
    DesObservacao,
    CodProduto,
    IndAlteracao,
    IndPossuiPrecoEstimado: String;

    DatAmostra,
    DatEntrega,
    DatEntregaCliente,
    DatAprovacao,
    DatAlteradoEntrega,
    DatFicha: TDateTime;

    ValorCusto,
    ValorVenda,
    ValVendaUnitario,
    QtdPrevisaoCompra,
    CustoMateriaPrima,
    CustoProcessos,
    CustoMaodeObraBordado,
    CustoProduto,
    CustoItensEspeciais: Double;
    DCor : TRBDCorAmostra;

    Processos,
    Quantidades,
    ValoresVenda,
    PrecosClientes,
    ItensEspeciais : TList;
    constructor cria;
    destructor destroy; override;
    function addQuantidade : TRBDQuantidadeAmostra;
    function addValorVenda : TRBDValorVendaAmostra;
    function addPrecoCliente : TRBDPrecoClienteAmostra;
    function addItemEspecial : TRBDItensEspeciaisAmostra;
    function addProcesso : TRBDAmostraProcesso;
end;

Type
  TRBDProdutoTabelaPreco = class
    public
      CodTabelaPreco,
      CodTamanho,
      CodCliente,
      CodMoeda,
      CodCor : Integer;
      NomTabelaPreco,
      NomMoeda,
      NomTamanho,
      NomCliente,
      NomCor,
      DesCodigodeBarra : String;
      ValVenda,
      ValRevenda,
      ValCompra,
      ValCusto,
      QtdEstoque,
      QtdMinima,
      QtdIdeal,
      PerMaximoDesconto :Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDProdutoAcessorio = class
    public
      CodAcessorio : integer;
      NomAcessorio :String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDFilialFaturamento = class
    public
      CodFilial : integer;
      NomFilial :String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDProdutoFornecedor = class
    public
      CodCliente,
      CodCor,
      NumDiaEntrega: Integer;
      DatUltimaCompra: TDateTime;
      QtdMinimaCompra,
      ValUnitario,
      PerIPI: Double;
      NomCliente,
      NomCor,
      DesReferencia: String;
      constructor Cria;
      destructor Destroy; override;
end;

Type TRBDProdutoImpressora = class
  public
    CodProduto,
    NomProduto : String;
    SeqImpressora : Integer;
end;

Type TRBDCartuchoCotacao = class
  public
    SeqCartucho,
    CodFilial,
    LanOrcamento,
    SeqProduto,
    SeqProdutoTrocado: Integer;
    CodProduto,
    NomProduto,
    CelulaTrabalho : String;
    PesCartucho: double;
    DatEmbalado,
    DatSaida : TDatetime;
    constructor cria;
    destructor destroy;override;
end;

type TRBDTipoCotacao = class
  public
    CodTipo,
    CodOperacaoEstoque,
    CodVendedor : Integer;
    NomTipo,
    CodPlanoContas : string;
    IndChamado,
    IndRevenda,
    IndExigirDataEntregaPrevista : Boolean;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDCelulaAgenda = class
  public
    CodCelula : Integer;
    DatCelula : TDatetime;
    DesHoraInicio,
    DesHoraFim : String;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDAgendaPCP = class
  public
    CelulasTrabalho : TList;
    constructor cria;
    destructor destroy;override;
    function addCelulaAgenda : TRBDCelulaAgenda;
end;

Type TRBDHorarioCelula = class
  public
    CodHorario : Integer;
    DesHoraInicio,
    DesHoraFim : String;
    constructor cria;
    destructor destroy;override;
end;

type TRBDEstagioCelula = class
  public
    CodEstagio : Integer;
    NomEstagio : String;
    IndPrincipal : Boolean;
    ValCapacidadeProdutiva : Integer;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDCelulaTrabalho = class
  public
    CodCelula : Integer;
    NomCelula : String;
    IndAtiva :Boolean;
    Estagios,
    Horarios : TList;
    constructor cria;
    Destructor destroy;override;
    Function addEstagio : TRBDEstagioCelula;
    function addHorario : TRBDHorarioCelula;
end;

Type TRBDProdutoOrcParcial = class
  public
    SeqParcial,
    SeqMovOrcamento,
    SeqProduto,
    CodCor : Integer;
    DesUM : String;
    QtdParcial,
    QtdConferido,
    ValProduto,
    ValTotal : Double;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDOrcamentoParcial = class
  public
    CodFilial,
    LanOrcamento,
    SeqParcial : Integer;
    DatParcial : TDateTime;
    ValTotal : Double;
    Produtos : TList;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDImpressaoFaturaNotaFiscal = class
  public
    Numero1,
    Numero2,
    Numero3,
    Numero4 : String;
    Valor1,
    Valor2,
    Valor3,
    Valor4 : Double;
    DatVencimento1,
    DatVencimento2,
    DatVencimento3,
    DatVencimento4 : TDateTime;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDNotaFiscalServico = class
  public
    CodServico,
    CodFiscal : Integer;
    CodClassificacao,
    NomServico,
    DesAdicional : String;
    QtdServico,
    ValUnitario,
    ValTotal,
    PerISSQN,
    PerComissaoClassificacao : Double;
    Constructor cria;
    destructor destroy;override;

end;


Type TRBDNotaFiscalProduto = class
  public
    SeqProduto,
    CodCor,
    NumOrdemClaFiscal,
    QtdMesesGarantia,
    NumOrigemProduto,
    CodCFOP
                :Integer;
    NumDestinoProduto : TRBDDestinoProduto;

    CodProduto,
    NomProduto,
    DesCor,
    CodClassificacaoFiscal,
    CodClassificacaoProduto,
    CodCST,
    DesRefCliente,
    DesOrdemCompra,
    DesAdicional,
    UM,
    UMAnterior,
    UMOriginal
                  :String;
    PerReducaoICMSProduto,
    PerSubstituicaoTributaria,
    PerICMS,
    PerIPI,
    PesLiquido,
    PesBruto,
    QtdEstoque,
    QtdMinima,
    QtdPedido,
    QtdProduto,
    ValIPI,
    ValUnitario,
    ValUnitarioOriginal,
    ValTabelaPreco,
    ValTotal,
    ValDesconto,
    ValBaseICMS,
    ValICMS,
    ValFrete,
    ValOutrasDespesas,
    ValBaseICMSSubstituicao,
    ValICMSSubtituicao,
    PerReducaoUFBaseICMS,
    PerComissaoProduto,
    PerComissaoClassificacao,
    PerDescontoMaximo,
    AltProdutonaGrade
                 : Double;
    IndSubstituicaoTributaria,
    IndReducaoICMS,
    IndBaixaEstoque,
    IndItemCancelado : Boolean;
    UnidadeParentes : TStringList;
    ProdutoPeca : TList;
    constructor cria;
    destructor destroy;override;
    function AddProdutoPeca:TRBDProdutoClientePeca;
end;

Type
  TRBDParcelaSinal = class
    public
      CodFilial,
      LanReceber,
      NumParcela : Integer;
      constructor cria;
      destructor destroy;override;
  end;

type
  TRBDTipoNota = (tnNormal,tnVendaPorContaeOrdem,tnDevolucao);
  TRBDNotaFiscal = class
  public
    CodFilial,
    SeqNota,
    NumNota,
    NumNSU,
    CodCliente,
    CodTipoFrete,
    CodTransportadora,
    CodRedespacho,
    CodCondicaoPagamento,
    CodFormaPagamento,
    CodVendedor,
    CodVendedorPreposto,
    CodModeloDocumento,
    QtdEmbalagem,
    SeqItemNatureza,
    CodUsuario,
    NumFolhaImpressao,
    QtdFolhaImpressao,
    CFOPProdutoIndustrializacao,
    CFOPProdutoRevenda,
    CFOPSubstituicaoTributariaIndustrializacao,
    CFOPSubstituicaoTributariaRevenda,
    CFOPServico : Integer;
    DesSerie,
    DesSubSerie,
    CodNatureza,
    CodPlanoContas,
    DesTipoNota,
    DesMarcaEmbalagem,
    DesUFFilial,
    DesPlacaVeiculo,
    DesUFPlacaVeiculo,
    DesUFEmbarque,
    DesLocalEmbarque,
    DesEspecie,
    NumEmbalagem,
    NumCotacaoTransportadora,
    DesOrdemCompra,
    NumPedidos,
    DesClassificacaoFiscal,
    DesTextoFiscal,
    NumContaCorrente,
    DesChaveNFE,
    NumProtocoloNFE,
    NumProtocoloCancelamentoNFE,
    NumReciboNFE,
    CodMotivoNFE,
    DesMotivoNFE,
    DesMotivoCancelamentoNFE,
    CodCSTNatureza : String;
    DatNSU,
    DatEmissao,
    DatSaida,
    DatPagamentoSinal,
    HorSaida : TDateTime;
    IndNaturezaEstadoLocal,
    IndGeraFinanceiro,
    IndGerouFinanceiroOculto,
    IndGeraComissao,
    IndCalculaICMS,
    IndCalculaISS,
    IndExigirCPFCNPJ,
    IndNaturezaProduto,
    IndNaturezaServico,
    IndBaixarEstoque,
    IndNaturezaNotaDevolucao,
    IndMovimentacaoFisica,
    IndNotaCancelada,
    IndNotaInutilizada,
    IndNotaImpressa,
    IndECF,
    IndNotaVendaConsumidor,
    IndNotaDevolvida,
    IndReducaoICMS,
    IndClienteRevenda,
    IndDescontarISS,
    IndMostrarParcelas,
    IndNFEEnviada : Boolean;
    ValICMSPadrao,
    ValICMSAliquotaInternaUFDestino,
    ValBaseICMS,
    ValICMS,
    ValBaseICMSSubstituicao,
    ValICMSSubtituicao,
    ValTotalProdutos,
    ValTotalProdutosSemDesconto,
    ValTotalServicos,
    ValFrete,
    ValSeguro,
    ValOutrasDepesesas,
    ValTotalIPI,
    ValTotal,
    ValDesconto,
    ValDescontoTroca,
    ValIssqn,
    ValBaseComissao,
    ValICMSSuperSimples,
    ValSinalPagamento,
    PerIssqn,
    PerDesconto,
    PerComissao,
    PerComissaoPreposto,
    PerReducaoUFICMS,
    PesBruto,
    PesLiquido,
    PerICMSSuperSimples : Double;
    DesDadosAdicinais,
    DesObservacao,
    DesDadosAdicionaisImpressao : TStringList;
    TipNota : TRBDTipoNota;
    Produtos,
    Servicos,
    Faturas,
    ParcelasSinal: TList;
    constructor cria;
    destructor destroy;override;
    function AddProduto : TRBDNotaFiscalProduto;
    function AddServico : TRBDNotafiscalServico;
    function AddFatura : TRBDImpressaoFaturaNotaFiscal;
    function AddParcelaSinal : TRBDParcelaSinal;
end;

Type
  TRBDCombinacaoFigura = class
    public
      SeqFigura,
      NumEspula : Integer;
      CodCor,
      TitFio : String;
      constructor cria;
end;

Type
  TRBDCombinacaoCadarcoTear = class
    public
      CodCombinacao,
      SeqProdutoFioTrama,
      SeqProdutoFioAjuda,
      CodCorFioTrama,
      CodCorFioAjuda : Integer;
      CodProdutoFioTrama,
      CodProdutoFioAjuda,
      NomProdutoFioTrama,
      NomProdutoFioAjuda,
      NomCorFioTrama,
      NomCorFioAjuda : String;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDCombinacao = class
    public
      CodCombinacao,
      Espula1,
      Espula2,
      EspulaUrdumeFigura,
      CorCartela : Integer;
      CorFundo1,
      CorFundo2,
      CorUrdumeFigura,
      TituloFundo1,
      TituloFundo2,
      TituloFundoFigura : String;
      Figuras : TList;
      Constructor Cria;
      destructor destroy;override;
      function AddFigura : TRBDCombinacaoFigura;
end;

Type
  TRBDConsumoMPBastidor = class
    public
      CodBastidor,
      QtdPecas : Integer;
      NomBastidor : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDConsumoMP = class
    public
      CorKit,
      SeqMovimento,
      SeqProduto,
      SeqProdutoEntretela,
      SeqProdutoTermoColante,
      CodCor,
      CodFaca,
      CodMaquina,
      AltProduto,
      CorReferencia,
      QtdEntretela,
      QtdTermoColante : Integer;
      CodProduto,
      CodProdutoEntretela,
      CodProdutoTermoColante,
      NomProduto,
      NomProdutoEntretela,
      NomProdutoTermoColante,
      NomCor,
      DesPrateleira,
      DesObservacoes,
      UMOriginal,
      UM : String;
      UnidadeParentes : TStringList;
      QtdProduto,
      PerValor,
      AlturaMolde,
      LarguraMolde,
      PecasMT,
      IndiceMT,
      ValorUnitario,
      ValorTotal : Double;
      DatDesenho : TDateTime;
      Faca: TRBDFaca;
      Maquina: TRBDMaquina;
      Bastidores : TList;
      constructor cria;
      destructor destroy;override;
      function addBastidor : TRBDConsumoMPBastidor;
end;

Type
  TRBDEstagioProduto = class
    public
      SeqEstagio,
      NumOrdem,
      CodEstagio,
      CodEstagioAnterior,
      QtdEstagioAnterior : Integer;
      DesEstagio,
      NomEstagio,
      NomEstagioAnterior,
      IndConfig,
      DesTempoConfig : String;
      QtdProducaoHora : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDProdutoCorInstalacaoTear = class
    public
      CodCor : Integer;
      Repeticoes : TList;
      constructor cria;
      destructor destroy;
      function AddRepeticoes : TRBDRepeticaoInstalacaoTear;
end;

Type
  TRBDProdutoFioOrcamentoCadarco = class
     public
       SeqProduto : Integer;
       CodProduto,
       NomProduto : String;
       IndSelecionado : Boolean;
       PesFio,
       ValCustoFio : Double;
       constructor cria;
       destructor destroy;override;
end;

Type
  TRBDTipoCadarco = (tcConvencional,tcCroche,tcRenda,tcElastico);
  TRBDArredondamentoTruncamento = (atArredondamento,atTruncamento);
  TRBDSituacaoTributaria =(stIsento, stNaoTributado, stSubstituicaoTributaria,stTributadoICMS);
  TRBDTipoEmbalagemPvc = (teEmBranco,teCosturado, teSoldada, teSoldadaZiper, teTnt, teMateriaPrima);
  TRBDAlcaEmbalagemPvc = (aeEmBranco,aeSemAlca, aePadrao, aePequeno, aeGrande, aeCosturada, aeAlcaFita, aeAlcaSilicone);
  TRBDImpEmbalagemPvc = (ieEmBranco,ieNao, ie1, ie2, ie3, ie4, ie5, ie6, ie7, ie8);
  TRBDCabEmbalagemPvc = (ceEmBranco,ceNao, ce8Cm, ce10Cm, ce14Cm, ceGancheira);
  TRBDSimCabEmbalagemPvc = (seEmBranco,seLado, seOposto, seLateral);
  TRBDBotaoEmbalagemPvc = (beEmBranco,beNao, be1, be2, be3);
  TRBDCorBotaoEmbalagemPvc = (cbEmBranco,cbeBranco, cbePreto);
  TRBDBolineEmbalagemPvc = (boEmBranco,boNao, bo1, bo2, bo3, boLiner);
  TRBDZiperEmbalagemPvc = (zeEmBranco,zeNao, zeNylon3, zeNylon6, zePvc, zeZiper);
  TRBDViesEmbalagemPvc = (veEmBranco,vePvcTran, vePvcCol, veViesTn, veViesAl, veViesLi);
  TRBDInternoExternoPvc = (inInterno, inExterno);
  TRBDProduto = Class
    public
    // Gerais
      CodEmpresa,
      CodEmpFil,
      SeqProduto,
      CodMoeda,
      CodUsuario,
      CodTipoCodBarra,
      QtdUnidadesPorCaixa,
      NumOrigemProduto :Integer;
      NumDestinoProduto : TRBDDestinoProduto;
      PerIPI,
      QtdDiasEntregaFornecedor,
      PerReducaoICMS,
      PerICMS,
      PerSubstituicaoTributaria,
      QtdMinima,
      QtdAReservar,
      QtdReservado,
      PerDesconto,
      PerMaxDesconto,
      QtdPedido,
      PerComissao,
      QtdEstoque,
      QtdRealEstoque,
      PerLucro,
      VlrCusto,
      VlrVenda,
      VlrRevenda: Double;
      CodProduto,
      CodUnidade,
      NomProduto,
      CodClassificacao,
      DesClassificacaoFiscal,
      DesObservacao,
      DesDescricaoTecnica,
      CodBarraFornecedor,
      PatFoto,
      CifraoMoeda: String;
      IndKit,
      IndProdutoAtivo,
      IndSubstituicaoTributaria,
      IndDescontoBaseICMSConfEstado: Boolean;
      UnidadesParentes: TStringList;

    // Cadarço Trançado
      CodMaquina,
      QuantidadeFusos,
      MetrosTabuaPequena,
      MetrosTabuaGrande,
      MetrosTabuaTrans: Integer;
      EngrenagemEspPequena,
      DesTituloFio,
      DesEnchimento: String;

    // Cadarço
      EngrenagemTrama,
      SistemaTear,
      BatidasPorCm,
      IndPreEncolhido: String;

    // Etiqueta
      CodSumula,
      CmpFigura,
      CodTipoFundo,
      CodTipoCorte,
      CodTipoEmenda,
      PerProdutividade: Integer;
      DatEntradaAmostra,
      DatSaidaAmostra: TDateTime;
      BatProduto,
      NumBatidasTear,
      Pente,
      IndCalandragem,
      IndEngomagem: String;

    // Adicionais
      PesoLiquido,
      PesoBruto,
      CapLiquida: Double;
      QtdMesesGarantia,
      CodEmbalagem,
      CodAcondicionamento,
      CodComposicao,
      AltProduto,
      CodDesenvolvedor: Integer;
      IndImprimeNaTabelaPreco,
      IndCracha,
      IndProdutoRetornavel,
      DesRendimento: String;
      IndMonitorarEstoque,
      IndRecalcularPreco,
      IndAgruparCorteBalancim : Boolean;
      DatCadastro : TDateTime;
      ArredondamentoTruncamento :TRBDArredondamentoTruncamento;
      SituacaoTributaria : TRBDSituacaoTributaria;

    // Copiadoras
      IndCopiadora,
      IndMultiFuncional,
      IndImpressora,
      IndColorida,
      IndComponente,
      IndCilindro,
      CodCartuchoAltaCapac,
      IndPlacaRede,
      IndPCL,
      IndFax,
      IndUSB,
      IndScanner,
      IndWireless,
      IndDuplex: String;
      QtdCopiasTonner,
      QtdCopiasTonnerAltaCapac,
      QtdCopiasCilindro,
      QtdPagPorMinuto,
      VolumeMensal: Integer;
      DatFabricacao,
      DatEncerProducao: TDateTime;

    // Cartuchos
      CodCorCartucho,
      PesCartuchoVazio,
      PesCartucho,
      QtdMlCartucho,
      QtdPaginas: Integer;
      DesTipoCartucho: String;
      IndCilindroNovo,
      IndChipNovo,
      IndProdutoOriginal,
      IndCartuchoTexto,
      IndProdutoCompativel: Boolean;

    // Outros
      IndFornecedoresCarregados: Boolean;

    // Dados que se repetem
      CmpProduto,
      LarProduto,
      MetrosPorMinuto: Integer;
      NumFios,
      Engrenagem,
      PraProduto,
      DesTipTear,
      CodReduzidoCartucho: String;
      DInstalacaoCorTear : TRBDProdutoCorInstalacaoTear;

    //Aco
      DensidadeVolumetrica,
      EspessuraAco : extended;
      IndGerouEstoqueChapa : boolean;

    //Embalagem PVC
      TipEmbalagem : TRBDTipoEmbalagemPvc;
      SeqProdutoPlastico,
      SeqProdutoPlastico2,
      CodFerramentaFaca,
      TamZiper,
      CodCorZiper: integer;

      Alca : TRBDAlcaEmbalagemPvc;
      InternoExterno: TRBDInternoExternoPvc;

      DesLocalAlca,
      DesLocalImp,
      DesLocalInt,
      ObsCorte,
      DesInterno,
      DesInterno2,
      DesCoresImp,
      ObsBotao,
      DesFotolito,
      DesAdicionaisPvc,
      ComLaminaZiper,
      ComLaminaAba,
      DesLarPvc,
      DesAltPvc,
      DesComFunPvc,
      DesComAbaPvc,
      DesComDiametroPvc,
      DesComPendurico : string;

      ValPrecoFaccionista,
      ValPrecoPvc: Double;

      IndCorte,
      IndBolso,
      IndInterno: Boolean;

      Impressao : TRBDImpEmbalagemPvc;
      Cabide: TRBDCabEmbalagemPvc;
      SimCabide: TRBDSimCabEmbalagemPvc;
      Botao : TRBDBotaoEmbalagemPvc;
      CorBotao :TRBDCorBotaoEmbalagemPvc;
      Boline: TRBDBolineEmbalagemPvc;
      Ziper : TRBDZiperEmbalagemPvc;
      Vies : TRBDViesEmbalagemPvc;

    // Detectores de Metal
      AberturaCabeca,
      ConsumoEletrico,
      TensaoAlimentacao,
      ComunicacaoRede,
      GrauProtecao,
      SensibilidadeFerrosos,
      SensibilidadeNaoFerrosos,
      AcoInoxidavel,
      DescritivoFuncDetectoresMetal,
      InfDisplayDetectoresMetal: String;

    //Maquinas Rotuladoras
      DesComercial,
      DesInfoTecnica: String;

    //Instalacao Tear
      QtdQuadros,
      QtdLinhas,
      QtdColunas : Integer;
    //Orcamento Cadarço
      TipoCadarco : TRBDTipoCadarco;
    // Listas
      Combinacoes,
      CombinacoesCadarcoTear,
      ConsumosMP,
      Estagios,
      Fornecedores,
      Acessorios,
      FigurasComposicao,
      InstalacaoTear,
      TabelaPreco,
      FilialFaturamento,
      FiosOrcamentoCadarco : TList;
      constructor Cria;
      destructor Destroy; override;
      function AddCombinacao: TRBDCombinacao;
      function AddCombinacaoCadarcoTear : TRBDCombinacaoCadarcoTear;
      function AddConsumoMP: TRBDConsumoMP;
      function AddEstagio: TRBDEstagioProduto;
      function AddFornecedor: TRBDProdutoFornecedor;
      function AddAcessorio : TRBDProdutoAcessorio;
      Function AddFilialFaturamento: TRBDFilialFaturamento;
      function AddTabelaPreco : TRBDProdutoTabelaPreco;
      function AddInstalacaoTear : TRBDProdutoInstalacaoTear;
      function addFioOrcamentoCadarco : TRBDProdutoFioOrcamentoCadarco;
end;


Type
  TRBDOrdemCorteItem = class
    public
      SeqItem,
      SeqProduto,
      SeqProdutoKit,
      SeqCorKit,
      SeqMovimentoKit,
      SeqEntretela,
      SeqTermocolante,
      CodCor,
      CodFaca,
      CodMaquina,
      AltProduto,
      QtdEntretela,
      QtdTermocolante,
      CodBastidor,
      QtdPecasBastidor,
      PosFaca : Integer;
      CodProduto,
      DesUm,
      DesObservacao,
      NomProduto,
      NomEntretela,
      NomTermocolante,
      NomCor,
      NomFaca,
      NomBastidor : String;
      LarMolde,
      AltMolde,
      AltEnfesto,
      LarEnfesto,
      QtdEnfesto,
      QtdProduto,
      QtdMetrosProduto,
      QtdPecasemMetro,
      ValIndiceMetro : Double;
      DMaquina : TRBDMaquina;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDOrdemProducaoProduto = class
    public
      DProduto : TRBDProduto;
      CodCor,
      CodTamanho : Integer;
      NomCor,
      NomTamanho,
      DesUM : String;
      QtdaProduzir,
      QtdOp,
      QtdemProcesso,
      QtdemProcessoSerie : Double;
      Fracoes : TList;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDOrdemCorte = class
    public
      CodFilial,
      SeqOrdemProducao,
      SeqCorte,
      QtdFracao : Integer;
      QtdProduto : Double;
      Itens : TList;
      function AddCorteItem : TRBDOrdemCorteItem;
      constructor cria;
      destructor destroy;override;
end;


Type TRBDColetaRomaneioOp = class
  public
    CodUsuario,
    CodFilial,
    NumOrdemProducao,
    SeqFracao,
    SeqColeta : Integer;
    DesUM : String;
    QtdColetado : Double;
    DatColeta : TDateTime;
    constructor cria;
end;

Type TRBDColetaFracaoOp = class
  public
    CodUsuario,
    CodFilial,
    NumOrdemProducao,
    SeqFracao,
    SeqEstagio,
    CodCelula,
    PerProdutividade,
    QtdMinutos : Integer;
    DesUM : String;
    QtdColetado,
    QtdDefeito,
    QtdProducaoHora,
    QtdProducaoIdeal : Double;
    DatInicio,
    DatFim : TDateTime;
    constructor cria;
end;

Type TRBDordemProducaoEstagio = class
  public
    SeqEstagio,
    CodEstagio,
    SeqEstagioAnterior,
    QtdCelula,
    NumOrdem : Integer;
    DesEstagio,
    NomEstagio,
    QtdHoras,
    IndProducaoInterna : String;
    DatInicio,
    DatFim,
    DatInicioPrevisto,
    DatFimPrevisto : TDateTime;
    QtdProduzido,
    ValUnitarioFaccao : Double;
    IndTerceirizado,
    IndFinalizado : Boolean;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDOPItemMaquina = class
  public
    CodMaquina : Integer;
    NomMaquina : String;
    QtdHoras,
    QtdMetros : Double;
    constructor cria;
    destructor destroy;override;
end;

Type TRBDOPItemCadarco = class
  public
    SeqItem,
    SeqProduto,
    CodCor,
    QtdFusos,
    NroFios,
    MetporTabua,
    NroMaquinas : Integer;
    CodProduto,
    NomProduto,
    IndAlgodao,
    IndPoliester,
    NomCor,
    DesEngrenagem,
    TitFios,
    DesEnchimento,
    DesTecnica,
    UM : String;
    Grossura,
    MetMinuto,
    QtdMetrosProduto,
    QtdProduto,
    NumTabuas : Double;
    Maquinas : TList;
    constructor cria;
    destructor destroy;override;
    function addMaquina : TRBDOPItemMaquina;
end;

Type
  TRBDOrdemProducaoItem = class
    public
      CodCombinacao,
      QtdFitas,
      QtdEtiquetas,
      SeqItem : Integer;
      CodManequim : String;
      MetrosFita,
      QtdProduzido,
      QtdFaltante : Double;
end;

Type
  TRBDEstagioFracaoOPReal = class
    public
      CodFilial,
      SeqOrdem,
      SeqFracao,
      CodEstagio,
      CodEstagioAtual,
      SeqEstagio,
      CodUsuario,
      CodUsuarioLogado : Integer;
      DesObservacao : String;
      DatFim : TDateTime;
      IndDatFim,
      IndEstagioFinal : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDRevisaoFracaoTerceiroFaccionista = class
    public
      NomTerceiro : String;
      QtdRevisado,
      QtdDefeito : Integer;
      constructor cria;
      destructor destroy;override;
end;

Type TRBDRevisaoFracaoFaccionista = class
  public
    CodFaccionista,
    SeqItem,
    SEqRetorno,
    CodFilial,
    SeqOrdem,
    SeqFracao,
    SeqEstagio,
    CodUsuario : Integer;
    QtdRevisado,
    QtdDefeito : Double;
    DatRevisao : TDateTime;
    CodProduto,
    NomProduto : String;
    Terceiros : TList;
    constructor cria;
    destructor destroy;override;
    function AddTerceiro : TRBDRevisaoFracaoTerceiroFaccionista;
end;

Type TRBDDevolucaoFracaoFaccionista = class
  public
    CodFaccionista,
    SeqItem,
    SeqDevolucao,
    CodUsuario,
    CodMotivo,
    CodFilial,
    SeqOrdem,
    SeqFracao,
    SeqIDEstagio : Integer;
    QtdDevolvido : double;
    DatCadastro : TDateTime;
    DesMotivo : String;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDRetornoFracaoFaccionista = class
    public
    CodFilial,
    SeqOrdem,
    SeqFracao,
    CodFaccionista,
    SeqItem,
    SeqIDEstagio,
    SEqRetorno,
    CodUsuario : Integer;
    QtdRetorno,
    QtdFaltante,
    ValUnitario,
    ValUnitarioEnviado,
    ValUnitarioPosteriorEnviado : Double;
    IndDefeito : Boolean;
    DatDigitacao,
    DatCadastro,
    DatFinalizacaoFracao,
    DatNegociado : TDatetime;
    IndFinalizar,
    IndValorMenor : Boolean;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDFracaoFaccionista = class
    public
      CodFilial,
      SeqOrdem,
      SeqFracao,
      SeqIDEstagio,
      CodUsuario,
      CodFaccionista : Integer;
      QtdEnviado,
      ValUnitario,
      ValUnitarioPosterior,
      ValEstagio,
      ValTaxaEntrega : Double;
      DesUM : String;
      IndDefeito : Boolean;
      DatCadastro,
      DatDigitacao,
      DatRetorno : TDatetime;
      Constructor Cria;
      destructor destroy;override;
end;

Type
  TRBDConsumoOrdemProducao = class
    public
      SeqConsumo,
      SeqProduto,
      CodCor,
      CodFaca : Integer;
      DesObservacoes,
      UM,
      UMUnitario,
      UMOriginal : String;
      QtdUnitario,
      QtdABaixar,
      QtdBaixado,
      QtdReservada,
      QtdAReservar,
      AltMolde,
      LarMolde : Double;
      IndBaixado,
      IndOrdemCorte,
      IndOrigemCorte,
      IndMaterialExtra,
      IndExcluir : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDFracaoOrdemProducao = class
    public
      SeqFracao,
      CodFilial,
      SeqOrdemProducao,
      SeqFracaoPai,
      QtdCelula,
      CodEstagio,
      SeqProduto,
      CodCor,
      CodTamanho : Integer;
      CodProduto,
      NomProduto,
      NomEstagio,
      NomCor,
      NomTamanho,
      HorProducao,
      UM,
      UMOriginal,
      DesObservacao : String;
      CodBarras,
      QtdUtilizada,
      QtdProduto : double;
      DatEntrega,
      DatFinalizacao,
      DatImpressaoFicha : TDatetime;
      IndEstagiosCarregados,
      IndEstagioGerado,
      IndPlanoCorte,
      IndConsumoBaixado,
      IndFracaoNova,
      IndPossuiEmEstoque,
      IndProducaoemSerie : Boolean;
      Estagios,
      Compose,
      Consumo,
      ConsumoOrdemCorte : TList;
      constructor cria;
      destructor destroy;override;
      function AddEstagio : TRBDordemProducaoEstagio;
      function addConsumo : TRBDConsumoOrdemProducao;
end;


Type
  TRBDOrdemSerra = class
    public
      SeqOrdemSerra,
      SeqMateriaPrima,
      SeqProduto,
      QtdProduto : Integer;
      NomMateriaPrima : String;
      ComMateriaPrima : Double;
      Fracoes : TList;
      constructor cria;
      destructor destroy;override;

end;

Type
  TRBDOrdemProducao = class
    public
      CodEmpresafilial,
      SeqOrdem,
      SeqOrdemaAdicionar,
      SeqUltimaFracao,
      SeqFracaoDisponivelReimportacao,
      CodCliente,
      LanOrcamento,
      SeqItemOrcamento,
      CodEstagio,
      SeqProduto,
      CodCor,
      CodProgramador,
      CodProjeto,
      NumPedido,
      QtdFracoes,
      CodTransportadora : Integer;
      CodProduto,
      NomProduto,
      NomCor,
      UMPedido,
      HorProducao,
      DesObservacoes,
      DesReferenciaCliente,
      DesOrdemCompra : String;
      DatEmissao,
      DatEntrega,
      DatEntregaPrevista : TDateTime;
      QtdProduto,
      ValUnitario : Double;
      DProduto : TRBDProduto;
      OrdemCorte : TRBDOrdemCorte;
      Estagios : TList;
      Fracoes : TList;
      Consumo : TList;
      ProdutosSubmontagemAgrupados : TList;
      OrdensSerra : TList;
      constructor cria;
      destructor destroy;override;
      function AddFracao : TRBDFracaoOrdemProducao;
      function AddConsumo : TRBDConsumoOrdemProducao;
      function AddOrdemSerra : TRBDOrdemSerra;
      function AddProdutoAgrupadoSubmontagem : TRBDOrdemProducaoProduto;
end;


type TRBDOrdemProducaoEtiqueta = class(TRBDOrdemProducao)
    public
      CodMaquina,
      CodTipoCorte,
      TipPedido,
      QtdFita,
      PerAcrescimo,
      NroOPCliente,
      QtdRPMMaquina,
      TipTear,
      CodMotivoReprogramacao : Integer;
      IndProdutoNovo : String;
      TotMetros,
      MetFita : Double;
      Items : TList;
      ItemsCadarco : TList;
      constructor cria;
      destructor destroy;override;
      function AddItems:TRBDOrdemProducaoItem;
      function AddItemsCadarco : TRBDOPItemCadarco;
end;

Type
  TRBDColetaOPItem = class
    public
      SeqItem,
      CodCombinacao,
      NroFitas,
      NroFitasAnterior : Integer;
      CodManequim : string;
      MetrosProduzidos,
      MetrosColetados,
      MetrosAProduzir,
      MetrosFaltante : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDColetaOP = class
    public
      CodEmpresaFilial,
      SeqOrdemProducao,
      SeqColeta,
      CodUsuario : Integer;
      DatColeta : TDateTime;
      IndFinal,
      IndReprogramacao,
      IndGeradoRomaneio : Boolean;
      QtdTotalColetado : Double;
      ItensColeta : TList;
    constructor cria;
    destructor destroy;override;
    function AddItemColeta : TRBDColetaOPItem;
end;

Type
  TRBDOrcCompose = class
    public
      SeqCompose,
      CorRefencia,
      SeqProduto,
      CodCor : Integer;
      CodProduto,
      NomProduto,
      NomCor : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDOrcServico = class
    public
      CodServico,
      CodFiscal : Integer;
      CodClassificacao,
      NomServico,
      DesAdicional : String;
      QtdServico,
      ValUnitario,
      ValTotal,
      PerISSQN,
      PerComissaoClassificacao : Double;
    constructor cria;
end;

Type
  TRBDOrcProduto = class
    public
      LanOrcamentoOrigem,
      SeqMovimento,
      SeqProduto,
      CodCor,
      CodTamanho,
      CodEmbalagem,
      CodPrincipioAtivo,
      SeqOrdemProducao,
      QtdMesesGarantia
                  :Integer;
      CodProduto,
      CodClassificacao,
      NomProduto,
      NomTamanho,
      DesCor,
      DesEmbalagem,
      DesObservacao,
      DesRefClienteOriginal,
      DesRefCliente,
      DesOrdemCompra,
      DesPrateleira,
      UM,
      UMAnterior,
      UMOriginal,
      IndImpFoto,
      IndImpDescricao,
      DesRegistroMSM,
      PathFoto,
      DesCodBarra,
      DesCodBarraAnterior :String;
      IndFaturar,
      IndRetornavel,
      IndBrinde,
      IndCracha,
      IndMedicamentoControlado,
      IndPermiteAlterarQtdnaSeparacao,
      IndImprimirEtiquetaSeparacao,
      IndSubstituicaoTributaria : Boolean;
      PerDesconto,
      PerDescontoMaximoPermitido,
      PesLiquido,
      PesBruto,
      QtdBaixadoNota,
      QtdBaixadoEstoque,
      QtdABaixar,
      QtdEstoque,
      QtdMinima,
      QtdPedido,
      QtdProduto,
      QtdCancelado,
      QtdKit,
      QtdFiscal,
      QtdDevolvido,
      QtdConferido,
      QtdConferidoSalvo,
      QtdSaldoBrinde,
      ValUnitario,
      ValUnitarioOriginal,
      ValCustoUnitario,
      ValVendaLiquida,
      ValCustoTotal,
      ValTabelaPreco,
      ValRevenda,
      ValTotal,
      RedICMS,
      PerICMS,
      PerComissao,
      PerComissaoClassificacao,
      AltProdutonaGrade,
      CmpProduto,
      QtdPecas
                   : Double;
      DatOrcamento,
      DatOpGerada,
      DatAmostraAprovada : TDateTime;
      UnidadeParentes : TStringList;
      Compose : TList;
      constructor cria;
      destructor destroy;override;
      function AddCompose : TRBDOrcCompose;
  end;

Type
  TRBDOrigemPedido = (opCliente,opRepresentante,opNaoDigitado);
  TRBDOrcamento = class
    public
      CodEmpFil,
      LanOrcamento,
      CodTipoOrcamento,
      CodRepresentada,
      CodCliente,
      CodClienteFaccionista,
      CodVendedor,
      CodPreposto,
      SeqNotaEntrada,
      CodCondicaoPagamento,
      CodOperacaoEstoque,
      CodFormaPaqamento,
      CodEstagio,
      CodUsuario,
      TipFrete,
      TipGrafica,
      CodTecnico,
      CodTabelaPreco,
      NumContadorOrdemOperacao,
      CodMedico,
      TipReceita,
      QtdVolumesTransportadora,
      CodRegiaoVenda: integer;
      RGCliente,
      FlaSituacao,
      NomContato,
      NomSolicitante,
      DesEmail,
      OrdemCompra,
      OrdemCorte,
      NumNotas,
      NumCupomfiscal,
      DesServico,
      CodPlanoContas,
      NumContaCorrente,
      DesProblemaChamado,
      DesEnderecoAtendimento,
      NomComputador,
      DesObservacaoFiscal,
      DesServicoExecutado,
      NumReceita,
      DesLocalEmbarque,
      UfEmbarque : String;
      PerComissao,
      PerComissaoPreposto,
      QtdProduto,
      ValTotal,
      ValTotalProdutos,
      ValTotalLiquido,
      ValTotalComDesconto,
      ValTroca,
      PesLiquido,
      PesBruto,
      PerDesconto,
      ValDesconto,
      ValTaxaEntrega,
      ValChamado,
      ValDeslocamento: Double;
      DatOrcamento,
      HorOrcamento,
      DatPrevista,
      DatValidade,
      DatEntrega,
      HorPrevista,
      DatReceita : TDateTime;
      FinanceiroGerado,
      IndSinalPagamentoGerado,
      IndCancelado,
      IndImpresso,
      IndNotaGerada,
      IndPendente,
      IndClienteRevenda,
      IndProcessada,
      IndProcessamentoFrio,
      IndValoresAlterados,
      IndRevenda,
      OPImpressa,
      IndNumeroBaixado : Boolean;
      CodTransportadora,
      CodRedespacho : integer;
      PlaVeiculo,
      UFVeiculo   : string;
      EspTransportadora,
      MarTransportadora : string;
      NumTransportadora : integer;
      OrigemPedido : TRBDOrigemPedido;
      DesObservacao,
      Parcelas : TStringList;
      BaixasParciais,
      Produtos,
      Servicos: TList;
      Constructor cria;
      destructor destroy;override;
      function AddProduto : TRBDOrcProduto;
      function AddServico : TRBDOrcServico;
      function addProdutoBaixaParcial : TRBDProdutoOrcParcial;
end;

Type
  TRBDGerarOp = class
    public
      CodProduto,
      NomProduto,
      NomCor,
      NomTamanho,
      UM,
      UMOriginal,
      DesReferenciaCliente,
      DesObservacao : String;
      SeqProduto,
      CodCor,
      CodTamanho,
      SeqItemOrcamento : Integer;
      IndGerar : Boolean;
      QtdProduto,
      QtdKit,
      ValUnitario : Double;
      DatEntrega : TDateTime;
      Compose : TList;
      constructor cria;
      destructor destroy;override;
end;



Type
  TRBDEtiPequena = class
    Qtd,
    DesMM,
    DesProduto,
    DesComposicao,
    DesReferencia,
    DesCor,
    DesOrdemCompra,
    DesDestino : String;
end;

Type
  TRBDEtiCor = class
    public
      CodCor : Integer;
      NomCor,
      UM,
      DesReferenciaCliente : String;
      QtdCotacao,
      QtdEtiqueta,
      QtdEmbalagem : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDEtiProduto = class
    public
    CodProduto,
    NomProduto,
    DesComposicao
     : String;
    QtdEmbalagem,
    QtdEmbalagemAnterior : Double;
    Cores : TList;
    function addCor : TRBDEtiCor;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDEtiModelo1 = class
    public
      NomCliente,
      OrdemCompra,
      DesDestino : String;
      QtdEtiquetas,
      EtiInicial : Integer;
      Produtos,
      EtiPequenas : TList;
      constructor cria;
      destructor destroy;override;
      function AddEtiPequena : TRBDETiPequena;
end;

Type TRBDNotaFiscalForServico = class
  public
    CodServico,
    CodFiscal,
    CodCFOP : Integer;
    CodClassificacao,
    NomServico,
    DesAdicional : String;
    QtdServico,
    ValUnitario,
    ValTotal,
    PerISSQN : Double;
    Constructor cria;
    destructor destroy;override;

end;

Type
  TRBDNotaFiscalForItem = class
    public
      CodFilial,
      SeqNota,
      SeqProduto,
      CodCor,
      CodTamanho,
      CodPrincipioAtivo,
      QtdEtiquetas,
      SeqEstoqueBarra,
      CodCFOP   :Integer;
      CodProduto,
      CodClassificacaoFiscal,
      CodClassificacaoFiscalOriginal,
      CodCST,
      NomProduto,
      DesCor,
      DesTamanho,
      UM,
      UMAnterior,
      UMOriginal,
      DesNumSerie,
      DesReferenciaFornecedor,
      DesRegistroMSM :String;
      QtdProduto,
      QtdChapa,
      LarChapa,
      ComChapa,
      ValUnitario,
      ValTotal,
      ValVenda,
      ValRevenda,
      ValNovoVenda,
      ValBaseST,
      ValBaseIcms,
      ValICMS,
      ValST,
      ValFrete,
      ValOutrasDespesas,
      ValDesconto,
      PerAcrescimoST,
      PerIPI,
      PerICMS,
      PerReducaoBaseICMS,
      PerMVAAnterior,
      PerMVA,
      PerMVAAjustado,
      EspessuraAco,
      DensidadeVolumetricaAco : Double;
      IndMedicamentoControlado,
      IndProdutoAtivo  : Boolean;
      UnidadeParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDNotaFiscalFor = class
    public
      CodFilial,
      SeqNota,
      NumNota,
      SeqNatureza,
      CodFornecedor,
      CodFormaPagamento,
      CodTransportadora,
      CodVendedor,
      CodCondicaoPagamento,
      CodUsuario: Integer;
      SerNota,
      CodNatureza,
      CodModeloDocumento,
      TipFormaPagamento,
      DesObservacao,
      NomFornecedor,
      CGC_CPFFornecedor : String;
      DNaturezaOperacao : TRBDNaturezaOperacao;
      ValTotal,
      ValTotalProdutos,
      ValFrete,
      ValSeguro,
      ValDesconto,
      ValDescontoCalculado,
      ValICMS,
      ValICMSSubstituicao,
      ValBaseICMSSubstituicao,
      ValBaseICMS,
      ValIPI,
      ValTotalServicos,
      ValICMSSuperSimples,
      ValOutrasDespesas,
      PerICMSSuperSimples,
      PerComissao,
      PerDesconto : Double;
      IndNotaDevolucao,
      IndFreteEmitente,
      IndGerouEstoqueChapa,
      IndOrigemPedidoCompra  : Boolean;
      DatEmissao,
      DatRecebimento : TDateTime;
      ItensNota,
      ItensServicos : TList;
      constructor cria;
      destructor destroy;override;
      function AddNotaItem : TRBDNotaFiscalForItem;
      function AddNotaServico: TRBDNotaFiscalForServico;
end;

Type
  TRBDMovEstoque = class
    public
      CodFilial,
      LanEstoque,
      SeqProduto,
      CodCor,
      CodTamanho,
      CodOperacaoEstoque,
      SeqNotaEntrada,
      SeqNotaSaida,
      NumNota,
      LanOrcamento : Integer;
      TipMovimento,
      CodUnidade : String;
      QtdProduto,
      ValMovimento,
      ValCusto : Double;
      DatMovimento : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDInventarioItem = class
    public
      SeqProduto,
      CodCor,
      CodTamanho,
      CodUsuario : Integer;
      CodProduto,
      NomProduto,
      NomCor,
      NomTamanho,
      NomUsuario,
      UM,
      UMOriginal : String;
      QtdProduto : Double;
      UnidadesParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDInventarioCorpo = class
    public
      CodFilial,
      CodUsuario,
      SeqInventario : Integer;
      CodClassificacao : String;
      ItemsInventario : TList;
      constructor cria;
      destructor destroy;override;
      function AddInventarioItem : TRBDInventarioItem;
end;

Type
  TRBDEtiquetaProduto = class
    public
      Produto : TRBDProduto;
      CodCor,
      QtdOriginalEtiquetas,
      QtdEtiquetas,
      QtdProduto,
      NumPedido : Integer;
      DesCodBarras,
      CodBarras,
      NomCor,
      NomComposicao,
      NumSerie,
      Cliente : String;
      IndParaEstoque : Boolean;
      constructor cria;
      destructor destroy;override;
end;


implementation

Uses FunObjeto;

{******************************************************************************}
constructor TRBDOrcamentoCompraProduto.Cria;
begin
  inherited create;
  IndArquivoProjetoLocalizado := false;
end;

{******************************************************************************}
destructor TRBDOrcamentoCompraProduto.Destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBOrcamentoCompraCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrcamentoCompraFornecedor.cria;
begin
  inherited create;
  ProdutosAdicionados := TList.create;
  ProdutosNaoAdicionados := TList.Create;
end;

{******************************************************************************}
destructor TRBDOrcamentoCompraFornecedor.destroy;
begin
  FreeTObjectsList(ProdutosAdicionados);
  ProdutosAdicionados.free;
  FreeTObjectsList(ProdutosNaoAdicionados);
  ProdutosNaoAdicionados.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDOrcamentoCompraFornecedor.addProdutoAdicionado : TRBDOrcamentoCompraProduto;
begin
  Result := TRBDOrcamentoCompraProduto.Cria;
  ProdutosAdicionados.add(result);
end;

{******************************************************************************}
function TRBDOrcamentoCompraFornecedor.addProdutoNaoAdicionado : TRBDOrcamentoCompraProduto;
begin
  result := TRBDOrcamentoCompraProduto.Cria;
  ProdutosNaoAdicionados.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBOrcamentoCompraCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrcamentoCompraCorpo.cria;
begin
  inherited create;
  Produtos := TList.create;
  FracaoOP := TList.create;
  Fornecedores := TList.Create;
  SolicitacoesCompra := TList.Create;
end;

{******************************************************************************}
destructor TRBDOrcamentoCompraCorpo.destroy;
begin
  FreeTObjectsList(Produtos);
  Produtos.free;
  FreeTObjectsList(FracaoOP);
  FracaoOP.free;
  FreeTObjectsList(Fornecedores);
  Fornecedores.free;
  SolicitacoesCompra.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDOrcamentoCompraCorpo.addFracao: TRBDOrcamentoCompraFracaoOP;
begin
  result := TRBDOrcamentoCompraFracaoOP.Cria;
  FracaoOP.Add(result);
end;

{******************************************************************************}
function TRBDOrcamentoCompraCorpo.addProduto : TRBDOrcamentoCompraProduto;
begin
  result := TRBDOrcamentoCompraProduto.Cria;
  Produtos.add(result);
end;

{******************************************************************************}
function TRBDOrcamentoCompraCorpo.addFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  Result := TRBDOrcamentoCompraFornecedor.cria;
  Fornecedores.add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBMOVIMENTACAOESTOQUE
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDMovimentacaoEstoque.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDMovimentacaoEstoque.destroy;
begin
  inherited destroy;
end;



{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBPLANOCORTEITEM
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPlanoCorteFracao.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPlanoCorteFracao.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBPLANOCORTEITEM
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPlanoCorteItem.cria;
begin
  inherited create;
  Fracoes := TList.Create;
end;

{******************************************************************************}
destructor TRBDPlanoCorteItem.destroy;
begin
  FreeTObjectsList(Fracoes);
  Fracoes.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDPlanoCorteItem.AddFracao : TRBDPlanoCorteFracao;
begin
  result :=  TRBDPlanoCorteFracao.cria;
  Fracoes.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBPLANOCORTECORPO
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPlanoCorteCorpo.cria;
begin
  inherited create;
  Itens := TList.create;
end;

{******************************************************************************}
destructor TRBDPlanoCorteCorpo.destroy;
begin
  FreeTObjectsList(Itens);
  Itens.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDPlanoCorteCorpo.AddPlanoCorteItem : TRBDPlanoCorteItem ;
begin
  result := TRBDPlanoCorteItem.cria;
  Itens.add(result);
  Result.SeqItem := Itens.Count;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBPRODUTOPENDENTEMETALVIDROS
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrcamentoProdutoPendenteMetalVidros.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDOrcamentoProdutoPendenteMetalVidros.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBPRODUTOPENDENTEMETALVIDROS
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoPendenteMetalVidros.cria;
begin
  inherited create;
  Orcamentos := TList.Create;
end;

{******************************************************************************}
destructor TRBDProdutoPendenteMetalVidros.destroy;
begin
  FreeTObjectsList(Orcamentos);
  Orcamentos.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDProdutoPendenteMetalVidros.AddOrcamentoProdutoPendente(VpaDatEntrega : TDateTime) : TRBDOrcamentoProdutoPendenteMetalVidros;
var
  VpfLaco : Integer;
  VpfInseriu : Boolean;
begin
  result := TRBDOrcamentoProdutoPendenteMetalVidros.cria;
  result.DatEntrega := VpaDatEntrega;
  VpfInseriu := false;
  for VpfLaco := 0 to Orcamentos.Count - 1 do
  begin
    if VpaDatEntrega < TRBDOrcamentoProdutoPendenteMetalVidros(Orcamentos.Items[VpfLaco]).DatEntrega then
    begin
      Orcamentos.Insert(VpfLaco,result);
      VpfInseriu := true;
      break;
    end;
  end;
  if not VpfInseriu then
    Orcamentos.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrdemCorteItem.cria;
begin
  inherited create;
  DMaquina := TRBDMaquina.cria;
end;

{******************************************************************************}
destructor TRBDOrdemCorteItem.destroy;
begin
  DMaquina.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrdemCorte.cria;
begin
  inherited create;
  Itens := TList.create;
end;

{******************************************************************************}
destructor TRBDOrdemCorte.destroy;
begin
  FreeTObjectsList(Itens);
  Itens.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDOrdemCorte.AddCorteItem : TRBDOrdemCorteItem;
begin
  result := TRBDOrdemCorteItem.cria;
  Itens.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPesoCartucho.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPesoCartucho.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOperacaoEstoque.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDOperacaoEstoque.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            TRBDBaixaConsumoProduto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDGerarOP.cria;
begin
  inherited create;
  Compose := TList.Create;
end;

{******************************************************************************}
destructor TRBDGerarOP.destroy;
begin
  FreeTObjectsList(Compose);
  Compose.free;
  inherited destroy;
end;



{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            TRBDBaixaConsumoProduto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDConsumoFracaoOP.Cria;
begin
  inherited Create;
  IndExcluir := false;
end;

{******************************************************************************}
destructor TRBDConsumoFracaoOP.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe do Bastidor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDBastidor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDBastidor.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe da Faca
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDMaquina.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDMaquina.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe da Faca
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFaca.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFaca.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe do produto reserva
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

constructor TRBDProdutoReserva.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoReserva.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe do servico fixo da amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDServicoFixoAmostra.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDServicoFixoAmostra.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe do consumo amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDConsumoAmostra.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.create;
  Faca := TRBDFaca.cria;
  Maquina := TRBDMaquina.cria;
end;

{******************************************************************************}
destructor TRBDConsumoAmostra.destroy;
begin
  UnidadeParentes.free;
  Faca.free;
  Maquina.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe da amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAmostra.cria;
begin
  inherited create;
  Quantidades := TList.Create;
  ValoresVenda := TList.Create;
  PrecosClientes := TList.create;
  ItensEspeciais := TList.Create;
  Processos := TList.Create;
  DCor := TRBDCorAmostra.cria;
end;

{******************************************************************************}
destructor TRBDAmostra.destroy;
begin
  FreeTObjectsList(Quantidades);
  Quantidades.free;
  FreeTObjectsList(ValoresVenda);
  ValoresVenda.free;
  FreeTObjectsList(PrecosClientes);
  PrecosClientes.free;
  FreeTObjectsList(ItensEspeciais);
  ItensEspeciais.Free;
  FreeTObjectsList(Processos);
  Processos.Free;
  DCor.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDAmostra.addItemEspecial: TRBDItensEspeciaisAmostra;
begin
  result := TRBDItensEspeciaisAmostra.cria;
  ItensEspeciais.Add(result);
end;

{******************************************************************************}
function TRBDAmostra.addPrecoCliente: TRBDPrecoClienteAmostra;
begin
  result := TRBDPrecoClienteAmostra.cria;
  PrecosClientes.add(result);
end;

{******************************************************************************}
function TRBDAmostra.addProcesso: TRBDAmostraProcesso;
begin
  result := TRBDAmostraProcesso.cria;
  Processos.Add(Result);
end;

{******************************************************************************}
function TRBDAmostra.addQuantidade: TRBDQuantidadeAmostra;
begin
  result := TRBDQuantidadeAmostra.cria;
  Quantidades.Add(result);
end;

{******************************************************************************}
function TRBDAmostra.addValorVenda: TRBDValorVendaAmostra;
begin
  result := TRBDValorVendaAmostra.cria;
  ValoresVenda.add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               TRBDProdutoAcessorio
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoAcessorio.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoAcessorio.destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               TRBDProdutoFornecedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDProdutoFornecedor.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDProdutoFornecedor.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe do cartucho cotacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCartuchoCotacao.cria;
begin
  inherited create;
  SeqProduto := 0;
end;

{******************************************************************************}
destructor TRBDCartuchoCotacao.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe do tipo da cotacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDTipoCotacao.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTipoCotacao.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe do estagio da ordem de producao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCelulaAgenda.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCelulaAgenda.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe do estagio da ordem de producao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAgendaPCP.cria;
begin
  inherited create;
  CelulasTrabalho := TList.Create;
end;

{******************************************************************************}
destructor TRBDAgendaPCP.destroy;
begin
  FreeTObjectsList(CelulasTrabalho);
  CelulasTrabalho.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDAgendaPCP.addCelulaAgenda : TRBDCelulaAgenda;
begin
  result := TRBDCelulaAgenda.cria;
  CelulasTrabalho.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe do estagio da ordem de producao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDHorarioCelula.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDHorarioCelula.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe do estagio da ordem de producao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDEstagioCelula.cria;
begin
  inherited;
  IndPrincipal := true;
end;

{******************************************************************************}
destructor TRBDEstagioCelula.destroy;
begin
  inherited;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe da impressao da baixa parcial do orcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCelulaTrabalho.cria;
begin
  inherited;
  Estagios := TList.create;
  Horarios := TList.Create;
end;

{******************************************************************************}
Destructor TRBDCelulaTrabalho.destroy;
begin
  FreeTObjectsList(Estagios);
  FreeTObjectsList(Horarios);
  Estagios.free;
  Horarios.free;
  inherited;
end;

{******************************************************************************}
Function TRBDCelulaTrabalho.addEstagio : TRBDEstagioCelula;
begin
  result := TRBDEstagioCelula.Cria;
  Estagios.add(result);
end;

{******************************************************************************}
function TRBDCelulaTrabalho.addHorario : TRBDHorarioCelula;
begin
  result := TRBDHorarioCelula.Cria;
  Horarios.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe da impressao da baixa parcial do orcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoOrcParcial.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoOrcParcial.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Dados da classe da impressao da baixa parcial do orcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrcamentoParcial.cria;
begin
  inherited create;
  Produtos := TList.Create;
end;

{******************************************************************************}
destructor TRBDOrcamentoParcial.destroy;
begin
  FreeTObjectsList(Produtos);
  Produtos.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                Dados da classe da impressao da fatura da nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDImpressaoFaturaNotaFiscal.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDImpressaoFaturaNotaFiscal.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Dados da classe dos produtos da nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDNotaFiscalServico.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDNotaFiscalServico.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Dados da classe dos produtos da nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDNotaFiscalProduto.AddProdutoPeca: TRBDProdutoClientePeca;
begin
  result := TRBDProdutoClientePeca.cria;
  ProdutoPeca.Add(result);
end;

{******************************************************************************}
constructor TRBDNotaFiscalProduto.cria;
begin
  inherited create;
  ProdutoPeca:= TList.Create;
end;

{******************************************************************************}
destructor TRBDNotaFiscalProduto.destroy;
begin
  inherited destroy;
  FreeTObjectsList(ProdutoPeca);
  ProdutoPeca.Free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da classe da nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDNotaFiscal.cria;
begin
  inherited create;
  TipNota := tnNormal;
  Produtos := TList.Create;
  Servicos := TList.Create;
  Faturas := TList.Create;
  ParcelasSinal := TList.create;
  DesObservacao := TStringList.create;
  DesDadosAdicinais := TStringList.Create;
  DesDadosAdicionaisImpressao := TStringList.create;
  IndMostrarParcelas := true;
  IndGerouFinanceiroOculto := false;
  IndNotaVendaConsumidor := false;
  IndNotaInutilizada := false;
end;

{******************************************************************************}
destructor TRBDNotaFiscal.destroy;
begin
  FreeTObjectsList(Produtos);
  FreeTObjectsList(Servicos);
  FreeTObjectsList(Faturas);
  FreeTObjectsList(ParcelasSinal);
  ParcelasSinal.Free;
  Produtos.Free;
  Faturas.free;
  DesDadosAdicinais.free;
  DesDadosAdicionaisImpressao.free;
  DesObservacao.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDNotaFiscal.AddParcelaSinal: TRBDParcelaSinal;
begin
  result := TRBDParcelaSinal.cria;
  ParcelasSinal.Add(result);
end;

{******************************************************************************}
function TRBDNotaFiscal.AddProduto : TRBDNotaFiscalProduto;
begin
  result := TRBDNotaFiscalProduto.cria;
  Produtos.Add(result);
  if config.SimplesFederal and config.EmiteNFe then
  begin
    Result.CodCST := '041';
  end;
end;

{******************************************************************************}
function TRBDNotaFiscal.AddServico : TRBDNotafiscalServico;
begin
  result := TRBDNotaFiscalServico.cria;
  Servicos.add(result);
end;

{******************************************************************************}
function TRBDNotaFiscal.AddFatura : TRBDImpressaoFaturaNotaFiscal;
begin
  result := TRBDImpressaoFaturaNotaFiscal.cria;
  Faturas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe Coleta Romaneio
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDColetaRomaneioOp.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe Coleta Fracao OP
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDColetaFracaoOp.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe Ordem de produção Geral
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDordemProducaoEstagio.cria;
begin
  inherited;
  IndProducaoInterna := 'I';
  IndFinalizado := false;
  IndTerceirizado := false;
end;

{******************************************************************************}
destructor TRBDordemProducaoEstagio.destroy;
begin
  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe Ordem de produção Item Cadarco
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOPItemMaquina.cria;
begin
  inherited;
end;

{******************************************************************************}
destructor TRBDOPItemMaquina.destroy;
begin
  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe Ordem de produção Item Cadarco
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOPItemCadarco.cria;
begin
  inherited;
  IndAlgodao := 'N';
  IndPoliester := 'N';
  NroMaquinas := 1;
  Maquinas := TList.Create;
end;

{******************************************************************************}
destructor TRBDOPItemCadarco.destroy;
begin
  FreeTObjectsList(Maquinas);
  Maquinas.free;
  inherited;
end;

{******************************************************************************}
function TRBDOPItemCadarco.addMaquina : TRBDOPItemMaquina;
begin
  result := TRBDOPItemMaquina.cria;
  Maquinas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Acoes da classe ESTAGIOFRACAOOPREAL
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDEstagioFracaoOPReal.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEstagioFracaoOPReal.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Acoes da classe REVISAOFracaoFaccionista
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRevisaoFracaoTerceiroFaccionista.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDRevisaoFracaoTerceiroFaccionista.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Acoes da classe REVISAOFracaoFaccionista
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDRevisaoFracaoFaccionista.Cria;
begin
  inherited create;
  Terceiros := TList.create;
end;

{******************************************************************************}
destructor TRBDRevisaoFracaoFaccionista.destroy;
begin
  FreeTObjectsList(Terceiros);
  Terceiros.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDRevisaoFracaoFaccionista.AddTerceiro : TRBDRevisaoFracaoTerceiroFaccionista;
begin
  result := TRBDRevisaoFracaoTerceiroFaccionista.cria;
  Terceiros.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Acoes da classe DevolucaoFracaoFaccionista
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDDevolucaoFracaoFaccionista.Cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDDevolucaoFracaoFaccionista.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Acoes da classe RetornoFracaoFaccionista
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDRetornoFracaoFaccionista.Cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDRetornoFracaoFaccionista.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Acoes da classe FracaoFaccionista
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDFracaoFaccionista.Cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFracaoFaccionista.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Acoes da classe FracaoOrdemProducao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFracaoOrdemProducao.cria;
begin
  inherited create;
  Estagios := TList.Create;
  Compose := TList.Create;
  Consumo := TList.create;
  IndEstagiosCarregados := false;
  IndEstagioGerado := false;
  IndPlanoCorte := false;
  IndFracaoNova := false;
  IndPossuiEmEstoque := false;
  IndProducaoemSerie := false;
  QtdCelula := 1;
  SeqFracao := 0;
end;

{******************************************************************************}
destructor TRBDFracaoOrdemProducao.destroy;
begin
  FreeTObjectsList(Estagios);
  Estagios.free;
  FreeTObjectsList(Compose);
  Compose.free;
  FreeTObjectsList(Consumo);
  Consumo.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFracaoOrdemProducao.AddEstagio : TRBDordemProducaoEstagio;
begin
 result := TRBDordemProducaoEstagio.cria;
 Estagios.add(result);
end;

{******************************************************************************}
function TRBDFracaoOrdemProducao.addConsumo : TRBDConsumoOrdemProducao;
begin
  result := TRBDConsumoOrdemProducao.cria;
  Consumo.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Ordem de corte
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrdemSerra.cria;
begin
  inherited create;
  Fracoes := TList.Create;
end;

{******************************************************************************}
destructor TRBDOrdemSerra.destroy;
begin
  Fracoes.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Ordem de produção
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDConsumoOrdemProducao.cria;
begin
  inherited create;
  IndOrigemCorte := false;
  IndMaterialExtra := false;
end;

{******************************************************************************}
destructor TRBDConsumoOrdemProducao.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Ordem de produção
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrdemProducao.cria;
begin
  inherited;
  Estagios := TList.create;
  Fracoes := TList.Create;
  Consumo := TList.create;
  OrdensSerra := TList.Create;
  ProdutosSubmontagemAgrupados := TList.create;
  DProduto := TRBDProduto.cria;
  OrdemCorte := TRBDOrdemCorte.cria;
  QtdFracoes := 1;
  SeqOrdemaAdicionar := 0;
end;

{******************************************************************************}
destructor TRBDOrdemProducao.destroy;
begin
  FreeTObjectsList(Estagios);
  Estagios.free;
  FreeTObjectsList(Fracoes);
  Fracoes.free;
  FreeTObjectsList(Consumo);
  Consumo.free;
  FreeTObjectsList(OrdensSerra);
  OrdensSerra.free;
  FreeTObjectsList(ProdutosSubmontagemAgrupados);
  ProdutosSubmontagemAgrupados.Free;
  DProduto.free;
  OrdemCorte.free;
  inherited;
end;

{******************************************************************************}
function TRBDOrdemProducao.AddFracao : TRBDFracaoOrdemProducao;
begin
  result := TRBDFracaoOrdemProducao.cria;
  Fracoes.add(result);
  if SeqOrdemaAdicionar <> 0 then
  begin
    inc(SeqUltimaFracao);
    Result.SeqFracao := SeqUltimaFracao;
  end
  else
    Result.SeqFracao := Fracoes.Count;
end;

{******************************************************************************}
function TRBDOrdemProducao.AddConsumo : TRBDConsumoOrdemProducao;
begin
  result := TRBDConsumoOrdemProducao.cria;
  Consumo.add(result);
end;

{******************************************************************************}
function TRBDOrdemProducao.AddOrdemSerra : TRBDOrdemSerra;
begin
  result := TRBDOrdemSerra.cria;
  OrdensSerra.add(Result);
  Result.SeqOrdemSerra := OrdensSerra.Count;
end;

{******************************************************************************}
function TRBDOrdemProducao.AddProdutoAgrupadoSubmontagem: TRBDOrdemProducaoProduto;
begin
  result := TRBDOrdemProducaoProduto.cria;
  ProdutosSubmontagemAgrupados.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Ordem de Etiqueta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
constructor TRBDOrdemProducaoEtiqueta.cria;
begin
  inherited;
  Items := TList.Create;
  ItemsCadarco := TList.Create;
end;

{******************************************************************************}
destructor TRBDOrdemProducaoEtiqueta.destroy;
begin
  FreeTObjectsList(Items);
  FreeTObjectsList(ItemsCadarco);
  Items.free;
  ItemsCadarco.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDOrdemProducaoEtiqueta.AddItems : TRBDOrdemProducaoItem;
begin
  result := TRBDOrdemProducaoItem.Create;
  result.SeqItem := 0;
  Items.add(result);
end;

{******************************************************************************}
function TRBDOrdemProducaoEtiqueta.AddItemsCadarco : TRBDOPItemCadarco;
begin
  result := TRBDOPItemCadarco.cria;
  ItemsCadarco.Add(result);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe COLETAOP
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDColetaOPItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDColetaOPItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe COLETAOP
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDColetaOP.cria;
begin
  inherited create;
  ItensColeta := TList.create;
  SeqColeta := 0;
end;

{******************************************************************************}
destructor TRBDColetaOP.destroy;
begin
  FreeTObjectsList(ItensColeta);
  ItensColeta.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDColetaOP.AddItemColeta : TRBDColetaOPItem;
begin
  result := TRBDColetaOPItem.cria;
  ItensColeta.Add(result);
end;
{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Combinacao Figura
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCombinacaoFigura.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Combinacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

Constructor TRBDCombinacao.Cria;
begin
  inherited create;
  Figuras := TList.Create;
end;

{******************************************************************************}
destructor TRBDCombinacao.destroy;
begin
  FreeTObjectsList(Figuras);
  Figuras.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDCombinacao.AddFigura : TRBDCombinacaoFigura;
begin
  result := TRBDCombinacaoFigura.cria;
  Figuras.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Dados da classe do consumo de Materia Prima
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDConsumoMPBastidor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDConsumoMPBastidor.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Dados da classe do consumo de Materia Prima
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDConsumoMP.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.Create;
  Faca:= TRBDFaca.cria;
  Maquina:= TRBDMaquina.cria;
  Bastidores := TList.create;
end;

{******************************************************************************}
destructor TRBDConsumoMP.destroy;
begin
  UnidadeParentes.free;
  Faca.Free;
  Maquina.Free;
  FreeTObjectsList(Bastidores);
  Bastidores.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDConsumoMP.addBastidor : TRBDConsumoMPBastidor;
begin
  result := TRBDConsumoMPBastidor.cria;
  Bastidores.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Dados da classe dos estagios do produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDEstagioProduto.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEstagioProduto.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProduto.cria;
begin
  inherited create;
  Combinacoes := TList.Create;
  CombinacoesCadarcoTear := TList.create;
  ConsumosMP := TList.Create;
  Estagios := TList.create;
  Fornecedores:= TList.Create;
  Acessorios := TList.create;
  FilialFaturamento:= TList.Create;
  FigurasComposicao := TList.Create;
  TabelaPreco := TList.Create;
  InstalacaoTear :=  TList.Create;
  FiosOrcamentoCadarco := TList.Create;
  DInstalacaoCorTear := TRBDProdutoCorInstalacaoTear.cria;
end;

{******************************************************************************}
destructor TRBDProduto.destroy;
begin
  FreeTObjectsList(Combinacoes);
  FreeTObjectsList(CombinacoesCadarcoTear);
  FreeTObjectsList(ConsumosMP);
  FreeTObjectsList(Estagios);
  FreeTObjectsList(Fornecedores);
  FreeTObjectsList(Acessorios);
  FreeTObjectsList(FilialFaturamento);
  FreeTObjectsList(FigurasComposicao);
  FreeTObjectsList(TabelaPreco);
  FreeTObjectsList(InstalacaoTear);
  FreeTObjectsList(FiosOrcamentoCadarco);
  ConsumosMP.free;
  Combinacoes.free;
  Estagios.free;
  Fornecedores.Free;
  Acessorios.free;
  FilialFaturamento.Free;
  TabelaPreco.free;
  FigurasComposicao.Free;
  DInstalacaoCorTear.Free;
  CombinacoesCadarcoTear.free;
  InstalacaoTear.Free;
  FiosOrcamentoCadarco.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDProduto.AddCombinacao:TRBDCombinacao;
begin
  Result := TRBDCombinacao.cria;
  Combinacoes.add(result);
end;

{******************************************************************************}
function TRBDProduto.AddCombinacaoCadarcoTear: TRBDCombinacaoCadarcoTear;
begin
  result := TRBDCombinacaoCadarcoTear.cria;
  CombinacoesCadarcoTear.add(Result);
end;

{******************************************************************************}
function TRBDProduto.AddConsumoMP : TRBDConsumoMP;
begin
  result := TRBDConsumoMP.cria;
  ConsumosMP.Add(result);
end;

{******************************************************************************}
function TRBDProduto.AddEstagio : TRBDEstagioProduto;
begin
  result := TRBDEstagioProduto.cria;
  Estagios.add(result);
end;

{******************************************************************************}
function TRBDProduto.AddFilialFaturamento: TRBDFilialFaturamento;
begin
  Result := TRBDFilialFaturamento.cria;
  FilialFaturamento.Add(result);
end;

{******************************************************************************}
function TRBDProduto.addFioOrcamentoCadarco: TRBDProdutoFioOrcamentoCadarco;
begin
  Result := TRBDProdutoFioOrcamentoCadarco.cria;
  FiosOrcamentoCadarco.Add(result);
end;

{******************************************************************************}
function TRBDProduto.AddFornecedor: TRBDProdutoFornecedor;
begin
  Result:= TRBDProdutoFornecedor.cria;
  Fornecedores.Add(Result);
end;

{******************************************************************************}
function TRBDProduto.AddInstalacaoTear: TRBDProdutoInstalacaoTear;
begin
  result := TRBDProdutoInstalacaoTear.cria;
  InstalacaoTear.Add(result);
end;

{******************************************************************************}
function TRBDProduto.AddTabelaPreco: TRBDProdutoTabelaPreco;
begin
  Result := TRBDProdutoTabelaPreco.cria;
  TabelaPreco.add(result);
end;

{******************************************************************************}
function TRBDProduto.AddAcessorio : TRBDProdutoAcessorio;
begin
  Result := TRBDProdutoAcessorio.cria;
  Acessorios.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Compose
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrcCompose.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDOrcCompose.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Servico
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrcServico.cria;
begin
  inherited create;
  CodServico := 0;
  QtdServico :=0;
  ValUnitario :=0;
  ValTotal := 0;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrcProduto.cria;
begin
  inherited create;
  Compose := TList.create;
  CodProduto := '';
  CodCor := 0;
  QtdBaixadoNota := 0;
  QtdBaixadoEstoque := 0;
  IndImpFoto := 'N';
  IndFaturar := false;
  IndRetornavel := false;
  IndBrinde := false;
  IndMedicamentoControlado := false;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDOrcProduto.destroy;
begin
  FreeTObjectsList(Compose);
  Compose.free;
  UnidadeParentes.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDOrcProduto.AddCompose : TRBDOrcCompose;
begin
  result := TRBDOrcCompose.cria;
  Compose.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDOrcamento.cria;
begin
  inherited create;
  BaixasParciais := TList.Create;
  Produtos := TList.create;
  Servicos := TList.create;
  DesObservacao := TStringList.Create;
  Parcelas := TStringList.Create;
  CodPlanoContas := '';
  CodOperacaoEstoque := 0;
  OPImpressa := false;
  IndNumeroBaixado := false;
  IndProcessamentoFrio := false;
  IndCancelado := false;
  IndValoresAlterados := false;
  IndSinalPagamentoGerado := false;
end;

{******************************************************************************}
destructor TRBDOrcamento.destroy;
begin
  FreeTObjectsList(Produtos);
  FreeTObjectsList(Servicos);
  FreeTObjectsList(BaixasParciais);
  BaixasParciais.free;
  Produtos.free;
  Servicos.free;
  DesObservacao.free;
  Parcelas.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDOrcamento.AddProduto : TRBDOrcProduto;
begin
  result := TRBDOrcProduto.cria;
  Produtos.add(result);
end;

{******************************************************************************}
function TRBDOrcamento.AddServico : TRBDOrcServico;
begin
  Result := TRBDOrcServico.cria;
  Servicos.add(result);
end;

{******************************************************************************}
function TRBDOrcamento.addProdutoBaixaParcial : TRBDProdutoOrcParcial;
begin
  result := TRBDProdutoOrcParcial.Cria;
  BaixasParciais.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDEtiCor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEtiCor.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}

constructor TRBDEtiProduto.cria;
begin
  inherited create;
  Cores := TList.Create;
end;

{******************************************************************************}
destructor TRBDEtiProduto.destroy;
begin
  FreeTObjectsList(Cores);
  Cores.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDEtiProduto.AddCor : TRBDEtiCor;
begin
  result := TRBDEtiCor.Cria;
  Cores.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

constructor TRBDEtiModelo1.cria;
begin
  inherited create;
  Produtos := TList.Create;
  EtiPequenas := TList.Create;
end;

{******************************************************************************}
destructor TRBDEtiModelo1.destroy;
begin
  FreeTObjectsList(produtos);
  Produtos.free;
  FreeTObjectsList(EtiPequenas);
  EtiPequenas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDEtiModelo1.AddEtiPequena : TRBDETiPequena;
begin
  result := TRBDEtiPequena.create;
  EtiPequenas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((

)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDNotaFiscalForItem.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.Create;
  IndMedicamentoControlado := false;
end;

{******************************************************************************}
destructor TRBDNotaFiscalForItem.destroy;
begin
  UnidadeParentes.free;
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((

)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDNotaFiscalFor.AddNotaServico: TRBDNotaFiscalForServico;
begin
  result := TRBDNotaFiscalForServico.cria;
  ItensServicos.Add(result);
end;

{******************************************************************************}
constructor TRBDNotaFiscalFor.cria;
begin
  inherited create;
  DNaturezaOperacao := TRBDNaturezaOperacao.cria;
  ItensNota := TList.Create;
  ItensServicos:= TList.Create;
  IndGerouEstoqueChapa := false;
  SeqNota := 0;
end;

{******************************************************************************}
destructor TRBDNotaFiscalFor.destroy;
begin
  DNaturezaOperacao.Free;
  FreeTObjectsList(ItensNota);
  FreeTObjectsList(ItensServicos);
  ItensNota.free;
  ItensServicos.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDNotaFiscalFor.AddNotaItem : TRBDNotaFiscalForItem;
begin
  result := TRBDNotaFiscalForItem.cria;
  ItensNota.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((

)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDMovEstoque.cria;
begin
  inherited;
end;

{******************************************************************************}
destructor TRBDMovEstoque.destroy;
begin
  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Dados da classe do item do inventario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDInventarioItem.cria;
begin
  inherited;
  UnidadesParentes := TStringList.Create;
  CodCor := 0;
  CodTamanho :=0;
end;

{******************************************************************************}
destructor TRBDInventarioItem.destroy;
begin
  UnidadesParentes.free;
  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Dados da classe do inventario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDInventarioCorpo.cria;
begin
  inherited;
  ItemsInventario := TList.Create;
end;

{******************************************************************************}
destructor TRBDInventarioCorpo.destroy;
begin
  FreeTObjectsList(ItemsInventario);
  ItemsInventario.free;
  inherited;
end;

{******************************************************************************}
function TRBDInventarioCorpo.AddInventarioItem : TRBDInventarioItem;
begin
  result := TRBDInventarioItem.cria;
  ItemsInventario.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Dados da classe da impressao da etiqueta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDEtiquetaProduto.cria;
begin
  inherited;
  IndParaEstoque := true;
end;

{******************************************************************************}
destructor TRBDEtiquetaProduto.destroy;
begin
//  Produto.free;
  inherited;
end;
{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Figura GRF
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFiguraGRF.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFiguraGRF.destroy;
begin

  inherited destroy;
end;

{ TRBDFiguraGRF }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Tabela de Preço do Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoTabelaPreco.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoTabelaPreco.destroy;
begin
  inherited destroy;
end;

{ TRBDProdutoTabelaPreco }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Tabela de Preço do Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoInstalacaoTear.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoInstalacaoTear.destroy;
begin

  inherited;
end;
{ TRBDProdutoInstalacaoTear }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Tabela de Preço do Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRepeticaoInstalacaoTear.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDRepeticaoInstalacaoTear.destroy;
begin
  inherited;
end;

{ TRBDRepeticaoInstalacaoTear }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Instalacao do tear
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDProdutoCorInstalacaoTear.AddRepeticoes: TRBDRepeticaoInstalacaoTear;
begin
  Result := TRBDRepeticaoInstalacaoTear.cria;
  Repeticoes.Add(result);
end;

{******************************************************************************}
constructor TRBDProdutoCorInstalacaoTear.cria;
begin
  inherited create;
  Repeticoes := TList.create;
end;

{******************************************************************************}
destructor TRBDProdutoCorInstalacaoTear.destroy;
begin
  FreeTObjectsList(Repeticoes);
  Repeticoes.free;
  inherited destroy;
end;
{ TRBDProdutoCorInstalacaoTear }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Instalacao do tear
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDOrdemProducaoProduto.cria;
begin
  inherited create;
  DProduto := TRBDProduto.Cria;
  Fracoes := TList.create;
end;

{******************************************************************************}
destructor TRBDOrdemProducaoProduto.destroy;
begin
  Fracoes.free;
  DProduto.Free;
  inherited;
end;
{ TRBDOrdemProducaoProduto }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Quantidade da amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDQuantidadeAmostra.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDQuantidadeAmostra.destroy;
begin
  inherited;
end;
{ TRBDQuantidadeAmostra }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados do preco de venda da amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDValorVendaAmostra.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDValorVendaAmostra.destroy;
begin
  inherited;
end;
{ TRBDValorVendaAmostra }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados do preco do cliente da amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPrecoClienteAmostra.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPrecoClienteAmostra.destroy;
begin

  inherited;
end;
{ TRBDPrecoClienteAmostra }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados do preco do cliente da amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCombinacaoCadarcoTear.cria;
begin
  inherited;
end;

{******************************************************************************}
destructor TRBDCombinacaoCadarcoTear.destroy;
begin

  inherited;
end;
{ TRBDCombinacaoCadarcoTear }


{ TRBDItensEspeciaisAmostra }
{******************************************************************************}
constructor TRBDItensEspeciaisAmostra.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDItensEspeciaisAmostra.destroy;
begin

  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados do estoque de chapas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDEStoqueChapa.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEStoqueChapa.destroy;
begin
  inherited;
end;

{ TRBDEStoqueChapa }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados do processo da amostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{ TRBDAmostraProcesso }
{******************************************************************************}
constructor TRBDAmostraProcesso.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDAmostraProcesso.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados do estoque de chapas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ TRBDFracaoOPOrcamentoCompra }

{******************************************************************************}
constructor TRBDOrcamentoCompraFracaoOP.Cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDOrcamentoCompraFracaoOP.Destroy;
begin

  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados do fio orcamento cadarço
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ TRBDProdutoFioOrcamentoCadarco }

{******************************************************************************}
constructor TRBDProdutoFioOrcamentoCadarco.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoFioOrcamentoCadarco.destroy;
begin
  inherited;
end;

{******************************************************************************}
                              { TRBDEtiquetaProdutoOP }
{******************************************************************************}

{******************************************************************************}
constructor TRBDEtiquetaProdutoOP.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEtiquetaProdutoOP.destroy;
begin
  inherited;
end;

{******************************************************************************}
                           { TRBDCorAmostra }
{******************************************************************************}

{******************************************************************************}
function TRBDCorAmostra.addConsumo: TRBDConsumoAmostra;
begin
  result := TRBDConsumoAmostra.cria;
  Consumos.add(result);
end;

{******************************************************************************}
constructor TRBDCorAmostra.cria;
begin
  inherited create;
  Consumos := TList.Create;
end;

{******************************************************************************}
destructor TRBDCorAmostra.destroy;
begin

  FreeTObjectsList(Consumos);
  Consumos.Free;
  inherited destroy;
end;

{ TRBDNotaFiscalForServico }

{******************************************************************************}
constructor TRBDNotaFiscalForServico.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDNotaFiscalForServico.destroy;
begin
  inherited destroy;
end;

{ TRBDFilialFaturamento }

{******************************************************************************}
constructor TRBDFilialFaturamento.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFilialFaturamento.destroy;
begin
  inherited Destroy;
end;

{******************************************************************************}
{ TRBDParcelaSinal }
{******************************************************************************}

{******************************************************************************}
constructor TRBDParcelaSinal.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDParcelaSinal.destroy;
begin

  inherited;
end;

end.
