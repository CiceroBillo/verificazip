unit UnDados;

interface
Uses Classes, UnDadosCR, SysUtils;


Type
  TRBDRomaneioOrcamentoItem = class
    public
      SeqItem,
      SeqProduto,
      CodFilialOrcamento,
      LanOrcamento,
      CodCor,
      CodTamanho,
      CodEmbalagem : Integer;
      CodProduto,
      NomProduto,
      NomCor,
      NomTamanho,
      NomEmbalagem,
      DesUM,
      DesReferenciaCliente,
      DesOrdemCompra,
      DesOrdemCorte,
      DesOrdemCompraPedido,
      DesCodBarrasAnterior,
      DesCodBarra : string;
      QtdProduto,
      QtdPedido,
      QtdEmbalagem,
      ValUnitario,
      ValTotal : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDRomaneioOrcamento = class
    public
      CodFilial,
      SeqRomaneio,
      NumNota,
      CodFilialNota,
      SeqNota,
      CodCliente,
      QtdVolume,
      CodUsuario : Integer;
      DatInicio,
      DatFim : TDateTime;
      PesBruto,
      ValTotal : Double;
      IndBloqueado : Boolean;
      Produtos : TList;
      constructor cria;
      destructor destroy;override;
      function addProduto : TRBDRomaneioOrcamentoItem;
  end;

Type
  TRBDTipoFiltroMenuFiscalECF =(tfPeriodo,tfCRZ,tfCOO);
  TRBDFormatoArquivoMenuFiscalECf = (faSintegra,faSped);
  TRBDFiltroMenuFiscalECF = class
    public
      NumIntervaloCRZInicio,
      NumIntervaloCRZFim,
      NumIntervaloCOOInicio,
      NumIntervaloCOOFim,
      NumUsuario : Integer;
      NumSerieECF : String;
      DatInicio,
      DatFim : TDateTime;
      IndMostrarPeriodo,
      IndMostrarCOO,
      IndMostrarCRZ,
      IndMostrarGerarArquivo,
      IndMostrarNumECF,
      IndMostrarFormatoArquivo,
      IndGerarArquivo : Boolean;
      TipFiltro : TRBDTipoFiltroMenuFiscalECF;
      TipFormatoArquivo : TRBDFormatoArquivoMenuFiscalECf;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDVendedor = class
    CodVendedor,
    TipComissao,
    TipValorComissao : Integer;
    NomVendedor,
    DesEmail : String;
    IndEnviaCopiaEmailNfe : boolean;
    constructor cria;
    destructor destroy;override;
  end;

Type
  TRBDExportacadoDadosErros = class
    public
      DesRegistro,
      NomTabela,
      DesErro :string;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDExportacaoDados = class
    public
      DatExportacao : TDateTime;
      ErrosExportacao : TList;
      ClientesNaoExportados,
      PedidosExportados,
      NotasExportadas,
      ContasaReceberExportados,
      ComissaoExportada,
      ClientesExportados : TStringList;

      constructor cria;
      destructor destroy;override;
      function AddErroExportacao(VpaNomTabela,VpaDesRegistro, VpaDesErro : String):TRBDExportacadoDadosErros;
  end;

Type             // 1           2         3          4
  TRBDTipoCampo =(tcInteiro,tcNumerico,tcCaracter, tcData);
  TRBDCamposImportacaoDados = class
    public
      NomCampo,
      NomCampoPai : String;
      TipCampo : TRBDTipoCampo;
    constructor cria;
    destructor destroy;override;
  end;


Type
  TRBDImportacaoDados = class
    public
      CodTabela : Integer;
      Nomtabela,
      NomTabelaPai,
      DesTabela,
      NomCampoData,
      DesFiltroVendedor : String;
      DatUltimaImportacao : TDateTime;
      CamposIgnorar : TStringList;
      CamposChavePrimaria,
      CamposChavePaiFilho : TList;
      constructor cria;
      destructor destroy;override;
      function addCampoFiltro : TRBDCamposImportacaoDados;
      function addCampoPaiFilho : TRBDCamposImportacaoDados;
  end;

Type
  TRBDRepresentada = class
    public
      CodRepresentada : Integer;
      NomRepresentada,
      NomFantasia,
      DesEmail,
      NomContado : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDFilial = class
    public
      CodFilial,
      CodIBGEMunicipio,
      CodAtividadeSpedFiscal,
      CodContabilidade,
      NumEndereco : Integer;
      NomFilial,
      NomFantasia,
      NomRepresentante,
      DesSite,
      DesEmail,
      DesEmailComercial,
      DesEndereco,
      DesEnderecoSemNumero,
      DesBairro,
      DesCidade,
      DesUF,
      DesCep,
      DesFone,
      DesFax,
      DesCNPJ,
      DesCPFRepresentante,
      DesCPFContador,
      DesCRCContador,
      NomContador,
      DesInscricaoEstadual,
      DesInscricaoMunicipal,
      DesPerfilSpedFiscal,
      DesCabecalhoEmailProposta,
      DesMeioEmailProposta,
      DesRodapeEmailProposta : String;
      IndEmiteNFE : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDNotaBlu = class
    public
      CodTipoRPS,
      NumNota,
      CodFiscalServico : Integer;
      DesSerieNota,
      DesSituacaoRPS,
      DesTipoPessoa,
      DesCNPJCPF,
      DesInscricaoEstadual,
      NomCliente,
      DesEndereco,
      DesNumeroEndereco,
      DesComplementoEndereco,
      DesBairro,
      DesCidade,
      DesUF,
      DesCEP,
      DesEmail,
      DesServico : String;
      DatEmissaoNota : TDateTime;
      ValServicos,
      PerISSQN : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDExportacaoRPS = class
    public
      CodFilial : Integer;
      DatInicio,
      DatFim : TDateTime;
      ValTotalServicos : Double;
      DFilial : TRBDFilial;
      Arquivo : TStringList;
      NotasBlu : TList;
      constructor cria;
      destructor destroy;override;
      function AddNotaBlu : TRBDNotaBlu;
  end;


Type
  TRBDDigitacaoProspectItem = class
    public
      CodProspect,
      CodRamoAtividade,
      CodHistorico : Integer;
      NomProspect,
      NomContato,
      NomContatoAnterior,
      NomRamoAtividade,
      NomHistorico,
      DesTipo,
      DesEndereco,
      DesEnderecoAnterior,
      DesBairro,
      DesBairroAnterior,
      DesCidade,
      DesUF,
      DesFone,
      DesFoneAnterior,
      DesCelular,
      DesCelularAnterior,
      DesEmail,
      DesEmailAnterior,
      DesObservacao : String;
      DatVisita : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDDigitacaoProspect = class
    public
      CodVendedor : Integer;
      Prospects : TList;
      constructor cria;
      destructor destroy;override;
      function AddProspectItem : TRBDDigitacaoProspectItem;
end;

Type
  TRBDPlanoContaOrcadoItem = class
    public
      NomPlanoContas,
      CodPlanoContas : String;
      ValJaneiro,
      ValFevereiro,
      ValMarco,
      ValAbril,
      ValMaio,
      ValJunho,
      ValJulho,
      ValAgosto,
      ValSetembro,
      ValOutubro,
      ValNovembro,
      ValDezembro,
      ValTotal : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDPlanoContaOrcado = class
    public
      AnoPlanoContaOrcado,
      CodEmpresa,
      CodCentroCusto : integer;
      PlanoContas : TList;
      constructor cria;
      destructor destroy;override;
      function AddPlanoContaItem : TRBDPlanoContaOrcadoItem;
  end;

Type
  TRBDEmailMarketing = class
    public
      SeqEmail : Integer;
      DesEmail,
      DesSenha : String;
      HorUltimoenvio : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDTipoCreditoDebito = (dcCredito,dcDebito,dcTodos);
  TRBDCreditoCliente = class
    public
      CodCliente,
      SeqCredito : Integer;
      ValInicial,
      ValCredito : Double;
      DatCredito : TDateTime;
      TipCredito : TRBDTipoCreditoDebito;
      DesObservacao : String;
      IndFinalizado : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDProdutoInteresseCliente = class
    public
      CodCliente,
      SeqProduto : Integer;
      CodProduto,
      NomProduto : String;
      QtdProduto : Double;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDClientePerdidoVendedor = class
    public
      SeqPerdido,
      CodVendedorDestino,
      CodUsuario,
      QtdDiasSemPedido,
      QtdDiasComPedido,
      QtdDiasSemTelemarketing,
      CodRegiaoVendas   : Integer;
      DatPerdido : TDateTime;
      IndCliente,
      IndProspect : Boolean;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDAgendaCliente = class
    public
      CodCliente,
      SeqVisita,
      CodTipoAgendamento,
      CodUsuario,
      CodVendedor: Integer;
      DatCadastro,
      DatVisita,
      DatFimVisita: TDateTime;
      IndRealizado,
      DesAgenda,
      DesRealizado: String;
      constructor Cria;
      destructor destroy; override;
end;

Type
  TRBDComprador = class
    public
      CodComprador : Integer;
      NomComprador,
      DesEmail : String;
      constructor cria;
      destructor destroy;override;
end;


type
  TRBDLembreteItem = class
    public
      IndMarcado: Boolean;
      CodUsuario,
      QtdVisualizacao: Integer;
      IndLido,
      NomUsuario: String;
      constructor Cria(VpaMarcado: Boolean);
      destructor Destroy; override;
end;

type
  TRBDLembreteCorpo = class
    public
      SeqLembrete,
      CodUsuario: Integer;
      DatLembrete,
      DatAgenda: TDateTime;
      IndAgendar,
      IndTodos,
      DesTitulo,
      DesLembrete: String;
      Usuarios: TList;
      constructor Cria;
      destructor Destroy; override;
      function AddUsuario: TRBDLembreteItem;
end;

type
  TRBDProdutoPendenteCompra = class
    public
      IndMarcado,
      IndAlterado : Boolean;
      SeqProduto,
      CodCor,
      SeqPedidoGerado: Integer;
      CodClassificacao,
      CodProduto,
      NomProduto,
      NomCor,
      DesTecnica,
      DesUM: String;
      QtdUtilizada,
      QtdAprovada,
      QtdComprada,
      QtdEstoque,
      QtdChapa,
      LarChapa,
      ComChapa : Double;
      DatAprovacao : TDateTime;
      SolicitacoesCompra : TList;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDChamadoParcial = class
    public
      CodFilial,
      NumChamado,
      SeqParcial,
      CodTecnico,
      CodUsuario : Integer;
      IndRetorno : Boolean;
      DatParcial : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDChamadoServicoOrcado = class
    public
      SeqItemOrcado,
      CodEmpresaServico,
      CodServico: Integer;
      QtdServico,
      ValUnitario,
      ValTotal: Double;
      IndAprovado: Boolean;
      NomServico: String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDChamadoProdutoOrcado = class
    public
      SeqItemOrcado,
      SeqProduto: Integer;
      Quantidade,
      ValUnitario,
      ValTotal: Double;
      CodProduto,
      DesUM,
      DesNumSerie,
      NomProduto: String;
      IndAprovado: Boolean;
      DatProducao: TDateTime;
      UnidadesParentes: TStringList;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDChamadoProdutoaProduzir = class
    public
      SeqItemOrcado,
      SeqProduto: Integer;
      Quantidade,
      ValUnitario,
      ValTotal: Double;
      CodProduto,
      DesUM,
      NomProduto: String;
      UnidadesParentes: TStringList;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDChamadoServicoExecutado = class
    public
      CodServico,
      CodEmpresaServico,
      SeqItemExecutado: Integer;
      NomServico: String;
      Quantidade,
      ValUnitario,
      ValTotal: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDComissaoClassificacaoVendedor = class
    public
      CodEmpresa,
      CodVendedor: Integer;
      TipClassificacao,
      CodClassificacao,
      NomVendedor: String;
      PerComissao: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaServico = class
    public
      SeqItem,
      CodEmpresaServico,
      CodServico,
      SeqProdutoChamado,
      SeqItemChamado: Integer;
      NomServico: String;
      QtdServico,
      ValUnitario,
      ValTotal: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaLocacaoFranquia = class
    public
      SeqItem,
      SeqItemFranquia,
      QtdFranquiaPB,
      QtdFranquiaColor: Integer;
      ValFranquia,
      ValExcedentePB,
      ValExcedenteColor: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaLocacaoCorpo = class
    public
      CodFilial,
      SeqProposta,
      SeqItem,
      SeqProduto: Integer;
      CodProduto,
      NomProduto,
      DesEmail: String;
      Franquias: TList;
      constructor Cria;
      destructor Destroy; override;
      function AddFranquia: TRBDPropostaLocacaoFranquia;
end;

type
  TRBDUsuarioVendedor = class
    public
      CodVendedor: Integer;
      NomVendedor: String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDSolicitacaoCompraFracaoOP = class
    public
      CodFilialFracao,
      SeqOrdem,
      SeqFracao: Integer;
      NomCliente: String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDSolicitacaoCompraItem = class
    public
      SeqItem,
      SeqProduto,
      CodCor,
      CodFilialFracao,
      SeqFracao,
      SeqOrdemProducao  : Integer;
      CodClassificacao,
      CodProduto,
      NomProduto,
      DesTecnica,
      NomCor,
      DesUM,
      UMOriginal: String;
      IndComprado: Boolean;
      UnidadesParentes: TStringList;
      QtdProduto,
      QtdEstoque,
      QtdAprovado,
      QtdComprado,
      QtdChapa,
      LarChapa,
      ComChapa,
      EspessuraAco,
      DensidadeVolumetricaAco : Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDSolicitacaoCompraCorpo = class
    public
      CodFilial,
      SeqSolicitacao,
      CodUsuario,
      CodUsuarioAprovacao,
      CodEstagio,
      CodComprador: Integer;
      DesSituacao,
      IndCancelado,
      DesObservacao: String;
      DatEmissao,
      HorEmissao,
      DatPrevista,
      DatFim,
      DatAprovacao: TDateTime;
      Produtos,
      Fracoes: TList;
      constructor Cria;
      destructor Destroy; override;
      function AddProduto: TRBDSolicitacaoCompraItem;
      function AddFracaoOP: TRBDSolicitacaoCompraFracaoOP;
end;

Type
  TRBDTarefaEMarketingProspectItem = class
    public
      CodProspect,
      SeqContato : Integer;
      constructor cria;
      destructor destroy;override;
