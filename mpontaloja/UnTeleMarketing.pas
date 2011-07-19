unit UnTeleMarketing;
{Verificado
-.edit;
}
interface

Uses Classes, UnDados, DBTables, SysUtils, Gauges,stdctrls, SQLExpr,
     Tabela;

Type
  TRBFuncoesTeleMarketing = class
    private
      Aux,
      Clientes : TSQLQuery;
      Cadastro : TSQL;
      function RSeqTeleDisponivel(VpaCodFilial,VpaCodCliente : Integer):integer;
      function RSeqTeleProspectDisponivel(VpaCodProspect: Integer): Integer;
      function AtualizaDTelemarketingCliente(VpaDTeleMarketing : TRBDtelemarketing):String;
      procedure CarQtdDiaseDataProximaLigacao(VpaCodCliente : Integer;Var VpaQtdDias : Integer;Var VpaDProximaLigacao : TDateTime);
    public
      constructor cria(VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      function GravaDTeleMarketing(VpaDTeleMarketing : TRBDTelemarketing) : String;
      function GravaDTeleMarketingProspect(VpaDTeleMarketingProspect: TRBDTelemarketingProspect): String;
      procedure AtualizaDiasTelemarketing(VpaMostrador :TGauge;VpaNomCliente :TLabel);
      function RQtdDiasProximaLigacao(VpaCodCliente : Integer):Integer;
      procedure ExcluiTelemarketing(VpaCodFilial, VpaCodCliente, VpaSeqTelemarketing : Integer);
end;


implementation

Uses FunSql, UnClientes, funString,fundata, FunNumeros, UnProspect;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Funcoes do teleMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBFuncoesTeleMarketing.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Clientes := TSQLQuery.Create(nil);
  Clientes.SQLConnection := VpaBaseDados;;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesTeleMarketing.destroy;
begin
  Aux.close;
  Cadastro.close;
  Clientes.Close;
  Aux.free;
  Clientes.free;
  Cadastro.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesTeleMarketing.ExcluiTelemarketing(VpaCodFilial, VpaCodCliente, VpaSeqTelemarketing: Integer);
begin
  ExecutaComandoSql(Aux,'Delete from TELEMARKETING ' +
                        ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                        ' AND SEQTELE = ' + IntToStr(VpaSeqTelemarketing)+
                        ' AND CODCLIENTE = ' +IntToStr(VpaCodCliente));
end;

{******************************************************************************}
function TRBFuncoesTeleMarketing.RSeqTeleDisponivel(VpaCodFilial,VpaCodCliente : Integer):integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQTELE) ULTIMO from TELEMARKETING '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and CODCLIENTE = '+IntToStr(VpaCodCliente));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesTeleMarketing.RSeqTeleProspectDisponivel(VpaCodProspect: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQTELE) PROXIMO FROM TELEMARKETINGPROSPECT '+
                            ' WHERE CODPROSPECT = '+IntToStr(VpaCodProspect));
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesTeleMarketing.AtualizaDTelemarketingCliente(VpaDTeleMarketing : TRBDtelemarketing):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCLIENTES '+
                                 ' Where I_COD_CLI = '+IntToStr(VpaDTeleMarketing.CodCliente));
  Cadastro.Edit;
  Cadastro.FieldByName('C_OBS_TEL').AsString := VpaDTeleMarketing.DesObsProximaLigacao;
  if VpaDTeleMarketing.LanOrcamento = 0 then
  begin
    if VpaDTeleMarketing.IndAtendeu then
      Cadastro.FieldByName('I_QTD_LSV').AsInteger := Cadastro.FieldByName('I_QTD_LSV').AsInteger + 1
  end
  else
    Cadastro.FieldByName('I_QTD_LCV').AsInteger := Cadastro.FieldByName('I_QTD_LCV').AsInteger + 1;
  Cadastro.FieldByName('D_ULT_TEL').AsDateTime := now;
  if VpaDTeleMarketing.IndProximaLigacao then
    Cadastro.FieldByName('D_PRO_LIG').AsDateTime := VpaDTeleMarketing.DatProximaLigacao
  else
    Cadastro.FieldByName('D_PRO_LIG').clear;
  if VpaDTeleMarketing.QtdDiasProximaLigacao <> 0 then
    Cadastro.FieldByName('I_DIA_PLI').AsInteger := VpaDTeleMarketing.QtdDiasProximaLigacao;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA ATUALIZAÇÃO DOS DADOS DO CLIENTE!!!!'#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesTeleMarketing.CarQtdDiaseDataProximaLigacao(VpaCodCliente : Integer;Var VpaQtdDias : Integer;Var VpaDProximaLigacao : TDateTime);
