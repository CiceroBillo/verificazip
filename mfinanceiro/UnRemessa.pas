unit UnRemessa;

interface

Uses Classes, UnDados, SysUtils,ComCtrls, uncontasareceber,DB, Tabela,
     SQLExpr ;


Type TRBFuncoesRemessa = class
  private
    Aux,
    Tabela : TSQLQuery;
    Cadastro : TSQL;
    VprBarraStatus : TStatusBar;
    procedure AtualizaStatus(VpaTexto : String);
    function RNumConvenioCNAB240(VpaDRemessa : TRBDRemessaCorpo):string;
    function RNumContratoCNAB240(VpaDRemessa : TRBDRemessaCorpo):string;
    function RCodCarteiraCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpadItem :TRBDRemessaItem):string;
    function RDigVerificadorAgenciaCNAB240(VpaDRemessa : TRBDRemessaCorpo):String;
    function RNumContaCNAB240(VpaDRemessa : TRBDRemessaCorpo):String;
    function RDigVerificadorContaCNAB240(VpaDRemessa : TRBDRemessaCorpo):String;
    function RDigVerificadorAgenciaContaCNB240(VpaDRemessa : TRBDRemessaCorpo):String;
    function RDigVerificadorAgenciaContaSegmentoPCNB240(VpaDRemessa : TRBDRemessaCorpo):String;
    function RDataDescontoCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
    function RDataJurosCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
    function RCNPJCedenteCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
    function RDiasProtestoCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
    function RCampoMultaCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
    function RCampo1aInstrucao(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemessa : TRBDRemessaItem) :String;
    function RCampo2aInstrucao(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemessa : TRBDRemessaItem) :String;
    function RTipoSacadorAvalistaCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
    function GeraHeaderItau(VpaDRemessa : TRBDRemessaCorpo):String;
    function GeraHeaderBancoBrasil(VpaDRemessa : TRBDRemessaCorpo) : String;
    function GeraHeaderCNAB240(VpaDRemessa : TRBDRemessaCorpo) : String;
    function GeraHeaderCNAB400(VpaDRemessa : TRBDRemessaCorpo) : String;
    function GeraHeaderCNAB400BB(VpaDRemessa : TRBDRemessaCorpo) : String;
    function GeraHeaderLoteCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraTrailerLoteCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraDetalheItau(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraDetalheCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraDetalhePCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItem : TRBDRemessaItem;VpaArquivo : TStringList;VpaNumSequencial : Integer):String;
    function GeraDetalheQCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItem : TRBDRemessaItem;VpaArquivo : TStringList;VpaNumSequencial : Integer):String;
    function GeraDetalheRCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItem : TRBDRemessaItem;VpaArquivo : TStringList;VpaNumSequencial : Integer):String;
    function GeraDetalheCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraDetalheCNAB400BB(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraTrailerItau(VpaDRemessa : TRBDRemessaCorpo) : string;
    function GeraTrailerCNAB240(VpaDRemessa : TRBDRemessaCorpo) : string;
    function GeraTrailerCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList) : string;
    function GeraRemessaItau(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraRemessaCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraRemessaCNAB400BB(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    function GeraRemessaCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
    procedure CarDRemessaItem(VpaDRemessesa : TRBDRemessaCorpo);
    function SetaRemessaGerada(VpaDRemessa : TRBDRemessaCorpo):string;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    function GeraRemessa(VpaDRemessa : TRBDRemessaCorpo;VpaBarraStatus : TStatusBar):String;
    procedure BloqueiaRemessa(VpaCodFilial,VpaSeqRemessa : Integer);
    procedure CarDRemessa(VpaDRemessa : TRBDRemessaCorpo);

end;


implementation

Uses FunSql,FunString, Constantes, FunArquivos, FunValida, ConstMsg;

{******************************************************************************}
constructor TRBFuncoesRemessa.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesRemessa.destroy;
begin
  Aux.free;
  Tabela.Free;
  Cadastro.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesRemessa.AtualizaStatus(VpaTexto : String);
begin
  VprBarraStatus.Panels[0].Text := VpaTExto;
  VprBarraStatus.refresh;
end;

{******************************************************************************}
function TRBFuncoesRemessa.RNumConvenioCNAB240(VpaDRemessa : TRBDRemessaCorpo):string;
begin
  case VpaDRemessa.CodBanco of
     1 : result := AdicionaCharE('0',VpaDRemessa.NumConvenioBanco,9)+AdicionaCharD(' ',VpaDRemessa.CodProdutoBanco,11);
   104 : result := VpaDRemessa.NumConvenioBanco+AdicionaCharD(' ','',4) ;
   356 : result := AdicionaCharD(' ',VpaDRemessa.NumConvenioBanco,20);
   399 : result := 'COBCNAB'+AdicionaCharE('0',VpaDRemessa.NumConvenioBanco,13);
  else
    result := AdicionaCharD(' ','',20);
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.RNumContratoCNAB240(VpaDRemessa : TRBDRemessaCorpo):string;
begin
  if VpaDRemessa.CodBanco = 104 then // caixa economica
    result := AdicionaCharD(' ','',10)
  else
    result := AdicionaCharE('0',VpaDRemessa.NumContrato,10);
end;

{******************************************************************************}
function TRBFuncoesRemessa.RCodCarteiraCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpadItem :TRBDRemessaItem):string;
begin
  if VpaDRemessa.CodBanco = 1 then // banco do brasil
  begin
    if VpaDItem.IndDescontado then
      result := '2'
    else
      result := '7';
  end
  else
    if VpaDRemessa.CodBanco = 409 then // Unibanco
    begin
      if VpaDRemessa.IndEmiteBoleto then
        result := '2'
      else
        result := '1';
    end
    else
      if VpaDRemessa.CodBanco = 399 then // HSBC
        result := '1'
      else
        if VpaDRemessa.CodBanco = 104 then // Caixa
          result := '1'
        else
          if VpaDRemessa.CodBanco = 356 then // Caixa
            result := '0';
end;

{******************************************************************************}
function TRBFuncoesRemessa.RDigVerificadorAgenciaCNAB240(VpaDRemessa : TRBDRemessaCorpo):String;
begin
  result := '';
  if (VpaDRemessa.CodBanco = 104) or //caixa
     (VpaDRemessa.CodBanco = 356) or //banco real
     (VpaDRemessa.CodBanco = 399) then //hsbc
    result := '0'
  else
    result := AdicionaCharD(' ',copy(DeleteAteChar(VpaDRemessa.NumAgencia,'-'),1,1),1);
end;

{******************************************************************************}
function TRBFuncoesRemessa.RNumContaCNAB240(VpaDRemessa : TRBDRemessaCorpo):String;
begin
  if VpaDRemessa.CodBanco = 399 then //hsbc
    result := AdicionaCharE('0',DeletaChars(VpaDRemessa.NumConta,'-'),12)
  else
    result := AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumConta,'-'),12);
end;

{******************************************************************************}
function TRBFuncoesRemessa.RDigVerificadorContaCNAB240(VpaDRemessa : TRBDRemessaCorpo):String;
begin
  if VpaDRemessa.CodBanco = 399 then //hsbc
    result := '0'
  else
    result := AdicionaCharD(' ',copy(DeleteAteChar(VpaDRemessa.NumConta,'-'),1,1),1);
end;

{******************************************************************************}
function TRBFuncoesRemessa.RDigVerificadorAgenciaContaCNB240(VpaDRemessa : TRBDRemessaCorpo):String;
begin
  if (VpaDRemessa.CodBanco = 104)or //caixa
     (VpaDRemessa.CodBanco = 399) then //hsbc
    result := '0'
  else
    result := ' ';
end;

{******************************************************************************}
function TRBFuncoesRemessa.RDigVerificadorAgenciaContaSegmentoPCNB240(VpaDRemessa : TRBDRemessaCorpo):String;
begin
  if (VpaDRemessa.CodBanco = 399) then //hsbc
    result := '0'
  else
    if (VpaDRemessa.CodBanco = 104) then //caixa
      result := AdicionaCharD('0',VpaDRemessa.CodProdutoBanco,1)
    else
      result := ' ';
end;

{******************************************************************************}
function TRBFuncoesRemessa.RDataDescontoCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
begin
  if VpaDRemessa.CodBanco = 104 then
    result := FormatDateTime('DDMMYYYY',VpaDItemRemesa.DatVencimento)
  else
    result := '00000000';
