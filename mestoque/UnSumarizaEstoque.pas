unit UnSumarizaEstoque;
{Verificado
-.edit;
}
interface

uses
    Db, classes, sysUtils, painelGradiente, ConvUnidade, UnMoedas, comctrls,SQLExpr,
    Tabela;

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
  TCalculosSumarizaEstoque = class
  private
    calcula : TSQLQuery;
    Filtro : string;
    siglaCom : string;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); virtual;
    destructor destroy; override;
    function LocalizaQdadeProduto(SeqProduto : integer ) : Double;
    function SomaProdutos : integer;
    function PrimeiroMovEstoque : TDateTime;
    function VerificaSumaVazio : Boolean;
end;

// localizacao
Type
  TLocalizaSumarizaEstoque = class(TCalculosSumarizaEstoque)
  public
    procedure LocalizaMovQdadeProduto( Tabela : TSQLQuery );
    procedure LocalizaEstoqueAnteriorProduto(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );
    procedure LocalizaQdadeOperacaoPeriodo(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );
    procedure LocalizaValorDataUltimaVenda(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );
    procedure LocalizaValorDataUltimaCompra(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );

    procedure LocalizaSumarizaEstoque(Tabela : TSQL; VpaMes, VpaAno, SequencialProduto : integer );
    procedure LocalizaQdadeInconsistentes(Tabela : TDataSet; seqProduto : Integer);
    procedure LocalizaProdutoCodSumariza(Tabela : TSQLQUERY; SeqSumariza : integer );
    procedure LocalizaOpercaoEstoque(Tabela : TSQLQUERY; CodigoOP : integer );
end;

// funcoes
type
  TFuncoesSumarizaEstoque = class(TLocalizaSumarizaEstoque)
  private
      Aux,
      Produtos,
      Tabela : TSQLQuery;
      Cadastro : TSQL;
      VprBaseDados : TSQLConnection;
    procedure AtuDiaFechamentoEst(VpaDia : TDateTime);
    procedure ExcluiMovEstoque(VpaFilial : Integer;VpaDatInicio,VpaDatFim : TDateTime);
    procedure PosCaOrcamentoMes(VpaTabela : TDataSet;VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime);
    function RValTotalProdutos(VpaEmpfil, VpaLanOrcamento : Integer;var VpaVaTotalComDesconto : Double) : Double;
    procedure GeraMovEstoqueOrcamento(VpaCodFilial, VpaLanOrcamento : Integer;VpaDatMovimento : TDateTime; VpaValTotal : Double);
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); override;
    procedure CamposSumarizaMes( var VpaValorMes, VpaQdadeMes : string; VpaFuncaoEstoque : string );
    destructor Destroy; override;
    procedure FechaMes( VpaMes, VpaAno : integer; VpaBarra : TProgressBar  );
    procedure FechaMesGeral(VpaMesInicio, VpaAnoInicio,  VpaMesFim, VpaAnoFim : integer; Barra : TProgressBar  );
    procedure AcertoFechamento( OpeSaida, OpeEntrada, SeqPro : integer);
    procedure AcertaMovEstoque( SeqPro, Operacao : integer; Qdade : Double; SaidaEntrada, Unidade : string);
    procedure AcertoEstoqueAtual( SeqPro : integer);
    procedure AdicionaTemporaria( VetorMascara : array of byte; FilialAtual : string; Mes, Ano, Grupo : integer);
    procedure ReprocessaMes(VpaMesInicio, VpaAnoInicio, VpaMesFim, VpaAnoFim : Integer);
  end;

implementation

uses constMsg, constantes, funSql, funstring, fundata, funnumeros, UnProdutos, Componentes1, controls;


{#############################################################################
                        TCalculo Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosSumarizaEstoque.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  calcula := TSQLQuery.Create(aowner);
  calcula.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosSumarizaEstoque.destroy;
begin
  calcula.Destroy;
  inherited;
end;

{***************** localiza qdade de produtos ****************************** }
function TCalculosSumarizaEstoque.LocalizaQdadeProduto(SeqProduto : integer ) : Double;
begin
  FechaTabela(calcula);
  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula, ' select n_qtd_pro from movqdadeproduto ' +
                            ' where  i_emp_fil = ' + IntTostr(varia.CodigoEmpFil) +
                            ' and i_seq_pro = ' + IntTostr(SeqProduto) );
  AbreTabela(calcula);
  Result := calcula.fieldByName('n_qtd_pro').AsCurrency;
  FechaTabela(calcula);
end;

