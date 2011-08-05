unit UnContasAReceber;
{Verificado
-.edit;
-Post;
}
interface

uses
    Db, DBTables, classes, sysUtils, painelGradiente, UnComissoes,  UnMoedas, variants,
    UnDados, UnDadosCR, UnClassesImprimir, UnSistema, UnDadosProduto,FunValida, forms,
    SQLExpr, UnCaixa, Tabela ;


// calculos
type
  TCalculosContasAReceber = class
  private
     calcula : TSQLQuery;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy; override;
    function SomaTotalParcelas( VpaCodFilial, VpaLanReceber : Integer ) : Double;
    function SomaValorReceber(VpaCodFilial,VpaOrdem, VpaParcela: Integer): Double;
end;

// localizacao
Type
  TLocalizaContasAReceber = class(TCalculosContasAReceber)
  public
    procedure LocalizaParcela(VpaTabela : TDataSet;VpaCodFilial, VpaLancamento, VpaNroParcela : integer);
    procedure LocalizaContaCR(tabela : TDataSet; VpaCodFilial, VpaLanReceber : Integer);
    procedure LocalizaParcelasSemParciais(tabela : TDataSet; VpaCodFilial, VpaLancamento : Integer);
    procedure LocalizaParcelasComParciais(VpaTabela : TDataSet; VpaCodFilial, VpaLanReceber: Integer);
    procedure LocalizaParcelasFRM(tabela : TDataSet; VpaCodFilial, VpaLancamento : Integer);
    function LocalizaNotaFiscal(Tabela : TDataSet;VpaCodFilial, VpaSeqNota : Integer): boolean;
    procedure LocalizaParcelasNotaFiscal(VpaTabela :TDataSet;VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaParcelasCotacao(VpaTabela :TDataSet;VpaCodFilial, VpaLanOrcamento : Integer);
    procedure LocalizaJoinContaParcelas(tabela : TDataSet; VpaCodFilial, VpaLancamento : Integer; CampoOrderBy : string);
    procedure LocalizaMov(VpaTabela : TDataSet);
    procedure LocalizaParcelasAbertas(Vpatabela : TDataSet; VpaCodFilial, VpaLanReceber : Integer; VpaCampoOrderBy : string);
    procedure LocalizaParcelaAberta(VpaTabela : TDataSet; VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer );
    procedure LocalizaFormaPagamento(Tabela : TDataSet; CodFormaPagto : integer );
    procedure LocalizaConPagto( tabela : TDataSet; Condicao : integer);
    procedure LocalizaChequesCR(VpaTabela : TDataSet;VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
    procedure LocalizaFluxoCaixa(VpaTabela : TDataSet;VpaDFluxo : TRBDFluxoCaixaCorpo);
end;

// funcoes
type
  TFuncoesContasAReceber = class(TLocalizaContasAReceber)
  private
      Tabela,
      CadCondicaoPgto,
      Aux : TSQLQuery;
      CadContas,
      Cadastro,
      Cadastro2 :TSQL;
      FunComissoes : TFuncoesComissao;
      // para criar parcelas
      ComPercentual : Boolean;  // utilizado para criar as parcelas
      TextoParcelas : TStringList;
      TextoVencimentos : TStringList;

    function RLogContasReceberDisponivel(VpaCodFilial,VpaLanReceber,VpaNumParcela : integer):Integer;
    function RNumParcelaDisponivel(VpaCodFilial,VpaLanReceber : integer):Integer;
    function RSeqReceberDisponivel(VpaCodFilial : Integer) : Integer;
    function RDescontoCliente(VpaCodCliente : Integer) : Double;
    function RValAcrescimoFormaPagamento(VpaCodFormaPagamento : Integer) : double;
    function ExisteSequencialReceber(VpaCodFilial, VpaLanReceber : Integer) : boolean;
    function BaixarContaFormaPagamento(VpaCodForma : Integer):Boolean;
    function RValorTotalJurosComposto(VpaValorTotal, VpaPerJuros : Double; VpaQtdParcelas : Integer):Double;
    function RParcelaAGerarParcial(VpaDBaixa : TRBDBaixaCR): TRBDParcelaBaixaCR;
    function UtilizaFaixaNossoNumero(VpaContaCorrente :String):Boolean;
    procedure CriaParcelasCR(VpaDNovaCR : TRBDContasCR);
    function GravaDParcelasCR(VpaDNovaCR : TRBDContasCR):String;
    function ContasConsolidadasValidas(VpaDContas : TRBDContasConsolidadasCR):String;
    function GravaDMovCRContaConsolidada(VpaDContas : TRBDContasConsolidadasCR):String;
    function GravaDContaConsolidadaItem(VpaDContas : TRBDContasConsolidadasCR) : String;
    function AtualizaDadosClientes(VpaDContas : TRBDContasCR):String;
    function RAgenciaConta(VpaNumConta : String):string;
    procedure CarAgenciaBancodaContaCorrente(VpaNumConta : String;Var VpaCodBanco : Integer;var VpaNumAgencia : string;Var VpaQtdDiasCompensacao : Integer);
    function BaixaParcelaReceber(VpaDBaixa : TRBDBaixaCR;VpaDParcela : TRBDParcelaBaixaCR):string;
    //remessas
    function ExisteRemessa(VpaCodFilial, VpaSeqRemessa,VpaLanReceber,VpaNumParcela : Integer) : Boolean;
    function ParcelaJaAdicionadaRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
    function RProximoSeqRemessa(VpaCodFilial : Integer):Integer;
    function RSeqRemessaCorpoAberto(VpaCodFilial : Integer;VpaContaCorrente : String):Integer;
    function InicializaNovaRemessa(VpaCodFilial : Integer;VpaContaCorrente : String):Integer;
    function AdicionaRemessaItem(VpaCodFilial, VpaSeqRemessa,VpaLanReceber,VpaNumParcela, VpaCodMovimento : Integer;VpaNomMotivo : String) : string;

    //cobranca
    function RProximoSeqCobranca : Integer;
    function GravaDCobrancaItem(VpaDCobranca : TRBDCobrancoCorpo) : String;
    function AtualizaItemscobranca(VpaDCobranca : TRBDCobrancoCorpo) : string;
    //e-cobranca
    function AtualizaDataEnvioEmail(VpaDECobrancaItem : TRBDECobrancaItem):String;
    //
    function RetiraFraseDescontoFinanceiro(VpaTexto : String):String;
    procedure ExcluiCheque(VpaSeqCheque : Integer);
    function RSeqChequeDisponivel : Integer;
    function GravaDChequeCR(VpaDBaixa : TRBDBaixaCR ):string;
    procedure CarParcelasCheque(VpaParcelas : TList;VpaSeqCheque, VpaCodFilialOriginal, VpaLanReceberOriginal, VpaNumParcelaOriginal : Integer);
    function EstornaCRChequeDevolvido(VpaCheques : TList):string;
    function VerificaCaixa(VpaDNovaCR : TRBDContasCR) : string;
    function BaixaParcelaAutomatica(VpaDNovaCR : TRBDContasCR) : String;
    procedure CarDFormaPagamentoTabela(VpaTabela : TSQLQuery;VpaDFormaPagamento : TRBDFormaPagamento);
    procedure PreparaPlanoContaOrcado(VpaCodEmpresa : integer; VpaPlanoContaOrcado : TRBDPlanoContaOrcado);
    function PossiuPlanoContasOrcadoFilho(VpaDPlanoContaOrcado : TRBDPlanoContaOrcado;VpaDItemPlanoContaOrcado : TRBDPlanoContaOrcadoItem;VpaPosLaco : Integer):Boolean;
    procedure ZeraPlanoContasOrcadoItem(VpaDItemPlanoContaOrcado : TRBDPlanoContaOrcadoItem);
    function DesbloqueiaclientesNabaixaCR(VpaDBaixa : TRBDBaixaCR):string;
    function TipoContaCaixa(VpaNumConta : string):Boolean;
    function ExcluiParcelasSinalPagamentoPagas(VpaDNovaCR : TRBDContasCR):string;
    function RUltimaParcelaemAberto(VpaCodFilial, VpaLanReceber : Integer): Integer;
    function RQtdParcelasEmAberto(VpaCodFilial, VpaLanReceber : Integer): Integer;
  public
    // inicializa
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor Destroy; override;
    function GeraComissaoCR(VpaDNovaCR : TRBDContasCR) : String;
    function GeraLogReceber(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaFuncao : String):String;

    procedure AtualizaTotalContasOrcadas(VpaDPlanoContaOrcado : TRBDPlanoContaOrcado; VpaDItemPlanoContaOrcado : TRBDPlanoContaOrcadoItem;Var VpaPosLaco : Integer);
    function GravaPlanoContaOrcado(VpaPlanoContaOrcado : TRBDPlanoContaOrcado): String;

    // gera parcelas
    procedure VerificaValAcrescimoFormaPagamento(VpaDNovaCR : TRBDContasCR);

    procedure CarDFormaPagamento(VpaDFormaPagamento : TRBDFormaPagamento;VpaCodFormaPagamento : Integer);
    function CalculaVencimento(DataAtual : TDateTime; NroDias : integer; DiaFixo : integer; DataFixa : TDateTime; diaUnico : word) : TDateTime;
    function CalculaValor(PercentualCondicao : double; DebitoCredito : string; Parcela : double; valorTotal : Double) : double;
    function CriaContasaReceber(VpaDNovaCR : TRBDContasCR;var VpaResultado : String;VpaGravarRegistro : Boolean ):Boolean;
    function GravaContasAReceber(VpaDNovaCR : TRBDContasCR):String;
    procedure CarDPNovaCR(VpaDNovaCR : TRBDContasCR);
    procedure CarDMovContasCR(VpaTabela : TDataSet; VpaDMovContasCR : TRBDMovContasCR);
    procedure CarDContasReceber(VpaCodFilial, VpaLanReceber : String;VpaDContasAReceber : TRBDContasCR;VpaCarregaItens : Boolean);
    procedure CarDContasReceberParcela(VpaCodFilial, VpaLanReceber, VpaNroParcela : String;VpaDContasAReceber : TRBDContasCR);
    function GravaDNovaCR(VpaDNovaCR : TRBDContasCR): String;
    function GravaDParcelaCR(VpaDContasCR : TRBDContasCR;VpaDParcela : TRBDMovContasCR):String;overload;
    function GravaAlteracaoDParcelaCR(VpaDParcelaCR : TRBDParcelaBaixaCR):string;overload;
    function ParcelasGeradas : TStringList;
    function VencimentosGeradas : TStringList;
    function  GeraNumeroDuplicata(VpaCodfilial,  NroNotaFiscal : Integer) : integer;
    function  GeraNroProximoParcela(VpaCodFilial, VpaLanReceber : Integer) : Integer;
    function AtualizaValorTotal( VpaCodFilial, VpaLanReceber : integer ) : Double;
    function  VerificaAtualizaValoresParcelas(ValorInicialParcelas : double;VpaCodFilial, lancamento : Integer ) : boolean;
    function RValTotalCredito(VpaCreditos : TList;VpaTipo : TRBDTipoCreditoDebito) : double;
    function ClientePossuiCredito(VpaCreditos : TList;VpaTipo : TRBDTipoCreditoDebito) : Boolean;
    function ClientesPossuiDuplicataEmAberto(VpaCodCliente: Integer): Boolean;
    function BaixaParcelacomCreditodoCliente(VpaDNovaCR : TRBDContasCR; VpaCredito : TList):string;

    // baixa parcela
    function BaixaContasAReceber(VpaDBaixa : TRBDBaixaCR) : string;
    function GeraParcelaParcial( VpaDBaixa : TRBDBaixaCR ) : string;
    function GravaParcelaParcial(VpaDParcelaOriginal : TRBDParcelaBaixaCR;VpaValParcial : Double;VpaDatVencimento : TDateTime):string;
    function ValidaParcelaPagamento(VpaCodFilial, VpaLanReceber, VpaNumParcela : integer ) : boolean;
    function CalculaJuros(  var VpaMulta, VpaMora, VpaJuro, VpaDesconto : double; VpaDatInicio, VpaDatFim : TdateTime; VpaValTotal : Double ) : Integer;
    function DescontaDuplicata(VpaDBaixa : TRBDBaixaCR):string;
    procedure SetaCobrancaExterna(VpaCodFilial, VpaLanReceber, VpaNroParcela : Integer;VpaDesObservacao : String);
    procedure SetaFundoPerdido(VpaCodfilial,VpaLanReceber, VpaNroParcela : Integer;VpaDesObservacao : String );
    procedure SetaBaixaEmCartorio(VpaCodfilial,VpaLanReceber, VpaNroParcela : Integer;VpaDesObservacao : String );
    procedure SetaDuplicataImpressa(VpaCodfilial,VpaLanReceber, VpaNumParcela : Integer);
    procedure CarDParcelaBaixa(VpaDParcela : TRBDParcelaBaixaCR;VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
    procedure CalculaValorTotalBaixa(VpaDBaixa : TRBDBaixaCR);
    procedure CalculaJuroseDescontoParcela(VpaDParcela : TRBDParcelaBaixaCR;VpaDatPagamento : TDateTime);overload;
    function CalculaJuroseDescontoParcela(VpaDParcela : TRBDMovContasCR):double;overload;
    procedure DistribuiValAcrescimoDescontoNasParcelas(VpaDBaixa : TRBDBaixaCR);
    function VerificaSeValorPagoQuitaTodasDuplicatas(VpaDBaixa : TRBDBaixaCR;VpaValAReceber : Double) : String;
    function VerificaSeGeraParcial(VpaDBaixa : TRBDBaixaCR;VpaValAReceber : Double;VpaIndSolicitarData : Boolean) : String;
    function RValTotalCheques(VpaCheques : TList) : Double;
    function RNumerosCheques(VpaCheques :TList) : string;
    function RNumParcelas(VpaDBaixaCR : TRBDBaixaCR) : string;
    function RValTotalParcelasBaixa(VpaDBaixaCR : TRBDBaixaCR) : Double;

    // exclusao e estorno
    function RetornaValorTotalParcelas(VpaCodFilial, Lancamento : Integer): Double;
    function ExcluiConta( VpaCodFilial, VpaLanReceber : integer; VpaVerificarNotaFiscal, VpaFazerVeriricacoes : Boolean) : String;
    function ExisteParcelaPaga(VpaCodFilial, VpaLanReceber: Integer): Boolean;
    function RValorParcelaEmAberto(VpaCodFilial, VpaLanReceber: Integer): double;
    function TemParcelasPagas(VpaCodFilial, VpaLanReceber : Integer): Boolean;
    function ExcluiTitulo( VpaCodFilial,VpaLanReceber, VpaNumParcela : Integer) : string;
    function TemParcelaPaga(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer): Boolean;
    function TemParcelas(VpaCodFilial, VpaLanReceber : Integer): Boolean;
    function EstornaParcela(VpaCodCliente, VpaCodFilial, VpaLanReceber,VpaNumParcela, VpaNumParcelaFilha : integer;VpaVerificarCheques : Boolean) : String;
    function EstornaDesconto(VpaCodFilial, VpaLanReceber,VpaNumParcela: integer) : String;
    function EstornaFundoPerdido(VpaCodFilial, VpaLanReceber,VpaNumParcela: integer) : String;
    function EstornaCobrancaExterna(VpaCodFilial, VpaLanReceber,VpaNumParcela: integer) : String;
    function EstornaParcelaParcial(VpaCodFilial, VpaLanReceber, VpaNumParcelaFilha : integer) : string;
    function EstornaCreditoCliente(VpaCodCliente,VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer) : string;
    function ExisteChequeAssociadoCP(VpaCheques, VpaParcelas : TList;VpaIndDevolucaoCheque : Boolean):String;
    function ValidaChequesCR(VpaCodFilial,VpaLanReceber,VpaNumparcela : Integer;Var VpaExisteCheques : Boolean):string;

    //conta consolidada
    function JaExisteParcela(VpaDContas : TRBDContasConsolidadasCR;VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer):Boolean;
    function ContaJaConsolidada(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer):Boolean;
    function RValTotalContas(VpaDContas : TRBDContasConsolidadasCR):Double;
    function RMaiorVencimentoContas(VpaDContas : TRBDContasConsolidadasCR):TDateTime;
    function GravaDContaConsolidada(VpaDContas : TRBDContasConsolidadasCR):String;
    procedure CarNroNotas(VpaDContas : TRBDContasConsolidadasCR);
    procedure BaixaContasConsolidadas(VpaCodFilial,VpaLanReceber : Integer;VpaDatBaixa : TDateTime);
    procedure ExtornaContasConsolidadas(VpaCodFilial,VpaLanReceber : Integer);
    procedure ExcluiContaConsolidada(VpaCodFilial,VpaLanReceber : Integer);

    //remessas
    function RNossoNumero(VpaLanReceber, VpaNumParcela : Integer; VpaContaCorrente :String):String;
    function AdicionaRemessa(VpaCodFilial, VpaLanReceber,VpaNumParcela, VpaCodMovimento : Integer;VpaNomMotivo : String):String;
    procedure ExcluiItemRemessa(VpaCodFilial,VpaSeqRemessa,VpaLanReceber,VpaNumParcela : Integer);
    procedure ExcluiItemRemessaSeNaoEnviado(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
    function ContaAdicionadaRemessa(VpaCodFilial, VpaLanReceber : Integer):string;
    function AdicionaParcelasCRNaRemessa(VpaDContasAReceber : TRBDContasCR):string;

    //cobranca
    function GravaDCobranca(VpaDCobranca : TRBDCobrancoCorpo):string;
    function AtualizaDataCartorio(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
    function GravaDECobrancaItem(VpaDCobrancaCorpo : TRBDECobrancaCorpo;VpaDItemCobranca : TRBDECobrancaItem):String;

    // diversos
    procedure atualizaVencimentoComissao( VpaCodFilial, VpaLaReceber, VpaNumParcela : Integer; VpaNovaData : TdateTime );
    procedure CarFormasPagamento(VpaFormas : TList);
    function VerificacoesExclusaoCheque(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaCheques : TList):string;
    function ExcluiChequesCR(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaCheques : TList):string;
    function GravaDCheques(VpaCheques : TList):String;
    function GravaDCondicaoPagamentoGrupoUsuario(VpaCodGrupoUsuario : Integer; VpaCondicoesPagamento : TList):String;
    procedure CarDCheque(VpaDCheque : TRBDCheque;VpaSeqCheque : Integer);
    procedure CarDChequesCR(VpaListaCheques : TList;VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
    procedure CarDCondicaoPagamentoGrupoUsuario(VpaCodGrupo : Integer; VpaCondicoesPagamento : TList);
    procedure CarFluxoCR(VpaDFluxo : TRBDFluxoCaixaCorpo);
    function RSeqEmailDisponivel : Integer;
    function RDescontoCotacaoPgtoaVista(VpaCodfilial,VpaLanOrcamento :Integer;VpaDatEmissao : TDateTime):Double;
    function RNomFormaPagamento(VpaCodFormaPagamento : Integer):String;
    function RNomCondicaoPagamento(VpaCodCondicao : Integer) : String;
    function RNomBanco(VpaCodBanco : Integer): String;
    function RNomPlanoContas(VpaCodEmpresa : Integer;VpaCodPlanoContas : String):string;
    function RNomMoeda(VpaCodMoeda : Integer) : String;
    function RDiasCompensacaoConta(VpaNumConta : String):Integer;
    function RPlanoContasDisponivel(VpaCodPlanoContas : String;VpaNumPlanoContas : Integer) : String;
    function RValAbertoCliente(VpaCodCliente : Integer;VpaDatInicio, vpaDatFim : tDateTime):Double;
    function RTipoFormapagamento(VpaTipo : TRBDTipoFormaPagamento) : string;overload;
    function RTipoFormaPagamento(VpaTipo : string) : TRBDTipoFormaPagamento;overload;
    function RNroDocumentoImpressaoCheque(VpaNumConta : string):Integer;
    function RTipoConta(VpaNumConta : string):string;
    function RDiasVencimentoFormaPagamento(VpaCodFormaPagamento : Integer): Integer;
    function RPerDescontoFormaPagamento(VpaCodFormaPagamento : Integer):double;
    procedure AlteraValorDescontoCotacao(VpaCodFilial,VpaLanOrcamento : Integer;VpaValDesconto : Double);
    procedure ExtornaValorDescontoCotacao(VpaCodFilial,VpaLanReceber : Integer;VpaValDesconto : Double);
    procedure CarDRecibo(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer;VpaDRecibo: TDadosRecibo);
    procedure AssociaFinanceiroCotacaoNaNota(VpaDNota : TRBDNotaFiscal;VpaDCotacao : TRBDOrcamento);
    function ExisteFormaPagamento(VpaCodFormaPagamento : Integer) : Boolean;overload;
    function ExisteFormaPagamento(VpaCodFormaPagamento : Integer;VpaDCheque : TRBDCheque):Boolean;overload;
    function ExisteFormaPagamento(VpaCodFormaPagamento : Integer;VpaDCaixaFormaPagamento : TRBDCaixaFormaPagamento):boolean;overload;
    function ExisteContaCorrente(VpaNumConta : String):Boolean;
    function ExisteSinalPagamentoCotacao(VpaCodFilial, VpaLanOrcamento : Integer):Boolean;
    function CompensaCheque(VpaDCheque : TRBDCheque;VpaTipOperacao : String;VpaAdicionarnoCaixa : Boolean) :string;
    function DevolveCheque(VpaCheques : TList;VpaData : TDateTime) :string;
    function ReservaCheque(VpaCheques: TList; VpaCodFornecedor: Integer): String;
    function EstornaReservaCheque(VpaCheques: TList): String;
    function EstornaCheque(VpaDCheque: TRBDCheque;VpaOrigemEstorno : TRBDOrigemEstorno) :string;
    function AlteraVencimentoCheque(VpaSeqCheque : Integer;VpaDatVencimento : TDatetime):string;
    function GeraComissaoNegativa(VpaDNotaFor : TRBDNotaFiscalFor):string;
    function CondicaoPagamentoDuplicada(VpaCondicoesPagamento : TList):Boolean;
    function ExcluiCondicaoPagamento(VpaCodCondicaoPagamento : Integer):String;
    function RValChequesNaoCompesadosContaCaixa(VpaNumConta : String):Double;
    function SetaMostarnoFluxo(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer):string;
    function MarcaTituloComoDescontado(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer):string;
    function SetaOcultarrnoFluxo(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer):string;
    procedure CarDPlanoContaOrcado(VpaDPlanoContaOrcado : TRBDPlanoContaOrcado; VpaCodEmpresa, VpaAno, VpaCodCentroCusto : Integer);
    procedure CopiaDCheque(VpaChequeOrigem, VpaChequeDestino : TRBDCheque);
    function DuplicaParcelaemAberto(VpaCodFilial, VpaLanReceber : Integer) : string;
    function DivideValoresParcelasEmAberto(VpaValor : Double; VpaCodFilial, VpaLanReceber : Integer) : string;
    function ExportaPagamentosSCI(VpaDatInicio, VpaDatFim : TDateTime):string;
    procedure ImprimePromissoria(VpaCodFilial,VpaLanOrcamento : Integer;VpaDCliente : TRBDCliente);
  end;

Var
  FunContasAReceber : TFuncoesContasAReceber;

implementation

uses constMsg, constantes, funSql, funstring, fundata, funnumeros, FunObjeto,
     AMostraParReceberOO, ABaixaContasAReceberOO, ABaixaContasaPagarOO,Uncotacao, APrincipal, AChequesOO,
     UnContasaPagar, unClientes, AChequesCP, dmrave;


{#############################################################################
                        TCalculo Contas a Receber
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosContasAReceber.cria(VpaBaseDados : TSqlConnection);
begin
  inherited;
  Calcula := TSQLQuery.Create(nil);
  Calcula.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosContasAReceber.destroy;
begin
  Calcula.Destroy;
  inherited;
end;

{ ******************* Soma Total das parcelas ****************************** }
function TCalculosContasAReceber.SomaTotalParcelas(VpaCodFilial, VpaLanReceber : Integer ) : Double;
begin
  AdicionaSQLAbreTabela(Calcula,
    ' select sum(N_VLR_PAR) as valor from MovContasaReceber ' +
    ' where I_LAN_REC = ' + IntToStr(VpaLanReceber) +
    ' and I_EMP_FIL = '   + IntToStr(VpaCodFilial) ); 
  Result := Calcula.fieldByName('valor').AsCurrency;
  calcula.close;
end;

{##################### adicionais ############################################ }

{ ***** soma os valores a receber (não nulos <> -1) do título informado ***** }
function TCalculosContasAReceber.SomaValorReceber(VpaCodFilial,VpaOrdem, VpaParcela: Integer): Double;
begin
  AdicionaSQLAbreTabela(calcula,
    ' SELECT SUM(N_VLR_REC) VALOR FROM CADCONTASAPAGAR ' +
    ' WHERE I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
    ' AND I_LAN_REC = ' + IntToStr(VpaOrdem) +
    ' AND I_PAR_REC = ' + IntToStr(VpaParcela) +
    ' AND N_VLR_REC >= 0'); // se N_VLR_REC = -1, é que foi cancelado.
  Result := calcula.FieldByName('VALOR').AsFloat;
  Calcula.close;
end;


{#############################################################################
                        TLocaliza Contas a Receber
#############################################################################  }

{ ******************** localiza uma parcela ********************************* }
procedure TLocalizaContasAReceber.LocalizaParcela(VpaTabela : TDataSet;VpaCodFilial, VpaLancamento, VpaNroParcela : integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,' select * from MOVCONTASARECEBER MOV ' +
                         ' Where  I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                         ' AND MOV.I_LAN_REC = ' + IntToStr(VpaLancamento) +
                         ' and MOV.I_NRO_PAR = ' + IntToStr(VpaNroParcela));
end;

{ ****************** localiza uma conta ************************************ }
procedure TLocalizaContasAReceber.LocalizaContaCR(tabela : TDataSet; VpaCodFilial, VpaLanReceber : Integer);
begin
  AdicionaSQLAbreTabela(Tabela, ' select * from CADCONTASARECEBER ' +
                                ' where I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber));
end;


{*********************** localiza parcelas sem parciais ********************** }
procedure TLocalizaContasAReceber.LocalizaParcelasSemParciais(tabela : TDataSet;VpaCodFilial, VpaLancamento : Integer);
begin
  AdicionaSQLAbreTabela(tabela,
    ' select * from MovContasaReceber ' +
    ' where I_LAN_REC = ' + IntToStr(VpaLancamento) +
    ' and i_emp_fil = ' + Inttostr(VpaCodFilial) +
    ' and c_fla_par = ''N''' + // parcelas parciais
    ' order by i_nro_par' );
end;

{*********************** localiza parcelas com parciais ********************** }
procedure TLocalizaContasAReceber.LocalizaParcelasComParciais(VpaTabela : TDataSet; VpaCodFilial, VpaLanReceber: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,' select * from MOVCONTASARECEBER ' +
                                 ' Where I_EMP_FIL = ' + Inttostr(VpaCodFilial) +
                                 ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                 ' order by I_NRO_PAR');
end;

{*********************** localiza parcelas sem parciais ********************** }
procedure TLocalizaContasAReceber.LocalizaParcelasFRM(tabela : TDataSet;VpaCodFilial, VpaLancamento : Integer);
begin
  AdicionaSQLAbreTabela(tabela,
    ' select * from MovContasaReceber as Mov, CadFormasPagamento as Pag' +
    ' where MOV.I_LAN_REC = ' + IntToStr(VpaLancamento) +
    ' and MOV.i_emp_fil = ' + Inttostr(VpaCodFilial) +
    ' and mov.i_cod_frm = pag.i_cod_frm ' +
    ' order by MOV.i_nro_par' );
end;

function TLocalizaContasAReceber.LocalizaNotaFiscal(Tabela : TDataSet;VpaCodFilial, VpaSeqNota : Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,
    ' SELECT I_EMP_FIL, I_LAN_REC, I_SEQ_NOT, I_LAN_ORC FROM CADCONTASARECEBER ' +
    ' where I_SEQ_NOT = ' + IntToStr(VpaSeqNota) +
    ' and I_EMP_FIL = ' + Inttostr(VpaCodFilial));
  Result := (not Tabela.EOF);
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaParcelasNotaFiscal(VpaTabela :TDataSet;VpaCodFilial, VpaSeqNota : Integer);
begin
  AdicionaSqlAbreTabela(VpaTabela,'select CR.I_LAN_REC, MCR.C_NRO_DUP, MCR.N_VLR_PAR, MCR.D_DAT_VEN ' +
              ' from CadContasAReceber CR, MovContasaReceber MCR ' +
              ' where CR.I_SEQ_NOT = ' + IntToStr(VpaSeqNota) +
              ' and CR.I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
              ' and CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
              ' and CR.I_LAN_REC =  MCR.I_LAN_REC'+
              ' order by MCR.D_DAT_VEN' );
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaParcelasCotacao(VpaTabela :TDataSet;VpaCodFilial, VpaLanOrcamento : Integer);
begin
  AdicionaSqlAbreTabela(VpaTabela,'select CR.I_LAN_REC, MCR.C_NRO_DUP, MCR.N_VLR_PAR, MCR.D_DAT_VEN ' +
              ' from CadContasAReceber CR, MovContasaReceber MCR ' +
              ' where CR.I_NRO_NOT = ' + IntToStr(VpaLanOrcamento) +
              ' and CR.I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
              ' and CR.I_SEQ_NOT IS NULL '+
              ' AND CR.C_IND_CAD = ''S''' +
              ' and CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
              ' and CR.I_LAN_REC =  MCR.I_LAN_REC'+
              ' order by MCR.D_DAT_VEN' );
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaJoinContaParcelas(tabela : TDataSet;VpaCodFilial, VpaLancamento : Integer; CampoOrderBy : string);
begin
  AdicionaSQLAbreTabela(Tabela,
    ' select * from MovContasaReceber as MCR, CadContasaReceber as CR '+
    ' where CR.I_EMP_FIL = MCR.I_EMP_FIL and CR.I_LAN_REC = MCR.I_LAN_REC ' +
    ' and CR.I_LAN_REC = ' + IntToStr(VpaLancamento) +
    ' and CR.I_EMP_FIL = ' + IntTostr(VpaCodFilial) +
    ' order by MCR.'+ CampoOrderBy );
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaMov(VpaTabela : TDataSet);
begin
  AdicionaSQLAbreTabela(Vpatabela, 'select * from MOVCONTASARECEBER '+
                                  ' Where I_EMP_FIL = 0 AND I_LAN_REC = 0 AND I_NRO_PAR = 0');
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaParcelasAbertas(VpaTabela : TDataSet; VpaCodFilial, VpaLanReceber : Integer; VpaCampoOrderBy : string);
begin
  AdicionaSQLAbreTabela(VpaTabela,    ' select * from MOVCONTASARECEBER ' +
    ' where I_EMP_FIL = ' + IntTostr(VpaCodFilial) +
    ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
    ' and D_DAT_PAG is null ' +
    ' order by ' + VpaCampoOrderBy );
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaParcelaAberta(VpaTabela : TDataSet; VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer );
begin
  AdicionaSQLAbreTabela(Vpatabela,' select * from MovContasAReceber ' +
    ' where I_EMP_FIL = ' + IntTostr(VpaCodFilial) +
    ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
    ' and i_NRO_PAR = ' + IntToStr(VpaNumParcela)+
    ' and D_DAT_PAG is null ');
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaFormaPagamento(Tabela : TDataSet; CodFormaPagto : integer );
begin
  AdicionaSQLAbreTabela( Tabela, ' select *  from CadFormasPagamento ' +
                                 ' where i_cod_frm =  ' + InttoStr(CodFormaPagto) );
end;

{************** localiza uma condicao de pagamento *************************** }
procedure TLocalizaContasAReceber.LocalizaConPagto( tabela : TDataSet; Condicao : integer);
begin
 AdicionaSQLAbreTabela( tabela, 'select * from CadCondicoesPagto where I_cod_pag = ' + IntToStr(Condicao));
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaChequesCR(VpaTabela : TDataSet;VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select CHR.SEQCHEQUE, CHR.CODFILIALRECEBER, CHR.LANRECEBER, '+
                                  ' CHR.NUMPARCELA ' +
                                  ' from  CHEQUECR CHR ' +
                                  ' Where CHR.CODFILIALRECEBER = ' + IntToStr(VpaCodFilial)+
                                  ' AND CHR.LANRECEBER = ' + IntToStr(VpaLanReceber)+
                                  ' AND CHR.NUMPARCELA = ' + IntToStr(VpaNumParcela));
end;

{******************************************************************************}
procedure TLocalizaContasAReceber.LocalizaFluxoCaixa(VpaTabela : TDataSet;VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  LimpaSqlTabela(VpaTabela);
  AdicionaSQlTabela(VpaTabela,'Select MCR.I_EMP_FIL, MCR.I_LAN_REC, MCR.I_NRO_PAR, MCR.I_COD_FRM, '+
                    ' MCR.C_NRO_CON, MCR.D_DAT_VEN, MCR.D_DAT_PAG, MCR.N_VLR_PAR, MCR.N_VLR_PAG, '+
                    ' CON.I_COD_BAN, CON.C_NOM_CRR, CON.N_LIM_CRE, CON.C_NRO_AGE, CON.N_SAL_ATU, '+
                    ' CON.I_DIA_COM');
  AdicionaSQlTabela(VpaTabela,' from MOVCONTASARECEBER MCR, CADCONTASARECEBER CR, CLIENTES CLI, CADCONTAS CON ');
  AdicionaSQlTabela(VpaTabela,' Where MCR.I_EMP_FIL = CR.I_EMP_FIL '+
                    ' AND MCR.I_LAN_REC = CR.I_LAN_REC '+
                    ' AND CR.I_COD_CLI = CLI.I_COD_CLI '+
                    ' AND MCR.C_NRO_CON *= CON.C_NRO_CON' );
  if VpaDFluxo.IndSomenteClientesQuePagamEmDia then
    AdicionaSQlTabela(VpaTabela,' and CLI.C_FIN_CON = ''S''');
  AdicionaSQlTabela(VpaTabela,'order by MCR.D_DAT_VEN, MCR.C_NRO_CON');
  VpaTabela.open;
end;

{#############################################################################
                        TFuncoes Contas a Receber
#############################################################################  }

{#####################  Na criacao e destruicao ###############################}

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesContasAReceber.cria(VpaBaseDados : TSqlConnection);
begin
  inherited;
  TextoParcelas := TStringList.Create;
  TextoVencimentos := TStringList.Create;
  FunComissoes := TFuncoesComissao.cria(VpaBaseDados);
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  CadContas := TSQL.Create(nil);
  CadContas.ASQLConnection := VpaBaseDados;
  CadCondicaoPgto := TSQLQuery.Create(nil);
  CadCondicaoPgto.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Cadastro2 := TSQL.Create(nil);
  Cadastro2.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesContasAReceber.Destroy;
begin
  TextoParcelas.Free;
  TextoVencimentos.Free;
  FunComissoes.free;
  tabela.close;
  Tabela.Destroy;
  Cadastro.free;
  Cadastro2.free;
  Aux.free;
  CAdContas.close;
  CadContas.free;
  CadCondicaoPgto.close;
  CadCondicaoPgto.free;
  Inherited;
end;

{******************************************************************************}
function TFuncoesContasAReceber.BaixarContaFormaPagamento(VpaCodForma : Integer):Boolean;
begin
  result := false;
  if VpaCodForma <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADFORMASPAGAMENTO '+
                              ' Where I_COD_FRM = '+ IntToStr(VpaCodForma));
    result := (UpperCase(Aux.FieldByName('C_BAI_CON').AsString) = 'S');
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RLogContasReceberDisponivel(VpaCodFilial,VpaLanReceber,VpaNumParcela : integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select Max(SEQLOG) ULTIMO from LOGCONTASARECEBER '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                            ' and LANRECEBER = '+IntToStr(VpaLanReceber)+
                            ' AND NUMPARCELA = '+IntToStr(VpaNumParcela));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RDescontoCliente(VpaCodCliente : Integer) : Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select N_PER_DES from CADCLIENTES '+
                            ' Where I_COD_CLI = '+ intToStr(VpaCodCliente));
  result := Aux.FieldByName('N_PER_DES').AsFloat;
  if result <> 0 then
    result := result * -1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValAbertoCliente(VpaCodCliente: Integer; VpaDatInicio, vpaDatFim: tDateTime): Double;
begin
  Aux.Sql.Clear;
  Aux.Sql.Add('select SUM(MOV.N_VLR_PAR) VALOR from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV ' +
                               ' where CAD.i_cod_cli = '+InttoStr( VpaCodCliente)+
                               ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                               SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN',VpaDatInicio,vpaDatFim,true)+
                               ' AND MOV.D_DAT_PAG IS NULL '+
                               ' AND MOV.C_FUN_PER = ''N'''+
                               ' AND CAD.C_IND_DEV = ''N''');
  Aux.Open;
  result := Aux.FieldByName('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValAcrescimoFormaPagamento(VpaCodFormaPagamento : Integer) : double;
begin
  result := 0;
  if config.CobrarFormaPagamento then
  begin
    AdicionaSQLAbreTabela(Aux,'Select N_VLR_FRM FROM CADFORMASPAGAMENTO '+
                              ' Where I_COD_FRM = ' +IntToStr(VpaCodFormaPagamento));
    Result := Aux.FieldByname('N_VLR_FRM').AsFloat;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValChequesNaoCompesadosContaCaixa(VpaNumConta: String): Double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Aux,'select sum(VALCHEQUE)VALOR , TIPCHEQUE '+
                            ' from CHEQUE '+
                            ' Where NUMCONTACAIXA = '''+VpaNumConta+''''+
                            ' AND DATDEVOLUCAO IS NULL '+
                            ' AND DATCOMPENSACAO IS NULL '+
                            ' GROUP BY TIPCHEQUE');
  while not Aux.Eof do
  begin
    if Aux.FieldByName('TIPCHEQUE').AsString = 'C' then
      result := result + Aux.FieldByName('VALOR').AsFloat
    else
      result := result - Aux.FieldByName('VALOR').AsFloat;
    Aux.next;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValorTotalJurosComposto(VpaValorTotal, VpaPerJuros : Double; VpaQtdParcelas : Integer) :Double;
var
  VpfLaco : Integer;
  VpfValParcela : Double;
begin
  result := 0;
  VpfLaco := 0;
  VpfValParcela := VpaValorTotal /VpaQtdParcelas;
  CadCondicaoPgto.first;
  while not CadCondicaoPgto.Eof do
  begin
    inc(VpfLaco);
    if CadCondicaoPgto.FieldByName('N_PER_CON').AsFloat <> 0 then
      result := result + (VpfValParcela + (((VpfValParcela * VpaPerJuros)/ 100) * VpfLaco))
    else
      result := result + VpfValParcela;
    CadCondicaoPgto.next;
  end;
  CadCondicaoPgto.first;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RParcelaAGerarParcial(VpaDBaixa : TRBDBaixaCR): TRBDParcelaBaixaCR;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    if TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]).IndGeraParcial then
      result := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RPerDescontoFormaPagamento(VpaCodFormaPagamento: Integer): double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Aux,'Select N_PER_DES FROM CADFORMASPAGAMENTO ' +
                            ' Where I_COD_FRM = '+IntToStr(VpaCodFormaPagamento));
  result := Aux.FieldByName('N_PER_DES').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RPlanoContasDisponivel(VpaCodPlanoContas: String;VpaNumPlanoContas : Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(C_CLA_PLA)ULTIMO '+
                            ' from CAD_PLANO_CONTA '+
                            ' Where C_CLA_PLA  LIKE '''+VpaCodPlanoContas+'%'''+
                            ' and LENGTH(C_CLA_PLA) = '+IntToStr(VpaNumPlanoContas));
  if aux.FieldByName('ULTIMO').AsString = '' then
    result := ''
  else
    result := AdicionaCharE('0',FloatToStr(aux.FieldByName('ULTIMO').AsFloat +1),VpaNumPlanoContas);
  Aux.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.UtilizaFaixaNossoNumero(VpaContaCorrente :String):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CADCONTAS '+
                            ' Where C_NRO_CON = '''+ VpaContaCorrente+'''');
  result := Aux.FieldByName('C_IND_FAI').AsString = 'T';
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CriaParcelasCR(VpaDNovaCR : TRBDContasCR);
var
  VpfDParcela : TRBDMovContasCR;
  VpfDatVencimento : TDateTime;
  VpfDiaAtual, VpfSequencial : Integer;
  VpfComPercentual : Boolean;
  VpfValTotal, VpfValSinal : Double;
  VpfDFormaPagamento : TRBDFormaPagamento;
begin
  VpfDFormaPagamento := TRBDFormaPagamento.cria;
  CarDFormaPagamento(VpfDFormaPagamento,VpaDNovaCR.CodFrmPagto);
  VpaDNovaCR.ValTotal := ArredondaDecimais(VpaDNovaCR.ValTotal,2);

  VpfValTotal := 0;
  VpfSequencial := 0;
  VpfValSinal := VpaDNovaCR.ValSinal;
  VpfComPercentual := false;
  VpfDatVencimento := VpaDNovaCR.DatEmissao;
  VpfDiaAtual := dia(VpfDatVencimento); // usado para modificar data fixa, nos dia (29,30,e 31 ) com vencimento sempre na data da compra
  AdicionaSQLAbreTabela(CadCondicaoPgto,'Select CAD.N_IND_REA, CAD.N_PER_DES, CAD.I_DIA_CAR, CAD.I_QTD_PAR, '+
                                        ' MOV.N_PER_PAG, MOV.N_PER_CON,'+
                                        ' MOV.C_CRE_DEB,MOV.D_DAT_FIX, MOV.I_DIA_FIX, MOV.I_NUM_DIA'+
                                        ' from CADCONDICOESPAGTO CAD, MOVCONDICAOPAGTO MOV '+
                                        ' Where CAD.I_COD_PAG = MOV.I_COD_PAG '+
                                        ' AND CAD.I_COD_PAG = '+ IntToStr(VpaDNovaCR.CodCondicaoPgto)+
                                        ' ORDER BY I_NRO_PAR');
  if CadCondicaoPgto.FieldByName('N_IND_REA').AsFloat <> 0 then
    VpaDNovaCR.ValTotal := RValorTotalJurosComposto(VpaDNovaCR.ValTotal,CadCondicaoPgto.FieldByName('N_IND_REA').AsFloat,CadCondicaoPgto.FieldByName('I_QTD_PAR').AsInteger);

  while not CadCondicaoPgto.eof do
  begin
    VpfDParcela := VpaDNovaCR.AddParcela;
    VpfDParcela.ValorBruto := VpaDNovaCR.ValTotal * (CadCondicaoPgto.fieldByName('N_PER_PAG').AsFloat / 100);
    if CadCondicaoPgto.FieldByName('N_IND_REA').AsFloat = 0 then
      VpfDParcela.ValorBruto := ArredondaDecimais(calculavalor(CadCondicaoPgto.fieldByName('N_PER_CON').AsFloat,
                                                      CadCondicaoPgto.FieldByName('C_CRE_DEB').AsString,
                                                      VpfDParcela.ValorBruto,VpaDNovaCR.ValTotal),2);
    VpfDParcela.Valor := (VpfDParcela.ValorBruto + (VpaDNovaCR.PercentualDesAcr * (VpfDParcela.ValorBruto/100))) ;
    VpfValTotal := VpfValTotal + VpfDParcela.ValorBruto;
    if CadCondicaoPgto.FieldByName('N_PER_CON').AsFloat <> 0 then
      VpfComPercentual := true;

    VpfDatVencimento := CalculaVencimento(VpfDatVencimento,CadCondicaoPgto.FieldByName('I_NUM_DIA').AsInteger,
                       CadCondicaoPgto.FieldByName('I_DIA_FIX').AsInteger,
                       CadCondicaoPgto.FieldByName('D_DAT_FIX').AsDateTime,
                       VpfDiaAtual);
    VpfDParcela.DatVencimento := VpfDatVencimento;
    VpfDParcela.DesObservacoes := VpaDNovaCR.DesObservacao;

    inc(VpfSequencial);
    if VpaDNovaCR.DPNumDuplicata  <> 0 then
       VpfDParcela.NroDuplicata := IntToStr(VpaDNovaCR.DPNumDuplicata)+ '/' + IntToStr(VpfSequencial);
      // configura o numero de documento
    if config.NumeroDocumento then
      VpfDParcela.NroDocumento := VpfDParcela.NroDuplicata
    else
      VpfDParcela.NroDocumento := InttoStr(VpaDNovaCR.LanReceber) + '/' +IntToStr(VpfSequencial); // Número do documento = I_LAN_REC + / + I_NRO_PAR.
    VpfDParcela.PerJuros := varia.Juro;
    VpfDParcela.PerMora := varia.Mora;
    VpfDParcela.PerMulta := varia.Multa;
    VpfDParcela.PerDesconto := VpaDNovaCR.PercentualDesAcr;
    VpfDParcela.PerDescontoVencimento := CadCondicaoPgto.FieldByName('N_PER_DES').AsFloat;
    VpfDParcela.CodFormaPagamento := VpaDNovaCR.CodFrmPagto;
    if VpfDFormaPagamento.FlaTipo = fpCobrancaBancaria then
    begin
      if VpaDNovaCR.NumContaCorrente <> '' then
        VpfDParcela.NroContaBoleto := VpaDNovaCR.NumContaCorrente
      else
        if VpfDFormaPagamento.CodForma = Varia.FormaPagamentoBoleto then
          VpfDParcela.NroContaBoleto := Varia.ContaBancariaBoleto
        else
          VpfDParcela.NroContaBoleto := Varia.ContaBancaria;
      CarAgenciaBancodaContaCorrente(VpfDParcela.NroContaBoleto,VpfDParcela.CodBanco,VpfDParcela.NroAgencia,VpfDParcela.DiasCompensacao);
    end;
    VpfDParcela.DatProrrogacao := IncDia(VpfDatVencimento,VpfDParcela.DiasCompensacao);

    VpfDParcela.DiasCarencia := CadCondicaoPgto.FieldByName('I_DIA_CAR').AsInteger;
    VpfDParcela.IndBaixarConta := VpfDFormaPagamento.IndBaixarConta ;
    if VpfDParcela.IndBaixarConta then
    begin
      if VpaDNovaCR.NumContaCaixa <> '' then
        VpfDParcela.NumcontaCaixa := VpaDNovaCR.NumContaCaixa
      else
        VpfDParcela.NumcontaCaixa := varia.CaixaPadrao;
    end;
    if VpfValSinal > 0 then
    begin
      VpfDatVencimento := VpaDNovaCR.DatEmissao;
      VpfDParcela.DatVencimento := VpaDNovaCR.DatPagamentoSinal;
      VpfDParcela.CodFormaPagamento := varia.FormaPagamentoDinheiro;
      if VpfValSinal >= VpfDParcela.Valor then
      begin
        VpfDParcela.ValSinal :=VpfDParcela.Valor;
      end
      else
      begin
        VpfDParcela.ValSinal :=VpfValSinal;
        VpfValTotal := VpfValTotal - VpfDParcela.Valor;
        VpfDParcela.Valor := VpfValSinal;
        VpfValTotal := VpfValTotal + VpfDParcela.Valor;
      end;
      VpfValSinal := VpfValSinal - VpfDParcela.ValSinal;
      if VpfValSinal >0  then
        Continue;
    end;

    CadCondicaoPgto.next;
  end;
  if (VpfDParcela <> nil) then
  begin
    if not(VpfComPercentual) and (CadCondicaoPgto.FieldByName('N_IND_REA').AsFloat = 0) then
      VpfDParcela.Valor := VpfDParcela.Valor + (VpaDNovaCR.ValTotal - VpfValTotal);
  end;
  CadCondicaoPgto.close;
  VpfDFormaPagamento.free;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDParcelasCR(VpaDNovaCR : TRBDContasCR):String;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
begin
  result := '';
  VpaDNovaCR.ValTotalAcrescimoFormaPagamento := 0;
  AdicionaSQLAbreTabela(CadContas,'Select * from MOVCONTASARECEBER'+
                                  ' Where I_EMP_FIL = 0 AND I_LAN_REC = 0 AND I_NRO_PAR = 0');

  for VpfLaco := 0 to VpaDNovaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[Vpflaco]);
    if VpfDParcela.ValSinal = 0 then
    begin
      CadContas.Insert;
      VpfDParcela.NumParcela := VpfLaco + 1;
      CadContas.FieldByName('I_EMP_FIL').AsInteger := VpaDNovaCR.CodEmpFil;
      CadContas.FieldByName('I_LAN_REC').AsInteger := VpaDNovaCR.LanReceber;
      CadContas.FieldByName('I_NRO_PAR').AsInteger := VpfDParcela.NumParcela;
      CadContas.FieldByName('I_COD_CLI').AsInteger := VpaDNovaCR.CodCliente;
      CadContas.FieldByName('I_COD_FRM').AsInteger := VpfDParcela.CodFormaPagamento;
      CadContas.FieldByName('D_DAT_VEN').AsDateTime := VpfDParcela.DatVencimento;
      CadContas.FieldByName('D_DAT_PRO').AsDateTime := VpfDParcela.DatProrrogacao;
      if VpfDParcela.DiasCarencia > 2 then
        CadContas.FieldByName('D_PRO_LIG').AsDateTime := IncDia(VpfDParcela.DatVencimento,VpfDParcela.DiasCarencia)
      else
        CadContas.FieldByName('D_PRO_LIG').AsDateTime := IncDia(VpfDParcela.DatVencimento,2);
      CadContas.FieldByName('N_VLR_PAR').AsFloat := VpfDParcela.Valor;
      CadContas.FieldByName('N_VLR_BRU').AsFloat := VpfDParcela.ValorBruto;
      if VpfDParcela.ValDesconto <> 0 then
        CadContas.FieldByName('N_VLR_DES').AsFloat := VpfDParcela.ValDesconto
      else
        CadContas.FieldByName('N_VLR_DES').Clear;
      CadContas.FieldByName('N_PER_MOR').AsFloat := VpfDParcela.PerMora;
      CadContas.FieldByName('N_PER_JUR').AsFloat := VpfDParcela.PerJuros;
      CadContas.FieldByName('N_PER_MUL').AsFloat := VpfDParcela.PerMulta;
      CadContas.FieldByName('C_NRO_DOC').AsString := VpfDParcela.NroDocumento;
      CadContas.FieldByName('L_OBS_REC').AsString := VpfDParcela.DesObservacoes;
      CadContas.FieldByName('C_NRO_DUP').AsString := VpfDParcela.NroDuplicata;
      CadContas.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
      IF VpfDParcela.CodBanco <> 0 then
        CadContas.FieldByName('I_COD_BAN').AsInteger := VpfDParcela.CodBanco;
      if VpfDParcela.NroAgencia <> '' then
        CadContas.FieldByName('C_NRO_AGE').asString := VpfDParcela.NroAgencia
      else
        CadContas.FieldByName('C_NRO_AGE').clear;
      if VpaDNovaCR.EsconderConta then
        CadContas.FieldByName('C_IND_CAD').AsString := 'S'
      else
        CadContas.FieldByName('C_IND_CAD').AsString := 'N';

      CadContas.FieldByName('N_DES_VEN').AsFloat := VpfDParcela.PerDescontoVencimento;
      CadContas.FieldByName('C_FLA_PAR').AsString := 'N';
      CadContas.FieldByName('L_OBS_REC').AsString := VpfDParcela.DesObservacoes;
      CadContas.FieldByName('I_DIA_CAR').AsInteger := VpfDParcela.DiasCarencia;
      CadContas.FieldByName('N_PER_ACR').AsFloat := 0;
      CadContas.FieldByName('N_PER_DES').AsFloat := VpfDParcela.PerDesconto;
      CadContas.FieldByName('I_FIL_PAG').AsInteger := VpaDNovaCR.CodEmpFil;
      CadContas.FieldByName('C_DUP_IMP').AsString := 'N';
      CadContas.FieldByName('C_FUN_PER').AsString := 'N';
      CadContas.FieldByName('C_BAI_CAR').AsString := 'N';
      CadContas.FieldByName('C_IND_REM').AsString := 'N';
      CadContas.FieldByName('I_COD_MOE').AsInteger := Varia.MoedaBase;
      CadContas.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
      if VpfDParcela.NroContaBoleto <> '' then
      begin
        CadContas.FieldByName('C_NRO_CON').AsString := VpfDParcela.NroContaBoleto;
        CadContas.FieldByName('C_NOS_NUM').AsString := RNossoNumero(CadContas.FieldByName('I_LAN_REC').AsInteger,CadContas.FieldByName('I_NRO_PAR').AsInteger,VpfDParcela.NroContaBoleto);
      end;
      CadContas.post;
      Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
      result := CadContas.AMensagemErroGravacao;
      if result <> '' then
      begin
        CadContas.close;
        exit;
      end;
    end;
  end;
  CadContas.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GeraComissaoCR(VpaDNovaCR : TRBDContasCR) : string;
var
  VpfDComissao : TRBDComissao;
  VpfLaco : Integer;
begin
  result := '';
  if (ConfigModulos.Comissao)  then
    if VpaDNovaCR.CodVendedor <> 0 then
    begin
      VpfDComissao := TRBDComissao.cria;
      VpfDComissao.CodFilial := VpaDNovaCR.CodEmpFil;
      VpfDComissao.LanReceber := VpaDNovaCR.LanReceber;
      VpfDComissao.CodVendedor := VpaDNovaCR.CodVendedor;
      VpfDComissao.TipComissao := VpaDNovaCR.TipComissao;
      VpfDComissao.ValTotalProdutos := VpaDNovaCR.ValTotalProdutos;
      VpfDComissao.PerComissao := VpaDNovaCR.PerComissao;
      if VpaDNovaCR.TipComissao = 1 then
      begin
        if VpaDNovaCR.ValBaseComissao > 0 then
          VpfDComissao.PerComissao :=  (VpaDNovaCR.ValComissao *100)/VpaDNovaCR.ValBaseComissao
        else
          VpfDComissao.PerComissao:=0;
      end;
      VpfDComissao.ValTotalComissao := VpaDNovaCR.ValComissao;
      VpfDComissao.DatEmissao := VpaDNovaCR.DatEmissao;
      FunComissoes.GeraParcelasComissao(VpaDNovaCR,VpfDComissao);
      result := FunComissoes.GravaDComissoes(VpfDComissao);
      if result = '' then
      begin
  //colocado em comentario porque estava excluindo a comissao do vendedor.
      if VpaDNovaCR.CodPreposto <> 0 then
        begin
          VpfDComissao.SeqComissao := 0;
          VpfDComissao.CodVendedor := VpaDNovaCR.CodPreposto;
          VpfDComissao.TipComissao := VpaDNovaCR.TipComissaoPreposto;
          if VpaDNovaCR.TipComissaoPreposto = 0 then
            VpfDComissao.PerComissao := VpaDNovaCR.PerComissaoPreposto
          else
            VpfDComissao.PerComissao := 0;

          VpfDComissao.ValTotalComissao := VpaDNovaCR.ValComissaoPreposto;
          FunComissoes.GeraParcelasComissao(VpaDNovaCR,VpfDComissao);
          result := FunComissoes.GravaDComissoes(VpfDComissao);
        end;
      end;
      VpfDComissao.free;
    end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GeraLogReceber(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaFuncao : String):String;
var
  VpfLaco : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from LOGCONTASARECEBER '+
                                 ' Where CODFILIAL = 0 AND LANRECEBER = 0 AND NUMPARCELA = 0 AND SEQLOG = 0' );
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVCONTASARECEBER '+
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial)+
                               ' and I_LAN_REC = '+InttoStr(VpaLanreceber)+
                               ' and I_NRO_PAR = '+InttoStr(VpaNumparcela));
  Cadastro.insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  Cadastro.FieldByName('LANRECEBER').AsInteger := VpaLanReceber;
  Cadastro.FieldByName('NUMPARCELA').AsInteger := VpaNumParcela;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('DATLOG').AsDateTime := now;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  Cadastro.FieldByName('DESLOG').AsString := VpaFuncao;
  Cadastro.FieldByName('DESMODULO').AsString := NomeModulo;
  Cadastro.FieldByName('NOMCOMPUTADOR').AsString := Varia.NomeComputador;
  for VpfLaco := 0 to Tabela.FieldCount - 1 do
    Cadastro.FieldByName('DESINFORMACOES').AsString := Cadastro.FieldByName('DESINFORMACOES').AsString + #13+
                            Tabela.Fields[VpfLaco].DisplayName +' = "'+
                            Tabela.FieldByName(Tabela.Fields[VpfLaco].DisplayName).AsString+'"';
  Cadastro.FieldByName('SEQLOG').AsInteger := RLogContasReceberDisponivel(VpaCodFilial,VpaLanReceber,VpaNumParcela);
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ContasConsolidadasValidas(VpaDContas : TRBDContasConsolidadasCR):String;
begin
  result := '';
  if VpaDContas.ItemsContas.Count = 0 then
  begin
    result := 'FALTA SELECIONAR CONTA!!!'#13'Não foi adicionado nenhuma conta para ser consolidada.'
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CopiaDCheque(VpaChequeOrigem,VpaChequeDestino: TRBDCheque);
begin
  VpaChequeDestino.SeqCheque := VpaChequeOrigem.SeqCheque;
  VpaChequeDestino.CodBanco := VpaChequeOrigem.CodBanco;
  VpaChequeDestino.CodFormaPagamento := VpaChequeOrigem.CodFormaPagamento;
  VpaChequeDestino.CodCliente := VpaChequeOrigem.CodCliente;
  VpaChequeDestino.NumCheque := VpaChequeOrigem.NumCheque+1;
  VpaChequeDestino.CodUsuario := VpaChequeOrigem.CodUsuario;
  VpaChequeDestino.NumConta := VpaChequeOrigem.NumConta;
  VpaChequeDestino.NumAgencia := VpaChequeOrigem.NumAgencia;
  VpaChequeDestino.NumContaCaixa := VpaChequeOrigem.NumContaCaixa;
  VpaChequeDestino.NomContaCaixa := VpaChequeOrigem.NomContaCaixa;
  VpaChequeDestino.NomEmitente := VpaChequeOrigem.NomEmitente;
  VpaChequeDestino.NomNomimal := VpaChequeOrigem.NomNomimal;
  VpaChequeDestino.NomFormaPagamento := VpaChequeOrigem.NomFormaPagamento;
  VpaChequeDestino.TipCheque := VpaChequeOrigem.TipCheque;
  VpaChequeDestino.TipContaCaixa := VpaChequeOrigem.TipContaCaixa;
  VpaChequeDestino.NomCliente := VpaChequeOrigem.NomCliente;
  VpaChequeDestino.ValCheque := VpaChequeOrigem.ValCheque;
  VpaChequeDestino.DatCadastro := VpaChequeOrigem.DatCadastro;
  VpaChequeDestino.DatVencimento := IncMes(VpaChequeOrigem.DatVencimento,1);
  VpaChequeDestino.DatCompensacao := VpaChequeOrigem.DatCompensacao;
  VpaChequeDestino.DatDevolucao := VpaChequeOrigem.DatDevolucao;
  VpaChequeDestino.DatEmissao := VpaChequeOrigem.DatEmissao;
  VpaChequeDestino.TipFormaPagamento := VpaChequeOrigem.TipFormaPagamento;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDMovCRContaConsolidada(VpaDContas : TRBDContasConsolidadasCR):String;
var
  VpfDItemConta : TRBDItemContasConsolidadasCR;
begin
  result := '';
  VpfDItemConta := TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[0]);
  AdicionaSQLAbreTabela(CadContas,'Select * from MOVCONTASARECEBER '+
                                  ' Where I_EMP_FIL = 11 '+
                                  ' AND I_LAN_REC = 0');
  CadContas.insert;
  CadContas.FieldByName('I_EMP_FIL').AsInteger := VpaDContas.CodFilial;
  CadContas.FieldByName('I_LAN_REC').AsInteger := VpaDContas.LanReceber;
  CadContas.FieldByName('I_NRO_PAR').AsInteger := 1;
  CadContas.FieldByName('I_COD_FRM').AsInteger := VpfDItemConta.CodFormaPagamento;
  CadContas.FieldByName('D_DAT_VEN').AsDateTime := VpaDContas.DatVencimento;
  CadContas.FieldByName('N_VLR_PAR').AsFloat := VpaDContas.ValConsolidacao;
  CadContas.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
  CadContas.FieldByName('C_FLA_PAR').AsString := 'N';
  CadContas.FieldByName('L_OBS_REC').AsString := VpaDContas.NroNotasFiscais;
  CadContas.FieldByName('I_PAR_MAE').AsInteger := 1;
  CadContas.FieldByName('N_PER_MOR').AsFloat := Varia.Mora;
  CadContas.FieldByName('N_PER_JUR').AsFloat := Varia.Juro;
  CadContas.FieldByName('N_PER_MUL').AsFloat := Varia.Multa;
  CadContas.FieldByName('N_DES_VEN').AsInteger := 0;
  CadContas.FieldByName('I_DIA_CAR').AsInteger := 0;
  CadContas.FieldByName('N_PER_ACR').AsFloat := 0;
  CadContas.FieldByName('N_PER_DES').AsFloat := VpaDContas.PerDesconto;
  CadContas.FieldByName('N_VLR_DES').AsFloat := VpaDContas.ValDesconto;
  CadContas.FieldByName('I_FIL_PAG').AsInteger := VpaDContas.CodFilial;
  CadContas.FieldByName('I_COD_MOE').AsInteger := VpfDItemConta.CodMoeda;
  CadContas.FieldByName('C_BAI_CAR').AsString := 'N';
  CadContas.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  CadContas.Post;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
  result := CadContas.AMensagemErroGravacao;
  CadContas.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDContaConsolidadaItem(VpaDContas : TRBDContasConsolidadasCR) : String;
var
  VpfLaco : Integer;
  VpfDContaItem : TRBDItemContasConsolidadasCR;
begin
  result := '';
  for VpfLaco := 0 to VpaDContas.ItemsContas.Count - 1 do
  begin
    VpfDContaItem := TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[VpfLaco]);
    Aux.close;
    Aux.sql.clear;
    Aux.sql.add('INSERT INTO MOVCONTACONSOLIDADACR (I_EMP_FIL,I_REC_PAI,I_LAN_REC,I_NRO_PAR) VALUES(');
    AUX.SQL.add(IntToStr(VpaDContas.CodFilial)+','+
                IntToStr(VpaDContas.LanReceber)+','+
                IntToStr(VpfDContaItem.LanReceber)+','+
                IntToStr(VpfDContaItem.NroParcela)+')');
    try
      Aux.execsql;
    except
      on e : Exception do result := 'ERRO NA GRAVAÇÃO DO MOVCONTACONSOLIDADACR!!!'#13+e.message;
    end;

  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.AtualizaDadosClientes(VpaDContas : TRBDContasCR):String;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCLIENTES '+
                                 ' Where I_COD_CLI = '+ IntToStr(VpaDContas.CodCliente));
  if Cadastro.FieldByName('I_FRM_PAG').AsInteger = 0 Then
  begin
    Cadastro.Edit;
    Cadastro.FieldByName('I_FRM_PAG').AsInteger := VpaDContas.CodFrmPagto;
  end;
  if Cadastro.FieldByName('I_COD_PAG').AsInteger = 0 Then
  begin
    if not (Cadastro.State =dsedit) then
      Cadastro.edit;
    Cadastro.FieldByName('I_COD_PAG').AsInteger := VpaDContas.CodCondicaoPgto;
  end;
  if Cadastro.State = dsedit then
  begin
    Cadastro.FieldByName('D_DAT_ALT').AsDateTime := Sistema.RDataServidor;
    Cadastro.Post;
    Sistema.MarcaTabelaParaImportar('CADCLIENTES');
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RAgenciaConta(VpaNumConta : String):string;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CADCONTAS '+
                            ' Where C_NRO_CON = '''+VpaNumConta+'''');
  result := Aux.FieldByName('C_NRO_AGE').AsString;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarAgenciaBancodaContaCorrente(VpaNumConta : String;Var VpaCodBanco : Integer;var VpaNumAgencia : string;Var VpaQtdDiasCompensacao : Integer);
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CADCONTAS '+
                            ' Where C_NRO_CON = '''+VpaNumConta+'''');
  VpaNumAgencia := Aux.FieldByName('C_NRO_AGE').AsString;
  VpaCodBanco := Aux.FieldByName('I_COD_BAN').AsInteger;
  VpaQtdDiasCompensacao := AUX.FieldByName('I_DIA_COM').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteRemessa(VpaCodFilial, VpaSeqRemessa,VpaLanReceber,VpaNumParcela : Integer) : Boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(Tabela,'Select * from REMESSAITEM '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                               ' and SEQREMESSA = '+IntToStr(VpaSeqRemessa)+
                               ' and LANRECEBER = '+IntToStr(VpaLanReceber)+
                               ' and NUMPARCELA = '+IntToStr(VpaNumParcela));
  result := not Tabela.Eof;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteSequencialReceber(VpaCodFilial, VpaLanReceber: Integer): boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_EMP_FIL FROM CADCONTASARECEBER ' +
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                            ' and I_LAN_REC = ' +IntToStr(VpaLanReceber));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteSinalPagamentoCotacao(VpaCodFilial,VpaLanOrcamento: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select 1 from CADCONTASARECEBER ' +
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' AND I_LAN_ORC =  '+ IntToStr(VpaLanOrcamento));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExportaPagamentosSCI(VpaDatInicio,VpaDatFim: TDateTime): string;
var
  VpfLinha : String;
  VpfArquivo : TStringList;
  VpfSequencia : Integer;
begin
  result := '';
  VpfSequencia := 0;
  VpfArquivo := TStringList.Create;
  AdicionaSQLAbreTabela(Tabela,'Select MOV.D_DAT_PAG, MOV.C_NRO_DUP, MOV.N_VLR_PAG,  ' +
                               ' CAD.I_NRO_NOT, CAD.I_COD_CLI '+
                               ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD ' +
                               ' Where MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                               ' AND MOV.I_LAN_REC = CAD.I_LAN_REC ' +
                               SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_PAG',VpaDatInicio,VpaDatFim,true));
  while not Tabela.Eof do
  begin
    inc(VpfSequencia);
    VpfLinha := IntToStr(VpfSequencia)+','+
    //data
    FormatDateTime('DD/MM/YYYY',Tabela.FieldByName('D_DAT_PAG').AsDateTime)+
    //Debito
    '0,'+
    //Credito
    Tabela.FieldByName('I_COD_CLI').AsString+ ','+
    //valor
    SubstituiStr(FormatFloat('#############0.00',Tabela.FieldByName('N_VLR_PAG').AsFloat),',','.') +','+
    //historico padrao
    Tabela.FieldByName('I_NRO_NOT').AsString+ ','+
    //Complemento
    Tabela.FieldByName('C_NRO_DUP').AsString+','+
    //LOTE
    'VENDAS';
    VpfArquivo.Add(VpfLinha);
    Tabela.Next;
  end;
  Tabela.Close;
  VpfArquivo.SaveToFile('c:\baixacr.txt');
  VpfArquivo.Free;
  Aviso('Arquivo "c:\baixacr.txt" gerado com sucesso');
end;

{******************************************************************************}
function TFuncoesContasAReceber.ParcelaJaAdicionadaRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Tabela,'Select * from REMESSAITEM '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                               ' and LANRECEBER = '+IntToStr(VpaLanReceber)+
                               ' and NUMPARCELA = '+IntToStr(VpaNumParcela));
  if not Tabela.eof then
    result := 'PARCELA JÁ ADICIONADA!!!'#13'A parcela selecionada já foi adicionada no arquivo de remessa "'+Tabela.FieldByName('SEQREMESSA').AsString+'"';
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RProximoSeqRemessa(VpaCodFilial : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MAX(SEQREMESSA) ULTIMO from REMESSACORPO '+
                              ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  Result := Tabela.FieldByName('ULTIMO').AsInteger +1;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RQtdParcelasEmAberto(VpaCodFilial,VpaLanReceber: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(I_EMP_FIL) QTD FROM MOVCONTASARECEBER ' +
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                            ' AND I_LAN_REC = ' +IntToStr(VpaLanReceber)+
                            ' AND D_DAT_PAG IS NULL');
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RSeqReceberDisponivel(VpaCodFilial: Integer): Integer;
begin
  if varia.TipoBancoDados = bdMatrizSemRepresentante then
  begin
    result := GeraProximoCodigo('I_LAN_REC','CADCONTASARECEBER','I_EMP_FIL', VpaCodFilial,  false,Cadastro.ASqlConnection);
  end
  else
  begin
    repeat
      AdicionaSQLAbreTabela(Tabela,'Select LANRECEBER FROM SEQUENCIALCONTASARECEBER '+
                                ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' order by LANRECEBER');
      result := Tabela.FieldByName('LANRECEBER').AsInteger;
      if result = 0 then
      begin
        aviso('FINAL SEQUENCIAL RECEBER!!!'#13'Não existem mais sequenciais de contas a receber disponivel, é necessário gerar mais sequenciais ou fazer uma importação de dados.');
        break;
      end;
      Tabela.Close;
      ExecutaComandoSql(Tabela,'Delete from SEQUENCIALCONTASARECEBER ' +
                            ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and LANRECEBER = '+IntToStr(result));
    until (not ExisteSequencialReceber(VpaCodFilial,result));
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RSeqRemessaCorpoAberto(VpaCodFilial : Integer;VpaContaCorrente : String):Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select * from REMESSACORPO '+
                              ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                              ' and NUMCONTA = '''+VpaContaCorrente+''''+
                              ' and DATBLOQUEIO is null' );
  result := AUX.FieldByName('SEQREMESSA').AsInteger;
  AUX.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RTipoFormapagamento(VpaTipo: TRBDTipoFormaPagamento): string;
begin
  case VpaTipo of
    fpDinheiro: result:= 'D' ;
    fpCheque :  result:= 'C' ;
    fpCartaoCredito:  result:= 'T' ;
    fpCobrancaBancaria:  result:= 'B' ;
    fpChequeTerceiros:  result:= 'R' ;
    fpCarteira:  result:= 'A' ;
    fpCartaoDebito: result:= 'E' ;
    fpDepositoCheque: result:= 'P' ;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RTipoConta(VpaNumConta: string): string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_TIP_CON FROM CADCONTAS ' +
                            ' WHERE C_NRO_CON = '''+VpaNumConta + '''');
  result := Aux.FieldByName('C_TIP_CON').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RTipoFormaPagamento(VpaTipo: string): TRBDTipoFormaPagamento;
begin
  if VpaTipo = 'D' then
    result := fpDinheiro
  else
    if VpaTipo = 'C' then
      result := fpCheque
    else
      if VpaTipo = 'T' then
        result := fpCartaoCredito
      else
        if VpaTipo = 'B' then
          result := fpCobrancaBancaria
        else
          if VpaTipo = 'R' then
            result := fpChequeTerceiros
          else
            if VpaTipo = 'A' then
              result := fpCarteira
            else
              if VpaTipo = 'E' then
                result := fpCartaoDebito
              else
                if VpaTipo = 'P' then
                  result := fpDepositoCheque;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RUltimaParcelaemAberto(VpaCodFilial,VpaLanReceber: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(I_NRO_PAR) ULTIMA FROM MOVCONTASARECEBER ' +
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                            ' and I_LAN_REC = ' +IntToStr(VpaLanReceber)+
                            ' AND D_DAT_PAG IS NULL');
  result := Aux.FieldByName('ULTIMA').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ImprimePromissoria(VpaCodFilial,VpaLanOrcamento: Integer;VpaDCliente : TRBDCliente);
Var
  VpfDFilial : TRBDFilial;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.C_NRO_DUP, MOV.N_VLR_PAR, MOV.D_DAT_VEN '+
                               ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD  ' +
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                               ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                               ' AND CAD.I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                               ' AND CAD.I_LAN_ORC = ' + IntToStr(VpaLanOrcamento));
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,VpaCodFilial);
  dtRave := TdtRave.create(nil);
  dtRave.Promissoria.close;
  dtRave.Promissoria.open;
  while not Tabela.Eof do
  begin
    dtRave.Promissoria.insert;
    dtRave.PromissoriaDesDuplicata.AsString := Tabela.FieldByName('C_NRO_DUP').AsString;
    dtRave.PromissoriaValDuplicata.AsFloat := Tabela.FieldByName('N_VLR_PAR').AsFloat;
    dtRave.PromissoriaDesValorExtenso.AsString := Extenso(Tabela.FieldByName('N_VLR_PAR').AsFloat,'real','reais');
    dtRave.PromissoriaDesLocaleData.AsString := varia.CidadeFilial+' '+ IntTostr(dia(date))+', de ' + TextoMes(date,false)+ ' de '+Inttostr(ano(date));
    dtRave.PromissoriaNumDiaVencimento.AsInteger := dia(Tabela.FieldByName('D_DAT_VEN').AsDateTime);
    dtRave.PromissoriaDesDiaVencimento.AsString := Extenso(dia(Tabela.FieldByName('D_DAT_VEN').AsDateTime),'dia','dias');
    dtRave.PromissoriaNumAnoVencimento.AsInteger := Ano(Tabela.FieldByName('D_DAT_VEN').AsDateTime);
    dtRave.PromissoriaDesMesVencimto.AsString := TextoMes(Tabela.FieldByName('D_DAT_VEN').AsDateTime,false);
    dtRave.Promissoria.Post;
    Tabela.Next;
  end;
  try
    dtRave.ImprimePromissoria(true);
  finally
    dtRave.Free;
  end;

  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.InicializaNovaRemessa(VpaCodFilial : Integer;VpaContaCorrente : String):Integer;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from REMESSACORPO '+
                                 ' Where CODFILIAL = 11 AND SEQREMESSA = 0');
  Cadastro.Insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  Cadastro.FieldByName('DATINICIO').AsDateTime := now;
  Cadastro.FieldByName('NUMCONTA').AsString := VpaContaCorrente;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := varia.CodigoUsuario;
  result := RProximoSeqRemessa(VpaCodFilial);
  Cadastro.FieldByName('SEQREMESSA').AsInteger := Result;
  Cadastro.post;
  if Cadastro.AErronaGravacao then
    result := 0;
  Cadastro.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.AdicionaRemessaItem(VpaCodFilial, VpaSeqRemessa,VpaLanReceber,VpaNumParcela,VpaCodMovimento : Integer;VpaNomMotivo : String) : string;
begin
  result := '';
  if ExisteRemessa(VpaCodFilial,VpaSeqRemessa,VpaLanReceber,VpaNumParcela) then
    result := 'PARCELA DUPLICADA NO ARQUIVO DE REMESSA!!!'#13'Esta parcela já existe no arquivo de remessa corrente.';
  if result = '' then
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from REMESSAITEM '+
                                   ' Where CODFILIAL = 0 AND SEQREMESSA = 0 AND LANRECEBER = 0 AND NUMPARCELA = 0');
    Cadastro.Insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger :=  VpaCodFilial;
    Cadastro.FieldByName('SEQREMESSA').AsInteger := VpaSeqRemessa;
    Cadastro.FieldByName('LANRECEBER').AsInteger := VpaLanReceber;
    Cadastro.FieldByName('NUMPARCELA').AsInteger := VpaNumParcela;
    Cadastro.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
    Cadastro.FieldByName('CODMOVIMENTO').AsInteger := VpaCodMovimento;
    Cadastro.FieldByName('NOMMOTIVO').AsString := VpaNomMotivo;
    Cadastro.FieldByName('INDCONFIRMADA').AsString := 'N';
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    Cadastro.Close;

    if result = '' then
      ExecutaComandoSql(Aux,'Update MOVCONTASARECEBER set C_IND_REM = ''S'''+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' AND I_LAN_REC = '+IntToStr(VpaLanReceber)+
                            ' AND I_NRO_PAR = '+ IntToStr(VpaNumParcela));

  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RProximoSeqCobranca : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(SEQCOBRANCA) ULTIMO from COBRANCACORPO ');
  result := Aux.FieldByName('ULTIMO').AsInteger+1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.AdicionaParcelasCRNaRemessa(VpaDContasAReceber : TRBDContasCR):string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
begin
  result := '';
  for VpfLaco := 0 to VpaDContasAReceber.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VpaDContasAReceber.Parcelas.Items[VpfLaco]);
    if VpfDParcela.CodFormaPagamento = varia.FormaPagamentoBoleto then
      result := adicionaremessa(VpaDContasAReceber.CodEmpFil,VpaDContasAReceber.LanReceber,VpfDParcela.NumParcela,1,'Remessa');
    if result <> '' then
      exit;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDCobrancaItem(VpaDCobranca : TRBDCobrancoCorpo) : String;
var
  VpfDItem : TRBDCobrancaItem;
  Vpflaco : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from COBRANCAITEM ');
  for VpfLaco := 0 to VpaDCobranca.Items.Count - 1 do
  begin
    VpfDItem := TRBDCobrancaItem(VpaDCobranca.Items.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('SEQCOBRANCA').AsInteger := VpaDCobranca.SeqCobranca;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpfDItem.CodFilial;
    Cadastro.FieldByName('LANRECEBER').AsInteger := VpfDItem.LanReceber;
    Cadastro.FieldByName('NUMPARCELA').AsInteger := VpfDItem.NumParcela;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.AtualizaItemscobranca(VpaDCobranca : TRBDCobrancoCorpo) : string;
var
  vpfLaco : Integer;
  VpfDItem : TRBDCobrancaItem;
begin
  result := '';
  Aux.Sql.Clear;
  Aux.Sql.add('UPDATE MOVCONTASARECEBER '+
              ' SET D_PRO_LIG = '+SQLTextoDataAAAAMMMDD(VpaDCobranca.DatProximaLigacao)+
              ' , D_DAT_PRO = '+SQLTextoDataAAAAMMMDD(VpaDCobranca.DatPromessa)+
              ' , C_OBS_LIG = '''+DeletaChars(VpaDCobranca.DesObsProximaLigacao,'''')+''''+
              ' , I_QTD_LIG = '+SQLTextoIsNull('I_QTD_LIG','0')+' +1');
  if VpaDCobranca.IndAtendeu then
    Aux.Sql.add(', I_QTD_ATE = '+SQLTextoIsnull('I_QTD_ATE','0')+' +1');
  if VpaDCobranca.CodMotivo <> 0 then
    Aux.Sql.add(', I_MOT_INA = '+IntToStr(VpaDCobranca.CodMotivo));

  Aux.Sql.add(' Where D_DAT_PAG IS NULL'+
              ' and I_COD_CLI = '+IntToStr(VpaDCobranca.CodCliente));
{29/03/2009
   rotina colocada em comentario pois na Reloponto(Janaina) e no Feldmann(Carla) estavam reclamando que as cobranças
   estavam reaparecendo elas faziam uma cobrança receptiva no dia 13/02 e aparecia uma parcela vencida de fevereiro,
   elas colocavam para ligar novamente no dia 20/03 e no dia 18/03 o cliente reaparecia para ligar pois tinha outra
   parcela que vencia.

   if VpaDCobranca.IndCobrarCliente then
    Aux.sql.add('AND D_DAT_VEN <= ' +SQLTextoDataAAAAMMMDD(Date))
  else
    Aux.sql.add(' and D_PRO_LIG  <= '+SQLTextoDataAAAAMMMDD(VpaDCobranca.DatProximaLigacao));}
  Aux.sql.add(' and D_PRO_LIG  <= '+SQLTextoDataAAAAMMMDD(VpaDCobranca.DatProximaLigacao));
  try
    Aux.ExecSQL;
  except
    on e : exception do result :=  'ERRO NA ATUALIZAÇÃO DOS ITENS DA COBRANÇA!!!'#13+e.message;
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.AtualizaTotalContasOrcadas(VpaDPlanoContaOrcado: TRBDPlanoContaOrcado; VpaDItemPlanoContaOrcado : TRBDPlanoContaOrcadoItem;Var  VpaPosLaco : Integer);
var
  VpfDItemPlanoContas : TRBDPlanoContaOrcadoItem;
  VpfPosLacoInicial : Integer;
begin
  ZeraPlanoContasOrcadoItem(VpaDItemPlanoContaOrcado);
  VpfPosLacoInicial := VpaPosLaco;
  VpaPosLaco := VpaPosLaco + 1;
  while VpaPosLaco < VpaDPlanoContaOrcado.PlanoContas.Count - 1 do
  begin
    VpfDItemPlanoContas := TRBDPlanoContaOrcadoItem(VpaDPlanoContaOrcado.PlanoContas.Items[VpaPosLaco]);
    if (Copy(VpfDItemPlanoContas.CodPlanoContas,1,length(VpaDItemPlanoContaOrcado.CodPlanoContas)) <> VpaDItemPlanoContaOrcado.CodPlanoContas)and
       (VpfPosLacoInicial >0) then
    begin
      VpaPosLaco := VpaPosLaco - 1;
      break;
    end;
    if PossiuPlanoContasOrcadoFilho(VpaDPlanoContaOrcado,VpfDItemPlanoContas,VpaPosLaco) then
    begin
      AtualizaTotalContasOrcadas(VpaDPlanoContaOrcado,VpfDItemPlanoContas,VpaPosLaco);
    end;
    VpaDItemPlanoContaOrcado.ValJaneiro := VpaDItemPlanoContaOrcado.ValJaneiro + VpfDItemPlanoContas.ValJaneiro;
    VpaDItemPlanoContaOrcado.ValFevereiro := VpaDItemPlanoContaOrcado.ValFevereiro + VpfDItemPlanoContas.ValFevereiro;
    VpaDItemPlanoContaOrcado.ValMarco := VpaDItemPlanoContaOrcado.ValMarco + VpfDItemPlanoContas.ValMarco;
    VpaDItemPlanoContaOrcado.ValAbril := VpaDItemPlanoContaOrcado.ValAbril + VpfDItemPlanoContas.ValAbril;
    VpaDItemPlanoContaOrcado.ValMaio := VpaDItemPlanoContaOrcado.ValMaio + VpfDItemPlanoContas.ValMaio;
    VpaDItemPlanoContaOrcado.ValJunho := VpaDItemPlanoContaOrcado.ValJunho + VpfDItemPlanoContas.ValJunho;
    VpaDItemPlanoContaOrcado.ValJulho := VpaDItemPlanoContaOrcado.ValJulho + VpfDItemPlanoContas.ValJulho;
    VpaDItemPlanoContaOrcado.ValAgosto := VpaDItemPlanoContaOrcado.ValAgosto + VpfDItemPlanoContas.ValAgosto;
    VpaDItemPlanoContaOrcado.ValSetembro := VpaDItemPlanoContaOrcado.ValSetembro + VpfDItemPlanoContas.ValSetembro;
    VpaDItemPlanoContaOrcado.ValOutubro := VpaDItemPlanoContaOrcado.ValOutubro + VpfDItemPlanoContas.ValOutubro;
    VpaDItemPlanoContaOrcado.ValNovembro := VpaDItemPlanoContaOrcado.ValNovembro + VpfDItemPlanoContas.ValNovembro;
    VpaDItemPlanoContaOrcado.ValDezembro := VpaDItemPlanoContaOrcado.ValDezembro + VpfDItemPlanoContas.ValDezembro;
    VpaDItemPlanoContaOrcado.ValTotal := VpaDItemPlanoContaOrcado.ValTotal + VpfDItemPlanoContas.ValTotal;
    VpaPosLaco := VpaPosLaco + 1;
  end;

end;

{******************************************************************************}
function TFuncoesContasAReceber.RSeqEmailDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQEMAIL) ULTIMO FROM ECOBRANCACORPO ');
  Result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDECobrancaItem(VpaDCobrancaCorpo : TRBDECobrancaCorpo;VpaDItemCobranca : TRBDECobrancaItem):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from ECOBRANCAITEM '+
                                 ' Where SEQEMAIL = 0 AND SEQITEM=0');
  Cadastro.Insert;
  Cadastro.FieldByName('SEQEMAIL').AsInteger := VpaDCobrancaCorpo.SeqEmail;
  Cadastro.FieldByName('SEQITEM').AsInteger := VpaDCobrancaCorpo.SeqItemEmailDisponivel;
  VpaDCobrancaCorpo.SeqItemEmailDisponivel := VpaDCobrancaCorpo.SeqItemEmailDisponivel + 1;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDItemCobranca.CodFilial;
  Cadastro.FieldByName('LANRECEBER').AsInteger := VpaDItemCobranca.LanReceber;
  Cadastro.FieldByName('NUMPARCELA').AsInteger := VpaDItemCobranca.NumParcela;
  Cadastro.FieldByName('NOMFINANCEIRO').AsString := VpaDItemCobranca.UsuarioEmail;
  Cadastro.FieldByName('DESEMAIL').AsString := VpaDItemCobranca.DesEmail;
  Cadastro.FieldByName('DATENVIO').AsDateTime := VpaDItemCobranca.DatEnvio;
  Cadastro.FieldByName('DESSTATUS').AsString := VpaDItemCobranca.DesEstatus;
  IF VpaDItemCobranca.IndEnviado then
    Cadastro.FieldByName('INDENVIADO').AsString := 'S'
  else
    Cadastro.FieldByName('INDENVIADO').AsString := 'N';
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  if Cadastro.AErronaGravacao then
      exit;
  Cadastro.close;
  if result = '' then
    AtualizaDataEnvioEmail(VpaDItemCobranca);
end;

{******************************************************************************}
function TFuncoesContasAReceber.AtualizaDataEnvioEmail(VpaDECobrancaItem : TRBDECobrancaItem):String;
begin
  result := '';
  if VpaDECobrancaItem.IndEnviado then
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER'+
                                 ' Where I_EMP_FIL = ' +IntToStr(VpaDECobrancaItem.CodFilial)+
                                 ' and I_LAN_REC = ' +IntToStr(VpaDECobrancaItem.LanReceber)+
                                 ' AND I_NRO_PAR = '+IntToStr(VpaDECobrancaItem.NumParcela));
    Cadastro.edit;
    Cadastro.FieldByName('D_ULT_EMA').AsDateTime := now;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      exit;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ReservaCheque(VpaCheques: TList;VpaCodFornecedor: Integer): String;
var
  VpfLaco: Integer;
  VpfDCheque : TRBDCheque;
begin
  for VpfLaco := 0 to VpaCheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Cadastro, 'SELECT * FROM CHEQUE' +
                                    ' WHERE SEQCHEQUE = ' + IntToStr(VpfDCheque.SeqCheque));
    Cadastro.edit;
    Cadastro.FieldByName('CODFORNECEDORRESERVA').AsInteger := VpaCodFornecedor;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      exit;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RetiraFraseDescontoFinanceiro(VpaTexto : String):String;
var
  VpfTexto : TStringList;
  VpfLaco : Integer;
begin
  VpfTexto := TStringList.Create;
  VpfTexto.Text := VpaTexto;
  for VpfLaco := VpfTexto.Count -1 downto 0 do
  begin
    if Uppercase(copy(VpfTexto.Strings[VpfLaco],1,22)) = 'DESCONTO FINANCEIRO DE' then
      VpfTexto.Delete(VpfLaco);
  end;
  result := VpfTExto.text;
  VpfTexto.free;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ExcluiCheque(VpaSeqCheque : Integer);
begin
  ExecutaComandoSql(Aux,'Delete from CHEQUE '+
                        ' Where SEQCHEQUE = ' + IntToStr(VpaSeqCheque));
end;

{******************************************************************************}
function TFuncoesContasAReceber.RSeqChequeDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQCHEQUE) ULTIMO from CHEQUE ');
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDChequeCR(VpaDBaixa : TRBDBaixaCR):string;
var
  VpfLacoCheque, VpfLacoParcelas : Integer;
  VpfDCheque : TRBDCheque;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHEQUECR '+
                                 ' Where SEQCHEQUE = 0 AND CODFILIALRECEBER = 0 AND LANRECEBER = 0 AND NUMPARCELA = 0');
  for VpfLacoCheque := 0 to VpaDBaixa.Cheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaDBaixa.Cheques.Items[VpfLacoCheque]);
    for VpfLacoParcelas := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLacoParcelas]);
      Cadastro.insert;
      Cadastro.FieldByname('SEQCHEQUE').AsInteger := VpfDCheque.SeqCheque;
      Cadastro.FieldByname('CODFILIALRECEBER').AsInteger := VpfDParcela.CodFilial;
      Cadastro.FieldByname('LANRECEBER').AsInteger := VpfDParcela.LanReceber;
      Cadastro.FieldByname('NUMPARCELA').AsInteger := VpfDParcela.NumParcela;
      Cadastro.post;
      result := Cadastro.AMensagemErroGravacao;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarParcelasCheque(VpaParcelas : TList;VpaSeqCheque, VpaCodFilialOriginal, VpaLanReceberOriginal, VpaNumParcelaOriginal : Integer);
var
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  FreeTObjectsList(VpaParcelas);
  AdicionaSQLAbreTabela(CadContas,'Select CODFILIALRECEBER, LANRECEBER, NUMPARCELA '+
                               ' from CHEQUECR '+
                               ' Where SEQCHEQUE = '+IntToStr(VpaSeqCheque)+
                               ' order by CODFILIALRECEBER, LANRECEBER, NUMPARCELA');
  While not CadContas.eof do
  begin
    if not((CadContas.FieldByname('CODFILIALRECEBER').AsInteger = VpaCodFilialOriginal) and
           (CadContas.FieldByname('LANRECEBER').AsInteger = VpaLanReceberOriginal) and
           (CadContas.FieldByname('NUMPARCELA').AsInteger = VpaNumParcelaOriginal)) then
    begin
      VpfDParcela := TRBDParcelaBaixaCR.Cria;
      CarDParcelaBaixa(VpfDParcela,CadContas.FieldByname('CODFILIALRECEBER').AsInteger,CadContas.FieldByname('LANRECEBER').AsInteger,
                       CadContas.FieldByname('NUMPARCELA').AsInteger);
      VpaParcelas.Add(VpfDParcela);
    end;
    CadContas.next;
  end;
  CadContas.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.EstornaCRChequeDevolvido(VpaCheques : TList):string;
var
  VpfLacoCheque, VpfLacoParcelas : Integer;
  VpfDCheque : TRBDCheque;
  VpfValCheque : Double;
  VpfParcelas : TList;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  result := '';
  VpfParcelas := TList.Create;
  for VpfLacoCheque := 0 to VpaCheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLacoCheque]);
    VpfValCheque := VpfDCheque.ValCheque;

    CarParcelasCheque(VpfParcelas,VpfDCheque.SeqCheque,0,0,0);
    for VpfLacoParcelas := VpfParcelas.Count - 1 downto 0 do
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VpfParcelas.Items[VpfLacoParcelas]);
      if VpfDParcela.ValPago > 0 then
      begin
        if VpfValCheque >= VpfDParcela.ValPago then
        begin
          VpfValCheque := VpfValCheque - VpfDParcela.ValPago;
          VpfDParcela.ValPago := 0;
          Result:= GravaAlteracaoDParcelaCR(VpfDParcela);
        end
        else
        begin
          result := GravaParcelaParcial(VpfDParcela,VpfValCheque,VpfDParcela.DatVencimento);
          if result = ''then
          begin
            VpfDParcela.ValPago := VpfDParcela.ValPago - VpfValCheque;
            Result:= GravaAlteracaoDParcelaCR(VpfDParcela);
            VpfValCheque := 0;
          end;
        end;
        if (result <> '') or (VpfValCheque <= 0) then
          break;
      end;
    end;
    if result <> '' then
      break;
    //se valor do cheque for maior que zero tem adicionar esse valor como credito para o clinte pois ele pagou a mais
   end;
  FreeTObjectsList(VpfParcelas);
  VpfParcelas.Free;
