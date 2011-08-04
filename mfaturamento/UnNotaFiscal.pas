unit UnNotaFiscal;
{Verificado
-.edit;
}
interface
Uses
   DBTables, SysUtils, Db, Localizacao,Classes, ConvUnidade, grids, stdctrls, Graphics, UnCotacao, UnDados, UnDadosProduto, comctrls,
   UnSistema, UnDadosCR, UnordemProducao, UnVendedor, Parcela, variants, sqlExpr, tabela, UnNfe,UnProdutos;

  // localizacao
Type
  TLocalizaNotaFiscal = class
  public
    procedure LocalizaCliente(Tabela : TDataSet; CodCliente : Integer );
    procedure LocalizaNatureza(Tabela : TDataSet; CodNatureza : Integer );
    procedure LocalizaFilial(Tabela : TDataSet; CodFilial : Integer );
    procedure LocalizaCadNotaFiscal(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaMovNotaFiscal(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaCadMovNotaFiscal(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaProdutoQdadeTabelaSeqPro(Tabela : TDataSet; VpaCodFilial,VpaSeqProduto, VpaCodCliente : Integer);
    procedure LocalizaProduto(Tabela : TDataSet; SeqPro : Integer);
    procedure LocalizaProdutoCodigos(Tabela : TDataSet; Codigos : string);
    procedure LocalizaCadServico(Tabela : TDataSet);
    procedure LocalizaMovServicoNota(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaCadMovServicoNota(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaProdutoMovNotaFiscalSeqMov(VpaTabela : TDataset; VpaCodFilial,SeqNot, SeqPro, SeqMov, VpaCodCor : Integer);
    Procedure LocalizaItensNota(Tabela : TDataSet; VpaCodFilial,SequencialNota : Integer );
    procedure LocalizaKit(Tabela : TDataSet;VpaCodFilial, SequencialProduto : Integer );
    procedure LocalizaParcelasBoleto(Tabela : TDataSet; VpaCodFilial,SeqNotaFiscal : Integer );
    procedure LocalizaFormaPAgamento(Tabela : TDataSet; CodFormaPagto : integer );
    procedure LocalizaMovNatureza(Tabela : TDataSet; Codnat : string; SomenteParaNota : Boolean );
  end;


type
  TFuncoesNotaFiscal = class(TLocalizaNotaFiscal)
  private
    Tabela, Aux, CadNotaFiscal : TSQLQuery;
    Cadastro : TSQL;
    DataBase : TSQLConnection;
    ConvUnidade : TConvUnidade;
    ValUnidade : TValidaUnidade;
    FunCotacao : TFuncoesCotacao;
    FunVendedor : TRBFuncoesVendedor;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    FunNFe : TRBFuncoesNFe;
    CriaParcelas : TCriaParcelasReceber;
    procedure GravaCotacoesEstornadas(VpaSeqNotaFiscal : Integer;VpaCotacoes : TList);
    function GravaDItensNota(VpaDNota : TRBDNotaFiscal):String;
    function GravaDServicosnota(VpaDNota : TRBDNotaFiscal):String;
    procedure CarDItensNota(VpaDNota : TRBDNotaFiscal);
    procedure CarDServicoNota(VpaDNota : TRBDNotaFiscal);
    procedure CarCotacoesAEstorar(VpaCotacoes : TList;VpaCodFilial,VpaSeqNotaFiscal : Integer);
    procedure CalculaValorFreteProdutos(VpaDNota : TRBDNotaFiscal);
    procedure CancelaNota(VpaDNotaFiscal : TRBDNotaFiscal);
    procedure DeletaServicoEstoqueNota(VpaCodFilial, Sequencial: Integer );
    procedure DeletaOrcamentoNota(VpaCodFilial,VpaSeqNota : Integer);
    procedure DiminuiQtdProdutosCotacao(VpaCotacoes : TList;VpaCodFilial, VpaSequencial : Integer);
    function EstornaEstoque( VpaCodFilial, VpaSeqNota : Integer ):String;
    function EstornaEstoqueRomaneio(VpaCodFilial,VpaSeqNota : Integer):String;
    function EstornaEstoqueFiscal(VpaDNota : TRBDNotaFiscal):String;
    function PossuiRomaneio(VpaCodFilial, VpaSeqNota : Integer) : Integer;
    procedure EstornaCotacao(VpaCodFilial,VpaSequencial : Integer);
    function EstornaNotaFiscal(VpaDNota : TRBDNotaFiscal;VpaEstornaCotacao : Boolean) : string;
    function EstonaSinalPagamento(VpaDNota : TRBDNotaFiscal) : string;
    procedure Devolucao(VpaCodFilial, VpaSeqNota : Integer);
    function RSeqNotaDisponivel(VpaCodFilial : Integer) : Integer;
    function RMVAAjustado(VpaDNota : TRBDNotaFiscal;VpaDProdutoNota : TRBDNotaFiscalProduto) : double;
    procedure GeraNSU(VpaDNota : TRBDNotaFiscal);
    function ExisteSequencialNota(VpaCodFilial, VpaSeqNota : Integer) :boolean;
    procedure CarValSinalPagoCotacao(VpaDNotaFiscal : TRBDNotaFiscal; VpaCotacoes : TList);
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
    destructor Destroy; override;
    procedure CarDNotaFiscal(VpaDNota : TRBDNotaFiscal;VpaCodFilial : Integer = 0;VpaSeqNota : Integer = 0);
    procedure CarDNaturezaOperacao(VpaDNota : TRBDNotaFiscal);overload;
    procedure CarDNaturezaOperacao(VpaDNatureza : TRBDNaturezaOperacao;VpaCodNatureza : String;VpaSeqItemNatureza : Integer);overload;
    function RSeqMovNotaFiscalDisponivel(VpaCodFilial,VpaSeqNota : Integer) : Integer;
    Function RetornaProximoCodigoNota(SerieNota : String):Integer;
    function RTextoClassificacaoFiscal(VpaDNota : TRBDNotaFiscal): String;
    function RTextDescontoAcrescimo(VpaDNota : TRBDNotaFiscal):String;
    procedure CarValICMSPadrao(Var VpaValICMSPadrao, VpaValICMSAliquotaInterna, VpaPerReducaoUFICMS: double; VpaSigEstado, VpaInscricaoEstadual : String;VpaIndPessoaJuridica : Boolean;VpaIndCupomFiscal : Boolean;Var VpaSubstituicaTributaria : Boolean);
    function RPlanoContasMovNatureza(VpaCodNatureza : String;VpaSeqMovimento :Integer;VpaRevendaEdson : Boolean):String;
    function RValorComissao(VpaDNotaFiscal : TRBDNotaFiscal;VpaTipComissao : Integer;VpaPerComissao, VpaPerComissaoPreposto : Double):Double;
    function RValNotasClientePeriodo(VpaDatInicio,VpaDatFim : TDateTime;VpaCodCliente : Integer):Double;
    function RCSTICMSProduto(VpaDCliente : TRBDCliente;VpaDProduto : TRBDProduto;VpaDNatureza : TRBDNaturezaOperacao) : string;
    function RCFOPProduto(VpaDCliente : TRBDCLiente;VpaDNatureza: TRBDNaturezaOperacao; VpaDProduto : TRBDProduto):Integer;
    function RSeqNota(VpaNumNota, VpaCodFilial: Integer; VpaNumSerie: String): integer;
    function VerificaExisteProdutoNota(VpaCodFilial,SeqPro, SeqNot : integer) : Boolean;
    function VerificaExisteProduto(CodProduto : string; var seqpro : integer) : Boolean;
    function VerificaExisteCondicaoPgto( CodCondicao : integer) : Boolean;
    function VerificaExisteItemNotaAdiciona( VpaCodFilial,SeqNot, SeqPro, SeqMov, VpaCodCor :Integer; QdadePro : Double; NovaUnidade : String  ) : Boolean;
    function VerificaExisteCor(VpaCodCor : String; var VpaNomCor :String):boolean;
    procedure deletaItemNota( VpaCodFilial,SeqMov : Integer );
    function ProdutoTributado(VpaDProdutoNota : TRBDNotaFiscalProduto) : boolean;
    Function NotaDuplicada(VpaCodFilial : Integer;NroNota,Serie : String; var NovoNumero : Integer) : Boolean;
    Function AcertaClaFiscal( MovNotas : TDataSet): String;
    function UnidadesParentes( Unidade : string ) : TStringList;
    function ValidaUnidade( unidadeAtual, UnidadePadrao : string ) : Boolean;
    function CalculaValorPadrao( unidadeAtual, UnidadePadrao : string; ValorTotal : double; SequencialProduto : integer) : Double;
    procedure ConfiguraFatura( VpaGrade : TStringGrid; VpaQtd : integer;  VpaTexto : TLabel);
    procedure CalculaValorTotal(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente);
   function AdicionaProdutoKit(VpaMovNF, Produtos : TDataSet;VpaCodFilial, VpaSeqNota,VpaSeqProduto : Integer; CalculaIcms : String; var TextoCodProduto : string) : Boolean;
   function AdicionaFinanceiroArquivoRemessa(VpaCodFilial, VpaSeqNota : Integer):String;
   procedure AssociaNotaOrcamento(VpaEmpfil,VpaSeqNota, VpaFilialOrcamento, VpaLanOrcamento : Integer);
   function ExisteProdutoNota(VpaMovNota : TDataSet; VpaCodFilial, VpaSeqNota, VpaSeqProduto : Integer) : Boolean;
   function ExisteNota(VpaNumNota: Integer): Boolean;
   function ExisteSerieNota(VpaNumNota: Integer;  VpaNumSerie: String): Boolean;
   function ExisteModelo(VpaCodModelo: String): Boolean;
   function ExisteProduto(VpaCodProduto : String; VpaDNota :TRBDNotaFiscal; VpaDProdutoNota : TRBDNotaFiscalProduto):Boolean;
   function ExisteServico(VpaCodServico : String;VpaDNota : TRBDNotaFiscal; VpaDServicoNota : TRBDNotaFiscalServico):Boolean;
   function ExisteCor(VpaCodCor :String;VpaDProdutoNota : TRBDNotaFiscalProduto):Boolean;
   procedure AlteraValorICMS(VpaDNota : TRBDNotaFiscal);
   function ContaLinhasTabela( Tab : TDataSet ) : Integer;
   function ValorComissaoCFGProduto( TotalNota, TotalProdutos, ValorICMS,
                                     ValorIPI, ValorISSQN : Double ) : Double;
   function ValorComissaoCFGServico( TotalServicos,ValorISSQN : Double ) : Double;
   function RetornaValorServico( CodServico : Integer ) : Double;
   function LocalizaICMSEcf( ICMS : Double ) : Double;
   function RetornaVendedorNota(CodVendedor: Integer): string;
   function RNumeroCotacaoTransportadoraTexto(VpaNumCotacao : String) :string;
   function RetornaCondPagamento(CodCondPagamento: Integer): string;
   function RTextoNotaRemessaFaccionista(VpaCodCliente, VpaNroNota : Integer;VpaSerieNota : string;VpaDatNota : TDateTime):string;
   function RTextoNotaContaeOrdem(VpaCodCliente : Integer;VpaSerieNota : string;VpaDatNota : TDateTime):string;
   function ImprimirCuponNaoFiscal(CodCondPagamento: Integer): string;
   procedure PosicionaFaturas(Tabela: TDataSet;VpaCodFilial, SeqNota: Integer);
   procedure MudaNotaParaImpressa(VpaCodFilial,SeqNot: Integer);
   function ExcluiContasaReceber( VpaCodFilial, VpaSeqNota : Integer; FazerVeriricacoes : Boolean  ) : Boolean;
   function ExcluiParcelasSinalPagamentoEmAberto(VpaCotacoes : TList):string;
   function VerificaSeUltimaNota( VpaCodFilial, NroNota : Integer; Serie : String) : Boolean;
   function VerificaItemNotaDuplicado(VpaDNota : TRBDNotaFiscal):Boolean;
   function VerificaServicoNotaDuplicado(VpaDNota : TRBDNotaFiscal):Boolean;
   procedure DeletaNota(VpaCodFilial, Sequencial: Integer);
   function ExcluiNotaFiscal(VpaDNotaFiscal : TRBDNotaFiscal):string;
   procedure CancelaCupomFiscal( VpaCodFilial, VpaSeqNota : Integer );
   function CancelaNotaFiscal(VpaDNota : TRBDNotaFiscal ; VpaEstornarCotacao, VpaCancelarSefaz : Boolean ) : string;
   function DevolucaoTotalNotaFiscal( VpaCodFilial, VpaSeqNota : Integer ) : boolean;
   function GeraNotaFiscalDevolucao(VpaCodFilial, VpaSeqNota : Integer; BaixaEstoque : String; VpaNatureza : String;VpaCupom : Boolean; VpaCodOpe, VpaItemNatureza : Integer):Integer;
   function RetornaSeqNotaDisponivel : Integer;
   function RetornaMovSeqDisponivel : Integer;
   function BaixaEstoqueNota(VpaDNota : TRBDNotaFiscal;VpaDNatureza : TRBDNaturezaOperacao; VpaFunProdutos : TFuncoesProduto):string;
   procedure BaixaEstoqueDevolucao(VpaCodFilial, VpaSeqNota : Integer; VpaNatureza, BaixaEstoque : String; VpaCodOpe : Integer);
//   function GeraNotaAPartirDe(VpaCodFilial, VpaSeqNota : Integer; CodNatureza : String; CodCliente, ItemNatureza : Integer) : Integer;
   function GeraFinanceiroNota(VpaDNota : TRBDNotaFiscal;VpaCotacoes : tlist;VpaDCliente : TRBDCliente;VpaDContasAReceber : TRBDContasCR;VpaOcultar, VpaGravar : Boolean):String;
   function GravaDNotaFiscal(VpaDNota : TRBDNotaFiscal) : String;
   function GravaParcelasSinalPagamento(VpaDNota : TRBDNotaFiscal) : String;
   procedure SetaNotaImpressa(VpaCodFilial, VpaSeqNota :Integer);
   procedure SetaNfeComoEnviada(VpaCodFilial, VpaSeqNota : Integer);
   function SetaNotaInutilizada(VpaCodFilial,VpaSeqNota : integer) :string;
   function RNomNaturezaOperacao(VpaCodNatureza : String;VpaItemNatureza : Integer) :String;
   function RValAproveitamentoCreditoICMS(VpaDCliente : TRBDCliente;VpaDNota : TRBDNotaFiscal):double;
   procedure CarFaturasImpressaoNotaFiscal(VpaDNotaFiscal : TRBDNotaFiscal;VpaQtdColunasFatura : Integer);
   procedure CarObservacaoNotaFiscal(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente);
   function PossuiProdutosIndustrializadosTributacaoICMSNormal(VpaDCliente : TRBDCliente;VpaDNota : TRBDNotaFiscal):Boolean;
   function PossuiProdutosRevendaTributacaoICMSNormal(VpaDCliente : TRBDCliente;VpaDNota : TRBDNotaFiscal):Boolean;
   function PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VpaDCliente : TRBDCliente;VpaDNota : TRBDNotaFiscal):Boolean;
   function PossuiProdutosRevendaTributacaoICMSSubstituto(VpaDCliente : TRBDCliente;VpaDNota : TRBDNotaFiscal):Boolean;
   function AssinaRegistroNota(VpaCodFilial,VpaSeqNota : Integer):string;
   function AssinaRegistroNotaProduto(VpaCodFilial,VpaSeqNota, VpaSeqItem : Integer):string;
   function AssociaNotaRomaneio(VpaCodFilialRomaneio, VpaSeqRomaneio,VpaCodFilialNota, VpaSeqNota, VpaNumNota : Integer):string;
   procedure AdicionaTextoProEmprego(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente);
   procedure CarTextoDescricaoAdicionalProduto(VpaDNotaFiscal : TRBDNotaFiscal);
   function DadosCTSItemNotaValido(VpaDProdutoNota : TRBDNotaFiscalProduto) : string;
   function BaixaSaldoSinalPagamento(VpaDNotaFiscal : TRBDNotaFiscal;VpaValSinal : Double):string;
  end;

Var
  FunNotaFiscal : TFuncoesNotaFiscal;

implementation
Uses FunSql,Constantes, ConstMsg, FunString, FunObjeto, FunData,
      FunNumeros, UnComissoes, UnContasaReceber, UnClientes, FunArquivos;


{#############################################################################
                        TFuncoes Notas Fiscais
#############################################################################  }

{********** localiza o cliente para a nota fiscal *************************** }
procedure TLocalizaNotaFiscal.LocalizaCliente(Tabela : TDataSet; CodCliente : Integer );
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CadClientes ' +
                               ' Where I_Cod_Cli = ' + IntToStr(CodCliente) )
end;

{********** localiza natureza para a nota fiscal **************************** }
procedure TLocalizaNotaFiscal.LocalizaNatureza(Tabela : TDataSet; CodNatureza : Integer );
begin
  AdicionaSQLAbreTabela(Tabela,' Select * from CadNatureza ' +
                               ' Where C_Cod_Nat = ''' + IntTostr(CodNatureza) + '''');
end;

{********** localiza filial para a nota fiscal **************************** }
procedure TLocalizaNotaFiscal.LocalizaFilial(Tabela : TDataSet; CodFilial : Integer );
begin
   AdicionaSQLAbreTabela( Tabela, 'select * from cadFiliais where I_EMP_FIL = ' + IntTostr(CodFilial));
end;

{*********Posiciona a nota fiscal de acordo com o sequencial passado***********}
procedure TLocalizaNotaFiscal.LocalizaCadNotaFiscal(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
begin
  AdicionaSQLAbreTabela(Tabela, ' Select * from CadNotaFiscais' +
                                ' Where I_Emp_Fil = ' + IntToStr(VpaCodFilial) +         //Codigo da filial Ativa
                                ' and I_seq_Not = ' + IntTostr(VpaSeqNota));
end;


{*******************Posiciona o movimento de notas fiscais*********************}
procedure TLocalizaNotaFiscal.LocalizaMovNotaFiscal(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
begin
  AdicionaSQLAbreTabela( Tabela, 'Select * from MovNotasFiscais ' +
                                 ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                                 ' and I_Seq_Not = ' + IntTostr(VpaSeqNota)+
                                 ' order by I_SEQ_MOV');
end;

{*******************Posiciona o movimento de notas fiscais*********************}
procedure TLocalizaNotaFiscal.LocalizaCadMovNotaFiscal(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,
    ' select * from MovNotasFiscais MOV, CadProdutos PRO ' +
    ' where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
    ' AND MOV.I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
    ' and MOV.I_SEQ_NOT = ' + IntTostr(VpaSeqNota));
end;

procedure TLocalizaNotaFiscal.LocalizaProdutoMovNotaFiscalSeqMov(VpaTabela : TDataset;VpaCodFilial, SeqNot, SeqPro, SeqMov,VpaCodCor : Integer);
begin
  LimpaSQlTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'Select * from MovNotasFiscais ' +
                   ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                   ' and I_Seq_Not = ' + IntTostr(SeqNot) +
                   ' and i_seq_pro = ' + IntTostr(SeqPro)  +
                   ' and I_seq_mov <> ' + IntTostr(SeqMov) );
  if (config.EstoquePorCor) then
  begin
    if (VpaCodCor <> 0) then
      AdicionaSQLTabela(VpaTabela,'and I_COD_COR = '+IntToStr(VpaCodCor))
    else
      AdicionaSQLTabela(VpaTabela,'and I_COD_COR is null');
  end;
  AbreTabela(VpaTabela);
end;

{*******************Posiciona o Produtos *************************************}
procedure TLocalizaNotaFiscal.LocalizaProdutoQdadeTabelaSeqPro(Tabela : TDataSet;VpaCodFilial, VpaSeqProduto, VpaCodCliente : Integer);
begin
  AdicionaSQLAbreTabela( Tabela, ' Select pro.c_pat_fot, pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cla_Fis, (mov.N_QTD_PRO - mov.N_QTD_RES) as N_QTD_PRO, ' +
                                 ' (Tab.N_Vlr_Ven * moe.n_vlr_dia) n_vlr_ven, pro.c_kit_pro, pro.C_FLA_PRO,PRO.N_PER_KIT, ' +
                                 ' pro.N_Red_Icm, pro.i_seq_pro, pro.c_cod_uni,pro.n_per_ipi, PRO.N_PER_ICM, PRO.C_SUB_TRI, '+
                                 ' mov.n_qtd_ped, mov.n_qtd_min, mov.c_cod_bar ' +
                                 ' from CadProdutos pro, MovQdadeProduto mov, ' +
                                 ' MovTabelaPreco Tab, cadmoedas moe ' +
                                 ' where pro.i_seq_pro = ' + intToStr(VpaSeqProduto) +
                                 ' and pro.i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                 ' and mov.I_EMP_FIL = ' + intToStr(VpaCodFilial) +
                                 ' and pro.i_seq_pro = mov.i_seq_pro ' +
                                 ' and tab.i_cod_tab =   ' + intToStr(varia.TabelaPreco) +
                                 ' and tab.i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                 ' and pro.i_seq_pro =  tab.i_seq_pro ' +
                                 ' and tab.i_cod_moe = moe.i_cod_moe ' +
                                 ' and TAB.I_COD_CLI IN (0,'+IntToStr(VpaCodCliente)+')'+
                                 ' order by TAB.I_COD_CLI DESC ');
end;


procedure TLocalizaNotaFiscal.LocalizaProduto(Tabela : TDataSet; SeqPro : Integer);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where i_seq_pro = '+ IntToStr(SeqPro) +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;


procedure TLocalizaNotaFiscal.LocalizaProdutoCodigos(Tabela : TDataSet; Codigos : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where i_seq_pro in ( ' + codigos + ')' +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;


procedure TLocalizaNotaFiscal.LocalizaCadServico(Tabela : TDataSet);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from CadServico ' +
                               ' Where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;

procedure TLocalizaNotaFiscal.LocalizaMovServicoNota(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from MovServicoNota ' +
                               ' Where i_seq_not = '  + InttoStr(VpaseqNota) +
                               ' and I_Emp_Fil = ' + IntToStr(VpaCodFilial) );
end;

procedure TLocalizaNotaFiscal.LocalizaCadMovServicoNota(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : Integer);
begin
  AdicionaSQLAbreTabela(tabela,
    ' Select * from CadServico CAD, MovServicoNota MOV ' +
    ' WHERE CAD.I_COD_SER = MOV.I_COD_SER ' +
    ' AND I_SEQ_NOT = '  + IntToStr(VpaSeqNota) +
    ' AND CAD.I_COD_EMP = MOV.I_COD_EMP ' +
    ' AND I_EMP_FIL = ' + IntToStr(VpaCodfilial));
end;

Procedure TLocalizaNotaFiscal.LocalizaItensNota(Tabela : TDataSet;VpaCodFilial, SequencialNota : Integer );
begin
   AdicionaSQLAbreTabela( Tabela, ' select * from MovNotasFiscais as MNF, CadProdutos as Pro ' +
                                  ' where MNF.I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                                  ' and MNF.i_seq_not = ' + IntToStr(SequencialNota) +
                                  ' and MNF.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                                  ' and Pro.I_COD_EMP = ' + intToStr(Varia.CodigoEmpresa) );
end;

procedure TLocalizaNotaFiscal.LocalizaKit(Tabela : TDataSet; VpaCodFilial,SequencialProduto : Integer );
begin
  AdicionaSQLAbreTabela(tabela,' Select '+ Varia.CodigoProduto + ', KIT.I_SEQ_PRO, KIT.N_QTD_PRO, Pro.I_Seq_Pro, '+
                               ' Pro.C_Cod_Uni, PRo.N_Per_Kit, (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                               ' pro.n_red_icm, pro.n_per_ipi, pro.C_CLA_FIS, pro.c_nom_pro '+
                               ' from CadProdutos Pro, MovKit Kit, MovTabelaPreco Pre, ' +
                               ' CadMoedas Moe, MovQdadeProduto Qtd '+
                               ' Where Kit.I_Pro_Kit = '+ IntToStr(SequencialProduto) +
                               ' and Pre.I_Cod_Emp = '+ IntToStr(Varia.CodigoEmpresa) +
                               ' and Pre.I_Cod_Tab = '+ IntToStr(varia.TabelaPreco)+
                               ' and Qtd.I_Emp_Fil = '+ IntToStr(VpaCodFilial) +
                               ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe ' +
                               ' and Pre.I_Seq_Pro = Pro.I_Seq_Pro '+
                               ' and Pro.I_Seq_Pro = Kit.I_Seq_Pro'+
                               ' and Pro.I_Seq_Pro = Qtd.I_Seq_Pro'+
                               ' and PRE.I_COD_CLI = 0');
end;


procedure TLocalizaNotaFiscal.LocalizaParcelasBoleto(Tabela : TDataSet; VpaCodFilial,SeqNotaFiscal : Integer );
begin
  AdicionaSQLAbreTabela( Tabela, ' select * ' +
                                 ' from cadContasaReceber Cad, MovContasaReceber mov, cadClientes cli, CADCONTAS CON ' +
                                 ' where ' +
                                 ' cad.I_seq_not = ' + IntToStr(SeqNotaFiscal) +
                                 ' and cad.I_emp_fil = ' + IntToStr(VpaCodFilial) +
                                 ' and cad.i_lan_rec = mov.i_lan_rec ' +
                                 ' and cad.I_emp_fil = mov.I_emp_fil ' +
                                 ' and cad.I_cod_cli = cli.i_cod_cli ' +
                                 ' AND MOV.C_NRO_CON = CON.C_NRO_CON '+
                                 ' and MOV.D_DAT_PAG IS NULL');

end;

{******************************************************************************}
procedure TLocalizaNotaFiscal.LocalizaFormaPagamento(Tabela : TDataSet; CodFormaPagto : integer );
begin
  AdicionaSQLAbreTabela( Tabela, ' select *  from CadFormasPagamento ' +
                                 ' where i_cod_frm =  ' + InttoStr(CodFormaPagto) );
end;

{******************************************************************************}
procedure  TLocalizaNotaFiscal.LocalizaMovNatureza(Tabela : TDataSet; Codnat : string; SomenteParaNota : Boolean );
var
  SomenteNota : string;
begin
  SomenteNota := '';
  if SomenteParaNota then
    SomenteNota := ' and c_mos_not = ''S''';
  AdicionaSQLAbreTabela(TABELA,' Select * from MovNatureza ' +
                                     ' Where C_Cod_Nat = ''' + Codnat + '''' +
                                     ' and C_TIP_EMI = ''P'' ' +
                                     SomenteNota );
end;


{#############################################################################
                        TFuncoes Notas Fiscais
#############################################################################  }

{************************** Cria novas funcoes ****************************** }
constructor TFuncoesNotaFiscal.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  FunVendedor := TRBFuncoesVendedor.cria(VpaBaseDados);
  FunNFe := TRBFuncoesNFe.cria(VpaBaseDados);
  DataBase := VpaBaseDados;
  Tabela := TSQLQuery.Create(aowner);
  Tabela.SQLConnection := VpaBaseDados;
  Aux := TSQLQuery.Create(aowner);
  Aux.SQLConnection := VpaBaseDados;
  CadNotaFiscal := TSQLQuery.Create(aowner);
  CadNotaFiscal.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(aowner);
  Cadastro.ASQLConnection := VpaBaseDados;

  FunCotacao := TFuncoesCotacao.Cria(VpaBaseDados);
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(VpaBaseDados);
  ConvUnidade := TConvUnidade.create(nil);
  ConvUnidade.ADataBase := VpaBaseDados;
  ConvUnidade.AInfo.UniNomeTabela := 'MOVINDICECONVERSAO';
  ConvUnidade.AInfo.UniCampoDE := 'C_UNI_ATU';
  ConvUnidade.AInfo.UniCampoPARA := 'C_UNI_COV';
  ConvUnidade.AInfo.UniCampoIndice := 'N_IND_COV';
  ConvUnidade.AInfo.ProCampoIndice := 'I_IND_COV';
  ConvUnidade.AInfo.ProCampoCodigo := 'I_SEQ_PRO';
  ConvUnidade.AInfo.ProCampoFilial := 'I_COD_EMP';
  ConvUnidade.AInfo.ProNomeTabela := 'CADPRODUTOS';
  ConvUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ConvUnidade.AInfo.UnidadeUN := varia.UnidadeUN;
  ConvUnidade.AInfo.UnidadeKit := varia.UnidadeKit;
  ConvUnidade.AInfo.UnidadeBarra := varia.UnidadeBarra;

  ValUnidade := TValidaUnidade.create(nil);
  ValUnidade.ADataBase := VpaBaseDados;
  ValUnidade.AInfo.NomeTabelaIndice := 'MOVINDICECONVERSAO';
  ValUnidade.AInfo.CampoUnidadeDE := 'C_UNI_ATU';
  ValUnidade.AInfo.CampoUnidadePARA := 'C_UNI_COV';
  ValUnidade.AInfo.CampoIndice := 'N_IND_COV';
  ValUnidade.AInfo.UnidadeCX :=  Varia.UnidadeCX;
  ValUnidade.AInfo.UnidadeUN := Varia.UnidadeUN;
  ValUnidade.AInfo.UnidadeKit := Varia.UnidadeKit;
  ValUnidade.AInfo.UnidadeBarra := Varia.UnidadeBarra;

  //criar parcelas
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


end;

{******************************************************************************}
function TFuncoesNotaFiscal.DadosCTSItemNotaValido(VpaDProdutoNota: TRBDNotaFiscalProduto): string;
var
  VpfCodCST : Integer;
begin
  result := '';
  if Length(VpaDProdutoNota.CodCST) =3 then
  begin
    try
      VpfCodCST := StrToInt(Copy(VpaDProdutoNota.CodCST,2,2));
    except
      result := 'CST INVÁLIDO!!!'#13'O código do CST tem que ser apenas números.';
    end;
    if result = '' then
    begin
      if (VpfCodCST = 00) and (VpaDProdutoNota.PerICMS = 0) then
      begin
        result := 'CST INVÁLIDO!!!'#13'Quando o código do CST termina com 00 é obrigatório digitar o percentual de ICMS.';
      end;
      if ((VpfCodCST = 70)or (VpfCodCST = 20)) and (VpaDProdutoNota.PerReducaoUFBaseICMS = 0) then
      begin
        result := 'CST INVÁLIDO!!!'#13'Quando o código do CST termina com 20 ou 70 é obrigatório digitar o percentual de redução da base de ICMS.';
      end;
    end;
  end
  else
    result :='CST INVÁLIDO!!!'#13'O CST digitado tem que possuir 3 caracteres';

end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesNotaFiscal.Destroy;
begin
  ConvUnidade.free;
  ValUnidade.free;
  FechaTabela(tabela);
  Aux.Close;;
  Cadastro.free;
  Aux.Free;
  CadNotaFiscal.free;
  Tabela.Destroy;
  FunCotacao.free;
  FunOrdemProducao.free;
  FunVendedor.free;
  FunNFe.free;
  CriaParcelas.free;
  inherited;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarDNaturezaOperacao(VpaDNatureza: TRBDNaturezaOperacao; VpaCodNatureza: String; VpaSeqItemNatureza: Integer);
var
  VpfCodNatureza : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select NAT.I_COD_OPE, NAT.C_CLA_PLA, NAT.C_GER_FIN, NAT.C_CAL_ICM, NAT.C_BAI_EST, '+
                               ' NAT.C_CAL_PIS, NAT.C_CAL_COF, NAT.I_CFO_PRO, NAT.I_CFO_SER, I_CFO_SUB, I_CFO_PRR, '+
                               ' NAT.C_MOV_FIS, NAT.I_CFO_STR, NAT.C_NOT_DEV, NAT.C_COD_CST, NAT.L_TEX_FIS, '+
                               ' OPE.C_NOM_OPE , OPE.C_TIP_OPE, OPE.C_FUN_OPE  '+
                               ' from MOVNATUREZA NAT, CADOPERACAOESTOQUE OPE '+
                               ' Where NAT.C_COD_NAT = '''+ VpaCodNatureza+''''+
                               ' and NAT.I_SEQ_MOV = ' + IntToStr(VpaSeqItemNatureza)+
                               ' AND '+SQLTextoRightJoin('NAT.I_COD_OPE','OPE.I_COD_OPE'));
  VpaDNatureza.CodNatureza := VpaCodNatureza;
  VpaDNatureza.SeqNatureza := VpaSeqItemNatureza;
  VpaDNatureza.CodOperacaoEstoque := Tabela.FieldByName('I_COD_OPE').AsInteger;
  VpaDNatureza.CFOPProdutoIndustrializacao := Tabela.FieldByName('I_CFO_PRO').AsInteger;
  VpaDNatureza.CFOPProdutoRevenda := Tabela.FieldByName('I_CFO_PRR').AsInteger;
  VpaDNatureza.CFOPSubstituicaoTributariaIndustrializacao := Tabela.FieldByName('I_CFO_SUB').AsInteger;
  VpaDNatureza.CFOPSubstituicaoTributariaRevenda := Tabela.FieldByName('I_CFO_STR').AsInteger;
  VpaDNatureza.CFOPServico := Tabela.FieldByName('I_CFO_SER').AsInteger;
  VpaDNatureza.NomOperacaoEstoque := Tabela.FieldByName('C_NOM_OPE').AsString;
  VpaDNatureza.TipOperacaoEstoque := Tabela.FieldByName('C_TIP_OPE').AsString;
  VpaDNatureza.FuncaoOperacaoEstoque := Tabela.FieldByName('C_FUN_OPE').AsString;
  VpaDNatureza.CodPlanoContas := Tabela.FieldByName('C_CLA_PLA').AsString;
  VpaDNatureza.IndFinanceiro := (Tabela.FieldByName('C_GER_FIN').AsString = 'S');
  VpaDNatureza.IndCalcularICMS := (Tabela.FieldByName('C_CAL_ICM').AsString = 'S');
  VpaDNatureza.IndBaixarEstoque := (Tabela.FieldByName('C_BAI_EST').AsString = 'S');
  VpaDNatureza.IndCalcularPIS := (Tabela.FieldByName('C_CAL_PIS').AsString = 'S');
  VpaDNatureza.IndCalcularCOFINS := (Tabela.FieldByName('C_CAL_COF').AsString = 'S');
  VpaDNatureza.IndMovimentacaoFisica := (Tabela.FieldByName('C_MOV_FIS').AsString = 'S');
  VpaDNatureza.IndNotaDevolucao := (Tabela.FieldByName('C_NOT_DEV').AsString = 'S');
  VpaDNatureza.CodCst := Tabela.FieldByName('C_COD_CST').AsString;
  VpaDNatureza.DesTextoFiscal := Tabela.FieldByName('L_TEX_FIS').AsString;
  Tabela.Close;
  if (VpaDNatureza.CFOPProdutoIndustrializacao =0) and (VpaDNatureza.CFOPServico = 0) then
  begin
    VpfCodNatureza := DeletaChars(DeletaChars(VpaCodNatureza,'.'),' ');
    if Length(VpfCodNatureza) > 4  then
    begin
      if (DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/') = '5933')or
         (DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/') = '6933') then
      begin
        VpaDNatureza.CFOPServico := StrToInt(DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/'));
        if (DeleteAteChar(VpfCodNatureza,'/') <> '') then
          VpaDNatureza.CFOPProdutoIndustrializacao := StrToInt(DeleteAteChar(VpfCodNatureza,'/'));
      end
      else
        if (DeleteAteChar(VpfCodNatureza,'/') = '5933') or
           (DeleteAteChar(VpfCodNatureza,'/') = '6933') then
        begin
          VpaDNatureza.CFOPProdutoIndustrializacao := StrToInt(DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/'));
          VpaDNatureza.CFOPServico := StrToInt(DeleteAteChar(VpfCodNatureza,'/'));
        end;
    end
    else
    begin
      if (VpfCodNatureza = '5933')or
         (VpfCodNatureza = '6933')  then
        VpaDNatureza.CFOPServico := StrToInt(VpfCodNatureza)
      else
        if VpfCodNatureza <> '' then
          VpaDNatureza.CFOPProdutoIndustrializacao := StrToInt(VpfCodNatureza);
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarDNotaFiscal(VpaDNota : TRBDNotaFiscal;VpaCodFilial : Integer = 0;VpaSeqNota : Integer = 0);
begin
  if VpaCodFilial <> 0 then
    VpaDNota.CodFilial := VpaCodFilial;
  if VpaSeqNota <> 0 then
    VpaDNota.SeqNota := VpaSeqNota;
  if VpaDNota.CodFilial = 0 then
    VpaDNota.CodFilial := varia.CodigoEmpFil;
  AdicionaSQLAbreTabela(CadNotaFiscal,'Select CAD.*, FIL.C_EST_FIL '+
                                      ' from CADNOTAFISCAIS CAD, CADFILIAIS FIL '+
                                      ' Where CAD.I_EMP_FIL = '+ IntToStr(VpaDNota.CodFilial)+
                                      ' and CAD.I_SEQ_NOT = '+ InttoStr(VpaDNota.SeqNota)+
                                      ' AND CAD.I_EMP_FIL = FIL.I_EMP_FIL ');
  VpaDNota.DesSerie := CadNotaFiscal.FieldByName('C_SER_NOT').AsString;
  VpaDNota.CodCondicaoPagamento := CadNotaFiscal.FieldByName('I_COD_PAG').AsInteger;
  VpaDNota.CodFormaPagamento := CadNotaFiscal.FieldByName('I_COD_FRM').AsInteger;
  VpaDNota.CodVendedor := CadNotaFiscal.FieldByName('I_COD_VEN').AsInteger;
  VpaDNota.CodVendedorPreposto := CadNotaFiscal.FieldByName('I_VEN_PRE').AsInteger;
  VpaDNota.NumNota := CadNotaFiscal.FieldByName('I_NRO_NOT').AsInteger;
  VpaDNota.CodCliente := CadNotaFiscal.FieldByName('I_COD_CLI').AsInteger;
  VpaDNota.CodTransportadora := CadNotaFiscal.FieldByName('I_COD_TRA').AsInteger;
  VpaDNota.CodRedespacho := CadNotaFiscal.FieldByName('I_COD_RED').AsInteger;
  VpaDNota.CodModeloDocumento := CadNotaFiscal.FieldByName('I_MOD_DOC').AsInteger;
  VpaDNota.CodNatureza := CadNotaFiscal.FieldByName('C_COD_NAT').AsString;
  VpaDNota.DesTipoNota := CadNotaFiscal.FieldByName('C_TIP_NOT').AsString;
  VpaDNota.DatEmissao := CadNotaFiscal.FieldByName('D_DAT_EMI').AsDateTime;
  VpaDNota.DatSaida := CadNotaFiscal.FieldByName('D_DAT_SAI').AsDateTime;
  VpaDNota.HorSaida := CadNotaFiscal.FieldByName('T_HOR_SAI').AsDateTime;
  VpaDNota.QtdEmbalagem := CadNotaFiscal.FieldByName('I_QTD_VOL').AsInteger;
  VpaDNota.DesMarcaEmbalagem := CadNotaFiscal.FieldByName('C_MAR_PRO').AsString;
  VpaDNota.NumCotacaoTransportadora := CadNotaFiscal.FieldByName('C_COT_TRA').AsString;
  VpaDNota.DesPlacaVeiculo := CadNotaFiscal.FieldByName('C_NRO_PLA').AsString;
  VpaDNota.DesEspecie := CadNotaFiscal.FieldByName('C_TIP_EMB').AsString;
  VpaDNota.DesObservacao.Text := CadNotaFiscal.FieldByName('L_OBS_NOT').AsString;
  VpaDNota.DesDadosAdicinais.Text := CadNotaFiscal.FieldByName('L_OB1_NOT').AsString;
  VpaDNota.DesUFFilial := CadNotaFiscal.FieldByName('C_EST_FIL').AsString;
  VpaDNota.CodTipoFrete := CadNotaFiscal.FieldByName('I_TIP_FRE').AsInteger;
  VpaDNota.ValBaseICMS := CadNotaFiscal.FieldByName('N_BAS_CAL').AsFloat;
  VpaDNota.ValICMS := CadNotaFiscal.FieldByName('N_VLR_ICM').AsFloat ;
  VpaDNota.ValBaseICMSSubstituicao := CadNotaFiscal.FieldByName('N_BAS_SUB').AsFloat;
  VpaDNota.ValICMSSubtituicao := CadNotaFiscal.FieldByName('N_VLR_SUB').AsFloat;
  VpaDNota.NumPedidos := CadNotaFiscal.FieldByName('C_NUM_PED').AsString;
  VpaDNota.ValTotalProdutos := CadNotaFiscal.FieldByName('N_TOT_PRO').AsFloat;
  VpaDNota.ValTotalProdutosSemDesconto := CadNotaFiscal.FieldByName('N_TOT_PSD').AsFloat;
  VpaDNota.ValFrete := CadNotaFiscal.FieldByName('N_VLR_FRE').AsFloat;
  VpaDNota.ValSeguro := CadNotaFiscal.FieldByName('N_VLR_SEG').AsFloat;
  VpaDNota.ValOutrasDepesesas := CadNotaFiscal.FieldByName('N_OUT_DES').AsFloat;
  VpaDNota.ValTotalIPI := CadNotaFiscal.FieldByName('N_TOT_IPI').AsFloat;
  VpaDNota.ValTotal :=CadNotaFiscal.FieldByName('N_TOT_NOT').AsFloat;
  VpaDNota.PesBruto := CadNotaFiscal.FieldByName('N_PES_BRU').AsFloat;
  VpaDNota.PesLiquido := CadNotaFiscal.FieldByName('N_PES_LIQ').AsFloat;
  VpaDNota.ValFrete := CadNotaFiscal.FieldByName('N_VLR_FRE').AsFloat;
  VpaDNota.ValTotalServicos := CadNotaFiscal.FieldByName('N_TOT_SER').AsFloat;
  VpaDNota.ValIssqn := CadNotaFiscal.FieldByName('N_VLR_ISQ').AsFloat;
  VpaDNota.ValICMSSuperSimples := CadNotaFiscal.FieldByName('N_ICM_SSI').AsFloat;
  VpaDNota.ValSinalPagamento := CadNotaFiscal.FieldByName('N_SIN_PAG').AsFloat;
  VpaDNota.PerICMSSuperSimples := CadNotaFiscal.FieldByName('N_PER_SSI').AsFloat;
  VpaDNota.PerIssqn := CadNotaFiscal.FieldByName('N_PER_ISQ').AsFloat;
  VpaDNota.DesUFPlacaVeiculo := CadNotaFiscal.FieldByName('C_EST_PLA').AsString;
  VpaDNota.IndECF := CadNotaFiscal.FieldByName('C_FLA_ECF').AsString = 'S';
  VpaDNota.IndNotaVendaConsumidor := CadNotaFiscal.FieldByName('C_VEN_CON').AsString = 'S';
  VpaDNota.IndNotaImpressa := CadNotaFiscal.FieldByName('C_NOT_IMP').AsString = 'S';
  VpaDNota.IndNotaCancelada := CadNotaFiscal.FieldByName('C_NOT_CAN').AsString = 'S';
  VpaDNota.IndNotaInutilizada := CadNotaFiscal.FieldByName('C_NOT_INU').AsString = 'S';
  VpaDNota.NumEmbalagem := CadNotaFiscal.FieldByName('C_NRO_PAC').AsString;
  VpaDNota.DesClassificacaoFiscal := CadNotaFiscal.FieldByName('C_TEX_CLA').AsString;
  VpaDNota.IndNotaDevolvida := CadNotaFiscal.FieldByName('C_NOT_DEV').AsString = 'S';
  VpaDNota.SeqItemNatureza := CadNotaFiscal.FieldByName('I_ITE_NAT').AsInteger;
  VpaDNota.DesOrdemCompra := CadNotaFiscal.FieldByName('C_ORD_COM').AsString;
  VpaDNota.IndGeraFinanceiro := CadNotaFiscal.FieldByName('C_FIN_GER').AsString = 'S';
  VpaDNota.IndNFEEnviada := CadNotaFiscal.FieldByName('C_ENV_NFE').AsString = 'S';
  VpaDNota.PerDesconto := CadNotaFiscal.FieldByName('N_PER_DES').AsFloat;
  VpaDNota.ValDesconto := CadNotaFiscal.FieldByName('N_VLR_DES').AsFloat;
  VpaDNota.PerComissao := CadNotaFiscal.FieldByName('N_PER_COM').AsFloat;
  VpaDNota.PerComissaoPreposto := CadNotaFiscal.FieldByName('N_COM_PRE').AsFloat;
  VpaDNota.NumNSU := CadNotaFiscal.FieldByName('I_NRO_NSU').AsInteger;
  VpaDNota.DatNSU := CadNotaFiscal.FieldByName('D_DAT_NSU').AsDateTime;
  VpaDNota.CodUsuario := CadNotaFiscal.FieldByName('I_COD_USU').AsInteger;
  case CadNotaFiscal.FieldByName('I_TIP_NOT').AsInteger of
    0 : VpaDNota.TipNota := tnNormal;
    1 : VpaDNota.TipNota := tnVendaPorContaeOrdem;
    2 : VpaDNota.TipNota := tnDevolucao;
  end;
  //nfe
  VpaDNota.DesChaveNFE := CadNotaFiscal.FieldByName('C_CHA_NFE').AsString;
  VpaDNota.NumReciboNFE := CadNotaFiscal.FieldByName('C_REC_NFE').AsString;
  VpaDNota.NumProtocoloNFE := CadNotaFiscal.FieldByName('C_PRO_NFE').AsString;
  VpaDNota.CodMotivoNFE := CadNotaFiscal.FieldByName('C_STA_NFE').AsString;
  VpaDNota.DesMotivoNFE := CadNotaFiscal.FieldByName('C_MOT_NFE').AsString;
  VpaDNota.DesUFEmbarque := CadNotaFiscal.FieldByName('C_EST_EMB').AsString;
  VpaDNota.DesLocalEmbarque := CadNotaFiscal.FieldByName('C_LOC_EMB').AsString;

  CarDItensNota(VpaDNota);
  CarDServicoNota(VpaDNota);
  if not VpaDNota.IndECF then
    CarDNaturezaOperacao(VpaDNota);
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarDNaturezaOperacao(VpaDNota : TRBDNotaFiscal);
var
  VpfCodNatureza : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVNATUREZA '+
                               ' Where C_COD_NAT = '''+ VpaDNota.CodNatureza+''''+
                               ' and I_SEQ_MOV = ' + IntToStr(VpaDNota.SeqItemNatureza));
  VpaDNota.CFOPProdutoIndustrializacao := Tabela.FieldByName('I_CFO_PRO').AsInteger;
  VpaDNota.CFOPProdutoRevenda := Tabela.FieldByName('I_CFO_PRR').AsInteger;
  VpaDNota.CFOPServico := Tabela.FieldByName('I_CFO_SER').AsInteger;
  VpaDNota.CFOPSubstituicaoTributariaIndustrializacao := Tabela.FieldByName('I_CFO_SUB').AsInteger;
  VpaDNota.CFOPSubstituicaoTributariaRevenda := Tabela.FieldByName('I_CFO_STR').AsInteger;
  VpaDNota.IndCalculaICMS := (Tabela.FieldByName('C_CAL_ICM').AsString = 'S');
  VpaDNota.IndNaturezaNotaDevolucao := (Tabela.FieldByName('C_NOT_DEV').AsString = 'S');
  VpaDNota.IndBaixarEstoque := (Tabela.FieldByName('C_BAI_EST').AsString = 'S');
  VpaDNota.IndNaturezaEstadoLocal := (Tabela.FieldByName('C_NAT_LOC').AsString = 'S');
  VpaDNota.IndGeraComissao := (Tabela.FieldByName('C_GER_COM').AsString = 'S');
  VpaDNota.IndNaturezaProduto := (Tabela.FieldByName('C_INS_PRO').AsString = 'S');
  VpaDNota.IndNaturezaServico := (Tabela.FieldByName('C_INS_SER').AsString = 'S');
  VpaDNota.IndMovimentacaoFisica := (Tabela.FieldByName('C_MOV_FIS').AsString = 'S');
  VpaDNota.IndGeraFinanceiro := (Tabela.FieldByName('c_ger_fin').AsString = 'S');
  VpaDNota.IndCalculaISS := (Tabela.FieldByName('C_CAL_ISS').AsString = 'S');
  VpaDNota.IndExigirCPFCNPJ := (Tabela.FieldByName('C_EXI_CPF').AsString = 'S');
  VpaDNota.DesTextoFiscal := Tabela.FieldByName('L_TEX_FIS').AsString;
  VpadNota.CodPlanoContas := Tabela.FieldByName('C_CLA_PLA').AsString;
  VpadNota.CodCSTNatureza := Tabela.FieldByName('C_COD_CST').AsString;

  if varia.CNPJFilial = CNPJ_AviamentosJaragua then
    VpaDNota.DesTextoFiscal := '';

  Tabela.Close;
  if (VpaDNota.CFOPProdutoIndustrializacao =0) and (VpaDNota.CFOPServico = 0) then
  begin
    VpfCodNatureza := DeletaChars(DeletaChars(VpaDNota.CodNatureza,'.'),' ');
    if Length(VpfCodNatureza) > 4  then
    begin
      if (DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/') = '5933')or
         (DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/') = '6933') then
      begin
        VpaDNota.CFOPServico := StrToInt(DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/'));
        if (DeleteAteChar(VpfCodNatureza,'/') <> '') then
          VpaDNota.CFOPProdutoIndustrializacao := StrToInt(DeleteAteChar(VpfCodNatureza,'/'));
      end
      else
        if (DeleteAteChar(VpfCodNatureza,'/') = '5933') or
           (DeleteAteChar(VpfCodNatureza,'/') = '6933') then
        begin
          VpaDNota.CFOPProdutoIndustrializacao := StrToInt(DeletaChars(CopiaAteChar(VpfCodNatureza,'/'),'/'));
          VpaDNota.CFOPServico := StrToInt(DeleteAteChar(VpfCodNatureza,'/'));
        end;
    end
    else
    begin
      if (VpfCodNatureza = '5933')or
         (VpfCodNatureza = '6933')  then
        VpaDNota.CFOPServico := StrToInt(VpfCodNatureza)
      else
        VpaDNota.CFOPProdutoIndustrializacao := StrToInt(VpfCodNatureza);
    end;
  end;
end;

{*******************Retorna o proximo codigo disponível************************}
function TFuncoesNotaFiscal.RSeqMovNotaFiscalDisponivel(VpaCodFilial,VpaSeqNota : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(I_SEQ_MOV) ULTIMO '+
                            ' from MOVNOTASFISCAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_SEQ_NOT = '+IntToStr(VpaSeqNota));
  result := Aux.FieldByname('ULTIMO').AsInteger+1;
  Aux.close;
end;

{*******************Retorna o proximo codigo disponível************************}
Function TFuncoesNotaFiscal.RetornaProximoCodigoNota(SerieNota : String):Integer;
begin
   Tabela.Sql.Clear;
   Tabela.Sql.Add(' Select Max(I_NRO_NOT) maximo from CadNotaFiscais ' +
                                ' Where C_Ser_Not = ''' + SerieNota + '''');
   if config.NotaFiscalPorFilial then
     Tabela.Sql.add(' and I_Emp_Fil = ' + IntToStr(varia.CodigoEmpFil));         //Codigo da filial Ativa
   Tabela.Open;
   result := tabela.FieldByName('maximo').AsInteger + 1;
   Tabela.close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RTextoClassificacaoFiscal(VpaDNota : TRBDNotaFiscal): String;
var
  Vpflaco : Integer;
  VpfClaFiscal : TStringList;
  VpfIndice : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  result := '';
  VpfClaFiscal := TStringList.Create;
  for VpfLaco :=0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    if VpfDProdutoNota.CodClassificacaoFiscal <> '' then
    begin
      VpfIndice := VpfClaFiscal.IndexOf(VpfDProdutoNota.CodClassificacaoFiscal);
      if VpfIndice < 0 then
      begin
        VpfClaFiscal.Add(VpfDProdutoNota.CodClassificacaoFiscal);
        VpfIndice := VpfClaFiscal.count;
        result := result + IntToStr(VpfIndice)+'-'+VpfDProdutoNota.CodClassificacaoFiscal+'; ';
      end
      else
        inc(VpfIndice);
      VpfDProdutoNota.NumOrdemClaFiscal := vpfIndice;
    end
    else
      VpfDProdutoNota.NumOrdemClaFiscal := 0;
  end;
  VpfClaFiscal.free;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RTextoNotaContaeOrdem(VpaCodCliente : Integer; VpaSerieNota: string;
  VpaDatNota: TDateTime): string;
var
  VpfDCliente : TRBDCliente;
begin
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := VpaCodCliente;
  FunClientes.CarDCliente(VpfDCliente);
  result := 'INSUMOS REMETIDOS PARA INDUSTRIALIZACAO POR CONTA E ORDEM ATRAVES DA NF '+IntToStr(RetornaProximoCodigoNota(VpaSerieNota)+1) + ' SERIE '+VpaSerieNota+ ' DE '+FormatDateTime('DD/MM/YYYY',VpaDatNota)+
            ' PARA '+VpfDCliente.NomCliente+ ' -  '+VpfDCliente.DesEndereco+', '+ VpfDCliente.NumEndereco+'-'+VpfDCliente.DesComplementoEndereco+
            ' BAIRRO: ' +VpfDCliente.DesBairro+' - '+VpfDCliente.DesCidade+'/'+VpfDCliente.DesUF+ 'CNPJ : '+VpfDCliente.CGC_CPF+ ' I.E.'+ VpfDCliente.InscricaoEstadual;
  VpfDCliente.Free;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RTextoNotaRemessaFaccionista(VpaCodCliente, VpaNroNota: Integer;VpaSerieNota : string;VpaDatNota : TDateTime): string;
var
  VpfDCliente : TRBDCliente;
begin
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := VpaCodCliente;
  FunClientes.CarDCliente(VpfDCliente);
  result := 'VENDA POR CONTA E ORDEM ATRAVES DA NF '+IntToStr(VpaNroNota) + ' SERIE '+VpaSerieNota+ ' DE '+FormatDateTime('DD/MM/YYYY',VpaDatNota)+
            ' PARA '+VpfDCliente.NomCliente+ ' -  '+VpfDCliente.DesEndereco+', '+ VpfDCliente.NumEndereco+'-'+VpfDCliente.DesComplementoEndereco+
            ' BAIRRO: ' +VpfDCliente.DesBairro+' - '+VpfDCliente.DesCidade+'/'+VpfDCliente.DesUF+ 'CNPJ : '+VpfDCliente.CGC_CPF+ ' I.E.'+ VpfDCliente.InscricaoEstadual;
  VpfDCliente.Free;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RTextDescontoAcrescimo(VpaDNota : TRBDNotaFiscal):String;
begin
  result := '';
  if VpaDNota.PerDesconto <> 0 then
  begin
    if VpaDNota.PerDesconto > 0 then
      result := 'Desconto de '+FormatFloat('0.00 %',VpaDNota.PerDesconto)
    else
      result := 'Acréscimo de '+FormatFloat('0.00 %',VpaDNota.PerDesconto * -1);
  end
  else
    if VpaDNota.ValDesconto <> 0 then
    begin
      if VpaDNota.ValDesconto > 0 then
        result := 'Desconto de '+FormatFloat(CurrencyString+ ' ###,###,##0.00 ',VpaDNota.ValDesconto)
      else
        result := 'Acréscimo de '+FormatFloat(CurrencyString+ ' ###,###,##0.00 ',VpaDNota.ValDesconto * -1);
    end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarValICMSPadrao(Var VpaValICMSPadrao, VpaValICMSAliquotaInterna,VpaPerReducaoUFICMS: double; VpaSigEstado, VpaInscricaoEstadual : String;VpaIndPessoaJuridica : Boolean;VpaIndCupomFiscal : Boolean;Var VpaSubstituicaTributaria : Boolean);
var
  VpfEstado : String;
begin
  if VpaSigEstado <> 'EX' then //EXPORTACAO
  begin
    if (VpaIndPessoaJuridica) and (VpaInscricaoEstadual <> 'ISENTO')then
    begin
      if VpaSigEstado = '' then
      begin
        erro(CT_UFCLIENTE);
        VpfEstado := Varia.UFFilial;
      end
      else
        VpfEstado := VpaSigEstado;
    end
    else
      VpfEstado := Varia.UFFilial;

    AdicionaSQLAbreTabela(Aux,'Select * from CADICMSESTADOS '+
                              ' Where C_COD_EST = '''+ VpfEstado+''''+
                              ' and I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa));
    VpaValICMSPadrao := Aux.FieldByName('N_ICM_INT').AsFloat;
    VpaSubstituicaTributaria := Aux.FieldByName('C_SUB_TRI').AsString = 'S';
  { 28/03/2011 - colocado em comentario pois nao estava calculando o icms na telas franz, pois o calculo estava sendo feito sobre a natureza de operacao 5403 e o correte é olhar o codigo do CST 010
    if not(VpaIndCupomFiscal) and config.SimplesFederal then
    begin
      VpaValICMSPadrao := 0;
      VpaPerReducaoUFICMS := 0;
      VpaValICMSAliquotaInterna := 0;
    end
    else}
    begin
      if Aux.Eof then
        erro('ICMS ESTADO NÃO CADASTRADO!!!'#13'Não existe cadastrado o icms para o estado "'+VpfEstado+'"');
      VpaPerReducaoUFICMS := Aux.FieldByName('N_RED_ICM').AsFloat;
    end;
    VpaValICMSAliquotaInterna := Aux.FieldByName('N_ICM_EXT').AsFloat;
    Aux.Close;

    if VpfEstado <> VpaSigEstado then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from CADICMSESTADOS '+
                                ' Where C_COD_EST = '''+ VpaSigEstado+''''+
                                ' and I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa));
      VpaSubstituicaTributaria := Aux.FieldByName('C_SUB_TRI').AsString = 'S';
      if Aux.Eof then
        erro('ICMS ESTADO NÃO CADASTRADO!!!'#13'Não existe cadastrado o icms para o estado "'+VpfEstado+'"');
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RPlanoContasMovNatureza(VpaCodNatureza : String;VpaSeqMovimento :Integer;VpaRevendaEdson : Boolean):String;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_CLA_PLA from MOVNATUREZA '+
                            ' Where C_COD_NAT = '''+VpaCodNatureza +''''+
                            ' and I_SEQ_MOV = '+ IntToStr(VpaSeqMovimento));
  result := Aux.FieldByName('C_CLA_PLA').AsString;
  if (varia.CNPJFilial = CNPJ_Kairos) or (Varia.CNPJFilial = CNPJ_AviamentosJaragua) then
  begin
    if VpaRevendaEdson then
      result := '1001003';
  end;
  Aux.Close;
end;

{*********** verifica se existe determinado produto na nota ****************** }
function TFuncoesNotaFiscal.VerificaExisteProdutoNota(VpaCodFilial,SeqPro, SeqNot : integer) : Boolean;
begin
  AdicionaSQLAbreTabela( Tabela, ' Select i_seq_not ' +
                                 ' from MovNotasFiscais ' +
                                 ' where  i_emp_fil = ' + intToStr(VpaCodFilial) +
                                 ' and i_seq_not = ' + intToStr(SeqNot) +
                                 ' and i_seq_pro = ' + intToStr(SeqPro) );
  result := not tabela.eof;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.VerificaExisteProduto(CodProduto : string; var seqpro : integer) : boolean;
begin
  seqpro := 0;
  AdicionaSQLAbreTabela( Tabela, ' Select pro.i_seq_pro ' +
                                 ' from CadProdutos pro, MovQdadeProduto mov ' +
                                 ' where ' + varia.CodigoProduto + ' = ''' + CodProduto + '''' +
                                 ' and pro.i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                 ' and mov.I_EMP_FIL = ' + intToStr(varia.CodigoEmpFil) +
                                 ' and Pro.c_ven_avu = ''S'''+
                                 ' and Pro.C_Ati_Pro = ''S'''+
                                 ' and pro.i_seq_pro = mov.i_seq_pro ' );
  seqpro := tabela.fieldByName('i_seq_pro').AsInteger;
  result := not tabela.eof;
end;


{******************* Verifica Condicao Pgto ********************************** }
function TFuncoesNotaFiscal.VerificaExisteCondicaoPgto( CodCondicao : integer) : Boolean;
begin
  AdicionaSQLAbreTabela( Tabela, ' Select i_cod_pag ' +
                                 ' from CadCondicoesPagto ' +
                                 ' where  i_cod_pag = ' + intToStr(CodCondicao));
  result := not Tabela.Eof;
end;

{*********** verifica se existe um item na nota fiscal *********************** }
function TFuncoesNotaFiscal.VerificaExisteItemNotaAdiciona(VpaCodFilial, SeqNot, SeqPro, SeqMov, VpaCodCor :Integer; QdadePro : Double; NovaUnidade : String  ) : Boolean;
begin
  LocalizaProdutoMovNotaFiscalSeqMov( Cadastro,VpaCodFilial, SeqNot, SeqPro, SeqMov, VpaCodCor );
  result := not Cadastro.eof;

  if result then
  begin
    Cadastro.Edit;
    //atualiza a data de alteracao para poder exportar
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;

    Cadastro.FieldByName('N_Qtd_Pro').AsFloat := Cadastro.FieldByName('N_Qtd_Pro').AsFloat +
                               QdadePro  * ConvUnidade.Indice(Cadastro.FieldByName('C_Cod_Uni').Asstring,
                               NovaUnidade, SeqPro, VpaCodFilial);
    Cadastro.FieldByName('N_TOT_PRO').AsCurrency := Cadastro.FieldByName('N_VLR_PRO').AsCurrency * Cadastro.FieldByName('N_Qtd_Pro').AsFloat;
    Cadastro.post;
    deletaItemNota(VpaCodFilial, SeqMov);
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.VerificaExisteCor(VpaCodCor : String; var VpaNomCor :String):boolean;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from COR'+
                              ' Where COD_COR = '+VpaCodCor );
  VpaNomCor := Tabela.FieldByName('NOM_COR').AsString;
  result := not Tabela.Eof;
  Tabela.close;
end;

procedure TFuncoesNotaFiscal.deletaItemNota( VpaCodFilial,SeqMov : Integer );
begin
   ExecutaComandoSql(Tabela, ' delete movnotasfiscais ' +
                              ' where i_emp_fil = ' + IntToStr(VpaCodFilial) +
                              ' and I_seq_mov = ' + IntToStr(SeqMov) );
end;

procedure TFuncoesNotaFiscal.MudaNotaParaImpressa(VpaCodFilial,SeqNot: Integer);
begin
   ExecutaComandoSql(Tabela,' update cadnotafiscais set C_NOT_IMP = ''S'' ' +
                              ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE) +
                              ' where i_emp_fil = ' + IntToStr(VpaCodFilial) +
                              ' and I_seq_not = ' + IntToStr(SeqNot) );
end;

{************************Verifica se existe a nota*****************************}
Function TFuncoesNotaFiscal.NotaDuplicada(VpaCodFilial : Integer;NroNota,Serie : String; var NovoNumero : Integer) : Boolean;
begin
  if (serie <> '') and (NroNota <> '') then
  begin
     if StrToInt(NroNota) <> 0 then
     begin
       Tabela.Sql.Clear;
       Tabela.Sql.Add('select * from CadNotaFiscais '+
                   ' Where I_NRO_NOT = ' + NroNota +
                   ' and C_SER_NOT = ''' + Serie + '''');
       if config.NotaFiscalPorFilial then
         Tabela.Sql.Add(' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));

       Tabela.Open;

       if not(tabela.Eof) then
       begin
         NovoNumero := RetornaProximoCodigoNota( serie );
         AvisoFormato(CT_NotaRepetida,[StrToInt(NroNota),Serie,NovoNumero]);
       end;
       result := not(tabela.Eof);
     end
     else
     begin
       result := true;
       aviso(CT_NroNotaSerieNula);
     end;
  end
  else
  begin
    result := true;
    aviso(CT_NroNotaSerieNula);
  end;
end;


{********************Acerta a classificacao da nota fiscal*********************}
Function TFuncoesNotaFiscal.AcertaClaFiscal(MovNotas : TDataSet): String;
var
  ClaFiscal : TStringList;
  ordem : Integer;
begin
   ClaFiscal := TStringList.Create;

   result := '';
   MovNotas.DisableControls;
   MovNotas.First;

   while not MovNotas.Eof do
   begin
      if MovNotas.FieldByName('C_Cla_Fis').AsString <> '' then
      begin

        ordem :=  ClaFiscal.IndexOf(MovNotas.FieldByName('C_Cla_Fis').AsString);
        if Ordem < 0 Then
        begin
           ClaFiscal.Add(MovNotas.FieldByName('C_Cla_Fis').AsString);
           result := result + IntToStr(ClaFiscal.Count) + ' - ' +
                        MovNotas.FieldByName('C_Cla_Fis').AsString + '; ';
           ordem := ClaFiscal.count;
        end
        else
           inc(ordem);
        MovNotas.edit;
        MovNotas.FieldByName('I_Ord_Fis').AsInteger := ordem;
        //atualiza a data de alteracao para poder exportar
        MovNotas.FieldByname('D_ULT_ALT').AsDateTime := Date;
        MovNotas.post;
      end;
      MovNotas.next;
   end;
   MovNotas.EnableControls;
end;

{************* Unidades paretes de uma determinada unidade ****************** }
function TFuncoesNotaFiscal.UnidadesParentes( Unidade : string ) : TStringList;
begin
  result := TStringList.create;
  result := valUnidade.UnidadesParentes(Unidade);
end;

{************* valida a unidade atual conforme a padrao ********************** }
function TFuncoesNotaFiscal.ValidaUnidade( unidadeAtual, UnidadePadrao : string ) : Boolean;
begin
  result := true;
  if not ValUnidade.ValidaUnidade(unidadeAtual,UnidadePadrao) then
    result := false;
end;

{************** calcula valor do poduto para a unidade padrao do mesmo ******* }
procedure TFuncoesNotaFiscal.CalculaValorFreteProdutos(VpaDNota: TRBDNotaFiscal);
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfTotalFrete, VpfPerFreteProduto : Double;
  VpfTotalOutrasDespesas, VpfPerOutrasDespesas : Double;
begin
  VpfTotalFrete := 0;
  VpfTotalOutrasDespesas := 0;
  for VpfLaco := 0 to VpaDNota.Produtos.Count -1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    VpfPerFreteProduto := (VpfDProdutoNota.ValTotal *100)/VpaDNota.ValTotalProdutosSemDesconto;
    VpfDProdutoNota.ValFrete := ArredondaDecimais((VpaDNota.ValFrete * VpfPerFreteProduto)/100,2);
    VpfTotalFrete := VpfTotalFrete + VpfDProdutoNota.ValFrete;

    VpfPerOutrasDespesas := (VpfDProdutoNota.ValTotal *100)/VpaDNota.ValTotalProdutosSemDesconto;
    VpfDProdutoNota.ValOutrasDespesas := ArredondaDecimais((VpaDNota.ValOutrasDepesesas * VpfPerOutrasDespesas)/100,2);
    VpfTotalOutrasDespesas := VpfTotalOutrasDespesas + VpfDProdutoNota.ValOutrasDespesas;


    if VpfLaco = VpaDNota.Produtos.Count -1 then
    begin
      VpfDProdutoNota.ValFrete := VpfDProdutoNota.ValFrete + (VpaDNota.ValFrete - VpfTotalFrete);
      VpfDProdutoNota.ValOutrasDespesas := VpfDProdutoNota.ValOutrasDespesas + (VpaDNota.ValOutrasDepesesas - VpfTotalOutrasDespesas);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.CalculaValorPadrao( unidadeAtual, UnidadePadrao : string; ValorTotal : double; SequencialProduto : integer) : Double;
var
  indice : double;
begin
  // indice para calculo de qdade / valor *
  indice := ConvUnidade.Indice(UnidadeAtual,UnidadePadrao,SequencialProduto,varia.CodigoEmpresa);
 if (unidadeAtual = Varia.UnidadeCX) or ( unidadeAtual = Varia.UnidadeUN ) then
   result := ArredondaDecimais((ValorTotal * ArredondaDecimais(indice,7)),2)
 else
   result := ArredondaDecimais((ValorTotal / ArredondaDecimais(indice,7)),2)
end;


{******************************************************************************}
procedure TFuncoesNotaFiscal.ConfiguraFatura( VpaGrade : TStringGrid; VpaQtd : integer; VpaTexto : TLabel);
var
  VpfQtdColunas, VpfTamanho, VpfLaco : Integer;
begin
  case VpaQtd of
    1 : begin VpfQtdColunas := 3; ; end;
    2 : begin VpfQtdColunas := 6; ; end;
    3 : begin VpfQtdColunas := 9; ; end;
    4 : begin VpfQtdColunas := 12 ; end;
  end;

  VpfTamanho := VpaGrade.Width div VpfQtdColunas;

 VpaGrade.ColCount := VpfQtdColunas;

 VpaTexto.Caption := '';
 for VpfLaco := 0 to VpfQtdColunas - 1 do
 begin
   case VpfLaco + 1 of
     1,4,7,10 :  VpaTexto.Caption := VpaTexto.Caption + CentraStr('NÚMERO', trunc( (VpfTamanho-19)/3));
     2,5,8,11 :  VpaTexto.Caption := VpaTexto.Caption + CentraStr('VENCIMENTO', trunc( (VpfTamanho-21)/3));
     3,6,9,12 :  VpaTexto.Caption := VpaTexto.Caption + CentraStr('VALOR', trunc( (VpfTamanho-22)/3));
   end;
   VpaGrade.ColWidths[VpfLaco] := VpfTamanho;
 end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CalculaValorTotal(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente);
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfDServicoNota : TRBDNotaFiscalServico;
  VpfValReducaoBaseICMS, VpfValBaseST, VpfPerDesconto : Double;
  VpfPesBruto, VpfPesLiquido, VpfMVA : Double;
begin
  VpaDNota.ValTotalProdutos := 0;
  VpaDNota.ValTotalProdutosSemDesconto := 0;
  VpaDNota.ValBaseICMS := 0;
  VpaDNota.ValICMSSubtituicao := 0;
  VpaDNota.ValBaseICMSSubstituicao := 0;
  VpaDNota.ValTotalIPI := 0;
  VpaDNota.ValICMS := 0;
  VpaDNota.ValIssqn := 0;
  VpaDNota.ValICMSSuperSimples := 0;
  VpaDNota.IndReducaoICMS := false;
  VpfPesLiquido := 0;
  VpfPesBruto := 0;
  for  Vpflaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    VpaDNota.ValTotalProdutos := VpaDNota.ValTotalProdutos + ArredondaDecimais(VpfDProdutoNota.ValTotal,2);
    VpaDNota.ValTotalProdutosSemDesconto := VpaDNota.ValTotalProdutosSemDesconto + ArredondaDecimais(VpfDProdutoNota.ValTotal,2);
  end;
  CalculaValorFreteProdutos(VpaDNota);
  //calcula o percentual de desconto da nota.
  VpfPerDesconto := 0;
  if VpaDNota.PerDesconto <> 0 then
    VpfPerDesconto := VpaDNota.PerDesconto
  else
    if (VpaDNota.ValDesconto <> 0) and (VpaDNota.ValTotalProdutos > 0) then
      VpfPerDesconto := (VpaDNota.ValDesconto *100) / VpaDNota.ValTotalProdutos;

  for  Vpflaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    VpfDProdutoNota.ValBaseICMS := 0;
    VpfDProdutoNota.ValICMS := 0;

    VpfDProdutoNota.ValDesconto := ArredondaDecimais(((VpfDProdutoNota.ValTotal *VpfPerDesconto)/100),2);
    VpfDProdutoNota.ValICMS := 0;
    if (not config.SimplesFederal and not VpaDNota.IndNaturezaNotaDevolucao) or (VpaDNota.IndNaturezaNotaDevolucao and not VpaDCliente.IndSimplesNacional) then
    begin
      VpaDNota.ValTotalIPI := VpaDNota.ValTotalIPI + VpfDProdutoNota.ValIPI;
      if ProdutoTributado(VpfDProdutoNota) then
      begin
        VpfDProdutoNota.ValBaseICMS := VpfDProdutoNota.ValTotal +VpfDProdutoNota.ValFrete +VpfDProdutoNota.ValOutrasDespesas - VpfDProdutoNota.ValDesconto;
        VpfValReducaoBaseICMS := (VpfDProdutoNota.PerReducaoUFBaseICMS*VpfDProdutoNota.ValBaseICMS)/ 100;
        VpfDProdutoNota.ValBaseICMS := ArredondaDecimais(VpfDProdutoNota.ValBaseICMS - VpfValReducaoBaseICMS,2);
        VpfDProdutoNota.ValICMS := ArredondaDecimais((VpfDProdutoNota.ValBaseICMS * VpfDProdutoNota.PerICMS)/100,2);
        VpaDNota.ValBaseICMS := VpaDNota.ValBaseICMS +VpfDProdutoNota.ValBaseICMS;
        VpaDNota.ValICMS := VpaDNota.ValICMS + VpfDProdutoNota.ValICMS;
      end;
    end;
    if VpaDCliente.IndUFConvenioSubstituicaoTributaria then
    begin
      if  (VpfDProdutoNota.PerSubstituicaoTributaria > 0) and
          (copy(VpfDProdutoNota.CodCST,2,2) ='10')then
      begin
        if VpaDCliente.DesUF = VpaDNota.DesUFFilial then
          VpfMVA := VpfDProdutoNota.PerSubstituicaoTributaria
        else
          VpfMVA := RMVAAjustado(VpaDNota,VpfDProdutoNota);
        if (VpaDCliente.IndSimplesNacional and not VpaDNota.IndNaturezaNotaDevolucao) or
           (VpaDNota.IndNaturezaNotaDevolucao and Config.SimplesFederal)   then
          VpfMVA := VpfMVA - ArredondaDecimais(((VpfMVA *70)/100),2);

        VpfValBaseST :=VpfDProdutoNota.ValTotal +ArredondaDecimais(((VpfDProdutoNota.ValTotal*VpfMVA )/100),2);
        VpfDProdutoNota.ValBaseICMSSubstituicao := VpfValBaseST;
        VpfDProdutoNota.ValICMSSubtituicao := ((VpfValBaseST *VpfDProdutoNota.PerICMS)/100) - ((VpfDProdutoNota.ValTotal * VpfDProdutoNota.PerICMS)/100);
        VpaDNota.ValBaseICMSSubstituicao := VpaDNota.ValBaseICMSSubstituicao + VpfValBaseST;
        VpaDNota.ValICMSSubtituicao := VpaDNota.ValICMSSubtituicao + ((VpfValBaseST *VpfDProdutoNota.PerICMS)/100) - ((VpfDProdutoNota.ValTotal * VpfDProdutoNota.PerICMS)/100);
      end;
    end;

    VpfPesBruto := VpfPesBruto + (VpfDProdutoNota.QtdProduto * VpfDProdutoNota.PesBruto);
    VpfPesLiquido := VpfPesLiquido + (VpfDProdutoNota.QtdProduto * VpfDProdutoNota.PesLiquido);
  end;
  if VpaDNota.Produtos.Count > 0 then
  begin
    if VpaDNota.ValDesconto <> 0 then
      VpaDNota.ValTotalProdutos := VpaDNota.ValTotalProdutos - VpaDNota.ValDesconto
    else
      if VpaDNota.PerDesconto <> 0 then
        VpaDNota.ValTotalProdutos := VpaDNota.ValTotalProdutos - ((VpaDNota.ValTotalProdutos * VpaDNota.PerDesconto)/100);
    if VpaDNota.ValDescontoTroca <> 0 then
      VpaDNota.ValTotalProdutos := VpaDNota.ValTotalProdutos - VpaDNota.ValDescontoTroca
  end;

  if (VpfPesBruto <> 0) then
    VpaDNota.PesBruto := VpfPesBruto;
  if VpfPesLiquido <> 0 then
    VpaDNota.PesLiquido := VpfPesLiquido;

  VpaDNota.ValTotalServicos := 0;
  for VpfLaco := 0 to VpaDNota.Servicos.Count - 1 do
  begin
    VpfDServicoNota := TRBDNotaFiscalServico(VpaDNota.Servicos.Items[VpfLaco]);
    if (VpfDServicoNota.ValTotal <> 0)and not(config.SimplesFederal) then
      VpaDNota.ValIssqn := VpaDNota.ValIssqn + (VpfDServicoNota.ValTotal * VpfDServicoNota.PerIssqn)/100;
    if VpaDNota.PerDesconto <> 0 then
      VpaDNota.ValTotalServicos := VpaDNota.ValTotalServicos + (VpfDServicoNota.ValTotal - (VpfDServicoNota.ValTotal * VpaDNota.PerDesconto)/100)
    else
      VpaDNota.ValTotalServicos := VpaDNota.ValTotalServicos + VpfDServicoNota.ValTotal;
  end;

  if VpaDNota.Produtos.Count = 0 then
    VpaDNota.ValTotalServicos := VpaDNota.ValTotalServicos - VpaDNota.ValDesconto;

  VpaDNota.ValTotal := VpaDNota.ValTotalProdutos + VpaDNota.ValTotalServicos;
  if VpaDNota.IndDescontarISS and not config.SimplesFederal then
    VpaDNota.ValTotal := VpaDNota.ValTotal - VpaDNota.ValIssqn;


  //o valor do frete não é adicionado no desconto
  if VpaDNota.CodTipoFrete = 1 then //Emitente - se o emitente paga o frete
  begin
    VpaDNota.ValTotal := VpaDNota.Valtotal + VpaDNota.ValFrete + VpaDNota.ValSeguro;
    if not config.SimplesFederal then
    begin
      VpaDNota.ValICMS := VpaDNota.ValICMS + (((VpaDNota.ValSeguro) * VpaDNota.ValICMSPadrao)/100);
      VpaDNota.ValBaseICMS := VpaDNota.ValBaseICMS +  VpaDNota.ValSeguro;
    end;
  end;
  VpaDNota.ValTotal := VpaDNota.ValTotal + VpaDNota.ValTotalIPI + VpaDNota.ValOutrasDepesesas+ VpaDNota.ValICMSSubtituicao;

  if config.SimplesFederal and not VpaDNota.IndNaturezaNotaDevolucao then
  begin
    VpaDNota.PerICMSSuperSimples := varia.PerCreditoICMSSimples;
    VpaDNota.ValICMSSuperSimples := RValAproveitamentoCreditoICMS(VpaDCliente,VpaDNota);
  end
  else
  begin
    VpaDNota.PerICMSSuperSimples := 0;
    VpaDNota.ValICMSSuperSimples := 0;
  end;
end;

{************************Realiza os calculos da nota***************************}

{*************** verifica se o produto ja existe na nota fiscal **************}
function TFuncoesNotaFiscal.ExisteProdutoNota(VpaMovNota : TDataSet; VpaCodFilial, VpaSeqNota, VpaSeqProduto : Integer) : Boolean;
begin
  result := VpaMovNota.Locate('I_Emp_fil;I_SEQ_NOT;I_Seq_Pro',VarArrayOf([VpaCodFilial,VpaSeqNota,VpaSeqProduto]),[locaseinsensitive]);
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExisteProduto(VpaCodProduto : String; VpaDNota :TRBDNotaFiscal; VpaDProdutoNota : TRBDNotaFiscalProduto):Boolean;
begin
  result := false;
  if (VpaCodProduto <> '') or (VpaDProdutoNOta.SeqProduto <> 0)   then
  begin
    Aux.Sql.Clear;
    Aux.Sql.add('Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, PRO.C_CLA_FIS, '+
                                  ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_IPI, PRO.N_RED_ICM,'+
                                  ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                                  ' (Pre.N_Vlr_REV * Moe.N_Vlr_Dia) VlrREVENDA, ' +
                                  ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                                  ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, PRO.N_PER_COM, ' +
                                  ' PRO.I_MES_GAR, PRO.I_ORI_PRO, '+
                                  ' CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO '+
                                  ' from CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                                  ' MOVQDADEPRODUTO Qtd, CADCLASSIFICACAO CLA ' +
                                  ' Where Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                                  ' and Pre.I_Cod_Tab = ' + IntToStr(Varia.TabelaPreco)+
                                  ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                  ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(VpaDNota.CodFilial)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and Pro.c_ven_avu = ''S'''+
                                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' and PRE.I_COD_CLI IN (0,'+IntToStr(VpaDNota.CodCliente)+')');
    if VpaCodProduto <> '' then
      Aux.Sql.Add(' and '+Varia.CodigoProduto +' = ''' + VpaCodProduto +'''')
    else
      Aux.Sql.Add(' and PRO.I_SEQ_PRO = '+IntToStr(VpaDProdutoNota.SeqProduto));
    Aux.SQl.Add(' order by PRE.I_COD_CLI DESC');
    Aux.open;

    result := not Aux.Eof;
    if result then
    begin
      with VpaDProdutoNota do
      begin
        UMOriginal := Aux.FieldByName('C_Cod_Uni').Asstring;
        UM := Aux.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := UM;
        ValUnitarioOriginal := Aux.FieldByName('VlrReal').AsFloat;
        QtdEstoque := Aux.FieldByName('QdadeReal').AsFloat;
        QtdMinima := Aux.FieldByName('N_QTD_Min').AsFloat;
        QtdPedido := Aux.FieldByName('N_QTD_Ped').AsFloat;
        CodProduto := Aux.FieldByName(Varia.CodigoProduto).Asstring;
        if (VpaDNota.IndClienteRevenda) and (Aux.FieldByName('VlrREVENDA').AsFloat <> 0) then
          ValUnitario := Aux.FieldByName('VlrREVENDA').AsFloat
        else
          ValUnitario := Aux.FieldByName('VlrReal').AsFloat;
        QtdProduto := 1;
        SeqProduto := Aux.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Aux.FieldByName('C_NOM_PRO').AsString;
        PesLiquido := Aux.FieldByName('N_PES_LIQ').AsFloat;
        PesBruto := Aux.FieldByName('N_PES_BRU').AsFloat;
        NumOrigemProduto := Aux.FieldByName('I_ORI_PRO').AsInteger;
        if config.UtilizarClassificacaoFiscalnosProdutos then
          CodClassificacaoFiscal := Aux.FieldByName('C_CLA_FIS').AsString;
        PerComissaoProduto := Aux.FieldByName('N_PER_COM').AsFloat;
        PerComissaoClassificacao := Aux.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
        CodClassificacaoProduto := Aux.FieldByName('C_COD_CLA').AsString;
        QtdMesesGarantia := Aux.FieldByName('I_MES_GAR').AsInteger;
        PerICMS := 0;
        PerIPI := 0;
        if (Aux.FieldByName('N_PER_IPI').AsFloat <> 0) and not(config.SimplesFederal) then
          PerIPI := Aux.FieldByName('N_PER_IPI').AsFloat;
        if Aux.FieldByName('N_RED_ICM').AsFloat <> 0 then
        begin
          IndReducaoICMS := true;
          PerReducaoICMSProduto := Aux.FieldByName('N_RED_ICM').AsFloat;
        end
        else
          IndReducaoICMS := false;
        if (config.EmitirECF or config.EmiteSped) then
        begin
          if VpaDProdutoNota.CodClassificacaoFiscal = '' then
          begin
            result := false;
            aviso('CODIGO NCM/CLASSIFICAÇÃO FISCAL NÃO PREENCHIDO!!!'#13'É necessário digitar o codigo NCM do produto.');
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExisteSequencialNota(VpaCodFilial, VpaSeqNota: Integer): boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_EMP_FIL from CADNOTAFISCAIS ' +
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_SEQ_NOT = ' +IntToStr(VpaSeqNota));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExisteSerieNota(VpaNumNota: Integer;  VpaNumSerie: String): Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'SELECT I_NRO_NOT, C_SER_NOT FROM CADNOTAFISCAIS '+
                            ' WHERE I_NRO_NOT = '+IntToStr(VpaNumNota)+
                            ' AND C_SER_NOT = ''' + VpaNumSerie + '''');
  Result:= not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExisteServico(VpaCodServico : String;VpaDNota : TRBDNotaFiscal; VpaDServicoNota : TRBDNotaFiscalServico):Boolean;
begin
  result := false;
  if VpaCodServico <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select (Moe.N_Vlr_dia * Pre.N_Vlr_Ven) Valor, SER.C_NOM_SER, SER.I_COD_SER, N_PER_ISS,  '+
                           ' SER.I_COD_FIS, '+
                           ' CLA.C_COD_CLA, CLA.N_PER_COM '+
                           ' from cadservico Ser, MovTabelaPrecoServico Pre, CadMoedas Moe, CADCLASSIFICACAO CLA ' +
                           ' where Ser.I_Cod_ser = ' + VpaCodServico +
                           ' and Pre.I_Cod_ser = Ser.I_Cod_Ser ' +
                           ' and Pre.i_cod_emp = ' + IntToStr(varia.codigoEmpresa) +
                           ' and Pre.I_Cod_tab = '+ IntToStr(Varia.TabelaPrecoServico)+
                           ' and Moe.I_cod_Moe = Pre.I_Cod_Moe'+
                           ' and SER.I_COD_EMP = CLA.I_COD_EMP '+
                           ' and SER.C_COD_CLA = CLA.C_COD_CLA '+
                           ' and SER.C_TIP_CLA = CLA.C_TIP_CLA ');
    result := not Tabela.Eof;
    if result then
    begin
      with VpaDServicoNota do
      begin
        NomServico := Tabela.FieldByName('C_NOM_SER').AsString;
        CodServico := Tabela.FieldByName('I_COD_SER').AsInteger;
        QtdServico := 1;
        ValUnitario := Tabela.FieldByName('Valor').AsFloat;
        if Tabela.FieldByName('N_PER_ISS').AsFloat > 0 then
          PerISSQN := Tabela.FieldByName('N_PER_ISS').AsFloat
        else
          PerISSQN := varia.ISSQN;
        CodClassificacao := Tabela.FieldByName('C_COD_CLA').AsString;
        PerComissaoClassificacao := Tabela.FieldByName('N_PER_COM').AsFloat;
        CodFiscal := Tabela.FieldByName('I_COD_FIS').AsInteger;
      end;
    end;
    Tabela.Close;
  end;


end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExisteCor(VpaCodCor :String;VpaDProdutoNota : TRBDNotaFiscalProduto):Boolean;
begin
  result := false;
  if VpaCodCor <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              ' Where COD_COR = '+VpaCodCor );
    result := not Aux.eof;
    if result then
    begin
      VpaDProdutoNota.CodCor := Aux.FieldByName('COD_COR').AsInteger;
      VpaDProdutoNota.DesCor := Aux.FieldByName('NOM_COR').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExisteModelo(VpaCodModelo: String): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT CODTIPODOCUMENTOFISCAL FROM TIPODOCUMENTOFISCAL  '+
                               'WHERE CODTIPODOCUMENTOFISCAL = '''+(VpaCodModelo)+'''');
  Result:= not Tabela.Eof;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExisteNota(VpaNumNota: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'SELECT I_NRO_NOT FROM CADNOTAFISCAIS '+
                               'WHERE I_NRO_NOT = '+IntToStr(VpaNumNota));
  Result:= not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.AlteraValorICMS(VpaDNota : TRBDNotaFiscal);
var
  VpfLaco : Integer;
  VpfDProdutoNota :TRBDNotaFiscalProduto;
begin
  for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    if VpaDNota.IndCalculaICMS then
    begin
      if not VpfDProdutoNota.IndReducaoICMS then
        VpfDProdutoNota.PerICMS := VpaDNota.ValICMSPadrao
    end
    else
      VpfDProdutoNota.PerICMS := 0;
  end;
end;

{******************* Adiciona um produto do tipo kit na nota ***************** }
function TFuncoesNotaFiscal.AdicionaProdutoKit(VpaMovNF, Produtos : TDataSet;VpaCodFilial, VpaSeqNota,VpaSeqProduto : Integer; CalculaIcms : String; var TextoCodProduto : string) : Boolean; // retorna se tem produto com reducao
var
  Kit : TSQLQuery;
begin
  result := false;
  Kit := TSQLQuery.Create(nil);
  Kit.SQLConnection := DataBase;

  LocalizaKit(Kit, VpaCodFilial,VpaSeqProduto );

  VpaMovNF.DisableControls;
  while not Kit.Eof do
  begin
    TextoCodProduto := TextoCodProduto + ', ' + Kit.FieldByname('I_Seq_Pro').AsString;
    LocalizaProdutoCodigos( Produtos, TextoCodProduto );
    if ExisteProdutoNota(VpaMovNF,VpaCodFilial,VpaSeqNota,Kit.FieldByname('I_Seq_Pro').AsInteger) then
    begin
      VpaMovNF.Edit;
      //atualiza a data de alteracao para poder exportar
      VpaMovNF.FieldByname('D_ULT_ALT').AsDateTime := DATE;
      VpaMovNF.FieldByName('N_Qtd_Pro').AsFloat := VpaMovNF.FieldByName('N_Qtd_Pro').AsFloat +
                             (Kit.FieldByName('N_Qtd_Pro').AsFloat  * ConvUnidade.Indice(VpaMovNF.FieldByName('C_Cod_Uni').Asstring,
                              Kit.FieldByName('C_Cod_Uni').Asstring, Kit.FieldByName('I_Seq_Pro').AsInteger,
                              VpaCodFilial));
      VpaMovNF.post;
    end
    else
    begin
      VpaMovNF.Insert;
      VpaMovNF.Fieldbyname('I_Emp_Fil').AsInteger := VpaCodFilial;
      VpaMovNF.Fieldbyname('I_SEQ_MOV').asInteger := ProximoCodigoFilial('MovNotasFiscais','I_SEQ_MOV','I_EMP_FIL',VpaCodFilial,Aux.SQLConnection);
      VpaMovNF.Fieldbyname('I_SEQ_NOT').AsInteger := VpaSeqNota;
      VpaMovNF.FieldByName('C_Cod_Pro').Asstring := Kit.FieldByName(varia.CodigoProduto).Asstring;
      VpaMovNF.FieldByName('N_Vlr_Pro').AsFloat := Kit.FieldByName('VlrReal').AsFloat * ( 1 - (Kit.FieldbyName('N_Per_Kit').AsFloat /100));
      VpaMovNF.FieldByName('C_COD_UNI').AsString := Kit.fieldByName('C_COD_UNI').AsString;
      VpaMovNF.FieldByName('N_QTD_PRO').AsFloat :=  Kit.fieldByName('N_QTD_PRO').AsFloat;
      VpaMovNF.Fieldbyname('I_Seq_Pro').AsInteger := Kit.FieldByName('I_Seq_Pro').AsInteger;
      //atualiza a data de alteracao para poder exportar
      VpaMovNF.FieldByname('D_ULT_ALT').AsDateTime := DATE;
      if CalculaIcms = 'S' then   // caso naum gere icms e ipi
      begin
        VpaMovNF.Fieldbyname('N_PER_IPI').AsFloat := Kit.FieldByName('N_PER_IPI').AsFloat;
        if Kit.FieldByname('n_red_icm').AsFloat <> 0 then
        begin
          VpaMovNF.Fieldbyname('N_PER_ICM').AsFloat := kit.FieldByname('n_red_icm').AsFloat;
          result := true;
        end;
      end
      else
      begin
         VpaMovNF.Fieldbyname('N_PER_ICM').AsFloat := 0;
         VpaMovNF.Fieldbyname('N_PER_IPI').AsFloat := 0;
      end;
      VpaMovNF.Fieldbyname('C_CLA_FIS').AsString := Kit.FieldByname('c_cla_fis').AsString;

      VpaMovNF.Post;
    end;
    Kit.Next;
  end;
  VpaMovNF.EnableControls;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.AdicionaTextoProEmprego(VpaDNota: TRBDNotaFiscal;VpaDCliente : TRBDCliente);
begin
  if VpaDCliente.DesResolucaoProEmprego <> '' then
    VpaDNota.DesDadosAdicinais.Add('ICMS DIFERIDO - EMPRESA ENQUADRADA NO PRO-EMPREGO CONFORME DECRETO 105/207 RESOLUCAO NR '+
                               VpaDCliente.DesResolucaoProEmprego);
end;

{******************************************************************************}
function TFuncoesNotaFiscal.AdicionaFinanceiroArquivoRemessa(VpaCodFilial, VpaSeqNota : Integer):String;
begin
  Result := '';
  if ConfigModulos.Bancario then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select MOV.I_COD_FRM, MOV.C_NRO_CON, MOV.I_EMP_FIL,MOV.I_LAN_REC, '+
                                    ' MOV.I_NRO_PAR '+
                                    ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                    ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                    ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                    ' AND CAD.I_EMP_FIL = '+IntTostr(VpaCodFilial)+
                                    ' AND CAD.I_SEQ_NOT = '+Inttostr(VpaSeqNota)+
                                    ' order by MOV.I_NRO_PAR ');
    While not Tabela.Eof do
    begin
      if (Tabela.FieldByName('I_COD_FRM').AsInteger = varia.FormaPagamentoBoleto)then
        result :=   FunContasAReceber.AdicionaRemessa(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_LAN_REC').AsInteger,Tabela.FieldByName('I_NRO_PAR').AsInteger,1,'Remessa');
      if result <> '' then
        Tabela.last;
      Tabela.next;
    end;
    Tabela.close;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.AssinaRegistroNota(VpaCodFilial,VpaSeqNota: Integer): string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADNOTAFISCAIS ' +
                                 ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                 ' AND I_SEQ_NOT = '+IntToStr(VpaSeqNota));
  Cadastro.edit;
  Cadastro.FieldByName('C_ASS_REG').AsString := sistema.RAssinaturaRegistro(Cadastro);
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.AssinaRegistroNotaProduto(VpaCodFilial, VpaSeqNota, VpaSeqItem: Integer): string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVNOTASFISCAIS ' +
                                 ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                                 ' and I_SEQ_NOT = ' +IntToStr(VpaSeqNota)+
                                 ' AND I_SEQ_MOV = ' + IntToStr(VpaSeqItem));
  Cadastro.Edit;
  Cadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(Cadastro);
  Cadastro.post;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.AssociaNotaOrcamento(VpaEmpfil,VpaSeqNota,VpaFilialOrcamento, VpaLanOrcamento : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM MOVNOTAORCAMENTO '+
                               ' Where I_EMP_FIL = '+ IntToStr(VpaEmpfil)+
                               ' AND I_SEQ_NOT = '+ IntToStr(VpaSeqNota)+
                               ' AND I_LAN_ORC = '+ IntToStr(VpaLanOrcamento)+
                               ' AND I_FIL_ORC = '+ IntToStr(VpaFilialOrcamento));
  if Tabela.Eof then
    ExecutaComandoSql(Tabela,'INSERT INTO MOVNOTAORCAMENTO(I_EMP_FIL, I_SEQ_NOT, I_LAN_ORC,I_FIL_ORC) VALUES ('+
                        IntTostr(VpaEmpFil)+','+IntToStr(VpaSeqNota)+ ','+IntToStr(VpaLanOrcamento)+','+IntToStr(VpaFilialOrcamento)+')');
end;

{******************************************************************************}
function TFuncoesNotaFiscal.AssociaNotaRomaneio(VpaCodFilialRomaneio,VpaSeqRomaneio, VpaCodFilialNota, VpaSeqNota, VpaNumNota: Integer): string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * FROM ROMANEIOORCAMENTO ' +
                                 ' Where CODFILIAL = ' +IntToStr(VpaCodFilialRomaneio)+
                                 ' AND SEQROMANEIO = ' +IntToStr(VpaSeqRomaneio));
  Cadastro.Edit;
  Cadastro.FieldByName('DATFIM').AsDateTime := now;
  Cadastro.FieldByName('CODFILIALNOTA').AsInteger := VpaCodFilialNota;
  Cadastro.FieldByName('SEQNOTA').AsInteger := VpaSeqNota;
  Cadastro.FieldByName('NUMNOTA').AsInteger := VpaNumNota;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{*********** conta linhas de uma tabela ************************************* }
function TFuncoesNotaFiscal.ContaLinhasTabela( Tab : TDataSet ) : Integer;
begin
  result := 0;
  tab.DisableControls;
  tab.First;
  while not tab.Eof do
  begin
    inc(result);
    tab.Next;
  end;
  tab.First;
  tab.EnableControls;
end;


{##############################################################################
                      Comissoes dos vendedores
############################################################################## }


{****** calcula a comissao conforme o tipo configurado no cfg *************** }
function  TFuncoesNotaFiscal.ValorComissaoCFGProduto( TotalNota, TotalProdutos, ValorICMS,
                                                      ValorIPI, ValorISSQN : Double ) : Double;
begin
  result := 0;
  case varia.TipoComissaoProduto of
    1 : result := TotalNota;
    2 : result := TotalNota - ValorICMS;
    3 : result := TotalNota - ValorICMS - ValorIPI;
    4 : result := TotalNota - ValorICMS - ValorIPI - ValorISSQN;
    5 : result := TotalProdutos;
    6 : result := TotalProdutos - ValorICMS;
    7 : result := TotalProdutos - ValorICMS - ValorIPI;
    8 : result := 0;
  end;
end;

{****** calcula a comissao conforme o tipo configurado no cfg *************** }
function  TFuncoesNotaFiscal.ValorComissaoCFGServico( TotalServicos,ValorISSQN : Double ) : Double;
begin
  result := 0;
  if Varia.TipoComissaoProduto <> 1 then // diferente do total da nota fiscal.
  begin
    case varia.TipoComissaoServico of
      1 : result := TotalServicos;
      2 : result := TotalServicos - ValorISSQN;
    end;
  end
end;


function TFuncoesNotaFiscal.RetornaValorServico( CodServico : Integer ) : Double;
begin
  AdicionaSQLAbreTabela(Tabela, ' Select n_vlr_ven from MovTabelaPrecoServico ' +
                                 ' where i_cod_ser = ' +  IntTostr(CodServico)  +
                                 ' and i_cod_tab = ' + IntToStr(varia.TabelaPrecoServico) +
                                 ' and i_cod_emp = ' + IntToStr(varia.CodigoEmpresa));
  result :=  Tabela.fieldByName('n_vlr_ven').AsCurrency;
end;


{******************** retorna o numero do icms da impre.  fiscal ************* }
function TFuncoesNotaFiscal.LocalizaICMSEcf( ICMS : Double ) : Double;
var
  icmsAtual : Double;
begin
  result := 0;
  AdicionaSQLAbreTabela( tabela, 'select * from CadICMSECF where N_PER_ICM = ' +
                                  SubstituiStr(floatToStr(ICMS),',','.'));

  if not Tabela.Eof then
    result := tabela.fieldByName('C_COD_ICM').AsFloat
  else
  begin
    avisoFormato(CT_AlicotaNaoCadastradaECF, [ Tabela.fieldByName('C_COD_ICM').Asstring ] );
    AdicionaSQLAbreTabela( tabela, ' select * from  cadicmsestados where ' +
                                   ' c_cod_est = ''' + varia.UFFilial + '''');
    icmsAtual := tabela.fieldByName('N_ICM_INT').AsFloat;

    AdicionaSQLAbreTabela( tabela, 'select * from CadICMSECF where N_PER_ICM = ' +
                                    SubstituiStr(floatToStr(icmsAtual),',','.'));
    if not Tabela.Eof then
      result := tabela.fieldByName('C_COD_ICM').AsFloat;
 end;

end;

procedure TFuncoesNotaFiscal.PosicionaFaturas(Tabela: TDataSet;VpaCodFilial, SeqNota: Integer);
begin
  AdicionaSQLAbreTabela(Tabela,
              ' select CR.I_LAN_REC, MCR.C_NRO_DUP, MCR.N_VLR_PAR, MCR.D_DAT_VEN ' +
              ' from CadContasAReceber as CR, MovContasaReceber as MCR ' +
              ' where  ' +
              ' CR.I_SEQ_NOT = ' + IntToStr(SeqNota) +
              ' and CR.I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
              ' and CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
              ' and CR.I_LAN_REC =  MCR.I_LAN_REC' );
end;

{*******************Retorna o proximo codigo disponível************************}
function TFuncoesNotaFiscal.RetornaVendedorNota(CodVendedor: Integer): string;
begin
  AdicionaSQLAbreTabela(Tabela,
    ' select * from CadVendedores ' +
    ' where I_COD_VEN = ' + IntToStr(CodVendedor));
  Result := Tabela.FieldByName('C_NOM_VEN').AsString;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RMVAAjustado(VpaDNota: TRBDNotaFiscal; VpaDProdutoNota: TRBDNotaFiscalProduto): double;
Var
  VpfA, VpfB : Double;
begin
  VpfA := 1+(VpaDProdutoNota.PerSubstituicaoTributaria/100);
  VpfB := (1-(VpaDNota.ValICMSPadrao/100))/((1-(VpaDNota.ValICMSAliquotaInternaUFDestino/100)));
  result := ((VpfA*VpfB)-1)*100;
end;

{***************************************************************************** }
function TFuncoesNotaFiscal.RCFOPProduto(VpaDCliente : TRBDCLiente; VpaDNatureza: TRBDNaturezaOperacao; VpaDProduto : TRBDProduto): Integer;
begin
  if (VpaDProduto.IndSubstituicaoTributaria) or
     (VpaDCliente.IndUFConvenioSubstituicaoTributaria and (VpaDProduto.PerSubstituicaoTributaria > 0)) then
  begin
    if VpaDProduto.NumDestinoProduto = dpRevenda then
      result := VpaDNatureza.CFOPSubstituicaoTributariaRevenda
    else
      result := VpaDNatureza.CFOPSubstituicaoTributariaIndustrializacao
  end
  else
  begin
    if VpaDProduto.NumDestinoProduto = dpRevenda then
      result := VpaDNatureza.CFOPProdutoRevenda
    else
      result := VpaDNatureza.CFOPProdutoIndustrializacao;
  end;
end;

{***************************************************************************** }
function TFuncoesNotaFiscal.RCSTICMSProduto(VpaDCliente : TRBDCliente; VpaDProduto: TRBDProduto; VpaDNatureza: TRBDNaturezaOperacao): string;
begin
  result := IntToStr(VpaDProduto.NumOrigemProduto);
  if (VpaDNatureza.IndCalcularICMS) then
  begin
    if (VpaDProduto.IndSubstituicaoTributaria or (VpaDProduto.PerSubstituicaoTributaria > 0) ) and VpaDCliente.IndUFConvenioSubstituicaoTributaria and
       not VpaDCliente.IndConsumidorFinal then
    begin
      if VpaDProduto.NumDestinoProduto = dpRevenda then
        result := result +'60'
      else
        result := result +'10';
    end
    else
      if config.SimplesFederal and config.EmiteNFe then
        result :=  result+'41'
        else
        if (VpaDProduto.PerReducaoICMS <> 0) or (VpaDProduto.IndDescontoBaseICMSConfEstado) then
          result :=result +'20'
        else
          if not VpaDCliente.IndDestacarICMSNota  then
            result := result + '51'
          else
          begin
            result := result + '00';
          end;
  end
  else
  begin
    result := result +   VpaDNatureza.CodCST;
  end;
end;

{***** retorna o codigo da condicao de pagamento ***************************** }
function TFuncoesNotaFiscal.RetornaCondPagamento(CodCondPagamento: Integer): string;
begin
  AdicionaSQLAbreTabela(Tabela,
    ' select * from cadcondicoespagto ' +
    ' where I_COD_PAG = ' + IntToStr(CodCondPagamento));
  Result := Tabela.FieldByName('C_NOM_PAG').AsString;
end;

{*********** verifica se deve ou naum imprimir um cupom nau fiscal *********** }
function TFuncoesNotaFiscal.ImprimirCuponNaoFiscal(CodCondPagamento: Integer): string;
begin
  AdicionaSQLAbreTabela(Tabela,
    ' select * from cadcondicoespagto ' +
    ' where I_COD_PAG = ' + IntToStr(CodCondPagamento));
  Result := Tabela.FieldByName('C_GER_CRE').AsString;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.GravaCotacoesEstornadas(VpaSeqNotaFiscal : Integer; VpaCotacoes : TList);
var
  Vpflaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    if (VpfDCotacao.Produtos.Count = 0) and(VpfDCotacao.Servicos.Count = 0) then
    begin
      FunCotacao.ExcluiOrcamento(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento);
      ExecutaComandoSql(Aux,'Delete from MOVNOTAORCAMENTO '+
                            ' Where I_EMP_FIL = '+IntToStr(VpfDCotacao.CodEmpFil)+
                            ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNotaFiscal)+
                            ' and I_LAN_ORC = '+ IntToStr(VpfDCotacao.LanOrcamento));
    end
    else
    begin
      FunCotacao.CalculaValorTotal(VpfDCotacao);
      FunCotacao.GravaDCotacao(VpfDCotacao,nil);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.GravaDItensNota(VpaDNota : TRBDNotaFiscal):String;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  result := '';
  ExecutaComandoSql(Aux,'DELETE FROM MOVNOTASFISCAIS '+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaDNota.CodFilial)+
                        ' and I_SEQ_NOT = '+ IntToStr(VpaDNota.SeqNota));
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVNOTASFISCAIS '+
                        ' Where I_EMP_FIL = 11 and I_SEQ_NOT = 0');

  for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNota.CodFilial;
    Cadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNota.SeqNota;
    Cadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfLaco + 1;
    Cadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfDProdutoNota.SeqProduto;
    Cadastro.FieldByName('C_COD_UNI').AsString := VpfDProdutoNota.UM;
    Cadastro.FieldByName('N_QTD_PRO').AsFloat := VpfDProdutoNota.QtdProduto;
    Cadastro.FieldByName('N_VLR_PRO').AsFloat := VpfDProdutoNota.ValUnitario;
    Cadastro.FieldByName('N_PER_ICM').AsFloat := VpfDProdutoNota.PerICMS;
    Cadastro.FieldByName('N_RED_BAS').AsFloat := VpfDProdutoNota.PerReducaoUFBaseICMS;
    Cadastro.FieldByName('N_VLR_ICM').AsFloat := VpfDProdutoNota.ValICMS;
    Cadastro.FieldByName('N_BAS_ICM').AsFloat := VpfDProdutoNota.ValBaseICMS;
    Cadastro.FieldByName('N_PER_IPI').AsFloat := VpfDProdutoNota.PerIPI;
    Cadastro.FieldByName('N_TOT_PRO').AsFloat := VpfDProdutoNota.ValTotal;
    Cadastro.FieldByName('N_VLR_DES').AsFloat := VpfDProdutoNota.ValDesconto;
    Cadastro.FieldByName('N_VLR_FRE').AsFloat := VpfDProdutoNota.ValFrete;
    Cadastro.FieldByName('N_OUT_DES').AsFloat := VpfDProdutoNota.ValOutrasDespesas;
    Cadastro.FieldByName('C_COD_CST').AsString := VpfDProdutoNota.CodCST;
    Cadastro.FieldByName('C_CLA_FIS').AsString := VpfDProdutoNota.CodClassificacaoFiscal;
    Cadastro.FieldByName('I_ORD_FIS').AsInteger := VpfDProdutoNota.NumOrdemClaFiscal;
    Cadastro.FieldByName('C_COD_PRO').AsString := VpfDProdutoNota.CodProduto;
    Cadastro.FieldByName('C_DES_COR').AsString := VpfDProdutoNota.DesCor;
    Cadastro.FieldByName('N_VLR_IPI').AsFloat := VpfDProdutoNota.ValIpi;
    Cadastro.FieldByName('N_BAS_SUT').AsFloat := VpfDProdutoNota.ValBaseICMSSubstituicao;
    Cadastro.FieldByName('N_VAL_SUT').AsFloat := VpfDProdutoNota.ValICMSSubtituicao;
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    Cadastro.FieldByName('I_COD_COR').AsInteger := VpfDProdutoNota.CodCor;
    Cadastro.FieldByName('C_PRO_REF').AsString := VpfDProdutoNota.DesRefCliente;
    Cadastro.FieldByName('C_IND_CAN').AsString := 'N';
    Cadastro.FieldByName('C_ORD_COM').AsString := VpfDProdutoNota.DesOrdemCompra;
    if VpfDProdutoNota.AltProdutonaGrade <> 0 then
      Cadastro.FieldByName('N_ALT_PRO').AsFloat := VpfDProdutoNota.AltProdutonaGrade
    else
      Cadastro.FieldByName('N_ALT_PRO').clear;
    Cadastro.FieldByName('I_COD_CFO').AsInteger := VpfDProdutoNota.CodCFOP;

    if config.PermiteAlteraNomeProdutonaCotacao then
      Cadastro.FieldByName('C_NOM_PRO').AsString := VpfDProdutoNota.NomProduto;

    Cadastro.FieldByName('C_DES_ADI').AsString :=  VpfDProdutoNota.DesAdicional;

    Cadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(Cadastro);
    cadastro.post;
    result := Cadastro.AMensagemErroGravacao;;
    if Cadastro.AErronaGravacao then
      exit;
  end;
  Sistema.MarcaTabelaParaImportar('MOVNOTASFISCAIS');
  Cadastro.Close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.GravaDServicosnota(VpaDNota : TRBDNotaFiscal):String;
var
  VpfLaco : Integer;
  VpfDServico : TRBDNotaFiscalServico;
begin
  result := '';
  ExecutaComandoSql(Aux,'DELETE FROM MOVSERVICONOTA '+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaDNota.CodFilial)+
                        ' and I_SEQ_NOT = '+ IntToStr(VpaDNota.SeqNota));
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVSERVICONOTA '+
                        ' Where I_EMP_FIL = 0 and I_SEQ_NOT = 0');
  for VpfLaco := 0 to VpaDNota.Servicos.Count - 1 do
  begin
    VpfDSErvico := TRBDNotaFiscalServico(VpaDNota.Servicos.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNota.CodFilial;
    Cadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNota.SeqNota;
    Cadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfLaco+1;
    Cadastro.FieldByName('I_COD_SER').AsInteger := VpfDServico.CodServico;
    if config.PermiteAlteraNomeProdutonaCotacao then
      Cadastro.FieldByName('C_NOM_SER').AsString := VpfDServico.NomServico;
    Cadastro.FieldByName('C_DES_ADI').AsString := VpfDServico.DesAdicional;
    Cadastro.FieldByName('N_QTD_SER').AsFloat := VpfDServico.QtdServico;
    Cadastro.FieldByName('N_VLR_SER').AsFloat := VpfDServico.ValUnitario;
    Cadastro.FieldByName('N_TOT_SER').AsFloat := VpfDServico.ValTotal;
    Cadastro.FieldByName('N_PER_ISQ').AsFloat := VpfDServico.PerISSQN;
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      exit;
  end;
  Sistema.MarcaTabelaParaImportar('MOVSERVICONOTA');
  Cadastro.Close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.GravaParcelasSinalPagamento(VpaDNota: TRBDNotaFiscal): String;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaSinal;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from NOTAFISCALSINALPAGAMENTO ' +
                        ' WHERE CODFILIAL = ' +IntToStr(VpaDNota.CodFilial)+
                        ' AND SEQNOTAFISCAL = ' + IntToStr(VpaDNota.SeqNota));
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM NOTAFISCALSINALPAGAMENTO ' +
                        ' WHERE CODFILIAL = 0  AND SEQNOTAFISCAL = 0 AND CODFILIALSINAL = 0 AND LANRECEBERSINAL = 0 AND NUMPARCELASINAL = 0');
  for VpfLaco := 0 to VpaDNota.ParcelasSinal.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaSinal(VpaDNota.ParcelasSinal.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDNota.CodFilial;
    Cadastro.FieldByName('SEQNOTAFISCAL').AsInteger := VpaDNota.SeqNota;
    Cadastro.FieldByName('CODFILIALSINAL').AsInteger := VpfDParcela.CodFilial;
    Cadastro.FieldByName('LANRECEBERSINAL').AsInteger := VpfDParcela.LanReceber;
    Cadastro.FieldByName('NUMPARCELASINAL').AsInteger := VpfDParcela.NumParcela;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  cadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarDItensNota(VpaDNota : TRBDNotaFiscal);
var
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfValRevenda : Double;
begin
  AdicionaSQLAbreTabela(CadNotaFiscal,'Select MNO.I_SEQ_PRO, MNO.C_COD_PRO, MNO.N_VLR_PRO, MNO.C_NOM_PRO NOMENOTA, '+
                                  ' MNO.N_QTD_PRO, MNO.N_TOT_PRO, MNO.C_COD_UNI, MNO.I_ORD_FIS, '+
                                  ' MNO.C_DES_COR, MNO.I_SEQ_MOV, MNO.I_COD_COR, MNO.D_ULT_ALT, MNO.C_PRO_REF,'+
                                  ' MNO.C_COD_CST, MNO.N_PER_ICM, MNO.N_PER_IPI, MNO.N_VLR_IPI, MNO.N_RED_BAS, '+
                                  ' MNO.C_ORD_COM, MNO.N_ALT_PRO ALTURAPRODUTOGRADE, I_COD_CFO,'+
                                  ' MNO.C_IND_CAN, MNO.N_VLR_DES, MNO.N_VLR_ICM, MNO.N_BAS_ICM,MNO.N_VLR_FRE, '+
                                  ' MNO.N_OUT_DES, MNO.N_BAS_SUT, MNO.N_VAL_SUT, MNO.C_DES_ADI,' +
                                  ' PRO.C_NOM_PRO, PRO.N_PES_LIQ, PRO.N_PES_BRU,  PRO.I_ORI_PRO, '+
                                  ' PRO.C_COD_UNI UNIORIGINAL,PRO.N_RED_ICM, PRO.N_PER_COM, PRO.C_CLA_FIS, '+
                                  ' PRO.C_SUB_TRI, PRO.N_PER_SUT, PRO.I_DES_PRO, '+
                                  ' CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO '+
                                  ' FROM MOVNOTASFISCAIS MNO, CADPRODUTOS PRO,  '+
                                  ' CADCLASSIFICACAO CLA ' +
                                  ' Where MNO.I_EMP_FIL = '+IntToStr(VpaDNota.CodFilial)+
                                  ' AND  MNO.I_SEQ_NOT = '+IntToStr(VpaDNota.SeqNota)+
                                  ' AND PRO.I_SEQ_PRO = MNO.I_SEQ_PRO' +
                                  ' and PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' and PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' and PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' order by MNO.I_SEQ_MOV');
  CadNotaFiscal.SQL.SaveToFile('consulta.sql');
  FreeTObjectsList(VpaDNota.Produtos);
  While not CadNotaFiscal.Eof do
  begin
    VpfDProdutoNota := VpaDNota.AddProduto;
    VpfDProdutoNota.SeqProduto := CadNotaFiscal.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDProdutoNota.CodCor := CadNotaFiscal.FieldByName('I_COD_COR').AsInteger;
    VpfDProdutoNota.NumOrdemClaFiscal := CadNotaFiscal.FieldByName('I_ORD_FIS').AsInteger;
    VpfDProdutoNota.CodClassificacaoProduto := CadNotaFiscal.FieldByName('C_COD_CLA').AsString;
    VpfDProdutoNota.CodProduto := CadNotaFiscal.FieldByName('C_COD_PRO').AsString;
    VpfDProdutoNota.NumDestinoProduto := FunProdutos.RTipoDestinoProduto(CadNotaFiscal.FieldByName('I_DES_PRO').AsInteger);
    if config.PermiteAlteraNomeProdutonaCotacao and (CadNotaFiscal.FieldByName('NOMENOTA').AsString <> '') then
      VpfDProdutoNota.NomProduto := CadNotaFiscal.FieldByName('NOMENOTA').AsString
    else
      VpfDProdutoNota.NomProduto := CadNotaFiscal.FieldByName('C_NOM_PRO').AsString;
    VpfDProdutoNota.DesCor := CadNotaFiscal.FieldByName('C_DES_COR').AsString;
    VpfDProdutoNota.CodClassificacaoFiscal := CadNotaFiscal.FieldByName('C_CLA_FIS').AsString;
    VpfDProdutoNota.CodCST := CadNotaFiscal.FieldByName('C_COD_CST').AsString;
    VpfDProdutoNota.DesRefCliente := CadNotaFiscal.FieldByName('C_PRO_REF').AsString;
    VpfDProdutoNota.DesOrdemCompra := CadNotaFiscal.FieldByName('C_ORD_COM').AsString;
    VpfDProdutoNota.DesAdicional := CadNotaFiscal.FieldByName('C_DES_ADI').AsString;
    VpfDProdutoNota.UM := CadNotaFiscal.FieldByName('C_COD_UNI').AsString;
    VpfDProdutoNota.UMAnterior := CadNotaFiscal.FieldByName('C_COD_UNI').AsString;
    VpfDProdutoNota.UMOriginal := CadNotaFiscal.FieldByName('UNIORIGINAL').AsString;
    VpfDProdutoNota.AltProdutonaGrade := CadNotaFiscal.FieldByName('ALTURAPRODUTOGRADE').AsFloat;
    VpfDProdutoNota.PerICMS := CadNotaFiscal.FieldByName('N_PER_ICM').AsFloat;
    VpfDProdutoNota.PerReducaoUFBaseICMS := CadNotaFiscal.FieldByName('N_RED_BAS').AsFloat;
    VpfDProdutoNota.PerSubstituicaoTributaria := CadNotaFiscal.FieldByName('N_PER_SUT').AsFloat;
    VpfDProdutoNota.PerIPI := CadNotaFiscal.FieldByName('N_PER_IPI').AsFloat;
    VpfDProdutoNota.PerComissaoProduto := CadNotaFiscal.FieldByName('N_PER_COM').AsFloat;
    VpfDProdutoNota.PerComissaoClassificacao := CadNotaFiscal.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
    VpfDProdutoNota.PesLiquido := CadNotaFiscal.FieldByName('N_PES_LIQ').AsFloat;
    VpfDProdutoNota.PesBruto := CadNotaFiscal.FieldByName('N_PES_BRU').AsFloat;
    VpfDProdutoNota.NumOrigemProduto := CadNotaFiscal.FieldByName('I_ORI_PRO').AsInteger;
{    VpfDProdutoNota.QtdEstoque := CadNotaFiscal.FieldByName('QTDREAL').AsFloat;
    VpfDProdutoNota.QtdMinima := CadNotaFiscal.FieldByName('N_QTD_MIN').AsFloat;
    VpfDProdutoNota.QtdPedido := CadNotaFiscal.FieldByName('N_QTD_PED').AsFloat;}
    VpfDProdutoNota.QtdProduto := CadNotaFiscal.FieldByName('N_QTD_PRO').AsFloat;
    VpfDProdutoNota.ValIPI := CadNotaFiscal.FieldByName('N_VLR_IPI').AsFloat;
    VpfDProdutoNota.ValUnitario := CadNotaFiscal.FieldByName('N_VLR_PRO').AsFloat;
    VpfDProdutoNota.ValTotal := CadNotaFiscal.FieldByName('N_TOT_PRO').AsFloat;
    VpfDProdutoNota.ValDesconto := CadNotaFiscal.FieldByName('N_VLR_DES').AsFloat;
    VpfDProdutoNota.ValICMS := CadNotaFiscal.FieldByName('N_VLR_ICM').AsFloat;
    VpfDProdutoNota.ValBaseICMS := CadNotaFiscal.FieldByName('N_BAS_ICM').AsFloat;
    VpfDProdutoNota.ValBaseICMSSubstituicao := CadNotaFiscal.FieldByName('N_BAS_SUT').AsFloat;
    VpfDProdutoNota.ValICMSSubtituicao := CadNotaFiscal.FieldByName('N_VAL_SUT').AsFloat;
    VpfDProdutoNota.ValFrete := CadNotaFiscal.FieldByName('N_VLR_FRE').AsFloat;
    VpfDProdutoNota.ValOutrasDespesas := CadNotaFiscal.FieldByName('N_OUT_DES').AsFloat;
    VpfDProdutoNota.IndReducaoICMS := (CadNotaFiscal.FieldByName('N_RED_ICM').AsFloat > 0);
    VpfDProdutoNota.IndSubstituicaoTributaria := (CadNotaFiscal.FieldByName('C_SUB_TRI').AsString = 'S');
    VpfDProdutoNota.IndItemCancelado := not(CadNotaFiscal.FieldByName('C_IND_CAN').AsString = 'N');
    VpfDProdutoNota.CodCFOP := CadNotaFiscal.FieldByName('I_COD_CFO').AsInteger;
    VpfDProdutoNota.IndBaixaEstoque := false;
    FunProdutos.CarValVendaeRevendaProduto(sistema.RTabelaPrecoFilial(VpaDNota.codfilial),VpfDProdutoNota.SeqProduto,VpfDProdutoNota.CodCor,
                                           0,VpaDNota.CodCliente,VpfDProdutoNota.ValUnitarioOriginal,VpfValRevenda,VpfDProdutoNota.ValTabelaPreco,VpfDProdutoNota.PerDescontoMaximo);

    CadNotaFiscal.Next;
  end;
  CadNotafiscal.Close;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarDServicoNota(VpaDNota : TRBDNotaFiscal);
Var
  VpfDServico : TRBDNotaFiscalServico;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.I_COD_SER, MOV.C_NOM_SER SERVICONOTA,MOV.C_DES_ADI, '+
                               ' MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_TOT_SER, MOV.N_PER_ISQ, '+
                               ' SER.C_NOM_SER, CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, '+
                               ' SER.I_COD_FIS '+
                               ' from MOVSERVICONOTA MOV, CADSERVICO SER, CADCLASSIFICACAO CLA '+
                               ' Where MOV.I_EMP_FIL = '+ IntToStr(VpaDNota.CodFilial)+
                               ' AND MOV.I_SEQ_NOT = '+ IntToStr(VpaDNota.SeqNota)+
                               ' AND SER.I_COD_EMP = CLA.I_COD_EMP '+
                               ' AND SER.C_COD_CLA = CLA.C_COD_CLA '+
                               ' AND SER.C_TIP_CLA = CLA.C_TIP_CLA '+
                               ' AND MOV.I_COD_SER = SER.I_COD_SER' );
  While not Tabela.Eof do
  begin
    VpfDServico := VpaDNota.AddServico;
    VpfDServico.CodServico := Tabela.FieldByName('I_COD_SER').AsInteger;
    if config.PermiteAlteraNomeProdutonaCotacao and (Tabela.FieldByName('SERVICONOTA').AsString <> '') then
      VpfDServico.NomServico := Tabela.FieldByName('SERVICONOTA').AsString
    else
      VpfDServico.NomServico := Tabela.FieldByName('C_NOM_SER').AsString;
    VpfDServico.DesAdicional:= Tabela.FieldByName('C_DES_ADI').AsString;
    VpfDServico.QtdServico := Tabela.FieldByName('N_QTD_SER').AsFloat;
    VpfDServico.ValUnitario := Tabela.FieldByName('N_VLR_SER').AsFloat;
    VpfDServico.ValTotal := Tabela.FieldByName('N_TOT_SER').AsFloat;
    VpfDServico.PerComissaoClassificacao := Tabela.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
    VpfDServico.CodClassificacao := Tabela.FieldByname('C_COD_CLA').AsString;
    VpfDServico.CodFiscal := Tabela.FieldByName('I_COD_FIS').AsInteger;
    VpfDServico.PerISSQN := Tabela.FieldByName('N_PER_ISQ').AsFloat;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarCotacoesAEstorar(VpaCotacoes : TList;VpaCodFilial,VpaSeqNotaFiscal : Integer);
var
  VpfDCotacao : TRBDOrcamento;
begin
  AdicionaSQLAbreTabela(CadNotaFiscal,'Select * from MOVNOTAORCAMENTO '+
                                      ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                      ' and I_SEQ_NOT = '+IntToStr(VpaSeqNotaFiscal));
  While not CadNotaFiscal.Eof do
  begin
    VpfDCotacao := TRBDOrcamento.cria;
    VpaCotacoes.add(VpfDCotacao);
    VpfDCotacao.CodEmpFil := CadNotaFiscal.FieldByName('I_FIL_ORC').AsInteger;;
    VpfDCotacao.LanOrcamento := CadNotaFiscal.FieldByName('I_LAN_ORC').AsInteger;
    FunCotacao.CarDOrcamento(VpfDCotacao);
    CadNotaFiscal.Next;
  end;
end;

{################### manutencao da nota ###################################### }

procedure TFuncoesNotaFiscal.CancelaNota(VpaDNotaFiscal : TRBDNotaFiscal);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADNOTAFISCAIS ' +
                            ' WHERE I_SEQ_NOT = ' + IntToStr(VpaDNotaFiscal.SeqNota) +
                            ' and I_EMP_FIL = ' + IntToStr(VpaDNotaFiscal.CodFilial));
  Cadastro.Edit;
  Cadastro.FieldByName('C_NOT_CAN').AsString := 'S';
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := now;
  Cadastro.FieldByName('C_PRC_NFE').AsString := VpaDNotaFiscal.NumProtocoloCancelamentoNFE;
  Cadastro.FieldByName('C_MOC_NFE').AsString := VpaDNotaFiscal.DesMotivoCancelamentoNFE;
  Cadastro.FieldByName('I_USU_CAN').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('D_DAT_CAN').AsDateTime := now;
  Cadastro.Post;
  Cadastro.Close;
end;

{*** verifica se existe um numero de nota maior que o passado como parametro **}
function TFuncoesNotaFiscal.VerificaSeUltimaNota(VpaCodFilial, NroNota : Integer; Serie : String) : Boolean;
begin
  AdicionaSQLAbreTabela(tabela, ' Select * from cadnotafiscais  ' +
                                ' where i_emp_fil = ' + IntTostr(VpaCodFilial) +
                                ' and i_nro_not > ' + IntTostr(NroNota) +
                                ' and c_ser_not = ''' + serie + '''' +
                                ' and '+SQLTextoIsNull('C_FLA_ECF','''N''')+' = ''N''' );
  result := Tabela.Eof;
  FechaTabela(tabela);
  if (varia.CNPJFilial = CNPJ_INFORMARE) or
     (varia.CNPJFilial = CNPJ_INFORWAP) or
     (varia.CNPJFilial = CNPJ_INFORMANET) then
    result := true;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.VerificaItemNotaDuplicado(VpaDNota : TRBDNotaFiscal):Boolean;
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDProdutoNota, VpfDProdutoNotaInterno : TRBDNotaFiscalProduto;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDNota.Produtos.Count - 2 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpflacoExterno]);
    if VpfDProdutoNota.AltProdutonaGrade = 0 then
    begin
      for VpfLacoInterno := VpfLacoExterno + 1 to VpaDNota.Produtos.Count - 1 do
      begin
         VpfDProdutoNotaInterno := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLacoInterno]);
        if (VpfDProdutoNota.SeqProduto = VpfDProdutoNotaInterno.SeqProduto) and
           (VpfDProdutoNota.CodCor = VpfDProdutoNotaInterno.CodCor) and
           (VpfDProdutoNota.DesOrdemCompra = VpfDProdutoNotaInterno.DesOrdemCompra) and
           (VpfDProdutoNota.DesRefCliente = VpfDProdutoNotaInterno.DesRefCliente) and
           (Config.NaNotaFazerMediaValProdutosDuplicados or (VpfDProdutoNota.ValUnitario = VpfDProdutoNotaInterno.ValUnitario)) then
        begin
          VpfDProdutoNotaInterno.QtdProduto := VpfDProdutoNotaInterno.QtdProduto + (VpfDProdutoNota.QtdProduto * ConvUnidade.Indice(VpfDProdutoNota.UM,VpfDProdutoNotaInterno.UM,VpfDProdutoNotaInterno.CodProduto,VpaDNota.CodFilial));
          if config.NaNotaFazerMediaValProdutosDuplicados then
            VpfDProdutoNotaInterno.ValUnitario := (VpfDProdutoNotaInterno.ValTotal + (VpfDProdutoNota.ValTotal *ConvUnidade.Indice(VpfDProdutoNota.UM,VpfDProdutoNotaInterno.UM,VpfDProdutoNotaInterno.CodProduto,VpaDNota.CodFilial))) / VpfDProdutoNotaInterno.QtdProduto;
          VpfDProdutoNotaInterno.ValTotal := VpfDProdutoNotaInterno.ValUnitario * VpfDProdutoNotaInterno.QtdProduto;
          VpfDProdutoNota.ValIPI := ArredondaDecimais((VpfDProdutoNota.ValTotal * VpfDProdutoNota.PerIPI)/100,2);
          result := true;
          VpfDProdutoNota.Free;
          VpaDNota.Produtos.Delete(VpfLacoExterno);
          exit;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.VerificaServicoNotaDuplicado(VpaDNota : TRBDNotaFiscal):Boolean;
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDServicoNota, VpfDServicoNotaInterno : TRBDNotaFiscalServico;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDNota.Servicos.Count - 2 do
  begin
    VpfDServicoNota := TRBDNotaFiscalServico(VpaDNota.Servicos.Items[VpflacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDNota.Servicos.Count - 1 do
    begin
       VpfDServicoNotaInterno := TRBDNotaFiscalServico(VpaDNota.Servicos.Items[VpfLacoInterno]);
      if (VpfDServicoNota.CodServico = VpfDServicoNotaInterno.CodServico) then
      begin
        VpfDServicoNotaInterno.QtdServico := VpfDServicoNotaInterno.QtdServico + VpfDServicoNota.QtdServico;
        VpfDServicoNotaInterno.ValTotal := VpfDServicoNotaInterno.ValTotal +  VpfDServicoNota.ValTotal;
        VpfDServicoNotaInterno.ValUnitario := VpfDServicoNotaInterno.ValTotal / VpfDServicoNotaInterno.QtdServico;
        result := true;
        VpfDServicoNota.Free;
        VpaDNota.Servicos.Delete(VpfLacoExterno);
        exit;
      end;
    end;

  end;
end;

{************* deleta um nota fiscal *************************************** }
procedure TFuncoesNotaFiscal.DeletaNota(VpaCodFilial, Sequencial: Integer );
begin
  sistema.GravaLogExclusao('CADNOTAFISCAIS','Select * from CADNOTAFISCAIS '+
                          ' Where I_Emp_Fil = ' + InttoStr(VpaCodFilial) +
                          ' and I_SEQ_NOT = ' + IntToStr(Sequencial));
  ExecutaComandoSql(tabela, ' DELETE MOVNOTASFISCAIS WHERE I_SEQ_NOT = ' + IntToStr(Sequencial) +
                            ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
  ExecutaComandoSql(tabela,' DELETE CADNOTAFISCAIS WHERE I_SEQ_NOT = ' + IntToStr(Sequencial) +
                            ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
end;

{************* deleta os servico e estoque de uma nota fiscal *************** }
procedure TFuncoesNotaFiscal.DeletaServicoEstoqueNota( VpaCodFilial,Sequencial: Integer );
begin
  LimpaSQLTabela(Tabela);
  ExecutaComandoSql(tabela, ' DELETE MOVESTOQUEPRODUTOS WHERE I_NOT_SAI = ' + IntToStr(Sequencial) +
                            ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial));
  ExecutaComandoSql(Tabela,' DELETE MOVSERVICONOTA     WHERE I_SEQ_NOT = ' + IntToStr(Sequencial) +
                            ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial) );
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.DeletaOrcamentoNota(VpaCodFilial,VpaSeqNota : Integer);
begin
  ExecutaComandoSql(Tabela,'Delete from MOVNOTAORCAMENTO '+
                           ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                           ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNota));
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.DiminuiQtdProdutosCotacao(VpaCotacoes : TList;VpaCodFilial,VpaSequencial : Integer);
var
  VpfLacoCotacao, VpfLacoProduto : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDCotacaoProduto : TRBDOrcProduto;
  VpfQtdProduto : Double;
  VpfUnidadeAtual : String;
begin
  AdicionaSQLAbreTabela(CadNotaFiscal,'Select * from  MOVNOTASFISCAIS '+
                                      ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                                      ' and I_SEQ_NOT = '+IntToStr(VpaSequencial)+
                                      ' order by I_SEQ_MOV');
  While not CadNotafiscal.eof do
  begin
    VpfQtdProduto := CadNotaFiscal.FieldByName('N_QTD_PRO').AsFloat;
    VpfUnidadeAtual := CadNotaFiscal.FieldByName('C_COD_UNI').AsString;
    for VpfLacoCotacao := 0 to VpaCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoCotacao]);
      for VpfLacoProduto := VpfDCotacao.Produtos.Count - 1 downto 0 do
      begin
        VpfDCotacaoProduto := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
        if (VpfDCotacaoProduto.SeqProduto = CadNotaFiscal.FieldByName('I_SEQ_PRO').AsInteger) then
        begin
          if ((config.EstoquePorCor) and (VpfDCotacaoProduto.CodCor <> CadNotaFiscal.FieldByName('I_COD_COR').AsInteger)) or
             (VpfDCotacaoProduto.QtdBaixadoNota = 0) then
            continue;

          VpfQtdProduto := FunProdutos.CalculaQdadePadrao(VpfUnidadeAtual,VpfDCotacaoProduto.UM,VpfQtdProduto,CadNotaFiscal.FieldByName('I_SEQ_PRO').AsString);
          VpfUnidadeAtual := VpfDCotacaoProduto.UM;
          if (VpfDCotacaoProduto.QtdBaixadoNota - VpfQtdProduto) <= 0 then
          begin
            VpfQtdProduto := VpfQtdProduto - VpfDCotacaoProduto.QtdBaixadoNota;
            VpfDCotacaoProduto.QtdBaixadoNota := 0;
            if config.ExcluirCotacaoQuandoNFCancelada then
            begin
              VpfDCotacao.Produtos.Delete(VpfLacoProduto);
              VpfDCotacaoProduto.free;
            end;
          end
          else
          begin
            VpfDCotacaoProduto.QtdBaixadoNota := VpfDCotacaoProduto.QtdBaixadoNota - VpfQtdProduto;
            VpfDCotacaoProduto.ValTotal := VpfDCotacaoProduto.QtdProduto * VpfDCotacaoProduto.ValUnitario;
            VpfQtdProduto := 0;
          end;
          if VpfQtdProduto <= 0 then
            break;
        end;
      end;
      if VpfQtdProduto <= 0 then
        break;
    end;

    CadNotaFiscal.Next;
  end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.Devolucao(VpaCodFilial, VpaSeqNota : Integer);