{****** localiza todos os produtos que sofreram modificacao em um periodo *****}
function TCalculosSumarizaEstoque.SomaProdutos : integer;
begin
  AdicionaSQLAbreTabela(calcula, ' select count(i_seq_pro) soma from movQdadeproduto ' +
                                 ' where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) );
  result := calcula.fieldByname('soma').asinteger
end;

{************** primeiro movimento de estoque ******************************** }
function TCalculosSumarizaEstoque.PrimeiroMovEstoque : TDateTime;
begin
  AdicionaSQLAbreTabela(calcula, ' select min(d_dat_mov) data from movEstoqueProdutos ' +
                            ' where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) );
  result := calcula.fieldByname('data').AsDateTime;
end;

{******************* verifica se o sumarizado esta vazio ******************** }
function TCalculosSumarizaEstoque.VerificaSumaVazio : Boolean;
begin
  FechaTabela(calcula);
  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula,' select * from movSumarizaEstoque ' +
                            ' where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) );
  AbreTabela(calcula);
  result := calcula.eof;
end;



{#############################################################################
                        TLocaliza Produtos
#############################################################################  }

{****** localiza todos os produtos que sofreram modificacao em um periodo *****}
procedure TLocalizaSumarizaEstoque.LocalizaMovQdadeProduto(Tabela : TSQLQuery );
begin
  AdicionaSQLAbreTabela(tabela, ' select i_seq_pro,N_VLR_CUS from movQdadeproduto ' +
                            ' where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil));

end;

{******************** localiza estoque anterior, venda  e compra do produto ** }
procedure TLocalizaSumarizaEstoque.LocalizaEstoqueAnteriorProduto(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );
begin
  FechaTabela(tabela);
  LimpaSQLTabela(tabela);
  AdicionaSQLTabela(tabela, ' select n_qtd_pro, n_qtd_ven, n_qtd_com, n_vlr_cmv, n_vlr_cmc from movsumarizaestoque ' +
                            ' where i_seq_pro = ' + IntTostr(SeqPro) +
                            ' and i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                            ' and i_cod_fec = ' +
                            '                     ( select  max(i_cod_fec) from movsumarizaestoque ' +
                            '                       where i_seq_pro = ' + IntTostr(SeqPro) +
                            '                       and i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                            '                       and d_dat_mes = ' +
                            '                                          ( select max(d_dat_mes) from movsumarizaestoque ' +
                            '                                            where i_seq_pro = ' + IntTostr(SeqPro) +
                            '                                            and i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                            '                                            and d_dat_mes < ' + SQLTextoDataAAAAMMMDD(MontaData(01,VpaMes, VpaAno)) +
                            '                                            ))' );
  AbreTabela(Tabela);
end;

{****** localiza qdade e valor do produto por funcoes da operacao de estoque ** }
procedure TLocalizaSumarizaEstoque.LocalizaQdadeOperacaoPeriodo(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );
var
  VpfDatInicio, VpfDatFim : TDateTime;
begin
  VpfDatInicio := MontaData(01,VpaMes, VpaAno);
  VpfDatFim :=  MontaData(Dia(UltimoDiaMes(VpfDatInicio)),VpaMes, VpaAno);
  AdicionaSQLAbreTabela(tabela, ' Select sum(mov.n_qtd_mov) qdade, sum(mov.n_vlr_mov) valor, SUM(MOV.N_VLR_CUS) VALORCUSTO, ' +
                            ' ope.c_fun_ope, mov.c_cod_uni UnidadeMov, pro.c_cod_uni UnidadePro ' +
                            ' from movestoqueprodutos mov, cadoperacaoestoque ope, cadprodutos  pro '+
                            ' where mov.i_seq_pro = ' + IntTostr(SeqPro) +
                            ' and mov.i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                            ' and mov.n_qtd_mov > 0  ' +
                            ' and mov.i_cod_ope = ope.i_cod_ope ' +
                            ' and mov.i_seq_pro = pro.i_seq_pro ' +
                            SQLTextoDataEntreAAAAMMDD( 'mov.d_dat_mov', VpfDatInicio, VpfDatFim, true ) +
                            ' group by ope.c_fun_ope, mov.c_cod_uni, pro.c_cod_uni ' );
end;

{*********************** localiza o valor e qdade da ultima venda *********** }
procedure TLocalizaSumarizaEstoque.LocalizaValorDataUltimaVenda(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );
var
  VpfDatInicio, VpfDataFim : TDateTime;
begin
  VpfDatInicio := MontaData(01,VpaMes, VpaAno);
  VpfDataFim :=  MontaData(Dia(UltimoDiaMes(VpfDatInicio)),VpaMes, VpaAno);
  FechaTabela(tabela);
  LimpaSQLTabela(tabela);
  AdicionaSQLTabela(tabela, ' select  movest.d_dat_mov, (movest.n_vlr_mov / movest.n_qtd_mov) n_vlr_mov, '+
                            ' movest.c_cod_uni UnidadeMov, pro.c_cod_uni unidadePro ' +
                            ' from movestoqueprodutos movest, cadprodutos pro ' +
                            ' where movest.i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                            ' and movest.i_seq_pro = ' + IntTostr(SeqPro) +
                            ' and movest.n_qtd_mov > 0 ' +
                            ' and movest.i_seq_pro = pro.i_seq_pro ' +
                            ' and pro.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa)  +
                            ' and movest.i_lan_est = ' +
                                                 ' (select max(i_lan_est) from movestoqueprodutos mov,' +
                                                 ' cadoperacaoestoque ope ' +
                                                 ' where  i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                                                 ' and i_seq_pro = ' + IntTostr(SeqPro) +
                                                 ' and mov.d_dat_mov <= ' + SQLTextoDataAAAAMMMDD(VpfDataFim) +
                                                 ' and mov.n_qtd_mov > 0 ' +
                                                 ' and mov.i_cod_ope = ope.i_cod_ope ' +
                                                 ' and ope.c_fun_ope = ''VE'' ) ' );
  AbreTabela(tabela);
end;

{*********************** localiza o valor e qdade da ultima Compra *********** }
procedure TLocalizaSumarizaEstoque.LocalizaValorDataUltimaCompra(Tabela : TSQLQUERY; VpaMes, VpaAno, SeqPro : integer );
var
  dataInicio, DataFim : TDateTime;
begin
  DataInicio := MontaData(01,VpaMes, VpaAno);
  DataFim :=  MontaData(Dia(UltimoDiaMes(dataInicio)),VpaMes, VpaAno);
  FechaTabela(tabela);
  LimpaSQLTabela(tabela);
  AdicionaSQLTabela(tabela, ' select  movest.d_dat_mov, (movest.n_vlr_mov / movest.n_qtd_mov) n_vlr_mov, '+
                            ' movest.c_cod_uni UnidadeMov, pro.c_cod_uni unidadePro ' +
                            ' from movestoqueprodutos movest, cadprodutos pro ' +
                            ' where movest.i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                            ' and movest.i_seq_pro = ' + IntTostr(SeqPro) +
                            ' and movest.n_qtd_mov > 0 ' +
                            ' and movest.i_seq_pro = pro.i_seq_pro ' +
                            ' and pro.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa)  +
                            ' and movest.i_lan_est = ' +
                                                 ' (select max(i_lan_est) from movestoqueprodutos mov,' +
                                                 ' cadoperacaoestoque ope ' +
                                                 ' where  i_emp_fil = ' + IntTostr(Varia.CodigoEmpFil) +
                                                 ' and i_seq_pro = ' + IntTostr(SeqPro) +
                                                 ' and mov.d_dat_mov <= ' + SQLTextoDataAAAAMMMDD(DataFim) +
                                                 ' and mov.n_qtd_mov > 0 ' +
                                                 ' and mov.i_cod_ope = ope.i_cod_ope ' +
                                                 ' and ope.c_fun_ope = ''CO'' ) ' );
  AbreTabela(tabela);
end;

{******* localiza um produto na tabela de sumarizacoes conforme mes e ano **** }
procedure TLocalizaSumarizaEstoque.LocalizaSumarizaEstoque(Tabela : TSQL; VpaMes, VpaAno, SequencialProduto : integer );
begin
  AdicionaSQLAbreTabela(tabela, ' Select * from MovSumarizaEstoque where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) +
                                ' and i_mes_fec = ' + IntToStr(VpaMes) +
                                ' and i_ano_fec = ' + IntToStr(VpaAno) +
                                ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpFil));
end;

{******************************************************************************}
procedure TLocalizaSumarizaEstoque.LocalizaQdadeInconsistentes(Tabela : TDataset; seqProduto : Integer);
var
  produto : string;
begin
  if seqProduto <> 0 then
    produto := ' and sum.i_seq_pro = ' + IntTostr(seqProduto)
  else
    produto := '';

  FechaTabela(tabela);
  AdicionaSQLAbreTabela(tabela, ' select sum.i_seq_pro, sum.i_cod_fec, sum.n_qtd_pro sumaQdade, ' +
                                ' mov.n_qtd_pro MovQdade, pro.c_nom_pro, pro.c_cod_uni ' +
                                ' from movsumarizaestoque sum, movqdadeproduto mov, cadprodutos  pro ' +
                                ' where sumaQdade <> MovQdade ' +
                                produto +
                                ' and sum.d_dat_mes = ( select max(d_dat_mes) from movsumarizaestoque sum1 ' +
                                '                       where sum1.i_seq_pro = sum.i_seq_pro ' +
                                '                       and sum1.i_emp_fil = sum.i_emp_fil) ' +
                                ' and sum.i_seq_pro = mov.i_seq_pro ' +
                                ' and sum.i_emp_fil = mov.i_emp_fil ' +
                                ' and sum.i_seq_pro = pro.i_seq_pro ' +
                                ' and pro.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
                                ' and mov.i_emp_fil = ' + IntToStr(Varia.CodigoEmpFil));
end;

{****** localiza um produto na tabela de sumarizacoes conforme cod sumariza *** }
procedure TLocalizaSumarizaEstoque.LocalizaProdutoCodSumariza(Tabela : TSQLQUERY; SeqSumariza : integer );
begin
  FechaTabela(tabela);
  AdicionaSQLAbreTabela(tabela, ' Select * from MovSumarizaEstoque where ' +
                                ' i_cod_fec = ' + IntToStr(SeqSumariza) +
                                ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpFil));
end;

{************** localiza a operacao de estoque ******************************* }
procedure TLocalizaSumarizaEstoque.LocalizaOpercaoEstoque(Tabela : TSQLQUERY; CodigoOP : integer );
begin
  AdicionaSQLAbreTabela(tabela, ' Select * from CadOperacaoEstoque where ' +
                                ' i_cod_ope = ' + IntToStr(CodigoOP) );
end;

{#############################################################################
                        TFuncoes Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesSumarizaEstoque.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  VprBaseDados := VpaBaseDados;
  Tabela := TSQLQuery.Create(aowner);
  Tabela.SQLConnection := VpaBaseDados;
  Produtos := TSQLQuery.Create(aowner);
  Produtos.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(aowner);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.Create(aowner);
  Aux.SQLConnection := VpaBaseDados;
end;

{************** atualiza o ultimo dia de fechamento de estoque ****************}
procedure TFuncoesSumarizaEstoque.AtuDiaFechamentoEst(VpaDia : TDateTime);
begin
  ExecutaComandoSql(Tabela,'Update CadFiliais '+
                           ' Set D_ULT_FEC =  ' + SQLTextoDataAAAAMMMDD(VpaDia)+
                           ' Where I_EMP_FIL = '+ IntToStr(Varia.CodigoEmpFil));
  varia.DataUltimoFechamento := VpaDia;
end;

{******************************************************************************}
procedure TFuncoesSumarizaEstoque.ExcluiMovEstoque(VpaFilial : Integer;VpaDatInicio,VpaDatFim : TDateTime);
begin
  ExecutaComandoSql(Aux,'Delete from MOVESTOQUEPRODUTOS '+
                     ' Where I_EMP_FIL = '+IntToStr(VpaFilial)+
                     SQLTextoDataEntreAAAAMMDD('D_DAT_MOV',VpaDatInicio,VpaDatFim,true));
end;

{******************************************************************************}
procedure TFuncoesSumarizaEstoque.PosCaOrcamentoMes(VpaTabela : TDataSet;VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime);
begin
  AdicionaSQlAbreTabela(VpaTabela,'Select I_EMP_FIL, I_LAN_ORC, N_VLR_TOT, D_DAT_ORC '+
                                  ' From CADORCAMENTOS '+
                                  ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                                  ' and I_TIP_ORC = 1 '+
                                  SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                                  ' order by D_DAT_ORC');
end;

{******************************************************************************}
function TFuncoesSumarizaEstoque.RValTotalProdutos(VpaEmpfil, VpaLanOrcamento : Integer;var VpaVaTotalComDesconto : Double) : Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select SUM(N_VLR_TOT) TOTAL, SUM((N_VLR_TOT * (100- N_PER_DES))/100) TOTALCOMDESCONTO '+
                            ' FROM MOVORCAMENTOS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaEmpfil)+
                            ' and I_LAN_ORC = ' +IntToStr(VpaLanOrcamento));
  result := Aux.FieldByname('TOTAL').AsFloat;
  VpaVaTotalComDesconto := Aux.FieldByname('TOTALCOMDESCONTO').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesSumarizaEstoque.GeraMovEstoqueOrcamento(VpaCodFilial, VpaLanOrcamento : Integer;VpaDatMovimento : TDateTime; VpaValTotal : Double);
var
  VpfValTotalProdutos, VpfValTotalProdutosComDesconto, VpfIndice, VpfValMovimento :Double;
  VpfProdutoComDesconto : boolean;
begin
  VpfValTotalProdutos := RValTotalProdutos(VpaCodFilial,VpaLanOrcamento,VpfValTotalProdutosComDesconto);
  if VpfValTotalProdutos = 0 then
    exit;
  VpfProdutoComDesconto := false;
  VpfIndice := 1;
  if ArredondaDecimais(VpaValTotal,2) <> ArredondaDecimais(VpfValTotalProdutos,2)  then
  begin
    if VpfValTotalProdutos < VpaValTotal then
      VpfIndice := (VpaValTotal )/VpfValTotalProdutos
    else
      if VpfValTotalProdutos > VpaValTotal then
      begin
        if VpaValTotal >= (VpfValTotalProdutosComDesconto)  then
        begin
          VpfProdutoComDesconto := true;
          if VpfValTotalProdutosComDesconto > 0 then
            VpfIndice := (VpaValTotal)/VpfValTotalProdutosComDesconto;
        end
        else
        begin
          if VpfValTotalProdutos > 0 then
            VpfIndice := (VpaValTotal)/VpfValTotalProdutos;
        end;
      end;
  end;
  AdicionaSQLAbreTabela(Produtos,'select MOV.I_EMP_FIL, MOV.I_LAN_ORC,  MOV.I_SEQ_PRO, MOV.N_QTD_PRO, MOV.N_VLR_TOT, '+
                                 ' MOV.C_COD_UNI, MOV.I_COD_COR, MOV.N_PER_DES, QTD.N_VLR_CUS '+
                                 ' from MOVORCAMENTOS MOV, MOVQDADEPRODUTO QTD '+
                                 ' Where MOV.I_SEQ_PRO = QTD.I_SEQ_PRO '+
                                 ' And MOV.I_EMP_FIL =  QTD.I_EMP_FIL '+
                                 ' and MOV.I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                                 ' and MOV.I_LAN_ORC = ' +IntToStr(VpaLanOrcamento));
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVESTOQUEPRODUTOS'+
                                 ' Where I_EMP_FIL = 0 AND I_LAN_EST = 0 AND I_SEQ_PRO = 0');
  While not Produtos.eof do
  begin
    Cadastro.insert;
    Cadastro.FieldByname('I_EMP_FIL').AsInteger := VpaCodFilial;
    Cadastro.FieldByname('I_SEQ_PRO').AsInteger := Produtos.FieldByname('I_SEQ_PRO').AsInteger;
    Cadastro.FieldByname('I_COD_OPE').AsInteger := 1101;
    Cadastro.FieldByname('D_DAT_MOV').AsDateTime := VpaDatMovimento;
    Cadastro.FieldByname('N_QTD_MOV').AsFloat := Produtos.FieldByname('N_QTD_PRO').AsFloat;
    Cadastro.FieldByname('C_TIP_MOV').AsString := 'S';
    if VpfProdutoComDesconto then
      VpfValMovimento := (Produtos.FieldByname('N_VLR_TOT').AsFloat * (100 - Produtos.FieldByname('N_PER_DES').AsFloat))/100
    else
      VpfValMovimento := Produtos.FieldByname('N_VLR_TOT').AsFloat;
    VpfValMovimento := VpfValMovimento * VpfIndice;
    Cadastro.FieldByname('N_VLR_MOV').AsFloat := VpfValMovimento;
    Cadastro.FieldByname('C_COD_UNI').AsString := Produtos.FieldByname('C_COD_UNI').AsString;
    Cadastro.FieldByname('I_NRO_NOT').AsInteger := Produtos.FieldByname('I_LAN_ORC').AsInteger;
    Cadastro.FieldByname('D_DAT_CAD').AsDateTime := VpaDatMovimento;
    Cadastro.FieldByname('I_COD_COR').AsInteger := Produtos.FieldByname('I_COD_COR').AsInteger;
    Cadastro.FieldByname('N_VLR_CUS').AsFloat := Produtos.FieldByname('N_QTD_PRO').AsFloat * Produtos.FieldByname('N_VLR_CUS').AsFloat;
    Cadastro.FieldByname('I_LAN_ORC').AsInteger := Produtos.FieldByname('I_LAN_ORC').AsInteger;

    Cadastro.FieldByname('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil, false,Cadastro.ASQlConnection );
    Cadastro.post;

    Produtos.next;
  end;
  Produtos.close;
  Cadastro.close;
end;

{************ qual campo para sumariza, se qcordo com a op de estoque *********}
procedure TFuncoesSumarizaEstoque.CamposSumarizaMes( var VpaValorMes, VpaQdadeMes : string; VpaFuncaoEstoque : string );
begin
  if VpaFuncaoEstoque = 'VE' then  // venda mes
  begin  VpaQdadeMes := 'N_QTD_VEN_MES';  VpaValorMes := 'N_VLR_VEN_MES'; end else
   if VpaFuncaoEstoque = 'CO' then  // compra mes
   begin  VpaQdadeMes := 'N_QTD_COM_MES';  VpaValorMes := 'N_VLR_COM_MES'; end else
     if VpaFuncaoEstoque = 'DV' then  // devolucao de venda
     begin  VpaQdadeMes := 'N_QTD_DEV_VEN';  VpaValorMes := 'N_VLR_DEV_VEN'; end else
       if VpaFuncaoEstoque = 'DC' then  // devolucao de compra
       begin  VpaQdadeMes := 'N_QTD_DEV_COM';  VpaValorMes := 'N_VLR_DEV_COM'; end else
         if VpaFuncaoEstoque = 'TS' then   // transferencia saida
         begin  VpaQdadeMes := 'N_QTD_TRA_SAI';  VpaValorMes := 'N_VLR_TRA_SAI'; end else
           if VpaFuncaoEstoque = 'TE' then   // transferencia entrada
           begin  VpaQdadeMes := 'N_QTD_TRA_ENT';  VpaValorMes := 'N_VLR_TRA_ENT'; end else
             if VpaFuncaoEstoque = 'OS' then  //outros saida
             begin  VpaQdadeMes := 'N_QTD_OUT_SAI';  VpaValorMes := 'N_VLR_OUT_SAI'; end else
               if VpaFuncaoEstoque = 'OE' then  // outros compra
               begin  VpaQdadeMes := 'N_QTD_OUT_ENT';  VpaValorMes := 'N_VLR_OUT_ENT'; end;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesSumarizaEstoque.Destroy;
begin
  FechaTabela(tabela);
  produtos.Close;
  Cadastro.Close;
  Aux.Close;
  Tabela.Destroy;
  Produtos.free;
  Cadastro.free;
  Aux.Free;
  inherited destroy;
end;

{************ efetua o fechamento mensal de estoque ************************* }
procedure TFuncoesSumarizaEstoque.FechaMes( VpaMes, VpaAno : integer; VpaBarra : TProgressBar  );
var
  VpfQdadeMes, VpfValorMes : string;
  VpfValor, VpfQdade, VpfValIcms : double;
begin
//  VpfValIcms :=   FunProdutos.RIcmsEstado(varia.EstadoPadrao);
// foi atribuido o icms = 0 porque existe muita venda sem icms.
  VpfValIcms := 0;
  VpaBarra.Position := 0;
  VpaBarra.Max := SomaProdutos;

  LocalizaMovQdadeProduto(Produtos);
  while not Produtos.Eof do
  begin
    LocalizaSumarizaEstoque(Cadastro, VpaMes, VpaAno, Produtos.fieldByname('i_seq_pro').AsInteger);
    if Cadastro.Eof then
    begin
      Cadastro.Insert;
      Cadastro.FieldByName('i_emp_fil').AsInteger := varia.CodigoEmpFil;
      Cadastro.FieldByName('i_cod_fec').AsInteger := ProximoCodigoFilial( 'MovSumarizaEstoque','i_cod_fec','i_emp_fil',varia.CodigoEmpFil,VprBaseDados);
      Cadastro.FieldByName('i_seq_pro').AsInteger := Produtos.fieldByname('i_seq_pro').AsInteger;
      Cadastro.FieldByName('i_mes_fec').AsInteger := VpaMes;
      Cadastro.FieldByName('i_ano_fec').AsInteger := VpaAno;
      Cadastro.FieldByName('d_dat_mes').AsDateTime := MontaData(15,VpaMes, VpaAno);
    end
    else
      Cadastro.edit;

    Cadastro.FieldByName('N_QTD_COM_MES').AsCurrency := 0;
    Cadastro.FieldByName('N_QTD_TRA_ENT').AsCurrency := 0;
    Cadastro.FieldByName('N_QTD_OUT_ENT').AsCurrency := 0;
    Cadastro.FieldByName('N_QTD_DEV_VEN').AsCurrency := 0;
    Cadastro.FieldByName('N_QTD_VEN_MES').AsCurrency := 0;
    Cadastro.FieldByName('N_QTD_OUT_SAI').AsCurrency := 0;
    Cadastro.FieldByName('N_QTD_TRA_SAI').AsCurrency := 0;
    Cadastro.FieldByName('N_QTD_DEV_COM').AsCurrency := 0;

    Cadastro.FieldByName('N_VLR_COM_MES').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_TRA_ENT').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_OUT_ENT').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_DEV_VEN').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_VEN_MES').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_OUT_SAI').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_TRA_SAI').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_DEV_COM').AsCurrency := 0;
    Cadastro.FieldByName('N_VLR_GIR').AsCurrency := 0;
    Cadastro.FieldByName('n_qtd_ven').AsCurrency := 0;
    Cadastro.FieldByName('n_qtd_com').AsCurrency := 0;
    Cadastro.FieldByName('n_vlr_cmv').AsCurrency := 0;
    // VE  Venda - CO  Compra - DV  Devolução de Venda
    // DC  Devolução de Compra -  TS  Transferência Saída
    // TE  Transferência Entrada - OS  Outros Saída - OE  Outro Entrada
    LocalizaQdadeOperacaoPeriodo(aux, VpaMes, VpaAno, Produtos.fieldByname('i_seq_pro').AsInteger);
    while not Aux.Eof do
    begin
       CamposSumarizaMes(VpfValorMes, VpfQdadeMes, aux.fieldByName('c_fun_ope').AsString);

       if aux.fieldByName('UnidadeMov').AsString <> aux.fieldByName('UnidadePro').AsString then
       begin
          VpfValor := FunProdutos.CalculaValorPadrao( aux.fieldByName('UnidadeMov').AsString,
                                             aux.fieldByName('UnidadePro').AsString,
                                             aux.fieldByName('valor').AsCurrency,
                                             Produtos.fieldByname('i_seq_pro').AsString );

          VpfQdade := FunProdutos.CalculaQdadePadrao( aux.fieldByName('UnidadeMov').AsString,
                                             aux.fieldByName('UnidadePro').AsString,
                                             aux.fieldByName('qdade').AsCurrency,
                                             Produtos.fieldByname('i_seq_pro').AsString );
       end
       else
       begin
         VpfValor := aux.fieldByName('valor').AsCurrency;
         VpfQdade := aux.fieldByName('qdade').AsCurrency;
       end;

       Cadastro.FieldByName(VpfValorMes).AsCurrency := VpfValor + Cadastro.FieldByName(VpfValorMes).AsCurrency;
       Cadastro.FieldByName(VpfQdadeMes).AsCurrency := VpfQdade + Cadastro.FieldByName(VpfQdadeMes).AsCurrency;
       if aux.fieldByName('c_fun_ope').AsString = 'VE' then  //ser for venda atualiza o valor de custo da venda;
       begin
         Cadastro.FieldByName('N_VLR_CMV').AsCurrency :=  Cadastro.FieldByName('N_VLR_CMV').AsCurrency +  Aux.FieldByName('VALORCUSTO').AsFloat;