end;

{******************************************************************************}
function TFuncoesContasAReceber.EstornaCreditoCliente(VpaCodCliente, VpaCodFilial, VpaLanReceber, VpaNumParcela: Integer): string;
begin
  result := '';
  LocalizaParcela(Tabela,VpaCodFilial,VpaLanReceber,VpaNumParcela);
  if Tabela.FieldByName('I_COD_FRM').AsInteger = varia.FormaPagamentoCreditoCliente then
  begin
    result := FunClientes.AdicionaCredito(VpaCodCliente,Tabela.FieldByName('N_VLR_PAG').AsFloat,'C','Extorno do pagamento da duplicata "'+Tabela.FieldByName('C_NRO_DUP').AsString+'"');
    if result = '' then
      aviso('ADICIONADO "'+FormatFloat('R$ #,###,###,##0.00',Tabela.FieldByName('N_VLR_PAG').AsFloat) +'" DE CRÉDITO PARA CLIENTE!!!'#13'O estorno desse contas a receber gerou um crédito para o cliente.');
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.VerificaCaixa(VpaDNovaCR : TRBDContasCR) : string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
  VpfContaCaixaVerificado : String;
begin
  result := '';
  VpfContaCaixaVerificado := '';
  if ConfigModulos.Caixa then
  begin
    if VpaDNovaCR.ValSinal = 0 then
    begin
      for Vpflaco  := 0 to VpaDNovaCR.Parcelas.Count - 1 do
      begin
        VpfDParcela := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[VpfLaco]);
        if VpfDParcela.IndBaixarConta then
        begin
          if (VpfDParcela.NumContaCaixa = '') then
            result := 'NÃO É POSSIVEL BAIXAR O CONTAS A RECEBER!!!'#13'A forma de pagamento está configurada para baixar automatico, porém não foi definido no usuário a conta caixa padrão';
          if result = '' then
          begin
            if (VpfContaCaixaVerificado <> VpfDParcela.NumContaCaixa) then
            begin
              if not FunCaixa.ContaCaixaAberta(VpfDParcela.NumContaCaixa) then
                result := 'CONTA CAIXA "'+VpfDParcela.NumContaCaixa+'" NÃO ESTÁ ABERTO!!!'#13+'A forma de pagamento está configurada para baixar automatico, porém a conta caixa não foi aberto';
              VpfContaCaixaVerificado := VpfDParcela.NumContaCaixa;
            end;
          end;
        end;
        if result <> '' then
          break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.BaixaParcelaAutomatica(VpaDNovaCR : TRBDContasCR) : String;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
  VpfDBaixa : TRBDBaixaCR;
  VpfIndCarregouDBaixa : Boolean;
  VpfDFormaPagamento : TRBDFormaPagamento;
  VpfDParcelaBaixa : TRBDParcelaBaixaCR;