begin
  ExecutaComandoSql(tabela, ' UPDATE CADNOTAFISCAIS SET C_NOT_DEV = ''S'',' +
                            ' C_Not_Can = ''S'''+
                            ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE) +
                            ' WHERE I_SEQ_NOT = ' + IntToStr(VpaSeqNota) +
                            ' and I_EMP_FIL = ' + IntToStr(VpaCodFilial) );
end;

(******************************************************************************)
function TFuncoesNotaFiscal.RSeqNota(VpaNumNota, VpaCodFilial: Integer; VpaNumSerie: String): integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_NOT from CADNOTAFISCAIS '+
                            ' Where I_NRO_NOT = '+IntToStr(VpaNumNota)+
                            ' AND C_SER_NOT = ''' + VpaNumSerie + '''' +
                            ' AND I_EMP_FIL = ' + IntToStr(VpaCodFilial));
  result := Aux.FieldByName('I_SEQ_NOT').AsInteger;
  Aux.Close;
end;

(******************************************************************************)
function TFuncoesNotaFiscal.RSeqNotaDisponivel(VpaCodFilial : Integer) : Integer;
begin
  if varia.TipoBancoDados = bdMatrizSemRepresentante then
  begin
    AdicionaSQLAbreTabela(Aux,'Select MAX(I_SEQ_NOT) ULTIMO from CADNOTAFISCAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
    result := Aux.FieldByname('ULTIMO').AsInteger + 1;
    Aux.close;
  end
  else
  begin
    repeat
      AdicionaSQLAbreTabela(Aux,'Select SEQNOTA FROM NUMERONOTA '+
                                ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' order by SEQNOTA');
      result := Aux.FieldByName('SEQNOTA').AsInteger;
      if result = 0 then
        aviso('FINAL SEQUENCIAL NOTA!!!'#13'Não existem mais sequenciais de notas disponiveis, é necessário gerar mais numeros.');
      Aux.Close;
      ExecutaComandoSql(Aux,'Delete from NUMERONOTA ' +
                            ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and SEQNOTA = '+IntToStr(result));
    until (not ExisteSequencialNota(VpaCodFilial,result));
  end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.GeraNSU(VpaDNota : TRBDNotaFiscal);
begin
  AdicionaSQLAbreTabela(Aux,'Select I_NRO_NSU from CADFILIAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaDNota.CodFilial));
  VpaDNota.NumNSU := Aux.FieldByname('I_NRO_NSU').AsInteger + 1;
  VpaDNota.DatNSU := now;
  Aux.close;
  ExecutaComandoSql(Aux,'Update CADFILIAIS SET I_NRO_NSU = '+IntToStr(VpaDNota.NumNSU)+
                        ' Where I_EMP_FIL = '+IntToStr(VpaDNota.CodFilial));
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RValorComissao(VpaDNotaFiscal : TRBDNotaFiscal;VpaTipComissao : Integer;VpaPerComissao, VpaPerComissaoPreposto : Double):Double;
var
  VpfLaco : Integer;
  VpfDNotaProduto : TRBDNotaFiscalProduto;
  VpfDNotaServico : TRBDNotaFiscalServico;
  VpfCodClassificacao : String;
  VpfPerComissaoVendedor : Double;
begin
  result := 0;
  VpaDNotaFiscal.ValBaseComissao := 0;
  if VpaTipComissao = 0 then //comissao direta;
  begin
    case Varia.TipoValorComissao of
      vcTotalNota :  result := (VpaDNotaFiscal.ValTotal * (VpaPerComissao - VpaPerComissaoPreposto))/100;
      vcTotalProdutos : result := (VpaDNotaFiscal.ValTotalProdutos * (VpaPerComissao - VpaPerComissaoPreposto))/100;
    end;
  end
  else
  begin
    VpfCodClassificacao := '';
    for VpfLaco := 0 to VpaDNotaFiscal.Produtos.Count - 1 do
    begin
      VpfDNotaProduto := TRBDNotaFiscalProduto(VpaDNotaFiscal.Produtos.Items[VpfLaco]);
      VpaDNotaFiscal.ValBaseComissao := VpaDNotaFiscal.ValBaseComissao + VpfDNotaProduto.ValTotal;
      if VpfDNotaProduto.PerComissaoProduto <> 0 then
      begin
        Result := result + ((VpfDNotaProduto.ValTotal * (VpfDNotaProduto.PerComissaoProduto-VpaPerComissaoPreposto))/100);
      end
      else
      begin
        if VpfCodClassificacao <> VpfDNotaProduto.CodClassificacaoProduto then
        begin
          VpfCodClassificacao := VpfDNotaProduto.CodClassificacaoProduto;
          VpfPerComissaoVendedor := FunVendedor.RPerComissaoVendedorClassificacao(varia.CodigoEmpresa,VpaDNotaFiscal.CodVendedor,VpfDNotaProduto.CodClassificacaoProduto,'P');
        end;
        if VpfPerComissaoVendedor <> 0 then
          Result := result + ((VpfDNotaProduto.ValTotal * (VpfPerComissaoVendedor-VpaPerComissaoPreposto))/100)
        else
          Result := result + ((VpfDNotaProduto.ValTotal * (VpfDNotaProduto.PerComissaoClassificacao-VpaPerComissaoPreposto))/100);
      end;
    end;
    VpfCodClassificacao := '';
    For VpfLaco := 0 to VpaDNotaFiscal.Servicos.Count - 1 do
    begin
      VpfDNotaServico := TRBDNotaFiscalServico(VpaDNotaFiscal.Servicos.Items[VpfLaco]);
      VpaDNotaFiscal.ValBaseComissao := VpaDNotaFiscal.ValBaseComissao + VpfDNotaServico.ValTotal;
      if VpfCodClassificacao <> VpfDNotaServico.CodClassificacao then
      begin
        VpfCodClassificacao := VpfDNotaServico.CodClassificacao;
        VpfPerComissaoVendedor := FunVendedor.RPerComissaoVendedorClassificacao(varia.CodigoEmpresa,VpaDNotaFiscal.CodVendedor,VpfDNotaServico.CodClassificacao,'S');
      end;
      if VpfPerComissaoVendedor <> 0 then
        Result := result + ((VpfDNotaServico.ValTotal *(VpfPerComissaoVendedor - VpaPerComissaoPreposto))/100)
      else
        Result := result + ((VpfDNotaServico.ValTotal * (VpfDNotaServico.PerComissaoClassificacao-VpaPerComissaoPreposto))/100);
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarValSinalPagoCotacao(VpaDNotaFiscal : TRBDNotaFiscal; VpaCotacoes: TList);
var
  VpfDCotacao : TRBDOrcamento;
  VpfLaco : Integer;
  VpfDParcelaSinal : TRBDParcelaSinal;
begin
  VpaDNotaFiscal.ValSinalPagamento :=0;
  if VpaCotacoes <> nil then
  begin
    FreeTObjectsList(VpaDNotaFiscal.ParcelasSinal);
    for VpfLaco := 0 to VpaCotacoes.Count -1 do
    begin
      VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
      AdicionaSQLAbreTabela(Tabela,'Select MOV.N_VLR_PAG, MOV.N_SIN_BAI, MOV.D_DAT_PAG, '+
                                   ' MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR '+
                                   ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD  ' +
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                                   ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                                   ' AND CAD.I_EMP_FIL = ' +IntToStr(VpfDCotacao.CodEmpFil)+
                                   ' AND CAD.I_LAN_ORC = ' +IntToStr(VpfDCotacao.LanOrcamento)+
                                   ' AND CAD.C_IND_SIN = ''S''');
      while not Tabela.Eof do
      begin
        if Tabela.FieldByName('N_VLR_PAG').AsFloat > 0 then
        begin
          VpfDParcelaSinal := VpaDNotaFiscal.AddParcelaSinal;
          VpfDParcelaSinal.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
          VpfDParcelaSinal.LanReceber := Tabela.FieldByName('I_LAN_REC').AsInteger;
          VpfDParcelaSinal.NumParcela := Tabela.FieldByName('I_NRO_PAR').AsInteger;
          VpaDNotaFiscal.ValSinalPagamento := VpaDNotaFiscal.ValSinalPagamento +(Tabela.FieldByName('N_VLR_PAG').AsFloat - Tabela.FieldByName('N_SIN_BAI').AsFloat) ;
          VpaDNotaFiscal.DatPagamentoSinal := Tabela.FieldByName('D_DAT_PAG').AsDateTime;
        end;
        Tabela.Next;
      end;
      Tabela.Close;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RValAproveitamentoCreditoICMS(VpaDCliente: TRBDCliente; VpaDNota: TRBDNotaFiscal): double;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfValBaseICMS : Double;
