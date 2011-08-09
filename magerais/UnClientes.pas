Unit UnClientes;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, UnDados, UnDadosProduto, SysUtils,ComCtrls, UnTelemarketing, UnDadosCR,
     SQLExpr, Tabela,db, StdCtrls,DBClient, FunData, CAgenda;

//classe localiza
Type TRBLocalizaClientes = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesClientes = class(TRBLocalizaClientes)
  private
    CliAux,
    CliTabela : TSQLQuery;
    CliCadastro,
    CliCadastro2 : TSQL;
    VprHouveAlteracao: Boolean;
    procedure AtualizaStatusBar(VpaBarraStatus : TStatusBar; VpaTexto :String);
    function RValDuplicatasEmAtraso(VpaCodCliente :String) : Double;
    function RSeqAgendaDisponivel(VpaCodUsuario : Integer):Integer;
    function RSeqProdutoClienteDisponivel(VpaCodCliente : Integer) : Integer;
    function RCodClienteDisponivel : Integer;
    function RCodProdutoClientePecaDisponivel: integer;
    function RCodSuspectDisponivel : Integer;
    function RSeqLogCliente(VpaCodCliente : Integer) : integer;
    function RSeqClientePerdidovendedorDisponivel : Integer;
    function RSeqCreditoDisponivel(VpaCodCliente : Integer):Integer;
    function RUltimoSeqTelemarketing(VpaCodCliente : Integer) : Integer;
    function RQtdClienteVendedor(VpaCodVendedor : Integer) : Integer;
    function ClientePossuiContrato(VpaCodCliente : Integer):Boolean;
    function ExisteClienteWEG(VpaTabela : TDataSet;VpaCodFuncionario: Integer; VpaNomFuncionario : String) : Boolean;
    function ExisteProdutoCliente(VpaNumSerie : string; VpaCodCliente, VpaSeqProduto: Integer):boolean;
    function GravaDClientesPerdidoVendedorItem(VpaDClientePerdido : TRBDClientePerdidoVendedor):String;
    function GravaDClientesPerdidoVendedorCliente(VpaDClientePerdido : TRBDClientePerdidoVendedor) : String;
    function GravaDProspectDigitado(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):string;
    function AlteraDProspectDigitado(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):string;
    function GravaDSuspectDigitado(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):string;
    function AlteraClienteVendedor(VpaDClientePerdido : TRBDClientePerdidoVendedor):string;
    procedure AlteraSeqItemProdutoClienteDuplicado(VpaClienteNovo, VpaClienteAExcluir : Integer);
    function CadastraProdutoNumeroSerieCliente(VpaDatEmissao : TDateTime; VpaCodCliente, VpaSeqProduto,VpaQtdMesesGarantia : Integer;VpaNumSerie, VpaUM, VpaNomProduto : String; VpaProdutoPeca: TList):string;
    function AtualizaNumeroSerieProdutoCliente(VpaCodCliente : Integer;VpaDProChamado : TRBDChamadoProduto) : string;
    function AtualizaNumeroSerieProdutoContrato(VpaDProChamado : TRBDChamadoProduto) : string;
    function CarDTelemarketingProspect(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):TRBDTelemarketing;
    function CarDTelemarketingSuspect(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):TRBDTelemarketingProspect;
    function RProdutoCliente(VpaProdutoCliente: TList; VpaSeqProduto: Integer; VpaNumSerie: String): TRBDProdutoCliente;
    procedure ExcluiClientePRODUTOFORNECEDOR(VpaCodClienteAExcluir,VpaCodClienteHistorico : Integer);
    procedure ExcluiClienteORCAMENTOCOMPRAFORNECEDOR(VpaCodClienteAExcluir,VpaCodClienteHistorico : Integer);
    procedure AdicionaTelefoneCliente(VpaArquivo : TStringList;VpaCodCliente : Integer;VpaUF, VpaTelefone,VpaNomCliente : string;VpaIndInadimplente, VpaIndFimVigencia : Boolean);
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    function ApagaVisitaCliente(VpaSeqVisita: Integer): String;
    function AtualizaProspectCliente(VpaDCliente: TRBDCliente; VpaCodProspect: Integer): String;
    function CarDCliente(VpaDCliente : TRBDCliente;VpaFornecedor : Boolean = false;VpaExigirCPFCNPJ : Boolean = true;VpaValidarDadosNFE : Boolean = false) :String;
    procedure CarProdutoInteresseCliente(VpaProdutos : TList;VpaCodCliente : Integer);
    function REmailContatoCliente(VpaCodCliente: Integer; var VpaNomContato: String): String; overload;
    function REmailContatoCliente(VpaCodCliente: Integer): String; overload;
    function RDatUltimoPedido(VpaCodCliente : String):TDateTime;
    function RQtdClientes(VpaCodSituacao : String) : Integer;
    function RNomCliente(VpaCodCliente : String) : String;
    function RNomeFantasia(VpaCodCliente : Integer) : String;
    function RNomTranpostadora(VpaCodTransportadora : Integer) : String;
    function RNomProfissao(VpaCodProfissao : Integer) : string;
    function RNomRamoAtividade(VpaCodRamoAtividade : Integer):string;
    function REmailCliente(VpaCodcliente : Integer) : String;
    function RSeqTarefaDisponivel : Integer;
    function RSeqContatoDisponivel(VpaCodCliente: Integer): Integer;
    function RSeqTarefaEMarketingDisponivel: Integer;
    function RSeqVisitaDisponivel: Integer;
    function RCodRegiaVendas(VpaCep : String):Integer;
    function RCodPais(VpaUF : String):Integer;
    function RNomPais(VpaCodPais : Integer) : String;
    function RCodCidade(VpaNomCidade, VpaDesUF : String ):integer;
    procedure ExcluiCliente(VpaCodClienteAExcluir,VpaCodClienteHistorico : Integer;VpaBarraStatus : TStatusBar);
    procedure ExcluiSuspect(VpaCodSuspect : Integer);
    procedure ExcluiClientesRamoAtividade(VpaCodRamoAtividade : integer);
    function RDDDCliente(VpaNumTelefone : String ):String;
    function RTelefoneSemDDD(VpaNumTelefone : String):String;
    function RCGCCPFCliente(VpaCodCliente : Integer) : String;
    function RValDeslocamentoCliente(VpaNomCidade : String):Double;
    function RUFCliente(VpaCodCliente : Integer):String;
    function RCodCliente(VpaNomCliente : string) : Integer;
    function RCodClientePeloTelefone(VpaDesTelefone : string):Integer;
    function RCodClientePelaIdentificaoBancaria(VpaDesIdentificacaoBancaria : String) : Integer;
    function RValemAbertoClienteCorrigido(VpaCodCliente : Integer) : Double;
    function RPerICMSUF(VpaCodEstado : string):Double;
    function RQtdCodigosClientes : Integer;
    function RProximoCodClienteRepresentanteDisponivel : Integer;
    function GravaDBrinde(VpaCodCliente : Integer;VpaBrindes : TList):String;
    function VerificaAtualizaContatoCliente(VpaCodCliente: Integer; VpaDCliente: TRBDCliente; VpaNomContato, VpaDesEMailContato: String): String;
    function GravaDContatos(VpaCodCliente: Integer; VpaContatos: TList): String;
    function GravaDContato(VpaCodCliente: Integer; VpaDContatoCliente: TRBDContatoCliente): String;
    function GravaDProdutosReserva(VpaCodCliente: Integer; VpaProdutosReserva: TList): String;
    function GravadProdutoInteresseCliente(VpaCodCliente : Integer;VpaProdutos : TList):string;
    function ExisteProfissao(VpaCodProfissao: Integer): Boolean;
    function ExisteTransportadora(VpaCodTransportadora: Integer): Boolean;
    function ExisteFaixaEtaria(VpaCodFaixaEtaria : Integer;Var VpaNomFaixaEtaria : string):Boolean;
    function ExisteCliente(VpaCodCliente: Integer): Boolean;
    function GravaDProdutoCliente(VpaCodCliente : Integer;VpaProdutos : TList):String;
    function GravaDProdutoClienteNota(VpaCodCliente : Integer;VpaProdutos : TList):String;
    function GravaDProdutoClientePeca(VpaDProdutoCliente: TRBDProdutoCliente): String;
    function AdicionaProdutoCliente(VpaCodCliente,VpaSeqProduto : Integer;VpaCodProduto, VpaUM : String):string;
    function GravaDAgenda(VpaDAgenda : TRBDAgendaSisCorp): String;
    function GravaDTarefa(VpaDTarefa : TRBDTarefa): String;
    function GravaDAgendaCliente(VpaDAgendaCliente: TRBDAgendaCliente): String;
    function GravaDParentes(VpaCodCliente : Integer;VpaParentes : TList):String;
    function GravaDDigitacaoProspect(VpaDDigProspect : TRBDDigitacaoProspect) :string;
    function AlteraDDigitacaoProspect(VpaDDigProspect : TRBDDigitacaoProspect) :string;
    function GravaCreditoCliente(VpaCodCliente : Integer;VpaCreditos : TList):string;
    function GravaDFaixaEtariaCliente(VpaCodCliente : Integer;VpaFaixasEtaria : TList):string;
    function GravaDMarcaCliente(VpaCodCliente : Integer;VpaMarcas : TList):string;
    function GravaLogCliente(VpaCodCliente:Integer):string;
    function AtivarEmailCliente(VpaCodCliente: Integer; VpaAtivar: Boolean = True): String;
    function AtivarEmailContatoCliente(VpaCodCliente, VpaSeqContato: Integer; VpaAtivar: Boolean = True): String;
    function AlteraEmailCliente(VpaCodCliente: Integer; VpaEmail: String): String;
    function AlteraEmailContatoCliente(VpaCodCliente, VpaSeqContato: Integer; VpaEmail: String): String;
    function AlteraEstagioAgenda(VpaDAgenda : TRBDAgendaSisCorp;VpaCodEstagio : Integer) : string;
    procedure AlteraObservacaoCliente(VpaCodCliente : Integer;VpaDesObservacao : String);
    procedure AlteraDatUltimoEmail(VpaCodCliente : Integer;VpaData : TDateTime);
    function AlteraDatUltimaCompra(VpaCodCliente: Integer; VpaData: TDateTime): String;
    function AlteraDatUltimoRecebimento(VpaCodCliente: Integer; VpaData: TDateTime): String;
    procedure AlterarObsLigacao(VpaCodCliente : Integer;VpaDesObservacao : String);
    function SetaAgendaConcluida(VpaCodUsuario,VpaSeqAgenda : Integer) : String;
    function SetaClienteComoFornecedor(VpaCodCliente : Integer):string;
    function CancelaAgendamento(VpaCodUsuario,VpaSeqAgenda : Integer) : String;
    function ExtornaAgendamento(VpaCodUsuario,VpaSeqAgenda : Integer) : String;
    procedure CarDBrinde(VpaCodCliente : Integer;VpaBrindes : TList);
    procedure CarDProdutoReserva(VpaCodCliente: Integer; VpaProdutosReserva: TList);
    procedure CarDProdutoCliente(VpaCodCliente : Integer;VpaProdutos : TList);
    procedure CarDProdutoClientePeca(VpaDProdutoCliente: TRBDProdutoCliente);
    procedure CarDContatoCliente(VpaCodCliente: Integer; VpaContatos: TList);
    procedure CarDAgenda(VpaCodUsuario,VpaSeqAgenda : Integer;VpaDAgenda : TRBDAgendaSisCorp);
    procedure CarDParenteCliente(VpaCodCliente : Integer;VpaParentes : TList);
    procedure CarDVisitaCliente(VpaSeqVisita: Integer; VpaDVisitaCliente: TRBDAgendaCliente);
    procedure CarCreditoCliente(VpaCodCliente : Integer;VpaCreditos : TList;VpaSomenteAtivos :Boolean; VpaTipo : TRBDTipoCreditoDebito);
    procedure CarDComprador(VpaDComprador : TRBDComprador;VpaCodComprador : Integer);
    procedure CarDFaixaEtaria(VpaCodCliente : Integer; VpaFaixasEtaria : TList);
    procedure CarDMarca(VpaCodCliente : Integer;VpaMarcas : TList);
    function ExisteContatoCliente(VpaCodCliente: Integer): Boolean; overload;
    function ExisteContatoCliente(VpaCodCliente: Integer; VpaDesEMail: String): Boolean; overload;
    function ExisteContatoCliente(VpaCodCliente: Integer; VpaNomContato: String; var VpaEMail: String): Boolean; overload;
    function AtualizaContatoCliente(VpaCodCliente: Integer; VpaNomContato: String): String;
    function AtualizaCliente(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String; overload;
    function AtualizaCliente(VpaCodCliente: Integer; VpaDCliente: TRBDCliente): String; overload;
    function AtualizaCliente(VpaDCliente: TRBDCliente;VpaDContasAPagar : TRBDContasaPagar): String; overload;
    function BaixaEstoqueBrinde(VpaCodCliente, VpaSeqProduto : integer;VpaQtdProduto : Double;VpaUM : String;VpaIndSaidaEstoque : Boolean):String;
    procedure AtualizaCodCidadeCliente(VpaCodCliente, VpaCodCidade : Integer);
    procedure AtualizaCodPaisCliente(VpaCodCliente, VpaCodPais : Integer);
    function ImportaClientesWeg(VpaNomArquivo : String; VpaBarraStatus : TStatusBar;VpaProgresso : TProgressBar) : String;
    function ImportaProdutosProspect(VpaCodProspect, VpaCodCliente: Integer): String;
    function ImportaContatosProspect(VpaCodProspect, VpaCodCliente: Integer): String;
    function ImportaTelemarketingProspect(VpaCodProspect, VpaCodCliente: Integer): String;
    function ImportaVisitaProspect(VpaCodProspect, VpaCodCliente : Integer):string;
    function AdicionaEmailContatoCliente(VpaCodCliente : Integer; VpaDesEmail, VpaDesObservacoes : String):String;
    function GravaDClientePerdido(VpaDClientePerdido : TRBDClientePerdidoVendedor):string;
    function ProdutoInteresseDuplicado(VpaProdutos : TList):Boolean;
    function FaixaEtariaDuplicada(VpaFaixasEtaria : TList):Boolean;
    function MarcaDuplicada(VpaMarcas : TList):Boolean;
    function CadastraProdutosCliente(VpaDCotacao : TRBDOrcamento) : string;overload;
    function CadastraProdutosCliente(VpaDNota : TRBDNotaFiscal) : string;overload;
    function CadastraReferenciaCliente(VpaDCotacao : TRBDOrcamento) : string;
    function AtualizaNumeroSerieProdutoChamado(VpaDChamado : TRBDChamado) : string;
    function AdicionaCredito(VpaCodCliente : Integer;VpaValor : Double;VpaTipCredito, VpaDesObservacao : String):String;
    function DiminuiCredito(VpaCodCliente : Integer;VpaValor : Double;VpaTipo : TRBDTipoCreditoDebito):String;
    function GeraCodigosClientes(VpaRegistro : TProgressBar; VpaLabel: TLabel) : string;
    procedure IncluiCodigoCliente(VpaCodCliente : Integer);
    function DadosSpedClienteValido(VpaDCliente : TRBDCliente):string;
    function ExisteAgendamentoEmAberto(VpaCodCliente : Integer) : boolean;
    procedure AlteraVendedorCadastroCliente(VpaCodVendedorOrigem, VpaCodVendedorDestino : Integer);
    procedure BloqueiaClientesAtrasados;
    function VerificaseClienteEstaBloqueado(VpaCodCliente: Integer):Boolean;
    function DesbloqueiaClienteAtrasado(VpaCodCliente: Integer): string;
    function RSeHouveAlteracaoDigitacaoProspect(VpaDProspect: TRBDDigitacaoProspectItem): Boolean;
    function RQtdEstados(VpaNomCidade : string) : Integer;
    procedure GeraArquivoURA(VpaNomArquivo : string);
    function RSeProdutoEDoCliente(VpaCodCliente, VpaSeqProduto: Integer): boolean;
    function RSeqDisponivelAlteraClienteVendedor: integer;
    function AdicionaEmailNfeCliente(VpaEmail:String):String;
end;

Var
  FunClientes : TRBFuncoesClientes;



implementation

Uses FunSql, Constantes, ConstMsg, FunString, FunValida, FunObjeto, UnProdutos,
     UnProspect, UnContasAReceber, funArquivos, UnSistema;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaClientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaClientes.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesClientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesClientes.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  CliAux := TSQLQUERY.Create(nil);
  CliAux.SQLConnection := VpaBaseDados;
  CliTabela := TSQLQUERY.Create(nil);
  CliTabela.SQLConnection := VpaBaseDados;
  CliCadastro := TSQL.Create(nil);
  Clicadastro.ASQLConnection := VpaBaseDados;
  CliCadastro.PacketRecords := 20;
  CliCadastro2 := TSQL.Create(nil);
  Clicadastro2.ASQLConnection := VpaBaseDados;
  CliCadastro2.PacketRecords := 20;

end;

{******************************************************************************}
function TRBFuncoesClientes.DadosSpedClienteValido(VpaDCliente: TRBDCliente): string;
begin
  result := '';
  if (config.EmiteNFe) or (config.EmiteSped)  then
  begin
    if VpaDCliente.CGC_CPF = '' then
      result := 'CNPJ/CPF DO CLIENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o CNPJ/CPF do cliente.'
    else
    if VpaDCliente.DesEndereco = '' then
      result := 'ENDEREÇO DO CLIENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o endereço do cliente.';
    if Result = '' then
    begin
      if DeletaChars(DeletaChars(VpaDCliente.CepCliente,' '),'-') = '' then
        result := 'CEP DO CLIENTE NÃO PREENCHIDO!!!!'#13'É necessário preencher o CEP do cliente.';
      if Result = '' then
      begin
        if VpaDCliente.DesBairro = '' then
          result := 'BAIRRO DO CLIENTE NÃO PREENCHIDO!!!!'#13'É necessário preencher o bairro do cliente.';
        if Result = '' then
        begin
          if VpaDCliente.CodIBGECidade = 0 then
            result := 'CODIGO IBGE DA CIDADE NÃO PREENCHIDA!!!!'#13'É necessário preencher o codigo do IBGE da Cidade do cliente.';
          if Result = '' then
          begin
            if VpaDCliente.CodPais = 0 then
              result := 'CODIGO IBGE DO PAIS NÃO PREENCHIDO!!!!'#13'É necessário preencher o codigo do IBGE do pais do cliente.';
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.DesbloqueiaClienteAtrasado(VpaCodCliente: Integer):string;
begin
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM CADCLIENTES ' +
                           ' WHERE I_COD_CLI = ' + IntToStr(VpaCodCliente));
  CliCadastro.Edit;
  CliCadastro.FieldByName('C_IND_BLO').AsString := 'N';
  CliCadastro.FieldByName('D_DAT_ALT').AsDateTime := Sistema.RDataServidor;
  CliCadastro.Post;
  result := CliCadastro.AMensagemErroGravacao;
  CliCadastro.Close;
  Sistema.MarcaTabelaParaImportar('CADCLIENTES');
end;

{******************************************************************************}
destructor TRBFuncoesClientes.destroy;
begin
  CliTabela.free;
  CliAux.free;
  CliCadastro.free;
  CliCadastro2.Free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AtualizaStatusBar(VpaBarraStatus : TStatusBar; VpaTexto :String);
begin
  VpaBarraStatus.Panels[0].Text := VpaTexto;
  VpaBarraStatus.Refresh;
end;
         
{******************************************************************************}
function TRBFuncoesClientes.RValDuplicatasEmAtraso(VpaCodCliente :String) : Double;
begin
  CliAux.Sql.Clear;
  CliAux.Sql.Add('select SUM(MOV.N_VLR_PAR) VALOR from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV ' +
                               ' where CAD.i_cod_cli = '+VpaCodCliente+
                               ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                               ' AND MOV.D_DAT_VEN < '+SQLTextoDataAAAAMMMDD(DecDia(Date,2))+
                               ' AND MOV.D_DAT_PAG IS NULL '+
                               ' AND MOV.C_FUN_PER = ''N''');
  CliAux.Open;
  result := CliAux.FieldByName('VALOR').AsFloat;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeHouveAlteracaoDigitacaoProspect(
  VpaDProspect: TRBDDigitacaoProspectItem): Boolean;
begin
  if (VpaDProspect.DesEndereco <> VpaDProspect.DesEnderecoAnterior) or
     (VpaDProspect.DesBairro <> VpaDProspect.DesBairroAnterior) or
     (VpaDProspect.DesEmail <> VpaDProspect.DesEmailAnterior) or
     (VpaDProspect.DesFone <> VpaDProspect.DesFoneAnterior) or
     (VpaDProspect.DesCelular <> VpaDProspect.DesCelularAnterior) then
    Result:= True
  else
    Result:= False;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeProdutoEDoCliente(VpaCodCliente,
  VpaSeqProduto: Integer): boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'Select SEQPRODUTO, CODCLIENTE from PRODUTOCLIENTE '+
                               ' Where CODCLIENTE = '+IntToStr(VpaCodCliente)+
                               ' AND SEQPRODUTO = ' + IntToStr(VpaSeqProduto));
  if CliAux.Eof then
    Result:= False
  else
    Result:= true;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqAgendaDisponivel(VpaCodUsuario : Integer):Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQAGENDA) ULTIMO from AGENDA '+
                               ' Where CODUSUARIO = '+IntToStr(VpaCodUsuario));
  result := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqProdutoClienteDisponivel(VpaCodCliente : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQITEM) Ultimo FROM PRODUTOCLIENTE '+
                               ' Where CODCLIENTE = ' +IntToStr(VpaCodCliente));
  result := CliAux.FieldByName('Ultimo').AsInteger + 1;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodClienteDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select max(I_COD_CLI) ULTIMO from CADCLIENTES');
  Result := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodSuspectDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select max(CODPROSPECT) ULTIMO from PROSPECT');
  Result := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqClientePerdidovendedorDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select max(SEQPERDIDO) ULTIMO from CLIENTEPERDIDOVENDEDOR ');
  result := CliAux.FieldByname('ULTIMO').AsInteger + 1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqCreditoDisponivel(VpaCodCliente : Integer):Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select Max(SEQCREDITO) ULTIMO from CREDITOCLIENTE '+
                               ' Where CODCLIENTE = ' +IntToStr(VpaCodCliente));
  result := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqDisponivelAlteraClienteVendedor: integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQITEM) ULTIMO from ALTERACLIENTEVENDEDOR ');
  result := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqLogCliente(VpaCodCliente: Integer): integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQLOG) ULTIMO from CLIENTELOG ' +
                               ' Where CODCLIENTE = ' + IntToStr(VpaCodCliente));
  result := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RUltimoSeqTelemarketing(VpaCodCliente : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQTELE) ULTIMO from TELEMARKETING '+
                               ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  Result := CliAux.FieldByName('ULTIMO').AsInteger+1;
end;

{******************************************************************************}
function TRBFuncoesClientes.RQtdClienteVendedor(VpaCodVendedor : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select Count(I_COD_CLI) QTD from CADCLIENTES ' +
                               ' Where I_COD_VEN = '+IntToStr(VpaCodVendedor));
  result := CliAux.FieldByname('QTD').AsInteger;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RQtdCodigosClientes: Integer;
