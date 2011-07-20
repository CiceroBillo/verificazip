unit UnContasAPagar;
{Verificado
-.edit;
-.post;
}
interface

uses
    Db, DBTables, classes, sysUtils, painelGradiente, UnDadosProduto, UnDados, UnDadosCR,
    UnCaixa, UnClientes, SQLExpr,Tabela;



// calculos
type
  TCalculosContasAPagar = class
  private
     calcula : TSQLQuery;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection  ); virtual;
    destructor destroy; override;
    function SomaTotalParcelas(VpaCodFilial,VpaLanPagar : Integer ) : Double;overload;
    function somaTotalParcelas(VpaDContasAPagar : TRBDContasaPagar) : Double;overload;
end;

// localizacao
Type
  TLocalizaContasAPagar = class(TCalculosContasAPagar)
  public
    procedure LocalizaParcela(VpaTabela : TDataSet; VpaCodFilial, VpaLancamento, VpaNumParcela : integer);
    procedure LocalizaContaCP(VpaTabela : TDataSet; VpaCodFilial, VpaLanPagar : Integer);
    procedure LocalizaParcelasSemParciais(tabela : TSQLQUERY; lancamento : Integer);
    procedure LocalizaParcelasComParciais(VpaTabela : TDataSet; VpaCodFilial, VpaLancamento : Integer);
    procedure LocalizaJoinContaParcelas(tabela : TSQLQUERY; lancamento : Integer; CampoOrderBy : string);
    procedure LocalizaMov(tabela : TDataSet);
    procedure LocalizaCad(tabela : TSQLQUERY);
    procedure LocalizaParcelasAbertas(VpaTabela : TSQLQUERY;  VpaLanPagar : Integer; VpaCampoOrderBy : string);
    procedure LocalizaParcelaAberta(VpaTabela : TSQLQUERY; VpaLanPagar, VpaNumParcela : Integer );
    procedure LocalizaFormaPagamento(VpaTabela : TSQLQUERY; VpaCodFormaPagto : integer );

end;

