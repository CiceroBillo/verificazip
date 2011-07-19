object FProspects: TFProspects
  Left = 0
  Top = 20
  Caption = 'Suspect'#39's'
  ClientHeight = 406
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 788
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Suspect'#180's   '
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
    Width = 788
    Height = 122
    Align = alTop
    Caption = '`'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object Label2: TLabel
      Left = 240
      Top = 7
      Width = 25
      Height = 16
      Caption = 'at'#233' :'
    end
    object Label11: TLabel
      Left = 527
      Top = 58
      Width = 66
      Height = 16
      Alignment = taRightJustify
      Caption = 'Vendedor :'
    end
    object SpeedButton4: TSpeedButton
      Left = 670
      Top = 54
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
    object LNomVendedor: TLabel
      Left = 702
      Top = 58
      Width = 57
      Height = 16
      Caption = '                   '
    end
    object Label1: TLabel
      Left = 86
      Top = 33
      Width = 43
      Height = 16
      Alignment = taRightJustify
      Caption = 'Nome :'
    end
    object Label3: TLabel
      Left = 31
      Top = 58
      Width = 98
      Height = 16
      Alignment = taRightJustify
      Caption = 'Nome Fantasia :'
    end
    object Label5: TLabel
      Left = 487
      Top = 33
      Width = 106
      Height = 16
      Alignment = taRightJustify
      Caption = 'Meio divulga'#231#227'o :'
    end
    object SpeedButton1: TSpeedButton
      Left = 670
      Top = 29
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
    object LMeioDivulgacao: TLabel
      Left = 702
      Top = 33
      Width = 57
      Height = 16
      Caption = '                   '
    end
    object Label7: TLabel
      Left = 79
      Top = 84
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cidade :'
    end
    object Label6: TLabel
      Left = 471
      Top = 7
      Width = 122
      Height = 16
      Alignment = taRightJustify
      Caption = 'Ramo de Atividade :'
    end
    object SpeedButton2: TSpeedButton
      Left = 670
      Top = 3
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
    object Label8: TLabel
      Left = 702
      Top = 7
      Width = 57
      Height = 16
      Caption = '                   '
    end
    object CPeriodo: TCheckBox
      Left = 24
      Top = 7
      Width = 105
      Height = 17
      Caption = 'Cadastro de :'
      TabOrder = 0
      OnClick = CPeriodoClick
    end
    object EDatInicio: TCalendario
      Left = 136
      Top = 3
      Width = 97
      Height = 24
      Date = 39178.828942777800000000
      Time = 39178.828942777800000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnCloseUp = CPeriodoClick
      OnExit = CPeriodoClick
      ACorFoco = FPrincipal.CorFoco
    end
    object EDatFim: TCalendario
      Left = 271
      Top = 3
      Width = 98
      Height = 24
      Date = 39178.828981481500000000
      Time = 39178.828981481500000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnCloseUp = CPeriodoClick
      OnExit = CPeriodoClick
      ACorFoco = FPrincipal.CorFoco
    end
    object EVendedor: TEditLocaliza
      Left = 598
      Top = 54
      Width = 69
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = LNomVendedor
      ABotao = SpeedButton4
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from dba.CadVendedores'
        'Where I_Cod_Ven = @')
      ASelectLocaliza.Strings = (
        'Select * from dba.CadVendedores'
        'Where C_Nom_Ven like '#39'@%'#39
        'order by c_Nom_Ven')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_Cod_Ven'
      AInfo.CampoNome = 'C_Nom_Ven'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Vendedor   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = CPeriodoClick
    end
    object ENome: TEditColor
      Left = 135
      Top = 29
      Width = 338
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnExit = ENomeExit
      OnKeyDown = ENomeKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
    end
    object ENomeFantasia: TEditColor
      Left = 135
      Top = 54
      Width = 338
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnExit = ENomeFantasiaExit
      OnKeyDown = ENomeFantasiaKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
    end
    object CContatovendedor: TCheckBox
      Left = 135
      Top = 104
      Width = 326
      Height = 17
      Caption = 'Somente o que o vendedor n'#227'o entrou em contato'
      TabOrder = 9
      OnClick = CPeriodoClick
    end
    object EMeioDivulgacao: TEditLocaliza
      Left = 598
      Top = 29
      Width = 69
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = LMeioDivulgacao
      ABotao = SpeedButton1
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select CODMEIODIVULGACAO, DESMEIODIVULGACAO'
        ' from MEIODIVULGACAO'
        'Where CODMEIODIVULGACAO = @')
      ASelectLocaliza.Strings = (
        'Select CODMEIODIVULGACAO, DESMEIODIVULGACAO'
        ' from MEIODIVULGACAO'
        'Where DESMEIODIVULGACAO like '#39'@%'#39
        'order by DESMEIODIVULGACAO')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'CODMEIODIVULGACAO'
      AInfo.CampoNome = 'DESMEIODIVULGACAO'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Meio Divulga'#231#227'o   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = CPeriodoClick
    end
    object ECidade: TEditColor
      Left = 135
      Top = 80
      Width = 338
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnExit = ECidadeExit
      OnKeyDown = ECidadeKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
    end
    object ERamoAtividade: TEditLocaliza
      Left = 598
      Top = 3
      Width = 69
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label8
      ABotao = SpeedButton2
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'SELECT * FROM RAMO_ATIVIDADE'
        'WHERE COD_RAMO_ATIVIDADE = @')
      ASelectLocaliza.Strings = (
        'SELECT * FROM RAMO_ATIVIDADE'
        'WHERE NOM_RAMO_ATIVIDADE LIKE '#39'@%'#39
        'ORDER BY NOM_RAMO_ATIVIDADE')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'COD_RAMO_ATIVIDADE'
      AInfo.CampoNome = 'NOM_RAMO_ATIVIDADE'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '  Localiza Ramo Atividade  '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = CPeriodoClick
    end
  end
  object GridIndice1: TGridIndice
    Left = 0
    Top = 163
    Width = 788
    Height = 203
    Align = alClient
    Color = clInfoBk
    DataSource = DataProspect
    DrawingStyle = gdsClassic
    FixedColor = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    ACorFoco = FPrincipal.CorFoco
    AListaIndice.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5')
    AListaCAmpos.Strings = (
      'CODPROSPECT'
      'NOMPROSPECT'
      'NOMFANTASIA'
      'PRO.CODMEIODIVULGACAO'
      'DATCADASTRO'
      'DESCIDADE')
    AindiceInicial = 0
    ALinhaSQLOrderBy = 0
    OnOrdem = GridIndice1Ordem
    Columns = <
      item
        Expanded = False
        FieldName = 'CODPROSPECT'
        Title.Caption = 'C'#243'digo  [>]'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMPROSPECT'
        Title.Caption = 'Nome  [+]'
        Width = 224
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMFANTASIA'
        Title.Caption = 'Nome Fantasia  [+]'
        Width = 226
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESMEIODIVULGACAO'
        Title.Caption = 'Meio Divulga'#231#227'o  [+]'
        Width = 202
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATCADASTRO'
        Title.Caption = 'Cadastro  [+]'
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCIDADE'
        Title.Caption = 'Cidade  [+]'
        Width = 208
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESFONE1'
        Title.Caption = 'Telefone'
        Visible = True
      end>
  end
  object PGraficos: TCorPainelGra
    Left = 296
    Top = 80
    Width = 173
    Height = 304
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = 'Gr'#225'ficos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    AColorFim = clNavy
    AColorSombra = clWhite
    AColorInicio = clNavy
    AEfeitosTexto = teNenhum
    AVertAlign = vlTopo
    AMoveable = True
    object BitBtn4: TBitBtn
      Left = 676
      Top = 3
      Width = 16
      Height = 17
      Caption = 'X'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
    end
    object PanelColor5: TPanelColor
      Left = 2
      Top = 19
      Width = 169
      Height = 283
      Align = alBottom
      Caption = 'PanelColor5'
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
      object Label17: TLabel
        Left = 214
        Top = 87
        Width = 57
        Height = 16
        Caption = '                   '
      end
      object Label18: TLabel
        Left = 214
        Top = 50
        Width = 51
        Height = 16
        Caption = '                 '
      end
      object BMeioDivulgacao: TBitBtn
        Left = 1
        Top = 1
        Width = 168
        Height = 30
        Caption = '&Meio Divulga'#231#227'o'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = BMeioDivulgacaoClick
      end
      object BFechaGrafico: TBitBtn
        Left = 1
        Top = 254
        Width = 168
        Height = 30
        HelpContext = 8
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
        TabOrder = 6
        OnClick = BFechaGraficoClick
      end
      object BVendedor: TBitBtn
        Left = 1
        Top = 30
        Width = 168
        Height = 30
        Caption = '&Vendedor'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = BVendedorClick
      end
      object BProduto: TBitBtn
        Left = 1
        Top = 59
        Width = 168
        Height = 30
        Caption = '&Cidade'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        OnClick = BProdutoClick
      end
      object BData: TBitBtn
        Left = 1
        Top = 88
        Width = 168
        Height = 30
        Caption = '&Ramo Atividade'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 3
        OnClick = BDataClick
      end
      object BFlag: TBitBtn
        Left = 1
        Top = 117
        Width = 168
        Height = 30
        Caption = '&Profiss'#227'o'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 4
        OnClick = BFlagClick
      end
      object BCondicao: TBitBtn
        Left = 1
        Top = 146
        Width = 168
        Height = 30
        Caption = '*&Data'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 5
        OnClick = BCondicaoClick
      end
      object BMes: TBitBtn
        Left = 1
        Top = 175
        Width = 168
        Height = 30
        Caption = '*&M'#234's'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 8
        OnClick = BMesClick
      end
      object BEstado: TBitBtn
        Left = 1
        Top = 204
        Width = 168
        Height = 30
        Caption = 'UF'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 7
        OnClick = BEstadoClick
      end
    end
  end
  object PanelColor4: TPanelColor
    Left = 0
    Top = 366
    Width = 788
    Height = 40
    Align = alBottom
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object BotaoCadastrar1: TBotaoCadastrar
      Left = 5
      Top = 5
      Width = 100
      Height = 30
      Hint = 'Incluir|Incluir novo registro'
      Caption = '&Cadastrar'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000CE0E0000D80E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330FEEFEEEF07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0FEEEEFEF0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330FEEF000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330FE8F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      OnAntesAtividade = BotaoCadastrar1AntesAtividade
      OnDepoisAtividade = BotaoCadastrar1DepoisAtividade
    end
    object BotaoAlterar1: TBotaoAlterar
      Left = 104
      Top = 5
      Width = 100
      Height = 30
      Hint = 'Alterar|Altera registro selecionado'
      Caption = '&Alterar'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
        555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
        05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
        FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
        FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
        FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
        05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
        555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
        9055575757575757775505050505055505557575757575557555}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnAntesAtividade = BotaoCadastrar1AntesAtividade
      OnDepoisAtividade = BotaoCadastrar1DepoisAtividade
      OnAtividade = BotaoAlterar1Atividade
    end
    object BotaoConsultar1: TBotaoConsultar
      Left = 203
      Top = 5
      Width = 100
      Height = 30
      Hint = 'Consultar|Consulta do registro selecionado'
      Caption = 'C&onsultar'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555500000000
        0555555F7777777775F55500FFFFFFFFF0555577F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FFFFFFFFF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FF777FFFF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FF7F777FF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FF77F7FFF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FFFFFFFFF05557F7FF5F5F5F57F550F00F0F0F0F
        005557F77F7F7F7F77555055070707070555575F7F7F7F7F7F55550507070707
        0555557575757575755555505050505055555557575757575555}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 2
      OnAntesAtividade = BotaoCadastrar1AntesAtividade
      OnDepoisAtividade = BotaoCadastrar1DepoisAtividade
      OnAtividade = BotaoAlterar1Atividade
    end
    object BotaoExcluir1: TBotaoExcluir
      Left = 302
      Top = 5
      Width = 100
      Height = 30
      Hint = 'Excluir|Exclui registro seleciondo'
      Caption = '&Excluir'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 3
      OnAntesAtividade = BotaoCadastrar1AntesAtividade
      OnDepoisAtividade = BotaoExcluir1DepoisAtividade
      OnAtividade = BotaoAlterar1Atividade
      OnDestroiFormulario = BotaoExcluir1DestroiFormulario
    end
    object BGraficos: TBitBtn
      Left = 401
      Top = 5
      Width = 100
      Height = 30
      HelpContext = 65
      Caption = '&Graficos'
      DoubleBuffered = True
      Glyph.Data = {
        9E020000424D9E0200000000000076000000280000002F000000170000000100
        04000000000028020000CE0E0000D80E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333303333333333333333333333333333
        3333333333333333333033333333333333333333333333333333333333333333
        3330333373737373737373737333337F7F7F7F7F7F7F7F7F3330333000000000
        000000000333F7777777777777777773333033703993CC3223EE3113333377F7
        7F77F77F77F77F33333033303993CC3223EE31133333F7F77F77F77F77F77F33
        333033703993CC3223EE3113333377F77F77F77F77F77333333033303993CC32
        23EE33333333F7F77F77F77F77F33333333033703993CC3223EE3333333377F7
        7377F77F77F33333333033303333CC3223EE33333333F7F33377F77F77F33333
        333033703333CC3223EE3333333377F33377F77F77F33333333033303333CC32
        23EE33333333F7F33377377F77F33333333033703333333223EE3333333377F3
        3333377F77F33333333033303333333223EE33333333F7F33333377F77333333
        333033703333333223333333333377F33333377F333333333330333033333332
        233333333333F7F33333377333333333333033703333333333333333333377F3
        33333333333333333330333033333333333333333333F7F33333333333333333
        333033703333333333333333333377F333333333333333333330333033333333
        3333333333333733333333333333333333303333333333333333333333333333
        3333333333333333333033333333333333333333333333333333333333333333
        3330}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = BGraficosClick
    end
    object BProdutos: TBitBtn
      Left = 500
      Top = 5
      Width = 95
      Height = 30
      HelpContext = 8
      Caption = '&Produtos'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333300333
        33333333333773FF333333333330F0033333333333373773FF333333330FFFF0
        03333333337F333773FF3333330FFFFFF003333333733FF33773333330FF00FF
        FF80333337F3773F3337333330FFFF0FFFF03FFFF7FFF3733F3700000000FFFF
        0FF0777777773FF373370000000000FFFFF07FFFFFF377FFF3370CCCCC000000
        FF037777773337773F7300CCC000003300307F77733337F37737000C00000033
        33307F373333F7F333370000007B703333307FFFF337F7F33337099900BBB033
        33307777F37777FF33370999007B700333037777F3373773FF73099900000030
        00337777FFFFF7F7773300000000003333337777777777333333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 5
      OnClick = BProdutosClick
    end
    object BContatos: TBitBtn
      Left = 594
      Top = 5
      Width = 100
      Height = 30
      HelpContext = 8
      Caption = 'Con&tatos'
      DoubleBuffered = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0FFFF00FFFF00FFFF00000000000000FFFF00FFFF00000000000000FFFF00FF
        FF00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFF00
        FFFF00000000FFFF00FFFF00000000000000FFFF00000000FFFF00000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000FF
        FF00FFFF00000000BFBFBFFFFFFF000000000000000000C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000000000
        00BFBFBFFFFFFFBFBFBF000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000BFBFBFFFFFFF
        000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000BFBFBFFFFFFFBF
        BFBFFFFFFFBFBFBF000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000FFFFFFBFBFBFFFFFFFBFBF
        BF000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0000000000000000000000000BFBFBFFFFFFFBFBFBFFFFFFFBFBFBF
        000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000
        00000000000000000000BFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBF00
        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000
        000000000000000000000000FFFFFFBFBFBFFF0000BFBFBF000000C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000
        0000000000FFFFFFBFBFBFFFFFFF000000000000C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000000000000000007F7F
        7FBFBFBFFFFFFFBFBFBFFFFFFF000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000000000000000000000
        7F7F7FFFFFFF000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000000000000000000000
        0000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C00000000000000000000000000000000000000000
        00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0}
      ParentDoubleBuffered = False
      TabOrder = 6
      OnClick = BContatosClick
    end
    object BFechar: TBitBtn
      Left = 698
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
      TabOrder = 7
      OnClick = BFecharClick
    end
  end
  object Prospect: TSQL
    Aggregates = <>
    PacketRecords = 200
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select CODPROSPECT, NOMPROSPECT, NOMFANTASIA, TIPPESSOA, DESENDE' +
        'RECO, DESCIDADE, DESFONE1, DATCADASTRO,'
      '       MEI.DESMEIODIVULGACAO'
      'from PROSPECT PRO, MEIODIVULGACAO MEI'
      '')
    object ProspectCODPROSPECT: TFMTBCDField
      FieldName = 'CODPROSPECT'
      Origin = 'BASEDADOS.PROSPECT.CODPROSPECT'
    end
    object ProspectNOMPROSPECT: TWideStringField
      FieldName = 'NOMPROSPECT'
      Origin = 'BASEDADOS.PROSPECT.NOMPROSPECT'
      Size = 50
    end
    object ProspectNOMFANTASIA: TWideStringField
      FieldName = 'NOMFANTASIA'
      Origin = 'BASEDADOS.PROSPECT.NOMFANTASIA'
      Size = 50
    end
    object ProspectTIPPESSOA: TWideStringField
      FieldName = 'TIPPESSOA'
      Origin = 'BASEDADOS.PROSPECT.TIPPESSOA'
      Size = 1
    end
    object ProspectDESENDERECO: TWideStringField
      FieldName = 'DESENDERECO'
      Origin = 'BASEDADOS.PROSPECT.DESENDERECO'
      Size = 50
    end
    object ProspectDESCIDADE: TWideStringField
      FieldName = 'DESCIDADE'
      Origin = 'BASEDADOS.PROSPECT.DESCIDADE'
      Size = 50
    end
    object ProspectDESFONE1: TWideStringField
      FieldName = 'DESFONE1'
      Origin = 'BASEDADOS.PROSPECT.DESFONE1'
    end
    object ProspectDATCADASTRO: TSQLTimeStampField
      FieldName = 'DATCADASTRO'
      Origin = 'BASEDADOS.PROSPECT.DATCADASTRO'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object ProspectDESMEIODIVULGACAO: TWideStringField
      FieldName = 'DESMEIODIVULGACAO'
      Origin = 'BASEDADOS.MEIODIVULGACAO.DESMEIODIVULGACAO'
      Size = 50
    end
  end
  object DataProspect: TDataSource
    AutoEdit = False
    DataSet = Prospect
    Left = 32
  end
  object GraficosTrio: TGraficosTrio
    ADataBase = FPrincipal.BaseDados
    AConfiguracoes = FPrincipal.CorPainelGra
    Left = 96
    Top = 1
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 212
  end
  object PopupMenu1: TPopupMenu
    Left = 272
    Top = 8
    object TelemarketingReceptivo1: TMenuItem
      Caption = 'Telemarketing Receptivo'
      OnClick = TelemarketingReceptivo1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object NovaAgenda1: TMenuItem
      Caption = 'Nova Agenda'
      OnClick = NovaAgenda1Click
    end
  end
end
