object FReferenciaProduto: TFReferenciaProduto
  Left = 31
  Top = 104
  Caption = 'Refer'#234'ncia Produto'
  ClientHeight = 358
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 681
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Refer'#234'ncia Produto   '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = FPrincipal.CorPainelGra
  end
  object PanelColor1: TPanelColor
    Left = 0
    Top = 41
    Width = 681
    Height = 69
    Align = alTop
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object Label1: TLabel
      Left = 24
      Top = 10
      Width = 47
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cliente :'
    end
    object SpeedButton1: TSpeedButton
      Left = 139
      Top = 6
      Width = 26
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000CE0E0000D80E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
        333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
        33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
        333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
    object Label2: TLabel
      Left = 173
      Top = 10
      Width = 249
      Height = 16
      AutoSize = False
      Caption = '                   '
    end
    object Label4: TLabel
      Left = 19
      Top = 40
      Width = 53
      Height = 16
      Alignment = taRightJustify
      Caption = 'Produto :'
    end
    object SpeedButton2: TSpeedButton
      Left = 154
      Top = 37
      Width = 26
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000CE0E0000D80E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
        333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
        33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
        333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
    object Label5: TLabel
      Left = 188
      Top = 45
      Width = 42
      Height = 16
      Caption = '              '
    end
    object ECliente: TEditLocaliza
      Left = 78
      Top = 6
      Width = 59
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label2
      ABotao = SpeedButton1
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from CadClientes '
        'Where I_Cod_cli = @')
      ASelectLocaliza.Strings = (
        'Select * from CadClientes '
        'Where C_Nom_Cli like '#39'@%'#39
        'order by c_Nom_Cli ')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_Cod_cli'
      AInfo.CampoNome = 'C_Nom_Cli'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Cliente   '
      ADarFocoDepoisdoLocaliza = True
      OnRetorno = EClienteRetorno
    end
    object EProduto: TEditLocaliza
      Left = 77
      Top = 37
      Width = 74
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label5
      ABotao = SpeedButton2
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      APermitirVazio = True
      AInfo.CampoCodigo = 'C_COD_PRO'
      AInfo.CampoNome = 'C_NOM_PRO'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '  Localiza Produto   '
      AInfo.Cadastrar = True
      AInfo.RetornoExtra1 = 'I_SEQ_PRO'
      ADarFocoDepoisdoLocaliza = True
      OnSelect = EProdutoSelect
      OnRetorno = EProdutoRetorno
    end
    object EConsultaProduto: TEditLocaliza
      Left = 565
      Top = 5
      Width = 74
      Height = 24
      TabStop = False
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label5
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      APermitirVazio = True
      AInfo.CampoCodigo = 'C_COD_PRO'
      AInfo.CampoNome = 'C_NOM_PRO'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '  Localiza Produto   '
      AInfo.Cadastrar = True
      AInfo.RetornoExtra1 = 'I_SEQ_PRO'
      ADarFocoDepoisdoLocaliza = False
      OnSelect = EProdutoSelect
      OnRetorno = EConsultaProdutoRetorno
    end
    object ECor: TEditLocaliza
      Left = 568
      Top = 32
      Width = 121
      Height = 24
      TabStop = False
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from COR'
        'Where COD_COR= @')
      ASelectLocaliza.Strings = (
        'Select * from COR'
        'Where NOM_COR LIKE '#39'@%'#39)
      APermitirVazio = True
      AInfo.CampoCodigo = 'COD_COR'
      AInfo.CampoNome = 'NOM_COR'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '  Localiza Cor   '
      AInfo.Cadastrar = True
      AInfo.RetornoExtra1 = 'NOM_COR'
      ADarFocoDepoisdoLocaliza = False
      OnCadastrar = ECorCadastrar
      OnRetorno = ECorRetorno
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 317
    Width = 681
    Height = 41
    Align = alBottom
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object BFechar: TBitBtn
      Left = 688
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Fechar'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = BFecharClick
    end
  end
  object GProdutos: TGridIndice
    Left = 0
    Top = 110
    Width = 681
    Height = 207
    Align = alClient
    Color = clInfoBk
    DataSource = DataProdutoReferencia
    FixedColor = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = GProdutosColEnter
    OnColExit = GProdutosColExit
    OnEditButtonClick = GProdutosEditButtonClick
    OnExit = GProdutosExit
    OnKeyDown = GProdutosKeyDown
    ACorFoco = FPrincipal.CorFoco
    AindiceInicial = 0
    ALinhaSQLOrderBy = 0
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_CLIENTE'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nom_Cliente'
        ReadOnly = True
        Title.Caption = 'Cliente'
        Width = 158
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'COD_PRODUTO'
        Title.Caption = 'C'#243'digo'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOM_PRODUTO'
        ReadOnly = True
        Title.Caption = 'Produto'
        Width = 162
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'COD_COR'
        Title.Caption = 'Cor'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nom_Cor'
        Title.Caption = 'Descri'#231#227'o'
        Width = 147
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DES_REFERENCIA'
        Title.Caption = 'Refer'#234'ncia'
        Width = 298
        Visible = True
      end>
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 340
    Top = 8
  end
  object ProdutoReferencia: TSQL
    Aggregates = <>
    PacketRecords = 20
    Params = <>
    ProviderName = 'InternalProvider'
    BeforeInsert = ProdutoReferenciaBeforeInsert
    AfterInsert = ProdutoReferenciaAfterInsert
    BeforePost = ProdutoReferenciaBeforePost
    AfterPost = ProdutoReferenciaAfterPost
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select * from PRODUTO_REFERENCIA')
    Left = 8
    Top = 1
    object ProdutoReferenciaSEQ_PRODUTO: TFMTBCDField
      FieldName = 'SEQ_PRODUTO'
      Origin = 'BASEDADOS.PRODUTO_REFERENCIA.SEQ_PRODUTO'
    end
    object ProdutoReferenciaSEQ_REFERENCIA: TFMTBCDField
      FieldName = 'SEQ_REFERENCIA'
      Origin = 'BASEDADOS.PRODUTO_REFERENCIA.SEQ_REFERENCIA'
    end
    object ProdutoReferenciaCOD_COR: TFMTBCDField
      FieldName = 'COD_COR'
      Origin = 'BASEDADOS.PRODUTO_REFERENCIA.COD_COR'
    end
    object ProdutoReferenciaDES_REFERENCIA: TWideStringField
      FieldName = 'DES_REFERENCIA'
      Origin = 'BASEDADOS.PRODUTO_REFERENCIA.DES_REFERENCIA'
      Size = 50
    end
    object ProdutoReferenciaCOD_PRODUTO: TWideStringField
      FieldName = 'COD_PRODUTO'
      Origin = 'BASEDADOS.PRODUTO_REFERENCIA.COD_PRODUTO'
    end
    object ProdutoReferenciaNOM_PRODUTO: TWideStringField
      FieldKind = fkLookup
      FieldName = 'NOM_PRODUTO'
      LookupDataSet = CadProdutos
      LookupKeyFields = 'I_SEQ_PRO'
      LookupResultField = 'C_NOM_PRO'
      KeyFields = 'SEQ_PRODUTO'
      Size = 50
      Lookup = True
    end
    object ProdutoReferenciaNom_Cor: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Nom_Cor'
      LookupDataSet = Cor
      LookupKeyFields = 'COD_COR'
      LookupResultField = 'NOM_COR'
      KeyFields = 'COD_COR'
      Size = 50
      Lookup = True
    end
    object ProdutoReferenciaCOD_CLIENTE: TFMTBCDField
      FieldName = 'COD_CLIENTE'
      Origin = 'BASEDADOS.PRODUTO_REFERENCIA.COD_CLIENTE'
    end
    object ProdutoReferenciaNom_Cliente: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Nom_Cliente'
      LookupDataSet = CadClientes
      LookupKeyFields = 'I_COD_CLI'
      LookupResultField = 'C_NOM_CLI'
      KeyFields = 'COD_CLIENTE'
      Size = 50
      Lookup = True
    end
  end
  object DataProdutoReferencia: TDataSource
    DataSet = ProdutoReferencia
    Left = 40
  end
  object CadProdutos: TSQL
    Aggregates = <>
    PacketRecords = 20
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select * from CADPRODUTOS')
    Left = 168
    Top = 1
  end
  object Cor: TSQL
    Aggregates = <>
    PacketRecords = 20
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select * from COR')
    Left = 200
    Top = 1
  end
  object CadClientes: TSQL
    Aggregates = <>
    PacketRecords = 20
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select * from CADCLIENTES')
    Left = 232
  end
end