end;


Type
  TRBDFormatoEmail = (feHTML,feTexto);
  TRBDTarefaEMarketingProspect = class
  private
    public
      SeqTarefa,
      QtdEmail : Integer;
      DesAssuntoEmail,
      DesLinkInternet,
      NomArquivoAnexo,
      DesTextoEmail : String;
      FormatoEmail : TRBDFormatoEmail;
      IndInterromper : Boolean;
      Itens : TList;
      constructor cria;
      destructor destroy; override;
      function addItem: TRBDTarefaEMarketingProspectItem;
end;

Type
  TRBDTarefaEMarketing = class
    public
      SeqTarefa,
      QtdEmail : Integer;
      DesAssuntoEmail,
      DesLinkInternet,
      NomArquivoAnexo,
      DesTextoEmail : String;
      FormatoEmail : TRBDFormatoEmail;
      IndInterromper : Boolean;
      constructor cria;
      destructor destroy; override;
end;

Type
  TRBDFracaoOPProdutoNaoComprado = class
    public
     SeqProduto,
     CodCor,
     CodFilialFracao,
     SeqFracao,
     SeqOrdemProducao : Integer;
     CodProduto,
     NomProduto,
     NomCor : String;
     QtdEstoque : Double;
     IndMarcado : Boolean;
     constructor cria;
     destructor destroy;override;
  end;

type
  TRBDFracaoOPPedidoCompra = class
    public
      CodFilialFracao,
      SeqOrdem,
      SeqFracao: Integer;
      NomCliente: String;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDProdutoPedidoCompraMateriaPrima = class
    public
      SeqProduto,
      CodCor,
      QtdChapa : Integer;
      CodProduto,
      NomProduto,
      NomCor : String;
      QtdProduto,
      LarChapa,
      ComChapa : double;
      constructor cria;
      destructor destroy;override;
  end;

type
  TRBDProdutoPedidoCompra = class
    public
      CodFilial,
      SeqPedido,
      SeqItem,
      SeqProduto,
      CodCor,
      CodTamanho: Integer;
      CodProduto,
      NomProduto,
      DesTecnica,
      NomCor,
      NomTamanho,
      DesUM,
      DesReferenciaFornecedor,
      CodClassificacaoFiscal: String;
      UnidadesParentes: TStringList;
      QtdProduto,
      QtdBaixado,
      QtdChapa,
      LarChapa,
      ComChapa,
      ValUnitario,
      ValTotal,
      QtdSolicitada,
      PerIPI,
      ValIPI,
      De,
      EspessuraAco,
      DensidadeVolumetricaAco : Double;
      DatAprovacao : TDateTime;
      MateriaPrima : TList;
      constructor Cria;
      destructor Destroy; override;
      function AddMateriaPrima :  TRBDProdutoPedidoCompraMateriaPrima;
end;

type
  TRBDTipoPedido =(tpPedidoCompra,tpTerceirizacao);
  TRBDPedidoCompraCorpo = class
    public
      Tipopedido : TRBDTipoPedido;
      CodFilial,
      CodFilialFaturamento,
      SeqPedido,
      CodCliente,
      CodUsuario,
      CodComprador,
      CodUsuarioAprovacao,
      NumDiasAtraso,
      CodCondicaoPagto,
      CodFormaPagto,
      CodTransportadora,
      CodEstagio,
      TipFrete: Integer;
      DesSituacao,
      IndCancelado,
      NomContato,
      DesEmailComprador,
      DesTelefone,
      DesObservacao: String;
      ValTotal,
      ValProdutos,
      ValIPI,
      PerDesconto,
      ValDesconto,
      ValFrete: Double;
      DatPedido,
      HorPedido,
      DatPrevista,
      DatPrevistaInicial,
      DatRenegociado,
      DatRenegociadoInicial,
      DatAprovacao,
      DatEntrega,
      DatPagamentoAntecipado: TDateTime;
      Produtos,
      FracaoOP: TList;
      constructor Cria;
      function AddProduto: TRBDProdutoPedidoCompra;
      function AddFracaoOP: TRBDFracaoOPPedidoCompra;
      destructor Destroy; override;
end;

type
  TRBDTelemarketingProspect = class
    public
      CodProspect,
      SeqTele,
      CodUsuario,
      CodFilial,
      SeqProposta,
      CodHistorico,
      CodVendedor,
      QtdSegundosLigacao: Integer;
      DataTempoLigacao: Double;
      DesFaladoCom,
      DesObservacao: String;
      IndAtendeu: Boolean;
      DatLigacao: TDateTime;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDContatoProspect = class
    public
      CodProspect,
      SeqContato,
      CodProfissao,
      CodUsuario,
      QtdVezesEmailInvalido : Integer;
      NomContato,
      NomProfissao,
      FonContato,
      CelContato,
      EmailContato,
      DesObservacoes,
      AceitaEMarketing: String;
      DatNascimento,
      DatCadastro: TDateTime;
      IndExportadoEficacia,
      IndEmailInvalido : Boolean;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaAmostra = class
    public
      SeqItem,
      CodCor,
      CodAmostra,
      CodAmostraIndefinida : Integer;
      NomCor,
      NomAmostra,
      DesImagem : String;
      QtdAmostra,
      ValUnitario,
      ValTotal: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaAmostraMotivoAtraso = class
    public
      SeqItem,
      CodCor,
      CodAmostra,
      CodMotivoAtraso,
      CodUsuario : Integer;
      DesObservacao : String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaCondicaoPagamento = class
    public
      CodCondicao: Integer;
      NomCondicao: String;
      IndAprovado: Boolean;
      constructor Cria;
      destructor Destroy; override;
  end;

type
  TRBDProdutoProspect = class
    public
      SeqProduto,
      CodProspect,
      SeqItem,
      CodDono,
      QtdCopias: Integer;
      CodProduto,
      NomProduto,
      NomDono,
      DesSetor,
      NumSerie,
      NumSerieInterno,
      DesUM,
      DesObservacao: String;
      QtdProduto,
      ValConcorrente: Double;
      DatGarantia,
      DatUltimaAlteracao: TDateTime;
      UnidadeParentes: TStringList;
      constructor Cria;
      Destructor Destroy; override;
end;




  TDadosBaixaCP = Class
    public
      CodFilial,
      LancamentoCP,
      NroParcela,
      NumParcelaParcial,
      CodUsuario,
      CodMoedaAtual,
      CodFormaPAgamento  : integer;
      DataVencimento,
      DataPagamento,
      DataVencimentoParcial   : TDateTime;
      ValorDesconto,
      valorAcrescimo,
      ValorPago,
      ValorTotalAserPago : Double;
      NumContaCaixa,
      Observacao,
      TipoFrmPagto,
      PlanoConta,
      FlagDespesaFixa       : String; // S/N
      IndGerouParcial : Boolean;
      Cheques : TList;
      Constructor cria;
      destructor destroy;override;
      function AddCheque : TRBDCheque;
  end;


Type
  TRBDAgendaProspect = class
    public
      CodProspect,
      SeqVisita,
      CodTipoAgendamento,
      CodUsuario,
      CodVendedor: Integer;
      DatCadastro,
      DatVisita,
      DatFimVisita: TDateTime;
      IndRealizado: Char;
      DesAgenda,
      DesRealizado: String;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDContatoCliente = class
    public
      DatNascimento: TDateTime;
      NomContato,
      DesTelefone,
      DesCelular,
      DesEMail,
      NomProfissao,
      DesObservacao,
      AceitaEMarketing: String;
      CodProfissao,
      CodUsuario,
      QtdVezesEmailInvalido: Integer;
      IndExportadoEficacia,
      IndEmailInvalido : Boolean;
      constructor cria;
      destructor destroy; override;
end;


type
  TRBDProspect = class
    public
      CodProspect,
      CodProfissao,
      CodVendedor,
      CodCliente,
      CodRamoAtividade,
      CodConcorrente,
      NumEndereco,
      QtdLigacaoSemProposta,
      QtdLigacaoComProposta: Integer;
      NomProspect,
      NomContato,
      NomFantasia,
      DesEmail,
      DesEmailContato,
      DesEnderecoCompleto,
      DesEndereco,
      DesComplementoEndereco,
      DesBairro,
      DesCep,
      DesCidade,
      DesUF,
      DesCNPJ,
      DesCPF,
      DESInscricaoEstadual,
      DesRG,
      DesTipoPessoa,
      DesFone,
      DesFax,
      DesFone1,
      DesFone2,
      DesObservacaoTelemarketing,
      DesObservacoes: String;
      IndAceitaTeleMarketing,
      IndAceitaSpam: Boolean;
      DatUltimaLigacao,
      DatNascimento: TDateTime;
      constructor cria;
      destructor destroy; override;
end;

Type
  TRBDPropostaProdutoASerRotulado = class
    public
      SeqItem,
      SeqProduto,
      CodFormatoFrasco,
      CodMaterialFrasco,
      AltFrasco,
      LarFrasco,
      ProfundidadeFrasco,
      DiametroFrasco,
      LarRotulo,
      LarContraRotulo,
      LarGargantilha,
      AltRotulo,
      AltContraRotulo,
      AltGargantilha,
      CodMaterialRotulo,
      CodLinerRotulo,
      CodMaterialContraRotulo,
      CodLinerContraRotulo,
      CodMaterialGargantilha,
      CodLinerGargantilha : Integer;
      CodProduto,
      NomProduto,
      NomFormatoFrasco,
      NomMaterialFrasco,
      NomMaterialRotulo,
      NomLinerRotulo,
      NomMaterialContraRotulo,
      NomLinerContraRotulo,
      NomMaterialGargantilha,
      NomLinerGargantilha,
      ObsProduto : String;
      QtdFrascosHora : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDPropostaProdutoSemQtd = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesUM : String;
      ValUnitario : Double;
      UnidadesParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDPropostaVendaAdicional = class
    public
      SeqProduto,
      CodCor : Integer;
      CodProduto,
      NomProduto,
      NomCor,
      DesUM,
      UMAnterior,
      UMOriginal : String;
      QtdProduto,
      ValUnitario,
      ValUnitarioOriginal,
      ValTotal : Double;
      UnidadesParentes : TStringList;
      constructor cria;
      destructor destroy;
end;

Type
  TRBDPropostaProduto = class
    public
      SeqMovimento,
      SeqProduto,
      CodCor,
      NumOpcao,
      SeqItemChamado,
      SeqProdutoChamado: Integer;
      CodProduto,
      NomProduto,
      DesCor,
      UM,
      UMAnterior,
      UMOriginal,
      PathFoto,
      CodReduzido,
      DesTecnica,
      DesObservacaoProduto :String;
      QtdProduto,
      QtdEstoque,
      ValUnitario,
      ValUnitarioOriginal,
      ValTotal,
      ValDesconto,
      PerIPI,
      ValIPI,
      PerMargemLucro : Double;
      UnidadeParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDPropostaMaterialAcabamento = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      UM : String;
      Quantidade: Integer;
      ValUnitario,
      ValTotal: Double;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDPropostaParcelas = class
    public
      SeqItem,
      CodFormaPagamento: Integer;
      ValPagamento: Double;
      DesCondicao,
      DesFormaPagamento:String;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDPropostaMaquinaCliente = class
    public
      CodFilial,
      SeqProposta,
      SeqItem,
      SeqProduto,
      CodEmbalagem,
      CodAplicacao: Integer;
      DesProducao,
      DesSentidoPassagem,
      DesDiametroCubo,
      DesObservacao: String;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDPropostaProdutoChamado = class
    public
      SeqItemChamado,
      SeqProdutoChamado : integer;
      ValTotal : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDPropostaCorpo = class
    public
      CodFilial,
      SeqProposta,
      CodSetor,
      CodProspect,
      CodCliente,
      CodCondicaoPagamento,
      CodFormaPagamento,
      CodConcorrente,
      CodMotivoVenda,
      CodProfissao,
      CodVendedor,
      CodUsuario,
      CodEstagio,
      CodTipoProposta,
      CodObsInstalacao,
      SeqProdutoInteresse,
      QtdPrazoEntrega,
      TipFrete,
      TipHorasInstalacao,
      TipModeloProposta : Integer;
      NomContato,
      NomSetor,
      DesEmail,
      DesEmailSetor,
      DesObservacao,
      DesObservacaoComercial,
      DesObservacaoInstalacao,
      DesRodapeSetor,
      DesGarantia,
      DesObsDataInstalacao : String;
      IndComprou,
      IndComprouConcorrente,
      IndDevolveraVazio : Boolean;
      PerDesconto,
      ValDesconto,
      ValConcorrente,
      ValFrete,
      ValTotal,
      ValTotalProdutos,
      ValTotalIpi : Double;
      DatProposta,
      DatValidade,
      DatPrevisaoCompra,
      DatPrevisaoVisitaTec : TDatetime;
      Produtos,
      ProdutosSemQtd,
      ProdutosASeremRotulados,
      MaquinasCliente,
      Amostras,
      Locacoes,
      Servicos,
      VendaAdicinal,
      ProdutosChamado,
      CondicaoPagamento,
      MaterialAcabamento,
      Parcelas : TList;
      constructor cria;
      destructor destroy;override;
      function addProduto : TRBDPropostaProduto;
      function addProdutoSemQtd : TRBDPropostaProdutoSemQtd;
      function addAmostra : TRBDPropostaAmostra;
      function AddLocacao: TRBDPropostaLocacaoCorpo;
      function AddServico: TRBDPropostaServico;
      function addProdutoAseremRotulados : TRBDPropostaProdutoASerRotulado;
      function addVendaAdicional : TRBDPropostaVendaAdicional;
      function addMaquinaCliente : TRBDPropostaMaquinaCliente;
      function addProdutoChamado : TRBDPropostaProdutoChamado;
      function addCondicaoPagamento: TRBDPropostaCondicaoPagamento;
      function addMaterialAcabamento: TRBDPropostaMaterialAcabamento;
      function addParcelas: TRBDPropostaParcelas;
end;

Type
  TRBDCotacaoGrafica = class
    QtdCorFrente,
    QtdCorVerso,
    QtdCopias,
    Altura,
    Largura : Integer;
    ValAcerto,
    ValTotal : Double;
    constructor cria;
    destructor destroy; override; 
end;