end;

{******************************************************************************}
function TRBFuncoesRemessa.RDataJurosCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
begin
  if VpaDRemessa.CodBanco = 356 then
    result := FormatDateTime('DDMMYYYY',VpaDItemRemesa.DatVencimento)
  else
    result := '00000000';
end;

{******************************************************************************}
function TRBFuncoesRemessa.RCNPJCedenteCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
begin
  result := '';
  if VpaDRemessa.CodBanco = 356 then
  begin
    if VpaDItemRemesa.TipCliente = 'J' then
      result := AdicionaCharE('0',VpaDItemRemesa.CPFCNPJCliente,15)
    else
      result := copy(VpaDItemRemesa.CPFCNPJCliente,1,9)+'0000'+copy(VpaDItemRemesa.CPFCNPJCliente,10,2);
  end
  else
    result := AdicionaCharE('0',VpaDItemRemesa.CPFCNPJCliente,15);
end;

{******************************************************************************}
function TRBFuncoesRemessa.RDiasProtestoCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
begin
  if VpaDRemessa.CodBanco = 104  then // caixa
  begin
    if VpaDItemRemesa.DiasProtesto > 0 then
      result := '1'+ AdicionaCharE('0',IntToStr(VpaDItemRemesa.DiasProtesto),2)
    else
      result := '300';
  end
  else
  begin
    if VpaDItemRemesa.DiasProtesto > 0 then
      result := '2'+ AdicionaCharE('0',IntToStr(VpaDItemRemesa.DiasProtesto),2)
    else
      result := '300';
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.RCampo1aInstrucao(VpaDRemessa: TRBDRemessaCorpo;
  VpaDItemRemessa: TRBDRemessaItem): String;
begin
  result:= '00';
  if VpaDItemRemessa.ValMora > 0 then
    result := '01';
  if VpaDItemRemessa.DiasProtesto > 0 then
  begin
    if VpaDItemRemessa.DiasProtesto < 5 then
      aviso('QUANTIDADE DIAS PROTESTO INVÁLIDO!!!'#13'A quantidade de dias para protesto deve ser no mínimo de 5 dias.')
    else
      Result:= '06';
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.RCampo2aInstrucao(VpaDRemessa: TRBDRemessaCorpo;
  VpaDItemRemessa: TRBDRemessaItem): String;
begin
  Result:= IntToStr(VpaDItemRemessa.DiasProtesto);
end;

{******************************************************************************}
function TRBFuncoesRemessa.RCampoMultaCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
begin
  result := '0';
  if VpaDItemRemesa.PerMulta <> 0 then
    result := '2';
end;


{******************************************************************************}
function TRBFuncoesRemessa.RTipoSacadorAvalistaCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItemRemesa : TRBDRemessaItem):String;
begin
  if VpaDRemessa.CodBanco = 104  then // caixa
    result := '1'
  else
    result := '0';
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraHeaderItau(VpaDRemessa : TRBDRemessaCorpo):String;
begin
  AtualizaStatus('Gerando registro Header "'+VpaDRemessa.NomBanco+'"');
  //tipo do arquivo
  Result := '0'+
  //Operacao
  '1'+
  //literal de remessa
  'REMESSA'+
  //CODIGO DO SERVICO
  '01'+
  //LITERAL DE SERVICO
  AdicionaCharD(' ','COBRANCA',15)+
  //AGENCIA MANTEDORA
  AdicionaCharE('0',VpaDRemessa.NumAgencia,4)+
  //COMPLEMENTO DE REGISTRO
  '00'+
  //CONTA
  AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumConta,'-'),5)+
  //DAC CONTA
  copy(DeleteAteChar(VpaDRemessa.NumConta,'-'),1,1)+
  //BRANCOS
  AdicionaCharD(' ',' ',8)+
  //NOME DO CORRENTISTA
  AdicionaCharD(' ',copy(VpaDRemessa.NomCorrentista,1,30),30)+
  //CODIGO DO BANCO
  AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //NOME DO BANCO
  AdicionaCharD(' ',VpaDRemessa.NomBanco,15)+
  //DATA DE GERACAO
  FormatDateTime('DDMMYY',Date)+
  //brancos
  AdicionaCharD(' ',' ',250)+
  AdicionaCharD(' ',' ',40)+
  //NUMERO SEQUENCIAL
  'S110000001';
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraHeaderBancoBrasil(VpaDRemessa : TRBDRemessaCorpo) : String;
begin
  AtualizaStatus('Gerando registro Header "'+VpaDRemessa.NomBanco+'"');
  //tipo do arquivo
  Result := '0'+
  //Operacao
  '1'+
  //literal de remessa
  'REMESSA'+
  //CODIGO DO SERVICO
  '01'+
  //LITERAL DE SERVICO
  AdicionaCharD(' ','COBRANCA',15)+
  //AGENCIA MANTEDORA
  AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumAgencia,'-'),4)+
  //DV DA AGENCIA
  '0'+
  //CONTA
  AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumConta,'-'),8)+
  //DAC CONTA
  AdicionaCharD(' ',copy(DeleteAteChar(VpaDRemessa.NumConta,'-'),1,1),1)+
  //Numero do convenente lider
  AdicionaCharD('0','0',6)+
  //NOME DO CORRENTISTA
  AdicionaCharD(' ',copy(VpaDRemessa.NomCorrentista,1,30),30)+
  //CODIGO DO BANCO
  AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //NOME DO BANCO
  AdicionaCharD(' ',VpaDRemessa.NomBanco,15)+
  //DATA DE GERACAO
  FormatDateTime('DDMMYY',Date)+
  //brancos
  AdicionaCharE('0',InttoStr(VpaDRemessa.SeqRemessa),7)+
  AdicionaCharD(' ',' ',287)+
  //NUMERO SEQUENCIAL
  '000001';
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraHeaderCNAB240(VpaDRemessa : TRBDRemessaCorpo) : String;
Var
  VpfDItem : TRBDRemessaItem;
begin
  if VpaDRemessa.Itens.Count < 1 then
    exit;
  VpfDItem := TRBDRemessaItem(VpaDRemessa.Itens.Items[0]);

  AtualizaStatus('Gerando registro Header CNAB240 "'+VpaDRemessa.NomBanco+'"');
  //codigo do banco na compensacao
  Result :=AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //lote de servico
  '0000'+
  //registro header de arquivo
  '0'+
  //uso excluisvo frebaban
  AdicionaCharD(' ','',9)+
  //TIPO DE INSCRICAO DA EMPRESA 2 - CNPJ
  '2'+
  //CNPJ DA EMPRESA
    AdicionaCharE('0',VpfDItem.CNPJCedente,14)+
  //codigo do convenio do banco
   RNumConvenioCNAB240(VpaDRemessa) +
  //AGENCIA MANTEDORA
  AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumAgencia,'-'),5)+
  //DV DA AGENCIA pos 58-58
  RDigVerificadorAgenciaCNAB240(VpaDRemessa)+
  //CONTA pos 59-70
  RNumContaCNAB240(VpaDRemessa) +
  //DAC CONTA pos 71-71
  RDigVerificadorContaCNAB240(VpaDRemessa)+
  //DIGITO VERIFICADOR DA AGENCIA CONTA pos 72-72
   RDigVerificadorAgenciaContaCNB240(VpaDRemessa)+
  //NOME DO CORRENTISTA
  AdicionaCharD(' ',copy(VpaDRemessa.NomCorrentista,1,30),30)+
  //NOME DO BANCO
  AdicionaCharD(' ',VpaDRemessa.NomBanco,30)+
  //uso excluisvo frebaban
  AdicionaCharD(' ','',10)+
  //CODIGO REMESSA RETORNO 1- REMESSA / 2 -RETORNO
  '1'+
  //DATA DE GERACAO
  FormatDateTime('DDMMYYYY',Date)+
  //HORA DE GERACAO
  FormatDateTime('HHMMSS',now)+
  //N SEQUENCIAL DO ARQUIVO
  AdicionaCharE('0',InttoStr(VpaDRemessa.SeqRemessa),6)+
  //NUMERO DA VERSAO DO LAYOUT DO ARQUIVO
  '030'+
  //DENSIDADE DE GRAVACAO
  AdicionaCharD('0','0',5)+
  //PARA USO RESERVADO DO BANCO
  AdicionaCharD(' ','',20)+
  //PARA USO RESERVADO DA EMPRESA
  AdicionaCharD(' ','',20)+
  //uso excluisvo frebaban
  AdicionaCharD(' ','',11)+
  //IDENTIFICACAO COBRANCAO SEM PAPEL
  AdicionaCharD(' ','',3)+
  //USO EXCLUSIVO DAS VANS
  AdicionaCharD(' ','',3)+
  //TIPO DE SERVICO
  AdicionaCharD(' ','',2)+
  //USO EXCLUSIVO DAS VANS
  AdicionaCharD(' ','',10);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraHeaderCNAB400(VpaDRemessa : TRBDRemessaCorpo) : String;
