Unit UnProspect;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, UnDados, SysUtils, Constantes, UnClientes, sqlExpr,
     Tabela, db, StdCtrls,Forms;

//classe localiza
Type TRBLocalizaProspect = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesProspect = class(TRBLocalizaProspect)
  private
    Cadastro : TSQL;
    Aux,
    Tabela : TSQLQuery;
    VprBaseDados : TSqlConnection;
    function RCodProspectDisponivel: Integer;
    function RSeqContatoDisponivel(VpaCodProspect : Integer):Integer;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function RSeqVisitaDisponivel : integer;
    function RSeqTarefaTelemarketingProspectDisponivel : Integer;
    function RSeqTarefaEMarketingProspectDisponivel: Integer;
    function RSeqTarefaDisponivel : Integer;
    procedure CarDProspect(VpaDProspect : TRBDProspect;VpaCodProspect : Integer);
    procedure CarDContatoProspect(VpaCodProspect: Integer; VpaContatos: TList);
    function GravaDContatosProspect(VpaCodProspect: Integer; VprContatos: TList): String;
    procedure CarDProdutoProspect(VpaCodProspect: Integer; VpaProdutos: TList);
    function GravaDProdutoProspect(VpaCodProspect: Integer; VpaProdutos: TList): String;
    procedure CarDVisitaProspect(VpaSeqVisita : Integer;VpaDVisita : TRBDAgendaProspect);
    function GravaDAgendaProspect(VpaDAgendaProspect: TRBDAgendaProspect): String;
    function ApagaVisitaProspect(VpaSeqVisita: Integer): String;
    function AtivarEmailProspect(VpaCodProspect: Integer; VpaAtivar: Boolean = True): String;
    function AtivarEmailContatoProspect(VpaCodProspect, VpaSeqContato: Integer; VpaAtivar: Boolean = True): String;
    function AlteraEmailProspect(VpaCodProspect: Integer; VpaEmail: String): String;
    function AlteraEmailContatoProspect(VpaCodProspect, VpaSeqContato: Integer; VpaEmail: String): String;
    procedure AlteraDatUltimoEmail(VpaCODPROSPECT : Integer;VpaData : TDateTime);
    procedure AlteraDatUltimoEmailContato(VpaCODPROSPECT,VpaSeqContato : Integer;VpaData : TDateTime);
    procedure AlterarObsLigacao(VpaCodProspect : Integer;VpaDesObservacao : String);
    function AtualizaDTElemarketing(VpaDTelemarketing : TRBDTelemarketingProspect) : string;
    function AdicionaEmailContatoProspect(VpaCodProspect : Integer; VpaDesEmail, VpaDesObservacoes : String):String;
    function CadastraEmailEmailSuspect(VpaDSuspect : TRBDProspect;VpaDesEmail : String;VpaEmailsCadatrados, VpaDominios : TMemo;Var VpaQtdEmailCadastradoPrincipal : Integer;Var VpaQtdCadastradoAutomatico : integer) : string;
end;

var
  FunProspect : TRBFuncoesProspect;


implementation

