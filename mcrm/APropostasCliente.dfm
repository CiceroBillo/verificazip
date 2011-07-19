object FPropostasCliente: TFPropostasCliente
  Left = 8
  Top = 76
  Caption = 'Propostas'
  ClientHeight = 417
  ClientWidth = 820
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
    Width = 820
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Propostas'
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
    Width = 820
    Height = 54
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
    object Label4: TLabel
      Left = 231
      Top = 6
      Width = 25
      Height = 16
      Alignment = taRightJustify
      Caption = 'at'#233' :'
    end
    object Label11: TLabel
      Left = 483
      Top = 6
      Width = 66
      Height = 16
      Alignment = taRightJustify
      Caption = 'Vendedor :'
    end
    object SpeedButton4: TSpeedButton
      Left = 624
      Top = 2
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
      Left = 656
      Top = 6
      Width = 57
      Height = 16
      Caption = '                   '
    end
    object Label2: TLabel
      Left = 497
      Top = 32
      Width = 52
      Height = 16
      Alignment = taRightJustify
      Caption = 'Est'#225'gio :'
    end
    object SpeedButton1: TSpeedButton
      Left = 624
      Top = 28
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
      Left = 654
      Top = 32
      Width = 27
      Height = 16
      Caption = '         '
    end
    object Label7: TLabel
      Left = 63
      Top = 31
      Width = 61
      Height = 16
      Alignment = taRightJustify
      Caption = 'Proposta :'
    end
    object Label8: TLabel
      Left = 511
      Top = 58
      Width = 38
      Height = 16
      Alignment = taRightJustify
      Caption = 'Setor :'
    end
    object SpeedButton3: TSpeedButton
      Left = 624
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
    object Label9: TLabel
      Left = 654
      Top = 58
      Width = 27
      Height = 16
      Caption = '         '
    end
    object Label35: TLabel
      Left = 10
      Top = 58
      Width = 111
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cliente / Prospect :'
    end
    object SpeedButton11: TSpeedButton
      Left = 200
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
    object Label34: TLabel
      Left = 234
      Top = 58
      Width = 239
      Height = 16
      AutoSize = False
      Caption = '             '
      Transparent = True
    end
    object Label5: TLabel
      Left = 515
      Top = 84
      Width = 34
      Height = 16
      Alignment = taRightJustify
      Caption = 'Filial :'
    end
    object SpeedButton2: TSpeedButton
      Left = 624
      Top = 80
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
    object Label6: TLabel
      Left = 657
      Top = 83
      Width = 27
      Height = 16
      Caption = '         '
    end
    object Label10: TLabel
      Left = 426
      Top = 108
      Width = 123
      Height = 16
      Alignment = taRightJustify
      Caption = 'Or'#231'amento Compra :'
    end
    object Label3: TLabel
      Left = 71
      Top = 84
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cidade :'
    end
    object SpeedButton5: TSpeedButton
      Left = 402
      Top = 79
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
    object Label12: TLabel
      Left = 97
      Top = 110
      Width = 24
      Height = 16
      Alignment = taRightJustify
      Caption = 'UF :'
    end
    object SpeedButton6: TSpeedButton
      Left = 200
      Top = 106
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
    object Label13: TLabel
      Left = 233
      Top = 110
      Width = 239
      Height = 16
      AutoSize = False
      Caption = '             '
      Transparent = True
    end
    object Label14: TLabel
      Left = 2
      Top = 136
      Width = 119
      Height = 16
      Alignment = taRightJustify
      Caption = 'Classifica'#231#227'o Prod :'
    end
    object SpeedButton15: TSpeedButton
      Left = 200
      Top = 132
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
      OnClick = SpeedButton15Click
    end
    object LNomClassificacao: TLabel
      Left = 229
      Top = 136
      Width = 168
      Height = 16
      Caption = '                                                        '
    end
    object EDatInicio: TCalendario
      Left = 127
      Top = 2
      Width = 100
      Height = 24
      Date = 36229.687051736100000000
      Time = 36229.687051736100000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnCloseUp = EDatInicioExit
      OnExit = EDatInicioExit
      ACorFoco = FPrincipal.CorFoco
    end
    object EDatFim: TCalendario
      Left = 260
      Top = 2
      Width = 97
      Height = 24
      Date = 36229.687155324100000000
      Time = 36229.687155324100000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnCloseUp = EDatInicioExit
      OnExit = EDatInicioExit
      ACorFoco = FPrincipal.CorFoco
    end
    object EVendedor: TEditLocaliza
      Left = 552
      Top = 2
      Width = 69
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
      ATexto = LNomVendedor
      ABotao = SpeedButton4
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'Select * from CadVendedores'
        'Where I_Cod_Ven = @')
      ASelectLocaliza.Strings = (
        'Select * from CadVendedores'
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
      OnFimConsulta = EDatInicioExit
    end
    object EEstagio: TEditLocaliza
      Left = 552
      Top = 28
      Width = 69
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label1
      ABotao = SpeedButton1
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'WHERE CODEST = @'
        'and TIPEST = '#39'C'#39)
      ASelectLocaliza.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where NOMEST Like '#39'@%'#39
        'and TIPEST = '#39'C'#39)
      APermitirVazio = True
      AInfo.CampoCodigo = 'CODEST'
      AInfo.CampoNome = 'NOMEST'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Est'#225'gio   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EDatInicioExit
    end
    object EProposta: Tnumerico
      Left = 127
      Top = 28
      Width = 100
      Height = 24
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
      ANaoUsarCorNegativo = False
      Color = clInfoBk
      ADecimal = 0
      AMascara = ' ,0;- ,0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnExit = EDatInicioExit
      OnKeyDown = EPropostaKeyDown
    end
    object ESetor: TEditLocaliza
      Left = 552
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
      TabOrder = 8
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label9
      ABotao = SpeedButton3
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'SELECT * FROM SETOR'
        'WHERE CODSETOR = @')
      ASelectLocaliza.Strings = (
        'SELECT * FROM SETOR'
        'WHERE NOMSETOR LIKE '#39'@%'#39
        'ORDER BY NOMSETOR')
      APermitirVazio = True
      AInfo.CampoCodigo = 'CODSETOR'
      AInfo.CampoNome = 'NOMSETOR'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '  Localiza Setor  '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EDatInicioExit
    end
    object ECliente: TEditLocaliza
      Left = 127
      Top = 54
      Width = 72
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnExit = EDatInicioExit
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label34
      ABotao = SpeedButton11
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = ConsultaPadrao1
      ASelectValida.Strings = (
        'Select * from cadclientes'
        'where I_Cod_Cli = @'
        'and (C_IND_CLI = '#39'S'#39
        'or C_IND_PRC = '#39'S'#39')')
      ASelectLocaliza.Strings = (
        'Select * from cadclientes'
        'where c_nom_cli like '#39'@%'#39' '
        'and (C_IND_CLI = '#39'S'#39
        'or C_IND_PRC = '#39'S'#39')')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_Cod_Cli'
      AInfo.CampoNome = 'C_Nom_Cli'
      AInfo.CampoMostra3 = 'C_CID_CLI'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Nome3 = 'Cidade'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 20
      AInfo.TituloForm = '  Localiza Cliente  '
      AInfo.Cadastrar = True
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EDatInicioExit
    end
    object EFilial: TEditLocaliza
      Left = 552
      Top = 80
      Width = 69
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label6
      ABotao = SpeedButton2
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ASelectValida.Strings = (
        'Select * from CADFILIAIS'
        'Where I_EMP_FIL = @')
      ASelectLocaliza.Strings = (
        'Select * from CADFILIAIS'
        'Where C_NOM_FIL LIKE '#39'@%'#39
        'order by C_NOM_FIL')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_EMP_FIL'
      AInfo.CampoNome = 'C_NOM_FIL'
      AInfo.CampoMostra3 = 'C_NOM_FAN'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Nome3 = 'Nome Fantasia'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 20
      AInfo.TituloForm = '   Localiza Filial   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EDatInicioExit
    end
    object EOrcamentoCompra: Tnumerico
      Left = 555
      Top = 106
      Width = 97
      Height = 24
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
      ANaoUsarCorNegativo = False
      Color = clInfoBk
      AMascara = ' ,0;- ,0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnExit = EDatInicioExit
    end
    object BFiltros: TBitBtn
      Left = 230
      Top = 28
      Width = 24
      Height = 24
      Caption = '>>'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 11
      OnClick = BFiltrosClick
    end
    object CPeriodo: TCheckBox
      Left = 32
      Top = 6
      Width = 94
      Height = 17
      Caption = 'Per'#237'odo de :'
      Checked = True
      State = cbChecked
      TabOrder = 12
      OnClick = EDatInicioExit
    end
    object ECidade: TRBEditLocaliza
      Left = 127
      Top = 80
      Width = 275
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnKeyDown = EPropostaKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ABotao = SpeedButton5
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ASelectValida.Strings = (
        'Select DES_CIDADE, COD_ESTADO'
        ' from CAD_CIDADES'
        ' Where DES_CIDADE = '#39'@'#39)
      ASelectLocaliza.Strings = (
        'Select DES_CIDADE, COD_ESTADO'
        ' from CAD_CIDADES')
      APermitirVazio = True
      AColunas = <
        item
          ATituloColuna = 'Cidade'
          ATamanhoColuna = 40
          ACampoFiltro = True
          ANomeCampo = 'DES_CIDADE'
          AMostrarNaGrade = True
          AOrdemInicial = False
        end
        item
          ATituloColuna = 'ESTADO'
          ATamanhoColuna = 5
          ACampoFiltro = True
          ANomeCampo = 'COD_ESTADO'
          AMostrarNaGrade = True
          AOrdemInicial = True
        end>
      ALocalizaPadrao = lpPersonalizado
      ATituloFormulario = '   Localiza Cidade'
      OnFimConsulta = EDatInicioExit
    end
    object EUF: TRBEditLocaliza
      Left = 127
      Top = 106
      Width = 72
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnKeyDown = EPropostaKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label13
      ABotao = SpeedButton6
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ASelectValida.Strings = (
        'Select COD_ESTADO, DES_ESTADO'
        ' from CAD_ESTADOS'
        ' Where COD_ESTADO = '#39'@'#39)
      ASelectLocaliza.Strings = (
        'Select COD_ESTADO, DES_ESTADO'
        ' from CAD_ESTADOS')
      APermitirVazio = True
      AColunas = <
        item
          ATituloColuna = 'C'#243'digo'
          ATamanhoColuna = 8
          ACampoFiltro = False
          ANomeCampo = 'COD_ESTADO'
          AMostrarNaGrade = True
          AOrdemInicial = False
        end
        item
          ATituloColuna = 'Descri'#231#227'o'
          ATamanhoColuna = 40
          ACampoFiltro = True
          ANomeCampo = 'DES_ESTADO'
          AMostrarNaGrade = True
          AOrdemInicial = True
        end>
      ALocalizaPadrao = lpPersonalizado
      ATituloFormulario = '   Localiza Estado'
      OnFimConsulta = EDatInicioExit
    end
    object ECodClassifcacao: TEditColor
      Left = 127
      Top = 132
      Width = 72
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnExit = ECodClassifcacaoExit
      OnKeyDown = ECodClassifcacaoKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
    end
  end
  object GPropostas: TGridIndice
    Left = 0
    Top = 95
    Width = 820
    Height = 281
    Align = alClient
    Color = clInfoBk
    DataSource = DataProposta
    DrawingStyle = gdsClassic
    FixedColor = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    ACorFoco = FPrincipal.CorFoco
    AColunasOrdem = <
      item
        ANomeCampoGrade = 'SEQPROPOSTA'
        ACamposOrdemSQL = 'PRO.SEQPROPOSTA'
        AOrdemInicial = True
      end
      item
        ANomeCampoGrade = 'DATPROPOSTA'
        ACamposOrdemSQL = 'PRO.DATPROPOSTA'
        AOrdemInicial = False
      end
      item
        ANomeCampoGrade = 'DATPREVISAOCOMPRA'
        ACamposOrdemSQL = 'PRO.DATPREVISAOCOMPRA'
        AOrdemInicial = False
      end
      item
        ANomeCampoGrade = 'C_NOM_CLI'
        ACamposOrdemSQL = 'CLI.C_NOM_CLI'
        AOrdemInicial = False
      end
      item
        ANomeCampoGrade = 'NOMSETOR'
        ACamposOrdemSQL = 'STR.NOMSETOR'
        AOrdemInicial = False
      end
      item
        ANomeCampoGrade = 'NOMEST'
        ACamposOrdemSQL = 'EST.NOMEST'
        AOrdemInicial = False
      end
      item
        ANomeCampoGrade = 'C_NOM_PAG'
        ACamposOrdemSQL = 'CON.C_NOM_PAG'
        AOrdemInicial = False
      end
      item
        ANomeCampoGrade = 'C_CID_CLI'
        ACamposOrdemSQL = 'CLI.C_CID_CLI'
        AOrdemInicial = False
      end>
    AindiceInicial = 0
    ALinhaSQLOrderBy = 0
    OnOrdem = GPropostasOrdem
    Columns = <
      item
        Expanded = False
        FieldName = 'CODFILIAL'
        Title.Caption = 'Fl'
        Width = 22
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SEQPROPOSTA'
        Title.Caption = 'Proposta  [>]'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATPROPOSTA'
        Title.Alignment = taCenter
        Title.Caption = 'Data  [+]'
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATPREVISAOCOMPRA'
        Title.Caption = 'Prev Compra  [+]'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C_NOM_CLI'
        Title.Caption = 'Cliente  [+]'
        Width = 288
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALTOTAL'
        Title.Caption = 'Valor Total'
        Width = 104
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMSETOR'
        Title.Caption = 'Setor  [+]'
        Width = 152
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEST'
        Title.Caption = 'Est'#225'gio  [+]'
        Width = 237
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C_NOM_PAG'
        Title.Caption = 'Condi'#231#227'o de Pagamento  [+]'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INDCOMPROU'
        Title.Caption = 'Comprou'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INDCOMPROUCONCORRENTE'
        Title.Caption = 'Comp. Concorr.'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C_CID_CLI'
        Title.Caption = 'Cidade  [+]'
        Width = 207
        Visible = True
      end>
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 376
    Width = 820
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
    TabOrder = 3
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object BCadastrar: TBitBtn
      Left = 8
      Top = 5
      Width = 100
      Height = 30
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
      OnClick = BCadastrarClick
    end
    object BAlterar: TBitBtn
      Left = 106
      Top = 5
      Width = 100
      Height = 30
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
      OnClick = BAlterarClick
    end
    object BConsultar: TBitBtn
      Left = 204
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Consultar'
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
      OnClick = BConsultarClick
    end
    object BImprimir: TBitBtn
      Left = 400
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Imprimir'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = BImprimirClick
    end
    object BEmail: TBitBtn
      Left = 572
      Top = 5
      Width = 100
      Height = 30
      Caption = 'E-mail'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0000377777777777777707FFFFFFFFFFFF70773FF33333333F770F77FFFFFFFF
        77F07F773FFFFFFF77F70FFF7700000000007F337777777777770FFFFF0FFFFF
        FFF07F333F7F3FFFF3370FFF700F0000FFF07F3F777F777733370F707F0FFFFF
        FFF07F77337F3FFFFFF7007EEE0F000000F077FFFF7F777777370777770FFFFF
        FFF07777777F3FFFFFF7307EEE0F000000F03773FF7F7777773733707F0FFFFF
        FFF03337737F3FFF33373333700F000FFFF03333377F77733FF73333330FFFFF
        00003333337F3FF377773333330F00FF0F033333337F77337F733333330FFFFF
        00333333337FFFFF773333333300000003333333337777777333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = BEmailClick
    end
    object BFechar: TBitBtn
      Left = 777
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
      TabOrder = 6
      OnClick = BFecharClick
    end
    object BGraficos: TBitBtn
      Left = 671
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
      TabOrder = 5
      OnClick = BGraficosClick
    end
    object BExcluir: TBitBtn
      Left = 302
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Excluir'
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
      TabOrder = 7
      OnClick = BExcluirClick
    end
  end
  object PGraficos: TCorPainelGra
    Left = 318
    Top = 58
    Width = 173
    Height = 312
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = 'Gr'#225'ficos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
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
      Height = 291
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
        Top = 262
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
        Caption = '&Data'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 5
        OnClick = BCondicaoClick
      end
      object BEstado: TBitBtn
        Left = 1
        Top = 175
        Width = 168
        Height = 30
        Caption = 'UF'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 7
        OnClick = BEstadoClick
      end
      object BGraEstagio: TBitBtn
        Left = 1
        Top = 204
        Width = 168
        Height = 30
        Caption = 'Est'#225'gio'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 8
        OnClick = BGraEstagioClick
      end
    end
  end
  object Proposta: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    AfterScroll = PropostaAfterScroll
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'select PRO.CODFILIAL, PRO.SEQPROPOSTA, PRO.DATPROPOSTA, PRO.DATP' +
        'REVISAOCOMPRA, '
      
        'PRO.INDCOMPROU, PRO.INDCOMPROUCONCORRENTE, PRO.VALTOTAL,PRO.CODE' +
        'STAGIO,'
      'CLI.I_COD_CLI, CLI.C_CID_CLI,'
      'CON.C_NOM_PAG,  '
      'CLI.C_NOM_CLI,'
      'EST.NOMEST, EST.INDFIN,'
      'STR.NOMSETOR, STR.DESMODELORELATORIO'
      ''
      
        'from PROPOSTA PRO, CADCONDICOESPAGTO CON, CADCLIENTES CLI, ESTAG' +
        'IOPRODUCAO EST, SETOR STR'
      'Where PRO.CODCONDICAOPAGAMENTO = CON.I_COD_PAG'
      'AND PRO.CODCLIENTE = CLI.I_COD_CLI'
      'AND PRO.CODESTAGIO = EST.CODEST'
      'AND PRO.CODSETOR = STR.CODSETOR')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select PRO.CODFILIAL, PRO.SEQPROPOSTA, PRO.DATPROPOSTA, PRO.DATP' +
        'REVISAOCOMPRA, '
      
        'PRO.INDCOMPROU, PRO.INDCOMPROUCONCORRENTE, PRO.VALTOTAL,PRO.CODE' +
        'STAGIO,'
      'CLI.I_COD_CLI, CLI.C_CID_CLI,'
      'CON.C_NOM_PAG,  '
      'CLI.C_NOM_CLI,'
      'EST.NOMEST, EST.INDFIN,'
      'STR.NOMSETOR, STR.DESMODELORELATORIO'
      ''
      
        'from PROPOSTA PRO, CADCONDICOESPAGTO CON, CADCLIENTES CLI, ESTAG' +
        'IOPRODUCAO EST, SETOR STR'
      'Where PRO.CODCONDICAOPAGAMENTO = CON.I_COD_PAG'
      'AND PRO.CODCLIENTE = CLI.I_COD_CLI'
      'AND PRO.CODESTAGIO = EST.CODEST'
      'AND PRO.CODSETOR = STR.CODSETOR')
    Left = 8
    object PropostaCODFILIAL: TFMTBCDField
      FieldName = 'CODFILIAL'
      Origin = 'BASEDADOS.PROPOSTA.CODFILIAL'
    end
    object PropostaSEQPROPOSTA: TFMTBCDField
      FieldName = 'SEQPROPOSTA'
      Origin = 'BASEDADOS.PROPOSTA.SEQPROPOSTA'
    end
    object PropostaDATPROPOSTA: TSQLTimeStampField
      FieldName = 'DATPROPOSTA'
      Origin = 'BASEDADOS.PROPOSTA.DATPROPOSTA'
    end
    object PropostaDATPREVISAOCOMPRA: TSQLTimeStampField
      FieldName = 'DATPREVISAOCOMPRA'
      Origin = 'BASEDADOS.PROPOSTA.DATPREVISAOCOMPRA'
    end
    object PropostaINDCOMPROU: TWideStringField
      FieldName = 'INDCOMPROU'
      Origin = 'BASEDADOS.PROPOSTA.INDCOMPROU'
      Size = 1
    end
    object PropostaINDCOMPROUCONCORRENTE: TWideStringField
      FieldName = 'INDCOMPROUCONCORRENTE'
      Origin = 'BASEDADOS.PROPOSTA.INDCOMPROUCONCORRENTE'
      Size = 1
    end
    object PropostaVALTOTAL: TFMTBCDField
      FieldName = 'VALTOTAL'
      Origin = 'BASEDADOS.PROPOSTA.VALTOTAL'
      currency = True
    end
    object PropostaI_COD_CLI: TFMTBCDField
      FieldName = 'I_COD_CLI'
      Origin = 'BASEDADOS.CADCLIENTES.I_COD_CLI'
    end
    object PropostaC_NOM_PAG: TWideStringField
      FieldName = 'C_NOM_PAG'
      Origin = 'BASEDADOS.CADCONDICOESPAGTO.C_NOM_PAG'
      Size = 50
    end
    object PropostaC_NOM_CLI: TWideStringField
      FieldName = 'C_NOM_CLI'
      Origin = 'BASEDADOS.CADCLIENTES.C_NOM_CLI'
      Size = 50
    end
    object PropostaNOMEST: TWideStringField
      FieldName = 'NOMEST'
      Origin = 'BASEDADOS.ESTAGIOPRODUCAO.NOMEST'
      Size = 50
    end
    object PropostaNOMSETOR: TWideStringField
      FieldName = 'NOMSETOR'
      Origin = 'BASEDADOS.SETOR.NOMSETOR'
      Size = 50
    end
    object PropostaDESMODELORELATORIO: TWideStringField
      FieldName = 'DESMODELORELATORIO'
      Size = 50
    end
    object PropostaCODESTAGIO: TFMTBCDField
      FieldName = 'CODESTAGIO'
      Precision = 10
      Size = 0
    end
    object PropostaINDFIN: TWideStringField
      FieldName = 'INDFIN'
      FixedChar = True
      Size = 1
    end
    object PropostaC_CID_CLI: TWideStringField
      FieldName = 'C_CID_CLI'
      Size = 40
    end
  end
  object DataProposta: TDataSource
    DataSet = Proposta
    Left = 40
  end
  object GraficosTrio: TGraficosTrio
    ADataBase = FPrincipal.BaseDados
    AConfiguracoes = FPrincipal.CorPainelGra
    Left = 96
    Top = 1
  end
  object ConsultaPadrao1: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 152
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 272
    Top = 8
    object TelemarketingReceptivo1: TMenuItem
      Caption = 'Telemarketing Receptivo'
      OnClick = TelemarketingReceptivo1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MAlterarEstagio: TMenuItem
      Caption = 'Alterar Est'#225'gio'
      OnClick = MAlterarEstagioClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Duplicar1: TMenuItem
      Caption = 'Duplicar'
      OnClick = Duplicar1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MGerarCotao: TMenuItem
      Caption = 'Gerar Cota'#231#227'o'
      OnClick = MGerarCotaoClick
    end
    object ConsultaCotaes1: TMenuItem
      Caption = 'Consulta Cota'#231#245'es'
      OnClick = ConsultaCotaes1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MGerarFichaImplantao: TMenuItem
      Caption = 'Gerar Ficha Implanta'#231#227'o'
      OnClick = MGerarFichaImplantaoClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object GerarPedidoCompra1: TMenuItem
      Caption = 'Gera Solicita'#231#227'o Compras'
      OnClick = GerarPedidoCompra1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ConsultaPedidoCompras1: TMenuItem
      Caption = 'Consulta Solicita'#231#227'o Compras'
      OnClick = ConsultaPedidoCompras1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object ConsultaChamados1: TMenuItem
      Caption = 'Consulta Chamados'
      OnClick = ConsultaChamados1Click
    end
  end
  object Aux: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    Left = 384
    Top = 8
  end
end