var
  VpfQtdCompras, VpfTotalDias : Integer;
  VpfDatCotacao,VpfDatPrimeiraCotacao : TDateTime;
begin
  VpaQtdDias := 30;
  VpaDProximaLigacao := date;
  AdicionaSQLAbreTabela(Aux,'Select D_DAT_ORC from CADORCAMENTOS '+
                            ' Where I_COD_CLI = '+InttoStr(VpaCodCliente)+
                            ' order by D_DAT_ORC desc');
  if not Aux.Eof then
  begin
    VpfQtdCompras := 0;
    VpfTotalDias := 0;
    VpfDatPrimeiraCotacao := Aux.FieldByName('D_DAT_ORC').AsDatetime;
    VpfDatCotacao := Aux.FieldByName('D_DAT_ORC').AsDatetime;
    while not Aux.Eof do
    begin
      if VpfDatCotacao <> Aux.FieldByName('D_DAT_ORC').AsDateTime then
      begin
        inc(VpfQtdCompras);
        VpfTotalDias := VpfTotalDias +DiasPorPeriodo(VpfDatCotacao,Aux.FieldByName('D_DAT_ORC').AsDateTime);
        VpfDatCotacao := Aux.FieldByName('D_DAT_ORC').AsDateTime;
        if VpfQtdCompras > 10 then //so faz a media das 10 ultimas cotacoes
          Aux.last;
      end;
      Aux.Next;
    end;
    if VpfQtdCompras > 0 then
    begin
      VpaQtdDias := RetornaInteiro(VpfTotalDias / VpfQtdCompras);
      VpaDProximaLigacao := IncDia(VpfDatPrimeiraCotacao,VpaQtdDias);
    end;
  end;
  Aux.Close;

end;

{******************************************************************************}
function TRBFuncoesTeleMarketing.GravaDTeleMarketing(VpaDTeleMarketing : TRBDTelemarketing) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from TELEMARKETING '+
                                ' Where CODFILIAL = 0 AND CODCLIENTE = 0 AND SEQTELE = 0');
  Cadastro.Insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDTeleMarketing.CodFilial;
  Cadastro.FieldByName('CODCLIENTE').AsInteger := VpaDTeleMarketing.CodCliente;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDTeleMarketing.CodUsuario;
  Cadastro.FieldByName('SEQCAMPANHA').AsInteger := VpaDTeleMarketing.SeqCampanha;
  if VpaDTeleMarketing.LanOrcamento <> 0 then
    Cadastro.FieldByName('LANORCAMENTO').AsInteger := VpaDTeleMarketing.LanOrcamento;
  Cadastro.FieldByName('CODHISTORICO').AsInteger := VpaDTeleMarketing.CodHistorico;
  Cadastro.FieldByName('DATLIGACAO').AsDatetime := VpaDTeleMarketing.DatLigacao;
  Cadastro.FieldByName('DESFALADOCOM').AsString := VpaDTeleMarketing.DesFaladoCom;
  Cadastro.FieldByName('DESOBSERVACAO').AsString := VpaDTeleMarketing.DesObservacao;
  Cadastro.FieldByName('QTDSEGUNDOSLIGACAO').AsInteger := VpaDTeleMarketing.QtdSegundosLigacao;
  Cadastro.FieldByName('DATTEMPOLIGACAO').AsDatetime := VpaDTeleMarketing.DatTempoLigacao;
  if VpaDTeleMarketing.CodVendedor <> 0 then
    Cadastro.FieldByName('CODVENDEDOR').AsInteger := VpaDTeleMarketing.CodVendedor;
  IF VpaDTeleMarketing.IndProximaLigacao then
    Cadastro.FieldByName('INDPROXIMALIGACAO').AsString := 'S'
  else
    Cadastro.FieldByName('INDPROXIMALIGACAO').AsString := 'N';
  VpaDTeleMarketing.SeqTele := RSeqTeleDisponivel(VpaDTeleMarketing.CodFilial,VpaDTeleMarketing.CodCliente);
  Cadastro.FieldByName('SEQTELE').AsInteger := VpaDTeleMarketing.SeqTele;
  try
    Cadastro.post;
  except
     on e : exception do result := 'ERRO NA GRAVAÇÃO DA TABELA DO TELEMARKETING!!!'#13+e.message;
  end;
  Cadastro.close;
  if result = '' then
    AtualizaDTelemarketingCliente(VpaDTeleMarketing);
end;