Uses FunSql, FunData, funObjeto, UnProdutos, FunString, UnEmarketing;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaProspect.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesProspect.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  vprbaseDados := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Cadastro  := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesProspect.destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesProspect.RSeqVisitaDisponivel : integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQVISITA) ULTIMO FROM VISITAPROSPECT ');
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProspect.CarDProspect(VpaDProspect : TRBDProspect;VpaCodProspect : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM PROSPECT'+
                               ' Where CODPROSPECT = ' +IntToStr(VpaCodProspect));
  VpaDProspect.CodProspect := VpaCodProspect;
  VpaDProspect.NomProspect := Tabela.FieldByname('NOMPROSPECT').AsString;
  VpaDProspect.NomContato := Tabela.FieldByname('NOMCONTATO').AsString;
  VpaDProspect.NomFantasia := Tabela.FieldByname('NOMFANTASIA').AsString;
  VpaDProspect.DesEmailContato := Tabela.FieldByname('DESEMAILCONTATO').AsString;
  VpaDProspect.CodProfissao := Tabela.FieldByname('CODPROFISSAOCONTATO').AsInteger;
  VpaDProspect.CodVendedor := Tabela.FieldByname('CODVENDEDOR').AsInteger;
  VpaDProspect.CodCliente:= Tabela.FieldByname('CODCLIENTE').AsInteger;
  VpaDProspect.CodConcorrente:= Tabela.FieldByname('CODCONCORRENTE').AsInteger;
  VpaDProspect.DesEnderecoCompleto := Tabela.FieldByname('DESENDERECO').AsString+ ', '+Tabela.FieldByname('NUMENDERECO').AsString+'  - '+ Tabela.FieldByname('DESCOMPLEMENTO').AsString;
  VpaDProspect.DesEndereco := Tabela.FieldByname('DESENDERECO').AsString;
  VpaDProspect.NumEndereco := Tabela.FieldByname('NUMENDERECO').AsInteger;
  VpaDProspect.DesComplementoEndereco := Tabela.FieldByname('DESCOMPLEMENTO').AsString;
  VpaDProspect.DesBairro := Tabela.FieldByname('DESBAIRRO').AsString;
  VpaDProspect.DesCep := Tabela.FieldByname('NUMCEP').AsString;
  VpaDProspect.DesCidade := Tabela.FieldByname('DESCIDADE').AsString;
  VpaDProspect.DesUF := Tabela.FieldByname('DESUF').AsString;
  VpaDProspect.DesCNPJ := Tabela.FieldByname('DESCNPJ').AsString;
  VpaDProspect.DesRG := Tabela.FieldByname('DESRG').AsString;
  VpaDProspect.DESInscricaoEstadual := Tabela.FieldByname('DESINSCRICAO').AsString;
  VpaDProspect.DesTipoPessoa := Tabela.FieldByname('TIPPESSOA').AsString;
  VpaDProspect.QtdLigacaoSemProposta:= Tabela.FieldByname('QTDLIGACAOSEMPROPOSTA').AsInteger;
  VpaDProspect.QtdLigacaoComProposta:= Tabela.FieldByname('QTDLIGACAOCOMPROPOSTA').AsInteger;
  VpaDProspect.CodRamoAtividade:= Tabela.FieldByname('CODRAMOATIVIDADE').AsInteger;
  VpaDProspect.DesCPF:= Tabela.FieldByname('DESCPF').AsString;
  VpaDProspect.DesFax:= Tabela.FieldByname('DESFAX').AsString;
  VpaDProspect.DesFone1:= Tabela.FieldByname('DESFONE1').AsString;
  VpaDProspect.DesFone2:= Tabela.FieldByname('DESFONE2').AsString;
  VpaDProspect.DesObservacaoTelemarketing:= Tabela.FieldByname('DESOBSERVACAOTELEMARKETING').AsString;
  VpaDProspect.DesObservacoes:= Tabela.FieldByname('DESOBSERVACOES').AsString;
  if Tabela.FieldByname('INDACEITATELEMARKETING').AsString = 'S' then
    VpaDProspect.IndAceitaTeleMarketing:= True
  else
    VpaDProspect.IndAceitaTeleMarketing:= False;
  if Tabela.FieldByname('INDACEITASPAM').AsString = 'S' then
    VpaDProspect.IndAceitaSpam:= True
  else
    VpaDProspect.IndAceitaSpam:= False;
  VpaDProspect.DatUltimaLigacao:= Tabela.FieldByname('DATULTIMALIGACAO').AsDateTime;
  VpaDProspect.DatNascimento:= Tabela.FieldByname('DATNASCIMENTO').AsDateTime;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.RSeqTarefaTelemarketingProspectDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQTAREFA) ULTIMO FROM TAREFATELEMARKETINGPROSPECT');
  Result:= Aux.FieldByName('ULTIMO').AsInteger + 1;
end;

{******************************************************************************}
function TRBFuncoesProspect.RSeqTarefaEMarketingProspectDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQTAREFA) ULTIMO FROM TAREFAEMARKETINGPROSPECT');
  Result:= Aux.FieldByName('ULTIMO').AsInteger + 1;
end;