begin
  result := 0;
  VpfValBaseICMS := 0;
  for vpflaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[vpfLaco]);
    if (VpfDProdutoNota.CodCFOP = 5101) or
       (VpfDProdutoNota.CodCFOP = 6101) or
       (VpfDProdutoNota.CodCFOP = 5102) or
       (VpfDProdutoNota.CodCFOP = 6102)then
      VpfValBaseICMS := VpfValBaseICMS + VpfDProdutoNota.ValTotal;
  end;
  result := (VpfValBaseICMS * varia.PerCreditoICMSSimples)/100
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RValNotasClientePeriodo(VpaDatInicio,VpaDatFim : TDateTime;VpaCodCliente : Integer):Double;
begin
  AdicionaSQLAbreTabela(Tabela,'Select SUM(N_TOT_NOT) TOTAL from CADNOTAFISCAIS '+
                               ' Where I_COD_CLI = '+IntToStr(VpaCodCliente)+
                               ' AND C_NOT_CAN = ''N'''+
                               ' AND C_FIN_GER = ''S'''+
                               SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  result := Tabela.FieldByName('TOTAL').AsFloat;
  Tabela.close;
end;

{************** exclui o contas a receber ********************************** }
function TFuncoesNotaFiscal.ExcluiContasaReceber(VpaCodFilial, VpaSeqNota : Integer; FazerVeriricacoes : Boolean ) : Boolean;
var
  VpfResultado : String;
begin
  result := true;
  if FunContasAReceber.LocalizaNotaFiscal(Tabela, VpaCodFilial, VpaSeqNota) then
  begin
    if Tabela.FieldByName('I_LAN_ORC').AsInteger = 0 then // se estiver preenchido o I_LAN_ORC é porque o financeiro foi gerado pela cotaçào, e que a nota nao pode excluir o financeiro;
     VpfResultado := FunContasAReceber.ExcluiConta(Tabela.FieldByName('I_EMP_FIL').AsInteger, Tabela.FieldByName('I_LAN_REC').AsInteger, false, FazerVeriricacoes)
    else
      FunCotacao.cancelaFinanceiroNota(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_LAN_ORC').AsInteger);
  end;
  Tabela.close;
  if VpfResultado <> '' then
  begin
    aviso(VpfResultado);
    Result := false;
  end;
end;

{************** estorna o estoque dos produtos ****************************** }
function TFuncoesNotaFiscal.EstornaEstoque(VpaCodFilial, VpaSeqNota : Integer ): String;
var
  VpfDMovimento : TRBDMovEstoque;
begin
  result := '';
  FunProdutos.LocalizaNotaSaidaEstoque(tabela,VpaCodFilial,VpaSeqNota);
  while not tabela.Eof do
  begin
    VpfDMovimento := TRBDMovEstoque.cria;
    FunProdutos.CarDMovimentoEstoque(Tabela,VpfDMovimento);
    result := FunProdutos.EstornaEstoque(VpfDMovimento);
    VpfDMovimento.free;
    if result <> '' then
      exit;
    tabela.Next;
  end;
  FechaTabela(tabela);
  if result = '' then
    result := EstornaEstoqueRomaneio(VpaCodFilial,VpaSeqNota);
end;

{******************************************************************************}
function TFuncoesNotaFiscal.EstornaEstoqueRomaneio(VpaCodFilial,VpaSeqNota : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Tabela,'Select EMPFIL,SEQROM FROM METROFATURADOITEM'+
                               ' Where FILNOT = '+IntToStr(VpaCodFilial)+
                               ' and SEQNOT = '+IntToStr(VpaSeqNota));
  While not Tabela.eof do
  begin
    result := FunOrdemProducao.BaixaEstoqueRomaneio(Tabela.FieldByName('EMPFIL').AsInteger,Tabela.FieldByName('SEQROM').AsInteger,true);
    Tabela.next;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.EstornaEstoqueFiscal(VpaDNota : TRBDNotaFiscal):String;
var
  VpfLaco : Integer;
  VpfDItemNota : TRBDNotaFiscalProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    FunProdutos.BaixaEstoqueFiscal(VpaDNota.CodFilial,VpfDItemNota.SeqProduto,VpfDItemNota.CodCor,0,VpfDItemNota.QtdProduto,VpfDItemNota.UM,
                                   VpfDItemNota.UMOriginal,'E');
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VpaDCliente : TRBDCliente; VpaDNota: TRBDNotaFiscal): Boolean;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  result := false;
  for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[Vpflaco]);
    if (VpaDCliente.IndUFConvenioSubstituicaoTributaria) then
    begin
      if (VpfDProdutoNota.PerSubstituicaoTributaria = 0) and (VpfDProdutoNota.NumDestinoProduto =dpProdutoAcabado) then
        Result := true;
    end
    else
      if (VpfDProdutoNota.NumDestinoProduto =dpProdutoAcabado) then
        result := true;
    if result then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VpaDCliente: TRBDCliente;VpaDNota: TRBDNotaFiscal): Boolean;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  result := false;
  for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[Vpflaco]);
    if (VpaDCliente.IndUFConvenioSubstituicaoTributaria) then
    begin
      if (VpfDProdutoNota.PerSubstituicaoTributaria = 0) and
         not(VpfDProdutoNota.IndSubstituicaoTributaria)  then
        Result := true;
    end
    else
      if (VpfDProdutoNota.NumDestinoProduto =dpRevenda) then
        result := true;
    if result then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.PossuiProdutosRevendaTributacaoICMSSubstituto(VpaDCliente: TRBDCliente; VpaDNota: TRBDNotaFiscal): Boolean;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  result := false;
  if (VpaDCliente.IndUFConvenioSubstituicaoTributaria) then
  begin
    for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
    begin
      VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[Vpflaco]);
      if ((VpfDProdutoNota.PerSubstituicaoTributaria > 0) OR (VpfDProdutoNota.IndSubstituicaoTributaria)) and (VpfDProdutoNota.NumDestinoProduto = dpRevenda) then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VpaDCliente: TRBDCliente;  VpaDNota: TRBDNotaFiscal): Boolean;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  result := false;
  if (VpaDCliente.IndUFConvenioSubstituicaoTributaria) then
  begin
    for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
    begin
      VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[Vpflaco]);
      if (VpfDProdutoNota.PerSubstituicaoTributaria > 0) and (VpfDProdutoNota.NumDestinoProduto = dpProdutoAcabado) then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.PossuiRomaneio(VpaCodFilial, VpaSeqNota : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select SEQROM from ROMANEIOCORPO '+
                            ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                            ' and SEQNOT = ' +IntToStr(VpaSeqNota));
  result := Aux.FieldByName('SEQROM').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ProdutoTributado(VpaDProdutoNota: TRBDNotaFiscalProduto): boolean;