Type
  TRBDPesquisaSatisfacaoItem = class
    SeqPergunta,
    NumBomRuim,
    NumNota : Integer;
    DesSimNao,
    DesTexto : String;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDPesquisaSatisfacaoCorpo = Class
    public
      CodFilial,
      SeqPesquisa,
      CodPesquisa,
      CodUsuario,
      NumChamado,
      CodTecnico : Integer;
      DatPesquisa : TDateTime;
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function AddPesquisaItem : TRBDPesquisaSatisfacaoItem;
end;

Type
  TRBDColunaAgenda = class
    NomCampo : String;
    TamCampo : Integer;
end;

Type
  TRBDChamadoProdutoTrocado = class
    public
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesUM,
      UMOriginal : String;
      QtdProduto,
      ValUnitario,
      ValTotal : Double;
      UnidadeParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDChamadoProdutoExtra = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      UM,
      UMOriginal : String;
      QtdProduto,
      QtdBaixado : Double;
      IndFaturado : Boolean;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDChamadoAnexoImagem = class
    public
      SeqItem: Integer;
      DesCaminho:String;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDChamadoProduto = Class
    public
      CodFilialChamado,
      SeqItem,
      SeqContrato,
      SeqItemContrato,
      SeqItemProdutoCliente,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesContrato,
      NumSerie,
      NumSerieInterno,
      DesSetor,
      DesProblema,
      DesServicoExecutado,
      DesUM,
      DesUMOriginal : String;
      NumContador : Integer;
      DatGarantia : TDateTime;
      QtdProduto,
      QtdBaixado,
      QtdABaixar,
      ValBackup : Double;
      UnidadeParentes : TStringList;
      ProdutosTrocados,
      ServicosExecutados,
      ProdutosOrcados,
      ServicosOrcados,
      ProdutosaProduzir: TList;
      constructor cria;
      destructor destroy;override;
      function AddProdutoTrocado : TRBDChamadoProdutoTrocado;
      function AddServicoExecutado: TRBDChamadoServicoExecutado;
      function AddProdutoOrcado: TRBDChamadoProdutoOrcado;
      function AddProdutoaProduzir: TRBDChamadoProdutoaProduzir;
      function AddServicoOrcado: TRBDChamadoServicoOrcado;

end;

Type
  TRBDChamado = class
    public
      CodFilial,
      NumChamado,
      NumChamadoAnterior,
      CodCliente,
      CodHotel,
      CodTecnico,
      CodTipoChamado,
      CodUsuario,
      CodEstagio,
      NumModeloEmail : Integer;
      NomSolicitante,
      NomContato,
      DesEmail,
      DesEnderecoAtendimento,
      DesObservacaoGeral,
      DesTipoChamado : String;
      DatChamado,
      DatPrevisao : TDateTime;
      ValChamado,
      ValDeslocamento : Double;
      IndGarantia,
      IndPesquisaSatisfacao : Boolean;
      Produtos,
      ProdutosExtras,
      AnexoImagem : TList;
      constructor cria;
      destructor destroy;override;
      function AddProdutoChamado : TRBDChamadoProduto;
      function AddProdutoExtra : TRBDChamadoProdutoExtra;
      function AddAnexoImagem: TRBDChamadoAnexoImagem;
end;

Type
  TRBDAgendaSisCorp = class
    public
      CodUsuario,
      CodUsuarioAnterior,
      SeqAgenda,
      CodCliente,
      CodTipoAgendamento,
      CodUsuarioAgendou,
      CodFilialCompra,
      SeqPedidoCompra : Integer;
      DesTitulo,
      DesObservacoes : string;
      DatCadastro,
      DatInicio,
      DatFim,
      DatRealizado : TDatetime;
      IndRealizado,
      IndCancelado : boolean;
      constructor cria;
      destructor destroy;override;
end;

type
TRBDProdutoClientePeca = class
    public
      SeqItemPeca,
      SeqProdutoPeca: Integer;
      NumSerieProduto,
      CodProduto,
      NomProduto: string;
      DatInstalacao : TDatetime;
      constructor cria;
      destructor destroy;override;
end;


Type
  TRBDProdutoCliente = class
    public
      SeqProduto,
      SeqItem,
      CodDono,
      CodCliente,
      QtdCopias  : Integer;
      CodProduto,
      NomProduto,
      NumSerieProduto,
      NumSerieInterno,
      DesSetorEmpresa,
      NomDono,
      UM,
      UMOriginal,
      DesObservacoes : string;
      DatGarantia,
      DatUltimaAlteracao : TDatetime;
      UnidadeParentes : TStringList;
      ValConcorrente,
      QtdProduto : Double;
      Pecas: TList;
      constructor cria;
      destructor destroy;override;
      function addPecas: TRBDProdutoClientePeca;

end;

Type
  TRBDReciboLocacaoServico = class
    public
      SeqItem,
      CodServico : Integer;
      QtdServico,
      ValUnitario,
      ValTotal : Double;
    constructor cria;
    destructor destroy;override;
  end;

type
  TRBDReciboLocacao = class
    public
      CodFilial,
      SeqRecibo,
      LanOrcamento,
      SeqLeituraLocacao,
      CodCliente : Integer;
      DesOrdemCompra,
      DesObservacoes,
      DesObservacaoCotacao : String;
      IndCancelado : Boolean;
      DatEmissao : TDateTime;
      ValTotal : Double;
      Servicos : TList;
      constructor cria;
      destructor destroy;override;
      function addServico : TRBDReciboLocacaoServico;
end;

Type
  TRBDLeituraLocacaoItem = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      NumSerieProduto,
      NumSerieInterno,
      DesSetorEmpresa : String;
      QtdUltimaLeitura,
      QtdUltimaLeituraColor,
      QtdMedidorAtual,
      QtdMedidorAtualColor,
      QtdDefeitos,
      QtdDefeitosColor,
      QtdTotalCopias,
      QtdTotalCopiasColor  : Integer;
      DatUltimaLeitura : TDatetime;
      IndDesativar : Boolean;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDLeituraLocacaoCorpo = class
    public
      CodFilial,
      SeqLeitura,
      CodCliente,
      MesLocacao,
      AnoLocacao,
      SeqContrato,
      CodTecnicoLeitura,
      QtdCopias,
      QtdCopiasColor,
      QtdExcedente,
      QtdExcednteColor,
      QtdDefeitos,
      QtdDefeitosColor,
      LanOrcamento,
      CodUsuario,
      QtdFranquia,
      QtdFranquiaColor : Integer;
      DesObservacao,
      DesOrdemCompra :String;
      DatDigitacao,
      DatLeitura,
      DatProcessamento  : TDateTime;
      ValDesconto,
      ValTotal,
      ValTotalComDesconto,
      ValContrato,
      ValExcessoFranquia,
      ValExcessoFranquiaColor : Double;
      IndProcessamentoFrio : Boolean;
      ItensLeitura : TList;
      constructor cria;
      destructor destroy;override;
      function AddItemLeitura : TRBDLeituraLocacaoItem;
end;

Type
  TRBDBrindeCliente = class
    public
      SeqProduto,
      CodUsuario : Integer;
      CodProduto,
      NomProduto,
      NomUsuario,
      UM,
      UMOriginal : string;
      UnidadeParentes : TStringList;
      QtdProduto : Double;
      DatCadastro: TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDTelemarketingFaccionista = class
    public
      CodFaccionista,
      SeqTele,
      CodUsuario,
      CodHistorico,
      QtdSegundosLigacao : Integer;
      DesFaladoCom,
      DesObservacoes : String; 
      DatLigacao,
      DatPrometido : TDateTime;
      IndAtendeu,
      IndPrometeuData : Boolean;
     constructor cria;
     destructor destroy;override;
end;

Type
  TRBDTelemarketing = class
    public
      CodFilial,
      CodCliente,
      SeqTele,
      CodUsuario,
      SeqCampanha,
      LanOrcamento,
      CodHistorico,
      QtdDiasProximaLigacao,
      QtdSegundosLigacao,
      CodVendedor : Integer;
      DesFaladoCom,
      DesObservacao,
      DesObsProximaLigacao :String;
      DatLigacao,
      DatProximaLigacao,
      DatTempoLigacao : TDateTime;
      IndAtendeu,
      IndProximaLigacao : Boolean;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDContratoProcessadoItem = class
    public
      SeqContrato,
      LanOrcamento : Integer;
      IndProcessado : Boolean;
      DesErro : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDContratoProcessadoCorpo = class
    public
      CodFilial,
      SeqProcessado,
      CodUsuario : Integer;
      DatProcessado : TDateTime;
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function AddItem : TRBDContratoProcessadoItem;
end;

Type TRBDContratoServico = class
  public
    CodServico,
    CodFiscal : Integer;
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
  TRBDContratoItem = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      NumSerieProduto,
      NumSerieInterno,
      DesSetorEmpresa : String;
      QtdUltimaLeitura,
      QtdUltimaLeituraColor,
      QtdLeituraDesativacao,
      QtdLeituraDesativacaoColor : Integer;
      DatUltimaLeitura,
      DatDesativacao : TDatetime;
      ValCustoProduto: double;
      IndNumeroSerieDuplicado : Boolean;
      constructor cria;
      destructor destroy;override;

end;

Type
  TRBDContratoCorpo = class
    public
      CodFilial,
      SeqContrato,
      CodCliente,
      CodTipoContrato,
      QtdMeses,
      QtdFranquia,
      QtdFranquiaColorida,
      CodServico,
      CodVendedor,
      CodPreposto,
      CodTecnicoLeitura,
      CodCondicaoPagamento,
      CodFormaPagamento,
      NumTextoServico,
      TipPeriodicidade,
      NumDiaLeitura : Integer;
      NumContrato,
      NomContato,
      NomServico,
      NumContaBancaria,
      NotaFiscalCupom,
      DesEmail : String;
      DatAssinatura,
      DatInicioVigencia,
      DatFimVigencia,
      DatUltimaExecucao,
      DatCancelamento : TDateTime;
      ValContrato,
      ValExcedenteFranquia,
      ValExcedenteColorido,
      ValDesconto,
      PerComissao,
      PerComissaoPreposto,
      ValTotalServico : Double;
      IndNotaFiscal,
      IndRecibo,
      IndProcessamentoAutomatico : Boolean;
      ItensContrato : TList;
      ServicoContrato: TList;
      constructor cria;
      destructor destroy;override;
      function addItemContrato : TRBDContratoItem;
      function addServicoContrato: TRBDContratoServico;
end;

Type
  TRBDCobrancaItem = Class
    public
      CodFilial,
      LanReceber,
      NumParcela : Integer;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDCobrancoCorpo = class
    public
      SeqCobranca,
      CodHistorico,
      CodMotivo,
      CodUsuario,
      CodCliente : Integer;
      DesFaladoCom,
      DesObservacao,
      DesObsProximaLigacao : string;
      DatProximaLigacao,
      DatPromessa,
      DatCobranca : TDateTime;
      IndCobrarCliente,
      IndAtendeu : Boolean;
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function addItem : TRBDCobrancaItem;
end;

Type
  TRBDParenteCliente = class
    public
      CodCliente : Integer;
      NomCliente : String;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDFaixaEtariaCliente = class
    public
      CodFaixaEtaria : Integer;
      NomFaixaEtaria : String;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDMarcaCliente = Class
    public
      CodMarca : Integer;
      NomMarca  : String;
      constructor cria;
      destructor destroy;
end;

Type
  TRBDConhecimentoTransporte = class
    public
      CodTransportadora,
      CodFilial,
      SeqConhecimento,
      SeqNotaSaida,
      SeqNotaEntrada,
      NumTipoConhecimento,
      NumConhecimento,
      NumNota : Integer;
      DatConhecimento: TDateTime;
      ValConhecimento,
      ValorBaseIcms,
      ValorIcms,
      ValorNaoTributado,
      PesoFrete: Double;
      CodModeloDocumento,
      NumSerieNota: String;
    constructor cria;
    destructor destroy;
  end;

