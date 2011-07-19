Unit UnSNGPC;

Interface

Uses Classes, DB, SysUtils, SQLExpr,tabela;

//classe localiza
Type TRBLocalizaSNGPC = class
  private
    procedure LocalizaNotasEntrada(VpaTabela : TDataSet;VpaDatInicio, VpaDatFim : TDateTime);
    procedure LocalizaNotasSaida(VpaTabela : TDataSet;VpaDatInicio, VpaDatFim : TDateTime);
  publiC
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesSNGPC = class(TRBLocalizaSNGPC)
  private
    Aux,
    Tabela : TSQLQuery;
    Cadastro : TSQL;
    procedure GeraCabecalho(VpaDatInicio,VpaDatfim : TDatetime;VpaArquivo : TStringList);
    procedure GeraCadNotaFiscalFor(VpaTabela : TDataSet;VpaArquivo : TStringList);
    procedure GeraCadNotaFiscal(VpaTabela : TDataSet;VpaArquivo : TStringList);
    procedure GeraNotasEntrada(VpaDatInicio,VpaDatfim : TDatetime;VpaArquivo : TStringList);
    procedure GeraNotasSaida(VpaDatInicio,VpaDatfim : TDatetime;VpaArquivo : TStringList);
    procedure AtualizaDataSNGPC(VpaData : TDateTime);
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function GeraXMLSNGPC(VpaDatInicio, VpaDatFim : TDateTime) : string;
end;



implementation

Uses FunSql, FunString, constantes, FunArquivos, ConstMsg;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaSNGPC
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaSNGPC.cria;
begin
  inherited create;
end;

{******************************************************************************}
procedure TRBLocalizaSNGPC.LocalizaNotasEntrada(VpaTabela : TDataSet;VpaDatInicio, VpaDatFim : TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select CAD.I_SEQ_NOT, CAD.I_NRO_NOT, CAD.D_DAT_EMI, CAD.D_DAT_REC, CLI.C_CGC_CLI, '+
                                  ' PRO.C_REG_MSM, MOV.C_NUM_SER, MOV.N_QTD_PRO ' +
                                  ' from CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV, CADPRODUTOS PRO, PRINCIPIOATIVO PRI, CADCLIENTES CLI '+
                                  ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                                  ' and CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                                  ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND PRO.I_PRI_ATI = PRI.CODPRINCIPIO '+
                                  ' AND PRI.INDCONTROLADO = ''T'''+
                                   SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_REC',VpaDatInicio,VpaDatFim,true)+
                                  ' AND CAD.I_EMP_FIL = '+IntToStr(Varia.Codigoempfil)+
                                  ' ORDER BY D_DAT_REC');

end;

{******************************************************************************}
procedure TRBLocalizaSNGPC.LocalizaNotasSaida(VpaTabela : TDataSet;VpaDatInicio, VpaDatFim : TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'SELECT CAN.I_SEQ_NOT, CAD.I_TIP_REC, CAD.C_NUM_REC,  CAD.D_DAT_REC, CAD.D_DAT_ORC, '+
                                  ' MED.NOMMEDICO, NUMREGISTRO, MED.DESCONSELHO, MED.DESUFCONSELHO, ' +
                                  ' CLI.C_NOM_CLI, CLI.C_REG_CLI, CLI.C_ORG_EXP, CLI.C_EST_RG, '+
                                  ' PRO.C_REG_MSM, MOV.C_PRO_REF, MOV.N_QTD_PRO '+
                                  ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV,  MOVNOTAORCAMENTO NOO, '+
                                  ' CADNOTAFISCAIS CAN, CADPRODUTOS PRO, PRINCIPIOATIVO PRI, MEDICO MED, CADCLIENTES CLI '+
                                  ' WHERE '+ SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,false)+
                                  ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                                  ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                                  ' AND CAD.I_EMP_FIL = NOO.I_EMP_FIL '+
                                  ' AND CAD.I_LAN_ORC = NOO.I_LAN_ORC '+
                                  ' AND CAN.I_EMP_FIL = NOO.I_EMP_FIL '+
                                  ' AND CAN.I_SEQ_NOT = NOO.I_SEQ_NOT '+
                                  ' AND CAN.C_NOT_CAN = ''N'' '+
                                  ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                  ' AND PRO.I_PRI_ATI = PRI.CODPRINCIPIO '+
                                  ' AND PRI.INDCONTROLADO = ''T'''+
                                  ' AND CAD.I_COD_MED = MED.CODMEDICO '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI ',TRUE);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesSNGPC
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesSNGPC.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Cadastro := TSQL.create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.create(nil);
  Tabela.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesSNGPC.destroy;