begin
  result := '';
  VpfIndCarregouDBaixa := false;
  VpfDBaixa := TRBDBaixaCR.Cria;
  VpfDBaixa.ValorPago := 0;
  for Vpflaco  := 0 to VpaDNovaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[VpfLaco]);
    if VpfDParcela.IndBaixarConta then
    begin
      if not VpfIndCarregouDBaixa then
      begin
       VpfDFormaPagamento := TRBDFormaPagamento.cria;
       CarDFormaPagamento(VpfDFormaPagamento,VpaDNovaCR.CodFrmPagto);
       if VpfDParcela.ValSinal > 0 then
         VpfDBaixa.CodFormaPagamento := varia.FormaPagamentoDinheiro
       else
         VpfDBaixa.CodFormaPagamento := VpfDParcela.CodFormaPagamento;
       VpfDBaixa.TipFormaPagamento := VpfDFormaPagamento.FlaTipo;
       VpfDBaixa.NumContaCaixa := VpfDParcela.NumContaCaixa;
       VpfDBaixa.DatPagamento := date;
       VpfDBaixa.IndPagamentoParcial := false;
       VpfDBaixa.IndBaixaRetornoBancario := false;
       VpfDBaixa.IndDesconto := false;
       VpfIndCarregouDBaixa := true;
      end;
      VpfDBaixa.ValorPago := VpfDBaixa.ValorPago + VpfDParcela.Valor;

      VpfDParcelaBaixa := VpfDBaixa.AddParcela;
      VpfDParcelaBaixa.CodFilial := VpaDNovaCR.CodEmpFil;
      VpfDParcelaBaixa.LanReceber := VpaDNovaCR.LanReceber;
      VpfDParcelaBaixa.NumParcela := VpfDParcela.NumParcela;
      VpfDParcelaBaixa.CodCliente := VpaDNovaCR.CodCliente;
      VpfDParcelaBaixa.CodFormaPagamento := VpfDParcela.CodFormaPagamento;
      VpfDParcelaBaixa.NumNotaFiscal := VpaDNovaCR.NroNota;
      VpfDParcelaBaixa.NumDiasAtraso := 0;
      VpfDParcelaBaixa.NumDiasCarencia := 0;
      VpfDParcelaBaixa.QtdParcelas := VpaDNovaCR.Parcelas.Count;
      VpfDParcelaBaixa.NumContaCorrente := VpfDParcela.NumContaCaixa;
      VpfDParcelaBaixa.NumDuplicata := VpfDParcela.NroDuplicata;
      VpfDParcelaBaixa.NomCliente := VpaDNovaCR.NomCliente;
      VpfDParcelaBaixa.DatEmissao := VpaDNovaCR.DatEmissao;
      VpfDParcelaBaixa.DatVencimento := VpfDParcela.DatVencimento;
      VpfDParcelaBaixa.DatPagamento := date;
      VpfDParcelaBaixa.ValParcela := VpfDParcela.Valor;
      VpfDParcelaBaixa.ValPago := VpfDParcela.Valor;
      VpfDParcelaBaixa.IndValorQuitaEssaParcela := true;
      VpfDParcelaBaixa.IndGeraParcial := false;
      VpfDParcelaBaixa.IndContaOculta := VpaDNovaCR.EsconderConta;
      VpfDParcelaBaixa.IndDescontado := false;
      CalculaJuroseDescontoParcela(VpfDParcelaBaixa,date);
      VpaDNovaCR.ValTotal := VpaDNovaCR.ValTotal - VpfDParcelaBaixa.ValDesconto;
    end;
  end;
  if VpfDBaixa.Parcelas.Count > 0 then
    result := BaixaContasAReceber(VpfDBaixa);
  VpfDBaixa.free;