Type
  TRBDCliente = class
    public
      CodCliente,
      CodVendedor,
      CodProspect,
      CodVendedorPreposto,
      CodTecnico,
      CodCondicaoPagamento,
      CodFormaPagamento,
      CodTransportadora,
      CodRedespacho,
      CodTipoCotacao,
      CodTabelaPreco,
      CodConcorrente,
      CodProfissao,
      CodIBGECidade,
      CodPais,
      CodRamoAtividade,
      QtdLigacoesSemVenda,
      QtdLigacoesComVenda,
      SeqCampanha,
      QtdDiasProtesto,
      NumDiasEntrega : Integer;
      ValFrete: Double;
      CodPlanoContas,
      DesIdentificacaoBancariaFornecedor,
      NomCliente,
      NomFantasia,
      NomContato,
      NomContatoFinanceiro,
      NomContatoFornecedor,
      NomContatoEntrega,
      ContaBancariaDeposito,
      DesEndereco,
      DesEnderecoCobranca,
      DesEnderecoEntrega,
      DesEmail,
      DesEmailFinanceiro,
      DesEmailFornecedor,
      DesEmailNfe,
      DesComplementoEndereco,
      NumEndereco,
      NumEnderecoCobranca,
      NumEnderecoEntrega,
      DesBairro,
      DesBairroCobranca,
      DesBairroEntrega,
      CepCliente,
      CepClienteCobranca,
      CepEntrega,
      DesCidade,
      DesCidadeCobranca,
      DesCidadeEntrega,
      DesUF,
      DesUfCobranca,
      DesUFEntrega,
      CGC_CPF,
      RG,
      Fone_FAX,
      DesFone1,
      DesFone2,
      DesFone3,
      DesCelular,
      DesFoneFinanceiro,
      DesFax,
      TipoPessoa,
      InscricaoEstadual,
      DesObservacao,
      DesLigarDiaSemana,
      DesLigarPeriodo,
      DesObsTeleMarketing,
      DesPracaPagto,
      DesResolucaoProEmprego,
      DesUfEmbarque,
      DesLocalEmbarque :String;
      LimiteCredito,
      DuplicatasEmAberto,
      DuplicatasEmAtraso,
      PerComissao,
      PerDescontoFinanceiro,
      PerDescontoCotacao,
      PerISS : Double;
      IndFornecedor,
      IndRevenda,
      IndNotaFiscal,
      IndRecibo,
      IndDecimo,
      IndQuarto,
      IndMeia,
      IndVintePorcento,
      IndDescontarISS,
      IndAceitaTeleMarketing,
      IndPossuiContrato,
      IndPendenciaSerasa,
      IndProtestar,
      IndBloqueado,
      IndSimplesNacional,
      IndCobrarFormaPagamento,
      IndConsumidorFinal,
      IndDestacarICMSNota,
      IndUFConvenioSubstituicaoTributaria : Boolean;
      DatUltimoTeleMarketing,
      DatProximaLigacao,
      DatUltimaConsultaSerasa,
      DatUltimoRecebimento : TDateTime;
      constructor cria;
  end;

  TRBDTransportadora = class
    public
      Codigo   : String;
      Nome     : String;
      Endereco : String;
      NroEndereco: String;
      Bairro   : String;
      Cep      : String;
      Cidade   : String;
      UF       : String;
      CGC_CPF  : String;
      Telefone : string;
      PlacaVeic: String;
      UFPlaca  : String;
      InscricaoEstadual: String;
      Qtd      : Double;
      Especie  : String;
      Numero   : String;
      PesoBruto: Double;
      PesoLiq  : Double;
  end;

    TRBDDadosCedente = record
    CNPJ         : String;
    Nome         : String;
    CodigoCedente: String;
    DigitoCodigoCedente: String;

    {Endereço do cedente}
    Rua        : String;
    Numero     : String;
    Complemento: String;
    Bairro     : String;
    Cidade     : String;
    Estado     : String;
    CEP        : String;
    Email      : String;

    {Dados bancários do cedente}
    CodigoBanco : String;
    CodigoAgencia: String;
    DigitoAgencia: String;
    NumeroConta  : String;
    DigitoConta  : String;
  end;

  TRBDRetornoItem = class
    public
      CodOcorrencia,
      CodFilialRec,
      LanReceber,
      NumParcela,
      CodCancelada : Integer;
      NomOcorrencia,
      CodLiquidacao,
      DesLiquidacao,
      CodErros,
      DesErro,
      NumDuplicata,
      NomSacado,
      DesNossoNumero : String;
      IndProcessada,
      IndPossuiErro : Boolean;
      ValTitulo,
      ValLiquido,
      ValTarifa,
      ValOutrasDespesas,
      ValJuros : Double;
      DatOcorrencia,
      DatVencimento,
      DatCredito : TDateTime;
      constructor cria;
      destructor destroy;override;
  end;

  TRBDRetornoCorpo = class
    public
      CodFilial,
      SeqRetorno,
      SeqArquivo,
      CodBanco,
      CodUsuario,
      CodFornecedorBancario : Integer;
      NomArquivo,
      NomBanco,
      NumConta,
      NumConvenio : String;
      DatRetorno,
      DatGeracao,
      DatCredito : TDatetime;
      Itens : TList;
      constructor cria;
      destructor destroy;override;
      function addItem : TRBDREtornoItem;
  end;

  TRBDRemessaItem = class
    public
      NumNossoNumero,
      CNPJCedente,
      NumDuplicata,
      TipCliente,
      CPFCNPJCliente,
      NomCliente,
      EndCliente,
      DesFoneCliente,
      BaiCliente,
      CidCliente,
      CEPCliente,
      UFCliente : String;
      CodMovimento,
      DiasProtesto,
      CodFilial,
      LanReceber,
      NumParcela : Integer;
      ValMora,
      ValReceber,
      PerMulta : Double;
      DatEmissao,
      DatVencimento : TDateTime;
      IndDescontado : Boolean;
      constructor cria;
      destructor destroy;override;
  end;

  TRBDTipoRemessa =(trCNAB240,trCNAB400, trCNAB400BB);
  TRBDRemessaCorpo = class
    public
      CodFilial,
      SeqRemessa,
      CodBanco,
      CodUsuario,
      NumCarteira  : Integer;
      NumAgencia,
      NumConta,
      NomCorrentista,
      NomBanco,
      NumContrato,
      NumConvenioBanco,
      CodProdutoBanco : String;
      DatInicio,
      DatEnvio : TDateTime;
      IndEmiteBoleto : Boolean;
      TipRemessa : TRBDTipoRemessa;
      Itens : TList;
      constructor cria;
      destructor destroy;override;
      function addIten : TRBDRemessaItem;
  end;

  TRBDItemContasConsolidadasCR = class
    public
      LanReceber,
      NroParcela,
      NroNota,
      CodCondicaoPagamento,
      CodFormaPagamento,
      CodSituacao,
      CodMoeda : Integer;
      CodPlanoContas : String;
      DatEmissao,
      DatVencimento : TDateTime;
      Cliente : String;
      ValParcela : Double;
      constructor cria;
      destructor destroy;override;
  end;

  TRBDContasConsolidadasCR = class
    public
      LanReceber,
      CodFilial,
      CodCliente : Integer;
      CodPlanoContas,
      NroNotasFiscais : String;
      DatVencimento : TDateTime;
      PerDesconto,
      ValDesconto,
      ValConsolidacao : Double;
      ItemsContas : TList;
      constructor cria;
      destructor destroy;override;
      function AddItemConta : TRBDItemContasConsolidadasCR;
  end;

//classes da visulização dos arquivos de vendas do Pao de açucar
Type
  TRBDVendasPaoAcucar = class
    public
      CodProdutoEAN : Double;
      NomProduto : String;
      QtdVendida,
      QtdEntrada : Double;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDFiliaisVendasPaoAcucar = class
    public
      CodEanFilial,
      QtdVendidaTotal,
      QtdEntradaTotal : Double;
      NomFilial : String;
      Vendas : TList;
      constructor cria;
      destructor destroy;override;
      function AddVendasPaoAcucar : TRBDVendasPaoAcucar;
end;

Type
  TRBDDatasVendasPaoAcucar = class
    public
      DatVenda : TDateTime;
      Filiais : TList;
      constructor cria;
      destructor destroy;override;
      function AddFiliaisPaoAcucar : TRBDFiliaisVendasPaoAcucar;
end;

Type
  TRBDArquivoVendasPaoAcucar = class
    public
      Datas : TList;
      constructor cria;
      destructor destroy;override;
      function AddDAtaVendaPaoAcucar : TRBDDatasVendasPaoAcucar;
end;


Type
  TRBDNaturezaOperacao = class
    public
      SeqNatureza,
      CodOperacaoEstoque,
      CFOPProdutoIndustrializacao,
      CFOPProdutoRevenda,
      CFOPSubstituicaoTributariaRevenda,
      CFOPSubstituicaoTributariaIndustrializacao,
      CFOPServico : Integer;
      CodNatureza,
      NomOperacaoEstoque,
      TipOperacaoEstoque,
      FuncaoOperacaoEstoque,
      CodPlanoContas,
      CodCST,
      DesTextoFiscal : String;
      IndFinanceiro,
      IndBaixarEstoque,
      IndCalcularICMS,
      IndCalcularPis,
      IndCalcularCofins,
      IndMovimentacaoFisica,
      IndNotaDevolucao : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDSpedFiscalRegistroE520 = class
    public
      VL_SD_ANT_IPI,
      VL_DEB_IPI,
      VL_CRED_IPI,
      VL_OD_IPI,
      VL_OC_IPI,
      VL_SC_IPI,
      VL_SD_IPI : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDSpedFiscalRegistroE510 = class
    public
      CFOP : Integer;
      CST_IPI : String;
      VL_CONT_IPI,
      VL_BC_IPI,
      VL_IPI : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDSpedfiscalRegistroCOD_OR = (coICMSaRecolher,coICMSSTpelasEntradas,coICMSSTpelasSaidas,coAntecipacaoDiferencialAliquotaICMS,coAntecipacaoICMSImportacao,
                                  coAntecipacaoTributaria,coICMSFUNCEP,coOutrasObrigacoesICMS,coICMSSTpelasSaidasparaOutroEstado);
  TRBDSpedFiscalRegistroIND_PROC = (ipSEFAZ,ipJusticaFederal,ipJusticaEstadual,ipOutros);
  TRBDSpedFiscalRegistroE116 = class
    public
      COD_OR : TRBDSpedfiscalRegistroCOD_OR;
      VL_OR : Double;
      DT_VCTO : TDateTime;
      COD_REC,
      NUM_PROC  : String;
      IND_PROC : TRBDSpedFiscalRegistroIND_PROC;
      PROC,
      TXT_COMPL :String;
      MES_REF : TDatetime;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDSpedFiscalRegistroE110 = class
    VL_ICMS_RECOLHER : Double;
    VL_TOT_DEBITOS,
    VL_SLD_APURADO,
    VL_TOT_CREDITOS,
    VL_SLD_CREDOR_TRANSPORTAR,
    DEB_ESP : DOUBLE;
    Constructor cria;
    destructor destroy;override;
 end;

Type
  TRBDSpedfiscalRegistroC190 = class
    public
      CodCFOP : Integer;
      CodCST : String;
      PerICMS,
      ValOperacao,
      ValBaseCalculoICMS,
      ValICMS,
      ValBaseCalculoICMSSubstituica,
      ValICMSSubstituicao,
      ValReducaBaseCalculo,
      ValIPI : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDSpedFiscalRegistroIndMov = (imSim, imNao);
  TRBDSpedFiscalRegistroIndApur = (iaMensal, iaDecendial);
  TRBDSpedFiscalRegistroC170 = class //PRODUTOS DA NOTA
    public
      PerReducaoBaseCalculoICMS,
      ValAcrescimo,
      ValFrete : Double;
      NUM_ITEM : Integer;
      COD_ITEM,
      DESCR_COMPL : String;
      QTD : Double;
      UNID : string;
      VL_ITEM,
      VL_DESC : Double;
      IND_MOV : TRBDSpedFiscalRegistroIndMov;
      CST_ICMS : String;
      CFOP : Integer;
      COD_NAT : string;
      VL_BC_ICMS,
      ALIQ_ICMS,
      VL_ICMS,
      VL_BC_ICMS_ST,
      ALIQ_ST,
      VL_ICMS_ST : Double;
      IND_APUR : TRBDSpedFiscalRegistroIndApur;
      CST_IPI : string;
      COD_ENQ : String;
      VL_BC_IPI,
      ALIQ_IPI,
      VL_IPI : Double;
      CST_PIS : String;
      VL_BC_PIS,
      ALIQ_PIS_PER,
      QUANT_BC_PIS,
      ALIQ_PIS_VLR,
      VL_PIS : Double;
      CST_COFINS : String;
      VL_BC_COFINS,
      ALIQ_COFINS_PER,
      QUANT_BC_COFINS,
      ALIQ_COFINS_VLR,
      VL_COFINS : Double;
      COD_CTA : String;
      constructor cria;
      destructor destroy;override;
  end;


Type
  TRBDSpedFiscalRegistroC160 = class //Transportadora
    public
      IndTranporteProprio : Boolean;
      COD_PART : Integer;
      VEIC_ID : String;
      QTD_VOL : Integer;
      PESO_BRT,
      PESO_LIQ : Double;
      UF_ID : string;
      constructor cria;
      destructor destroy; override;
end;

Type
  TRBDSpedFiscalRegistroC141 = class //vencimento duplicatas
    public
      NUM_PARC : Integer;
      DT_VCTO : TDateTime;
      VL_PARC : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDSpedFiscalRegistroIndEmit = (ieEmissaoPropria,ieTerceiros);
  TRBDSpedFiscalRegistroC140IndTit = (itDuplicata,itCheque,itPromissoria,itRecibo,itOutros);
  TRBDSpedfiscalRegistroC140 = class //contas a receber geral
    public
      CodFilial,
      LanReceber,
      LanPagar : Integer;
      IND_EMIT : TRBDSpedFiscalRegistroIndEmit;
      IND_TIT : TRBDSpedFiscalRegistroC140IndTit;
      DESC_TIT,
      NUM_TIT : String;
      QTD_PARC : Integer;
      VL_TIT : Double;
      RegistrosC141 : TList;
      constructor cria;
      destructor destroy;override;
      function addRegistroC141 : TRBDSpedFiscalRegistroC141;
end;

Type
  TRBDSpedFiscalRegistroC110 = class //Dados adicionais da nota
    private
      ATXT_COMPL : String;
      procedure SetATXT_COMPL(VpaValor : string);
    public
      COD_INF : Integer;
      property TXT_COMPL : string read ATXT_COMPL write SetATXT_COMPL;
      constructor cria;
      destructor destroy;override;
  end;


Type
  TRBDSpedFiscalRegistroC100IndOper = (ioEntrada,ioSaida);
  TRBDSpedFiscalRegistroC100IndPgto = (ipAVista,ipAPrazo,ipSemPagamento);
  TRBDSpedFiscalRegistroC100IndFRT = (ifPorContaTerceiros,ifPorContadoEmitente,ifPorContadoDestinatario,ifSemCobrancafrete);
  TRBDSpedFiscalRegistroC100CodMOD = (cmModelo1ou1A,cmNfe);
  TRBDSpedFiscalRegistroC100CodSIT = (csDocumentoRegular,csEscrituracaoExtemporaneaRegular,csCancelado,csEscrituracaoExtemporaneaCancelado,csNFEouCTEDenegado,csNFEouCTENumeracaoInutilizada,csDocumentoFiscalComplentar,csEscrituracaoExtemporaneaComplentar,csDocumentoFiscalEspecial);
  TRBDspedFiscalRegistroC100 = class
  private
    function AddREgistroC190: TRBDSpedfiscalRegistroC190;  //cabecalho nota fiscal;
    public
      CodFilial,
      SeqNota : Integer;
      DesObservacoesNota : String;
      DNatureza : TRBDNaturezaOperacao;
      DCliente : TRBDCliente;
      IND_OPER : TRBDSpedFiscalRegistroC100IndOper;
      IND_EMIT : TRBDSpedFiscalRegistroIndEmit;
      COD_PART : Integer;
      COD_MOD : TRBDSpedFiscalRegistroC100CodMOD;
      COD_SIT : TRBDSpedFiscalRegistroC100CodSIT;
      SER : string;
      NUM_DOC : Integer;
      CHV_NFE : String;
      DT_DOC,
      DT_E_S  : TDateTime;
      VL_DOC : Double;
      IND_PAGTO : TRBDSpedFiscalRegistroC100IndPgto;
      VL_DESC,
      VL_ABAT_NT,
      VL_MERC : double;
      IND_FRT : TRBDSpedFiscalRegistroC100IndFRT;
      VL_FRT,
      VL_SEG,
      VL_OUT_DA,
      VL_BC_ICMS,
      VL_ICMS,
      VL_BC_ICMS_ST,
      VL_ICMS_ST,
      VL_IPI,
      VL_PIS,
      VL_COFINS,
      VL_PIS_ST,
      VL_COFINS_ST : Double;
      RegistroC140 : TRBDSpedfiscalRegistroC140;
      RegistroC160 : TRBDSpedFiscalRegistroC160;
      RegistrosC110,
      RegistrosC170,
      RegistrosC190 : Tlist;
      constructor cria;
      destructor destroy;override;
      function AddRegistroC110 : TRBDSpedFiscalRegistroC110;
      function AddRegistroC170 : TRBDSpedFiscalRegistroC170;
      function RRegistroC190(VpaCodCST : String; VpaCodCFOP : Integer; VpaPerICMS : Double):TRBDSpedfiscalRegistroC190;
  end;

