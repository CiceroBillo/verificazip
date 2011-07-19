unit Constantes;

interface
 uses
   db,Forms, SysUtils, FunValida, classes, dbtables, Menus, Registry, unSistema, UnVersoes ;

const
  CT_DIRETORIOREGEDIT = 'Software\Listeners\SisCorp';






















  CNPJ_CopyLine = '04.724.655/0001-63';
  CNPJ_EmbutidosOlho = '07.137.707/0001-93';
  CNPJ_FarmaciaNova = '82.647.207/0001-17';
  CNPJ_IMPOX = '07.615.955/0001-00';
  CNPJ_LaticiniosPomerode = '04.630.689/0001-99';
  CNPJ_MKJ = '02.538.770/0001-18';
  CNPJ_Reloponto = '81.011.082/0001-71';
  CNPJ_RLP = '00.539.911/0001-91';
  CNPJ_Zumm = '81.331.837/0001-15';
  CNPJ_ZummH = '81.331.837/0002-04';
  CNPJ_Kairos = '83.115.485/0001-96';
  CNPJ_AviamentosJaragua = '05.660.967/0001-13';
  CNPJ_EtikArt = '04.288.847/0001-74';
  CNPJ_VilaReal = '05.826.905/0001-39';
  CNPJ_Cadartex = '05.895.359/0001-98';
  CNPJ_Feldmann = '83.527.101/0001-42';
  CNPJ_MetalVidros = '03.279.333/0001-90';
  CNPJ_Atol = '06.881.153/0001-71';
  CNPJ_WorkFabrica = '03.731.084/0001-21';
  CNPJ_Listeners = '04.216.817/0001-52';
  CNPJ_CorBella = '01.771.374/0001-73';
  CNPJ_RafThel = '85.371.243/0001-99';
  CNPJ_R2 = '09.364.080/0001-39';

type

  TRBDOpcoesPermisaoUsuario = (puAdministrador, puFACompleto, puPLCompleto, puESCompleto, puFICompleto,puCHCompleto, puCRCompleto,
    puFICadastraCR, puFIBaixaCR, puFICadastraCP, puFIBaixaCP, puFIConsultarCPOculto,puPLImprimePedPendentes,puFIEfetuarCobranca, puConsultarCliente,puManutencaoProdutos,
    puPLCadastraCotacao, puPLConsultarCotacao, puPLAlterarCotacao, puPLCancelarCotacao, puPLExcluirCotacao, puPLAlterarExcluirDepoisFaturado,puPLAlterarTipoCotacao,puImprimirPedido,
    puPLGerarNota, puPLGerarCupom, puPLImprimirEtiqueta,puPLUsuarioTelemarketing, puPLSupervisorTelemarketing,
    puClienteCompleto,puProdutoCompleto,puServicoCompleto,puImpressao,puRelatorios,puSomenteProdutos,puSomenteMateriaPrima,
    puVerPrecoVendaProduto,puVerPrecoCustoProduto, puConsultarOP,puFAManutencaoNota, puFAGerarNota,puESAlterarOP, puESCadastrarNotaFiscal, puESManutencaoNotaFiscal,
    puESExcluirOP,puCHCadastrosBasicos,puCHCadastrarChamado,puCHConsultarChamado,puCHGerarCotacao,puCHAlterarChamadoTodosTecnicos,
    puCHAlterarChamadosFinalizados,puESRomaneio,puESCadastrarFaccionista,puESAdicionarFracaoFaccionista,puESConsultarFracaoFaccionista,
    puESExcluirFracaoFaccionista,puESAdicionarRetornoFracaoFaccionista,puESConsultarRetornoFracaoFaccionista,puESExcluirRetornoFracaoFaccionista,
    puESImprimirEtiquetaProduto, puCRSomenteProspectDoVendedor, puESPedidoCompra, puESOrcamentoCompra, 
    puSomenteClientesdoVendedor,puFIBloquearClientes, puVendedorAlteraContrato);

  TRBDPermisaoUsuario = set of TRBDOpcoesPermisaoUsuario;

  TRBDOperacaoCadastro =(ocInsercao,ocEdicao,ocConsulta);
  TRBDOrientacaoPagina =(opRetrato,opPaisagem);
  TRBDFormatoExportacaoFiscal =(feLince,feWKLiscalforDos,feSantaCatarina,feSintegra,feMTFiscal,feWKRadar,feValidaPR);
  TRBTipoImpressoraFiscal = (ifBematech_FI_2,ifDaruamFS600);


  TVariaveis = class
    private
      procedure EscondeMenuItems(VpaMenuItem : TMenuItem;VpaEstado : Boolean);
    public
      VarAux : TQuery;
      CT_AreaX, CT_AreaY : Integer;    // inicio variaveis do basico
      senha,
      usuario : string;
      ParametroBase : String;
      CodigoUsuario,
      CodigoUsuarioSistema : Integer;
      CodRegiaoVenda,
      CodTecnico,
      CodComprador : Integer;
      NomeUsuario,
      NomeComputador,
      CodigosVendedores : string;
      GrupoUsuario : integer;
      PermissoesUsuario : TRBDPermisaoUsuario;
      ServidorSMTP,
      ServidorPop,
      UsuarioSMTP,
      SenhaEmail : String;
      CodDepartamentoFichaTecnica: Integer;

      StatusAbertura : string;
      CodigoEmpresa : integer;
      NomeEmpresa : string;
      NomeFilial,
      RazaoSocialFilial,
      EnderecoFilial,
      CNPJFilial,
      IEFilial,
      CPFResponsavelLegal,
      BairroFilial,
      CepFilial,
      CidadeFilial,
      UFFilial,
      FoneFilial,
      EMailFilial,
      SiteFilial : String;
      CodigoFilial : integer;
      CodigoEmpFil : integer;
      AcaoCancela : boolean;
      MascaraMoeda : string;
      MascaraValor : string;
      DriveFoto : string;
      PathRestauracaoBackup,
      PathVersoes : string;
      PathSybase : string;
      PathBackup : string;
      PathInSig : string;
      ImpressoraRelatorio,
      ImpressoraAlmoxarifado,
      ImpressoraAssitenciaTecnica  : string;
      MoedaBase : integer;
      DataDaMoeda : TdateTime;
      MoedasVazias,
      VersaoSistema : string;
      Decimais,
      DecimaisQtd,
      VersaoBanco : integer;
      SenhaBanco : string;
      TipoBase : integer;
      DiaValBase : integer;
      ImpressoraCheque : integer;
      DiretorioSistema,
      DiretorioFiscais,
      DiretorioTemporarioCrystal : String; // fim das variaveis do basico
      PlanoContasDevolucaoCotacao : String;
      SeqCampanhaTelemarketing,
      SeqCampanhaCadastrarEmail,
      CondicaoPagamentoContrato,
      FormaPagamentoContrato : integer;
      DatSNGPC : TDateTime;
      PortaComunicacaoBalanca : Integer;
      PortaComunicacaoImpTermica,
      PortaComunicacaoImpTermica2 : String;

      //ecf
      TipoECF : TRBTipoImpressoraFiscal;
      ClientePadraoECF,
      CodCondicaoPagamentoECF,
      CodOperacaoEstoqueECF : Integer;
      CodPlanoContasECF : String;

      // produto/estoque
      MascaraQtd : String;
      MascaraValorUnitario : String;
      MascaraCla : string;
      MascaraClaSer : string;
      MascaraPro : string;
      UnidadeCX : string;
      UnidadeUN : string;
      ClassificacaoFiscal : string;
      DiasValidade : integer;  // dias de validade para os orcamentos
      TabelaPreco,
      TabelaPrecoServico : Integer;
      CodigoProduto : string; // guarda o campo do produto, codigo ou campo codigo de barra
      OperacaoEstoqueInicial : integer;
      OperacaoEstoqueEstornoEntrada,
      OperacaoEstoqueEstornoSaida,
      OperacaoAcertoEstoqueEntrada,
      OperacaoAcertoEstoqueSaida,
      OperacaoEstoqueImpressaoEtiqueta : Integer;
      UltimoMesEstoque : integer; // para a sumarizado de estoque,
      UltimoAnoEstoque : integer; // para a sumarizado de estoque,
      UtilizarIpi : Boolean;
      DataUltimoFechamento : TDateTime;//qual foi a data do ultimo fechamento;
      InventarioEntrada,
      InventarioSaida,
      EstagioOrdemProducao,  // estágio inicial da ordem de producao
      EstagioOrdemProducaoAlmoxarifado,
      EstagioAguardandoEntrega,
      EstagioNaEntrega,
      EstagioFinalOrdemProducao,
      EstagioCotacaoAlterada,
      EstagioCotacaoExtornada,
      EstagioBaixaParcialCancelada,
      EstagioAssistenciaTecnica,
      EstagioInicialChamado,
      EstagioChamadoFinalizado,
      EstagioChamadoFaturado,
      EstagioChamadoAguardandoAgendamendo,
      EstagioEnviadoFaccionista,
      EstagioRetornoFaccionista,
      EstagioInicialProposta,
      EstagioAguardandoRecebimentoProposta,
      EstagioPropostaEmNegociacao,
      EstagioPropostaConcluida,
      EstagioInicialCompras,
      EstagioComprasAprovado,
      EstagioComprasAguardandoConfirmacaoRecebFornececedor,
      EstagioComprasAguardandoEntregaFornecedor,
      EstagioFinalCompras,
      EstagioInicialOrcamentoCompra,
      EstagioOrcamentoCompraAprovado,
      TipoCotacao,
      TipoCotacaoPedido,
      TipoCotacaoFaturamentoPosterior,
      TipoCotacaoContrato,
      TipoCotacaoGarantia,
      TipoCotacaoRevenda,
      TipoCotacaoFaturamentoPendente,
      CodTransportadoraVazio,
      CodFilialControladoraEstoque,
      CodVendedorCotacao
      : Integer;
      CodClassificacaoProdutos,
      CodClassificacaoMateriaPrima : String;
      CodClientePadraoCotacao,
      CodTipoCotacaoMaquinaLocal,
      ModeloEtiquetaNotaEntrada,
      ModeloEtiquetaCartuchoToner,
      ModeloEtiquetaCartuchoTinta : Integer;

      //Cartucho
      CodClassificacaoPoTinta,
      CodClassificacaoCilindro,
      CodClassificacaoChip: String;

      // clientes
      SituacaoPadraoCliente: Integer;

      // ecf
      UsarGaveta : string;
      PathRetornoECF : string;
      EstadoPadrao : string;
      TextoPromocional : TStringList;
      CodigoOpeEstEcf : integer;
      TipoComissaoProduto : Integer;
      TipoComissaoServico : Integer;
      BoletoPadraoNota : Integer;
      DadoBoletoPadraoNota : Integer;
      MaiorDescontoPermitido : Integer;
      NaturezaDevolucaoCupom : string;
      NaturezaDevolucaoNotaFiscal : string;
      NaturezaNotaFiscalCupom : string; // quando ultrapassar o desconto maximo da nota
      NaturezaServico : String;
      NaturezaServicoForaEstado,
      NaturezaServicoEProduto,
      NaturezaServicoEProdutoForaEstado : String;
      LayoutECF : integer;
      TamanhoFonteECF : integer;
      FormatoExportacaoFiscal : TRBDFormatoExportacaoFiscal;

      //FISCAL
      ISSQN,
      PerPIS,
      PerCOFINS : Double;
      SerieNota : String;
      PlanoContaEcf : String;
      NaturezaNota,
      NaturezaForaEstado : string;
      NotaFiscalPadrao,
      ClienteDevolucao : Integer;
      PathSintegra,
      PlacaVeiculoNota,
      MarcaEmbalagem : string;
      FretePadraoNF,
      CodTransportadora,
      DocPadraoPedido,
      ContaContabilFornecedor,
      ContaContabilCliente : integer;
      TextoReducaoImposto : String;  // fim das variaveis do fiscais
      ValMinimoFaturamentoAutomatico : Double;

      //financeiro
      Mora : Double;           // inicio das variaveis financeiro
      Juro : Double;
      Multa : double;
      ConsultaPor : Char;
      ContaBancaria,
      ContaBancariaBoleto,
      ContaBancariaContrato : String;
      ChequePre : integer;
      DescontoMaximoNota : Double;
      FilialControladora : Integer;
      SenhaLiberacao : String;    // fim das variaveis do financeiro
      GrupoUsuarioMaster : Integer;
      QtdDiasProtesto : Integer;
      MascaraPlanoConta : string;
      OperacaoBancariaCheque : string;
      FormaPagamentoPadrao,
      FormaPagamentoCarteira,
      FormaPagamentoBoleto,
      FormaPagamentoDinheiro,
      FormaPagamentoDeposito : Integer;
      ClienteFornecedorbancario : Integer;// Baixa da comissao caso seje pagamento parcial
      DocReciboPadrao : Integer;
      PlanoContasBancario,
      PlanoDescontoDuplicata : String;
      CodHistoricoNaoLigado : Integer;
      RodapeECobranca : String;
      emailECobranca : string;
      EmailComercial : string;
      CentroCustoPadrao,
      TipComissao : Integer;

      // caixa
      CaixaPadrao : Integer;  // caixa padrao da impressa
      ValorTolerancia : Double; // valor de tolerância de esouro do caixa - máximo e mínimo.
      OperacaoPagar : Integer; // Código do Tipo de Operação padrao para carregar uma conta a pagar no caixa.
      OperacaoReceber : Integer; // Código do Tipo de Operação padrao para carregar uma conta a receber no caixa.
      CondPagtoVista  : Integer; // Código da condição de pagamento a vista para lançamento no contas a receber atraves do cadastro de mov. bancária.
      SenhaCaixa : string;   // senha de liberacao do caixa

      //Contrato
      MesLocacao,
      AnoLocacao,
      SeqProdutoContrato,
      TipoContratoLocacao : Integer;
      CodProdutoContrato : String;
      DatFimLocacao : TDateTime;
      DatUltimaLeituraLocacao : TDateTime;

      //Assitência Técnica
      CodServicoChamadoCotacao,
      TipoChamadoInstalacao,
      CodPesquisaSatisfacaoChamado,
      CodPesquisaSatisfacaoInstalacao,
      CodTecnicoIndefinido : Integer;
      ValChamado,
      ValKMRodado : Double;

      //CRM
      CRMCorEscuraEmail,
      CRMCorClaraEmail : string;
      CRMTamanhoLogo,
      CRMAlturaLogo,
      CodSetor : Integer;

      //Diversos
      PathRemessaBancaria,           //diretorio onde serao salvos os arquivos de importacao
      PathRelatorios,
      ModemTelemarketing : String;  // diretorio onde serao salvos os arquivos de exportacao;

      //Grafica
      ValAcerto : Double;

      //OrdemProducao
      CodClienteOP : Integer;

      constructor cria;
      destructor destroy;override;
      procedure CarPermissaoUsuario(var VpaDPermissao : TRBDPermisaoUsuario;VpaCodEmpFil, VpaCodGrupoUsuario : String);
      procedure EscondeMenus(VpaMenu : TMenu;VpaEstado : Boolean);
      function RCodigosVendedores(VpaCodUsuario : Integer) : String;