end;

{############################# gera conta e parecela ##########################}

{******************************************************************************}
procedure TFuncoesContasAReceber.VerificaValAcrescimoFormaPagamento(VpaDNovaCR : TRBDContasCR);
var
  VpfDParcela : TRBDMovContasCR;
  VpfValAcrescimoFormaPagamento : Double;
  VpfLaco, VpfFormaPagamentoAtual : Integer;
  VpfNomFormaPagamento : String;
begin
  if VpaDNovaCR.IndCobrarFormaPagamento then
  begin
    VpaDNovaCR.ValTotalAcrescimoFormaPagamento := 0;
    VpfFormaPagamentoAtual := -1;

    for VpfLaco := 0 to VpaDNovaCR.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[Vpflaco]);
      if (VpfDParcela.CodFormaPagamento <> VpfFormaPagamentoAtual) and (VpaDNovaCR.IndCobrarFormaPagamento) then
      begin
        VpfValAcrescimoFormaPagamento := RValAcrescimoFormaPagamento(VpfDParcela.CodFormaPagamento);
         VpfFormaPagamentoAtual := VpfDParcela.CodFormaPagamento;
         VpfNomFormaPagamento := RNomFormaPagamento(VpfDParcela.CodFormaPagamento);
      end;
      VpfDParcela.Valor := VpfDParcela.Valor + VpfValAcrescimoFormaPagamento;
      VpfDParcela.ValorBruto := VpfDParcela.ValorBruto+VpfValAcrescimoFormaPagamento;
      if (VpfValAcrescimoFormaPagamento > 0) and (VpaDNovaCR.IndCobrarFormaPagamento) then
      begin
        if VpfDParcela.DesObservacoes <> '' then
           VpfDParcela.DesObservacoes :=  VpfDParcela.DesObservacoes+#13;
        VpfDParcela.DesObservacoes :=  VpfDParcela.DesObservacoes + 'Acrescimo Financeiro Ref '+VpfNomFormaPagamento;
        VpaDNovaCR.ValTotalAcrescimoFormaPagamento := VpaDNovaCR.ValTotalAcrescimoFormaPagamento + VpfValAcrescimoFormaPagamento;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ZeraPlanoContasOrcadoItem(VpaDItemPlanoContaOrcado: TRBDPlanoContaOrcadoItem);
begin
  VpaDItemPlanoContaOrcado.ValJaneiro := 0;
  VpaDItemPlanoContaOrcado.ValFevereiro := 0;
  VpaDItemPlanoContaOrcado.ValMarco := 0;
  VpaDItemPlanoContaOrcado.ValAbril := 0;
  VpaDItemPlanoContaOrcado.ValMaio := 0;
  VpaDItemPlanoContaOrcado.ValJunho := 0;
  VpaDItemPlanoContaOrcado.ValJulho := 0;
  VpaDItemPlanoContaOrcado.ValAgosto := 0;
  VpaDItemPlanoContaOrcado.ValSetembro := 0;
  VpaDItemPlanoContaOrcado.ValOutubro := 0;
  VpaDItemPlanoContaOrcado.ValNovembro := 0;
  VpaDItemPlanoContaOrcado.ValDezembro := 0;
  VpaDItemPlanoContaOrcado.ValTotal := 0;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDFormaPagamento(VpaDFormaPagamento : TRBDFormaPagamento;VpaCodFormaPagamento : Integer);
begin
  LocalizaFormaPagamento(Aux,VpaCodFormaPagamento);
  CarDFormaPagamentoTabela(Aux,VpaDFormaPagamento);
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDFormaPagamentoTabela(VpaTabela: TSQLQuery; VpaDFormaPagamento: TRBDFormaPagamento);
begin
  VpaDFormaPagamento.CodForma := VpaTabela.FieldByName('I_COD_FRM').AsInteger;
  VpaDFormaPagamento.NomForma := VpaTabela.FieldByName('C_NOM_FRM').AsString;
  VpaDFormaPagamento.FlaTipo := RTipoFormaPagamento(VpaTabela.FieldByName('C_FLA_TIP').AsString);
  VpaDFormaPagamento.IndBaixarConta := (UpperCase(VpaTabela.FieldByName('C_BAI_CON').AsString) = 'S');
end;

{*************************** calcula o vencimento das parcelas ***************}
function TFuncoesContasAReceber.CalculaVencimento(DataAtual : TDateTime; NroDias : integer; DiaFixo : integer; DataFixa : TDateTime; diaUnico : word) : TDateTime;
var
  data : TDateTime;
begin
  Data := DataAtual;

  if  NroDias <> 0 then
    Data := Data + NroDias
  else   // 2º situacao
    if  DataFixa <> 0 then
      Data := DataFixa
    else  // 3º situacao
      if  DiaFixo <> 0 then
      begin
        if DiaFixo < 32 then
        begin
          if DiaFixo > dia(UltimoDiaMes(Data)) then
            DiaFixo := dia(UltimoDiaMes(Data));
          Data := Montadata(DiaFixo, mes(Data), ano(Data));
          if data < date then
            Data := incmes(Data,1);
        end
        else
        begin
          Data := incMes(Data,1);
          while not validaData(DiaUnico, mes(Data), ano(Data)) do
            Dec(DiaUnico);
          Data := Montadata(DiaUnico, mes(Data), ano(Data));
        end;
      end;
    result := data;
end;


{**************************** calcula o valor da parcela ********************* }
function TFuncoesContasAReceber.CalculaValor(PercentualCondicao : double;
                                              DebitoCredito : string; Parcela : double; valorTotal : Double) : double;
var
  desconto : double;
begin
  if percentualCondicao <> 0  then
    ComPercentual := true;
   desconto := parcela * (PercentualCondicao / 100);
     if 'D' = DebitoCredito then
        result := parcela - desconto
     else
        result := parcela + desconto;
end;


{******************************************************************************}
function TFuncoesContasAReceber.CriaContasaReceber(VpaDNovaCR : TRBDContasCR;var VpaResultado : String;VpaGravarRegistro : Boolean ):Boolean;
begin
  VpaResultado := '';
  if (VpaDNovaCR.ValSinal >= VpaDNovaCR.ValTotal) and
    not(VpaDNovaCR.IndDevolucao) then
  begin
    VpaDNovaCR.ValSinal := VpaDNovaCR.ValTotal;
    aviso('VALOR DO SINAL MAIOR QUE O VALOR DA PARCELA!!!'#13'Não será gerado financeiro porque o valor pago como sinal é maior que o valor das parcelas');
    exit;
  end;
  result := true;
  CarDPNovaCR(VpaDNovaCR);
  CriaParcelasCR(VpaDNovaCR);

  if VpaDNovaCR.MostrarParcelas then
  begin
   FMostraparReceberOO := TFMostraparReceberOO.CriarSDI(nil, '',true);
   result := FMostraparReceberOO.Mostraparcelas(VpaDNovaCR);
  end;
  if result then
  begin
    VerificaValAcrescimoFormaPagamento(VpaDNovaCR);
    if VpaGravarRegistro then
    begin
      if result then
        VpaResultado := GravaContasAReceber(VpaDNovaCR);
    end;
  end;
  if not result then
    VpaResultado := 'FINANCEIRO CANCELADO!!!'#13'A operação foi cancelada porque o financeiro foi cancelado.';
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaContasAReceber(VpaDNovaCR : TRBDContasCR):string;
var
  VpfCreditoCliente : TList;
begin
  if (VpaDNovaCR.ValSinal >= VpaDNovaCR.ValTotal) and
    not(VpaDNovaCR.IndDevolucao) then
  begin
    exit;
  end;

  VpfCreditoCliente := TList.create;
  result := ExcluiParcelasSinalPagamentoPagas(VpaDNovaCR);
  if result = '' then
    result := VerificaCaixa(VpaDNovaCR);
  if result = ''  then
  begin
    result := GravaDNovaCR(VpaDNovaCR);
    if result = '' then
    begin
      if VpaDNovaCR.IndGerarComissao then
        result := GeraComissaoCR(VpaDNovaCR);
      if result = '' then
      begin
        VpaDNovaCR.CodFrmPagto := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[0]).CodFormaPagamento;
        result := AtualizaDadosClientes(VpaDNovaCR);
        if result = '' then
          if config.QuandoFaturarAdicionarnaRemessa then
            Result := FunContasAReceber.AdicionaParcelasCRNaRemessa(VpaDNovaCR);
        if result = '' then
        begin
          result := BaixaParcelaAutomatica(VpaDNovaCR);
          if result = '' then
          begin
            if config.ControlarDebitoeCreditoCliente then
            begin
              VpaDNovaCR.ValUtilizadoCredito := 0;
              FunClientes.CarCreditoCliente(VpaDNovaCR.CodCliente,VpfCreditoCliente,true,dcCredito);
              if ClientePossuiCredito(VpfCreditoCliente,dcCredito) then
              begin
                if confirmacao('CLIENTE POSSUI CRÉDITO!!!'#13'Esse cliente possui um crédito de "'+ FormatFloat('R$ #,###,###,##0.00',RValTotalCredito(VpfCreditoCliente,dcCredito))+
                               '".Deseja utilizar o credito para quitar essa conta? ') then
                  result := BaixaParcelacomCreditodoCliente(VpaDNovaCR,VpfCreditoCliente);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  FreeTObjectsList(VpfCreditoCliente);
  VpfCreditoCliente.free;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDPNovaCR(VpaDNovaCR : TRBDContasCR);
begin
  VpaDNovaCR.LanReceber :=  RSeqReceberDisponivel(VpaDNovaCR.CodEmpFil);
   if not Config.NumeroDuplicata Then
      VpaDNovaCR.DPNumDuplicata := VpaDNovaCR.LanReceber
   else
      VpaDNovaCR.DPNumDuplicata := VpaDNovaCR.NroNota;
   //carrega os dados da condicao de pagamento;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDMovContasCR(VpaTabela : TDataSet;VpaDMovContasCR : TRBDMovContasCR );
begin
  VpaDMovContasCR.NumParcela := VpaTabela.FieldByName('I_NRO_PAR').AsInteger;
  VpaDMovContasCR.CodFormaPagamento := VpaTabela.FieldByName('I_COD_FRM').AsInteger;
  VpaDMovContasCR.CodBanco := VpaTabela.FieldByName('I_COD_BAN').AsInteger;
  VpaDMovContasCR.DiasCarencia := VpaTabela.FieldByName('I_DIA_CAR').AsInteger;
  VpaDMovContasCR.Valor := VpaTabela.FieldByName('N_VLR_PAR').AsFloat;
  VpaDMovContasCR.PerJuros := VpaTabela.FieldByName('N_PER_JUR').AsFloat;
  VpaDMovContasCR.PerMora :=  VpaTabela.FieldByName('N_PER_MOR').AsFloat;
  VpaDMovContasCR.PerMulta :=  VpaTabela.FieldByName('N_PER_MUL').AsFloat;
  VpaDMovContasCR.ValDesconto :=  VpaTabela.FieldByName('N_VLR_DES').AsFloat;
  VpaDMovContasCR.ValAcrescimo :=  VpaTabela.FieldByName('N_VLR_ACR').AsFloat;
  VpaDMovContasCR.PerDescontoVencimento :=  VpaTabela.FieldByName('N_DES_VEN').AsFloat;
  VpaDMovContasCR.ValTarifasBancarias :=  VpaTabela.FieldByName('N_TOT_TAR').AsFloat;
  VpaDMovContasCR.DatVencimento :=  VpaTabela.FieldByName('D_DAT_VEN').AsDateTime;
  VpaDMovContasCR.DatProrrogacao :=  VpaTabela.FieldByName('D_DAT_PRO').AsDateTime;
  VpaDMovContasCR.DatPagamento :=  VpaTabela.FieldByName('D_DAT_PAG').AsDateTime;
  VpaDMovContasCR.NroContaBoleto :=  VpaTabela.FieldByName('C_NRO_CON').AsString;
  VpaDMovContasCR.NroDuplicata :=  VpaTabela.FieldByName('C_NRO_DUP').AsString;
  VpaDMovContasCR.NroDocumento :=  VpaTabela.FieldByName('C_NRO_DOC').AsString;
  VpaDMovContasCR.NossoNumero :=  VpaTabela.FieldByName('C_NOS_NUM').AsString;
  VpaDMovContasCR.DesObservacoes :=  VpaTabela.FieldByName('L_OBS_REC').AsString;
  VpaDMovContasCR.NroAgencia := VpaTabela.FieldByName('C_NRO_AGE').AsString;
  VpaDMovContasCR.ValAcrescimoFrm :=  RValAcrescimoFormaPagamento(VpaTabela.FieldByName('I_COD_FRM').AsInteger);
  CalculaJuroseDescontoParcela(VpaDMovContasCR);
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDCondicaoPagamentoGrupoUsuario(VpaCodGrupo: Integer; VpaCondicoesPagamento: TList);
var
  VpfDCondicaoPagamento : TRBDCondicaoPagamentoGrupoUsuario;
begin
  FreeTObjectsList(VpaCondicoesPagamento);
  AdicionaSQLAbreTabela(CadCondicaoPgto,'Select CON.I_COD_PAG, CON.C_NOM_PAG  '+
                                        ' FROM CADCONDICOESPAGTO CON, CONDICAOPAGAMENTOGRUPOUSUARIO GRU '+
                                        ' Where CON.I_COD_PAG = GRU.CODCONDICAOPAGAMENTO '+
                                        ' AND GRU.CODGRUPOUSUARIO = '+IntToStr(VpaCodGrupo));
  while not CadCondicaoPgto.eof do
  begin
    VpfDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario.cria;
    VpaCondicoesPagamento.Add(VpfDCondicaoPagamento);
    VpfDCondicaoPagamento.CodCondicao := CadCondicaoPgto.FieldByName('I_COD_PAG').AsInteger;
    VpfDCondicaoPagamento.NomCondicao := CadCondicaoPgto.FieldByName('C_NOM_PAG').AsString;
    CadCondicaoPgto.next;
  end;
  CadCondicaoPgto.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDContasReceber(VpaCodFilial, VpaLanReceber : String;VpaDContasAReceber : TRBDContasCR;VpaCarregaItens : Boolean);
begin
  FreeTObjectsList(VpaDContasAReceber.Parcelas);
  AdicionaSQLAbreTabela(Tabela,'Select * from CADCONTASARECEBER '+
                               ' Where I_EMP_FIL = '+VpaCodFilial+
                               ' and I_LAN_REC = '+ VpaLanReceber);
  VpaDContasAReceber.LanReceber := StrToInt(VpaLanReceber);
  VpaDContasAReceber.CodEmpFil := StrToInt(VpaCodFilial);
  VpaDContasAReceber.NroNota := Tabela.FieldByName('I_NRO_NOT').AsInteger;
  VpaDContasAReceber.SeqNota := Tabela.FieldByName('I_SEQ_NOT').AsInteger;
  VpaDContasAReceber.LanOrcamento := Tabela.FieldByName('I_LAN_ORC').AsInteger;
  VpaDContasAReceber.CodCondicaoPgto := Tabela.FieldByName('I_COD_PAG').AsInteger;
  VpaDContasAReceber.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
  VpaDContasAReceber.CodUsuario := Tabela.FieldByName('I_COD_USU').AsInteger;
  VpaDContasAReceber.DatMov := Tabela.FieldByName('D_DAT_MOV').AsDateTime;
  VpaDContasAReceber.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
  VpaDContasAReceber.PlanoConta := Tabela.FieldByName('C_CLA_PLA').AsString;

  if VpaCarregaItens then
  begin
    AdicionaSQLAbreTabela(CadContas,'Select * from MOVCONTASARECEBER '+
                                 ' Where I_EMP_FIL = '+VpaCodFilial+
                                 ' and I_LAN_REC = '+ VpaLanReceber +
                                 ' order by I_NRO_PAR ');
    While not CadContas.Eof do
    begin
      CarDMovContasCR(CadContas,VpaDContasAReceber.AddParcela);
      CadContas.Next;
    end;
    CadContas.Close;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDContasReceberParcela(VpaCodFilial, VpaLanReceber, VpaNroParcela : String;VpaDContasAReceber : TRBDContasCR);
begin
  CarDContasReceber(VpaCodFilial,VpaLanReceber,VpaDContasAReceber,false);
  AdicionaSQLAbreTabela(CadContas,'Select * from MOVCONTASARECEBER '+
                               ' Where I_EMP_FIL = '+VpaCodFilial+
                               ' and I_LAN_REC = '+ VpaLanReceber +
                               ' and I_NRO_PAR = ' + VpaNroParcela);
  CarDMovContasCR(CadContas,VpaDContasAReceber.AddParcela);
  VpaDContasAReceber.ValTotal := TRBDMovContasCR(VpaDContasAReceber.Parcelas.Items[0]).Valor;
  CadContas.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDNovaCR(VpaDNovaCR : TRBDContasCR): String;
begin
  result := '';
  AdicionaSQLAbreTabela(CadContas,'Select * from CadContasAReceber'+
                                 ' Where I_EMP_FIL = 0 AND I_LAN_REC = 0');

  CadContas.Insert;
   //atualiza a data de alteracao para poder exportar.Insert;
  CadContas.FieldByname('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  CadContas.FieldByName('I_Emp_Fil').AsInteger := VpaDNovaCR.CodEmpFil;
  CadContas.FieldByName('I_Cod_Pag').AsInteger := VpaDNovaCR.CodCondicaoPgto;
  CadContas.FieldByName('I_Cod_Cli').AsInteger := VpaDNovaCR.CodCliente;
  CadContas.FieldByName('I_Cod_Usu').AsInteger := VpaDNovaCR.CodUsuario;
  if VpaDNovaCR.SeqNota <> 0 then
    CadContas.FieldByName('I_Seq_Not').AsInteger := VpaDNovaCR.SeqNota;

  if VpaDNovaCR.NroNota <> 0 then
    CadContas.FieldByName('I_Nro_Not').AsInteger := VpaDNovaCR.NroNota;

  if VpaDNovaCR.LanOrcamento <> 0 then
    CadContas.FieldByName('I_LAN_ORC').AsInteger := VpaDNovaCR.LanOrcamento
  else
    CadContas.FieldByName('I_LAN_ORC').Clear;

  if VpaDNovaCR.SeqParcialCotacao <> 0 then
    CadContas.FieldByName('I_SEQ_PAR').AsInteger := VpaDNovaCR.SeqParcialCotacao
  else
    CadContas.FieldByName('I_SEQ_PAR').Clear;

  if not Config.NumeroDuplicata Then  // caso a duplicata seja sempre incrementada
    CadContas.FieldByName('I_Ult_Dup').AsInteger :=  VpaDNovaCR.DPNumDuplicata;

  CadContas.FieldByName('N_Vlr_Tot').AsFloat := VpaDNovaCR.ValTotal;
  CadContas.FieldByName('D_Dat_Mov').AsDateTime := VpaDNovaCR.DatMov;
  CadContas.FieldByName('D_dat_Emi').AsDateTime := VpaDNovaCR.DatEmissao;
  CadContas.FieldByName('I_Qtd_Par').AsInteger := VpaDNovaCR.Parcelas.Count;
  CadContas.FieldByName('C_CLA_PLA').AsString := VpaDNovaCR.PlanoConta;
  CadContas.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
  CadContas.FieldByName('C_CON_TEF').AsString := 'N';
  if VpaDNovaCR.EsconderConta then
    CadContas.FieldByName('C_IND_CAD').AsString := 'S'
  else
    CadContas.FieldByName('C_IND_CAD').AsString := 'N';
  if VpaDNovaCR.IndDevolucao then
    CadContas.FieldByName('C_IND_DEV').AsString := 'S'
  else
    CadContas.FieldByName('C_IND_DEV').AsString := 'N';
  if VpaDNovaCR.IndSinalPagamento then
    CadContas.FieldByName('C_IND_SIN').AsString := 'S'
  else
    CadContas.FieldByName('C_IND_SIN').AsString := 'N';
  if VpaDNovaCR.IndPossuiSinalPagamento then
    CadContas.FieldByName('C_POS_SIN').AsString := 'S'
  else
    CadContas.FieldByName('C_POS_SIN').AsString := 'N';
  CadContas.FieldByName('I_LAN_REC').AsInteger := VpaDNovaCR.LanReceber;
  if varia.TipoBancoDados = bdRepresentante then
    CadContas.FieldByName('C_FLA_EXP').AsString := 'N'
  else
    CadContas.FieldByName('C_FLA_EXP').AsString := 'S';

  CadContas.post;
  result := CadContas.AMensagemErroGravacao;
  CadContas.close;
  Sistema.MarcaTabelaParaImportar('CADCONTASARECEBER');
  if result = '' then
    result := GravaDParcelasCR(VpaDNovaCR);
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDParcelaCR(VpaDContasCR : TRBDContasCR;VpaDParcela : TRBDMovContasCR):String;
begin
  AdicionaSQLAbreTabela(CadContas,'Select * from MOVCONTASARECEBER '+
                                  ' Where I_EMP_FIL = '+ IntToStr(VpaDContasCR.CodEmpFil)+
                                  ' and I_LAN_REC = '+ IntToStr(VpaDContasCR.LanReceber)+
                                  ' and I_NRO_PAR = '+ IntToStr(VpaDParcela.NumParcela));
  CadContas.Edit;
  CadContas.FieldByName('I_COD_FRM').AsInteger := VpaDParcela.CodFormaPagamento;
  if VpaDParcela.CodBanco <> 0 then
    CadContas.FieldByName('I_COD_BAN').AsInteger := VpaDParcela.CodBanco
  else
    CadContas.FieldByName('I_COD_BAN').Clear;
  CadContas.FieldByName('I_DIA_CAR').AsInteger := VpaDParcela.DiasCarencia;
  CadContas.FieldByName('I_COD_CLI').AsInteger := VpaDContasCR.CodCliente;
  CadContas.FieldByName('N_VLR_PAR').AsFloat := VpaDParcela.Valor;
  CadContas.FieldByName('N_PER_JUR').AsFloat := VpaDParcela.PerJuros;
  CadContas.FieldByName('N_PER_MOR').AsFloat := VpaDParcela.PerMora;
  CadContas.FieldByName('N_PER_MUL').AsFloat := VpaDParcela.PerMulta;
  CadContas.FieldByName('N_DES_VEN').AsFloat := VpaDParcela.PerDescontoVencimento;
  CadContas.FieldByName('D_DAT_VEN').AsDateTime := VpaDParcela.DatVencimento;
  CadContas.FieldByName('C_NRO_AGE').AsString := VpaDParcela.NroAgencia;

  if VpaDParcela.NroContaBoleto <> '' then
  begin
    CadContas.FieldByName('C_NRO_CON').AsString := VpaDParcela.NroContaBoleto;
    CadContas.FieldByName('C_NOS_NUM').AsString := RNossoNumero(VpaDContasCR.LanReceber,VpaDParcela.NumParcela,VpaDParcela.NroContaBoleto);
  end;
  CadContas.FieldByName('C_NRO_DUP').AsString := VpaDParcela.NroDuplicata;
  if VpaDContasCR.EsconderConta then
    CadContas.FieldByName('C_IND_CAD').AsString := 'S'
  else
    CadContas.FieldByName('C_IND_CAD').AsString := 'N';
  CadContas.FieldByName('C_DUP_IMP').AsString := 'N';
  CadContas.FieldByName('C_FUN_PER').AsString := 'N';
  CadContas.FieldByName('C_NRO_DOC').AsString := VpaDParcela.NroDocumento;
  CadContas.FieldByName('L_OBS_REC').AsString := VpaDParcela.DesObservacoes;
  CadContas.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  CadContas.Post;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');

  result := CadContas.AMensagemErroGravacao;
  CadContas.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaAlteracaoDParcelaCR(VpaDParcelaCR : TRBDParcelaBaixaCR):string;
begin
  result := '';
  if VpaDParcelaCR.ValPago = 0 then
    result := EstornaParcelaParcial(VpaDParcelaCR.CodFilial,VpaDParcelaCR.LanReceber,VpaDParcelaCR.NumParcelaParcial);

  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                 ' Where I_EMP_FIL = ' +IntToStr(VpaDParcelaCR.CodFilial)+
                                 ' AND I_LAN_REC = ' +  IntToStr(VpaDParcelaCR.LanReceber)+
                                 ' AND I_NRO_PAR = ' +IntToStr(VpaDParcelaCR.NumParcela));
  Cadastro.edit;
  Cadastro.FieldByname('I_COD_FRM').AsInteger := VpaDParcelaCR.CodFormaPagamento;
  if VpaDParcelaCR.ValPago <> 0 then
    Cadastro.FieldByname('N_VLR_PAG').AsFloat := VpaDParcelaCR.ValPago
  else
  begin
    Cadastro.FieldByname('N_VLR_PAG').Clear;
    Cadastro.FieldByname('D_DAT_PAG').Clear;
  end;
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
  Cadastro.close;
end;

{***************** resulta no texto das parcelas ***************************** }
function TFuncoesContasAReceber.ParcelasGeradas : TStringList;
begin
  result := TextoParcelas;
end;

{******************************************************************************}
function TFuncoesContasAReceber.PossiuPlanoContasOrcadoFilho(VpaDPlanoContaOrcado: TRBDPlanoContaOrcado;VpaDItemPlanoContaOrcado: TRBDPlanoContaOrcadoItem;VpaPosLaco: Integer): Boolean;
var
  VpfDItem : TRBDPlanoContaOrcadoItem;
begin
  result := false;
  if (VpaPosLaco < (VpaDPlanoContaOrcado.PlanoContas.Count - 1)) then
  begin
      VpfDItem := TRBDPlanoContaOrcadoItem(VpaDPlanoContaOrcado.PlanoContas.Items[VpaPosLaco + 1]);
      if copy(VpfDItem.CodPlanoContas,1,length(VpaDItemPlanoContaOrcado.CodPlanoContas)) = VpaDItemPlanoContaOrcado.CodPlanoContas then
        result := true
      else
        result := false;
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.PreparaPlanoContaOrcado(VpaCodEmpresa: integer; VpaPlanoContaOrcado : TRBDPlanoContaOrcado);
var
  VpfDItemPlanoConta : TRBDPlanoContaOrcadoItem;
begin
  FreeTObjectsList(VpaPlanoContaOrcado.PlanoContas);
  AdicionaSQLAbreTabela(Tabela, 'SELECT * FROM CAD_PLANO_CONTA' +
                             ' WHERE I_COD_EMP = ' + IntToStr(VpaCodEmpresa)+
                             ' AND C_TIP_PLA = ''D'' ' +
                             ' ORDER BY C_CLA_PLA ');

  while not Tabela.Eof do
  begin
    VpfDItemPlanoConta:= VpaPlanoContaOrcado.AddPlanoContaItem;
    VpfDItemPlanoConta.CodPlanoContas:= Tabela.FieldByName('C_CLA_PLA').AsString;
    VpfDItemPlanoConta.NomPlanoContas:= Tabela.FieldByName('C_NOM_PLA').AsString;
    Tabela.Next;
  end;
end;

{**************** resulta o texto dos vencimentos **************************** }
function TFuncoesContasAReceber.VencimentosGeradas : TStringList;
begin
  result := TextoVencimentos;
end;

{ **************** gera o numero mais significativo da proxima duplicata **** }
function TFuncoesContasAReceber.GeraNumeroDuplicata(VpaCodFilial, NroNotaFiscal : Integer) : integer;
begin
  if config.NumeroDuplicata then
    result := nroNotaFiscal
  else
  begin
    AdicionaSQLAbreTabela(calcula,' select max(i_ult_dup) i_ult_dup from CADCONTASARECEBER ' +
      ' where i_emp_fil = ' + IntToStr(VpaCodFilial) );
    Result :=  calcula.fieldbyName('I_ULT_DUP').AsInteger + 1;
    calcula.close;
  end;
end;

{********* gera numero proxima parcela ************************************** }
function TFuncoesContasAReceber.GeraNroProximoParcela(VpaCodFilial, VpaLanReceber : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(calcula, ' select max(I_NRO_PAR) ULTIMO from MOVCONTASARECEBER ' +
                                 ' where I_EMP_FIL = ' + IntTostr(VpaCodFilial) +
                                 ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) );
  result := calcula.fieldByname('ULTIMO').AsInteger + 1;
  Calcula.Close;
end;

{*************** atualiza o valor total do cadcontasaReceber ***************** }
function TFuncoesContasAReceber.AtualizaValorTotal(VpaCodFilial, VpaLanReceber : integer ) : Double;
begin
  result := 0;
  LocalizaContaCR(Cadastro,VpaCodFilial,VpaLanReceber);
  if not Cadastro.eof then
  begin
    Cadastro.edit;
    Cadastro.FieldByName('N_VLR_TOT').AsFloat :=  SomaTotalParcelas(VpaCodFilial,VpaLanReceber);
    //atualiza a data de alteracao para poder exportar
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    result := Cadastro.FieldByName('N_VLR_TOT').AsFloat;
    Cadastro.post;
    Sistema.MarcaTabelaParaImportar('CADCONTASARECEBER');
  end;
  Cadastro.close;
end;

{*********  verifica se as parcelas possui o mesmo Valor do total da conta ** }
function TFuncoesContasAReceber.VerificaAtualizaValoresParcelas( ValorInicialParcelas : double;VpaCodfilial, lancamento : Integer ) : boolean;
var
  Total : double;
