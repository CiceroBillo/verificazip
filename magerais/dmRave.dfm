object dtRave: TdtRave
  OldCreateOrder = False
  OnCreate = f
  Height = 390
  Width = 699
  object Principal: TSQL
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'SELECT PRO.C_COD_PRO, PRO.C_NOM_PRO, FRA.QTDPRODUTO, FRA.SEQORDE' +
        'M, FRA.SEQFRACAO'
      'FROM CADPRODUTOS PRO, FRACAOOP FRA, PRODUTONAOCOMPRADOITEM COM'
      'WHERE FRA.SEQPRODUTO = PRO.I_SEQ_PRO'
      'AND FRA.CODFILIAL = COM.CODFILIAL'
      'AND FRA.SEQORDEM = COM.SEQORDEMPRODUCAO'
      'AND FRA.SEQFRACAO = COM.SEQFRACAO'
      'AND COM.SEQPRODUTONAOCOMPRADO = 1')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'SELECT PRO.C_COD_PRO, PRO.C_NOM_PRO, FRA.QTDPRODUTO, FRA.SEQORDE' +
        'M, FRA.SEQFRACAO'
      'FROM CADPRODUTOS PRO, FRACAOOP FRA, PRODUTONAOCOMPRADOITEM COM'
      'WHERE FRA.SEQPRODUTO = PRO.I_SEQ_PRO'
      'AND FRA.CODFILIAL = COM.CODFILIAL'
      'AND FRA.SEQORDEM = COM.SEQORDEMPRODUCAO'
      'AND FRA.SEQFRACAO = COM.SEQFRACAO'
      'AND COM.SEQPRODUTONAOCOMPRADO = 1')
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
    Top = 16
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
        'cad.d_dat_pre) MESANO, Extract(MONTH FROM cad.d_dat_pre) || '#39'/'#39' ' +
        '|| Extract(YEAR FROM  cad.d_dat_pre) MESANOF, CAD.I_EMP_FIL, cad' +
        '.d_dat_pre, cad.d_dat_orc, cad.i_lan_orc, cad.i_cod_cli, CAD.T_H' +
        'OR_ENT, cli.c_nom_cli,  CAD.C_ORD_COM, PRO.I_ALC_EMB alca, PRO.C' +
        '_IND_BOL bolso,  mov.n_qtd_pro, MOV.N_QTD_PRO - nvl(MOV.N_QTD_BA' +
        'I,0)  - nvl(MOV.N_QTD_CAN,0)  QTDREAL,  (MOV.N_QTD_PRO - nvl(MOV' +
        '.N_QTD_BAI,0) -nvl(MOV.N_QTD_CAN,0) )  * MOV.N_VLR_PRO TOTAL,  p' +
        'ro.c_nom_pro,PRO.C_COD_PRO, mov.c_cod_uni, mov.n_vlr_pro, MOV.N_' +
        'QTD_BAI,  MOV.C_DES_COR, MOV.I_COD_COR, MOV.C_PRO_REF, MOV.I_SEQ' +
        '_MOV, MOV.I_SEQ_ORD,  MOV.N_QTD_BAI  from cadorcamentos cad, mov' +
        'orcamentos mov, cadclientes cli, cadprodutos pro  where cad.i_em' +
        'p_fil = mov.i_emp_fil  and cad.i_lan_orc = mov.i_lan_orc  and ca' +
        'd.i_cod_cli = cli.i_cod_cli  and mov.i_seq_pro = pro.i_seq_pro '
      
        ' and cad.c_fla_sit = '#39'A'#39' and (MOV.N_QTD_PRO - nvl(MOV.N_QTD_BAI,' +
        '0) -nvl(MOV.N_QTD_CAN,0) ) > 0 '
      
        ' and CAD.D_DAT_PRE between to_date('#39'01/07/2011'#39','#39'DD/MM/YYYY'#39') an' +
        'd to_date('#39'31/07/2011'#39','#39'DD/MM/YYYY'#39')'
      ' and CAD.C_IND_CAN = '#39'N'#39
      ' order by cad.d_dat_pre, CAD.T_HOR_ENT, CAD.I_LAN_ORC ')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select Extract(YEAR FROM  cad.d_dat_pre)  || Extract(MONTH FROM ' +
        'cad.d_dat_pre) MESANO, Extract(MONTH FROM cad.d_dat_pre) || '#39'/'#39' ' +
        '|| Extract(YEAR FROM  cad.d_dat_pre) MESANOF, CAD.I_EMP_FIL, cad' +
        '.d_dat_pre, cad.d_dat_orc, cad.i_lan_orc, cad.i_cod_cli, CAD.T_H' +
        'OR_ENT, cli.c_nom_cli,  CAD.C_ORD_COM, PRO.I_ALC_EMB alca, PRO.C' +
        '_IND_BOL bolso,  mov.n_qtd_pro, MOV.N_QTD_PRO - nvl(MOV.N_QTD_BA' +
        'I,0)  - nvl(MOV.N_QTD_CAN,0)  QTDREAL,  (MOV.N_QTD_PRO - nvl(MOV' +
        '.N_QTD_BAI,0) -nvl(MOV.N_QTD_CAN,0) )  * MOV.N_VLR_PRO TOTAL,  p' +
        'ro.c_nom_pro,PRO.C_COD_PRO, mov.c_cod_uni, mov.n_vlr_pro, MOV.N_' +
        'QTD_BAI,  MOV.C_DES_COR, MOV.I_COD_COR, MOV.C_PRO_REF, MOV.I_SEQ' +
        '_MOV, MOV.I_SEQ_ORD,  MOV.N_QTD_BAI  from cadorcamentos cad, mov' +
        'orcamentos mov, cadclientes cli, cadprodutos pro  where cad.i_em' +
        'p_fil = mov.i_emp_fil  and cad.i_lan_orc = mov.i_lan_orc  and ca' +
        'd.i_cod_cli = cli.i_cod_cli  and mov.i_seq_pro = pro.i_seq_pro '
      
        ' and cad.c_fla_sit = '#39'A'#39' and (MOV.N_QTD_PRO - nvl(MOV.N_QTD_BAI,' +
        '0) -nvl(MOV.N_QTD_CAN,0) ) > 0 '
      
        ' and CAD.D_DAT_PRE between to_date('#39'01/07/2011'#39','#39'DD/MM/YYYY'#39') an' +
        'd to_date('#39'31/07/2011'#39','#39'DD/MM/YYYY'#39')'
      ' and CAD.C_IND_CAN = '#39'N'#39
      ' order by cad.d_dat_pre, CAD.T_HOR_ENT, CAD.I_LAN_ORC ')
    Left = 512
    Top = 136
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
    Left = 512
    Top = 192
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
      
        'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_P' +
        'RO, MOV.N_VLR_TOT, MOV.C_NOM_PRO PRODUTOCOTACAO,  MOV.C_IND_BRI,' +
        ' MOV.N_SAL_BRI, MOV.C_DES_COR, MOV.N_ALT_PRO, MOV.N_PER_DES,  MO' +
        'V.C_DES_COR CORCOTACAO, MOV.C_PRO_REF, MOV.N_PER_DES, MOV.C_ORD_' +
        'COM, MOV.I_COD_TAM,  COR.COD_COR, COR.NOM_COR,  PRO.C_NOM_PRO,  ' +
        'TAM.NOMTAMANHO,  CLA.C_COD_CLA, CLA.C_NOM_CLA,  MPR.N_QTD_PRO  f' +
        'rom MOVORCAMENTOS MOV, CADPRODUTOS PRO, COR, TAMANHO TAM, CADCLA' +
        'SSIFICACAO CLA, MOVQDADEPRODUTO MPR  where MOV.I_EMP_FIL = 11 AN' +
        'D MOV.I_LAN_ORC = 31226 AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO AND PR' +
        'O.I_COD_EMP = CLA.I_COD_EMP  AND PRO.C_COD_CLA = CLA.C_COD_CLA  ' +
        'AND PRO.C_TIP_CLA = CLA.C_TIP_CLA  AND MOV.I_SEQ_PRO = MPR.I_SEQ' +
        '_PRO  AND   MOV.I_COD_COR = MPR.I_COD_COR (+)  AND   MOV.I_COD_T' +
        'AM = MPR.I_COD_TAM (+)  AND   MOV.I_COD_COR = COR.COD_COR (+)  A' +
        'ND   MOV.I_COD_TAM = TAM.CODTAMANHO (+)  ORDER BY MOV.I_SEQ_MOV ')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_P' +
        'RO, MOV.N_VLR_TOT, MOV.C_NOM_PRO PRODUTOCOTACAO,  MOV.C_IND_BRI,' +
        ' MOV.N_SAL_BRI, MOV.C_DES_COR, MOV.N_ALT_PRO, MOV.N_PER_DES,  MO' +
        'V.C_DES_COR CORCOTACAO, MOV.C_PRO_REF, MOV.N_PER_DES, MOV.C_ORD_' +
        'COM, MOV.I_COD_TAM,  COR.COD_COR, COR.NOM_COR,  PRO.C_NOM_PRO,  ' +
        'TAM.NOMTAMANHO,  CLA.C_COD_CLA, CLA.C_NOM_CLA,  MPR.N_QTD_PRO  f' +
        'rom MOVORCAMENTOS MOV, CADPRODUTOS PRO, COR, TAMANHO TAM, CADCLA' +
        'SSIFICACAO CLA, MOVQDADEPRODUTO MPR  where MOV.I_EMP_FIL = 11 AN' +
        'D MOV.I_LAN_ORC = 31226 AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO AND PR' +
        'O.I_COD_EMP = CLA.I_COD_EMP  AND PRO.C_COD_CLA = CLA.C_COD_CLA  ' +
        'AND PRO.C_TIP_CLA = CLA.C_TIP_CLA  AND MOV.I_SEQ_PRO = MPR.I_SEQ' +
        '_PRO  AND   MOV.I_COD_COR = MPR.I_COD_COR (+)  AND   MOV.I_COD_T' +
        'AM = MPR.I_COD_TAM (+)  AND   MOV.I_COD_COR = COR.COD_COR (+)  A' +
        'ND   MOV.I_COD_TAM = TAM.CODTAMANHO (+)  ORDER BY MOV.I_SEQ_MOV ')
    Left = 136
    Top = 8
  end
  object rvItem: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    OnGetRow = rvItemGetRow
    DataSet = Item
    Left = 144
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
      
        'SELECT ORC.CODFILIAL, ORC.NUMCHAMADO, ORC.SEQITEM, ORC.SEQPRODUT' +
        'O, ORC.DESNUMSERIE, PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_PRO,' +
        'ORC.QTDPRODUTO, ORC.VALUNITARIO, ORC.VALTOTAL, ORC.DESUM  FROM C' +
        'HAMADOPRODUTOORCADO ORC, CADPRODUTOS PRO  WHERE ORC.CODFILIAL = ' +
        '11 AND ORC.NUMCHAMADO = 5135 AND ORC.SEQPRODUTO = PRO.I_SEQ_PRO ')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'SELECT ORC.CODFILIAL, ORC.NUMCHAMADO, ORC.SEQITEM, ORC.SEQPRODUT' +
        'O, ORC.DESNUMSERIE, PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_PRO,' +
        'ORC.QTDPRODUTO, ORC.VALUNITARIO, ORC.VALTOTAL, ORC.DESUM  FROM C' +
        'HAMADOPRODUTOORCADO ORC, CADPRODUTOS PRO  WHERE ORC.CODFILIAL = ' +
        '11 AND ORC.NUMCHAMADO = 5135 AND ORC.SEQPRODUTO = PRO.I_SEQ_PRO ')
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
      
        ' Select ppr.seqproposta,  PPR.SeqItem, PPR.SeqProduto, PPR.CodFo' +
        'rmatoFrasco, PPR.CodMaterialFrasco,  PPR.AltFrasco,  PPR.LarFras' +
        'co, PPR.ProFrasco, PPR.DiaFrasco, PPR.LarRotulo,  PPR.LarContraR' +
        'otulo, PPR.LarGargantilha, PPR.AltRotulo, PPR.AltContraRotulo, P' +
        'PR.OBSPRODUTO, PPR.DESPROROTULADO,  PPR.AltGargantilha,  PPR.Cod' +
        'MaterialRotulo, PPR.CodLinerRotulo, PPR.CodMaterialContraRotulo,' +
        ' PPR.CodLinerContraRotulo,   PPR.CodMaterialGargantilha, PPR.Cod' +
        'LinerGargantilha, PPR.QTDFRASCOHORA,  PRO.C_COD_PRO, PRO.C_NOM_P' +
        'RO,  FOF.NomFormato,   MAF.NomMaterialFrasco, PRO.C_NOM_PRO  FRO' +
        'M PROPOSTAPRODUTOROTULADO PPR, FORMATOFRASCO FOF, MATERIALFRASCO' +
        ' MAF, CADPRODUTOS PRO  WHERE   PPR.CODFORMATOFRASCO = MAF.CODMAT' +
        'ERIALFRASCO (+)        AND   PPR.CODFORMATOFRASCO = FOF.CODFORMA' +
        'TO (+)        AND PPR.SEQPRODUTO = PRO.I_SEQ_PRO        AND PPR.' +
        'CODFILIAL = 11       AND PPR.SEQPROPOSTA = 723 ORDER BY PPR.SEQI' +
        'TEM ')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        ' Select ppr.seqproposta,  PPR.SeqItem, PPR.SeqProduto, PPR.CodFo' +
        'rmatoFrasco, PPR.CodMaterialFrasco,  PPR.AltFrasco,  PPR.LarFras' +
        'co, PPR.ProFrasco, PPR.DiaFrasco, PPR.LarRotulo,  PPR.LarContraR' +
        'otulo, PPR.LarGargantilha, PPR.AltRotulo, PPR.AltContraRotulo, P' +
        'PR.OBSPRODUTO, PPR.DESPROROTULADO,  PPR.AltGargantilha,  PPR.Cod' +
        'MaterialRotulo, PPR.CodLinerRotulo, PPR.CodMaterialContraRotulo,' +
        ' PPR.CodLinerContraRotulo,   PPR.CodMaterialGargantilha, PPR.Cod' +
        'LinerGargantilha, PPR.QTDFRASCOHORA,  PRO.C_COD_PRO, PRO.C_NOM_P' +
        'RO,  FOF.NomFormato,   MAF.NomMaterialFrasco, PRO.C_NOM_PRO  FRO' +
        'M PROPOSTAPRODUTOROTULADO PPR, FORMATOFRASCO FOF, MATERIALFRASCO' +
        ' MAF, CADPRODUTOS PRO  WHERE   PPR.CODFORMATOFRASCO = MAF.CODMAT' +
        'ERIALFRASCO (+)        AND   PPR.CODFORMATOFRASCO = FOF.CODFORMA' +
        'TO (+)        AND PPR.SEQPRODUTO = PRO.I_SEQ_PRO        AND PPR.' +
        'CODFILIAL = 11       AND PPR.SEQPROPOSTA = 723 ORDER BY PPR.SEQI' +
        'TEM ')
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
    Left = 616
    Top = 136
  end
  object rvVendaAdicional: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = VendaAdicional
    Left = 616
    Top = 192
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
  object Item6: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      ' Select PC.SEQPRODUTOCHAMADO, PC.SEQITEMCHAMADO,  PC.VALTOTAL,'
      ' PRO.C_COD_PRO, PRO.C_NOM_PRO  '
      'from PROPOSTAPRODUTOSCHAMADO PC, CADPRODUTOS PRO  '
      'Where PC.SEQPRODUTOCHAMADO = PRO.I_SEQ_PRO'
      '  AND PC.CODFILIAL = 11'
      ' AND PC.SEQPROPOSTA = 1  ORDER BY PC.SEQITEMCHAMADO ')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      ' Select PC.SEQPRODUTOCHAMADO, PC.SEQITEMCHAMADO,  PC.VALTOTAL,'
      ' PRO.C_COD_PRO, PRO.C_NOM_PRO  '
      'from PROPOSTAPRODUTOSCHAMADO PC, CADPRODUTOS PRO  '
      'Where PC.SEQPRODUTOCHAMADO = PRO.I_SEQ_PRO'
      '  AND PC.CODFILIAL = 11'
      ' AND PC.SEQPROPOSTA = 1  ORDER BY PC.SEQITEMCHAMADO ')
    Left = 432
    Top = 8
  end
  object rvItem6: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Item6
    Left = 432
    Top = 64
  end
  object ChamadoProposta: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'select numchamado from chamadoproposta')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'select numchamado from chamadoproposta')
    Left = 272
    Top = 136
    object ChamadoPropostaNUMCHAMADO: TFMTBCDField
      FieldName = 'NUMCHAMADO'
      Required = True
      Precision = 10
      Size = 0
    end
  end
  object RvChamadoProposta: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = ChamadoProposta
    Left = 272
    Top = 192
  end
  object RTF: TRvRenderRTF
    DisplayName = 'Rich Text Format (RTF)'
    FileExtension = '*.rtf'
    ImageEncoding = ieBinary
    Left = 80
    Top = 128
  end
  object Item7: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'Select VALPAGAMENTO, DESCONDICAO, DESFORMAPAGAMENTO'
      'from PROPOSTAFORMAPAGAMENTO'
      'Where CODFILIAL = 11'
      'AND SEQPROPOSTA = 1216')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select VALPAGAMENTO, DESCONDICAO, DESFORMAPAGAMENTO'
      'from PROPOSTAFORMAPAGAMENTO'
      'Where CODFILIAL = 11'
      'AND SEQPROPOSTA = 1216')
    Left = 496
    Top = 8
  end
  object rvItem7: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Item7
    Left = 496
    Top = 64
  end
  object Promissoria: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 608
    Top = 248
    Data = {
      1C0100009619E0BD0100000018000000080000000000030000001C010C446573
      4475706C696361746101004900000001000557494454480200020032000C5661
      6C4475706C696361746108000400000000000F44657356616C6F72457874656E
      736F01004900000001000557494454480200020064000D4465734C6F63616C65
      446174610100490000000100055749445448020002006400104E756D44696156
      656E63696D656E746F04000100000000001044657344696156656E63696D656E
      746F0100490000000100055749445448020002001400104E756D416E6F56656E
      63696D656E746F01004900000001000557494454480200020014000E4465734D
      657356656E63696D746F01004900000001000557494454480200020014000000}
    object PromissoriaDesDuplicata: TStringField
      FieldName = 'DesDuplicata'
      Size = 50
    end
    object PromissoriaValDuplicata: TFloatField
      FieldName = 'ValDuplicata'
    end
    object PromissoriaDesValorExtenso: TStringField
      FieldName = 'DesValorExtenso'
      Size = 100
    end
    object PromissoriaDesLocaleData: TStringField
      FieldName = 'DesLocaleData'
      Size = 100
    end
    object PromissoriaNumDiaVencimento: TIntegerField
      FieldName = 'NumDiaVencimento'
    end
    object PromissoriaDesDiaVencimento: TStringField
      FieldName = 'DesDiaVencimento'
    end
    object PromissoriaNumAnoVencimento: TStringField
      FieldName = 'NumAnoVencimento'
    end
    object PromissoriaDesMesVencimto: TStringField
      FieldName = 'DesMesVencimto'
    end
  end
  object RvPromissoria: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Promissoria
    Left = 608
    Top = 296
  end
end
