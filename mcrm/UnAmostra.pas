Unit UnAmostra;
{Verificado
-.edit;
-*= e =*
-.post;

}
Interface

Uses Classes, DBTables, SysUtils, UnDadosProduto, SQLExpr, tabela, Forms,CBancoDados, DBClient, UnDados;

//classe localiza
Type TRBLocalizaAmostra = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesAmostra = class(TRBLocalizaAmostra)
  private
    Aux,
    Amostra : TSQLQuery;
    Cadastro : TSql;
    function RSeqRequisicaoMaquinaDisponivel : Integer;
    function RSeqLogAmostraDisponivel(VpaCodAmostra : Integer):Integer;
    function RSeqLogAmostraConsumoDisponivel(VpaCodAmostra,VpaCodCor : Integer):integer;
    procedure CarAmostracor(VpaDAmotra : TRBDAmostra; vpaCorAmostra : Integer);
    function GravaDPrecoClienteAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer):string;
    function GravaDAmostracor(VpaDAmostra : TRBDAmostra):string;
    function GravaAmostraConsumoLog(VpaCodAmostra, VpaCodCor : Integer):string;
    procedure CarCoeficientesTabelaPreco(VpaDAmostra : TRBDAmostra);
    function RValCustoMateriaPrima(VpaDAmostra : TRBDAmostra):Double;
    function RValCustoProcessos(VpaDAmostra : TRBDAmostra):Double;
    function CalculaCustoMaodeObraBordado(VpaDAmostra : TRBDAmostra) : Double;
    function RCustoItensEspeciais(VpaDAmostra : TRBDAmostra) : Double;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    procedure CarDAmostra(VpaDAmostra: TRBDAmostra; VpaCodAmostra: Integer);
    procedure CarDAmostraProcesso(VpaDAmostraProcesso: TRBDAmostraProcesso; VpaCodProcessoProducao: Integer);
    procedure CarPrecosClienteAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
    procedure CarProcessosAmostra(VpaDAmostra : TRBDAmostra);
    function CarProcessoAmostraImportacao(VpaDAmostra: TRBDAmostra): TRBDAmostraProcesso;
    function ConcluiAmostra(VpaCodAmostra : Integer;VpaDatConclusao : TDateTime) : string;
    function ConcluiAmostraCor(VpaCodAmostra, VpaCodCor : Integer;VpaDatConclusao : TDateTime) : string;
    function ConcluirPrecoAmostra(VpaCodAmostra : Integer;VpaDatConclusao : TDateTime) : string;
    function ConcluiDesenhoAmostra(VpaSeqRequisicao : Integer) : string;
    function AprovaAmostra(VpaCodAmostra : Integer) : string;
    function ConcluirFichaTecnica(VpaCodAmostra : Integer) : string;
    function ConcluirFichaAmostra(VpaCodAmostra : Integer) : string;
    function ConcluirFichaCor(VpaCodAmostra, VpaCodCor : Integer) : string;
    function EstornarAprovacao(VpaCodAmostra : Integer) : string;
    procedure CarConsumosAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
    procedure CarItensEspeciais(VpaDAmostra : TRBDAmostra);
    function GravaConsumoAmostra(VpaDAmostra : TRBDAmostra):string;
    function GravaAmostraLog(VpaCodAmostra : Integer) : string;
    function GravaRequisicaoMAquina(VpaCodAmostra, VpaCodMaquina : Integer;VpaDesRequisicao : string):string;
    function GravaDItensEspeciais(VpaDAmostra : TRBDAmostra) : string;
    function GravaDProcessoAmostra(VpaDAmostra : TRBDAmostra): string;
    function AtualizarAmostra(VpaCodAmostra: Integer; VpaDAmostra: TRBDAmostra): String;
    function CopiaConsumoAmostraProduto(VpaCodAmostra,VpaSeqProduto : Integer):String;
    procedure CalculaValorVendaUnitario(VpaDAmostra : TRBDAmostra);overload;
    procedure CalculaValorVendaUnitario(VpaDAmostra : TRBDAmostra;VpaDValorVenda : TRBDValorVendaAmostra);overload;
    procedure CalculaValorVendaUnitarioPorValorLucro(VpaDAmostra : TRBDAmostra;VpaDValorVenda : TRBDValorVendaAmostra);
    procedure CalculaValorVendaPeloValorSugerido(VpaDAmostra : TRBDAmostra;VpaValSugerido : Double);
    function ExisteAmostraDefinidaDesenvolvida(VpaCodAmostra : integer):Boolean;
    function ExisteCodigoAmostra(VpaCodigo : Integer):Boolean;
    function RQtdAmostraSolicitada(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer; VpaCodCliente: Integer = -1):Integer;
    function RQtdAmostraEntregue(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer; VpaCodCliente: Integer = -1):Integer;
    function RQtdAmostraAprovada(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer; VpaCodCliente: Integer = -1):Integer;
    function RQtdClientesAmostra(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer; VpaCodCliente: Integer = -1):Integer;
    function RLegendaDisponivel(VpaDAmostra : TRBDAmostra):String;
    function RCodAmostraDisponivel(VpaCodClassificacao : String) : Integer;
    function RCodAmostraIndefinida(VpaCodAmostra : integer):Integer;
    function RNomeProcessoProducao(VpaCodProcessoProducao: Integer): String;
    procedure CarPerLucroComissaoCoeficienteCusto(VpaCodCoeficiente : Integer;var VpaPerLucro, VpaPerComissao : Double);
    procedure ExcluiAmostra(VpaCodAmostra : Integer);
    procedure ExportaFichaTecnicaAmostra(VpaDAmostra : TRBDAmostra);
    procedure CarQtdPontos(VpaDAmostra : TRBDAmostra);
    function VerificaAmostraRealizada(VpaCodAmostraIndef: Integer): String;
    function AtualizaTrocaLinhasQtdTotalPontosAmostra(VpaDAmostra : TRBDAmostra) : string;
    function AlteraDesenvolvedor(VpaCodAmostra : Integer; VpaCodDesenvolvedor : Integer):string;
    function RSeqItemDisponivelMotivoAmostra: integer;
    function GravaDMotivoAmostra(VpaDMotivoAmostra : TRBDPropostaAmostraMotivoAtraso) : string;

end;



implementation

Uses FunSql, FunObjeto, UnProdutos, Constantes, FunData, dmRave, UnCotacao,
     UnClientes, UnSistema, FunString, constmsg, FunArquivos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaAmostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaAmostra.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesAmostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesAmostra.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Cadastro := TSQL.create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Amostra := TSQLQuery.create(nil);
  Amostra.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesAmostra.destroy;
begin
  Cadastro.free;
  Aux.free;
  Amostra.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdAmostraAprovada(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer; VpaCodCliente: Integer = -1): Integer;
var
  VpfSqlCliente : String;
begin
  if VpaCodCliente = -1 then
    VpfSqlCliente := ''
  else
    VpfSqlCliente := ' AND CODCLIENTE = ' + IntToStr(VpaCodCliente);
  AdicionaSQLAbreTabela(Aux,'Select count(CODAMOSTRA) QTD '+
                            ' from AMOSTRA '+
                            ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' and TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('DATAPROVACAO',VpaDatInicio,VpaDatFim,true)+
                            VpfSqlCliente);
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdAmostraEntregue(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer; VpaCodCliente: Integer = -1): Integer;
var
  VpfSqlCliente : String;
begin
  if VpaCodCliente = -1 then
    VpfSqlCliente := ''
  else
    VpfSqlCliente := ' AND CODCLIENTE = ' + IntToStr(VpaCodCliente);
  AdicionaSQLAbreTabela(Aux,'Select count(CODAMOSTRA) QTD '+
                            ' from AMOSTRA '+
                            ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' and TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('DATENTREGA',VpaDatInicio,VpaDatFim,true)+
                            VpfSqlCliente);
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdAmostraSolicitada(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer; VpaCodCliente: Integer = -1): Integer;
var
  VpfSqlCliente : String;
begin
  if VpaCodCliente = -1 then
    VpfSqlCliente := ''
  else
    VpfSqlCliente := ' AND AMO.CODCLIENTE = ' + IntToStr(VpaCodCliente);
  AdicionaSQLAbreTabela(Aux,'Select count(AMO.CODAMOSTRA) QTD '+
                            ' from AMOSTRA AMO, AMOSTRA REC '+
                            ' Where AMO.CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' AND AMO.CODAMOSTRAINDEFINIDA = REC.CODAMOSTRA '+
                            ' and AMO.TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('TRUNC(REC.DATAMOSTRA)',VpaDatInicio,INCDIA(VpaDatFim,1),true)+
                            VpfSqlCliente);
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdClientesAmostra(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer; VpaCodCliente: Integer = -1): Integer;
var
  VpfSqlCliente : String;