Type
  TRBDSpedFiscalRegistroC321 = class
    public
      CodProduto,
      DesUM : String;
      QtdProduto,
      ValItem,
      ValDesconto,
      ValBCICMS,
      ValICMS,
      ValPIS,
      ValCofins :Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDSpedFiscalRegistroC320 = class
    public
      CodCST,
      CodCFOP : Integer;
      PerICMS,
      ValOperacao,
      ValBcICMS,
      ValICMS,
      ValReducaoBC : Double;
      RegistrosC321 : TList;
      constructor cria;
      destructor destroy;override;
      function AddRegistroC321 :TRBDSpedFiscalRegistroC321;
  end;

Type
  TRBDSpedFiscalRegistroC300 = class
    public
      DesSerieNota,
      DesSubSerieNota : String;
      NumDocumentoInicial,
      NumDocumentoFinal : Integer;
      DatDocumento : TDateTime;
      ValDocumento,
      ValPis,
      ValCofins : Double;
       RegistrosC320 : TList;
      constructor cria;
      destructor destroy;override;
      function addRegistroC320 : TRBDSpedFiscalRegistroC320;
  end;

Type
  TRBDSpedFiscalRegistroC425 = class
    public
      CodProduto,
      DesUM :string;
      QtdProduto,
      ValTotal,
      ValPis,
      ValCofins : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDSpedFiscalRegistroC420 = class
    public
      CodTotalizadorParcial :string;
      ValAcumulado : Double;
      RegistrosC425 :TList;
      constructor cria;
      destructor destroy;override;
      function addRegistroC425 : TRBDSpedFiscalRegistroC425;
  end;

Type
  TRBDSpedFiscalRegistroC405 = class
    public
      NumCRO,
      NumCRZ,
      NumCOO :Integer;
      NumSerieECF : String;
      DatMovimento : TDateTime;
      ValVendaBrutaDiaria,
      ValGrandeTotal : Double;
      RegistrosC420 : TList;
      constructor cria;
      destructor destroy;override;
      function addRegistroC420 : TRBDSpedFiscalRegistroC420;
  end;

Type
  TRBDSpedFiscalRegistroC400 = class
    public
      CodModeloDocumento,
      CodModeloECF,
      DesSerie :String;
      NumCaixa : Integer;
      RegistrosC405 : TList;
      constructor cria;
      destructor destroy;override;
      function addRegistroC405 : TRBDSpedFiscalRegistroC405;
  end;

Type
  TRBDSpedFiscalRegistroC490 = class
    public
      CODCST,
      CodCFOP : Integer;
      PerICMS : Double;
      ValProdutos,
      ValBaseCalculo,
      ValICMS : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDSpedFiscalRegistroD100 = class
    public
      CodParticipante,
      NumDocumentoFiscal : Integer;
      CodModeloDocumento,
      DesSerieDocumentoFiscal,
      DesSubSerieDocumentoFiscal : String;
      DatDocumentoFiscal,
      DatAquisicaoServico : TDateTime;
      ValDocumento,
      ValDesconto,
      ValServico,
      ValBaseICMS,
      ValICMS,
      ValNaoTributado : Double;
      IndFrete : TRBDSpedFiscalRegistroC100IndFRT;
      CodSituacao : TRBDSpedFiscalRegistroC100CodSIT;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDSpedFiscalRegistro0450 = class
    private
      ADesInformacao : String;
      procedure SetDesInformacao(VpaValor : string);
    public
      CodInformacao,
      SeqNatureza  : Integer;
      property DesInformacao : string read ADesInformacao write SetDesInformacao;
      constructor cria;
      destructor destroy;override;
  end;


Type
  TRBCod_Fin = (cfRemessaOriginal,cfRemessaSubtituto);
  TRBDSpedFiscal = class
    public
     CodFilial,
     CodModeloDocumento,
     NumNota : integer;
     DatInicio,
     DatFinal : TDateTime;
     IndEntradas,
     IndSaidas,
     IndConsistirDados : Boolean;
     PerICMSInterno : Double;
     CodFinalidade : TRBCod_Fin;
     DFilial : TRBDFilial;
     DContabilidade : TRBDCliente;
     QtdLinhasBloco0,
     QtdLinhasBlocoC,
     QtdLinhasBlocoD,
     QtdLinhasBlocoE,
     QtdLinhasBlocoG,
     QtdLinhasBlocoH,
     QtdLinhasBloco1,
     QtdLinhasBloco9 : Integer;
     QtdLinhasRegistro0150,
     QtdLinhasRegistro0190,
     QtdLinhasRegistro0200,
     QtdLinhasRegistro0400,
     QtdLinhasRegistro0450,
     QtdLinhasRegistroC100,
     QtdLinhasRegistroC110,
     QtdLinhasRegistroC140,
     QtdLinhasRegistroC141,
     QtdLinhasRegistroC160,
     QtdLinhasRegistroC170,
     QtdLinhasRegistroC190,
     QtdLinhasRegistroC300,
     QtdLinhasRegistroC320,
     QtdLinhasRegistroC321,
     QtdLinhasRegistroC400,
     QtdLinhasRegistroC405,
     QtdLinhasRegistroC420,
     QtdLinhasRegistroC425,
     QtdLinhasRegistroD100,
     QtdLinhasREgistroE116,
     QtdLinhasREgistroE510,
     QtdLinhasRegistro9900     : Integer;
     Arquivo,
     Incosistencias : TStringList;
     Registros0450,
     RegistrosC100,
     RegistrosC300,
     RegistrosC400,
     RegistrosC490,
     RegistrosD100,
     RegistrosE116,
     RegistrosE510  : TList;
     RegistroE110 : TRBDSpedFiscalRegistroE110;
     RegistroE520 : TRBDSpedFiscalRegistroE520;
     constructor cria;
     destructor destroy;override;
     function addRegistro0450 : TRBDSpedFiscalRegistro0450;
     function addRegistrC100 : TRBDspedFiscalRegistroC100;
     function addRegistroC300 : TRBDSpedFiscalRegistroC300;
     function addRegistroC400 : TRBDSpedFiscalRegistroC400;
     function addRegistroC490 : TRBDSpedFiscalRegistroC490;
     function addRegistroD100 : TRBDSpedFiscalRegistroD100;
     function AddRegistroE116 : TRBDSpedFiscalRegistroE116;
     function RRegistroE510(VpaCFOP : Integer;VpaCSTIPI : String) : TRBDSpedFiscalRegistroE510;
  end;

Type
  TRBDEEstagioProducaoGrupoUsuario = class
     CodGrupoUsuario,
     CodEstagio: Integer;
     NomEstagio: String;
     constructor cria;
  end;

Type
  TRBDEmailMedidorItem = class
  public
    CodFilial,
    SeqContrato: Integer;
    Enviado: Char;
    Status: String;
    constructor cria;
  end;

Type
  TRBDEmailMedidorCorpo = class
  public
    Emails: TList;
    SeqEmail,
    CodUsuario: Integer;
    DataEnvio: TDateTime;
    constructor cria;
    destructor destroy; override;
    function AddItem: TRBDEmailMedidorItem;
  end;

Type
  TRBDEmailECobrancaCompraItem = class
  public
    CodFilial,
    SeqPedido: Integer;
    Enviado: Char;
    Status,
    NomFornecedor: String;
    constructor cria;
  end;
Type
  TRBDEmailECobrancaCompraCorpo = class
    Emails: TList;
    SeqEmail,
    CodUsuario: Integer;
    DataEnvio: TDateTime;
    constructor cria;
    destructor destroy; override;
    function AddItem: TRBDEmailECobrancaCompraItem;
  end;

Type
  TRBDOrcamentoRoteiroEntrega = class
  public
    SeqOrcamentoRoteiro,
    CodEntregador: Integer;
    DataAbertura,
    DataFechamento: TDateTime;
  end;

Type
  TRBDOrcamentoRoteiroEntregaItem = class
  public
    SeqOrcamentoRoteiro,
    SeqOrcamento,
    CodFilialOrcamento: Integer;
  end;

implementation

Uses FunObjeto, FunData, FunString;

{******************************************************************************}
constructor TRBDDigitacaoProspectItem.cria;
begin

end;

{******************************************************************************}
destructor TRBDDigitacaoProspectItem.destroy;
begin

end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDDigitacaoProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDDigitacaoProspect.cria;
begin
  inherited create;
  Prospects := TList.create;
end;

{******************************************************************************}
destructor TRBDDigitacaoProspect.destroy;
begin
  FreeTObjectsList(Prospects);
  Prospects.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDDigitacaoProspect.AddProspectItem : TRBDDigitacaoProspectItem;
begin
  result := TRBDDigitacaoProspectItem.cria;
  Prospects.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDCreditoCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDEmailMarketing.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEmailMarketing.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDCreditoCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCreditoCliente.cria;
begin
  inherited create;
  IndFinalizado := false;
end;

{******************************************************************************}
destructor TRBDCreditoCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      TRBDProdutoInteresseCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDProdutoInteresseCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoInteresseCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      TRBDClientePerdidoVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDClientePerdidoVendedor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDClientePerdidoVendedor.destroy;
begin
  Inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      TRBDAgendaCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAgendaCliente.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDAgendaCliente.destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDProdutoPendenteCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComprador.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDComprador.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDLembreteItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLembreteItem.Cria(VpaMarcado: Boolean);
begin
  inherited Create;
  IndMarcado:= VpaMarcado;
end;

{******************************************************************************}
destructor TRBDLembreteItem.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   TRBDLembrete
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLembreteCorpo.Cria;
begin
  inherited Create;
  Usuarios:= TList.Create;
end;

{******************************************************************************}
destructor TRBDLembreteCorpo.Destroy;
begin
  FreeTObjectsList(Usuarios);
  Usuarios.Free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDLembreteCorpo.AddUsuario: TRBDLembreteItem;
begin
  Result:= TRBDLembreteItem.Cria(False);
  Usuarios.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDProdutoPendenteCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoPendenteCompra.Cria;
begin
  inherited Create;
  SolicitacoesCompra:= TList.Create;
  SeqPedidoGerado:= 0;
  IndAlterado := false;
end;

{******************************************************************************}
destructor TRBDProdutoPendenteCompra.Destroy;
begin
  // não limpar o conteudo da lista de orçamentos por aqui, porque podem existir
  // N orçamentos para N produtos pendentes, deve ser feito um controle externo.
  SolicitacoesCompra.Free;
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoParcial.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDChamadoParcial.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoServicoOrcado.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDChamadoServicoOrcado.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRBDChamadoProdutoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProdutoOrcado.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDChamadoProdutoOrcado.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDChamadoServicoExecutado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoServicoExecutado.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDChamadoServicoExecutado.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       TRBDComissaoClassificacaoVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComissaoClassificacaoVendedor.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDComissaoClassificacaoVendedor.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               TRBDPropostaServico
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaServico.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaServico.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            TRBDPropostaLocacaoFranquia
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaLocacaoFranquia.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaLocacaoFranquia.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDProspostaLocacaoCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaLocacaoCorpo.Cria;
begin
  inherited Create;
  Franquias:= TList.Create;
end;

{******************************************************************************}
destructor TRBDPropostaLocacaoCorpo.Destroy;
begin
  FreeTObjectsList(Franquias);
  Franquias.Free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDPropostaLocacaoCorpo.AddFranquia: TRBDPropostaLocacaoFranquia;
begin
  Result:= TRBDPropostaLocacaoFranquia.Cria;
  Franquias.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDUsuarioVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDUsuarioVendedor.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDUsuarioVendedor.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDOrcamentoCompraFracaoOP
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSolicitacaoCompraFracaoOP.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDSolicitacaoCompraFracaoOP.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDOrcamentoCompraItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSolicitacaoCompraItem.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDSolicitacaoCompraItem.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            TRBDSolicitacaoCompraCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSolicitacaoCompraCorpo.Cria;
begin
  inherited Create;
  Produtos:= TList.Create;
  Fracoes:= TList.Create;
end;

{******************************************************************************}
destructor TRBDSolicitacaoCompraCorpo.Destroy;
begin
  FreeTObjectsList(Produtos);
  Produtos.Free;
  FreeTObjectsList(Fracoes);
  Fracoes.Free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDSolicitacaoCompraCorpo.AddFracaoOP: TRBDSolicitacaoCompraFracaoOP;
begin
  Result:= TRBDSolicitacaoCompraFracaoOP.Cria;
  Fracoes.Add(Result);
end;

{******************************************************************************}
function TRBDSolicitacaoCompraCorpo.AddProduto: TRBDSolicitacaoCompraItem;
begin
  Result:= TRBDSolicitacaoCompraItem.Cria;
  Produtos.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDTarefaEMarketingProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDTarefaEMarketingProspect.addItem: TRBDTarefaEMarketingProspectItem;
begin
  result := TRBDTarefaEMarketingProspectItem.cria;
  Itens.Add(result);
end;

{******************************************************************************}
constructor TRBDTarefaEMarketingProspect.cria;
begin
  inherited create;
  Itens := TList.Create;
  IndInterromper := false;
end;

{******************************************************************************}
destructor TRBDTarefaEMarketingProspect.destroy;
begin
  FreeTObjectsList(Itens);
  Itens.Free;
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDTarefaEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDTarefaEMarketing.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTarefaEMarketing.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDFracaoOPPedidoCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFracaoOPPedidoCompra.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDFracaoOPPedidoCompra.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDProdutoPedidoCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDProdutoPedidoCompra.AddMateriaPrima: TRBDProdutoPedidoCompraMateriaPrima;
begin
  result := TRBDProdutoPedidoCompraMateriaPrima.cria;
  MateriaPrima.Add(result);