begin
  AdicionaSqlAbreTabela(CliAux,'Select COUNT(*) QTD FROM CODIGOCLIENTE');
  result := CliAux.FieldByName('QTD').AsInteger;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RQtdEstados(VpaNomCidade: string): Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select count(*) QTD from CAD_CIDADES ' +
                               ' WHERE DES_CIDADE = '''+VpaNomCidade+'''');
  Result := CliAux.FieldByName('QTD').AsInteger;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ClientePossuiContrato(VpaCodCliente : Integer):Boolean;
begin
  result := false;
  AdicionaSqlAbreTabela(CliAux,'Select * from CONTRATOCORPO '+
                               ' Where CODCLIENTE = '+IntTostr(VpaCodCliente));
  while not CliAux.Eof do
  begin
    if CliAux.FieldByName('DATCANCELAMENTO').IsNull then
    begin
      CliAux.close;
      EXIT(true);
    end;
    CliAux.Next;
  end;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteClienteWEG(VpaTabela : TDataset;VpaCodFuncionario: Integer; VpaNomFuncionario : String) : Boolean;
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CADCLIENTES ' +
                                  ' Where C_NOM_CLI = ''' +VpaNomFuncionario+
                                  ''' or I_COD_WEG = '+IntTostr(VpaCodFuncionario));
  result := not VpaTabela.Eof;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteProdutoCliente(VpaNumSerie : string; VpaCodCliente, VpaSeqProduto: Integer):boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'Select * from PRODUTOCLIENTE '+
                               ' Where NUMSERIE = '''+VpaNumSerie+'''' +
                               ' AND SEQPRODUTO = ' + IntToStr(VpaSeqProduto)+
                               ' AND CODCLIENTE = ' + IntToStr(VpaCodCliente));
  result := not CliAux.eof;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDClientesPerdidoVendedorItem(VpaDClientePerdido : TRBDClientePerdidoVendedor):String;
Var
  VpfItem : Integer;
begin
  result := '';
  VpfItem := 1;
  CliTabela.sql.clear;
  CliTabela.sql.add('select I_COD_VEN, COUNT(I_COD_CLI) QTD from CADCLIENTES CLI '+
                                  ' WHERE CLI.I_COD_VEN <> '+IntToStr(VpaDClientePerdido.CodVendedorDestino)+
                                  SQLFiltroCliente('CLI',VpaDClientePerdido.IndCliente,VpaDClientePerdido.IndProspect));
  if VpaDClientePerdido.QtdDiasSemPedido <> 0 then
    CliTabela.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasSemPedido)+
                      ' and NOT EXISTS(select * from CADORCAMENTOS ORC '+
                      '       Where ORC.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasSemPedido))+
                      '       AND ORC.I_COD_CLI = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.QtdDiasComPedido <> 0 then
    CliTabela.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasComPedido)+
                      ' and EXISTS(select * from CADORCAMENTOS ORC '+
                      '       Where ORC.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasComPedido))+
                      '       AND ORC.I_COD_CLI = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.QtdDiasSemTelemarketing <> 0 then
    CliTabela.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasSemTelemarketing)+
                      ' and NOT EXISTS(select * from TELEMARKETING TEL  '+
                      '       Where TEL.DATLIGACAO >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasSemTelemarketing))+
                      '       AND TEL.CODCLIENTE = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.CodRegiaoVendas <> 0 then
    CliTabela.sql.add(' and CLI.I_COD_REG = '+IntToStr(VpaDClientePerdido.CodRegiaoVendas));
  CliTabela.sql.add(' GROUP BY I_COD_VEN ');
  CliTabela.open;
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CLIENTEPERDIDOVENDEDORITEM');
  while not CliTabela.eof do
  begin
    CliCadastro.insert;
    CliCadastro.FieldByname('SEQPERDIDO').AsInteger := VpaDClientePerdido.SeqPerdido;
    CliCadastro.FieldByname('SEQITEM').AsInteger := VpfItem;
    if CliTabela.FieldByname('I_COD_VEN').AsInteger <> 0 then
      CliCadastro.FieldByname('CODVENDEDOR').AsInteger := CliTabela.FieldByname('I_COD_VEN').AsInteger;
    CliCadastro.FieldByname('QTDCLIENTE').AsInteger := RQtdClienteVendedor(CliTabela.FieldByname('I_COD_VEN').AsInteger);
    CliCadastro.FieldByname('QTDCLIENTEPERDIDO').AsInteger := CliTabela.FieldByname('QTD').AsInteger;
    CliCadastro.post;
    result := CliCadastro.AMensagemErroGravacao;
    if result <> '' then
      CliTabela.last;
    inc(VpfItem);
    CliTabela.next;
  end;
  CliTabela.Close;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDClientesPerdidoVendedorCliente(VpaDClientePerdido : TRBDClientePerdidoVendedor) : String;
var
  VpfItem : Integer;
begin
  result := '';
  VpfItem := 1;
  CliTabela.sql.clear;
  CliTabela.sql.add('select I_COD_VEN, I_COD_CLI from CADCLIENTES CLI '+
                                  ' WHERE CLI.I_COD_VEN <> '+IntToStr(VpaDClientePerdido.CodVendedorDestino)+
                                  SQLFiltroCliente('CLI',VpaDClientePerdido.IndCliente,VpaDClientePerdido.IndProspect));

  if VpaDClientePerdido.QtdDiasSemPedido <> 0 then
    CliTabela.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasSemPedido)+
                      ' and NOT EXISTS(select * from CADORCAMENTOS ORC '+
                      '       Where ORC.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasSemPedido))+
                      '       AND ORC.I_COD_CLI = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.QtdDiasComPedido <> 0 then
    CliTabela.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasComPedido)+
                      ' and EXISTS(select * from CADORCAMENTOS ORC '+
                      '       Where ORC.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasComPedido))+
                      '       AND ORC.I_COD_CLI = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.QtdDiasSemTelemarketing <> 0 then
    CliTabela.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasSemTelemarketing)+
                      ' and NOT EXISTS(select * from TELEMARKETING TEL  '+
                      '       Where TEL.DATLIGACAO >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasSemTelemarketing))+
                      '       AND TEL.CODCLIENTE = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.CodRegiaoVendas <> 0 then
    CliTabela.sql.add(' and CLI.I_COD_REG = '+IntToStr(VpaDClientePerdido.CodRegiaoVendas));
  CliTabela.open;

  AdicionaSQLAbreTabela(CliCadastro,'Select * from CLIENTEPERDIDOVENDEDORCLIENTE');
  while not CliTabela.eof do
  begin
    CliCadastro.insert;
    CliCadastro.FieldByname('SEQPERDIDO').AsInteger := VpaDClientePerdido.SeqPerdido;
    CliCadastro.FieldByname('SEQITEM').AsInteger := VpfItem;
    if CliTabela.FieldByname('I_COD_VEN').AsInteger <> 0 then
      CliCadastro.FieldByname('CODVENDEDOR').AsInteger := CliTabela.FieldByname('I_COD_VEN').AsInteger;
    CliCadastro.FieldByname('CODCLIENTE').AsInteger := CliTabela.FieldByname('I_COD_CLI').AsInteger;
    CliCadastro.post;
    result := CliCadastro.AMensagemErroGravacao;
    if result <> '' then
      CliTabela.last;
    inc(VpfItem);
    CliTabela.next;
  end;
  CliTabela.Close;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDProspectDigitado(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):string;
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES  ' +
                                    ' Where I_COD_CLI = 0');
  CliCadastro.Insert;
  cliCadastro.FieldByName('C_NOM_CLI').AsString := VpaDProspect.NomProspect;
  cliCadastro.FieldByName('C_NOM_FAN').AsString := VpaDProspect.NomProspect;
  cliCadastro.FieldByName('D_DAT_CAD').AsDateTime := date;
  cliCadastro.FieldByName('D_DAT_ALT').AsDateTime := date;
  cliCadastro.FieldByName('C_END_CLI').AsString := VpaDProspect.DesEndereco;
  cliCadastro.FieldByName('C_BAI_CLI').AsString := VpaDProspect.DesBairro;
  cliCadastro.FieldByName('C_EST_CLI').AsString := VpaDProspect.DesUF;
  cliCadastro.FieldByName('C_CID_CLI').AsString := VpaDProspect.DesCidade;
  cliCadastro.FieldByName('C_FO1_CLI').AsString := VpaDProspect.DesFone;
  cliCadastro.FieldByName('C_FON_CEL').AsString := VpaDProspect.DesCelular;
  cliCadastro.FieldByName('C_CON_CLI').AsString := VpaDProspect.NomContato;
  cliCadastro.FieldByName('C_END_ELE').AsString := VpaDProspect.DesEmail;
  cliCadastro.FieldByName('I_COD_SIT').AsInteger := varia.SituacaoPadraoCliente;
  cliCadastro.FieldByName('I_COD_VEN').AsInteger := VpaDDigProspect.CodVendedor;
  if VpaDProspect.CodRamoAtividade <> 0 then
    cliCadastro.FieldByName('I_COD_RAM').AsInteger := VpaDProspect.CodRamoAtividade;
  cliCadastro.FieldByName('C_TIP_PES').AsString := 'J';
  cliCadastro.FieldByName('C_ACE_SPA').AsString := 'S';
  cliCadastro.FieldByName('C_IND_REV').AsString := 'N';
  cliCadastro.FieldByName('C_ACE_TEL').AsString := 'S';
  cliCadastro.FieldByName('C_IND_CRA').AsString := 'N';
  cliCadastro.FieldByName('C_IND_AGR').AsString := 'N';
  cliCadastro.FieldByName('C_IND_CON').AsString := 'N';
  cliCadastro.FieldByName('C_IND_SER').AsString := 'N';
  cliCadastro.FieldByName('C_IND_PRO').AsString := 'S';
  cliCadastro.FieldByName('C_IND_BLO').AsString := 'N';
  cliCadastro.FieldByName('C_COB_FRM').AsString := 'N';
  cliCadastro.FieldByName('C_IND_CLI').AsString := 'N';
  cliCadastro.FieldByName('C_IND_FOR').AsString := 'N';
  cliCadastro.FieldByName('C_IND_PRC').AsString := 'S';
  cliCadastro.FieldByName('C_IND_TRA').AsString := 'N';
  cliCadastro.FieldByName('C_EMA_INV').AsString := 'N';
  cliCadastro.FieldByName('C_EXP_EFI').AsString := 'N';
  cliCadastro.FieldByName('C_IND_HOT').AsString := 'N';
  cliCadastro.FieldByName('C_IND_ATI').AsString := 'S';
  cliCadastro.FieldByName('C_IND_VIS').AsString := 'S';
  cliCadastro.FieldByName('C_TIP_FAT').AsString := 'N';
  cliCadastro.FieldByName('C_DES_ISS').AsString := 'N';
  cliCadastro.FieldByName('C_FIN_CON').AsString := 'S';
  cliCadastro.FieldByName('C_ENV_ROM').AsString := 'N';
  cliCadastro.FieldByName('C_IND_LOC').AsString := 'R';
  cliCadastro.FieldByName('C_TIP_LOC').AsString := 'C';
  cliCadastro.FieldByName('C_DES_ICM').AsString := 'S';
  cliCadastro.FieldByName('C_OPT_SIM').AsString := 'N';
  cliCadastro.FieldByName('C_IND_BUM').AsString := 'N';
  cliCadastro.FieldByName('C_IND_CBA').AsString := 'N';

  cliCadastro.FieldByName('I_PRC_MDV').AsInteger := varia.CodMeioDivulgacaoVisitaVendedor;
  VpaDProspect.CodProspect := RCodClienteDisponivel;
  CliCadastro.FieldByName('I_COD_USU').AsInteger := Varia.CodigoUsuario;
  CliCadastro.FieldByName('I_COD_CLI').AsInteger := VpaDProspect.CodProspect;
  CliCadastro.post;
  result := CliCadastro.AMensagemErroGravacao;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDSuspectDigitado(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):string;
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from PROSPECT ');
  CliCadastro.Insert;
  cliCadastro.FieldByName('NOMPROSPECT').AsString := VpaDProspect.NomProspect;
  cliCadastro.FieldByName('NOMFANTASIA').AsString := VpaDProspect.NomProspect;
  cliCadastro.FieldByName('DESENDERECO').AsString := VpaDProspect.DesEndereco;
  cliCadastro.FieldByName('DESBAIRRO').AsString := VpaDProspect.DesBairro;
  cliCadastro.FieldByName('DESCIDADE').AsString := VpaDProspect.DesCidade;
  cliCadastro.FieldByName('DESUF').AsString := VpaDProspect.DesUF;
  cliCadastro.FieldByName('DESFONE1').AsString := VpaDProspect.DesFone;
  cliCadastro.FieldByName('DESFONE2').AsString := VpaDProspect.DesCelular;
  cliCadastro.FieldByName('NOMCONTATO').AsString := VpaDProspect.NomContato;
  cliCadastro.FieldByName('DESEMAILCONTATO').AsString := VpaDProspect.DesEmail;
  cliCadastro.FieldByName('INDACEITASPAM').AsString := 'S';
  if VpaDProspect.CodRamoAtividade <> 0 then
    cliCadastro.FieldByName('CODRAMOATIVIDADE').AsInteger := VpaDProspect.CodRamoAtividade;
  cliCadastro.FieldByName('INDACEITATELEMARKETING').AsString := 'S';
  cliCadastro.FieldByName('CODUSUARIO').AsInteger := varia.CodigoUsuario;
  cliCadastro.FieldByName('DATCADASTRO').AsDateTime := date;
  cliCadastro.FieldByName('CODMEIODIVULGACAO').AsInteger := varia.CodMeioDivulgacaoVisitaVendedor;
  cliCadastro.FieldByName('CODVENDEDOR').AsInteger := VpaDDigProspect.CodVendedor;
  cliCadastro.FieldByName('INDCONTATOVENDEDOR').AsString := 'S';
  cliCadastro.FieldByName('INDEMAILINVALIDO').AsString := 'N';
  cliCadastro.FieldByName('INDEXPORTADO').AsString := 'N';
  VpaDProspect.CodProspect := RCodSuspectDisponivel;
  CliCadastro.FieldByName('CODPROSPECT').AsInteger := VpaDProspect.CodProspect;
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO SUPECT!!!'#13+e.message;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDTarefa(VpaDTarefa: TRBDTarefa): String;
begin
  result := '';
  if VpaDTarefa.SeqAgenda <> 0 then
  begin
    if VpaDTarefa.CodUsuario <>VpaDTarefa.CodUsuarioAnterior then
    begin
      ExecutaComandoSql(CliAux,'Delete from AGENDA '+
                                    ' Where CODUSUARIO = '+IntToStr(VpaDTarefa.CodUsuarioAnterior)+
                                    ' and SEQAGENDA = '+IntToStr(VpaDTarefa.SeqAgenda));
      VpaDTarefa.SeqAgenda := 0;
    end;
  end;
  AdicionaSQLAbreTabela(CliCadastro,'Select * from AGENDA '+
                                    ' Where CODUSUARIO = '+IntToStr(VpaDTarefa.CodUsuario)+
                                    ' and SEQAGENDA = '+IntToStr(VpaDTarefa.SeqAgenda));
  if VpaDTarefa.SeqAgenda = 0 then
    CliCadastro.Insert
  else
    CliCadastro.Edit;

  CliCadastro.FieldByName('CODUSUARIO').AsInteger := VpaDTarefa.CodUsuario;
  if VpaDTarefa.CodCliente <> 0 then
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaDTarefa.CodCliente
  else
    CliCadastro.FieldByName('CODCLIENTE').clear;
  CliCadastro.FieldByName('DATCADASTRO').AsDateTime := VpaDTarefa.DatCadastro;
  CliCadastro.FieldByName('DATINICIO').AsDateTime := VpaDTarefa.DatTarefa;
  CliCadastro.FieldByName('DATFIM').AsDateTime := VpaDTarefa.DatFim;
  CliCadastro.FieldByName('CODTIPOAGENDAMENTO').AsInteger := VpaDTarefa.CodTipo;
  CliCadastro.FieldByName('CODUSUARIOAGENDOU').AsInteger := VpaDTarefa.CodUsuarioAgendou;
  CliCadastro.FieldByName('DESTITULO').AsString := VpaDTarefa.DesTitulo;
  CliCadastro.FieldByName('DESOBSERVACAO').AsString := VpaDTarefa.DesObservacoes;
  if VpaDTarefa.IndConcluida then
    CliCadastro.FieldByName('INDREALIZADO').AsString := 'S'
  else
    CliCadastro.FieldByName('INDREALIZADO').AsString := 'N';
  if VpaDTarefa.IndCancelada then
    CliCadastro.FieldByName('INDCANCELADO').AsString := 'S'
  else
    CliCadastro.FieldByName('INDCANCELADO').AsString := 'N';
  if VpaDTarefa.CodFilialCompra <> 0 then
    CliCadastro.FieldByName('CODFILIALCOMPRA').AsInteger := VpaDTarefa.CodFilialCompra
  else
    CliCadastro.FieldByName('CODFILIALCOMPRA').Clear;
  if VpaDTarefa.SeqPedidoCompra <> 0 then
    CliCadastro.FieldByName('SEQPEDIDOCOMPRA').AsInteger := VpaDTarefa.SeqPedidoCompra
  else
    CliCadastro.FieldByName('SEQPEDIDOCOMPRA').Clear;

  if VpaDTarefa.SeqAgenda = 0 then
    VpaDTarefa.SeqAgenda := RSeqAgendaDisponivel(VpaDTarefa.CodUsuario);
  CliCadastro.FieldByName('SEQAGENDA').AsInteger := VpaDTarefa.SeqAgenda;
  CliCadastro.post;
  Result := CliCadastro.AMensagemErroGravacao;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaLogCliente(VpaCodCliente: Integer): string;
var
  VpfSeqLog : Integer;
  VpfNomArquivo : String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM CLIENTELOG '+
                                 ' Where CODCLIENTE = 0 AND SEQLOG = 0');
  cliCadastro.Insert;

  cliCadastro.FieldByName('CODCLIENTE').AsInteger:= VpaCodCliente;
  VpfSeqLog:= RSeqLogCliente(VpaCodCliente);
  CLICadastro.FieldbyName('SEQLOG').asInteger:= VpfSeqLog;
  CliCadastro.FieldByName('DATLOG').AsDateTime:= Now;
  CliCadastro.FieldByName('CODUSUARIO').AsInteger:= varia.CodigoUsuario;

  VpfNomArquivo := varia.PathVersoes+'\LOG\CLIENTE\'+FormatDateTime('YYYYMM',date)+'\' +IntToStr(VpaCodCliente)+'_u'+IntToStr(Varia.CodigoUsuario)+'_'+FormatDateTime('YYMMDDHHMMSSMM',NOW)+'.xml';

  CliCadastro.FieldByname('DESLOCALARQUIVO').AsString := VpfNomArquivo;

  CliCadastro.Post;
  Result := CliCadastro.AMensagemErroGravacao;

  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES '+
                               ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));

  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  CliCadastro.SaveToFile(VpfNomArquivo,dfxml);
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraClienteVendedor(VpaDClientePerdido : TRBDClientePerdidoVendedor):string;
begin
  Result := '';
  CliAux.sql.clear;
  CliAux.sql.add('UPDATE CADCLIENTES CLI '+
                   ' SET I_COD_VEN = '+IntToStr(VpaDClientePerdido.CodVendedorDestino)+
                   ' WHERE I_COD_VEN <>  '+IntToStr(VpaDClientePerdido.CodVendedorDestino)+
                   SQLFiltroCliente('CLI',VpaDClientePerdido.IndCliente,VpaDClientePerdido.IndProspect));
  if VpaDClientePerdido.QtdDiasSemPedido <> 0 then
    CliAux.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasSemPedido)+
                      ' and NOT EXISTS(select * from CADORCAMENTOS ORC '+
                      '       Where ORC.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasSemPedido))+
                      '       AND ORC.I_COD_CLI = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.QtdDiasComPedido <> 0 then
    CliAux.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasComPedido)+
                      ' and EXISTS(select * from CADORCAMENTOS ORC '+
                      '       Where ORC.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasComPedido))+
                      '       AND ORC.I_COD_CLI = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.QtdDiasSemTelemarketing <> 0 then
    CliAux.sql.add(' and TRUNC(SYSDATE) - TRUNC(NVL(D_DAT_CAD,TO_DATE(''01/01/2001'',''DD/MM/YYYY''))) > '+InttoStr(VpaDClientePerdido.QtdDiasSemTelemarketing)+
                      ' and NOT EXISTS(select * from TELEMARKETING TEL  '+
                      '       Where TEL.DATLIGACAO >= '+SQLTextoDataAAAAMMMDD(DecDia(Date,VpaDClientePerdido.QtdDiasSemTelemarketing))+
                      '       AND TEL.CODCLIENTE = CLI.I_COD_CLI) ');
  if VpaDClientePerdido.CodRegiaoVendas <> 0 then
    CliAux.sql.add(' and CLI.I_COD_REG = '+IntToStr(VpaDClientePerdido.CodRegiaoVendas));
  CliAux.SQL.SaveToFile('C:\consulta.sql');
  CliAux.ExecSQL;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AlteraSeqItemProdutoClienteDuplicado(VpaClienteNovo, VpaClienteAExcluir : Integer);
var
  VpfUltimoSeqItem :Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQITEM) ULTIMO from PRODUTOCLIENTE '+
                               ' Where CODCLIENTE = ' +IntToStr(VpaClienteNovo));
  VpfUltimoSeqItem := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  ExecutaComandoSql(CliAux,'Update PRODUTOCLIENTE '+
                           ' SET SEQITEM = SEQITEM + '+IntToStr(VpfUltimoSeqItem)+
                           ' Where CODCLIENTE = '+IntToStr(VpaClienteAExcluir));
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AlteraVendedorCadastroCliente(VpaCodVendedorOrigem,VpaCodVendedorDestino: Integer);
begin
  ExecutaComandoSql(CliAux,'UPDATE CADCLIENTES ' +
                           ' SET I_COD_VEN  = '+IntToStr(VpaCodVendedorDestino)+
                           ' Where I_COD_VEN = '+IntToStr(VpaCodVendedorOrigem));
end;

{******************************************************************************}
function TRBFuncoesClientes.CadastraProdutoNumeroSerieCliente(VpaDatEmissao : TDateTime; VpaCodCliente, VpaSeqProduto,VpaQtdMesesGarantia : Integer;VpaNumSerie, VpaUM, VpaNomProduto : String; VpaProdutoPeca: TList):string;
var
  VpfProdutos, VpfProdutoPecaOriginais : TList;
  VpfDProdutoCliente : TRBDProdutoCliente;
  VpfLaco: Integer;
begin
  result := '';
  VpfProdutos := TList.create;
  if not ExisteProdutoCliente(VpaNumSerie,VpaCodCliente,VpaSeqProduto) then
  begin
    if VpaQtdMesesGarantia = 0 then
      aviso('QUANTIDADE DE MESES DE GARANTIA NO CADASTRO DO PRODUTO NÃO INFORMADO!!!'#13'A quantidade de meses de garantia do produto "'+VpaNomProduto+'" não foi informado, foi cadastrado um produto para o cliente com a garantia vencendo hoje.');
    CarDProdutoCliente(VpaCodCliente,VpfProdutos);
    VpfDProdutoCliente := TRBDProdutoCliente.cria;
    VpfProdutos.add(VpfDProdutoCliente);
    VpfDProdutoCliente.SeqProduto := VpaSeqProduto;
    VpfDProdutoCliente.CodCliente:= VpaCodCliente;
    VpfDProdutoCliente.NumSerieProduto :=  VpaNumSerie;
    VpfDProdutoCliente.UM := VpaUM;
    VpfDProdutoCliente.QtdProduto := 1;
    VpfDProdutoCliente.DatGarantia :=IncMes(VpaDatEmissao,VpaQtdMesesGarantia);
    result := GravaDProdutoCliente(VpaCodCliente,VpfProdutos);
  end
  else
  begin
    CarDProdutoCliente(VpaCodCliente,VpfProdutos);
    VpfDProdutoCliente:= RProdutoCliente(VpfProdutos, VpaSeqProduto, VpaNumSerie);
    for VpfLaco := 0 to VpfDProdutoCliente.Pecas.Count - 1 do
    begin
      VpaProdutoPeca.Add(VpfDProdutoCliente.Pecas.Items[VpfLaco]);
    end;
  end;
    if Result = '' then
    begin
      if VpaProdutoPeca <> nil then
      begin
        VpfProdutoPecaOriginais:= VpfDProdutoCliente.Pecas;
        VpfDProdutoCliente.Pecas:= VpaProdutoPeca;
        Result:= GravaDProdutoClientePeca(VpfDProdutoCliente);
        VpfDProdutoCliente.Pecas:= VpfProdutoPecaOriginais;
      end;
    end;

    FreeTObjectsList(VpfProdutos);
    VpfProdutos.free;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaNumeroSerieProdutoCliente(VpaCodCliente : Integer;VpaDProChamado : TRBDChamadoProduto) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from PRODUTOCLIENTE '+
                                    ' Where CODCLIENTE = '+IntToStr(VpaCodCliente)+
                                    ' and SEQITEM = '+IntToStr(VpaDProChamado.SeqItemProdutoCliente)+
                                    ' AND SEQPRODUTO = '+IntToStr(VpaDProChamado.SeqProduto));
  if not CliCadastro.eof then
  begin
    if CliCadastro.FieldByName('NUMSERIE').AsString = '' then
    begin
      CliCadastro.Edit;
      CliCadastro.FieldByName('NUMSERIE').AsString := VpaDProChamado.NumSerie;
      try
        CliCadastro.Post;
      except
        on e : exception do result := 'ERRO NA GRAVAÇÃO DOS PRODUTO DO CLIENTE!!!'#13+e.message;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaNumeroSerieProdutoContrato(VpaDProChamado : TRBDChamadoProduto) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CONTRATOITEM '+
                                    ' Where CODFILIAL = '+IntToStr(VpaDProChamado.CodFilialChamado)+
                                    ' AND SEQCONTRATO = '+IntToStr(VpaDProChamado.SeqContrato)+
                                    ' AND SEQITEM = '+IntToStr(VpaDProChamado.SeqItemContrato));
  if not CliCadastro.eof then
  begin
    if CliCadastro.FieldByName('NUMSERIE').AsString = '' then
    begin
      CliCadastro.Edit;
      CliCadastro.FieldByName('NUMSERIE').AsString := VpaDProChamado.NumSerie;
      try
        CliCadastro.post;
      except
        on e : exception do result := 'ERRO NA GRAVAÇÃO DO CONTRATOITE!!!'#13+e.message;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.CarDTelemarketingProspect(VpaDDigProspect : TRBDDigitacaoProspect;VpaDProspect : TRBDDigitacaoProspectItem):TRBDTelemarketing;
begin
  result := TRBDTelemarketing.cria;
  result.CodFilial := varia.CodigoEmpFil;
  result.CodCliente := VpaDProspect.CodProspect;
  result.CodUsuario := Varia.CodigoUsuario;
  result.SeqCampanha := varia.SeqCampanhaTelemarketing;
  result.DesFaladoCom := VpaDProspect.NomContato;
  result.CodHistorico := VpaDProspect.CodHistorico;
  result.DesObservacao := VpaDProspect.DesObservacao;
  result.DatLigacao := VpaDProspect.DatVisita;
  result.CodVendedor := VpaDDigProspect.CodVendedor;
end;

{******************************************************************************}
function TRBFuncoesClientes.CarDTelemarketingSuspect(VpaDDigProspect : TRBDDigitacaoProspect; VpaDProspect : TRBDDigitacaoProspectItem):TRBDTelemarketingProspect;
begin
  result := TRBDTelemarketingProspect.cria;
  result.CodFilial := varia.CodigoEmpFil;
  result.CodProspect := VpaDProspect.CodProspect;
  result.CodUsuario := Varia.CodigoUsuario;
  result.DesFaladoCom := VpaDProspect.NomContato;
  result.CodHistorico := VpaDProspect.CodHistorico;
  result.DesObservacao := VpaDProspect.DesObservacao;
  result.DatLigacao := VpaDProspect.DatVisita;
  result.CodVendedor := VpaDDigProspect.CodVendedor;
end;

{******************************************************************************}
function TRBFuncoesClientes.CarDCliente(VpaDCliente : TRBDCliente;VpaFornecedor : Boolean = false;VpaExigirCPFCNPJ : Boolean = true;VpaValidarDadosNFE : Boolean = false):String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliTabela,'Select * from CADCLIENTES'+
                                  ' Where I_COD_CLI = ' +IntToStr(VpaDCliente.CodCliente));
  with VpaDCliente do
  begin
    CodVendedor := CliTabela.FieldByName('I_COD_VEN').AsInteger;
    CodProfissao := CliTabela.FieldByName('I_PRC_PRF').AsInteger;
    CodVendedorPreposto := CliTabela.FieldByName('I_VEN_PRE').AsInteger;
    CodCondicaoPagamento := CliTabela.FieldByName('I_COD_PAG').AsInteger;
    CodFormaPagamento := CliTabela.FieldByName('I_FRM_PAG').AsInteger;
    CodTransportadora := CliTabela.FieldByName('I_COD_TRA').AsInteger;
    CodRedespacho := CliTabela.FieldByName('I_COD_RED').AsInteger;
    CodTipoCotacao := CliTabela.FieldByName('I_TIP_ORC').AsInteger;
    CodTabelaPreco := CliTabela.FieldByName('I_COD_TAB').AsInteger;
    CodIBGECidade := CliTabela.FieldByName('I_COD_IBG').AsInteger;
    CodPais := CliTabela.FieldByName('I_COD_PAI').AsInteger;
    CodRamoAtividade := CliTabela.FieldByName('I_COD_RAM').AsInteger;
    QtdLigacoesSemVenda := CliTabela.FieldByName('I_QTD_LSV').AsInteger;
    QtdDiasProtesto := CliTabela.FieldByName('I_DIA_PRO').AsInteger;
    QtdLigacoesComVenda := CliTabela.FieldByName('I_QTD_LCV').AsInteger;
    PerComissao := CliTabela.FieldByName('I_PER_COM').AsFloat;
    NomCliente := CliTabela.FieldByName('C_NOM_CLI').AsString;
    NomFantasia := CliTabela.FieldByName('C_NOM_FAN').AsString;
    NomContato := CliTabela.FieldByName('C_CON_CLI').AsString;
    ContaBancariaDeposito := CliTabela.FieldByName('C_NRO_CON').AsString;
    NomContatoFinanceiro := CliTabela.FieldByName('C_CON_FIN').AsString;
    NomContato := CliTabela.FieldByName('C_CON_CLI').AsString;
    NomContatoEntrega := CliTabela.FieldByName('C_RES_ENT').AsString;
    DesEmailFinanceiro := CliTabela.FieldByName('C_EMA_FIN').AsString;
    DesEmail := CliTabela.FieldByName('C_END_ELE').AsString;
    DesEmailNfe := CliTabela.FieldByName('C_EMA_NFE').AsString;
    DesFoneFinanceiro := CliTabela.FieldByName('C_FON_FIN').AsString;
    DesEndereco := CliTabela.FieldByName('C_END_CLI').AsString;
    DesEnderecoEntrega := CliTabela.FieldByName('C_END_ANT').AsString;
    DesComplementoEndereco := CliTabela.FieldByName('C_COM_END').AsString;
    NumEndereco := CliTabela.FieldByName('I_NUM_END').AsString;
    NumEnderecoEntrega := CliTabela.FieldByName('I_NUM_ANT').AsString;
    DesBairro := CliTabela.FieldByName('C_BAI_CLI').AsString;
    DesBairroEntrega := CliTabela.FieldByName('C_BAI_ANT').AsString;
    CepCliente := CliTabela.FieldByName('C_CEP_CLI').AsString;
    CepEntrega := CliTabela.FieldByName('C_CEP_ANT').AsString;
    DesCidade := CliTabela.FieldByName('C_CID_CLI').AsString;
    DesCidadeEntrega := CliTabela.FieldByName('C_CID_ANT').AsString;
    DesUF := CliTabela.FieldByName('C_EST_CLI').AsString;
    DesUFEntrega := CliTabela.FieldByName('C_EST_ANT').AsString;
    DesResolucaoProEmprego := CliTabela.FieldByName('C_PRO_EMP').AsString;
    DesEnderecoCobranca := CliTabela.FieldByName('C_END_COB').AsString;
    NumEnderecoCobranca := CliTabela.FieldByName('I_NUM_COB').AsString;
    DesBairroCobranca := CliTabela.FieldByName('C_BAI_COB').AsString;
    CepClienteCobranca := CliTabela.FieldByName('C_CEP_COB').AsString;
    CodPlanoContas := CliTabela.FieldByName('C_CLA_PLA').AsString;
    DesIdentificacaoBancariaFornecedor := CliTabela.FieldByName('C_IDE_BAN').AsString;
    DesCidadeCobranca := CliTabela.FieldByName('C_CID_COB').AsString;
    DesUfCobranca := CliTabela.FieldByName('C_EST_COB').AsString;
    DesObsTeleMarketing := CliTabela.FieldByName('C_OBS_TEL').AsString;
    LimiteCredito := CliTabela.FieldByName('N_LIM_CLI').AsFloat;
    PerDescontoCotacao := CliTabela.FieldByName('N_DES_COT').AsFloat;
    PerDescontoFinanceiro := CliTabela.FieldByName('N_PER_DES').AsFloat;
    PerISS := CliTabela.FieldByName('N_PER_ISS').AsFloat;
    IndFornecedor := (CliTabela.FieldByName('C_IND_FOR').AsString = 'S');
    IndRevenda := (CliTabela.FieldByName('C_IND_REV').AsString = 'S');
    IndNotaFiscal :=(DeletaChars(CliTabela.FieldByName('C_TIP_FAT').AsString,' ') <> '');
    IndQuarto := UpperCase(CliTabela.FieldByName('C_TIP_FAT').AsString) = 'Q';
    IndDecimo := UpperCase(CliTabela.FieldByName('C_TIP_FAT').AsString) = 'D';
    IndMeia := UpperCase(CliTabela.FieldByName('C_TIP_FAT').AsString) = 'M';
    IndVintePorcento := UpperCase(CliTabela.FieldByName('C_TIP_FAT').AsString) = 'V';
    IndDescontarISS := (CliTabela.FieldByName('C_DES_ISS').AsString = 'S');
    IndAceitaTeleMarketing := (CliTabela.FieldByName('C_ACE_TEL').AsString = 'S');
    IndPendenciaSerasa := (CliTabela.FieldByName('C_IND_SER').AsString = 'S');
    IndProtestar := (CliTabela.FieldByName('C_IND_PRO').AsString = 'S');
    IndBloqueado := (CliTabela.FieldByName('C_IND_BLO').AsString = 'S');
    IndSimplesNacional := (CliTabela.FieldByName('C_OPT_SIM').AsString = 'S');
    IndDestacarICMSNota := (CliTabela.FieldByName('C_DES_ICM').AsString = 'S');
    IndCobrarFormaPagamento := (CliTabela.FieldByName('C_COB_FRM').AsString = 'S');
    IndConsumidorFinal := (CliTabela.FieldByName('C_IND_COF').AsString = 'S');
    DatUltimaConsultaSerasa := CliTabela.FieldByName('D_CON_SER').AsDateTime;
    DatUltimoRecebimento := CliTabela.FieldByName('D_ULT_REC').AsDateTime;
    DesPracaPagto := CliTabela.FieldByName('C_PRA_CLI').AsString;
    DesUfEmbarque:= CliTabela.FieldByName('C_EST_EMB').AsString;
    DesLocalEmbarque:= CliTabela.FieldByName('C_LOC_EMB').AsString;

    if CliTabela.FieldByName('C_TIP_PES').AsString = 'F' then
    begin
      CGC_CPF := CliTabela.FieldByName('C_CPF_CLI').AsString;
      rg := CliTabela.FieldByName('C_REG_CLI').AsString;
      if VpaExigirCPFCNPJ then
        if not VerificaCPF(CGC_CPF) then
          result := 'CPF DO CLIENTE/FORNECEDOR INVÁLIDO!!!'#13'O CPF cadastrado para o cliente está inválido.';
    end
    else
      if CliTabela.FieldByName('C_TIP_PES').AsString = 'J' then
      begin
       InscricaoEstadual := CliTabela.FieldByName('C_INS_CLI').AsString;
       CGC_CPF := CliTabela.FieldByName('C_CGC_CLI').AsString;
       if VpaExigirCPFCNPJ then
       begin
         if not VerificaCGC(CGC_CPF) then
           result := 'CNPJ DO CLIENTE/FORNECEDOR INVÁLIDO!!!'#13'O CNPJ cadastrado para o cliente está inválido, para maiores informações acesse o site www.sintegra.gov.br.'
//d5         else
//           if not VerificarIncricaoEstadual(InscricaoEstadual,DesUF,false,true) then
//             result := 'INSCRIÇÃO ESTADUAL DO CLIENTE/FORNECEDOR INVÁLIDO!!!'#13'A Inscrição Estadual cadastrada para o cliente está inválida, para maiores informações acesse o site www.sintegra.gov.br.';
       end;
    end;

    Fone_FAX  := CliTabela.FieldByName('C_FO1_CLI').AsString;
    DesFone1 := CliTabela.FieldByName('C_FO1_CLI').AsString;
    DesFone2 := CliTabela.FieldByName('C_FO2_CLI').AsString;
    DesFone3 := CliTabela.FieldByName('C_FO3_CLI').AsString;
    DesCelular := CliTabela.FieldByName('C_FON_CEL').AsString;
    DesFax := CliTabela.FieldByName('C_FON_FAX').AsString;
    CodTecnico := CliTabela.FieldByName('I_COD_TEC').AsInteger;

    TipoPessoa        := CliTabela.FieldByName('C_TIP_PES').AsString;
    DesObservacao := CliTabela.FieldByName('C_OBS_CLI').AsString;

    case CliTabela.FieldByName('I_PER_TEL').AsInteger of
      0 : DesLigarPeriodo := 'Qualquer Período';
      1 : DesLigarPeriodo := 'Manhã';
      2 : DesLigarPeriodo := 'Tarde';
      3 : DesLigarPeriodo := 'Noite';
    end;

    case CliTabela.FieldByName('I_DIA_TEL').AsInteger of
      0 : DesLigarDiaSemana := 'Qualquer Dia';
      1 : DesLigarDiaSemana := 'Domingo';
      2 : DesLigarDiaSemana := 'Segunda Feira';
      3 : DesLigarDiaSemana := 'Terça Feira';
      4 : DesLigarDiaSemana := 'Quarta Feira';
      5 : DesLigarDiaSemana := 'Quinta Feira';
      6 : DesLigarDiaSemana := 'Sexta Feira';
      7 : DesLigarDiaSemana := 'Sábado';
    end;
    DatUltimoTeleMarketing := CliTabela.FieldByName('D_ULT_TEL').AsDateTime;
    DatProximaLigacao := CliTabela.FieldByName('D_PRO_LIG').AsDateTime;
    SeqCampanha := CliTabela.FieldByName('I_SEQ_CAM').AsInteger;
    DesEmailFornecedor:= CliTabela.FieldByName('C_EMA_FOR').AsString;
    NomContatoFornecedor:= CliTabela.FieldByName('C_CON_COM').AsString;
    ValFrete:= CliTabela.FieldByName('N_VAL_FRE').AsFloat;
    NumDiasEntrega := CliTabela.FieldByName('I_PRA_ENT').AsInteger;
    CodConcorrente:= CliTabela.FieldByName('I_COD_CON').AsInteger;
    CodProspect:= CliTabela.FieldByName('I_COD_PRC').AsInteger;    

    if not VpaFornecedor then
    begin
      if config.LimiteCreditoCliente then
        DuplicatasEmAberto := RValemAbertoClienteCorrigido(VpaDCliente.CodCliente);
      if config.BloquearClienteEmAtraso then
        DuplicatasEmAtraso := RValDuplicatasEmAtraso(IntToStr(VpaDCliente.CodCliente));
      IndPossuiContrato := ClientePossuiContrato(VpaDCliente.CodCliente);
    end;
  end;
  CliTabela.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RDatUltimoPedido(VpaCodCliente : String):TDateTime;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(D_DAT_ORC) ULTIMA from CADORCAMENTOS '+
                               ' Where I_COD_CLI = '+VpaCodCliente);
  result := CliAux.FieldByName('ULTIMA').AsDateTime;
  CliAux.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarProdutoInteresseCliente(VpaProdutos : TList;VpaCodCliente : Integer);
var
  VpfDProduto : TRBDProdutoInteresseCliente;
begin
  FreeTObjectsList(VpaProdutos);
  AdicionaSQLAbreTabela(CliTabela,'Select PIN.SEQPRODUTO, PIN.QTDPRODUTO, '+
                                  ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                                  ' from CADPRODUTOS PRO, PRODUTOINTERESSECLIENTE PIN '+
                                  ' Where PRO.I_SEQ_PRO = PIN.SEQPRODUTO '+
                                  ' AND PIN.CODCLIENTE = '+IntToStr(VpaCodCliente));
  while not CliTabela.eof do
  begin
    VpfDProduto := TRBDProdutoInteresseCliente.cria;
    VpaProdutos.add(VpfDProduto);
    VpfDProduto.CodCliente := VpaCodCliente;
    VpfDProduto.SeqProduto := CliTabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDProduto.CodProduto := CliTabela.FieldByName('C_COD_PRO').AsString;
    VpfDProduto.NomProduto := CliTabela.FieldByName('C_NOM_PRO').AsString;
    VpfDProduto.QtdProduto := CliTabela.FieldByName('QTDPRODUTO').AsFloat;
    CliTabela.next;
  end;
  CliTabela.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RQtdClientes(VpaCodSituacao : String) : Integer;
begin
  CliAux.Sql.Clear;
  CliAux.Sql.Add('Select count(*) QTD FROM CADCLIENTES '+
                 ' Where C_TIP_CAD IN (''A'',''C'')');
  if VpaCodSituacao <> '' then
    CliAux.Sql.Add('and I_COD_SIT = '+VpaCodSituacao);
  CliAux.Open;
  result := CliAux.FieldByName('QTD').AsInteger;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RNomCliente(VpaCodCliente : String) : String;
begin
  AdicionaSqlAbreTabela(CliAux,'Select C_NOM_CLI from CADCLIENTES '+
                               ' Where I_COD_CLI = '+VpaCodCliente);
  result := CliAux.FieldByName('C_NOM_CLI').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RNomeFantasia(VpaCodCliente: Integer): String;
begin
  AdicionaSqlAbreTabela(CliAux,'Select C_NOM_FAN from CADCLIENTES '+
                               ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));
  result := CliAux.FieldByName('C_NOM_FAN').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RNomTranpostadora(VpaCodTransportadora : Integer) : String;
begin
  AdicionaSqlAbreTabela(CliAux,'Select * from CADCLIENTES '+
                              ' Where I_COD_CLI = '+Inttostr(VpaCodtransportadora));
  result := CliAux.FieldByName('C_NOM_CLI').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RPerICMSUF(VpaCodEstado: string): Double;
begin
  AdicionaSQLAbreTabela(CliTabela,'Select N_ICM_INT from CADICMSESTADOS '+
                            ' Where C_COD_EST = '''+ VpaCodEstado+''''+
                            ' and I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa));
  result := CliTabela.FieldByName('N_ICM_INT').AsFloat;
  CliTabela.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RProdutoCliente(VpaProdutoCliente: TList;
  VpaSeqProduto: Integer; VpaNumSerie: String): TRBDProdutoCliente;
Var
 VpfLaco: integer;
 VpfDProdutoCliente: TRBDProdutoCliente;
begin
  for VpfLaco := 0 to VpaProdutoCliente.Count -1 do
  begin
    VpfDProdutoCliente:= TRBDProdutoCliente(VpaProdutoCliente.Items[VpfLaco]);
    if (VpfDProdutoCliente.SeqProduto = VpaSeqProduto) and (VpfDProdutoCliente.NumSerieProduto = VpaNumSerie) then
    begin
      Result:= VpfDProdutoCliente;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.RProximoCodClienteRepresentanteDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CODIGOCLIENTE '+
                                   ' ORDER BY CODCLIENTE ');
  Result:= CliCadastro.FieldByName('CODCLIENTE').AsInteger;
  CliCadastro.Delete;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RNomProfissao(VpaCodProfissao : Integer) : string;
begin
  AdicionaSqlAbreTabela(CliAux,'Select C_NOM_PRF from CADPROFISSOES '+
                              ' Where I_COD_PRF = '+Inttostr(VpaCodProfissao));
  result := CliAux.FieldByName('C_NOM_PRF').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RNomRamoAtividade(VpaCodRamoAtividade: Integer): string;
begin
  AdicionaSQLAbreTabela(CliAux,'Select NOM_RAMO_ATIVIDADE ' +
                               ' FROM RAMO_ATIVIDADE  ' +
                               ' Where COD_RAMO_ATIVIDADE = '+IntToStr(VpaCodRamoAtividade));
  Result := CliAux.FieldByName('NOM_RAMO_ATIVIDADE').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.REmailCliente(VpaCodcliente : Integer) : String;
begin
  AdicionaSqlAbreTabela(CliAux,'Select C_END_ELE from CADCLIENTES '+
                               ' Where I_COD_CLI = '+IntTostr(VpaCodCliente));
  result := CliAux.FieldByName('C_END_ELE').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqTarefaDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQTAREFA) ULTIMO FROM TAREFATELEMARKETING ');
  result := CliAux.FieldByName('ULTIMO').AsInteger +1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqContatoDisponivel(VpaCodCliente: Integer): Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT MAX(SEQCONTATO) ULTIMO FROM CONTATOCLIENTE'+
                               ' WHERE CODCLIENTE = '+IntToStr(VpaCodCliente));
  Result:= CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqTarefaEMarketingDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select MAX(SEQTAREFA) ULTIMO FROM TAREFAEMARKETING ');
  result := CliAux.FieldByName('ULTIMO').AsInteger +1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodRegiaVendas(VpaCep : String):Integer;
begin
  result := 0;
  if VpaCep <> '' then
  begin
    AdicionaSQLAbreTabela(CliAux,'Select I_COD_REG  from CADREGIAOVENDA '+
                                 ' Where I_CEP_INI <= '+VpaCep+
                                 ' AND I_CEP_FIM >= '+VpaCep);
    result := CliAux.FieldByName('I_COD_REG').AsInteger;
    CliAux.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodPais(VpaUF : String):Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'select PAI.COD_IBGE '+
                               ' from CAD_ESTADOS EST, CAD_PAISES PAI '+
                               ' WHERE PAI.COD_PAIS = EST.COD_PAIS '+
                               ' AND EST.COD_ESTADO = '''+VpaUF+'''' );
  result := CliAux.FieldByName('COD_IBGE').AsInteger;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodProdutoClientePecaDisponivel: integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select max(CODPRODUTOCLIENTEPECA) ULTIMO from PRODUTOCLIENTEPECA');
  Result := CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RNomPais(VpaCodPais : Integer) : String;
begin
  AdicionaSQLAbreTabela(CliAux,'select DES_PAIS '+
                               ' from CAD_PAISES  '+
                               ' WHERE COD_IBGE = '+ IntToStr(VpaCodPais));
  result := CliAux.FieldByName('DES_PAIS').AsString;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodCidade(VpaNomCidade, VpaDesUF : String ):integer;
begin
  AdicionaSQLAbreTabela(CliAux,'Select COD_FISCAL FROM CAD_CIDADES '+
                               ' Where DES_CIDADE = '''+VpaNomCidade+''''+
                               ' and COD_ESTADO = '''+VpaDesUF+'''' );
  if DeletaChars(CliAux.FieldByName('COD_FISCAL').AsString,' ') <> '' then
    result := CliAux.FieldByName('COD_FISCAL').AsInteger
  else
    result := 0;
  CliAux.CLOSE;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.ExcluiCliente(VpaCodClienteAExcluir,VpaCodClienteHistorico : Integer;VpaBarraStatus : TStatusBar);
begin
  if VpaCodClienteAExcluir = VpaCodClienteHistorico then
    aviso('CLIENTES IGUAIS!!!'#13'O código do cliente a excluir é igual ao código do cliente histórico.')
  else
  begin
    AtualizaStatusBar(VpaBarraStatus,'Contas a Pagar');
    ExecutaComandoSql(CliAux,'UPDATE CONTATOCLIENTE '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    ExecutaComandoSql(CliAux,'UPDATE AMOSTRA '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    ExecutaComandoSql(CliAux,'UPDATE CADCONTASAPAGAR '+
                             ' SET I_COD_CLI = '+IntToStr(VpaCodClienteHistorico)+
                             ' where I_COD_CLI = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Contas a Receber');
    ExecutaComandoSql(CliAux,'UPDATE CADCONTASARECEBER '+
                             ' SET I_COD_CLI = '+IntToStr(VpaCodClienteHistorico)+
                             ' where I_COD_CLI = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Notas Fiscais');
    ExecutaComandoSql(CliAux,'UPDATE CADNOTAFISCAIS '+
                             ' SET I_COD_CLI = '+IntToStr(VpaCodClienteHistorico)+
                             ' where I_COD_CLI = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Orcamento compra fornecedor corpo');
    ExcluiClienteORCAMENTOCOMPRAFORNECEDOR(VpaCodClienteAExcluir,VpaCodClienteHistorico);
    AtualizaStatusBar(VpaBarraStatus,'Pedido Compra');
    ExecutaComandoSql(CliAux,'UPDATE PEDIDOCOMPRACORPO '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Nota Fiscais Fornecedor');
    ExecutaComandoSql(CliAux,'UPDATE CADNOTAFISCAISFOR '+
                             ' SET I_COD_CLI = '+IntToStr(VpaCodClienteHistorico)+
                             ' where I_COD_CLI = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Agendamentos');
    ExecutaComandoSql(CliAux,'UPDATE AGENDA '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Orcamentos');
    ExecutaComandoSql(CliAux,'UPDATE CADORCAMENTOS '+
                             ' SET I_COD_CLI = '+IntToStr(VpaCodClienteHistorico)+
                             ' where I_COD_CLI = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Movimento de eventos');
    ExecutaComandoSql(CliAux,'UPDATE MOVEVENTOS '+
                             ' SET I_COD_CLI = '+IntToStr(VpaCodClienteHistorico)+
                             ' where I_COD_CLI = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Movimento de fornecedores');
    ExcluiClientePRODUTOFORNECEDOR(VpaCodClienteAExcluir,VpaCodClienteHistorico);
    AtualizaStatusBar(VpaBarraStatus,'Atualizando SeqTelemarketing');
    ExecutaComandoSql(CliAux,'UPDATE TELEMARKETING '+
                             ' SET SEQTELE = SEQTELE +'+IntToStr(RUltimoSeqTelemarketing(VpaCodClienteHistorico))+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Telemarketing');
    ExecutaComandoSql(CliAux,'UPDATE TELEMARKETING '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'BRINDE CLIENTE');
    ExecutaComandoSql(CliAux,'UPDATE BRINDECLIENTE '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'PRODUTO CLIENTE');
    AlteraSeqItemProdutoClienteDuplicado(VpaCodClienteHistorico,VpaCodClienteAExcluir);
    ExecutaComandoSql(CliAux,'UPDATE PRODUTOCLIENTE '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'CONTRATO CORPO');
    ExecutaComandoSql(CliAux,'UPDATE CONTRATOCORPO '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'COBRANÇA CORPO');
    ExecutaComandoSql(CliAux,'UPDATE COBRANCACORPO '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'LEITURA LOCAÇÃO CORPO');
    ExecutaComandoSql(CliAux,'UPDATE LEITURALOCACAOCORPO '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'CHAMADOS');
    ExecutaComandoSql(CliAux,'UPDATE CHAMADOCORPO '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'AMOSTRA PREÇO CLIENTE');
    ExecutaComandoSql(CliAux,'UPDATE AMOSTRAPRECOCLIENTE '+
                             ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Excluindo tarefa emarketing');
    ExecutaComandoSql(CliAux,'DELETE FROM TAREFAEMARKETINGITEM ' +
                             ' where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Excluindo cliente');
    ExecutaComandoSql(CliAux,'DELETE FROM CADCLIENTES ' +
                             ' where I_COD_CLI = '+IntToStr(VpaCodClienteAExcluir));
    AtualizaStatusBar(VpaBarraStatus,'Cliente Excluído com sucesso');
  end;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.ExcluiClienteORCAMENTOCOMPRAFORNECEDOR(VpaCodClienteAExcluir,VpaCodClienteHistorico: Integer);
Var
  VpfLaco : Integer;
begin
  AdicionaSQLAbreTabela(CliTabela,'SELECT * FROM ORCAMENTOCOMPRAFORNECEDORCORPO ' +
                                  ' Where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
  while not CliTabela.Eof do
  begin
    AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM ORCAMENTOCOMPRAFORNECEDORCORPO ' +
                                    ' Where CODFILIAL = '+CliTabela.FieldByName('CODFILIAL').AsString+
                                    '  AND SEQORCAMENTO =  '+CliTabela.FieldByName('SEQORCAMENTO').AsString+
                                    ' AND CODCLIENTE = '+IntToStr(VpaCodClienteHistorico));
    if CliCadastro.Eof then
      CliCadastro.Insert
    else
      CliCadastro.Edit;
    for VpfLaco := 0 to CliTabela.FieldCount - 1 do
      CliCadastro.FieldByName(CliTabela.Fields[VpfLaco].DisplayName).AsVariant := CliTabela.FieldByName(CliTabela.Fields[VpfLaco].DisplayName).AsVariant;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodClienteHistorico;
    CliCadastro.Post;
    CliCadastro.Close;
    ExecutaComandoSql(CliAux,'UPDATE ORCAMENTOCOMPRAFORNECEDORITEM '+
                         ' SET CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                          ' Where CODFILIAL = '+CliTabela.FieldByName('CODFILIAL').AsString+
                          '  AND SEQORCAMENTO =  '+CliTabela.FieldByName('SEQORCAMENTO').AsString+
                          ' AND CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    ExecutaComandoSql(CliAux,'DELETE ORCAMENTOCOMPRAFORNECEDORCORPO '+
                          ' Where CODFILIAL = '+CliTabela.FieldByName('CODFILIAL').AsString+
                          '  AND SEQORCAMENTO =  '+CliTabela.FieldByName('SEQORCAMENTO').AsString+
                          ' AND CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
    CliTabela.next;
  end;
  CliTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.ExcluiClientePRODUTOFORNECEDOR(VpaCodClienteAExcluir, VpaCodClienteHistorico: Integer);
Var
  VpfLaco : Integer;
begin
  AdicionaSQLAbreTabela(CliTabela,'SELECT * FROM PRODUTOFORNECEDOR ' +
                                  ' Where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir));
  while not CliTabela.Eof do
  begin
    AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM PRODUTOFORNECEDOR ' +
                                    ' Where CODCLIENTE = '+IntToStr(VpaCodClienteHistorico)+
                                    ' and SEQPRODUTO = '+CliTabela.FieldByName('SEQPRODUTO').AsString+
                                    ' and CODCOR = '+CliTabela.FieldByName('CODCOR').AsString);
    if CliCadastro.Eof then
    begin
      CliCadastro.Insert;
      for VpfLaco := 0 to CliTabela.FieldCount - 1 do
        CliCadastro.FieldByName(CliTabela.Fields[VpfLaco].DisplayName).AsVariant := CliTabela.FieldByName(CliTabela.Fields[VpfLaco].DisplayName).AsVariant;
      CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodClienteHistorico;
      CliCadastro.Post;
      CliCadastro.Close;
    end;
    ExecutaComandoSql(CliAux,'DELETE FROM PRODUTOFORNECEDOR ' +
                                    ' Where CODCLIENTE = '+IntToStr(VpaCodClienteAExcluir)+
                                    ' and SEQPRODUTO = '+CliTabela.FieldByName('SEQPRODUTO').AsString+
                                    ' and CODCOR = '+CliTabela.FieldByName('CODCOR').AsString);
    CliTabela.Next
  end;
  CliTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.ExcluiClientesRamoAtividade(VpaCodRamoAtividade: integer);
Var
  VpfQtdClientes : Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'select count(*) QTD from CADCLIENTES '+
                           ' Where I_COD_RAM = '+IntToStr(VpaCodRamoAtividade));
  VpfQtdClientes := CliAux.FieldByName('QTD').AsInteger;
  ExecutaComandoSql(CliAux,'Delete from CADCLIENTES '+
                           ' Where I_COD_RAM = '+IntToStr(VpaCodRamoAtividade));
  aviso(IntToStr(VpfQtdClientes)+ ' clientes excluídos');
  ExecutaComandoSql(CliAux,'Delete from RAMO_ATIVIDADE '+
                           ' Where COD_RAMO_ATIVIDADE = '+IntToStr(VpaCodRamoAtividade));
end;

{******************************************************************************}
procedure TRBFuncoesClientes.ExcluiSuspect(VpaCodSuspect : Integer);
begin
  ExecutaComandoSql(CliAux,'Delete from PROSPECT '+
                           ' Where CODPROSPECT = '+IntToStr(VpaCodSuspect));
end;

{******************************************************************************}
function TRBFuncoesClientes.RDDDCliente(VpaNumTelefone : String ):String;
begin
  result := CopiaAteChar(VpaNumTelefone,')');
  result := DeletaChars(result,')');
  result := DeletaChars(result,' ');
  result := Deletachars(result,'(');
  result := DeletaChars(result,'*');
end;

{******************************************************************************}
function TRBFuncoesClientes.RTelefoneSemDDD(VpaNumTelefone : String):String;
begin
  result := DeleteAteChar(VpaNumTelefone,')');
  result := DeletaChars(result,' ');
  result := Deletachars(result,'-');
end;

{******************************************************************************}
function TRBFuncoesClientes.RCGCCPFCliente(VpaCodCliente : Integer) : String;
begin
  AdicionaSQLAbreTabela(CliAux,'Select C_CGC_CLI, C_CPF_CLI, C_TIP_PES FROM CADCLIENTES '+
                               ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));
  if CliAux.FieldByName('C_TIP_PES').AsString = 'J' then
    result := CliAux.FieldByName('C_CGC_CLI').AsString
  else
    result := CliAux.FieldByName('C_CPF_CLI').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RValDeslocamentoCliente(VpaNomCidade : String):Double;
begin
  AdicionaSqlAbreTabela(CliAux,'Select QTD_KM from CAD_CIDADES '+
                               ' Where DES_CIDADE = '''+VpaNomCidade+'''' );
  result := CliAux.FieldByName('QTD_KM').AsFloat * varia.ValKMRodado;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RUFCliente(VpaCodCliente : Integer):String;
begin
  AdicionaSqlAbreTabela(CliAux,'Select C_EST_CLI from CADCLIENTES '+
                               ' Where I_COD_CLI = ' +IntToStr(VpaCodCliente));
  result := CliAux.FieldByName('C_EST_CLI').AsString;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodCliente(VpaNomCliente : string) : Integer;
begin
  result := 0;
  if VpaNomCliente <> '' then
  begin
    AdicionaSQLAbreTabela(CliAux,'Select I_COD_CLI from CADCLIENTES '+
                                 ' Where C_NOM_CLI like '''+VpaNomCliente+'%''');
    result := CliAux.FieldByname('I_COD_CLI').AsInteger;
    CliAux.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodClientePeloTelefone(VpaDesTelefone : string):Integer;
