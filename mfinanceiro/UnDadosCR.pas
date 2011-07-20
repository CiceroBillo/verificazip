unit UnDadosCR;

interface
Uses Classes;

Type
  TRBDTransferenciaExternaCheques = class
    public
      SeqCheque,
      NumCheque : Integer;
      IndMarcado : Boolean;
      NomEmitente : String;
      ValCheque : Double;
      DatVencimento : TDateTime;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDTransferenciaExternaFormaPagamento = class
    public
      SeqItem,
      CodFormaPagamento : Integer;
      NomFormaPagamento : String;
      ValInicial,
      ValFinal : Double;
      IndMarcado,
      IndPossuiCheques : Boolean;
      Cheques : TList;
      constructor cria;
      destructor destroy;override;
      function addCheque : TRBDTransferenciaExternaCheques;
  end;

Type
  TRBDTransferenciaExterna = class
    public
      SeqTransferencia,
      SeqCaixa : Integer;
      FormasPagamento : TList;

      constructor cria;
      destructor destroy;override;
      function AddFormaPagamento : TRBDTransferenciaExternaFormaPagamento;
  end;

type
  TRBDParcelaCP = class
    public
      CodFilial,
      LanPagar,
      NumParcela,
      NumParcelaParcial,
      CodCliente,
      CodFormaPagamento,
      NumNotaFiscal,
      NumDiasAtraso,
      QtdParcelas : Integer;
      NumContaCorrente,
      NomCliente,
      NomFormaPagamento,
      NumDuplicata,
      DesObservacoes,
      CodBarras : String;
      DatEmissao,
      DatVencimento,
      DatPagamento : TDateTime;
      ValParcela,
      ValPago,
      ValAcrescimo,
      ValDesconto,
      PerMora,
      PerJuros,
      PerMulta: Double;
      IndValorQuitaEssaParcela,
      IndGeraParcial,
      IndContaOculta : Boolean;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDCondicaoPagamentoGrupoUsuario = class
    public
      CodCondicao : Integer;
      NomCondicao : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBTipoParcela = (tpProximoMes,tpQtdDias,tpDiaFixo,tpDataFixa);
  TRBDParcelaCondicaoPagamento = class
    public
      NumParcela,
      QtdDias,
      DiaFixo,
      CodFormaPagamento : Integer;
      PerParcela,
      PerAcrescimoDesconto : Double;
      TipAcrescimoDesconto: String;
      DatFixa : TDatetime;
      TipoParcela : TRBTipoParcela;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDCondicaoPagamento = class
    public
      CodCondicaoPagamento,
      QtdParcelas : Integer;
      NomCondicaoPagamento : String;
      Parcelas : TList;
      constructor cria;
      destructor destroy;override;
      function AddParcela : TRBDParcelaCondicaoPagamento;
end;

Type
  TRBDDERVendedor = class
    public
      CodVendedor : Integer;
      NomVendedor : String;
      ValMeta,
      ValRealizado : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDDERCorpo = class
    public
      Mes,
      Ano : Integer;
      IndMensal : Boolean;
      Vendedores : TList;
      constructor Cria;
      destructor destroy;override;
      function addVendedor : TRBDDERVendedor;
end;

Type
  TRBDTipoFormaPagamento = (fpDinheiro,fpCheque,fpCartaoCredito,fpCobrancaBancaria,fpChequeTerceiros,fpCarteira,fpCartaoDebito,fpDepositoCheque);
 TRBDCheque = class
  public
    SeqCheque,
    CodBanco,
    CodFormaPagamento,
    CodCliente,
    NumCheque,
    CodUsuario,
    NumConta,
    NumAgencia : Integer;
    NumContaCaixa,
    NomContaCaixa,
    NomEmitente,
    NomNomimal,
    NomFormaPagamento,
    TipCheque,
    TipContaCaixa,
    NomCliente,
    IdeOrigem : String;
    ValCheque : Double;
    DatCadastro,
    DatVencimento,
    DatCompensacao,
    DatDevolucao,
    DatEmissao : TDatetime;
    TipFormaPagamento : TRBDTipoFormaPagamento;
    constructor cria;
    destructor destroy;override;
end;


type
  TRBDParcelaBaixaCR = class
    public
      CodFilial,
      LanReceber,
      NumParcela,
      NumParcelaParcial,
      CodCliente,
      CodFormaPagamento,
      NumNotaFiscal,
      NumDiasAtraso,
      NumDiasCarencia,
      QtdParcelas : Integer;
      NumContaCorrente,
      NomCliente,
      NomFormaPagamento,
      NumDuplicata,
      DesObservacoes: String;
      DatEmissao,
      DatVencimento,
      DatPagamento,
      DatPromessaPagamento : TDateTime;
      ValParcela,
      ValPago,
      ValAcrescimo,
      ValDesconto,
      ValDescontoAteVencimento,
      ValTarifaDesconto,
      PerDescontoFormaPagamento,
      PerMora,
      PerJuros,
      PerMulta: Double;
      IndValorQuitaEssaParcela,
      IndGeraParcial,
      IndContaOculta,
      IndDescontado : Boolean;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDFluxoCaixaDia = Class
    public
      Dia : Integer;
      ValCRPrevisto,
      ValCRDuvidoso,
      ValCobrancaPrevista,
      ValDescontoDuplicata,
      ValChequesCR,
      ValCP,
      ValChequesCP,
      ValTotalReceita,
      ValTotalReceitaAcumulada,
      ValTotalDespesa,
      ValTotalDespesaAcumulada,
      Valtotal,
      ValTotalAcumulado :Double;
      ParcelasCR,
      ParcelasCP,
      ParcelasDuvidosas,
      ChequesCR,
      ChequesCP  : TList;
      constructor cria;
      destructor destroy;override;
      function addParcelaCR : TRBDParcelaBaixaCR;
      function AddParcelaCP : TRBDParcelaCP;
      function addParcelaDuvidosa : TRBDParcelaBaixaCR;
      function AddChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
      function AddChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
end;

Type
  TRBDFluxoCaixaMes = Class
    public
      Mes,
      Ano : Integer;
      ValCRPrevisto,
      ValCRDuvidoso,
      ValCobrancaPrevista,
      ValDescontoDuplicata,
      ValChequesCR,
      ValCP,
      ValChequesCP,
      ValTotalReceita,
      ValTotalReceitaAcumulada,
      ValTotalDespesa,
      ValTotalDespesaAcumulada,
      Valtotal,
      ValTotalAcumulado :Double;
      Dias : TList;
      constructor cria;
      destructor destroy;override;
      function addDia(VpaDia : Integer) : TRBDFluxoCaixaDia;
      function RDia(VpaDia : Integer):TRBDFluxoCaixaDia;
end;

