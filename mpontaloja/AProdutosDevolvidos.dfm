object FProdutosDevolvidos: TFProdutosDevolvidos
  Left = 54
  Top = 90
  Caption = 'Produtos Devolvidos'
  ClientHeight = 371
  ClientWidth = 626
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
    Width = 626
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Produtos Devolvidos   '
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
    Width = 626
    Height = 32
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
      Left = 32
      Top = 7
      Width = 47
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cliente :'
    end
    object SpeedButton1: TSpeedButton
      Left = 142
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
    object Label2: TLabel
      Left = 172
      Top = 7
      Width = 249
      Height = 16
      AutoSize = False
      Caption = '                   '
    end
    object ECliente: TEditLocaliza
      Left = 82
      Top = 3
      Width = 59
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
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from dba.CadClientes '
        'Where I_Cod_cli = @')
      ASelectLocaliza.Strings = (
        'Select * from dba.CadClientes '
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
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 331
    Width = 626
    Height = 40
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
      Left = 520
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
  object PanelColor3: TPanelColor
    Left = 0
    Top = 73
    Width = 626
    Height = 258
    Align = alClient
    Caption = 'PanelColor3'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object Splitter1: TSplitter
      Left = 1
      Top = 150
      Width = 624
      Height = 10
      Cursor = crVSplit
      Align = alBottom
      Beveled = True
    end
    object DBGridColor1: TDBGridColor
      Left = 1
      Top = 160
      Width = 624
      Height = 97
      Align = alBottom
      Color = clInfoBk
      DataSource = DataMovNotasFiscaisFor
      FixedColor = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      ACorFoco = FPrincipal.CorFoco
      Columns = <
        item
          Expanded = False
          FieldName = 'C_Cod_pro'
          Title.Caption = 'C'#243'digo'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C_Nom_pro'
          Title.Caption = 'Descri'#231#227'o'
          Width = 205
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C_Cod_Cst'
          Title.Caption = 'CST'
          Width = 39
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C_Cod_Uni'
          Title.Caption = 'UN'
          Width = 34
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_Qtd_Pro'
          Title.Caption = 'Qtd'
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_Vlr_Pro'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 118
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_Per_Icm'
          Title.Caption = 'ICMS'
          Width = 57
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_Per_IPI'
          Title.Caption = 'IPI'
          Width = 59
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_Tot_Pro'
          Title.Caption = 'Valor Total'
          Width = 112
          Visible = True
        end>
    end
    object GridIndice1: TGridIndice
      Left = 1
      Top = 1
      Width = 624
      Height = 149
      Align = alClient
      Color = clInfoBk
      DataSource = DataCadNotaFiscaisFor
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
      AListaIndice.Strings = (
        '0'
        '4')
      AListaCAmpos.Strings = (
        'I_NRO_NOT'
        'D_DAT_EMI')
      AindiceInicial = 0
      ALinhaSQLOrderBy = 0
      Columns = <
        item
          Expanded = False
          FieldName = 'I_Nro_Not'
          Title.Caption = 'Nota  [>]'
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C_Ser_Not'
          Title.Caption = 'S'#233'rie'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fornecedor'
          Title.Caption = 'Cliente'
          Width = 304
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_Tot_Not'
          Title.Caption = 'Valor Total'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D_Dat_Emi'
          Title.Caption = 'Emiss'#227'o  [+]'
          Width = 80
          Visible = True
        end>
    end
  end
  object CadNotaFiscaisFor: TQuery
    AfterScroll = CadNotaFiscaisForAfterScroll
    DatabaseName = 'BaseDados'
    SQL.Strings = (
      
        'Select Cad.I_Emp_Fil, Cad.I_Seq_Not, Cad.I_Nro_Not, Cad.C_Ser_No' +
        't,'
      'Cad.D_Dat_Emi, N_Tot_Not, Cad.D_ULT_ALT,'
      'Cad.I_Cod_Cli ||'#39'-'#39'|| Cli.C_Nom_Cli Fornecedor'
      ''
      'from dba.CadnotaFiscaisFor Cad, CadClientes Cli'
      'Where Cad.I_Cod_Cli = Cli.I_Cod_Cli')
    Left = 8
  end
  object DataCadNotaFiscaisFor: TDataSource
    DataSet = CadNotaFiscaisFor
    Left = 48
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 212
  end
  object MovNotasfiscaisFor: TQuery
    DatabaseName = 'BaseDados'
    SQL.Strings = (
      
        'Select Mov.I_Emp_Fil, Mov.I_Seq_Not, Mov.C_Cod_pro, Mov.N_Qtd_Pr' +
        'o,'
      ' Mov.N_Vlr_Pro, Mov.N_Per_Icm, Mov.N_Per_IPI, '
      'Mov.N_Tot_Pro,  Mov.C_Cod_Cst, Mov.I_Seq_Mov, Mov.C_Cod_Uni, '
      'Pro.C_Nom_pro '
      ''
      'From dba.MovNotasFiscais Mov, CadProdutos Pro '
      ''
      'Where  Mov.I_Seq_pro = Pro.I_Seq_pro'
      'and Mov.I_Emp_Fil = 11 '
      'order by i_seq_Mov asc; ')
    Left = 95
    object MovNotasfiscaisForI_Seq_Not: TIntegerField
      FieldName = 'I_Seq_Not'
    end
    object MovNotasfiscaisForC_Cod_pro: TStringField
      FieldName = 'C_Cod_pro'
    end
    object MovNotasfiscaisForN_Qtd_Pro: TFloatField
      FieldName = 'N_Qtd_Pro'
    end
    object MovNotasfiscaisForN_Vlr_Pro: TFloatField
      FieldName = 'N_Vlr_Pro'
      currency = True
    end
    object MovNotasfiscaisForN_Per_Icm: TFloatField
      FieldName = 'N_Per_Icm'
      DisplayFormat = '##0.00 %'
    end
    object MovNotasfiscaisForN_Per_IPI: TFloatField
      FieldName = 'N_Per_IPI'
      DisplayFormat = '##0.00 %'
    end
    object MovNotasfiscaisForN_Tot_Pro: TFloatField
      FieldName = 'N_Tot_Pro'
      currency = True
    end
    object MovNotasfiscaisForC_Cod_Cst: TStringField
      FieldName = 'C_Cod_Cst'
      Size = 2
    end
    object MovNotasfiscaisForI_Seq_Mov: TIntegerField
      FieldName = 'I_Seq_Mov'
    end
    object MovNotasfiscaisForC_Cod_Uni: TStringField
      FieldName = 'C_Cod_Uni'
      Size = 2
    end
    object MovNotasfiscaisForC_Nom_pro: TStringField
      FieldName = 'C_Nom_pro'
      Size = 50
    end
    object MovNotasfiscaisForI_Emp_Fil: TIntegerField
      FieldName = 'I_Emp_Fil'
    end
  end
  object DataMovNotasFiscaisFor: TDataSource
    AutoEdit = False
    DataSet = MovNotasfiscaisFor
    Left = 123
  end
end