begin
  result := 0;
  if VpaDesTelefone <> '' then
  begin
    AdicionaSQLAbreTabela(CliAux,'Select I_COD_CLI from CADCLIENTES '+
                                 ' Where( C_FO1_CLI = '''+VpaDesTelefone+'''or '+
                                 ' C_FO2_CLI = '''+VpaDesTelefone+'''or '+
                                 ' C_FO3_CLI = '''+VpaDesTelefone+'''or '+
                                 ' C_FON_FAX = '''+VpaDesTelefone+''')');
    result := CliAux.FieldByname('I_COD_CLI').AsInteger;
    CliAux.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.RCodClientePelaIdentificaoBancaria(VpaDesIdentificacaoBancaria : String) : Integer;
begin
  result := 0;
  if VpaDesIdentificacaoBancaria <> '' then
  begin
    AdicionaSQLAbreTabela(CliAux,'Select I_COD_CLI from CADCLIENTES '+
                                 ' Where C_IDE_BAN = '''+VpaDesIdentificacaoBancaria+'''');
    result := CliAux.FieldByName('I_COD_CLI').AsInteger;
    CliAux.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.RValemAbertoClienteCorrigido(VpaCodCliente : Integer) : Double;
var
  VpfValJuros : Double;
begin
  AdicionaSQLAbreTabela(CliTabela,'Select MCR.I_NRO_PAR, MCR.D_DAT_VEN, MCR.N_VLR_PAR, CR.I_LAN_ORC,  '+
                             ' MCR.I_LAN_REC, MCR.I_EMP_FIL, CR.D_DAT_EMI, CR.I_QTD_PAR, PAG.I_DIA_CAR ' +
                             '  from  MovContasaReceber MCR, CadContasaReceber CR, '+
                             '  CADCONDICOESPAGTO PAG'+
                             ' Where CR.I_EMP_FIL = MCR.I_EMP_FIL '+
                             ' and CR.I_LAN_REC = MCR.I_LAN_REC '+
                             ' and CR.I_COD_PAG = PAG.I_COD_PAG ' +
                             ' and MCR.I_COD_CLI = ' +IntToStr(VpaCodCliente)+
                             ' AND MCR.D_DAT_PAG IS NULL '+
                             ' AND MCR.C_FUN_PER = ''N''' );
  result := 0;
  while not CliTabela.Eof do
  begin
    VpfValJuros := 0;
    if (DiasPorPeriodo(CliTabela.FieldByName('D_DAT_VEN').AsDateTime,Date) > CliTabela.FieldByName('I_DIA_CAR').AsInteger) and
       (CliTabela.FieldByName('D_DAT_VEN').AsDateTime < date)  then
    begin
      VpfValJuros := ((CliTabela.FieldByName('N_VLR_PAR').AsFloat * Varia.Juro)/100);
      VpfValJuros := ((VpfValJuros /30)*DiasPorPeriodo(CliTabela.FieldByName('D_DAT_VEN').AsDateTime,Date));
    end;
    //retorna o valor de desconto da cotacao
    if CliTabela.FieldByName('I_QTD_PAR').AsInteger = 1 then
      VpfValJuros := VpfValJuros - FunContasAReceber.RDescontoCotacaoPgtoaVista(CliTabela.FieldByName('I_EMP_FIL').AsInteger,CliTabela.FieldByName('I_LAN_ORC').AsInteger,CliTabela.FieldByName('D_DAT_EMI').AsDateTime);
    result := result +(CliTabela.FieldByName('N_VLR_PAR').AsFloat + VpfValJuros);
    CliTabela.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDBrinde(VpaCodCliente : Integer;VpaBrindes : TList):String;