// funcoes
type
  TFuncoesContasAPagar = class(TLocalizaContasAPagar)
  private
    Aux,
    Tabela : TSQLQuery;
    Cadastro,
    Cadastro2 : TSQL;
    VprBaseDados : TSQlConnection;
    function EstornaParcelaParcial(VpaCodFilial, VpaLanPagar, VpaNumParcelaFilha : integer) : string;
    function RParcelaAGerarParcial(VpaDBaixa : TRBDBaixaCP): TRBDParcelaCP;
    function GeraParcelaParcial( VpaDBaixa : TRBDBaixaCP) : string;
    function GravaParcelaParcial(VpaDParcelaOriginal : TRBDParcelaCP;VpaValParcial : Double;VpaDatVencimento : TDateTime):string;
    function BaixaParcelaPagar(VpaDBaixa : TRBDBaixaCP;VpaDParcela : TRBDParcelaCP):string;
    function BaixaContasaPagarAutomatico(VpaDContasaPagar : TRBDContasaPagar) : string;
    procedure LocalizaChequesCP(VpaTabela : TSQLQUERY;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
    procedure CarDChequesCP(VpaListaCheques : TList;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
    procedure CarParcelasCheque(VpaParcelas : TList;VpaSeqCheque, VpaCodFilialOriginal, VpaLanPagarOriginal, VpaNumParcelaOriginal : Integer);
    function GravaDContasaPagar(VpaDContasAPagar : TRBDContasaPagar) : String;
    function GravaDParcelaPagar(VpaDContasAPagar : TRBDContasaPagar) : String;
    function RNumParcelas(VpaDBaixaCP : TRBDBaixaCP) : string;
    function FornecedorPossuiDebito(VpaCreditos : TList;VpaTipo : TRBDTipoCreditoDebito) : Boolean;
    function BaixaParcelacomDebitoFornecedor(VpaDContasaPagar : TRBDContasaPagar; VpaCredito : TList):string;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); override;
    destructor Destroy; override;
    procedure CarDContasaPagar(VpaDContasaPagar : TRBDContasaPagar;VpaCodFilial,VpaLanPagar : Integer;VpaCarregarParcelas : Boolean);
    procedure CarDContasaPagarParcela(VpaDContasaPagar : TRBDContasaPagar;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
    function GravaDParcelaCP(VpaDParcelaCP : TRBDParcelaCP) : String;
    function GravaDChequeCP(VpaParcelas, VpaCheques : TList):string;

    // gera parcela
    function CriaContaPagar(VpaDContasaPagar : TRBDContasaPagar;VpaDCliente : TRBDCliente) : string;
    procedure CriaParcelas( VpaDContasaPagar : TRBDContasaPagar );
    procedure AtualizaValorTotal(VpaCodfilial, VpaLanPagar : integer );
    function VerificaAtualizaValoresParcelas(ValorInicialParcelas : double; lancamento : Integer ) : boolean;
    procedure AjustaValorUltimaParcela(VpaDContasAPagar : TRBDContasaPagar;VpaValorInicial : Double);

    // baixa parcela
    function BaixaContasAPagar(VpaDBaixa : TRBDBaixaCP) : string;
    function GeraNroProximoParcela(VpaCodFilial,VpaLancamento : Integer) : Integer;
    procedure CalculaValorTotalBaixa(VpaDBaixa : TRBDBaixaCP);
    function VerificaSeValorPagoQuitaTodasDuplicatas(VpaDBaixa : TRBDBaixaCP;VpaValAReceber : Double) : String;
    function VerificaSeGeraParcial(VpaDBaixa : TRBDBaixaCP;VpaValAReceber : Double;VpaIndSolicitarData : Boolean) : String;
    function RValTotalCheques(VpaDBaixaCP : TRBDBaixaCP) : Double;
    function RValTotalParcelasBaixa(VpaDBaixaCP : TRBDBaixaCP) : Double;
    procedure DistribuiValAcrescimoDescontoNasParcelas(VpaDBaixa : TRBDBaixaCP);
    procedure CarDParcelaBaixa(VpaDParcela : TRBDParcelaCP;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
    function ValidaParcelaPagamento(VpaCodFilial, VpaLanPagar, VpaNumParcela : integer) : boolean;
    function PossuiChequeDigitado(VpaDBaixa : TRBDBaixaCP):Boolean;

    // estorno e exclusa de conta e titulos
    function TemParcelasPagas(VpaCodFilial,VpaLanPagar : Integer ): Boolean;
    function ExcluiConta(VpaCodFilial, VpaLanPagar : integer; VpaVerificarNotaFiscal : Boolean ) : string;
    function TemParcelas(VpaCodFilial,VpaLanPagamento: Integer): Boolean;
    function ExcluiTitulo(VpaCodFilial, VpaLanPagar, VpaNumParcela : Integer ) : string;
    function VerificacoesExclusaoCheque(VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer;VpaCheques : TList):string;
    function ExcluiChequesCP(VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer;VpaCheques : TList):string;
    function ValidaChequesCP(VpaCodFilial,VpaLanPagar,VpaNumparcela : Integer;Var VpaExisteCheques : Boolean):string;
    function EstornoParcela(VpaCodFilial, VpaLanPagar,VpaNumParcela, VpaNumParcelaFilha, VpaCodCliente : integer;VpaVerificarCheques : Boolean) : String;
    function EstornaParcela(VpaLancamentoCP, VpaLancamentoBancario, VpaNroParcela,VpaNroParcelaFilha : integer; VpaDataParcela : TDateTime; VpaFlagParcial : string ) : Boolean;
    function ValidaEstornoParcela( VpaLancamentoCP : integer; VpaDatPagamento : TDateTime; VpaFlagParcial : string ) : boolean;
    function EstornaCPChequeDevolvido(VpaCheques : TList) : string;
    function EstornaValorCPChequeDevolvido(VpaValCheque : Double; VpaParcelas : TList) : string;

    // adicionais
    function RetiraAdicionalConta(Lancamento, Parcela : Integer; ValorRetirar: Double) : Boolean;
    function VerificaContaReceberVinculada(VpaNroOrdem, VpaParcela: Integer): Boolean;
    procedure AlteraValorRecebidoCAB(VpaOrdem: Integer; VpaValor:Double);

    //retornos
    function GeraCPTarifasRetorno(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDRetornoItem : TRBDRetornoItem;VpaValor : Double;VpaDescricao,VpaPlanoContas : String) : String;
    // diversos
    procedure BaixaConta( Valor, valorDesconto, ValorAcrescimo : double; Data : TDateTime; lancamento, NroParcela : integer );
    procedure ConfiguraFormaPagto( FormaInicio, FormaFim, lancamento, Nroparcela : Integer; NroConta : string );
    function ExcluiContaNotaFiscal( SeqNota : integer ) : Boolean;
    procedure AtualizaFormaPagamento(LancamentoCP, ParcelaCP, CodigoFormaPagamento: string);
    function NotaPossuiParcelaPaga(VpaCodFilial, VpaSeqNota : Integer) : Boolean;
    function FlagBaixarContaFormaPagamento(VpaCodFormapagamento : Integer):Boolean;
    function ExisteCheque(VpaNumCheque : Integer;var VpaExisteVariosCheques : Boolean;VpaDCheque : TRBDCheque): Boolean;
    procedure CarParcelasCPCheque(VpaSeqCheque : Integer;VpaParcelas : TList);
    procedure InterpretaCodigoBarras(VpaDContasAPagar : TRBDContasaPagar;VpaCodBarras : String);
    function ValorProjetosMaiorQueContasaPagar(VpaDContasaPagar : TRBDContasaPagar;VpaValContasAPagar : Double):string;
    function RPercentualProjetoFaltante(VpaDContasAPagar : TRBDContasaPagar) : Double;
    function ProjetoDuplicado(VpaDContasAPagar : TRBDContasaPagar) : boolean;
    procedure ExcluiPlanoContas(VpaPlanoOrigem, VpaPlanoDestino : String);
    procedure CarDProjetoContasaPagar(VpaDContasAPagar : TRBDContasaPagar);
    function GravaDDespesaProjeto(VpaDContasAPagar : TRBDContasaPagar) : String;
    function MarcaProrrogado(VpaCodFilial,VpaLanPagar, VpaNumParcela : Integer;VpaMarcarProrrogado : boolean):string;
    function RValPrevistoPlanoContas(VpaCodEmpresa, VpaCodCentroCusto : Integer;VpaCodPlanoContas : String;VpaDatInicio, VpaDatFim : TDateTime) : double;
  end;

var
  FunContasAPagar : TFuncoesContasAPagar;

implementation

uses constMsg, constantes, funSql, funstring, fundata, FunNumeros,AMostraParPagarOO,
      AChequesCP, UnContasAReceber, FunObjeto,ABaixaContasaPagarOO, UnSistema;


{#############################################################################
                        TCalculo Contas a Pagar
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosContasAPagar.criar( aowner : TComponent; VpaBaseDados : TSQLConnection  );
begin
  inherited;
  calcula := TSQLQuery.Create(aowner);
  calcula.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosContasAPagar.destroy;
begin
  Calcula.close;
  calcula.Destroy;
  inherited;
end;

{ *************************************************************************** }
function TCalculosContasAPagar.SomaTotalParcelas(VpaDContasAPagar: TRBDContasaPagar): Double;
var
  VpfLaco : Integer;
begin
  result := 0;
  for VpfLaco := 0 to VpaDContasAPagar.Parcelas.Count - 1 do
  begin
    result := result + TRBDParcelaCP(VpaDContasAPagar.Parcelas.Items[VpfLaco]).ValParcela;
  end;
  VpaDContasAPagar.ValTotal := result;
end;

{ ******************* Soma Total das parcelas ****************************** }
function TCalculosContasAPagar.SomaTotalParcelas(VpaCodFilial,VpaLanPagar : Integer ) : Double;
begin
  AdicionaSQLAbreTabela(calcula,
    ' select sum(N_VLR_DUP) as valorDup from MovContasaPagar ' +
    ' where I_LAN_APG = '  + IntToStr(VpaLanPagar) +
    ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial) );      // <> canceladas
  Result := calcula.fieldByName('valorDup').AsCurrency;
  FechaTabela(calcula);
end;


{#############################################################################
                        TLocaliza Contas a Pagar
#############################################################################  }

{ ******************** localiza uma parcela ********************************* }
procedure TLocalizaContasAPagar.LocalizaParcela(VpaTabela : TDataSet; VpaCodFilial, VpaLancamento, VpaNumParcela : integer);
begin
  AdicionaSQLAbreTabela( VpaTabela,' select * from MOVCONTASAPAGAR ' +
                                ' Where I_EMP_FIL = ' +  IntToStr(VpaCodfilial)+
                                ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela)+
                                ' and I_LAN_APG = ' + IntToStr(VpaLancamento));
end;

{ ****************** localiza uma conta ************************************ }
procedure TLocalizaContasAPagar.LocalizaContaCP(VpaTabela : TDataset; VpaCodFilial, VpaLanPagar : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,' select * from CadContasaPagar ' +
                  ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                  ' and I_LAN_APG = '  + IntToStr(VpaLanPagar));
end;

{*********************** localiza parcelas sem parciais ********************** }
procedure TLocalizaContasAPagar.LocalizaParcelasSemParciais(tabela : TSQLQUERY; lancamento : Integer);
begin
  AdicionaSQLAbreTabela(tabela,
    ' select * from MovContasaPagar ' +
    ' where i_lan_apg = ' + IntToStr(Lancamento) +
    ' and i_emp_fil = ' + Inttostr(varia.CodigoEmpFil) +
    ' and c_fla_par = ''N''' +     // parcelas parciais
    ' order by i_nro_par' );
end;


{*********************** localiza parcelas com parciais ********************** }
procedure TLocalizaContasAPagar.LocalizaParcelasComParciais(VpaTabela : TDataSet; VpaCodFilial, VpaLancamento : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,
    ' select * from MovContasaPagar ' +
    ' where i_lan_apg = ' + IntToStr(VpaLancamento) +
    ' and i_emp_fil = ' + Inttostr(VpaCodFilial) +
    ' order by i_nro_par' );
end;

procedure TLocalizaContasAPagar.LocalizaJoinContaParcelas(tabela : TSQLQUERY; lancamento : Integer; CampoOrderBy : string);
begin
  AdicionaSQLAbreTabela(tabela,
    ' select * from MovContasaPagar as MCP, CadContasapagar as CP '+
    ' where ' +
    ' CP.I_LAN_APG = ' + IntToStr(lancamento) +
    ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
    ' and CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
    ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
    ' order by MCP.'+ CampoOrderBy );
end;

procedure TLocalizaContasAPagar.LocalizaMov(tabela : TDataSet);
begin
  AdicionaSQLAbreTabela(tabela, 'select * from MovContasaPagar');
end;

procedure TLocalizaContasAPagar.LocalizaCad(tabela : TSQLQUERY);
begin
  AdicionaSQLAbreTabela(tabela, 'select * from CadContasapagar');
end;

{******************************************************************************}
procedure TLocalizaContasAPagar.LocalizaParcelasAbertas(VpaTabela : TSQLQUERY; VpaLanPagar : Integer; VpaCampoOrderBy : string);
begin
  AdicionaSQLAbreTabela(VpaTabela,' select * from MovContasaPagar as MCP '+
    ' where I_LAN_APG = ' + IntToStr(VpaLanPagar) +
    ' and I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
    ' and D_DAT_PAG is null ' +
    ' order by ' + VpaCampoOrderBy );
end;

{******************************************************************************}
procedure TLocalizaContasAPagar.LocalizaParcelaAberta(VpaTabela : TSQLQUERY; VpaLanPagar, VpaNumParcela : Integer );
begin
  AdicionaSQLAbreTabela(Vpatabela,' select * from MOVCONTASAPAGAR ' +
    ' where I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
    ' and I_LAN_APG = ' + IntToStr(VpaLanPagar) +
    ' and D_DAT_PAG is null ' +
    ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela));
end;

{******************************************************************************}
procedure TLocalizaContasAPagar.LocalizaFormaPagamento(VpaTabela : TSQLQUERY; VpaCodFormaPagto : integer );
begin
  AdicionaSQLAbreTabela( VpaTabela, ' select *  from CadFormasPagamento ' +
                                 ' where i_cod_frm =  ' + InttoStr(VpaCodFormaPagto) );
end;

{#############################################################################
                        TFuncoes Contas a Pagar
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesContasAPagar.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  VprBaseDados  := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(aowner);
  Tabela.SQLConnection := VpaBaseDados;
  Cadastro := tSQL.create(aowner);
  Cadastro.ASQLConnection := VpaBaseDados;
  Cadastro2 := tSQL.create(aowner);
  Cadastro2.ASQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesContasAPagar.Destroy;
begin
  FechaTabela(tabela);
  Tabela.Destroy;
  Cadastro.free;
  Cadastro2.free;
  Aux.free;
  inherited;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.CarDContasaPagar(VpaDContasaPagar : TRBDContasaPagar;VpaCodFilial,VpaLanPagar : Integer;VpaCarregarParcelas : Boolean);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADCONTASAPAGAR '+
                                 ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                 ' and I_LAN_APG = ' + IntToStr(VpaLanPagar));
  VpaDContasAPagar.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
  VpaDContasAPagar.CodCondicaoPagamento := Tabela.FieldByName('I_COD_PAG').AsInteger;
  VpaDContasAPagar.CodCentroCusto := Tabela.FieldByName('I_COD_CEN').AsInteger;
  VpaDContasAPagar.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
  VpaDContasAPagar.DesPathFoto := Tabela.FieldByName('C_PAT_FOT').AsString;
  VpaDContasAPagar.NumNota := Tabela.FieldByName('I_NRO_NOT').AsInteger;
  VpaDContasAPagar.SeqNota := Tabela.FieldByName('I_SEQ_NOT').AsInteger;
  VpaDContasAPagar.CodFornecedor := Tabela.FieldByName('I_COD_CLI').AsInteger;
  VpaDContasAPagar.ValTotal := Tabela.FieldByName('N_VLR_TOT').AsFloat;
  VpaDContasAPagar.CodPlanoConta := Tabela.FieldByName('C_CLA_PLA').AsString;
  VpaDContasAPagar.LanPagar := Tabela.FieldByName('I_LAN_APG').AsInteger;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.CarDContasaPagarParcela(VpaDContasaPagar : TRBDContasaPagar;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
begin
  CarDContasaPagar(VpaDContasaPagar,VpaCodFilial,VpaLanPagar,false);
  CarDParcelaBaixa(VpaDContasaPagar.addParcela,VpaCodFilial,VpaLanPagar,VpaNumParcela);
  VpaDContasaPagar.ValTotal := TRBDParcelaCP(VpaDContasaPagar.Parcelas.Items[0]).ValParcela;
end;

{******************************************************************************}
function TFuncoesContasAPagar.GravaDParcelaCP(VpaDParcelaCP : TRBDParcelaCP) : String;
begin
  result := '';
  if VpaDParcelaCP.ValPago = 0 then
    result := EstornaParcelaParcial(VpaDParcelaCP.CodFilial,VpaDParcelaCP.LanPagar,VpaDParcelaCP.NumParcelaParcial);

  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASAPAGAR '+
                                 ' Where I_EMP_FIL = ' +IntToStr(VpaDParcelaCP.CodFilial)+
                                 ' AND I_LAN_APG = ' +  IntToStr(VpaDParcelaCP.LanPagar)+
                                 ' AND I_NRO_PAR = ' +IntToStr(VpaDParcelaCP.NumParcela));
  Cadastro.edit;
  if VpaDParcelaCP.NumContaCorrente <> '' then
    Cadastro.FieldByname('C_NRO_CON').AsString := VpaDParcelaCP.NumContaCorrente
  else
    Cadastro.FieldByname('C_NRO_CON').clear;

  Cadastro.FieldByname('I_COD_FRM').AsInteger := VpaDParcelaCP.CodFormaPagamento;
  if VpaDParcelaCP.ValPago <> 0 then
    Cadastro.FieldByname('N_VLR_PAG').AsFloat := VpaDParcelaCP.ValPago
  else
  begin
    Cadastro.FieldByname('N_VLR_PAG').Clear;
    Cadastro.FieldByname('D_DAT_PAG').Clear;
  end;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{########################## na criacaco das parcelas ######################### }

{************************ Cria uma nova conta completa *********************** }
function TFuncoesContasAPagar.CriaContaPagar(VpaDContasaPagar : TRBDContasaPagar;VpaDCliente : TRBDCliente) : string;
var
  VpfCreditoCliente : TList;
begin
  result := '';
  VpfCreditoCliente := TList.create;
  CriaParcelas(VpaDContasaPagar);
   // formas de pagamento
  if (VpaDContasaPagar.CodCondicaoPagamento = Varia.CondPagtoVista) and
     ((VpaDContasaPagar.DesTipFormaPagamento = 'D') or
     (VpaDContasaPagar.DesTipFormaPagamento = 'T') or (VpaDContasaPagar.DesTipFormaPagamento = 'E')) then  // caso par 1 e =  dinheiro, cartao, cheque eletronico naum chamar detalhes
     VpaDContasaPagar.IndMostrarParcelas := false;

   // detalhes do cheque, boleto, etc
  if VpaDContasaPagar.IndMostrarParcelas then
  begin
     FMostraParPagarOO := TFMostraParPagarOO.CriarSDI(nil,'',true);
     if not FMostraParPagarOO.MostraParcelas(VpaDContasaPagar) then
       result := 'FINANCEIRO CANCELADO!!!'#13'A operação foi cancelada porque o financeiro foi cancelado.';
     FMostraParPagarOO.free;
  end;
  if  (result = '') then
  begin
    result := GravaDContasaPagar(VpaDContasaPagar);
    if result = '' then
    begin
      if VpaDContasaPagar.IndBaixarConta then
      begin
        result := BaixaContasaPagarAutomatico(VpaDContasaPagar);
      end;
      if result = '' then
      begin
        if config.ControlarDebitoeCreditoCliente then
        begin
          VpaDContasaPagar.ValUtilizadoCredito := 0;
          FunClientes.CarCreditoCliente(VpaDContasaPagar.CodFornecedor,VpfCreditoCliente,true,dcDebito);
          if FornecedorPossuiDebito(VpfCreditoCliente,dcDebito) then
          begin
            if confirmacao('FORNECEDOR POSSUI DÉBITO!!!'#13'Esse fornecedor possui um débito de "'+ FormatFloat('R$ #,###,###,##0.00',FunContasAReceber.RValTotalCredito(VpfCreditoCliente,dcDebito))+
                           '".Deseja utilizar o débito para quitar essa conta? ') then
              result := BaixaParcelacomDebitoFornecedor(VpaDContasaPagar,VpfCreditoCliente);
          end;
        end;
      end;

      if result = '' then
      begin
        if VpaDCliente <> nil then
        begin
          result := FunClientes.AtualizaCliente(VpaDCliente,VpaDContasAPagar);
        end;
      end;
    end;
  end;
  FreeTObjectsList(VpfCreditoCliente);
  VpfCreditoCliente.free;
end;

{********* criacao das parcelas **********************************************}
procedure TFuncoesContasAPagar.CriaParcelas(VpaDContasaPagar : TRBDContasaPagar);
var
  VpfParcela, VpfDiaAtual : integer;
  VpfDParcela : TRBDParcelaCP;
  VpfDatVencimento : TDatetime;
begin
  FreeTObjectsList(VpaDContasaPagar.Parcelas);
  VpfDatVencimento := VpaDContasaPagar.DatEmissao;
  VpfParcela := 1;
  VpfDiaAtual := dia(VpfDatVencimento); // usado para modificar data fixa, nos dia (29,30,e 31 ) com vencimento sempre na data da compra
  AdicionaSQLAbreTabela(Tabela,'Select CAD.N_IND_REA, CAD.N_PER_DES, CAD.I_DIA_CAR, CAD.I_QTD_PAR, '+
                                        ' MOV.N_PER_PAG, MOV.N_PER_CON,'+
                                        ' MOV.C_CRE_DEB,MOV.D_DAT_FIX, MOV.I_DIA_FIX, MOV.I_NUM_DIA'+
                                        ' from CADCONDICOESPAGTO CAD, MOVCONDICAOPAGTO MOV '+
                                        ' Where CAD.I_COD_PAG = MOV.I_COD_PAG '+
                                        ' AND CAD.I_COD_PAG = '+ IntToStr(VpaDContasaPagar.CodCondicaoPagamento)+
                                        ' ORDER BY I_NRO_PAR');
  while not Tabela.Eof do
  begin
    VpfDParcela := VpaDContasaPagar.addParcela;
    VpfDParcela.CodFilial := VpaDContasaPagar.CodFilial;
    VpfDParcela.LanPagar := VpaDContasaPagar.LanPagar;
    VpfDParcela.NumParcela := VpfParcela;
    VpfDParcela.NumParcelaParcial := 0;
    VpfDParcela.CodCliente := VpaDContasaPagar.CodFornecedor;
    VpfDParcela.NomCliente := VpaDContasaPagar.NomFornecedor;
    VpfDParcela.CodFormaPagamento := VpaDContasaPagar.CodFormaPagamento;
    VpfDParcela.NumContaCorrente := VpaDContasaPagar.NumContaCaixa;
    VpfDParcela.NumNotaFiscal := VpaDContasaPagar.NumNota;
    VpfDParcela.NumDuplicata := IntToStr(VpaDContasaPagar.NumNota)+'/'+IntToStr(VpfParcela);
    VpfDParcela.DatEmissao := VpaDContasaPagar.DatEmissao;
    VpfDatVencimento := FunContasAReceber.CalculaVencimento(VpfDatVencimento,Tabela.FieldByName('I_NUM_DIA').AsInteger,
                       Tabela.FieldByName('I_DIA_FIX').AsInteger,Tabela.FieldByName('D_DAT_FIX').AsDateTime,
                       VpfDiaAtual);
    if VpfParcela = 1 then
    begin
      if VpaDContasaPagar.CodBarras <> '' then
      begin
        VpfDParcela.DatVencimento := IncDia(MontaData(7,10,1997),VpaDContasaPagar.FatorVencimento);
        VpfDParcela.CodBarras := VpaDContasaPagar.CodBarras;
      end
      else
        VpfDParcela.DatVencimento := VpfDatVencimento;
    end
    else
      VpfDParcela.DatVencimento := VpfDatVencimento;
    VpfDatVencimento := VpfDParcela.DatVencimento;
    VpfDParcela.DatPagamento := montadata(1,1,1900);
    VpfDParcela.ValParcela := VpaDContasaPagar.ValParcela;
    VpfDParcela.PerMora := Varia.Mora;
    VpfDParcela.PerJuros := Varia.Juro;
    VpfDParcela.PerMulta := Varia.Multa;
    VpfDParcela.IndContaOculta := VpaDContasaPagar.IndEsconderConta;
    inc(VpfParcela);
    Tabela.next;
  end;
  Tabela.close;
  AjustaValorUltimaParcela(VpaDContasaPagar,VpaDContasaPagar.ValTotal);
end;

{*************** atualiza o valor total do cadcontasapagar ***************** }
procedure TFuncoesContasAPagar.AtualizaValorTotal(VpaCodfilial, VpaLanPagar : integer );
begin
  LocalizaContaCP(Cadastro2,VpaCodFilial,VpaLanPagar);
  if not Cadastro2.eof then
  begin
    //atualiza a data de alteracao para poder exportar
    Cadastro2.edit;
    Cadastro2.FieldByname('D_ULT_ALT').AsDateTime := Date;
    Cadastro2.FieldByName('N_VLR_TOT').AsFloat :=  SomaTotalParcelas(VpaCodfilial,VpaLanPagar);
    Cadastro2.post;
  end;
  Cadastro2.close;
end;


{ ******  verifica se as parcelas possuem o mesmo valor do total da conta ****** }
function TFuncoesContasAPagar.VerificaAtualizaValoresParcelas(ValorInicialParcelas : double; lancamento : Integer ) : boolean;
var
  Total : double;
begin
  Total := SomaTotalParcelas(varia.CodigoEmpFil,Lancamento);
  Result := false;
  if Total <> ValorInicialParcelas then
  begin
      if not Confirmacao(CT_ValorDiferente + ' Nota = ' + FormatFloat(Varia.MascaraMoeda,ValorInicialParcelas) +
                         ' -> parcelas = ' + FormatFloat(varia.MascaraMoeda,Total) + '. Você deseja corrigir ?' ) then
       begin
          Result := True;
          AtualizaValorTotal(varia.CodigoEmpFil,lancamento);
       end;
  end
  else
     Result := True;
end;

{########################### baixa Parcela ##################################}

{******************************************************************************}
function TFuncoesContasAPagar.BaixaContasAPagar(VpaDBaixa : TRBDBaixaCP) : string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
  VpfValTotalParcelas : Double;
begin
  result := GeraParcelaParcial(VpaDBaixa);
  if result = '' then
  begin
    for vpflaco :=0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
      result := BaixaParcelaPagar(VpaDBaixa,VpfDParcela);
    end;
   if result = '' then
   begin
      result := FunContasAReceber.GravaDCheques(VpaDBaixa.Cheques);
   end;
    if result = '' then
    begin
      Result := GravaDChequeCP(VpaDBaixa.Parcelas,VpaDBaixa.Cheques);
      if result = '' then
      begin
        if config.ControlarDebitoeCreditoCliente then
        begin
          VpfValTotalParcelas := RValTotalParcelasBaixa(VpaDBaixa);
          if VpaDBaixa.ValorPago > VpfValTotalParcelas   then
          begin
            if confirmacao('VALOR PAGO A MAIOR!!!'#13'Está sendo pago um valor de "'+FormatFloat('R$ #,###,###,###,##0.00',VpaDBaixa.ValorPago - RValTotalParcelasBaixa(VpaDBaixa))+
                         '" a mais do que o valor da(s) parcela(s). Deseja gerar esse valor de debito com o fornecedor?') then
            begin
              result := FunClientes.AdicionaCredito(VpfDParcela.CodCliente,VpaDBaixa.ValorPago - VpfValTotalParcelas,'D','Referente valor pago a maior das parcelas "'+RNumParcelas(VpaDBaixa)+'"');
              VpaDBaixa.ValParaGerardeDebito := VpaDBaixa.ValorPago - VpfValTotalParcelas;
            end;
          end;
        end;

        if ConfigModulos.Caixa then
        begin
          result := FunCaixa.AdicionaBaixaCPCaixa(VpaDBaixa);
        end;
      end;
    end;
  end;
end;



{********* gera numero proxima parcela ************************************** }
function TFuncoesContasAPagar.GeraNroProximoParcela(VpaCodFilial,VpaLancamento : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Calcula,' select max(i_nro_par) I_NRO_PAR from MOVCONTASAPAGAR ' +
                                ' Where I_EMP_FIL = ' + IntTostr(Varia.CodigoEmpFil)+
                                ' and I_LAN_APG = ' + IntToStr(VpaLancamento));
  Result := Calcula.fieldByname('I_NRO_PAR').AsInteger + 1;
  FechaTabela(calcula);
end;


{******************************************************************************}
procedure TFuncoesContasAPagar.CalculaValorTotalBaixa(VpaDBaixa : TRBDBaixaCP);
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
begin
  VpaDBaixa.ValorPago := 0;
  VpaDBaixa.ValorAcrescimo := 0;
  VpaDBaixa.ValorDesconto := 0;
  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
    VpaDBaixa.ValorAcrescimo := VpaDBaixa.ValorAcrescimo + VpfDParcela.ValAcrescimo;
    VpaDBaixa.ValorDesconto := VpaDBaixa.ValorDesconto + VpfDParcela.ValDesconto;
    VpaDBaixa.ValorPago := VpaDBaixa.ValorPago + VpfDParcela.ValParcela;
   end;
   VpaDBaixa.ValorPago := VpaDBaixa.ValorPago + VpaDBaixa.ValorAcrescimo-VpaDBaixa.ValorDesconto;
end;

{******************************************************************************}
function TFuncoesContasAPagar.VerificaSeValorPagoQuitaTodasDuplicatas(VpaDBaixa : TRBDBaixaCP;VpaValAReceber : Double) : String;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
begin
  result := '';
  if VpaDBaixa.Parcelas.Count > 0 then
  begin
    for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
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
function TFuncoesContasAPagar.VerificaSeGeraParcial(VpaDBaixa : TRBDBaixaCP;VpaValAReceber : Double;VpaIndSolicitarData : Boolean) : String;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
begin
  result := '';
  VpaDBaixa.IndPagamentoParcial := false;
  VpaDBaixa.ValParcialFaltante := 0;
  if VpaDBaixa.Parcelas.Count > 0 then
  begin
    for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
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
function TFuncoesContasAPagar.RValPrevistoPlanoContas(VpaCodEmpresa, VpaCodCentroCusto: Integer;VpaCodPlanoContas: String; VpaDatInicio, VpaDatFim: TDateTime): double;
var
  VpfMesAtual : TDatetime;
  VpfAnoAtual : Integer;
begin
  result := 0;
  VpfMesAtual := VpaDatInicio;
  VpfAnoAtual := -999;

  while VpfMesAtual < VpaDatFim do
  begin
    if VpfAnoAtual <> ano(VpfMesAtual) then
    begin
      AdicionaSQLAbreTabela(Tabela,'Select * from PLANOCONTAORCADO ' +
                                   ' WHERE CODEMPRESA = ' +IntToStr(VpaCodEmpresa)+
                                   ' AND CODPLANOCONTA = '''+VpaCodPlanoContas+''''+
                                   ' AND ANOORCADO = '+ IntToStr(Ano(VpfMesAtual))+
                                   ' AND CODCENTROCUSTO = '+IntToStr(VpaCodCentroCusto));
      VpfAnoAtual := Ano(VpfMesAtual);
    end;
    case Mes(VpfMesAtual) of
      1 : result := result + Tabela.FieldByName('VALJANEIRO').AsFloat;
      2 : result := result + Tabela.FieldByName('VALFEVEREIRO').AsFloat;
      3 : result := result + Tabela.FieldByName('VALMARCO').AsFloat;
      4 : result := result + Tabela.FieldByName('VALABRIL').AsFloat;
      5 : result := result + Tabela.FieldByName('VALMAIO').AsFloat;
      6 : result := result + Tabela.FieldByName('VALJUNHO').AsFloat;
      7 : result := result + Tabela.FieldByName('VALJULHO').AsFloat;
      8 : result := result + Tabela.FieldByName('VALAGOSTO').AsFloat;
      9 : result := result + Tabela.FieldByName('VALSETEMBRO').AsFloat;
      10 : result := result + Tabela.FieldByName('VALOUTUBRO').AsFloat;
      11 : result := result + Tabela.FieldByName('VALNOVEMBRO').AsFloat;
      12 : result := result + Tabela.FieldByName('VALDEZEMBRO').AsFloat;
    end;
    VpfMesAtual := incmes(VpfMesAtual,1);
  end;
  Tabela.Close;
end;


{******************************************************************************}
function TFuncoesContasAPagar.RValTotalCheques(VpaDBaixaCP : TRBDBaixaCP) : Double;
var
  VpfLaco : Integer;
begin
  result := 0;
  for VpfLaco := 0 to VpaDBaixaCP.Cheques.Count - 1 do
    result := Result + TRBDCheque(VpaDBaixaCP.Cheques.Items[VpfLaco]).ValCheque;
end;

{******************************************************************************}
function TFuncoesContasAPagar.RValTotalParcelasBaixa(VpaDBaixaCP : TRBDBaixaCP) : Double;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
begin
  result := 0;
  for VpfLaco := 0 to VpaDBaixaCP.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaCP(VpaDBaixaCP.Parcelas.Items[VpfLaco]);
    result := result + VpfDParcela.ValParcela + VpfDParcela.ValAcrescimo - VpfDParcela.ValDesconto;
  end;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.DistribuiValAcrescimoDescontoNasParcelas(VpaDBaixa : TRBDBaixaCP);
Var
  VpfLaco : Integer;
  VpfValTotal,VpfPerSobreTotal : Double;
  VpfDParcela : TRBDParcelaCP;
begin
  VpfValTotal := 0;
  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
    VpfValTotal := VpfValTotal + VpfDParcela.ValParcela;
  end;

  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
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
procedure TFuncoesContasAPagar.CarDParcelaBaixa(VpaDParcela : TRBDParcelaCP;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, CAD.C_IND_CAD, '+
                                  ' CAD.I_QTD_PAR, '+
                                  ' MOV.I_COD_FRM, MOV.C_NRO_DUP, MOV.C_NRO_CON, MOV.L_OBS_APG ,'+
                                  ' MOV.D_DAT_VEN, MOV.N_VLR_DUP, MOV.N_PER_MOR, MOV.N_PER_JUR, '+
                                  ' MOV.N_PER_MUL, I_PAR_FIL, MOV.N_VLR_PAG, '+
                                  ' CLI.C_NOM_CLI, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' from CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV, CADCLIENTES CLI, '+
                                  ' CADFORMASPAGAMENTO FRM '+
                                  ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' and CAD.I_LAN_APG = MOV.I_LAN_APG '+
                                  ' and CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' and MOV.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' AND MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND MOV.I_LAN_APG = '+IntToStr(VpaLanPagar)+
                                  ' AND MOV.I_NRO_PAR = '+IntToStr(VpaNumParcela));
  VpaDParcela.CodFilial := VpaCodFilial;
  VpaDParcela.LanPagar := VpaLanPagar;
  VpaDParcela.NumParcela := VpaNumParcela;
  VpaDParcela.NumParcelaParcial := Tabela.FieldByname('I_PAR_FIL').AsInteger;
  VpaDParcela.NomCliente := Tabela.FieldByname('C_NOM_CLI').AsString;
  VpaDParcela.NomFormaPagamento := Tabela.FieldByname('C_NOM_FRM').AsString;
  VpaDParcela.DesObservacoes := Tabela.FieldByname('L_OBS_APG').AsString;
  VpaDParcela.CodCliente := Tabela.FieldByname('I_COD_CLI').AsInteger;
  VpaDParcela.CodFormaPagamento := Tabela.FieldByname('I_COD_FRM').AsInteger;
  VpaDParcela.QtdParcelas := Tabela.FieldByname('I_QTD_PAR').AsInteger;
  VpaDParcela.NumNotaFiscal := Tabela.FieldByname('I_NRO_NOT').AsInteger;
  VpaDParcela.NumDuplicata := Tabela.FieldByname('C_NRO_DUP').AsString;
  VpaDParcela.NumContaCorrente := Tabela.FieldByname('C_NRO_CON').AsString;
  VpaDParcela.DatEmissao := Tabela.FieldByname('D_DAT_EMI').AsDateTime;
  VpaDParcela.DatVencimento := Tabela.FieldByname('D_DAT_VEN').AsDateTime;
  VpaDParcela.ValParcela := Tabela.FieldByname('N_VLR_DUP').AsFloat;
  VpaDParcela.ValPago := Tabela.FieldByname('N_VLR_PAG').AsFloat;
  VpaDParcela.IndContaOculta := (Tabela.FieldByname('C_IND_CAD').AsString = 'S');
  VpaDParcela.PerMora := Tabela.FieldByname('N_PER_MOR').AsFloat;
  VpaDParcela.PerJuros := Tabela.FieldByname('N_PER_JUR').AsFloat;
  VpaDParcela.PerMulta := Tabela.FieldByname('N_PER_MUL').AsFloat;

  if Tabela.FieldByname('D_DAT_VEN').AsDateTime < date then
    VpaDParcela.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByname('D_DAT_VEN').AsDateTime,date)
  else
    VpaDParcela.NumDiasAtraso := 0;

  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.CarDProjetoContasaPagar(VpaDContasAPagar: TRBDContasaPagar);
Var
  VpfDDespesaProjeto : TRBDContasaPagarProjeto;
begin
  FreeTObjectsList(VpaDContasAPagar.DespesaProjeto);
  AdicionaSQLAbreTabela(Tabela,'Select PRO.CODPROJETO, PRO.NOMPROJETO, '+
                               ' CPP.VALDESPESA, CPP.PERDESPESA ' +
                               ' From PROJETO PRO, CONTAAPAGARPROJETO CPP ' +
                               ' WHERE PRO.CODPROJETO = CPP.CODPROJETO ' +
                               ' AND CPP.CODFILIAL = '+IntToStr( VpaDContasAPagar.CodFilial)+
                               ' AND CPP.LANPAGAR = '+IntToStr(VpaDContasAPagar.LanPagar)+
                               ' ORDER BY SEQDESPESA ');
  while not Tabela.Eof do
  begin
    VpfDDespesaProjeto := VpaDContasAPagar.addDespesaProjeto;
    VpfDDespesaProjeto.CodProjeto := Tabela.FieldByName('CODPROJETO').AsInteger;
    VpfDDespesaProjeto.NomProjeto := Tabela.FieldByName('NOMPROJETO').AsString;
    VpfDDespesaProjeto.PerDespesa := Tabela.FieldByName('PERDESPESA').AsFloat;
    VpfDDespesaProjeto.ValDespesa := Tabela.FieldByName('VALDESPESA').AsFloat;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.ValidaParcelaPagamento(VpaCodFilial, VpaLanPagar, VpaNumParcela : integer) : boolean;
begin
  result := true;
  if config.BaixaParcelaAntVazia then
  begin
    AdicionaSQLAbreTabela(Tabela,' select * from MOVCONTASAPAGAR '+
                         ' where i_emp_fil = '+ IntToStr(VpaCodFilial) +
                         ' and I_LAN_APG = ' + IntTostr(VpaLanPagar) +
                         ' and I_NRO_PAR < '+ IntToStr(VpaNumParcela)+
                         ' and d_dat_pag is null ');
    if not tabela.Eof then
    begin
      aviso(CT_ParcelaAntVAzia);
      result := false;
    end;
    tabela.close;
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.ValorProjetosMaiorQueContasaPagar(VpaDContasaPagar: TRBDContasaPagar;VpaValContasAPagar : Double): string;
var
  VpfValProjetos  : Double;
  VpfLaco : Integer;
begin
  result := '';
  VpfValProjetos := 0;
  for VpfLaco := 0 to VpaDContasaPagar.DespesaProjeto.Count - 1 do
  begin
    VpfValProjetos := VpfValProjetos + TRBDContasaPagarProjeto(VpaDContasaPagar.DespesaProjeto.Items[VpfLaco]).ValDespesa;
  end;
  if ArredondaDecimais(VpfValProjetos,2) > ArredondaDecimais(VpaValContasAPagar,2) then
  begin
    result := 'VALOR PROJETOS MAIOR QUE O VALOR DO CONTAS A PAGAR!!!'#13'O valor das depesas do projeto soma "'+FormatFloat('R$ #,###,###,##0.00',VpfValProjetos)+'" e o valor do contas a pagar é "'+FormatFloat('R$ #,###,###,##0.00',VpaValContasAPagar)+'"';
  end
  else
    if ArredondaDecimais(VpfValProjetos,2) < ArredondaDecimais(VpaValContasAPagar,2) then
      result := 'VALOR PROJETOS MENOR QUE O VALOR DO CONTAS A PAGAR!!!'#13'O valor das depesas do projeto soma "'+FormatFloat('R$ #,###,###,##0.00',VpfValProjetos)+'" e o valor do contas a pagar é "'+FormatFloat('R$ #,###,###,##0.00',VpaValContasAPagar)+'"';

end;

{******************************************************************************}
function TFuncoesContasAPagar.EstornaParcelaParcial(VpaCodFilial, VpaLanPagar, VpaNumParcelaFilha : integer) : string;
begin
  result := '';
  if VpaNumParcelaFilha <> 0 then
  begin
    AdicionaSQLAbreTabela(Cadastro,'select * from MOVCONTASAPAGAR '+
                                ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                                ' and I_LAN_APG = ' + IntToStr(VpaLanPagar) +
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
function TFuncoesContasAPagar.RParcelaAGerarParcial(VpaDBaixa : TRBDBaixaCP): TRBDParcelaCP;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
  begin
    if TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]).IndGeraParcial then
     result := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.RPercentualProjetoFaltante(VpaDContasAPagar: TRBDContasaPagar): Double;
var
  VpfPerProjetos : Double;
  VpfLaco : Integer;
begin
  result := 0;
  VpfPerProjetos := 0;
  for VpfLaco := 0 to VpaDContasaPagar.DespesaProjeto.Count - 1 do
    VpfPerProjetos := VpfPerProjetos + TRBDContasaPagarProjeto(VpaDContasaPagar.DespesaProjeto.Items[VpfLaco]).PerDespesa;
  if VpfPerProjetos < 100 then
    result := 100 - VpfPerProjetos;
end;

{******************************************************************************}
function TFuncoesContasAPagar.GeraParcelaParcial( VpaDBaixa : TRBDBaixaCP) : string;
var
  VpfDParcelaOriginal : TRBDParcelaCP;
begin
  result := '';
  if VpaDBaixa.IndPagamentoParcial then
  begin
    VpfDParcelaOriginal := RParcelaAGerarParcial(VpaDBaixa);
    result := GravaParcelaParcial(VpfDParcelaOriginal,VpaDBaixa.ValParcialFaltante,VpaDBaixa.DatVencimentoParcial);
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.GravaParcelaParcial(VpaDParcelaOriginal : TRBDParcelaCP;VpaValParcial : Double;VpaDatVencimento : TDateTime):string;
begin
  result := '';
  VpaDParcelaOriginal.NumParcelaParcial := GeraNroProximoParcela(VpaDParcelaOriginal.CodFilial,VpaDParcelaOriginal.LanPagar );
  //atualiza o numero da parcial na parcela mae
  LocalizaParcela(Cadastro2,VpaDParcelaOriginal.CodFilial, VpaDParcelaOriginal.LanPagar,VpaDParcelaOriginal.NumParcela);
  Cadastro2.edit;
  Cadastro2.FieldByName('I_PAR_FIL').AsInteger := VpaDParcelaOriginal.NumParcelaParcial;
  Cadastro2.post;

  LocalizaMov(Cadastro);
  Cadastro.insert;

  Cadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDParcelaOriginal.CodFilial;
  Cadastro.FieldByName('I_LAN_APG').AsInteger := VpaDParcelaOriginal.LanPagar;
  Cadastro.FieldByName('I_NRO_PAR').AsInteger := VpaDParcelaOriginal.NumParcelaParcial;
  Cadastro.FieldByName('D_DAT_VEN').AsDateTime := MontaData(dia(VpaDatVencimento),mes(VpaDatVencimento),ano(VpaDatVencimento));
  Cadastro.FieldByName('L_OBS_APG').AsString := Cadastro2.FieldByName('L_OBS_APG').AsString + ' - Lançamento originado da parcela ' + IntToStr(VpaDParcelaOriginal.NumParcela);
  Cadastro.FieldByName('N_VLR_DUP').AsFloat := VpaValParcial;
  Cadastro.FieldByName('I_COD_MOE').AsInteger := Cadastro2.FieldByName('I_COD_MOE').AsInteger;
  Cadastro.FieldByName('N_PER_MUL').AsFloat := Cadastro2.fieldByName('N_PER_MUL').AsCurrency;
  Cadastro.FieldByName('N_PER_MOR').AsFloat := Cadastro2.fieldByName('N_PER_MOR').AsCurrency;
  Cadastro.FieldByName('N_PER_JUR').AsFloat := Cadastro2.fieldByName('N_PER_JUR').AsCurrency;
  Cadastro.FieldByName('N_VLR_JUR').AsFloat := Cadastro2.fieldByName('N_VLR_JUR').AsFloat;
  Cadastro.FieldByName('N_VLR_MOR').AsFloat := Cadastro2.fieldByName('N_VLR_MOR').AsFloat;
  Cadastro.FieldByName('N_VLR_MUL').AsFloat := Cadastro2.fieldByName('N_VLR_MUL').AsFloat;
  if Cadastro2.FieldByName('C_NRO_CON').AsString <> '' then
    Cadastro.FieldByName('C_NRO_CON').AsString := Cadastro2.FieldByName('C_NRO_CON').AsString;
  Cadastro.FieldByName('C_FLA_PAR').AsString := 'S';
  Cadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('C_FLA_CHE').AsString := 'N';
  Cadastro.FieldByName('C_IMP_CHE').AsString := 'N';
  Cadastro.FieldByName('C_DES_PRR').AsString := 'N';
  Cadastro.FieldByName('I_COD_FRM').Asinteger := Cadastro2.fieldByName('I_COD_FRM').Asinteger;
  //atualiza a data de alteracao para poder exportar
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;

  if Cadastro2.fieldByName('C_NRO_DUP').AsString <> '' then
  begin
    Cadastro.FieldByName('C_NRO_DUP').AsString := Cadastro2.fieldByName('C_NRO_DUP').AsString + '/' + IntTostr(VpaDParcelaOriginal.NumParcelaParcial);
    Cadastro.FieldByName('C_NRO_DOC').AsString := Cadastro2.fieldByName('C_NRO_DOC').AsString + '/' + IntTostr(VpaDParcelaOriginal.NumParcelaParcial);
  end;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;

  Cadastro.close;
  Cadastro2.close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.GravaDChequeCP(VpaParcelas, VpaCheques : TList ):string;
var
  VpfLacoCheque, VpfLacoParcelas : Integer;
  VpfDCheque : TRBDCheque;
  VpfDParcela : TRBDParcelaCP;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHEQUECP'+
                                 ' Where SEQCHEQUE = 0 AND CODFILIALPAGAR = 0 '+
                                 ' AND LANPAGAR = 0 AND NUMPARCELA = 0 ');
  for VpfLacoCheque := 0 to VpaCheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLacoCheque]);
    if (VpfDCheque.TipFormaPagamento = fpChequeTerceiros) then //cheque de terceiros.
      result := FunContasAReceber.CompensaCheque(VpfDCheque,'D',false);
    if result = '' then
    begin
      for VpfLacoParcelas := 0 to VpaParcelas.Count - 1 do
      begin
        VpfDParcela := TRBDParcelaCP(VpaParcelas.Items[VpfLacoParcelas]);
        Cadastro.insert;
        Cadastro.FieldByname('SEQCHEQUE').AsInteger := VpfDCheque.SeqCheque;
        Cadastro.FieldByname('CODFILIALPAGAR').AsInteger := VpfDParcela.CodFilial;
        Cadastro.FieldByname('LANPAGAR').AsInteger := VpfDParcela.LanPagar;
        Cadastro.FieldByname('NUMPARCELA').AsInteger := VpfDParcela.NumParcela;
        Cadastro.post;
        result := Cadastro.AMensagemErroGravacao;
        if Cadastro.AErronaGravacao then
          break;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.LocalizaChequesCP(VpaTabela : TSQLQUERY;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select CHE.SEQCHEQUE, CHE.CODBANCO, CHE.CODFORMAPAGAMENTO,'+
                                  ' CHP.CODFILIALPAGAR, CHP.LANPAGAR, '+
                                  ' CHP.NUMPARCELA, CHE.NOMEMITENTE, CHE.NUMCHEQUE, CHE.DATCADASTRO, ' +
                                  ' CHE.DATVENCIMENTO, CHE.DATCOMPENSACAO, CHE.VALCHEQUE, CHE.DATDEVOLUCAO, '+
                                  ' CHE.DATALTERACAO, CHE.CODUSUARIO,CHE.NUMCONTACAIXA, CHE.TIPCHEQUE, '+
                                  ' FRM.C_NOM_FRM, FRM.C_FLA_TIP,  '+
                                  ' CON.C_NOM_CRR, CON.C_TIP_CON ' +
                                  ' from CHEQUE CHE, CHEQUECP CHP, CADFORMASPAGAMENTO FRM, CADCONTAS CON ' +
                                  ' Where CHE.CODFORMAPAGAMENTO = FRM.I_COD_FRM ' +
                                  ' AND CHE.NUMCONTACAIXA = CON.C_NRO_CON ' +
                                  ' AND CHE.SEQCHEQUE = CHP.SEQCHEQUE '+
                                  ' AND CHP.CODFILIALPAGAR = ' + IntToStr(VpaCodFilial)+
                                  ' AND CHP.LANPAGAR = ' + IntToStr(VpaLanPagar)+
                                  ' AND CHP.NUMPARCELA = ' + IntToStr(VpaNumParcela));
end;

{******************************************************************************}
function TFuncoesContasAPagar.MarcaProrrogado(VpaCodFilial, VpaLanPagar, VpaNumParcela: Integer;
  VpaMarcarProrrogado: boolean): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASAPAGAR ' +
                                 ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                 ' AND I_LAN_APG = '+IntToStr(VpaLanPagar)+
                                 ' AND I_NRO_PAR = '+IntToStr(VpaNumParcela));
  Cadastro.Edit;
  if VpaMarcarProrrogado  then
    Cadastro.FieldByName('C_DES_PRR').AsString := 'S'
  else
    Cadastro.FieldByName('C_DES_PRR').AsString := 'N';
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.CarDChequesCP(VpaListaCheques : TList;VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer);
var
  VpfDCheque :  TRBDCheque;
begin
  FreeTObjectsList(VpaListaCheques);
  LocalizaChequesCP(Tabela,VpaCodFilial,VpaLanPagar,VpaNumParcela);
  While not Tabela.Eof do
  begin
    VpfDCheque := TRBDCheque.cria;
    VpaListaCheques.Add(VpfDCheque);
    VpfDCheque.SeqCheque := Tabela.FieldByname('SEQCHEQUE').AsInteger;
    VpfDCheque.CodBanco := Tabela.FieldByname('CODBANCO').AsInteger;
    VpfDCheque.CodFormaPagamento := Tabela.FieldByname('CODFORMAPAGAMENTO').AsInteger;
    VpfDCheque.NumCheque := Tabela.FieldByname('NUMCHEQUE').AsInteger;
    VpfDCheque.CodUsuario := Tabela.FieldByname('CODUSUARIO').AsInteger;
    VpfDCheque.NumContaCaixa := Tabela.FieldByname('NUMCONTACAIXA').AsString ;
    VpfDCheque.NomContaCaixa := Tabela.FieldByname('C_NOM_CRR').AsString ;
    VpfDCheque.NomEmitente := Tabela.FieldByname('NOMEMITENTE').AsString ;
    VpfDCheque.NomFormaPagamento := Tabela.FieldByname('C_NOM_FRM').AsString ;
    VpfDCheque.TipFormaPagamento := FunContasAReceber.RTipoFormapagamento(Tabela.FieldByname('C_FLA_TIP').AsString);
    VpfDCheque.TipCheque := Tabela.FieldByName('TIPCHEQUE').AsString;
    VpfDCheque.TipContaCaixa := Tabela.FieldByName('C_TIP_CON').AsString;
    VpfDCheque.ValCheque := Tabela.FieldByname('VALCHEQUE').AsFloat ;
    VpfDCheque.DatCadastro := Tabela.FieldByname('DATCADASTRO').AsDateTime ;
    VpfDCheque.DatVencimento := Tabela.FieldByname('DATVENCIMENTO').AsDateTime ;
    VpfDCheque.DatCompensacao := Tabela.FieldByname('DATCOMPENSACAO').AsDateTime ;
    VpfDCheque.DatDevolucao := Tabela.FieldByname('DATDEVOLUCAO').AsDateTime ;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.CarParcelasCheque(VpaParcelas : TList;VpaSeqCheque, VpaCodFilialOriginal, VpaLanPagarOriginal, VpaNumParcelaOriginal : Integer);
var
  VpfDParcela : TRBDParcelaCP;
begin
  FreeTObjectsList(VpaParcelas);
  AdicionaSQLAbreTabela(calcula,'Select CODFILIALPAGAR, LANPAGAR, NUMPARCELA '+
                               ' from CHEQUECP '+
                               ' Where SEQCHEQUE = '+IntToStr(VpaSeqCheque));
  While not Calcula.eof do
  begin
    if not((Calcula.FieldByname('CODFILIALPAGAR').AsInteger = VpaCodFilialOriginal) and
           (Calcula.FieldByname('LANPAGAR').AsInteger = VpaLanPagarOriginal) and
           (Calcula.FieldByname('NUMPARCELA').AsInteger = VpaNumParcelaOriginal)) then
    begin
      VpfDParcela := TRBDParcelaCP.Cria;
      CarDParcelaBaixa(VpfDParcela,Calcula.FieldByname('CODFILIALPAGAR').AsInteger,Calcula.FieldByname('LANPAGAR').AsInteger,
                       Calcula.FieldByname('NUMPARCELA').AsInteger);
      VpaParcelas.Add(VpfDParcela);
    end;
    Calcula.next;
  end;
  Calcula.close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.GravaDContasaPagar(VpaDContasAPagar : TRBDContasaPagar) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCONTASAPAGAR '+
                                 ' Where I_EMP_FIL = '+IntToStr(VpaDContasAPagar.CodFilial)+
                                 ' and I_LAN_APG = ' + IntToStr(VpaDContasAPagar.LanPagar));
  if Cadastro.Eof then
    Cadastro.Insert
  else
    Cadastro.edit;
  Cadastro.FieldByName('I_COD_EMP').AsInteger := Varia.CodigoEmpresa;
  Cadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDContasAPagar.CodFilial;
  Cadastro.FieldByName('I_COD_PAG').AsInteger := VpaDContasAPagar.CodCondicaoPagamento;
  if VpaDContasAPagar.IndDespesaPrevista then
    Cadastro.FieldByName('I_QTD_PAR').AsInteger := 1
  else
    Cadastro.FieldByName('I_QTD_PAR').AsInteger := Sistema.RQtdParcelasCondicaoPagamento(VpaDContasAPagar.CodCondicaoPagamento);
  if VpaDContasAPagar.CodCentroCusto <> 0 then
    Cadastro.FieldByName('I_COD_CEN').AsInteger := VpaDContasAPagar.CodCentroCusto
  else
    Cadastro.FieldByName('I_COD_CEN').clear;

  if (VpaDContasAPagar.IndDespesaPrevista)  then
    VpaDContasAPagar.DatEmissao := TRBDParcelaCP(VpaDContasAPagar.Parcelas.Items[0]).DatVencimento;
  Cadastro.FieldByName('D_DAT_MOV').AsDateTime := date;
  Cadastro.FieldByName('D_DAT_EMI').AsDateTime := VpaDContasAPagar.DatEmissao;

  Cadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;   // adiciona o usuario que esta cadastrando
  if DeletaEspacoDE(VpaDContasAPagar.DesPathFoto) <> '' then
    Cadastro.FieldByName('C_PAT_FOT').AsString := VpaDContasAPagar.DesPathFoto;
  // Parâmetros.
  if VpaDContasAPagar.NumNota <> 0 then
    Cadastro.FieldByName('I_NRO_NOT').AsInteger := VpaDContasAPagar.NumNota;
  if VpaDContasAPagar.SeqNota <> 0 then
    Cadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDContasAPagar.SeqNota;
  Cadastro.FieldByName('I_COD_CLI').AsInteger := VpaDContasAPagar.CodFornecedor;
  Cadastro.FieldByName('N_VLR_TOT').AsFloat :=  VpaDContasAPagar.ValTotal;
  Cadastro.FieldByName('C_CLA_PLA').AsString := VpaDContasAPagar.CodPlanoConta;
  if VpaDContasAPagar.IndEsconderConta then
    Cadastro.FieldByName('C_IND_CAD').AsString := 'S';
  if VpaDContasAPagar.IndDespesaPrevista then
    Cadastro.FieldByName('C_IND_PRE').AsString := 'S'
  else
    Cadastro.FieldByName('C_IND_PRE').AsString := 'N';
  VpaDContasAPagar.LanPagar := GeraProximoCodigo('i_lan_apg','CADCONTASAPAGAR','I_EMP_FIL', varia.CodigoEmpFil, false,VprBaseDados);
  Cadastro.FieldByName('I_LAN_APG').AsInteger := VpaDContasAPagar.LanPagar;
  //atualiza a data de alteracao para poder exportar
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;
  Cadastro.post;
  if Cadastro.AErronaGravacao then
  begin
    // caso erro na Cadastro de codigos sequencial a o proximo do movCadastro
    Cadastro.FieldByName('I_LAN_APG').AsInteger := GeraProximoCodigo('i_lan_apg','cadContasAPagar','i_emp_fil', varia.CodigoEmpFil, true,VprBaseDados);
    Cadastro.POST;
    result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.close;
  if result = '' then
  begin
    Result := GravaDParcelaPagar(VpaDContasAPagar);
    if result = ''  then
      result := GravaDDespesaProjeto(VpaDContasAPagar);
  end;

  if (VpaDContasAPagar.IndDespesaPrevista)  then
  begin
    VpaDContasAPagar.Parcelas.Delete(0);
    if (VpaDContasAPagar.Parcelas.Count > 0) then
    begin
      VpaDContasAPagar.LanPagar := 0;
      TRBDParcelaCP(VpaDContasAPagar.Parcelas.Items[0]).DatEmissao := TRBDParcelaCP(VpaDContasAPagar.Parcelas.Items[0]).DatVencimento;
      GravaDContasaPagar(VpaDContasAPagar);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.GravaDDespesaProjeto(VpaDContasAPagar: TRBDContasaPagar): String;
var
  VpfDDespesa :TRBDContasaPagarProjeto;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from CONTAAPAGARPROJETO '+
                        ' Where CODFILIAL = '+IntToStr(VpaDContasAPagar.CodFilial)+
                        ' and LANPAGAR = ' + IntToStr(VpaDContasAPagar.LanPagar));
  AdicionaSQLAbreTabela(Cadastro,'Select * from CONTAAPAGARPROJETO '+
                                 ' Where CODFILIAL = 0 AND LANPAGAR = 0 ');
  for VpfLaco := 0 to VpaDContasAPagar.DespesaProjeto.Count - 1 do
  begin
    VpfDDespesa := TRBDContasaPagarProjeto(VpaDContasAPagar.DespesaProjeto.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDContasAPagar.CodFilial;
    Cadastro.FieldByName('LANPAGAR').AsInteger := VpaDContasAPagar.LanPagar;
    Cadastro.FieldByName('SEQDESPESA').AsInteger := VpfLaco + 1;
    Cadastro.FieldByName('CODPROJETO').AsInteger := VpfDDespesa.CodProjeto;
    Cadastro.FieldByName('PERDESPESA').AsFloat := VpfDDespesa.PerDespesa;
    Cadastro.FieldByName('VALDESPESA').AsFloat := VpfDDespesa.ValDespesa;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.GravaDParcelaPagar(VpaDContasAPagar : TRBDContasaPagar) : String;
Var
  VpfLaco : Integer;
  VpfDParcelaCP : TRBDParcelaCP;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from MOVCONTASAPAGAR '+
                        ' Where I_EMP_FIL = '+IntToStr(VpaDContasAPagar.CodFilial)+
                        ' and I_LAN_APG = ' + IntToStr(VpaDContasAPagar.LanPagar));
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASAPAGAR '+
                                 ' Where I_EMP_FIL = '+IntToStr(VpaDContasAPagar.CodFilial)+
                                 ' and I_LAN_APG = ' + IntToStr(VpaDContasAPagar.LanPagar));
  for VpfLaco := 0 to VpaDContasAPagar.Parcelas.Count - 1 do
  begin
    VpfDParcelaCP := TRBDParcelaCP(VpaDContasAPagar.Parcelas.Items[VpfLaco]);
    VpfDParcelaCP.CodFilial := VpaDContasAPagar.CodFilial;
    VpfDParcelaCP.LanPagar := VpaDContasAPagar.LanPagar;
    Cadastro.Insert;
    Cadastro.FieldByname('I_EMP_FIL').AsInteger := VpaDContasAPagar.CodFilial;
    Cadastro.FieldByname('I_LAN_APG').AsInteger := VpaDContasAPagar.LanPagar;
    Cadastro.FieldByname('I_NRO_PAR').AsInteger := VpfDParcelaCP.NumParcela;
    if VpfDParcelaCP.NumContaCorrente <> '' then
      Cadastro.FieldByname('C_NRO_CON').AsString := VpfDParcelaCP.NumContaCorrente;
    Cadastro.FieldByname('C_NRO_DUP').AsString := VpfDParcelaCP.NumDuplicata;
    Cadastro.FieldByname('C_COD_BAR').AsString := VpfDParcelaCP.CodBarras;
    Cadastro.FieldByname('D_DAT_VEN').AsDateTime := VpfDParcelaCP.DatVencimento;
    Cadastro.FieldByname('N_VLR_DUP').AsFloat := VpfDParcelaCP.ValParcela;
    Cadastro.FieldByname('N_PER_JUR').AsFloat := VpfDParcelaCP.PerJuros;
    Cadastro.FieldByname('N_PER_MOR').AsFloat := VpfDParcelaCP.PerMora;
    Cadastro.FieldByname('N_PER_MUL').AsFloat := VpfDParcelaCP.PerMulta;
    Cadastro.FieldByname('I_COD_USU').AsInteger := varia.CodigoUsuario;
    Cadastro.FieldByname('C_NRO_DOC').AsString := VpfDParcelaCP.NumDuplicata;
    Cadastro.FieldByname('I_COD_FRM').AsInteger := VpfDParcelaCP.CodFormaPagamento;
    Cadastro.FieldByname('C_FLA_PAR').AsString := 'N';
    Cadastro.FieldByname('C_IMP_CHE').AsString := 'N';
    Cadastro.FieldByname('C_BOL_REC').AsString := 'N';
    Cadastro.FieldByname('C_DES_PRR').AsString := 'N';
    Cadastro.FieldByname('L_OBS_APG').AsString := VpfDParcelaCP.DesObservacoes;
    Cadastro.FieldByname('I_COD_MOE').AsInteger := VpaDContasAPagar.CodMoeda;
    Cadastro.FieldByname('D_ULT_ALT').AsDateTime := now;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
    if VpaDContasAPagar.IndDespesaPrevista then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.BaixaParcelacomDebitoFornecedor(VpaDContasaPagar: TRBDContasaPagar; VpaCredito: TList): string;
var
  VpfDBaixa : TRBDBaixaCP;
  VpfLaco : Integer;
  VpfDParcelaBaixa : TRBDParcelaCP;
  VpfValCredito : Double;
begin
{ O que falta:
  -No credito quem que informar qual a conta caixa que gerou esse credito, para quando excluir o credito no cadastro de clientes tem que adicionar esse valor no caixa novamente;}

  result := '';
  if varia.FormaPagamentoCreditoCliente = 0  then
    result := 'FORMA DE PAGAMENTO CREDITO CLIENTE NÃO PREENCHIDA!!!'#13'É necessário preencher nas configurações financeiras a forma de pagamento de credito do cliente.';
  if result = ''  then
  begin
    VpfDBaixa := TRBDBaixaCP.Cria;
    VpfDBaixa.CodFormaPagamento := Varia.FormaPagamentoCreditoCliente;
    VpfDBaixa.NumContaCaixa := varia.CaixaPadrao;
    VpfDBaixa.DatPagamento := date;
    VpfValCredito := FunContasAReceber.RValTotalCredito(VpaCredito,dcDebito);
    //carrega as parcelas que serao pagas
    for VpfLaco := 0 to VpaDContasaPagar.Parcelas.Count - 1 do
    begin
      VpfDParcelaBaixa := VpfDBaixa.AddParcela;
      CarDParcelaBaixa(VpfDParcelaBaixa,VpaDContasaPagar.CodFilial,VpaDContasaPagar.LanPagar,TRBDParcelaCP(VpaDContasaPagar.Parcelas.Items[VpfLaco]).NumParcela);
      VpfValCredito := VpfValCredito - VpfDParcelaBaixa.ValParcela;
      if VpfValCredito <= 0 then
        break;
    end;
    if VpfValCredito >= 0 then
    begin
      VpfDBaixa.ValorPago := VpaDContasaPagar.ValTotal;
      VpaDContasaPagar.ValSaldoDebitoFornecedor := VpfValCredito;
    end
    else
    begin
      VpfDBaixa.ValorPago := FunContasAReceber.RValTotalCredito(VpaCredito,dcDebito);
      VpaDContasaPagar.ValSaldoDebitoFornecedor := 0;
    end;
    VpaDContasaPagar.ValUtilizadoCredito := VpfDBaixa.ValorPago;
    //baixa o contas a receber;
    result := VerificaSeGeraParcial(VpfDBaixa,VpfDBaixa.ValorPago,false);
    if result = '' then
    begin
      VpfDBaixa.IndBaixaUtilizandoODebitoFornecedor := true;
      result := BaixaContasAPagar(VpfDBaixa);
    end;
    //exclui o valor do credito do cliente;
    if result = '' then
    begin
      result := FunClientes.DiminuiCredito(VpfDParcelaBaixa.CodCliente,VpfDBaixa.ValorPago,dcDebito);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.BaixaParcelaPagar(VpaDBaixa : TRBDBaixaCP;VpaDParcela : TRBDParcelaCP):string;
begin
  result := '';
  Localizaparcela(Cadastro,VpaDParcela.CodFilial,VpaDParcela.LanPagar, VpaDParcela.NumParcela);
  Cadastro.edit;

  Cadastro.FieldByName('D_DAT_PAG').AsDateTime := VpaDBaixa.DatPagamento;
  Cadastro.FieldByName('N_VLR_DES').AsCurrency := VpaDBaixa.ValorDesconto;
  Cadastro.FieldByName('N_VLR_ACR').AsCurrency := VpaDBaixa.ValorAcrescimo;

  if VpaDParcela.IndGeraParcial then
    Cadastro.FieldByName('N_VLR_PAG').AsCurrency := VpaDParcela.ValParcela-VpaDBaixa.ValParcialFaltante
  else
    Cadastro.FieldByName('N_VLR_PAG').AsCurrency := VpaDParcela.ValParcela+VpaDParcela.ValAcrescimo-VpaDParcela.ValDesconto;
  Cadastro.FieldByName('L_OBS_APG').AsString := VpaDParcela.DesObservacoes;
  Cadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('N_PER_MUL').AsCurrency := VpaDParcela.PerMulta;
  Cadastro.FieldByName('N_PER_JUR').AsCurrency := VpaDParcela.PerJuros;
  Cadastro.FieldByName('N_PER_MOR').AsCurrency := VpaDParcela.PerMora;
  Cadastro.FieldByName('C_NRO_CON').AsString := VpaDBaixa.NumContaCaixa;
  Cadastro.FieldByName('I_COD_FRM').AsInteger := VpaDBaixa.CodFormaPAgamento;  // caso naum mude a frm aqui so no cadastro, ou baixa

  //atualiza a data de alteracao para poder exportar
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;

  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.BaixaContasaPagarAutomatico(VpaDContasaPagar : TRBDContasaPagar) : string;
var
  VpfDBaixa : TRBDBaixaCP;
  VpfDParcelaCadastro, VpfDParcelaBaixa : TRBDParcelaCP;
  VpfLaco : Integer;
begin
  result := '';
  VpfDBaixa := TRBDBaixaCP.Cria;
  VpfDBaixa.CodFormaPagamento := VpaDContasaPagar.CodFormaPagamento;
  VpfDBaixa.TipFormaPagamento := VpaDContasaPagar.DesTipFormaPagamento;
  VpfDBaixa.NumContaCaixa := VpaDContasaPagar.NumContaCaixa;
  VpfDBaixa.ValorPago := VpaDContasaPagar.ValTotal;
  VpfDBaixa.DatPagamento := VpaDContasaPagar.DatEmissao;
  for VpfLaco := 0 to VpaDContasaPagar.Parcelas.Count - 1 do
  begin
    VpfDParcelaCadastro := TRBDParcelaCP(VpaDContasaPagar.Parcelas.Items[VpfLaco]);
    VpfDParcelaBaixa := VpfDBaixa.AddParcela;
    with VpfDParcelaBaixa do
    begin
      CodFilial :=  VpfDParcelaCadastro.CodFilial;
      LanPagar :=  VpfDParcelaCadastro.LanPagar;
      NumParcela :=  VpfDParcelaCadastro.NumParcela;
      NumParcelaParcial :=  VpfDParcelaCadastro.NumParcelaParcial;
      CodCliente :=  VpfDParcelaCadastro.CodCliente;
      CodFormaPagamento :=  VpfDParcelaCadastro.CodFormaPagamento;
      NumNotaFiscal :=  VpfDParcelaCadastro.NumNotaFiscal;
      NumDiasAtraso :=  VpfDParcelaCadastro.NumDiasAtraso;
      QtdParcelas :=  VpfDParcelaCadastro.QtdParcelas;
      NumContaCorrente :=  VpaDContasaPagar.NumContaCaixa;
      NomCliente :=  VpfDParcelaCadastro.NomCliente;
      NomFormaPagamento :=  VpfDParcelaCadastro.NomFormaPagamento;
      NumDuplicata :=  VpfDParcelaCadastro.NumDuplicata;
      DesObservacoes :=  VpfDParcelaCadastro.DesObservacoes;
      DatEmissao :=  VpfDParcelaCadastro.DatEmissao;
      DatVencimento :=  VpfDParcelaCadastro.DatVencimento;
      DatPagamento :=  VpfDParcelaCadastro.DatPagamento;
      ValParcela :=  VpfDParcelaCadastro.ValParcela;
      ValAcrescimo :=  VpfDParcelaCadastro.ValAcrescimo;
      ValDesconto :=  VpfDParcelaCadastro.ValDesconto;
      PerMora :=  VpfDParcelaCadastro.PerMora;
      PerJuros :=  VpfDParcelaCadastro.PerJuros;
      PerMulta :=  VpfDParcelaCadastro.PerMulta;
      IndValorQuitaEssaParcela :=  true;
      IndGeraParcial :=  false;
      IndContaOculta :=  false;
    end;
  end;
  result := BaixaContasAPagar(VpfDBaixa);
  VpfDBaixa.Free;
end;

{##################### estorno e exclusa de conta e titulos ################## }

{****************** verifica se tem parcelas pagas ************************** }
function TFuncoesContasAPagar.TemParcelasPagas(VpaCodFilial,VpaLanPagar: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,' select D_DAT_PAG from MovContasAPagar ' +
                      ' where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                      ' and I_LAN_APG = ' + IntToStr(VpaLanPagar) +
                      ' and not D_DAT_PAG is null ');
  Result := (not Tabela.EOF);
  Tabela.close;
end;

{*************** exclui uma conta do contas a pagar ********************** }
function TFuncoesContasAPagar.ExcluiConta(VpaCodFilial, VpaLanPagar : integer; VpaVerificarNotaFiscal : Boolean ) : string;
begin
  result := '';
  if TemParcelasPagas(VpaCodFilial,VpaLanPagar) then
    result := CT_ParcelaPaga;
  if result = '' then
  begin
    LocalizaContaCP(Tabela,VpaCodFilial,VpaLanPagar);
    if VpaVerificarNotaFiscal then
      if Tabela.FieldByname('I_SEQ_NOT').AsInteger <> 0 THEN
        result := CT_ExclusaoNota;
    if result = '' then
    begin
      sistema.GravaLogExclusao('MOVCONTASAPAGAR','select * from MOVCONTASAPAGAR WHERE ' +
                                 ' I_LAN_APG = ' + IntToStr(VpaLanPagar) +
                                 ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
      ExecutaComandoSql(Aux,'DELETE CONTAAPAGARPROJETO  ' +
                                 ' Where LANPAGAR = ' + IntToStr(VpaLanPagar) +
                                 ' and CODFILIAL = ' + IntToStr(VpaCodFilial));
      ExecutaComandoSql(Aux,'DELETE MOVCONTASAPAGAR WHERE ' +
                                 ' I_LAN_APG = ' + IntToStr(VpaLanPagar) +
                                 ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
      sistema.GravaLogExclusao('CADCONTASAPAGAR','select * from CADCONTASAPAGAR WHERE ' +
                                 ' I_LAN_APG = ' + IntToStr(VpaLanPagar) +
                                 ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
      ExecutaComandoSql(Aux,'DELETE CADCONTASAPAGAR WHERE ' +
                                 ' I_LAN_APG = ' + IntToStr(VpaLanPagar) +
                                 ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));

    end;
  end;
  Tabela.close;
end;

{ *** verifica se o título tem parcelas *** }
function TFuncoesContasAPagar.TemParcelas(VpaCodFilial,VpaLanPagamento : Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,
    ' select * from MovContasaPagar ' +
    ' where I_LAN_APG = ' + IntToStr(VpaLanPagamento) +
    ' and I_EMP_FIL = '   + IntToStr(VpaCodFilial));
  Result :=(not Tabela.EOF);
  Tabela.close;
end;

{******************* exclui um titulo a pagar ****************************** }
function TFuncoesContasAPagar.ExcluiTitulo(VpaCodFilial, VpaLanPagar, VpaNumParcela : Integer ) : string;
begin
  result := '';
  if result = '' then
  begin
    LocalizaContaCP(Tabela,VpaCodFilial,VpaLanPagar);
    if Tabela.FieldByname('I_SEQ_NOT').AsInteger <> 0 THEN
      result := CT_ExclusaoNota;
    if result = '' then
    begin
      LocalizaParcela(Tabela,VpaCodFilial,VpaLanPagar,VpaNumParcela);
      if Tabela.fieldByName('N_VLR_PAG').AsCurrency <> 0 then
        result := CT_ParcelaPaga;

      if result = '' then
      begin
        ExecutaComandoSql(Aux,'DELETE MOVCONTASAPAGAR WHERE ' +
                                   ' I_LAN_APG = ' + IntToStr(VpaLanPagar) +
                                   ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                                   ' and I_NRO_PAR = '+IntTostr(VpaNumParcela) );
      end;
    end;
  end;
  Tabela.close;

  if not TemParcelas(VpaCodFilial,VpaLanPagar) then
  begin
   result := ExcluiConta(VpaCodFilial,VpaLanPagar,false);
  end
  else
    AtualizaValorTotal(VpaCodFilial,VpaLanPagar);
end;

{******************************************************************************}
function TFuncoesContasAPagar.ValidaChequesCP(VpaCodFilial,VpaLanPagar,VpaNumparcela : Integer;Var VpaExisteCheques : Boolean):string;
Var
  VpfCheques : TList;
begin
  result := '';
  VpaExisteCheques := false;
  VpfCheques :=  TList.Create;
  CarDChequesCP(VpfCheques,VpaCodFilial,VpaLanPagar,VpaNumparcela);
  if VpfCheques.Count > 0 then
  begin
    VpaExisteCheques := true;
    FChequesCP := TFChequesCP.CriarSDI(nil,'',true);
    FChequesCP.ConsultaCheques(VpfCheques);
    if confirmacao('Os cheques que foram recebidos nesta parcela serão excluídos. Tem certeza que deseja continuar?') then
      result := ExcluiChequesCP(VpaCodFilial,VpaLanPagar,VpaNumparcela,VpfCheques)
    else
      result := 'EXCLUSÃO DO CHEQUE CANCELADO!!!'#13'Não é possível cancelar o contas a pagar porque a exclusão dos cheques foi cancelado.';
    FChequesCP.free;
  end;

  FreeTObjectsList(VpfCheques);
  VpfCheques.free;
end;

{******************************************************************************}
function TFuncoesContasAPagar.VerificacoesExclusaoCheque(VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer;VpaCheques : TList):string;
var
  VpfDCheque : TRBDCheque;
  VpfDParcela : TRBDParcelaCP;
  VpfParcelas : TList;
  VpfLaco : Integer;
begin
  result := '';
  VpfParcelas := TList.Create;
  if VpaCheques.Count > 0 then
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[0]);
    CarParcelasCheque(VpfParcelas,VpfDCheque.SeqCheque,VpaCodFilial,VpaLanPagar,VpaNumParcela);
    if VpfParcelas.Count > 0 then
    begin
      FBaixaContasaPagarOO := TFBaixaContasaPagarOO.CriarSDI(nil,'',true);
      FBaixaContasaPagarOO.ConsultaParcelasBaixa(VpfParcelas);
      if not  confirmacao('Os cheques estão associados a outras parcelas, a exclusão dos cheques irá resultar no estorno dessas parcelas do contas a receber. Deseja continuar? ') then
        result := 'Cancelado estorno das parcelas adicionais do cheque';
      FBaixaContasaPagarOO.free;
      if result = '' then
      begin
        for VpfLaco := 0 to VpfParcelas.Count - 1 do
        begin
          VpfDParcela := TRBDParcelaCP(VpfParcelas.Items[VpfLaco]);
          result := EstornoParcela(VpfDParcela.CodFilial,VpfDParcela.LanPagar,VpfDParcela.NumParcela,VpfDParcela.NumParcelaParcial,VpfDParcela.CodCliente,false);
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
function TFuncoesContasAPagar.ExcluiChequesCP(VpaCodFilial,VpaLanPagar,VpaNumParcela : Integer;VpaCheques : TList):string;
var
  VpfDCheque : TRBDCheque;
  VpfLaco : Integer;
begin
  result := '';
  if VpaCheques.Count > 0 then
  begin
    result := VerificacoesExclusaoCheque(VpaCodFilial,VpaLanPagar,VpaNumParcela,VpaCheques);
    if result = '' then
    begin
      for vpfLaco := 0 to VpaCheques.count - 1 do
      begin
        VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
        FunContasAReceber.EstornaCheque(VpfDCheque,oeContasaPagar);
        ExecutaComandoSql(Aux,'Delete from CHEQUECP '+
                          ' Where SEQCHEQUE = ' +IntToStr(VpfDCheque.SeqCheque));
        if VpfDCheque.TipCheque = 'D' then //somente exclui os cheques que foram emitidos, os cheque do tipo 'C'-Credito não pode excluir pois foram recebidos de terceiros, pode somente estornar a compensacao;
          ExecutaComandoSql(Aux,'Delete from CHEQUE '+
                               ' Where SEQCHEQUE = ' +IntToStr(VpfDCheque.SeqCheque));
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.EstornoParcela(VpaCodFilial, VpaLanPagar,VpaNumParcela, VpaNumParcelaFilha, VpaCodCliente : integer;VpaVerificarCheques : Boolean) : String;
var
  VpfPossuiCheques : Boolean;
begin
  result := '';
  if VpaVerificarCheques then
    result := ValidaChequesCP(VpaCodFilial,VpaLanPagar,VpaNumParcela,VpfPossuiCheques);
  if result = '' then
  begin
    if not VpfPossuiCheques then
      result := FunCaixa.ExtornaParcelaCPCaixa(VpaCodFilial,VpaLanPagar,VpaNumParcela);

    if result = '' then
    begin
      // Verificar se tem mais de uma parcela parcial.
      result := EstornaParcelaParcial(VpaCodFilial,VpaLanPagar,VpaNumParcelaFilha);

      if result = '' then
      begin
        LocalizaParcela(Cadastro,VpaCodFilial,VpaLanPagar, VpaNumParcela);
        if Cadastro.FieldByName('I_COD_FRM').AsInteger = varia.FormaPagamentoCreditoCliente then
        begin
          result := FunClientes.AdicionaCredito(VpaCodCliente,Cadastro.FieldByName('N_VLR_PAG').AsFloat,'D','Extorno do C P da duplicata "'+Cadastro.FieldByName('C_NRO_DUP').AsString+'"');
          if result = '' then
            aviso('ADICIONADO "'+FormatFloat('R$ #,###,###,##0.00',Cadastro.FieldByName('N_VLR_PAG').AsFloat) +'" DE DÉBITO PARA O FORNECEDOR!!!'#13'O estorno desse contas a pagar gerou um débito para o fornecedor.');
        end;

        if result = '' then
        begin
          Cadastro.edit;
          // Retira os valoes de pagamento.
          Cadastro.FieldByName('D_DAT_PAG').Clear;
          Cadastro.FieldByName('N_VLR_DES').Clear;
          Cadastro.FieldByName('N_VLR_ACR').Clear;
          Cadastro.FieldByName('N_VLR_PAG').Clear;
          Cadastro.FieldByName('N_VLR_CHE').Clear;
          // Estornar a Impressão de Cheque;
          Cadastro.FieldByName('C_FLA_CHE').AsString := 'N';
          Cadastro.FieldByName('C_IMP_CHE').AsString := 'N';

          Cadastro.FieldByName('I_PAR_FIL').AsInteger := 0;
          //atualiza a data de alteracao para poder exportar
          Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;
          Cadastro.post;
          result := Cadastro.AMensagemErroGravacao;
          Cadastro.close;
        end;
      end;
    end;
  end;
end;

{ ****** Estorna a Parcela  ****** }
function TFuncoesContasAPagar.EstornaParcela( VpaLancamentoCP, VpaLancamentoBancario, VpaNroParcela,VpaNroParcelaFilha : integer; VpaDataParcela : TDateTime;
                                              VpaFlagParcial : string ) : Boolean;
begin
  Result := false;
  if ValidaEstornoParcela(VpaLancamentoCP, VpaDataParcela, VpaFlagparcial) then
  begin
//    if  EstornaParcelaParcial(VpaLancamentoCP, VpaNroParcelaFilha) then
    begin
      LocalizaParcela(Cadastro,varia.CodigoEmpfil,VpaLancamentoCP, VpaNroParcela);
      Cadastro.edit;
      // Retira os valoes de pagamento.
      Cadastro.FieldByName('D_DAT_PAG').Clear;
      Cadastro.FieldByName('N_VLR_DES').Clear;
      Cadastro.FieldByName('N_VLR_ACR').Clear;
      Cadastro.FieldByName('N_VLR_PAG').Clear;
      Cadastro.FieldByName('N_VLR_CHE').Clear;
      // Estornar a Impressão de Cheque;
      Cadastro.FieldByName('C_FLA_CHE').AsString := 'N';
      Cadastro.FieldByName('C_IMP_CHE').AsString := 'N';
      Cadastro.FieldByName('C_NRO_CON').Clear;

      Cadastro.FieldByName('I_PAR_FIL').AsInteger := 0;
      //atualiza a data de alteracao para poder exportar
      Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;
      Cadastro.post;
      Result := true;
    end
//    else
//      Aviso(CT_EstonoPacialInvalida);
  end;
  Cadastro.close;
end;

{******** valida a parcela, parcela anterior aberta, ************************* }
function TFuncoesContasAPagar.ValidaEstornoParcela( VpaLancamentoCP : integer; VpaDatPagamento : TDateTime; VpaFlagParcial : string ) : boolean;
begin
  Result := True;
  if VpaFlagParcial <> 'S' then
  begin
    AdicionaSQLAbreTabela(Tabela,' select * from MOVCONTASAPAGAR '+
                         ' where i_emp_fil = '+ IntToStr(varia.CodigoEmpFil) +
                         ' and i_lan_apg = ' + IntTostr(VpaLancamentoCP) +
                         ' and d_dat_ven > ''' + DataToStrFormato(AAAAMMDD,VpaDatPagamento,'/') + '''' +
                         ' and not d_dat_pag is null ' + // Já foi paga.
                         ' order by D_DAT_VEN ');
    if not Tabela.Eof then
    begin
      Aviso(CT_ParcelaPosPaga);
      Result := false;
    end;
    Tabela.Close;
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.EstornaCPChequeDevolvido(VpaCheques : TList) : string;
var
  VpfLacoCheque : Integer;
  VpfDCheque : TRBDCheque;
  VpfValCheque : Double;
  VpfParcelas : TList;
begin
  result := '';
  VpfParcelas := TList.Create;
  for VpfLacoCheque := 0 to VpaCheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLacoCheque]);
    VpfValCheque := VpfDCheque.ValCheque;
    CarParcelasCPCheque(VpfDCheque.SeqCheque,VpfParcelas);
    result :=  EstornaValorCPChequeDevolvido(VpfValCheque,VpfParcelas);

    if result <> '' then
      break;
    //se valor do cheque for maior que zero tem adicionar esse valor como credito com o fornecedor, foi pago a mais
   end;
  FreeTObjectsList(VpfParcelas);
  VpfParcelas.Free;
end;

{******************************************************************************}
function TFuncoesContasAPagar.EstornaValorCPChequeDevolvido(VpaValCheque : Double; VpaParcelas : TList) : string;
Var
  VpfLacoParcelas : Integer;
  VpfDParcela : TRBDParcelaCP;
begin
  for VpfLacoParcelas := VpaParcelas.Count - 1 downto 0 do
  begin
    VpfDParcela := TRBDParcelaCP(VpaParcelas.Items[VpfLacoParcelas]);
    if VpfDParcela.ValPago > 0 then
    begin
      if VpaValCheque >= VpfDParcela.ValPago then
      begin
        VpaValCheque := VpaValCheque - VpfDParcela.ValPago;
        VpfDParcela.ValPago := 0;
        Result:= GravaDParcelaCP(VpfDParcela);
      end
      else
      begin
        result := GravaParcelaParcial(VpfDParcela,VpaValCheque,VpfDParcela.DatVencimento);
        if result = ''then
        begin
          VpfDParcela.ValPago := VpfDParcela.ValPago - VpaValCheque;
          Result:= GravaDParcelaCP(VpfDParcela);
          VpaValCheque := 0;
        end;
      end;
      if (result <> '') or (VpaValCheque <= 0) then
        break;
    end;
  end;
end;

{################################## adicionais #############################}

{******************* retira adicionais ************************************** }
function TFuncoesContasAPagar.RetiraAdicionalConta(Lancamento, Parcela : Integer; ValorRetirar: Double) : Boolean;
begin
  Result:=True;
  LimpaSQLTabela(Calcula);
  AdicionaSQLTabela(Calcula,
    ' UPDATE MOVCONTASARECEBER' +
    ' set N_VLR_ADI = (ISNULL(N_VLR_ADI, 0) - ' +
      SubstituiStr(FloatToStr(ValorRetirar),',','.') + ') ' +
    ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE) + 
    ' where I_EMP_FIL = ' + IntTostr(Varia.CodigoEmpFil) +
    ' and I_LAN_REC = ' + IntToStr(Lancamento) +
    ' and I_NRO_PAR = ' + IntToStr(Parcela) +
    ' and D_DAT_PAG IS NULL ');
  Calcula.ExecSQL;
end;

{******************************************************************************}
function TFuncoesContasAPagar.RNumParcelas(VpaDBaixaCP: TRBDBaixaCP): string;
var
  VpfLaco : Integer;
begin
  result := '';
  for VpfLaco := 0 to VpaDBaixaCP.Parcelas.Count - 1 do
    result := result +TRBDParcelaCP(VpaDBaixaCP.Parcelas.Items[VpfLaco]).NumDuplicata+', ';
  if VpaDBaixaCP.Parcelas.Count > 0 then
    result := copy(result,1,length(result)-2);
end;

{*************** verifica conta adicional vinculada ************************ }
function TFuncoesContasAPagar.VerificaContaReceberVinculada(VpaNroOrdem, VpaParcela: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Calcula,
    ' SELECT * FROM MOVCONTASARECEBER' +
    ' where I_EMP_FIL = ' + IntTostr(Varia.CodigoEmpFil) +
    ' and I_LAN_REC = ' + IntToStr(VpaNroOrdem) +
    ' and I_NRO_PAR = ' + IntToStr(VpaParcela) +
    ' and NOT D_DAT_PAG IS NULL '); // Paga;
  Result := Calcula.EOF;
  if (not Result) then
    Aviso(CT_Titulo_Pago);
  calcula.close;
end;

{***************** configura o valor recebido de um adicional **************** }
procedure TFuncoesContasAPagar.AjustaValorUltimaParcela(VpaDContasAPagar: TRBDContasaPagar;VpaValorInicial : Double);
begin
  SomaTotalParcelas(VpaDContasAPagar);
  if VpaDContasAPagar.ValTotal <> VpaValorInicial then
    TRBDParcelaCP(VpaDContasAPagar.Parcelas.Items[VpaDContasAPagar.Parcelas.Count-1]).ValParcela :=  TRBDParcelaCP(VpaDContasAPagar.Parcelas.Items[VpaDContasAPagar.Parcelas.Count-1]).ValParcela - (VpaDContasAPagar.ValTotal - VpaValorInicial);
end;

{***************** configura o valor recebido de um adicional **************** }
procedure TFuncoesContasAPagar.AlteraValorRecebidoCAB(
  VpaOrdem: Integer; VpaValor:Double);
begin
  LimpaSQLTabela(Calcula);
  AdicionaSQLTabela(Calcula,
    ' UPDATE CADCONTASAPAGAR' +
    ' set N_VLR_REC =  ' +
      SubstituiStr(FloatToStr(VpaValor),',','.') +
    ' , D_ULT_ALT = ' + SQLTextoDataAAAAMMMDD(DATE) +  
    ' where I_EMP_FIL = ' + IntTostr(Varia.CodigoEmpFil) +
    ' and ISNULL(I_LAN_REC, 0) > 0 ' + // Altera somente se é um adiciona de uma conta a receber.
    ' and ISNULL(I_PAR_REC, 0) > 0 ' +
    ' and I_LAN_APG = ' + IntToStr(VpaOrdem));
  Calcula.ExecSQL;
end;

{##################### retornos bancários #####################################}

{******************************************************************************}
function TFuncoesContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDRetornoItem : TRBDRetornoItem;VpaValor : Double;VpaDescricao, VpaPlanoContas : String) : String;
Var
  VpfDContasPagar : TRBDContasaPagar;
  VpfDBaixa :  TDadosBaixaCP;
  VpfValor : Double;
  VpfFormaPagamento : Integer;
begin
  result := '';
  exit;
  if VpaDRetornoCorpo.CodFornecedorBancario = 0 then
    result := 'FORNECEDOR BANCÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher no cadastro da conta corrento o fornecedor bancario para gerar o contas a pagar';
  if Varia.PlanoContasBancario = '' then
    result := 'PLANO DE CONTAS NÃO PREENCHIDO!!!'#13'É necessário preencher o plano de contas bancário nas configurações da empresa.';
  if varia.FormaPagamentoDinheiro = 0 then
    result := 'FORMA DE PAGAMENTO EM DINHEIRO NÃO PREENCHIDA!!!'#13'É necessário preencher a forma de pagamento em dinheiro nas configurações do financeiras.';
  if result = '' then
  begin
    if VpaPlanoContas = '' then
      VpaPlanoContas := varia.PlanoContasBancario;
    VpfDContasPagar  := TRBDContasaPagar.cria;
    VpfDContasPagar.CodFilial := VpaDRetornoCorpo.CodFilial;
    VpfDContasPagar.CodFornecedor := VpaDRetornoCorpo.CodFornecedorBancario;
    VpfDContasPagar.CodFormaPagamento := varia.FormaPagamentoDinheiro;
    VpfDContasPagar.CodMoeda := varia.MoedaBase;
    VpfDContasPagar.CodUsuario := varia.CodigoUsuario;
    VpfDContasPagar.DatEmissao := VpaDRetornoItem.DatOcorrencia;
    VpfDContasPagar.CodPlanoConta := VpaPlanoContas;
    VpfDContasPagar.CodCondicaoPagamento := VARIA.CondPagtoVista;
    VpfDContasPagar.ValParcela := VpaValor;
    VpfDContasPagar.IndBaixarConta := true;
    VpfDContasPagar.IndMostrarParcelas := false;
    VpfDContasPagar.IndEsconderConta := false;
    VpfDContasPagar.DesTipFormaPagamento := 'D';
    VpfDContasPagar.DesObservacao := VpaDescricao;
    CriaContaPagar(VpfDContasPagar,nil);
  end;
end;

{######################## diversos ########################################### }

{******************** baixa uma conta da parcela ******************************}
procedure TFuncoesContasAPagar.BaixaConta( Valor, valorDesconto, ValorAcrescimo : double; Data : TDateTime; lancamento, NroParcela : integer );
begin
  LimpaSQLTabela(tabela);
  AdicionaSQLTabela(Tabela,
    ' Update movcontasapagar ' +
    ' set n_vlr_pag = ' +  SubstituiStr(FloatToStr(valor),',','.') +  ', ' +
    ' d_dat_pag = ''' + DataToStrFormato(AAAAMMDD,Data,'/') + ''',' +
    ' n_vlr_acr = ' + SubstituiStr(FloatToStr(ValorAcrescimo),',','.') +  ', ' +
    ' n_vlr_des = ' + SubstituiStr(FloatToStr(valorDesconto),',','.') +
    ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE)+
    ' where i_lan_apg = ' + IntToStr(lancamento) +
    ' and i_nro_par = ' + IntToStr(NroParcela) +
    ' and i_emp_fil = ' + IntToStr(varia.CodigoEmpFil));
  Tabela.ExecSQL;
end;

{******************** altera a forma de pagamento **************************** }
procedure TFuncoesContasAPagar.ConfiguraFormaPagto( FormaInicio, FormaFim, lancamento, Nroparcela : Integer; NroConta : string );
var
  Aux1, Aux2 : TSQLQUERY;
  LancamentoBancario : string;
  TipoInicio, TipoFim : string;
begin
  Aux1 := TSQLQUERY.Create(nil);
  Aux1.SQLConnection := VprBaseDados;
  Aux2 := TSQLQUERY.Create(nil);
  Aux2.SQLConnection := VprBaseDados;
  LocalizaFormaPagamento(aux1, FormaInicio);
  LocalizaFormaPagamento(aux2, FormaFim);
  TipoInicio := aux1.FieldByName('C_FLA_TIP').AsString;
  TipoFim := aux2.FieldByName('C_FLA_TIP').AsString;
  if TipoInicio <> TipoFim then
  begin
    FechaTabela(Aux1);
    LocalizaParcela(Aux1,Varia.Codigoempfil, lancamento, Nroparcela);
  end;
  FechaTabela(aux1);
  FechaTabela(aux2);
  Aux1.free;
  Aux2.free;
end;

{************ exclui uma conta atraves do estorno da nota fiscal de entrada ** }
function TFuncoesContasAPagar.ExcluiContaNotaFiscal( SeqNota : integer ) : Boolean;
var
  Lancamento : integer;
  VpfResultado : string;
begin
   AdicionaSQLAbreTabela(tabela,' select I_LAN_APG from CADCONTASAPAGAR ' +
                                ' where I_SEQ_NOT = ' + IntToStr(SeqNota )  +
                                ' and I_EMP_FIL = ' +  IntTostr(varia.CodigoEmpFil) );
   lancamento :=  Tabela.fieldByName('I_LAN_APG').AsInteger;
   tabela.close;
   vpfResultado :=  ExcluiConta(varia.codigoEmpfil, lancamento, false );
   if VpfResultado <> '' then
   begin
     result := false;
     aviso(VpfResultado);
   end
   else
     result := true;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.ExcluiPlanoContas(VpaPlanoOrigem, VpaPlanoDestino: String);
begin
  ExecutaComandoSql(Aux,'Update CADCLIENTES SET C_CLA_PLA = '''+ VpaPlanoDestino+''''+
                         ' Where C_CLA_PLA = '''+VpaPlanoOrigem+'''');
  ExecutaComandoSql(Aux,'Update MOVNATUREZA SET C_CLA_PLA = '''+ VpaPlanoDestino+''''+
                         ' Where C_CLA_PLA = '''+VpaPlanoOrigem+'''');
  ExecutaComandoSql(Aux,'UPDATE CADCONTASAPAGAR '+
                       ' SET C_CLA_PLA = '''+VpaPlanoDestino+''''+
                       ' Where C_CLA_PLA = '''+VpaPlanoOrigem+''''+
                       ' and I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
  ExecutaComandoSql(Aux,'DELETE FROM PLANOCONTAORCADO '+
                       ' Where CODPLANOCONTA = '''+VpaPlanoOrigem+''''+
                       ' and CODEMPRESA = '+IntToStr(Varia.CodigoEmpresa));
  ExecutaComandoSql(Aux,'DELETE FROM CAD_PLANO_CONTA '+
                       ' Where C_CLA_PLA = '''+VpaPlanoOrigem+''''+
                       ' and I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
end;

{******************** atualiza a forma de pagamento ************************** }
procedure TFuncoesContasAPagar.AtualizaFormaPagamento(LancamentoCP, ParcelaCP, CodigoFormaPagamento: string);
begin
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,
    ' UPDATE MOVCONTASAPAGAR SET I_COD_FRM = ' + CodigoFormaPagamento +
    ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE)+
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_LAN_APG = '   + LancamentoCP +
    ' AND I_NRO_PAR = '   + ParcelaCP );
  Tabela.ExecSQL;
end;

{******************************************************************************}
function TFuncoesContasAPagar.NotaPossuiParcelaPaga(VpaCodFilial, VpaSeqNota : Integer) : Boolean;
begin

   AdicionaSQLAbreTabela(tabela,' select i_lan_apg from CadContasaPagar ' +
                                ' where i_seq_not = ' + IntToStr(VpaSeqNota )  +
                                ' and i_emp_fil = ' +  IntTostr(VpaCodFilial) );
   result := TemParcelasPagas(VpaCodFilial, Tabela.fieldByName('i_lan_apg').AsInteger);
   tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.PossuiChequeDigitado(VpaDBaixa: TRBDBaixaCP): Boolean;
var
  VpfLaco : Integer;
  VpfDCheque : TRBDCheque;
begin
  result := false;
  for VpfLaco := 0 to VpaDBaixa.Cheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaDBaixa.Cheques.Items[VpfLaco]);
    if VpfDCheque.TipFormaPagamento = fpCheque then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.ProjetoDuplicado(VpaDContasAPagar: TRBDContasaPagar): boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDProjetoInterno, VpfDProjetoExterno : TRBDContasaPagarProjeto;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDContasAPagar.DespesaProjeto.Count - 2 do
  begin
    VpfDProjetoExterno := TRBDContasaPagarProjeto(VpaDContasAPagar.DespesaProjeto.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDContasAPagar.DespesaProjeto.Count - 1 do
    begin
      VpfDProjetoInterno := TRBDContasaPagarProjeto(VpaDContasAPagar.DespesaProjeto.Items[VpfLacoInterno]);
      if VpfDProjetoInterno.CodProjeto = VpfDProjetoExterno.CodProjeto then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesContasAPagar.FlagBaixarContaFormaPagamento(VpaCodFormapagamento : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,'Select C_BAI_CON from CADFORMASPAGAMENTO '+
                               ' Where I_COD_FRM = ' +IntToStr(VpaCodFormapagamento));
  result := Tabela.FieldByname('C_BAI_CON').AsString = 'S';
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesContasAPagar.FornecedorPossuiDebito(VpaCreditos: TList;VpaTipo : TRBDTipoCreditoDebito): Boolean;
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
function TFuncoesContasAPagar.ExisteCheque(VpaNumCheque: Integer;  var VpaExisteVariosCheques: Boolean;VpaDCheque : TRBDCheque): Boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(Tabela,'Select COUNT(CHE.SEQCHEQUE) QTD '+
                              ' from CHEQUE CHE ' +
                              ' Where CHE.NUMCHEQUE = ' +IntToStr(VpaNumCheque)+
                              ' AND CHE.DATCOMPENSACAO IS NULL');
  if Tabela.FieldbyName('QTD').AsInteger > 1 then
    VpaExisteVariosCheques := true
  else
    if Tabela.FieldbyName('QTD').AsInteger = 1 then
    begin
      AdicionaSQLAbreTabela(Tabela,'Select CHE.SEQCHEQUE, CHE.CODBANCO, CHE.NOMEMITENTE, '+
                                  ' CHE.DATVENCIMENTO, CHE.DATCOMPENSACAO, CHE.VALCHEQUE, CHE.NUMCONTACAIXA, '+
                                  ' CHE.NUMCHEQUE, CON.C_TIP_CON  '+
                                  ' from CHEQUE CHE, CADCONTAS CON ' +
                                  ' Where CHE.NUMCHEQUE = ' +IntToStr(VpaNumCheque)+
                                  ' AND CHE.DATCOMPENSACAO IS NULL'+
                                  ' AND CHE.NUMCONTACAIXA = CON.C_NRO_CON' +
                                  ' AND (CHE.CODFORNECEDORRESERVA IS NULL OR ' +
                                  ' CHE.CODFORNECEDORRESERVA = ' + IntToStr(VpaDCheque.CodCliente)+ ')');
      if tabela.Eof then
       result := false
      else
      begin
        result := true;
        VpaDCheque.SeqCheque := Tabela.FieldByname('SEQCHEQUE').AsInteger;
        VpaDCheque.CodBanco := Tabela.FieldByname('CODBANCO').AsInteger;
        VpaDCheque.NumCheque := Tabela.FieldByname('NUMCHEQUE').AsInteger;
        VpaDCheque.ValCheque := Tabela.FieldByname('VALCHEQUE').AsFloat;
        VpaDCheque.NomEmitente := Tabela.FieldByname('NOMEMITENTE').AsString;
        VpaDCheque.NumContaCaixa := Tabela.FieldByname('NUMCONTACAIXA').AsString;
        VpaDCheque.TipCheque := 'C';
        VpaDCheque.TipContaCaixa := Tabela.FieldByname('C_TIP_CON').AsString;
      end;
    end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.CarParcelasCPCheque(VpaSeqCheque : Integer;VpaParcelas : TList);
var
    VpfDParcelasCP : TRBDParcelaCP;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CHEQUECP '+
                            ' Where SEQCHEQUE = '+IntToStr(VpaSeqCheque)+
                            ' order by CODFILIALPAGAR, LANPAGAR, NUMPARCELA');
  while not Aux.eof do
  begin
    VpfDParcelasCP := TRBDParcelaCP.Cria;
    VpaParcelas.Add(VpfDParcelasCP);
    FunContasAPagar.CarDParcelaBaixa(VpfDParcelasCP,Aux.FieldByname('CODFILIALPAGAR').AsInteger,Aux.FieldByname('LANPAGAR').AsInteger,
                                      Aux.FieldByname('NUMPARCELA').AsInteger);
    Aux.next;
  end;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesContasAPagar.InterpretaCodigoBarras(VpaDContasAPagar : TRBDContasaPagar;VpaCodBarras : String);
begin
  if length(VpaCodBarras)>=20 then
  begin
    VpaDContasAPagar.ValBoleto := StrToFloat(copy(VpaCodBarras,10,10))/100;
    VpaDContasAPagar.CodFormaPagamento := varia.FormaPagamentoBoleto;
    VpaDContasAPagar.FatorVencimento := StrToInt(copy(VpaCodBarras,6,4));
    VpaDContasAPagar.CodBancoBoleto := StrToInt(copy(VpaCodBarras,1,3));

    if (VpaDContasAPagar.CodBancoBoleto = 748) then
    begin
      VpaDContasAPagar.DesIdentificacaoBancarioFornecedor := copy(VpaCodBarras,31,11)
    end;

    VpaDContasAPagar.CodFornecedor := FunClientes.RCodClientePelaIdentificaoBancaria(VpaDContasAPagar.DesIdentificacaoBancarioFornecedor);
  end;
end;

end.

