object FPrincipioAtivo: TFPrincipioAtivo
  Left = 149
  Top = 179
  Caption = 'Principio Ativo'
  ClientHeight = 412
  ClientWidth = 558
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
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 558
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Principio Ativo   '
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
    Width = 446
    Height = 371
    Align = alClient
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
      Left = 32
      Top = 12
      Width = 50
      Height = 16
      Caption = 'C'#243'digo :'
    end
    object Label2: TLabel
      Left = 14
      Top = 44
      Width = 68
      Height = 16
      Caption = 'Descri'#231#227'o :'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 96
      Width = 500
      Height = 17
      Shape = bsTopLine
    end
    object Label3: TLabel
      Left = 6
      Top = 100
      Width = 121
      Height = 16
      Caption = 'Nome para consulta'
    end
    object ECodigo: TDBKeyViolation
      Left = 88
      Top = 8
      Width = 57
      Height = 24
      Color = 11661566
      DataField = 'CODPRINCIPIO'
      DataSource = DataPrincipioAtivo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ACampoObrigatorio = True
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AFormatoData = False
      AIgnorarTipoLetra = False
      ADataBase = FPrincipal.BaseDados
      ATabela = 'PRINCIPIOATIVO'
    end
    object DBEditColor1: TDBEditColor
      Left = 88
      Top = 40
      Width = 345
      Height = 24
      Color = clInfoBk
      DataField = 'NOMPRINCIPIO'
      DataSource = DataPrincipioAtivo
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
      AFormatoData = False
      AIgnorarTipoLetra = False
    end
    object CControlado: TDBCheckBox
      Left = 88
      Top = 72
      Width = 217
      Height = 17
      Caption = 'Medicamento Controlado'
      DataField = 'INDCONTROLADO'
      DataSource = DataPrincipioAtivo
      TabOrder = 2
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object Consulta: TLocalizaEdit
      Left = 5
      Top = 117
      Width = 428
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
      ATabela = PrincipioAtivo
      ASelect.Strings = (
        'Select * from PRINCIPIOATIVO'
        'Where NOMPRINCIPIO LIKE '#39'@%'#39)
      AOrdem = 'order by NOMPRINCIPIO'
    end
    object Grade: TGridIndice
      Left = 6
      Top = 143
      Width = 427
      Height = 222
      Color = clInfoBk
      DataSource = DataPrincipioAtivo
      FixedColor = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      ACorFoco = FPrincipal.CorFoco
      AListaIndice.Strings = (
        '0'
        '1'
        '2')
      AListaCAmpos.Strings = (
        'CODPRINCIPIO'
        'NOMPRINCIPIO'
        'INDCONTROLADO')
      AindiceInicial = 2
      ALinhaSQLOrderBy = 1
      OnOrdem = GradeOrdem
      Columns = <
        item
          Expanded = False
          FieldName = 'CODPRINCIPIO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMPRINCIPIO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 231
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'INDCONTROLADO'
          Title.Alignment = taCenter
          Title.Caption = 'Controlado'
          Width = 74
          Visible = True
        end>
    end
  end
  object PanelColor2: TPanelColor
    Left = 446
    Top = 41
    Width = 112
    Height = 371
    Align = alRight
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
    object MoveBasico1: TMoveBasico
      Left = 8
      Top = 8
      Width = 100
      Height = 30
      AProximoCaption = ' '
      AProximoBitmap.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FF3333333333333447333333333333377FFF33333333333744473333333
        333337773FF3333333333444447333333333373F773FF3333333334444447333
        33333373F3773FF3333333744444447333333337F333773FF333333444444444
        733333373F3333773FF333334444444444733FFF7FFFFFFF77FF999999999999
        999977777777777733773333CCCCCCCCCC3333337333333F7733333CCCCCCCCC
        33333337F3333F773333333CCCCCCC3333333337333F7733333333CCCCCC3333
        333333733F77333333333CCCCC333333333337FF7733333333333CCC33333333
        33333777333333333333CC333333333333337733333333333333}
      AAnteriorCaption = ' '
      AAnteriorBitmap.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF3333333333333744333333333333F773333333333337
        44473333333333F777F3333333333744444333333333F7733733333333374444
        4433333333F77333733333333744444447333333F7733337F333333744444444
        433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
        9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
        C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
        CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
        CCC333333333333777FF33333333333333CC3333333333333773}
      caption = 'MoveBasico1'
    end
    object BotaoCadastrar1: TBotaoCadastrar
      Left = 8
      Top = 56
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
      TabOrder = 1
      AFoco = ECodigo
    end
    object BotaoAlterar1: TBotaoAlterar
      Left = 8
      Top = 85
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
      TabOrder = 2
      AFoco = DBEditColor1
    end
    object BotaoExcluir1: TBotaoExcluir
      Left = 8
      Top = 114
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
    end
    object BotaoGravar1: TBotaoGravar
      Left = 8
      Top = 184
      Width = 100
      Height = 30
      Hint = 'Gravar|Grava no registro'
      Caption = '&Gravar'
      DoubleBuffered = True
      Enabled = False
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
      TabOrder = 4
      AFecharAposOperacao = False
    end
    object BotaoCancelar1: TBotaoCancelar
      Left = 8
      Top = 213
      Width = 100
      Height = 30
      Hint = 'Cancelar|Cancela opera'#231#227'o atual'
      Caption = '&Cancelar'
      DoubleBuffered = True
      Enabled = False
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
      TabOrder = 5
      AFecharAposOperacao = False
    end
    object BFechar: TBitBtn
      Left = 8
      Top = 336
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
      TabOrder = 6
      OnClick = BFecharClick
    end
  end
  object PrincipioAtivo: TRBSQL
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    AfterInsert = PrincipioAtivoAfterInsert
    AfterEdit = PrincipioAtivoAfterEdit
    BeforePost = PrincipioAtivoBeforePost
    AfterPost = PrincipioAtivoAfterPost
    ABarraMove = MoveBasico1
    AFecharFormulario = BFechar
    AGravar = BotaoGravar1
    ACancelar = BotaoCancelar1
    AAlterar = BotaoAlterar1
    AExcluir = BotaoExcluir1
    ACadastrar = BotaoCadastrar1
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'Select * from PRINCIPIOATIVO'
      ' order by INDCONTROLADO Asc')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select * from PRINCIPIOATIVO'
      ' order by INDCONTROLADO Asc')
    ALocalizaEdit = Consulta
    ALabelConsulta = Label3
    AGrade = Grade
    Left = 16
    object PrincipioAtivoDATULTIMAALTERACAO: TSQLTimeStampField
      FieldName = 'DATULTIMAALTERACAO'
    end
    object PrincipioAtivoCODPRINCIPIO: TFMTBCDField
      FieldName = 'CODPRINCIPIO'
      Required = True
      Precision = 10
      Size = 0
    end
    object PrincipioAtivoNOMPRINCIPIO: TWideStringField
      FieldName = 'NOMPRINCIPIO'
      Size = 50
    end
    object PrincipioAtivoINDCONTROLADO: TWideStringField
      FieldName = 'INDCONTROLADO'
      FixedChar = True
      Size = 1
    end
  end
  object DataPrincipioAtivo: TDataSource
    DataSet = PrincipioAtivo
    Left = 48
  end
end
