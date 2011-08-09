object FProdutosCliente: TFProdutosCliente
  Left = 36
  Top = 91
  ActiveControl = Grade
  Caption = 'Produtos Cliente'
  ClientHeight = 414
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object EDono: TEditLocaliza
    Left = 360
    Top = 256
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
    ACampoObrigatorio = False
    AIgnorarCor = False
    ACorFoco = FPrincipal.CorFoco
    AInteiro = 0
    ADataBase = FPrincipal.BaseDados
    ACorForm = FPrincipal.CorForm
    ACorPainelGra = FPrincipal.CorPainelGra
    ALocaliza = ConsultaPadrao1
    ASelectValida.Strings = (
      'SELECT * FROM DONOPRODUTO'
      'Where CODDONO = @')
    ASelectLocaliza.Strings = (
      'SELECT * FROM DONOPRODUTO'
      'Where NOMDONO LIKE '#39'@%'#39
      'order by NOMDONO')
    APermitirVazio = True
    AInfo.CampoCodigo = 'CODDONO'
    AInfo.CampoNome = 'NOMDONO'
    AInfo.Nome1 = 'C'#243'digo'
    AInfo.Nome2 = 'Nome'
    AInfo.Tamanho1 = 8
    AInfo.Tamanho2 = 40
    AInfo.Tamanho3 = 0
    AInfo.TituloForm = '   Localiza Propriet'#225'rio Produto   '
    AInfo.Cadastrar = True
    AInfo.RetornoExtra1 = 'NOMDONO'
    ADarFocoDepoisdoLocaliza = False
    OnCadastrar = EDonoCadastrar
    OnRetorno = EDonoRetorno
  end
  object PanelColor3: TPanelColor
    Left = 0
    Top = 71
    Width = 715
    Height = 302
    Align = alClient
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object Splitter1: TSplitter
      Left = 1
      Top = 204
      Width = 713
      Height = 8
      Cursor = crVSplit
      Align = alBottom
      Beveled = True
    end
    object Grade: TRBStringGridColor
      Left = 1
      Top = 1
      Width = 713
      Height = 203
      Align = alClient
      Color = clInfoBk
      ColCount = 15
      DefaultRowHeight = 18
      DrawingStyle = gdsClassic
      FixedColor = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnGetEditMask = GradeGetEditMask
      OnKeyDown = GradeKeyDown
      OnSelectCell = GradeSelectCell
      ACorFoco = FPrincipal.CorFoco
      ALinha = 0
      AColuna = 0
      AEstadoGrade = egNavegacao
      APermiteExcluir = True
      APermiteInserir = True
      APossuiDadosForadaGrade = False
      ReadOnly = False
      OnDadosValidos = GradeDadosValidos
      onDadosValidosForaGrade = GradeDadosValidosForaGrade
      OnMudouLinha = GradeMudouLinha
      OnNovaLinha = GradeNovaLinha
      OnCarregaItemGrade = GradeCarregaItemGrade
      ColWidths = (
        7
        115
        314
        35
        85
        87
        89
        73
        185
        134
        161
        146
        113
        94
        346)
    end
    object EObservacoes: TMemoColor
      Left = 1
      Top = 212
      Width = 713
      Height = 89
      Align = alBottom
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = EObservacoesChange
      OnExit = EObservacoesExit
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
    end
  end
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 715
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Produtos Cliente   '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = FPrincipal.CorPainelGra
  end
  object PanelColor1: TPanelColor
    Left = 0
    Top = 41
    Width = 715
    Height = 30
    Align = alTop
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
    object SpeedButton1: TSpeedButton
      Left = 147
      Top = 3
      Width = 27
      Height = 26
      Enabled = False
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
    object Label1: TLabel
      Left = 32
      Top = 7
      Width = 47
      Height = 16
      Caption = 'Cliente :'
    end
    object Label2: TLabel
      Left = 176
      Top = 7
      Width = 60
      Height = 16
      Caption = '                    '
    end
    object ECliente: TEditLocaliza
      Left = 81
      Top = 3
      Width = 65
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
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
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'Select * from CADCLIENTES'
        'where I_COD_CLI = @')
      ASelectLocaliza.Strings = (
        'Select * from CADCLIENTES'
        'where C_NOM_CLI like '#39'@%'#39)
      APermitirVazio = True
      AInfo.CampoCodigo = 'I_COD_CLI'
      AInfo.CampoNome = 'C_NOM_CLI'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Cliente   '
      ADarFocoDepoisdoLocaliza = True
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 373
    Width = 715
    Height = 41
    Align = alBottom
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object BGravar: TBitBtn
      Left = 245
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Gravar'
      DoubleBuffered = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = BGravarClick
    end
    object BCancelar: TBitBtn
      Left = 344
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Cancelar'
      DoubleBuffered = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = BCancelarClick
    end
    object BFechar: TBitBtn
      Left = 600
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
      TabOrder = 2
      OnClick = BFecharClick
    end
  end
  object ConsultaPadrao1: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 264
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 408
    Top = 8
    object MProdutoReserva: TMenuItem
      Caption = 'Pe'#231'as M'#225'quina'
      OnClick = MProdutoReservaClick
    end
  end
end