Type
  TRBDTipoLinhaFluxo = (lfCRPrevisto,lfCRDuvidoso,lfCRCheques,lfCRTotalDia,lfCRTotalAcumulado,lfCPPrevisto,lfCPCheques,lfCPTotalDia,lfCPTotalAcumaldo,lfTotalConta,lfTotalContaAcumulada);
  TRBDFluxoCaixaConta = Class
    public
      NumContaCaixa,
      NomContaCaixa : String;
      LinContasReceberPrevisto,
      LinContasReceberDuvidoso,
      LinChequesaCompensarCR,
      LinReceitasAcumuladas,
      LinContasAPagar,
      LinChequesaCompensarCP,
      LinDespesasAcumuladas,
      LinTotalConta,
      LinTotalAcumulado : Integer;
      ValSaldoAtual,
      ValChequeCRSaldoAnterior,
      ValChequeCPSaldoAnterior,
      ValSaldoAnteriorCR,
      ValSaldoAnteriorCP,
      ValAplicado,
      ValLimiteCredito,
      ValTotalReceitas,
      ValTotalDespesas,
      ValTotalReceitasAcumuladas,
      ValTotalDespesasAcumuladas : Double;
      ParcelasSaldoAnterior,
      ParcelasSaldoAnteriorCP,
      ChequeCRSaldoAnterior,
      ChequeCPSaldoAnterior,
      Meses : TList;
      constructor cria;
      destructor destroy;override;
      function RMes(VpaMes,VpaAno : Integer):TRBDFluxoCaixaMes;
      function RDia(VpaDatVencimento : TDatetime;VpaCriarSeNaoEncontrar : Boolean = true):TRBDFluxoCaixaDia;
      function addMes(VpaMes,VpaAno : Integer) : TRBDFluxoCaixaMes;
      function addParcelaSaldoAnteriorCR : TRBDParcelaBaixaCR;
      function addParcelaSaldoAnteriorCP : TRBDParcelaCP;
      function addParcelaCR(VpaData : TDateTime) : TRBDParcelaBaixaCR;
      function AddParcelaCP(VpaData : TDateTime) : TRBDParcelaCP;
      function AddParcelaDuvidosa(VpaData : TDateTime) : TRBDParcelaBaixaCR;
      function addChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
      function AddChequeCRSaldoAnterior : TRBDCheque;
      function AddChequeCPSaldoAnterior : TRBDCheque;
      function addChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
end;

Type
  TRBDFluxoCaixaCorpo = Class
    public
      CodFilial,
      Mes,
      Ano,
      QtdColunas,
      LinTotalAcumulado : Integer;
      IndDiario : Boolean;
      IndSeparaCRDuvidoso,
      IndMostrarCobrancaPrevista,
      IndSomenteClientesQuePagamEmDia,
      IndMostraContasSeparadas,
      IndMostrarContasaPagarProrrogado : Boolean;
      ValChequeCRSaldoAnterior,
      ValChequeCPSaldoAnterior,
      ValSaldoAnteriorCR,
      ValSaldoAnteriorCP,
      ValSaldoAtual,
      ValAplicacao,
      ValTotalAcumulado : Double;
      DatInicio,
      DatFim : TDateTime;
      ParcelasSaldoAnterior,
      ContasCaixa,
      Dias : TList;
      ContaGeral : TRBDFluxoCaixaConta;
      constructor cria;
      destructor destroy;override;
      function addContaCaixa : TRBDFluxoCaixaConta;
      procedure OrdenaDias(VpaDias : TList);
      procedure OrdenaDiasContas;
      procedure CalculaValoresTotais;
      function RDia(VpaDia: Integer) : TRBDFluxoCaixaDia;
end;


Type
  TRBDCaixaFormaPagamento = class
    public
      CodFormaPagamento : Integer;
      NomFormaPagamento : String;
      ValInicial,
      ValAtual,
      ValFinal : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDCaixaItem = class
    public
      seqItem,
      CodUsuario,
      CodFilial,
      LanReceber,
      LanPagar,
      NumParcelaReceber,
      NumParcelaPagar,
      SeqCheque,
      CodFormaPagamento : Integer;
      DesLancamento,
      DesDebitoCredito : String;
      ValLancamento : Double;
      DatPagamento,
      DatLancamento : TDatetime;
      TipFormaPagamento : TRBDTipoFormaPagamento;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDTipoConta = (tcCaixa,tcContaCorrente);
  TRBDCaixa = class
    public
      SeqCaixa,
      CodUsuarioAbertura,
      CodUsuarioFechamento : Integer;
      NumConta : String;
      ValInicial,
      ValInicialCheque,
      ValAtual,
      ValAtualCheque,
      ValFinal : double;
      DatAbertura,
      DatFechamento : TDateTime;
      TipoConta : TRBDTipoConta;
      FormasPagamento,
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function AddCaixaItem : TRBDCaixaItem;
      function AddFormaPagamento : TRBDCaixaFormaPagamento;
end;



Type
  TRBDContasaPagarProjeto = class
    public
      CodProjeto : Integer;
      NomProjeto : String;
      PerDespesa,
      ValDespesa : Double;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDContasaPagar = Class
    public
      CodFilial,
      LanPagar,
      NumNota,
      SeqNota,
      CodFornecedor,
      CodCentroCusto,
      CodFormaPagamento,
      CodBancoBoleto,
      CodMoeda,
      CodProjeto,
      CodUsuario,
      CodCondicaoPagamento,
      FatorVencimento  : integer;
      DatEmissao : TDateTime;
      NomFornecedor,
      NumContaCaixa,
      CodPlanoConta,
      DesIdentificacaoBancarioFornecedor,
      CodBarras,
      DesPathFoto : string;
      ValParcela,
      ValTotal,
      ValBoleto,
      ValUtilizadoCredito,
      ValSaldoDebitoFornecedor     : double;
      PerDescontoAcrescimo : double;
      IndDespesaPrevista,
      IndBaixarConta,
      IndMostrarParcelas,
      IndEsconderConta : Boolean;
      DesTipFormaPagamento : String;
      DesObservacao : String;
      Parcelas,
      DespesaProjeto : TList;
      constructor cria;
      destructor Destroy;override;
      function addParcela : TRBDParcelaCP;
      function addDespesaProjeto : TRBDContasaPagarProjeto;
  end;


Type
  TRBDComissaoItem = class
    public
      NumParcela : Integer;
      ValComissaoParcela,
      ValBaseComissao : Double;
      DatVencimento,
      DatPagamento,
      DatLiberacao : TDateTime;
      IndLiberacaoAutomatica : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDComissao = class
    public
      CodFilial,
      SeqComissao,
      LanReceber,
      CodVendedor,
      TipComissao : Integer;
      DesObservacao : string;
      PerComissao,
      ValTotalComissao,
      ValTotalProdutos : Double;
      DatEmissao : TDateTime;
      Parcelas : TList;
      constructor cria;
      destructor destroy;override;
      function AddParcela : TRBDComissaoItem;
end;