end;

{******************************************************************************}
constructor TRBDProdutoPedidoCompra.Cria;
begin
  inherited Create;
  MateriaPrima := TList.Create;
end;

{******************************************************************************}
destructor TRBDProdutoPedidoCompra.Destroy;
begin
  FreeTObjectsList(MateriaPrima);
  MateriaPrima.Free;
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDPedidoCompraCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPedidoCompraCorpo.Cria;
begin
  inherited Create;
  Produtos:= TList.Create;
  FracaoOP:= TList.Create;
  DatPrevistaInicial := montadata(1,1,1900);
  DatRenegociadoInicial := montadata(1,1,1900);
end;

{******************************************************************************}
function TRBDPedidoCompraCorpo.AddProduto: TRBDProdutoPedidoCompra;
begin
  Result:= TRBDProdutoPedidoCompra.Cria;
  result.QtdProduto := 0;
  Result.QtdSolicitada := 0;
  Result.QtdChapa := 0;
  Produtos.Add(Result);
end;

{******************************************************************************}
function TRBDPedidoCompraCorpo.AddFracaoOP: TRBDFracaoOPPedidoCompra;
begin
  Result:= TRBDFracaoOPPedidoCompra.Cria;
  FracaoOP.Add(Result);
end;

{******************************************************************************}
destructor TRBDPedidoCompraCorpo.Destroy;
begin
  FreeTObjectsList(Produtos);
  FreeTObjectsList(FracaoOP);
  Produtos.Free;
  FracaoOP.Free;
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDTelemarketingProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDTelemarketingProspect.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDTelemarketingProspect.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDContatoProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContatoProspect.Cria;
begin
  inherited Create;
  IndExportadoEficacia := false;
  IndEmailInvalido := false;
  DatCadastro := now;
end;

{******************************************************************************}
destructor TRBDContatoProspect.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDPropostaAmostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaAmostra.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaAmostra.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDProdutoProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoProspect.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDProdutoProspect.Destroy;
begin
  inherited Destroy;
end;