begin
  Aux.close;
  Tabela.close;
  Cadastro.close;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesSNGPC.GeraCabecalho(VpaDatInicio,VpaDatfim : TDatetime;VpaArquivo : TStringList);
begin
  VpaArquivo.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
  VpaArquivo.Add('<mensagemSNGPC xmlns="urn:sngpc-schema">');
  VpaArquivo.Add('  <cabecalho>');
  VpaArquivo.Add('    <cnpjEmissor>'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'/'),'-') +'</cnpjEmissor>');
  VpaArquivo.Add('    <cpfTransmissor>'+DeletaChars(DeletaChars(varia.CPFResponsavelLegal,'.'),'-') +'</cpfTransmissor>');
  VpaArquivo.Add('    <dataInicio>'+ FormatDateTime('YYYY-MM-DD',VpaDatInicio)+'</dataInicio>');
  VpaArquivo.Add('    <dataFim>'+FormatDateTime('YYYY-MM-DD',VpaDatfim)+'</dataFim>');
  VpaArquivo.Add('  </cabecalho>');
end;

{******************************************************************************}
procedure TRBFuncoesSNGPC.GeraCadNotaFiscalFor(VpaTabela : TDataSet;VpaArquivo : TStringList);
begin
  VpaArquivo.add('      <entradaMedicamentos>');
  VpaArquivo.add('        <notaFiscalEntradaMedicamento>');
  VpaArquivo.add('          <numeroNotaFiscal>'+VpaTabela.FieldByname('I_NRO_NOT').AsString+'</numeroNotaFiscal>');
  VpaArquivo.add('          <tipoOperacaoNotaFiscal>1</tipoOperacaoNotaFiscal>');
  VpaArquivo.add('          <dataNotaFiscal>'+FormatDateTime('YYYY-MM-DD',VpaTabela.FieldByname('D_DAT_EMI').AsDateTime)+ '</dataNotaFiscal>');
  VpaArquivo.add('          <cnpjOrigem>'+DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByname('C_CGC_CLI').AsString,'.'),'/'),'-')+'</cnpjOrigem>');
  VpaArquivo.add('          <cnpjDestino>'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'/'),'-')+'</cnpjDestino>');
  VpaArquivo.add('        </notaFiscalEntradaMedicamento>');
end;

