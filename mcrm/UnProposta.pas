Unit UnProposta;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, UnDadosProduto, UnDados, SysUtils,Parcela, UnSistema, IdMessage, IdSMTP, UnCotacao, UnProspect,
     UNClientes, UnContasAreceber, UnProdutos, UnAmostra,IdAttachmentfile, idText, SQLExpr,
     tabela, DBKeyViolation, Forms, DBClient;

//classe localiza
Type TRBLocalizaProposta = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesProposta = class(TRBLocalizaProposta)
  private
    Aux,
    Aux2,
    Tabela :TSQLQuery;
    Cadastro,
    Cadastro2 : TSQL;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    CriaParcelas : TCriaParcelasReceber;
    function RSeqPropostaDisponivel(VpaCodfilial : Integer) : Integer;
    function RTextoProdutoRotulados(VpaDProdutoRotulados : TRBDPropostaProdutoASerRotulado): String;
    function RTextoAcrescimoDesconto(VpaDProposta : TRBDpropostaCorpo):String;
    function RValorAcresicmodesconto(VpaDProposta : TRBDpropostaCorpo):String;
    function RSeqEstagioDisponivel(VpaCodFilial,VpaSeqProposta : Integer):Integer;
    function RSeqEmailDisponivel: Integer;
    function RNomTipoProposta(VpaCodTipoProposta : Integer):String;
    function RNomMaterialRotulo(VpaCodMaterial : Integer) : String;
    function RNomMaterialLiner(VpaCodMaterial : Integer) : string;
    function RCorpoEmailPadrao(VpaListaProposta : TList): String;
    function CarOpcoesProposta(VpaDProposta : TRBDPropostaCorpo):TStringList;
    procedure ExcluiPropostaCotacao(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaProduto(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropotaSolicitacaoCompra(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaMaquinaCliente(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaProdutoSemQtd(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaAmostra(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaLocacao(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaServico(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiLocacaoFranquia(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaProdutoRotuloado(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaVendaAdicional(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ExcluiPropostaEmail(VpaCodFilial, VpaSeqProposta : Integer);
    procedure CarDPropostaProduto(VpaDProposta  : TRBDPropostaCorpo);
    procedure CarDPropostaProdutoSemQtd(VpaDProposta  : TRBDPropostaCorpo);
    procedure CarDPropostaAmostra(VpaDProposta : TRBDPropostaCorpo);
    procedure CarDPropostaLocacao(VpaDProposta : TRBDPropostaCorpo);
    procedure CarDPropostaServico(VpaDProposta : TRBDPropostaCorpo);
    procedure CarDLocacaoFranquias(VpaDLocacaoCorpo : TRBDPropostaLocacaoCorpo);
    procedure CarDPropostaProdutoRotulado(VpaDProposta : TRBDPropostaCorpo);
    procedure CadDPropostaMaquinaCliente(VpaDProposta : TRBDPropostaCorpo);
    procedure CarDPropostaVendaAdicional(VpaDProposta : TRBDPropostaCorpo);
    procedure CarDPropostaCondicaoPagamento(VpaDProposta: TRBDPropostaCorpo);
    procedure CarDPropostaMaterialAcabamento(VpaDProposta: TRBDPropostaCorpo);
    procedure CarDPropostaParcelas(VpaDProposta : TRBDPropostaCorpo);
    procedure PreparaProdutosChamado(VpaDProposta : TRBDPropostaCorpo);
    procedure AdicionaProdutoChamado(VpaDProposta : TRBDPropostaCorpo; VpaSeqItemChamado, VpaSeqProdutoChamado : Integer;VpaValTotal : Double);
    function GravaDPropostaProduto(VpaDProposta : TRBDPropostaCorpo) : String;
    function GravaDPropostaProdutoSemQtd(VpaDProposta : TRBDPropostaCorpo) : String;
    function GravaDPropostaAmostra(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDPropostaLocacao(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDPropostaServico(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDLocacaoFranquia(VpaDPropostaLocacao: TRBDPropostaLocacaoCorpo): String;
    function GravaDProdutoRotulados(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDMaquinaCliente(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDVendaAdicional(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDPropostaProdutoChamado(VpaDProposta : TRBDPropostaCorpo) : string;
    function GravaDPropostaCondicaoPagamento(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDPropostaMaterialAcabamento(VpaDProposta: TRBDPropostaCorpo): String;
    function GravaDPropostaParcelas(VpaDProposta: TRBDPropostaCorpo): String;
    procedure MontaCabecalhoEmail(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial;VpaOpcao : Integer);
    procedure MontaCabecalhoEmailModelo2(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial);
    procedure MontaCabecalhoEmailEmAnexo(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial;VpaCorpoEmail : String);
    procedure MontaCabecalhoEmailEmAnexoEficacia(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial;VpaCorpoEmail : String;VpaDCliente : TRBDCliente);
    procedure MontaCabecalhoEmailHomero(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial);
    procedure MontaCabecalhoEmailRotuladoras(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial);
    procedure MontaEmailProposta(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial;VpaOpcao : Integer);
    procedure MontaEmailPropostaModelo1(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial;VpaOpcao : Integer);
    procedure MontaEmailPropostaModelo2(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
    procedure MontaEmailPropostaModelo3(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
    procedure MontaEmailPropostaModelo4(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
    procedure MontaEmailsPropostaHomero(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
    procedure MontaEmailPropostaRotuladora(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
    procedure MontaEmailPropostaEmAnexo(VpaTexto : TStrings; VpaListaProposta : TList; VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial; VpaCorpoEmail: String);
    procedure MontaEmailAdicionaProdutosRotulados(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo);
    procedure MontaEmailAdicionaConfiguracao(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo);
    procedure MontaEmailAdcionaValoresRotuladora(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo);
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial) : string;
    function GravaLogEstagio(VpaCodFilial, VpaSeqProposta,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String):String;
    function GravaDEmail(VpaDProposta: TRBDPropostaCorpo): String;
    procedure OrdenaItensPelaOpcao(VpaDProposta: TRBDPropostaCorpo);
    function AnexaLogos(VpaDFilial : TRBDFilial) : string;
    function RNomFormaPagamento(VpaCodFormaPagamento: Integer):String;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    function RNomeEmbalagem(VpaCodEmbalagem: Integer): String;
    function RNomAplicacao(VpaCodAplicacao: Integer): String;
    function RNomProduto(VpaSeqProduto: Integer): String;
    function ExisteProduto(VpaCodProduto : String;VpaCodTabelaPreco : Integer;VpaDProProposta : TRBDPropostaProduto;VpaDProposta : TRBDPropostaCorpo):Boolean; overload;
    function ExisteProduto(VpaCodProduto: String; VpaDPropostaLocacao: TRBDPropostaLocacaoCorpo): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String; VpaDProdutoAdicional: TRBDPropostaVendaAdicional): Boolean; overload;
    function ExisteProdutoMaterialAcabamento(VpaCodProduto: String; VpaDMaterialAcabamento: TRBDPropostaMaterialAcabamento):Boolean;
    function ExisteAmostra(VpaCodAmostra: Integer; VpaDAmostraProposta : TRBDPropostaAmostra): Boolean;
    function ExisteCondicaoPagamento(VpaCodCondicaoPagamento: Integer; VpaDCondicaoPafamentoAmostra: TRBDPropostaCondicaoPagamento): Boolean;
    function ExisteFormaPagamento(VpaCodFormaPagamento: Integer; VpaDParcela: TRBDPropostaParcelas): Boolean;
    function Existecor(VpaCodCor :String;VpaDProProposta : TRBDPropostaProduto):Boolean; overload;
    function Existecor(VpaCodCor: String; var VpaNomCor: String):Boolean; overload;
    procedure CalculaValorTotal(VpaDProposta : TRBDPropostaCorpo);
    procedure CalCulaValorParcelas(VpaDProposta: TRBDPropostaCorpo);
    procedure CarDSetorProposta(VpaDProposta : TRBDPropostaCorpo);
    procedure CarDProposta(VpaDProposta: TRBDPropostaCorpo;VpaCodFilial, VpaSeqProposta : Integer);
    procedure CarDEstagioGrupoUsuario(VpaCodGrupo: Integer; VpaEstagio: TList);
    function GravaDProposta(VpaDProposta : TRBDPropostaCorpo) : string;
    function GravaDEstagioGrupoUsuario(VpaCodGrupoUsuario: Integer; VpaEstagio: TList): String;
    function EnviaEmailCliente(VpaListaPropostas: TList; VpaDCliente : TRBDCliente) : string;
    function CarListaProposta(VpaDProposta: TRBDPropostaCorpo): TList;
    function VerificaListaPropostasGrid(VpaGrid: TGridIndice; VpaLista: TList): String;
    function AlteraEstagioProposta(VpaCodFilial,VpaSeqProposta, VpaCodUsuario, VpaCodEstagio : Integer;VpaDesMotivo : String):String;overload;
    function AlteraEstagioProposta(VpaPropostas : TList; VpaCodUsuario, VpaCodEstagio : Integer;VpaDesMotivo : String):String;overload;
    function AlteraEstagioPropostas(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaPropostas, VpaDesMotivo : String):String;
    function AdicionaPropostaChamado(VpaCodFilial,VpaSeqProposta,VpaNumChamado : Integer) : string;
    function ConcluiAmostraPendenteEnvioEmail(VpaDProposta : TRBDPropostaCorpo) :string;
    function EstagioDuplicado(VpaEstagios: TList): Boolean;
    procedure CalculaParcelas(VpaCodFormaPagamento: Integer; VpaDProposta : TRBDPropostaCorpo);
    procedure PreencheClasseParcelas(VpaCodFormaPagamento: Integer; VpaDProposta: TRBDPropostaCorpo);
    procedure ExcluiProposta(VpaCodFilial, VpaSeqProposta : Integer;VpaExcluiPropostaCorpo : Boolean);
end;



implementation

Uses FunSql,Constantes, FunArquivos, FunString, fundata, FunObjeto, dmRave, Constmsg,
     ACorpoEmailProposta;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaProposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaProposta.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesProposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesProposta.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Aux2 := TSQLQuery.Create(nil);
  Aux2.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.aSQLConnection := VpaBaseDados;
  Cadastro2 := TSQL.Create(nil);
  Cadastro2.ASQLConnection := VpaBaseDados;
  //gerador de parcelas da condicao de pagamento
  CriaParcelas := TCriaParcelasReceber.create(nil);
  CriaParcelas.info.ConCampoCodigoCondicao := 'I_COD_PAG';
  CriaParcelas.info.ConCampoQdadeParcelas := 'I_QTD_PAR';
  CriaParcelas.info.ConIndiceReajuste := 'N_IND_REA';
  CriaParcelas.info.ConNomeTabelaCondicao := 'CADCONDICOESPAGTO';
  CriaParcelas.info.ConPercAteVencimento := 'N_PER_DES';
  CriaParcelas.info.MovConCampoCreDeb := 'C_CRE_DEB';
  CriaParcelas.info.MovConCampoDataFixa := 'D_DAT_FIX';
  CriaParcelas.info.MOvConCampoDiaFixo := 'I_DIA_FIX';
  CriaParcelas.info.MovConCampoNumeroDias := 'I_NUM_DIA';
  CriaParcelas.info.MovConCampoNumeroParcela := 'I_NRO_PAR';
  CriaParcelas.info.MovConCampoPercentualCon := 'N_PER_CON';
  CriaParcelas.info.MovConCampoPercPagamento := 'N_PER_PAG';
  CriaParcelas.info.MovConCaracterCrePer := 'C';
  CriaParcelas.info.MovConCaracterDebPer := 'D';
  CriaParcelas.info.MovConNomeTabela := 'MOVCONDICAOPAGTO';
  CriaParcelas.ADataBase := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesProposta.destroy;
begin
  Aux.free;
  Aux2.Free;
  Tabela.free;
  Cadastro.free;
  Cadastro2.free;
  CriaParcelas.free;
  VprMensagem.free;
  VprSMTP.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesProposta.RSeqPropostaDisponivel(VpaCodfilial : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQPROPOSTA) ULTIMO from PROPOSTA '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodfilial));
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.RTextoAcrescimoDesconto(VpaDProposta : TRBDpropostaCorpo):String;
begin
  result := '';
  if (VpaDProposta.PerDesconto > 0) or (VpaDProposta.ValDesconto > 0) then
    result := 'Desconto'
  else
    if (VpaDProposta.PerDesconto < 0) or (VpaDProposta.PerDesconto < 0) then
      result := 'Acréscimo';
end;

{******************************************************************************}
function TRBFuncoesProposta.RTextoProdutoRotulados(
  VpaDProdutoRotulados: TRBDPropostaProdutoASerRotulado): String;
begin
      Result:= VpaDProdutoRotulados.NomProduto;
      if VpaDProdutoRotulados.NomFormatoFrasco <> '' then
        Result:= Result + ' / Formato Frasco: ' + VpaDProdutoRotulados.NomFormatoFrasco;
      if VpaDProdutoRotulados.NomMaterialFrasco <> '' then
        Result:= Result + ' / Material Frasco: ' + VpaDProdutoRotulados.NomMaterialFrasco;
      if VpaDProdutoRotulados.AltFrasco <> 0 then
        Result:= Result + ' / Altura Frasco: ' + IntToStr(VpaDProdutoRotulados.AltFrasco);
      if VpaDProdutoRotulados.LarFrasco <> 0 then
        Result:= Result + ' / Largura Frasco: ' + IntToStr(VpaDProdutoRotulados.LarFrasco);
      if VpaDProdutoRotulados.ProfundidadeFrasco <> 0 then
        Result:= Result + ' / Profundidade Frasco : ' + IntToStr(VpaDProdutoRotulados.ProfundidadeFrasco);
      if VpaDProdutoRotulados.DiametroFrasco <> 0 then
        Result:= Result + ' / Diametro Frasco: ' + IntToStr(VpaDProdutoRotulados.DiametroFrasco);
      if VpaDProdutoRotulados.AltRotulo <> 0 then
        Result:= Result + ' / Altura Rotulo: ' + IntToStr(VpaDProdutoRotulados.AltRotulo);
      if VpaDProdutoRotulados.LarRotulo <> 0  then
        Result:= Result + ' / Largura Rotulo: ' + IntToStr(VpaDProdutoRotulados.LarRotulo);
      if VpaDProdutoRotulados.AltContraRotulo <> 0 then
        Result:= Result + ' / Alt. Contra Rotulo: ' + IntToStr(VpaDProdutoRotulados.AltContraRotulo);
      if VpaDProdutoRotulados.LarContraRotulo <> 0 then
        Result:= Result + ' / Larg. Contra Rotulo: ' + IntToStr(VpaDProdutoRotulados.LarContraRotulo);
      if VpaDProdutoRotulados.AltGargantilha <> 0 then
        Result:= Result + ' / Altura Gargantilha: ' + IntToStr(VpaDProdutoRotulados.AltGargantilha);
      if VpaDProdutoRotulados.LarGargantilha <> 0 then
        Result:= Result + ' / Largura Gargantilha: ' + IntToStr(VpaDProdutoRotulados.LarGargantilha);
      if VpaDProdutoRotulados.ObsProduto <> '' then
        Result:= Result + ' / ' + VpaDProdutoRotulados.ObsProduto;
end;

{******************************************************************************}
function TRBFuncoesProposta.RValorAcresicmodesconto(VpaDProposta : TRBDpropostaCorpo):String;
begin
  result := '';
  if VpaDProposta.PerDesconto > 0 then
    result := FormatFloat('0%',VpaDProposta.PerDesconto)
  else
    if VpaDProposta.PerDesconto < 0 then
      result := FormatFloat('0%',VpaDProposta.PerDesconto*-1);
  if VpaDProposta.ValDesconto > 0 then
    Result := FormatFloat(varia.MascaraValor,VpaDProposta.ValDesconto)
  else
    if VpaDProposta.ValDesconto > 0 then
      Result := FormatFloat(varia.MascaraValor,VpaDProposta.ValDesconto*-1);
end;

{******************************************************************************}
function TRBFuncoesProposta.RSeqEstagioDisponivel(VpaCodFilial,VpaSeqProposta : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select Max(SEQESTAGIO) ULTIMO from ESTAGIOPROPOSTA '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and SEQPROPOSTA = '+ IntToStr(VpaSeqProposta));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.CarOpcoesProposta(VpaDProposta : TRBDPropostaCorpo):TStringList;
var
  VpfLaco : Integer;
begin
  OrdenaItensPelaOpcao(VpaDProposta);
  result := TStringList.Create;
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    if result.IndexOf(IntToStr(TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]).NumOpcao)) < 0 then
      result.add(IntToStr(TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]).NumOpcao));
  end;
  if result.Count = 0 then
    result.add('0');
end;

{******************************************************************************}
function TRBFuncoesProposta.VerificaListaPropostasGrid(VpaGrid: TGridIndice; VpaLista: TList): String;
begin
  Result := '';

end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaProduto(VpaCodFilial, VpaSeqProposta : Integer);
begin
  if (VpaSeqProposta <> 0)then
  begin
    sistema.GravaLogExclusao('PROPOSTAPRODUTO','Select * from PROPOSTAPRODUTO '+
                          ' Where CODFILIAL = ' + IntTostr(VpaCodFilial) +
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
    ExecutaComandoSql(Aux,'Delete from PROPOSTAPRODUTO '+
                          ' Where CODFILIAL = ' + IntTostr(VpaCodFilial) +
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaProdutoSemQtd(VpaCodFilial, VpaSeqProposta : Integer);
begin
  if (VpaSeqProposta <> 0)then
  begin
    sistema.GravaLogExclusao('PROPOSTAPRODUTOSEMQTD','Select * from PROPOSTAPRODUTOSEMQTD '+
                          ' Where CODFILIAL = ' + IntTostr(VpaCodFilial) +
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
    ExecutaComandoSql(Aux,'Delete from PROPOSTAPRODUTOSEMQTD '+
                          ' Where CODFILIAL = ' + IntTostr(VpaCodFilial) +
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiProposta(VpaCodFilial,VpaSeqProposta: Integer;VpaExcluiPropostaCorpo : Boolean);
begin
  ExcluiPropostaProduto(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaProdutoSemQtd(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaAmostra(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaLocacao(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaServico(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaProdutoRotuloado(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaVendaAdicional(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaMaquinaCliente(VpaCodFilial,VpaSeqProposta);
  ExcluiPropotaSolicitacaoCompra(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaCotacao(VpaCodFilial,VpaSeqProposta);
  ExcluiPropostaEmail(VpaCodFilial,VpaSeqProposta);
  if VpaExcluiPropostaCorpo  then
  begin
    Sistema.GravaLogExclusao('PROPOSTA','SELECT * FROM PROPOSTA'+
                                               ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                                               ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));

    ExecutaComandoSql(Aux,'DELETE FROM PROPOSTA'+
                          ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                          ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
  end;

end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaAmostra(VpaCodFilial, VpaSeqProposta : Integer);
begin
  if VpaSeqProposta <> 0 then
  begin
    Sistema.GravaLogExclusao('PROPOSTAAMOSTRA','SELECT * FROM PROPOSTAAMOSTRA'+
                                               ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                                               ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
    ExecutaComandoSql(Aux,'DELETE FROM PROPOSTAAMOSTRA'+
                          ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                          ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaCotacao(VpaCodFilial,VpaSeqProposta: Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM PROPOSTACOTACAO '+
                        ' WHERE CODFILIALPROPOSTA = '+IntToStr(VpaCodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaLocacao(VpaCodFilial, VpaSeqProposta : Integer);
begin
  ExcluiLocacaoFranquia(VpaCodFilial,VpaSeqProposta);
  ExecutaComandoSql(Aux,'DELETE FROM PROPOSTALOCACAO'+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaMaquinaCliente(VpaCodFilial, VpaSeqProposta : Integer);
begin
  if (VpaSeqProposta <> 0)then
  begin
    sistema.GravaLogExclusao('PROPOSTAPRODUTOCLIENTE','Select * from PROPOSTAPRODUTOCLIENTE '+
                          ' Where CODFILIAL = ' + IntTostr(VpaCodFilial) +
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
    ExecutaComandoSql(Aux,'Delete from PROPOSTAPRODUTOCLIENTE '+
                          ' Where CODFILIAL = ' + IntTostr(VpaCodFilial) +
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaServico(VpaCodFilial, VpaSeqProposta : Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM PROPOSTASERVICO'+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaEmail(VpaCodFilial, VpaSeqProposta: Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM PROPOSTAEMAIL '+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiLocacaoFranquia(VpaCodFilial, VpaSeqProposta : Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM PROPOSTALOCACAOFRANQUIA'+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaProdutoRotuloado(VpaCodFilial, VpaSeqProposta : Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM PROPOSTAPRODUTOROTULADO '+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropostaVendaAdicional(VpaCodFilial, VpaSeqProposta : Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM PROPOSTAVENDAADICIONAL '+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
end;

{******************************************************************************}
procedure TRBFuncoesProposta.ExcluiPropotaSolicitacaoCompra(VpaCodFilial,VpaSeqProposta: Integer);
begin
  if (VpaSeqProposta <> 0)then
  begin
    ExecutaComandoSql(Aux,'Delete from PROPOSTASOLICITACAOCOMPRA '+
                          ' Where CODFILIAL = ' + IntTostr(VpaCodFilial) +
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaParcelas(
  VpaDProposta: TRBDPropostaCorpo);
var
  VpfDParcelas : TRBDPropostaParcelas;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PAR.CODFILIAL, PAR.SEQPROPOSTA, PAR.SEQITEM, PAR.VALPAGAMENTO, '+
                               ' PAR.DESCONDICAO, PAR.CODFORMAPAGAMENTO, ' +
                               ' CAD.C_NOM_FRM '+
                               ' FROM PROPOSTAPARCELAS PAR, CADFORMASPAGAMENTO CAD' +
                               ' WHERE PAR.CODFILIAL = ' + IntToStr(VpaDProposta.CodFilial)+
                               ' and PAR.SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' AND PAR.CODFORMAPAGAMENTO = CAD.I_COD_FRM '+
                               ' ORDER BY PAR.SEQITEM' );
  FreeTObjectsList(VpaDProposta.Parcelas);
  While not tabela.eof do
  begin
    VpfDParcelas := VpaDProposta.addParcelas;
    with VpfDParcelas do
    begin
      SeqItem := Tabela.FieldByname('SEQITEM').AsInteger;
      CodFormaPagamento:= Tabela.FieldByname('CODFORMAPAGAMENTO').AsInteger;
      ValPagamento:= Tabela.FieldByname('VALPAGAMENTO').AsFloat;
      DesCondicao:= Tabela.FieldByname('DESCONDICAO').AsString;
      DesFormaPagamento:= Tabela.FieldByname('C_NOM_FRM').AsString;
      Tabela.Next;
    end;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaProduto(VpaDProposta  : TRBDPropostaCorpo);
var
  VpfDProdutoProposta : TRBDPropostaProduto;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRP.SEQPRODUTO, PRP.CODPRODUTO, PRP.CODCOR, PRP.NOMCOR, PRP.NOMPRODUTO, ' +
                               ' PRP.QTDPRODUTO, PRP.VALUNITARIO,PRP.VALTOTAL, PRP.DESUM, PRP.NUMOPCAO, PRP.DESOBSERVACAO, ' +
                               ' PRP.SEQPRODUTOCHAMADO, PRP.SEQITEMCHAMADO, PRP.PERIPI, PRP.VALIPI,' +
                               ' Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, PRO.N_RED_ICM,'+
                               ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_KIT, PRO.C_IND_RET, PRO.C_IND_CRA, '+
                               ' PRO.C_PAT_FOT, PRO.L_DES_TEC, PRO.C_COD_CTB, '+
                               ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                               ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                               ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, QTD.N_QTD_FIS, PRP.VALDESCONTO ' +
                               ' from PROPOSTAPRODUTO PRP, CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                               ' MOVQDADEPRODUTO Qtd ' +
                               ' Where Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                               ' and PRE.I_COD_TAB = '+IntToStr(Varia.TabelaPreco)+
                               ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                               ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                               ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                               ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                               ' AND '+SQLTextoIsNull('PRP.CODCOR','0')+' = QTD.I_COD_COR '+
                               ' and Pro.c_ven_avu = ''S'''+
                               ' and PRE.I_COD_CLI  = 0 '+
                               ' AND PRP.CODFILIAL = ' + IntToStr(VpaDProposta.CodFilial)+
                               ' and PRP.SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' AND PRP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                               ' ORDER BY PRP.SEQITEM' );
  FreeTObjectsList(VpaDProposta.Produtos);
  While not tabela.eof do
  begin
    VpfDProdutoProposta := VpaDProposta.addProduto;
    with VpfDProdutoProposta do
    begin
      SeqProduto := Tabela.FieldByname('SEQPRODUTO').AsInteger;
      CodProduto := Tabela.FieldByname('CODPRODUTO').AsString;
      CodCor := Tabela.FieldByname('CODCOR').AsInteger;
      UM := Tabela.FieldByname('DESUM').AsString;
      DesCor := Tabela.FieldByname('NOMCOR').AsString;
      NomProduto := Tabela.FieldByname('NOMPRODUTO').AsString;
      QtdProduto := Tabela.FieldByname('QTDPRODUTO').AsFloat;
      ValUnitario := Tabela.FieldByname('VALUNITARIO').AsFloat;
      ValTotal := Tabela.FieldByname('VALTOTAL').AsFloat;
      PerIPI:= Tabela.FieldByname('PERIPI').AsFloat;
      ValIPI:= Tabela.FieldByname('VALIPI').AsFloat;
      UMOriginal := Tabela.FieldByName('C_Cod_Uni').Asstring;
      UMAnterior := UM;
      ValUnitarioOriginal := Tabela.FieldByName('VlrReal').AsFloat;
      QtdEstoque := Tabela.FieldByName('QdadeReal').AsFloat;
      PathFoto := Tabela.FieldByName('C_PAT_FOT').AsString;
      DesTecnica := Tabela.FieldByName('L_DES_TEC').AsString;
      NumOpcao := Tabela.FieldByName('NUMOPCAO').AsInteger;
      ValDesconto := Tabela.FieldByName('VALDESCONTO').AsFloat;
      UnidadeParentes.free;
      UnidadeParentes := FunProdutos.ValidaUnidade.UnidadesParentes(UMOriginal) ;
      DesObservacaoProduto:= Tabela.FieldByName('DESOBSERVACAO').AsString;
      SeqItemChamado:= Tabela.FieldByName('SEQITEMCHAMADO').AsInteger;
      SeqProdutoChamado:= Tabela.FieldByName('SEQPRODUTOCHAMADO').AsInteger;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;


{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaProdutoSemQtd(VpaDProposta  : TRBDPropostaCorpo);
var
  VpfDProdutoSemQtd : TRBDPropostaProdutoSemQtd;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRP.SEQPRODUTO, PRP.CODPRODUTO, PRP.NOMPRODUTO, ' +
                               ' PRP.VALUNITARIO, PRP.DESUM, ' +
                               ' Pro.C_Cod_Uni '+
                               ' from PROPOSTAPRODUTOSEMQTD PRP, CADPRODUTOS PRO  '+
                               ' Where PRP.CODFILIAL = ' + IntToStr(VpaDProposta.CodFilial)+
                               ' and PRP.SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' AND PRP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                               ' ORDER BY PRP.SEQITEM' );
  FreeTObjectsList(VpaDProposta.ProdutosSemQtd);
  While not tabela.eof do
  begin
    VpfDProdutoSemQtd := VpaDProposta.addProdutoSemQtd;
    with VpfDProdutoSemQtd do
    begin
      SeqProduto := Tabela.FieldByname('SEQPRODUTO').AsInteger;
      CodProduto := Tabela.FieldByname('CODPRODUTO').AsString;
      DesUM := Tabela.FieldByname('DESUM').AsString;
      NomProduto := Tabela.FieldByname('NOMPRODUTO').AsString;
      ValUnitario := Tabela.FieldByname('VALUNITARIO').AsFloat;
      UnidadesParentes.free;
      UnidadesParentes := FunProdutos.ValidaUnidade.UnidadesParentes(Tabela.FieldByname('C_COD_UNI').AsString) ;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaAmostra(VpaDProposta: TRBDPropostaCorpo);
var
  VpfDAmostraProposta: TRBDPropostaAmostra;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT PRP.NOMCOR, PRP.NOMAMOSTRA, PRP.SEQITEM, PRP.CODCOR, PRP.CODAMOSTRA, '+
                               ' PRP.QTDAMOSTRA, PRP.VALUNITARIO, PRP.VALTOTAL, '+
                               ' AMO.CODAMOSTRAINDEFINIDA, AMO.DESIMAGEM '+
                               ' FROM PROPOSTAAMOSTRA PRP, AMOSTRA AMO '+
                               ' WHERE SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' AND PRP.CODAMOSTRA = AMO.CODAMOSTRA '+
                               ' order by SEQITEM');
  FreeTObjectsList(VpaDProposta.Amostras);
  while not Tabela.Eof do
  begin
    VpfDAmostraProposta:= VpaDProposta.addAmostra;

    VpfDAmostraProposta.NomCor:= Tabela.FieldByName('NOMCOR').AsString;
    VpfDAmostraProposta.NomAmostra:= Tabela.FieldByName('NOMAMOSTRA').AsString;
    VpfDAmostraProposta.DesImagem:= Tabela.FieldByName('DESIMAGEM').AsString;
    VpfDAmostraProposta.SeqItem:= Tabela.FieldByName('SEQITEM').AsInteger;
    VpfDAmostraProposta.CodCor:= Tabela.FieldByName('CODCOR').AsInteger;
    VpfDAmostraProposta.CodAmostra:= Tabela.FieldByName('CODAMOSTRA').AsInteger;
    VpfDAmostraProposta.CodAmostraIndefinida := Tabela.FieldByName('CODAMOSTRAINDEFINIDA').AsInteger;
    VpfDAmostraProposta.QtdAmostra:= Tabela.FieldByName('QTDAMOSTRA').AsFloat;
    VpfDAmostraProposta.ValUnitario:= Tabela.FieldByName('VALUNITARIO').AsFloat;
    VpfDAmostraProposta.ValTotal:= Tabela.FieldByName('VALTOTAL').AsFloat;

    Tabela.Next;
  end;
  Tabela.Close;
end;

procedure TRBFuncoesProposta.CarDPropostaCondicaoPagamento(
  VpaDProposta: TRBDPropostaCorpo);
var
  VpfDCondicaoPagamento : TRBDPropostaCondicaoPagamento;
begin
  AdicionaSQLAbreTabela(Tabela,'Select CODFILIAL, SEQPROPOSTA, CODCONDICAO, NOMCONDICAO, INDAPROVADO' +
                               ' FROM PROPOSTACONDICAOPAGAMENTO ' +
                               ' WHERE CODFILIAL = ' + IntToStr(VpaDProposta.CodFilial)+
                               ' and SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' ORDER BY CODCONDICAO' );
  FreeTObjectsList(VpaDProposta.CondicaoPagamento);
  While not tabela.eof do
  begin
    VpfDCondicaoPagamento := VpaDProposta.addCondicaoPagamento;
    with VpfDCondicaoPagamento do
    begin
      CodCondicao := Tabela.FieldByname('CODCONDICAO').AsInteger;
      NomCondicao := Tabela.FieldByname('NOMCONDICAO').AsString;
      if Tabela.FieldByName('INDAPROVADO').AsString = 'S' then
      VpfDCondicaoPagamento.IndAprovado:= True
    else
      VpfDCondicaoPagamento.IndAprovado:= False;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaLocacao(VpaDProposta: TRBDPropostaCorpo);
var
  VpfDLocacaoProposta: TRBDPropostaLocacaoCorpo;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT'+
                               ' PPL.CODFILIAL, PPL.SEQPROPOSTA, PPL.SEQITEM,'+
                               ' PPL.SEQPRODUTO, PRO.C_COD_PRO, PRO.C_NOM_PRO,'+
                               ' PPL.DESEMAIL'+
                               ' FROM'+
                               ' PROPOSTALOCACAO PPL, CADPRODUTOS PRO'+
                               ' WHERE'+
                               ' PRO.I_SEQ_PRO = PPL.SEQPRODUTO'+
                               ' AND PPL.CODFILIAL = '+IntToStr(VpaDProposta.CodFilial)+
                               ' AND PPL.SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta));
  FreeTObjectsList(VpaDProposta.Locacoes);
  while not Tabela.Eof do
  begin
    VpfDLocacaoProposta:= VpaDProposta.AddLocacao;

    VpfDLocacaoProposta.CodFilial:= Tabela.FieldByName('CODFILIAL').AsInteger;
    VpfDLocacaoProposta.SeqProposta:= Tabela.FieldByName('SEQPROPOSTA').AsInteger;
    VpfDLocacaoProposta.SeqItem:= Tabela.FieldByName('SEQITEM').AsInteger;
    VpfDLocacaoProposta.SeqProduto:= Tabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDLocacaoProposta.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDLocacaoProposta.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDLocacaoProposta.DesEmail:= Tabela.FieldByName('DESEMAIL').AsString;

    CarDLocacaoFranquias(VpfDLocacaoProposta);

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaMaterialAcabamento(
  VpaDProposta: TRBDPropostaCorpo);
var
  VpfDMaterialAcabamento : TRBDPropostaMaterialAcabamento;
begin
  AdicionaSQLAbreTabela(Tabela,'Select CODFILIAL, SEQPROPOSTA, SEQPRODUTO, CODPRODUTO, NOMPRODUTO, DESUM, QTDPRODUTO, VALUNITARIO, VALTOTAL' +
                               ' FROM PROPOSTAMATERIALACABAMENTO ' +
                               ' WHERE CODFILIAL = ' + IntToStr(VpaDProposta.CodFilial)+
                               ' and SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' ORDER BY SEQPRODUTO' );
  FreeTObjectsList(VpaDProposta.MaterialAcabamento);
  While not tabela.eof do
  begin
    VpfDMaterialAcabamento := VpaDProposta.addMaterialAcabamento;
    with VpfDMaterialAcabamento do
    begin
      SeqProduto := Tabela.FieldByname('SEQPRODUTO').AsInteger;
      CodProduto:= Tabela.FieldByname('CODPRODUTO').AsString;
      NomProduto:= Tabela.FieldByname('NOMPRODUTO').AsString;
      UM:= Tabela.FieldByName('DESUM').AsString;
      Quantidade := Tabela.FieldByname('QTDPRODUTO').AsInteger;
      ValUnitario:= Tabela.FieldByname('VALUNITARIO').AsFloat;
      ValTotal:= Tabela.FieldByname('VALTOTAL').AsFloat;
      Tabela.Next;
    end;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaServico(VpaDProposta: TRBDPropostaCorpo);
var
  VpfDPropostaServico: TRBDPropostaServico;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT PSR.CODFILIAL, PSR.SEQPROPOSTA, PSR.SEQITEM,'+
                               ' PSR.CODEMPRESASERVICO, PSR.CODSERVICO, PSR.QTDSERVICO,'+
                               ' PSR.VALUNITARIO, PSR.VALTOTAL, PSR.SEQITEMCHAMADO, PSR.SEQPRODUTOCHAMADO,'+
                               ' CSR.C_NOM_SER'+
                               ' FROM PROPOSTASERVICO PSR, CADSERVICO CSR'+
                               ' WHERE PSR.CODFILIAL = '+IntToStr(VpaDProposta.CodFilial)+
                               ' AND PSR.SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' AND CSR.I_COD_SER = PSR.CODSERVICO');
  FreeTObjectsList(VpaDProposta.Servicos);
  while not Tabela.Eof do
  begin
    VpfDPropostaServico:= VpaDProposta.AddServico;

    VpfDPropostaServico.SeqItem:= Tabela.FieldByName('SEQITEM').AsInteger;
    VpfDPropostaServico.CodEmpresaServico:= Tabela.FieldByName('CODEMPRESASERVICO').AsInteger;
    VpfDPropostaServico.CodServico:= Tabela.FieldByName('CODSERVICO').AsInteger;
    VpfDPropostaServico.QtdServico:= Tabela.FieldByName('QTDSERVICO').AsFloat;
    VpfDPropostaServico.NomServico:= Tabela.FieldByName('C_NOM_SER').AsString;
    VpfDPropostaServico.ValUnitario:= Tabela.FieldByName('VALUNITARIO').AsFloat;
    VpfDPropostaServico.ValTotal:= Tabela.FieldByName('VALTOTAL').AsFloat;
    VpfDPropostaServico.SeqItemChamado:= Tabela.FieldByName('SEQITEMCHAMADO').AsInteger;
    VpfDPropostaServico.SeqProdutoChamado:= Tabela.FieldByName('SEQPRODUTOCHAMADO').AsInteger;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDEstagioGrupoUsuario(VpaCodGrupo: Integer; VpaEstagio: TList);
var
  VpfDEstagio : TRBDEEstagioProducaoGrupoUsuario;
begin
  FreeTObjectsList(VpaEstagio);
  AdicionaSQLAbreTabela(aux,'Select EST.CODEST, EST.NOMEST  '+
                                        ' FROM ESTAGIOPRODUCAO EST, ESTAGIOPRODUCAOGRUPOUSUARIO GRU '+
                                        ' Where EST.CODEST = GRU.CODEST '+
                                        ' AND GRU.CODGRUPOUSUARIO = '+IntToStr(VpaCodGrupo));
  while not AUX.eof do
  begin
    VpfDEstagio := TRBDEEstagioProducaoGrupoUsuario.cria;
    VpaEstagio.Add(VpfDEstagio);
    VpfDEstagio.CodEstagio := aux.FieldByName('CODEST').AsInteger;
    VpfDEstagio.NomEstagio := Aux.FieldByName('NOMEST').AsString;
    Aux.next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDLocacaoFranquias(VpaDLocacaoCorpo: TRBDPropostaLocacaoCorpo);
var
  VpfDLocacaoFranquia: TRBDPropostaLocacaoFranquia;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT'+
                            ' PLF.CODFILIAL, PLF.SEQPROPOSTA, PLF.SEQITEM, PLF.SEQITEMFRANQUIA,'+
                            ' PLF.VALFRANQUIA, PLF.QTDFRAQUIAPB, PLF.VALEXCEDENTEPB,'+
                            ' PLF.QTDFRANQUIACOLOR, PLF.VALEXCEDENTECOLOR'+
                            ' FROM'+
                            ' PROPOSTALOCACAOFRANQUIA PLF'+
                            ' WHERE'+
                            ' PLF.CODFILIAL ='+IntToStr(VpaDLocacaoCorpo.CodFilial)+
                            ' AND PLF.SEQPROPOSTA ='+IntToStr(VpaDLocacaoCorpo.SeqProposta)+
                            ' AND PLF.SEQITEM ='+IntToStr(VpaDLocacaoCorpo.SeqItem));

  while not Aux.Eof do
  begin
    VpfDLocacaoFranquia:= VpaDLocacaoCorpo.AddFranquia;

    VpfDLocacaoFranquia.SeqItem:= Aux.FieldByName('SEQITEM').AsInteger;
    VpfDLocacaoFranquia.SeqItemFranquia:= Aux.FieldByName('SEQITEMFRANQUIA').AsInteger;
    VpfDLocacaoFranquia.ValFranquia:= Aux.FieldByName('VALFRANQUIA').AsFloat;
    VpfDLocacaoFranquia.QtdFranquiaPB:= Aux.FieldByName('QTDFRAQUIAPB').AsInteger;
    VpfDLocacaoFranquia.QtdFranquiaColor:= Aux.FieldByName('QTDFRANQUIACOLOR').AsInteger;
    VpfDLocacaoFranquia.ValExcedentePB:= Aux.FieldByName('VALEXCEDENTEPB').AsFloat;
    VpfDLocacaoFranquia.ValExcedenteColor:= Aux.FieldByName('VALEXCEDENTECOLOR').AsFloat;

    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaProdutoRotulado(VpaDProposta : TRBDPropostaCorpo);
var
  VpfDProRotulado : TRBDPropostaProdutoASerRotulado;
begin
  FreeTObjectsList(VpaDProposta.ProdutosASeremRotulados);
  AdicionaSQLAbreTabela(Tabela,'Select PPR.SeqItem, PPR.SeqProduto, PPR.CodFormatoFrasco, PPR.CodMaterialFrasco, '+
                       ' PPR.AltFrasco, PPR.LarFrasco, PPR.ProFrasco, PPR.DiaFrasco, PPR.LarRotulo, PPR.OBSPRODUTO, '+
                       ' PPR.LarContraRotulo, PPR.LarGargantilha, PPR.AltRotulo, PPR.AltContraRotulo, PPR.AltGargantilha, '+
                       ' PPR.CodMaterialRotulo, PPR.CodLinerRotulo, PPR.CodMaterialContraRotulo, PPR.CodLinerContraRotulo, '+
                       ' PPR.CodMaterialGargantilha, PPR.CodLinerGargantilha, PPR.QTDFRASCOHORA, '+
                       ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                       ' FOF.NomFormato, '+
                       ' MAF.NomMaterialFrasco '+
                       ' FROM PROPOSTAPRODUTOROTULADO PPR, FORMATOFRASCO FOF, MATERIALFRASCO MAF, CADPRODUTOS PRO '+
                       ' WHERE '+SQLTEXTORightJoin('PPR.CODFORMATOFRASCO','MAF.CODMATERIALFRASCO')+
                       ' AND '+SQLTEXTORightJoin('PPR.CODFORMATOFRASCO','FOF.CODFORMATO')+
                       ' AND PPR.SEQPRODUTO = PRO.I_SEQ_PRO '+
                       ' AND PPR.CODFILIAL = '+IntToStr(VpaDProposta.CodFilial)+
                       ' AND PPR.SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                       ' ORDER BY PPR.SEQITEM');

  While not Tabela.eof do
  begin
    VpfDProRotulado := VpaDProposta.addProdutoAseremRotulados;
    with VpfDProRotulado do
    begin
      SeqItem := Tabela.FieldByName('SEQITEM').AsInteger;
      SeqProduto  := Tabela.FieldByName('SEQPRODUTO').AsInteger;
      CodFormatoFrasco := Tabela.FieldByName('CODFORMATOFRASCO').AsInteger;
      CodMaterialFrasco := Tabela.FieldByName('CODMATERIALFRASCO').AsInteger;
      AltFrasco := Tabela.FieldByName('ALTFRASCO').AsInteger;
      LarFrasco := Tabela.FieldByName('LARFRASCO').AsInteger;
      ProfundidadeFrasco := Tabela.FieldByName('PROFRASCO').AsInteger;
      DiametroFrasco := Tabela.FieldByName('DIAFRASCO').AsInteger;
      LarRotulo := Tabela.FieldByName('LARROTULO').AsInteger;
      LarContraRotulo := Tabela.FieldByName('LARCONTRAROTULO').AsInteger;
      LarGargantilha := Tabela.FieldByName('LARGARGANTILHA').AsInteger;
      AltRotulo := Tabela.FieldByName('ALTROTULO').AsInteger;
      AltContraRotulo := Tabela.FieldByName('ALTCONTRAROTULO').AsInteger;
      AltGargantilha := Tabela.FieldByName('ALTGARGANTILHA').AsInteger;
      CodMaterialRotulo := Tabela.FieldByName('CODMATERIALROTULO').AsInteger;
      CodLinerRotulo := Tabela.FieldByName('CODLINERROTULO').AsInteger;
      CodMaterialContraRotulo := Tabela.FieldByName('CODMATERIALCONTRAROTULO').AsInteger;
      CodLinerContraRotulo := Tabela.FieldByName('CODLINERCONTRAROTULO').AsInteger;
      CodMaterialGargantilha := Tabela.FieldByName('CODMATERIALGARGANTILHA').AsInteger;
      CodLinerGargantilha := Tabela.FieldByName('CODLINERGARGANTILHA').AsInteger;
      CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
      NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
      NomFormatoFrasco := Tabela.FieldByName('NOMFORMATO').AsString;
      NomMaterialFrasco := Tabela.FieldByName('NOMMATERIALFRASCO').AsString;
      QtdFrascosHora := Tabela.FieldByName('QTDFRASCOHORA').AsFloat;
      NomMaterialRotulo := RNomMaterialRotulo(Tabela.FieldByName('CODMATERIALROTULO').AsInteger);
      NomLinerRotulo := RNomMaterialLiner(Tabela.FieldByName('CODLINERROTULO').AsInteger);
      NomMaterialContraRotulo := RNomMaterialRotulo(Tabela.FieldByName('CODMATERIALCONTRAROTULO').AsInteger);
      NomLinerContraRotulo := RNomMaterialLiner(Tabela.FieldByName('CODLINERCONTRAROTULO').AsInteger);
      NomMaterialGargantilha := RNomMaterialRotulo(Tabela.FieldByName('CODMATERIALGARGANTILHA').AsInteger);
      NomLinerGargantilha := RNomMaterialLiner(Tabela.FieldByName('CODLINERGARGANTILHA').AsInteger);
      ObsProduto:= Tabela.FieldByName('OBSPRODUTO').AsString;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDPropostaVendaAdicional(VpaDProposta : TRBDPropostaCorpo);
var
  VpfDVendaAdicional : TRBDPropostaVendaAdicional;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRP.SEQPRODUTO, PRP.CODPRODUTO, PRP.CODCOR, ' +
                               ' PRP.QTDPRODUTO, PRP.VALUNITARIO,PRP.VALTOTAL, PRP.DESUM,' +
                               ' Pro.C_Cod_Uni, PRO.C_NOM_PRO,'+
                               ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal ' +
                               ' from PROPOSTAVENDAADICIONAL PRP, CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe  '+
                               ' Where Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                               ' and PRE.I_COD_TAB = '+IntToStr(Varia.TabelaPreco)+
                               ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                               ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                               ' and Pro.c_ven_avu = ''S'''+
                               ' and PRE.I_COD_CLI  = 0 '+
                               ' and PRE.I_COD_TAM  = 0 '+
                               ' AND PRP.CODFILIAL = ' + IntToStr(VpaDProposta.CodFilial)+
                               ' and PRP.SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta)+
                               ' AND PRP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                               ' ORDER BY PRP.SEQITEM' );
  FreeTObjectsList(VpaDProposta.VendaAdicinal);
  While not tabela.eof do
  begin
    VpfDVendaAdicional := VpaDProposta.addVendaAdicional;
    with VpfDVendaAdicional do
    begin
      SeqProduto := Tabela.FieldByname('SEQPRODUTO').AsInteger;
      CodProduto := Tabela.FieldByname('CODPRODUTO').AsString;
      CodCor := Tabela.FieldByname('CODCOR').AsInteger;
      DesUM := Tabela.FieldByname('DESUM').AsString;
      NomCor := FunProdutos.RNomeCor(IntToStr(CodCor));
      NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
      QtdProduto := Tabela.FieldByname('QTDPRODUTO').AsFloat;
      ValUnitario := Tabela.FieldByname('VALUNITARIO').AsFloat;
      ValTotal := Tabela.FieldByname('VALTOTAL').AsFloat;
      UMOriginal := Tabela.FieldByName('C_Cod_Uni').Asstring;
      UMAnterior := DesUM;
      ValUnitarioOriginal := Tabela.FieldByName('VlrReal').AsFloat;
      UnidadesParentes.free;
      UnidadesParentes := FunProdutos.ValidaUnidade.UnidadesParentes(UMOriginal) ;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDSetorProposta(VpaDProposta : TRBDPropostaCorpo);
begin
  if VpaDProposta.CodSetor <> 0 then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select * from SETOR '+
                                 ' Where CODSETOR = '+IntToStr(VpaDProposta.CodSetor));
    VpaDProposta.NomSetor := Tabela.FieldByname('NOMSETOR').AsString;
    VpaDProposta.TipModeloProposta := Tabela.FieldByname('NUMMODELOEMAIL').AsInteger;
    VpaDProposta.DesRodapeSetor := Tabela.FieldByname('DESRODAPEPROPOSTA').AsString;
    VpaDProposta.DesEmailSetor := Tabela.FieldByname('DESEMAIL').AsString;
    Tabela.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.CarListaProposta(VpaDProposta: TRBDPropostaCorpo): TList;
begin
  Result := TList.Create;
  Result.Add(VpaDProposta);
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaProduto(VpaDProposta : TRBDPropostaCorpo) : String;
var
  VpfLaco : Integer;
  VpfDProdutoProposta : TRBDPropostaProduto;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROPOSTAPRODUTO '+
                                 ' Where CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 AND SEQITEMCHAMADO = 0 AND SEQPRODUTOCHAMADO = 0');
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoProposta := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByname('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByname('SEQITEM').AsInteger := VpfLaco + 1;
    Cadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDProdutoProposta.SeqProduto;
    Cadastro.FieldByname('CODPRODUTO').AsString := VpfDProdutoProposta.CodProduto;
    if VpfDProdutoProposta.CodCor <> 0 then
      Cadastro.FieldByname('CODCOR').AsInteger := VpfDProdutoProposta.CodCor
    else
      Cadastro.FieldByname('CODCOR').Clear;
    Cadastro.FieldByname('DESUM').AsString := VpfDProdutoProposta.UM;
    Cadastro.FieldByname('NOMCOR').AsString := VpfDProdutoProposta.DesCor;
    Cadastro.FieldByname('NOMPRODUTO').AsString := VpfDProdutoProposta.NomProduto;
    Cadastro.FieldByname('QTDPRODUTO').AsFloat := VpfDProdutoProposta.QtdProduto;
    Cadastro.FieldByname('VALUNITARIO').AsFloat := VpfDProdutoProposta.ValUnitario;
    Cadastro.FieldByname('VALTOTAL').AsFloat := VpfDProdutoProposta.ValTotal;
    Cadastro.FieldByname('VALDESCONTO').AsFloat := VpfDProdutoProposta.ValDesconto;
    Cadastro.FieldByname('PERIPI').AsFloat := VpfDProdutoProposta.PerIPI;
    Cadastro.FieldByname('VALIPI').AsFloat := VpfDProdutoProposta.ValIPI;
    Cadastro.FieldByname('NUMOPCAO').AsInteger := VpfDProdutoProposta.NumOpcao;
    Cadastro.FieldByName('DESOBSERVACAO').AsString:= copy(VpfDProdutoProposta.DesObservacaoProduto,1,450);
    if VpfDProdutoProposta.SeqItemChamado <> 0 then
      Cadastro.FieldByname('SEQITEMCHAMADO').AsInteger := VpfDProdutoProposta.SeqItemChamado
    else
      Cadastro.FieldByname('SEQITEMCHAMADO').clear;
    if VpfDProdutoProposta.SeqProdutoChamado <> 0 then
      Cadastro.FieldByName('SEQPRODUTOCHAMADO').AsInteger := VpfDProdutoProposta.SeqProdutoChamado
    else
      Cadastro.FieldByName('SEQPRODUTOCHAMADO').Clear;


    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaProdutoChamado(VpaDProposta: TRBDPropostaCorpo): string;
var
  VpfLaco: Integer;
  VpfDProdutosChamado : TRBDPropostaProdutoChamado;
begin
  result := '';
  PreparaProdutosChamado(VpaDProposta);
  ExecutaComandoSql(Aux,'Delete from PROPOSTAPRODUTOSCHAMADO ' +
                        'WHERE CODFILIAL = '+ IntToStr(VpaDProposta.CodFilial) +
                        ' AND SEQPROPOSTA = ' + IntToStr(VpaDProposta.SeqProposta));

  AdicionaSQLAbreTabela(Cadastro,'select * from PROPOSTAPRODUTOSCHAMADO '+
                                 ' Where CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQPRODUTOCHAMADO = 0 AND SEQITEMCHAMADO = 0 ');

  for VpfLaco := 0 to VpaDProposta.ProdutosChamado.Count - 1 do
  begin
    VpfDProdutosChamado := TRBDPropostaProdutoChamado(VpaDProposta.ProdutosChamado.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByname('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByname('SEQPRODUTOCHAMADO').AsInteger := VpfDProdutosChamado.SeqProdutoChamado;
    Cadastro.FieldByname('SEQITEMCHAMADO').AsInteger := VpfDProdutosChamado.SeqItemChamado;
    Cadastro.FieldByName('VALTOTAL').AsFloat := VpfDProdutosChamado.ValTotal;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaProdutoSemQtd(VpaDProposta : TRBDPropostaCorpo) : String;
var
  VpfLaco : Integer;
  VpfDProdutoSemQTD : TRBDPropostaProdutoSemQtd;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROPOSTAPRODUTOSEMQTD '+
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 ' );
  for VpfLaco := 0 to VpaDProposta.ProdutosSemQtd.Count - 1 do
  begin
    VpfDProdutoSemQTD := TRBDPropostaProdutoSemQtd(VpaDProposta.ProdutosSemQtd.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByname('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByname('SEQITEM').AsInteger := VpfLaco + 1;
    Cadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDProdutoSemQTD.SeqProduto;
    Cadastro.FieldByname('CODPRODUTO').AsString := VpfDProdutoSemQTD.CodProduto;
    Cadastro.FieldByname('DESUM').AsString := VpfDProdutoSemQTD.DesUM;
    Cadastro.FieldByname('NOMPRODUTO').AsString := VpfDProdutoSemQTD.NomProduto;
    Cadastro.FieldByname('VALUNITARIO').AsFloat := VpfDProdutoSemQTD.ValUnitario;
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DOS PRODUTOS SEM QTD DA PROPOSTA!!!'+#13+e.message;
        break;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaAmostra(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco: Integer;
  VpfDAmostraProposta: TRBDPropostaAmostra;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PROPOSTAAMOSTRA '+
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 ');
  for VpfLaco:= 0 to VpaDProposta.Amostras.Count-1 do
  begin
    VpfDAmostraProposta:= TRBDPropostaAmostra(VpaDProposta.Amostras.Items[VpfLaco]);
    VpfDAmostraProposta.SeqItem := VpfLaco+1;
    Cadastro.Insert;

    Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDProposta.CodFilial;
    Cadastro.FieldByName('SEQPROPOSTA').AsInteger:= VpaDProposta.SeqProposta;
    Cadastro.FieldByName('SEQITEM').AsInteger:=VpfDAmostraProposta.SeqItem;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger:= VpfDAmostraProposta.CodAmostra;
    Cadastro.FieldByName('CODCOR').AsInteger:= VpfDAmostraProposta.CodCor;
    Cadastro.FieldByName('NOMAMOSTRA').AsString:= VpfDAmostraProposta.NomAmostra;
    Cadastro.FieldByName('NOMCOR').AsString:= VpfDAmostraProposta.NomCor;
    Cadastro.FieldByName('QTDAMOSTRA').AsFloat:= VpfDAmostraProposta.QtdAmostra;
    Cadastro.FieldByName('VALUNITARIO').AsFloat:= VpfDAmostraProposta.ValUnitario;
    Cadastro.FieldByName('VALTOTAL').AsFloat:= VpfDAmostraProposta.ValTotal;

    try
      Cadastro.Post;
    except
      on E:Exception do
      begin
        Result:= 'ERRO NA GRAVAÇÃO DAS AMOSTRA DA PROPOSTA!!!'#13+E.Message;
        Break;
      end;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaCondicaoPagamento(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco: Integer;
  VpfDCondicaoPagamento : TRBDPropostaCondicaoPagamento;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from PROPOSTACONDICAOPAGAMENTO'+
                        ' WHERE CODFILIAL = '+ IntToStr(VpaDProposta.CodFilial) +
                        ' AND SEQPROPOSTA = ' + IntToStr(VpaDProposta.SeqProposta));

  AdicionaSQLAbreTabela(Cadastro,'select * from PROPOSTACONDICAOPAGAMENTO '+
                                 ' Where CODFILIAL = 0 AND SEQPROPOSTA = 0 AND CODCONDICAO = 0');

  for VpfLaco := 0 to VpaDProposta.CondicaoPagamento.Count - 1 do
  begin
    VpfDCondicaoPagamento := TRBDPropostaCondicaoPagamento(VpaDProposta.CondicaoPagamento.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByname('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByname('CODCONDICAO').AsInteger := VpfDCondicaoPagamento.CodCondicao;
    Cadastro.FieldByname('NOMCONDICAO').AsString := VpfDCondicaoPagamento.NomCondicao;
    if VpfDCondicaoPagamento.IndAprovado then
      Cadastro.FieldByName('INDAPROVADO').AsString:= 'S'
    else
      Cadastro.FieldByName('INDAPROVADO').AsString:= 'N';

    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaParcelas(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco: Integer;
  VpfDParcelas : TRBDPropostaParcelas;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from PROPOSTAPARCELAS '+
                        ' Where CODFILIAL =  ' +IntToStr(VpaDProposta.CodFilial)+
                        ' AND SEQPROPOSTA = '+IntToStr(VpaDProposta.SeqProposta));

  AdicionaSQLAbreTabela(Cadastro,'select * from PROPOSTAPARCELAS '+
                                 ' Where CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0');

  for VpfLaco := 0 to VpaDProposta.Parcelas.Count - 1 do
  begin
    VpfDParcelas := TRBDPropostaParcelas(VpaDProposta.Parcelas.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByname('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByname('SEQITEM').AsInteger := VpfLaco+1;
    if VpfDParcelas.CodFormaPagamento <> 0 then
      Cadastro.FieldByname('CODFORMAPAGAMENTO').AsInteger := VpfDParcelas.CodFormaPagamento
    else
      Cadastro.FieldByname('CODFORMAPAGAMENTO').AsInteger := VpaDProposta.CodFormaPagamento;
    Cadastro.FieldByname('VALPAGAMENTO').AsFloat := VpfDParcelas.ValPagamento;
    Cadastro.FieldByname('DESCONDICAO').AsString := VpfDParcelas.DesCondicao;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaLocacao(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco: Integer;
  VpfDPropostaLocacao: TRBDPropostaLocacaoCorpo;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PROPOSTALOCACAO '+
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 ' );
  for VpfLaco:= 0 to VpaDProposta.Locacoes.Count - 1 do
  begin
    VpfDPropostaLocacao:= TRBDPropostaLocacaoCorpo(VpaDProposta.Locacoes.Items[VpfLaco]);

    Cadastro.Insert;
    VpfDPropostaLocacao.SeqItem:= VpfLaco + 1;
    VpfDPropostaLocacao.CodFilial:= VpaDProposta.CodFilial;
    VpfDPropostaLocacao.SeqProposta:= VpaDProposta.SeqProposta;
    Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDProposta.CodFilial;
    Cadastro.FieldByName('SEQPROPOSTA').AsInteger:= VpaDProposta.SeqProposta;
    Cadastro.FieldByName('SEQITEM').AsInteger:= VpfDPropostaLocacao.SeqItem;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger:= VpfDPropostaLocacao.SeqProduto;
    Cadastro.FieldByName('DESEMAIL').AsString:= VpfDPropostaLocacao.DesEmail;

    try
      Cadastro.Post;
      Result:= GravaDLocacaoFranquia(VpfDPropostaLocacao);
      if Result <> '' then
        Break;
    except
      on E:Exception do
      begin
        Result:= 'ERRO NA GRAVAÇÃO DAS LOCAÇÕES DA PROPOSTA!!!'#13+E.Message;
        Break;
      end;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaMaterialAcabamento(
  VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco: Integer;
  VpfDMaterialAcabamento : TRBDPropostaMaterialAcabamento;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from PROPOSTAMATERIALACABAMENTO'+
                        ' WHERE CODFILIAL = '+ IntToStr(VpaDProposta.CodFilial) +
                        ' AND SEQPROPOSTA = ' + IntToStr(VpaDProposta.SeqProposta));

  AdicionaSQLAbreTabela(Cadastro,'select * from PROPOSTAMATERIALACABAMENTO '+
                                 ' Where CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQPRODUTO = 0');

  for VpfLaco := 0 to VpaDProposta.MaterialAcabamento.Count - 1 do
  begin
    VpfDMaterialAcabamento := TRBDPropostaMaterialAcabamento(VpaDProposta.MaterialAcabamento.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByname('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDMaterialAcabamento.SeqProduto;
    Cadastro.FieldByname('CODPRODUTO').AsString := VpfDMaterialAcabamento.CodProduto;
    Cadastro.FieldByname('NOMPRODUTO').AsString := VpfDMaterialAcabamento.NomProduto;
    Cadastro.FieldByname('DESUM').AsString := VpfDMaterialAcabamento.UM;
    Cadastro.FieldByname('QTDPRODUTO').AsInteger := VpfDMaterialAcabamento.Quantidade;
    Cadastro.FieldByname('VALUNITARIO').AsFloat := VpfDMaterialAcabamento.ValUnitario;
    Cadastro.FieldByname('VALTOTAL').AsFloat := VpfDMaterialAcabamento.ValTotal;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDPropostaServico(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco: Integer;
  VpfDPropostaServico: TRBDPropostaServico;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PROPOSTASERVICO '+
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 AND SEQITEMCHAMADO = 0 AND SEQPRODUTOCHAMADO = 0 ' );
  for VpfLaco:= 0 to VpaDProposta.Servicos.Count - 1 do
  begin
    VpfDPropostaServico:= TRBDPropostaServico(VpaDProposta.Servicos.Items[VpfLaco]);

    Cadastro.Insert;
    VpfDPropostaServico.SeqItem:= VpfLaco + 1;
    Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDProposta.CodFilial;
    Cadastro.FieldByName('SEQPROPOSTA').AsInteger:= VpaDProposta.SeqProposta;
    Cadastro.FieldByName('SEQITEM').AsInteger:= VpfDPropostaServico.SeqItem;
    Cadastro.FieldByName('CODEMPRESASERVICO').AsInteger:= VpfDPropostaServico.CodEmpresaServico;
    Cadastro.FieldByName('CODSERVICO').AsInteger:= VpfDPropostaServico.CodServico;
    Cadastro.FieldByName('QTDSERVICO').AsFloat:= VpfDPropostaServico.QtdServico;
    Cadastro.FieldByName('VALUNITARIO').AsFloat:= VpfDPropostaServico.ValUnitario;
    Cadastro.FieldByName('VALTOTAL').AsFloat:= VpfDPropostaServico.ValTotal;

    if VpfDPropostaServico.SeqItemChamado <> 0 then
      Cadastro.FieldByname('SEQITEMCHAMADO').AsInteger := VpfDPropostaServico.SeqItemChamado
    else
      Cadastro.FieldByname('SEQITEMCHAMADO').clear;
    if VpfDPropostaServico.SeqProdutoChamado <> 0 then
      Cadastro.FieldByName('SEQPRODUTOCHAMADO').AsInteger := VpfDPropostaServico.SeqProdutoChamado
    else
      Cadastro.FieldByName('SEQPRODUTOCHAMADO').Clear;

    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDLocacaoFranquia(VpaDPropostaLocacao: TRBDPropostaLocacaoCorpo): String;
var
  VpfLaco: Integer;
  VpfLocacaoFranquia: TRBDPropostaLocacaoFranquia;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro2,'SELECT * FROM PROPOSTALOCACAOFRANQUIA');
  for VpfLaco:= 0 to VpaDPropostaLocacao.Franquias.Count - 1 do
  begin
    VpfLocacaoFranquia:= TRBDPropostaLocacaoFranquia(VpaDPropostaLocacao.Franquias.Items[VpfLaco]);

    Cadastro2.Insert;
    VpfLocacaoFranquia.SeqItemFranquia:= VpfLaco+1;

    Cadastro2.FieldByName('CODFILIAL').AsInteger:= VpaDPropostaLocacao.CodFilial;
    Cadastro2.FieldByName('SEQPROPOSTA').AsInteger:= VpaDPropostaLocacao.SeqProposta;
    Cadastro2.FieldByName('SEQITEM').AsInteger:= VpaDPropostaLocacao.SeqItem;
    Cadastro2.FieldByName('SEQITEMFRANQUIA').AsInteger:= VpfLocacaoFranquia.SeqItemFranquia;
    Cadastro2.FieldByName('QTDFRAQUIAPB').AsInteger:= VpfLocacaoFranquia.QtdFranquiaPB;
    Cadastro2.FieldByName('QTDFRANQUIACOLOR').AsInteger:= VpfLocacaoFranquia.QtdFranquiaColor;
    Cadastro2.FieldByName('VALFRANQUIA').AsFloat:= VpfLocacaoFranquia.ValFranquia;
    Cadastro2.FieldByName('VALEXCEDENTEPB').AsFloat:= VpfLocacaoFranquia.ValExcedentePB;
    Cadastro2.FieldByName('VALEXCEDENTECOLOR').AsFloat:= VpfLocacaoFranquia.ValExcedenteColor;

    try
      Cadastro2.Post;
    except
      on E:Exception do
      begin
        Result:= 'ERRO NA GRAVAÇÃO DAS FRANQUIAS DA LOCAÇÃO!!!'#13+E.Message;
        Break;
      end;
    end;
  end;
  Cadastro2.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDMaquinaCliente(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco : Integer;
  VpfDMaquinaCliente : TRBDPropostaMaquinaCliente;
begin
  AdicionaSQLAbreTabela(Cadastro,' SELECT * FROM PROPOSTAPRODUTOCLIENTE '+
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 ' );
  for VpfLaco := 0 to VpaDProposta.MaquinasCliente.Count - 1 do
  begin
    VpfDMaquinaCliente := TRBDPropostaMaquinaCliente(VpaDProposta.MaquinasCliente.Items[VpfLaco]);
    VpfDMaquinaCliente.SeqItem := VpfLaco + 1;
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByName('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfDMaquinaCliente.SeqItem;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDMaquinaCliente.SeqProduto;
    if VpfDMaquinaCliente.CodEmbalagem <> 0 then
      Cadastro.FieldByName('CODEMBALAGEM').AsInteger := VpfDMaquinaCliente.CodEmbalagem;
    if VpfDMaquinaCliente.CodAplicacao <> 0 then
      Cadastro.FieldByName('CODAPLICACAO').AsInteger := VpfDMaquinaCliente.CodAplicacao;
    Cadastro.FieldByName('DESPRODUCAO').AsString := VpfDMaquinaCliente.DesProducao;
    Cadastro.FieldByName('DESSENTIDOPASSAGEM').AsString := VpfDMaquinaCliente.DesSentidoPassagem;
    Cadastro.FieldByName('DESDIAMETROTUBO').AsString := VpfDMaquinaCliente.DesDiametroCubo;
    Cadastro.FieldByName('DESOBSERVACAO').AsString := VpfDMaquinaCliente.DesObservacao;
    Cadastro.post;
    Result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDProdutoRotulados(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco : Integer;
  VpfDProRotulado : TRBDPropostaProdutoASerRotulado;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROPOSTAPRODUTOROTULADO '+
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 ' );
  for VpfLaco := 0 to VpaDProposta.ProdutosASeremRotulados.Count - 1 do
  begin
    VpfDProRotulado := TRBDPropostaProdutoASerRotulado(VpaDProposta.ProdutosASeremRotulados.Items[VpfLaco]);
    VpfDProRotulado.SeqItem := VpfLaco + 1;
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByName('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfDProRotulado.SeqItem;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProRotulado.SeqProduto;
    if VpfDProRotulado.CodFormatoFrasco <> 0 then
      Cadastro.FieldByName('CODFORMATOFRASCO').AsInteger := VpfDProRotulado.CodFormatoFrasco;
    if VpfDProRotulado.CodMaterialFrasco <> 0 then
    Cadastro.FieldByName('CODMATERIALFRASCO').AsInteger := VpfDProRotulado.CodMaterialFrasco;
    Cadastro.FieldByName('ALTFRASCO').AsInteger := VpfDProRotulado.AltFrasco;
    Cadastro.FieldByName('LARFRASCO').AsInteger := VpfDProRotulado.LarFrasco;
    Cadastro.FieldByName('PROFRASCO').AsInteger := VpfDProRotulado.ProfundidadeFrasco;
    Cadastro.FieldByName('DIAFRASCO').AsInteger := VpfDProRotulado.DiametroFrasco;
    if VpfDProRotulado.CodMaterialRotulo <> 0 then
      Cadastro.FieldByName('CODMATERIALROTULO').AsInteger := VpfDProRotulado.CodMaterialRotulo;
    if VpfDProRotulado.CodLinerRotulo <> 0 then
      Cadastro.FieldByName('CODLINERROTULO').AsInteger := VpfDProRotulado.CodLinerRotulo;
    Cadastro.FieldByName('LARROTULO').AsInteger := VpfDProRotulado.LarRotulo;
    Cadastro.FieldByName('ALTROTULO').AsInteger := VpfDProRotulado.AltRotulo;
    if VpfDProRotulado.CodMaterialContraRotulo <> 0 then
      Cadastro.FieldByName('CODMATERIALCONTRAROTULO').AsInteger := VpfDProRotulado.CodMaterialContraRotulo;
    if VpfDProRotulado.CodLinerContraRotulo <> 0 then
      Cadastro.FieldByName('CODLINERCONTRAROTULO').AsInteger := VpfDProRotulado.CodLinerContraRotulo;
    Cadastro.FieldByName('LARCONTRAROTULO').AsInteger := VpfDProRotulado.LarContraRotulo;
    Cadastro.FieldByName('ALTCONTRAROTULO').AsInteger := VpfDProRotulado.AltContraRotulo;
    if VpfDProRotulado.CodMaterialGargantilha <> 0 then
      Cadastro.FieldByName('CODMATERIALGARGANTILHA').AsInteger := VpfDProRotulado.CodMaterialGargantilha;
    if VpfDProRotulado.CodLinerGargantilha <> 0 then
      Cadastro.FieldByName('CODLINERGARGANTILHA').AsInteger := VpfDProRotulado.CodLinerGargantilha;
    Cadastro.FieldByName('ALTGARGANTILHA').AsInteger := VpfDProRotulado.AltGargantilha;
    Cadastro.FieldByName('LARGARGANTILHA').AsInteger := VpfDProRotulado.LarGargantilha;
    Cadastro.FieldByName('QTDFRASCOHORA').AsFloat := VpfDProRotulado.QtdFrascosHora;
    Cadastro.FieldByName('OBSPRODUTO').AsString:= VpfDProRotulado.ObsProduto;
    Cadastro.FieldByName('DESPROROTULADO').AsString:= RTextoProdutoRotulados(VpfDProRotulado);
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DO PRODUTO ROTULADO DA PROPOSTA!!!'#13+e.message;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDVendaAdicional(VpaDProposta: TRBDPropostaCorpo): String;
var
  VpfLaco : Integer;
  VpfDVendaAdicional : TRBDPropostaVendaAdicional;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROPOSTAVENDAADICIONAL '+
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQITEM = 0 ' );
  for VpfLaco := 0 to VpaDProposta.VendaAdicinal.Count - 1 do
  begin
    VpfDVendaAdicional := TRBDPropostaVendaAdicional(VpaDProposta.VendaAdicinal.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDProposta.CodFilial;
    Cadastro.FieldByname('SEQPROPOSTA').AsInteger := VpaDProposta.SeqProposta;
    Cadastro.FieldByname('SEQITEM').AsInteger := VpfLaco + 1;
    Cadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDVendaAdicional.SeqProduto;
    Cadastro.FieldByname('CODPRODUTO').AsString := VpfDVendaAdicional.CodProduto;
    if VpfDVendaAdicional.CodCor <> 0 then
      Cadastro.FieldByname('CODCOR').AsInteger := VpfDVendaAdicional.CodCor
    else
      Cadastro.FieldByname('CODCOR').Clear;
    Cadastro.FieldByname('DESUM').AsString := VpfDVendaAdicional.DesUM;
    Cadastro.FieldByname('QTDPRODUTO').AsFloat := VpfDVendaAdicional.QtdProduto;
    Cadastro.FieldByname('VALUNITARIO').AsFloat := VpfDVendaAdicional.ValUnitario;
    Cadastro.FieldByname('VALTOTAL').AsFloat := VpfDVendaAdicional.ValTotal;
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DA VENDA ADICIONAL!!!'+#13+e.message;
        break;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaCabecalhoEmail(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial;VpaOpcao : Integer );
var
  VpfOpcao : String;
begin
  if VpaOpcao <> 0 then
    VpfOpcao := 'Opção '+IntToStr(VpaOpcao);
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDProposta.CodFilial)+' - Proposta : '+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <a href="http://'+VpaDFilial.DesSite+ '">');
  VpaTexto.add('      <IMG src="cid:'+IntToStr(VpaDProposta.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' border = 0>');
  VpaTexto.add('    </a></td> <td bgcolor="#'+varia.CRMCorClaraEmail+'"> <font size = "2">');
  VpaTexto.add('    <b>'+VpaDFilial.NomFantasia+ '.</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesEndereco+'              Bairro : '+VpaDFilial.DesBairro);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF+ '                CEP : '+VpaDFilial.DesCep);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+VpaDFilial.DesFone +'         -             e-mail :'+VpaDFilial.DesEmailComercial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+VpaDFilial.DesSite+'">'+VpaDFilial.DesSite);
  VpaTexto.add('    </td><td bgcolor="#'+varia.CRMCorClaraEmail+'">' );
  VpaTexto.add('    <center>');
  VpaTexto.add('    <b>Proposta');
  VpaTexto.add('    <br> '+formatFloat('###,###,##0',VpaDProposta.SeqProposta)+'');
  VpaTexto.add('    <br><br> '+VpfOpcao+' </b>');
  VpaTexto.add('    </center>');
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('    <br>');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaCabecalhoEmailEmAnexo(VpaTexto: TStrings;VpaDProposta: TRBDPropostaCorpo; VpaDFilial: TRBDFilial;VpaCorpoEmail : String);
var
  Vpfbmppart: TIdAttachmentfile;
begin
  if (Varia.CNPJFilial <> CNPJ_Kabran) then
    exit;
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDProposta.CodFilial)+' - Proposta : '+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  if FileExists(Varia.PathVersoes + '\cabecalhoemail' + IntToStr(VpaDProposta.CodFilial) + '.JPG') then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\cabecalhoemail'+inttoStr(VpaDProposta.CodFilial)+'.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := 'cabecalhoemail' + inttoStr(VpaDProposta.CodFilial)+'.jpg';
    Vpfbmppart.DisplayName := 'cabecalhoemail' + inttoStr(VpaDProposta.CodFilial)+'.jpg';
    VpaTexto.add('<table width="100%" cellpadding="0" cellspacing="0" > ');
    VpaTexto.add('<tr>');
    VpaTexto.add('  <td background="cid:cabecalhoemail' + IntToStr(VpaDProposta.CodFilial) + '.JPG" height="149">&nbsp;</td>');
    VpaTexto.add('</tr>');
    VpaTexto.add('</table>');
  end;
  VpaTexto.add('<table width=100%  border=0 cellpadding="0" cellspacing="0" ><tr>');
  VpaTexto.add('<td width=100% bgcolor=#FFFFFF ><font face="Verdana" size="3">   ');
  VpaTexto.add('   <br> ');
  VpaTexto.add('   <br> ' + VpaCorpoEmail);
  VpaTexto.add('   <br> ');
  VpaTexto.add('</tr></table> ');

end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaCabecalhoEmailEmAnexoEficacia(VpaTexto: TStrings; VpaDProposta: TRBDPropostaCorpo; VpaDFilial: TRBDFilial;VpaCorpoEmail : String;VpaDCliente : TRBDCliente);
var
  Vpfbmppart: TIdAttachmentfile;
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDProposta.CodFilial)+' - Proposta : '+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.add('</title>');
  VpaTexto.add('<body> <center>');
  VpaTexto.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
  VpaTexto.Add('<tr>');
  VpaTexto.add('<td>');
  VpaTexto.Add('<table width=100%  border=0 >');
  VpaTexto.add(' <tr>');
  VpaTexto.Add('  <td width=40%>');
  VpaTexto.add('    <a > <img src="cid:'+IntToStr(VpaDProposta.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  <td width=20% align="center" > <font face="Verdana" size="5"><b>Proposta '+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="Sistema de Gestao Desenvolvido por Eficacia Sistemas e Consultoria" href="http://www.eficaciaconsultoria.com.br"> <img src="cid:efi.jpg" border="0"');
  VpaTexto.add('  </td>');
  VpaTexto.Add('  </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.Add('</table>');
  VpaTexto.add('<br>');
  VpaTexto.Add('<br>');
  VpaTexto.add('<table width=100%  border=0 cellpadding="0" cellspacing="0" >');
  VpaTexto.Add(' <tr>');
  VpaTexto.add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
  VpaTexto.Add('   <br> <left>');
  VpaTexto.add('   '+VpaCorpoEmail);
  VpaTexto.Add('   <br></center>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.Add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="3">');
  VpaTexto.add('   <br><center>');
  VpaTexto.Add('   <br>Cliente : '+RetiraAcentuacao(VpaDCliente.NomCliente) );
  VpaTexto.add('   <br>CNPJ :'+VpaDCliente.CGC_CPF);
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr><tr>');
  VpaTexto.Add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
  VpaTexto.add('   <br><center>');
  VpaTexto.Add('   <br>Data Emissao : '+FormatDateTime('DD/MM/YYY',VpaDProposta.DatProposta));
  VpaTexto.Add('   <br>Vendedor : '+FunCotacao.RNomVendedor(VpaDProposta.CodVendedor));
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add(' </tr>');
  VpaTexto.Add(' </tr><tr>');
  VpaTexto.add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="3">');
  VpaTexto.Add('   <br><center>');
  VpaTexto.add('   <br><address><a href="http://'+varia.SiteFilial+'">'+Varia.NomeFilial+'</a>  </address>');
  VpaTexto.Add('   <br> '+Varia.FoneFilial);
  VpaTexto.add('   <br>');
  VpaTexto.Add('   <br>');
  VpaTexto.add('   <br>');
  VpaTexto.Add(' </tr><tr>');
  VpaTexto.add('</table>');
  VpaTexto.Add('</td>');
  VpaTexto.add('</tr>');
  VpaTexto.Add('</table>');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaCabecalhoEmailModelo2(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDProposta.CodFilial)+' - Proposta : '+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' >');
  VpaTexto.add('    <a >');
  VpaTexto.add('      <IMG src="cid:'+IntToStr(VpaDProposta.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' border = 0>');
  VpaTexto.add('    </td> <td>');
  VpaTexto.add('    <b>'+VpaDFilial.NomFantasia);
  VpaTexto.add('    </b><br>');
  VpaTexto.add('    '+VpaDFilial.DesEndereco);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+VpaDFilial.DesFone);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+VpaDFilial.DesSite+'">'+VpaDFilial.DesSite);
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaCabecalhoEmailHomero(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDProposta.CodFilial)+' - Proposta : '+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' >');
  VpaTexto.add('    <a >');
  VpaTexto.add('      <IMG src="cid:'+IntToStr(VpaDProposta.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' border = 0>');
  VpaTexto.add('    </td> <td align="right"> <font color="blue">');
  VpaTexto.add('    <b>S</b>istemas <b>D</b>igitais de <b>M</b>onitoramento - <b>S</b>istemas <b>I</b>nteligentes de <b>A</b>larme');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <b>C</b>ontroles de <b>A</b>cesso - <b>C</b>entrais de <b>I</b>nterfone - <b>C</b>ercas <b>E</b>létricas');
  VpaTexto.add('    <br> ');
  VpaTexto.add('    <b>P</b>ortões <b>E</b>letrônicos - <b>P</b>rojetos <b>E</b>speciais </font>');
  VpaTexto.add('    <br> ');
  VpaTexto.add('    <br><b> ');
  VpaTexto.add('    '+varia.EnderecoFilial+' - '+Varia.BairroFilial+' - ' +VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF);
  VpaTexto.add('    <br>');
  VpaTexto.add('    (1.a rua à direita após a CREMER) ');
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+VpaDFilial.DesFone);
  VpaTexto.add('    <br>');
  VpaTexto.add('    <font color="blue">'+Varia.SiteFilial+'</font></b>');
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('<br> ');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaCabecalhoEmailRotuladoras(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDFilial : TRBDFilial);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDProposta.CodFilial)+' - Proposta : '+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.add('</title>');
  VpaTexto.add('<head>');
  VpaTexto.add('<left>');
  VpaTexto.add('<a href="http://'+VpaDFilial.DesSite+'">');
  VpaTexto.add('<IMG src="c:\11.jpg" width='+IntToStr(varia.CRMTamanhoLogo div 2)+' height = '+IntToStr(Varia.CRMAlturaLogo div 2)+' border = 0>');
//  VpaTexto.add('<IMG src="cid:'+IntToStr(VpaDProposta.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' border = 0>');
  VpaTexto.add('</a>');
  VpaTexto.add('</left>');
  VpaTexto.add('<hr>');
  VpaTexto.add('</head>');
  VpaTexto.add('<body>');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailProposta(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial;VpaOpcao : Integer);
var
  VpfDProdutoPro : TRBDPropostaProduto;
  VpfDServicoPro : TRBDPropostaServico;
  VpfLaco, VpfLacoDescricao : Integer;
  Vpfbmppart : TIdAttachmentfile;
  VpfValOpcao,VpfDescontoOpcao : Double;
  VpfDescricaoTecnica: TStringList;
begin
  VpfDescricaoTecnica := TStringList.Create;
  OrdenaItensPelaOpcao(VpaDProposta);
  Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDProposta.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDProposta.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDProposta.CodFilial)+'.jpg';

  MontaCabecalhoEmail(VpaTexto,VpaDProposta,VpaDFilial,VpaOpcao);
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY - HH:MM:SS',VpaDProposta.DatProposta)+'</td>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Vendedor</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunCotacao.RNomVendedor(VpaDProposta.CodVendedor) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');

  VpaTexto.add('    <br>');
  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDProposta.CodCliente)+ '-'+VpaDCliente.NomCliente +' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Endere&ccedil;o</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesEndereco+'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Bairro</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesBairro +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cep</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CepCliente+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cidade</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesCidade+'/'+VpaDCliente.DesUF +'</td>');
  if VpaDCliente.TipoPessoa = 'F' Then
  begin
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CPF</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;RG</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.RG+'</td>');
  end
  else
  begin
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CNPJ</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF +'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Inscrição Estadual</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.InscricaoEstadual+'</td>');
  end;
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fone</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFone1 +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fax</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFax+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;e-mail</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDProposta.DesEmail+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Contato</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDProposta.NomContato+'</td>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Profissão</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunClientes.RNomProfissao(VpaDProposta.CodProfissao) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=7 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Produtos</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('        <td width="25%"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="-1"><b>&nbsp;Imagem</td>');
  VpaTexto.add('        <td colspan=6  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="-1"><b>Itens</td>');
  VpfValOpcao := 0;
  VpfDescontoOpcao :=0;
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoPro := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    if (VpfDProdutoPro.NumOpcao = VpaOpcao) then
    begin
      VpfValOpcao := VpfValOpcao + VpfDProdutoPro.ValTotal -VpfDProdutoPro.ValDesconto;
      VpfDescontoOpcao := VpfDescontoOpcao + VpfDProdutoPro.ValDesconto;
      if VpfDProdutoPro.PathFoto <> '' then
      begin
        if ExisteArquivo(varia.DriveFoto+VpfDProdutoPro.PathFoto) then
        begin
          Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.DriveFoto+VpfDProdutoPro.PathFoto);
          Vpfbmppart.ContentType := 'image/jpg';
          Vpfbmppart.ContentDisposition := 'inline';
          Vpfbmppart.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpfDProdutoPro.PathFoto);
          Vpfbmppart.DisplayName := RetornaNomArquivoSemDiretorio(VpfDProdutoPro.PathFoto);
        end
        else
          aviso('PRODUTO "'+VpfDProdutoPro.CodProduto+'-'+VpfDProdutoPro.NomProduto+ '".'#13'ARQUIVO INEXISTENTE!!!'#13'O arquivo "'+varia.DriveFoto+VpfDProdutoPro.PathFoto+'" não existe.');
      end;
      VpfDescricaoTecnica.Text := VpfDProdutoPro.desTecnica;
      VpaTexto.add('</tr><tr> ');
      if VpfDProdutoPro.PathFoto <> '' then
        VpaTexto.add('        <td width="25%" align="center"><font face="Verdana" size="-1"><IMG src="cid:'+RetornaNomArquivoSemDiretorio(VpfDProdutoPro.PathFoto)+'"></td>')
      else
        VpaTexto.add('        <td width="25%" align="center"><font face="Verdana" size="-1"></td>');
      VpaTexto.add('        <td colspan=6 > ');
      VpaTexto.add('        <table border=1 cellpadding="0" cellspacing="0" width=100%> ');
      VpaTexto.add('        <tr>');
      VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Nome</td>');
      VpaTexto.add('        <td width="05%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;UM</td>');
      VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
      VpaTexto.add('        </tr><tr>');
      VpaTexto.add('        <tr>');
      VpaTexto.add('        <td width="40%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.NomProduto+ '</td>');
      VpaTexto.add('        <td width="05%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.UM+'</td>');
      VpaTexto.add('	<td width="15%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProdutoPro.QtdProduto) +'</td>');
      VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfDProdutoPro.ValUnitario)+'</td>');
      VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDProdutoPro.ValTotal) +'</td>');
      VpaTexto.add('        </tr><tr>');
      VpaTexto.add('	<td colspan=5 align="center" bgcolor="#'+varia.CRMCorClaraemail+'">  <font face="Verdana" size="2"><b>Descrição Técnica</td>');
      VpaTexto.add('        </tr><tr>');
      if VpfDescricaoTecnica.Count > 0 then
        VpaTexto.add('	<td colspan=6 align="left" <font face="Verdana" size="-1">'+VpfDescricaoTecnica.Strings[0]+' <br>')
      else
        VpaTexto.add('	<td colspan=6 align="left" <font face="Verdana" size="-1"> <br>');
      for VpfLacoDescricao := 1 to VpfDescricaoTecnica.Count - 1 do
      begin
        VpaTexto.add(VpfDescricaoTecnica.Strings[VpfLacoDescricao]+' <br>');
      end;
      VpaTexto.add('        </td>');
      VpaTexto.add('        </tr>');
      VpaTexto.add('        </table>');
    end;
  end;

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  if VpaDProposta.Servicos.Count > 0 then
  begin
    VpaTexto.add('<table width="100%" border = 1>');
    VpaTexto.add('<tr>');
    VpaTexto.add('	<td colspan=4 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Serviços</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('      <td width="50%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Serviço</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
    VpaTexto.add('</tr><tr>');

    for VpfLaco := 0 to VpaDProposta.Servicos.Count - 1 do
    begin
      VpfDServicoPro := TRBDPropostaServico(VpaDProposta.Servicos.Items[VpfLaco]);
      VpaTexto.add('</tr><tr>');
      VpaTexto.add('  <td width="50%" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDServicoPro.CodServico)+'-'+VpfDServicoPro.NomServico+ '</td>');
      VpaTexto.add('  <td width="15%" align="right"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraQtd,VpfDServicoPro.QtdServico) +'</td>');
      VpaTexto.add('  <td width="20%" align="right"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraValorUnitario,VpfDServicoPro.ValUnitario)+'</td>');
      VpaTexto.add('  <td width="20%" align="right"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraValor,VpfDServicoPro.ValTotal) +'</td>');
    end;
    VpaTexto.add('  </tr>');
    VpaTexto.add('</table>');
    VpaTexto.add('<br>');
  end;


  if (VpaOpcao = 0)  or (VpaDProposta.Servicos.Count > 0) then
  begin
    VpaTexto.add('<table width="100%">');
    VpaTexto.add('<tr>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+RTextoAcrescimoDesconto(VpaDProposta)+'</td>');
    VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+RValorAcresicmodesconto(VpaDProposta)+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
    VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="4">&nbsp;'+FormatFloat(varia.MascaraValor,VpaDProposta.ValTotal)+'</td>');
    VpaTexto.add('</tr>');
    VpaTexto.add('</table><br>');
  end
  else
    if (VpaOpcao <> 0) then
    begin
      VpaTexto.add('<table width="100%">');
      VpaTexto.add('<tr>');
      VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Desconto</td>');
      VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDescontoOpcao)+'</td>');
      VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
      VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="4">&nbsp;'+FormatFloat(varia.MascaraValor,VpfValOpcao)+'</td>');
      VpaTexto.add('</tr>');
      VpaTexto.add('</table><br>');
    end;

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Condição de Pagamento</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomCondicaoPagamento(VpaDProposta.CodCondicaoPagamento) +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Forma de Pagamento</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomFormaPagamento(VpaDProposta.CodFormaPagamento));
  if config.CobrarFormaPagamento then
    VpaTexto.add('<br><font face="Verdana" size="-3">*Cobramos a taxa de R$ 2,50 por boleto bancário.');

  VpaTexto.add('</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('<br>');
  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Previsão Compra</td>');
  VpaTexto.add('	<td width="17%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY',VpaDProposta.DatPrevisaoCompra) +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Validade Proposta</td>');
  VpaTexto.add('	<td width="17%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY',VpaDProposta.DatValidade) +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Prazo Entrega</td>');
  VpaTexto.add('	<td width="21%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDProposta.QtdPrazoEntrega) +' dias</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpfDescricaoTecnica.Text := VpaDProposta.DesObservacao;
  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Observações</td>');
  VpaTexto.add('</tr><tr>');
  if VpfDescricaoTecnica.Count > 0 then
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+VpfDescricaoTecnica.Strings[0] +'<br>')
  else
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;');
  for Vpflaco := 1 to VpfDescricaoTecnica.count - 1 do
    VpaTexto.add(VpfDescricaoTecnica.strings[VpfLaco]+'<br>');
  VpaTexto.add('</td></tr>');
  VpaTexto.add('</table><br>');
  //rodape do setor
  VpfDescricaoTecnica.Text := VpaDProposta.DesRodapeSetor;
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]);

  VpfDescricaoTecnica.Text := Sistema.RRodapeCRM(VpaDProposta.CodFilial);
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]);

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');

  VpfDescricaoTecnica.free;
end;

procedure TRBFuncoesProposta.MontaEmailPropostaModelo1(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial;VpaOpcao : Integer);
var
  VpfDProdutoPro : TRBDPropostaProduto;
  VpfDServicoPro : TRBDPropostaServico;
  VpfDescricaoTecnica : TStringList;
  VpfLaco, VpfLacoDescricao : Integer;
  Vpfbmppart : TIdAttachmentfile;
  VpfValOpcao,VpfDescontoOpcao : Double;
begin
  VpfDescricaoTecnica := TStringList.create;
  Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDProposta.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDProposta.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDProposta.CodFilial)+'.jpg';

  MontaCabecalhoEmail(VpaTexto,VpaDProposta,VpaDFilial,VpaOpcao);
  VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY - HH:MM:SS',VpaDProposta.DatProposta)+'</td>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Vendedor</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunCotacao.RNomVendedor(VpaDProposta.CodVendedor) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');

  VpaTexto.add('    <br>');
  VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  VpaTexto.add('	<td colspan="3" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDProposta.CodCliente)+ '-'+VpaDCliente.NomCliente +' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('        <td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Contato</td><td width="40%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDProposta.NomContato+'</td>');
  VpaTexto.add('        <td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fone</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFone1 +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

                                  
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=6 align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>Produtos</td>');
  VpaTexto.add('</tr><tr> ');
  VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Nome</td>');
  VpaTexto.add('        <td width="05%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;UM</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('</tr>');
  VpfDescontoOpcao :=0;
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoPro := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    VpfDescontoOpcao := VpfDescontoOpcao + VpfDProdutoPro.ValDesconto;
    VpaTexto.add('    <td width="40%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.NomProduto+ '</td>');
    VpaTexto.add('    <td width="05%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.UM+'</td>');
    VpaTexto.add('	<td width="15%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProdutoPro.QtdProduto) +'</td>');
    VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfDProdutoPro.ValUnitario)+'</td>');
    VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDProdutoPro.ValTotal) +'</td>');
    VpaTexto.add('        </tr><tr>');
  end;

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  if VpaDProposta.Servicos.Count > 0 then
  begin
    VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width="100%" >');
    VpaTexto.add('<tr>');
    VpaTexto.add('	<td colspan=4 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Serviços</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('      <td width="50%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Serviço</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
    VpaTexto.add('</tr><tr>');

    for VpfLaco := 0 to VpaDProposta.Servicos.Count - 1 do
    begin
      VpfDServicoPro := TRBDPropostaServico(VpaDProposta.Servicos.Items[VpfLaco]);
      VpaTexto.add('</tr><tr>');
      VpaTexto.add('  <td width="50%" align="left"><font face="Verdana" size="-1">'+VpfDServicoPro.NomServico+ '</td>');
      VpaTexto.add('  <td width="15%" align="right"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraQtd,VpfDServicoPro.QtdServico) +'</td>');
      VpaTexto.add('  <td width="20%" align="right"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraValorUnitario,VpfDServicoPro.ValUnitario)+'</td>');
      VpaTexto.add('  <td width="20%" align="right"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraValor,VpfDServicoPro.ValTotal) +'</td>');
    end;
    VpaTexto.add('  </tr>');
    VpaTexto.add('</table>');
  end;


  if (VpaOpcao = 0)  or (VpaDProposta.Servicos.Count > 0) then
  begin
    VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
    VpaTexto.add('<tr>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+RTextoAcrescimoDesconto(VpaDProposta)+'</td>');
    VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+RValorAcresicmodesconto(VpaDProposta)+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
    VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="4">&nbsp;'+FormatFloat(varia.MascaraValor,VpaDProposta.ValTotal)+'</td>');
    VpaTexto.add('</tr>');
    VpaTexto.add('</table><br>');
  end
  else
    if (VpaOpcao <> 0) then
    begin
      VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
      VpaTexto.add('<tr>');
      VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Desconto</td>');
      VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDescontoOpcao)+'</td>');
      VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
      VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="4">&nbsp;'+FormatFloat(varia.MascaraValor,VpfValOpcao)+'</td>');
      VpaTexto.add('</tr>');
      VpaTexto.add('</table><br>');
    end;

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Condição de Pagamento</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomCondicaoPagamento(VpaDProposta.CodCondicaoPagamento) +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Forma de Pagamento</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomFormaPagamento(VpaDProposta.CodFormaPagamento));
  if config.CobrarFormaPagamento then
    VpaTexto.add('<br><font face="Verdana" size="-3">*Cobramos a taxa de R$ 2,50 por boleto bancário.');
  VpaTexto.add('</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');


  VpfDescricaoTecnica.Text := VpaDProposta.DesObservacao;
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Observações</td>');
  VpaTexto.add('</tr><tr>');
  if VpfDescricaoTecnica.Count > 0 then
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+VpfDescricaoTecnica.Strings[0] +'<br>')
  else
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;');
  for Vpflaco := 1 to VpfDescricaoTecnica.count - 1 do
    VpaTexto.add(VpfDescricaoTecnica.strings[VpfLaco]+'<br>');
  VpaTexto.add('</td></tr>');
  VpaTexto.add('</table><br>');
  //rodape do setor
  VpfDescricaoTecnica.Text := VpaDProposta.DesRodapeSetor;
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]);

  VpfDescricaoTecnica.Text := Sistema.RRodapeCRM(VpaDProposta.CodFilial);
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]);

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');

  VpfDescricaoTecnica.free;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailPropostaModelo2(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
var
  VpfDProdutoPro : TRBDPropostaProduto;
  VpfDServico : TRBDPropostaServico;
  VpfDescricaoTecnica : TStringList;
  VpfLaco : Integer;
  Vpfbmppart : TIdAttachmentfile;
begin
  VpfDescricaoTecnica := TStringList.create;
  Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDProposta.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDProposta.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDProposta.CodFilial)+'.jpg';


  MontaCabecalhoEmailModelo2(VpaTexto,VpaDProposta,VpaDFilial);
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td>');
  VpaTexto.add('    <left>');
  VpaTexto.add('    '+varia.CidadeFilial+',' +IntToStr(dia(VpaDProposta.DatProposta))+' de '+TextoMes(VpaDProposta.DatProposta,false)+ ' de '+IntToStr(ano(VpaDProposta.DatProposta)) );
  VpaTexto.add('    </left>');
  VpaTexto.add('    </td><td>');
  VpaTexto.add('    <right><b> Orçamento :  '+formatFloat('###,###,##0',VpaDProposta.SeqProposta)+'</h2>');
  VpaTexto.add('    </right>');
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('<br>');
  VpaTexto.add('<br> ');

  VpaTexto.add('Para : '+IntToStr(VpaDCliente.CodCliente)+ '-'+VpaDCliente.NomCliente );
  if VpaDCliente.TipoPessoa = 'J' Then
  Begin
    VpaTexto.add('<br> ');
    VpaTexto.add('A/C : '+VpaDProposta.NomContato);
  end;
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br>Segue cotação dos produtos solicitados, sendo : ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');


  if VpaDProposta.Servicos.Count > 0 then
  begin
    VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%> ');
    VpaTexto.add('<tr>');
    VpaTexto.add('  <td width="15%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
    VpaTexto.add('  <td width="40%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Descrição Serviço</td>');
    VpaTexto.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
    VpaTexto.add('  <td width="25%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('<tr>');
    for VpfLaco := 0 to VpaDProposta.Servicos.Count - 1 do
    begin
      VpfDServico := TRBDPropostaServico(VpaDProposta.Servicos.Items[VpfLaco]);
      VpaTexto.add('	<td width="15%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDServico.QtdServico) +'</td>');
      VpaTexto.add('    <td width="40%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDServico.NomServico+ '</td>');
      VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDServico.ValUnitario)+'</td>');
      VpaTexto.add('	<td width="25%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDServico.ValTotal) +'</td>');
      VpaTexto.add('</tr><tr>');
    end;
    VpaTexto.add('</tr>');
    VpaTexto.add('</table><br>');
    VpaTexto.add('<br>');
  end;

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%> ');
  VpaTexto.add('<tr>');
  VpaTexto.add('  <td width="10%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('  <td width="10%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Código</td>');
  VpaTexto.add('  <td width="35%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Descrição Produto</td>');
  VpaTexto.add('  <td width="05%" align="center"><font face="Verdana" size="-1"><b>&nbsp;UN</td>');
  VpaTexto.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('<tr>');

  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoPro := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    VpaTexto.add('	<td width="10%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProdutoPro.QtdProduto) +'</td>');
    VpaTexto.add('      <td width="10%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.CodReduzido+ '</td>');
    VpaTexto.add('      <td width="35%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.NomProduto+ '</td>');
    VpaTexto.add('      <td width="05%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.UM+'</td>');
    VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDProdutoPro.ValUnitario)+'</td>');
    VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDProdutoPro.ValTotal) +'</td>');
    VpaTexto.add('</tr><tr>');
  end;
  VpaTexto.add('	<td colspan = 6 align="right"><font face="Verdana" size="-1">&nbsp; Total Orçamento : <b>'+FormatFloat(varia.MascaraMoeda,VpaDProposta.ValTotal)+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<br>');


  VpaTexto.add('Prazo de Entrega : '+IntToStr(VpaDProposta.QtdPrazoEntrega)+' dia(s)' );
  VpaTexto.add('<br>');
  VpaTexto.add('Faturamento : '+FunContasAReceber.RNomCondicaoPagamento(VpaDProposta.CodCondicaoPagamento)+ '  -  ' +FunContasAReceber.RNomFormaPagamento(VpaDProposta.CodFormaPagamento));
  VpaTexto.add('<br>');
  case VpaDProposta.TipFrete of
    1 : VpaTexto.add('Frete : Por conta do Cliente');
    2 : VpaTexto.add('Frete : Por conta da '+Varia.NomeFilial)
  end;
  VpaTexto.add('<br>');
  VpaTexto.add('Validade Proposta : '+FormatDateTime('DD/MM/YYYY',VpaDProposta.DatValidade));
  VpaTexto.add('<br>');
  if VpaDProposta.IndDevolveraVazio then
    VpaTexto.add('Devolução Vazio : Sim')
  else
    VpaTexto.add('Devolução Vazio : Não');

  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
  VpaTexto.add('<b>Observações</b><br>');
  VpfDescricaoTecnica.Text := VpaDProposta.DesObservacao;
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]+'<br>');

  VpaTexto.add('<br>');
  VpfDescricaoTecnica.Text := Sistema.RRodapeCRM(VpaDProposta.CodFilial);
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]);

  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<b>Atenciosamente, ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br><b> ');
  VpaTexto.add(FunCotacao.RNomVendedor(VpaDProposta.CodVendedor));
  VpaTexto.add('<br> '+varia.NomeFilial);
  VpaTexto.add('<br> '+Varia.FoneFilial);
  VpaTexto.add('<br> ');

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');

  VpfDescricaoTecnica.free;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailPropostaModelo3(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente ; VpaDFilial : TRBDFilial);
var
  VpfDAmostra : TRBDPropostaAmostra;
  VpfDescricaoTecnica : TStringList;
  VpfLaco : Integer;
  Vpfbmppart : TIdAttachmentfile;
begin
  VpfDescricaoTecnica := TStringList.create;
  Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDProposta.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDProposta.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDProposta.CodFilial)+'.jpg';

  MontaCabecalhoEmailModelo2(VpaTexto,VpaDProposta,VpaDFilial);

  VpaTexto.add('Para : '+IntToStr(VpaDCliente.CodCliente)+ '-'+VpaDCliente.NomCliente);
  if VpaDCliente.TipoPessoa = 'J' Then
  Begin
    VpaTexto.add('<br> ');
    VpaTexto.add('A/C : '+VpaDProposta.NomContato);
  end;
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br>Segue amostra dos produtos solicitados, sendo : ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');

  VpaTexto.add('<table width="100%" border=1  cellpadding="0" cellspacing="0" >');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=5 align="center"><font face="Verdana" size="3"><b>Amostras</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('        <td width="25%"  align="center"><font face="Verdana" size="-1"><b>&nbsp;Imagem</td>');
  VpaTexto.add('        <td width="35%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Nome</td>');
  VpaTexto.add('	<td width="10%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('	<td width="15%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('	<td width="15%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
  for VpfLaco := 0 to VpaDProposta.Amostras.Count - 1 do
  begin
    VpfDAmostra := TRBDPropostaAmostra(VpaDProposta.Amostras.Items[VpfLaco]);
    if VpfDAmostra.DesImagem <> '' then
    begin
      Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.DriveFoto+VpfDAmostra.DesImagem);
      Vpfbmppart.ContentType := 'image/jpg';
      Vpfbmppart.ContentDisposition := 'inline';
      Vpfbmppart.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpfDAmostra.DesImagem);
      Vpfbmppart.DisplayName := RetornaNomArquivoSemDiretorio(VpfDAmostra.DesImagem);
    end;
    VpaTexto.add('</tr><tr> ');
    if VpfDAmostra.DesImagem <> '' then
      VpaTexto.add('        <td width="25%" align="center"><font face="Verdana" size="-1"><IMG src="cid:'+RetornaNomArquivoSemDiretorio(VpfDAmostra.DesImagem)+'" width=150 height=150 ></td>')
    else
      VpaTexto.add('        <td width="25%" align="center"><font face="Verdana" size="-1"></td>');
    VpaTexto.add('        <td width="35%" align="left"><font face="Verdana" size="-1">&nbsp;'+IntToStr(VpfDAmostra.CodAmostra)+'-'+ VpfDAmostra.NomAmostra+ '</td>');
    VpaTexto.add('	<td width="10%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDAmostra.QtdAmostra) +'</td>');
    VpaTexto.add('	<td width="15%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfDAmostra.ValUnitario)+'</td>');
    VpaTexto.add('	<td width="15%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDAmostra.ValTotal) +'</td>');
    VpaTexto.add('        </td>');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');


  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<b>Atenciosamente, ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br><b> ');
  VpaTexto.add(FunCotacao.RNomVendedor(VpaDProposta.CodVendedor));
  VpaTexto.add('<br> '+varia.NomeFilial);
  VpaTexto.add('<br> '+Varia.FoneFilial);
  VpaTexto.add('<br> ');

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');

  VpfDescricaoTecnica.free;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailPropostaModelo4(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
var
  VpfDProdutoPro : TRBDPropostaProduto;
  VpfDServico : TRBDPropostaServico;
  VpfDescricaoTecnica : TStringList;
  VpfLaco : Integer;
  Vpfbmppart : TIdAttachmentfile;
begin
  VpfDescricaoTecnica := TStringList.create;
  Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDProposta.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDProposta.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDProposta.CodFilial)+'.jpg';

  MontaCabecalhoEmailModelo2(VpaTexto,VpaDProposta,VpaDFilial);

  VpaTexto.add('<table border=0 width=100%> ');
  VpaTexto.add('<tr>');
  VpaTexto.add('  <td width="80%" align="left" >');
  VpaTexto.add('<b>A <br>Sr.(a)</b> '+VpaDProposta.NomContato);

  VpaTexto.add('</td> <td width="20%" align="right" >');
  VpaTexto.add('<b>Proposta : </b>'+IntToStr(VpaDProposta.SeqProposta));
  if VpaDCliente.TipoPessoa = 'J' Then
  Begin
    VpaTexto.add('</td></tr><tr> <td colspan=2 align="left" >');
    VpaTexto.add('<b>Empresa :</b> ' +IntToStr(VpaDCliente.CodCliente)+ '-'+VpaDCliente.NomCliente );
  end;
  VpaTexto.add('</td></tr></table>');
  VpaTexto.add('<br> ');

  VpaTexto.add('<center><font color="blue"><b><u><H2>'+RNomTipoProposta(VpaDProposta.CodTipoProposta)+'</H2></u></b></font></center>');



  if VpaDProposta.Servicos.Count > 0 then
  begin
    VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%> ');
    VpaTexto.add('<tr>');
    VpaTexto.add('  <td width="15%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
    VpaTexto.add('  <td width="40%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Descrição Serviço</td>');
    VpaTexto.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
    VpaTexto.add('  <td width="25%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('<tr>');
    for VpfLaco := 0 to VpaDProposta.Servicos.Count - 1 do
    begin
      VpfDServico := TRBDPropostaServico(VpaDProposta.Servicos.Items[VpfLaco]);
      VpaTexto.add('	<td width="15%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDServico.QtdServico) +'</td>');
      VpaTexto.add('    <td width="40%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDServico.NomServico+ '</td>');
      VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDServico.ValUnitario)+'</td>');
      VpaTexto.add('	<td width="25%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDServico.ValTotal) +'</td>');
      VpaTexto.add('</tr><tr>');
    end;
    VpaTexto.add('</tr>');
    VpaTexto.add('</table><br>');
    VpaTexto.add('<br>');
  end;

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%> ');
  VpaTexto.add('<tr>');
  VpaTexto.add('  <td width="10%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('  <td width="10%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Código</td>');
  VpaTexto.add('  <td width="35%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Descrição Produto</td>');
  VpaTexto.add('  <td width="05%" align="center"><font face="Verdana" size="-1"><b>&nbsp;UN</td>');
  VpaTexto.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('<tr>');

  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoPro := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    VpaTexto.add('	<td width="10%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProdutoPro.QtdProduto) +'</td>');
    VpaTexto.add('      <td width="10%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.CodReduzido+ '</td>');
    VpaTexto.add('      <td width="35%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.NomProduto+ '</td>');
    VpaTexto.add('      <td width="05%" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProdutoPro.UM+'</td>');
    VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDProdutoPro.ValUnitario)+'</td>');
    VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDProdutoPro.ValTotal) +'</td>');
    VpaTexto.add('</tr><tr>');
  end;
  VpaTexto.add('	<td colspan = 6 align="right"><font face="Verdana" size="-1">&nbsp; Total Orçamento : <b>'+FormatFloat(varia.MascaraMoeda,VpaDProposta.ValTotal)+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<br>');


  VpaTexto.add('Prazo de Entrega : '+IntToStr(VpaDProposta.QtdPrazoEntrega)+' dia(s)' );
  VpaTexto.add('<br>');
  VpaTexto.add('Faturamento : '+FunContasAReceber.RNomCondicaoPagamento(VpaDProposta.CodCondicaoPagamento)+ '  -  ' +FunContasAReceber.RNomFormaPagamento(VpaDProposta.CodFormaPagamento));
  VpaTexto.add('<br>');
  case VpaDProposta.TipFrete of
    1 : VpaTexto.add('Frete : Por conta do Cliente');
    2 : VpaTexto.add('Frete : Por conta da '+Varia.NomeFilial)
  end;
  VpaTexto.add('<br>');
  VpaTexto.add('Validade Proposta : '+FormatDateTime('DD/MM/YYYY',VpaDProposta.DatValidade));
  VpaTexto.add('<br>');
  if VpaDProposta.IndDevolveraVazio then
    VpaTexto.add('Devolução Vazio : Sim')
  else
    VpaTexto.add('Devolução Vazio : Não');

  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
  VpaTexto.add('<b>Observações</b><br>');
  VpfDescricaoTecnica.Text := VpaDProposta.DesObservacao;
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]+'<br>');

  VpaTexto.add('<br>');
  VpfDescricaoTecnica.Text := Sistema.RRodapeCRM(VpaDProposta.CodFilial);
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]);

  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<b>Atenciosamente, ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br><b> ');
  VpaTexto.add(FunCotacao.RNomVendedor(VpaDProposta.CodVendedor));
  VpaTexto.add('<br> '+varia.NomeFilial);
  VpaTexto.add('<br> '+Varia.FoneFilial);
  VpaTexto.add('<br> ');

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');

  VpfDescricaoTecnica.free;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailPropostaEmAnexo(VpaTexto: TStrings; VpaListaProposta: TList; VpaDCliente: TRBDCliente; VpaDFilial: TRBDFilial; VpaCorpoEmail: String);
var
  VpfDProdutoPro : TRBDPropostaProduto;
  VpfDServico : TRBDPropostaServico;
  VpfDescricaoTecnica : TStringList;
  VpfDProposta : TRBDPropostaCorpo;
  VpfLaco : Integer;
  VpfPDF : TIdAttachmentfile;
  VpfCorpoEmail,
  VpfNomAnexo,
  VpfDesSite,
  VpfDesFone: String;
begin
  for VpfLaco :=  0 to VpaListaProposta.Count - 1 do
  begin
    VpfDProposta := TRBDPropostaCorpo(VpaListaProposta.Items[VpfLaco]);
    dtRave := TdtRave.Create(nil);
    VpfNomAnexo := varia.PathVersoes+'\ANEXOS\PROPOSTA'+IntToStr(VpfDProposta.CodFilial)+'_'+IntToStr(VpfDProposta.SeqProposta)+'.PDF';
    dtRave.VplArquivoPDF := VpfNomAnexo;
    dtRave.ImprimeProposta(VpfDProposta.CodFilial,VpfDProposta.SeqProposta,false);
    dtRave.Free;
    VpfPDF := TIdAttachmentFile.Create(VprMensagem.MessageParts,VpfNomAnexo);
    VpfPDF.ContentType := 'application/pdf;Proposta'+IntToStr(TRBDPropostaCorpo(VpaListaProposta.Items[VpfLaco]).CodFilial)+'_'+IntToStr(VpfDProposta.SeqProposta);
    VpfPDF.ContentDisposition := 'inline';
    VpfPDF.ExtraHeaders.Values['content-id'] := VpfNomAnexo;
    VpfPDF.DisplayName := RetornaNomeSemExtensao(VpfNomAnexo)+'.pdf';
  end;

  VpfCorpoEmail := SubstituiStr(VpaCorpoEmail, #13, '<br>');
  VpfCorpoEmail := SubstituiStr(VpfCorpoEmail, #10, '');

  // KABRAN
  VpaDFilial.DesSite := Minusculas(VpaDFilial.DesSite);
  VpaDFilial.DesFone := SubstituiStr(VpaDFilial.DesFone, '0**', '');
  if VpfDProposta.TipModeloProposta = 6 then
    MontaCabecalhoEmailEmAnexo(VpaTexto,VpfDProposta,VpaDFilial,VpfCorpoEmail)
  else
    MontaCabecalhoEmailEmAnexoEficacia(VpaTexto,VpfDproposta,VpaDFilial,VpfCorpoEmail,VpaDCliente);

  VpaTexto.add('<br><hr>');
  VpaTexto.add('<center>');
  if sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestao desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailsPropostaHomero(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
var
  VpfDProdutoPro : TRBDPropostaProduto;
  VpfDescricaoTecnica : TStringList;
  VpfLaco, VpfLacoDescricao : Integer;
  Vpfbmppart : TIdAttachmentfile;
  VpfValOpcao,VpfDescontoOpcao : Double;
begin
  VpfDescricaoTecnica := TStringList.create;
  Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDProposta.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDProposta.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDProposta.CodFilial)+'.jpg';

  MontaCabecalhoEmailHomero(VpaTexto,VpaDProposta,VpaDFilial);

  VpaTexto.add('<table border=0  width=100%> ');
  VpaTexto.add('<tr>');
  VpaTexto.add('  <td width="80%" align="left" >');
  VpaTexto.add('<b>A <br>Sr.(a)</b> '+VpaDProposta.NomContato);
  if VpaDCliente.TipoPessoa = 'J' Then
  Begin
    VpaTexto.add('<br> ');
    VpaTexto.add('<b>Empresa :</b> ' +IntToStr(VpaDCliente.CodCliente)+ '-'+VpaDCliente.NomCliente );
  end;
  VpaTexto.add('<br><b>Fone : </b> '+VpaDCliente.DesFone1);
  if VpaDCliente.DesFone2 <> '' then
    VpaTexto.add('/'+VpaDCliente.DesFone2);
  VpaTexto.add('<br><b>E-mail : </b> '+VpaDCliente.DesEmail);
  VpaTexto.add('</td> <td width="20%" align="right" >');
  VpaTexto.add('<b>Proposta : </b>'+IntToStr(VpaDProposta.SeqProposta));
  VpaTexto.add('</td></tr></table>');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  if VpaDProposta.CodTipoProposta = 0 then
    VpaTexto.add('<center><font color="blue"><b><u><H2>SISTEMA DE SEGURANÇA</H2></u></b></font></center>')
  else
    VpaTexto.add('<center><font color="blue"><b><u><H2>'+RNomTipoProposta(VpaDProposta.CodTipoProposta)+'</H2></u></b></font></center>');
  VpaTexto.add('<b> Caros Clientes</b> ');
  VpaTexto.add('<br>Somos uma empresa sólida no mercado, com <b>17 anos</b> de atuação, sede própria e show-room dos produtos e serviços que oferecemos. ');
  VpaTexto.add('Trabalhamos com fornecedores e parceiros comprometidos com a qualidade e procedência dos produtos e equipe própria, capacitada e treinada para atender sempre e cada vez melhor, nossos clientes.');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%> ');
  VpaTexto.add('<tr>');
  VpaTexto.add('  <td width="10%" align="center" bgcolor="silver"><font face="Verdana" color="blue" size="-1"><b>Quantidade</td>');
  VpaTexto.add('  <td width="50%" align="center" bgcolor="silver"><font face="Verdana" color="blue" size="-1"><b>Produtos</td>');
  VpaTexto.add('  <td width="20%" align="center" bgcolor="silver"><font face="Verdana" color="blue" size="-1"><b>Valor Unitário</td>');
  VpaTexto.add('  <td width="20%" align="center" bgcolor="silver"><font face="Verdana" color="blue" size="-1"><b>Valor Total</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('<tr>');
  VpfValOpcao := 0;
  VpfDescontoOpcao := 0;
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoPro := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    begin
      VpfValOpcao := VpfValOpcao + VpfDProdutoPro.ValTotal;
      VpfDescontoOpcao := VpfDescontoOpcao + VpfDProdutoPro.ValDesconto;
      VpaTexto.add('	<td width="10%" align="center"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProdutoPro.QtdProduto) +'</td>');
      VpaTexto.add('      <td width="50%" align="left"><font face="Verdana" size="-1">');
      if VpfDProdutoPro.DesTecnica <> '' then
        VpaTexto.add('<b>');
      VpaTexto.add(VpfDProdutoPro.NomProduto);
      if VpfDProdutoPro.DesTecnica <> '' then
      begin
        VpaTexto.add('</b>');
        VpfDescricaoTecnica.Text := VpfDProdutoPro.DesTecnica;
        for VpfLacoDescricao := 0 to VpfDescricaoTecnica.Count - 1 do
        begin
          VpaTexto.add('<br>'+VpfDescricaoTecnica.Strings[VpfLacoDescricao]);

        end;
      end;
      VpaTexto.add('</td>');
      VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDProdutoPro.ValUnitario)+'</td>');
      VpaTexto.add('	<td width="20%" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraMoeda,VpfDProdutoPro.ValTotal) +'</td>');
      VpaTexto.add('</tr><tr>');
    end;
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" align="right" width=40%> ');
  VpaTexto.add('	<td width="20%" bgcolor="silver" align="right"><font face="Verdana" color="blue" size="-1">&nbsp; TOTAL À VISTA &nbsp;</td>');
  VpaTexto.add('	<td width="20%" bgcolor="silver" align="right"><font face="Verdana" color="blue" size="-1">&nbsp;<b>'+FormatFloat(varia.MascaraMoeda,VpaDProposta.ValTotal)+'</b></td>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<br>');
  VpaTexto.add(' <b><font size="2" color="red">***Obs.1: </font><font size="3" color="blue">Material de Acabamento será cobrado cfme. consumo, ao término da obra, se necessário.</font>');
  VpaTexto.add('<br><font size="2" color="red">***Obs.2: </font><font size="3" color="blue">Serviço de Serralheiro, Marceneiro, Pedreiro, Chaveiro não estão inclusos no orçamento(à combinar).</font> ');
  VpaTexto.add('<br><font size="2" color="red">***Obs.3: </font><font size="3" color="blue">Dutos e Eletrodutos para passagem  de cabos, serão cobrados cfme. o consumo, ao término da obra.</font> ');
  VpaTexto.add('<br><font size="2" color="red">***Obs.4: </font><font size="3" color="blue">Este orçamento está sujeito a alterações após a visita do consultor comercial.</b></font> ');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');

  VpaTexto.add('<b>Observações</b><br>');
  VpfDescricaoTecnica.Text := VpaDProposta.DesObservacao;
  for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
    VpaTexto.Add(VpfDescricaoTecnica.Strings[VpfLaco]+'<br>');

  VpaTexto.add('<table border="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('  <td width="70%" <font size="1">');
  VpaTexto.add('    <li><b><u>Opções de Pagamento :</u></b> Cheque à vista, boleto bancario ou leasing');
  VpaTexto.add('    <li><b><u>Garantia :</u></b> 1 ano nos equipamentos (Contra defeitos de fabricação)');
  VpaTexto.add('    <li><b><u>Validade Proposta :</u></b> '+FormatDateTime('DD/MM/YYYY',VpaDProposta.DatValidade));
  VpaTexto.add('    <li><b><u>Prazo Entrega :</u></b> à combinar');
  VpaTexto.add('    <li><b><u>Assistência Técnica :</u></b> Permanente');
  VpaTexto.add('  </td>');
  VpaTexto.add('  <td width="30%" <font size="1"><br>');
  VpaTexto.add('  <table border="1" cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('    <tr>');
  VpaTexto.add('      <td colspan=2 align="center" bgcolor="silver"> <font color="blue"><b>Condições de Pagamento</td>');
  VpaTexto.add('    </tr><tr>');
  VpaTexto.add('      <td width="50%" align="center" bgcolor="silver"><font color="blue"><b>Entrada(30%)</td>');
  VpaTexto.add('      <td width="50%" align="right" bgcolor="silver"><font color="blue"><b>'+FormatFloat(varia.MascaraValor,VpaDProposta.ValTotal*0.30)+ '</td>');
  VpaTexto.add('    </tr><tr>');
  VpaTexto.add('      <td width="50%" align="center" bgcolor="silver"><font color="blue"><b>1X</td>');
  VpaTexto.add('      <td width="50%" align="right" bgcolor="silver"><font color="blue"><b>'+FormatFloat(varia.MascaraValor,(VpaDProposta.ValTotal*0.70)*1.02)+'</td>');
  VpaTexto.add('    </tr><tr>');
  VpaTexto.add('      <td width="50%" align="center" bgcolor="silver"><font color="blue"><b>2X</td>');
  VpaTexto.add('      <td width="50%" align="right" bgcolor="silver"><font  color="blue"><b>'+FormatFloat(varia.MascaraValor,((VpaDProposta.ValTotal*0.70)*1.04)/2)+'</td>');
  VpaTexto.add('    </tr><tr>');
  VpaTexto.add('      <td width="50%" align="center" bgcolor="silver"><font color="blue"><b>3X</td>');
  VpaTexto.add('      <td width="50%" align="right" bgcolor="silver"><font color="blue"><b>'+FormatFloat(varia.MascaraValor,((VpaDProposta.ValTotal*0.70)*1.06)/3)+'</td>');
  VpaTexto.add('    </tr>');
  VpaTexto.add('  </table>');
  VpaTexto.add('  </td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table>');

  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
  VpaTexto.add('            Estamos a disposição,');
  VpaTexto.add('<br> ');
  VpaTexto.add('<br> ');
  VpaTexto.add('<center><b> ');
  VpaTexto.add(FunCotacao.RNomVendedor(VpaDProposta.CodVendedor)+'</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+varia.CidadeFilial+', ' +IntToStr(dia(VpaDProposta.DatProposta))+' de '+TextoMes(VpaDProposta.DatProposta,false)+ ' de '+IntToStr(ano(VpaDProposta.DatProposta)) );
  VpaTexto.add('    </center>');
  VpaTexto.add('<br> ');
  VpaTexto.add('<center><font color="blue"><b>KABRAN</b>... Trabalhando sério há mais de <b>17 anos</b> para sempre tê-lo ao nosso lado!!!</center>');
  VpaTexto.add('<br> ');
  VpaTexto.add('<hr> ');
  VpaTexto.add('<table width="60%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('        <td colspan="2" align="right" ><font face="Verdana" size="3"><b>Aprovação do Cliente</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td colspan="2" align="right" ><font face="Verdana" size="1">Devolver preenchido e assinado com carimbo da empresa</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="30%" align="left" ><font face="Verdana" size="2">&nbsp;Data </td>');
  VpaTexto.add('	<td width="70%" align="left" ><font face="Verdana" size="2">&nbsp;___/___/______ </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="30%" align="left" ><font face="Verdana" size="2">&nbsp;Nome </td>');
  VpaTexto.add('	<td width="70%" align="left" ><font face="Verdana" size="2">&nbsp;__________________________________________ </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="30%" align="left" ><font face="Verdana" size="2">&nbsp;Assinatura </td>');
  VpaTexto.add('	<td width="70%" align="left" ><font face="Verdana" size="2">&nbsp;__________________________________________ </td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table> ');


  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');

  VpfDescricaoTecnica.free;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailPropostaRotuladora(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo;VpaDCliente : TRBDCliente; VpaDFilial : TRBDFilial);
var
  VpfDProdutoProposta : TRBDpropostaProduto;
begin
  if VpaDProposta.Produtos.Count > 0 then
  begin
    VpfDProdutoProposta := TRBDPropostaProduto(VpaDProposta.Produtos.Items[0]);
    MontaCabecalhoEmailRotuladoras(VpaTexto,VpaDProposta,VpaDFilial);
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="0" width=100%> ');
    VpaTexto.add('<tr>');
    VpaTexto.add('  <td width="100%" align="right" <font face="Verdana" size="-1"> '+varia.CidadeFilial+'/'+varia.UFFilial+', ' +IntToStr(dia(VpaDProposta.DatProposta))+' de '+TextoMes(VpaDProposta.DatProposta,false)+ ' de '+IntToStr(ano(VpaDProposta.DatProposta))+'</td>');
    VpaTexto.add('</tr>');
    VpaTexto.add('</table>' );
    VpaTexto.add('<b>À' );
    VpaTexto.add('<br>'+VpaDCliente.NomFantasia );
    VpaTexto.add('<br>'+VpaDCliente.DesCidade+' - '+VpaDCliente.DesUF );
    VpaTexto.add('<br>Fone: '+VpaDCliente.DesFone1 );
    VpaTexto.add('<br>e-mail: '+VpaDCliente.DesEmail );
    VpaTexto.add('<br> ');
    VpaTexto.add('<br>A/C Sr(a). '+VpaDProposta.NomContato);
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<center>' );
    VpaTexto.add('<u>Proposta Comercial</u>');
    VpaTexto.add('</center>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('Or&ccedil;amento No. '+IntToStr(VpaDProposta.SeqProposta) );
    VpaTexto.add('</b>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<P>Conforme solicita&ccedil;ão, apresentamos nossa proposta de fornecimento de rotuladora automática para rótulos auto-adesivos, modelo ');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    MontaEmailAdicionaProdutosRotulados(VpaTexto,VpaDProposta);
    MontaEmailAdicionaConfiguracao(VpaTexto,VpaDProposta);
    MontaEmailAdcionaValoresRotuladora(VpaTexto,VpaDProposta);
    VpaTexto.add('<b><U>3-Condições de Pagamento</u></b>' );
    VpaTexto.add('<br>25% no ato do pedido: R$                   (Depósito Bancário)');
    VpaTexto.add('<br>25% no ato da entrega: R$                  (Boleto Bancário)');
    VpaTexto.add('<br>25% a 28 dias da entrega: R$               (Boleto Bancário)');
    VpaTexto.add('<br>25% a 56 dias da entrega: R$               (Boleto Bancário)');
    VpaTexto.add('<br>Temos opção para PROGER, Finame, Cartão BNDES, depende da aprovação do Bando do cliente.');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>4-Amostras para testes</u></b>' );
    VpaTexto.add('<br>É necessário o envio de amostras de frascos(10 pe&ccedil;as de cada item a ser rotulado) à '+CopiaAteChar(Varia.NomeFilial,' ')+', bem como de amostras de cada rótulo utilizado(1 bobina de cada).');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>5-Prazo de Entrega</u></b>' );
    VpaTexto.add('<br>Até '+IntToStr(VpaDProposta.QtdPrazoEntrega)+' dias a contar do recebimento via fax do pedido de compra, devidamente assinado e com o carimbo da empresa, e após o recebimento das amostras de rótulos e frascos solicitadas.');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>7-Garantia</u></b>' );
    VpaTexto.add('<br>A '+CopiaAteChar(Varia.NomeFilial,' ')+' dá garantia do equipamento por um período de 6 meses, a contar da data constante na nota fiscal, contra defeitos de fabricação, conforme normas que acompanham o termo de garantia e '+
                 ' manual do equipamento, entregues no ato da instalação. A '+CopiaAteChar(Varia.NomeFilial,' ')+ ' não cobrará despesas com horas técnica durante o período de garantia, e substituirá as peças que eventualmente tiverem defeitos de fabricação, sem custos para o cliente.');
    VpaTexto.add('<P>De acordo com o código do consumidor em vigência, somente serão cobrados a parte, mesmo no período de garantia, as despesas decorrentes de viagens, estadia e alimentação dos técnicos. Não estão inclusas na garantia '+
                 ' os itens que apresentarem desgaste natural, decorrente do'+
                 ' uso do equipamento, como correias, correntes, rolamentos, resistências elétricas, e/ou danos elétricos em componentes que sofrerem sub ou sob-tensão de operação (placas, sensores,resistências), após avaliação do técnico da '+CopiaAteChar(Varia.NomeFilial,' ')+'.');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>8-Transporte e Treinamento</u></b>' );
    VpaTexto.add('<br>O transporte do equipamento é feito por transportadora de preferência e conta do cliente (FOB). O treinamento é feito por técnico da empresa que efetuará no local '+
                 'treinamento ao(s) operador(es). A despesa decorrente de viagens, estadia e alimentação do técnico serão por conta do cliente.');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>9-Re-treinamento dos operador(es)</u></b>' );
    VpaTexto.add('<br>Será oferecido gratuitamente nas dependências da '+CopiaAteChar(Varia.NomeFilial,' ')+'.');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>10-Validade da proposta</u></b>' );
    VpaTexto.add('<br>Os valores, bem como as características do equipamento, expressos nesta proposta comercial, terão validade por um período de  '+IntToStr(DiasPorPeriodo(VpaDProposta.DatProposta,VpaDProposta.DatValidade))+
                 ' dias. A ' +CopiaAteChar(Varia.NomeFilial,' ')+' se reserva no direito de alterar os valores e a característica do equipamento sem prévio aviso.');
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>11-Conta corrente para depósito</u></b>' );
    VpaTexto.add('<br>Banco do Brasil / Ag 1478-8 / CC: 7474-8 / Titular: '+Varia.NomeFilial);
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>12-Observa&ccedil;ões Gerais</u></b>' );
    VpaTexto.add('<br>1. Em caso de equipamento com datador Hot Stamping, observar as especificações abaixo:');
    VpaTexto.add('<li>Dimesões de cada letra ou número: 2mm de altura e largura de 1,5mm;');
    VpaTexto.add('<li>Possível escrever LOTE (0000 até 9999), FAB (01JAN00 até 31DEZ99) e VAL (01JAN00 até 31DEZ99) em no máximo três linhas;');
    VpaTexto.add('<li>Máximo de 14 caracteres cada linha;');
    VpaTexto.add('<li>Espaço entre linhas 2mm;');
    VpaTexto.add('<li>Utiliza fita para Hot Stamping, disponível em nosso departamento de vendas;');
    VpaTexto.add('<li>Sugestão de marca&ccedil;ão (Tamanho real de marcação):');
    VpaTexto.add('<br>F 01/01/07' );
    VpaTexto.add('<br>V 01/01/08' );
    VpaTexto.add('<br>L 0001' );
    VpaTexto.add('<P>2. Para troca de bobinas (quando a bobina com rótulos termina) se faz necessário parar a rotulagem. Quanto maior a produção horária, maior a quantidade de paradas.' );
    VpaTexto.add('<P>3. Sentido das bobinas.' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<br>' );
    VpaTexto.add('<b><U>13-Aquisi&ccedil;ão do equipamento</u></b>' );
    VpaTexto.add('<br>Visando facilitar nossas rela&ccedil;ões, oferecemos a op&ccedil;ão de validar seu pedido de compra através desta proposta comercial, sendo que serão mantidas exatamente as condições e termos'+
                 ' expressos nesta proposta comercial ou redefinidas por escrito e acordado entre as partes. Para confirmar o pedido, pedimos a gentileza de preencher os campos abaixo e '+
                 ' encaminhar os documentos e materias solicitados: ');
    VpaTexto.add('<br>' );
    VpaTexto.add('<P>1. Dados do cliente:' );
    VpaTexto.add('<br>ANEXAR A ESTE O CADASTRO COMPLETO' );
    VpaTexto.add('<P>2. Embalagem:' );
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="0" width=100%> ');
    VpaTexto.add('<tr>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">a) Material?</td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Vidro</td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Plástica</td>');
    VpaTexto.add('  <td width="40%" align="left" <font face="Verdana" size="-1"></td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">b) Tipo? </td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Transparente</td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Opaca</td>');
    VpaTexto.add('  <td width="40%" align="left" <font face="Verdana" size="-1"></td>');
    VpaTexto.add('</tr>');
    VpaTexto.add('</table>');
    VpaTexto.add('<br>               ' );
    VpaTexto.add('<br>              ' );
    VpaTexto.add('<P>3. Rotulos:' );
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="0" width=100%> ');
    VpaTexto.add('<tr>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">a) Possui rótulos?</td>');
    VpaTexto.add('  <td width="20%" align="leftr" <font face="Verdana" size="-1">( ) Sim </td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Não</td>');
    VpaTexto.add('  <td width="40%" align="left" <font face="Verdana" size="-1">( ) Em desenvolvimento</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">b) Material? </td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Papel</td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) BOPP</td>');
    VpaTexto.add('  <td width="40%" align="left" <font face="Verdana" size="-1"></td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">c) Tipo? </td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Transparente</td>');
    VpaTexto.add('  <td width="20%" align="left" <font face="Verdana" size="-1">( ) Opaca</td>');
    VpaTexto.add('  <td width="40%" align="left" <font face="Verdana" size="-1"></td>');
    VpaTexto.add('</tr>');
    VpaTexto.add('</table>');
    VpaTexto.add('<tr>');
    VpaTexto.add('<P>4. Enviar as amostras descritas no item 4. No caso de não envio das amostras solicitadas, a '+CopiaAteChar(Varia.NomeFilial,' ') +' não se compromete quanto a qualidade da rotulagem e produtividade por hora do equipamento;');
    VpaTexto.add('<P>5. Em caso de o cliente não possuir produto, rótulos ou algo que impeça a instalação do equipamento por falta de produção e estando vencido o prazo de entrega, a '+CopiaAteChar(Varia.NomeFilial,' ') + ' reserva-se no direito de '+
                 ' efetuar as cobranças relativas à entrega do equipamento;'  );
    VpaTexto.add('<P>6. Encaminhar esta proposta assinada e carimbada para o FAX :'+Varia.FoneFilial+'.');
    VpaTexto.add('<br>');
    VpaTexto.add('<P>Em acordo com os dados acima descritos,');
    VpaTexto.add('<br>');
    VpaTexto.add('<br>');
    VpaTexto.add('<br>');
    VpaTexto.add('<br>');
    VpaTexto.add('<br>');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="0" width=100%> ');
    VpaTexto.add('<tr>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1"> Marcos David Berti</td>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1"></td>');
    VpaTexto.add('  <td width="40%" align="center" <font face="Verdana" size="-1"><hr></td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1">Vendas</td>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1"> </td>');
    VpaTexto.add('  <td width="40%" align="center" <font face="Verdana" size="-1">'+VpaDCliente.NomCliente+'</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1"></td>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1"> </td>');
    VpaTexto.add('  <td width="40%" align="center" <font face="Verdana" size="-1">Assinatura e carimbo da empresa</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1"></td>');
    VpaTexto.add('  <td width="30%" align="center" <font face="Verdana" size="-1"> </td>');
    VpaTexto.add('  <td width="40%" align="center" <font face="Verdana" size="-1">Em todas as páginas</td>');
    VpaTexto.add('</tr>' );
    VpaTexto.add('</table>' );

    VpaTexto.add('</body>');
    VpaTexto.add('</html>');
    //VpaTexto.SaveToFile('c:\Proposta.html');
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailAdicionaProdutosRotulados(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo);
var
  VpfLaco : Integer;
  VpfDProRotulado : TRBDPropostaProdutoASerRotulado;
begin
  varia.CRMCorEscuraEmail := 'FFFFFF';
  varia.CRMCorClaraEmail := 'FFFFFF';
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=2 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Produtos a Serem Rotulados</td>');

  for VpfLaco := 0 to VpaDProposta.ProdutosASeremRotulados.Count - 1 do
  begin
    VpfDProRotulado := TRBDPropostaProdutoASerRotulado(VpaDProposta.ProdutosASeremRotulados.Items[VpfLaco]);
    VpaTexto.add('</tr><tr> ');
    VpaTexto.add('        <td width="60%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>Produto</td>');
    VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>Rotulo</td>');
    VpaTexto.add('</tr><tr> ');
    VpaTexto.add('        <td width="60%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1">'+
                 '<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Produto &nbsp;</td>');
    VpaTexto.add('        <td width="80%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomProduto+'</td>');
    VpaTexto.add('  </tr><tr> ');
    VpaTexto.add('        <td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Formato &nbsp;</td>');
    VpaTexto.add('        <td width="80%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomFormatoFrasco+'</td>');
    VpaTexto.add('  </tr><tr> ');
    VpaTexto.add('        <td colspan=2 bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1">');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Material &nbsp;</td>');
    VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomMaterialFrasco+'</td>');
    VpaTexto.add('        <td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Frascos por Hora &nbsp;</td>');
    VpaTexto.add('        <td width="20%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+FormatFloat('#,###,##0',VpfDProRotulado.QtdFrascosHora) +'</td>');
    VpaTexto.add(' </tr>');
    VpaTexto.add('  </table> </td></tr>');
    //largura produto
    VpaTexto.add('        <td colspan=2 bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1">');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="12%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Largura &nbsp;</td>');
    VpaTexto.add('        <td width="13%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.LarFrasco)+'</td>');
    VpaTexto.add('        <td width="12%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Altura &nbsp;</td>');
    VpaTexto.add('        <td width="12%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.AltFrasco)+'</td>');
    VpaTexto.add('        <td width="12%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Diametro &nbsp;</td>');
    VpaTexto.add('        <td width="12%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.DiametroFrasco)+'</td>');
    VpaTexto.add('        <td width="14%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Profundidade &nbsp;</td>');
    VpaTexto.add('        <td width="13%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.ProfundidadeFrasco)+'</td>');
    VpaTexto.add('  </table>');
    //contra gargantilha
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td colspan=4 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-1"><b>Gargantilha</td>');
    VpaTexto.add('   </tr>');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Material &nbsp;</td>');
    VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomMaterialGargantilha+'</td>');
    VpaTexto.add('        <td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Liner &nbsp;</td>');
    VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomLinerGargantilha+'</td>');
    VpaTexto.add('   </tr>');
    VpaTexto.add('  </table> ');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Largura &nbsp;</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.LarGargantilha)+'</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Altura &nbsp;</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.AltGargantilha)+'</td>');
    VpaTexto.add('  </tr> ');
    VpaTexto.add('  </table> </td></tr>');

    VpaTexto.add(' </table> </td>');

    //rotulo
    VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1">');
//                 '<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Material &nbsp;</td>');
    VpaTexto.add('        <td width="70%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomMaterialRotulo+'</td>');
    VpaTexto.add('        </tr><tr> ');
    VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Liner &nbsp;</td>');
    VpaTexto.add('        <td width="70%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomLinerRotulo+'</td>');
    VpaTexto.add('   </tr>');
    VpaTexto.add('  </table> ');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Largura &nbsp;</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.LarRotulo)+'</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Altura &nbsp;</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.AltRotulo)+'</td>');
    VpaTexto.add('  </tr> ');
    VpaTexto.add('  </table> ');
    //contra rotulo
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td colspan=2 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-1"><b>Contra Rotulo</td>');
    VpaTexto.add('   </tr>');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Material &nbsp;</td>');
    VpaTexto.add('        <td width="70%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomMaterialContraRotulo+'</td>');
    VpaTexto.add('        </tr><tr> ');
    VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Liner &nbsp;</td>');
    VpaTexto.add('        <td width="70%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+VpfDProRotulado.NomLinerContraRotulo+'</td>');
    VpaTexto.add('   </tr>');
    VpaTexto.add('  </table> ');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    VpaTexto.add('  <tr> ');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Largura &nbsp;</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.LarContraRotulo)+'</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="right"><font face="Verdana" size="-2"><b>Altura &nbsp;</td>');
    VpaTexto.add('        <td width="25%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="left"><font face="Verdana" size="-1">'+IntToStr(VpfDProRotulado.AltContraRotulo)+'</td>');
    VpaTexto.add('  </tr> ');
    VpaTexto.add('  </table> ');


    VpaTexto.add('  </td> ');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('<br>');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailAdicionaConfiguracao(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo);
var
  VpfDProduto : TRBDProduto;
  VpfDProProposta : TRBDPropostaProduto;
  VpfDAcessorio : TRBDProdutoAcessorio;
  VpfLacoAcessorio : Integer;
begin
  VpaTexto.add('<br>');
  VpaTexto.add('<b><U>1-Configuração do Equipamento</u></b>' );
  VpfDProProposta := nil;
  if VpaDProposta.Produtos.Count > 0 then
  begin
    VpfDProProposta := TRBDPropostaProduto(VpaDProposta.Produtos.Items[0]);
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,Varia.codigoempresa,VpaDProposta.CodFilial,VpfDProProposta.SeqProduto);
    for VpflacoAcessorio := 0 to VpfDProduto.Acessorios.Count - 1 do
    begin
      VpfDAcessorio := TRBDProdutoAcessorio(VpfDProduto.Acessorios.Items[VpfLacoAcessorio]);
      VpaTexto.add('<li> '+VpfDAcessorio.NomAcessorio);
    end;
  end;
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
end;

{******************************************************************************}
procedure TRBFuncoesProposta.MontaEmailAdcionaValoresRotuladora(VpaTexto : TStrings; VpaDProposta : TRBDPropostaCorpo);
var
  VpfDProduto : TRBDProduto;
  VpfDProProposta : TRBDPropostaProduto;
  VpfLaco : Integer;
  VpfDVendaAdicional : TRBDPropostaVendaAdicional;
begin
  VpaTexto.add('<br>');
  VpaTexto.add('<b><U>2-Valores* (Impostos Inclusos) - EMPRESA OPTANTE DO SIMPLES NACIONAL </u></b>' );
  VpfDProProposta := nil;
  if VpaDProposta.Produtos.Count > 0 then
  begin
    VpfDProProposta := TRBDPropostaProduto(VpaDProposta.Produtos.Items[0]);
    VpaTexto.add('<br>Máquina modelo ' +VpfDProProposta.NomProduto+', conforme configuração acima:..... '+FormatFloat('R$ #,###,###,##0.00',VpfDProProposta.ValTotal));
  end;
  if VpaDProposta.VendaAdicinal.Count > 0 then
  begin
    VpaTexto.add('<br>');
    VpaTexto.add('<br>');
    VpaTexto.add('<U>Opcionais não inclusos (Somar ao valor acima e diluir nas prestações):</U>');
    VpaTexto.add('<table border=0 cellpadding="0" cellspacing="1" width="100%">');
    for VpfLaco := 0 to VpaDProposta.VendaAdicinal.Count -1 do
    begin
      VpfDVendaAdicional := TRBDPropostaVendaAdicional(VpaDProposta.VendaAdicinal.Items[VpfLaco]);
      VpaTexto.add('  <tr> ');
      VpaTexto.add('        <td width="70%" align="left">(  )'+VpfDVendaAdicional.NomProduto+'</td>');
      VpaTexto.add('        <td width="30%" align="left">'+FormatFloat('R$ #,###,###,##0.00',VpfDVendaAdicional.ValTotal) +'</td>');
      VpaTexto.add(' </tr>');
    end;
    VpaTexto.add('  </table>');
  end;
  VpaTexto.add('<br>');
  VpaTexto.add('*Não está incluso transporte do equipamento (FOB - Ascurra - Santa Catarina) e deslocamento do técnico.');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
end;

{******************************************************************************}
function TRBFuncoesProposta.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial) : string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := varia.PortaSMTP;
  if config.ServidorInternetRequerAutenticacao then
    VpaSMTP.AuthType := satdefault
  else
    VpaSMTP.AuthType := satNone;


  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DA FILIAL !!!'#13'É necessário preencher o e-mail da filial.';
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
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaLogEstagio(VpaCodFilial, VpaSeqProposta,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String):String;
var
  VpfNomArquivo : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from ESTAGIOPROPOSTA ' +
                                 ' WHERE CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQESTAGIO = 0');
  Cadastro.insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  Cadastro.FieldByName('SEQPROPOSTA').AsInteger := VpaSeqProposta;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaCodUsuario;
  Cadastro.FieldByName('CODESTAGIO').AsInteger := VpaCodEstagio;
  if VpaDesMotivo <> '' then
    Cadastro.FieldByName('DESMOTIVO').AsString := VpaDesMotivo;
  Cadastro.FieldByName('DATESTAGIO').AsDateTime := now;

  AdicionaSQLAbreTabela(Cadastro2,'Select * from PROPOSTA '+
                                  ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' and SEQPROPOSTA = '+ IntToStr(VpaSeqProposta));
  VpfNomArquivo := varia.PathVersoes+'\LOG\PROPOSTA\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqProposta)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'CAB.xml';
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  Cadastro.FieldByname('DESLOG').AsString := Cadastro.FieldByname('DESLOG').AsString+'PROPOSTA="'+VpfNomArquivo+'"'+ #13;
  Cadastro2.SaveToFile(VpfNomArquivo,dfXml);

  AdicionaSQLAbreTabela(Cadastro2,'Select * from PROPOSTAPRODUTO '+
                                  ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' and SEQPROPOSTA = '+ IntToStr(VpaSeqProposta)+
                                  ' order by SEQITEM');
  VpfNomArquivo := varia.PathVersoes+'\LOG\PROPOSTA\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqProposta)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'PRO.xml';
  Cadastro.FieldByname('DESLOG').AsString := Cadastro.FieldByname('DESLOG').AsString+'PROPOSTAPRODUTO="'+VpfNomArquivo+'"'+ #13;
  Cadastro2.SaveToFile(VpfNomArquivo,dfXml);

  AdicionaSQLAbreTabela(Cadastro2,'Select * from PROPOSTAPRODUTOROTULADO '+
                                  ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' and SEQPROPOSTA = '+ IntToStr(VpaSeqProposta)+
                                  ' order by SEQITEM');
  VpfNomArquivo := varia.PathVersoes+'\LOG\PROPOSTA\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqProposta)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'PROROT.xml';
  Cadastro.FieldByname('DESLOG').AsString := Cadastro.FieldByname('DESLOG').AsString+'PROPOSTAPRODUTOROTULADO="'+VpfNomArquivo+'"'+ #13;
  Cadastro2.SaveToFile(VpfNomArquivo,dfXml);


  Cadastro.FieldByName('SEQESTAGIO').AsInteger := RSeqEstagioDisponivel(VpaCodFilial,VpaSeqProposta);
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro2.Close;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDEmail(VpaDProposta: TRBDPropostaCorpo): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PROPOSTAEMAIL'+
                                 ' Where CODFILIAL = 0 AND SEQPROPOSTA = 0 AND SEQEMAIL = 0');
  Cadastro.Insert;

  Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDProposta.CodFilial;
  Cadastro.FieldByName('SEQPROPOSTA').AsInteger:= VpaDProposta.SeqProposta;
  Cadastro.FieldByName('SEQEMAIL').AsInteger:= RSeqEmailDisponivel;
  Cadastro.FieldByName('DATEMAIL').AsDateTime:= Now;
  Cadastro.FieldByName('DESEMAIL').AsString:= VpaDProposta.DesEmail;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= Varia.CodigoUsuario;

  Cadastro.post;
  result := cadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDEstagioGrupoUsuario(VpaCodGrupoUsuario: Integer; VpaEstagio: TList): String;
var
  VpfLaco : Integer;
  VpfDEstagio : TRBDEEstagioProducaoGrupoUsuario;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from ESTAGIOPRODUCAOGRUPOUSUARIO '+
                        ' Where CODGRUPOUSUARIO = '+IntToStr(VpaCodGrupoUsuario));
  AdicionaSQLAbreTabela(Cadastro,' Select * from ESTAGIOPRODUCAOGRUPOUSUARIO ' +
                                 '  WHERE CODGRUPOUSUARIO = 0 AND CODEST = 0 ');
  for VpfLaco := 0 to VpaEstagio.Count - 1 do
  begin
    VpfDEstagio := TRBDEEstagioProducaoGrupoUsuario(VpaEstagio.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODEST').AsInteger := VpfDEstagio.CodEstagio;
    Cadastro.FieldByName('CODGRUPOUSUARIO').AsInteger := VpaCodGrupoUsuario;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if result <> ''  then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.OrdenaItensPelaOpcao(VpaDProposta: TRBDPropostaCorpo);
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDProPropostaExterno, VpfDProPropostaInterno: TRBDPropostaProduto;
begin
  for VpfLacoExterno := 0 to VpaDProposta.Produtos.Count -2 do
  begin
    VpfDProPropostaExterno := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDProposta.Produtos.Count - 1 do
    begin
      VpfDProPropostaInterno := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLacoInterno]);
      if VpfDProPropostaInterno.NumOpcao < VpfDProPropostaExterno.NumOpcao then
      begin
        VpaDProposta.Produtos.Items[VpfLacoExterno] := VpfDProPropostaInterno;
        VpaDProposta.Produtos.Items[VpfLacoInterno] := VpfDProPropostaExterno;
        VpfDProPropostaExterno := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.PreencheClasseParcelas(VpaCodFormaPagamento: Integer; VpaDProposta: TRBDPropostaCorpo);
Var
  VpfQtdDiasAnterior: Integer;
  VpfDParcelas : TRBDPropostaParcelas;
begin
  VpfQtdDiasAnterior:= 0;
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM MOVCONDICAOPAGTO '+
                            ' WHERE I_COD_PAG = ' +IntToStr(VpaCodFormaPagamento)+
                            ' ORDER BY I_NRO_PAR');
  while not Tabela.Eof do
  begin
    VpfDParcelas := VpaDProposta.addParcelas;
    VpfDParcelas.ValPagamento:= (VpaDProposta.ValTotal * Tabela.FieldByName('N_PER_PAG').AsInteger) /100;

    if Tabela.FieldByName('I_DIA_FIX').AsInteger = 100 then
      VpfDParcelas.DesCondicao:= 'em 30 DDF'
    else
      if Tabela.FieldByName('I_NUM_DIA').AsInteger = 0 then
        VpfDParcelas.DesCondicao:= 'No Pedido'
      else
        VpfDParcelas.DesCondicao:= 'Em ' + IntToStr(VpfQtdDiasAnterior + Tabela.FieldByName('I_NUM_DIA').AsInteger) + ' DDF' ;

    VpfQtdDiasAnterior:= VpfQtdDiasAnterior + Tabela.FieldByName('I_NUM_DIA').AsInteger;

    VpfDParcelas.CodFormaPagamento:= Tabela.FieldByName('I_COD_FRM').AsInteger;

    if Tabela.FieldByName('I_COD_FRM').AsInteger <> 0 then
      VpfDParcelas.DesFormaPagamento:=  RNomFormaPagamento(Tabela.FieldByName('I_COD_FRM').AsInteger)
    else
      VpfDParcelas.DesFormaPagamento:=  RNomFormaPagamento(VpaDProposta.CodFormaPagamento);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.PreparaProdutosChamado(VpaDProposta: TRBDPropostaCorpo);
var
  VpfLaco : integer;
  VpfDPropostaProduto : TRBDPropostaProduto;
  VpfDPropostaServico : TRBDPropostaServico;
begin
  for VpfLaco := 0 to VpaDProposta.Produtos.Count -1 do
  begin
    VpfDPropostaProduto :=  TRBDPropostaProduto(VpaDProposta.Produtos.Items[Vpflaco]);
    AdicionaProdutoChamado(VpaDProposta,VpfDPropostaProduto.SeqItemChamado,VpfDPropostaProduto.SeqProdutoChamado,VpfDPropostaProduto.ValTotal);
  end;

  for VpfLaco := 0 to VpaDProposta.Servicos.Count -1 do
  begin
    VpfDPropostaServico :=  TRBDPropostaServico(VpaDProposta.Servicos.Items[Vpflaco]);
    AdicionaProdutoChamado(VpaDProposta,VpfDPropostaServico.SeqItemChamado,VpfDPropostaServico.SeqProdutoChamado,VpfDPropostaServico.ValTotal);
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.RSeqEmailDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQEMAIL) PROXIMO FROM PROPOSTAEMAIL');
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.RNomTipoProposta(VpaCodTipoProposta : Integer):String;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT NOMTIPOPROPOSTA FROM TIPOPROPOSTA '+
                            ' WHERE CODTIPOPROPOSTA = '+IntToStr(VpaCodTipoProposta));
  Result:= Aux.FieldByName('NOMTIPOPROPOSTA').AsString;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.RNomMaterialRotulo(VpaCodMaterial : Integer) : String;
begin
  result := '';
  if VpaCodMaterial <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select NOMMATERIALROTULO '+
                              ' from MATERIALROTULO '+
                              ' Where CODMATERIALROTULO = '+IntToStr(VpaCodMaterial));
    Result := Aux.FieldByName('NOMMATERIALROTULO').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.RNomProduto(VpaSeqProduto: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT C_NOM_PRO FROM CADPRODUTOS WHERE I_SEQ_PRO = ' +
                            IntToStr(VpaSeqProduto));
  Result := Aux.FieldByName('C_NOM_PRO').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.RCorpoEmailPadrao(VpaListaProposta : TList): String;
var
  VpfTextoPadrao : TStringList;
  VpfDProposta: TRBDPropostaCorpo;
  VpfLaco: Integer;
  VpfNumPropostas: String;
  VpfDescricaoTecnica : TStringList;
begin
  Result := '';
  if VpaListaProposta.Count > 0 then
  begin
    VpfDProposta   := TRBDPropostaCorpo(VpaListaProposta.Items[0]);
    VpfTextoPadrao := TStringList.Create;
    if (Varia.CNPJFilial = CNPJ_MIGRAMAQ) or (varia.CNPJFilial = CNPJ_MAQMUNDI) then
    begin
       VpfTextoPadrao.Add('Bom dia ' + VpfDProposta.NomContato + ',');
       VpfTextoPadrao.Add('');
    end
    else
    begin
       VpfTextoPadrao.Add('Prezado(a) ' + VpfDProposta.NomContato + ',');
       VpfTextoPadrao.Add('');
       VpfTextoPadrao.Add('');
    end;
    if VpaListaProposta.Count = 1 then
    begin
      if (Varia.CNPJFilial = CNPJ_MIGRAMAQ) or (varia.CNPJFilial = CNPJ_MAQMUNDI) then
      begin
         VpfTextoPadrao.Add('Conforme solicitado, segue anexo a proposta "'+IntToStr(VpfDProposta.SeqProposta)+'" ref. a '+RNomTipoProposta(VpfDProposta.CodTipoProposta));
      end
      else
      begin
         VpfTextoPadrao.Add('Conforme combinado, segue anexo a proposta "'+IntToStr(VpfDProposta.SeqProposta)+'" ref. a '+RNomTipoProposta(VpfDProposta.CodTipoProposta));
      end;
    end
    else
    begin
      VpfNumPropostas := '';
      for VpfLaco := 0 to VpaListaProposta.Count - 1 do
      begin
        VpfDProposta := TRBDPropostaCorpo(VpaListaProposta.Items[VpfLaco]);
        VpfNumPropostas := '"' + IntToStr(VpfDProposta.SeqProposta) + '" ,';
      end;
      VpfTextoPadrao.Add('Conforme combinado, seguem anexo as propostas ' + Copy(VpfNumPropostas, 1, Length(VpfNumPropostas) - 1));
    end;
    //if Varia.CNPJFilial = CNPJ_PERFOR then
    //begin
    //  VpfTextoPadrao.Add('');
    //  VpfTextoPadrao.Add('');
    //  VpfTextoPadrao.Add('As Horas de instalação e treinamento correm por conta da PERFOR.');
    //  VpfTextoPadrao.Add('Deslocamento, Estadia e Alimentação correm por conta do Cliente.');
    //  VpfTextoPadrao.Add('A Instalação será feita por técnico de fábrica PERFOR.');
    //  VpfTextoPadrao.Add('O Técnico fará treinamento detalhado na instalação do equipamento.');
    //end;
    if (Varia.CNPJFilial = CNPJ_MIGRAMAQ) or (varia.CNPJFilial = CNPJ_MAQMUNDI) then
    begin
      //VpfTextoPadrao.Add('');
    end
    else
    begin
      VpfTextoPadrao.Add('');
      VpfTextoPadrao.Add('');
    end;
    if (Varia.CNPJFilial = CNPJ_MIGRAMAQ) or (varia.CNPJFilial = CNPJ_MAQMUNDI) then
    begin
       VpfTextoPadrao.Add('Qualquer dúvida estou a disposição, fico no aguardo de um parecer para dar continuidade ao processo.');
       //VpfTextoPadrao.Add('');
    end
    else
    begin
      VpfTextoPadrao.Add('Ficamos à disposição para quaisquer dúvidas.');
      VpfTextoPadrao.Add('');
      VpfTextoPadrao.Add('');
    end;
    VpfTextoPadrao.Add(varia.RodapeEmailUsuario);

    VpfDescricaoTecnica := TStringList.create;
    VpfDescricaoTecnica.Text := Sistema.RRodapeCRM(TRBDPropostaCorpo(VpaListaProposta.Items[0]).CodFilial);
    if VpfDescricaoTecnica.Text <> '' then
    begin
      for VpfLaco := 0 to VpfDescricaoTecnica.Count - 1 do
        VpfTextoPadrao.Add(VpfDescricaoTecnica.Strings[VpfLaco]);
    end;
    VpfDescricaoTecnica.free;

    VpfTextoPadrao.Add(FunCotacao.RNomVendedor(VpfDProposta.CodVendedor));
    VpfTextoPadrao.Add(Minusculas(FunCotacao.REmailVencedor(VpfDProposta.CodVendedor)));
    VpfTextoPadrao.Add(SubstituiStr(FunCotacao.RFoneVendedor(VpfDProposta.CodVendedor), '0**', ''));
    Result := VpfTextoPadrao.Text;
    VpfTextoPadrao.Free;
  end
  else
    Result := 'NENHUMA PROPOSTA SELECIONADA!';
end;

{******************************************************************************}
function TRBFuncoesProposta.RNomAplicacao(VpaCodAplicacao: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT NOMAPLICACAO FROM APLICACAO WHERE CODAPLICACAO = ' +
                            IntToStr(VpaCodAplicacao));
  Result := Aux.FieldByName('NOMAPLICACAO').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.RNomeEmbalagem(VpaCodEmbalagem: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT NOM_EMBALAGEM FROM EMBALAGEM WHERE COD_EMBALAGEM = ' +
                            IntToStr(VpaCodEmbalagem));
  Result := Aux.FieldByName('NOM_EMBALAGEM').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.RNomFormaPagamento(VpaCodFormaPagamento: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Aux2,'Select C_NOM_FRM '+
                              ' from CADFORMASPAGAMENTO '+
                              ' Where I_COD_FRM = '+IntToStr(VpaCodFormaPagamento));
  Result := Aux2.FieldByName('C_NOM_FRM').AsString;
  Aux2.Close;
end;

{******************************************************************************}
function TRBFuncoesProposta.RNomMaterialLiner(VpaCodMaterial : Integer) : string;
begin
  result := '';
  if VpaCodMaterial <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select NOMMATERIALLINER '+
                              ' from MATERIALLINER '+
                              ' Where CODMATERIALLINER = '+IntToStr(VpaCodMaterial));
    Result := Aux.FieldByName('NOMMATERIALLINER').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.ExisteProduto(VpaCodProduto : String;VpaCodTabelaPreco : Integer;VpaDProProposta : TRBDPropostaProduto;VpaDProposta : TRBDPropostaCorpo):Boolean;
begin
  result := false;
  if VpaCodTabelaPreco = 0 then
    VpaCodTabelaPreco := Varia.TabelaPreco;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, PRO.N_RED_ICM,'+
                                  ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_KIT, PRO.C_IND_RET, PRO.C_IND_CRA, '+
                                  ' PRO.C_PAT_FOT, PRO.L_DES_TEC,'+
                                  ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                                  ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                                  ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, QTD.N_QTD_FIS ' +
                                  ' from CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                                  ' MOVQDADEPRODUTO Qtd ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                                  ' and PRE.I_COD_TAB = '+IntToStr(VpaCodTabelaPreco)+
                                  ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                  ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and Pro.c_ven_avu = ''S'''+
                                  ' and PRE.I_COD_CLI  = 0 ',true);

    result := not Tabela.Eof;
    if result then
    begin
      with VpaDProProposta do
      begin
        UMOriginal := Tabela.FieldByName('C_Cod_Uni').Asstring;
        UM := Tabela.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := UM;
        ValUnitarioOriginal := Tabela.FieldByName('VlrReal').AsFloat;
        QtdEstoque := Tabela.FieldByName('QdadeReal').AsFloat;
        CodProduto := Tabela.FieldByName(Varia.CodigoProduto).Asstring;
        ValUnitario := Tabela.FieldByName('VlrReal').AsFloat;
        QtdProduto := 1;
        SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
        PathFoto := Tabela.FieldByName('C_PAT_FOT').AsString;
        DesTecnica := Tabela.FieldByName('L_DES_TEC').AsString;
      end;
    end;
    Tabela.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.ExisteAmostra(VpaCodAmostra: Integer; VpaDAmostraProposta : TRBDPropostaAmostra): Boolean;
begin
  Result:= False;
  if VpaCodAmostra <> 0 then
  begin
    AdicionaSQLAbreTabela(Tabela,'SELECT NOMAMOSTRA, DESIMAGEM,CODAMOSTRAINDEFINIDA FROM AMOSTRA'+
                                 ' WHERE CODAMOSTRA = '+IntToStr(VpaCodAmostra));
    Result:= not Tabela.Eof;
    if Result then
    begin
      VpaDAmostraProposta.CodAmostraIndefinida:= Tabela.FieldByName('CODAMOSTRAINDEFINIDA').AsInteger;
      VpaDAmostraProposta.NomAmostra:= Tabela.FieldByName('NOMAMOSTRA').AsString;
      VpaDAmostraProposta.DesImagem:= Tabela.FieldByName('DESIMAGEM').AsString;
     end;
    Tabela.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.ExisteCondicaoPagamento(
  VpaCodCondicaoPagamento: Integer;
  VpaDCondicaoPafamentoAmostra: TRBDPropostaCondicaoPagamento): Boolean;
begin
  Result:= False;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSQLAbreTabela(Tabela,'SELECT I_COD_PAG, C_NOM_PAG FROM CADCONDICOESPAGTO'+
                                 ' WHERE I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
    Result:= not Tabela.Eof;
    if Result then
    begin
      VpaDCondicaoPafamentoAmostra.CodCondicao:= Tabela.FieldByName('I_COD_PAG').AsInteger;
      VpaDCondicaoPafamentoAmostra.NomCondicao:= Tabela.FieldByName('C_NOM_PAG').AsString;
     end;
    Tabela.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.Existecor(VpaCodCor :String;VpaDProProposta : TRBDPropostaProduto):Boolean;
begin
  result := false;
  if VpaCodCor <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              ' Where COD_COR = '+VpaCodCor );
    result := not Aux.eof;
    if result then
    begin
      VpaDProProposta.CodCor := Aux.FieldByName('COD_COR').AsInteger;
      VpaDProProposta.DesCor := Aux.FieldByName('NOM_COR').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.Existecor(VpaCodCor: String; var VpaNomCor: String): Boolean;
begin
  Result:= False;
  if VpaCodCor <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'SELECT * FROM COR'+
                              ' WHERE COD_COR = '+VpaCodCor);
    Result:= not Aux.Eof;
    if Result then
      VpaNomCor:= Aux.FieldByName('NOM_COR').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.ExisteFormaPagamento(VpaCodFormaPagamento: Integer;
  VpaDParcela: TRBDPropostaParcelas): Boolean;
begin
  Result:= False;
  if VpaCodFormaPagamento <> 0 then
  begin
    AdicionaSQLAbreTabela(Tabela,'SELECT I_COD_FRM, C_NOM_FRM FROM CADFORMASPAGAMENTO'+
                                 ' WHERE I_COD_FRM = '+IntToStr(VpaCodFormaPagamento));
    Result:= not Tabela.Eof;
    if Result then
    begin
      VpaDParcela.CodFormaPagamento:= Tabela.FieldByName('I_COD_FRM').AsInteger;
      VpaDParcela.DesFormaPagamento:= Tabela.FieldByName('C_NOM_FRM').AsString;
     end;
    Tabela.Close;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CadDPropostaMaquinaCliente(VpaDProposta: TRBDPropostaCorpo);
var
  VpfDMaquinaCliente : TRBDPropostaMaquinaCliente;
begin
  FreeTObjectsList(VpaDProposta.MaquinasCliente);
  AdicionaSQLAbreTabela(Tabela,' SELECT CODFILIAL, SEQPROPOSTA, SEQITEM, SEQPRODUTO, CODEMBALAGEM, ' +
                               '        CODAPLICACAO, DESPRODUCAO, DESSENTIDOPASSAGEM, DESDIAMETROTUBO, DESOBSERVACAO ' +
                               '  FROM PROPOSTAPRODUTOCLIENTE' +
                               ' WHERE CODFILIAL = ' + IntToStr(VpaDProposta.CodFilial) +
                               '   AND SEQPROPOSTA = ' + IntToStr(VpaDProposta.SeqProposta) +
                               ' ORDER BY SEQITEM ');

  While not Tabela.eof do
  begin
    VpfDMaquinaCliente := VpaDProposta.addMaquinaCliente;
    with VpfDMaquinaCliente do
    begin
      SeqItem := Tabela.FieldByName('SEQITEM').AsInteger;
      SeqProduto  := Tabela.FieldByName('SEQPRODUTO').AsInteger;
      CodFilial := Tabela.FieldByName('CODFILIAL').AsInteger;
      SeqProposta := Tabela.FieldByName('SEQPROPOSTA').AsInteger;
      CodEmbalagem := Tabela.FieldByName('CODEMBALAGEM').AsInteger;
      CodAplicacao := Tabela.FieldByName('CODAPLICACAO').AsInteger;
      DesProducao := Tabela.FieldByName('DESPRODUCAO').AsString;
      DesSentidoPassagem := Tabela.FieldByName('DESSENTIDOPASSAGEM').AsString;
      DesDiametroCubo := Tabela.FieldByName('DESDIAMETROTUBO').AsString;
      DesObservacao := Tabela.FieldByName('DESOBSERVACAO').AsString;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CalculaParcelas(VpaCodFormaPagamento: Integer; VpaDProposta : TRBDPropostaCorpo);
begin
  PreencheClasseParcelas(VpaCodFormaPagamento,VpaDProposta);
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CalCulaValorParcelas(VpaDProposta: TRBDPropostaCorpo);
var
  VpfDParcelas: TRBDPropostaParcelas;
  VpfLaco: Integer;
begin
  VpfLaco:= 0;
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM MOVCONDICAOPAGTO '+
                            ' WHERE I_COD_PAG = ' +IntToStr(VpaDProposta.CodCondicaoPagamento)+
                            ' ORDER BY I_NRO_PAR');
  while not Tabela.Eof do
  begin
    VpfDParcelas := TRBDPropostaParcelas(VpaDProposta.Parcelas.items[VpfLaco]);
    VpfDParcelas.ValPagamento:= (VpaDProposta.ValTotal * Tabela.FieldByName('N_PER_PAG').AsInteger) /100;
    VpfLaco:= VpfLaco+1;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CalculaValorTotal(VpaDProposta : TRBDPropostaCorpo);
var
  VpfLaco : Integer;
  VpfDProdutoProposta : TRBDPropostaProduto;
  VpfDAmostraProduto : TRBDPropostaAmostra;
  VpfDServicoProposta: TRBDPropostaServico;
  VpfDProdutoPropostaMaterialAcabamento: TRBDPropostaMaterialAcabamento;
begin
  VpaDProposta.ValTotal := 0;
  VpaDProposta.ValTotalProdutos:= 0;
  VpaDProposta.ValTotalIpi:= 0;
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoProposta := TRBDPropostaProduto(VpaDProposta.Produtos.items[VpfLaco]);
    VpaDProposta.ValTotal := VpaDProposta.ValTotal + VpfDProdutoProposta.ValTotal;
    VpaDProposta.ValTotalProdutos:= VpaDProposta.ValTotalProdutos + VpfDProdutoProposta.ValTotal;
    VpaDProposta.ValTotalIpi:= VpaDProposta.ValTotalIpi + VpfDProdutoProposta.ValIPI;
  end;

  for VpfLaco := 0 to VpaDProposta.Amostras.count - 1 do
  begin
    VpfDAmostraProduto := TRBDPropostaAmostra(VpaDProposta.Amostras.items[VpfLaco]);
    VpaDProposta.ValTotal := VpaDProposta.ValTotal + VpfDAmostraProduto.ValTotal;
  end;

  for VpfLaco:= 0 to VpaDProposta.Servicos.count - 1 do
  begin
    VpfDServicoProposta:= TRBDPropostaServico(VpaDProposta.Servicos.Items[VpfLaco]);
    VpaDProposta.ValTotal:= VpaDProposta.ValTotal + VpfDServicoProposta.ValTotal;
  end;

  for VpfLaco := 0 to VpaDProposta.MaterialAcabamento.Count - 1 do
  begin
    VpfDProdutoPropostaMaterialAcabamento:= TRBDPropostaMaterialAcabamento(VpaDProposta.MaterialAcabamento.Items[VpfLaco]);
    VpaDProposta.ValTotal:= VpaDProposta.ValTotal + VpfDProdutoPropostaMaterialAcabamento.ValTotal;
  end;

  if VpaDProposta.PerDesconto <> 0 then
    VpaDProposta.ValTotal := VpaDProposta.ValTotal - ((VpaDProposta.ValTotal * VpaDProposta.PerDesconto)/100)
  else
    if VpaDProposta.ValDesconto <> 0 then
      VpaDProposta.ValTotal := VpaDProposta.ValTotal - VpaDProposta.ValDesconto;

  if VpaDProposta.CodCondicaoPagamento <> 0 then
  begin
    CriaParcelas.Parcelas(VpaDProposta.ValTotal,VpaDProposta.CodCondicaoPagamento,false,date);
    VpaDProposta.ValTotal := CriaParcelas.valorTotal;
  end;

  if VpaDProposta.ValFrete <> 0 then
    VpaDProposta.ValTotal := VpaDProposta.ValTotal + VpaDProposta.ValFrete;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.CarDProposta(VpaDProposta: TRBDPropostaCorpo;VpaCodFilial, VpaSeqProposta : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from PROPOSTA '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' and SEQPROPOSTA = ' +IntToStr(VpaSeqProposta),true);
  with VpaDProposta do
  begin
    SeqProposta := Tabela.FieldByname('SEQPROPOSTA').AsInteger;
    CodFilial := Tabela.FieldByname('CODFILIAL').AsInteger;
    CodProspect := Tabela.FieldByname('CODPROSPECT').AsInteger;
    CodCliente := Tabela.FieldByname('CODCLIENTE').AsInteger;
    CodCondicaoPagamento := Tabela.FieldByname('CODCONDICAOPAGAMENTO').AsInteger;
    CodFormaPagamento := Tabela.FieldByname('CODFORMAPAGAMENTO').AsInteger;
    CodSetor:= Tabela.FieldByname('CODSETOR').AsInteger;
    CodTipoProposta:= Tabela.FieldByname('CODTIPOPROPOSTA').AsInteger;
    DatProposta := Tabela.FieldByname('DATPROPOSTA').AsDateTime;
    DatValidade := Tabela.FieldByname('DATVALIDADE').AsDateTime;
    DatPrevisaoCompra := Tabela.FieldByname('DATPREVISAOCOMPRA').AsDateTime;
    DatPrevisaoVisitaTec := Tabela.FieldByName('DATPREVISAOVISITATEC').AsDateTime;
    IndComprou := Tabela.FieldByname('INDCOMPROU').AsString = 'S';
    IndComprouConcorrente := Tabela.FieldByname('INDCOMPROUCONCORRENTE').AsString = 'S';
    PerDesconto := Tabela.FieldByname('PERDESCONTO').AsFloat;
    ValDesconto := Tabela.FieldByname('VALDESCONTO').AsFloat;
    ValConcorrente := Tabela.FieldByname('VALCONCORRENTE').AsFloat;
    CodConcorrente := Tabela.FieldByname('CODCONCORRENTE').AsInteger;
    CodMotivoVenda := Tabela.FieldByname('CODMOTIVOVENDA').AsInteger;
    NomContato := Tabela.FieldByname('NOMCONTATO').AsString;
    DesEmail := Tabela.FieldByname('DESEMAIL').AsString;
    NomContato := Tabela.FieldByname('NOMCONTATO').AsString;
    CodProfissao := Tabela.FieldByname('CODPROFISSAO').AsInteger;
    DesObservacao := Tabela.FieldByname('DESOBSERVACAO').AsString;
    DesObservacaoComercial := Tabela.FieldByname('DESOBSERVACAOCOMERCIAL').AsString;
    DesObservacaoInstalacao := Tabela.FieldByname('DESOBSERVACAOINSTALACAO').AsString;
    DesObsDataInstalacao:= Tabela.FieldByname('DESOBSDATAINSTALACAO').AsString;
    ValTotal := Tabela.FieldByname('VALTOTAL').AsFloat;
    CodVENDEDOR := Tabela.FieldByname('CODVENDEDOR').AsInteger;
    CodUsuario := Tabela.FieldByname('CODUSUARIO').AsInteger;
    SeqProdutoInteresse := Tabela.FieldByname('SEQPRODUTOINTERESSE').AsInteger;
    QtdPrazoEntrega := Tabela.FieldByname('QTDPRAZOENTREGA').AsInteger;
    CodEstagio := Tabela.FieldByname('CODESTAGIO').AsInteger;
    TipFrete := Tabela.FieldByname('TIPFRETE').AsInteger;
    TipHorasInstalacao := Tabela.FieldByName('TIPHORASINSTALACAO').AsInteger;
    ValFrete := Tabela.FieldByName('VALFRETE').AsFloat;
    IndDevolveraVazio := Tabela.FieldByname('INDDEVOLVERAVAZIO').AsString = 'S';
    DesGarantia:= Tabela.FieldByName('DESTEMPOGARANTIA').AsString;
    CodObsInstalacao:= Tabela.FieldByName('CODOBSINSTALACAO').AsInteger;
  end;
  Tabela.close;
  CarDSetorProposta(VpaDProposta);
  CarDPropostaProduto(VpaDProposta);
  CarDPropostaProdutoSemQtd(VpaDProposta);
  CarDPropostaAmostra(VpaDProposta);
  CarDPropostaLocacao(VpaDProposta);
  CarDPropostaServico(VpaDProposta);
  CarDPropostaProdutoRotulado(VpaDProposta);
  CadDPropostaMaquinaCliente(VpaDProposta);
  CarDPropostaVendaAdicional(VpaDProposta);
  CarDPropostaCondicaoPagamento(VpaDProposta);
  CarDPropostaMaterialAcabamento(VpaDProposta);
  CarDPropostaParcelas(VpaDProposta);
end;

{******************************************************************************}
function TRBFuncoesProposta.GravaDProposta(VpaDProposta : TRBDPropostaCorpo) : string;
begin
  result := '';
  ExcluiProposta(VpaDProposta.CodFilial,VpaDProposta.SeqProposta,false);
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROPOSTA '+
                                 ' Where CODFILIAL = '+IntToStr(VpaDProposta.CodFilial)+
                                 ' and SEQPROPOSTA = ' +IntToStr(VpaDProposta.SeqProposta));
  with VpaDProposta do
  begin
    if SeqProposta = 0 then
      Cadastro.Insert
    else
    begin
      if Cadastro.Eof then
        result := 'ERRO NA LOCALIZAÇÃO DO REGISTRO!!!'#13'Não foi possivel alterar a proposta "'+IntToStr(SeqProposta)+'", porque ela não existe gravada no banco de dados.'
      else
        Cadastro.edit;
    end;
    if result = '' then
    begin
      Cadastro.FieldByname('CODFILIAL').AsInteger := CodFilial;
      if CodProspect <> 0 then
      begin
        Cadastro.FieldByname('CODCLIENTE').Clear;
        Cadastro.FieldByname('CODPROSPECT').AsInteger := CodProspect;
      end
      else
      begin
        Cadastro.FieldByname('CODPROSPECT').Clear;
        Cadastro.FieldByname('CODCLIENTE').AsInteger := CodCliente;
      end;
      Cadastro.FieldByname('CODCONDICAOPAGAMENTO').AsInteger := CodCondicaoPagamento;
      Cadastro.FieldByname('CODESTAGIO').AsInteger := CodEstagio;
      Cadastro.FieldByname('CODSETOR').AsInteger:= CodSetor;
      Cadastro.FieldByname('CODFORMAPAGAMENTO').AsInteger := CodFormaPagamento;
      Cadastro.FieldByname('DATPROPOSTA').AsDateTime := DatProposta;
      Cadastro.FieldByname('DATVALIDADE').AsDateTime := DatValidade;
      Cadastro.FieldByname('DATPREVISAOCOMPRA').AsDateTime := DatPrevisaoCompra;
      Cadastro.FieldByName('DATPREVISAOVISITATEC').AsDateTime := DatPrevisaoVisitaTec;
      if IndComprou then
        Cadastro.FieldByname('INDCOMPROU').AsString := 'S'
      else
        Cadastro.FieldByname('INDCOMPROU').AsString := 'N';
      if IndComprouConcorrente then
        Cadastro.FieldByname('INDCOMPROUCONCORRENTE').AsString := 'S'
      else
        Cadastro.FieldByname('INDCOMPROUCONCORRENTE').AsString := 'N';
      if IndDevolveraVazio then
        Cadastro.FieldByname('INDDEVOLVERAVAZIO').AsString := 'S'
      else
        Cadastro.FieldByname('INDDEVOLVERAVAZIO').AsString := 'N';
      Cadastro.FieldByname('TIPFRETE').AsInteger := TipFrete;
      Cadastro.FieldByName('TIPHORASINSTALACAO').AsInteger := TipHorasInstalacao;
      Cadastro.FieldByname('PERDESCONTO').AsFloat := PerDesconto;
      Cadastro.FieldByname('VALDESCONTO').AsFloat := ValDesconto;
      if ValConcorrente <> 0 then
        Cadastro.FieldByname('VALCONCORRENTE').AsFloat := ValConcorrente
      else
        Cadastro.FieldByname('VALCONCORRENTE').clear;
      if CodTipoProposta <> 0 then
        Cadastro.FieldByname('CODTIPOPROPOSTA').AsInteger := CodTipoProposta
      else
        Cadastro.FieldByname('CODTIPOPROPOSTA').Clear;
      if CodConcorrente <> 0 then
        Cadastro.FieldByname('CODCONCORRENTE').AsInteger := CodConcorrente
      else
        Cadastro.FieldByname('CODCONCORRENTE').Clear;
      if CodMotivoVenda <> 0 then
        Cadastro.FieldByname('CODMOTIVOVENDA').AsInteger := CodMotivoVenda
      else
        Cadastro.FieldByname('CODMOTIVOVENDA').Clear;
      Cadastro.FieldByname('NOMCONTATO').AsString := NomContato;
      Cadastro.FieldByname('DESEMAIL').AsString := lowercase(DesEmail);
      Cadastro.FieldByname('NOMCONTATO').AsString := NomContato;
      if CodProfissao <> 0 then
        Cadastro.FieldByname('CODPROFISSAO').AsInteger := CodProfissao
      else
        Cadastro.FieldByname('CODPROFISSAO').Clear;
      Cadastro.FieldByname('DESOBSERVACAO').AsString := DesObservacao;
      Cadastro.FieldByName('DESOBSERVACAOCOMERCIAL').AsString := DesObservacaoComercial;
      Cadastro.FieldByName('DESOBSERVACAOINSTALACAO').AsString:= DesObservacaoInstalacao;
      Cadastro.FieldByName('DESOBSDATAINSTALACAO').AsString:= DesObsDataInstalacao;
      Cadastro.FieldByname('VALFRETE').AsFloat := ValFrete;
      Cadastro.FieldByname('VALTOTAL').AsFloat := ValTotal;
      Cadastro.FieldByname('VALTOTALPRODUTOS').AsFloat := ValTotalProdutos;
      Cadastro.FieldByname('VALTOTALIPI').AsFloat := ValTotalIpi;
      Cadastro.FieldByname('CODVENDEDOR').AsInteger := CodVENDEDOR;
      Cadastro.FieldByname('CODUSUARIO').AsInteger := CodUsuario;
      Cadastro.FieldByname('QTDPRAZOENTREGA').AsInteger := QtdPrazoEntrega;
      Cadastro.FieldByName('DESTEMPOGARANTIA').AsString:= DesGarantia;
      if CodObsInstalacao <> 0 then
        Cadastro.FieldByName('CODOBSINSTALACAO').AsInteger:= CodObsInstalacao
      else
        Cadastro.FieldByName('CODOBSINSTALACAO').Clear;
      if SeqProdutoInteresse <> 0 then
        Cadastro.FieldByname('SEQPRODUTOINTERESSE').AsInteger := SeqProdutoInteresse
      else
        Cadastro.FieldByname('SEQPRODUTOINTERESSE').clear;
      if SeqProposta = 0 then
        SeqProposta := RSeqPropostaDisponivel(VpaDProposta.CodFilial);
      Cadastro.FieldByname('SEQPROPOSTA').AsInteger := SeqProposta;

      cadastro.post;
      result :=Cadastro.AMensagemErroGravacao;
    end;
  end;
  Cadastro.close;
  if result = '' then
  begin
    Result := GravaDPropostaProduto(VpaDProposta);
    if Result = '' then
    begin
      Result:= GravaDPropostaAmostra(VpaDProposta);
      if Result = '' then
      begin
        Result:= GravaDPropostaLocacao(VpaDProposta);
        if Result = '' then
        begin
          Result:= GravaDPropostaServico(VpaDProposta);
          if result = '' then
          begin
            result := GravaDPropostaProdutoSemQtd(VpaDProposta);
            if result = '' then
            begin
              Result := GravaDProdutoRotulados(VpaDProposta);
              if Result = '' then
              begin
                Result := GravaDMaquinaCliente(VpaDProposta);
                if result = '' then
                begin
                  Result := GravaDVendaAdicional(VpaDProposta);
                end;
                if Result = '' then
                begin
                  Result:= GravaDPropostaProdutoChamado(VpaDProposta);
                end;
                if Result = '' then
                begin
                  Result:= GravaDPropostaCondicaoPagamento(VpaDProposta);
                end;
                if Result = '' then
                begin
                  Result:= GravaDPropostaMaterialAcabamento(VpaDProposta);
                end;
                if Result = '' then
                begin
                  Result:= GravaDPropostaParcelas(VpaDProposta);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  if (result = '') and (varia.EstagioCotacaoAlterada <> 0) then
    result := GravaLogEstagio(VpaDProposta.CodFilial,VpaDProposta.SeqProposta,Varia.EstagioCotacaoAlterada,varia.CodigoUsuario,'PROPOSTA ALTERADA');
end;

{******************************************************************************}
function TRBFuncoesProposta.EnviaEmailCliente(VpaListaPropostas: TList; VpaDCliente : TRBDCliente) : string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfEmailVendedor,
  VpfCorpoEMailProposta6 : String;
  VpfDFilial : TRBDFilial;
  VpfLaco, VpfQtdOpcoes, VpfOpcao : Integer;
  VpfOpcoes : TStringLIst;
  VpfDProposta: TRBDPropostaCorpo;
begin
  VpfDFilial := TRBDFilial.cria;
  VprMensagem.Clear;
  result := '';
  if VpaListaPropostas.count < 1 then
    Result := 'NENHUMA PROPOSTA SELECIONADA!!!'#13 + 'É necessário Selecionar ao menos uma proposta.';
  if Result = '' then
  begin
    if (VpaListaPropostas.Count > 0) and (TRBDPropostaCorpo(VpaListaPropostas.Items[0]).TipModeloProposta in [6,7]) then
    begin
      VpfCorpoEMailProposta6 := RCorpoEmailPadrao(VpaListaPropostas);
      FCorpoEmailProposta := TFCorpoEmailProposta.CriarSDI(Application, '', true);
      if not FCorpoEmailProposta.ConfirmaCorpoEMail(VpfCorpoEMailProposta6) then
        result := 'ENVIO DO E-MAIL CANCELADO PELO USUÁRIO!';
      FCorpoEmailProposta.Free;
    end;

    if result = '' then
    begin
      VpfDProposta := VpaListaPropostas.Items[0];
      Sistema.CarDFilial(VpfDFilial,VpfDProposta.CodFilial);
      result := AnexaLogos(VpfDFilial);
      if result = '' then
      begin
        if VpfDProposta.DesEmail = '' then
          result := 'E-MAIL DO PROSPECT NÃO PREENCHIDO!!!'#13'Falta preencher o e-mail do prospect.';
        if result = '' then
        begin
          VpfOpcoes := CarOpcoesProposta(VpfDProposta);
          for VpfLaco := 0 to VpfOpcoes.Count - 1 do
          begin
            VpfOpcao := StrToInt(VpfOpcoes.Strings[VpfLaco]);

            VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
            VpfEmailHTML.ContentType := 'text/html';
            VpfEmailHTML.DisplayName := 'Proposta Seguranca2';
            VpfEmailHTML.CharSet := 'ISO-8859-1'; // NOSSA LINGUAGEM PT-BR (Latin-1)!!!!
            VpfEmailHTML.ContentTransfer := '16bit'; // para SAIR ACENTUADO !!!! Pois, 8bit SAI SEM
            case VpfDProposta.TipModeloProposta of
              0 : MontaEmailProposta(VpfEmailHTML.Body,VpfDProposta,VpaDCliente,VpfDFilial,VpfOpcao);
              1 : MontaEmailPropostaModelo1(VpfEmailHTML.Body,VpfDProposta,VpaDCliente,VpfDFilial,VpfOpcao);
              2 : MontaEmailPropostaModelo2(VpfEmailHTML.Body,VpfDProposta,VpaDCliente,VpfDFilial);
              3 : MontaEmailPropostaModelo3(VpfEmailHTML.Body,VpfDProposta,VpaDCliente,VpfDFilial);
              4 : MontaEmailsPropostaHomero(VpfEmailHTML.Body,VpfDProposta,VpaDCliente,VpfDFilial);
              5 : begin
                    MontaEmailPropostaRotuladora(VpfEmailHTML.Body,VpfDProposta,VpaDCliente,VpfDFilial);
      //              exit;
                  end;
              6,7: begin
                   MontaEmailPropostaEmAnexo(VpfEmailHTML.Body,VpaListaPropostas,VpaDCliente,VpfDFilial,VpfCorpoEMailProposta6);
                 end;
            end;
            VpfEmailHTML.Body.Text := RetiraAcentuacao(VpfEmailHTML.Body.Text);
            VprMensagem.From.Name := VpfDFilial.NomFantasia;
      //      VpfEmailHTML.Body.Text := RetiraAcentuacaoHTML(VpfEmailHTML.Body.Text);
      //      VpfEmailHTML.Body.SaveToFile('c:\proposta.html');
            if VpfDProposta.DesEmailSetor <> '' then
            begin
              VprMensagem.From.Address := VpfDProposta.DesEmailSetor;
              VprMensagem.ReceiptRecipient.Text  := VpfDProposta.DesEmailSetor;
              VprMensagem.Recipients.Add.Address := VpfDProposta.DesEmailSetor;
              VprMensagem.ReplyTo.EMailAddresses := VpfDProposta.DesEmailSetor;
            end
            else
            begin
              VprMensagem.From.Address := VpfDFilial.DesEmailComercial;
              VprMensagem.ReceiptRecipient.Text  := VpfDFilial.DesEmailComercial;
              VprMensagem.Recipients.Add.Address := VpfDFilial.DesEmailComercial;
              VprMensagem.ReplyTo.EMailAddresses := VpfDFilial.DesEmailComercial;
            end;

            if config.EnviarCopiaPropostaEmailComerical then
              VprMensagem.Recipients.add.Address := VpfDProposta.DesEmail;
            if (VpfDProposta.DesEmailSetor <> '') then
            begin
               VprMensagem.BccList.EMailAddresses:= VpfDProposta.DesEmailSetor;
            end;

            VpfEmailVendedor := FunCotacao.REmailVencedor(VpfDProposta.CodVendedor);
            if VpfEmailVendedor <> '' then
            begin
              VprMensagem.Recipients.Add.Address := VpfEmailVendedor;
              if config.RetornoEmailPropostaParaoVendedor then
                VprMensagem.ReplyTo.EMailAddresses := VpfEmailVendedor;
            end;

            if VpfOpcao <> 0 then
              VprMensagem.Subject := VpaDCliente.NomCliente+ ' - Proposta ' +IntToStr(VpfDProposta.SeqProposta)+' - opção '+IntToStr(VpfOpcao)
            else
              VprMensagem.Subject := VpaDCliente.NomCliente+ ' - Proposta ' +IntToStr(VpfDProposta.SeqProposta);
            result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial);
            if Result = '' then
            begin
              result := GravaDEmail(VpfDProposta);
              if result = '' then
                result := AlteraEstagioProposta(VpfDProposta.CodFilial,VpfDProposta.SeqProposta,Varia.CodigoUsuario,Varia.EstagioAguardandoRecebimentoProposta,'');
            end;
            VpfEmailHTML.free;
          end;
          VpfOpcoes.free;
        end;
      end;
    end;
  end;
  VpfDFilial.free;
  if result = '' then
    ConcluiAmostraPendenteEnvioEmail(VpfDProposta);
end;

{******************************************************************************}
function TRBFuncoesProposta.EstagioDuplicado(VpaEstagios: TList): Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDEstagioInterno, VpfDEstagioExterno: TRBDEEstagioProducaoGrupoUsuario;
begin
  Result := false;
  for VpfLacoExterno := 0 to VpaEstagios.Count - 2 do
  begin
    VpfDEstagioExterno := TRBDEEstagioProducaoGrupoUsuario(VpaEstagios.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaEstagios.Count - 1 do
    begin
      VpfDEstagioInterno := TRBDEEstagioProducaoGrupoUsuario(VpaEstagios.Items[VpfLacoInterno]);
      if VpfDEstagioInterno.CodEstagio = VpfDEstagioExterno.CodEstagio then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.AlteraEstagioProposta(VpaCodFilial,VpaSeqProposta, VpaCodUsuario, VpaCodEstagio : Integer;VpaDesMotivo : String):String;
begin
  result := '';
  try
    ExecutaComandoSql(Aux,'UPDATE PROPOSTA ' +
                          ' Set CODESTAGIO = ' + IntToStr(VpaCodEstagio)+
                          ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' and SEQPROPOSTA = ' + IntToStr(VpaSeqProposta));
  except
    on e : exception do result := 'ERRO NA ALTERAÇÃO DO ESTAGIO DA PROPOSTA!!!'#13+e.message;
  end;
  if result = '' then
  begin
    result := GravaLogEstagio(VpaCodFilial,VpaSeqProposta,VpaCodEstagio,VpaCodUsuario,VpaDesMotivo);
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.AlteraEstagioProposta(VpaPropostas: TList; VpaCodUsuario, VpaCodEstagio: Integer;
  VpaDesMotivo: String): String;
var
  VpfLaco : Integer;
  VpfDProposta : TRBDPropostaCorpo;
begin
  result := '';
  for VpfLaco := 0 to VpaPropostas.Count - 1 do
  begin
    VpfDProposta := TRBDPropostaCorpo(VpaPropostas.Items[VpfLaco]);
    result :=  AlteraEstagioProposta(VpfDProposta.CodFilial,VpfDProposta.SeqProposta,VpaCodUsuario,VpaCodEstagio,VpaDesMotivo);
    if result <> '' then
      break;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.AlteraEstagioPropostas(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaPropostas, VpaDesMotivo : String):String;
var
  VpfProposta : integer;
begin
  result := '';
  try
    ExecutaComandoSql(Aux,'UPDATE PROPOSTA ' +
                          ' Set CODESTAGIO = ' + IntToStr(VpaCodEstagio)+
                          ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' and PROPOSTA in (' + VpaPropostas+')');
  except
    on e : exception do result := 'ERRO NA ALTERAÇÃO DOS ESTAGIOS DA PROPOSTA!!!'#13+e.message;
  end;
  While length(VpaPropostas) > 0 do
  begin
    VpfProposta := strtoInt(CopiaAteChar(VpaPropostas,','));
    VpaPropostas := DeleteAteChar(VpaPropostas,',');
    GravaLogEstagio(VpaCodFilial,VpfProposta,VpaCodEstagio,VpaCodUsuario,VpaDesMotivo);
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.AnexaLogos(VpaDFilial: TRBDFilial): string;
var
  Vpfbmppart : TIdAttachmentFile;
begin
  result := '';
  if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';

  if not ExisteArquivo(varia.PathVersoes+'\'+IntToStr(VpaDFilial.CodFilial)+'.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\'+IntToStr(VpaDFilial.CodFilial)+'.jpg'+'"';
  if result = '' then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDFilial.CodFilial)+'.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDFilial.CodFilial)+'.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\efi.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := 'efi.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';
  end;
end;

{******************************************************************************}
procedure TRBFuncoesProposta.AdicionaProdutoChamado(VpaDProposta: TRBDPropostaCorpo; VpaSeqItemChamado, VpaSeqProdutoChamado : Integer;VpaValTotal : Double);
var
  VpfLaco : Integer;
  VpfDProdutoChamado : TRBDPropostaProdutoChamado;
  VpfExisteProdutoChamado : Boolean;
begin
  VpfExisteProdutoChamado := false;
  for VpfLaco := 0 to VpaDProposta.ProdutosChamado.Count-1 do
  begin
    VpfDProdutoChamado := TRBDPropostaProdutoChamado(VpaDProposta.ProdutosChamado.Items[VpfLaco]);
    if (VpfDProdutoChamado.SeqItemChamado = VpaSeqItemChamado)   then
    begin
      VpfExisteProdutoChamado := true;
      VpfDProdutoChamado.ValTotal := VpfDProdutoChamado.ValTotal + VpaValTotal;
      break;
    end;
  end;
  if not VpfExisteProdutoChamado then
  begin
    VpfDProdutoChamado :=  VpaDProposta.addProdutoChamado;
    VpfDProdutoChamado.SeqItemChamado :=  VpaSeqItemChamado;
    VpfDProdutoChamado.SeqProdutoChamado := VpaSeqProdutoChamado;
    VpfDProdutoChamado.ValTotal := VpaValTotal;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.AdicionaPropostaChamado(VpaCodFilial,VpaSeqProposta,VpaNumChamado : Integer) : string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHAMADOPROPOSTA');
  Cadastro.insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  Cadastro.FieldByName('SEQPROPOSTA').AsInteger := VpaSeqProposta;
  Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaNumChamado;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO CHAMADOPROPOSTA!!!'#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProposta.ConcluiAmostraPendenteEnvioEmail(VpaDProposta : TRBDPropostaCorpo) :string;
var
  VpfLaco : Integer;
  VpfDAmostra : TRBDPropostaAmostra;
  VpfFunAmostra : TRBFuncoesAmostra;
begin
  result := '';
  VpfFunAmostra := TRBFuncoesAmostra.cria(Cadastro.ASQLConnection);
  for VpfLaco := 0 to VpaDProposta.Amostras.Count - 1 do
  begin
    VpfDAmostra := TRBDPropostaAmostra(VpaDProposta.Amostras.Items[VpfLaco]);
    if VpfDAmostra.CodAmostraIndefinida <> 0 then
    begin
      result := VpfFunAmostra.ConcluiAmostra(VpfDAmostra.CodAmostraIndefinida,Date);
    end;
  end;
  VpfFunAmostra.Free;
end;

{******************************************************************************}
function TRBFuncoesProposta.ExisteProduto(VpaCodProduto: String; VpaDPropostaLocacao: TRBDPropostaLocacaoCorpo): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT I_SEQ_PRO, C_COD_PRO, C_NOM_PRO, L_DES_TEC'+
                            ' FROM CADPRODUTOS'+
                            ' WHERE C_COD_PRO = '+VpaCodProduto);
  VpaDPropostaLocacao.SeqProduto:= Aux.FieldByName('I_SEQ_PRO').AsInteger;
  VpaDPropostaLocacao.CodProduto:= Aux.FieldByName('C_COD_PRO').AsString;
  VpaDPropostaLocacao.NomProduto:= Aux.FieldByName('C_NOM_PRO').AsString;
  VpaDPropostaLocacao.DesEmail:= Aux.FieldByName('L_DES_TEC').AsString;
  Result:= (VpaDPropostaLocacao.SeqProduto <> 0);
end;

{******************************************************************************}
function TRBFuncoesProposta.ExisteProduto(VpaCodProduto: String; VpaDProdutoAdicional: TRBDPropostaVendaAdicional): Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, PRO.N_RED_ICM,'+
                                  ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_KIT, PRO.C_IND_RET, PRO.C_IND_CRA, '+
                                  ' PRO.C_PAT_FOT, PRO.L_DES_TEC,'+
                                  ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                                  ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                                  ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, QTD.N_QTD_FIS ' +
                                  ' from CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                                  ' MOVQDADEPRODUTO Qtd ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                                  ' and PRE.I_COD_TAB = '+IntToStr(Varia.TabelaPreco)+
                                  ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                  ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and Pro.c_ven_avu = ''S'''+
                                  ' and PRE.I_COD_CLI  = 0 '+
                                  ' and PRE.I_COD_TAM = 0',true);

    result := not Tabela.Eof;
    if result then
    begin
      with VpaDProdutoAdicional  do
      begin
        UMOriginal := Tabela.FieldByName('C_Cod_Uni').Asstring;
        DesUM := Tabela.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := DesUM;
        ValUnitarioOriginal := Tabela.FieldByName('VlrReal').AsFloat;
        CodProduto := Tabela.FieldByName(Varia.CodigoProduto).Asstring;
        ValUnitario := Tabela.FieldByName('VlrReal').AsFloat;
        QtdProduto := 1;
        SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
    Tabela.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesProposta.ExisteProdutoMaterialAcabamento(VpaCodProduto: String;
  VpaDMaterialAcabamento: TRBDPropostaMaterialAcabamento): Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, PRO.N_RED_ICM,'+
                                  ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_KIT, PRO.C_IND_RET, PRO.C_IND_CRA, '+
                                  ' PRO.C_PAT_FOT, PRO.L_DES_TEC,'+
                                  ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                                  ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                                  ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, QTD.N_QTD_FIS ' +
                                  ' from CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                                  ' MOVQDADEPRODUTO Qtd ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                                  ' and PRE.I_COD_TAB = '+IntToStr(Varia.TabelaPreco)+
                                  ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                  ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and Pro.c_ven_avu = ''S'''+
                                  ' and PRE.I_COD_CLI  = 0 '+
                                  ' and PRE.I_COD_TAM = 0',true);

    result := not Tabela.Eof;
    if result then
    begin
      with VpaDMaterialAcabamento  do
      begin
        UM := Tabela.FieldByName('C_Cod_Uni').Asstring;
        CodProduto := Tabela.FieldByName(Varia.CodigoProduto).Asstring;
        ValUnitario := Tabela.FieldByName('VlrReal').AsFloat;
        Quantidade := 1;
        SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
    Tabela.close;
  end;
end;
end.