{******************************************************************************}
function TRBFuncoesProspect.RSeqTarefaDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQTAREFA) ULTIMO from TAREFATELEMARKETINGPROSPECT');
  Result := Aux.FieldByname('ULTIMO').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesProspect.CarDVisitaProspect(VpaSeqVisita : Integer;VpaDVisita : TRBDAgendaProspect);
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT'+
                               ' VPR.SEQVISITA,'+
                               ' VPR.DATCADASTRO, VPR.DATVISITA, VPR.DATFIMVISITA,'+
                               ' VPR.CODPROSPECT, VPR.CODVENDEDOR, VPR.INDREALIZADO,'+
                               ' VPR.CODTIPOAGENDAMENTO, VPR.CODUSUARIO, VPR.DESAGENDA, '+
                               ' VPR.DESREALIZADO '+
                               ' FROM'+
                               ' VISITAPROSPECT VPR '+
                               ' WHERE SEQVISITA = '+ IntToStr(VpaSeqVisita));
  VpaDVisita.SeqVisita := VpaSeqVisita;
  VpaDVisita.CodProspect := Tabela.FieldByName('CODPROSPECT').AsInteger;
  VpaDVisita.CodTipoAgendamento := Tabela.FieldByName('CODTIPOAGENDAMENTO').AsInteger;
  VpaDVisita.CodUsuario := Tabela.FieldByName('CODUSUARIO').AsInteger;
  VpaDVisita.CodVendedor := Tabela.FieldByName('CODVENDEDOR').AsInteger;
  VpaDVisita.DatCadastro := Tabela.FieldByName('DATCADASTRO').AsDateTime;
  VpaDVisita.DatVisita := Tabela.FieldByName('DATVISITA').AsDateTime;
  VpaDVisita.DatFimVisita := Tabela.FieldByName('DATFIMVISITA').AsDateTime;
  VpaDVisita.IndRealizado := Tabela.FieldByName('INDREALIZADO').AsString[1];
  VpaDVisita.DesAgenda := Tabela.FieldByName('DESAGENDA').AsString;
  VpaDVisita.DesRealizado := Tabela.FieldByName('DESREALIZADO').AsString;
end;

{******************************************************************************}
procedure TRBFuncoesProspect.CarDProdutoProspect(VpaCodProspect: Integer; VpaProdutos: TList);
Var
  VpfDProdutoProspect: TRBDProdutoProspect;
begin
  FreeTObjectsList(VpaProdutos);
  AdicionaSQLAbreTabela(Tabela,'SELECT PRP.SEQPRODUTO, PRP.SEQITEM, PRP.CODDONO, PRP.QTDCOPIAS, PRP.CODPRODUTO, ' +
                               ' PRP.DESSETOR, PRP.NUMSERIE, PRP.NUMSERIEINTERNO, PRP.DESUM, PRP.DESOBSERVACAO, '+
                               ' PRP.QTDPRODUTO, PRP.VALCONCORRENTE, PRP.DATGARANTIA, PRP.DATULTIMAALTERACAO, '+
                               ' PRO.C_NOM_PRO, '+
                               ' DPR.NOMDONO'+
                               ' FROM PRODUTOPROSPECT PRP, CADPRODUTOS PRO, DONOPRODUTO DPR'+
                               ' WHERE PRP.CODPROSPECT = '+IntToStr(VpaCodProspect)+
                               ' AND PRO.I_SEQ_PRO = PRP.SEQPRODUTO'+
                               ' AND '+SQLTextoRightJoin('PRP.CODDONO','DPR.CODDONO'));

  While not Tabela.eof do
  begin
    VpfDProdutoProspect:= TRBDProdutoProspect.Cria;
    VpaProdutos.Add(VpfDProdutoProspect);
    VpfDProdutoProspect.SeqProduto:= Tabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDProdutoProspect.CodProspect:= VpaCodProspect;
    VpfDProdutoProspect.SeqItem:= Tabela.FieldByName('SEQITEM').AsInteger;
    VpfDProdutoProspect.CodDono:= Tabela.FieldByName('CODDONO').AsInteger;
    VpfDProdutoProspect.QtdCopias:= Tabela.FieldByName('QTDCOPIAS').AsInteger;
    VpfDProdutoProspect.CodProduto:= Tabela.FieldByName('CODPRODUTO').AsString;
    VpfDProdutoProspect.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDProdutoProspect.NomDono:= Tabela.FieldByName('NOMDONO').AsString;
    VpfDProdutoProspect.DesSetor:= Tabela.FieldByName('DESSETOR').AsString;
    VpfDProdutoProspect.NumSerie:= Tabela.FieldByName('NUMSERIE').AsString;
    VpfDProdutoProspect.NumSerieInterno:= Tabela.FieldByName('NUMSERIEINTERNO').AsString;
    VpfDProdutoProspect.DesUM:= Tabela.FieldByName('DESUM').AsString;
    VpfDProdutoProspect.UnidadeParentes := FunProdutos.RUnidadesParentes(VpfDProdutoProspect.DesUM);
    VpfDProdutoProspect.DesObservacao:= Tabela.FieldByName('DESOBSERVACAO').AsString;
    VpfDProdutoProspect.QtdProduto:= Tabela.FieldByName('QTDPRODUTO').AsFloat;
    VpfDProdutoProspect.ValConcorrente:= Tabela.FieldByName('VALCONCORRENTE').AsFloat;
    VpfDProdutoProspect.DatGarantia:= Tabela.FieldByName('DATGARANTIA').AsDateTime;
    VpfDProdutoProspect.DatUltimaAlteracao:= Tabela.FieldByName('DATULTIMAALTERACAO').AsDateTime;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