begin
    AtualizaStatus('Gerando registro Header "'+VpaDRemessa.NomBanco+'"');
  //tipo do arquivo
  Result := '0'+
  //Operacao
  '1'+
  //literal de remessa
  'REMESSA'+
  //CODIGO DO SERVICO
  '01'+
  //LITERAL DE SERVICO
  AdicionaCharD(' ','COBRANCA',15)+
  //CODIGO DA EMPRESA
  AdicionaCharE('0',VpaDRemessa.NumContrato,20)+
  //NOME DO CORRENTISTA
  AdicionaCharD(' ',copy(VpaDRemessa.NomCorrentista,1,30),30)+
  //CODIGO DO BANCO
  AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //NOME DO BANCO
  AdicionaCharD(' ',copy(VpaDRemessa.NomBanco,1,15),15)+
  //DATA DE GERACAO
  FormatDateTime('DDMMYY',Date)+
 //brancos
  AdicionaCharD(' ',' ',8)+
  //Identificacao do sistema
  AdicionaCharD(' ','MX',2)+
  //Nro sequencial de remessa
  AdicionaCharE('0',IntToStr(VpaDRemessa.SeqRemessa),7)+
  //brancos
  AdicionaCharD(' ',' ',177)+
  //brancos
  AdicionaCharD(' ',' ',100)+
  //NUMERO SEQUENCIAL
  '000001';
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraHeaderCNAB400BB(VpaDRemessa: TRBDRemessaCorpo): String;
begin
    AtualizaStatus('Gerando registro Header "'+VpaDRemessa.NomBanco+'"');
  //tipo do arquivo
  Result := '0'+
  //Operacao
  '1'+
  //literal de remessa
  'REMESSA'+
  //CODIGO DO SERVICO
  '01'+
  //LITERAL DE SERVICO
  AdicionaCharD(' ','COBRANCA',15)+
  //PREFIXO DA AGENCIA  27-31
  AdicionaCharD(' ',DeletaChars(VpaDRemessa.NumAgencia,'-'),5)+
  //NUMERO DA CONTA CORRENTE 32-40
  AdicionaCharE('0',DeletaChars(VpaDRemessa.NumConta,'-'),9)+
  //NUMERO DA CONTA CORRENTE 41-46
  AdicionaCharE(' ','',6)+
  //NOME DO CORRENTISTA
  AdicionaCharD(' ',copy(VpaDRemessa.NomCorrentista,1,30),30)+
  //CODIGO DO BANCO
  AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //NOME DO BANCO
  AdicionaCharD(' ',copy(VpaDRemessa.NomBanco,1,15),15)+
  //DATA DE GERACAO
  FormatDateTime('DDMMYY',Date)+
   //brancos
  AdicionaCharE('0',IntToStr(VpaDRemessa.SeqRemessa),7)+' '+
  //Identificacao do sistema
  AdicionaCharD(' ','',9)+
  //brancos
  AdicionaCharD(' ',' ',177)+
  //brancos
  AdicionaCharD(' ',' ',100)+
  //NUMERO SEQUENCIAL
  '000001';

end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraHeaderLoteCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
Var
  VpfDItem : TRBDRemessaItem;
  VpfLinha : string;
begin
  if VpaDRemessa.Itens.Count < 1 then
    exit;
  VpfDItem := TRBDRemessaItem(VpaDRemessa.Itens.Items[0]);
    AtualizaStatus('Carregando Header do lote CNAB240 do cliente "'+VpfDItem.NomCliente+'"');
  //codigo do banco
  VpfLinha := AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //LOTE DE SERVICO
  '0001'+
  //REGISTRO DE HEADER
  '1'+
  //TIPO DE OPERACAO R- REMESSA
  'R'+
  //TIPO DE SERVICO
  '01' +
  //FORMA DE LANCAMENTOS
  '00'+
  //N DA VERSAO DO LAYOUT DO LOTE
  '020'+
  //USO EXCLUSIVO FREBRABAN
  ' '+
  //TIPO INSCRICAO
  '2'+
  //Numero de Inscricao
  AdicionaCharE('0',VpfDItem.CNPJCedente,15)+
  //CODIGO DO CONVENIO NO BANCO
//     9999999994444ccVVV
  RNumConvenioCNAB240(VpaDRemessa) +
//  '001205155001417019  ' +
  //AGENCIA MANTEDORA
  AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumAgencia,'-'),5)+
  //DV DA AGENCIA
  RDigVerificadorAgenciaCNAB240(VpaDRemessa) +
  //CONTA
  RNumContaCNAB240(VpaDRemessa)+
  //DAC
  RDigVerificadorContaCNAB240(VpaDRemessa)+
  //DIGITO VERIFICADOR DA AGENCIA CONTA
  RDigVerificadorAgenciaContaCNB240(VpaDRemessa)+
  //NOME DO CORRENTISTA
  AdicionaCharD(' ',copy(VpaDRemessa.NomCorrentista,1,30),30)+
  //mensagem 1 do lote - imprime em todos os boletos do lote.
  AdicionaCharD(' ','',40)+
  //mensagem 2 do lote - imprime em todos os boletos do lote.
  AdicionaCharD(' ','',40)+
  //NUMERO REMESSA / RETORNO
  AdicionaCharE('0',IntToStr(VpaDRemessa.SeqRemessa),8)+
  //DATA DE GRAVACAO REMESSA / RETORNO
  FormatDateTime('DDMMYYYY',Date)+
  //data do credito
  '00000000'+
  //uso exclusivo frebaban no arquivo da raftel tinha o valor "1205155        CBR10801"
  AdicionaCharD(' ','',33);
  VpaArquivo.Add(VpfLinha);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraTrailerLoteCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
var
  VpfLinha : String;
