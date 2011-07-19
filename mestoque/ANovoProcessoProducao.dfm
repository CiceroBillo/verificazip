object FNovoProcessoProducao: TFNovoProcessoProducao
  Left = 200
  Top = 108
  ActiveControl = DBEditColor2
  Caption = 'Processos Produ'#231#227'o'
  ClientHeight = 267
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 628
    Height = 47
    Align = alTop
    Alignment = taLeftJustify
    Caption = '  Processos Produ'#231#227'o  '
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
    Top = 47
    Width = 628
    Height = 179
    Align = alClient
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
    object Label1: TLabel
      Left = 120
      Top = 16
      Width = 50
      Height = 16
      Caption = 'C'#243'digo :'
    end
    object Label2: TLabel
      Left = 102
      Top = 42
      Width = 68
      Height = 16
      Caption = 'Descri'#231#227'o :'
    end
    object Label3: TLabel
      Left = 38
      Top = 94
      Width = 132
      Height = 16
      Caption = 'Qtd. Produ'#231#227'o / Hora :'
    end
    object Label4: TLabel
      Left = 118
      Top = 68
      Width = 52
      Height = 16
      Caption = 'Est'#225'gio :'
    end
    object Label5: TLabel
      Left = 15
      Top = 150
      Width = 155
      Height = 16
      Caption = 'Tempo de Configura'#231#227'o  :'
    end
    object BEstagio: TSpeedButton
      Left = 241
      Top = 63
      Width = 31
      Height = 26
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
    object LEstagio: TLabel
      Left = 277
      Top = 70
      Width = 174
      Height = 16
      Caption = '                                                          '
    end
    object DBEditColor2: TDBEditColor
      Left = 176
      Top = 38
      Width = 417
      Height = 24
      Color = 11661566
      DataField = 'DESPROCESSOPRODUCAO'
      DataSource = DATAPROCESSOPRODUCAO
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = ECodigoChange
      ACampoObrigatorio = True
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AFormatoData = False
      AIgnorarTipoLetra = False
    end
    object EEstagio: TDBEditLocaliza
      Left = 176
      Top = 64
      Width = 65
      Height = 24
      Color = 11661566
      DataField = 'CODESTAGIO'
      DataSource = DATAPROCESSOPRODUCAO
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = ECodigoChange
      ACampoObrigatorio = True
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AFormatoData = False
      AIgnorarTipoLetra = False
      ATexto = LEstagio
      ABotao = BEstagio
      ADataBase = FPrincipal.BaseDados
      ALocaliza = ConsultaPadrao
      ASelectValida.Strings = (
        'SELECT CODEST, NOMEST FROM  ESTAGIOPRODUCAO'
        'WHERE CODEST = @')
      ASelectLocaliza.Strings = (
        'SELECT CODEST, NOMEST FROM  ESTAGIOPRODUCAO'
        'WHERE NOMEST LIKE '#39'@%'#39
        'ORDER BY NOMEST')
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      APermitirVazio = True
      AInfo.CampoCodigo = 'CODEST'
      AInfo.CampoNome = 'NOMEST'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Est'#225'gio'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '  Localiza Est'#225'gios Produ'#231#227'o  '
    end
    object DBEditColor3: TDBEditColor
      Left = 176
      Top = 90
      Width = 90
      Height = 24
      Color = clInfoBk
      DataField = 'QTDPRODUCAOHORA'
      DataSource = DATAPROCESSOPRODUCAO
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = ECodigoChange
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AFormatoData = False
      AIgnorarTipoLetra = False
    end
    object CConfiguracao: TDBCheckBox
      Left = 176
      Top = 120
      Width = 105
      Height = 17
      Caption = '&Configura'#231#227'o'
      DataField = 'INDCONFIGURACAO'
      DataSource = DATAPROCESSOPRODUCAO
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'F'
      OnClick = CConfiguracaoClick
    end
    object ETempoConfiguracao: TMaskEditColor
      Left = 176
      Top = 147
      Width = 90
      Height = 24
      Color = clInfoBk
      EditMask = '!900\:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 5
      Text = '   :  '
      OnChange = ECodigoChange
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
    end
    object ECodigo: TDBKeyViolation
      Left = 176
      Top = 12
      Width = 65
      Height = 24
      Color = 11661566
      DataField = 'CODPROCESSOPRODUCAO'
      DataSource = DATAPROCESSOPRODUCAO
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = ECodigoChange
      ACampoObrigatorio = True
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AFormatoData = False
      AIgnorarTipoLetra = False
      ADataBase = FPrincipal.BaseDados
      ATabela = 'PROCESSOPRODUCAO'
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 226
    Width = 628
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
    object BotaoGravar: TBotaoGravar
      Left = 202
      Top = 5
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
      TabOrder = 0
      OnClick = BotaoGravarClick
      OnDepoisAtividade = BotaoGravarDepoisAtividade
      AFecharAposOperacao = False
    end
    object BotaoCancelar: TBotaoCancelar
      Left = 302
      Top = 5
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
      TabOrder = 1
      OnClick = BotaoCancelarClick
      AFecharAposOperacao = False
    end
  end
  object PROCESSOPRODUCAO: TRBSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    AfterInsert = PROCESSOPRODUCAOAfterInsert
    AfterEdit = PROCESSOPRODUCAOAfterEdit
    BeforePost = PROCESSOPRODUCAOBeforePost
    AfterPost = PROCESSOPRODUCAOAfterPost
    AfterCancel = PROCESSOPRODUCAOAfterCancel
    AfterDelete = PROCESSOPRODUCAOAfterDelete
    AfterScroll = PROCESSOPRODUCAOAfterScroll
    AFecharFormulario = BotaoCancelar
    AGravar = BotaoGravar
    ACancelar = BotaoCancelar
    AAlterar = FProcessosProducao.BotaoAlterar1
    AExcluir = FProcessosProducao.BotaoExcluir1
    AConsultar = FProcessosProducao.BotaoConsultar1
    ACadastrar = FProcessosProducao.BotaoCadastrar1
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'SELECT * FROM PROCESSOPRODUCAO'
      'WHERE CODPROCESSOPRODUCAO = 0')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'SELECT * FROM PROCESSOPRODUCAO'
      'WHERE CODPROCESSOPRODUCAO = 0')
    AGrade = FProcessosProducao.GConsulta
    Left = 416
    Top = 32
    object PROCESSOPRODUCAOCODPROCESSOPRODUCAO: TFMTBCDField
      FieldName = 'CODPROCESSOPRODUCAO'
      Required = True
      Precision = 10
      Size = 0
    end
    object PROCESSOPRODUCAODESPROCESSOPRODUCAO: TWideStringField
      FieldName = 'DESPROCESSOPRODUCAO'
      Size = 80
    end
    object PROCESSOPRODUCAOCODESTAGIO: TFMTBCDField
      FieldName = 'CODESTAGIO'
      Precision = 10
      Size = 0
    end
    object PROCESSOPRODUCAOQTDPRODUCAOHORA: TFMTBCDField
      FieldName = 'QTDPRODUCAOHORA'
      Precision = 11
      Size = 4
    end
    object PROCESSOPRODUCAOINDCONFIGURACAO: TWideStringField
      FieldName = 'INDCONFIGURACAO'
      FixedChar = True
      Size = 1
    end
    object PROCESSOPRODUCAODESTEMPOCONFIGURACAO: TWideStringField
      FieldName = 'DESTEMPOCONFIGURACAO'
      Size = 7
    end
  end
  object DATAPROCESSOPRODUCAO: TDataSource
    DataSet = PROCESSOPRODUCAO
    Left = 544
    Top = 32
  end
  object ConsultaPadrao: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 316
    Top = 32
  end
  object ValidaGravacao: TValidaGravacao
    AComponente = PanelColor1
    ABotaoGravar = BotaoGravar
    Left = 328
    Top = 128
  end
end