function TRBFuncoesProspect.GravaDProdutoProspect(VpaCodProspect: Integer; VpaProdutos: TList): String;
var
  VpfLaco: Integer;
  VpfDProdutoProspect: TRBDProdutoProspect;
begin
  Result:= '';
  ExecutaComandoSql(Cadastro,'DELETE FROM PRODUTOPROSPECT '+
                             ' WHERE CODPROSPECT = '+IntToStr(VpaCodProspect));
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PRODUTOPROSPECT '+
                                 ' Where CODPROSPECT = 0 AND SEQITEM = 0');
  for VpfLaco:= 0 to VpaProdutos.Count - 1 do
  begin
    VpfDProdutoProspect:= TRBDProdutoProspect(VpaProdutos.Items[VpfLaco]);
    Cadastro.Insert;
    VpfDProdutoProspect.SeqItem:= VpfLaco+1;

    Cadastro.FieldByName('CODPROSPECT').AsInteger:= VpfDProdutoProspect.CodProspect;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger:= VpfDProdutoProspect.SeqProduto;
    Cadastro.FieldByName('CODPRODUTO').AsString:= VpfDProdutoProspect.CodProduto;
    Cadastro.FieldByName('SEQITEM').AsInteger:= VpfDProdutoProspect.SeqItem;
    if VpfDProdutoProspect.CodDono <> 0 then
      Cadastro.FieldByName('CODDONO').AsInteger:= VpfDProdutoProspect.CodDono
    else
      Cadastro.FieldByName('CODDONO').Clear;
    Cadastro.FieldByName('QTDCOPIAS').AsInteger:= VpfDProdutoProspect.QtdCopias;
    Cadastro.FieldByName('DESSETOR').AsString:= VpfDProdutoProspect.DesSetor;
    Cadastro.FieldByName('NUMSERIE').AsString:= VpfDProdutoProspect.NumSerie;
    Cadastro.FieldByName('NUMSERIEINTERNO').AsString:= VpfDProdutoProspect.NumSerieInterno;
    Cadastro.FieldByName('DESUM').AsString:= VpfDProdutoProspect.DesUM;
    Cadastro.FieldByName('DESOBSERVACAO').AsString:= VpfDProdutoProspect.DesObservacao;
    Cadastro.FieldByName('QTDPRODUTO').AsFloat:= VpfDProdutoProspect.QtdProduto;
    Cadastro.FieldByName('VALCONCORRENTE').AsFloat:= VpfDProdutoProspect.ValConcorrente;
    Cadastro.FieldByName('DATGARANTIA').AsDateTime:= VpfDProdutoProspect.DatGarantia;
    Cadastro.FieldByName('DATULTIMAALTERACAO').AsDateTime:= VpfDProdutoProspect.DatUltimaAlteracao;

    try
      Cadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO NA GRAVAÇÃO DO PRODUTOPROSPECT!!!'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.ApagaVisitaProspect(VpaSeqVisita: Integer): String;
begin
  Result:= '';
  try
    ExecutaComandoSql(Cadastro,'DELETE FROM VISITAPROSPECT'#13+
                               ' WHERE SEQVISITA = '+IntToStr(VpaSeqVisita));
  except
    on E:Exception do
      Result:= E.Message;
  end;
end;