var
  VpfDBrinde : TRBDBrindeCliente;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(CliAux,'Delete from BRINDECLIENTE '+
                           ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from BRINDECLIENTE');
  for Vpflaco := 0 to VpaBrindes.count - 1 do
  begin
    VpfDBrinde := TRBDBrindeCliente(VpaBrindes.Items[Vpflaco]);
    CliCadastro.insert;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodcliente;
    CliCadastro.FieldByName('CODUSUARIO').AsInteger := VpfDBrinde.CodUsuario;    
    CliCadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDBrinde.SeqProduto;
    CliCadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDBrinde.QtdProduto;
    CliCadastro.FieldByName('DESUM').AsString := VpfDBrinde.UM;
    CliCadastro.FieldByName('DATCADASTRO').AsDateTime:= VpfDBrinde.DatCadastro;
    try
      CliCadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DO BRINDECLIENTE!!!'#13+e.message;
        break;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDProdutoCliente(VpaCodCliente : Integer;VpaProdutos : TList):String;
var
  VpfLaco : Integer;
  VpfDProduto : TRBDProdutoCliente;
begin
  result := '';
  ExecutaComandoSql(CliAux, 'DELETE FROM PRODUTOCLIENTEPECA ' +
                            ' WHERE CODCLIENTE = '+ IntToStr(VpaCodCliente));
  ExecutaComandoSql(CliAux,'Delete from PRODUTOCLIENTE '+
                           ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from PRODUTOCLIENTE '+
                                    ' WHERE SEQPRODUTO=0 AND SEQITEM=0 AND CODCLIENTE=0');
  for VpfLaco := 0 to VpaProdutos.Count - 1 do
  begin
    VpfDProduto := TRBDProdutoCliente(VpaProdutos.Items[VpfLaco]);
    CliCadastro.insert;
    CliCadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProduto.SeqProduto;
    VpfDProduto.SeqItem:= VpfLaco+1;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodcliente;
    VpfDProduto.CodCliente:= VpaCodCliente;
    CliCadastro.FieldByName('SEQITEM').AsInteger := VpfDProduto.SeqItem;
    CliCadastro.FieldByName('CODPRODUTO').AsString := VpfDProduto.CodProduto;
    CliCadastro.FieldByName('DESSETOR').AsString := VpfDProduto.DesSetorEmpresa;
    CliCadastro.FieldByName('DESOBSERVACAO').AsString := VpfDProduto.DesObservacoes;
    CliCadastro.FieldByName('NUMSERIE').AsString := VpfDProduto.NumSerieProduto;
    CliCadastro.FieldByName('NUMSERIEINTERNO').AsString := VpfDProduto.NumSerieInterno;
    CliCadastro.FieldByName('DESUM').AsString := VpfDProduto.UM;
    CliCadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDProduto.QtdProduto;
    CliCadastro.FieldByName('QTDCOPIAS').AsInteger := VpfDProduto.QtdCopias;
    CliCadastro.FieldByName('DATULTIMAALTERACAO').AsDatetime := VpfDProduto.DatUltimaAlteracao;
    if VpfDProduto.ValConcorrente > 0 then
      CliCadastro.FieldByName('VALCONCORRENTE').AsFloat := VpfDProduto.ValConcorrente
    else
      CliCadastro.FieldByName('VALCONCORRENTE').clear;
    if VpfDProduto.DatGarantia > montadata(1,1,1900) then
      CliCadastro.FieldByName('DATGARANTIA').AsDatetime := VpfDProduto.DatGarantia
    else
      CliCadastro.FieldByName('DATGARANTIA').clear;
    if VpfDProduto.CodDono <> 0 then
      CliCadastro.FieldByName('CODDONO').AsInteger := VpfDProduto.CodDono
    else
      CliCadastro.FieldByName('CODDONO').clear;

    CliCadastro.post;
    Result:= CliCadastro.AMensagemErroGravacao;
    if CliCadastro.AErronaGravacao then
     break;
    if Result = '' then
      Result := GravaDProdutoClientePeca(VpfDProduto);
    if Result <> '' then
      Break;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDProdutoClienteNota(VpaCodCliente: Integer;
  VpaProdutos: TList): String;
var
  VpfLaco : Integer;
  VpfDProduto : TRBDNotaFiscalProduto;
begin
  result := '';
  ExecutaComandoSql(CliAux,'Delete from PRODUTOCLIENTE '+
                           ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from PRODUTOCLIENTE ' +
                                    ' WHERE SEQPRODUTO =0 AND CODCLIENTE = 0 AND SEQITEM = 0');
  for VpfLaco := 0 to VpaProdutos.Count - 1 do
  begin
    VpfDProduto := TRBDNotaFiscalProduto(VpaProdutos.Items[VpfLaco]);
    CliCadastro.insert;
    CliCadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProduto.SeqProduto;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodcliente;
    CliCadastro.FieldByName('SEQITEM').AsInteger := VpfLaco+1;
    CliCadastro.FieldByName('CODPRODUTO').AsString := VpfDProduto.CodProduto;
    CliCadastro.FieldByName('DESUM').AsString := VpfDProduto.UM;
    CliCadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDProduto.QtdProduto;
    CliCadastro.FieldByName('NUMSERIE').AsString := VpfDProduto.DesRefCliente;
    CliCadastro.post;
    result := CliCadastro.AMensagemErroGravacao;
    if CliCadastro.AErronaGravacao then
      break;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDProdutoClientePeca(VpaDProdutoCliente: TRBDProdutoCliente): String;
var
  VpfLaco : Integer;
  VpfDProdutoPeca : TRBDProdutoClientePeca;
begin
  result := '';
  ExecutaComandoSql(CliAux,'Delete from PRODUTOCLIENTEPECA '+
                           ' Where  SEQPRODUTOCLIENTE = '+IntToStr(VpaDProdutoCliente.SeqProduto)+
                           ' AND SEQITEMPRODUTOCLIENTE = '+ IntToStr(VpaDProdutoCliente.SeqItem)+
                           ' AND CODCLIENTE = '+ IntToStr(VpaDProdutoCliente.CodCliente));
  AdicionaSQLAbreTabela(CliCadastro2,'SELECT * FROM PRODUTOCLIENTEPECA '+
                                    'WHERE SEQPRODUTOCLIENTE=0 AND CODCLIENTE=0 AND SEQITEMPRODUTOCLIENTE=0 AND SEQITEMPECA=0 ');
  for VpfLaco := 0 to VpaDProdutoCliente.Pecas.Count - 1 do
  begin
    VpfDProdutoPeca := TRBDProdutoClientePeca(VpaDProdutoCliente.Pecas.Items[VpfLaco]);
    CliCadastro2.insert;
    CliCadastro2.FieldByName('SEQPRODUTOCLIENTE').AsInteger := VpaDProdutoCliente.SeqProduto;
    CliCadastro2.FieldByName('CODCLIENTE').AsInteger := VpaDProdutoCliente.CodCliente;
    CliCadastro2.FieldByName('SEQITEMPRODUTOCLIENTE').AsInteger := VpaDProdutoCliente.SeqItem;
    CliCadastro2.FieldByName('SEQITEMPECA').AsInteger:= VpfLaco+1;
    CliCadastro2.FieldByName('SEQPRODUTOPECA').AsInteger:= VpfDProdutoPeca.SeqProdutoPeca;
    CliCadastro2.FieldByName('DESNUMSERIE').AsString := VpfDProdutoPeca.NumSerieProduto;
    CliCadastro2.FieldByName('DATINSTALACAO').AsDatetime := VpfDProdutoPeca.DatInstalacao;
    CliCadastro2.post;
    result := CliCadastro2.AMensagemErroGravacao;
    if CliCadastro2.AErronaGravacao then
      break;
  end;
  CliCadastro2.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AdicionaProdutoCliente(VpaCodCliente,VpaSeqProduto : Integer;VpaCodProduto, VpaUM : String):string;
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from PRODUTOCLIENTE');
  CliCadastro.Insert;
  CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
  CliCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  CliCadastro.FieldByName('CODPRODUTO').AsString := VpaCodProduto;
  CliCadastro.FieldByName('QTDPRODUTO').AsInteger := 1;
  CliCadastro.FieldByName('DESUM').AsString := VpaUM;
  CliCadastro.FieldByName('DATULTIMAALTERACAO').AsDatetime := now;

  CliCadastro.FieldByName('SEQITEM').AsInteger := RSeqProdutoClienteDisponivel(VpaCodCliente);
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO PRODUTO CLIENTE!!!'#13+e.message;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AdicionaTelefoneCliente(VpaArquivo: TStringList;VpaCodCliente : Integer; VpaUF, VpaTelefone, VpaNomCliente: string; VpaIndInadimplente,VpaIndFimVigencia: Boolean);
Var
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 1 to 5 do
  begin
    VpfLinha := copy(DeletaEspaco(DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaTelefone,'('),')'),'-'),'*')),1,10) + '|'+
    //codigo area acesso
    IntToStr(VpfLaco) + '|';
    if VpaIndInadimplente then
      VpfLinha :=  VpfLinha +'N|'
    else
      VpfLinha :=  VpfLinha +'S|';
    if VpaIndFimVigencia then
      VpfLinha :=  VpfLinha +'N|'
    else
      VpfLinha :=  VpfLinha +'S|';
    VpfLinha := VpfLinha + copy(AdicionaCharE('0',IntToStr(VpaCodCliente),7),3,7)+VpaUF+'|'+
    //nome cliente
    AdicionaCharD(' ',copy(VpaNomCliente,1,40),40)+'|';
    VpaArquivo.Add(VpfLinha);
  end;


