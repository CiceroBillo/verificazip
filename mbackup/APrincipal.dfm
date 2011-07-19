object FPrincipal: TFPrincipal
  Left = 187
  Top = 104
  Width = 696
  Height = 480
  Caption = 'Backup - SisCorp - 1.00 v'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 688
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Backup   '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = CorPainelGra1
  end
  object PanelColor1: TPanelColor
    Left = 0
    Top = 41
    Width = 688
    Height = 364
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
    ACorForm = CorForm1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 50
      Height = 16
      Caption = 'Origem :'
    end
    object Label2: TLabel
      Left = 312
      Top = 16
      Width = 52
      Height = 16
      Caption = 'Destino :'
    end
    object Posicao: TGauge
      Left = 192
      Top = 48
      Width = 241
      Height = 233
      BorderStyle = bsNone
      Kind = gkPie
      MaxValue = 102
      Progress = 0
    end
    object LNomTabela: TLabel
      Left = 208
      Top = 304
      Width = 91
      Height = 20
      Caption = '                  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EOrigem: TComboBoxColor
      Left = 63
      Top = 12
      Width = 219
      Height = 24
      Style = csDropDownList
      Color = clInfoBk
      ItemHeight = 16
      Sorted = True
      TabOrder = 0
      OnClick = EOrigemClick
      ACampoObrigatorio = False
      ACorFoco = CorFoco1
    end
    object EDestino: TComboBoxColor
      Left = 370
      Top = 12
      Width = 219
      Height = 24
      Style = csDropDownList
      Color = clInfoBk
      ItemHeight = 16
      Sorted = True
      TabOrder = 1
      OnClick = EDestinoClick
      ACampoObrigatorio = False
      ACorFoco = CorFoco1
    end
    object PTabela: TProgressBar
      Left = 64
      Top = 56
      Width = 25
      Height = 273
      Min = 0
      Max = 100
      Orientation = pbVertical
      Smooth = True
      TabOrder = 2
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 344
      Width = 686
      Height = 19
      Panels = <
        item
          Width = 400
        end>
      SimplePanel = False
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 405
    Width = 688
    Height = 41
    Align = alBottom
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 2
    AUsarCorForm = False
    ACorForm = CorForm1
    object BExecutar: TBitBtn
      Left = 24
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Executar'
      TabOrder = 0
      OnClick = BExecutarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
        000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
        99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
        0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
        FFFF3FFFFF7F337F333300000307B70FFFFF77777F73FF733F330EEE033000FF
        0FFF7F337FF777337FF30EEE00033FF000FF7F33777F333777FF0EEE0E033300
        000F7FFF7F7FFF77777F00000E00000000007777737773777777330EEE0E0330
        00FF337FFF7F7F3777F33300000E033000FF337777737F3777F333330EEE0330
        00FF33337FFF7FF77733333300000000033F3333777777777333}
      NumGlyphs = 2
    end
    object BFechar: TBitBtn
      Left = 584
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Fechar'
      TabOrder = 1
      OnClick = BFecharClick
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
    end
  end
  object CorPainelGra1: TCorPainelGra
    Left = 16
    Top = 8
    Width = 29
    Height = 29
    Alignment = taLeftJustify
    Caption = 'A'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    AEfeitosDeFundos = bdEsquerda
    AColorSombra = clBlack
    AColorInicio = 4227072
    AEfeitosTexto = teContorno
  end
  object CorFoco1: TCorFoco
    ACorFundoFoco = clWhite
    ACorObrigatorio = clWhite
    ACorFonteFoco = clBlack
    AFonteComponentes.Charset = DEFAULT_CHARSET
    AFonteComponentes.Color = clWindowText
    AFonteComponentes.Height = -13
    AFonteComponentes.Name = 'MS Sans Serif'
    AFonteComponentes.Style = []
    AFundoComponentes = clInfoBk
    AFonteTituloGrid.Charset = DEFAULT_CHARSET
    AFonteTituloGrid.Color = clWindowText
    AFonteTituloGrid.Height = -13
    AFonteTituloGrid.Name = 'MS Sans Serif'
    AFonteTituloGrid.Style = []
    ACorTituloGrid = clSilver
    AcorNegativo = clBlack
    ACodigoUsuario = 0
    AGravarConsultaSQl = False
    APermitePercentualConsulta = False
    Left = 272
    Top = 8
  end
  object CorForm1: TCorForm
    ACorFormulario = clSilver
    ACorPainel = clSilver
    AFonteForm.Charset = DEFAULT_CHARSET
    AFonteForm.Color = clWindowText
    AFonteForm.Height = -13
    AFonteForm.Name = 'MS Sans Serif'
    AFonteForm.Style = []
    Left = 336
    Top = 8
  end
  object BaseOrigem: TDatabase
    DatabaseName = 'BaseOrigem'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 80
  end
  object BaseDestino: TDatabase
    DatabaseName = 'BaseDados'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 168
  end
  object PopupMenu1: TPopupMenu
    Left = 392
    Top = 8
    object Restaurar1: TMenuItem
      Caption = 'Restaurar'
      OnClick = Restaurar1Click
    end
  end
  object BaseDados: TDatabase
    DatabaseName = 'BaseOrigem'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 112
  end
end