{******************************************************************************}
function TRBFuncoesProspect.AtivarEmailProspect(VpaCodProspect: Integer; VpaAtivar: Boolean): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * '+
                                 ' FROM PROSPECT PCT'+
                                 ' WHERE'+
                                 ' PCT.CODPROSPECT = '+IntToStr(VpaCodProspect));
  if Cadastro.Eof then
    Result:= 'PROSPECT NÃO ENCONTRADO!!!'#13'Não foi possível localizar o prospect.';
  if Result = '' then
  begin
    Cadastro.Edit;
    if VpaAtivar then
      Cadastro.FieldByName('INDACEITASPAM').AsString:= 'S'
    else
      Cadastro.FieldByName('INDACEITASPAM').AsString:= 'N';
    try
      Cadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATIVAR/DESATIVAR O PROSPECT!!!'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.AtivarEmailContatoProspect(VpaCodProspect, VpaSeqContato: Integer; VpaAtivar: Boolean): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * '+
                                 ' FROM CONTATOPROSPECT CPP'+
                                 ' WHERE'+
                                 ' CPP.CODPROSPECT = '+IntToStr(VpaCodProspect)+
                                 ' AND CPP.SEQCONTATO = '+IntToStr(VpaSeqContato));
  if Cadastro.Eof then
    Result:= 'CONTATO DO PROSPECT NÃO ENCONTRADO!!!'#13'Não foi possível localizar o contato do prospect.';
  if Result = '' then
  begin
    Cadastro.Edit;
    if VpaAtivar then
      Cadastro.FieldByName('INDACEITAEMARKETING').AsString:= 'S'
    else
      Cadastro.FieldByName('INDACEITAEMARKETING').AsString:= 'N';
    try
      Cadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATIVAR/DESATIVAR O CONTATO DO PROSPECT!!!'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.AlteraEmailProspect(VpaCodProspect: Integer; VpaEmail: String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * '+
                                 ' FROM PROSPECT PCT'+
                                 ' WHERE'+
                                 ' PCT.CODPROSPECT = '+IntToStr(VpaCodProspect));
  if Cadastro.Eof then
    Result:= 'PROSPECT NÃO ENCONTRADO!!!'#13'Não foi possível localizar o prospect.';
  if Result = '' then
  begin
    Cadastro.Edit;
    Cadastro.FieldByName('DESEMAILCONTATO').AsString:= VpaEmail;
    try
      Cadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATUALIZAR O EMAIL DO PROSPECT!!!'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.AlteraEmailContatoProspect(VpaCodProspect, VpaSeqContato: Integer; VpaEmail: String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * '+
                                 ' FROM CONTATOPROSPECT CPR'+
                                 ' WHERE'+
                                 ' CPR.CODPROSPECT = '+IntToStr(VpaCodProspect)+
                                 ' AND CPR.SEQCONTATO = '+IntToStr(VpaSeqContato));
  if Cadastro.Eof then
    Result:= 'CONTATO DO PROSPECT NÃO ENCONTRADO!!!'#13'Não foi possível localizar o contato do prospect.';
  if Result = '' then
  begin
    Cadastro.Edit;
    Cadastro.FieldByName('DESEMAIL').AsString:= VpaEmail;
    try
      Cadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO ATUALIZAR O EMAIL DO CONTATO DO PROSPECT!!!'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.GravaDAgendaProspect(VpaDAgendaProspect: TRBDAgendaProspect): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM VISITAPROSPECT'+
                                 ' WHERE SEQVISITA = '+IntToStr(VpaDAgendaProspect.SeqVisita));
  if Cadastro.Eof then
    Cadastro.Insert
  else
    Cadastro.edit;

  Cadastro.FieldByName('CODPROSPECT').AsInteger:= VpaDAgendaProspect.CodProspect;
  Cadastro.FieldByName('CODTIPOAGENDAMENTO').AsInteger:= VpaDAgendaProspect.CodTipoAgendamento;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpaDAgendaProspect.CodUsuario;
  Cadastro.FieldByName('CODVENDEDOR').AsInteger:= VpaDAgendaProspect.CodVendedor;
  Cadastro.FieldByName('DATCADASTRO').AsDateTime:= VpaDAgendaProspect.DatCadastro;
  Cadastro.FieldByName('DATVISITA').AsDateTime:= VpaDAgendaProspect.DatVisita;
  Cadastro.FieldByName('DATFIMVISITA').AsDateTime:= VpaDAgendaProspect.DatFimVisita;
  Cadastro.FieldByName('INDREALIZADO').AsString:= VpaDAgendaProspect.IndRealizado;
  Cadastro.FieldByName('DESAGENDA').AsString:= VpaDAgendaProspect.DesAgenda;
  Cadastro.FieldByName('DESREALIZADO').AsString:= VpaDAgendaProspect.DesRealizado;
  if VpaDAgendaProspect.SeqVisita = 0 then
    VpaDAgendaProspect.SeqVisita:= FunProspect.RSeqVisitaDisponivel;
  Cadastro.FieldByName('SEQVISITA').AsInteger:= VpaDAgendaProspect.SeqVisita;

  try
    Cadastro.Post;
  except
    on E:Exception do
      Result:= 'ERRO NA GRAVAÇÃO DA AGENDAPROSPECT!!!'#13+E.Message;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProspect.CarDContatoProspect(VpaCodProspect: Integer; VpaContatos: TList);
Var
  VpfDContatoProspect: TRBDContatoProspect;