//calcula sobre o valor de custo atual do produto         Cadastro.FieldByName('N_VLR_CMV').AsCurrency :=  Cadastro.FieldByName('N_VLR_CMV').AsCurrency + (Produtos.FieldByName('N_VLR_CUS').AsFloat *  VpfQdade);
       end
       else
         if aux.fieldByName('c_fun_ope').AsString = 'DV' then  //ser for DEVOLUCAO SUBTRAI DO CUSTO DE VENDA.
           Cadastro.FieldByName('N_VLR_CMV').AsCurrency :=  Cadastro.FieldByName('N_VLR_CMV').AsCurrency -  Aux.FieldByName('VALORCUSTO').AsFloat;

       aux.next;
    end;
    if (Cadastro.FieldByName('N_QTD_VEN_MES').AsFloat - Cadastro.FieldByName('N_QTD_DEV_VEN').AsFloat <=0) then
      Cadastro.FieldByName('N_VLR_CMV').Asfloat := 0;

    // estoque anterior, qdade vendida, qdade comprada.
    LocalizaEstoqueAnteriorProduto(aux, VpaMes, VpaAno,Produtos.fieldByname('i_seq_pro').AsInteger);
    Cadastro.FieldByName('n_qtd_ant').AsCurrency := Aux.fieldByname('n_qtd_pro').AsCurrency;
    Cadastro.FieldByName('n_qtd_ven').AsCurrency := Cadastro.FieldByName('n_qtd_ven_mes').AsCurrency + Aux.fieldByname('n_qtd_ven').AsInteger;
    Cadastro.FieldByName('n_qtd_com').AsCurrency := Cadastro.FieldByName('n_qtd_com_mes').AsCurrency + Aux.fieldByname('n_qtd_com').AsInteger;

    if Cadastro.FieldByName('n_qtd_com').AsCurrency <> 0 then
      Cadastro.FieldByName('n_vlr_cmc').AsCurrency := ((Aux.fieldByname('n_qtd_com').AsCurrency *
                                                   Aux.fieldByname('n_vlr_cmc').AsCurrency) +
                                                   Cadastro.FieldByName('n_vlr_com_mes').AsCurrency) /
                                                   Cadastro.FieldByName('n_qtd_com').AsCurrency

    else
      Cadastro.FieldByName('n_vlr_cmc').AsCurrency := 0;

    // ultima venda
    LocalizaValorDataUltimaVenda(aux, VpaMes, VpaAno,Produtos.fieldByname('i_seq_pro').AsInteger);
    Cadastro.FieldByName('d_ult_ven').AsDateTime := Aux.fieldByname('d_dat_mov').AsDateTime;
    if aux.fieldByName('UnidadeMov').AsString <> aux.fieldByName('UnidadePro').AsString then
      Cadastro.FieldByName('n_vlr_ven').AsCurrency := FunProdutos.CalculaValorPadrao(
                                                  aux.fieldByName('UnidadeMov').AsString,
                                                  aux.fieldByName('UnidadePro').AsString,
                                                  aux.fieldByName('n_vlr_mov').AsCurrency,
                                                  Produtos.fieldByname('i_seq_pro').AsString )
    else
      Cadastro.FieldByName('n_vlr_ven').AsCurrency := Aux.fieldByname('n_vlr_mov').AsCurrency;


    Cadastro.FieldByName('n_vlr_ven_LIQ').AsCurrency := Cadastro.FieldByName('n_vlr_ven_Mes').AsCurrency - (Cadastro.FieldByName('n_vlr_ven_Mes').AsCurrency *((Varia.PerPIS + Varia.PerCOFINS+VpfValIcms) /100));
    // ultima compra
    LocalizaValorDataUltimaCompra(aux, VpaMes, VpaAno,Produtos.fieldByname('i_seq_pro').AsInteger);
    Cadastro.FieldByName('d_ult_com').AsDateTime := Aux.fieldByname('d_dat_mov').AsDateTime;
    if aux.fieldByName('UnidadeMov').AsString <> aux.fieldByName('UnidadePro').AsString then
      Cadastro.FieldByName('n_vlr_com').AsCurrency := FunProdutos.CalculaValorPadrao(
                                                  aux.fieldByName('UnidadeMov').AsString,
                                                  aux.fieldByName('UnidadePro').AsString,
                                                  aux.fieldByName('n_vlr_mov').AsCurrency,
                                                  Produtos.fieldByname('i_seq_pro').AsString )
    else
      Cadastro.FieldByName('n_vlr_com').AsCurrency := Aux.fieldByname('n_vlr_mov').AsCurrency;

    // quantidade de produtos
    Cadastro.FieldByName('N_QTD_PRO').AsFloat := ( Cadastro.FieldByName('N_QTD_ANT').AsCurrency +
                                               Cadastro.FieldByName('N_QTD_COM_MES').AsCurrency +
                                               Cadastro.FieldByName('N_QTD_TRA_ENT').AsCurrency +
                                               Cadastro.FieldByName('N_QTD_OUT_ENT').AsCurrency +
                                               Cadastro.FieldByName('N_QTD_DEV_VEN').AsCurrency  ) -
                                             ( Cadastro.FieldByName('N_QTD_VEN_MES').AsCurrency +
                                               Cadastro.FieldByName('N_QTD_OUT_SAI').AsCurrency +
                                               Cadastro.FieldByName('N_QTD_TRA_SAI').AsCurrency +
                                               Cadastro.FieldByName('N_QTD_DEV_COM').AsCurrency );
    //se houve venda no mes
{    if Cadastro.FieldByName('n_qtd_ven_mes').AsCurrency <> 0 then
    begin
      Cadastro.FieldByName('N_VLR_GIR').AsCurrency := Cadastro.FieldByName('N_QTD_PRO').AsFloat / Cadastro.FieldByName('n_qtd_ven_mes').AsFloat;
    end;}

    //Flaga se imprime ou não o relatorio
    if (Cadastro.FieldByName('N_QTD_PRO').AsFloat = 0) and (Cadastro.FieldByName('N_QTD_ANT').AsFloat = 0) and
       (Cadastro.FieldByName('N_QTD_VEN_MES').AsFloat = 0)and (Cadastro.FieldByName('N_QTD_DEV_VEN').AsFloat = 0) Then
      Cadastro.FieldByName('C_REL_PRO').AsString := 'N'
    else
      Cadastro.FieldByName('C_REL_PRO').AsString := 'S';
    Cadastro.post;
    Produtos.next;

    VpaBarra.Position := VpaBarra.Position  + 1;
  end;

  VpaBarra.position := VpaBarra.max;

  ExecutaComandoSql(aux, ' update cfg_produto set i_mes_est = ' + Inttostr(VpaMes) + ', ' +
                         ' i_ano_est = ' + Inttostr(VpaAno) );