begin
  if VpaCodCliente = -1 then
    VpfSqlCliente := ''
  else
    VpfSqlCliente := ' AND CODCLIENTE = ' + IntToStr(VpaCodCliente);
  AdicionaSQLAbreTabela(Aux,'Select count(DISTINCT(CODCLIENTE)) QTD '+
                            ' from AMOSTRA '+
                            ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' and TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('DATAMOSTRA',VpaDatInicio,INCDIA(VpaDatFim,1),true)+
                            VpfSqlCliente);
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarQtdPontos(VpaDAmostra: TRBDAmostra);
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoAmostra;
begin
  VpaDAmostra.QtdTotalPontos := 0;
  VpaDAmostra.QtdTrocasLinhaBordado := 0;
  VpaDAmostra.QtdAplique := 0;
  for Vpflaco := 0 to VpaDAmostra.DCor.Consumos.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoAmostra(VpaDAmostra.DCor.Consumos.Items[Vpflaco]);
    if TRBDConsumoAmostra(VpaDAmostra.DCor.Consumos.Items[Vpflaco]).QtdPontos > 0 then
    begin
      VpaDAmostra.QtdTotalPontos := VpaDAmostra.QtdTotalPontos + VpfDConsumo.QtdPontos;
      VpaDAmostra.QtdTrocasLinhaBordado := VpaDAmostra.QtdTrocasLinhaBordado +1;
    end;
    if VpfDConsumo.CodTipoMateriaPrima = VARIA.CodTipoMateriaPrimaAplique then
      inc(VpaDAmostra.QtdAplique);
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RCodAmostraDisponivel(VpaCodClassificacao: String): Integer;
var
  VpfBaseCodigo : String;
  VpfProximoCodigoSemBase : Integer;