end;

type
  TConfig = Class
//-------------------Geral
    AtualizaPermissao : Boolean; // permite ou naum gravar formularios na tabela de formularios
    CodigoBarras : Boolean; // true utiliza leitor de códio de barras
    EmitirECF : Boolean; //permite a emissao do cupom fiscal;
    Farmacia : Boolean;
    ManutencaoImpressoras : boolean;
    RelogioPonto : Boolean;
    Grafica : Boolean;
    SoftwareHouse : boolean;
    UtilizarPercentualConsulta : Boolean;
    ResponsavelLeituraLocacao : Boolean;


//contratos
    ControlarFaturamentoMinimoContrato,
    ExibirMensagemAntesdeImprimirNotanoFaturamentoMensal,
    NoFaturamentoMensalProcessarFaturamentoPosterior : Boolean;
    EnviarEmailFaturamentoMensal,
    EmitirNotaFaturamentoMensal,
    NoFaturamentoMensalCondPagamentoCliente : Boolean;

//-------------------Produtos
    AvisaIndMoeda : Boolean;       // para moedas, indice vazio - Basico
    AvisaDataAtualInvalida : Boolean;   // para moedas com data desatualizadas - Basico
    AvisaQtdPedido : Boolean;     // avisa se qtd de produtos é = a qtd estoque - Qtd Pedido
    AvisaQtdMinima : Boolean;     // Avisa se qtd de produtos é = a qtd mímima - Qtd Minima
    QtdNegativa : Integer;        // Quantidade negativa de produtos
    VerCodigoProdutos : Boolean; // mostra ou naum o codigo dos produtos na arvore
    MascaraProdutoPadrao  : Boolean; // utiliza mascara padrao do produto..
    CodigoUnicoProduto : Boolean; //Cas true, o codigo do produto e gerado por empresa, senaum por classificacao
    PermiteItemNFEntradaDuplicado : Boolean; // Permite duplicat item de da Nota Fiscal de entrada duplicado
    CadastroEtiqueta,             //No cadastro dos produto mostra os dados técnicos da etiqueta.
    CadastroCadarco  : Boolean;   //No cadastro dos produtos mostra os dados técnicos do cadarço.
    EstoquePorCor,                //Se controla o estoque dos produtos pela cor
    PrecoPorClienteAutomatico,
    ExigirDataEntregaPrevista,
    ExcluirCotacaoQuandoNFCancelada  : Boolean;
    BaixarEstoquePeloConsumoProduto : Boolean;
    NomDesenhoIgualCodigo : Boolean;
    EstoqueCentralizado : Boolean;
    NumeroSerieProduto : Boolean;
    EstoqueFiscal : Boolean;
    ControlarBrinde : Boolean;
    PermiteAlteraNomeProdutonaCotacao : boolean;
    UtilizarClassificacaoFiscalnosProdutos : Boolean;
    ValordeCompraComFrete : Boolean;

//-------------------Financeiro
    CapaLote : Boolean;            // verica capa de lote
    BaixaMovBancario : Boolean;    // permite a baixa bancaria ou não no cad novo contas a pagar
    BaixaCPCadastro : Boolean;     //permite a baixa CP ou não no cad novo contas a pagar
    BaixaCRCadastro : Boolean;     //permite a baixa CR ou não no cad novo contas a receber
    DataVencimentoMenor : Boolean;  // trava data de vencimento menor que a atual
    DataBaixaMenor : Boolean;       // trava a data da baixa menor que a atual
    BaixaParcelaAntVazia : Boolean;  // trava baixa da parcela se anterior estiver vazia
    JurosMultaDoDia : Boolean;  // Identifica o tipo de clculo de juro, da parcela ou atual
    ComissaoDireta  : Boolean;  // para definir somente comissoes direta para os vendedores
    NumeroDuplicata : Boolean; // se true gera o numero da duplicata igual ao da nota senao um sequencial
    NumeroDocumento : Boolean; // se true gera o numero do documento igual ao da duplicata senao um sequencial + parcela = 34/1
    PermitirParcial : Boolean; // permitir gerar parcelas parciais
    AlterarValorUnitarioNota : Boolean ; // se altera o valor unitario na nota fiscal
    DescontoNota : Boolean;  /// Dar desconto na nota
    AlterarValorUnitarioComSenha : Boolean ; // se altera o valor unitario somente com senha;
    AlterarDescontoComSenha : Boolean;
    GerarDespesasFixa : Boolean; // true para gerar despesas fixas, false naum
    AtualizarDespesas : Boolean; // Atualiza despesas fixas
    ConfirmaBancario : Boolean; // Pergunta antes de lançar o movimento bancário.
    FilialControladora :Boolean;// Verifica se existirá uma filial controladora ou seja tudo é pago em uma filal
    LimiteCreditoCliente : Boolean; //Permite o cliente comprar até o limite de crédito.
    BloquearClienteEmAtraso : Boolean; //Bloquear o Cliente que está em atraso
    ImprimirBoletoFolhaBranco : Boolean;
    GerarFinanceiroCotacao : Boolean;
    BaixarEstoqueCotacao : Boolean;
    QuandoFaturarAdicionarnaRemessa : Boolean;
    ECobrancaEnviarAvisoProgramacaoPagamento : Boolean;
    ECobrancaEnviarAvisoPagamentoAtrasado : Boolean;
    ECobrancaEnviarValoresCorrigidos : Boolean;
    CobrarFormaPagamento : Boolean;
    SalvarDataUltimaBaixaCR : Boolean;
    BaixaContasReceberCalcularJuros: Boolean;
    AdicionarRemessaAoImprimirBoleto: Boolean; // adicionar a nota fiscal no arquivo de remessa ao imprimir o boleto bancario

    //-----------------------Cotacao
    ExcluirFinanceiroCotacaoQuandoGeraNota : Boolean;
    RegerarFinanceiroQuandoCotacaoAlterada,
    BaixaQTDCotacaonaNota,
    NaoPermitirAlterarCotacaoAposImpressa,
    TecniconaCotacao,
    MostrarCotacoesSomenteFilialAtiva,
    CopiarTransportadoraPedido : Boolean;
    DataFinanceiroIgualDataCotacao : boolean;
    ImprimeCotacaocomEntregadorSomenteAlmoxarifado : Boolean;
    ImprimirEnvolopeSomentecomNotaFatMensal,
    ImprimirCotacaoFatMensal,
    AlterarCotacaoSomentenoDiaEmissao,
    ObservacaoFiscalNaCotacao,
    PermitirAlterarVendedornaCotacao,
    ExigirCNPJeCEPCotacaoPadrao,
    AlterarCotacaoComOPGerada,
    PermanecerOVendedorDaUltimaVenda,
    EnviaCotacaoEmailTransportadora : Boolean;
    UtilizarTabelaPreconaCotacao : Boolean;
    TransportadoraObrigatorianaCotacao : Boolean;
    DescontoNosProdutodaCotacao : Boolean;
    GerarNotaPelaQuantidadeProdutos,
    EstagioFinalOpparaCotacaoFaturamentoPosterior,
    EstagioFinalOPparaCotacaoTransportadoraVaiza : Boolean;
    PermitirAlterarTipoCotacao : Boolean;
    UtilizarLeitorSeparacaoProduto : Boolean;
    UtilizarCompose : Boolean;
    NaCotacaoBuscaroContato,
    SolicitarSenhaparaCancelarBaixaParcial,
    QuandoGerarFinanceiorMostrarCotacoesNaoFaturadas : Boolean;
    ProdutoPorTamanho : Boolean;
    PermitirGravaCotacaoSemCNPJaVista,
    ObrigarObservacaoNaGarantia : boolean;
    PermitirCancelareExtornarCotacao : Boolean;
    PermitirBaixarNumeroPedido: Boolean;

    //-----------------------Caixa
    VariosCaixasDia : Boolean;  // true permite abrir vários caixas no mesmo dia (um de cada vez).
    LogDireto : Boolean;  // true efetua o log do caixa direto, sem pedir o usuário e a sua senha.
    SenhaAlteracao : Boolean; // utilizar senha de liberacao na alteracao de caixa
    SenhaEstorno : Boolean; // Utilizar senha de liberacao para estorno
    ParcialCaixaDataAnterior : Boolean; // Permitir abrir parcial em um caixa com data retroativa
    itemCaixaDataAnterior : Boolean; // Permitir lancar item em um caixa com data retroativa

    //-----------------------Fiscal
    ImpPorta : Boolean;
    UsaTEF : Boolean; // Usa o TEF discado no sistema
    MostraDadosClienteCupom : Boolean; // permite ou naum mostrar os dados do cliente na emissao do cupom fiscal
    AlterarNroNF : Boolean; // permite alterar o numero da nota fiscal
    AlterarValorNotaCR : Boolean;
    ItemNFSaidaDuplicado : Boolean;// permite duplicar os produtos na nota fiscal de saida
    ImprimirPedEmPreImp: boolean;
    UtilizarTransPedido: boolean;
    OptanteSimples : Boolean;
    NotaFiscalPorFilial : Boolean;
    MostrarNotasDevolvidasnaVenda,
    NaoCopiarObservacaoPedidoNotaFiscal,
    ImprimirNumeroCotacaonaNotaFiscal,
    NaNotaFazerMediaValProdutosDuplicados : Boolean;
    UtilizarNSU,
    SimplesFederal,
    ImprimirnaNotaDescricaoItemNatureza : Boolean;

    //---------------------Ecf
    BaixarEstoqueECF, //baixar o estoque quando gera um cupom direto pela tela de cupom sem estar associado a uma cotação
    GerarFinanceiroECF ,  //Gerar financeiro quando gera um cupom direto pela tela de cupom sem estar associado a uma cotação
    MostrarFormaPagamentoECFGeradoPelaCotacao,
    UtilizarGaveta,
    PassarDescontodaCotacao: Boolean;
    //---------------------cliente
    ExigirCPFCNPJCliente,
    ExigirCEPCliente :Boolean;
    UtilizarMailing : Boolean;

    //---------------------Chamados
    EnviaChamadoEmailTecnico : Boolean;

    //---------------------Ordem de produção
    AgruparProdutosnaOP,
    AdicionarQtdIdealEstoquenaOP : Boolean;

    //------------------------Vendas
    MetaVendedorpelaCarteiradeClientes : Boolean;

    //------------------------Amostras
    ConcluiAmostraNaFichaTecnica: Boolean;