end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDAgenda(VpaDAgenda : TRBDAgendaSisCorp): String;
begin
  result := '';
  if VpaDAgenda.SeqAgenda <> 0 then
  begin
    if VpaDAgenda.CodUsuario <>VpaDAgenda.CodUsuarioAnterior then
    begin
      ExecutaComandoSql(CliAux,'Delete from AGENDA '+
                                    ' Where CODUSUARIO = '+IntToStr(VpaDAgenda.CodUsuarioAnterior)+
                                    ' and SEQAGENDA = '+IntToStr(VpaDAgenda.SeqAgenda));
      VpaDAgenda.SeqAgenda := 0;
    end;
  end;
  AdicionaSQLAbreTabela(CliCadastro,'Select * from AGENDA '+
                                    ' Where CODUSUARIO = '+IntToStr(VpaDAgenda.CodUsuario)+
                                    ' and SEQAGENDA = '+IntToStr(VpaDAgenda.SeqAgenda));
  if VpaDAgenda.SeqAgenda = 0 then
    CliCadastro.Insert
  else
    CliCadastro.Edit;

  CliCadastro.FieldByName('CODUSUARIO').AsInteger := VpaDAgenda.CodUsuario;
  CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaDAgenda.CodCliente;
  CliCadastro.FieldByName('DATCADASTRO').AsDateTime := VpaDAgenda.DatCadastro;
  CliCadastro.FieldByName('DATINICIO').AsDateTime := VpaDAgenda.DatInicio;
  CliCadastro.FieldByName('DATFIM').AsDateTime := VpaDAgenda.DatFim;
  CliCadastro.FieldByName('CODTIPOAGENDAMENTO').AsInteger := VpaDAgenda.CodTipoAgendamento;
  CliCadastro.FieldByName('CODUSUARIOAGENDOU').AsInteger := VpaDAgenda.CodUsuarioAgendou;
  CliCadastro.FieldByName('DESTITULO').AsString := VpaDAgenda.DesTitulo;
  CliCadastro.FieldByName('DESOBSERVACAO').AsString := VpaDAgenda.DesObservacoes;
  if VpaDAgenda.IndRealizado then
    CliCadastro.FieldByName('INDREALIZADO').AsString := 'S'
  else
    CliCadastro.FieldByName('INDREALIZADO').AsString := 'N';
  if VpaDAgenda.IndCancelado then
    CliCadastro.FieldByName('INDCANCELADO').AsString := 'S'
  else
    CliCadastro.FieldByName('INDCANCELADO').AsString := 'N';
  if VpaDAgenda.CodFilialCompra <> 0 then
    CliCadastro.FieldByName('CODFILIALCOMPRA').AsInteger := VpaDAgenda.CodFilialCompra
  else
    CliCadastro.FieldByName('CODFILIALCOMPRA').Clear;
  if VpaDAgenda.SeqPedidoCompra <> 0 then
    CliCadastro.FieldByName('SEQPEDIDOCOMPRA').AsInteger := VpaDAgenda.SeqPedidoCompra
  else
    CliCadastro.FieldByName('SEQPEDIDOCOMPRA').Clear;

  if VpaDAgenda.SeqAgenda = 0 then
    VpaDAgenda.SeqAgenda := RSeqAgendaDisponivel(VpaDAgenda.CodUsuario);
  CliCadastro.FieldByName('SEQAGENDA').AsInteger := VpaDAgenda.SeqAgenda;
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA AGENDA!!!'#13+e.message;
  end;
  CliCadastro.close;
end;
{******************************************************************************}
function TRBFuncoesClientes.ApagaVisitaCliente(VpaSeqVisita: Integer): String;
begin
  Result:= '';
  try
    ExecutaComandoSql(CliCadastro,'DELETE FROM VISITACLIENTE'#13+
                                  ' WHERE SEQVISITA = '+IntToStr(VpaSeqVisita));
  except
    on E:Exception do
      Result:= 'ERRO AO APAGAR A VISITACLIENTE'#13+E.Message;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDAgendaCliente(VpaDAgendaCliente: TRBDAgendaCliente): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM VISITACLIENTE'+
                                    ' WHERE SEQVISITA = '+IntToStr(VpaDAgendaCliente.SeqVisita));
  if CliCadastro.Eof then
    CliCadastro.Insert
  else
    CliCadastro.Edit;

  CliCadastro.FieldByName('CODCLIENTE').AsInteger:= VpaDAgendaCliente.CodCliente;
  CliCadastro.FieldByName('CODTIPOAGENDAMENTO').AsInteger:= VpaDAgendaCliente.CodTipoAgendamento;
  CliCadastro.FieldByName('CODUSUARIO').AsInteger:= VpaDAgendaCliente.CodUsuario;
  CliCadastro.FieldByName('CODVENDEDOR').AsInteger:= VpaDAgendaCliente.CodVendedor;
  CliCadastro.FieldByName('DATCADASTRO').AsDateTime:= VpaDAgendaCliente.DatCadastro;
  CliCadastro.FieldByName('DATVISITA').AsDateTime:= VpaDAgendaCliente.DatVisita;
  CliCadastro.FieldByName('DATFIMVISITA').AsDateTime:= VpaDAgendaCliente.DatFimVisita;
  CliCadastro.FieldByName('INDREALIZADO').AsString:= VpaDAgendaCliente.IndRealizado;
  CliCadastro.FieldByName('DESAGENDA').AsString:= VpaDAgendaCliente.DesAgenda;
  CliCadastro.FieldByName('DESREALIZADO').AsString:= VpaDAgendaCliente.DesRealizado;
  if VpaDAgendaCliente.SeqVisita = 0 then
    VpaDAgendaCliente.SeqVisita:= FunClientes.RSeqVisitaDisponivel;
  CliCadastro.FieldByName('SEQVISITA').AsInteger:= VpaDAgendaCliente.SeqVisita;

  try
    CliCadastro.Post;
  except
    on E:Exception do
      Result:= 'ERRO NA GRAVAÇÃO DA AGENDACLIENTE!!!'#13+E.Message;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.RSeqVisitaDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT MAX(SEQVISITA) ULTIMO FROM VISITACLIENTE');
  Result:= CliAux.FieldByName('ULTIMO').AsInteger + 1;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDParentes(VpaCodCliente : Integer;VpaParentes : TList):String;
var
  VpfDParenteCliente : TRBDParenteCliente;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(CliAux,'Delete from PARENTECLIENTE '+
                           ' Where CODCLIENTEPARENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from PARENTECLIENTE');
  for Vpflaco := 0 to VpaParentes.count - 1 do
  begin
    VpfDParenteCliente := TRBDParenteCliente(VpaParentes.Items[Vpflaco]);
    CliCadastro.insert;
    CliCadastro.FieldByName('CODCLIENTEPARENTE').AsInteger := VpaCodcliente;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpfDParenteCliente.CodCliente;
    try
      CliCadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DO PARENTECLIENTE!!!'#13+e.message;
        break;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDDigitacaoProspect(VpaDDigProspect : TRBDDigitacaoProspect) :string;
var
  VpfLaco : Integer;
  VpfDProspect : TRBDDigitacaoProspectItem;
  VpfDTelemarketing : TRBDTelemarketing;
  VpfDTeleMarketingSuspect : TRBDTelemarketingProspect;
  VpfFunTelemarketing : TRBFuncoesTeleMarketing;
begin
  result := '';
  VpfFunTelemarketing := TRBFuncoesTeleMarketing.cria(CliCadastro.ASqlConnection);
  for VpfLaco := 0 to VpaDDigProspect.Prospects.Count - 1 do
  begin
    VpfDProspect := TRBDDigitacaoProspectItem(VpaDDigProspect.Prospects.Items[VpfLaco]);
    if VpfDProspect.CodProspect = 0 then
    begin
      if VpfDProspect.DesTipo = 'P' then
        result := GravaDProspectDigitado(VpaDDigProspect,VpfDProspect)
      else
        if VpfDProspect.DesTipo = 'S' then
          result := GravaDSusPectDigitado(VpaDDigProspect,VpfDProspect)
    end
    Else
      begin
        VprHouveAlteracao:= RSeHouveAlteracaoDigitacaoProspect(VpfDProspect);
        if VprHouveAlteracao then
          result := AlteraDProspectDigitado(VpaDDigProspect,VpfDProspect)
      end;
    if result = '' then
    begin
      if VpfDProspect.DesTipo = 'P' then
      begin
        VpfDTelemarketing := CarDTelemarketingProspect(VpaDDigProspect,VpfDProspect);
        Result := VpfFunTelemarketing.GravaDTeleMarketing(VpfDTelemarketing);
        VpfDTelemarketing.free;
      end
      else
        if VpfDProspect.DesTipo = 'S' then
        begin
          VpfDTeleMarketingSuspect := CarDTelemarketingSuspect(VpaDDigProspect,VpfDProspect);
          Result := VpfFunTelemarketing.GravaDTeleMarketingProspect(VpfDTeleMarketingSuspect);
          VpfDTeleMarketingSuspect.Free;
        end;
    end;
    if result <> '' then
      break;
  end;
  VpfFunTelemarketing.free;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.GeraArquivoURA(VpaNomArquivo: string);
var
  VpfArquivo : TStringList;
  VpfLinha : String;
  VpfClienteInadimplente,VpfFimVigencia : Boolean;
begin
  AdicionaSQLAbreTabela(CliCadastro,'SELECT  CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_FO1_CLI, CLI.C_FO2_CLI, CLI.C_FO3_CLI, CLI.C_FON_FAX, '+
                                    ' CLI.C_EST_CLI, CLI.C_IND_BLO, '+
                                   ' CON.CODFILIAL, CON.SEQCONTRATO,  CON.DATFIMVIGENCIA '+
                                   ' FROM CADCLIENTES CLI, CONTRATOCORPO CON, CONTRATOITEM ITE '+
                                   ' WHERE CLI.I_COD_CLI = CON.CODCLIENTE '+
                                   ' AND CON.CODFILIAL = ITE.CODFILIAL '+
                                   ' AND CON.SEQCONTRATO = ITE.SEQCONTRATO '+
                                   ' AND CON.DATCANCELAMENTO IS NULL '+
                                   ' AND ITE.SEQPRODUTO IN (1,66)'+
                                   ' AND CLI.C_IND_ATI = ''S''');
  VpfArquivo := TStringList.Create;
  while not CliCadastro.eof do
  begin
    VpfClienteInadimplente := CliCadastro.FieldByName('C_IND_BLO').AsString = 'S';
    VpfFimVigencia := CliCadastro.FieldByName('DATFIMVIGENCIA').AsDateTime < Date;
    if CliCadastro.FieldByName('C_FO1_CLI').AsString <> '' then
      AdicionaTelefoneCliente(VpfArquivo,CliCadastro.FieldByName('I_COD_CLI').AsInteger,CliCadastro.FieldByName('C_EST_CLI').AsString,CliCadastro.FieldByName('C_FO1_CLI').AsString,CliCadastro.FieldByName('C_NOM_CLI').AsString,VpfClienteInadimplente,VpfFimVigencia);
    if CliCadastro.FieldByName('C_FO2_CLI').AsString <> '' then
      AdicionaTelefoneCliente(VpfArquivo,CliCadastro.FieldByName('I_COD_CLI').AsInteger,CliCadastro.FieldByName('C_EST_CLI').AsString,CliCadastro.FieldByName('C_FO2_CLI').AsString,CliCadastro.FieldByName('C_NOM_CLI').AsString,VpfClienteInadimplente,VpfFimVigencia);
    if CliCadastro.FieldByName('C_FO3_CLI').AsString <> '' then
      AdicionaTelefoneCliente(VpfArquivo,CliCadastro.FieldByName('I_COD_CLI').AsInteger,CliCadastro.FieldByName('C_EST_CLI').AsString,CliCadastro.FieldByName('C_FO3_CLI').AsString,CliCadastro.FieldByName('C_NOM_CLI').AsString,VpfClienteInadimplente,VpfFimVigencia);
    if CliCadastro.FieldByName('C_FON_FAX').AsString <> '' then
      AdicionaTelefoneCliente(VpfArquivo,CliCadastro.FieldByName('I_COD_CLI').AsInteger,CliCadastro.FieldByName('C_EST_CLI').AsString,CliCadastro.FieldByName('C_FON_FAX').AsString,CliCadastro.FieldByName('C_NOM_CLI').AsString,VpfClienteInadimplente,VpfFimVigencia);
    AdicionaSQLAbreTabela(CliTabela,'Select * from CLIENTETELEFONE ' +
                                    ' WHERE CODCLIENTE = ' +IntToStr(CliCadastro.FieldByName('I_COD_CLI').AsInteger));
    while not CliTabela.Eof do
    begin
      AdicionaTelefoneCliente(VpfArquivo,CliCadastro.FieldByName('I_COD_CLI').AsInteger,CliCadastro.FieldByName('C_EST_CLI').AsString,CliTabela.FieldByName('DESTELEFONE').AsString,CliCadastro.FieldByName('C_NOM_CLI').AsString,VpfClienteInadimplente,VpfFimVigencia);
      CliTabela.Next
    end;

{    if VpfArquivo.Count > 500 then
      Break;}
    CliCadastro.Next;
  end;
  NaoExisteCriaDiretorio(Varia.PathVersoes+'\URA',false);
  VpfArquivo.SaveToFile(Varia.PathVersoes+'\URA\'+VpaNomArquivo);
  CliCadastro.Close;
  aviso('Arquivo "'+Varia.PathVersoes+'\URA\'+VpaNomArquivo+'" Gerado com sucesso');
  VpfArquivo.Free;
end;

{******************************************************************************}
function TRBFuncoesClientes.GeraCodigosClientes(VpaRegistro : TProgressBar; VpaLabel: TLabel): string;
var
  VpfQtdClientesAGerar : Integer;
begin
  result := '';
  VpfQtdClientesAGerar := Varia.QtdCodigoClienteGerar - RQtdCodigosClientes;
  VpaRegistro.Max:= VpfQtdClientesAGerar;
  VpaLabel.Caption:= 'Codigo cliente';
  VpaLabel.Refresh;
  inc(varia.CodUltimoClienteGerado);
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CODIGOCLIENTE');
  while VpfQtdClientesAGerar > 0 do
  begin
    while ExisteCliente(Varia.CodUltimoClienteGerado) do
      inc(varia.CodUltimoClienteGerado);
    CliCadastro.Insert;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := Varia.CodUltimoClienteGerado;
    CliCadastro.Post;
    dec(VpfQtdClientesAGerar);
    inc(varia.CodUltimoClienteGerado);
    VpaRegistro.Position:= VpaRegistro.Position + 1;
  end;
  CliCadastro.Close;
  ExecutaComandoSql(CliAux,'UPDATE CFG_GERAL SET I_ULT_CCG = '+IntToStr(Varia.CodUltimoClienteGerado));
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaCreditoCliente(VpaCodCliente : Integer;VpaCreditos : TList):string;
Var
  VpfLaco : Integer;
  VpfDCreditoCliente : TRBDCreditoCliente;
begin
  result := '';
  ExecutaComandoSql(CliAux,'Delete from CREDITOCLIENTE '+
                           ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CREDITOCLIENTE ');
  for VpfLaco := 0 to VpaCreditos.Count - 1 do
  begin
    VpfDCreditoCliente := TRBDCreditoCliente(VpaCreditos.Items[VpfLaco]);
    CliCadastro.insert;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
    CliCadastro.FieldByName('SEQCREDITO').AsInteger := VpfLaco +1;
    CliCadastro.FieldByName('VALINICIAL').AsFloat := VpfDCreditoCliente.ValInicial;
    CliCadastro.FieldByName('VALCREDITO').AsFloat := VpfDCreditoCliente.ValCredito;
    CliCadastro.FieldByName('DATCREDITO').AsDateTime := VpfDCreditoCliente.DatCredito;
    CliCadastro.FieldByName('DESOBSERVACAO').AsString := VpfDCreditoCliente.DesObservacao;
    case VpfDCreditoCliente.TipCredito of
      dcCredito: CliCadastro.FieldByName('TIPCREDITO').AsString := 'C';
      dcDebito: CliCadastro.FieldByName('TIPCREDITO').AsString := 'D';
    end;
    if VpfDCreditoCliente.IndFinalizado then
      CliCadastro.FieldByName('INDFINALIZADO').AsString := 'S'
    else
      CliCadastro.FieldByName('INDFINALIZADO').AsString := 'N';
    try
      CliCadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DO CREDITO DO CLIENTE!!!'#13+e.message;
        break;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDFaixaEtariaCliente(VpaCodCliente : Integer;VpaFaixasEtaria : TList):string;
Var
  VpfLaco : Integer;
  VpfDFaixaEtaria : TRBDFaixaEtariaCliente;
begin
  result := '';
  ExecutaComandoSql(CliAux,'Delete from FAIXAETARIACLIENTE '+
                           ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from FAIXAETARIACLIENTE');
  for VpfLaco := 0 to VpaFaixasEtaria.Count - 1 do
  begin
    VpfDFaixaEtaria := TRBDFaixaEtariaCliente(VpaFaixasEtaria.Items[VpfLaco]);
    CliCadastro.insert;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
    CliCadastro.FieldByName('CODFAIXAETARIA').AsInteger := VpfDFaixaEtaria.CodFaixaEtaria;
    try
      CliCadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DA FAIXAETARIACLIENTE!!!'#13+e.message;
        break;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDMarcaCliente(VpaCodCliente : Integer;VpaMarcas : TList):string;
Var
  VpfLaco : Integer;
  VpfDMarca : TRBDMarcaCliente;
begin
  result := '';
  ExecutaComandoSql(CliAux,'Delete from MARCACLIENTE '+
                           ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from MARCACLIENTE');
  for VpfLaco := 0 to VpaMarcas.Count - 1 do
  begin
    VpfDMarca := TRBDMarcaCliente(VpaMarcas.Items[VpfLaco]);
    CliCadastro.insert;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
    CliCadastro.FieldByName('CODMARCA').AsInteger := VpfDMarca.CodMarca;
    try
      CliCadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DA MARCACLIENTE!!!'#13+e.message;
        break;
      end;
    end;
  end;
  CliCadastro.close;
end;

//verificar mudar o nome para AtivarEmarketing
{******************************************************************************}
function TRBFuncoesClientes.AtivarEmailCliente(VpaCodCliente: Integer; VpaAtivar: Boolean): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * '+
                                    ' FROM CADCLIENTES CLI'+
                                    ' WHERE'+
                                    ' CLI.I_COD_CLI = '+IntToStr(VpaCodCliente));
  if CliCadastro.Eof then
    Result:= 'CLIENTE NÃO ENCONTRADO!!!'#13'Não foi possível localizar o cliente.';
  if Result = '' then
  begin
    CliCadastro.Edit;
    if VpaAtivar then
      CliCadastro.FieldByName('C_ACE_SPA').AsString:= 'S'
    else
      CliCadastro.FieldByName('C_ACE_SPA').AsString:= 'N';
    try
      CliCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATIVAR/DESATIVAR O CLIENTE!!!'#13+E.Message;
    end;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtivarEmailContatoCliente(VpaCodCliente, VpaSeqContato: Integer; VpaAtivar: Boolean): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * '+
                                    ' FROM CONTATOCLIENTE CCL'+
                                    ' WHERE'+
                                    ' CCL.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                                    ' AND CCL.SEQCONTATO = '+IntToStr(VpaSeqContato));
  if CliCadastro.Eof then
    Result:= 'CONTATO DO CLIENTE NÃO ENCONTRADO!!!'#13'Não foi possível localizar o contato do cliente.';
  if Result = '' then
  begin
    CliCadastro.Edit;
    if VpaAtivar then
      CliCadastro.FieldByName('INDACEITAEMARKETING').AsString:= 'S'
    else
      CliCadastro.FieldByName('INDACEITAEMARKETING').AsString:= 'N';
    try
      CliCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATIVAR/DESATIVAR O CONTATO DO CLIENTE!!!'#13+E.Message;
    end;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraEmailCliente(VpaCodCliente: Integer; VpaEmail: String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * '+
                                    ' FROM CADCLIENTES CLI'+
                                    ' WHERE'+
                                    ' CLI.I_COD_CLI = '+IntToStr(VpaCodCliente));
  if CliCadastro.Eof then
    Result:= 'CLIENTE NÃO ENCONTRADO!!!'#13'Não foi possível localizar o cliente.';
  if Result = '' then
  begin
    CliCadastro.Edit;
    CliCadastro.FieldByName('C_END_ELE').AsString:= VpaEmail;
    try
      CliCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATUALIZAR O EMAIL DO CLIENTE!!!'#13+E.Message;
    end;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraEmailContatoCliente(VpaCodCliente, VpaSeqContato: Integer; VpaEmail: String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * '+
                                    ' FROM CONTATOCLIENTE CCL'+
                                    ' WHERE'+
                                    ' CCL.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                                    ' AND CCL.SEQCONTATO = '+IntToStr(VpaSeqContato));
  if CliCadastro.Eof then
    Result:= 'CONTATO DO CLIENTE NÃO ENCONTRADO!!!'#13'Não foi possível localizar o contato do cliente.';
  if Result = '' then
  begin
    CliCadastro.Edit;
    CliCadastro.FieldByName('DESEMAIL').AsString:= VpaEmail;
    try
      CliCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATUALIZAR O EMAIL DO CONTATO DO CLIENTE!!!'#13+E.Message;
    end;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraEstagioAgenda(VpaDAgenda : TRBDAgendaSisCorp;VpaCodEstagio : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from AGENDA '+
                                    ' Where CODUSUARIO = '+IntToStr(VpaDAgenda.CodUsuario)+
                                    ' and SEQAGENDA = '+IntToStr(VpaDAgenda.SeqAgenda));
  if CliCadastro.Eof then
    result := 'REGISTRO NÃO ENCONTRADO!!!'#13'Não foi possível localizar o registro do agendamento.';
  if result = '' then
  begin
    CliCadastro.Edit;
    CliCadastro.FieldByName('CODESTAGIO').AsInteger := VpaCodEstagio;
    try
      CliCadastro.post;
    except
      on e : exception do result := 'ERRO NA GRAVAÇÃO DA ALTERAÇÃO DO ESTÁGIO DA AGENDA!!!'+e.message;
    end;
  end;
  Clicadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AlteraObservacaoCliente(VpaCodCliente : Integer;VpaDesObservacao : String);
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES '+
                                    ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));

  CliCadastro.Edit;
  CliCadastro.FieldByname('C_OBS_CLI').AsString := VpaDesObservacao;
  CliCadastro.Post;
  CliCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AlteraDatUltimoEmail(VpaCodCliente : Integer;VpaData : TDateTime);
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES '+
                                ' Where I_COD_CLI = ' + IntToStr(VpaCodCliente));
  CliCadastro.edit;
  CliCadaStro.FieldByname('D_ULT_EMA').AsDateTime := VpaData;
  CliCadastro.post;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraDatUltimaCompra(VpaCodCliente: Integer; VpaData: TDateTime): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM CADCLIENTES '+
                                    ' WHERE I_COD_CLI = ' + IntToStr(VpaCodCliente));
  CliCadastro.Edit;
  CliCadaStro.FieldByname('D_ULT_COM').AsDateTime := VpaData;
  try
    CliCadastro.Post;
  except
    on E:Exception do
      Result:= 'ERRO AO ATUALIZAR A DATA DA ULTIMA COMPRA.'#13+E.Message;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraDatUltimoRecebimento(VpaCodCliente: Integer; VpaData: TDateTime): String;
begin
  Result:= '';
  ExecutaComandosql(CliAux,'UPDATE CADCLIENTES '+
                           ' SET D_ULT_REC = ' +SQLTextoDataAAAAMMMDD(VpaData)+
                           ' WHERE I_COD_CLI = ' + IntToStr(VpaCodCliente));
end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraDDigitacaoProspect(
  VpaDDigProspect: TRBDDigitacaoProspect): string;
begin

end;

{******************************************************************************}
function TRBFuncoesClientes.AlteraDProspectDigitado(VpaDDigProspect: TRBDDigitacaoProspect;VpaDProspect: TRBDDigitacaoProspectItem): string;
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES '+
                                    ' WHERE I_COD_CLI = ' + IntToStr(VpaDProspect.CodProspect));
  CliCadastro.Edit;
  cliCadastro.FieldByName('D_DAT_ALT').AsDateTime := date;
  cliCadastro.FieldByName('C_END_CLI').AsString := VpaDProspect.DesEndereco;
  cliCadastro.FieldByName('C_BAI_CLI').AsString := VpaDProspect.DesBairro;
  cliCadastro.FieldByName('C_EST_CLI').AsString := VpaDProspect.DesUF;
  cliCadastro.FieldByName('C_CID_CLI').AsString := VpaDProspect.DesCidade;
  cliCadastro.FieldByName('C_FO1_CLI').AsString := VpaDProspect.DesFone;
  cliCadastro.FieldByName('C_FON_CEL').AsString := VpaDProspect.DesCelular;
  cliCadastro.FieldByName('C_END_ELE').AsString := VpaDProspect.DesEmail;
  cliCadastro.FieldByName('I_USU_ALT').AsInteger := varia.CodigoUsuario;
  if VpaDProspect.CodRamoAtividade <> 0 then
    cliCadastro.FieldByName('I_COD_RAM').AsInteger := VpaDProspect.CodRamoAtividade;
  CliCadastro.post;
  result := CliCadastro.AMensagemErroGravacao;
  CliCadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AlterarObsLigacao(VpaCodCliente : Integer;VpaDesObservacao : String);
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES '+
                                ' Where I_COD_CLI = ' + IntToStr(VpaCodCliente));
  CliCadastro.edit;
  if CliCadastro.FieldByname('C_OBS_TEL').AsString <> '' then
    VpaDesObservacao := #13+VpaDesObservacao;
  CliCadastro.FieldByname('C_OBS_TEL').AsString := VpaDesObservacao;
  CliCadastro.post;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.SetaAgendaConcluida(VpaCodUsuario,VpaSeqAgenda : Integer) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from AGENDA '+
                                    ' Where CODUSUARIO = '+ InttoStr(VpaCodUsuario)+
                                    ' and SEQAGENDA = '+InttoStr(VpaSeqAgenda));
  CliCadastro.edit;
  CliCadastro.FieldByName('INDREALIZADO').AsString := 'S';
  CliCadastro.FieldByName('DATREALIZADO').AsDatetime := now;
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA CONCLUSÃO DA AGENDA!!!'#13+e.message;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.SetaClienteComoFornecedor(VpaCodCliente : Integer):string;
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES '+
                                    ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));
  CliCadastro.edit;
  CliCadastro.FieldByName('C_IND_FOR').AsString := 'S';
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA TABELA CADCLIENTES!!!'#13+e.message;
  end;
  Clicadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.CancelaAgendamento(VpaCodUsuario,VpaSeqAgenda : Integer) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from AGENDA '+
                                    ' Where CODUSUARIO = '+ InttoStr(VpaCodUsuario)+
                                    ' and SEQAGENDA = '+InttoStr(VpaSeqAgenda));
  CliCadastro.edit;
  CliCadastro.FieldByName('INDCANCELADO').AsString := 'S';
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO CANCELAMENTO DA AGENDA!!!'#13+e.message;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExtornaAgendamento(VpaCodUsuario,VpaSeqAgenda : Integer) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from AGENDA '+
                                    ' Where CODUSUARIO = '+ InttoStr(VpaCodUsuario)+
                                    ' and SEQAGENDA = '+InttoStr(VpaSeqAgenda));
  CliCadastro.edit;
  CliCadastro.FieldByName('INDREALIZADO').AsString := 'N';
  CliCadastro.FieldByName('INDCANCELADO').AsString := 'N';
  CliCadastro.FieldByName('DATREALIZADO').Clear;
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO EXTORNO DA AGENDA!!!'#13+e.message;
  end;
  CliCadastro.close;

