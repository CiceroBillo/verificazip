Unit UnContrato;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, UnDados, SysUtils,ComCtrls, UnDadosProduto, UnClientes, UnCotacao, Unsistema,
     UnContasAReceber, ANovaNotaFiscalNota, Forms,stdctrls, UnNotaFiscal, UnImpressaoBoleto, UnDadosCR,
     UnVendedor, SQLExpr, Tabela,db,IdAttachmentfile, idText, IdMessage, IdSMTP, unchamado,Graphics, dmRave;

//classe localiza
Type TRBLocalizaContrato = class
  private
  public
    constructor cria;
    procedure LContratosAExecutar(VpaTabela : TDataSet;VpaCodTipoContrato : Integer;VpaNaoFaturarReajustes :Boolean);
    procedure LFaturamentosPosteriores(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime;VpaCodCliente : Integer;var VpaQtd : Integer);
end;
//classe funcoes
Type TRBFuncoesContrato = class(TRBLocalizaContrato)
  private
    Aux,
    Tabela,
    ContratosAExecutar,
    FaturamentoPosterior : TSQLQuery;
    Cadastro : TSQL;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    VprBarraStatus : TStatusbar;
    FunImpFolhaBranca: TImpressaoBoleto;
    FunChamado : TRBFuncoesChamado;
    VprSeqRecibo: Integer;
    function RProximoSeqContrato(VpaCodFilial : Integer) : Integer;
    function RSeqReajusteDisponivel: Integer;
    function RProximoSeqLeituraLocacao(VpaCodFilial : Integer):Integer;
    function RPlanoContasTipoContrato(VpaCodTipoContrato : Integer):String;
    function RSeqProcessadoDisponivel(VpaCodFilial: Integer) : Integer;
    function RSeqReciboDisponivel(VpaCodFilial : Integer) : Integer;
    procedure AtualizaStatus(VpaTexto : String);
    function GravaDContratoItem(VpaDContrato : TRBDContratoCorpo):String;
    function GravaDContratoServico(VpaDContrato : TRBDContratoCorpo):String;
    function GravaDLeituraLocacaoItem(VpaDLeitura : TRBDLeituraLocacaoCorpo):String;
    function GravaDContratoProcessadoItem(VpaDContatoProcessado : TRBDContratoProcessadoCorpo):String;
    function GravaDContratoProcessado(VpaDContratoProcessado : TRBDContratoProcessadoCorpo) : String;
    function GravaDReciboLocacaoServico(VpaDRecibo : TRBDReciboLocacao) : string;
    function GravaDEmailMedidorItem(VpaDMedidores : TRBDEmailMedidorCorpo): String;
    function GeraCotacaoCorpoContrato(VpaDContrato : TRBDContratoCorpo;VpaDCliente : TRBDCliente):TRBDOrcamento;
    function GeraCotacaodoFaturamentoPosterior(VpaDCotacao : TRBDOrcamento;VpaDCliente :TRBDCliente):TRBDOrcamento;
    function GeraCotacaoCorpoLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo;VpaDContrato : TRBDContratoCorpo; VpaDCliente : TRBDCliente):TRBDorcamento;
    function GeraServicoContrato(VpaDContrato : TRBDContratoCorpo;VpaDCotacao : TRBDOrcamento):TRBDOrcServico;
    function ClientePossuiContratoaReajustar(VpaCodCliente : Integer) :Boolean;
    procedure VerificaQtdMinimaFaturamento(VpaDCotacao : TRBDOrcamento);
    procedure AdicionaVendasCotacaoFaturamentoPost(VpadCotacao : TRBDOrcamento;VpaDCotacaodoMes : TRBDOrcamento);
    procedure AdicionaDescontoCotacaoFaturamentoPost(VpadCotacao : TRBDOrcamento;VpaDCotacaodoMes : TRBDOrcamento);
    function MesFaturamentoContrato(VpaDContrato : TRBDContratoCorpo):Boolean;
    procedure SetaContratoProcessado(VpaCodfilial,VpaSeqContrato : Integer);
    procedure CarDContratoItem(VpaDContrato : TRBDContratoCorpo);
    procedure CarDLeituraLocacaoItem(VpaDLeitura : TRBDLeituraLocacaoCorpo);
    procedure CarServicosCotacaoparaRecibo(VpaDCotacao : TRBDOrcamento; VpaDRecibo : TRBDReciboLocacao;VpaDLeituraLocacao : TRBDLeituraLocacaoCorpo);
    function GeraNotaExcedenteReciboLocacao(VpaDCotacao : TRBDOrcamento; VpaDCliente : TRBDCliente; VpaDLeituraLocacao : TRBDLeituraLocacaoCorpo):string;
    procedure FaturaContrato(VpaDCotacao : TRBDOrcamento;VpaDItemProcessado : TRBDContratoProcessadoItem; VpaDCliente : TRBDCliente;VpaDLeituraLocacao : TRBDLeituraLocacaoCorpo);
    procedure FaturaCrachaComoServico(VpaDCotacao : TRBDOrcamento);
    procedure InicializaDContratoProcessado(VpaDContratoProcessado : TRBDContratoProcessadoCorpo);
    function AtualizaDatUltimaLeituraCFG : string;
    procedure ExcluirFinanceiro(VpaDCotacao : TRBDOrcamento);
    procedure GeraBoletoUnicoContrato(VpaDCotacaoContrato: trbdorcamento;VpaDCliente : TRBDCliente; VpaLanOrcamentoPosterior :Integer);
    function VincularReajusteContratos(VpaSeqReajuste, VpaAno, VpaMes: Integer): String;
    procedure MontaEmailLeituraLocacao(VpaTexto : TStrings; VpaDContrato : TRBDContratoCorpo ;VpaDCliente : TRBDCliente);
    procedure MontaEmailRecibo(VpaTexto : TStrings; VpaDContrato : TRBDContratoCorpo ;VpaDCliente : TRBDCliente);
    function ArrumaFinanceiroReciboLocacao(VpaDRecibo : TRBDReciboLocacao) : string;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP) : string;
    function AnexaArquivoEmail(VpaNomArquivo : String;VpaMensagem : TIdMessage):string;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function ProcessaFaturamentoPosterior(VpaMostrador : TProgressbar;VpaEstgio : TLabel;VpaDatInicio, VpaDatFim : TDateTime;VpaCodCliente : Integer;var VpaLanOrcamento : Integer;VpaContratosProcessados :TRBDContratoProcessadoCorpo;VpaNaoFaturarReajuste : Boolean;VpaDCotacaoContrato : TRBDOrcamento):string;
    function GravaDContrato(VpaDContrato : TRBDContratoCorpo): String;
    function GravaDEmailMedidor(VpaDMedidores : TRBDEmailMedidorCorpo): string;
    function GravaDLeituraLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo):string;
    function GravaDReciboLocacao(VpaDRecibo : TRBDReciboLocacao) : string;
    procedure CarDContrato(VpaDContrato : TRBDContratoCorpo;VpaCodFilial, VpaSeqContrato : Integer);
    procedure CarDLeituraLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo;VpaCodFilial,VpaSeqLeitura : Integer);
    procedure CarDServicoContrato(VpaDContratoCorpo : TRBDContratoCorpo);
    procedure ExcluiContrato(VpaCodfilial,VpaSeqContrato : Integer);
    procedure ExcluiLeituraLocacao(VpaCodFilial,VpaSeqLeitura : Integer);
    function ExecutaFaturamentoMensal(VpaMostrador : TProgressbar;VpaEstgio : TLabel;VpaCodTipoContrato : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaNaoFaturarReajustes :Boolean):String;
    procedure InicializaLeituraContratoLocacao(VpaDContrato : TRBDContratoCorpo;VpaDLeitura : TRBDLeituraLocacaoCorpo);
    function ProcessaContratoLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo;VpaBarraStatus : TStatusBar):string;
    function MarcaContratoComoProcessado(VpaDLeitura : TRBDLeituraLocacaoCorpo;VpaBarraStatus : TStatusBar):string;
    function ExisteContratoLocacaoEmAberto(VpaCodFilial,VpaSeqContrato : Integer):Boolean;
    procedure SetaContratoAReprocessar(VpaCodfilial,VpaSeqContrato, VpaTipPerido : Integer;VpaDataUltimaExecucao : TDateTime);
    procedure SetaReprocessarContratos(VpaCodFilial,VpaSeqProcessado : Integer);
    procedure ImprimirBoleto(VpaCodFilial,VpaLanOrcamento, VpaCodCliente : Integer);
    function ReajustaContrato(VpaAno, VpaMes: Integer; VpaIndice: Double): String;
    function EnviaMedidorEmail(VpaCodFilial, VpaSeqContrato : Integer) : String;
    function EnviaLeituraLocacaoProcessadaEmail(VpaCodFilial, VpaSeqLeitura : Integer):string;
    function RNomTipoContrato(VpaCodTipoContrato : Integer) : String;
    function CarDUltimaLeituraLocacaoCliente(VpaCodFilial, vpaCodSeQContrato,VpaCodCliente: Integer):TRBDLeituraLocacaoCorpo;
    function AtualizaMedidoresContrato(VpaDLeitura : TRBDLeituraLocacaoCorpo):string;
    function ValidaNumeroSeriesProdutosContrato(VpaDContrato : TRBDContratoCorpo):string;
    function NumeroSerieDuplicado(VpaDContrato : TRBDContratoCorpo):string;
    function RSeqEmailMedidorDisponivel : Integer;
    procedure CalculaContrato(VpaDContrato : TRBDContratoCorpo );
    function ExisteServico(VpaCodServico : String;VpaDContrato : TRBDContratoCorpo; VpaDServico : TRBDContratoServico):Boolean;
    function GeraReciboLocacao(VpaDCotacao : TRBDOrcamento; VpaDCliente : TRBDCliente; VpaDLeituraLocacao : TRBDLeituraLocacaoCorpo):string;
    function CancelaRecibo(VpaCodFilial, VpaSeqRecibo: Integer;VpaMotivo : String):string;
    function CancelaContratosVigenciaVencida(VpaDataFimVigencia : TDateTime):Integer;
    function EnviaEmailCliente(VpaDContrato : TRBDContratoCorpo;VpaDCliente : TRBDCliente) : string;
end;


implementation

Uses FunSql,FunData, Constantes, FunObjeto, UnProdutos, constmsg, FunString, FunArquivos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaContrato
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaContrato.cria;
begin
  inherited create;
end;

{******************************************************************************}
procedure TRBLocalizaContrato.LContratosAExecutar(VpaTabela : TDataSet;VpaCodTipoContrato : Integer;VpaNaoFaturarReajustes :Boolean);
begin
  LimpaSQlTabela(VpaTabela);
  AdicionaSqlTabela(VpaTabela,'Select * from CONTRATOCORPO ' +
                                  ' Where CODFILIAL = '+IntToStr(Varia.CodigoEmpFil)+
                                  ' and DATCANCELAMENTO IS NULL '+
                                  ' and INDAUTOMATICO = ''S'''+
                                  ' and ( DATULTIMAEXECUCAO < '+SQLTextoDataAAAAMMMDD(PrimeiroDiaMes(date))+
                                  ' or DATULTIMAEXECUCAO IS NULL)');

  if VpaCodTipoContrato <> 0 then
    AdicionaSqlTabela(VpaTabela,' and CODTIPOCONTRATO = '+IntToStr(VpaCodtipocontrato))
  else
    AdicionaSqlTabela(VpaTabela,' and CODTIPOCONTRATO <> '+IntToStr(Varia.TipoContratoLocacao));
  if VpaNaoFaturarReajustes then
    AdicionaSqlTabela(VpaTabela,' and '+SQLTextoMes('DATASSINATURA')+' <> '+IntToStr(mes(date)));

  AdicionaSqlTabela(VpaTabela,' order by CODCLIENTE, CODCONDICAOPAGAMENTO');
  VpaTabela.open;
end;

{******************************************************************************}
procedure TRBLocalizaContrato.LFaturamentosPosteriores(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime;VpaCodCliente : Integer;var VpaQtd : Integer);
begin
  LimpaSqlTabela(VpaTabela);
  AdicionaSqlTabela(VpaTabela,'select count(*)QTD ');
  AdicionaSqlTabela(VpaTabela,'from CADORCAMENTOS ORC, CADCLIENTES CLI '+
                                  ' WHERE ORC.I_TIP_ORC = '+InttoStr(varia.TipoCotacaoFaturamentoPosterior)+
                                  SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                                  ' AND ORC.C_IND_CAN = ''N'''+
                                  ' AND ORC.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' and I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(VpaTabela,'and (CLI.I_COD_CLI = '+InttoStr(VpaCodCliente)+
                                 ' OR CLI.I_CLI_MAS = '+InttoStr(VpaCodCliente)+')' );
  if VpaCodCliente = 0 then
  begin
    VpaTabela.open;
    VpaQtd := VpaTabela.FieldByName('QTD').AsInteger;
    VpaTabela.close;
  end;
  SubstituiLinhaSQL(VpaTabela,0,'Select * ');
  AdicionaSqlTabela(VpaTabela,' ORDER BY CLI.I_COD_CLI, D_DAT_ORC');
  VpaTabela.open;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesContrato
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesContrato.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  ContratosAExecutar := TSQLQuery.Create(nil);
  ContratosAExecutar.SQLConnection := VpaBaseDados;
  FaturamentoPosterior := TSQLQuery.Create(nil);
  FaturamentoPosterior.SQLConnection := VpaBaseDados;
  FunImpFolhaBranca := TImpressaoBoleto.cria(VpaBaseDados);
  FunChamado := TRBFuncoesChamado.cria(VpaBaseDados);
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesContrato.destroy;
begin
  Cadastro.free;
  Tabela.free;
  Aux.Free;
  ContratosAExecutar.free;
  FaturamentoPosterior.free;
  FunImpFolhaBranca.free;
  FunChamado.Free;
  VprMensagem.free;
  VprSMTP.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesContrato.RProximoSeqContrato(VpaCodFilial : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQCONTRATO) ULTIMO from CONTRATOCORPO '+
                            ' Where CODFILIAL = '+IntToStr(VpacodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.RProximoSeqLeituraLocacao(VpaCodFilial : Integer):Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQLEITURA) ULTIMO from LEITURALOCACAOCORPO '+
                            ' Where CODFILIAL = '+IntToStr(VpacodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.RPlanoContasTipoContrato(VpaCodTipoContrato : Integer):String;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from TIPOCONTRATO '+
                            ' Where CODTIPOCONTRATO = '+IntToStr(VpaCodTipoContrato));
  result := Aux.FieldByName('CODPLANOCONTAS').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.RSeqEmailMedidorDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQEMAIL) ULTIMO FROM EMAILMEDIDORCORPO ');
  Result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesContrato.RSeqProcessadoDisponivel(VpaCodFilial : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQPROCESSADO) ULTIMO from CONTRATOPROCESSADOCORPO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodfilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.AtualizaStatus(VpaTexto : String);
begin
  if VprBarraStatus <> nil then
  begin
    VprBarraStatus.Panels[0].text := VpaTexto;
    VprBarraStatus.Refresh;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDContratoItem(VpaDContrato : TRBDContratoCorpo):String;