begin
  Total := SomaTotalParcelas(VpaCodFilial, lancamento);
  Result := false;
    if total <> ValorInicialPArcelas then
    begin
        if not Confirmacao(CT_ValorDiferente + ' Nota = ' + FormatFloat(varia.MascaraMoeda,ValorInicialParcelas) +
                           ' -> parcelas = ' + FormatFloat(varia.MascaraMoeda,Total) + '. Você deseja corrigir ?' ) then
        begin
             result := true;
             AtualizaValorTotal(VpaCodFilial,lancamento);
        end;
    end
    else
       result := true;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValTotalCredito(VpaCreditos : TList;VpaTipo : TRBDTipoCreditoDebito) : double;
var
  VpfLaco : Integer;
begin
  result := 0;
  for VpfLaco := 0 to VpaCreditos.Count - 1 do
  begin
    if not TRBDCreditoCliente(VpaCreditos.Items[VpfLaco]).IndFinalizado and
       (TRBDCreditoCliente(VpaCreditos.Items[VpfLaco]).TipCredito = VpaTipo) then
      result := result + TRBDCreditoCliente(VpaCreditos.Items[VpfLaco]).ValCredito;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ClientePossuiCredito(VpaCreditos : TList;VpaTipo : TRBDTipoCreditoDebito) : Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  for VpfLaco := 0 to VpaCreditos.count - 1 do
  begin
    if (TRBDCreditoCliente(VpaCreditos.Items[VpfLaco]).ValCredito <> 0) and
       (TRBDCreditoCliente(VpaCreditos.Items[VpfLaco]).TipCredito = VpaTipo) and
       not (TRBDCreditoCliente(VpaCreditos.Items[VpfLaco]).IndFinalizado)  then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ClientesPossuiDuplicataEmAberto(VpaCodCliente: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Aux, 'SELECT * FROM MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD ' +
                             ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL' +
                             ' AND MOV.I_LAN_REC = CAD.I_LAN_REC ' +
                             ' AND MOV.D_DAT_VEN <= '+SQLTextoDataAAAAMMMDD(FunData.DecDia(Now,2))+
                             ' AND MOV.D_DAT_PAG IS NULL ' +
                             ' AND CAD.I_COD_CLI = ' +IntToStr(VpaCodCliente));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.BaixaParcelacomCreditodoCliente(VpaDNovaCR : TRBDContasCR; VpaCredito : TList):string;
var
  VpfDBaixa : TRBDBaixaCR;
  VpfLaco : Integer;
  VpfDParcelaBaixa : TRBDParcelaBaixaCR;
  VpfValCredito : Double;
begin
{ O que falta:
  -No credito quem que informar qual a conta caixa que gerou esse credito, para quando excluir o credito no cadastro de clientes tem que adicionar esse valor no caixa novamente;}

  result := '';
  if varia.FormaPagamentoCreditoCliente = 0  then
    result := 'FORMA DE PAGAMENTO CREDITO CLIENTE NÃO PREENCHIDA!!!'#13'É necessário preencher nas configurações financeiras a forma de pagamento de credito do cliente.';
  if result = ''  then
  begin
    VpfDBaixa := TRBDBaixaCR.Cria;
    VpfDBaixa.CodFormaPagamento := Varia.FormaPagamentoCreditoCliente;
    VpfDBaixa.NumContaCaixa := varia.CaixaPadrao;
    VpfDBaixa.DatPagamento := date;
    VpfValCredito := RValTotalCredito(VpaCredito,dcCredito);
    //carrega as parcelas que serao pagas
    for VpfLaco := 0 to VpaDNovaCR.Parcelas.Count - 1 do
    begin
      VpfDParcelaBaixa := VpfDBaixa.AddParcela;
      CarDParcelaBaixa(VpfDParcelaBaixa,VpaDNovaCR.CodEmpFil,VpaDNovaCR.LanReceber,TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[VpfLaco]).NumParcela);
      VpfValCredito := VpfValCredito - VpfDParcelaBaixa.ValParcela;
      if VpfValCredito <= 0 then
        break;
    end;
    if VpfValCredito >= 0 then
    begin
      VpfDBaixa.ValorPago := VpaDNovaCR.ValTotal;
      VpaDNovaCR.ValSaldoCreditoCliente := VpfValCredito;
    end
    else
    begin
      VpfDBaixa.ValorPago := RValTotalCredito(VpaCredito,dcCredito);
      VpaDNovaCR.ValSaldoCreditoCliente := 0;
    end;
    VpaDNovaCR.ValUtilizadoCredito := VpfDBaixa.ValorPago;
    //baixa o contas a receber;
    result := VerificaSeGeraParcial(VpfDBaixa,VpfDBaixa.ValorPago,false);
    if result = '' then
    begin
      VpfDBaixa.IndBaixaUtilizandoOCreditodoCliente := true;
      result := BaixaContasAReceber(VpfDBaixa);
    end;
    //exclui o valor do credito do cliente;
    if result = '' then
    begin
      result := FunClientes.DiminuiCredito(VpfDParcelaBaixa.CodCliente,VpfDBaixa.ValorPago,dcCredito);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.BaixaContasAReceber(VpaDBaixa : TRBDBaixaCR) : string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
  VpfValTotalParcelas : Double;
begin
  result := GeraParcelaParcial(VpaDBaixa);
  if result = '' then
  begin
    for vpflaco :=0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
      result := BaixaParcelaReceber(VpaDBaixa,VpfDParcela);
      if result = '' then
      begin
      // BAIXA A COMISSÃO SE O MÓDULO COMISSÕES EXISTIR //
        if (ConfigModulos.Comissao) then
          result := FunComissoes.LiberaComissao(VpfDParcela.CodFilial,VpfDParcela.LanReceber,VpfDParcela.NumParcela,VpaDBaixa.DatPagamento);
        if Result = '' then
        begin
          BaixaContasConsolidadas(VpfDParcela.CodFilial,VpfDParcela.LanReceber,VpaDBaixa.DatPagamento);
        end;
      end;
      if result <> '' then
        break;
    end;
   if result = '' then
      result := GravaDCheques(VpaDBaixa.Cheques);
    if result = '' then
      Result := GravaDChequeCR(VpaDBaixa);
    if result = ''  then
    begin
      if config.ControlarDebitoeCreditoCliente then
      begin
        VpfValTotalParcelas := RValTotalParcelasBaixa(VpaDBaixa);
        if VpaDBaixa.ValorPago > VpfValTotalParcelas   then
        begin
          if confirmacao('VALOR PAGO A MAIOR!!!'#13'Está sendo pago um valor de "'+FormatFloat('R$ #,###,###,###,##0.00',VpaDBaixa.ValorPago - RValTotalParcelasBaixa(VpaDBaixa))+
                         '" a mais do que o valor da(s) parcela(s). Deseja gerar esse valor de crédito para o cliente?') then
          begin
            result := FunClientes.AdicionaCredito(VpfDParcela.CodCliente,VpaDBaixa.ValorPago - VpfValTotalParcelas,'C','Referente valor pago a maior das parcelas "'+RNumParcelas(VpaDBaixa)+'"');
            VpaDBaixa.ValParaGerardeCredito := VpaDBaixa.ValorPago - VpfValTotalParcelas;
          end;
        end;
      end;
    end;
    if result = '' then
    begin
      if ConfigModulos.Caixa and
        not VpaDBaixa.IndBaixaUtilizandoOCreditodoCliente then
      begin
        result := FunCaixa.AdicionaBaixaCRCaixa(VpaDBaixa);
      end;
    end;
    if result = '' then
    begin
      Result := DesbloqueiaclientesNabaixaCR(VpaDBaixa);
    end;
  end;
end;

{############################# gera conta e parecela ##########################}

{ * gera parcelas parciais retorna o numero da parcela gerado *****************}
function TFuncoesContasAReceber.GeraParcelaParcial( VpaDBaixa : TRBDBaixaCR ) : String;
var
  VpfDParcelaOriginal : TRBDParcelaBaixaCR;
begin
  result := '';
  if VpaDBaixa.IndPagamentoParcial then
  begin
    VpfDParcelaOriginal := RParcelaAGerarParcial(VpaDBaixa);
    result := GravaParcelaParcial(VpfDParcelaOriginal,VpaDBaixa.ValParcialFaltante,VpaDBaixa.DatVencimentoParcial);
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaParcelaParcial(VpaDParcelaOriginal : TRBDParcelaBaixaCR;VpaValParcial : Double;VpaDatVencimento : TDateTime):string;
begin
  result := '';
  VpaDParcelaOriginal.NumParcelaParcial := GeraNroProximoParcela(VpaDParcelaOriginal.CodFilial,VpaDParcelaOriginal.LanReceber );
  //atualiza o numero da parcial na parcela mae
  LocalizaParcela(Cadastro2,VpaDParcelaOriginal.CodFilial, VpaDParcelaOriginal.LanReceber,VpaDParcelaOriginal.NumParcela);
  Cadastro2.edit;
  Cadastro2.FieldByName('I_PAR_FIL').AsInteger := VpaDParcelaOriginal.NumParcelaParcial;
  Cadastro2.post;

  LocalizaMov(Cadastro);
  Cadastro.insert;
  Cadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDParcelaOriginal.CodFilial;
  Cadastro.FieldByName('I_LAN_REC').AsInteger := VpaDParcelaOriginal.LanReceber;
  Cadastro.FieldByName('I_NRO_PAR').AsInteger := VpaDParcelaOriginal.NumParcelaParcial;
  Cadastro.FieldByName('D_DAT_VEN').AsDateTime := DataSemHora(VpaDatVencimento);
  Cadastro.FieldByName('D_DAT_PRO').AsDateTime := VpaDatVencimento;
  Cadastro.FieldByName('D_PRO_LIG').AsDateTime := IncDia(VpaDatVencimento,2);
  Cadastro.FieldByName('L_OBS_REC').AsString := Cadastro2.FieldByName('L_OBS_REC').AsString + ' - Lançamento originado da parcela ' + IntToStr(VpaDParcelaOriginal.NumParcela);
  Cadastro.FieldByName('N_VLR_PAR').AsFloat := VpaValParcial;
  Cadastro.FieldByName('I_COD_MOE').AsInteger := Cadastro2.FieldByName('I_COD_MOE').AsInteger;
  Cadastro.FieldByName('I_COD_CLI').AsInteger := Cadastro2.FieldByName('I_COD_CLI').AsInteger;
  Cadastro.FieldByName('C_IND_CAD').AsString := Cadastro2.FieldByName('C_IND_CAD').AsString;
  Cadastro.FieldByName('N_PER_MUL').AsFloat := Cadastro2.fieldByName('N_PER_MUL').AsCurrency;
  Cadastro.FieldByName('N_PER_MOR').AsFloat := Cadastro2.fieldByName('N_PER_MOR').AsCurrency;
  Cadastro.FieldByName('N_PER_JUR').AsFloat := Cadastro2.fieldByName('N_PER_JUR').AsCurrency;
  Cadastro.FieldByName('I_PAR_MAE').AsInteger := Cadastro2.fieldByName('I_PAR_MAE').AsInteger;  // para calculos futuros de comissoes
  Cadastro.FieldByName('I_DIA_CAR').AsInteger := Cadastro2.fieldByName('I_DIA_CAR').AsInteger;
  if Cadastro2.FieldByName('C_NRO_CON').AsString <> '' then
    Cadastro.FieldByName('C_NRO_CON').AsString := Cadastro2.FieldByName('C_NRO_CON').AsString;
  if Cadastro2.fieldByName('I_COD_BAN').AsInteger <> 0 then
    Cadastro.FieldByName('I_COD_BAN').AsInteger := Cadastro2.fieldByName('I_COD_BAN').AsInteger;  // para calculos futuros de comissoes
  if Cadastro2.FieldByName('C_NRO_AGE').AsString <> '' then
    Cadastro.FieldByName('C_NRO_AGE').AsString := Cadastro2.FieldByName('C_NRO_AGE').AsString;
  Cadastro.FieldByName('C_NOS_NUM').AsString := RNossoNumero(VpaDParcelaOriginal.LanReceber,VpaDParcelaOriginal.NumParcelaParcial,Cadastro2.FieldByName('C_NRO_CON').AsString);
  Cadastro.FieldByName('C_FLA_PAR').AsString := 'S';
  Cadastro.FieldByName('C_DUP_IMP').AsString := 'N';
  Cadastro.FieldByName('C_FUN_PER').AsString := 'N';
  Cadastro.FieldByName('C_BAI_CAR').AsString := 'N';
  Cadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('I_COD_FRM').Asinteger := Cadastro2.fieldByName('I_COD_FRM').Asinteger;
  //atualiza a data de alteracao para poder exportar
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;

  if Cadastro2.fieldByName('C_NRO_DUP').AsString <> '' then
  begin
    Cadastro.FieldByName('C_NRO_DUP').AsString := Cadastro2.fieldByName('C_NRO_DUP').AsString + '/' + IntTostr(VpaDParcelaOriginal.NumParcelaParcial);
    Cadastro.FieldByName('C_NRO_DOC').AsString := Cadastro2.fieldByName('C_NRO_DOC').AsString + '/' + IntTostr(VpaDParcelaOriginal.NumParcelaParcial);
  end;
  Cadastro.post;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
  result := Cadastro.AMensagemErroGravacao;

  Cadastro.close;
  Cadastro2.close;
end;


{******************************************************************************}
function TFuncoesContasAReceber.GravaPlanoContaOrcado(VpaPlanoContaOrcado: TRBDPlanoContaOrcado): String;
var
  VpfLaco : Integer;
  VpfDPlanoContaItem: TRBDPlanoContaOrcadoItem;
begin
  result := '';
  ExecutaComandoSql(Aux, 'delete from PLANOCONTAORCADO ' +
                         'Where CODEMPRESA = '+IntTostr(VpaPlanoContaOrcado.CodEmpresa)+
                         ' and ANOORCADO = '+IntToStr(VpaPlanoContaOrcado.AnoPlanoContaOrcado)+
                         ' and CODCENTROCUSTO = '+IntToStr(VpaPlanoContaOrcado.CodCentroCusto));
  for VpfLaco := 0 to VpaPlanoContaOrcado.PlanoContas.Count - 1 do
  begin
    VpfDPlanoContaItem:= TRBDPlanoContaOrcadoItem(VpaPlanoContaOrcado.PlanoContas.Items[Vpflaco]);
    AdicionaSQLAbreTabela(Cadastro,'Select * from PLANOCONTAORCADO '+
                        ' Where CODEMPRESA = 0 and ANOORCADO = 0 ');
    Cadastro.Insert;
    Cadastro.FieldByName('CODEMPRESA').AsInteger := VpaPlanoContaOrcado.CodEmpresa;
    Cadastro.FieldByName('CODPLANOCONTA').AsString := VpfDPlanoContaItem.CodPlanoContas;
    Cadastro.FieldByName('CODCENTROCUSTO').AsInteger := VpaPlanoContaOrcado.CodCentroCusto;
    Cadastro.FieldByName('ANOORCADO').AsInteger := VpaPlanoContaOrcado.AnoPlanoContaOrcado;
    Cadastro.FieldByName('VALJANEIRO').AsFloat := VpfDPlanoContaItem.ValJaneiro;
    Cadastro.FieldByName('VALFEVEREIRO').AsFloat := VpfDPlanoContaItem.ValFevereiro;
    Cadastro.FieldByName('VALMARCO').AsFloat := VpfDPlanoContaItem.ValMarco;
    Cadastro.FieldByName('VALABRIL').AsFloat := VpfDPlanoContaItem.ValAbril;
    Cadastro.FieldByName('VALMAIO').AsFloat := VpfDPlanoContaItem.ValMaio;
    Cadastro.FieldByName('VALJUNHO').AsFloat := VpfDPlanoContaItem.ValJunho;
    Cadastro.FieldByName('VALJULHO').AsFloat := VpfDPlanoContaItem.ValJulho;
    Cadastro.FieldByName('VALAGOSTO').AsFloat := VpfDPlanoContaItem.ValAgosto;
    Cadastro.FieldByName('VALSETEMBRO').AsFloat := VpfDPlanoContaItem.ValSetembro;
    Cadastro.FieldByName('VALOUTUBRO').AsFloat := VpfDPlanoContaItem.ValOutubro;
    Cadastro.FieldByName('VALNOVEMBRO').AsFloat := VpfDPlanoContaItem.ValNovembro;
    Cadastro.FieldByName('VALDEZEMBRO').AsFloat := VpfDPlanoContaItem.ValDezembro;
    Cadastro.FieldByName('VALTOTAL').AsFloat := VpfDPlanoContaItem.ValTotal;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
end;

{******** valida a parcela, parcela anterior aberta, ************************* }
function TFuncoesContasAReceber.ValidaParcelaPagamento(VpaCodFilial, VpaLanReceber, VpaNumParcela : integer) : boolean;
begin
  result := true;
  if config.BaixaParcelaAntVazia then
  begin
    AdicionaSQLAbreTabela(Tabela,' select * from MOVCONTASARECEBER '+
                         ' where i_emp_fil = '+ IntToStr(VpaCodFilial) +
                         ' and I_LAN_REC = ' + IntTostr(VpaLanReceber) +
                         ' and I_NRO_PAR < '+ IntToStr(VpaNumParcela)+
                         ' and d_dat_pag is null ' +
                         ' and C_FUN_PER = ''N'''+
                         ' order by D_DAT_VEN ');
    if not tabela.Eof then
    begin
      aviso(CT_ParcelaAntVAzia);
      result := false;
    end;
    tabela.close;
  end;
end;


{********** calcula juros result dias em atraza e valores por referencia **** }
function TFuncoesContasAReceber.CalculaJuros( var VpaMulta, VpaMora, VpaJuro, VpaDesconto : double; VpaDatInicio, VpaDatFim : TdateTime; VpaValTotal : Double ) : Integer;
begin
  Result := DiasPorPeriodoPagamento(VpaDatInicio, VpaDatFim);
  if result <> 0 then
  begin
     if config.JurosMultaDoDia then  // utiliza a multa e mora atual
     begin
        VpaMulta := 0;
        VpaMora := 0;
        VpaJuro := 0;
        VpaMulta := (varia.Multa / 100 ) * VpaValTotal;

        if (varia.Mora <> 0) then
           VpaMora := (((VpaValTotal * varia.Mora) / 100 ) * result)/30
        else
           VpaJuro := (((varia.Juro / 30) / 100 ) * VpaValTotal) * result;
     end
     else
     begin
        VpaMulta := ( VpaMulta / 100 ) * VpaValTotal;

        if VpaMora <> 0 then
        begin
           VpaMora := ((VpaMora / 100 ) * VpaValTotal) * result;
           Vpajuro := 0;
        end
        else
        begin
           VpaJuro := (((VpaJuro / 30) / 100 ) * VpaValTotal) * result;
           VpaMora := 0;
        end;
      end;
  end
  else
  begin
     Vpamulta := 0;
     Vpamora := 0;
     Vpajuro := 0;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.DesbloqueiaclientesNabaixaCR(VpaDBaixa: TRBDBaixaCR): string;
var
  VpfLaco, VpfUltimoCliente : Integer;
  VpfDParcelaCR : TRBDParcelaBaixaCR;
begin
  result := '';
  VpfUltimoCliente := -1;
  if Config.DesbloquearClientesAutomaticamente then
  begin
    for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcelaCR := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[Vpflaco]);
      if VpfDParcelaCR.CodCliente <> VpfUltimoCliente then
      begin
        VpfUltimoCliente := VpfDParcelaCR.CodCliente;
        if FunClientes.VerificaseClienteEstaBloqueado(VpfDParcelaCR.CodCliente) then
        begin
          if not FunContasAReceber.ClientesPossuiDuplicataEmAberto(VpfDParcelaCR.CodCliente) then
             result := FunClientes.DesbloqueiaClienteAtrasado(VpfDParcelaCR.CodCliente);
        end;
      end;
    end;
  end;
end;