{******************************************************************************}
procedure TRBFuncoesSNGPC.GeraCadNotaFiscal(VpaTabela : TDataSet;VpaArquivo : TStringList);
begin
  VpaArquivo.add('      <saidaMedicamentoVendaAoConsumidor>');
  VpaArquivo.add('        <tipoReceituarioMedicamento>1</tipoReceituarioMedicamento>');
  VpaArquivo.add('        <numeroNotificacaoMedicamento>'+VpaTabela.FieldByname('C_NUM_REC').AsString+'</numeroNotificacaoMedicamento>');
  VpaArquivo.add('        <dataPrescricaoMedicamento>'+FormatDateTime('YYYY-MM-DD',VpaTabela.FieldByname('D_DAT_REC').AsDateTime)+'</dataPrescricaoMedicamento>');
  VpaArquivo.add('        <prescritorMedicamento>');
  VpaArquivo.add('          <nomePrescritor>'+VpaTabela.FieldByname('NOMMEDICO').AsString+'</nomePrescritor>');
  VpaArquivo.add('          <numeroRegistroProfissional>'+VpaTabela.FieldByname('NUMREGISTRO').AsString+'</numeroRegistroProfissional>');
  VpaArquivo.add('          <conselhoProfissional>'+VpaTabela.FieldByname('DESCONSELHO').AsString+'</conselhoProfissional>');
  VpaArquivo.add('          <UFConselho>'+VpaTabela.FieldByname('DESUFCONSELHO').AsString+'</UFConselho>');
  VpaArquivo.add('        </prescritorMedicamento>');
  VpaArquivo.add('        <usoMedicamento>1</usoMedicamento>');
  VpaArquivo.add('        <compradorMedicamento>');
  VpaArquivo.add('          <nomeComprador>'+VpaTabela.FieldByname('C_NOM_CLI').AsString+'</nomeComprador>');
  VpaArquivo.add('          <tipoDocumento>1</tipoDocumento>');
  VpaArquivo.add('          <numeroDocumento>'+VpaTabela.FieldByname('C_REG_CLI').AsString+'</numeroDocumento>');
  VpaArquivo.add('          <orgaoExpedidor>'+VpaTabela.FieldByname('C_REG_CLI').AsString+'</orgaoExpedidor>');
  VpaArquivo.add('          <UFEmissaoDocumento>'+VpaTabela.FieldByname('C_EST_RG').AsString +'</UFEmissaoDocumento>');
  VpaArquivo.add('        </compradorMedicamento>');
end;

{******************************************************************************}
procedure TRBFuncoesSNGPC.GeraNotasEntrada(VpaDatInicio,VpaDatfim : TDatetime;VpaArquivo : TStringList);
var
  VpfSeqNota : Integer;
  VpfDatRecebimento : TDateTime;
begin
  LocalizaNotasEntrada(Tabela,VpaDatInicio,VpaDatfim);
  VpfSeqNota := 0;
  while not Tabela.eof do
  begin
    if VpfSeqNota <> Tabela.FieldByname('I_SEQ_NOT').AsInteger Then
    begin
      if VpfSeqNota <> 0 then
      begin
        VpaArquivo.add('        <dataRecebimentoMedicamento>'+FormatDateTime('YYYY-MM-DD',VpfDatRecebimento)+'</dataRecebimentoMedicamento>');
        VpaArquivo.add('      </entradaMedicamentos>');
      end;
      GeraCadNotaFiscalFor(Tabela,VpaArquivo);
      VpfDatRecebimento := Tabela.FieldByname('D_DAT_REC').AsDateTime;
      VpfSeqNota := Tabela.FieldByname('I_SEQ_NOT').AsInteger;
    end;
    VpaArquivo.add('        <medicamentoEntrada>');
    VpaArquivo.add('          <registroMSMedicamento>'+Tabela.FieldByname('C_REG_MSM').AsString+'</registroMSMedicamento>');
    VpaArquivo.add('          <numeroLoteMedicamento>'+Tabela.FieldByname('C_NUM_SER').AsString+'</numeroLoteMedicamento>');
    VpaArquivo.add('          <quantidadeMedicamento>'+FormatFloat('0',Tabela.FieldByname('N_QTD_PRO').AsFloat)+'</quantidadeMedicamento>');
    VpaArquivo.add('        </medicamentoEntrada>');
    Tabela.next;
  end;
  if VpfSeqNota <> 0 then
  begin
    VpaArquivo.add('        <dataRecebimentoMedicamento>'+FormatDateTime('YYYY-MM-DD',VpfDatRecebimento)+'</dataRecebimentoMedicamento>');
    VpaArquivo.add('      </entradaMedicamentos>');
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesSNGPC.GeraNotasSaida(VpaDatInicio,VpaDatfim : TDatetime;VpaArquivo : TStringList);
var
  VpfSeqNota : Integer;
  VpfDatVenda : TDateTime;
