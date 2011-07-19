object FProdutosKit: TFProdutosKit
  Left = 53
  Top = 107
  HelpContext = 1431
  BorderIcons = [biSystemMenu]
  Caption = 'Produtos do Kit'
  ClientHeight = 364
  ClientWidth = 720
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
  object PanelColor1: TPanelColor
    Left = 0
    Top = 0
    Width = 720
    Height = 34
    Align = alTop
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object Label3D1: TLabel3D
      Left = 1
      Top = 1
      Width = 718
      Height = 32
      Align = alClient
      Alignment = taCenter
      Caption = 'Produtos do Kit'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      ACorMove = clBlack
      ExplicitWidth = 165
      ExplicitHeight = 29
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 34
    Width = 720
    Height = 289
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
      Left = 15
      Top = 12
      Width = 20
      Height = 16
      Caption = 'Kit :'
    end
    object SpeedButton1: TSpeedButton
      Left = 131
      Top = 8
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
      Left = 164
      Top = 12
      Width = 57
      Height = 16
      Caption = '              '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 480
      Top = 256
      Width = 151
      Height = 16
      Alignment = taRightJustify
      Caption = 'Quantidade em Estoque :'
    end
    object Label4: TLabel
      Left = 16
      Top = 256
      Width = 75
      Height = 16
      Caption = '                         '
    end
    object Kit: TEditLocaliza
      Left = 40
      Top = 8
      Width = 89
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
      APermitirVazio = True
      AInfo.CampoCodigo = 'C_Cod_Pro'
      AInfo.CampoNome = 'C_Nom_pro'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Kit   '
      AInfo.RetornoExtra1 = 'C_Cod_Pro'
      ADarFocoDepoisdoLocaliza = True
      OnSelect = KitSelect
      OnRetorno = KitRetorno
    end
    object DBGridColor1: TDBGridColor
      Left = 16
      Top = 40
      Width = 697
      Height = 209
      HelpContext = 37
      Color = clInfoBk
      DataSource = DataMovKit
      FixedColor = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      ACorFoco = FPrincipal.CorFoco
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
          Title.Caption = 'C'#243'digo'
          Width = 108
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C_Nom_Pro'
          Title.Caption = 'Nome'
          Width = 256
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QtdKit'
          Title.Caption = 'Qtd Kit'
          Width = 68
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'C_cod_Uni'
          Title.Caption = 'Un'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_qtd_Pro'
          Title.Caption = 'Qtd Estoque'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ValorVenda'
          Title.Caption = 'Valor Venda'
          Width = 111
          Visible = True
        end>
    end
    object QtdKit: Tnumerico
      Left = 640
      Top = 252
      Width = 73
      Height = 24
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
      ANaoUsarCorNegativo = False
      Color = clInfoBk
      AMascara = '0;-0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object PanelColor3: TPanelColor
    Left = 0
    Top = 323
    Width = 720
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
      Left = 496
      Top = 6
      Width = 114
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
      TabOrder = 0
      OnClick = BFecharClick
    end
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 168
  end
  object MovKit: TQuery
    DatabaseName = 'BaseDados'
    SQL.Strings = (
      'Select Pro.c_cod_pro Codigo '
      
        '                  , pro.C_Nom_Pro, pro.C_cod_Uni, mov.N_qtd_Pro,' +
        ' kit.n_qtd_pro QtdKit, '
      
        '                   tab.c_cif_moe + '#39' '#39' + cast(Tab.N_VLR_VEN as c' +
        'har) as ValorVenda '
      '                   from MovKit as kit, CadProdutos as Pro, '
      '                   MovQdadeProduto as mov, MovTabelaPreco Tab '
      '                   Where  Kit.I_pro_kit = 25'
      '                   and kit.i_seq_pro = Pro.i_seq_pro '
      '                   and Mov.I_seq_pro =* pro.I_seq_pro')
    object MovKitCodigo: TStringField
      FieldName = 'Codigo'
    end
    object MovKitC_Nom_Pro: TStringField
      FieldName = 'C_Nom_Pro'
      Size = 50
    end
    object MovKitC_cod_Uni: TStringField
      FieldName = 'C_cod_Uni'
      Size = 2
    end
    object MovKitN_qtd_Pro: TFloatField
      FieldName = 'N_qtd_Pro'
      DisplayFormat = '###,###,##0.00'
    end
    object MovKitQtdKit: TFloatField
      FieldName = 'QtdKit'
      DisplayFormat = '###,###,##0.00'
    end
    object MovKitValorVenda: TStringField
      FieldName = 'ValorVenda'
      Size = 26
    end
  end
  object DataMovKit: TDataSource
    DataSet = MovKit
    Left = 28
  end
  object Aux: TQuery
    DatabaseName = 'BaseDados'
    Left = 56
  end
end