begin
  FreeTObjectsList(VpaContatos);
  AdicionaSQLAbreTabela(Tabela,'SELECT CPR.CODPROSPECT, CPR.SEQCONTATO, CPR.NOMCONTATO,'+
                               ' CPR.DESTELEFONE, CPR.DESCELULAR, CPR.DESEMAIL, CPR.DATNASCIMENTO,'+
                               ' CPR.CODPROFISSAO, CPR.QTDVEZESEMAILINVALIDO, CPR.INDEMAILINVALIDO, '+
                               ' CPR.INDEXPORTADO, CPR.DATCADASTRO, '+
                               ' PRF.C_NOM_PRF, CPR.CODUSUARIO, CPR.DESOBSERVACOES, '+
                               ' CPR.INDACEITAEMARKETING '+
                               ' FROM CONTATOPROSPECT CPR, CADPROFISSOES PRF'+
                               ' WHERE CPR.CODPROSPECT = '+IntToStr(VpaCodProspect)+
                               ' AND '+SQLTextoRightJoin('CPR.CODPROFISSAO','PRF.I_COD_PRF')+
                               ' order BY SEQCONTATO' );

  While not Tabela.Eof do
  begin
    VpfDContatoProspect:= TRBDContatoProspect.Cria;
    VpaContatos.Add(VpfDContatoProspect);

    VpfDContatoProspect.CodProspect:= Tabela.FieldByName('CODPROSPECT').AsInteger;
    VpfDContatoProspect.SeqContato:= Tabela.FieldByName('SEQCONTATO').AsInteger;
    VpfDContatoProspect.CodProfissao:= Tabela.FieldByName('CODPROFISSAO').AsInteger;
    VpfDContatoProspect.CodUsuario:= Tabela.FieldByName('CODUSUARIO').AsInteger;
    VpfDContatoProspect.NomContato:= Tabela.FieldByName('NOMCONTATO').AsString;
    VpfDContatoProspect.NomProfissao:= Tabela.FieldByName('C_NOM_PRF').AsString;
    VpfDContatoProspect.FonContato:= Tabela.FieldByName('DESTELEFONE').AsString;
    VpfDContatoProspect.CelContato:= Tabela.FieldByName('DESCELULAR').AsString;
    VpfDContatoProspect.EMailContato:= Tabela.FieldByName('DESEMAIL').AsString;
    VpfDContatoProspect.DesObservacoes:= Tabela.FieldByName('DESOBSERVACOES').AsString;
    VpfDContatoProspect.AceitaEMarketing:= Tabela.FieldByName('INDACEITAEMARKETING').AsString;
    VpfDContatoProspect.DatNascimento:= Tabela.FieldByName('DATNASCIMENTO').AsDateTime;
    VpfDContatoProspect.DatCadastro:= Tabela.FieldByName('DATCADASTRO').AsDateTime;
    VpfDContatoProspect.IndExportadoEficacia:= (Tabela.FieldByName('INDEXPORTADO').AsString = 'S');
    VpfDContatoProspect.IndEmailInvalido:= (Tabela.FieldByName('INDEMAILINVALIDO').AsString = 'S');
    VpfDContatoProspect.QtdVezesEmailInvalido:= Tabela.FieldByName('QTDVEZESEMAILINVALIDO').AsInteger;

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.GravaDContatosProspect(VpaCodProspect: Integer; VprContatos: TList): String;
var
  VpfLaco: Integer;
  VpfDContatoProspect: TRBDContatoProspect;