{#############################################################################
                     Classe do conta a pagar
#############################################################################  }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                  Baixa Contas a Pagar
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TDadosBaixaCP.cria;
begin
  inherited create;
  Cheques := TList.create;
end;

{******************************************************************************}
destructor TDadosBaixaCP.destroy;
begin
  FreeTObjectsList(Cheques);
  Cheques.free;
  inherited destroy;
end;

{******************************************************************************}
function TDadosBaixaCP.AddCheque : TRBDCheque;
begin
  result := TRBDCheque.cria;
  Cheques.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDAgendaProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAgendaProspect.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDAgendaProspect.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe Contatos do Cliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContatoCliente.cria;
begin
  inherited create;
  IndExportadoEficacia := false;
  IndEmailInvalido := false;
end;

{******************************************************************************}
destructor TRBDContatoCliente.destroy;
begin
  inherited destroy;
end;
    
{******************************************************************************}
constructor TRBDFilial.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFilial.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do prospect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProspect.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProspect.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaProdutoASerRotulado.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaProdutoASerRotulado.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaProdutoSemQtd.cria;
begin
  inherited create;
  UnidadesParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDPropostaProdutoSemQtd.destroy;
begin
  UnidadesParentes.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da TRBDPropostaVendaAdicional
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaVendaAdicional.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaVendaAdicional.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaProduto.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaProduto.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaCorpo.cria;
begin
  inherited create;
  Produtos := TList.create;
  ProdutosASeremRotulados := TList.Create;
  Amostras := TList.Create;
  Locacoes:= TList.Create;
  Servicos:= TList.Create;
  ProdutosSemQtd := TList.Create;
  VendaAdicinal := TList.create;
  MaquinasCliente := TList.Create;
  ProdutosChamado := TList.Create;
  CondicaoPagamento:= TList.Create;
  MaterialAcabamento:= TList.Create;
  Parcelas:= TList.Create;
end;

{******************************************************************************}
destructor TRBDPropostaCorpo.destroy;
begin
  FreeTObjectsList(Produtos);
  FreeTObjectsList(Amostras);
  FreeTObjectsList(Locacoes);
  FreeTObjectsList(Servicos);
  FreeTObjectsList(ProdutosASeremRotulados);
  FreeTObjectsList(ProdutosSemQtd);
  FreeTObjectsList(VendaAdicinal);
  FreeTObjectsList(MaquinasCliente);
  FreeTObjectsList(ProdutosChamado);
  FreeTObjectsList(CondicaoPagamento);
  FreeTObjectsList(MaterialAcabamento);
  FreeTObjectsList(Parcelas);
  Produtos.free;
  Amostras.Free;
  Locacoes.Free;
  Servicos.Free;
  ProdutosASeremRotulados.free;
  MaquinasCliente.Free;
  ProdutosSemQtd.free;
  VendaAdicinal.free;
  CondicaoPagamento.Free;
  MaterialAcabamento.Free;
  Parcelas.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDPropostaCorpo.addMaquinaCliente: TRBDPropostaMaquinaCliente;
begin
  result := TRBDPropostaMaquinaCliente.cria;
  MaquinasCliente.Add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addMaterialAcabamento: TRBDPropostaMaterialAcabamento;
begin
  result:= TRBDPropostaMaterialAcabamento.cria;
  MaterialAcabamento.Add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addProduto : TRBDPropostaProduto;
begin
  result := TRBDPropostaProduto.cria;
  Produtos.add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addProdutoSemQtd : TRBDPropostaProdutoSemQtd;
begin
  result := TRBDPropostaProdutoSemQtd.cria;
  ProdutosSemQtd.add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addAmostra: TRBDPropostaAmostra;
begin
  Result:= TRBDPropostaAmostra.Cria;
  Amostras.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addCondicaoPagamento: TRBDPropostaCondicaoPagamento;
begin
  Result:= TRBDPropostaCondicaoPagamento.Cria;
  CondicaoPagamento.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addParcelas: TRBDPropostaParcelas;
begin
  Result:= TRBDPropostaParcelas.cria;
  Parcelas.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.AddLocacao: TRBDPropostaLocacaoCorpo;
begin
  Result:= TRBDPropostaLocacaoCorpo.Cria;
  Locacoes.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.AddServico: TRBDPropostaServico;
begin
  Result:= TRBDPropostaServico.Cria;
  Servicos.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addProdutoAseremRotulados : TRBDPropostaProdutoASerRotulado;
begin
  result := TRBDPropostaProdutoASerRotulado.Cria;
  ProdutosASeremRotulados.add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addProdutoChamado: TRBDPropostaProdutoChamado;
begin
  result := TRBDPropostaProdutoChamado.Create;
  ProdutosChamado.Add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addVendaAdicional : TRBDPropostaVendaAdicional;
begin
  result := TRBDPropostaVendaAdicional.cria;
  VendaAdicinal.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da cotacao grafica
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCotacaoGrafica.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCotacaoGrafica.destroy;
begin
  inherited destroy;
end;
                    
{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da pesquisa de satisfação
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPesquisaSatisfacaoItem.cria;
begin
  inherited create;
  NumNota := -1
end;

{******************************************************************************}
destructor TRBDPesquisaSatisfacaoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da pesquisa de satisfação
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPesquisaSatisfacaoCorpo.cria;
begin
  inherited create;
  Items := TList.create;
end;

{******************************************************************************}
destructor TRBDPesquisaSatisfacaoCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDPesquisaSatisfacaoCorpo.AddPesquisaItem : TRBDPesquisaSatisfacaoItem;
begin
  result := TRBDPesquisaSatisfacaoItem.cria;
  Items.add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do Produto Trocado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProdutoTrocado.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDChamadoProdutoTrocado.destroy;
begin
  UnidadeParentes.free;
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do chamado Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProdutoExtra.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDChamadoProdutoExtra.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do chamado Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProduto.cria;
begin
  inherited create;
  ProdutosTrocados := TList.create;
  ServicosExecutados:= TList.Create;
  ProdutosOrcados:= TList.Create;
  ProdutosaProduzir:= TList.Create;
  ServicosOrcados:= TList.Create;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDChamadoProduto.destroy;
begin
  FreeTObjectsList(ServicosExecutados);
  ServicosExecutados.Free;
  FreeTObjectsList(ProdutosTrocados);
  ProdutosTrocados.free;
  FreeTObjectsList(ProdutosOrcados);
  ProdutosOrcados.Free;
  FreeTObjectsList(ServicosOrcados);
  ServicosOrcados.Free;
  FreeTObjectsList(ProdutosaProduzir);
  ProdutosaProduzir.Free;
  UnidadeParentes.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDChamadoProduto.AddProdutoTrocado : TRBDChamadoProdutoTrocado;
begin
  result := TRBDChamadoProdutoTrocado.cria;
  ProdutosTrocados.add(result);
end;

{******************************************************************************}
function TRBDChamadoProduto.AddServicoExecutado: TRBDChamadoServicoExecutado;
begin
  Result:= TRBDChamadoServicoExecutado.Cria;
  ServicosExecutados.Add(Result);
end;

{******************************************************************************}
function TRBDChamadoProduto.AddProdutoaProduzir: TRBDChamadoProdutoaProduzir;
begin
  Result:= TRBDChamadoProdutoaProduzir.Cria;
  ProdutosaProduzir.Add(Result);
end;

{******************************************************************************}
function TRBDChamadoProduto.AddProdutoOrcado: TRBDChamadoProdutoOrcado;
begin
  Result:= TRBDChamadoProdutoOrcado.Cria;
  ProdutosOrcados.Add(Result);
end;

{******************************************************************************}
function TRBDChamadoProduto.AddServicoOrcado: TRBDChamadoServicoOrcado;
begin
  Result:= TRBDChamadoServicoOrcado.Cria;
  ServicosOrcados.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do chamado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamado.cria;
begin
  inherited create;
  IndPesquisaSatisfacao := false;
  Produtos := TList.create;
  ProdutosExtras := TList.Create;
  AnexoImagem:= TList.Create;
end;

{******************************************************************************}
destructor TRBDChamado.destroy;
begin
  FreeTObjectsList(Produtos);
  Produtos.free;
  FreeTObjectsList(ProdutosExtras);
  ProdutosExtras.free;
  FreeTObjectsList(AnexoImagem);
  AnexoImagem.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDChamado.AddAnexoImagem: TRBDChamadoAnexoImagem;
begin
  result := TRBDChamadoAnexoImagem.cria;
  AnexoImagem.add(result);
end;

{******************************************************************************}
function TRBDChamado.AddProdutoChamado : TRBDChamadoProduto;
begin
  result := TRBDChamadoProduto.cria;
  produtos.add(result);
end;

{******************************************************************************}
function TRBDChamado.AddProdutoExtra : TRBDChamadoProdutoExtra;
begin
  result := TRBDChamadoProdutoExtra.cria;
  ProdutosExtras.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do produto do cliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAgendaSisCorp.cria;
begin
  inherited create;
  IndCancelado := false;
  IndRealizado := false;
end;

{******************************************************************************}
destructor TRBDAgendaSisCorp.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do produto do cliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
function TRBDProdutoCliente.addPecas: TRBDProdutoClientePeca;
begin
  result := TRBDProdutoClientePeca.cria;
  Pecas.add(result);
end;

{******************************************************************************}
constructor TRBDProdutoCliente.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.create;
  Pecas:= TList.Create;
end;

{******************************************************************************}
destructor TRBDProdutoCliente.destroy;
begin
  UnidadeParentes.free;
  FreeAndNil(Pecas);
  Pecas.Free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do leitura contrato item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLeituraLocacaoItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDLeituraLocacaoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do leitura contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLeituraLocacaoCorpo.cria;
begin
  inherited create;
  ItensLeitura := TList.Create;
  IndProcessamentoFrio := false;
end;

{******************************************************************************}
destructor TRBDLeituraLocacaoCorpo.destroy;
begin
  FreeTObjectsList(ItensLeitura);
  ItensLeitura.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDLeituraLocacaoCorpo.AddItemLeitura : TRBDLeituraLocacaoItem;
begin
  result := TRBDLeituraLocacaoItem.cria;
  ItensLeitura.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDBrindeCliente.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDBrindeCliente.destroy;
begin
  UnidadeParentes.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDTelemarketingFaccionista.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTelemarketingFaccionista.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDTelemarketing.cria;
begin

end;

{******************************************************************************}
destructor TRBDTelemarketing.destroy;
begin

end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContratoProcessadoItem.cria;
begin
  inherited create;
  IndProcessado := true;
end;

{******************************************************************************}
destructor TRBDContratoProcessadoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContratoProcessadoCorpo.cria;
begin
  inherited create;
  Items := TList.Create;
end;

{******************************************************************************}
destructor TRBDContratoProcessadoCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContratoProcessadoCorpo.AddItem : TRBDContratoProcessadoItem;
begin
  result := TRBDContratoProcessadoItem.cria;
  Items.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContratoItem.cria;
begin
  inherited create;
  IndNumeroSerieDuplicado := false;
end;

{******************************************************************************}
destructor TRBDContratoItem.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDContratoCorpo.addServicoContrato: TRBDContratoServico;
begin
  result := TRBDContratoServico.cria;
  ServicoContrato.add(result);
end;

{******************************************************************************}
constructor TRBDContratoCorpo.cria;
begin
  inherited create;
  ItensContrato := TList.create;
  ServicoContrato:= TList.Create;
end;

{******************************************************************************}
destructor TRBDContratoCorpo.destroy;
begin
  FreeTObjectsList(ItensContrato);
  FreeTObjectsList(ServicoContrato);
  ItensContrato.free;
  ServicoContrato.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContratoCorpo.addItemContrato : TRBDContratoItem;
begin
  result := TRBDContratoItem.cria;
  ItensContrato.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da cobranca corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCobrancaItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCobrancaItem.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da cobranca corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCobrancoCorpo.cria;
begin
  inherited create;
  Items := TList.create;
  IndCobrarCliente := false;
end;

{******************************************************************************}
destructor TRBDCobrancoCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDCobrancoCorpo.addItem : TRBDCobrancaItem;
begin
  result := TRBDCobrancaItem.cria;
  Items.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDParenteCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDParenteCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDFaixaEtariaCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFaixaEtariaCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDMarcaCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDMarcaCliente.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCliente.cria;
begin
  inherited create;
  IndRecibo := false;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe RETORNOITEM
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

constructor TRBDREtornoItem.cria;
begin
  inherited create;
  IndProcessada := false;
  IndPossuiErro := true;
end;

{******************************************************************************}
destructor TRBDREtornoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe RETORNOCORPO
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRetornoCorpo.cria;
begin
  inherited create;
  Itens := TList.create;
end;

{******************************************************************************}
destructor TRBDRetornoCorpo.destroy;
begin
  FreeTObjectsList(Itens);
  Itens.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDRetornoCorpo.addItem : TRBDREtornoItem;
begin
  result := TRBDREtornoItem.cria;
  itens.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRemessaItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDRemessaItem.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRemessaCorpo.cria;
begin
  inherited create;
  Itens := TList.create;
end;

{******************************************************************************}
destructor TRBDRemessaCorpo.destroy;
begin
  FreeTObjectsList(Itens);
  Itens.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDRemessaCorpo.addIten : TRBDRemessaItem;
begin
  result := TRBDRemessaItem.cria;
  Itens.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDItemContasConsolidadasCR.cria;
begin
  inherited;
end;

{******************************************************************************}
destructor TRBDItemContasConsolidadasCR.destroy;
begin
  inherited
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContasConsolidadasCR.cria;
begin
  inherited create;
  ItemsContas := TList.Create;
end;  

{******************************************************************************}
destructor TRBDContasConsolidadasCR.destroy;
begin
  FreeTObjectsList(ItemsContas);
  inherited destroy;
end;

{******************************************************************************}
function TRBDContasConsolidadasCR.AddItemConta : TRBDItemContasConsolidadasCR;
begin
  result := TRBDItemContasConsolidadasCR.cria;
  ItemsContas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do pao de açucar
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDVendasPaoAcucar.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDVendasPaoAcucar.destroy;
begin
 inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das filias das vendas do pao de açucar
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFiliaisVendasPaoAcucar.cria;
begin
  inherited create;
  Vendas := TList.Create;
  QtdVendidaTotal := 0;
  QtdEntradaTotal := 0;
end;

{******************************************************************************}
destructor TRBDFiliaisVendasPaoAcucar.destroy;
begin
  FreeTObjectsList(Vendas);
  Vendas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFiliaisVendasPaoAcucar.AddVendasPaoAcucar : TRBDVendasPaoAcucar;
begin
  Result := TRBDVendasPaoAcucar.cria;
  Vendas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDDatasVendasPaoAcucar.cria;
begin
  inherited create;
  Filiais := TList.create;
end;

{******************************************************************************}
destructor TRBDDatasVendasPaoAcucar.destroy;
begin
  FreeTObjectsList(Filiais);
  Filiais.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDDatasVendasPaoAcucar.AddFiliaisPaoAcucar : TRBDFiliaisVendasPaoAcucar;
begin
  result := TRBDFiliaisVendasPaoAcucar.cria;
  Filiais.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDArquivoVendasPaoAcucar.cria;
begin
  inherited create;
  Datas := TList.Create;
end;

{******************************************************************************}
destructor TRBDArquivoVendasPaoAcucar.destroy;
begin
  FreeTObjectsList(datas);
  Datas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDArquivoVendasPaoAcucar.AddDAtaVendaPaoAcucar : TRBDDatasVendasPaoAcucar;
begin
  Result := TRBDDatasVendasPaoAcucar.cria;
  Datas.add(result);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
constructor TRBDNaturezaOperacao.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDNaturezaOperacao.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDSpedFiscal.addRegistrC100: TRBDspedFiscalRegistroC100;
begin
  result := TRBDspedFiscalRegistroC100.cria;
  RegistrosC100.Add(result);
end;

{******************************************************************************}
function TRBDSpedFiscal.addRegistro0450: TRBDSpedFiscalRegistro0450;
begin
  result := TRBDSpedFiscalRegistro0450.cria;
  Registros0450.add(result);
end;

function TRBDSpedFiscal.addRegistroC300: TRBDSpedFiscalRegistroC300;
begin
  result := TRBDSpedFiscalRegistroC300.Cria;
  RegistrosC300.Add(Result);
end;

{******************************************************************************}
function TRBDSpedFiscal.addRegistroC400: TRBDSpedFiscalRegistroC400;
begin
  result := TRBDSpedFiscalRegistroC400.cria;
  RegistrosC400.Add(Result);
end;

{******************************************************************************}
function TRBDSpedFiscal.addRegistroC490: TRBDSpedFiscalRegistroC490;
begin
  result := TRBDSpedFiscalRegistroC490.cria;
  RegistrosC490.Add(result);
end;

{******************************************************************************}
function TRBDSpedFiscal.addRegistroD100: TRBDSpedFiscalRegistroD100;
begin
  result := TRBDSpedFiscalRegistroD100.cria;
  RegistrosD100.Add(result);
end;

{******************************************************************************}
function TRBDSpedFiscal.AddRegistroE116: TRBDSpedFiscalRegistroE116;
begin
  result := TRBDSpedFiscalRegistroE116.cria;
  RegistrosE116.Add(result);
end;

{******************************************************************************}
constructor TRBDSpedFiscal.cria;
begin
  inherited create;
  Arquivo := TStringList.Create;
  Incosistencias := TStringList.Create;
  DFilial := TRBDFilial.cria;
  DContabilidade := TRBDCliente.cria;
  RegistrosC100 := TList.Create;
  RegistrosC300 := TList.Create;
  RegistrosC400 := TList.Create;
  RegistrosC490 := TList.Create;
  RegistroE110 := TRBDSpedFiscalRegistroE110.cria;
  RegistrosE116 := Tlist.Create;
  RegistrosE510 := TList.Create;
  RegistroE520 := TRBDSpedFiscalRegistroE520.cria;
  Registros0450 := TList.Create;
  RegistrosD100 := TList.Create;
end;

{******************************************************************************}
destructor TRBDSpedFiscal.destroy;
begin
  DFilial.free;
  DContabilidade.free;
  Incosistencias.free;
  Arquivo.free;
  FreeTObjectsList(RegistrosC100);
  RegistrosC100.Free;
  FreeTObjectsList(RegistrosC300);
  RegistrosC300.Free;
  FreeTObjectsList(RegistrosC400);
  RegistrosC400.Free;
  FreeTObjectsList(RegistrosC490);
  RegistrosC490.Free;
  FreeTObjectsList(RegistrosE510);
  RegistrosE510.Free;
  FreeTObjectsList(RegistrosE116);
  RegistrosE116.Free;
  FreeTObjectsList(Registros0450);
  Registros0450.Free;
  FreeTObjectsList(RegistrosD100);
  RegistrosD100.Free;
  RegistroE110.Free;
  RegistroE520.Free;
  inherited;
end;

{******************************************************************************}
function TRBDSpedFiscal.RRegistroE510(VpaCFOP: Integer; VpaCSTIPI: String): TRBDSpedFiscalRegistroE510;
var
  VpfLaco : Integer;
  VpfDREgistroE510 : TRBDSpedFiscalRegistroE510;
begin
  result := nil;
  for VpfLaco := 0 to RegistrosE510.Count - 1 do
  begin
    VpfDREgistroE510 := TRBDSpedFiscalRegistroE510(RegistrosE510.Items[VpfLaco]);
    if (VpfDREgistroE510.CFOP = VpaCFOP) and
       (VpfDREgistroE510.CST_IPI = VpaCSTIPI) then
    begin
      result := VpfDREgistroE510;
      break;
    end;
  end;
  if result = nil then
  begin
    result := TRBDSpedFiscalRegistroE510.cria;
    RegistrosE510.Add(result);
    Result.CFOP := VpaCFOP;
    Result.CST_IPI := VpaCSTIPI;
  end;
end;

{ TRBDSpedFiscal }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSpedfiscalRegistroC190.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedfiscalRegistroC190.destroy;
begin
  inherited destroy;
end;

{ TRBDSpedfiscalRegistroC190 }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRepresentada.cria;
begin

end;

{******************************************************************************}
destructor TRBDRepresentada.destroy;
begin

  inherited;
end;

{ TRBDRepresentada }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDImportacaoDados.addCampoFiltro: TRBDCamposImportacaoDados;
begin
  result := TRBDCamposImportacaoDados.cria;
  CamposChavePrimaria.Add(result);
end;

{******************************************************************************}
function TRBDImportacaoDados.addCampoPaiFilho: TRBDCamposImportacaoDados;
begin
  result := TRBDCamposImportacaoDados.cria;
  CamposChavePaiFilho.Add(result);
end;

{******************************************************************************}
constructor TRBDImportacaoDados.cria;
begin
  inherited create;
  CamposIgnorar := TStringList.Create;
  CamposChavePrimaria := TList.Create;
  CamposChavePaiFilho := TList.Create;
end;

{******************************************************************************}
destructor TRBDImportacaoDados.destroy;
begin
  FreeTObjectsList(CamposChavePrimaria);
  CamposIgnorar.Free;
  FreeTObjectsList(CamposChavePaiFilho);
  CamposChavePaiFilho.Free;
  CamposChavePrimaria.Free;
  inherited;
end;

{ TRBDImportacaoDados }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDVendedor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDVendedor.destroy;
begin

  inherited;
end;

{ TRBDVendedor }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Classe de importacao dos dados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCamposImportacaoDados.cria;
begin
  inherited create;;
end;

{******************************************************************************}
destructor TRBDCamposImportacaoDados.destroy;
begin

  inherited;
end;

{ TRBDCamposImportacaoDados }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Classe dos estagio da producao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
{******************************************************************************}
{ TRBDEEstagioProducaoGrupoUsuario }

constructor TRBDEEstagioProducaoGrupoUsuario.cria;
begin
  inherited Create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Classe dos envio dos medidos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
{ TRBDEmailMedidorItem }
constructor TRBDEmailMedidorItem.cria;
begin
  inherited Create;

end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da Classe do medidor corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
{ TRBDEmailMedidorCorpo }
function TRBDEmailMedidorCorpo.AddItem: TRBDEmailMedidorItem;
begin
  Result:= TRBDEmailMedidorItem.Cria;
  Emails.Add(Result);
end;

{******************************************************************************}
constructor TRBDEmailMedidorCorpo.cria;
begin
  inherited Create;
  Emails := TList.Create;
end;

{******************************************************************************}
destructor TRBDEmailMedidorCorpo.destroy;
begin
  FreeTObjectsList(Emails);
  Emails.Free;
  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     dados da classe de exportacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ TRBDExportacaoDados }
{******************************************************************************}
function TRBDExportacaoDados.AddErroExportacao(VpaNomTabela, VpaDesRegistro,VpaDesErro: String): TRBDExportacadoDadosErros;
begin
  result := TRBDExportacadoDadosErros.cria;
  ErrosExportacao.Add(result);
  result.NomTabela := VpaNomTabela;
  result.DesRegistro :=  VpaDesRegistro;
  Result.DesErro := VpaDesErro;
end;

{******************************************************************************}
constructor TRBDExportacaoDados.cria;
begin
  inherited create;
  ErrosExportacao := TList.Create;
  ClientesNaoExportados := TStringList.Create;
  PedidosExportados := TStringList.Create;
  ClientesExportados:= TStringList.Create;
  NotasExportadas := TStringList.Create;
  ContasaReceberExportados := TStringList.Create;
  ComissaoExportada := TStringList.Create;
end;

{******************************************************************************}
destructor TRBDExportacaoDados.destroy;
begin
  FreeTObjectsList(ErrosExportacao);
  ErrosExportacao.Free;
  ClientesExportados.Free;
  PedidosExportados.Free;
  ClientesNaoExportados.Free;
  NotasExportadas.Free;
  ContasaReceberExportados.Free;
  ComissaoExportada.Free;
  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     dados da classe de exportacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{ TRBDEXportacadoDadosErros }
{******************************************************************************}
constructor TRBDEXportacadoDadosErros.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEXportacadoDadosErros.destroy;
begin

  inherited;
end;

{ TRBDEmailECobrancaCompraItem }
{******************************************************************************}
constructor TRBDEmailECobrancaCompraItem.cria;
begin
  inherited Create;
end;

{ TRBDEmailECobrancaCompraCorpo }
{******************************************************************************}
function TRBDEmailECobrancaCompraCorpo.AddItem: TRBDEmailECobrancaCompraItem;
begin
  Result:= TRBDEmailECobrancaCompraItem.Cria;
  Emails.Add(Result);
end;

{******************************************************************************}
constructor TRBDEmailECobrancaCompraCorpo.cria;
begin
  inherited Create;

  Emails := TList.Create;
end;

{******************************************************************************}
destructor TRBDEmailECobrancaCompraCorpo.destroy;
begin
  FreeTObjectsList(Emails);
  Emails.Free;

  inherited;
end;

{ TRBDMaquinaCliente }
{******************************************************************************}
constructor TRBDPropostaMaquinaCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaMaquinaCliente.destroy;
begin
  inherited;
end;

{ TRBDSpedFiscalRegistroE110 }
{******************************************************************************}
constructor TRBDSpedFiscalRegistroE110.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroE110.destroy;
begin

  inherited;
end;



{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
  { TRBDESpedFiscalRegistroC100 }
{)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDspedFiscalRegistroC100.AddRegistroC110: TRBDSpedFiscalRegistroC110;
begin
  Result := TRBDSpedFiscalRegistroC110.cria;
  RegistrosC110.Add(Result);
end;

{******************************************************************************}
function TRBDspedFiscalRegistroC100.AddRegistroC170: TRBDSpedFiscalRegistroC170;
begin
  result := TRBDSpedFiscalRegistroC170.cria;
  RegistrosC170.Add(result);
end;

{******************************************************************************}
function TRBDspedFiscalRegistroC100.AddREgistroC190: TRBDSpedfiscalRegistroC190;
begin
  result := TRBDSpedfiscalRegistroC190.cria;
  RegistrosC190.Add(result);
end;

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC100.cria;
begin
  inherited create;
  RegistroC140 := TRBDSpedfiscalRegistroC140.cria;
  RegistroC160 := TRBDSpedFiscalRegistroC160.cria;
  RegistrosC110 := TList.Create;
  RegistrosC170 := TList.Create;
  RegistrosC190 := TList.Create;
  DNatureza := TRBDNaturezaOperacao.cria;
  DCliente := TRBDCliente.cria;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC100.destroy;
begin
  FreeTObjectsList(RegistrosC170);
  RegistrosC170.Free;
  FreeTObjectsList(RegistrosC190);
  RegistrosC190.Free;
  FreeTObjectsList(RegistrosC110);
  RegistrosC110.Free;
  RegistroC140.Free;
  RegistroC160.Free;
  DNatureza.Free;
  DCliente.Free;
  inherited;
end;

{******************************************************************************}
function TRBDspedFiscalRegistroC100.RRegistroC190(VpaCodCST: String; VpaCodCFOP: Integer;
  VpaPerICMS: Double): TRBDSpedfiscalRegistroC190;
var
  VpfLaco : Integer;
  VpfDRegistroC190 : TRBDSpedfiscalRegistroC190;
begin
  result := nil;
  for Vpflaco := 0 to RegistrosC190.Count - 1 do
  begin
    VpfDRegistroC190 := TRBDSpedfiscalRegistroC190(RegistrosC190.Items[VpfLaco]);
    if (VpfDRegistroC190.CodCST = VpaCodCST) and
       (VpfDRegistroC190.CodCFOP = VpaCodCFOP) and
       (VpfDRegistroC190.PerICMS = VpaPerICMS) then
    begin
      result := VpfDRegistroC190;
      break;
    end;
  end;
  if result = nil then
  begin
    result := TRBDSpedfiscalRegistroC190.cria;
    RegistrosC190.add(result);
    Result.CodCST := VpaCodCST;
    Result.CodCFOP := VpaCodCFOP;
    result.PerICMS := VpaPerICMS;
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDSpedfiscalRegistroC140 }
{)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDSpedfiscalRegistroC140.addRegistroC141: TRBDSpedFiscalRegistroC141;
begin
  result := TRBDSpedFiscalRegistroC141.cria;
  RegistrosC141.Add(result);
end;

{******************************************************************************}
constructor TRBDSpedfiscalRegistroC140.cria;
begin
  inherited create;
  RegistrosC141 := TList.Create;
end;

{******************************************************************************}
destructor TRBDSpedfiscalRegistroC140.destroy;
begin
  FreeTObjectsList(RegistrosC141);
  RegistrosC141.Free;
  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDSpedFiscalRegistroC141 }
{)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC141.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC141.destroy;
begin
  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDSpedFiscalRegistroC160 }
{)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC160.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC160.destroy;
begin

  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDSpedFiscalRegistroC170 }
{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC170.cria;
begin

end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC170.destroy;
begin

  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDSpedFiscalRegistroE116 }
{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroE116.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroE116.destroy;
begin

  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDSpedFiscalRegistroE510 }
{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroE510.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroE510.destroy;
begin
  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDSpedFiscalRegistroE520 }
{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroE520.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroE520.destroy;
begin

  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDProdutoPedidoCompraMateriaPrima }
{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}

