unit UnProgramador1;

interface
Uses SQLExpr, Classes, SysUtils;
Const
  CT_VersaoBancoProgramador1 = 202;

Type
  TRBFunProgramador1 = class
    private
      procedure AtualizaTabela(VpaNumAtualizacao : Integer);
    public
      Aux : TSQLQuery;
      constructor cria(VpaBaseDados : TSQLConnection );
      destructor destroy;override;
      procedure AtualizaBanco;
      function AtualizaBanco1(VpaNumAtualizacao: integer): string;
  end;

implementation

uses FunSql, ConstMsg;

{ TRBFunProgramador1 }

{******************************************************************************}
procedure TRBFunProgramador1.AtualizaBanco;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_ULT_PR1 from Cfg_Geral ');
  if Aux.FieldByName('I_ULT_PR1').AsInteger < CT_VersaoBancoProgramador1 Then
    AtualizaTabela(Aux.FieldByName('I_ULT_PR1').AsInteger);
  Aux.Close;
end;


{******************************************************************************}
constructor TRBFunProgramador1.cria(VpaBaseDados: TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFunProgramador1.destroy;
begin
  aux.Free;
  inherited;
end;

{******************************************************************************}
procedure TRBFunProgramador1.AtualizaTabela(VpaNumAtualizacao: Integer);
var
  VpfSemErros : Boolean;
  VpfErro : String;
begin
  VpfSemErros := true;
//  FAbertura.painelTempo1.Execute('Atualizando o Banco de Dados. Aguarde...');
  repeat
    Try
      if VpaNumAtualizacao < 1 Then
      begin
        VpfErro := '1';
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 1');
      end;
      if VpaNumAtualizacao < 2 Then
      begin
        VpfErro := '2';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_ALT_GCA CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_ALT_GCA = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 2');
      end;
      if VpaNumAtualizacao < 3 Then
      begin
        VpfErro := '3';
        ExecutaComandoSql(Aux,'ALTER TABLE TABELAIMPORTACAO ADD INDIMPORTAR CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE TABELAIMPORTACAO SET INDIMPORTAR = ''S''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 3');
      end;
      if VpaNumAtualizacao < 4 then
      begin
        VpfErro := '4';
        ExecutaComandoSql(Aux,'update TABELAIMPORTACAO set DESCAMPODATA = ''D_DAT_ALT'''+
                              ' Where CODTABELA = 31');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 4');
      end;
      if VpaNumAtualizacao < 5 then
      begin
        VpfErro := '5';
        ExecutaComandoSql(Aux,'ALTER TABLE ESTAGIOPRODUCAO ADD DATALT DATE NULL');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(33,3200,''ESTAGIOPRODUCAO'',''CADASTRO DE ESTAGIOS PRODUCAO'',''DATALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(33,1,''CODEST'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 5');
      end;
      if VpaNumAtualizacao < 6 then
      begin
        VpfErro := '6';
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(34,3300,''CADUNIDADE'',''CADASTRO DE UNIDADES DE MEDIDA'',''D_ULT_ALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(34,1,''C_COD_UNI'',3)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 6');
      end;
      if VpaNumAtualizacao < 7 then
      begin
        VpfErro := '7';
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(35,3400,''MOVINDICECONVERSAO'',''CADASTRO DE INDICE DE DE CONVERSAO UM'',''D_ULT_ALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(35,1,''C_UNI_COV'',3)');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(35,2,''C_UNI_ATU'',3)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 7');
      end;
      if VpaNumAtualizacao < 8 then
      begin
        VpfErro := '8';
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(36,3500,''CADCLASSIFICACAO'',''CADASTRO DE CLASSIFICACAO'',''D_ULT_ALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(36,1,''I_COD_EMP'',1)');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(36,2,''C_COD_CLA'',3)');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA, SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(36,3,''C_TIP_CLA'',3)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 8');
      end;
      if VpaNumAtualizacao < 9 then
      begin
        VpfErro := '9';
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(37,3500,''CADMOEDAS'',''CADASTRO DE MOEDAS'',''D_ULT_ALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(37,1,''I_COD_MOE'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 9');
      end;
      if VpaNumAtualizacao < 10 then
      begin
        VpfErro := '10';
        ExecutaComandoSql(Aux,'ALTER TABLE PRINCIPIOATIVO ADD DATULTIMAALTERACAO DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(38,3600,''PRINCIPIOATIVO'',''CADASTRO DE PRINCIPIO ATIVO'',''DATULTIMAALTERACAO'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(38,1,''CODPRINCIPIO'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 10');
      end;
      if VpaNumAtualizacao < 11 then
      begin
        VpfErro := '11';
        ExecutaComandoSql(Aux,'ALTER TABLE MAQUINA ADD DATALT DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(39,3700,''MAQUINA'',''CADASTRO DE MAQUINA'',''DATALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(39,1,''CODMAQ'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 11');
      end;
      if VpaNumAtualizacao < 12 then
      begin
        VpfErro := '12';
        ExecutaComandoSql(Aux,'ALTER TABLE CADTIPOFUNDO ADD D_ULT_ALT DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(40,3800,''CADTIPOFUNDO'',''CADASTRO DE TIPO DE FUNDO'',''D_ULT_ALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(40,1,''I_COD_FUN'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 12');
      end;
      if VpaNumAtualizacao < 13 then
      begin
        VpfErro := '13';
        ExecutaComandoSql(Aux,'ALTER TABLE TIPOEMENDA ADD DATALT DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(41,3900,''TIPOEMENDA'',''CADASTRO DE TIPO DE EMENDA'',''DATALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(41,1,''CODEME'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 13');
      end;
      if VpaNumAtualizacao < 15 then
      begin
        VpfErro := '15';
        ExecutaComandoSql(Aux,'ALTER TABLE TIPOCORTE ADD DATALT DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(42,4000,''TIPOCORTE'',''CADASTRO DE TIPO DE CORTE'',''DATALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(42,1,''CODCORTE'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 15');
      end;
      if VpaNumAtualizacao < 16 then
      begin
        VpfErro := '16';
        ExecutaComandoSql(Aux,'ALTER TABLE EMBALAGEM ADD DAT_ULTIMA_ALTERACAO DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(43,4100,''EMBALAGEM'',''CADASTRO DE EMBALAGEM'',''DAT_ULTIMA_ALTERACAO'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(43,1,''COD_EMBALAGEM'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 16');
      end;
      if VpaNumAtualizacao < 17 then
      begin
        VpfErro := '17';
        ExecutaComandoSql(Aux,'ALTER TABLE ACONDICIONAMENTO ADD DATULTIMAALTERACAO DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(44,4200,''ACONDICIONAMENTO'',''CADASTRO DE ACONDICIONAMENTO'',''DATULTIMAALTERACAO'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(44,1,''CODACONDICIONAMENTO'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 17');
      end;
      if VpaNumAtualizacao < 18 then
      begin
        VpfErro := '18';
        ExecutaComandoSql(Aux,'ALTER TABLE COMPOSICAO ADD DATULTIMAALTERACAO DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(45,4300,''COMPOSICAO'',''CADASTRO DE COMPOSICAO'',''DATULTIMAALTERACAO'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(45,1,''CODCOMPOSICAO'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 18');
      end;
      if VpaNumAtualizacao < 19 then
      begin
        VpfErro := '19';
        ExecutaComandoSql(Aux,'ALTER TABLE REPRESENTADA ADD DATULTIMAALTERACAO DATE');
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(46,4400,''REPRESENTADA'',''CADASTRO DE REPRESENTADA'',''DATULTIMAALTERACAO'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(46,1,''CODREPRESENTADA'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 19');
      end;
      if VpaNumAtualizacao < 20 then
      begin
        VpfErro := '20';
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(47,4500,''CADMOEDAS'',''CADASTRO DE MOEDAS'',''D_ULT_ALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(47,1,''I_COD_MOE'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 20');
      end;
      if VpaNumAtualizacao < 21 then
      begin
        VpfErro := '21';
        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAO(CODTABELA, SEQIMPORTACAO,NOMTABELA,DESTABELA,DESCAMPODATA,INDIMPORTAR) '   +
                              ' VALUES(48,4600,''CADPRODUTOS'',''CADASTRO DE PRODUTOS'',''D_ULT_ALT'', ''S'')');

        ExecutaComandoSql(Aux,'INSERT INTO TABELAIMPORTACAOFILTRO(CODTABELA,SEQFILTRO,NOMCAMPO,TIPCAMPO) ' +
                              ' VALUES(48,1,''I_SEQ_PRO'',1)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 21');
      end;
      if VpaNumAtualizacao < 22 then
      begin
        VpfErro := '22';
        ExecutaComandoSql(Aux,' ALTER TABLE CADPRODUTOS ADD (C_SIS_TEA VARCHAR2(10) NULL, ' +
                              '                              C_BCM_TEA VARCHAR2(10) NULL, ' +
                              '                              C_IND_PRE CHAR(1) NULL)      ');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 22');
      end;
      if VpaNumAtualizacao < 23 then
      begin
        VpfErro := '23';
        ExecutaComandoSql(Aux,' CREATE TABLE PROCESSOPRODUCAO ( ' +
                              '  CODPROCESSOPRODUCAO NUMBER(10,0) NOT NULL, ' +
                              '  DESPROCESSOPRODUCAO VARCHAR2(80) NULL,  ' +
                              '  CODESTAGIO NUMBER(10,0) NULL REFERENCES ESTAGIOPRODUCAO(CODEST), ' +
                              '  QTDPRODUCAOHORA NUMBER(11,4) NULL, ' +
                              '  INDCONFIGURACAO CHAR(1) NULL, ' +
                              '  DESTEMPOCONFIGURACAO VARCHAR2(7) NULL,' +
                              '  PRIMARY KEY (CODPROCESSOPRODUCAO))');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 23');
      end;
      if VpaNumAtualizacao < 24 then
      begin
        VpfErro := '24';
        ExecutaComandoSql(Aux,' CREATE TABLE AMOSTRAPRODUTO ( ' +
                              '  CODAMOSTRA NUMBER(10) NOT NULL, ' +
                              '  SEQAMOSTRAPRODUTO NUMBER(10) NOT NULL, ' +
                              '  CODESTAGIO NUMBER(10), ' +
                              '  CODPROCESSOPRODUCAO NUMBER(10), ' +
                              '  QTDPRODUCAOHORA NUMBER(11,4), ' +
                              '  INDCONFIGURACAO CHAR(1), ' +
                              '  DESTEMPOCONFIGURACAO VARCHAR2(7), ' +
                              ' PRIMARY KEY (CODAMOSTRA, SEQAMOSTRAPRODUTO), ' +
                              ' FOREIGN KEY (CODAMOSTRA) REFERENCES AMOSTRA (CODAMOSTRA), ' +
                              ' FOREIGN KEY (CODESTAGIO) REFERENCES ESTAGIOPRODUCAO (CODEST) ) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 24');
      end;
      if VpaNumAtualizacao < 25 then
      begin
        VpfErro := '25';
        ExecutaComandoSql(Aux,' ALTER TABLE CADPRODUTOS MODIFY L_DES_FUN VARCHAR2(2000)');
        ExecutaComandoSql(Aux,' ALTER TABLE CADPRODUTOS MODIFY L_INF_DIS VARCHAR2(2000)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 25');
      end;
      if VpaNumAtualizacao < 26 then
      begin
        VpfErro := '26';
        ExecutaComandoSql(Aux,' CREATE TABLE APLICACAO (' +
                              '   CODAPLICACAO NUMBER(10,0), ' +
                              '   NOMAPLICACAO VARCHAR2(60), ' +
                              '  PRIMARY KEY(CODAPLICACAO)  ' +
                              ' )');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 26');
      end;
      if VpaNumAtualizacao < 27 then
      begin
        VpfErro := '27';
        ExecutaComandoSql(Aux,' CREATE TABLE PROPOSTAPRODUTOCLIENTE (' +
                              '   CODFILIAL NUMBER(10,0) NOT NULL, ' +
                              '   SEQPROPOSTA NUMBER(10,0) NOT NULL, ' +
                              '   SEQITEM NUMBER(10,0) NOT NULL,' +
                              '   SEQPRODUTO NUMBER(10,0), ' +
                              '   CODEMBALAGEM NUMBER(10,0), ' +
                              '   CODAPLICACAO NUMBER(10,0), ' +
                              '   DESPRODUCAO VARCHAR2(50), ' +
                              '   DESSENTIDOPASSAGEM VARCHAR2(50), ' +
                              '   DESDIAMETROTUBO VARCHAR2(50), ' +
                              '   FOREIGN KEY(SEQPRODUTO) REFERENCES CADPRODUTOS(I_SEQ_PRO), ' +
                              '   FOREIGN KEY(CODEMBALAGEM) REFERENCES EMBALAGEM(COD_EMBALAGEM), ' +
                              '   FOREIGN KEY(CODAPLICACAO) REFERENCES APLICACAO(CODAPLICACAO), ' +
                              '  PRIMARY KEY(CODFILIAL, SEQPROPOSTA, SEQITEM))');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 27');
      end;
      if VpaNumAtualizacao < 28 then
      begin
        VpfErro := '28';
        ExecutaComandoSql(Aux,' ALTER TABLE PROPOSTAPRODUTOCLIENTE ADD DESOBSERVACAO VARCHAR2(100)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 28');
      end;
      if VpaNumAtualizacao < 29 then
      begin
        VpfErro := '29';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTA ADD TIPHORASINSTALACAO NUMBER(10)');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 29');
      end;
      if VpaNumAtualizacao < 30 then
      begin
        VpfErro := '30';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_AOC CHAR(1) NULL');

        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 30');
      end;
      if VpaNumAtualizacao < 31 then
      begin
        VpfErro := '31';
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_AOC = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 31');
      end;
      if VpaNumAtualizacao < 32 then
      begin
        VpfErro := '32';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_EST_IMPC NUMBER(10)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 32');
      end;
      if VpaNumAtualizacao < 33 then
      begin
        VpfErro := '33';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_POL_CTOT VARCHAR(1)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 33');
      end;
      if VpaNumAtualizacao < 34 then
      begin
        VpfErro := '34';
        ExecutaComandoSql(Aux,'ALTER TABLE RETORNOITEM MODIFY (DESDUPLICATA varchar2(20))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 34');
      end;
      if VpaNumAtualizacao < 35 then
      begin
        VpfErro := '35';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD (CODSOLVEND NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 35');
      end;
      if VpaNumAtualizacao < 36 then
      begin
        VpfErro := '36';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA MODIFY (CODSOLVEND varchar2(20))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 36');
      end;
      if VpaNumAtualizacao < 37 then
      begin
        VpfErro := '37';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_MEN_BOL CHAR(1))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 37');
      end;
      if VpaNumAtualizacao < 38 then
      begin
        VpfErro := '38';
        ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_MEN_BOL= ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 38');
      end;
      if VpaNumAtualizacao < 39 then
      begin
        VpfErro := '39';
        ExecutaComandoSql(Aux,'CREATE TABLE PERFILCLIENTE (CODPERFIL INTEGER NOT NULL PRIMARY KEY, NOMPERFIL VARCHAR2(50))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 39');
      end;
      if VpaNumAtualizacao < 40 then
      begin
        VpfErro := '40';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_GRU_ADM CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_GRU_ADM = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 40');
      end;
      if VpaNumAtualizacao < 41 then
      begin
        VpfErro := '41';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_QTD_SOL CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_QTD_SOL = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 41');
      end;
      if VpaNumAtualizacao < 42 then
      begin
        VpfErro := '42';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (D_DAT_CER DATE)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 42');
      end;
      if VpaNumAtualizacao < 43 then
      begin
        VpfErro := '43';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ADD (I_COD_USU INTEGER)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 43');
      end;
      if VpaNumAtualizacao < 44 then
      begin
        VpfErro := '44';
        ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAISFOR SET I_COD_USU = 1');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 44');
      end;
      if VpaNumAtualizacao < 45 then
      begin
        VpfErro := '45';
        ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES ADD (C_IND_NFE CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CADVENDEDORES SET C_IND_NFE = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 45');
      end;
      if VpaNumAtualizacao < 46 then
      begin
        VpfErro := '46';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (I_EST_COP NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 46');
      end;
      if VpaNumAtualizacao < 47 then
      begin
        VpfErro := '47';
        ExecutaComandoSql(Aux,'CREATE TABLE PRODUTOLOG( ' +
                              ' SEQPRODUTO NUMBER(10) NOT NULL, ' +
                              ' SEQLOG NUMBER(10) NOT NULL, ' +
                              ' DATLOG DATE, ' +
                              ' CODUSUARIO NUMBER(10),' +
                              ' DESCAMINHOLOG VARCHAR2(200),' +
                              ' PRIMARY KEY(SEQPRODUTO, SEQLOG))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 47');
      end;
      if VpaNumAtualizacao < 48 then
      begin
        VpfErro := '48';
        ExecutaComandoSql(Aux,'CREATE TABLE TABELAPERCOMISSAO( ' +
                              ' CODACRESDESC NUMBER(10) NOT NULL, ' +
                              ' PERCOMISSAO NUMBER(10),' +
                              ' PERDESCONTO NUMBER(10),' +
                              ' INDACRESDESC CHAR(1))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 48');
      end;
      if VpaNumAtualizacao < 49 then
      begin
        VpfErro := '49';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD (I_PER_CLI NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 49');
      end;
      if VpaNumAtualizacao < 50 then
      begin
        VpfErro := '50';
        ExecutaComandoSql(Aux,'CREATE TABLE CONSUMOPRODUTOLOG( ' +
                              ' SEQPRODUTO NUMBER(10) NOT NULL, ' +
                              ' SEQLOG NUMBER(10) NOT NULL, ' +
                              ' DATLOG DATE, ' +
                              ' CODUSUARIO NUMBER(10),' +
                              ' DESCAMINHOLOG VARCHAR2(200),' +
                              ' PRIMARY KEY(SEQPRODUTO, SEQLOG))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 50');
      end;
      if VpaNumAtualizacao < 51 then
      begin
        VpfErro := '51';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD (DESSOLVENDEDOR varchar2(20))');
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA DROP COLUMN CODSOLVEND');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 51');
      end;
       if VpaNumAtualizacao < 52 then
      begin
        VpfErro := '52';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_POL_CROM varchar2(1))');
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_POL_VROM VARCHAR2(1))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 52');
      end;
       if VpaNumAtualizacao < 53 then
      begin
        VpfErro := '53';
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_CROM  = ''F''');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_VROM  = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 53');
      end;
      if VpaNumAtualizacao < 54 then
      begin
        VpfErro := '54';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD (C_IND_EMB varchar(1))');
        ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_IND_EMB  = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 54');
      end;
       if VpaNumAtualizacao < 55 then
      begin
        VpfErro := '55';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_PCO_ARQ varchar(1))');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_PCO_ARQ  = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 55');
      end;
      if VpaNumAtualizacao < 56 then
      begin
        VpfErro := '56';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_PCO_DIR varchar2(200))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 56');
      end;
      if VpaNumAtualizacao < 57 then
      begin
        VpfErro := '57';
        ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAITEM ADD (DESARQUIVOPROJETO varchar2(250))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 57');
      end;
      if VpaNumAtualizacao < 58 then
      begin
        VpfErro := '58';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (I_TIP_EMB INTEGER)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 58');
      end;
      if VpaNumAtualizacao < 59 then
      begin
        VpfErro := '59';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (I_PLA_EMB NUMBER(10), ' +
        ' I_PLS_EMB NUMBER(10), I_FER_EMB NUMBER(10), I_LAR_EMB NUMBER(10), I_ALT_EMB NUMBER(10), ' +
        ' I_FUN_EMB NUMBER(10), I_ABA_EMB NUMBER(10), I_DIA_EMB NUMBER(10), I_PEN_EMB NUMBER(10), ' +
        ' I_LAM_ZIP NUMBER(10), I_LAM_ABA NUMBER(10), I_FOT_NRO NUMBER(10), I_TAM_ZIP NUMBER(10), ' +
        ' I_COR_ZIP NUMBER(10), I_ALC_EMB NUMBER(10), I_IMP_EMB NUMBER(10), I_CBD_EMB NUMBER(10), ' +
        ' I_SIM_CAB NUMBER(10), I_BOT_EMB NUMBER(10), I_COR_BOT NUMBER(10), I_BOL_EMB NUMBER(10), ' +
        ' I_ZPE_EMB NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 59');
      end;
      if VpaNumAtualizacao < 60 then
      begin
        VpfErro := '60';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (C_LOC_ALC VARCHAR(70), C_OBS_COR VARCHAR(70), C_INT_EMB VARCHAR(10), ' +
        ' C_INU_EMB VARCHAR(10), C_COR_IMP VARCHAR(40), C_OBS_BOT VARCHAR(70), C_ADI_EMB VARCHAR(70),' +
        ' C_PRE_FAC VARCHAR(15), C_PRC_EMB VARCHAR(15), C_COR_SIM CHAR(1), C_COR_NAO CHAR(1), ' +
        ' C_BOL_SIM CHAR(1), C_BOL_NAO CHAR(1), C_ITN_EMB CHAR(1), C_EXT_EMB CHAR(1))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 60');
      end;
      if VpaNumAtualizacao < 61 then
      begin
        VpfErro := '61';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (I_COD_VIE INTEGER)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 61');
      end;
      if VpaNumAtualizacao < 62 then
      begin
        VpfErro := '62';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_CAR_IEV CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CAR_IEV  = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 62');
      end;
      if VpaNumAtualizacao < 63 then
      begin
        VpfErro := '63';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (I_ETI_VOL INTEGER)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 63');
      end;
      if VpaNumAtualizacao < 64 then
      begin
        VpfErro := '64';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS DROP (C_COR_SIM, C_COR_NAO, C_BOL_SIM, C_BOL_NAO, C_ITN_EMB, C_EXT_EMB)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 64');
      end;
      if VpaNumAtualizacao < 65 then
      begin
        VpfErro := '65';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (C_IND_CRT CHAR(1), C_IND_BOL CHAR(1), C_IND_IEX CHAR(1))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 65');
      end;
      if VpaNumAtualizacao < 66 then
      begin
        VpfErro := '66';
        ExecutaComandoSql(Aux, 'CREATE TABLE ORCAMENTOROTEIROENTREGA( ' +
                               ' SEQORCAMENTOROTEIRO NUMBER(10) NOT NULL, ' +
                               ' CODENTREGADOR NUMBER(10) NOT NULL, ' +
                               ' DATABERTURA DATE, '+
                               ' DATFECHAMENTO DATE,' +
                               ' PRIMARY KEY(SEQORCAMENTOROTEIRO))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 66');
      end;
      if VpaNumAtualizacao < 67 then
      begin
        VpfErro := '67';
        ExecutaComandoSql(Aux, 'CREATE TABLE ORCAMENTOROTEIROENTREGAITEM( ' +
                               ' SEQORCAMENTOROTEIRO NUMBER(10) NOT NULL, ' +
                               ' SEQORCAMENTO NUMBER(10) NOT NULL, ' +
                               ' CODFILIALORCAMENTO NUMBER(10) NOT NULL, ' +
                               ' PRIMARY KEY(SEQORCAMENTO,CODFILIALORCAMENTO),' +
                               ' FOREIGN KEY(SEQORCAMENTOROTEIRO) REFERENCES ORCAMENTOROTEIROENTREGA(SEQORCAMENTOROTEIRO))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 67');
      end;
      if VpaNumAtualizacao < 68 then
      begin
        VpfErro := '68';
        ExecutaComandoSql(Aux, 'DROP TABLE ORCAMENTOROTEIROENTREGAITEM');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 68');
      end;
      if VpaNumAtualizacao < 69 then
      begin
        VpfErro := '69';
        ExecutaComandoSql(Aux, 'CREATE TABLE ORCAMENTOROTEIROENTREGAITEM( ' +
                               ' SEQORCAMENTOROTEIRO NUMBER(10) NOT NULL, ' +
                               ' SEQORCAMENTO NUMBER(10) NOT NULL, ' +
                               ' CODFILIALORCAMENTO NUMBER(10) NOT NULL, ' +
                               ' PRIMARY KEY(SEQORCAMENTOROTEIRO,SEQORCAMENTO,CODFILIALORCAMENTO),' +
                               ' FOREIGN KEY(SEQORCAMENTOROTEIRO) REFERENCES ORCAMENTOROTEIROENTREGA(SEQORCAMENTOROTEIRO),'+
                               ' FOREIGN KEY(SEQORCAMENTO, CODFILIALORCAMENTO) REFERENCES CADORCAMENTOS(I_LAN_ORC,I_EMP_FIL))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 69');
      end;
      if VpaNumAtualizacao < 70 then
      begin
        VpfErro := '70';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS DROP (C_PRE_FAC,C_PRC_EMB)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 70');
      end;
      if VpaNumAtualizacao < 71 then
      begin
        VpfErro := '71';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (I_PRE_FAC NUMBER(10), I_PRC_EMB NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 71');
      end;
      if VpaNumAtualizacao < 72 then
      begin
        VpfErro := '72';
        ExecutaComandoSql(Aux,'ALTER TABLE CHAMADOPRODUTO ADD (VALBACKUP NUMBER(15,3))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 72');
      end;
      if VpaNumAtualizacao < 73 then
      begin
        VpfErro := '73';
        ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES ADD (C_DES_MSN VARCHAR(50))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 73');
      end;
      if VpaNumAtualizacao < 74 then
      begin
        VpfErro := '74';
        ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES ADD (I_COD_PRF NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 74');
      end;
      if VpaNumAtualizacao < 75 then
      begin
        VpfErro := '75';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTO ADD (SEQITEMCHAMADO NUMBER(10), SEQPRODUTOCHAMADO NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 75');
      end;
      if VpaNumAtualizacao < 76 then
      begin
        VpfErro := '76';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTASERVICO ADD (SEQITEMCHAMADO NUMBER(10), SEQPRODUTOCHAMADO NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 76');
      end;
      if VpaNumAtualizacao < 77 then
      begin
        VpfErro := '77';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (C_LOC_IMP VARCHAR(50))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 77');
      end;
      if VpaNumAtualizacao < 78 then
      begin
        VpfErro := '78';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS DROP (I_FOT_NRO, I_LAM_ZIP, I_LAM_ABA)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 78');
      end;
      if VpaNumAtualizacao < 79 then
      begin
        VpfErro := '79';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (C_FOT_NRO VARCHAR(15), C_LAM_ZIP VARCHAR(15), C_LAM_ABA VARCHAR(15))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 79');
      end;
      if VpaNumAtualizacao < 80 then
      begin
        VpfErro := '80';
        ExecutaComandoSql(Aux,'ALTER TABLE FACA ADD (ABAFACA NUMBER(9,3), FUNFACA NUMBER(9,3), TOTFACA NUMBER(9,3), PENFACA NUMBER(9,3))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 80');
      end;
      if VpaNumAtualizacao < 81 then
      begin
        VpfErro := '81';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTOROTULADO ADD (OBSPRODUTO VARCHAR2(500))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 81');
      end;
      if VpaNumAtualizacao < 82 then
      begin
        VpfErro := '82';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTOROTULADO ADD (DESPROROTULADO VARCHAR2(1000))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 82');
      end;
      if VpaNumAtualizacao < 83 then
      begin
        VpfErro := '83';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD (C_TIP_FO1 VARCHAR2(10), C_TIP_FO2 VARCHAR2(10), C_TIP_FO3 VARCHAR2(10) )');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 83');
      end;
      if VpaNumAtualizacao < 84 then
      begin
        VpfErro := '84';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_END_COT VARCHAR2(60) )');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 84');
      end;
      if VpaNumAtualizacao < 85 then
      begin
        VpfErro := '85';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD (N_QTD_TPR NUMBER(17,3) )');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 85');
      end;
      if VpaNumAtualizacao < 86 then
      begin
        VpfErro := '86';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTA ADD (DESTEMPOGARANTIA VARCHAR2(10) )');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 86');
      end;
      if VpaNumAtualizacao < 87 then
      begin
        VpfErro := '87';
        ExecutaComandoSql(Aux,'CREATE TABLE OBSPROPOSTACOMERCIAL (CODOBSPROPOSTA NUMBER(10), OBSINSTALACAO VARCHAR2(1000))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 87');
      end;
      if VpaNumAtualizacao < 88 then
      begin
        VpfErro := '88';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (C_DES_COM VARCHAR2(50))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 88');
      end;
      if VpaNumAtualizacao < 89 then
      begin
        VpfErro := '89';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTA ADD (CODOBSINSTALACAO NUMBER(10) )');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 89');
      end;
      if VpaNumAtualizacao < 90 then
      begin
        VpfErro := '90';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (C_INF_TEC VARCHAR2(1000))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 90');
      end;
      if VpaNumAtualizacao < 91 then
      begin
        VpfErro := '91';
        ExecutaComandoSql(Aux, 'DROP TABLE OBSPROPOSTACOMERCIAL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 91');
      end;
      if VpaNumAtualizacao < 92 then
      begin
        VpfErro := '92';
        ExecutaComandoSql(Aux,'CREATE TABLE OBSERVACAOINSTALACAOPROPOSTA( ' +
                              ' CODOBSINSTALACAOPROPOSTA NUMBER(10) NOT NULL, ' +
                              ' NOMOBSINSTALACAOPROPOSTA VARCHAR(40), '+
                              ' DESOBSINSTALACAOPROPOSTA VARCHAR2(1000),' +
                              ' PRIMARY KEY (CODOBSINSTALACAOPROPOSTA))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 92');
      end;
      if VpaNumAtualizacao < 93 then
      begin
        VpfErro := '93';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS DROP(I_LAR_EMB,I_ALT_EMB, ' +
                              ' I_FUN_EMB, I_ABA_EMB, I_DIA_EMB, I_PEN_EMB)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 93');
      end;
      if VpaNumAtualizacao < 94 then
      begin
        VpfErro := '94';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD(C_LAR_EMB VARCHAR2(15),C_ALT_EMB VARCHAR2(15), ' +
                              ' C_FUN_EMB VARCHAR2(15), C_ABA_EMB VARCHAR2(15), ' +
                              ' C_DIA_EMB VARCHAR2(15), C_PEN_EMB VARCHAR2(15))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 94');
      end;
      if VpaNumAtualizacao < 95 then
      begin
        VpfErro := '95';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD (C_LOC_INT VARCHAR(50))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 95');
      end;
      if VpaNumAtualizacao < 96 then
      begin
        VpfErro := '96';
        ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD (C_COT_MES CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CADEMPRESAS SET C_COT_MES = ''S''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 96');
      end;
      if VpaNumAtualizacao < 97 then
      begin
        VpfErro := '97';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_DIR_PRO VARCHAR2(240))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 97');
      end;
      if VpaNumAtualizacao < 98 then
      begin
        VpfErro := '98';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (I_EST_CAN NUMBER(10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 98');
      end;
      if VpaNumAtualizacao < 99 then
      begin
        VpfErro := '99';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_CRM_INS CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_INS = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 99');
      end;
      if VpaNumAtualizacao < 100 then
      begin
        VpfErro := '100';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTA ADD (DESOBSERVACAOINSTALACAO VARCHAR2(3000))  ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 100');
      end;
      if VpaNumAtualizacao < 101 then
      begin
        VpfErro := '101';
        ExecutaComandoSql(Aux,' ALTER TABLE CHAMADOCORPO ADD (DESOBSERVACAOGERAL VARCHAR2(3000))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 101');
      end;
      if VpaNumAtualizacao < 102 then
      begin
        VpfErro := '102';
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAPRODUTO ADD (DESOBSERVACAO VARCHAR2(200))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 102');
      end;
      if VpaNumAtualizacao < 103 then
      begin
        VpfErro := '103';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (I_EST_CCA NUMBER (10))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 103');
      end;
      if VpaNumAtualizacao < 104 then
      begin
        VpfErro := '104';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD (C_DIR_PRT VARCHAR2(240))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 104');
      end;
      if VpaNumAtualizacao < 105 then
      begin
        VpfErro := '105';
        ExecutaComandoSql(Aux,'CREATE TABLE PRODUTOCLIENTEPECA( ' +
                              ' CODPRODUTOCLIENTEPECA NUMBER(10) NOT NULL, ' +
                              ' SEQPRODUTOSELECIONADO NUMBER(10), ' +
                              ' SEQPRODUTO  NUMBER(10), '+
                              ' CODPRODUTO VARCHAR2(50),' +
                              ' NOMPRODUTO VARCHAR2(100), ' +
                              ' DESNUMSERIE VARCHAR2(30), ' +
                              ' DATINSTALACAO DATE, ' +
                              ' PRIMARY KEY (CODPRODUTOCLIENTEPECA, SEQPRODUTOSELECIONADO, SEQPRODUTO))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 105');
      end;
      if VpaNumAtualizacao < 106 then
      begin
        VpfErro := '106';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_PRODUTO ADD(C_CLA_MPA VARCHAR2(15))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 106');
      end;
      if VpaNumAtualizacao < 107 then
      begin
        VpfErro := '107';
        ExecutaComandoSql(Aux,' ALTER TABLE SETOR ADD(INDIMPRESSAOOPCAO CHAR(1)) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 107');
      end;
      if VpaNumAtualizacao < 108 then
      begin
        VpfErro := '108';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_ORC_NPE CHAR(1)) ');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORC_NPE = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 108');
      end;
      if VpaNumAtualizacao < 109 then
      begin
        VpfErro := '109';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_LOG_PSC CHAR(1)) ');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_LOG_PSC = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 109');
      end;
      if VpaNumAtualizacao < 110 then
      begin
        VpfErro := '110';
        ExecutaComandoSql(Aux,' CREATE TABLE PLANOCONTAORCADO(  ' +
                              ' CODEMPRESA NUMBER(10) NOT NULL, '+
                              ' CODPLANOCONTA VARCHAR2(20) NOT NULL,' +
                              ' ANOORCADO NUMBER(10) NOT NULL, ' +
                              ' VALJANEIRO NUMBER(15,3), ' +
                              ' VALFEVEREIRO NUMBER(15,3), ' +
                              ' VALMARCO NUMBER(15,3), ' +
                              ' VALABRIL NUMBER(15,3), ' +
                              ' VALMAIO NUMBER(15,3), ' +
                              ' VALJUNHO NUMBER(15,3), ' +
                              ' VALJULHO NUMBER(15,3), ' +
                              ' VALAGOSTO NUMBER(15,3), ' +
                              ' VALSETEMBRO NUMBER(15,3), ' +
                              ' VALOUTUBRO NUMBER(15,3), ' +
                              ' VALNOVEMBRO NUMBER(15,3), ' +
                              ' VALDEZEMBRO NUMBER(15,3), ' +
                              ' PRIMARY KEY (CODEMPRESA, CODPLANOCONTA, ANOORCADO))');
        ExecutaComandoSql(Aux,'ALTER TABLE PLANOCONTAORCADO add CONSTRAINT PLANOCONTAORCADO_PLANO '+
                              ' FOREIGN KEY (CODEMPRESA,CODPLANOCONTA) '+
                              '  REFERENCES CAD_PLANO_CONTA (I_COD_EMP,C_CLA_PLA) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 110');
      end;
      if VpaNumAtualizacao < 111 then
      begin
        VpfErro := '111';
        ExecutaComandoSql(Aux,' ALTER TABLE CADEMPRESAS ADD (C_TMK_ORD CHAR(1))');
        ExecutaComandoSql(Aux,'UPDATE CADEMPRESAS SET C_TMK_ORD = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 111');
      end;
      if VpaNumAtualizacao < 112 then
      begin
        VpfErro := '112';
        ExecutaComandoSql(Aux,' ALTER TABLE PEDIDOCOMPRAITEM ADD (VALIPI NUMBER(15,4))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 112');
      end;
     if VpaNumAtualizacao < 113 then
     begin
       VpfErro := '113';
       ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR ADD (N_VLR_MVA NUMBER(17,2), N_VLR_BST NUMBER(17,2), ' +
                             ' N_VLR_TST NUMBER(17,2), N_PER_ACU NUMBER(8,3))  ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 113');
     end;
     if VpaNumAtualizacao < 114 then
     begin
       VpfErro := '114';
       ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_ROM_ABE CHAR(1))  ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 114');
     end;
     if VpaNumAtualizacao < 115 then
     begin
       VpfErro := '115';
       ExecutaComandoSql(Aux,' ALTER TABLE PLANOCONTAORCADO ADD(VALTOTAL NUMBER (15,3))   ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 115');
     end;
     if VpaNumAtualizacao < 116 then
     begin
       VpfErro := '116';
       ExecutaComandoSql(Aux,' ALTER TABLE CADPRODUTOS MODIFY I_PRE_FAC NUMBER(15,3)');
       ExecutaComandoSql(Aux,' ALTER TABLE CADPRODUTOS MODIFY I_PRC_EMB NUMBER(15,3)');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 116');
     end;
     if VpaNumAtualizacao < 117 then
     begin
       VpfErro := '117';
       ExecutaComandoSql(Aux,' ALTER TABLE CHEQUE ADD (DATEMISSAO DATE) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 117');
     end;
     if VpaNumAtualizacao < 118 then
     begin
       VpfErro := '118';
       ExecutaComandoSql(Aux,' ALTER TABLE ORCAMENTOROTEIROENTREGAITEM ADD (DATFECHAMENTO DATE) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 118');
     end;
     if VpaNumAtualizacao < 119 then
     begin
       VpfErro := '119';
       ExecutaComandoSql(Aux,' ALTER TABLE CADPRODUTOS ADD (N_PER_ICM NUMBER(8,3))');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 119');
     end;
     if VpaNumAtualizacao < 120 then
     begin
       VpfErro := '120';
       ExecutaComandoSql(Aux,'CREATE TABLE CHAMADOPRODUTOAPRODUZIR( ' +
                             ' CODFILIAL NUMBER(10,0) NOT NULL, ' +
                             ' NUMCHAMADO NUMBER(10,0) NOT NULL, ' +
                             ' SEQITEM NUMBER(10,0) NOT NULL, '+
                             ' SEQITEMORCADO NUMBER(10,0) NOT NULL, ' +
                             ' SEQPRODUTO NUMBER(10,0), ' +
                             ' QTDPRODUTO NUMBER(15,4), '+
                             ' VALUNITARIO NUMBER(15,4), ' +
                             ' VALTOTAL NUMBER(15,5), ' +
                             ' DESUM VARCHAR2(2),' +
                             ' PRIMARY KEY (CODFILIAL, NUMCHAMADO, SEQITEM, SEQITEMORCADO))');
        ExecutaComandoSql(Aux,'ALTER TABLE CHAMADOPRODUTOAPRODUZIR add CONSTRAINT CHAMADOPRODUTOAPRODUZIR '+
                              ' FOREIGN KEY (CODFILIAL,NUMCHAMADO) '+
                              '  REFERENCES CHAMADOCORPO (CODFILIAL,NUMCHAMADO) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 120');
     end;
     if VpaNumAtualizacao < 121 then
     begin
       VpfErro := '121';
       ExecutaComandoSql(Aux,'ALTER TABLE ESTAGIOPRODUCAO ADD (INDEMAIL CHAR(1)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 121');
     end;
     if VpaNumAtualizacao < 122 then
     begin
       VpfErro := '122';
       ExecutaComandoSql(Aux,' ALTER TABLE CHAMADOPRODUTOAPRODUZIR ADD(DATENTREGA DATE) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 122');
     end;
     if VpaNumAtualizacao < 123 then
     begin
       VpfErro := '123';
       ExecutaComandoSql(Aux,' ALTER TABLE PROPOSTAPRODUTO ADD(PERIPI NUMBER(5,3), VALIPI NUMBER(15,4))');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 123');
     end;
     if VpaNumAtualizacao < 124 then
     begin
       VpfErro := '124';
       ExecutaComandoSql(Aux,'CREATE TABLE MOVSERVICONOTAFOR( ' +
                             ' I_EMP_FIL NUMBER(10,0) NOT NULL, ' +
                             ' I_SEQ_NOT NUMBER(10,0) NOT NULL, ' +
                             ' I_SEQ_MOV NUMBER(10,0) NOT NULL, ' +
                             ' I_COD_SER NUMBER(10,0) NOT NULL, ' +
                             ' N_VLR_SER NUMBER(17,3), ' +
                             ' I_COD_EMP NUMBER(10,0), ' +
                             ' N_QTD_SER NUMBER(17,3), ' +
                             ' N_TOT_SER NUMBER(17,3), ' +
                             ' D_ULT_ALT DATE, ' +
                             ' C_DES_ADI VARCHAR2(70), ' +
                             ' C_NOM_SER VARCHAR2(250), ' +
                             ' PRIMARY KEY (I_EMP_FIL, I_SEQ_NOT, I_SEQ_MOV))');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVSERVICONOTAFOR add CONSTRAINT MOVSERVICONOTAFOR '+
                              ' FOREIGN KEY (I_EMP_FIL,I_SEQ_NOT) '+
                              '  REFERENCES CADNOTAFISCAISFOR (I_EMP_FIL,I_SEQ_NOT) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 124');
     end;
     if VpaNumAtualizacao < 125 then
     begin
       VpfErro := '125';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_NOE_SPR CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_NOE_SPR = ''N''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 125');
     end;
     if VpaNumAtualizacao < 126 then
     begin
       VpfErro := '126';
       ExecutaComandoSql(Aux,' ALTER TABLE PROPOSTA ADD (VALTOTALPRODUTOS NUMBER(15,3), VALTOTALIPI NUMBER(15,3))  ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 126');
     end;
     if VpaNumAtualizacao < 127 then
     begin
       VpfErro := '127';
       ExecutaComandoSql(Aux,' ALTER TABLE CADNOTAFISCAISFOR ADD (N_TOT_SER NUMBER(17,2)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 127');
     end;
     if VpaNumAtualizacao < 128 then
     begin
       VpfErro := '128';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD (C_CRM_DET CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_DET = ''N''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 128');
     end;
     if VpaNumAtualizacao < 129 then
     begin
       VpfErro := '129';
       ExecutaComandoSql(Aux,'CREATE TABLE PROPOSTACONDICAOPAGAMENTO( ' +
                             ' CODFILIAL NUMBER(10,0) NOT NULL, ' +
                             ' SEQPROPOSTA NUMBER(10,0) NOT NULL, ' +
                             ' CODCONDICAO NUMBER(10,0) NOT NULL, ' +
                             ' NOMCONDICAO VARCHAR2(50), ' +
                             ' INDAPROVADO CHAR(1), ' +
                             ' PRIMARY KEY (CODFILIAL, SEQPROPOSTA, CODCONDICAO))');
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTACONDICAOPAGAMENTO add CONSTRAINT PROPOSTACONDICAOPAGAMENTO '+
                              ' FOREIGN KEY (CODFILIAL,SEQPROPOSTA) '+
                              '  REFERENCES PROPOSTA (CODFILIAL,SEQPROPOSTA) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 129');
     end;
     if VpaNumAtualizacao < 130 then
     begin
       VpfErro := '130';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD (C_CRM_OBP VARCHAR2(4000)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 130');
     end;
     if VpaNumAtualizacao < 131 then
     begin
       VpfErro := '131';
       ExecutaComandoSql(Aux,'CREATE TABLE PROPOSTAMATERIALACABAMENTO( ' +
                             ' CODFILIAL NUMBER(10,0) NOT NULL, ' +
                             ' SEQPROPOSTA NUMBER(10,0) NOT NULL, ' +
                             ' SEQPRODUTO  NUMBER(10,0) NOT NULL, ' +
                             ' CODPRODUTO VARCHAR2(20), ' +
                             ' NOMPRODUTO VARCHAR2(80),' +
                             ' DESUM VARCHAR2(2),' +
                             ' QTDPRODUTO NUMBER(15,4),' +
                             ' VALUNITARIO NUMBER(15,4),' +
                             ' VALTOTAL NUMBER(15,4),' +
                             ' PRIMARY KEY (CODFILIAL, SEQPROPOSTA, SEQPRODUTO))');
        ExecutaComandoSql(Aux,'ALTER TABLE PROPOSTAMATERIALACABAMENTO add CONSTRAINT PROPOSTAMATERIALACABAMENTO '+
                              ' FOREIGN KEY (CODFILIAL,SEQPROPOSTA) '+
                              '  REFERENCES PROPOSTA (CODFILIAL,SEQPROPOSTA) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 131');
     end;
     if VpaNumAtualizacao < 132 then
     begin
       VpfErro := '132';
       ExecutaComandoSql(Aux,' ALTER TABLE CADGRUPOS ADD(C_CRM_EFC CHAR(1))  ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 132');
     end;
     if VpaNumAtualizacao < 133 then
     begin
       VpfErro := '133';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD (C_EST_PRC NUMBER(10))  ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 133');
     end;
     if VpaNumAtualizacao < 134 then
     begin
       VpfErro := '134';
       ExecutaComandoSql(Aux,' ALTER TABLE CADGRUPOS ADD (C_CHA_EFC char(1)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 134');
     end;
     if VpaNumAtualizacao < 135 then
     begin
       VpfErro := '135';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_FINANCEIRO ADD(C_CLI_BLO CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_CLI_BLO = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 135');
     end;
     if VpaNumAtualizacao < 136 then
     begin
       VpfErro := '136';
       ExecutaComandoSql(Aux,' ALTER TABLE CADGRUPOS ADD(C_CLI_INA CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_CLI_INA = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 136');
     end;
     if VpaNumAtualizacao < 137 then
     begin
       VpfErro := '137';
       ExecutaComandoSql(Aux,' ALTER TABLE CHAMADOPRODUTOORCADO ADD (DATPRODUCAO DATE) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 137');
     end;
     if VpaNumAtualizacao < 138 then
     begin
       VpfErro := '138';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD (C_CHA_SDP CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CHA_SDP = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 138');
     end;
     if VpaNumAtualizacao < 139 then
     begin
       VpfErro := '139';
       ExecutaComandoSql(Aux,' ALTER TABLE CHAMADOCORPO ADD (DESTIPOCHAMADO VARCHAR2(50)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 139');
     end;
     if VpaNumAtualizacao < 140 then
     begin
       VpfErro := '140';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_CRM_GAR VARCHAR2(10))');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 140');
     end;
     if VpaNumAtualizacao < 141 then
     begin
       VpfErro := '141';
       ExecutaComandoSql(Aux,' ALTER TABLE PRODUTOACESSORIO ADD(SEQITEM NUMBER(10)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 141');
     end;
     if VpaNumAtualizacao < 142 then
     begin
       VpfErro := '142';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_OBS_NOT CHAR(1))');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_OBS_NOT = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 142');
     end;
     if VpaNumAtualizacao < 143 then
     begin
       VpfErro := '143';
       ExecutaComandoSql(Aux,' ALTER TABLE CHEQUE ADD(NUMCONTA NUMBER(10), NUMAGENCIA NUMBER(10)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 143');
     end;
     if VpaNumAtualizacao < 144 then
     begin
       VpfErro := '144';
       ExecutaComandoSql(Aux,' ALTER TABLE TAREFATELEMARKETING ADD(INDSITUACAOCLIENTE CHAR(1)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 144');
     end;
     if VpaNumAtualizacao < 145 then
     begin
       VpfErro := '145';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_TAB_CLI CHAR(1))  ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_TAB_CLI = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 145');
     end;
     if VpaNumAtualizacao < 146 then
     begin
       VpfErro := '146';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_PRE_TAB CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_PRE_TAB = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 146');
     end;
     if VpaNumAtualizacao < 147 then
     begin
       VpfErro := '147';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_PEC_PDF CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_PEC_PDF = ''T''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 147');
     end;
     if VpaNumAtualizacao < 148 then
     begin
       VpfErro := '148';
       ExecutaComandoSql(Aux,'CREATE TABLE CONTRATOSERVICO( ' +
                             ' CODFILIAL NUMBER(10,0) NOT NULL, ' +
                             ' SEQCONTRATO NUMBER(10,0) NOT NULL, ' +
                             ' SEQITEM NUMBER(10,0) NOT NULL, ' +
                             ' CODSERVICO NUMBER(10,0) NOT NULL, ' +
                             ' VALSERVICO NUMBER(17,3), ' +
                             ' CODEMPRESA NUMBER(10,0), ' +
                             ' QTDSERVICO NUMBER(17,3), ' +
                             ' VALTOTSERVICO NUMBER(17,3), ' +
                             ' DATULTIMAALTERACAO DATE, ' +
                             ' DESADICIONAIS VARCHAR2(70), ' +
                             ' NOMSERVICO VARCHAR2(250), ' +
                             ' PRIMARY KEY (CODFILIAL, SEQCONTRATO, SEQITEM))');
        ExecutaComandoSql(Aux,'ALTER TABLE CONTRATOSERVICO add CONSTRAINT CONTRATOSERVICO '+
                              ' FOREIGN KEY (CODFILIAL,SEQCONTRATO) '+
                              '  REFERENCES CONTRATOCORPO (CODFILIAL,SEQCONTRATO) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 148');
     end;
     if VpaNumAtualizacao < 149 then
     begin
       VpfErro := '149';
       ExecutaComandoSql(Aux,' UPDATE CFG_GERAL SET C_ORC_NPE = ''F'' WHERE C_ORC_NPE = ''N''');
       ExecutaComandoSql(Aux,' UPDATE CFG_GERAL SET C_CRM_INS = ''F'' WHERE C_CRM_INS = ''N''');
       ExecutaComandoSql(Aux,' UPDATE CFG_GERAL SET C_LOG_PSC = ''F'' WHERE C_LOG_PSC = ''N''');
       ExecutaComandoSql(Aux,' UPDATE CFG_GERAL SET C_NOE_SPR = ''F'' WHERE C_NOE_SPR = ''N''');
       ExecutaComandoSql(Aux,' UPDATE CFG_GERAL SET C_CRM_DET = ''F'' WHERE C_CRM_DET = ''N''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 149');
     end;
     if VpaNumAtualizacao < 150 then
     begin
       VpfErro := '150';
       ExecutaComandoSql(Aux,' ALTER TABLE AMOSTRA ADD(INDPRECOESTIMADO CHAR(1)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 150');
     end;
     if VpaNumAtualizacao < 151 then
     begin
       VpfErro := '151';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_AMO_PEO CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_AMO_PEO = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 151');
     end;
     if VpaNumAtualizacao < 152 then
     begin
       VpfErro := '152';
       ExecutaComandoSql(Aux,' ALTER TABLE AMOSTRACOR ADD(VALPRECOESTIMADO NUMBER(15,4)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 152');
     end;
     if VpaNumAtualizacao < 153 then
     begin
       VpfErro := '153';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_AMO_PRV CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_AMO_PRV = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 153');
     end;
     if VpaNumAtualizacao < 154 then
     begin
       VpfErro := '154';
       ExecutaComandoSql(Aux,' CREATE TABLE MOTIVOATRASO( ' +
                             ' CODMOTIVOATRASO NUMBER(10,0) NOT NULL, ' +
                             ' DESMOTIVOATRASO VARCHAR2(80), ' +
                             ' PRIMARY KEY (CODMOTIVOATRASO))');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 154');
     end;
     if VpaNumAtualizacao < 155 then
     begin
       VpfErro := '155';
       ExecutaComandoSql(Aux,' CREATE TABLE AMOSTRACORMOTIVOATRASO( ' +
                             ' CODAMOSTRA NUMBER(10) NOT NULL, ' +
                             ' CODCOR NUMBER(10) NOT NULL, ' +
                             ' SEQITEM NUMBER(10) NOT NULL, ' +
                             ' CODMOTIVOATRASO NUMBER(10), ' +
                             ' DESOBSERVACAO VARCHAR2(80), ' +
                             ' PRIMARY KEY (CODAMOSTRA, CODCOR, SEQITEM))');
       ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACORMOTIVOATRASO add CONSTRAINT AMOSTRACORMOTIVOATRASO '+
                             ' FOREIGN KEY (CODAMOSTRA,CODCOR) '+
                             '  REFERENCES AMOSTRACOR (CODAMOSTRA,CODCOR) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 155');
     end;
     if VpaNumAtualizacao < 156 then
     begin
       VpfErro := '156';
       ExecutaComandoSql(Aux,' ALTER TABLE AMOSTRACORMOTIVOATRASO ADD CODUSUARIO NUMBER(10)NULL');
       ExecutaComandoSql(Aux,' CREATE INDEX AMOSTRACORMOTIVOATRASO_FK1 ON AMOSTRACORMOTIVOATRASO(CODMOTIVOATRASO)');
       ExecutaComandoSql(Aux,' CREATE INDEX AMOSTRACORMOTIVOATRASO_FK2 ON AMOSTRACORMOTIVOATRASO(CODUSUARIO)');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 156');
     end;
     if VpaNumAtualizacao < 157 then
     begin
       VpfErro := '157';
       ExecutaComandoSql(Aux,' ALTER TABLE MOVNOTASFISCAISFOR ADD(N_VLR_BIC NUMBER(8,3), N_VLR_ICM NUMBER(17,3)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 157');
     end;
     if VpaNumAtualizacao < 158 then
     begin
       VpfErro := '158';
       ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_COT_LMO CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_LMO = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 158');
     end;
     if VpaNumAtualizacao < 159 then
     begin
       VpfErro := '159';
       ExecutaComandoSql(Aux,' ALTER TABLE CADGRUPOS ADD(C_POL_NIC CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_NIC = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 159');
     end;
     if VpaNumAtualizacao < 160 then
     begin
       VpfErro := '160';
       ExecutaComandoSql(Aux,' ALTER TABLE CADGRUPOS ADD(C_POL_ROT CHAR(1)) ');
       ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_ROT = ''F''');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 160');
     end;
     if VpaNumAtualizacao < 161 then
     begin
       VpfErro := '161';
       ExecutaComandoSql(Aux,' ALTER TABLE ORCAMENTOROTEIROENTREGAITEM ADD(DATSAIDAENTREGA DATE) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 161');
     end;
     if VpaNumAtualizacao < 162 then
     begin
       VpfErro := '162';
       ExecutaComandoSql(Aux,' ALTER TABLE PROPOSTA ADD(DESOBSDATAINSTALACAO VARCHAR2(70)) ');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 162');
     end;
     if VpaNumAtualizacao < 163 then
     begin
       VpfErro := '163';
       ExecutaComandoSql(Aux,' ALTER TABLE ORCAMENTOROTEIROENTREGA ADD(DATBLOQUEIO DATE)');
       ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 163');
     end;
      VpfErro := AtualizaBanco1(VpaNumAtualizacao);

      VpfSemErros := true;
    except
      on E : Exception do
      begin
        Aux.sql.SaveToFile('comando.sql');
        Aux.Sql.text := E.message;
        Aux.Sql.SavetoFile('ErroInicio.txt');
        if Confirmacao(VpfErro + ' PRG1 - Existe uma alteração para ser feita no banco de dados mas existem usuários'+
                    ' utilizando o sistema, ou algum outro sistema sendo utilizado no seu computador, é necessário'+
                    ' que todos os usuários saiam do sistema, para'+
                    ' poder continuar. Deseja continuar agora?') then
        Begin
          VpfSemErros := false;
          AdicionaSQLAbreTabela(Aux,'Select I_Ult_PR1 from CFG_GERAL ');
          VpaNumAtualizacao := Aux.FieldByName('I_ULT_PR1').AsInteger;
        end
        else
          exit;
      end;
    end;
  until VpfSemErros;
end;

{******************************************************************************}
function TRBFunProgramador1.AtualizaBanco1(VpaNumAtualizacao: integer): string;
begin
  Result:= '';
  if VpaNumAtualizacao < 164 then
  begin
    Result := '164';
    ExecutaComandoSql(Aux,' DROP TABLE PRODUTOCLIENTEPECA ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 164');
  end;
  if VpaNumAtualizacao < 165 then
  begin
    Result := '165';
    ExecutaComandoSql(Aux,'CREATE TABLE PRODUTOCLIENTEPECA( ' +
                          ' SEQPRODUTOCLIENTE NUMBER(10) NOT NULL, ' +
                          ' CODCLIENTE  NUMBER(10) NOT NULL, '+
                          ' SEQITEMPRODUTOCLIENTE NUMBER(10) NOT NULL,' +
                          ' SEQITEMPECA NUMBER(10) NOT NULL, ' +
                          ' SEQPRODUTOPECA NUMBER(10) NOT NULL, ' +
                          ' DESNUMSERIE VARCHAR2(30), ' +
                          ' DATINSTALACAO DATE, ' +
                          ' PRIMARY KEY (SEQPRODUTOCLIENTE, CODCLIENTE, SEQITEMPRODUTOCLIENTE, SEQITEMPECA ))');
    ExecutaComandoSql(Aux,'ALTER TABLE PRODUTOCLIENTEPECA add CONSTRAINT PRODUTOCLIENTEPECA '+
                          ' FOREIGN KEY (SEQPRODUTOCLIENTE,CODCLIENTE,SEQITEMPRODUTOCLIENTE) '+
                          '  REFERENCES PRODUTOCLIENTE (SEQPRODUTO,CODCLIENTE,SEQITEM) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 165');
  end;
  if VpaNumAtualizacao < 166 then
  begin
    Result := '16';
    ExecutaComandoSql(Aux,' ALTER TABLE CADGRUPOS ADD(C_FAT_SPF CHAR(1))');
    ExecutaComandoSql(Aux,' update CADGRUPOS CADGRUPOS SET C_FAT_SPF = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 166');
  end;
  if VpaNumAtualizacao < 167 then
  begin
    Result := '167';
    ExecutaComandoSql(Aux,' ALTER TABLE AMOSTRAPROCESSO ADD(DESOBSERVACAO VARCHAR2(150)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 167');
  end;
  if VpaNumAtualizacao < 168 then
  begin
    Result := '168';
    ExecutaComandoSql(Aux,' ALTER TABLE CADORCAMENTOS ADD(C_ORD_COR VARCHAR2(20)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 168');
  end;
  if VpaNumAtualizacao < 169 then
  begin
    Result := '169';
    ExecutaComandoSql(Aux,' ALTER TABLE ROMANEIOORCAMENTOITEM ADD(DESORDEMCORTE VARCHAR2(20)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 169');
  end;
  if VpaNumAtualizacao < 170 then
  begin
    Result := '170';
    ExecutaComandoSql(Aux,' ALTER TABLE MOVORCAMENTOS ADD(C_ORD_COR VARCHAR2(20)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 170');
  end;
  if VpaNumAtualizacao < 171 then
  begin
    Result := '171';
    ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_CRM_VUC CHAR(1)) ');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_VUC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 171');
  end;
  if VpaNumAtualizacao < 172 then
  begin
    Result := '172';
    ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_CRM_PMP CHAR(1))');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CRM_PMP = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 172');
  end;
  if VpaNumAtualizacao < 173 then
  begin
    Result := '173';
    ExecutaComandoSql(Aux,' ALTER TABLE CADGRUPOS ADD(C_CRM_VDR CHAR(1))');
    ExecutaComandoSql(Aux,' update CADGRUPOS CADGRUPOS SET C_CRM_VDR = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 173');
  end;
  if VpaNumAtualizacao < 174 then
  begin
    Result := '174';
    ExecutaComandoSql(Aux,' ALTER TABLE RECIBOLOCACAOCORPO ADD(INDCANCELADO CHAR(1))');
    ExecutaComandoSql(Aux,' update RECIBOLOCACAOCORPO SET INDCANCELADO = ''N''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 174');
  end;
  if VpaNumAtualizacao < 175 then
  begin
    Result := '175';
    ExecutaComandoSql(Aux,' ALTER TABLE RECIBOLOCACAOCORPO ADD(DESMOTIVOCANCELAMENTO VARCHAR2(40), DATCANCELAMENTO DATE, CODUSUARIOCANCELAMENTO NUMBER(10)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 175');
  end;
  if VpaNumAtualizacao < 176 then
  begin
    Result := '176';
    ExecutaComandoSql(Aux,' ALTER TABLE LEITURALOCACAOCORPO ADD(DESORDEMCOMPRA VARCHAR2(20))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 176');
  end;
  if VpaNumAtualizacao < 177 then
  begin
    Result := '177';
    ExecutaComandoSql(Aux,' ALTER TABLE RECIBOLOCACAOCORPO ADD(DESORDEMCOMPRA VARCHAR2(20))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 177');
  end;
  if VpaNumAtualizacao < 178 then
  begin
    Result := '178';
    ExecutaComandoSql(Aux,' ALTER TABLE RECIBOLOCACAOCORPO ADD(DESOBSERVACAOCOTACAO VARCHAR2(4000)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 178');
  end;
  if VpaNumAtualizacao < 179 then
  begin
    Result := '179';
    ExecutaComandoSql(Aux,'CREATE TABLE ALTERACLIENTEVENDEDOR (' +
                          ' SEQITEM NUMBER(10) NOT NULL, '+
                          ' CODUSUARIO NUMBER(10)NULL, ' +
                          ' DATALTERACAO DATE, ' +
                          ' CODVENDEDORORIGEM NUMBER(10) NULL, ' +
                          ' CODCLIENTEORIGEM NUMBER(10) NULL, '+
                          ' CODCIDADEORIGEM NUMBER(10) NULL, '+
                          ' CODVENDEDORDESTINO NUMBER(10) NULL, '+
                          ' QTDREGISTROSALTERADOS NUMBER(10) NULL, '+
                          ' PRIMARY KEY(SEQITEM))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 179');
  end;
  if VpaNumAtualizacao < 180 then
  begin
    Result := '180';
    ExecutaComandoSql(Aux,'CREATE TABLE ALTERACLIENTEVENDEDORITEM (' +
                          ' SEQITEMALTERACLIENTEVENDEDOR NUMBER(10) NOT NULL, '+
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' CODCLIENTE NUMBER(10) NULL, '+
                          ' PRIMARY KEY(SEQITEMALTERACLIENTEVENDEDOR,SEQITEM))');
    ExecutaComandoSql(Aux,'CREATE INDEX ALTERACLIENTEVENDEDORITEM_FK1 ON ALTERACLIENTEVENDEDORITEM(SEQITEMALTERACLIENTEVENDEDOR)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 180');
  end;
  if VpaNumAtualizacao < 181 then
  begin
    Result := '181';
    ExecutaComandoSql(Aux,' ALTER TABLE CFG_PRODUTO ADD(C_FIL_FAT CHAR(1))');
    ExecutaComandoSql(Aux,' update CFG_PRODUTO SET C_FIL_FAT = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 181');
  end;
  if VpaNumAtualizacao < 182 then
  begin
    Result := '182';
    ExecutaComandoSql(Aux,' ALTER TABLE CONHECIMENTOTRANSPORTE ADD(NUMCONHECIMENTO NUMBER(10))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 182');
  end;
  if VpaNumAtualizacao < 183 then
  begin
    Result := '183';
    ExecutaComandoSql(Aux,'CREATE TABLE PRODUTOFILIALFATURAMENTO( ' +
                              ' SEQPRODUTO NUMBER(10) NOT NULL REFERENCES CADPRODUTOS(I_SEQ_PRO), ' +
                              ' CODFILIAL NUMBER(10) NOT NULL, ' +
                              ' SEQITEM NUMBER(10) NOT NULL, ' +
                              ' PRIMARY KEY(SEQPRODUTO,CODFILIAL, SEQITEM))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 183');
  end;
  if VpaNumAtualizacao < 184 then
  begin
    Result := '184';
    ExecutaComandoSql(Aux,'ALTER TABLE PRODUTOFILIALFATURAMENTO DROP PRIMARY KEY ' );
    ExecutaComandoSql(Aux,'ALTER TABLE PRODUTOFILIALFATURAMENTO DROP(SEQITEM)' );
    ExecutaComandoSql(Aux,'ALTER TABLE PRODUTOFILIALFATURAMENTO ADD PRIMARY KEY (SEQPRODUTO, CODFILIAL)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 184');
  end;
  if VpaNumAtualizacao < 185 then
  begin
    Result := '185';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO ADD(N_VVE_ANT NUMBER(17,4))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 185');
  end;
  if VpaNumAtualizacao < 186 then
  begin
    Result := '186';
    ExecutaComandoSql(Aux,'CREATE TABLE PROPOSTAFORMAPAGAMENTO( ' +
                              ' CODFILIAL NUMBER(10) NOT NULL, ' +
                              ' SEQPROPOSTA NUMBER(10) NOT NULL, ' +
                              ' SEQITEM NUMBER(10) NOT NULL, ' +
                              ' VALPAGAMENTO NUMBER(15,3), ' +
                              ' DESCONDICAO VARCHAR2(20), ' +
                              ' DESFORMAPAGAMENTO VARCHAR2(30), ' +
                              ' PRIMARY KEY(SEQPROPOSTA,CODFILIAL, SEQITEM))');
    ExecutaComandoSql(Aux,'CREATE INDEX PROPOSTAFORMAPAGAMENTO_FK1 ON PROPOSTAFORMAPAGAMENTO(SEQPROPOSTA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 186');
  end;
  if VpaNumAtualizacao < 187 then
  begin
    Result := '187';
    ExecutaComandoSql(Aux,'DROP INDEX PROPOSTAFORMAPAGAMENTO_FK1');
    ExecutaComandoSql(Aux,'CREATE INDEX PROPOSTAFORMAPAGAMENTO_FK1 ON PROPOSTAFORMAPAGAMENTO(CODFILIAL,SEQPROPOSTA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 187');
  end;
  if VpaNumAtualizacao < 188 then
  begin
    result := '188';
    ExecutaComandoSql(Aux,' CREATE TABLE CHAMADOANEXOIMAGEM( ' +
                          ' CODFILIAL NUMBER(10) NOT NULL,' +
                          ' NUMCHAMADO NUMBER(10) NOT NULL,' +
                          ' SEQITEM NUMBER(10) NOT NULL, ' +
                          ' DESCAMINHOIMAGEM VARCHAR2(100), ' +
                          ' PRIMARY KEY(CODFILIAL, NUMCHAMADO, SEQITEM))');
//    ExecutaComandoSql(Aux,'CREATE INDEX CHAMADOANEXOIMAGEM_FK1 ON CHAMADOCORPO(CODFILIAL, NUMCHAMADO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 188');
  end;
  if VpaNumAtualizacao < 189 then
  begin
    result := '189';
    ExecutaComandoSql(Aux,' ALTER TABLE ORCAMENTOPARCIALCORPO ADD(PESLIQUIDO NUMBER(11,3), QTDVOLUME NUMBER(10))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 189');
  end;
  if VpaNumAtualizacao < 190 then
  begin
    result := '190';
    ExecutaComandoSql(Aux,' DROP TABLE PROPOSTAFORMAPAGAMENTO');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 190');
  end;
  if VpaNumAtualizacao < 191 then
  begin
    result := '191';
    ExecutaComandoSql(Aux,'CREATE TABLE PROPOSTAPARCELAS( ' +
                              ' CODFILIAL NUMBER(10) NOT NULL, ' +
                              ' SEQPROPOSTA NUMBER(10) NOT NULL, ' +
                              ' SEQITEM NUMBER(10) NOT NULL, ' +
                              ' VALPAGAMENTO NUMBER(15,3), ' +
                              ' DESCONDICAO VARCHAR2(20), ' +
                              ' CODFORMAPAGAMENTO NUMBER(10) NOT NULL REFERENCES CADFORMASPAGAMENTO(I_COD_FRM), ' +
                              ' PRIMARY KEY(SEQPROPOSTA,CODFILIAL, SEQITEM))');
    ExecutaComandoSql(Aux,'CREATE INDEX PROPOSTAPARCELAS_FK1 ON PROPOSTAPARCELAS(CODFILIAL,SEQPROPOSTA)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 191');
  end;
  if VpaNumAtualizacao < 192 then
  begin
    result := '192';
    ExecutaComandoSql(Aux,' ALTER TABLE SETOR ADD(DESGARANTIA VARCHAR2(10))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 192');
  end;
  if VpaNumAtualizacao < 193 then
  begin
    result := '193';
    ExecutaComandoSql(Aux,' ALTER TABLE CHAMADOPRODUTOORCADO ADD(DESNUMSERIE VARCHAR2(20)) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 193');
  end;
  if VpaNumAtualizacao < 194 then
  begin
    result := '194';
    ExecutaComandoSql(Aux,' ALTER TABLE CADCLIENTES ADD(C_EST_EMB VARCHAR2(2), C_LOC_EMB VARCHAR2(60))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 194');
  end;
  if VpaNumAtualizacao < 195 then
  begin
    result := '195';
    ExecutaComandoSql(Aux,' ALTER TABLE CADORCAMENTOS ADD(C_EST_EMB VARCHAR2(2), C_LOC_EMB VARCHAR2(60))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 195');
  end;
  if VpaNumAtualizacao < 196 then
  begin
    result := '196';
    ExecutaComandoSql(Aux,' ALTER TABLE CFG_FINANCEIRO ADD(I_QTD_VEN NUMBER(10))');
    ExecutaComandoSql(Aux,' UPDATE CFG_FINANCEIRO SET I_QTD_VEN = 2');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 196');
  end;
  if VpaNumAtualizacao < 197 then
  begin
    result := '197';
    ExecutaComandoSql(Aux,' ALTER TABLE CHEQUE ADD(CODFORNECEDORRESERVA NUMBER(10))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 197');
  end;
  if VpaNumAtualizacao < 198 then
  begin
    result := '198';
    ExecutaComandoSql(Aux,' ALTER TABLE MOVNOTASFISCAISFOR ADD(N_MVA_AJU NUMBER(17,2))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 198');
  end;
  if VpaNumAtualizacao < 199 then
  begin
    result := '199';
    ExecutaComandoSql(Aux,' ALTER TABLE CFG_GERAL ADD(C_EMA_PRO CHAR(1))');
    ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_EMA_PRO = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 199');
  end;
  if VpaNumAtualizacao < 200 then
  begin
    result := '200';
    ExecutaComandoSql(Aux,' ALTER TABLE ORCAMENTOROTEIROENTREGA ADD(CODREGIAOVENDAS NUMBER(10))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 200');
  end;
  if VpaNumAtualizacao < 201 then
  begin
    result := '201';
    ExecutaComandoSql(Aux,' ALTER TABLE CFG_PRODUTO ADD(C_COD_BAR CHAR(1))');
    ExecutaComandoSql(Aux,' update CFG_PRODUTO SET C_COD_BAR = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 201');
  end;
  if VpaNumAtualizacao < 202 then
  begin
    result := '202';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_EXC_AMO varchar2(1))');
    ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EXC_AMO  = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_PR1 = 202');
  end;
end;
end.
