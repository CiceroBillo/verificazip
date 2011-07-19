object FCelulaTrabalho: TFCelulaTrabalho
  Left = 148
  Top = 108
  Caption = 'C'#233'lula Trabalho'
  ClientHeight = 412
  ClientWidth = 559
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
    Width = 559
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   C'#233'lula Trabalho   '
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
    Width = 449
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
      Left = 28
      Top = 7
      Width = 50
      Height = 16
      Caption = 'C'#243'digo :'
    end
    object Label2: TLabel
      Left = 35
      Top = 36
      Width = 43
      Height = 16
      Caption = 'Nome :'
    end
    object Bevel1: TBevel
      Left = 1
      Top = 95
      Width = 600
      Height = 10
      Shape = bsTopLine
    end
    object Label4: TLabel
      Left = 2
      Top = 98
      Width = 128
      Height = 16
      Caption = 'C'#243'digo para consulta'
    end
    object ECodigo: TDBKeyViolation
      Left = 83
      Top = 3
      Width = 65
      Height = 24
      Color = 11661566
      DataField = 'CODCELULA'
      DataSource = DataCelulaTrabalho
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
      ADataBase = FPrincipal.BaseDados
      ATabela = 'CELULATRABALHO'
    end
    object DBEditColor1: TDBEditColor
      Left = 83
      Top = 32
      Width = 358
      Height = 24
      Color = clInfoBk
      DataField = 'NOMCELULA'
      DataSource = DataCelulaTrabalho
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
    end
    object EConsulta: TLocalizaEdit
      Left = 3
      Top = 115
      Width = 438
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATabela = CelulaTrabalho
      ASelect.Strings = (
        'Select * from CELULATRABALHO'
        'Where NOMCELULA LIKE '#39'@%'#39)
      AOrdem = 'order by CODCELULA'
    end
    object GridIndice1: TGridIndice
      Left = 4
      Top = 144
      Width = 437
      Height = 217
      Color = clInfoBk
      DataSource = DataCelulaTrabalho
      FixedColor = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 3
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
        '3')
      AListaCAmpos.Strings = (
        'CODCELULA'
        'NOMCELULA'
        'INDATIVA'
        'INDTROCASERVICOFACIL')
      AindiceInicial = 0
      ALinhaSQLOrderBy = 1
      Columns = <
        item
          Expanded = False
          FieldName = 'CODCELULA'
          Title.Caption = 'C'#243'digo  [>]'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCELULA'
          Title.Caption = 'Nome  [+]'
          Width = 266
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INDATIVA'
          Title.Caption = 'Ativo  [+]'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INDTROCASERVICOFACIL'
          Title.Caption = 'TS  [+]'
          Width = 44
          Visible = True
        end>
    end
    object CAtiva: TDBCheckBox
      Left = 83
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Ativa'
      DataField = 'INDATIVA'
      DataSource = DataCelulaTrabalho
      TabOrder = 4
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBCheckBox1: TDBCheckBox
      Left = 179
      Top = 64
      Width = 262
      Height = 17
      Caption = 'Possui facilidade em trocar de servi'#231'o'
      DataField = 'INDTROCASERVICOFACIL'
      DataSource = DataCelulaTrabalho
      TabOrder = 5
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  object PanelColor2: TPanelColor
    Left = 449
    Top = 41
    Width = 110
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
      AFoco = ECodigo
    end
    object BotaoAlterar1: TBotaoAlterar
      Left = 5
      Top = 34
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
      AFoco = DBEditColor1
    end
    object BotaoExcluir1: TBotaoExcluir
      Left = 5
      Top = 63
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
      TabOrder = 2
      ATextoExcluir = CelulaTrabalhoNOMCELULA
    end
    object BotaoGravar1: TBotaoGravar
      Left = 5
      Top = 243
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
      TabOrder = 3
      AFecharAposOperacao = False
    end
    object BotaoCancelar1: TBotaoCancelar
      Left = 5
      Top = 272
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
      TabOrder = 4
      AFecharAposOperacao = False
    end
    object BFechar: TBitBtn
      Left = 5
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
      TabOrder = 5
      OnClick = BFecharClick
    end
    object BEstagios: TBitBtn
      Left = 5
      Top = 105
      Width = 100
      Height = 30
      Caption = '&Est'#225'gios'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 6
      OnClick = BEstagiosClick
    end
    object BHorarios: TBitBtn
      Left = 5
      Top = 134
      Width = 100
      Height = 30
      Caption = 'Hor'#225'rios'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 7
      OnClick = BHorariosClick
    end
    object BCalendario: TBitBtn
      Left = 5
      Top = 163
      Width = 100
      Height = 30
      Caption = 'Calend'#225'rio'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 8
      OnClick = BCalendarioClick
    end
    object BExcecoes: TBitBtn
      Left = 5
      Top = 192
      Width = 100
      Height = 30
      Caption = 'Exce'#231#245'es'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 9
    end
  end
  object CelulaTrabalho: TRBSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    AfterInsert = CelulaTrabalhoAfterInsert
    AfterEdit = CelulaTrabalhoAfterEdit
    BeforePost = CelulaTrabalhoBeforePost
    AfterPost = CelulaTrabalhoAfterPost
    AFecharFormulario = BFechar
    AGravar = BotaoGravar1
    ACancelar = BotaoCancelar1
    AAlterar = BotaoAlterar1
    AExcluir = BotaoExcluir1
    ACadastrar = BotaoCadastrar1
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select * from CELULATRABALHO')
    ALocalizaEdit = EConsulta
    ALabelConsulta = Label4
    AGrade = GridIndice1
    Left = 16
    Top = 8
    object CelulaTrabalhoCODCELULA: TFMTBCDField
      FieldName = 'CODCELULA'
      Origin = 'BASEDADOS.CELULATRABALHO.CODCELULA'
    end
    object CelulaTrabalhoNOMCELULA: TWideStringField
      FieldName = 'NOMCELULA'
      Origin = 'BASEDADOS.CELULATRABALHO.NOMCELULA'
      Size = 50
    end
    object CelulaTrabalhoINDATIVA: TWideStringField
      FieldName = 'INDATIVA'
      Origin = 'BASEDADOS.CELULATRABALHO.INDATIVA'
      Size = 1
    end
    object CelulaTrabalhoINDTROCASERVICOFACIL: TWideStringField
      FieldName = 'INDTROCASERVICOFACIL'
      Origin = 'BASEDADOS.CELULATRABALHO.INDTROCASERVICOFACIL'
      Size = 1
    end
  end
  object DataCelulaTrabalho: TDataSource
    AutoEdit = False
    DataSet = CelulaTrabalho
    Left = 72
    Top = 9
  end
end
