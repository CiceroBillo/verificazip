object FOrdemProducaoGenerica: TFOrdemProducaoGenerica
  Left = 44
  Top = 98
  Caption = 'Ordens de Produ'#231#227'o'
  ClientHeight = 486
  ClientWidth = 821
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
  object PanelColor3: TPanelColor
    Left = 0
    Top = 94
    Width = 821
    Height = 326
    Align = alClient
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
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 819
      Height = 324
      ActivePage = PFracionada
      Align = alClient
      TabOrder = 0
      OnChange = PageControl1Change
      object PFracionada: TTabSheet
        Caption = 'Fracionada'
        object GridIndice1: TGridIndice
          Left = 0
          Top = 0
          Width = 811
          Height = 293
          Align = alClient
          Color = clInfoBk
          DataSource = DataOrdemProducao
          DrawingStyle = gdsClassic
          FixedColor = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupMenu1
          ShowHint = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -13
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = BConsultarClick
          OnKeyDown = GridIndice1KeyDown
          ACorFoco = FPrincipal.CorFoco
          AColunasOrdem = <>
          AListaIndice.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '11')
          AListaCAmpos.Strings = (
            'ORD.EMPFIL'
            'FRA.SEQORDEM'
            'FRA.SEQFRACAO'
            'ORD.DATEMI '
            'ORD.DATENP'
            'ORD.DATENT '
            'ORD.NUMPED'
            'CLI.C_NOM_CLI '
            'PRO.C_NOM_PRO  '
            'EST.NOMEST')
          AindiceInicial = 1
          ALinhaSQLOrderBy = 0
          OnOrdem = GridIndice1Ordem
          Columns = <
            item
              Expanded = False
              FieldName = 'EMPFIL'
              Title.Caption = 'Filial  [+]'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SEQORD'
              Title.Caption = 'OP  [+]'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SEQFRACAO'
              Title.Caption = 'Fra'#231#227'o  [+]'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATEMI'
              Title.Caption = 'Emiss'#227'o  [+]'
              Width = 102
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DATENTREGA'
              Title.Caption = 'Entrega Prevista  [+]'
              Width = 118
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATENT'
              Title.Caption = 'Entrega  [+]'
              Width = 81
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMPED'
              Title.Caption = 'Pedido  [+]'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_NOM_CLI'
              Title.Caption = 'Cliente  [+]'
              Width = 211
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRODUTO'
              Title.Caption = 'Produto  [+]'
              Width = 220
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOM_COR'
              Title.Caption = 'Combinacao'
              Width = 140
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTDPRODUTO'
              Title.Caption = 'Qtd'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOMEST'
              Title.Caption = 'Estagio  [+]'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_NOM_USU'
              Title.Caption = 'Usu'#225'rio'
              Width = 214
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTDAFATURAR'
              Title.Caption = 'Qtd a Faturar'
              Width = 93
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTDREVISADO'
              Title.Caption = 'Qtd Revisado'
              Visible = True
            end>
        end
        object EAlteraCliente: TRBEditLocaliza
          Left = 275
          Top = 87
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
        end
      end
      object PSubMontagem: TTabSheet
        Caption = 'Sub Montagem'
        ImageIndex = 1
        object Arvore: TTreeView
          Left = 0
          Top = 0
          Width = 560
          Height = 293
          Align = alClient
          Images = ImageList1
          Indent = 19
          ParentShowHint = False
          PopupMenu = MArvore
          ReadOnly = True
          ShowHint = True
          StateImages = ImageList1
          TabOrder = 0
          OnDblClick = ArvoreDblClick
          OnExpanded = ArvoreExpanded
          OnMouseMove = ArvoreMouseMove
        end
        object PLegenda: TPanelColor
          Left = 560
          Top = 0
          Width = 251
          Height = 293
          Align = alRight
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          Visible = False
          OnClick = PLegendaClick
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
          object Image1: TImage
            Left = 6
            Top = 5
            Width = 16
            Height = 16
            AutoSize = True
            Picture.Data = {
              07544269746D6170F6000000424DF60000000000000076000000280000001000
              0000100000000100040000000000800000000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF003333333333333333333333333333333333300000000003333330FFFFFFFF
              03333330FFFFFFFF03333330F00F000F03333330FFFFFFFF03333330F0000F0F
              03333330FFFFFFFF03333330F00F000003333330FFFF0FF033333330F08F0F03
              33333330FFFF0033333333300000033333333333333333333333333333333333
              3333}
            Transparent = True
          end
          object Label11: TLabel
            Left = 24
            Top = 6
            Width = 207
            Height = 16
            Caption = 'N'#227'o Atrasada e Aguardando Inicio'
          end
          object Image2: TImage
            Left = 6
            Top = 23
            Width = 16
            Height = 16
            AutoSize = True
            Picture.Data = {
              07544269746D6170F6000000424DF60000000000000076000000280000001000
              0000100000000100040000000000800000000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF0033333333A333333AAAAAAAAAAAAAAAA33AA0000000000A3333A0FFFFFFFF
              0A3333A0FFFFFFFF0A3333A0F00F000F0A3333A0FFFFFFFF0A33AAA0F0000F0F
              0AA33AA0FFFFFFFF0AAA33A0F00F00000A3333A0FFFF0FF0A33333A0F08F0F0A
              333333A0FFFF00AAA33333A000000A33AA333AAAAAAAA3333AAAA333333A3333
              333A}
            Transparent = True
          end
          object Label12: TLabel
            Left = 24
            Top = 22
            Width = 145
            Height = 16
            Caption = 'N'#227'o Atrasada e Iniciada'
          end
          object Image3: TImage
            Left = 6
            Top = 41
            Width = 16
            Height = 16
            AutoSize = True
            Picture.Data = {
              07544269746D6170F6000000424DF60000000000000076000000280000001000
              0000100000000100040000000000800000000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF0033333333B333333BBBBBBBBBBBBBBBB33BB0000000000B3333B0FFFFFFFF
              0B3333B0FFFFFFFF0B3333B0F00F000F0B3333B0FFFFFFFF0B33BBB0F0000F0F
              0BB33BB0FFFFFFFF0BBB33B0F00F00000B3333B0FFFF0FF0B33333B0F08F0F0B
              333333B0FFFF00BBB33333B000000B33BB333BBBBBBBBB333BBBB333333B3333
              333B}
            Transparent = True
          end
          object Label13: TLabel
            Left = 24
            Top = 40
            Width = 202
            Height = 16
            Caption = 'Entrega Hoje e Aguardando Inicio'
          end
          object Label14: TLabel
            Left = 24
            Top = 58
            Width = 140
            Height = 16
            Caption = 'Entrega Hoje e Iniciada'
          end
          object Image4: TImage
            Left = 6
            Top = 59
            Width = 16
            Height = 16
            AutoSize = True
            Picture.Data = {
              07544269746D6170F6000000424DF60000000000000076000000280000001000
              0000100000000100040000000000800000000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF0033333333B333333BBBBBBBBBBBBBBBB33BB0000000000B3333B0AAAAAAAA
              0B3333B0AAAAAAAA0B3333B0A00A000A0B3333B0AAAAAAAA0B33BBB0A0000A0A
              0BB33BB0FFFFFFFF0BBB33B0F00F00000B3333B0FFFF0FF0B33333B0F08F0F0B
              333333B0FFFF00BBB33333B000000B33BB333BBBBBBBBB333BBBB333333B3333
              333B}
            Transparent = True
          end
          object Label17: TLabel
            Left = 24
            Top = 77
            Width = 178
            Height = 16
            Caption = 'Atrasada e Aguardando Inicio'
          end
          object Image5: TImage
            Left = 6
            Top = 78
            Width = 16
            Height = 16
            AutoSize = True
            Picture.Data = {
              07544269746D6170F6000000424DF60000000000000076000000280000001000
              0000100000000100040000000000800000000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF003333333393333339999999999999999339900000000009333390FFFFFFFF
              09333390FFFFFFFF09333390F00F000F09333390FFFFFFFF09339990F0000F0F
              09933990FFFFFFFF09993390F00F000009333390FFFF0FF093333390F08F0F09
              33333390FFFF0099933333900000093399333999999999333999933333393333
              3339}
            Transparent = True
          end
          object Image6: TImage
            Left = 6
            Top = 95
            Width = 16
            Height = 16
            AutoSize = True
            Picture.Data = {
              07544269746D6170F6000000424DF60000000000000076000000280000001000
              0000100000000100040000000000800000000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF003333333393333339999999999999999339900000000009333390AAAAAAAA
              09333390AAAAAAAA09333390A00A000A09333390AAAAAAAA09339990A0000A0A
              09933990FFFFFFFF09993390F00F000009333390FFFF0FF093333390F08F0F09
              33333390FFFF0099933333900000093399333999999999333999933333393333
              3339}
            Transparent = True
          end
          object Label18: TLabel
            Left = 24
            Top = 94
            Width = 116
            Height = 16
            Caption = 'Atrasada e Iniciada'
          end
          object Image7: TImage
            Left = 6
            Top = 113
            Width = 16
            Height = 16
            AutoSize = True
            Picture.Data = {
              07544269746D6170F6000000424DF60000000000000076000000280000001000
              0000100000000100040000000000800000000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF00888888888888888888888888888888888880000000000888888077777777
              0888888077777777088888807007000708888880777777770888888070000707
              0888888077777777088888807007000008888880777707708888888070770708
              8888888077770088888888800000088888888888888888888888888888888888
              8888}
            Transparent = True
          end
          object Label19: TLabel
            Left = 24
            Top = 112
            Width = 108
            Height = 16
            Caption = 'Fra'#231#227'o Finalizada'
          end
        end
      end
      object PImpressao: TTabSheet
        Caption = 'Impress'#227'o'
        ImageIndex = 2
        TabVisible = False
        object GImpressao: TRBStringGridColor
          Left = 0
          Top = 0
          Width = 811
          Height = 265
          Align = alClient
          Color = clInfoBk
          DefaultRowHeight = 22
          DrawingStyle = gdsClassic
          FixedColor = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnMudouLinha = GImpressaoMudouLinha
          OnCarregaItemGrade = GImpressaoCarregaItemGrade
          ColWidths = (
            7
            30
            46
            69
            425)
        end
        object PanelColor4: TPanelColor
          Left = 0
          Top = 265
          Width = 811
          Height = 28
          Align = alBottom
          Caption = 'Imprimir'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = PanelColor4Click
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
        end
      end
      object PImpressaoProduto: TTabSheet
        Caption = 'Impress'#227'o Produto'
        ImageIndex = 3
        object GImpressaoProduto: TRBStringGridColor
          Left = 0
          Top = 0
          Width = 811
          Height = 265
          Align = alClient
          Color = clInfoBk
          ColCount = 6
          DefaultRowHeight = 22
          DrawingStyle = gdsClassic
          FixedColor = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACorFoco = FPrincipal.CorFoco
          ALinha = 0
          AColuna = 0
          AEstadoGrade = egNavegacao
          APermiteExcluir = True
          APermiteInserir = True
          APossuiDadosForadaGrade = False
          ReadOnly = False
          OnMudouLinha = GImpressaoMudouLinha
          OnCarregaItemGrade = GImpressaoProdutoCarregaItemGrade
          ColWidths = (
            7
            35
            43
            62
            163
            475)
        end
        object PanelColor5: TPanelColor
          Left = 0
          Top = 265
          Width = 811
          Height = 28
          Align = alBottom
          Caption = 'Imprimir'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = PanelColor5Click
          AUsarCorForm = False
          ACorForm = FPrincipal.CorForm
        end
      end
    end
  end
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 821
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Ordens de Produ'#231#227'o   '
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
    Width = 821
    Height = 53
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
    object Label7: TLabel
      Left = 33
      Top = 32
      Width = 76
      Height = 16
      Alignment = taRightJustify
      Caption = 'N'#250'mero OP :'
    end
    object Label2: TLabel
      Left = 516
      Top = 82
      Width = 52
      Height = 16
      Alignment = taRightJustify
      Caption = 'Est'#225'gio :'
    end
    object SpeedButton1: TSpeedButton
      Left = 642
      Top = 78
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
    object Label3: TLabel
      Left = 672
      Top = 82
      Width = 27
      Height = 16
      Caption = '         '
    end
    object Label4: TLabel
      Left = 491
      Top = 32
      Width = 77
      Height = 16
      Alignment = taRightJustify
      Caption = 'Per'#237'odo por :'
    end
    object Label5: TLabel
      Left = 59
      Top = 110
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Pedido :'
    end
    object Label8: TLabel
      Left = 56
      Top = 84
      Width = 53
      Height = 16
      Alignment = taRightJustify
      Caption = 'Produto :'
    end
    object SpeedButton2: TSpeedButton
      Left = 228
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
    object Label9: TLabel
      Left = 261
      Top = 84
      Width = 42
      Height = 16
      Caption = '              '
    end
    object Label1: TLabel
      Left = 521
      Top = 57
      Width = 47
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cliente :'
    end
    object SpeedButton3: TSpeedButton
      Left = 642
      Top = 53
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
      Left = 672
      Top = 57
      Width = 27
      Height = 16
      Caption = '         '
    end
    object Label15: TLabel
      Left = 75
      Top = 5
      Width = 34
      Height = 16
      Alignment = taRightJustify
      Caption = 'Filial :'
    end
    object SpeedButton6: TSpeedButton
      Left = 172
      Top = 1
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
    object Label16: TLabel
      Left = 210
      Top = 5
      Width = 249
      Height = 16
      AutoSize = False
      Caption = '            '
    end
    object Label10: TLabel
      Left = 60
      Top = 58
      Width = 49
      Height = 16
      Alignment = taRightJustify
      Caption = 'Fra'#231#227'o :'
    end
    object Label20: TLabel
      Left = 413
      Top = 108
      Width = 155
      Height = 16
      Alignment = taRightJustify
      Caption = 'Est'#225'gio n'#227'o Processado :'
    end
    object SpeedButton4: TSpeedButton
      Left = 642
      Top = 104
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
    object Label21: TLabel
      Left = 672
      Top = 108
      Width = 27
      Height = 16
      Caption = '         '
    end
    object Label22: TLabel
      Left = 479
      Top = 163
      Width = 89
      Height = 16
      Alignment = taRightJustify
      Caption = 'Mat'#233'ria Prima :'
    end
    object SpeedButton5: TSpeedButton
      Left = 642
      Top = 159
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
    object Label23: TLabel
      Left = 675
      Top = 163
      Width = 42
      Height = 16
      Caption = '              '
    end
    object Label24: TLabel
      Left = 383
      Top = 134
      Width = 185
      Height = 16
      Alignment = taRightJustify
      Caption = 'Tipo Est'#225'gio n'#227'o processado :'
    end
    object SpeedButton7: TSpeedButton
      Left = 642
      Top = 130
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
    object Label25: TLabel
      Left = 672
      Top = 134
      Width = 27
      Height = 16
      Caption = '         '
    end
    object SpeedButton8: TSpeedButton
      Left = 172
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
    end
    object Label26: TLabel
      Left = 204
      Top = 136
      Width = 42
      Height = 16
      Caption = '              '
    end
    object Label27: TLabel
      Left = 60
      Top = 136
      Width = 49
      Height = 16
      Alignment = taRightJustify
      Caption = 'Projeto :'
    end
    object CPeriodo: TCheckBox
      Left = 476
      Top = 7
      Width = 92
      Height = 17
      Caption = 'Per'#237'odo de :'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = EPedidoExit
    end
    object EDatInicio: TCalendario
      Left = 576
      Top = 2
      Width = 97
      Height = 24
      Date = 37897.782365810180000000
      Time = 37897.782365810180000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnCloseUp = EPedidoExit
      OnExit = EPedidoExit
      OnKeyDown = EEstagioKeyDown
      ACorFoco = FPrincipal.CorFoco
    end
    object EDatFim: TCalendario
      Left = 705
      Top = 2
      Width = 97
      Height = 24
      Date = 37897.782391307870000000
      Time = 37897.782391307870000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnCloseUp = EPedidoExit
      OnExit = PageControl1Change
      OnKeyDown = EEstagioKeyDown
      ACorFoco = FPrincipal.CorFoco
    end
    object ENumeroOp: Tnumerico
      Left = 112
      Top = 28
      Width = 89
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
      OnExit = EPedidoExit
      OnKeyDown = EEstagioKeyDown
    end
    object EEstagio: TEditLocaliza
      Left = 576
      Top = 78
      Width = 65
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnKeyDown = EEstagioKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label3
      ABotao = SpeedButton1
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'WHERE CODEST = @')
      ASelectLocaliza.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where NOMEST Like '#39'@%'#39
        'and TIPEST = '#39'P'#39
        'order by CODEST ')
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
      OnFimConsulta = EPedidoExit
    end
    object EPeriodoPor: TComboBoxColor
      Left = 576
      Top = 28
      Width = 225
      Height = 24
      Style = csDropDownList
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = EPedidoExit
      Items.Strings = (
        'Data Entrega Prevista'
        'Data Emissao O.P.'
        'Data de Finaliza'#231#227'o'
        'Data Finaliza'#231#227'o Prevista Estagio')
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
    end
    object EPedido: Tnumerico
      Left = 112
      Top = 106
      Width = 89
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
      TabOrder = 8
      OnExit = EPedidoExit
      OnKeyDown = EEstagioKeyDown
    end
    object EProduto: TEditLocaliza
      Left = 112
      Top = 80
      Width = 116
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnKeyDown = EProdutoKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label9
      ABotao = SpeedButton2
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'SELECT * FROM CADPRODUTOS'
        'WHERE C_COD_PRO = '#39'@'#39)
      ASelectLocaliza.Strings = (
        'Select * from CadProdutos'
        'Where C_NOM_PRO like '#39'@%'#39)
      APermitirVazio = True
      AInfo.CampoCodigo = 'C_COD_PRO'
      AInfo.CampoNome = 'C_NOM_PRO'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Produto   '
      AInfo.Cadastrar = True
      AInfo.RetornoExtra1 = 'I_SEQ_PRO'
      ADarFocoDepoisdoLocaliza = True
      OnRetorno = EProdutoRetorno
    end
    object CFichaConsumo: TCheckBox
      Left = 112
      Top = 156
      Width = 265
      Height = 17
      Caption = 'Fichas de consumo n'#227'o impressas'
      TabOrder = 10
      OnClick = EPedidoExit
    end
    object ECliente: TEditLocaliza
      Left = 576
      Top = 53
      Width = 65
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      OnKeyDown = EEstagioKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label6
      ABotao = SpeedButton3
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from CADCLIENTES'
        'Where I_COD_CLI = @')
      ASelectLocaliza.Strings = (
        'Select * from CADCLIENTES '
        'Where C_NOM_CLI like '#39'@%'#39)
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_COD_CLI'
      AInfo.CampoNome = 'C_NOM_CLI'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Cliente   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EPedidoExit
    end
    object CFracaoFinalizada: TCheckBox
      Left = 112
      Top = 171
      Width = 265
      Height = 17
      Caption = 'Somente fra'#231#245'es n'#227'o finalizadas'
      TabOrder = 11
      OnClick = EPedidoExit
    end
    object EFilial: TEditLocaliza
      Left = 112
      Top = 1
      Width = 59
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
      ATexto = Label16
      ABotao = SpeedButton6
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from CADFILIAIS'
        'Where I_EMP_FIL = @')
      ASelectLocaliza.Strings = (
        'Select * from CADFILIAIS'
        'Where C_NOM_FAN LIKE '#39'@%'#39
        'order by  C_NOM_FAN')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_EMP_FIL'
      AInfo.CampoNome = 'C_NOM_FAN'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Filial      '
      ADarFocoDepoisdoLocaliza = True
    end
    object EFracao: Tnumerico
      Left = 112
      Top = 54
      Width = 89
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
      TabOrder = 6
      OnExit = EPedidoExit
      OnKeyDown = EEstagioKeyDown
    end
    object EEstagioNaoProcesado: TEditLocaliza
      Left = 576
      Top = 104
      Width = 65
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnKeyDown = EEstagioKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label21
      ABotao = SpeedButton4
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'WHERE CODEST = @')
      ASelectLocaliza.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where NOMEST Like '#39'@%'#39
        'and TIPEST = '#39'P'#39
        'order by CODEST ')
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
      OnFimConsulta = EPedidoExit
    end
    object EMateriaPrima: TEditLocaliza
      Left = 576
      Top = 159
      Width = 65
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      OnKeyDown = EEstagioKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label23
      ABotao = SpeedButton5
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'SELECT * FROM CADPRODUTOS'
        'WHERE C_COD_PRO = '#39'@'#39)
      ASelectLocaliza.Strings = (
        'Select * from CadProdutos'
        'Where C_NOM_PRO like '#39'@%'#39)
      APermitirVazio = True
      AInfo.CampoCodigo = 'C_COD_PRO'
      AInfo.CampoNome = 'C_NOM_PRO'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Produto   '
      AInfo.Cadastrar = True
      AInfo.RetornoExtra1 = 'I_SEQ_PRO'
      ADarFocoDepoisdoLocaliza = True
      OnRetorno = EMateriaPrimaRetorno
    end
    object BFiltros: TBitBtn
      Left = 200
      Top = 29
      Width = 28
      Height = 24
      Caption = '>>'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 17
      OnClick = BFiltrosClick
    end
    object ETipoEstagio: TEditLocaliza
      Left = 576
      Top = 130
      Width = 65
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      OnKeyDown = EEstagioKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label25
      ABotao = SpeedButton7
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from TIPOESTAGIOPRODUCAO'
        'WHERE CODTIP = @')
      ASelectLocaliza.Strings = (
        'Select * from TIPOESTAGIOPRODUCAO'
        'and TIPEST = '#39'P'#39
        'order by CODEST ')
      APermitirVazio = True
      AInfo.CampoCodigo = 'CODTIP'
      AInfo.CampoNome = 'NOMTIP'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Tipo Est'#225'gio   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EPedidoExit
    end
    object EProjeto: TRBEditLocaliza
      Left = 112
      Top = 132
      Width = 59
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnKeyDown = EEstagioKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = Label26
      ABotao = SpeedButton8
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ASelectValida.Strings = (
        'Select CODPROJETO, NOMPROJETO '
        ' from PROJETO '
        ' Where CODPROJETO = @')
      ASelectLocaliza.Strings = (
        'Select CODPROJETO, NOMPROJETO '
        ' from PROJETO ')
      APermitirVazio = True
      AColunas = <
        item
          ATituloColuna = 'C'#243'digo'
          ATamanhoColuna = 8
          ACampoFiltro = False
          ANomeCampo = 'CODPROJETO'
          AMostrarNaGrade = True
          AOrdemInicial = False
        end
        item
          ATituloColuna = 'Nome'
          ATamanhoColuna = 30
          ACampoFiltro = True
          ANomeCampo = 'NOMPROJETO'
          AMostrarNaGrade = True
          AOrdemInicial = True
        end>
      ALocalizaPadrao = lpProjeto
      ATituloFormulario = '   Localiza Projeto   '
      OnFimConsulta = EPedidoExit
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 420
    Width = 821
    Height = 66
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
    object BCadastrar: TBitBtn
      Left = 4
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
      Left = 103
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
      Left = 202
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Co&nsultar'
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
    object BExcluir: TBitBtn
      Left = 301
      Top = 5
      Width = 100
      Height = 30
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
      OnClick = BExcluirClick
    end
    object BFechar: TBitBtn
      Left = 706
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
    object BExcluiFracao: TBitBtn
      Left = 400
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Fra'#231#227'o'
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
      OnClick = BExcluiFracaoClick
    end
    object BImprimir: TBitBtn
      Left = 499
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
      PopupMenu = PopupMenu3
      TabOrder = 4
      OnClick = BImprimirClick
    end
    object BFichaConsumo: TBitBtn
      Tag = 1
      Left = 598
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Consumo'
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
      PopupMenu = PopupMenu4
      TabOrder = 5
      OnClick = BFichaConsumoClick
    end
    object BitBtn2: TBitBtn
      Left = 202
      Top = 34
      Width = 135
      Height = 30
      Caption = '&Baixar Consumo'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFFFF
        FFFF33333333333FFFFF3FFFFFFFFF00000F333333333377777F33FFFFFFFF09
        990F33333333337F337F333FFFFFFF09990F33333333337F337F3333FFFFFF09
        990F33333333337FFF7F33333FFFFF00000F3333333333777773333333FFFFFF
        FFFF3333333333333F333333333FFFFF0FFF3333333333337FF333333333FFF0
        00FF33333333333777FF333333333F00000F33FFFFF33777777F300000333000
        0000377777F33777777730EEE033333000FF37F337F3333777F330EEE0333330
        00FF37F337F3333777F330EEE033333000FF37FFF7F333F77733300000333000
        03FF3777773337777333333333333333333F3333333333333333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 9
      OnClick = BitBtn2Click
    end
    object BImprimeOrdemSerra: TBitBtn
      Left = 499
      Top = 34
      Width = 100
      Height = 30
      Caption = '&Ord Serra'
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
      PopupMenu = PopupMenu2
      TabOrder = 10
      OnClick = BImprimeOrdemSerraClick
    end
    object BImprimeOrdemCorte: TBitBtn
      Left = 598
      Top = 34
      Width = 100
      Height = 30
      Caption = '&Ord Corte'
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
      TabOrder = 8
      OnClick = BImprimeOrdemCorteClick
    end
    object BImprimirEtiquetas: TBitBtn
      Left = 400
      Top = 34
      Width = 100
      Height = 30
      Caption = '&Etiquetas'
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
      PopupMenu = PopupMenu3
      TabOrder = 11
      OnClick = BImprimirEtiquetasClick
    end
    object BSolicitacaoCompras: TBitBtn
      Left = 4
      Top = 34
      Width = 199
      Height = 30
      Caption = '&Gera Requisi'#231#227'o Compras'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFFFF
        FFFF33333333333FFFFF3FFFFFFFFF00000F333333333377777F33FFFFFFFF09
        990F33333333337F337F333FFFFFFF09990F33333333337F337F3333FFFFFF09
        990F33333333337FFF7F33333FFFFF00000F3333333333777773333333FFFFFF
        FFFF3333333333333F333333333FFFFF0FFF3333333333337FF333333333FFF0
        00FF33333333333777FF333333333F00000F33FFFFF33777777F300000333000
        0000377777F33777777730EEE033333000FF37F337F3333777F330EEE0333330
        00FF37F337F3333777F330EEE033333000FF37FFF7F333F77733300000333000
        03FF3777773337777333333333333333333F3333333333333333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 12
      OnClick = BSolicitacaoComprasClick
    end
  end
  object PainelTempo1: TPainelTempo
    Left = 301
    Top = 8
    Width = 29
    Height = 29
    Caption = 'T'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
    AColorSombra = clBlack
    AColorInicio = clSilver
  end
  object OrdemProducao: TSQL
    Aggregates = <>
    PacketRecords = 30
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'select ORD.EMPFIL, ORD.SEQORD, ORD.DATEMI,  ORD.DATENP, ORD.DATE' +
        'NT,  ORD.NUMPED, '
      
        ' FRA.SEQFRACAO, FRA.DATIMPRESSAOFICHA, FRA.QTDPRODUTO, FRA.DATEN' +
        'TREGA,'
      ' FRA.QTDAFATURAR, FRA.QTDREVISADO, FRA.CODCOR, FRA.DESUM,'
      '  CLI.C_NOM_CLI, '
      'PRO.C_COD_PRO || '#39'-'#39'|| PRO.C_NOM_PRO PRODUTO,  '
      ' COR.NOM_COR,'
      ' EST.NOMEST,'
      'USU.C_NOM_USU,'
      'PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, '
      'PRO.C_COD_UNI UMORIGINAL'
      ''
      'from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI, '
      '        CADPRODUTOS PRO, COR, ESTAGIOPRODUCAO EST, '
      '        CADUSUARIOS USU, FRACAOOP FRA'
      'Where ORD.CODCLI = CLI.I_COD_CLI'
      'and ORD.SEQPRO = PRO.I_SEQ_PRO'
      'and ORD.CODCOM = COR.COD_COR'
      'AND FRA.CODESTAGIO = EST.CODEST'
      'AND ORD.CODUSU = USU.I_COD_USU')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select ORD.EMPFIL, ORD.SEQORD, ORD.DATEMI,  ORD.DATENP, ORD.DATE' +
        'NT,  ORD.NUMPED, '
      
        ' FRA.SEQFRACAO, FRA.DATIMPRESSAOFICHA, FRA.QTDPRODUTO, FRA.DATEN' +
        'TREGA,'
      ' FRA.QTDAFATURAR, FRA.QTDREVISADO, FRA.CODCOR, FRA.DESUM,'
      '  CLI.C_NOM_CLI, '
      'PRO.C_COD_PRO || '#39'-'#39'|| PRO.C_NOM_PRO PRODUTO,  '
      ' COR.NOM_COR,'
      ' EST.NOMEST,'
      'USU.C_NOM_USU,'
      'PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, '
      'PRO.C_COD_UNI UMORIGINAL'
      ''
      'from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI, '
      '        CADPRODUTOS PRO, COR, ESTAGIOPRODUCAO EST, '
      '        CADUSUARIOS USU, FRACAOOP FRA'
      'Where ORD.CODCLI = CLI.I_COD_CLI'
      'and ORD.SEQPRO = PRO.I_SEQ_PRO'
      'and ORD.CODCOM = COR.COD_COR'
      'AND FRA.CODESTAGIO = EST.CODEST'
      'AND ORD.CODUSU = USU.I_COD_USU')
    Left = 16
    Top = 8
    object OrdemProducaoEMPFIL: TFMTBCDField
      FieldName = 'EMPFIL'
      Origin = 'BASEDADOS.ORDEMPRODUCAOCORPO.EMPFIL'
    end
    object OrdemProducaoSEQORD: TFMTBCDField
      FieldName = 'SEQORD'
      Origin = 'BASEDADOS.ORDEMPRODUCAOCORPO.SEQORD'
    end
    object OrdemProducaoDATEMI: TSQLTimeStampField
      FieldName = 'DATEMI'
      Origin = 'BASEDADOS.ORDEMPRODUCAOCORPO.DATEMI'
    end
    object OrdemProducaoDATENP: TSQLTimeStampField
      FieldName = 'DATENP'
      Origin = 'BASEDADOS.ORDEMPRODUCAOCORPO.DATENP'
    end
    object OrdemProducaoDATENT: TSQLTimeStampField
      FieldName = 'DATENT'
      Origin = 'BASEDADOS.ORDEMPRODUCAOCORPO.DATENT'
    end
    object OrdemProducaoNUMPED: TFMTBCDField
      FieldName = 'NUMPED'
      Origin = 'BASEDADOS.ORDEMPRODUCAOCORPO.NUMPED'
    end
    object OrdemProducaoC_NOM_CLI: TWideStringField
      FieldName = 'C_NOM_CLI'
      Origin = 'BASEDADOS.CADCLIENTES.C_NOM_CLI'
      Size = 50
    end
    object OrdemProducaoNOM_COR: TWideStringField
      FieldName = 'NOM_COR'
      Origin = 'BASEDADOS.COR.NOM_COR'
      Size = 50
    end
    object OrdemProducaoNOMEST: TWideStringField
      FieldName = 'NOMEST'
      Origin = 'BASEDADOS.ESTAGIOPRODUCAO.NOMEST'
      Size = 50
    end
    object OrdemProducaoC_NOM_USU: TWideStringField
      FieldName = 'C_NOM_USU'
      Origin = 'BASEDADOS.CADUSUARIOS.C_NOM_USU'
      Size = 60
    end
    object OrdemProducaoSEQFRACAO: TFMTBCDField
      FieldName = 'SEQFRACAO'
      Origin = 'BASEDADOS.FRACAOOP.SEQFRACAO'
    end
    object OrdemProducaoDATIMPRESSAOFICHA: TSQLTimeStampField
      FieldName = 'DATIMPRESSAOFICHA'
      Origin = 'BASEDADOS.FRACAOOP.DATIMPRESSAOFICHA'
    end
    object OrdemProducaoQTDPRODUTO: TFMTBCDField
      FieldName = 'QTDPRODUTO'
      Origin = 'BASEDADOS.FRACAOOP.QTDPRODUTO'
    end
    object OrdemProducaoDATENTREGA: TSQLTimeStampField
      FieldName = 'DATENTREGA'
      Origin = 'BASEDADOS.FRACAOOP.DATENTREGA'
    end
    object OrdemProducaoI_SEQ_PRO: TFMTBCDField
      FieldName = 'I_SEQ_PRO'
      Origin = 'BASEDADOS.CADPRODUTOS.I_SEQ_PRO'
    end
    object OrdemProducaoPRODUTO: TWideStringField
      FieldName = 'PRODUTO'
      Origin = 'BASEDADOS.CADPRODUTOS.C_COD_PRO'
      Size = 71
    end
    object OrdemProducaoQTDAFATURAR: TFMTBCDField
      FieldName = 'QTDAFATURAR'
      Origin = 'BASEDADOS.FRACAOOP.QTDAFATURAR'
    end
    object OrdemProducaoQTDREVISADO: TFMTBCDField
      FieldName = 'QTDREVISADO'
      Origin = 'BASEDADOS.FRACAOOP.QTDREVISADO'
    end
    object OrdemProducaoCODCOR: TFMTBCDField
      FieldName = 'CODCOR'
      Precision = 10
      Size = 0
    end
    object OrdemProducaoC_COD_PRO: TWideStringField
      FieldName = 'C_COD_PRO'
      Size = 50
    end
    object OrdemProducaoC_NOM_PRO: TWideStringField
      FieldName = 'C_NOM_PRO'
      Size = 100
    end
    object OrdemProducaoDESUM: TWideStringField
      FieldName = 'DESUM'
      Size = 2
    end
    object OrdemProducaoUMORIGINAL: TWideStringField
      FieldName = 'UMORIGINAL'
      Size = 2
    end
  end
  object DataOrdemProducao: TDataSource
    DataSet = OrdemProducao
    Left = 48
    Top = 8
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 136
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 8
    object AlterarEstgiosProduto1: TMenuItem
      Caption = 'Alterar Est'#225'gios Produto'
      OnClick = AlterarEstgiosProduto1Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object AlterarCliente1: TMenuItem
      Caption = 'Alterar Cliente'
      OnClick = AlterarCliente1Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object MReimportarProjeto: TMenuItem
      Caption = 'Reimportar Projeto'
      OnClick = ReimportarFrao1Click
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object ConsultaLogSeparao1: TMenuItem
      Caption = 'Consulta Log Separa'#231#227'o'
      OnClick = ConsultaLogSeparao1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ConsultarOramentoCompra1: TMenuItem
      Caption = 'Consultar Or'#231'amento Compra'
      OnClick = ConsultarOramentoCompra1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ConsultarSolicitaoCompras1: TMenuItem
      Caption = 'Consultar Pedido de Compra'
      OnClick = ConsultarSolicitaoCompras1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object GeraOrdemCorte1: TMenuItem
      Caption = 'Gera Ordem Corte'
      OnClick = GeraOrdemCorte1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MGerarConsumo: TMenuItem
      Caption = 'Gerar Consumo'
      OnClick = MGerarConsumoClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object GerarSolicitaoCompras1: TMenuItem
      Caption = 'Gerar Solicita'#231#227'o Compras'
      OnClick = GerarSolicitaoCompras1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ProdutosPendentes1: TMenuItem
      Caption = 'Imprimir Produtos Pendentes'
      OnClick = ProdutosPendentes1Click
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object AdicionarSubmontagememOPExistente1: TMenuItem
      Caption = 'Adicionar Submontagem em OP Existente'
      OnClick = AdicionarSubmontagememOPExistente1Click
    end
  end
  object Aux: TSQL
    Aggregates = <>
    PacketRecords = 30
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    Left = 344
    Top = 8
  end
  object ImageList1: TImageList
    Left = 416
    Top = 8
    Bitmap = {
      494C010107000900700010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      80000000000000000000000000000000000000000000000000000000FF000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000FF000000000000000000000000000000000000FFFF000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      80000000000000000000000000000000000000000000000000000000FF000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000FF000000000000000000000000000000000000FFFF000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000808080000000000000000000000000008080
      80000000000000000000000000000000000000000000000000000000FF000000
      000000FF0000000000000000000000FF000000000000000000000000000000FF
      0000000000000000FF000000000000000000000000000000000000FFFF000000
      000000FF0000000000000000000000FF000000000000000000000000000000FF
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      80000000000000000000000000000000000000000000000000000000FF000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000FF000000000000000000000000000000000000FFFF000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000080808000000000008080
      8000000000000000000000000000000000000000FF000000FF000000FF000000
      000000FF00000000000000000000000000000000000000FF00000000000000FF
      0000000000000000FF000000FF000000000000FFFF0000FFFF0000FFFF000000
      000000FF00000000000000000000000000000000000000FF00000000000000FF
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      800000000000000000000000000000000000000000000000FF000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000FF000000FF000000FF000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000808080000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000FF000000000000000000000000000000000000FFFF000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000080808000808080000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      00000000FF00000000000000000000000000000000000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000080808000808080000000000080808000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000FFFFFF0000000000C0C0C000FFFFFF0000000000FFFFFF00000000000000
      FF0000000000000000000000000000000000000000000000000000FFFF000000
      0000FFFFFF0000000000C0C0C000FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000FF000000
      FF000000FF00000000000000000000000000000000000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000FF000000FF000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF0000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      000000000000000000000000000000FF00000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF00000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FF00000000000000000000000000000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF00000000000000000000000000000000000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000FF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FF00000000000000000000000000000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF00000000000000000000000000000000000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000FF0000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF000000000000FF00000000000000000000000000000000000000FFFF000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF000000000000FFFF00000000000000000000000000000000000000FF000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000FF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FF00000000000000000000000000000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF00000000000000000000000000000000000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000FF0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000000000000000000000FF000000FF000000FF00000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FF000000FF00000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF00000000000000FF000000FF000000FF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000FF000000FF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FF000000FF00000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FF000000FF000000FF00000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF00000000000000FF000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000FF000000FF000000FF000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      00000000000000FF00000000000000000000000000000000000000FFFF000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      00000000000000FFFF00000000000000000000000000000000000000FF000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000FF0000000000000000000000000000000000000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000FFFF0000000000000000000000000000000000000000000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000C0C0C000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF0000000000C0C0C000FFFFFF0000000000FFFFFF000000000000FF
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000FFFFFF0000000000C0C0C000FFFFFF0000000000FFFFFF000000000000FF
      FF000000000000000000000000000000000000000000000000000000FF000000
      0000FFFFFF0000000000C0C0C000FFFFFF0000000000FFFFFF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FF000000FF
      000000FF0000000000000000000000000000000000000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000000
      0000000000000000000000000000000000000000000000FF0000000000000000
      000000FF000000FF00000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      000000FFFF0000FFFF00000000000000000000000000000000000000FF000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000000000000000000000
      00000000000000FF000000FF000000FF00000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      00000000000000FFFF0000FFFF0000FFFF00000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      000000000000000000000000000000FF00000000000000000000000000000000
      000000000000000000000000000000FF000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000FF0000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF00424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFF7EFF7E0000FFFF000100010000
      E007800380030000E007C003C0030000E007C003C0030000E007C003C0030000
      E007C003C0030000E007000100010000E007800080000000E007C003C0030000
      E00FC007C0070000E01FC00FC00F0000E03FC007C0070000E07FC033C0330000
      FFFF803880380000FFFF7EFE7EFE0000FFFFFF7EFF7EFF7EFFFF000100010001
      E007800380038003E007C003C003C003E007C003C003C003E007C003C003C003
      E007C003C003C003E007000100010001E007800080008000E007C003C003C003
      E00FC007C007C007E01FC00FC00FC00FE03FC007C007C007E07FC033C033C033
      FFFF807880388038FFFF7EFE7EFE7EFE00000000000000000000000000000000
      000000000000}
  end
  object FracaoOpSubMontagem: TSQL
    Aggregates = <>
    PacketRecords = 30
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    Left = 504
    Top = 8
  end
  object PopupMenu2: TPopupMenu
    Left = 384
    Top = 8
    object EtiquetasOrdemSerra1: TMenuItem
      Caption = 'Etiquetas Ordem Serra'
      OnClick = EtiquetasOrdemSerra1Click
    end
  end
  object MArvore: TPopupMenu
    Left = 568
    Top = 8
    object AlterarDataEntrega1: TMenuItem
      Caption = 'Alterar Data Entrega'
      OnClick = AlterarDataEntrega1Click
    end
    object AlterarEstagio1: TMenuItem
      Caption = 'Alterar Estagio'
      OnClick = AlterarEstagio1Click
    end
    object ConcluirFrao1: TMenuItem
      Caption = 'Concluir Fra'#231#227'o'
      OnClick = ConcluirFrao1Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object ConsultarFrao1: TMenuItem
      Caption = 'Consultar Fra'#231#227'o'
      OnClick = ConsultarFrao1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object PedidosdeCompra1: TMenuItem
      Caption = 'Pedidos de Compra'
      OnClick = PedidosdeCompra1Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object ReimportarFrao1: TMenuItem
      Caption = 'Reimportar Fra'#231#227'o'
      OnClick = ReimportarFrao1Click
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object ImprimirConsumo1: TMenuItem
      Caption = 'Imprimir Consumo'
      OnClick = ImprimirConsumo1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object MLegenda: TMenuItem
      Caption = 'Legenda'
      OnClick = MLegendaClick
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 464
    Top = 8
    object NumeroOP1: TMenuItem
      Caption = 'Numero OP'
      OnClick = NumeroOP1Click
    end
  end
  object PopupMenu4: TPopupMenu
    Left = 624
    Top = 8
    object SemQuebraPgina1: TMenuItem
      Tag = 2
      Caption = 'Sem Quebra P'#225'gina'
      OnClick = SemQuebraPgina1Click
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object SomenteConsumoaReservar1: TMenuItem
      Caption = 'Somente Consumo a Reservar'
      OnClick = BFichaConsumoClick
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object ListaProdutosaExcluir1: TMenuItem
      Caption = 'Lista Produtos a Excluir'
      OnClick = ListaProdutosaExcluir1Click
    end
  end
end