end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDBrinde(VpaCodCliente : Integer;VpaBrindes : TList);
var
  VpfDBrinde : TRBDBrindeCliente;
begin
  AdicionaSQLAbreTabela(CliTabela,'SELECT BRI.SEQPRODUTO, BRI.DESUM,BRI.QTDPRODUTO, '+
                                  ' PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.C_COD_PRO, '+
                                  ' BRI.CODUSUARIO, BRI.DATCADASTRO, USU.C_NOM_USU '+
                                  ' from BRINDECLIENTE BRI, CADPRODUTOS PRO, CADUSUARIOS USU '+
                                  ' Where BRI.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                                  ' and BRI.SEQPRODUTO = PRO.I_SEQ_PRO'+
                                  ' AND ' +SQLTEXTORightJoin('BRI.CODUSUARIO','USU.I_COD_USU'));
  FreeTObjectsList(VpaBrindes);
  While not CliTabela.Eof do
  begin
    VpfDBrinde := TRBDBrindeCliente.cria;
    VpaBrindes.Add(VpfDbrinde);
    VpfDBrinde.SeqProduto := CliTabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDBrinde.CodUsuario:= CliTabela.FieldByName('CODUSUARIO').AsInteger;
    VpfDBrinde.NomUsuario:= CliTabela.FieldByName('C_NOM_USU').AsString;
    VpfDBrinde.DatCadastro:= CliTabela.FieldByName('DATCADASTRO').AsDateTime;    
    VpfDBrinde.CodProduto := CliTabela.FieldByName('C_COD_PRO').AsString;
    VpfDBrinde.NomProduto := CliTabela.FieldByName('C_NOM_PRO').AsString;
    VpfDBrinde.UM := CliTabela.FieldByName('DESUM').AsString;
    VpfDBrinde.UMOriginal :=  CliTabela.FieldByName('C_COD_UNI').AsString;
    VpfDBrinde.QtdProduto := CliTabela.FieldByName('QTDPRODUTO').AsFloat;
    VpfDBrinde.UnidadeParentes := FunProdutos.RUnidadesParentes(VpfDBrinde.UMOriginal);
    CliTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDProdutoReserva(VpaCodCliente: Integer; VpaProdutosReserva: TList);
var
  VpfDProdutoReserva: TRBDProdutoReserva;
begin
   AdicionaSQLAbreTabela(CliTabela,'SELECT PRV.CODCLIENTE, PRV.SEQRESERVA,'+
                                   ' PRV.DATULTIMACOMPRA, PRV.SEQPRODUTO,'+
                                   ' PRV.CODPRODUTO, PRO.C_NOM_PRO,'+
                                   ' PRV.QTDDIASCONSUMO, PRV.INDCLIENTE,'+
                                   ' PRV.QTDPRODUTO '+
                                   ' FROM PRODUTORESERVA PRV, CADPRODUTOS PRO'+
                                   ' WHERE PRV.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                                   ' AND PRV.SEQPRODUTO = PRO.I_SEQ_PRO');
   FreeTObjectsList(VpaProdutosReserva);
   while not CliTabela.Eof do
   begin
      VpfDProdutoReserva:= TRBDProdutoReserva.cria;
      VpaProdutosReserva.Add(VpfDProdutoReserva);
      VpfDProdutoReserva.CodCliente:= CliTabela.FieldByName('CODCLIENTE').AsInteger;
      VpfDProdutoReserva.SeqReserva:= CliTabela.FieldByName('SEQRESERVA').AsInteger;
      VpfDProdutoReserva.SeqProduto:= CliTabela.FieldByName('SEQPRODUTO').AsInteger;
      VpfDProdutoReserva.QtdDiasConsumo:= CliTabela.FieldByName('QTDDIASCONSUMO').AsInteger;
      VpfDProdutoReserva.CodProduto:= CliTabela.FieldByName('CODPRODUTO').AsString;
      VpfDProdutoReserva.NomProduto:= CliTabela.FieldByName('C_NOM_PRO').AsString;
      VpfDProdutoReserva.DatUltimaCompra:= CliTabela.FieldByName('DATULTIMACOMPRA').AsDateTime;
      VpfDProdutoReserva.IndCliente:= CliTabela.FieldByName('INDCLIENTE').AsString;
      VpfDProdutoReserva.QtdProduto:= CliTabela.FieldByName('QTDPRODUTO').AsFloat;
      CliTabela.Next;
   end;
   CliTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDProdutoCliente(VpaCodCliente : Integer;VpaProdutos : TList);
var
  VpfDProduto : TRBDProdutoCliente;
begin
  FreeTObjectsList(VpaProdutos);
  AdicionaSQLAbreTabela(CliTabela,'SELECT PCL.SEQITEM,PCL.SEQPRODUTO, PCL.DESUM,PCL.QTDPRODUTO, '+
                                  ' PCL.NUMSERIE, PCL.NUMSERIEINTERNO, PCL.DESSETOR,PCL.CODDONO,'+
                                  ' PCL.DATGARANTIA, PCL.VALCONCORRENTE, PCL.QTDCOPIAS, PCL.DESOBSERVACAO, '+
                                  ' PCL.DATULTIMAALTERACAO, '+
                                  ' PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.C_COD_PRO, '+
                                  ' DON.NOMDONO '+
                                  ' from PRODUTOCLIENTE PCL, CADPRODUTOS PRO, DONOPRODUTO DON '+
                                  ' Where PCL.CODCLIENTE = '+IntToStr(VpaCodCliente)+
                                  ' and PCL.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND '+ SQLTextoRightJoin('PCL.CODDONO','DON.CODDONO')+
                                  ' order by PCL.SEQITEM');
  While not CliTabela.Eof do
  begin
    VpfDProduto := TRBDProdutoCliente.cria;
    VpaProdutos.add(VpfDProduto);
    VpfDProduto.SeqProduto := CliTabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDProduto.SeqItem := CliTabela.FieldByName('SEQITEM').AsInteger;
    VpfDProduto.CodProduto := CliTabela.FieldByName('C_COD_PRO').AsString;
    VpfDProduto.NomProduto := CliTabela.FieldByName('C_NOM_PRO').AsString;
    VpfDProduto.NumSerieProduto := CliTabela.FieldByName('NUMSERIE').AsString;
    VpfDProduto.NumSerieInterno := CliTabela.FieldByName('NUMSERIEINTERNO').AsString;
    VpfDProduto.DesSetorEmpresa := CliTabela.FieldByName('DESSETOR').AsString;
    VpfDProduto.UM := CliTabela.FieldByName('DESUM').AsString;
    VpfDProduto.UMOriginal := CliTabela.FieldByName('C_COD_UNI').AsString;
    VpfDProduto.UnidadeParentes := FunProdutos.RUnidadesParentes(VpfDProduto.UMOriginal);
    VpfDProduto.QtdProduto := CliTabela.FieldByName('QTDPRODUTO').AsFloat;
    VpfDProduto.CODDONO := CliTabela.FieldByName('CODDONO').AsInteger;
    VpfDProduto.QtdCopias := CliTabela.FieldByName('QTDCOPIAS').AsInteger;
    VpfDProduto.NomDono := CliTabela.FieldByName('NOMDONO').AsString;
    VpfDProduto.DatGarantia := CliTabela.FieldByName('DATGARANTIA').AsDateTime;
    VpfDProduto.DatUltimaAlteracao := CliTabela.FieldByName('DATULTIMAALTERACAO').AsDateTime;
    VpfDProduto.ValConcorrente := CliTabela.FieldByName('ValConcorrente').AsFloat;
    VpfDProduto.DesObservacoes := CliTabela.FieldByName('DESOBSERVACAO').AsString;
    VpfDProduto.CodCliente:= VpaCodCliente;

    CarDProdutoClientePeca(VpfDProduto);
    CliTabela.next;
  end;
  CliTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDProdutoClientePeca(VpaDProdutoCliente: TRBDProdutoCliente);
var
  VpfDProdutoPeca : TRBDProdutoClientePeca;
begin
  FreeTObjectsList(VpaDProdutoCliente.Pecas);
  AdicionaSQLAbreTabela(CliCadastro,'SELECT PCL.SEQPRODUTOPECA, PCL.SEQITEMPECA, PCL.DESNUMSERIE, PCL.DATINSTALACAO, '+
                                  ' PRO.C_NOM_PRO, PRO.C_COD_PRO, PRO.I_SEQ_PRO ' +
                                  'FROM PRODUTOCLIENTEPECA PCL, CADPRODUTOS PRO '+
                                  'WHERE SEQPRODUTOCLIENTE = ' + IntToStr(VpaDProdutoCliente.SeqProduto)+
                                  'AND CODCLIENTE = ' + IntToStr(VpaDProdutoCliente.CodCliente) +
                                  'AND SEQITEMPRODUTOCLIENTE = ' + IntToStr(VpaDProdutoCliente.SeqItem) +
                                  'AND PCL.SEQPRODUTOPECA = PRO.I_SEQ_PRO');
  While not CliCadastro.Eof do
  begin
    VpfDProdutoPeca:= VpaDProdutoCliente.addPecas;
    VpfDProdutoPeca.SeqItemPeca:= CliCadastro.FieldByName('SEQITEMPECA').AsInteger;
    VpfDProdutoPeca.SeqProdutoPeca:= CliCadastro.FieldByName('SEQPRODUTOPECA').AsInteger;
    VpfDProdutoPeca.NumSerieProduto:= CliCadastro.FieldByName('DESNUMSERIE').AsString;
    VpfDProdutoPeca.DatInstalacao:= CliCadastro.FieldByName('DATINSTALACAO').AsDateTime;
    VpfDProdutoPeca.CodProduto:= CliCadastro.FieldByName('C_COD_PRO').AsString;
    VpfDProdutoPeca.NomProduto:= CliCadastro.FieldByName('C_NOM_PRO').AsString;
    CliCadastro.next;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDAgenda(VpaCodUsuario,VpaSeqAgenda : Integer;VpaDAgenda : TRBDAgendaSisCorp);
begin
  AdicionaSQLAbreTabela(CliTabela,'Select * from AGENDA '+
                                    ' Where CODUSUARIO = '+IntToStr(VpaCodUsuario)+
                                    ' and SEQAGENDA = '+IntToStr(VpaSeqAgenda));
  with VpaDAgenda do
  begin
    CodUsuario := CliTabela.FieldByName('CODUSUARIO').AsInteger;
    CodUsuarioAnterior := CodUsuario;
    CodCliente := CliTabela.FieldByName('CODCLIENTE').AsInteger;
    DatCadastro := CliTabela.FieldByName('DATCADASTRO').AsDateTime;
    DatInicio := CliTabela.FieldByName('DATINICIO').AsDateTime;
    DatFim := CliTabela.FieldByName('DATFIM').AsDateTime;
    DatRealizado := CliTabela.FieldByName('DATREALIZADO').AsDateTime;
    CodTipoAgendamento := CliTabela.FieldByName('CODTIPOAGENDAMENTO').AsInteger;
    CodUsuarioAgendou := CliTabela.FieldByName('CODUSUARIOAGENDOU').AsInteger;
    DesObservacoes := CliTabela.FieldByName('DESOBSERVACAO').AsString;
    DesTitulo := CliTabela.FieldByName('DESTITULO').AsString;
    IndRealizado := CliTabela.FieldByName('INDREALIZADO').AsString = 'S';
    IndCancelado := CliTabela.FieldByName('INDCANCELADO').AsString = 'S';
    SeqAgenda := CliTabela.FieldByName('SEQAGENDA').AsInteger;
  end;
  CliTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDParenteCliente(VpaCodCliente : Integer;VpaParentes : TList);
var
  VprDParenteCliente : TRBDParenteCliente;
begin
  FreeTObjectsList(VpaParentes);
  AdicionaSQLAbreTabela(CliTabela,'Select CLI.C_NOM_CLI, PAR.CODCLIENTE '+
                                   ' from PARENTECLIENTE PAR, CADCLIENTES CLI '+
                                   ' Where PAR.CODCLIENTEPARENTE = ' +IntToStr(VpaCodCliente)+
                                   ' and PAR.CODCLIENTE = CLI.I_COD_CLI');
  While not CliTabela.Eof do
  begin
    VprDParenteCliente := TRBDParenteCliente.cria;
    VpaParentes.add(VprDParenteCliente);
    VprDParenteCliente.CodCliente := CliTabela.FieldByName('CODCLIENTE').AsInteger;
    VprDParenteCliente.NomCliente := CliTabela.FieldByName('C_NOM_CLI').AsString;
    CliTabela.next;
  end;
  CliTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDVisitaCliente(VpaSeqVisita: Integer; VpaDVisitaCliente: TRBDAgendaCliente);
begin
  AdicionaSQLAbreTabela(CliTabela,'SELECT'+
                                  ' VPC.SEQVISITA,'+
                                  ' VPC.DATCADASTRO, VPC.DATVISITA, VPC.DATFIMVISITA,'+
                                  ' VPC.CODCLIENTE, VPC.CODVENDEDOR, VPC.INDREALIZADO,'+
                                  ' VPC.CODTIPOAGENDAMENTO, VPC.CODUSUARIO, VPC.DESAGENDA, '+
                                  ' VPC.DESREALIZADO '+
                                  ' FROM'+
                                  ' VISITACLIENTE VPC '+
                                  ' WHERE VPC.SEQVISITA = '+ IntToStr(VpaSeqVisita));
  VpaDVisitaCliente.SeqVisita:= VpaSeqVisita;
  VpaDVisitaCliente.CodCliente:= CliTabela.FieldByName('CODCLIENTE').AsInteger;
  VpaDVisitaCliente.CodTipoAgendamento:= CliTabela.FieldByName('CODTIPOAGENDAMENTO').AsInteger;
  VpaDVisitaCliente.CodUsuario:= CliTabela.FieldByName('CODUSUARIO').AsInteger;
  VpaDVisitaCliente.CodVendedor:= CliTabela.FieldByName('CODVENDEDOR').AsInteger;
  VpaDVisitaCliente.DatCadastro:= CliTabela.FieldByName('DATCADASTRO').AsDateTime;
  VpaDVisitaCliente.DatVisita:= CliTabela.FieldByName('DATVISITA').AsDateTime;
  VpaDVisitaCliente.DatFimVisita:= CliTabela.FieldByName('DATFIMVISITA').AsDateTime;
  VpaDVisitaCliente.IndRealizado:= CliTabela.FieldByName('INDREALIZADO').AsString;
  VpaDVisitaCliente.DesAgenda:= CliTabela.FieldByName('DESAGENDA').AsString;
  VpaDVisitaCliente.DesRealizado:= CliTabela.FieldByName('DESREALIZADO').AsString;
  CliTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarCreditoCliente(VpaCodCliente : Integer;VpaCreditos : TList;VpaSomenteAtivos :Boolean;VpaTipo : TRBDTipoCreditoDebito );
var
  VpfDCredito : TRBDCreditoCliente;
begin
  FreeTObjectsList(VpaCreditos);
  CliTabela.Sql.clear;
  CliTabela.sql.add('Select * from CREDITOCLIENTE '+
                                  ' Where CODCLIENTE =  '+IntToStr(VpaCodCliente));
  if VpaSomenteAtivos then
    CliTabela.sql.add(' and INDFINALIZADO = ''N''');
  case VpaTipo of
    dcCredito: CliTabela.sql.add(' and TIPCREDITO = ''C''');
    dcDebito:  CliTabela.sql.add(' and TIPCREDITO = ''D''');
  end;


  CliTabela.sql.add(' order by DATCREDITO DESC');
  CliTabela.open;
  while not CliTabela.eof do
  begin
    VpfDCredito := TRBDCreditoCliente.cria;
    VpaCreditos.add(VpfDCredito);
    VpfDCredito.CodCliente := VpaCodCliente;
    VpfDCredito.SeqCredito := CliTabela.FieldByName('SEQCREDITO').AsInteger;
    VpfDCredito.ValInicial := CliTabela.FieldByName('VALINICIAL').AsFloat;
    VpfDCredito.ValCredito := CliTabela.FieldByName('VALCREDITO').AsFloat;
    VpfDCredito.DatCredito := CliTabela.FieldByName('DATCREDITO').AsDateTime;
    VpfDCredito.DesObservacao := CliTabela.FieldByName('DESOBSERVACAO').AsString;
    if CliTabela.FieldByName('TIPCREDITO').AsString = 'C' then
      VpfDCredito.TipCredito := dcCredito
    else
      VpfDCredito.TipCredito := dcDebito;
    VpfDCredito.IndFinalizado := (CliTabela.FieldByName('INDFINALIZADO').AsString = 'S');
    CliTabela.next;
  end;
  CliTabela.Close;
end;


{******************************************************************************}
procedure TRBFuncoesClientes.CarDComprador(VpaDComprador : TRBDComprador;VpaCodComprador : Integer);
begin
  AdicionaSQLAbreTabela(CliTabela,'Select CODCOMPRADOR, NOMCOMPRADOR, DESEMAIL from COMPRADOR '+
                               ' Where CODCOMPRADOR = ' + IntToStr(VpaCodComprador));
  VpaDComprador.CodComprador := CliTabela.FieldByname('CODCOMPRADOR').AsInteger;
  VpaDComprador.NomComprador := CliTabela.FieldByname('NOMCOMPRADOR').AsString;
  VpaDComprador.DesEmail := CliTabela.FieldByname('DESEMAIL').AsString;
  CliTabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDFaixaEtaria(VpaCodCliente : Integer; VpaFaixasEtaria : TList);
var
  VpfDFaixaEtaria : TRBDFaixaEtariaCliente;
begin
  FreeTObjectsList(VpaFaixasEtaria);
  AdicionaSQLAbreTabela(CliTabela,'Select FAI.CODFAIXAETARIA, FAI.NOMFAIXAETARIA '+
                                  ' FROM FAIXAETARIACLIENTE FCL, FAIXAETARIA FAI '+
                                  ' Where FCL.CODCLIENTE = '+IntTostr(VpaCodCliente)+
                                  ' and FCL.CODFAIXAETARIA = FAI.CODFAIXAETARIA'+
                                  ' ORDER BY FAI.NOMFAIXAETARIA ');
  While not CliTabela.eof do
  begin
    VpfDFaixaEtaria := TRBDFaixaEtariaCliente.cria;
    VpaFaixasEtaria.Add(VpfDFaixaEtaria);
    VpfDFaixaEtaria.CodFaixaEtaria := CliTabela.FieldByName('CODFAIXAETARIA').AsInteger;
    VpfDFaixaEtaria.NomFaixaEtaria := CliTabela.FieldByName('NOMFAIXAETARIA').AsString;
    CliTabela.Next;
  end;
  CliTabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDMarca(VpaCodCliente : Integer;VpaMarcas : TList);
var
  VpfDMarca : TRBDMarcaCliente;
begin
  FreeTObjectsList(VpaMarcas);
  AdicionaSQLAbreTabela(CliTabela,'Select MAR.CODMARCA, MAR.NOMMARCA '+
                                  ' FROM MARCACLIENTE MCL, MARCA MAR '+
                                  ' Where MCL.CODCLIENTE = '+IntTostr(VpaCodCliente)+
                                  ' and MCL.CODMARCA = MAR.CODMARCA '+
                                  ' ORDER BY MAR.NOMMARCA ');
  While not CliTabela.eof do
  begin
    VpfDMarca := TRBDMarcaCliente.cria;
    VpaMarcas.Add(VpfDMarca);
    VpfDMarca.CodMarca := CliTabela.FieldByName('CODMARCA').AsInteger;
    VpfDMarca.NomMarca := CliTabela.FieldByName('NOMMARCA').AsString;
    CliTabela.Next;
  end;
  CliTabela.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.BaixaEstoqueBrinde(VpaCodCliente, VpaSeqProduto : integer;VpaQtdProduto : Double;VpaUM : String;VpaIndSaidaEstoque : Boolean):string;
var
  VpfQtd : Double;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from BRINDECLIENTE '+
                                   ' Where CODCLIENTE = '+InttoStr(VpaCodCliente)+
                                   ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto));
  if VpaIndSaidaEstoque then
  begin
    VpfQtd := FunProdutos.CalculaQdadePadrao(VpaUM,CliCadastro.FieldByName('DESUM').AsString,VpaQtdProduto,IntToStr(VpaseqProduto));
    if VpfQtd = CliCadastro.FieldByName('QTDPRODUTO').AsFloat then
      CliCadastro.delete
    else
    begin
      CliCadastro.edit;
      CliCadastro.FieldByName('QTDPRODUTO').AsFloat := CliCadastro.FieldByName('QTDPRODUTO').AsFloat - VpfQtd;
      try
        CliCadastro.post;
      except
        on e : exception do result:= 'ERRO NA BAIXA(SUBTRAÇÃO) DO ESTOQUE DOS BRINDES!!!'#13+e.message;
      end;
    end;
  end
  else
  begin
    if CliCadastro.Eof then
    begin
      CliCadastro.insert;
      CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
      CliCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
      CliCadastro.FieldByName('QTDPRODUTO').AsFloat := VpaQtdProduto;
      CliCadastro.FieldByName('DESUM').AsString := VpaUM;
      try
        CliCadastro.post;
      except
        on e : exception do result:= 'ERRO NA BAIXA(ADIÇÃO) DO ESTOQUE DOS BRINDES!!!'#13+e.message;
      end;
    end
    else
    begin
      VpfQtd := FunProdutos.CalculaQdadePadrao(VpaUM,CliCadastro.FieldByName('DESUM').AsString,VpaQtdProduto,IntToStr(VpaseqProduto));
      CliCadastro.edit;
      CliCadastro.FieldByName('QTDPRODUTO').AsFloat := CliCadastro.FieldByName('QTDPRODUTO').AsFloat + VpfQtd;
      try
        CliCadastro.post;
      except
        on e : exception do result:= 'ERRO NA BAIXA(SUBTRAÇÃO) DO ESTOQUE DOS BRINDES!!!'#13+e.message;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.BloqueiaClientesAtrasados;