Type
  TRBDECobrancaItem = class
    public
      CodFilial,
      LanReceber,
      NumParcela : Integer;
      UsuarioEmail,
      DesEmail,
      DesEstatus,
      NomCliente,
      NomFantasiaFilial : String;
      DatEnvio : TDatetime;
      IndEnviado : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDECobrancaCorpo = class
    public
      SeqEmail,
      SeqItemEmailDisponivel : Integer;
      DatEnvio : TDateTime;
      QtdEnvidados,
      QtdNaoEnviados,
      CodUsuario : Integer;
      Items : TList;
      constructor cria;
      destructor destroy; override;
      function AddECobrancaItem : TRBDECobrancaItem;
end;

Type
  TRBDFormaPagamento = class
    public
      CodForma : Integer;
      NomForma : String;
      FlaTipo : TRBDTipoFormaPagamento;
      IndBaixarConta : Boolean;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDMovContasCR = class
    public
      NumParcela,
      CodFormaPagamento,
      CodBanco,
      NumDiasAtraso,
      DiasCarencia,
      DiasCompensacao : integer;
      Valor,
      ValorBruto,
      ValAcrescimo,
      ValDesconto,
      ValTarifasBancarias,
      PerJuros,
      PerMora,
      PerMulta,
      PerDescontoVencimento,
      PerDesconto,
      ValCheque,
      ValAcrescimoFrm,
      ValSinal : Double;
      DatVencimento,
      DatProrrogacao,
      DatPagamento: TDateTime;
      NroAgencia,
      NumContaCaixa,
      NroContaBoleto,
      NroDuplicata,
      NroDocumento,
      NossoNumero,
      DesObservacoes : String;
      IndBaixarConta : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDContasCR = class
    public
      CodEmpFil,
      LanReceber,
      NroNota,
      SeqNota,
      LanOrcamento,
      SeqParcialCotacao,
      CodCondicaoPgto,
      CodCliente,
      CodFrmPagto,
      CodMoeda,
      CodUsuario : Integer;
      DatMov,
      DatEmissao,
      DatPagamentoSinal : TDateTime;
      NomCliente,
      PlanoConta,
      NumContaCaixa,
      NumContaCorrente,
      DesObservacao: string;
      MostrarParcelas,
      EsconderConta,
      IndDevolucao,
      IndGerarComissao,
      IndCobrarFormaPagamento,
      IndSinalPagamento,
      IndPossuiSinalPagamento : Boolean;
      CodVendedor,
      CodPreposto : Integer;
      ValTotal,
      ValTotalAcrescimoFormaPagamento,
      PercentualDesAcr,
      PerComissao,
      PerComissaoPreposto,
      ValComissao,
      ValBaseComissao,
      ValTotalProdutos,
      ValComissaoPreposto,
      ValUtilizadoCredito,
      ValSaldoCreditoCliente,
      ValSinal : Double;
      TipComissao,
      TipValorComissao,
      TipComissaoPreposto : Integer; // 0 direta 1 produtos
      DPNumDuplicata : Integer;
      Parcelas : TList;
      constructor cria;
      destructor destroy;override;
      function AddParcela : TRBDMovContasCR;
end;

type
  TDadosNovaContaCR = Class
    CodEmpFil,
    NroNota,
    SeqNota,
    CodCondicaoPgto,
    CodCliente,
    CodFrmPagto,
    CodMoeda,
    CodUsuario: Integer;
    DataMov,
    DataEmissao : TDateTime;
    PlanoConta: string;
    ValorTotal : Double;
    PercentualDescAcr : double;
    VerificarCaixa,
    BaixarConta,
    MostrarParcelas,
    MostrarTelaCaixa,
    GerarComissao,
    EsconderConta : Boolean;
    TipoFrmPAgto : String;
    ValorPro, PercPro : TstringList;
    CodVendedor : Integer;
    PercComissaoPro,
    PercComissaoServ,
    ValorComPro,
    ValorComServ : Double;
    TipoComissao  : Integer; // 0 direta 1 produtos
end;

type
  TDadosNovaParcelaCR = Class
    EmpresaFilial      : integer;
    LancamentoCR       : integer;
    ValorTotal         : double;
    CodigoFrmPagto     : Integer;
    CodigoConPagamento : integer;
    CodMoeda           : Integer;
    NumeroDup          : string;
    PercentualDesAcr   : Double;
    DataEmissao        : TDateTime;
    ParcelaPerson      : Boolean;
    DataVenPerson,
    ValorVenPrson      : TStringList;
    SeqTef             : Integer;
end;


type
  TRBDBaixaCP = class
    public
      CodFormaPagamento,
      CodFornecedor: Integer;
      TipFormaPagamento,
      NumContaCaixa : String;
      ValorAcrescimo,
      ValorDesconto,
      ValorPago,
      ValParcialFaltante,
      ValParaGerardeDebito : Double;
      DatPagamento,
      DatVencimentoParcial : TDateTime;
      IndPagamentoParcial,
      IndBaixaUtilizandoODebitoFornecedor : Boolean;
      Parcelas,
      Cheques,
      Caixas : TList;
      constructor Cria;
      destructor Destroy; override;
      function AddParcela: TRBDParcelaCP;
      function AddCheque : TRBDCheque;
      function AddCaixa : TRBDCaixa;
end;


type
  TRBDBaixaCR = class
    public
      CodFormaPagamento,
      DiasVencimentoCartao : Integer;
      NumContaCaixa: String;
      TipFormaPagamento:TRBDTipoFormaPagamento;
      ValorAcrescimo,
      ValorDesconto,
      ValorPago,
      ValParcialFaltante,
      ValParaGerardeCredito : Double;
      DatPagamento,
      DatVencimentoParcial : TDateTime;
      IndPagamentoParcial,
      IndBaixaRetornoBancario,
      IndDesconto,
      IndBaixaUtilizandoOCreditodoCliente,
      IndContaOculta : Boolean;
      Parcelas,
      Cheques,
      Caixas : TList;
      constructor Cria;
      destructor Destroy; override;
      function AddParcela: TRBDParcelaBaixaCR;
      function AddCheque : TRBDCheque;
      function AddCaixa : TRBDCaixa;
end;


implementation

Uses FunObjeto, FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaConta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaMes.cria;
begin
  inherited create;
  Dias := TList.create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaMes.destroy;
begin
  FreeTObjectsList(Dias);
  Dias.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFluxoCaixaMes.RDia(VpaDia: Integer): TRBDFluxoCaixaDia;
var
  VpfLaco : Integer;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  result := nil;
  for VpfLaco := 0 to Dias.Count - 1 do
  begin
    VpfDDia := TRBDFluxoCaixaDia(Dias.Items[VpfLaco]);
    if (VpaDia = VpfDDia.Dia)  then
    begin
      result := VpfDDia;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBDFluxoCaixaMes.addDia(VpaDia : Integer) : TRBDFluxoCaixaDia;
begin
  Result := TRBDFluxoCaixaDia.cria;
  result.Dia := VpaDia;
  Dias.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaConta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaConta.cria;
