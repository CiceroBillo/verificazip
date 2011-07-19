unit UnExportacaoFiscal;

interface

Uses Classes, db, SQLExpr, comctrls, SysUtils, UnDados;

Type TRBFuncoesExportacaoFiscal = class
  private
    Aux,
    Estados,
    Tabela,
    Produtos : TSQLQuery;
    procedure LocalizaPessoasExportacao(VpaTabela : TDataSet; VpaCodFilial : Integer; VpaDataInicial,VpaDataFinal: TDateTime);
    procedure LocalizaNotasExportacao(VpaTabela : TDataSet;VpaCodFilial : Integer; VpaDataInicial,VpaDataFinal: TDateTime;  VpaUF : String);
    procedure LocalizaProdutosExportacao(VpaTabela : TDataSet;VpaCodFilial : Integer; VpaDataInicial,VpaDataFinal: TDateTime;  VpaUF : String);
    procedure SintegraGeraArquivo(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure SintegraGeraArquivoporEstado(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure SintegraAdicionaRegistro10e11(VpaCodFilia : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaArquivo : TStringList);
    procedure SintegraAdicionaRegistro50(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure LINCEExportarPessoas(VpaTabela: TDataSet; VpaDiretorio: string;VpaBarraStatus : TStatusBar);
    procedure LINCEExportarNotas(VpaTabela: TDataSet; VpaDiretorio: string;VpaBarraStatus : TStatusBar);
    procedure WKLiscalDosExportarPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure WKLiscalDosExportarNotas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar);
    procedure WkLiscalDosAdicionaParcelasNota(VpaArquivo : TStringList;VpaCodFilial, VpaSeqNota : Integer);
    function WkLiscalDosMontaNatureza(VpaCodNatureza, VpaTipoPagamento : String;VpaPerAliquota : Double) : String;
    function WkLiscalRCodigoAliquota(VpaPerAliquota :Double) : String;
    procedure WKRadarExportarPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure SCISupremaExportaPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure SCISupremaExportaNotasVpa(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure MTFiscalExportaPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure MTFiscalExportarNotas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdicionaRegistro10e11(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaArquivo : TStringList);
    procedure ValidaPRAdiconaRegistro50(VpaTabela : TDataSet; VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdiconaRegistro51(VpaTabela : TDataSet; VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdiconaRegistro53(VpaTabela : TDataSet; VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdiconaRegistro54(VpaTabela : TDataSet; VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdiconaRegistro50e51e53e54(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar;Var VpaQtdRegistro50, VpaQtdRegistro51, VpaQtdRegistro53, VpaQtdRegistro54 : Integer);
    procedure ValidaPRAdicionaRegistro74(VpaTabela : TDataSet; VpaDatInventario : TDateTime; Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdicionaRegistro75(VpaTabela : TDataSet; VpaDatInicial, VpaDatFinal : TDateTime; Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdicionaRegistro74e75(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar;Var VpaQtdRegistro74, VpaQtdRegistro75 : Integer);
    procedure ValidaPRAdiconaRegistro60Me60Ae60R(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
    procedure ValidaPRAdicionaRegistro90porTipo(VpaQtdRegistro,VpaTipoRegistro : Integer;VpaCNPJ,VpaInscricaoEstadual : String;VpaArquivo : TStringList);
    procedure ValidaPRAdicionaRegistro90(VpaCNPJ, VpaInscricaoEstadual : String;VpaQtdRegistro50, VpaQtdRegistro51,VpaQtdRegistro53,VpaQtdRegistro54,VpaQtdRegistro74,VpaQtdRegistro75 : Integer;VpaArquivo: TStringList);
    procedure ValidaPRExportaNotas(VpaTabela : TDataSet; VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDatetime; VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure DominioExportarPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure DominioExportaNotas(VpaTabela : TDataSet; VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDatetime; VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
    procedure DominioCabecalhoNotas(VpaDatInicio, VpaDatFim : TDatetime;VpaArquivo : TStringList);
    procedure DominioExportaNotasRegistro2(VpaTabela : TDataSet; VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDatetime; VpaBarraStatus : TStatusBar;VpaCritica :TStringList;VpaArquivo : TStringList);
    procedure TextoStatusBar(VpaStatusBar : TStatusBar;VpaTexto : String);
    procedure ValidaVariaveisExportacaoFiscal(VpaCritica : TStringList);
    function RAliquotaNota(VpaCodfilial, VpaSeqNota : Integer) : Double;
    function RCodigoFiscalMunicipio(VpaDesCidade, VpaDesUF : string) : String;
    function RInscricaoEstadualFilial(VpaCodFilial : Integer) :String;
  public
    constructor cria(VpaBaseDados : TSQLConnection );
    destructor destroy;override;
    procedure ExportarNotasPessoas(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
end;


implementation

Uses FunString, UnClientes, Constantes, FunSql, FunData, FunArquivos, funValida, UnNotaFiscal, unSistema;

{******************************************************************************}
constructor TRBFuncoesExportacaoFiscal.cria(VpaBaseDados : TSQLConnection );
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLCOnnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLCOnnection := VpaBaseDados;
  Estados := TSQLQuery.Create(nil);
  Estados.SQLCOnnection := VpaBaseDados;
  Produtos := TSQLQuery.Create(nil);
  Produtos.SQLCOnnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesExportacaoFiscal.destroy;
begin
  Aux.free;
  Tabela.free;
  Estados.free;
  inherited destroy;
end;
{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.LocalizaPessoasExportacao(VpaTabela : TDataSet; VpaCodFilial : Integer;VpaDataInicial,VpaDataFinal: TDateTime);
begin
  FechaTabela(VpaTabela);
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,' select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_TIP_PES, ' +
                              SQLTextoIsNull('CLI.C_CGC_CLI','CLI.C_CPF_CLI')+' CNPJ_CPF, CLI.C_END_CLI, CLI.C_BAI_CLI, ' +
                              ' CLI.C_EST_CLI, CLI.C_CID_CLI, C_CEP_CLI, C_FO1_CLI,CLI.C_FON_FAX,CLI.C_NOM_FAN, CLI.C_INS_CLI, CLI.C_TIP_CAD,  ' +
                              ' CLI.C_COM_END, CLI.I_NUM_END, CLI.C_IND_AGR '+
                              ' from  CADCLIENTES CLI ' +
                              ' where exists (Select * from CADNOTAFISCAIS CAD '+
                              ' Where CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                              ' and CAD.I_NRO_NOT IS NOT NULL '+
                              ' and '+SQLTextoIsNull('CAD.C_FLA_ECF','''N''')+' = ''N'' ' +
                              ' and CAD.I_EMP_FIL = '+  IntToStr(VpaCodFilial)+

  SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI', VpaDataInicial, VpaDataFinal, True)+
                              ' )');

  AbreTabela(VpaTabela);
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.LocalizaNotasExportacao(VpaTabela : TDataSet;VpaCodFilial : Integer; VpaDataInicial,VpaDataFinal: TDateTime; VpaUF : String);
begin
  FechaTabela(VpaTabela);
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,
  ' select '+SqlTextoIsNull('CLI.C_CGC_CLI','CLI.C_CPF_CLI')+' CNPJ_CPF, CLI.I_COD_CLI, CLI.C_EST_CLI, C_INS_CLI, FIL.C_EST_FIL, ' +
           ' FIL.C_CGC_FIL, CAD.I_NRO_NOT, CAD.C_SER_NOT, CAD.D_DAT_EMI, CAD.N_TOT_NOT, CAD.N_BAS_CAL, ' +
           ' CAD.N_VLR_ICM, CAD.N_TOT_IPI, CAD.N_VLR_ISQ, CAD.L_OB1_NOT, CAD.C_COD_NAT,  CAD.I_SEQ_NOT,'+
           ' CAD.I_TIP_FRE, CAD.N_VLR_FRE, CAD.I_EMP_FIL, CAD.N_VLR_SEG, N_OUT_DES, CAD.C_NOT_CAN, '+
           ' CAD.I_COD_PAG, CAD.N_TOT_PRO, CAD.N_TOT_SER, CAD.N_PER_ISQ, CAD.N_VLR_ISQ, CAD.C_CHA_NFE, '+
           ' CLI.C_TIP_PES, CLI.C_CID_CLI '+
           ' from CADNOTAFISCAIS CAD, CADCLIENTES CLI, CADFILIAIS FIL' +
           ' where CAD.I_COD_CLI = CLI.I_COD_CLI ' +
  ' and CAD.I_EMP_FIL = FIL.I_EMP_FIL ' +
  ' and CAD.I_NRO_NOT IS NOT NULL '+
  ' and CAD.C_SER_NOT = '''+Varia.SerieNota+''''+
  ' and '+SqlTextoisNull('CAD.C_FLA_ECF','''N''')+' = ''N'' ' +
  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodfilial)+
//  ' and CAD.I_NRO_NOT = 6561 ' +
  SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI', VpaDataInicial, VpaDataFinal, True));
  if VpaUF <> '' then
    AdicionaSQLTabela(VpaTabela,' AND CLI.C_EST_CLI = '''+VpaUF+'''');

  AdicionaSQLTabela(VpaTabela,'order by cad.I_SEQ_NOT');
  AbreTabela(VpaTabela);
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.LocalizaProdutosExportacao(VpaTabela : TDataSet;VpaCodFilial : Integer; VpaDataInicial,VpaDataFinal: TDateTime;  VpaUF : String);
begin
  LimpaSQlTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'select PRO.C_COD_PRO, QTD.N_QTD_PRO, QTD.N_VLR_CUS, PRO.C_NOM_PRO, C_COD_UNI, '+
                    ' PRO.N_PER_IPI, PRO.N_RED_ICM '+
                    ' from CADPRODUTOS PRO, MOVQDADEPRODUTO QTD '+
                    ' Where  PRO.I_SEQ_PRO = QTD.I_SEQ_PRO '+
                    ' AND QTD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                    ' AND EXISTS ( SELECT CAD.I_SEQ_NOT FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADCLIENTES CLI '+
                    ' Where CAD.I_EMP_FIL = '+IntTosTr(VpaCodFilial)+
                    SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDataInicial,VpaDataFinal,true)+
                    ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                    ' AND CAD.I_COD_CLI = CLI.I_COD_CLI ');
  if VpaUF <> '' then
    AdicionaSQLTabela(VpaTabela,' AND CLI.C_EST_CLI = '''+VpaUF+'''');

  AdicionaSQLTabela(VpaTabela,' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO)');
  AdicionaSQLTabela(VpaTabela,' order by PRO.C_COD_PRO');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.SintegraGeraArquivo(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfArquivo : TStringList;
begin
  VpfArquivo := TStringList.create;
  TextoStatusBar(VpaBarraStatus,'4 Adicionando registro 10');
  SintegraAdicionaRegistro10e11(VpaCodFilial,VpaDataInicial,VpaDataFinal, VpfArquivo);

  SintegraAdicionaRegistro50(VpaCodFilial,VpaDataInicial,VpaDataFinal,'',VpfArquivo,VpaCritica,VpaBarraStatus);
  VpfArquivo.SaveToFile(VpaDiretorio+InttoStr(Ano(VpaDataInicial))+AdicionaCharE('0',InttoStr(Mes(VpaDataInicial)),2)+'.txt');
  VpfArquivo.free;
  SintegraGeraArquivoporEstado(VpaCodFilial,VpaDataInicial,VpaDataFinal,VpaDiretorio,VpaBarraStatus,VpaCritica);
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.SintegraGeraArquivoporEstado(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfArquivo : TStringList;
begin
  AdicionaSQLAbreTabela(Estados,'Select  DISTINCT(C_EST_CLI) ESTADO '+
                                ' from CADNOTAFISCAIS CAD, CADCLIENTES CLI '+
                                ' where CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                                ' and CAD.I_NRO_NOT IS NOT NULL '+
                                ' and CAD.C_SER_NOT = '''+Varia.SerieNota+''''+
                                ' and '+SqlTextoIsnull('CAD.C_FLA_ECF','''N''')+' = ''N'' ' +
                                ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodfilial)+
                                SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI', VpaDataInicial, VpaDataFinal, True)+
                                ' and CLI.C_EST_CLI <> '''+Varia.UFFilial+'''');
  While not Estados.Eof do
  begin
    VpfArquivo := TStringList.create;
    TextoStatusBar(VpaBarraStatus,'4 Adicionando registro 10');
    SintegraAdicionaRegistro10e11(VpaCodFilial,VpaDataInicial,VpaDataFinal, VpfArquivo);

    SintegraAdicionaRegistro50(VpaCodFilial,VpaDataInicial,VpaDataFinal,Estados.FieldByName('ESTADO').AsString, VpfArquivo,VpaCritica,VpaBarraStatus);
    VpfArquivo.SaveToFile(VpaDiretorio+Estados.FieldByName('ESTADO').AsString+ InttoStr(Ano(VpaDataInicial))+AdicionaCharE('0',InttoStr(Mes(VpaDataInicial)),2)+'.txt');
    VpfArquivo.free;
    Estados.next;
  end;
  Estados.close;
end;


{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.SintegraAdicionaRegistro10e11(VpaCodFilia : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaArquivo : TStringList);
var
  VpfLinha : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADFILIAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodfilia));
  VpfLinha := '10'+
  //CGC
  DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_FIL').AsString,'.'),'/'),'-')+
  //INSCRICAO ESTADUAL
  AdicionaCharD(' ',DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_FIL').AsString,'.'),'-'),14)+
  //NOME DO CONTRIBUINTE
  AdicionaCharD(' ',COPY(Tabela.FieldByName('C_NOM_FIL').AsString,1,35),35)+
  //MUNICIPIO
  AdicionaCharD(' ',COPY(Tabela.FieldByName('C_CID_FIL').AsString,1,30),30)+
  //UNIDADE DE FEDERACAO
  AdicionaCharD(' ',Tabela.FieldByName('C_EST_FIL').AsString,2)+
  //FAX
  AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(COPY(Tabela.FieldByName('C_FON_FIL').AsString,5,15),')'),' '),'-'),10)+
  //DATA INICIAL
  FormatDateTime('YYYYMMDD',VpaDatInicial)+
  //DATA FINAL
  FormatDateTime('YYYYMMDD',VpaDatFinal)+
  //CODIGO DO CONVENIO
  '3'+
  //CODIGO DA IDENTIFICACAO DAS NATUREZAS INFORMADAS
  '3'+
  //CODIGO DA FINALIDADE DO ARQUIVO MAGNETICO
  '1';
  VpaArquivo.Add(VpfLinha);

  //registro 11
  VpfLinha := '11'+
  //Logradouro
  AdicionaCharD(' ',copy(Tabela.FieldByName('C_END_FIL').AsString,1,34),34)+
  //NUMERO
  AdicionaCharE('0',Tabela.FieldByName('I_NUM_FIL').AsString,5)+
  //COMPLEMENTO
  AdicionaCharD(' ','',22)+
  //BAIRRO
  AdicionaCharD(' ',Tabela.FieldByName('C_BAI_FIL').AsString,15)+
  //CEP
  AdicionaCharE('0',Tabela.FieldByName('I_CEP_FIL').AsString,8)+
  //NOME DE CONTATO
  AdicionaCharD(' ',Tabela.FieldByName('C_DIR_FIL').AsString,28)+
  //TELEFONE CONTATO
  AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(COPY(Tabela.FieldByName('C_FAX_FIL').AsString,5,15),')'),' '),'-'),12);
  VpaArquivo.Add(VpfLinha);

  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.SintegraAdicionaRegistro50(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime;  VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
Var
  VpfLinha : String;
  VpfQtdRegistros50, VpfQtdRegistros51 : Integer;
  VpfInscricaoEstadual, VpfInscricaoEstadualFilial : String;
begin
  VpfInscricaoEstadualFilial := RInscricaoEstadualFilial(VpaCodFilial);
  VpfQtdRegistros50 := 0;
  VpfQtdRegistros51 := 0;

  TextoStatusBar(VpaBarraStatus,'4 Localizando as notas fiscais');
  LocalizaNotasExportacao(Tabela,VpaCodFilial,VpaDatInicial,VpaDatFinal,VpaUF);
  While not Tabela.Eof do
  begin
    inc(VpfQtdRegistros50);
    TextoStatusBar(VpaBarraStatus,'4 Validando a inscrição estadual');
    VpfInscricaoEstadual := DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_CLI').AsString,'.'),'-'),'/');
    if (VpfInscricaoEstadual = '') or (Tabela.FieldByName('C_TIP_PES').AsString = 'F') then
      VpfInscricaoEstadual := 'ISENTO';
    if (Tabela.FieldByName('C_TIP_PES').AsString = 'F') then
    begin
      if not VerificaCPF(Tabela.FieldByName('CNPJ_CPF').AsString) then
        VpaCritica.Add('Cadastro do Cliente "'+Tabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! CPF inválida');
    end
    else
    begin
      if not VerificarIncricaoEstadual(VpfInscricaoEstadual,Tabela.FieldByName('C_EST_CLI').AsString,false,true) then
        VpaCritica.Add('Cadastro do Cliente "'+Tabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual inválida');
      if VpfInscricaoEstadual = VpfInscricaoEstadualFilial then
        VpaCritica.Add('Cadastro do Cliente "'+Tabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual é a mesma da "'+varia.NomeFilial+'"');
    end;

    TextoStatusBar(VpaBarraStatus,'4 Inserindo registro 50 da nota fiscal "'+Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    //codigo do registro
    VpfLinha := '50'+
    //cnpj destinatario
    AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('CNPJ_CPF').AsString,'.'),'/'),'-'),14)+
    //INSCRICAO ESTADUAL
    AdicionaCharD(' ',VpfInscricaoEstadual,14)+
    //DATA DE EMISSAO
    FormatDateTime('YYYYMMDD',Tabela.FieldByName('D_DAT_EMI').AsDateTime)+
    //UNIDADE DE FEDERACAO
    AdicionaCharD(' ',Tabela.FieldByName('C_EST_CLI').AsString,2)+
    //MODELO
    '01'+
    //SERIE DA NOTA
    AdicionaCharD(' ',Tabela.FieldByName('C_SER_NOT').AsString,3)+
    //NUMERO DA NOTA FISCAL
    AdicionaCharE('0',Tabela.FieldByName('I_NRO_NOT').AsString,6)+
    //CFOP
    AdicionaCharE('0',COPY(Tabela.FieldByName('C_COD_NAT').AsString,1,4),4)+
    //EMITENTE DA NOTA FISCAL
    'P'+
    //VALOR TOTAL
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Tabela.FieldByName('N_TOT_NOT').AsFloat),','),13)+
    //BASE DE CALCULO DO ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Tabela.FieldByName('N_BAS_CAL').AsFloat),','),13)+
    //VALOR DO ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Tabela.FieldByName('N_VLR_ICM').AsFloat),','),13)+
    // ISENTA OU NÃO TRIBUTADA
    AdicionaCharE('0','0',13)+
    // OUTRAS
    AdicionaCharE('0','0',13)+
    //ALIQUOTA
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',RAliquotaNota(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_NOT').AsInteger)),','),4)+
   //SITUACAO DA NOTA FISCAL
    AdicionaCharE('N',Tabela.FieldByName('C_NOT_CAN').AsString,1);
    VpaArquivo.Add(VpfLinha);

    Tabela.Next;
  end;
  Tabela.First;
  While not Tabela.Eof do
  begin
    inc(VpfQtdRegistros51);
    if (varia.CNPJFilial = CNPJ_Kairos) then
    begin
      TextoStatusBar(VpaBarraStatus,'3 Inserindo registro 51 da nota fiscal "'+Tabela.FieldByName('I_NRO_NOT').AsString+'"');
      //codigo do registro
      VpfLinha := '51'+
      //cnpj destinatario
      AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('CNPJ_CPF').AsString,'.'),'/'),'-'),14)+
      //INSCRICAO ESTADUAL
      AdicionaCharD(' ',VpfInscricaoEstadual,14)+
      //DATA DE EMISSAO
      FormatDateTime('YYYYMMDD',Tabela.FieldByName('D_DAT_EMI').AsDateTime)+
      //UNIDADE DE FEDERACAO
      AdicionaCharD(' ',Tabela.FieldByName('C_EST_CLI').AsString,2)+
      //SERIE DA NOTA
      AdicionaCharD(' ',Tabela.FieldByName('C_SER_NOT').AsString,3)+
      //NUMERO DA NOTA FISCAL
      AdicionaCharE('0',Tabela.FieldByName('I_NRO_NOT').AsString,6)+
      //CFOP
      AdicionaCharE('0',COPY(Tabela.FieldByName('C_COD_NAT').AsString,1,4),4)+
      //VALOR TOTAL
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Tabela.FieldByName('N_TOT_NOT').AsFloat),','),13)+
      //VALOR DO IPI
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Tabela.FieldByName('N_TOT_IPI').AsFloat),','),13)+
      // ISENTA OU NÃO TRIBUTADA
      AdicionaCharE('0','0',13)+
      // OUTRAS
      AdicionaCharE('0','0',13)+
      //BRANCOS 20
      AdicionaCharE(' ','',20)+
     //SITUACAO DA NOTA FISCAL
      AdicionaCharE('N',Tabela.FieldByName('C_NOT_CAN').AsString,1);
      VpaArquivo.Add(VpfLinha);
    end;
    Tabela.Next;
  end;


  TextoStatusBar(VpaBarraStatus,'4 Inserindo registro tipo 90');
  AdicionaSQLAbreTabela(Tabela,'Select * from CADFILIAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial));
  //registro do tipo 90
  VpfLinha := '90' +
  //CGC
  DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_FIL').AsString,'.'),'/'),'-')+
  //INSCRICAO ESTADUAL
  AdicionaCharD(' ',DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_FIL').AsString,'.'),'-'),14)+
  //TIPO DO REGISTRO A SER TOTALIZADO
  '50'+
  //TOTAL DE REGISTROS
  AdicionaCharE('0',IntToStr(VpfQtdRegistros50),8)+
  '51'+
  //TOTAL DE REGISTROS
  AdicionaCharE('0',IntToStr(VpfQtdRegistros51),8)+
  //TOTAL GERAL DOS REGISTROS
  '99'+AdicionaCharE('0',IntToStr(VpfQtdRegistros50+VpfQtdRegistros51+3),8);
  VpfLinha := AdicionaCharD(' ',VPFLINHA,125)+ '1';
  VpaArquivo.add(VpfLinha);
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.LinceExportarPessoas(VpaTabela: TDataSet; VpaDiretorio: string;VpaBarraStatus : TStatusBar);
var
  VpfTexto: TextFile;
  VpfAuxStr: Ansistring;
begin
  AssignFile(VpfTExto,VpaDiretorio + 'PESSOAS.txt');
  Rewrite(VpfTexto);

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    TextoStatusBar(VpaBarraStatus,'2 Exportando o cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'"');
    VpfAuxStr :=
    //Field1=Codigo,Char,06,00,00
    AdicionaCharD(' ',VpaTabela.fieldbyname('I_COD_CLI').AsString, 6) +
    //Field2=Fantas,Char,20,00,06
    AdicionaCharD(' ',CopiaDireita(VpaTabela.fieldbyname('C_NOM_CLI').AsString,20), 20) +
    //Field3=Pessoa,Char,01,00,26
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_TIP_PES').AsString, 1) +
    //Field4=CGCCPF,Char,18,00,27
    AdicionaCharD(' ',VpaTabela.fieldbyname('CNPJ_CPF').AsString, 18) +
    //Field5=RazSoc,Char,50,00,45
    AdicionaCharD(' ',CopiaDireita(VpaTabela.fieldbyname('C_NOM_CLI').AsString,50), 50) +
    //Field6=Endere,Char,50,00,95
    AdicionaCharD(' ',CopiaDireita(VpaTabela.fieldbyname('C_END_CLI').AsString,50), 50) +
    //Field7=Bairro,Char,30,00,145
    AdicionaCharD(' ',CopiaDireita(VpaTabela.fieldbyname('C_BAI_CLI').AsString,30), 30) +
    //Field8=Estado,Char,02,00,175
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_CLI').AsString, 2) +
    //Field9=CodMun,Char,06,00,177
    AdicionaCharD(' ',RCodigoFiscalMunicipio(VpaTabela.FieldByName('C_CID_CLI').AsString,VpaTabela.FieldByName('C_EST_CLI').AsString), 7) +
    //Field10=NomMun,Char,30,00,183
    AdicionaCharD(' ',CopiaDireita(VpaTabela.fieldbyname('C_CID_CLI').AsString,30), 30) +
    //Field11=CepMun,Char,08,00,213
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_CEP_CLI').AsString, 8) +
    //Field12=Telefo,Char,15,00,221
    AdicionaCharD(' ',DeletaChars(VpaTabela.fieldbyname('C_FO1_CLI').AsString,'*'), 15) +
    //Field13=Agrope,Char,01,00,236
    AdicionaCharD('N',VpaTabela.fieldbyname('C_IND_AGR').AsString,1) +
    //Field14=Inscri,Char,25,00,237
    AdicionaCharD(' ',DeletaChars(VpaTabela.fieldbyname('C_INS_CLI').AsString,'-'), 25) +
    //Field15=CtbFor,Char,10,00,262
    AdicionaCharD(' ','', 10) +
    //Field16=CtbCli,Char,10,00,272
    AdicionaCharD(' ','', 10);

    Writeln(VpfTExto,VpfAuxStr);
    VpaTabela.Next;
  end;
  CloseFile(VpfTexto);
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.LINCEExportarNotas(VpaTabela : TDataSet; VpaDiretorio: string;VpaBarraStatus : TStatusBar);
var
  VpfTexto: TStringList;
  VpfAuxStr, VpfNatureza,VpfContribuinte,VpfDesObservacao : string;
  VpfValTotal, VpfValBase, VpfValAliquota,VpfValICMS, VpfValIPI, VpfValIsentas: Double;
  VpfIndNotaCancelada : Boolean;
begin
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    TextoStatusBar(VpaBarraStatus,'2 Exportado dados da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    if VpaTabela.FieldByName('C_COD_NAT').AsString <> '' then
      VpfNatureza := VpaTabela.FieldByName('C_COD_NAT').AsString
    else
    begin
      if VpaTabela.FieldByName('C_EST_CLI').AsString <> 'SC' then
        VpfNatureza := '6101'
      else
        VpfNatureza := '';
    end;
    IF VpaTabela.FieldByName('C_TIP_PES').AsString = 'F' then
      VpfContribuinte := 'N'
    else
      VpfContribuinte := 'S';
    VpfIndNotaCancelada := (VpaTabela.FieldByName('C_NOT_CAN').AsString = 'S');
    if VpfIndNotaCancelada then
    begin
      VpfValTotal := 0;
      VpfValBase := 0;
      VpfValAliquota :=0;
      VpfValIcms := 0;
      VpfValIPI := 0;
      VpfDesObservacao := 'NOTA FISCAL CANCELADA';
      VpfValIsentas := 0
    end
    else
    begin
      VpfValTotal := VpaTabela.fieldbyname('N_TOT_NOT').AsFloat;
      VpfValBase := VpaTabela.fieldbyname('N_BAS_CAL').AsFloat;
      VpfValIcms := VpaTabela.fieldbyname('N_VLR_ICM').AsFloat;
      VpfValIpi := VpaTabela.fieldbyname('N_TOT_IPI').AsFloat;
      VpfValAliquota := 12;
      VpfValIsentas := VpaTabela.fieldbyname('N_BAS_CAL').AsFloat;
      VpfDesObservacao := DeletaChars(DeletaChars(CopiaEsquerda(VpaTabela.FieldByName('L_OB1_NOT').AsString,57),#13),'"');
    end;

    VpfAuxStr :=
    //Field1=Fornec,Char,18,00,00
    AdicionaCharD(' ',VpaTabela.fieldbyname('CNPJ_CPF').AsString, 18) +
    //Field2=EstDes,Char,02,00,18
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_CLI').AsString, 2) +
    //Field3=Operac,Char,06,00,20
    AdicionaCharD(' ',VpfNatureza, 4) + '02'+
    //Field4=EstOri,Char,02,00,26
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_FIL').AsString, 2) +
    //Field5=MunOri,Char,06,00,28
    AdicionaCharD(' ','', 6) +
    //Field6=DocIni,Char,06,00,34
    AdicionaCharD(' ',VpaTabela.fieldbyname('I_NRO_NOT').AsString, 6) +
    //Field7=DocFin,Char,06,00,40
    AdicionaCharD(' ',VpaTabela.fieldbyname('I_NRO_NOT').AsString, 6) +
    //Field8=Especi,Char,04,00,46
    AdicionaCharD(' ','NFE', 4) +
    //Field9=DSerie,Char,03,00,50
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_SER_NOT').AsString, 3) +
    //Field10=DatEmi,Char,10,00,53
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) +
    //Field11=Contri,Char,01,00,63
    AdicionaCharD('S',VpfContribuinte, 1) +
    //Field12=VlCont,Float,20,02,64
    AdicionaCharE(' ',FormatFloat('0.00',vpfValTotal), 20) +
    //Field13=IcmAli,Float,20,02,84
    AdicionaCharE(' ',FormatFloat('00.00',vpfValAliquota), 20) +
    //Field14=IcmBsr,Char,01,00,104
    AdicionaCharE('N','N', 1) +
    //Field15=IcmRed,Float,20,02,105
    AdicionaCharE(' ','0,00', 20) +
    //Field16=IcmBsc,Float,20,02,125
    AdicionaCharE(' ',FormatFloat('0.00',VpfValBase), 20) +
    //Field17=IcmVlr,Float,20,02,145
    AdicionaCharE(' ',FormatFloat('0.00',VpfValICMS), 20) +
    //Field18=IcmIse,Float,20,02,165
    AdicionaCharE(' ',FormatFloat('0.00',VpfValTotal), 20) +
    //Field19=IcmOut,Float,20,02,185
    AdicionaCharE(' ','0,00', 20) +
    //Field20=AcrFin,Float,20,02,205
    AdicionaCharE(' ','0,00', 20) +
    //Field21=CplAli,Float,20,02,225
    AdicionaCharE(' ','0,00', 20) +
    //Field22=CplBsc,Float,20,02,245
    AdicionaCharE(' ','0,00', 20) +
    //Field23=CplVlr,Float,20,02,265
    AdicionaCharE(' ','0,00', 20) +
    //Field24=IpiBsc,Float,20,02,285
    AdicionaCharE(' ','0,00', 20) +
    //Field25=IpiVlr,Float,20,02,305
    AdicionaCharE(' ',FormatFloat('0.00',VpfValIPI), 20) +
    //Field26=IpiIse,Float,20,02,325
    AdicionaCharE(' ','0,00', 20) +
    //Field27=IpiOut,Float,20,02,345
    AdicionaCharE(' ','0,00', 20) +
    //Field28=IssAli,Float,20,02,365
    AdicionaCharE(' ','0,00', 20) +
    //Field29=IssBsc,Float,20,02,385
    AdicionaCharE(' ','0,00', 20) +
    //Field30=IssVlr,Float,20,02,405
    AdicionaCharE(' ',FormatFloat('0.00',VpaTabela.fieldbyname('N_VLR_ISQ').AsFloat), 20) +
    //Field31=Observ,Char,40,00,425
    AdicionaCharE(' ',CopiaDireita(DeletaChars(VpfDesObservacao,#13), 40), 40) +
    //Field32=TabCon,Char,04,00,465
    AdicionaCharD(' ','', 4) +
    //Field33=Esp,Char,04,00,469
    AdicionaCharD(' ','xxxx', 4) +
    //Field34=C75Cod,Char,02,00,473
    AdicionaCharD(' ','01', 2);
    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'SAIDA.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.WKLiscalDosExportarPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfTexto: TStringList;
  VpfAuxStr: string;
  VpfCodFiscalMunicipio : String;
begin
  //Exporta os clientes para o sistema LISCAL versão 447 for DOS da WK sistemas
  //Dúvidas referente ao layout foram tiradas com o Arno da ERB no dia 17/08/2005 as 16:30
  //Os campos textos tem que vir entre " aspas duplas e os numericos com zero a esquerda, com o separador de campo vírgula
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    VpfCodFiscalMunicipio := RCodigoFiscalMunicipio(RetiraAcentuacao(VpaTabela.FieldByName('C_CID_CLI').AsString),VpaTabela.FieldByName('C_EST_CLI').AsString);
    if VpfCodFiscalMunicipio = '' then
      VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! O município cadastrado "'+VpaTabela.FieldByName('C_CID_CLI').AsString+ '" não existe para o Fisco');

    TextoStatusBar(VpaBarraStatus,'1 Exportando o cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'"');
    VpfAuxStr :=
    //01=Tipo de Operacao (A-Alteracao, E-Exclusão, I-Inclusão) X(01)  **Sempre será I de inclusão, o Liscal se encarrega de verificar se o cliente já existe pelo CNPJ e caso existir altera os dados
    '"I","'+
    //02 -Codigo reduzido do fornecedor / cliente 9(8).
    AdicionaCharE('0',VpaTabela.fieldbyname('I_COD_CLI').AsString, 8) +'","'+
    //03 - Tipo (F-Fornecedor/C-Cliente/A-Ambos)  X(1).
    AdicionaCharD('C',VpaTabela.fieldbyname('C_TIP_CAD').AsString,1) + '","'+
    //04 - Nome de fantasia  X(19).
    AdicionaCharD(' ',CopiaDireita(retiraAcentuacao(VpaTabela.fieldbyname('C_NOM_CLI').AsString),19),19) + '","'+
    //05 - Razao Social X(47).
    AdicionaCharD(' ',CopiaDireita(RetiraAcentuacao(VpaTabela.fieldbyname('C_NOM_CLI').AsString),47), 47) + '","'+
    //06 - Endereço X(47).
    AdicionaCharD(' ',CopiaDireita(VpaTabela.fieldbyname('C_END_CLI').AsString,47), 47) + '","'+
    //07 - Bairro X(31).
    AdicionaCharD(' ',CopiaDireita(VpaTabela.fieldbyname('C_BAI_CLI').AsString,31), 31) + '","'+
    //08 - Estado X(2).
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_CLI').AsString, 2) + '","'+
    //09 - Codigo fiscal do municipio X(6)
    AdicionaCharD(' ',VpfCodFiscalMunicipio, 6) + '","'+
    //10 - Nome do municipio X(31)
    AdicionaCharD(' ',UpperCase(RetiraAcentuacao(CopiaDireita(VpaTabela.fieldbyname('C_CID_CLI').AsString,31))), 31) +'","'+
    //11 - CEP DO BAIRRO X(9)
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_CEP_CLI').AsString, 9) + '","'+
    //12 - Numero DDD 9(4)
    AdicionaCharE('0',FunClientes.RDDDCliente(VpaTabela.fieldbyname('C_FO1_CLI').AsString),4) + '","'+
    //13 - Telefone X(08)
    AdicionaCharD(' ',FunClientes.RTelefoneSemDDD(VpaTabela.fieldbyname('C_FO1_CLI').AsString),8) + '","'+
    //14 - FAX X(08)
    AdicionaCharD(' ',FunClientes.RTelefoneSemDDD(VpaTabela.fieldbyname('C_FON_FAX').AsString),8) + '","'+
    //15 - TELEX X(08)
    AdicionaCharD(' ','',8) + '","'+
    //16 - CAIXA POSTAL X(5)
    AdicionaCharD(' ','', 5) +'","'+
    //17 - AGROPECUARIO (S/N)  X(1)
    AdicionaCharD(' ','N', 1) +'","'+
    //18 - NUMERO DO CNPJ X(18)
    AdicionaCharD(' ',VpaTabela.fieldbyname('CNPJ_CPF').AsString, 18) +'","'+
    //19 - NUMERO DA INSCRICAO ESTADUAL X(18)
    VpaTabela.fieldbyname('C_INS_CLI').AsString +'","'+
    //20 - CONTA CONTABIL DO FORNECEDOR 9(6)
    AdicionaCharE('0',IntTostr(Varia.ContaContabilFornecedor),6) +'","'+
    //21 - CONTA CONTABIL DO CLIENTE 9(6)
    AdicionaCharE('0',inttostr(varia.ContaContabilCliente),6) +'","'+
    //22 - NUMERO DA INSCRICAO MUNICIPAL X(15)
    AdicionaCharD(' ','', 15) +'","'+
    //23 - REGIME DE ICMS RETIDO NA FONTE
    'N"';


    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'LFDCD90.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.WKLiscalDosExportarNotas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar);
var
  VpfTexto: TStringList;
  VpfAuxStr, VpfNatureza,VpfContribuinte, VpfDesObservacao, VpfTipoCondicaoPgto: string;
  VpfIndNotaCancelada : Boolean;
  VpfValTotal, VpfValBase,VpfValIcms,VpfValAliquota, VpfValIPI : Double;
begin
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    TextoStatusBar(VpaBarraStatus,'1 Exportado dados da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    if VpaTabela.FieldByName('C_COD_NAT').AsString <> '' then
      VpfNatureza := VpaTabela.FieldByName('C_COD_NAT').AsString
    else
    begin
      if VpaTabela.FieldByName('C_EST_CLI').AsString <> 'SC' then
        VpfNatureza := '6101'
      else
        VpfNatureza := '';
    end;

    IF VpaTabela.FieldByName('C_INS_CLI').AsString = '' then
      VpfContribuinte := 'N'
    else
      VpfContribuinte := 'S';

    if (VpaTabela.FieldByName('I_COD_PAG').AsInteger = Varia.CondPagtoVista) then
      VpfTipoCondicaoPgto := '1' // a vista
    else
      VpfTipoCondicaoPgto := '2';//a prazo
    VpfIndNotaCancelada := (VpaTabela.FieldByName('C_NOT_CAN').AsString = 'S');
    if VpfIndNotaCancelada then
    begin
      VpfValTotal := 0;
      VpfValBase := 0;
      VpfValAliquota :=0;
      VpfValIcms := 0;
      VpfValIPI := 0;
      VpfDesObservacao := 'NOTA FISCAL CANCELADA';
      VpfNatureza := '5.949.99';
    end
    else
    begin
      VpfValtotal := VpaTabela.fieldbyname('N_TOT_NOT').AsFloat;
      VpfValBase := VpaTabela.fieldbyname('N_BAS_CAL').AsFloat;
      VpfValIcms := VpaTabela.fieldbyname('N_VLR_ICM').AsFloat;
      VpfValIpi := VpaTabela.fieldbyname('N_TOT_IPI').AsFloat;
      VpfValAliquota := RAliquotaNota(VpaTabela.FieldByName('I_EMP_FIL').AsInteger,VpaTabela.FieldByName('I_SEQ_NOT').AsInteger);
      if VpfValAliquota = 0 then
      begin
        VpfValBase := 0;
        VpfValIPI := VpaTabela.FieldByName('N_TOT_PRO').AsFloat;
      end;
      VpfDesObservacao := DeletaChars(DeletaChars(CopiaEsquerda(VpaTabela.FieldByName('L_OB1_NOT').AsString,57),#13),'"');
      VpfNatureza := WkLiscalDosMontaNatureza(VpfNatureza,VpfTipoCondicaoPgto,VpfValAliquota);
    end;
    VpfAuxStr :=
    //01 - TIPO DE OPERACAO (I-INCLUSAO, A-ALTERACAO, E-EXCLUSA) X(1)
    '"I","'+
    //02 - FORNCEDOR CLIENTE (CNPJ) X(18)
    AdicionaCharD(' ',VpaTabela.fieldbyname('CNPJ_CPF').AsString, 18) + '","'+
    //03 - CODIGO DA NATUREZA x(12)
    VpfNatureza + '","'+
    //04 - NUMERO DO DOCUMENTO X(6)
    VpaTabela.fieldbyname('I_NRO_NOT').AsString + '","'+
    //05 - ESPECIE DO DOCUMENTO X(3)
    'NF' +'","'+
    //06 - SERIE DO DOCUMENTO X(3)
    VpaTabela.fieldbyname('C_SER_NOT').AsString  +'","' +
    //07 - DATA DE ENTRADA DO DOCUMENTO X(8)
    FormatDateTime('ddmmyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) + '","'+
    //08 - DATA DE EMISSAO DO DOCUMENTO X(8)
    FormatDateTime('ddmmyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) + '","'+
    //09 - ALIQUOTA DE ICMS 9(6)v99
    SubstituiStr(FormatFloat('0.00',VpfValAliquota),',','.') +'","'+
    //10 - VALOR CONTABIL 9(14)v99
    SubstituiStr(FormatFloat('0.00',VpfValTotal),',','.') +'","'+
    //11 - BASE REDUZIDA (S/N)
    AdicionaCharD(' ','N', 1) +'","'+
    //12 - BASE DE CALCULO DO PRIMEIRO IMPOSTO /ICMS
    SubstituiStr(FormatFloat('0.00',VpfValBase),',','.') +'","'+
    //13 - VALOR DO IMPOSTO
    SubstituiStr(FormatFloat('0.00',VpfValIcms),',','.') +'","'+
    //14 - VALOR DE ISENTAS  - SEGUNDO ARNO DA ERB VAI O VALOR DO IPI
    SubstituiStr(FormatFloat('0.00',VpfValIPI),',','.') +'","'+
    //15 - VALOR DE OUTRAS  - ZERADO
    '0.00' +'","'+
    //16 - VALOR BASE CALCULO IMPOSTO INDIRETO - ZERADO
    '0.00' +'","'+
    //17 - VALOR DO IMPOSTO INDIRETO - ZERADO
    '0.00' +'","'+
    //18 - BASE DE CALCULO DO SEGUNDO IMPOSTO - IPI
    '0.00' +'","'+
    //19 - VALOR DO SEGUNDO IMPOSTO - IPI
    '0.00'+'","'+
    //20 - VALOR DE ISENTAS
    SubstituiStr(FormatFloat('0.00',VpfValTotal),',','.') +'","'+
    //21 - VALOR DE OUTRAS
    '0.00' +'","'+
    //22 - OBSERVACOES
    DeletaChars(DeletaChars(VpfDesObservacao,#13),#10) +'","'+
    //23 - VALOR DO ACRESCIMO FINANCEIRO
    '0.00' +'","'+
    //24 - CONTA CREDORA DO VALOR CONTABIL
    '' +'","'+
    //'3168' +'","'+
    //25 - CONTA DEVEDORA DO VALOR CONTABIL
    // a vista 52
    // a prazo 5345
    '' +'","'+
    //26 - CÓDIGO DO HISTÓRICO DO CRÉDITO VALOR CONTÁBIL
    //historico a prazo 763
    //historico a vista 778
    '' +'","'+
    //27 - CÓDIGO DO HISTÓRICO DO DÉBITO VALOR CONTÁBIL
    '' +'","'+
    //28 - CONTRIBUINTE  (S/N)
    AdicionaCharD('S',VpfContribuinte, 1) +'","'+
    //29 - NUMERO FINAL DO INTERVALO DO DOCUMENTO
    VpaTabela.fieldbyname('I_NRO_NOT').AsString + '","'+
    //30 - ESTADO DE ORIGEM (SIGLA)
    VpaTabela.FieldByName('C_EST_FIL').AsString+'","'+
    //31 - ESTADO DE DESTINO (SIGLA)
    VpaTabela.FieldByName('C_EST_CLI').AsString +'","'+
    //32 - CODIGO FISCAL DO MUNICIO DE DESTINO
    RCodigoFiscalMunicipio(VpaTabela.FieldByName('C_CID_CLI').AsString,VpaTabela.FieldByName('C_EST_CLI').AsString) +'","'+
    //33 - IPI EMBUTIDO/ICMS RESPONSABILIDADE
    '0.00' +'","'+
    //34 - COMPLEMNTO CONTABIL DO DEBITO
    '' +'","'+
    //35 - COMPLEMNTO CONTABIL DO CRÉDITO
    '' +'","'+
    //36 - DATA DE VENCIMENTO DO DOCUMENTO
    FormatDateTime('DDMMYY',VpaTabela.FieldByName('D_DAT_EMI').AsDatetime) +'","'+
    //37 - NUMERO DO DOCUMENTO DE IMPORTACAO
    '' +'","'+
    //38 - TIPO DE FRETE 1 -CIF, 2 -FOB, 3 -OUTROS
    AdicionaCharD(' ',CopiaDireita(VpaTabela.FieldByName('I_TIP_FRE').AsString,1),1) +'","'+
    //39 - VALOR DO DESCONTO
    '0.00' +'","'+
    //40 - VALOR DO FRETE (DESPESAS ACESSORIAS)
    SubstituiStr(FormatFloat('0.00',VpaTabela.fieldbyname('N_VLR_FRE').AsFloat),',','.') +'","'+
    //41 - VALOR DO SEGURO (DESPESAS ACESSORIAS)
    SubstituiStr(FormatFloat('0.00',VpaTabela.fieldbyname('N_VLR_SEG').AsFloat),',','.') +'","'+
    //42 - VALOR DE OUTRAS DESPESAS ACESSORIAS
    SubstituiStr(FormatFloat('0.00',VpaTabela.fieldbyname('N_OUT_DES').AsFloat),',','.') +'","'+
    //43 - LANCAMENTO FUNDAP
    AdicionaCharE('N','N',1) +'","'+
    //44 - TIPO DO DOCUMENTO
    AdicionaCharE('P','P',1) +'","'+
    //45 - ICMS ANTECIPADO
    '0.00'+'","'+
    //46 - NUMERO DO FORMULARIO CONTINUO USADO PARA A EMISSAO DESTA NOTA (SISIF - CE)
    '0' +'","'+
    //47 - CODIGO QUE IDENTIFICA O TIPO DE ANTEC. TRIBUTARIA
    AdicionaCharD(' ',' ',1) +'","'+
    //48 - BASE DE CALCULO ICMS ANTECIPADO (SISIF - CE)
    '0.00' +'","'+
    //49 - TOTAL DO ICMS ANTECIPADO (SISIF - CE)
    '0.00' +'","'+
    //50 - CNPJ DO LOCAL DE SAIDA DA MERADORIA
    AdicionaCharD(' ',VpaTabela.FieldByName('C_CGC_FIL').AsString,18) +'","'+
    //51 - TIPO PAGAMENTO 1-AVISTA 2 - A PRAZO 3 - LEASING
    AdicionaCharD(' ',VpfTipoCondicaoPgto,1) +'","'+
    //52 - CNPJ DO LOCAL DE ENTREGA
    '' +'"';
    VpfTexto.Add(VpfAuxStr);
    if not VpfIndNotaCancelada then
      WkLiscalDosAdicionaParcelasNota(VpfTexto,VpaTabela.FieldByName('I_EMP_FIL').AsInteger,VpaTabela.FieldByName('I_SEQ_NOT').AsInteger);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'LFDCD50.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.WkLiscalDosAdicionaParcelasNota(VpaArquivo : TStringList;VpaCodFilial, VpaSeqNota : Integer);
var
  VpfAuxStr, VpfDatRecebimento : String;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MOV.I_NRO_PAR, MOV.C_NRO_DUP, MOV.D_DAT_VEN, CAD.I_NRO_NOT, D_DAT_PAG, N_VLR_PAR, N_VLR_PAG '+
                        ' FROM CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                        ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                        ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                        ' AND CAD.I_EMP_FIL = '+ IntTostr(VpaCodFilial)+
                        ' and CAD.I_SEQ_NOT = '+ IntToStr(VpaSeqNota));
  While not Aux.Eof do
  begin
    if Aux.FieldByName('D_DAT_PAG').ASDatetime > MontaData(1,1,1900) then
      VpfDatRecebimento := FormatDateTime('DDMMYY',Aux.FieldByName('D_DAT_PAG').AsDateTime)
    else
      VpfDatRecebimento := '';
    VpfAuxStr := '"T","'+
    //parcela
    Aux.FieldByName('I_NRO_PAR').AsString+ '","'+
    //Titulo
    Aux.FieldByName('I_NRO_NOT').AsString + '","'+
    //DT Vencimento
    FormatDateTime('DDMMYY',Aux.FieldByName('D_DAT_VEN').AsDateTime)+ '","'+
    //valor
    SubstituiStr(FormatFloat('0.00',Aux.FieldByName('N_VLR_PAR').AsFloat),',','.') + '","'+
    //DT RECEBIMENTO
    VpfDatRecebimento + '","'+
    //Valor recebido
    SubstituiStr(FormatFloat('0.00',Aux.FieldByName('N_VLR_PAG').AsFloat),',','.') +'"';
    VpaArquivo.Add(VpfAuxStr);
    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoFiscal.WkLiscalDosMontaNatureza(VpaCodNatureza, VpaTipoPagamento : String;VpaPerAliquota : Double) : String;
begin
  result := VpaCodNatureza;
  insert('.',result,2);
  result := result + '.'+ AdicionaCharE('0',WkLiscalRCodigoAliquota(VpaPerAliquota),2);
  Result := result +'.'+AdicionaCharE('0',VpaTipoPagamento,2);
end;

{******************************************************************************}
function TRBFuncoesExportacaoFiscal.WkLiscalRCodigoAliquota(VpaPerAliquota :Double) : String;
begin
  AdicionaSqlAbreTabela(Aux,'Select CODALIQUOTA FROM ALIQUOTAFISCAL'+
                            ' Where PERALIQUOTA = '+SubstituiStr(FormatFloat('0.##',VpaPerAliquota),',','.'));
  result := Aux.FieldByName('CODALIQUOTA').AsString;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.WKRadarExportarPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfTexto: TStringList;
  VpfAuxStr: string;
  VpfCodFiscalMunicipio : String;
begin
  //Exporta os clientes para o sistema LISCAL versão 447 for DOS da WK sistemas
  //Dúvidas referente ao layout foram tiradas com o Arno da ERB no dia 17/08/2005 as 16:30
  //Os campos textos tem que vir entre " aspas duplas e os numericos com zero a esquerda, com o separador de campo vírgula
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    VpfCodFiscalMunicipio := RCodigoFiscalMunicipio(RetiraAcentuacao(VpaTabela.FieldByName('C_CID_CLI').AsString),VpaTabela.FieldByName('C_EST_CLI').AsString);
    if VpfCodFiscalMunicipio = '' then
      VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! O município cadastrado "'+VpaTabela.FieldByName('C_CID_CLI').AsString+ '" não existe para o Fisco');

    TextoStatusBar(VpaBarraStatus,'1 Exportando o cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'"');
    VpfAuxStr :=
    //02 -Codigo reduzido do fornecedor / cliente 9(8).
    AdicionaCharE('0',VpaTabela.fieldbyname('I_COD_CLI').AsString, 8) +'"|"'+
    //04 - Nome de fantasia  X(19).
    retiraAcentuacao(VpaTabela.fieldbyname('C_NOM_FAN').AsString) + '"|"'+
    //05 - Razao Social X(47).
    RetiraAcentuacao(VpaTabela.fieldbyname('C_NOM_CLI').AsString) + '"|"'+
    //18 - NUMERO DO CNPJ X(18)
    VpaTabela.fieldbyname('CNPJ_CPF').AsString +'"|"'+
    //06 - Endereço X(47).
    VpaTabela.fieldbyname('C_END_CLI').AsString + '"|"'+
    //07 - Bairro X(31).
    VpaTabela.fieldbyname('C_BAI_CLI').AsString+ '"|"'+
    //08 - Estado X(2).
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_CLI').AsString, 2) + '"|"'+
    //09 - Codigo fiscal do municipio X(6)
    AdicionaCharD(' ',VpfCodFiscalMunicipio, 6) + '"|"'+
    //11 - CEP DO BAIRRO X(9)
    VpaTabela.fieldbyname('C_CEP_CLI').AsString + '"|"'+
    //12 - Numero DDD 9(4)
    AdicionaCharE('0',FunClientes.RDDDCliente(VpaTabela.fieldbyname('C_FO1_CLI').AsString),4) + '"|"'+
    //13 - Telefone X(08)
    AdicionaCharD(' ',FunClientes.RTelefoneSemDDD(VpaTabela.fieldbyname('C_FO1_CLI').AsString),8) + '"|"'+
    //14 - FAX X(08)
    AdicionaCharD(' ',FunClientes.RTelefoneSemDDD(VpaTabela.fieldbyname('C_FON_FAX').AsString),8) + '"|"'+
    //19 - NUMERO DA INSCRICAO ESTADUAL X(18)
    VpaTabela.fieldbyname('C_INS_CLI').AsString +'"|"'+
    //19 - INDICADOR DE AGROPECUARIO
    VpaTabela.fieldbyname('C_IND_AGR').AsString+'"' ;

    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'Pessoas.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.SCISupremaExportaPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfTexto: TStringList;
  VpfAuxStr, VpfTipoPessoa: string;
  VpfCodFiscalMunicipio : String;
begin
  //Exporta os clientes para o sistema SUPREMA Versão 3.02 for DOS da Santa Catarina Informática
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    TextoStatusBar(VpaBarraStatus,'3 Exportando o cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'"');
    VpfCodFiscalMunicipio := RCodigoFiscalMunicipio(RetiraAcentuacao(VpaTabela.FieldByName('C_CID_CLI').AsString),VpaTabela.FieldByName('C_EST_CLI').AsString);
    if VpfCodFiscalMunicipio = '' then
      VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! O município cadastrado "'+VpaTabela.FieldByName('C_CID_CLI').AsString+ '" não existe para o Fisco');
    if VpaTabela.FieldByName('C_TIP_PES').AsString = 'J' then
      VpfTipoPessoa := '0'
    else
      VpfTipoPessoa := '1';

    VpfAuxStr :='"'+
    //01 -Codigo do Cliente
    AdicionaCharE('0',VpaTabela.fieldbyname('I_COD_CLI').AsString, 6) +'",'+
    //02 - Tipo  0-cnpj / 1-cpf
    VpfTipoPessoa+ ',"'+
    //03 - NUMERO DO CNPJ/cpf X(14)
    DeletaChars(DeletaChars(DeletaChars(VpaTabela.fieldbyname('CNPJ_CPF').AsString,'-'),'.'),'/') +'","'+
    //04 - APELIDO DO CLIENTE  X(14).
    CopiaDireita(UpperCase(retiraAcentuacao(VpaTabela.fieldbyname('C_NOM_FAN').AsString)),14) + '","'+
    //05 - Razao Social X(40).
    CopiaDireita(UpperCase(RetiraAcentuacao(VpaTabela.fieldbyname('C_NOM_CLI').AsString)),40) + '","'+
    //06 - Endereço X(40).
    CopiaDireita(UpperCase(VpaTabela.fieldbyname('C_END_CLI').AsString),40) + '","'+
    //07 - COMPLEMENTO X(40).
    CopiaDireita(Uppercase(VpaTabela.fieldbyname('C_COM_END').AsString),40) + '","'+
    //08 - Bairro X(31).
    CopiaDireita(UpperCase(VpaTabela.fieldbyname('C_BAI_CLI').AsString),40) + '","'+
    //09 - CEP DO BAIRRO X(9)
    VpaTabela.fieldbyname('C_CEP_CLI').AsString+ '","'+
    //10 - Codigo fiscal do municipio X(5)
    VpfCodFiscalMunicipio + '","'+
    //11 - Nome do municipio X(31)
    UpperCase(RetiraAcentuacao(CopiaDireita(VpaTabela.fieldbyname('C_CID_CLI').AsString,30))) +'","'+
    //12 - Estado X(2).
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_CLI').AsString, 2) + '","'+
    //13 - TELEFONE DO CLIENTE X(14)
    DeletaChars(DeletaChars(DeletaChars(VpaTabela.fieldbyname('C_FO1_CLI').AsString,'*'),'('),')') + '","'+
    //14 - FAX X(14)
    DeletaChars(DeletaChars(DeletaChars(VpaTabela.fieldbyname('C_FON_FAX').AsString,'*'),'('),')') + '","'+
    //15 - NUMERO DA INSCRICAO ESTADUAL X(18)
    DeletaChars(DeletaChars(DeletaChars(VpaTabela.fieldbyname('C_INS_CLI').AsString,'.'),'-'),'/') +'","'+
    //16 - APELIDO DA CONTA CONTABIL DO CLIENTE PARA INTEGRAÇÃO COM O SISTEMA SUCESSOR
    CopiaDireita(retiraAcentuacao(VpaTabela.fieldbyname('C_NOM_FAN').AsString),14) + '","'+
    //17 - NUMERO DA INSCRICAO MUNICIPAL X(15)
    '' +'"';
    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'CADCLI.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.SCISupremaExportaNotasVpa(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
begin
  SintegraGeraArquivo(VpaCodFilial,VpaDataInicial,VpaDataFinal,VpaDiretorio,VpaBarraStatus,VpaCritica);
end;


{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.TextoStatusBar(VpaStatusBar : TStatusBar;VpaTexto : String);
begin
  VpaStatusBar.Panels[0].Text := VpaTexto;
  VpaStatusBar.refresh;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.MTFiscalExportaPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfTexto: TStringList;
  VpfAuxStr: string;
  VpfCodFiscalMunicipio : String;
begin
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    VpfCodFiscalMunicipio := RCodigoFiscalMunicipio(RetiraAcentuacao(VpaTabela.FieldByName('C_CID_CLI').AsString),VpaTabela.FieldByName('C_EST_CLI').AsString);
    if VpfCodFiscalMunicipio = '' then
      VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! O município cadastrado "'+VpaTabela.FieldByName('C_CID_CLI').AsString+ '" não existe para o Fisco');

    TextoStatusBar(VpaBarraStatus,'4 Exportando o cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'"');
    VpfAuxStr :=
    //Razao social.
    AdicionaCharD(' ',RetiraAcentuacao(VpaTabela.fieldbyname('C_NOM_CLI').AsString),50) + '|'+
    //Tipo Pessoa.
    VpaTabela.fieldbyname('C_TIP_PES').AsString + '|'+
    //nUMERO DO CNPJ X(18)
    AdicionaCharD(' ',VpaTabela.fieldbyname('CNPJ_CPF').AsString, 18) +'|'+
    //Endereço X(47).
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_END_CLI').AsString, 50) + '|'+
    //06 - numero DO Endereço X(47).
    AdicionaCharD(' ',VpaTabela.fieldbyname('I_NUM_END').AsString,10) + '|'+
    //Bairro X(31).
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_BAI_CLI').AsString,40) + '|'+
    //Estado X(2).
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_CLI').AsString, 2) + '|'+
    //Codigo fiscal do municipio X(6)
    AdicionaCharD(' ',VpfCodFiscalMunicipio, 6) + '|'+
    //CEP DO BAIRRO X(9)
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_CEP_CLI').AsString, 9) + '|'+
    //19 - NUMERO DA INSCRICAO ESTADUAL X(18)
    VpaTabela.fieldbyname('C_INS_CLI').AsString;

    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'Pessoas.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.MTFiscalExportarNotas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar);
var
  VpfTexto: TStringList;
  VpfAuxStr, VpfContribuinte, VpfTipoCondicaoPgto,VpfNotaCancelada, VpfTipoFrete, VpfTipoDocumento, VpfModeloDocumento: string;
  VpfIndNotaCancelada : Boolean;
  VpfValTotal, VpfValBase,VpfValIsenta,VpfValIcms,VpfValAliquota, VpfValIPI : Double;
begin
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    TextoStatusBar(VpaBarraStatus,'1 Exportado dados da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    if (VpaTabela.FieldByName('N_TOT_PRO').AsFloat = 0) then
    begin
      VpaTabela.Next;
      continue;
    end;

    if config.EmiteNFe then
    begin
      VpfTipoDocumento := 'NFE';
      VpfModeloDocumento := '55';
    end
    else
    begin
      VpfTipoDocumento := 'NFF';
      VpfModeloDocumento := '1';
    end;
    IF VpaTabela.FieldByName('I_TIP_FRE').AsInteger = 1 then
      VpfTipoFrete := 'C'
    else
      VpfTipoFrete := 'F';

    IF (VpaTabela.FieldByName('C_INS_CLI').AsString = '')or (UpperCase(VpaTabela.FieldByName('C_INS_CLI').AsString)= 'ISENTO') then
      VpfContribuinte := 'N'
    else
      VpfContribuinte := 'S';

    if (VpaTabela.FieldByName('I_COD_PAG').AsInteger = Varia.CondPagtoVista) then
      VpfTipoCondicaoPgto := 'V' // a vista
    else
      VpfTipoCondicaoPgto := 'P';//a prazo
    VpfIndNotaCancelada := (VpaTabela.FieldByName('C_NOT_CAN').AsString = 'S');
    if VpfIndNotaCancelada then
    begin
      VpfValTotal := 0;
      VpfValBase := 0;
      VpfValAliquota :=0;
      VpfValIcms := 0;
      VpfValIPI := 0;
      VpfValIsenta := VpaTabela.fieldbyname('N_BAS_CAL').AsFloat;
      VpfNotaCancelada := 'S';
    end
    else
    begin
      VpfValtotal := VpaTabela.fieldbyname('N_TOT_NOT').AsFloat;
//      VpfValtotal := VpaTabela.fieldbyname('N_TOT_PRO').AsFloat;
//      VpfValtotal := VpaTabela.fieldbyname('N_BAS_CAL').AsFloat;
      VpfValBase := VpfValTotal;
      VpfValIcms := VpaTabela.fieldbyname('N_VLR_ICM').AsFloat;
      VpfValIsenta := VpfValTotal;
      VpfValIpi := VpaTabela.fieldbyname('N_TOT_IPI').AsFloat;
      VpfValAliquota := RAliquotaNota(VpaTabela.FieldByName('I_EMP_FIL').AsInteger,VpaTabela.FieldByName('I_SEQ_NOT').AsInteger);
      VpfNotaCancelada := 'N';
      if VpfValAliquota = 0 then
      begin
        VpfValBase := 0;
      end;
    end;
    VpfAuxStr :=
    //01 - TIPO DE OPERACAO 1 X(1)
    '"1","0001","'+
    // CNPJ DA FILIAL (CNPJ) X(18)
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_CGC_FIL').AsString, 18) + '","'+
    // FORNCEDOR CLIENTE (CNPJ) X(18)
    AdicionaCharD(' ',VpaTabela.fieldbyname('CNPJ_CPF').AsString, 18) + '","'+
    // CODIGO DA NATUREZA x(12)
    CopiaAteChar(VpaTabela.FieldByName('C_COD_NAT').AsString,'/') + '","'+
    //NUMERO INICIO
    VpaTabela.fieldbyname('I_NRO_NOT').AsString + '","'+
    //NUMERO FIM
    VpaTabela.fieldbyname('I_NRO_NOT').AsString + '","'+
    //MODELO DO DOCUMENTO
    VpfModeloDocumento+ '","'+
    // ESPECIE DO DOCUMENTO X(3)
    VpfTipoDocumento +'","'+
    // SERIE DO DOCUMENTO X(3)
    VpaTabela.fieldbyname('C_SER_NOT').AsString  +'","' +
    // CHAVE NFE X(3)
    VpaTabela.fieldbyname('C_CHA_NFE').AsString  +'","' +
    //DATA DE ENTRADA DO DOCUMENTO X(8)
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) + '","'+
    //DATA DE EMISSAO DO DOCUMENTO X(8)
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) + '","'+
    //ESTADO DE DESTINO (SIGLA)
    VpaTabela.FieldByName('C_EST_CLI').AsString +'","'+
    //ESTADO DE ORIGEM (SIGLA)
    VpaTabela.FieldByName('C_EST_FIL').AsString+'","'+
    //CONTRIBUINTE  (S/N)
    AdicionaCharD('S',VpfContribuinte, 1) +'","'+
    // NOTA CANCELADA
    AdicionaCharD('S',VpfNotaCancelada, 1) +'","'+
    // TIPO PAGAMENTO V-AVISTA P - PRAZO
    AdicionaCharD(' ',VpfTipoCondicaoPgto,1) +'","'+
    //TIPO DE FRETE 1 -CIF, 2 -FOB, 3 -OUTROS
    AdicionaCharD(' ',VpfTipoFrete,1) +'","'+
    //ALIQUOTA DE ICMS 9(6)v99
    SubstituiStr(FormatFloat('0.00',VpfValAliquota),',','.') +'","'+
    //VALOR CONTABIL 9(14)v99
    SubstituiStr(FormatFloat('0.00',VpfValTotal),',','.') +'","'+
    // BASE DE CALCULO DO PRIMEIRO IMPOSTO /ICMS
    SubstituiStr(FormatFloat('0.00',VpfValBase),',','.') +'","'+
    //VALOR DO IMPOSTO
    SubstituiStr(FormatFloat('0.00',VpfValIcms),',','.') +'","'+
    //VALOR DE ISENTAS
    SubstituiStr(FormatFloat('0.00',VpfValIsenta),',','.') +'","'+
    // VALOR DE OUTRAS
    '0.00' +'","'+
    // VALOR IPI EMBUTIDO NA NOTA
    '0.00' +'","'+
    // BASE CALCULO IPI
    '0.00' +'","'+
    // VALOR IPI
    SubstituiStr(FormatFloat('0.00',VpfValIPI),',','.') +'","'+
    // VALOR DE ISENTAS DO IPI
    SubstituiStr(FormatFloat('0.00',VpfValTotal),',','.') +'","'+
    // VALOR DE OUTROS DO IPI
    '0.00' +'","'+
    // VALOR DE REDUCAO DO IPI
    '0.00"';
    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'Produtos.txt');
  VpfTexto.Clear;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    TextoStatusBar(VpaBarraStatus,'1 Exportado dados da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    if not ExistePalavra(VpaTabela.FieldByName('C_COD_NAT').AsString,'5933') then
    begin
      VpaTabela.Next;
      continue;
    end;

    IF VpaTabela.FieldByName('I_TIP_FRE').AsInteger = 1 then
      VpfTipoFrete := 'C'
    else
      VpfTipoFrete := 'F';

    IF (VpaTabela.FieldByName('C_INS_CLI').AsString = '')or (UpperCase(VpaTabela.FieldByName('C_INS_CLI').AsString)= 'ISENTO') then
      VpfContribuinte := 'N'
    else
      VpfContribuinte := 'S';

    if (VpaTabela.FieldByName('I_COD_PAG').AsInteger = Varia.CondPagtoVista) then
      VpfTipoCondicaoPgto := 'V' // a vista
    else
      VpfTipoCondicaoPgto := 'P';//a prazo
    VpfIndNotaCancelada := (VpaTabela.FieldByName('C_NOT_CAN').AsString = 'S');
    if VpfIndNotaCancelada then
    begin
      VpfValTotal := 0;
      VpfValBase := 0;
      VpfValAliquota :=0;
      VpfValIcms := 0;
      VpfValIPI := 0;
      VpfNotaCancelada := 'S';
    end
    else
    begin
      VpfValtotal := VpaTabela.fieldbyname('N_TOT_SER').AsFloat;
      VpfValBase := VpaTabela.fieldbyname('N_TOT_SER').AsFloat;
      VpfValIcms := VpaTabela.fieldbyname('N_VLR_ISQ').AsFloat;
      VpfValIpi := 0;
      VpfValAliquota := VpaTabela.FieldByName('N_PER_ISQ').AsFloat;
      VpfNotaCancelada := 'N';
    end;
    VpfAuxStr :=
    //01 - TIPO DE OPERACAO 1 X(1)
    '"1","0001","'+
    // CNPJ DA FILIAL (CNPJ) X(18)
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_CGC_FIL').AsString, 18) + '","'+
    // FORNCEDOR CLIENTE (CNPJ) X(18)
    AdicionaCharD(' ',VpaTabela.fieldbyname('CNPJ_CPF').AsString, 18) + '","'+
    // CODIGO DA NATUREZA x(12)
    '8000","'+
    //NUMERO INICIO
    VpaTabela.fieldbyname('I_NRO_NOT').AsString + '","'+
    //NUMERO FIM
    VpaTabela.fieldbyname('I_NRO_NOT').AsString + '","'+
    //MODELO DO DOCUMENTO
    '1","'+
    // ESPECIE DO DOCUMENTO X(3)
    'NFF' +'","'+
    // SERIE DO DOCUMENTO X(3)
    VpaTabela.fieldbyname('C_SER_NOT').AsString  +'","' +
    //DATA DE ENTRADA DO DOCUMENTO X(8)
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) + '","'+
    //DATA DE EMISSAO DO DOCUMENTO X(8)
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) + '","'+
    //ESTADO DE DESTINO (SIGLA)
    VpaTabela.FieldByName('C_EST_CLI').AsString +'","'+
    //ESTADO DE ORIGEM (SIGLA)
    VpaTabela.FieldByName('C_EST_FIL').AsString+'","'+
    //CONTRIBUINTE  (S/N)
    AdicionaCharD('S',VpfContribuinte, 1) +'","'+
    // NOTA CANCELADA
    AdicionaCharD('S',VpfNotaCancelada, 1) +'","'+
    // TIPO PAGAMENTO V-AVISTA P - PRAZO
    AdicionaCharD(' ',VpfTipoCondicaoPgto,1) +'","'+
    //TIPO DE FRETE 1 -CIF, 2 -FOB, 3 -OUTROS
    AdicionaCharD(' ',VpfTipoFrete,1) +'","'+
    //ALIQUOTA DE ICMS 9(6)v99
    SubstituiStr(FormatFloat('0.00',VpfValAliquota),',','.') +'","'+
    //VALOR CONTABIL 9(14)v99
    SubstituiStr(FormatFloat('0.00',VpfValTotal),',','.') +'","'+
    // BASE DE CALCULO DO PRIMEIRO IMPOSTO /ICMS
    SubstituiStr(FormatFloat('0.00',VpfValBase),',','.') +'","'+
    //VALOR DO IMPOSTO
    SubstituiStr(FormatFloat('0.00',VpfValIcms),',','.') +'","'+
    //VALOR DE ISENTAS
    '0.00' +'","'+
    // VALOR DE OUTRAS
    '0.00' +'","'+
    // VALOR IPI EMBUTIDO NA NOTA
    '0.00' +'","'+
    // BASE CALCULO IPI
    '0.00' +'","'+
    // VALOR IPI
    SubstituiStr(FormatFloat('0.00',VpfValIPI),',','.') +'","'+
    // VALOR DE ISENTAS DO IPI
    '0.00' +'","'+
    // VALOR DE OUTROS DO IPI
    '0.00' +'","'+
    // VALOR DE REDUCAO DO IPI
    '0.00"';
    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.savetofile(VpaDiretorio + 'Servicos.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdicionaRegistro10e11(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaArquivo : TStringList);
var
  VpfLinha : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADFILIAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial));
  VpfLinha := '10'+
  //CGC
  DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_FIL').AsString,'.'),'/'),'-')+
  //INSCRICAO ESTADUAL
  AdicionaCharD(' ',DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_FIL').AsString,'.'),'-'),14)+
  //NOME DO CONTRIBUINTE
  AdicionaCharD(' ',COPY(Tabela.FieldByName('C_NOM_FIL').AsString,1,35),35)+
  //MUNICIPIO
  AdicionaCharD(' ',COPY(Tabela.FieldByName('C_CID_FIL').AsString,1,30),30)+
  //UNIDADE DE FEDERACAO
  AdicionaCharD(' ',Tabela.FieldByName('C_EST_FIL').AsString,2)+
  //FAX
  AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(COPY(Tabela.FieldByName('C_FON_FIL').AsString,5,15),')'),' '),'-'),10)+
  //DATA INICIAL
  FormatDateTime('YYYYMMDD',VpaDatInicial)+
  //DATA FINAL
  FormatDateTime('YYYYMMDD',VpaDatFinal)+
  //CODIGO DO CONVENIO
  '3'+
  //CODIGO DA IDENTIFICACAO DAS NATUREZAS INFORMADAS
  '3'+
  //CODIGO DA FINALIDADE DO ARQUIVO MAGNETICO
  '1';
  VpaArquivo.Add(VpfLinha);

  //registro 11
  VpfLinha := '11'+
  //Logradouro
  AdicionaCharD(' ',copy(Tabela.FieldByName('C_END_FIL').AsString,1,34),34)+
  //NUMERO
  AdicionaCharE('0',Tabela.FieldByName('I_NUM_FIL').AsString,5)+
  //COMPLEMENTO
  AdicionaCharD(' ','',22)+
  //BAIRRO
  AdicionaCharD(' ',Tabela.FieldByName('C_BAI_FIL').AsString,15)+
  //CEP
  AdicionaCharE('0',Tabela.FieldByName('I_CEP_FIL').AsString,8)+
  //NOME DE CONTATO
  AdicionaCharD(' ',Tabela.FieldByName('C_DIR_FIL').AsString,28)+
  //TELEFONE CONTATO
  AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(COPY(Tabela.FieldByName('C_FAX_FIL').AsString,5,15),')'),' '),'-'),12);
  VpaArquivo.Add(VpfLinha);

  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdiconaRegistro50(VpaTabela : TDataSet;VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
var
  VpfInscricaoEstadual : String;
  VpfLinha : String;
begin
  VpaQtdRegistros := 0;
  VpaTabela.First;
  While not VpaTabela.Eof do
  begin
    inc(VpaQtdRegistros);
    TextoStatusBar(VpaBarraStatus,'4 Validando a inscrição estadual');
    VpfInscricaoEstadual := DeletaChars(DeletaChars(DeletaChars(VpaTabela.FieldByName('C_INS_CLI').AsString,'.'),'-'),'/');
    if (VpfInscricaoEstadual = '') or (VpaTabela.FieldByName('C_TIP_PES').AsString = 'F') then
      VpfInscricaoEstadual := 'ISENTO';
    if (VpaTabela.FieldByName('C_TIP_PES').AsString = 'F') then
    begin
      if not VerificaCPF(VpaTabela.FieldByName('CNPJ_CPF').AsString) then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! CPF inválida');
    end
    else
    begin
      if not VerificarIncricaoEstadual(VpfInscricaoEstadual,VpaTabela.FieldByName('C_EST_CLI').AsString,false,true) then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual inválida');
      if VpfInscricaoEstadual = VpaInscricaoFilial then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual é a mesma da "'+varia.NomeFilial+'"');
    end;

    TextoStatusBar(VpaBarraStatus,'4 Inserindo registro 50 da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    //codigo do registro
    VpfLinha := '50'+
    //cnpj destinatario
    AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(VpaTabela.FieldByName('CNPJ_CPF').AsString,'.'),'/'),'-'),14)+
    //INSCRICAO ESTADUAL
    AdicionaCharD(' ',VpfInscricaoEstadual,14)+
    //DATA DE EMISSAO
    FormatDateTime('YYYYMMDD',VpaTabela.FieldByName('D_DAT_EMI').AsDateTime)+
    //UNIDADE DE FEDERACAO
    AdicionaCharD(' ',VpaTabela.FieldByName('C_EST_CLI').AsString,2)+
    //MODELO
    '01'+
    //SERIE DA NOTA
    AdicionaCharD(' ',VpaTabela.FieldByName('C_SER_NOT').AsString,3)+
    //NUMERO DA NOTA FISCAL
    AdicionaCharE('0',VpaTabela.FieldByName('I_NRO_NOT').AsString,6)+
    //CFOP
    AdicionaCharE('0',COPY(VpaTabela.FieldByName('C_COD_NAT').AsString,1,4),4)+
    //EMITENTE DA NOTA FISCAL
    'P'+
    //VALOR TOTAL
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_TOT_NOT').AsFloat),','),13)+
    //BASE DE CALCULO DO ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_BAS_CAL').AsFloat),','),13)+
    //VALOR DO ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_VLR_ICM').AsFloat),','),13)+
    // ISENTA OU NÃO TRIBUTADA
    AdicionaCharE('0','0',13)+
    // OUTRAS
    AdicionaCharE('0','0',13)+
    //ALIQUOTA
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',RAliquotaNota(VpaTabela.FieldByName('I_EMP_FIL').AsInteger,VpaTabela.FieldByName('I_SEQ_NOT').AsInteger)),','),4)+
   //SITUACAO DA NOTA FISCAL
    AdicionaCharE('N',VpaTabela.FieldByName('C_NOT_CAN').AsString,1);
    VpaArquivo.Add(VpfLinha);

    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdiconaRegistro51(VpaTabela : TDataSet; VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
var
  VpfInscricaoEstadual : String;
  VpfLinha : String;
begin
  VpaQtdRegistros := 0;
  VpaTabela.First;
  While not VpaTabela.Eof do
  begin
    inc(VpaQtdRegistros);
    TextoStatusBar(VpaBarraStatus,'4 Validando a inscrição estadual');
    VpfInscricaoEstadual := DeletaChars(DeletaChars(DeletaChars(VpaTabela.FieldByName('C_INS_CLI').AsString,'.'),'-'),'/');
    if (VpfInscricaoEstadual = '') or (VpaTabela.FieldByName('C_TIP_PES').AsString = 'F') then
      VpfInscricaoEstadual := 'ISENTO';
    if (VpaTabela.FieldByName('C_TIP_PES').AsString = 'F') then
    begin
      if not VerificaCPF(VpaTabela.FieldByName('CNPJ_CPF').AsString) then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! CPF inválida');
    end
    else
    begin
      if not VerificarIncricaoEstadual(VpfInscricaoEstadual,VpaTabela.FieldByName('C_EST_CLI').AsString,false,true) then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual inválida');
      if VpfInscricaoEstadual = VpaInscricaoFilial then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual é a mesma da "'+varia.NomeFilial+'"');
    end;
    TextoStatusBar(VpaBarraStatus,'3 Inserindo registro 51 da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    //codigo do registro
    VpfLinha := '51'+
    //cnpj destinatario
    AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(VpaTabela.FieldByName('CNPJ_CPF').AsString,'.'),'/'),'-'),14)+
    //INSCRICAO ESTADUAL
    AdicionaCharD(' ',VpfInscricaoEstadual,14)+
    //DATA DE EMISSAO
    FormatDateTime('YYYYMMDD',VpaTabela.FieldByName('D_DAT_EMI').AsDateTime)+
    //UNIDADE DE FEDERACAO
    AdicionaCharD(' ',VpaTabela.FieldByName('C_EST_CLI').AsString,2)+
    //SERIE DA NOTA
    AdicionaCharD(' ',VpaTabela.FieldByName('C_SER_NOT').AsString,3)+
    //NUMERO DA NOTA FISCAL
    AdicionaCharE('0',VpaTabela.FieldByName('I_NRO_NOT').AsString,6)+
    //CFOP
    AdicionaCharE('0',COPY(VpaTabela.FieldByName('C_COD_NAT').AsString,1,4),4)+
    //VALOR TOTAL
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_TOT_NOT').AsFloat),','),13)+
    //VALOR DO IPI
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_TOT_IPI').AsFloat),','),13)+
    // ISENTA OU NÃO TRIBUTADA
    AdicionaCharE('0','0',13)+
    // OUTRAS
    AdicionaCharE('0','0',13)+
    //BRANCOS 20
    AdicionaCharE(' ','',20)+
   //SITUACAO DA NOTA FISCAL
    AdicionaCharE('N',VpaTabela.FieldByName('C_NOT_CAN').AsString,1);
    VpaArquivo.Add(VpfLinha);
    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdiconaRegistro53(VpaTabela : TDataSet; VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
var
  VpfInscricaoEstadual : String;
  VpfLinha : String;
begin
  VpaQtdRegistros := 0;
  VpaTabela.First;
  While not VpaTabela.Eof do
  begin
    inc(VpaQtdRegistros);
    TextoStatusBar(VpaBarraStatus,'4 Validando a inscrição estadual');
    VpfInscricaoEstadual := DeletaChars(DeletaChars(DeletaChars(VpaTabela.FieldByName('C_INS_CLI').AsString,'.'),'-'),'/');
    if (VpfInscricaoEstadual = '') or (VpaTabela.FieldByName('C_TIP_PES').AsString = 'F') then
      VpfInscricaoEstadual := 'ISENTO';
    if (VpaTabela.FieldByName('C_TIP_PES').AsString = 'F') then
    begin
      if not VerificaCPF(VpaTabela.FieldByName('CNPJ_CPF').AsString) then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! CPF inválida');
    end
    else
    begin
      if not VerificarIncricaoEstadual(VpfInscricaoEstadual,VpaTabela.FieldByName('C_EST_CLI').AsString,false,true) then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual inválida');
      if VpfInscricaoEstadual = VpaInscricaoFilial then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! Inscrição estadual é a mesma da "'+varia.NomeFilial+'"');
    end;
    TextoStatusBar(VpaBarraStatus,'3 Inserindo registro 53 da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    //codigo do registro
    VpfLinha := '53'+
    //cnpj destinatario
    AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(VpaTabela.FieldByName('CNPJ_CPF').AsString,'.'),'/'),'-'),14)+
    //INSCRICAO ESTADUAL
    AdicionaCharD(' ',VpfInscricaoEstadual,14)+
    //DATA DE EMISSAO
    FormatDateTime('YYYYMMDD',VpaTabela.FieldByName('D_DAT_EMI').AsDateTime)+
    //UNIDADE DE FEDERACAO
    AdicionaCharD(' ',VpaTabela.FieldByName('C_EST_CLI').AsString,2)+
    //MODELO
    '01'+
    //SERIE DA NOTA
    AdicionaCharD(' ',VpaTabela.FieldByName('C_SER_NOT').AsString,3)+
    //NUMERO DA NOTA FISCAL
    AdicionaCharE('0',VpaTabela.FieldByName('I_NRO_NOT').AsString,6)+
    //CFOP
    AdicionaCharE('0',COPY(VpaTabela.FieldByName('C_COD_NAT').AsString,1,4),4)+
    //EMITENTE DA NOTA FISCAL
    'P'+
    //BASE DE CALCULO DO ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_BAS_CAL').AsFloat),','),13)+
    //VALOR DO ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_VLR_ICM').AsFloat),','),13)+
    //DESPESAS ACESSORIAS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_VLR_FRE').AsFloat+VpaTabela.FieldByName('N_VLR_SEG').AsFloat+VpaTabela.FieldByName('N_OUT_DES').AsFloat),','),13)+
   //SITUACAO DA NOTA FISCAL
    AdicionaCharE('N',VpaTabela.FieldByName('C_NOT_CAN').AsString,1)+
    //Codigo da antecipacao
    ''+
    //BRANCOS
    AdicionaCharE(' ','',29);
    VpaArquivo.Add(VpfLinha);
    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdiconaRegistro54(VpaTabela : TDataSet; VpaInscricaoFilial : String;Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
var
  VpfLinha : String;
begin
  VpaQtdRegistros := 0;
  VpaTabela.First;
  While not VpaTabela.Eof do
  begin
    if (VpaTabela.FieldByName('C_TIP_PES').AsString = 'F') then
    begin
      if not VerificaCPF(VpaTabela.FieldByName('CNPJ_CPF').AsString) then
        VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! CPF inválida');
    end;
    TextoStatusBar(VpaBarraStatus,'3 Inserindo registro 54 da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    AdicionaSQLAbreTabela(Produtos,'Select MOV.C_COD_CST,  MOV.I_SEQ_MOV,  MOV.C_COD_PRO,  MOV.N_QTD_PRO, MOV.N_VLR_PRO, '+
                                   ' MOV.N_VLR_IPI, MOV.N_PER_ICM, MOV.N_TOT_PRO ' +
                                   ' from MOVNOTASFISCAIS MOV '+
                                   ' Where MOV.I_EMP_FIL = '+VpaTabela.FieldByname('I_EMP_FIL').AsString +
                                   ' and MOV.I_SEQ_NOT = '+VpaTabela.FieldByname('I_SEQ_NOT').AsString +
                                   ' ORDER BY MOV.I_SEQ_MOV ');
    While not Produtos.eof do
    begin
      inc(VpaQtdRegistros);
      //codigo do registro
      VpfLinha := '54'+
      //cnpj destinatario
      AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(VpaTabela.FieldByName('CNPJ_CPF').AsString,'.'),'/'),'-'),14)+
      //MODELO
      '01'+
      //SERIE DA NOTA
      AdicionaCharD(' ',VpaTabela.FieldByName('C_SER_NOT').AsString,3)+
      //NUMERO DA NOTA FISCAL
      AdicionaCharE('0',VpaTabela.FieldByName('I_NRO_NOT').AsString,6)+
      //CFOP
      AdicionaCharE('0',COPY(VpaTabela.FieldByName('C_COD_NAT').AsString,1,4),4)+
      //CST
      AdicionaCharE('0',COPY(Produtos.FieldByName('C_COD_CST').AsString,1,3),3)+
      //NUMERO DO ITEM
      AdicionaCharE('0',COPY(Produtos.FieldByName('I_SEQ_MOV').AsString,1,3),3)+
      //CODIGO DO PRODUTO OU SERVICO
      AdicionaCharD(' ',COPY(Produtos.FieldByName('C_COD_PRO').AsString,1,14),14)+
      //QTD PRODUTO
      AdicionaCharE('0',DeletaChars(FormatFloat('0.000',Produtos.FieldByName('N_QTD_PRO').AsFloat),','),11)+
      //VALOR DO PRODUTO
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Produtos.FieldByName('N_VLR_PRO').AsFloat),','),12)+
      //VALOR DO DESCONTO / DESPESA ACESSORIA
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),12)+
      //BASE DE CALCULO DO ICMS
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Produtos.FieldByName('N_TOT_PRO').AsFloat),','),12)+
      //BASE DE CALCULO PARA ICMS SUBSTITUICAO TRIBUTARIA
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),12)+
      //VALOR DO IPI
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Produtos.FieldByName('N_VLR_IPI').AsFloat),','),12)+
      //ALIQUOTA ICMS
      AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Produtos.FieldByName('N_PER_ICM').AsFloat),','),4);
      VpaArquivo.Add(VpfLinha);
      Produtos.next;
    end;
    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdiconaRegistro50e51e53e54(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar;Var VpaQtdRegistro50, VpaQtdRegistro51, VpaQtdRegistro53, VpaQtdRegistro54 : Integer);
var
  VpfInscricaoEstadualFilial : String;
begin
  VpfInscricaoEstadualFilial := RInscricaoEstadualFilial(VpaCodFilial);

  TextoStatusBar(VpaBarraStatus,'4 Localizando as notas fiscais');
  LocalizaNotasExportacao(Tabela,VpaCodFilial,VpaDatInicial,VpaDatFinal,VpaUF);

  ValidaPRAdiconaRegistro50(Tabela,VpfInscricaoEstadualFilial,VpaQtdRegistro50,VpaArquivo,VpaCritica,VpaBarraStatus);
  ValidaPRAdiconaRegistro51(Tabela,VpfInscricaoEstadualFilial,VpaQtdRegistro51,VpaArquivo,VpaCritica,VpaBarraStatus);
  ValidaPRAdiconaRegistro53(Tabela,VpfInscricaoEstadualFilial,VpaQtdRegistro53,VpaArquivo,VpaCritica,VpaBarraStatus);
  ValidaPRAdiconaRegistro54(Tabela,VpfInscricaoEstadualFilial,VpaQtdRegistro54,VpaArquivo,VpaCritica,VpaBarraStatus);
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdicionaRegistro74(VpaTabela : TDataSet; VpaDatInventario : TDateTime; Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
var
  VpfLinha : String;
begin
  VpaQtdRegistros := 0;
  VpaTabela.First;
  While not VpaTabela.Eof do
  begin
    inc(VpaQtdRegistros);
    TextoStatusBar(VpaBarraStatus,'4 Registro 74 Exportando produto '+VpaTabela.FieldByname('C_COD_PRO').AsString);
    //codigo do registro
    VpfLinha := '74'+
    //DATA DO EMISSAO
    FormatDateTime('YYYYMMDD',VpaDatInventario)+
      //CODIGO DO PRODUTO OU SERVICO
    AdicionaCharD(' ',COPY(VpaTabela.FieldByName('C_COD_PRO').AsString,1,14),14)+
    //QUANTIDADE PRODUTO
    AdicionaCharE('0',DeletaChars(FormatFloat('0.000',VpaTabela.FieldByName('N_QTD_PRO').AsFloat),','),13)+
    //VALOR BRUTO DO PRODUTO
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',(VpaTabela.FieldByName('N_QTD_PRO').AsFloat * VpaTabela.FieldByName('N_VLR_CUS').AsFloat)),','),13)+
    //CODIGO DA POSSE DA MERCADORIA
    '1'+
    //CNPJ DO POSSUIDOR DO PRODUTO
    '00000000000000'+
    //INSCRICAO ESTADUAL DO POSSUIDOR
    '              '+
    //UF DO POSSUIDOR
    '  '+
    AdicionaCharD(' ','',45);
    VpaArquivo.Add(VpfLinha);
//    VpaArquivo.Add(IntToStr(VpaArquivo.Count+1)+ ' '+ VpfLinha);
    VpaTabela.next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdicionaRegistro75(VpaTabela : TDataSet; VpaDatInicial, VpaDatFinal : TDateTime; Var VpaQtdRegistros : Integer; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
var
  VpfICMSPadrao, VpfValICMSREducao, vpfValICMSINternoUFDestino : Double;
  VpfIndSubstituicaoTributaria : boolean;
  VpfLinha : String;
begin
  FunNotaFiscal.CarValICMSPadrao(VpfICMSPadrao,vpfValICMSINternoUFDestino, VpfValICMSREducao, Varia.UFFilial,'',TRUE,FALSE,VpfIndSubstituicaoTributaria);

  VpaQtdRegistros := 0;
  VpaTabela.First;
  While not VpaTabela.Eof do
  begin
    inc(VpaQtdRegistros);
    TextoStatusBar(VpaBarraStatus,'4 Registro 75 Exportando produto '+VpaTabela.FieldByname('C_COD_PRO').AsString);
    //codigo do registro
    VpfLinha := '75'+
    //DATA INICIAL
    FormatDateTime('YYYYMMDD',VpaDatInicial)+
    //DATA FINAL
    FormatDateTime('YYYYMMDD',VpaDatFinal)+
    //CODIGO DO PRODUTO OU SERVICO
    AdicionaCharD(' ',COPY(VpaTabela.FieldByName('C_COD_PRO').AsString,1,14),14)+
    //CODIGO NCM
    AdicionaCharD(' ','AB',8)+
    //NOME DO PRODUTO
    AdicionaCharD(' ',VpaTabela.FieldByName('C_NOM_PRO').AsString,53)+
    //UM DO PRODUTO
    AdicionaCharD(' ',VpaTabela.FieldByName('C_COD_UNI').AsString,6)+
    //ALIQUOTA DE IPI
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_PER_IPI').AsFloat),','),5)+
    //ALIQUOTA DE ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfICMSPadrao ),','),4)+
    //REDUCAO DE ICMS
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByName('N_RED_ICM').AsFloat),','),5)+
    //BASE DE CALCULO DO ICMS SUBSTITUICAO
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),13);
    VpaArquivo.add(VpfLinha);
    VpaTabela.next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdicionaRegistro74e75(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar;Var VpaQtdRegistro74, VpaQtdRegistro75 : Integer);
var
  VpfQtdRegistros : Integer;
begin
  TextoStatusBar(VpaBarraStatus,'4 Localizando as notas fiscais');
  LocalizaProdutosExportacao(Tabela,VpaCodFilial,VpaDatInicial,VpaDatFinal,VpaUF);

  ValidaPRAdicionaRegistro74(Tabela,VpaDatInicial,VpaQtdRegistro74,VpaArquivo,VpaCritica,VpaBarraStatus);
  ValidaPRAdicionaRegistro75(Tabela,VpaDatInicial,VpaDatFinal, VpaQtdRegistro75,VpaArquivo,VpaCritica,VpaBarraStatus);

end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdiconaRegistro60Me60Ae60R(VpaCodFilial : Integer;VpaDatInicial,VpaDatFinal : TDateTime; VpaUF : String; VpaArquivo, VpaCritica : TStringList;VpaBarraStatus : TStatusBar);
begin

end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdicionaRegistro90porTipo(VpaQtdRegistro,VpaTipoRegistro : Integer;VpaCNPJ,VpaInscricaoEstadual : String; VpaArquivo : TStringList);
begin

end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRAdicionaRegistro90(VpaCNPJ, VpaInscricaoEstadual : String;VpaQtdRegistro50, VpaQtdRegistro51,VpaQtdRegistro53,VpaQtdRegistro54,VpaQtdRegistro74,VpaQtdRegistro75 : Integer;VpaArquivo: TStringList);
begin
  VpaArquivo.add('90'+
  //cnpj destinatario
  AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(VpaCNPJ,'.'),'/'),'-'),14)+
  //INSCRICAO ESTADUAL
  AdicionaCharD(' ',DeletaChars(DeletaChars(DeletaChars(VpaInscricaoEstadual,'.'),'/'),'-'),14)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0','50',2)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0',IntToStr(VpaQtdRegistro50),8)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0','51',2)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0',IntToStr(VpaQtdRegistro51),8)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0','53',2)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0',IntToStr(VpaQtdRegistro53),8)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0','54',2)+
    //TIPO A SER TOTALIZADO
  AdicionaCharE('0',IntToStr(VpaQtdRegistro54),8)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0','60',2)+
    //TIPO A SER TOTALIZADO
  AdicionaCharE('0','3',8)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0','74',2)+
    //TIPO A SER TOTALIZADO
  AdicionaCharE('0',IntToStr(VpaQtdRegistro74),8)+
  //TIPO A SER TOTALIZADO
  AdicionaCharE('0','75',2)+
    //TIPO A SER TOTALIZADO
  AdicionaCharE('0',IntToStr(VpaQtdRegistro75),8)+
    //TIPO A SER TOTALIZADO
  AdicionaCharE('0','99',2)+
    //TIPO A SER TOTALIZADO
  AdicionaCharE('0',IntToStr(VpaArquivo.Count+1),8)+

   //QUANTIDDE DE REGISTRO 90
   AdicionaCharE(' ','',15)+

    '1');
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaPRExportaNotas(VpaTabela : TDataSet;VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDatetime; VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfArquivo : TStringList;
  VpfDFilial : TRBDFilial;
  VpfQtdRegistro50, VpfQtdRegistro51,VpfQtdRegistro53,VpfQtdRegistro54,VpfQtdRegistro74,VpfQtdRegistro75 : Integer;
begin
  VpfArquivo := TStringList.create;
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,VpaCodFilial);
  TextoStatusBar(VpaBarraStatus,'7 Adicionando registro 10');
  ValidaPRAdicionaRegistro10e11(VpaCodFilial,VpaDatInicio,VpaDatFim, VpfArquivo);
  ValidaPRAdiconaRegistro50e51e53e54(VpaCodFilial,VpaDatInicio,VpaDatFim,'',VpfArquivo,VpaCritica,VpaBarraStatus,VpfQtdRegistro50,VpfQtdRegistro51,VpfQtdRegistro53,VpfQtdRegistro54);
  ValidaPRAdicionaRegistro74e75(VpaCodFilial,VpaDatInicio,VpaDatFim,'',VpfArquivo,VpaCritica,VpaBarraStatus,VpfQtdRegistro74,VpfQtdRegistro75);

  ValidaPRAdicionaRegistro90(VpfDFilial.DesCNPJ,VpfDFilial.DesInscricaoEstadual,VpfQtdRegistro50,VpfQtdRegistro51,VpfQtdRegistro53,VpfQtdRegistro54,VpfQtdRegistro74,VpfQtdRegistro75,VpfArquivo);

  VpfArquivo.SaveToFile(VpaDiretorio+InttoStr(Ano(VpaDatInicio))+AdicionaCharE('0',InttoStr(Mes(VpaDatFim)),2)+'.txt');
  VpfDFilial.free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.DominioExportarPessoas(VpaTabela : TDataSet;VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfTexto: TStringList;
  VpfAuxStr: string;
  VpfCodFiscalMunicipio,VpfTipInscricao : String;
begin
  VpfTexto := TStringList.Create;

  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    VpfCodFiscalMunicipio := RCodigoFiscalMunicipio(RetiraAcentuacao(VpaTabela.FieldByName('C_CID_CLI').AsString),VpaTabela.FieldByName('C_EST_CLI').AsString);
    if VpfCodFiscalMunicipio = '' then
      VpaCritica.Add('Cadastro do Cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'" incorreto!!! O município cadastrado "'+VpaTabela.FieldByName('C_CID_CLI').AsString+ '" não existe para o Fisco');
    if VpaTabela.FieldByname('C_TIP_PES').AsString = 'F' then
      VpfTipInscricao := '2'
    else
      VpfTipInscricao := '1';

    TextoStatusBar(VpaBarraStatus,'1 Exportando o cliente "'+VpaTabela.FieldByName('I_COD_CLI').AsString+'"');
    VpfAuxStr :=
   //fixo 22- clientes
    '22'+
    //Codigo reduzido do fornecedor / cliente numerico7.
    AdicionaCharE('0',IntToStr(varia.CodClienteExportacaoFiscal), 7)+
    //Sigla estado
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_EST_CLI').AsString, 2) +
    //Codigo da conta
    AdicionaCharE('0',IntToStr(varia.ContaContabilCliente), 7)+
    //Codigo fiscal do municipio 9(7)
    AdicionaCharE('0',VpfCodFiscalMunicipio, 7) +
    //Nome reduzido
    AdicionacharD(' ',copy(retiraAcentuacao(VpaTabela.fieldbyname('C_NOM_FAN').AsString),1,10),10) +
    //nome do cliente
    AdicionacharD(' ',copy(retiraAcentuacao(VpaTabela.fieldbyname('C_NOM_CLI').AsString),1,40),40) +
    //endereco
    AdicionacharD(' ',copy(VpaTabela.fieldbyname('C_END_CLI').AsString,1,40),40) +
    //numero endereco
    AdicionacharE('0',VpaTabela.fieldbyname('I_NUM_END').AsString,7) +
    //brancos
    AdicionacharD(' ','',30) +
    //cep
    VpaTabela.fieldbyname('C_CEP_CLI').AsString +
    //cnpj
    AdicionacharD(' ',DeletaChars(DeletaChars(DeletaChars(VpaTabela.fieldbyname('CNPJ_CPF').AsString,'.'),'-'),'/'),14) +
    //NUMERO DA INSCRICAO ESTADUAL
    AdicionacharD(' ',VpaTabela.fieldbyname('C_INS_CLI').AsString,20)+
    //Telefone
    AdicionaCharD(' ',FunClientes.RTelefoneSemDDD(VpaTabela.fieldbyname('C_FO1_CLI').AsString),14) +
    //FAX
    AdicionaCharD(' ',FunClientes.RTelefoneSemDDD(VpaTabela.fieldbyname('C_FON_FAX').AsString),14) +
    //INDICADOR DE AGROPECUARIO
    VpaTabela.fieldbyname('C_IND_AGR').AsString+
    //ICMS
    'S'+
    //tipo inscricao
    VpfTipInscricao +
    //inscricao municipal+
    AdicionacharD(' ','',20) +
    //bairro
    AdicionacharD(' ',copy(retiraAcentuacao(VpaTabela.fieldbyname('C_BAI_CLI').AsString),1,20),20) +
    //Numero DDD
    AdicionaCharE('0',copy(FunClientes.RDDDCliente(VpaTabela.fieldbyname('C_FO1_CLI').AsString),1,4),4) +
    //Aliquota icms
    AdicionaCharE('0','0',5) +
    //codigo do pais
    AdicionaCharE('0','0',7) +
    //suframa
    AdicionaCharD(' ','',9) +
    //suframa
    AdicionaCharD(' ','',100);

    VpfTexto.Add(VpfAuxStr);
    VpaTabela.Next;
  end;
  VpfTexto.SaveToFile(VpaDiretorio + 'Pessoas.txt');
  VpfTexto.Free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.DominioExportaNotas(VpaTabela : TDataSet; VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDatetime; VpaDiretorio : String;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
var
  VpfArquivo : TStringList;
begin
  VpfArquivo := TStringList.create;
  DominioCabecalhoNotas(VpaDatInicio,VpaDatFim,VpfArquivo);
  DominioExportaNotasRegistro2(VpaTabela,VpaCodFilial,VpaDatInicio,VpaDatFim,VpaBarraStatus,VpaCritica,VpfArquivo);
  VpfArquivo.SaveToFile(VpaDiretorio+InttoStr(Ano(VpaDatInicio))+AdicionaCharE('0',InttoStr(Mes(VpaDatFim)),2)+'.txt');
  VpfArquivo.free;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.DominioCabecalhoNotas(VpaDatInicio, VpaDatFim : TDatetime;VpaArquivo : TStringList);
begin
  VpaArquivo.add('01'+
  AdicionaCharE('0',IntToStr(Varia.CodClienteExportacaoFiscal),7)+
  AdicionacharD(' ',DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/'),14) +
  FormatDateTime('DD/MM/YYYY',VpaDatInicio)+
  FormatDateTime('DD/MM/YYYY',VpaDatFim)+
  'N'+
  '03'+
  '00000'+
  '1'+
  '14');
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.DominioExportaNotasRegistro2(VpaTabela : TDataSet; VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDatetime; VpaBarraStatus : TStatusBar;VpaCritica :TStringList;VpaArquivo : TStringList);
var
  VpfTexto: TStringList;
  VpfAuxStr, VpfCodFiscalMunicipio,VpfTipoFrete: string;
  VpfIndNotaCancelada : Boolean;
  VpfValTotal  : Double;
  VpfSequencial : Integer;
begin
  VpfSequencial := 0;
  VpaTabela.First;
  while not VpaTabela.Eof do
  begin
    TextoStatusBar(VpaBarraStatus,'1 Exportado dados da nota fiscal "'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'"');
    inc(VpfSequencial);
    IF VpaTabela.FieldByName('I_TIP_FRE').AsInteger = 1 then
      VpfTipoFrete := 'C'
    else
      VpfTipoFrete := 'F';

    VpfCodFiscalMunicipio := RCodigoFiscalMunicipio(RetiraAcentuacao(VpaTabela.FieldByName('C_CID_CLI').AsString),VpaTabela.FieldByName('C_EST_CLI').AsString);

    VpfIndNotaCancelada := (VpaTabela.FieldByName('C_NOT_CAN').AsString = 'S');
    if VpfIndNotaCancelada then
    begin
      VpfValTotal := 0;
    end
    else
    begin
      VpfValtotal := VpaTabela.fieldbyname('N_BAS_CAL').AsFloat;
    end;
    VpfAuxStr :=
    //fixo 02
    '02'+
    //Sequencial
    AdicionaCharE('0',IntToStr(VpfSequencial),7)+
    // codigo da empresa
    AdicionaCharE('0',IntToStr(Varia.CodClienteExportacaoFiscal),7)+
    // Inscricao do cliente
    AdicionaCharD(' ',DeletaChars(DeletaChars(DeletaChars(VpaTabela.fieldbyname('CNPJ_CPF').AsString,'.'),'-'),'/'),14) +
    //codigo da especie
    '0000000'+
    //codigo da exclusao da Dief
    '00'+
    //codigo do acumulador
    '0000000'+
    //codigo da natureza
    AdicionaCharE('0',CopiaAteChar(VpaTabela.FieldByName('C_COD_NAT').AsString,'/'),7)+
    //ESTADO DE DESTINO (SIGLA)
    AdicionaCharE(' ',VpaTabela.FieldByName('C_EST_CLI').AsString,2) +
    //seguinte
    '00'+
    //numero nota
    AdicionaCharE('0',VpaTabela.fieldbyname('I_NRO_NOT').AsString,7) +
    // serie
    AdicionaCharD(' ',VpaTabela.fieldbyname('C_SER_NOT').AsString,7)  +
    //documento final
    AdicionaCharE('0',VpaTabela.fieldbyname('I_NRO_NOT').AsString,7) +
    //data de saisa
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) +
    //data de emissao
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) +
    //valor contabil
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpfValTotal),','),13)+
    //valor da exclusa da DIEF
    AdicionaCharE('0','0',13)+
    //obervacoes
    AdicionaCharD(' ',DeletaChars(copy(VpaTabela.FieldByname('L_OB1_NOT').AsString,1,30),#13),30)+
    //TIPO DE FRETE 1 -CIF, 2 -FOB, 3 -OUTROS
    AdicionaCharD(' ',VpfTipoFrete,1) +
    //Codigo fiscal do municipio 9(7)
    AdicionaCharE('0',VpfCodFiscalMunicipio, 7) +
    //fato gerador
    'E'+
    //fato gerador DA CRFOP
    'E'+
    //fato gerador DA IRRFP
    'E'+
    // tipo de receita 1-proprio 2-terceiros
    '1'+
    //branco
    ' '+
    //cfop extendido/ detalhado
    '0000000'+
    //codigo da transferencia
    '0000000'+
    //codigo da observacao
    '0000000'+
    //data do visto
    FormatDateTime('dd/mm/yyyy', VpaTabela.fieldbyname('D_DAT_EMI').AsDateTime) +
    //codigo que identifica tipo da antecipacao tributaria
    '000000'+
    //valor do frete
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByname('N_VLR_FRE').AsFloat),','),13)+
    //valor do seguro
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByname('N_VLR_SEG').AsFloat),','),13)+
    //valor das despesas acessorias
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByname('N_OUT_DES').AsFloat),','),13)+
    //valor dos produtos
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',VpaTabela.FieldByname('N_TOT_PRO').AsFloat),','),13)+
    // Valor B.C ICMS ST
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),13)+
    // Outras saidas
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),13)+
    // Saidas insentas
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),13)+
    // Saidas insentas Cupom Fiscal
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),13)+
    // Saidas insentas Nota Fiscal modelo 2
    AdicionaCharE('0',DeletaChars(FormatFloat('0.00',0),','),13)+
    // codigo do modelo do documento
    '0000001'+
    //codigo fiscal da prestacao de servico
    '0000000'+
    //codigo da situação tributaria
    '0000000'+
    //subseries
    '0000000'+
    //tipo de titulo
    '00'+ //00-Duplicata
    //identificacao do titulo
    AdicionaCharD(' ',VpaTabela.fieldbyname('I_NRO_NOT').AsString,50) +
    //inscricao estadual do cliente
    AdicionaCharD(' ',VpaTabela.FieldByName('C_INS_CLI').AsString,20) +
    //inscricao municipal do cliente
    AdicionaCharD(' ','',20) +
    //brancos
    AdicionaCharD(' ','',60);
    VpaArquivo.Add(VpfAuxStr);

    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ValidaVariaveisExportacaoFiscal(VpaCritica : TStringList);
begin
  if (varia.ContaContabilFornecedor = 0 ) then
    VpaCritica.Add('CONFIGURAÇÕES DA EXPORTAÇÃO!!!Falta preencher a conta contabil do fornecedor');
  if (varia.ContaContabilCliente = 0) then
    VpaCritica.Add('CONFIGURAÇÕES DA EXPORTAÇÃO!!!Falta preencher a conta contabil do cliente');
end;

{******************************************************************************}
function TRBFuncoesExportacaoFiscal.RAliquotaNota(VpaCodfilial, VpaSeqNota : Integer) : Double;
begin
  AdicionaSQlAbreTabela(Aux,'Select N_PER_ICM from MOVNOTASFISCAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNota));
  result := Aux.FieldByName('N_PER_ICM').AsFloat;
end;

{*****************************************************************************}
function TRBFuncoesExportacaoFiscal.RCodigoFiscalMunicipio(VpaDesCidade, VpaDesUF : string) : String;
begin
  result := '';
  AdicionaSqlAbreTabela(Aux,'Select COD_FISCAL from CAD_CIDADES ' +
                            ' Where DES_CIDADE = '''+VpaDesCidade+''''+
                            ' and COD_ESTADO = '''+VpaDesUF+'''' );
  if not Aux.Eof then
    result := Aux.FieldByName('COD_FISCAL').AsString;
end;

{******************************************************************************}
function TRBFuncoesExportacaoFiscal.RInscricaoEstadualFilial(VpaCodFilial : Integer) :String;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CADFILIAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial));
  result := Aux.FieldByName('C_INS_FIL').AsString;
  result := DeletaChars(DeletaChars(DeletaChars(Result,'.'),'/'),'-');
  if result = 'ISENTO' then
    result := '-1';
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoFiscal.ExportarNotasPessoas(VpaCodFilial : Integer;VpaDataInicial, VpaDataFinal: TDateTime; VpaDiretorio: string;VpaBarraStatus : TStatusBar;VpaCritica :TStringList);
begin
  VpaCritica.clear;
  ValidaVariaveisExportacaoFiscal(VpaCritica);
  TextoStatusBar(VpaBarraStatus,'Limpando diretório "'+VpaDiretorio+'"');
  DeletaArquivo(VpaDiretorio+'\*.*');

  if varia.FormatoExportacaoFiscal = feSintegra then
  begin
    SintegraGeraArquivo(VpaCodFilial,VpaDataInicial,VpaDataFinal,VpaDiretorio,VpaBarraStatus,VpaCritica);
  end
  else
  begin
    TextoStatusBar(VpaBarraStatus,'Localizando os clientes');
    LocalizaPessoasExportacao(Tabela, VpaCodFilial, VpaDataInicial, VpaDataFinal);

    if varia.FormatoExportacaoFiscal = feLince then
      LINCEExportarPessoas(Tabela, VpaDiretorio,VpaBarraStatus)
    else
      if varia.FormatoExportacaoFiscal = feWKLiscalForDos then
        WKLiscalDosExportarPessoas(Tabela,VpaDiretorio,VpaBarraStatus,VpaCritica)
      else
        if varia.FormatoExportacaoFiscal = feSantaCatarina then
          SCISupremaExportaPessoas(Tabela,VpaDiretorio,VpaBarraStatus,VpaCritica)
        else
          if varia.FormatoExportacaoFiscal = feMTFiscal then
            MTFiscalExportaPessoas(Tabela,VpaDiretorio,VpaBarraStatus,VpaCritica)
          else
            if varia.FormatoExportacaoFiscal = feWKRadar then
              WKRadarExportarPessoas(Tabela,VpaDiretorio,VpaBarraStatus,VpaCritica)
            else
              if varia.FormatoExportacaoFiscal = feDominioSistemas then
                DominioExportarPessoas(Tabela,VpaDiretorio,VpaBarraStatus,VpaCritica);


    TextoStatusBar(VpaBarraStatus,'Localizando as notas fiscais');
    LocalizaNotasExportacao(Tabela,VpaCodFilial, VpaDataInicial, VpaDataFinal,'');

    if Varia.FormatoexportacaoFiscal = feLince then
      LINCEExportarNotas(Tabela, VpaDiretorio,VpaBarraStatus)
    else
      if varia.FormatoExportacaoFiscal = feWKLiscalForDos then
        WKLiscalDosExportarNotas(Tabela,VpaDiretorio,VpaBarraStatus)
      else
        if varia.FormatoExportacaoFiscal = feSantaCatarina then
          SCISupremaExportaNotasVpa(VpaCodFilial,VpaDataInicial,VpaDataFinal,VpaDiretorio,VpaBarraStatus,VpaCritica)
        else
          if varia.FormatoExportacaoFiscal = feMTFiscal then
            MTFiscalExportarNotas(Tabela,VpaDiretorio,VpaBarraStatus)
          else
            if varia.FormatoExportacaoFiscal = feWKRadar then
              MTFiscalExportarNotas(Tabela,VpaDiretorio,VpaBarraStatus)
            else
              if varia.FormatoExportacaoFiscal = feValidaPR then
                ValidaPRExportaNotas(Tabela,VpaCodFilial,VpaDataInicial,VpaDataFinal,VpaDiretorio,VpaBarraStatus,VpaCritica)
              else
                if varia.FormatoExportacaoFiscal = feDominioSistemas then
                  DominioExportaNotas(Tabela,VpaCodFilial,VpaDataInicial,VpaDataFinal,VpaDiretorio,VpaBarraStatus,VpaCritica);
    FechaTabela(Tabela);
  end;

  TextoStatusBar(VpaBarraStatus,'Notas fiscais exportadas com sucesso!!!');
end;

end.