begin
  result := FunProdutos.ProdutoTributado(VpaDProdutoNota.CodCST);
end;

{******************************************************************************}
function TFuncoesNotaFiscal.EstonaSinalPagamento(VpaDNota: TRBDNotaFiscal): string;
begin
  if VpaDNota.ValSinalPagamento > 0 then
  begin
    AdicionaSQLAbreTabela(Tabela,'select * '+
                                 ' from NOTAFISCALSINALPAGAMENTO SIN'+
                                 ' Where SEQNOTAFISCAL =  '+IntToStr(VpaDNota.SeqNota)+
                                 ' AND CODFILIAL = '+IntToStr(VpaDNota.CodFilial));
    while not Tabela.Eof do
    begin
      AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER ' +
                                     ' Where I_EMP_FIL = ' +Tabela.FieldByName('CODFILIALSINAL').AsString+
                                     ' and I_LAN_REC = ' +Tabela.FieldByName('LANRECEBERSINAL').AsString+
                                     ' and I_NRO_PAR = '+Tabela.FieldByName('NUMPARCELASINAL').AsString);
      Cadastro.Edit;
      if VpaDNota.ValSinalPagamento <= Cadastro.FieldByName('N_SIN_BAI').AsFloat  then
      begin
        Cadastro.FieldByName('N_SIN_BAI').AsFloat := Cadastro.FieldByName('N_SIN_BAI').AsFloat - VpaDNota.ValSinalPagamento;
        VpaDNota.ValSinalPagamento := 0;
      end
      else
      begin
        VpaDNota.ValSinalPagamento := VpaDNota.ValSinalPagamento - Cadastro.FieldByName('N_SIN_BAI').AsFloat;
        Cadastro.FieldByName('N_SIN_BAI').AsFloat := 0;
      end;
      Cadastro.Post;
      result := Cadastro.AMensagemErroGravacao;
      if (Cadastro.AErronaGravacao) or (VpaDNota.ValSinalPagamento <= 0) then
        Break;
      Tabela.Delete;
    end;
    Tabela.Close;
  end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.EstornaCotacao(VpaCodFilial, VpaSequencial : Integer);