begin
  inherited create;
  Meses := TList.create;
  ParcelasSaldoAnterior := TList.Create;
  ParcelasSaldoAnteriorCP := TList.Create;
  ChequeCRSaldoAnterior := TList.Create;
  ChequeCPSaldoAnterior := TList.Create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaConta.destroy;
begin
  FreeTObjectsList(Meses);
  Meses.free;
  FreeTObjectsList(ChequeCRSaldoAnterior);
  ChequeCRSaldoAnterior.Free;
  FreeTObjectsList(ParcelasSaldoAnterior);
  ParcelasSaldoAnterior.free;
  FreeTObjectsList(ParcelasSaldoAnteriorCP);
  ParcelasSaldoAnteriorCP.Free;
  FreeTObjectsList(ChequeCPSaldoAnterior);
  ChequeCPSaldoAnterior.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.RDia(VpaDatVencimento : TDatetime;VpaCriarSeNaoEncontrar : Boolean = true):TRBDFluxoCaixaDia;
var
  VpfLacoDia : Integer;
  VpfDFluxoMes : TRBDFluxoCaixaMes;
begin
  result := nil;
  VpfDFluxoMes := nil;
  if DiaSemanaNumerico(VpaDatVencimento) = 1  then
    VpaDatVencimento := IncDia(VpaDatVencimento,1)
  else
    if DiaSemanaNumerico(VpaDatVencimento) = 7  then
      VpaDatVencimento := IncDia(VpaDatVencimento,2);
  VpfDFluxoMes := RMes(mes(VpaDatVencimento),ano(VpaDatVencimento));
  if VpfDFluxoMes <> nil then
  begin
    for VpfLacoDia := 0 to VpfDFluxoMes.Dias.Count - 1 do
    begin
      if (dia(VpaDatVencimento) = TRBDFluxoCaixaDia(VpfDFluxoMes.Dias.Items[VpfLacoDia]).Dia) then
        result := TRBDFluxoCaixaDia(VpfDFluxoMes.Dias.Items[VpfLacoDia]);
    end;
  end;
  if VpaCriarSeNaoEncontrar then
  begin
    if result = nil then
    begin
      if VpfDFluxoMes = nil then
        VpfDFluxoMes := addMes(Mes(VpaDatVencimento),Ano(VpaDatVencimento));
      result := VpfDFluxoMes.addDia(Dia(VpaDatVencimento));
    end;
  end;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.RMes(VpaMes, VpaAno: Integer): TRBDFluxoCaixaMes;
var
  VpfLacoMes : Integer;
begin
  result := nil;
  for VpfLacoMes := 0 to Meses.Count - 1 do
  begin
    if (VpaMes = TRBDFluxoCaixaMes(Meses.Items[VpfLacoMes]).Mes) and
       (VpaAno = TRBDFluxoCaixaMes(Meses.Items[VpfLacoMes]).Ano) then
    begin
      result := TRBDFluxoCaixaMes(Meses.Items[VpfLacoMes]);
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addMes(VpaMes,VpaAno : Integer) : TRBDFluxoCaixaMes;
begin
  Result := TRBDFluxoCaixaMes.cria;
  result.Mes := VpaMes;
  Result.Ano := VpaAno;
  Meses.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.AddParcelaCP(VpaData: TDateTime): TRBDParcelaCP;
begin
  result := RDia(VpaData).AddParcelaCP;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addParcelaSaldoAnteriorCR : TRBDParcelaBaixaCR;
begin
  result := TRBDParcelaBaixaCR.Cria;
  ParcelasSaldoAnterior.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addParcelaSaldoAnteriorCP: TRBDParcelaCP;
begin
  result := TRBDParcelaCP.Cria;
  ParcelasSaldoAnteriorCP.Add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addParcelaCR(VpaData : TDateTime) : TRBDParcelaBaixaCR;
begin
  result := RDia(VpaData).addParcelaCR;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.AddParcelaDuvidosa(VpaData: TDateTime): TRBDParcelaBaixaCR;
begin
  result := RDia(VpaData).addParcelaDuvidosa;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.AddChequeCPSaldoAnterior: TRBDCheque;
begin
  result := TRBDCheque.cria;
  ChequeCPSaldoAnterior.Add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
begin
  result :=  RDia(VpaDatVencimento).AddChequeCR(VpaDatVencimento);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.AddChequeCRSaldoAnterior: TRBDCheque;
begin
  result := TRBDCheque.cria;
  ChequeCRSaldoAnterior.Add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
begin
  result :=  RDia(VpaDatVencimento).AddChequeCP(VpaDatVencimento);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaCorpo.cria;
begin
  inherited create;
  ContasCaixa := TList.Create;
  ParcelasSaldoAnterior := TList.Create;
  Dias := TList.Create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaCorpo.destroy;
begin
  FreeTObjectsList(ContasCaixa);
  ContasCaixa.free;
  ParcelasSaldoAnterior.Free;
  FreeTObjectsList(Dias);
  Dias.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFluxoCaixaCorpo.addContaCaixa : TRBDFluxoCaixaConta;
begin
  result := TRBDFluxoCaixaConta.cria;
  ContasCaixa.add(result);
end;

{******************************************************************************}
procedure TRBDFluxoCaixaCorpo.OrdenaDias(VpaDias: TList);
var
  VpfLacoDiaInterno, VpfLacoDiaExterno : Integer;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  for VpfLacoDiaExterno := 0 to VpaDias.Count - 2 do
  begin
    VpfDDia := TRBDFluxoCaixaDia(VpaDias.Items[VpfLacoDiaExterno]);
    for VpfLacoDiaInterno := VpfLacoDiaExterno + 1 to VpaDias.Count - 1 do
    begin
      if TRBDFluxoCaixaDia(VpaDias.Items[VpfLacoDiaInterno]).Dia < VpfDDia.Dia then
      begin
        VpaDias.Items[VpfLacoDiaExterno] := VpaDias.Items[VpfLacoDiaInterno];
        VpaDias.Items[VpfLacoDiaInterno] := VpfDDia;
        VpfDDia := TRBDFluxoCaixaDia(VpaDias.Items[VpfLacoDiaExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBDFluxoCaixaCorpo.OrdenaDiasContas;
var
  VpfLacoContas, VpfLacoMes, VpfLacoDiaInterno, VpfLacoDiaExterno : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDMes : TRBDFluxoCaixaMes;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  for VpfLacoContas := 0 to ContasCaixa.Count - 1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(ContasCaixa.Items[VpfLacoContas]);
    for VpfLacoMes := 0 to VpfDConta.Meses.Count - 1 do
    begin
      VpfDMes := TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]);
      OrdenaDias(VpfDMes.Dias);
    end;
  end;
end;