function TFuncoesContasAReceber.DescontaDuplicata(VpaDBaixa : TRBDBaixaCR) : string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  result := '';
  VpaDBaixa.IndDesconto := true;
  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                        ' Where I_EMP_FIL = '+ IntToStr(VpfDParcela.CodFilial)+
                        ' and I_LAN_REC = '+IntToStr(VpfDParcela.LanReceber)+
                        ' and I_NRO_PAR = '+IntToStr(VpfDParcela.NumParcela));
    Cadastro.Edit;
    Cadastro.FieldByName('C_DUP_DES').AsString := 'S';
    Cadastro.FieldByName('C_NRO_CON').AsString := VpaDBaixa.NumContaCaixa;
    Cadastro.FieldByName('N_TAR_DES').AsFloat := VpfDParcela.ValDesconto;
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
  Cadastro.close;
  if result = '' then
  begin
    if ConfigModulos.Caixa then
    begin
      result := FunCaixa.AdicionaBaixaCRCaixa(VpaDBaixa);
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.SetaCobrancaExterna(VpaCodFilial, VpaLanReceber, VpaNroParcela : Integer;VpaDesObservacao : String);
begin
  ExecutaComandoSql(Aux,'UPDATE MOVCONTASARECEBER '+
                        ' Set C_COB_EXT = ''S'''+
                        ' , L_OBS_REC = '''+VpaDesObservacao+''''+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_REC = '+IntToStr(VpaLanReceber)+
                        ' and I_NRO_PAR = '+IntToStr(VpaNroParcela));
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.SetaDuplicataImpressa(VpaCodfilial, VpaLanReceber, VpaNumParcela: Integer);
begin
  ExecutaComandoSql(Aux,'UPDATE MOVCONTASARECEBER '+
                        ' Set C_DUP_IMP = ''S''' +
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_REC = '+IntToStr(VpaLanReceber)+
                        ' and I_NRO_PAR = '+IntToStr(VpaNumParcela));
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.SetaFundoPerdido(VpaCodfilial,VpaLanReceber, VpaNroParcela : Integer;VpaDesObservacao : String);
begin
  ExecutaComandoSql(Aux,'UPDATE MOVCONTASARECEBER '+
                        ' Set C_FUN_PER = ''S''' +
                        ' , L_OBS_REC = '''+VpaDesObservacao+''''+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_REC = '+IntToStr(VpaLanReceber)+
                        ' and I_NRO_PAR = '+IntToStr(VpaNroParcela));
end;

{******************************************************************************}
function TFuncoesContasAReceber.SetaMostarnoFluxo(VpaCodFilial, VpaLanReceber,VpaNumParcela: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER ' +
                                 ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                                 ' AND I_LAN_REC = ' +IntToStr(VpaLanReceber)+
                                 ' AND I_NRO_PAR = ' +IntToStr(VpaNumParcela));
  Cadastro.Edit;
  Cadastro.FieldByName('C_MOS_FLU').AsString := 'S';
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
function TFuncoesContasAReceber.SetaOcultarrnoFluxo(VpaCodFilial, VpaLanReceber,VpaNumParcela: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER ' +
                                 ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                                 ' AND I_LAN_REC = ' +IntToStr(VpaLanReceber)+
                                 ' AND I_NRO_PAR = ' +IntToStr(VpaNumParcela));
  Cadastro.Edit;
  Cadastro.FieldByName('C_MOS_FLU').AsString := 'N';
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.SetaBaixaEmCartorio(VpaCodfilial,VpaLanReceber, VpaNroParcela : Integer;VpaDesObservacao : String );
begin
  ExecutaComandoSql(Aux,'UPDATE MOVCONTASARECEBER '+
                        ' Set C_BAI_CAR = ''S''' +
                        ' , L_OBS_REC = '''+VpaDesObservacao+''''+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_REC = '+IntToStr(VpaLanReceber)+
                        ' and I_NRO_PAR = '+IntToStr(VpaNroParcela));
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDParcelaBaixa(VpaDParcela : TRBDParcelaBaixaCR;VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, CAD.C_IND_CAD, '+
                                  ' CAD.I_QTD_PAR, MOV.I_DIA_CAR, MOV.N_VLR_ACR, MOV.N_VLR_DES, '+
                                  ' MOV.I_COD_FRM, MOV.C_NRO_DUP, MOV.C_NRO_CON, MOV.L_OBS_REC ,'+
                                  ' MOV.D_DAT_VEN, MOV.N_VLR_PAR, MOV.N_PER_MOR, MOV.N_PER_JUR, '+
                                  ' MOV.N_PER_MUL, N_DES_VEN, I_PAR_FIL, MOV.C_DUP_DES, MOV.N_TAR_DES, '+
                                  ' MOV.D_DAT_PAG, MOV.N_VLR_PAG, '+
                                  ' CLI.C_NOM_CLI, '+
                                  ' FRM.C_NOM_FRM, FRM.N_PER_DES '+
                                  ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV, CADCLIENTES CLI, '+
                                  ' CADFORMASPAGAMENTO FRM '+
                                  ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' and CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                  ' and CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' and MOV.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' AND MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND MOV.I_LAN_REC = '+IntToStr(VpaLanReceber)+
                                  ' AND MOV.I_NRO_PAR = '+IntToStr(VpaNumParcela));
  VpaDParcela.CodFilial := VpaCodFilial;
  VpaDParcela.LanReceber := VpaLanReceber;
  VpaDParcela.NumParcela := VpaNumParcela;
  VpaDParcela.NumContaCorrente :=  Tabela.FieldByname('C_NRO_CON').AsString;
  VpaDParcela.NumParcelaParcial := Tabela.FieldByname('I_PAR_FIL').AsInteger;
  VpaDParcela.NomCliente := Tabela.FieldByname('C_NOM_CLI').AsString;
  VpaDParcela.NomFormaPagamento := Tabela.FieldByname('C_NOM_FRM').AsString;
  VpaDParcela.DesObservacoes := Tabela.FieldByname('L_OBS_REC').AsString;
  VpaDParcela.CodCliente := Tabela.FieldByname('I_COD_CLI').AsInteger;
  VpaDParcela.CodFormaPagamento := Tabela.FieldByname('I_COD_FRM').AsInteger;
  VpaDParcela.QtdParcelas := Tabela.FieldByname('I_QTD_PAR').AsInteger;
  VpaDParcela.NumNotaFiscal := Tabela.FieldByname('I_NRO_NOT').AsInteger;
  VpaDParcela.NumDuplicata := Tabela.FieldByname('C_NRO_DUP').AsString;
  VpaDParcela.NumContaCorrente := Tabela.FieldByname('C_NRO_CON').AsString;
  VpaDParcela.DatEmissao := Tabela.FieldByname('D_DAT_EMI').AsDateTime;
  VpaDParcela.DatVencimento := Tabela.FieldByname('D_DAT_VEN').AsDateTime;
  VpaDParcela.DatPagamento := Tabela.FieldByname('D_DAT_PAG').AsDateTime;
  VpaDParcela.ValParcela := Tabela.FieldByname('N_VLR_PAR').AsFloat;
  VpaDParcela.ValPago := Tabela.FieldByname('N_VLR_PAG').AsFloat;
  VpaDParcela.ValAcrescimo := Tabela.FieldByname('N_VLR_ACR').AsFloat;
  VpaDParcela.ValTarifaDesconto := Tabela.FieldByname('N_TAR_DES').AsFloat;
  VpaDParcela.ValDesconto := Tabela.FieldByname('N_VLR_DES').AsFloat;
  VpaDParcela.NumDiasCarencia := Tabela.FieldByname('I_DIA_CAR').AsInteger;
  VpaDParcela.ValDescontoAteVencimento := Tabela.FieldByname('N_DES_VEN').AsFloat;
  VpaDParcela.IndContaOculta := (Tabela.FieldByname('C_IND_CAD').AsString = 'S');
  VpaDParcela.IndDescontado := (Tabela.FieldByname('C_DUP_DES').AsString = 'S');
  VpaDParcela.PerDescontoFormaPagamento := Tabela.FieldByName('N_PER_DES').AsFloat;

  if Tabela.FieldByname('D_DAT_VEN').AsDateTime < date then
    VpaDParcela.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByname('D_DAT_VEN').AsDateTime,date)
  else
    VpaDParcela.NumDiasAtraso := 0;

  if config.JurosMultaDoDia then
  begin
    VpaDParcela.PerMora := varia.Mora;
    VpaDParcela.PerJuros := varia.Juro;
    VpaDParcela.PerMulta := varia.Multa;
  end
  else
  begin
    VpaDParcela.PerMora := Tabela.FieldByname('N_PER_MOR').AsFloat;
    VpaDParcela.PerJuros := Tabela.FieldByname('N_PER_JUR').AsFloat;
    VpaDParcela.PerMulta := Tabela.FieldByname('N_PER_MUL').AsFloat;
  end;

  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDPlanoContaOrcado(VpaDPlanoContaOrcado: TRBDPlanoContaOrcado; VpaCodEmpresa, VpaAno, VpaCodCentroCusto : Integer);
var
  VpfLaco : integer;
  VpfDPlanoContaOrcadoItem : TRBDPlanoContaOrcadoItem;
begin
  VpaDPlanoContaOrcado.AnoPlanoContaOrcado:= VpaAno;
  VpaDPlanoContaOrcado.CodEmpresa:= VpaCodEmpresa;
  VpaDPlanoContaOrcado.CodCentroCusto := VpaCodCentroCusto;
  PreparaPlanoContaOrcado(VpaCodEmpresa,VpaDPlanoContaOrcado);
  for VpfLaco := 0 to VpaDPlanoContaOrcado.PlanoContas.Count - 1 do
  begin
    VpfDPlanoContaOrcadoItem:= TRBDPlanoContaOrcadoItem(VpaDPlanoContaOrcado.PlanoContas.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Tabela, ' SELECT * FROM PLANOCONTAORCADO' +
                                  ' WHERE CODEMPRESA = ' + IntToStr(VpaCodEmpresa) +
                                  ' AND CODPLANOCONTA = ' + VpfDPlanoContaOrcadoItem.CodPlanoContas +
                                  ' AND ANOORCADO = ' + IntToStr(VpaAno)+
                                  ' and CODCENTROCUSTO = ' +IntToStr(VpaDPlanoContaOrcado.CodCentroCusto));
    while not Tabela.Eof do
    begin
      VpfDPlanoContaOrcadoItem.ValJaneiro:= Tabela.FieldByName('VALJANEIRO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValFevereiro:= Tabela.FieldByName('VALFEVEREIRO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValMarco:= Tabela.FieldByName('VALMARCO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValAbril:= Tabela.FieldByName('VALABRIL').AsFloat;
      VpfDPlanoContaOrcadoItem.ValMaio:= Tabela.FieldByName('VALMAIO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValJunho:= Tabela.FieldByName('VALJUNHO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValJulho:= Tabela.FieldByName('VALJULHO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValAgosto:= Tabela.FieldByName('VALAGOSTO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValSetembro:= Tabela.FieldByName('VALSETEMBRO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValOutubro:= Tabela.FieldByName('VALOUTUBRO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValNovembro:= Tabela.FieldByName('VALNOVEMBRO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValDezembro:= Tabela.FieldByName('VALDEZEMBRO').AsFloat;
      VpfDPlanoContaOrcadoItem.ValTotal:= Tabela.FieldByName('VALTOTAL').AsFloat;
      Tabela.Next;
    end;

  end;

end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CalculaValorTotalBaixa(VpaDBaixa : TRBDBaixaCR);
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  VpaDBaixa.ValorPago := 0;
  VpaDBaixa.ValorAcrescimo := 0;
  VpaDBaixa.ValorDesconto := 0;
  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
    VpaDBaixa.ValorAcrescimo := VpaDBaixa.ValorAcrescimo + VpfDParcela.ValAcrescimo;
    VpaDBaixa.ValorDesconto := VpaDBaixa.ValorDesconto + VpfDParcela.ValDesconto;
    VpaDBaixa.ValorPago := VpaDBaixa.ValorPago + VpfDParcela.ValParcela;
   end;
   VpaDBaixa.ValorPago := VpaDBaixa.ValorPago + VpaDBaixa.ValorAcrescimo-VpaDBaixa.ValorDesconto;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CalculaJuroseDescontoParcela(VpaDParcela : TRBDParcelaBaixaCR;VpaDatPagamento : TDateTime);
var
  VpfValMora, VpfValJuros : Double;
begin
  VpaDParcela.ValAcrescimo := 0;
  VpaDParcela.ValDesconto := 0;

  if VpaDParcela.DatVencimento < VpaDatPagamento then
    VpaDParcela.NumDiasAtraso := DiasPorPeriodo(VpaDParcela.DatVencimento,VpaDatPagamento)
  else
    VpaDParcela.NumDiasAtraso := 0;

  if VpaDParcela.NumDiasAtraso = 0 then
    VpaDParcela.ValDesconto := VpaDParcela.ValDescontoAteVencimento;
  if VpaDParcela.PerDescontoFormaPagamento <> 0 then
    VpaDParcela.ValDesconto := ArredondaDecimais((VpaDParcela.ValParcela * VpaDParcela.PerDescontoFormaPagamento)/100,2);
  if (VpaDParcela.NumDiasAtraso > 0)and (VpaDParcela.NumDiasAtraso > VpaDParcela.NumDiasCarencia) and
     (VpaDParcela.PerDescontoFormaPagamento = 0) then
  begin
    if Config.BaixaContasReceberCalcularJuros then
    begin
      if VpaDParcela.PerMulta <> 0 then
        VpaDParcela.ValAcrescimo := ((VpaDParcela.ValParcela * VpaDParcela.PerMulta) / 100 );
      if VpaDParcela.PerMora <> 0 then
        VpaDParcela.ValAcrescimo := VpaDParcela.ValAcrescimo +((((VpaDParcela.ValParcela * VpaDParcela.PerMora) / 100 ) * VpaDParcela.NumDiasAtraso)/30)
      else
        if VpaDParcela.PerJuros <> 0 then
          VpaDParcela.ValAcrescimo := VpaDParcela.ValAcrescimo + ((((VpaDParcela.ValParcela * VpaDParcela.PerJuros) / 100 ) * VpaDParcela.NumDiasAtraso)/30)
    end;
  end;

  if VpaDParcela.IndContaOculta and (VpaDParcela.QtdParcelas = 1) and
     (varia.CNPJFilial = CNPJ_FELDMANN) then //se a contas a receber foi gerado da cotação.
    VpaDParcela.ValDesconto := VpaDParcela.ValDesconto + RDescontoCotacaoPgtoaVista(VpaDParcela.CodFilial, VpaDParcela.NumNotaFiscal,VpaDParcela.DatEmissao);
end;

{******************************************************************************}
function TFuncoesContasAReceber.CalculaJuroseDescontoParcela(VpaDParcela : TRBDMovContasCR):double;
Var
  VpfPerMora, VpfPerJuros : Double;
begin
  VpaDParcela.NumDiasAtraso := 0;
  if VpaDParcela.DatPagamento < MontaData(1,1,1900) then
  begin
    VpaDParcela.NumDiasAtraso := DiasPorPeriodo(VpaDParcela.DatVencimento,date);

    VpaDParcela.ValAcrescimo := 0;
    VpaDParcela.ValDesconto := 0;


    if (VpaDParcela.NumDiasAtraso > 0)and (VpaDParcela.NumDiasAtraso > VpaDParcela.DiasCarencia) then
    begin
      if Config.BaixaContasReceberCalcularJuros then
      begin
        if Config.JurosMultaDoDia then
        begin
          VpfPerMora := varia.Mora;
          VpfPerJuros := varia.Juro;
        end
        else
        begin
          VpfPerMora := VpaDParcela.PerMora;
          VpfPerJuros := VpaDParcela.PerJuros;
        end;

        if VpfPerMora <> 0 then
          VpaDParcela.ValAcrescimo := VpaDParcela.ValAcrescimo + ((((VpaDParcela.Valor * VpfPerMora) / 100 ) * VpaDParcela.NumDiasAtraso)/30)
        else
          if VpfPerJuros <> 0 then
            VpaDParcela.ValAcrescimo := VpaDParcela.ValAcrescimo + ((((VpaDParcela.Valor * VpfPerJuros) / 100 ) * VpaDParcela.NumDiasAtraso)/30);
        VpaDParcela.ValAcrescimo := ArredondaDecimais(VpaDParcela.ValAcrescimo,2);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.DistribuiValAcrescimoDescontoNasParcelas(VpaDBaixa : TRBDBaixaCR);
Var
  VpfLaco : Integer;
  VpfValTotal,VpfPerSobreTotal : Double;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  VpfValTotal := 0;
  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
    VpfValTotal := VpfValTotal + VpfDParcela.ValParcela;
  end;

  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
    VpfPerSobreTotal := (VpfDParcela.ValParcela * 100)/VpfValTotal;

    if VpaDBaixa.ValorAcrescimo = 0 then
      VpfDParcela.ValAcrescimo := 0
    else
      VpfDParcela.ValAcrescimo := (VpaDBaixa.ValorAcrescimo * VpfPerSobreTotal)/100;

    if VpaDBaixa.ValorDesconto = 0 then
      VpfDParcela.ValDesconto := 0
    else
      VpfDParcela.ValDesconto := (VpaDBaixa.ValorDesconto * VpfPerSobreTotal)/100;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.DivideValoresParcelasEmAberto(VpaValor: Double;VpaCodFilial, VpaLanReceber: Integer): string;
var
  VpfQtdParcelas : Integer;
  VpfValParcela, VpfValTotalParcelas : Double;
begin
  result := '';
  VpfValTotalParcelas := 0;
  VpfQtdParcelas :=  RQtdParcelasEmAberto(VpaCodFilial,VpaLanReceber);
  VpfValParcela := ArredondaDecimais((VpaValor / VpfQtdParcelas),2);
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER ' +
                                 ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                                 ' and I_LAN_REC = ' +IntToStr(VpaLanReceber)+
                                 ' and D_DAT_PAG IS NULL');
  while not Cadastro.Eof do
  begin
    Cadastro.Edit;
    Cadastro.FieldByName('N_VLR_PAR').AsFloat := VpfValParcela;
    VpfValTotalParcelas := VpfValTotalParcelas + VpfValParcela;
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
    Cadastro.Next;
  end;
  if result = '' then
  begin
    if VpfValTotalParcelas <> VpaValor then
    begin
      Cadastro.Edit;
      if VpfValTotalParcelas > VpaValor then
        Cadastro.FieldByName('N_VLR_PAR').AsFloat := VpfValParcela - (VpfValTotalParcelas - VpaValor)
      else
        Cadastro.FieldByName('N_VLR_PAR').AsFloat := VpfValParcela + (VpaValor - VpfValTotalParcelas );
      Cadastro.Post;
      result := Cadastro.AMensagemErroGravacao;
    end;
  end;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
end;

{******************************************************************************}
function TFuncoesContasAReceber.DuplicaParcelaemAberto(VpaCodFilial,VpaLanReceber: Integer): string;
var
  VpfNumParcela : Integer;
  VpfLaco : Integer;
begin
  result := '';
  VpfNumParcela := RUltimaParcelaemAberto(VpaCodFilial,VpaLanReceber);
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVCONTASARECEBER ' +
                               ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                               ' AND I_LAN_REC =  ' +IntToStr(VpaLanReceber)+
                               ' AND I_NRO_PAR = ' +IntToStr(VpfNumParcela));
  AdicionaSQLAbreTabela(Cadastro,'Select * FROM MOVCONTASARECEBER ' +
                                 ' Where I_EMP_FIL = 0 AND I_LAN_REC = 0 AND I_NRO_PAR = 0');
  Cadastro.insert;
  for VpfLaco := 0 to Tabela.FieldCount -1 do
    Cadastro.FieldByName(Tabela.Fields[VpfLaco].DisplayName).Value := Tabela.FieldByName(Tabela.Fields[VpfLaco].DisplayName).Value;
  Cadastro.FieldByName('I_NRO_PAR').AsInteger := RNumParcelaDisponivel(VpaCodFilial,VpaLanReceber);
  Cadastro.FieldByName('C_NOS_NUM').AsString := RNossoNumero(VpaLanReceber,VpfNumParcela,Cadastro.FieldByName('C_NRO_CON').AsString);
  Cadastro.FieldByName('C_NRO_DUP').AsString := CopiaAteChar(Cadastro.FieldByName('C_NRO_DUP').AsString,'/')+'/'+Cadastro.FieldByName('I_NRO_PAR').AsString;
  Cadastro.FieldByName('C_NRO_DOC').AsString := Cadastro.FieldByName('C_NRO_DUP').AsString;
  Cadastro.FieldByName('N_VLR_DES').clear;
  Cadastro.FieldByName('N_VLR_ACR').clear;
  Cadastro.FieldByName('N_TOT_PAR').clear;
  Cadastro.FieldByName('I_PAR_FIL').Clear;
  Cadastro.FieldByName('I_PAR_MAE').Clear;
  Cadastro.FieldByName('I_COD_USU').AsInteger := varia.CodigoUsuario;
  Cadastro.FieldByName('N_VLR_ACR').clear;
  Cadastro.FieldByName('C_FLA_PAR').AsString := 'N';
  Cadastro.FieldByName('C_IND_REM').AsString := 'N';
  Cadastro.FieldByName('C_DUP_IMP').AsString := 'N';
  Cadastro.FieldByName('C_IND_RET').Clear;
  Cadastro.FieldByName('I_MOT_INA').Clear;
  Cadastro.FieldByName('D_TIT_PRO').Clear;
  Cadastro.FieldByName('D_ENV_CAR').Clear;
  Cadastro.FieldByName('N_VLR_ECA').Clear;
  Cadastro.FieldByName('N_VLR_CAR').Clear;
  Cadastro.FieldByName('N_VLR_EPR').Clear;
  Cadastro.FieldByName('N_VLR_PRT').Clear;
  Cadastro.FieldByName('N_VLR_TMA').Clear;
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
end;

{******************************************************************************}
function TFuncoesContasAReceber.VerificaSeValorPagoQuitaTodasDuplicatas(VpaDBaixa : TRBDBaixaCR;VpaValAReceber : Double) : string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  result := '';
  if VpaDBaixa.Parcelas.Count > 0 then
  begin
    for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
      if VpaValAReceber <= 0 then
      begin
        result := 'O valor pago não é suficiente para quitar todas as duplicatas. '+
                  ' É necessário eliminar da baixa as duplicatas que estão em vermelho.';
        VpfDParcela.IndValorQuitaEssaParcela := false;
      end
      else
        VpfDParcela.IndValorQuitaEssaParcela := true;
      VpaValAReceber := VpaValAReceber - (VpfDParcela.ValParcela - VpfDParcela.ValDesconto+VpfDParcela.ValAcrescimo);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.VerificaSeGeraParcial(VpaDBaixa : TRBDBaixaCR;VpaValAReceber : Double;VpaIndSolicitarData : Boolean) : String;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  result := '';
  VpaDBaixa.IndPagamentoParcial := false;
  VpaDBaixa.ValParcialFaltante := 0;
  if VpaDBaixa.Parcelas.Count > 0 then
  begin
    for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
      VpfDParcela.IndGeraParcial := false;
      VpaValAReceber := VpaValAReceber - (VpfDParcela.ValParcela - VpfDParcela.ValDesconto+VpfDParcela.ValAcrescimo);
      if ArredondaDecimais(VpaValAReceber,2) < 0 then
      begin
        VpaDBaixa.ValParcialFaltante := VpaValAReceber * - 1;
        VpfDParcela.IndGeraParcial := true;
        VpaDBaixa.IndPagamentoParcial := true;
        VpaDBaixa.DatVencimentoParcial := VpfDParcela.DatVencimento;
      end;
    end;
  end;
  if VpaDBaixa.IndPagamentoParcial then
  begin
    if VpaDBaixa.DatVencimentoParcial < date then
      VpaDBaixa.DatVencimentoParcial := date;
    if VpaIndSolicitarData then
      if not EntraData('Pagamento Parcial','Valor Parcial = '+FormatFloat(Varia.MascaraValor,VpaDBaixa.ValParcialFaltante),VpaDBaixa.DatVencimentoParcial) Then
        result :='PARGAMENTO PARCIAL CANCELADO!!!'#13'Não foi gerado o pagamento parcial.';
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValTotalCheques(VpaCheques : TList) : Double;
var
  VpfLaco : Integer;
begin
  result := 0;
  for VpfLaco := 0 to VpaCheques.Count - 1 do
    result := Result + TRBDCheque(VpaCheques.Items[VpfLaco]).ValCheque;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNumerosCheques(VpaCheques :TList) : string;
var
  VpfLaco : Integer;
begin
  result := '';
  for VpfLaco := 0 to VpaCheques.Count - 1 do
    result := result + IntTosTr(TRBDCheque(VpaCheques.Items[VpfLaco]).NumCheque)+',';

  if VpaCheques.Count > 0 then
    result := copy(result,1,length(result)-1);
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNumParcelaDisponivel(VpaCodFilial,VpaLanReceber: integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(I_NRO_PAR) ULTIMO FROM MOVCONTASARECEBER ' +
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_LAN_REC = '+IntToStr(VpaLanReceber));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNumParcelas(VpaDBaixaCR: TRBDBaixaCR): string;
var
  VpfLaco : Integer;
begin
  result := '';
  for VpfLaco := 0 to VpaDBaixaCR.Parcelas.Count - 1 do
    result := result +TRBDParcelaBaixaCR(VpaDBaixaCR.Parcelas.Items[VpfLaco]).NumDuplicata+', ';
  if VpaDBaixaCR.Parcelas.Count > 0 then
    result := copy(result,1,length(result)-2);
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValTotalParcelasBaixa(VpaDBaixaCR : TRBDBaixaCR) : Double;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  result := 0;
  for VpfLaco := 0 to VpaDBaixaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixaCR.Parcelas.Items[VpfLaco]);
    result := result + VpfDParcela.ValParcela + VpfDParcela.ValAcrescimo - VpfDParcela.ValDesconto;
  end;
end;

{######################## exclusão e estorno ################################ }

{***************************** retornar o valor total *********************** }
function TFuncoesContasAReceber.RetornaValorTotalParcelas(VpaCodFilial, Lancamento : Integer): Double;
begin
  AdicionaSQLAbreTabela( Tabela,' select * from CadContasaReceber ' +
    ' where I_LAN_REC = ' + IntToStr(lancamento) +
    ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
  Result := Tabela.FieldByName('N_VLR_TOT').AsFloat;
  Tabela.close;
end;

{*************** exclui uma conta do contas a Receber ********************** }
function TFuncoesContasAReceber.excluiConta(VpaCodFilial, VpaLanReceber : integer; VpaVerificarNotaFiscal, VpaFazerVeriricacoes : Boolean ) : String;
begin
  result := '';
  LocalizaContaCR(CadContas, VpaCodFilial,VpaLanReceber);

  if VpaFazerVeriricacoes then  // caso excluir direto sem verificar nada
  begin
    // vrifica comissoes
    if ConfigModulos.Comissao then
      if FunComissoes.VerificaComissaoPaga(VpaCodFilial,VpaLanReceber) then
         result := 'COMISSÃO PAGA!!!'#13'Não é possível excluir o contas a receber por haver comissão paga referente a esse título.';

    if result = '' then
    begin
    // verefica parcelas pagas
      if TemParcelasPagas(VpaCodFilial,VpaLanReceber) then
        result := CT_ParcelaPaga;

      if result = '' then
      begin
        // verifica nota fiscal
         if (VpaVerificarNotaFiscal) and (CadContas.FieldByName('I_SEQ_NOT').AsInteger <> 0) then
           result := CT_ExclusaoNota;
      end;
    end;
  end;
  CadContas.close;

  // se poder excluir
  if result = '' then
  begin
    if ConfigModulos.Comissao then
      FunComissoes.ExcluiTodaComissaoDireto(VpaCodFilial,VpaLanReceber);
    ExecutaComandoSql(Aux,'DELETE from REMESSAITEM '+
                              ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                              ' and LANRECEBER = '+IntToStr(VpaLanReceber));

    sistema.GravaLogExclusao('MOVCONTASARECEBER','Select * from MOVCONTASARECEBER WHERE ' +
                               ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                               ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
    sistema.GravaLogExclusao('CADCONTASARECEBER','Select * from CADCONTASARECEBER WHERE ' +
                               ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                               ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
    ExecutaComandoSql(Aux, ' DELETE from ECOBRANCAITEM ' +
                               ' WHERE LANRECEBER = ' + IntToStr(VpaLanReceber) +
                               ' and CODFILIAL = ' + IntToStr(VpaCodFilial));
    ExecutaComandoSql(Aux, ' DELETE from COBRANCAITEM WHERE ' +
                               ' LANRECEBER = ' + IntToStr(VpaLanReceber) +
                               ' and CODFILIAL = ' + IntToStr(VpaCodFilial));
    ExecutaComandoSql(Aux, ' DELETE from LOGCONTASARECEBER ' +
                               ' WHERE LANRECEBER = ' + IntToStr(VpaLanReceber) +
                               ' and CODFILIAL = ' + IntToStr(VpaCodFilial));
    ExecutaComandoSql(Aux, ' DELETE MOVCONTASARECEBER WHERE ' +
                               ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                               ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
    ExecutaComandoSql(Aux, ' DELETE CADCONTASARECEBER WHERE ' +
                               ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                               ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
    ExcluiContaConsolidada(VpaCodFilial,VpaLanReceber);
  end;
end;

{*************************** varifica parcelas pagas ************************* }
function TFuncoesContasAReceber.RValorParcelaEmAberto(VpaCodFilial,VpaLanReceber: Integer): double;
begin
  AdicionaSQLAbreTabela(Aux,'Select sum(N_VLR_PAR) TOTAL from MOVCONTASARECEBER ' +
                            ' Where I_EMP_FIL = '+  IntToStr(VpaCodFilial)+
                            ' AND I_LAN_REC = ' +IntToStr(VpaLanReceber)+
                            ' AND D_DAT_PAG IS NULL');
  result := Aux.FieldByName('TOTAL').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteParcelaPaga(VpaCodFilial, VpaLanReceber: Integer): Boolean;
begin
  result := TemParcelasPagas(VpaCodFilial,VpaLanReceber);
  if result then
    aviso(CT_ParcelaPaga);
end;

{****************** verifica se tem parcelas pagas ************************** }
function TFuncoesContasAReceber.TemParcelasPagas(VpaCodFilial, VpaLanReceber: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,' select I_EMP_FIL from MOVCONTASARECEBER ' +
                               ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                               ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                               ' and not D_DAT_PAG is null ');
  Result := (not Tabela.EOF);
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.TipoContaCaixa(VpaNumConta: string): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_TIP_CON FROM CADCONTAS ' +
                            ' WHERE C_NRO_CON = '''+VpaNumConta+'''');
  result := Aux.FieldByName('C_TIP_CON').AsString = 'CA';
  Aux.Close;
end;

{******************* exclui um titulo a pagar ****************************** }
function TFuncoesContasAReceber.ExcluiTitulo(VpaCodFilial,VpaLanReceber, VpaNumParcela : Integer) : String;
begin
  result := '';
  // verifica parcelas pagas
  if TemParcelaPaga(VpaCodFilial,VpaLanReceber, VpaNumParcela) then
     result := CT_ParcelaPaga;

  if result = '' then
  begin
    // vrifica comissoes
    if ConfigModulos.Comissao then
      if FunComissoes.VerificaComissaoPaga(VpaCodFilial,VpaLanReceber,VpaNumParcela) then
         result := 'COMISSÃO PAGA!!!'#13'Não é possível excluir o contas a receber por haver comissão paga referente a esse título.';

    if result = '' then
    begin
{      // verifica nota fiscal
      if  Excluir.FieldByName('I_SEQ_NOT').AsInteger <> 0 then
        result := CT_ExclusaoNota;}

      // verifica e exclui comissao
      if Result = '' then
      begin
        if (ConfigModulos.Comissao) then
          result := Funcomissoes.ExcluiUmaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela);

        if result = '' then
        begin
          ExecutaComandoSql(Aux,'delete from REMESSAITEM '+
                                    ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                    ' and LANRECEBER = '+IntToStr(VpaLanReceber)+
                                    ' and NUMPARCELA = '+IntToStr(VpaNumParcela));
          ExecutaComandoSql(Aux, ' DELETE from ECOBRANCAITEM ' +
                                     ' WHERE LANRECEBER = ' + IntToStr(VpaLanReceber) +
                                     ' and CODFILIAL = ' + IntToStr(VpaCodFilial)+
                                     ' and NUMPARCELA = ' +IntToStr(VpaNumParcela));
          ExecutaComandoSql(Aux, ' DELETE from COBRANCAITEM WHERE ' +
                                     ' LANRECEBER = ' + IntToStr(VpaLanReceber) +
                                     ' and NUMPARCELA = ' +IntToStr(VpaNumParcela)+
                                     ' and CODFILIAL = ' + IntToStr(VpaCodFilial));
          ExecutaComandoSql(Aux, ' DELETE from LOGCONTASARECEBER WHERE ' +
                                     ' LANRECEBER = ' + IntToStr(VpaLanReceber) +
                                     ' and NUMPARCELA = ' +IntToStr(VpaNumParcela)+
                                     ' and CODFILIAL = ' + IntToStr(VpaCodFilial));
          Sistema.GravalogExclusao('MOVCONTASARECEBER','SELECT * FROM MOVCONTASARECEBER WHERE ' +
                                     ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                     ' AND I_NRO_PAR = ' + IntToStr(VpaNumParcela )  +
                                     ' AND I_EMP_FIL = ' + IntToStr(VpaCodFilial));
          ExecutaComandoSql(Aux, ' DELETE MOVCONTASARECEBER WHERE ' +
                                     ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                     ' AND I_NRO_PAR = ' + IntToStr(VpaNumParcela )  +
                                     ' AND I_EMP_FIL = ' + IntToStr(VpaCodFilial));
          if not TemParcelas(VpaCodFilial,VpaLanReceber) then
          begin
            Sistema.GravalogExclusao('CADCONTASARECEBER','SELECT * FROM CADCONTASARECEBER WHERE ' +
                                      ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                       ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
            ExecutaComandoSql(Aux, ' DELETE CADCONTASARECEBER WHERE ' +
                                       ' I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                       ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
            ExcluiContaConsolidada(VpaCodFilial,VpaLanReceber);
          end
          else
            AtualizaValorTotal(VpaCodFilial,VpaLanReceber);
        end;
      end;
    end;
  end;
end;


{****************** verifica se tem parcelas pagas ************************** }
function TFuncoesContasAReceber.TemParcelaPaga(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,' select I_EMP_FIL from MovContasAReceber ' +
                               ' Where I_EMP_FIL = ' + IntToStr(VpaCodfilial)+
                               ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                               ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela) +
                               ' and not D_DAT_PAG is null ');
  Result := (not Tabela.EOF);
  Tabela.close;
end;

{ ************* verifica se o título tem parcelas ************************** }
function TFuncoesContasAReceber.TemParcelas(VpaCodFilial, VpaLanReceber: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,
    ' select I_EMP_FIL from MovContasAReceber ' +
    ' where I_LAN_REC = ' + IntToStr(VpaLanReceber) +
    ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
  Result :=(not Tabela.EOF);
  Tabela.Close;
end;

{*************** estorna a parcela  ****************************************** }
function TFuncoesContasAReceber.EstornaParcela(VpaCodCliente,VpaCodFilial, VpaLanReceber,VpaNumParcela, VpaNumParcelaFilha : integer;VpaVerificarCheques : Boolean) : String;
var
  VpfPossuiCheques : boolean;
begin
  result := '';
  if VpaVerificarCheques then
    result := ValidaChequesCR(VpaCodFilial,VpaLanReceber,VpaNumParcela,VpfPossuiCheques);
  if result = '' then
  begin
    if not VpfPossuiCheques then
      result := FunCaixa.ExtornaParcelaCRCaixa(VpaCodFilial,VpaLanReceber,VpaNumParcela,false);
  end;
  if result = '' then
  begin
    // Verificar se tem mais de uma parcela parcial.
    result := EstornaParcelaParcial(VpaCodFilial,VpaLanReceber,VpaNumParcelaFilha);
    // Verifica se a parcela foi paga com o credito do cliente
    if result = '' then
    begin
      result := EstornaCreditoCliente(VpaCodCliente,VpaCodFilial,VpaLanReceber,VpaNumParcela);
      if result = '' then
      begin
        result := FunComissoes.EstornaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela);
        if result = '' then
        begin
             // estorna conta
          LocalizaParcela(Cadastro2,VpaCodFilial, VpaLanReceber, VpaNumParcela);
             // estorna desconto nos produtos
          if Cadastro2.FieldByName('N_VLR_DES').AsFloat <> 0 then
            ExtornaValorDescontoCotacao(VpaCodFilial,VpaLanReceber,Cadastro2.FieldByName('N_VLR_DES').AsFloat);
          Cadastro2.edit;
          if Cadastro2.FieldByName('D_DAT_PAG').IsNull then
            Cadastro2.FieldByName('C_DUP_DES').Clear
          else
            Cadastro2.FieldByName('D_DAT_PAG').Clear;
          Cadastro2.FieldByName('N_VLR_DES').Clear;
          Cadastro2.FieldByName('N_VLR_ACR').Clear;
          Cadastro2.FieldByName('N_VLR_PAG').Clear;
          Cadastro2.FieldByName('C_FUN_PER').AsString := 'N';
          Cadastro2.FieldByName('C_BAI_CAR').AsString := 'N';
          // Atualiza o valor adicional.
          Cadastro2.FieldByName('I_PAR_FIL').AsInteger := 0; // Não possui mais filhas.
          //atualiza a data de alteracao para poder exportar
          Cadastro2.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
          Cadastro2.post;
          result := Cadastro2.AMensagemErroGravacao;
          Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
          Cadastro2.close;
          GeraLogReceber(VpaCodFilial,VpaLanReceber,VpaNumParcela,'EXTORNO');
        end;
      end;
    end;
  end;
  if result = '' then
  begin
    ExtornaContasConsolidadas(VpaCodFilial,VpaLanReceber);
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.EstornaDesconto(VpaCodFilial, VpaLanReceber,VpaNumParcela: integer) : String;
begin
  result := FunCaixa.ExtornaParcelaCRCaixa(VpaCodFilial,VpaLanReceber,VpaNumParcela,true);
  if result = '' then
  begin
    LocalizaParcela(Cadastro2,VpaCodFilial, VpaLanReceber, VpaNumParcela);
    if Cadastro2.FieldByName('C_DUP_DES').AsString = 'S' then
    begin
      Cadastro2.edit;
      Cadastro2.FieldByName('C_DUP_DES').Clear;
      Cadastro2.FieldByName('N_TAR_DES').Clear;
      Cadastro2.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
      Cadastro2.post;
      result := Cadastro2.AMensagemErroGravacao;
      Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
    end
    else
      result := 'DULICATA NÃO DESCONTADA!!!'#13'Não é possível estornar um desconto de uma duplicata que não foi descontada...';
  end;
  Cadastro2.close;
end;

function TFuncoesContasAReceber.EstornaFundoPerdido(VpaCodFilial, VpaLanReceber, VpaNumParcela: integer): String;
begin
  if result = '' then
  begin
    LocalizaParcela(Cadastro2,VpaCodFilial, VpaLanReceber, VpaNumParcela);
    if Cadastro2.FieldByName('C_FUN_PER').AsString = 'S' then
    begin
      Cadastro2.edit;
      Cadastro2.FieldByName('C_FUN_PER').AsString := 'N';
      Cadastro2.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
      Cadastro2.post;
      result := Cadastro2.AMensagemErroGravacao;
      Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
    end
    else
      result := 'DULICATA NÃO ESTA MARCADA FUNDO PERDIDO!!!'#13'Não é possível estornar um fundo perdido uma duplicata que não foi marcada como fundo perdido...';
  end;
  Cadastro2.close;

end;

{ ********  estorna a parcela parcial ***************************************}
function TFuncoesContasAReceber.EstornaParcelaParcial(VpaCodFilial, VpaLanReceber, VpaNumParcelaFilha : integer) : string;
begin
  result := '';
  if VpaNumParcelaFilha <> 0 then
  begin
    AdicionaSQLAbreTabela(Cadastro,'select * from MOVCONTASARECEBER '+
                                ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                ' and I_NRO_PAR = ' + IntToStr(VpaNumParcelaFilha));
    if not Cadastro.eof then
    begin
      if Cadastro.FieldByName('I_PAR_FIL').AsInteger <> 0 then
        result := CT_EstonoPacialInvalida
      else
        Cadastro.Delete;
    end;
    Cadastro.close;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.EstornaReservaCheque(VpaCheques: TList): String;
var
  VpfLaco: Integer;
  VpfDCheque : TRBDCheque;
begin
  for VpfLaco := 0 to VpaCheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Cadastro, 'SELECT * FROM CHEQUE' +
                                    ' WHERE SEQCHEQUE = ' + IntToStr(VpfDCheque.SeqCheque));
    Cadastro.edit;
    Cadastro.FieldByName('CODFORNECEDORRESERVA').clear;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      exit;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteChequeAssociadoCP(VpaCheques, VpaParcelas : TList;VpaIndDevolucaoCheque : Boolean):string;
var
  VpfLaco : Integer;
  VpfDCheque : TRBDCheque;
  VpfCriadoListaParcelas : boolean;
begin
  result := '';
  VpfCriadoListaParcelas := false;
  if VpaParcelas = nil then
  begin
    VpaParcelas := TList.create;
    VpfCriadoListaParcelas := true;
  end;
  for VpfLaco := 0 to VpaCheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
    FunContasAPagar.CarParcelasCPCheque(VpfDCheque.SeqCheque,VpaParcelas);
  end;
  if VpaParcelas.Count > 0 then
  begin
    FBaixaContasaPagarOO := TFBaixaContasaPagarOO.CriarSDI(nil,'',FPrincipal.VerificaPermisao('FBaixaContasaPagarOO'));
    FBaixaContasaPagarOO.ConsultaParcelasBaixa(VpaParcelas);
    //se for estorno de contas a receber não permite extornar o contas a receber porque os cheques foram passados para
    // um fornecedor
    //se for devolucao de cheque pergunta se quer digitar os cheque que irão substituir ou é para estornar o contas a pagar
    if VpaIndDevolucaoCheque then
    begin
      if Confirmacao('CHEQUE ASSOCIADO AO CONTAS A PAGAR!!!'#13'Os cheques foram associados ao contas a pagar, deseja digitar novos cheques que irão substituir os cheques devolvidos?') then
        result := 'DIGITAR'
      else
        result := 'EXTORNAR';
    end
    else
    begin
      aviso('CHEQUE ASSOCIADO AO CONTAS A PAGAR!!!'#13'Não é possivel extonar o contas a receber pois os cheques foram repassados para os fornecedores do contas a pagar'#13+
          'É necessário antes extornar os contas a pagar.');
      result := 'CHEQUE ASSOCIADO AO CONTAS A PAGAR!!!'#13'Não é possivel extonar o contas a receber pois os cheques foram repassados para os fornecedores do contas a pagar.'+
          ' É necessário antes extornar os contas a pagar.' ;
    end;

    FBaixaContasaPagarOO.free;
  end;
  if VpfCriadoListaParcelas then
  begin
    FreeTObjectsList(VpaParcelas);
    VpaParcelas.free;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ValidaChequesCR(VpaCodFilial,VpaLanReceber,VpaNumparcela : Integer;Var VpaExisteCheques : Boolean):string;
Var
  VpfCheques : TList;
begin
  result := '';
  VpaExisteCheques := false;
  VpfCheques :=  TList.Create;
  CarDChequesCR(VpfCheques,VpaCodFilial,VpaLanReceber,VpaNumparcela);
  if VpfCheques.Count > 0 then
  begin
    VpaExisteCheques := true;
    result := ExisteChequeAssociadoCP(VpfCheques,nil,false);
    if result = '' then
    begin
      FChequesOO := TFChequesOO.CriarSDI(nil,'',FPrincipal.VerificaPermisao('FChequesOO'));
      FChequesOO.ConsultaCheques(VpfCheques);
      if confirmacao('Os cheques que foram recebidos nesta parcela serão excluídos. Tem certeza que deseja continuar?') then
        result := ExcluiChequesCR(VpaCodFilial,VpaLanReceber,VpaNumparcela,VpfCheques)
      else
        result := 'CANCELADO EXCLUSÃO DOS CHEQUES!!!'#13'Não é possível estornar o contas a receber porque a exclusão dos cheques foi cancelada.';
      FChequesOO.free;
    end;
  end;

  FreeTObjectsList(VpfCheques);
  VpfCheques.free;
end;

{******************************************************************************}
function TFuncoesContasAReceber.JaExisteParcela(VpaDContas : TRBDContasConsolidadasCR;VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer):Boolean;
var
  vpfLaco : Integer;
begin
  result := false;
  for VpfLaco := 0 to VpaDContas.ItemsContas.count - 1 do
  begin
    if (VpaDContas.CodFilial = VpaCodFilial) and
      (TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.items[VpfLaco]).LanReceber = VpaLanReceber) and
      (TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.items[VpfLaco]).NroParcela = VpaNumParcela) then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.MarcaTituloComoDescontado(VpaCodFilial,VpaLanReceber, VpaNumParcela: Integer): string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER ' +
                                 ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                 ' AND I_LAN_REC = '+IntToStr(VpaLanReceber)+
                                 ' AND I_NRO_PAR = '+IntToStr(VpaNumParcela));
  Cadastro.Edit;
  cadastro.FieldByName('C_DUP_DES').AsString := 'S';
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ContaJaConsolidada(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from MOVCONTACONSOLIDADACR '+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                            ' and I_LAN_REC = '+ IntToStr(VpaLanReceber) +
                            ' and I_NRO_PAR = '+ IntToStr(VpaNumParcela));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RValTotalContas(VpaDContas : TRBDContasConsolidadasCR):Double;
var
  VpfLaco : Integer;
begin
  result := 0;
  for VpfLaco := 0 to VpaDContas.ItemsContas.Count - 1 do
  begin
    result := result + TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[VpfLaco]).ValParcela;
  end;
  if VpaDContas.PerDesconto <> 0 then
    result := result - ((result * VpaDContas.PerDesconto) / 100)
  else
    if VpaDContas.ValDesconto <> 0 then
      result := result - VpaDContas.ValDesconto;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RMaiorVencimentoContas(VpaDContas : TRBDContasConsolidadasCR):TDateTime;
var
  VpfLaco : Integer;
begin
  if VpaDContas.ItemsContas.Count > 0 then
  begin
    result := TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[0]).DatVencimento;
    for VpfLaco := 1 to VpaDContas.ItemsContas.Count - 1 do
    begin
      if (TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[VpfLaco]).DatVencimento > result) then
      begin
        result := TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[VpfLaco]).DatVencimento;
      end;
    end;
  end
  else
    result := null;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDCondicaoPagamentoGrupoUsuario(VpaCodGrupoUsuario: Integer; VpaCondicoesPagamento: TList): String;
var
  VpfLaco : Integer;
  VpfDCondicaoPagamento : TRBDCondicaoPagamentoGrupoUsuario;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from CONDICAOPAGAMENTOGRUPOUSUARIO '+
                        ' Where CODGRUPOUSUARIO = '+IntToStr(VpaCodGrupoUsuario));
  AdicionaSQLAbreTabela(Cadastro,'Select * from CONDICAOPAGAMENTOGRUPOUSUARIO ');
  for VpfLaco := 0 to VpaCondicoesPagamento.Count - 1 do
  begin
    VpfDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario(VpaCondicoesPagamento.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODCONDICAOPAGAMENTO').AsInteger := VpfDCondicaoPagamento.CodCondicao;
    Cadastro.FieldByName('CODGRUPOUSUARIO').AsInteger := VpaCodGrupoUsuario;
    Cadastro.FieldByName('DATULTIMAALTERACAO').AsDateTime := Sistema.RDataServidor;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if result <> ''  then
      break;
  end;
  Sistema.MarcaTabelaParaImportar('CONDICAOPAGAMENTOGRUPOUSUARIO');
  Cadastro.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDContaConsolidada(VpaDContas : TRBDContasConsolidadasCR):String;
var
  VpfDItemConta : TRBDItemContasConsolidadasCR;
begin
  result := '';

  result := ContasConsolidadasValidas(VpaDContas);
  if result = '' then
  begin
    VpfDItemConta := TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[0]);
    AdicionaSQLAbreTabela(CadContas,'Select * from CADCONTASARECEBER '+
                                    ' Where I_EMP_FIL = 11'+
                                    ' AND I_LAN_REC = 0' );
    CadContas.Insert;
    CadContas.FieldByName('I_EMP_FIL').AsInteger := VpaDContas.CodFilial;
    CadContas.FieldByName('I_COD_CLI').AsInteger := VpaDContas.CodCliente;
    CadContas.FieldByName('D_DAT_MOV').AsDateTime := now;
    CadContas.FieldByName('N_VLR_TOT').AsFloat := VpaDContas.ValConsolidacao;
    CadContas.FieldByName('I_QTD_PAR').AsInteger := 1;
    CadContas.FieldByName('D_DAT_EMI').AsDateTime := now;
    CadContas.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
    CadContas.FieldByName('I_COD_EMP').AsInteger := Varia.CodigoEmpresa;
    CadContas.FieldByName('C_CON_TEF').AsString := 'N';
    CadContas.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    CadContas.FieldByName('I_COD_PAG').AsInteger := VpfDItemConta.CodCondicaoPagamento;
    CadContas.FieldByName('C_CLA_PLA').AsString := VpfDItemConta.CodPlanoContas;
    CadContas.FieldByName('C_IND_CON').AsString := 'S';
    CadContas.FieldByName('C_IND_DEV').AsString := 'N';
    VpaDContas.LanReceber := RSeqReceberDisponivel(VpaDContas.CodFilial);
    CadContas.FieldByName('I_LAN_REC').AsInteger := VpaDContas.LanReceber;
    CadContas.Post;
    Sistema.MarcaTabelaParaImportar('CADCONTASARECEBER');
    result := CadContas.AMensagemErroGravacao;
    if result = '' then
    begin
      result := GravaDMovCRContaConsolidada(VpaDContas);
      if result = '' then
      begin
        result := GravaDContaConsolidadaItem(VpaDContas);
      end;
    end;
  end;
  CadContas.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarNroNotas(VpaDContas : TRBDContasConsolidadasCR);
var
  VpfLaco : Integer;
begin
  VpaDContas.NroNotasFiscais := 'Referente as NF''s: ';
  for VpfLaco := 0 to VpaDContas.ItemsContas.Count - 1 do
  begin
    VpaDContas.NroNotasFiscais := VpaDContas.NroNotasFiscais + IntToStr(TRBDItemContasConsolidadasCR(VpaDContas.ItemsContas.Items[VpfLaco]).NroNota)+', ';
  end;
  VpaDContas.NroNotasFiscais := copy(VpaDContas.NroNotasFiscais,1,Length(VpaDContas.NroNotasFiscais)-2);
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.BaixaContasConsolidadas(VpaCodFilial,VpaLanReceber : Integer;VpaDatBaixa : TDateTime);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVCONTACONSOLIDADACR '+
                               ' Where  I_EMP_FIL = '+IntToStr(VpaCodFilial) +
                               ' and  I_REC_PAI = '+IntToStr(VpaLanReceber));
  While not tabela.eof do
  begin
    Localizaparcela(CadContas,Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_LAN_REC').AsInteger,Tabela.FieldByName('I_NRO_PAR').AsInteger );
    if not Cadastro.Eof then
    begin
      Cadastro.edit;

      Cadastro.FieldByName('D_DAT_PAG').AsDateTime := VpaDatBaixa;
      Cadastro.FieldByName('N_VLR_PAG').AsFloat := Cadastro.FieldByName('N_VLR_PAR').AsFloat;
      Cadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
      Cadastro.FieldByName('I_FIL_PAG').AsInteger := VpaCodFilial;
      Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
      Cadastro.post;
      Sistema.MarcaTabelaParaImportar('MOVCONTACONSOLIDADACR');
      if ConfigModulos.Comissao then
        FunComissoes.LiberaComissao( Tabela.FieldByName('I_LAN_REC').AsInteger,
                                   Tabela.FieldByName('I_LAN_REC').AsInteger,
                                     Tabela.FieldByName('I_NRO_PAR').AsInteger,
                                     VpaDatBaixa);


    end;
    tabela.next;
    Cadastro.close;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ExtornaContasConsolidadas(VpaCodFilial,VpaLanReceber : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVCONTACONSOLIDADACR '+
                               ' Where  I_EMP_FIL = '+IntToStr(VpaCodFilial) +
                               ' and  I_REC_PAI = '+IntToStr(VpaLanReceber));
  While not tabela.eof do
  begin
    Localizaparcela(CadContas,Tabela.FieldByname('I_EMP_FIL').AsInteger, Tabela.FieldByName('I_LAN_REC').AsInteger,Tabela.FieldByName('I_NRO_PAR').AsInteger );
    CadContas.edit;

    CadContas.FieldByName('D_DAT_PAG').Clear;
    CadContas.FieldByName('N_VLR_PAG').Clear;
    CadContas.FieldByName('I_COD_USU').Clear;
    CadContas.FieldByName('I_FIL_PAG').Clear;
    CadContas.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    CadContas.post;
    Sistema.MarcaTabelaParaImportar('MOVCONTACONSOLIDADACR');
    if ConfigModulos.Comissao then
      FunComissoes.EstornaComissao(Tabela.FieldByName('I_EMP_FIL').AsInteger,
                                Tabela.FieldByName('I_LAN_REC').AsInteger,
                                   Tabela.FieldByName('I_NRO_PAR').AsInteger);


    tabela.next;
  end;
  Tabela.close;
  CadContas.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ExcluiContaConsolidada(VpaCodFilial,VpaLanReceber : Integer);
begin
  Sistema.GravaLogExclusao('MOVCONTACONSOLIDADACR','Select * from MOVCONTACONSOLIDADACR '+
                               ' Where  I_EMP_FIL = '+IntToStr(VpaCodFilial) +
                               ' and  I_REC_PAI = '+IntToStr(VpaLanReceber));
  ExecutaComandoSql(Tabela,'Delete from MOVCONTACONSOLIDADACR '+
                               ' Where  I_EMP_FIL = '+IntToStr(VpaCodFilial) +
                               ' and  I_REC_PAI = '+IntToStr(VpaLanReceber));
end;


{******************************************************************************}
function TFuncoesContasAReceber.AdicionaRemessa(VpaCodFilial, VpaLanReceber,VpaNumParcela,VpaCodMovimento : Integer;VpaNomMotivo : String):String;
var
  VpfSeqRemessa : Integer;
begin
  if VpaCodMovimento = 1 then
    result := ParcelaJaAdicionadaRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela);

  if result = '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select MCR.C_NRO_AGE, MCR.C_NRO_CON, MCR.I_COD_BAN, MCR.N_VLR_PAG, '+
                                 ' CLI.C_CEP_CLI '+
                                 ' from MOVCONTASARECEBER MCR, CADCONTASARECEBER CR, CADCLIENTES CLI '+
                                 ' Where MCR.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                 ' and MCR.I_LAN_REC = '+IntToStr(VpaLanReceber)+
                                 ' and MCR.I_NRO_PAR = '+IntToStr(VpaNumParcela)+
                                 ' AND MCR.I_EMP_FIL = CR.I_EMP_FIL '+
                                 ' AND MCR.I_LAN_REC = CR.I_LAN_REC '+
                                 ' AND CR.I_COD_CLI = CLI.I_COD_CLI');
    if Tabela.FieldByName('C_NRO_AGE').AsString = '' then
      result := 'AGENCIA VAZIA!!!'#13'É necessário que a parcela possua a agencia digitada.'
    else
      if Tabela.FieldByName('C_NRO_CON').AsString = '' then
        result := 'CONTA CORRENTE VAZIA!!!'#13'É necessário que a parcela possua a conta corrente digitada.'
      else
        if Tabela.FieldByName('I_COD_BAN').AsInteger = 0 then
          result := 'BANCO VAZIO!!!'#13'É necessário que a parcela possua o banco digitado.'
        else
          if (Tabela.FieldByName('N_VLR_PAG').AsFloat <> 0) and (VpaCodMovimento <> 2) then
            result := 'PARCELA PAGA!!!'#13'Não é possivel enviar ao banco uma parcela que já foi paga.'
          else
            if Tabela.FieldByName('C_CEP_CLI').AsString = '' then
              result := 'CEP CLIENTE VAZIO!!!'#13'No cadastro do cliente não foi preenchido o CEP.';
  end;
  if result = '' then
  begin
    VpfSeqRemessa := RSeqRemessaCorpoAberto(VpaCodFilial,Tabela.FieldByName('C_NRO_CON').AsString);
    if VpfSeqRemessa = 0 then
    begin
      VpfSeqRemessa := InicializaNovaRemessa(VpaCodFilial,Tabela.FieldByName('C_NRO_CON').AsString);
      if VpfSeqRemessa = 0 then
          result := 'ERRO NA INICIALIZAÇÃO DO ARQUIVO DE REMESSA!!!';
    end;
  end;
  if result = '' then
  begin
    result :=  AdicionaRemessaItem(VpaCodFilial,VpfSeqRemessa,VpaLanReceber,VpaNumParcela,VpaCodMovimento,VpaNomMotivo);
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNossoNumero(VpaLanReceber, VpaNumParcela : Integer; VpaContaCorrente :String):String;
var
  VpfCodBanco : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CADCONTAS '+
                            ' Where C_NRO_CON = '''+ VpaContaCorrente+'''');
  VpfCodBanco := Aux.FieldByName('I_COD_BAN').AsInteger;
  if Aux.FieldByName('I_COD_BAN').AsInteger = 1 then//banco do brasil
  begin
    result := AdicionaCharE('0',Aux.FieldByName('C_CON_BAN').AsString,7)+AdicionaCharE('0',IntToStr(VpaLanReceber),8)+AdicionaCharE('0',IntToStr(VpaNumParcela),2);
  end
  else
    if (Aux.FieldByName('I_COD_BAN').AsInteger = 237) then //BRADESCO
    begin
      if Aux.FieldByName('C_EMI_BOL').AsString = 'T' then
      begin
        result := AdicionaCharE('0',IntToStr(VpaLanReceber)+AdicionaCharE('0',IntToStr(VpaNumParcela),2),11);
        result := result + Modulo11(AdicionaCharE('0',Aux.FieldByName('I_NUM_CAR').AsString,2)+ result,7,false,'P');
      end
      else
        result := AdicionaCharE('0','',12);
    end
    else
      if (Aux.FieldByName('I_COD_BAN').AsInteger = 341) then // ITAU
      begin
        if Aux.FieldByName('C_EMI_BOL').AsString = 'T' then
          result := AdicionaCharE('0',IntToStr(VpaLanReceber)+AdicionaCharE('0',IntToStr(VpaNumParcela),2),8)
        else
          result := AdicionaCharE('0','',8);
      end
      else
        if Aux.FieldByName('I_COD_BAN').AsInteger = 399 then//HSBC
        begin
          if Aux.FieldByName('C_EMI_BOL').AsString = 'T' then
          begin
            result := AdicionaCharE('0',Aux.FieldByName('C_NUM_CON').AsString,5) +
                      AdicionaCharE('0',FloattoStr(Aux.FieldByName('N_FAI_INI').AsFloat),5);
            ExecutaComandoSql(Aux,'Update CADCONTAS '+
                                  ' SET N_FAI_INI = '+ FloatToStr(Aux.FieldByName('N_FAI_INI').AsFloat+1) +
                                  ' Where C_NRO_CON = '''+ VpaContaCorrente+'''');
            result := result + Modulo11(result,7,false);
          end
          else
            result := AdicionaCharE('0','',8);
        end
        else
          if (Aux.FieldByName('I_COD_BAN').AsInteger = 356) then //banco real
          begin
            if Aux.FieldByName('C_IND_FAI').AsString = 'T' then
            Begin
              result := AdicionaCharE('0',Aux.FieldByName('I_NUM_CAR').AsString,2)+'00000000000'+FormatFloat('0000000',Aux.FieldByName('N_FAI_INI').AsFloat);
              if Aux.FieldByName('N_FAI_INI').AsFloat + 1 > Aux.FieldByName('N_FAI_FIM').AsFloat then
                aviso('FAIXA DE NOSSO NÚMERO ESGOTADO!!!'#13'A faixa de nosso número para a conta "'+VpaContaCorrente+'" está esgotado, solicite ao banco uma nova faixa de nosso número.');
              ExecutaComandoSql(Aux,'Update CADCONTAS '+
                                    ' SET N_FAI_INI = '+ FloatToStr(Aux.FieldByName('N_FAI_INI').AsFloat+1) +
                                    ' Where C_NRO_CON = '''+ VpaContaCorrente+'''');
            end;
          end
          else
            if (Aux.FieldByName('I_COD_BAN').AsInteger = 409) then//unibanco
            begin
              if Aux.FieldByName('C_IND_FAI').AsString = 'T' then
              Begin
                result := FloattoStr(Aux.FieldByName('N_FAI_INI').AsFloat);
                result := result + Modulo11(result);
                if Aux.FieldByName('N_FAI_INI').AsFloat + 1 > Aux.FieldByName('N_FAI_FIM').AsFloat then
                  aviso('FAIXA DE NOSSO NÚMERO ESGOTADO!!!'#13'A faixa de nosso número para a conta "'+VpaContaCorrente+'" está esgotado, solicite ao banco uma nova faixa de nosso número.');
                ExecutaComandoSql(Aux,'Update CADCONTAS '+
                                      ' SET N_FAI_INI = '+ FloatToStr(Aux.FieldByName('N_FAI_INI').AsFloat+1) +
                                      ' Where C_NRO_CON = '''+ VpaContaCorrente+'''');
              end;
            end
            else
              if (Aux.FieldByName('I_COD_BAN').AsInteger = 104) then//Caixa
              begin
                if Aux.FieldByName('C_EMI_BOL').AsString = 'T' then
                  result :='8'+AdicionaCharE('0',IntToStr(VpaLanReceber)+AdicionaCharE('0',IntToStr(VpaNumParcela),2),9)
                else
                  result := AdicionaCharE(' ','',9)+ AdicionaCharE('0','',10);
              end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNroDocumentoImpressaoCheque(VpaNumConta: string): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_LAY_CHE FROM CADCONTAS ' +
                            ' Where C_NRO_CON =  '''+VpaNumConta+'''');
  Result := Aux.FieldByName('I_LAY_CHE').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ExcluiItemRemessa(VpaCodFilial,VpaSeqRemessa,VpaLanReceber,VpaNumParcela : Integer);
begin
  ExecutaComandoSql(Tabela,'Delete from REMESSAITEM '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQREMESSA = '+IntToStr(VpaSeqRemessa)+
                           ' and LANRECEBER = '+IntToStr(VpaLanReceber)+
                           ' and NUMPARCELA = '+IntToStr(VpaNumParcela));
  ExecutaComandoSql(Tabela,'Update MOVCONTASARECEBER '+
                           ' set C_IND_REM = ''N'''+
                           ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                           ' and I_LAN_REC = '+IntToStr(VpaLanReceber)+
                           ' and I_NRO_PAR = '+IntToStr(VpaNumParcela));
  AdicionaSQLAbreTabela(Tabela,'Select count(CODFILIAL) QTD from REMESSAITEM '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQREMESSA = '+IntToStr(VpaSeqRemessa));
  if Tabela.FieldByName('QTD').AsInteger = 0 then
  begin
    ExecutaComandoSql(Tabela,'Delete from REMESSACORPO '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQREMESSA = '+IntToStr(VpaSeqRemessa));
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ExcluiItemRemessaSeNaoEnviado(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
var
  VpfResultado : string;
begin
  VpfResultado := '';
   AdicionaSQLAbreTabela(Tabela,'Select COR.SEQREMESSA, COR.DATENVIO '+
                                ' FROM REMESSACORPO COR, REMESSAITEM ITE '+
                                ' Where COR.CODFILIAL = ITE.CODFILIAL '+
                                ' AND COR.SEQREMESSA = ITE.SEQREMESSA '+
                                ' AND ITE.CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' AND ITE.LANRECEBER = '+IntToStr(VpaLanReceber)+
                                ' and ITE.NUMPARCELA = '+IntToStr(VpaNumParcela));
   if Tabela.FieldByName('DATENVIO').AsDateTime < MontaData(1,1,1900) then
     ExcluiItemRemessa(VpaCodFilial,Tabela.FieldByName('SEQREMESSA').AsInteger,VpaLanReceber,VpaNumParcela)
   else
     if confirmacao('DUPLICATA JÁ ENVIADA PARA O BANCO!!!'#13'A duplicata já foi enviada para o banco, é necessário cancelar ela junto ao banco. Deseja adicionar a baixa ao arquivo de remessa?') then
       VpfResultado := AdicionaRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela,2,'Pedido de Baixa');
   if VpfResultado <> '' then
     aviso(VpfResultado);
   Tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExcluiParcelasSinalPagamentoPagas(VpaDNovaCR: TRBDContasCR): string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
begin
  result := '';
  for VpfLaco := VpaDNovaCR.Parcelas.Count -1 downto 0 do
  begin
    VpfDParcela := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[Vpflaco]);
    if VpfDParcela.ValSinal > 0 then
    begin
      VpaDNovaCR.ValTotal := VpaDNovaCR.ValTotal - VpfDParcela.Valor;
      VpfDParcela.Free;
      VpaDNovaCR.Parcelas.Delete(VpfLaco);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ContaAdicionadaRemessa(VpaCodFilial, VpaLanReceber : Integer):string;
begin
  result := '';
  AdicionaSqlAbreTabela(Aux,'Select * from REMESSAITEM ITEM, REMESSACORPO CORPO '+
                            ' Where ITEM.CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and ITEM.LANRECEBER = '+IntToStr(VpaLanReceber)+
                            ' and CORPO.CODFILIAL = ITEM.CODFILIAL '+
                            ' and CORPO.SEQREMESSA = ITEM.SEQREMESSA' );
  if not Aux.Eof then
  begin
    result := 'ERRO NA EXCLUSÃO DO CONTAS A RECEBER!!!'#13'Não foi possível excluir a parcela do contas a receber porque já foi adicionado a remessa desse título.';
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDCobranca(VpaDCobranca : TRBDCobrancoCorpo):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from COBRANCACORPO ');
  Cadastro.insert;
  Cadastro.FieldByName('CODHISTORICO').AsInteger := VpaDCobranca.CodHistorico;
  if VpaDCobranca.CodMotivo <> 0 then
    Cadastro.FieldByName('CODMOTIVO').AsInteger := VpaDCobranca.CodMotivo;
  Cadastro.FieldByName('DESFALADOCOM').AsString := VpaDCobranca.DesFaladoCom;
  Cadastro.FieldByName('DESOBSERVACAO').AsString := VpaDCobranca.DesObservacao;
  Cadastro.FieldByName('DATPROXIMALIGACAO').AsDatetime := VpaDCobranca.DatProximaLigacao;
  if VpaDCobranca.DatPromessa > MontaData (1,1,1900) then
    Cadastro.FieldByName('DATPROMESSAPAGAMENTO').AsDatetime := VpaDCobranca.DatPromessa;
  if VpaDCobranca.DesObsProximaLigacao <> '' then
    Cadastro.FieldByName('DESOBSPROXIMALIGACAO').AsString := VpaDCobranca.DesObsProximaLigacao
  else
    Cadastro.FieldByName('DESOBSPROXIMALIGACAO').Clear;
  Cadastro.FieldByName('CODCLIENTE').AsInteger := VpaDCobranca.CodCliente;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDCobranca.CodUsuario;
  Cadastro.FieldByName('DATCOBRANCA').AsDatetime := VpaDCobranca.DatCobranca;
  VpaDCobranca.SeqCobranca := RProximoSeqCobranca;
  Cadastro.FieldByName('SEQCOBRANCA').AsInteger := VpaDCobranca.SeqCobranca;

  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
  if result = '' then
  begin
    Result := GravaDCobrancaItem(VpaDCobranca);
    if result = '' then
      result := AtualizaItemscobranca(VpaDCobranca);
  end;

end;


{******************************************************************************}
function TFuncoesContasAReceber.AtualizaDataCartorio(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                 ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                 ' and I_LAN_REC = ' +IntToStr(VpaLanReceber)+
                                 ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela));
  Cadastro.edit;
  Cadastro.FieldByname('D_ENV_CAR').AsDateTime := now;
  Cadastro.FieldByname('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  Cadastro.post;
  SistemA.MarcaTabelaParaImportar('MOVCONTASARECEBER');
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.atualizaVencimentoComissao( VpaCodFilial, VpaLaReceber, VpaNumParcela : Integer; VpaNovaData : TdateTime );
begin
  FunComissoes.AlteraVencimentos(VpaCodFilial, VpaLaReceber, VpaNumParcela, VpaNovaData);
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarFormasPagamento(VpaFormas : TList);
var
  VpfDForma : TRBDFormaPagamento;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADFORMASPAGAMENTO '+
                               ' ORDER BY C_NOM_FRM' );
  While not Tabela.Eof do
  begin
    VpfDForma := TRBDFormaPagamento.cria;
    VpaFormas.Add(VpfDForma);
    CarDFormaPagamentoTabela(Tabela,VpfDForma);
    Tabela.Next;
  end;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.VerificacoesExclusaoCheque(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaCheques : TList):string;
var
  VpfDCheque : TRBDCheque;
  VpfDParcela : TRBDParcelaBaixaCR;
  VpfParcelas : TList;
  VpfLaco : Integer;
begin
  result := '';
  VpfParcelas := TList.Create;
  if VpaCheques.Count > 0 then
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[0]);
    CarParcelasCheque(VpfParcelas,VpfDCheque.SeqCheque,VpaCodFilial,VpaLanReceber,VpaNumParcela);
    if VpfParcelas.Count > 0 then
    begin
      FBaixaContasaReceberOO := tFBaixaContasaReceberOO.CriarSDI(nil,'',FPrincipal.VerificaPermisao('FBaixaContasaReceberOO'));
      FBaixaContasaReceberOO.ConsultaParcelasBaixa(VpfParcelas);
      if not  confirmacao('Os cheques estão associados a outras parcelas, a exclusão dos cheques irá resultar no estorno dessas parcelas do contas a receber. Deseja continuar? ') then
        result := 'Cancelado estorno das parcelas adicionais do cheque';
      FBaixaContasaReceberOO.free;
      if result = '' then
      begin
        for VpfLaco := 0 to VpfParcelas.Count - 1 do
        begin
          VpfDParcela := TRBDParcelaBaixaCR(VpfParcelas.Items[VpfLaco]);
          result := EstornaParcela(VpfDParcela.CodCliente,VpfDParcela.CodFilial,VpfDParcela.LanReceber,VpfDParcela.NumParcela,VpfDParcela.NumParcelaParcial,false);
          if result <> '' then
            break;
        end;
      end;
    end;
  end;
  FreeTObjectsList(VpfParcelas);
  VpfParcelas.free;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExcluiChequesCR(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaCheques : TList):string;
