unit UnECF;
{Verificado
-.edit;
}
interface

Uses Classes, DbTables, SysUtils, ComCtrls,db, UnDaruma, forms, StdCtrls,controls, Dialogs,
     SQLExpr, Tabela, UnDadosProduto,ACBrECF, ACBrDevice, UnDados, ACBrECFClass, SHDocVw, Windows,
     ActiveX, MSHTML, ACBrPAF, ACBRSintegra, unSistema, IniFiles, ACBrTEFD, ACBrTEFDClass, UnDadosCR;

type
  TRBLocalizaECF = class
    public
      procedure LocalizaECF(VpaTabela : TDataSet;VpaCodFilial,VpaSeqNota : Integer);overload;
      procedure LocalizaECF(VpaTabela : TDataSet; VpaCodFilial,VpaNroNota : Integer;VpaNumSerie : String);overload;
end;



Type
  TGenerateEAD  = function (cNomeArquivo : AnsiString; cChavePublica:AnsiString; CChavePrivada: AnsiString; cEAD : AnsiString; iSign : Integer) : integer; stdcall;

  TRBFuncoesECF = class(TRBLocalizaECF)
      Aux,
      Tabela,
      Tabela2 : TSQLQuery;
      Cadastro : TSQL;
      VprErro : Integer;
      VprStatusBar : TStatusBar;
      ACBRECF :  TACBrECF;
      ACBRPAF : TACBrPAF;
      ACBRSintegra : TACBrSintegra;
      ACBRTEFD : TACBrTEFD;
      VprNumSerieECF : String;
      VprWebBrose : TWebBrowser;
      procedure VerificaECF(VpaMostrarMensagemRequerZ : boolean = true);
      procedure MostraMensagemErro(VpaOperacaoExecutada : String);
      procedure AtualizaBarraStatus(VpaTexto : String);
      function RSeqNotaDisponivel(VpaCodfilial : Integer) : Integer;
      function RNumLojaECF : Integer;
      function RNumCaixa : Integer;
      function RDataMovimentoReducaoZ(VpaReducaoZ : TStringList):TDateTime;
      function RetornaValorCampo(VpaArquivo: TStringList; VpaNomCampo: string): string;
      function RValorNaoFiscalECF(VpaNumSerie : String;VpaDatMovimento : TDateTime):Double;
      function RCodNacionalFabricanteECF(VpaNUmSerie :String) : integer;
      procedure AlteraValorCampo(VpaArquivo:TStringList;VpaCampo, VpaNovoValor :string);
      function AbreCupom(VpaDCliente : TRBDCliente) : Boolean;
      procedure ExtornaEstoqueUltimoCupom;
      procedure ExtornaEstoqueCupomCancelado(VpaCadNota,VpaMovNota : TDataSet);
      procedure ExtornaEstoqueFiscalCupomCancelado(VpaMovNota : TDataSet);
      function CupomAPartirdaCotacao(VpaCodFilial,VpaSeqNota : Integer):Boolean;
      procedure MsgAguarde(const VpaMensagem : string);
      procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
      procedure WB_ScrollToBottom(WebBrowser1: TWebBrowser);
      procedure BobinaAdicionarLinha(const VpaLinhas, VpaOperacao: String);
      function MovimentoPorECFCarRegistroR1(VpaDFiltro : TRBDFiltroMenuFiscalECF):string;
      function MovimentoPorECFCarRegistroR2(VpaDFiltro : TRBDFiltroMenuFiscalECF):string;
      function MovimentoPorECFCarRegistroR4(VpaDFiltro : TRBDFiltroMenuFiscalECF):string;
      function MovimentoPorECFCarRegistroR6(VpaDFiltro : TRBDFiltroMenuFiscalECF):string;
      function VendasPorPeriodoSintegraRegistro10(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro11(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro60m(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro60A(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro60D(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro60I(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro60R(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro61(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro61R(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      function VendasPorPeriodoSintegraRegistro75(VpaDFiltro : TRBDFiltroMenuFiscalECF) : string;
      procedure TabelaProdutoRegistroP1;
      procedure TabelaProdutoRegistroP2;
      procedure EstoqueRegistroE1;
      procedure EstoqueREgistroE2;
      procedure GeraARquivoDAVEmitidosRegistroD1;
      procedure GeraArquivoDAVEmitidos(VpaTabela : TSQLQuery);
      procedure ImprimeDAVEmitidos(VpaTabela : TSQLQuery);
      procedure GravaArqLeituraMemoriaFiscal(VpaDFiltro: TRBDFiltroMenuFiscalECF;VpaSimplificada : Boolean);
      function SalvaDadosReducaoZ : string;
      function SalvaDadosReducaoZAliquotas(VpaNumSerie : String;VpaNumReducaoZ :Integer):string;
      procedure CalculaEAD(VpaNomArquivo : String);
      function CarAliquotaProduto(VpaPerAliquota : Double;VpaIndProduto,VpaIndSubstituicaoTributaria : Boolean;Var VpaAliquota : Ansistring;Var VpaTotalizardorParcial :string ) : string;
      procedure CarECFAutorizados(VpaListaECFS : TStringList);
      function RNumLaudo :string;
      procedure TEFComandaECF(VpaOperacao: TACBrTEFDOperacaoECF; VpaResposta : TACBrTEFDResp; var RetornoECF: Integer);
      procedure TEFAbreVinculado(VpaCOO, VpaIndiceECF: String; VpaValor: Double; var VpaRetornoECF: Integer);
      procedure TEFImprimeVia(VpaTipoRelatorio: TACBrTEFDTipoRelatorio; VpaVia: Integer;VpaImagemComprovante: TStringList; var VpaRetornoECF: Integer);
      procedure TEFPagamento(VpaIndiceECF: String;VpaValor: Double; var VpaRetornoECF: Integer);
      procedure TEFDepoisCancelarTransacoes(VpaRespostasPendentes: TACBrTEFDRespostasPendentes);
      procedure TEFDepoisConfirmarTransacoes(VpaRespostasPendentes: TACBrTEFDRespostasPendentes);
      procedure TEFInfoECF(VpaOperacao: TACBrTEFDInfoECF;var VpaRetornoECF: String);
      procedure TEFExibeMsg(VpaOperacao: TACBrTEFDOperacaoMensagem;VpaMensagem: String; var VpaAModalResult: TModalResult);
      procedure DAVOSEmitidos;
      procedure AdicionaItemIndiceTecnico(VpaArquivo : TStringList;VpaSeqProduto: Integer);
    public
      constructor cria(VpaStatusBar : TStatusBar;VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      function ExisteCupomAberto : Boolean;
      function RNumECF : Integer;
      function RNumCOO : Integer;
      function RNumGRG : Integer;
      function RNumSerieECF : String;
      function RNumeroUltimoItemVendido : Integer;
      function RTextoVencimentos(VpaCodFilial,VpaSeqNota : Integer):TStringList;
      function RTextoVencimentoCotacao(VpaCodFilial,VpaLanOrcamento : Integer):TStringList;
      function RAliquotas : String;
      function RValComissao(VpaValTotal, VpaPerComissao, VpaPerComissaoPreposto : Double;VpaTipComissao, VpaCodVendedor : Integer;VpaProdutos : TDataSet):Double;
      function RIndiceFormaPagamento(VpaNomFormaPagamento : String) :string;
      procedure AnalisaBarraStatus;
      function CadastraECF(VpaTabela : TSQL;VpaCodCondicaoPagamento : Integer;VpaDCliente : TRBDCliente) : string;
      function VendeItem(VpaCodProduto,VpaNomProduto,VpaUM : AnsiString;VpaQtdProduto, VpaValUnitario,VpaPerDesconto,VpaPerICMS : Double;VpaIndSubstituicaoTributaria,VpaIndDesconto,VpaIndPercentual, VpaIndProduto  : Boolean;var VpaTotalizadorParcial : string):String;
      procedure CancelaCupom(VpaCadNota, VpaMovNota : TDataSet;VpaExtornarEstoque : Boolean);
      procedure CancelaCupomAberto;
      procedure CancelaUltimoCupom;
      function AbreRelatorioGerencial : string;
      function AbreCupomFiscalVinculado(VpaCOO, VpaIndiceECF: String; VpaValor: Double; var VpaRetornoECF: Integer) : string;
      function CancelaItem(VpaCodFilial,VpaSeqNota,VpaSeqItem, VpaNumItemECF : Integer):Boolean;
      function IniciaFechamento(VpaDescontoAcrescimo : double) : String;
      procedure FormaPagamentoCupom(VpaDesFormaPagamento, VpaDesCondicaoPagamento : String;VpaValor : Double);
      procedure FinalizaCupom(VpaTexto : TStringlist);
      procedure AdicionaAliquotaICMS(VpaAliquota : Double);
      function FechacomTEF(VpaValorTotal :Double;VpaDFormaPagamento : TRBDFormaPagamento) : string;
      procedure LeituraX;
      procedure ReducaoZ;
      procedure AbreGaveta;
      procedure AssociaBobina(VpaMemo: TMemo;VpaBrowse: TWebBrowser);
      procedure LeituraLMF(VpaDFiltro : TRBDFiltroMenuFiscalECF;VpaSimplificada : Boolean);
      procedure EspelhoMFD(VpaDFiltro : TRBDFiltroMenuFiscalECF);
      procedure ArquivoMFD(VpaDFiltro : TRBDFiltroMenuFiscalECF);
      procedure MovimentoporECF(VpaDFiltro : TRBDFiltroMenuFiscalECF);
      procedure VendasPorPeriodoSintegra(VpaDFiltro : TRBDFiltroMenuFiscalECF);
      procedure TabelaProdutos;
      procedure Estoque;
      procedure MeiosPagamento(VpaDFiltro : TRBDFiltroMenuFiscalECF);
      procedure DAVEmitidos(VpaDFiltro : TRBDFiltroMenuFiscalECF);
      procedure IndiceTecnicoProducao;
      procedure IdentificacaoPAFECF;
      procedure CadastraMaquinaECF;
      procedure CarNumerosECF(VpaLista : TStrings);
      procedure Sangria(VpaValor : Double;VpaMotivo : String);
      procedure Suprimento(VpaValor : Double;VpaMotivo : String);
      function GravaDComprovanteNaoFiscal(VpaNumSerieECF, VpaDesOperacao, VpaDesDenominacao : String; VpaNumCOO,VpaNumGNF : Integer;VpaValor : Double):string;
      procedure GravaMD5(VpaMD5 : string);
      function ImpressoraAtiva : Boolean;
      function NumeroSerieAutorizado : Boolean;
      procedure AtualizaGrandeTotalCriptografado;
      procedure AssinaArquivo(VpaNomArquivo : String);
end;


implementation

Uses FunSql, Constantes, UnClientes, FunString, ConstMsg, UnContasAReceber, UnProdutos,FunData, FunValida, UnCotacao, FunArquivos;

{******************************************************************************}
procedure TRBLocalizaECF.LocalizaECF(VpaTabela : TDataSet;VpaCodFilial,VpaSeqNota : Integer);
Begin
  AdicionaSqlAbreTabela(VpaTabela,'Select * from CADNOTAFISCAIS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpacodFilial)+
                                  ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNota));
end;

{******************************************************************************}
procedure TRBLocalizaECF.LocalizaECF(VpaTabela : TDataSet; VpaCodFilial,VpaNroNota : Integer;VpaNumSerie : String);
begin
  AdicionasqlAbretabela(VpaTabela,'Select * from CADNOTAFISCAIS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpacodFilial)+
                                  ' and I_NRO_NOT = '+ IntToStr(VpaNroNota)+
                                  ' and C_SER_NOT = '''+VpaNumSerie+'''');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  EVENTOS DA CLASSE DO ECF
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBFuncoesECF.cria(VpaStatusBar : TStatusBar;VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQUERY.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Tabela2 := TSQLQuery.Create(nil);
  Tabela2.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  VprStatusBar := VpaStatusBar;
  ACBRECF := TACBrECF.Create(nil);
  ACBRECF.onMsgAguarde := MsgAguarde;
  case varia.TipoECF of
    ifBematech_FI_2 : ACBRECF.Modelo := ecfBematech;
    ifSchalter : ACBRECF.Modelo := ecfSchalter;
  end;
  case varia.PortaECF of
    pcCOM1 : ACBRECF.Porta := 'COM1';
    pcCOM2 : ACBRECF.Porta := 'COM2';
    pcCOM3 : ACBRECF.Porta := 'COM3';
    pcCOM4 : ACBRECF.Porta := 'COM4';
    pcCOM5 : ACBRECF.Porta := 'COM5';
    pcCOM6 : ACBRECF.Porta := 'COM6';
  end;
  ACBRECF.OnBobinaAdicionaLinhas := BobinaAdicionarLinha;

  ACBRPAF := TACBrPAF.Create(NIL);
  if Varia.DiretorioSistema <> '' then
  begin
    ACBRPAF.Path := varia.DiretorioSistema+CT_PASTAPAF;
    NaoExisteCriaDiretorio(ACBRPAF.Path,false);
  end;
  ACBRPAF.OnPAFCalcEAD := CalculaEAD;

  ACBRSintegra := TACBrSintegra.Create(nil);
  ACBRTEFD := TACBrTEFD.Create(nil);
  ACBRTEFD.OnComandaECF := TEFComandaECF;
  ACBRTEFD.OnComandaECFAbreVinculado := TEFAbreVinculado;
  ACBRTEFD.OnComandaECFImprimeVia:= TEFImprimeVia;
  ACBRTEFD.OnComandaECFPagamento := TEFPagamento;
  ACBRTEFD.OnDepoisCancelarTransacoes := TEFDepoisCancelarTransacoes;
  ACBRTEFD.OnDepoisConfirmarTransacoes := TEFDepoisConfirmarTransacoes;
  ACBRTEFD.OnExibeMsg := TEFExibeMsg;
  ACBRTEFD.OnInfoECF := TEFInfoECF;
  ACBRTEFD.AutoFinalizarCupom := false;
  if Varia.NomeModulo = 'PDV' then
  begin
    try
      VerificaECF(false);
      VprNumSerieECF := ACBRECF.NumSerie;
      ACBRECF.Desativar;
    except
      on e : Exception do aviso(e.Message);
    end;
  end;
end;

{******************************************************************************}
destructor TRBFuncoesECF.destroy;
begin
  inherited destroy;
  Tabela.Free;
  Tabela2.Free;
  Cadastro.Free;
  Aux.Free;
  ACBRECF.Desativar;
  ACBRECF.Free;
  ACBRPAF.Free;
  ACBRSintegra.Free;
  ACBRTEFD.Free;
end;

{******************************************************************************}
function TRBFuncoesECF.RTextoVencimentos(VpaCodFilial,VpaSeqNota : Integer):TStringList;
var
  VpfLinha : String;
  VpfQtdParcelas : Integer;
begin
  VpfQtdParcelas := 0;
  VpfLinha := '';
  result := TStringList.Create;
  FunContasAReceber.LocalizaParcelasNotaFiscal(Tabela,VpaCodFilial,VpaSeqNota);
  while not Tabela.Eof do
  begin
    VpfLinha := VpfLinha +' '+FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_VEN').AsDateTime)+' '+FormatFloat('R$###,##0.00',Tabela.FieldByName('N_VLR_PAR').AsFloat);
    inc(VpfQtdParcelas);
    if VpfQtdParcelas >= 2 then
    begin
      result.add(DeletaCharE(VpfLinha,' '));
      VpfLinha := '';
      VpfQtdParcelas := 0;
    end;
    tabela.next;
  end;
  if VpfQtdParcelas > 0 then
    result.add(DeletaCharE(VpfLinha,' '));
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.RTextoVencimentoCotacao(VpaCodFilial,VpaLanOrcamento : Integer):TStringList;
var
  VpfLinha : String;
  VpfQtdParcelas : Integer;
begin
  VpfQtdParcelas := 0;
  VpfLinha := '';
  result := TStringList.Create;
  FunContasAReceber.LocalizaParcelasCotacao(Tabela,VpaCodFilial,VpaLanOrcamento);
  while not Tabela.Eof do
  begin
    VpfLinha := VpfLinha +' '+FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_VEN').AsDateTime)+' '+FormatFloat('R$###,##0.00',Tabela.FieldByName('N_VLR_PAR').AsFloat);
    inc(VpfQtdParcelas);
    if VpfQtdParcelas >= 2 then
    begin
      result.add(DeletaCharE(VpfLinha,' '));
      VpfLinha := '';
      VpfQtdParcelas := 0;
    end;
    tabela.next;
  end;
  if VpfQtdParcelas > 0 then
    result.add(DeletaCharE(VpfLinha,' '));
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.RAliquotas : String;
begin

{  result := AdicionaCharD(' ',result,79);
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_RetornoAliquotas(result);
//    ifDaruamFS600   : VprErro := Daruma_FI_RetornoAliquotas(result);
  end;}
end;

{******************************************************************************}
function TRBFuncoesECF.RCodNacionalFabricanteECF(VpaNUmSerie: String): integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_NAC FROM CADSERIENOTAS '+
                            ' Where C_SER_NOT = '''+VpaNUmSerie+'''');
  result := Aux.FieldByName('I_COD_NAC').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesECF.RDataMovimentoReducaoZ(VpaReducaoZ: TStringList): TDateTime;
var
  VpfLaco,VpfDia,VpfMes,VpfAno : Integer;
  VpfLinha : String;
begin
  result := MontaData(1,1,1900);
  for VpfLaco := 0 to VpaReducaoZ.Count - 1 do
  begin
    if (UpperCase(DeletaEspaco(CopiaAteChar(VpaReducaoZ.Strings[VpfLaco],'='))) = 'DATAMOVIMENTO')  then
    begin
      VpfLinha := DeleteAteChar(VpaReducaoZ.Strings[VpfLaco],'=');
      VpfDia := StrtoInt(CopiaAteChar(VpfLinha,'/'));
      VpfLinha := DeleteAteChar(VpfLinha,'/');
      VpfMes := StrtoInt(CopiaAteChar(VpfLinha,'/'));
      VpfLinha := DeleteAteChar(VpfLinha,'/');
      VpfAno := StrtoInt(CopiaAteChar(VpfLinha,'/'));
      result := MontaData(VpfDia,VpfMes,2000+VpfAno);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.RValComissao(VpaValTotal, VpaPerComissao,VpaPerComissaoPreposto : Double;VpaTipComissao, VpaCodVendedor : Integer;VpaProdutos : TDataSet):Double;
var
  VpfPerComissaoVendedor, VpfPerComissaoProduto, VpfPerComissaoClassificacao : Double;
begin
  result := 0;
  if VpaTipComissao = 0 then // comissao direta
    result := (VpaValTotal * (VpaPerComissao - VpaPerComissaoPreposto))/100
  else
  begin
    VpaProdutos.First;
    while not VpaProdutos.Eof do
    begin
      FunProdutos.CarPerComissoesProduto(VpaProdutos.FieldByname('I_SEQ_PRO').AsInteger,VpaCodVendedor,VpfPerComissaoProduto,VpfPerComissaoClassificacao,VpfPerComissaoVendedor);
      if VpfPerComissaoProduto <> 0 then
        Result := result + ((VpaProdutos.FieldByname('N_TOT_PRO').AsFloat* (VpfPerComissaoProduto - VpaPerComissaoPreposto))/100)
      else
        if VpfPerComissaoVendedor <> 0 then
          Result := result + ((VpaProdutos.FieldByname('N_TOT_PRO').AsFloat* (VpfPerComissaoVendedor - VpaPerComissaoPreposto))/100)
        else
          Result := result + ((VpaProdutos.FieldByname('N_TOT_PRO').AsFloat* (VpfPerComissaoClassificacao - VpaPerComissaoPreposto))/100);

      VpaProdutos.Next;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.RValorNaoFiscalECF(VpaNumSerie: String; VpaDatMovimento: TDateTime): Double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Aux,'Select SUM(VALCOMPROVANTE) TOTAL, DESOPERACAO' +
                            ' FROM COMPROVANTENAOFISCAL ' +
                            ' Where TRUNC(DATEMISSAO) = '+ SQLTextoDataAAAAMMMDD(VpaDatMovimento)+
                            ' GROUP BY DESOPERACAO');
  while not Aux.Eof do
  begin
    if Aux.FieldByName('DESOPERACAO').AsString = 'A' then
      result := result + Aux.FieldByName('TOTAL').AsFloat
    else
      result := result + Aux.FieldByName('TOTAL').AsFloat;
    aux.Next
  end;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.SalvaDadosReducaoZ : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from REDUCAOZ ' +
                                 ' Where NUMSERIEECF = '''+ACBRECF.NumSerie+''''+
                                 ' AND NUMREDUCAOZ = '+IntToStr(StrToInt(ACBRECF.NumCRZ)+1));
  if Cadastro.Eof then
    Cadastro.Insert
  else
    Cadastro.Edit;
  Cadastro.FieldByName('NUMSERIEECF').AsString := ACBRECF.NumSerie;
  Cadastro.FieldByName('NUMREDUCAOZ').AsInteger := StrToInt(ACBRECF.NumCRZ)+1;
  Cadastro.FieldByName('NUMCONTADOROPERACAO').AsInteger := StrToInt(ACBRECF.NumCOO)+1;
  Cadastro.FieldByName('NUMCONTADORREINICIOOPERACAO').AsString := ACBRECF.NumCRO;
  Cadastro.FieldByName('DATMOVIMENTO').AsDateTime := ACBRECF.DataMovimento;
  Cadastro.FieldByName('DATEMISSAO').AsDateTime := Sistema.RDataServidor;
  Cadastro.FieldByName('VALVENDABRUTADIARIA').AsFloat := ACBRECF.VendaBruta;
  Cadastro.FieldByName('VALSTICMS').AsFloat := ACBRECF.TotalSubstituicaoTributaria;
  Cadastro.FieldByName('VALISENTOICMS').AsFloat := ACBRECF.TotalIsencao;
  Cadastro.FieldByName('VALNAOTRIBUTADOICMS').AsFloat := ACBRECF.TotalNaoTributado;
  Cadastro.FieldByName('VALSTISSQN').AsFloat := ACBRECF.TotalSubstituicaoTributariaISSQN;
  Cadastro.FieldByName('VALISENTOISSQN').AsFloat := ACBRECF.TotalIsencaoISSQN;
  Cadastro.FieldByName('VALNAOTRIBUTADOISSQN').AsFloat := ACBRECF.TotalNaoTributadoISSQN;
  Cadastro.FieldByName('VALOPERACAONAOFISCAL').AsFloat := ACBRECF.TotalNaoFiscal;
  Cadastro.FieldByName('VALDESCONTOICMS').AsFloat := ACBRECF.TotalDescontos;
  Cadastro.FieldByName('VALDESCONTOISSQN').AsFloat := ACBRECF.TotalDescontosISSQN;
  Cadastro.FieldByName('VALACRESCIMOICMS').AsFloat := ACBRECF.TotalAcrescimos;
  Cadastro.FieldByName('VALACRESCIMOISSQN').AsFloat := ACBRECF.TotalAcrescimosISSQN;
  Cadastro.FieldByName('VALCANCELADOICMS').AsFloat := ACBRECF.TotalCancelamentos;
  Cadastro.FieldByName('VALCANCELADOISSQN').AsFloat := ACBRECF.TotalCancelamentosISSQN;
  Cadastro.FieldByName('VALGRANDETOTAL').AsFloat := ACBRECF.GrandeTotal;
  Cadastro.FieldByName('DESASSINATURAREGISTRO').AsString := Sistema.RAssinaturaRegistro(Cadastro);
  Cadastro.Post;
  Cadastro.Close;
  result := Cadastro.AMensagemErroGravacao;
  if result = '' then
    result := SalvaDadosReducaoZAliquotas(ACBRECF.NumSerie,StrToInt(ACBRECF.NumCRZ)+1);
end;


{******************************************************************************}
function TRBFuncoesECF.SalvaDadosReducaoZAliquotas(VpaNumSerie: String; VpaNumReducaoZ: Integer):string;
Var
  VpfLaco : Integer;
  VpfDAliquota : TACBrECFAliquota;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from REDUCAOZALIQUOTA ' +
                        ' Where NUMSERIEECF = '''+VpaNumSerie +''''+
                        ' AND NUMREDUCAOZ = '+IntToStr(VpaNumReducaoZ));
  AdicionaSQLAbreTabela(Cadastro,'Select * from REDUCAOZALIQUOTA '+
                                 ' Where NUMSERIEECF IS NULL AND NUMREDUCAOZ = 0 AND SEQINDICE = 0');

  ACBrECF.LerTotaisAliquota;
  for VpfLaco := 0 to ACBrECF.Aliquotas.Count -1 do
  begin
    VpfDAliquota := ACBrECF.Aliquotas[VpfLaco];
    Cadastro.Insert;
    Cadastro.FieldByName('NUMSERIEECF').AsString := VpaNumSerie;
    Cadastro.FieldByName('NUMREDUCAOZ').AsInteger := VpaNumReducaoZ;
    Cadastro.FieldByName('SEQINDICE').AsString := VpfDAliquota.Indice;
    Cadastro.FieldByName('DESTIPO').AsString := VpfDAliquota.Tipo;
    Cadastro.FieldByName('PERALIQUOTA').AsFloat := VpfDAliquota.Aliquota;
    Cadastro.FieldByName('VALVENDA').AsFloat := VpfDAliquota.Total;
    Cadastro.FieldByName('DESASSINATURAREGISTRO').AsString := Sistema.RAssinaturaRegistro(Cadastro);
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Result <> '' then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.Sangria(VpaValor: Double; VpaMotivo: String);
var
  VpfResultado : String;
begin
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  ACBRECF.Sangria(VpaValor,VpaMotivo);
  VpfResultado := GravaDComprovanteNaoFiscal(ACBRECF.NumSerie,'A', 'CN',StrToInt(ACBRECF.NumCOO),StrToInt(ACBRECF.NumGNF),VpaValor);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  ACBRECF.Desativar;
end;

{******************************************************************************}
procedure TRBFuncoesECF.Suprimento(VpaValor: Double; VpaMotivo: String);
var
  VpfResultado : String;
begin
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  ACBRECF.Suprimento(VpaValor,VpaMotivo);
  VpfResultado := GravaDComprovanteNaoFiscal(ACBRECF.NumSerie,'U','CN',StrToInt(ACBRECF.NumCOO),StrToInt(ACBRECF.NumGNF),VpaValor);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  ACBRECF.Desativar;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TabelaProdutoRegistroP1;
begin
  with ACBRPAF.PAF_P.RegistroP1 do
  begin
    UF := varia.CNPJFilial;
    CNPJ := LimpaMascaraCGCCPF(Varia.CNPJFilial);
    IE := LimpaMascaraCGCCPF(Varia.IEFilial);
    IM := LimpaMascaraCGCCPF(varia.InscricaoMunicipal);
    RAZAOSOCIAL := varia.RazaoSocialFilial;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TabelaProdutoRegistroP2;
var
  VpfAliquotaICMSPadrao : Double;
begin
  VpfAliquotaICMSPadrao := FunCotacao.RAliquotaICMSUF(Varia.UFFilial);
  AdicionaSQLAbreTabela(Tabela,'Select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, ' +
                               ' PRO.C_ARE_TRU, PRO.I_DES_PRO, PRO.N_RED_ICM, ' +
                               ' PRE.N_VLR_VEN ' +
                               ' FROM CADPRODUTOS PRO, MOVTABELAPRECO PRE ' +
                               ' Where PRO.I_SEQ_PRO = PRE.I_SEQ_PRO ' +
                               ' and PRE.I_COD_TAM = 0 ' +
                               ' and PRE.I_COD_COR = 0 ' +
                               ' and PRE.I_COD_CLI = 0 ' +
                               ' and PRE.I_COD_TAB = ' + IntToStr(Varia.TabelaPreco)+
                               ' and PRE.I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa));
  while not Tabela.Eof do
  begin
    with ACBRPAF.PAF_P.RegistroP2.New do
    begin
      COD_MERC_SERV := Tabela.FieldByName('C_COD_PRO').AsString;
      DESC_MERC_SERV := Tabela.FieldByName('C_NOM_PRO').AsString;
      UN_MED := Tabela.FieldByName('C_COD_UNI').AsString;
      IAT := Tabela.FieldByName('C_ARE_TRU').AsString;
      if Tabela.FieldByName('I_DES_PRO').AsInteger in [3,4,5] then
        IPPT := 'P'
      else
        IPPT := 'T';
      ST :='';
      if Tabela.FieldByName('N_RED_ICM').AsFloat > 0 then
        ALIQ := Tabela.FieldByName('N_RED_ICM').AsFloat
      else
        ALIQ := VpfAliquotaICMSPadrao;
      VL_UNIT := Tabela.FieldByName('N_VLR_VEN').AsFloat;
      //valida se algum registro foi alterado
      AdicionaSQLAbreTabela(Aux,'Select * from CADPRODUTOS ' +
                                ' Where I_SEQ_PRO = ' +Tabela.FieldByName('I_SEQ_PRO').AsString);
      if not Sistema.AssinaturaValida(Aux,Aux.FieldByName('C_ASS_REG').AsString) then
        UN_MED := AdicionaCharD('?','',6);
      AdicionaSQLAbreTabela(Aux,'Select * from MOVTABELAPRECO ' +
                                ' Where I_SEQ_PRO = ' +Tabela.FieldByName('I_SEQ_PRO').AsString +
                                ' AND I_COD_COR = 0 ' +
                                ' AND I_COD_TAM = 0 ' +
                               ' and I_COD_CLI = 0 ' +
                               ' and I_COD_TAB = ' + IntToStr(Varia.TabelaPreco)+
                               ' and I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa));
      if not Sistema.AssinaturaValida(Aux,Aux.FieldByName('C_ASS_REG').AsString) then
        UN_MED := AdicionaCharD('?','',6);


    end;
    Tabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TabelaProdutos;
Var
  VpfNomArquivo : string;
begin
  TabelaProdutoRegistroP1;
  TabelaProdutoRegistroP2;
  VpfNomArquivo := 'Paf_P.txt';
  ACBRPAF.SaveFileTXT_P(VpfNomArquivo);
  AssinaArquivo(varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);
  AVISO('Arquivo Gerado '+varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFDepoisCancelarTransacoes(VpaRespostasPendentes: TACBrTEFDRespostasPendentes);
begin
  //se nao associar essa rotina no compomente da acces violation;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFDepoisConfirmarTransacoes(VpaRespostasPendentes: TACBrTEFDRespostasPendentes);
begin
  //se nao associar essa rotina no compomente da acces violation;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFExibeMsg(VpaOperacao: TACBrTEFDOperacaoMensagem; VpaMensagem: String;var VpaAModalResult: TModalResult);
var
   Fim : TDateTime;
   OldMensagem : String;
begin
  //StatusBar1.Panels[1].Text := '' ;
  //StatusBar1.Panels[2].Text := '' ;

  case VpaOperacao of

    opmOK :
       VpaAModalResult := MessageDlg( VpaMensagem, mtInformation, [mbOK], 0);

    opmYesNo :
       VpaAModalResult := MessageDlg( VpaMensagem, mtConfirmation, [mbYes,mbNo], 0);

   // opmExibirMsgOperador, opmRemoverMsgOperador :
//         pMensagemOperador.Caption := Mensagem ;

    //opmExibirMsgCliente, opmRemoverMsgCliente :
       //  pMensagemCliente.Caption := Mensagem ;

    opmDestaqueVia :
       begin
       //  OldMensagem := pMensagemOperador.Caption ;
         try
           // pMensagemOperador.Caption := Mensagem ;
          //  pMensagemOperador.Visible := True ;
           // pMensagem.Visible         := True ;

            { Aguardando 3 segundos }
         //   Fim := IncSecond( now, 3)  ;
            repeat
               sleep(200) ;
             //  pMensagemOperador.Caption := Mensagem + ' ' + IntToStr(SecondsBetween(Fim,now));
               Application.ProcessMessages;
            until (now > Fim) ;

         finally
           // pMensagemOperador.Caption := OldMensagem ;
         end;
       end;
  end;

 // pMensagemOperador.Visible := (pMensagemOperador.Caption <> '') ;
 // pMensagemCliente.Visible  := (pMensagemCliente.Caption <> '') ;

 // pMensagem//.Visible := pMensagemOperador.Visible or pMensagemCliente.Visible;
  Application.ProcessMessages;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFInfoECF(VpaOperacao: TACBrTEFDInfoECF; var VpaRetornoECF: String);
begin
  if not ACBrECF.Ativo then
    ACBrECF.Ativar;

  case VpaOperacao of
    ineSubTotal : VpaRetornoECF := FloatToStr( ACBrECF.Subtotal-ACBrECF.TotalPago ) ;
    ineEstadoECF :
    begin
      Case ACBrECF.Estado of
        estLivre     : VpaRetornoECF := 'L' ;
        estVenda     : VpaRetornoECF := 'V' ;
        estPagamento : VpaRetornoECF := 'P' ;
        estRelatorio : VpaRetornoECF := 'R' ;
      else
        VpaRetornoECF := 'O' ;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFPagamento(VpaIndiceECF: String; VpaValor: Double; var VpaRetornoECF: Integer);
begin
  //se nao associar essa rotina no compomente da acces violation;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AssinaArquivo(VpaNomArquivo: String);
var
  VpfregEAD :AnsiString;
  generateEAD : TGenerateEAD;
  LibHandle : THandle;
begin
  // carrega a dll dinamicamente;
  LibHandle :=  LoadLibrary (PChar (Trim ('sign_bema.dll')));
  // verifica se existe a dll
  if  LibHandle <=  HINSTANCE_ERROR then
    raise Exception.Create ('Dll  de assinatura do arquivo - "sign_bema.dll" - não carregada');

  @generateEAD  :=  GetProcAddress (LibHandle,'generateEAD');
  if  @generateEAD  = nil then
    raise Exception.Create('Funcao de assinatura digital do arquivo não encontrado na Dll "sign_bema.dll"');

  SetLength(VpfregEAD,256);
  generateEAD(VpaNomArquivo,CT_CHAVEPUBLICA,CT_CHAVEPRIVADA,VpfregEAD,1);
  FreeLibrary (LibHandle);
end;

{******************************************************************************}
procedure TRBFuncoesECF.AssociaBobina(VpaMemo: TMemo;VpaBrowse: TWebBrowser);
begin
  VprWebBrose := VpaBrowse;
  ACBRECF.MemoBobina := VpaMemo;
  ACBrECF.MemoParams.Values['HTML'] := '1' ;
end;

{******************************************************************************}
function TRBFuncoesECF.RSeqNotaDisponivel(VpaCodfilial : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select max(I_SEQ_NOT) ULTIMO from CADNOTAFISCAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.RNumECF : Integer;
Begin
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;

  if ACBRECF.NumCCF <> '' then
    result := strToInt(ACBRECF.NumCCF)
  else
    result := strToInt(ACBRECF.NumCOO);
end;

{******************************************************************************}
function TRBFuncoesECF.RNumSerieECF : String;
begin
  if Varia.NomeModulo = 'PDV' then
    result := VprNumSerieECF
  else
    result := ACBRECF.NumSerie;
end;

{******************************************************************************}
function TRBFuncoesECF.RNumeroUltimoItemVendido : Integer;
begin
  result := ACBRECF.NumUltItem;
  AtualizaBarraStatus('último item vendido recuperado.');
  MostraMensagemErro('RECUPERANDO O NUMERO DO ULTIMO ITEM VENDIDO!!!');
end;

{******************************************************************************}
function TRBFuncoesECF.RNumGRG: Integer;
begin
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  if ACBRECF.NumGRG <> '' then
    result := strToInt(ACBRECF.NumGRG)
  else
    result := 0;
end;

{******************************************************************************}
function TRBFuncoesECF.RNumLaudo: string;
var
  VpfArquivo : TStringList;
begin
  VpfArquivo := TStringList.Create;
  VpfArquivo.LoadFromFile(varia.DiretorioSistema+'\INFOPAF.INI');
  VpfArquivo.Text := Descriptografa(VpfArquivo.Text);
  RESULT := RetornaValorCampo(VpfArquivo,'LAUDO');
  VpfArquivo.Free;
end;

{******************************************************************************}
function TRBFuncoesECF.RNumLojaECF : Integer;
begin
  result := StrtoInt(ACBRECF.NumLoja);
end;

{******************************************************************************}
function TRBFuncoesECF.RNumCaixa : Integer;
var
  VpfNumero : String;
begin
{  VpfNumero := AdicionaCharD(' ','',4);
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro :=  Bematech_FI_NumeroCaixa(VpfNumero);
//    ifDaruamFS600   : VprErro := Daruma_FI_NumeroCaixa(VpfNumero);
  end;
  result := StrToInt(VpfNumero);
  MostraMensagemErro('CAPTURA DO NUMERO DO CAIXA!!!');}
end;

{******************************************************************************}
function TRBFuncoesECF.RNumCOO: Integer;
begin
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  result := strToInt(ACBRECF.NumCOO);
end;

{******************************************************************************}
procedure TRBFuncoesECF.MostraMensagemErro(VpaOperacaoExecutada : String);
Var
  VpfErro : String;
begin
  AnalisaBarraStatus;
end;

{******************************************************************************}
procedure TRBFuncoesECF.MovimentoporECF(VpaDFiltro: TRBDFiltroMenuFiscalECF);
Var
  VpfNomArquivo : string;
begin
  MovimentoPorECFCarRegistroR1(VpaDFiltro);
  MovimentoPorECFCarRegistroR2(VpaDFiltro);
  MovimentoPorECFCarRegistroR4(VpaDFiltro);
  MovimentoPorECFCarRegistroR6(VpaDFiltro);
  VpfNomArquivo:= AdicionaCharE('0',IntToStr(RCodNacionalFabricanteECF(VpaDFiltro.NumSerieECF)),6)+AdicionaCharD('0',Copy(VpaDFiltro.NumSerieECF,length(VpaDFiltro.NumSerieECF)-14,14),14)+FormatDateTime('DDMMYYYY',VpaDFiltro.DatInicio)+'.TXT';
  ACBrPAF.SaveFileTXT_R(VpfNomArquivo);
  AssinaArquivo(varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);
  AVISO('Arquivo Gerado '+varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);
end;

{******************************************************************************}
function TRBFuncoesECF.MovimentoPorECFCarRegistroR1(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfDFilial : TRBDFilial;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADSERIENOTAS ' +
                               ' Where C_SER_NOT = '''+VpaDFiltro.NumSerieECF+'''');
  VpaDFiltro.NumUsuario := Tabela.FieldByName('I_NUM_USU').AsInteger;
  with ACBRPAF.PAF_R.RegistroR01 do
  begin
    NUM_FAB := VpaDFiltro.NumSerieECF;
    MF_ADICIONAL:= '';
    TIPO_ECF := Tabela.FieldByName('C_TIP_ECF').AsString;
    MARCA_ECF := Tabela.FieldByName('C_MAR_ECF').AsString;
    MODELO_ECF := Tabela.FieldByName('C_MOD_ECF').AsString;
    VERSAO_SB := Tabela.FieldByName('C_VER_SFB').AsString;
    DT_INST_SB := Tabela.FieldByName('D_DAT_SFB').AsDateTime;
    HR_INST_SB := Tabela.FieldByName('D_DAT_SFB').AsDateTime;
    NUM_SEQ_ECF := Tabela.FieldByName('I_NUM_ECF').AsInteger;
    if not SISTEMA.AssinaturaValida(Tabela,Tabela.FieldByName('C_ASS_REG').AsString) then
      RegistroValido := false;

    VpfDFilial := TRBDFilial.cria;
    Sistema.CarDFilial(VpfDFilial,Tabela.FieldByName('I_EMP_FIL').AsInteger);
    CNPJ :=LimpaMascaraCGCCPF(VpfDFilial.DesCNPJ);
    IE := LimpaMascaraCGCCPF(VpfDFilial.DesInscricaoEstadual);
    CNPJ_SH := '04216817000152';
    IE_SH := '';
    IM_SH := '';
    NOME_SH := 'EFICACIA SISTEMAS E CONSULTORIA LTDA';
    NOME_PAF := 'EFIPDV';
    VER_PAF :='1.00';
    COD_MD5 := '';
    DT_INI := VpaDFiltro.DatInicio;
    DT_FIN := VpaDFiltro.DatFim;
    ER_PAF_ECF := CT_ERPAFECF;
    VpfDFilial.Free;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.MovimentoPorECFCarRegistroR2(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfR2Valido : Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from REDUCAOZ ' +
                               ' Where '+SQLTextoDataEntreAAAAMMDD('trunc(DATMOVIMENTO)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,false)+
                               ' and NUMSERIEECF = '''+VpaDFiltro.NumSerieECF+''''+
                               ' order by DATMOVIMENTO');
  while not Tabela.Eof do
  begin
    with  ACBRPAF.PAF_R.RegistroR02.new do
    begin
      NUM_USU := VpaDFiltro.NumUsuario;
      CRZ := Tabela.FieldByName('NUMREDUCAOZ').AsInteger;
      COO := Tabela.FieldByName('NUMCONTADOROPERACAO').AsInteger;
      CRO := Tabela.FieldByName('NUMCONTADORREINICIOOPERACAO').AsInteger;
      DT_MOV := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      DT_EMI := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      HR_EMI := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      VL_VBD := Tabela.FieldByName('VALVENDABRUTADIARIA').AsFloat;
      PAR_ECF := Tabela.FieldByName('INDDESCONTOISSQN').AsString;
      RegistroValido := Sistema.AssinaturaValida(Tabela,Tabela.FieldByName('DESASSINATURAREGISTRO').AsString);
      VpfR2Valido := RegistroValido;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'F1';
        VL_ACUM := Tabela.FieldByName('VALSTICMS').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'I1';
        VL_ACUM := Tabela.FieldByName('VALISENTOICMS').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'N1';
        VL_ACUM := Tabela.FieldByName('VALNAOTRIBUTADOICMS').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'FS1';
        VL_ACUM := Tabela.FieldByName('VALSTISSQN').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'Is1';
        VL_ACUM := Tabela.FieldByName('VALISENTOISSQN').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'NS1';
        VL_ACUM := Tabela.FieldByName('VALNAOTRIBUTADOISSQN').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'OPNF';
        VL_ACUM := Tabela.FieldByName('VALOPERACAONAOFISCAL').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'DT';
        VL_ACUM := Tabela.FieldByName('VALDESCONTOICMS').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'DS';
        VL_ACUM := Tabela.FieldByName('VALDESCONTOISSQN').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'AT';
        VL_ACUM := Tabela.FieldByName('VALACRESCIMOICMS').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'AS';
        VL_ACUM := Tabela.FieldByName('VALACRESCIMOISSQN').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'Can-T';
        VL_ACUM := Tabela.FieldByName('VALCANCELADOICMS').AsFloat;
      end;
      with RegistroR03.New do
      begin
        RegistroValido := VpfR2Valido;
        TOT_PARCIAL := 'Can-S';
        VL_ACUM := Tabela.FieldByName('VALCANCELADOISSQN').AsFloat;
      end;
      AdicionaSQLAbreTabela(Tabela2,'Select * from REDUCAOZALIQUOTA ' +
                                    ' Where NUMSERIEECF = '''+Tabela.FieldByName('NUMSERIEECF').AsString+''''+
                                    ' and  NUMREDUCAOZ = ' +Tabela.FieldByName('NUMREDUCAOZ').AsString+
                                    ' order by SEQINDICE');
      while not Tabela2.Eof do
      begin
        with RegistroR03.New do
        begin
          TOT_PARCIAL := FormatFloat('00',Tabela2.FieldByName('SEQINDICE').AsInteger)+DeletaEspaco(Tabela2.FieldByName('DESTIPO').AsString)+DeletaChars(FormatFloat('00.00',Tabela2.FieldByName('PERALIQUOTA').AsFloat),',');
          VL_ACUM := Tabela2.FieldByName('VALVENDA').AsFloat;
          RegistroValido := VpfR2Valido and Sistema.AssinaturaValida(Tabela2,Tabela2.FieldByName('DESASSINATURAREGISTRO').AsString);
        end;
        Tabela2.Next;
      end;

    end;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.MovimentoPorECFCarRegistroR4(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
Var
  VpfR4Valido : Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,'Select NOTA.I_EMP_FIL, NOTA.I_SEQ_NOT, NOTA.I_NRO_NOT, NOTA.I_NUM_COO, NOTA.D_DAT_EMI, NOTA.N_TOT_PRO, NOTA.N_TOT_SER, ' +
                               ' NOTA.N_PER_DES, NOTA.N_VLR_DES, NOTA.N_TOT_NOT, NOTA.C_NOT_CAN, NOTA.I_COD_CLI, NOTA.I_COD_FRM, ' +
                               ' CLI.C_NOM_CLI, CLI.C_TIP_PES, CLI.C_CPF_CLI, CLI.C_CGC_CLI ' +
                               ' FROM CADNOTAFISCAIS NOTA, CADCLIENTES CLI ' +
                               ' Where ' +SQLTextoDataEntreAAAAMMDD('trunc(NOTA.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,false)+
                               ' and NOTA.C_SER_NOT = '''+VpaDFiltro.NumSerieECF+''''+
                               ' AND NOTA.I_COD_CLI = CLI.I_COD_CLI '+
                               ' ORDER BY NOTA.I_NRO_NOT');
  while not Tabela.Eof do
  begin
    with ACBRPAF.PAF_R.RegistroR04.New do
    begin
      NUM_USU := VpaDFiltro.NumUsuario;
      NUM_CONT := Tabela.FieldByName('I_NRO_NOT').AsInteger;
      COO := Tabela.FieldByName('I_NUM_COO').AsInteger;
      DT_INI := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
      SUB_DOCTO := Tabela.FieldByName('N_TOT_PRO').AsFloat + Tabela.FieldByName('N_TOT_SER').AsFloat;
      //carrega o desconto acrescimo
      if Tabela.FieldByName('N_PER_DES').AsFloat <> 0 then
      begin
        if Tabela.FieldByName('N_PER_DES').AsFloat > 0 then
        begin
          SUB_DESCTO := Tabela.FieldByName('N_PER_DES').AsFloat;
          TP_DESCTO := 'P';
          ORDEM_DA := 'D';
        end
        else
          if Tabela.FieldByName('N_PER_DES').AsFloat < 0 then
          begin
            SUB_ACRES := Tabela.FieldByName('N_PER_DES').AsFloat *-1;
            TP_ACRES := 'P';
            ORDEM_DA := 'A';
          end;
      end
      else
        if Tabela.FieldByName('N_VLR_DES').AsFloat <> 0 then
        begin
          if Tabela.FieldByName('N_VLR_DES').AsFloat > 0 then
          begin
            SUB_DESCTO := Tabela.FieldByName('N_VLR_DES').AsFloat;
            TP_DESCTO := 'V';
            ORDEM_DA := 'D';
          end
          else
            if Tabela.FieldByName('N_VLR_DES').AsFloat < 0 then
            begin
              SUB_ACRES := Tabela.FieldByName('N_VLR_DES').AsFloat *(-1);
              TP_ACRES := 'V';
              ORDEM_DA := 'A';
          end;
        end;
      VL_TOT := Tabela.FieldByName('N_TOT_NOT').AsFloat;
      CANC := Tabela.FieldByName('C_NOT_CAN').AsString;

      NOME_CLI := Tabela.FieldByName('C_NOM_CLI').AsString;
      if Tabela.FieldByName('C_TIP_PES').AsString = 'F' then
        CNPJ_CPF := LimpaMascaraCGCCPF(Tabela.FieldByName('C_CPF_CLI').AsString)
      else
        CNPJ_CPF := LimpaMascaraCGCCPF(Tabela.FieldByName('C_CGC_CLI').AsString);

      AdicionaSQLAbreTabela(Aux,'Select * from  CADNOTAFISCAIS ' +
                                ' Where I_EMP_FIL = ' +Tabela.FieldByName('I_EMP_FIL').AsString +
                                ' and I_SEQ_NOT = ' + Tabela.FieldByName('I_SEQ_NOT').AsString);
      RegistroValido := Sistema.AssinaturaValida(Aux,Aux.FieldByName('C_ASS_REG').AsString);
      VpfR4Valido := RegistroValido;
      Aux.Close;

      //Registro R5
      AdicionaSQLAbreTabela(Tabela2,'Select MOV.I_EMP_FIL, MOV.I_SEQ_NOT, MOV.I_SEQ_MOV, '+
                                    ' MOV.I_NUM_ITE, MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, ' +
                                    ' MOV.N_PER_DES, MOV.N_TOT_PRO, MOV.C_IND_CAN, MOV.C_TPA_ECF,'+
                                    ' PRO.C_NOM_PRO, C_ARE_TRU, PRO.I_DES_PRO ' +
                                    'FROM MOVNOTASFISCAIS MOV, CADPRODUTOS PRO ' +
                                    ' Where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                                    ' AND MOV.I_EMP_FIL = ' +Tabela.FieldByName('I_EMP_FIL').AsString +
                                    ' AND MOV.I_SEQ_NOT = '+Tabela.FieldByName('I_SEQ_NOT').AsString+
                                    ' ORDER BY MOV.I_SEQ_MOV');
      while not Tabela2.Eof do
      begin
        with RegistroR05.New do
        begin
          NUM_ITEM := Tabela2.FieldByName('I_NUM_ITE').AsInteger;
          COD_ITEM := Tabela2.FieldByName('C_COD_PRO').AsString;
          DESC_ITEM := Tabela2.FieldByName('C_NOM_PRO').AsString;
          QTDE_ITEM := Tabela2.FieldByName('N_QTD_PRO').AsFloat;
          UN_MED := Tabela2.FieldByName('C_COD_UNI').AsString;
          VL_UNIT := Tabela2.FieldByName('N_VLR_PRO').AsFloat;
          DESCTO_ITEM := Tabela2.FieldByName('N_PER_DES').AsFloat;
          VL_TOT_ITEM := Tabela2.FieldByName('N_TOT_PRO').AsFloat;
          IND_CANC := Tabela2.FieldByName('C_IND_CAN').AsString;
          QTDE_CANC := 0;
          VL_CANC := 0;
          VL_CANC_ACRES := 0;
          IAT := Tabela2.FieldByName('C_ARE_TRU').AsString;
          if Tabela2.FieldByName('I_DES_PRO').AsInteger IN [3,4,5] then
            IPPT := 'P'
          else
            IPPT := 'T';
          COD_TOT_PARC := Tabela2.FieldByName('C_TPA_ECF').AsString;
          QTDE_DECIMAL := Varia.DecimaisQtd;
          VL_DECIMAL := Varia.Decimais;

          AdicionaSQLAbreTabela(Aux,'Select * from  MOVNOTASFISCAIS ' +
                                    ' Where I_EMP_FIL = ' +Tabela2.FieldByName('I_EMP_FIL').AsString +
                                    ' and I_SEQ_NOT = ' + Tabela2.FieldByName('I_SEQ_NOT').AsString+
                                    ' AND I_SEQ_MOV = ' +Tabela2.FieldByName('I_SEQ_MOV').AsString);
          RegistroValido := VpfR4Valido and Sistema.AssinaturaValida(Aux,Aux.FieldByName('C_ASS_REG').AsString);
          Aux.Close;
        end;
        Tabela2.Next;
      end;

      //registro r7
      with RegistroR07.New do
      begin
        CCF := Tabela.FieldByName('I_NRO_NOT').AsInteger;
        MP := FunContasAReceber.RNomFormaPagamento(Tabela.FieldByName('I_COD_FRM').AsInteger);
        VL_PAGTO := Tabela.FieldByName('N_TOT_NOT').AsFloat;
        IND_EST := 'N';
        VL_EST := 0;
        RegistroValido := VpfR4Valido;
      end;
    end;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.MovimentoPorECFCarRegistroR6(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from COMPROVANTENAOFISCAL '+
                               ' Where NUMSERIEECF = '''+VpaDFiltro.NumSerieECF+''''+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(DATEMISSAO)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' order by DATEMISSAO');
  while not Tabela.Eof do
  begin
    with ACBRPAF.PAF_R.RegistroR06.New do
    begin
      NUM_USU := VpaDFiltro.NumUsuario;
      COO := Tabela.FieldByName('NUMCOO').AsInteger;
      GNF := Tabela.FieldByName('NUMGNF').AsInteger;
      DENOM := Tabela.FieldByName('DESDENOMINACAO').AsString;
      DT_FIN := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      HR_FIN := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      RegistroValido := Sistema.AssinaturaValida(Tabela,Tabela.FieldByName('DESASSINATURAREGISTRO').AsString);
      with RegistroR07.New do
      begin
        GNF := Tabela.FieldByName('NUMGNF').AsInteger;
        if Tabela.FieldByName('DESOPERACAO').AsString = 'A' then
          MP := 'SANGRIA'
        else
          if Tabela.FieldByName('DESOPERACAO').AsString = 'U' then
            MP := 'SUPRIMENTO';
        VL_PAGTO := Tabela.FieldByName('VALCOMPROVANTE').AsFloat;
        IND_EST := 'N';
        VL_EST :=0;
        RegistroValido := Sistema.AssinaturaValida(Tabela,Tabela.FieldByName('DESASSINATURAREGISTRO').AsString);
      end;
    end;
    Tabela.Next
  end;
  AdicionaSQLAbreTabela(Tabela,'Select * from RELATORIOGERENCIALECF '+
                               ' Where NUMSERIEECF = '''+VpaDFiltro.NumSerieECF+''''+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(DATEMISSAO)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' order by DATEMISSAO');
  while not Tabela.Eof do
  begin
    with ACBRPAF.PAF_R.RegistroR06.New do
    begin
      NUM_USU := VpaDFiltro.NumUsuario;
      COO := Tabela.FieldByName('NUMCOO').AsInteger;
      GNF := Tabela.FieldByName('NUMGNF').AsInteger;
      GRG := Tabela.FieldByName('NUMGRG').AsInteger;
      DENOM := 'RG';
      DT_FIN := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      HR_FIN := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      RegistroValido := Sistema.AssinaturaValida(Tabela,Tabela.FieldByName('DESASSINATURAREGISTRO').AsString);
    end;
    Tabela.Next
  end;

  AdicionaSQLAbreTabela(Tabela,'Select * from DOCUMENTOVINCULADOECF '+
                               ' Where NUMSERIEECF = '''+VpaDFiltro.NumSerieECF+''''+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(DATEMISSAO)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' order by DATEMISSAO');
  while not Tabela.Eof do
  begin
    with ACBRPAF.PAF_R.RegistroR06.New do
    begin
      NUM_USU := VpaDFiltro.NumUsuario;
      COO := Tabela.FieldByName('NUMCOO').AsInteger;
      CDC := Tabela.FieldByName('NUMCDC').AsInteger;
      DENOM := 'CC';
      DT_FIN := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      HR_FIN := Tabela.FieldByName('DATEMISSAO').AsDateTime;
      RegistroValido := Sistema.AssinaturaValida(Tabela,Tabela.FieldByName('DESASSINATURAREGISTRO').AsString);
    end;
    Tabela.Next
  end;

end;

{******************************************************************************}
procedure TRBFuncoesECF.MsgAguarde(Const VpaMensagem: string);
begin
  if VprStatusBar <> nil then
  begin
    VprStatusBar.Panels[0].Text := VpaMensagem;
    VprStatusBar.Refresh;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.NumeroSerieAutorizado: Boolean;
var
  VpfSerie : string;
  VpfArquivo : TstringList;
  VpfGrandeTotalArquivo : Double;
begin
  result := true;
  try
    VerificaECF;
    VpfSerie := RNumSerieECF;
    VpfArquivo := TStringList.Create;
    VpfArquivo.LoadFromFile(varia.DiretorioSistema+'\'+VpfSerie +'.txt');
    VpfGrandeTotalArquivo := strtofloat(Descriptografa(VpfArquivo.Strings[0]));
    if VpfGrandeTotalArquivo <> ACBRECF.GrandeTotal then
    begin
      result := false;
      aviso('IMPRESSORA FISCAL NÃO AUTORIZADA PARA ESSE COMPUTADOR(GRANDE TOTAL)!!!'#13'A impressora ECF não está autorizada para ser utilizada nesse computador.');
    end;
  except
    on e : exception do
    begin
      aviso('IMPRESSORA FISCAL NÃO AUTORIZADA PARA ESSE COMPUTADOR!!!'#13'A impressora ECF não está autorizada para ser utilizada nesse computador.'#13+e.Message);
      result := false;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AtualizaBarraStatus(VpaTexto : String);
begin
  if VprStatusBar <> nil then
  begin
    VprStatusBar.Panels[2].Text := VpaTexto;
    VprStatusBar.Refresh;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AtualizaGrandeTotalCriptografado;
var
  VpfSerie : string;
  VpfArquivo : TstringList;
  VpfGrandeTotalArquivo : Double;
begin
  VpfSerie := RNumSerieECF;
  VpfArquivo := TStringList.Create;
  VpfArquivo.Add(Criptografa(FloatToStr(ACBRECF.GrandeTotal)));
  VpfArquivo.SaveToFile(varia.DiretorioSistema+'\'+VpfSerie +'.txt');
end;

{******************************************************************************}
procedure TRBFuncoesECF.BobinaAdicionarLinha(const VpaLinhas, VpaOperacao: String);
begin
  if VprWebBrose <> nil then
  begin
    WB_LoadHTML(VprWebBrose, ACBRECF.MemoBobina.Text);
    Application.ProcessMessages ;

    WB_ScrollToBottom(VprWebBrose);
  end;
end;


{******************************************************************************}
procedure TRBFuncoesECF.EspelhoMFD(VpaDFiltro: TRBDFiltroMenuFiscalECF);
var
  VpfNomArquivo :AnsiString;
begin
  VerificaECF;
  VpfNomArquivo := varia.DiretorioSistema +CT_PASTAPAF+'EspelhoMFD.txt';
  if VpaDFiltro.TipFiltro = tfPeriodo then
    ACBRECF.EspelhoMFD_DLL(VpaDFiltro.DatInicio,VpaDFiltro.DatFim,VpfNomArquivo)
  else
    ACBRECF.EspelhoMFD_DLL(VpaDFiltro.NumIntervaloCOOInicio,VpaDFiltro.NumIntervaloCOOFim,VpfNomArquivo);

  AssinaArquivo(VpfNomArquivo);
  aviso(VpfNomArquivo);
end;

{******************************************************************************}
procedure TRBFuncoesECF.Estoque;
Var
  VpfNomArquivo : string;
begin
  EstoqueRegistroE1;
  EstoqueRegistroE2;

  VpfNomArquivo := 'Paf_E.txt';
  ACBRPAF.SaveFileTXT_E(VpfNomArquivo);
  AssinaArquivo(varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);
  AVISO('Arquivo Gerado '+varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);

end;

{******************************************************************************}
procedure TRBFuncoesECF.EstoqueRegistroE1;
begin
  with ACBRPAF.PAF_E.RegistroE1 do
  begin
    UF := varia.CNPJFilial;
    CNPJ := LimpaMascaraCGCCPF(Varia.CNPJFilial);
    IE := LimpaMascaraCGCCPF(Varia.IEFilial);
    IM := LimpaMascaraCGCCPF(varia.InscricaoMunicipal);
    RAZAOSOCIAL := varia.RazaoSocialFilial;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.EstoqueREgistroE2;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.I_SEQ_PRO,  ' +
                               ' QTD.N_QTD_PRO, QTD.I_EMP_FIL ' +
                               ' FROM CADPRODUTOS PRO, MOVQDADEPRODUTO QTD ' +
                               ' Where PRO.I_SEQ_PRO = QTD.I_SEQ_PRO ' +
                               ' AND QTD.I_COD_COR = 0 ' +
                               ' AND QTD.I_COD_TAM = 0 ' +
                               ' AND QTD.I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil));
  while not Tabela.Eof do
  begin
    with ACBRPAF.PAF_E.RegistroE2.New do
    begin
      COD_MERC := Tabela.FieldByName('C_COD_PRO').AsString;
      DESC_MERC := Tabela.FieldByName('C_NOM_PRO').AsString;
      UN_MED := Tabela.FieldByName('C_COD_UNI').AsString;
      if Tabela.FieldByName('N_QTD_PRO').AsFloat >= 0 then
        QTDE_EST := Tabela.FieldByName('N_QTD_PRO').AsFloat
      else
        QTDE_EST := 0;
      DT_EST := date;
      AdicionaSQLAbreTabela(Aux,'Select * from CADPRODUTOS ' +
                                ' Where I_SEQ_PRO = ' +Tabela.FieldByName('I_SEQ_PRO').AsString);
      if not Sistema.AssinaturaValida(Aux,Aux.FieldByName('C_ASS_REG').AsString) then
        UN_MED := AdicionaCharD('?','',6);
      AdicionaSQLAbreTabela(Aux,'Select * from MOVQDADEPRODUTO ' +
                                ' Where I_SEQ_PRO = ' +Tabela.FieldByName('I_SEQ_PRO').AsString +
                                ' AND I_EMP_FIL = '+Tabela.FieldByName('I_EMP_FIL').AsString+
                                ' AND I_COD_COR = 0 ' +
                                ' AND I_COD_TAM = 0 ');
      if not Sistema.AssinaturaValida(Aux,Aux.FieldByName('C_ASS_REG').AsString) then
        UN_MED := AdicionaCharD('?','',6);
    end;
    Tabela.Next;
  end;
  tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.ExisteCupomAberto : Boolean;
begin
  VerificaECF;
  result := (ACBRECF.Estado = estVenda) or (ACBRECF.Estado = estPagamento);
  MostraMensagemErro('VERIFICANDO SE EXISTE CUPOM ABERTO!!!');
  ACBRECF.Desativar;
end;

{******************************************************************************}
function TRBFuncoesECF.AbreCupom(VpaDCliente : TRBDCliente) : Boolean;
begin
  result := true;
  if ACBRECF.PoucoPapel then
  begin
    aviso('IMPRESSORA COM POUCO PAPEL!!!'#13'Troque a bobina de papel do cupom fiscal antes de continuar.');
    result := false;
  end;
  if result then
  begin
    ACBRECF.IdentificaConsumidor(VpaDCliente.CGC_CPF,VpaDCliente.NomCliente,VpaDCliente.DesEndereco);
    ACBRECF.AbreCupom(VpaDCliente.CGC_CPF,VpaDCliente.NomCliente,VpaDCliente.DesEndereco);
    MostraMensagemErro('ABERTURA DE CUPOM!!!');
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ExtornaEstoqueUltimoCupom;
var
  VpfNumNota : Integer;
  VpfSerNota : String;
begin
  VpfNumNota := RNumECF;
  VpfSerNota := RNumSerieECF;
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADNOTAFISCAIS '+
                               ' Where I_NRO_NOT = '+IntToStr(VpfNumNota));
  while not Cadastro.eof and (Cadastro.FieldByName('C_SER_NOT').AsString <> VpfSerNota) do
    Cadastro.Next;

  if not Cadastro.eof then
  begin
    if Cadastro.FieldByName('C_NOT_CAN').AsString = 'S' then
      aviso('CUPOM JÁ SE ENCONTRA CANCELADO!!!'#13'O último cupom já se encontra cancelado.')
    else
      if Cadastro.FieldByName('I_EMP_FIL').AsInteger <> varia.CodigoEmpFil then
        aviso('FILIAL INVÁLIDA!!!'#13'Não foi possivel cancelar o cupom, pois o mesmo não foi gerado na filial ativa.')
      else
      begin
        AdicionaSQLAbreTabela(Tabela,'Select * from MOVNOTASFISCAIS '+
                                         ' Where I_EMP_FIL = '+ Cadastro.FieldByName('I_EMP_FIL').AsString+
                                         ' and I_SEQ_NOT = '+Cadastro.FieldByName('I_SEQ_NOT').AsString);
        if not CupomAPartirdaCotacao(Cadastro.FieldByName('I_EMP_FIL').AsInteger,Cadastro.FieldByName('I_SEQ_NOT').AsInteger) then
          ExtornaEstoqueCupomCancelado(Cadastro,Tabela);

        ExtornaEstoqueFiscalCupomCancelado(Tabela);

        Cadastro.Edit;
        Cadastro.FieldByName('C_NOT_CAN').AsString := 'S';
        Cadastro.post;
        Tabela.Close;
      end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ExtornaEstoqueCupomCancelado(VpaCadNota,VpaMovNota : TDataSet);
var
  VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  VpaMovNota.First;
  while not VpaMovNota.Eof do
  begin
    VpfDProduto := TRBDProduto.cria;
    FunProdutos.CarDProduto(VpfDProduto,0,VpaCadNota.FieldByname('I_EMP_FIL').AsInteger, VpaMovNota.FieldByName('I_SEQ_PRO').AsInteger);
    FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaCadNota.FieldByname('I_EMP_FIL').AsInteger, Varia.OperacaoEstoqueEstornoEntrada,VpaCadNota.FieldByName('I_SEQ_NOT').AsInteger,
                                  VpaCadNota.FieldByName('I_NRO_NOT').AsInteger,0,varia.MoedaBase,0,0,date,VpaMovNota.FieldByName('N_QTD_PRO').AsFloat,VpaMovNota.FieldByName('N_TOT_PRO').AsFloat,
                                  VpaMovNota.FieldByName('C_COD_UNI').AsString,VpaMovNota.FieldByName('C_PRO_REF').AsString,false,VpfSeqEstoqueBarra,true);
    VpfDProduto.free;
    VpaMovNota.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ExtornaEstoqueFiscalCupomCancelado(VpaMovNota : TDataSet);
begin
  VpaMovNota.First;
  while not VpaMovNota.Eof do
  begin
    FunProdutos.BaixaEstoqueFiscal(Varia.CodigoEmpfil, VpaMovNota.FieldByName('I_SEQ_PRO').AsInteger,0,0,VpaMovNota.FieldByName('N_QTD_PRO').AsFloat,
                                  VpaMovNota.FieldByName('C_COD_UNI').AsString,FunProdutos.UnidadePadrao(VpaMovNota.FieldByName('I_SEQ_PRO').AsInteger),'E');

    VpaMovNota.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.CupomAPartirdaCotacao(VpaCodFilial,VpaSeqNota : Integer):Boolean;
begin
  AdicionaSqlAbreTabela(Aux,'Select * from MOVNOTAORCAMENTO '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_SEQ_NOT = '+IntToStr(VpaSeqNota));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.DAVEmitidos(VpaDFiltro: TRBDFiltroMenuFiscalECF);
begin
  AdicionaSQLAbreTabela(Tabela,'Select ORC.I_EMP_FIL, ORC.I_LAN_ORC, ORC.I_NUM_COO, ORC.N_VLR_LIQ, ORC.D_DAT_ORC,' +
                               ' TIP.C_NOM_TIP ' +
                               ' FROM CADORCAMENTOS ORC, CADTIPOORCAMENTO TIP ' +
                               ' Where ORC.I_TIP_ORC = TIP.I_COD_TIP ' +
                               SQLTextoDataEntreAAAAMMDD('ORC.D_DAT_ORC',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true));
  if VpaDFiltro.IndGerarArquivo then
    GeraArquivoDAVEmitidos(Tabela)
  else
    ImprimeDAVEmitidos(Tabela);
end;

{******************************************************************************}
procedure TRBFuncoesECF.DAVOSEmitidos;
var
  VpfDFiltro : TRBDFiltroMenuFiscalECF;
begin
  if ACBRECF.Estado = estLivre then
  begin
    if Varia.TipoCotacaoChamado <> 0 then
    begin
      VpfDFiltro := TRBDFiltroMenuFiscalECF.cria;
      VpfDFiltro.NumSerieECF := ACBRECF.NumSerie;
      VpfDFiltro.DatInicio := ACBRECF.DataMovimento;
      VpfDFiltro.DatFim := VpfDFiltro.DatInicio;
      DAVEmitidos(VpfDFiltro);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.CadastraECF(VpaTabela : TSQL; VpaCodCondicaoPagamento : Integer;VpaDCliente : TRBDCliente):string;
begin
  result := '';
  ACBRECF.MemoBobina.Clear;
  if not NumeroSerieAutorizado then
    result := 'IMPRESSORA FISCAL NÃO AUTORIZADA PARA ESSE COMPUTADOR(GRANDE TOTAL)!!!'#13'A impressora ECF não está autorizada para ser utilizada nesse computador.';
  if result = '' then
  begin
    AtualizaBarraStatus('Verificando se já existe cupom aberto.');
    if ExisteCupomAberto then
    begin
      ACBRECF.Ativar;
      AtualizaBarraStatus('Localizando o cupom fiscal no BD.');
      LocalizaECF(VpaTabela,Varia.CodigoEmpFil,RNumECF,RNumSerieECF);
      if VpaTabela.Eof then
      begin
        CancelaCupomAberto;
      end
      else
      begin
        AtualizaBarraStatus('Editando a tabela do cupom fical.');
        VpaTabela.Edit;
        AtualizaBarraStatus('Cupom fiscal aberto com sucesso.');
      end;
    end
    else
    begin
      ACBRECF.Ativar;
      AtualizaBarraStatus('Abrindo Cupom Fiscal.');
      if AbreCupom(VpaDCliente) then
      begin
        AtualizaBarraStatus('Localizando o cupom fiscal no BD');
        LocalizaECF(VpaTabela,0,0);
        AtualizaBarraStatus('Inserindo registro na tabela do cupom fiscal');
        VpaTabela.Insert;
        VpaTabela.FieldByName('I_EMP_FIL').AsInteger := Varia.CodigoEmpfil;
        AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando o seq nota');
        VpaTabela.FieldByName('I_SEQ_NOT').AsInteger := RSeqNotaDisponivel(Varia.CodigoEmpfil);
        AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando numero do ecf');
        VpaTabela.FieldByName('I_NRO_NOT').AsInteger := RNumECF;
        AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando numero do coo');
        VpaTabela.FieldByName('I_NUM_COO').AsInteger := RNumCOO;
        AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando numero do CRZ');
        VpaTabela.FieldByName('I_NUM_CRZ').AsInteger := StrToInt(ACBRECF.NumCRZ)+1;
        AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando o numero de serie');
        VpaTabela.FieldByName('C_SER_NOT').AsString := RNumSerieECF;
        AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal carregando demais dados');
        VpaTabela.FieldByName('I_COD_CLI').AsInteger := VpaDCliente.CodCliente;
        VpaTabela.FieldByName('I_COD_PAG').AsInteger := VpaCodCondicaoPagamento;
        VpaTabela.FieldByName('D_DAT_EMI').AsDatetime := ACBRECF.DataHora;
        VpaTabela.FieldByName('D_DAT_SAI').AsDateTime := VpaTabela.FieldByName('D_DAT_EMI').AsDatetime;
        VpaTabela.FieldByName('T_HOR_SAI').AsDateTime := VpaTabela.FieldByName('D_DAT_EMI').AsDatetime;
        VpaTabela.FieldByName('C_FLA_ECF').AsString := 'S';
        VpaTabela.FieldByName('C_VEN_CON').AsString := 'N';
        VpaTabela.FieldByName('C_NOT_IMP').AsString := 'N';
        VpaTabela.FieldByName('C_NOT_CAN').AsString := 'N';
        VpaTabela.FieldByName('C_NOT_DEV').AsString := 'N';
        VpaTabela.FieldByName('D_ULT_ALT').AsDatetime := Date;
        VpaTabela.FieldByName('C_FIN_GER').AsString := 'S';
        VpaTabela.FieldByName('I_COD_USU').AsInteger := varia.CodigoUsuario;
        if varia.TipoBancoDados = bdRepresentante then
          VpaTabela.FieldByName('C_FLA_EXP').AsString := 'N'
        else
          VpaTabela.FieldByName('C_FLA_EXP').AsString := 'S';
        AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal');
        VpaTabela.Post;
        result := VpaTabela.AMensagemErroGravacao;
        if result = '' then
        begin
          AtualizaBarraStatus('Editando a tabela do cupom fical.');
          Vpatabela.Edit;
          AtualizaBarraStatus('Cupom fiscal aberto com sucesso.');
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.CadastraMaquinaECF;
var
  VpfNumSerie : String;
begin
  VpfNumSerie := RNumSerieECF;
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADSERIENOTAS ' +
                                 ' Where C_SER_NOT = '''+VpfNumSerie+'''');
  if Cadastro.Eof then
  begin
    Cadastro.Insert;
    Cadastro.FieldByName('C_SER_NOT').AsString := VpfNumSerie;
  end
  else
    Cadastro.Edit;
  Cadastro.FieldByName('C_TIP_ECF').AsString := 'ECF-IF';
  Cadastro.FieldByName('C_MAR_ECF').AsString := ACBRECF.ModeloStr;
  Cadastro.FieldByName('C_MOD_ECF').AsString := ACBRECF.SubModeloECF;
  Cadastro.FieldByName('C_VER_SFB').AsString := ACBRECF.NumVersao;
  Cadastro.FieldByName('D_DAT_SFB').AsDateTime := ACBRECF.DataHoraSB;
  Cadastro.FieldByName('I_NUM_ECF').AsString := ACBRECF.NumECF;
  Cadastro.FieldByName('C_NOM_SFH').AsString := 'EFICACIA SIST E CONSULTORIA LTDA';
  Cadastro.FieldByName('C_CNP_SFH').AsString := '04.216.817/0001-52';
  Cadastro.FieldByName('C_END_SFH').AsString := 'RUA LONDRINA, 333 - VELHA - BLUMENAU';
  Cadastro.FieldByName('C_FON_SFH').AsString := '(47) 3035-5604';
  Cadastro.FieldByName('C_CON_SFH').AsString := 'RAFAEL BUDAG';
  Cadastro.FieldByName('C_NOM_COM').AsString := 'EFIPONTO DE VENDA';
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  Cadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(Cadastro);
  Cadastro.Post;
  Sistema.MarcaTabelaParaImportar('CADSERIENOTAS');

end;

procedure TRBFuncoesECF.CalculaEAD(VpaNomArquivo: String);
begin
  VpaNomArquivo := ''
end;

{******************************************************************************}
procedure TRBFuncoesECF.VendasPorPeriodoSintegra(VpaDFiltro: TRBDFiltroMenuFiscalECF);
begin
  VendasPorPeriodoSintegraRegistro10(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro11(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro60m(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro60A(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro60D(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro60I(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro60R(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro61(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro61R(VpaDFiltro);
  VendasPorPeriodoSintegraRegistro75(VpaDFiltro);


  ACBRSintegra.FileName := Varia.DiretorioSistema+CT_PASTAPAF+RNumLaudo+FormatDateTime('DDMMYYYYHHMMSS',now)+'.txt';
  ACBRSintegra.GeraArquivo;
  AssinaArquivo(ACBRSintegra.FileName);
  aviso('arquivo "'+ACBRSintegra.FileName +'"gerado com sucesso');
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro10(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
begin
  with ACBRSintegra.Registro10 do
  begin
    CNPJ := LimpaMascaraCGCCPF(Varia.CNPJFilial);
    Inscricao := LimpaMascaraCGCCPF(Varia.IEFilial);
    RazaoSocial := Varia.RazaoSocialFilial;
    Cidade := Varia.CidadeFilial;
    Estado := Varia.UFFilial;
    Telefone :=DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(Varia.FoneFilial,'*'),'('),')'),'-'),'0');
    DataInicial := VpaDFiltro.DatInicio;
    DataFinal := VpaDFiltro.DatFim;
    CodigoConvenio  := '3';
    NaturezaInformacoes := '3'; //3-totalidade das operacoes do informante
    FinalidadeArquivo := '1' ; // 1-normal
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro11(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
begin
  with ACBRSintegra.Registro11 do
  begin
    Endereco :=  varia.EnderecoFilialSemNumero;
    Numero := Varia.NumEnderecoFilial;
    Complemento := '';
    Bairro := varia.BairroFilial;
    Cep := Varia.CepFilial;
    Responsavel := VariA.NomeResponsavelLegal;
    Telefone := DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(Varia.FoneFilial,'*'),'('),')'),'-'),'0');
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro60A(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfDRegistro60A : TRegistro60A;
begin
  AdicionaSQLAbreTabela(Tabela,'select RED.NUMSERIEECF, RED.NUMREDUCAOZ, RED.DATMOVIMENTO, ' +
                               ' REA.SEQINDICE, REA.DESTIPO, REA.PERALIQUOTA, REA.VALVENDA '+
                               ' from REDUCAOZ RED, REDUCAOZALIQUOTA REA '+
                               ' Where RED.NUMSERIEECF = REA.NUMSERIEECF ' +
                               ' AND RED.NUMREDUCAOZ = REA.NUMREDUCAOZ ' +
                               SQLTextoDataEntreAAAAMMDD('TRUNC(DATMOVIMENTO)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' AND REA.DESTIPO = ''T'''+
                               ' ORDER BY RED.DATMOVIMENTO');
  while not Tabela.Eof do
  begin
    VpfDRegistro60A := TRegistro60A.Create;
    if Tabela.FieldByName('VALVENDA').AsFloat <> 0 then
    begin
      VpfDRegistro60A := TRegistro60A.Create;
      VpfDRegistro60A.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      VpfDRegistro60A.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
      VpfDRegistro60A.StAliquota := DeletaChars(FormatFloat('00.00',Tabela.FieldByName('PERALIQUOTA').AsFloat),'.');
      VpfDRegistro60A.Valor := Tabela.FieldByName('VALVENDA').AsFloat;
      ACBRSintegra.Registros60A.Add(VpfDRegistro60A);
    end;
    Tabela.Next;
  end;
  Tabela.Close;
  //aliquota de issqn
  AdicionaSQLAbreTabela(Tabela,'select RED.NUMSERIEECF, RED.NUMREDUCAOZ, RED.DATMOVIMENTO, ' +
                               ' REA.SEQINDICE, REA.DESTIPO, REA.PERALIQUOTA, REA.VALVENDA '+
                               ' from REDUCAOZ RED, REDUCAOZALIQUOTA REA '+
                               ' Where RED.NUMSERIEECF = REA.NUMSERIEECF ' +
                               ' AND RED.NUMREDUCAOZ = REA.NUMREDUCAOZ ' +
                               SQLTextoDataEntreAAAAMMDD('TRUNC(DATMOVIMENTO)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' AND REA.DESTIPO = ''S'''+
                               ' ORDER BY RED.DATMOVIMENTO');
  while not Tabela.Eof do
  begin
    VpfDRegistro60A := TRegistro60A.Create;
    if Tabela.FieldByName('VALVENDA').AsFloat <> 0 then
    begin
      VpfDRegistro60A := TRegistro60A.Create;
      VpfDRegistro60A.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      VpfDRegistro60A.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
      VpfDRegistro60A.StAliquota := 'ISS';
      VpfDRegistro60A.Valor := Tabela.FieldByName('VALVENDA').AsFloat;
      ACBRSintegra.Registros60A.Add(VpfDRegistro60A);
    end;
    Tabela.Next;
  end;
  Tabela.Close;

end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro60D(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfDRegistro60D :TRegistro60D;
begin
  AdicionaSQLAbreTabela(Tabela,'select TRUNC(CAD.D_DAT_EMI) D_DAT_EMI, C_SER_NOT,  SUM(MOV.N_QTD_PRO) QTD, SUM(MOV.N_TOT_PRO) VALOR, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_SIT_TRI, '+
                               ' MOV.N_PER_ICM '+
                               ' from MOVNOTASFISCAIS MOV, CADNOTAFISCAIS CAD, CADPRODUTOS PRO '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' AND CAD.C_FLA_ECF = ''S'''+
                               ' AND CAD.C_NOT_CAN = ''N'''+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' GROUP BY CAD.C_SER_NOT, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_SIT_TRI, TRUNC(CAD.D_DAT_EMI), MOV.N_PER_ICM'+
                               ' ORDER BY 1');
  while not Tabela.Eof do
  begin
    VpfDRegistro60D := TRegistro60D.Create;
    VpfDRegistro60D.Emissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDRegistro60D.NumSerie := Tabela.FieldByName('C_SER_NOT').AsString;
    VpfDRegistro60D.Codigo := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDRegistro60D.Quantidade := Tabela.FieldByName('QTD').AsFloat;
    VpfDRegistro60D.Valor := Tabela.FieldByName('VALOR').AsFloat;
    VpfDRegistro60D.BaseDeCalculo := Tabela.FieldByName('VALOR').AsFloat;
    if Tabela.FieldByName('C_SIT_TRI').AsString = 'T' then
    begin
      VpfDRegistro60D.StAliquota := DeletaChars(FormatFloat('00.00',Tabela.FieldByName('N_PER_ICM').AsFloat),',');
      VpfDRegistro60D.ValorIcms :=(Tabela.FieldByName('N_PER_ICM').AsFloat/100)* Tabela.FieldByName('VALOR').AsFloat;
    end
    else
      VpfDRegistro60D.StAliquota := Tabela.FieldByName('C_SIT_TRI').AsString;

    ACBRSintegra.Registros60D.Add(VpfDRegistro60D);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro60I(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
Var
  VpfDRegistro60I :TRegistro60I;
begin
  AdicionaSQLAbreTabela(Tabela,'select  CAD.C_SER_NOT, TRUNC(CAD.D_DAT_EMI)D_DAT_EMI, CAD.I_NRO_NOT, '+
                               ' MOV.N_QTD_PRO, MOV.N_TOT_PRO,  MOV.N_PER_ICM, MOV.I_NUM_ITE, '+
                               ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_SIT_TRI '+
                               ' from MOVNOTASFISCAIS MOV, CADNOTAFISCAIS CAD, CADPRODUTOS PRO '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' AND CAD.C_FLA_ECF = ''S'''+
                               ' AND CAD.C_NOT_CAN = ''N'''+
                                SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                               ' ORDER BY CAD.I_SEQ_NOT');
  while not Tabela.Eof do
  begin
    VpfDRegistro60I := TRegistro60I.Create;
    VpfDRegistro60I.Emissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDRegistro60I.NumSerie := Tabela.FieldByName('C_SER_NOT').AsString;
    VpfDRegistro60I.ModeloDoc := '2D';
    VpfDRegistro60I.Cupom := Tabela.FieldByName('I_NRO_NOT').AsString;
    VpfDRegistro60I.Item := Tabela.FieldByName('I_NUM_ITE').AsInteger;
    VpfDRegistro60I.Codigo := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDRegistro60I.Quantidade := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDRegistro60I.Valor := Tabela.FieldByName('N_TOT_PRO').AsFloat;
    VpfDRegistro60I.BaseDeCalculo := Tabela.FieldByName('N_TOT_PRO').AsFloat;
    if Tabela.FieldByName('C_SIT_TRI').AsString = 'T' then
    Begin
      VpfDRegistro60I.StAliquota := DeletaChars(FormatFloat('00.00',Tabela.FieldByName('N_PER_ICM').AsFloat),',');
      VpfDRegistro60I.ValorIcms := (Tabela.FieldByName('N_PER_ICM').AsFloat/100)*Tabela.FieldByName('N_TOT_PRO').AsFloat;
    End
    else
      VpfDRegistro60I.StAliquota := Tabela.FieldByName('C_SIT_TRI').AsString;


    ACBRSintegra.Registros60I.Add(VpfDRegistro60I);
    Tabela.next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro60m(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfDRegistro60M : TRegistro60M ;
  VpfDRegistro60A : TRegistro60A;
begin
  AdicionaSQLAbreTabela(Tabela,'select NUMSERIEECF, NUMREDUCAOZ, NUMCONTADOROPERACAO, NUMCONTADORREINICIOOPERACAO,VALVENDABRUTADIARIA, DATMOVIMENTO, VALGRANDETOTAL, '+
                               ' VALSTICMS, VALISENTOICMS, VALNAOTRIBUTADOICMS, VALCANCELADOICMS, VALDESCONTOICMS '+
                               ' from REDUCAOZ ' +
                               ' Where '+SQLTextoDataEntreAAAAMMDD('TRUNC(DATMOVIMENTO)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,false)+
                               ' ORDER BY NUMREDUCAOZ');
  while not Tabela.Eof do
  begin
    VpfDRegistro60M := TRegistro60M.Create;
    VpfDRegistro60M.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
    VpfDRegistro60M.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
    VpfDRegistro60M.NumOrdem := 1;
    VpfDRegistro60M.ModeloDoc := '2D';
    VpfDRegistro60M.CooInicial := Tabela.FieldByName('NUMCONTADOROPERACAO').AsInteger;
    VpfDRegistro60M.CooFinal := Tabela.FieldByName('NUMCONTADOROPERACAO').AsInteger;
    VpfDRegistro60M.CRZ := Tabela.FieldByName('NUMREDUCAOZ').AsInteger;
    VpfDRegistro60M.CRO := Tabela.FieldByName('NUMCONTADORREINICIOOPERACAO').AsInteger;
    VpfDRegistro60M.VendaBruta := Tabela.FieldByName('VALVENDABRUTADIARIA').AsFloat;
    VpfDRegistro60M.ValorGT := Tabela.FieldByName('VALGRANDETOTAL').AsFloat;
    ACBRSintegra.Registros60M.Add(VpfDRegistro60M);

    if Tabela.FieldByName('VALSTICMS').AsFloat <> 0 then
    begin
      VpfDRegistro60A := TRegistro60A.Create;
      VpfDRegistro60A.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      VpfDRegistro60A.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
      VpfDRegistro60A.StAliquota := 'F';
      VpfDRegistro60A.Valor := Tabela.FieldByName('VALSTICMS').AsFloat;
      ACBRSintegra.Registros60A.Add(VpfDRegistro60A);
    end;

    if Tabela.FieldByName('VALISENTOICMS').AsFloat <> 0 then
    begin
      VpfDRegistro60A := TRegistro60A.Create;
      VpfDRegistro60A.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      VpfDRegistro60A.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
      VpfDRegistro60A.StAliquota := 'I';
      VpfDRegistro60A.Valor := Tabela.FieldByName('VALISENTOICMS').AsFloat;
      ACBRSintegra.Registros60A.Add(VpfDRegistro60A);
    end;
    if Tabela.FieldByName('VALNAOTRIBUTADOICMS').AsFloat <> 0 then
    begin
      VpfDRegistro60A := TRegistro60A.Create;
      VpfDRegistro60A.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      VpfDRegistro60A.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
      VpfDRegistro60A.StAliquota := 'N';
      VpfDRegistro60A.Valor := Tabela.FieldByName('VALNAOTRIBUTADOICMS').AsFloat;
      ACBRSintegra.Registros60A.Add(VpfDRegistro60A);
    end;
    if Tabela.FieldByName('VALCANCELADOICMS').AsFloat <> 0 then
    begin
      VpfDRegistro60A := TRegistro60A.Create;
      VpfDRegistro60A.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      VpfDRegistro60A.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
      VpfDRegistro60A.StAliquota := 'CANC';
      VpfDRegistro60A.Valor := Tabela.FieldByName('VALCANCELADOICMS').AsFloat;
      ACBRSintegra.Registros60A.Add(VpfDRegistro60A);
    end;
    if Tabela.FieldByName('VALDESCONTOICMS').AsFloat <> 0 then
    begin
      VpfDRegistro60A := TRegistro60A.Create;
      VpfDRegistro60A.Emissao := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
      VpfDRegistro60A.NumSerie := Tabela.FieldByName('NUMSERIEECF').AsString;
      VpfDRegistro60A.StAliquota := 'DESC';
      VpfDRegistro60A.Valor := Tabela.FieldByName('VALDESCONTOICMS').AsFloat;
      ACBRSintegra.Registros60A.Add(VpfDRegistro60A);
    end;

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro60R(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfDRegistro60R :TRegistro60R;
begin
  AdicionaSQLAbreTabela(Tabela,'select  SUM(MOV.N_QTD_PRO) QTD, SUM(MOV.N_TOT_PRO) VALOR, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_SIT_TRI, '+
                               ' MOV.N_PER_ICM '+
                               ' from MOVNOTASFISCAIS MOV, CADNOTAFISCAIS CAD, CADPRODUTOS PRO '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' AND CAD.C_FLA_ECF = ''S'''+
                               ' AND CAD.C_NOT_CAN = ''N'''+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' GROUP BY PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_SIT_TRI, MOV.N_PER_ICM'+
                               ' ORDER BY 1');
  while not Tabela.Eof do
  begin
    VpfDRegistro60R := TRegistro60R.Create;
    VpfDRegistro60R.MesAno := AdicionaCharE('0',IntToStr(mes(VpaDFiltro.DatInicio)),2)+AdicionaCharE('0',IntToStr(ano(VpaDFiltro.DatInicio)),4);
    VpfDRegistro60R.Codigo := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDRegistro60R.Qtd := Tabela.FieldByName('QTD').AsFloat;
    VpfDRegistro60R.Valor := Tabela.FieldByName('VALOR').AsFloat;
      VpfDRegistro60R.BaseDeCalculo := Tabela.FieldByName('VALOR').AsFloat;
    if Tabela.FieldByName('C_SIT_TRI').AsString = 'T' then
    begin
      VpfDRegistro60R.Aliquota := DeletaChars(FormatFloat('00.00',Tabela.FieldByName('N_PER_ICM').AsFloat),',');
    end
    else
      VpfDRegistro60R.Aliquota := Tabela.FieldByName('C_SIT_TRI').AsString;

    ACBRSintegra.Registros60R.Add(VpfDRegistro60R);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro61(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
Var
  VpfDRegistro61 :TRegistro61;
begin
  AdicionaSQLAbreTabela(Tabela,'select TRUNC(CAD.D_DAT_EMI) D_DAT_EMI, CAD.C_SER_NOT, CAD.C_SUB_SER, SUM(MOV.N_QTD_PRO) QTD, SUM(MOV.N_TOT_PRO) VALOR, PRO.C_SIT_TRI, '+
                               ' MOV.N_PER_ICM '+
                               ' from MOVNOTASFISCAIS MOV, CADNOTAFISCAIS CAD, CADPRODUTOS PRO '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' AND CAD.C_VEN_CON = ''S'''+
                               ' AND CAD.C_NOT_CAN = ''N'''+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' GROUP BY CAD.C_SER_NOT, CAD.C_SUB_SER, PRO.C_SIT_TRI, TRUNC(CAD.D_DAT_EMI), MOV.N_PER_ICM'+
                               ' ORDER BY 1');
  while not Tabela.Eof do
  begin
    VpfDRegistro61 := TRegistro61.Create;
    VpfDRegistro61.Emissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDRegistro61.Modelo := '02';
    VpfDRegistro61.Serie := Tabela.FieldByName('C_SER_NOT').AsString;
    VpfDRegistro61.SubSerie := Tabela.FieldByName('C_SUB_SER').AsString;
    VpfDRegistro61.NumOrdemInicial := 1;
    VpfDRegistro61.NumOrdemInicial := 99999;
    VpfDRegistro61.Valor := Tabela.FieldByName('VALOR').AsFloat;
    VpfDRegistro61.BaseDeCalculo := Tabela.FieldByName('VALOR').AsFloat;
    if Tabela.FieldByName('C_SIT_TRI').AsString = 'T' then
    Begin
      VpfDRegistro61.Aliquota := Tabela.FieldByName('N_PER_ICM').AsFloat;
      VpfDRegistro61.ValorIcms := (Tabela.FieldByName('N_PER_ICM').AsFloat/100)*Tabela.FieldByName('VALOR').AsFloat;
    End
    else
      VpfDRegistro61.Aliquota := 0;


    ACBRSintegra.Registros61.Add(VpfDRegistro61);
    Tabela.next;
  end;

  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro61R(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfDRegistro61R : TRegistro61R;
begin
  AdicionaSQLAbreTabela(Tabela,'select  SUM(MOV.N_QTD_PRO) QTD, SUM(MOV.N_TOT_PRO) VALOR, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_SIT_TRI, '+
                               ' MOV.N_PER_ICM '+
                               ' from MOVNOTASFISCAIS MOV, CADNOTAFISCAIS CAD, CADPRODUTOS PRO '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' AND CAD.C_VEN_CON = ''S'''+
                               ' AND CAD.C_NOT_CAN = ''N'''+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' GROUP BY PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_SIT_TRI, MOV.N_PER_ICM'+
                               ' ORDER BY 1');
  while not Tabela.Eof do
  begin
    VpfDRegistro61R := TRegistro61R.Create;
    VpfDRegistro61R.MesAno := AdicionaCharE('0',IntToStr(mes(VpaDFiltro.DatInicio)),2)+AdicionaCharE('0',IntToStr(ano(VpaDFiltro.DatInicio)),4);
    VpfDRegistro61R.Codigo := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDRegistro61R.Qtd := Tabela.FieldByName('QTD').AsFloat;
    VpfDRegistro61R.Valor := Tabela.FieldByName('VALOR').AsFloat;
      VpfDRegistro61R.BaseDeCalculo := Tabela.FieldByName('VALOR').AsFloat;
    if Tabela.FieldByName('C_SIT_TRI').AsString = 'T' then
    begin
      VpfDRegistro61R.Aliquota := Tabela.FieldByName('N_PER_ICM').AsFloat;
    end;

    ACBRSintegra.Registros61R.Add(VpfDRegistro61R);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.VendasPorPeriodoSintegraRegistro75(VpaDFiltro: TRBDFiltroMenuFiscalECF): string;
var
  VpfDRegistro75 : TRegistro75;
  VpfAliquotaICMS : Double;
begin
  VpfAliquotaICMS := FunCotacao.RAliquotaICMSUF(varia.UFFilial);
  AdicionaSQLAbreTabela(Tabela,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.C_SIT_TRI, PRO.C_CLA_FIS, PRO.N_RED_ICM '+
                               ' FROM CADPRODUTOS PRO '+
                               ' Where EXISTS (Select 1 '+
                               ' from CADNOTAFISCAIS CAD , MOVNOTASFISCAIS MOV '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO)');
  while not Tabela.Eof do
  begin
    VpfDRegistro75 := TRegistro75.Create;
    VpfDRegistro75.DataInicial := VpaDFiltro.DatInicio;
    VpfDRegistro75.DataFinal := VpaDFiltro.DatFim;
    VpfDRegistro75.Codigo := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDRegistro75.NCM := Tabela.FieldByName('C_CLA_FIS').AsString;
    VpfDRegistro75.Descricao := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDRegistro75.Unidade := Tabela.FieldByName('C_COD_UNI').AsString;
    if Tabela.FieldByName('C_SIT_TRI').AsString = 'T' then
      VpfDRegistro75.AliquotaICMS := VpfAliquotaICMS
    else
      if Tabela.FieldByName('N_RED_ICM').AsFloat > 0 then
        VpfDRegistro75.AliquotaICMS := Tabela.FieldByName('N_RED_ICM').AsFloat;
    ACBRSintegra.Registros75.Add(VpfDRegistro75);
    Tabela.Next
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.VendeItem(VpaCodProduto,VpaNomProduto, VpaUM : AnsiString;VpaQtdProduto, VpaValUnitario, VpaPerDesconto, VpaPerICMS : Double;VpaIndSubstituicaoTributaria,VpaIndDesconto,VpaIndPercentual, VpaIndProduto : Boolean;var VpaTotalizadorParcial : string):String;
Var
  VpfPerAliquota,VpfTipDesconto,VpfDescontoAcrescimo : AnsiString;
  VpfQtdTentativas : Integer;
begin
  result := CarAliquotaProduto(VpaPerICMS,VpaIndProduto,VpaIndSubstituicaoTributaria,VpfPerAliquota,VpaTotalizadorParcial);

  if result = '' then
  begin
    if VpaIndPercentual then
      VpfTipDesconto := '%'
    else
      VpfTipDesconto := '$';
    if VpaIndDesconto  then
      VpfDescontoAcrescimo := 'D'
    else
      VpfDescontoAcrescimo := 'A';

    AtualizaBarraStatus('Adicionando Item da Venda');
    ACBRECF.VendeItem(VpaCodProduto,VpaNomProduto,VpfPerAliquota,VpaQtdProduto,VpaValUnitario,VpaPerDesconto,
                     VpaUM,VpfTipDesconto,VpfDescontoAcrescimo);
    AtualizaGrandeTotalCriptografado;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.FechacomTEF(VpaValorTotal: Double; VpaDFormaPagamento: TRBDFormaPagamento): string;
var
  VpfNumIndiceFormaPagamento : string;
begin
  result := '';
  VpfNumIndiceFormaPagamento := RIndiceFormaPagamento(VpaDFormaPagamento.NomForma);
  NaoExisteCriaDiretorio(Varia.DiretorioSistema+'\TEF',false);
  ACBrTEFD.TEFDial.Inicializar;
  if ACBrTEFD.CRT(VpaValorTotal,VpfNumIndiceFormaPagamento ,ACBrECF.NumCOO) then
   begin
    ACBrECF.SubtotalizaCupom;
    ACBrECF.EfetuaPagamento(VpfNumIndiceFormaPagamento,VpaValorTotal,'',True);
    ACBrECF.FechaCupom('MD5='+VARIA.MD5);
   end
  else
    ShowMessage('Erro ao pagar com TEF');

  ACBrTEFD.ImprimirTransacoesPendentes;
end;

{******************************************************************************}
procedure TRBFuncoesECF.VerificaECF(VpaMostrarMensagemRequerZ : boolean = true);
begin
  if not ACBRECF.Ativo then
  begin
    ACBRECF.Ativar;
  end;

  if VpaMostrarMensagemRequerZ then
  begin
    if (ACBRECF.Estado = estRequerZ) then
      aviso('REDUÇÃO Z PENDENTE!!!'#13'Antes de executar essa operação é necessário tirar a Redução Z.');
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
   Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.WB_ScrollToBottom(WebBrowser1: TWebBrowser);
var
 scrollpos: Integer;
 pw : IHTMLWindow2;
 Doc: IHTMLDocument2;
begin
 Doc := WebBrowser1.Document as IHTMLDocument2;
 pw := IHTMLWindow2(Doc.parentWindow);
 scrollPos := pw.screen.height;
 pw.scrollBy(0, scrollpos);
end;

{******************************************************************************}
procedure TRBFuncoesECF.CancelaCupom(VpaCadNota, VpaMovNota : TDataSet;VpaExtornarEstoque : Boolean);
begin
  if not(VpaCadNota.State = dsedit) then
    VpaCadNota.Edit;
  VpaCadNota.FieldByName('C_NOT_CAN').AsString := 'S';
  VpaCadNota.Post;
  if VpaExtornarEstoque then
    ExtornaEstoqueCupomCancelado(VpaCadNota,VpaMovNota);
  ExtornaEstoqueFiscalCupomCancelado(VpaMovNota);
  CancelaCupomAberto;
end;

{******************************************************************************}
procedure TRBFuncoesECF.CancelaCupomAberto;
begin
  ACBRECF.CancelaCupom;
end;

{******************************************************************************}
procedure TRBFuncoesECF.CancelaUltimoCupom;
begin
  if confirmacao('Tem certeza que deseja cancelar o último cupom ?') then
  begin
    VerificaECF;
    ACBRECF.CancelaCupom;
    ExtornaEstoqueUltimoCupom;
    ACBRECF.Desativar;
    aviso('CUPOM FISCAL CANCELADO COM SUCESSO!!!'#13'O cupom fiscal foi cancelado com sucesso.');
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.CarAliquotaProduto(VpaPerAliquota: Double; VpaIndProduto,VpaIndSubstituicaoTributaria : Boolean; var VpaAliquota : AnsiString;Var VpaTotalizardorParcial: string): string;
var
  VpfTipoAliquota : char;
  VpfDAliquota : TACBrECFAliquota;
begin
  result := '';
  if (VpaPerAliquota  > 0) and not VpaIndSubstituicaoTributaria then
  begin
    if VpaIndProduto then
      VpfTipoAliquota := 'T'
    else
      VpfTipoAliquota := 'S';
    VpfDAliquota := ACBRECF.AchaICMSAliquota(VpaPerAliquota,VpfTipoAliquota);
    IF VpfDAliquota = nil then
      result := 'ALIQUOTA DE IMPOSTO NÃO PROGRAMADA NO ECF!!!'#13'Esse produto/serviço não pode ser vendido porque a aliquota de imposto('+FormatFloat('0.00',VpaPerAliquota)+') não existe programada na impressora.';
    if result = '' then
    begin
      VpaAliquota := 'T'+VpfDAliquota.Indice;
      VpaTotalizardorParcial := VpfDAliquota.Indice+VpfTipoAliquota+DeletaChars(FormatFloat('00.00',VpfDAliquota.Aliquota),',');
    end;
  end
  else
  begin
    VpaAliquota := 'FF';
    VpaTotalizardorParcial := 'F1';
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.CarECFAutorizados(VpaListaECFS: TStringList);
var
  VpfArquivo : TStringList;
  VpfLaco : Integer;
begin
  VpaListaECFS.Clear;
  VpfArquivo := TStringList.Create;
  VpfArquivo.LoadFromFile(varia.DiretorioSistema+'\INFOPAF.INI');
  VpfArquivo.Text:= Descriptografa(VpfArquivo.Text);
  for VpfLaco := 0 to VpfArquivo.Count - 1 do
  begin
    if UpperCase(CopiaAteChar(VpfArquivo.Strings[VpfLaco],'=')) = 'ECFAUTORIZADO' then
      VpaListaECFS.Add(DeleteAteChar(VpfArquivo.Strings[VpfLaco],'='));
  end;

  VpfArquivo.Free;
end;

{******************************************************************************}
procedure TRBFuncoesECF.CarNumerosECF(VpaLista: TStrings);
begin
  VpaLista.Clear;
  AdicionaSQLAbreTabela(Tabela,'Select C_SER_NOT FROM CADSERIENOTAS ' +
                               ' Where C_TIP_ECF IS NOT NULL'+
                               ' order by C_SER_NOT ');
  while not Tabela.Eof do
  begin
    VpaLista.Add(Tabela.FieldByName('C_SER_NOT').AsString);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFComandaECF(VpaOperacao: TACBrTEFDOperacaoECF; VpaResposta: TACBrTEFDResp; var RetornoECF: Integer);
begin
//Memo1.Lines.Add('ComandaECF: '+GetEnumName( TypeInfo(TACBrTEFDOperacaoECF),
                                           //   integer(Operacao) ));
  try
    case VpaOperacao of
      opeAbreGerencial :
          AbreRelatorioGerencial;

      opeCancelaCupom :
          ACBrECF.CancelaCupom;

      opeFechaCupom :
         ACBrECF.FechaCupom('Eficacia Sistemas');

      opeSubTotalizaCupom :
         ACBrECF.SubtotalizaCupom( 0, 'TEF-PAF-ECF' );

      opeFechaGerencial, opeFechaVinculado :
        ACBrECF.FechaRelatorio ;

      opePulaLinhas :
        begin
          ACBrECF.PulaLinhas( ACBrECF.LinhasEntreCupons );
          ACBrECF.CortaPapel( True );
          Sleep(200);
        end;
    end;

    RetornoECF := 1 ;
  except
    RetornoECF := 0 ;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.CancelaItem(VpaCodFilial,VpaSeqNota,VpaSeqItem, VpaNumItemECF : Integer):Boolean;
begin
  ACBRECF.CancelaItemVendido(VpaNumItemECF);
  AtualizaBarraStatus('Cancelando Item do Cupom fiscal');
  AtualizaBarraStatus('Inicio fechamento efetuado com sucesso');
  result := true;
  ExecutaComandoSql(Aux,' UPDATE MOVNOTASFISCAIS '+
                        ' SET C_IND_CAN = ''S'''+
                        ' Where I_EMP_FIL = '+IntTostr(VpaCodFilial)+
                        ' and I_SEQ_NOT = ' + IntToStr(VpaSeqNota)+
                        ' and I_SEQ_MOV = '+ IntToStr(VpaSeqItem));
end;

{******************************************************************************}
procedure TRBFuncoesECF.IdentificacaoPAFECF;
var
  VpfArquivo : TStringList;
  VpfLaco : Integer;
begin
  VpfArquivo := TStringList.Create;
  VpfArquivo.LoadFromFile(varia.DiretorioSistema+'\INFOPAF.INI');
  VpfArquivo.Text := Descriptografa(VpfArquivo.Text);

  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  AbreRelatorioGerencial;
  ACBrECF.LinhaRelatorioGerencial('Identificacao do PAF-ECF');
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('Nº do Laudo : '+RetornaValorCampo(VpfArquivo,'LAUDO'));
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('Identificacao da Empresa Desenvolvedora');
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('CNPJ : ' +RetornaValorCampo(VpfArquivo,'CNPJSH'));
  ACBrECF.LinhaRelatorioGerencial('Razao Social : ' +RetornaValorCampo(VpfArquivo,'RAZAOSOCIALSH'));
  ACBrECF.LinhaRelatorioGerencial('Endereco : ' +RetornaValorCampo(VpfArquivo,'ENDERECOSH'));
  ACBrECF.LinhaRelatorioGerencial('Tel : ' +RetornaValorCampo(VpfArquivo,'TELEFONESH'));
  ACBrECF.LinhaRelatorioGerencial('Contato : ' +RetornaValorCampo(VpfArquivo,'CONTATOSH'));
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('Identificacao do PAF-ECF');
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('Nome Comercial : ' +RetornaValorCampo(VpfArquivo,'NOMEPAF'));
  ACBrECF.LinhaRelatorioGerencial('Versao : ' +RetornaValorCampo(VpfArquivo,'VERSAOPAF'));
  ACBrECF.LinhaRelatorioGerencial('Principal Executavel : ' +RetornaValorCampo(VpfArquivo,'PRINCIPALEXECUTAVELPAF'));
  ACBrECF.LinhaRelatorioGerencial('MD5 : ' +RetornaValorCampo(VpfArquivo,'MD5'));
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('No Fabricacao de ECFs autorizados');

  CarECFAutorizados(VpfArquivo);
  for VpfLaco := 0 to VpfArquivo.Count - 1 do
    ACBrECF.LinhaRelatorioGerencial(CopiaAteChar(VpfArquivo.Strings[VpfLaco],'='));


  ACBrECF.FechaRelatorio;
  VpfArquivo.Free;
end;

{******************************************************************************}
function TRBFuncoesECF.ImpressoraAtiva: Boolean;
begin
  try
    ACBRECF.Ativar
  except
  end;
  result := ACBRECF.Ativo;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ImprimeDAVEmitidos(VpaTabela: TSQLQuery);
begin
  AbreRelatorioGerencial;
  ACBrECF.LinhaRelatorioGerencial('DAV EMITIDOS');
  ACBrECF.LinhaRelatorioGerencial('');
  while not VpaTabela.Eof do
  begin
    ACBrECF.LinhaRelatorioGerencial(AdicionaCharE('0',VpaTabela.FieldByName('I_LAN_ORC').AsString,10)+ ' '+
                        FormatDateTime('DD/MM/YYYY',VpaTabela.FieldByName('D_DAT_ORC').AsDateTime)+ ' ' +
                        COPY(AdicionaCharD(' ',VpaTabela.FieldByName('C_NOM_TIP').AsString,8),1,8)+' ' +
                        AdicionaCharE(' ',FormatFloat('#,###,##0.00',VpaTabela.FieldByName('N_VLR_LIQ').AsFloat),9)+ ' '+
                        AdicionaCharE(' ',FormatFloat('#,###,##0',VpaTabela.FieldByName('I_NUM_COO').AsInteger),7));
    VpaTabela.Next;
  end;
  VpaTabela.Close;
  ACBrECF.FechaRelatorio;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFImprimeVia(VpaTipoRelatorio: TACBrTEFDTipoRelatorio; VpaVia: Integer;VpaImagemComprovante: TStringList; var VpaRetornoECF: Integer);
begin
  if ACBRECF.MemoBobina <> nil then
    ACBRECF.MemoBobina.Lines.AddStrings( VpaImagemComprovante );
  try
     case VpaTipoRelatorio of
       trGerencial :
         ACBrECF.LinhaRelatorioGerencial( VpaImagemComprovante.Text ) ;

       trVinculado :
         ACBrECF.LinhaCupomVinculado( VpaImagemComprovante.Text )
     end;

     VpaRetornoECF := 1 ;
  except
     VpaRetornoECF := 0 ;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.MeiosPagamento(VpaDFiltro: TRBDFiltroMenuFiscalECF);
begin
  AdicionaSQLAbreTabela(Tabela,'select SUM(CAD.N_TOT_NOT) TOTAL, FRM.C_NOM_FRM, TRUNC(CAD.D_DAT_EMI) D_DAT_EMI '+
                               ' from CADNOTAFISCAIS CAD, CADFORMASPAGAMENTO FRM, CADCONTASARECEBER REC,  MOVCONTASARECEBER MOV '+
                               ' WHERE MOV.I_COD_FRM = FRM.I_COD_FRM '+
                               ' AND C_FLA_ECF = ''S'''+
                               'AND REC.I_EMP_FIL = MOV.I_EMP_FIL '+
                               'AND REC.I_LAN_REC = MOV.I_LAN_REC '+
                               'AND CAD.I_EMP_FIL = REC.I_EMP_FIL '+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               'AND CAD.I_SEQ_NOT = REC.I_SEQ_NOT '+
                               ' GROUP BY FRM.C_NOM_FRM, TRUNC(CAD.D_DAT_EMI) '+
                               ' ORDER BY 3 ');
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  AbreRelatorioGerencial;
  ACBrECF.LinhaRelatorioGerencial('MEIOS E PAGAMENTO');
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('Periodo '+FormatDateTime('DD/MM/YY',VpaDFiltro.DatInicio)+ ' A ' + FormatDateTime('DD/MM/YY',VpaDFiltro.DatFim));
  ACBrECF.LinhaRelatorioGerencial('');
  ACBrECF.LinhaRelatorioGerencial('Identificacao         Fiscal   N.Fiscal   Data ');

  while not Tabela.Eof do
  begin
    ACBrECF.LinhaRelatorioGerencial(AdicionaCharD(' ',Copy(Tabela.FieldByName('C_NOM_FRM').AsString,1,13),13)+ ' '+AdicionaCharE(' ',FormatFloat('#,###,###,##0.00',Tabela.FieldByName('TOTAL').AsFloat),14) + ' '+ AdicionaCharE(' ',FormatFloat('#,###,###,##0.00',RValorNaoFiscalECF(VpaDFiltro.NumSerieECF,Tabela.FieldByName('D_DAT_EMI').AsDateTime) ),10)+' ' +FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_EMI').AsDateTime));
    Tabela.Next;
  end;
  Tabela.Close;

  AdicionaSQLAbreTabela(Tabela,'select SUM(CAD.N_TOT_NOT) TOTAL, FRM.C_NOM_FRM '+
                               ' from CADNOTAFISCAIS CAD, CADFORMASPAGAMENTO FRM, CADCONTASARECEBER REC,  MOVCONTASARECEBER MOV '+
                               ' WHERE MOV.I_COD_FRM = FRM.I_COD_FRM '+
                               ' AND C_FLA_ECF = ''S'''+
                               'AND REC.I_EMP_FIL = MOV.I_EMP_FIL '+
                               'AND REC.I_LAN_REC = MOV.I_LAN_REC '+
                               'AND CAD.I_EMP_FIL = REC.I_EMP_FIL '+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDFiltro.DatInicio,VpaDFiltro.DatFim,true)+
                               'AND CAD.I_SEQ_NOT = REC.I_SEQ_NOT '+
                               ' GROUP BY FRM.C_NOM_FRM ');
  ACBrECF.LinhaRelatorioGerencial('TOTAIS POR PAGAMENTO NO PERIODO');
  ACBrECF.LinhaRelatorioGerencial('');
  while not Tabela.Eof do
  begin
    ACBrECF.LinhaRelatorioGerencial(AdicionaCharD(' ',Copy(Tabela.FieldByName('C_NOM_FRM').AsString,1,13),13)+ ' '+AdicionaCharE(' ',FormatFloat('#,###,###,##0.00',Tabela.FieldByName('TOTAL').AsFloat),14) );
    Tabela.Next;
  end;
  ACBRECF.FechaRelatorio;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.IndiceTecnicoProducao;
var
  VpfArquivo : TStringList;
begin
  VpfArquivo := TStringList.Create;

  AdicionaSQLAbreTabela(Tabela,'Select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.I_SEQ_PRO ' +
                               ' FROM CADPRODUTOS PRO ');
  while not Tabela.Eof do
  begin
    VpfArquivo.Add('Produto: '+Tabela.FieldByName('C_COD_PRO').AsString+'-'+Tabela.FieldByName('C_NOM_PRO').AsString);
    AdicionaItemIndiceTecnico(VpfArquivo,Tabela.FieldByName('I_SEQ_PRO').AsInteger);
    Tabela.Next;
  end;
  tabela.Close;

  VpfArquivo.SaveToFile(varia.DiretorioSistema+CT_PASTAPAF+'IndiceProducao.txt');
  VpfArquivo.Free;
  AssinaArquivo(varia.DiretorioSistema+CT_PASTAPAF+'IndiceProducao.txt');
  AVISO('Arquivo Gerado '+varia.DiretorioSistema+CT_PASTAPAF+'IndiceProducao.txt');
end;

{******************************************************************************}
function TRBFuncoesECF.IniciaFechamento(VpaDescontoAcrescimo : double) : String;
begin
  result := '';
  ACBRECF.SubtotalizaCupom(VpaDescontoAcrescimo,'www.eficaciaconsultoria.com.br');
end;

{******************************************************************************}
procedure TRBFuncoesECF.FormaPagamentoCupom(VpaDesFormaPagamento, VpaDesCondicaoPagamento : String;VpaValor : Double);
begin
  ACBRECF.EfetuaPagamento(RIndiceFormaPagamento(VpaDesFormaPagamento),VpaValor,VpaDesCondicaoPagamento);
end;

{******************************************************************************}
procedure TRBFuncoesECF.GeraArquivoDAVEmitidos(VpaTabela: TSQLQuery);
Var
  VpfNomArquivo : string;
begin
  GeraARquivoDAVEmitidosRegistroD1;
  while not VpaTabela.Eof do
  begin
    with ACBRPAF.PAF_D.RegistroD2.New do
    begin
      COO := '000000';
      NUM_DAV := VpaTabela.FieldByName('I_LAN_ORC').AsString;
      DT_DAV :=  VpaTabela.FieldByName('D_DAT_ORC').AsDateTime;
      TIT_DAV := VpaTabela.FieldByName('C_NOM_TIP').AsString;
      VLT_DAV := VpaTabela.FieldByName('N_VLR_LIQ').AsFloat;

      AdicionaSQLAbreTabela(Aux,'Select * from CADORCAMENTOS ' +
                                ' Where I_EMP_FIL = '+VpaTabela.FieldByName('I_EMP_FIL').AsString+
                                ' and I_LAN_ORC = '+VpaTabela.FieldByName('I_LAN_ORC').AsString);
      if not Sistema.AssinaturaValida(aux,Aux.FieldByName('C_ASS_REG').AsString) then
        MODELO_ECF := AdicionaCharD('?','',20);

//      COO_DFV := VpaTabela.FieldByName('I_NUM_COO').AsString;
    end;
    VpaTabela.Next;
  end;
  VpfNomArquivo := 'Paf_D.txt';
  ACBRPAF.SaveFileTXT_D(VpfNomArquivo);
  AssinaArquivo(varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);
  AVISO('Arquivo Gerado '+varia.DiretorioSistema+CT_PASTAPAF+VpfNomArquivo);
end;

{******************************************************************************}
procedure TRBFuncoesECF.GeraARquivoDAVEmitidosRegistroD1;
begin
  with ACBRPAF.PAF_D.RegistroD1 do
  begin
    UF := varia.CNPJFilial;
    CNPJ := LimpaMascaraCGCCPF(Varia.CNPJFilial);
    IE := LimpaMascaraCGCCPF(Varia.IEFilial);
    IM := LimpaMascaraCGCCPF(varia.InscricaoMunicipal);
    RAZAOSOCIAL := varia.RazaoSocialFilial;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.GravaArqLeituraMemoriaFiscal(VpaDFiltro: TRBDFiltroMenuFiscalECF;VpaSimplificada : Boolean);
var
  VpfArqPaf: TStringList;
  VpfNomArquivo : String;
begin
  try
    if VpaSimplificada then
      VpfNomArquivo := Varia.DiretorioSistema+CT_PASTAPAF+'LeituraMemoriaFiscalSimplificada.txt'
    else
      VpfNomArquivo := Varia.DiretorioSistema+CT_PASTAPAF+'LeituraMemoriaFiscalCompleta.txt';

    VpfArqPaf:= TStringList.Create;
    ACBRECF.LeituraMemoriaFiscalSerial(VpaDFiltro.DatInicio,VpaDFiltro.DatFim, VpfArqPaf, VpaSimplificada);
    VpfArqPaf.SaveToFile(VpfNomArquivo);

    //assina Arquivo
    AssinaArquivo(VpfNomArquivo);

    ArquivoMFD(VpaDFiltro);

    aviso(VpfNomArquivo);
  finally
    FreeAndNil(VpfArqPaf);
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.GravaDComprovanteNaoFiscal(VpaNumSerieECF, VpaDesOperacao, VpaDesDenominacao: String; VpaNumCOO,VpaNumGNF: Integer;VpaValor : Double): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from COMPROVANTENAOFISCAL ' +
                                 ' Where NUMSERIEECF IS NULL AND NUMCOO = 0 ');
  Cadastro.Insert;
  Cadastro.FieldByName('NUMSERIEECF').AsString := VpaNumSerieECF;
  Cadastro.FieldByName('NUMCOO').AsInteger := VpaNumCOO;
  Cadastro.FieldByName('NUMGNF').AsInteger := VpaNumGNF;
  Cadastro.FieldByName('DESDENOMINACAO').AsString := VpaDesDenominacao;
  Cadastro.FieldByName('DESOPERACAO').AsString := VpaDesOperacao;
  Cadastro.FieldByName('DATEMISSAO').AsDateTime := Now;
  Cadastro.FieldByName('VALCOMPROVANTE').AsFloat := VpaValor;
  Cadastro.FieldByName('DESASSINATURAREGISTRO').AsString := Sistema.RAssinaturaRegistro(Cadastro);
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.GravaMD5(VpaMD5: string);
var
  VpfArquivo : TStringList;
begin
  VpfArquivo := TStringList.Create;
  VpfArquivo.LoadFromFile(varia.DiretorioSistema+'\INFOPAF.INI');
  VpfArquivo.Text := Descriptografa(VpfArquivo.Text);
  AlteraValorCampo(VpfArquivo,'MD5',VpaMD5);
  VpfArquivo.Delete(VpfArquivo.Count-1);
  VpfArquivo.Text := Criptografa(VpfArquivo.Text);
  VpfArquivo.SaveToFile(varia.DiretorioSistema+'\INFOPAF.INI');
end;

{******************************************************************************}
procedure TRBFuncoesECF.FinalizaCupom(VpaTexto : TStringlist);
begin
  ACBRECF.FechaCupom(VpaTexto.Text);
  ACBRECF.Desativar;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AdicionaAliquotaICMS(VpaAliquota : Double);
begin
  ACBRECF.ProgramaAliquota(VpaAliquota);
end;

procedure TRBFuncoesECF.AdicionaItemIndiceTecnico(VpaArquivo: TStringList; VpaSeqProduto: Integer);
begin
  AdicionaSQLAbreTabela(Tabela2,'Select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.I_SEQ_PRO, KIT.N_QTD_PRO '+
                               ' FROM CADPRODUTOS PRO, MOVKIT KIT '+
                               ' WHERE PRO.I_SEQ_PRO =  KIT.I_SEQ_PRO '+
                               ' AND I_COR_KIT = 0 '+
                               ' AND I_PRO_KIT = ' +  IntToStr(VpaSeqProduto));

  while not Tabela2.Eof do
  begin
    VpaArquivo.Add('ITEM='+Tabela2.FieldByName('C_COD_PRO').AsString+'UN='+Tabela2.FieldByName('C_COD_UNI').AsString + ' QTD='+FormatFloat('0.00',Tabela2.FieldByName('N_QTD_PRO').AsFloat));
    Tabela2.Next;
  end;
  Tabela2.Close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AlteraValorCampo(VpaArquivo: TStringList; VpaCampo, VpaNovoValor: string);
var
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaArquivo.Count - 1 do
  begin
    if UpperCase(CopiaAteChar(VpaArquivo.Strings[VpfLaco],'=')) = UpperCase(VpaCampo) then
    begin
      VpaArquivo.Strings[VpfLaco] := CopiaAteChar(VpaArquivo.Strings[VpfLaco],'=') + '='+VpaNovoValor;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AnalisaBarraStatus;
begin

end;

{******************************************************************************}
procedure TRBFuncoesECF.ArquivoMFD(VpaDFiltro: TRBDFiltroMenuFiscalECF);
var
  VpfNomArquivo :String;
begin
  VerificaECF;
  VpfNomArquivo := varia.DiretorioSistema +CT_PASTAPAF+'ArquivoMFD.txt';
  if VpaDFiltro.TipFiltro = tfPeriodo then
    ACBRECF.ArquivoMFD_DLL(VpaDFiltro.DatInicio,VpaDFiltro.DatFim,VpfNomArquivo)
  else
    ACBRECF.ArquivoMFD_DLL(VpaDFiltro.NumIntervaloCOOInicio,VpaDFiltro.NumIntervaloCOOFim,VpfNomArquivo);

  AssinaArquivo(VpfNomArquivo);
  aviso(VpfNomArquivo);
end;

{******************************************************************************}
procedure TRBFuncoesECF.LeituraLMF(VpaDFiltro: TRBDFiltroMenuFiscalECF;VpaSimplificada : Boolean);
begin
  if VpaDFiltro.TipFiltro = tfPeriodo then
  begin
    if VpaDFiltro.IndGerarArquivo then
    begin
      ACBRECF.Ativar;
      GravaArqLeituraMemoriaFiscal(VpaDFiltro,VpaSimplificada);
    end
    else
    begin
      ACBRECF.Ativar;
      ACBRECF.LeituraMemoriaFiscal(VpaDFiltro.DatInicio,VpaDFiltro.DatFim,VpaSimplificada);
    end;
  end
  else
  begin
    if VpaDFiltro.IndGerarArquivo then
    begin
      ACBRECF.Ativar;
      GravaArqLeituraMemoriaFiscal(VpaDFiltro,VpaSimplificada);
    end
    else
    begin
      ACBRECF.Ativar;
      ACBRECF.LeituraMemoriaFiscal(VpaDFiltro.NumIntervaloCRZInicio,VpaDFiltro.NumIntervaloCRZFim,VpaSimplificada);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.LeituraX;
begin
  VerificaECF;
  ACBRECF.LeituraX;
  ACBRECF.Desativar;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ReducaoZ;
var
  VpfEfetuarReducao : Boolean;
  VpfDatUltimaReducaoZ: TDateTime;
  VpfResultado : string;
  VpfDFiltro : TRBDFiltroMenuFiscalECF;
begin
  VpfResultado := '';
  VpfEfetuarReducao := true;
  VerificaECF(false);
  if (ACBRECF.Estado <> estRequerZ) then
  begin
    VpfEfetuarReducao := confirmacao('Tem certeza que deseja efetuar a Redução Z ?');
    DAVOSEmitidos;
  end;

  if VpfEfetuarReducao  then
  begin
    VpfResultado :=  SalvaDadosReducaoZ;
    VpfDatUltimaReducaoZ := ACBRECF.DataMovimento;
    if VpfResultado = '' then
    begin
      ACBRECF.ReducaoZ;

      VpfDFiltro := TRBDFiltroMenuFiscalECF.cria;
      VpfDFiltro.NumSerieECF := ACBRECF.NumSerie;
      VpfDFiltro.DatInicio := VpfDatUltimaReducaoZ;
      VpfDFiltro.DatFim := VpfDFiltro.DatInicio;
      MovimentoporECF(VpfDFiltro);

      if Mes(ACBrECF.DataMovimento) <> Mes(VpfDatUltimaReducaoZ) then
        ACBRECF.LeituraMemoriaFiscal(PrimeiroDiaMes(VpfDatUltimaReducaoZ),UltimoDiaMes(VpfDatUltimaReducaoZ));
      DAVOSEmitidos;
    end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TRBFuncoesECF.RetornaValorCampo(VpaArquivo : TStringList;VpaNomCampo: string): string;
var
  VpfLaco : Integer;
begin
  result := '';
  for VpfLaco := 0 to VpaArquivo.Count - 1 do
  begin
    if UpperCase(CopiaAteChar(VpaArquivo.Strings[VpfLaco],'=')) = UpperCase(VpaNomCampo) then
    begin
      result := DeleteAteChar(VpaArquivo.Strings[VpfLaco],'=');
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.RIndiceFormaPagamento(VpaNomFormaPagamento: String): string;
var
  VpfFPG : TACBrECFFormaPagamento;
  VpfDesFormaPagamento : String;
begin
  VpfDesFormaPagamento := copy(VpaNomFormaPagamento,1,15);
  VpfFPG := ACBRECF.AchaFPGDescricao(VpfDesFormaPagamento);
  if VpfFPG <> nil then
    result :=  VpfFPG.Indice
  else
  begin
    ACBRECF.ProgramaFormaPagamento(VpfDesFormaPagamento,true);
    VpfFPG := ACBRECF.AchaFPGDescricao(VpfDesFormaPagamento);
    if VpfFPG <> nil then
      Result :=  VpfFPG.Indice
    else
      Result :=  '01';
  end;
end;

{***************************************************************************}
function TRBFuncoesECF.AbreCupomFiscalVinculado(VpaCOO, VpaIndiceECF: String; VpaValor: Double; var VpaRetornoECF: Integer): string;
begin
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  ACBrECF.AbreCupomVinculado( VpaCOO, VpaIndiceECF, VpaValor );
  AdicionaSQLAbreTabela(Cadastro,'Select * from DOCUMENTOVINCULADOECF '+
                                 ' Where NUMSERIEECF IS NULL AND NUMCOO = 0');
  Cadastro.Insert;
  Cadastro.FieldByName('NUMSERIEECF').AsString := RNumSerieECF;
  Cadastro.FieldByName('NUMCOO').AsInteger := RNumCOO;
  Cadastro.FieldByName('NUMGNF').AsInteger := StrToInt(ACBRECF.NumGNF);
  Cadastro.FieldByName('NUMCDC').AsInteger := StrToInt(ACBRECF.NumCDC);
  Cadastro.FieldByName('DATEMISSAO').AsDateTime := now;
  Cadastro.FieldByName('DESASSINATURAREGISTRO').AsString := Sistema.RAssinaturaRegistro(Cadastro);
  Cadastro.Post;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AbreGaveta;
begin
  ACBRECF.AbreGaveta
end;

{******************************************************************************}
function TRBFuncoesECF.AbreRelatorioGerencial: string;
begin
  if not ACBRECF.Ativo then
    ACBRECF.Ativar;
  ACBrECF.AbreRelatorioGerencial();
  AdicionaSQLAbreTabela(Cadastro,'Select * from RELATORIOGERENCIALECF '+
                                 ' Where NUMSERIEECF IS NULL AND NUMCOO = 0');
  Cadastro.Insert;
  Cadastro.FieldByName('NUMSERIEECF').AsString := RNumSerieECF;
  Cadastro.FieldByName('NUMCOO').AsInteger := RNumCOO;
  Cadastro.FieldByName('NUMGNF').AsInteger := StrToInt(ACBRECF.NumGNF);
  Cadastro.FieldByName('NUMGRG').AsInteger := RNumGRG;
  Cadastro.FieldByName('DATEMISSAO').AsDateTime := now;
  Cadastro.FieldByName('DESASSINATURAREGISTRO').AsString := Sistema.RAssinaturaRegistro(Cadastro);
  Cadastro.Post;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.TEFAbreVinculado(VpaCOO, VpaIndiceECF: String; VpaValor: Double; var VpaRetornoECF: Integer);
begin
  try
    AbreCupomFiscalVinculado(VpaCOO,VpaIndiceECF,VpaValor,VpaRetornoECF);
    VpaRetornoECF := 1 ;
  except
    VpaRetornoECF := 0 ;
  end;
end;

end.