{******************************************************************************}
function TRBDFluxoCaixaCorpo.RDia(VpaDia: Integer): TRBDFluxoCaixaDia;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to Dias.Count - 1 do
  begin
    if VpaDia =  TRBDFluxoCaixaDia(Dias.Items[VpfLaco]).dia then
    begin
      result :=TRBDFluxoCaixaDia(Dias.Items[VpfLaco]);
      break;
    end;
  end;
  if result = nil then
  begin
    result := TRBDFluxoCaixaDia.cria;
    Dias.add(result);
    Result.Dia := VpaDia;
  end;
end;

{******************************************************************************}
procedure TRBDFluxoCaixaCorpo.CalculaValoresTotais;
var
  VpfLacoContas, VpfLacoMes, VpfLacoDia, VpfLacoParcela : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDMes : TRBDFluxoCaixaMes;
  VpfDDia, VpfDDiaFluxo : TRBDFluxoCaixaDia;
  VpfDParcela : TRBDParcelaBaixaCR;
  VpfDParcelaCP : TRBDParcelaCP;
  VpfDCheque : TRBDCheque;
begin
  OrdenaDiasContas;
  FreeTObjectsList(Dias); //apaga os dias para zeras or valores gerais do fluxo.
  ValTotalAcumulado := 0;
  ValSaldoAnteriorCR := 0;
  ValSaldoAnteriorCP := 0;
  ValChequeCRSaldoAnterior := 0;
  ValChequeCPSaldoAnterior := 0;
  for VpfLacoContas := 0 to ContasCaixa.Count - 1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(ContasCaixa.Items[VpfLacoContas]);
    VpfDConta.ValTotalReceitas := 0;
