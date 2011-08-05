unit UnNotasFiscaisFor;
{Verificado
-.edit;
}
interface

uses
    Db, DBTables, classes, sysUtils, painelGradiente, localizacao, UnArgox, UnZebra,
    Componentes1, UnProdutos, UnDados, UnDadosCR, UnContasAPagar, UnDadosProduto,
    SQLExpr, tabela, DBClient;
// calculos
type
  TCalculosNFFor = class
  private
    calcula : TSQLQuery;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); virtual;
    destructor destroy; override;
end;

// localizacao
Type
  TLocalizaNFFor = class(TCalculosNFFor)
  public
    procedure LocalizaCadNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
    procedure LocalizaMovNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
    procedure LocalizaProdutoMovNota(Tabela : TDataSet; SequencialNota, SequencialProduto : Integer );
    procedure LocalizaNatureza( Tabela : TDataSet; CodNatureza : Integer );
    procedure LocalizaProdutoCodigos(Tabela : TDataSet; Codigos : string);
    procedure LocalizaMovNatureza(Tabela : TDataSet; Codnat : string );
  end;

// funcoes
type
  TFuncoesNFFor = class(TLocalizaNFFor)
  private
    Natureza : TSqlQuery;
    Tabela,
    NotCadastro : TSQL;
    DataBase : TSQLConnection;
    UnProduto : TFuncoesProduto;
    function RSeqNotaDisponivel(VpaEmpFil : String) : Integer;
    function RSeqConhecimentoTransporte: integer;
    function GravaLogEstagio(VpaCodFilial, VpaSeqNotaFiscal,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String):String;
    function GravaDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
    function GravaDItemServicoNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
    procedure CarDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
    procedure CarDItemServicoNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
    function AtualizaProdutoFornecedor(VpaDNotaFor : TRBDNotaFiscalFor):String;
    function AtualizaNcmProduto(VpaDNotaFor : TRBDNotaFiscalFor):String;
    function RProdutoNota(VpaDNota: TRBDNotaFiscalFor; VpaDProdutoPedido: TRBDProdutoPedidoCompra): TRBDNotaFiscalForItem;
    function ExtornaVinculoPedidoNotaFiscalItem(VpaCodFilial, VpaSeqNota: Integer): String;
    function AdicionaProdutoDevolucao(VpaNotas : TList;VpaDNotafor : TRBDNotaFiscalFor):string;
    procedure CalculaValorFreteProdutos(VpaDNota : TRBDNotaFiscalFor);
  public
    Localiza: TConsultaPadrao;
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); override;
    destructor Destroy; override;
    function RSeqEstagioDisponivel(VpaCodFilial, VpaSeqNota : Integer):Integer;
    function VerificaItemNotaRepetido( SequencialNota, SequencialProduto : Integer ) : Boolean;
    procedure LocalizaCadastrar(Sender: TObject);
    function LocalizaProduto( var codigoProduto, ClaFis, Unidade, SequencialProduto : string; LocalizarF3 : Boolean;
                             corForm : TCorForm; CorFoco : TCorFoco; PainelGra : TCorPainelGra) : Boolean;
    procedure CalculaNota(VpaDNotaFor : TRBDNotaFiscalFor );
    function ExisteProduto(VpaCodProduto : String;VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
    function ExisteServico(VpaCodServico : String;VpaDNotaFor : TRBDNotaFiscalFor; VpaDServicoNota : TRBDNotaFiscalForServico):Boolean;
    procedure DeletaNotaFiscalFor(VpaCodFilial, VpaSeqNota : Integer );
    procedure EstornaEstoqueFiscal(VpaDNota : TRBDNotaFiscalFor);
    procedure EstornaNotaEntrada( VpaCodFilial, VpaSeqNota : integer );
    procedure CarDNaturezaOperacao(VpaDNotaFor : TRBDNotaFiscalFor);overload;
    procedure CarDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
    procedure CarDConhecimentoTransporte(VpaSeqNota, VpaCodFilial: Integer; VpaDConhecimentoTransporte: TRBDConhecimentoTransporte; VpaNotaEntrada: Boolean);
    function GravaDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
    Function GravaDConhecimentoTransporte(VpaDConhecimentoTransporte : TRBDConhecimentoTransporte) : String;
    Function ExcluiConhecimentoTransporte(VpaCodFilial, VpaSeqConhecimento, VpaCodTransportadora: Integer): String;
    function GravaDConhecimentoTransporteNotaSaida(VpaConhecimento : TList): String;
    function GeraNotaDevolucao(VpaNotas : TList;VpaDNotaFor : TRBDNotaFiscalFor) : string;
    function BaixaProdutosEstoque(VpaDNotaFor : TRBDNotaFiscalFor) :String;
    procedure BaixaEstoqueFiscal(VpaDNotafor : TRBDNotaFiscalFor);
    function GeraContasaPagar(VpaDNotaFor : TRBDNotaFiscalFor) :String;
    function RValICMSFornecedor(VpaSigEstado : String) : Double;
    function ValidaMedicamentoControlado(VpaDNotaFor : TRBDNotaFiscalFor; VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
    function PreparaEtiqueta(VpaDNotaFor : TRBDNotaFiscalFor;VpaPosInicial : Integer):string;
    function ImprimeEtiquetaNota(VpaDNotaFor : TRBDNotaFiscalFor):string;
    procedure GeraNotadosPedidos(VpaListaPedidos: TList; VpaDNota: TRBDNotaFiscalFor);
    procedure PreencheProdutosNotaPedido(VpaListaPedidos: TList; VpaDNota: TRBDNotaFiscalFor);
    procedure CarUltimaNotafiscalProduto(VpaDatVenda : TDateTime;VpaCodFilial, VpaSeqProduto : Integer;VpadNotaFiscal : TRBDNotaFiscalFor);
    function RCSTICMSProduto(VpaDCliente : TRBDCliente;VpaDProduto : TRBDProduto;VpaDNatureza : TRBDNaturezaOperacao) : string;
  end;

implementation

uses constMsg, constantes, funSql, funstring, fundata, funnumeros, AItensNatureza,
      FunObjeto, ANovoProdutoPro, unsistema,FunArquivos, UnNotaFiscal;


{#############################################################################
                        TCalculo Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosNFFor.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  calcula := TSQLQuery.Create(aowner);
  calcula.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosNFFor.destroy;
begin
  calcula.Destroy;
  inherited;
end;

{#############################################################################
                        TLocaliza Produtos
#############################################################################  }

{ ***************** localiza o Cabecalho de uma nota fiscal ****************** }
procedure TLocalizaNFFor.LocalizaCadNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
begin
  AdicionaSQLAbreTabela(tabela,' Select * from CadNotaFiscaisFor where ' +
                               ' I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                               ' and I_SEQ_NOT = ' + IntToStr(sequencialNota) );
end;

{ ***************** localiza o Movimento de uma nota fiscal ****************** }
procedure TLocalizaNFFor.LocalizaMovNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
begin
  AdicionaSQLAbreTabela(tabela,' Select * from dba.MovNotasFiscaisFor where ' +
                               ' I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                               ' and i_seq_not = ' + IntToStr(SequencialNota) );
end;

procedure TLocalizaNFFor.LocalizaProdutoMovNota(Tabela : TDataSet; SequencialNota, SequencialProduto : Integer );
begin
AdicionaSQLAbreTabela(tabela,'Select * from MovNotasFiscaisFor where ' +
                             ' I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                             ' and i_seq_not = ' + IntToStr(SequencialNota) +
                             ' and I_SEQ_PRO = ' + IntToStr(SequencialProduto) );
end;

{******************************************************************************}
procedure TLocalizaNFFor.LocalizaNatureza(Tabela : TDataSet; CodNatureza : Integer );
begin
  AdicionaSQLAbreTabela(Tabela,' Select * from CadNatureza ' +
                               ' Where c_Cod_Nat = ''' + IntTostr(CodNatureza) + '''' );
end;

{******************************************************************************}
procedure TLocalizaNFFor.LocalizaProdutoCodigos(Tabela : TDataSet; Codigos : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where i_seq_pro in ( ' + codigos + ')' +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;

{******************************************************************************}
procedure TLocalizaNFFor.LocalizaMovNatureza(Tabela : TDataSet; Codnat : string );
begin
  AdicionaSQLAbreTabela(TABELA,' Select * from MovNatureza ' +
                                     ' Where C_Cod_Nat = ''' + Codnat + '''' +
                                     ' and c_ent_sai = ''E'' ');
end;

{#############################################################################
                        TFuncoes Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesNFFor.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  DataBase := VpaBaseDados;
  Natureza := TSQLQuery.Create(aowner);
  Natureza.SQLConnection := VpaBaseDados;
  Tabela := TSQL.Create(aowner);
  Tabela.ASQLConnection := VpaBaseDados;
  NotCadastro := TSQL.Create(aowner);
  NotCadastro.ASQLConnection := VpaBaseDados;
  Localiza := TConsultaPadrao.Create(aowner);
  UnProduto := TFuncoesProduto.criar(aowner,VpaBaseDados);
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesNFFor.Destroy;
begin
  localiza.Free;
  UnProduto.Free;
  Tabela.Close;
  Tabela.free;
  NotCadastro.Close;
  NotCadastro.free;
  Natureza.close;
  Natureza.free;
  inherited;
end;

{******************************************************************************}
function TFuncoesNFFor.RSeqConhecimentoTransporte: integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MAX(SEQCONHECIMENTO) ULTIMO from CONHECIMENTOTRANSPORTE ');
  result := Tabela.FieldByName('ULTIMO').AsInteger + 1;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesNFFor.RSeqEstagioDisponivel(VpaCodFilial, VpaSeqNota: Integer): Integer;
begin
  Natureza.Close;
  Natureza.SQL.Clear;
  Natureza.SQL.Add('Select MAX(SEQESTAGIO) ULTIMO FROM ESTAGIONOTAFISCALENTRADA ' +
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' and SEQNOTAFISCAL = ' +IntToStr(VpaSeqNota));
  Natureza.Open;
  result := Natureza.FieldByName('ULTIMO').AsInteger + 1;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.RSeqNotaDisponivel(VpaEmpFil : String) : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MAX(I_SEQ_NOT) ULTIMO from CADNOTAFISCAISFOR ' +
                               ' Where I_EMP_FIL = '+ VpaEmpFil);
  result := Tabela.FieldByName('ULTIMO').AsInteger + 1;
  Tabela.close;
end;


{******************************************************************************}
function TFuncoesNFFor.GravaDConhecimentoTransporte(VpaDConhecimentoTransporte: TRBDConhecimentoTransporte): String;
begin
  result := '';
  AdicionaSQLAbreTabela(NotCadastro,'Select * from CONHECIMENTOTRANSPORTE'+
                                    ' Where SEQCONHECIMENTO = ' + IntToStr(VpaDConhecimentoTransporte.SeqConhecimento));
  if VpaDConhecimentoTransporte.SeqConhecimento = 0 then
    NotCadastro.Insert
  else
    NotCadastro.Edit;
  NotCadastro.FieldByName('CODTRANSPORTADORA').AsInteger := VpaDConhecimentoTransporte.CodTransportadora;
  NotCadastro.FieldByName('CODFILIALNOTA').AsInteger := VpaDConhecimentoTransporte.CodFilial;
  if VpaDConhecimentoTransporte.SeqNotaSaida  <> 0 then
    NotCadastro.FieldByName('SEQNOTASAIDA').AsInteger := VpaDConhecimentoTransporte.SeqNotaSaida
  else
    NotCadastro.FieldByName('SEQNOTASAIDA').Clear;
  if VpaDConhecimentoTransporte.SeqNotaEntrada <> 0 then
    NotCadastro.FieldByName('SEQNOTAENTRADA').AsInteger := VpaDConhecimentoTransporte.SeqNotaEntrada
  else
    NotCadastro.FieldByName('SEQNOTAENTRADA').Clear;
  NotCadastro.FieldByName('CODMODELODOCUMENTO').AsString := VpaDConhecimentoTransporte.CodModeloDocumento;
  if VpaDConhecimentoTransporte.DatConhecimento > MontaData(1,1,1900) then
    NotCadastro.FieldByName('DATCONHECIMENTO').AsDateTime := VpaDConhecimentoTransporte.DatConhecimento
  else
    NotCadastro.FieldByName('DATCONHECIMENTO').Clear;
  NotCadastro.FieldByName('NUMTIPOCONHECIMENTO').AsInteger := VpaDConhecimentoTransporte.NumTipoConhecimento;
  NotCadastro.FieldByName('VALCONHECIMENTO').AsFloat := VpaDConhecimentoTransporte.ValConhecimento;
  NotCadastro.FieldByName('VALBASEICMS').AsFloat := VpaDConhecimentoTransporte.ValorBaseIcms;
  NotCadastro.FieldByName('VALICMS').AsFloat := VpaDConhecimentoTransporte.ValorIcms;
  NotCadastro.FieldByName('VALNAOTRIBUTADO').AsFloat := VpaDConhecimentoTransporte.ValorNaoTributado;
  NotCadastro.FieldByName('PESFRETE').AsFloat := VpaDConhecimentoTransporte.PesoFrete;
  NotCadastro.FieldByName('NUMCONHECIMENTO').AsInteger := VpaDConhecimentoTransporte.NumConhecimento;
  NotCadastro.FieldByName('SEQCONHECIMENTO').AsInteger := RSeqConhecimentoTransporte;
  NotCadastro.Post;
  Result := NotCadastro.AMensagemErroGravacao;
  NotCadastro.close;
end;

{******************************************************************************}
function TFuncoesNFFor.GravaDConhecimentoTransporteNotaSaida(VpaConhecimento: TList): String;
var
  VpfLaco: Integer;
  VpfDConhecimentoTransporte: TRBDConhecimentoTransporte;
begin
  Result:= '';
  for VpfLaco := 0 to VpaConhecimento.Count - 1 do
  begin
    VpfDConhecimentoTransporte:= TRBDConhecimentoTransporte(VpaConhecimento.Items[VpfLaco]);
    Result:= GravaDConhecimentoTransporte(VpfDConhecimentoTransporte);
    if Result <> '' then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.GravaDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
var
  VpfLaco : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
begin
  result := '';
  ExecutaComandoSql(Tabela,'DELETE FROM MOVNOTASFISCAISFOR '+
                           ' Where I_EMP_FIL = '+ IntTostr(VpaDNotaFor.CodFilial)+
                           ' and I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota));
  AdicionaSQLAbreTabela(NotCadastro,'Select * from MOVNOTASFISCAISFOR'+
                                    ' Where I_EMP_FIL = 0  AND I_SEQ_NOT = 0 AND I_SEQ_MOV = 0 ');
  for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    NotCadastro.Insert;
    NotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNotaFor.CodFilial;
    NotCadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNotaFor.SeqNota;
    NotCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfLaco + 1;
    NotCadastro.FieldByName('C_COD_UNI').AsString := UpperCase(VpfDItemNota.UM);
    NotCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfDItemNota.SeqProduto;
    NotCadastro.FieldByName('I_COD_CFO').AsInteger := VpfDItemNota.CodCFOP;
    NotCadastro.FieldByName('I_ITE_NAT').AsInteger := VpaDNotaFor.SeqNatureza;
    NotCadastro.FieldByName('N_QTD_PRO').AsFloat := VpfDItemNota.QtdProduto;
    NotCadastro.FieldByName('N_VLR_PRO').AsFloat := VpfDItemNota.ValUnitario;
    NotCadastro.FieldByName('N_PER_ICM').AsFloat := VpfDItemNota.PerICMS;
    NotCadastro.FieldByName('N_PER_IPI').AsFloat := VpfDItemNota.PerIPI;
    NotCadastro.FieldByName('N_VLR_BIC').AsFloat := VpfDItemNota.ValBaseIcms;
    NotCadastro.FieldByName('N_VLR_ICM').AsFloat := VpfDItemNota.ValICMS;
    NotCadastro.FieldByName('N_TOT_PRO').AsFloat := VpfDItemNota.ValTotal;
    NotCadastro.FieldByName('C_CLA_FIS').AsString := VpfDItemNota.CodClassificacaoFiscal;
    NotCadastro.FieldByName('C_COD_CST').AsString := VpfDItemNota.CodCST;
    NotCadastro.FieldByName('C_COD_PRO').AsString := VpfDItemNota.CodProduto;
    NotCadastro.FieldByName('C_NUM_SER').AsString := VpfDItemNota.DesNumSerie;
    NotCadastro.FieldByName('N_VLR_MVA').AsFloat := VpfDItemNota.PerMVA;
    NotCadastro.FieldByName('N_MVA_AJU').AsFloat := VpfDItemNota.PerMVAAjustado;
    NotCadastro.FieldByName('N_VLR_BST').AsFloat := VpfDItemNota.ValBaseST;
    NotCadastro.FieldByName('N_VLR_TST').AsFloat := VpfDItemNota.ValST;
    NotCadastro.FieldByName('N_PER_ACU').AsFloat := VpfDItemNota.PerAcrescimoST;
    NotCadastro.FieldByName('N_VLR_DES').AsFloat := VpfDItemNota.ValDesconto;
    NotCadastro.FieldByName('N_OUT_DES').AsFloat := VpfDItemNota.ValOutrasDespesas;
    NotCadastro.FieldByName('N_VLR_FRE').AsFloat := VpfDItemNota.ValFrete;
    NotCadastro.FieldByName('N_RED_BAS').AsFloat := VpfDItemNota.PerReducaoBaseICMS;

    if config.PermiteAlteraNomeProdutonaNotaEntrada then
      NotCadastro.FieldByName('C_NOM_PRO').AsString := VpfDItemNota.NomProduto;;
    NotCadastro.FieldByName('C_NOM_COR').AsString := VpfDItemNota.DesCor;
    if VpfDItemNota.CodCor <> 0 then
      NotCadastro.FieldByName('I_COD_COR').AsInteger := VpfDItemNota.CodCor
    else
      NotCadastro.FieldByName('I_COD_COR').Clear;
    if VpfDItemNota.QtdChapa <> 0 then
      NotCadastro.FieldByName('N_QTD_CHA').AsFloat := VpfDItemNota.QtdChapa
    else
      NotCadastro.FieldByName('N_QTD_CHA').Clear;
    if VpfDItemNota.LarChapa <> 0 then
      NotCadastro.FieldByName('N_LAR_CHA').AsFloat := VpfDItemNota.LarChapa
    else
      NotCadastro.FieldByName('N_LAR_CHA').Clear;
    if VpfDItemNota.ComChapa <> 0 then
      NotCadastro.FieldByName('N_COM_CHA').AsFloat := VpfDItemNota.ComChapa
    else
      NotCadastro.FieldByName('N_COM_CHA').Clear;
    if VpfDItemNota.CodTamanho <> 0 then
      NotCadastro.FieldByName('I_COD_TAM').AsInteger := VpfDItemNota.CodTamanho
    else
      NotCadastro.FieldByName('I_COD_TAM').Clear;

    NotCadastro.FieldByName('D_ULT_ALT').AsDateTime := now;
    if VpfDItemNota.DesReferenciaFornecedor <> '' then
      NotCadastro.FieldByName('C_REF_FOR').AsString := VpfDItemNota.DesReferenciaFornecedor
    else
      NotCadastro.FieldByName('C_REF_FOR').Clear;

    FunProdutos.AlteraClassificacaoProdutoFamilia(VpfDItemNota.SeqProduto);
    if VpfDItemNota.CodCST <> '' then
      FunProdutos.AlteraProdutoParaSubstituicaoTributaria(VpfDItemNota.SeqProduto, VpfDItemNota.CodCST);

    NotCadastro.Post;
    if not VpfDItemNota.IndProdutoAtivo then
      result := FunProdutos.ColocaProdutoEmAtividade(VpfDItemNota.SeqProduto);

    Result := NotCadastro.AMensagemErroGravacao;
    if NotCadastro.AErronaGravacao then
      exit;
    if VpfDItemNota.ValVenda <> VpfDItemNota.ValNovoVenda then
    begin
      result := FunProdutos.AlteraValorVendaProduto(VpfDItemNota.SeqProduto,VpfDItemNota.CodTamanho,VpfDItemNota.ValNovoVenda);
      if result <> '' then
        exit;
    end;
  end;
  NotCadastro.close;
end;

{******************************************************************************}
function TFuncoesNFFor.GravaDItemServicoNotaFor(
  VpaDNotaFor: TRBDNotaFiscalFor): String;
var
  VpfLaco : Integer;
  VpfDServico : TRBDNotaFiscalForServico;
begin
  result := '';
  ExecutaComandoSql(Tabela,'DELETE FROM MOVSERVICONOTAFOR '+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaDNotaFor.CodFilial)+
                        ' and I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota));
  AdicionaSQLAbreTabela(NotCadastro,'Select * from MOVSERVICONOTAFOR '+
                        ' Where I_EMP_FIL = 0 and I_SEQ_NOT = 0');
  for VpfLaco := 0 to VpaDNotaFor.ItensServicos.Count - 1 do
  begin
    VpfDSErvico := TRBDNotaFiscalForServico(VpaDNotaFor.ItensServicos.Items[VpfLaco]);
    NotCadastro.insert;
    NotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNotaFor.CodFilial;
    NotCadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNotaFor.SeqNota;
    NotCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfLaco+1;
    NotCadastro.FieldByName('I_COD_SER').AsInteger := VpfDServico.CodServico;
    if config.PermiteAlteraNomeProdutonaCotacao then
      NotCadastro.FieldByName('C_NOM_SER').AsString := VpfDServico.NomServico;
    NotCadastro.FieldByName('C_DES_ADI').AsString := VpfDServico.DesAdicional;
    NotCadastro.FieldByName('N_QTD_SER').AsFloat := VpfDServico.QtdServico;
    NotCadastro.FieldByName('N_VLR_SER').AsFloat := VpfDServico.ValUnitario;
    NotCadastro.FieldByName('N_TOT_SER').AsFloat := VpfDServico.ValTotal;
    NotCadastro.FieldByName('I_COD_CFO').AsInteger := VpfDServico.CodCFOP;
    NotCadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    Notcadastro.post;
    result := NotCadastro.AMensagemErroGravacao;
    if NotCadastro.AErronaGravacao then
      break;
  end;
  NotCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarDConhecimentoTransporte(VpaSeqNota, VpaCodFilial: Integer; VpaDConhecimentoTransporte: TRBDConhecimentoTransporte; VpaNotaEntrada: Boolean);
begin
  AdicionaSQLTabela(Tabela,'Select * from CONHECIMENTOTRANSPORTE '+
                               ' Where CODFILIALNOTA = '+ IntToStr(VpaCodFilial));
  if VpaNotaEntrada then
    AdicionaSQLTabela(Tabela, ' and SEQNOTAENTRADA = '+ IntToStr(VpaSeqNota))
  else
    AdicionaSQLTabela(Tabela, ' and SEQNOTASAIDA = '+ IntToStr(VpaSeqNota));

 Tabela.Open;
 if not Tabela.Eof then
 begin
  VpaDConhecimentoTransporte.SeqConhecimento:= Tabela.FieldByName('SEQCONHECIMENTO').AsInteger;
  VpaDConhecimentoTransporte.CodTransportadora:= Tabela.FieldByName('CODTRANSPORTADORA').AsInteger;
  VpaDConhecimentoTransporte.CodFilial:= Tabela.FieldByName('CODFILIALNOTA').AsInteger;
  VpaDConhecimentoTransporte.SeqNotaSaida:= Tabela.FieldByName('SEQNOTASAIDA').AsInteger;
  VpaDConhecimentoTransporte.SeqNotaEntrada:= Tabela.FieldByName('SEQNOTAENTRADA').AsInteger;
  VpaDConhecimentoTransporte.CodModeloDocumento:= Tabela.FieldByName('CODMODELODOCUMENTO').AsString;
  VpaDConhecimentoTransporte.DatConhecimento:= Tabela.FieldByName('DATCONHECIMENTO').AsDateTime;
  VpaDConhecimentoTransporte.NumTipoConhecimento:= StrToInT(Tabela.FieldByName('NUMTIPOCONHECIMENTO').AsString);
  VpaDConhecimentoTransporte.ValConhecimento:= Tabela.FieldByName('VALCONHECIMENTO').AsFloat;
  VpaDConhecimentoTransporte.ValorBaseIcms:= Tabela.FieldByName('VALBASEICMS').AsFloat;
  VpaDConhecimentoTransporte.ValorIcms:= Tabela.FieldByName('VALICMS').AsFloat;
  VpaDConhecimentoTransporte.ValorNaoTributado:= Tabela.FieldByName('VALNAOTRIBUTADO').AsFloat;
  VpaDConhecimentoTransporte.PesoFrete:= Tabela.FieldByName('PESFRETE').AsFloat;
  VpaDConhecimentoTransporte.NumConhecimento:= Tabela.FieldByName('NUMCONHECIMENTO').AsInteger;
  Tabela.Close;
 end;
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
var
  VpfDItemNota : TRBDNotaFiscalForItem;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_ITE_NAT, MOV.C_NUM_SER, MOV.I_COD_CFO,'+
                               ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_TOT_PRO, MOV.N_PER_IPI, ' +
                               ' MOV.N_PER_ICM,MOV.C_CLA_FIS, MOV.C_COD_CST, MOV.C_NOM_COR, MOV.C_REF_FOR, '+
                               ' MOV.C_NOM_PRO NOMPRODUTONOTA, MOV.I_COD_TAM, MOV.N_QTD_CHA, MOV.N_LAR_CHA, MOV.N_COM_CHA,'+
                               ' MOV.N_VLR_MVA, MOV.N_VLR_BST, MOV.N_VLR_TST, MOV.N_PER_ACU, MOV.N_VLR_BIC, MOV.N_VLR_ICM, ' +
                               ' MOV.N_VLR_DES, MOV.N_OUT_DES, MOV.N_VLR_FRE, MOV.N_RED_BAS, N_MVA_AJU, '+
                               ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UNIORIGINAL, PRO.N_DEN_VOL, PRO.N_ESP_ACO, PRO.C_ATI_PRO, '+
                               ' TAM.NOMTAMANHO '+
                               ' from MOVNOTASFISCAISFOR MOV, CADPRODUTOS PRO, TAMANHO TAM'+
                               ' Where MOV.I_EMP_FIL = '+ IntToStr(VpaDNotaFor.CodFilial)+
                               ' and MOV.I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota)+
                               ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               ' and '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                               ' order by I_SEQ_MOV');
  While not Tabela.Eof do
  begin
    VpfDItemNota := VpaDNotaFor.AddNotaItem;
    VpfDItemNota.SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDItemNota.CodCor := Tabela.FieldByName('I_COD_COR').AsInteger;
    VpfDItemNota.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDItemNota.CodCFOP := Tabela.FieldByName('I_COD_CFO').AsInteger;
    VpfDItemNota.CodClassificacaoFiscal := Tabela.FieldByName('C_CLA_FIS').AsString;
    VpfDItemNota.CodCST := Tabela.FieldByName('C_COD_CST').AsString;
    if config.PermiteAlteraNomeProdutonaNotaEntrada then
      VpfDItemNota.NomProduto := Tabela.FieldByName('NOMPRODUTONOTA').AsString
    else
      VpfDItemNota.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDItemNota.DesCor := Tabela.FieldByName('C_NOM_COR').AsString;
    VpfDItemNota.CodTamanho := Tabela.FieldByName('I_COD_TAM').AsInteger;
    VpfDItemNota.DesTamanho := Tabela.FieldByName('NOMTAMANHO').AsString;
    VpfDItemNota.UM := Tabela.FieldByName('C_COD_UNI').AsString;
    VpfDItemNota.UMAnterior := Tabela.FieldByName('C_COD_UNI').AsString;
    VpfDItemNota.UMOriginal := Tabela.FieldByName('UNIORIGINAL').AsString;
    VpfDItemNota.UnidadeParentes := FunProdutos.ValidaUnidade.UnidadesParentes(VpfDItemNota.UMOriginal);
    VpfDItemNota.QtdChapa := Tabela.FieldByName('N_QTD_CHA').AsFloat;
    VpfDItemNota.LarChapa := Tabela.FieldByName('N_LAR_CHA').AsFloat;
    VpfDItemNota.ComChapa := Tabela.FieldByName('N_COM_CHA').AsFloat;
    VpfDItemNota.QtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDItemNota.ValUnitario := Tabela.FieldByName('N_VLR_PRO').AsFloat;
    VpfDItemNota.ValTotal := Tabela.FieldByName('N_TOT_PRO').AsFloat;
    VpfDItemNota.PerIPI := Tabela.FieldByName('N_PER_IPI').AsFloat;
    VpfDItemNota.ValBaseIcms:= Tabela.FieldByName('N_VLR_BIC').AsFloat;
    VpfDItemNota.ValICMS:= Tabela.FieldByName('N_VLR_ICM').AsFloat;
    VpfDItemNota.PerICMS := Tabela.FieldByName('N_PER_ICM').AsFloat;
    VpfDItemNota.PerMVA := Tabela.FieldByName('N_VLR_MVA').AsFloat;
    VpfDItemNota.PerMVAAjustado := Tabela.FieldByName('N_MVA_AJU').AsFloat;
    VpfDItemNota.ValBaseST := Tabela.FieldByName('N_VLR_BST').AsFloat;
    VpfDItemNota.ValST := Tabela.FieldByName('N_VLR_TST').AsFloat;
    VpfDItemNota.ValDesconto := Tabela.FieldByName('N_VLR_DES').AsFloat;
    VpfDItemNota.ValFrete := Tabela.FieldByName('N_VLR_FRE').AsFloat;
    VpfDItemNota.ValOutrasDespesas := Tabela.FieldByName('N_OUT_DES').AsFloat;
    VpfDItemNota.PerAcrescimoST := Tabela.FieldByName('N_PER_ACU').AsFloat;

    VpfDItemNota.QtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDItemNota.ValVenda := FunProdutos.ValorDeVenda(VpfDItemNota.SeqProduto,varia.TabelaPreco,Tabela.FieldByName('I_COD_TAM').AsInteger);
    VpfDItemNota.ValReVenda := VpfDItemNota.ValVenda;
    VpfDItemNota.ValNovoVenda := VpfDItemNota.ValVenda;
    VpfDItemNota.DesNumSerie := Tabela.FieldByName('C_NUM_SER').AsString;
    VpfDItemNota.DesReferenciaFornecedor := Tabela.FieldByName('C_REF_FOR').AsString;
    VpfDItemNota.EspessuraAco := Tabela.FieldByName('N_ESP_ACO').AsFloat;
    VpfDItemNota.DensidadeVolumetricaAco := Tabela.FieldByName('N_DEN_VOL').AsFloat;
    VpfDItemNota.PerReducaoBaseICMS := Tabela.FieldByName('N_RED_BAS').AsFloat;
    VpfDItemNota.QtdEtiquetas := ArredondaPraMaior(VpfDItemNota.QtdProduto);
    VpfDItemNota.IndProdutoAtivo := Tabela.FieldByName('C_ATI_PRO').AsString = 'S';
    Tabela.Next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarDItemServicoNotaFor(VpaDNotaFor: TRBDNotaFiscalFor);
Var
  VpfDServico : TRBDNotaFiscalForServico;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.I_COD_SER, MOV.C_NOM_SER SERVICONOTA,MOV.C_DES_ADI, '+
                               ' MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_TOT_SER, MOV.I_COD_CFO, '+
                               ' SER.C_NOM_SER, SER.C_COD_CLA, '+
                               ' SER.I_COD_FIS '+
                               ' from MOVSERVICONOTAFOR MOV, CADSERVICO SER '+
                               ' Where MOV.I_EMP_FIL = '+ IntToStr(VpaDNotaFor.CodFilial)+
                               ' AND MOV.I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota)+
                               ' AND MOV.I_COD_SER = SER.I_COD_SER' );
  While not Tabela.Eof do
  begin
    VpfDServico := VpaDNotaFor.AddNotaServico;
    VpfDServico.CodServico := Tabela.FieldByName('I_COD_SER').AsInteger;
    if config.PermiteAlteraNomeProdutonaCotacao and (Tabela.FieldByName('SERVICONOTA').AsString <> '') then
      VpfDServico.NomServico := Tabela.FieldByName('SERVICONOTA').AsString
    else
      VpfDServico.NomServico := Tabela.FieldByName('C_NOM_SER').AsString;
    VpfDServico.DesAdicional:= Tabela.FieldByName('C_DES_ADI').AsString;
    VpfDServico.QtdServico := Tabela.FieldByName('N_QTD_SER').AsFloat;
    VpfDServico.ValUnitario := Tabela.FieldByName('N_VLR_SER').AsFloat;
    VpfDServico.ValTotal := Tabela.FieldByName('N_TOT_SER').AsFloat;
    VpfDServico.CodClassificacao := Tabela.FieldByname('C_COD_CLA').AsString;
    VpfDServico.CodFiscal := Tabela.FieldByName('I_COD_FIS').AsInteger;
    VpfDServico.CodCFOP := Tabela.FieldByName('I_COD_CFO').AsInteger;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.AtualizaNcmProduto(VpaDNotaFor: TRBDNotaFiscalFor): String;
var
  VpfLaco: integer;
  VpfDItem: TRBDNotaFiscalForItem;
begin
  Result:= '';
  for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItem:= TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    if (VpfDItem.CodClassificacaoFiscalOriginal <> VpfDItem.CodClassificacaoFiscal) or
       (VpfDItem.PerMVAAnterior <> VpfDItem.PerMVA) then
    begin
      Result:= FunProdutos.AlteraClassificacaoFiscalProduto(VpfDItem.SeqProduto, VpfDItem.CodClassificacaoFiscal,VpfDItem.PerMVA);
    end;
    if Result <> '' then
      break;
   end;
end;

{******************************************************************************}
function TFuncoesNFFor.AtualizaProdutoFornecedor(VpaDNotaFor : TRBDNotaFiscalFor):String;
var
  VpfLaco : Integer;
  VpfDItem : TRBDNotaFiscalForItem;
begin
  result := '';
  for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItem := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    AdicionaSQLAbreTabela(NotCadastro,'Select * from PRODUTOFORNECEDOR '+
                                      ' Where SEQPRODUTO = '+IntToStr(VpfDItem.SeqProduto)+
                                      ' and CODCLIENTE = '+IntToStr(VpaDNotaFor.CodFornecedor)+
                                      ' and CODCOR = ' +IntToStr(VpfDItem.CodCor));
    if NotCadastro.Eof then
    begin
      NotCadastro.Insert;
      NotCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDItem.SeqProduto;
      NotCadastro.FieldByname('CODCLIENTE').AsInteger := VpaDNotaFor.CodFornecedor;
      NotCadastro.FieldByname('CODCOR').AsInteger := VpfDItem.CodCor;
    end
    else
      NotCadastro.edit;

    if (NotCadastro.FieldByname('DESREFERENCIA').AsString = '') and (VpfDItem.DesReferenciaFornecedor <> '') then
      NotCadastro.FieldByname('DESREFERENCIA').AsString := VpfDItem.DesReferenciaFornecedor;

    NotCadastro.FieldByname('DATULTIMACOMPRA').AsDateTime := now;
    NotCadastro.FieldByname('VALUNITARIO').AsFloat := VpfDItem.ValUnitario;
    NotCadastro.FieldByname('PERIPI').AsFloat := VpfDItem.PerIPI;
    NotCadastro.post;
    Result := NotCadastro.AMensagemErroGravacao;
    if NotCadastro.AErronaGravacao then
      break;
  end;
  NotCadastro.close;
end;

{*********** verifica produto repetido na nota ****************************** }
function TFuncoesNFFor.VerificaItemNotaRepetido( SequencialNota, SequencialProduto : Integer ) : Boolean;
begin
  result := false;
  if not config.PermiteItemNFEntradaDuplicado then
  begin
    LocalizaProdutoMovNota(tabela,SequencialNota, SequencialProduto);

    if not tabela.EOF then
    begin
      result := true;
      Aviso(CT_ProdutoNotaRepetido);
    end;
  end;
end;

{************* cadastra novo produto ************************************** }
procedure TFuncoesNFFor.LocalizaCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(nil,'',true);
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
end;

{***************************localiza codigo de produto*************************}
function TFuncoesNFFor.LocalizaProduto( var codigoProduto, ClaFis, Unidade, SequencialProduto : string; LocalizarF3 : Boolean;
                                       corForm : TCorForm; CorFoco : TCorFoco; PainelGra : TCorPainelGra) : Boolean;
begin
result := true;

Localiza.OnCadastrar := LocalizaCadastrar;
SequencialProduto := '0';

  if (codigoProduto <> '') and ( not LocalizarF3 ) then
  begin
     FechaTabela(tabela);
     LimpaSQLTabela(tabela);
     AdicionaSQLTabela(tabela,
                 ' select Pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                 ' pro.I_SEQ_PRO, mov.C_COD_BAR, pro.c_cla_fis ' +
                 ' from CadProdutos as Pro,  MovQdadeProduto as mov ' +
                 ' where I_COD_EMP = ' + InttoStr(varia.CodigoEmpresa) +
                 ' and C_Kit_Pro = ''P''' +
                 ' and ' + varia.CodigoProduto + ' = ''' +
                 codigoProduto + ''''+
                 ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                 ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil) );
    AbreTabela(tabela);
  end;


  if (tabela.EOF) or (codigoProduto = '') or (LocalizarF3)  then
  begin
    Localiza.info.DataBase := DataBase;
    Localiza.info.ComandoSQL := ' Select Pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                                ' pro.I_SEQ_PRO, mov.C_COD_BAR, pro.c_cla_fis ' +
                                ' from CadProdutos as pro, MovQdadeProduto as mov ' +
                                ' where pro.I_COD_EMP = ' + InttoStr(varia.CodigoEmpresa)+
                                ' and pro.c_nom_Pro like ''@%'''+
                                ' and C_Kit_Pro = ''P'' '+
                                ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                                ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil) +
                                ' Order by C_Nom_Pro';
    Localiza.info.caracterProcura := '@';
    Localiza.info.ValorInicializacao := '';
    Localiza.info.CamposMostrados[0] := Varia.CodigoProduto;
    Localiza.info.CamposMostrados[1] := 'c_nom_pro';
    Localiza.info.CamposMostrados[2] := '';
    Localiza.info.DescricaoCampos[0] := 'codigo';
    Localiza.info.DescricaoCampos[1] := 'Descrição';
    Localiza.info.DescricaoCampos[2] := '';
    Localiza.info.TamanhoCampos[0] := 8;
    Localiza.info.TamanhoCampos[1] := 40;
    Localiza.info.TamanhoCampos[2] := 0;
    Localiza.info.CamposRetorno[0] := 'i_seq_pro';
    Localiza.info.CamposRetorno[1] := 'c_cod_uni';
    Localiza.info.CamposRetorno[2] := 'C_cla_fis';
    Localiza.info.CamposRetorno[3] := Varia.CodigoProduto;
    Localiza.info.SomenteNumeros := false;
    Localiza.info.CorFoco := CorFoco;
    Localiza.info.CorForm := CorForm;
    Localiza.info.CorPainelGra := PainelGra;
    Localiza.info.TituloForm := '   Localizar Produto  ';
    Localiza.ACadastrar := true;

    result := Localiza.execute;

    if result then
    begin
       SequencialProduto := Localiza.retorno[0];
       Unidade := Localiza.retorno[1];
       ClaFis := Localiza.retorno[2];
       codigoProduto := Localiza.retorno[3];
    end
  end
  else
  begin
     SequencialProduto := tabela.FieldByName('I_SEQ_PRO').AsString;
     unidade := tabela.FieldByName('C_COD_UNI').AsString;
     ClaFis := tabela.FieldByName('C_Cla_Fis').AsString;
     codigoProduto := tabela.FieldByName(varia.CodigoProduto).AsString;
  end;
end;

{**************************Calcula o valor da nota*****************************}
procedure TFuncoesNFFor.CalculaNota(VpaDNotaFor : TRBDNotaFiscalFor);
var
  VpfTotFrete, VpfPerDesconto, VpfValIPI, VpfValTotalServico,VpfValReducaoBaseICMS, VpfBaseICMSComIPI : double;
  descontoFormato : string;
  Sinal : string;
  VpfLaco, VpfLacoServico : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
  VpfDItemServico: TRBDNotaFiscalForServico;
begin
  VpaDNotaFor.ValTotalProdutos := 0;
  VpaDNotaFor.ValBaseICMS := 0;
  VpaDNotaFor.ValBaseICMSSubstituicao := 0;
  VpaDNotaFor.ValICMSSubstituicao := 0;
  VpaDNotaFor.ValICMS := 0;
  VpaDNotaFor.ValIPI := 0;
  VpaDNotaFor.ValDescontoCalculado := 0;
  VpaDNotaFor.ValTotalServicos := 0;

  for  Vpflaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    VpaDNotaFor.ValTotalProdutos := VpaDNotaFor.ValTotalProdutos + ArredondaDecimais(VpfDItemNota.ValTotal,2);
    VpfDItemNota.ValTotal:= ArredondaDecimais((VpfDItemNota.ValUnitario * VpfDItemNota.QtdProduto),2);
  end;
  CalculaValorFreteProdutos(VpaDNotaFor);

  //calcula o percentual de desconto da nota.
  VpfPerDesconto := 0;
  if VpaDNotaFor.PerDesconto <> 0 then
    VpfPerDesconto := VpaDNotaFor.PerDesconto
  else
    if (VpaDNotaFor.ValDesconto <> 0) and (VpaDNotaFor.ValTotalProdutos > 0) then
      VpfPerDesconto := (VpaDNotaFor.ValDesconto *100) / VpaDNotaFor.ValTotalProdutos;

  for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[Vpflaco]);
    if VpfDItemNota.ValTotal = 0 then
      Continue;
    VpfDItemNota.ValBaseICMS := 0;
    VpfDItemNota.ValICMS := 0;

    VpfDItemNota.ValDesconto := ArredondaDecimais(((VpfDItemNota.ValTotal *VpfPerDesconto)/100),2);

    if FunProdutos.ProdutoTributado(VpfDItemNota.CodCST) then
    begin
      VpfDItemNota.ValBaseIcms := VpfDItemNota.ValTotal + VpfDItemNota.ValFrete + VpfDItemNota.ValOutrasDespesas-VpfDItemNota.ValDesconto ;
      VpfValReducaoBaseICMS := (VpfDItemNota.PerReducaoBaseICMS*VpfDItemNota.ValBaseICMS)/ 100;
      VpfDItemNota.ValBaseICMS := ArredondaDecimais(VpfDItemNota.ValBaseICMS - VpfValReducaoBaseICMS,2);
      VpfDItemNota.ValICMS := ArredondaDecimais(((VpfDItemNota.ValBaseIcms * VpfDItemNota.PerICMS)/100),2);

      VpaDNotaFor.ValBaseICMS :=  VpaDNotaFor.ValBaseICMS + VpfDItemNota.ValBaseIcms;
      VpaDNotaFor.ValICMS := VpaDNotaFor.ValICMS + VpfDItemNota.ValICMS;
    end;
    VpfDItemNota.PerAcrescimoST := 0;
    if FunProdutos.ProdutoDestacaST(VpfDItemNota.CodCST) then
    begin
      VpfDItemNota.ValBaseST := VpfDItemNota.ValBaseIcms + (( VpfDItemNota.ValBaseIcms * VpfDItemNota.PerIPI)/100);
      VpfDItemNota.ValBaseST := VpfDItemNota.ValBaseST + (( VpfDItemNota.ValBaseST * VpfDItemNota.PerMVA)/100);
      VpfDItemNota.ValBaseST := ArredondaDecimais(VpfDItemNota.ValBaseST,2);
      VpfDItemNota.ValST := ((VpfDItemNota.ValBaseST * VpfDItemNota.PerICMS)/100) - ((VpfDItemNota.ValBaseIcms * VpfDItemNota.PerICMS)/100);
      VpfDItemNota.ValST := ArredondaDecimais(VpfDItemNota.ValST,2);
      if VpfDItemNota.ValBaseST > 0 then
        VpfDItemNota.PerAcrescimoST := ((VpfDItemNota.ValBaseIcms + VpfDItemNota.ValST) *100) /VpfDItemNota.ValBaseIcms;

      VpaDNotaFor.ValICMSSubstituicao := VpaDNotaFor.ValICMSSubstituicao + VpfDItemNota.ValST;
      VpaDNotaFor.ValBaseICMSSubstituicao := VpaDNotaFor.ValBaseICMSSubstituicao + VpfDItemNota.ValBaseST;
    end;
    VpfValIPI := ((VpfDItemNota.ValTotal * VpfDItemNota.PerIPI)/100);
    VpfValIPI := VpfValIPI - ((VpfValIPI * VpaDNotaFor.PerDesconto)*100);
    VpaDNotaFor.ValIPI := VpaDNotaFor.ValIPI + VpfValIPI;
  end;

  for VpfLacoServico := 0 to VpaDNotaFor.ItensServicos.Count - 1 do
  begin
    VpfDItemServico := TRBDNotaFiscalForServico(VpaDNotaFor.ItensServicos.Items[VpfLacoServico]);
    VpaDNotaFor.ValTotalServicos:=VpaDNotaFor.ValTotalServicos + VpfDItemServico.ValTotal;
  end;

  VpfTotFrete := 0;
  if VpaDNotaFor.IndFreteEmitente then
    VpfTotFrete := VpaDNotaFor.ValFrete + VpaDNotaFor.ValSeguro;


  VpaDNotaFor.ValTotal := VpaDNotaFor.ValTotalProdutos + VpfTotFrete + VpaDNotaFor.ValIPI + VpaDNotaFor.ValOutrasDespesas + VpaDNotaFor.ValICMSSubstituicao + VpaDNotaFor.ValTotalServicos;
  if VpaDNotaFor.ValDesconto <> 0 then
    VpaDNotaFor.ValDescontoCalculado := VpaDNotaFor.ValDesconto
  else
    if VpaDNotaFor.Perdesconto <> 0 then
      VpaDNotaFor.ValDescontoCalculado := ((VpaDNotaFor.ValTotal * VpaDNotaFor.PerDesconto)/100);
  VpaDNotaFor.ValTotal := VpaDNotaFor.ValTotal - VpaDNotaFor.ValDescontoCalculado
end;

{******************************************************************************}
procedure TFuncoesNFFor.CalculaValorFreteProdutos(VpaDNota: TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalForItem;
  VpfTotalFrete, VpfPerFreteProduto : Double;
  VpfTotalOutrasDespesas, VpfPerOutrasDespesas : Double;
begin
  VpfTotalFrete := 0;
  VpfTotalOutrasDespesas := 0;
  for VpfLaco := 0 to VpaDNota.ItensNota.Count -1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalForItem(VpaDNota.ItensNota.Items[VpfLaco]);
    if VpfDProdutoNota.ValTotal = 0 then
      continue;
    VpfPerFreteProduto := (VpfDProdutoNota.ValTotal *100)/VpaDNota.ValTotalProdutos;
    VpfDProdutoNota.ValFrete :=  ArredondaDecimais((VpaDNota.ValFrete * VpfPerFreteProduto)/100,2) ;
    VpfTotalFrete := VpfTotalFrete + VpfDProdutoNota.ValFrete;

    VpfPerOutrasDespesas := (VpfDProdutoNota.ValTotal *100)/VpaDNota.ValTotalProdutos;
    VpfDProdutoNota.ValOutrasDespesas := ArredondaDecimais((VpaDNota.ValOutrasDespesas * VpfPerOutrasDespesas)/100,2);
    VpfTotalOutrasDespesas := VpfTotalOutrasDespesas + VpfDProdutoNota.ValOutrasDespesas;


    if VpfLaco = VpaDNota.ItensNota.Count -1 then
    begin
      VpfDProdutoNota.ValFrete := VpfDProdutoNota.ValFrete + (VpaDNota.ValFrete - VpfTotalFrete);
      VpfDProdutoNota.ValOutrasDespesas := VpfDProdutoNota.ValOutrasDespesas + (VpaDNota.ValOutrasDespesas - VpfTotalOutrasDespesas);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.ExcluiConhecimentoTransporte(VpaCodFilial,
  VpaSeqConhecimento, VpaCodTransportadora: Integer): String;
begin
  NotCadastro.sql.clear;
  ExecutaComandoSql(NotCadastro, ' DELETE FROM CONHECIMENTOTRANSPORTE '+
                         ' WHERE CODFILIALNOTA = ' + InttoStr(VpaCodFilial) +
                         ' AND SEQCONHECIMENTO = ' + IntToStr(VpaSeqConhecimento) +
                         ' AND CODTRANSPORTADORA = ' + IntToStr(VpaCodTransportadora));
  result := NotCadastro.AMensagemErroGravacao;
  NotCadastro.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.ExisteProduto(VpaCodProduto : String;VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, '+
                                  ' PRO.C_CLA_FIS, PRO.I_PRI_ATI, C_REG_MSM, PRE.N_VLR_VEN, PRE.N_VLR_REV,'+
                                  ' PRO.N_DEN_VOL, PRO.N_ESP_ACO, PRO.C_ATI_PRO, PRO.N_PER_SUT ' +
                                  ' from CADPRODUTOS PRO, MOVQDADEPRODUTO Qtd, MOVTABELAPRECO PRE ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and PRE.I_COD_EMP = '+ IntToStr(varia.CodigoEmpresa)+
                                  ' and PRE.I_COD_TAB = '+ IntTostr(varia.TabelaPreco)+
                                  ' and PRE.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                  ' AND PRE.I_COD_MOE = '+ IntTostr(varia.MoedaBase)+
                                  ' and PRE.I_COD_CLI = 0'+
                                  ' and Pro.c_ven_avu = ''S''');

    result := not Tabela.Eof;
    if result then
    begin
      with VpaDItemNota do
      begin
        UMOriginal := Tabela.FieldByName('C_Cod_Uni').Asstring;
        UM := Tabela.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := UM;
        CodProduto := Tabela.FieldByName(Varia.CodigoProduto).Asstring;
        QtdProduto := 1;
        SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
        CodClassificacaoFiscal := Tabela.FieldByName('C_CLA_FIS').AsString;
        CodClassificacaoFiscalOriginal := Tabela.FieldByName('C_CLA_FIS').AsString;
        ValVenda := Tabela.FieldByName('N_VLR_VEN').AsFloat;
        ValRevenda := Tabela.FieldByName('N_VLR_REV').AsFloat;
        PerMVA := Tabela.FieldByName('N_PER_SUT').AsFloat;
        PerMVAAnterior := PerMVA;
        ValNovoVenda := ValVenda;
        DesRegistroMSM := Tabela.FieldByname('C_REG_MSM').AsString;
        CodPrincipioAtivo := Tabela.FieldByName('I_PRI_ATI').AsInteger;
        DensidadeVolumetricaAco := Tabela.FieldByName('N_DEN_VOL').AsFloat;
        EspessuraAco := Tabela.FieldByName('N_ESP_ACO').AsFloat;
        IndProdutoAtivo := Tabela.FieldByName('C_ATI_PRO').AsString = 'S';
        if config.Farmacia then
          IndMedicamentoControlado := FunProdutos.PrincipioAtivoControlado(CodPrincipioAtivo);
      end;
    end;
    Tabela.close;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.ExisteServico(VpaCodServico: String;VpaDNotaFor: TRBDNotaFiscalFor;VpaDServicoNota: TRBDNotaFiscalForServico): Boolean;
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
      with VpaDServicoNota do
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

{ ******************** Deleta Nota fiscal *********************************** }
procedure TFuncoesNFFor.DeletaNotaFiscalFor(VpaCodFilial, VpaSeqNota : Integer );
begin
  sistema.GravaLogExclusao('MovNotasFiscaisFor','select * from MovNotasFiscaisFor ' +
                           ' where i_emp_fil = ' + IntToStr(VpaCodFilial) +
                           ' and i_seq_not = ' + IntToStr(VpaSeqNota));
  ExecutaComandoSql(tabela,' Delete MovNotasFiscaisFor ' +
                           ' where i_emp_fil = ' + IntToStr(VpaCodFilial) +
                           ' and i_seq_not = ' + IntToStr(VpaSeqNota));
  ExecutaComandoSql(tabela,' Delete MOVSERVICONOTAFOR ' +
                           ' where i_emp_fil = ' + IntToStr(VpaCodFilial) +
                           ' and i_seq_not = ' + IntToStr(VpaSeqNota));
  sistema.GravaLogExclusao('CadNotaFiscaisFor','select * from CadNotaFiscaisFor' +
                           ' where i_emp_fil = ' + IntToStr(VpaCodFilial) +
                           ' and i_seq_not = ' + IntToStr(VpaSeqNota));
  ExecutaComandoSql(Tabela,' Delete CadNotaFiscaisFor ' +
                           ' where i_emp_fil = ' + IntToStr(VpaCodFilial) +
                           ' and i_seq_not = ' + IntToStr(VpaSeqNota) );
end;


{******************************************************************************}
procedure TFuncoesNFFor.EstornaEstoqueFiscal(VpaDNota : TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDItem : TRBDNotaFiscalForItem;
begin
  if VpaDNota.NumNota <> 1 then
  begin
    for VpfLaco := 0 to VpaDNota.ItensNota.Count - 1 do
    begin
      VpfDItem := TRBDNotaFiscalForItem(VpaDNota.ItensNota.Items[Vpflaco]);
      FunProdutos.BaixaEstoqueFiscal(VpaDNota.CodFilial,VpfDItem.SeqProduto,VpfDItem.CodCor,VpfDItem.CodTamanho, VpfDItem.QtdProduto,
                                     VpfDItem.UM,VpfDItem.UMOriginal,'S');
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesNFFor.EstornaNotaEntrada(VpaCodFilial, VpaSeqNota : integer );
var
  VpfDNota : TRBDNotaFiscalFor;
  VpfDProdutoNota : TRBDNotaFiscalForItem;
  VpfLaco,VpfSeqBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  VpfDNota := TRBDNotaFiscalFor.cria;
  VpfDNota.CodFilial := VpaCodFilial;
  VpfDNota.SeqNota := VpaSeqNota;
  CarDNotaFor(VpfDNota);
  if VpfDNota.DNaturezaOperacao.IndBaixarEstoque then
  begin
    for VpfLaco := 0 to VpfDNota.ItensNota.Count - 1 do
    begin
      VpfDProdutoNota := TRBDNotaFiscalForItem(VpfDNota.ItensNota.Items[VpfLaco]);
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,0,VpfDNota.CodFilial,VpfDProdutoNota.SeqProduto);
      FunProdutos.BaixaProdutoEstoque( VpfDProduto,VpfDNota.CodFilial,varia.OperacaoEstoqueEstornoSaida,
                                         VpfDNota.SeqNota, VpfDNota.NumNota,0,varia.MoedaBase,VpfDProdutoNota.CodCor,VpfDProdutoNota.CodTamanho,
                                         Date, VpfDProdutoNota.QtdProduto,
                                         VpfDProdutoNota.ValTotal, VpfDProdutoNota.UM ,
                                         VpfDProdutoNota.DesNumSerie,true,VpfSeqBarra);
      VpfDProduto.free;
    end;
  end;
  EstornaEstoqueFiscal(VpfDNota);
  ExtornaVinculoPedidoNotaFiscalItem(VpaCodfilial,VpaSeqNota);
  FunProdutos.ExcluiEstoqueChapa(VpaCodFilial,VpaSeqNota);
  VpfDNota.free;

  DeletaNotaFiscalFor(VpaCodFilial,VpaSeqNota );
end;

{******************************************************************************}
function TFuncoesNFFor.ExtornaVinculoPedidoNotaFiscalItem(VpaCodFilial, VpaSeqNota: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM PEDIDOCOMPRANOTAFISCALITEM'+
                               ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND SEQNOTA = '+IntToStr(VpaSeqNota));
  while not Tabela.Eof do
  begin
    NotCadastro.sql.clear;
    NotCadastro.sql.add('SELECT * FROM PEDIDOCOMPRAITEM'+
                                      ' WHERE SEQPEDIDO = '+Tabela.FieldByName('SEQPEDIDO').AsString+
                                      ' AND SEQPRODUTO = '+Tabela.FieldByName('SEQPRODUTO').AsString);
    if Tabela.FieldByName('CODCOR').AsInteger <> 0 then
      Tabela.sql.add(' AND CODCOR = '+Tabela.FieldByName('CODCOR').AsString);
    Tabela.open;
    if not NotCadastro.Eof then
    begin
      NotCadastro.Edit;
      NotCadastro.FieldByName('QTDBAIXADO').AsFloat:= NotCadastro.FieldByName('QTDBAIXADO').AsFloat-Tabela.FieldByName('QTDPRODUTO').AsFloat;
      NotCadastro.Post;
      Result := NotCadastro.AMensagemErroGravacao;
      NotCadastro.Close;
    end;
    if Result = '' then
      Tabela.Next
    else
      Tabela.Last;
  end;
  try
    ExecutaComandoSql(Tabela,'DELETE FROM PEDIDOCOMPRANOTAFISCALITEM'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND SEQNOTA = '+IntToStr(VpaSeqNota));
    ExecutaComandoSql(Tabela,'DELETE FROM PEDIDOCOMPRANOTAFISCAL'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND SEQNOTA = '+IntToStr(VpaSeqNota));
  except
    on E:Exception do
      Result:= 'ERRO AO ATUALIZAR A QUANTIDADE RECEBIDA DO PEDIDO DE COMPRA'#13+E.Message;
  end;
  Tabela.Close;
  NotCadastro.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.AdicionaProdutoDevolucao(VpaNotas : TList;VpaDNotafor : TRBDNotaFiscalFor):string;
var
  VpfLacoNota, VpfLacoProduto : Integer;
  VpfDNota : TRBDNotaFiscal;
  VpfDProNotaFor : TRBDNotaFiscalForItem;
  VpfDProNota : TRBDNotaFiscalProduto;
begin
  result := '';
  for VpfLacoNota := 0 to VpaNotas.Count -1 do
  begin
    VpfDNota := TRBDNotaFiscal(VpaNotas.Items[VpfLacoNota]);
    for VpfLacoProduto := 0 to VpfDNota.Produtos.Count - 1 do
    begin
      VpfDProNota := TRBDNotaFiscalProduto(VpfDNota.Produtos.Items[VpfLacoProduto]);
      VpfDProNotaFor := VpaDNotafor.AddNotaItem;
      ExisteProduto(VpfDProNota.CodProduto,VpfDProNotaFor);
      VpfDProNotaFor.SeqProduto := VpfDProNota.SeqProduto;
      VpfDProNotaFor.CodCor := VpfDProNota.CodCor;
      VpfDProNotaFor.UM := VpfDProNota.UM;
      VpfDProNotaFor.UnidadeParentes := FunProdutos.RUnidadesParentes(VpfDProNotaFor.UM);
      VpfDProNotaFor.DesNumSerie := VpfDProNota.DesRefCliente;
      VpfDProNotaFor.QtdProduto := VpfDProNota.QtdProduto;
      VpfDProNotaFor.ValUnitario := VpfDProNota.ValUnitario;
      VpfDProNotaFor.ValTotal := VpfDProNota.ValTotal;
      VpfDProNotaFor.PerICMS := VpfDProNota.PerICMS;
      VpfDProNotaFor.PerIPI := VpfDProNota.PerIPI;
    end;
  end;
end;


{******************************************************************************}
procedure TFuncoesNFFor.CarDNaturezaOperacao(VpaDNotaFor : TRBDNotaFiscalFor);
Var
  VpfQtd : Integer;
begin
  AdicionaSQLAbreTabela(NotCadastro,'Select COUNT(I_SEQ_MOV) QTD from MovNatureza ' +
                               ' Where C_Cod_Nat = ''' + VpaDNotaFor.CodNatureza + '''' +
                               ' and C_TIP_EMI = ''F'' ');
  VpfQtd := NotCadastro.FieldByName('QTD').AsInteger;
  AdicionaSQLAbreTabela(NotCadastro,' Select * from MovNatureza ' +
                               ' Where C_Cod_Nat = ''' + VpaDNotaFor.CodNatureza + '''' +
                               ' and C_TIP_EMI = ''F'' ');
  if VpfQtd > 1 then
  begin
    FItensNatureza := TFItensNatureza.CriarSDI(nil, '', true);
    FItensNatureza.PosicionaNatureza(NotCadastro);
    FItensNatureza.free;
  end;
  FunNotaFiscal.CarDNaturezaOperacao(VpaDNotaFor.DNaturezaOperacao,VpaDNotaFor.CodNatureza,NotCadastro.FieldByName('I_SEQ_MOV').AsInteger);
  NotCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADNOTAFISCAISFOR '+
                               ' Where I_EMP_FIL = '+ IntToStr(VpaDNotaFor.CodFilial)+
                               ' and I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota));

  VpaDNotaFor.CodFornecedor := Tabela.FieldByName('I_COD_CLI').AsInteger;
  VpaDNotaFor.NumNota := Tabela.FieldByName('I_NRO_NOT').AsInteger;
  VpaDNotaFor.CodTransportadora := Tabela.FieldByName('I_COD_TRA').AsInteger;
  VpaDNotaFor.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
  VpaDNotaFor.DatRecebimento := Tabela.FieldByName('D_DAT_REC').AsDateTime;
  VpaDNotaFor.DesObservacao := Tabela.FieldByName('L_OBS_NOT').AsString;
  VpaDNotaFor.IndFreteEmitente := Tabela.FieldByName('I_TIP_FRE').AsInteger = 1;
  VpaDNotaFor.ValBaseICMS := Tabela.FieldByName('N_BAS_CAL').AsFloat;
  VpaDNotaFor.ValICMS := Tabela.FieldByName('N_VLR_ICM').AsFloat;
  VpaDNotaFor.ValICMSSubstituicao := Tabela.FieldByName('N_VLR_SUB').AsFloat;
  VpaDNotaFor.ValBaseICMSSubstituicao := Tabela.FieldByName('N_BAS_SUB').AsFloat;
  VpaDNotaFor.ValTotalProdutos := Tabela.FieldByName('N_TOT_PRO').AsFloat;
  VpaDNotaFor.ValTotalServicos := Tabela.FieldByName('N_TOT_SER').AsFloat;
  VpaDNotaFor.ValFrete := Tabela.FieldByName('N_VLR_FRE').AsFloat;
  VpaDNotaFor.ValSeguro := Tabela.FieldByName('N_VLR_SEG').AsFloat;
  VpaDNotaFor.ValOutrasDespesas := Tabela.FieldByName('N_OUT_DES').AsFloat;
  VpaDNotaFor.ValIPI := Tabela.FieldByName('N_TOT_IPI').AsFloat;
  VpaDNotaFor.ValTotal := Tabela.FieldByName('N_TOT_NOT').AsFloat;
  VpaDNotaFor.SerNota := Tabela.FieldByName('C_SER_NOT').AsString;
  VpaDNotaFor.ValDesconto :=  Tabela.FieldByName('N_VLR_DES').AsFloat;
  VpaDNotaFor.ValDescontoCalculado :=  Tabela.FieldByName('N_VLR_DEC').AsFloat;
  VpaDNotaFor.PerDesconto := Tabela.FieldByName('N_PER_DES').AsFloat;
  VpaDNotaFor.PerICMSSuperSimples := Tabela.FieldByName('N_PER_SUS').AsFloat;
  VpaDNotaFor.ValICMSSuperSimples := Tabela.FieldByName('N_VLR_SUS').AsFloat;
  VpaDNotaFor.CodNatureza := Tabela.FieldByName('C_COD_NAT').AsString;
  VpaDNotaFor.SeqNatureza := Tabela.FieldByName('I_SEQ_NAT').AsInteger;
  FunNotaFiscal.CarDNaturezaOperacao(VpaDNotaFor.DNaturezaOperacao,VpaDNotaFor.CodNatureza,VpaDNotaFor.SeqNatureza);
  VpaDNotaFor.DNaturezaOperacao.CodPlanoContas := Tabela.FieldByName('C_CLA_PLA').AsString;
  VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque := Tabela.FieldByName('I_COD_OPE').AsInteger;
  VpaDNotaFor.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
  VpaDNotaFor.CodCondicaoPagamento := Tabela.FieldByName('I_COD_PAG').AsInteger;
  VpaDNotaFor.IndNotaDevolucao :=(Tabela.FieldByName('C_IND_DEV').AsString = 'S');
  VpaDNotaFor.IndOrigemPedidoCompra :=(Tabela.FieldByName('C_ORI_PEC').AsString = 'S');
  VpaDNotaFor.CodVendedor := Tabela.FieldByName('I_COD_VEN').AsInteger;
  VpaDNotaFor.PerComissao := Tabela.FieldByName('N_PER_COM').AsFloat;
  VpaDNotaFor.CodModeloDocumento := Tabela.FieldByName('C_MOD_DOC').AsString;
  Tabela.close;
  CarDItemNotaFor(VpaDNotaFor);
  CarDItemServicoNotaFor(VpaDNotaFor);
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarUltimaNotafiscalProduto(VpaDatVenda : TDateTime;VpaCodFilial,VpaSeqProduto: Integer; VpadNotaFiscal: TRBDNotaFiscalFor);
begin
  AdicionaSQLAbreTabela(Tabela,'Select CLI.C_NOM_CLI, CLI.C_CGC_CLI, ' +
                               ' CAD.I_NRO_NOT, CAD.D_DAT_EMI ' +
                               ' from CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV, CADCLIENTES CLI ' +
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                               ' AND CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                               ' AND CAD.I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                               ' AND MOV.I_SEQ_PRO = ' +IntToStr(VpaSeqProduto)+
                               ' AND CAD.C_MOD_DOC IS NOT NULL '+
                               ' AND CAD.D_DAT_REC <= '+SQLTextoDataAAAAMMMDD(VpaDatVenda)+
                               '  ORDER BY D_DAT_EMI DESC ');
  VpadNotaFiscal.NumNota := Tabela.FieldByName('I_NRO_NOT').AsInteger;
  VpadNotaFiscal.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
  VpadNotaFiscal.CGC_CPFFornecedor := Tabela.FieldByName('C_CGC_CLI').AsString;
  VpadNotaFiscal.NomFornecedor := Tabela.FieldByName('C_NOM_CLI').AsString;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.GravaDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
begin
  result := '';
  if VpaDNotaFor.SeqNota <> 0 then
  begin
    AdicionaSQLAbreTabela(NotCadastro,'Select * from CADNOTAFISCAISFOR'+
                                      ' Where I_EMP_FIL = '+IntTostr(VpaDNotaFor.CodFilial)+
                                      ' and I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota));
    NotCadastro.edit;
  end
  else
  begin
    AdicionaSQLAbreTabela(NotCadastro,'Select * from CADNOTAFISCAISFOR '+
                                      ' Where I_EMP_FIL = 0 AND I_SEQ_NOT = 0');
    NotCadastro.Insert;
  end;
  NotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNotaFor.CodFilial;
  NotCadastro.FieldByName('I_COD_CLI').AsInteger := VpaDNotaFor.CodFornecedor;
  NotCadastro.FieldByName('I_NRO_NOT').AsInteger := VpaDNotaFor.NumNota;
  if VpaDNotaFor.CodTransportadora <> 0 then
    NotCadastro.FieldByName('I_COD_TRA').AsInteger := VpaDNotaFor.CodTransportadora
  else
    NotCadastro.FieldByName('I_COD_TRA').clear;
  NotCadastro.FieldByName('D_DAT_EMI').AsDateTime := VpaDNotaFor.DatEmissao;
  NotCadastro.FieldByName('D_DAT_SAI').AsDateTime := VpaDNotaFor.DatEmissao;
  NotCadastro.FieldByName('D_DAT_REC').AsDateTime := VpaDNotaFor.DatRecebimento;
  NotCadastro.FieldByName('L_OBS_NOT').AsString := VpaDNotaFor.DesObservacao;
  if VpaDNotaFor.IndFreteEmitente then
    NotCadastro.FieldByName('I_TIP_FRE').AsInteger := 1
  else
    NotCadastro.FieldByName('I_TIP_FRE').AsInteger := 2;
  NotCadastro.FieldByName('N_BAS_CAL').AsFloat := VpaDNotaFor.ValBaseICMS;
  NotCadastro.FieldByName('N_VLR_ICM').AsFloat := VpaDNotaFor.ValICMS;
  NotCadastro.FieldByName('N_TOT_PRO').AsFloat := VpaDNotaFor.ValTotalProdutos;
  NotCadastro.FieldByName('N_TOT_SER').AsFloat := VpaDNotaFor.ValTotalServicos;
  NotCadastro.FieldByName('N_VLR_FRE').AsFloat := VpaDNotaFor.ValFrete;
  NotCadastro.FieldByName('N_VLR_SEG').AsFloat := VpaDNotaFor.ValSeguro;
  NotCadastro.FieldByName('N_OUT_DES').AsFloat := VpaDNotaFor.ValOutrasDespesas;
  NotCadastro.FieldByName('N_BAS_SUB').AsFloat := VpaDNotaFor.ValBaseICMSSubstituicao;
  NotCadastro.FieldByName('N_VLR_SUB').AsFloat := VpaDNotaFor.ValICMSSubstituicao;
  NotCadastro.FieldByName('N_TOT_IPI').AsFloat := VpaDNotaFor.ValIPI;
  NotCadastro.FieldByName('N_TOT_NOT').AsFloat := VpaDNotaFor.ValTotal;
  NotCadastro.FieldByName('C_SER_NOT').AsString := VpaDNotaFor.SerNota;
  NotCadastro.FieldByName('C_COD_NAT').AsString := VpaDNotaFor.CodNatureza;
  NotCadastro.FieldByName('I_SEQ_NAT').AsInteger := VpaDNotaFor.DNaturezaOperacao.SeqNatureza;
  NotCadastro.FieldByName('N_VLR_DES').AsFloat := VpaDNotaFor.ValDesconto;
  NotCadastro.FieldByName('N_VLR_DEC').AsFloat := VpaDNotaFor.ValDescontoCalculado;
  NotCadastro.FieldByName('N_PER_DES').AsFloat := VpaDNotaFor.PerDesconto;
  NotCadastro.FieldByName('N_VLR_SUS').AsFloat := VpaDNotaFor.ValICMSSuperSimples;
  NotCadastro.FieldByName('N_PER_SUS').AsFloat := VpaDNotaFor.PerICMSSuperSimples;
  NotCadastro.FieldByName('I_COD_PAG').AsInteger := VpaDNotaFor.CodCondicaoPagamento;
  NotCadastro.FieldByName('C_MOD_DOC').AsString := VpaDNotaFor.CodModeloDocumento;
  if VpaDNotaFor.DNaturezaOperacao.CodPlanoContas <> '' then
    NotCadastro.FieldByName('C_CLA_PLA').AsString :=  VpaDNotaFor.DNaturezaOperacao.CodPlanoContas
  else
    NotCadastro.FieldByName('C_CLA_PLA').Clear;
  if VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque <> 0 then
    NotCadastro.FieldByName('I_COD_OPE').AsInteger :=  VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque
  else
    NotCadastro.FieldByName('I_COD_OPE').Clear;
  if VpaDNotaFor.CodFormaPagamento <> 0 then
    NotCadastro.FieldByName('I_COD_FRM').AsInteger := VpaDNotaFor.CodFormaPagamento
  else
    NotCadastro.FieldByName('I_COD_FRM').Clear;
  if VpaDNotaFor.IndNotaDevolucao  then
    NotCadastro.FieldByName('C_IND_DEV').AsString := 'S'
  else
    NotCadastro.FieldByName('C_IND_DEV').AsString := 'N';
  if VpaDNotaFor.IndOrigemPedidoCompra  then
    NotCadastro.FieldByName('C_ORI_PEC').AsString := 'S'
  else
    NotCadastro.FieldByName('C_ORI_PEC').AsString := 'N';
  if VpaDNotaFor.CodVendedor <> 0 then
    NotCadastro.FieldByName('I_COD_VEN').AsInteger := VpaDNotaFor.CodVendedor
  else
    NotCadastro.FieldByName('I_COD_VEN').Clear;
  NotCadastro.FieldByName('N_PER_COM').AsFloat := VpaDNotaFor.PerComissao;
  NotCadastro.FieldByName('D_ULT_ALT').AsDateTime := now;

  if VpaDNotaFor.SeqNota = 0 then
    VpaDNotaFor.SeqNota := RSeqNotaDisponivel(IntToStr(VpaDNotaFor.CodFilial));

  NotCadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNotaFor.SeqNota;
  NotCadastro.FieldByName('I_COD_USU').AsInteger:= VpaDNotaFor.CodUsuario;
  NotCadastro.post;
  Result := NotCadastro.AMensagemErroGravacao;
  if result = '' then
  begin
    result := GravaDItemNotaFor(VpaDNotaFor);
    if result = '' then
    begin
      result := AtualizaProdutoFornecedor(VpaDNotaFor);
      if result = '' then
      begin
        result := AtualizaNcmProduto(VpaDNotaFor);
      end;
      if result = '' then
      begin
        result := GravaDItemServicoNotaFor(VpaDNotaFor);
      end;
    end;
  end;
  if (result = '') and (varia.EstagioCotacaoAlterada <> 0) then
    result := GravaLogEstagio(VpaDNotaFor.CodFilial,VpaDNotaFor.SeqNota,varia.EstagioCotacaoAlterada,varia.CodigoUsuario,'');
  NotCadastro.close;
end;

{******************************************************************************}
function TFuncoesNFFor.GravaLogEstagio(VpaCodFilial, VpaSeqNotaFiscal,VpaCodEstagio, VpaCodUsuario: Integer; VpaDesMotivo: String): String;
var
  VpfNomArquivo : string;
  VpfSeqContasAPagar : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(NotCadastro,'Select * from ESTAGIONOTAFISCALENTRADA ' +
                                 ' WHERE CODFILIAL = 0 AND SEQNOTAFISCAL = 0 AND SEQESTAGIO = 0');
  NotCadastro.insert;
  NotCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  NotCadastro.FieldByName('SEQNOTAFISCAL').AsInteger := VpaSeqNotaFiscal;
  NotCadastro.FieldByName('CODUSUARIO').AsInteger := VpaCodUsuario;
  NotCadastro.FieldByName('CODESTAGIO').AsInteger := VpaCodEstagio;
  if VpaDesMotivo <> '' then
    NotCadastro.FieldByName('DESMOTIVO').AsString := VpaDesMotivo;
  NotCadastro.FieldByName('DATESTAGIO').AsDateTime := now;

  AdicionaSQLAbreTabela(Tabela,'Select * from CADNOTAFISCAISFOR '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNotaFiscal));
  VpfNomArquivo := varia.PathVersoes+'\LOG\NotaEntrada\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqNotaFiscal)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'CAB.xml';
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  NotCadastro.FieldByname('DESLOG').AsString := NotCadastro.FieldByname('DESLOG').AsString+'NOTA="'+VpfNomArquivo+'"'+ #13;
  Tabela.SaveToFile(VpfNomArquivo,dfXml);

  AdicionaSQLAbreTabela(Tabela,'Select * from MOVNOTASFISCAISFOR '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNotaFiscal)+
                                  ' order by I_SEQ_MOV');
  VpfNomArquivo := varia.PathVersoes+'\LOG\NotaEntrada\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqNotaFiscal)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'PRO.xml';
  NOTCadastro.FieldByname('DESLOG').AsString := NotCadastro.FieldByname('DESLOG').AsString+'NOTAITEM="'+VpfNomArquivo+'"'+ #13;
  Tabela.SaveToFile(VpfNomArquivo,dfXml);
  Tabela.Close;

  AdicionaSQLAbreTabela(Tabela,'Select * from CADCONTASAPAGAR '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNotaFiscal));
  VpfSeqContasAPagar := Tabela.FieldByName('I_LAN_APG').AsInteger;
  VpfNomArquivo := varia.PathVersoes+'\LOG\NotaEntrada\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqNotaFiscal)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'CCP.xml';
  NOTCadastro.FieldByname('DESLOG').AsString := NotCadastro.FieldByname('DESLOG').AsString+'CADCONTASAPAGAR="'+VpfNomArquivo+'"'+ #13;
  Tabela.SaveToFile(VpfNomArquivo,dfXml);
  Tabela.Close;

  AdicionaSQLAbreTabela(Tabela,'Select * from MOVCONTASAPAGAR '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_LAN_APG = '+ IntToStr(VpfSeqContasAPagar));
  VpfNomArquivo := varia.PathVersoes+'\LOG\NotaEntrada\'+IntToStr(VpaCodFilial)+'_'+IntToStr(VpaSeqNotaFiscal)+'_'+FormatDateTime('DDMMYYHHMMSSMM',NOW)+'MCP.xml';
  NOTCadastro.FieldByname('DESLOG').AsString := NotCadastro.FieldByname('DESLOG').AsString+'MOVCONTASAPAGAR="'+VpfNomArquivo+'"'+ #13;
  Tabela.SaveToFile(VpfNomArquivo,dfXml);
  Tabela.Close;

  notCadastro.FieldByName('SEQESTAGIO').AsInteger := RSeqEstagioDisponivel(VpaCodFilial,VpaSeqNotaFiscal);

  NotCadastro.post;
  result := NotCadastro.AMensagemErroGravacao;
  Tabela.Close;
  NotCadastro.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.GeraNotaDevolucao(VpaNotas : TList;VpaDNotaFor : TRBDNotaFiscalFor) : string;
var
  VpfDNotaFiscal : TRBDNotaFiscal;
begin
  result := '';
  VpfDNotaFiscal := TRBDNotaFiscal(VpaNotas.Items[0]);
  VpaDNotaFor.CodFornecedor := VpfDNotaFiscal.CodCliente;
  VpaDNotaFor.CodTransportadora := VpfDNotaFiscal.CodTransportadora;
  VpaDNotaFor.DatEmissao := Date;
  VpaDNotaFor.CodVendedor := VpfDNotaFiscal.CodVendedor;
  VpaDNotaFor.PerComissao := VpfDNotaFiscal.PerComissao;

  AdicionaProdutoDevolucao(VpaNotas,VpaDNotaFor);
end;

{******************************************************************************}
procedure TFuncoesNFFor.GeraNotadosPedidos(VpaListaPedidos: TList; VpaDNota: TRBDNotaFiscalFor);
var
  VpfDPedidoCompra : TRBDPedidoCompraCorpo;
  VpfLaco : Integer;
begin
  for VpfLaco  := 0 to VpaListaPedidos.Count - 1 do
  begin
    VpfDPedidoCompra := TRBDPedidoCompraCorpo(VpaListaPedidos.Items[Vpflaco]);
    if VpfLaco = 0 then
    begin
      VpaDNota.CodFornecedor := VpfDPedidoCompra.CodCliente;
      VpaDNota.CodFormaPagamento := VpfDPedidoCompra.CodFormaPagto;
      VpaDNota.CodCondicaoPagamento := VpfDPedidoCompra.CodCondicaoPagto;
      VpaDNota.IndFreteEmitente := true;
    end;
    VpaDNota.ValFrete := VpaDNota.ValFrete + VpfDPedidoCompra.ValFrete;
  end;
  PreencheProdutosNotaPedido(VpaListaPedidos,VpaDNota);

end;

{******************************************************************************}
function TFuncoesNFFor.BaixaProdutosEstoque(VpaDNotaFor : TRBDNotaFiscalFor) :String;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfValDescontoNota : Double;
  VpfDItemNota : TRBDNotaFiscalForItem;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  VpaDNotaFor.IndGerouEstoqueChapa := false;
  if VpaDNotaFor.DNaturezaOperacao.IndBaixarEstoque then
  begin
    for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
    begin
      VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
      FunProdutos.AtualizaValorCusto(VpfDItemNota.SeqProduto,VpaDNotaFor.CodFilial,varia.MoedaBase,
                                     VpfDItemNota.UMOriginal,VpfDItemNota.um,VpaDNotaFor.DNaturezaOperacao.FuncaoOperacaoEstoque,
                                     VpfDItemNota.CodCor,VpfDItemNota.CodTamanho,VpfDItemNota.QtdProduto,VpfDItemNota.ValUnitario,VpaDNotaFor.ValTotal,VpaDNotaFor.ValFrete,
                                     VpfDItemNota.PerICMS,VpfDItemNota.PerIPI,VpaDNotaFor.ValDescontoCalculado,VpfDItemNota.ValST,VpaDNotaFor.IndFreteEmitente);
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,0,VpaDNotaFor.CodFilial,VpfDItemNota.SeqProduto);
      FunProdutos.BaixaProdutoEstoque( VpfDProduto, VpaDNotaFor.CodFilial, VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque,
                                       VpaDNotaFor.SeqNota, VpaDNotaFor.NumNota,0,varia.MoedaBase,VpfDItemNota.CodCor,VpfDItemNota.CodTamanho,
                                       Date, VpfDItemNota.QtdProduto,
                                       VpfDItemNota.ValTotal, VpfDItemNota.UM ,
                                       VpfDItemNota.DesNumSerie,true,VpfSeqEstoqueBarra,true,0,0,VpfDItemNota.QtdChapa,VpfDItemNota.LarChapa,
                                       VpfDItemNota.ComChapa);
      if VpfDProduto.IndGerouEstoqueChapa  then
        VpaDNotaFor.IndGerouEstoqueChapa := true;
      VpfDProduto.free;
    end;
  end;
  if result = '' then
    BaixaEstoqueFiscal(VpaDNotaFor);
end;

{******************************************************************************}
procedure TFuncoesNFFor.BaixaEstoqueFiscal(VpaDNotafor : TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDItem : TRBDNotaFiscalForItem;
begin
  if  VpaDNotafor.CodModeloDocumento <> '' then
  begin
    for VpfLaco := 0 to VpaDNotafor.ItensNota.Count - 1 do
    begin
      VpfDItem := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[vpfLaco]);
      FunProdutos.BaixaEstoqueFiscal(VpaDNotafor.CodFilial, VpfDItem.SeqProduto,VpfDItem.CodCor,VpfDItem.CodTamanho, VpfDItem.QtdProduto,VpfDItem.UM,VpfDItem.UMOriginal,'E');
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.GeraContasaPagar(VpaDNotaFor : TRBDNotaFiscalFor) :String;
var
  VpfDadoCP : TRBDContasaPagar;
begin
  result := '';
  if ConfigModulos.ContasAPagar then
  begin
    if (VpaDNotaFor.DNaturezaOperacao.IndFinanceiro) Then
    begin
      VpfDadoCP := TRBDContasaPagar.Cria;
      VpfDadoCP.CodFilial := VpaDNotaFor.CodFilial;
      VpfDadoCP.NumNota := VpaDNotaFor.NumNota;
      VpfDadoCP.SeqNota := VpaDNotaFor.SeqNota;
      VpfDadoCP.CodFornecedor := VpaDNotaFor.CodFornecedor;
      VpfDadoCP.CodFormaPagamento :=  VpaDNotaFor.CodFormaPagamento;
      VpfDadoCP.CodMoeda := varia.MoedaBase;
      VpfDadoCP.CodUsuario := varia.CodigoUsuario;
      VpfDadoCP.DatEmissao := VpaDNotaFor.DatEmissao;
      VpfDadoCP.CodPlanoConta := VpaDNotaFor.DNaturezaOperacao.CodPlanoContas;
      VpfDadoCP.DesPathFoto := '';
      VpfDadoCP.CodCondicaoPagamento := VpaDNotaFor.CodCondicaoPagamento;
      VpfDadoCP.PerDescontoAcrescimo := 0;
      VpfDadoCP.IndMostrarParcelas := true;
      VpfDadoCP.ValTotal := VpaDNotaFor.ValTotal;
      VpfDadoCP.ValParcela := VpaDNotaFor.ValTotal / Sistema.RQtdParcelasCondicaoPagamento(VpaDNotaFor.CodCondicaoPagamento);
      VpfDadoCP.DesTipFormaPagamento := VpaDNotaFor.TipFormaPagamento;
      VpfDadoCP.IndBaixarConta := FunContasAPagar.FlagBaixarContaFormaPagamento(VpaDNotaFor.CodFormaPagamento);
      VpfDadoCP.IndEsconderConta := (VpaDNotaFor.CodModeloDocumento = '');
      result := FunContasAPagar.CriaContaPagar( VpfDadoCP,nil);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.RValICMSFornecedor(VpaSigEstado : String) : Double;
var
  VpfEstado : String;
begin
  if VpaSigEstado = '' then
  begin
    erro('ICMS INTER-ESTADUAL NÃO CADASTRADO!!!!Não existe cadastrado o ICMS Inter-Estadual para o estado "'+VpaSigEstado+'".');
    VpfEstado := Varia.UFFilial;
  end
  else
    VpfEstado := VpaSigEstado;

  AdicionaSQLAbreTabela(Tabela,'Select * from CADICMSESTADOS '+
                            ' Where C_COD_EST = '''+ VpfEstado+''''+
                            ' and I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa));
  result := Tabela.FieldByName('N_ICM_EXT').AsFloat;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.ValidaMedicamentoControlado(VpaDNotaFor : TRBDNotaFiscalFor; VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
begin
  result := true;
  if VpaDItemNota.IndMedicamentoControlado then
  begin
    if VpaDItemNota.DesRegistroMSM = '' then
    begin
      aviso('REGISTRO DO MSM NÃO PREENCHIDO!!!'#13'Antes de comprar um produto controlado é necessário preencher no cadastro do produto o registro do MSM.');
      result := false;
    end;
    if result then
    begin
      if VpaDNotaFor.CGC_CPFFornecedor = '' then
      begin
        aviso('CNPJ FORNECEDOR NÃO PREENCHIDO!!!'#13'Antes de comprar um produto controlado é necessário preencher o CNPJ do fornecedor no cadastro de fornecedores.');
        result := false;
      end;
      if result then
      begin
        if VpaDNotaFor.CodFornecedor = 0 then
        begin
          aviso('FORNECEDOR NÃO PREENCHIDO!!!'#13'Antes de comprar um produto controlado é necessário preencher o fornecedor.');
          result := false;
        end;
        if result then
        begin
          if VpaDItemNota.CodPrincipioAtivo = 0 then
          begin
            result := false;
            aviso('PRINCIPIO ATIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o principio ativo do medicamento.');
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.PreparaEtiqueta(VpaDNotaFor : TRBDNotaFiscalFor;VpaPosInicial : Integer):string;
Var
  VpfSequencial, Vpflaco, VpfLacoQtd : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
begin
  result := '';
  VpfSequencial := 0;
  ExecutaComandoSql(Tabela,'Delete from ETIQUETAPRODUTO');
  AdicionaSQLAbreTabela(NotCadastro,'Select * from ETIQUETAPRODUTO');
  for vpfLaco := 1 to VpaPosInicial - 1 do
  begin
    inc(VpfSequencial);
    NotCadastro.Insert;
    NotCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
    NotCadastro.FieldByname('INDIMPRIMIR').AsString := 'N';
    NotCadastro.Post;
  end;

  for vpflaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    if VpfDItemNota.QtdEtiquetas > 0  then
    begin
      for VpfLacoQtd := 1 to RetornaInteiro(VpfDItemNota.QtdEtiquetas) do
      begin
        inc(VpfSequencial);
        NotCadastro.insert;
        NotCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
        NotCadastro.FieldByname('CODPRODUTO').AsString := VpfDItemNota.CodProduto;
        NotCadastro.FieldByname('NOMPRODUTO').AsString := VpfDItemNota.NomProduto;
        NotCadastro.FieldByname('CODTAMANHO').AsInteger := VpfDItemNota.CodTamanho;
        NotCadastro.FieldByname('NOMTAMANHO').AsString := VpfDItemNota.DesTamanho;
        NotCadastro.FieldByname('INDIMPRIMIR').AsString := 'S';
        NotCadastro.post;
        Result := NotCadastro.AMensagemErroGravacao;
        if NotCadastro.AErronaGravacao then
          exit;
      end;
    end;
  end;
  NotCadastro.close;
end;


{******************************************************************************}
function TFuncoesNFFor.ImprimeEtiquetaNota(VpaDNotaFor : TRBDNotaFiscalFor):string;
var
  VpfEtiquetas : TList;
  VpfDEtiquetas : TRBDEtiquetaProduto;
  VpfLacoNota : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
  VpfDProduto : TRBDProduto;
  VpfFunArgox : TRBFuncoesArgox;
  VpfFunZebra : TRBFuncoesZebra;
begin
  VpfEtiquetas := TList.create;
  VpfFunArgox := nil;
  VpfFunZebra := nil;
  for VpfLacoNota := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLacoNota]);
    if VpfDItemNota.QtdEtiquetas > 0 then
    begin
      VpfDEtiquetas := TRBDEtiquetaProduto.cria;
      VpfEtiquetas.Add(VpfDEtiquetas);
      VpfDProduto := TRBDProduto.cria;
      VpfDProduto.CodEmpresa := varia.CodigoEmpresa;
      VpfDProduto.CodEmpFil := varia.CodigoEmpFil;
      VpfDProduto.SeqProduto := VpfDItemNota.SeqProduto;
      FunProdutos.CarDProduto(VpfDProduto);
      VpfDEtiquetas.Produto := VpfDProduto;
      VpfDEtiquetas.CodCor := VpfDItemNota.CodCor;
      VpfDEtiquetas.NomCor := VpfDItemNota.DesCor;
      VpfDEtiquetas.QtdEtiquetas := VpfDItemNota.QtdEtiquetas;
      VpfDEtiquetas.NumPedido := VpaDNotaFor.NumNota;
    end;
  end;
  if VpfEtiquetas.Count > 0 then
  begin
    if varia.ModeloEtiquetaNotaEntrada in [2,3,4,10] then
      VpfFunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica)
    else
      if varia.ModeloEtiquetaNotaEntrada in [6] then
        VpfFunZebra := TRBFuncoesZebra.cria(Varia.PortaComunicacaoImpTermica,176,lzEPL)
      else
        if varia.ModeloEtiquetaNotaEntrada in [7] then
          VpfFunZebra := TRBFuncoesZebra.cria(Varia.PortaComunicacaoImpTermica,176,lzZPL);
    case varia.ModeloEtiquetaNotaEntrada of
      2: VpfFunArgox.ImprimeEtiquetaProduto50X25(VpfEtiquetas);
      3: VpfFunArgox.ImprimeEtiquetaKairosTexto(VpfEtiquetas);
      4: VpfFunArgox.ImprimeEtiquetaProduto54X28(VpfEtiquetas);
      6: VpfFunZebra.ImprimeEtiquetaProduto33X22(VpfEtiquetas);
      7: VpfFunZebra.ImprimeEtiquetaProduto33X57(VpfEtiquetas);
      10: VpfFunArgox.ImprimeEtiquetaProduto33X14(VpfEtiquetas);
    end;
    if VpfFunArgox <> nil then
      VpfFunArgox.free;
    if VpfFunZebra <> nil then
      VpfFunZebra.free;
  end;
  FreeTObjectsList(VpfEtiquetas);
  VpfEtiquetas.free;
end;

{******************************************************************************}
procedure TFuncoesNFFor.PreencheProdutosNotaPedido(VpaListaPedidos: TList; VpaDNota: TRBDNotaFiscalFor);
var
  VpfLacoPedidos,
  VpfLacoProdutosPedido: Integer;
  VpfDPedidoCompraCorpo: TRBDPedidoCompraCorpo;
  VpfDProdutoPedido: TRBDProdutoPedidoCompra;
  VpfDNotaItem: TRBDNotaFiscalForItem;
begin
  for VpfLacoPedidos:= 0 to VpaListaPedidos.Count-1 do
  begin
    VpfDPedidoCompraCorpo:= TRBDPedidoCompraCorpo(VpaListaPedidos.Items[VpfLacoPedidos]);
    if VpfLacoPedidos = 0 then
    begin
      VpaDNota.PerDesconto := VpfDPedidoCompraCorpo.PerDesconto;
      VpaDNota.ValDesconto := VpfDPedidoCompraCorpo.ValDesconto;
    end;
    for VpfLacoProdutosPedido:= 0 to VpfDPedidoCompraCorpo.Produtos.Count-1 do
    begin
      VpfDProdutoPedido:= TRBDProdutoPedidoCompra(VpfDPedidoCompraCorpo.Produtos.Items[VpfLacoProdutosPedido]);
      if (VpfDProdutoPedido.QtdProduto-VpfDProdutoPedido.QtdBaixado) > 0 then
      begin
        VpfDNotaItem:= RProdutoNota(VpaDNota, VpfDProdutoPedido);
        if VpfDNotaItem = nil then
        begin
          VpfDNotaItem:= VpaDNota.AddNotaItem;

          VpfDNotaItem.CodProduto:= VpfDProdutoPedido.CodProduto;
          ExisteProduto(VpfDProdutoPedido.CodProduto,VpfDNotaItem);
          VpfDNotaItem.SeqProduto:= VpfDProdutoPedido.SeqProduto;
          VpfDNotaItem.CodCor:= VpfDProdutoPedido.CodCor;
          VpfDNotaItem.NomProduto:= VpfDProdutoPedido.NomProduto;
          VpfDNotaItem.DesCor:= VpfDProdutoPedido.NomCor;
          VpfDNotaItem.UM:= VpfDProdutoPedido.DesUM;
          VpfDNotaItem.UMOriginal:= VpfDProdutoPedido.DesUM;
          VpfDNotaItem.UnidadeParentes.Free;
          VpfDNotaItem.UnidadeParentes:= FunProdutos.RUnidadesParentes(VpfDNotaItem.UMOriginal);
          VpfDNotaItem.DesReferenciaFornecedor:= VpfDProdutoPedido.DesReferenciaFornecedor;
          VpfDNotaItem.ValUnitario:= VpfDProdutoPedido.ValUnitario;
          VpfDNotaItem.LarChapa := VpfDProdutoPedido.LarChapa;
          VpfDNotaItem.ComChapa := VpfDProdutoPedido.ComChapa;
          VpfDNotaItem.QtdProduto := 0;
          VpfDNotaItem.PerIPI := VpfDProdutoPedido.PerIPI;
          VpfDNotaItem.CodClassificacaoFiscal := VpfDProdutoPedido.CodClassificacaoFiscal;
          VpfDNotaItem.CodClassificacaoFiscalOriginal := VpfDProdutoPedido.CodClassificacaoFiscal;
          VpfDNotaItem.ValNovoVenda :=  FunProdutos.ValorDeVenda(VpfDProdutoPedido.SeqProduto,varia.TabelaPreco,VpfDProdutoPedido.CodTamanho);
        end;
        // fazer o calculo de quanto eu posso utilizar de acordo com o QTDBAIXADO
        // este campo já está sendo carregado na rotina de carregar o pedido
        VpfDNotaItem.QtdProduto:= VpfDNotaItem.QtdProduto + (VpfDProdutoPedido.QtdProduto-VpfDProdutoPedido.QtdBaixado);
        VpfDNotaItem.QtdChapa:= VpfDNotaItem.QtdChapa + VpfDProdutoPedido.QtdChapa;
        VpfDNotaItem.QtdEtiquetas := RetornaInteiro(VpfDNotaItem.QtdProduto);
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.RCSTICMSProduto(VpaDCliente: TRBDCliente;VpaDProduto: TRBDProduto; VpaDNatureza: TRBDNaturezaOperacao): string;
begin
  result := IntToStr(VpaDProduto.NumOrigemProduto);
  if (VpaDNatureza.IndCalcularICMS) then
  begin
    if (VpaDProduto.IndSubstituicaoTributaria or (VpaDProduto.PerSubstituicaoTributaria > 0) ) and VpaDCliente.IndUFConvenioSubstituicaoTributaria then
    begin
      result := result +'10'
    end
    else
      if VpaDCliente.IndSimplesNacional then
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

{******************************************************************************}
function TFuncoesNFFor.RProdutoNota(VpaDNota: TRBDNotaFiscalFor; VpaDProdutoPedido: TRBDProdutoPedidoCompra): TRBDNotaFiscalForItem;
var
  VpfLaco: Integer;
  VpfDNotaItem: TRBDNotaFiscalForItem;
begin
  Result:= nil;
  for VpfLaco:= 0 to VpaDNota.ItensNota.Count-1 do
  begin
    VpfDNotaItem:= TRBDNotaFiscalForItem(VpaDNota.ItensNota.Items[VpfLaco]);
    if (VpaDProdutoPedido.SeqProduto = VpfDNotaItem.SeqProduto) and
       (VpaDProdutoPedido.CodCor = VpfDNotaItem.CodCor) and
       (VpaDProdutoPedido.LarChapa = VpfDNotaItem.LarChapa) and
       (VpaDProdutoPedido.ComChapa = VpfDNotaItem.ComChapa)  then
    begin
      Result:= VpfDNotaItem;
      Break;
    end;
  end;
end;

end.