begin
  LocalizaNotasSaida(Tabela,VpaDatInicio,VpaDatfim);
  VpfSeqNota := 0;
  while not Tabela.eof do
  begin
    if VpfSeqNota <> Tabela.FieldByname('I_SEQ_NOT').AsInteger Then
    begin
      if VpfSeqNota <> 0 then
      begin
        VpaArquivo.add('        <dataVendaMedicamento>'+FormatDateTime('YYYY-MM-DD',VpfDatVenda)+'</dataVendaMedicamento>');
        VpaArquivo.add('      </saidaMedicamentoVendaAoConsumidor>');
      end;
      GeraCadNotaFiscal(Tabela,VpaArquivo);
      VpfDatVenda := Tabela.FieldByname('D_DAT_ORC').AsDateTime;
      VpfSeqNota := Tabela.FieldByname('I_SEQ_NOT').AsInteger;
    end;
    VpaArquivo.add('        <medicamentoVenda>');
    VpaArquivo.add('          <registroMSMedicamento>'+Tabela.FieldByname('C_REG_MSM').AsString+'</registroMSMedicamento>');
    VpaArquivo.add('          <numeroLoteMedicamento>'+Tabela.FieldByname('C_PRO_REF').AsString+'</numeroLoteMedicamento>');
    VpaArquivo.add('          <quantidadeMedicamento>'+FormatFloat('0',Tabela.FieldByname('N_QTD_PRO').AsFloat)+'</quantidadeMedicamento>');
    VpaArquivo.add('        </medicamentoVenda>');
    Tabela.next;
  end;
  if VpfSeqNota <> 0 then
  begin
    VpaArquivo.add('        <dataVendaMedicamento>'+FormatDateTime('YYYY-MM-DD',VpfDatVenda)+'</dataVendaMedicamento>');
    VpaArquivo.add('      </saidaMedicamentoVendaAoConsumidor>');
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesSNGPC.AtualizaDataSNGPC(VpaData : TDateTime);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select D_DAT_SNG from CADFILIAIS '+
                                 ' Where I_EMP_FIL = '+IntToStr(varia.CodigoEmpFil));
  Cadastro.edit;
  Cadastro.FieldByname('D_DAT_SNG').AsDateTime := VpaData;
  Cadastro.post;
  Cadastro.close;
  varia.DatSNGPC := VpaData;
end;

{******************************************************************************}
function TRBFuncoesSNGPC.GeraXMLSNGPC(VpaDatInicio, VpaDatFim : TDateTime) : string;
var
  VpfArquivo : TStringList;
  VpfNomArquivo : String;
begin
  result := '';
  VpfArquivo := TStringList.Create;
  GeraCabecalho(VpaDatInicio,VpaDatFim,VpfArquivo);
  VpfArquivo.add('  <corpo>');
  VpfArquivo.add('    <medicamentos>');
  GeraNotasEntrada(VpaDatInicio,VpaDatFim,VpfArquivo);
  GeraNotasSaida(VpaDatInicio,VpaDatFim,VpfArquivo);
  VpfArquivo.add('    </medicamentos>');
  VpfArquivo.add('  </corpo>');
  VpfArquivo.add('</mensagemSNGPC>');
  if not ExisteDiretorio(Varia.DiretorioSistema+'\SNGPC') then
    CriaDiretorio(Varia.DiretorioSistema+'\SNGPC');
  VpfNomArquivo := Varia.DiretorioSistema+'\SNGPC\'+FormatDateTime('YYYYMMDD_HHMMSS',now)+'.xml';
  VpfArquivo.SaveToFile(VpfNomArquivo);
  aviso('Arquivo "'+VpfNomArquivo+'" gerado com sucesso');
  VpfArquivo.free;
  if result = '' then
    AtualizaDataSNGPC(VpaDatFim);  
end;

end.