//    VpfDConta.ValTotalReceitasAcumuladas := VpfDConta.ValAplicado +VpfDConta.ValSaldoAnteriorCR + VpfDConta.ValChequeCRSaldoAnterior+ VpfDConta.ValSaldoAtual ;
    VpfDConta.ValTotalReceitasAcumuladas := VpfDConta.ValSaldoAnteriorCR + VpfDConta.ValChequeCRSaldoAnterior;
    VpfDConta.ValTotalDespesasAcumuladas := VpfDConta.ValSaldoAnteriorCP + VpfDConta.ValChequeCPSaldoAnterior;
    for VpfLacoMes := 0 to VpfDConta.Meses.Count - 1 do
    begin
      VpfDMes := TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]);
      VpfDMes.ValCRPrevisto := 0;
      VpfDMes.ValCRDuvidoso := 0;
      VpfDMes.ValCobrancaPrevista := 0;
      VpfDMes.ValDescontoDuplicata := 0;
      VpfDMes.ValCP := 0;
      VpfDMes.ValTotalReceita := 0;
      VpfDMes.ValTotalAcumulado := VpfDConta.ValAplicado +VpfDConta.ValSaldoAnteriorCR + VpfDConta.ValSaldoAtual+ VpfDConta.ValChequeCRSaldoAnterior-VpfDConta.ValSaldoAnteriorCP -VpfDConta.ValChequeCPSaldoAnterior ;
      VpfDMes.ValTotalDespesaAcumulada := VpfDConta.ValSaldoAnteriorCP + VpfDConta.ValChequeCPSaldoAnterior;
      VpfDMes.ValTotalReceitaAcumulada := VpfDConta.ValSaldoAnteriorCR + VpfDConta.ValChequeCRSaldoAnterior;
      for VpfLacoDia := 0 to VpfDMes.Dias.Count - 1 do
      begin
        VpfDDia := TRBDFluxoCaixaDia(VpfDMes.Dias.Items[VpfLacoDia]);
        VpfDDia.ValCRPrevisto := 0;
        VpfDDia.ValCRDuvidoso := 0;
        VpfDDia.ValCP := 0;
        VpfDDia.ValChequesCP :=0;
        VpfDDia.ValCobrancaPrevista := 0;
        VpfDDia.ValDescontoDuplicata := 0;
        VpfDDia.Valtotal := 0;
        VpfDDia.ValTotalReceitaAcumulada := VpfDMes.ValTotalReceitaAcumulada;
        VpfDDia.ValTotalDespesaAcumulada := VpfDMes.ValTotalDespesaAcumulada;
        VpfDDia.ValTotalAcumulado := VpfDMes.ValTotalAcumulado;
        VpfDDia.ValTotalReceita := 0;
        VpfDDia.ValTotalDespesa := 0;
        VpfDDiaFluxo := RDia(VpfDDia.Dia);
        //contas a receber
        for VpfLacoParcela := 0 to VpfDDia.ParcelasCR.Count - 1 do
        begin
          VpfDParcela := TRBDParcelaBaixaCR(VpfDDia.ParcelasCR.Items[VpfLacoParcela]);
          VpfDDia.ValCRPrevisto := VpfDDia.ValCRPrevisto + VpfDParcela.ValParcela;
          VpfDDiaFluxo.ValCRPrevisto := VpfDDiaFluxo.ValCRPrevisto + VpfDParcela.ValParcela;
          VpfDMes.ValCRPrevisto := VpfDMes.ValCRPrevisto + VpfDParcela.ValParcela;
          if VpfDParcela.IndDescontado then
          begin
            VpfDDia.ValDescontoDuplicata := VpfDDia.ValDescontoDuplicata + VpfDParcela.ValParcela;
            VpfDDiaFluxo.ValDescontoDuplicata := VpfDDiaFluxo.ValDescontoDuplicata + VpfDParcela.ValParcela;
            VpfDMes.ValDescontoDuplicata := VpfDMes.ValDescontoDuplicata + VpfDParcela.ValParcela;
          end
          else
          begin
            VpfDDia.ValTotalReceita := VpfDDia.ValTotalReceita + VpfDParcela.ValParcela;
            VpfDDiaFluxo.ValTotalReceita := VpfDDiaFluxo.ValTotalReceita + VpfDParcela.ValParcela;
            VpfDMes.ValTotalReceita := VpfDMes.ValTotalReceita + VpfDParcela.ValParcela;
            VpfDConta.ValTotalReceitas := VpfDConta.ValTotalReceitas + VpfDParcela.ValParcela;
          end;
          VpfDMes.ValTotalReceitaAcumulada := VpfDMes.ValTotalReceitaAcumulada +VpfDParcela.ValParcela ;
          VpfDDia.ValTotalReceitaAcumulada := VpfDDia.ValTotalReceitaAcumulada + VpfDParcela.ValParcela;
          VpfDConta.ValTotalReceitasAcumuladas := VpfDConta.ValTotalReceitasAcumuladas + VpfDParcela.ValParcela;
          VpfDMes.ValTotalAcumulado := VpfDMes.ValTotalAcumulado + VpfDParcela.ValParcela;
        end;
        for VpfLacoParcela := 0 to VpfDDia.ParcelasDuvidosas.Count - 1 do
        begin
          VpfDParcela := TRBDParcelaBaixaCR(VpfDDia.ParcelasDuvidosas.Items[VpfLacoParcela]);
          VpfDDia.ValCRDuvidoso := VpfDDia.ValCRDuvidoso + VpfDParcela.ValParcela;
          VpfDDiaFluxo.ValCRDuvidoso := VpfDDiaFluxo.ValCRDuvidoso + VpfDParcela.ValParcela;
          VpfDMes.ValCRDuvidoso := VpfDMes.ValCRDuvidoso + VpfDParcela.ValParcela;
          if VpfDParcela.IndDescontado then
          begin
            VpfDDia.ValDescontoDuplicata := VpfDDia.ValDescontoDuplicata + VpfDParcela.ValParcela;
            VpfDDiaFluxo.ValDescontoDuplicata := VpfDDiaFluxo.ValDescontoDuplicata + VpfDParcela.ValParcela;
            VpfDMes.ValDescontoDuplicata := VpfDMes.ValDescontoDuplicata + VpfDParcela.ValParcela;
          end
          else
          begin
            VpfDDia.ValTotalReceita := VpfDDia.ValTotalReceita + VpfDParcela.ValParcela;
            VpfDDiaFluxo.ValTotalReceita := VpfDDiaFluxo.ValTotalReceita + VpfDParcela.ValParcela;
            VpfDMes.ValTotalReceita := VpfDMes.ValTotalReceita + VpfDParcela.ValParcela;
            VpfDConta.ValTotalReceitas := VpfDConta.ValTotalReceitas + VpfDParcela.ValParcela;
          end;
          VpfDMes.ValTotalReceitaAcumulada := VpfDMes.ValTotalReceitaAcumulada +VpfDParcela.ValParcela ;
          VpfDDia.ValTotalReceitaAcumulada := VpfDDia.ValTotalReceitaAcumulada + VpfDParcela.ValParcela;
          VpfDDiaFluxo.ValTotalReceitaAcumulada := VpfDDiaFluxo.ValTotalReceitaAcumulada + VpfDParcela.ValParcela;
          VpfDConta.ValTotalReceitasAcumuladas := VpfDConta.ValTotalReceitasAcumuladas + VpfDParcela.ValParcela;
          VpfDMes.ValTotalAcumulado := VpfDMes.ValTotalAcumulado + VpfDParcela.ValParcela;
        end;
        for VpfLacoParcela := 0 to VpfDDia.ChequesCR.Count - 1 do
        begin
          VpfDCheque := TRBDCheque(VpfDDia.ChequesCR.Items[VpfLacoParcela]);
          VpfDDia.ValChequesCR := VpfDDia.ValChequesCR + VpfDCheque.ValCheque;
          VpfDDiaFluxo.ValChequesCR := VpfDDiaFluxo.ValChequesCR + VpfDCheque.ValCheque;
          VpfDMes.ValChequesCR := VpfDMes.ValChequesCR + VpfDCheque.ValCheque;
          VpfDDia.ValTotalReceita := VpfDDia.ValTotalReceita + VpfDCheque.ValCheque;
          VpfDDiaFluxo.ValTotalReceita := VpfDDiaFluxo.ValTotalReceita + VpfDCheque.ValCheque;
          VpfDMes.ValTotalReceita := VpfDMes.ValTotalReceita + VpfDCheque.ValCheque;
          VpfDConta.ValTotalReceitas := VpfDConta.ValTotalReceitas + VpfDCheque.ValCheque;
          VpfDMes.ValTotalReceitaAcumulada := VpfDMes.ValTotalReceitaAcumulada +VpfDCheque.ValCheque ;
          VpfDDia.ValTotalReceitaAcumulada := VpfDDia.ValTotalReceitaAcumulada + VpfDCheque.ValCheque ;
          VpfDConta.ValTotalReceitasAcumuladas := VpfDConta.ValTotalReceitasAcumuladas + VpfDCheque.ValCheque;
          VpfDMes.ValTotalAcumulado := VpfDMes.ValTotalAcumulado + VpfDCheque.ValCheque;
        end;
        //contas a pagar
        for VpfLacoParcela := 0 to VpfDDia.ParcelasCP.Count - 1 do
        begin
          VpfDParcelaCP := TRBDParcelaCP(VpfDDia.ParcelasCP.Items[VpfLacoParcela]);
          VpfDDia.ValCP := VpfDDia.ValCP + VpfDParcelaCP.ValParcela;
          VpfDDia.ValTotalDespesa := VpfDDia.ValTotalDespesa + VpfDParcelaCP.ValParcela;
          VpfDDiaFluxo.ValCP := VpfDDiaFluxo.ValCP + VpfDParcelaCP.ValParcela;
          VpfDDiaFluxo.ValTotalDespesa := VpfDDiaFluxo.ValTotalDespesa + VpfDParcelaCP.ValParcela;
          VpfDMes.ValCP := VpfDMes.ValCP + VpfDParcelaCP.ValParcela;
          VpfDMes.ValTotalDespesa := VpfDMes.ValTotalDespesa + VpfDParcelaCP.ValParcela;
          VpfDConta.ValTotalDespesas := VpfDConta.ValTotalDespesas + VpfDParcelaCP.ValParcela;
          VpfDMes.ValTotalDespesaAcumulada := VpfDMes.ValTotalDespesaAcumulada +VpfDParcelaCP.ValParcela ;
          VpfDDia.ValTotalDespesaAcumulada := VpfDDia.ValTotalDespesaAcumulada + VpfDParcelaCP.ValParcela;
          VpfDConta.ValTotalDespesasAcumuladas := VpfDConta.ValTotalDespesasAcumuladas + VpfDParcelaCP.ValParcela;
          VpfDMes.ValTotalAcumulado := VpfDMes.ValTotalAcumulado - VpfDParcelaCP.ValParcela;
        end;
        for VpfLacoParcela := 0 to VpfDDia.ChequesCP.Count - 1 do
        begin
          VpfDCheque := TRBDCheque(VpfDDia.ChequesCP.Items[VpfLacoParcela]);
          VpfDDia.ValChequesCP := VpfDDia.ValChequesCP + VpfDCheque.ValCheque;
          VpfDDiaFluxo.ValChequesCP := VpfDDiaFluxo.ValChequesCP + VpfDCheque.ValCheque;
          VpfDMes.ValChequesCP := VpfDMes.ValChequesCP + VpfDCheque.ValCheque;
          VpfDDia.ValTotalDespesa := VpfDDia.ValTotalDespesa + VpfDCheque.ValCheque;
          VpfDDiaFluxo.ValTotalDespesa := VpfDDiaFluxo.ValTotalDespesa + VpfDCheque.ValCheque;
          VpfDMes.ValTotalDespesa := VpfDMes.ValTotalDespesa + VpfDCheque.ValCheque;
          VpfDConta.ValTotalDespesas := VpfDConta.ValTotalDespesas + VpfDCheque.ValCheque;
          VpfDMes.ValTotalDespesaAcumulada := VpfDMes.ValTotalDespesaAcumulada +VpfDCheque.ValCheque ;
          VpfDDia.ValTotalDespesaAcumulada := VpfDDia.ValTotalDespesaAcumulada + VpfDCheque.ValCheque ;
          VpfDConta.ValTotalDespesasAcumuladas := VpfDConta.ValTotalDespesasAcumuladas + VpfDCheque.ValCheque;
          VpfDMes.ValTotalAcumulado := VpfDMes.ValTotalAcumulado - VpfDCheque.ValCheque;
        end;

        VpfDDia.Valtotal := VpfDDia.ValTotalReceita - VpfDDia.ValTotalDespesa;
        VpfDDiaFluxo.Valtotal := VpfDDiaFluxo.ValTotalReceita - VpfDDiaFluxo.ValTotalDespesa;
        VpfDDia.ValTotalAcumulado := VpfDDia.ValTotalAcumulado + VpfDDia.Valtotal;
      end;
    end;
    ValSaldoAnteriorCR := ValSaldoAnteriorCR + VpfDConta.ValSaldoAnteriorCR + VpfDConta.ValChequeCRSaldoAnterior;
    ValSaldoAnteriorCP := ValSaldoAnteriorCP + VpfDConta.ValSaldoAnteriorCP + VpfDConta.ValChequeCPSaldoAnterior;
  end;
  OrdenaDias(Dias);
  ValTotalAcumulado := ValAplicacao + ValSaldoAtual +ValChequeCRSaldoAnterior+ ValSaldoAnteriorCR - ValChequeCPSaldoAnterior - ValSaldoAnteriorCP;
  for VpfLacoDia := 0 to Dias.Count - 1 do
  begin
    VpfDDiaFluxo := TRBDFluxoCaixaDia(dias.Items[VpfLacoDia]);
    ValTotalAcumulado := ValTotalAcumulado + VpfDDiaFluxo.Valtotal;
    VpfDDiaFluxo.ValTotalAcumulado := ValTotalAcumulado;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaDia.cria;