end;

{************ efetua o fechamento Geral de estoque ************************* }
procedure TFuncoesSumarizaEstoque.FechaMesGeral(VpaMesInicio, VpaAnoInicio, VpaMesFim, VpaAnoFim : integer; Barra : TProgressBar );
var
  VpfTempo : TPainelTempo;
  VpfDatInicio, VpfDatFim : TDateTime;
begin
  VpfDatInicio := MontaData(01, VpaMesInicio, VpaAnoInicio);
  VpfDatFim :=  MontaData(15,VpaMesFim, VpaAnoFim);

  if (tabela.owner is TWinControl) then
  begin
    VpfTempo := TPainelTempo.create(Tabela.Owner);
    VpfTempo.parent := (tabela.owner as TWinControl);
  end;

  while VpfDatInicio < VpfDatFim do
  begin
    if (tabela.owner is TWinControl) then
      VpfTempo.execute('Efetuando fechamento do Mes ' + InttoStr(mes(VpfDatInicio)) + '/' + InttoStr(ano(VpfDatInicio)) + ', aguarde...' );
    FechaMes(mes(VpfDatInicio), ano(VpfDatInicio), Barra);
    VpfDatInicio := IncMes(VpfDatInicio,1);
  end;

  AtuDiaFechamentoEst(UltimoDiaMes(VpfDatFim));
  VpfTempo.fecha;
  VpfTempo.free;