var
  VpfDCheque : TRBDCheque;
  VpfLaco : Integer;
begin
  result := '';
  if VpaCheques.Count > 0 then
  begin
    result := VerificacoesExclusaoCheque(VpaCodFilial,VpaLanReceber,VpaNumParcela,VpaCheques);
    if result = '' then
    begin
      result := FunCaixa.ExtornaChequeCaixa(VpaCheques,oeContasAReceber);
      if result = '' then
      begin
        for vpfLaco := 0 to VpaCheques.count - 1 do
        begin
          VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);

          ExecutaComandoSql(Aux,'Delete from CHEQUECR '+
                            ' Where SEQCHEQUE = ' +IntToStr(VpfDCheque.SeqCheque));
          ExecutaComandoSql(Aux,'Delete from CHEQUE '+
                            ' Where SEQCHEQUE = ' +IntToStr(VpfDCheque.SeqCheque));
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GravaDCheques(VpaCheques : TList):String;
var
  VpfLaco : Integer;
  VpfDCheque : TRBDCheque;
begin
  for VpfLaco := 0 to VpaCheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
    if VpfDCheque.SeqCheque = 0 then
    begin
      VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
      if (VpfDCheque.TipFormaPagamento <> fpCheque) and
         (VpfDCheque.TipFormaPagamento <> fpCartaoCredito) and
         (VpfDCheque.TipFormaPagamento <> fpCartaoDebito) and
         (VpfDCheque.TipFormaPagamento <> fpChequeTerceiros) and
         (VpfDCheque.TipFormaPagamento <> fpDepositoCheque) then //cheque e cheque de terceiros.
         VpfDCheque.DatCompensacao := date;
      if (VpfDCheque.TipCheque = 'C') AND
         (VpfDCheque.TipContaCaixa = 'CC') and
         (VpfDCheque.TipFormaPagamento <> fpDepositoCheque) then
         VpfDCheque.DatCompensacao := date;
      AdicionaSQLAbreTabela(Cadastro,'Select * from CHEQUE'+
                                    ' Where SEQCHEQUE = ' +IntToStr(VpfDCheque.SeqCheque));
      if Cadastro.eof then
        Cadastro.Insert
      else
        Cadastro.edit;
      if VpfDCheque.CodBanco <> 0 then
        Cadastro.FieldByname('CODBANCO').AsInteger := VpfDCheque.CodBanco;

      Cadastro.FieldByname('CODFORMAPAGAMENTO').AsInteger := VpfDCheque.CodFormaPagamento;
      if VpfDCheque.NomEmitente <> '' then
        Cadastro.FieldByname('NOMEMITENTE').AsString := VpfDCheque.NomEmitente;
      if VpfDCheque.NumCheque <> 0 then
        Cadastro.FieldByname('NUMCHEQUE').AsInteger := VpfDCheque.NumCheque;
      Cadastro.FieldByname('DATCADASTRO').AsDateTime := VpfDCheque.DatCadastro;
      Cadastro.FieldByname('DATVENCIMENTO').AsDateTime := VpfDCheque.DatVencimento;
      if VpfDCheque.DatCompensacao > MontaData(1,1,1900) then
        Cadastro.FieldByname('DATCOMPENSACAO').AsDateTime := VpfDCheque.DatCompensacao
      else
        Cadastro.FieldByname('DATCOMPENSACAO').Clear;
      if VpfDCheque.DatDevolucao > MontaData(1,1,1900) then
        Cadastro.FieldByname('DATDEVOLUCAO').AsDateTime := VpfDCheque.DatDevolucao;
      Cadastro.FieldByname('DATALTERACAO').AsDateTime := now;
      Cadastro.FieldByname('VALCHEQUE').AsFloat := VpfDCheque.ValCheque;
      Cadastro.FieldByname('CODUSUARIO').AsInteger := VpfDCheque.CodUsuario;
      Cadastro.FieldByname('NUMCONTACAIXA').AsString := VpfDCheque.NumContaCaixa;
      Cadastro.FieldByname('NOMNOMINAL').AsString := VpfDCheque.NomNomimal;
      Cadastro.FieldByname('TIPCHEQUE').AsString := VpfDCheque.TipCheque;
      Cadastro.FieldByname('DESORIGEM').AsString := VpfDCheque.IdeOrigem;
      if VpfDCheque.CodCliente <> 0 then
        Cadastro.FieldByname('CODCLIENTE').AsInteger := VpfDCheque.CodCliente
      else
        Cadastro.FieldByname('CODCLIENTE').clear;
      if VpfDCheque.DatEmissao > MontaData(1,1,1900) then
        Cadastro.FieldByname('DATEMISSAO').AsDateTime := VpfDCheque.DatEmissao;

      if VpfDCheque.SeqCheque = 0 then
        VpfDCheque.SeqCheque := RSeqChequeDisponivel;
      Cadastro.FieldByname('SEQCHEQUE').AsInteger := VpfDCheque.SeqCheque;
      Cadastro.FieldByname('NUMCONTA').AsInteger := VpfDCheque.NumConta;
      Cadastro.FieldByname('NUMAGENCIA').AsInteger := VpfDCheque.NumAgencia;
      Cadastro.post;
      result := Cadastro.AMensagemErroGravacao;
      if Cadastro.AErronaGravacao then
        break;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDCheque(VpaDCheque : TRBDCheque;VpaSeqCheque : Integer);