begin
  CliAux.Close;
  CliAux.SQL.Clear;
  CliAux.SQL.Add('UPDATE CADCLIENTES CLI ' +
                 ' SET C_IND_BLO = ''S'',' +
                 ' D_DAT_ALT = TO_DATE('''+ DateToStr(Sistema.RDataServidor)+ ''',''DD/MM/YYYY'')' +
                 ' WHERE EXISTS( ' +
                 ' SELECT 1 FROM MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD ' +
                 ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                 ' AND MOV.I_LAN_REC = CAD.I_LAN_REC ' +
                 ' AND MOV.D_DAT_VEN <= TO_DATE('''+ DateToStr(FunData.DecDia(Now,2)) +''',''DD/MM/YYYY'')' +
                 ' AND MOV.D_DAT_PAG IS NULL ');
  if config.BloquearClientesAutomaticoSomentedaFilialLogada then
    CliAux.SQL.Add('and MOV.I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil));
  CliAux.SQL.Add(' AND CLI.I_COD_CLI = CAD.I_COD_CLI)');
  CliAux.ExecSQL;
end;

{******************************************************************************}
function TRBFuncoesClientes.ImportaClientesWeg(VpaNomArquivo : String; VpaBarraStatus : TStatusBar;VpaProgresso : TProgressBar) : String;
var
  VpfArquivo : TStringList;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  AtualizaStatusBar(VpaBarraStatus,'');

  VpfArquivo := TStringList.Create;
  VpfArquivo.loadFromFile(VpaNomArquivo);
  VpaProgresso.Max := VpfArquivo.count;
  VpaProgresso.Position := 0;

  for VpfLaco := 0 to VpfArquivo.Count - 1 do
  begin
    VpfLinha := VpfArquivo.Strings[VpfLaco];
    if DeletaChars(VpfLinha,' ') <> '' then
    begin
      AtualizaStatusBar(VpaBarraStatus,'Importando cliente "'+copy(VpfLinha,10,30)+'"');
      if ExisteClienteWEG(CliCadastro,StrToInt(DeletaCharE(copy(VpfLinha,4,6),' ')),DeletaCharD(copy(VpfLinha,10,30),' ')) then
        CliCadastro.Edit
      else
      begin
        CliCadastro.insert;
        CliCadastro.FieldByName('C_NOM_CLI').AsString := DeletaCharD(copy(VpfLinha,10,30),' ');
        CliCadastro.FieldByName('I_COD_CLI').AsInteger := RCodClienteDisponivel;
        CliCadastro.FieldByName('C_TIP_CAD').AsString := 'C';
      end;
      CliCadastro.FieldByName('C_TIP_PES').AsString := 'F';
      CliCadastro.FieldByName('I_COD_WEG').AsInteger := StrToInt(DeletaCharE(copy(VpfLinha,4,6),' '));
      CliCadastro.FieldByName('C_FUN_WEG').AsString := 'S';
      CliCadastro.FieldByName('C_SIG_WEG').AsString := copy(VpfLinha,1,3);
      try
        CliCadastro.post;
      except
        on e: exception do
        begin
          result := 'ERRO NA IMPORTAÇÃO DO CLIENTE!!!'#13+e.message;
          Clicadastro.close;
          exit;
        end;
      end;
      VpaProgresso.Position := VpaProgresso.Position +1;
    end;
  end;
  VpfArquivo.free;
  Clicadastro.close;
  if result = '' then
    result := 'Importação realizada com sucesso.';
  AtualizaStatusBar(VpaBarraStatus,'Importação realizada com sucesso');
end;

{******************************************************************************}
function TRBFuncoesClientes.ImportaProdutosProspect(VpaCodProspect, VpaCodCliente: Integer): String;
var
  VpfLaco: Integer;
  VpfListProdutosProspect,
  VpfListProdutosCliente: TList;
  VpfProdutosProspect: TRBDProdutoProspect;
  VpfProdutosCliente: TRBDProdutoCliente;
begin
  VpfListProdutosProspect:= TList.Create;
  VpfListProdutosCliente:= TList.Create;

  FunProspect.CarDProdutoProspect(VpaCodProspect,VpfListProdutosProspect);
  for VpfLaco:= 0 to VpfListProdutosProspect.Count-1 do
  begin
    VpfProdutosProspect:= TRBDProdutoProspect(VpfListProdutosProspect.Items[VpfLaco]);
    VpfProdutosCliente:= TRBDProdutoCliente.cria;
    VpfListProdutosCliente.Add(VpfProdutosCliente);

    VpfProdutosCliente.SeqProduto:= VpfProdutosProspect.SeqProduto;
    VpfProdutosCliente.SeqItem:= VpfProdutosProspect.SeqItem;
    VpfProdutosCliente.CodDono:= VpfProdutosProspect.CodDono;
    VpfProdutosCliente.QtdCopias:= VpfProdutosProspect.QtdCopias;
    VpfProdutosCliente.CodProduto:= VpfProdutosProspect.CodProduto;
    VpfProdutosCliente.NomProduto:= VpfProdutosProspect.NomProduto;
    VpfProdutosCliente.NumSerieProduto:= VpfProdutosProspect.NumSerie;
    VpfProdutosCliente.NumSerieInterno:= VpfProdutosProspect.NumSerieInterno;
    VpfProdutosCliente.DesSetorEmpresa:= VpfProdutosProspect.DesSetor;
    VpfProdutosCliente.NomDono:= VpfProdutosProspect.NomDono;
    VpfProdutosCliente.UM:= VpfProdutosProspect.DesUM;
    VpfProdutosCliente.UMOriginal:= VpfProdutosProspect.DesUM;
    VpfProdutosCliente.DesObservacoes:= VpfProdutosProspect.DesObservacao;
    VpfProdutosCliente.DatGarantia:= VpfProdutosProspect.DatGarantia;
    VpfProdutosCliente.DatUltimaAlteracao:= Now;
    VpfProdutosCliente.UnidadeParentes:= VpfProdutosProspect.UnidadeParentes;
    VpfProdutosCliente.ValConcorrente:= VpfProdutosProspect.ValConcorrente;
    VpfProdutosCliente.QtdProduto:= VpfProdutosProspect.QtdProduto;
  end;

  Result:= FunClientes.GravaDProdutoCliente(VpaCodCliente,VpfListProdutosCliente);

  FreeTObjectsList(VpfListProdutosProspect);
  FreeTObjectsList(VpfListProdutosCliente);
  VpfListProdutosProspect.Free;
  VpfListProdutosCliente.Free;
end;

{******************************************************************************}
function TRBFuncoesClientes.ImportaContatosProspect(VpaCodProspect, VpaCodCliente: Integer): String;
var
  VpfLaco: Integer;
  VpfListContatosProspect,
  VpfListContatosCliente: TList;
  VpfContatoProspect: TRBDContatoProspect;
  VpfContatoCliente: TRBDContatoCliente;
begin
  VpfListContatosProspect:= TList.Create;
  VpfListContatosCliente:= TList.Create;

  FunProspect.CarDContatoProspect(VpaCodProspect,VpfListContatosProspect);
  for VpfLaco:= 0 to VpfListContatosProspect.Count-1 do
  begin
    VpfContatoProspect:= TRBDContatoProspect(VpfListContatosProspect.Items[VpfLaco]);
    VpfContatoCliente:= TRBDContatoCliente.cria;
    VpfListContatosCliente.Add(VpfContatoCliente);

    VpfContatoCliente.DatNascimento:= VpfContatoProspect.DatNascimento;
    VpfContatoCliente.NomContato:= VpfContatoProspect.NomContato;
    VpfContatoCliente.DesTelefone:= VpfContatoProspect.FonContato;
    VpfContatoCliente.DesCelular:= VpfContatoProspect.CelContato;
    VpfContatoCliente.DesEMail:= VpfContatoProspect.EmailContato;
    VpfContatoCliente.NomProfissao:= VpfContatoProspect.NomProfissao;
    VpfContatoCliente.DesObservacao:= VpfContatoProspect.DesObservacoes;
    VpfContatoCliente.AceitaEMarketing:= VpfContatoProspect.AceitaEMarketing;
    VpfContatoCliente.CodProfissao:= VpfContatoProspect.CodProfissao;
    VpfContatoCliente.CodUsuario:= VpfContatoProspect.CodUsuario;
  end;

  Result:= FunClientes.GravaDContatos(VpaCodCliente,VpfListContatosCliente);

  FreeTObjectsList(VpfListContatosProspect);
  FreeTObjectsList(VpfListContatosCliente);
  VpfListContatosProspect.Free;
  VpfListContatosCliente.Free;
end;

{******************************************************************************}
function TRBFuncoesClientes.ImportaTelemarketingProspect(VpaCodProspect, VpaCodCliente: Integer): String;
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from TELEMARKETING');
  AdicionaSQLAbreTabela(CliTabela,'Select * from TELEMARKETINGPROSPECT '+
                                  ' Where CODPROSPECT = '+IntToStr(VpaCodProspect));
  While not CliTabela.Eof do
  begin
    CliCadastro.insert;
    CliCadastro.FieldByName('CODFILIAL').AsInteger := Varia.CodigoEmpFil;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
    CliCadastro.FieldByName('CODUSUARIO').AsInteger := CliTabela.FieldByName('CODUSUARIO').AsInteger;
    CliCadastro.FieldByName('DATLIGACAO').AsDateTime := CliTabela.FieldByName('DATLIGACAO').AsDateTime;
    CliCadastro.FieldByName('DESFALADOCOM').AsString := CliTabela.FieldByName('DESFALADOCOM').AsString;
    CliCadastro.FieldByName('DESOBSERVACAO').AsString := CliTabela.FieldByName('DESOBSERVACAO').AsString;
    CliCadastro.FieldByName('CODHISTORICO').AsInteger := CliTabela.FieldByName('CODHISTORICO').AsInteger;
    CliCadastro.FieldByName('QTDSEGUNDOSLIGACAO').AsInteger := CliTabela.FieldByName('QTDSEGUNDOSLIGACAO').AsInteger;
    CliCadastro.FieldByName('DATTEMPOLIGACAO').AsDateTime := CliTabela.FieldByName('DATTEMPOLIGACAO').AsDateTime;
    CliCadastro.FieldByName('SEQTELE').AsInteger := RUltimoSeqTelemarketing(VpaCodCliente);
    try
      CliCadastro.post;
    except
      on e : exception do result := 'ERRO NA GRAVAÇÃO DO TELEMARKETING!!!'#13+e.message;
    end;
    CliTabela.next;
  end;
  CliTabela.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ImportaVisitaProspect(VpaCodProspect, VpaCodCliente : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(CliTabela,'Select * from VISITAPROSPECT '+
                                  ' Where CODPROSPECT = '+IntToStr(VpaCodProspect));
  AdicionaSQLAbreTabela(CliCadastro,'Select * from AGENDA ');
  While not(CliTabela.eof) and (result = '') do
  begin
    CliCadastro.insert;
    CliCadastro.FieldByName('CODUSUARIO').AsInteger := CliTabela.FieldByName('CODUSUARIO').AsInteger;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
    CliCadastro.FieldByName('DATCADASTRO').AsDateTime := CliTabela.FieldByName('DATCADASTRO').AsDateTime;
    CliCadastro.FieldByName('DATINICIO').AsDateTime := CliTabela.FieldByName('DATVISITA').AsDateTime;
    CliCadastro.FieldByName('DATFIM').AsDateTime := CliTabela.FieldByName('DATFIMVISITA').AsDateTime;
    CliCadastro.FieldByName('CODTIPOAGENDAMENTO').AsInteger := CliTabela.FieldByName('CODTIPOAGENDAMENTO').AsInteger;
    if CliTabela.FieldByName('INDREALIZADO').AsString = 'A' then
      CliCadastro.FieldByName('INDREALIZADO').AsString := 'N'
    else
    begin
      CliCadastro.FieldByName('INDREALIZADO').AsString := 'S';
      CliCadastro.FieldByName('DATREALIZADO').AsDateTime := CliTabela.FieldByName('DATVISITA').AsDateTime;
    end;
    CliCadastro.FieldByName('DESOBSERVACAO').AsString := CliTabela.FieldByName('DESAGENDA').AsString+#13+CliTabela.FieldByName('DESREALIZADO').AsString;
    CliCadastro.FieldByName('CODUSUARIOAGENDOU').AsInteger := CliTabela.FieldByName('CODUSUARIO').AsInteger;
    CliCadastro.FieldByName('INDCANCELADO').AsString := 'N';
    CliCadastro.FieldByName('SEQAGENDA').AsInteger := RSeqAgendaDisponivel(CliTabela.FieldByName('CODUSUARIO').AsInteger);
    try
      CliCadastro.post;
    except
      on e : exception do result := 'ERRO NA IMPORTAÇÃO DA AGENDA DO PROSPECT!!!'#13+e.message;
    end;
    CliTabela.next;
  end;
  CliTabela.next;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.IncluiCodigoCliente(VpaCodCliente: Integer);
begin
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CODIGOCLIENTE');
  CliCadastro.Insert;
  CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
  CliCadastro.Post;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.VerificaAtualizaContatoCliente(VpaCodCliente: Integer; VpaDCliente: TRBDCliente; VpaNomContato, VpaDesEMailContato: String): String;
var
  VpfEMail: String;
  VpfDContatoCliente: TRBDContatoCliente;
  VpfVerificarContatos: Boolean;
begin
  Result:= '';
  VpfEMail:= '';
  VpfDContatoCliente:= TRBDContatoCliente.cria;
  VpfVerificarContatos:= False;
  if VpaNomContato <> '' then
  begin
    if not ExisteContatoCliente(VpaCodCliente) then
    // se o contato principal não estiver preenchido
    begin
      VpaDCliente.NomContato:= VpaNomContato;
      VpaDCliente.DesEmail:= VpaDesEMailContato;
      FunClientes.AtualizaCliente(VpaCodCliente,VpaDCliente);
    end
    else
    begin
      if VpaDCliente.NomContato = VpaNomContato then
      // se o nome do contato principal do cliente for igual ao nome que tem no
      // parametro, só para identificar se o usuário está alterando o contato
      // principal ou não. se não fizer esta checagem ele gera confusão e
      // atualiza os dados de forma incorreta
      begin
        if not ExisteContatoCliente(VpaCodCliente, VpaDesEMailContato) then
        // se o email no contato principal não estiver correto
        begin
          VpaDCliente.NomContato:= VpaNomContato;
          VpaDCliente.DesEmail:= VpaDesEMailContato;
          FunClientes.AtualizaCliente(VpaCodCliente,VpaDCliente);
        end;
      end
      else
        VpfVerificarContatos:= True;
    end;
  end;
  if VpfVerificarContatos then
  begin
    // se o contato principal do cliente estiver OK então atualiza o contato
    VpfDContatoCliente.NomContato:= VpaNomContato;
    VpfDContatoCliente.DesEMail:= VpaDesEMailContato;
    VpfDContatoCliente.AceitaEMarketing:= 'S';
    Result:= GravaDContato(VpaCodCliente,VpfDContatoCliente);
  end;
  VpfDContatoCliente.Free;
end;

{******************************************************************************}
function TRBFuncoesClientes.VerificaseClienteEstaBloqueado(VpaCodCliente: Integer): Boolean;
begin
  Result:= false;
  AdicionaSQLAbreTabela(CliAux, 'SELECT C_IND_BLO FROM CADCLIENTES ' +
                                ' WHERE  I_COD_CLI = ' + IntToStr(VpaCodCliente));
  result := CliAux.FieldByName('C_IND_BLO').AsString = 'S';
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDContatos(VpaCodCliente: Integer;
  VpaContatos: TList): String;
var
  VpfDContatoCliente: TRBDContatoCliente;
  VpfLaco: Integer;
begin
  Result:= '';
  ExecutaComandoSql(CliAux,'DELETE FROM CONTATOCLIENTE ' +
                           'WHERE CODCLIENTE = ' + IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM CONTATOCLIENTE');
  for VpfLaco:= 0 to VpaContatos.Count - 1 do
  begin
    VpfDContatoCliente:= TRBDContatoCliente(VpaContatos.Items[VpfLaco]);
    CliCadastro.Insert;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger:= VpaCodCliente;
    CliCadastro.FieldByName('SEQCONTATO').AsInteger:= VpfLaco + 1;
    if VpfDContatoCliente.CodProfissao <> 0 then
      CliCadastro.FieldByName('CODPROFISSAO').AsInteger:= VpfDContatoCliente.CodProfissao
    else
      CliCadastro.FieldByName('CODPROFISSAO').Clear;
    CliCadastro.FieldByName('CODUSUARIO').AsInteger:= VpfDContatoCliente.CodUsuario;
    if VpfDContatoCliente.DatNascimento > MontaData(1,1,1900) then
      CliCadastro.FieldByName('DATNASCIMENTO').AsDateTime:= VpfDContatoCliente.DatNascimento
    else
      CliCadastro.FieldByName('DATNASCIMENTO').Clear;
    CliCadastro.FieldByName('NOMCONTATO').AsString:= VpfDContatoCliente.NomContato;
    CliCadastro.FieldByName('DESTELEFONE').AsString:= VpfDContatoCliente.DesTelefone;
    CliCadastro.FieldByName('DESCELULAR').AsString:= VpfDContatoCliente.DesCelular;
    CliCadastro.FieldByName('DESEMAIL').AsString:= VpfDContatoCliente.DesEMail;
    CliCadastro.FieldByName('DESOBSERVACOES').AsString:= VpfDContatoCliente.DesObservacao;
    CliCadastro.FieldByName('QTDVEZESEMAILINVALIDO').AsInteger:= VpfDContatoCliente.QtdVezesEmailInvalido;
    CliCadastro.FieldByName('INDACEITAEMARKETING').AsString:= VpfDContatoCliente.AceitaEMarketing;

    if VpfDContatoCliente.IndExportadoEficacia then
      CliCadastro.FieldByName('INDEXPORTADO').AsString:= 'S'
    else
      CliCadastro.FieldByName('INDEXPORTADO').AsString:= 'N';
    if VpfDContatoCliente.IndEmailInvalido then
      CliCadastro.FieldByName('INDEMAILINVALIDO').AsString:= 'S'
    else
      CliCadastro.FieldByName('INDEMAILINVALIDO').AsString:= 'N';
    try
      CliCadastro.Post;
    except
      on E:Exception do
      begin
        Result:= 'ERRO NA GRAVAÇÃO DO CONTATOCLIENTE!!!'#13+e.message;
        Break;
      end;
    end;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDContato(VpaCodCliente: Integer; VpaDContatoCliente: TRBDContatoCliente): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM CONTATOCLIENTE'+
                                    ' WHERE NOMCONTATO = '''+VpaDContatoCliente.NomContato+'''');
  if CliCadastro.Eof then
    CliCadastro.Insert
  else
    CliCadastro.Edit;

  CliCadastro.FieldByName('CODCLIENTE').AsInteger:= VpaCodCliente;
  if VpaDContatoCliente.CodProfissao <> 0 then
    CliCadastro.FieldByName('CODPROFISSAO').AsInteger:= VpaDContatoCliente.CodProfissao
  else
    CliCadastro.FieldByName('CODPROFISSAO').Clear;
  CliCadastro.FieldByName('CODUSUARIO').AsInteger:= VpaDContatoCliente.CodUsuario;
  if VpaDContatoCliente.DatNascimento > MontaData(1,1,1900) then
    CliCadastro.FieldByName('DATNASCIMENTO').AsDateTime:= VpaDContatoCliente.DatNascimento
  else
    CliCadastro.FieldByName('DATNASCIMENTO').Clear;
  CliCadastro.FieldByName('NOMCONTATO').AsString:= VpaDContatoCliente.NomContato;
  CliCadastro.FieldByName('DESTELEFONE').AsString:= VpaDContatoCliente.DesTelefone;
  CliCadastro.FieldByName('DESCELULAR').AsString:= VpaDContatoCliente.DesCelular;
  CliCadastro.FieldByName('DESEMAIL').AsString:= lowercase(VpaDContatoCliente.DesEMail);
  CliCadastro.FieldByName('DESOBSERVACOES').AsString:= VpaDContatoCliente.DesObservacao;
  CliCadastro.FieldByName('QTDVEZESEMAILINVALIDO').AsInteger:= VpaDContatoCliente.QtdVezesEmailInvalido;
  CliCadastro.FieldByName('INDACEITAEMARKETING').AsString:= VpaDContatoCliente.AceitaEMarketing;
  if VpaDContatoCliente.IndExportadoEficacia then
    CliCadastro.FieldByName('INDEXPORTADO').AsString:= 'S'
  else
    CliCadastro.FieldByName('INDEXPORTADO').AsString:= 'N';
  if VpaDContatoCliente.IndEmailInvalido then
    CliCadastro.FieldByName('INDEMAILINVALIDO').AsString:= 'S'
  else
    CliCadastro.FieldByName('INDEMAILINVALIDO').AsString:= 'N';

  CliCadastro.FieldByName('SEQCONTATO').AsInteger:= RSeqContatoDisponivel(VpaCodCliente);
  try
    CliCadastro.Post;
  except
    on E:Exception do
      Result:= 'ERRO NA GRAVAÇÃO DO CONTATO DO CLIENTE!!!'#13+E.Message;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDProdutosReserva(VpaCodCliente: Integer; VpaProdutosReserva: TList): String;
Var
  VpfDProdutoReserva: TRBDProdutoReserva;
  VpfLaco: Integer;
begin
  Result:= '';
  ExecutaComandoSql(CliAux,'DELETE FROM PRODUTORESERVA'+
                           ' WHERE CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM PRODUTORESERVA');
  for VpfLaco:= 0 to VpaProdutosReserva.Count - 1 do
  begin
    VpfDProdutoReserva:= TRBDProdutoReserva(VpaProdutosReserva.Items[VpfLaco]);
    CliCadastro.Insert;
    CliCadastro.FieldByName('SEQRESERVA').AsInteger:= VpfLaco+1;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger:= VpaCodCliente;
    CliCadastro.FieldByName('SEQPRODUTO').AsInteger:= VpfDProdutoReserva.SeqProduto;
    CliCadastro.FieldByName('CODPRODUTO').AsString:= VpfDProdutoReserva.CodProduto;
    CliCadastro.FieldByName('DATULTIMACOMPRA').AsDateTime:= VpfDProdutoReserva.DatUltimaCompra;
    CliCadastro.FieldByName('QTDDIASCONSUMO').AsInteger:= VpfDProdutoReserva.QtdDiasConsumo;
    CliCadastro.FieldByName('INDCLIENTE').AsString:= VpfDProdutoReserva.IndCliente;
    CliCadastro.FieldByName('QTDPRODUTO').AsFloat:= VpfDProdutoReserva.QtdProduto;
    try
      CliCadastro.Post;
    except
      on E:Exception do
      begin
        Result:= 'ERRO NA GRAVAÇÃO DO PRODUTORESERVA!!!'#13+e.message;
        Break;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravadProdutoInteresseCliente(VpaCodCliente : Integer;VpaProdutos : TList):string;
var
  VpfLaco : Integer;
  VpfDProduto : TRBDProdutoInteresseCliente;
begin
  result := '';
  ExecutaComandoSql(CliAux,'DELETE FROM PRODUTOINTERESSECLIENTE '+
                           ' Where CODCLIENTE = '+IntToStr(VpaCodCliente));
  AdicionaSQLAbreTabela(CliCadastro,'Select * FROM PRODUTOINTERESSECLIENTE ');
  for VpfLaco := 0 to VpaProdutos.Count - 1 do
  begin
    VpfDProduto := TRBDProdutoInteresseCliente(VpaProdutos.Items[VpfLaco]);
    CliCadastro.Insert;
    CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
    CliCadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProduto.SeqProduto;
    CliCadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDProduto.QtdProduto;
    try
      CliCadastro.Post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DOS PRODUTOS DE INTERESSE!!!'#13+e.message;
        break;
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteProfissao(
  VpaCodProfissao: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT * FROM CADPROFISSOES '+
                               'WHERE I_COD_PRF = '+IntToStr(VpaCodProfissao));
  Result:= not CliAux.Eof;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteTransportadora(VpaCodTransportadora: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT I_COD_CLI FROM CADCLIENTES '+
                               'WHERE I_COD_CLI = '+IntToStr(VpaCodTransportadora)+
                               ' AND C_IND_TRA = ''S''');
  Result:= not CliAux.Eof;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteFaixaEtaria(VpaCodFaixaEtaria : Integer;Var VpaNomFaixaEtaria : string):Boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'Select * from FAIXAETARIA '+
                               ' Where CODFAIXAETARIA = '+IntToStr(VpaCodFaixaEtaria));
  result := not CliAux.Eof;
  VpaNomFaixaEtaria := CliAux.FieldByName('NOMFAIXAETARIA').AsString;
  CliAux.close;
