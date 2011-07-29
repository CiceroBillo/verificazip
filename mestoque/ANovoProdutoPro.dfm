object FNovoProdutoPro: TFNovoProdutoPro
  Left = 6
  Top = 70
  Caption = 'Produto'
  ClientHeight = 596
  ClientWidth = 804
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton17: TSpeedButton
    Left = 161
    Top = 134
    Width = 24
    Height = 24
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
  object Label136: TLabel
    Left = 184
    Top = 230
    Width = 60
    Height = 13
    Caption = 'Folha 2 Por :'
  end
  object Label138: TLabel
    Left = 53
    Top = 339
    Width = 33
    Height = 13
    Caption = 'Cores :'
  end
  object PanelColor1: TPanelColor
    Left = 0
    Top = 41
    Width = 804
    Height = 514
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
    object Paginas: TPageControl
      Left = 1
      Top = 1
      Width = 802
      Height = 512
      ActivePage = PTabelaPreco
      Align = alClient
      TabOrder = 0
      OnChange = PaginasChange
      OnChanging = PaginasChanging
      object PGerais: TTabSheet
        Caption = 'Gerais'
        object PanelColor6: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          BevelOuter = bvNone
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object SpeedButton1: TSpeedButton
            Left = 282
            Top = 0
            Width = 24
            Height = 24
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
            OnClick = SpeedButton1Click
          end
          object SpeedButton12: TSpeedButton
            Left = 622
            Top = 27
            Width = 24
            Height = 24
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
          object SpeedButton3: TSpeedButton
            Left = 250
            Top = 78
            Width = 24
            Height = 24
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
          object Label21: TLabel
            Left = 94
            Top = 294
            Width = 82
            Height = 16
            Alignment = taRightJustify
            Caption = '% Comiss'#227'o :'
          end
          object Label23: TLabel
            Left = 537
            Top = 238
            Width = 129
            Height = 16
            Alignment = taRightJustify
            Caption = '% Maximo Desconto :'
          end
          object Label3: TLabel
            Left = 61
            Top = 56
            Width = 115
            Height = 16
            Alignment = taRightJustify
            Caption = 'Nome / Descri'#231#227'o :'
          end
          object LIPI: TLabel
            Left = 155
            Top = 135
            Width = 21
            Height = 16
            Alignment = taRightJustify
            Caption = 'IPI :'
          end
          object Label4: TLabel
            Left = 550
            Top = 340
            Width = 116
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor de Revenda :'
          end
          object Label5: TLabel
            Left = 309
            Top = 82
            Width = 60
            Height = 16
            Caption = '                    '
          end
          object Label6: TLabel
            Left = 89
            Top = 4
            Width = 87
            Height = 16
            Alignment = taRightJustify
            Caption = 'Classifica'#231#227'o :'
          end
          object Label65: TLabel
            Left = 503
            Top = 31
            Width = 53
            Height = 16
            Alignment = taRightJustify
            Caption = 'Usu'#225'rio :'
          end
          object Label66: TLabel
            Left = 649
            Top = 31
            Width = 39
            Height = 16
            Caption = '             '
          end
          object Label7: TLabel
            Left = 565
            Top = 82
            Width = 101
            Height = 16
            Alignment = taRightJustify
            Caption = 'Unidade Venda :'
          end
          object Label73: TLabel
            Left = 485
            Top = 134
            Width = 181
            Height = 16
            Alignment = taRightJustify
            Caption = 'Qtd Dias Entrega Fornecedor :'
          end
          object Label9: TLabel
            Left = 76
            Top = 320
            Width = 100
            Height = 16
            Alignment = taRightJustify
            Caption = 'Origem Produto :'
          end
          object LblClassificacaoFiscal: TLabel
            Left = 10
            Top = 109
            Width = 166
            Height = 16
            Alignment = taRightJustify
            Caption = 'Classifica'#231#227'o Fiscal / NCM :'
          end
          object LblDescontoKit: TLabel
            Left = 97
            Top = 268
            Width = 79
            Height = 16
            Alignment = taRightJustify
            Caption = '% Desconto :'
          end
          object LblQtdMin: TLabel
            Left = 544
            Top = 160
            Width = 122
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade M'#237'nima :'
          end
          object LblQtdPed: TLabel
            Left = 543
            Top = 186
            Width = 123
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade Pedido :'
          end
          object LDescricaoTecnica: TLabel
            Left = 52
            Top = 428
            Width = 120
            Height = 16
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o T'#233'cnica :'
          end
          object LNomClassificacao: TLabel
            Left = 310
            Top = 4
            Width = 72
            Height = 16
            Caption = '                        '
          end
          object LPatFoto: TLabel
            Left = 179
            Top = 394
            Width = 54
            Height = 16
            Caption = 'LPatFoto'
          end
          object LQtdCaixa: TLabel
            Left = 541
            Top = 108
            Width = 125
            Height = 16
            Alignment = taRightJustify
            Caption = 'Unidades por Caixa :'
          end
          object LValCusto: TLabel
            Left = 523
            Top = 288
            Width = 143
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor de Custo Unit'#225'rio :'
          end
          object LValVenda: TLabel
            Left = 517
            Top = 314
            Width = 149
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor de Venda Unit'#225'rio :'
          end
          object Label1: TLabel
            Left = 126
            Top = 30
            Width = 50
            Height = 16
            Alignment = taRightJustify
            Caption = 'C'#243'digo :'
          end
          object Label10: TLabel
            Left = 612
            Top = 263
            Width = 54
            Height = 16
            Alignment = taRightJustify
            Caption = '% Lucro :'
          end
          object Label14: TLabel
            Left = 540
            Top = 212
            Width = 126
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade Produto :'
          end
          object Label18: TLabel
            Left = 127
            Top = 82
            Width = 49
            Height = 16
            Alignment = taRightJustify
            Caption = 'Moeda :'
          end
          object Label19: TLabel
            Left = 45
            Top = 186
            Width = 131
            Height = 16
            Alignment = taRightJustify
            Caption = '% Redu'#231#227'o do ICMS :'
          end
          object Label2: TLabel
            Left = 89
            Top = 394
            Width = 87
            Height = 16
            Alignment = taRightJustify
            Caption = 'Diret'#243'rio Foto :'
          end
          object Label102: TLabel
            Left = 55
            Top = 345
            Width = 121
            Height = 16
            Alignment = taRightJustify
            Caption = 'Destina'#231#227'o Poduto :'
          end
          object Label13: TLabel
            Left = 20
            Top = 212
            Width = 154
            Height = 16
            Alignment = taRightJustify
            Caption = '% Substitui'#231#227'o Tribut'#225'ria :'
          end
          object LICMS: TLabel
            Left = 138
            Top = 160
            Width = 38
            Height = 16
            Alignment = taRightJustify
            Caption = 'ICMS :'
          end
          object EPerDesconto: Tnumerico
            Left = 180
            Top = 264
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00 %;- ,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object EPerIPI: Tnumerico
            Left = 180
            Top = 130
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00 %;- ,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object EPerLucro: Tnumerico
            Left = 673
            Top = 259
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ',0.00 %;-,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 26
            OnChange = EPerLucroChange
          end
          object EPerMaxDesconto: Tnumerico
            Left = 673
            Top = 234
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ',0.00 %;-,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 25
          end
          object EQtdEntregaFornecedor: Tnumerico
            Left = 673
            Top = 130
            Width = 94
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
            TabOrder = 21
          end
          object EQtdMinima: Tnumerico
            Left = 673
            Top = 156
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 22
            OnExit = EQtdMinimaExit
          end
          object EQtdPedido: Tnumerico
            Left = 673
            Top = 182
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 23
            OnExit = EQtdPedidoExit
          end
          object EQuantidade: Tnumerico
            Left = 673
            Top = 208
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 24
            OnExit = EQuantidadeExit
          end
          object EReducaoICMS: Tnumerico
            Left = 180
            Top = 182
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00 %;- ,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object EUnidadesPorCaixa: Tnumerico
            Left = 673
            Top = 104
            Width = 94
            Height = 24
            ACampoObrigatorio = True
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = 11661566
            ADecimal = 0
            AMascara = ' ,0;- ,0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 20
            OnChange = ECodEmpresaChange
          end
          object EUnidadesVenda: TComboBoxColor
            Left = 673
            Top = 78
            Width = 94
            Height = 24
            Style = csDropDownList
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Sorted = True
            TabOrder = 19
            OnChange = EUnidadesVendaChange
            ACampoObrigatorio = True
            ACorFoco = FPrincipal.CorFoco
          end
          object EUsuario: TRBEditLocaliza
            Left = 563
            Top = 26
            Width = 57
            Height = 24
            TabStop = False
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label66
            ABotao = SpeedButton12
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select I_COD_USU, C_NOM_USU '
              ' from CADUSUARIOS '
              ' Where I_COD_USU = @')
            ASelectLocaliza.Strings = (
              'Select I_COD_USU, C_NOM_USU '
              ' from CADUSUARIOS ')
            APermitirVazio = True
            AColunas = <
              item
                ATituloColuna = 'C'#243'digo'
                ATamanhoColuna = 8
                ACampoFiltro = False
                ANomeCampo = 'I_COD_USU'
                AMostrarNaGrade = True
                AOrdemInicial = False
              end
              item
                ATituloColuna = 'Nome'
                ATamanhoColuna = 40
                ACampoFiltro = True
                ANomeCampo = 'C_NOM_USU'
                AMostrarNaGrade = True
                AOrdemInicial = True
              end>
            ALocalizaPadrao = lpUsuario
            ATituloFormulario = '   Localiza Usu'#225'rio '
          end
          object EValCusto: Tnumerico
            Left = 673
            Top = 284
            Width = 94
            Height = 24
            ACampoObrigatorio = True
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = 11661566
            ADecimal = 4
            AMascara = 'R$ ,0.0000;-R$ ,0.0000'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 27
            OnChange = ECodEmpresaChange
            OnExit = EValCustoExit
          end
          object EValRevenda: Tnumerico
            Left = 673
            Top = 336
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            ADecimal = 4
            AMascara = 'R$ ,0.0000;-R$ ,0.0000'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 29
            OnChange = ECodEmpresaChange
            OnExit = EValRevendaExit
          end
          object EValVenda: Tnumerico
            Left = 672
            Top = 310
            Width = 94
            Height = 24
            ACampoObrigatorio = True
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = 11661566
            ADecimal = 4
            AMascara = 'R$ ,0.0000;-R$ ,0.0000'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 28
            OnChange = ECodEmpresaChange
            OnExit = EValVendaExit
          end
          object BFoto: TBitBtn
            Left = 180
            Top = 365
            Width = 130
            Height = 30
            HelpContext = 27
            Caption = '&Associar Foto'
            DoubleBuffered = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
              BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
              BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
              BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
              BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
              EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
              EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
              EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
              EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
            NumGlyphs = 2
            ParentDoubleBuffered = False
            PopupMenu = MImagem
            TabOrder = 18
            OnClick = BFotoClick
          end
          object CKit: TRadioButton
            Left = 652
            Top = 3
            Width = 69
            Height = 17
            Caption = 'Kit'
            TabOrder = 1
          end
          object CProduto: TRadioButton
            Left = 562
            Top = 3
            Width = 84
            Height = 17
            Caption = 'Produto'
            TabOrder = 2
          end
          object CProdutoAtivo: TCheckBox
            Left = 672
            Top = 361
            Width = 97
            Height = 17
            Caption = 'Produto Ativo'
            TabOrder = 30
          end
          object ECifraoMoeda: TEditColor
            Left = 275
            Top = 78
            Width = 30
            Height = 24
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            OnChange = ECodEmpresaChange
            ACampoObrigatorio = True
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EClassificacaoFiscal: TMaskEditColor
            Left = 180
            Top = 104
            Width = 197
            Height = 24
            Color = clInfoBk
            EditMask = '99999999;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            TabOrder = 8
            OnChange = ECodEmpresaChange
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object ECodClassificacao: TMaskEditColor
            Left = 180
            Top = 0
            Width = 100
            Height = 24
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = ECodEmpresaChange
            OnEnter = ECodClassificacaoEnter
            OnExit = ECodClassificacaoExit
            OnKeyDown = ECodClassificacaoKeyDown
            ACampoObrigatorio = True
            ACorFoco = FPrincipal.CorFoco
          end
          object ECodMoeda: TEditLocaliza
            Left = 180
            Top = 78
            Width = 68
            Height = 24
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = ECodEmpresaChange
            ACampoObrigatorio = True
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label5
            ABotao = SpeedButton3
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from CadMoedas '
              'Where I_Cod_Moe = @')
            ASelectLocaliza.Strings = (
              'Select * from CadMoedas'
              'Where C_Nom_Moe like '#39'@%'#39
              'order by C_Nom_Moe')
            APermitirVazio = True
            ASomenteNumeros = True
            AInfo.CampoCodigo = 'I_COD_MOE'
            AInfo.CampoNome = 'C_NOM_MOE'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Moeda'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Moeda  '
            AInfo.RetornoExtra1 = 'C_CIF_MOE'
            ADarFocoDepoisdoLocaliza = True
            OnRetorno = ECodMoedaRetorno
          end
          object ECodProduto: TEditColor
            Left = 180
            Top = 26
            Width = 125
            Height = 24
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            PopupMenu = PopupMenu1
            TabOrder = 3
            OnChange = ECodEmpresaChange
            OnExit = ECodProdutoExit
            ACampoObrigatorio = True
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EDescricao: TEditColor
            Left = 180
            Top = 52
            Width = 587
            Height = 24
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = ECodEmpresaChange
            OnExit = EDescricaoExit
            ACampoObrigatorio = True
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EDescricaoTecnica: TMemoColor
            Left = 179
            Top = 412
            Width = 587
            Height = 60
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 31
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object EOrigemProduto: TComboBoxColor
            Left = 180
            Top = 316
            Width = 244
            Height = 24
            Style = csDropDownList
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
            OnChange = ECodEmpresaChange
            Items.Strings = (
              'NACIONAL'
              'ESTRANGEIRA - IMPORTACAO DIRETA'
              'ESTRANGEIRA - AQUISICAO NO MERCADO INTERNO')
            ACampoObrigatorio = True
            ACorFoco = FPrincipal.CorFoco
          end
          object EPerComissao: Tnumerico
            Left = 180
            Top = 290
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00 %;- ,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object EDestinoProduto: TComboBoxColor
            Left = 180
            Top = 341
            Width = 244
            Height = 24
            Style = csDropDownList
            Color = 11661566
            DropDownCount = 12
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
            OnChange = ECodEmpresaChange
            Items.Strings = (
              '00 - Mercadoria para Revenda'
              '01 - Materia Prima'
              '02 - Embalagem'
              '03 - Produtos em Processo'
              '04 - Produto Acabado'
              '05 - SubProduto'
              '06 - Produto Intermediario'
              '07 - Material de Uso e Consumo'
              '08 - Ativo Imbolilizado'
              '09 - Servi'#231'os'
              '10 - Outros Insumos'
              '99 - Outras ')
            ACampoObrigatorio = True
            ACorFoco = FPrincipal.CorFoco
          end
          object CSubstituicaoTributaria: TCheckBox
            Left = 180
            Top = 234
            Width = 291
            Height = 17
            Caption = 'Substitui'#231#227'o Tribut'#225'ria nor Fornecedor'
            TabOrder = 12
            OnClick = CSubstituicaoTributariaClick
          end
          object CDescontoBaseICMS: TCheckBox
            Left = 180
            Top = 251
            Width = 291
            Height = 17
            Caption = 'Desconto na Base de Calculo ICMS conf. UF '
            TabOrder = 13
          end
          object EPerST: Tnumerico
            Left = 180
            Top = 208
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00 %;- ,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            OnExit = CSubstituicaoTributariaClick
          end
          object EPerICMS: Tnumerico
            Left = 180
            Top = 156
            Width = 94
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00 %;- ,0.00 %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 32
          end
          object BLimpaFoto: TBitBtn
            Left = 309
            Top = 365
            Width = 36
            Height = 30
            HelpContext = 27
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
            PopupMenu = MImagem
            TabOrder = 33
            OnClick = BLimpaFotoClick
          end
        end
      end
      object PCadarco: TTabSheet
        Caption = 'Cadar'#231'o Tran'#231'ado'
        ImageIndex = 1
        object PanelColor7: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label11: TLabel
            Left = 301
            Top = 38
            Width = 66
            Height = 16
            Caption = '                      '
          end
          object SpeedButton4: TSpeedButton
            Left = 273
            Top = 34
            Width = 24
            Height = 24
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
          object Label43: TLabel
            Left = 87
            Top = 64
            Width = 112
            Height = 16
            Alignment = taRightJustify
            Caption = 'Metros por Minuto :'
          end
          object Label44: TLabel
            Left = 64
            Top = 142
            Width = 135
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade de Fusos :'
          end
          object Label45: TLabel
            Left = 28
            Top = 194
            Width = 171
            Height = 16
            Alignment = taRightJustify
            Caption = 'Metros por T'#225'bua Pequeno :'
          end
          object Label24: TLabel
            Left = 171
            Top = 298
            Width = 28
            Height = 16
            Alignment = taRightJustify
            Caption = 'MM :'
          end
          object Label25: TLabel
            Left = 138
            Top = 168
            Width = 61
            Height = 16
            Alignment = taRightJustify
            Caption = 'T'#237'tulo Fio :'
          end
          object Label40: TLabel
            Left = 97
            Top = 12
            Width = 102
            Height = 16
            Alignment = taRightJustify
            Caption = 'N'#250'mero de Fios :'
          end
          object Label41: TLabel
            Left = 110
            Top = 38
            Width = 89
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo M'#225'quina :'
          end
          object Label55: TLabel
            Left = 38
            Top = 220
            Width = 161
            Height = 16
            Alignment = taRightJustify
            Caption = 'Metros por T'#225'bua Grande :'
          end
          object Label56: TLabel
            Left = 22
            Top = 116
            Width = 177
            Height = 16
            Alignment = taRightJustify
            Caption = 'Engrenagem Espula Grande :'
          end
          object Label57: TLabel
            Left = 32
            Top = 246
            Width = 167
            Height = 16
            Alignment = taRightJustify
            Caption = 'Metros por T'#225'bua Transilin :'
          end
          object Label58: TLabel
            Left = 12
            Top = 90
            Width = 187
            Height = 16
            Alignment = taRightJustify
            Caption = 'Engrenagem Espula Pequena :'
          end
          object Label63: TLabel
            Left = 123
            Top = 272
            Width = 76
            Height = 16
            Alignment = taRightJustify
            Caption = 'Enchimento :'
          end
          object EMetrosMinuto: TEditColor
            Left = 203
            Top = 60
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = ECodEmpresaChange
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EEngEspPequena: TEditColor
            Left = 203
            Top = 86
            Width = 94
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
          end
          object EEngEspGrande: TEditColor
            Left = 203
            Top = 112
            Width = 94
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
          end
          object ENumFios: TEditColor
            Left = 203
            Top = 8
            Width = 94
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
          end
          object ETipMaquina: TEditLocaliza
            Left = 203
            Top = 34
            Width = 68
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = ECodEmpresaChange
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label11
            ABotao = SpeedButton4
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from MAQUINA'
              'Where CODMAQ = @')
            ASelectLocaliza.Strings = (
              'Select * from MAQUINA'
              'Where NOMMAQ LIKE '#39'@%'#39)
            APermitirVazio = True
            AInfo.CampoCodigo = 'CODMAQ'
            AInfo.CampoNome = 'NOMMAQ'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'M'#225'quina'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza M'#225'quina  '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ETipMaquinaCadastrar
          end
          object EQtdFuso: TEditColor
            Left = 203
            Top = 138
            Width = 94
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
          end
          object EMetTabuaTrans: TEditColor
            Left = 203
            Top = 242
            Width = 94
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
          end
          object EEnchimento: TEditColor
            Left = 203
            Top = 268
            Width = 585
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ELargProduto: TEditColor
            Left = 203
            Top = 294
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ETituloFio: TEditColor
            Left = 203
            Top = 164
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EMetTabuaPequeno: TEditColor
            Left = 203
            Top = 190
            Width = 94
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
          end
          object EMetTabuaGrande: TEditColor
            Left = 203
            Top = 216
            Width = 94
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
          end
        end
      end
      object PETiqueta: TTabSheet
        Caption = 'Etiqueta'
        ImageIndex = 2
        object PanelColor8: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label29: TLabel
            Left = 72
            Top = 82
            Width = 127
            Height = 16
            Alignment = taRightJustify
            Caption = 'Comprimento Figura :'
          end
          object Label36: TLabel
            Left = 111
            Top = 263
            Width = 88
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo Emenda :'
          end
          object Label27: TLabel
            Left = 97
            Top = 30
            Width = 102
            Height = 16
            Alignment = taRightJustify
            Caption = 'Largura Produto :'
          end
          object Label34: TLabel
            Left = 124
            Top = 237
            Width = 75
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo Fundo :'
          end
          object Label30: TLabel
            Left = 97
            Top = 108
            Width = 102
            Height = 16
            Alignment = taRightJustify
            Caption = 'N'#250'mero de Fios :'
          end
          object Label53: TLabel
            Left = 158
            Top = 134
            Width = 41
            Height = 16
            Alignment = taRightJustify
            Caption = 'Pente :'
          end
          object Label47: TLabel
            Left = 115
            Top = 359
            Width = 84
            Height = 16
            Alignment = taRightJustify
            Caption = 'Engrenagem :'
          end
          object Label28: TLabel
            Left = 319
            Top = 30
            Width = 136
            Height = 16
            Alignment = taRightJustify
            Caption = 'Comprimento Produto :'
          end
          object Label26: TLabel
            Left = 66
            Top = 385
            Width = 133
            Height = 16
            Alignment = taRightJustify
            Caption = 'Prateleira do Produto :'
          end
          object Label54: TLabel
            Left = 115
            Top = 212
            Width = 84
            Height = 16
            Alignment = taRightJustify
            Caption = 'Batidas Tear :'
          end
          object Label48: TLabel
            Left = 106
            Top = 160
            Width = 93
            Height = 16
            Alignment = taRightJustify
            Caption = 'Batidas Totais :'
          end
          object Label33: TLabel
            Left = 66
            Top = 186
            Width = 133
            Height = 16
            Alignment = taRightJustify
            Caption = 'Batidas Produto (RL)  :'
          end
          object Label59: TLabel
            Left = 130
            Top = 289
            Width = 69
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo Corte :'
          end
          object Label61: TLabel
            Left = 148
            Top = 4
            Width = 51
            Height = 16
            Alignment = taRightJustify
            Caption = 'Sumula :'
          end
          object Label22: TLabel
            Left = 133
            Top = 412
            Width = 66
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo Tear :'
          end
          object Label38: TLabel
            Left = 51
            Top = 316
            Width = 148
            Height = 16
            Alignment = taRightJustify
            Caption = 'Indice de Produtividade :'
          end
          object Label88: TLabel
            Left = 61
            Top = 56
            Width = 138
            Height = 16
            Alignment = taRightJustify
            Caption = 'Data Entrada Amostra :'
          end
          object SpeedButton5: TSpeedButton
            Left = 273
            Top = 234
            Width = 24
            Height = 24
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
          object SpeedButton6: TSpeedButton
            Left = 273
            Top = 260
            Width = 24
            Height = 24
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
          object SpeedButton7: TSpeedButton
            Left = 273
            Top = 286
            Width = 24
            Height = 24
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
            Left = 301
            Top = 238
            Width = 66
            Height = 16
            Caption = '                      '
          end
          object Label15: TLabel
            Left = 301
            Top = 264
            Width = 66
            Height = 16
            Caption = '                      '
          end
          object Label20: TLabel
            Left = 301
            Top = 290
            Width = 66
            Height = 16
            Caption = '                      '
          end
          object SpeedButton8: TSpeedButton
            Left = 555
            Top = 51
            Width = 29
            Height = 25
            Caption = '...'
            OnClick = SpeedButton8Click
          end
          object Label89: TLabel
            Left = 328
            Top = 56
            Width = 127
            Height = 16
            Alignment = taRightJustify
            Caption = 'Data Sa'#237'da Amostra :'
          end
          object ENumeroFios: TEditColor
            Left = 203
            Top = 104
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EComprFigura: TEditColor
            Left = 203
            Top = 78
            Width = 94
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
          end
          object ESumula: TEditColor
            Left = 203
            Top = 0
            Width = 94
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
          end
          object EBatidasTear: TEditColor
            Left = 203
            Top = 208
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EBatidasTotais: TEditColor
            Left = 203
            Top = 156
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnExit = EBatidasTotaisExit
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object CCalandragem: TCheckBox
            Left = 203
            Top = 337
            Width = 105
            Height = 17
            Caption = 'Calandragem'
            TabOrder = 15
          end
          object CEngomagem: TCheckBox
            Left = 319
            Top = 337
            Width = 105
            Height = 17
            Caption = 'Engomagem'
            TabOrder = 16
          end
          object EBatidasProduto: TEditColor
            Left = 203
            Top = 182
            Width = 94
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
          end
          object EComprProduto: TEditColor
            Left = 459
            Top = 26
            Width = 94
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
          end
          object EDatAmostra: TMaskEditColor
            Left = 203
            Top = 52
            Width = 94
            Height = 24
            Color = clInfoBk
            EditMask = '!99\/99\/0000;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 3
            Text = '  /  /    '
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object EDatSaidaAmostra: TMaskEditColor
            Left = 459
            Top = 52
            Width = 94
            Height = 24
            Color = clInfoBk
            EditMask = '!99\/99\/0000;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 4
            Text = '  /  /    '
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object EEngrenagem: TEditColor
            Left = 203
            Top = 355
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EIndiceProdutividade: TEditColor
            Left = 203
            Top = 312
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ELarguraProduto: TEditColor
            Left = 203
            Top = 26
            Width = 94
            Height = 24
            Color = clInfoBk
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
            AInteiro = 0
          end
          object EPente: TEditColor
            Left = 203
            Top = 130
            Width = 94
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
          end
          object EPrateleiraProduto: TEditColor
            Left = 203
            Top = 381
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 18
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ETipCorte: TEditLocaliza
            Left = 203
            Top = 286
            Width = 68
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label20
            ABotao = SpeedButton7
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from TIPOCORTE'
              'Where CODCORTE = @')
            ASelectLocaliza.Strings = (
              'Select * from TIPOCORTE'
              'Where NOMCORTE LIKE '#39'@%'#39
              'order by NOMCORTE')
            APermitirVazio = True
            AInfo.CampoCodigo = 'CODCORTE'
            AInfo.CampoNome = 'NOMCORTE'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Tipo Corte  '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ETipCorteCadastrar
          end
          object ETipEmenda: TEditLocaliza
            Left = 203
            Top = 260
            Width = 68
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label15
            ABotao = SpeedButton6
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from TIPOEMENDA'
              'Where CODEME = @')
            ASelectLocaliza.Strings = (
              'Select * from TIPOEMENDA'
              'Where NOMEME like '#39'@%'#39
              'order by NOMEME')
            APermitirVazio = True
            AInfo.CampoCodigo = 'CODEME'
            AInfo.CampoNome = 'NOMEME'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Tipo Emenda  '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ETipEmendaCadastrar
          end
          object ETipFundo: TEditLocaliza
            Left = 203
            Top = 234
            Width = 68
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label12
            ABotao = SpeedButton5
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from CADTIPOFUNDO '
              'Where I_COD_FUN = @')
            ASelectLocaliza.Strings = (
              'Select * from CADTIPOFUNDO'
              'Where C_NOM_FUN like '#39'@%'#39
              'order by C_NOM_FUN')
            APermitirVazio = True
            AInfo.CampoCodigo = 'I_COD_FUN'
            AInfo.CampoNome = 'C_NOM_FUN'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'DEscri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Tipo Fundo  '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ETipFundoCadastrar
          end
          object Panel1: TPanel
            Left = 203
            Top = 408
            Width = 302
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 19
            object RTearConvencional: TRadioButton
              Left = 0
              Top = 5
              Width = 145
              Height = 17
              Caption = 'Tear Convencional'
              TabOrder = 0
            end
            object RTearH: TRadioButton
              Left = 152
              Top = 5
              Width = 145
              Height = 17
              Caption = 'Tear H (Eletr'#244'nico)'
              TabOrder = 1
            end
          end
        end
      end
      object PCadarcoFita: TTabSheet
        Caption = 'Cadar'#231'o'
        ImageIndex = 12
        object PanelColor13: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label16: TLabel
            Left = 116
            Top = 13
            Width = 75
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo Fundo :'
          end
          object SpeedButton2: TSpeedButton
            Left = 265
            Top = 8
            Width = 26
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
          object Label103: TLabel
            Left = 293
            Top = 13
            Width = 66
            Height = 16
            Caption = '                      '
          end
          object Label107: TLabel
            Left = 81
            Top = 43
            Width = 110
            Height = 16
            Alignment = taRightJustify
            Caption = 'Engrenagens Bat :'
          end
          object Label108: TLabel
            Left = 58
            Top = 130
            Width = 133
            Height = 16
            Alignment = taRightJustify
            Caption = 'Engrenagens Trama : '
          end
          object Label109: TLabel
            Left = 136
            Top = 72
            Width = 55
            Height = 16
            Alignment = taRightJustify
            Caption = 'Sistema :'
          end
          object Label110: TLabel
            Left = 95
            Top = 101
            Width = 96
            Height = 16
            Alignment = taRightJustify
            Caption = 'Batidas por cm :'
          end
          object Label111: TLabel
            Left = 150
            Top = 159
            Width = 41
            Height = 16
            Alignment = taRightJustify
            Caption = 'Pente :'
          end
          object Label112: TLabel
            Left = 89
            Top = 188
            Width = 102
            Height = 16
            Alignment = taRightJustify
            Caption = 'Largura Produto :'
          end
          object ETipoFundo: TEditLocaliza
            Left = 197
            Top = 9
            Width = 68
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
            ATexto = Label103
            ABotao = SpeedButton2
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from CADTIPOFUNDO '
              'Where I_COD_FUN = @')
            ASelectLocaliza.Strings = (
              'Select * from CADTIPOFUNDO'
              'Where C_NOM_FUN like '#39'@%'#39
              'order by C_NOM_FUN')
            APermitirVazio = True
            AInfo.CampoCodigo = 'I_COD_FUN'
            AInfo.CampoNome = 'C_NOM_FUN'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'DEscri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Tipo Fundo  '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ETipFundoCadastrar
          end
          object EEngrenagensBat: TEditColor
            Left = 195
            Top = 39
            Width = 94
            Height = 24
            Color = clInfoBk
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
            AInteiro = 0
          end
          object EEngrenagemTrama: TEditColor
            Left = 195
            Top = 126
            Width = 94
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
          end
          object ESistemaTear: TEditColor
            Left = 195
            Top = 68
            Width = 94
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
          end
          object EBatidasPorCm: TEditColor
            Left = 195
            Top = 96
            Width = 94
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
          end
          object EPenteCadarco: TEditColor
            Left = 195
            Top = 155
            Width = 94
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
          end
          object ELargura: TEditColor
            Left = 195
            Top = 184
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object CCalandragemFita: TCheckBox
            Left = 200
            Top = 214
            Width = 105
            Height = 17
            Caption = 'Calandragem'
            TabOrder = 7
          end
          object CPreEncolhido: TCheckBox
            Left = 311
            Top = 214
            Width = 105
            Height = 17
            Caption = 'Pr'#233' Encolhido'
            TabOrder = 8
          end
        end
      end
      object PCombinacao: TTabSheet
        Caption = 'Combina'#231#227'o'
        ImageIndex = 3
        object PanelColor12: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label39: TLabel
            Left = 1
            Top = 146
            Width = 792
            Height = 16
            Align = alTop
            Caption = '<F4> Foco Para a Pr'#243'xima Grade'
            ExplicitWidth = 199
          end
          object Label35: TLabel
            Left = 1
            Top = 1
            Width = 792
            Height = 16
            Align = alTop
            Caption = 'Combina'#231#227'o'
            Color = clSilver
            ParentColor = False
            ExplicitWidth = 77
          end
          object Label37: TLabel
            Left = 1
            Top = 162
            Width = 792
            Height = 16
            Align = alTop
            Caption = 'Figuras'
            ExplicitWidth = 45
          end
          object GCombinacao: TRBStringGridColor
            Left = 1
            Top = 17
            Width = 792
            Height = 129
            Align = alTop
            Color = clInfoBk
            ColCount = 12
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
            TabOrder = 0
            OnGetEditMask = GCombinacaoGetEditMask
            ACorFoco = FPrincipal.CorFoco
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GCombinacaoDadosValidos
            OnMudouLinha = GCombinacaoMudouLinha
            OnNovaLinha = GCombinacaoNovaLinha
            OnCarregaItemGrade = GCombinacaoCarregaItemGrade
            ColWidths = (
              19
              52
              55
              52
              53
              52
              64
              64
              64
              64
              64
              64)
            RowHeights = (
              18
              18
              18
              18
              18)
          end
          object GFigura: TRBStringGridColor
            Left = 1
            Top = 178
            Width = 792
            Height = 302
            Align = alClient
            Color = clInfoBk
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
            TabOrder = 1
            OnGetEditMask = GFiguraGetEditMask
            ACorFoco = FPrincipal.CorFoco
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GFiguraDadosValidos
            OnMudouLinha = GFiguraMudouLinha
            OnNovaLinha = GFiguraNovaLinha
            OnCarregaItemGrade = GFiguraCarregaItemGrade
            ColWidths = (
              19
              77
              86
              83
              84)
          end
        end
      end
      object PDadosAdicionais: TTabSheet
        Caption = 'Dados Adicionais'
        ImageIndex = 4
        object ScrollBox1: TScrollBox
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          TabOrder = 0
          object PanelColor9: TPanelColor
            Left = 0
            Top = 0
            Width = 773
            Height = 547
            Align = alTop
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            AUsarCorForm = False
            ACorForm = FPrincipal.CorForm
            object SpeedButton13: TSpeedButton
              Left = 271
              Top = 183
              Width = 24
              Height = 24
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
            object Label95: TLabel
              Left = 114
              Top = 187
              Width = 83
              Height = 16
              Alignment = taRightJustify
              Caption = 'Composi'#231#227'o :'
            end
            object Label96: TLabel
              Left = 301
              Top = 187
              Width = 66
              Height = 16
              Caption = '                      '
            end
            object Label100: TLabel
              Left = 299
              Top = 308
              Width = 14
              Height = 16
              Caption = 'ml'
            end
            object Label99: TLabel
              Left = 69
              Top = 308
              Width = 128
              Height = 16
              Alignment = taRightJustify
              Caption = 'Capacidade L'#237'quida :'
            end
            object Label86: TLabel
              Left = 107
              Top = 213
              Width = 90
              Height = 16
              Alignment = taRightJustify
              Caption = 'Altura Produto :'
            end
            object Label42: TLabel
              Left = 117
              Top = 494
              Width = 79
              Height = 16
              Alignment = taRightJustify
              Caption = 'Rendimento :'
            end
            object Label165: TLabel
              Left = 53
              Top = 282
              Width = 146
              Height = 16
              Alignment = taRightJustify
              Caption = 'C'#243'digo Desenvolvedor :'
            end
            object Label52: TLabel
              Left = 301
              Top = 56
              Width = 16
              Height = 16
              Caption = 'Kg'
            end
            object Label51: TLabel
              Left = 301
              Top = 30
              Width = 16
              Height = 16
              Caption = 'Kg'
            end
            object Label76: TLabel
              Left = 81
              Top = 161
              Width = 118
              Height = 16
              Alignment = taRightJustify
              Caption = 'Acondicionamento :'
            end
            object Label49: TLabel
              Left = 114
              Top = 30
              Width = 85
              Height = 16
              Alignment = taRightJustify
              Caption = 'Peso L'#237'quido :'
            end
            object Label50: TLabel
              Left = 127
              Top = 56
              Width = 72
              Height = 16
              Alignment = taRightJustify
              Caption = 'Peso Bruto :'
            end
            object Label75: TLabel
              Left = 119
              Top = 135
              Width = 80
              Height = 16
              Alignment = taRightJustify
              Caption = 'Embalagem :'
            end
            object Label64: TLabel
              Left = 66
              Top = 109
              Width = 133
              Height = 16
              Alignment = taRightJustify
              Caption = 'Prateleira do Produto :'
            end
            object Label32: TLabel
              Left = 98
              Top = 83
              Width = 101
              Height = 16
              Alignment = taRightJustify
              Caption = 'Meses Garantia :'
            end
            object Label74: TLabel
              Left = 301
              Top = 135
              Width = 66
              Height = 16
              Caption = '                      '
            end
            object Label17: TLabel
              Left = 63
              Top = 257
              Width = 136
              Height = 16
              Alignment = taRightJustify
              Caption = 'Comprimento Produto :'
            end
            object Label94: TLabel
              Left = 301
              Top = 257
              Width = 18
              Height = 16
              Caption = 'cm'
            end
            object Label93: TLabel
              Left = 106
              Top = 5
              Width = 93
              Height = 16
              Alignment = taRightJustify
              Caption = 'Data Cadastro :'
            end
            object Label77: TLabel
              Left = 301
              Top = 161
              Width = 66
              Height = 16
              Caption = '                      '
            end
            object SpeedButton10: TSpeedButton
              Left = 271
              Top = 157
              Width = 24
              Height = 24
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
            object SpeedButton9: TSpeedButton
              Left = 273
              Top = 131
              Width = 24
              Height = 24
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
            object Label87: TLabel
              Left = 301
              Top = 213
              Width = 18
              Height = 16
              Caption = 'cm'
            end
            object Label167: TLabel
              Left = 301
              Top = 282
              Width = 39
              Height = 16
              Caption = '             '
            end
            object SpeedButton28: TSpeedButton
              Left = 273
              Top = 278
              Width = 24
              Height = 24
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
            object Label116: TLabel
              Left = 78
              Top = 334
              Width = 119
              Height = 16
              Alignment = taRightJustify
              Caption = 'Situa'#231#227'o Tribut'#225'ria :'
            end
            object Label117: TLabel
              Left = 24
              Top = 357
              Width = 173
              Height = 16
              Alignment = taRightJustify
              Caption = 'Indicador Arrendondamento :'
            end
            object EPrateleiraPro: TEditColor
              Left = 203
              Top = 105
              Width = 94
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
            end
            object EPesoBruto: Tnumerico
              Left = 203
              Top = 52
              Width = 94
              Height = 24
              ACampoObrigatorio = False
              ACorFoco = FPrincipal.CorFoco
              ANaoUsarCorNegativo = False
              Color = clInfoBk
              AMascara = ' ,0.00;-,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object EEmbalagem: TEditLocaliza
              Left = 203
              Top = 131
              Width = 68
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
              ATexto = Label74
              ABotao = SpeedButton9
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select * from EMBALAGEM '
                'Where COD_EMBALAGEM = @')
              ASelectLocaliza.Strings = (
                'Select * from EMBALAGEM'
                'Where NOM_EMBALAGEM LIKE '#39'@%'#39
                'order by NOM_EMBALAGEM')
              APermitirVazio = True
              AInfo.CampoCodigo = 'COD_EMBALAGEM'
              AInfo.CampoNome = 'NOM_EMBALAGEM'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Descri'#231#227'o'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '  Localiza Embalagem  '
              AInfo.Cadastrar = True
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = EEmbalagemCadastrar
            end
            object ECodDesenvolvedor: TEditLocaliza
              Left = 203
              Top = 278
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = Label167
              ABotao = SpeedButton28
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'SELECT * FROM DESENVOLVEDOR'
                'WHERE CODDESENVOLVEDOR = @')
              ASelectLocaliza.Strings = (
                'SELECT * FROM DESENVOLVEDOR'
                'WHERE NOMDESENVOLVEDOR LIKE '#39'@%'#39)
              APermitirVazio = True
              AInfo.CampoCodigo = 'CODDESENVOLVEDOR'
              AInfo.CampoNome = 'NOMDESENVOLVEDOR'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Nome'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '  Localiza Desenvolvedor  '
              ADarFocoDepoisdoLocaliza = True
            end
            object EAcondicionamento: TEditLocaliza
              Left = 203
              Top = 157
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = Label77
              ABotao = SpeedButton10
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select * from ACONDICIONAMENTO'
                'Where CODACONDICIONAMENTO = @')
              ASelectLocaliza.Strings = (
                'Select * from ACONDICIONAMENTO'
                'Where NOMACONDICIONAMENTO LIKE '#39'@%'#39
                'order by NOMACONDICIONAMENTO')
              APermitirVazio = True
              AInfo.CampoCodigo = 'CODACONDICIONAMENTO'
              AInfo.CampoNome = 'NOMACONDICIONAMENTO'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Descri'#231#227'o'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '  Localiza Acondicionamento  '
              AInfo.Cadastrar = True
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = EAcondicionamentoCadastrar
            end
            object EPesoLiquido: Tnumerico
              Left = 203
              Top = 26
              Width = 94
              Height = 24
              ACampoObrigatorio = False
              ACorFoco = FPrincipal.CorFoco
              ANaoUsarCorNegativo = False
              Color = clInfoBk
              AMascara = ' ,0.00;-,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object EDatCadastro: TEditColor
              Left = 203
              Top = 1
              Width = 94
              Height = 24
              TabStop = False
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
            end
            object EMetCadarco: TEditColor
              Left = 203
              Top = 253
              Width = 94
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
              OnChange = ECodEmpresaChange
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EComposicao: TRBEditLocaliza
              Left = 203
              Top = 183
              Width = 68
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
              ATexto = Label96
              ABotao = SpeedButton13
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ASelectValida.Strings = (
                'Select CODCOMPOSICAO, NOMCOMPOSICAO '
                ' from COMPOSICAO '
                ' Where CODCOMPOSICAO = @')
              ASelectLocaliza.Strings = (
                'Select CODCOMPOSICAO, NOMCOMPOSICAO '
                ' from COMPOSICAO ')
              APermitirVazio = True
              AColunas = <
                item
                  ATituloColuna = 'C'#243'digo'
                  ATamanhoColuna = 8
                  ACampoFiltro = False
                  ANomeCampo = 'CODCOMPOSICAO'
                  AMostrarNaGrade = True
                  AOrdemInicial = False
                end
                item
                  ATituloColuna = 'Descri'#231#227'o'
                  ATamanhoColuna = 40
                  ACampoFiltro = True
                  ANomeCampo = 'NOMCOMPOSICAO'
                  AMostrarNaGrade = True
                  AOrdemInicial = True
                end>
              ALocalizaPadrao = lpComposicao
              ATituloFormulario = '   Localiza Composi'#231#227'o   '
              OnCadastrar = EComposicaoCadastrar
            end
            object ECapacidadeLiquida: Tnumerico
              Left = 203
              Top = 304
              Width = 94
              Height = 24
              ACampoObrigatorio = False
              ACorFoco = FPrincipal.CorFoco
              ANaoUsarCorNegativo = False
              Color = clInfoBk
              AMascara = ' ,0.00;-,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
            end
            object CMonitorarEstoque: TCheckBox
              Left = 204
              Top = 436
              Width = 191
              Height = 17
              Caption = 'Monitorar Estoque Produto'
              TabOrder = 15
            end
            object EMesesGarantia: TSpinEditColor
              Left = 203
              Top = 78
              Width = 46
              Height = 26
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxValue = 0
              MinValue = 0
              ParentFont = False
              TabOrder = 3
              Value = 0
              ACorFoco = FPrincipal.CorFoco
            end
            object CImprimeTabelaPreco: TCheckBox
              Left = 203
              Top = 383
              Width = 191
              Height = 17
              Caption = 'Imprimir na Tabela de Pre'#231'o'
              TabOrder = 12
            end
            object EAlturaProduto: TEditColor
              Left = 203
              Top = 209
              Width = 94
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
            end
            object CCracha: TCheckBox
              Left = 203
              Top = 400
              Width = 191
              Height = 17
              Caption = 'Crach'#225
              TabOrder = 13
            end
            object ERendimento: TMemoColor
              Left = 204
              Top = 474
              Width = 585
              Height = 53
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 16
              ACampoObrigatorio = False
              ACorFoco = FPrincipal.CorFoco
            end
            object CProdutoRetornavel: TCheckBox
              Left = 203
              Top = 418
              Width = 191
              Height = 17
              Caption = 'Produto Retorn'#225'vel'
              TabOrder = 14
            end
            object CAgruparBalancim: TCheckBox
              Left = 204
              Top = 235
              Width = 277
              Height = 17
              Caption = 'Permite agrupar enfesto no corte balancim'
              TabOrder = 17
            end
            object PanelColor17: TPanelColor
              Left = 203
              Top = 356
              Width = 326
              Height = 22
              BevelOuter = bvNone
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentBackground = False
              ParentFont = False
              TabOrder = 18
              AUsarCorForm = False
              ACorForm = FPrincipal.CorForm
              object CArredondamento: TRadioButton
                Left = 0
                Top = 1
                Width = 121
                Height = 17
                Caption = 'Arredondamento'
                TabOrder = 0
              end
              object CTruncamento: TRadioButton
                Left = 160
                Top = 1
                Width = 113
                Height = 17
                Caption = 'Truncamento'
                TabOrder = 1
              end
            end
            object ESituacaoTributaria: TComboBoxColor
              Left = 202
              Top = 330
              Width = 263
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 19
              OnChange = ECodEmpresaChange
              Items.Strings = (
                'ISENTO'
                'N'#195'O TRIBUTADO'
                'SUBSTITUI'#199#195'O TRIBUT'#193'RIA'
                'TRIBUTADO PELO ICMS')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object CRecalcularPreco: TCheckBox
              Left = 204
              Top = 454
              Width = 191
              Height = 17
              Caption = 'Recalcular Pre'#231'o'
              TabOrder = 20
            end
          end
        end
      end
      object PAco: TTabSheet
        Caption = 'A'#231'o'
        ImageIndex = 13
        object PanelColor14: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label113: TLabel
            Left = 24
            Top = 33
            Width = 258
            Height = 16
            Alignment = taRightJustify
            Caption = 'Densidade Volum'#233'trica de Massa (kg/mt3):'
          end
          object Label114: TLabel
            Left = 211
            Top = 63
            Width = 71
            Height = 16
            Alignment = taRightJustify
            Caption = 'Espessura :'
          end
          object Label115: TLabel
            Left = 410
            Top = 62
            Width = 22
            Height = 16
            Caption = 'mm'
          end
          object EDensidadeVolumetrica: Tnumerico
            Left = 286
            Top = 29
            Width = 118
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            ADecimal = 4
            AMascara = ' ,#,###,##0.0000;- ,0.0000'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object EEspessuraAco: Tnumerico
            Left = 286
            Top = 59
            Width = 118
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ' ,0.00;- ,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object PCopiadoras: TTabSheet
        Caption = 'Copiadora && Impressora'
        ImageIndex = 5
        object PanelColor10: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label62: TLabel
            Left = 78
            Top = 238
            Width = 121
            Height = 16
            Alignment = taRightJustify
            Caption = 'Qtd C'#243'pias Cilindro :'
          end
          object Label67: TLabel
            Left = 30
            Top = 264
            Width = 169
            Height = 16
            Alignment = taRightJustify
            Caption = 'Qtd C'#243'pias Toner Alta Cap. :'
          end
          object Label68: TLabel
            Left = 396
            Top = 264
            Width = 163
            Height = 16
            Alignment = taRightJustify
            Caption = 'C'#243'digo Cartucho Alta Cap. :'
          end
          object Label46: TLabel
            Left = 87
            Top = 212
            Width = 112
            Height = 16
            Alignment = taRightJustify
            Caption = 'Qtd C'#243'pias Toner :'
          end
          object Label60: TLabel
            Left = 453
            Top = 212
            Width = 106
            Height = 16
            Alignment = taRightJustify
            Caption = 'C'#243'digo Cartucho :'
          end
          object Label69: TLabel
            Left = 54
            Top = 290
            Width = 145
            Height = 16
            Alignment = taRightJustify
            Caption = 'Qtd P'#225'ginas por Minuto :'
          end
          object Label70: TLabel
            Left = 414
            Top = 290
            Width = 145
            Height = 16
            Alignment = taRightJustify
            Caption = 'Volume Mensal C'#243'pias :'
          end
          object Label71: TLabel
            Left = 92
            Top = 316
            Width = 107
            Height = 16
            Alignment = taRightJustify
            Caption = 'Data Fabrica'#231#227'o :'
          end
          object Label72: TLabel
            Left = 375
            Top = 316
            Width = 184
            Height = 16
            Alignment = taRightJustify
            Caption = 'Data Encerramento Produ'#231#227'o :'
          end
          object EQtdCopiasCilindro: TEditColor
            Left = 203
            Top = 234
            Width = 94
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
          end
          object EQtdCopiasTonerAltaCapacidade: TEditColor
            Left = 203
            Top = 260
            Width = 94
            Height = 24
            Color = clInfoBk
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
            AInteiro = 0
          end
          object EQtdPaginasPorMinuto: TEditColor
            Left = 203
            Top = 286
            Width = 94
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
          end
          object Panel5: TPanel
            Left = 88
            Top = 153
            Width = 617
            Height = 33
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 3
            object RTonerComCilindro: TRadioButton
              Left = 16
              Top = 6
              Width = 217
              Height = 17
              Caption = 'Toner com Cilindro (Combinado)'
              TabOrder = 0
            end
            object RTonerSemCilindro: TRadioButton
              Left = 240
              Top = 6
              Width = 217
              Height = 17
              Caption = 'Toner sem Cilindro'
              TabOrder = 1
            end
          end
          object Panel6: TPanel
            Left = 90
            Top = 11
            Width = 617
            Height = 33
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 4
            object CCopiadora: TCheckBox
              Left = 16
              Top = 6
              Width = 153
              Height = 17
              Caption = 'Copiadora'
              TabOrder = 0
            end
            object CMultiFuncional: TCheckBox
              Left = 240
              Top = 6
              Width = 153
              Height = 17
              Caption = 'Multi-Funcional'
              TabOrder = 1
            end
            object CImpressora: TCheckBox
              Left = 456
              Top = 6
              Width = 153
              Height = 17
              Caption = 'Impressora'
              TabOrder = 2
            end
          end
          object EQtdCopiasToner: TEditColor
            Left = 203
            Top = 208
            Width = 94
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
          end
          object Panel7: TPanel
            Left = 88
            Top = 352
            Width = 617
            Height = 57
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 6
            object CPlacaRede: TCheckBox
              Left = 16
              Top = 6
              Width = 153
              Height = 17
              Caption = 'Placa de Rede'
              TabOrder = 0
            end
            object CPcl: TCheckBox
              Left = 16
              Top = 30
              Width = 153
              Height = 17
              Caption = 'PCL'
              TabOrder = 1
            end
            object CFax: TCheckBox
              Left = 152
              Top = 6
              Width = 153
              Height = 17
              Caption = 'Fax'
              TabOrder = 2
            end
            object CUSB: TCheckBox
              Left = 152
              Top = 30
              Width = 153
              Height = 17
              Caption = 'USB'
              TabOrder = 3
            end
            object CScanner: TCheckBox
              Left = 288
              Top = 6
              Width = 153
              Height = 17
              Caption = 'Scanner'
              TabOrder = 4
            end
            object CWireless: TCheckBox
              Left = 288
              Top = 30
              Width = 153
              Height = 17
              Caption = 'Wireless'
              TabOrder = 5
            end
            object CDuplex: TCheckBox
              Left = 424
              Top = 6
              Width = 169
              Height = 17
              Caption = 'Duplex (Frente e Verso)'
              TabOrder = 6
            end
          end
          object EDatFabricacao: TMaskEditColor
            Left = 203
            Top = 312
            Width = 94
            Height = 24
            TabStop = False
            Color = clInfoBk
            EditMask = '!99\/99\/0000;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            Text = '  /  /    '
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object EDatEncerramentoProducao: TMaskEditColor
            Left = 563
            Top = 312
            Width = 94
            Height = 24
            TabStop = False
            Color = clInfoBk
            EditMask = '!99\/99\/0000;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Text = '  /  /    '
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object ECodCartucho: TEditColor
            Left = 563
            Top = 208
            Width = 94
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
          end
          object ECodCartuchoAltaCapacidade: TEditColor
            Left = 563
            Top = 260
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EVolumeMensalCopias: TEditColor
            Left = 563
            Top = 286
            Width = 94
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object Panel4: TPanel
            Left = 88
            Top = 118
            Width = 617
            Height = 33
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 12
            object RMonoComponente: TRadioButton
              Left = 16
              Top = 6
              Width = 201
              Height = 17
              Caption = 'Mono Componente'
              TabOrder = 0
            end
            object RBiComponente: TRadioButton
              Left = 240
              Top = 6
              Width = 201
              Height = 17
              Caption = 'Bi Componente (c/Revelador)'
              TabOrder = 1
            end
          end
          object Panel2: TPanel
            Left = 88
            Top = 48
            Width = 617
            Height = 33
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 13
            object RColorida: TRadioButton
              Left = 16
              Top = 6
              Width = 201
              Height = 17
              Caption = 'Colorida'
              TabOrder = 0
            end
            object RMonoCromatica: TRadioButton
              Left = 240
              Top = 6
              Width = 201
              Height = 17
              Caption = 'Mono-Crom'#225'tica'
              TabOrder = 1
            end
          end
          object Panel3: TPanel
            Left = 88
            Top = 83
            Width = 617
            Height = 33
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 14
            object RMatricial: TRadioButton
              Left = 16
              Top = 6
              Width = 201
              Height = 17
              Caption = 'Matricial'
              TabOrder = 0
            end
            object RJatoTinta: TRadioButton
              Left = 240
              Top = 6
              Width = 201
              Height = 17
              Caption = 'Jato de Tinta'
              TabOrder = 1
            end
            object RLaser: TRadioButton
              Left = 456
              Top = 6
              Width = 177
              Height = 17
              Caption = 'Laser'
              TabOrder = 2
            end
          end
        end
      end
      object PCartuchos: TTabSheet
        Caption = 'Cartuchos'
        ImageIndex = 6
        object PanelColor11: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          BevelOuter = bvNone
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label81: TLabel
            Left = 102
            Top = 82
            Width = 97
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade ML :'
          end
          object Label82: TLabel
            Left = 70
            Top = 108
            Width = 129
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade P'#225'ginas :'
          end
          object Label90: TLabel
            Left = 109
            Top = 164
            Width = 90
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo Cartucho :'
          end
          object Label78: TLabel
            Left = 88
            Top = 4
            Width = 111
            Height = 16
            Alignment = taRightJustify
            Caption = 'C'#243'digo Reduzido :'
          end
          object Label79: TLabel
            Left = 68
            Top = 30
            Width = 131
            Height = 16
            Alignment = taRightJustify
            Caption = 'Peso Cartucho Vazio :'
          end
          object Label80: TLabel
            Left = 67
            Top = 56
            Width = 132
            Height = 16
            Alignment = taRightJustify
            Caption = 'Peso Cartucho Cheio :'
          end
          object Label92: TLabel
            Left = 304
            Top = 134
            Width = 66
            Height = 16
            Caption = '                      '
          end
          object Label91: TLabel
            Left = 172
            Top = 134
            Width = 27
            Height = 16
            Alignment = taRightJustify
            Caption = 'Cor :'
          end
          object Label85: TLabel
            Left = 0
            Top = 276
            Width = 794
            Height = 16
            Align = alBottom
            Caption = 'Impressoras'
            ExplicitWidth = 75
          end
          object Label83: TLabel
            Left = 300
            Top = 30
            Width = 12
            Height = 16
            Alignment = taRightJustify
            Caption = 'gr'
          end
          object Label84: TLabel
            Left = 300
            Top = 56
            Width = 12
            Height = 16
            Alignment = taRightJustify
            Caption = 'gr'
          end
          object SpeedButton11: TSpeedButton
            Left = 273
            Top = 130
            Width = 24
            Height = 24
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
          object ECodCor: TEditLocaliza
            Left = 203
            Top = 130
            Width = 68
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
            ATexto = Label92
            ABotao = SpeedButton11
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from COR'
              'Where COD_COR = @')
            ASelectLocaliza.Strings = (
              'Select * from COR'
              'Where NOM_COR like '#39'@%'#39' '
              'order by NOM_COR')
            APermitirVazio = True
            AInfo.CampoCodigo = 'COD_COR'
            AInfo.CampoNome = 'NOM_COR'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Cor  '
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ECodCorCadastrar
          end
          object Panel8: TPanel
            Left = 203
            Top = 160
            Width = 374
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 6
            object RCartuchoTinta: TRadioButton
              Left = 0
              Top = 5
              Width = 145
              Height = 17
              Caption = 'Cartucho Tinta'
              TabOrder = 0
            end
            object RCartuchoTonner: TRadioButton
              Left = 174
              Top = 5
              Width = 145
              Height = 17
              Caption = 'Cartucho Toner'
              TabOrder = 1
            end
          end
          object CChipNovo: TCheckBox
            Left = 202
            Top = 193
            Width = 103
            Height = 17
            Caption = 'Chip Novo'
            TabOrder = 7
          end
          object EPesoCartuchoVazio: TEditColor
            Left = 203
            Top = 26
            Width = 94
            Height = 24
            Color = clInfoBk
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
            AInteiro = 0
          end
          object EPesoCartuchoCheio: TEditColor
            Left = 203
            Top = 52
            Width = 94
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
          end
          object EQtdPaginas: TEditColor
            Left = 203
            Top = 104
            Width = 94
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
          end
          object CProdutoCompativel: TCheckBox
            Left = 522
            Top = 193
            Width = 143
            Height = 17
            Caption = 'Produto Compat'#237'vel'
            TabOrder = 11
          end
          object GImpressoras: TRBStringGridColor
            Left = 0
            Top = 292
            Width = 794
            Height = 189
            Align = alBottom
            Color = clInfoBk
            ColCount = 3
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
            TabOrder = 12
            OnKeyDown = GImpressorasKeyDown
            OnSelectCell = GImpressorasSelectCell
            ACorFoco = FPrincipal.CorFoco
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GImpressorasDadosValidos
            OnMudouLinha = GImpressorasMudouLinha
            OnNovaLinha = GImpressorasNovaLinha
            OnCarregaItemGrade = GImpressorasCarregaItemGrade
            ColWidths = (
              19
              91
              566)
          end
          object EQtdML: TEditColor
            Left = 203
            Top = 78
            Width = 94
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
          end
          object CCilindroNovo: TCheckBox
            Left = 202
            Top = 210
            Width = 103
            Height = 17
            Caption = 'Cilindro Novo'
            TabOrder = 8
          end
          object CProdutoOriginal: TCheckBox
            Left = 378
            Top = 193
            Width = 119
            Height = 17
            Caption = 'Produto Original'
            TabOrder = 9
          end
          object CCartuchoTexto: TCheckBox
            Left = 378
            Top = 210
            Width = 119
            Height = 17
            Caption = 'Cartucho Texto'
            TabOrder = 10
          end
          object ECodigoReduzido: TEditColor
            Left = 203
            Top = 0
            Width = 94
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
          end
        end
      end
      object PEstagios: TTabSheet
        Caption = 'Est'#225'gios'
        ImageIndex = 7
        object GEstagios: TRBStringGridColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clInfoBk
          ColCount = 10
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
          TabOrder = 0
          OnGetEditMask = GEstagiosGetEditMask
          OnKeyDown = GEstagiosKeyDown
          OnKeyPress = GEstagiosKeyPress
          OnSelectCell = GEstagiosSelectCell
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnDadosValidos = GEstagiosDadosValidos
          OnMudouLinha = GEstagiosMudouLinha
          OnNovaLinha = GEstagiosNovaLinha
          OnDepoisExclusao = GEstagiosDepoisExclusao
          OnCarregaItemGrade = GEstagiosCarregaItemGrade
          ColWidths = (
            19
            57
            60
            155
            189
            103
            103
            117
            58
            58)
        end
        object EEstagio: TEditLocaliza
          Left = 8
          Top = 367
          Width = 89
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from ESTAGIOPRODUCAO'
            'Where CODEST = @')
          ASelectLocaliza.Strings = (
            'Select * from ESTAGIOPRODUCAO'
            'Where NOMEST LIKE '#39'@%'#39)
          APermitirVazio = True
          AInfo.CampoCodigo = 'CODEST'
          AInfo.CampoNome = 'NOMEST'
          AInfo.Nome1 = 'Codigo'
          AInfo.Nome2 = 'Descri'#231#227'o'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Estagio   '
          AInfo.Cadastrar = True
          AInfo.RetornoExtra1 = 'NOMEST'
          ADarFocoDepoisdoLocaliza = False
          OnCadastrar = EEstagioCadastrar
          OnRetorno = EEstagioRetorno
        end
      end
      object PFornecedores: TTabSheet
        Caption = 'Fornecedores'
        ImageIndex = 8
        object GFornecedores: TRBStringGridColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clInfoBk
          ColCount = 11
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
          TabOrder = 0
          OnGetEditMask = GFornecedoresGetEditMask
          OnKeyDown = GFornecedoresKeyDown
          OnKeyPress = GFornecedoresKeyPress
          OnSelectCell = GFornecedoresSelectCell
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnDadosValidos = GFornecedoresDadosValidos
          OnMudouLinha = GFornecedoresMudouLinha
          OnNovaLinha = GFornecedoresNovaLinha
          OnCarregaItemGrade = GFornecedoresCarregaItemGrade
          ColWidths = (
            19
            58
            172
            67
            201
            137
            118
            107
            101
            127
            64)
        end
        object EFornecedor: TEditLocaliza
          Left = 8
          Top = 341
          Width = 89
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'SELECT * FROM CADCLIENTES'
            'WHERE I_COD_CLI = @'
            'and c_ind_for = '#39'S'#39)
          ASelectLocaliza.Strings = (
            'SELECT * FROM CADCLIENTES'
            'WHERE C_NOM_CLI LIKE '#39'@%'#39' AND'
            'c_ind_for = '#39'S'#39)
          APermitirVazio = True
          AInfo.CampoCodigo = 'I_COD_CLI'
          AInfo.CampoNome = 'C_NOM_CLI'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '  Localiza Fornecedor  '
          AInfo.RetornoExtra1 = 'I_COD_CLI'
          AInfo.RetornoExtra2 = 'C_NOM_CLI'
          ADarFocoDepoisdoLocaliza = False
          OnRetorno = EFornecedorRetorno
        end
        object ECor: TEditLocaliza
          Left = 8
          Top = 367
          Width = 89
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Visible = False
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from COR'
            'Where COD_COR = @')
          ASelectLocaliza.Strings = (
            'Select * from COR'
            'Where NOM_COR like '#39'@%'#39
            'order by NOM_COR')
          APermitirVazio = True
          AInfo.CampoCodigo = 'COD_COR'
          AInfo.CampoNome = 'NOM_COR'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Descri'#231#227'o'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '  Localiza Cor  '
          AInfo.Cadastrar = True
          AInfo.RetornoExtra1 = 'COD_COR'
          AInfo.RetornoExtra2 = 'NOM_COR'
          ADarFocoDepoisdoLocaliza = False
          OnCadastrar = ECorCadastrar
          OnRetorno = ECorRetorno
        end
      end
      object PAcessorios: TTabSheet
        Caption = 'Acess'#243'rios'
        ImageIndex = 9
        object GAcessorios: TRBStringGridColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clInfoBk
          ColCount = 3
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
          TabOrder = 0
          OnGetEditMask = GAcessoriosGetEditMask
          OnKeyDown = GAcessoriosKeyDown
          OnRowMoved = GAcessoriosRowMoved
          OnSelectCell = GAcessoriosSelectCell
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnDadosValidos = GAcessoriosDadosValidos
          OnMudouLinha = GAcessoriosMudouLinha
          OnNovaLinha = GAcessoriosNovaLinha
          OnCarregaItemGrade = GAcessoriosCarregaItemGrade
          ColWidths = (
            19
            74
            399)
        end
        object EAcessorio: TRBEditLocaliza
          Left = 240
          Top = 152
          Width = 57
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ASelectValida.Strings = (
            'Select CODACESSORIO, NOMACESSORIO '
            ' from ACESSORIO '
            ' Where CODACESSORIO = @')
          ASelectLocaliza.Strings = (
            'Select CODACESSORIO, NOMACESSORIO '
            ' from ACESSORIO ')
          APermitirVazio = False
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'CODACESSORIO'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Descri'#231#227'o'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'NOMACESSORIO'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end>
          ALocalizaPadrao = lpAcessorio
          ATituloFormulario = '   Localiza Acess'#243'rio   '
          OnCadastrar = EAcessorioCadastrar
          OnRetorno = EAcessorioRetorno
        end
      end
      object PTabelaPreco: TTabSheet
        Caption = 'Pre'#231'os'
        ImageIndex = 10
        object GPreco: TRBStringGridColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clInfoBk
          ColCount = 19
          DefaultRowHeight = 20
          DrawingStyle = gdsClassic
          FixedColor = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
          ParentFont = False
          TabOrder = 0
          OnGetEditMask = GPrecoGetEditMask
          OnKeyDown = GPrecoKeyDown
          OnSelectCell = GPrecoSelectCell
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnDadosValidos = GPrecoDadosValidos
          OnMudouLinha = GPrecoMudouLinha
          OnNovaLinha = GPrecoNovaLinha
          onAntesExclusao = GPrecoAntesExclusao
          OnCarregaItemGrade = GPrecoCarregaItemGrade
          ColWidths = (
            10
            69
            191
            108
            116
            116
            106
            88
            63
            158
            54
            145
            67
            218
            64
            170
            86
            82
            185)
        end
        object ETabelaPreco: TRBEditLocaliza
          Left = 41
          Top = 152
          Width = 57
          Height = 24
          Color = 11661566
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select I_COD_TAB, C_NOM_TAB '
            ' from CADTABELAPRECO '
            ' Where I_COD_EMP = 0 and I_COD_TAB = @')
          ASelectLocaliza.Strings = (
            'Select I_COD_TAB, C_NOM_TAB '
            ' from CADTABELAPRECO '
            ' Where I_COD_EMP = 0')
          APermitirVazio = False
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'I_COD_TAB'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Nome'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'C_NOM_TAB'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end>
          ALocalizaPadrao = lpPersonalizado
          ATituloFormulario = '   Localiza Tabela Pre'#231'o   '
          OnSelect = ETabelaPrecoSelect
          OnRetorno = ETabelaPrecoRetorno
        end
        object ETamanho: TRBEditLocaliza
          Left = 104
          Top = 152
          Width = 57
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Visible = False
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select CODTAMANHO, NOMTAMANHO '
            ' from TAMANHO '
            ' Where CODTAMANHO = @')
          ASelectLocaliza.Strings = (
            'Select CODTAMANHO, NOMTAMANHO '
            ' from TAMANHO ')
          APermitirVazio = True
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'CODTAMANHO'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Descri'#231#227'o'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'NOMTAMANHO'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end>
          ALocalizaPadrao = lpTamanho
          ATituloFormulario = '   Localiza Tamanho   '
          OnRetorno = ETamanhoRetorno
        end
        object ECliPreco: TRBEditLocaliza
          Left = 167
          Top = 152
          Width = 57
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Visible = False
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select I_COD_CLI, C_NOM_CLI, C_NOM_FAN, C_CID_CLI '
            ' from CADCLIENTES '
            ' Where I_COD_CLI = @ and C_IND_CLI = '#39'S'#39)
          ASelectLocaliza.Strings = (
            'Select I_COD_CLI, C_NOM_CLI, C_NOM_FAN, C_CID_CLI '
            ' from CADCLIENTES  Where C_IND_CLI = '#39'S'#39)
          APermitirVazio = True
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'I_COD_CLI'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Razao Social'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'C_NOM_CLI'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end
            item
              ATituloColuna = 'Nome Fantasia'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'C_NOM_FAN'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Cidade'
              ATamanhoColuna = 20
              ACampoFiltro = True
              ANomeCampo = 'C_CID_CLI'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end>
          ALocalizaPadrao = lpCliente
          ATituloFormulario = '   Localiza Cliente   '
          OnRetorno = ECliPrecoRetorno
        end
        object EMoeda: TRBEditLocaliza
          Left = 230
          Top = 152
          Width = 57
          Height = 24
          Color = 11661566
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Visible = False
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select I_COD_MOE, C_NOM_MOE, C_CIF_MOE '
            ' from CADMOEDAS '
            ' Where I_COD_MOE = @')
          ASelectLocaliza.Strings = (
            'Select I_COD_MOE, C_NOM_MOE,C_CIF_MOE '
            ' from CADMOEDAS ')
          APermitirVazio = True
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'I_COD_MOE'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Descri'#231#227'o'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'C_NOM_MOE'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end
            item
              ATituloColuna = 'Cifr'#227'o'
              ATamanhoColuna = 6
              ACampoFiltro = False
              ANomeCampo = 'C_CIF_MOE'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end>
          ALocalizaPadrao = lpMoeda
          ATituloFormulario = '   Localiza Moeda   '
          OnRetorno = EMoedaRetorno
        end
        object ECorPreco: TRBEditLocaliza
          Left = 293
          Top = 152
          Width = 57
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          Visible = False
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select COD_COR, NOM_COR '
            ' from COR '
            ' Where COD_COR = @')
          ASelectLocaliza.Strings = (
            'Select COD_COR, NOM_COR'
            ' from COR ')
          APermitirVazio = True
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'COD_COR'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Descri'#231#227'o'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'NOM_COR'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end>
          ALocalizaPadrao = lpCor
          ATituloFormulario = '   Localiza Cor '
          OnRetorno = ECorPrecoRetorno
        end
      end
      object PInstalacaoTear: TTabSheet
        Caption = 'Instala'#231#227'o Tear'
        ImageIndex = 11
        object Splitter1: TSplitter
          Left = 584
          Top = 121
          Width = 7
          Height = 299
          Align = alRight
          ExplicitLeft = 636
          ExplicitTop = 32
          ExplicitHeight = 360
        end
        object PanelColor4: TPanelColor
          Left = 0
          Top = 121
          Width = 33
          Height = 299
          Align = alLeft
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
          object BRepeticaoDesenho: TSpeedButton
            Left = 1
            Top = 161
            Width = 31
            Height = 32
            Align = alTop
            GroupIndex = 1
            Caption = 'X'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = BRepeticaoDesenhoClick
            ExplicitLeft = 4
            ExplicitTop = 129
          end
          object BZoomMenos: TSpeedButton
            Left = 1
            Top = 97
            Width = 31
            Height = 32
            Align = alTop
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33033333333333333F7F3333333333333000333333333333F777333333333333
              000333333333333F777333333333333000333333333333F77733333333333300
              033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
              333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
              333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078999998703
              33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
              333337F3333337F333333078F8F870333333373FF333F7333333330777770333
              333333773FF77333333333370007333333333333777333333333}
            NumGlyphs = 2
            OnClick = BZoomMenosClick
            ExplicitTop = 1
          end
          object BCursor: TSpeedButton
            Left = 1
            Top = 1
            Width = 31
            Height = 32
            Align = alTop
            GroupIndex = 1
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              333333333333333FFF3333333333333707333333333333F777F3333333333370
              9033333333F33F7737F33333373337090733333337F3F7737733333330037090
              73333333377F7737733333333090090733333333373773773333333309999073
              333333337F333773333333330999903333333333733337F33333333099999903
              33333337F3333F7FF33333309999900733333337333FF7773333330999900333
              3333337F3FF7733333333309900333333333337FF77333333333309003333333
              333337F773333333333330033333333333333773333333333333333333333333
              3333333333333333333333333333333333333333333333333333}
            NumGlyphs = 2
            OnClick = BCursorClick
          end
          object BZoomMais: TSpeedButton
            Left = 1
            Top = 65
            Width = 31
            Height = 32
            Align = alTop
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33033333333333333F7F3333333333333000333333333333F777333333333333
              000333333333333F777333333333333000333333333333F77733333333333300
              033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
              33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
              3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
              33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
              333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
              333333773FF77333333333370007333333333333777333333333}
            NumGlyphs = 2
            OnClick = BZoomMaisClick
            ExplicitTop = 1
          end
          object BNovo: TSpeedButton
            Left = 1
            Top = 129
            Width = 31
            Height = 32
            Align = alTop
            GroupIndex = 1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
              333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
              0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
              0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
              33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
              B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
              3BB33773333773333773B333333B3333333B7333333733333337}
            NumGlyphs = 2
            ParentFont = False
            OnClick = BNovoClick
            ExplicitLeft = -4
            ExplicitTop = 121
          end
          object BExcluir: TSpeedButton
            Left = 1
            Top = 33
            Width = 31
            Height = 32
            Align = alTop
            GroupIndex = 1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
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
            ParentFont = False
            OnClick = BExcluirClick
            ExplicitLeft = 4
            ExplicitTop = 27
          end
        end
        object PanelColor3: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 121
          Align = alTop
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label97: TLabel
            Left = 19
            Top = 19
            Width = 82
            Height = 16
            Caption = 'Qtd Quadros :'
          end
          object Label98: TLabel
            Left = 19
            Top = 51
            Width = 79
            Height = 16
            Caption = 'Qtd Colunas :'
          end
          object Label8: TLabel
            Left = 29
            Top = 83
            Width = 69
            Height = 16
            Caption = 'Qtd Linhas :'
          end
          object EQtdQuadros: TSpinEditColor
            Left = 104
            Top = 14
            Width = 49
            Height = 26
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxValue = 0
            MinValue = 0
            ParentFont = False
            TabOrder = 0
            Value = 0
            OnExit = EQtdQuadrosExit
            ACorFoco = FPrincipal.CorFoco
          end
          object EQtdColInstalacao: TSpinEditColor
            Left = 104
            Top = 46
            Width = 49
            Height = 26
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxValue = 0
            MinValue = 0
            ParentFont = False
            TabOrder = 1
            Value = 1
            OnExit = EQtdColInstalacaoExit
            ACorFoco = FPrincipal.CorFoco
          end
          object EQtdLinInstalacao: TSpinEditColor
            Left = 104
            Top = 78
            Width = 49
            Height = 26
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxValue = 0
            MinValue = 0
            ParentFont = False
            TabOrder = 2
            Value = 0
            OnExit = EQtdLinInstalacaoExit
            ACorFoco = FPrincipal.CorFoco
          end
          object GCombinacaoCadarco: TRBStringGridColor
            Left = 159
            Top = 3
            Width = 650
            Height = 112
            Color = clInfoBk
            ColCount = 10
            DefaultRowHeight = 20
            DrawingStyle = gdsClassic
            FixedColor = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
            ParentFont = False
            TabOrder = 3
            OnGetEditMask = GCombinacaoCadarcoGetEditMask
            OnKeyDown = GCombinacaoCadarcoKeyDown
            OnSelectCell = GCombinacaoCadarcoSelectCell
            ACorFoco = FPrincipal.CorFoco
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GCombinacaoCadarcoDadosValidos
            OnMudouLinha = GCombinacaoCadarcoMudouLinha
            OnNovaLinha = GCombinacaoCadarcoNovaLinha
            OnCarregaItemGrade = GCombinacaoCadarcoCarregaItemGrade
            ColWidths = (
              7
              89
              64
              228
              65
              172
              75
              239
              64
              265)
          end
          object ECorFioTrama: TRBEditLocaliza
            Left = 328
            Top = 48
            Width = 57
            Height = 24
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Visible = False
            ACampoObrigatorio = True
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ASelectValida.Strings = (
              'Select COD_COR, NOM_COR '
              ' from COR '
              ' Where COD_COR = @')
            ASelectLocaliza.Strings = (
              'Select COD_COR, NOM_COR'
              ' from COR ')
            APermitirVazio = True
            AColunas = <
              item
                ATituloColuna = 'C'#243'digo'
                ATamanhoColuna = 8
                ACampoFiltro = False
                ANomeCampo = 'COD_COR'
                AMostrarNaGrade = True
                AOrdemInicial = False
              end
              item
                ATituloColuna = 'Descri'#231#227'o'
                ATamanhoColuna = 40
                ACampoFiltro = True
                ANomeCampo = 'NOM_COR'
                AMostrarNaGrade = True
                AOrdemInicial = True
              end>
            ALocalizaPadrao = lpCor
            ATituloFormulario = '   Localiza Cor '
            OnRetorno = ECorFioTramaRetorno
          end
          object ECorFioAjuda: TRBEditLocaliza
            Left = 408
            Top = 51
            Width = 57
            Height = 24
            Color = 11661566
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            Visible = False
            ACampoObrigatorio = True
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ASelectValida.Strings = (
              'Select COD_COR, NOM_COR '
              ' from COR '
              ' Where COD_COR = @')
            ASelectLocaliza.Strings = (
              'Select COD_COR, NOM_COR'
              ' from COR ')
            APermitirVazio = True
            AColunas = <
              item
                ATituloColuna = 'C'#243'digo'
                ATamanhoColuna = 8
                ACampoFiltro = False
                ANomeCampo = 'COD_COR'
                AMostrarNaGrade = True
                AOrdemInicial = False
              end
              item
                ATituloColuna = 'Descri'#231#227'o'
                ATamanhoColuna = 40
                ACampoFiltro = True
                ANomeCampo = 'NOM_COR'
                AMostrarNaGrade = True
                AOrdemInicial = True
              end>
            ALocalizaPadrao = lpCor
            ATituloFormulario = '   Localiza Cor '
            OnRetorno = ECorFioAjudaRetorno
          end
        end
        object GInstalacao: TRBStringGridColor
          Left = 33
          Top = 121
          Width = 551
          Height = 299
          Align = alClient
          Color = clInfoBk
          DrawingStyle = gdsClassic
          FixedColor = clSilver
          FixedCols = 0
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
          ParentFont = False
          TabOrder = 1
          OnClick = GInstalacaoClick
          OnMouseDown = GInstalacaoMouseDown
          OnMouseUp = GInstalacaoMouseUp
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnGetCellColor = GInstalacaoGetCellColor
          ColWidths = (
            23
            19
            18
            17
            17)
        end
        object PanelColor5: TPanelColor
          Left = 0
          Top = 420
          Width = 794
          Height = 61
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
          object SpeedButton14: TSpeedButton
            Left = 152
            Top = 1
            Width = 27
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
          object LProdutoInstalacao: TLabel
            Left = 21
            Top = 6
            Width = 53
            Height = 16
            Alignment = taRightJustify
            Caption = 'Produto :'
          end
          object LNomProdutoInstalacao: TLabel
            Left = 184
            Top = 6
            Width = 57
            Height = 16
            Caption = '                   '
          end
          object LNomCorInstalacao: TLabel
            Left = 184
            Top = 33
            Width = 57
            Height = 16
            Caption = '                   '
          end
          object LCorInstalacao: TLabel
            Left = 47
            Top = 33
            Width = 27
            Height = 16
            Alignment = taRightJustify
            Caption = 'Cor :'
          end
          object SpeedButton15: TSpeedButton
            Left = 151
            Top = 28
            Width = 27
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
          object LQtdFiosLico: TLabel
            Left = 534
            Top = 6
            Width = 102
            Height = 16
            Alignment = taRightJustify
            Caption = 'Qtd Fios no Li'#231'o :'
          end
          object LFuncaoFio: TLabel
            Left = 563
            Top = 32
            Width = 73
            Height = 16
            Alignment = taRightJustify
            Caption = 'Fun'#231#227'o Fio :'
          end
          object EProdutoInstalacao: TRBEditLocaliza
            Left = 80
            Top = 2
            Width = 73
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
            ATexto = LNomProdutoInstalacao
            ABotao = SpeedButton14
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ASelectValida.Strings = (
              'Select C_COD_PRO, C_NOM_PRO, I_SEQ_PRO '
              ' from CADPRODUTOS '
              ' Where C_COD_PRO = '#39'@'#39)
            ASelectLocaliza.Strings = (
              'Select C_COD_PRO, C_NOM_PRO, I_SEQ_PRO '
              ' from CADPRODUTOS ')
            APermitirVazio = True
            AColunas = <
              item
                ATituloColuna = 'C'#243'digo'
                ATamanhoColuna = 15
                ACampoFiltro = False
                ANomeCampo = 'C_COD_PRO'
                AMostrarNaGrade = True
                AOrdemInicial = False
              end
              item
                ATituloColuna = 'Nome'
                ATamanhoColuna = 40
                ACampoFiltro = True
                ANomeCampo = 'C_NOM_PRO'
                AMostrarNaGrade = True
                AOrdemInicial = True
              end
              item
                ATituloColuna = 'SeqProduto'
                ATamanhoColuna = 40
                ACampoFiltro = False
                ANomeCampo = 'I_SEQ_PRO'
                AMostrarNaGrade = False
                AOrdemInicial = False
              end>
            ALocalizaPadrao = lpProduto
            ATituloFormulario = '   Localiza Produto '
            OnRetorno = EProdutoInstalacaoRetorno
          end
          object ECorInstalacao: TRBEditLocaliza
            Left = 80
            Top = 29
            Width = 73
            Height = 24
            Color = clInfoBk
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
            AInteiro = 0
            ATexto = LNomCorInstalacao
            ABotao = SpeedButton15
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ASelectValida.Strings = (
              'Select COD_COR, NOM_COR '
              ' from COR '
              ' Where COD_COR = @')
            ASelectLocaliza.Strings = (
              'Select COD_COR, NOM_COR'
              ' from COR ')
            APermitirVazio = True
            AColunas = <
              item
                ATituloColuna = 'C'#243'digo'
                ATamanhoColuna = 8
                ACampoFiltro = False
                ANomeCampo = 'COD_COR'
                AMostrarNaGrade = True
                AOrdemInicial = False
              end
              item
                ATituloColuna = 'Descri'#231#227'o'
                ATamanhoColuna = 40
                ACampoFiltro = True
                ANomeCampo = 'NOM_COR'
                AMostrarNaGrade = True
                AOrdemInicial = True
              end>
            ALocalizaPadrao = lpCor
            ATituloFormulario = '   Localiza Cor '
          end
          object EQtdFiosLico: Tnumerico
            Left = 642
            Top = 2
            Width = 45
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            AMascara = ',0;- ,0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object EFuncaoFio: TComboBoxColor
            Left = 642
            Top = 28
            Width = 111
            Height = 24
            Style = csDropDownList
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Items.Strings = (
              'Urdume'
              'Ajuda'
              'Amarra'#231#227'o')
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
        end
        object GDPC: TRBStringGridColor
          Left = 591
          Top = 121
          Width = 203
          Height = 299
          Align = alRight
          Color = clInfoBk
          DrawingStyle = gdsClassic
          FixedColor = clSilver
          FixedCols = 0
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
          ParentFont = False
          TabOrder = 4
          OnClick = GDPCClick
          OnMouseDown = GInstalacaoMouseDown
          OnMouseUp = GInstalacaoMouseUp
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnGetCellColor = GDPCGetCellColor
          ColWidths = (
            23
            19
            18
            17
            17)
        end
      end
      object PDetectoresMetal: TTabSheet
        Caption = 'Detectores de Metal'
        ImageIndex = 14
        object PanelColor15: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          OnClick = PanelColor15Click
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Bevel4: TBevel
            Left = 0
            Top = 15
            Width = 769
            Height = 2
          end
          object Label184: TLabel
            Left = 8
            Top = -1
            Width = 154
            Height = 16
            Caption = 'Informa'#231#245'es T'#233'cnicas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label119: TLabel
            Left = 46
            Top = 25
            Width = 111
            Height = 16
            Caption = 'Consumo El'#233'trico :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label120: TLabel
            Left = 7
            Top = 51
            Width = 150
            Height = 16
            Caption = 'Tens'#227'o de Alimenta'#231#227'o :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label121: TLabel
            Left = 45
            Top = 77
            Width = 112
            Height = 16
            Caption = 'Grau de Prote'#231#227'o :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label122: TLabel
            Left = 394
            Top = 25
            Width = 127
            Height = 16
            Caption = 'Abertura da Cabe'#231'a :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label123: TLabel
            Left = 372
            Top = 51
            Width = 149
            Height = 16
            Caption = 'Comunica'#231#227'o Via Rede :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label124: TLabel
            Left = 8
            Top = 97
            Width = 97
            Height = 16
            Caption = 'Sensibilidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Bevel1: TBevel
            Left = 0
            Top = 113
            Width = 769
            Height = 2
          end
          object Bevel2: TBevel
            Left = 0
            Top = 220
            Width = 769
            Height = 2
          end
          object Label125: TLabel
            Left = 8
            Top = 204
            Width = 204
            Height = 16
            Caption = 'Descritivo da Funcionalidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Bevel3: TBevel
            Left = 2
            Top = 326
            Width = 769
            Height = 2
          end
          object LInfomDisplayDetectoresMetais: TLabel
            Left = 8
            Top = 307
            Width = 522
            Height = 16
            Caption = 
              'Informa'#231#245'es dispon'#237'veis no Display do Equipamento ou via Rede MO' +
              'DBUS'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label126: TLabel
            Left = 102
            Top = 121
            Width = 60
            Height = 16
            Alignment = taRightJustify
            Caption = 'Ferrosos :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label127: TLabel
            Left = 68
            Top = 149
            Width = 89
            Height = 16
            Alignment = taRightJustify
            Caption = 'N'#227'o Ferrosos :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label128: TLabel
            Left = 63
            Top = 175
            Width = 94
            Height = 16
            Alignment = taRightJustify
            Caption = 'A'#231'o Inoxid'#225'vel :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object EConsumoEletrico: TEditColor
            Left = 168
            Top = 22
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 0
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ETensaoAlimentacao: TEditColor
            Left = 168
            Top = 47
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 1
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EGrauProtecao: TEditColor
            Left = 168
            Top = 73
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 2
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EAberturaCabeca: TEditColor
            Left = 528
            Top = 21
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 3
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EComunicacaoRede: TEditColor
            Left = 528
            Top = 47
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 4
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EDescritivoFuncDetectoresMetal: TMemoColor
            Left = 8
            Top = 226
            Width = 585
            Height = 76
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 2000
            ParentFont = False
            TabOrder = 8
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object ESensibilidadeFerrosos: TEditColor
            Left = 168
            Top = 119
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 5
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ESensibilidadeNaoFerrosos: TEditColor
            Left = 168
            Top = 145
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 6
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EAcoInoxidavel: TEditColor
            Left = 168
            Top = 171
            Width = 177
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 7
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EInfDisplayDetectoresMetal: TMemoColor
            Left = 7
            Top = 334
            Width = 585
            Height = 76
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 2000
            ParentFont = False
            TabOrder = 9
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
        end
      end
      object POrcamentoCadarco: TTabSheet
        Caption = 'Or'#231'amento Cadar'#231'o'
        ImageIndex = 15
        object PanelColor16: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label31: TLabel
            Left = 61
            Top = 11
            Width = 84
            Height = 16
            Caption = 'Tipo Produto :'
          end
          object Label101: TLabel
            Left = 20
            Top = 39
            Width = 125
            Height = 16
            Caption = 'Quantidade Batidas :'
          end
          object Label104: TLabel
            Left = 389
            Top = 432
            Width = 87
            Height = 16
            Caption = 'Valor Unitario :'
          end
          object Label105: TLabel
            Left = 473
            Top = 39
            Width = 102
            Height = 16
            Alignment = taRightJustify
            Caption = 'Largura Produto :'
          end
          object ETipoCadarco: TComboBoxColor
            Left = 151
            Top = 8
            Width = 161
            Height = 24
            Style = csDropDownList
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = ETipoCadarcoChange
            Items.Strings = (
              'Convencional'
              'Croch'#234
              'Renda'
              'Elastico')
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
          object EQtdBatidasOrcamentoCadarco: Tnumerico
            Left = 151
            Top = 35
            Width = 50
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
            TabOrder = 1
            OnChange = ETipoCadarcoChange
          end
          object GFioOrcamentoCadarco: TRBStringGridColor
            Left = 20
            Top = 61
            Width = 621
            Height = 361
            Color = clInfoBk
            ColCount = 4
            DefaultRowHeight = 20
            DrawingStyle = gdsClassic
            FixedColor = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
            ParentFont = False
            TabOrder = 2
            OnKeyDown = GFioOrcamentoCadarcoKeyDown
            OnKeyPress = GFioOrcamentoCadarcoKeyPress
            ACorFoco = FPrincipal.CorFoco
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APrimeiraColunaCheckBox = True
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GFioOrcamentoCadarcoDadosValidos
            OnMudouLinha = GFioOrcamentoCadarcoMudouLinha
            OnCarregaItemGrade = GFioOrcamentoCadarcoCarregaItemGrade
            onCellClick = GFioOrcamentoCadarcoCellClick
            ColWidths = (
              12
              25
              536
              83)
          end
          object EValUnitarioOrcamentoCadarco: Tnumerico
            Left = 520
            Top = 428
            Width = 121
            Height = 24
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
            ANaoUsarCorNegativo = False
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ELarguraOrcamentoCadarco: Tnumerico
            Left = 581
            Top = 35
            Width = 60
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
            TabOrder = 4
            OnChange = ETipoCadarcoChange
          end
        end
      end
      object PEmbalagemPvc: TTabSheet
        Caption = 'Embalagem PVC'
        ImageIndex = 16
        object SPVC: TScrollBox
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          TabOrder = 0
          object PPVC: TPanelColor
            Left = 0
            Top = 0
            Width = 773
            Height = 481
            Align = alTop
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            AUsarCorForm = False
            ACorForm = FPrincipal.CorForm
            object LTipoEmb: TLabel
              Left = 20
              Top = 8
              Width = 68
              Height = 16
              Caption = 'Tipo Emb. :'
            end
            object Label106: TLabel
              Left = 34
              Top = 32
              Width = 54
              Height = 16
              Caption = 'Plastico :'
            end
            object SpeedButton16: TSpeedButton
              Left = 164
              Top = 30
              Width = 24
              Height = 24
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
            object Label118: TLabel
              Left = 395
              Top = 32
              Width = 61
              Height = 16
              Caption = 'Plastico2 :'
            end
            object SpeedButton18: TSpeedButton
              Left = 529
              Top = 28
              Width = 24
              Height = 24
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
            object Label129: TLabel
              Left = 34
              Top = 87
              Width = 52
              Height = 16
              Caption = 'Largura :'
            end
            object Label130: TLabel
              Left = 166
              Top = 87
              Width = 40
              Height = 16
              Caption = 'Altura :'
            end
            object Label131: TLabel
              Left = 283
              Top = 87
              Width = 44
              Height = 16
              Caption = 'Fundo :'
            end
            object Label132: TLabel
              Left = 406
              Top = 87
              Width = 31
              Height = 16
              Caption = 'Aba :'
            end
            object Label133: TLabel
              Left = 53
              Top = 112
              Width = 33
              Height = 16
              Caption = 'Al'#231'a :'
            end
            object Label134: TLabel
              Left = 323
              Top = 112
              Width = 39
              Height = 16
              Caption = 'Local :'
            end
            object LLaminaZiper: TLabel
              Left = 4
              Top = 166
              Width = 84
              Height = 16
              Caption = 'Lamina Ziper :'
            end
            object LPlastico: TLabel
              Left = 194
              Top = 34
              Width = 66
              Height = 16
              Caption = '                      '
            end
            object LLaminaAba: TLabel
              Left = 185
              Top = 166
              Width = 78
              Height = 16
              Caption = 'Lamina Aba :'
            end
            object LInterno1: TLabel
              Left = 30
              Top = 218
              Width = 56
              Height = 16
              Caption = 'Interno 1 :'
              Visible = False
            end
            object LInterno2: TLabel
              Left = 170
              Top = 218
              Width = 56
              Height = 16
              Caption = 'Interno 2 :'
              Visible = False
            end
            object Label141: TLabel
              Left = 16
              Top = 244
              Width = 70
              Height = 16
              Caption = 'Impress'#227'o :'
            end
            object Label142: TLabel
              Left = 184
              Top = 244
              Width = 42
              Height = 16
              Caption = 'Cores :'
            end
            object Label143: TLabel
              Left = 36
              Top = 298
              Width = 50
              Height = 16
              Caption = 'Cabide :'
            end
            object Label144: TLabel
              Left = 44
              Top = 327
              Width = 42
              Height = 16
              Caption = 'Bot'#227'o :'
            end
            object LcorBotao: TLabel
              Left = 186
              Top = 327
              Width = 27
              Height = 16
              Caption = 'Cor :'
              Visible = False
            end
            object Label146: TLabel
              Left = 42
              Top = 354
              Width = 44
              Height = 16
              Caption = 'Boline :'
            end
            object Label147: TLabel
              Left = 49
              Top = 379
              Width = 37
              Height = 16
              Caption = 'Ziper :'
            end
            object Label148: TLabel
              Left = 330
              Top = 379
              Width = 64
              Height = 16
              Caption = 'Tamanho :'
            end
            object Label149: TLabel
              Left = 511
              Top = 379
              Width = 27
              Height = 16
              Caption = 'Cor :'
            end
            object SpeedButton20: TSpeedButton
              Left = 610
              Top = 376
              Width = 24
              Height = 24
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
            object LVies: TLabel
              Left = 53
              Top = 407
              Width = 33
              Height = 16
              Caption = 'Vies :'
            end
            object Label152: TLabel
              Left = 7
              Top = 435
              Width = 91
              Height = 16
              Caption = 'Preco Fac'#231#227'o :'
            end
            object Label153: TLabel
              Left = 180
              Top = 435
              Width = 42
              Height = 16
              Caption = 'Pre'#231'o :'
            end
            object LFerramenta: TLabel
              Left = 13
              Top = 58
              Width = 75
              Height = 16
              Caption = 'Ferramenta :'
              Visible = False
            end
            object SpeedButton21: TSpeedButton
              Left = 164
              Top = 55
              Width = 24
              Height = 24
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
              Visible = False
            end
            object LFaca: TLabel
              Left = 191
              Top = 60
              Width = 66
              Height = 16
              Caption = '                      '
              Visible = False
            end
            object Label139: TLabel
              Left = 519
              Top = 87
              Width = 61
              Height = 16
              Caption = 'Diametro :'
            end
            object Label140: TLabel
              Left = 658
              Top = 87
              Width = 67
              Height = 16
              Caption = 'Pendurico :'
            end
            object LCorteObs: TLabel
              Left = 202
              Top = 139
              Width = 34
              Height = 16
              Caption = 'Obs. :'
              Visible = False
            end
            object Label135: TLabel
              Left = 528
              Top = 244
              Width = 74
              Height = 16
              Caption = 'Fotolito No. :'
            end
            object Label137: TLabel
              Left = 319
              Top = 327
              Width = 34
              Height = 16
              Caption = 'Obs. :'
              Visible = False
            end
            object Label155: TLabel
              Left = 472
              Top = 379
              Width = 18
              Height = 16
              Caption = 'cm'
            end
            object LZIperCor: TLabel
              Left = 640
              Top = 354
              Width = 66
              Height = 16
              Caption = '                      '
              Visible = False
            end
            object Label150: TLabel
              Left = 325
              Top = 407
              Width = 69
              Height = 16
              Caption = 'Adicionais :'
            end
            object LLocalImp: TLabel
              Left = 21
              Top = 272
              Width = 67
              Height = 16
              Caption = 'Local Imp. :'
            end
            object LCorZiper: TLabel
              Left = 637
              Top = 379
              Width = 33
              Height = 16
              Caption = '           '
            end
            object LPlastico2: TLabel
              Left = 559
              Top = 32
              Width = 66
              Height = 16
              Caption = '                      '
            end
            object LLocalInt: TLabel
              Left = 308
              Top = 218
              Width = 39
              Height = 16
              Caption = 'Local :'
              Visible = False
            end
            object CTipo: TComboBoxColor
              Left = 94
              Top = 4
              Width = 211
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = CTipoChange
              OnClick = CTipoClick
              Items.Strings = (
                ''
                'COSTURADO'
                'SOLDADO'
                'SOLDADO COM ZIPER'
                'TNT'
                'MATERIA PRIMA')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object CAlca: TComboBoxColor
              Left = 94
              Top = 109
              Width = 210
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
              OnChange = ECodEmpresaChange
              Items.Strings = (
                ''
                'SEM ALCA'
                'PADRAO 12x15 '
                'PEQUENO TIPO T'
                'GRANDE TIPO T'
                'COSTURADA'
                'ALCA FITA'
                'ALCA SILICONE')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object ELocalAlca: TEditColor
              Left = 368
              Top = 109
              Width = 353
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object CImpressao: TComboBoxColor
              Left = 94
              Top = 241
              Width = 80
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 18
              OnChange = ECodEmpresaChange
              Items.Strings = (
                ''
                'NAO'
                '1 COR'
                '2 CORES'
                '3 CORES'
                '4 CORES'
                '5 CORES'
                '6 CORES'
                '7 CORES'
                '8 CORES')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object ECoreslImp: TEditColor
              Left = 230
              Top = 241
              Width = 294
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 19
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object CCabide: TComboBoxColor
              Left = 94
              Top = 296
              Width = 80
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 22
              OnChange = CCabideChange
              Items.Strings = (
                ''
                'NAO'
                '8 CM'
                '10 CM'
                '14 CM'
                'GANCHEIRA')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object CBotao: TComboBoxColor
              Left = 94
              Top = 324
              Width = 80
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 24
              OnChange = CBotaoChange
              Items.Strings = (
                ''
                'NAO'
                '1'
                '2'
                '3')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object CBoline: TComboBoxColor
              Left = 94
              Top = 351
              Width = 80
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 26
              OnChange = ECodEmpresaChange
              Items.Strings = (
                ''
                'NAO'
                '1'
                '2'
                '3'
                'LINER')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object CZiper: TComboBoxColor
              Left = 94
              Top = 378
              Width = 221
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 27
              OnChange = ECodEmpresaChange
              Items.Strings = (
                ''
                'NAO'
                'NYLON 3 MM (FINO)'
                'NYLON 6 MM (GROSSO)'
                'PVC 6 MM'
                'ZIPER CHINES')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object CVies: TComboBoxColor
              Left = 94
              Top = 405
              Width = 221
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 31
              OnChange = ECodEmpresaChange
              Items.Strings = (
                ''
                'PVC TRANSPARENTE'
                'PVC COLORIDO'
                'VIES TNT'
                'VIES DE ALGODAO'
                'VIES LISOLENE')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object EPlastico2: TEditLocaliza
              Left = 458
              Top = 28
              Width = 68
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
              ATexto = LPlastico2
              ABotao = SpeedButton18
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select * from CADPRODUTOS'
                'Where C_COD_PRO = @')
              ASelectLocaliza.Strings = (
                'Select * from CADPRODUTOS'
                'Where C_NOM_PRO like '#39'@%'#39' '
                'order by C_NOM_PRO')
              APermitirVazio = True
              AInfo.CampoCodigo = 'C_COD_PRO'
              AInfo.CampoNome = 'C_NOM_PRO'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Descri'#231#227'o'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '  Localiza Produto    '
              AInfo.RetornoExtra1 = 'I_SEQ_PRO'
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = ECodCorCadastrar
              OnSelect = EPlastico2Select
              OnRetorno = EPlastico2Retorno
            end
            object EFerramenta: TEditLocaliza
              Left = 94
              Top = 56
              Width = 68
              Height = 24
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Visible = False
              OnChange = ECodEmpresaChange
              ACampoObrigatorio = True
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = LFaca
              ABotao = SpeedButton21
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select * from FACA'
                'Where CODFACA = @')
              ASelectLocaliza.Strings = (
                'Select * from FACA'
                'Where NOMFACA like '#39'@%'#39' '
                'order by NOMFACA')
              APermitirVazio = True
              AInfo.CampoCodigo = 'CODFACA'
              AInfo.CampoNome = 'NOMFACA'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Descri'#231#227'o'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '  Localiza Facas      '
              AInfo.Cadastrar = True
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = EFerramentaCadastrar
              OnFimConsulta = ECodEmpresaChange
            end
            object ECorteObs: TEditColor
              Left = 240
              Top = 136
              Width = 481
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 35
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object CSimCabide: TComboBoxColor
              Left = 180
              Top = 296
              Width = 166
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 23
              Visible = False
              OnChange = ECodEmpresaChange
              Items.Strings = (
                ''
                'LADO ABA'
                'OPOSTO ABA'
                'LATERAL')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object EObsBotao: TEditColor
              Left = 359
              Top = 323
              Width = 362
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 28
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object CBotaoCor: TComboBoxColor
              Left = 219
              Top = 323
              Width = 94
              Height = 24
              Style = csDropDownList
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 25
              Visible = False
              OnChange = ECodEmpresaChange
              Items.Strings = (
                ''
                'BRANCO'
                'PRETO')
              ACampoObrigatorio = True
              ACorFoco = FPrincipal.CorFoco
            end
            object EAdicionais: TEditColor
              Left = 400
              Top = 405
              Width = 396
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 32
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object ECorZiper: TEditLocaliza
              Left = 540
              Top = 376
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 30
              OnChange = ECorZiperChange
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = LCorZiper
              ABotao = SpeedButton20
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select * from COR'
                'Where COD_COR = @')
              ASelectLocaliza.Strings = (
                'Select * from COR'
                'Where NOM_COR like '#39'@%'#39' '
                'order by NOM_COR')
              APermitirVazio = True
              AInfo.CampoCodigo = 'COD_COR'
              AInfo.CampoNome = 'NOM_COR'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Descri'#231#227'o'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '  Localiza Cor  '
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = ECodCorCadastrar
            end
            object Panel9: TPanel
              Left = 94
              Top = 161
              Width = 102
              Height = 20
              BevelOuter = bvNone
              TabOrder = 36
            end
            object PanelColor19: TPanelColor
              Left = 94
              Top = 221
              Width = 94
              Height = 18
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 37
              AUsarCorForm = False
            end
            object PanelColor20: TPanelColor
              Left = 670
              Top = 267
              Width = 139
              Height = 24
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 38
              AUsarCorForm = False
            end
            object EPreFaccao: Tnumerico
              Left = 100
              Top = 431
              Width = 69
              Height = 24
              ACampoObrigatorio = False
              ACorFoco = FPrincipal.CorFoco
              ANaoUsarCorNegativo = False
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 33
            end
            object EPrecPvc: Tnumerico
              Left = 225
              Top = 431
              Width = 69
              Height = 24
              ACampoObrigatorio = False
              ACorFoco = FPrincipal.CorFoco
              ANaoUsarCorNegativo = False
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 34
            end
            object ETamZiper: Tnumerico
              Left = 400
              Top = 376
              Width = 69
              Height = 24
              ACampoObrigatorio = False
              ACorFoco = FPrincipal.CorFoco
              ANaoUsarCorNegativo = False
              Color = clInfoBk
              AMascara = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 29
            end
            object EInternoPvc: TEditColor
              Left = 94
              Top = 213
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 16
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EInternoPvc2: TEditColor
              Left = 230
              Top = 213
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 17
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EPlastico: TEditLocaliza
              Left = 94
              Top = 29
              Width = 68
              Height = 24
              Color = 11661566
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnChange = ECodEmpresaChange
              ACampoObrigatorio = True
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = LPlastico
              ABotao = SpeedButton16
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select * from CADPRODUTOS'
                'Where C_COD_PRO = @')
              ASelectLocaliza.Strings = (
                'Select * from CADPRODUTOS'
                'Where C_NOM_PRO like '#39'@%'#39' '
                'order by C_NOM_PRO')
              APermitirVazio = True
              AInfo.CampoCodigo = 'C_COD_PRO'
              AInfo.CampoNome = 'C_NOM_PRO'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Descri'#231#227'o'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '  Localiza Produto    '
              AInfo.RetornoExtra1 = 'I_SEQ_PRO'
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = ECodCorCadastrar
              OnSelect = EPlasticoSelect
              OnRetorno = EPlasticoRetorno
              OnFimConsulta = ECodEmpresaChange
            end
            object CBolso: TCheckBox
              Left = 97
              Top = 192
              Width = 97
              Height = 17
              Caption = 'Bolso'
              TabOrder = 15
              OnClick = CBolsoClick
            end
            object CCorte: TCheckBox
              Left = 97
              Top = 139
              Width = 97
              Height = 17
              Caption = 'Corte'
              TabOrder = 14
              Visible = False
              OnClick = CCorteClick
            end
            object Panel10: TPanel
              Left = 653
              Top = 240
              Width = 138
              Height = 24
              BevelOuter = bvNone
              Color = clSilver
              Ctl3D = True
              ParentCtl3D = False
              ParentShowHint = False
              ShowHint = False
              TabOrder = 39
              object RInterno: TRadioButton
                Left = 3
                Top = 4
                Width = 65
                Height = 17
                Caption = 'Interno'
                TabOrder = 0
              end
              object RExterno: TRadioButton
                Left = 72
                Top = 4
                Width = 113
                Height = 17
                Caption = 'Externo'
                TabOrder = 1
              end
            end
            object ELocalImp: TEditColor
              Left = 94
              Top = 268
              Width = 294
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 21
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EFolha2: TEditColor
              Left = 94
              Top = 164
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EFolhaMarc: TEditColor
              Left = 266
              Top = 164
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EFotolito: TEditColor
              Left = 603
              Top = 240
              Width = 47
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 20
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object ELarPvc: TEditColor
              Left = 94
              Top = 82
              Width = 68
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
            end
            object EAltPvc: TEditColor
              Left = 208
              Top = 82
              Width = 68
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
            end
            object EFunPvc: TEditColor
              Left = 329
              Top = 82
              Width = 68
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EAbaPvc: TEditColor
              Left = 439
              Top = 82
              Width = 68
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
            end
            object EDiaPvc: TEditColor
              Left = 582
              Top = 82
              Width = 68
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
            end
            object EPenPvc: TEditColor
              Left = 720
              Top = 82
              Width = 68
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
            end
            object ELocalInt: TEditColor
              Left = 352
              Top = 213
              Width = 353
              Height = 24
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 40
              Visible = False
              ACampoObrigatorio = False
              AIgnorarCor = False
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
          end
        end
      end
      object PRotuladoras: TTabSheet
        Caption = 'Maquinas Rotuladoras'
        ImageIndex = 17
        object PanelColor21: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Label145: TLabel
            Left = 14
            Top = 16
            Width = 132
            Height = 16
            Caption = 'Descri'#231#227'o Comercial :'
          end
          object Label151: TLabel
            Left = 21
            Top = 56
            Width = 125
            Height = 16
            Caption = 'Informa'#231#227'o Tecnica :'
          end
          object EDescComercial: TEditColor
            Left = 152
            Top = 13
            Width = 635
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
          end
          object MInfoTecnica: TMemoColor
            Left = 152
            Top = 53
            Width = 635
            Height = 148
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Lines.Strings = (
              'MInfoTecnica')
            ParentFont = False
            TabOrder = 1
            ACampoObrigatorio = False
            ACorFoco = FPrincipal.CorFoco
          end
        end
      end
      object PFilial: TTabSheet
        Caption = 'Filial Faturamento'
        ImageIndex = 18
        object PanelColor18: TPanelColor
          Left = 0
          Top = 0
          Width = 794
          Height = 481
          Align = alClient
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object GFilial: TRBStringGridColor
            Left = 1
            Top = 1
            Width = 792
            Height = 479
            Align = alClient
            Color = clInfoBk
            ColCount = 3
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
            TabOrder = 0
            OnGetEditMask = GFilialGetEditMask
            OnKeyDown = GFilialKeyDown
            OnSelectCell = GFilialSelectCell
            ACorFoco = FPrincipal.CorFoco
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GFilialDadosValidos
            OnMudouLinha = GFilialMudouLinha
            OnNovaLinha = GFilialNovaLinha
            OnCarregaItemGrade = GFilialCarregaItemGrade
            ColWidths = (
              19
              74
              399)
          end
          object EFilial: TRBEditLocaliza
            Left = 96
            Top = 128
            Width = 57
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = False
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ASelectValida.Strings = (
              'Select I_EMP_FIL, C_NOM_FAN '
              ' from CADFILIAIS '
              ' Where I_EMP_FIL = @')
            ASelectLocaliza.Strings = (
              'Select I_EMP_FIL, C_NOM_FAN '
              ' from CADFILIAIS ')
            APermitirVazio = False
            AColunas = <
              item
                ATituloColuna = 'C'#243'digo'
                ATamanhoColuna = 8
                ACampoFiltro = False
                ANomeCampo = 'I_EMP_FIL'
                AMostrarNaGrade = True
                AOrdemInicial = False
              end
              item
                ATituloColuna = 'Nome'
                ATamanhoColuna = 40
                ACampoFiltro = True
                ANomeCampo = 'C_NOM_FAN'
                AMostrarNaGrade = True
                AOrdemInicial = True
              end>
            ALocalizaPadrao = lpFilial
            ATituloFormulario = '   Localiza Filial '
            OnRetorno = EFilialRetorno
          end
        end
      end
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 555
    Width = 804
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
      Left = 304
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Gravar'
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
      Left = 400
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Cancelar'
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
      OnClick = BFecharClick
    end
    object BFechar: TBitBtn
      Left = 692
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Fechar'
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
    object BKit: TBitBtn
      Left = 14
      Top = 6
      Width = 100
      Height = 30
      Caption = 'Consumo'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
        000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
        99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
        0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
        FFFF3333337F337F333333333307B70FFFFF33333373FF733F333333333000FF
        0FFF3333333777337FF3333333333FF000FF33FFFFF3333777FF300000333300
        000F377777F33377777F30EEE0333000000037F337F33777777730EEE0333330
        00FF37F337F3333777F330EEE033333000FF37FFF7F3333777F3300000333330
        00FF3777773333F77733333333333000033F3333333337777333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = BKitClick
    end
    object BMenuFiscal: TBitBtn
      Left = 586
      Top = 6
      Width = 100
      Height = 30
      Caption = 'Menu Fiscal'
      DoubleBuffered = True
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = BGravarClick
    end
  end
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 804
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '  Produto  '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = FPrincipal.CorPainelGra
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 104
    Top = 8
  end
  object ValidaGravacao: TValidaGravacao
    AComponente = PanelColor1
    ABotaoGravar = BGravar
    Left = 216
    Top = 8
  end
  object EditorImagem: TEditorImagem
    Left = 169
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 272
    Top = 8
    object ImportarProduto1: TMenuItem
      Caption = 'Importar Amostra'
      OnClick = ImportarProduto1Click
    end
  end
  object MImagem: TPopupMenu
    Left = 360
    Top = 8
    object SalvarImagemAreaTranferenciaWindows1: TMenuItem
      Caption = 'Salvar Imagem Area Tranferencia Windows'
      OnClick = SalvarImagemAreaTranferenciaWindows1Click
    end
  end
end