begin
  inherited create;
  ParcelasCR := TList.create;
  ParcelasCP := TList.Create;
  ParcelasDuvidosas := TList.create;
  ChequesCR := TList.create;
  ChequesCP := TList.create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaDia.destroy;
begin
  FreeTObjectsList(ParcelasCR);
  ParcelasCR.free;
  FreeTObjectsList(ParcelasCP);
  ParcelasCP.Free;
  FreeTObjectsList(ParcelasDuvidosas);
  ParcelasDuvidosas.Free;
  FreeTObjectsList(ChequesCR);
  ChequesCR.free;
  FreeTObjectsList(ChequesCP);
  ChequesCP.free;
  inherited destroy;
end;


{******************************************************************************}
function TRBDFluxoCaixaDia.addParcelaCR : TRBDParcelaBaixaCR;
begin
  result := TRBDParcelaBaixaCR.cria;
  ParcelasCR.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaDia.addParcelaDuvidosa: TRBDParcelaBaixaCR;
begin
  result := TRBDParcelaBaixaCR.cria;
  ParcelasDuvidosas.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaDia.AddChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
var
  VpfLaco : Integer;
  VpfInseriu : Boolean;
begin
  VpfInseriu := false;

  result := TRBDCheque.cria;
  result.DatVencimento := VpaDatVencimento;

  for VpfLaco := 0 to ChequesCR.Count - 1 do
  begin
    if VpaDatVencimento < TRBDCheque(ChequesCR).DatVencimento then
    begin
      ChequesCR.Insert(VpfLaco,Result);
      VpfInseriu := true;
    end;
  end;
  if not VpfInseriu then
    ChequesCR.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaDia.AddParcelaCP: TRBDParcelaCP;
begin
  result := TRBDParcelaCP.cria;
  ParcelasCP.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaDia.AddChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
var
  VpfLaco : Integer;
  VpfInseriu : Boolean;
begin
  VpfInseriu := false;

  result := TRBDCheque.cria;
  result.DatVencimento := VpaDatVencimento;

  for VpfLaco := 0 to ChequesCP.Count - 1 do
  begin
    if VpaDatVencimento < TRBDCheque(ChequesCP).DatVencimento then
    begin
      ChequesCP.Insert(VpfLaco,Result);
      VpfInseriu := true;
    end;
  end;
  if not VpfInseriu then
    ChequesCP.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCaixaFormaPagamento.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCaixaFormaPagamento.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

constructor TRBDCaixaItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCaixaItem.Destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCaixa.cria;
begin
  inherited create;
  Items := TList.create;
  FormasPagamento := TList.Create;
end;

{******************************************************************************}
destructor TRBDCaixa.destroy;
begin
  FreeTObjectsList(Items);
  FreeTObjectsList(FormasPagamento);
  Items.free;
  FormasPagamento.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDCaixa.AddCaixaItem : TRBDCaixaItem;
begin
  result := TRBDCaixaItem.cria;
  Items.add(result);
end;

{******************************************************************************}
function TRBDCaixa.AddFormaPagamento : TRBDCaixaFormaPagamento;
begin
  result := TRBDCaixaFormaPagamento.cria;
  FormasPagamento.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDDERCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDDERVendedor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDDERVendedor.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDDERCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDDERCorpo.Cria;
begin
  inherited create;
  Vendedores := TList.Create;
end;

{******************************************************************************}
destructor TRBDDERCorpo.destroy;
begin
  FreeTObjectsList(Vendedores);
  Vendedores.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDDERCorpo.addVendedor : TRBDDERVendedor;
begin
  result := TRBDDERVendedor.cria;
  Vendedores.add(result);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDParcelaBaixaCR.Cria;
begin
  inherited Create;
  ValAcrescimo:= 0;
  ValDesconto:= 0;
  IndValorQuitaEssaParcela := true;
  IndGeraParcial := false;
end;

{******************************************************************************}
destructor TRBDParcelaBaixaCR.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                    TRBDBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDBaixaCP.Cria;
begin
  inherited Create;
  Parcelas:= TList.Create;
  Cheques := TList.Create;
  Caixas := TList.Create;
  ValParaGerardeDebito := 0;
end;

{******************************************************************************}
destructor TRBDBaixaCP.Destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.Free;
  FreeTObjectsList(Cheques);
  Cheques.free;
  FreeTObjectsList(Caixas);
  Caixas.free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDBaixaCP.AddParcela: TRBDParcelaCP;
begin
  Result:=  TRBDParcelaCP.Cria;
  Parcelas.Add(Result);
end;

{******************************************************************************}
function TRBDBaixaCP.AddCheque : TRBDCheque;
begin
  result := TRBDCheque.cria;
  Cheques.add(result);
end;

{******************************************************************************}
function TRBDBaixaCP.AddCaixa : TRBDCaixa;
begin
  result := TRBDCaixa.cria;
  Caixas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                    TRBDBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDBaixaCR.Cria;
begin
  inherited Create;
  Parcelas:= TList.Create;
  Cheques := TList.Create;
  Caixas := TList.Create;
  IndBaixaRetornoBancario := false;
  IndDesconto := false;
  IndBaixaUtilizandoOCreditodoCliente := false;
  ValParaGerardeCredito := 0;