begin
  Result:= '';
  ExecutaComandoSql(Cadastro,'DELETE FROM CONTATOPROSPECT '+
                             ' WHERE CODPROSPECT = '+IntToStr(VpaCodProspect));
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM CONTATOPROSPECT');
  for VpfLaco:= 0 to VprContatos.Count - 1 do
  begin
    VpfDContatoProspect:= TRBDContatoProspect(VprContatos.Items[VpfLaco]);
    Cadastro.Insert;
    VpfDContatoProspect.SeqContato:= VpfLaco+1;

    Cadastro.FieldByName('CODPROSPECT').AsInteger:= VpfDContatoProspect.CodProspect;
    Cadastro.FieldByName('SEQCONTATO').AsInteger:= VpfDContatoProspect.SeqContato;
    Cadastro.FieldByName('NOMCONTATO').AsString:= VpfDContatoProspect.NomContato;
    Cadastro.FieldByName('DESTELEFONE').AsString:= VpfDContatoProspect.FonContato;
    Cadastro.FieldByName('DESCELULAR').AsString:= VpfDContatoProspect.CelContato;
    Cadastro.FieldByName('DESEMAIL').AsString:= LowerCase(VpfDContatoProspect.EMailContato);
    Cadastro.FieldByName('DATCADASTRO').AsDateTime:= VpfDContatoProspect.DatCadastro;
    if VpfDContatoProspect.DatNascimento > MontaData(1,1,1900) then
      Cadastro.FieldByName('DATNASCIMENTO').AsDateTime:= VpfDContatoProspect.DatNascimento
    else
      Cadastro.FieldByName('DATNASCIMENTO').Clear;
    if VpfDContatoProspect.CodProfissao <> 0 then
      Cadastro.FieldByName('CODPROFISSAO').AsInteger:= VpfDContatoProspect.CodProfissao
    else
      Cadastro.FieldByName('CODPROFISSAO').Clear;
    Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpfDContatoProspect.CodUsuario;
    Cadastro.FieldByName('DESOBSERVACOES').AsString:= VpfDContatoProspect.DesObservacoes;
    Cadastro.FieldByName('INDACEITAEMARKETING').AsString:= VpfDContatoProspect.AceitaEMarketing;
    Cadastro.FieldByName('QTDVEZESEMAILINVALIDO').AsInteger:= VpfDContatoProspect.QtdVezesEmailInvalido;
    if VpfDContatoProspect.IndExportadoEficacia then
      Cadastro.FieldByName('INDEXPORTADO').AsString:= 'S'
    else
      Cadastro.FieldByName('INDEXPORTADO').AsString:= 'N';
    if VpfDContatoProspect.IndEmailInvalido then
      Cadastro.FieldByName('INDEMAILINVALIDO').AsString:= 'S'
    else
      Cadastro.FieldByName('INDEMAILINVALIDO').AsString:= 'N';


    try
      Cadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO NA GRAVAÇÃO DO CONTATOPROSPECT!!!'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesProspect.AlteraDatUltimoEmail(VpaCODPROSPECT: Integer;VpaData: TDateTime);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROSPECT '+
                                ' Where CODPROSPECT = ' + IntToStr(VpaCODPROSPECT));
  Cadastro.edit;
  CadaStro.FieldByname('DATULTIMOEMAIL').AsDateTime := VpaData;
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesProspect.AlteraDatUltimoEmailContato(VpaCODPROSPECT,VpaSeqContato : Integer;VpaData : TDateTime);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CONTATOPROSPECT '+
                                ' Where CODPROSPECT = ' + IntToStr(VpaCODPROSPECT)+
                                ' AND SEQCONTATO = '+IntToStr(VpaSeqContato));
  Cadastro.edit;
  CadaStro.FieldByname('DATULTIMOEMAIL').AsDateTime := VpaData;
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesProspect.AlterarObsLigacao(VpaCodProspect: Integer;VpaDesObservacao: String);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROSPECT '+
                                ' Where CODPROSPECT = ' + IntToStr(VpaCodProspect));
  Cadastro.edit;
  if Cadastro.FieldByname('DESOBSERVACAOTELEMARKETING').AsString <> '' then
    VpaDesObservacao := #13+VpaDesObservacao;
  Cadastro.FieldByname('DESOBSERVACAOTELEMARKETING').AsString := VpaDesObservacao;
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProspect.AtualizaDTElemarketing(VpaDTelemarketing : TRBDTelemarketingProspect) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from PROSPECT '+
                                 ' Where CODPROSPECT = '+IntToStr(VpaDTelemarketing.CodProspect));
  Cadastro.Edit;
//  Cadastro.FieldByName('DESOBSERVACAOTELEMARKETING').AsString := VpaDTeleMarketing.DesObsProximaLigacao;
  if VpaDTeleMarketing.SeqProposta = 0 then
  begin
    if VpaDTeleMarketing.IndAtendeu then
      Cadastro.FieldByName('QTDLIGACAOSEMPROPOSTA').AsInteger := Cadastro.FieldByName('QTDLIGACAOSEMPROPOSTA').AsInteger + 1
  end
  else
    Cadastro.FieldByName('QTDLIGACAOCOMPROPOSTA').AsInteger := Cadastro.FieldByName('QTDLIGACAOCOMPROPOSTA').AsInteger + 1;
  Cadastro.FieldByName('DATULTIMALIGACAO').AsDateTime := now;
{  if VpaDTeleMarketing.IndProximaLigacao then
    Cadastro.FieldByName('D_PRO_LIG').AsDateTime := VpaDTeleMarketing.DatProximaLigacao
  else
    Cadastro.FieldByName('D_PRO_LIG').clear;}
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA ATUALIZAÇÃO DOS DADOS DO PROSPECT!!!!'#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProspect.AdicionaEmailContatoProspect(VpaCodProspect : Integer; VpaDesEmail, VpaDesObservacoes : String):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CONTATOPROSPECT '+
                                 ' Where CODPROSPECT = 0 AND SEQCONTATO = 0');
  Cadastro.Insert;
  Cadastro.FieldByname('CODPROSPECT').AsInteger := VpaCodProspect;
  Cadastro.FieldByname('DESEMAIL').AsString := lowerCase(VpaDesEmail);
  Cadastro.FieldByname('DESOBSERVACOES').AsString := VpaDesObservacoes;
  Cadastro.FieldByname('INDEMAILINVALIDO').AsString := 'N';
  Cadastro.FieldByname('INDACEITAEMARKETING').AsString := 'S';
  Cadastro.FieldByname('DATCADASTRO').AsDatetime := now;
  Cadastro.FieldByname('CODUSUARIO').AsInteger := VARIA.CodigoUsuario;
  Cadastro.FieldByname('SEQCONTATO').AsInteger := RSeqContatoDisponivel(VpaCodProspect);
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesProspect.CadastraEmailEmailSuspect(VpaDSuspect : TRBDProspect;VpaDesEmail : String;VpaEmailsCadatrados, VpaDominios : TMemo;Var VpaQtdEmailCadastradoPrincipal : Integer;Var VpaQtdCadastradoAutomatico : integer) : string;
var
  VpfFunEmarketing : TRBFuncoesEMarketing;
  VpfEmailIndividual,VpfEmailsCadastrados : string;
  VpfSeparador : Char;
