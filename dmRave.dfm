object dtRave: TdtRave
  OldCreateOrder = False
  OnCreate = f
  Height = 390
  Width = 517
  object Principal: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'SELECT PED.SEQPEDIDO, PED.TIPFRETE, PED.DATPEDIDO, CLI.C_NOM_CLI' +
        ', USU.C_NOM_USU, PGT.C_NOM_PAG, PED.VALTOTAL  FROM PEDIDOCOMPRAC' +
        'ORPO PED, CADCLIENTES CLI, CADUSUARIOS USU, CADCONDICOESPAGTO PG' +
        'T  WHERE DATPEDIDO between to_date('#39'01/07/2010'#39','#39'DD/MM/YYYY'#39') an' +
        'd to_date('#39'31/08/2010'#39','#39'DD/MM/YYYY'#39') AND PED.CODCLIENTE = CLI.I_' +
        'COD_CLI  AND PED.CODUSUARIO = USU.I_COD_USU  AND PED.CODCONDICAO' +
        'PAGAMENTO = PGT.I_COD_PAG '
      ' AND PED.CODFILIAL =  11'
      ' ORDER BY PED.SEQPEDIDO')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'SELECT PED.SEQPEDIDO, PED.TIPFRETE, PED.DATPEDIDO, CLI.C_NOM_CLI' +
        ', USU.C_NOM_USU, PGT.C_NOM_PAG, PED.VALTOTAL  FROM PEDIDOCOMPRAC' +
        'ORPO PED, CADCLIENTES CLI, CADUSUARIOS USU, CADCONDICOESPAGTO PG' +
        'T  WHERE DATPEDIDO between to_date('#39'01/07/2010'#39','#39'DD/MM/YYYY'#39') an' +
        'd to_date('#39'31/08/2010'#39','#39'DD/MM/YYYY'#39') AND PED.CODCLIENTE = CLI.I_' +
        'COD_CLI  AND PED.CODUSUARIO = USU.I_COD_USU  AND PED.CODCONDICAO' +
        'PAGAMENTO = PGT.I_COD_PAG '
      ' AND PED.CODFILIAL =  11'
      ' ORDER BY PED.SEQPEDIDO')
    Left = 80
    Top = 8
  end
  object rvPrincipal: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Principal
    Left = 80
    Top = 64
  end
  object Rave: TRvProject
    Engine = RvSystem1
    OnBeforeOpen = RaveBeforeOpen
    Left = 16
    Top = 8
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Opcoes de Saida'
    TitleStatus = 'Report Status'
    TitlePreview = 'Visualizador de Relatorio'
    SystemSetups = [ssAllowCopies, ssAllowCollate, ssAllowDuplex, ssAllowDestPreview, ssAllowDestPrinter, ssAllowDestFile, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Siscorp'
    SystemPrinter.Units = unMM
    SystemPrinter.UnitsFactor = 25.400000000000000000
    OnBeforePrint = RvSystem1BeforePrint
    Left = 16
    Top = 64
  end
  object PedidosPendentes: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'select Extract(YEAR FROM  cad.d_dat_pre)  || Extract(MONTH FROM ' +
        'cad.d_dat_pre) MESANO,'
      
        ' Extract(MONTH FROM cad.d_dat_pre) || '#39'/'#39' || Extract(YEAR FROM  ' +
        'cad.d_dat_pre) MESANOF,'
      
        ' CAD.I_EMP_FIL, cad.d_dat_pre, cad.d_dat_orc, cad.i_lan_orc, cad' +
        '.i_cod_cli, CAD.T_HOR_ENT, cli.c_nom_cli, '
      ' CAD.C_ORD_COM, '
      ' mov.n_qtd_pro, MOV.N_QTD_PRO QTDREAL, '
      ' (MOV.N_QTD_PRO)  * MOV.N_VLR_PRO TOTAL, '
      ' pro.c_nom_pro,PRO.C_COD_PRO, mov.c_cod_uni,  '
      
        ' MOV.C_DES_COR, MOV.C_PRO_REF, MOV.I_SEQ_MOV, MOV.I_SEQ_ORD,  MO' +
        'V.N_QTD_BAI,'
      'MOV.I_COD_COR'
      ' from '
      
        '  cadorcamentos cad, movorcamentos mov, cadclientes cli, cadprod' +
        'utos pro '
      ' where cad.i_emp_fil = mov.i_emp_fil '
      ' and cad.i_lan_orc = mov.i_lan_orc '
      ' and cad.i_cod_cli = cli.i_cod_cli '
      ' and mov.i_seq_pro = pro.i_seq_pro ')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select Extract(YEAR FROM  cad.d_dat_pre)  || Extract(MONTH FROM ' +
        'cad.d_dat_pre) MESANO,'
      
        ' Extract(MONTH FROM cad.d_dat_pre) || '#39'/'#39' || Extract(YEAR FROM  ' +
        'cad.d_dat_pre) MESANOF,'
      
        ' CAD.I_EMP_FIL, cad.d_dat_pre, cad.d_dat_orc, cad.i_lan_orc, cad' +
        '.i_cod_cli, CAD.T_HOR_ENT, cli.c_nom_cli, '
      ' CAD.C_ORD_COM, '
      ' mov.n_qtd_pro, MOV.N_QTD_PRO QTDREAL, '
      ' (MOV.N_QTD_PRO)  * MOV.N_VLR_PRO TOTAL, '
      ' pro.c_nom_pro,PRO.C_COD_PRO, mov.c_cod_uni,  '
      
        ' MOV.C_DES_COR, MOV.C_PRO_REF, MOV.I_SEQ_MOV, MOV.I_SEQ_ORD,  MO' +
        'V.N_QTD_BAI,'
      'MOV.I_COD_COR'
      ' from '
      
        '  cadorcamentos cad, movorcamentos mov, cadclientes cli, cadprod' +
        'utos pro '
      ' where cad.i_emp_fil = mov.i_emp_fil '
      ' and cad.i_lan_orc = mov.i_lan_orc '
      ' and cad.i_cod_cli = cli.i_cod_cli '
      ' and mov.i_seq_pro = pro.i_seq_pro ')
    Left = 448
    Top = 8
    object PedidosPendentesI_EMP_FIL: TFMTBCDField
      FieldName = 'I_EMP_FIL'
      Required = True
      Precision = 10
      Size = 0
    end
    object PedidosPendentesD_DAT_PRE: TSQLTimeStampField
      FieldName = 'D_DAT_PRE'
    end
    object PedidosPendentesD_DAT_ORC: TSQLTimeStampField
      FieldName = 'D_DAT_ORC'
    end
    object PedidosPendentesI_LAN_ORC: TFMTBCDField
      FieldName = 'I_LAN_ORC'
      Required = True
      Precision = 10
      Size = 0
    end
    object PedidosPendentesI_COD_CLI: TFMTBCDField
      FieldName = 'I_COD_CLI'
      Precision = 10
      Size = 0
    end
    object PedidosPendentesT_HOR_ENT: TSQLTimeStampField
      FieldName = 'T_HOR_ENT'
    end
    object PedidosPendentesC_NOM_CLI: TWideStringField
      FieldName = 'C_NOM_CLI'
      Size = 50
    end
    object PedidosPendentesC_ORD_COM: TWideStringField
      FieldName = 'C_ORD_COM'
    end
    object PedidosPendentesN_QTD_PRO: TFMTBCDField
      FieldName = 'N_QTD_PRO'
      Precision = 17
      Size = 3
    end
    object PedidosPendentesQTDREAL: TFMTBCDField
      FieldName = 'QTDREAL'
      Precision = 32
    end
    object PedidosPendentesC_NOM_PRO: TWideStringField
      FieldName = 'C_NOM_PRO'
      Size = 100
    end
    object PedidosPendentesC_COD_PRO: TWideStringField
      FieldName = 'C_COD_PRO'
      Size = 50
    end
    object PedidosPendentesC_COD_UNI: TWideStringField
      FieldName = 'C_COD_UNI'
      Size = 2
    end
    object PedidosPendentesC_DES_COR: TWideStringField
      FieldName = 'C_DES_COR'
      Size = 50
    end
    object PedidosPendentesC_PRO_REF: TWideStringField
      FieldName = 'C_PRO_REF'
      Size = 50
    end
    object PedidosPendentesI_SEQ_MOV: TFMTBCDField
      FieldName = 'I_SEQ_MOV'
      Required = True
      Precision = 10
      Size = 0
    end
    object PedidosPendentesTOTAL: TFMTBCDField
      FieldName = 'TOTAL'
      Precision = 32
    end
    object PedidosPendentesI_SEQ_ORD: TFMTBCDField
      FieldName = 'I_SEQ_ORD'
      Precision = 10
      Size = 0
    end
    object PedidosPendentesN_QTD_BAI: TFMTBCDField
      FieldName = 'N_QTD_BAI'
      Precision = 17
      Size = 3
    end
    object PedidosPendentesMESANO: TWideStringField
      FieldName = 'MESANO'
      Size = 80
    end
    object PedidosPendentesMESANOF: TWideStringField
      FieldName = 'MESANOF'
      Size = 81
    end
    object PedidosPendentesI_COD_COR: TFMTBCDField
      FieldName = 'I_COD_COR'
      Precision = 10
      Size = 0
    end
  end
  object rvPedidosPendentes: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = PedidosPendentes
    Left = 448
    Top = 64
  end
  object Item: TSQL
    Aggregates = <>
    PacketRecords = 30
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'select PRO.C_COD_PRO, PRO.C_NOM_PRO, '
      ' PMP.CODFILIAL, PMP.SEQPEDIDO, PMP.SEQITEM, PMP.CODCOR,'
      'PMP.QTDPRODUTO, PMP.QTDCHAPA, PMP.LARCHAPA, PMP.COMCHAPA'
      'from PEDIDOCOMPRAITEMMATERIAPRIMA PMP, CADPRODUTOS PRO '
      '           '
      ' Where PMP.CODFILIAL = 11'
      ' AND PMP.SEQPEDIDO = 1847'
      'AND PMP.SEQPRODUTO = PRO.I_SEQ_PRO')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'select PRO.C_COD_PRO, PRO.C_NOM_PRO, '
      ' PMP.CODFILIAL, PMP.SEQPEDIDO, PMP.SEQITEM, PMP.CODCOR,'
      'PMP.QTDPRODUTO, PMP.QTDCHAPA, PMP.LARCHAPA, PMP.COMCHAPA'
      'from PEDIDOCOMPRAITEMMATERIAPRIMA PMP, CADPRODUTOS PRO '
      '           '
      ' Where PMP.CODFILIAL = 11'
      ' AND PMP.SEQPEDIDO = 1847'
      'AND PMP.SEQPRODUTO = PRO.I_SEQ_PRO')
    Left = 136
    Top = 8
  end
  object rvItem: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Item
    Left = 136
    Top = 64
  end
  object Item2: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'Select ITE.SEQITEM, ITE.CODSERVICO, ITE.QTDSERVICO, ITE.VALUNITA' +
        'RIO, ITE.VALTOTAL, '
      ' SER.C_NOM_SER '
      ' from PROPOSTASERVICO ITE, CADSERVICO SER '
      ' Where ITE.CODEMPRESASERVICO = SER.I_COD_EMP '
      ' AND ITE.CODSERVICO = SER.I_COD_SER '
      ' AND ITE.CODFILIAL = 11'
      ' AND ITE.SEQPROPOSTA =1888'
      ' ORDER BY ITE.SEQITEM ')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'Select ITE.SEQITEM, ITE.CODSERVICO, ITE.QTDSERVICO, ITE.VALUNITA' +
        'RIO, ITE.VALTOTAL, '
      ' SER.C_NOM_SER '
      ' from PROPOSTASERVICO ITE, CADSERVICO SER '
      ' Where ITE.CODEMPRESASERVICO = SER.I_COD_EMP '
      ' AND ITE.CODSERVICO = SER.I_COD_SER '
      ' AND ITE.CODFILIAL = 11'
      ' AND ITE.SEQPROPOSTA =1888'
      ' ORDER BY ITE.SEQITEM ')
    Left = 200
    Top = 8
  end
  object rvItem2: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Item2
    Left = 200
    Top = 64
  end
  object Item3: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'SELECT PRP.CODFILIAL, PRP.SEQPROPOSTA, PRP.SEQITEM, PRP.SEQPRODU' +
        'TO, PRP.CODEMBALAGEM, PRP.CODAPLICACAO, PRP.DESPRODUCAO, PRP.DES' +
        'SENTIDOPASSAGEM,'
      'PRP.DESDIAMETROTUBO, PRP.DESOBSERVACAO, PRO.C_NOM_PRO'
      'FROM PROPOSTAPRODUTOCLIENTE PRP, CADPRODUTOS PRO'
      'WHERE PRP.SEQPRODUTO = PRO.I_SEQ_PRO')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'SELECT PRP.CODFILIAL, PRP.SEQPROPOSTA, PRP.SEQITEM, PRP.SEQPRODU' +
        'TO, PRP.CODEMBALAGEM, PRP.CODAPLICACAO, PRP.DESPRODUCAO, PRP.DES' +
        'SENTIDOPASSAGEM,'
      'PRP.DESDIAMETROTUBO, PRP.DESOBSERVACAO, PRO.C_NOM_PRO'
      'FROM PROPOSTAPRODUTOCLIENTE PRP, CADPRODUTOS PRO'
      'WHERE PRP.SEQPRODUTO = PRO.I_SEQ_PRO')
    Left = 256
    Top = 8
  end
  object rvItem3: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Item3
    Left = 256
    Top = 64
  end
  object PDF: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    DocInfo.Creator = 'Rave Reports (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    Left = 16
    Top = 128
  end
  object Item4: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'Select ACE.CODACESSORIO, ACE.NOMACESSORIO  '
      ' from ACESSORIO ACE, PRODUTOACESSORIO PAC '
      ' Where ACE.CODACESSORIO = PAC.CODACESSORIO'
      ' and PAC.SEQPRODUTO <> 1'
      ' ORDER BY ACE.CODACESSORIO')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select ACE.CODACESSORIO, ACE.NOMACESSORIO  '
      ' from ACESSORIO ACE, PRODUTOACESSORIO PAC '
      ' Where ACE.CODACESSORIO = PAC.CODACESSORIO'
      ' and PAC.SEQPRODUTO <> 1'
      ' ORDER BY ACE.CODACESSORIO')
    Left = 312
    Top = 8
  end
  object rvItem4: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Item4
    Left = 312
    Top = 64
  end
  object VendaAdicional: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'Select PRP.SEQPRODUTO, PRP.CODPRODUTO, PRP.CODCOR, '
      ' PRP.QTDPRODUTO, PRP.VALUNITARIO,PRP.VALTOTAL, PRP.DESUM,'
      ' Pro.C_Cod_Uni, PRO.C_NOM_PRO,'
      ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal '
      
        ' from PROPOSTAVENDAADICIONAL PRP, CADPRODUTOS PRO, MOVTABELAPREC' +
        'O PRE, CadMOEDAS Moe  '
      ' Where 1=1'
      ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro '
      ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '
      ' and Pro.c_ven_avu = '#39'S'#39
      ' and PRE.I_COD_CLI  = 0 '
      ' and PRE.I_COD_TAM  = 0 '
      ' '
      ' AND PRP.SEQPRODUTO = PRO.I_SEQ_PRO '
      ' ORDER BY PRP.SEQITEM')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select PRP.SEQPRODUTO, PRP.CODPRODUTO, PRP.CODCOR, '
      ' PRP.QTDPRODUTO, PRP.VALUNITARIO,PRP.VALTOTAL, PRP.DESUM,'
      ' Pro.C_Cod_Uni, PRO.C_NOM_PRO,'
      ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal '
      
        ' from PROPOSTAVENDAADICIONAL PRP, CADPRODUTOS PRO, MOVTABELAPREC' +
        'O PRE, CadMOEDAS Moe  '
      ' Where 1=1'
      ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro '
      ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '
      ' and Pro.c_ven_avu = '#39'S'#39
      ' and PRE.I_COD_CLI  = 0 '
      ' and PRE.I_COD_TAM  = 0 '
      ' '
      ' AND PRP.SEQPRODUTO = PRO.I_SEQ_PRO '
      ' ORDER BY PRP.SEQITEM')
    Left = 80
    Top = 128
  end
  object rvVendaAdicional: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = VendaAdicional
    Left = 368
    Top = 128
  end
  object Item5: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'SELECT PRP.CODFILIAL, PRP.SEQPROPOSTA, PRP.SEQITEM, PRP.SEQPRODU' +
        'TO, PRP.CODEMBALAGEM, PRP.CODAPLICACAO, PRP.DESPRODUCAO, PRP.DES' +
        'SENTIDOPASSAGEM,'
      
        'PRP.DESDIAMETROTUBO, PRP.DESOBSERVACAO, PRO.C_NOM_PRO, EMB.NOM_E' +
        'MBALAGEM, APL.NOMAPLICACAO'
      
        'FROM PROPOSTAPRODUTOCLIENTE PRP, CADPRODUTOS PRO, EMBALAGEM EMB,' +
        ' APLICACAO APL'
      'WHERE PRP.SEQPRODUTO = PRO.I_SEQ_PRO'
      'AND PRP.CODEMBALAGEM = EMB.COD_EMBALAGEM'
      'AND PRP.CODAPLICACAO = APL.CODAPLICACAO')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'SELECT PRP.CODFILIAL, PRP.SEQPROPOSTA, PRP.SEQITEM, PRP.SEQPRODU' +
        'TO, PRP.CODEMBALAGEM, PRP.CODAPLICACAO, PRP.DESPRODUCAO, PRP.DES' +
        'SENTIDOPASSAGEM,'
      
        'PRP.DESDIAMETROTUBO, PRP.DESOBSERVACAO, PRO.C_NOM_PRO, EMB.NOM_E' +
        'MBALAGEM, APL.NOMAPLICACAO'
      
        'FROM PROPOSTAPRODUTOCLIENTE PRP, CADPRODUTOS PRO, EMBALAGEM EMB,' +
        ' APLICACAO APL'
      'WHERE PRP.SEQPRODUTO = PRO.I_SEQ_PRO'
      'AND PRP.CODEMBALAGEM = EMB.COD_EMBALAGEM'
      'AND PRP.CODAPLICACAO = APL.CODAPLICACAO')
    Left = 368
    Top = 8
  end
  object rvItem5: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Item5
    Left = 368
    Top = 64
  end
end