begin
  AdicionaSQLAbreTabela(CadCondicaoPgto,'select CHE.SEQCHEQUE, CHE.CODBANCO, CHE.CODFORMAPAGAMENTO,'+
                                  ' CHE.NOMEMITENTE, CHE.NUMCHEQUE, CHE.DATCADASTRO, CHE.TIPCHEQUE, ' +
                                  ' CHE.DATVENCIMENTO, CHE.DATCOMPENSACAO, CHE.VALCHEQUE, CHE.DATDEVOLUCAO, '+
                                  ' CHE.DATALTERACAO, CHE.CODUSUARIO,CHE.NUMCONTACAIXA, CHE.NOMNOMINAL, CHE.DATEMISSAO, '+
                                  ' CHE.NUMCONTA, CHE.NUMAGENCIA,'+
                                  ' FRM.C_NOM_FRM, FRM.C_FLA_TIP,  '+
                                  ' CON.C_NOM_CRR, CON.C_TIP_CON ' +
                                  ' from CHEQUE CHE, CADFORMASPAGAMENTO FRM, CADCONTAS CON ' +
                                  ' Where CHE.CODFORMAPAGAMENTO = FRM.I_COD_FRM ' +
                                  ' AND CHE.NUMCONTACAIXA = CON.C_NRO_CON ' +
                                  ' AND CHE.SEQCHEQUE = ' + IntToStr(VpaSeqCheque));
  VpaDCheque.SeqCheque := CadCondicaoPgto.FieldByname('SEQCHEQUE').AsInteger;
  VpaDCheque.CodBanco := CadCondicaoPgto.FieldByname('CODBANCO').AsInteger;
  VpaDCheque.CodFormaPagamento := CadCondicaoPgto.FieldByname('CODFORMAPAGAMENTO').AsInteger;
  VpaDCheque.NumCheque := CadCondicaoPgto.FieldByname('NUMCHEQUE').AsInteger;
  VpaDCheque.CodUsuario := CadCondicaoPgto.FieldByname('CODUSUARIO').AsInteger;
  VpaDCheque.NumContaCaixa := CadCondicaoPgto.FieldByname('NUMCONTACAIXA').AsString ;
  VpaDCheque.NomContaCaixa := CadCondicaoPgto.FieldByname('C_NOM_CRR').AsString ;
  VpaDCheque.NomEmitente := CadCondicaoPgto.FieldByname('NOMEMITENTE').AsString ;
  VpaDCheque.NomNomimal := CadCondicaoPgto.FieldByname('NOMNOMINAL').AsString ;
  VpaDCheque.NomFormaPagamento := CadCondicaoPgto.FieldByname('C_NOM_FRM').AsString ;
  VpaDCheque.TipCheque := CadCondicaoPgto.FieldByname('TIPCHEQUE').AsString ;
  VpaDCheque.TipFormaPagamento := FunContasAReceber.RTipoFormapagamento(CadCondicaoPgto.FieldByname('C_FLA_TIP').AsString);
  VpaDCheque.TipContaCaixa := CadCondicaoPgto.FieldByname('C_TIP_CON').AsString ;
  VpaDCheque.ValCheque := CadCondicaoPgto.FieldByname('VALCHEQUE').AsFloat ;
  VpaDCheque.DatCadastro := CadCondicaoPgto.FieldByname('DATCADASTRO').AsDateTime ;
  VpaDCheque.DatVencimento := CadCondicaoPgto.FieldByname('DATVENCIMENTO').AsDateTime ;
  VpaDCheque.DatCompensacao := CadCondicaoPgto.FieldByname('DATCOMPENSACAO').AsDateTime ;
  VpaDCheque.DatDevolucao:= CadCondicaoPgto.FieldByname('DATDEVOLUCAO').AsDateTime ;
  VpaDCheque.DatEmissao := CadCondicaoPgto.FieldByname('DATEMISSAO').AsDateTime ;
  VpaDCheque.NumConta := CadCondicaoPgto.FieldByname('NUMCONTA').AsInteger ;
  VpaDCheque.NumAgencia := CadCondicaoPgto.FieldByname('NUMAGENCIA').AsInteger ;
  CadCondicaoPgto.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDChequesCR(VpaListaCheques : TList;VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
var
  VpfDCheque :  TRBDCheque;
begin
  FreeTObjectsList(VpaListaCheques);
  LocalizaChequesCR(Tabela,VpaCodFilial,VpaLanReceber,VpaNumParcela);
  While not Tabela.Eof do
  begin
    VpfDCheque := TRBDCheque.cria;
    VpaListaCheques.Add(VpfDCheque);
    CarDCheque(VpfDCheque,Tabela.FieldByname('SEQCHEQUE').AsInteger);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarFluxoCR(VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfDFluxoDia : TRBDFluxoCaixaDia;
begin
  VpfDFluxoDia := nil;
  FreeTObjectsList(VpaDFluxo.ContasCaixa);
  LocalizaFluxoCaixa(CadContas,VpaDFluxo);

  while not CadContas.eof do
  begin

    CadContas.next;
  end;
  CadContas.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RDescontoCotacaoPgtoaVista(VpaCodfilial,VpaLanOrcamento :Integer;VpaDatEmissao : TDateTime):Double;
begin
  result := 0;
  if (date <= incDia(VpaDatEmissao,7)) then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADORCAMENTOS '+
                                ' Where I_EMP_FIL = '+ IntTostr(VpaCodFilial)+
                                ' and I_LAN_ORC = '+ IntTostr(VpaLanOrcamento) );
    result := Aux.FieldByName('N_VLR_TOT').AsFloat - Aux.FieldByName('N_VLR_TTD').AsFloat;
    if Aux.FieldByName('N_VLR_DES').AsFloat = result then
      result := 0;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNomFormaPagamento(VpaCodFormaPagamento : Integer):String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADFORMASPAGAMENTO '+
                               ' Where I_COD_FRM = '+ IntToStr(VpaCodFormaPagamento));
  result := tabela.FieldByName('C_NOM_FRM').AsString;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNomPlanoContas(VpaCodEmpresa: Integer;VpaCodPlanoContas: String): string;
begin
  AdicionaSQLAbreTabela(Tabela,'Select C_NOM_PLA from CAD_PLANO_CONTA '+
                               ' Where I_COD_EMP = '+ IntToStr(VpaCodEmpresa)+
                               ' and C_CLA_PLA = '''+VpaCodPlanoContas+'''');
  result := tabela.FieldByName('C_NOM_PLA').AsString;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNomMoeda(VpaCodMoeda : Integer) : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select C_NOM_MOE from CADMOEDAS '+
                               ' Where I_COD_MOE = '+ IntToStr(VpaCodMoeda));
  result := tabela.FieldByName('C_NOM_MOE').AsString;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNomCondicaoPagamento(VpaCodCondicao : Integer) : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select C_NOM_PAG from CADCONDICOESPAGTO '+
                               ' Where I_COD_PAG = '+ IntToStr(VpaCodCondicao));
  result := tabela.FieldByName('C_NOM_PAG').AsString;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RNomBanco(VpaCodBanco : Integer): String;
begin
  AdicionaSqlAbreTabela(Tabela,'Select * from CADBANCOS '+
                               ' Where I_COD_BAN = '+InttoStr(VpaCodBanco));
  result := Tabela.FieldByName('C_NOM_BAN').AsString;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RDiasCompensacaoConta(VpaNumConta : String):Integer;
begin
  result := 0;
  if VpaNumConta <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select I_DIA_COM FROM CADCONTAS '+
                                 ' Where C_NRO_CON = '''+VpaNumConta+'''');
    result := Tabela.FieldByName('I_DIA_COM').AsInteger;
    Tabela.close;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.RDiasVencimentoFormaPagamento(VpaCodFormaPagamento: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_DIA_CHE from CADFORMASPAGAMENTO ' +
                            ' Where I_COD_FRM = '+  IntToStr(VpaCodFormaPagamento));
  result := Aux.FieldByName('I_DIA_CHE').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.AlteraValorDescontoCotacao(VpaCodFilial,VpaLanOrcamento : Integer;VpaValDesconto : Double);
var
  VpfValTotalAtual, VpfValTotalMovimento, VpfPerDescontoMov : Double;
begin
  if VpaValDesconto <> 0 then
  begin
    // atualiza o valor do orcamento
    AdicionaSQLAbreTabela(Cadastro,'Select * from CADORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+ IntToStr(VpaCodfilial)+
                                    ' and I_LAN_ORC = ' + IntToStr(VpaLanOrcamento));
    Cadastro.edit;
    Cadastro.FieldByName('N_VLR_TOT').AsFloat :=  Cadastro.FieldByName('N_VLR_TOT').AsFloat -VpaValDesconto ;
    VpfValTotalAtual := Cadastro.FieldByName('N_VLR_TOT').AsFloat;
    Cadastro.FieldByName('L_OBS_ORC').AsString := Cadastro.FieldByName('L_OBS_ORC').AsString + #13+'Desconto Financeiro de '+FormatFloat('R$ ###,###,###,##0.00##',VpaValDesconto);
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;

    Cadastro.Post;
    Cadastro.Close;
    Sistema.MarcaTabelaParaImportar('CADORCAMENTOS');
    //Atualiza o valor do movimento de estoque dos produtos.
    VpfValTotalMovimento := FunCotacao.RValTotalOrcamentoNoMovEstoque(VpaCodFilial,VpaLanOrcamento);
    if VpfValTotalMovimento <> 0 then
      VpfPerDescontoMov := 100 - (VpfValTotalAtual * 100) / VpfValTotalMovimento
    else
      VpfPerDescontoMov := 0;

    AdicionaSQLAbreTabela(Cadastro,'Select * from MOVESTOQUEPRODUTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
    While not Cadastro.Eof do
    begin
      Cadastro.Edit;
      Cadastro.FieldByName('N_VLR_MOV').AsFloat := Cadastro.FieldByName('N_VLR_MOV').AsFloat - ((Cadastro.FieldByName('N_VLR_MOV').AsFloat * VpfPerDescontoMov)/100);
      Cadastro.Post;
      Cadastro.Next;
    end;
    Cadastro.Close;
  End;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.ExtornaValorDescontoCotacao(VpaCodFilial,VpaLanReceber : Integer;VpaValDesconto : Double);
var
  VpfValTotalAtual, VpfValTotalMovimento, VpfPerDescontoMov : Double;
  VpfLanOrcamento : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select I_LAN_ORC, I_QTD_PAR, C_IND_CAD from CADCONTASARECEBER '+
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' and I_LAN_REC = ' +IntToStr(VpaLanReceber));

  if (VpaValDesconto <> 0) and (Tabela.FieldByName('C_IND_CAD').AsString = 'S') and
     (Tabela.FieldByName('I_QTD_PAR').AsInteger = 1) then
  begin
    VpfLanOrcamento := Tabela.FieldByName('I_LAN_ORC').AsInteger;
    // atualiza o valor do orcamento
    AdicionaSQLAbreTabela(Cadastro,'Select * from CADORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+ IntToStr(VpaCodfilial)+
                                    ' and I_LAN_ORC = ' + IntToStr(VpfLanOrcamento));
    Cadastro.edit;
    Cadastro.FieldByName('N_VLR_TOT').AsFloat :=  Cadastro.FieldByName('N_VLR_LIQ').AsFloat;
    VpfValTotalAtual := Cadastro.FieldByName('N_VLR_TOT').AsFloat;
    Cadastro.FieldByName('L_OBS_ORC').AsString := RetiraFraseDescontoFinanceiro(Cadastro.FieldByName('L_OBS_ORC').AsString);
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    Cadastro.Post;
    Cadastro.Close;
    Sistema.MarcaTabelaParaImportar('CADORCAMENTOS');

    //Atualiza o valor do movimento de estoque dos produtos.
    VpfValTotalMovimento := FunCotacao.RValTotalOrcamentoNoMovEstoque(VpaCodFilial,VpfLanOrcamento);
    if VpfValTotalMovimento <> 0 then
      VpfPerDescontoMov :=((VpfValTotalAtual * 100) / VpfValTotalMovimento)/100
    else
      VpfPerDescontoMov := 0;

    AdicionaSQLAbreTabela(Cadastro,'Select * from MOVESTOQUEPRODUTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+ IntToStr(VpfLanOrcamento));
    While not Cadastro.Eof do
    begin
      Cadastro.Edit;
      Cadastro.FieldByName('N_VLR_MOV').AsFloat := Cadastro.FieldByName('N_VLR_MOV').AsFloat * VpfPerDescontoMov;
      Cadastro.Post;
      Cadastro.Next;
    end;
    Cadastro.Close;
  End;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.CarDRecibo(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer;VpaDRecibo: TDadosRecibo);
Var
  VpfValorExtenso : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.C_NRO_DUP, MOV.N_VLR_PAG,  '+
                               ' CLI.C_NOM_CLI '+
                               ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADCLIENTES CLI'+
                               ' Where MOV.I_EMP_FIL = ' +IntToStr(VpaCodfilial)+
                               ' and MOV.I_LAN_REC = '+ IntToStr(VpaLanReceber)+
                               ' and MOV.I_NRO_PAR = '+IntToStr(VpaNumParcela)+
                               ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                               ' and CAD.I_COD_CLI = CLI.I_COD_CLI ');
  VpaDRecibo.Numero := IntToStr(VpaLanReceber);
  VpaDRecibo.Valor := Tabela.FieldByName('N_VLR_PAG').AsFloat;
  VpaDRecibo.Pessoa := Tabela.FieldByName('C_NOM_CLI').AsString;
  VpfValorExtenso := Extenso(VpaDRecibo.Valor,'reais','real');
  VpaDRecibo.DescValor1 := copy(VpfValorExtenso,1,55);
  VpaDRecibo.DescValor2 := copy(VpfValorExtenso,56,100);
  VpaDRecibo.DescReferente1 := 'duplicata '+ Tabela.FieldByName('C_NRO_DUP').AsString;
  VpaDRecibo.Cidade := varia.CidadeFilial;
  VpaDRecibo.Dia := InttoStr(Dia(Date));
  VpaDRecibo.Mes := TextoMes(date,false);
  VpaDRecibo.Ano := IntTostr(Ano(date));
  VpaDRecibo.Emitente := varia.NomeFilial;
end;

{******************************************************************************}
procedure TFuncoesContasAReceber.AssociaFinanceiroCotacaoNaNota(VpaDNota : TRBDNotaFiscal;VpaDCotacao : TRBDOrcamento);
begin
  ExecutaComandoSql(Aux,'UPDATE CADCONTASARECEBER '+
                        'Set I_SEQ_NOT = '+ IntTostr(VpaDNota.SeqNota)+
                        ' ,I_NRO_NOT = '+IntToStr(VpaDNota.NumNota)+
                        ' , C_IND_CAD = ''N'''+
                        ' , D_ULT_ALT = '+SQLTextoDataAAAAMMMDD(Sistema.RDataServidor)+
                        ' Where I_EMP_FIL = ' +InttoStr(VpaDNota.CodFilial)+
                        ' and I_LAN_ORC = '+ IntToStr(VpaDCotacao.LanOrcamento));
  Sistema.MarcaTabelaParaImportar('CADCONTASARECEBER');
  ExecutaComandoSql(Aux,'UPDATE MOVCONTASARECEBER MOV '+
                        ' SET C_IND_CAD = ''N'''+
                        ' Where EXISTS (Select I_EMP_FIL FROM CADCONTASARECEBER CAD '+
                        ' Where CAD.I_EMP_FIL = ' +InttoStr(VpaDNota.CodFilial)+
                        ' and CAD.I_SEQ_NOT = '+ IntToStr(VpaDNota.SeqNota)+
                        ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                        ' AND CAD.I_LAN_REC = MOV.I_LAN_REC)');
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteFormaPagamento(VpaCodFormaPagamento: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_FRM from CADFORMASPAGAMENTO '+
                            ' Where I_COD_FRM = ' +IntToStr(VpaCodFormaPagamento));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteFormaPagamento(VpaCodFormaPagamento : Integer;VpaDCheque : TRBDCheque):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_FRM, C_NOM_FRM,C_FLA_TIP from CADFORMASPAGAMENTO '+
                            ' Where I_COD_FRM = ' +IntToStr(VpaCodFormaPagamento));
  result := not Aux.Eof;
  if result then
  begin
    VpaDCheque.CodFormaPagamento := VpaCodFormaPagamento;
    VpaDCheque.NomFormaPagamento := Aux.FieldByname('C_NOM_FRM').AsString;
    VpaDCheque.TipFormaPagamento := FunContasAReceber.RTipoFormapagamento(Aux.FieldByname('C_FLA_TIP').AsString);
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteFormaPagamento(VpaCodFormaPagamento : Integer;VpaDCaixaFormaPagamento : TRBDCaixaFormaPagamento):boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_FRM, C_NOM_FRM from CADFORMASPAGAMENTO '+
                            ' Where I_COD_FRM = ' +IntToStr(VpaCodFormaPagamento));
  result := not Aux.Eof;
  if result then
  begin
    VpaDCaixaFormaPagamento.CodFormaPagamento := VpaCodFormaPagamento;
    VpaDCaixaFormaPagamento.NomFormaPagamento := Aux.FieldByname('C_NOM_FRM').AsString;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExisteContaCorrente(VpaNumConta : String):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NRO_CON from CADCONTAS '+
                            ' Where C_NRO_CON = '''+VpaNumConta+'''');
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.CompensaCheque(VpaDCheque : TRBDCheque;VpaTipOperacao : String;VpaAdicionarnoCaixa : Boolean): string;
begin
  result := '';
{  if TipoContaCaixa(VpaDCheque.NumContaCaixa) then
    result := 'TIPO CONTA INVÁLIDO!!!'#13'Não é possível compensar um cheque em uma conta tipo Caixa';}

  if result = '' then
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from CHEQUE '+
                                   ' Where SEQCHEQUE = '+IntToStr(VpaDCheque.SeqCheque));
    Cadastro.Edit;
    Cadastro.FieldByname('DATCOMPENSACAO').AsDateTime := VpaDCheque.DatCompensacao;
    Cadastro.FieldByname('NUMCONTACAIXA').AsString := VpaDCheque.NumContaCaixa;
    Cadastro.FieldByname('DATALTERACAO').AsDateTime := now;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if result = '' then
      if ConfigModulos.Caixa and VpaAdicionarnoCaixa then
      begin
        result := FunCaixa.AdicionaCompensacaoChequeCaixa(VpaDCheque,VpaTipOperacao);
      end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.DevolveCheque(VpaCheques : TList;VpaData : TDateTime):string;
var
  VpfLaco : Integer;
  VpfDCheque : TRBDCheque;
  VpfChequesNovos, VpfParcelas : TList;
  VpfValCheques,VpfValChequesNovos :Double;
begin
  VpfParcelas := TList.Create;
  result := ExisteChequeAssociadoCP(VpaCheques,VpfParcelas,true);
  if result = 'EXTORNAR' then
  begin
    result := FunContasAPagar.EstornaCPChequeDevolvido(VpaCheques)
  end
  else
    if (result = 'DIGITAR') then
    begin
      VpfChequesNovos := TList.create;
      VpfValCheques := RValTotalCheques(VpaCheques);
      FChequesCP := TFChequesCP.criarSDI(nil,'',true);
      if FChequesCP.CadastraChequesAvulso(VpfValCheques,VpfChequesNovos) then
      begin
        VpfValChequesNovos := RValTotalCheques(VpfChequesNovos);
        result := GravaDCheques(VpfChequesNovos);
        if result = '' then
        begin
          //se o cheque novo entregue para o fornecedor é maior que o cheque que voltou o sistema gera um debito para o fornecedor junto a empresa;
          if VpfValChequesNovos  > VpfValCheques then
          begin
            result := FunClientes.AdicionaCredito(TRBDParcelaCP(VpfParcelas.Items[0]).CodCliente,VpfValChequesNovos- VpfValCheques,'D','Referente ao pagamento a maior dos cheques devolvidos "'+RNumerosCheques(VpfChequesNovos)+'"');
            if result = '' then
              aviso('FOI GERADO UM CRÉDITO COM O FORNECEDOR "'+TRBDParcelaCP(VpfParcelas.Items[0]).NomCliente+'" NO VALOR DE "'+FormatFloat('R$ #,###,###,##0.00',VpfValChequesNovos - VpfValCheques)+'"');
          end
          else
            if VpfValChequesNovos < VpfValCheques then
              result := FunContasAPagar.EstornaValorCPChequeDevolvido(VpfValCheques-VpfValChequesNovos,VpfParcelas);
        end;
        result := FunContasAPagar.GravaDChequeCP(VpfParcelas,VpfChequesNovos);
      end
      else
        result := 'DIGITAÇÃO DE CHEQUES CANCELADA!!!';
      VpfChequesNovos.free;
    end;

  if result = '' then
    result := EstornaCRChequeDevolvido(VpaCheques);
  if result = '' then
  begin
    for VpfLaco := 0 to VpaCheques.Count - 1 do
    begin
      VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
      AdicionaSQLAbreTabela(Cadastro,'Select * from CHEQUE '+
                                     ' Where SEQCHEQUE = '+IntToStr(VpfDCheque.SeqCheque));
      Cadastro.Edit;
      Cadastro.FieldByname('DATDEVOLUCAO').AsDateTime := VpaData;
      Cadastro.FieldByname('DATALTERACAO').AsDateTime := now;
      Cadastro.post;
      result := Cadastro.AMensagemErroGravacao;
    end;
    Cadastro.close;
  end;
  FreeTObjectsList(VpfParcelas);
  VpfParcelas.free;
end;

{******************************************************************************}
function TFuncoesContasAReceber.EstornaCheque(VpaDCheque: TRBDCheque;VpaOrigemEstorno : TRBDOrigemEstorno): string;
var
  VpfCheques : TList;
begin
  result := '';
  if ConfigModulos.Caixa then
  begin
    VpfCheques := TList.Create;
    VpfCheques.add(VpaDCheque);
    result := FunCaixa.ExtornaChequeCaixa(VpfCheques,VpaOrigemEstorno);
    VpfCheques.free;
  end;
  if result = '' then
  begin
    if(VpaDCheque.DatCompensacao > montadata(1,1,1900))or
      (VpaDCheque.DatDevolucao > MontaData(1,1,1900)) then
    begin
      AdicionaSQLAbreTabela(Cadastro,'Select * from CHEQUE '+
                                     ' Where SEQCHEQUE = '+IntToStr(VpaDCheque.SeqCheque));
      Cadastro.Edit;
      Cadastro.FieldByname('DATDEVOLUCAO').Clear;
      Cadastro.FieldByname('DATCOMPENSACAO').Clear;
      Cadastro.FieldByname('DATALTERACAO').AsDateTime := now;
      Cadastro.post;
      result := Cadastro.AMensagemErroGravacao;
      Cadastro.close;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.EstornaCobrancaExterna(VpaCodFilial,VpaLanReceber, VpaNumParcela: integer): String;
begin
  if result = '' then
  begin
    LocalizaParcela(Cadastro2,VpaCodFilial, VpaLanReceber, VpaNumParcela);
    if Cadastro2.FieldByName('C_COB_EXT').AsString = 'S' then
    begin
      Cadastro2.edit;
      Cadastro2.FieldByName('C_COB_EXT').AsString := 'N';
      Cadastro2.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
      Cadastro2.post;
      result := Cadastro2.AMensagemErroGravacao;
      Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
    end
    else
      result := 'DULICATA NÃO ESTA MARCADA COMO COBRANÇA !!!'#13'Não é possível estornar uma cobrança externa de uma duplicata que não foi marcada como fundo perdido...';
  end;
  Cadastro2.close;

end;

{******************************************************************************}
function TFuncoesContasAReceber.AlteraVencimentoCheque(VpaSeqCheque : Integer;VpaDatVencimento : TDatetime):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHEQUE '+
                                 ' Where SEQCHEQUE = '+IntToStr(VpaSeqCheque));
  Cadastro.Edit;
  Cadastro.FieldByname('DATVENCIMENTO').AsDateTime := VpaDatVencimento;
  Cadastro.FieldByname('DATALTERACAO').AsDateTime := now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAReceber.GeraComissaoNegativa(VpaDNotaFor : TRBDNotaFiscalFor):string;
var
  VpfDContasAReceber : TRBDContasCR;
begin
  VpfDContasAReceber := TRBDContasCR.cria;
  VpfDContasAReceber.CodEmpFil := VpaDNotaFor.CodFilial;
  VpfDContasAReceber.NroNota := VpaDNotaFor.NumNota;
  VpfDContasAReceber.CodCondicaoPgto := varia.CondPagtoVista;
  VpfDContasAReceber.CodCliente := VpaDNotaFor.CodFornecedor;
  VpfDContasAReceber.CodFrmPagto := Varia.FormaPagamentoDinheiro;
  VpfDContasAReceber.NumContaCorrente := '';
  VpfDContasAReceber.CodMoeda :=  varia.MoedaBase;
  VpfDContasAReceber.CodUsuario := varia.CodigoUsuario;
  VpfDContasAReceber.DatMov := Date;
  VpfDContasAReceber.DatEmissao := Date;
  VpfDContasAReceber.PlanoConta := VpaDNotaFor.DNaturezaOperacao.CodPlanoContas;
//  VpfDContasAReceber.IndBaixarConta := true;

  VpfDContasAReceber.ValTotal := 0;
  VpfDContasAReceber.PercentualDesAcr := 0;
  VpfDContasAReceber.MostrarParcelas := false;
  VpfDContasAReceber.CodVendedor := VpaDNotaFor.CodVendedor;
  VpfDContasAReceber.DesObservacao := 'Referente a nota de devoluçao "'+IntTostr(VpaDNotaFor.NumNota)+'"';
       // comissao
  if VpaDNotaFor.CodVendedor <> 0 then
  begin
    VpfDContasAReceber.TipComissao := 0;
    VpfDContasAReceber.PerComissao := VpaDNotaFor.PerComissao;
    VpfDContasAReceber.ValComissao := (VpaDNotaFor.PerComissao * VpaDNotaFor.ValTotalProdutos);
    if VpfDContasAReceber.ValComissao > 0 then
      VpfDContasAReceber.ValComissao := (VpfDContasAReceber.ValComissao/100)*-1;
  end;
  VpfDContasAReceber.EsconderConta := false;
  VpfDContasAReceber.IndGerarComissao := true;
  VpfDContasAReceber.IndCobrarFormaPagamento := false;
  VpfDContasAReceber.IndDevolucao := true;
  CriaContasaReceber(VpfDContasAReceber,result,true);
  VpfDContasAReceber.Free;
end;

{******************************************************************************}
function TFuncoesContasAReceber.CondicaoPagamentoDuplicada(VpaCondicoesPagamento : TList):Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDCondicaoInterna, VpfDCondicaoExterna : TRBDCondicaoPagamentoGrupoUsuario;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaCondicoesPagamento.Count - 2 do
  begin
    VpfDCondicaoExterna := TRBDCondicaoPagamentoGrupoUsuario(VpaCondicoesPagamento.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaCondicoesPagamento.Count - 1 do
    begin
      VpfDCondicaoInterna := TRBDCondicaoPagamentoGrupoUsuario(VpaCondicoesPagamento.Items[VpfLacoInterno]);
      if VpfDCondicaoInterna.CodCondicao = VpfDCondicaoExterna.CodCondicao then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.ExcluiCondicaoPagamento(VpaCodCondicaoPagamento : Integer):String;
var
  VpfTransacao : TTransactionDesc;
begin
  VpfTransacao.IsolationLevel :=xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(vpfTransacao);
  try
    ExecutaComandoSql(Aux,'delete from MOVCONDICAOPAGTO '+
                          ' Where I_COD_PAG = ' +IntToStr(VpaCodCondicaoPagamento));
    ExecutaComandoSql(Aux,'delete from CADCONDICOESPAGTO '+
                          ' Where I_COD_PAG = ' +IntToStr(VpaCodCondicaoPagamento));
    FPrincipal.BaseDados.Commit(VpfTransacao);
  except
    on e : exception do
    begin
      aviso(e.message);
      FPrincipal.BaseDados.Rollback(VpfTransacao);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAReceber.BaixaParcelaReceber(VpaDBaixa : TRBDBaixaCR;VpaDParcela : TRBDParcelaBaixaCR):string;
begin
  result := '';
  Localizaparcela(Cadastro,VpaDParcela.CodFilial,VpaDParcela.LanReceber, VpaDParcela.NumParcela);
  Cadastro.edit;

  Cadastro.FieldByName('D_DAT_PAG').AsDateTime := VpaDBaixa.DatPagamento;
  Cadastro.FieldByName('N_VLR_DES').AsCurrency := VpaDBaixa.ValorDesconto;
  Cadastro.FieldByName('N_VLR_ACR').AsCurrency := VpaDBaixa.ValorAcrescimo;
  Cadastro.FieldByName('C_NRO_CON').AsString := VpaDBaixa.NumContaCaixa;

  if VpaDParcela.IndGeraParcial then
    Cadastro.FieldByName('N_VLR_PAG').AsCurrency := (VpaDParcela.ValParcela+VpaDParcela.ValAcrescimo-VpaDParcela.ValDesconto)- VpaDBaixa.ValParcialFaltante
  else
    Cadastro.FieldByName('N_VLR_PAG').AsCurrency := VpaDParcela.ValParcela+VpaDParcela.ValAcrescimo-VpaDParcela.ValDesconto;
  Cadastro.FieldByName('L_OBS_REC').AsString := VpaDParcela.DesObservacoes;
  Cadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('N_PER_MUL').AsCurrency := VpaDParcela.PerMulta;
  Cadastro.FieldByName('N_PER_JUR').AsCurrency := VpaDParcela.PerJuros;
  Cadastro.FieldByName('N_PER_MOR').AsCurrency := VpaDParcela.PerMora;
  Cadastro.FieldByName('I_FIL_PAG').AsInteger := VpaDParcela.CodFilial;
  Cadastro.FieldByName('I_COD_FRM').AsInteger := VpaDBaixa.CodFormaPAgamento;  // caso naum mude a frm aqui so no cadastro, ou baixa

  //atualiza a data de alteracao para poder exportar
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;

  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Sistema.MarcaTabelaParaImportar('MOVCONTASARECEBER');
  Cadastro.close;
  if result = '' then
  begin
    result := GeraLogReceber(VpaDParcela.CodFilial,VpaDParcela.LanReceber,VpaDParcela.NumParcela,'BAIXA');
    if result = '' then
    begin
      if VpaDParcela.IndContaOculta  and (VpaDParcela.QtdParcelas = 1) then
      begin
        begin
          if VpaDParcela.ValDesconto <> 0 then
            AlteraValorDescontoCotacao(VpaDParcela.CodFilial,VpaDParcela.NumNotaFiscal,VpaDParcela.ValDesconto);
        end;
      end;
      if not VpaDBaixa.IndBaixaRetornoBancario then
        ExcluiItemRemessaSeNaoEnviado(VpaDParcela.CodFilial,VpaDParcela.LanReceber,VpaDParcela.NumParcela);
      if result = '' then
        result := FunClientes.AlteraDatUltimoRecebimento(VpaDParcela.CodCliente,date);
    end;
  end;
end;


end.
