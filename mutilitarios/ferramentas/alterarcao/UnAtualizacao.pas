Unit UnAtualizacao;

interface
  Uses Classes, DbTables,SysUtils;

Const
  CT_VersaoBanco = 353;
  CT_VersaoInvalida = 'SISTEMA DESATUALIZADO!!! Este sistema já possui novas versões, essa versão pode não funcionar corretamente,  para o bom funcionamento do mesmo é necessário fazer atualização...' ;

  CT_SenhaAtual = '9774';


Type
  TAtualiza = Class
    Private
      Aux : TQuery;
      DataBase : TDataBase;
      procedure AtualizaSenha( Senha : string );
      procedure AlteraVersoesSistemas;
    public
      procedure AtualizaTabela(VpaNumAtualizacao : Integer);
      function AtualizaTabela1(VpaNumAtualizacao : Integer): String;
      procedure AtualizaBanco;
      constructor criar( aowner : TComponent; ADataBase : TDataBase );
end;


implementation

Uses FunSql, ConstMsg, FunNumeros,Registry, Constantes, FunString, funvalida;

{*************************** cria a classe ************************************}
constructor TAtualiza.criar( aowner : TComponent; ADataBase : TDataBase );
begin
  inherited Create;
  Aux := TQuery.Create(aowner);
  DataBase := ADataBase;
  Aux.DataBaseName := 'BaseDados';
end;

{*************** atualiza senha na base de dados ***************************** }
procedure TAtualiza.AtualizaSenha( Senha : string );
var
  ini : TRegIniFile;
  senhaInicial : string;