{******************************************************************************}
constructor TRBDProdutoPedidoCompraMateriaPrima.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoPedidoCompraMateriaPrima.destroy;
begin

  inherited;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}
{ TRBDFiltroMenuFiscalECF }
{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((}

{******************************************************************************}
constructor TRBDFiltroMenuFiscalECF.cria;
begin
  inherited create;
  IndMostrarNumECF := false;
  IndMostrarPeriodo := false;
  IndMostrarCOO := false;
  IndMostrarCRZ := false;
end;

{******************************************************************************}
destructor TRBDFiltroMenuFiscalECF.destroy;
begin

  inherited destroy;
end;

{******************************************************************************}
                       { TRBDSpedFiscalRegistroC300 }
{******************************************************************************}

{******************************************************************************}
function TRBDSpedFiscalRegistroC300.addRegistroC320: TRBDSpedFiscalRegistroC320;
begin
  result := TRBDSpedFiscalRegistroC320.cria;
  RegistrosC320.Add(Result);
end;

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC300.cria;
begin
  inherited create;
  RegistrosC320 := TList.Create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC300.destroy;
begin
  FreeTObjectsList(RegistrosC320);
  RegistrosC320.Free;
  inherited;
end;

{******************************************************************************}
                     { TRBDSpedFiscalRegistroC320 }
{******************************************************************************}

{******************************************************************************}
function TRBDSpedFiscalRegistroC320.AddRegistroC321: TRBDSpedFiscalRegistroC321;
begin
  Result := TRBDSpedFiscalRegistroC321.cria;
  RegistrosC321.Add(result);
end;

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC320.cria;
begin
  inherited create;
  RegistrosC321 := TList.Create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC320.destroy;
begin
  FreeTObjectsList(RegistrosC321);
  RegistrosC321.Free;
  inherited destroy;
end;

{******************************************************************************}
                 { TRBDSpedFiscalRegistroC321 }
{******************************************************************************}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC321.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC321.destroy;
begin

  inherited destroy;
end;

{******************************************************************************}
                      { TRBDSpedFiscalRegistroC400 }
{******************************************************************************}

{******************************************************************************}
function TRBDSpedFiscalRegistroC400.addRegistroC405: TRBDSpedFiscalRegistroC405;
begin
  result := TRBDSpedFiscalRegistroC405.cria;
  RegistrosC405.Add(result);
end;

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC400.cria;
begin
  inherited create;
  RegistrosC405 := TList.Create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC400.destroy;
begin
  FreeTObjectsList(RegistrosC405);
  RegistrosC405.Free;
  inherited;
end;

{******************************************************************************}
                     { TRBDSpedFiscalRegistroC405 }
{******************************************************************************}

{******************************************************************************}
function TRBDSpedFiscalRegistroC405.addRegistroC420: TRBDSpedFiscalRegistroC420;
begin
  result := TRBDSpedFiscalRegistroC420.cria;
  RegistrosC420.Add(result);
end;

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC405.cria;
begin
  inherited create;
  RegistrosC420 := TList.Create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC405.destroy;
begin
  FreeTObjectsList(RegistrosC420);
  RegistrosC420.Free;
  inherited;
end;

{******************************************************************************}
{ TRBDSpedFiscalRegistroC420 }
{******************************************************************************}

{******************************************************************************}
function TRBDSpedFiscalRegistroC420.addRegistroC425: TRBDSpedFiscalRegistroC425;
begin
  result := TRBDSpedFiscalRegistroC425.cria;
  RegistrosC425.Add(result);
end;

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC420.cria;
begin
  inherited create;
  RegistrosC425 := TList.Create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC420.destroy;
begin
  FreeTObjectsList(RegistrosC425);
  RegistrosC425.Free;
  inherited;
end;

{******************************************************************************}
                    { TRBDSpedFiscalRegistroC425 }
{******************************************************************************}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC425.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC425.destroy;
begin
  inherited;
end;

{******************************************************************************}
                      { TRBDSpedFiscalRegistroC490 }
{******************************************************************************}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC490.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC490.destroy;
begin

  inherited;
end;

{******************************************************************************}
                   { TRBDTarefaEMarketingProspectItem }
{******************************************************************************}

{******************************************************************************}
constructor TRBDTarefaEMarketingProspectItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTarefaEMarketingProspectItem.destroy;
begin
  inherited;
end;

{******************************************************************************}
{ TRBDRomaneioOrcamento }
{******************************************************************************}

{******************************************************************************}
function TRBDRomaneioOrcamento.addProduto: TRBDRomaneioOrcamentoItem;
begin
  result := TRBDRomaneioOrcamentoItem.cria;
  Produtos.Add(result);
end;

{******************************************************************************}
constructor TRBDRomaneioOrcamento.cria;
begin
  inherited create;
  Produtos := TList.Create;
  IndBloqueado := false;
end;

{******************************************************************************}
destructor TRBDRomaneioOrcamento.destroy;
begin
  FreeTObjectsList(Produtos);
  Produtos.Free;
  inherited destroy;
end;

{******************************************************************************}
{ TRBDRomaneioOrcamentoItem }
{******************************************************************************}

{******************************************************************************}
constructor TRBDRomaneioOrcamentoItem.cria;
begin
  inherited create;

end;

{******************************************************************************}
destructor TRBDRomaneioOrcamentoItem.destroy;
begin

  inherited;
end;

{ TRBDProdutoClientePeca }

constructor TRBDProdutoClientePeca.cria;
begin
  inherited create;
end;

destructor TRBDProdutoClientePeca.destroy;
begin
  inherited destroy;
end;

{ TRBDPropostaProdutoChamado }

{******************************************************************************}
constructor TRBDPropostaProdutoChamado.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaProdutoChamado.destroy;
begin

  inherited destroy;
end;

{ TRBDPlanoContaOrcado }

function TRBDPlanoContaOrcado.AddPlanoContaItem: TRBDPlanoContaOrcadoItem;
begin
  Result:= TRBDPlanoContaOrcadoItem.cria;
  PlanoContas.Add(Result);
end;

{******************************************************************************}
constructor TRBDPlanoContaOrcado.cria;
begin
  inherited create;
  PlanoContas:= TList.Create;
end;

{******************************************************************************}
destructor TRBDPlanoContaOrcado.destroy;
begin
  FreeTObjectsList(PlanoContas);
  PlanoContas.Free;
  inherited destroy;
end;

{ TRBDPlanoContaOrcadoItem }

{******************************************************************************}
constructor TRBDPlanoContaOrcadoItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPlanoContaOrcadoItem.destroy;
begin
  inherited destroy;
end;

{ TRBDChamadoProdutoaProduzir }

constructor TRBDChamadoProdutoaProduzir.Cria;
begin
  inherited create;
end;

destructor TRBDChamadoProdutoaProduzir.Destroy;
begin
  inherited destroy;
end;

{ TRBDPropostaCondicaoPagamento }

{******************************************************************************}
constructor TRBDPropostaCondicaoPagamento.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaCondicaoPagamento.Destroy;
begin
  inherited Destroy;
end;

{ TRBDPropostaMaterialAcabamento }

{******************************************************************************}
constructor TRBDPropostaMaterialAcabamento.cria;
begin
 inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaMaterialAcabamento.destroy;
begin
  inherited Destroy;
end;

{******************************************************************************}
                            { TRBDReciboLocacao }
{******************************************************************************}

{******************************************************************************}
function TRBDReciboLocacao.addServico: TRBDReciboLocacaoServico;
begin
  result := TRBDReciboLocacaoServico.cria;
  Servicos.Add(result);
end;

{******************************************************************************}
constructor TRBDReciboLocacao.cria;
begin
  inherited create;
  Servicos := TList.Create;
  SeqRecibo := 0;
  IndCancelado := false;
end;

{******************************************************************************}
destructor TRBDReciboLocacao.destroy;
begin
  FreeTObjectsList(Servicos);
  Servicos.Free;
  inherited;
end;

{******************************************************************************}
                    { TRBDReciboLocacaoServico }
{******************************************************************************}

{******************************************************************************}
constructor TRBDReciboLocacaoServico.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDReciboLocacaoServico.destroy;
begin

  inherited;
end;

{ TRBDContratoServico }

{******************************************************************************}
constructor TRBDContratoServico.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDContratoServico.destroy;
begin
  inherited destroy;
end;

{ TRBDPropostaAmostraMotivoAtraso }

{******************************************************************************}
constructor TRBDPropostaAmostraMotivoAtraso.Cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaAmostraMotivoAtraso.Destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
{ TRBDSpedFiscalRegistro0450 }
{******************************************************************************}

{******************************************************************************}
constructor TRBDSpedFiscalRegistro0450.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistro0450.destroy;
begin
  inherited;
end;

{******************************************************************************}
procedure TRBDSpedFiscalRegistro0450.SetDesInformacao(VpaValor: string);
begin
  ADesInformacao := DeletaChars(DeletaChars(VpaValor,#13),#10);
end;

{******************************************************************************}
{ TRBDSpedFiscalRegistroC110 }
{******************************************************************************}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroC110.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroC110.destroy;
begin

  inherited;
end;

{******************************************************************************}
procedure TRBDSpedFiscalRegistroC110.SetATXT_COMPL(VpaValor: string);
begin
  ATXT_COMPL := DeletaChars(DeletaChars(VpaValor,#13),#10);
end;

{******************************************************************************}
                              { TRBDExportacaoRPS }
{******************************************************************************}

{******************************************************************************}
function TRBDExportacaoRPS.AddNotaBlu: TRBDNotaBlu;
begin
  Result := TRBDNotaBlu.cria;
  NotasBlu.add(result);
end;

{******************************************************************************}
constructor TRBDExportacaoRPS.cria;
begin
  inherited create;
  Arquivo := TStringList.Create;
  DFilial := TRBDFilial.cria;
  NotasBlu := TList.Create;
end;

{******************************************************************************}
destructor TRBDExportacaoRPS.destroy;
begin
  Arquivo.Free;
  DFilial.Free;
  FreeTObjectsList(NotasBlu);
  NotasBlu.Free;
  inherited destroy;
end;

{ TRBDConhecimentoTransporte }
{******************************************************************************}
constructor TRBDConhecimentoTransporte.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDConhecimentoTransporte.destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
                                 { TRBDNotaBlu }
{******************************************************************************}

{******************************************************************************}
constructor TRBDNotaBlu.cria;
begin
  inherited create;
  ValServicos := 0;
  DesServico := '';
end;

{******************************************************************************}
destructor TRBDNotaBlu.destroy;
begin

  inherited destroy;
end;

{ TRBDPropostaFormaPagamento }
{******************************************************************************}
constructor TRBDPropostaParcelas.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaParcelas.destroy;
begin
  inherited destroy;
end;

{ TRBDChamadoAnexoImagem }
{******************************************************************************}
constructor TRBDChamadoAnexoImagem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDChamadoAnexoImagem.destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
{ TRBDSpedFiscalRegistroD100 }
{******************************************************************************}

{******************************************************************************}
constructor TRBDSpedFiscalRegistroD100.cria;
begin
  inherited;
end;

{******************************************************************************}
destructor TRBDSpedFiscalRegistroD100.destroy;
begin

  inherited;
end;

{******************************************************************************}
{ TRBDFracaoOPProdutoNaoComprado }
{******************************************************************************}

{******************************************************************************}
constructor TRBDFracaoOPProdutoNaoComprado.cria;
begin
  inherited create;
  IndMarcado := false;
end;

{******************************************************************************}
destructor TRBDFracaoOPProdutoNaoComprado.destroy;
begin

  inherited;
end;

end.