var
  VpfCotacoes : TList;
  VpfSeqRomaneio : Integer;
begin
  VpfSeqRomaneio := PossuiRomaneio(VpaCodFilial,VpaSequencial);
  if  VpfSeqRomaneio <> 0 then
  begin
    FunOrdemProducao.ExtornaRomaneioGenerico(VpaCodFilial,VpfSeqRomaneio);
  end
  else
  begin
    if config.CancelarNotaCancelarBaixaCotacao then
    begin
      VpfCotacoes := TList.Create;

      CarCotacoesAEstorar(VpfCotacoes,VpaCodFilial,VpaSequencial);
      DiminuiQtdProdutosCotacao(VpfCotacoes,VpaCodFilial, VpaSequencial);
      GravaCotacoesEstornadas(VpaSequencial,VpfCotacoes);

      FreeTObjectsList(VpfCotacoes);
      VpfCotacoes.free;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.EstornaNotaFiscal(VpaDNota : TRBDNotaFiscal;VpaEstornaCotacao : Boolean) : string;
begin
  result := '';
  if not VpaDNota.IndNotaCancelada then
  begin
    result := EstonaSinalPagamento(VpaDNota);
    if result = '' then
    begin
      if not ExcluiContasaReceber(VpaDNota.CodFilial,VpaDNota.SeqNota, true) then  // exclui contas a receber
        result := 'ERRO NA EXCLUSÃO DO CONTAS A RECEBER!!!'#13'Não foi possível excluir o contas a receber';
      if result = '' then
      begin
        EstornaEstoque(VpaDNota.CodFilial,VpaDNota.SeqNota);
        if VpaDNota.CodNatureza <> varia.NaturezaNotaFiscalCupom then
          EstornaEstoqueFiscal(VpaDNota);
        if VpaEstornaCotacao then
          EstornaCotacao(VpaDNota.CodFilial,VpaDNota.SeqNota);
        ExecutaComandoSql(Aux,'UPDATE ROMANEIOORCAMENTO ' +
                              ' SET CODFILIALNOTA = NULL, ' +
                              ' NUMNOTA = NULL, ' +
                              ' SEQNOTA = NULL ' +
                              ' Where CODFILIALNOTA = '+IntToStr( VpaDNota.CodFilial)+
                              ' AND SEQNOTA = ' +IntToStr(VpaDNota.SeqNota));
      end;
    end;
  end;