{******************************************************************************}
function TRBFuncoesTeleMarketing.GravaDTeleMarketingProspect(VpaDTeleMarketingProspect: TRBDTelemarketingProspect): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM TELEMARKETINGPROSPECT ' +
                                 ' Where CODPROSPECT = 0 AND SEQTELE = 0 ');
  Cadastro.Insert;

  Cadastro.FieldByName('CODPROSPECT').AsInteger:= VpaDTeleMarketingProspect.CodProspect;
  if VpaDTeleMarketingProspect.CodUsuario = 0 then
    Cadastro.FieldByName('CODUSUARIO').Clear
  else
    Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpaDTeleMarketingProspect.CodUsuario;
  Cadastro.FieldByName('DATLIGACAO').AsDateTime:= VpaDTeleMarketingProspect.DatLigacao;
  if VpaDTeleMarketingProspect.SeqProposta = 0 then
  begin
    Cadastro.FieldByName('CODFILIAL').Clear;
    Cadastro.FieldByName('SEQPROPOSTA').Clear;
  end
  else
  begin
    Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDTeleMarketingProspect.CodFilial;
    Cadastro.FieldByName('SEQPROPOSTA').AsInteger:= VpaDTeleMarketingProspect.SeqProposta;
  end;
  Cadastro.FieldByName('DESFALADOCOM').AsString:= VpaDTeleMarketingProspect.DesFaladoCom;
  Cadastro.FieldByName('DESOBSERVACAO').AsString:= VpaDTeleMarketingProspect.DesObservacao;
  if VpaDTeleMarketingProspect.CodHistorico = 0 then
    Cadastro.FieldByName('CODHISTORICO').Clear
  else
    Cadastro.FieldByName('CODHISTORICO').AsInteger:= VpaDTeleMarketingProspect.CodHistorico;
  Cadastro.FieldByName('QTDSEGUNDOSLIGACAO').AsInteger:= VpaDTeleMarketingProspect.QtdSegundosLigacao;
  Cadastro.FieldByName('DATTEMPOLIGACAO').AsDateTime:= VpaDTeleMarketingProspect.DataTempoLigacao;
  if VpaDTeleMarketingProspect.CodVendedor <> 0 then
    Cadastro.FieldByName('CODVENDEDOR').AsInteger:= VpaDTeleMarketingProspect.CodVendedor;

  VpaDTeleMarketingProspect.SeqTele :=  RSeqTeleProspectDisponivel(VpaDTeleMarketingProspect.CodProspect);
  Cadastro.FieldByName('SEQTELE').AsInteger:= VpaDTeleMarketingProspect.SeqTele;

  try
    Cadastro.post;
  except
     on E:Exception do
       Result:= 'ERRO NA GRAVAÇÃO DA TABELA DO TELEMARKETING DO PROSPECT!!!'#13+E.Message;
  end;
  Cadastro.Close;
  if result = '' then
    result := FunProspect.AtualizaDTElemarketing(VpaDTeleMarketingProspect);
end;

{******************************************************************************}
procedure TRBFuncoesTeleMarketing.AtualizaDiasTelemarketing(VpaMostrador :TGauge;VpaNomCliente :TLabel);
var
  VpfQtdDias : Integer;
  VpfDatProximaLigacao : TDateTime;
begin
  VpaMostrador.MaxValue := FunClientes.RQtdClientes('');
  VpaMostrador.Progress := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCLIENTES ');
  while not cadastro.Eof do
  begin
    VpaMostrador.AddProgress(1);
    VpaNomCliente.Caption := AdicionaCharD(' ',Cadastro.FieldByName('C_NOM_CLI').AsString,50);
    VpaNomCliente.Refresh;
    Cadastro.edit;
    CarQtdDiaseDataProximaLigacao(Cadastro.FieldByName('I_COD_CLI').AsInteger,VpfQtdDias,VpfDatProximaLigacao);
    if Cadastro.FieldByName('D_PRO_LIG').IsNull then
      Cadastro.FieldByName('D_PRO_LIG').AsDateTime := VpfDatProximaLigacao;
    Cadastro.FieldByName('I_DIA_PLI').AsInteger := VpfQtdDias;
    Cadastro.post;
    Cadastro.next;
  end;
end;

{******************************************************************************}
function TRBFuncoesTeleMarketing.RQtdDiasProximaLigacao(VpaCodCliente : Integer):integer;
var
  VpfDatProximaLigacao : TDateTime;
begin
  CarQtdDiaseDataProximaLigacao(VpaCodCliente,result,VpfDatProximaLigacao);
end;

end.