end;

{************** acerta o estoque do fechamento ****************************** }
procedure  TFuncoesSumarizaEstoque.AcertoFechamento( OpeSaida, OpeEntrada, SeqPro : integer);
var
  operacao : integer;
  Qdade : Double;
  SaidaEntrada : string;
begin
  LocalizaQdadeInconsistentes(tabela, SeqPro);
  while Not tabela.Eof do
  begin
      if Tabela.fieldByname('movQdade').AsCurrency < Tabela.fieldByname('sumaQdade').AsCurrency  then
      begin
        Qdade := Tabela.fieldByname('sumaQdade').AsCurrency - Tabela.fieldByname('movQdade').AsCurrency;
        operacao := OpeSaida;
        SaidaEntrada := 'S';
      end
      else
      begin
        Qdade :=  Tabela.fieldByname('movQdade').AsCurrency - Tabela.fieldByname('sumaQdade').AsCurrency;
        operacao := OpeEntrada;
        SaidaEntrada := 'E';
      end;

      AcertaMovEstoque( Tabela.FieldByName('i_seq_pro').AsInteger,operacao,qdade,SaidaEntrada,
                        tabela.fieldByName('c_cod_uni').AsString);
    tabela.next;
  end;
end;

{*************** grava uma movimentacao de estoque para acerto ************** }
procedure TFuncoesSumarizaEstoque.AcertaMovEstoque( SeqPro, Operacao : integer; Qdade : Double; SaidaEntrada, Unidade : string);
var
  VpfAcerto : TSQL;
