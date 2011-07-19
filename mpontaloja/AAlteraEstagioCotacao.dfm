object FAlteraEstagioCotacao: TFAlteraEstagioCotacao
  Left = 200
  Top = 108
  Caption = 'Altera Est'#225'gio Cota'#231#227'o'
  ClientHeight = 267
  ClientWidth = 536
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
    Width = 536
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '  Altera Est'#225'gio   '
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
    Width = 536
    Height = 185
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
    object SpeedButton1: TSpeedButton
      Left = 195
      Top = 8
      Width = 25
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
    object SpeedButton2: TSpeedButton
      Left = 194
      Top = 96
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
    object Label1: TLabel
      Left = 40
      Top = 12
      Width = 53
      Height = 16
      Alignment = taRightJustify
      Caption = 'Usu'#225'rio :'
    end
    object Label2: TLabel
      Left = 36
      Top = 44
      Width = 57
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cota'#231#227'o :'
    end
    object Label3: TLabel
      Left = 41
      Top = 100
      Width = 52
      Height = 16
      Alignment = taRightJustify
      Caption = 'Est'#225'gio :'
    end
    object Label4: TLabel
      Left = 225
      Top = 12
      Width = 48
      Height = 16
      Caption = '                '
    end
    object BCotacao: TSpeedButton
      Left = 195
      Top = 40
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
      Left = 225
      Top = 44
      Width = 48
      Height = 16
      Caption = '                '
    end
    object Label6: TLabel
      Left = 225
      Top = 100
      Width = 48
      Height = 16
      Caption = '                '
    end
    object Label7: TLabel
      Left = 8
      Top = 72
      Width = 85
      Height = 16
      Alignment = taRightJustify
      Caption = 'Est'#225'gio Atual :'
    end
    object SpeedButton4: TSpeedButton
      Left = 194
      Top = 67
      Width = 26
      Height = 25
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
    object Label8: TLabel
      Left = 225
      Top = 75
      Width = 48
      Height = 16
      Caption = '                '
      Enabled = False
    end
    object Label9: TLabel
      Left = 47
      Top = 142
      Width = 46
      Height = 16
      Alignment = taRightJustify
      Caption = 'Motivo :'
    end
    object EUsuario: TEditLocaliza
      Left = 104
      Top = 8
      Width = 89
      Height = 24
      TabStop = False
      Color = 11661566
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnChange = EUsuarioChange
      ACampoObrigatorio = True
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label4
      ABotao = SpeedButton1
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'Select * from CADUSUARIOS'
        'Where I_COD_USU = @')
      ASelectLocaliza.Strings = (
        'Select * from CADUSUARIOS'
        'WHERE C_NOM_USU like '#39'@%'#39)
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_COD_USU'
      AInfo.CampoNome = 'C_NOM_USU'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Usu'#225'rio   '
      ADarFocoDepoisdoLocaliza = True
    end
    object ECodEstagio: TEditLocaliza
      Left = 104
      Top = 96
      Width = 89
      Height = 24
      Color = 11661566
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = EUsuarioChange
      ACampoObrigatorio = True
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label6
      ABotao = SpeedButton2
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where CODEST = @')
      ASelectLocaliza.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where NOMEST Like '#39'@%'#39
        'order by CODEST')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'CODEST'
      AInfo.CampoNome = 'NOMEST'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Est'#225'gio   '
      AInfo.Cadastrar = True
      AInfo.RetornoExtra1 = 'INDOBS'
      ADarFocoDepoisdoLocaliza = True
      OnCadastrar = ECodEstagioCadastrar
      OnRetorno = ECodEstagioRetorno
    end
    object ECotacao: TEditLocaliza
      Left = 104
      Top = 40
      Width = 89
      Height = 24
      Color = 11661566
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = EUsuarioChange
      ACampoObrigatorio = True
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label5
      ABotao = BCotacao
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectLocaliza.Strings = (
        'Select CLI.C_NOM_CLI, COT.I_LAN_ORC '
        'from CADCLIENTES CLI, CADORCAMENTOS COT'
        'Where CLI.I_COD_CLI = COT.I_COD_CLI'
        'and CLI.C_NOM_CLI LIKE '#39'@%'#39)
      APermitirVazio = True
      AInfo.CampoCodigo = 'I_LAN_ORC'
      AInfo.CampoNome = 'C_NOM_CLI'
      AInfo.Nome1 = 'Cota'#231#227'o'
      AInfo.Nome2 = 'Cliente'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '  Localiza Cota'#231#227'o   '
      AInfo.RetornoExtra1 = 'I_COD_EST'
      ADarFocoDepoisdoLocaliza = True
      OnSelect = ECotacaoSelect
      OnRetorno = ECotacaoRetorno
    end
    object EEstagioAtual: TEditLocaliza
      Left = 104
      Top = 68
      Width = 89
      Height = 24
      Color = clInfoBk
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = EUsuarioChange
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label8
      ABotao = SpeedButton4
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where CODEST = @')
      ASelectLocaliza.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where NOMEST Like '#39'@%'#39
        'order by CODEST')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'CODEST'
      AInfo.CampoNome = 'NOMEST'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Est'#225'gio   '
      AInfo.Cadastrar = True
      ADarFocoDepoisdoLocaliza = True
      OnCadastrar = ECodEstagioCadastrar
    end
    object EMotivo: TMemoColor
      Left = 104
      Top = 124
      Width = 425
      Height = 56
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 226
    Width = 536
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
      Left = 179
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Gravar'
      Default = True
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
      Left = 278
      Top = 5
      Width = 100
      Height = 30
      Cancel = True
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
  end
  object ConsultaPadrao1: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 208
  end
  object ValidaGravacao1: TValidaGravacao
    AComponente = PanelColor1
    ABotaoGravar = BGravar
    Left = 264
  end
end