end;

{************* exclui nota fiscal ******************************************** }
function TFuncoesNotaFiscal.ExcluiNotaFiscal( VpaDNotaFiscal : TRBDNotaFiscal ):string;
begin
  if VerificaSeUltimaNota(VpaDNotaFiscal.CodFilial,  VpaDNotaFiscal.NumNota, VpaDNotaFiscal.DesSerie ) then
  begin
    result := EstornaNotaFiscal(VpaDNotaFiscal,true);
    if result = '' then
    begin
      DeletaServicoEstoqueNota(VpaDNotaFiscal.CodFilial,VpaDNotaFiscal.SeqNota);
      DeletaOrcamentoNota(VpaDNotaFiscal.CodFilial, VpaDNotaFiscal.SeqNota);
      DeletaNota(VpaDNotaFiscal.CodFilial, VpaDNotaFiscal.SeqNota);
    end;
  end
  else
    Result := CT_NaoUltimoNumero;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.ExcluiParcelasSinalPagamentoEmAberto(VpaCotacoes: TList): string;
var
  VpfDCotacao : TRBDOrcamento;
  VpfLaco : Integer;
begin
  result := '';
  if VpaCotacoes <> nil then
  begin
    for VpfLaco := 0 to VpaCotacoes.Count -1 do
    begin
      VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
      AdicionaSQLAbreTabela(Tabela,'Select MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR '+
                                   ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD  ' +
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                                   ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                                   ' AND CAD.I_EMP_FIL = ' +IntToStr(VpfDCotacao.CodEmpFil)+
                                   ' AND CAD.I_LAN_ORC = ' +IntToStr(VpfDCotacao.LanOrcamento)+
                                   ' AND CAD.C_IND_SIN = ''S'''+
                                   ' AND MOV.N_VLR_PAG IS NULL');
      while not Tabela.Eof do
      begin
        result := FunContasAReceber.ExcluiTitulo(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_LAN_REC').AsInteger,Tabela.FieldByName('I_NRO_PAR').AsInteger);
        if result <> '' then
          break;
        Tabela.Next;
      end;
      Tabela.Close;
    end;
  end;
end;

{************* exclui nota fiscal ******************************************** }
procedure TFuncoesNotaFiscal.CancelaCupomFiscal(VpaCodFilial, VpaSeqNota : Integer );
var
  ExcluirOk : boolean;
  VpfDNotaFiscal : TRBDNotaFiscal;
begin
  VpfDNotaFiscal := TRBDNotaFiscal.cria;
  FunNotaFiscal.CarDNotaFiscal(VpfDNotaFiscal,VpaCodFilial,VpaSeqNota);
  ExcluiContasaReceber(VpaCodFilial, VpaSeqNota, false);  // exclui contas a receber
  EstornaEstoque(VpaCodFilial, VpaSeqNota);
  CancelaNota(VpfDNotaFiscal);
  VpfDNotaFiscal.free;
end;

{************* cancela nota fiscal ******************************************** }
function TFuncoesNotaFiscal.CancelaNotaFiscal(VpaDNota : TRBDNotaFiscal;VpaEstornarCotacao, VpaCancelarSefaz : Boolean ) : String;
begin
  result := '';

  if (Config.EmiteNFe) and (VpaDNota.NumProtocoloNFE <> '' ) and VpaCancelarSefaz then
  begin

    if DiasPorPeriodo(VpaDNota.DatEmissao,Date) > 7  then
      result := 'NOTA FISCAL EMITIDA A MAIS DE 7 DIAS!!!'#13'Não é permitido cancelar uma nota fiscal emitida a mais de 7 dias.';
    if result = '' then
    begin
      if not Entrada('Motivo Cancelamento','Motivo Cancelamento',VpaDNota.DesMotivoCancelamentoNFE,false,clInfoBk,clGray) then
        result := 'NÃO FOI POSSÍVEL CANCELAR A NOTA FISCAL!!!'#13'Operação cancelada pelo usuário';
      if (result = '') and (VpaDNota.DesMotivoCancelamentoNFE = '') then
        result := 'MOTIVO NÃO PREENCHIDO!!!'#13'Para cancelar uma NFe é necessário informar o motivo';
    end;
  end;

  if (result = '') then
  begin
    if (Config.EmiteNFe)and (VpaCancelarSefaz) then
    begin
      if (VpaDNota.NumProtocoloNFE <> '' ) then
        result := FunNFe.CancelaNFE(VpaDNota,VpaDNota.DesMotivoCancelamentoNFE)
      else
        result := FunNFe.InutilizaNumero(VpaDNota.CodFilial,VpaDNota.SeqNota,VpaDNota.NumNota);
    end;
    if result = '' then
    begin
      result := EstornaNotaFiscal(VpaDNota,VpaEstornarCotacao);
      if result = '' then
        CancelaNota(VpaDNota);
    end;
  end;
end;

{************* cancela nota fiscal ******************************************** }
function  TFuncoesNotaFiscal.DevolucaoTotalNotaFiscal(VpaCodFilial, VpaSeqNota : Integer ) : boolean;
begin
  result := ExcluiContasaReceber(VpaCodFilial,VpaSeqNota, true);  // exclui contas a receber
  if Result then
    Devolucao(VpaCodFilial,VpaSeqNota);
end;

{************** gera a nota e o cupom fiscal de devolução *********************}
function TFuncoesNotaFiscal.GeraNotaFiscalDevolucao(VpaCodFilial, VpaSeqNota : Integer; BaixaEstoque : String; VpaNatureza : String; VpaCupom : Boolean; VpaCodOpe, VpaItemNatureza : Integer): Integer;
Var
  VpfLaco, VpfSeqNovaNota : Integer;
begin
  LocalizaCadNotaFiscal(Tabela,VpaCodFilial,VpaSeqNota);
  LocalizaCadNotaFiscal(Cadastro,VpaCodFilial,VpaSeqNota);
  Cadastro.Insert;
  for VpfLaco := 0 to Cadastro.FieldCount - 1 do
    Cadastro.FieldByName(Cadastro.Fields[VpfLaco].FieldName).Value := Tabela.FieldByName(Cadastro.Fields[VpfLaco].FieldName).Value;

  Cadastro.FieldByName('I_Nro_Loj').Clear;
  Cadastro.FieldByName('I_Nro_Cai').Clear;
  Cadastro.FieldByName('I_Nro_Tec').Clear;
  Cadastro.FieldByName('C_Not_Dev').Asstring := 'N';
  Cadastro.FieldByName('C_Not_Can').Asstring := 'N';
  Cadastro.FieldByName('C_NOT_INU').Asstring := 'N';
  Cadastro.FieldByName('C_Tip_Not').Asstring := 'E';
  Cadastro.FieldByName('C_Fla_Ecf').Asstring := 'N';
  Cadastro.FieldByName('C_Not_Imp').Asstring := 'N';
  Cadastro.FieldByName('C_Cod_Nat').Asstring := VpaNatureza;
  Cadastro.FieldByName('I_Ite_Nat').AsInteger := VpaItemNatureza;
  Cadastro.FieldByName('D_Dat_Sai').AsDateTime := Date;
  Cadastro.FieldByName('D_Dat_Emi').AsDateTime := Date;
  Cadastro.FieldByName('T_Hor_Sai').AsDateTime := Time;
  Cadastro.FieldByName('C_SER_NOT').AsString := varia.SerieNota;
  Cadastro.FieldByName('I_SEQ_DEV').AsInteger := Tabela.FieldByName('I_SEQ_NOT').AsInteger;
  Cadastro.FieldByName('I_Nro_Not').AsInteger := RetornaProximoCodigoNota(Varia.SerieNota);
//  Cadastro.FieldByName('I_COD_Cli').AsInteger := Varia.ClienteDevolucao;
  //atualiza a data de alteracao para poder exportar
  Cadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  VpfSeqNovaNota := RetornaSeqNotaDisponivel;
  Cadastro.FieldByName('I_Seq_Not').AsInteger := VpfSeqNovaNota;
  Cadastro.Post;

  LocalizaMovNotaFiscal(Tabela,VpaCodFilial,VpaSeqNota);
  LocalizaMovNotaFiscal(Cadastro,VpaCodFilial,VpaSeqNota);

  While not Tabela.Eof do
  begin
    Cadastro.insert;
    for VpfLaco := 0 to Cadastro.FieldCount -1 do
      Cadastro.FieldByName(Cadastro.Fields[VpfLaco].FieldName).Value := Tabela.FieldByName(Cadastro.Fields[VpfLaco].FieldName).Value;

    Cadastro.FieldByName('I_Seq_Not').AsInteger := VpfSeqNovaNota;
    Cadastro.FieldByName('I_Seq_Mov').AsInteger := RetornaMovSeqDisponivel;
    //atualiza a data de alteracao para poder exportar
    Cadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;
    Cadastro.Post;
    Tabela.Next;
  end;

  LocalizaMovServicoNota(Tabela, VpaCodFilial,VpaSeqNota);
  LocalizaMovServicoNota(Cadastro,VpaCodfilial,VpaSeqNota);

  While not Tabela.Eof do
  begin
    Cadastro.insert;
    for VpfLaco := 0 to Cadastro.FieldCount -1 do
      Cadastro.FieldByName(Cadastro.Fields[VpfLaco].FieldName).Value := Tabela.FieldByName(Cadastro.Fields[VpfLaco].FieldName).Value;

    Cadastro.FieldByName('I_Seq_Not').AsInteger := VpfSeqNovaNota;
    //atualiza a data de alteracao para poder exportar
    Cadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

    Cadastro.Post;
    Tabela.Next;
  end;
  BaixaEstoqueDevolucao(VpaCodFilial,VpaSeqNota,VpaNatureza, BaixaEstoque, VpaCodOpe);
  result := VpfSeqNovaNota
end;

{**************** retorna o sequencial da nota disponivel *********************}
function TFuncoesNotaFiscal.RetornaSeqNotaDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(I_seq_Not) Ultimo  from CadNotaFiscais '+
                            ' Where I_Emp_Fil = ' + InttoStr(Varia.CodigoEmpFil));
  result := Aux.FieldByName('Ultimo').Asinteger + 1;