begin
  result := '';
  if VpaDRemessa.Itens.Count < 1 then
    exit;
   AtualizaStatus('Carregando Trailer do lote CNAB240');
  //codigo do banco
  VpfLinha := AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //LOTE DE SERVICO
  '0001'+
  //REGISTRO DE HEADER
  '5'+
  // uso exclusivo Febraban
  adicionaCharD(' ','',9)+
  //QTD DE REGISTROS
  AdicionaCharE('0',IntTostr((VpaDRemessa.Itens.Count*3) +2),6)+
  //zeros
  AdicionaCharE(' ','',217);
  VpaArquivo.Add(VpfLinha);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraDetalheItau(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
var
  VpfDItem : TRBDRemessaItem;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  result := '';
  for VpfLaco := 0 to VpaDRemessa.Itens.Count - 1 do
  begin
    VpfDItem := TRBDRemessaItem(VpaDRemessa.Itens[Vpflaco]);
    AtualizaStatus('Carregando titulo do cliente "'+VpfDItem.NomCliente+'"');
    //identificacao do registro
    VpfLinha := '1'+
    //TIPO INSCRICAO
    '02'+
    //Numero de Inscricao
    AdicionaCharE('0',VpfDItem.CNPJCedente,14)+
    //AGENCIA DA CONTA
    AdicionaCharE('0',VpaDRemessa.NumAgencia,4)+
    //ZEROS
    '00'+
    //CONTA
    AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumConta,'-'),5)+
    //DAC
    copy(DeleteAteChar(VpaDRemessa.NumConta,'-'),1,1)+
    //BRANCOS
    AdicionaCharD(' ','',4)+
    //INSTRUCAO/ALEGACAO
    AdicionaCharD(' ','',4)+
    //USO DA EMPRESA
    AdicionaCharD(' ','FL='+IntToStr(VpfDItem.CodFilial)+'|LR='+IntToStr(VpfDItem.LanReceber)+'|PC='+IntToStr(VpfDItem.NumParcela),25)+
    //nosso numero
    AdicionaCharD('0',VpfDItem.NumNossoNumero,8)+
    //QUANTIDADE MOEDA
    AdicionaCharD('0','0',13)+
    //Numero da carteira
    AdicionaCharE('0',IntToStr(VpaDRemessa.NumCarteira),3)+
    //uso do banco
    AdicionaCharD(' ','',21)+
    //codigo da carteira
    'I'+
    //IDENTIFICACAO DA OCORRENCIA
    AdicionaCharE('0',IntToStr(VpfDItem.CodMovimento),2)+
    //NUMERO DO DOCUMENTO
    AdicionaCharD(' ',VpfDItem.NumDuplicata,10)+
    //DATA DE VENCIMENTO
    FormatDateTime('DDMMYY',VpfDItem.DatVencimento)+
    //VALOR DO TITULO
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfDItem.ValReceber),','),13)+
    //CODIGO DO BANCO
    AdicionaCharE('0',IntToStr(VpaDRemessa.CodBanco),3)+
    //Agencia Cobradora
    AdicionaChard('0','',5)+
    //Especie do titulo
    '01'+
    //aceite
    'N'+
    //DATA DE EMISSAO
    FormatDateTime('DDMMYY',VpfDItem.DatEmissao)+
    //INSTRUCAO 1
    '73'+
    //INSTRUCAO 2
    '70'+
    //VALOR MORA
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfDItem.ValMora),','),13)+
    //DESCONTO ATÉ
    AdicionaCharD(' ','',6)+
    //VALOR DO DESCONTO
    AdicionaCharD('0','',13)+
    //VALOR DO IOF
    AdicionaCharD('0','',13)+
    //VALOR ABATIMENTO
    AdicionaCharD('0','',13);
    //identificacao da Incricao da Empresa
    if VpfDItem.TipCliente = 'J' then
      VpfLinha := VpfLinha +'02'
    else
      VpfLinha := VpfLinha +'01';
    //NUMERO DE INSCRICAO
    VpfLinha := VpfLinha + AdicionaCharE('0',VpfDItem.CPFCNPJCliente,14)+
    //NOME
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpfDItem.NomCliente,1,40))),40)+
    //logradouro
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpfDItem.EndCliente,1,40))),40)+
    //bairro
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpfDItem.BaiCliente,1,12))),12)+
    //cep
    AdicionaCharE('0',DeletaChars(VpfDItem.CEPCliente,'-'),8)+
    //cidade
    AdicionaCharD(' ',Copy(UpperCase(RetiraAcentuacao(VpfDItem.CidCliente)),1,15),15)+
    //estado
    AdicionaCharD(' ',UpperCase(VpfDItem.UFCliente),2)+
    //sacador avalista
    AdicionaCharD(' ',' ',30)+
    //brancos
    AdicionaCharD(' ','',4)+
    //data de mora
    FormatDateTime('DDMMYY',VpfDItem.DatVencimento)+
    //prazo
    '00'+
    //BRANCOS
    ' '+
    //NUMERO SEQUENCIAL
    AdicionaCharE('0',IntToStr(VpfLaco+2),6);
    VpaArquivo.Add(VpfLinha);
  end;
end;


{******************************************************************************}
function TRBFuncoesRemessa.GeraDetalheCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
var
  VpfDItem : TRBDRemessaItem;
  VpfLaco,VpfNumSequencial : Integer;
begin
  result := GeraHeaderLoteCNAB240(VpaDRemessa,VpaArquivo);
  VpfNumSequencial := 0;

  if result = '' then
  begin
    for VpfLaco := 0 to VpaDRemessa.Itens.Count - 1 do
    begin
      inc(vpfNumSequencial);
      VpfDItem := TRBDRemessaItem(VpaDRemessa.Itens[Vpflaco]);
      result := GeraDetalhePCNAB240(VpaDRemessa,VpfDItem,VpaArquivo,VpfNumSequencial);
      if result = '' then
      begin
        inc(VpfNumSequencial);
        result := GeraDetalheQCNAB240(VpaDRemessa,VpfDItem,VpaArquivo,VpfNumSequencial);
        if result = '' then
        begin
          inc(VpfNumSequencial);
          result := GeraDetalheRCNAB240(VpaDRemessa,VpfDItem,VpaArquivo,VpfNumSequencial);
        end;
      end;
    end;
  end;
  if result = '' then
    result := GeraTrailerLoteCNAB240(VpaDRemessa,VpaArquivo);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraDetalhePCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItem : TRBDRemessaItem;VpaArquivo : TStringList;VpaNumSequencial : Integer):String;
var
  VpfLinha : String;
begin
  AtualizaStatus('Carregando detalhe segmento P CNAB240 do cliente "'+VpaDItem.NomCliente+'"');
  //CODIGO DO BANCO POS 1-3
  VpfLinha := AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //LOTE DE SERVICO  POS 4-7
  '0001'+
  //REGISTRO DE HEADER POS 8-8
  '3'+
  //NUMERO SEQUENCIAL POS 9-13
  AdicionaCharE('0',IntToStr(VpaNumSequencial),5)+
  //codigo segmento do reg. detalhe = POS 14-14
  'P'+
  //uso exclusivo frebanban POS 15-15
  ' '+
  //codigo do movimento POS 16-17
  AdicionaCharE('0',IntToStr(VpaDItem.CodMovimento),2)+
  //AGENCIA MANTEDORA     POS 18-22
  AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumAgencia,'-'),5)+
  //DV DA AGENCIA POS 23-23
  RDigVerificadorAgenciaCNAB240(VpaDRemessa)+
  //CONTA         POS 24-35 E
  RNumContaCNAB240(VpaDRemessa)+
  //DAC CONTA
  RDigVerificadorContaCNAB240(VpaDRemessa)+
  //digito verificador ag. conta POS 36-37
  RDigVerificadorAgenciaContaSegmentoPCNB240(VpaDRemessa)+
  //IDENTIFICACAO DO TITULO NO BANCO - NOSSO NUMERO POS 38
  AdicionaCharD(' ',VpaDItem.NumNossoNumero,20)+
  //CODIGO CARTEIRA
  RCodCarteiraCNAB240(VpaDRemessa,VpaDItem)+
  //FORMA DE CADASTRO DO TITULO NO BANCO 1-COM CADASTRO
  '1'+
  //TIPO DE DOCUMENTO 1 - TRADICIONAL / 2 -ESCRITURAL
  '1';
  //IDENTIFICACAO DA EMISSAO DO BOLETO
  if VpaDRemessa.IndEmiteBoleto then
    VpfLinha := VpfLinha +'22'
  else
    VpfLinha := VpfLinha +'11';
  VpfLinha := VpfLinha +
  //numero do documento de cobranca
  AdicionaCharD(' ',VpaDItem.NumDuplicata,15)+
  //DATA DE VENCIMENTO
  FormatDateTime('DDMMYYYY',VpaDItem.DatVencimento)+
  //VALOR DO TITULO
  AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaDItem.ValReceber),','),15)+
  //agencia encarregada da cobranca
  AdicionaCharE('0','0',6)+
  //especie do titulo
  '02'+
  //identificacao de titulo aceite / nao aceite
  'N'+
  //DATA DE EMISSAO
  FormatDateTime('DDMMYYYY',VpaDItem.DatEmissao)+
  //CODIGO DE JUROS DE MORA 3- INSENTO
  '1'+
  //DATA DE JUROS DE MORA
  RDataJurosCNAB240(VpaDRemessa,VpaDItem) +
  //JUROS DE MORA POR DIA
  AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaDItem.ValMora),','),15)+
  //CODIGO DO DESCONTO
  '0'+
  //DATA DO DESCONTO
  RDataDescontoCNAB240(VpaDRemessa,VpaDItem) +
  //VALOR DO DESCONTO
  AdicionaCharE('0','0',15)+
  //VALOR DO IOF A SER RECOLHIDO
  AdicionaCharE('0','0',15)+
  //VALOR DO ABATIMENTO
  AdicionaCharE('0','0',15)+
  //USO DA EMPRESA
  AdicionaCharD(' ','FL='+IntToStr(VpaDItem.CodFilial)+'/LR='+IntToStr(VpaDItem.LanReceber)+'/PC='+IntToStr(VpaDItem.NumParcela),25)+
  //IDENTIFICACAO DO PROTESTO
  RDiasProtestoCNAB240(VpaDRemessa,VpaDItem);
   //CODIGO PARA BAIXA DEVOLUCAO
  VpfLinha := VpfLinha + '2'+
  //NUMEROS DE DIAS PARA A BAIXA DEVOLUCAO
  '000'+
  //CODIGO DA MOEDA
  '09'+
  //NUMERO DE CONTRATO DE CREDITO
  RNumContratoCNAB240(VpaDRemessa)+
  //USO EXCLUISO FEBRABAN
  ' ';
  VpaArquivo.Add(VpfLinha);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraDetalheQCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItem : TRBDRemessaItem;VpaArquivo : TStringList;VpaNumSequencial : Integer):String;