begin
  VpfEmailsCadastrados := '';
  VpaDesEmail := DeletaEspaco(VpaDesEmail);
  VpfFunEmarketing := TRBFuncoesEMarketing.cria(VprBaseDados);
  if ExisteLetraString(';',VpaDesEmail) then
    VpfSeparador := ';'
  else
    VpfSeparador := ',';
  while length(VpaDesEmail) > 0 do
  begin
    VpfEmailIndividual := CopiaAteChar(VpaDesEmail,VpfSeparador);
    VpaDesEmail := DeleteAteChar(VpaDesEmail,VpfSeparador);
    if ExisteLetraString('<',VpfEmailIndividual) then
      VpfEmailIndividual := CopiaAteChar(DeleteAteChar(VpfEmailIndividual,'<'),'>');
    if ExisteLetraString('@',VpfEmailIndividual) then
    begin
      if not VpfFunEmarketing.ExisteEmail(VpfEmailIndividual) then
      begin
        result := AdicionaEmailContatoProspect(VpaDSuspect.CodProspect,VpfEmailIndividual,'');
        if result = '' then
          VpfEmailsCadastrados := VpfEmailsCadastrados+ VpfEmailIndividual+';';
      end;
      VpfEmailIndividual := DeleteAteChar(VpfEmailIndividual,'@');
      inc(VpaQtdEmailCadastradoPrincipal);
    end;
    if (UpperCase(copy(VpfEmailIndividual,1,4)) = 'WWW.') or (UpperCase(copy(VpfEmailIndividual,1,4)) = 'HTTP') then
      VpfEmailIndividual := DeleteAteChar(VpfEmailIndividual,'.');
    if (ExisteLetraString('@',VpfEmailIndividual)) or (ExisteLetraString('.',VpfEmailIndividual)) then
    begin
      if result = '' then
      begin
        if not VpfFunEmarketing.EmailDominioProvedores(VpfEmailIndividual) then
        begin
          if VpaDominios.Lines.IndexOf(VpfEmailIndividual) < 0 then
            VpaDominios.Lines.Insert(0,VpfEmailIndividual);
          VpfEmailsCadastrados := VpfEmailsCadastrados +
                                 VpfFunEmarketing.CadastraEmailsAdicionaisProspect(VpaDSuspect.CodProspect, VpfEmailIndividual,'CADASTRADO A PARTIR DE 1 EMAIL PRINCIPAL');
        end;
      end;
    end;
  end;

  VpaQtdCadastradoAutomatico := ContaLetra(VpfEmailsCadastrados,';')-1;
  VpfEmailsCadastrados := SubstituiStr(VpfEmailsCadastrados,';',#13);
  VpaEmailsCadatrados.Lines.Text := VpfEmailsCadastrados + VpaEmailsCadatrados.Lines.Text;
  VpaEmailsCadatrados.Refresh;
  Application.ProcessMessages;
  VpfFunEmarketing.free;
end;

{******************************************************************************}
function TRBFuncoesProspect.RCodProspectDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT MAX(CODPROSPECT) ULTIMO FROM PROSPECT');
  Result:= Tabela.FieldByName('ULTIMO').AsInteger+1;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesProspect.RSeqContatoDisponivel(VpaCodProspect : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT MAX(SEQCONTATO) ULTIMO FROM CONTATOPROSPECT'+
                               ' Where CODPROSPECT = ' +IntToStr(VpaCodProspect));
  Result:= Tabela.FieldByName('ULTIMO').AsInteger+1;
  Tabela.Close;
end;



end.