end;

{******************************************************************************}
procedure TRBFuncoesClientes.CarDContatoCliente(VpaCodCliente: Integer;
  VpaContatos: TList);
var
  VpfDContato : TRBDContatoCliente;
begin
  FreeTObjectsList(VpaContatos);
  AdicionaSQLAbreTabela(CliTabela,'SELECT * '+
                                  'FROM CONTATOCLIENTE CON, CADPROFISSOES PRF '+
                                  'WHERE CON.CODCLIENTE = ' + IntToStr(VpaCodCliente) + ' '+
                                  'AND '+SQLTextoRightJoin('CON.CODPROFISSAO','PRF.I_COD_PRF'));
  While not CliTabela.Eof do
  begin
    VpfDContato:= TRBDContatoCliente.cria;
    VpaContatos.Add(VpfDContato);
    VpfDContato.DatNascimento:= CliTabela.FieldByName('DATNASCIMENTO').AsDateTime;
    VpfDContato.NomContato:= CliTabela.FieldByName('NOMCONTATO').AsString;
    VpfDContato.DesTelefone:= CliTabela.FieldByName('DESTELEFONE').AsString;
    VpfDContato.DesCelular:= CliTabela.FieldByName('DESCELULAR').AsString;
    VpfDContato.DesEMail:= CliTabela.FieldByName('DESEMAIL').AsString;
    VpfDContato.NomProfissao:= CliTabela.FieldByName('C_NOM_PRF').AsString;
    VpfDContato.DesObservacao:= CliTabela.FieldByName('DESOBSERVACOES').AsString;
    VpfDContato.AceitaEMarketing:= CliTabela.FieldByName('INDACEITAEMARKETING').AsString;
    VpfDContato.CodProfissao:= CliTabela.FieldByName('I_COD_PRF').AsInteger;
    VpfDContato.IndExportadoEficacia := (CliTabela.FieldByName('INDEXPORTADO').AsString = 'S');
    VpfDContato.IndEmailInvalido := (CliTabela.FieldByName('INDEMAILINVALIDO').AsString = 'S');
    VpfDContato.QtdVezesEmailInvalido := CliTabela.FieldByName('QTDVEZESEMAILINVALIDO').AsInteger;

    CliTabela.next;
  end;
  CliTabela.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteAgendamentoEmAberto(VpaCodCliente: Integer): boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'Select 1 from AGENDA ' +
                               ' Where CODCLIENTE = '+IntToStr(VpaCodCliente)+
                               ' AND INDREALIZADO = ''N''');
  Result := not CliAux.Eof;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteCliente(VpaCodCliente: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT I_COD_CLI FROM CADCLIENTES '+
                               'WHERE I_COD_CLI = '+IntToStr(VpaCodCliente));
  Result:= not CliAux.Eof;
  CliAux.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteContatoCliente(VpaCodCliente: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT C_CON_CLI FROM CADCLIENTES'+
                               ' WHERE I_COD_CLI = '+IntToStr(VpaCodCliente));
  Result:= (CliAux.FieldByName('C_CON_CLI').AsString <> '');
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteContatoCliente(VpaCodCliente: Integer; VpaDesEMail: String): Boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT C_END_ELE, C_CON_CLI FROM CADCLIENTES'+
                               ' WHERE I_COD_CLI = '+IntToStr(VpaCodCliente)+
                               ' AND C_END_ELE = '''+VpaDesEMail+'''');
  Result:= not CliAux.Eof;
  CliAux.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ExisteContatoCliente(VpaCodCliente: Integer; VpaNomContato: String; var VpaEMail: String): Boolean;
begin
  AdicionaSQLAbreTabela(CliAux,'SELECT * FROM CONTATOCLIENTE'+
                               ' WHERE CODCLIENTE = '+IntToStr(VpaCodCliente)+
                               ' AND NOMCONTATO = '''+VpaNomContato+''''+
                               ' AND DESEMAIL LIKE '''+VpaEMail+'%''');
  Result:= not CliAux.Eof;
  VpaEMail:= CliAux.FieldByName('DESEMAIL').AsString;
  CliAux.Close;
end;


{******************************************************************************}
procedure TRBFuncoesClientes.AtualizaCodCidadeCliente(VpaCodCliente,  VpaCodCidade: Integer);
begin
  ExecutaComandoSql(CliAux,'UPDATE CADCLIENTES '+
                           ' SET I_COD_IBG = ' +IntToStr(VpaCodCidade)+
                           ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));
end;

{******************************************************************************}
procedure TRBFuncoesClientes.AtualizaCodPaisCliente(VpaCodCliente,VpaCodPais: Integer);
begin
  ExecutaComandoSql(CliAux,'UPDATE CADCLIENTES '+
                           ' SET I_COD_PAI = ' +IntToStr(VpaCodPais)+
                           ' Where I_COD_CLI = '+IntToStr(VpaCodCliente));
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaContatoCliente(VpaCodCliente: Integer; VpaNomContato: String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,
                        'SELECT * FROM CADCLIENTES WHERE I_COD_CLI = '+IntToStr(VpaCodCliente));
  CliCadastro.Edit;
  CliCadastro.FieldByName('C_CON_CLI').AsString:= VpaNomContato;
  try
    CliCadastro.Post;
  except
    on E:Exception do
      Result:= 'ERRO AO ATUALIZAR O NOME DO CONTATO.'#13+E.Message;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaCliente(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * '+
                                    ' FROM CADCLIENTES'+
                                    ' WHERE I_COD_CLI = '+IntToStr(VpaDPedidoCompra.CodCliente));
  CliCadastro.Edit;

  CliCadaStro.FieldByname('D_ULT_COM').AsDateTime:= VpaDPedidoCompra.DatPedido;
  if (CliCadastro.FieldByName('C_CON_COM').IsNull) or
     (CliCadastro.FieldByName('C_CON_COM').AsString = '') then
    CliCadastro.FieldByName('C_CON_COM').AsString:= VpaDPedidoCompra.NomContato;

  if (CliCadastro.FieldByName('C_EMA_FOR').IsNull) or
     (CliCadastro.FieldByName('C_EMA_FOR').AsString = '') then
    CliCadastro.FieldByName('C_EMA_FOR').AsString:= lowercase(VpaDPedidoCompra.DesEmailComprador);

  if (CliCadastro.FieldByName('N_VAL_FRE').IsNull) or
     (CliCadastro.FieldByName('N_VAL_FRE').AsFloat = 0) then
    CliCadastro.FieldByName('N_VAL_FRE').AsFloat:= VpaDPedidoCompra.ValFrete;

  if ((CliCadastro.FieldByName('I_FRM_PAG').IsNull) or
     (CliCadastro.FieldByName('I_FRM_PAG').AsInteger = 0)) and
     (VpaDPedidoCompra.CodFormaPagto <> 0) then
    CliCadastro.FieldByName('I_FRM_PAG').AsInteger:= VpaDPedidoCompra.CodFormaPagto;

  if ((CliCadastro.FieldByName('I_COD_PAG').IsNull) or
     (CliCadastro.FieldByName('I_COD_PAG').AsInteger = 0))and
     (VpaDPedidoCompra.CodCondicaoPagto <> 0) then
    CliCadastro.FieldByName('I_COD_PAG').AsInteger:= VpaDPedidoCompra.CodCondicaoPagto;

  try
    CliCadastro.Post;
  except
    on E:Exception do
      Result:= 'ERRO AO ATUALIZAR OS DADOS DO CLIENTE/FORNECEDOR.'#13+E.Message;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaCliente(VpaCodCliente: Integer; VpaDCliente: TRBDCliente): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * '+
                                    ' FROM CADCLIENTES'+
                                    ' WHERE I_COD_CLI = '+IntToStr(VpaCodCliente));
  if not CliCadastro.Eof then
  begin
    CliCadastro.Edit;
    if VpaDCliente.DesEmail <> '' then
      CliCadastro.FieldByName('C_END_ELE').AsString:= VpaDCliente.DesEmail;
    if VpaDCliente.NomContato <> '' then
      CliCadastro.FieldByName('C_CON_CLI').AsString:= VpaDCliente.NomContato;
    try
      CliCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATUALIZAR OS DADOS DO CLIENTE/FORNECEDOR.'#13+E.Message;
    end;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaCliente(VpaDCliente: TRBDCliente;VpaDContasAPagar : TRBDContasaPagar): String;
begin
  Result:= '';
  if (VpaDContasAPagar.CodPlanoConta <> VpaDCliente.CodPlanoContas) or
     (VpaDContasAPagar.DesIdentificacaoBancarioFornecedor <> VpaDCliente.DesIdentificacaoBancariaFornecedor) then
  begin
    AdicionaSQLAbreTabela(CliCadastro,'SELECT * '+
                                      ' FROM CADCLIENTES'+
                                      ' WHERE I_COD_CLI = '+IntToStr(VpaDCliente.CodCliente));
    if not CliCadastro.Eof then
    begin
      CliCadastro.Edit;
      if (VpaDContasAPagar.CodPlanoConta <> VpaDCliente.CodPlanoContas) and
         (VpaDContasAPagar.CodPlanoConta <> '') then
        CliCadastro.FieldByName('C_CLA_PLA').AsString:= VpaDContasAPagar.CodPlanoConta;
      if (VpaDContasAPagar.DesIdentificacaoBancarioFornecedor <> VpaDCliente.DesIdentificacaoBancariaFornecedor) and
         (VpaDContasAPagar.DesIdentificacaoBancarioFornecedor <> '')  then
        CliCadastro.FieldByName('C_IDE_BAN').AsString:= VpaDContasAPagar.DesIdentificacaoBancarioFornecedor;
      try
        CliCadastro.Post;
      except
        on E:Exception do
          Result:= 'ERRO AO ATUALIZAR OS DADOS DO CLIENTE/FORNECEDOR.'#13+E.Message;
      end;
    end;
    CliCadastro.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaProspectCliente(VpaDCliente: TRBDCliente; VpaCodProspect: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliCadastro,'SELECT * FROM CADCLIENTES'+
                                    ' WHERE I_COD_CLI = '+IntToStr(VpaDCliente.CodCliente));
  if not CliCadastro.Eof then
  begin
    CliCadastro.edit;

    CliCadastro.FieldByName('I_COD_PRC').AsInteger:= VpaCodProspect;
    try
      CliCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATUALIZAR O PROSPECT DO CLIENTE!!!'#13+E.Message;
    end;
  end;
  CliCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.REmailContatoCliente(VpaCodCliente: Integer; var VpaNomContato: String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliTabela,'SELECT NOMCONTATO, DESEMAIL FROM CONTATOCLIENTE'+
                                  ' WHERE CODCLIENTE = '+IntToStr(VpaCodCliente)+
                                  ' AND NOMCONTATO LIKE '''+VpaNomContato+'%''');
  VpaNomContato:= CliTabela.FieldByName('NOMCONTATO').AsString;
  Result:= CliTabela.FieldByName('DESEMAIL').AsString;
  CliTabela.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.REmailContatoCliente(VpaCodCliente: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CliTabela,'SELECT C_END_ELE FROM CADCLIENTES'+
                                  ' WHERE I_COD_CLI = '+IntToStr(VpaCodCliente));
  Result:= CliTabela.FieldByName('C_END_ELE').AsString;
  CliTabela.Close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AdicionaEmailContatoCliente(VpaCodCliente : Integer; VpaDesEmail, VpaDesObservacoes : String):String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CONTATOCLIENTE '+
                                    ' Where codcliente = 0 and seqcontato = 0');
  CliCadastro.Insert;
  CliCadastro.FieldByname('CODCLIENTE').AsInteger := VpaCodCliente;
  CliCadastro.FieldByname('DESEMAIL').AsString := LowerCase(VpaDesEmail);
  CliCadastro.FieldByname('DESOBSERVACOES').AsString := VpaDesObservacoes;
  CliCadastro.FieldByname('INDEMAILINVALIDO').AsString := 'N';
  CliCadastro.FieldByname('INDACEITAEMARKETING').AsString := 'S';
//  CliCadastro.FieldByname('DATCADASTRO').AsDatetime := now;
  CliCadastro.FieldByname('CODUSUARIO').AsInteger := VARIA.CodigoUsuario;
  CliCadastro.FieldByname('SEQCONTATO').AsInteger := RSeqContatoDisponivel(VpaCodCliente);
  try
    CliCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO CONTATO DO CLIENTE!!!'#13+e.message;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.AdicionaEmailNfeCliente(VpaEmail: String): String;
var
  VpfLaco: Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CADCLIENTES');

  while not CliCadastro.Eof do
  begin
     CliCadastro.Edit;
//     CliCadastro.FieldByName('C_EMA_NFE').AsString:= CliCadastro.FieldByName('C_EMA_NFE').AsString + ';' + VpaEmail;
     CliCadastro.FieldByName('C_END_ELE').AsString:= CliCadastro.FieldByName('C_END_ELE').AsString + ';' + VpaEmail;
     CliCadastro.Post;
     result := CliCadastro.AMensagemErroGravacao;
      if result <> '' then
        break;
      CliCadastro.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.GravaDClientePerdido(VpaDClientePerdido : TRBDClientePerdidoVendedor):string;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CLIENTEPERDIDOVENDEDOR ' +
                                    ' WHERE SEQPERDIDO = 0 ');

  CliCadastro.Insert;
  CliCadastro.FieldByname('DATPERDIDO').AsDateTime := VpaDClientePerdido.DatPerdido;
  CliCadastro.FieldByname('CODUSUARIO').AsInteger := VpaDClientePerdido.CodUsuario;
  CliCadastro.FieldByname('QTDDIA').AsInteger := VpaDClientePerdido.QtdDiasSemPedido;
  if VpaDClientePerdido.QtdDiasComPedido <> 0 then
    CliCadastro.FieldByname('QTDDIACOMPEDIDO').AsInteger := VpaDClientePerdido.QtdDiasComPedido;
  if VpaDClientePerdido.CodRegiaoVendas <> 0 then
    CliCadastro.FieldByname('CODREGIAOVENDA').AsInteger := VpaDClientePerdido.CodRegiaoVendas;
  if VpaDClientePerdido.QtdDiasSemTelemarketing <> 0 then
    CliCadastro.FieldByname('QTDDIASSEMTELEMARKETING').AsInteger := VpaDClientePerdido.QtdDiasSemTelemarketing;
  if VpaDClientePerdido.IndCliente then
    CliCadastro.FieldByname('INDCLIENTE').AsString := 'S'
  else
    CliCadastro.FieldByname('INDCLIENTE').AsString := 'N';
  if VpaDClientePerdido.IndProspect then
    CliCadastro.FieldByname('INDPROSPECT').AsString := 'S'
  else
    CliCadastro.FieldByname('INDPROSPECT').AsString := 'N';
  CliCadastro.FieldByname('CODVENDEDORDESTINO').AsInteger := VpaDClientePerdido.CodVendedorDestino;
  if VpaDClientePerdido.SeqPerdido = 0 then
    VpaDClientePerdido.SeqPerdido := RSeqClientePerdidovendedorDisponivel;
  CliCadastro.FieldByname('SEQPERDIDO').AsInteger := VpaDClientePerdido.SeqPerdido;
  CliCadastro.Post;
  result := CliCadastro.AMensagemErroGravacao;
  if result = '' then
  begin
    result := GravaDClientesPerdidoVendedorItem(VpaDClientePerdido);
    if result = '' then
    begin
      result := GravaDClientesPerdidoVendedorCliente(VpaDClientePerdido);
      if result = '' then
      begin
        result := AlteraClienteVendedor(VpaDClientePerdido);
      end;
    end;
  end;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.ProdutoInteresseDuplicado( VpaProdutos: TList): Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDProInterno, VpfDProdutoExterno : TRBDProdutoInteresseCliente;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaProdutos.Count - 2 do
  begin
    VpfDProdutoExterno := TRBDProdutoInteresseCliente(VpaProdutos.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaProdutos.Count - 1 do
    begin
      VpfDProInterno := TRBDProdutoInteresseCliente(VpaProdutos.Items[VpfLacoInterno]);
      if VpfDProInterno.SeqProduto = VpfDProdutoExterno.SeqProduto then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;


{******************************************************************************}
function TRBFuncoesClientes.FaixaEtariaDuplicada(VpaFaixasEtaria : TList):Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDFaixaInterna, VpfDFaixaExterno : TRBDFaixaEtariaCliente;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaFaixasEtaria.Count - 2 do
  begin
    VpfDFaixaExterno := TRBDFaixaEtariaCliente(VpaFaixasEtaria.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaFaixasEtaria.Count - 1 do
    begin
      VpfDFaixaInterna := TRBDFaixaEtariaCliente(VpaFaixasEtaria.Items[VpfLacoInterno]);
      if VpfDFaixaInterna.CodFaixaEtaria = VpfDFaixaExterno.CodFaixaEtaria then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.MarcaDuplicada(VpaMarcas : TList):Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDMarcaInterna, VpfDMarcaExterna : TRBDMarcaCliente;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaMarcas.Count - 2 do
  begin
    VpfDMarcaExterna := TRBDMarcaCliente(VpaMarcas.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaMarcas.Count - 1 do
    begin
      VpfDMarcaInterna := TRBDMarcaCliente(VpaMarcas.Items[VpfLacoInterno]);
      if VpfDMarcaInterna.CodMarca = VpfDMarcaExterna.CodMarca then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.CadastraProdutosCliente(VpaDCotacao : TRBDOrcamento) : string;
var
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfLaco : Integer;
begin
  result := '';
  if config.NumeroSerieProduto then
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      if VpfDProdutoOrc.DesRefCliente <> '' then
      begin
        result := CadastraProdutoNumeroSerieCliente(VpaDCotacao.DatOrcamento,VpaDCotacao.CodCliente,VpfDProdutoOrc.SeqProduto,
                        VpfDProdutoOrc.QtdMesesGarantia,VpfDProdutoOrc.DesRefCliente,VpfDProdutoOrc.UM,VpfDProdutoOrc.NomProduto, nil);
        if result <> '' then
          break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.CadastraReferenciaCliente(VpaDCotacao : TRBDOrcamento) : string;
var
  VpfDProCotacao : TRBDOrcProduto;
  VpfLaco : Integer;
begin
  result := '';
  if config.ReferenciaClienteCadastrarAutomatica then
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      if VpfDProCotacao.DesRefClienteOriginal <> VpfDProCotacao.DesRefCliente then
      begin
        AdicionaSQLAbreTabela(CliCadastro,'Select * from PRODUTO_REFERENCIA '+
                                          ' Where SEQ_PRODUTO = '+IntToStr(VpfDProCotacao.SeqProduto)+
                                          ' and COD_CLIENTE = '+IntToStr(VpaDCotacao.CodCliente)+
                                          ' and COD_COR = '+IntToStr(VpfDProCotacao.CodCor));
        if CliCadastro.Eof then
          CliCadastro.Insert
        else
          CliCadastro.Edit;
        CliCadastro.FieldByName('SEQ_PRODUTO').AsInteger := VpfDProCotacao.SeqProduto;
        CliCadastro.FieldByName('COD_CLIENTE').AsInteger := VpaDCotacao.CodCliente;
        CliCadastro.FieldByName('COD_COR').AsInteger := VpfDProCotacao.CodCor;
        CliCadastro.FieldByName('DES_REFERENCIA').AsString := VpfDProCotacao.DesRefCliente;
        CliCadastro.FieldByName('COD_PRODUTO').AsString := VpfDProCotacao.CodProduto;
        CliCadastro.FieldByName('SEQ_REFERENCIA').AsInteger := VpfDProCotacao.CodCor;
        try
          CliCadastro.post;
        except
          on e : exception do result := 'ERRO NA GRAVAÇÃO DO PRODUTOREFERENCIA!!!'#13+e.message;
        end;
      end;
    end;
    CliCadastro.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.CadastraProdutosCliente(VpaDNota : TRBDNotaFiscal) : string;
var
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfLaco : Integer;
begin
  result := '';
  if config.NumeroSerieProduto then
  begin
    for VpfLaco := 0 to VpaDNota.Produtos.Count - 1 do
    begin
      VpfDProdutoNota := TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
      if (VpfDProdutoNota.DesRefCliente = '') and (VpfDProdutoNota.ProdutoPeca.Count > 0) then
      begin
        Result:= 'PECAS DO PRODUTO INVALIDAS!!!' + #13 + 'Para digitar as peças é necessário preencher o número de série do produto. ';
        Break;
      end;
      if VpfDProdutoNota.DesRefCliente <> '' then
      begin
        result := CadastraProdutoNumeroSerieCliente(VpaDNota.DatEmissao,VpaDNota.CodCliente,VpfDProdutoNota.SeqProduto,
                        VpfDProdutoNota.QtdMesesGarantia,VpfDProdutoNota.DesRefCliente,VpfDProdutoNota.UM,VpfDProdutoNota.NomProduto, VpfDProdutoNota.ProdutoPeca);
        if result <> '' then
          break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.AtualizaNumeroSerieProdutoChamado(VpaDChamado : TRBDChamado) : string;
var
  VpfLaco : Integer;
  VpfDChamadoPro : TRBDChamadoProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDChamadoPro := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
    if VpfDChamadoPro.NumSerie <> '' then
    begin
      if VpfDChamadoPro.SeqItemProdutoCliente <> 0 then
        result := AtualizaNumeroSerieProdutoCliente(VpaDChamado.CodCliente,VpfDChamadoPro)
      else
        if VpfDChamadoPro.SeqItemContrato <> 0 then
          result := AtualizaNumeroSerieProdutoContrato(VpfDChamadoPro);
    end;
    if result <> ''then
      break;
  end;
end;

{******************************************************************************}
function TRBFuncoesClientes.AdicionaCredito(VpaCodCliente : Integer;VpaValor : Double;VpaTipCredito, VpaDesObservacao : String):String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from CREDITOCLIENTE '+
                                    ' Where CODCLIENTE = 0 AND SEQCREDITO = 0' );
  CliCadastro.Insert;
  CliCadastro.FieldByName('CODCLIENTE').AsInteger := VpaCodCliente;
  CliCadastro.FieldByName('VALINICIAL').AsFloat := VpaValor;
  CliCadastro.FieldByName('VALCREDITO').AsFloat := VpaValor;
  CliCadastro.FieldByName('DATCREDITO').AsDateTime := now;
  CliCadastro.FieldByName('DESOBSERVACAO').AsString := VpaDesObservacao;
  CliCadastro.FieldByName('TIPCREDITO').AsString := VpaTipCredito;
  CliCadastro.FieldByName('INDFINALIZADO').AsString := 'N';
  CliCadastro.FieldByName('SEQCREDITO').AsInteger := RSeqCreditoDisponivel(VpaCodCliente) ;
  CliCadastro.post;
  result := CliCadastro.AMensagemErroGravacao;
  CliCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesClientes.DiminuiCredito(VpaCodCliente : Integer;VpaValor : Double;VpaTipo : TRBDTipoCreditoDebito):String;
var
  VpfCredito : TList;
  VpfDCredito : TRBDCreditoCliente;
  VpfLaco : Integer;
begin
  VpfCredito := TList.Create;
  CarCreditoCliente(VpaCodCliente,VpfCredito,false,dcTodos);
  for VpfLaco := VpfCredito.Count - 1 downto 0  do
  begin
    VpfDCredito := TRBDCreditoCliente(VpfCredito.Items[VpfLaco]);
    if not VpfDCredito.IndFinalizado  and
       (VpfDCredito.TipCredito = VpaTipo) then
    begin
      if VpfDCredito.ValCredito <= VpaValor then
      begin
        VpaValor := VpaValor - VpfDCredito.ValCredito;
        VpfCredito.Delete(VpfLaco);
      end
      else
      begin
        VpfDCredito.ValCredito := VpfDCredito.ValCredito - VpaValor;
        VpaValor := 0;
      end;
    end;
    if VpaValor <= 0 then
      break;
  end;
  result := GravaCreditoCliente(VpaCodCliente,VpfCredito);
end;

end.