end;

{**************** retorna o sequencial do mov notafiscal **********************}
function TFuncoesNotaFiscal.RetornaMovSeqDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(I_seq_Mov) Ultimo  from MovNotasFiscais '+
                            ' Where I_Emp_Fil = ' + InttoStr(Varia.CodigoEmpFil));
  result := Aux.FieldByName('Ultimo').Asinteger + 1;
end;

{*************** baixa a nota de devolucao no estoque *************************}
procedure TFuncoesNotaFiscal.BaixaEstoqueDevolucao(VpaCodFilial, VpaSeqNota : Integer; VpaNatureza, BaixaEstoque : String; VpaCodOpe : Integer);
var
  VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  if BaixaEstoque = 'S' Then
  begin
    AdicionaSQLAbreTabela(CadNotaFiscal,'Select CAD.I_EMP_FIL, Pro.I_Seq_Pro,PRO.C_KIT_PRO Mov.I_Seq_Not, Cad.I_Nro_Not, '+
                        ' Cad.D_Dat_Emi, Mov.N_Qtd_Pro, Mov.N_Tot_Pro, MOV.I_COD_COR,MOV.C_PRO_REF,' +
                        ' Mov.C_Cod_Uni UnidadeMov, Pro.C_Cod_Uni UnidadePro '+
                        'from CadProdutos Pro, MovNotasFiscais Mov, CadNotaFiscais Cad '+
                        ' Where Cad.I_Emp_Fil = '+ IntToStr(VpaCodFilial)+
                        ' and Cad.I_Seq_Not = ' + IntTostr(VpaSeqNota) +
                        ' and Pro.I_Seq_Pro = Mov.I_Seq_Pro '+
                        ' and Cad.I_Emp_Fil = Mov.I_Emp_Fil '+
                        ' and Cad.I_Seq_Not = Mov.I_Seq_Not');
    while not CadNotaFiscal.eof do
    begin
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,varia.codigoempresa,CadNotaFiscal.FieldByname('I_EMP_FIL').AsInteger,CadNotaFiscal.FieldByName('I_Seq_Pro').Asinteger);
      FunProdutos.BaixaProdutoEstoque(VpfDProduto,
                                   CadNotaFiscal.FieldByname('I_EMP_FIL').AsInteger,
                                   VpaCodOpe,
                                   CAdNotaFiscal.FieldByName('I_Seq_Not').AsInteger,
                                   CAdNotaFiscal.FieldByName('I_Nro_Not').AsInteger,0,
                                   Varia.MoedaBase, CAdNotaFiscal.FieldByName('I_COD_COR').AsInteger,
                                   0,
                                   CAdNotaFiscal.FieldByName('D_Dat_Emi').AsDateTime,
                                   CAdNotaFiscal.FieldByName('N_Qtd_Pro').AsFloat,
                                   CAdNotaFiscal.FieldByName('N_Tot_Pro').AsFloat,
                                   CAdNotaFiscal.FieldByName('UnidadeMov').AsString,
                                   CAdNotaFiscal.FieldByName('C_PRO_REF').AsString,false,VpfSeqEstoqueBarra);
      VpfDProduto.free;
      CadNotaFiscal.next;
    end;
    CadNotaFiscal.close;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.BaixaEstoqueNota(VpaDNota: TRBDNotaFiscal; VpaDNatureza : TRBDNaturezaOperacao; VpaFunProdutos: TFuncoesProduto): string;
var
  VpfLaco, VpfSeqEstoqueBarra, VpfCodOperacaoEstoque : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  try
    // baixa em estoque
    if ConfigModulos.Estoque then
    begin
      if (VpaDNota.IndBaixarEstoque and  not VpaDNota.IndECF) or
        (VpaDNota.IndECF and config.BaixarEstoqueECF) then
      begin
        for VpfLaco := 0 to VpaDNota.Produtos.count - 1 do
        begin
          if VpaDNota.IndECF then
            VpfCodOperacaoEstoque := varia.CodOperacaoEstoqueECF
          else
            VpfCodOperacaoEstoque := VpaDNatureza.CodOperacaoEstoque;

          VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
          if (VpfDProdutoNota.IndItemCancelado) and   VpaDNota.IndECF then
            Continue;

          VpfDProduto := TRBDProduto.Cria;
          VpaFunProdutos.CarDProduto(VpfDProduto,0,VpaDNota.CodFilial,VpfDProdutoNota.SeqProduto);
          VpaFunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDNota.CodFilial,
                                          VpfCodOperacaoEstoque ,
                                          VpaDNota.SeqNota,
                                          VpaDNota.NumNota,0,
                                          varia.MoedaBase,VpfDProdutoNota.CodCor,0,
                                          VpaDNota.DatEmissao,
                                          VpfDProdutoNota.QtdProduto,
                                          VpfDProdutoNota.ValTotal,
                                          VpfDProdutoNota.UM,
                                          VpfDProdutoNota.DesRefCliente,false,VpfSeqEstoqueBarra);
          VpfDProduto.free;
        end;
      end;
    end;
  except
    on e : Exception do result := 'ERRO NA BAIXA DO ESTOQUE!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.BaixaSaldoSinalPagamento(VpaDNotaFiscal : TRBDNotaFiscal;VpaValSinal: Double): string;
var
  VpfLaco : Integer;
  VpfDParcelaSinal : TRBDParcelaSinal;
begin
  result := '';
  for VpfLaco := 0 to VpaDNotaFiscal.ParcelasSinal.Count - 1 do
  begin
    VpfDParcelaSinal := TRBDParcelaSinal(VpaDNotaFiscal.ParcelasSinal.Items[VpfLaco]);
    FunContasAReceber.LocalizaParcela(Cadastro,VpfDParcelaSinal.CodFilial,VpfDParcelaSinal.LanReceber,VpfDParcelaSinal.NumParcela);
    if Cadastro.FieldByName('N_VLR_PAG').AsFloat > Cadastro.FieldByName('N_SIN_BAI').AsFloat  then
    begin
      Cadastro.Edit;
      if VpaValSinal > (Cadastro.FieldByName('N_VLR_PAG').AsFloat - Cadastro.FieldByName('N_SIN_BAI').AsFloat) then
      begin
        VpaValSinal := VpaValSinal - (Cadastro.FieldByName('N_VLR_PAG').AsFloat - Cadastro.FieldByName('N_SIN_BAI').AsFloat);
        Cadastro.FieldByName('N_SIN_BAI').AsFloat := Cadastro.FieldByName('N_VLR_PAG').AsFloat;
      end
      else
      begin
        Cadastro.FieldByName('N_SIN_BAI').AsFloat := Cadastro.FieldByName('N_SIN_BAI').AsFloat + VpaValSinal;
        VpaValSinal := 0;
      end;
      Cadastro.Post;
      result := Cadastro.AMensagemErroGravacao;
      if Cadastro.AErronaGravacao then
        Break;
    end;
  end;
end;