begin
  VpfBaseCodigo :=Copy(VpaCodClassificacao,2,length(VpaCodClassificacao));
  AdicionaSQLAbreTabela(Aux,'Select MAX(CODAMOSTRA) ULTIMO FROM AMOSTRA '+
                            ' Where CODCLASSIFICACAO = '''+VpaCodClassificacao+'''');
  if Aux.FieldByName('ULTIMO').AsInteger = 0 then
    VpfProximoCodigoSemBase :=  1
  else
    VpfProximoCodigoSemBase := StrtoInt(COPY(Aux.FieldByName('ULTIMO').AsString,length(VpfBaseCodigo),20))+1;

  Result := StrToInt(VpfBaseCodigo + IntToStr(VpfProximoCodigoSemBase));
  while ExisteCodigoAmostra(Result) do
  begin
    Inc(VpfProximoCodigoSemBase);
    Result := StrToInt(VpfBaseCodigo + IntToStr(VpfProximoCodigoSemBase));
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RCodAmostraIndefinida(VpaCodAmostra: integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select CODAMOSTRAINDEFINIDA FROM AMOSTRA ' +
                            ' WHERE CODAMOSTRA = ' +IntToStr(VpaCodAmostra));
  result := Aux.FieldByName('CODAMOSTRAINDEFINIDA').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RLegendaDisponivel(VpaDAmostra : TRBDAmostra):String;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoAmostra;
  VpfLegenda : String;
begin
  result := '';
  if VpaDAmostra.DCor.Consumos.Count = 1 then
    result := 'A'
  else
  begin
    for VpfLaco := 0 to VpaDAmostra.DCor.Consumos.Count - 1 do
    begin
      VpfDConsumo := TRBDConsumoAmostra(VpaDAmostra.DCor.Consumos.Items[VpfLaco]);
      if DeletaEspaco(VpfDConsumo.DesLegenda) <> '' then
      begin
        VpfLegenda := DeletaEspaco(VpfDConsumo.DesLegenda);
        result := '';
        if Length(VpfLegenda) > 1 then
          result := copy(VpfLegenda,1,Length(VpfLegenda)-1);
        result := result + char(ord(VpfLegenda[Length(VpfLegenda)])+1);
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RNomeProcessoProducao(VpaCodProcessoProducao: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux, ' SELECT DESPROCESSOPRODUCAO ' +
                             '   FROM PROCESSOPRODUCAO    ' +
                             '  WHERE CODPROCESSOPRODUCAO = ' +IntToStr(VpaCodProcessoProducao));

  Result := Aux.FieldByName('DESPROCESSOPRODUCAO').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RSeqItemDisponivelMotivoAmostra: integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQITEM) ULTIMO FROM AMOSTRACORMOTIVOATRASO ');
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RSeqLogAmostraConsumoDisponivel(VpaCodAmostra, VpaCodCor: Integer): integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select Max(SEQLOG) ULTIMO from AMOSTRACONSUMOLOG '+
                            ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra)+
                            ' AND CODCOR = '+IntToStr(VpaCodCor));
  result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RSeqLogAmostraDisponivel(VpaCodAmostra: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select Max(SEQLOG) ULTIMO from AMOSTRALOG '+
                            ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RSeqRequisicaoMaquinaDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select Max(SEQREQUISICAO) ULTIMO from REQUISICAOMAQUINA ');
  result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RValCustoMateriaPrima(VpaDAmostra: TRBDAmostra): Double;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoAmostra;
begin
  result := 0;
  for Vpflaco := 0 to VpaDAmostra.DCor.Consumos.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoAmostra(VpaDAmostra.DCor.Consumos.Items[VpfLaco]);
    result :=  result + VpfDConsumo.ValTotal;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RValCustoProcessos(VpaDAmostra: TRBDAmostra): Double;
var
  VpfLaco : Integer;
  VpfDProcessoAmostra : TRBDAmostraProcesso;
begin
  result := 0;
  for Vpflaco := 0 to VpaDAmostra.Processos.Count - 1 do
  begin
    VpfDProcessoAmostra := TRBDAmostraProcesso(VpaDAmostra.Processos.Items[VpfLaco]);
    result :=  result + VpfDProcessoAmostra.ValUnitario;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.VerificaAmostraRealizada(VpaCodAmostraIndef: Integer): String;
var
  VpfAmostraRealizada : Char;
begin
  Result := '';
  AdicionaSQLAbreTabela(Aux, ' SELECT COUNT(*) QTD FROM AMOSTRA AMO, AMOSTRACOR AMC ' +
                             ' WHERE CODAMOSTRAINDEFINIDA = ' + IntToStr(VpaCodAmostraIndef) +
                             ' AND AMO.CODAMOSTRA = AMC.CODAMOSTRA '+
                             ' AND AMC.DATENTREGA IS NULL  ');
  if Aux.FieldByName('QTD').AsInteger < 1 then
  begin
    AdicionaSqlAbreTabela(Cadastro,' SELECT * FROM AMOSTRA WHERE CODAMOSTRA = ' + IntToStr(VpaCodAmostraIndef));
    Cadastro.Edit;
    Cadastro.FieldByName('INDAMOSTRAREALIZADA').AsString := 'S';
    Cadastro.Post;
    Result := Cadastro.AMensagemErroGravacao;
  end;
end;


{******************************************************************************}
function TRBFuncoesAmostra.GravaDAmostracor(VpaDAmostra: TRBDAmostra): string;
begin
  ExecutaComandoSql(Aux,'Delete from AMOSTRACOR '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                        '  and CODCOR = '+IntToStr(VpaDAmostra.DCor.CodCor));
  if VpaDAmostra.DCor.Consumos.Count > 0 then
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRACOR '+
                                   ' Where CODAMOSTRA = 0 AND CODCOR = 0');
    Cadastro.Insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDAmostra.CodAmostra;
    Cadastro.FieldByName('CODCOR').AsInteger := VpaDAmostra.DCor.CodCor;
    Cadastro.FieldByName('DESIMAGEM').AsString := VpaDAmostra.DCor.DesImagemCor;
    Cadastro.FieldByName('DATCADASTRO').AsDateTime := VpaDAmostra.DCor.DatCadastro;
    Cadastro.FieldByName('VALPRECOESTIMADO').AsFloat := VpaDAmostra.DCor.ValPrecoEstimado;
    if (VpaDAmostra.DCor.DatFicha <= montadata(1,1,1900)) and
       (Config.ConcluirAmostraSeForFichaTecnica) and
       (VpaDAmostra.CodDepartamento = Config.CodDepartamentoFichaTecnica)  then
      VpaDAmostra.DCor.DatFicha := date;

    if VpaDAmostra.DCor.DatFicha > montadata(1,1,1900) then
      Cadastro.FieldByName('DATFICHACOR').AsDateTime := VpaDAmostra.DCor.DatFicha
    else
      Cadastro.FieldByName('DATFICHACOR').clear;
    if VpaDAmostra.DCor.DatEntrega > montadata(1,1,1900) then
      Cadastro.FieldByName('DATENTREGA').AsDateTime := VpaDAmostra.DCor.DatEntrega
    else
      Cadastro.FieldByName('DATENTREGA').clear;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    Cadastro.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaDItensEspeciais(VpaDAmostra: TRBDAmostra): string;
var
  VpfLaco : Integer;
  VpfDItemEspecial : TRBDItensEspeciaisAmostra;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from AMOSTRAITEMESPECIAL '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra));
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRAITEMESPECIAL ' +
                                 ' WHERE CODAMOSTRA = 0 AND SEQITEM = 0 ');
  for VpfLaco := 0 to VpaDAmostra.ItensEspeciais.Count - 1 do
  begin
    VpfDItemEspecial := TRBDItensEspeciaisAmostra(VpaDAmostra.ItensEspeciais.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger :=  VpaDAmostra.CodAmostra;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfLaco + 1;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger :=  VpfDItemEspecial.SeqProduto;
    Cadastro.FieldByName('VALITEM').AsFloat :=  VpfDItemEspecial.ValProduto;
    Cadastro.FieldByName('DESOBSERVACAO').AsString :=  VpfDItemEspecial.DesObservacao;

    cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaDMotivoAmostra(
  VpaDMotivoAmostra: TRBDPropostaAmostraMotivoAtraso): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRACORMOTIVOATRASO '+
                                 ' Where CODAMOSTRA = 0 AND CODCOR = 0 AND SEQITEM = 0 AND CODMOTIVOATRASO = 0');
  Cadastro.edit;
  Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDMotivoAmostra.CodAmostra;
  Cadastro.FieldByName('CODCOR').AsInteger := VpaDMotivoAmostra.CodCor;
  Cadastro.FieldByName('SEQITEM').AsInteger := VpaDMotivoAmostra.SeqItem;
  Cadastro.FieldByName('CODMOTIVOATRASO').AsInteger := VpaDMotivoAmostra.CodMotivoAtraso;
  Cadastro.FieldByName('DESOBSERVACAO').AsString := VpaDMotivoAmostra.DesObservacao;
  Cadastro.FieldByName('CODUSUARIO').AsInteger :=  VpaDMotivoAmostra.CodUsuario;
  Cadastro.FieldByName('DATCADASTRO').AsDateTime:= now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  if Cadastro.AErronaGravacao then
    aviso(Result);
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaDPrecoClienteAmostra(VpaDAmostra: TRBDAmostra; VpaCorAmostra: Integer): string;
var
  VpfLaco : Integer;
  VpfDPrecoCliente : TRBDPrecoClienteAmostra;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from AMOSTRAPRECOCLIENTE '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                        '  and CODCORAMOSTRA = '+IntToStr(VpaCorAmostra));
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRAPRECOCLIENTE '+
                                 ' Where CODAMOSTRA = 0 AND CODCORAMOSTRA = 0 AND CODCLIENTE = 0 AND CODCOEFICIENTE = 0 AND SEQPRECO = 0 ');
  for VpfLaco := 0 to VpaDAmostra.PrecosClientes.Count -1 do
  begin
    VpfDPrecoCliente := TRBDPrecoClienteAmostra(VpaDAmostra.PrecosClientes.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDAmostra.CodAmostra;
    Cadastro.FieldByName('CODCORAMOSTRA').AsInteger := VpaCorAmostra;
    VpfDPrecoCliente.SeqPreco := VpfLaco +1;
    Cadastro.FieldByName('SEQPRECO').AsInteger := VpfDPrecoCliente.SeqPreco;
    Cadastro.FieldByName('CODCLIENTE').AsInteger := VpfDPrecoCliente.CodCliente;
    Cadastro.FieldByName('CODCOEFICIENTE').AsInteger := VpfDPrecoCliente.CodTabela;
    Cadastro.FieldByName('QTDAMOSTRA').AsFloat :=  VpfDPrecoCliente.QtdVenda;
    Cadastro.FieldByName('VALVENDA').AsFloat := VpfDPrecoCliente.ValVenda;
    Cadastro.FieldByName('PERLUCRO').AsFloat := VpfDPrecoCliente.PerLucro;
    Cadastro.FieldByName('PERCOMISSAO').AsFloat := VpfDPrecoCliente.PerComissao;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaDProcessoAmostra(VpaDAmostra: TRBDAmostra): string;
var
  VpfLaco : Integer;
  VpfDAmostraProcesso : TRBDAmostraProcesso;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from AMOSTRAPROCESSO '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra));
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRAPROCESSO '+
                                 ' Where CODAMOSTRA = 0 AND SEQPROCESSO = 0 ');
  for VpfLaco := 0 to VpaDAmostra.Processos.Count -1 do
  begin
    VpfDAmostraProcesso := TRBDAmostraProcesso(VpaDAmostra.Processos.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDAmostra.CodAmostra;
    VpfDAmostraProcesso.SeqProcesso := VpfLaco +1;
    Cadastro.FieldByName('SEQPROCESSO').AsInteger := VpfDAmostraProcesso.SeqProcesso;
    Cadastro.FieldByName('CODESTAGIO').AsInteger := VpfDAmostraProcesso.CodEstagio;
    Cadastro.FieldByName('CODPROCESSOPRODUCAO').AsInteger := VpfDAmostraProcesso.CodProcessoProducao;
    Cadastro.FieldByName('QTDPRODUCAOHORA').AsFloat := VpfDAmostraProcesso.QtdProducaoHora;
    if VpfDAmostraProcesso.Configuracao then
      Cadastro.FieldByName('INDCONFIGURACAO').AsString := 'S'
    else
      Cadastro.FieldByName('INDCONFIGURACAO').AsString := 'N';
    Cadastro.FieldByName('DESTEMPOCONFIGURACAO').AsString := VpfDAmostraProcesso.DesTempoConfiguracao;
    Cadastro.FieldByName('VALUNITARIO').AsFloat := VpfDAmostraProcesso.ValUnitario;
    Cadastro.FieldByName('DESOBSERVACAO').AsString := VpfDAmostraProcesso.DesObservacoes;

    Cadastro.post;
    Result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;


{******************************************************************************}
function TRBFuncoesAmostra.ConcluiAmostra(VpaCodAmostra: Integer; VpaDatConclusao: TDateTime): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  if Cadastro.FieldByname('DATENTREGA').IsNull then
  begin
    Cadastro.edit;
    Cadastro.FieldByname('DATENTREGA').AsDateTime := VpaDatConclusao;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
  end;

  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluiAmostraCor(VpaCodAmostra, VpaCodCor : Integer;VpaDatConclusao : TDateTime) : string;
var
  VpfCodAmostraIndefinida: Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRACOR '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra) +
                                 ' AND CODCOR = ' +IntToStr(VpaCodCor));
  if Cadastro.FieldByname('DATENTREGA').IsNull then
  begin
    Cadastro.edit;
    Cadastro.FieldByname('DATENTREGA').AsDateTime := VpaDatConclusao;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
  end;
  VpfCodAmostraIndefinida :=RCodAmostraIndefinida(Cadastro.FieldByName('CODAMOSTRA').AsInteger);

  if (result = '') and (VpfCodAmostraIndefinida <> 0) then
    result := VerificaAmostraRealizada(VpfCodAmostraIndefinida);

  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluirPrecoAmostra(VpaCodAmostra : Integer;VpaDatConclusao : TDateTime) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('DATPRECO').AsDateTime := VpaDatConclusao;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluiDesenhoAmostra(VpaSeqRequisicao : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from REQUISICAOMAQUINA '+
                                 ' Where SEQREQUISICAO = '+IntToStr(VpaSeqRequisicao));
  cadastro.edit;
  Cadastro.FieldByName('DATCONCLUSAO').AsDateTime := now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.AlteraDesenvolvedor(VpaCodAmostra : Integer; VpaCodDesenvolvedor: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('CODDESENVOLVEDOR').AsInteger := VpaCodDesenvolvedor;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.AprovaAmostra(VpaCodAmostra : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  if Cadastro.FieldByName('DATAPROVACAO').IsNull then
  begin
    Cadastro.edit;
    Cadastro.FieldByname('DATAPROVACAO').AsDateTime := DATE;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluirFichaAmostra(VpaCodAmostra: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('DATFICHAAMOSTRA').AsDateTime := now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluirFichaCor(VpaCodAmostra,VpaCodCor: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRACOR '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra)+
                                 ' and CODCOR = ' +IntToStr(VpaCodCor));
  Cadastro.edit;
  Cadastro.FieldByname('DATFICHACOR').AsDateTime := now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluirFichaTecnica(VpaCodAmostra : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,' Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('DATFICHA').AsDateTime := now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.EstornarAprovacao(VpaCodAmostra : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('DATAPROVACAO').Clear;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RCustoItensEspeciais(VpaDAmostra: TRBDAmostra): Double;
var
  VpfLaco : Integer;
  VpfDItemEspecial : TRBDItensEspeciaisAmostra;
begin
  result := 0;
  for VpfLaco := 0 to VpaDAmostra.ItensEspeciais.Count - 1 do
  begin
    VpfDItemEspecial := TRBDItensEspeciaisAmostra(VpaDAmostra.ItensEspeciais.Items[VpfLaco]);
    Result := result + VpfDItemEspecial.ValProduto;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.CalculaCustoMaodeObraBordado(VpaDAmostra: TRBDAmostra): Double;
var
  VpfG5, VpfG6, VpfF7, VpfSoma, VpfG8, VpfAux, vpfMinutos : Double;
begin
{ Explicativo custo
  Calcular minuto peca - bordado

  G5 = PONTOS / PAR_ROTACAO

  G6 = (CORTES + TROCA_LINHA) * 0,159

  F7 = PAR_TEMPO_APLIQUE + (PAR_TEMPO_APLIQUE * QTD_APLIQUE)

  SOMA = G5 + G6 + F7

  G8 = (SOMA * PAR_INTERFERENCIA)/100

  AUX = (SOMA + G8) / PAR_QTD_CABECAS

  MINUTOS = AUX + PAR_OPERADOR_MAQUINA

  CUSTO_MO = (PAR_CUSTO_MO_DIRETA * MINUTOS) + (PAR_CUSTO_MO_INDIRETA * MINUTOS) }

  if Varia.RotacaoMaquina > 0 then
  begin
    CarQtdPontos(VpaDAmostra);
    if VpaDAmostra.QtdTotalPontos > 0 then
    begin

      VpfG5 := VpaDAmostra.QtdTotalPontos / Varia.RotacaoMaquina;
      VpfG6  := (VpaDAmostra.QtdCortesBordado + VpaDAmostra.QtdTrocasLinhaBordado) * 0.159;
      if VpaDAmostra.QtdAplique <> 0 then
      begin
        VpfF7 := Varia.TempoAplique + (VpaDAmostra.QtdAplique * Varia.TempoAplique);
      end
      else
        VpfF7 := 0;

      VpfSoma := VpfG5 + VpfG6 + VpfF7;

      VpfG8 := (VpfSoma * Varia.Interferencia) / 100;
      VpfAux := (VpfSoma + VpfG8)/Varia.QtdCabecas;
      vpfMinutos := VpfAux * varia.OperadorPorMaquina;
      VpaDAmostra.CustoMaodeObraBordado := (Varia.ValMaodeObraDireta * vpfMinutos) +
                 (varia.ValMaodeObraIndireta * vpfMinutos);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CalculaValorVendaPeloValorSugerido(VpaDAmostra: TRBDAmostra; VpaValSugerido: Double);
var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
begin
  CalculaValorVendaUnitario(VpaDAmostra);
  for VpfLaco := 0 to VpaDAmostra.ValoresVenda.Count - 1 do
  begin
    VpfDValorVenda := TRBDValorVendaAmostra(VpaDAmostra.ValoresVenda.Items[VpfLaco]);
    if VpfDValorVenda.ValVenda <> 0 then
    begin
      VpfDValorVenda.PerLucro := (VpaValSugerido * 30)/VpfDValorVenda.ValVenda;
      CalculaValorVendaUnitario(VpaDAmostra,VpfDValorVenda);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CalculaValorVendaUnitario(VpaDAmostra: TRBDAmostra; VpaDValorVenda: TRBDValorVendaAmostra);
var
  VpfCoeficiente, VpfCustoUnitarioItemEspecial  : Double;
begin
  if config.CalcularPrecoAmostracomValorLucroenaoPercentual then
  begin
    CalculaValorVendaUnitarioPorValorLucro(VpaDAmostra,VpaDValorVenda);
    exit;
  end;

  VpfCustoUnitarioItemEspecial :=  VpaDAmostra.CustoItensEspeciais / VpaDValorVenda.Quantidade;
  VpfCoeficiente := VpaDValorVenda.PerCoeficientes + VpaDValorVenda.PerComissao + VpaDValorVenda.PerLucro;
  VpaDValorVenda.CustoComImposto := (VpaDAmostra.CustoProduto)   /(1-((VpaDValorVenda.PerCoeficientes + VpaDValorVenda.PerComissao)/100));
  VpaDValorVenda.ValVenda := (VpaDAmostra.CustoProduto ) /(1-(vpfCoeficiente/100));
  VpaDValorVenda.ValVenda := VpaDValorVenda.ValVenda + VpfCustoUnitarioItemEspecial;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CalculaValorVendaUnitarioPorValorLucro(VpaDAmostra: TRBDAmostra; VpaDValorVenda: TRBDValorVendaAmostra);
var
  VpfCoeficiente, VpfCustoUnitarioItemEspecial  : Double;
  VpfValSobra : Double;
begin
{  VpfCustoUnitarioItemEspecial :=  VpaDAmostra.CustoItensEspeciais / VpaDValorVenda.Quantidade;
  VpaDValorVenda.CustoComImposto := (VpaDAmostra.CustoProduto)   /(1-((VpaDValorVenda.PerCoeficientes + VpaDValorVenda.PerComissao)/100));
  VpaDValorVenda.ValVenda := (VpaDAmostra.CustoProduto ) /(1-(vpfCoeficiente/100));
  VpaDValorVenda.ValVenda := VpaDValorVenda.ValVenda + VpfCustoUnitarioItemEspecial;}

  VpfCoeficiente := VpaDValorVenda.PerCoeficientes + VpaDValorVenda.PerComissao;
  VpfValSobra := 10;
  VpaDValorVenda.ValVenda := VpaDAmostra.CustoProduto * 4;
  while not((VpfValSobra < 1) and (VpfValSobra > -1)) do
  begin
    VpfValSobra := VpaDValorVenda.ValVenda;
    VpfValSobra := VpfValSobra - ((VpaDValorVenda.ValVenda *VpfCoeficiente)/100);
    VpfValSobra := VpfValSobra - VpaDAmostra.CustoProduto;
    VpfValSobra := VpfValSobra - VpaDValorVenda.PerLucro;
    if VpfValSobra > 0 then
      VpaDValorVenda.ValVenda := VpaDValorVenda.ValVenda - 0.1
    else
      VpaDValorVenda.ValVenda := VpaDValorVenda.ValVenda + 0.1;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarAmostracor(VpaDAmotra: TRBDAmostra;vpaCorAmostra: Integer);
begin
  AdicionaSQLAbreTabela(Amostra,'Select CODCOR, DESIMAGEM, DATCADASTRO, DATFICHACOR, VALPRECOESTIMADO, DATENTREGA ' +
                               ' from AMOSTRACOR' +
                               ' Where CODAMOSTRA = ' +IntToStr(VpaDAmotra.CodAmostra)+
                               ' and CODCOR = ' +IntToStr(vpaCorAmostra));
  if amostra.Eof then
  begin
    VpaDAmotra.DCor.DatCadastro := now;
    VpaDAmotra.DCor.DatFicha := montadata(1,1,1900);
    VpaDAmotra.DCor.DatEntrega := montadata(1,1,1900);
  end
  else
  begin
    VpaDAmotra.DCor.DatCadastro := Amostra.fieldbyname('DATCADASTRO').AsDateTime;
    VpaDAmotra.DCor.DatFicha := Amostra.fieldbyname('DATFICHACOR').AsDateTime;
    VpaDAmotra.DCor.DatEntrega := Amostra.fieldbyname('DATENTREGA').AsDateTime;
  end;
  VpaDAmotra.DCor.DesImagemCor := Amostra.fieldbyname('DESIMAGEM').AsString;
  VpaDAmotra.DCor.Codcor := Amostra.fieldbyname('CODCOR').AsInteger;
  VpaDAmotra.DCor.ValPrecoEstimado:= Amostra.FieldByName('VALPRECOESTIMADO').AsFloat;
  Amostra.Close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarCoeficientesTabelaPreco(VpaDAmostra: TRBDAmostra);
Var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
  VpfDQuantidade : TRBDQuantidadeAmostra;
begin
  FreeTObjectsList(VpaDAmostra.ValoresVenda);
  AdicionaSQLAbreTabela(Amostra,'Select * from COEFICIENTECUSTO'+
                                ' order by CODCOEFICIENTE ');
  while not Amostra.Eof do
  begin
    for VpfLaco := 0 to VpaDAmostra.Quantidades.Count - 1 do
    begin
      VpfDQuantidade := TRBDQuantidadeAmostra(VpaDAmostra.Quantidades.Items[VpfLaco]);
      VpfDValorVenda := VpaDAmostra.addValorVenda;
      VpfDValorVenda.CodTabela := Amostra.FieldByName('CODCOEFICIENTE').AsInteger;
      VpfDValorVenda.NomTabela := Amostra.FieldByName('NOMCOEFICIENTE').AsString;
      VpfDValorVenda.PerCoeficientes := Amostra.FieldByName('PERICMS').AsFloat+ Amostra.FieldByName('PERPISCOFINS').AsFloat +Amostra.FieldByName('PERFRETE').AsFloat+
                                        Amostra.FieldByName('PERADMINISTRATIVO').AsFloat + Amostra.FieldByName('PERPROPAGANDA').AsFloat;
      VpfDValorVenda.PerComissao := Amostra.FieldByName('PERCOMISSAO').AsFloat;
      VpfDValorVenda.PerVendaPrazo := Amostra.FieldByName('PERVENDAPRAZO').AsFloat;
      VpfDValorVenda.PerLucro := Amostra.FieldByName('PERLUCRO').AsFloat;
      VpfDValorVenda.Quantidade :=VpfDQuantidade.Quantidade;
    end;
    Amostra.Next;
  end;
  Amostra.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarConsumosAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
Var
  VpfDConsumo : TRBDConsumoAmostra;
begin
  FreeTObjectsList(VpaDAmostra.DCor.Consumos);
  Amostra.Close;
  Amostra.SQL.Clear;
  Amostra.SQL.Add('Select CON.SEQCONSUMO, CON.SEQPRODUTO, CON.DESUM, CON.NOMPRODUTO, CON.CODCOR,' +
                  ' CON.DESOBSERVACAO, CON.DESLEGENDA, CON.VALUNITARIO, CON.QTDPRODUTO, CON.VALTOTAL,'+
                  ' CON.CODFACA, CON.ALTMOLDE, CON.LARMOLDE, CON.CODMAQUINA,  '+
                  ' CON.DESOBSERVACAO, CON.NUMSEQUENCIA, CON.QTDPONTOSBORDADO, '+
                  ' PRO.C_COD_PRO, PRO.I_ALT_PRO, '+
                  ' COR.NOM_COR, '  +
                  ' CLA.N_PER_PER, ' +
                  ' TIP.CODTIPOMATERIAPRIMA, TIP.NOMTIPOMATERIAPRIMA '+
                  ' FROM AMOSTRACONSUMO CON, CADPRODUTOS PRO, COR, TIPOMATERIAPRIMA TIP, CADCLASSIFICACAO CLA  '+
                  ' Where CON.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra));
  Amostra.SQL.Add(' AND CON.CODCORAMOSTRA = '+IntToStr(VpaCorAmostra));
  Amostra.SQL.Add(' AND CON.SEQPRODUTO = PRO.I_SEQ_PRO '+
                  ' AND '+SQLTextoRightJoin('CON.CODCOR','COR.COD_COR')+
                  ' AND '+SQLTextoRightJoin('CON.CODTIPOMATERIAPRIMA','TIP.CODTIPOMATERIAPRIMA')+
                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                  ' ORDER BY NUMSEQUENCIA, SEQCONSUMO');
  Amostra.Open;
  while not Amostra.Eof do
  begin
    VpfDConsumo := VpaDAmostra.DCor.addConsumo;
    VpfDConsumo.SeqConsumo := Amostra.FieldByname('SEQCONSUMO').AsInteger;
    VpfDConsumo.CodCorAmostra := VpaCorAmostra;
    VpfDConsumo.SeqProduto := Amostra.FieldByname('SEQPRODUTO').AsInteger;
    VpfDConsumo.CodCor := Amostra.FieldByname('CODCOR').AsInteger;
    VpfDConsumo.CodProduto := Amostra.FieldByname('C_COD_PRO').AsString;
    VpfDConsumo.NomProduto := Amostra.FieldByname('NOMPRODUTO').AsString;
    VpfDConsumo.NomCor := Amostra.FieldByname('NOM_COR').AsString;
    VpfDConsumo.DesUM :=  Amostra.FieldByname('DESUM').AsString;
    VpfDConsumo.UMAnterior :=  VpfDConsumo.DesUM;
    VpfDConsumo.UnidadeParentes := FunProdutos.ValidaUnidade.UnidadesParentes(VpfDConsumo.DesUM);
    VpfDConsumo.DesObservacao := Amostra.FieldByname('DESOBSERVACAO').AsString;
    VpfDConsumo.Qtdproduto := Amostra.FieldByname('QTDPRODUTO').AsFloat;
    VpfDConsumo.ValUnitario := Amostra.FieldByname('VALUNITARIO').AsFloat;
    VpfDConsumo.ValTotal := Amostra.FieldByname('VALTOTAL').AsFloat;
    VpfDConsumo.CodFaca := Amostra.FieldByname('CODFACA').AsInteger;
    VpfDConsumo.AltProduto := Amostra.FieldByname('I_ALT_PRO').AsInteger;
    VpfDConsumo.LarMolde := Amostra.FieldByname('LARMOLDE').AsFloat;
    VpfDConsumo.AltMolde := Amostra.FieldByname('ALTMOLDE').AsFloat;
    VpfDConsumo.CodMaquina := Amostra.FieldByname('CODMAQUINA').AsInteger;
    VpfDConsumo.DesObservacao := Amostra.FieldByname('DESOBSERVACAO').AsString;
    VpfDConsumo.DesLegenda := Amostra.FieldByname('DESLEGENDA').AsString;
    VpfDConsumo.CodTipoMateriaPrima := Amostra.FieldByName('CODTIPOMATERIAPRIMA').AsInteger;
    VpfDConsumo.NomTipoMateriaPrima := Amostra.FieldByName('NOMTIPOMATERIAPRIMA').AsString;
    VpfDConsumo.NumSequencia := Amostra.FieldByName('NUMSEQUENCIA').AsInteger;
    VpfDConsumo.QtdPontos := Amostra.FieldByName('QTDPONTOSBORDADO').AsInteger;
    VpfDConsumo.PerAcrescimoPerda := Amostra.FieldByName('N_PER_PER').AsFloat;
    if VpfDConsumo.CodFaca <> 0 then
      FunProdutos.ExisteFaca(VpfDConsumo.CodFaca,VpfDConsumo.Faca);
    if VpfDConsumo.CodMaquina <> 0 then
      FunProdutos.ExisteMaquina(VpfDConsumo.CodMaquina,VpfDConsumo.Maquina);
    Amostra.next;
  end;
  Amostra.close;
  CarPrecosClienteAmostra(VpaDAmostra,VpaCorAmostra);
  CarAmostracor(VpaDAmostra,VpaCorAmostra);
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaAmostraConsumoLog(VpaCodAmostra, VpaCodCor: Integer): string;
Var
  VpfNomArquivo : String;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRACONSUMOLOG '+
                                    ' Where CODAMOSTRA = 0 AND CODCOR = 0 AND SEQLOG = 0' );
  Cadastro.insert;
  Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaCodAmostra;
  Cadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;
  Cadastro.FieldByName('DATLOG').AsDateTime := now;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;

  VpfNomArquivo := varia.PathVersoes+'\LOG\AMOSTRA\'+FormatDateTime('YYYYMM',date)+'\' +IntToStr(VpaCodAmostra)+'_CONSUMO_'+IntToStr(VpaCodCor)+'_'+FormatDateTime('YYMMDDHHMMSSMM',NOW)+'.xml';
  Cadastro.FieldByname('DESLOCALARQUIVO').AsString := VpfNomArquivo;
  Cadastro.FieldByName('SEQLOG').AsInteger := RSeqLogAmostraConsumoDisponivel(VpaCodAmostra,VpaCodCor);
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRACONSUMO '+
                            ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra)+
                            ' AND CODCORAMOSTRA = '+IntToStr(VpaCodCor)+
                            ' order by SEQCONSUMO');
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  Cadastro.SaveToFile(VpfNomArquivo,dfxml);
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaAmostraLog(VpaCodAmostra : Integer): string;
Var
  VpfNomArquivo : String;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRALOG '+
                                    ' Where CODAMOSTRA = 0 AND SEQLOG = 0' );
  Cadastro.insert;
  Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaCodAmostra;
  Cadastro.FieldByName('DATLOG').AsDateTime := now;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;

  VpfNomArquivo := varia.PathVersoes+'\LOG\AMOSTRA\'+FormatDateTime('YYYYMM',date)+'\'+IntToStr(VpaCodAmostra)+'_'+FormatDateTime('YYMMDDHHMMSSMM',NOW)+'.xml';
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  Cadastro.FieldByname('DESLOCALARQUIVO').AsString := VpfNomArquivo;
  Cadastro.FieldByName('SEQLOG').AsInteger := RSeqLogAmostraDisponivel(VpaCodAmostra);
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.SaveToFile(VpfNomArquivo,dfxml);
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaConsumoAmostra(VpaDAmostra: TRBDAmostra): string;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoAmostra;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from AMOSTRACONSUMO '+
                        ' Where CODAMOSTRA = '+ IntToStr(VpaDAmostra.CodAmostra)+
                        ' and CODCORAMOSTRA = '+IntToStr(VpaDAmostra.DCor.CodCor));
  AdicionaSqlAbreTabela(Cadastro,'Select * from AMOSTRACONSUMO '+
                                 ' Where CODAMOSTRA = 0 AND CODCORAMOSTRA = 0 AND SEQCONSUMO = 0 ');
  for VpfLaco := 0 to VpaDAmostra.DCor.Consumos.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoAmostra(VpaDAmostra.DCor.Consumos.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDAmostra.CodAmostra;
    Cadastro.FieldByName('CODCORAMOSTRA').AsInteger := VpaDAmostra.DCor.CodCor;
    Cadastro.FieldByName('SEQCONSUMO').AsInteger := VpfLaco + 1;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDConsumo.SeqProduto;
    cadastro.FieldByName('NOMPRODUTO').AsString := VpfDConsumo.NomProduto;
    cadastro.FieldByName('DESUM').AsString := VpfDConsumo.DesUM;
    IF VpfDConsumo.CodCor <> 0 then
      Cadastro.FieldByName('CODCOR').AsInteger := VpfDConsumo.CodCor;
    Cadastro.FieldByName('QTDPRODUTO').AsFloat := VpfdConsumo.Qtdproduto;
    Cadastro.FieldByName('VALUNITARIO').AsFloat := VpfdConsumo.ValUnitario;
    Cadastro.FieldByName('VALTOTAL').AsFloat := VpfdConsumo.ValTotal;
    Cadastro.FieldByName('DESOBSERVACAO').AsString := VpfdConsumo.DesObservacao;
    Cadastro.FieldByName('DESLEGENDA').AsString := VpfdConsumo.DesLegenda;
    if VpfDConsumo.CodFaca <> 0 then
      Cadastro.FieldByName('CODFACA').AsInteger := VpfDConsumo.CodFaca;
    if VpfDConsumo.LarMolde <> 0 then
      Cadastro.FieldByName('LARMOLDE').AsFloat := VpfDConsumo.LarMolde;
    if VpfDConsumo.AltMolde <> 0 then
      Cadastro.FieldByName('ALTMOLDE').AsFloat := VpfDConsumo.AltMolde;
    if VpfDConsumo.CodMaquina <> 0 then
      Cadastro.FieldByName('CODMAQUINA').AsInteger := VpfDConsumo.CodMaquina;
    if VpfDConsumo.QtdPecasemMetro <> 0 then
      Cadastro.FieldByName('QTDPECAEMMETRO').AsFloat := VpfDConsumo.QtdPecasemMetro;
    if VpfDConsumo.ValIndiceConsumo <> 0 then
      Cadastro.FieldByName('VALINDICEMETRO').AsFloat := VpfDConsumo.ValIndiceConsumo;
    if VpfDConsumo.CodTipoMateriaPrima <> 0 then
      Cadastro.FieldByName('CODTIPOMATERIAPRIMA').AsInteger := VpfDConsumo.CodTipoMateriaPrima;
    if VpfDConsumo.NumSequencia <> 0 then
      Cadastro.FieldByName('NUMSEQUENCIA').AsInteger := VpfDConsumo.NumSequencia;
    if VpfDConsumo.QtdPontos <> 0 then
      Cadastro.FieldByName('QTDPONTOSBORDADO').AsInteger := VpfDConsumo.QtdPontos;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
  if result = '' then
  begin
    if result = '' then
    begin
      result := GravaDPrecoClienteAmostra(VpaDAmostra,VpaDAmostra.DCor.CodCor);
      if result = '' then
      begin
        result := AtualizaTrocaLinhasQtdTotalPontosAmostra(VpaDAmostra);
        if result = '' then
        begin
          result := GravaDAmostracor(VpaDAmostra);
          if result = '' then
          begin
            result := GravaAmostraConsumoLog(VpaDAmostra.CodAmostra,VpaDAmostra.DCor.CodCor);
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaRequisicaoMAquina(VpaCodAmostra, VpaCodMaquina : Integer;VpaDesRequisicao : string):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from REQUISICAOMAQUINA ');
  Cadastro.insert;
  Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaCodAmostra;
  Cadastro.FieldByName('CODMAQUINA').AsInteger := VpaCodMaquina;
  Cadastro.FieldByName('DESREQUISICAO').AsString := VpaDesRequisicao;
  Cadastro.FieldByName('DATREQUISICAO').AsDateTime := now;
  Cadastro.FieldByName('SEQREQUISICAO').AsInteger := RSeqRequisicaoMaquinaDisponivel;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarDAmostra(VpaDAmostra: TRBDAmostra; VpaCodAmostra : Integer);
begin
  AdicionaSQLAbreTabela(Amostra,'SELECT * FROM AMOSTRA'+
                                ' WHERE CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  VpaDAmostra.CodAmostra:= VpaCodAmostra;
  VpaDAmostra.CodColecao:= Amostra.FieldByName('CODCOLECAO').AsInteger;
  VpaDAmostra.CodDesenvolvedor:= Amostra.FieldByName('CODDESENVOLVEDOR').AsInteger;
  VpaDAmostra.CodDepartamento := Amostra.FieldByName('CODDEPARTAMENTOAMOSTRA').AsInteger;
  VpaDAmostra.CodProspect:= Amostra.FieldByName('CODCLIENTE').AsInteger;
  VpaDAmostra.CodVendedor:= Amostra.FieldByName('CODVENDEDOR').AsInteger;
  VpaDAmostra.CodAmostraIndefinida:= Amostra.FieldByName('CODAMOSTRAINDEFINIDA').AsInteger;
  VpaDAmostra.QtdAmostra:= Amostra.FieldByName('QTDAMOSTRA').AsInteger;
  VpaDAmostra.NomAmostra:= Amostra.FieldByName('NOMAMOSTRA').AsString;
  VpaDAmostra.DesImagem:= Amostra.FieldByName('DESIMAGEM').AsString;
  VpaDAmostra.DesImagemCliente:= Amostra.FieldByName('DESIMAGEMCLIENTE').AsString;
  VpaDAmostra.IndCopia:= Amostra.FieldByName('INDCOPIA').AsString;
  VpaDAmostra.TipAmostra:= Amostra.FieldByName('TIPAMOSTRA').AsString;
  VpaDAmostra.DesObservacao:= Amostra.FieldByName('DESOBSERVACAO').AsString;
  VpaDAmostra.CodProduto:= Amostra.FieldByName('CODPRODUTO').AsString;
  VpaDAmostra.IndAlteracao:= Amostra.FieldByName('INDALTERACAO').AsString;
  VpaDAmostra.DatAmostra:= Amostra.FieldByName('DATAMOSTRA').AsDateTime;
  VpaDAmostra.DatEntrega:= Amostra.FieldByName('DATENTREGA').AsDateTime;
  VpaDAmostra.DatEntregaCliente:= Amostra.FieldByName('DATENTREGACLIENTE').AsDateTime;
  VpaDAmostra.DatAprovacao:= Amostra.FieldByName('DATAPROVACAO').AsDateTime;
  VpaDAmostra.DatAlteradoEntrega:= Amostra.FieldByName('DATALTERADOENTREGA').AsDateTime;
  VpaDAmostra.DatFicha:= Amostra.FieldByName('DATFICHA').AsDateTime;
  VpaDAmostra.QtdPrevisaoCompra:= Amostra.FieldByName('QTDPREVISAOCOMPRA').AsFloat;
  VpaDAmostra.QtdTotalPontos := Amostra.FieldByName('QTDTOTALPONTOSBORDADO').AsInteger;
  VpaDAmostra.QtdCortesBordado := Amostra.FieldByName('QTDCORTES').AsInteger;
  VpaDAmostra.QtdTrocasLinhaBordado := Amostra.FieldByName('QTDTROCALINHA').AsInteger;
  VpaDAmostra.CodClassificacao := Amostra.FieldByName('CODCLASSIFICACAO').AsString;
  VpaDAmostra.IndPossuiPrecoEstimado:= Amostra.FieldByName('INDPRECOESTIMADO').AsString;
  Amostra.Close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarDAmostraProcesso(VpaDAmostraProcesso: TRBDAmostraProcesso; VpaCodProcessoProducao: Integer);
begin
  AdicionaSQLAbreTabela(Amostra,'SELECT * FROM PROCESSOPRODUCAO'+
                                ' WHERE CODPROCESSOPRODUCAO = '+IntToStr(VpaCodProcessoProducao));
  //VpaDAmostraProcesso.CodProcessoProducao := Amostra.Create.FieldByName('CODPROCESSOPRODUCAO').AsInteger;
  VpaDAmostraProcesso.QtdProducaoHora := Amostra.FieldByName('QTDPRODUCAOHORA').AsFloat;
  VpaDAmostraProcesso.Configuracao := Amostra.FieldByName('INDCONFIGURACAO').AsString = 'S';
  VpaDAmostraProcesso.DesTempoConfiguracao := Amostra.FieldByName('DESTEMPOCONFIGURACAO').AsString;
  Amostra.Close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarItensEspeciais(VpaDAmostra: TRBDAmostra);
Var
  VpfDItemEspecial : TRBDItensEspeciaisAmostra;
begin
  AdicionaSQLAbreTabela(Amostra,'Select PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_PRO, ' +
                                ' AIE.VALITEM, AIE.DESOBSERVACAO '+
                                ' from AMOSTRAITEMESPECIAL AIE, CADPRODUTOS PRO' +
                                ' Where AIE.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                                ' AND AIE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                ' ORDER BY AIE.SEQITEM ');
  FreeTObjectsList(VpaDAmostra.ItensEspeciais);
  while not Amostra.eof do
  begin
    VpfDItemEspecial :=VpaDAmostra.addItemEspecial;
    VpfDItemEspecial.SeqProduto := Amostra.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDItemEspecial.CodProduto := Amostra.FieldByName('C_COD_PRO').AsString;
    VpfDItemEspecial.NomProduto := Amostra.FieldByName('C_NOM_PRO').AsString;
    VpfDItemEspecial.DesObservacao := Amostra.FieldByName('DESOBSERVACAO').AsString;
    VpfDItemEspecial.ValProduto := Amostra.FieldByName('VALITEM').AsFloat;
    Amostra.Next;
  end;
  Amostra.Close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarPerLucroComissaoCoeficienteCusto(VpaCodCoeficiente: Integer;var VpaPerLucro, VpaPerComissao : Double);
begin
  AdicionaSQLAbreTabela(Aux,'Select PERCOMISSAO, PERLUCRO FROM COEFICIENTECUSTO '+
                            ' Where CODCOEFICIENTE = '+IntToStr(VpaCodCoeficiente));
  VpaPerLucro := Aux.FieldByName('PERLUCRO').AsFloat;
  VpaPerComissao := Aux.FieldByName('PERCOMISSAO').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarPrecosClienteAmostra(VpaDAmostra: TRBDAmostra;VpaCorAmostra: Integer);
Var
  VpfDPreAmostra :TRBDPrecoClienteAmostra;
begin
  FreeTObjectsList(VpaDAmostra.PrecosClientes);

  AdicionaSQLAbreTabela(Amostra,'Select AMP.CODAMOSTRA, AMP.CODCORAMOSTRA, AMP.SEQPRECO, AMP.CODCLIENTE, AMP.CODCOEFICIENTE, AMP.QTDAMOSTRA, ' +
                                ' AMP.VALVENDA, AMP.PERLUCRO, AMP.PERCOMISSAO, ' +
                                ' CLI.C_NOM_CLI, ' +
                                ' COE.NOMCOEFICIENTE ' +
                                ' FROM AMOSTRAPRECOCLIENTE AMP, CADCLIENTES CLI, COEFICIENTECUSTO COE ' +
                                ' Where AMP.CODCLIENTE = CLI.I_COD_CLI ' +
                                ' AND AMP.CODCOEFICIENTE = COE.CODCOEFICIENTE '+
                               ' and AMP.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                               ' and AMP.CODCORAMOSTRA = '+IntToStr(VpaCorAmostra)+
                               ' order by AMP.CODCLIENTE, AMP.CODCORAMOSTRA, AMP.QTDAMOSTRA ');
  While not Amostra.eof do
  begin
    VpfDPreAmostra := VpaDAmostra.addPrecoCliente;
    VpfDPreAmostra.SeqPreco := Amostra.FieldByName('SEQPRECO').AsInteger;
    VpfDPreAmostra.CodTabela := Amostra.FieldByName('CODCOEFICIENTE').AsInteger;
    VpfDPreAmostra.CodCliente := Amostra.FieldByName('CODCLIENTE').AsInteger;
    VpfDPreAmostra.NomTabela := Amostra.FieldByName('NOMCOEFICIENTE').AsString;
    VpfDPreAmostra.NomCliente := Amostra.FieldByName('C_NOM_CLI').AsString;
    VpfDPreAmostra.ValVenda := Amostra.FieldByName('VALVENDA').AsFloat;
    VpfDPreAmostra.QtdVenda := Amostra.FieldByName('QTDAMOSTRA').AsFloat;
    VpfDPreAmostra.PerLucro := Amostra.FieldByName('PERLUCRO').AsFloat;
    VpfDPreAmostra.PerComissao := Amostra.FieldByName('PERCOMISSAO').AsFloat;
    Amostra.next;
  end;
  Amostra.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.CarProcessoAmostraImportacao(VpaDAmostra: TRBDAmostra): TRBDAmostraProcesso;
Var
  VpfDAmostraProcesso : TRBDAmostraProcesso;
begin
  FreeTObjectsList(VpaDAmostra.Processos);

  AdicionaSQLAbreTabela(Amostra,' SELECT AMP.CODAMOSTRA, AMP.SEQPROCESSO, AMP.CODESTAGIO, ' +
                                '        AMP.CODPROCESSOPRODUCAO, AMP.QTDPRODUCAOHORA, AMP.INDCONFIGURACAO,  '+
                                '        AMP.DESTEMPOCONFIGURACAO, AMP.VALUNITARIO, AMP.DESOBSERVACAO ' +
                                '  FROM AMOSTRAPROCESSO AMP '+
                                ' WHERE AMP.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                                ' ORDER BY AMP.SEQPROCESSO ');
  While not Amostra.eof do
  begin
    VpfDAmostraProcesso := VpaDAmostra.addProcesso;
    VpfDAmostraProcesso.SeqProcesso := Amostra.FieldByName('SEQPROCESSO').AsInteger;
    VpfDAmostraProcesso.CodAmostra := VpaDAmostra.CodAmostra;
    VpfDAmostraProcesso.CodEstagio := Amostra.FieldByName('CODESTAGIO').AsInteger;
    VpfDAmostraProcesso.CodProcessoProducao := Amostra.FieldByName('CODPROCESSOPRODUCAO').AsInteger;
    VpfDAmostraProcesso.QtdProducaoHora := Amostra.FieldByName('QTDPRODUCAOHORA').AsFloat;
    VpfDAmostraProcesso.Configuracao  := Amostra.FieldByName('INDCONFIGURACAO').AsString = 'S';
    VpfDAmostraProcesso.DesTempoConfiguracao := Amostra.FieldByName('DESTEMPOCONFIGURACAO').AsString;
    VpfDAmostraProcesso.ValUnitario := Amostra.FieldByName('VALUNITARIO').AsFloat;
    VpfDAmostraProcesso.DesObservacoes := Amostra.FieldByName('DESOBSERVACAO').AsString;
    Amostra.next;
  end;
  Result:= VpfDAmostraProcesso;
  Amostra.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarProcessosAmostra(VpaDAmostra: TRBDAmostra);
Var
  VpfDAmostraProcesso : TRBDAmostraProcesso;
begin
  FreeTObjectsList(VpaDAmostra.Processos);

  AdicionaSQLAbreTabela(Amostra,' SELECT AMP.CODAMOSTRA, AMP.SEQPROCESSO, AMP.CODESTAGIO, ' +
                                '        AMP.CODPROCESSOPRODUCAO, AMP.QTDPRODUCAOHORA, AMP.INDCONFIGURACAO,  '+
                                '        AMP.DESTEMPOCONFIGURACAO, AMP.VALUNITARIO, AMP.DESOBSERVACAO ' +
                                '  FROM AMOSTRAPROCESSO AMP '+
                                ' WHERE AMP.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                                ' ORDER BY AMP.SEQPROCESSO ');
  While not Amostra.eof do
  begin
    VpfDAmostraProcesso := VpaDAmostra.addProcesso;
    VpfDAmostraProcesso.SeqProcesso := Amostra.FieldByName('SEQPROCESSO').AsInteger;
    VpfDAmostraProcesso.CodAmostra := VpaDAmostra.CodAmostra;
    VpfDAmostraProcesso.CodEstagio := Amostra.FieldByName('CODESTAGIO').AsInteger;
    VpfDAmostraProcesso.CodProcessoProducao := Amostra.FieldByName('CODPROCESSOPRODUCAO').AsInteger;
    VpfDAmostraProcesso.QtdProducaoHora := Amostra.FieldByName('QTDPRODUCAOHORA').AsFloat;
    VpfDAmostraProcesso.Configuracao  := Amostra.FieldByName('INDCONFIGURACAO').AsString = 'S';
    VpfDAmostraProcesso.DesTempoConfiguracao := Amostra.FieldByName('DESTEMPOCONFIGURACAO').AsString;
    VpfDAmostraProcesso.ValUnitario := Amostra.FieldByName('VALUNITARIO').AsFloat;
    VpfDAmostraProcesso.DesObservacoes := Amostra.FieldByName('DESOBSERVACAO').AsString;
    Amostra.next;
  end;
  Amostra.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.AtualizarAmostra(VpaCodAmostra: Integer; VpaDAmostra: TRBDAmostra): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM AMOSTRA'+
                                 ' WHERE CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  if not Cadastro.Eof then
  begin
    Cadastro.Edit;
    Cadastro.FieldByName('CODPRODUTO').AsString:= VpaDAmostra.CodProduto;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.AtualizaTrocaLinhasQtdTotalPontosAmostra(VpaDAmostra: TRBDAmostra): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra));
  Cadastro.Edit;
  Cadastro.FieldByName('QTDTOTALPONTOSBORDADO').AsInteger := VpaDAmostra.QtdTotalPontos;
  Cadastro.FieldByName('QTDCORTES').AsInteger := VpaDAmostra.QtdCortesBordado;
  Cadastro.FieldByName('QTDTROCALINHA').AsInteger := VpaDAmostra.QtdTrocasLinhaBordado;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.CopiaConsumoAmostraProduto(VpaCodAmostra,VpaSeqProduto : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Amostra,'Select * from AMOSTRACONSUMO '+
                                ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from MOVKITBASTIDOR '+
                        ' Where SEQPRODUTOKIT = '+IntToStr(VpaSeqProduto));
  ExecutaComandoSql(Aux,'Delete from MOVKIT '+
                        ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto));
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVKIT '+
                                 ' Where I_PRO_KIT = 0 AND I_SEQ_MOV = 0 AND I_COR_KIT = 0 ');
  While not Amostra.Eof do
  begin
    Cadastro.Insert;
    Cadastro.FieldByname('I_PRO_KIT').AsInteger := VpaSeqProduto;
    Cadastro.FieldByname('I_SEQ_PRO').AsInteger := Amostra.FieldByname('SEQPRODUTO').AsInteger;
    Cadastro.FieldByname('N_QTD_PRO').AsFloat := Amostra.FieldByname('QTDPRODUTO').AsFloat;
    Cadastro.FieldByname('I_COD_EMP').AsInteger := VARIA.CodigoEmpresa;
    Cadastro.FieldByname('D_ULT_ALT').AsDateTime := date;
    if Amostra.FieldByname('CODCOR').AsInteger <> 0 then
      Cadastro.FieldByname('I_COD_COR').AsInteger := Amostra.FieldByname('CODCOR').AsInteger;
    Cadastro.FieldByname('C_COD_UNI').AsString := Amostra.FieldByname('DESUM').AsString;
    Cadastro.FieldByname('I_SEQ_MOV').AsInteger := Amostra.FieldByname('SEQCONSUMO').AsInteger;
    Cadastro.FieldByname('I_COR_KIT').AsInteger := Amostra.FieldByname('CODCORAMOSTRA').AsInteger;
    if Amostra.FieldByname('CODFACA').AsInteger <> 0 then
      Cadastro.FieldByname('I_COD_FAC').AsInteger := Amostra.FieldByname('CODFACA').AsInteger;
    if Amostra.FieldByname('ALTMOLDE').AsFloat <> 0 then
      Cadastro.FieldByname('I_ALT_MOL').Asfloat := Amostra.FieldByname('ALTMOLDE').AsFloat;
    if Amostra.FieldByname('LARMOLDE').Asfloat <> 0 then
      Cadastro.FieldByname('I_LAR_MOL').AsFloat := Amostra.FieldByname('LARMOLDE').AsFloat;
    if Amostra.FieldByname('CODMAQUINA').AsInteger <> 0 then
      Cadastro.FieldByname('I_COD_MAQ').AsInteger := Amostra.FieldByname('CODMAQUINA').AsInteger;
    Cadastro.FieldByname('N_VLR_UNI').AsFloat := Amostra.FieldByname('VALUNITARIO').AsFloat;
    Cadastro.FieldByname('N_VLR_TOT').AsFloat := Amostra.FieldByname('VALTOTAL').AsFloat;
    Cadastro.FieldByname('N_PEC_MET').AsFloat := Amostra.FieldByname('QTDPECAEMMETRO').AsFloat;
    Cadastro.FieldByname('N_IND_MET').AsFloat := Amostra.FieldByname('VALINDICEMETRO').AsFloat;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
    Amostra.next;
  end;
  Amostra.close;
  Cadastro.close;
  AprovaAmostra(VpaCodAmostra);
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CalculaValorVendaUnitario(VpaDAmostra : TRBDAmostra);
var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
begin
{Explicativo do custo
  CALCULAR MINUTOS PEÇA - BORDADO;


  COEFICIENTE = %ICMS + %PIS + %COMISSAO + %FRETE + %ADM_VENDAS + %PROPAGANDA

  CUSTO_IMPOSTOS = CUSTO_PRODUTO /(1-(COEFICIENTE/100))

  PVENDA = (CUSTO_PRODUTO /1 -((COEFICIENTE + % LUCRO)/100)))

  PVENDA_PRAZO = (CUSTO_PRODUTO / (1 - ((COEFICIENTE +%LUCRO + %VENDAPRAZO)/100)))}

//  if VpaDAmostra.ValoresVenda.Count = 0 then
    CarCoeficientesTabelaPreco(VpaDAmostra);
  VpaDAmostra.CustoMateriaPrima := RValCustoMateriaPrima(VpaDAmostra);
  VpaDAmostra.CustoProcessos := RValCustoProcessos(VpaDAmostra);
  CalculaCustoMaodeObraBordado(VpaDAmostra);
  VpaDAmostra.CustoProduto := VpaDAmostra.CustoProcessos + VpaDAmostra.CustoMateriaPrima + VpaDAmostra.CustoMaodeObraBordado;;
  VpaDAmostra.CustoItensEspeciais := RCustoItensEspeciais(VpaDAmostra);

  for VpfLaco := 0 to VpaDAmostra.ValoresVenda.Count - 1 do
  begin
    VpfDValorVenda := TRBDValorVendaAmostra(VpaDAmostra.ValoresVenda.Items[VpfLaco]);
    if config.CalcularPrecoAmostracomValorLucroenaoPercentual then
      CalculaValorVendaUnitarioPorValorLucro(VpaDAmostra,VpfDValorVenda)
    else
      CalculaValorVendaUnitario(VpaDAmostra,VpfDValorVenda);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.ExcluiAmostra(VpaCodAmostra: Integer);
begin
  ExecutaComandoSql(Aux,'Delete from AMOSTRAPRECOCLIENTE '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRACOR '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRACONSUMO '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRALOG '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRACONSUMOLOG '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Sistema.GravaLogExclusao('AMOSTRA','Select * from AMOSTRA '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRA '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
end;

{******************************************************************************}
function TRBFuncoesAmostra.ExisteAmostraDefinidaDesenvolvida(VpaCodAmostra : integer):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select CODAMOSTRA FROM AMOSTRA '+
                            ' Where CODAMOSTRAINDEFINIDA = '+IntToStr(VpaCodAmostra));
  result := not Aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ExisteCodigoAmostra(VpaCodigo: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select CODAMOSTRA FROM AMOSTRA '+
                            ' Where CODAMOSTRA = '+IntToStr(VpaCodigo));
  result := not Aux.eof;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.ExportaFichaTecnicaAmostra(VpaDAmostra: TRBDAmostra);
var
  VpfNomArquivo, VpfNomAmostraArquivo, VpfTextoEmail, VpfNomPastaVendedor, VpfNomVendedor, VpfEmailVendedor : String;
begin
  VpfNomPastaVendedor := FunCotacao.RPastaFTPVendedor(VpaDAmostra.CodVendedor);
  VpfNomVendedor := FunCotacao.RNomVendedor(VpaDAmostra.CodVendedor);
  if VpfNomPastaVendedor = '' then
    aviso('PASTA FTP DO VENDEDOR NÃO CONFIGURADA!!!'#13'É necessário configurar a pasta FTP no cadastro do vendedor.');

  AdicionaSQLAbreTabela(Amostra,'Select * from AMOSTRACOR ' +
                               '  Where CODAMOSTRA = ' +IntToStr(VpaDAmostra.CodAmostra)+
                               '  ORDER BY CODCOR ' );
  while not amostra.eof do
  begin
    if ExisteLetraString('\',Amostra.FieldByName('DESIMAGEM').AsString) then
      VpfNomAmostraArquivo := DeleteAteChar(Amostra.FieldByName('DESIMAGEM').AsString,'\')
    else
      VpfNomAmostraArquivo := Amostra.FieldByName('DESIMAGEM').AsString;
    VpfNomAmostraArquivo :=CopiaAteChar(VpfNomAmostraArquivo,'.');
    VpfNomArquivo := Varia.PathFichaAmostra+'\'+VpfNomPastaVendedor+'\Ficha Técnica\'+FunClientes.RNomeFantasia(VpaDAmostra.CodProspect)+'\'+VpfNomAmostraArquivo+'.PDF';
    dtRave := TdtRave.Create(nil);
    dtRave.ImprimeFichaTecnicaAmostraCor(VpaDAmostra.CodAmostra,Amostra.FieldByName('CODCOR').AsInteger,false,VpfNomArquivo);
    if Varia.CNPJFilial = CNPJ_VENETO then
    begin
      VpfNomArquivo := varia.DriveFoto +'\PDF\'+VpfNomAmostraArquivo+'.PDF';
      dtRave.ImprimeFichaTecnicaAmostraCor(VpaDAmostra.CodAmostra,Amostra.FieldByName('CODCOR').AsInteger,false,VpfNomArquivo);
    end;

    dtRave.free;
    Amostra.Next;
  end;

  VpfEmailVendedor := FunCotacao.REmailVencedor(VpaDAmostra.CodVendedor);
  if VpfEmailVendedor <> '' then
  begin
    VpfTextoEmail := 'Prezado <b>'+VpfNomVendedor+'</b> <br><br>Segue anexo a <b>F</b>icha <b>T</b>ecnica de <b>A</b>mostra. <br><br><br>Atenciosamente<br><br>Departamento de Criação <br>'+varia.NomeFilial;

    Sistema.EnviaEmail(VpfEmailVendedor,Varia.NomeFilial+' - FTA - ' +IntToStr(VpaDAmostra.CodAmostra),
                       VpfTextoEmail,VpfNomArquivo);
  end;
end;

end.