begin
  VpfAcerto := TSQL.Create(nil);
  VpfAcerto.ASQLConnection := VprBaseDados;
  LimpaSQLTabela(VpfAcerto);
  AdicionaSQLTabela(VpfAcerto, ' Select * From MovEstoqueProdutos ');
  VpfAcerto.Open;
  VpfAcerto.insert;
  VpfAcerto.FieldByName('I_EMP_FIL').AsInteger := varia.CodigoEmpFil;
  VpfAcerto.FieldByName('I_LAN_EST').AsInteger := ProximoCodigoFilial('MovEstoqueProdutos','I_LAN_EST', 'I_EMP_FIL', varia.CodigoEmpFil,VprBaseDados );
  VpfAcerto.FieldByName('I_SEQ_PRO').AsInteger := SeqPro;
  VpfAcerto.FieldByName('I_COD_OPE').AsInteger := operacao;
  VpfAcerto.FieldByName('D_DAT_MOV').AsDateTime := date;
  VpfAcerto.FieldByName('N_QTD_MOV').AsFloat := Qdade;
  VpfAcerto.FieldByName('C_TIP_MOV').AsString := SaidaEntrada;
  VpfAcerto.FieldByName('N_VLR_MOV').AsFloat := 0;
  VpfAcerto.FieldByName('D_DAT_CAD').AsDateTime := date;
  VpfAcerto.FieldByName('C_COD_UNI').AsString := unidade;
  GravaReg(VpfAcerto);
  FechaTabela(VpfAcerto);
  VpfAcerto.Free;