{*********************** gera a nota a partir de ******************************
Function  TFuncoesNotaFiscal.GeraNotaAPartirDe(VpaCodFilial, VpaSeqNota : Integer;  CodNatureza : String; CodCliente, ItemNatureza : Integer): Integer;
Var
  VpfLaco : Integer;
begin
  CadNotaFiscal.RequestLive := true;
  LocalizaCadNotaFiscal(Tabela,VpaCodFilial, VpaSeqNota);
  LocalizaCadNotaFiscal(CadNotaFiscal,VpaCodFilial,VpaSeqNota);
  CadNotaFiscal.Insert;
  for VpfLaco := 0 to CadNotaFiscal.FieldCount - 1 do
    CadNotaFiscal.FieldByName(CadNotaFiscal.Fields[VpfLaco].FieldName).Value := Tabela.FieldByName(CadNotaFiscal.Fields[VpfLaco].FieldName).Value;

  CadNotaFiscal.FieldByName('I_COD_CLI').AsInteger := CodCliente;
  CadNotaFiscal.FieldByName('I_Nro_Loj').Clear;
  CadNotaFiscal.FieldByName('I_Nro_Cai').Clear;
  CadNotaFiscal.FieldByName('I_Nro_Tec').Clear;
  CadNotaFiscal.FieldByName('C_Not_Dev').Asstring := 'N';
  CadNotaFiscal.FieldByName('C_Not_Can').Asstring := 'N';
  CadNotaFiscal.FieldByName('C_Fla_Ecf').Asstring := 'N';
  CadNotaFiscal.FieldByName('C_Not_Imp').Asstring := 'N';
  CadNotaFiscal.FieldByName('C_COD_NAT').Asstring := CodNatureza;
  CadNotaFiscal.FieldByName('I_ITE_NAT').AsInteger := ItemNatureza;
  CadNotaFiscal.FieldByName('D_Dat_Sai').AsDateTime := Date;
  CadNotaFiscal.FieldByName('D_Dat_Emi').AsDateTime := Date;
  CadNotaFiscal.FieldByName('T_Hor_Sai').AsDateTime := Time;
  CadNotaFiscal.FieldByName('C_SER_NOT').AsString := Varia.SerieNota;
  CadNotaFiscal.FieldByName('L_OBS_NOT').AsString := CadNotaFiscal.FieldByName('L_OBS_NOT').AsString +
                                                     ' Nota fiscal Referente ao Cupom nº ' +
                                                     Tabela.FieldByName('I_NRO_NOT').AsString;

  CadNotaFiscal.FieldByName('I_Nro_Not').AsInteger := RetornaProximoCodigoNota(Varia.SerieNota);
  //atualiza a data de alteracao para poder exportar
  CadNotaFiscal.FieldByname('D_ULT_ALT').AsDateTime := Date;

  result := RetornaSeqNotaDisponivel;
  CadNotaFiscal.FieldByName('I_Seq_Not').AsInteger := result;
  CadNotaFiscal.Post;

  LocalizaMovNotaFiscal(Tabela,VpaCodFilial,VpaSeqNota);
  LocalizaMovNotaFiscal(CadNotaFiscal,VpaCodFilial,VpaSeqNota);

  While not Tabela.Eof do
  begin
    CadNotaFiscal.insert;
    for VpfLaco := 0 to CadNotaFiscal.FieldCount -1 do
      CadNotaFiscal.FieldByName(CadNotaFiscal.Fields[VpfLaco].FieldName).Value := Tabela.FieldByName(CadNotaFiscal.Fields[VpfLaco].FieldName).Value;

    CadNotaFiscal.FieldByName('I_Seq_Not').AsInteger := Result;
    CadNotaFiscal.FieldByName('I_Seq_Mov').AsInteger := RetornaMovSeqDisponivel;
    //atualiza a data de alteracao para poder exportar
    CadNotaFiscal.FieldByname('D_ULT_ALT').AsDateTime := Date;
    CadNotaFiscal.Post;
    Tabela.Next;
  end;

  LocalizaMovServicoNota(Tabela,VpaCodFilial,VpaSeqNota);
  LocalizaMovServicoNota(CadNotaFiscal,VpaCodFilial,VpaSeqNota);

  While not Tabela.Eof do
  begin
    CadNotaFiscal.insert;
    for VpfLaco := 0 to CadNotaFiscal.FieldCount -1 do
      CadNotaFiscal.FieldByName(CadNotaFiscal.Fields[VpfLaco].FieldName).Value := Tabela.FieldByName(CadNotaFiscal.Fields[VpfLaco].FieldName).Value;

    CadNotaFiscal.FieldByName('I_Seq_Not').AsInteger := result;
    //atualiza a data de alteracao para poder exportar
    CadNotaFiscal.FieldByname('D_ULT_ALT').AsDateTime := Date;
    CadNotaFiscal.Post;
    Tabela.Next;
  end;
  CadNotaFiscal.RequestLive := False;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.GeraFinanceiroNota(VpaDNota : TRBDNotaFiscal;VpaCotacoes : tlist;VpaDCliente : TRBDCliente;VpaDContasAReceber : TRBDContasCR;VpaOcultar,VpaGravar : Boolean):String;
var
  VpfDOrcamento : TRBDOrcamento;
  VpfDVendedor : TRBDVendedor;
begin
  result := '';
  try
    if ConfigModulos.ContasAReceber then
    begin
      if VpaDNota.IndGeraFinanceiro then
      begin
        if  VpaDNota.CodPlanoContas <> '' then
        begin
          VpaDContasAReceber.CodEmpFil := VpaDNota.CodFilial;
          VpaDContasAReceber.NroNota := VpaDNota.NumNota;
          VpaDContasAReceber.SeqNota := VpaDNota.SeqNota;
          VpaDContasAReceber.CodCondicaoPgto := VpaDNota.CodCondicaoPagamento;
          VpaDContasAReceber.CodCliente := VpaDNota.CodCliente;
          VpaDContasAReceber.CodFrmPagto := VpaDNota.CodFormaPagamento;
          VpaDContasAReceber.NumContaCorrente := VpaDNota.NumContaCorrente;
          VpaDContasAReceber.CodMoeda :=  varia.MoedaBase;
          VpaDContasAReceber.CodUsuario := varia.CodigoUsuario;
          VpaDContasAReceber.DatMov := date;
          VpaDContasAReceber.DatEmissao := VpaDNota.DatEmissao;
          VpaDContasAReceber.PlanoConta := VpaDNota.CodPlanoContas;

          VpaDContasAReceber.ValTotal := VpaDNota.ValTotal;
          VpaDContasAReceber.PercentualDesAcr := (VpaDCliente.PerDescontoFinanceiro*-1);
          VpaDContasAReceber.MostrarParcelas := VpaDNota.IndMostrarParcelas;
          VpaDContasAReceber.CodVendedor := VpaDNota.CodVendedor;
          VpaDContasAReceber.CodPreposto := VpaDNota.CodVendedorPreposto;
          VpaDContasAReceber.ValTotalProdutos := VpaDNota.ValTotalProdutos;

          // comissao
          if VpaDNota.CodVendedorPreposto <> 0 then
          begin
            VpaDContasAReceber.TipComissaoPreposto := 0;
            VpaDContasAReceber.PerComissaoPreposto := VpaDNota.PerComissaoPreposto;
            VpaDContasAReceber.ValComissaoPreposto := RValorComissao(VpaDNota,VpaDContasAReceber.TipComissaoPreposto,VpaDNota.PerComissaoPreposto,0);
            VpaDContasAReceber.ValBaseComissao := VpaDNota.ValBaseComissao;
          end;
          if VpaDNota.CodVendedor <> 0 then
          begin
            VpfDVendedor := TRBDVendedor.cria;
            FunVendedor.CarDVendedor(VpfDVendedor,VpaDNota.CodVendedor);
            VpaDContasAReceber.TipComissao := VpfDVendedor.TipComissao;
            VpaDContasAReceber.TipValorComissao := VpfDVendedor.TipValorComissao;
            VpaDContasAReceber.PerComissao := VpaDNota.PerComissao;
            VpaDContasAReceber.ValComissao := RValorComissao(VpaDNota,VpaDContasAReceber.TipComissao,VpaDNota.PerComissao,VpaDNota.PerComissaoPreposto);
            VpaDContasAReceber.ValBaseComissao := VpaDNota.ValBaseComissao;
          end;
          VpaDContasAReceber.EsconderConta := VpaOcultar;
          VpaDContasAReceber.CodPreposto := VpaDNota.CodVendedorPreposto;
          VpaDContasAReceber.PerComissaoPreposto := VpaDNota.PerComissaoPreposto;
          VpaDContasAReceber.IndGerarComissao := VpaDNota.IndGeraComissao;
          VpaDContasAReceber.IndCobrarFormaPagamento := VpaDCliente.IndCobrarFormaPagamento;
          if config.SinaldePagamentonaCotacao then
          begin
            CarValSinalPagoCotacao(VpaDNota,VpaCotacoes);
            if VpaDNota.ValSinalPagamento > 0 then
            begin
              VpaDContasAReceber.IndPossuiSinalPagamento := true;
              VpaDContasAReceber.ValSinal :=VpaDNota.ValSinalPagamento;
            end;
          end;
          FunContasAReceber.CriaContasaReceber(VpaDContasAReceber,result,VpaGravar);
          VpaDNota.ValSinalPagamento := VpaDContasAReceber.ValSinal;
          if VpaDNota.ValSinalPagamento > 0 then
             VpaDNota.DesObservacao.Add('Abatido valor do sinal de "'+FormatFloat('R$ #,###,###,##0.00',VpaDNota.ValSinalPagamento)+'" realizado em '+FormatDateTime('DD/MM/YYYY',VpaDNota.DatPagamentoSinal) );
        end;
      end;
    end;
  except
    on e : exception do result := 'ERRO NA GERAÇÃO DO CONTAS A RECEBER DA NOTA FISCAL!!!'#13+e.message;
  End;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.GravaDNotaFiscal(VpaDNota : TRBDNotaFiscal) : String;
var
  VpfNovoNumNota, VpfQtdGravacao : Integer;
begin
  result := '';
  if VpaDNota.NumNota = 0 then
    VpaDNota.NumNota := RetornaProximoCodigoNota(VpaDNota.DesSerie)
  else
  begin
    if VpaDNota.SeqNota = 0 then // so valida se o numero é duplicado na inserçao da nota.
      if Notaduplicada(VpaDNota.CodFilial, InttoStr(VpaDNota.NumNota),VpaDNota.DesSerie,VpfNovoNumNota) then
        result := 'NUMERO DA NOTA FISCAL DUPLICADO!!!'#13'O número da nota fiscal digitado já existe armazenada. O próximo número de nota disponível é "'+IntToStr(VpfNovoNumNota)+'".';
  end;


  AdicionaSQLAbreTabela(Cadastro,'Select * from CADNOTAFISCAIS '+
                                 ' Where I_EMP_FIL = '+IntToStr(VpaDNota.CodFilial)+
                                 ' AND I_SEQ_NOT = '+IntToStr(VpaDNota.SeqNota));
  if VpaDNota.SeqNota = 0  then
    Cadastro.Insert
  else
    Cadastro.edit;
  Cadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNota.CodFilial;
  Cadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByName('C_SER_NOT').AsString := VpaDNota.DesSerie;
  Cadastro.FieldByName('C_SUB_SER').AsString := VpaDNota.DesSubSerie;
  Cadastro.FieldByName('I_MOD_DOC').AsInteger := VpaDNota.CodModeloDocumento;
  if VpaDNota.CodCondicaoPagamento <> 0 then
    Cadastro.FieldByName('I_COD_PAG').AsInteger := VpaDNota.CodCondicaoPagamento
  else
    Cadastro.FieldByName('I_COD_PAG').Clear;
  if VpaDNota.CodFormaPagamento <> 0 then
    Cadastro.FieldByName('I_COD_FRM').AsInteger := VpaDNota.CodFormaPagamento
  else
    Cadastro.FieldByName('I_COD_FRM').Clear;
  if VpaDNota.CodVendedor <> 0 then
    Cadastro.FieldByName('I_COD_VEN').AsInteger := VpaDNota.CodVendedor
  else
    Cadastro.FieldByName('I_COD_VEN').clear;
  if VpaDNota.CodVendedorPreposto <> 0 then
    Cadastro.FieldByName('I_VEN_PRE').AsInteger := VpaDNota.CodVendedorPreposto
  else
    Cadastro.FieldByName('I_VEN_PRE').clear;
  Cadastro.FieldByName('I_NRO_NOT').AsInteger := VpaDNota.NumNota;
  Cadastro.FieldByName('I_COD_CLI').AsInteger := VpaDNota.CodCliente;
  if VpaDNota.CodTransportadora <> 0 then
    Cadastro.FieldByName('I_COD_TRA').AsInteger := VpaDNota.CodTransportadora
  else
    Cadastro.FieldByName('I_COD_TRA').Clear;
  if VpaDNota.CodRedespacho <> 0 then
    Cadastro.FieldByName('I_COD_RED').AsInteger := VpaDNota.CodRedespacho
  else
    Cadastro.FieldByName('I_COD_RED').Clear;

  Cadastro.FieldByName('C_COD_NAT').AsString := VpaDNota.CodNatureza;
  Cadastro.FieldByName('C_NUM_PED').AsString := VpaDNota.NumPedidos;
  Cadastro.FieldByName('C_TIP_NOT').AsString := VpaDNota.DesTipoNota;
  Cadastro.FieldByName('D_DAT_EMI').AsDateTime := VpaDNota.DatEmissao;
  Cadastro.FieldByName('D_DAT_SAI').AsDateTime := VpaDNota.DatSaida;
  Cadastro.FieldByName('T_HOR_SAI').AsDateTime := VpaDNota.HorSaida;
  if VpaDNota.QtdEmbalagem <> 0 then
    Cadastro.FieldByName('I_QTD_VOL').AsInteger := VpaDNota.QtdEmbalagem
  else
    Cadastro.FieldByName('I_QTD_VOL').Clear;
  if VpaDNota.NumCotacaoTransportadora <> '' then
    Cadastro.FieldByName('C_COT_TRA').AsString := VpaDNota.NumCotacaoTransportadora
  else
    Cadastro.FieldByName('C_COT_TRA').clear;
  if VpaDNota.DesMarcaEmbalagem <> '' then
    Cadastro.FieldByName('C_MAR_PRO').AsString := VpaDNota.DesMarcaEmbalagem
  else
    Cadastro.FieldByName('C_MAR_PRO').clear;
  if VpaDNota.DesPlacaVeiculo <> '' then
    Cadastro.FieldByName('C_NRO_PLA').AsString := VpaDNota.DesPlacaVeiculo
  else
    Cadastro.FieldByName('C_NRO_PLA').clear;
  if VpaDNota.DesEspecie <> '' then
    Cadastro.FieldByName('C_TIP_EMB').AsString := VpaDNota.DesEspecie
  else
    Cadastro.FieldByName('C_TIP_EMB').clear;
  if VpaDNota.DesObservacao.Text <> '' then
    Cadastro.FieldByName('L_OBS_NOT').AsString := VpaDNota.DesObservacao.Text
  else
    Cadastro.FieldByName('L_OBS_NOT').clear;

  if VpaDNota.DesDadosAdicinais.Text <> '' then
    Cadastro.FieldByName('L_OB1_NOT').AsString := VpaDNota.DesDadosAdicinais.Text
  else
    Cadastro.FieldByName('L_OB1_NOT').clear;

  if VpaDNota.CodTipoFrete <> 0 then
    Cadastro.FieldByName('I_TIP_FRE').AsInteger := VpaDNota.CodTipoFrete
  else
    Cadastro.FieldByName('I_TIP_FRE').Clear;
  Cadastro.FieldByName('N_BAS_CAL').AsFloat := VpaDNota.ValBaseICMS;
  Cadastro.FieldByName('N_VLR_ICM').AsFloat := VpaDNota.ValICMS;
  Cadastro.FieldByName('N_TOT_PRO').AsFloat := VpaDNota.ValTotalProdutos;
  Cadastro.FieldByName('N_TOT_PSD').AsFloat := VpaDNota.ValTotalProdutosSemDesconto;
  Cadastro.FieldByName('N_TOT_SER').AsFloat := VpaDNota.ValTotalServicos;
  Cadastro.FieldByName('N_VLR_ISQ').AsFloat := VpaDNota.ValIssqn;
  Cadastro.FieldByName('N_PER_ISQ').AsFloat := VpaDNota.PerIssqn;
  Cadastro.FieldByName('N_VLR_FRE').AsFloat := VpaDNota.ValFrete;
  Cadastro.FieldByName('N_VLR_SEG').AsFloat := VpaDNota.ValSeguro;
  Cadastro.FieldByName('N_OUT_DES').AsFloat := VpaDNota.ValOutrasDepesesas;
  Cadastro.FieldByName('N_TOT_IPI').AsFloat := VpaDNota.ValTotalIPI;
  Cadastro.FieldByName('N_TOT_NOT').AsFloat := VpaDNota.ValTotal;
  Cadastro.FieldByName('N_BAS_SUB').AsFloat := VpaDNota.ValBaseICMSSubstituicao;
  Cadastro.FieldByName('N_PER_SSI').AsFloat := VpaDNota.PerICMSSuperSimples;
  Cadastro.FieldByName('N_ICM_SSI').AsFloat := VpaDNota.ValICMSSuperSimples;
  Cadastro.FieldByName('N_VLR_SUB').AsFloat := VpaDNota.ValICMSSubtituicao;
  Cadastro.FieldByName('N_PES_BRU').AsFloat := VpaDNota.PesBruto;
  Cadastro.FieldByName('N_PES_LIQ').AsFloat := VpaDNota.PesLiquido;
  Cadastro.FieldByName('N_SIN_PAG').AsFloat := VpaDNota.ValSinalPagamento;
  IF VpaDNota.DesUFPlacaVeiculo <> '' then
    Cadastro.FieldByName('C_EST_PLA').AsString := VpaDNota.DesUFPlacaVeiculo
  else
    Cadastro.FieldByName('C_EST_PLA').Clear;
  if VpaDNota.IndECF then
    Cadastro.FieldByName('C_FLA_ECF').AsString := 'S'
  else
    Cadastro.FieldByName('C_FLA_ECF').AsString := 'N';
  if VpaDNota.IndNotaVendaConsumidor then
    Cadastro.FieldByName('C_VEN_CON').AsString := 'S'
  else
    Cadastro.FieldByName('C_VEN_CON').AsString := 'N';
  if VpaDNota.IndNotaImpressa then
    Cadastro.FieldByName('C_NOT_IMP').AsString := 'S'
  else
    Cadastro.FieldByName('C_NOT_IMP').AsString := 'N';
  if VpaDNota.IndNotaCancelada then
    Cadastro.FieldByName('C_NOT_CAN').AsString := 'S'
  else
    Cadastro.FieldByName('C_NOT_CAN').AsString := 'N';
  if VpaDNota.IndNotaInutilizada then
    Cadastro.FieldByName('C_NOT_INU').AsString := 'S'
  else
    Cadastro.FieldByName('C_NOT_INU').AsString := 'N';
  if VpaDNota.NumEmbalagem <> '' then
    Cadastro.FieldByName('C_NRO_PAC').AsString := VpaDNota.NumEmbalagem
  else
    Cadastro.FieldByName('C_NRO_PAC').clear;
  if VpaDNota.DesClassificacaoFiscal <> '' then
    Cadastro.FieldByName('C_TEX_CLA').AsString := VpaDNota.DesClassificacaoFiscal
  else
    Cadastro.FieldByName('C_TEX_CLA').clear;
  if VpaDNota.IndNotaDevolvida then
    Cadastro.FieldByName('C_NOT_DEV').AsString := 'S'
  else
    Cadastro.FieldByName('C_NOT_DEV').AsString := 'N';
  if VpaDNota.IndNFEEnviada then
    Cadastro.FieldByName('C_ENV_NFE').AsString := 'S'
  else
    Cadastro.FieldByName('C_ENV_NFE').AsString := 'N';
  Cadastro.FieldByName('I_ITE_NAT').AsInteger := VpaDNota.SeqItemNatureza;
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  if VpaDNota.DesOrdemCompra <> '' then
    Cadastro.FieldByName('C_ORD_COM').AsString := VpaDNota.DesOrdemCompra
  else
    Cadastro.FieldByName('C_ORD_COM').clear;

  if VpaDNota.IndGeraFinanceiro then
    Cadastro.FieldByName('C_FIN_GER').AsString := 'S'
  else
    Cadastro.FieldByName('C_FIN_GER').AsString := 'N';
  Cadastro.FieldByName('N_PER_DES').AsFloat := VpaDNota.PerDesconto;
  Cadastro.FieldByName('N_VLR_DES').AsFloat := VpaDNota.ValDesconto;
  Cadastro.FieldByName('N_PER_COM').AsFloat := VpaDNota.PerComissao;
  Cadastro.FieldByName('N_COM_PRE').AsFloat := VpaDNota.PerComissaoPreposto;
  case VpaDNota.TipNota of
    tnNormal: Cadastro.FieldByName('N_COM_PRE').AsInteger :=0;
    tnVendaPorContaeOrdem: Cadastro.FieldByName('N_COM_PRE').AsInteger :=1;
    tnDevolucao: Cadastro.FieldByName('N_COM_PRE').AsInteger :=2;
  end;
//nfe
  Cadastro.FieldByName('C_CHA_NFE').AsString := VpaDNota.DesChaveNFE;
  Cadastro.FieldByName('C_REC_NFE').AsString := VpaDNota.NumReciboNFE;
  Cadastro.FieldByName('C_PRO_NFE').AsString := VpaDNota.NumProtocoloNFE;
  Cadastro.FieldByName('C_STA_NFE').AsString := VpaDNota.CodMotivoNFE;
  Cadastro.FieldByName('C_MOT_NFE').AsString := VpaDNota.DesMotivoNFE;
  Cadastro.FieldByName('C_EST_EMB').AsString := VpaDNota.DesUFEmbarque;
  Cadastro.FieldByName('C_LOC_EMB').AsString := VpaDNota.DesLocalEmbarque;

  VpfQtdGravacao := 0;
  repeat
    if VpaDNota.SeqNota = 0 then
    Begin
      VpaDNota.SeqNota := RSeqNotaDisponivel(VpaDNota.CodFilial);
      if config.UtilizarNSU then
      begin
        GeraNSU(VpaDNota);
        Cadastro.FieldByname('I_NRO_NSU').AsInteger := VpaDNota.NumNSU;
        Cadastro.FieldByname('D_DAT_NSU').AsDateTime := VpaDNota.DatNSU;
      end;
      if varia.TipoBancoDados = bdRepresentante then
        Cadastro.FieldByName('C_FLA_EXP').AsString := 'N'
      else
        Cadastro.FieldByName('C_FLA_EXP').AsString := 'S';
    end;
    Cadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNota.SeqNota;
    Cadastro.FieldByName('C_ASS_REG').AsString := Sistema.RAssinaturaRegistro(Cadastro);
    cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      VpaDNota.NumNota := RetornaProximoCodigoNota(VpaDNota.DesSerie);
    inc(VpfQtdGravacao);
  until ((result = '') or (VpfQtdGravacao > 3));

  if result = '' then
  begin
    Sistema.MarcaTabelaParaImportar('CADNOTAFISCAIS');
    Result := GravaDItensNota(VpaDNota);
    if result = '' then
    begin
      result := GravaDServicosnota(VpaDNota);
      if result = '' then
      begin
        result := FunClientes.CadastraProdutosCliente(VpaDNota);
      end;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.SetaNfeComoEnviada(VpaCodFilial,
  VpaSeqNota: Integer);
begin
  ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS '+
                        ' SET C_ENV_NFE = ''S'''+
                        ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                        ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNota));
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.SetaNotaImpressa(VpaCodFilial, VpaSeqNota :Integer);
begin
  ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS '+
                        ' SET C_NOT_IMP = ''S'''+
                        ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                        ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNota));
end;

{******************************************************************************}
function TFuncoesNotaFiscal.SetaNotaInutilizada(VpaCodFilial,VpaSeqNota: integer): string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select C_NOT_INU,D_ULT_ALT FROM CADNOTAFISCAIS ' +
                                 ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                 ' AND I_SEQ_NOT = '+IntToStr(VpaSeqNota));
  Cadastro.Edit;
  Cadastro.FieldByName('C_NOT_INU').AsString := 'S';
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := now;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RNomNaturezaOperacao(VpaCodNatureza : String;VpaItemNatureza : Integer) :String;
begin
  if config.ImprimirnaNotaDescricaoItemNatureza then
  begin
    AdicionaSQLAbreTabela(Aux,'Select C_NOM_MOV from MOVNATUREZA '+
                              ' Where C_COD_NAT = '''+ VpaCodNatureza+''''+
                              ' AND I_SEQ_MOV = ' +IntToStr(VpaItemNatureza));
    result := Aux.FieldByName('C_NOM_MOV').AsString;
  end
  else
  begin
    AdicionaSQLAbreTabela(Aux,'Select C_NOM_NAT from CADNATUREZA '+
                              ' Where C_COD_NAT = '''+ VpaCodNatureza+'''' );
    result := Aux.FieldByName('C_NOM_NAT').AsString;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesNotaFiscal.RNumeroCotacaoTransportadoraTexto(VpaNumCotacao: String): string;
begin
  result := '';
  if VpaNumCotacao <> '' then
    result := '    COTACAO TRANSPORTADORA : '+VpaNumCotacao;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarFaturasImpressaoNotaFiscal(VpaDNotaFiscal : TRBDNotaFiscal; VpaQtdColunasFatura : Integer);
var
  VpfNumFatura : Integer;
  VpfDFatura : TRBDImpressaoFaturaNotaFiscal;
begin
  FreeTObjectsList(VpaDNotaFiscal.Faturas);

  Tabela.sql.clear;
  Tabela.sql.add('select CR.I_LAN_REC, MCR.C_NRO_DUP, MCR.N_VLR_PAR, MCR.D_DAT_VEN, MCR.I_COD_BAN, ' +
              ' MCR.C_NRO_AGE, MCR.C_NRO_CON, MCR.I_COD_FRM '+
              ' from CadContasAReceber CR, MovContasaReceber MCR ' +
              ' where  ' +
              ' CR.I_SEQ_NOT = ' + IntToStr(VpaDNotaFiscal.SeqNota) +
              ' and CR.I_EMP_FIL = ' + IntToStr(VpaDNotaFiscal.CodFilial) +
              ' and CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
              ' and CR.I_LAN_REC =  MCR.I_LAN_REC');
  if VpaDNotaFiscal.IndGerouFinanceiroOculto then
    Tabela.sql.add('AND CR.C_IND_CAD = ''S''')
  else
    Tabela.sql.add('AND CR.C_IND_CAD = ''N''');
  Tabela.sql.add(' ORDER BY MCR.D_DAT_VEN');
  Tabela.open;
  VpfNumFatura := 5;
  if not Tabela.Eof then
  begin
    if Tabela.FieldByName('I_COD_FRM').AsInteger <> Varia.FormaPagamentoBoleto then
    begin
      if Tabela.FieldByName('C_NRO_CON').AsString <> '' then
        VpaDNotaFiscal.DesDadosAdicionaisImpressao.Insert(0,'Agencia: '+ Tabela.FieldByName('C_NRO_AGE').AsString+ '   C/C: '+Tabela.FieldByName('C_NRO_CON').AsString);
      if Tabela.FieldByName('I_COD_BAN').AsInteger <> 0 then
        VpaDNotaFiscal.DesDadosAdicionaisImpressao.insert(0,'Banco: '+Tabela.FieldByName('I_COD_BAN').AsString+'-'+FunContasAReceber.RNomBanco(Tabela.FieldByName('I_COD_BAN').AsInteger));
    end;
  end;
  if config.UtilizarNSU then
    VpaDNotaFiscal.DesDadosAdicionaisImpressao.Add('NSU '+IntToStr(VpaDNotaFiscal.NumNSU)+ ', '+FormatDateTime('DD/MM/YY HH:MM',VpaDNotaFiscal.DatNSU));
  while VpaDNotaFiscal.DesDadosAdicionaisImpressao.Count < 5 do
  begin
    VpaDNotaFiscal.DesDadosAdicionaisImpressao.Add('');
  end;
  if (VpaDNotaFiscal.CodFormaPagamento <> 0) and config.ImprimirFormaPagamentonaNota then
    VpaDNotaFiscal.DesDadosAdicionaisImpressao.Insert(0,FunContasAReceber.RNomFormaPagamento(VpaDNotaFiscal.CodFormaPagamento)+';');

  While not Tabela.Eof do
  begin
    if VpfNumFatura > VpaQtdColunasFatura then
    begin
      VpfNumFatura := 1;
      VpfDFatura := VpaDNotaFiscal.AddFatura;;
    end;
    case VpfNumFatura of
      1 :begin
           VpfDFatura.Numero1 := Tabela.fieldByName('C_NRO_DUP').AsString;
           VpfDFatura.Valor1 := Tabela.fieldByName('N_VLR_PAR').AsFloat;
           VpfDFatura.DatVencimento1 := Tabela.fieldByName('D_DAT_VEN').AsDateTime;
         end;
      2 :begin
           VpfDFatura.Numero2 := Tabela.fieldByName('C_NRO_DUP').AsString;
           VpfDFatura.Valor2 := Tabela.fieldByName('N_VLR_PAR').AsFloat;
           VpfDFatura.DatVencimento2 := Tabela.fieldByName('D_DAT_VEN').AsDateTime;
         end;
      3 :begin
           VpfDFatura.Numero3 := Tabela.fieldByName('C_NRO_DUP').AsString;
           VpfDFatura.Valor3 := Tabela.fieldByName('N_VLR_PAR').AsFloat;
           VpfDFatura.DatVencimento3 := Tabela.fieldByName('D_DAT_VEN').AsDateTime;
         end;
      4 :begin
           VpfDFatura.Numero4 := Tabela.fieldByName('C_NRO_DUP').AsString;
           VpfDFatura.Valor4 := Tabela.fieldByName('N_VLR_PAR').AsFloat;
           VpfDFatura.DatVencimento4 := Tabela.fieldByName('D_DAT_VEN').AsDateTime;
         end;
    end;
    inc(VpfNumFatura);
    Tabela.Next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarObservacaoNotaFiscal(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente);
var
  VpfTextoFiscal : TStringList;
  VpfLaco : Integer;
begin
  VpaDNota.DesDadosAdicionaisImpressao.Clear;
  VpaDNota.DesDadosAdicionaisImpressao.Text := VpaDNota.DesDadosAdicinais.Text;
  if config.SimplesFederal then
  begin
    if VpaDNota.IndCalculaICMS then
    begin
      if (VpaDNota.PerICMSSuperSimples <> 0) or (VpaDNota.ValICMSSuperSimples <> 0) then
      begin
        VpaDNota.DesDadosAdicionaisImpressao.Add(';"PERMITE O APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE '+FormatFloat('R$ ###,###,##0.00',VpaDNota.ValICMSSuperSimples)+
                                       '; CORRES-'+#10+#13);
        VpaDNota.DesDadosAdicionaisImpressao.Add('PONDENTE A ALIQUOTA DE '+FormatFloat('0.00%',VpaDNota.PerICMSSuperSimples)+' NOS TERMOS DO ART. 23 DA LC 123"');
      end;
    end;
  end;
  if not VpaDCliente.IndDestacarICMSNota then
    VpaDNota.DesDadosAdicionaisImpressao.add(Varia.TextoReducaoICMSCliente);

  if VpaDNota.DesTextoFiscal <> '' then
    VpaDNota.DesDadosAdicionaisImpressao.add(VpaDNota.DesTextoFiscal);
  if Varia.TextoReducaoImposto <> '' then
  begin
    VpfTextoFiscal := TStringList.Create;
    VpfTextoFiscal.Text := Varia.TextoReducaoImposto;
    for vpfLaco := 0 to VpfTextoFiscal.Count - 1 do
      VpaDNota.DesDadosAdicionaisImpressao.add(VpfTextoFiscal.Strings[VpfLaco]);
    VpfTextoFiscal.free;
  end;
end;

{******************************************************************************}
procedure TFuncoesNotaFiscal.CarTextoDescricaoAdicionalProduto(VpaDNotaFiscal: TRBDNotaFiscal);
var
  VpfLacoProduto, VpfLacoPeca : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfDPeca : TRBDProdutoClientePeca;
  VpfPrimeiraVezDadosAdicionais : boolean;
begin
  for VpfLacoProduto := 0 to VpaDNotaFiscal.Produtos.Count - 1 do
  begin
    VpfPrimeiraVezDadosAdicionais := true;
    VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNotaFiscal.Produtos.Items[VpfLacoProduto]);
    VpfDProdutoNota.DesAdicional := '';
    if VpfDProdutoNota.DesOrdemCompra <> '' then
      VpfDProdutoNota.DesAdicional := 'OC= '+VpfDProdutoNota.DesOrdemCompra;
    if VpfDProdutoNota.DesRefCliente <> '' then
    begin
      if config.NumeroSerieProduto then
        VpfDProdutoNota.DesAdicional :=  VpfDProdutoNota.DesAdicional +'  NUMERO SERIE='+ VpfDProdutoNota.DesRefCliente
      else
        VpfDProdutoNota.DesAdicional :=  VpfDProdutoNota.DesAdicional +'  REFERENCIA CLIENTE='+ VpfDProdutoNota.DesRefCliente;
    end;
    for VpfLacoPeca := 0 to VpfDProdutoNota.ProdutoPeca.Count - 1 do
    begin
      VpfDPeca := TRBDProdutoClientePeca(VpfDProdutoNota.ProdutoPeca.Items[VpfLacoPeca]);
      if Length(VpfDProdutoNota.DesAdicional + ' | Peca='+VpfDPeca.NomProduto+' NS='+VpfDPeca.NumSerieProduto) < 500 then
        VpfDProdutoNota.DesAdicional := VpfDProdutoNota.DesAdicional + ' | Peca='+VpfDPeca.NomProduto+' NS='+VpfDPeca.NumSerieProduto
      else
      begin
        if VpfPrimeiraVezDadosAdicionais  then
        begin
          VpfPrimeiraVezDadosAdicionais := false;
          VpaDNotaFiscal.DesDadosAdicinais.Add('|*RELACAO PECAS PRODUTO '+VpfDProdutoNota.NomProduto);
        end;
        VpaDNotaFiscal.DesDadosAdicinais.Text := VpaDNotaFiscal.DesDadosAdicinais.TEXT + ' | Peca='+VpfDPeca.NomProduto+' NS='+VpfDPeca.NumSerieProduto

      end;

    end;
  end;
end;

end.