begin
  try
    if not DataBase.InTransaction then
      DataBase.StartTransaction;

    // atualiza regedit
    Ini := TRegIniFile.Create('Software\Systec\Sistema');
    senhaInicial := Ini.ReadString('SENHAS','BANCODADOS', '');  // guarda senha do banco
    Ini.WriteString('SENHAS','BANCODADOS', Criptografa(senha));  // carrega senha do banco


   // atualiza base de dados
    LimpaSQLTabela(aux);
    AdicionaSQLTabela(Aux, 'grant connect, to DBA identified by ''' + senha + '''');
    Aux.ExecSQL;

    if DataBase.InTransaction then
      DataBase.commit;
    ini.free;
   except
    if DataBase.InTransaction then
      DataBase.Rollback;
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
end;

{********************* altera as versoes do sistema ***************************}
procedure TAtualiza.AlteraVersoesSistemas;
begin
  ExecutaComandoSql(Aux,'Update Cfg_Geral ' +
                        'set C_Mod_Fat = '''+ VersaoFaturamento + ''',' +
                        ' C_Mod_Pon = '''+ VersaoPontoLoja + ''','+
                        ' C_Mod_Est = ''' + VersaoEstoque + ''',' +
                        ' C_Mod_Fin = ''' + VersaoFinanceiro+''','+
                        ' C_CON_SIS = ''' + VersaoConfiguracaoSistema+'''');
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
      if VpaNumAtualizacao < 1 Then
      begin
        VpfErro := '1';
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 3');
      end;

      if VpaNumAtualizacao < 2 Then
      begin
        VpfErro := '2';
        ExecutaComandoSql(Aux,'Alter table CFG_GERAL'
                            +'  ADD C_MOD_TRX CHAR(10) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 2');
        ExecutaComandoSql(Aux,'comment on column CFG_GERAL.C_MOD_TRX is ''MODULO DE TRANSFERENCIA DE DADOS''');
      end;

      if VpaNumAtualizacao < 3 Then
      begin
        VpfErro := '3';
        ExecutaComandoSql(Aux,'Alter table CADUSUARIOS'
                            +'  ADD C_MOD_TRX CHAR(1) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 3');
        ExecutaComandoSql(Aux,'comment on column CADUSUARIOS.C_MOD_TRX is ''MODULO DE TRANSFERENCIA DE DADOS''');
      end;

      if VpaNumAtualizacao < 4 Then
      begin
        VpfErro := '4';
        ExecutaComandoSql(Aux,'alter table movchequeterceiro'
                            +'     add C_TIP_MOV char(1); '
                            +'   '
                            +'  update  movchequeterceiro '
                            +'  set C_TIP_MOV = ''T''; ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 4');
        ExecutaComandoSql(Aux,'comment on column movchequeterceiro.c_tip_mov is ''TIPO DE MOVIMENTACAO, T TERCEIRO, V VARIAS FORMAS''');
      end;

      if VpaNumAtualizacao < 5 Then
      begin
        VpfErro := '5';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_MODULO '
                            +'     ADD FLA_SERVICO CHAR(1), '
                            +'     ADD FLA_TEF CHAR(1), '
                            +'     ADD FLA_CODIGOBARRA CHAR(1), '
                            +'     ADD FLA_GAVETA CHAR(1), '
                            +'     ADD FLA_IMPDOCUMENTOS CHAR(1), '
                            +'     ADD FLA_ORCAMENTOVENDA CHAR(1), '
                            +'     ADD FLA_IMP_EXP CHAR(1), '
                            +'     ADD FLA_SENHAGRUPO CHAR(1); ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 5');
      end;
    
      if VpaNumAtualizacao < 6 Then
      begin
        VpfErro := '6';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'  ADD I_CLI_DEV INTEGER ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 6');
        ExecutaComandoSql(Aux,'comment on column CFG_FISCAL.I_CLI_DEV is ''CLIENTE DE DEVOLUCAO DA NOTA FISCAL''');
      end;

      if VpaNumAtualizacao < 7 Then
      begin
        VpfErro := '7';
        ExecutaComandoSql(Aux,'alter table cadClientes'
                            +'  add C_ELE_REP char(100) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 7');
        ExecutaComandoSql(Aux,'comment on column  cadClientes.C_ELE_REP is ''ENDERECO ELETRONICO DO REPRESENTANTE (WWW)''');
      end;

      if VpaNumAtualizacao < 8 Then
      begin
        VpfErro := '8';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'    add I_NAT_NOT integer, '
                            +'    add I_NOT_CUP integer ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 8');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.I_NAT_NOT is ''NATUREZA PARA DEVOLUCAO DE NOTA FISCAL''');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.I_NOT_CUP is ''NATUREZA DE NOTA FISCAL DE CUPOM''');
      end;

      if VpaNumAtualizacao < 9 Then
      begin
        VpfErro := '9';
        ExecutaComandoSql(Aux,'alter table MovTef'
                            +'    drop n_aut_tra, '
                            +'    drop t_tim_loc, '
                            +'    drop n_tip_par, '
                            +'    drop n_qtd_par, '
                            +'    drop d_ven_par, '
                            +'    drop n_vlr_par, '
                            +'    drop n_nsu_par, '
                            +'    drop d_pre_dat, '
                            +'    drop c_ima_lin, '
                            +'    drop c_aut_tef, '
                            +'    drop c_nom_adm ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 9');
      end;

      if VpaNumAtualizacao < 10 Then
      begin
        VpfErro := '10';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'    add C_CLI_CUP char(1) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 10');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.c_cli_cup is ''BOOLEAN  - MOSTRAR OU NAO TELA DADOS DO CLIENTE NO CUPOM FISCAL''');
      end;

      if VpaNumAtualizacao < 11 Then
      begin
        VpfErro := '11';
        ExecutaComandoSql(Aux,'drop table Tabela_Exportacao');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 11');
      end;

      if VpaNumAtualizacao < 12 Then
      begin
        VpfErro := '12';
        ExecutaComandoSql(Aux,'create table TABELA_EXPORTACAO'
                            +'  ( SEQ_TABELA INTEGER NOT NULL, '
                            +'   NOM_TABELA CHAR(50), '
                            +'  NOM_CHAVE1 CHAR(50), '
                            +'  NOM_CHAVE2 CHAR(50), '
                            +'  NOM_CHAVE3 CHAR(50), '
                            +'  NOM_CHAVE4 CHAR(50), '
                            +'  NOM_CHAVE5 CHAR(50), '
                            +'  NOM_CAMPO_DATA CHAR(50), '
                            +'  PRIMARY KEY(SEQ_TABELA)) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 12');
        ExecutaComandoSql(Aux,'comment on table TABELA_EXPORTACAO is ''TABELA DE EXPORTACAO''');
        ExecutaComandoSql(Aux,'comment on column TABELA_EXPORTACAO.SEQ_TABELA is ''SEQUENCIAL DE EXPORTACAO DA TABELA''');
        ExecutaComandoSql(Aux,'comment on column TABELA_EXPORTACAO.NOM_CHAVE1 is ''NOME DO CAMPO CHAVE 1''');
        ExecutaComandoSql(Aux,'comment on column TABELA_EXPORTACAO.NOM_CHAVE2 is ''NOME DO CAMPO CHAVE 2''');
        ExecutaComandoSql(Aux,'comment on column TABELA_EXPORTACAO.NOM_CHAVE3 is ''NOME DO CAMPO CHAVE 3''');
        ExecutaComandoSql(Aux,'comment on column TABELA_EXPORTACAO.NOM_CHAVE4 is ''NOME DO CAMPO CHAVE 4''');
        ExecutaComandoSql(Aux,'comment on column TABELA_EXPORTACAO.NOM_CHAVE5 is ''NOME DO CAMPO CHAVE 5''');
        ExecutaComandoSql(Aux,'comment on column TABELA_EXPORTACAO.NOM_CAMPO_DATA is ''NOME DO CAMPO DATA''');
      end;

      if VpaNumAtualizacao < 13 Then
      begin
        VpfErro := '13';
        ExecutaComandoSql(Aux,'create table GRUPO_TABELA_EXPORTACAO'
                            +'  ( SEQ_TABELA INTEGER NOT NULL, '
                            +'    COD_GRUPO  INTEGER NOT NULL, '
                            +'  PRIMARY KEY(SEQ_TABELA,COD_GRUPO)) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 13');
        ExecutaComandoSql(Aux,'comment on table GRUPO_TABELA_EXPORTACAO is ''GRUPOS DAS TABELAS DE EXPORTACAO''');
        ExecutaComandoSql(Aux,'comment on column GRUPO_TABELA_EXPORTACAO.SEQ_TABELA is ''SEQUENCIAL DA TABELA''');
        ExecutaComandoSql(Aux,'comment on column GRUPO_TABELA_EXPORTACAO.COD_GRUPO is ''CODIGO DO GRUPO''');
      end;

      if VpaNumAtualizacao < 14 Then
      begin
        VpfErro := '14';
        ExecutaComandoSql(Aux,'create unique index GRUPO_TABELA_EXPORTACAO_pk on'         
                            +'  GRUPO_TABELA_EXPORTACAO(SEQ_TABELA ASC,COD_GRUPO ASC) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 14');
      end;

      if VpaNumAtualizacao < 15 Then
      begin
        VpfErro := '15';
        ExecutaComandoSql(Aux,'drop index GRUPO_EXPORTACAO_PK');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 15');
      end;

      if VpaNumAtualizacao < 16 Then
      begin
        VpfErro := '16';
        ExecutaComandoSql(Aux,'alter table grupo_exportacao'
                            +'  drop primary key ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 16');
      end;

      if VpaNumAtualizacao < 17 Then
      begin
        VpfErro := '17';
        ExecutaComandoSql(Aux,'alter table grupo_exportacao'
                            +'  drop cod_empresa ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 17');
      end;

      if VpaNumAtualizacao < 18 Then
      begin
        VpfErro := '18';
        ExecutaComandoSql(Aux,'alter table grupo_exportacao'
                            +'       add primary key(cod_grupo) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 18');
      end;

      if VpaNumAtualizacao < 19 Then
      begin
        VpfErro := '19';
        ExecutaComandoSql(Aux,'alter table GRUPO_TABELA_EXPORTACAO'
                            +'                                 add foreign key GRUPO_TABELA_EXPORTACAO_FK101(COD_GRUPO)  '
                            +'                                 references GRUPO_EXPORTACAO(COD_GRUPO)  '
                            +'                                on update restrict on delete restrict ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 19');
      end;

      if VpaNumAtualizacao < 20 Then
      begin
        VpfErro := '20';
        ExecutaComandoSql(Aux,'alter table GRUPO_EXPORTACAO'
                            +'                                 add IDE_TIPO_GRUPO CHAR(1) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 20');
        ExecutaComandoSql(Aux,'comment on column GRUPO_EXPORTACAO.IDE_TIPO_GRUPO is ''DEFINE O TIPO DO GRUPO''');
      end;

      if VpaNumAtualizacao < 21 Then
      begin
        VpfErro := '21';
        ExecutaComandoSql(Aux,'create table CADCARTAO( I_COD_CAR integer,'
                            +'                                                         C_NOM_CAR char(40), '
                            +'                                                         N_PER_COM numeric(17,2), '
                            +'           primary key (I_COD_CAR) )  ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 21');
        ExecutaComandoSql(Aux,'comment on column CADCARTAO.I_COD_CAR is ''CODIGO DO CARTAO''');
        ExecutaComandoSql(Aux,'comment on column CADCARTAO.C_NOM_CAR is ''NOME DA REDE DO CARTAO''');
        ExecutaComandoSql(Aux,'comment on column CADCARTAO.N_PER_COM is ''PERCENTUAL DO CARTAO''');
      end;

      if VpaNumAtualizacao < 22 Then
      begin
        VpfErro := '22';
        ExecutaComandoSql(Aux,'create table CADTIPOTRANSACAO( I_COD_TRA integer,'
                            +'           C_NOM_TRA char(40), '
                            +'           primary key (I_COD_TRA) )  ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 22');
        ExecutaComandoSql(Aux,'comment on column CADTIPOTRANSACAO.I_COD_TRA is ''CODIGO DO TRANSACAO''');
        ExecutaComandoSql(Aux,'comment on column CADTIPOTRANSACAO.C_NOM_TRA is ''NOME DO TIPO DE TRANSACAO DO CARTAO''');
      end;

      if VpaNumAtualizacao < 23 Then
      begin
        VpfErro := '23';
        ExecutaComandoSql(Aux,'alter table MovContasAReceber'
                            +'    add I_SEQ_TEF integer; '
                            +'   '
                            +'  alter table MovContasAReceber '
                            +'    add foreign key FK_MOVTEF_2020(I_EMP_FIL,I_SEQ_TEF)   '
                            +'    references movtef(I_EMP_FIL,I_SEQ_TEF)  '
                            +'    on update restrict on delete restrict ; '
                            +'   '
                            +'  create index FK_MOVTEF_56231 on '
                            +'  MovContasAReceber(I_SEQ_TEF ASC, I_EMP_FIL ASC) ; ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 23');
        ExecutaComandoSql(Aux,'comment on column MovContasAReceber.I_SEQ_TEF is ''SEQUENCIAL DO TEF DISCADO''');
      end;

      if VpaNumAtualizacao < 24 Then
      begin
        VpfErro := '24';
        ExecutaComandoSql(Aux, ' drop index Ref_125589_FK; '
                            +'alter table movtef'
                            +'   drop foreign key FK_MOVTEF_REF_12558_MOVCONTA; '
                            +'   '
                            +'  alter table movtef '
                            +'    drop i_lan_rec, '
                            +'    drop i_nro_par; ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 24');
      end;

      if VpaNumAtualizacao < 25 Then
      begin
        VpfErro := '25';
        ExecutaComandoSql(Aux,'create unique index CADTIPOTRANSACAO_pk on'
                            +'    CADTIPOTRANSACAO(I_COD_TRA ASC); '
                            +'  create unique index CADCARTAO_pk on '
                            +'    CADCARTAO(I_COD_CAR ASC); ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 25');
      end;

      if VpaNumAtualizacao < 26 Then
      begin
        VpfErro := '26';
        ExecutaComandoSql(Aux,' create table CADREGIAOVENDA( I_COD_REG integer,'
                            +'           C_NOM_REG char(40), '
                            +'           primary key (I_COD_REG) ); '
                            +' create unique index CADREGIAOVENDA_pk on'
                            +'    CADREGIAOVENDA(I_COD_REG ASC); ' );
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 26');
        ExecutaComandoSql(Aux,'comment on column CADREGIAOVENDA.I_COD_REG is ''CODIGO DA REGIAO DE VENDA''');
        ExecutaComandoSql(Aux,'comment on column CADREGIAOVENDA.C_NOM_REG is ''NOME DA REGIAO DE VENDA''');
      end;

      if VpaNumAtualizacao < 27 Then
      begin
        VpfErro := '27';
        ExecutaComandoSql(Aux,'alter table CADClientes'
                            +'    add I_COD_REG integer; '
                            +'   '
                            +'  alter table CADClientes '
                            +'    add foreign key FK_CADREGIAOVENDA_7561(I_COD_REG)   '
                            +'    references CADREGIAOVENDA(I_COD_REG)  '
                            +'    on update restrict on delete restrict ; '
                            +'   '
                            +'  create index FK_CADREGIAOVENDA_14549 on '
                            +'  CADClientes(I_COD_REG ASC); ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 27');
        ExecutaComandoSql(Aux,'comment on column CADClientes.I_COD_REG is ''CODIGO DA REGIAO DE VENDA''');
      end;

      if VpaNumAtualizacao < 28 Then
      begin
        VpfErro := '28';
        ExecutaComandoSql(Aux,' INSERT INTO CADREGIAOVENDA(I_COD_REG, C_NOM_REG) '
                              +' VALUES(1101,''GERAL''); '
                              +' update cadClientes '
                              +' set i_cod_reg = 1101' );
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 28');
      end;
    
      if VpaNumAtualizacao < 29 Then
      begin
        VpfErro := '29';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'   add I_LAY_ECF integer; '
                            +'   '
                            +'  update cfg_fiscal '
                            +'  set I_LAY_ECF = 0; ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 29');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.i_lay_ecf is ''TIPO DE LAYOUT DO ECF''');
      end;
    
      if VpaNumAtualizacao < 30 Then
      begin
        VpfErro := '30';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'   add I_FON_ECF  integer, '
                            +'   add I_CLI_ECF integer; ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 30');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.I_FON_ECF is ''TAMANHO DA FONTE DO ECF''');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.I_CLI_ECF is ''CLIENTE PADRAO DO ECF''');
      end;
    
      if VpaNumAtualizacao < 31 Then
      begin
        VpfErro := '31';
        ExecutaComandoSql(Aux,'alter table cfg_financeiro'
                            +'    add C_PAR_DAT char(1) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 31');
        ExecutaComandoSql(Aux,'comment on column cfg_financeiro.c_par_dat is ''BOOLEAN - SE O CAIXA ESTIVER COM DATA RETROATIVA NAUM PERMITE ABRIR PARCIAL''');
      end;
    
      if VpaNumAtualizacao < 32 Then
      begin
        VpfErro := '32';
        ExecutaComandoSql(Aux,'alter table cfg_financeiro'
                            +'    add C_ITE_DAT char(1) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 32');
        ExecutaComandoSql(Aux,'comment on column cfg_financeiro.c_ite_dat is ''BOOLEAN - PERMITE LANCAR ITENS EM CAIXA COM DATA RETROATIVA''');
      end;
    
      if VpaNumAtualizacao < 33 Then
      begin
        VpfErro := '33';
        ExecutaComandoSql(Aux,'alter table movsumarizaestoque'
                            +'    drop c_tip_ope; '
                            +'  alter table movsumarizaestoque '
                            +'    add D_DAT_MES date; ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 33');
        ExecutaComandoSql(Aux,'comment on column movsumarizaestoque.d_dat_mes is ''DATA DO FECHAMENTO DO PRODUTO POR MES''');
      end;
    
      if VpaNumAtualizacao < 34 Then
      begin
        VpfErro := '34';
        ExecutaComandoSql(Aux,'alter table movnotasfiscais'
                            +'    add N_VLR_IPI numeric(17,3) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 34');
        ExecutaComandoSql(Aux,'comment on column movnotasfiscais.N_VLR_IPI is ''VALOR DO IPI''');
      end;

      if VpaNumAtualizacao < 35 Then
      begin
        VpfErro := '35';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'    drop i_cod_nat, '
                            +'    drop i_nat_not, '
                            +'    drop i_not_cup, '
                            +'    drop i_nat_dev; ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 35');
      end;

      if VpaNumAtualizacao < 36 Then
      begin
        VpfErro := '36';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'    add C_COD_NAT char(10), '
                            +'    add C_NAT_NOT char(10), '
                            +'    add C_NOT_CUP  char(10), '
                            +'    add C_NAT_DEV  char(10); ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 36');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.C_COD_NAT is ''CODIGO DA NATUREZA PADRAO''');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.C_NAT_NOT is ''NATUREZA DE DEVOLUCAO DE NOTA FISCAL''');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.C_NOT_CUP is ''NATUREZA DE CUPOM FISCAL''');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.C_NAT_DEV is ''NATUREZA DE DEVOLUCAO DE CUPOM''');
      end;
    
      if VpaNumAtualizacao < 37 Then
      begin
        VpfErro := '37';
        ExecutaComandoSql(Aux,'alter table cadnatureza'
                            +'    add C_ENT_SAI char(1) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 37');
        ExecutaComandoSql(Aux,'comment on column cadnatureza.C_ENT_SAI is ''TIPO DA NOTA ENTRADA OU SAIDA''');
      end;
    
      if VpaNumAtualizacao < 38 Then
      begin
        VpfErro := '38';
        ExecutaComandoSql(Aux,'alter table tabela_exportacao'
                            +'  ADD NOM_CAMPO_FILIAL CHAR(50) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 38');
        ExecutaComandoSql(Aux,'comment on column tabela_exportacao.NOM_CAMPO_FILIAL is ''NOME DO CAMPO FILIAL''');
      end;
    
      if VpaNumAtualizacao < 39 Then
      begin
        VpfErro := '39';
        ExecutaComandoSql(Aux,'alter table movnatureza'
                            +'    add C_MOS_NOT char(1) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 39');
        ExecutaComandoSql(Aux,'comment on column movnatureza.c_mos_not is ''MOSTRAR OPCAO NA NOTA FISCAL''');
      end;
    
      if VpaNumAtualizacao < 40 Then
      begin
        VpfErro := '40';
        ExecutaComandoSql(Aux,'alter table CadNotaFiscais'
                            +'    add I_ITE_NAT integer; '
                            +'   '
                            +'  alter table MovNotasFiscaisFor '
                            +'    add I_ITE_NAT integer; ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 40');
        ExecutaComandoSql(Aux,'comment on column CadNotaFiscais.i_ite_nat is ''ITEM DO MOVNATUREZA''');
        ExecutaComandoSql(Aux,'comment on column MovNotasFiscaisFor.i_ite_nat is ''ITEM DO MOVNATUREZA''');
      end;
    
      if VpaNumAtualizacao < 41 Then
      begin
        VpfErro := '41';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'    add I_FRE_NOT integer ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 41');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.i_fre_not is ''TIPO PADRAO DO FRETE DA NOTA 1 - 2 ''');
      end;
    
      if VpaNumAtualizacao < 42 Then
      begin
        VpfErro := '42';
        ExecutaComandoSql(Aux,'alter table cfg_fiscal'
                            +'    add C_NRO_NOT CHAR(1) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 42');
        ExecutaComandoSql(Aux,'comment on column cfg_fiscal.c_nro_not is ''TRANCA A ALTERAÇÃO DO NRO DA NOTA FISCAL''');
      end;
    
      if VpaNumAtualizacao < 43 Then
      begin
        VpfErro := '43';
        ExecutaComandoSql(Aux,'alter table  CAD_PAISES'
                            +'  add DAT_ULTIMA_ALTERACAO DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 43');
        ExecutaComandoSql(Aux,'comment on column CAD_PAISES.DAT_ULTIMA_ALTERACAO is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 44 Then
      begin
        VpfErro := '44';
        ExecutaComandoSql(Aux,'alter table  CAD_ESTADOS'
                            +'  add DAT_ULTIMA_ALTERACAO DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 44');
        ExecutaComandoSql(Aux,'comment on column CAD_ESTADOS.DAT_ULTIMA_ALTERACAO is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 45 Then
      begin
        VpfErro := '45';
        ExecutaComandoSql(Aux,'alter table  CADREGIAOVENDA'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 45');
        ExecutaComandoSql(Aux,'comment on column CADREGIAOVENDA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 46 Then
      begin
        VpfErro := '46';
        ExecutaComandoSql(Aux,'alter table  CADEMPRESAS'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 46');
        ExecutaComandoSql(Aux,'comment on column CADEMPRESAS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 47 Then
      begin
        VpfErro := '47';
        ExecutaComandoSql(Aux,'alter table  CADFILIAIS'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 47');
        ExecutaComandoSql(Aux,'comment on column CADFILIAIS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 48 Then
      begin
        VpfErro := '48';
        ExecutaComandoSql(Aux,'alter table  CADCLASSIFICACAO'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 48');
        ExecutaComandoSql(Aux,'comment on column  CADCLASSIFICACAO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 49 Then
      begin
        VpfErro := '49';
        ExecutaComandoSql(Aux,'alter table  CADUNIDADE'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 49');
        ExecutaComandoSql(Aux,'comment on column  CADUNIDADE.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 50 Then
      begin
        VpfErro := '50';
        ExecutaComandoSql(Aux,'alter table  MOVINDICECONVERSAO'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 50');
        ExecutaComandoSql(Aux,'comment on column  MOVINDICECONVERSAO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 51 Then
      begin
        VpfErro := '51';
        ExecutaComandoSql(Aux,'alter table  CADOPERACAOBANCARIA'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 51');
        ExecutaComandoSql(Aux,'comment on column CADOPERACAOBANCARIA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 52 Then
      begin
        VpfErro := '52';
        ExecutaComandoSql(Aux,'alter table  MOVCONDICAOPAGTO'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 52');
        ExecutaComandoSql(Aux,'comment on column MOVCONDICAOPAGTO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 53 Then
      begin
        VpfErro := '53';
        ExecutaComandoSql(Aux,'alter table  CADBANCOS'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 53');
        ExecutaComandoSql(Aux,'comment on column CADBANCOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 54 Then
      begin
        VpfErro := '54';
        ExecutaComandoSql(Aux,'alter table  MOVMOEDAS'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 54');
        ExecutaComandoSql(Aux,'comment on column MOVMOEDAS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 55 Then
      begin
        VpfErro := '55';
        ExecutaComandoSql(Aux,'alter table  CADGRUPOS'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 55');
        ExecutaComandoSql(Aux,'comment on column CADGRUPOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 56 Then
      begin
        VpfErro := '56';
        ExecutaComandoSql(Aux,'alter table  CADUSUARIOS'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 56');
        ExecutaComandoSql(Aux,'comment on column CADUSUARIOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 57 Then
      begin
        VpfErro := '57';
        ExecutaComandoSql(Aux,'alter table  CAD_CODIGO_BARRA'
                            +'  add D_ULT_ALT  DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 57');
        ExecutaComandoSql(Aux,'comment on column CAD_CODIGO_BARRA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 58 Then
      begin
        VpfErro := '58';
        ExecutaComandoSql(Aux,'ALTER TABLE CAD_BORDERO'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 58');
        ExecutaComandoSql(Aux,'comment on column CAD_BORDERO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 59 Then
      begin
        VpfErro := '59';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVKIT'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 59');
        ExecutaComandoSql(Aux,'comment on column MOVKIT.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 60 Then
      begin
        VpfErro := '60';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 60');
        ExecutaComandoSql(Aux,'comment on column MOVQDADEPRODUTO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 61 Then
      begin
        VpfErro := '61';
        ExecutaComandoSql(Aux,'alter table MOVTABELAPRECO'
                            +'  add D_ULT_ALT DATE NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 61');
        ExecutaComandoSql(Aux,'comment on column MOVTABELAPRECO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 62 Then
      begin
        VpfErro := '62';
        ExecutaComandoSql(Aux,'Alter table cadnatureza'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 62');
        ExecutaComandoSql(Aux,'comment on column cadnatureza.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 63 Then
      begin
        VpfErro := '63';
        ExecutaComandoSql(Aux,'create table TEMPORARIAESTOQUE'
                            +'   ( I_EMP_FIL INTEGER NULL, '
                            +'     C_GRU_001 CHAR(20) NULL, '
                            +'     C_GRU_002 CHAR(20) NULL, '
                            +'     C_GRU_003 CHAR(20) NULL, '
                            +'     C_GRU_004 CHAR(20) NULL, '
                            +'     C_GRU_005 CHAR(20) NULL, '
                            +'     C_COD_CLA CHAR(15) NULL, '
                            +'     C_NOM_CLA CHAR(40) NULL, '
                            +'     N_EST_ANT NUMERIC(17,3) NULL, '
                            +'     N_VLR_ANT NUMERIC(17,3) NULL, '
                            +'     N_EST_ATU NUMERIC(17,3) NULL, '
                            +'     N_VLR_ATU NUMERIC(17,3) NULL, '
                            +'     N_QTD_VEN NUMERIC(17,3) NULL, '
                            +'     N_VLR_VEN NUMERIC(17,3) NULL, '
                            +'     N_GIR_EST  NUMERIC(17,3) NULL) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 63');
      end;

      if VpaNumAtualizacao < 64 Then
      begin
        VpfErro := '64';
        ExecutaComandoSql(Aux,'Alter table MOVnatureza'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 64');
        ExecutaComandoSql(Aux,'comment on column MOVNATUREZA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 65 Then
      begin
        VpfErro := '65';
        ExecutaComandoSql(Aux,'alter table CADORCAMENTOS'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 65');
        ExecutaComandoSql(Aux,'comment on column CADORCAMENTOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 66 Then
      begin
        VpfErro := '66';
        ExecutaComandoSql(Aux,'alter table MOVORCAMENTOS'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 66');
        ExecutaComandoSql(Aux,'comment on column CADORCAMENTOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 67 Then
      begin
        VpfErro := '67';
        ExecutaComandoSql(Aux,'alter table MOVSERVICOORCAMENTO'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 67');
        ExecutaComandoSql(Aux,'comment on column MOVSERVICOORCAMENTO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 68 Then
      begin
        VpfErro := '68';
        ExecutaComandoSql(Aux,'ALTER TABLE CADICMSESTADOS'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 68');
        ExecutaComandoSql(Aux,'comment on column CADICMSESTADOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 69 Then
      begin
        VpfErro := '69';
        ExecutaComandoSql(Aux,'ALTER TABLE  MOVTABELAPRECOSERVICO'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 69');
        ExecutaComandoSql(Aux,'comment on column MOVTABELAPRECOSERVICO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 70 Then
      begin
        VpfErro := '70';
        ExecutaComandoSql(Aux,'DROP TABLE  PROXIMO_CODIGO');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 70');
      end;

      if VpaNumAtualizacao < 71 Then
      begin
        VpfErro := '71';
        ExecutaComandoSql(Aux,'ALTER TABLE CADSERIENOTAS'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 71');
        ExecutaComandoSql(Aux,'comment on column CADSERIENOTAS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 72 Then
      begin
        VpfErro := '72';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 72');
        ExecutaComandoSql(Aux,'comment on column CADNOTAFISCAISFOR.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 73 Then
      begin
        VpfErro := '73';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 73');
        ExecutaComandoSql(Aux,'comment on column MOVNOTASFISCAISFOR.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 74 Then
      begin
        VpfErro := '74';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 74');
        ExecutaComandoSql(Aux,'comment on column CADNOTAFISCAIS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 75 Then
      begin
        VpfErro := '75';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 75');
        ExecutaComandoSql(Aux,'comment on column MOVNOTASFISCAIS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 76 Then
      begin
        VpfErro := '76';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVSERVICONOTA'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 76');
        ExecutaComandoSql(Aux,'comment on column MOVSERVICONOTA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 77 Then
      begin
        VpfErro := '77';
        ExecutaComandoSql(Aux,' alter table CadCartao '
                            +'    add I_DIA_VEN integer nulL, '
                            +'    add I_TIP_VEN integer null ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 77');
        ExecutaComandoSql(Aux,'comment on column CadCartao.I_DIA_VEN is ''DIA FIXO OU QUANTIDADE DE DIAS PARA O VENCIMENTO''');
        ExecutaComandoSql(Aux,'comment on column CadCartao.I_TIP_VEN is ''TIPO DE VENCIMENTO FIXO OU SOMATORIO''');
      end;
    
      if VpaNumAtualizacao < 78 Then
      begin
        VpfErro := '78';
        ExecutaComandoSql(Aux,'alter table CADDESPESAS'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 78');
        ExecutaComandoSql(Aux,'comment on column CADDESPESAS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 79 Then
      begin
        VpfErro := '79';
        ExecutaComandoSql(Aux,'alter table CADCONTAS'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 79');
        ExecutaComandoSql(Aux,'comment on column CADCONTAS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 80 Then
      begin
        VpfErro := '80';
        ExecutaComandoSql(Aux,'alter table cadcartao'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 80');
        ExecutaComandoSql(Aux,'comment on column CADCARTAO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO DO REGISTRO''');
      end;
    
      if VpaNumAtualizacao < 81 Then
      begin
        VpfErro := '81';
        ExecutaComandoSql(Aux,'alter table CAD_TIPO_OPERA'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 81');
        ExecutaComandoSql(Aux,'comment on column CAD_TIPO_OPERA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO DO REGISTRO''');
      end;
    
      if VpaNumAtualizacao < 82 Then
      begin
        VpfErro := '82';
        ExecutaComandoSql(Aux,'alter table CADTIPOTRANSACAO'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 82');
        ExecutaComandoSql(Aux,'comment on column CADTIPOTRANSACAO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO DO REGISTRO''');
      end;

      if VpaNumAtualizacao < 83 Then
      begin
        VpfErro := '83';
        ExecutaComandoSql(Aux,'alter table CADCONTASARECEBER'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 83');
        ExecutaComandoSql(Aux,'comment on column CADCONTASARECEBER.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO DO REGISTRO''');
      end;
    
      if VpaNumAtualizacao < 84 Then
      begin
        VpfErro := '84';
        ExecutaComandoSql(Aux,'alter table MOVCONTASARECEBER'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 84');
        ExecutaComandoSql(Aux,'comment on column MOVCONTASARECEBER.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO DO REGISTRO''');
      end;
    
      if VpaNumAtualizacao < 85 Then
      begin
        VpfErro := '85';
        ExecutaComandoSql(Aux,'alter table MOVCONTASAPAGAR'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 85');
        ExecutaComandoSql(Aux,'comment on column MOVCONTASAPAGAR.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO DO REGISTRO''');
      end;
    
      if VpaNumAtualizacao < 86 Then
      begin
        VpfErro := '86';
        ExecutaComandoSql(Aux,'alter table CADCONTASAPAGAR'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 86');
        ExecutaComandoSql(Aux,'comment on column CADCONTASAPAGAR.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO DO REGISTRO''');
      end;
    
      if VpaNumAtualizacao < 87 Then
      begin
        VpfErro := '87';
        ExecutaComandoSql(Aux,'alter table MOVFORNECPRODUTOS'
                            +'  ADD D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 87');
        ExecutaComandoSql(Aux,'comment on column MOVFORNECPRODUTOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 88 Then
      begin
        VpfErro := '88';
        ExecutaComandoSql(Aux,'alter table MOVBANCOS'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 88');
        ExecutaComandoSql(Aux,'comment on column MOVBANCOS.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 89 Then
      begin
        VpfErro := '89';
        ExecutaComandoSql(Aux,'alter table MOVCOMISSOES'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 89');
        ExecutaComandoSql(Aux,'comment on column MOVCOMISSOES.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 90 Then
      begin
        VpfErro := '90';
        ExecutaComandoSql(Aux,'alter table CAD_ALTERACAO'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 90');
        ExecutaComandoSql(Aux,'comment on column CAD_ALTERACAO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 91 Then
      begin
        VpfErro := '91';
        ExecutaComandoSql(Aux,'alter table CAD_CAIXA'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 91');
        ExecutaComandoSql(Aux,'comment on column CAD_CAIXA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 92 Then
      begin
        VpfErro := '92';
        ExecutaComandoSql(Aux,'alter table CAD_BOLETO'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 92');
        ExecutaComandoSql(Aux,'comment on column CAD_BOLETO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 93 Then
      begin
        VpfErro := '93';
        ExecutaComandoSql(Aux,'alter table MOV_DOC'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 93');
        ExecutaComandoSql(Aux,'comment on column MOV_DOC.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
     if VpaNumAtualizacao < 95 Then
      begin
        VpfErro := '95';
        ExecutaComandoSql(Aux,'alter table MOVCHEQUETERCEIRO'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 95');
        ExecutaComandoSql(Aux,'comment on column MOVCHEQUETERCEIRO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 96 Then
      begin
        VpfErro := '96';
        ExecutaComandoSql(Aux,'alter table MOV_DIARIO'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 96');
        ExecutaComandoSql(Aux,'comment on column MOV_DIARIO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 97 Then
      begin
        VpfErro := '97';
        ExecutaComandoSql(Aux,'alter table ITE_CAIXA'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 97');
        ExecutaComandoSql(Aux,'comment on column ITE_CAIXA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;

      if VpaNumAtualizacao < 98 Then
      begin
        VpfErro := '98';
        ExecutaComandoSql(Aux,'alter table CRP_PARCIAL'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 98');
        ExecutaComandoSql(Aux,'comment on column CRP_PARCIAL.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 99 Then
      begin
        VpfErro := '99';
        ExecutaComandoSql(Aux,'alter table MOV_ALTERACAO'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 99');
        ExecutaComandoSql(Aux,'comment on column MOV_ALTERACAO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 100 Then
      begin
        VpfErro := '100';
        ExecutaComandoSql(Aux,'alter table MOVTEF'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 100');
        ExecutaComandoSql(Aux,'comment on column MOVTEF.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 101 Then
      begin
        VpfErro := '101';
        ExecutaComandoSql(Aux,'alter table ITE_FECHAMENTO'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 101');
        ExecutaComandoSql(Aux,'comment on column ITE_FECHAMENTO.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;
    
      if VpaNumAtualizacao < 102 Then
      begin
        VpfErro := '102';
        ExecutaComandoSql(Aux,'alter table MovTef'
                            +'    add C_CAN_TEF char(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 102');
        ExecutaComandoSql(Aux,'comment on column MovTef.C_CAN_TEF is ''CASO O TEF TENHA SIDO CANCELADO''');
      end;

      if VpaNumAtualizacao < 103 Then
      begin
        VpfErro := '103';
        ExecutaComandoSql(Aux,'alter table CAD_PLANO_CONTA'
                            +'  add D_ULT_ALT DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 103');
        ExecutaComandoSql(Aux,'comment on column CAD_PLANO_CONTA.D_ULT_ALT is ''DATA DA ULTIMA ALTERACAO''');
      end;


      if VpaNumAtualizacao < 104 Then
      begin
        VpfErro := '104';
        AtualizaSenha(CT_SenhaAtual);
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 104');
      end;

      if VpaNumAtualizacao < 105 Then
      begin
        VpfErro := '105';
        ExecutaComandoSql(Aux,'alter table cadformularios'
                            +'  add C_MOD_TRX CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 105');
        ExecutaComandoSql(Aux,'comment on column cadformularios.C_MOD_TRX is ''MODULO DE TRANSFERECIA''');
      end;

      if VpaNumAtualizacao < 106 Then
      begin
        VpfErro := '106';
        ExecutaComandoSql(Aux,'alter table cadusuarios'
                            +'    add C_MOD_REL char(1) null ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 106');
        ExecutaComandoSql(Aux,'comment on column cadusuarios.c_mod_rel is ''PERMITE CONSULTAR O MODULO DE RELATORIOS''');
      end;

      if VpaNumAtualizacao < 107 Then
      begin
        VpfErro := '107';
        ExecutaComandoSql(Aux,'alter table cadformularios'
                            +'    add C_MOD_REL char(1) null ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 107');
        ExecutaComandoSql(Aux,'comment on column cadformularios.c_mod_rel is ''cadastros de relatorios''');
      end;

      if VpaNumAtualizacao < 108 Then
      begin
        VpfErro := '108';
        ExecutaComandoSql(Aux,'alter table cfg_geral'
                            +'    add C_MOD_REL char(10) null ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 108');
        ExecutaComandoSql(Aux,'comment on column CFG_GERAL.C_MOD_REL is ''VERSAO DO MODULO DE RALATORIO''');
      end;

      if VpaNumAtualizacao < 109 Then
      begin
        VpfErro := '109';
        ExecutaComandoSql(Aux,'alter table cfg_geral'
                            +'    ADD I_DIA_VAL integer NULL, '
                            +'    ADD I_TIP_BAS integer NULL; '
                            +' update cfg_geral set i_tip_bas = 1');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 109');
        ExecutaComandoSql(Aux,'comment on column cfg_geral.I_DIA_VAL is ''DIAS DE VALIDADE DA BASE DEMO''');
        ExecutaComandoSql(Aux,'comment on column cfg_geral.I_TIP_BAS is ''TIPO DA BASE DEMO OU OFICIAL 0 OFICIAL 1 DEMO''');
      end;

      if VpaNumAtualizacao < 110 Then
      begin
        VpfErro := '110';
        ExecutaComandoSql(Aux,'alter table cfg_financeiro'
                            +'  add I_FRM_CAR INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 110');
        ExecutaComandoSql(Aux,'comment on column cfg_financeiro.I_FRM_CAR is ''FORMA DE PAGAMENTO EM CARTEIRA''');
      end;

      if VpaNumAtualizacao < 111 Then
      begin
        VpfErro := '111';
        ExecutaComandoSql(Aux,' create table MOVFORMAS'
                            +'  ( I_EMP_FIL INTEGER NOT NULL, '
                            +'   I_SEQ_MOV INTEGER NOT NULL, '
                            +'   I_NRO_LOT INTEGER NULL, '
                            +'   I_LAN_REC INTEGER NULL, '
                            +'   I_LAN_APG INTEGER NULL, '
                            +'   I_COD_FRM INTEGER NULL, '
                            +'   C_NRO_CHE CHAR(20) NULL, '
                            +'   N_VLR_MOV NUMERIC(17,3) NULL, '
                            +'   C_NRO_CON CHAR(13) NULL, '
                            +'   C_NRO_BOL CHAR(20) NULL, '
                            +'   C_NOM_CHE CHAR(50) NULL, '
                            +'  PRIMARY KEY(I_EMP_FIL, I_SEQ_MOV)) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 111');
        ExecutaComandoSql(Aux,'comment on column movformas.I_EMP_FIL is ''CODIGO DA FILIAL''');
        ExecutaComandoSql(Aux,'comment on column movformas.I_SEQ_MOV is ''SEQUENCIAL DO MOVIMENTO''');
        ExecutaComandoSql(Aux,'comment on column movformas.I_NRO_LOT is ''NUMERO DO LOTE''');
        ExecutaComandoSql(Aux,'comment on column movformas.I_LAN_REC is ''LANCAMENTO DO CONTAS A RECEBER''');
        ExecutaComandoSql(Aux,'comment on column movformas.I_LAN_APG is ''LANCAMENTO DO CONTAS A PAGAR''');
        ExecutaComandoSql(Aux,'comment on column movformas.I_COD_FRM is ''CODIGO DA FORMA DE PAGAMENTO''');
        ExecutaComandoSql(Aux,'comment on column movformas.C_NRO_CHE is ''NUMERO DO CHEQUE''');
        ExecutaComandoSql(Aux,'comment on column movformas.N_VLR_MOV is ''VALOR DO MOVIMENTO''');
        ExecutaComandoSql(Aux,'comment on column movformas.C_NRO_CON is ''NUMERO DA CONTA''');
        ExecutaComandoSql(Aux,'comment on column movformas.C_NRO_BOL is ''NUMERO DO BOLETO''');
        ExecutaComandoSql(Aux,'comment on column movformas.C_NOM_CHE is ''NOMINAL DO CHEQUE''');
      end;

      if VpaNumAtualizacao < 112 Then
      begin
        VpfErro := '112';
        ExecutaComandoSql(Aux,'create unique index MOVFORMAS_pk on'
                            +'  MOVFORMAS(I_EMP_FIL, I_SEQ_MOV ASC)  ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 112');
      end;

      if VpaNumAtualizacao < 113 Then
      begin
        VpfErro := '113';
        ExecutaComandoSql(Aux,'create table CADHISTORICOCLIENTE'
                            +'  ( I_COD_HIS INTEGER NOT NULL, '
                            +'    C_DES_HIS char(40) NULL, '
                            +'    D_ULT_ALT DATE NULL, '
                            +'    PRIMARY KEY(I_COD_HIS) ) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 113');
        ExecutaComandoSql(Aux,'comment on table CADHISTORICOCLIENTE is ''TABELA DO HISTORICO DO CLIENTE''');
        ExecutaComandoSql(Aux,'comment on column CADHISTORICOCLIENTE.I_COD_HIS is ''CODIGO HISTORICO CLIENTE''');
        ExecutaComandoSql(Aux,'comment on column CADHISTORICOCLIENTE.C_DES_HIS is ''DESCRICAO DO HISTORICO DO CLIENTE''');
      end;

      if VpaNumAtualizacao < 114 Then
      begin
        VpfErro := '114';
        ExecutaComandoSql(Aux,'create table MOVHISTORICOCLIENTE'
                            +'  ( I_SEQ_HIS INTEGER NOT NULL, '
                            +'    I_COD_HIS INTEGER NULL, '
                            +'    I_COD_CLI INTEGER NULL, '
                            +'    I_COD_USU INTEGER NULL, '
                            +'    D_DAT_HIS  DATE  NULL, '
                            +'    L_HIS_CLI LONG VARCHAR NULL, '
                            +'    D_DAT_AGE  DATE NULL, '
                            +'    L_HIS_AGE LONG VARCHAR NULL, '
                            +'    D_ULT_ALT DATE NULL, '
                            +'    PRIMARY KEY(I_SEQ_HIS) ) ');
        ExecutaComandoSql(Aux,'Update Cfg_Geral set I_Ult_Alt = 114');
        ExecutaComandoSql(Aux,'comment on table MOVHISTORICOCLIENTE is ''TABELA DO HISTORICO DO CLIENTE''');
        ExecutaComandoSql(Aux,'comment on column MOVHISTORICOCLIENTE.I_SEQ_HIS is ''SEQUENCIAL DO MOV HISTORICO''');
        ExecutaComandoSql(Aux,'comment on column MOVHISTORICOCLIENTE.I_COD_HIS is ''CODIGO HISTORICO''');
        ExecutaComandoSql(Aux,'comment on column MOVHISTORICOCLIENTE.I_COD_CLI is ''CODIGO DO CLIENTE''');
        ExecutaComandoSql(Aux,'comment on column MOVHISTORICOCLIENTE.D_DAT_HIS is ''DATA DO HISTORICO''');
        ExecutaComandoSql(Aux,'comment on column MOVHISTORICOCLIENTE.L_HIS_CLI is ''HISTORICO DO CLIENTE''');
        ExecutaComandoSql(Aux,'comment on column MOVHISTORICOCLIENTE.D_DAT_AGE is ''DATA DA AGENDA DO CLIENTE''');
        ExecutaComandoSql(Aux,'comment on column MOVHISTORICOCLIENTE.L_HIS_AGE is ''HISTORICO DA AGENDA''');
      end;

      if VpaNumAtualizacao < 115 Then
      begin
        VpfErro := '115';
        ExecutaComandoSql(Aux,' alter table MOVHISTORICOCLIENTE '
                            +'  add foreign key CADHISTORICOCLIENTE_FK(I_COD_HIS)  '
                            +'  references CADHISTORICOCLIENTE(I_COD_HIS)  '
                            +'  on update restrict on delete restrict ');
        ExecutaComandoSql(Aux,' Update Cfg_Geral set I_Ult_Alt = 115');
      end;

      if VpaNumAtualizacao < 116 Then
      begin
        VpfErro := '116';
        ExecutaComandoSql(Aux,' alter table MOVHISTORICOCLIENTE '
                            +'  add foreign key CADCLIENTE_FK101(I_COD_CLI)  '
                            +'  references CADCLIENTES(I_COD_CLI)  '
                            +'  on update restrict on delete restrict ');
        ExecutaComandoSql(Aux,' Update Cfg_Geral set I_Ult_Alt = 116');
      end;

      if VpaNumAtualizacao < 117 Then
      begin
        VpfErro := '117';
        ExecutaComandoSql(Aux,'alter table cfg_geral'
                            +'    add L_ATU_IGN long varchar null; '
                            +'  update cfg_geral '
                            +'    set L_ATU_IGN = null; ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 117');
        ExecutaComandoSql(Aux,'comment on column cfg_geral.L_ATU_IGN is ''ATUALIZACOES IGNORADAS''');
      end;

      if VpaNumAtualizacao < 118 Then
      begin
        VpfErro := '118';
        ExecutaComandoSql(Aux,' alter table movhistoricocliente '
                            +'  add H_HOR_AGE TIME NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 118');
        ExecutaComandoSql(Aux,'comment on column movhistoricocliente.H_HOR_AGE is ''HORA AGENDADA''');
      end;

      if VpaNumAtualizacao < 119 Then
      begin
        VpfErro := '119';
        ExecutaComandoSql(Aux,' alter table movhistoricocliente '
                            +'  add C_SIT_AGE char(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 119');
        ExecutaComandoSql(Aux,'comment on column movhistoricocliente.H_HOR_AGE is ''HORA AGENDADA''');
      end;

      if VpaNumAtualizacao < 120 Then
      begin
        VpfErro := '120';
        ExecutaComandoSql(Aux,' alter table movhistoricocliente '
                            +'  add H_HOR_HIS TIME NULL  ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 120');
        ExecutaComandoSql(Aux,'comment on column movhistoricocliente.H_HOR_HIS is ''HORA HISTORICO''');
      end;

      if VpaNumAtualizacao < 121 Then
      begin
        VpfErro := '121';
        ExecutaComandoSql(Aux,' alter table movcontasareceber '
                            +'  add N_VLR_CHE numeric(17,3) NULL, '
                            +'  add C_CON_CHE char(15) NULL      ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 121');
        ExecutaComandoSql(Aux,'comment on column movcontasareceber.N_VLR_CHE is ''VALOR DO CHEQUE''');
        ExecutaComandoSql(Aux,'comment on column movcontasareceber.C_CON_CHE is ''CONTA DO CHEQUE''');
      end;

      if VpaNumAtualizacao < 122 Then
      begin
        VpfErro := '122';
        ExecutaComandoSql(Aux,'create table CADCODIGO'
                            +'   ( I_EMP_FIL INTEGER NULL, '
                            +'     I_LAN_REC INTEGER NULL, '
                            +'     I_LAN_APG INTEGER NULL, '
                            +'     I_LAN_EST INTEGER NULL, '
                            +'     I_LAN_BAC INTEGER NULL, '
                            +'     I_LAN_CON INTEGER NULL ) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 122');
      end;

      if VpaNumAtualizacao < 123 Then
      begin
        VpfErro := '123';
        ExecutaComandoSql(Aux,'alter table cfg_modulo'
                            +' add FLA_MALACLIENTE CHAR(1) NULL, '
                            +' add FLA_AGENDACLIENTE CHAR(1) NULL, '
                            +' add FLA_PEDIDO CHAR(1) NULL, '
                            +' add FLA_ORDEMSERVICO CHAR(1) NULL ' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 123');
      end;
    
      if VpaNumAtualizacao < 124 Then
      begin
        VpfErro := '124';
        ExecutaComandoSql(Aux,'alter table MOVSUMARIZAESTOQUE'
                            +'  ADD C_REL_PRO CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 124');
        ExecutaComandoSql(Aux,'comment on column MOVSUMARIZAESTOQUE.C_REL_PRO is ''BOOLEAN - INDICA SE IMPRIME NO RELATORIO DE PRODUTOS OU NAO''');
      end;
    
      if VpaNumAtualizacao < 125 Then
      begin
        VpfErro := '125';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL'
                            +'  ADD N_PER_PIS NUMERIC(6,3) null, '
                            +'  ADD N_PER_COF NUMERIC(6,3) null ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 125');
        ExecutaComandoSql(Aux,'comment on column CFG_FISCAL.N_PER_PIS is ''PERCENTUAL DO PIS''');
        ExecutaComandoSql(Aux,'comment on column CFG_FISCAL.N_PER_COF is ''PERCENTUAL DE COFINS''');
      end;

      if VpaNumAtualizacao < 126 Then
      begin
        VpfErro := '126';
        ExecutaComandoSql(Aux,'alter table MOVSUMARIZAESTOQUE'
                            +'  ADD N_VLR_VEN_LIQ NUMERIC(17,4) null ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 126');
        ExecutaComandoSql(Aux,'comment on column MOVSUMARIZAESTOQUE.N_VLR_VEN_LIQ is ''VALOR DE VENDA LIQUIDA''');
      end;

      if VpaNumAtualizacao < 128 Then
      begin
        VpfErro := '128';
        ExecutaComandoSql(Aux,'alter table MOVSUMARIZAESTOQUE'
                            +'  ADD N_VLR_GIR NUMERIC(5,2) null');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 128');
        ExecutaComandoSql(Aux,'comment on column MOVSUMARIZAESTOQUE.N_VAL_GIR is ''VALOR DO GIRO DE ESTOQUE''');
      end;
    
      if VpaNumAtualizacao < 129 Then
      begin
        VpfErro := '129';
        ExecutaComandoSql(Aux,'Alter table cadprodutos'
                            +'  add C_FLA_PRO CHAR(1) null ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 129');
        ExecutaComandoSql(Aux,'comment on column CADPRODUTOS.C_FLA_PRO is ''FLAG SE CONSIDERA O KIT COMO PRODUTO''');
      end;
    
      if VpaNumAtualizacao < 130 Then
      begin
        VpfErro := '130';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO'
                            +'  ADD C_FLA_IPI CHAR(1) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 130');
        ExecutaComandoSql(Aux,'comment on column CFG_PRODUTO.C_FLA_IPI is ''BOOLEAN - SE E PARA UTILIZAR O IPI''');
      end;
    
      if VpaNumAtualizacao < 131 Then
      begin
        VpfErro := '131';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL'
                            +'  ADD C_ALT_VNF CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 131');
      end;
    
      if VpaNumAtualizacao < 132 Then
      begin
        VpfErro := '132';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASAPAGAR'
                            +'  ADD I_FIL_NOT INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 132');
        ExecutaComandoSql(Aux,'comment on column CADCONTASAPAGAR.I_FIL_NOT is ''FILIAL DA NOTA FISCAL''');
      end;
    
      if VpaNumAtualizacao < 133 Then
      begin
        VpfErro := '133';
        ExecutaComandoSql(Aux,'alter table CFG_FINANCEIRO'
                            +'  ADD I_FIL_CON INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 133');
        ExecutaComandoSql(Aux,'comment on column CFG_FINANCEIRO.I_FIL_CON is ''FILIAL CONTROLADORA''');
      end;
    
      if VpaNumAtualizacao < 134 Then
      begin
        VpfErro := '134';
        ExecutaComandoSql(Aux,'alter table CFG_FINANCEIRO'
                            +'  ADD C_FIL_CON CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 134');
        ExecutaComandoSql(Aux,'comment on column CFG_FINANCEIRO.C_FIL_CON is ''FILIAL CONTROLADORA''');
      end;
    
      if VpaNumAtualizacao < 135 Then
      begin
        VpfErro := '135';
        ExecutaComandoSql(Aux,'alter table CFG_FISCAL'
                            +'  ADD C_PLA_VEI CHAR(10) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 135');
        ExecutaComandoSql(Aux,'comment on column CFG_FISCAL.C_PLA_VEI is ''PLACA DO VEICULO''');
      end;

      if VpaNumAtualizacao < 136 Then
      begin
        VpfErro := '136';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS'
                            +'  ADD D_ULT_FEC DATE NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 136');
        ExecutaComandoSql(Aux,'comment on column CADFILIAIS.D_ULT_FEC is ''DATA DO ULTIMO FECHAMENTO''');
      end;

      if VpaNumAtualizacao < 137 Then
      begin
        VpfErro := '137';
        ExecutaComandoSql(Aux,'create table INVENTARIO'
                            +'  (I_EMP_FIL INTEGER NOT NULL, '
                            +'  I_COD_INV  INTEGER NOT NULL, '
                            +'  I_NUM_SEQ  INTEGER NOT NULL, '
                            +'  I_SEQ_PRO INTEGER, '
                            +'  C_COD_PRO CHAR(20), '
                            +'  I_QTD_ANT Numeric(15,4), '
                            +'  I_QTD_INV Numeric(15,4), '
                            +'  N_CUS_PRO NUMERIC(15,4), '
                            +'  C_COD_UNI CHAR(2),'
                            +'  D_DAT_INV DATE, '
                            +'  PRIMARY KEY(I_EMP_FIL, I_COD_INV,I_NUM_SEQ)) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 137');
      end;

      if VpaNumAtualizacao < 138 Then
      begin
        VpfErro := '138';
        ExecutaComandoSql(Aux,'create unique index  INVENTARIO_PK ON INVENTARIO(I_EMP_FIL,I_COD_INV,I_NUM_SEQ)'
                            +'   ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 138');
      end;

      if VpaNumAtualizacao < 139 Then
      begin
        VpfErro := '139';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO '
                            +'  ADD I_INV_ENT INTEGER NULL, '
                            +'  ADD I_INV_SAI INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 139');
      end;

      if VpaNumAtualizacao < 140 Then
      begin
        VpfErro := '140';
        ExecutaComandoSql(Aux,'alter table CFG_FISCAL '
                            +'  ADD C_DUP_PNF CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 140');
      end;

      if VpaNumAtualizacao < 141 Then
      begin
        VpfErro := '141';
        ExecutaComandoSql(Aux,'alter table movnotasfiscais ' +
                          ' modify N_VLR_PRO NUMERIC(17,4)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 141');
      end;

      if VpaNumAtualizacao < 142 Then
      begin
        VpfErro := '142';
        ExecutaComandoSql(Aux,'alter table MOVORCAMENTOS ' +
                          ' modify N_VLR_PRO NUMERIC(17,4)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 142');
      end;

      if VpaNumAtualizacao < 143 Then
      begin
        VpfErro := '143';
        ExecutaComandoSql(Aux,'alter table MOVHISTORICOCLIENTE ' +
                          ' modify D_DAT_HIS null');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 143');
      end;

      if VpaNumAtualizacao < 144 Then
      begin
        VpfErro := '144';
        ExecutaComandoSql(Aux,'alter table MOVHISTORICOCLIENTE ' +
                          ' modify D_DAT_AGE null');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 144');
      end;

      if VpaNumAtualizacao < 145 Then
      begin
        VpfErro := '145';
        ExecutaComandoSql(Aux,'alter table MOVHISTORICOCLIENTE ' +
                          ' modify L_HIS_CLI null');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 145');
      end;

      if VpaNumAtualizacao < 146 Then
      begin
        VpfErro := '146';
        ExecutaComandoSql(Aux,'alter table MOVHISTORICOCLIENTE ' +
                          ' modify L_HIS_AGE null');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 146');
      end;

      if VpaNumAtualizacao < 147 Then
      begin
        VpfErro := '147';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ' +
                          ' ADD C_PRA_PRO CHAR(20) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 147');
      end;

      if VpaNumAtualizacao < 148 Then
      begin
        VpfErro := '148';
        ExecutaComandoSql(Aux,'alter table CADNOTAFISCAIS ' +
                          ' ADD C_ORD_COM CHAR(50) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 148');
      end;
      if VpaNumAtualizacao < 149 Then
      begin
        VpfErro := '149';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ' +
                          ' ADD I_LRG_PRO INTEGER NULL,'+
                          ' ADD I_CMP_PRO INTEGER NULL, '+
                          ' ADD I_CMP_FIG INTEGER NULL,'+
                          ' ADD C_NUM_FIO CHAR(20) NULL, '+
                          ' ADD C_BAT_PRO CHAR(20) NULL,'+
                          ' ADD I_COD_FUN INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 149');
      end;

      if VpaNumAtualizacao < 150 Then
      begin
        VpfErro := '150';
        ExecutaComandoSql(Aux,'create  table CADTIPOFUNDO ' +
                          ' (I_COD_FUN INTEGER  NOT NULL,'+
                          '  C_NOM_FUN CHAR(50), '+
                          ' PRIMARY KEY (I_COD_FUN))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 150');
      end;
      if VpaNumAtualizacao < 151 Then
      begin
        VpfErro := '151';
        ExecutaComandoSql(Aux,'create unique index CADTIPOFUNDO_PK ON CADTIPOFUNDO(I_COD_FUN) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 151');
      end;
      if VpaNumAtualizacao < 152 Then
      begin
        VpfErro := '152';
        ExecutaComandoSql(Aux,'Alter table CFG_PRODUTO  ADD C_IND_ETI CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 152');
      end;
      if VpaNumAtualizacao < 153 Then
      begin
        VpfErro := '153';
        ExecutaComandoSql(Aux,'update CFG_PRODUTO  set C_IND_ETI = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 153');
      end;
      if VpaNumAtualizacao < 154 Then
      begin
        VpfErro := '154';
        ExecutaComandoSql(Aux,'CREATE TABLE MAQUINA (CODMAQ INTEGER NOT NULL , '+
                              ' NOMMAQ CHAR(50),  '+
                              ' QTDFIO INTEGER, '+
                              ' INDATI CHAR(1), '+
                              ' PRIMARY KEY (CODMAQ))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MAQUINA_PK ON MAQUINA(CODMAQ)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 154');
      end;
      if VpaNumAtualizacao < 155 Then
      begin
        VpfErro := '155';
        ExecutaComandoSql(Aux,'CREATE TABLE ORDEMPRODUCAOCORPO(EMPFIL INTEGER NOT NULL , '+
                              ' SEQORD INTEGER NOT NULL,  '+
                              ' DATEMI DATETIME, '+
                              ' DATENT DATETIME, '+
                              ' DATENP DATETIME, '+
                              ' CODCLI INTEGER, '+
                              ' CODPRO INTEGER, '+
                              ' CODCOM INTEGER, '+
                              ' NUMPED INTEGER, '+
                              ' HORPRO CHAR(8), '+
                              ' CODEST INTEGER, '+
                              ' CODMAQ INTEGER, '+
                              ' TIPPED INTEGER, ' +
                              ' PRIMARY KEY (EMPFIL, SEQORD))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX ORDEMPRODUCAOCORPO_PK ON ORDEMPRODUCAOCORPO(EMPFIL,SEQORD)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 155');
      end;
      if VpaNumAtualizacao < 156 Then
      begin
        VpfErro := '156';
        ExecutaComandoSql(Aux,'CREATE TABLE ESTAGIOPRODUCAO(CODEST INTEGER NOT NULL , '+
                              ' NOMEST CHAR(50),  '+
                              ' CODTIP INTEGER, '+
                              ' PRIMARY KEY (CODEST))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX ESTAGIOPRODUCAO_PK ON ESTAGIOPRODUCAO(CODEST)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 156');
      end;
      if VpaNumAtualizacao < 157 Then
      begin
        VpfErro := '157';
        ExecutaComandoSql(Aux,'CREATE TABLE TIPOESTAGIOPRODUCAO(CODTIP INTEGER NOT NULL , '+
                              ' NOMTIP CHAR(50),  '+
                              ' PRIMARY KEY (CODTIP))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX TIPOESTAGIOPRODUCAO_PK ON TIPOESTAGIOPRODUCAO(CODTIP)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 157');
      end;
      if VpaNumAtualizacao < 158 Then
      begin
        VpfErro := '158';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ADD SEQPRO INTEGER ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 158');
      end;
      if VpaNumAtualizacao < 159 Then
      begin
        VpfErro := '159';
        ExecutaComandoSql(Aux,'CREATE INDEX ORDEMPRODUCAOCORPO_FK1 ON ORDEMPRODUCAOCORPO(CODCLI) ');
        ExecutaComandoSql(Aux,'CREATE INDEX ORDEMPRODUCAOCORPO_FK2 ON ORDEMPRODUCAOCORPO(CODEST) ');
        ExecutaComandoSql(Aux,'CREATE INDEX ORDEMPRODUCAOCORPO_FK3 ON ORDEMPRODUCAOCORPO(SEQPRO) ');
        ExecutaComandoSql(Aux,'CREATE INDEX ORDEMPRODUCAOCORPO_FK4 ON ORDEMPRODUCAOCORPO(CODMAQ) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 159');
      end;
      if VpaNumAtualizacao < 160 Then
      begin
        VpfErro := '160';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD CODEST INTEGER ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 160');
      end;
      if VpaNumAtualizacao < 161 Then
      begin
        VpfErro := '161';
        ExecutaComandoSql(Aux,'CREATE TABLE TIPOEMENDA(CODEME INTEGER NOT NULL , '+
                              ' NOMEME CHAR(50),  '+
                              ' PRIMARY KEY (CODEME))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX TIPOEMENDA_PK ON TIPOEMENDA(CODEME)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 161');
      end;
      if VpaNumAtualizacao < 162 Then
      begin
        VpfErro := '162';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ' +
                          ' ADD CODEME INTEGER NULL,'+
                          ' ADD INDCAL CHAR(1) NULL,'+
                          ' ADD INDENG CHAR(1) NULL');
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTO_TIPOEMENDA_FK ON CADPRODUTOS(CODEME)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 162');
      end;
      if VpaNumAtualizacao < 163 Then
      begin
        VpfErro := '163';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ADD METTOT NUMERIC(11,2) NULL,'+
                              ' ADD METFIT NUMERIC(11,2) NULL,'+
                              ' ADD PERACR INTEGER NULL, '+
                              ' ADD VALUNI NUMERIC(12,3) NULL, '+
                              ' ADD QTDFIT INTEGER NULL' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 163');
      end;
      if VpaNumAtualizacao < 164 Then
      begin
        VpfErro := '164';
        ExecutaComandoSql(Aux,'CREATE TABLE COMBINACAOFIGURA'+
                              ' (SEQPRO INTEGER NOT NULL,'+
                              ' CODCOM INTEGER NOT NULL,'+
                              ' SEQCOR INTEGER NOT NULL, '+
                              ' CODCOR INTEGER NOT NULL, '+
                              ' TITFIO INTEGER NULL,'+
                              ' NUMESP INTEGER NULL, '+
                              ' PRIMARY KEY (SEQPRO, CODCOM,SEQCOR))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX COMBINACAOFIGURA_PK ON COMBINACAOFIGURA(SEQPRO,CODCOM,SEQCOR)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 164');
      end;
      if VpaNumAtualizacao < 165 Then
      begin
        VpfErro := '165';
        ExecutaComandoSql(Aux,'CREATE TABLE COMBINACAO '+
                              ' (SEQPRO INTEGER NOT NULL,'+
                              ' CODCOM INTEGER NOT NULL,'+
                              ' PRIMARY KEY (SEQPRO, CODCOM))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX COMBINACAO_PK ON COMBINACAO(SEQPRO,CODCOM)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 165');
      end;
      if VpaNumAtualizacao < 166 Then
      begin
        VpfErro := '166';
        ExecutaComandoSql(Aux,'DELETE FROM COMBINACAO ');
        ExecutaComandoSql(Aux,'ALTER TABLE COMBINACAO '+
                              ' ADD CORFU1 INTEGER NOT NULL,'+
                              ' ADD CORFU2 INTEGER NOT NULL,'+
                              ' ADD TITFU1 INTEGER NOT NULL,'+
                              ' ADD TITFU2 INTEGER NOT NULL,'+
                              ' ADD CORCAR INTEGER NOT NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 166');
      end;
      if VpaNumAtualizacao < 167 Then
      begin
        VpfErro := '167';
        ExecutaComandoSql(Aux,'CREATE TABLE ORDEMPRODUCAOITEM(EMPFIL INTEGER NOT NULL , '+
                              ' SEQORD INTEGER NOT NULL,  '+
                              ' SEQITE INTEGER NOT NULL, '+
                              ' CODCOM INTEGER NOT NULL, '+
                              ' CODMAN INTEGER, '+
                              ' QTDCOM INTEGER, '+
                              ' METFIT NUMERIC(8,2), '+
                              ' PRIMARY KEY (EMPFIL, SEQORD,SEQITE))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX ORDEMPRODUCAOITEM_PK ON ORDEMPRODUCAOITEM(EMPFIL,SEQORD,SEQITE)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 167');
      end;
      if VpaNumAtualizacao < 168 Then
      begin
        VpfErro := '168';
        ExecutaComandoSql(Aux,'ALTER TABLE COMBINACAO '+
                              ' ADD ESPFU1 INTEGER NULL,'+
                              ' ADD ESPFU2 INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 168');
      end;
      if VpaNumAtualizacao < 169 Then
      begin
        VpfErro := '169';
        ExecutaComandoSql(Aux,'Alter TABLE ORDEMPRODUCAOITEM add QTDFIT INTEGER  ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 169');
      end;
      if VpaNumAtualizacao < 170 Then
      begin
        VpfErro := '170';
        ExecutaComandoSql(Aux,'Alter TABLE CADCLIENTES add I_COD_VEN INTEGER  ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 170');
      end;
      if VpaNumAtualizacao < 171 Then
      begin
        VpfErro := '171';
        ExecutaComandoSql(Aux,'Alter TABLE MAQUINA add CONKWH NUMERIC(8,4)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 171');
      end;
      if VpaNumAtualizacao < 172 Then
      begin
        VpfErro := '172';
        ExecutaComandoSql(Aux,'Alter table CFG_PRODUTO  ADD C_IND_CAR CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 172');
      end;
      if VpaNumAtualizacao < 173 Then
      begin
        VpfErro := '173';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ' +
                          ' ADD CODMAQ INTEGER NULL,'+
                          ' ADD METMIN NUMERIC(7,3) NULL,'+
                          ' ADD ENGPRO CHAR(7) NULL,'+
                          ' ADD IMPPRE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 173');
      end;
      if VpaNumAtualizacao < 174 Then
      begin
        VpfErro := '174';
        ExecutaComandoSql(Aux,'ALTER TABLE COMBINACAO '+
                              ' MODIFY TITFU1 CHAR(10) NOT NULL,'+
                              ' MODIFY TITFU2 CHAR(10) NOT NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 174');
      end;
      if VpaNumAtualizacao < 175 Then
      begin
        VpfErro := '175';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO '+
                              ' ADD C_PLA_ORC CHAR(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 175');
      end;
      if VpaNumAtualizacao < 176 Then
      begin
        VpfErro := '176';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS '+
                              ' ADD N_PER_COM INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 176');
      end;
      if VpaNumAtualizacao < 177 Then
      begin
        VpfErro := '177';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS '+
                              ' ADD I_TIP_ORC INTEGER NULL,'+
                              ' ADD C_GER_FIN CHAR(1) NULL,'+
                              ' ADD N_VLR_LIQ NUMERIC(17,4) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 177');
      end;
      if VpaNumAtualizacao < 178 Then
      begin
        VpfErro := '178';
        ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS '+
                              ' SET N_VLR_LIQ = N_VLR_TOT');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 178');
      end;
      if VpaNumAtualizacao < 179 Then
      begin
        VpfErro := '179';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER '+
                              ' ADD C_IND_CAD CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 179');
      end;
      if VpaNumAtualizacao < 180 Then
      begin
        VpfErro := '180';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO '+
                              ' ADD I_OPE_ORC INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 180');
      end;
      if VpaNumAtualizacao < 181 Then
      begin
        VpfErro := '181';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS '+
                              ' ADD C_DES_COR CHAR(20)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 181');
      end;
      if VpaNumAtualizacao < 182 Then
      begin
        VpfErro := '182';
        ExecutaComandoSql(Aux,'drop index MOVORCAMENTOS_PK ');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 182');
      end;
      if VpaNumAtualizacao < 183 Then
      begin
        VpfErro := '183';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS '+
                              ' ADD I_SEQ_MOV INTEGER NULL');
        ExecutaComandoSql(Aux,'UPDATE MOVORCAMENTOS '+
                              ' SET I_SEQ_MOV = I_SEQ_PRO');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS '+
                              ' MODIFY I_SEQ_MOV NOT NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 183');
      end;
      if VpaNumAtualizacao < 184 Then
      begin
        VpfErro := '184';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS '+
                              ' ADD PRIMARY KEY(I_EMP_FIL,I_LAN_ORC,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 184');
      end;
      if VpaNumAtualizacao < 185 Then
      begin
        VpfErro := '185';
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MOVORCAMENTOS_PK ON MOVORCAMENTOS(I_EMP_FIL,I_LAN_ORC,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 185');
      end;
      if VpaNumAtualizacao < 186 Then
      begin
        VpfErro := '186';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD C_ORD_COM CHAR(20) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 186');
      end;
      if VpaNumAtualizacao < 187 Then
      begin
        VpfErro := '187';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS '+
                              ' ADD C_DES_COR CHAR(20)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 187');
      end;
      if VpaNumAtualizacao < 188 Then
      begin
        VpfErro := '188';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES '+
                              ' ADD I_COD_PAG INTEGER NULL, '+
                              ' ADD I_FRM_PAG INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 188');
      end;
      if VpaNumAtualizacao < 189 Then
      begin
        VpfErro := '189';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES '+
                              ' ADD I_PER_COM INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 189');
      end;
      if VpaNumAtualizacao < 190 Then
      begin
        VpfErro := '190';
        ExecutaComandoSql(Aux,'CREATE TABLE COR '+
                              ' (COD_COR INTEGER NOT NULL, '+
                              ' NOM_COR CHAR(50) , '+
                              ' PRIMARY KEY(COD_COR))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 190');
      end;
      if VpaNumAtualizacao < 191 Then
      begin
        VpfErro := '191';
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX COR_PK ON COR(COD_COR) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 191');
      end;
      if VpaNumAtualizacao < 192 Then
      begin
        VpfErro := '192';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ' +
                              ' ADD I_COD_COR INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 192');
      end;
      if VpaNumAtualizacao < 193 Then
      begin
        VpfErro := '193';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO '+
                              ' ADD C_EST_COR CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 193');
      end;
      if VpaNumAtualizacao < 194 Then
      begin
        VpfErro := '194';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS '+
                              ' ADD I_COD_COR INTEGER  NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 194');
      end;
      if VpaNumAtualizacao < 195 Then
      begin
        VpfErro := '195';
        ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS '+
                              ' SET C_FLA_SIT = ''A'''+
                              ' where c_fla_sit <> ''A'''+
                              ' AND C_FLA_SIT <> ''E'''+
                              ' AND C_FLA_SIT <> ''C''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 195');
      end;
      if VpaNumAtualizacao < 196 Then
      begin
        VpfErro := '196';
        ExecutaComandoSql(Aux,'Alter table MOVNOTASFISCAIS MODIFY C_COD_CST CHAR(3)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 196');
      end;
      if VpaNumAtualizacao < 197 Then
      begin
        VpfErro := '197';
        ExecutaComandoSql(Aux,'Alter table COMBINACAOFIGURA MODIFY TITFIO CHAR(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 197');
      end;
      if VpaNumAtualizacao < 198 Then
      begin
        VpfErro := '198';
        ExecutaComandoSql(Aux,'Alter table CADNOTAFISCAIS ADD C_FIN_GER CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 198');
      end;
      if VpaNumAtualizacao < 199 Then
      begin
        VpfErro := '199';
        ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS SET C_FIN_GER = ''N''');
        ExecutaComandoSql(Aux,'UPDATE CADNOTAFISCAIS SET C_FIN_GER = ''S'''+
                              ' WHERE C_COD_NAT LIKE ''51%'''+
                              ' OR C_COD_NAT LIKE ''61%''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 199');
      end;
      if VpaNumAtualizacao < 200 Then
      begin
        VpfErro := '200';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO '+
                              ' ADD C_LIM_CRE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 200');
      end;
      if VpaNumAtualizacao < 201 Then
      begin
        VpfErro := '201';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO '+
                              ' ADD C_BLO_CAT CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 201');
      end;
      if VpaNumAtualizacao < 202 Then
      begin
        VpfErro := '202';
        ExecutaComandoSql(Aux,'Update CFG_FINANCEIRO '+
                              ' set C_BLO_CAT = ''F'', C_LIM_CRE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 202');
      end;
      if VpaNumAtualizacao < 203 Then
      begin
        VpfErro := '203';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO '+
                              ' ADD ORDCLI INTEGER  NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 203');
      end;
      if VpaNumAtualizacao < 204 Then
      begin
        VpfErro := '204';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_FISCAL ' +
                              ' ADD C_PED_PRE CHAR(1) ');
        ExecutaComandoSql(Aux,' UPDATE CFG_FISCAL ' +
                              ' SET C_PED_PRE = ''F'' ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 204');
      end;
      if VpaNumAtualizacao < 205 Then
      begin
        VpfErro := '205';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_FISCAL ' +
                              ' ADD C_MAR_PRO CHAR(50), '+
                              ' ADD I_COD_TRA INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 205');
      end;
      if VpaNumAtualizacao < 206 Then
      begin
        VpfErro := '206';
        ExecutaComandoSql(Aux,' ALTER TABLE CAD_DOC ' +
                              ' ADD I_MAX_ITE INTEGER NULL ');
        ExecutaComandoSql(Aux,' Update CAD_DOC set I_MAX_ITE = 40');
        ExecutaComandoSql(Aux,' Update CFG_GERAL set I_Ult_Alt = 206');
      end;
      if VpaNumAtualizacao < 207 Then
      begin
        VpfErro := '207';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_FISCAL ' +
                              ' ADD I_PED_PAD INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 207');
      end;
      if VpaNumAtualizacao < 208 Then
      begin
        VpfErro := '208';
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD I_COD_TRA integer NULL ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD C_PLA_VEI varchar(10) ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD C_EST_VEI char(2) ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD N_QTD_TRA NUMERIC(11,3) ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD C_ESP_TRA varchar(30) ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD C_MAR_TRA varchar(30) ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD I_NRO_TRA integer ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD N_PES_BRU NUMERIC(11,3) ');
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' ADD N_PES_LIQ NUMERIC(11,3) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 208');
      end;
      if VpaNumAtualizacao < 209 Then
      begin
        VpfErro := '209';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_FISCAL ' +
                              ' ADD C_TRA_PED CHAR(1) ');
        ExecutaComandoSql(Aux,' UPDATE CFG_FISCAL ' +
                              ' SET C_TRA_PED = ''F'' ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 209');
      end;
      if VpaNumAtualizacao < 210 Then
      begin
        VpfErro := '210';
        ExecutaComandoSql(Aux,' ALTER TABLE CADCLIENTES '+
                              ' MODIFY I_PER_COM NUMERIC(8,3) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 210');
      end;
      if VpaNumAtualizacao < 211 Then
      begin
        VpfErro := '211';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_FISCAL '+
                              ' ADD C_NAT_FOE CHAR(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 211');
      end;
      if VpaNumAtualizacao < 212 Then
      begin
        VpfErro := '212';
        ExecutaComandoSql(Aux,' ALTER TABLE CADPRODUTOS '+
                              ' ADD N_PES_LIQ NUMERIC(10,5) NULL,'+
                              ' ADD N_PES_BRU NUMERIC(10,5) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 212');
      end;
      if VpaNumAtualizacao < 213 Then
      begin
        VpfErro := '213';
        ExecutaComandoSql(Aux,' CREATE TABLE CADTIPOORCAMENTO ( '+
                              ' I_COD_TIP INTEGER NOT NULL, '+
                              ' C_NOM_TIP CHAR(50), '+
                              ' C_CLA_PLA CHAR(10), '+
                              ' I_COD_OPE INTEGER, '+
                              ' PRIMARY KEY (I_COD_TIP))');
        ExecutaComandoSql(Aux,'Create unique index CADTIPOORCAMENTO_PK on CADTIPOORCAMENTO(I_COD_TIP)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 213');
      end;
      if VpaNumAtualizacao < 214 Then
      begin
        VpfErro := '214';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_PRODUTO '+
                              ' DROP I_OPE_ORC ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 214');
      end;
      if VpaNumAtualizacao < 215 Then
      begin
        VpfErro := '215';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_FINANCEIRO '+
                              ' DROP C_PLA_ORC ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 215');
      end;
      if VpaNumAtualizacao < 216 Then
      begin
        VpfErro := '216';
        ExecutaComandoSql(Aux,' CREATE TABLE LOG'+
                              ' (SEQ_LOG INTEGER NOT NULL, '+
                              ' DAT_LOG DATETIME NOT NULL ,'+
                              ' COD_USUARIO INTEGER NOT NULL,'+
                              ' DES_LOG CHAR(20),'+
                              ' NOM_TABELA CHAR(50),'+
                              ' NOM_CAMPO CHAR(50),'+
                              ' VAL_ANTERIOR CHAR(100),'+
                              ' VAL_ATUAL  CHAR(100),' +
                              ' NOM_MODULO_SISTEMA CHAR(30), '+
                              ' PRIMARY KEY (SEQ_LOG))');
        ExecutaComandoSql(Aux,'Create UNIQUE INDEX LOG_PK on LOG(SEQ_LOG)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 216');
      end;
      if VpaNumAtualizacao < 217 Then
      begin
        VpfErro := '217';
        ExecutaComandoSql(Aux,' ALTER TABLE CFG_PRODUTO '+
                              ' ADD I_TIP_ORC INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 217');
      end;
      if VpaNumAtualizacao < 218 Then
      begin
        VpfErro := '218';
        ExecutaComandoSql(Aux,' CREATE TABLE RAMO_ATIVIDADE ('+
                              ' COD_RAMO_ATIVIDADE INTEGER NOT NULL, '+
                              ' NOM_RAMO_ATIVIDADE CHAR(50),'+
                              ' PRIMARY KEY (COD_RAMO_ATIVIDADE))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX RAMO_ATIVIDADE_PK ON RAMO_ATIVIDADE(COD_RAMO_ATIVIDADE)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 218');
      end;
      if VpaNumAtualizacao < 219 Then
      begin
        VpfErro := '219';
        ExecutaComandoSql(Aux,' ALTER TABLE CADCLIENTES '+
                              ' ADD I_COD_RAM INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 219');
      end;
      if VpaNumAtualizacao < 220 Then
      begin
        VpfErro := '220';
        ExecutaComandoSql(Aux,' ALTER TABLE MOVCONTASARECEBER '+
                              ' ADD C_DUP_DES CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 220');
      end;
      if VpaNumAtualizacao < 221 Then
      begin
        VpfErro := '221';
        ExecutaComandoSql(Aux,' alter table CFG_FINANCEIRO ' +
                              ' add C_TIP_BOL char(1) null ');
        ExecutaComandoSql(Aux,' update cfg_financeiro set C_TIP_BOL = ''P'' ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 221');
      end;
      if VpaNumAtualizacao < 222 Then
      begin
        VpfErro := '222';
        ExecutaComandoSql(Aux,' alter table CADORCAMENTOS ' +
                              ' MODIFY N_PER_COM NUMERIC(8,3) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 222');
      end;
      if VpaNumAtualizacao < 223 Then
      begin
        VpfErro := '223';
        ExecutaComandoSql(Aux,' alter table CADCONTASARECEBER ' +
                              ' ADD C_IND_CON CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 223');
      end;
      if VpaNumAtualizacao < 224 Then
      begin
        VpfErro := '224';
        ExecutaComandoSql(Aux,' UPDATE CADORCAMENTOS '+
                              ' SET I_TIP_ORC = 1 '+
                              ' Where I_TIP_ORC is null');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 224');
      end;
      if VpaNumAtualizacao < 225 Then
      begin
        VpfErro := '225';
        ExecutaComandoSql(Aux,' UPDATE CADORCAMENTOS '+
                              ' SET I_TIP_ORC = 1 '+
                              ' Where I_TIP_ORC = 0');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 225');
      end;
      if VpaNumAtualizacao < 226 Then
      begin
        VpfErro := '226';
        ExecutaComandoSql(Aux,' ALTER TABLE MOVCONTASARECEBER '+
                              ' ADD N_VLR_BRU NUMERIC(17,2) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 226');
      end;
      if VpaNumAtualizacao < 227 Then
      begin
        VpfErro := '227';
        ExecutaComandoSql(Aux,' ALTER TABLE CADCLIENTES '+
                              ' ADD C_NOM_FAN CHAR(50) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 227');
      end;
      if VpaNumAtualizacao < 228 Then
      begin
        VpfErro := '228';
        ExecutaComandoSql(Aux,' ALTER TABLE ORDEMPRODUCAOITEM '+
                              ' modify CODMAN CHAR(15) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 228');
      end;
      if VpaNumAtualizacao < 229 Then
      begin
        VpfErro := '229';
        ExecutaComandoSql(Aux,' CREATE TABLE MOVCONTACONSOLIDADACR '+
                              ' (I_EMP_FIL INTEGER NOT NULL, '+
                              '  I_REC_PAI INTEGER NOT NULL, '+
                              '  I_LAN_REC INTEGER NOT NULL, '+
                              '  I_NRO_PAR INTEGER NOT NULL,' +
                              '  PRIMARY KEY (I_EMP_FIL, I_REC_PAI, I_LAN_REC, I_NRO_PAR))' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 229');
      end;
      if VpaNumAtualizacao < 230 Then
      begin
        VpfErro := '230';
        ExecutaComandoSql(Aux,' CREATE UNIQUE INDEX MOVCONTACONSOLIDADACR_PK ON MOVCONTACONSOLIDADACR(I_EMP_FIL,I_REC_PAI,I_LAN_REC, I_NRO_PAR)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 230');
      end;
      if VpaNumAtualizacao < 231 Then
      begin
        VpfErro := '231';
        ExecutaComandoSql(Aux,' Alter table CFG_GERAL ADD D_CLI_PED Datetime');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 231');
      end;
      if VpaNumAtualizacao < 232 Then
      begin
        VpfErro := '232';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASAPAGAR '+
                              ' ADD C_IND_CAD CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 232');
      end;
      if VpaNumAtualizacao < 233 Then
      begin
        VpfErro := '233';
        ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES '+
                              ' ADD C_IND_ATI CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 233');
      end;
      if VpaNumAtualizacao < 234 Then
      begin
        VpfErro := '234';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES '+
                              ' ADD N_COD_EAN NUMERIC(15) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 234');
      end;
      if VpaNumAtualizacao < 235 Then
      begin
        VpfErro := '235';
        ExecutaComandoSql(Aux,'UPDATE CADVENDEDORES SET C_IND_ATI = ''S''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 235');
      end;
      if VpaNumAtualizacao < 236 Then
      begin
        VpfErro := '236';
        ExecutaComandoSql(Aux,'ALTER TABLE MAQUINA ADD QTDRPM INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 236');
      end;
      if VpaNumAtualizacao < 237 Then
      begin
        VpfErro := '237';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ADD DESOBS CHAR(750) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 237');
      end;
      if VpaNumAtualizacao < 238 Then
      begin
        VpfErro := '238';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO ADD I_COD_CLI INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 238');
      end;
      if VpaNumAtualizacao < 239 Then
      begin
        VpfErro := '239';
        ExecutaComandoSql(Aux,'UPDATE MOVTABELAPRECO SET I_COD_CLI = 0');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 239');
      end;
      if VpaNumAtualizacao < 240 Then
      begin
        VpfErro := '240';
        ExecutaComandoSql(Aux,'DROP INDEX MOVTABELAPRECO_PK');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO DELETE PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO MODIFY I_COD_CLI INTEGER NOT NULL');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO ADD PRIMARY KEY(I_COD_EMP,I_COD_TAB,I_SEQ_PRO,I_COD_CLI)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 240');
      end;
      if VpaNumAtualizacao < 241 Then
      begin
        VpfErro := '241';
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MOVTABELAPRECO_PK ON MOVTABELAPRECO(I_COD_EMP,I_COD_TAB,I_SEQ_PRO,I_COD_CLI)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 241');
      end;
      if VpaNumAtualizacao < 242 Then
      begin
        VpfErro := '242';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ADD UNMPED CHAR(2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 242');
      end;
      if VpaNumAtualizacao < 243 Then
      begin
        VpfErro := '243';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_PRC_AUT CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_PRC_AUT = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 243');
      end;
      if VpaNumAtualizacao < 244 Then
      begin
        VpfErro := '244';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ADD TIPTEA INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 244');
      end;
      if VpaNumAtualizacao < 245 Then
      begin
        VpfErro := '245';
        ExecutaComandoSql(Aux,'CREATE TABLE EMBALAGEM ( '+
                              ' COD_EMBALAGEM INTEGER NOT NULL, '+
                              ' NOM_EMBALAGEM CHAR(50),'+
                              ' PRIMARY KEY (COD_EMBALAGEM))');
        ExecutaComandoSql(Aux,'Create unique INDEX EMBALAGEM_PK ON EMBALAGEM(COD_EMBALAGEM)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 245');
      end;
      if VpaNumAtualizacao < 246 Then
      begin
        VpfErro := '246';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS  '+
                              ' ADD I_COD_EMB INTEGER NULL,'+
                              ' ADD C_DES_EMB CHAR(50)NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 246');
      end;
      if VpaNumAtualizacao < 247 Then
      begin
        VpfErro := '247';
        ExecutaComandoSql(Aux,'CREATE TABLE VENDA_PAO_DE_ACUCAR ( '+
                              ' COD_FILIAL NUMERIC(15,0) NOT NULL,'+
                              ' NOM_FILIAL CHAR(50) NULL,' +
                              ' QTD_COMPRADO NUMERIC(15,3),'+
                              ' QTD_VENDIDO NUMERIC(15,3),'+
                              ' PRIMARY KEY (COD_FILIAL))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX VENDA_PAO_DE_ACUCAR_PK ON VENDA_PAO_DE_ACUCAR(COD_FILIAL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 247');
      end;
      if VpaNumAtualizacao < 248 Then
      begin
        VpfErro := '248';
        ExecutaComandoSql(Aux,'CREATE TABLE VENDA_PAO_DE_ACUCAR_ITEM ( '+
                              ' COD_FILIAL NUMERIC(15,0) NOT NULL,'+
                              ' COD_PRODUTO NUMERIC(15,0) NOT NULL,'+
                              ' NOM_PRODUTO CHAR(50) NULL,' +
                              ' QTD_COMPRADO NUMERIC(15,3),'+
                              ' QTD_VENDIDO NUMERIC(15,3),'+
                              ' PRIMARY KEY (COD_FILIAL,COD_PRODUTO))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX VENDA_PAO_DE_ACUCAR_ITEM_PK ON VENDA_PAO_DE_ACUCAR_ITEM(COD_FILIAL,COD_PRODUTO)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 248');
      end;
      if VpaNumAtualizacao < 249 Then
      begin
        VpfErro := '249';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS '+
                              ' ADD C_ADM_SIS CHAR(1) NULL,'+
                              ' ADD C_FIN_COM CHAR(1) NULL,'+
                              ' ADD C_EST_COM CHAR(1) NULL,'+
                              ' ADD C_POL_COM CHAR(1) NULL,'+
                              ' ADD C_FAT_COM CHAR(1) NULL,'+
                              ' ADD C_FIN_CCR CHAR(1) NULL,'+
                              ' ADD C_FIN_BCR CHAR(1) NULL,'+
                              ' ADD C_FIN_CCP CHAR(1) NULL,'+
                              ' ADD C_FIN_BCP CHAR(1) NULL,'+
                              ' ADD C_POL_IPP CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 249');
      end;
      if VpaNumAtualizacao < 250 Then
      begin
        VpfErro := '250';
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS '+
                              ' SET C_ADM_SIS = ''F'','+
                              '  C_FIN_COM = ''F'','+
                              '  C_EST_COM = ''F'','+
                              '  C_POL_COM = ''F'','+
                              '  C_FAT_COM = ''F'','+
                              '  C_FIN_CCR = ''F'','+
                              '  C_FIN_BCR = ''F'','+
                              '  C_FIN_CCP = ''F'','+
                              '  C_FIN_BCP = ''F'','+
                              '  C_POL_IPP = ''F''');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS '+
                              ' SET C_ADM_SIS = ''T'','+
                              '  C_FIN_COM = ''T'','+
                              '  C_EST_COM = ''T'','+
                              '  C_POL_COM = ''T'','+
                              '  C_FAT_COM = ''T'','+
                              '  C_FIN_CCR = ''T'','+
                              '  C_FIN_BCR = ''T'','+
                              '  C_FIN_CCP = ''T'','+
                              '  C_FIN_BCP = ''T'','+
                              '  C_POL_IPP = ''T'''+
                              ' Where I_COD_GRU = 1');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 250');
      end;
      if VpaNumAtualizacao < 251 Then
      begin
        VpfErro := '251';
        ExecutaComandoSql(Aux,'DROP TABLE CFG_FAIXA_CADASTRO');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 251');
      end;
      if VpaNumAtualizacao < 252 Then
      begin
        VpfErro := '252';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ADD C_ORP_IMP CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 252');
      end;
      if VpaNumAtualizacao < 253 Then
      begin
        VpfErro := '253';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ' +
                          ' MODIFY METMIN NUMERIC(12,3) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 253');
      end;
      if VpaNumAtualizacao < 254 Then
      begin
        VpfErro := '254';
        ExecutaComandoSql(Aux,'CREATE TABLE COLETAOPCORPO( EMPFIL INTEGER NOT NULL, ' +
                              ' SEQORD INTEGER NOT NULL, '+
                              ' SEQCOL INTEGER NOT NULL, '+
                              ' DATCOL DATETIME NOT NULL,'+
                              ' INDFIN CHAR(1) NULL, '+
                              ' INDREP CHAR(1) NULL, '+
                              ' CODUSU INTEGER NOT NULL, '+
                              ' PRIMARY KEY (EMPFIL,SEQORD,SEQCOL))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX COLETAOPCORPO_PK ON COLETAOPCORPO(EMPFIL,SEQORD,SEQCOL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 254');
      end;
      if VpaNumAtualizacao < 255 Then
      begin
        VpfErro := '255';
        ExecutaComandoSql(Aux,'CREATE TABLE COLETAOPITEM(EMPFIL INTEGER NOT NULL , '+
                              ' SEQORD INTEGER NOT NULL,  '+
                              ' SEQCOL INTEGER NOT NULL, '+
                              ' SEQITE INTEGER NOT NULL, '+
                              ' CODCOM INTEGER NOT NULL, '+
                              ' CODMAN INTEGER, '+
                              ' NROFIT INTEGER, '+
                              ' METPRO NUMERIC(14,2), '+
                              ' METCOL NUMERIC(14,2), '+
                              ' METAPR NUMERIC(14,2), '+
                              ' METFAL NUMERIC(14,2), '+
                              ' PRIMARY KEY (EMPFIL, SEQORD,SEQCOL,SEQITE))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX COLETAOPITEM_PK ON COLETAOPITEM(EMPFIL,SEQORD,SEQCOL,SEQITE)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 255');
      end;
      if VpaNumAtualizacao < 256 Then
      begin
        VpfErro := '256';
        ExecutaComandoSql(Aux,'CREATE TABLE PRODUTO_REFERENCIA(SEQ_PRODUTO INTEGER NOT NULL , '+
                              ' COD_CLIENTE INTEGER NOT NULL , '+
                              ' SEQ_REFERENCIA INTEGER NOT NULL,  '+
                              ' COD_COR INTEGER, '+
                              ' DES_REFERENCIA CHAR(50), '+
                              ' COD_PRODUTO CHAR(20), '+
                              ' PRIMARY KEY (SEQ_PRODUTO,COD_CLIENTE,SEQ_REFERENCIA))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX PRODUTO_REFERENCIA_PK ON PRODUTO_REFERENCIA(SEQ_PRODUTO,COD_CLIENTE,SEQ_REFERENCIA)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 256');
      end;

      if VpaNumAtualizacao < 257 Then
      begin
        VpfErro := '257';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOITEM '+
                              ' ADD QTDPRO NUMERIC(14,2), '+
                              ' ADD QTDFAL NUMERIC(14,2)');
        ExecutaComandoSql(Aux,'Update ORDEMPRODUCAOITEM SET QTDFAL = METFIT');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 257');
      end;
      if VpaNumAtualizacao < 258 Then
      begin
        VpfErro := '258';
        ExecutaComandoSql(Aux,'ALTER TABLE COLETAOPCORPO '+
                              ' ADD QTDTOT NUMERIC(14,2)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 258');
      end;
      if VpaNumAtualizacao < 259 Then
      begin
        VpfErro := '259';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS '+
                              ' ADD C_PEN_PRO CHAR(20)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 259');
      end;
      if VpaNumAtualizacao < 260 Then
      begin
        VpfErro := '260';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_EXI_DAP CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_EXI_DAP = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 260');
      end;
      if VpaNumAtualizacao < 261 Then
      begin
        VpfErro := '261';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD C_PRO_REF CHAR(50) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 261');
      end;
      if VpaNumAtualizacao < 262 Then
      begin
        VpfErro := '262';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS ADD C_PRO_REF CHAR(50) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 262');
      end;
      if VpaNumAtualizacao < 263 Then
      begin
        VpfErro := '263';
        ExecutaComandoSql(Aux,'CREATE TABLE MOVNOTAORCAMENTO ('+
                              ' I_EMP_FIL INTEGER NOT NULL, '+
                              ' I_SEQ_NOT INTEGER NOT NULL,'+
                              ' I_LAN_ORC INTEGER NOT NULL,'+
                              ' PRIMARY KEY(I_EMP_FIL,I_SEQ_NOT,I_LAN_ORC))');
        ExecutaComandoSql(Aux,'create unique index MOVNOTAORCAMENTO_PK ON MOVNOTAORCAMENTO(I_EMP_FIL, I_SEQ_NOT,I_LAN_ORC)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 263');
      end;
      if VpaNumAtualizacao < 264 Then
      begin
        VpfErro := '264';
        ExecutaComandoSql(Aux,' ALTER TABLE COLETAOPITEM '+
                              ' modify CODMAN CHAR(15) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 264');
      end;
      if VpaNumAtualizacao < 265 Then
      begin
        VpfErro := '265';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO'
                            +'  ADD C_EXC_CNF CHAR(1) NULL ');
        ExecutacomandoSql(Aux,'Update CFG_PRODUTO SET C_EXC_CNF = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 265');
      end;
      if VpaNumAtualizacao < 266 Then
      begin
        VpfErro := '266';
        ExecutaComandoSql(Aux,'CREATE TABLE ROMANEIOCORPO(EMPFIL INTEGER NOT NULL,'+
                             ' SEQROM INTEGER NOT NULL,'+
                             ' DATINI DATETIME, '+
                             ' DATFIM DATETIME, '+
                             ' NOTGER CHAR(1),'+
                             ' INDIMP CHAR(1),'+
                             ' PRIMARY KEY(EMPFIL, SEQROM))');
        ExecutacomandoSql(Aux,'CREATE UNIQUE INDEX ROMANEIOCORPO_PK ON ROMANEIOCORPO(EMPFIL,SEQROM)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 266');
      end;
      if VpaNumAtualizacao < 267 Then
      begin
        VpfErro := '267';
        ExecutaComandoSql(Aux,'CREATE TABLE ROMANEIOITEM(EMPFIL INTEGER NOT NULL,'+
                             ' SEQROM INTEGER NOT NULL,'+
                             ' SEQORD INTEGER NOT NULL, '+
                             ' SEQCOL INTEGER NOT NULL,'+
                             ' PRIMARY KEY(EMPFIL, SEQROM,SEQORD,SEQCOL))');
        ExecutacomandoSql(Aux,'CREATE UNIQUE INDEX ROMANEIOITEM_PK ON ROMANEIOITEM(EMPFIL,SEQROM,SEQORD,SEQCOL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 267');
      end;
      if VpaNumAtualizacao < 268 Then
      begin
        VpfErro := '268';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD I_SEQ_ROM INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 268');
      end;
      if VpaNumAtualizacao < 269 Then
      begin
        VpfErro := '269';
        ExecutaComandoSql(Aux,'ALTER TABLE COLETAOPCORPO ADD INDROM CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update COLETAOPCORPO SET INDROM = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 269');
      end;
      if VpaNumAtualizacao < 270 Then
      begin
        VpfErro := '270';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVKIT'
                            +'  ADD I_COD_COR INTEGER NULL, '+
                             ' ADD C_COD_UNI CHAR(2) NULL,'+
                             ' ADD I_SEQ_MOV INTEGER NULL');
        ExecutaComandoSql(Aux,'Update MOVKIT SET I_SEQ_MOV = 1');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVKIT MODIFY I_SEQ_MOV INTEGER NOT NULL');
        ExecutaComandoSql(Aux,'DROP INDEX MOVKIT_PK');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVKIT drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVKIT '+
                              ' ADD PRIMARY KEY(I_PRO_KIT,I_SEQ_PRO,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MOVKIT_PK ON MOVKIT(I_PRO_KIT,I_SEQ_PRO,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 270');
        ExecutaComandoSql(Aux,'comment on column MOVKIT.I_COD_COR is ''CODIGO DA COR''');
      end;
      if VpaNumAtualizacao < 271 Then
      begin
        VpfErro := '271';
        ExecutaComandoSql(Aux,'update movkit mov ' +
                              ' set C_COD_UNI = (SELECT C_COD_UNI FROM CADPRODUTOS PRO WHERE PRO.I_SEQ_PRO = MOV.I_SEQ_PRO)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 271');
      end;
      if VpaNumAtualizacao < 272 Then
      begin
        VpfErro := '272';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR ADD I_COD_COR INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 272');
      end;
      if VpaNumAtualizacao < 273 Then
      begin
        VpfErro := '273';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO'
                            +'  ADD I_COD_COR INTEGER NULL');
        ExecutaComandoSql(Aux,'Update MOVQDADEPRODUTO SET I_COD_COR = 0');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO MODIFY I_COD_COR INTEGER NOT NULL');
        ExecutaComandoSql(Aux,'DROP INDEX MOVQDADEPRODUTO_PK');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO '+
                              ' ADD PRIMARY KEY(I_EMP_FIL,I_SEQ_PRO,I_COD_COR)');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MOVQDADEPRODUTO_PK ON MOVQDADEPRODUTO(I_EMP_FIL,I_SEQ_PRO,I_COD_COR)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 273');
      end;
      if VpaNumAtualizacao < 274 Then
      begin
        VpfErro := '274';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL '
                            +'  ADD C_OPT_SIM CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_OPT_SIM = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 274');
      end;
      if VpaNumAtualizacao < 275 Then
      begin
        VpfErro := '275';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR '
                            +' ADD N_PER_DES NUMERIC(15,3) NULL, '+
                            '  ADD C_CLA_PLA CHAR(10) NULL, ' +
                            '  ADD I_COD_FRM INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 275');
      end;
      if VpaNumAtualizacao < 276 Then
      begin
        VpfErro := '276';
        ExecutaComandoSql(Aux,'DROP INDEX MOVNOTASFISCAISFOR_PK');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR '+
                              ' ADD PRIMARY KEY(I_EMP_FIL,I_SEQ_NOT,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MOVNOTASFISCAISFOR_PK ON MOVNOTASFISCAISFOR(I_EMP_FIL,I_SEQ_NOT,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 276');
      end;
      if VpaNumAtualizacao < 277 Then
      begin
        VpfErro := '277';
        ExecutaComandoSql(Aux,'delete from CADPRODUTOS Where C_COD_PRO = ''6054218''');
        ExecutaComandoSql(Aux,'delete from CADPRODUTOS Where C_COD_PRO = ''6062326''');
        ExecutaComandoSql(Aux,'delete from CADPRODUTOS Where C_COD_PRO = ''6062377''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 277');
      end;
      if VpaNumAtualizacao < 278 Then
      begin
        VpfErro := '278';
        ExecutaComandoSql(Aux,'DROP INDEX MOVQDADEPRODUTO_PK2');
        ExecutaComandoSql(Aux,'DROP INDEX MOVQDADEPRODUTO_PK3');
        ExecutaComandoSql(Aux,'DROP INDEX MOVQDADEPRODUTO_PK4');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 278');
      end;
      if VpaNumAtualizacao < 279 Then
      begin
        VpfErro := '279';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS '+
                              ' DROP N_PER_ACR ');
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS '+
                              ' ADD N_VLR_DES NUMERIC(15,3)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 279');
      end;
      if VpaNumAtualizacao < 280 Then
      begin
        VpfErro := '280';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVESTOQUEPRODUTOS '+
                              ' ADD I_COD_COR INTEGER NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 280');
      end;
      if VpaNumAtualizacao < 281 Then
      begin
        VpfErro := '281';
        ExecutaComandoSql(Aux,'DROP TABLE INVENTARIO');
        ExecutaComandoSql(Aux,'DROP TABLE CADINVENTARIO');
        ExecutaComandoSql(Aux,'DROP TABLE MOVINVENTARIO');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 281');
      end;
      if VpaNumAtualizacao < 282 Then
      begin
        VpfErro := '282';
        ExecutaComandoSql(Aux,'CREATE TABLE INVENTARIOCORPO( '+
                              ' COD_FILIAL INTEGER NOT NULL, '+
                              ' SEQ_INVENTARIO INTEGER NOT NULL, '+
                              ' COD_USUARIO INTEGER , '+
                              ' DAT_INICIO DATETIME, '+
                              ' DAT_FIM DATETIME,'+
                              ' PRIMARY KEY(COD_FILIAL,SEQ_INVENTARIO))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX INVENTARIOCORPO_PK ON INVENTARIOCORPO(COD_FILIAL,SEQ_INVENTARIO)');
        ExecutaComandoSql(Aux,'CREATE TABLE INVENTARIOITEM( '+
                              ' COD_FILIAL INTEGER NOT NULL, '+
                              ' SEQ_INVENTARIO INTEGER NOT NULL, '+
                              ' SEQ_ITEM INTEGER NOT NULL, '+
                              ' SEQ_PRODUTO INTEGER, '+
                              ' COD_COR INTEGER, '+
                              ' DAT_INVENTARIO DATETIME , '+
                              ' COD_UNIDADE CHAR(2),'+
                              ' QTD_PRODUTO NUMERIC(15,3),'+
                              ' COD_USUARIO INTEGER, '+
                              ' COD_PRODUTO CHAR(20), '+
                              ' PRIMARY KEY(COD_FILIAL,SEQ_INVENTARIO,SEQ_ITEM))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX INVENTARIOITEM_PK ON INVENTARIOITEM(COD_FILIAL,SEQ_INVENTARIO,SEQ_ITEM)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 282');
      end;
      if VpaNumAtualizacao < 283 Then
      begin
        VpfErro := '283';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES '+
                              ' ADD N_PER_DES NUMERIC(10,3)NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 283');
      end;
      if VpaNumAtualizacao < 284 Then
      begin
        VpfErro := '284';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS '+
                              ' ADD I_TAB_GRA INTEGER NULL,'+
                              ' ADD I_TAB_PED INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 284');
      end;
      if VpaNumAtualizacao < 285 Then
      begin
        VpfErro := '285';
        ExecutaComandoSql(Aux,'CREATE TABLE MOTIVOREPROGRAMACAO( '+
                              ' COD_MOTIVO INTEGER NOT NULL,'+
                              ' NOM_MOTIVO CHAR(50),'+
                              ' PRIMARY KEY (COD_MOTIVO))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 285');
      end;
      if VpaNumAtualizacao < 286 Then
      begin
        VpfErro := '286';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO '+
                              ' ADD CODMOT INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 286');
      end;
      if VpaNumAtualizacao < 287 Then
      begin
        VpfErro := '287';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL '+
                              ' ADD C_NNF_FIL CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_NNF_FIL = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 287');
      end;
      if VpaNumAtualizacao < 288 Then
      begin
        VpfErro := '288';
        ExecutaComandoSql(Aux,'CREATE TABLE OPITEMCADARCO( '+
                              ' EMPFIL INTEGER NOT NULL, '+
                              ' SEQORD INTEGER NOT NULL, '+
                              ' SEQITE INTEGER NOT NULL, '+
                              ' SEQPRO INTEGER NOT NULL, '+
                              ' CODCOR INTEGER NULL, '+
                              ' GROPRO INTEGER NULL, '+
                              ' QTDFUS INTEGER NULL, '+
                              ' NROFIO INTEGER NULL, '+
                              ' NROMAQ INTEGER NULL, '+
                              ' CODPRO CHAR(20) NULL, '+
                              ' INDALG CHAR(1) NULL, '+
                              ' INDPOL CHAR(1) NULL, '+
                              ' DESENG CHAR(15) NULL, '+
                              ' TITFIO CHAR(15) NULL, '+
                              ' DESENC CHAR(50) NULL, '+
                              ' QTDMET NUMERIC(15,3), '+
                              ' QTDPRO NUMERIC(15,3), '+
                              ' NUMTAB NUMERIC(5,2) , '+
                              ' PRIMARY KEY (EMPFIL,SEQORD,SEQITE))');
        ExecutaComandoSql(Aux,'create unique index OPITEMCADARCO_PK ON OPITEMCADARCO(EMPFIL,SEQORD,SEQITE)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 288');
      end;
      if VpaNumAtualizacao < 289 Then
      begin
        VpfErro := '289';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO '+
                              ' ADD CODUSU INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 289');
      end;
      if VpaNumAtualizacao < 290 Then
      begin
        VpfErro := '290';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS '+
                              ' ADD I_QTD_FUS INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 290');
      end;
      if VpaNumAtualizacao < 291 Then
      begin
        VpfErro := '291';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL '+
                              ' ADD C_VER_DEV CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_VER_DEV = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 291');
      end;
      if VpaNumAtualizacao < 292 Then
      begin
        VpfErro := '292';
        ExecutaComandoSql(Aux,'CREATE TABLE REVISAOOPEXTERNA( EMPFIL INTEGER NOT NULL, ' +
                              ' SEQORD INTEGER NOT NULL, '+
                              ' SEQCOL INTEGER NOT NULL, '+
                              ' CODUSU INTEGER NOT NULL, '+
                              ' DATREV DATETIME NOT NULL,'+
                              ' PRIMARY KEY (EMPFIL,SEQORD,SEQCOL,CODUSU))');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX REVISAOOPEXTERNA_PK ON REVISAOOPEXTERNA(EMPFIL,SEQORD,SEQCOL,CODUSU)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 292');
      end;
      if VpaNumAtualizacao < 293 Then
      begin
        VpfErro := '293';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS '+
                              ' ADD C_BAT_TEA CHAR(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 293');
      end;
      if VpaNumAtualizacao < 294 Then
      begin
        VpfErro := '294';
        ExecutaComandoSql(Aux,'ALTER TABLE ROMANEIOCORPO '+
                              ' ADD NRONOT INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 294');
      end;
      if VpaNumAtualizacao < 295 Then
      begin
        VpfErro := '295';
        ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS '+
                              ' ADD I_TIP_FRE INTEGER NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 295');
      end;
      if VpaNumAtualizacao < 296 Then
      begin
        VpfErro := '296';
        ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS '+
                              ' ADD I_ULT_PRO INTEGER NULL');
        ExecutaComandoSql(Aux,'UPDATE  CADEMPRESAS SET I_ULT_PRO = 0 ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 296');
      end;
      if VpaNumAtualizacao < 297 Then
      begin
        VpfErro := '297';
        ExecutaComandoSql(Aux,'ALTER TABLE OPITEMCADARCO '+
                              ' MODIFY GROPRO NUMERIC(8,2) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 297');
      end;
      if VpaNumAtualizacao < 298 Then
      begin
        VpfErro := '298';
        ExecutaComandoSql(Aux,'CREATE TABLE OPITEMCADARCOMAQUINA( '+
                              ' EMPFIL INTEGER NOT NULL, '+
                              ' SEQORD INTEGER NOT NULL, '+
                              ' SEQITE INTEGER NOT NULL, '+
                              ' SEQMAQ INTEGER NOT NULL, '+
                              ' CODMAQ INTEGER NOT NULL, '+
                              ' QTDMET NUMERIC(15,3) NULL,'+
                              ' QTDHOR CHAR(7) NULL,'+
                              ' DATFIN DATETIME NULL,'+
                              ' PRIMARY KEY(EMPFIL,SEQORD,SEQITE,SEQMAQ))');
        ExecutaComandoSql(Aux,'Create unique index OPITEMCADARCOMAQUINA_PK ON OPITEMCADARCOMAQUINA(EMPFIL,SEQORD,SEQITE,SEQMAQ)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 298');
      end;
      if VpaNumAtualizacao < 299 Then
      begin
        VpfErro := '299';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVESTOQUEPRODUTOS' +
                              ' add N_VLR_CUS NUMERIC(15,3) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 299');
      end;
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
      VpfErro := AtualizaTabela1(VpaNumAtualizacao);
      VpfSemErros := true;
    except
      on E : Exception do
      begin
        Aux.Sql.text := E.message;
        Aux.Sql.SavetoFile('c:\ErroInicio.txt');
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
  if VpaNumAtualizacao < 304 Then
  begin
    result := '304';
    ExecutaComandoSql(Aux,'create index CADORCAMENTOS_CP1 on CADORCAMENTOS(D_DAT_ORC)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 304');
  end;

  if VpaNumAtualizacao < 305 Then
  begin
    result := '305';
    ExecutaComandoSql(Aux,'ALTER TABLE CAD_DOC ADD C_FLA_FOR CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 305');
  end;

  if VpaNumAtualizacao < 306 Then
  begin
    result := '306';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ADD N_PER_DES NUMERIC(5,2) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 306');
  end;
  if VpaNumAtualizacao < 307 Then
  begin
    result := '307';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL '+
                          ' ADD C_OBS_PED CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_FISCAL SET C_OBS_PED = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 307');
  end;

  if VpaNumAtualizacao < 308 Then
  begin
    result := '308';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS '+
                          ' ADD C_NUM_PED CHAR(40) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 308');
  end;
  if VpaNumAtualizacao < 309 Then
  begin
    result := '309';
    ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS '+
                          ' ADD C_GER_COC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 309');
  end;

  if VpaNumAtualizacao < 310 Then
  begin
    result := '310';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL '+
                          ' ADD C_FIN_COT CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_FIN_COT = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 310');
  end;

  if VpaNumAtualizacao < 311 Then
  begin
    result := '311';
    ExecutaComandoSql(Aux,'CREATE INDEX CADNOTAFISCAIS_CP2 ON CADNOTAFISCAIS(D_DAT_EMI)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 311');
  end;

  if VpaNumAtualizacao < 312 Then
  begin
    result := '312';
    ExecutaComandoSql(Aux,'ALTER TABLE CADICMSESTADOS ADD I_COD_EMP INTEGER NULL');
    ExecutaComandoSql(Aux,'UPDATE CADICMSESTADOS SET I_COD_EMP = 1');
    ExecutaComandoSql(Aux,'ALTER TABLE CADICMSESTADOS MODIFY I_COD_EMP INTEGER NOT NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 312');
  end;

  if VpaNumAtualizacao < 313 Then
  begin
    result := '313';
    ExecutaComandoSql(Aux,'drop index CADICMSESTADOS_PK ');
    ExecutaComandoSql(Aux,'ALTER TABLE CADICMSESTADOS drop PRIMARY KEY');
    ExecutaComandoSql(Aux,'ALTER TABLE CADICMSESTADOS ADD PRIMARY KEY(I_COD_EMP,C_COD_EST)');
    ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX CADICMSESTADOS_PK ON CADICMSESTADOS(I_COD_EMP,C_COD_EST)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 313');
  end;

  if VpaNumAtualizacao < 314 Then
  begin
    result := '314';
    ExecutaComandoSql(Aux,'alter table CFG_PRODUTO  '+
                          ' ADD I_OPE_ESA INTEGER NULL, '+
                          ' ADD I_OPE_EEN INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 314');
  end;

  if VpaNumAtualizacao < 315 Then
  begin
    result := '315';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS'+
                          ' ADD C_NOT_GER CHAR(1) NULL' );
    ExecutaComandoSql(Aux,'update CADORCAMENTOS  SET C_NOT_GER = ''S''  WHERE C_NRO_NOT IS NOT NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 315');
  end;

  if VpaNumAtualizacao < 316 Then
  begin
    result := '316';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS'+
                          ' ADD N_VLR_TTD NUMERIC(15,3) NULL' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 316');
  end;
  if VpaNumAtualizacao < 317 Then
  begin
    result := '317';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO'+
                          ' ADD C_BAI_CON CHAR(1) NULL' );
    ExecutaComandoSql(Aux,'UPDATE  CFG_PRODUTO SET C_BAI_CON = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 317');
  end;
  if VpaNumAtualizacao < 318 Then
  begin
    result := '318';
    ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS'+
                          ' ADD C_PLA_DEC CHAR(10) NULL' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 318');
  end;
  if VpaNumAtualizacao < 319 Then
  begin
    result := '319';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVINDICECONVERSAO'+
                          ' MODIFY N_IND_COV NUMERIC(16,8)' );
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 319');
  end;
  if VpaNumAtualizacao < 320 Then
  begin
    result := '320';
    ExecutaComandoSql(Aux,'update MOVINDICECONVERSAO'+
                          ' set N_IND_COV = 100 '+
                          ' where C_UNI_COV = ''mt'''+
                          ' AND C_UNI_ATU = ''cm''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 320');
  end;
  if VpaNumAtualizacao < 321 Then
  begin
    result := '321';
    ExecutaComandoSql(Aux,'alter table CFG_PRODUTO'+
                          ' ADD C_DES_ICO CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_DES_ICO = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 321');
  end;
  if VpaNumAtualizacao < 322 Then
  begin
    result := '322';
    ExecutaComandoSql(Aux,'alter table ORDEMPRODUCAOCORPO '+
                          ' ADD INDPNO  CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 322');
  end;

  if VpaNumAtualizacao < 323 Then
  begin
    result := '323';
    ExecutaComandoSql(Aux,'CREATE TABLE TIPOCORTE ('+
                          ' CODCORTE INTEGER NOT NULL, '+
                          ' NOMCORTE CHAR(50) , '+
                          ' PRIMARY KEY(CODCORTE))');
    ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX TIPOCORTE_PK ON TIPOCORTE(CODCORTE)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 323');
  end;
  if VpaNumAtualizacao < 324 Then
  begin
    result := '324';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS' +
                          ' DROP C_DES_ACR, '+
                          ' DROP C_VLR_PER, '+
                          ' DROP N_DES_ACR, '+
                          ' DROP N_VLR_PER');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 324');
  end;

  if VpaNumAtualizacao < 325 Then
  begin
    result := '325';
    ExecutaComandoSql(Aux,'CREATE TABLE ORCAMENTOPARCIALCORPO ( ' +
                          ' CODFILIAL INTEGER NOT NULL, '+
                          ' LANORCAMENTO INTEGER NOT NULL, '+
                          ' SEQPARCIAL INTEGER NOT NULL, '+
                          ' DATPARCIAL DATETIME,' +
                          ' PRIMARY KEY(CODFILIAL,LANORCAMENTO,SEQPARCIAL))');
    ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX ORCAMENTOPARCIALCORPO_PK ON ORCAMENTOPARCIALCORPO(CODFILIAL,LANORCAMENTO,SEQPARCIAL)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 325');
  end;
  if VpaNumAtualizacao < 326 Then
  begin
    result := '326';
    ExecutaComandoSql(Aux,'CREATE TABLE ORCAMENTOPARCIALITEM ( ' +
                          ' CODFILIAL INTEGER NOT NULL, '+
                          ' LANORCAMENTO INTEGER NOT NULL, '+
                          ' SEQPARCIAL INTEGER NOT NULL, '+
                          ' SEQMOVORCAMENTO INTEGER NOT NULL,' +
                          ' QTDPARCIAL NUMERIC(13,4),'+
                          ' PRIMARY KEY(CODFILIAL,LANORCAMENTO,SEQPARCIAL,SEQMOVORCAMENTO))');
    ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX ORCAMENTOPARCIALITEM_PK ON ORCAMENTOPARCIALITEM(CODFILIAL,LANORCAMENTO,SEQPARCIAL,SEQMOVORCAMENTO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 326');
  end;
  if VpaNumAtualizacao < 327 Then
  begin
    result := '327';
    ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS' +
                          ' ADD I_BOL_PAD INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 327');
  end;

  if VpaNumAtualizacao < 328 Then
  begin
    result := '328';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO' +
                          ' ADD I_OPE_EXE INTEGER NULL,'+
                          ' ADD I_OPE_EXS INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 328');
  end;

  if VpaNumAtualizacao < 329 Then
  begin
    result := '329';
    ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ' +
                          ' ADD CODCRT INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 329');
  end;

  if VpaNumAtualizacao < 330 Then
  begin
    result := '330';
    ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ' +
                          ' ADD C_COD_NAT CHAR(10) NULL,'+
                          ' ADD I_SEQ_NAT INTEGER NULL, '+
                          ' ADD I_QTD_PAR INTEGER NULL, '+
                          ' ADD I_PRA_DIA INTEGER NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 330');
  end;
  if VpaNumAtualizacao < 331 Then
  begin
    result := '331';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAISFOR ' +
                          ' ADD C_NOM_COR CHAR(50) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 331');
  end;
  if VpaNumAtualizacao < 332 Then
  begin
    result := '332';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ' +
                          ' ADD I_REC_PAD INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 332');
  end;
  if VpaNumAtualizacao < 333 Then
  begin
    result := '333';
    ExecutaComandoSql(Aux,'ALTER TABLE LOG ' +
                          ' ADD DES_INFORMACOES LONG VARCHAR NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 333');
  end;

  if VpaNumAtualizacao < 334 Then
  begin
    result := '334';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVORCAMENTOS ' +
                          ' MODIFY C_DES_COR CHAR(50) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 334');
  end;

  if VpaNumAtualizacao < 335 Then
  begin
    result := '335';
    ExecutaComandoSql(Aux,'ALTER TABLE MOVCONTASARECEBER ' +
                          ' ADD C_COB_EXT CHAR(1) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 335');
  end;

  if VpaNumAtualizacao < 336 Then
  begin
    result := '336';
    ExecutaComandoSql(Aux,'ALTER TABLE CADORCAMENTOS ' +
                          ' ADD I_COD_OPE INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 336');
  end;
  if VpaNumAtualizacao < 337 Then
  begin
    result := '337';
    ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS ' +
                          ' SET I_COD_OPE = 1101');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 337');
  end;
  if VpaNumAtualizacao < 338 Then
  begin
    result := '338';
    ExecutaComandoSql(Aux,'CREATE TABLE REL_PRODUTO_VENDIDO_MES ' +
                          '( SEQ_PRODUTO INTEGER NOT NULL,'+
                          ' QTD_VENDIDA NUMERIC(15,3),'+
                          ' UM_PRODUTO CHAR(2), '+
                          ' PRIMARY KEY (SEQ_PRODUTO))');
    ExecutaComandoSql(Aux,'Create unique index REL_PRODUTO_VENDIDO_MES_PK ON REL_PRODUTO_VENDIDO_MES(SEQ_PRODUTO)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 338');
  end;
  if VpaNumAtualizacao < 339 Then
  begin
    result := '339';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ' +
                          ' ADD C_IMP_NOR CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CFG_FISCAL SET C_IMP_NOR = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 339');
  end;
  if VpaNumAtualizacao < 340 Then
  begin
    result := '340';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ' +
                          ' ADD C_FIN_COT CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_FIN_COT = (SELECT C_FIN_COT FROM CFG_FISCAL)');
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ' +
                          ' DROP C_FIN_COT');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 340');
  end;
  if VpaNumAtualizacao < 341 Then
  begin
    result := '341';
    ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ' +
                          ' ADD C_EXC_FIC CHAR(1) NULL');
    ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_EXC_FIC = ''F''');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 341');
  end;
  if VpaNumAtualizacao < 342 Then
  begin
    result := '342';
    ExecutaComandoSql(Aux,'CREATE  TABLE METROFATURADOITEM (' +
                          ' EMPFIL INTEGER NOT NULL,'+
                          ' SEQROM INTEGER NOT NULL,'+
                          ' FILNOT INTEGER NOT NULL,'+
                          ' SEQNOT INTEGER NOT NULL,'+
                          ' PRIMARY KEY (EMPFIL,SEQROM,FILNOT,SEQNOT))');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 342');
  end;
  if VpaNumAtualizacao < 343 Then
  begin
    result := '343';
    ExecutaComandoSql(Aux,'Alter Table CFG_PRODUTO ' +
                          ' ADD C_EST_CEN CHAR(1),'+
                          ' ADD I_FIL_EST INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 343');
  end;
  if VpaNumAtualizacao < 344 Then
  begin
    result := '344';
    ExecutaComandoSql(Aux,'Alter Table CFG_PRODUTO ' +
                          ' DROP C_PAG_PRO');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 344');
  end;
  if VpaNumAtualizacao < 345 Then
  begin
    result := '345';
    ExecutaComandoSql(Aux,'CREATE INDEX ORDEMPRODUCAOCOPRO_FK5 ON ORDEMPRODUCAOCORPO(DATENP) ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 345');
  end;
  if VpaNumAtualizacao < 346 Then
  begin
    result := '346';
    ExecutaComandoSql(Aux,'Alter table CADPRODUTOS ADD I_TAB_TRA INTEGER NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 346');
  end;
  if VpaNumAtualizacao < 347 Then
  begin
    result := '347';
    ExecutaComandoSql(Aux,'Alter table CADPRODUTOS ADD C_TIT_FIO CHAR(15) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 347');
  end;
  if VpaNumAtualizacao < 348 Then
  begin
    result := '348';
    ExecutaComandoSql(Aux,'Alter table CADFILIAIS ADD C_JUN_COM CHAR(50) NULL, '+
                          ' ADD C_CPF_RES CHAR(20) NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 348');
  end;
  if VpaNumAtualizacao < 349 Then
  begin
    result := '349';
    ExecutaComandoSql(Aux,'Alter table ORDEMPRODUCAOCORPO ADD DATFIM DATETIME NULL, '+
                          ' ADD DATPCO DATETIME NULL, '+
                          ' ADD DATFAT DATETIME NULL');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 349');
  end;
  if VpaNumAtualizacao < 350 Then
  begin
    result := '350';
    ExecutaComandoSql(Aux,'UPDATE ORDEMPRODUCAOCORPO OP '+
                          ' SET DATPCO = ''2005/01/01'''+
                          ' WHERE EXISTS (SELECT * FROM COLETAOPCORPO COL '+
                          ' WHERE OP.EMPFIL = COL.EMPFIL '+
                          ' AND OP.SEQORD = COL.SEQORD)');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 350');
  end;
  if VpaNumAtualizacao < 351 Then
  begin
    result := '351';
    ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL '+
                          ' ADD I_FOR_EXP INTEGER ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 351');
  end;
  if VpaNumAtualizacao < 352 Then
  begin
    result := '352';
    ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER '+
                          ' ADD I_SEQ_PAR INTEGER NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 352');
  end;
  if VpaNumAtualizacao < 353 Then
  begin
    result := '353';
    ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOPARCIALCORPO '+
                          ' ADD VALTOTAL NUMERIC(15,3) NULL ');
    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 353');
  end;
end;

end.