end;

{******************************************************************************}
destructor TRBDBaixaCR.Destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.Free;
  FreeTObjectsList(Cheques);
  Cheques.free;
  FreeTObjectsList(Caixas);
  Caixas.free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDBaixaCR.AddParcela: TRBDParcelaBaixaCR;
begin
  Result:=  TRBDParcelaBaixaCR.Cria;
  Parcelas.Add(Result);
end;

{******************************************************************************}
function TRBDBaixaCR.AddCheque : TRBDCheque;
begin
  result := TRBDCheque.cria;
  Cheques.add(result);
end;

{******************************************************************************}
function TRBDBaixaCR.AddCaixa : TRBDCaixa;
begin
  result := TRBDCaixa.cria;
  Caixas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Parcela Baixa CP
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDParcelaCP.Cria;
begin
  inherited Create;
  ValAcrescimo:= 0;
  ValDesconto:= 0;
  IndValorQuitaEssaParcela := true;
  IndGeraParcial := false;
end;

{******************************************************************************}
destructor TRBDParcelaCP.Destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ComissaoItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDContasaPagar.Cria;
begin
  inherited;
  IndEsconderConta := false;
  Parcelas := TList.create;
  DespesaProjeto := TList.create;
end;

{******************************************************************************}
destructor TRBDContasaPagar.Destroy;
begin
  FreeTObjectsList(DespesaProjeto);
  FreeTObjectsList(Parcelas);
  DespesaProjeto.free;
  Parcelas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContasaPagar.addDespesaProjeto: TRBDContasaPagarProjeto;
begin
  result := TRBDContasaPagarProjeto.cria;
  DespesaProjeto.add(result);
end;

{******************************************************************************}
function TRBDContasaPagar.addParcela : TRBDParcelaCP;
begin
  result := TRBDParcelaCP.cria;
  Parcelas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ComissaoItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComissaoItem.cria;
begin
  Inherited create;
  IndLiberacaoAutomatica := false;
end;

{******************************************************************************}
destructor TRBDComissaoItem.destroy;
begin

  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da Comissao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComissao.cria;
begin
  inherited Create;
  Parcelas := TList.create;
end;

{******************************************************************************}
destructor TRBDComissao.destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDComissao.AddParcela : TRBDComissaoItem;
begin
  result := TRBDComissaoItem.cria;
  Parcelas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ecobrancaitem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDECobrancaItem.cria;
begin
  inherited create;

end;

{******************************************************************************}
destructor TRBDECobrancaitem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ecobrancacorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDECobrancaCorpo.cria;
begin
  inherited create;
  Items := TList.create;
end;

{******************************************************************************}
destructor TRBDECobrancaCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDECobrancaCorpo.AddECobrancaItem : TRBDECobrancaItem;
begin
  Result := TRBDECobrancaItem.cria;
  Items.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da forma de pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFormaPagamento.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFormaPagamento.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Dados da parcela da nova contas a receber
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDMovContasCR.cria;
begin
  inherited create;
  ValDesconto := 0;
  ValSinal := 0;
  DiasCompensacao := 0;
end;

{******************************************************************************}
destructor TRBDMovContasCR.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da nova contas a receber
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
constructor TRBDContasCR.cria;
begin
  inherited create;
  Parcelas := TList.create;
  MostrarParcelas := false;
  EsconderConta := false;
  SeqParcialCotacao := 0;
  LanOrcamento := 0;
  ValSinal := 0;
  IndCobrarFormaPagamento := false;
  IndDevolucao := false;
  IndSinalPagamento := false;
  IndPossuiSinalPagamento := false;
end;

{******************************************************************************}
destructor TRBDContasCR.destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContasCR.AddParcela : TRBDMovContasCR;
begin
  result := TRBDMovContasCR.Cria;
  Parcelas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados do Cheque
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCheque.cria;
begin
  SeqCheque := 0;
end;

{******************************************************************************}
destructor TRBDCheque.destroy;
begin
  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Dados da condicao de pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDCondicaoPagamento.AddParcela: TRBDparcelaCondicaoPagamento;
begin
  result := TRBDParcelaCondicaoPagamento.cria;
  Parcelas.add(result);
end;

{******************************************************************************}
constructor TRBDCondicaoPagamento.cria;
begin
  inherited create;
  Parcelas := TList.Create;
end;

{******************************************************************************}
destructor TRBDCondicaoPagamento.destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.free;
  inherited;
end;
{ TRBDCondicaoPagamento }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRBDPercentuaisCondicaoPagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDParcelaCondicaoPagamento.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDParcelaCondicaoPagamento.destroy;
begin

  inherited;
end;
{ TRBDPercentuaisCondicaoPagamento }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRBDPercentuaisCondicaoPagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCondicaoPagamentoGrupoUsuario.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCondicaoPagamentoGrupoUsuario.destroy;
begin
  inherited;
end;
{ TRBDCondicaoPagamentoGrupoUsuario }


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    dados da classe do contas a pagar do projeto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContasaPagarProjeto.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDContasaPagarProjeto.destroy;
begin

  inherited;
end;

{ TRBDContasaPagarProjeto }


{******************************************************************************}
{ TRBDTransferenciaExterna }
{******************************************************************************}

{******************************************************************************}
function TRBDTransferenciaExterna.AddFormaPagamento: TRBDTransferenciaExternaFormaPagamento;
begin
  result := TRBDTransferenciaExternaFormaPagamento.cria;
  FormasPagamento.Add(result);
end;

{******************************************************************************}
constructor TRBDTransferenciaExterna.cria;
begin
  inherited create;
  FormasPagamento := TList.Create;
end;

{******************************************************************************}
destructor TRBDTransferenciaExterna.destroy;
begin
  FreeTObjectsList(FormasPagamento);
  FormasPagamento.Free;
  inherited;
end;

{******************************************************************************}
{ TRBDTransferenciaExternaFormaPagamento }
{******************************************************************************}

{******************************************************************************}
function TRBDTransferenciaExternaFormaPagamento.addCheque: TRBDTransferenciaExternaCheques;
begin
  result := TRBDTransferenciaExternaCheques.cria;
  Cheques.Add(Result);
end;

{******************************************************************************}
constructor TRBDTransferenciaExternaFormaPagamento.cria;
begin
  inherited create;
  IndPossuiCheques := false;
  Cheques := TList.Create;
end;

{******************************************************************************}
destructor TRBDTransferenciaExternaFormaPagamento.destroy;
begin
  FreeTObjectsList(Cheques);
  Cheques.Free;
  inherited;
end;

{******************************************************************************}
{ TRBDTransferenciaExternaCheques }
{******************************************************************************}

{******************************************************************************}
constructor TRBDTransferenciaExternaCheques.cria;
begin
  inherited create;

end;

{******************************************************************************}
destructor TRBDTransferenciaExternaCheques.destroy;
begin

  inherited;
end;


end.