end;

type                             //    tag Nenhum : 0
  TConfigModulo = Class          //    tag Gerais : 1
    Bancario : Boolean;          //    tag Bancario : 2
    Caixa : Boolean;             //    tag Caixa : 3
    Comissao : Boolean;          //    tag Comissao : 4
    ContasAPagar : Boolean;      //    tag ContasAPagar : 5
    ContasAReceber : Boolean;    //    tag ContasAReceber : 6
    Faturamento : Boolean;       //    tag Faturamento : 7
    Fluxo : Boolean;             //    tag Fluxo : 8
    Produto : Boolean;           //    tag Produto : 9
    Custo : Boolean;             //    tag Custo : 10
    Estoque : Boolean;           //    tag Estoque : 11

    Servico : Boolean;
    NotaFiscal : Boolean;
    TEF : Boolean;
    ECF : Boolean;
    CodigoBarra : Boolean;
    Gaveta : Boolean;
    ImpDocumentos : Boolean;
    OrcamentoVenda : Boolean;
    Imp_Exp : Boolean;
    SenhaGrupo : Boolean;
    MalaDiretaCliente : Boolean;
    AgendaHistoricoCliente : boolean;
    PedidoVenda : boolean;
    OrdemServico : boolean;
    TeleMarketing : boolean;
    Faccionista : Boolean;
    Amostra : Boolean;
end;

procedure ConfiguraVideo;
procedure CarregaEmpresaFilial( codEmp, CodEmpFil : integer; DataBase : TDataBase );
procedure CarregaDiretorios;
procedure carregaCFG( DataBase : TDataBase);
function RCodBancoConta(VpaContaCorrente : String) : Integer;
function TipoCheck(flag : string) : Boolean;
function GeraProximoCodigo(VpaCampo, VpaTabelaProximoCod, VpaCampoFilial : string; VpaCodEmpFil : Integer; VpacodSequencial : Boolean ) : Integer;

var
    Varia : TVariaveis;
    Config : TConfig;
    ConfigModulos : TConfigModulo;

implementation

uses
   FunSql, FunArquivos;

{******************************************************************************}
constructor TVariaveis.cria;
begin
  inherited create;
  VarAux := TQuery.Create(nil);
  VarAux.DataBaseName := 'BaseDados';
  PermissoesUsuario := [];
end;

{******************************************************************************}
destructor TVariaveis.destroy;
begin
  VarAux.Free;
  inherited destroy;
end;

{******************************************************************************}
procedure TVariaveis.EscondeMenuItems(VpaMenuItem : TMenuItem;VpaEstado : Boolean);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaMenuItem.Count - 1 do
  begin
    EscondeMenuItems(TMenuItem(VpaMenuItem.Items[VpfLaco]),VpaEstado);
  end;
  VpaMenuItem.Visible := VpaEstado;
end;