end;

{************** acerta o estoque do fechamento ****************************** }
procedure TFuncoesSumarizaEstoque.AcertoEstoqueAtual( SeqPro : integer);
var
  VpfAcerto : TSQL;
begin
  VpfAcerto := TSQL.Create(nil);
  VpfAcerto.ASQLConnection := VprBaseDados;
  LimpaSQLTabela(VpfAcerto);

  LocalizaQdadeInconsistentes(tabela, SeqPro);
  while Not tabela.Eof do
  begin
      AdicionaSQLAbreTabela(VpfAcerto, ' select * from movQdadeProduto '  +
                                    ' where i_seq_pro = ' + Tabela.FieldByName('i_seq_pro').AsString  +
                                    ' and i_emp_fil = ' + InttoStr(varia.CodigoEmpFil) );
      VpfAcerto.edit;
      VpfAcerto.fieldByname('n_qtd_pro').AsCurrency := Tabela.fieldByname('sumaQdade').AsCurrency;
      VpfAcerto.post;
    tabela.next;
  end;
  VpfAcerto.free;
end;

{***************  Gera o relatorio ****************************************** }
procedure TFuncoesSumarizaEstoque.AdicionaTemporaria( VetorMascara : array of byte; FilialAtual : string; Mes, Ano, Grupo : integer);
var
  Nivel, Filial : string;
  VpfAux : TSqlQuery;
  VpTemporaria : TSQL;
