Unit UnAtualizacao;

interface
  Uses Classes, DbTables,SysUtils, APrincipal, Windows, Forms, UnVersoes,
       SQLExpr,IniFiles, UnProgramador1, Tabela ;

Const
  CT_VersaoBanco = 2114;
  CT_VersaoInvalida = 'SISTEMA DESATUALIZADO!!! Este sistema já possui novas versões, essa versão pode não funcionar corretamente,  para o bom funcionamento do mesmo é necessário fazer a atualização...' ;

  CT_SenhaAtual = '9774';

  {CFG_FISCAL
C_OPT_SIM

CadFormasPagamento
C_FLA_BCP
C_FLA_BCR

CFG_FISCAL
I_CLI_DEV
C_EST_ICM

CFG_GERAL
C_COT_TPR

CFG_FINANCEIRO
C_CON_CAI

AMOSTRA
DESDEPARTAMENTO
INDCOPIA
}


Type
  TAtualiza = Class
    Private
      Aux :  TSQLQuery;
      Tabela,
      Cadastro : TSQL;
      VprBaseDados : TSQLConnection;
      FunProgramador1 : TRBFunProgramador1;
      function RCodClienteDisponivel : Integer;
      procedure AtualizaSenha( Senha : string );
      procedure AlteraVersoesSistemas(VpaNomCampo, VpaDesVersao : String);
      procedure VerificaVersaoSistema;
      procedure CadastraTransportadorasComoClientes;
    public
      constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
      destructor destroy;override;
      procedure AtualizaTabela(VpaNumAtualizacao : Integer);
      function AtualizaTabela1(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela2(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela3(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela4(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela5(VpaNumAtualizacao : Integer): String;
      procedure AtualizaBanco;
      procedure AtualizaNumeroVersaoSistema;
end;


implementation

Uses FunSql, ConstMsg, FunNumeros,Registry, Constantes, FunString, funvalida, FunArquivos;

{*************************** cria a classe ************************************}
constructor TAtualiza.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited Create;
  VprBaseDados := VpaBasedados;
  Aux := TSQLQuery.Create(aowner);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSql.create(nil);
  Tabela.ASQLConnection := VpaBaseDados;
  Cadastro := TSql.create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;

  FunProgramador1 := TRBFunProgramador1.cria(VpaBaseDados);
end;

destructor TAtualiza.destroy;
begin
  FunProgramador1.Free;
  Aux.Free;
  inherited;
end;

{******************************************************************************}
function TAtualiza.RCodClienteDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(I_COD_CLI) ULTIMO from CADCLIENTES');
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  aux.Close;
end;

{*************** atualiza senha na base de dados ***************************** }
procedure TAtualiza.AtualizaSenha( Senha : string );
var
  ini : TRegIniFile;
  senhaInicial : string;
begin
  try
    // atualiza regedit
    Ini := TRegIniFile.Create('Software\Systec\Sistema');
    senhaInicial := Ini.ReadString('SENHAS','BANCODADOS', '');  // guarda senha do banco
    Ini.WriteString('SENHAS','BANCODADOS', Criptografa(senha));  // carrega senha do banco

   // atualiza base de dados
    LimpaSQLTabela(aux);
    AdicionaSQLTabela(Aux, 'grant connect, to DBA identified by ''' + senha + '''');
    Aux.ExecSQL;

    ini.free;
   except
    Ini.WriteString('SENHAS','BANCODADOS', senhaInicial);
    ini.free;
  end;
end;

{*********************** atualiza o banco de dados ****************************}
procedure TAtualiza.AtualizaBanco;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_Ult_Alt from Cfg_Geral ');
  if Aux.FieldByName('I_Ult_Alt').AsInteger < CT_VersaoBanco Then
    AtualizaTabela(Aux.FieldByName('I_Ult_Alt').AsInteger);
  Aux.Close;
  FunProgramador1.AtualizaBanco;
  VerificaVersaoSistema

end;

{******************************************************************************}
procedure TAtualiza.AtualizaNumeroVersaoSistema;
var
  VpfRegistry : TIniFile;
begin
  VpfRegistry := TIniFile.Create(RetornaDiretorioCorrente+'\'+ varia.ParametroBase+ '.ini');
  if UpperCase(CampoPermissaoModulo) = 'C_MOD_PON' then
    VpfRegistry.WriteString('VERSAO','PONTOLOJA',VersaoPontoLoja)
  else
    if UpperCase(CampoPermissaoModulo) = 'C_CON_SIS' then
      VpfRegistry.WriteString('VERSAO','CONFIGURACAOSISTEMA',VersaoConfiguracaoSistema)
    else
      if UpperCase(CampoPermissaoModulo) = 'C_MOD_FIN' then
        VpfRegistry.WriteString('VERSAO','FINANCEIRO',VersaoFinanceiro)
      else
        if UpperCase(CampoPermissaoModulo) = 'C_MOD_FAT' then
          VpfRegistry.WriteString('VERSAO','FATURAMENTO',VersaoFaturamento)
        else
          if UpperCase(CampoPermissaoModulo) = 'C_MOD_EST' then
            VpfRegistry.WriteString('VERSAO','ESTOQUE',VersaoEstoque)
          else
            if UpperCase(CampoPermissaoModulo) = 'C_MOD_CHA' then
              VpfRegistry.WriteString('VERSAO','CHAMADO',VersaoChamadoTecnico)
            else
              if UpperCase(CampoPermissaoModulo) = 'C_MOD_AGE' then
                VpfRegistry.WriteString('VERSAO','AGENDA',VersaoAgenda)
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_CRM' then
                  VpfRegistry.WriteString('VERSAO','CRM',VersaoCRM)
                else
                  if UpperCase(CampoPermissaoModulo) = 'C_MOD_CAI' then
                    VpfRegistry.WriteString('VERSAO','CAIXA',VersaoCaixa)
                  else
                    if UpperCase(CampoPermissaoModulo) = 'C_MOD_PDV' then
                      VpfRegistry.WriteString('VERSAO','PDV',VersaoPDV);
  VpfRegistry.Free;
end;

{****************** verifica a versao do sistema ******************************}
procedure TAtualiza.VerificaVersaoSistema;
var
  VpfVersaoSistema : String;
begin
  if CampoPermissaoModulo <>  'SISCORP' then
  Begin
    AdicionaSQLAbreTabela(Aux,'Select '+SQlTextoIsNull(CampoPermissaoModulo,'0')+ CampoPermissaoModulo +
                              ' from cfg_geral ');
    if UpperCase(CampoPermissaoModulo) = 'C_MOD_EST' THEN
      VpfVersaoSistema := VersaoEstoque
    else
      if UpperCase(CampoPermissaoModulo) = 'C_MOD_FAT' THEN
        VpfVersaoSistema := VersaoFaturamento
      else
        if UpperCase(CampoPermissaoModulo) = 'C_MOD_PON' THEN
          VpfVersaoSistema := VersaoPontoLoja
        else
          if UpperCase(CampoPermissaoModulo) = 'C_MOD_CHA' THEN
            VpfVersaoSistema := VersaoChamadoTecnico
          else
            if UpperCase(CampoPermissaoModulo) = 'C_MOD_FIN' THEN
              VpfVersaoSistema := VersaoFinanceiro
            else
              if UpperCase(CampoPermissaoModulo) = 'C_CON_SIS' THEN
                VpfVersaoSistema := VersaoConfiguracaoSistema
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_AGE' THEN
                  VpfVersaoSistema := VersaoAgenda
                else
                  if UpperCase(CampoPermissaoModulo) = 'C_MOD_CRM' THEN
                    VpfVersaoSistema := VersaoCRM
                  else
                    if UpperCase(CampoPermissaoModulo) = 'C_MOD_CAI' THEN
                      VpfVersaoSistema := VersaoCaixa
                    else
                      if UpperCase(CampoPermissaoModulo) = 'C_MOD_SIP' THEN
                        VpfVersaoSistema := VersaoSistemaPedido
                    else
                      if UpperCase(CampoPermissaoModulo) = 'C_MOD_PDV' THEN
                        VpfVersaoSistema := VersaoPDV;


    if trim(SubstituiStr(VpfVersaoSistema,'.',',')) <> trim(Aux.FieldByName(CampoPermissaoModulo).AsString) then
    begin
      if ArredondaDecimais(StrToFloat(SubstituiStr(VpfVersaoSistema,'.',',')),3) > ArredondaDecimais(StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',',')),3) then
        if StrToFloat(SubstituiStr(VpfVersaoSistema,'.',','))  > StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',',')) then
          AlteraVersoesSistemas(CampoPermissaoModulo,VpfVersaoSistema);
    end;
    if UpperCase(Application.Title) <> 'SISCORP' then
      AtualizaNumeroVersaoSistema;
    Aux.close;
  End;
end;

{********************* altera as versoes do sistema ***************************}
procedure TAtualiza.AlteraVersoesSistemas(VpaNomCampo, VpaDesVersao : String);
begin
  ExecutaComandoSql(Aux,'Update Cfg_Geral ' +
                        'set '+VpaNomCampo+ ' = '''+VpaDesVersao + '''');
end;

{******************************************************************************}
procedure TAtualiza.CadastraTransportadorasComoClientes;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADTRANSPORTADORAS ' +
//                               ' WHERE I_COD_TRA = 2965 '+
                               ' ORDER BY I_COD_TRA');
  while not Tabela.Eof do
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from CADCLIENTES ' +
                                ' Where I_TRA_ANT ='+Tabela.FieldByName('I_COD_TRA').AsString);
    if Cadastro.Eof then
    begin
      Cadastro.Insert;
      Cadastro.FieldByName('I_COD_CLI').AsInteger := RCodClienteDisponivel;
    end
    else
      Cadastro.Edit;
    Cadastro.FieldByName('I_TRA_ANT').AsInteger := Tabela.FieldByName('I_COD_TRA').AsInteger;
    Cadastro.FieldByName('C_NOM_CLI').AsString := Tabela.FieldByName('C_NOM_TRA').AsString;
    Cadastro.FieldByName('C_NOM_FAN').AsString := Tabela.FieldByName('C_NOM_TRA').AsString;
    Cadastro.FieldByName('C_END_CLI').AsString := Tabela.FieldByName('C_END_TRA').AsString;
    Cadastro.FieldByName('C_BAI_CLI').AsString := Tabela.FieldByName('C_BAI_TRA').AsString;
    Cadastro.FieldByName('I_NUM_END').AsInteger := Tabela.FieldByName('I_NUM_TRA').AsInteger;
    Cadastro.FieldByName('C_CEP_CLI').AsString := Tabela.FieldByName('C_CEP_TRA').AsString;
    Cadastro.FieldByName('C_CID_CLI').AsString := Tabela.FieldByName('C_CID_TRA').AsString;
    Cadastro.FieldByName('C_EST_CLI').AsString := Tabela.FieldByName('C_EST_TRA').AsString;
    Cadastro.FieldByName('C_CID_CLI').AsString := Tabela.FieldByName('C_CID_TRA').AsString;
    Cadastro.FieldByName('C_FO1_CLI').AsString := '('+DeleteAteChar(Tabela.FieldByName('C_FON_TRA').AsString,'*');
    Cadastro.FieldByName('C_FON_FAX').AsString := '('+DeleteAteChar(Tabela.FieldByName('C_FAX_TRA').AsString,'*');
    Cadastro.FieldByName('C_CON_CLI').AsString := Tabela.FieldByName('C_NOM_GER').AsString;
    Cadastro.FieldByName('C_CGC_CLI').AsString := Tabela.FieldByName('C_CGC_TRA').AsString;
    Cadastro.FieldByName('C_INS_CLI').AsString := Tabela.FieldByName('C_INS_TRA').AsString;
    Cadastro.FieldByName('C_TIP_PES').AsString := 'J';
    Cadastro.FieldByName('D_DAT_CAD').AsDateTime := Tabela.FieldByName('D_DAT_MOV').AsDateTime;
    Cadastro.FieldByName('C_END_ELE').AsString := Tabela.FieldByName('C_END_ELE').AsString;
    Cadastro.FieldByName('C_WWW_CLI').AsString := Tabela.FieldByName('C_WWW_TRA').AsString;
    Cadastro.FieldByName('C_COM_END').AsString := Tabela.FieldByName('C_COM_END').AsString;
    Cadastro.FieldByName('C_OBS_CLI').AsString := Tabela.FieldByName('L_OBS_TRA').AsString;
    Cadastro.FieldByName('C_IND_ATI').AsString := Tabela.FieldByName('C_IND_ATI').AsString;
    Cadastro.FieldByName('I_COD_IBG').AsInteger := Tabela.FieldByName('I_COD_IBG').AsInteger;
    Cadastro.FieldByName('C_ACE_SPA').AsString := 'S';
    Cadastro.FieldByName('C_ACE_TEL').AsString := 'S';
    Cadastro.FieldByName('C_EMA_INV').AsString := 'N';
    Cadastro.FieldByName('C_EXP_EFI').AsString := 'N';
    Cadastro.FieldByName('C_IND_CRA').AsString := 'N';
    Cadastro.FieldByName('C_IND_CON').AsString := 'N';
    Cadastro.FieldByName('C_IND_SER').AsString := 'N';
    Cadastro.FieldByName('C_IND_PRO').AsString := 'N';
    Cadastro.FieldByName('C_IND_BLO').AsString := 'N';
    Cadastro.FieldByName('C_FIN_CON').AsString := 'S';
    Cadastro.FieldByName('C_COB_FRM').AsString := 'S';
    Cadastro.FieldByName('C_IND_AGR').AsString := 'N';
    Cadastro.FieldByName('C_IND_CLI').AsString := 'N';
    Cadastro.FieldByName('C_IND_PRC').AsString := 'N';
    Cadastro.FieldByName('C_IND_FOR').AsString := 'N';
    Cadastro.FieldByName('C_IND_HOT').AsString := 'N';
    Cadastro.FieldByName('C_IND_TRA').AsString := 'S';
    Cadastro.FieldByName('C_IND_CBA').AsString := 'S';
    Cadastro.FieldByName('C_IND_BUM').AsString := 'N';
    Cadastro.FieldByName('C_IND_VIS').AsString := 'N';
    Cadastro.FieldByName('C_OPT_SIM').AsString := 'N';
    Cadastro.FieldByName('C_FLA_EXP').AsString := 'S';
    Cadastro.FieldByName('C_OPT_SIM').AsString := 'N';
    Cadastro.FieldByName('C_DES_ICM').AsString := 'S';
    Cadastro.FieldByName('C_DES_ISS').AsString := 'N';
    Cadastro.FieldByName('C_FLA_EXP').AsString := 'S';
    Cadastro.FieldByName('I_COD_SIT').AsInteger := 1101;
    Cadastro.post;
    Tabela.Next;
  end;
  Tabela.Close;
end;


{**************************** atualiza a tabela *******************************}
procedure TAtualiza.AtualizaTabela(VpaNumAtualizacao : Integer);
var
  VpfSemErros : Boolean;
  VpfErro : String;
begin
  VpfSemErros := true;
//  FAbertura.painelTempo1.Execute('Atualizando o Banco de Dados. Aguarde...');
  repeat
    Try
      if VpaNumAtualizacao < 300 Then
      begin
        VpfErro := '300';
        ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES' +
                              ' add C_DES_EMA CHAR(50) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 300');
      end;
      if VpaNumAtualizacao < 301 Then
      begin
        VpfErro := '301';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS' +
                              ' ADD N_VLR_DES NUMERIC(12,3) NULL, '+
                              ' ADD N_PER_DES NUMERIC(12,3) NULL, '+
                              ' ADD N_PER_COM NUMERIC(5,2) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 301');
      end;
      if VpaNumAtualizacao < 302 Then
      begin
        VpfErro := '302';
        ExecutaComandoSql(Aux,'DROP INDEX MOVNOTASFISCAIS_PK');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS '+
                              ' ADD PRIMARY KEY(I_EMP_FIL,I_SEQ_NOT,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MOVNOTASFISCAIS_PK ON MOVNOTASFISCAIS(I_EMP_FIL,I_SEQ_NOT,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 302');
      end;
      if VpaNumAtualizacao < 303 Then
      begin
        VpfErro := '303';
        ExecutaComandoSql(Aux,'create index CadNotaFiscais_CP1 on CADNOTAFISCAIS(C_Ser_Not,I_NRO_NOT)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 303');
      end;
      if VpaNumAtualizacao < 1429 Then
      begin
        VpfErro := '1429';
        ExecutaComandoSql(Aux,'alter table RETORNOITEM ADD NOMOCORRENCIA VARCHAR2(30) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1429');
      end;
      if VpaNumAtualizacao < 1430 Then
      begin
        VpfErro := '1430';
        ExecutaComandoSql(Aux,'alter table REMESSAITEM ADD NOMMOTIVO VARCHAR2(30) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1430');
      end;
      if VpaNumAtualizacao < 1431 Then
      begin
        VpfErro := '1431';
        ExecutaComandoSql(Aux,'DROP INDEX MOVCOMISSOES_CP4');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1431');
      end;
      if VpaNumAtualizacao < 1432 Then
      begin
        VpfErro := '1432';
        ExecutaComandoSql(Aux,'CREATE INDEX MOVCOMISSOES_CP3 ON MOVCOMISSOES(D_DAT_VAL,D_DAT_PAG)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1432');
      end;
      if VpaNumAtualizacao < 1433 Then
      begin
        VpfErro := '1433';
        TRY
          ExecutaComandoSql(Aux,'DROP INDEX MOVCOMISSOES_CP2');
        FINALLY
          ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1433');
        END;
      end;
      if VpaNumAtualizacao < 1434 Then
      begin
        VpfErro := '1434';
        ExecutaComandoSql(Aux,'CREATE INDEX MOVCOMISSOES_CP2 ON MOVCOMISSOES(D_DAT_VEN,D_DAT_PAG)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1434');
      end;
      if VpaNumAtualizacao < 1435 Then
      begin
        VpfErro := '1435';
        try
          ExecutaComandoSql(Aux,'DROP INDEX MOVCONTASRECEBERCP5');
        finally
          ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1435');
        end;
      end;
      if VpaNumAtualizacao < 1436 Then
      begin
        VpfErro := '1436';
        ExecutaComandoSql(Aux,'create index remessacorpo_cp1 on REMESSACORPO(DATBLOQUEIO,NUMCONTA,CODFILIAL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1436');
      end;
      if VpaNumAtualizacao < 1437 Then
      begin
        VpfErro := '1437';
        ExecutaComandoSql(Aux,'CREATE INDEX CADCODIGO_CP1 ON CADCODIGO(I_EMP_FIL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1437');
      end;
      if VpaNumAtualizacao < 1438 Then
      begin
        VpfErro := '1438';
        ExecutaComandoSql(Aux,'alter table CONTRATOCORPO ADD (CODPREPOSTO NUMBER(10,0) NULL,'+
                              ' PERCOMISSAO NUMBER(6,3) NULL, '+
                              ' PERCOMISSAOPREPOSTO NUMBER(6,3) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1438');
      end;
      if VpaNumAtualizacao < 1439 Then
      begin
        VpfErro := '1439';
        ExecutaComandoSql(Aux,'CREATE INDEX CONTRATOCORPO_FK4 on CONTRATOCORPO(CODPREPOSTO)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1439');
      end;
      if VpaNumAtualizacao < 1440 Then
      begin
        VpfErro := '1440';
        ExecutaComandoSql(Aux,'ALTER TABLE CONTRATOCORPO ADD DESEMAIL VARCHAR2(60) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1440');
      end;
      if VpaNumAtualizacao < 1441 Then
      begin
        VpfErro := '1441';
        ExecutaComandoSql(Aux,'CREATE TABLE FIGURAGRF( '+
                              ' CODFIGURAGRF NUMBER(10,0) NOT NULL, '+
                              ' NOMFIGURAGRF VARCHAR2(50) NULL,'+
                              ' DESFIGURAGRF VARCHAR2(2000)NULL,'+
                              ' PRIMARY KEY(CODFIGURAGRF))' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1441');
      end;
      if VpaNumAtualizacao < 1442 Then
      begin
        VpfErro := '1442';
        ExecutaComandoSql(Aux,'CREATE TABLE COMPOSICAO( '+
                              ' CODCOMPOSICAO NUMBER(10,0) NOT NULL, '+
                              ' NOMCOMPOSICAO VARCHAR2(50) NULL,'+
                              ' PRIMARY KEY(CODCOMPOSICAO))' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1442');
      end;
      if VpaNumAtualizacao < 1443 Then
      begin
        VpfErro := '1443';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_REF_CLI CHAR(1) NULL' );
        ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_REF_CLI = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1443');
      end;
      if VpaNumAtualizacao < 1444 Then
      begin
        VpfErro := '1444';
        ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD C_CON_CAI  VARCHAR2(13) NULL' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1444');
      end;
      if VpaNumAtualizacao < 1445 Then
      begin
        VpfErro := '1445';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_CNF_ESC CHAR(1) NULL' );
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_CNF_ESC  = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1445');
      end;
      if VpaNumAtualizacao < 1446 Then
      begin
        VpfErro := '1446';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD (C_UFD_NFE CHAR(2) NULL,'+
                              ' C_AMH_NFE CHAR(1) NULL, '+   //AMBIENTE DE HOMOLOGACAO
                              ' C_MOM_NFE CHAR(1) NULL)');   // MOSTRAR MENSAGEM
        ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_AMH_NFE = ''T'','+
                              ' C_MOM_NFE = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1446');
      end;
      if VpaNumAtualizacao < 1447 Then
      begin
        VpfErro := '1447';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD (C_POL_PSP CHAR(1) NULL,'+
                              ' C_POL_PCP CHAR(1) NULL) ');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_PSP = ''T'','+
                              ' C_POL_PCP = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1447');
      end;
      if VpaNumAtualizacao < 1448 Then
      begin
        VpfErro := '1448';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD C_POL_ECP CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_ECP = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1448');
      end;
      if VpaNumAtualizacao < 1449 Then
      begin
        VpfErro := '1449';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD (C_DAN_NFE CHAR(1) NULL,'+
                              ' C_CER_NFE VARCHAR2(50))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1449');
      end;
      if VpaNumAtualizacao < 1450 Then
      begin
        VpfErro := '1450';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD C_IND_NFE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_IND_NFE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1450');
      end;
      if VpaNumAtualizacao < 1451 Then
      begin
        VpfErro := '1451';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD C_FAT_CNO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_FAT_CNO = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1451');
      end;
      if VpaNumAtualizacao < 1452 Then
      begin
        VpfErro := '1452';
        ExecutaComandoSql(Aux,'alter table movorcamentos add I_SEQ_ORD NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1452');
      end;
      if VpaNumAtualizacao < 1453 Then
      begin
        VpfErro := '1453';
        ExecutaComandoSql(Aux,'create table COMPOSICAOFIGURAGRF ('+
                              ' CODCOMPOSICAO NUMBER(10,0) NOT NULL,'+
                              ' CODFIGURAGRF NUMBER(10,0) NOT NULL,'+
                              ' PRIMARY KEY(CODCOMPOSICAO,CODFIGURAGRF))');
        ExecutaComandoSql(Aux,'CREATE INDEX COMPOSICAOFIGURAGRF_FK1 ON COMPOSICAOFIGURAGRF(CODCOMPOSICAO)');
        ExecutaComandoSql(Aux,'CREATE INDEX COMPOSICAOFIGURAGRF_FK2 ON COMPOSICAOFIGURAGRF(CODFIGURAGRF)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1453');
      end;
      if VpaNumAtualizacao < 1454 Then
      begin
        VpfErro := '1454';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ADD I_COD_COM NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1454');
      end;
      if VpaNumAtualizacao < 1455 Then
      begin
        VpfErro := '1455';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO ADD C_ORP_ACE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE  CFG_PRODUTO SET C_ORP_ACE = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1455');
      end;
      if VpaNumAtualizacao < 1456 Then
      begin
        VpfErro := '1456';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ADD I_NUM_LOT NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1456');
      end;
      if VpaNumAtualizacao < 1457 Then
      begin
        VpfErro := '1457';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO ADD I_REG_LOT NUMBER(5,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1457');
      end;
      if VpaNumAtualizacao < 1458 Then
      begin
        VpfErro := '1458';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO ADD C_EST_SER CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_EST_SER = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1458');
      end;
      if VpaNumAtualizacao < 1459 Then
      begin
        VpfErro := '1459';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD I_COD_FIS NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1459');
      end;
      if VpaNumAtualizacao < 1460 Then
      begin
        VpfErro := '1460';
        ExecutaComandoSql(Aux,'alter table CADCLIENTES ADD I_COD_IBG NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1460');
      end;
      if VpaNumAtualizacao < 1461 Then
      begin
        VpfErro := '1461';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD C_COD_CNA VARCHAR2(15)NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1461');
      end;
      if VpaNumAtualizacao < 1462 Then
      begin
        VpfErro := '1462';
        ExecutaComandoSql(Aux,'alter table CADNOTAFISCAIS ADD( C_CHA_NFE VARCHAR2(50)NULL, '+
                              ' C_REC_NFE VARCHAR2(15) NULL, '+
                              ' C_PRO_NFE VARCHAR2(20) NULL,'+
                              ' C_STA_NFE VARCHAR2(3) NULL,'+
                              ' C_MOT_NFE VARCHAR2(40) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1462');
      end;
      if VpaNumAtualizacao < 1463 Then
      begin
        VpfErro := '1463';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ADD C_IND_MON CHAR(1)NULL ');
        ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS SET C_IND_MON = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1463');
      end;
      if VpaNumAtualizacao < 1464 Then
      begin
        VpfErro := '1464';
        ExecutaComandoSql(Aux,'alter table MOVESTOQUEPRODUTOS ADD(N_QTD_INI NUMBER(17,4)NULL, '+
                              ' N_QTD_FIN NUMBER(17,4) NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1464');
      end;
      if VpaNumAtualizacao < 1465 Then
      begin
        VpfErro := '1465';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD(C_COD_CLA VARCHAR2(15)NULL, '+
                              ' I_COD_FIL NUMBER(10) NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1465');
      end;
      if VpaNumAtualizacao < 1466 Then
      begin
        VpfErro := '1466';
        ExecutaComandoSql(Aux,'INSERT INTO CADSERIENOTAS(C_SER_NOT) VALUES(''900'')');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1466');
      end;
      if VpaNumAtualizacao < 1467 Then
      begin
        VpfErro := '1467';
        ExecutaComandoSql(Aux,'ALTER TABLE CAD_PAISES ADD(COD_IBGE NUMBER(4) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1467');
      end;
      if VpaNumAtualizacao < 1468 Then
      begin
        VpfErro := '1468';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD(I_COD_PAI NUMBER(4) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1468');
      end;
      if VpaNumAtualizacao < 1469 Then
      begin
        VpfErro := '1469';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_INS_MUN VARCHAR2(30) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1469');
      end;
      if VpaNumAtualizacao < 1470 Then
      begin
        VpfErro := '1470';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD I_ORI_PRO NUMBER(1,0) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS SET I_ORI_PRO = 0 ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1470');
      end;
      if VpaNumAtualizacao < 1471 Then
      begin
        VpfErro := '1471';
        ExecutaComandoSql(Aux,'ALTER TABLE CADSERVICO ADD I_COD_FIS NUMBER(6,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1471');
      end;
      if VpaNumAtualizacao < 1472 Then
      begin
        VpfErro := '1472';
        ExecutaComandoSql(Aux,'CREATE INDEX MOVCONTASARECEBER_CP6 ON MOVCONTASARECEBER(C_NOS_NUM)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1472');
      end;
      if VpaNumAtualizacao < 1473 Then
      begin
        VpfErro := '1473';
        ExecutaComandoSql(Aux,'CREATE INDEX FRACAOOP_CP1 ON FRACAOOP(INDPLANOCORTE)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1473');
      end;
      if VpaNumAtualizacao < 1474 Then
      begin
        VpfErro := '1474';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD(I_TIP_BAR NUMBER(1,0),'+
                              ' N_PRE_EAN NUMBER(15,0)NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1474');
      end;
      if VpaNumAtualizacao < 1475 Then
      begin
        VpfErro := '1475';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD(I_ULT_EAN NUMBER(20,0)NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1475');
      end;
      if VpaNumAtualizacao < 1476 Then
      begin
        VpfErro := '1476';
        ExecutaComandoSql(Aux,'CREATE TABLE CONDICAOPAGAMENTOGRUPOUSUARIO('+
                              ' CODGRUPOUSUARIO NUMBER(10,0) NOT NULL, '+
                              ' CODCONDICAOPAGAMENTO NUMBER(10,0) NOT NULL, ' +
                              ' PRIMARY KEY(CODGRUPOUSUARIO,CODCONDICAOPAGAMENTO))');
        ExecutaComandoSql(Aux,'CREATE INDEX CONDICAOPGTOGRUPOUSUARIO_FK1 ON CONDICAOPAGAMENTOGRUPOUSUARIO(CODGRUPOUSUARIO)');
        ExecutaComandoSql(Aux,'CREATE INDEX CONDICAOPGTOGRUPOUSUARIO_FK2 ON CONDICAOPAGAMENTOGRUPOUSUARIO(CODCONDICAOPAGAMENTO)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1476');
      end;
      if VpaNumAtualizacao < 1477 Then
      begin
        VpfErro := '1477';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_GER_COP CHAR(1)NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS set C_GER_COP = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1477');
      end;
      if VpaNumAtualizacao < 1478 Then
      begin
        VpfErro := '1478';
        ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAFORNECEDORCORPO '+
                              ' ADD (DESEMAIL VARCHAR2(100) NULL, '+
                              ' NOMCONTATO VARCHAR2(50) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1478');
      end;
      if VpaNumAtualizacao < 1479 Then
      begin
        VpfErro := '1479';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ORP_CMM CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORP_CMM = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1479');
      end;
      if VpaNumAtualizacao < 1480 Then
      begin
        VpfErro := '1480';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD (C_PRC_NFE VARCHAR2(20) NULL, '+
                              ' C_MOC_NFE VARCHAR2(255) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1480');
      end;
      if VpaNumAtualizacao < 1481 Then
      begin
        VpfErro := '1481';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_SER_SER VARCHAR2(15) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1481');
      end;
      if VpaNumAtualizacao < 1482 Then
      begin
        VpfErro := '1482';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_NOT_CON CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CADFILIAIS set C_NOT_CON = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1482');
      end;
      if VpaNumAtualizacao < 1483 Then
      begin
        VpfErro := '1483';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_EST_CAC CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CADGRUPOS set C_EST_CAC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1483');
      end;
      if VpaNumAtualizacao < 1484 Then
      begin
        VpfErro := '1484';
        ExecutaComandoSql(Aux,'ALTER TABLE RETORNOITEM MODIFY NOMSACADO VARCHAR2(40)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1484');
      end;
      if VpaNumAtualizacao < 1485 Then
      begin
        VpfErro := '1485';
        ExecutaComandoSql(Aux,'ALTER TABLE CAD_PLANO_CONTA ADD N_VLR_PRE NUMBER(17,2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1485');
      end;
      if VpaNumAtualizacao < 1486 Then
      begin
        VpfErro := '1486';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_MOD_EPE NUMBER(2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1486');
      end;
      if VpaNumAtualizacao < 1487 Then
      begin
        VpfErro := '1487';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_EAN_ACE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_EAN_ACE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1487');
      end;
      if VpaNumAtualizacao < 1488 Then
      begin
        VpfErro := '1488';
        ExecutaComandoSql(Aux,'ALTER TABLE EMBALAGEM ADD QTD_EMBALAGEM NUMBER(15,3)NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1488');
      end;
      if VpaNumAtualizacao < 1489 Then
      begin
        VpfErro := '1489';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPCONSUMO ADD QTDARESERVAR NUMBER(15,4)NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1489');
      end;
      if VpaNumAtualizacao < 1490 Then
      begin
        VpfErro := '1490';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO ADD N_QTD_ARE NUMBER(15,4)NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1490');
      end;
      if VpaNumAtualizacao < 1491 Then
      begin
        VpfErro := '1491';
        ExecutaComandoSql(Aux,'ALTER TABLE IMPRESSAOCONSUMOFRACAO ADD(QTDRESERVADA NUMBER(15,4)NULL, '+
                              ' QTDARESERVAR NUMBER(15,4) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1491');
      end;
      if VpaNumAtualizacao < 1492 Then
      begin
        VpfErro := '1492';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_EMA_NFE VARCHAR2(75) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1492');
      end;
      if VpaNumAtualizacao < 1493 Then
      begin
        VpfErro := '1493';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_NOT_IEC CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_NOT_IEC =''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1493');
      end;
      if VpaNumAtualizacao < 1494 Then
      begin
        VpfErro := '1494';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_COM_ROM CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_COM_ROM =''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1494');
      end;
      if VpaNumAtualizacao < 1495 Then
      begin
        VpfErro := '1495';
        ExecutaComandoSql(Aux,'CREATE TABLE PRODUTORESERVADOEMEXCESSO ('+
                              ' SEQRESERVA NUMBER(10) NOT NULL, '+
                              ' DATRESERVA DATE, ' +
                              ' SEQPRODUTO NUMBER(10) NOT NULL, '+
                              ' QTDESTOQUEPRODUTO NUMBER(15,4) NULL, '+
                              ' QTDRESERVADO NUMBER(15,4) NULL, '+
                              ' QTDEXCESSO NUMBER(15,4) NULL, '+
                              ' CODFILIAL NUMBER(10) NULL, ' +
                              ' SEQORDEMPRODUCAO NUMBER(10) NULL, '+
                              ' CODUSUARIO NUMBER(10) NULL, '+
                              ' DESUM CHAR(2) NULL, '+
                              ' PRIMARY KEY(SEQRESERVA))');
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_FK1 ON PRODUTORESERVADOEMEXCESSO(SEQPRODUTO)' );
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_FK2 ON PRODUTORESERVADOEMEXCESSO(CODFILIAL,SEQORDEMPRODUCAO)' );
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_FK3 ON PRODUTORESERVADOEMEXCESSO(CODUSUARIO)' );
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_CP1 ON PRODUTORESERVADOEMEXCESSO(DATRESERVA)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1495');
      end;
      if VpaNumAtualizacao < 1496 Then
      begin
        VpfErro := '1496';
        ExecutaComandoSql(Aux,'CREATE TABLE RESERVAPRODUTO( '+
                              ' SEQRESERVA NUMBER(10) NOT NULL, '+
                              ' SEQPRODUTO NUMBER(10) NOT NULL, '+
                              ' TIPMOVIMENTO CHAR(1) NULL, '+
                              ' DATRESERVA DATE NULL, '+
                              ' QTDRESERVADA NUMBER(15,3) NULL, '+
                              ' CODUSUARIO NUMBER(10) NULL, '+
                              ' QTDINICIAL NUMBER(15,3) NULL,'+
                              ' QTDFINAL NUMBER(15,3) NULL, '+
                              ' CODFILIAL NUMBER(10) NULL, '+
                              ' SEQORDEMPRODUCAO NUMBER(10) NULL, '+
                              ' DESUM CHAR(2) NULL, '+
                              ' PRIMARY KEY(SEQRESERVA))');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_FK1 ON RESERVAPRODUTO(SEQPRODUTO)');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_FK2 ON RESERVAPRODUTO(CODFILIAL,SEQORDEMPRODUCAO)');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_FK3 ON RESERVAPRODUTO(CODUSUARIO)');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_CP1 ON RESERVAPRODUTO(DATRESERVA)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1496');
      end;
      if VpaNumAtualizacao < 1497 Then
      begin
        VpfErro := '1497';
        ExecutaComandoSql(Aux,'CREATE TABLE PROJETO( '+
                              ' CODPROJETO NUMBER(10) NOT NULL, '+
                              ' NOMPROJETO VARCHAR2(50) NULL, '+
                              ' PRIMARY KEY(CODPROJETO))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1497');
      end;
      if VpaNumAtualizacao < 1498 Then
      begin
        VpfErro := '1498';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_CON_PRO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_CON_PRO = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1498');
      end;
      if VpaNumAtualizacao < 1499 Then
      begin
        VpfErro := '1499';
        ExecutaComandoSql(Aux,'CREATE TABLE CONTAAPAGARPROJETO( '+
                              ' CODFILIAL NUMBER(10) NOT NULL, '+
                              ' LANPAGAR NUMBER(10) NOT NULL, '+
                              ' CODPROJETO NUMBER(10) NOT NULL, '+
                              ' SEQDESPESA NUMBER(10) NOT NULL,' +
                              ' VALDESPESA NUMBER(15,3) NULL, '+
                              ' PERDESPESA NUMBER(15,3) NULL,'+
                              ' PRIMARY KEY(CODFILIAL,LANPAGAR,CODPROJETO,SEQDESPESA))');
        ExecutaComandoSql(Aux,'CREATE INDEX CONTAAPAGARPROJETO_FK1 ON CONTAAPAGARPROJETO(CODFILIAL,LANPAGAR)');
        ExecutaComandoSql(Aux,'CREATE INDEX CONTAAPAGARPROJETO_FK2 ON CONTAAPAGARPROJETO(CODPROJETO)');
        ExecutaComandoSql(Aux,'ALTER TABLE CONTAAPAGARPROJETO add CONSTRAINT CONTAAPAGARPRO_CP '+
                              ' FOREIGN KEY (CODFILIAL,LANPAGAR) '+
                              '  REFERENCES CADCONTASAPAGAR (I_EMP_FIL,I_LAN_APG) ');
        ExecutaComandoSql(Aux,'ALTER TABLE CONTAAPAGARPROJETO add CONSTRAINT CONTAAPAGAR_PROJETO '+
                              ' FOREIGN KEY (CODPROJETO) '+
                              '  REFERENCES PROJETO (CODPROJETO) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1499');
      end;
      if VpaNumAtualizacao < 1500 Then
      begin
        VpfErro := '1500';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_PPP CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_PPP = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1500');
      end;
      if VpaNumAtualizacao < 1501 Then
      begin
        VpfErro := '1501';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_COT_QME NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET I_COT_QME = 6');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1501');
      end;
      if VpaNumAtualizacao < 1502 Then
      begin
        VpfErro := '1502';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ADD CODPRJ NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1502');
      end;
      if VpaNumAtualizacao < 1503 Then
      begin
        VpfErro := '1503';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD N_CAP_LIQ NUMBER(10,2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1503');
      end;
      if VpaNumAtualizacao < 1504 Then
      begin
        VpfErro := '1504';
        ExecutaComandoSql(Aux,'CREATE TABLE MOTIVOPARADA( '+
                              ' CODMOTIVOPARADA NUMBER(10) NOT NULL, '+
                              ' NOMMOTIVOPARADA VARCHAR2(50) NULL,'+
                              ' PRIMARY KEY(CODMOTIVOPARADA))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1504');
      end;
      if VpaNumAtualizacao < 1505 Then
      begin
        VpfErro := '1505';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_RES CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_RES = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1505');
      end;
      if VpaNumAtualizacao < 1506 Then
      begin
        VpfErro := '1506';
        ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_COT_ICS CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADEMPRESAS SET C_COT_ICS = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1506');
      end;
      if VpaNumAtualizacao < 1507 Then
      begin
        VpfErro := '1507';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLASSIFICACAO ADD C_IMP_ETI CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADCLASSIFICACAO SET C_IMP_ETI = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1507');
      end;
      if VpaNumAtualizacao < 1508 Then
      begin
        VpfErro := '1508';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO ADD I_COD_COR NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'UPDATE MOVTABELAPRECO SET I_COD_COR = 0');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO MODIFY I_COD_COR NUMBER(10) NOT NULL');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO  '+
                              ' ADD PRIMARY KEY(I_COD_EMP,I_COD_TAB,I_SEQ_PRO,I_COD_CLI,I_COD_TAM,I_COD_COR)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1508');
      end;
      if VpaNumAtualizacao < 1509 Then
      begin
        VpfErro := '1509';
        ExecutaComandoSql(Aux,'create table DEPARTAMENTOAMOSTRA('+
                              ' CODDEPARTAMENTOAMOSTRA NUMBER(10,0) NOT NULL,'+
                              ' NOMDEPARTAMENTOAMOSTRA VARCHAR2(50)NULL,' +
                              ' PRIMARY KEY(CODDEPARTAMENTOAMOSTRA))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1509');
      end;
      if VpaNumAtualizacao < 1510 Then
      begin
        VpfErro := '1510';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD CODDEPARTAMENTOAMOSTRA NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1510');
      end;
      if VpaNumAtualizacao < 1511 Then
      begin
        VpfErro := '1511';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(I_COD_DEA NUMBER(10,0) NULL , '+
                               ' I_DIA_AMO NUMBER(3) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1511');
      end;
      if VpaNumAtualizacao < 1512 Then
      begin
        VpfErro := '1512';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_NOF_ICO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_NOF_ICO = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1512');
      end;
      if VpaNumAtualizacao < 1513 Then
      begin
        VpfErro := '1513';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER ADD C_IND_DEV CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADCONTASARECEBER SET C_IND_DEV = ''N''');
        ExecutaComandoSql(Aux,'CREATE INDEX CADCONTASARECEBER_CP3 ON CADCONTASARECEBER(C_IND_DEV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1513');
      end;
      if VpaNumAtualizacao < 1514 Then
      begin
        VpfErro := '1514';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_EST_REI NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1514');
      end;
      if VpaNumAtualizacao < 1515 Then
      begin
        VpfErro := '1515';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPCONSUMO ADD(INDEXCLUIR CHAR(1) NULL, '+
                              ' ALTMOLDE NUMBER(9,4) NULL, ' +
                              ' LARMOLDE NUMBER(9,4) NULL)');
        ExecutaComandoSql(Aux,'UPDATE FRACAOOPCONSUMO SET INDEXCLUIR = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1515');
      end;
      if VpaNumAtualizacao < 1516 Then
      begin
        VpfErro := '1516';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_IND_VIS CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_IND_VIS = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1516');
      end;
      if VpaNumAtualizacao < 1517 Then
      begin
        VpfErro := '1517';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACONSUMO ADD DESLEGENDA CHAR(4)NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1517');
      end;
      if VpaNumAtualizacao < 1518 Then
      begin
        VpfErro := '1518';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASAPAGAR add CONSTRAINT CADCONTASPAGAR_PLAC '+
                              ' FOREIGN KEY (I_COD_EMP, C_CLA_PLA) '+
                              '  REFERENCES CAD_PLANO_CONTA(I_COD_EMP,C_CLA_PLA) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1518');
      end;
      if VpaNumAtualizacao < 1519 Then
      begin
        VpfErro := '1519';
        ExecutaComandoSql(Aux,'CREATE TABLE TIPOMATERIAPRIMA ('+
                              ' CODTIPOMATERIAPRIMA NUMBER(10) NULL, '+
                              ' NOMTIPOMATERIAPRIMA VARCHAR2(50) NULL, '+
                              ' PRIMARY KEY(CODTIPOMATERIAPRIMA))' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1519');
      end;
      if VpaNumAtualizacao < 1520 Then
      begin
        VpfErro := '1520';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACONSUMO '+
                              ' ADD(CODTIPOMATERIAPRIMA NUMBER(10) NULL,'+
                              ' NUMSEQUENCIA NUMBER(10) NULL,' +
                              ' SEQENTRETELA NUMBER(10) NULL,' +
                              ' QTDENTRETELA NUMBER(10) NULL,' +
                              ' SEQTERMOCOLANTE NUMBER(10)NULL,' +
                              ' QTDTERMOCOLANTE NUMBER(10)NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1520');
      end;
      if VpaNumAtualizacao < 1521 Then
      begin
        VpfErro := '1521';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD( '+
                              ' C_PER_SPE CHAR(1) NULL, '+
                              ' I_ATI_SPE NUMBER(2) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1521');
      end;
      if VpaNumAtualizacao < 1522 Then
      begin
        VpfErro := '1522';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD( '+
                              ' I_CON_SPE NUMBER(10) NULL, '+
                              ' C_NCO_SPE VARCHAR2(50) NULL,'+
                              ' C_CPC_SPE VARCHAR2(14) NULL,' +
                              ' C_CRC_SPE VARCHAR2(15) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1522');
      end;
      if VpaNumAtualizacao < 1523 Then
      begin
        VpfErro := '1523';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD I_DES_PRO NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1523');
      end;
      if VpaNumAtualizacao < 1524 Then
      begin
        VpfErro := '1524';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD(CODEMPRESA NUMBER(10) NULL, '+
                              ' DESTIPOCLASSIFICACAO CHAR(1)NULL)');
        ExecutaComandoSql(Aux,'UPDATE AMOSTRA SET CODEMPRESA = 1, ' +
                              ' DESTIPOCLASSIFICACAO = ''P''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1524');
      end;
      if VpaNumAtualizacao < 1525 Then
      begin
        VpfErro := '1525';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOP ADD INDPOSSUIEMESTOQUE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update FRACAOOP SET INDPOSSUIEMESTOQUE = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1525');
      end;
      if VpaNumAtualizacao < 1526 Then
      begin
        VpfErro := '1526';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_OBS_BOL VARCHAR2(600) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL SET C_OBS_BOL = ''****O DEPOSITO BANCARIO NAO QUITA ESTE BOLETO****''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1526');
      end;
      if VpaNumAtualizacao < 1527 Then
      begin
        VpfErro := '1527';
        ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_IND_FCA CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADEMPRESAS SET C_IND_FCA = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1527');
      end;
      if VpaNumAtualizacao < 1528 Then
      begin
        VpfErro := '1528';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_ORC_LOC NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1528');
      end;
      if VpaNumAtualizacao < 1529 Then
      begin
        VpfErro := '1529';
        ExecutaComandoSql(Aux,'ALTER TABLE FACA ADD (ALTPROVA NUMBER(9,3)NULL, '+
                               ' LARPROVA NUMBER(9,3) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1529');
      end;
      if VpaNumAtualizacao < 1530 Then
      begin
        VpfErro := '1530';
        ExecutaComandoSql(Aux,'alter TABLE CFG_GERAL ADD C_AMO_CAC CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set C_AMO_CAC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1530');
      end;
      if VpaNumAtualizacao < 1531 Then
      begin
        VpfErro := '1531';
        ExecutaComandoSql(Aux,'alter TABLE CFG_GERAL ADD C_DIR_FAM VARCHAR2(200) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1531');
      end;
      if VpaNumAtualizacao < 1532 Then
      begin
        VpfErro := '1532';
        ExecutaComandoSql(Aux,'create table COEFICIENTECUSTO('+
                              ' CODCOEFICIENTE NUMBER(10) NOT NULL,' +
                              ' NOMCOEFICIENTE VARCHAR2(50) NOT NULL,' +
                              ' PERICMS NUMBER(9,3) NULL, ' +
                              ' PERPISCOFINS NUMBER(9,3) NULL,' +
                              ' PERCOMISSAO NUMBER(9,3) NULL,' +
                              ' PERFRETE NUMBER(9,3) NULL,' +
                              ' PERADMINISTRATIVO NUMBER(9,3) NULL,' +
                              ' PERPROPAGANDA NUMBER(9,3) NULL,' +
                              ' PERVENDAPRAZO NUMBER(9,3) NULL,' +
                              ' PERLUCRO NUMBER(9,3) NULL,' +
                              ' PRIMARY KEY(CODCOEFICIENTE))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1532');
      end;
      if VpaNumAtualizacao < 1533 Then
      begin
        VpfErro := '1533';
        ExecutaComandoSql(Aux,'ALTER TABLE CADTRANSPORTADORAS ADD(I_COD_PAI NUMBER(10) NULL, '+
                              ' I_COD_IBG NUMBER(10) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1533');
      end;
      if VpaNumAtualizacao < 1534 Then
      begin
        VpfErro := '1534';
        ExecutaComandoSql(Aux,'ALTER TABLE CADTRANSPORTADORAS ADD C_IND_PRO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADTRANSPORTADORAS SET C_IND_PRO = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1534');
      end;
      if VpaNumAtualizacao < 1535 Then
      begin
        VpfErro := '1535';
        ExecutaComandoSql(Aux,'create table TIPODOCUMENTOFISCAL ('+
                              ' CODTIPODOCUMENTOFISCAL CHAR(2) NOT NULL, '+
                              ' NOMTIPODOCUMENTOFISCAL VARCHAR2(70) NULL, '+
                              ' PRIMARY KEY(CODTIPODOCUMENTOFISCAL))');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''01'',''NOTA FISCAL MODELO 1/1A'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''1B'',''NOTA FISCAL AVULSA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''02'',''NOTA FISCAL DE VENDA AO CONSUMIDOR'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''2D'',''CUPOM FISCAL'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''04'',''NOTA FISCAL DE PRODUTOR'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''06'',''CONTA DE ENERGIA ELETRICA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''07'',''NOTA FISCAL DE SERVICO DE TRANSPORTE'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''08'',''CONHECIMENTO DE TRANSPORTE RODOVIARIO DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''8B'',''CONHECIMENTO DE TRANSPORTE AVULSO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''09'',''CONHECIMENTO DE TRANSPORTE AQUAVIARIO DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''10'',''CONHECIMENTO DE AEREO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''11'',''CONHECIMENTO DE TRANSPORTE FERROVIARIO DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''13'',''BILHETE DE PASSAGEM RODOVIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''14'',''BILHETE DE PASSAGEM AQUAVIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''15'',''BILHETE DE PASSAGEM E NOTA DE BAGAGEM'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''16'',''BILHETE DE PASSAGEM FERROVIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''18'',''RESUMO DE MOVIMENTO DIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''21'',''NOTA FISCAL DE SERVICO DE COMUNICACAO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''22'',''NOTA FISCAL DE SERVICO DE TELECOMUNICACAO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''26'',''CONHECIMENTO DE TRANSPORTE MULTIMODAL DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''27'',''NOTA FISCAL DE TRANSPORTE FERROVIARIO DE CARGA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''28'',''NOTA FISCAL/CONTA DE FORNECIMENTO DE GAS CANALIZADO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''29'',''NOTA FISCAL/CONTA DE FORNECIMENTO DE AGUA CANALIZADA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''55'',''NOTA FISCAL ELETRONICA (NF-E)'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''57'',''CONHECIMENTO DE TRANSPORTE ELETRONICO (CT-E)'')');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1535');
      end;
      if VpaNumAtualizacao < 1536 Then
      begin
        VpfErro := '1536';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOP ADD DATCORTE DATE NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1536');
      end;
      if VpaNumAtualizacao < 1537 Then
      begin
        VpfErro := '1537';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_IND_SPE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_IND_SPE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1537');
      end;
      if VpaNumAtualizacao < 1538 Then
      begin
        VpfErro := '1538';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (N_PER_COF NUMBER(6,3) NULL,'+
                              ' N_PER_PIS NUMBER(6,3) NULL,'+
                              ' C_CST_IPI CHAR(2) NULL )');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1538');
      end;
      if VpaNumAtualizacao < 1539 Then
      begin
        VpfErro := '1539';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL DROP (N_PER_COF, N_PER_PIS)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1539');
      end;
      if VpaNumAtualizacao < 1540 Then
      begin
        VpfErro := '1540';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD(C_CAL_PIS CHAR(1) NULL,'+
                              ' C_CAL_COF CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update MOVNATUREZA SET C_CAL_PIS = ''N'','+
                              ' C_CAL_COF = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1540');
      end;
      if VpaNumAtualizacao < 1541 Then
      begin
        VpfErro := '1541';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR DROP (I_PRA_DIA, I_QTD_PAR)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1541');
      end;
      if VpaNumAtualizacao < 1542 Then
      begin
        VpfErro := '1542';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ADD I_COD_PAG NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1542');
      end;
      if VpaNumAtualizacao < 1543 Then
      begin
        VpfErro := '1543';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASAPAGAR ADD I_COD_PAG NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1543');
      end;
      if VpaNumAtualizacao < 1544 Then
      begin
        VpfErro := '1544';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ADD C_MOD_DOC CHAR(2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1544');
      end;
      if VpaNumAtualizacao < 1545 Then
      begin
        VpfErro := '1545';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_SOW_IMC CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_SOW_IMC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1545');
      end;
      if VpaNumAtualizacao < 1546 Then
      begin
        VpfErro := '1546';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_COE_PAD NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1546');
      end;
      if VpaNumAtualizacao < 1547 Then
      begin
        VpfErro := '1547';
        ExecutaComandoSql(Aux,'CREATE TABLE REPRESENTADA ('+
                              ' CODREPRESENTADA NUMBER(10,0) NOT NULL, '+
                              ' NOMREPRESENTADA VARCHAR2(50) NULL, '+
                              ' NOMFANTASIA VARCHAR2(50) NULL,'+
                              ' DESENDERECO VARCHAR2(50) NULL,'+
                              ' DESBAIRRO VARCHAR2(30) NULL,'+
                              ' DESCEP VARCHAR2(9) NULL,'+
                              ' DESCOMPLEMENTO VARCHAR2(50) NULL,'+
                              ' NUMENDERECO NUMBER(10) NULL,'+
                              ' DESCIDADE VARCHAR2(40) NULL,'+
                              ' DESUF CHAR(2) NULL, '+
                              ' DESFONE VARCHAR2(20) NULL,'+
                              ' DESFAX VARCHAR2(20) NULL,'+
                              ' DESCNPJ VARCHAR2(18) NULL,'+
                              ' DESINSCRICAOESTADUAL VARCHAR2(20),'+
                              ' DESEMAIL VARCHAR2(100) NULL,'+
                              ' PRIMARY KEY(CODREPRESENTADA))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1547');
      end;
      if VpaNumAtualizacao < 1548 Then
      begin
        VpfErro := '1548';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_DEB_CRE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_DEB_CRE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1548');
      end;
      if VpaNumAtualizacao < 1549 Then
      begin
        VpfErro := '1549';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(I_LAR_BAL NUMBER(10) NULL, '+
                              ' I_ALT_BAL NUMBER(10) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1549');
      end;
      if VpaNumAtualizacao < 1550 Then
      begin
        VpfErro := '1550';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMCORTEITEM ADD(LARENFESTO NUMBER(10) NULL, '+
                              ' ALTENFESTO NUMBER(10) NULL, '+
                              ' QTDENFESTO NUMBER(10,2) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1550');
      end;
      if VpaNumAtualizacao < 1551 Then
      begin
        VpfErro := '1551';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMCORTEITEM ADD(POSFACA NUMBER(1) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1551');
      end;
      if VpaNumAtualizacao < 1552 Then
      begin
        VpfErro := '1552';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD(C_AGR_BAL CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CADPRODUTOS set C_AGR_BAL = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1552');
      end;
      if VpaNumAtualizacao < 1553 Then
      begin
        VpfErro := '1553';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(I_LAR_PRE NUMBER(10) NULL, '+
                              ' I_ALT_PRE NUMBER(10) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1553');
      end;
      if VpaNumAtualizacao < 1554 Then
      begin
        VpfErro := '1554';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD(C_IND_CAT CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_IND_CAT = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1554');
      end;
      if VpaNumAtualizacao < 1555 Then
      begin
        VpfErro := '1555';
        ExecutaComandoSql(Aux,'ALTER TABLE COMBINACAO ADD (SEQPRODUTOFIOTRAMA NUMBER(10) NULL,'+
                              ' SEQPRODUTOFIOAJUDA NUMBER(10) NULL,'+
                              ' CODCORFIOTRAMA NUMBER(10) NULL,'+
                              ' CODCORFIOAJUDA NUMBER(10) NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1555');
      end;
      if VpaNumAtualizacao < 1556 Then
      begin
        VpfErro := '1556';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_CHA_SEC CHAR(1)NULL)' );
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CHA_SEC = ''F''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1556');
      end;
      if VpaNumAtualizacao < 1557 Then
      begin
        VpfErro := '1557';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD(C_EST_CPR CHAR(1)NULL)' );
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_CPR = ''T''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1557');
      end;
      if VpaNumAtualizacao < 1558 Then
      begin
        VpfErro := '1558';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVCONTASARECEBER ADD(C_DUP_IMP CHAR(1)NULL)' );
        ExecutaComandoSql(Aux,'UPDATE MOVCONTASARECEBER SET C_DUP_IMP = ''S''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1558');
      end;
      if VpaNumAtualizacao < 1559 Then
      begin
        VpfErro := '1559';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_COT_APG CHAR(1)NULL)' );
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_APG = ''F''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1559');
      end;
      if VpaNumAtualizacao < 1560 Then
      begin
        VpfErro := '1560';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD(N_ALT_PRO NUMBER(10,3)NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1560');
      end;
      if VpaNumAtualizacao < 1561 Then
      begin
        VpfErro := '1561';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD(N_ALT_PRO NUMBER(10,3)NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1561');
      end;
      if VpaNumAtualizacao < 1562 Then
      begin
        VpfErro := '1562';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD(I_COD_CFO NUMBER(10)NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1562');
      end;
      if VpaNumAtualizacao < 1563 Then
      begin
        VpfErro := '1563';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD(C_OPT_SIM CHAR(1)NULL)' );
        ExecutaComandoSql(Aux,'Update CADCLIENTES set C_OPT_SIM = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1563');
      end;
      if VpaNumAtualizacao < 1564 Then
      begin
        VpfErro := '1564';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_GER_ALC CHAR(1) NULL' );
        ExecutaComandoSql(Aux,'Update CADGRUPOS set C_GER_ALC = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1564');
      end;
      if VpaNumAtualizacao < 1565 Then
      begin
        VpfErro := '1565';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_MES_SCS NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1565');
      end;
      if VpaNumAtualizacao < 1566 Then
      begin
        VpfErro := '1566';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_ORC_SLO NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1566');
      end;
      if VpaNumAtualizacao < 1567 Then
      begin
        VpfErro := '1567';
        ExecutaComandoSql(Aux,'CREATE TABLE AMOSTRAPRECOCLIENTE ('+
                              ' CODAMOSTRA NUMBER(10,0) NOT NULL, '+
                              ' CODCORAMOSTRA NUMBER(10,0) NOT NULL, '+
                              ' CODCLIENTE NUMBER(10,0) NOT NULL, '+
                              ' CODCOEFICIENTE NUMBER(10,0) NOT NULL, '+
                              ' SEQPRECO NUMBER(10,0) NOT NULL, '+
                              ' QTDAMOSTRA NUMBER(15,3) NULL,'+
                              ' VALVENDA NUMBER(15,3) NULL,'+
                              ' PERLUCRO NUMBER(5,2) NULL,'+
                              ' PERCOMISSAO NUMBER(5,2) NULL,'+
                              ' PRIMARY KEY(CODAMOSTRA,CODCORAMOSTRA,CODCLIENTE,CODCOEFICIENTE,SEQPRECO))');
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRAPRECOCLIENTE add CONSTRAINT AMOSTRAPRECOCLIENTE '+
                              ' FOREIGN KEY (CODAMOSTRA) '+
                              '  REFERENCES AMOSTRA (CODAMOSTRA) ');
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRAPRECOCLIENTE add CONSTRAINT AMOSTRAPRECOCLIENTECLI '+
                              ' FOREIGN KEY (CODCLIENTE) '+
                              '  REFERENCES CADCLIENTES (I_COD_CLI) ');
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRAPRECOCLIENTE add CONSTRAINT AMOSTRAPRECOCLIENTECOE '+
                              ' FOREIGN KEY (CODCOEFICIENTE) '+
                              '  REFERENCES COEFICIENTECUSTO (CODCOEFICIENTE) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1567');
      end;
      if VpaNumAtualizacao < 1568 Then
      begin
        VpfErro := '1568';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVCOMISSOES ADD D_PAG_REC DATE NULL ');
        ExecutaComandoSql(Aux,'Update MOVCOMISSOES COM '+
                          ' SET D_PAG_REC = (SELECT D_DAT_PAG FROM MOVCONTASARECEBER MOV '+
                          ' WHERE MOV.I_EMP_FIL = COM.I_EMP_FIL '+
                          ' AND MOV.I_LAN_REC = COM.I_LAN_REC '+
                          ' AND MOV.I_NRO_PAR = COM.I_NRO_PAR )'+
                          ' WHERE D_DAT_VAL IS NOT NULL' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1568');
      end;
      if VpaNumAtualizacao < 1569 Then
      begin
        VpfErro := '1569';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACONSUMO ADD QTDPONTOSBORDADO NUMBER(10,0) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1569');
      end;
      if VpaNumAtualizacao < 1570 Then
      begin
        VpfErro := '1570';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD (QTDTOTALPONTOSBORDADO NUMBER(10,0) NULL, '+
                                                        ' QTDCORTES NUMBER(10,0) NULL ,' +
                                                        ' QTDTROCALINHA NUMBER(10,0) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1570');
      end;
      if VpaNumAtualizacao < 1571 Then
      begin
        VpfErro := '1571';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLASSIFICACAO ADD N_PER_PER NUMBER(5,2)NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1571');
      end;
      if VpaNumAtualizacao < 1572 Then
      begin
        VpfErro := '1572';
        ExecutaComandoSql(Aux,'DROP TABLE AMOSTRASERVICO ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1572');
      end;
      if VpaNumAtualizacao < 1573 Then
      begin
        VpfErro := '1573';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD (C_ENV_NFE CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CADNOTAFISCAIS set C_ENV_NFE = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1573');
      end;
      if VpaNumAtualizacao < 1574 Then
      begin
        VpfErro := '1574';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_INV CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CADGRUPOS set C_EST_INV = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1574');
      end;
      if VpaNumAtualizacao < 1575 Then
      begin
        VpfErro := '1575';
        ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_IND_REC CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CADEMPRESAS set C_IND_REC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1575');
      end;
      if VpaNumAtualizacao < 1576 Then
      begin
        VpfErro := '1576';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD I_COD_REP NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'CREATE INDEX CADORCAMENTOS_REP ON CADORCAMENTOS(I_COD_REP)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1576');
      end;
      if VpaNumAtualizacao < 1577 Then
      begin
        VpfErro := '1577';
        ExecutaComandoSql(Aux,'ALTER TABLE OPITEMCADARCO ADD DESTAB VARCHAR2(150) NULL');
        ExecutaComandoSql(Aux,'UPDATE OPITEMCADARCO SET DESTAB = NUMTAB');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1577');
      end;
      if VpaNumAtualizacao < 1578 Then
      begin
        VpfErro := '1578';
        ExecutaComandoSql(Aux,'CREATE TABLE AMOSTRACOR ('+
                              ' CODAMOSTRA NUMBER(10) NOT NULL,' +
                              ' CODCOR NUMBER(10) NOT NULL, ' +
                              ' DESIMAGEM VARCHAR2(200) NULL, ' +
                              ' PRIMARY KEY(CODAMOSTRA,CODCOR))');
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACOR add CONSTRAINT AMOSTRACORAMO '+
                              ' FOREIGN KEY (CODAMOSTRA) '+
                              '  REFERENCES AMOSTRA (CODAMOSTRA) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1578');
      end;
      if VpaNumAtualizacao < 1579 Then
      begin
        VpfErro := '1579';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_AMO_FTC CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_AMO_FTC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1579');
      end;
      if VpaNumAtualizacao < 1580 Then
      begin
        VpfErro := '1580';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD DATFICHAAMOSTRA DATE NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1580');
      end;
      if VpaNumAtualizacao < 1581 Then
      begin
        VpfErro := '1581';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD(C_EST_FAP CHAR(1), '+
                              ' C_EST_MAP CHAR(1) NULL, '+
                              ' C_EST_MCP CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_FAP =''F'' ,'+
                              ' C_EST_MAP = ''F'','+
                              ' C_EST_MCP = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1581');
      end;
      if VpaNumAtualizacao < 1582 Then
      begin
        VpfErro := '1582';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD(C_CRM_CAM CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_CRM_CAM =''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1582');
      end;
      if VpaNumAtualizacao < 1583 Then
      begin
        VpfErro := '1583';
        ExecutaComandoSql(Aux,'ALTER TABLE SOLICITACAOCOMPRAITEM ADD(QTDCHAPA NUMBER(10,2) NULL,' +
                              ' LARCHAPA NUMBER(8,2) NULL, ' +
                              ' COMCHAPA NUMBER(8,2) NULL) ' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1583');
      end;
      if VpaNumAtualizacao < 1584 Then
      begin
        VpfErro := '1584';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_EST_CHA CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_EST_CHA = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1584');
      end;
      if VpaNumAtualizacao < 1585 Then
      begin
        VpfErro := '1585';
        ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAITEM ADD(QTDCHAPA NUMBER(10,2) NULL,' +
                              ' LARCHAPA NUMBER(8,2) NULL, ' +
                              ' COMCHAPA NUMBER(8,2) NULL) ' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1585');
      end;
      if VpaNumAtualizacao < 1586 Then
      begin
        VpfErro := '1586';
        ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAFORNECEDORITEM ADD(QTDCHAPA NUMBER(10,2) NULL,' +
                              ' LARCHAPA NUMBER(8,2) NULL, ' +
                              ' COMCHAPA NUMBER(8,2) NULL) ' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1586');
      end;
      if VpaNumAtualizacao < 1587 Then
      begin
        VpfErro := '1587';
        ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES ADD C_PAS_FTP VARCHAR2(150) NULL' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1587');
      end;
      if VpaNumAtualizacao < 1588 Then
      begin
        VpfErro := '1588';
        ExecutaComandoSql(Aux,'ALTER TABLE PEDIDOCOMPRAITEM ADD(QTDCHAPA NUMBER(10,2) NULL,' +
                              ' LARCHAPA NUMBER(8,2) NULL, ' +
                              ' COMCHAPA NUMBER(8,2) NULL) ' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1588');
      end;
      if VpaNumAtualizacao < 1589 Then
      begin
        VpfErro := '1589';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR ADD(N_QTD_CHA NUMBER(10,2) NULL,' +
                              ' N_LAR_CHA NUMBER(8,2) NULL, ' +
                              ' N_COM_CHA NUMBER(8,2) NULL) ' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1589');
      end;
      if VpaNumAtualizacao < 1590 Then
      begin
        VpfErro := '1590';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD(N_DEN_VOL NUMBER(15,4) NULL,' +
                              ' N_ESP_ACO NUMBER(8,4) NULL) ' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1590');
      end;
      if VpaNumAtualizacao < 1591 Then
      begin
        VpfErro := '1591';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_COT_BPN CHAR(1) NULL)' );
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL  SET C_COT_BPN = ''F''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1591');
      end;
      if VpaNumAtualizacao < 1592 Then
      begin
        VpfErro := '1592';
        ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD(C_DES_EMA VARCHAR2(120) NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1592');
      end;
      if VpaNumAtualizacao < 1593 Then
      begin
        VpfErro := '1593';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_COT_REU CHAR(1) NULL)' );
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_REU = ''F''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1593');
      end;
      VpfErro := AtualizaTabela1(VpaNumAtualizacao);
      if VpfErro = '' then
      begin
        VpfErro := AtualizaTabela2(VpaNumAtualizacao);
        if VpfErro = '' then
        begin
          VpfErro := AtualizaTabela3(VpaNumAtualizacao);
          if VpfErro = '' then
          begin
            VpfErro := AtualizaTabela4(VpaNumAtualizacao);
            if VpfErro = '' then
            begin
              VpfErro := AtualizaTabela5(VpaNumAtualizacao);
            end;
          end;
        end;
      end;
      VpfSemErros := true;
    except
      on E : Exception do
      begin
        Aux.sql.SaveToFile('comando.sql');
        Aux.Sql.text := E.message;
        Aux.Sql.SavetoFile('ErroInicio.txt');
        if Confirmacao(VpfErro + ' - Existe uma alteração para ser feita no banco de dados mas existem usuários'+
                    ' utilizando o sistema, ou algum outro sistema sendo utilizado no seu computador, é necessário'+
                    ' que todos os usuários saiam do sistema, para'+
                    ' poder continuar. Deseja continuar agora?') then
        Begin
          VpfSemErros := false;
          AdicionaSQLAbreTabela(Aux,'Select I_Ult_Alt from CFG_GERAL ');
          VpaNumAtualizacao := Aux.FieldByName('I_Ult_Alt').AsInteger;
        end
        else
          exit;
      end;
    end;
  until VpfSemErros;
//  FAbertura.painelTempo1.Fecha;
end;

{******************************************************************************}
function TAtualiza.AtualizaTabela1(VpaNumAtualizacao : Integer): String;
begin
  result := '';
  if VpaNumAtualizacao < 1594 Then
  begin
    result := '1594';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_COT_CAA CHAR(1) NULL)' );
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_CAA = ''F''' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1594');
  end;
  if VpaNumAtualizacao < 1595 Then
  begin
    result := '1595';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD(D_APR_AMO DATE NULL)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1595');
  end;
  if VpaNumAtualizacao < 1596 Then
  begin
    result := '1596';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD(I_QTD_PAR NUMBER(10) NULL)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1596');
  end;
  if VpaNumAtualizacao < 1597 Then
  begin
    result := '1597';
    ExecutaComandoSql(Aux,'ALTER TABLE ETIQUETAPRODUTO ADD(NOMCOR VARCHAR2(60) NULL)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1597');
  end;
  if VpaNumAtualizacao < 1598 Then
  begin
    result := '1598';
    ExecutaComandoSql(Aux,'ALTER TABLE ETIQUETAPRODUTO ADD(NOMCLIENTE VARCHAR2(60) NULL, ' +
                          ' DESORDEMCOMPRA VARCHAR2(40) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1598');
  end;
  if VpaNumAtualizacao < 1599 Then
  begin
    result := '1599';
    ExecutaComandoSql(Aux,'ALTER TABLE ETIQUETAPRODUTO ADD(NOMCOR2 VARCHAR2(60) NULL, ' +
                          ' QTDCOR2 NUMBER(15,3) NULL, ' +
                          ' NOMCOR3 VARCHAR2(60) NULL, ' +
                          ' QTDCOR3 NUMBER(15,3) NULL, ' +
                          ' NOMCOR4 VARCHAR2(60) NULL, ' +
                          ' QTDCOR4 NUMBER(15,3) NULL, ' +
                          ' NOMCOR5 VARCHAR2(60) NULL, ' +
                          ' QTDCOR5 NUMBER(15,3) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1599');
  end;
  if VpaNumAtualizacao < 1600 Then
  begin
    result := '1600';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_TIP_BAD CHAR(2) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_TIP_BAD = ''MA''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1600');
  end;
  if VpaNumAtualizacao < 1601 Then
  begin
    result := '1601';
    ExecutaComandoSql(Aux,'CREATE TABLE CODIGOCLIENTE(CODCLIENTE NUMBER(10) NOT NULL, ' +
                          ' PRIMARY KEY(CODCLIENTE))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1601');
  end;
  if VpaNumAtualizacao < 1602 Then
  begin
    result := '1602';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(I_QTD_CCL NUMBER(10) NULL , '+
                          ' I_ULT_CCG NUMBER(10) NULL ) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1602');
  end;
  if VpaNumAtualizacao < 1603 Then
  begin
    result := '1603';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD(C_FLA_EXP CHAR(1) NULL)' );
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_FLA_EXP = ''S''' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1603');
  end;
  if VpaNumAtualizacao < 1604 Then
  begin
    result := '1604';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_MOD_SIP VARCHAR2(10) NULL)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_MOD_SIP = ''0.001''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1604');
  end;
  if VpaNumAtualizacao < 1605 Then
  begin
    result := '1605';
    ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD C_MOD_SIP CHAR(1) NULL' );
    ExecutaComandoSql(Aux,'Update CADUSUARIOS SET C_MOD_SIP = ''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1605');
  end;
  if VpaNumAtualizacao < 1606 Then
  begin
    result := '1606';
    ExecutaComandoSql(Aux,'CREATE TABLE TABELAIMPORTACAO ( ' +
                          ' CODTABELA NUMBER(10,0) NOT NULL, ' +
                          ' SEQIMPORTACAO NUMBER(10,0) NULL, ' +
                          ' NOMTABELA VARCHAR2(50) NULL, '+
                          ' DESTABELA VARCHAR2(100) NULL, ' +
                          ' DATIMPORTACAO DATE NULL,' +
                          ' DESFILTROVENDEDOR VARCHAR2(50) NULL, ' +
                          ' PRIMARY KEY(CODTABELA))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1606');
  end;
  if VpaNumAtualizacao < 1607 Then
  begin
    result := '1607';
    ExecutaComandoSql(Aux,'CREATE TABLE ESTOQUECHAPA ( ' +
                          ' SEQCHAPA NUMBER(10,0) NOT NULL, ' +
                          ' CODFILIAL NUMBER(10,0) NOT NULL,' +
                          ' SEQPRODUTO NUMBER(10,0) NOT NULL, ' +
                          ' CODCOR NUMBER(10,0) NOT NULL, ' +
                          ' CODTAMANHO NUMBER(10) NOT NULL, ' +
                          ' LARCHAPA NUMBER(8,2) NULL, '+
                          ' COMCHAPA NUMBER(8,2) NULL, '+
                          ' PERCHAPA NUMBER(5,2) NULL,'+
                          ' PESCHAPA NUMBER(15,3) NULL, ' +
                          ' SEQNOTAFORNECEDOR NUMBER(10,0) ,'+
                          ' PRIMARY KEY(SEQCHAPA))');
    ExecutaComandoSql(Aux,'CREATE INDEX ESTOQUECHAPA_FK1 ON ESTOQUECHAPA(CODFILIAL,SEQPRODUTO,CODCOR,CODTAMANHO)');
    ExecutaComandoSql(Aux,'CREATE INDEX ESTOQUECHAPA_FK2 ON ESTOQUECHAPA(CODFILIAL,SEQNOTAFORNECEDOR)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1607');
  end;
  if VpaNumAtualizacao < 1608 Then
  begin
    result := '1608';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTA ADD VALFRETE NUMBER(15,3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1608');
  end;
  if VpaNumAtualizacao < 1609 Then
  begin
    result := '1609';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTA ADD DATPREVISAOVISITATEC DATE');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1609');
  end;
  if VpaNumAtualizacao < 1610 Then
  begin
    result := '1610';
    ExecutaComandoSql(Aux,'ALTER TABLE TABELAIMPORTACAO ADD(DESCAMPODATA VARCHAR2(40),'+
                          ' DATULTIMAALTERACAOMATRIZ DATE NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1610');
  end;
  if VpaNumAtualizacao < 1611 Then
  begin
    result := '1611';
    ExecutaComandoSql(Aux,'ALTER TABLE CONTRATOITEM ADD VALCUSTOPRODUTO NUMBER(15,3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1611');
  end;
  if VpaNumAtualizacao < 1612 Then
  begin
    result := '1612';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_AAA CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_AAA = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1612');
  end;
  if VpaNumAtualizacao < 1613 Then
  begin
    result := '1613';
    ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPCONSUMO ADD VALCUSTOTOTAL NUMBER(15,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1613');
  end;
  if VpaNumAtualizacao < 1614 Then
  begin
    result := '1614';
    ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPCONSUMO ADD PESPRODUTO NUMBER(15,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1614');
  end;
  if VpaNumAtualizacao < 1615 then
  begin
    result := '1615';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD N_QTD_CAN NUMBER(15,3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1615');
  end;
  if VpaNumAtualizacao < 1616 then
  begin
    result := '1616';
    ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD INDAMOSTRAREALIZADA CHAR(1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1616');
  end;
  if VpaNumAtualizacao < 1617 then
  begin
    result := '1617';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD CODDEPARTAMENTOFICHATECNICA NUMBER(10)');
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CRM_FIT CHAR(1)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_FIT = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1617');
  end;
  if VpaNumAtualizacao < 1618 then
  begin
    result := '1618';
    ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES ADD I_TIP_VAL NUMBER(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADVENDEDORES SET I_TIP_VAL = 0');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1618');
  end;
  if VpaNumAtualizacao < 1619 then
  begin
    result := '1619';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCOMISSOES ADD C_LIB_AUT CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE MOVCOMISSOES SET C_LIB_AUT = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1619');
  end;
  if VpaNumAtualizacao < 1620 then
  begin
    result := '1620';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL DROP COLUMN CODDEPARTAMENTOFICHATECNICA ');
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_CRM_FIT NUMBER(10)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1620');
  end;
  if VpaNumAtualizacao < 1621 then
  begin
    result := '1621';
    ExecutaComandoSql(Aux,'ALTER TABLE PLANOCORTECORPO ADD(SEQCHAPA NUMBER(10,0)NULL, '+
                          ' PERCHAPA NUMBER(15,3) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1621');
  end;
  if VpaNumAtualizacao < 1622 then
  begin
    result := '1622';
    ExecutaComandoSql(Aux,'CREATE TABLE ESTAGIOPRODUCAOGRUPOUSUARIO ( '+
                          'CODGRUPOUSUARIO NUMBER(10), '+
                          'CODEST NUMBER(10) REFERENCES ESTAGIOPRODUCAO(CODEST),'+
                          'PRIMARY KEY(CODGRUPOUSUARIO, CODEST))');
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_AUT CHAR(1)');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_AUT = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1622');
  end;
  if VpaNumAtualizacao < 1623 then
  begin
    result := '1623';
    ExecutaComandoSql(Aux,'CREATE TABLE TABELAIMPORTACAOFILTRO( '+
                          ' CODTABELA NUMBER(10) NOT NULL REFERENCES TABELAIMPORTACAO(CODTABELA),' +
                          ' SEQFILTRO NUMBER(10) NOT NULL, ' +
                          ' NOMCAMPO VARCHAR2(50) NULL, ' +
                          ' TIPCAMPO NUMBER(1) NULL, '+
                          ' PRIMARY KEY(CODTABELA,SEQFILTRO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1623');
  end;
  if VpaNumAtualizacao < 1624 then
  begin
    result := '1624';
    ExecutaComandoSql(Aux,'CREATE TABLE TABELAIMPORTACAOIGNORARCAMPO( '+
                          ' CODTABELA NUMBER(10) NOT NULL REFERENCES TABELAIMPORTACAO(CODTABELA),' +
                          ' SEQIGNORAR NUMBER(10) NOT NULL, ' +
                          ' NOMCAMPO VARCHAR2(50) NULL, ' +
                          ' TIPCAMPO NUMBER(1) NULL, '+
                          ' PRIMARY KEY(CODTABELA,SEQIGNORAR))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1624');
  end;
  if VpaNumAtualizacao < 1625 Then
  begin
    result := '1625';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_MOD_PDV VARCHAR2(10) NULL)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_MOD_PDV = ''0.001''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1625');
  end;
  if VpaNumAtualizacao < 1626 Then
  begin
    result := '1626';
    ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD C_MOD_PDV CHAR(1) NULL' );
    ExecutaComandoSql(Aux,'Update CADUSUARIOS SET C_MOD_PDV = ''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1626');
  end;
  if VpaNumAtualizacao < 1627 Then
  begin
    result := '1627';
    ExecutaComandoSql(Aux,'ALTER TABLE ETIQUETAPRODUTO ADD DESMM VARCHAR2(15) NULL' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1627');
  end;
  if VpaNumAtualizacao < 1628 Then
  begin
    result := '1628';
    ExecutaComandoSql(Aux,'ALTER TABLE ETIQUETAPRODUTO ADD(DESREFERENCIACLIENTE VARCHAR2(25) NULL, ' +
                          ' DESCOMPOSICAO VARCHAR2(25) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1628');
  end;
  if VpaNumAtualizacao < 1629 Then
  begin
    result := '1629';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS MODIFY C_SER_NOT VARCHAR2(35) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1629');
  end;
  if VpaNumAtualizacao < 1630 Then
  begin
    result := '1630';
    ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS MODIFY C_SER_NOT VARCHAR2(35) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1630');
  end;
  if VpaNumAtualizacao < 1631 Then
  begin
    result := '1631';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_VAP_OPC CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_VAP_OPC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1631');
  end;
  if VpaNumAtualizacao < 1632 then
  begin
    result := '1632';
    ExecutaComandoSql(Aux,'CREATE TABLE EMAILMEDIDORCORPO (' +
                          ' SEQEMAIL NUMBER(10,0) NOT NULL,' +
                          ' DATENVIO TIMESTAMP(6) NOT NULL,' +
                          ' CODUSUARIO NUMBER(10,0) NOT NULL,' +
                          ' PRIMARY KEY(SEQEMAIL) )');
    ExecutaComandoSql(Aux,'CREATE INDEX EMAILMEDIDORCORPO_DATENVIO ON EMAILMEDIDORCORPO(DATENVIO)');
    ExecutaComandoSql(Aux,'CREATE TABLE EMAILMEDIDORITEM (' +
                          ' SEQEMAIL NUMBER(10,0) NOT NULL REFERENCES EMAILMEDIDORCORPO(SEQEMAIL),' +
                          ' CODFILIAL NUMBER(10,0) NOT NULL,' +
                          ' SEQCONTRATO NUMBER(10,0) NOT NULL,' +
                          ' INDENVIADO CHAR(1) DEFAULT ''N'',' +
                          ' DESSTATUS VARCHAR2(300), ' +
                          ' PRIMARY KEY(SEQEMAIL,CODFILIAL,SEQCONTRATO) )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1632');
  end;
  if VpaNumAtualizacao < 1633 Then
  begin
    result := '1633';
    ExecutaComandoSql(Aux,'CREATE TABLE RETORNOFRACAOOPFACTERCEIRO ('+
                          ' CODFACCIONISTA NUMBER(10,0) NOT NULL, ' +
                          ' SEQITEM NUMBER(10,0) NOT NULL, ' +
                          ' SEQRETORNO NUMBER(10,0) NOT NULL, ' +
                          ' SEQTERCEIRO NUMBER(10,0) NOT NULL, ' +
                          ' NOMTERCEIRO VARCHAR2(50) NULL, ' +
                          ' QTDREVISADO NUMBER(10,0) NULL, ' +
                          ' QTDDEFEITO NUMBER(10,0) NULL, ' +
                          ' PRIMARY KEY(CODFACCIONISTA,SEQITEM, SEQRETORNO,SEQTERCEIRO)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1633');
  end;
  if VpaNumAtualizacao < 1634 Then
  begin
    result := '1634';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_CEC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_CEC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1634');
  end;
  if VpaNumAtualizacao < 1635 Then
  begin
    result := '1635';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_CRM_TMA NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1635');
  end;
  if VpaNumAtualizacao < 1636 Then
  begin
    result := '1636';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (N_CUS_RMA NUMBER(10,2) NULL, ' +
                          ' N_CUS_TAP NUMBER(10,5) NULL, ' +
                          ' N_CUS_INT NUMBER(10,3) NULL, ' +
                          ' N_CUS_QTC NUMBER(10) NULL, ' +
                          ' N_CUS_OPM NUMBER(10) NULL, ' +
                          ' N_CUS_VMD NUMBER(10,5) NULL, ' +
                          ' N_CUS_VMI NUMBER(10,5) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1636');
  end;
  if VpaNumAtualizacao < 1638 then
  begin
    result := '1638';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ORP_OBS CHAR(1) NULL');
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ORP_TER CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORP_TER=''F'',C_ORP_OBS=''F'' ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1638');
  end;
  if VpaNumAtualizacao < 1639 then
  begin
    result := '1639';
    ExecutaComandoSql(Aux,'ALTER TABLE SETOR ADD DESMODELORELATORIO VARCHAR2(50) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1639');
  end;
  if VpaNumAtualizacao < 1640 then
  begin
    result := '1640';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_ALT_PLC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_ALT_PLC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1640');
  end;
  if VpaNumAtualizacao < 1641 then
  begin
    result := '1641';
    ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_IND_DET CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CADEMPRESAS SET C_IND_DET = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1641');
  end;
  if VpaNumAtualizacao < 1642 then
  begin
    result := '1642';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(1,100,''CFG_GERAL'',''CONFIGURACOES DO SISTEMA'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,1,''C_TIP_BAD'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1642');
  end;
  if VpaNumAtualizacao < 1643 then
  begin
    result := '1643';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD D_ULT_ALT DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1643');
  end;
  if VpaNumAtualizacao < 1644 then
  begin
    result := '1644';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(2,200,''CFG_ECF'',''CONFIGURACOES DO ECF'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1644');
  end;
  if VpaNumAtualizacao < 1645 then
  begin
    result := '1645';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_ECF ADD D_ULT_ALT DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1645');
  end;
  if VpaNumAtualizacao < 1646 then
  begin
    result := '1646';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(3,300,''CFG_FISCAL'',''CONFIGURACOES FISCAIS'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1646');
  end;
  if VpaNumAtualizacao < 1647 then
  begin
    result := '1647';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD D_ULT_ALT DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1647');
  end;
  if VpaNumAtualizacao < 1648 then
  begin
    result := '1648';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(4,400,''CFG_PRODUTO'',''CONFIGURACOES PRODUTO'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1648');
  end;
  if VpaNumAtualizacao < 1649 then
  begin
    result := '1649';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD D_ULT_ALT DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1649');
  end;
  if VpaNumAtualizacao < 1650 then
  begin
    result := '1650';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(5,500,''CADEMPRESAS'',''CONFIGURACOES DA EMPRESA'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(5,1,''I_COD_EMP'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1650');
  end;
  if VpaNumAtualizacao < 1651 then
  begin
    result := '1651';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(6,600,''CADFILIAIS'',''CONFIGURACOES DA FILIAL'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(6,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1651');
  end;
  if VpaNumAtualizacao < 1652 then
  begin
    result := '1652';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(7,700,''CAD_PAISES'',''PAISES'',''DAT_ULTIMA_ALTERACAO'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(7,1,''COD_PAIS'',3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1652');
  end;
  if VpaNumAtualizacao < 1653 then
  begin
    result := '1653';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(8,800,''CAD_ESTADOS'',''UNIDADES FEDERADAS'',''DAT_ULTIMA_ALTERACAO'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(8,1,''COD_PAIS'',3)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(8,2,''COD_ESTADO'',3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1653');
  end;
  if VpaNumAtualizacao < 1654 then
  begin
    result := '1654';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(9,900,''CAD_CIDADES'',''CIDADES'',''DAT_ULTIMA_ALTERACAO'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(9,1,''COD_CIDADE'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1654');
  end;
  if VpaNumAtualizacao < 1655 then
  begin
    result := '1655';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(10,1000,''CADREGIAOVENDA'',''REGIOES DE VENDAS'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(10,1,''I_COD_REG'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1655');
  end;
  if VpaNumAtualizacao < 1656 then
  begin
    result := '1656';
    ExecutaComandoSql(Aux,'ALTER TABLE DESENVOLVEDOR ADD DATULTIMAALTERACAO DATE NULL ');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(11,1100,''DESENVOLVEDOR'',''DESENVOLVEDORES'',''DATULTIMAALTERACAO'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(11,1,''CODDESENVOLVEDOR'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1656');
  end;
  if VpaNumAtualizacao < 1657 then
  begin
    result := '1657';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(12,1200,''CADSITUACOESCLIENTES'',''SITUACOES CLIENTES'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(12,1,''I_COD_SIT'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1657');
  end;
  if VpaNumAtualizacao < 1658 then
  begin
    result := '1658';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(13,1300,''CADPROFISSOES'',''PROFISSOES CLIENTES'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(13,1,''I_COD_PRF'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1658');
  end;
  if VpaNumAtualizacao < 1659 then
  begin
    result := '1659';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_EST_FII NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CRM_FII CHAR(1) NULL' );
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_EST_AGU NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CRM_COT CHAR(1) NULL' );
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CRM_OBS CHAR(1) NULL' );
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_COT = ''F''' );
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_FII = ''F''' );
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_OBS = ''F''' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1659');
  end;
  if VpaNumAtualizacao < 1660 then
  begin
    result := '1660';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTA ADD DESOBSERVACAOCOMERCIAL VARCHAR2(300) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1660');
  end;
  if VpaNumAtualizacao < 1661 then
  begin
    result := '1661';
    ExecutaComandoSql(Aux,'ALTER TABLE ordemproducaocorpo ADD DESCOR VARCHAR2(50) NULL');
    ExecutaComandoSql(Aux,'ALTER TABLE ordemproducaocorpo ADD CODTRA NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1661');
  end;
  if VpaNumAtualizacao < 1662 then
  begin
    result := '1662';
    ExecutaComandoSql(Aux,'CREATE TABLE PRODUTOINSTALACAOTEAR( ' +
                          ' SEQPRODUTO NUMBER(10,0) NOT NULL, ' +
                          ' SEQINSTALACAO NUMBER(10,0) NOT NULL, ' +
                          ' CODCOR NUMBER(10,0) NULL, ' +
                          ' QTDFIOLICO NUMBER(5) NULL, ' +
                          ' DESFUNCAOFIO CHAR(1) NULL, ' +
                          ' NUMLINHA NUMBER(3) NULL, ' +
                          ' NUMCOLUNA NUMBER(3) NULL, ' +
                          ' PRIMARY KEY(SEQPRODUTO,SEQINSTALACAO))');
    ExecutaComandoSql(Aux,'CREATE INDEX PRODUTOINSTALACAOTEAR_FK1 ON PRODUTOINSTALACAOTEAR(SEQPRODUTO)');
    ExecutaComandoSql(Aux,'CREATE INDEX PRODUTOINSTALACAOTEAR_FK2 ON PRODUTOINSTALACAOTEAR(CODCOR)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1662');
  end;
  if VpaNumAtualizacao < 1663 then
  begin
    result := '1663';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(14,1400,''CADUSUARIOS'',''CADASTRO DE USUARIOS'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(14,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(14,2,''I_COD_USU'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1663');
  end;
  if VpaNumAtualizacao < 1664 then
  begin
    result := '1664';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(15,1350,''CADGRUPOS'',''CADASTRO DE GRUPOS DE USUARIOS'',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(15,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(15,2,''I_COD_GRU'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1664');
  end;
  if VpaNumAtualizacao < 1665 then
  begin
    result := '1665';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(16,1500,''CADCONDICOESPAGTO'',''CADASTRO DE CONDICOES DE PAGAMENTO'',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(16,1,''I_COD_PAG'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1665');
  end;
  if VpaNumAtualizacao < 1666 then
  begin
    result := '1666';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(17,1600,''CADFORMASPAGAMENTO'',''CADASTRO DE FORMAS DE PAGAMENTO'',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(17,1,''I_COD_FRM'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1666');
  end;
  if VpaNumAtualizacao < 1667 then
  begin
    result := '1667';
    ExecutaComandoSql(Aux,'ALTER TABLE TECNICO ADD DATULTIMAALTERACAO DATE');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(18,1700,''TECNICO'',''CADASTRO DE TECNICOS'',''DATULTIMAALTERACAO'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(18,1,''CODTECNICO'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1667');
  end;
  if VpaNumAtualizacao < 1668 then
  begin
    result := '1668';
    ExecutaComandoSql(Aux,'ALTER TABLE RAMO_ATIVIDADE ADD DAT_ULTIMA_ALTERACAO DATE');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(19,1800,''RAMO_ATIVIDADE'',''CADASTRO DE RAMOS DE ATIVIDADES'',''DAT_ULTIMA_ALTERACAO'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(19,1,''COD_RAMO_ATIVIDADE'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1668');
  end;

  if VpaNumAtualizacao < 1669 then
  begin
    result := '1669';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(20,1900,''CADTRANSPORTADORAS'',''CADASTRO DE TRANSPORTADORAS'',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(20,1,''I_COD_TRA'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1670');
  end;
  if VpaNumAtualizacao < 1670 then
  begin
    result := '1670';
    ExecutaComandoSql(Aux,'ALTER TABLE CONCORRENTE ADD DATULTIMAALTERACAO DATE');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(21,2000,''CONCORRENTE'',''CADASTRO DE CONCORRENTES '',''DATULTIMAALTERACAO'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(21,1,''CODCONCORRENTE'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1670');
  end;
  if VpaNumAtualizacao < 1671 then
  begin
    result := '1671';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(22,2100,''CADTABELAPRECO'',''CADASTRO DE TABELA DE PRECOS'',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(22,1,''I_COD_EMP'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(22,2,''I_COD_TAB'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1671');
  end;
  if VpaNumAtualizacao < 1672 then
  begin
    result := '1672';
    ExecutaComandoSql(Aux,'ALTER TABLE CADTIPOORCAMENTO ADD D_ULT_ALT DATE');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(23,2200,''CADTIPOORCAMENTO'',''CADASTRO DE TIPOS DE COTACOES '',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(23,1,''I_COD_TIP'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1672');
  end;
  if VpaNumAtualizacao < 1673 then
  begin
    result := '1673';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(24,2300,''CADBANCOS'',''CADASTRO DE BANCOS '',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(24,1,''I_COD_BAN'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1673');
  end;
  if VpaNumAtualizacao < 1674 then
  begin
    result := '1674';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(25,2400,''CADCONTAS'',''CADASTRO DE CONTA CORRENTE '',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(25,1,''C_NRO_CON'',3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1674');
  end;
  if VpaNumAtualizacao < 1675 then
  begin
    result := '1675';
    ExecutaComandoSql(Aux,'ALTER TABLE MEIODIVULGACAO ADD DATULTIMAALTERACAO DATE');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(26,2500,''MEIODIVULGACAO'',''CADASTRO DE MEIOS DE DIVULGACAO '',''DATULTIMAALTERACAO'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(26,1,''CODMEIODIVULGACAO'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1675');
  end;

  if VpaNumAtualizacao < 1676 then
  begin
    result := '1676';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (I_QTD_QUA NUMBER(10) NULL, '+
                           ' I_QTD_COL NUMBER(10) NULL,' +
                           ' I_QTD_LIN NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'ALTER TABLE PRODUTOINSTALACAOTEAR ADD SEQMATERIAPRIMA NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1676');
  end;

  if VpaNumAtualizacao < 1677 then
  begin
    result := '1677';

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(27,2600,''CAD_PLANO_CONTA'',''CADASTRO DE PLANOS DE CONTA'',''D_ULT_ALT'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(27,1,''C_CLA_PLA'',3)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(27,2,''I_COD_EMP'',1)');

    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1677');
  end;

  if VpaNumAtualizacao < 1678 then
  begin
    result := '1678';

    ExecutaComandoSql(Aux,'ALTER TABLE MARCA ADD DATULTIMAALTERACAO DATE');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(28,2700,''MARCA'',''CADASTRO DE MARCA '',''DATULTIMAALTERACAO'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(28,1,''CODMARCA'',1)');

    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1678');
  end;

  if VpaNumAtualizacao < 1679 then
  begin
    result := '1679';

    ExecutaComandoSql(Aux,'ALTER TABLE FAIXAETARIA ADD DATULTIMAALTERACAO DATE');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(29,2800,''FAIXAETARIA'',''CADASTRO DE FAIXA ETARIA'',''DATULTIMAALTERACAO'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(29,1,''CODFAIXAETARIA'',1)');

    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1679');
  end;

  if VpaNumAtualizacao < 1680 then
  begin
    result := '1680';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_ABE_CAB VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_CON_ELE VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_TEN_ALI VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_COM_RED VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_GRA_PRO VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_SEN_FER VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_SEN_NFE VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_ACO_INO VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD L_DES_FUN VARCHAR2(300)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD L_INF_DIS VARCHAR2(300)');

    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1680');
  end;
  if VpaNumAtualizacao < 1681 then
  begin
    result := '1681';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_EST_AVN CHAR(1) NULL, '+
                          ' C_EST_SCC CHAR(1) NULL )' );
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_AVN = ''T'','+
                           ' C_EST_SCC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1681');
  end;
  if VpaNumAtualizacao < 1682 then
  begin
    result := '1682';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLASSIFICACAO ADD (C_IND_INS CHAR(1) NULL )' );
    ExecutaComandoSql(Aux,'UPDATE CADCLASSIFICACAO SET C_IND_INS = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1682');
  end;
  if VpaNumAtualizacao < 1683 then
  begin
    result := '1683';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_EST_CSC CHAR(1) NULL, '+
                          ' C_EST_CPC CHAR(1) NULL )' );
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_CSC = ''T'','+
                           ' C_EST_CPC = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1683');
  end;
  if VpaNumAtualizacao < 1684 then
  begin
    result := '1684';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_ULT_PR1 NUMBER(10) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1684');
  end;
  if VpaNumAtualizacao < 1685 then
  begin
    result := '1685';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_SIP_VEN NUMBER(10) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1685');
  end;
  if VpaNumAtualizacao < 1686 then
  begin
    result := '1686';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,2,''I_SIP_VEN'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1686');
  end;
  if VpaNumAtualizacao < 1687 then
  begin
    result := '1687';

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,DESFILTROVENDEDOR) '   +
                          ' VALUES(30,2900,''CADVENDEDORES'',''CADASTRO DE VENDEDORES'',''D_ULT_ALT'',''I_COD_VEN'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(30,1,''I_COD_VEN'',1)');

    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1687');
  end;
  if VpaNumAtualizacao < 1688 then
  begin
    result := '1688';

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,DESFILTROVENDEDOR) '   +
                          ' VALUES(31,3100,''CADCLIENTES'',''CADASTRO DE CLIENTES'',''D_ULT_ALT'',''I_COD_VEN'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(31,1,''I_COD_CLI'',1)');

    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1688');
  end;
  if VpaNumAtualizacao < 1689 then
  begin
    result := '1689';
    ExecutaComandoSql(Aux,'CREATE INDEX CADCLIENTES_CP11 ON CADCLIENTES(C_FLA_EXP)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1689');
  end;
  if VpaNumAtualizacao < 1690 then
  begin
    result := '1690';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD(C_VER_PED VARCHAR2(15) NULL, ' +
                          '                            C_COM_PED VARCHAR2(50) NULL, ' +
                          '                            D_DAT_EXP DATE NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1690');
  end;
  if VpaNumAtualizacao < 1691 Then
  begin
    result := '1691';
    ExecutaComandoSql(Aux,'CREATE TABLE NUMEROPEDIDO( '+
                          ' CODFILIAL  NUMBER(10) NOT NULL, ' +
                          ' NUMPEDIDO NUMBER(10) NOT NULL, '+
                          ' PRIMARY KEY(CODFILIAL,NUMPEDIDO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1691');
  end;
  if VpaNumAtualizacao < 1691 Then
  begin
    result := '1691';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_QTD_NPE NUMBER(10)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET I_QTD_NPE = 5000');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1691');
  end;
  if VpaNumAtualizacao < 1692 Then
  begin
    result := '1692';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD I_ULT_PED NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1692');
  end;
  if VpaNumAtualizacao < 1693 Then
  begin
    result := '1693';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD C_FLA_EXP CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS set C_FLA_EXP = ''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1693');
  end;
  if VpaNumAtualizacao < 1694 then
  begin
    result := '1694';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) '   +
                          ' VALUES(32,1550,''MOVCONDICAOPAGTO'',''PARCELAS DA CONDICAO DE PAGAMENTO'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(32,1,''I_COD_PAG'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(32,2,''I_NRO_PAR'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1694');
  end;
  if VpaNumAtualizacao < 1695 then
  begin
    result := '1695';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,3,''C_DIR_REL'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,4,''C_DIR_VER'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1695');
  end;
  if VpaNumAtualizacao < 1696 then
  begin
    result := '1696';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD(C_VER_PED VARCHAR2(15) NULL, ' +
                          '                            C_COM_PED VARCHAR2(50) NULL, ' +
                          '                            D_DAT_EXP DATE NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1696');
  end;
  if VpaNumAtualizacao < 1697 then
  begin
    result := '1697';
    ExecutaComandoSql(Aux,'ALTER TABLE PRODUTOIMPRESSORA ADD DATULTIMAALTERACAO DATE');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1697');
  end;
  if VpaNumAtualizacao < 1698 then
  begin
    result := '1698';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                          ' VALUES(49,4700,''PRODUTOIMPRESSORA'',''IMPRESSORAS DO PRODUTO'',''DATULTIMAALTERACAO'', ''S'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(49,1,''SEQPRODUTO'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(49,2,''SEQIMPRESSORA'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1698');
  end;
  if VpaNumAtualizacao < 1699 then
  begin
    result := '1699';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                          ' VALUES(50,4800,''MOVKIT'',''CONSUMO DO PRODUTO'',''D_ULT_ALT'', ''S'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(50,1,''I_PRO_KIT'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(50,2,''I_SEQ_MOV'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(50,3,''I_COR_KIT'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1699');
  end;
  if VpaNumAtualizacao < 1700 then
  begin
    result := '1700';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                          ' VALUES(51,4900,''MOVTABELAPRECO'',''TABELA DE PRECO'',''D_ULT_ALT'', ''S'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(51,1,''I_COD_EMP'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(51,2,''I_COD_TAB'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(51,3,''I_SEQ_PRO'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(51,4,''I_COD_CLI'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(51,5,''I_COD_TAM'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(51,6,''I_COD_COR'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1700');
  end;
  if VpaNumAtualizacao < 1701 then
  begin
    result := '1701';
    ExecutaComandoSql(Aux,'UPDATE MOVTABELAPRECO SET D_ULT_ALT = TO_DATE(''1/1/2000'',''DD/MM/YYYY'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1701');
  end;
  if VpaNumAtualizacao < 1702 then
  begin
    result := '1702';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                          ' VALUES(52,5000,''MOVQDADEPRODUTO'',''ESTOQUE PRODUTOS'',''D_ULT_ALT'', ''S'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(52,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(52,2,''I_SEQ_PRO'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(52,3,''I_COD_TAM'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(52,4,''I_COD_COR'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1702');
  end;
  if VpaNumAtualizacao < 1703 then
  begin
    result := '1703';
    ExecutaComandoSql(Aux,'UPDATE MOVQDADEPRODUTO SET D_ULT_ALT = TO_DATE(''1/1/2000'',''DD/MM/YYYY'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1703');
  end;
  if VpaNumAtualizacao < 1704 then
  begin
    result := '1704';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR,DESFILTROVENDEDOR) '   +
                          ' VALUES(53,5100,''CADORCAMENTOS'',''COTACOES'',''D_ULT_ALT'', ''S'',''I_COD_VEN'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(53,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(53,2,''I_LAN_ORC'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1704');
  end;
  if VpaNumAtualizacao < 1705 then
  begin
    result := '1705';
    ExecutaComandoSql(Aux,'CREATE TABLE TABELAIMPORTACAOCAMPOPAIFILHO ( ' +
                          ' CODTABELA NUMBER(10) NOT NULL  REFERENCES TABELAIMPORTACAO(CODTABELA), '+
                          ' SEQCAMPO NUMBER(10) NOT NULL, ' +
                          ' NOMCAMPO VARCHAR2(50) NULL, ' +
                          ' NOMCAMPOPAI VARCHAR2(50) NULL, ' +
                          ' PRIMARY KEY(CODTABELA,SEQCAMPO))');
    ExecutaComandoSql(Aux,'CREATE INDEX TABELAIMPORTCAMPOPAIFILHO_FK ON TABELAIMPORTACAOCAMPOPAIFILHO(CODTABELA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1705');
  end;
  if VpaNumAtualizacao < 1706 then
  begin
    result := '1706';
    ExecutaComandoSql(Aux,'ALTER TABLE TABELAIMPORTACAO ADD NOMTABELAPAI VARCHAR2(50) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1706');
  end;
  if VpaNumAtualizacao < 1707 then
  begin
    result := '1707';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR,DESFILTROVENDEDOR, NOMTABELAPAI) '   +
                          ' VALUES(54,5400,''MOVORCAMENTOS'',''PRODUTOS DAS COTACOES'',''D_ULT_ALT'', ''S'',''I_COD_VEN'',''CADORCAMENTOS'')');

    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(54,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(54,2,''I_LAN_ORC'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(54,3,''I_SEQ_MOV'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOCAMPOPAIFILHO(CODTABELA,SEQCAMPO,NOMCAMPO,NOMCAMPOPAI) ' +
                          ' VALUES(54,1,''I_EMP_FIL'',''I_EMP_FIL'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOCAMPOPAIFILHO(CODTABELA,SEQCAMPO,NOMCAMPO,NOMCAMPOPAI) ' +
                          ' VALUES(54,2,''I_LAN_ORC'',''I_LAN_ORC'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1707');
  end;
  if VpaNumAtualizacao < 1708 then
  begin
    result := '1708';
    ExecutaComandoSql(Aux,'UPDATE CAD_CIDADES SET DAT_ULTIMA_ALTERACAO = TO_DATE(''1/1/2000'',''DD/MM/YYYY'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1708');
  end;
  if VpaNumAtualizacao < 1709 then
  begin
    result := '1709';
    ExecutaComandoSql(Aux,'UPDATE TABELAIMPORTACAO SET DATULTIMAALTERACAOMATRIZ = TO_DATE(''1/1/2000'',''DD/MM/YYYY'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1709');
  end;
  if VpaNumAtualizacao < 1710 then
  begin
    result := '1710';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASAPAGAR ADD C_IND_PRE CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADCONTASAPAGAR SET C_IND_PRE = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1710');
  end;
  if VpaNumAtualizacao < 1711 then
  begin
    result := '1711';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_CPV CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_CPV = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1711');
  end;
  if VpaNumAtualizacao < 1712 then
  begin
    result := '1712';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_SIP_ITV CHAR(1) NULL, '+
                           ' C_SIP_OBR VARCHAR2(10) NULL)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_SIP_ITV = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_MOD_SIP = ''0.001''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_SIP_OBR = ''0.006''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1712');
  end;
  if VpaNumAtualizacao < 1713 then
  begin
    result := '1713';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,5,''C_SIP_ITV'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1713');
  end;
  if VpaNumAtualizacao < 1714 then
  begin
    result := '1714';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (D_ULT_IMP DATE NULL) ');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,6,''D_ULT_IMP'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1714');
  end;
  if VpaNumAtualizacao < 1715 then
  begin
    result := '1715';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_GER_APP CHAR(1) NULL) ');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_GER_APP = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1715');
  end;
  if VpaNumAtualizacao < 1716 then
  begin
    result := '1716';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (N_PAR_MIN NUMBER(15,3) NULL,  '+
                          ' C_PAR_MIN CHAR(1) NULL )');
    ExecutaComandoSql(Aux,'Update CADGRUPOS set C_PAR_MIN = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1716');
  end;
  if VpaNumAtualizacao < 1717 then
  begin
    result := '1717';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD (I_CFO_PRO NUMBER(6) NULL,  '+
                          ' I_CFO_SER NUMBER(6) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1717');
  end;
  if VpaNumAtualizacao < 1718 then
  begin
    result := '1718';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_EMA_NFE VARCHAR2(100) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1718');
  end;
  if VpaNumAtualizacao < 1719 then
  begin
    result := '1719';
    ExecutaComandoSql(Aux,'ALTER TABLE PEDIDOCOMPRACORPO ADD TIPPEDIDO CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE PEDIDOCOMPRACORPO SET TIPPEDIDO = ''P''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1719');
  end;
  if VpaNumAtualizacao < 1720 then
  begin
    result := '1720';
    ExecutaComandoSql(Aux,'CREATE TABLE AMOSTRAITEMESPECIAL (' +
                          ' CODAMOSTRA NUMBER(10) NULL REFERENCES AMOSTRA(CODAMOSTRA), ' +
                          ' SEQITEM NUMBER(10) NULL, ' +
                          ' SEQPRODUTO NUMBER(10) NULL, ' +
                          ' VALITEM NUMBER(15,3) NULL, ' +
                          ' DESOBSERVACAO VARCHAR2(200) NULL, ' +
                          ' PRIMARY KEY(CODAMOSTRA, SEQITEM)) ');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRAITEMESPECIAL_FK1 ON AMOSTRAITEMESPECIAL(CODAMOSTRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1720');
  end;
  if VpaNumAtualizacao < 1721 then
  begin
    result := '1721';
    ExecutaComandoSql(Aux,'DROP TABLE AMOSTRASERVICOFIXO');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1721');
  end;
end;

{******************************************************************************}
function TAtualiza.AtualizaTabela2(VpaNumAtualizacao: Integer): String;
begin
  RESULT := '';
  if VpaNumAtualizacao < 1722 then
  begin
    result := '1722';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_SUB_TRI CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CADPRODUTOS SET C_SUB_TRI = ''N''');
    ExecutaComandoSql(Aux,'Update CADPRODUTOS SET C_SUB_TRI = ''S'''+
                          ' Where N_RED_ICM < 0 ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1722');
  end;
  if VpaNumAtualizacao < 1723 then
  begin
    result := '1723';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD C_TIP_EMI CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update MOVNATUREZA SET C_TIP_EMI = ''P'''+
                          ' Where C_ENT_SAI = ''S''');
    ExecutaComandoSql(Aux,'Update MOVNATUREZA SET C_TIP_EMI = ''F'''+
                          ' Where C_ENT_SAI = ''E''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1723');
  end;
  if VpaNumAtualizacao < 1724 then
  begin
    result := '1724';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_ESR CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CADGRUPOS SET C_EST_ESR = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1724');
  end;
  if VpaNumAtualizacao < 1725 then
  begin
    result := '1725';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_DES_BCI CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CADPRODUTOS SET C_DES_BCI = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1725');
  end;
  if VpaNumAtualizacao < 1726 then
  begin
    result := '1726';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_MET_CUS NUMBER(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_PRODUTO SET I_MET_CUS = 0');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1726');
  end;
  if VpaNumAtualizacao < 1727 then
  begin
    result := '1727';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTO MODIFY NOMPRODUTO VARCHAR2(80)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1727');
  end;
  if VpaNumAtualizacao < 1728 then
  begin
    result := '1728';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD C_COT_TRA VARCHAR2(30) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1728');
  end;
  if VpaNumAtualizacao < 1729 then
  begin
    result := '1729';
    ExecutaComandoSql(Aux,'ALTER TABLE CADICMSESTADOS ADD N_RED_ICM NUMBER(6,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1729');
  end;
  if VpaNumAtualizacao < 1730 then
  begin
    result := '1730';
    ExecutaComandoSql(Aux,'CREATE TABLE AMOSTRALOG ( ' +
                          ' CODAMOSTRA NUMBER(10) NOT NULL REFERENCES AMOSTRA(CODAMOSTRA), ' +
                          ' SEQLOG NUMBER(10) NOT NULL,' +
                          ' CODUSUARIO NUMBER(10) NOT NULL, ' +
                          ' DATLOG DATE NOT NULL, ' +
                          ' DESLOCALARQUIVO VARCHAR2(200) NULL, ' +
                          ' PRIMARY KEY(CODAMOSTRA,SEQLOG))');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRALOG_FK1 ON AMOSTRALOG(CODAMOSTRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1730');
  end;
  if VpaNumAtualizacao < 1731 then
  begin
    result := '1731';
    ExecutaComandoSql(Aux,'CREATE TABLE AMOSTRACONSUMOLOG ( ' +
                          ' CODAMOSTRA NUMBER(10) NOT NULL REFERENCES AMOSTRA(CODAMOSTRA), ' +
                          ' CODCOR NUMBER(10) NOT NULL, ' +
                          ' SEQLOG NUMBER(10) NOT NULL,' +
                          ' CODUSUARIO NUMBER(10) NOT NULL, ' +
                          ' DATLOG DATE NOT NULL, ' +
                          ' DESLOCALARQUIVO VARCHAR2(200) NULL, ' +
                          ' PRIMARY KEY(CODAMOSTRA,CODCOR,SEQLOG))');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRACONSUMOLOG_FK1 ON AMOSTRACONSUMOLOG(CODAMOSTRA,CODCOR)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1731');
  end;
  if VpaNumAtualizacao < 1732 then
  begin
    result := '1732';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD N_RED_BAS NUMBER(6,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1732');
  end;
  if VpaNumAtualizacao < 1733 then
  begin
    result := '1733';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA MODIFY C_COD_NAT VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADNATUREZA MODIFY C_COD_NAT VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS MODIFY C_COD_NAT VARCHAR2(20)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR MODIFY C_COD_NAT VARCHAR2(20)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1732');
  end;
  if VpaNumAtualizacao < 1734 then
  begin
    result := '1734';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD (I_CFO_SUB NUMBER(6) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1734');
  end;
  if VpaNumAtualizacao < 1735 then
  begin
    result := '1735';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_NAT_STD VARCHAR2(15) NULL, ' +
                          ' C_NAT_STF VARCHAR2(15) NULL, ' +
                          ' C_NAT_SPD VARCHAR2(15) NULL, ' +
                          ' C_NAT_SPF VARCHAR2(15) NULL, ' +
                          ' C_NAT_SSD VARCHAR2(15) NULL, ' +
                          ' C_NAT_SSF VARCHAR2(15) NULL, ' +
                          ' C_NST_SPD VARCHAR2(20) NULL, ' +
                          ' C_NST_SPF VARCHAR2(20) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1735');
  end;
  if VpaNumAtualizacao < 1736 then
  begin
    result := '1736';
    ExecutaComandoSql(Aux,'ALTER TABLE CADICMSESTADOS ADD C_SUB_TRI CHAR(1)');
    ExecutaComandoSql(Aux,'UPDATE CADICMSESTADOS SET C_SUB_TRI = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1736');
  end;
  if VpaNumAtualizacao < 1737 then
  begin
    result := '1737';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD N_PER_SUT NUMBER(6,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1737');
  end;
  if VpaNumAtualizacao < 1738 then
  begin
    result := '1738';
    ExecutaComandoSql(Aux,'CREATE TABLE PEDIDOCOMPRAITEMCONSUMOFRACAO ( ' +
                          ' CODFILIAL NUMBER(10,0) NOT NULL, ' +
                          ' SEQPEDIDO NUMBER(10,0) NOT NULL, ' +
                          ' SEQITEM NUMBER(10,0) NOT NULL, ' +
                          ' CODFILIALFRACAO NUMBER(10,0) NOT NULL, ' +
                          ' SEQORDEM NUMBER(10,0) NOT NULL, ' +
                          ' SEQFRACAO NUMBER(10,0) NOT NULL, ' +
                          ' SEQCONSUMO NUMBER(10,0) NOT NULL, ' +
                          ' PRIMARY KEY(CODFILIAL, SEQPEDIDO, SEQITEM, CODFILIALFRACAO, SEQORDEM,SEQFRACAO, SEQCONSUMO))');
    ExecutaComandoSql(Aux,'ALTER TABLE PEDIDOCOMPRAITEMCONSUMOFRACAO add CONSTRAINT PEDIDOCOMPRAITEM_CONSUMOFRA '+
                          ' FOREIGN KEY (CODFILIAL,SEQPEDIDO,SEQITEM) '+
                          ' REFERENCES PEDIDOCOMPRAITEM (CODFILIAL,SEQPEDIDO,SEQITEM) ');
    ExecutaComandoSql(Aux,'ALTER TABLE PEDIDOCOMPRAITEMCONSUMOFRACAO add CONSTRAINT CONSUMOFRACAO_PEDIDOITEM '+
                          ' FOREIGN KEY (CODFILIALFRACAO,SEQORDEM,SEQFRACAO,SEQCONSUMO) '+
                          '  REFERENCES FRACAOOPCONSUMO (CODFILIAL,SEQORDEM,SEQFRACAO,SEQCONSUMO) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1738');
  end;
  if VpaNumAtualizacao < 1739 then
  begin
    result := '1739';
    ExecutaComandoSql(Aux,'ALTER TABLE COR ADD DATULTIMAALTERACAO DATE NULL ');
    ExecutaComandoSql(Aux,'Update COR set DATULTIMAALTERACAO = SYSDATE ');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(55,4050,''COR'',''CORES'',''DATULTIMAALTERACAO'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(55,1,''COD_COR'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1739');
  end;
  if VpaNumAtualizacao < 1740 then
  begin
    result := '1740';
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_SIP_OBR = ''0.010''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1740');
  end;
  if VpaNumAtualizacao < 1741 then
  begin
    result := '1741';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,7,''I_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOIGNORARCAMPO(CODTABELA, SEQIGNORAR,NOMCAMPO) ' +
                          ' VALUES(1,8,''I_ULT_PR1'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1741');
  end;
  if VpaNumAtualizacao < 1742 then
  begin
    result := '1742';
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_SIP_OBR = ''0.011''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1742');
  end;
  if VpaNumAtualizacao < 1743 then
  begin
    result := '1743';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD (I_CFO_STR NUMBER(6) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1743');
  end;
  if VpaNumAtualizacao < 1744 then
  begin
    result := '1744';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTAORCAMENTO ADD (I_FIL_ORC NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update MOVNOTAORCAMENTO SET I_FIL_ORC = I_EMP_FIL');
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTAORCAMENTO drop PRIMARY KEY');
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTAORCAMENTO '+
                          ' ADD PRIMARY KEY(I_EMP_FIL,I_SEQ_NOT,I_LAN_ORC,I_FIL_ORC)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1744');
  end;
  if VpaNumAtualizacao < 1745 then
  begin
    result := '1745';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD( I_COT_LCP NUMBER(4) NULL, ' +
                          ' I_COT_LCC NUMBER(4) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_COT_LCP = 450, I_COT_LCC = 200');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1745');
  end;
  if VpaNumAtualizacao < 1746 then
  begin
    result := '1746';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS MODIFY C_NOM_PRO VARCHAR2(100)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1746');
  end;
  if VpaNumAtualizacao < 1747 then
  begin
    result := '1747';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_SAL_NMC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_SAL_NMC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1747');
  end;
  if VpaNumAtualizacao < 1748 then
  begin
    result := '1748';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_NAT_RED VARCHAR2(15) NULL, ' +
                          ' C_NAT_REF VARCHAR2(15) NULL, ' +
                          ' C_NAT_RID VARCHAR2(15) NULL, ' +
                          ' C_NAT_RIF VARCHAR2(15) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1748');
  end;
  if VpaNumAtualizacao < 1749 then
  begin
    result := '1749';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD (I_CFO_PRR NUMBER(6) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1749');
  end;
  if VpaNumAtualizacao < 1750 then
  begin
    result := '1750';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_NST_RED VARCHAR2(15) NULL, ' +
                          ' C_NST_REF VARCHAR2(15) NULL, ' +
                          ' C_NST_RID VARCHAR2(15) NULL, ' +
                          ' C_NST_RIF VARCHAR2(15) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1750');
  end;
  if VpaNumAtualizacao < 1751 then
  begin
    result := '1751';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD (C_MOV_FIS CHAR(1) NULL)');
    ExecutaComandoSql(Aux,'UPDATE MOVNATUREZA SET C_MOV_FIS = ''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1751');
  end;
  if VpaNumAtualizacao < 1752 then
  begin
    result := '1752';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD (I_DES_PRO NUMBER(2) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1752');
  end;
  if VpaNumAtualizacao < 1753 then
  begin
    result := '1753';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_ECF ADD (NUMPORTA NUMBER(2) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1753');
  end;
  if VpaNumAtualizacao < 1754 then
  begin
    result := '1754';
    ExecutaComandoSql(Aux,'UPDATE MOVNOTAORCAMENTO ' +
                          ' SET I_LAN_ORC = I_FIL_ORC  ' +
                          ' WHERE I_FIL_ORC > 100');
    ExecutaComandoSql(Aux,'UPDATE MOVNOTAORCAMENTO ' +
                          ' SET I_FIL_ORC = 11  ' +
                          ' WHERE I_FIL_ORC > 100');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1753');
  end;
  if VpaNumAtualizacao < 1755 then
  begin
    result := '1755';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD(C_COD_REC VARCHAR2(30), ' +
                          ' I_DIA_VIC NUMBER(2) )');
    ExecutaComandoSql(Aux,'Update CADFILIAIS SET I_DIA_VIC = 20');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1755');
  end;
  if VpaNumAtualizacao < 1756 then
  begin
    result := '1756';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_NAT_SRD VARCHAR2(15) NULL, ' +
                          ' C_NAT_SRF VARCHAR2(15) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1756');
  end;
  if VpaNumAtualizacao < 1757 then
  begin
    result := '1757';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR MODIFY C_COD_CST VARCHAR2(3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1757');
  end;
  if VpaNumAtualizacao < 1758 then
  begin
    result := '1758';
    ExecutaComandoSql(Aux,'DROP TABLE PEDIDOCOMPRAITEMCONSUMOFRACAO ');
    ExecutaComandoSql(Aux,'CREATE TABLE PEDIDOCOMPRAITEMMATERIAPRIMA( '+
                          ' CODFILIAL NUMBER(10,0) NOT NULL, ' +
                          ' SEQPEDIDO NUMBER(10) NOT NULL, ' +
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' SEQITEMMP NUMBER(10) NOT NULL, ' +
                          ' SEQPRODUTO NUMBER(10) NOT NULL, ' +
                          ' CODCOR NUMBER(10) NULL, ' +
                          ' QTDPRODUTO NUMBER(15,3) NULL, ' +
                          ' QTDCHAPA NUMBER(10) NULL, ' +
                          ' LARCHAPA NUMBER(10) NULL, ' +
                          ' COMCHAPA NUMBER(10) NULL, ' +
                          ' PRIMARY KEY (CODFILIAL,SEQPEDIDO,SEQITEM,SEQITEMMP))');
    ExecutaComandoSql(Aux,'ALTER TABLE PEDIDOCOMPRAITEMMATERIAPRIMA add CONSTRAINT PEDIDOCOMPRAITEM_MP '+
                          ' FOREIGN KEY (CODFILIAL,SEQPEDIDO,SEQITEM) '+
                          ' REFERENCES PEDIDOCOMPRAITEM (CODFILIAL,SEQPEDIDO,SEQITEM) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1758');
  end;
  if VpaNumAtualizacao < 1759 then
  begin
    result := '1759';
    ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPESTAGIO ADD INDTERCEIRIZADO CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE FRACAOOPESTAGIO SET INDTERCEIRIZADO = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1759');
  end;
  if VpaNumAtualizacao < 1760 then
  begin
    result := '1760';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD I_CON_PAD NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1760');
  end;
  if VpaNumAtualizacao < 1761 then
  begin
    result := '1761';
    ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_PLA_PAD VARCHAR2(20) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1761');
  end;
  if VpaNumAtualizacao < 1762 then
  begin
    result := '1762';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_NAR_ISD VARCHAR2(15) NULL, ' +
                          ' C_NAR_ISF VARCHAR2(15) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1762');
  end;
  if VpaNumAtualizacao < 1763 then
  begin
    result := '1763';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_ENG_TRA VARCHAR2(15) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1763');
  end;
  if VpaNumAtualizacao < 1764 then
  begin
    result := '1764';
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAFORNECEDORITEM ADD PERICMS NUMBER(5,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1764');
  end;
  if VpaNumAtualizacao < 1765 then
  begin
    result := '1765';
    ExecutaComandoSql(Aux,'alter table MOVORCAMENTOS ADD N_CUS_UNI NUMBER(15,3)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1765');
  end;
  if VpaNumAtualizacao < 1766 then
  begin
    result := '1766';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_SUT_RSD VARCHAR2(15) NULL, ' +
                          ' C_SUT_RSF VARCHAR2(15) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1766');
  end;
  if VpaNumAtualizacao < 1767 then
  begin
    result := '1767';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_NRS_RID VARCHAR2(15) NULL, ' +
                          ' C_NRS_RIF VARCHAR2(15) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1767');
  end;
  if VpaNumAtualizacao < 1768 then
  begin
    result := '1768';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_STR_RSD VARCHAR2(15) NULL, ' +
                          ' C_STR_RSF VARCHAR2(15) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1768');
  end;
  if VpaNumAtualizacao < 1769 then
  begin
    result := '1769';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_OPE_SBO NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1769');
  end;
  if VpaNumAtualizacao < 1770 then
  begin
    result := '1770';
    ExecutaComandoSql(Aux,' CREATE TABLE AMOSTRAPROCESSO ( ' +
                          '  CODAMOSTRA NUMBER(10) NOT NULL, ' +
                          '  SEQPROCESSO NUMBER(10) NOT NULL, ' +
                          '  CODESTAGIO NUMBER(10), ' +
                          '  CODPROCESSOPRODUCAO NUMBER(10), ' +
                          '  QTDPRODUCAOHORA NUMBER(11,4), ' +
                          '  INDCONFIGURACAO CHAR(1), ' +
                          '  DESTEMPOCONFIGURACAO VARCHAR2(7), ' +
                          '  VALUNITARIO NUMBER(15,4) NULL, '+
                          ' PRIMARY KEY (CODAMOSTRA, SEQPROCESSO), ' +
                          ' FOREIGN KEY (CODAMOSTRA) REFERENCES AMOSTRA (CODAMOSTRA), ' +
                          ' FOREIGN KEY (CODESTAGIO) REFERENCES ESTAGIOPRODUCAO (CODEST) ) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1770');
  end;
  if VpaNumAtualizacao < 1771 then
  begin
    result := '1771';
    ExecutaComandoSql(Aux,'DROP TABLE AMOSTRAPRODUTO');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1771');
  end;
  if VpaNumAtualizacao < 1772 then
  begin
    result := '1772';
    ExecutaComandoSql(Aux,'ALTER TABLE ESTAGIOPRODUCAO ADD VALHOR NUMBER(15,4) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1772');
  end;
  if VpaNumAtualizacao < 1773 then
  begin
    result := '1773';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_COT_CSP CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADFILIAIS '+
                           'SET C_COT_CSP = (SELECT C_COT_CSP from CFG_GERAL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1773');
  end;
  if VpaNumAtualizacao < 1774 then
  begin
    result := '1774';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_DES_IPI CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_DES_IPI = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1774');
  end;
  if VpaNumAtualizacao < 1775 then
  begin
    result := '1775';
    ExecutaComandoSql(Aux,'CREATE TABLE PRODUTOINSTALACAOTEARREPETICAO ( ' +
                          ' SEQPRODUTO NUMBER(10) NOT NULL REFERENCES CADPRODUTOS(I_SEQ_PRO), ' +
                          ' SEQREPETICAO NUMBER(10) NOT NULL, ' +
                          ' COLINICIAL NUMBER(10) NULL, ' +
                          ' COLFINAL NUMBER(10) NULL, ' +
                          ' QTDREPETICAO NUMBER(10) NULL, ' +
                          ' PRIMARY KEY(SEQPRODUTO,SEQREPETICAO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1775');
  end;
  if VpaNumAtualizacao < 1776 then
  begin
    result := '1776';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_IND_HOT CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_IND_HOT = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1776');
  end;
  if VpaNumAtualizacao < 1777 then
  begin
    result := '1777';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CHA_SHO CHAR(1)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CHA_SHO = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1777');
  end;
  if VpaNumAtualizacao < 1778 then
  begin
    result := '1778';
    ExecutaComandoSql(Aux,'ALTER TABLE CHAMADOCORPO ADD CODHOTEL NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1778');
  end;
  if VpaNumAtualizacao < 1779 then
  begin
    result := '1779';
    ExecutaComandoSql(Aux,'ALTER TABLE HISTORICOLIGACAO ADD INDCADASTRORAPIDO CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'UPDATE HISTORICOLIGACAO SET INDCADASTRORAPIDO = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1779');
  end;
  if VpaNumAtualizacao < 1780 then
  begin
    result := '1780';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_COP_ENF VARCHAR2(150) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1780');
  end;
  if VpaNumAtualizacao < 1781 then
  begin
    result := '1781';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_IND_ATI CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_IND_ATI =''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1781');
  end;
  if VpaNumAtualizacao < 1782 then
  begin
    result := '1782';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CHA_ANC CHAR(1)NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CHA_ANC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1782');
  end;
  if VpaNumAtualizacao < 1783 then
  begin
    result := '1783';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_DEC_TAP NUMBER(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET I_DEC_TAP = I_DEC_QTD ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1783');
  end;
  if VpaNumAtualizacao < 1784 then
  begin
    result := '1784';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ADD C_ORI_PEC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAISFOR SET C_ORI_PEC = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1784');
  end;
  if VpaNumAtualizacao < 1785 then
  begin
    result := '1785';
    ExecutaComandoSql(Aux,'ALTER TABLE IMPRESSAOCONSUMOFRACAO ADD CODCOR NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1785');
  end;
  if VpaNumAtualizacao < 1786 then
  begin
    result := '1786';
    ExecutaComandoSql(Aux,'CREATE TABLE ORCAMENTOPEDIDOCOMPRA( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQORCAMENTO NUMBER(10) NOT NULL, ' +
                          ' SEQPEDIDO NUMBER(10) NOT NULL, ' +
                          ' PRIMARY KEY(CODFILIAL, SEQORCAMENTO,SEQPEDIDO))');
    ExecutaComandoSql(Aux,'CREATE INDEX ORCAMENTOPEDIDOCOMPRA_FK1 ON ORCAMENTOPEDIDOCOMPRA(CODFILIAL,SEQORCAMENTO)');
    ExecutaComandoSql(Aux,'CREATE INDEX ORCAMENTOPEDIDOCOMPRA_FK2 ON ORCAMENTOPEDIDOCOMPRA(CODFILIAL,SEQPEDIDO)');
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOPEDIDOCOMPRA add CONSTRAINT ORCAMENTOPEDIDOCOMPRA_PC '+
                          ' FOREIGN KEY (CODFILIAL,SEQPEDIDO) '+
                          '  REFERENCES PEDIDOCOMPRACORPO(CODFILIAL,SEQPEDIDO) ');
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOPEDIDOCOMPRA add CONSTRAINT ORCAMENTOPEDIDOCOMPRA_OC '+
                          ' FOREIGN KEY (CODFILIAL,SEQORCAMENTO) '+
                          '  REFERENCES ORCAMENTOCOMPRACORPO(CODFILIAL,SEQORCAMENTO) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1786');
  end;
  if VpaNumAtualizacao < 1787 then
  begin
    result := '1787';
    ExecutaComandoSql(Aux,'CREATE TABLE ORCAMENTOCOMPRAFRACAOOP( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQORCAMENTO NUMBER(10) NOT NULL, ' +
                          ' CODFILIALFRACAO NUMBER(10) NOT NULL, ' +
                          ' SEQORDEM NUMBER(10) NOT NULL, ' +
                          ' SEQFRACAO NUMBER(10) NOT NULL, ' +
                          ' PRIMARY KEY(CODFILIAL, SEQORCAMENTO,CODFILIALFRACAO,SEQORDEM,SEQFRACAO))');
    ExecutaComandoSql(Aux,'CREATE INDEX ORCAMENTOCOMPRAFRACAOOP_FK1 ON ORCAMENTOCOMPRAFRACAOOP(CODFILIAL,SEQORCAMENTO)');
    ExecutaComandoSql(Aux,'CREATE INDEX ORCAMENTOCOMPRAFRACAOOP_FK2 ON ORCAMENTOCOMPRAFRACAOOP(CODFILIALFRACAO,SEQORDEM,SEQFRACAO)');
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAFRACAOOP add CONSTRAINT ORCAMENTOCOMPRAFRACAOOP_OC '+
                          ' FOREIGN KEY (CODFILIAL,SEQORCAMENTO) '+
                          '  REFERENCES ORCAMENTOCOMPRACORPO(CODFILIAL,SEQORCAMENTO) ');
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAFRACAOOP add CONSTRAINT ORCAMENTOCOMPRAFRACAOOP_FRA '+
                          ' FOREIGN KEY (CODFILIALFRACAO,SEQORDEM,SEQFRACAO) '+
                          '  REFERENCES FRACAOOP(CODFILIAL,SEQORDEM,SEQFRACAO) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1787');
  end;
  if VpaNumAtualizacao < 1788 then
  begin
    result := '1788';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCOMISSOES ADD N_BAS_PRO NUMBER(15,3) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1788');
  end;
  if VpaNumAtualizacao < 1789 then
  begin
    result := '1789';
    ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_CLA_FIO VARCHAR2(15) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1789');
  end;
  if VpaNumAtualizacao < 1790 Then
  begin
    result := '1790';
    ExecutaComandoSql(Aux,'CREATE TABLE NUMERONOTA( '+
                          ' CODFILIAL  NUMBER(10) NOT NULL, ' +
                          ' SEQNOTA NUMBER(10) NOT NULL, '+
                          ' PRIMARY KEY(CODFILIAL,SEQNOTA))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1790');
  end;
  if VpaNumAtualizacao < 1791 then
  begin
    result := '1791';
    ExecutaComandoSql(Aux,'ALTER TABLE TELEMARKETING ADD CODVENDEDOR NUMBER(10,0) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1791');
  end;
  if VpaNumAtualizacao < 1792 then
  begin
    result := '1792';
    ExecutaComandoSql(Aux,'ALTER TABLE TELEMARKETINGPROSPECT ADD CODVENDEDOR NUMBER(10,0) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1792');
  end;
  if VpaNumAtualizacao < 1793 then
  begin
    result := '1793';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD I_ULT_SEN NUMBER(10,0)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1793');
  end;
  if VpaNumAtualizacao < 1794 then
  begin
    result := '1794';
    ExecutaComandoSql(Aux,'CREATE TABLE ORCAMENTOSOLICITACAOCOMPRA ( ' +
                          ' CODFILIAL NUMBER(10) NULL, ' +
                          ' SEQORCAMENTO NUMBER(10) NULL, ' +
                          ' CODFILIALSOLICITACAO NUMBER(10) NULL, ' +
                          ' SEQSOLICITACAO NUMBER(10) NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,SEQORCAMENTO,CODFILIALSOLICITACAO,SEQSOLICITACAO))');
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOSOLICITACAOCOMPRA add CONSTRAINT ORCAMENTOSOLCOMPRA_OC '+
                          ' FOREIGN KEY (CODFILIAL,SEQORCAMENTO) '+
                          '  REFERENCES ORCAMENTOCOMPRACORPO(CODFILIAL,SEQORCAMENTO) ');
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOSOLICITACAOCOMPRA add CONSTRAINT ORCAMENTOSOLCOMPRA_SC '+
                          ' FOREIGN KEY (CODFILIALSOLICITACAO,SEQSOLICITACAO) '+
                          '  REFERENCES SOLICITACAOCOMPRACORPO(CODFILIAL,SEQSOLICITACAO) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1794');
  end;
  if VpaNumAtualizacao < 1795 then
  begin
    result := '1795';
    ExecutaComandoSql(Aux,'CREATE TABLE PRECOLARGURATEAR ( ' +
                          ' NUMLARGURA NUMBER(10,2) NOT NULL PRIMARY KEY, ' +
                          ' VALCONVENCIONAL NUMBER(15,4) NULL, ' +
                          ' VALCROCHE NUMBER(15,4) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1795');
  end;
  if VpaNumAtualizacao < 1796 then
  begin
    result := '1796';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD I_TIP_PRO NUMBER(2) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1796');
  end;
  if VpaNumAtualizacao < 1797 then
  begin
    result := '1797';
    ExecutaComandoSql(Aux,'CREATE TABLE MATERIAPRIMAORCAMENTOCADARCO ( ' +
                          ' SEQPRODUTO NUMBER(10) NOT NULL, ' +
                          ' SEQMATERIAPRIMA NUMBER(10) NOT NULL, ' +
                          ' QTDFIO NUMBER(15,4) NULL, ' +
                          ' PRIMARY KEY(SEQPRODUTO,SEQMATERIAPRIMA))');
    ExecutaComandoSql(Aux,'ALTER TABLE MATERIAPRIMAORCAMENTOCADARCO add CONSTRAINT MATPRIORCAMENTOCADARCO_PRO '+
                          ' FOREIGN KEY (SEQPRODUTO) '+
                          '  REFERENCES CADPRODUTOS(I_SEQ_PRO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1797');
  end;
  if VpaNumAtualizacao < 1798 then
  begin
    result := '1798';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(56,5500,''CADNATUREZA'',''NATUREZA DE OPERACAO'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(56,1,''C_COD_NAT'',3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1798');
  end;
  if VpaNumAtualizacao < 1799 then
  begin
    result := '1799';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(57,5600,''CADOPERACAOESTOQUE'',''OPERACOES ESTOQUE'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(57,1,''I_COD_OPE'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1799');
  end;
  if VpaNumAtualizacao < 1801 then
  begin
    result := '1801';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(59,5800,''MOVNATUREZA'',''ITENS DA NATUREZA DE OPERACAO'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(59,1,''C_COD_NAT'',3)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(59,2,''I_SEQ_MOV'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1801');
  end;
  if VpaNumAtualizacao < 1802 then
  begin
    result := '1802';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(60,5900,''CADSERIENOTAS'',''SERIES DA NOTA FISCAL'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(60,1,''C_SER_NOT'',3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1802');
  end;
  if VpaNumAtualizacao < 1803 then
  begin
    result := '1803';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(61,6000,''CADNOTAFISCAIS'',''NOTAS FISCAIS'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(61,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(61,2,''I_SEQ_NOT'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1803');
  end;
  if VpaNumAtualizacao < 1804 then
  begin
    result := '1804';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(62,6100,''CADSERVICO'',''SERVICOS'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(62,1,''I_COD_EMP'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(62,2,''I_COD_SER'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1804');
  end;
  if VpaNumAtualizacao < 1805 then
  begin
    result := '1805';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(63,6200,''MOVSERVICONOTA'',''SERVICOS DA NOTA FISCAL'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(63,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(63,2,''I_SEQ_NOT'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(63,3,''I_SEQ_MOV'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1805');
  end;
  if VpaNumAtualizacao < 1806 then
  begin
    result := '1806';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(64,6300,''MOVNOTASFISCAIS'',''ITENS DA NOTA FISCAL'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(64,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(64,2,''I_SEQ_NOT'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(64,3,''I_SEQ_MOV'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1806');
  end;
  if VpaNumAtualizacao < 1807 then
  begin
    result := '1807';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(65,6400,''CADCONTASARECEBER'',''CONTAS A RECEBER'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(65,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(65,2,''I_LAN_REC'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1807');
  end;
  if VpaNumAtualizacao < 1808 then
  begin
    result := '1808';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(66,6500,''MOTIVOINADIMPLENCIA'',''MOTIVO INADIMPLECIA'',''DATULTIMAALTERACAO'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(66,1,''CODMOTIVO'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1808');
  end;
  if VpaNumAtualizacao < 1809 then
  begin
    result := '1809';
    ExecutaComandoSql(Aux,'ALTER TABLE MOTIVOINADIMPLENCIA ADD DATULTIMAALTERACAO DATE NULL');
    ExecutaComandoSql(Aux,'UPDATE MOTIVOINADIMPLENCIA SET DATULTIMAALTERACAO = SYSDATE');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1809');
  end;
  if VpaNumAtualizacao < 1810 then
  begin
    result := '1810';
    ExecutaComandoSql(Aux,'DELETE FROM TABELAIMPORTACAOFILTRO WHERE CODTABELA = 47');
    ExecutaComandoSql(Aux,'DELETE FROM TABELAIMPORTACAO WHERE CODTABELA = 47');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1810');
  end;
  if VpaNumAtualizacao < 1811 then
  begin
    result := '1811';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(67,6600,''MOVCONTASARECEBER'',''ITENS DO CONTAS A RECEBER'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(67,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(67,2,''I_LAN_REC'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(67,3,''I_NRO_PAR'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1811');
  end;
  if VpaNumAtualizacao < 1812 then
  begin
    result := '1812';
    ExecutaComandoSql(Aux,'update MOVNOTASFISCAIS SET D_ULT_ALT = SYSDATE -1');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1812');
  end;
  if VpaNumAtualizacao < 1813 then
  begin
    result := '1813';
    ExecutaComandoSql(Aux,'CREATE TABLE SEQUENCIALCONTASARECEBER( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' LANRECEBER NUMBER(10) NOT NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,LANRECEBER))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1813');
  end;
  if VpaNumAtualizacao < 1814 then
  begin
    result := '1814';
    ExecutaComandoSql(Aux,'CREATE TABLE SEQUENCIALCOMISSAO ( ' +
                          ' CODFILIAL NUMBER(10) NULL , ' +
                          ' SEQCOMISSAO NUMBER(10) NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,SEQCOMISSAO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1814');
  end;
  if VpaNumAtualizacao < 1815 then
  begin
    result := '1815';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD(I_ULT_REC NUMBER(10) NULL, ' +
                          ' I_ULT_COM NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1815');
  end;
  if VpaNumAtualizacao < 1816 then
  begin
    result := '1816';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_CRM_PRP CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CADGRUPOS set C_CRM_PRP = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1816');
  end;
  if VpaNumAtualizacao < 1817 then
  begin
    result := '1817';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(68,6700,''MOVCOMISSOES'',''COMISSOES'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(68,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(68,2,''I_LAN_CON'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1817');
  end;
  if VpaNumAtualizacao < 1818 then
  begin
    result := '1818';
    ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS '+
                          ' SET D_ULT_ALT = SYSDATE ' +
                          ' WHERE D_ULT_ALT IS NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1818');
  end;
  if VpaNumAtualizacao < 1819 then
  begin
    result := '1819';
    ExecutaComandoSql(Aux,'UPDATE MOVORCAMENTOS '+
                          ' SET D_ULT_ALT = SYSDATE ' +
                          ' WHERE D_ULT_ALT IS NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1819');
  end;
  if VpaNumAtualizacao < 1820 then
  begin
    result := '1820';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(69,450,''CFG_MODULO'',''CONFIGURACOES DOS MODULOS'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1820');
  end;
  if VpaNumAtualizacao < 1821 then
  begin
    result := '1821';
    ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS '+
                          ' SET D_ULT_ALT = SYSDATE ' +
                          ' WHERE D_ULT_ALT IS NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1821');
  end;
  if VpaNumAtualizacao < 1822 then
  begin
    result := '1822';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_MODULO ADD D_ULT_ALT DATE');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1822');
  end;
  if VpaNumAtualizacao < 1823 then
  begin
    result := '1823';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD C_FLA_EXP CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS SET C_FLA_EXP = ''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1823');
  end;
  if VpaNumAtualizacao < 1824 then
  begin
    result := '1824';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD D_DAT_EXP DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1824');
  end;
  if VpaNumAtualizacao < 1825 then
  begin
    result := '1825';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER ADD C_FLA_EXP CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADCONTASARECEBER SET C_FLA_EXP = ''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1825');
  end;
  if VpaNumAtualizacao < 1826 then
  begin
    result := '1826';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER ADD D_DAT_EXP DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1826');
  end;
  if VpaNumAtualizacao < 1827 then
  begin
    result := '1827';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCOMISSOES ADD(C_FLA_EXP CHAR(1) NULL, ' +
                          ' D_DAT_EXP DATE NULL)');
    ExecutaComandoSql(Aux,'UPDATE MOVCOMISSOES SET C_FLA_EXP = ''S''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1827');
  end;
  if VpaNumAtualizacao < 1828 then
  begin
    result := '1828';
    ExecutaComandoSql(Aux,'ALTER TABLE IMPRESSAOCONSUMOFRACAO ADD DESLOCALIZACAO VARCHAR2(20)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1828');
  end;
  if VpaNumAtualizacao < 1829 then
  begin
    result := '1829';
    ExecutaComandoSql(Aux,'UPDATE CADCONTASARECEBER '+
                          ' SET D_ULT_ALT = SYSDATE ' +
                          ' WHERE D_ULT_ALT IS NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1829');
  end;
  if VpaNumAtualizacao < 1830 then
  begin
    result := '1830';
    ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS ADD (C_TIP_ECF VARCHAR2(7)NULL, ' +
                          ' C_MAR_ECF VARCHAR2(20) NULL, ' +
                          ' C_MOD_ECF VARCHAR2(20) NULL, ' +
                          ' C_VER_SFB VARCHAR2(10) NULL, ' +
                          ' D_DAT_SFB date NULL, ' +
                          ' I_NUM_ECF NUMBER(10) NULL, ' +
                          ' I_EMP_FIL NUMBER(10) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1830');
  end;
  if VpaNumAtualizacao < 1831 then
  begin
    result := '1831';
    ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS ADD (I_NUM_USU NUMBER(10)NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1831');
  end;
  if VpaNumAtualizacao < 1832 then
  begin
    result := '1832';
    ExecutaComandoSql(Aux,'CREATE TABLE REDUCAOZ( ' +
                          ' NUMSERIEECF VARCHAR2(20) NOT NULL, ' +
                          ' NUMREDUCAOZ NUMBER(10) NOT NULL, ' +
                          ' NUMCONTADOROPERACAO NUMBER(10) NULL, ' +
                          ' NUMCONTADORREINICIOOPERACAO NUMBER(10) NULL, ' +
                          ' DATMOVIMENTO DATE NULL, ' +
                          ' DATEMISSAO DATE NULL, ' +
                          ' VALVENDABRUTADIARIA NUMBER(15,3) NULL, ' +
                          ' INDDESCONTOISSQN CHAR(1) NULL, ' +
                          ' PRIMARY KEY(NUMSERIEECF,NUMREDUCAOZ))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1832');
  end;
  if VpaNumAtualizacao < 1833 then
  begin
    result := '1833';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD(I_NUM_COO NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1833');
  end;
  if VpaNumAtualizacao < 1834 then
  begin
    result := '1834';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD C_IND_CAN CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE MOVNOTASFISCAIS SET C_IND_CAN = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1834');
  end;
  if VpaNumAtualizacao < 1835 then
  begin
    result := '1835';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_ARE_TRU CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS SET C_ARE_TRU = ''A''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1835');
  end;
  if VpaNumAtualizacao < 1836 then
  begin
    result := '1836';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD I_NUM_COO NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1836');
  end;
  if VpaNumAtualizacao < 1837 then
  begin
    result := '1837';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_SIT_TRI CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS SET C_SIT_TRI = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1837');
  end;
  if VpaNumAtualizacao < 1838 then
  begin
    result := '1838';
    ExecutaComandoSql(Aux,'CREATE TABLE REDUCAOZALIQUOTA ( ' +
                          ' NUMSERIEECF VARCHAR2(20) NOT NULL, ' +
                          ' NUMREDUCAOZ NUMBER(10) NOT NULL, ' +
                          ' SEQINDICE NUMBER(10) NOT NULL, ' +
                          ' DESTIPO CHAR(2) NULL, ' +
                          ' PERALIQUOTA NUMBER(7,2) NULL, ' +
                          ' VALVENDA NUMBER(15,3) NULL, ' +
                          ' PRIMARY KEY(NUMSERIEECF,NUMREDUCAOZ,SEQINDICE))');
    ExecutaComandoSql(Aux,'ALTER TABLE REDUCAOZALIQUOTA add CONSTRAINT REDUCAOZALIQUOTA_REDUCAOZ '+
                          ' FOREIGN KEY (NUMSERIEECF,NUMREDUCAOZ) '+
                          '  REFERENCES REDUCAOZ(NUMSERIEECF,NUMREDUCAOZ)');
    ExecutaComandoSql(Aux,'CREATE INDEX REDUCAOZALIQUOTA_FK1 ON REDUCAOZALIQUOTA(NUMSERIEECF,NUMREDUCAOZ)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1838');
  end;
  if VpaNumAtualizacao < 1839 then
  begin
    result := '1839';
    ExecutaComandoSql(Aux,'ALTER TABLE REDUCAOZ ADD (VALSTICMS NUMBER(15,3) ,' +
                          ' VALISENTOICMS NUMBER(15,3), ' +
                          ' VALNAOTRIBUTADOICMS NUMBER(15,3), ' +
                          ' VALSTISSQN NUMBER(15,3), ' +
                          ' VALISENTOISSQN NUMBER(15,3), ' +
                          ' VALNAOTRIBUTADOISSQN NUMBER(15,3), ' +
                          ' VALOPERACAONAOFISCAL NUMBER(15,3), ' +
                          ' VALDESCONTOICMS NUMBER(15,3), ' +
                          ' VALDESCONTOISSQN NUMBER(15,3), ' +
                          ' VALACRESCIMOICMS NUMBER(15,3), ' +
                          ' VALACRESCIMOISSQN NUMBER(15,3), ' +
                          ' VALCANCELADOICMS NUMBER(15,3), ' +
                          ' VALCANCELADOISSQN NUMBER(15,3))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1839');
  end;
  if VpaNumAtualizacao < 1840 then
  begin
    result := '1840';
    ExecutaComandoSql(Aux,'Alter table MOVNOTASFISCAIS ADD C_TPA_ECF VARCHAR2(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1840');
  end;
  if VpaNumAtualizacao < 1841 then
  begin
    result := '1841';
    ExecutaComandoSql(Aux,'Alter table CADNOTAFISCAIS ADD C_VEN_CON CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS SET C_VEN_CON = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1841');
  end;
  if VpaNumAtualizacao < 1842 then
  begin
    result := '1842';
    ExecutaComandoSql(Aux,'CREATE TABLE COMPROVANTENAOFISCAL( '+
                          ' NUMSERIEECF VARCHAR2(20) NOT NULL, ' +
                          ' NUMCOO NUMBER(10) NOT NULL, ' +
                          ' NUMGNF NUMBER(10) NOT NULL, ' +
                          ' DESDENOMINACAO CHAR(2) NULL, ' +
                          ' DESOPERACAO CHAR(1) NULL, '+
                          ' VALCOMPROVANTE NUMBER(15,3) NULL, '+
                          ' DATEMISSAO DATE NULL, '+
                          'PRIMARY KEY(NUMSERIEECF,NUMCOO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1842');
  end;
  if VpaNumAtualizacao < 1843 then
  begin
    result := '1843';
    ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS ADD I_COD_NAC NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1843');
  end;
  if VpaNumAtualizacao < 1844 then
  begin
    result := '1844';
    ExecutaComandoSql(Aux,'ALTER TABLE REDUCAOZ ADD VALGRANDETOTAL NUMBER(15,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1844');
  end;
  if VpaNumAtualizacao < 1845 then
  begin
    result := '1845';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD I_NUM_CRZ NUMBER(10)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1845');
  end;
  if VpaNumAtualizacao < 1846 then
  begin
    result := '1846';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_IND_TEF CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_IND_TEF = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1846');
  end;
  if VpaNumAtualizacao < 1847 then
  begin
    result := '1847';
    ExecutaComandoSql(Aux,'CREATE TABLE ARQUIVOAUXILIAR( ' +
                          ' NOMARQUIVO VARCHAR2(200) NULL)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1847');
  end;
  if VpaNumAtualizacao < 1848 then
  begin
    result := '1848';
    ExecutaComandoSql(Aux,'INSERT INTO ARQUIVOAUXILIAR(NOMARQUIVO) VALUES(''ACESSOREMOTO.EXE'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1848');
  end;
  if VpaNumAtualizacao < 1849 then
  begin
    result := '1849';
    ExecutaComandoSql(Aux,'INSERT INTO ARQUIVOAUXILIAR(NOMARQUIVO) VALUES(''libeay32.dll'')');
    ExecutaComandoSql(Aux,'INSERT INTO ARQUIVOAUXILIAR(NOMARQUIVO) VALUES(''sign_bema.dll'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1849');
  end;
  if VpaNumAtualizacao < 1850 then
  begin
    result := '1850';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD C_ASS_REG VARCHAR2(30) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1850');
  end;
  if VpaNumAtualizacao < 1851 then
  begin
    result := '1851';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_ASS_REG VARCHAR2(30)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1851');
  end;
  if VpaNumAtualizacao < 1852 then
  begin
    result := '1852';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO ADD C_ASS_REG VARCHAR2(30)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1852');
  end;
  if VpaNumAtualizacao < 1853 then
  begin
    result := '1853';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO ADD C_ASS_REG VARCHAR2(30)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1853');
  end;
  if VpaNumAtualizacao < 1854 then
  begin
    result := '1854';
    ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS ADD C_ASS_REG VARCHAR2(30)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1854');
  end;
  if VpaNumAtualizacao < 1855 then
  begin
    result := '1855';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EXC_TEL CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EXC_TEL = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1855');
  end;
  if VpaNumAtualizacao < 1856 then
  begin
    result := '1856';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_IND_SPV CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_IND_SPV = C_IND_SCV');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1856');
  end;
  if VpaNumAtualizacao < 1857 then
  begin
    result := '1857';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_MOT_NFE CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_MOT_NFE = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1857');
  end;
  if VpaNumAtualizacao < 1858 then
  begin
    result := '1858';
    ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS DROP(C_ASS_REG)');
    ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS ADD(C_NOM_SFH VARCHAR2(40), ' +
                          ' C_CNP_SFH VARCHAR2(20) NULL, ' +
                          ' C_END_SFH VARCHAR2(50) NULL, '+
                          ' C_FON_SFH VARCHAR2(15) NULL, ' +
                          ' C_CON_SFH VARCHAR2(15) NULL, ' +
                          ' C_CNP_EMI VARCHAR2(15) NULL, ' +
                          ' C_NOM_COM VARCHAR2(30) NULL, ' +
                          ' C_ASS_REG VARCHAR2(30) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1858');
  end;
  if VpaNumAtualizacao < 1859 then
  begin
    result := '1859';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD C_SUB_SER VARCHAR2(10)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1859');
  end;
  if VpaNumAtualizacao < 1860 then
  begin
    result := '1860';
    ExecutaComandoSql(Aux,'CREATE TABLE RELATORIOGERENCIALECF( ' +
                          ' NUMSERIEECF VARCHAR2(20) NOT NULL, ' +
                          ' NUMCOO NUMBER(10) NOT NULL, ' +
                          ' NUMGRG NUMBER(10) NULL, ' +
                          ' DATEMISSAO DATE NULL, '+
                          ' PRIMARY KEY(NUMSERIEECF,NUMCOO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1860');
  end;
  if VpaNumAtualizacao < 1861 then
  begin
    result := '1861';
    ExecutaComandoSql(Aux,'ALTER TABLE REDUCAOZ ADD DESASSINATURAREGISTRO VARCHAR2(30)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1861');
  end;
  if VpaNumAtualizacao < 1862 then
  begin
    result := '1862';
    ExecutaComandoSql(Aux,'ALTER TABLE REDUCAOZALIQUOTA ADD DESASSINATURAREGISTRO VARCHAR2(30)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1862');
  end;
  if VpaNumAtualizacao < 1863 then
  begin
    result := '1863';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD C_ASS_REG VARCHAR2(30) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1863');
  end;
  if VpaNumAtualizacao < 1864 then
  begin
    result := '1864';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD C_ASS_REG VARCHAR2(30) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1864');
  end;
  if VpaNumAtualizacao < 1865 then
  begin
    result := '1865';
    ExecutaComandoSql(Aux,'update CADUSUARIOS SET C_MOD_PDV = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1865');
  end;
  if VpaNumAtualizacao < 1866 then
  begin
    result := '1866';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_OCU_VEN CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_OCU_VEN = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1866');
  end;
  if VpaNumAtualizacao < 1867 then
  begin
    result := '1867';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD C_ORI_PED CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1867');
  end;
  if VpaNumAtualizacao < 1868 then
  begin
    result := '1868';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_IMP_FNF CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FISCAL SET C_IMP_FNF = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1868');
  end;
  if VpaNumAtualizacao < 1869 then
  begin
    result := '1869';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD D_ULT_BAC DATE NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1869');
  end;
  if VpaNumAtualizacao < 1870 then
  begin
    result := '1870';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD I_CLI_FAC NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1870');
  end;
  if VpaNumAtualizacao < 1871 then
  begin
    result := '1871';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_CLF CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_CLF = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1871');
  end;
  if VpaNumAtualizacao < 1872 then
  begin
    result := '1872';
    ExecutaComandoSql(Aux,'CREATE TABLE DOCUMENTOVINCULADOECF( ' +
                          ' NUMSERIEECF VARCHAR2(20) NOT NULL, ' +
                          ' NUMCOO NUMBER(10) NOT NULL, ' +
                          ' NUMCDC NUMBER(10) NULL, ' +
                          ' DATEMISSAO DATE NULL, '+
                          ' DESASSINATURAREGISTRO VARCHAR2(30) NULL, '+
                          ' PRIMARY KEY(NUMSERIEECF,NUMCOO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1872');
  end;
  if VpaNumAtualizacao < 1873 then
  begin
    result := '1873';
    ExecutaComandoSql(Aux,'ALTER TABLE COMPROVANTENAOFISCAL ADD DESASSINATURAREGISTRO VARCHAR2(30)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1873');
  end;
  if VpaNumAtualizacao < 1874 then
  begin
    result := '1874';
    ExecutaComandoSql(Aux,'ALTER TABLE RELATORIOGERENCIALECF ADD DESASSINATURAREGISTRO VARCHAR2(30)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1874');
  end;
end;

function TAtualiza.AtualizaTabela3(VpaNumAtualizacao: Integer): String;
begin
  result := '';
  if VpaNumAtualizacao < 1875 then
  begin
    result := '1875';
    ExecutaComandoSql(Aux,'ALTER TABLE DOCUMENTOVINCULADOECF DROP(DESASSINATURAREGISTRO)');
    ExecutaComandoSql(Aux,'ALTER TABLE DOCUMENTOVINCULADOECF ADD(NUMGNF NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1875');
  end;
  if VpaNumAtualizacao < 1876 then
  begin
    result := '1876';
    ExecutaComandoSql(Aux,'ALTER TABLE DOCUMENTOVINCULADOECF ADD(DESASSINATURAREGISTRO VARCHAR2(30) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1876');
  end;
  if VpaNumAtualizacao < 1877 then
  begin
    result := '1877';
    ExecutaComandoSql(Aux,'ALTER TABLE RELATORIOGERENCIALECF DROP(DESASSINATURAREGISTRO)');
    ExecutaComandoSql(Aux,'ALTER TABLE RELATORIOGERENCIALECF ADD(NUMGNF NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1877');
  end;
  if VpaNumAtualizacao < 1878 then
  begin
    result := '1878';
    ExecutaComandoSql(Aux,'ALTER TABLE RELATORIOGERENCIALECF ADD(DESASSINATURAREGISTRO VARCHAR2(30) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1878');
  end;
  if VpaNumAtualizacao < 1879 then
  begin
    result := '1879';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD N_PER_FRE NUMBER(5,2) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1879');
  end;
  if VpaNumAtualizacao < 1880 then
  begin
    result := '1880';
    ExecutaComandoSql(Aux,'Alter table CFG_GERAL ADD C_COT_OIO CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_OIO =  ''D''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1880');
  end;
  if VpaNumAtualizacao < 1881 then
  begin
    result := '1881';
    ExecutaComandoSql(Aux,'INSERT INTO ARQUIVOAUXILIAR(NOMARQUIVO) VALUES(''DelZip190.dll'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1881');
  end;
  if VpaNumAtualizacao < 1882 then
  begin
    result := '1882';
    ExecutaComandoSql(Aux,'alter table CADCLIENTES ADD(C_IND_CBA CHAR(1) NULL, '+
                           ' C_IND_BUM CHAR(1) NULL, ' +
                           ' I_COD_EMB NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1882');
  end;
  if VpaNumAtualizacao < 1883 then
  begin
    result := '1883';
    ExecutaComandoSql(Aux,'alter table CADCLIENTES ADD(I_COD_RED NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1883');
  end;
  if VpaNumAtualizacao < 1884 then
  begin
    result := '1884';
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES ' +
                          ' SET C_IND_CBA = ''S'','+
                          ' C_IND_BUM = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1884');
  end;
  if VpaNumAtualizacao < 1885 then
  begin
    result := '1885';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD I_TIP_MAP NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1885');
  end;
  if VpaNumAtualizacao < 1886 then
  begin
    result := '1886';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_IMP_CPN CHAR(1)NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FISCAL SET C_IMP_CPN = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1886');
  end;
  if VpaNumAtualizacao < 1887 then
  begin
    result := '1887';
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES ' +
                          ' SET C_EMA_INV = ''S''' +
                          ' Where C_EMA_INV = ''N''' +
                          ' AND I_QTD_EMI >= 1');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1887');
  end;
  if VpaNumAtualizacao < 1888 then
  begin
    result := '1888';
    ExecutaComandoSql(Aux,'UPDATE PROSPECT ' +
                          ' SET INDEMAILINVALIDO = ''S''' +
                          ' Where INDEMAILINVALIDO = ''N''' +
                          ' AND QTDVEZESEMAILINVALIDO >= 1');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1888');
  end;
  if VpaNumAtualizacao < 1889 then
  begin
    result := '1889';
    ExecutaComandoSql(Aux,'UPDATE CONTATOCLIENTE ' +
                          ' SET INDEMAILINVALIDO = ''S''' +
                          ' Where INDEMAILINVALIDO = ''N''' +
                          ' AND QTDVEZESEMAILINVALIDO >= 1');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1889');
  end;
  if VpaNumAtualizacao < 1890 then
  begin
    result := '1890';
    ExecutaComandoSql(Aux,'UPDATE CONTATOPROSPECT ' +
                          ' SET INDEMAILINVALIDO = ''S''' +
                          ' Where INDEMAILINVALIDO = ''N''' +
                          ' AND QTDVEZESEMAILINVALIDO >= 1');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1890');
  end;
  if VpaNumAtualizacao < 1891 then
  begin
    result := '1891';
    ExecutaComandoSql(Aux,'UPDATE CONTATOPROSPECT '+
                          ' SET DESEMAIL = TRIM(DESEMAIL) ' +
                          ' Where DESEMAIL LIKE ''% %''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1891');
  end;
  if VpaNumAtualizacao < 1891 then
  begin
    result := '1891';
    ExecutaComandoSql(Aux,'UPDATE PROSPECT '+
                          ' SET DESEMAILCONTATO = TRIM(DESEMAILCONTATO) ' +
                          ' Where DESEMAILCONTATO LIKE ''% %''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1891');
  end;
  if VpaNumAtualizacao < 1892 then
  begin
    result := '1892';
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES '+
                          ' SET C_END_ELE = TRIM(C_END_ELE) ' +
                          ' Where C_END_ELE LIKE ''% %''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1892');
  end;
  if VpaNumAtualizacao < 1893 then
  begin
    result := '1893';
    ExecutaComandoSql(Aux,'UPDATE CONTATOCLIENTE '+
                          ' SET DESEMAIL = TRIM(DESEMAIL) ' +
                          ' Where DESEMAIL LIKE ''% %''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1893');
  end;
  if VpaNumAtualizacao < 1894 then
  begin
    result := '1894';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_ORC_CHA NUMBER(10)NULL  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1894');
  end;
  if VpaNumAtualizacao < 1895 then
  begin
    result := '1895';
    ExecutaComandoSql(Aux,'ALTER TABLE TAREFATELEMARKETING ADD(INDPROSPECT CHAR(1) NULL, ' +
                          ' INDCLIENTE CHAR(1) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1895');
  end;
  if VpaNumAtualizacao < 1896 then
  begin
    result := '1896';
    ExecutaComandoSql(Aux,'ALTER TABLE CLIENTEPERDIDOVENDEDOR ADD(INDCLIENTE CHAR(1) NULL, ' +
                          ' INDPROSPECT CHAR(1) NULL, ' +
                          ' QTDDIASSEMTELEMARKETING NUMBER(10) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1896');
  end;
  if VpaNumAtualizacao < 1897 then
  begin
    result := '1897';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD(C_IMP_CHE CHAR(1) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_FINANCEIRO SET C_IMP_CHE = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1897');
  end;
  if VpaNumAtualizacao < 1898 then
  begin
    result := '1898';
    ExecutaComandoSql(Aux,'ALTER TABLE CHEQUE ADD(NOMNOMINAL VARCHAR2(50) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1898');
  end;
  if VpaNumAtualizacao < 1899 then
  begin
    result := '1899';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTAS ADD I_LAY_CHE NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1899');
  end;
  if VpaNumAtualizacao < 1900 then
  begin
    result := '1900';
    ExecutaComandoSql(Aux,'ALTER TABLE ESTAGIOPROPOSTA MODIFY DESMOTIVO VARCHAR2(500)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1900');
  end;
  if VpaNumAtualizacao < 1901 then
  begin
    result := '1901';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD (C_NAT_VOD VARCHAR2(15) NULL, ' +
                          ' C_NAT_VOF VARCHAR2(15) NULL, ' +
                          ' C_NAT_ROD VARCHAR2(15) NULL, ' +
                          ' C_NAT_ROF VARCHAR2(15) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1901');
  end;
  if VpaNumAtualizacao < 1902 then
  begin
    result := '1902';
    ExecutaComandoSql(Aux,'ALTER TABLE FACCIONISTA ADD TIPDISTRIBUICAO CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'Update FACCIONISTA SET TIPDISTRIBUICAO = ''B''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1902');
  end;
  if VpaNumAtualizacao < 1903 then
  begin
    result := '1903';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCONTASAPAGAR ADD C_DES_PRR CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE MOVCONTASAPAGAR SET C_DES_PRR = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1903');
  end;
  if VpaNumAtualizacao < 1904 then
  begin
    result := '1904';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES MODIFY C_CID_CLI VARCHAR2(40)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1904');
  end;
  if VpaNumAtualizacao < 1905 then
  begin
    result := '1905';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD I_COD_RED NUMBER(10)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1905');
  end;
  if VpaNumAtualizacao < 1906 then
  begin
    result := '1906';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD I_COD_RED NUMBER(10)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1906');
  end;
  if VpaNumAtualizacao < 1907 then
  begin
    result := '1907';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCOMISSOES ADD C_IND_DEV CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'UPDATE MOVCOMISSOES SET C_IND_DEV = ''N''');
    ExecutaComandoSql(Aux,'UPDATE MOVCOMISSOES SET C_IND_DEV = ''S'' WHERE N_VLR_COM < 0');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1907');
  end;
  if VpaNumAtualizacao < 1908 then
  begin
    result := '1908';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_OOP CHAR(1)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_OOP = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1908');
  end;
  if VpaNumAtualizacao < 1909 then
  begin
    result := '1909';
    ExecutaComandoSql(Aux,'ALTER TABLE IMPRESSAOCONSUMOFRACAO ADD SEQPRODUTO NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1909');
  end;
  if VpaNumAtualizacao < 1910 then
  begin
    result := '1910';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_CUS_PPA CHAR(1) ');
    ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_CUS_PPA = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1910');
  end;
  if VpaNumAtualizacao < 1911 then
  begin
    result := '1911';
    ExecutaComandoSql(Aux,'CREATE TABLE ROMANEIOORCAMENTO ( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQROMANEIO NUMBER(10) NOT NULL, ' +
                          ' DATINICIO DATE, ' +
                          ' DATFIM DATE, ' +
                          ' NUMNOTA NUMBER(10), ' +
                          ' CODFILIALNOTA NUMBER(10), ' +
                          ' SEQNOTA NUMBER(10), ' +
                          ' CODCLIENTE NUMBER(10), ' +
                          ' VALTOTAL NUMBER(15,3), ' +
                          ' CODUSUARIO NUMBER(10), '+
                          ' PRIMARY KEY(CODFILIAL, SEQROMANEIO),' +
                          ' FOREIGN KEY (CODCLIENTE) REFERENCES CADCLIENTES (I_COD_CLI), ' +
                          ' FOREIGN KEY (CODFILIALNOTA,SEQNOTA) REFERENCES CADNOTAFISCAIS(I_EMP_FIL,I_SEQ_NOT))');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTO_CLI ON ROMANEIOORCAMENTO(CODCLIENTE)');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTO_NOTA ON ROMANEIOORCAMENTO(CODFILIALNOTA,SEQNOTA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1911');
  end;
  if VpaNumAtualizacao < 1912 then
  begin
    result := '1912';
    ExecutaComandoSql(Aux,'CREATE TABLE ROMANEIOORCAMENTOITEM( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQROMANEIO NUMBER(10)NOT NULL, ' +
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' CODFILIALORCAMENTO NUMBER(10) NULL, ' +
                          ' LANORCAMENTO NUMBER(10) NULL, ' +
                          ' SEQITEMORCAMENTO NUMBER(10) NULL, ' +
                          ' SEQPRODUTO NUMBER(10) NULL, ' +
                          ' CODCOR NUMBER(10) NULL, ' +
                          ' CODTAMANHO NUMBER(10) NULL, '+
                          ' QTDPRODUTO NUMBER(17,3), ' +
                          ' VALUNITARIO NUMBER(17,4), ' +
                          ' VALTOTAL NUMBER(17,2), ' +
                          ' CODEMBALAGEM NUMBER(10), '+
                          ' PRIMARY KEY(CODFILIAL, SEQROMANEIO, SEQITEM), ' +
                          ' FOREIGN KEY (CODFILIAL,SEQROMANEIO) REFERENCES ROMANEIOORCAMENTO(CODFILIAL,SEQROMANEIO), ' +
                          ' FOREIGN KEY (CODFILIALORCAMENTO,LANORCAMENTO) REFERENCES CADORCAMENTOS (I_EMP_FIL, I_LAN_ORC), ' +
                          ' FOREIGN KEY (SEQPRODUTO) REFERENCES CADPRODUTOS(I_SEQ_PRO), ' +
                          ' FOREIGN KEY (CODTAMANHO) REFERENCES TAMANHO (CODTAMANHO), ' +
                          ' FOREIGN KEY (CODCOR) REFERENCES COR(COD_COR), ' +
                          ' FOREIGN KEY (CODEMBALAGEM) REFERENCES EMBALAGEM(COD_EMBALAGEM)) ');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTOITEM_ROM ON ROMANEIOORCAMENTOITEM(CODFILIAL,SEQROMANEIO)');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTOITEM_ORC ON ROMANEIOORCAMENTOITEM(CODFILIALORCAMENTO,LANORCAMENTO)');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTOITEM_PRO ON ROMANEIOORCAMENTOITEM(SEQPRODUTO)');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTOITEM_COR ON ROMANEIOORCAMENTOITEM(CODCOR)');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTOITEM_TAM ON ROMANEIOORCAMENTOITEM(CODTAMANHO)');
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTOITEM_EMB ON ROMANEIOORCAMENTOITEM(CODEMBALAGEM)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1912');
  end;
  if VpaNumAtualizacao < 1913 then
  begin
    result := '1913';
    ExecutaComandoSql(Aux,'CREATE INDEX ROMANEIOORCAMENTO_DTFIM ON ROMANEIOORCAMENTO(DATFIM)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1913');
  end;
  if VpaNumAtualizacao < 1914 then
  begin
    result := '1914';
    ExecutaComandoSql(Aux,'alter table PROPOSTA DROP(LANORCAMENTO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1914');
  end;
  if VpaNumAtualizacao < 1915 then
  begin
    result := '1915';
    ExecutaComandoSql(Aux,'CREATE TABLE PROPOSTACOTACAO ( ' +
                          ' CODFILIALPROPOSTA NUMBER(10) NOT NULL, ' +
                          ' SEQPROPOSTA NUMBER(10) NOT NULL, ' +
                          ' CODFILIALORCAMENTO NUMBER(10) NOT NULL, ' +
                          ' LANORCAMENTO NUMBER(10) NOT NULL, ' +
                          ' PRIMARY KEY(CODFILIALPROPOSTA,SEQPROPOSTA,CODFILIALORCAMENTO,LANORCAMENTO), ' +
                          ' FOREIGN KEY (CODFILIALPROPOSTA,SEQPROPOSTA) REFERENCES PROPOSTA(CODFILIAL,SEQPROPOSTA), ' +
                          ' FOREIGN KEY (CODFILIALORCAMENTO,LANORCAMENTO) REFERENCES CADORCAMENTOS(I_EMP_FIL,I_LAN_ORC))');
    ExecutaComandoSql(Aux,'CREATE INDEX PROPOSTACOTACAO_PRO ON PROPOSTACOTACAO(CODFILIALPROPOSTA,SEQPROPOSTA)');
    ExecutaComandoSql(Aux,'CREATE INDEX PROPOSTACOTACAO_COT ON PROPOSTACOTACAO(CODFILIALORCAMENTO,LANORCAMENTO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1915');
  end;
  if VpaNumAtualizacao < 1916 then
  begin
    result := '1916';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(70,6350,''MOVSERVICOORCAMENTO'',''SERVICO ORCAMENTO'',''D_ULT_ALT'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(70,1,''I_EMP_FIL'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(70,2,''I_LAN_ORC'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(70,3,''I_SEQ_MOV'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1916');
  end;
  if VpaNumAtualizacao < 1917 then
  begin
    result := '1917';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES add C_FOR_EAP CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_FOR_EAP = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1917');
  end;
  if VpaNumAtualizacao < 1918 then
  begin
    result := '1918';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_IND_REV CHAR(1)NULL');
    ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_IND_REV = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1918');
  end;
  if VpaNumAtualizacao < 1919 then
  begin
    result := '1919';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_IND_TRA CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CADCLIENTES SET C_IND_TRA = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1919');
  end;
  if VpaNumAtualizacao < 1920 then
  begin
    result := '1920';
    ExecutaComandoSql(Aux,'alter TABLE CADCLIENTES ADD I_TRA_ANT NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1920');
  end;
  if VpaNumAtualizacao < 1921 then
  begin
    result := '1921';
    CadastraTransportadorasComoClientes;
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1921');
  end;
  if VpaNumAtualizacao < 1922 then
  begin
    result := '1922';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD(I_ORC_COL NUMBER(10) NULL, ' +
                          ' I_ORC_ENT NUMBER(10) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1922');
  end;
  if VpaNumAtualizacao < 1923 then
  begin
    result := '1923';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ING_EEM CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ING_EEM = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1923');
  end;
  if VpaNumAtualizacao < 1924 then
  begin
    result := '1924';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ORP_DFF CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORP_DFF = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1924');
  end;
  if VpaNumAtualizacao < 1925 then
  begin
    result := '1925';
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA) ' +
                          ' VALUES(71,6350,''CONDICAOPAGAMENTOGRUPOUSUARIO'',''CONDICAO PAGAMENTO GRUPO USUARIO'',''DATULTIMAALTERACAO'')');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(71,1,''CODGRUPOUSUARIO'',1)');
    ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                          ' VALUES(71,2,''CODCONDICAOPAGAMENTO'',1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1925');
  end;
  if VpaNumAtualizacao < 1926 then
  begin
    result := '1926';
    ExecutaComandoSql(Aux,'ALTER TABLE CONDICAOPAGAMENTOGRUPOUSUARIO ADD DATULTIMAALTERACAO DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1926');
  end;
  if VpaNumAtualizacao < 1927 then
  begin
    result := '1927';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_BOL_NOT CHAR(1)NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_BOL_NOT = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1927');
  end;
  if VpaNumAtualizacao < 1928 then
  begin
    result := '1928';
    ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD C_ASS_EMA VARCHAR2(500) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1928');
  end;
  if VpaNumAtualizacao < 1929 then
  begin
    result := '1929';
    ExecutaComandoSql(Aux,'ALTER TABLE ETIQUETAPRODUTO ADD(NOMCORMARISOL VARCHAR2(50) NULL, ' +
                          ' NOMCORMARISOLCOMPLETA VARCHAR2(50) NULL, ' +
                          ' INDALGODAO CHAR(1) NULL, ' +
                          ' INDPOLIESTER CHAR(1) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1929');
  end;
  if VpaNumAtualizacao < 1930 then
  begin
    result := '1930';
    ExecutaComandoSql(Aux,'ALTER TABLE ETIQUETAPRODUTO ADD(DESQTDPRODUTO VARCHAR2(50) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1930');
  end;
  if VpaNumAtualizacao < 1931 then
  begin
    result := '1931';
    ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOORCAMENTOITEM DROP(SEQITEMORCAMENTO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1931');
  end;
  if VpaNumAtualizacao < 1932 then
  begin
    result := '1932';
    ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOORCAMENTO ADD( CODFILIALORCAMENTOBAIXA NUMBER(10) NULL, ' +
                          ' LANORCAMENTOBAIXA NUMBER(10) NULL, ' +
                          ' SEQORCAMENTOPARCIALBAIXA NUMBER(10) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1932');
  end;
  if VpaNumAtualizacao < 1933 then
  begin
    result := '1933';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_ETI_ROO NUMBER(10) NULL  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1933');
  end;
  if VpaNumAtualizacao < 1934 then
  begin
    result := '1934';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_IMP_ENR CHAR(1) NULL)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_IMP_ENR = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1934');
  end;
  if VpaNumAtualizacao < 1935 then
  begin
    result := '1935';
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_TIP_FAT = ''N'''+
                          ' Where C_TIP_FAT IS NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1935');
  end;
  if VpaNumAtualizacao < 1936 then
  begin
    result := '1936';
    ExecutaComandoSql(Aux,'CREATE TABLE CLIENTELOG ( ' +
                          ' CODCLIENTE NUMBER(10) NOT NULL, ' +
                          ' SEQLOG NUMBER(10) NOT NULL,' +
                          ' CODUSUARIO NUMBER(10) NOT NULL, ' +
                          ' DATLOG DATE NOT NULL, ' +
                          ' DESLOCALARQUIVO VARCHAR2(200) NULL, ' +
                          ' PRIMARY KEY(CODCLIENTE,SEQLOG))');
    ExecutaComandoSql(Aux,'CREATE INDEX CLIENTE_FK1 ON CLIENTELOG(CODCLIENTE)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1936');
  end;
  if VpaNumAtualizacao < 1937 then
  begin
    result := '1937';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD(I_COD_USU NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1937');
  end;
  if VpaNumAtualizacao < 1938 then
  begin
    result := '1938';
    ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOORCAMENTO ADD(QTDVOLUME NUMBER(10) NULL, ' +
                          ' PESBRUTO NUMBER(17,2) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1938');
  end;
  if VpaNumAtualizacao < 1939 then
  begin
    result := '1939';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD(C_PRO_EMP VARCHAR2(50) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1939');
  end;
  if VpaNumAtualizacao < 1940 then
  begin
    result := '1940';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ADD(N_PER_SUS NUMBER(15,3) NULL, ' +
                          ' N_VLR_SUS NUMBER(15,3) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1940');
  end;
  if VpaNumAtualizacao < 1941 then
  begin
    result := '1941';
    ExecutaComandoSql(Aux,'ALTER TABLE CHAMADOPRODUTO MODIFY DESSERVICOEXECUTADO VARCHAR2(2000)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1941');
  end;
  if VpaNumAtualizacao < 1942 then
  begin
    result := '1942';
    ExecutaComandoSql(Aux,'ALTER TABLE CHAMADOPRODUTO MODIFY DESPROBLEMA VARCHAR2(2000)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1942');
  end;
  if VpaNumAtualizacao < 1943 then
  begin
    result := '1943';
    ExecutaComandoSql(Aux,'ALTER TABLE OPITEMCADARCO MODIFY DESTAB VARCHAR2(500) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1943');
  end;
  if VpaNumAtualizacao < 1944 then
  begin
    result := '1944';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_COT_TIF NUMBER(5) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET I_COT_TIF = 1');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1944');
  end;
  if VpaNumAtualizacao < 1945 then
  begin
    result := '1945';
    ExecutaComandoSql(Aux,'CREATE TABLE MODULO( ' +
                          ' SEQMODULO NUMBER(10) NULL, ' +
                          ' NOMMODULO VARCHAR2(50) NULL, ' +
                          ' NOMCAMPOCFG VARCHAR2(50) NULL, ' +
                          ' NOMARQUIVOFTP VARCHAR2(150) NULL, ' +
                          ' DATULTIMAATUALIZACAO DATE, ' +
                          ' PRIMARY KEY(SEQMODULO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1945');
  end;
  if VpaNumAtualizacao < 1946 then
  begin
    result := '1946';
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(1,''PONTO DE VENDAS'',''C_MOD_PON'',''pontoloja.zip'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1946');
  end;
  if VpaNumAtualizacao < 1947 then
  begin
    result := '1947';
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(2,''FATURAMENTO'',''C_MOD_FAT'',''faturamento.zip'')');
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(3,''FINANCEIRO'',''C_MOD_FIN'',''financeiro.zip'')');
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(4,''ESTOQUE'',''C_MOD_EST'',''EstoqueCusto.zip'')');
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(5,''CHAMADO TECNICO'',''C_MOD_CHA'',''ChamadoTecnico.zip'')');
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(6,''CONFIGURACAO SISTEMA'',''C_CON_SIS'',''configuracoessistema.zip'')');
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(7,''CRM'',''C_MOD_CRM'',''CRM.zip'')');
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(8,''PDV ECF'',''C_MOD_PDV'',''efiPDV.zip'')');
    ExecutaComandoSql(Aux,'INSERT INTO MODULO(SEQMODULO,NOMMODULO,NOMCAMPOCFG,NOMARQUIVOFTP)     ' +
                          ' VALUES(9,''CAIXA'',''C_MOD_CAI'',''Caixa.zip'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1947');
  end;
  if VpaNumAtualizacao < 1948 then
  begin
    result := '1948';
    ExecutaComandoSql(Aux,'ALTER TABLE MODULO ADD INDATUALIZAR CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1948');
  end;
  if VpaNumAtualizacao < 1949 then
  begin
    result := '1949';
    ExecutaComandoSql(Aux,'alter table CFG_GERAL ADD(C_FTP_EFI VARCHAR2(150) NULL, ' +
                          ' C_USU_FTE VARCHAR2(50) NULL, ' +
                          ' C_SEN_FTE VARCHAR2(50) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1949');
  end;
  if VpaNumAtualizacao < 1950 then
  begin
    result := '1950';
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL ' +
                          ' SET C_FTP_EFI = ''public_html/downloads/SisCorp/'',' +
                          ' C_USU_FTE = ''eficaciaconsultoria1'',' +
                          ' C_SEN_FTE = ''rafael12''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1950');
  end;
  if VpaNumAtualizacao < 1951 then
  begin
    result := '1951';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CRM_DPR CHAR(1)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_CRM_DPR = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1951');
  end;
  if VpaNumAtualizacao < 1952 then
  begin
    result := '1952';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_CHA_ECH CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_CHA_ECH = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1952');
  end;
  if VpaNumAtualizacao < 1953 then
  begin
    result := '1953';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_CRM_APF CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_CRM_APF = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1953');
  end;
  if VpaNumAtualizacao < 1954 then
  begin
    result := '1954';
    ExecutaComandoSql(Aux,'ALTER TABLE TELEMARKETING MODIFY DESOBSERVACAO VARCHAR2(4000)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1954');
  end;
  if VpaNumAtualizacao < 1955 then
  begin
    result := '1955';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD(I_USU_CAN NUMBER(10) NULL,  ' +
                          ' D_DAT_CAN DATE NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1955');
  end;
  if VpaNumAtualizacao < 1956 then
  begin
    result := '1956';
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL ' +
                          'SET C_SEN_FTE = ''rafael12''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1956');
  end;
  if VpaNumAtualizacao < 1957 then
  begin
    result := '1957';
    ExecutaComandoSql(Aux,'INSERT INTO ARQUIVOAUXILIAR(NOMARQUIVO) VALUES(''ATUALIZAMODULOS.EXE'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1957');
  end;
  if VpaNumAtualizacao < 1958 then
  begin
    result := '1958';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD N_TOT_PSD NUMBER(15,4)NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1958');
  end;
  if VpaNumAtualizacao < 1959 then
  begin
    result := '1959';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS add N_VLR_DES NUMBER(15,2) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1959');
  end;
  if VpaNumAtualizacao < 1960 then
  begin
    result := '1960';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD(N_VLR_ICM NUMBER(15,2) NULL, ' +
                          ' N_BAS_ICM NUMBER(15,2))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1960');
  end;
  if VpaNumAtualizacao < 1961 then
  begin
    result := '1961';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD N_VLR_FRE NUMBER(15,2) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1961');
  end;
  if VpaNumAtualizacao < 1962 then
  begin
    result := '1962';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_EMA_RAM VARCHAR2(75) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1962');
  end;
  if VpaNumAtualizacao < 1963 then
  begin
    result := '1963';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_BAC_FTP CHAR(1) NULL, ' +
                          ' D_ENV_BAC DATE NULL, ' +
                          ' I_PER_BAC INTEGER NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1963');
  end;
  if VpaNumAtualizacao < 1964 then
  begin
    result := '1964';
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_BAC_FTP = ''T''' +
                          ', I_PER_BAC = 1 ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1964');
  end;
  if VpaNumAtualizacao < 1965 then
  begin
    result := '1965';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCONTASARECEBER ADD C_MOS_FLU CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1965');
  end;
  if VpaNumAtualizacao < 1966 then
  begin
    result := '1966';
    ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOORCAMENTO ADD INDBLOQUEADO CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'UPDATE ROMANEIOORCAMENTO SET INDBLOQUEADO = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1966');
  end;
  if VpaNumAtualizacao < 1967 then
  begin
    result := '1967';
    ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOORCAMENTOITEM ADD(DESUM CHAR(2) NULL, ' +
                          ' DESREFERENCIACLIENTE VARCHAR2(50)NULL, ' +
                          ' DESORDEMCOMPRA VARCHAR2(50)NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1967');
  end;
  if VpaNumAtualizacao < 1968 then
  begin
    result := '1968';
    ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOORCAMENTOITEM ADD(QTDPEDIDO NUMERIC(17,3)NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1968');
  end;
  if VpaNumAtualizacao < 1969 then
  begin
    result := '1969';
    ExecutaComandoSql(Aux,'alter table TAREFAEMARKETINGPROSPECT add (DESTEXTO VARCHAR2(4000)NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1969');
  end;
  if VpaNumAtualizacao < 1970 then
  begin
    result := '1970';
    ExecutaComandoSql(Aux,'alter table TAREFAEMARKETINGPROSPECT add (NUMFORMATOEMAIL NUMBER(1)NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1970');
  end;
  if VpaNumAtualizacao < 1971 then
  begin
    result := '1971';
    ExecutaComandoSql(Aux,'alter table CFG_GERAL ADD I_SMT_POR NUMBER(5) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_SMT_POR = 25');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1971');
  end;
  if VpaNumAtualizacao < 1972 then
  begin
    result := '1972';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD D_IMP_EFI DATE');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1972');
  end;
  if VpaNumAtualizacao < 1973 then
  begin
    result := '1973';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD C_NOT_INU CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS SET C_NOT_INU = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1973');
  end;
  if VpaNumAtualizacao < 1974 then
  begin
    result := '1974';
    ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACOR ADD(DATCADASTRO DATE NULL, ' +
                          ' DATFICHACOR DATE)');
    ExecutaComandoSql(Aux,'UPDATE AMOSTRACOR AMC SET DATCADASTRO = (SELECT DATAMOSTRA FROM AMOSTRA AMO WHERE AMO.CODAMOSTRA = AMC.CODAMOSTRA)');
    ExecutaComandoSql(Aux,'UPDATE AMOSTRACOR AMC SET DATFICHACOR = (SELECT DATFICHAAMOSTRA FROM AMOSTRA AMO WHERE AMO.CODAMOSTRA = AMC.CODAMOSTRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1974');
  end;
  if VpaNumAtualizacao < 1975 then
  begin
    result := '1975';
    ExecutaComandoSql(Aux,'create table PROPOSTAPRODUTOSCHAMADO '+
                          '(CODFILIAL NUMBER(10) NOT NULL, '+
                          ' SEQPROPOSTA NUMBER(10) NOT NULL, '+
                          ' SEQPRODUTOCHAMADO NUMBER(10) NOT NULL, '+
                          ' SEQITEMCHAMADO NUMBER(10) NOT NULL, '+
                          ' PRIMARY KEY (CODFILIAL, SEQPROPOSTA, SEQPRODUTOCHAMADO,SEQITEMCHAMADO))  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1975');
  end;
  if VpaNumAtualizacao < 1976 then
  begin
    result := '1976';
    ExecutaComandoSql(Aux,'ALTER TABLE ORDEMCORTEITEM ADD QTDMETROPRODUTO NUMBER(15,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1976');
  end;
  if VpaNumAtualizacao < 1977 then
  begin
    result := '1977';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_AMO_CFA CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_AMO_CFA = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1977');
  end;
  if VpaNumAtualizacao < 1978 then
  begin
    result := '1978';
    ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOORCAMENTO ADD DESMOTIVOBLOQUEIO VARCHAR2(100) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1978');
  end;
  if VpaNumAtualizacao < 1979 then
  begin
    result := '1979';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD C_NOT_DEV CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update MOVNATUREZA set C_NOT_DEV = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1979');
  end;
  if VpaNumAtualizacao < 1980 then
  begin
    result := '1980';
    ExecutaComandoSql(Aux,'alter TABLE CADNOTAFISCAIS ADD(N_PER_SSI NUMBER(15,2) NULL, ' +
                          ' N_ICM_SSI NUMBER(15,2) NULL )');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1980');
  end;
  if VpaNumAtualizacao < 1981 then
  begin
    result := '1981';
    ExecutaComandoSql(Aux,'ALTER TABLE ESTAGIOPROPOSTA ADD DESLOG VARCHAR2(1000)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1981');
  end;
  if VpaNumAtualizacao < 1982 then
  begin
    result := '1982';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD D_IMP_PRO DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1982');
  end;
  if VpaNumAtualizacao < 1983 then
  begin
    result := '1983';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_MAX_COP NUMBER(10)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1983');
  end;
  if VpaNumAtualizacao < 1984 then
  begin
    result := '1984';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTO MODIFY DESOBSERVACAO VARCHAR2(500)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1984');
  end;
  if VpaNumAtualizacao < 1985 then
  begin
    result := '1985';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTOSCHAMADO ADD VALTOTAL NUMBER(15,3)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1985');
  end;
  if VpaNumAtualizacao < 1986 then
  begin
    result := '1986';
    ExecutaComandoSql(Aux,'CREATE TABLE ESTAGIONOTAFISCALENTRADA ( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQNOTAFISCAL NUMBER(10) NOT NULL, ' +
                          ' CODESTAGIO NUMBER(10) NOT  NULL, ' +
                          ' SEQESTAGIO NUMBER(10) NOT NULL, ' +
                          ' DATESTAGIO DATE NULL, ' +
                          ' CODUSUARIO NUMBER(10) NULL, ' +
                          ' DESMOTIVO VARCHAR2(250) NULL, ' +
                          ' DESLOG VARCHAR2(2000) NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,SEQNOTAFISCAL,SEQESTAGIO), ' +
                          ' FOREIGN KEY (CODESTAGIO) REFERENCES ESTAGIOPRODUCAO(CODEST))');
    ExecutaComandoSql(Aux,'CREATE INDEX ESTAGIONOTAENTRADA_FK1 ON ESTAGIONOTAFISCALENTRADA(CODFILIAL,SEQNOTAFISCAL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1986');
  end;
  if VpaNumAtualizacao < 1987 then
  begin
    result := '1987';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD(C_NAD_DPI VARCHAR2(20), ' +
                          ' C_NAF_DPI VARCHAR2(20))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1987');
  end;
  if VpaNumAtualizacao < 1988 then
  begin
    result := '1988';
    ExecutaComandoSql(Aux,'alter table CADNOTAFISCAIS ADD I_TIP_NOT NUMBER(2)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1988');
  end;
  if VpaNumAtualizacao < 1989 then
  begin
    result := '1989';
    CadastraTransportadorasComoClientes;
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1989');
  end;
  if VpaNumAtualizacao < 1990 then
  begin
    result := '1990';
    ExecutaComandoSql(Aux,'update CADCLIENTES ORC ' +
                          ' set I_COD_TRA = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = ORC.I_COD_TRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1990');
  end;
  if VpaNumAtualizacao < 1991 then
  begin
    result := '1991';
    ExecutaComandoSql(Aux,'update CADCLIENTES ORC ' +
                          ' set I_COD_RED = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = ORC.I_COD_RED)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1991');
  end;
  if VpaNumAtualizacao < 1992 then
  begin
    result := '1992';
    ExecutaComandoSql(Aux,'update cadorcamentos ORC ' +
                          ' set I_COD_TRA = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = ORC.I_COD_TRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1992');
  end;
  if VpaNumAtualizacao < 1993 then
  begin
    result := '1993';
    ExecutaComandoSql(Aux,'update cadorcamentos ORC ' +
                          ' set I_COD_RED = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = ORC.I_COD_RED)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1993');
  end;
  if VpaNumAtualizacao < 1994 then
  begin
    result := '1994';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ' +
                          ' drop CONSTRAINT CADNOTAFIS_CADTRANSPO1  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1994');
  end;
  if VpaNumAtualizacao < 1995 then
  begin
    result := '1995';
    ExecutaComandoSql(Aux,'DROP TABLE PEDIDOCOMPRANOTAFISCALITEM ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1995');
  end;
  if VpaNumAtualizacao < 1996 then
  begin
    result := '1996';
    ExecutaComandoSql(Aux,'CREATE TABLE PEDIDOCOMPRANOTAFISCALITEM (' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQPEDIDO NUMBER(10) NOT NULL, ' +
                          ' SEQNOTA NUMBER(10) NOT NULL, ' +
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' SEQPRODUTO NUMBER(10) NULL, ' +
                          ' CODCOR NUMBER(10)  NULL, ' +
                          ' QTDPRODUTO NUMBER(15,4) NULL,' +
                          ' PRIMARY KEY(CODFILIAL,SEQPEDIDO,SEQNOTA,SEQITEM))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1996');
  end;
  if VpaNumAtualizacao < 1997 then
  begin
    result := '1997';
    ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD C_REC_PRE CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS SET C_REC_PRE =''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1997');
  end;
  if VpaNumAtualizacao < 1998 then
  begin
    result := '1998';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD N_OUT_DES NUMBER(15,2) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1998');
  end;
  if VpaNumAtualizacao < 1999 then
  begin
    result := '1999';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_CRM_EPC CHAR(1)');
    ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_CRM_EPC = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1999');
  end;
  if VpaNumAtualizacao < 2000 then
  begin
    result := '2000';
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2000');
  end;
  if VpaNumAtualizacao < 2001 then
  begin
    result := '2001';
    ExecutaComandoSql(Aux,'update CADNOTAFISCAIS NOTA ' +
                          ' set I_COD_TRA = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = NOTA.I_COD_TRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2001');
  end;
  if VpaNumAtualizacao < 2002 then
  begin
    result := '2002';
    ExecutaComandoSql(Aux,'update CADNOTAFISCAIS NOTA ' +
                          ' set I_COD_RED = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = NOTA.I_COD_RED)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2002');
  end;
  if VpaNumAtualizacao < 2003 then
  begin
    result := '2003';
    ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD(C_EST_MUP CHAR(1) NULL, ' +
                          ' C_EST_BOC CHAR(1) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2003');
  end;
  if VpaNumAtualizacao < 2004 then
  begin
    result := '2004';
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_MUP = ''F'','+
                          ' C_EST_BOC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2004');
  end;
  if VpaNumAtualizacao < 2005 then
  begin
    result := '2005';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_EPD CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_EPD = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2005');
  end;
  if VpaNumAtualizacao < 2006 then
  begin
    result := '2006';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTO MODIFY DESOBSERVACAO VARCHAR2(2000) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2006');
  end;
  if VpaNumAtualizacao < 2007 then
  begin
    result := '2007';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS MODIFY C_OBS_ORC VARCHAR2(2000) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2007');
  end;
  if VpaNumAtualizacao < 2008 then
  begin
    result := '2008';
    ExecutaComandoSql(Aux,'CREATE TABLE CLIENTETELEFONE( ' +
                          ' CODCLIENTE NUMBER(10) NOT NULL, ' +
                          ' SEQTELEFONE NUMBER(10) NOT NULL, ' +
                          ' DESTELEFONE VARCHAR2(15) NULL, ' +
                          ' PRIMARY KEY(CODCLIENTE,SEQTELEFONE))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2008');
  end;
  if VpaNumAtualizacao < 2009 then
  begin
    result := '2009';
    ExecutaComandoSql(Aux,'ALTER TABLE CONTRATOCORPO ADD(DATINICIOVIGENCIA DATE NULL, ' +
                          ' DATFIMVIGENCIA DATE) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2009');
  end;
  if VpaNumAtualizacao < 2010 then
  begin
    result := '2010';
    ExecutaComandoSql(Aux,'ALTER TABLE CONTRATOCORPO ADD(LANORCAMENTO NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2010');
  end;
  if VpaNumAtualizacao < 2011 then
  begin
    result := '2011';
    ExecutaComandoSql(Aux,'UPDATE CONTRATOCORPO SET DATINICIOVIGENCIA = DATASSINATURA');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2011');
  end;
  if VpaNumAtualizacao < 2012 then
  begin
    result := '2012';
    ExecutaComandoSql(Aux,'alter table cadclientes add C_SEN_ASS VARCHAR2(20) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2012');
  end;
  if VpaNumAtualizacao < 2013 then
  begin
    result := '2013';
    ExecutaComandoSql(Aux,'update CONTRATOCORPO SET DATFIMVIGENCIA = add_months(DATASSINATURA,QTDMESES)   ' +
                          ' WHERE DATFIMVIGENCIA IS NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2013');
  end;
  if VpaNumAtualizacao < 2014 then
  begin
    result := '2014';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_SER_OBR CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_SER_OBR = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2014');
  end;
  if VpaNumAtualizacao < 2015 then
  begin
    result := '2015';
    ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD I_CAM_VEN NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2015');
  end;
  if VpaNumAtualizacao < 2016 then
  begin
    result := '2016';
    ExecutaComandoSql(Aux,'ALTER TABLE CHEQUE ADD CODCLIENTE NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2016');
  end;
  if VpaNumAtualizacao < 2017 then
  begin
    result := '2017';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD (N_QTD_PEC NUMBER(15,3) NULL, ' +
                          ' N_COM_PRO NUMBER(10,2) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2017');
  end;
  if VpaNumAtualizacao < 2018 then
  begin
    result := '2018';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_CPC CHAR(1) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set C_COT_CPC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2018');
  end;
  if VpaNumAtualizacao < 2019 then
  begin
    result := '2019';
    ExecutaComandoSql(Aux,'ALTER TABLE PLANOCONTAORCADO drop PRIMARY KEY');
    ExecutaComandoSql(Aux,'DELETE FROM PLANOCONTAORCADO');
    ExecutaComandoSql(Aux,'ALTER TABLE PLANOCONTAORCADO ADD (CODCENTROCUSTO NUMBER(10)NOT NULL)');
    ExecutaComandoSql(Aux,'ALTER TABLE PLANOCONTAORCADO ' +
                          ' ADD PRIMARY KEY(CODEMPRESA,CODPLANOCONTA,CODCENTROCUSTO,ANOORCADO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2019');
  end;
  if VpaNumAtualizacao < 2020 then
  begin
    result := '2020';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD (I_PLA_CCO NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2020');
  end;
  if VpaNumAtualizacao < 2021 then
  begin
    result := '2021';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS MODIFY C_OBS_FIS VARCHAR2(2000)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2021');
  end;
  if VpaNumAtualizacao < 2022 then
  begin
    result := '2022';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ' +
                          ' drop CONSTRAINT CADNOTAFIS_CADTRANSPO15  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2022');
  end;
  if VpaNumAtualizacao < 2023 then
  begin
    result := '2023';
    CadastraTransportadorasComoClientes;
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2023');
  end;
  if VpaNumAtualizacao < 2024 then
  begin
    result := '2024';
    ExecutaComandoSql(Aux,'update CADNOTAFISCAISFOR NOTA ' +
                          ' set I_COD_TRA = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = NOTA.I_COD_TRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2024');
  end;
  if VpaNumAtualizacao < 2025 then
  begin
    result := '2025';
    ExecutaComandoSql(Aux,'update PEDIDOCOMPRACORPO NOTA ' +
                          ' set CODTRANSPORTADORA = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = NOTA.CODTRANSPORTADORA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2025');
  end;
  if VpaNumAtualizacao < 2026 then
  begin
    result := '2026';
    ExecutaComandoSql(Aux,'update ORCAMENTOROTEIROENTREGA NOTA ' +
                          ' set CODENTREGADOR = ( SELECT I_COD_CLI FROM CADCLIENTES CLI' +
                          ' where CLI.I_TRA_ANT = NOTA.CODENTREGADOR)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2026');
  end;
  if VpaNumAtualizacao < 2027 then
  begin
    result := '2027';
    ExecutaComandoSql(Aux,'CREATE TABLE GRUPOUSUARIORELATORIO( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' CODGRUPO NUMBER(10) NOT NULL, ' +
                          ' SEQRELATORIO NUMBER(10) NOT NULL, ' +
                          ' NOMRELATORIO VARCHAR2(300) NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,CODGRUPO,SEQRELATORIO))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2027');
  end;
  if VpaNumAtualizacao < 2028 then
  begin
    result := '2028';
    ExecutaComandoSql(Aux,'alter table CHAMADOPRODUTOORCADO ADD NOMPRODUTO VARCHAR2(100) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2028');
  end;
  if VpaNumAtualizacao < 2029 then
  begin
    result := '2029';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_GER_SRA CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_GER_SRA = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2029');
  end;
  if VpaNumAtualizacao < 2030 then
  begin
    result := '2030';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_LOC_REC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_LOC_REC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2030');
  end;
  if VpaNumAtualizacao < 2031 then
  begin
    result := '2031';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_LOC_EFN CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_LOC_EFN =''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2031');
  end;
  if VpaNumAtualizacao < 2032 then
  begin
    result := '2032';
    ExecutaComandoSql(Aux,'CREATE TABLE RECIBOLOCACAOCORPO ( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQRECIBO NUMBER(10) NOT NULL, ' +
                          ' SEQLEITURALOCACAO NUMBER(10), ' +
                          ' LANORCAMENTO NUMBER(10), ' +
                          ' CODCLIENTE NUMBER(10), ' +
                          ' DATEMISSAO DATE, ' +
                          ' VALTOTAL NUMBER(15,3), ' +
                          ' DESOBSERVACAO VARCHAR2(500), ' +
                          ' PRIMARY KEY(CODFILIAL,SEQRECIBO))');
    ExecutaComandoSql(Aux,'create index RECIBOLOCACAOCORPO_CP1 ON RECIBOLOCACAOCORPO(CODFILIAL,SEQLEITURALOCACAO)');
    ExecutaComandoSql(Aux,'create index RECIBOLOCACAOCORPO_CP2 ON RECIBOLOCACAOCORPO(CODFILIAL,LANORCAMENTO)');
    ExecutaComandoSql(Aux,'create index RECIBOLOCACAOCORPO_CP3 ON RECIBOLOCACAOCORPO(CODCLIENTE)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2032');
  end;
  if VpaNumAtualizacao < 2033 then
  begin
    result := '2033';
    ExecutaComandoSql(Aux,'CREATE TABLE RECIBOLOCACAOSERVICO( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQRECIBO NUMBER(10) NOT NULL, ' +
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' CODSERVICO NUMBER(10)  NULL, ' +
                          ' QTDSERVICO NUMBER(15,3) NULL, '+
                          ' VALUNITARIO NUMBER(15,3) NULL, ' +
                          ' VALTOTAL NUMBER(15,3) NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,SEQRECIBO,SEQITEM))');
    ExecutaComandoSql(Aux,'CREATE INDEX RECIBOLOCACAOSERVICO_FK1 ON RECIBOLOCACAOSERVICO(CODSERVICO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2033');
  end;
  if VpaNumAtualizacao < 2034 then
  begin
    result := '2034';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD N_BAI_EST NUMBER(17,3) NULL');
    ExecutaComandoSql(Aux,'UPDATE MOVORCAMENTOS SET N_BAI_EST = N_QTD_BAI');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2034');
  end;
  if VpaNumAtualizacao < 2035 then
  begin
    result := '2035';
    ExecutaComandoSql(Aux,'update CADCLIENTES '+
                          'SET C_END_ELE = lower(C_END_ELE) ' +
                          ' Where C_END_ELE IS NOT NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2035');
  end;
  if VpaNumAtualizacao < 2036 then
  begin
    result := '2036';
    ExecutaComandoSql(Aux,'update CONTATOCLIENTE '+
                          'SET DESEMAIL = lower(DESEMAIL) ' +
                          ' Where DESEMAIL IS NOT NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2036');
  end;
  if VpaNumAtualizacao < 2037 then
  begin
    result := '2037';
    ExecutaComandoSql(Aux,'update PROSPECT '+
                          'SET DESEMAILCONTATO = lower(DESEMAILCONTATO) ' +
                          ' Where DESEMAILCONTATO IS NOT NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2037');
  end;
  if VpaNumAtualizacao < 2038 then
  begin
    result := '2038';
    ExecutaComandoSql(Aux,'update CONTATOPROSPECT '+
                          'SET DESEMAIL = lower(DESEMAIL) ' +
                          ' Where DESEMAIL IS NOT NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2038');
  end;
  if VpaNumAtualizacao < 2039 then
  begin
    result := '2039';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER ADD C_IND_SIN CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADCONTASARECEBER set C_IND_SIN = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2039');
  end;
  if VpaNumAtualizacao < 2040 then
  begin
    result := '2040';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS add C_SIN_PAG CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS SET C_SIN_PAG = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2040');
  end;
  if VpaNumAtualizacao < 2041 then
  begin
    result := '2041';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_SIN_PAG CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_SIN_PAG = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2041');
  end;
  if VpaNumAtualizacao < 2042 then
  begin
    result := '2042';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ORD_EFE CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORD_EFE = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2042');
  end;
  if VpaNumAtualizacao < 2043 then
  begin
    result := '2043';
    ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACOR ADD DATENTREGA DATE NULL  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2043');
  end;
  if VpaNumAtualizacao < 2044 then
  begin
    result := '2044';
    ExecutaComandoSql(Aux,'UPDATE AMOSTRACOR COR ' +
                          ' SET DATENTREGA = (SELECT DATENTREGA FROM AMOSTRA AMO ' +
                          ' WHERE COR.CODAMOSTRA = AMO.CODAMOSTRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2044');
  end;
  if VpaNumAtualizacao < 2045 then
  begin
    result := '2045';
    ExecutaComandoSql(Aux,'CREATE TABLE AMOSTRACORESTAGIO( ' +
                          ' CODAMOSTRA NUMBER(10) NOT NULL, ' +
                          ' CODCOR NUMBER(10) NOT NULL, ' +
                          ' SEQESTAGIO NUMBER(10) NOT NULL, ' +
                          ' CODESTAGIO NUMBER(10) NULL, ' +
                          ' DATCADASTRO DATE NULL, ' +
                          ' CODUSUARIOCADASTRO NUMBER(10) NULL, ' +
                          ' DATFIM DATE NULL, ' +
                          ' CODUSUARIOFIM NUMBER(10) NULL, ' +
                          ' PRIMARY KEY(CODAMOSTRA, CODCOR,SEQESTAGIO))');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRACORESTAGIO_FK1 ON AMOSTRACORESTAGIO(CODAMOSTRA,CODCOR) ');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRACORESTAGIO_FK2 ON AMOSTRACORESTAGIO(CODESTAGIO) ');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRACORESTAGIO_FK3 ON AMOSTRACORESTAGIO(CODUSUARIOCADASTRO) ');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRACORESTAGIO_FK4 ON AMOSTRACORESTAGIO(CODUSUARIOFIM) ');
    ExecutaComandoSql(Aux,'CREATE INDEX AMOSTRACORESTAGIO_CP1 ON AMOSTRACORESTAGIO(DATFIM) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2045');
  end;
  if VpaNumAtualizacao < 2046 then
  begin
    result := '2046';
    ExecutaComandoSql(Aux,'create index MOVQDADEPRODUTO_CP2 ON MOVQDADEPRODUTO(D_ULT_ALT)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2046');
  end;
  if VpaNumAtualizacao < 2047 then
  begin
    result := '2047';
    ExecutaComandoSql(Aux,'alter table cadclientes add C_IND_COF CHAR(1)NULL');
    ExecutaComandoSql(Aux,'UPDATE cadclientes SET C_IND_COF = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2047');
  end;
  if VpaNumAtualizacao < 2048 then
  begin
    result := '2048';
    ExecutaComandoSql(Aux,'alter table MOVNOTASFISCAIS ADD( ' +
                          ' N_BAS_SUT NUMBER(15,2) NULL, ' +
                          ' N_VAL_SUT NUMBER(15,2) NULL)');
    ExecutaComandoSql(Aux,'UPDATE cadclientes SET C_IND_COF = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2048');
  end;
  if VpaNumAtualizacao < 2049 then
  begin
    result := '2049';
    ExecutaComandoSql(Aux,'alter table CADFILIAIS MODIFY C_NOM_FIL VARCHAR2(70)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2049');
  end;
  if VpaNumAtualizacao < 2050 then
  begin
    result := '2050';
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAFORNECEDORCORPO ' +
                          ' drop CONSTRAINT ORCAMENTOC_CADTRANSPO72  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2050');
  end;
  if VpaNumAtualizacao < 2051 then
  begin
    result := '2051';
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRACORPO ' +
                          ' drop CONSTRAINT ORCAMENTOC_CADTRANSPO71');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2051');
  end;
end;

{******************************************************************************}
function TAtualiza.AtualizaTabela4(VpaNumAtualizacao: Integer): String;
begin
  if VpaNumAtualizacao < 2052 then
  begin
    result := '2052';
{    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ' +
                          ' drop CONSTRAINT CADNOTAFIS_CADTRANSPO14  ');}
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2052');
  end;
  if VpaNumAtualizacao < 2053 then
  begin
    result := '2053';
    ExecutaComandoSql(Aux,'DROP TABLE CADTRANSPORTADORAS');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2053');
  end;
  if VpaNumAtualizacao < 2054 then
  begin
    result := '2054';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_VEI_PRO CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_VEI_PRO = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2054');
  end;
  if VpaNumAtualizacao < 2055 then
  begin
    result := '2055';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_CUS_LPV CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CUS_LPV = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2055');
  end;
  if VpaNumAtualizacao < 2056 then
  begin
    result := '2056';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD( I_AMO_COL NUMBER(10) NULL, ' +
                          ' I_AMO_CDP NUMBER(10) NULL, ' +
                          ' I_AMO_CDE NUMBER(10) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2056');
  end;
  if VpaNumAtualizacao < 2057 then
  begin
    result := '2057';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD C_COD_CST CHAR(2) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2057');
  end;
  if VpaNumAtualizacao < 2058 then
  begin
    result := '2058';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA DROP(I_PLA_CCO) ');
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD(C_PLA_CCO VARCHAR2(5) NULL) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2058');
  end;
  if VpaNumAtualizacao < 2059 then
  begin
    result := '2059';
    ExecutaComandoSql(Aux,'UPDATE MOVNOTASFISCAISFOR SET N_VLR_BIC = N_TOT_PRO, ' +
                          ' C_COD_CST = ''000''');
    ExecutaComandoSql(Aux,'UPDATE MOVNOTASFISCAISFOR SET N_VLR_ICM = N_TOT_PRO  * 0.17');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2059');
  end;
  if VpaNumAtualizacao < 2060 then
  begin
    result := '2060';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR ADD (N_VLR_DES NUMBER(15,3) NULL,  ' +
                          ' N_OUT_DES NUMBER(15,3) NULL, ' +
                          ' N_VLR_FRE NUMBER(15,3) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2060');
  end;
  if VpaNumAtualizacao < 2061 then
  begin
    result := '2061';
    ExecutaComandoSql(Aux,'alter table MOVNOTASFISCAISFOR ADD (I_COD_CFO NUMBER(5)NULL)');
    ExecutaComandoSql(Aux,'alter table MOVNOTASFISCAISFOR DROP (C_COD_NAT)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2061');
  end;
  if VpaNumAtualizacao < 2062 then
  begin
    result := '2062';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_CST_IPE CHAR(4) NULL,' +
                          ' C_CST_PIS CHAR(4) NULL, ' +
                          ' C_CST_PIE CHAR(4) NULL, ' +
                          ' C_CST_COS CHAR(4) NULL, ' +
                          ' C_CST_COE CHAR(4) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2062');
  end;
  if VpaNumAtualizacao < 2063 then
  begin
    result := '2063';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVSERVICONOTAFOR ADD I_COD_CFO NUMBER(5)NULL');
    ExecutaComandoSql(Aux,'UPDATE MOVSERVICONOTAFOR SET I_COD_CFO = 1100');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2063');
  end;
  if VpaNumAtualizacao < 2064 then
  begin
    result := '2064';
    ExecutaComandoSql(Aux,'delete from TABELAIMPORTACAOFILTRO '+
                          ' WHERE CODTABELA = 20');
    ExecutaComandoSql(Aux,'delete from TABELAIMPORTACAO '+
                          ' WHERE CODTABELA = 20');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2064');
  end;
  if VpaNumAtualizacao < 2065 then
  begin
    result := '2065';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD I_MOD_DOC NUMBER(10)NULL');
    ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS SET I_MOD_DOC = 55');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2065');
  end;
  if VpaNumAtualizacao < 2066 then
  begin
    result := '2066';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD C_CON_ANA VARCHAR2(20)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2066');
  end;
  if VpaNumAtualizacao < 2067 then
  begin
    result := '2067';
    ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACORMOTIVOATRASO' +
                          ' drop CONSTRAINT AMOSTRACORMOTIVOATRASO  ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2067');
  end;
  if VpaNumAtualizacao < 2068 then
  begin
    result := '2068';
    ExecutaComandoSql(Aux,'CREATE TABLE TRANSFERENCIAEXTERNACORPO (' +
                          ' SEQTRANSFERENCIA  NUMBER(10) NOT NULL, '+
                          ' DATTRANSFERENCIA DATE, ' +
                          ' CODUSUARIO NUMBER(10) NULL, ' +
                          ' VALTOTAL NUMBER(15,3) NULL, '+
                          ' SEQCAIXA NUMBER(10) NULL, ' +
                          ' PRIMARY KEY(SEQTRANSFERENCIA))');
    ExecutaComandoSql(Aux,'CREATE INDEX TRANSFERENCIAEXTCORP_FK1 ON TRANSFERENCIAEXTERNACORPO(SEQCAIXA)');
    ExecutaComandoSql(Aux,'CREATE INDEX TRANSFERENCIAEXTCORP_FK2 ON TRANSFERENCIAEXTERNACORPO(CODUSUARIO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2068');
  end;
  if VpaNumAtualizacao < 2069 then
  begin
    result := '2069';
    ExecutaComandoSql(Aux,'CREATE TABLE TRANSFERENCIAEXTERNAITEM ( ' +
                          ' SEQTRANSFERENCIA NUMBER(10) NOT NULL REFERENCES TRANSFERENCIAEXTERNACORPO(SEQTRANSFERENCIA),'+
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' VALATUAL NUMBER(15,3) NULL, ' +
                          ' CODFORMAPAGAMENTO NUMBER(10) NULL, ' +
                          ' PRIMARY KEY (SEQTRANSFERENCIA,SEQITEM)) ');
    ExecutaComandoSql(Aux,'CREATE INDEX TRANSFERENCIAEXTITE_FK1 ON TRANSFERENCIAEXTERNAITEM(CODFORMAPAGAMENTO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2069');
  end;
  if VpaNumAtualizacao < 2070 then
  begin
    result := '2070';
    ExecutaComandoSql(Aux,'CREATE TABLE TRANSFERENCIAEXTERNACHEQUE (' +
                          ' SEQTRANSFERENCIA NUMBER(10) NOT NULL, ' +
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' SEQITEMCHEQUE NUMBER(10) NOT NULL, ' +
                          ' SEQCHEQUE NUMBER(10) NULL, '+
                          ' PRIMARY KEY(SEQTRANSFERENCIA,SEQITEM,SEQITEMCHEQUE))');
    ExecutaComandoSql(Aux,'ALTER TABLE TRANSFERENCIAEXTERNACHEQUE add CONSTRAINT TRANSFEXTERCHEQUE_ITEM '+
                          ' FOREIGN KEY (SEQTRANSFERENCIA,SEQITEM) '+
                          '  REFERENCES TRANSFERENCIAEXTERNAITEM (SEQTRANSFERENCIA,SEQITEM) ');
    ExecutaComandoSql(Aux,'CREATE INDEX TRANSFIAEXTCHEQUE_FK1 ON TRANSFERENCIAEXTERNACHEQUE(SEQCHEQUE)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2070');
  end;
  if VpaNumAtualizacao < 2071 then
  begin
    result := '2071';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ORD_RRA CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORD_RRA = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2071');
  end;
  if VpaNumAtualizacao < 2072 then
  begin
    result := '2072';
    ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPFACCIONISTA ADD DATDIGITACAO DATE NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2072');
  end;
  if VpaNumAtualizacao < 2073 then
  begin
    result := '2073';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR ADD N_RED_BAS NUMBER(15,3) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2073');
  end;
  if VpaNumAtualizacao < 2074 then
  begin
    result := '2074';
    ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL(CODTIPODOCUMENTOFISCAL,NOMTIPODOCUMENTOFISCAL) VALUES(''IS'',''NOTA FISCAL SERVICO PREFETURA'')');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2074');
  end;
  if VpaNumAtualizacao < 2075 then
  begin
    result := '2075';
    ExecutaComandoSql(Aux,'CREATE TABLE CONHECIMENTOTRANSPORTE( ' +
                          ' SEQCONHECIMENTO NUMBER(10) NOT NULL, ' +
                          ' CODTRANSPORTADORA NUMBER(10) NOT NULL, ' +
                          ' CODFILIALNOTA NUMBER(10), ' +
                          ' SEQNOTASAIDA NUMBER(10), ' +
                          ' SEQNOTAENTRADA NUMBER(10), ' +
                          ' CODMODELODOCUMENTO CHAR(2) NULL, ' +
                          ' DATCONHECIMENTO DATE NULL, ' +
                          ' NUMTIPOCONHECIMENTO NUMBER(1) NULL, ' +
                          ' VALCONHECIMENTO NUMBER(15,3) NULL, ' +
                          ' VALBASEICMS NUMBER(15,3) NULL, ' +
                          ' VALICMS NUMBER(15,3) NULL, ' +
                          ' PESFRETE NUMBER(15,3) NULL, ' +
                          ' VALNAOTRIBUTADO NUMBER(15,3) NULL, ' +
                          ' PRIMARY KEY(SEQCONHECIMENTO))');
    ExecutaComandoSql(Aux,'CREATE INDEX CONHECIMENTOTRANSPORTE_FK1 ON CONHECIMENTOTRANSPORTE(CODFILIALNOTA,SEQNOTASAIDA)');
    ExecutaComandoSql(Aux,'CREATE INDEX CONHECIMENTOTRANSPORTE_FK2 ON CONHECIMENTOTRANSPORTE(CODFILIALNOTA,SEQNOTAENTRADA)');
    ExecutaComandoSql(Aux,'CREATE INDEX CONHECIMENTOTRANSPORTE_FK3 ON CONHECIMENTOTRANSPORTE(CODTRANSPORTADORA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2075');
  end;
  if VpaNumAtualizacao < 2076 then
  begin
    result := '2076';
    ExecutaComandoSql(Aux,'alter table movnotasfiscais add C_DES_ADI VARCHAR2(500) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2076');
  end;
  if VpaNumAtualizacao < 2077 then
  begin
    result := '2077';
    ExecutaComandoSql(Aux,'ALTER TABLE SETOR ADD DESDIRETORIOSALVARPDF VARCHAR2(200) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2077');
  end;
  if VpaNumAtualizacao < 2078 then
  begin
    result := '2078';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVSERVICONOTA ADD N_PER_ISQ NUMBER(5,2) NULL');
    ExecutaComandoSql(Aux,' UPDATE MOVSERVICONOTA MOV '+
                          ' SET N_PER_ISQ = (SELECT N_PER_ISQ FROM CADNOTAFISCAIS CAD '+
                          ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                          ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2078');
  end;
  if VpaNumAtualizacao < 2079 then
  begin
    result := '2079';
    ExecutaComandoSql(Aux,'alter table TAREFAEMARKETING add (DESTEXTO VARCHAR2(4000)NULL, ' +
                          ' NUMFORMATOEMAIL NUMBER(1)NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2079');
  end;
  if VpaNumAtualizacao < 2080 then
  begin
    result := '2080';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_LEI_SEF CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_LEI_SEF = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2080');
  end;
  if VpaNumAtualizacao < 2081 then
  begin
    result := '2081';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFORMASPAGAMENTO ADD N_PER_DES NUMBER(5,2)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2081');
  end;
  if VpaNumAtualizacao < 2082 then
  begin
    result := '2082';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFORMASPAGAMENTO ADD I_DIA_CHE NUMBER(10)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2082');
  end;
  if VpaNumAtualizacao < 2083 then
  begin
    result := '2083';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_REL_FAC NUMBER(10)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2083');
  end;
  if VpaNumAtualizacao < 2084 then
  begin
    result := '2084';
    ExecutaComandoSql(Aux,'ALTER TABLE RETORNOFRACAOOPFACCIONISTA ADD DATDIGITACAO DATE NULL');
    ExecutaComandoSql(Aux,'update RETORNOFRACAOOPFACCIONISTA set DATDIGITACAO = DATCADASTRO');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2084');
  end;
  if VpaNumAtualizacao < 2085 then
  begin
    result := '2085';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCONDICAOPAGTO ADD I_COD_FRM NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2085');
  end;
  if VpaNumAtualizacao < 2086 then
  begin
    result := '2086';
    ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD I_COR_AGE NUMBER(10) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADUSUARIOS SET I_COR_AGE = 12639424' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2086');
  end;
  if VpaNumAtualizacao < 2087 then
  begin
    result := '2087';
    ExecutaComandoSql(Aux,'ALTER TABLE CAIXACORPO ADD(VALINICIALCHEQUE NUMBER(15,3) NULL, ' +
                          ' VALATUALCHEQUE NUMBER(15,3) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2087');
  end;
  if VpaNumAtualizacao < 2088 then
  begin
    result := '2088';
    ExecutaComandoSql(Aux,'alter table CADNOTAFISCAIS DROP(C_REV_EDS)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2088');
  end;
  if VpaNumAtualizacao < 2089 then
  begin
    result := '2089';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD(C_EST_EMB CHAR(2) NULL, ' +
                          ' C_LOC_EMB VARCHAR2(60) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2089');
  end;
  if VpaNumAtualizacao < 2090 then
  begin
    result := '2090';
    ExecutaComandoSql(Aux,'CREATE TABLE CONTAARECEBERSINALPAGAMENTO (' +
                          ' CODFILIAL NUMBER(10) NOT NULL,  ' +
                          ' LANRECEBER NUMBER(10) NOT NULL, ' +
                          ' CODFILIALSINAL NUMBER(10) NOT NULL, ' +
                          ' LANRECEBERSINAL NUMBER(10) NOT NULL, ' +
                          ' NUMPARCELASINAL NUMBER(10) NOT NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,LANRECEBER,CODFILIALSINAL,LANRECEBERSINAL,NUMPARCELASINAL))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2090');
  end;
  if VpaNumAtualizacao < 2091 then
  begin
    result := '2091';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER ADD C_POS_SIN CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADCONTASARECEBER SET C_POS_SIN = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2091');
  end;
  if VpaNumAtualizacao < 2092 then
  begin
    result := '2092';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD N_SIN_PAG NUMBER(15,3)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2092');
  end;
  if VpaNumAtualizacao < 2093 then
  begin
    result := '2093';
    ExecutaComandoSql(Aux,'alter table MOVCONTASARECEBER ADD N_SIN_BAI NUMBER(15,3)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2093');
  end;
  if VpaNumAtualizacao < 2094 then
  begin
    result := '2094';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_ACG CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_ACG = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2094');
  end;
  if VpaNumAtualizacao < 2095 then
  begin
    result := '2095';
    ExecutaComandoSql(Aux,'DROP TABLE CONTAARECEBERSINALPAGAMENTO ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2095');
  end;
  if VpaNumAtualizacao < 2096 then
  begin
    result := '2096';
    ExecutaComandoSql(Aux,'CREATE TABLE NOTAFISCALSINALPAGAMENTO (' +
                          ' CODFILIAL NUMBER(10) NOT NULL,  ' +
                          ' SEQNOTAFISCAL NUMBER(10) NOT NULL, ' +
                          ' CODFILIALSINAL NUMBER(10) NOT NULL, ' +
                          ' LANRECEBERSINAL NUMBER(10) NOT NULL, ' +
                          ' NUMPARCELASINAL NUMBER(10) NOT NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,SEQNOTAFISCAL,CODFILIALSINAL,LANRECEBERSINAL,NUMPARCELASINAL))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2096');
  end;
  if VpaNumAtualizacao < 2097 then
  begin
    result := '2097';
    ExecutaComandoSql(Aux,'ALTER TABLE CHEQUE ADD DESORIGEM CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2097');
  end;
  if VpaNumAtualizacao < 2098 then
  begin
    result := '2098';
    ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTO MODIFY NOMPRODUTO VARCHAR2(90)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2098');
  end;
  if VpaNumAtualizacao < 2099 then
  begin
    result := '2099';
    ExecutaComandoSql(Aux,'ALTER TABLE AGENDA ADD DESTITULO VARCHAR2(100) NULL');
    ExecutaComandoSql(Aux,'UPDATE AGENDA SET DESTITULO =  SUBSTR(DESOBSERVACAO,1,50) '+
                          ' Where INDREALIZADO = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2099');
  end;
  if VpaNumAtualizacao < 2100 then
  begin
    result := '2100';
    ExecutaComandoSql(Aux,' ALTER TABLE AMOSTRACORMOTIVOATRASO ADD(DATCADASTRO DATE) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2100');
  end;
  if VpaNumAtualizacao < 2101 then
  begin
    result := '2101';
    ExecutaComandoSql(Aux,' UPDATE AMOSTRACORMOTIVOATRASO AMT SET DATCADASTRO = ' +
                          ' (SELECT DATAMOSTRA FROM AMOSTRA AMO' +
                          ' WHERE AMO.CODAMOSTRA = AMT.CODAMOSTRA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2101');
  end;
  if VpaNumAtualizacao < 2102 then
  begin
    result := '2102';
    ExecutaComandoSql(Aux,'alter table CFG_FINANCEIRO ADD C_CON_FIL CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_CON_FIL = ''T''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2102');
  end;
  if VpaNumAtualizacao < 2103 then
  begin
    result := '2103';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_BCA_FIL CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_BCA_FIL = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2103');
  end;
  if VpaNumAtualizacao < 2104 then
  begin
    result := '2104';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_SOM_URC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_SOM_URC =''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2104');
  end;
  if VpaNumAtualizacao < 2105 then
  begin
    result := '2105';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTAS ADD I_QTD_RET NUMBER(10)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2105');
  end;
  if VpaNumAtualizacao < 2106 then
  begin
    result := '2106';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCLASSIFICACAO ADD N_PER_MAX NUMBER(8,3)NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2106');
  end;
  if VpaNumAtualizacao < 2107 then
  begin
    result := '2107';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS DROP(N_CUS_UNI)');
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD(N_CUS_TOT NUMBER(15,3) NULL, ' +
                          ' N_VEN_LIQ NUMBER(15,3) NULL, ' +
                          ' N_MAR_BRU NUMBER(8,2) NULL,' +
                          ' N_MAR_LIQ NUMBER(8,2) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2107');
  end;
  if VpaNumAtualizacao < 2108 then
  begin
    result := '2108';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_TEC_ACE CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_TEC_ACE = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2108');
  end;
  if VpaNumAtualizacao < 2109 then
  begin
    result := '2109';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_ORP_ACE CHAR(1) NULL, ' +
                          ' C_EAN_ACE CHAR(1) NULL, ' +
                          ' C_LEI_SEF CHAR(1) NULL)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORP_ACE = (SELECT C_ORP_ACE FROM CFG_PRODUTO)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_EAN_ACE = (SELECT C_EAN_ACE FROM CFG_PRODUTO)');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_LEI_SEF = (SELECT C_LEI_SEF FROM CFG_PRODUTO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2109');
  end;
  if VpaNumAtualizacao < 2110 then
  begin
    result := '2110';
    ExecutaComandoSql(Aux,'CREATE TABLE ESTOQUENUMEROSERIE( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL, ' +
                          ' SEQPRODUTO NUMBER(10) NOT NULL, ' +
                          ' CODCOR NUMBER(10) NOT NULL, ' +
                          ' CODTAMANHO NUMBER(10) NOT NULL, ' +
                          ' SEQESTOQUE NUMBER(10) NOT NULL, ' +
                          ' DESNUMEROSERIE VARCHAR2(50) NULL, ' +
                          ' QTDPRODUTO NUMBER(17,4)NULL, ' +
                          ' PRIMARY KEY(CODFILIAL,SEQPRODUTO,CODCOR,CODTAMANHO,SEQESTOQUE))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2110');
  end;
  if VpaNumAtualizacao < 2111 then
  begin
    result := '2111';
    ExecutaComandoSql(Aux,'ALTER TABLE COR MODIFY NOM_COR VARCHAR2(150)');
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS MODIFY C_DES_COR VARCHAR2(150)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2111');
  end;
  if VpaNumAtualizacao < 2112 then
  begin
    result := '2112';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_CID_FRE CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FISCAL SET C_CID_FRE = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2112');
  end;
  if VpaNumAtualizacao < 2113 then
  begin
    result := '2113';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD( C_UNI_QUI CHAR(2) NULL, ' +
                          ' C_UNI_MIL CHAR(2) NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2113');
  end;
  if VpaNumAtualizacao < 2114 then
  begin
    result := '2114';
    ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD (D_ULT_RPS DATE NULL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 2114');
  end;
end;

function TAtualiza.AtualizaTabela5(VpaNumAtualizacao: Integer): String;
begin

end;


end.