var
  VpfLinha : String;
begin
  AtualizaStatus('Carregando detalhe segmento Q CNAB240 do cliente "'+VpaDItem.NomCliente+'"');
  VpfLinha := AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //LOTE DE SERVICO
  '0001'+
  //REGISTRO DE HEADER
  '3'+
  //NUMERO SEQUENCIAL
  AdicionaCharE('0',IntToStr(VpaNumSequencial),5)+
  //codigo segmento do reg. detalhe =
  'Q'+
  //uso exclusivo frebanban
  ' '+
  //codigo do movimento
  '01';
  //identificacao da Incricao da Empresa
  if VpaDItem.TipCliente = 'J' then
    VpfLinha := VpfLinha +'2'
  else
    VpfLinha := VpfLinha +'1';
  //NUMERO DE INSCRICAO
  VpfLinha := VpfLinha + RCNPJCedenteCNAB240(VpaDRemessa,VpaDItem) +
  //NOME
  AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpaDItem.NomCliente,1,40))),40)+
  //logradouro
  AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpaDItem.EndCliente,1,37))),40)+
  //bairro
  AdicionaCharD(' ',RetiraAcentuacao(copy(VpaDItem.BaiCliente,1,15)),15)+
  //cep
  AdicionaCharE('0',DeletaChars(VpaDItem.CEPCliente,'-'),8)+
  //cidade
  AdicionaCharD(' ',Copy(UpperCase(RetiraAcentuacao(VpaDItem.CidCliente)),1,15),15)+
  //estado
  AdicionaCharD(' ',UpperCase(VpaDItem.UFCliente),2)+
  //tipo sacador / avalista
  RTipoSacadorAvalistaCNAB240(VpaDRemessa,VpaDItem)+
  //inscricao sacador / avalista
  AdicionaCharD('0','',15)+
  //NOME SACADOR AVALISTA
  AdicionaCharD(' ','',40)+
  //COD BANCO COMPESACAO CORRESPONDENTE
  AdicionaCharD(' ','',23)+
  //USO EXCLUSIVO FEBRABAN
  AdicionaCharD(' ','',8);
  VpaArquivo.Add(VpfLinha);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraDetalheRCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaDItem : TRBDRemessaItem;VpaArquivo : TStringList;VpaNumSequencial : Integer):String;
var
  VpfLinha : String;
begin
  AtualizaStatus('Carregando detalhe segmento R CNAB240 do cliente "'+VpaDItem.NomCliente+'"');
  VpfLinha := AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //LOTE DE SERVICO
  '0001'+
  //REGISTRO DE HEADER
  '3'+
  //NUMERO SEQUENCIAL
  AdicionaCharE('0',IntToStr(VpaNumSequencial),5)+
  //codigo segmento do reg. detalhe =
  'R'+
  //uso exclusivo frebanban
  ' '+
  //codigo do movimento
  '01'+
  //ZEROS
  AdicionaCharD('0','',72)+
  //MENSAGEM 3
  AdicionaCharD(' ','',40)+
  //MENSAGEM 4
  AdicionaCharD(' ','',50)+
  //ZEROS
  AdicionaCharD('0','',28)+
  //ZEROS
  AdicionaCharD(' ','',33);
  VpaArquivo.Add(VpfLinha);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraDetalheCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
var
  VpfLinha : String;
  VpfLaco : Integer;
  VpfDItem : TRBDRemessaItem;
begin
  for VpfLaco := 0 to VpaDRemessa.Itens.Count - 1 do
  begin
    VpfDItem := TRBDRemessaItem(VpaDRemessa.Itens[VpfLaco]);
    AtualizaStatus('Carregando detalhe segmento R CNAB240 do cliente "'+VpfDItem.NomCliente+'"');
    VpfLinha :=
    //IDENTIFICACAO DO REGISTRO POS 1-1
    '1'+
    //AGENCIA DE DEBITO POS 2-6
    '00000'+
    //DIGITO DA AGENCIA DE DEBITO POS 7-7
    ' '+
    //RAZAO DA CONTA CORRENTE POS 8-12
    '00000'+
    //CONTA CORRENTE POS 13-19
    '0000000'+
    //DIGITO DA CONTA CORRENTE POS 20-20
    ' '+
    //IDENTIFICACAO DA EMPRESA CEDENTE NO BANCO POS 21-21
    '0'+
    //IDENTIFICACAO DA EMPRESA CEDENTE NO BANCO CODIGO DA CARTEIRA POS 22-24
    AdicionaCharE('0',InttoStr(VpaDRemessa.NumCarteira),3)+
    //IDENTIFICACAO DA EMPRESA CEDENTE NO BANCO CODIGO DA AGENCIA POS 25-29
    AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumAgencia,'-'),5)+
    //IDENTIFICACAO DA EMPRESA CEDENTE NO BANCO CODIGO DA CONTA CORRENTE POS 30-36
    AdicionaCharE('0',CopiaAteChar(VpaDRemessa.NumConta,'-'),7)+
    //IDENTIFICACAO DA EMPRESA CEDENTE NO BANCO CODIGO DA CONTA CORRENTE POS 37-37
    AdicionaCharE('0',DeleteAteChar(VpaDRemessa.NumConta,'-'),1)+
    //N.o CONTROLE DO PARTICIPANTE POS 38-62
    AdicionaCharD(' ','FL='+IntToStr(VpfDItem.CodFilial)+'/LR='+IntToStr(VpfDItem.LanReceber)+'/PC='+IntToStr(VpfDItem.NumParcela),25)+
    //CODIGO DO BANCO A SER DEBITADO NA CAMARA    POS 63-65
    AdicionaCharE('0','000',3)+
    //CODIGO DO BANCO A SER DEBITADO NA CAMARA    POS 66-66
    AdicionaCharD(' ',RCampoMultaCNAB400(VpaDRemessa,VpfDItem),1)+
    //CODIGO DO BANCO A SER DEBITADO NA CAMARA    POS 67-70
    AdicionaCharE('0',DeletaChars(FormatFloat('00.00',VpfDItem.PerMulta),','),4)+
    //IDENTIFICACAO DO TITULO NO BANCO POS 71-82
    AdicionaCharD(' ',VpfDItem.NumNossoNumero,12)+
    //DESCONTO BONIFICACAO POR DIA POS 83-92
    AdicionaCharE('0','0',10) +
    //CONDICAO PARA EMISSAO DO BOLETO POS 93-93
    AdicionaCharE('0','2',1) +
    //IDENTIFICACAO SE EMITE DBITO AUTOMATICO POS 94-94
    AdicionaCharE('0','N',1) +
    //IDENTIFICACAO IDENTIFICACAO DA OPERACAO DO BANCO POS 95-104
    AdicionaCharD(' ',' ',10) +
    //IDENTIFICADOR RATEIO DE CREDITO POS 105-105
    AdicionaCharD(' ',' ',1) +
    //ENDERECAMENTO PARA AVISO DE DEBITO POS 106-106
    AdicionaCharD(' ','2',1) +
    //BRANCO POS 107-108
    AdicionaCharD(' ','',2) +
    //IDENTIFICACAO DA OPERACAO POS 109-110
    AdicionaCharE('0',IntToStr(VpfDItem.CodMovimento),2) +
    //numero do documento de cobranca POS 111-120
    AdicionaCharD(' ',VpfDItem.NumDuplicata,10)+
    //DATA DE VENCIMENTO POS 121 A 126
    FormatDateTime('DDMMYY',VpfDItem.DatVencimento)+
    //VALOR DO TITULO POS 127 A 1139
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfDItem.ValReceber),','),13)+
    //BANCO DA ENCARREGADO DA COBRANCA POS 140-142
    AdicionaCharD('0','000',3) +
    //BANCO DA ENCARREGADO DA COBRANCA POS 143-147
    AdicionaCharD('0','000',5) +
    //ESPECIE DO TITULO POS 148-149
    AdicionaCharD('0','01',2) +
    //IDENTIFICACAO ACEITE/NAO ACEITE POS 150-150
    AdicionaCharD(' ','N',1) +
    //DATA EMISSAO POS 151-156
    FormatDateTime('DDMMYY',VpfDItem.DatEmissao)+
    //1.a INSTRUCAO POS 157-158
    AdicionaCharD('0',RCampo1aInstrucao(VpaDRemessa,VpfDItem),2) +
    //2.a INSTRUCAO POS 159-160
    AdicionaCharD('0','0',2) +
    //VALOR A SER COBRADO POR DIA DE ATRASO POS 161-173
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfDItem.ValMora),','),13)+
    //DATA LIMITE PARA CONCESSAO DE DESCONTO POS 174-179
    AdicionaCharD('0','0',6) +
    //VALOR DO DESCONTO POS 180-192
    AdicionaCharD('0','0',13) +
    //VALOR DO IOF POS 193-205
    AdicionaCharD('0','0',13) +
    //VALOR DO ABATIMENTO A SER CONCEDIDO POS 206-218
    AdicionaCharD('0','0',13);
    //TIPO E INSCRICAO DO SACADO POS 219-220
    if VpfDItem.TipCliente = 'J' then
      VpfLinha := VpfLinha +'02'
    else
      VpfLinha := VpfLinha +'01';
    //NRO INSCRICAO DO SACADO POS 221-234
    VpfLinha := VpfLinha +
    AdicionaCharE('0',VpfDItem.CPFCNPJCliente,14)+
    //NOME DO SACADO POS 235-274
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpfDItem.NomCliente,1,40))),40)+
    //ENDERECO POS 275-314
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpfDItem.EndCliente,1,37))),40)+
    //1.a MENSAGEM POS 315-326
    AdicionaCharD(' ','',12)+
    //CEP POS 327-334
    AdicionaCharE('0',DeletaChars(VpfDItem.CEPCliente,'-'),8)+
    //2.a MENSAGEM POS 335-395
    AdicionaCharD(' ','',60)+
    //N.o SEQUENCIAL DO REGISTRO
    AdicionaCharE('0',IntToStr(VpfLaco+2),6);
    VpaArquivo.add(VpfLinha);
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraDetalheCNAB400BB(VpaDRemessa: TRBDRemessaCorpo;VpaArquivo: TStringList): String;
var
  VpfLinha : String;
  VpfLaco : Integer;
  VpfDItem : TRBDRemessaItem;