begin
  VpfAux := TSQLQUERY.Create(nil);
  VpfAux.SQLConnection := VprBaseDados;
  VpTemporaria := TSQL.Create(nil);
  VpTemporaria.ASQLConnection := VprBaseDados;

   nivel := intTostr(VetorMascara[Grupo]);
   if FilialAtual <> '' then
     Filial := ' and Mov.i_emp_fil  = ' + FilialAtual
   else
     Filial := '';

   LimpaSQLTabela(VpfAux);
   AdicionaSQLTabela(VpfAux,
     ' select ' +

     ' mov.i_emp_fil ,  ' +
     ' left(pro.c_cod_cla, ' + nivel + ' ) classificacao, cla.c_nom_cla,  ' +
     ' sum(n_qtd_ant) EstAnterior , sum(n_qtd_ant * Qtd.n_vlr_Com )  ValorAnterior,  ' +
     ' sum(mov.n_qtd_pro) Estatual , sum(mov.n_qtd_pro * Qtd.n_vlr_com )  ValorAtual,  ' +
     ' sum(mov.n_vlr_ven_mes - mov.n_vlr_dev_ven) ValorMes,  ' +
     ' sum(mov.n_qtd_ven_mes - mov.n_qtd_dev_ven) QdadeMes  ' +

     ' from movsumarizaestoque mov, Cadprodutos pro, cadclassificacao cla,  ' +
     ' MovTabelaPreco  Tab, cadMoedas moe, MovQdadeproduto Qtd  ' +
     ' where  ' +

     ' mov.i_mes_fec = ' + IntTostr(Mes) +
     ' and mov.i_ano_fec = ' + IntToStr(Ano) +
     ' and cla.c_tip_cla = ''P''   ' +
     Filial +

     ' and Mov.i_seq_pro = pro.i_seq_pro  ' +
     ' and pro.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
     ' and cla.c_cod_cla = classificacao  ' +
     ' and mov.i_seq_pro = tab.i_seq_pro  ' +
     ' and tab.I_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
     ' and tab.i_cod_tab  = ' + IntToStr(varia.TabelaPreco) +
     ' and tab.i_cod_moe = moe.i_cod_Moe  ' +
     ' and pro.i_seq_pro = qtd.i_seq_Pro  ' +
     ' and qtd.i_Emp_fil = Mov.I_Emp_fil '+
     ' AND TAB.I_COD_CLI = 0'+

     ' group by  mov.i_emp_fil,left(pro.c_cod_cla,' + nivel + '), cla.c_nom_cla  ' +
//     ' having length(left(pro.c_cod_cla,' + nivel + ')) = ' + nivel +
     ' order by left(pro.c_cod_cla,' + nivel + ') ');
  AbreTabela(VpfAux);

  LimpaSQLTabela(VpTemporaria);
  AdicionaSQLTabela(VpTemporaria, 'delete VpTemporariaEstoque');
  VpTemporaria.ExecSQL;

  AdicionaSQLAbreTabela( VpTemporaria, 'Select * from VpTemporariaEstoque');

  while not VpfAux.Eof do
  begin
    VpTemporaria.Insert;
    VpTemporaria.fieldByName('I_EMP_FIL').AsInteger := VpfAux.fieldByName('i_emp_fil').AsInteger;
    if Grupo >= 0 then
      VpTemporaria.fieldByName('C_GRU_001').AsString := copy(VpfAux.fieldByName('classificacao').AsString,1,vetormascara[0]);
    if Grupo >= 1 then
      VpTemporaria.fieldByName('C_GRU_002').AsString := copy(VpfAux.fieldByName('classificacao').AsString,1,vetormascara[1]);
    if Grupo >= 2 then
      VpTemporaria.fieldByName('C_GRU_003').AsString := copy(VpfAux.fieldByName('classificacao').AsString,1,vetormascara[2]);
    if Grupo >= 3 then
      VpTemporaria.fieldByName('C_GRU_004').AsString := copy(VpfAux.fieldByName('classificacao').AsString,1,vetormascara[3]);
    if Grupo >= 4 then
      VpTemporaria.fieldByName('C_GRU_005').AsString := copy(VpfAux.fieldByName('classificacao').AsString,1,vetormascara[4]);

    VpTemporaria.fieldByName('C_COD_CLA').AsString := VpfAux.fieldByName('classificacao').AsString;
    VpTemporaria.fieldByName('C_NOM_CLA').AsString := VpfAux.fieldByName('c_nom_cla').AsString;
    VpTemporaria.fieldByName('N_EST_ANT').AsCurrency := VpfAux.fieldByName('EstAnterior').AsCurrency;
    VpTemporaria.fieldByName('N_VLR_ANT').AsCurrency := VpfAux.fieldByName('ValorAnterior').AsCurrency;
    VpTemporaria.fieldByName('N_EST_ATU').AsCurrency := VpfAux.fieldByName('EstAtual').AsCurrency;
    VpTemporaria.fieldByName('N_VLR_ATU').AsCurrency := VpfAux.fieldByName('ValorAtual').AsCurrency;
    VpTemporaria.fieldByName('N_VLR_VEN').AsCurrency := VpfAux.fieldByName('ValorMes').AsCurrency;
    VpTemporaria.fieldByName('N_QTD_VEN').AsCurrency := VpfAux.fieldByName('QdadeMes').AsCurrency;
//    VpTemporariaN_GIR_EST.AsCurrency := VpfAux.fieldByName('i_emp_fil').AsCurrency;
    VpTemporaria.post;
    VpfAux.Next;
  end;
  FechaTabela(VpfAux);
  FechaTabela(VpTemporaria);
  VpTemporaria.Free;
  VpfAux.Free;
end;

{******************************************************************************}
procedure TFuncoesSumarizaEstoque.ReprocessaMes(VpaMesInicio, VpaAnoInicio, VpaMesFim, VpaAnoFim : Integer);
var
  VpfDataInicio, VpfDataFim : TDateTime;
begin
  VpfDataInicio := MontaData(1,VpaMesInicio,VpaAnoInicio);
  VpfDataFim := UltimoDiaMes(MontaData(1,VpaMesFim,VpaAnoFim));
  ExcluiMovEstoque(varia.CodigoEmpFil,VpfDataInicio,VpfDataFim);
  PosCaOrcamentoMes(Tabela,Varia.CodigoEmpFil,VpfDataInicio,VpfDataFim);
  While not Tabela.eof do
  begin
    GeraMovEstoqueOrcamento(Tabela.FieldByname('I_EMP_FIL').AsInteger,Tabela.FieldByname('I_LAN_ORC').AsInteger,Tabela.FieldByname('D_DAT_ORC').AsDateTime,
                            Tabela.FieldByname('N_VLR_TOT').AsFloat);
    Tabela.Next;
  end;
end;

end.