var
  VpfDItem : TRBDContratoItem;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from CONTRATOITEM '+
                        ' Where CODFILIAL = '+IntToStr(VpaDContrato.CodFilial)+
                        ' and SEQCONTRATO = '+IntToStr(VpaDContrato.SeqContrato));
  AdicionaSqlAbreTabela(Cadastro,'Select * from CONTRATOITEM'+
                          ' Where CODFILIAL = '+IntToStr(VpaDContrato.CodFilial)+
                          ' and SEQCONTRATO = '+IntToStr(VpaDContrato.SeqContrato));

  for VpfLaco := 0 to VpadContrato.ItensContrato.Count - 1 do
  begin
    VpfDItem := TRBDContratoItem(VpaDContrato.ItensContrato.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDContrato.CodFilial;
    Cadastro.FieldByName('SEQCONTRATO').AsInteger := VpaDContrato.SeqContrato;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfLaco + 1;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDItem.SeqProduto;
    Cadastro.FieldByName('CODPRODUTO').AsString := VpfDItem.CodProduto;
    Cadastro.FieldByName('NUMSERIE').AsString := DeletaChars(VpfDItem.NumSerieProduto,#13);
    Cadastro.FieldByName('NUMSERIEINTERNO').AsString := VpfDItem.NumSerieInterno;
    Cadastro.FieldByName('DATULTIMALEITURA').AsDatetime := VpfDItem.DatUltimaLeitura;
    Cadastro.FieldByName('QTDULTIMALEITURA').AsFloat := VpfDItem.QtdUltimaLeitura;
    Cadastro.FieldByName('QTDULTIMALEITURACOLOR').AsFloat := VpfDItem.QtdUltimaLeituraColor;
    Cadastro.FieldByName('DESSETOR').AsString := VpfDItem.DesSetorEmpresa;
    Cadastro.FieldByName('QTDMEDIDORDESATIVACAO').AsInteger := VpfDItem.QtdLeituraDesativacao;
    Cadastro.FieldByName('QTDMEDIDORDESATIVACAOCOLOR').AsInteger := VpfDItem.QtdLeituraDesativacaoColor;
    Cadastro.FieldByName('VALCUSTOPRODUTO').AsFloat := VpfDItem.ValCustoProduto;
    if VpfDItem.DatDesativacao > montadata(1,1,1970) then
      Cadastro.FieldByName('DATDESATIVACAO').AsDateTime := VpfDItem.DatDesativacao
    else
      Cadastro.FieldByName('DATDESATIVACAO').Clear;
    try
      cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DA TABELA CONTRATOITEM!!!'#13+e.message;
        exit;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDLeituraLocacaoItem(VpaDLeitura : TRBDLeituraLocacaoCorpo):String;
var
  VpfDItem : TRBDLeituraLocacaoItem;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from LEITURALOCACAOITEM '+
                        ' Where CODFILIAL = '+IntToStr(VpaDLeitura.CodFilial)+
                        ' and SEQLEITURA = '+IntToStr(VpaDLeitura.SeqLeitura));
  AdicionaSQLAbreTabela(Cadastro,'Select * from LEITURALOCACAOITEM'+
                                 ' Where CODFILIAL = '+ IntToStr(VpaDLeitura.CodFilial)+
                                 ' and SEQLEITURA = '+IntToStr(VpaDLeitura.SeqLeitura));
  for vpfLaco := 0 to VpaDLeitura.ItensLeitura.Count - 1 do
  begin
    VpfDItem := TRBDLeituraLocacaoItem(VpaDLeitura.ItensLeitura.Items[Vpflaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDLeitura.CodFilial;
    Cadastro.FieldByName('SEQLEITURA').AsInteger := VpaDLeitura.SeqLeitura;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfDItem.seqItem;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDItem.SeqProduto;
    Cadastro.FieldByName('CODPRODUTO').AsString := VpfDItem.CodProduto;
    Cadastro.FieldByName('NUMSERIE').AsString := VpfDItem.NumSerieProduto;
    Cadastro.FieldByName('NUMSERIEINTERNO').AsString := VpfDItem.NumSerieInterno;
    Cadastro.FieldByName('DATULTIMALEITURA').AsDateTime := VpfDItem.DatUltimaLeitura;
    Cadastro.FieldByName('QTDULTIMALEITURA').AsInteger := VpfDItem.QtdUltimaLeitura;
    Cadastro.FieldByName('QTDLEITURA').AsInteger := VpfDItem.QtdMedidorAtual;
    Cadastro.FieldByName('QTDULTIMALEITURACOLOR').AsInteger := VpfDItem.QtdUltimaLeituraColor;
    Cadastro.FieldByName('QTDLEITURACOLOR').AsInteger := VpfDItem.QtdMedidorAtualColor;
    Cadastro.FieldByName('DESSETOR').AsString := VpfDItem.DesSetorEmpresa;
    Cadastro.FieldByName('QTDDEFEITO').AsInteger := VpfDItem.QtdDefeitos;
    Cadastro.FieldByName('QTDDEFEITOCOLOR').AsInteger := VpfDItem.QtdDefeitosColor;
    Cadastro.FieldByName('QTDCOPIAS').AsInteger := VpfDItem.QtdTotalCopias;
    Cadastro.FieldByName('QTDCOPIASCOLOR').AsInteger := VpfDItem.QtdTotalCopiasColor;
    if VpfDItem.IndDesativar then
      Cadastro.FieldByName('INDDESATIVAR').AsString := 'S'
    else
      Cadastro.FieldByName('INDDESATIVAR').AsString := 'N';
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DA LEITURA DO CONTRATO ITEM '+IntToStr(VpfLaco)+'!!!'#13+e.message;
        exit;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDReciboLocacao(VpaDRecibo: TRBDReciboLocacao): string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from RECIBOLOCACAOCORPO ' +
                                 ' Where CODFILIAL = ' +IntToStr(VpaDRecibo.CodFilial)+
                                 ' AND SEQRECIBO = ' +IntToStr(VpaDRecibo.SeqRecibo));
  if Cadastro.Eof then
    Cadastro.Insert
  else
    Cadastro.Edit;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDRecibo.CodFilial;
  Cadastro.FieldByName('SEQLEITURALOCACAO').AsInteger := VpaDRecibo.SeqLeituraLocacao;
  Cadastro.FieldByName('LANORCAMENTO').AsInteger := VpaDRecibo.LanOrcamento;
  Cadastro.FieldByName('CODCLIENTE').AsInteger := VpaDRecibo.CodCliente;
  Cadastro.FieldByName('DATEMISSAO').AsDateTime := VpaDRecibo.DatEmissao;
  Cadastro.FieldByName('VALTOTAL').AsFloat := VpaDRecibo.ValTotal;
  Cadastro.FieldByName('DESOBSERVACAO').AsString := VpaDRecibo.DesObservacoes;
  Cadastro.FieldByName('DESOBSERVACAOCOTACAO').AsString := VpaDRecibo.DesObservacaoCotacao;
  Cadastro.FieldByName('DESORDEMCOMPRA').AsString := VpaDRecibo.DesOrdemCompra;
  if VpaDRecibo.IndCancelado then
    Cadastro.FieldByName('INDCANCELADO').AsString := 'S'
  else
    Cadastro.FieldByName('INDCANCELADO').AsString := 'N';


  if VpaDRecibo.SeqRecibo = 0 then
    VpaDRecibo.SeqRecibo := RSeqReciboDisponivel(VpaDRecibo.CodFilial);

  VprSeqRecibo:=VpaDRecibo.SeqRecibo;
  Cadastro.FieldByName('SEQRECIBO').AsInteger := VpaDRecibo.SeqRecibo;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  if result = '' then
    result := GravaDReciboLocacaoServico(VpaDRecibo);
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDReciboLocacaoServico(VpaDRecibo: TRBDReciboLocacao): string;
var
  VpfLaco : Integer;
  VpfDServicoRecibo : TRBDReciboLocacaoServico;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from RECIBOLOCACAOSERVICO ' +
                        ' WHERE CODFILIAL = ' +IntToStr(VpaDRecibo.CodFilial)+
                        ' AND SEQRECIBO = ' +IntToStr(VpaDRecibo.SeqRecibo));
  AdicionaSQLAbreTabela(Cadastro,'Select * FROM RECIBOLOCACAOSERVICO '+
                                 ' WHERE CODFILIAL = 0 AND SEQRECIBO = 0 AND SEQITEM = 0');
  for VpfLaco := 0 to VpaDRecibo.Servicos.Count - 1 do
  begin
    VpfDServicoRecibo := TRBDReciboLocacaoServico(VpaDRecibo.Servicos.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDRecibo.CodFilial;
    Cadastro.FieldByName('SEQRECIBO').AsInteger := VpaDRecibo.SeqRecibo;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfLaco +1;
    Cadastro.FieldByName('CODSERVICO').AsInteger := VpfDServicoRecibo.CodServico;
    Cadastro.FieldByName('QTDSERVICO').AsFloat := VpfDServicoRecibo.QtdServico;
    Cadastro.FieldByName('VALUNITARIO').AsFloat := VpfDServicoRecibo.ValUnitario;
    Cadastro.FieldByName('VALTOTAL').AsFloat := VpfDServicoRecibo.ValTotal;
    Cadastro.Post;
    Result := Cadastro.AMensagemErroGravacao;
    if cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDContratoProcessado(VpaDContratoProcessado : TRBDContratoProcessadoCorpo) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CONTRATOPROCESSADOCORPO ' +
                                 ' WHERE CODFILIAL = 0 AND SEQPROCESSADO = 0');
  Cadastro.Insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDContratoProcessado.CodFilial;
  Cadastro.FieldByName('DATPROCESSADO').AsDatetime := VpaDContratoProcessado.DatProcessado;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDContratoProcessado.CodUsuario;
  VpaDContratoProcessado.SeqProcessado := RSeqProcessadoDisponivel(VpaDContratoProcessado.CodFilial);
  Cadastro.FieldByName('SEQPROCESSADO').AsInteger := VpaDContratoProcessado.SeqProcessado;
  try
    Cadastro.Post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO CONTRATO PROCESSADO CORPO!!!'#13+e.message;
  end;
  Cadastro.close;
  if result = '' then
    result := GravaDContratoProcessadoItem(VpaDContratoProcessado);
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDContratoProcessadoItem(VpaDContatoProcessado : TRBDContratoProcessadoCorpo):String;
var
  VpfLaco : Integer;
  VpfDItem : TRBDContratoProcessadoItem;
  VpfLanOrcamento : Integer;
begin
  result := '';
  AdicionaSqlAbreTabela(Cadastro,'Select * from CONTRATOPROCESSADOITEM ' +
                                 ' Where CODFILIAL = 0 AND SEQPROCESSADO = 0 AND SEQITEM = 0');
  for VpfLaco := VpaDContatoProcessado.Items.Count -1 downto 0 do
  begin
    VpfDItem := TRBDContratoProcessadoItem(VpaDContatoProcessado.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDContatoProcessado.CodFilial;
    Cadastro.FieldByName('SEQPROCESSADO').AsInteger := VpaDContatoProcessado.SeqProcessado;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfLaco + 1;
    if VpfDItem.SeqContrato <> 0 then
      Cadastro.FieldByName('SEQCONTRATO').AsInteger := VpfDItem.SeqContrato;
    if  VpfDItem.LanOrcamento <> 0 then
      VpfLanOrcamento := VpfDItem.LanOrcamento;
    Cadastro.FieldByName('LANORCAMENTO').AsInteger := VpfLanOrcamento;
    if VpfDItem.IndProcessado then
      Cadastro.FieldByName('INDPROCESSADO').AsString := 'T'
    else
      Cadastro.FieldByName('INDPROCESSADO').AsString := 'F';
    Cadastro.FieldByName('DESERRO').AsString := VpfDItem.DesErro;
    try
      Cadastro.Post;
    except
      on e : exception do result := 'ERRO NA GRAVACAO DO CONTRATRO PROCESSADO ITEM!!!'#13+e.message;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDContratoServico(VpaDContrato: TRBDContratoCorpo): String;
var
  VpfDItem : TRBDContratoServico;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from CONTRATOSERVICO '+
                        ' Where CODFILIAL = '+IntToStr(VpaDContrato.CodFilial)+
                        ' and SEQCONTRATO = '+IntToStr(VpaDContrato.SeqContrato));
  AdicionaSqlAbreTabela(Cadastro,'Select * from CONTRATOSERVICO'+
                          ' Where CODFILIAL = '+IntToStr(VpaDContrato.CodFilial)+
                          ' and SEQCONTRATO = '+IntToStr(VpaDContrato.SeqContrato));

  for VpfLaco := 0 to VpadContrato.ServicoContrato.Count - 1 do
  begin
    VpfDItem := TRBDContratoServico(VpaDContrato.ServicoContrato.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDContrato.CodFilial;
    Cadastro.FieldByName('SEQCONTRATO').AsInteger := VpaDContrato.SeqContrato;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfLaco+1;
    Cadastro.FieldByName('CODSERVICO').AsInteger := VpfDItem.CodServico;
    Cadastro.FieldByName('NOMSERVICO').AsString := VpfDItem.NomServico;
    Cadastro.FieldByName('DESADICIONAIS').AsString := VpfDItem.DesAdicional;
    Cadastro.FieldByName('QTDSERVICO').AsFloat := VpfDItem.QtdServico;
    Cadastro.FieldByName('VALSERVICO').AsFloat := VpfDItem.ValUnitario;
    Cadastro.FieldByName('VALTOTSERVICO').AsFloat := VpfDItem.ValTotal;
    Cadastro.FieldByName('DATULTIMAALTERACAO').AsDateTime := Sistema.RDataServidor;
    cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDEmailMedidor(VpaDMedidores: TRBDEmailMedidorCorpo): string;
begin
  result := '';
  AdicionaSqlAbreTabela(Cadastro,'Select * from EMAILMEDIDORCORPO '+
                                 ' Where SEQEMAIL = 0 ');
  Cadastro.Insert;
  Cadastro.FieldByName('SEQEMAIL').AsInteger  := VpaDMedidores.SeqEmail;
  Cadastro.FieldByName('DATENVIO').AsDateTime := VpaDMedidores.DataEnvio;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDMedidores.CodUsuario;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  if Result = '' then
    result := GravaDEmailMedidorItem(VpaDMedidores);
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDEmailMedidorItem(VpaDMedidores: TRBDEmailMedidorCorpo): String;
var
  VpfDItem : TRBDEmailMedidorItem;
  VpfLaco : Integer;
begin
  result := '';
  if VpaDMedidores.Emails.Count > 0 then
  begin
    VpfDItem := TRBDEmailMedidorItem(VpaDMedidores.Emails.Items[0]);
    ExecutaComandoSql(Aux,'Delete from EMAILMEDIDORITEM '+
                          ' Where SEQEMAIL = '+IntToStr(VpaDMedidores.SeqEmail));
    AdicionaSqlAbreTabela(Cadastro,'Select * from EMAILMEDIDORITEM'+
                            ' Where SEQEMAIL = 0');

    for VpfLaco := 0 to VpaDMedidores.Emails.Count - 1 do
    begin
      VpfDItem := TRBDEmailMedidorItem(VpaDMedidores.Emails.Items[VpfLaco]);
      Cadastro.insert;
      Cadastro.FieldByName('CODFILIAL').AsInteger := VpfDItem.CodFilial;
      Cadastro.FieldByName('SEQEMAIL').AsInteger := VpaDMedidores.SeqEmail;
      Cadastro.FieldByName('SEQCONTRATO').AsInteger := VpfDItem.SeqContrato;
      Cadastro.FieldByName('INDENVIADO').AsString := VpfDItem.Enviado;
      Cadastro.FieldByName('DESSTATUS').AsString := VpfDItem.Status;
      cadastro.post;
      result := cadastro.AMensagemErroGravacao;
      if Result <> '' then
        break;
    end;
    Cadastro.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.GeraCotacaoCorpoContrato(VpaDContrato : TRBDContratoCorpo;VpaDCliente : TRBDCliente):TRBDOrcamento;
var
  VpfFunVendedor : TRBFuncoesVendedor;
begin
  VpfFunVendedor := TRBFuncoesVendedor.cria(Tabela.SQLConnection);
  result := TRBDOrcamento.cria;

  result.CodEmpFil := VpaDContrato.CodFilial;
  result.CodTipoOrcamento := varia.TipoCotacao;
  result.CodCliente := VpaDContrato.CodCliente;
  result.CodVendedor := VpaDContrato.CodVendedor;
  result.CodCondicaoPagamento := VpaDContrato.CodCondicaoPagamento;
  result.PerComissao := VpaDContrato.PerComissao;
  if Result.PerComissao = 0 then
    Result.PerComissao := VpfFunVendedor.RPerComissao(Result.codVendedor);
  if VpaDContrato.CodFormaPagamento <> 0 then
    Result.CodFormaPaqamento := VpaDContrato.CodFormaPagamento
  else
    if VpaDCliente.CodFormaPagamento <> 0 then
      result.CodFormaPaqamento := VpaDCliente.CodFormaPagamento
    else
      result.CodFormaPaqamento := Varia.FormaPagamentoPadrao;
  result.NumContaCorrente := VpaDContrato.NumContaBancaria;
  result.CodEstagio := Varia.EstagioFinalOrdemProducao;
  result.CodUsuario := varia.CodigoUsuario;
  result.FlaSituacao := 'E';
  result.CodPlanoContas := RPlanoContasTipoContrato(VpaDContrato.CodTipoContrato);
  result.NomComputador := Varia.NomeComputador;
  result.NomContato := VpaDCliente.NomContato;
  result.DatOrcamento := date;
  result.HorOrcamento := now;
  result.DatPrevista := date;
  result.DatEntrega := date;
  result.FinanceiroGerado := true;
  result.IndNotaGerada := false;
  result.IndPendente := false;
  result.IndClienteRevenda := false;
  result.IndProcessada := true;
  Result.ValDesconto := VpaDContrato.ValDesconto;
  VpfFunVendedor.free;
end;

{******************************************************************************}
function TRBFuncoesContrato.GeraCotacaodoFaturamentoPosterior(VpaDCotacao : TRBDOrcamento;VpaDCliente :TRBDCliente):TRBDOrcamento;
var
  VpfDTipoCotacao :TRBDTipoCotacao ;
begin
  if varia.CondicaoPagamentoContrato = 0 then
    aviso('CONDIÇÃO DE PAGAMENTO DOS CONTRATOS NÃO CADASTRADO!!!'#13'É necessário cadastrar nas configurações do sistema a condição de pagamento dos contratos.');
  if varia.FormaPagamentoContrato = 0 then
    aviso('FORMA DE PAGAMENTO DOS CONTRATOS NÃO CADASTRADO!!!'#13'É necessário cadastrar nas configurações do sistema a forma de pagamento dos contratos.');

  VpfDTipoCotacao := TRBDTipoCotacao.cria;
  FunCotacao.CarDtipoCotacao(VpfDTipoCotacao,Varia.TipoCotacao);
  result := TRBDOrcamento.cria;
  result.CodEmpFil := VpaDCotacao.CodEmpFil;
  result.CodTipoOrcamento := varia.TipoCotacaoPedido;
  result.CodCliente := VpaDCotacao.CodCliente;
  result.CodVendedor := VpaDCotacao.CodVendedor;
  Result.CodPreposto := VpaDCotacao.CodPreposto;
  result.PerComissao := VpaDCotacao.PerComissao;
  Result.PerComissaoPreposto := VpaDCotacao.PerComissaoPreposto;
  result.CodTabelaPreco := VpaDCotacao.CodTabelaPreco;

  result.CodCondicaoPagamento := varia.CondicaoPagamentoContrato;
  Result.CodFormaPaqamento := varia.FormaPagamentoContrato;
  result.NumContaCorrente := Varia.ContaBancariaContrato;
  result.CodEstagio := Varia.EstagioFinalOrdemProducao;
  result.CodUsuario := varia.CodigoUsuario;
  result.FlaSituacao := 'E';
  result.CodPlanoContas := VpfDTipoCotacao.CodPlanoContas;
  result.NomComputador := Varia.NomeComputador;
  result.NomContato := VpaDCotacao.NomContato;
  result.DatOrcamento := date;
  result.HorOrcamento := now;
  result.DatPrevista := date;
  result.DatEntrega := date;
  result.FinanceiroGerado := false;
  result.IndNotaGerada := false;
  result.IndPendente := false;
  result.IndClienteRevenda := false;
  result.IndProcessada := true;
  Result.valdesconto := 0;
  result.perdesconto := 0;
  Result.DesObservacaoFiscal := 'Referente as cotações ';

  if config.NoFaturamentoMensalCondPagamentoCliente then
  begin
    if VpaDCliente.CodCondicaoPagamento <> 0 then
      Result.CodCondicaoPagamento := VpaDCliente.CodCondicaoPagamento;
    if VpaDCliente.CodFormaPagamento <> 0 then
      Result.CodFormaPaqamento := VpaDCliente.CodFormaPagamento;
    if VpaDCliente.ContaBancariaDeposito <> '' then
      Result.NumContaCorrente := VpaDCliente.ContaBancariaDeposito;
  end;
  VpfDTipoCotacao.free;
end;

{******************************************************************************}
function TRBFuncoesContrato.GeraNotaExcedenteReciboLocacao(VpaDCotacao: TRBDOrcamento; VpaDCliente: TRBDCliente;VpaDLeituraLocacao: TRBDLeituraLocacaoCorpo): string;
var
  VpfCotacoes : TList;
  VpfDServico : TRBDOrcServico;
  VpfValServicos : Double;
begin
  if config.ExcedenteFranquiaLocacaoFaturaremNotaFiscal and
    (VpaDLeituraLocacao.ValContrato < VpaDCotacao.ValTotal) then
  begin
    VpfCotacoes := TList.create;
    VpfCotacoes.Add(VpaDCotacao);
    //arruma o valor unitario do serviço;
    VpfDServico := TRBDOrcServico(VpaDCotacao.Servicos.Items[0]);
    VpfValServicos := VpfDServico.ValUnitario;
    VpfDServico.ValUnitario := VpaDCotacao.ValTotal - VpaDLeituraLocacao.ValContrato;
    VpfDServico.ValTotal :=  VpfDServico.ValUnitario;

    AtualizaStatus('Gerando a nota fiscal');
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(application,'', true);
    result := FNovaNotaFiscalNota.GeraNotaCotacoesAutomatico(VpfCotacoes,VpaDCliente,VprBarraStatus);
    FNovaNotaFiscalNota.free;
    VpfDServico.ValUnitario := VpfValServicos;
    VpfDServico.ValTotal :=  VpfDServico.ValUnitario;
    VpfCotacoes.Free;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.GeraReciboLocacao(VpaDCotacao: TRBDOrcamento;VpaDCliente : TRBDCliente; VpaDLeituraLocacao: TRBDLeituraLocacaoCorpo): string;
var
  VpfDReciboLocacao : TRBDReciboLocacao;
  VpfDSericoRecibo : TRBDReciboLocacaoServico;
begin
  result := '';
  VpfDReciboLocacao := TRBDReciboLocacao.cria;
  VpfDReciboLocacao.CodFilial := VpaDCotacao.CodEmpFil;
  if VpaDLeituraLocacao <> nil then
    VpfDReciboLocacao.SeqLeituraLocacao := VpaDLeituraLocacao.SeqLeitura;
  VpfDReciboLocacao.LanOrcamento := VpaDCotacao.LanOrcamento;
  VpfDReciboLocacao.CodCliente := VpaDCotacao.CodCliente;
  VpfDReciboLocacao.DesObservacoes := VpaDCotacao.DesObservacaoFiscal;
  VpfDReciboLocacao.DesObservacaoCotacao:= VpaDCotacao.DesObservacao.Text;
  VpfDReciboLocacao.DesOrdemCompra := VpaDCotacao.OrdemCompra;
  VpfDReciboLocacao.DatEmissao := now;
  if (config.ExcedenteFranquiaLocacaoFaturaremNotaFiscal) and (VpaDLeituraLocacao <> nil) then
    VpfDReciboLocacao.ValTotal := VpaDLeituraLocacao.ValContrato
  else
    VpfDReciboLocacao.ValTotal := VpaDCotacao.ValTotal;

  CarServicosCotacaoparaRecibo(VpaDCotacao,VpfDReciboLocacao,VpaDLeituraLocacao);

  result := GravaDReciboLocacao(VpfDReciboLocacao);

  if result = '' then
  begin
    result := ArrumaFinanceiroReciboLocacao(VpfDReciboLocacao);
    if Result = '' then
    begin
      //gera nota fiscal excedente franquia.
      if config.ExcedenteFranquiaLocacaoFaturaremNotaFiscal and
        (VpaDLeituraLocacao <>  nil) then
      begin
        if (VpaDLeituraLocacao.ValContrato < VpaDCotacao.ValTotal) then
          Result := GeraNotaExcedenteReciboLocacao(VpaDCotacao,VpaDCliente,VpaDLeituraLocacao);
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.GeraCotacaoCorpoLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo;VpaDContrato : TRBDContratoCorpo;VpaDCliente : TRBDCliente):TRBDorcamento;
Var
  VpfDItemCotacao : TRBDOrcServico;
begin
  result := GeraCotacaoCorpoContrato(VpaDContrato,VpaDCliente);
  if Varia.TipoCotacaoFaturaLocacao <> 0 then
    result.CodTipoOrcamento := varia.TipoCotacaoFaturaLocacao;
  if VpaDContrato.CodVendedor <> 0 then
    result.CodVendedor := VpaDContrato.CodVendedor;
  if VpaDLeitura.ValDesconto <> 0 then
    result.ValDesconto := VpaDLeitura.ValDesconto;
  result.DesObservacaoFiscal := 'Qtd copias = '+IntToStr(VpaDLeitura.QtdCopias);
  if VpaDLeitura.QtdDefeitos <> 0 then
    result.DesObservacaoFiscal := result.DesObservacaoFiscal+#13+' Qtd copias com defeito = '+IntToStr(VpaDLeitura.QtdDefeitos);
  if VpaDLeitura.QtdExcedente <> 0 then
    result.DesObservacaoFiscal := result.DesObservacaoFiscal+#13+' Qtd copias excedente franquia = '+IntToStr(VpaDLeitura.QtdExcedente);
  result.DesObservacaoFiscal := result.DesObservacaoFiscal+#13+VpaDLeitura.DesObservacao;
  VpfDItemCotacao := GeraServicoContrato(VpaDContrato,result);
  VpfDItemCotacao.ValUnitario := VpaDLeitura.ValTotal;
  VpfDItemCotacao.ValTotal := VpaDLeitura.ValTotal;
  result.IndProcessamentoFrio := VpaDLeitura.IndProcessamentoFrio;
  result.OrdemCompra := VpaDLeitura.DesOrdemCompra;
end;

{******************************************************************************}
function TRBFuncoesContrato.GeraServicoContrato(VpaDContrato : TRBDContratoCorpo;VpaDCotacao : TRBDOrcamento):TRBDOrcServico;
begin
  result := VpaDCotacao.AddServico;
  result.CodServico := VpaDContrato.CodServico;
  result.NomServico := VpaDContrato.NomServico;
  FunCotacao.ExisteServico(InttoStr(VpaDContrato.CodServico),result);
  if VpaDContrato.NumContrato <> '' then
    result.DesAdicional := 'cfrme. contr. '+VpaDContrato.NumContrato;
  case VpaDContrato.NumTextoServico of
    1 : result.DesAdicional := result.DesAdicional +' ref mes '+ TextoMes(decmes(date,1),false)+'/'+inttoStr(ano(decmes(date,1)));
    2 : result.DesAdicional := result.DesAdicional +' ref mes '+ TextoMes(date,false)+'/'+inttoStr(ano(date));
  end;
  result.QtdServico := 1;
  result.ValUnitario := VpaDContrato.ValContrato;
  result.ValTotal := VpaDContrato.ValContrato;
end;

{******************************************************************************}
function TRBFuncoesContrato.ClientePossuiContratoaReajustar(VpaCodCliente : Integer) :Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'select * from CONTRATOCORPO '+
                            ' Where CODCLIENTE = '+IntToStr(VpaCodCliente)+
                            ' and DATCANCELAMENTO IS NULL '+
                            ' and INDAUTOMATICO = ''S'''+
                            ' and '+SQLTextoMes('DATASSINATURA')+' = '+IntToStr(mes(date)));
  result := not Aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesContrato.ValidaNumeroSeriesProdutosContrato(VpaDContrato: TRBDContratoCorpo): string;
var
  VpfLaco : Integer;
  VpfDContratoItem : TRBDContratoItem;
begin
  result := '';
  for VpfLaco := 0 to VpaDContrato.ItensContrato.Count - 1 do
  begin
    VpfDContratoItem := TRBDContratoItem(VpaDContrato.ItensContrato.Items[Vpflaco]);
    if DeletaChars(VpfDContratoItem.NumSerieProduto,' ') = '' then
    begin
      result := 'EQUIPAMENTO SEM NUMERO DE SÉRIE!!!'#13'Não foi digitado o numero de série para o equipamento "'+VpfDContratoItem.NomProduto+'", antes de fazer qualquer operação é necessário informar o numero de serie no cadastro do contrato.';
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.VerificaQtdMinimaFaturamento(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfQtdCracha,VpfQtdProdutos,VpfQtdCredito : Double;
  VpfDItem : TRBDOrcProduto;
begin
  VpfQtdCracha :=0;
  VpfQtdProdutos := 0;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItem := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDItem.IndCracha then
       VpfQtdCracha := VpfQtdCracha + VpfDItem.QtdProduto;
    VpfQtdProdutos := VpfQtdProdutos + VpfDItem.QtdProduto;
  end;
  if (VpfQtdCracha < 5) and not((VpfQtdCracha = 0) and (VpfQtdProdutos > 5))  then
  begin
    for VpfLaco := VpaDCotacao.Produtos.count -1 downto 0 do
    begin
      VpfDItem := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      if VpfDItem.IndCracha then
        break;
    end;

    if VpfQtdCracha = 0 then
      VpfQtdCredito := (5 - VpfQtdProdutos)
    else
      VpfQtdCredito := (5 - VpfQtdCracha);
    VpfDItem.QtdProduto := VpfDItem.QtdProduto +VpfQtdCredito;
    VpfDItem.ValTotal :=  VpfDItem.QtdProduto * VpfDItem.ValUnitario;
    VpaDCotacao.DesObservacaoFiscal := VpaDCotacao.DesObservacaoFiscal + #13'Faturamento Mínimo de 5 produto. Existe um crédito de '+FormatFloat(varia.MascaraQtd,VpfQtdCredito) +' '+VpfDItem.UM+#13+'do produto "'+VpfDItem.NomProduto+'" para a sua próxima compra';
    FunClientes.BaixaEstoqueBrinde(VpaDCotacao.CodCliente,VpfDItem.SeqProduto,VpfQtdCredito,VpfDItem.UM,false);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.AdicionaVendasCotacaoFaturamentoPost(VpadCotacao : TRBDOrcamento;VpaDCotacaodoMes : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDItem, VpfDItemMes : TRBDOrcProduto;
  VpfDItemServico, VpfDItemServicoMes : TRBDOrcServico;
begin
  VpadCotacao.DesObservacaoFiscal := VpadCotacao.DesObservacaoFiscal + IntToStr(VpaDCotacaodoMes.LanOrcamento)+',';
  VpadCotacao.ValTaxaEntrega := VpadCotacao.ValTaxaEntrega + VpaDCotacaodoMes.ValTaxaEntrega;
  for VpfLaco := 0 to VpaDCotacaodoMes.Produtos.Count - 1 do
  begin
    VpfDItemMes := TRBDOrcProduto(VpaDCotacaodoMes.Produtos.Items[VpfLaco]);
    if not VpfDItemMes.IndBrinde then
    begin
      VpfDItem := FunCotacao.RProdutoCotacao(VpaDCotacao,VpfDItemMes.SeqProduto,VpfDItemMes.CodCor, VpfDItemMes.CodTamanho, VpfDItemMes.ValUnitario);
      if (VpfDItem = nil) or (VpfDItem.ValUnitario <> VpfDItemMes.ValUnitario) then
      begin
        VpfDItem := VpadCotacao.AddProduto;
        VpfDItem.SeqMovimento := VpadCotacao.Produtos.Count + 1;
        VpfDItem.SeqProduto := VpfDItemMes.SeqProduto;
        VpfDItem.CodCor := VpfDItemMes.CodCor;
        VpfDItem.CodEmbalagem := VpfDItemMes.CodEmbalagem;
        VpfDItem.CodProduto := VpfDItemMes.CodProduto;
        VpfDItem.NomProduto := VpfDItemMes.NomProduto;
        VpfDItem.DesObservacao := VpfDItemMes.DesObservacao;
        VpfDItem.DesRefCliente := VpfDItemMes.DesRefCliente;
        VpfDItem.UM := VpfDItemMes.UM;
        VpfDItem.UMOriginal := VpfDItemMes.UMOriginal;
        VpfDItem.IndRetornavel := false;
        VpfDItem.IndCracha := VpfDItemMes.IndCracha;
        VpfDItem.PerDesconto := VpfDItemMes.PerDesconto;
        VpfDItem.PesLiquido := VpfDItemMes.PesLiquido;
        VpfDItem.PesBruto := VpfDItemMes.PesBruto;
        VpfDItem.QtdProduto := VpfDItemMes.QtdProduto;
        VpfDItem.ValUnitario := VpfDItemMes.ValUnitario;
        VpfDItem.ValTotal := VpfDItemMes.ValTotal;
        VpfDItem.PerComissao := VpfDItemMes.PerComissao;
        VpfDItem.PerComissaoClassificacao := VpfDItem.PerComissaoClassificacao;
        VpfDItem.QtdDevolvido := VpfDItem.QtdProduto;
      end
      else
      begin
        VpfDItem.QtdProduto := VpfDItem.QtdProduto +FunProdutos.CalculaQdadePadrao(VpfDItemMes.UM,VpfDItem.UM,VpfDItemMes.QtdProduto,IntToStr(VpfDItem.SeqProduto));
        VpfDItem.ValTotal := VpfDItem.QtdProduto * VpfDItem.ValUnitario;
        VpfDItem.QtdDevolvido := VpfDItem.QtdProduto;
      end;
    end;
  end;

  for VpfLaco := 0 to VpaDCotacaodoMes.Servicos.Count - 1 do
  begin
    VpfDItemServicoMes := TRBDOrcServico(VpaDCotacaodoMes.Servicos.Items[VpfLaco]);
    VpfDItemServico := FunCotacao.RServicoCotacao(VpadCotacao,VpfDItemServicoMes.CodServico);
    if (VpfDItemServico = nil) or (VpfDItemServico.ValUnitario <> VpfDItemServicoMes.ValUnitario) then
    begin
      VpfDItemServico := VpadCotacao.AddServico;
      VpfDItemServico.CodServico := VpfDItemServicoMes.CodServico;
      VpfDItemServico.NomServico := VpfDItemServicoMes.NomServico;
      VpfDItemServico.DesAdicional := VpfDItemServicoMes.DesAdicional;
      VpfDItemServico.QtdServico := VpfDItemServicoMes.QtdServico;
      VpfDItemServico.ValUnitario := VpfDItemServicoMes.ValUnitario;
      VpfDItemServico.ValTotal := VpfDItemServicoMes.ValTotal;
      VpfDItemServico.PerISSQN := VpfDItemServicoMes.PerISSQN;
      VpfDItemServico.PerComissaoClassificacao := VpfDItemServicoMes.PerComissaoClassificacao;
    end
    else
    begin
      VpfDItemServico.QtdServico := VpfDItemServico.QtdServico + VpfDItemServicoMes.QtdServico;
      VpfDItemServico.ValTotal := VpfDItemServico.QtdServico * VpfDItemServico.ValUnitario;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.AnexaArquivoEmail(VpaNomArquivo: String;VpaMensagem: TIdMessage): string;
var
  VpfAnexo : TIdAttachmentfile;
begin
  VpfAnexo := TIdAttachmentfile.Create(VpaMensagem.MessageParts,VpaNomArquivo);
  VpfAnexo.ContentType := 'application/pdf';
  VpfAnexo.ContentDisposition := 'inline';
  VpfAnexo.DisplayName:=RetornaNomArquivoSemDiretorio(VpaNomArquivo);
  VpfAnexo.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpaNomArquivo);;
  VpfAnexo.DisplayName := RetornaNomArquivoSemDiretorio(VpaNomArquivo);;
end;

{******************************************************************************}
function TRBFuncoesContrato.ArrumaFinanceiroReciboLocacao(VpaDRecibo: TRBDReciboLocacao): string;
Var
  VpfIndice : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCONTASARECEBER ' +
                                 ' Where I_EMP_FIL = '+IntToStr(VpaDRecibo.CodFilial)+
                                 ' AND I_LAN_ORC = ' +IntToStr(VpaDRecibo.LanOrcamento));
  if not Cadastro.Eof then
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER ' +
                                   ' Where I_EMP_FIL = '+ IntToStr(VpaDRecibo.CodFilial)+
                                   ' AND I_LAN_REC = ' + Cadastro.FieldByName('I_LAN_REC').AsString +
                                   ' ORDER BY I_NRO_PAR ');
    VpfIndice := 0;
    while not Cadastro.eof do
    begin
      inc(VpfIndice);
      cadastro.Edit;
      Cadastro.FieldByName('C_NRO_DUP').AsString := 'RL'+IntToStr(VpaDRecibo.SeqRecibo)+'/'+IntToStr(VpfIndice);
      Cadastro.FieldByName('C_IND_CAD').AsString := 'N';
      Cadastro.Post;
      result := Cadastro.AMensagemErroGravacao;
      if Cadastro.AErronaGravacao then
      break;
      Cadastro.Next;
    end;
    Cadastro.Close;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.AdicionaDescontoCotacaoFaturamentoPost(VpadCotacao : TRBDOrcamento;VpaDCotacaodoMes : TRBDOrcamento);
begin
  if VpaDCotacaodoMes.ValDesconto <> 0 then
    VpaDCotacao.ValDesconto := VpaDCotacao.ValDesconto + VpadCotacaodoMes.ValDesconto;
  if VpadCotacaodoMes.PerDesconto <> 0 then
    VpaDCotacao.ValDesconto := VpadCotacao.ValDesconto +((VpaDCotacaodoMes.ValTotalProdutos * VpaDCotacaodoMes.PerDesconto)/100);
end;

{******************************************************************************}
function TRBFuncoesContrato.MarcaContratoComoProcessado(VpaDLeitura: TRBDLeituraLocacaoCorpo;VpaBarraStatus: TStatusBar): string;
var
    VpfDContrato : TRBDContratoCorpo;
begin
  VpaDLeitura.DatProcessamento := now;
  AtualizaStatus('Gravando os dados da leitura da locação');
  result := GravaDLeituraLocacao(VpaDLeitura);
  if result = '' then
  begin
    VpfDContrato := TRBDContratoCorpo.cria;
    CarDContrato(VpfDContrato,VpaDLeitura.CodFilial,VpaDLeitura.SeqContrato);
    VpfDContrato.DatUltimaExecucao := VpaDLeitura.DatProcessamento;
    AtualizaStatus('Gravando os dados do contrato');
    result := gravadcontrato(VpfDContrato);
    if result = '' then
    begin
      AtualizaStatus('Atualizando os medidos');
      result := AtualizaMedidoresContrato(VpaDLeitura);
    end;
    VpfDContrato.Free;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.MesFaturamentoContrato(VpaDContrato : TRBDContratoCorpo):Boolean;
var
  VpfData : TDateTime;
begin
  result := false;
  case VpaDContrato.TipPeriodicidade of
    0 : VpfData := incMes(VpaDContrato.DatUltimaExecucao,1);//mensal
    1 : VpfData := incMes(VpaDContrato.DatUltimaExecucao,2); //bimestral
    2 : VpfData := incMes(VpaDContrato.DatUltimaExecucao,3); // trimestral;
    3 : VpfData := incMes(VpaDContrato.DatUltimaExecucao,6); //semestral
    4 : VpfData := incMes(VpaDContrato.DatUltimaExecucao,12); //anual;
  end;

  result :=  ((mes(VpfData) <= mes(date)) and (ano(vpfData)<= ano(date)) or (ano(vpfdata) < ano(date)));
end;

{******************************************************************************}
procedure TRBFuncoesContrato.MontaEmailLeituraLocacao(VpaTexto: TStrings;VpaDContrato: TRBDContratoCorpo; VpaDCliente: TRBDCliente);
var
  VpfLaco : Integer;
  VpfDContratoItem : TRBDContratoItem;
begin
  VpaTexto.Clear;
  VpaTexto.Add('<html>');
  VpaTexto.Add('<head>');
  VpaTexto.add('<title> Eficacia Sistemas e Consultoria Ltda');
  VpaTexto.Add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.Add('<center>');
  VpaTexto.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
  VpaTexto.Add('<tr>');
  VpaTexto.add('<td>');
  VpaTexto.Add('<table width=100%  border=0>');
  VpaTexto.add(' <tr>');
  VpaTexto.Add('  <td width=40%>');
  VpaTexto.add('    <a > <img src="cid:'+IntToStr(VpaDContrato.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  <td width=20% align="center" > <font face="Verdana" size="5"><b>Medidores Contrato ');
  VpaTexto.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="Sistema de Gestão Desenvolvido por Eficacia Sistemas e Consultoria" href="http://www.eficaciaconsultoria.com.br"> <img src="cid:efi.jpg" border="0"');
  VpaTexto.add('  </td>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<br>');
  // preencha os campos em Amarelo
  VpaTexto.Add('<table width=100%  border=1 cellpadding="3" cellspacing="0">');
  VpaTexto.Add(' <tr>');
  VpaTexto.add('	<td width="20%" bgcolor="#EEEEEE"><font face="Verdana" size="1">');
  VpaTexto.add('&nbsp;&nbsp;&nbsp;Caro cliente, voce esta recebendo este e-mail por ter um <b>contrato de locacao</b> com a <b>');
  VpaTexto.add(Varia.NomeFilial + '</b>.<br>&nbsp;&nbsp;&nbsp;Por gentileza poderia responder este e-mail com os contadores atuais dos equipamentos.');
  VpaTexto.add('<br>&nbsp;&nbsp;&nbsp;Para isto basta clicar em <b>responder e digitar os contadores nos espaços em amarelo</b>');
  VpaTexto.add('<br>&nbsp;&nbsp;&nbsp;Qualquer duvida entrar em contato com o fone '+Varia.FoneFilial);
  VpaTexto.add('	</td>');
  VpaTexto.add(' </tr></table>');

  VpaTexto.add('<table width=100%  border=1 cellpadding="0" cellspacing="0" >');
  VpaTexto.Add(' <tr>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  VpaTexto.add('	<td colspan="3" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(vpadcliente.CodCliente)+' '+vpadcliente.NomCliente+'</td>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Tipo Contrato</td>');
  VpaTexto.add('	<td width="30%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomTipoContrato(VpaDContrato.CodTipoContrato) +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Responsavel Leitura</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunChamado.RNomeTecnico(VpaDContrato.CodTecnicoLeitura) +'</td>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Nº Contrato</td>');
  VpaTexto.add('	<td width="30%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDContrato.SeqContrato) +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Filial Contrato</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDContrato.CodFilial) +'</td>');
  VpaTexto.add(' </tr>');
  VpaTexto.add('</table>');

  VpaTexto.add('<table width=100%  border=1 cellpadding="0" cellspacing="0" >');
  VpaTexto.add(' <tr>');
  VpaTexto.add('	<td width="5%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Item</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Modelo</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Num Serie</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Serie Interno</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Setor</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Ult Leitura</td>');
  VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Med PB</td>');
  VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Med PB Atual</td>');
  VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Med Color</td>');
  VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Med Color Atual</td>');
  VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Defeitos</td>');
  for VpfLaco := 0 to VpaDContrato.ItensContrato.Count - 1 do
  begin
    VpfDContratoItem := TRBDContratoItem(VpaDContrato.ItensContrato.Items[VpfLaco]);
    if VpfDContratoItem.DatDesativacao > MontaData(1,1,1900) then
      continue;
    VpaTexto.add(' </tr><tr>');
    VpaTexto.add('	<td width="5%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+IntToStr(VpfDContratoItem.SeqItem)+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+VpfDContratoItem.NomProduto+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+VpfDContratoItem.NumSerieProduto+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+VpfDContratoItem.NumSerieInterno+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+VpfDContratoItem.DesSetorEmpresa+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+FormatDateTime('DD/MM/YY',VpfDContratoItem.DatUltimaLeitura)+'</td>');
    VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+IntToStr(VpfDContratoItem.QtdUltimaLeitura)+'</td>');
    VpaTexto.add('	<td width="8%" bgcolor="#FFFF00"><font face="Verdana" size="1">&nbsp;</td>');
    VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;'+IntToStr(VpfDContratoItem.QtdUltimaLeituraColor)+'</td>');
    VpaTexto.add('	<td width="8%" bgcolor="#FFFF00"><font face="Verdana" size="1">&nbsp;</td>');
    VpaTexto.add('	<td width="8%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">&nbsp;</td>');
  end;
  VpaTexto.add(' </tr>');
  VpaTexto.add('</table>');

  VpaTexto.add('<hr>');
  VpaTexto.Add('<center>');
  if sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestao desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.Add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.Add('');
  VpaTexto.add('</html>');
end;

{******************************************************************************}
procedure TRBFuncoesContrato.MontaEmailRecibo(VpaTexto: TStrings;
  VpaDContrato: TRBDContratoCorpo; VpaDCliente: TRBDCliente);
var
  VpfLaco : Integer;
  VpfDContratoItem : TRBDContratoItem;
begin
  VpaTexto.Clear;
  VpaTexto.Add('<html>');
  VpaTexto.Add('<head>');
  VpaTexto.add('<title> Eficacia Sistemas e Consultoria Ltda');
  VpaTexto.Add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.Add('<center>');
  VpaTexto.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
  VpaTexto.Add('<tr>');
  VpaTexto.add('<td>');
  VpaTexto.Add('<table width=100%  border=0>');
  VpaTexto.add(' <tr>');
  VpaTexto.Add('  <td width=40%>');
  VpaTexto.add('    <a > <img src="cid:'+IntToStr(VpaDContrato.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  <td width=20% align="center" > <font face="Verdana" size="5"><b>Medidores Contrato ');
  VpaTexto.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="Sistema de Gestão Desenvolvido por Eficacia Sistemas e Consultoria" href="http://www.eficaciaconsultoria.com.br"> <img src="cid:efi.jpg" border="0"');
  VpaTexto.add('  </td>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<br>');
  VpaTexto.Add('<table width=100%  border=1 cellpadding="3" cellspacing="0">');
  VpaTexto.Add(' <tr>');
  VpaTexto.add('	<td width="20%" bgcolor="#EEEEEE"><font face="Verdana" size="1">');
  VpaTexto.add('&nbsp;&nbsp;&nbsp;Esta mensagem e referente a os recibos de locacao. <b>');
  VpaTexto.add(Varia.NomeFilial + '</b>.<br>&nbsp;&nbsp;&nbsp;Por gentileza poderia responder este e-mail com os contadores atuais dos equipamentos.');
  VpaTexto.add('<br>&nbsp;&nbsp;&nbsp;Qualquer duvida entrar em contato com o fone '+Varia.FoneFilial);
  VpaTexto.add('	</td>');
  VpaTexto.add(' </tr></table>');

  VpaTexto.add(' </tr>');
  VpaTexto.add('</table>');

  VpaTexto.add('<hr>');
  VpaTexto.Add('<center>');
  if sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestao desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.Add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.Add('');
  VpaTexto.add('</html>');
end;

{******************************************************************************}
function TRBFuncoesContrato.NumeroSerieDuplicado(VpaDContrato: TRBDContratoCorpo): string;
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDItemExterno, VpfDItemInterno : TRBDContratoItem;
begin
  result := '';

  for VpfLacoExterno := 0 to VpaDContrato.ItensContrato.Count - 1 do
  begin
    VpfDItemExterno := TRBDContratoItem(VpaDContrato.ItensContrato.Items[VpfLacoExterno]);
    VpfDItemExterno.IndNumeroSerieDuplicado := false;
  end;

  for VpfLacoExterno := 0 to VpaDContrato.ItensContrato.Count - 2 do
  begin
    VpfDItemExterno := TRBDContratoItem(VpaDContrato.ItensContrato.Items[VpfLacoExterno]);
    if VpfDItemExterno.NumSerieProduto = '' then
      result := 'NUMERO DE SÉRIE NÃO PREENCHIDO!!!'#13'O número de serie do produto "'+VpfDItemExterno.NomProduto+'" não foi preenchido...';
    for VpfLacoInterno  := VpflacoExterno+1 to VpaDContrato.ItensContrato.Count - 1 do
    begin
      VpfDItemInterno := TRBDContratoItem(VpaDContrato.ItensContrato.Items[VpfLacoInterno]);
      if (VpfDItemExterno.NumSerieProduto = VpfDItemInterno.NumSerieProduto) then
      begin
        result := 'NUMERO DE SÉRIE DULICADO!!!'#13'O número de série "'+VpfDItemExterno.NumSerieProduto+'" está duplicado.';
        VpfDItemExterno.IndNumeroSerieDuplicado := true;
        VpfDItemInterno.IndNumeroSerieDuplicado := true;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.SetaContratoProcessado(VpaCodfilial,VpaSeqContrato : Integer);
begin
  ExecutaComandoSql(Aux,'UPDATE CONTRATOCORPO '+
                        ' SET DATULTIMAEXECUCAO = '+SQLTextoDataAAAAMMMDD(Date)+
                        ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQCONTRATO = '+ IntToStr(VpaSeqContrato));
end;

{******************************************************************************}
procedure TRBFuncoesContrato.CarDContratoItem(VpaDContrato : TRBDContratoCorpo);
var
  VpfDItem : TRBDContratoItem;
begin
  FreeTObjectsList(VpaDContrato.ItensContrato);
  AdicionaSQLAbreTabela(Tabela,'select ITE.SEQITEM, ITE.SEQPRODUTO,ITE.CODPRODUTO,ITE.NUMSERIE,ITE.DATULTIMALEITURA,'+
                               ' ITE.DESSETOR, ITE.NUMSERIEINTERNO, ITE.QTDMEDIDORDESATIVACAO, ITE.DATDESATIVACAO, '+
                               ' ITE.QTDMEDIDORDESATIVACAOCOLOR, ITE.QTDULTIMALEITURACOLOR, ITE.VALCUSTOPRODUTO, '+
                               ' QTDULTIMALEITURA, PRO.C_NOM_PRO '+
                               ' from CONTRATOITEM ITE, CADPRODUTOS PRO ' +
                               ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                               ' and ITE.CODFILIAL = '+InttoStr(VpaDContrato.CodFilial)+
                               ' and ITE.SEQCONTRATO = '+IntToStr(VpaDContrato.SeqContrato)+
                               ' order by ITE.DATDESATIVACAO DESC, ITE.SEQITEM');
  while not Tabela.Eof do
  begin
    VpfDItem := VpaDContrato.addItemContrato;
    VpfDItem.SeqItem := Tabela.FieldByName('SEQITEM').AsInteger;
    VpfDItem.SeqProduto := Tabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDItem.CodProduto := Tabela.FieldByName('CODPRODUTO').AsString;
    VpfDItem.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDItem.NumSerieProduto := Tabela.FieldByName('NUMSERIE').AsString;
    VpfDItem.NumSerieInterno := Tabela.FieldByName('NUMSERIEINTERNO').AsString;
    VpfDItem.QtdUltimaLeitura := Tabela.FieldByName('QTDULTIMALEITURA').AsInteger;
    VpfDItem.QtdUltimaLeituraColor := Tabela.FieldByName('QTDULTIMALEITURACOLOR').AsInteger;
    VpfDItem.DatUltimaLeitura := Tabela.FieldByName('DATULTIMALEITURA').AsDateTime;
    VpfDItem.DesSetorEmpresa := Tabela.FieldByName('DESSETOR').AsString;
    VpfDItem.DatDesativacao := Tabela.FieldByName('DATDESATIVACAO').AsDateTime;
    VpfDItem.QtdLeituraDesativacao := Tabela.FieldByName('QTDMEDIDORDESATIVACAO').AsInteger;
    VpfDItem.QtdLeituraDesativacaoColor := Tabela.FieldByName('QTDMEDIDORDESATIVACAOCOLOR').AsInteger;
    VpfDItem.ValCustoProduto := Tabela.FieldByName('VALCUSTOPRODUTO').AsFloat;
    Tabela.Next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.CarDLeituraLocacaoItem(VpaDLeitura : TRBDLeituraLocacaoCorpo);
var
  VpfDItem : TRBDLeituraLocacaoItem;
begin
  AdicionaSqlAbreTabela(Tabela,'Select ITE.SEQITEM, ITE.SEQPRODUTO,ITE.CODPRODUTO,ITE.NUMSERIE,ITE.DATULTIMALEITURA,'+
                               ' ITE.QTDULTIMALEITURA, ITE.DESSETOR, ITE.NUMSERIEINTERNO, ITE.QTDLEITURA,ITE.QTDDEFEITO, '+
                               ' ITE.QTDCOPIAS, ITE.INDDESATIVAR, ITE.QTDULTIMALEITURACOLOR, ITE.QTDLEITURACOLOR, '+
                               ' ITE.QTDDEFEITOCOLOR, ITE.QTDCOPIASCOLOR, '+
                               ' PRO.C_NOM_PRO '+
                               ' from LEITURALOCACAOITEM ITE, CADPRODUTOS PRO '+
                               ' Where ITE.CODFILIAL = '+IntToStr(VpaDLeitura.CodFilial)+
                               ' and ITE.SEQLEITURA = '+IntToStr(VpaDLeitura.SeqLeitura)+
                               ' and ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                               ' order by ITE.SEQITEM');
  While not Tabela.Eof do
  begin
    VpfDItem := VpaDLeitura.AddItemLeitura;
    VpfDItem.SeqItem := Tabela.FieldByName('SEQITEM').AsInteger;
    VpfDItem.SeqProduto := Tabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDItem.CodProduto := Tabela.FieldByName('CODPRODUTO').AsString;
    VpfDItem.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDItem.NumSerieProduto := Tabela.FieldByName('NUMSERIE').AsString;
    VpfDItem.NumSerieInterno := Tabela.FieldByName('NUMSERIEINTERNO').AsString;
    VpfDItem.DesSetorEmpresa := Tabela.FieldByName('DESSETOR').AsString;
    VpfDItem.QtdUltimaLeitura := Tabela.FieldByName('QTDULTIMALEITURA').AsInteger;
    VpfDItem.QtdUltimaLeituraColor := Tabela.FieldByName('QTDULTIMALEITURACOLOR').AsInteger;
    VpfDItem.QtdMedidorAtual := Tabela.FieldByName('QTDLEITURA').AsInteger;
    VpfDItem.QtdMedidorAtualColor := Tabela.FieldByName('QTDLEITURACOLOR').AsInteger;
    VpfDItem.QtdDefeitos := Tabela.FieldByName('QTDDEFEITO').AsInteger;
    VpfDItem.QtdDefeitosColor := Tabela.FieldByName('QTDDEFEITOCOLOR').AsInteger;
    VpfDItem.QtdTotalCopias := Tabela.FieldByName('QTDCOPIAS').AsInteger;
    VpfDItem.QtdTotalCopiasColor := Tabela.FieldByName('QTDCOPIASCOLOR').AsInteger;
    VpfDItem.DatUltimaLeitura := Tabela.FieldByName('DATULTIMALEITURA').AsDatetime;
    VpfDItem.IndDesativar := (Tabela.FieldByName('INDDESATIVAR').AsString = 'S');
    Tabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.CarDServicoContrato(VpaDContratoCorpo: TRBDContratoCorpo);
Var
  VpfDServico : TRBDContratoServico;
begin
  AdicionaSQLAbreTabela(Tabela,'Select CON.CODSERVICO, CON.NOMSERVICO SERVICONOTA,CON.DESADICIONAIS, '+
                               ' CON.QTDSERVICO, CON.VALSERVICO, CON.VALTOTSERVICO, '+
                               ' SER.C_NOM_SER, SER.C_COD_CLA, '+
                               ' SER.I_COD_FIS '+
                               ' from CONTRATOSERVICO CON, CADSERVICO SER '+
                               ' Where CON.CODFILIAL = '+ IntToStr(VpaDContratoCorpo.CodFilial)+
                               ' AND CON.SEQCONTRATO = '+ IntToStr(VpaDContratoCorpo.SeqContrato)+
                               ' AND CON.CODSERVICO = SER.I_COD_SER' );
  While not Tabela.Eof do
  begin
    VpfDServico := VpaDContratoCorpo.addServicoContrato;
    VpfDServico.CodServico := Tabela.FieldByName('CODSERVICO').AsInteger;
    VpfDServico.NomServico := Tabela.FieldByName('C_NOM_SER').AsString;
    VpfDServico.DesAdicional:= Tabela.FieldByName('DESADICIONAIS').AsString;
    VpfDServico.QtdServico := Tabela.FieldByName('QTDSERVICO').AsFloat;
    VpfDServico.ValUnitario := Tabela.FieldByName('VALSERVICO').AsFloat;
    VpfDServico.ValTotal := Tabela.FieldByName('VALTOTSERVICO').AsFloat;
    VpfDServico.CodClassificacao := Tabela.FieldByname('C_COD_CLA').AsString;
    VpfDServico.CodFiscal := Tabela.FieldByName('I_COD_FIS').AsInteger;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.CarDUltimaLeituraLocacaoCliente(VpaCodFilial, vpaCodSeQContrato,VpaCodCliente: Integer): TRBDLeituraLocacaoCorpo;
begin
  Result := nil;
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQLEITURA) ULTIMA from LEITURALOCACAOCORPO '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQCONTRATO = '+IntToStr(vpaCodSeQContrato));
  if not Aux.Eof then
  begin
    result := TRBDLeituraLocacaoCorpo.cria;
    CarDLeituraLocacao(Result,VpaCodFilial,Aux.FieldByName('ULTIMA').AsInteger);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.CarServicosCotacaoparaRecibo(VpaDCotacao: TRBDOrcamento; VpaDRecibo: TRBDReciboLocacao;VpaDLeituraLocacao : TRBDLeituraLocacaoCorpo);
var
  VpfLaco : Integer;
  VpfDSerCotacao : TRBDOrcServico;
  VpfDSerRecibo : TRBDReciboLocacaoServico;
begin
  for VpfLaco := 0 to VpaDCotacao.Servicos.Count-1 do
  begin
    VpfDSerCotacao := TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
    VpfDSerRecibo :=  VpaDRecibo.addServico;
    VpfDSerRecibo.CodServico := VpfDSerCotacao.CodServico;
    VpfDSerRecibo.QtdServico := VpfDSerCotacao.QtdServico;
    VpfDSerRecibo.ValUnitario := VpfDSerCotacao.ValUnitario;
    if config.ExcedenteFranquiaLocacaoFaturaremNotaFiscal and
      (VpaDLeituraLocacao <> nil) then
    begin
      if (VpfDSerCotacao.ValTotal > VpaDLeituraLocacao.ValContrato)  then
        VpfDSerRecibo.ValUnitario := VpaDLeituraLocacao.ValContrato;
    end;

    VpfDSerRecibo.ValTotal := VpfDSerRecibo.QtdServico * VpfDSerRecibo.ValUnitario;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.FaturaContrato(VpaDCotacao : TRBDOrcamento;VpaDItemProcessado : TRBDContratoProcessadoItem; VpaDCliente : TRBDCliente;VpaDLeituraLocacao : TRBDLeituraLocacaoCorpo);
var
  VpfCotacoes : TList;
  VpfResultado : String;
  VpfDContasAReceber : TRBDContasCR;
begin
  VpfDContasAReceber := TRBDContasCR.cria;
  FunCotacao.CalculaValorTotal(VpaDCotacao);
  AtualizaStatus('Grava Cotação');
  VpfResultado := FunCotacao.GravaDCotacao(VpaDCotacao,VpaDCliente);
  if VpfResultado = '' then
  begin
    if ((not VpaDCliente.IndNotaFiscal)and not(VpaDCliente.IndRecibo)) or (not Config.EmitirNotaFaturamentoMensal) then
    begin
      AtualizaStatus('Gera Financeiro');
      FunCotacao.GeraFinanceiro(VpaDCotacao,nil,VpfDContasAReceber,FunContasAReceber,VpfResultado,true,false,false);
      AtualizaStatus('Adiciona financeiro arquivo de remessa');
      FunCotacao.AdicionaFinanceiroArqRemessa(VpaDCotacao);
      if config.ImprimirCotacaoFatMensal then
      begin
        AtualizaStatus('Imprimindo cotacao');
        dtRave := TdtRave.create(nil);
        dtRave.ImprimePedido(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento,false);
        dtRave.free;
      end;
    end
    else
    begin
      VpfCotacoes := TList.create;
      VpfCotacoes.Add(VpaDCotacao);
      if config.GerarFinanceiroCotacao or
         VpaDCliente.IndRecibo  or
        (config.FaturarLocacaoComRecibo and (VpaDLeituraLocacao <> nil)) then
      begin
        AtualizaStatus('Gera Financeiro');
        FunCotacao.GeraFinanceiro(VpaDCotacao,VpaDCliente,VpfDContasAReceber,FunContasAReceber,VpfResultado,true,false,false);
        AtualizaStatus('Adiciona financeiro arquivo de remessa');
        FunCotacao.AdicionaFinanceiroArqRemessa(VpaDCotacao);
      end;
      FaturaCrachaComoServico(VpaDCotacao);

      if VpaDCliente.IndRecibo or
         (config.FaturarLocacaoComRecibo and (VpaDLeituraLocacao <> nil)) then
      begin
        VpfResultado := GeraReciboLocacao(VpaDCotacao, VpaDCliente, VpaDLeituraLocacao);
      end
      else
      begin
        AtualizaStatus('Gerando a nota fiscal');
        FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(application,'', true);
        VpfResultado := FNovaNotaFiscalNota.GeraNotaCotacoesAutomatico(VpfCotacoes,VpaDCliente,VprBarraStatus);
        FNovaNotaFiscalNota.free;

        if not config.GerarFinanceiroCotacao then
          FunNotaFiscal.AdicionaFinanceiroArquivoRemessa(varia.CodigoEmpFil,FunCotacao.RSeqNotaFiscalCotacao(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento));
      end;

      VpfCotacoes.free;
      if VpfResultado = '' then
      begin
        AtualizaStatus('Atualizando os dados da nota na cotação');
        VpfResultado := FunCotacao.GravaDCotacao(VpaDCotacao,VpaDCliente);
      end;
    end;
  end;
  if VpaDItemProcessado <> nil then
  begin
    if VpfResultado = '' then
    begin
      VpaDItemProcessado.LanOrcamento := VpaDCotacao.LanOrcamento;
      VpaDItemProcessado.IndProcessado := true;
    end
    else
    begin
      try
        VpaDItemProcessado.IndProcessado := false;
        VpaDItemProcessado.DesErro := VpfResultado;
      except
      end;
    end;
  end;

  if config.EnviarEmailFaturamentoMensal then
    if VpaDCliente.DesEmail <> '' then
    begin
      AtualizaStatus('Enviando e-mail da fatura');
      FunCotacao.EnviaEmailCliente(VpaDCotacao,VpaDCliente);
    end;
  VpfDContasAReceber.free;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.InicializaDContratoProcessado(VpaDContratoProcessado : TRBDContratoProcessadoCorpo);
begin
  with  VpaDContratoProcessado do
  begin
    CodFilial := varia.CodigoEmpFil;
    CodUsuario := varia.CodigoUsuario;
    DatProcessado := now;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.AtualizaMedidoresContrato(VpaDLeitura : TRBDLeituraLocacaoCorpo):string;
var
  VpfDItemLeitura : TRBDLeituraLocacaoItem;
  VpfLaco : Integer;
begin
  result := '';
  for Vpflaco := 0 to VpaDLeitura.ItensLeitura.Count -1 do
  begin
    VpfDItemLeitura := TRBDLeituraLocacaoItem(VpaDLeitura.ItensLeitura.Items[VpfLaco]);
    if (VpfDItemLeitura.QtdMedidorAtual <> 0) or (VpfDItemLeitura.QtdMedidorAtualColor <> 0) then
    begin
      AdicionaSQLAbreTabela(Cadastro,'Select * from CONTRATOITEM '+
                                     ' Where CODFILIAL = '+IntToStr(VpaDLeitura.CodFilial)+
                                     ' and SEQCONTRATO = '+InttoStr(VpaDLeitura.SeqContrato)+
                                     ' and NUMSERIE = '''+VpfDItemLeitura.NumSerieProduto+'''');
      if not Cadastro.eof then
      begin
        Cadastro.Edit;
        Cadastro.FieldByName('DATULTIMALEITURA').AsDateTime := VpaDLeitura.DatLeitura;
        Cadastro.FieldByName('QTDULTIMALEITURA').AsInteger := VpfDItemLeitura.QtdMedidorAtual;
        Cadastro.FieldByName('QTDULTIMALEITURACOLOR').AsInteger := VpfDItemLeitura.QtdMedidorAtualColor;
        if VpfDItemLeitura.IndDesativar then
        begin
          Cadastro.FieldByName('QTDMEDIDORDESATIVACAO').Clear;
          Cadastro.FieldByName('QTDMEDIDORDESATIVACAOCOLOR').Clear;
          if Cadastro.FieldByName('DATDESATIVACAO').AsDateTime < montadata(1,1,1970) then
            Cadastro.FieldByName('DATDESATIVACAO').AsDateTime := date;
        end;

        Cadastro.post;
        result := Cadastro.AMensagemErroGravacao;
        if Cadastro.AErronaGravacao then
          break;
      end
      else
        aviso('ERRO AO ATUALIZAR OS MEDIDORES!!!'#13'Não foi possivel atualizar os medidos do equipamento de numero de série "'+VpfDItemLeitura.NumSerieProduto+'"');
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesContrato.AtualizaDatUltimaLeituraCFG : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CFG_GERAL');
  Cadastro.edit;
  Cadastro.FieldByname('D_ULT_LEL').AsDateTime := date;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA ATUALIZAÇÃO DA DATA DA ULTIMA LEITURA!!!'#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesContrato.ProcessaFaturamentoPosterior(VpaMostrador : TProgressbar;VpaEstgio : TLabel;VpaDatInicio, VpaDatFim : TDateTime;VpaCodCliente : Integer;var VpaLanOrcamento : Integer;VpaContratosProcessados :TRBDContratoProcessadoCorpo;VpaNaoFaturarReajuste : Boolean;VpaDCotacaoContrato : TRBDOrcamento):string;
Var
  vpfCodCliente, VpfCodClienteMaster ,VpfQtd : Integer;
  VpfDCotacao,VpfDCotacaoGerada : TRBDOrcamento;
  VpfDCliente : TRBDCliente;
  VpfDItemProcessado : TRBDContratoProcessadoItem;
begin
  result := '';
  VpfDItemProcessado := nil;
  VpaLanOrcamento := 0;
  VpaEstgio.Caption := 'Processando faturamentos posteriores do cliente '+ Inttostr(VpaCodCliente);
  VpaEstgio.refresh;
  LFaturamentosPosteriores(FaturamentoPosterior,VpaDatInicio,VpaDatFim,VpaCodCliente,VpfQtd);
  if VpaCodCliente = 0 then
  begin
    VpaMostrador.Max := VpfQtd;
    VpaMostrador.Position := 0;
  end;
  VpfDCliente := TRBDCliente.cria;
  vpfCodCliente := -1;
  VpfCodClienteMaster := -1;
  while not FaturamentoPosterior.eof do
  begin
    if not(ClientePossuiContratoaReajustar(FaturamentoPosterior.FieldByName('I_COD_CLI').AsInteger)) or
       not VpaNaoFaturarReajuste then
    begin
      VpfDCotacaoGerada := TRBDOrcamento.cria;
      FunCotacao.CarDOrcamento(VpfDCotacaoGerada,FaturamentoPosterior.FieldByName('I_EMP_FIL').AsInteger,FaturamentoPosterior.FieldByName('I_LAN_ORC').AsInteger );
      if ((vpfCodCliente <> FaturamentoPosterior.FieldByName('I_COD_CLI').AsInteger) and (FaturamentoPosterior.FieldByName('I_CLI_MAS').AsInteger = 0)) or
         (VpfCodClienteMaster <> FaturamentoPosterior.FieldByName('I_CLI_MAS').AsInteger)  then
      begin
        if vpfCodCliente <> -1 then
        begin
          if (VpfDCotacao.Produtos.Count > 0) or (VpfDCotacao.Servicos.Count > 0) then
          begin
            if config.ControlarFaturamentoMinimoContrato and (VpaCodCliente = 0) then
              VerificaQtdMinimaFaturamento(VpfDCotacao);
            if VpaDCotacaoContrato = nil then
              FaturaContrato(VpfDCotacao,VpfDItemProcessado,VpfDCliente,nil);
          end;
          if VpaDCotacaoContrato = nil then
            VpfDCotacao.free;
        end;
        VpfDCliente.CodCliente := FaturamentoPosterior.FieldByName('I_COD_CLI').AsInteger;
        FunClientes.CarDCliente(VpfDCliente);
        VpaEstgio.Caption := 'Processando faturamento posterior do cliente "'+VpfDCliente.NomCliente+'"';
        VpaEstgio.refresh;

        vpfCodCliente :=FaturamentoPosterior.FieldByName('I_COD_CLI').AsInteger;
        VpfCodClienteMaster := FaturamentoPosterior.FieldByName('I_CLI_MAS').AsInteger;

        if VpaDCotacaoContrato <> nil then
          VpfDCotacao := VpaDCotacaoContrato
        else
          VpfDCotacao := GeraCotacaodoFaturamentoPosterior(VpfDCotacaoGerada,VpfDCliente);
      end;
      AdicionaVendasCotacaoFaturamentoPost(VpfDCotacao,VpfDCotacaoGerada);
      FunCotacao.AlteraTipoCotacao(VpfDCotacaoGerada,varia.TipoCotacaoContrato);
      FunCotacao.AdicionaDescontoCotacaoDePara(VpfDCotacaoGerada,VpfDCotacao);

      if VpaContratosProcessados <> nil then
        VpfDItemProcessado := VpaContratosProcessados.AddItem;
      if VpaMostrador <> nil then
        VpaMostrador.Position := VpaMostrador.Position +1;
      VpfDCotacaoGerada.free;
    end;
    FaturamentoPosterior.next;
  end;
  if VpfCodCliente <> -1 then
  begin
    if (VpfDCotacao.Produtos.Count > 0) or (VpfDCotacao.Servicos.Count > 0) then
    begin
      if VpaDCotacaoContrato = nil then
      begin
        FaturaContrato(VpfDCotacao,VpfDItemProcessado, VpfDCliente,nil);
        VpaLanOrcamento := VpfDCotacao.LanOrcamento;
      end;
    end;
  end;

  VpaEstgio.Caption := 'Faturamento do cliente "'+VpfDCliente.NomCliente+'" processado com sucesso.';
  VpfDCliente.Free;
  FaturamentoPosterior.close;
  result := '';
end;

{******************************************************************************}
procedure TRBFuncoesContrato.ExcluirFinanceiro(VpaDCotacao : TRBDOrcamento);
begin
  if VpaDCotacao.NumNotas <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from MOVNOTAORCAMENTO '+
                             ' Where I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                             ' and I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento));
    FunNotaFiscal.ExcluiContasaReceber(VpaDCotacao.CodEmpFil,Aux.FieldByName('I_SEQ_NOT').AsInteger,false);
  end
  else
  begin
    FunCotacao.ExcluiFinanceiroOrcamento(VpaDCotacao.CodEmpFil, VpaDCotacao.LanOrcamento,0,false);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.GeraBoletoUnicoContrato(VpaDCotacaoContrato : trbdorcamento;VpaDCliente : TRBDCliente;VpaLanOrcamentoPosterior : Integer);
Var
  vpfCotacoes : TList;
  VpfDNotaFiscal : TRBDNotaFiscal;
  VpfResultado : string;
  VpfDCotacaoFaturamentoPosterior : TRBDOrcamento;
  VpfDContasAReceber : TRBDContasCR;
Begin
  VpfDCotacaoFaturamentoPosterior := TRBDOrcamento.cria;
  VpfDCotacaoFaturamentoPosterior.CodEmpFil := varia.codigoempfil;
  VpfDCotacaoFaturamentoPosterior.LanOrcamento := VpaLanOrcamentoPosterior;
  FunCotacao.CarDOrcamento(VpfDCotacaoFaturamentoPosterior);

  ExcluirFinanceiro(VpaDCotacaoContrato);
  ExcluirFinanceiro(VpfDCotacaoFaturamentoPosterior);
  VpfDCotacaoFaturamentoPosterior.ValTotal := VpfDCotacaoFaturamentoPosterior.ValTotal + VpaDCotacaoContrato.ValTotal;
  VpfDCotacaoFaturamentoPosterior.ValTotalLiquido := VpfDCotacaoFaturamentoPosterior.ValTotalLiquido + VpaDCotacaoContrato.ValTotalLiquido;

  if VpfDCotacaoFaturamentoPosterior.NumNotas <> ''  then
  begin
    VpfDNotaFiscal := TRBDNotaFiscal.cria;
    VpfDNotaFiscal.CodFilial := VpfDCotacaoFaturamentoPosterior.CodEmpFil;
    VpfDNotaFiscal.SeqNota := FunCotacao.RSeqNotaFiscalCotacao(VpfDCotacaoFaturamentoPosterior.CodEmpFil,VpfDCotacaoFaturamentoPosterior.LanOrcamento);
    FunNotaFiscal.CarDNotaFiscal(VpfDNotaFiscal);
    VpfDNotaFiscal.ValTotal := VpfDCotacaoFaturamentoPosterior.ValTotalLiquido;
    VpfDNotaFiscal.IndMostrarParcelas := false;
    VpfDContasAReceber := TRBDContasCR.cria;
    FunNotaFiscal.GeraFinanceiroNota(VpfDNotaFiscal,vpfCotacoes,VpaDCliente,VpfDContasAReceber,false,true);
    if not config.GerarFinanceiroCotacao then
      FunNotaFiscal.AdicionaFinanceiroArquivoRemessa(varia.CodigoEmpFil,VpfDNotaFiscal.SeqNota);
    VpfDNotaFiscal.free;
  end
  else
  begin
    VpfDContasAReceber := TRBDContasCR.cria;
    FunCotacao.GeraFinanceiro(VpfDCotacaoFaturamentoPosterior,nil,VpfDContasAReceber,FunContasAReceber,VpfResultado,true,false);
    FunCotacao.AdicionaFinanceiroArqRemessa(VpfDCotacaoFaturamentoPosterior);
  end
end;

{******************************************************************************}
procedure TRBFuncoesContrato.ImprimirBoleto(VpaCodFilial,VpaLanOrcamento,VpaCodCliente : Integer);
Var
  VpfDCliente : TRBDCliente;
begin
    if config.GerarFinanceiroCotacao then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                ' Where CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial)+
                                ' AND CAD.I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ');
    end
    else
    begin
      AdicionaSQLAbreTabela(Aux,'Select * '+
                                ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV, MOVNOTAORCAMENTO NOTA '+
                                ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                ' AND CAD.I_EMP_FIL = NOTA.I_EMP_FIL '+
                                ' AND CAD.I_SEQ_NOT = NOTA.I_SEQ_NOT '+
                                ' AND NOTA.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                ' AND NOTA.I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
      if Aux.Eof then
        AdicionaSQLAbreTabela(Aux,'Select * from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                  ' Where CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial)+
                                  ' AND CAD.I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                  ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ');
    end;
    While not aux.eof do
    begin
      if Varia.FormaPagamentoBoleto = Aux.FieldByName('I_COD_FRM').AsInteger then
      begin
        VpfDCliente := TRBDCliente.cria;
        VpfDCliente.CodCliente := VpaCodCliente;

        FunClientes.CarDCliente(VpfDCliente);
        FunImpFolhaBranca.ImprimeBoleto(Aux.FieldByName('I_EMP_FIL').AsInteger,Aux.FieldByName('I_LAN_REC').AsInteger,Aux.FieldByName('I_NRO_PAR').AsInteger,
                                    VpfDCliente,false,'',false);
        VpfDCliente.Free;
      end;
      Aux.Next;
    end;
    Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.FaturaCrachaComoServico(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfQtdCracha,VpfValServico : Double;
  VpfDItem : TRBDOrcProduto;
  VpfDServico : TRBDOrcServico;
begin
  VpfQtdCracha :=0;
  VpfValServico := 0;
  for VpfLaco := VpaDCotacao.Produtos.Count - 1 downto 0 do
  begin
    VpfDItem := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDItem.IndCracha then
    begin
       VpfQtdCracha := VpfQtdCracha + VpfDItem.QtdProduto;
       VpfValServico :=  VpfValServico +VpfDItem.ValTotal;
       VpfDItem.Free;
       VpaDCotacao.Produtos.Delete(VpfLaco);
    end;
  end;
  if VpfQtdCracha > 0 then
  begin
    VpfDServico := VpaDCotacao.AddServico;
    VpfDServico.CodServico := 1102;
    FunCotacao.ExisteServico(IntToStr(VpfDServico.CodServico),VpfDServico);
    VpfDServico.DesAdicional := ' de '+FormatFloat('0.00',VpfQtdCracha)+ ' crachas';
    VpfDServico.QtdServico := VpfQtdCracha;
    VpfDServico.ValUnitario := VpfValServico / VpfQtdCracha;
    VpfDServico.ValTotal := VpfValServico;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDContrato(VpaDContrato : TRBDContratoCorpo): String;
begin
  result := '';
  AdicionaSqlAbreTabela(Cadastro,'Select * from CONTRATOCORPO '+
                                 ' Where CODFILIAL = '+IntToStr(VpaDContrato.CodFilial)+
                                 ' and SEQCONTRATO = '+IntToStr(VpadContrato.SeqContrato));
  if cadastro.eof then
    Cadastro.Insert
  else
    Cadastro.edit;

  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDContrato.CodFilial;
  Cadastro.FieldByName('CODCLIENTE').AsInteger := VpaDContrato.CodCliente;
  Cadastro.FieldByName('CODTIPOCONTRATO').AsInteger := VpaDContrato.CodTipoContrato;
  Cadastro.FieldByName('CODSERVICO').AsInteger := VpaDContrato.CodServico;
  Cadastro.FieldByName('QTDMESES').AsInteger := VpaDContrato.QtdMeses;
  Cadastro.FieldByName('QTDFRANQUIA').AsInteger := VpaDContrato.QtdFranquia;
  Cadastro.FieldByName('QTDFRANQUIACOLOR').AsInteger := VpaDContrato.QtdFranquiaColorida;
  if VpaDContrato.CodVendedor <> 0 then
    Cadastro.FieldByName('CODVENDEDOR').AsInteger := VpaDContrato.CodVendedor
  else
    Cadastro.FieldByName('CODVENDEDOR').clear;
  Cadastro.FieldByName('NUMCONTRATO').AsString := VpaDContrato.NumContrato ;
  Cadastro.FieldByName('VALCONTRATO').AsFloat := VpaDContrato.ValContrato ;
  Cadastro.FieldByName('VALEXCESSOFRANQUIA').AsFloat := VpaDContrato.ValExcedenteFranquia ;
  Cadastro.FieldByName('VALEXCESSOFRANQUIACOLOR').AsFloat := VpaDContrato.ValExcedenteColorido ;
  Cadastro.FieldByName('VALDESCONTO').AsFloat := VpaDContrato.ValDesconto;
  Cadastro.FieldByName('DATASSINATURA').AsDateTime := VpaDContrato.DatAssinatura ;
  Cadastro.FieldByName('DATINICIOVIGENCIA').AsDateTime := VpaDContrato.DatInicioVigencia ;
  Cadastro.FieldByName('DATFIMVIGENCIA').AsDateTime := VpaDContrato.DatFimVigencia ;
  Cadastro.FieldByName('CODCONDICAOPAGAMENTO').AsInteger := VpaDContrato.CodCondicaoPagamento ;
  Cadastro.FieldByName('CODFORMAPAGAMENTO').AsInteger := VpaDContrato.CodFormaPagamento ;
  if VpaDContrato.NumContaBancaria <> '' then
    Cadastro.FieldByName('NUMCONTACORRENTE').AsString := VpaDContrato.NumContaBancaria
  else
    Cadastro.FieldByName('NUMCONTACORRENTE').clear;
  Cadastro.FieldByName('NUMTEXTOSERVICO').AsInteger := VpaDContrato.NumTextoServico ;
  Cadastro.FieldByName('TIPPERIODO').AsInteger := VpaDContrato.TipPeriodicidade;
  Cadastro.FieldByName('DESNOTACUPOM').AsString := VpaDContrato.NotaFiscalCupom;
  Cadastro.FieldByName('NOMCONTATO').AsString := VpaDContrato.NomContato;
  Cadastro.FieldByName('DESEMAIL').AsString := VpaDContrato.DesEmail;
  Cadastro.FieldByName('CODTECNICOLEITURA').AsInteger := VpaDContrato.CodTecnicoLeitura;
  cadastro.FieldByName('DATALTERACAO').AsDateTime := now;
  if VpaDContrato.IndProcessamentoAutomatico then
    Cadastro.FieldByName('INDAUTOMATICO').AsString := 'S'
  else
    Cadastro.FieldByName('INDAUTOMATICO').AsString := 'N';

  if VpaDContrato.NumDiaLeitura <> 0 then
    Cadastro.FieldByname('NUMDIALEITURA').AsInteger := VpaDContrato.NumDiaLeitura
  else
    Cadastro.FieldByname('NUMDIALEITURA').Clear;

  if VpaDContrato.DatCancelamento > montadata(1,1,1950) then
    Cadastro.FieldByName('DATCANCELAMENTO').AsDateTime := VpaDContrato.DatCancelamento
  else
    Cadastro.FieldByName('DATCANCELAMENTO').clear;

  if VpaDContrato.DatUltimaExecucao > montadata(1,1,1950) then
    Cadastro.FieldByName('DATULTIMAEXECUCAO').AsDateTime := VpaDContrato.DatUltimaExecucao
  else
    Cadastro.FieldByName('DATULTIMAEXECUCAO').clear;

  if VpaDContrato.CodPreposto <> 0 then
    Cadastro.FieldByName('CODPREPOSTO').AsInteger := VpaDContrato.CodPreposto
  else
    Cadastro.FieldByName('CODPREPOSTO').clear;
  Cadastro.FieldByName('PERCOMISSAO').AsFloat := VpaDContrato.PerComissao;
  Cadastro.FieldByName('PERCOMISSAOPREPOSTO').AsFloat := VpaDContrato.PerComissaoPreposto;

  if VpaDContrato.SeqContrato = 0 then
  begin
    VpaDContrato.SeqContrato := RProximoSeqContrato(VpaDContrato.CodFilial);
    Cadastro.FieldByName('DATCADASTRO').AsDateTime := now;
  end;
  Cadastro.FieldByName('SEQCONTRATO').AsInteger := VpaDContrato.SeqContrato;
  try
    cadastro.post;
  except
     on e : exception do result := 'ERRO NA GRAVAÇÃO DA TABELA CONTRATO CORPO!!!'#13+e.message;
  end;
  cadastro.close;

  if result = '' then
    result := GravaDContratoItem(VpaDContrato);

  if result = '' then
    result := GravaDContratoServico(VpaDContrato);
end;

{******************************************************************************}
function TRBFuncoesContrato.GravaDLeituraLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from LEITURALOCACAOCORPO '+
                                 ' Where CODFILIAL = '+IntToStr(VpaDLeitura.CodFilial)+
                                 ' and SEQLEITURA = '+IntToStr(VpaDLeitura.SeqLeitura));
  if Cadastro.Eof or (VpaDLeitura.SeqLeitura = 0) then
    Cadastro.insert
  else
    Cadastro.Edit;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDLeitura.CodFilial;
  Cadastro.FieldByName('DATDIGITACAO').AsDateTime := VpaDLeitura.DatDigitacao;
  Cadastro.FieldByName('MESLOCACAO').AsInteger := VpaDLeitura.MesLocacao;
  Cadastro.FieldByName('ANOLOCACAO').AsInteger := VpaDLeitura.AnoLocacao;
  Cadastro.FieldByName('CODCLIENTE').AsInteger := VpaDLeitura.CodCliente;
  Cadastro.FieldByName('SEQCONTRATO').AsInteger := VpaDLeitura.SeqContrato;
  Cadastro.FieldByName('CODTECNICOLEITURA').AsInteger := VpaDLeitura.CodTecnicoLeitura;
  Cadastro.FieldByName('DATLEITURA').AsDateTime := VpaDLeitura.DatLeitura;
  Cadastro.FieldByName('QTDCOPIA').AsInteger := VpaDLeitura.QtdCopias;
  Cadastro.FieldByName('QTDCOPIACOLOR').AsInteger := VpaDLeitura.QtdCopiasColor;
  Cadastro.FieldByName('QTDEXCEDENTE').AsInteger := VpaDLeitura.QtdExcedente;
  Cadastro.FieldByName('QTDEXCEDENTECOLOR').AsInteger := VpaDLeitura.QtdExcednteColor;
  Cadastro.FieldByName('QTDDEFEITO').AsInteger := VpaDLeitura.QtdDefeitos;
  Cadastro.FieldByName('QTDDEFEITOCOLOR').AsInteger := VpaDLeitura.QtdDefeitosColor;
  Cadastro.FieldByName('VALTOTAL').AsFloat := VpaDLeitura.ValTotal;
  Cadastro.FieldByName('VALDESCONTO').AsFloat := VpaDLeitura.ValDesconto;
  Cadastro.FieldByName('VALTOTALDESCONTO').AsFloat := VpaDLeitura.ValTotalComDesconto;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDLeitura.CodUsuario;
  if VpaDLeitura.DesObservacao <> '' then
    Cadastro.FieldByName('DESOBSERVACAO').AsString := VpaDLeitura.DesObservacao
  else
    Cadastro.FieldByName('DESOBSERVACAO').clear;
  if VpaDLeitura.DesOrdemCompra <> '' then
    Cadastro.FieldByName('DESORDEMCOMPRA').AsString := VpaDLeitura.DesOrdemCompra
  else
    Cadastro.FieldByName('DESORDEMCOMPRA').clear;
  if VpaDLeitura.DatProcessamento > MontaData(1,1,1990) then
    Cadastro.FieldByName('DATPROCESSAMENTO').AsDateTime := VpaDLeitura.DatProcessamento
  else
    Cadastro.FieldByName('DATPROCESSAMENTO').clear;
  if VpaDLeitura.LanOrcamento > 0 then
    Cadastro.FieldByName('LANORCAMENTO').AsInteger := VpaDLeitura.LanOrcamento
  else
    Cadastro.FieldByName('LANORCAMENTO').clear;
  Cadastro.FieldByName('VALCONTRATO').AsFloat:= VpaDLeitura.ValContrato;
  Cadastro.FieldByName('VALEXECESSOFRANQUIA').AsFloat:= VpaDLeitura.ValExcessoFranquia;
  Cadastro.FieldByName('QTDFRANQUIA').AsInteger:= VpaDLeitura.QtdFranquia;
  Cadastro.FieldByName('VALEXECESSOFRANQUIACOLOR').AsFloat:= VpaDLeitura.ValExcessoFranquiaColor;
  Cadastro.FieldByName('QTDFRANQUIACOLOR').AsInteger:= VpaDLeitura.QtdFranquiaColor;

  if VpaDLeitura.SeqLeitura = 0 then
    VpaDLeitura.SeqLeitura := RProximoSeqLeituraLocacao(VpaDLeitura.CodFilial);
  Cadastro.FieldByName('SEQLEITURA').AsInteger := VpaDLeitura.SeqLeitura;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA LEITURA LOCACAO CORPO!!!'#13+e.message;
  end;
  if result ='' then
  begin
    result := GravaDLeituraLocacaoItem(VpaDLeitura);
    if result = '' then
      result := AtualizaDatUltimaLeituraCFG;
  end;

  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.CalculaContrato(VpaDContrato: TRBDContratoCorpo);
var
  VpfTotFrete, VpfValICMS, VpfValIPI, VpfValTotalServico : double;
  descontoFormato : string;
  Sinal : string;
  VpfLaco, VpfLacoServico : Integer;
  VpfDItemServico: TRBDContratoServico;
begin
  VpaDContrato.ValContrato := 0;

  for VpfLacoServico := 0 to VpaDContrato.ServicoContrato.Count - 1 do
  begin
    VpfDItemServico := TRBDContratoServico(VpaDContrato.ServicoContrato.Items[VpfLacoServico]);
    VpaDContrato.ValTotalServico:=VpaDContrato.ValTotalServico + VpfDItemServico.ValTotal;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.CancelaContratosVigenciaVencida(VpaDataFimVigencia: TDateTime): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(*) QTD from CONTRATOCORPO '+
                             ' WHERE DATFIMVIGENCIA <= '+SQLTextoDataAAAAMMMDD(VpaDataFimVigencia)+
                             ' AND DATCANCELAMENTO IS NULL ');
  result := Aux.FieldByName('QTD').AsInteger;
  ExecutaComandoSql(Aux,'UPDATE CONTRATOCORPO '+
                        ' SET DATCANCELAMENTO = ' +SQLTextoDataAAAAMMMDD(Sistema.RDataServidor)+
                        ' WHERE DATFIMVIGENCIA <= '+SQLTextoDataAAAAMMMDD(VpaDataFimVigencia)+
                        ' AND DATCANCELAMENTO IS NULL ');
end;

function TRBFuncoesContrato.CancelaRecibo(VpaCodFilial, VpaSeqRecibo: Integer;VpaMotivo : String) : string;
begin
  AdicionaSQLAbreTabela(Cadastro, ' SELECT * FROM RECIBOLOCACAOCORPO ' +
                               ' WHERE SEQRECIBO = ' + IntToStr(VpaSeqRecibo) +
                               ' AND CODFILIAL = ' + IntToStr(VpaCodfilial));
  Cadastro.Edit;
  Cadastro.FieldByName('DATCANCELAMENTO').AsDateTime := now;
  Cadastro.FieldByName('INDCANCELADO').AsString := 'S';
  Cadastro.FieldByName('CODUSUARIOCANCELAMENTO').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('DESMOTIVOCANCELAMENTO').AsString := VpaMotivo;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.CarDContrato(VpaDContrato : TRBDContratoCorpo;VpaCodFilial, VpaSeqContrato : Integer);
begin
  AdicionaSqlAbreTabela( Tabela,'Select CON.CODFILIAL, CON.CODCLIENTE, CON.CODTIPOCONTRATO, CON.QTDFRANQUIA, '+
                                ' CON.CODSERVICO, CON.QTDMESES, CON.CODVENDEDOR, CON.CODCONDICAOPAGAMENTO, '+
                                ' CON.CODFORMAPAGAMENTO, CON.NUMCONTACORRENTE, CON.NUMTEXTOSERVICO, '+
                                ' CON.NUMCONTRATO, CON.VALCONTRATO, CON.VALDESCONTO, CON.VALEXCESSOFRANQUIA, '+
                                ' CON.VALEXCESSOFRANQUIACOLOR, CON.DATASSINATURA, CON.DATCANCELAMENTO, CON.DATULTIMAEXECUCAO, '+
                                ' CON.QTDFRANQUIACOLOR, CON.DATINICIOVIGENCIA, CON.DATFIMVIGENCIA,'+
                                ' CON.DESNOTACUPOM, CON.TIPPERIODO, CON.NOMCONTATO, CON.CODTECNICOLEITURA,'+
                                ' CON.INDAUTOMATICO, CON.NUMDIALEITURA,  CON.CODPREPOSTO, CON.PERCOMISSAO, '+
                                ' CON.PERCOMISSAOPREPOSTO, CON.DESEMAIL, ' +
                                ' SER.C_NOM_SER '+
                                ' from CONTRATOCORPO CON, CADSERVICO SER '+
                                ' Where CON.CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' and CON.SEQCONTRATO = '+IntToStr(VpaSeqContrato)+
                                ' AND CON.CODSERVICO = SER.I_COD_SER '+
                                ' AND SER.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
  VpaDContrato.CodFilial := Tabela.FieldByName('CODFILIAL').AsInteger;
  VpaDContrato.SeqContrato :=  VpaSeqContrato;
  VpaDContrato.CodCliente := Tabela.FieldByName('CODCLIENTE').AsInteger;
  VpaDContrato.CodTipoContrato := Tabela.FieldByName('CODTIPOCONTRATO').AsInteger;
  VpaDContrato.CodServico := Tabela.FieldByName('CODSERVICO').AsInteger;
  VpaDContrato.QtdMeses := Tabela.FieldByName('QTDMESES').AsInteger;
  VpaDContrato.QtdFranquia := Tabela.FieldByName('QTDFRANQUIA').AsInteger;
  VpaDContrato.QtdFranquiaColorida := Tabela.FieldByName('QTDFRANQUIACOLOR').AsInteger;
  VpaDContrato.CodVendedor := Tabela.FieldByName('CODVENDEDOR').AsInteger;
  VpaDContrato.CodPreposto := Tabela.FieldByName('CODPREPOSTO').AsInteger;
  VpaDContrato.CodCondicaoPagamento := Tabela.FieldByName('CODCONDICAOPAGAMENTO').AsInteger;
  VpaDContrato.CodFormaPagamento := Tabela.FieldByName('CODFORMAPAGAMENTO').AsInteger;
  VpaDContrato.NumContaBancaria := Tabela.FieldByName('NUMCONTACORRENTE').AsString;
  VpaDContrato.NumTextoServico := Tabela.FieldByName('NUMTEXTOSERVICO').AsInteger;
  VpaDContrato.NumContrato := Tabela.FieldByName('NUMCONTRATO').AsString;
  VpaDContrato.ValContrato := Tabela.FieldByName('VALCONTRATO').AsFloat;
  VpaDContrato.ValDesconto := Tabela.FieldByName('VALDESCONTO').AsFloat;
  VpaDContrato.ValExcedenteFranquia := Tabela.FieldByName('VALEXCESSOFRANQUIA').AsFloat;
  VpaDContrato.ValExcedenteColorido := Tabela.FieldByName('VALEXCESSOFRANQUIACOLOR').AsFloat;
  VpaDContrato.DatInicioVigencia := Tabela.FieldByName('DATINICIOVIGENCIA').AsDateTime;
  VpaDContrato.DatFimVigencia := Tabela.FieldByName('DATFIMVIGENCIA').AsDateTime;
  VpaDContrato.DatAssinatura := Tabela.FieldByName('DATASSINATURA').AsDateTime;
  VpaDContrato.DatCancelamento := Tabela.FieldByName('DATCANCELAMENTO').AsDateTime;
  VpaDContrato.DatUltimaExecucao := Tabela.FieldByName('DATULTIMAEXECUCAO').AsDateTime;
  VpaDContrato.NomServico := Tabela.FieldByName('C_NOM_SER').AsString;
  VpaDContrato.NotaFiscalCupom := Tabela.FieldByName('DESNOTACUPOM').AsString;
  VpaDContrato.TipPeriodicidade := Tabela.FieldByName('TIPPERIODO').AsInteger;
  VpaDContrato.NomContato := Tabela.FieldByName('NOMCONTATO').AsString;
  VpaDContrato.CodTecnicoLeitura := Tabela.FieldByName('CODTECNICOLEITURA').AsInteger;
  VpaDContrato.IndNotaFiscal := (Tabela.FieldByName('DESNOTACUPOM').AsString = 'N');
  VpaDContrato.IndRecibo := (Tabela.FieldByName('DESNOTACUPOM').AsString = 'R');
  VpaDContrato.IndProcessamentoAutomatico := (Tabela.FieldByName('INDAUTOMATICO').AsString = 'S');
  VpaDContrato.NumDiaLeitura := Tabela.FieldByname('NUMDIALEITURA').AsInteger;
  VpaDContrato.PerComissao := Tabela.FieldByname('PERCOMISSAO').AsFloat;
  VpaDContrato.PerComissaoPreposto := Tabela.FieldByname('PERCOMISSAOPREPOSTO').AsFloat;
  VpaDContrato.DesEmail := Tabela.FieldByName('DESEMAIL').AsString;

  CarDContratoItem(VpaDContrato);
  CarDServicoContrato(VpaDContrato);
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.CarDLeituraLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo;VpaCodFilial,VpaSeqLeitura : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from LEITURALOCACAOCORPO '+
                           ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                           ' and SEQLEITURA = '+IntToStr(VpaSeqLeitura));
  with VpaDLeitura do
  begin
    CodFilial := VpaCodFilial;
    SeqLeitura := VpaSeqLeitura;
    CodCliente := Tabela.FieldByName('CODCLIENTE').AsInteger;
    MesLocacao := Tabela.FieldByName('MESLOCACAO').AsInteger;
    AnoLocacao := Tabela.FieldByName('ANOLOCACAO').AsInteger;
    SeqContrato := Tabela.FieldByName('SEQCONTRATO').AsInteger;
    CodTecnicoLeitura := Tabela.FieldByName('CODTECNICOLEITURA').AsInteger;
    QtdCopias := Tabela.FieldByName('QTDCOPIA').AsInteger;
    QtdCopiasColor := Tabela.FieldByName('QTDCOPIACOLOR').AsInteger;
    QtdExcedente := Tabela.FieldByName('QTDEXCEDENTE').AsInteger;
    QtdExcednteColor := Tabela.FieldByName('QTDEXCEDENTECOLOR').AsInteger;
    QtdDefeitos := Tabela.FieldByName('QTDDEFEITO').AsInteger;
    QtdDefeitosColor := Tabela.FieldByName('QTDDEFEITOCOLOR').AsInteger;
    LanOrcamento := Tabela.FieldByName('LANORCAMENTO').AsInteger;
    CodUsuario := Tabela.FieldByName('CODUSUARIO').AsInteger;
    DatDigitacao := Tabela.FieldByName('DATDIGITACAO').AsDateTime;
    DatLeitura := Tabela.FieldByName('DATLEITURA').AsDateTime;
    DatProcessamento := Tabela.FieldByName('DATPROCESSAMENTO').AsDateTime;
    ValTotal := Tabela.FieldByName('VALTOTAL').AsFloat;
    ValDesconto := Tabela.FieldByName('VALDESCONTO').AsFloat;
    ValTotalComDesconto := Tabela.FieldByName('VALTOTALDESCONTO').AsFloat;
    DesObservacao:= Tabela.FieldByName('DESOBSERVACAO').AsString;
    DesOrdemCompra:= Tabela.FieldByName('DESORDEMCOMPRA').AsString;
    ValContrato:= Tabela.FieldByName('VALCONTRATO').AsFloat;
    ValExcessoFranquia:= Tabela.FieldByName('VALEXECESSOFRANQUIA').AsFloat;
    QtdFranquia:= Tabela.FieldByName('QTDFRANQUIA').AsInteger;
    ValExcessoFranquiaColor:= Tabela.FieldByName('VALEXECESSOFRANQUIACOLOR').AsFloat;
    QtdFranquiaColor:= Tabela.FieldByName('QTDFRANQUIACOLOR').AsInteger;
  end;
  CarDLeituraLocacaoItem(VpaDLeitura);
end;

{******************************************************************************}
function TRBFuncoesContrato.EnviaEmail(VpaMensagem: TIdMessage;
  VpaSMTP: TIdSMTP): string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  if VpaMensagem.From.Address = '' then
    VpaMensagem.From.Address := varia.UsuarioSMTP;
  VpaMensagem.From.Name := varia.NomeFilial;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := varia.PortaSMTP;
  if config.ServidorInternetRequerAutenticacao then
    VpaSMTP.AuthType := satDefault
  else
    VpaSMTP.AuthType := satNone;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    VpaMensagem.ReceiptRecipient.Text  :=VpaMensagem.From.Text;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DA FILIAL !!!'#13'É necessário preencher o e-mail da transportadora.';
  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    VpaSMTP.Connect;
    try
      VpaSMTP.Send(VpaMensagem);

    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
        VpaSMTP.Disconnect;
      end;
    end;
    VpaSMTP.Disconnect;
    VpaMensagem.Clear;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.EnviaEmailCliente(VpaDContrato: TRBDContratoCorpo;
  VpaDCliente: TRBDCliente): string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfEmailVendedor,VpfEmailCliente, VpfNomAnexo, VpfEmailUsuario : String;
  VpfPDF, Vpfbmppart : TIdAttachmentFile;
  VpfChar : Char;
begin
    result := '';
    if VpaDContrato.DesEmail = '' then
      result := 'E-MAIL DO CLIENTE NÃO PREENCHIDO!!!'#13'Falta preencher o e-mail do cliente.'
    else
      VpaDContrato.DesEmail := VpaDCliente.DesEmail;
    if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
      result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';
    if result = '' then
    begin
      Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDContrato.CodFilial)+'.jpg');
      Vpfbmppart.ContentType := 'image/jpg';
      Vpfbmppart.ContentDisposition := 'inline';
      Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDContrato.CodFilial)+'.jpg';
      Vpfbmppart.FileName := '';
      Vpfbmppart.DisplayName := '';
    end;
      dtRave := TdtRave.Create(nil);
      //VpfNomAnexo := varia.PathVersoes+'\ANEXOS\COTACAO'+IntToStr(VpaDCotacao.CodEmpFil)+'_'+IntToStr(VpaDCotacao.LanOrcamento)+'.PDF';
      dtRave.VplArquivoPDF := VpfNomAnexo ;
     // dtRave.ImprimePedido(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento,false);
      dtRave.Free;
      VpfPDF := TIdAttachmentFile.Create(VprMensagem.MessageParts,VpfNomAnexo);
      VpfPDF.ContentType := 'application/pdf;Cotacao';
      VpfPDF.ContentDisposition := 'inline';
      VpfPDF.ExtraHeaders.Values['content-id'] := VpfNomAnexo;
     // VpfPDF.DisplayName := RetornaNomeSemExtensao(VpfNomAnexo)+'.pdf';


      VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
      VpfEmailHTML.ContentType := 'text/html';

      MontaEmailRecibo(VpfEmailHTML.Body,VpaDContrato,VpaDCliente);

      VpfEmailCliente := VpaDContrato.DesEmail;
      VpfChar := ',';
      if ExisteLetraString(';',VpfEmailCliente) then
        VpfChar := ';';
      while Length(VpfEmailCliente) > 0 do
      begin
        VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
        VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
      end;
      if VpaDContrato.DesEmail <> '' then
      begin
        VpfEmailCliente := VpaDContrato.DesEmail;
        if ExisteLetraString(';',VpfEmailCliente) then
          VpfChar := ';';
        while Length(VpfEmailCliente) > 0 do
        begin
          VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
          VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
        end;
      end;
      if Varia.EmailCopiaCotacao <> '' then
        VprMensagem.Recipients.Add.Address := varia.EmailCopiaCotacao;


      VprMensagem.Subject := Varia.NomeFilial+' - Recibo ' +IntToStr(VpaDContrato.SeqContrato);
      if VpfEmailVendedor <> '' then
      begin
        VprMensagem.ReplyTo.EMailAddresses := VpfEmailVendedor;
      end;
      VprMensagem.ReceiptRecipient.Text  :='';

      result := EnviaEmail(VprMensagem,VprSMTP);
end;

{******************************************************************************}
function TRBFuncoesContrato.EnviaLeituraLocacaoProcessadaEmail(VpaCodFilial, VpaSeqLeitura: Integer): string;
var
  VpfDLeitura : TRBDLeituraLocacaoCorpo;
  VpfNomArquivo : string;
begin
  result := '';
  if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';
  if result = '' then
  begin
    VprMensagem.Clear;
    VpfDLeitura := TRBDLeituraLocacaoCorpo.cria;
    CarDLeituraLocacao(VpfDLeitura,VpaCodFilial,VpaSeqLeitura);
    try
      dtRave := TdtRave.Create(nil);
      VpfNomArquivo := Varia.PathVersoes+'\ANEXOS\Contrato\LL'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqLeitura)+'.pdf';
      dtRave.VplArquivoPDF := VpfNomArquivo;
      dtRave.ImprimeExtratoLocacao(VpaCodFilial,VpaSeqLeitura,false);
    finally
      dtRave.Free;
    end;
    AnexaArquivoEmail(VpfNomArquivo,VprMensagem);


    if result = '' then
    begin


    end;
    VpfDLeitura.Free;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.EnviaMedidorEmail(VpaCodFilial,VpaSeqContrato: Integer): String;
var
  VpfDContrato : TRBDContratoCorpo;
  VpfPDF, Vpfbmppart : TIdAttachmentFile;
  VpfChar : Char;
  VpfNomAnexo, VpfEmailCliente : String;
  VpfEmailHTML : TIdText;
  VpfDCliente : TRBDCliente;
begin
  result := '';
  VprMensagem.Clear;
  VpfDContrato := TRBDContratoCorpo.cria;
  CarDContrato(VpfDContrato,VpaCodFilial,VpaSeqContrato);
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := VpfDContrato.CodCliente;
  FunClientes.CarDCliente(VpfDCliente);

  if VpfDContrato.DesEmail = '' then
    result := 'CONTRATO '+IntToStr(VpaSeqContrato)+ ' DO CLIENTE "'+VpfDCliente.NomCliente+'" NÃO POSSUI E-MAIL CADASTRADO.';
  if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';
  if result = '' then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaCodFilial)+'.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'attachment';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaCodFilial)+'.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\efi.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := 'efi.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    dtRave := TdtRave.Create(nil);
    VpfNomAnexo := varia.PathVersoes+'\ANEXOS\LEITURALOCACAO'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqContrato)+'.PDF';
    dtRave.VplArquivoPDF := VpfNomAnexo ;
    dtRave.ImprimeLeituraContratos(0,0,0,0,VpaCodFilial,VpaSeqContrato,'','','','');
    dtRave.Free;

    VpfPDF := TIdAttachmentFile.Create(VprMensagem.MessageParts,VpfNomAnexo);
    VpfPDF.ContentType := 'application/pdf;LeituraContrato';
    VpfPDF.ContentDisposition := 'inline';
    VpfPDF.ExtraHeaders.Values['content-id'] := VpfNomAnexo;
    VpfPDF.DisplayName := RetornaNomeSemExtensao(VpfNomAnexo)+'.pdf';

    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    MontaEmailLeituraLocacao(VpfEmailHTML.Body,VpfDContrato,VpfDCliente);

    VpfEmailCliente := VpfDContrato.DesEmail;
    VpfChar := ',';
    if ExisteLetraString(';',VpfEmailCliente) then
      VpfChar := ';';
    while Length(VpfEmailCliente) > 0 do
    begin
      VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
      VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
    end;
    VprMensagem.Subject := Varia.NomeFilial+' - Medidores Contrato ';

    result := Sistema.EnviaEmail(VprMensagem,VprSMTP);
  end;
  VpfDCliente.Free;
  VpfDContrato.Free;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.ExcluiContrato(VpaCodfilial,VpaSeqContrato : Integer);
begin
  ExecutaComandoSql(Aux,'Delete from CONTRATOITEM '+
                        ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQCONTRATO = '+IntToStr(VpaSeqContrato));
  ExecutaComandoSql(Aux,'Delete from CONTRATOCORPO '+
                        ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQCONTRATO = '+IntToStr(VpaSeqContrato));
end;

{******************************************************************************}
procedure TRBFuncoesContrato.ExcluiLeituraLocacao(VpaCodFilial,VpaSeqLeitura : Integer);
begin
  Sistema.GravaLogExclusao('LEITURALOCACAOITEM','Select * from LEITURALOCACAOITEM '+
                        ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQLEITURA = '+IntToStr(VpaSeqLeitura));
  ExecutaComandoSql(Aux,'Delete from LEITURALOCACAOITEM '+
                        ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQLEITURA = '+IntToStr(VpaSeqLeitura));
  Sistema.GravaLogExclusao('LEITURALOCACAOCORPO','Select * from LEITURALOCACAOCORPO '+
                        ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQLEITURA = '+IntToStr(VpaSeqLeitura));
  ExecutaComandoSql(Aux,'Delete from LEITURALOCACAOCORPO '+
                        ' Where CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQLEITURA = '+IntToStr(VpaSeqLeitura));
end;

{******************************************************************************}
function TRBFuncoesContrato.ExecutaFaturamentoMensal(VpaMostrador : TProgressbar;VpaEstgio : TLabel;VpaCodTipoContrato : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaNaoFaturarReajustes :Boolean):String;
var
  VpfDContratoProcessado : TRBDContratoProcessadoCorpo;
  VpfDItemProcessado : TRBDContratoProcessadoItem;
  VpfDContrato : TRBDContratoCorpo;
  VpfDCotacao: TRBDOrcamento;
  VpfDCliente : TRBDCliente;
  VpfCodClienteAtual,VpfCodCondicaoPagamentoAtual,VpfLanOrcamentoPosterior : Integer;
begin
  LContratosAExecutar(ContratosAExecutar,VpaCodTipoContrato,VpaNaoFaturarReajustes);
  VpfDCliente := TRBDCliente.cria;

  VpfDContratoProcessado := TRBDContratoProcessadoCorpo.cria;
  InicializaDContratoProcessado(VpfDContratoProcessado);

  VpaMostrador.Max := ContratosAExecutar.RecordCount;
  VpaMostrador.Position := 0;

  VpfCodClienteAtual := -1;
  VpfCodCondicaoPagamentoAtual := -1;

  While not ContratosAExecutar.eof do
  begin
    VpfDContrato := TRBDContratoCorpo.cria;
    CarDContrato(VpfDContrato,ContratosAExecutar.FieldByName('CODFILIAL').AsInteger,ContratosAExecutar.FieldByName('SEQCONTRATO').AsInteger);
    if not MesFaturamentoContrato(VpfDContrato) then
    begin
      ContratosAExecutar.next;
      continue;
    end;

    if (VpfCodClienteAtual <> ContratosAExecutar.FieldByName('CODCLIENTE').AsInteger) or
       (VpfCodCondicaoPagamentoAtual <> ContratosAExecutar.FieldByName('CODCONDICAOPAGAMENTO').AsInteger) then
    begin
      if VpfCodClienteAtual <> -1 then
      begin
        if config.NoFaturamentoMensalProcessarFaturamentoPosterior then
        begin
          ProcessaFaturamentoPosterior(VpaMostrador,VpaEstgio,VpaDatInicio,VpaDatFim,VpfCodClienteAtual,VpfLanOrcamentoPosterior,VpfDContratoProcessado,VpaNaoFaturarReajustes,VpfDCotacao);
          // 31/03/2011
          //rotina colocada em comentario pois antigamente na reloponto tinha que gerar 2 cotacoes 1 para os contratos e outra para os crachas, isso era para fins de imposto
          // foi solicitado na reloponto que seja tudo numa cotacao só. Foi alterado a rotina Processafaturamentoposterior, adicionado um paramento VpaCotacaoContrato, que sera
          //nela adicionado os produtos de faturamento posterior, a rotina abaixo era responsavel em juntar as duas cotacoes em 1 boleto. Houve alteracao na ordem, pois antes
          // precisava primento faturar o contrato, para depois faturar o posterior e gerar 1 unico boleto, agora primeiro adiciona o faturamento posterior para depois faturar o contrato;
//          if VpfLanOrcamentoPosterior <> 0 then
  //          GeraBoletoUnicoContrato(VpfDCotacao,VpfDCliente, VpfLanOrcamentoPosterior);
        end;
        FaturaContrato(VpfDCotacao,VpfdItemProcessado, VpfDCliente,nil);
        VpfDCotacao.free;
      end;
      VpfDCliente.CodCliente := VpfDContrato.CodCliente;
      FunClientes.CarDCliente(VpfDCliente);
      VpfDCliente.IndNotaFiscal := VpfDContrato.IndNotaFiscal;
      VpfDCliente.IndRecibo := VpfDContrato.IndRecibo;

      VpfDCotacao := GeraCotacaoCorpoContrato(VpfDContrato,VpfDCliente);
      VpfCodClienteAtual := ContratosAExecutar.FieldByName('CODCLIENTE').AsInteger;
      VpfCodCondicaoPagamentoAtual := ContratosAExecutar.FieldByName('CODCONDICAOPAGAMENTO').AsInteger;
    end;
    VpaEstgio.Caption := 'Processando contrato "'+VpfDContrato.NumContrato+'" do cliente "'+VpfDCliente.NomCliente+'"';
    VpaEstgio.refresh;
    GeraServicoContrato(VpfDContrato,VpfDCotacao);
    VpfDItemProcessado := VpfDContratoProcessado.AddItem;
    VpfDItemProcessado.SeqContrato := VpfDContrato.SeqContrato;

    SetaContratoProcessado(VpfDContrato.CodFilial,VpfDContrato.SeqContrato);
    VpaMostrador.Position := VpaMostrador.Position +1;
    ContratosAExecutar.Next;
    VpfDContrato.Free;
  end;
  if VpfCodClienteAtual <> -1 then
  begin
    ProcessaFaturamentoPosterior(VpaMostrador,VpaEstgio,VpaDatInicio,VpaDatFim,VpfCodClienteAtual,VpfLanOrcamentoPosterior,VpfDContratoProcessado,VpaNaoFaturarReajustes,VpfDCotacao);
    FaturaContrato(VpfDCotacao,VpfDItemProcessado, VpfDCliente,nil);
    //31/03/2011
    //tambem foi alterado conforme comentario acima
//    if VpfLanOrcamentoPosterior <> 0 then
//      GeraBoletoUnicoContrato(VpfDCotacao,VpfDCliente,VpfLanOrcamentoPosterior);
  end;

  if VpaCodTipoContrato = 0 then
    ProcessaFaturamentoPosterior(VpaMostrador,VpaEstgio,VpaDatInicio,VpaDatFim,0,VpfLanOrcamentoPosterior,VpfDContratoProcessado,VpaNaoFaturarReajustes,nil);

  result := GravaDContratoProcessado(VpfDContratoProcessado);
  VpfDCliente.free;
  VpfDContratoProcessado.free;
  VpaEstgio.Caption := 'Contratos processados com sucesso.';
  VpaEstgio.refresh;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.InicializaLeituraContratoLocacao(VpaDContrato : TRBDContratoCorpo;VpaDLeitura : TRBDLeituraLocacaoCorpo);
var
  VpfDItemLeitura : TRBDLeituraLocacaoItem;
  VpfDContratoItem : TRBDContratoItem;
  VpfLaco : Integer;
begin
  FreeTObjectsList(VpaDLeitura.ItensLeitura);
  for VpfLaco := 0 to VpaDContrato.ItensContrato.count - 1 do
  begin
    VpfDContratoItem := TRBDContratoItem(VpaDContrato.ItensContrato.Items[Vpflaco]);
    if (VpfDContratoItem.DatDesativacao > montadata(1,1,1970)) and
       (VpfDContratoItem.QtdLeituraDesativacao = 0) then
      continue;
    VpfDItemLeitura := vpaDLeitura.addItemLeitura;
    VpfDItemLeitura.SeqItem := VpfDContratoItem.SeqItem;
    VpfDItemLeitura.SeqProduto := VpfDContratoItem.SeqProduto;
    VpfDItemLeitura.CodProduto := VpfDContratoItem.CodProduto;
    VpfDItemLeitura.NomProduto := VpfDContratoItem.NomProduto;
    VpfDItemLeitura.NumSerieProduto := VpfDContratoItem.NumSerieProduto;
    VpfDItemLeitura.NumSerieInterno := VpfDContratoItem.NumSerieInterno;
    VpfDItemLeitura.DesSetorEmpresa := VpfDContratoItem.DesSetorEmpresa;
    VpfDItemLeitura.QtdUltimaLeitura := VpfDContratoItem.QtdUltimaLeitura;
    VpfDItemLeitura.QtdUltimaLeituraColor := VpfDContratoItem.QtdUltimaLeituraColor;
    VpfDItemLeitura.DatUltimaLeitura := VpfDContratoItem.DatUltimaLeitura;
    if VpfDContratoItem.QtdLeituraDesativacao <> 0 then
    begin
      VpfDItemLeitura.QtdMedidorAtual := VpfDContratoItem.QtdLeituraDesativacao;
      VpfDItemLeitura.QtdMedidorAtualColor := VpfDContratoItem.QtdLeituraDesativacaoColor;
      VpfDItemLeitura.QtdTotalCopias := (VpfDItemLeitura.QtdMedidorAtual - VpfDItemLeitura.QtdUltimaLeitura);
      VpfDItemLeitura.QtdTotalCopiasColor :=(VpfDItemLeitura.QtdMedidorAtualColor - VpfDItemLeitura.QtdUltimaLeituraColor) ;
      VpfDItemLeitura.IndDesativar := true;
    end
    else
      VpfDItemLeitura.IndDesativar := false;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.ProcessaContratoLocacao(VpaDLeitura : TRBDLeituraLocacaoCorpo;VpaBarraStatus : TStatusBar):string;
var
  VpfDCliente : TRBDCliente;
  VpfDContrato : TRBDContratoCorpo;
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
  VprBarraStatus := VpaBarraStatus;
  VpfDContrato := TRBDContratoCorpo.cria;
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := VpaDLeitura.CodCliente;
  AtualizaStatus('Carregando os dados do cliente');
  FunClientes.CarDCliente(VpfDCliente);
  AtualizaStatus('Carregando os dados do contrato');
  CarDContrato(VpfDContrato,VpaDLeitura.CodFilial,VpaDLeitura.SeqContrato);
  VpfDCliente.IndNotaFiscal := VpfDContrato.IndNotaFiscal;

  AtualizaStatus('Gerando a cotação');
  VpfDCotacao := GeraCotacaoCorpoLocacao(VpaDLeitura,VpfDContrato,VpfDCliente);
  AtualizaStatus('Faturando contrato');
  FaturaContrato(VpfDCotacao,nil,VpfDCliente,VpaDLeitura);

  VpaDLeitura.LanOrcamento := VpfDCotacao.LanOrcamento;
  VpaDLeitura.DatProcessamento := now;
  AtualizaStatus('Gravando os dados da leitura da locação');
  result := GravaDLeituraLocacao(VpaDLeitura);
  if result = '' then
  begin
    VpfDContrato.DatUltimaExecucao := VpaDLeitura.DatProcessamento;
    AtualizaStatus('Gravando os dados do contrato');
    result := gravadcontrato(VpfDContrato);
    if result = '' then
    begin
      AtualizaStatus('Atualizando os medidos');
      result := AtualizaMedidoresContrato(VpaDLeitura);
      AtualizaStatus('Imprimindo boleto');
      ImprimirBoleto(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento,VpfDCotacao.CodCliente);
    end;
  end;

  if Result = '' then
  begin
    if (config.FaturarLocacaoComRecibo) and VpfDCliente.IndNotaFiscal then
    begin
      dtRave := TdtRave.create(nil);
      dtRave.ImprimeReciboLocacao(VpaDLeitura.CodFilial,VprSeqRecibo,false, false,0,0);
      dtRave.Free;
    end;
  end;

  AtualizaStatus('Locação processada com sucesso.');
  VpfDCotacao.free;
  VpfdContrato.free;
  VpfdCliente.free;
end;

{******************************************************************************}
function TRBFuncoesContrato.ExisteContratoLocacaoEmAberto(VpaCodFilial,VpaSeqContrato : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from LEITURALOCACAOCORPO '+
                            ' Where CODFILIAL = '+ IntToStr(VpaCodfilial)+
                            ' and SEQCONTRATO = '+IntToStr(VpaSeqContrato)+
                            ' and DATPROCESSAMENTO IS NULL');
  result := not Aux.Eof;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesContrato.ExisteServico(VpaCodServico: String;
  VpaDContrato: TRBDContratoCorpo; VpaDServico: TRBDContratoServico): Boolean;
begin
    result := false;
  if VpaCodServico <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select (Moe.N_Vlr_dia * Pre.N_Vlr_Ven) Valor, SER.C_NOM_SER, SER.I_COD_SER, N_PER_ISS,  '+
                           ' SER.I_COD_FIS, SER.C_COD_CLA '+
                           ' from cadservico Ser, MovTabelaPrecoServico Pre, CadMoedas Moe ' +
                           ' where Ser.I_Cod_ser = ' + VpaCodServico +
                           ' and Pre.I_Cod_ser = Ser.I_Cod_Ser ' +
                           ' and Pre.i_cod_emp = ' + IntToStr(varia.codigoEmpresa) +
                           ' and Pre.I_Cod_tab = '+ IntToStr(Varia.TabelaPrecoServico)+
                           ' and Moe.I_cod_Moe = Pre.I_Cod_Moe');
    result := not Tabela.Eof;
    if result then
    begin
      with VpaDServico do
      begin
        NomServico := Tabela.FieldByName('C_NOM_SER').AsString;
        CodServico := Tabela.FieldByName('I_COD_SER').AsInteger;
        QtdServico := 1;
        ValUnitario := Tabela.FieldByName('Valor').AsFloat;
        PerISSQN := Tabela.FieldByName('N_PER_ISS').AsFloat;
        CodClassificacao := Tabela.FieldByName('C_COD_CLA').AsString;
        CodFiscal := Tabela.FieldByName('I_COD_FIS').AsInteger;
      end;
    end;
    Tabela.Close;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesContrato.SetaContratoAReprocessar(VpaCodfilial,VpaSeqContrato, VpaTipPerido : Integer;VpaDataUltimaExecucao : TDateTime);
var
  VpfNovaData : Tdatetime;
begin
    case VpaTipPerido of
      0 : VpfNovaData := DecMes(VpaDataUltimaExecucao,1);
      1 : VpfNovaData := DecMes(VpaDataUltimaExecucao,2);
      2 : VpfNovaData := DecMes(VpaDataUltimaExecucao,3);
      3 : VpfNovaData := DecMes(VpaDataUltimaExecucao,6);
      4 : VpfNovaData := DecMes(VpaDataUltimaExecucao,12);
    end;
    ExecutaComandoSql(Aux,'update CONTRATOCORPO CON '+
                        ' SET DATULTIMAEXECUCAO = '+SQLTextoDataAAAAMMMDD( VpfNovaData)+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodfilial)+
                        ' and SEQCONTRATO = '+IntToStr(VpaSeqContrato));

end;

{******************************************************************************}
procedure TRBFuncoesContrato.SetaReprocessarContratos(VpaCodFilial,VpaSeqProcessado : Integer);
var
  vpfUltimoProcessamento: TDatetime;
begin
  AdicionaSQLAbreTabela(Tabela,'Select DATPROCESSADO from CONTRATOPROCESSADOCORPO '+
                               ' Where CODFILIAL = '+InttoStr(VpaCodFilial)+
                               ' and SEQPROCESSADO = ' +IntToStr(VpaSeqProcessado));
  vpfUltimoProcessamento := Tabela.FieldByName('DATPROCESSADO').AsDateTime;
  AdicionaSQLAbreTabela(Tabela,'select CON.CODFILIAL, CON.SEQCONTRATO, CON.DATULTIMAEXECUCAO, CON.TIPPERIODO '+
                               ' from CONTRATOPROCESSADOITEM COR, CONTRATOCORPO CON '+
                               ' where COR.CODFILIAL = CON.CODFILIAL '+
                               ' AND COR.SEQCONTRATO = CON.SEQCONTRATO'+
                               ' AND COR.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND COR.SEQPROCESSADO = '+IntToStr(VpaSeqProcessado));
  While not Tabela.Eof do
  begin
    SetaContratoAReprocessar(Tabela.FieldByName('CODFILIAL').AsInteger, Tabela.FieldByName('SEQCONTRATO').AsInteger,Tabela.FieldByName('TIPPERIODO').AsInteger,vpfUltimoProcessamento);
    Tabela.next;
  end;
end;

{******************************************************************************}
function TRBFuncoesContrato.ReajustaContrato(VpaAno, VpaMes: Integer; VpaIndice: Double): String;
begin
  Result:= '';
  ExecutaComandoSql(Tabela,'UPDATE CONTRATOCORPO'+
                           ' SET VALCONTRATO = VALCONTRATO + ((VALCONTRATO *'+SubstituiStr(FloatToStr(VpaIndice),',','.')+')/100),'+
                           ' VALEXCESSOFRANQUIA = VALEXCESSOFRANQUIA + ((VALEXCESSOFRANQUIA *'+SubstituiStr(FloatToStr(VpaIndice),',','.')+')/100)'+
                           ' WHERE '+SQLTextoMes('DATASSINATURA')+' = '+IntToStr(VpaMes));
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM REAJUSTECONTRATOCORPO '+
                                 ' Where SEQREAJUSTE = 0');
  Cadastro.Insert;
  Cadastro.FieldByName('MESREAJUSTE').AsInteger:= VpaMes;
  Cadastro.FieldByName('ANOREAJUSTE').AsInteger:= VpaAno;
  Cadastro.FieldByName('INDICEREAJUSTE').AsFloat:= VpaIndice;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= Varia.CodigoUsuario;
  Cadastro.FieldByName('DATREAJUSTE').AsDateTime:= Now;
  Cadastro.FieldByName('SEQREAJUSTE').AsInteger:= RSeqReajusteDisponivel;
  Cadastro.Post;
  Result:= Cadastro.AMensagemErroGravacao;
  if result = '' then
    Result:= VincularReajusteContratos(Cadastro.FieldByName('SEQREAJUSTE').AsInteger, VpaAno, VpaMes);
  Cadastro.Close;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.RNomTipoContrato(VpaCodTipoContrato: Integer): String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select NOMTIPOCONTRATO ' +
                               ' FROM TIPOCONTRATO ' +
                               ' Where CODTIPOCONTRATO = ' +IntToStr(VpaCodTipoContrato));
  result := Tabela.FieldByName('NOMTIPOCONTRATO').AsString;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.RSeqReajusteDisponivel: Integer;
begin
  AdicionaSqlAbreTabela(Aux,'SELECT MAX(SEQREAJUSTE) ULTIMO FROM REAJUSTECONTRATOCORPO');
  Result:= Aux.FieldByName('ULTIMO').AsInteger+1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.RSeqReciboDisponivel(VpaCodFilial: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(SEQRECIBO) ULTIMO from RECIBOLOCACAOCORPO ' +
                            ' Where CODFILIAL = ' +IntToStr(VpaCodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesContrato.VincularReajusteContratos(VpaSeqReajuste, VpaAno, VpaMes: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM CONTRATOCORPO'+
                               ' WHERE '+SQLTextoMes('DATASSINATURA')+' = '+IntToStr(VpaMes));
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM REAJUSTECONTRATOITEM '+
                                 ' Where SEQREAJUSTE = 0');
  while not Tabela.Eof do
  begin
    Cadastro.Insert;
    Cadastro.FieldByName('SEQREAJUSTE').AsInteger:= VpaSeqReajuste;
    Cadastro.FieldByName('CODFILIALCONTRATO').AsInteger:= Tabela.FieldByName('CODFILIAL').AsInteger;
    Cadastro.FieldByName('SEQCONTRATO').AsInteger:= Tabela.FieldByName('SEQCONTRATO').AsInteger;
    Cadastro.FieldByName('VALCONTRATO').AsFloat:= Tabela.FieldByName('VALCONTRATO').AsFloat;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Result <> '' then
      Tabela.Last
    else
      Tabela.Next;
  end;
  Tabela.Close;
  Cadastro.Close;
end;

end.