begin
  for VpfLaco := 0 to VpaDRemessa.Itens.Count - 1 do
  begin
    VpfDItem := TRBDRemessaItem(VpaDRemessa.Itens[VpfLaco]);
    AtualizaStatus('Carregando detalhe segmento R CNAB240 do cliente "'+VpfDItem.NomCliente+'"');
    VpfLinha :=
    //IDENTIFICACAO DO REGISTRO POS 1-1
    '1'+
    //TIPO INSCRICAO EMPRESA 2-3
    '02'+
    //NUMERO CNPJ EMPRESA 4-17
    VpfDItem.CNPJCedente+
    //CODIGO DA AGENCIA 18-22
    AdicionaCharE('0',DeletaChars(VpaDRemessa.NumAgencia,'-'),5)+
    //NUMERO DA CONTA  23-31
    AdicionaCharE('0',DeletaChars(VpaDRemessa.NumConta,'-'),9)+
    //NUMERO DO CONVENIO 32-38
    AdicionaCharE(' ',DeletaChars(VpaDRemessa.NumConvenioBanco,'-'),7)+
    //NUMERO DO CONTROLE DO PARTICIPANTE 39-63
    AdicionaCharD(' ','FL='+IntToStr(VpfDItem.CodFilial)+'/LR='+IntToStr(VpfDItem.LanReceber)+'/PC='+IntToStr(VpfDItem.NumParcela),25)+
    //IDENTIFICACAO DO TITULO NO BANCO POS 64-80
    AdicionaCharD(' ',VpfDItem.NumNossoNumero,17)+
    //NUMERO DA PRESTACAO POS 83-84
    AdicionaCharD(' ','',2)+
    //NUMERO DA PRESTACAO POS 83-84
    AdicionaCharD(' ','SD',2)+
    //COMPLEMENTO DE RESGISTRO "BRANCOS" 85-87
    AdicionaCharD(' ',' 01',3)+
    //INDICATIVO DE MENSAGEM OU SACADOR AVALISTA 88-88
    '9'+
    //PREFIXO DE TITULOS "BRANCOS" 89-91
    AdicionaCharD('0','0',3)+
    //IDENTIFICACAO DA EMPRESA CEDENTE NO BANCO CODIGO DA CARTEIRA POS 92-94
    AdicionaCharE('0',InttoStr(VpaDRemessa.NumCarteira),3)+
    //CONTA CAUCAO 95-95
    '0'+
    //NUMERO DE BORDEROS 96-101
    '000000'+
    //TIPO COBRANCA 102-106
    '     '+
    //IDENTIFICACAO DA EMPRESA CEDENTE NO BANCO CODIGO DA CARTEIRA POS 107-108
    AdicionaCharE('0',InttoStr(VpaDRemessa.NumCarteira),2)+

    //IDENTIFICACAO DA OPERACAO POS 109-110
    AdicionaCharE('0',IntToStr(VpfDItem.CodMovimento),2) +
    //numero do documento de cobranca POS 111-120
    AdicionaCharD(' ',VpfDItem.NumDuplicata,10)+
    //DATA DE VENCIMENTO POS 121 A 126
    FormatDateTime('DDMMYY',VpfDItem.DatVencimento)+
    //VALOR DO TITULO POS 127 A 1139
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfDItem.ValReceber),','),13)+
    //BANCO DA ENCARREGADO DA COBRANCA POS 140-142
    AdicionaCharD('0',IntTosTr(VpaDRemessa.CodBanco),3) +
    //BANCO DA ENCARREGADO DA COBRANCA POS 143-147
    AdicionaCharD('0','000',5) +
    //ESPECIE DO TITULO POS 148-149
    AdicionaCharD('0','01',2) +
    //IDENTIFICACAO ACEITE/NAO ACEITE POS 150-150
    AdicionaCharD(' ','N',1) +
    //DATA EMISSAO POS 151-156
    FormatDateTime('DDMMYY',VpfDItem.DatEmissao)+
    //1.a INSTRUCAO POS 157-158
    AdicionaCharD('0',RCampo1aInstrucao(VpaDRemessa,VpfDItem),2) +
    //2.a INSTRUCAO POS 159-160
    AdicionaCharD('0','0',2) +
    //VALOR A SER COBRADO POR DIA DE ATRASO POS 161-173
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfDItem.ValMora),','),13)+
    //DATA LIMITE PARA CONCESSAO DE DESCONTO POS 174-179
    AdicionaCharD('0','0',6) +
    //VALOR DO DESCONTO POS 180-192
    AdicionaCharD('0','0',13) +
    //VALOR DO IOF POS 193-205
    AdicionaCharD('0','0',13) +
    //VALOR DO ABATIMENTO A SER CONCEDIDO POS 206-218
    AdicionaCharD('0','0',13);
    //TIPO E INSCRICAO DO SACADO POS 219-220
    if VpfDItem.TipCliente = 'J' then
      VpfLinha := VpfLinha +'02'
    else
      VpfLinha := VpfLinha +'01';
    //NRO INSCRICAO DO SACADO POS 221-234
    VpfLinha := VpfLinha +
    AdicionaCharE('0',VpfDItem.CPFCNPJCliente,14)+
    //NOME DO SACADO POS 235-274
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpfDItem.NomCliente,1,40))),40)+
    //ENDERECO POS 275-326
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(copy(VpfDItem.EndCliente,1,37))),37)+
    //1.a MENSAGEM POS 312-326
    AdicionaCharD(' ', AdicionaCharE('0',copy(VpfDItem.DesFoneCliente,1,11),11),15)+
    //CEP POS 327-334
    AdicionaCharE('0',DeletaChars(VpfDItem.CEPCliente,'-'),8)+
    // CIDADE DO SACADO 335-349
    AdicionaCharD(' ',COPY(VpfDItem.CidCliente,1,15),15)+
    // CIDADE DO SACADO 350-351
    AdicionaCharD(' ',COPY(VpfDItem.UFCliente,1,2),2)+
    //
    AdicionaCharD(' ','',43)+
    //N.o SEQUENCIAL DO REGISTRO
    AdicionaCharE('0',IntToStr(VpfLaco+2),6);
    VpaArquivo.add(VpfLinha);
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraTrailerItau(VpaDRemessa : TRBDRemessaCorpo) : string;
begin
  result := '9'+
  AdicionaCharD(' ','',200)+
  AdicionaCharD(' ','',193)+
  AdicionaCharE('0',IntToStr(VpaDRemessa.Itens.Count +2),6);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraTrailerCNAB240(VpaDRemessa : TRBDRemessaCorpo) : string;