{******************************************************************************}
procedure TVariaveis.CarPermissaoUsuario(var VpaDPermissao : TRBDPermisaoUsuario;VpaCodEmpFil, VpaCodGrupoUsuario : String);
begin
  AdicionaSQLAbreTabela(VarAux,'Select * from CADGRUPOS '+
                               ' Where I_EMP_FIL = '+VpaCodEmpFil +
                               ' and I_COD_GRU = '+VpaCodGrupoUsuario);
  VpaDPermissao := [];
  if TipoCheck(VarAux.FieldByName('C_ADM_SIS').AsString) then
    VpaDPermissao := VpaDPermissao + [puAdministrador];
  if TipoCheck(VarAux.FieldByName('C_FIN_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puFICompleto];
  if TipoCheck(VarAux.FieldByName('C_EST_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puESCompleto];
  if TipoCheck(VarAux.FieldByName('C_POL_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLCompleto];
  if TipoCheck(VarAux.FieldByName('C_FAT_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puFACompleto];
  if TipoCheck(VarAux.FieldByName('C_FIN_CCR').AsString) then
    VpaDPermissao := VpaDPermissao + [puFICadastraCR];
  if TipoCheck(VarAux.FieldByName('C_FIN_BCR').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIBaixaCR];
  if TipoCheck(VarAux.FieldByName('C_FIN_CCP').AsString) then
    VpaDPermissao := VpaDPermissao + [puFICadastraCP];
  if TipoCheck(VarAux.FieldByName('C_FIN_BCP').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIBaixaCP];
  if TipoCheck(VarAux.FieldByName('C_FIN_CPO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIConsultarCPOculto];
  if TipoCheck(VarAux.FieldByName('C_POL_IPP').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLImprimePedPendentes];
  if TipoCheck(VarAux.FieldByName('C_FIN_ECO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIEfetuarCobranca];
  if TipoCheck(VarAux.FieldByName('C_GER_COC').AsString) then
    VpaDPermissao := VpaDPermissao + [puConsultarCliente];
  if TipoCheck(VarAux.FieldByName('C_GER_MPR').AsString) then
    VpaDPermissao := VpaDPermissao + [puManutencaoProdutos];
  if TipoCheck(VarAux.FieldByName('C_POL_CCO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLCadastraCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_CAC').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLCancelarCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_ACO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLAlterarCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_VCO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLConsultarCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_ICO').AsString) then
    VpaDPermissao := VpaDPermissao + [puImprimirPedido];
  if TipoCheck(VarAux.FieldByName('C_POL_CGN').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLGerarNota];
  if TipoCheck(VarAux.FieldByName('C_POL_CGC').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLGerarCupom];
  if TipoCheck(VarAux.FieldByName('C_POL_IPE').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLImprimirEtiqueta];
  if TipoCheck(VarAux.FieldByName('C_GER_MCP').AsString) then
    VpaDPermissao := VpaDPermissao + [puProdutoCompleto];
  if TipoCheck(VarAux.FieldByName('C_GER_MCC').AsString) then
    VpaDPermissao := VpaDPermissao + [puClienteCompleto];
  if TipoCheck(VarAux.FieldByName('C_GER_MCS').AsString) then
    VpaDPermissao := VpaDPermissao + [puServicoCompleto];
  if TipoCheck(VarAux.FieldByName('C_GER_IMP').AsString) then
    VpaDPermissao := VpaDPermissao + [puImpressao];
  if TipoCheck(VarAux.FieldByName('C_GER_REL').AsString) then
    VpaDPermissao := VpaDPermissao + [puRelatorios];
  if TipoCheck(VarAux.FieldByName('C_POL_UTE').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLUsuarioTelemarketing];
  if TipoCheck(VarAux.FieldByName('C_POL_STE').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLSupervisorTelemarketing];
  if TipoCheck(VarAux.FieldByName('C_GER_SPA').AsString) then
    VpaDPermissao := VpaDPermissao + [puSomenteProdutos];
  if TipoCheck(VarAux.FieldByName('C_GER_SMP').AsString) then
    VpaDPermissao := VpaDPermissao + [puSomenteMateriaPrima];
  if TipoCheck(VarAux.FieldByName('C_GER_SPA').AsString) then
    VpaDPermissao := VpaDPermissao + [puSomenteProdutos];
  if TipoCheck(VarAux.FieldByName('C_GER_PRV').AsString) then
    VpaDPermissao := VpaDPermissao + [puVerPrecoVendaProduto];
  if TipoCheck(VarAux.FieldByName('C_GER_PRC').AsString) then
    VpaDPermissao := VpaDPermissao + [puVerPrecoCustoProduto];
  if TipoCheck(VarAux.FieldByName('C_EST_COP').AsString) then
    VpaDPermissao := VpaDPermissao + [puConsultarOP];
  if TipoCheck(VarAux.FieldByName('C_FAT_GNO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFAGerarNota];
  if TipoCheck(VarAux.FieldByName('C_FAT_MNO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFAManutencaoNota];
  if TipoCheck(VarAux.FieldByName('C_EST_AOP').AsString) then
    VpaDPermissao := VpaDPermissao + [puESAlterarOP];
  if TipoCheck(VarAux.FieldByName('C_EST_CNF').AsString) then
    VpaDPermissao := VpaDPermissao + [puESCadastrarNotaFiscal];
  if TipoCheck(VarAux.FieldByName('C_EST_MNF').AsString) then
    VpaDPermissao := VpaDPermissao + [puESManutencaoNotaFiscal];
  if TipoCheck(VarAux.FieldByName('C_EST_EOP').AsString) then
    VpaDPermissao := VpaDPermissao + [puESExcluirOP];
  if TipoCheck(VarAux.FieldByName('C_CHA_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHCompleto];
  if TipoCheck(VarAux.FieldByName('C_CHA_CBA').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHCadastrosBasicos];
  if TipoCheck(VarAux.FieldByName('C_CHA_CAC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHCadastrarChamado];
  if TipoCheck(VarAux.FieldByName('C_CHA_COC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHConsultarChamado];
  if TipoCheck(VarAux.FieldByName('C_CHA_GEC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHGerarCotacao];
  if TipoCheck(VarAux.FieldByName('C_CHA_ATC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHAlterarChamadoTodosTecnicos];
  if TipoCheck(VarAux.FieldByName('C_CHA_ACF').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHAlterarChamadosFinalizados];
  if TipoCheck(VarAux.FieldByName('C_POL_ECO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLExcluirCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_AEF').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLAlterarExcluirDepoisFaturado];
  if TipoCheck(VarAux.FieldByName('C_POL_ATC').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLAlterarTipoCotacao];
  if TipoCheck(VarAux.FieldByName('C_EST_ROM').AsString) then
   VpaDPermissao := VpaDPermissao + [puESRomaneio];
  if TipoCheck(VarAux.FieldByName('C_EST_CFA').AsString) then
   VpaDPermissao := VpaDPermissao + [puESCadastrarFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_AFF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESAdicionarFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_CFF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESConsultarFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_EFF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESExcluirFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_ARF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESAdicionarRetornoFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_CRF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESConsultarRetornoFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_ERF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESExcluirRetornoFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_IEP').AsString) then
   VpaDPermissao := VpaDPermissao + [puESImprimirEtiquetaProduto];
  if TipoCheck(VarAux.FieldByName('C_CRM_COM').AsString) then
   VpaDPermissao := VpaDPermissao + [puCRCompleto];
  if TipoCheck(VarAux.FieldByName('C_IND_SCV').AsString) then
   VpaDPermissao := VpaDPermissao + [puSomenteClientesdoVendedor];
  if TipoCheck(VarAux.FieldByName('C_CRM_SPV').AsString) then
   VpaDPermissao := VpaDPermissao + [puCRSomenteProspectDoVendedor];
  if TipoCheck(VarAux.FieldByName('C_EST_PEC').AsString) then
   VpaDPermissao := VpaDPermissao + [puESPedidoCompra];
  if TipoCheck(VarAux.FieldByName('C_FIN_BCL').AsString) then
   VpaDPermissao := VpaDPermissao + [puFIBloquearClientes];
  if TipoCheck(VarAux.FieldByName('C_GER_VAC').AsString) then
   VpaDPermissao := VpaDPermissao + [puVendedorAlteraContrato];
  if TipoCheck(VarAux.FieldByName('C_EST_SCO').AsString) then
   VpaDPermissao := VpaDPermissao + [puESOrcamentoCompra];

  config.UtilizarPercentualConsulta := TipoCheck(VarAux.fieldByName('C_IND_PER').AsString);
  config.ResponsavelLeituraLocacao := TipoCheck(VarAux.fieldByName('C_RES_LEL').AsString);
  VarAux.close;
end;

{******************************************************************************}
procedure TVariaveis.EscondeMenus(VpaMenu : TMenu;VpaEstado : Boolean);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 1 to VpaMenu.Items.Count - 2 do
  begin
    EscondeMenuItems(TMenuItem(VpaMenu.Items.Items[VpfLaco]),VpaEstado);
  end;
end;

{******************************************************************************}
function TVariaveis.RCodigosVendedores(VpaCodUsuario : Integer) : String;
begin
  result := '(0';
  AdicionaSQLAbreTabela(VarAux,'Select CODVENDEDOR from USUARIOVENDEDOR '+
                               ' Where CODUSUARIO = '+IntToStr(VpaCodUsuario));
  while not VarAux.Eof do
  begin
    result := result + ','+VarAux.FieldByname('CODVENDEDOR').AsString;
    VArAux.Next;
  End;
  VarAux.close;
  result := result + ')';
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TipoCheck(flag : string) : Boolean;
begin
  result := true;
  if flag = 'F' then
    result := false;
end;


{******************************************************************************}
procedure configuraVideo;
begin
 if  screen.Height =  600 then
   begin
      Varia.CT_AreaX := 796;
      Varia.CT_AreaY := 470;
   end
   else
     if screen.Height = 480 then
     begin
       Varia.CT_AreaX := 635;
       Varia.CT_AreaY := 350;
     end
     else
     if screen.Height = 768 then
     begin
        Varia.CT_AreaX := 1020;
        Varia.CT_AreaY := 638;
     end;
end;

{************* gera o proximo codigo ***************************************** }
function GeraProximoCodigo(VpaCampo, VpaTabelaProximoCod, VpaCampoFilial : string; VpaCodEmpFil : Integer; VpacodSequencial : Boolean ) : Integer;
var
 Vpftabela : TQuery;
 VpfCodigo : integer;
begin
  //cria e abre a tabela de codigos
  Vpftabela := TQuery.Create(nil);
  Vpftabela.DatabaseName := 'BaseDados';
  Vpftabela.RequestLive := true;
  AdicionaSQLAbreTabela(Vpftabela, 'select * from CadCodigo' +
                                ' where ' + VpaCampoFilial + ' = ' + IntToStr(VpaCodEmpFil) );
  //se o registro não existir, inseri
  if Vpftabela.Eof then
  begin
    Vpftabela.Insert;
    Vpftabela.FieldByName(VpaCampoFilial).AsInteger := VpaCodEmpFil;
  end
  else
    VpfTabela.edit;

  if (Vpftabela.FieldByName(VpaCampo).AsInteger = 0) or VpaCodSequencial then
  begin
     if VpaCodEmpFil <> 0 then
       Vpfcodigo := ProximoCodigoFilial(VpaTabelaProximoCod,VpaCampo,VpaCampoFilial,VpaCodEmpFil)
     else
       Vpfcodigo := ProximoCodigo(VpaTabelaProximoCod,VpaCampo);
  end
  else
    VpfCodigo := Vpftabela.FieldByName(VpaCampo).AsInteger + 1;

  result := Vpfcodigo;
  Vpftabela.FieldByName(Vpacampo).AsInteger := Vpfcodigo;
  Vpftabela.post;
  Vpftabela.close;
  Vpftabela.free;
end;

{********** carrega dados da empresa e filial para constantes do sistema ***** }
procedure CarregaEmpresaFilial( codEmp, CodEmpFil : integer; DataBase : TDataBase );
var
 tabela : TQuery;
begin
  tabela := TQuery.Create(nil);
  tabela.DatabaseName := DataBase.DatabaseName;
  // dados da empresa
  AdicionaSQLAbreTabela(tabela, 'select * from Cadempresas' +
                                ' where I_Cod_Emp = ' + IntToStr(CodEmp) );
  if not tabela.Eof then
  begin
    with Varia do
    begin
      CodigoEmpresa := tabela.fieldByName('I_COD_EMP').AsInteger;
      NomeEmpresa :=   tabela.fieldByName('C_NOM_EMP').AsString;
      MascaraPro :=  tabela.fieldByName('C_PIC_PRO').AsString;
      MascaraCla :=  tabela.fieldByName('C_PIC_CLA').AsString;
      MascaraClaSer :=  tabela.fieldByName('C_CLA_SER').AsString;
      MascaraPlanoConta := tabela.fieldByName('C_MAS_PLA').AsString;
      PlanoContasDevolucaoCotacao := tabela.fieldByName('C_PLA_DEC').AsString;
      PlanoContasBancario := tabela.fieldByName('C_PLA_RET').AsString;
      PlanoDescontoDuplicata := tabela.fieldByName('C_PLA_DES').AsString;
      DadoBoletoPadraoNota := tabela.fieldByName('I_BOL_PAD').AsInteger;
      SeqCampanhaTelemarketing := tabela.fieldByName('I_SEQ_CAM').AsInteger;
      SeqCampanhaCadastrarEmail := tabela.fieldByName('I_CAM_CEM').AsInteger;
      CodVendedorCotacao := tabela.fieldByName('I_VEN_COT').AsInteger;
      CodServicoChamadoCotacao := tabela.fieldByName('I_SER_CHA').AsInteger;
      ValAcerto := tabela.fieldByName('N_VAL_ACE').AsFloat;
      ModeloEtiquetaCartuchoToner := tabela.fieldByName('I_MOD_ETO').AsInteger;
      ModeloEtiquetaCartuchoTinta := tabela.fieldByName('I_MOD_ETI').AsInteger;
      CodClassificacaoPoTinta:= Tabela.FieldByName('C_CLA_POT').AsString;
      CodClassificacaoCilindro:= Tabela.FieldByName('C_CLA_CIL').AsString;
      CodClassificacaoChip:= Tabela.FieldByName('C_CLA_CHI').AsString;
      CodDepartamentoFichaTecnica := VpfTabela.FieldByName('CODDEPARTAMENTOFICHATECNICA').AsInteger;
    end;
    with Config do   // boolean
    begin
      BaixaQTDCotacaonaNota := TipoCheck(tabela.fieldByName('C_BAI_QCO').AsString);
      NaoPermitirAlterarCotacaoAposImpressa := TipoCheck(tabela.fieldByName('C_BDI_COT').AsString);
      TecniconaCotacao := TipoCheck(tabela.fieldByName('C_TEC_COT').AsString);
      ExigirCPFCNPJCliente := TipoCheck(tabela.fieldByName('C_CPF_CLI').AsString);
      ExigirCEPCliente := TipoCheck(tabela.fieldByName('C_CEP_CLI').AsString);
      MostrarCotacoesSomenteFilialAtiva := TipoCheck(tabela.fieldByName('C_FIL_COT').AsString);
      CopiarTransportadoraPedido := TipoCheck(tabela.fieldByName('C_CTP_COT').AsString);
      DataFinanceiroIgualDataCotacao := TipoCheck(tabela.fieldByName('C_DAR_COT').AsString);
      ImprimeCotacaocomEntregadorSomenteAlmoxarifado := TipoCheck(tabela.fieldByName('C_IMP_ALM').AsString);
      ImprimirEnvolopeSomentecomNotaFatMensal := TipoCheck(tabela.fieldByName('C_FME_IEN').AsString);
      ImprimirCotacaoFatMensal := TipoCheck(tabela.fieldByName('C_FME_ICO').AsString);
      Farmacia := TipoCheck(tabela.fieldByName('C_IND_FAR').AsString);
      ManutencaoImpressoras := TipoCheck(tabela.fieldByName('C_IND_MIM').AsString);
      RelogioPonto := TipoCheck(tabela.fieldByName('C_IND_MRE').AsString);
      Grafica := TipoCheck(tabela.fieldByName('C_IND_GRA').AsString);
      SoftwareHouse := TipoCheck(tabela.fieldByName('C_IND_SOF').AsString);
      AlterarCotacaoSomentenoDiaEmissao := TipoCheck(tabela.fieldByName('C_ALC_SDE').AsString);
      ObservacaoFiscalNaCotacao := TipoCheck(tabela.fieldByName('C_COT_TFI').AsString);
      UtilizarMailing := TipoCheck(tabela.fieldByName('C_IND_MAI').AsString);
      ExibirMensagemAntesdeImprimirNotanoFaturamentoMensal := TipoCheck(tabela.fieldByName('C_IND_AIN').AsString);
      PermitirAlterarVendedornaCotacao := TipoCheck(tabela.fieldByName('C_COT_CAV').AsString);
      AlterarCotacaoComOPGerada := TipoCheck(tabela.fieldByName('C_ALT_COG').AsString);
      TransportadoraObrigatorianaCotacao := TipoCheck(tabela.fieldByName('C_TRA_OBR').AsString);
      GerarNotaPelaQuantidadeProdutos := TipoCheck(tabela.fieldByName('C_NOT_QPR').AsString);
      ConcluiAmostraNaFichaTecnica := TipoCheck(VpfTabela.fieldByName('C_CRM_FIT').AsString);
    end;
  end;

    // dados da filial
  AdicionaSQLAbreTabela(tabela, 'select * from CadFiliais' +
                                ' where I_Emp_Fil = ' + IntToStr(CodEmpFil) );
  if not tabela.Eof then
  begin
    with Varia do
    begin
        CodigoEmpFil := tabela.fieldByName('I_EMP_FIL').AsInteger;
        NomeFilial := tabela.fieldByName('C_NOM_FAN').AsString;
        RazaoSocialFilial := tabela.fieldByName('C_NOM_FIL').AsString;
        CodigoFilial := tabela.fieldByName('I_COD_FIL').AsInteger;
        SerieNota := tabela.fieldByName('C_Ser_Not').AsString;
        TabelaPreco := tabela.fieldByName('I_COD_TAB').AsInteger;
        TabelaPrecoServico := tabela.fieldByName('I_TAB_SER').AsInteger;
        NotaFiscalPadrao := tabela.fieldByName('I_DOC_NOT').AsInteger;
        DataUltimoFechamento := tabela.fieldByName('D_ULT_FEC').AsDateTime;
        EnderecoFilial := tabela.fieldByName('C_END_FIL').AsString + ', '+ tabela.fieldByName('I_NUM_FIL').AsString;
        CepFilial := tabela.FieldByName('I_CEP_FIL').AsString;
        BairroFilial := tabela.FieldByName('C_BAI_FIL').AsString;
        CidadeFilial := tabela.FieldByName('C_CID_FIL').AsString;
        UFFilial := tabela.FieldByName('C_EST_FIL').AsString;
        CNPJFilial := tabela.FieldByName('C_CGC_FIL').AsString;
        IEFilial := Tabela.FieldByName('C_INS_FIL').AsString;
        CPFResponsavelLegal := Tabela.FieldByName('C_CPF_RES').AsString;
        SiteFilial := tabela.FieldByName('C_WWW_FIL').AsString;
        FoneFilial := tabela.fieldByName('C_FON_FIL').AsString  ;
        if tabela.fieldByName('C_FAX_FIL').AsString <> '' then
          FoneFilial :=  FoneFilial + '/'+tabela.fieldByName('C_FAX_FIL').AsString  ;
        EMailFilial := tabela.fieldByName('C_END_ELE').AsString;
        ISSQN := tabela.fieldByName('N_PER_ISQ').AsFloat;
        TextoReducaoImposto := tabela.fieldByName('C_TEX_RED').AsString;
        DatSNGPC := tabela.fieldByName('D_DAT_SNG').AsDateTime;;

        //FINANCEIRO
        ContaBancaria := tabela.fieldByName('C_CON_BAN').AsString;
        ContaBancariaBoleto := tabela.fieldByName('C_CON_BOL').AsString;
        ContaBancariaContrato := tabela.fieldByName('C_CON_CON').AsString;
        ValChamado := tabela.fieldByName('N_VAL_CHA').AsFloat;
        ValKMRodado := tabela.fieldByName('N_VAL_DKM').AsFloat;
        //CRM
        EmailComercial := tabela.fieldByName('C_EMA_COM').AsString;
        CRMCorEscuraEmail := Tabela.FieldByName('C_CRM_CES').AsString;
        CRMCorClaraEmail := Tabela.FieldByName('C_CRM_CCL').AsString;

    end;
    with Config do   // boolean
    begin
      GerarFinanceiroCotacao := TipoCheck(tabela.fieldByName('C_FIN_COT').AsString);
      BaixarEstoqueCotacao := TipoCheck(tabela.fieldByName('C_COT_BEC').AsString);
      ExcluirFinanceiroCotacaoQuandoGeraNota := TipoCheck(tabela.fieldByName('C_EXC_FIC').AsString);
      RegerarFinanceiroQuandoCotacaoAlterada := TipoCheck(tabela.fieldByName('C_FIN_ACO').AsString);
      EstoqueFiscal := TipoCheck(tabela.fieldByName('C_EST_FIS').AsString);
      EmitirECF := TipoCheck(tabela.fieldByName('C_IND_ECF').AsString);
      //
      UtilizarClassificacaoFiscalnosProdutos := TipoCheck(tabela.fieldByName('C_IND_CLA').AsString);
      UtilizarNSU := TipoCheck(tabela.fieldByName('C_IND_NSU').AsString);
      SimplesFederal := TipoCheck(tabela.fieldByName('C_SIM_FED').AsString);
      CobrarFormaPagamento := TipoCheck(tabela.fieldByName('C_COB_FRM').AsString);
      UtilizarCompose := TipoCheck(tabela.fieldByName('C_COT_COM').AsString);
    end;
  end;
  tabela.close;
  tabela.free;
end;

{******************************************************************************}
procedure CarregaDiretorios;
var
 VpfIni : TRegIniFile;
begin
 // informacoes do ini
 try
    VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
    Varia.DriveFoto := VpfIni.ReadString('DRIVEFOTO','DRIVE', 'C:\');  // carrega drive da foto;
    Varia.ImpressoraRelatorio :=  VpfIni.ReadString('IMPRESSORA','RELATORIO',   'A');  // carrega drive da jato tinta;
    Varia.ImpressoraAlmoxarifado :=  VpfIni.ReadString('IMPRESSORA','ALMOXARIFADO','');
    varia.PortaComunicacaoBalanca := VpfIni.ReadInteger('PERIFERICOS','PORTABALANCA',1);
    varia.PortaComunicacaoImpTermica := VpfIni.ReadString('PERIFERICOS','PORTAIMPTERMICA','');
    varia.PortaComunicacaoImpTermica2 := VpfIni.ReadString('PERIFERICOS','PORTAIMPTERMICA2','');
    Varia.ImpressoraAssitenciaTecnica := VpfIni.ReadString('IMPRESSORA','ASSISTENCIA','');
    Varia.PathRestauracaoBackup := VpfIni.ReadString('DIRETORIOS','RESTAURACAO','c:\Eficacia\Restauracao');
    Varia.PathVersoes := VpfIni.ReadString('DIRETORIOS','VERSOES','C:\Eficacia');
    Varia.PathSybase  := VpfIni.ReadString('DIRETORIOS','PATH_SYBASE','A');
    Varia.PathBackup := VpfIni.ReadString('DIRETORIOS','PATH_BACKUP','c:\Eficacia\Backup');
    Varia.CaixaPadrao := VpfIni.ReadInteger('CAIXA','PADRAO', 0);
    varia.UsarGaveta := VpfIni.ReadString('ECF','USARGAVETA','N');
    varia.PathSintegra := VpfIni.ReadString('SINTEGRA','PATH', '');
    varia.SenhaBanco := Descriptografa(VpfIni.ReadString(varia.ParametroBase+'\BANCODADOS','SENHA',''));
    varia.PathInSig := VpfIni.ReadString('DIRETORIOS','PATH_SISCORP','C:\Eficacia');
    varia.PathRemessaBancaria := VpfIni.ReadString('DIRETORIOS','PATH_REMESSABANCARIA','c:\Eficacia\remessa');
    varia.PathRelatorios := VpfIni.ReadString('DIRETORIOS','PATH_RELATORIOS', 'c:\Eficacia\Relatorios');
    varia.ImpressoraCheque := VpfIni.ReadInteger('IMPRESSORA','CHEQUE', 0);
    varia.ModemTelemarketing := VpfIni.ReadString('TELEMARKETING','MODEM','');
    varia.CodClientePadraoCotacao := VpfIni.ReadInteger('COTACAO','CLIENTEPADRAO',0);
    varia.CodTipoCotacaoMaquinaLocal :=VpfIni.ReadInteger('COTACAO','TIPOCOTACAO',0);
    config.PermanecerOVendedorDaUltimaVenda :=VpfIni.ReadBool('COTACAO','PERMANECERULTIMOVENDEDOR',False);
    Varia.DiretorioFiscais :=  VpfIni.ReadString('DIRETORIOS','ARQUIVOSFISCAIS',RetornaDiretorioCorrente+'\FiscaisGerados');
    varia.DiretorioTemporarioCrystal :=  VpfIni.ReadString('DIRETORIOS','TEMPORARIOCRYSTAL',RetornaDiretorioCorrente+'\Crystal\temp');
    if not existeDiretorio(Varia.DiretorioFiscais) then
      CriaDiretorio(Varia.DiretorioFiscais);
    if not existeDiretorio(varia.DiretorioTemporarioCrystal) then
      CriaDiretorio(varia.DiretorioTemporarioCrystal);
  finally
    VpfIni.Free;
  end;
end;

{******* carrega informacoes do cfg ****************************************** }
procedure carregaCFG( DataBase : TDataBase);
var
 tabela : TQuery;
begin
  tabela := TQuery.Create(nil);
  tabela.DatabaseName := DataBase.DatabaseName;
  Varia.NomeComputador :=  Sistema.RNomComputador;
  AdicionaSQLAbreTabela(tabela, 'select * from cfg_geral');
  if not tabela.Eof then
  begin
    with Varia do
    begin
    //-------  geral
       CodigoEmpresa := tabela.fieldByName('I_COD_EMP').AsInteger;
       CodigoEmpFil := tabela.fieldByName('I_EMP_FIL').AsInteger;
       CodigoUsuarioSistema := tabela.fieldByName('I_COD_USU').AsInteger;
       case tabela.fieldByName('I_DEC_VAl').AsInteger of
          2 : MascaraValorUnitario := '#,###,###,###,##0.00';
          3 : MascaraValorUnitario := '#,###,###,###,##0.000';
          4 : MascaraValorUnitario := '#,###,###,###,##0.0000';
       else
          MascaraValorUnitario := '#,###,###,###,##0.00';
       end;
       MascaraValor :=  MascaraValorUnitario;

       MascaraMoeda := Tabela.fieldByName('C_MAS_MOE').AsString + ' ' + MascaraValorUnitario ;
       CurrencyString := tabela.fieldByName('C_MAS_MOE').AsString;

//       if tabela.fieldByName('I_DEC_QTD').AsInteger > 0 then
//          CurrencyDecimals := tabela.fieldByName('I_DEC_VAL').AsInteger;

       case tabela.fieldByName('I_DEC_QTD').AsInteger of
         0 : MascaraQtd :=  '#,###,###,###,##0';
         1 : MascaraQtd :=  '#,###,###,###,##0.0';
         2 : MascaraQtd :=  '#,###,###,###,##0.00';
         3 : MascaraQtd :=  '#,###,###,###,##0.000';
         4 : MascaraQtd :=  '#,###,###,###,##0.0000';
       else
          MascaraQtd :=  '#,###,###,###,##0.00';
       end;
       DecimaisQtd := tabela.fieldByName('I_DEC_QTD').AsInteger;

       MoedaBase := tabela.fieldByName('I_MOE_BAS').AsInteger;
       DataDaMoeda := tabela.fieldByName('D_DAT_MOE').AsDateTime;
       MoedasVazias := tabela.fieldByName('C_MOE_VAZ').AsString;
       Decimais := tabela.fieldByName('I_DEC_VAL').AsInteger;
       GrupoUsuarioMaster := tabela.fieldByName('I_GRU_MAS').AsInteger;
       VersaoBanco := tabela.fieldByName('I_ULT_ALT').AsInteger;
       TipoBase :=  tabela.fieldByName('I_TIP_BAS').AsInteger;
       DiaValBase :=  tabela.fieldByName('I_DIA_VAl').AsInteger;
       ServidorSMTP := tabela.fieldByName('C_SER_SMT').AsString;
       ServidorPop := tabela.fieldByName('C_SER_POP').AsString;
       UsuarioSMTP := tabela.fieldByName('C_USU_SMT').AsString;
       SenhaEmail := tabela.fieldByName('C_SEN_EMA').AsString;
       CondicaoPagamentoContrato := tabela.fieldByName('I_PAG_CON').AsInteger;
       FormaPagamentoContrato := tabela.fieldByName('I_FRM_CON').AsInteger;
       MesLocacao := tabela.fieldByName('I_MES_LOC').AsInteger;
       AnoLocacao := Tabela.FieldByName('I_ANO_LOC').AsInteger;
       TipoContratoLocacao := Tabela.FieldByName('I_CON_LOC').AsInteger;
       SeqProdutoContrato := Tabela.FieldByName('I_PRO_CON').AsInteger;
       CodProdutoContrato := Tabela.FieldByName('C_PRO_CON').AsString;
       DatFimLocacao := Tabela.FieldByName('D_FIM_LOC').AsDateTime;
       EstagioInicialChamado := tabela.fieldByName('I_EST_ICH').AsInteger;
       TipoChamadoInstalacao := tabela.fieldByName('I_CHA_INS').AsInteger;
       CodPesquisaSatisfacaoChamado := tabela.fieldByName('I_PES_SAA').AsInteger;
       CodPesquisaSatisfacaoInstalacao := tabela.fieldByName('I_PES_INS').AsInteger;
       CodTecnicoIndefinido := tabela.fieldByName('I_TEC_IND').AsInteger;
       DatUltimaLeituraLocacao := Tabela.FieldByname('D_ULT_LEL').AsDateTime;
       CRMTamanhoLogo := Tabela.FieldByName('I_CRM_TIM').AsInteger;
       CRMAlturaLogo := Tabela.FieldByName('I_CRM_AIM').AsInteger;
       CentroCustoPadrao := Tabela.FieldByName('I_CEN_CUS').AsInteger;
       EstagioInicialProposta := Tabela.FieldByName('I_EST_CRI').AsInteger;
       EstagioAguardandoRecebimentoProposta := Tabela.FieldByName('I_EST_CAR').AsInteger;
       EstagioPropostaEmNegociacao := Tabela.FieldByName('I_EST_CRN').AsInteger;
       EstagioPropostaConcluida := Tabela.FieldByName('I_EST_CRF').AsInteger;
       EstagioInicialCompras := Tabela.FieldByName('I_EST_COI').AsInteger;
       EstagioComprasAprovado := Tabela.FieldByName('I_EST_COA').AsInteger;
       EstagioComprasAguardandoConfirmacaoRecebFornececedor:= Tabela.FieldByName('I_EST_CCR').AsInteger;
       EstagioComprasAguardandoEntregaFornecedor:= Tabela.FieldByName('I_EST_CAE').AsInteger;
       EstagioFinalCompras:= Tabela.FieldByName('I_EST_COF').AsInteger;
       EstagioInicialOrcamentoCompra := Tabela.FieldByName('I_EST_OCI').AsInteger;
       EstagioOrcamentoCompraAprovado := Tabela.FieldByName('I_EST_OCA').AsInteger;
       CodSetor:= Tabela.FieldByName('I_COD_SET').AsInteger;
       CodClienteOP := Tabela.FieldByName('I_ORP_ICP').AsInteger;
       SituacaoPadraoCliente:= Tabela.FieldByName('I_SIT_CLI').AsInteger;       
    end;

    with Config do   // boolean
    begin
      CodigoBarras := TipoCheck(tabela.fieldByName('C_COD_BAR').AsString);
      AtualizaPermissao := TipoCheck(tabela.fieldByName('C_VER_FOR').AsString);
      ImpPorta :=  TipoCheck(tabela.fieldByName('C_IMP_PRT').AsString);
      ControlarFaturamentoMinimoContrato := TipoCheck(tabela.fieldByName('C_FAT_MIN').AsString);
      NoFaturamentoMensalProcessarFaturamentoPosterior := TipoCheck(tabela.fieldByName('C_FAT_POS').AsString);
      ExigirCNPJeCEPCotacaoPadrao := TipoCheck(tabela.fieldByName('C_COT_ECC').AsString);
      EnviaCotacaoEmailTransportadora := TipoCheck(tabela.fieldByName('C_COT_EEE').AsString);
      EnviaChamadoEmailTecnico := TipoCheck(tabela.fieldByName('C_CHA_EET').AsString);
      EnviarEmailFaturamentoMensal := TipoCheck(tabela.fieldByName('C_CON_EMA').AsString);
      NoFaturamentoMensalCondPagamentoCliente := TipoCheck(tabela.fieldByName('C_CON_CPC').AsString);
      EmitirNotaFaturamentoMensal := TipoCheck(tabela.fieldByName('C_CON_NOT').AsString);
      UtilizarTabelaPreconaCotacao := TipoCheck(tabela.fieldByName('C_COT_TPC').AsString);
      DescontoNosProdutodaCotacao := TipoCheck(tabela.fieldByName('C_IND_DPC').AsString);
      EstagioFinalOpParaCotacaoFaturamentoPosterior := TipoCheck(tabela.fieldByName('C_EST_FAP').AsString);
      EstagioFinalOPparaCotacaoTransportadoraVaiza := TipoCheck(tabela.fieldByName('C_EST_TRV').AsString);
      PermitirAlterarTipoCotacao := TipoCheck(tabela.fieldByName('C_COT_ATC').AsString);
      UtilizarLeitorSeparacaoProduto := TipoCheck(tabela.fieldByName('C_COT_LSP').AsString);
      NaCotacaoBuscaroContato := TipoCheck(tabela.fieldByName('C_CON_COT').AsString);
      SolicitarSenhaparaCancelarBaixaParcial := TipoCheck(tabela.fieldByName('C_COT_SCB').AsString);
      QuandoGerarFinanceiorMostrarCotacoesNaoFaturadas := TipoCheck(tabela.fieldByName('C_COT_MCN').AsString);
      ProdutoPorTamanho := TipoCheck(tabela.fieldByName('C_COT_TPR').AsString);
      AgruparProdutosnaOP := TipoCheck(tabela.fieldByName('C_ORP_AGP').AsString);
      AdicionarQtdIdealEstoquenaOP := TipoCheck(tabela.fieldByName('C_ORP_AQI').AsString);
      PermitirGravaCotacaoSemCNPJaVista := TipoCheck(tabela.fieldByName('C_COT_ECV').AsString);
      ObrigarObservacaoNaGarantia := TipoCheck(tabela.fieldByName('C_COT_OGO').AsString);
      PermitirCancelareExtornarCotacao := TipoCheck(tabela.fieldByName('C_COT_PCE').AsString);
      PermitirBaixarNumeroPedido:= TipoCheck(tabela.fieldByName('C_COT_PBN').AsString);
      MetaVendedorpelaCarteiradeClientes := TipoCheck(tabela.fieldByName('C_MET_VEN').AsString);
    end;
  end;

   CarregaEmpresaFilial(varia.CodigoEmpresa, Varia.CodigoEmpFil, dataBase );

    // -- produtos
    AdicionaSQLAbreTabela(tabela, 'select * from cfg_produto');
    if not tabela.Eof then
    begin
      with Varia do
      begin
         DiasValidade := tabela.fieldByName('I_DIA_ORC').AsInteger;
         UnidadeCX := tabela.fieldByName('C_UNI_CAX').AsString;
         UnidadeUN := tabela.fieldByName('C_UNI_PEC').AsString;
         OperacaoEstoqueInicial := tabela.fieldByName('I_OPE_INI').AsInteger;
         UltimoMesEstoque := tabela.fieldByName('I_MES_EST').AsInteger;
         UltimoAnoEstoque := tabela.fieldByName('I_ANO_EST').AsInteger;
         UtilizarIpi := TipoCheck(tabela.fieldByName('C_FLA_IPI').AsString);
         InventarioEntrada := Tabela.FieldByName('I_INV_ENT').AsInteger;
         InventarioSaida := Tabela.FieldByName('I_INV_SAI').AsInteger;
         EstagioOrdemProducao := Tabela.FieldByName('CODEST').AsInteger;
         EstagioOrdemProducaoAlmoxarifado := Tabela.FieldByName('I_EST_ALM').AsInteger;
         EstagioAguardandoEntrega := Tabela.FieldByName('I_EST_AEN').AsInteger;
         EstagioNaEntrega := Tabela.FieldByName('I_EST_NEN').AsInteger;
         EstagioFinalOrdemProducao := Tabela.FieldByName('I_EST_FIN').AsInteger;
         EstagioCotacaoAlterada := Tabela.FieldByName('I_EST_ALT').AsInteger;
         EstagioCotacaoExtornada := Tabela.FieldByName('I_EST_CEX').AsInteger;
         EstagioBaixaParcialCancelada := Tabela.FieldByName('I_EST_BCC').AsInteger;
         EstagioAssistenciaTecnica := Tabela.FieldByName('I_EST_AST').AsInteger;
         EstagioChamadoFinalizado := tabela.fieldByName('I_EST_CFI').AsInteger;
         EstagioChamadoFaturado := tabela.fieldByName('I_EST_CFA').AsInteger;
         EstagioChamadoAguardandoAgendamendo := tabela.fieldByName('I_EST_CAA').AsInteger;
         EstagioEnviadoFaccionista := tabela.fieldByName('I_EST_FAC').AsInteger;
         EstagioRetornoFaccionista := tabela.fieldByName('I_EST_RFA').AsInteger;
         TipoCotacao := Tabela.FieldByName('I_TIP_ORC').AsInteger;
         TipoCotacaoPedido := Tabela.FieldByName('I_ORC_PED').AsInteger;
         TipoCotacaoFaturamentoPosterior := Tabela.FieldByName('I_ORC_FPO').AsInteger;
         TipoCotacaoContrato := Tabela.FieldByName('I_ORC_CON').AsInteger;
         TipoCotacaoGarantia := Tabela.FieldByName('I_ORC_GAR').AsInteger;
         TipoCotacaoRevenda := Tabela.FieldByName('I_ORC_REV').AsInteger;
         TipoCotacaoFaturamentoPendente := Tabela.FieldByName('I_FAT_PEN').AsInteger;
         CodTransportadoraVazio := Tabela.FieldByName('I_COD_TRA').AsInteger;
         OperacaoEstoqueEstornoEntrada := Tabela.FieldByName('I_OPE_EEN').AsInteger;
         OperacaoEstoqueEstornoSaida := Tabela.FieldByName('I_OPE_ESA').AsInteger;
         OperacaoAcertoEstoqueEntrada := Tabela.FieldByName('I_OPE_EXE').AsInteger;
         OperacaoAcertoEstoqueSaida := Tabela.FieldByName('I_OPE_EXS').AsInteger;
         OperacaoEstoqueImpressaoEtiqueta := Tabela.FieldByName('I_OPE_EIE').AsInteger;
         CodFilialControladoraEstoque := Tabela.FieldByName('I_FIL_EST').AsInteger;
         ClassificacaoFiscal := tabela.fieldByName('C_CLA_FIS').AsString;
         CodClassificacaoProdutos := tabela.fieldByName('C_CLA_PRO').AsString;
         CodClassificacaoMateriaPrima := tabela.fieldByName('C_CLA_MAP').AsString;
         ModeloEtiquetaNotaEntrada := tabela.fieldByName('I_MOD_ENE').AsInteger;
       end;

      with Config do   // boolean
      begin
        AvisaQtdPedido := TipoCheck(tabela.fieldByName('C_Qtd_Est').AsString);
        AvisaQtdMinima := TipoCheck(tabela.fieldByName('C_Qtd_Min').AsString);
        QtdNegativa := tabela.fieldbyname('I_Est_Neg').AsInteger;
        MascaraProdutoPadrao := TipoCheck(tabela.fieldByName('C_MAS_PRO').AsString);
        VerCodigoProdutos := TipoCheck(tabela.fieldByName('C_VER_PRO').AsString);
        CodigoUnicoProduto := not TipoCheck(tabela.fieldByName('C_Cod_Uni').AsString);
        PermiteItemNFEntradaDuplicado := TipoCheck(tabela.fieldByName('C_Ent_Rep').AsString);
        CadastroEtiqueta := TipoCheck(tabela.fieldByName('C_IND_ETI').AsString);
        CadastroCadarco := TipoCheck(tabela.fieldByName('C_IND_CAR').AsString);
        EstoquePorCor := TipoCheck(tabela.fieldByName('C_EST_COR').AsString);
        PrecoPorClienteAutomatico := TipoCheck(tabela.fieldByName('C_PRC_AUT').AsString);
        ExigirDataEntregaPrevista := TipoCheck(tabela.fieldByName('C_EXI_DAP').AsString);
        ExcluirCotacaoQuandoNFCancelada := TipoCheck(tabela.fieldByName('C_EXC_CNF').AsString);
        BaixarEstoquePeloConsumoProduto := TipoCheck(tabela.fieldByName('C_BAI_CON').AsString);
        NomDesenhoIgualCodigo := TipoCheck(tabela.fieldByName('C_DES_ICO').AsString);
        EstoqueCentralizado := TipoCheck( tabela.fieldByName('C_EST_CEN').AsString);
        NumeroSerieProduto := TipoCheck( tabela.fieldByName('C_SER_PRO').AsString);
        ControlarBrinde := TipoCheck( tabela.fieldByName('C_IND_BRI').AsString);
        PermiteAlteraNomeProdutonaCotacao := TipoCheck( tabela.fieldByName('C_ALT_DPR').AsString);
        ValordeCompraComFrete := TipoCheck( tabela.fieldByName('C_VCO_FRE').AsString);
      end;
    end;
    if not Config.EstoqueCentralizado then
      Varia.CodFilialControladoraEstoque := Varia.CodigoEmpFil;

    //--------------- financeiro ----------------------------------------
    AdicionaSQLAbreTabela(tabela, 'select * from cfg_financeiro');
    if not tabela.Eof then
    begin
      with Varia do
      begin
        Mora :=  tabela.fieldByName('N_PER_MOR').AsCurrency;
        Juro := tabela.fieldByName('N_PER_JUR').AsCurrency;
        Multa := tabela.fieldByName('N_PER_MUL').AsCurrency;
        ChequePre := tabela.fieldByName('I_CHE_PRE').AsInteger;
        QtdDiasProtesto := tabela.fieldByName('I_DIA_PTS').AsInteger;
        ValorTolerancia := tabela.fieldByName('VAL_TOLERANCIA').AsFloat;
        OperacaoPagar := tabela.fieldByName('COD_OPERACAO_PADRAO_PAGAR').AsInteger;
        OperacaoReceber := tabela.fieldByName('COD_OPERACAO_PADRAO_RECEBER').AsInteger;
        CondPagtoVista := tabela.fieldByName('I_COD_PAG').AsInteger;
        SenhaCaixa := Descriptografa(tabela.fieldByName('C_SEN_CAI').Asstring);
        OperacaoBancariaCheque := tabela.fieldByName('C_OPE_BAN').AsString;
        FormaPagamentoPadrao := Tabela.fieldByName('I_FRM_PAD').AsInteger;
        FormaPagamentoCarteira := Tabela.fieldByName('I_FRM_CAR').AsInteger;
        FormaPagamentoBoleto := Tabela.fieldByName('I_FRM_BOL').AsInteger;
        FormaPagamentoDinheiro := Tabela.fieldByName('I_FRM_DIN').AsInteger;
        FormaPagamentoDeposito := Tabela.fieldByName('I_FRM_DEP').AsInteger;
        ClienteFornecedorbancario := Tabela.fieldByName('I_CLI_BAN').AsInteger;
        DocReciboPadrao := Tabela.fieldByName('I_REC_PAD').AsInteger;
        if LENGTH(Tabela.fieldByName('C_CON_GER').AsString) > 0 then
          ConsultaPor := Tabela.fieldByName('C_CON_GER').AsString[1]
        else
          ConsultaPor := 'O'; // Número de Ordem.
        FilialControladora := Tabela.fieldByName('I_FIL_CON').AsInteger;
        CodHistoricoNaoLigado := Tabela.fieldByName('I_HIS_NLI').AsInteger;
        RodapeECobranca := Tabela.fieldByName('C_ROD_ECO').AsString;
        emailECobranca := Tabela.fieldByName('C_EMA_ECO').AsString;
        TipComissao := Tabela.fieldByName('I_TIP_COM').AsInteger;
      end;
      with Config do   // boolean
      begin
        CapaLote := TipoCheck(tabela.fieldByName('C_CAP_LOT').AsString);
        BaixaMovBancario :=TipoCheck(tabela.fieldByName('C_BAI_CHE').AsString);
        BaixaCPCadastro :=TipoCheck(tabela.fieldByName('C_BAI_COP').AsString);
        BaixaCRCadastro :=TipoCheck(tabela.fieldByName('C_BAI_COR').AsString);
        DataVencimentoMenor := TipoCheck(tabela.fieldByName('C_DAT_VEN').AsString);
        DataBaixaMenor := TipoCheck(tabela.fieldByName('C_DAT_BAI').AsString);
        BaixaParcelaAntVazia := TipoCheck(tabela.fieldByName('C_PAR_ANT').AsString);
        JurosMultaDoDia := TipoCheck(tabela.fieldByName('C_JUR_ATU').AsString);
        ComissaoDireta := TipoCheck(tabela.fieldByName('C_COM_DIR').AsString);
        NumeroDuplicata := TipoCheck(tabela.fieldByName('C_NRO_DUP').AsString);
        NumeroDocumento := TipoCheck(tabela.fieldByName('C_NRO_DOC').AsString);
        PermitirParcial := TipoCheck(tabela.fieldByName('C_PER_PAR').AsString);
        GerarDespesasFixa := TipoCheck(tabela.fieldByName('C_DES_FIX').AsString);

        AvisaIndMoeda := TipoCheck(tabela.fieldByName('C_Ind_Moe').AsString);
        AvisaDataAtualInvalida := TipoCheck(tabela.fieldByName('C_Dat_Inv').AsString);

        VariosCaixasDia := TipoCheck(tabela.fieldByName('FLA_VARIOS_GERAIS').AsString);
        LogDireto := TipoCheck(tabela.fieldByName('FLA_LOG_DIRETO').AsString);
        SenhaAlteracao := TipoCheck(tabela.fieldByName('C_SEN_ALT').AsString);
        SenhaEstorno := TipoCheck(tabela.fieldByName('C_SEN_EST').AsString);
        ParcialCaixaDataAnterior := TipoCheck(tabela.fieldByName('C_PAR_DAT').AsString);
        itemCaixaDataAnterior := TipoCheck(tabela.fieldByName('C_ITE_DAT').AsString);
        AtualizarDespesas := TipoCheck(tabela.fieldByName('C_FLA_ATD').AsString);
        ConfirmaBancario := TipoCheck(tabela.fieldByName('C_FLA_BAN').AsString);
        FilialControladora := TipoCheck(tabela.fieldByName('C_FIL_CON').AsString);
        LimiteCreditoCliente := TipoCheck(tabela.fieldByName('C_LIM_CRE').AsString);
        BloquearClienteEmAtraso := TipoCheck(tabela.fieldByName('C_BLO_CAT').AsString);
        QuandoFaturarAdicionarnaRemessa := TipoCheck(tabela.fieldByName('C_REM_AUT').AsString);
        ECobrancaEnviarAvisoProgramacaoPagamento := TipoCheck(tabela.fieldByName('C_ECO_AVP').AsString);
        ECobrancaEnviarAvisoPagamentoAtrasado := TipoCheck(tabela.fieldByName('C_ECO_APE').AsString);
        ECobrancaEnviarValoresCorrigidos := TipoCheck(tabela.fieldByName('C_ECO_VAC').AsString);
        if tabela.FieldByName('C_TIP_BOL').AsString = 'B' Then
          ImprimirBoletoFolhaBranco := true
        else
          ImprimirBoletoFolhaBranco := false;
        SalvarDataUltimaBaixaCR := TipoCheck(tabela.fieldByName('C_SAL_DAB').AsString);
        BaixaContasReceberCalcularJuros:= TipoCheck(tabela.fieldByName('C_JUR_AUT').AsString);
        AdicionarRemessaAoImprimirBoleto:= TipoCheck(tabela.fieldByName('C_IMB_AAR').AsString);
      end;
    end;

    //--------------------fiscal-------------------------------------
    AdicionaSQLAbreTabela(tabela, 'select * from cfg_fiscal');
    if not tabela.Eof then
    begin
      with Varia do
      begin
        PathRetornoECF := tabela.fieldByName('C_PAT_ECF').AsString;
        EstadoPadrao := tabela.fieldByName('C_EST_ICM').AsString;
        TextoPromocional := TStringList.create;
        TextoPromocional.Add(tabela.fieldByName('L_TEX_PRO').AsString);
        CodigoOpeEstEcf := tabela.fieldByName('C_OPE_ECF').AsInteger;
        PlanoContaEcf := tabela.fieldByName('C_PLA_ECF').AsString;
        DescontoMaximoNota := tabela.fieldByName('N_DES_NOT').AsFloat;
        NaturezaNota := tabela.fieldByName('C_Cod_Nat').AsString;
        NaturezaForaEstado := tabela.fieldByName('C_NAT_FOE').AsString;
        FretePadraoNF := tabela.fieldByName('I_FRE_NOT').AsInteger;
        TipoComissaoProduto := tabela.fieldByName('I_COM_PRO').AsInteger;
        TipoComissaoServico := tabela.fieldByName('I_COM_SER').AsInteger;
        MaiorDescontoPermitido := tabela.fieldByName('I_DES_MAI').AsInteger;
        SenhaLiberacao := Descriptografa(tabela.fieldByName('C_Sen_Lib').AsString);
        BoletoPadraoNota := tabela.fieldByName('I_BOL_PAD').AsInteger;
        ClienteDevolucao := tabela.fieldByName('I_CLI_DEV').AsInteger;
        NaturezaDevolucaoCupom := tabela.fieldByName('C_NAT_DEV').AsString;
        NaturezaDevolucaoNotaFiscal := tabela.fieldByName('C_NAT_NOT').AsString;
        NaturezaNotaFiscalCupom := tabela.fieldByName('C_NOT_CUP').AsString;
        NaturezaServico := tabela.fieldByName('C_NAT_SER').AsString;
        NaturezaServicoEProduto := tabela.fieldByName('C_NAT_PSE').AsString;
        NaturezaServicoForaEstado := tabela.fieldByName('C_NAT_FSE').AsString;
        NaturezaServicoEProdutoForaEstado := tabela.fieldByName('C_NAT_PSF').AsString;
        LayoutECF := tabela.fieldByName('I_LAY_ECF').AsInteger;
        TamanhoFonteECF := tabela.fieldByName('I_FON_ECF').AsInteger;
        PerPIS := Tabela.FieldByname('N_PER_PIS').AsFloat;
        PerCOFINS := Tabela.FieldByname('N_PER_COF').AsFloat;
        PlacaVeiculoNota := Tabela.FieldByname('C_PLA_VEI').AsString;
        MarcaEmbalagem := tabela.FieldByName('C_MAR_PRO').AsString;
        CodTransportadora :=  Tabela.FieldByName('I_COD_TRA').AsInteger;
        ContaContabilFornecedor := Tabela.FieldByName('I_CCO_FOR').AsInteger;
        ContaContabilCliente := Tabela.FieldByName('I_CCO_CLI').AsInteger;
        DocPadraoPedido :=  Tabela.FieldByName('I_PED_PAD').AsInteger;
        case Tabela.FieldByName('I_FOR_EXP').AsInteger of
          0 :  FormatoExportacaoFiscal := feLince;
          1 :  FormatoExportacaoFiscal := feWKLiscalforDos;
          2 :  FormatoExportacaoFiscal := feSantaCatarina;
          3 :  FormatoExportacaoFiscal := feSintegra;
          4 :  FormatoExportacaoFiscal := feMTFiscal;
          5 :  FormatoExportacaoFiscal :=  feWKRadar;
          6 :  FormatoExportacaoFiscal :=  feValidaPR;
        end;
        ValMinimoFaturamentoAutomatico := Tabela.FieldByname('N_VAL_MFA').AsFloat;
      end;

      with Config do   // boolean
      begin
        AlterarValorUnitarioNota := TipoCheck(tabela.fieldByName('C_ALT_VLR').AsString);
        DescontoNota := TipoCheck(tabela.fieldByName('C_DES_NOT').AsString);
        AlterarValorUnitarioComSenha := TipoCheck(tabela.fieldByName('C_SEN_ALT').AsString);
        AlterarDescontoComSenha := TipoCheck(tabela.fieldByName('C_SEN_DES').AsString);
        UsaTEF := TipoCheck(tabela.fieldByName('C_USA_TEF').AsString);
        MostraDadosClienteCupom := TipoCheck(tabela.fieldByName('C_CLI_CUP').AsString);
        AlterarNroNF := TipoCheck(tabela.fieldByName('C_NRO_NOT').AsString);
        AlterarValorNotaCR := TipoCheck(tabela.fieldByName('C_ALT_VNF').AsString);
        ItemNFSaidaDuplicado := TipoCheck(tabela.fieldByName('C_DUP_PNF').AsString);
        ImprimirPedEmPreImp := TipoCheck(tabela.fieldByName('C_PED_PRE').AsString);
        UtilizarTransPedido := TipoCheck(tabela.fieldByName('C_TRA_PED').AsString);
        OptanteSimples := TipoCheck(tabela.fieldByName('C_OPT_SIM').AsString);
        NotaFiscalPorFilial := TipoCheck(tabela.fieldByName('C_NNF_FIL').AsString);
        MostrarNotasDevolvidasnaVenda := TipoCheck(tabela.fieldByName('C_VER_DEV').AsString);
        NaoCopiarObservacaoPedidoNotaFiscal := TipoCheck(tabela.fieldByName('C_OBS_PED').AsString);
        ImprimirNumeroCotacaonaNotaFiscal := TipoCheck(tabela.fieldByName('C_IMP_NOR').AsString);
        NaNotaFazerMediaValProdutosDuplicados := TipoCheck(tabela.fieldByName('C_MED_PRO').AsString);
        ImprimirnaNotaDescricaoItemNatureza := TipoCheck(tabela.fieldByName('C_INF_INO').AsString);
      end;
    end;

    AdicionaSQLAbreTabela(tabela, 'select * from CFG_ECF ');
    if not Tabela.Eof then
    begin
      with varia do
      begin
        case Tabela.FieldByName('NUMTIPOECF').AsInteger of
          0 : TipoECF := ifBematech_FI_2;
          1 : TipoECF := ifDaruamFS600;
        end;
        ClientePadraoECF := tabela.fieldByName('CODCLIENTEPADRAO').AsInteger;
        CodPlanoContasECF := tabela.fieldByName('CODPLANOCONTAS').AsString;
        CodOperacaoEstoqueECF := tabela.fieldByName('CODOPERACAOESTOQUE').AsInteger;
        CodCondicaoPagamentoECF := tabela.fieldByName('CODCONDICAOPAGAMENTO').AsInteger;
      end;
      with config do
      begin
        GerarFinanceiroECF := TipoCheck(tabela.fieldByName('INDGERAFINANCEIRO').AsString);
        BaixarEstoqueECF := TipoCheck(tabela.fieldByName('INDBAIXAESTOQUE').AsString);
        MostrarFormaPagamentoECFGeradoPelaCotacao := TipoCheck(tabela.fieldByName('INDFORMAPAGAMENTOCOTACAO').AsString);
        UtilizarGaveta := TipoCheck(tabela.fieldByName('INDUTILIZAGAVETA').AsString);
        PassarDescontodaCotacao := TipoCheck(tabela.fieldByName('INDDESCONTOCOTACAO').AsString);
      end;
    end;

    AdicionaSQLAbreTabela(tabela, 'select * from cfg_modulo');
    if not tabela.Eof then
    begin
      with ConfigModulos do   // boolean
        begin
          Bancario := TipoCheck(tabela.fieldByName('FLA_BANCARIO').AsString);
          Caixa := TipoCheck(tabela.fieldByName('FLA_CAIXA').AsString);
          Comissao := TipoCheck(tabela.fieldByName('FLA_COMISSAO').AsString);
          ContasAPagar := TipoCheck(tabela.fieldByName('FLA_CONTA_PAGAR').AsString);
          ContasAReceber := TipoCheck(tabela.fieldByName('FLA_CONTA_RECEBER').AsString);
          Faturamento := TipoCheck(tabela.fieldByName('FLA_FATURAMENTO').AsString);
          Fluxo := TipoCheck(tabela.fieldByName('FLA_FLUXO').AsString);
          Custo := TipoCheck(tabela.fieldByName('FLA_CUSTO').AsString);
          Produto := TipoCheck(tabela.fieldByName('FLA_PRODUTO').AsString);
          Estoque := TipoCheck(tabela.fieldByName('FLA_ESTOQUE').AsString);

          Servico := TipoCheck(tabela.fieldByName('FLA_SERVICO').AsString);
          NotaFiscal := TipoCheck(tabela.fieldByName('FLA_NOTA_FISCAL').AsString);
          TEF := TipoCheck(tabela.fieldByName('FLA_TEF').AsString);
          ECF := TipoCheck(tabela.fieldByName('FLA_ECF').AsString);
          CodigoBarra := TipoCheck(tabela.fieldByName('FLA_CODIGOBARRA').AsString);
          Gaveta := TipoCheck(tabela.fieldByName('FLA_GAVETA').AsString);
          ImpDocumentoS := TipoCheck(tabela.fieldByName('FLA_IMPDOCUMENTOS').AsString);
          OrcamentoVenda := TipoCheck(tabela.fieldByName('FLA_ORCAMENTOVENDA').AsString);
          Imp_Exp := TipoCheck(tabela.fieldByName('FLA_IMP_EXP').AsString);
          SenhaGrupo := TipoCheck(tabela.fieldByName('FLA_SENHAGRUPO').AsString);
          MalaDiretaCliente := TipoCheck(tabela.fieldByName('FLA_MALACLIENTE').AsString);
          AgendaHistoricoCliente := TipoCheck(tabela.fieldByName('FLA_AGENDACLIENTE').AsString);
          PedidoVenda := TipoCheck(tabela.fieldByName('FLA_PEDIDO').AsString);
          OrdemServico := TipoCheck(tabela.fieldByName('FLA_ORDEMSERVICO').AsString);
          TeleMarketing := TipoCheck(tabela.fieldByName('FLA_TELEMARKETING').AsString);
          Faccionista := TipoCheck(tabela.fieldByName('FLA_FACCIONISTA').AsString);
          Amostra := TipoCheck(tabela.fieldByName('FLA_AMOSTRA').AsString);
        end;
   end;
  //desativado em 19/04/2006 por nenhum cliente estar utilizando.
{  if config.CodigoBarras then
   varia.CodigoProduto := 'C_COD_BAR'
  else
   varia.CodigoProduto := 'C_COD_PRO';}
  varia.CodigoProduto := 'C_COD_PRO';

  CarregaDiretorios;
  Varia.CodigosVendedores :=  Varia.RCodigosVendedores(Varia.CodigoUsuario);

  if varia.TipoBase = 0 then
  begin
    LimpaSQLTabela(Tabela); // soma dia na base de demonstracao
    AdicionaSQLTabela(Tabela, ' update cfg_geral ' +
                              ' set I_DIA_VAL = ' + IntToStr(varia.DiaValBase-1) );
    tabela.ExecSQL;
  end;
  Tabela.Close;
  tabela.free;
  Varia.CarPermissaoUsuario(Varia.PermissoesUsuario,IntToStr(Varia.CodigoEmpFil),Inttostr(Varia.GrupoUsuario));
end;

function RCodBancoConta(VpaContaCorrente : String) : Integer;
var
  VpfTabela : TQuery;
begin
  VpfTabela := TQuery.Create(nil);
  VpfTabela.DataBaseName := 'BaseDados';
  AdicionaSQlAbreTabela(vpfTabela,'Select * from CADCONTAS '+
                          ' Where C_NRO_CON = '''+VpaContaCorrente+ '''');
  result := VpfTabela.FieldByName('I_COD_BAN').AsInteger;
  VpfTabela.free;
end;
end.