begin
  AtualizaStatus('Carregando trailer do arquivo CNAB240');
  result := AdicionaCharE('0',InttoStr(VpaDRemessa.CodBanco),3)+
  //LOTE DE SERVICO
  '9999'+
  //REGISTRO TRAILER DE ARQUIVO
  '9'+
  //USO EXCLUSIVO FEBRABAN
  AdicionaCharD(' ','',9)+
  //QUANTIDADE DE LOTES DO ARQUIVO
  AdicionaCharE('0','1',6)+
  //QUANTIDADE DE REGISTROS DO ARQUIVO
  adicionaCharE('0',InttoStr((VpaDRemessa.Itens.Count *3)+4),6)+
  //quantidade de contas para consolidadcao
  AdicionaCharE('0','0',6) +
  //brancos
  AdicionaCharD(' ','',205);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraTrailerCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList) : string;
begin
  result := //identificacao do registro
  '9'+
  //brancos
  AdicionaCharD(' ','',193)+
  AdicionaCharD(' ','',200)+
  //Numero sequencial de registro pos 395-400
  AdicionaCharE('0',IntToStr(VpaArquivo.Count+1),6);
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraRemessaCNAB240(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
begin
  if (Varia.CNPJFilial= CNPJ_INFORWAP) or
     (Varia.CNPJFilial= CNPJ_INFORMANET) then
    GeraRemessaCNAB400BB(VpaDRemessa,VpaArquivo)
  else
  begin
    VpaDRemessa.TipRemessa := trCNAB240;
    result := '';
    VpaArquivo.clear;
    VpaArquivo.add(GeraHeaderCNAB240(VpaDRemessa));
    result := GeraDetalheCNAB240(VpaDRemessa,VpaArquivo);
    VpaArquivo.Add(GeraTrailerCNAB240(VpaDRemessa));
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraRemessaCNAB400(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
begin
  VpaDRemessa.TipRemessa := trCNAB400;
  result := '';
  VpaArquivo.clear;
  VpaArquivo.add(GeraHeaderCNAB400(VpaDRemessa));
  result := GeraDetalheCNAB400(VpaDRemessa,VpaArquivo);
  VpaArquivo.Add(GeraTrailerCNAB400(VpaDRemessa,VpaArquivo));
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraRemessaCNAB400BB(VpaDRemessa: TRBDRemessaCorpo;VpaArquivo: TStringList): String;
begin
  VpaDRemessa.TipRemessa := trCNAB400BB;
  result := '';
  VpaArquivo.clear;
  VpaArquivo.add(GeraHeaderCNAB400BB(VpaDRemessa));
  result := GeraDetalheCNAB400BB(VpaDRemessa,VpaArquivo);
  VpaArquivo.Add(GeraTrailerCNAB400(VpaDRemessa,VpaArquivo));
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraRemessaItau(VpaDRemessa : TRBDRemessaCorpo;VpaArquivo : TStringList):String;
begin
  result := '';
  VpaArquivo.clear;
  VpaArquivo.add(GeraHeaderItau(VpaDRemessa));
  result := GeraDetalheItau(VpaDRemessa,VpaArquivo);
  VpaArquivo.Add(GeraTrailerItau(VpaDRemessa));
end;

{******************************************************************************}
procedure TRBFuncoesRemessa.CarDRemessaItem(VpaDRemessesa : TRBDRemessaCorpo);
var
  VpfDItem : TRBDRemessaItem;
begin
  AdicionaSQLAbreTabela(Tabela,'select ITE.CODMOVIMENTO, FIL.C_CGC_FIL,'+
                               ' MCR.C_NRO_DUP, MCR.I_EMP_FIL, MCR.I_LAN_REC, MCR.I_NRO_PAR, MCR.N_PER_MUL, MCR.N_PER_MOR, MCR.N_VLR_PAR, '+
                               ' MCR.C_DUP_DES, MCR.C_NOS_NUM,'+
                               ' CR.D_DAT_EMI, MCR.D_DAT_VEN, '+
                               ' CLI.C_TIP_PES, CLI.C_CGC_CLI, CLI.C_CPF_CLI, CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_COM_END, CLI.C_BAI_CLI,'+
                               ' CLI.C_CID_CLI, CLI.C_CEP_CLI, CLI.C_EST_CLI, CLI.I_DIA_PRO, CLI.C_IND_PRO, CLI.C_END_COB, CLI.I_NUM_COB, CLI.C_BAI_COB, '+
                               ' CLI.C_CID_COB, CLI.C_CEP_COB, CLI.C_EST_COB, CLI.C_FO1_CLI '+
                               ' from  CADFILIAIS FIL, MOVCONTASARECEBER MCR, CADCONTASARECEBER CR, REMESSAITEM ITE, CADCLIENTES CLI '+
                               ' Where CR.I_EMP_FIL = MCR.I_EMP_FIL '+
                               ' and CR.I_LAN_REC = MCR.I_LAN_REC '+
                               ' and CR.I_COD_CLI = CLI.I_COD_CLI '+
                               ' and FIL.I_EMP_FIL = CR.I_EMP_FIL '+
                               ' and ITE.CODFILIAL = MCR.I_EMP_FIL '+
                               ' and ITE.LANRECEBER = MCR.I_LAN_REC '+
                               ' and ITE.NUMPARCELA = MCR.I_NRO_PAR '+
                               ' and ITE.CODFILIAL = '+IntToStr(VpaDRemessesa.CodFilial)+
                               ' and ITE.SEQREMESSA = '+IntToStr(VpaDRemessesa.SeqRemessa)+
                               ' order by CLI.C_NOM_CLI, MCR.D_DAT_VEN');
  While not tabela.Eof do
  begin
    VpfDItem := VpaDRemessesa.addIten;
    VpfDItem.CodMovimento := Tabela.FieldByName('CODMOVIMENTO').AsInteger;
    VpfDItem.NumNossoNumero := Tabela.FieldByName('C_NOS_NUM').AsString;
    if VpaDRemessesa.CodBanco = 104 then // caixa
      if VpfDItem.NumNossoNumero <> '' then
        VpfDItem.NumNossoNumero := AdicionaCharD(' ','',9)+VpfDItem.NumNossoNumero + Modulo11(VpfDItem.NumNossoNumero);
    VpfDItem.CNPJCedente := DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_FIL').AsString,'.'),'/'),'-');
    VpfDItem.NumDuplicata := Tabela.FieldByName('C_NRO_DUP').AsString;
    VpfDItem.TipCliente := Tabela.FieldByName('C_TIP_PES').AsString;
    if VpfDItem.TipCliente = 'J' then
      VpfDItem.CPFCNPJCliente := DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_CLI').AsString,'.'),'/'),'-')
    else
      VpfDItem.CPFCNPJCliente := DeletaChars(DeletaChars(Tabela.FieldByName('C_CPF_CLI').AsString,'.'),'-');
    VpfDItem.NomCliente := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_NOM_CLI').AsString));
    VpfDItem.DesFoneCliente := DeletaChars(DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_FO1_CLI').AsString,'('),')'),'-'),' ');
    if (Tabela.FieldByName('C_IND_PRO').AsString = 'N') or (varia.QtdDiasProtesto = 0 ) then
      VpfDItem.DiasProtesto := 0
    else
      if Tabela.FieldByName('I_DIA_PRO').AsInteger <>0 THEN
        VpfDItem.DiasProtesto := Tabela.FieldByName('I_DIA_PRO').AsInteger
      else
        VpfDItem.DiasProtesto := varia.QtdDiasProtesto;
    if Tabela.FieldByName('C_END_COB').AsString <> '' then
    begin
      VpfDItem.EndCliente := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_END_COB').AsString));
      if Tabela.FieldByName('I_NUM_COB').AsInteger <> 0 then
        VpfDItem.EndCliente := VpfDItem.EndCliente+','+ Tabela.FieldByName('I_NUM_COB').AsString;
      if VpaDRemessesa.CodBanco = 1 then //banco do brasil nao trata o campo bairro tem que adicionar atras do endereco
      begin
        VpfDItem.EndCliente := VpfDItem.EndCliente+'-'+ UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_BAI_COB').AsString));
        VpfDItem.BaiCliente := '';
      end
      else
        VpfDItem.BaiCliente := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_BAI_COB').AsString));
      VpfDItem.CidCliente := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_CID_COB').AsString));
      VpfDItem.CEPCliente := Tabela.FieldByName('C_CEP_COB').AsString;
      VpfDItem.UFCliente := Tabela.FieldByName('C_EST_COB').AsString;
    end
    else
    begin
      VpfDItem.EndCliente := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_END_CLI').AsString));
      if Tabela.FieldByName('I_NUM_END').AsInteger <> 0 then
        VpfDItem.EndCliente := VpfDItem.EndCliente+','+ Tabela.FieldByName('I_NUM_END').AsString;
      if Tabela.FieldByName('C_COM_END').AsString <> '' then
        VpfDItem.EndCliente := VpfDItem.EndCliente+'-'+ UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_COM_END').AsString));
      if VpaDRemessesa.CodBanco = 1 then //banco do brasil nao trata o campo bairro tem que adicionar atras do endereco
      begin
        VpfDItem.EndCliente := VpfDItem.EndCliente+'-'+ UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_BAI_CLI').AsString));
        VpfDItem.BaiCliente := '';
      end
      else
        VpfDItem.BaiCliente := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_BAI_CLI').AsString));
      VpfDItem.CidCliente := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_CID_CLI').AsString));
      VpfDItem.CEPCliente := Tabela.FieldByName('C_CEP_CLI').AsString;
      VpfDItem.UFCliente := Tabela.FieldByName('C_EST_CLI').AsString;
    end;
    VpfDItem.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDItem.LanReceber := Tabela.FieldByName('I_LAN_REC').AsInteger;
    VpfDItem.NumParcela := Tabela.FieldByName('I_NRO_PAR').AsInteger;
    if VpaDRemessesa.CodBanco = 341 then //itau
      VpfDItem.ValMora :=  (Tabela.FieldByName('N_VLR_PAR').AsFloat * 0.1657536170810)/100
    else
      VpfDItem.ValMora :=  ((Tabela.FieldByName('N_VLR_PAR').AsFloat * Varia.Mora )/100)/30;
    VpfDItem.ValReceber := Tabela.FieldByName('N_VLR_PAR').AsFloat;
    VpfDItem.PerMulta := Tabela.FieldByName('N_PER_MUL').AsFloat;
    VpfDItem.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDItem.DatVencimento := Tabela.FieldByName('D_DAT_VEN').AsDateTime;
    VpfDItem.IndDescontado := Tabela.FieldByName('D_DAT_VEN').AsString = 'S';
    Tabela.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.SetaRemessaGerada(VpaDRemessa : TRBDRemessaCorpo):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from REMESSACORPO '+
                                 ' Where CODFILIAL = '+ IntToStr(VpaDRemessa.CodFilial)+
                                 ' and SEQREMESSA = '+IntToStr(VpaDRemessa.SeqRemessa));
  Cadastro.Edit;
  Cadastro.FieldByName('DATENVIO').AsDateTime := now;
  Cadastro.FieldByName('DATBLOQUEIO').AsDateTime := now;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO ARQUIVO DE REMESSA!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TRBFuncoesRemessa.GeraRemessa(VpaDRemessa : TRBDRemessaCorpo;VpaBarraStatus : TStatusBar):String;
var
  VpfArquivo : TStringList;
  VpfNomArquivo : String;
begin
  result := '';
  if UpperCase(varia.PathRemessaBancaria) = Uppercase(Varia.PathInSig) then
    result := 'DIRETORIO REMESSA INVÁLIDO!!!'#13'O diretório que será gerado o arquivo remessa é igual o diretorio dos aplicativos.';

  if result = '' then
  begin
    VpfArquivo := TStringList.Create;
    VprBarraStatus := VpaBarraStatus;
    case VpaDRemessa.CodBanco of
      001,104,356,399,409
          : begin
              result := GeraRemessaCNAB240(VpaDRemessa,VpfArquivo);
              VpfNomArquivo := Varia.PathRemessaBancaria+'\'+FormatDateTime('DDMMYYSS',now)+'.txt';
            end;
      237 : begin
              result := GeraRemessaCNAB400(VpaDRemessa,VpfArquivo);
              VpfNomArquivo := Varia.PathRemessaBancaria+'\CB'+FormatDateTime('DDMMSS',now)+'.txt';
            end;
      341 : begin
              result := GeraRemessaItau(VpaDRemessa,VpfArquivo);
              VpfNomArquivo := Varia.PathRemessaBancaria+'\CBR641.'+copy(IntToStr(VpaDRemessa.SeqRemessa),length(IntToStr(VpaDRemessa.SeqRemessa))-2,3);
            end;
    end;

    DeletaArquivoDiretorio(varia.PathRemessaBancaria,true);
    NaoExisteCriaDiretorio(varia.PathRemessaBancaria,false);
    VpfArquivo.SaveToFile(VpfNomArquivo);
    VpfArquivo.free;
    if result = '' then
    begin
      AtualizaStatus('Arquivo "'+VpfNomArquivo+'" do banco '+VpaDRemessa.NomBanco+' gerado com sucesso.');
      result := SetaRemessaGerada(VpaDRemessa);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesRemessa.BloqueiaRemessa(VpaCodFilial,VpaSeqRemessa : Integer);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from REMESSACORPO '+
                                 ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                 ' and SEQREMESSA = '+InttoStr(VpaSeqRemessa));
  Cadastro.Edit;
  Cadastro.FieldByName('DATBLOQUEIO').AsDateTime := now;
  Cadastro.Post;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesRemessa.CarDRemessa(VpaDRemessa : TRBDRemessaCorpo);
begin
  AdicionaSQLAbreTabela(Tabela,'Select REM.CODUSUARIO, REM.NUMCONTA, REM.DATINICIO, REM.DATENVIO, '+
                               'BAN.I_COD_BAN, CON.C_CON_BAN, CON.C_PRO_BAN, '+
                               ' BAN.C_NOM_BAN, CON.C_NRO_AGE, CON.C_NOM_CRR, CON.C_EMI_BOL, CON.C_NUM_CON,  '+
                               ' CON.I_NUM_CAR  '+
                               ' from REMESSACORPO REM, CADBANCOS BAN, CADCONTAS CON '+
                               ' Where REM.NUMCONTA = CON.C_NRO_CON '+
                               ' and CON.I_COD_BAN = BAN.I_COD_BAN '+
                               ' AND REM.CODFILIAL = '+IntToStr(VpadRemessa.CodFilial)+
                               ' and REM.SEQREMESSA = '+ IntToStr(VpaDRemessa.SeqRemessa));
  with VpaDRemessa do
  begin
    CodBanco := Tabela.FieldByName('I_COD_BAN').AsInteger;
    CodUsuario := Tabela.FieldByName('CODUSUARIO').AsInteger;
    NumConta := Tabela.FieldByName('NUMCONTA').AsString;
    NumAgencia := Tabela.FieldByName('C_NRO_AGE').AsString;
    NumCarteira := Tabela.FieldByName('I_NUM_CAR').AsInteger;
    NomCorrentista := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_NOM_CRR').AsString));
    NomBanco := UpperCase(RetiraAcentuacao(Tabela.FieldByName('C_NOM_BAN').AsString));
    NumContrato := Tabela.FieldByName('C_NUM_CON').AsString;
    NumConvenioBanco := Tabela.FieldByName('C_CON_BAN').AsString;
    CodProdutoBanco := Tabela.FieldByName('C_PRO_BAN').AsString;
    DatInicio := Tabela.FieldByName('DATINICIO').AsDateTime;
    DatEnvio := Tabela.FieldByName('DATENVIO').AsDateTime;
    IndEmiteBoleto := Tabela.FieldByName('C_EMI_BOL').AsString = 'T';
  end;
  CarDRemessaItem(VpaDRemessa);
  Tabela.close;
end;

end.
