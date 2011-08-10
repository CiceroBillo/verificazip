object FNovaCotacao: TFNovaCotacao
  Left = 49
  Top = 83
  Hint = 'Gerar cota'#231#227'o de venda'
  HelpContext = 1422
  ActiveControl = ETipoCotacao
  Caption = 'Cota'#231#227'o'
  ClientHeight = 602
  ClientWidth = 816
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Paginas: TPageControl
    Left = 0
    Top = 0
    Width = 816
    Height = 561
    ActivePage = PCotacao
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = PaginasChange
    object PCotacao: TTabSheet
      Caption = 'Cota'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 808
        Height = 530
        HorzScrollBar.Visible = False
        VertScrollBar.Position = 960
        Align = alClient
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        object PCliente: TPanelColor
          Left = 0
          Top = -960
          Width = 787
          Height = 243
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          AUsarCorForm = False
          object LNomeFantasia: TLabel
            Left = 2
            Top = 8
            Width = 349
            Height = 38
            Caption = 'Etik Art Etiquetas Ltda'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -31
            Font.Name = 'Bookman Old Style'
            Font.Style = []
            ParentFont = False
          end
          object Shape8: TShape
            Left = 4
            Top = 51
            Width = 772
            Height = 34
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object Label16: TLabel
            Left = 72
            Top = 57
            Width = 41
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SpeedButton6: TSpeedButton
            Left = 179
            Top = 54
            Width = 27
            Height = 26
            Flat = True
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
          object Label31: TLabel
            Left = 211
            Top = 59
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object LNomComputador: TLabel
            Left = 587
            Top = 1
            Width = 186
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '             '
            Transparent = True
          end
          object ECor: TEditLocaliza
            Left = 480
            Top = 38
            Width = 121
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
            OnEnter = ECorEnter
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
              'Where NOM_COR LIKE '#39'@%'#39)
            APermitirVazio = True
            AInfo.CampoCodigo = 'COD_COR'
            AInfo.CampoNome = 'NOM_COR'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Cor   '
            AInfo.Cadastrar = True
            AInfo.RetornoExtra1 = 'NOM_COR'
            ADarFocoDepoisdoLocaliza = False
            OnCadastrar = ECorCadastrar
            OnRetorno = ECorRetorno
          end
          object ETipoCotacao: TEditLocaliza
            Tag = 100
            Left = 117
            Top = 55
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
            OnChange = ESituacaoChange
            ACampoObrigatorio = True
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label31
            ABotao = SpeedButton6
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from CADTIPOORCAMENTO'
              'where I_COD_TIP = @')
            ASelectLocaliza.Strings = (
              'Select * from CADTIPOORCAMENTO'
              'where C_NOM_TIP LIKE '#39'@%'#39
              'order by C_NOM_TIP')
            APermitirVazio = True
            ASomenteNumeros = True
            AInfo.CampoCodigo = 'I_COD_TIP'
            AInfo.CampoNome = 'C_NOM_TIP'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Nome'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Tipo Cota'#231#227'o   '
            AInfo.Cadastrar = True
            AInfo.RetornoExtra1 = 'C_CLA_PLA'
            AInfo.RetornoExtra2 = 'I_COD_OPE'
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ETipoCotacaoCadastrar
            OnRetorno = ETipoCotacaoRetorno
          end
          object EEmbalagem: TEditLocaliza
            Left = 480
            Top = 62
            Width = 121
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
            OnEnter = EEmbalagemEnter
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from EMBALAGEM'
              'Where COD_EMBALAGEM = @')
            ASelectLocaliza.Strings = (
              'Select * from EMBALAGEM'
              'Where NOM_EMBALAGEM LIKE '#39'@%'#39)
            APermitirVazio = True
            AInfo.CampoCodigo = 'COD_EMBALAGEM'
            AInfo.CampoNome = 'NOM_EMBALAGEM'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Embalagem   '
            AInfo.Cadastrar = True
            AInfo.RetornoExtra1 = 'NOM_EMBALAGEM'
            ADarFocoDepoisdoLocaliza = False
            OnCadastrar = EEmbalagemCadastrar
            OnRetorno = EEmbalagemRetorno
          end
          object PainelTempo1: TPainelTempo
            Left = 176
            Top = 0
            Width = 29
            Height = 29
            Caption = 'T'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Visible = False
            AColorSombra = clBlack
            AColorInicio = clSilver
          end
          object ECorCompose: TEditLocaliza
            Left = 480
            Top = 78
            Width = 121
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
              'Select * from COR'
              'Where COD_COR = @')
            ASelectLocaliza.Strings = (
              'Select * from COR'
              'Where NOM_COR LIKE '#39'@%'#39)
            APermitirVazio = True
            AInfo.CampoCodigo = 'COD_COR'
            AInfo.CampoNome = 'NOM_COR'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Cor   '
            AInfo.Cadastrar = True
            AInfo.RetornoExtra1 = 'NOM_COR'
            ADarFocoDepoisdoLocaliza = False
            OnCadastrar = ECorCadastrar
            OnRetorno = ECorComposeRetorno
          end
          object ETamanho: TEditLocaliza
            Left = 408
            Top = 51
            Width = 65
            Height = 24
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            Visible = False
            OnEnter = ETamanhoEnter
            ACampoObrigatorio = False
            AIgnorarCor = False
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from TAMANHO'
              'Where CODTAMANHO = @')
            ASelectLocaliza.Strings = (
              'Select * from TAMANHO'
              'Where NOMTAMANHO LIKE '#39'@%'#39
              'order by NOMTAMANHO')
            APermitirVazio = True
            AInfo.CampoCodigo = 'CODTAMANHO'
            AInfo.CampoNome = 'NOMTAMANHO'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Tamanho   '
            AInfo.Cadastrar = True
            AInfo.RetornoExtra1 = 'NOMTAMANHO'
            ADarFocoDepoisdoLocaliza = False
            OnCadastrar = ETamanhoCadastrar
            OnRetorno = ETamanhoRetorno
          end
          object PImagem: TPanelColor
            Left = 621
            Top = 0
            Width = 156
            Height = 135
            BevelInner = bvLowered
            Caption = ' '
            Color = clGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            AUsarCorForm = False
            object Shape17: TShape
              Left = 2
              Top = 2
              Width = 152
              Height = 131
              Align = alClient
              Brush.Color = clBlack
              ExplicitLeft = 3
              ExplicitTop = 9
              ExplicitWidth = 161
              ExplicitHeight = 136
            end
            object Foto: TImage
              Left = 2
              Top = 2
              Width = 152
              Height = 131
              Align = alClient
              Center = True
              Stretch = True
              OnDblClick = FotoDblClick
              ExplicitTop = -6
              ExplicitWidth = 157
              ExplicitHeight = 136
            end
          end
          object Panel1: TPanelColor
            Left = 0
            Top = 127
            Width = 787
            Height = 116
            Align = alBottom
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            AUsarCorForm = False
            object Shape1: TShape
              Left = 2
              Top = 2
              Width = 774
              Height = 108
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label1: TLabel
              Left = 71
              Top = 11
              Width = 42
              Height = 16
              Alignment = taRightJustify
              Caption = 'Para :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object SpeedButton1: TSpeedButton
              Left = 179
              Top = 5
              Width = 27
              Height = 26
              Flat = True
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
              Tag = 210
              Left = 209
              Top = 11
              Width = 39
              Height = 13
              Caption = '             '
              Transparent = True
            end
            object LEnderecoCliente: TLabel
              Tag = 220
              Left = 117
              Top = 33
              Width = 73
              Height = 13
              Caption = 'LNomeEmpresa'
              Transparent = True
            end
            object Label5: TLabel
              Left = 51
              Top = 53
              Width = 62
              Height = 16
              Alignment = taRightJustify
              Caption = 'Contato :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label12: TLabel
              Left = 13
              Top = 79
              Width = 100
              Height = 16
              Alignment = taRightJustify
              Caption = 'Ord.  Compra :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object LCNPJ: TLabel
              Tag = 230
              Left = 581
              Top = 11
              Width = 186
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '             '
              Transparent = True
            end
            object Label42: TLabel
              Left = 469
              Top = 79
              Width = 171
              Height = 16
              Alignment = taRightJustify
              Caption = #218'ltima Consulta Serasa :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label59: TLabel
              Left = 444
              Top = 53
              Width = 52
              Height = 16
              Alignment = taRightJustify
              Caption = 'e-mail :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label64: TLabel
              Left = 191
              Top = 78
              Width = 79
              Height = 16
              Alignment = taRightJustify
              Caption = 'Ord. Corte :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object ECliente: TEditLocaliza
              Tag = 200
              Left = 117
              Top = 8
              Width = 60
              Height = 19
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              PopupMenu = MClientes
              TabOrder = 0
              OnChange = ESituacaoChange
              OnExit = EClienteExit
              ACampoObrigatorio = True
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = Label2
              ABotao = SpeedButton1
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select * from cadclientes'
                'where I_Cod_Cli = @'
                'and  c_ind_cli = '#39'S'#39)
              ASelectLocaliza.Strings = (
                'Select * from cadclientes'
                'where c_nom_cli like '#39'@%'#39' '
                'and c_ind_cli = '#39'S'#39)
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
              AInfo.TituloForm = '  Localiza Cliente   '
              AInfo.Cadastrar = True
              AInfo.Alterar = True
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = EClienteCadastrar
              onAlterar = EClienteAlterar
              OnSelect = EClienteSelect
              OnRetorno = EClienteRetorno
            end
            object EContato: TEditColor
              Tag = 300
              Left = 117
              Top = 51
              Width = 226
              Height = 19
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 1
              OnChange = ESituacaoChange
              OnExit = EContatoExit
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EOrdemCompra: TEditColor
              Tag = 500
              Left = 117
              Top = 76
              Width = 69
              Height = 19
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 3
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EConsultaSerasa: TEditColor
              Left = 646
              Top = 76
              Width = 105
              Height = 19
              TabStop = False
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 5
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object CPendenciaSerasa: TCheckBox
              Left = 356
              Top = 79
              Width = 137
              Height = 17
              TabStop = False
              Caption = 'Pend'#234'ncia Serasa'
              Color = 14474718
              ParentColor = False
              TabOrder = 4
            end
            object EEmailContato: TEditColor
              Tag = 400
              Left = 501
              Top = 51
              Width = 249
              Height = 19
              CharCase = ecLowerCase
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 2
              OnChange = ESituacaoChange
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EOrdemCorte: TEditColor
              Tag = 500
              Left = 273
              Top = 76
              Width = 70
              Height = 19
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 6
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
          end
          object PRepresentada: TPanelColor
            Left = 0
            Top = 87
            Width = 787
            Height = 40
            Align = alBottom
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            AUsarCorForm = False
            object Shape20: TShape
              Left = 4
              Top = 1
              Width = 772
              Height = 34
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label61: TLabel
              Left = 5
              Top = 10
              Width = 108
              Height = 16
              Alignment = taRightJustify
              Caption = 'Representada :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object SpeedButton10: TSpeedButton
              Left = 178
              Top = 5
              Width = 27
              Height = 26
              Flat = True
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
            object Label62: TLabel
              Left = 211
              Top = 10
              Width = 39
              Height = 13
              Caption = '             '
              Transparent = True
            end
            object ERepresentada: TRBEditLocaliza
              Left = 117
              Top = 6
              Width = 59
              Height = 22
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = Label62
              ABotao = SpeedButton10
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select CODREPRESENTADA, NOMREPRESENTADA, NOMFANTASIA '
                ' from REPRESENTADA '
                ' Where CODREPRESENTADA = @')
              ASelectLocaliza.Strings = (
                'Select CODREPRESENTADA, NOMREPRESENTADA, NOMFANTASIA '
                ' from REPRESENTADA ')
              APermitirVazio = True
              AColunas = <
                item
                  ATituloColuna = 'C'#243'digo'
                  ATamanhoColuna = 8
                  ACampoFiltro = False
                  ANomeCampo = 'CODREPRESENTADA'
                  AMostrarNaGrade = True
                  AOrdemInicial = False
                end
                item
                  ATituloColuna = 'Nome'
                  ATamanhoColuna = 30
                  ACampoFiltro = True
                  ANomeCampo = 'NOMFANTASIA'
                  AMostrarNaGrade = True
                  AOrdemInicial = True
                end>
              ALocalizaPadrao = lpRepresentada
              ATituloFormulario = '   Localiza Representada   '
            end
          end
        end
        object PRodaPe: TPanelColor
          Left = 0
          Top = 6
          Width = 785
          Height = 912
          Hint = 'Rodape'
          AutoSize = True
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          AUsarCorForm = False
          object PTransportadora: TPanelColor
            Left = 0
            Top = 0
            Width = 785
            Height = 214
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 0
            AUsarCorForm = False
            object Shape7: TShape
              Left = 4
              Top = 2
              Width = 774
              Height = 210
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label15: TLabel
              Left = 13
              Top = 11
              Width = 117
              Height = 16
              Alignment = taRightJustify
              Caption = 'Transportadora :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object SpeedButton4: TSpeedButton
              Left = 196
              Top = 6
              Width = 27
              Height = 26
              Flat = True
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
            object LTransportadora: TLabel
              Left = 225
              Top = 11
              Width = 260
              Height = 16
              AutoSize = False
              Caption = '             '
              Transparent = True
            end
            object Label17: TLabel
              Left = 27
              Top = 89
              Width = 105
              Height = 16
              Alignment = taRightJustify
              Caption = 'Placa Ve'#237'culo :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label18: TLabel
              Left = 393
              Top = 89
              Width = 129
              Height = 16
              Alignment = taRightJustify
              Caption = 'UF Placa Ve'#237'culo :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label19: TLabel
              Left = 48
              Top = 38
              Width = 82
              Height = 16
              Alignment = taRightJustify
              Caption = 'CNPJ/CPF :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label21: TLabel
              Left = 54
              Top = 64
              Width = 76
              Height = 16
              Alignment = taRightJustify
              Caption = 'Endere'#231'o :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label22: TLabel
              Left = 463
              Top = 64
              Width = 59
              Height = 16
              Alignment = taRightJustify
              Caption = 'Cidade :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label23: TLabel
              Left = 412
              Top = 38
              Width = 110
              Height = 16
              Alignment = taRightJustify
              Caption = 'Inscr. estadual :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label24: TLabel
              Left = 712
              Top = 64
              Width = 29
              Height = 16
              Alignment = taRightJustify
              Caption = 'UF :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label26: TLabel
              Left = 264
              Top = 114
              Width = 66
              Height = 16
              Alignment = taRightJustify
              Caption = 'Esp'#233'cie :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label27: TLabel
              Left = 533
              Top = 114
              Width = 52
              Height = 16
              Alignment = taRightJustify
              Caption = 'Marca :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label25: TLabel
              Left = 41
              Top = 114
              Width = 89
              Height = 16
              Alignment = taRightJustify
              Caption = 'Quantidade :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label28: TLabel
              Left = 67
              Top = 139
              Width = 63
              Height = 16
              Alignment = taRightJustify
              Caption = 'N'#250'mero :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label29: TLabel
              Left = 245
              Top = 139
              Width = 85
              Height = 16
              Alignment = taRightJustify
              Caption = 'Peso Bruto :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label30: TLabel
              Left = 485
              Top = 139
              Width = 100
              Height = 16
              Alignment = taRightJustify
              Caption = 'Peso L'#237'quido :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label33: TLabel
              Left = 49
              Top = 163
              Width = 81
              Height = 16
              Alignment = taRightJustify
              Caption = 'Tipo Frete :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label57: TLabel
              Left = 163
              Top = 160
              Width = 54
              Height = 12
              Caption = '1 - Emitente '
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              Transparent = True
            end
            object Label55: TLabel
              Left = 163
              Top = 170
              Width = 64
              Height = 12
              Caption = '2 - Destinat'#225'rio'
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              Transparent = True
            end
            object Label47: TLabel
              Left = 498
              Top = 162
              Width = 86
              Height = 16
              Alignment = taRightJustify
              Caption = 'Valor Frete :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label14: TLabel
              Left = 31
              Top = 188
              Width = 98
              Height = 16
              Alignment = taRightJustify
              Caption = 'Redespacho :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object SpeedButton12: TSpeedButton
              Left = 199
              Top = 183
              Width = 27
              Height = 26
              Flat = True
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
            object Label63: TLabel
              Left = 232
              Top = 188
              Width = 260
              Height = 16
              AutoSize = False
              Caption = '             '
              Transparent = True
            end
            object ETransportadora: TRBEditLocaliza
              Left = 134
              Top = 10
              Width = 59
              Height = 19
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 0
              OnChange = ESituacaoChange
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = LTransportadora
              ABotao = SpeedButton4
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'Select I_COD_CLI, C_NOM_CLI '
                ' from CADCLIENTES '
                ' Where I_COD_CLI = @ AND C_IND_TRA = '#39'S'#39' and C_IND_ATI = '#39'S'#39)
              ASelectLocaliza.Strings = (
                'SELECT I_COD_CLI, C_NOM_CLI '
                ' from CADCLIENTES  Where C_IND_TRA = '#39'S'#39' and C_IND_ATI = '#39'S'#39)
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
                  ATituloColuna = 'Nome'
                  ATamanhoColuna = 50
                  ACampoFiltro = True
                  ANomeCampo = 'C_NOM_CLI'
                  AMostrarNaGrade = True
                  AOrdemInicial = True
                end>
              ALocalizaPadrao = lpTransportadora
              ATituloFormulario = '   Localiza Transportadora   '
              OnCadastrar = ETransportadoraCadastrar
              OnRetorno = ETransportadoraRetorno
            end
            object EPlaVeiculo: TEditColor
              Left = 134
              Top = 86
              Width = 59
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 6
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EUFPlaVeiculo: TEditColor
              Left = 525
              Top = 86
              Width = 28
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 7
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object ECNPJTransportadora: TEditColor
              Left = 134
              Top = 35
              Width = 204
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EEndTransportadora: TEditColor
              Left = 134
              Top = 61
              Width = 324
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object ECidTransportadora: TEditColor
              Left = 525
              Top = 61
              Width = 184
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EIETransportadora: TEditColor
              Left = 525
              Top = 35
              Width = 184
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 2
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EUFTransportadora: TEditColor
              Left = 743
              Top = 61
              Width = 28
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EQtdTransportadora: Tnumerico
              Left = 134
              Top = 111
              Width = 109
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              ADecimal = 0
              AMascara = '0;-0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 8
            end
            object EEspTransportadora: TEditColor
              Left = 333
              Top = 111
              Width = 184
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 9
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EMarTransportadora: TEditColor
              Left = 587
              Top = 111
              Width = 122
              Height = 22
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 10
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object ENumTransportadora: Tnumerico
              Left = 134
              Top = 136
              Width = 109
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              AMascara = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 11
            end
            object EPesoBruto: Tnumerico
              Left = 333
              Top = 136
              Width = 121
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              AMascara = ',0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 12
            end
            object EPesoLiquido: Tnumerico
              Left = 587
              Top = 136
              Width = 121
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              AMascara = ',0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 13
            end
            object ETipFrete: Tnumerico
              Left = 134
              Top = 160
              Width = 28
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              AMascara = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 14
            end
            object EValFrete: Tnumerico
              Left = 588
              Top = 160
              Width = 120
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 15
              OnChange = EDescontoChange
            end
            object ERedespacho: TRBEditLocaliza
              Left = 134
              Top = 186
              Width = 59
              Height = 22
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 16
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = Label63
              ABotao = SpeedButton12
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ASelectValida.Strings = (
                'Select I_COD_CLI, C_NOM_CLI '
                ' from CADCLIENTES '
                ' Where I_COD_CLI = @ AND C_IND_TRA = '#39'S'#39' and C_IND_ATI = '#39'S'#39)
              ASelectLocaliza.Strings = (
                'SELECT I_COD_CLI, C_NOM_CLI '
                ' from CADCLIENTES  Where C_IND_TRA = '#39'S'#39' and C_IND_ATI = '#39'S'#39)
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
                  ATituloColuna = 'Nome'
                  ATamanhoColuna = 50
                  ACampoFiltro = True
                  ANomeCampo = 'C_NOM_CLI'
                  AMostrarNaGrade = True
                  AOrdemInicial = True
                end>
              ALocalizaPadrao = lpTransportadora
              ATituloFormulario = '   Localiza Transportadora   '
            end
          end
          object PObservacao: TPanelColor
            Left = 0
            Top = 571
            Width = 785
            Height = 190
            Align = alTop
            BevelOuter = bvNone
            Caption = 'PObservacao'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 2
            AUsarCorForm = False
            object Shape5: TShape
              Left = 1
              Top = 5
              Width = 774
              Height = 116
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object TLabel
              Left = 19
              Top = 33
              Width = 102
              Height = 16
              Caption = 'Observa'#231#245'es :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Caption15: TLabel
              Left = 568
              Top = 13
              Width = 109
              Height = 16
              Alignment = taRightJustify
              Caption = 'Data Validade :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Visible = False
            end
            object Label13: TLabel
              Left = 18
              Top = 11
              Width = 108
              Height = 16
              Alignment = taRightJustify
              Caption = 'Data Previs'#227'o :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label34: TLabel
              Left = 357
              Top = 11
              Width = 113
              Height = 16
              Alignment = taRightJustify
              Caption = 'Hora  Previs'#227'o :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Shape19: TShape
              Left = 3
              Top = 126
              Width = 772
              Height = 59
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label32: TLabel
              Left = 35
              Top = 136
              Width = 31
              Height = 13
              Caption = 'Valor :'
              Color = 14869218
              ParentColor = False
            end
            object Shape18: TShape
              Left = 82
              Top = 152
              Width = 73
              Height = 1
            end
            object Shape16: TShape
              Left = 652
              Top = 177
              Width = 73
              Height = 1
            end
            object Label60: TLabel
              Left = 507
              Top = 161
              Width = 109
              Height = 13
              Caption = 'Valor Desconto Troca :'
              Color = 14869218
              ParentColor = False
            end
            object EObservacoes: TMemoColor
              Left = 18
              Top = 51
              Width = 753
              Height = 56
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 3
              ACampoObrigatorio = False
            end
            object EDatPrevista: TMaskEditColor
              Left = 129
              Top = 8
              Width = 81
              Height = 22
              Color = 14474718
              Ctl3D = False
              EditMask = '!99/99/00;1;_'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 8
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              Text = '  /  /  '
              ACampoObrigatorio = True
            end
            object EDatValidade: TMaskEditColor
              Left = 680
              Top = 10
              Width = 81
              Height = 22
              Color = 14474718
              Ctl3D = False
              EditMask = '!99/99/00;1;_'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 8
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              Text = '  /  /  '
              Visible = False
              ACampoObrigatorio = True
            end
            object EHorPrevista: TMaskEditColor
              Left = 473
              Top = 8
              Width = 48
              Height = 22
              Color = 14474718
              Ctl3D = False
              EditMask = '!90\:00;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 5
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 2
              Text = '  :  '
              ACampoObrigatorio = True
            end
            object CAcrescimoDesconto: TRadioGroup
              Tag = 3
              Left = 262
              Top = 127
              Width = 209
              Height = 32
              Color = 14869218
              Columns = 2
              Items.Strings = (
                'Acrescimo'
                'Desconto')
              ParentColor = False
              TabOrder = 5
              OnClick = EDescontoChange
            end
            object CValorPercentual: TRadioGroup
              Tag = 3
              Left = 503
              Top = 127
              Width = 225
              Height = 32
              Color = 14869218
              Columns = 2
              Ctl3D = True
              Items.Strings = (
                'Valor'
                'Percentual')
              ParentColor = False
              ParentCtl3D = False
              TabOrder = 6
              OnClick = EDescontoChange
            end
            object EDesconto: Tnumerico
              Tag = 3
              Left = 81
              Top = 135
              Width = 73
              Height = 17
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              AutoSize = False
              BorderStyle = bsNone
              Color = 14869218
              AMascara = ',0.00;- ,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              OnChange = EDescontoChange
            end
            object EValTroca: Tnumerico
              Tag = 3
              Left = 649
              Top = 160
              Width = 73
              Height = 17
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              AutoSize = False
              BorderStyle = bsNone
              Color = 14869218
              AMascara = ',0.00;- ,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              OnChange = EDescontoChange
            end
          end
          object PTecnico: TPanelColor
            Left = 0
            Top = 278
            Width = 785
            Height = 95
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            AUsarCorForm = False
            object Shape10: TShape
              Left = 3
              Top = 3
              Width = 774
              Height = 86
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label38: TLabel
              Left = 65
              Top = 13
              Width = 65
              Height = 16
              Alignment = taRightJustify
              Caption = 'T'#233'cnico :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object SpeedButton8: TSpeedButton
              Left = 196
              Top = 7
              Width = 27
              Height = 26
              Flat = True
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
            object Label40: TLabel
              Left = 225
              Top = 13
              Width = 260
              Height = 16
              AutoSize = False
              Caption = '             '
              Transparent = True
            end
            object Label48: TLabel
              Left = 8
              Top = 38
              Width = 122
              Height = 16
              Alignment = taRightJustify
              Caption = 'End Atendimento:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label49: TLabel
              Left = 48
              Top = 64
              Width = 82
              Height = 16
              Alignment = taRightJustify
              Caption = 'Solicitante :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object ECodTecnico: TEditLocaliza
              Left = 134
              Top = 10
              Width = 59
              Height = 19
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 0
              OnChange = ESituacaoChange
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = Label40
              ABotao = SpeedButton8
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ALocaliza = Localiza
              ASelectValida.Strings = (
                'select * from TECNICO'
                'Where CODTECNICO = @')
              ASelectLocaliza.Strings = (
                'select * from TECNICO'
                'where NOMTECNICO LIKE '#39'@%'#39
                'and INDATIVO  = '#39'S'#39
                'order by NOMTECNICO')
              APermitirVazio = True
              AInfo.CampoCodigo = 'CODTECNICO'
              AInfo.CampoNome = 'NOMTECNICO'
              AInfo.Nome1 = 'C'#243'digo'
              AInfo.Nome2 = 'Nome'
              AInfo.Tamanho1 = 8
              AInfo.Tamanho2 = 40
              AInfo.Tamanho3 = 0
              AInfo.TituloForm = '   Localiza T'#233'cnico   '
              AInfo.Cadastrar = True
              ADarFocoDepoisdoLocaliza = True
              OnCadastrar = ECodTecnicoCadastrar
            end
            object EEnderecoAtendimento: TEditColor
              Left = 133
              Top = 36
              Width = 636
              Height = 22
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object ESolicitante: TEditColor
              Left = 133
              Top = 62
              Width = 636
              Height = 22
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 2
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
          end
          object PObservacaoFiscal: TPanelColor
            Left = 0
            Top = 820
            Width = 785
            Height = 92
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            AUsarCorForm = False
            object Shape12: TShape
              Left = 3
              Top = 2
              Width = 774
              Height = 87
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label46: TLabel
              Left = 19
              Top = 10
              Width = 199
              Height = 16
              Caption = 'Observa'#231#245'es da Nota Fiscal'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object EObservacaoFiscal: TMemoColor
              Left = 18
              Top = 28
              Width = 753
              Height = 45
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 0
              ACampoObrigatorio = False
            end
          end
          object PChamado: TPanelColor
            Left = 0
            Top = 373
            Width = 785
            Height = 198
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            AUsarCorForm = False
            object Shape11: TShape
              Left = 3
              Top = 3
              Width = 774
              Height = 187
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object TLabel
              Left = 19
              Top = 5
              Width = 151
              Height = 16
              Caption = 'Descri'#231#227'o Problema :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label39: TLabel
              Left = 20
              Top = 87
              Width = 116
              Height = 16
              Alignment = taRightJustify
              Caption = 'Valor Chamado :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label41: TLabel
              Left = 506
              Top = 87
              Width = 150
              Height = 16
              Alignment = taRightJustify
              Caption = 'Valor Deslocamento :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object TLabel
              Left = 19
              Top = 112
              Width = 131
              Height = 16
              Caption = 'Servi'#231'o Executado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object EDesProblema: TMemoColor
              Left = 18
              Top = 22
              Width = 753
              Height = 56
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 0
              ACampoObrigatorio = False
            end
            object EValChamado: Tnumerico
              Left = 140
              Top = 85
              Width = 109
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              OnChange = EDescontoChange
            end
            object EValDeslocamento: Tnumerico
              Left = 660
              Top = 85
              Width = 109
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 2
              OnChange = EDescontoChange
            end
            object EServicoExecutado: TMemoColor
              Left = 18
              Top = 129
              Width = 753
              Height = 56
              Color = 14474718
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 3
              ACampoObrigatorio = False
            end
          end
          object PDadosGrafica: TPanelColor
            Left = 0
            Top = 761
            Width = 785
            Height = 59
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            AUsarCorForm = False
            object Shape9: TShape
              Left = 3
              Top = 2
              Width = 774
              Height = 57
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label35: TLabel
              Left = 31
              Top = 10
              Width = 99
              Height = 16
              Alignment = taRightJustify
              Caption = 'Tipo Gr'#225'fica : '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label36: TLabel
              Left = 478
              Top = 10
              Width = 102
              Height = 16
              Alignment = taRightJustify
              Caption = 'Taxa Entrega :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label37: TLabel
              Left = 28
              Top = 34
              Width = 98
              Height = 16
              Alignment = taRightJustify
              Caption = 'Desc. Servi'#231'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CDigital: TRadioButton
              Left = 160
              Top = 11
              Width = 113
              Height = 17
              Caption = 'Digital'
              Color = 14474718
              ParentColor = False
              TabOrder = 0
            end
            object COffSEt: TRadioButton
              Left = 288
              Top = 10
              Width = 113
              Height = 17
              Caption = 'Off-Set'
              Color = 14474718
              ParentColor = False
              TabOrder = 1
            end
            object EValTaxa: Tnumerico
              Left = 587
              Top = 7
              Width = 109
              Height = 22
              ACampoObrigatorio = False
              ANaoUsarCorNegativo = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 2
              OnChange = EDescontoChange
            end
            object EDesServico: TEditColor
              Left = 133
              Top = 32
              Width = 580
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 50
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 3
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
          end
          object PEmbarque: TPanelColor
            Left = 0
            Top = 214
            Width = 785
            Height = 64
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            Visible = False
            AUsarCorForm = False
            object Shape22: TShape
              Left = 3
              Top = 2
              Width = 774
              Height = 61
              Brush.Color = 14474718
              Pen.Style = psDot
              Shape = stRoundRect
            end
            object Label65: TLabel
              Left = 30
              Top = 10
              Width = 104
              Height = 16
              Caption = 'UF Embarque :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label66: TLabel
              Left = 12
              Top = 34
              Width = 122
              Height = 16
              Alignment = taRightJustify
              Caption = 'Local Embarque :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object SpeedButton41: TSpeedButton
              Left = 177
              Top = 7
              Width = 28
              Height = 24
              Flat = True
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
            object Label67: TLabel
              Left = 207
              Top = 11
              Width = 260
              Height = 16
              AutoSize = False
              Caption = '             '
              Transparent = True
            end
            object ELocalEmbarque: TEditColor
              Left = 134
              Top = 33
              Width = 518
              Height = 22
              TabStop = False
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 50
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
            end
            object EUfEmbarque: TRBEditLocaliza
              Left = 134
              Top = 8
              Width = 42
              Height = 22
              Color = 14474718
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              ACampoObrigatorio = False
              AIgnorarCor = True
              ACorFoco = FPrincipal.CorFoco
              AInteiro = 0
              ATexto = Label67
              ABotao = SpeedButton41
              ADataBase = FPrincipal.BaseDados
              ACorForm = FPrincipal.CorForm
              ACorPainelGra = FPrincipal.CorPainelGra
              ASelectValida.Strings = (
                'Select COD_ESTADO, DES_ESTADO, COD_PAIS '
                ' from CAD_ESTADOS '
                ' Where COD_ESTADO = '#39'@'#39)
              ASelectLocaliza.Strings = (
                'Select COD_ESTADO, DES_ESTADO, COD_PAIS '
                ' from CAD_ESTADOS ')
              APermitirVazio = True
              AColunas = <
                item
                  ATituloColuna = 'Sigla'
                  ATamanhoColuna = 5
                  ACampoFiltro = False
                  ANomeCampo = 'COD_ESTADO'
                  AMostrarNaGrade = True
                  AOrdemInicial = False
                end
                item
                  ATituloColuna = 'Nome Estado'
                  ATamanhoColuna = 40
                  ACampoFiltro = True
                  ANomeCampo = 'DES_ESTADO'
                  AMostrarNaGrade = True
                  AOrdemInicial = True
                end
                item
                  ATituloColuna = 'Pa'#237's'
                  ATamanhoColuna = 4
                  ACampoFiltro = False
                  ANomeCampo = 'COD_PAIS'
                  AMostrarNaGrade = True
                  AOrdemInicial = False
                end>
              ALocalizaPadrao = lpUF
              ATituloFormulario = '   Localiza UF '
            end
          end
        end
        object PVendedor: TPanelColor
          Left = 0
          Top = -574
          Width = 787
          Height = 344
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          AUsarCorForm = False
          object Shape4: TShape
            Left = 3
            Top = 82
            Width = 774
            Height = 38
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object Shape3: TShape
            Left = 3
            Top = 127
            Width = 774
            Height = 216
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object Shape2: TShape
            Left = 2
            Top = 3
            Width = 774
            Height = 72
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object LVendedor: TLabel
            Left = 34
            Top = 11
            Width = 77
            Height = 16
            Alignment = taRightJustify
            Caption = 'Vendedor :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object BVendedor: TSpeedButton
            Left = 178
            Top = 6
            Width = 27
            Height = 26
            Flat = True
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
            Left = 208
            Top = 11
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object Label7: TLabel
            Left = 26
            Top = 101
            Width = 269
            Height = 13
            Caption = 'Conforme solicitado, segue cota'#231#227'o do material abaixo :'
            Transparent = True
          end
          object Label8: TLabel
            Left = 562
            Top = 84
            Width = 126
            Height = 16
            Alignment = taRightJustify
            Caption = 'Data da Cota'#231#227'o :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label9: TLabel
            Left = 561
            Top = 101
            Width = 127
            Height = 16
            Alignment = taRightJustify
            Caption = 'Hora da Cota'#231#227'o :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object TLabel
            Left = 19
            Top = 132
            Width = 94
            Height = 16
            Alignment = taRightJustify
            Caption = 'Cond. Pagto :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SpeedButton3: TSpeedButton
            Left = 178
            Top = 129
            Width = 27
            Height = 26
            Flat = True
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
          object Label10: TLabel
            Left = 209
            Top = 134
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object Label11: TLabel
            Left = 40
            Top = 82
            Width = 67
            Height = 16
            Alignment = taRightJustify
            Caption = 'Cota'#231#227'o :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            OnDblClick = Label11DblClick
          end
          object Label20: TLabel
            Left = 15
            Top = 305
            Width = 496
            Height = 16
            Caption = 
              '<Esc> - Cancela | <Delete> - Exclui Registro  |  <F3> -  Localiz' +
              'a  |  <F4> - Alterar Foco '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object TLabel
            Left = 547
            Top = 323
            Width = 86
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor Total :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SpeedButton5: TSpeedButton
            Left = 191
            Top = 318
            Width = 90
            Height = 21
            Caption = 'Parcelas'
            Flat = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
              55555575555555775F55509999999901055557F55555557F75F5001111111101
              105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
              01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
              8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
              0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
              0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
              05555555575FF777755555555500055555555555557775555555}
            NumGlyphs = 2
            OnClick = SpeedButton5Click
          end
          object LPerComissao: TLabel
            Left = 549
            Top = 11
            Width = 152
            Height = 16
            Alignment = taRightJustify
            Caption = 'Percentual Comiss'#227'o:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object LSimboloPercentual: TLabel
            Left = 756
            Top = 11
            Width = 14
            Height = 16
            Alignment = taRightJustify
            Caption = '%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SpeedButton7: TSpeedButton
            Left = 24
            Top = 320
            Width = 149
            Height = 21
            Caption = 'Refer'#234'ncia Cliente'
            Flat = True
            Glyph.Data = {
              16020000424D160200000000000076000000280000003B0000000D0000000100
              040000000000A0010000CE0E0000D80E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0030BBBBB0EE7E
              EE7EE7EE7EE7E0FF0330BBBBB0EE7EEE7EE7EE7EE7E0FF00000030BBBBB07777
              777777777777707F0330BBBBB07777777777777777707F00000030B777B0EE7E
              EE7EE7EE7EE7E07F0330B777B0EE7EEE7EE7EE7EE7E07F00000030B777B0EE7E
              EE7EE7EE7EE7E0FF0330B777B0EE7EEE7EE7EE7EE7E0FF00000030BBBBB00000
              000000000000007F0330BBBBB00000000000000000007F00000030B777B030F7
              7F77F77F0FFF777F0330B777B030F77F77F77F0FFF777F00000030B777B030F7
              7F77F77F0FFFFFFF0330B777B030F77F77F77F0FFFFFFF00000030BBBBB030FF
              FFFFFFFF000000000330BBBBB030FFFFFFFFFF0000000000000030B777B030F7
              7F77F77F033333333330B777B030F77F77F77F0333333330000030B777B030F7
              7F77F77F033333333330B777B030F77F77F77F0333333330000030BBBBB030F7
              7F77F77F033333333330BBBBB030F77F77F77F033333333000003000000030F7
              7F77F77F03333333333000000030F77F77F77F03333333300000333333333000
              0000000003333333333333333330000000000003333333300000}
            NumGlyphs = 2
            OnClick = SpeedButton7Click
          end
          object TLabel
            Left = 293
            Top = 322
            Width = 132
            Height = 16
            Alignment = taRightJustify
            Caption = 'Total c/ Desconto :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object LPreposto: TLabel
            Left = 38
            Top = 35
            Width = 72
            Height = 16
            Alignment = taRightJustify
            Caption = 'Preposto :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object BPreposto: TSpeedButton
            Left = 179
            Top = 31
            Width = 27
            Height = 26
            Flat = True
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
            Left = 209
            Top = 36
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object Label44: TLabel
            Left = 549
            Top = 37
            Width = 152
            Height = 16
            Alignment = taRightJustify
            Caption = 'Percentual Comiss'#227'o:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label45: TLabel
            Left = 756
            Top = 37
            Width = 14
            Height = 16
            Alignment = taRightJustify
            Caption = '%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object LFormaPagamento2: TLabel
            Left = 490
            Top = 132
            Width = 89
            Height = 16
            Alignment = taRightJustify
            Caption = 'Forma Pgto :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SFormaPagamento: TSpeedButton
            Left = 644
            Top = 129
            Width = 27
            Height = 26
            Flat = True
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
          object LFormaPagamento: TLabel
            Left = 675
            Top = 134
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object Label3: TLabel
            Left = 20
            Top = 56
            Width = 91
            Height = 16
            Alignment = taRightJustify
            Caption = 'Origem Ped :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object TLabel
            Left = 527
            Top = 306
            Width = 105
            Height = 16
            Alignment = taRightJustify
            Caption = 'Qtd. Total Pro.:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object EVendedor: TEditLocaliza
            Tag = 600
            Left = 117
            Top = 8
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
            OnChange = ESituacaoChange
            ACampoObrigatorio = True
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = LNomVendedor
            ABotao = BVendedor
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from CadVendedores'
              'where I_Cod_Ven = @'
              'and C_IND_ATI = '#39'S'#39)
            ASelectLocaliza.Strings = (
              'Select * from CadVendedores'
              'where c_nom_Ven like '#39'@%'#39' '
              'and C_IND_ATI = '#39'S'#39
              'order by C_NOM_VEN')
            APermitirVazio = True
            AInfo.CampoCodigo = 'I_Cod_Ven'
            AInfo.CampoNome = 'C_Nom_Ven'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Nome'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Vendedor   '
            AInfo.Cadastrar = True
            AInfo.RetornoExtra1 = 'N_PER_COM'
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = EVendedorCadastrar
            OnRetorno = EVendedorRetorno
          end
          object ENumCotacao: TEditColor
            Left = 111
            Top = 83
            Width = 83
            Height = 22
            TabStop = False
            BorderStyle = bsNone
            Color = 14474718
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 7
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EDataCotacao: TEditColor
            Left = 691
            Top = 84
            Width = 83
            Height = 18
            TabStop = False
            BorderStyle = bsNone
            Color = 14474718
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object EHoraCotacao: TEditColor
            Left = 691
            Top = 101
            Width = 83
            Height = 18
            TabStop = False
            BorderStyle = bsNone
            Color = 14474718
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ECondPagamento: TEditLocaliza
            Left = 117
            Top = 131
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 4
            OnChange = ESituacaoChange
            ACampoObrigatorio = True
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label10
            ABotao = SpeedButton3
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'select * from cadcondicoespagto'
              'where I_Cod_pag = @')
            ASelectLocaliza.Strings = (
              'select * from cadcondicoespagto'
              'where c_nom_pag like '#39'@%'#39' ')
            APermitirVazio = True
            AInfo.CampoCodigo = 'I_Cod_Pag'
            AInfo.CampoNome = 'C_Nom_Pag'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '   Localiza Condi'#231#227'o de Pagamento   '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = ECondPagamentoCadastrar
            OnSelect = ECondPagamentoSelect
            OnRetorno = ECondPagamentoRetorno
          end
          object EValorTotal: TEditColor
            Left = 641
            Top = 322
            Width = 121
            Height = 17
            TabStop = False
            BorderStyle = bsNone
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 10
            ACampoObrigatorio = False
            AIgnorarCor = False
            AInteiro = 0
          end
          object EPerComissao: Tnumerico
            Left = 704
            Top = 9
            Width = 49
            Height = 22
            ACampoObrigatorio = False
            ANaoUsarCorNegativo = False
            Color = 14474718
            Ctl3D = False
            AMascara = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
          end
          object GProdutos: TRBStringGridColor
            Left = 8
            Top = 153
            Width = 765
            Height = 149
            Color = 14474718
            ColCount = 22
            DefaultRowHeight = 20
            DrawingStyle = gdsClassic
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
            TabOrder = 6
            OnEnter = GProdutosEnter
            OnGetEditMask = GProdutosGetEditMask
            OnKeyDown = GProdutosKeyDown
            OnKeyPress = GProdutosKeyPress
            OnSelectCell = GProdutosSelectCell
            ALinha = 0
            AColuna = 1
            AEstadoGrade = egNavegacao
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnGetCellColor = GProdutosGetCellColor
            OnDadosValidos = GProdutosDadosValidos
            OnMudouLinha = GProdutosMudouLinha
            OnNovaLinha = GProdutosNovaLinha
            OnDepoisExclusao = GProdutosDepoisExclusao
            OnCarregaItemGrade = GProdutosCarregaItemGrade
            ColWidths = (
              9
              83
              210
              63
              197
              72
              209
              54
              30
              102
              129
              135
              95
              86
              99
              148
              151
              59
              136
              61
              61
              259)
          end
          object ETotalComDesconto: TEditColor
            Left = 427
            Top = 319
            Width = 109
            Height = 17
            TabStop = False
            BorderStyle = bsNone
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 11
            ACampoObrigatorio = False
            AIgnorarCor = False
            AInteiro = 0
          end
          object ECodPreposto: TEditLocaliza
            Left = 117
            Top = 34
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 2
            OnChange = ESituacaoChange
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label43
            ABotao = BPreposto
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from CadVendedores'
              'where I_Cod_Ven = @'
              'and C_IND_ATI = '#39'S'#39
              'AND C_IND_PRE = '#39'S'#39)
            ASelectLocaliza.Strings = (
              'Select * from CadVendedores'
              'where c_nom_Ven like '#39'@%'#39' '
              'and C_IND_ATI = '#39'S'#39
              'AND C_IND_PRE = '#39'S'#39
              'order by C_NOM_VEN')
            APermitirVazio = True
            AInfo.CampoCodigo = 'I_Cod_Ven'
            AInfo.CampoNome = 'C_Nom_Ven'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Nome'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Vendedor   '
            AInfo.Cadastrar = True
            AInfo.RetornoExtra1 = 'N_PER_PRE'
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = EVendedorCadastrar
            OnRetorno = ECodPrepostoRetorno
          end
          object EComissaoPreposto: Tnumerico
            Left = 704
            Top = 34
            Width = 49
            Height = 22
            ACampoObrigatorio = False
            ANaoUsarCorNegativo = False
            Color = 14474718
            Ctl3D = False
            AMascara = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 3
          end
          object EFormaPagamento: TEditLocaliza
            Left = 583
            Top = 131
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 5
            OnChange = ESituacaoChange
            ACampoObrigatorio = True
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = LFormaPagamento
            ABotao = SFormaPagamento
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'select * from CADFORMASPAGAMENTO'
              'where I_COD_FRM = @')
            ASelectLocaliza.Strings = (
              'select * from CADFORMASPAGAMENTO'
              'where C_NOM_FRM like '#39'@%'#39' '
              'order by C_NOM_FRM')
            APermitirVazio = True
            AInfo.CampoCodigo = 'I_COD_FRM'
            AInfo.CampoNome = 'C_NOM_FRM'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Descri'#231#227'o'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '   Localiza Forma de Pagamento   '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = EFormaPagamentoCadastrar
          end
          object COrigemCliente: TRadioButton
            Left = 117
            Top = 55
            Width = 113
            Height = 17
            Caption = 'Cliente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object COrigemRepresentante: TRadioButton
            Left = 277
            Top = 55
            Width = 124
            Height = 17
            Caption = 'Representante'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object EQtdTotal: TEditColor
            Left = 640
            Top = 307
            Width = 121
            Height = 17
            TabStop = False
            BorderStyle = bsNone
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 14
            ACampoObrigatorio = False
            AIgnorarCor = False
            AInteiro = 0
          end
        end
        object PTabelaPreco: TPanelColor
          Left = 0
          Top = -611
          Width = 787
          Height = 37
          Align = alTop
          BevelOuter = bvNone
          Caption = 'PTabelaPreco'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          AUsarCorForm = False
          object Shape13: TShape
            Left = 3
            Top = 2
            Width = 774
            Height = 34
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object Label50: TLabel
            Left = 30
            Top = 10
            Width = 82
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tab Pre'#231'o :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SpeedButton2: TSpeedButton
            Left = 179
            Top = 5
            Width = 27
            Height = 26
            Flat = True
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
          object Label51: TLabel
            Left = 209
            Top = 10
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object ETabelaPreco: TEditLocaliza
            Left = 117
            Top = 8
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 0
            OnChange = ESituacaoChange
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label51
            ABotao = SpeedButton2
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from CadVendedores'
              'where I_Cod_Ven = @'
              'and C_IND_ATI = '#39'S'#39)
            ASelectLocaliza.Strings = (
              'Select * from CadVendedores'
              'where c_nom_Ven like '#39'@%'#39' '
              'and C_IND_ATI = '#39'S'#39
              'order by C_NOM_VEN')
            APermitirVazio = True
            AInfo.CampoCodigo = 'I_COD_TAB'
            AInfo.CampoNome = 'C_NOM_TAB'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Nome'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza Tabela Pre'#231'o   '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = EVendedorCadastrar
            OnSelect = ETabelaPrecoSelect
          end
        end
        object PServico: TPanelColor
          Left = 0
          Top = -100
          Width = 787
          Height = 134
          Align = alTop
          BevelOuter = bvNone
          Caption = 'PServico'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          AUsarCorForm = False
          object Shape6: TShape
            Left = 3
            Top = 6
            Width = 774
            Height = 123
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object lTextoGradeServico: TLabel
            Left = 14
            Top = 109
            Width = 657
            Height = 16
            Caption = 
              '<Insert> -  Novo Registro  | <Delete> - Exclui Registro  |  <F3>' +
              ' -  Localiza  |  <F4> - Alterar Foco  |  <Esc> - Cancela'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object GServicos: TRBStringGridColor
            Left = 11
            Top = 9
            Width = 748
            Height = 101
            Color = 14474718
            ColCount = 7
            DefaultRowHeight = 20
            DrawingStyle = gdsClassic
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
            TabOrder = 0
            OnGetEditMask = GServicosGetEditMask
            OnKeyDown = GServicosKeyDown
            OnKeyPress = GServicosKeyPress
            OnSelectCell = GServicosSelectCell
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APermiteExcluir = True
            APermiteInserir = True
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GServicosDadosValidos
            OnMudouLinha = GServicosMudouLinha
            OnNovaLinha = GServicosNovaLinha
            OnDepoisExclusao = GProdutosDepoisExclusao
            OnCarregaItemGrade = GServicosCarregaItemGrade
            ColWidths = (
              9
              89
              259
              218
              78
              127
              114)
          end
        end
        object PMedico: TPanelColor
          Left = 0
          Top = -675
          Width = 787
          Height = 64
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          AUsarCorForm = False
          object Shape14: TShape
            Left = 5
            Top = 4
            Width = 774
            Height = 59
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object Label52: TLabel
            Left = 52
            Top = 12
            Width = 60
            Height = 16
            Alignment = taRightJustify
            Caption = 'M'#233'dico :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SpeedButton9: TSpeedButton
            Left = 179
            Top = 7
            Width = 27
            Height = 26
            Flat = True
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
          object Label53: TLabel
            Left = 203
            Top = 11
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object Label54: TLabel
            Left = 522
            Top = 11
            Width = 121
            Height = 16
            Alignment = taRightJustify
            Caption = 'N'#250'mero Receita :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label56: TLabel
            Left = 13
            Top = 37
            Width = 99
            Height = 16
            Alignment = taRightJustify
            Caption = 'Tipo Receita :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label58: TLabel
            Left = 543
            Top = 36
            Width = 100
            Height = 16
            Alignment = taRightJustify
            Caption = 'Data Receita :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object EMedico: TEditLocaliza
            Left = 117
            Top = 9
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
            OnChange = ESituacaoChange
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label53
            ABotao = SpeedButton9
            ADataBase = FPrincipal.BaseDados
            ACorForm = FPrincipal.CorForm
            ACorPainelGra = FPrincipal.CorPainelGra
            ALocaliza = Localiza
            ASelectValida.Strings = (
              'Select * from MEDICO '
              'Where CODMEDICO = @')
            ASelectLocaliza.Strings = (
              'Select * from MEDICO'
              'Where NOMMEDICO LIKE '#39'@%'#39
              'order by NOMMEDICO')
            APermitirVazio = True
            AInfo.CampoCodigo = 'CODMEDICO'
            AInfo.CampoNome = 'NOMMEDICO'
            AInfo.Nome1 = 'C'#243'digo'
            AInfo.Nome2 = 'Nome'
            AInfo.Tamanho1 = 8
            AInfo.Tamanho2 = 40
            AInfo.Tamanho3 = 0
            AInfo.TituloForm = '  Localiza M'#233'dico   '
            AInfo.Cadastrar = True
            ADarFocoDepoisdoLocaliza = True
            OnCadastrar = EMedicoCadastrar
          end
          object ENumReceita: TEditColor
            Left = 648
            Top = 8
            Width = 104
            Height = 19
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 1
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
          end
          object ETipoReceita: TComboBoxColor
            Left = 117
            Top = 33
            Width = 394
            Height = 21
            Style = csDropDownList
            Color = 14474718
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 2
            Items.Strings = (
              'Receita de Controle Especial em 2 vias (Receita Branca)'
              'Notifica'#231#227'o de Receita B (Notifica'#231#227'o Azul)'
              'Notifica'#231#227'o de Receita Especial (Notifica'#231#227'o Branca)'
              'Notifica'#231#227'o de Receita A (Notifica'#231#227'o Amarela)')
            ACampoObrigatorio = False
          end
          object EDatReceita: TMaskEditColor
            Left = 648
            Top = 33
            Width = 103
            Height = 22
            Color = 14474718
            Ctl3D = False
            EditMask = '!99/99/00;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 8
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 3
            Text = '  /  /  '
            ACampoObrigatorio = True
          end
        end
        object PCompose: TPanelColor
          Left = 0
          Top = -230
          Width = 787
          Height = 130
          Align = alTop
          BevelOuter = bvNone
          Caption = 'PServico'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          AUsarCorForm = False
          object Shape15: TShape
            Left = 3
            Top = 5
            Width = 774
            Height = 123
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object TLabel
            Left = 14
            Top = 109
            Width = 657
            Height = 16
            Caption = 
              '<Insert> -  Novo Registro  | <Delete> - Exclui Registro  |  <F3>' +
              ' -  Localiza  |  <F4> - Alterar Foco  |  <Esc> - Cancela'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object GCompose: TRBStringGridColor
            Left = 13
            Top = 9
            Width = 748
            Height = 101
            Color = 14474718
            ColCount = 6
            DefaultRowHeight = 20
            DrawingStyle = gdsClassic
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
            TabOrder = 0
            OnGetEditMask = GComposeGetEditMask
            OnKeyDown = GComposeKeyDown
            OnKeyPress = GComposeKeyPress
            OnSelectCell = GComposeSelectCell
            ALinha = 0
            AColuna = 0
            AEstadoGrade = egNavegacao
            APermiteExcluir = False
            APermiteInserir = False
            APossuiDadosForadaGrade = False
            ReadOnly = False
            OnDadosValidos = GComposeDadosValidos
            OnMudouLinha = GComposeMudouLinha
            OnCarregaItemGrade = GComposeCarregaItemGrade
            ColWidths = (
              9
              69
              67
              256
              79
              227)
          end
        end
        object PClienteFaccionista: TPanelColor
          Left = 0
          Top = -717
          Width = 787
          Height = 42
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          AUsarCorForm = False
          object Shape21: TShape
            Left = 3
            Top = 2
            Width = 774
            Height = 34
            Brush.Color = 14474718
            Pen.Style = psDot
            Shape = stRoundRect
          end
          object Label4: TLabel
            Left = 2
            Top = 11
            Width = 111
            Height = 16
            Alignment = taRightJustify
            Caption = 'Cli Faccionista :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object SpeedButton11: TSpeedButton
            Left = 179
            Top = 6
            Width = 27
            Height = 26
            Flat = True
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
            Left = 212
            Top = 13
            Width = 39
            Height = 13
            Caption = '             '
            Transparent = True
          end
          object EClienteFaccionista: TRBEditLocaliza
            Left = 119
            Top = 10
            Width = 60
            Height = 19
            Color = 14474718
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            ACampoObrigatorio = False
            AIgnorarCor = True
            ACorFoco = FPrincipal.CorFoco
            AInteiro = 0
            ATexto = Label6
            ABotao = SpeedButton11
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
          end
        end
      end
    end
    object PEstagios: TTabSheet
      Caption = 'Est'#225'gios'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter1: TSplitter
        Left = 0
        Top = 317
        Width = 808
        Height = 7
        Cursor = crVSplit
        Align = alBottom
        Beveled = True
        ExplicitTop = 249
        ExplicitWidth = 806
      end
      object PanelColor1: TPanelColor
        Left = 0
        Top = 0
        Width = 808
        Height = 25
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
      end
      object GridIndice1: TGridIndice
        Left = 0
        Top = 25
        Width = 808
        Height = 292
        Align = alClient
        Color = clInfoBk
        DataSource = DataEstagios
        DrawingStyle = gdsClassic
        FixedColor = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        ACorFoco = FPrincipal.CorFoco
        AColunasOrdem = <>
        AindiceInicial = 0
        ALinhaSQLOrderBy = 0
        Columns = <
          item
            Expanded = False
            FieldName = 'SEQESTAGIO'
            Title.Caption = 'Sequencial'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODEST'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMEST'
            Title.Caption = 'Est'#225'gio'
            Width = 214
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATESTAGIO'
            Title.Caption = 'Data'
            Width = 148
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'C_NOM_USU'
            Title.Caption = 'Usu'#225'rio'
            Width = 247
            Visible = True
          end>
      end
      object DBMemoColor1: TDBMemoColor
        Left = 0
        Top = 441
        Width = 808
        Height = 89
        Align = alBottom
        Color = clInfoBk
        DataField = 'DESMOTIVO'
        DataSource = DataEstagios
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ACampoObrigatorio = False
        ACorFoco = FPrincipal.CorFoco
      end
      object DBMemoColor2: TDBMemoColor
        Left = 0
        Top = 324
        Width = 808
        Height = 117
        Align = alBottom
        Color = clInfoBk
        DataField = 'LOGALTERACAO'
        DataSource = DataEstagios
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        ACampoObrigatorio = False
        ACorFoco = FPrincipal.CorFoco
      end
    end
    object PEmails: TTabSheet
      Caption = 'E-Mails'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GEmails: TGridIndice
        Left = 0
        Top = 0
        Width = 808
        Height = 530
        Align = alClient
        Color = clInfoBk
        DataSource = DataORCAMENTOEMAIL
        DrawingStyle = gdsClassic
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
        AColunasOrdem = <>
        AListaIndice.Strings = (
          '0'
          '1'
          '2')
        AListaCAmpos.Strings = (
          'DATEMAIL'
          'DESEMAIL'
          'C_NOM_USU')
        AindiceInicial = 0
        ALinhaSQLOrderBy = 0
        Columns = <
          item
            Expanded = False
            FieldName = 'DATEMAIL'
            Title.Caption = 'Data  [>]'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESEMAIL'
            Title.Caption = 'E-Mail  [+]'
            Width = 362
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'C_NOM_USU'
            Title.Caption = 'Usu'#225'rio  [+]'
            Width = 261
            Visible = True
          end>
      end
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 561
    Width = 816
    Height = 41
    Align = alBottom
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
    object BGravar: TBitBtn
      Left = 198
      Top = 5
      Width = 100
      Height = 30
      HelpContext = 6
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
      Tag = 10
      Left = 296
      Top = 5
      Width = 100
      Height = 30
      HelpContext = 7
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
    object BImprimir: TBitBtn
      Left = 497
      Top = 5
      Width = 100
      Height = 30
      HelpContext = 66
      Caption = 'Imprimir'
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
      PopupMenu = MImpressao
      TabOrder = 2
      OnClick = BImprimirClick
    end
    object BFechar: TBitBtn
      Left = 695
      Top = 5
      Width = 100
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
      TabOrder = 3
      OnClick = BFecharClick
    end
    object BCadastrar: TBitBtn
      Left = 8
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Cadastrar'
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
      PopupMenu = MCadastrar
      TabOrder = 4
      OnClick = BCadastrarClick
    end
    object BGeraCupom: TBitBtn
      Left = 598
      Top = 5
      Width = 97
      Height = 31
      Caption = '&Cupom'
      DoubleBuffered = True
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333FFFFFFFFF333333300000000
        0333333777777777F33333330888888803333337FFFFFFF7F333333307777777
        0333333777777777F33333330FFFFFFF03333337F3F3FFF7F33333330F9F000F
        03333337F7377737F33333330FFFFFFF03333337F3333337F33333330FFFFFFF
        03333337F3FFFFF7F33333330F40004F03333337F77777F7F33333330F00000F
        03333337F7F337F7F33333330F00000F03333337F7FFF7F7F33333330F40004F
        03333337F7777737F33333330FFFFFFF03333337FFFFFFF7F333333300000000
        0333333777777777333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      PopupMenu = MCupom
      TabOrder = 5
      OnClick = BGeraCupomClick
    end
    object BEnviarEmailCliente: TBitBtn
      Left = 398
      Top = 5
      Width = 100
      Height = 30
      HelpContext = 66
      Caption = 'Cliente'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        0000777777777777777707FFFFFFFFFFFF70773FF33333333F770F77FFFFFFFF
        77F07F773FF3333F77370FFF77FFFF77FFF07F33773FFF7733370FFFFF0000FF
        FFF07F333F77773FF3370FFF70EEEE07FFF07F3F773333773FF70F707FFFFFF7
        07F07F77333333337737007EEEEEEEEEE70077FFFFFFFFFFFF77077777777777
        77707777777777777777307EEEEEEEEEE7033773FF333333F77333707FFFFFF7
        0733333773FF33F773333333707EE707333333333773F7733333333333700733
        3333333333377333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      PopupMenu = MEmail
      TabOrder = 6
      OnClick = BEnviarEmailClienteClick
    end
    object BMenuFiscal: TBitBtn
      Left = 111
      Top = 5
      Width = 81
      Height = 30
      HelpContext = 8
      Caption = 'Menu Fiscal'
      DoubleBuffered = True
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 7
      OnClick = BMenuFiscalClick
    end
  end
  object Aux: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = FPrincipal.BaseDados
    Left = 16
    Top = 40
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 88
    Top = 48
  end
  object ValidaUnidade: TValidaUnidade
    ADataBase = FPrincipal.BaseDados
    AInfo.NomeTabelaIndice = 'MOVINDICECONVERSAO'
    AInfo.CampoUnidadeDE = 'C_UNI_ATU'
    AInfo.CampoUnidadePARA = 'C_UNI_COV'
    AInfo.CampoIndice = 'N_IND_COV'
    Left = 120
    Top = 48
  end
  object ValidaGravacao1: TValidaGravacao
    AComponente = ScrollBox1
    ABotaoGravar = BGravar
    Left = 160
    Top = 50
  end
  object CriaParcelas: TCriaParcelasReceber
    AInfo.ConNomeTabelaCondicao = 'CADCONDICOESPAGTO'
    AInfo.ConCampoCodigoCondicao = 'I_COD_PAG'
    AInfo.ConCampoQdadeParcelas = 'I_QTD_PAR'
    AInfo.ConIndiceReajuste = 'N_IND_REA'
    AInfo.ConPercAteVencimento = 'N_PER_DES'
    AInfo.MovConNomeTabela = 'MOVCONDICAOPAGTO'
    AInfo.MovConCampoNumeroParcela = 'I_NRO_PAR'
    AInfo.MovConCampoNumeroDias = 'I_NUM_DIA'
    AInfo.MovConCampoDataFixa = 'D_DAT_FIX'
    AInfo.MOvConCampoDiaFixo = 'I_DIA_FIX'
    AInfo.MovConCampoPercentualCon = 'N_PER_CON'
    AInfo.MovConCampoCreDeb = 'C_CRE_DEB'
    AInfo.MovConCampoPercPagamento = 'N_PER_PAG'
    AInfo.MovConCaracterDebPer = 'D'
    AInfo.MovConCaracterCrePer = 'C'
    Left = 56
    Top = 40
  end
  object MClientes: TPopupMenu
    Left = 210
    Top = 42
    object Trocas1: TMenuItem
      Caption = 'Trocas'
      OnClick = Trocas1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Brindes1: TMenuItem
      Caption = 'Brindes'
      OnClick = Brindes1Click
    end
  end
  object MImpressao: TPopupMenu
    Left = 258
    Top = 42
    object MImprimirOp: TMenuItem
      Caption = '&Autoriza'#231#227'o de Produ'#231#227'o'
      OnClick = MImprimirOpClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object FormurioGarantia1: TMenuItem
      Caption = 'Formu'#225'rio Garantia'
      OnClick = FormurioGarantia1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ChamadoTcnico1: TMenuItem
      Caption = 'Chamado T'#233'cnico'
      OnClick = ChamadoTcnico1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Boleto1: TMenuItem
      Caption = 'Boleto'
      OnClick = Boleto1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Envelope1: TMenuItem
      Caption = 'Envelope'
      OnClick = Envelope1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object SomenteServicos1: TMenuItem
      Caption = 'Somente Servicos'
      OnClick = SomenteServicos1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object EtiquetaCodigodeBarra1: TMenuItem
      Caption = 'Etiqueta do Produto'
      OnClick = EtiquetaCodigodeBarra1Click
    end
    object EtiquetaVolume1: TMenuItem
      Caption = 'Etiqueta Volume'
      OnClick = EtiquetaVolume1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Promissria1: TMenuItem
      Caption = 'Promiss'#243'ria'
      OnClick = Promissria1Click
    end
  end
  object Estagios: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      'select EST.CODEST, EST.NOMEST, ORC.DATESTAGIO, ORC.DESMOTIVO,'
      'USU.C_NOM_USU, ORC.LOGALTERACAO, ORC.SEQESTAGIO'
      ''
      'from ESTAGIOORCAMENTO ORC, ESTAGIOPRODUCAO EST, CADUSUARIOS USU'
      'Where ORC.CODESTAGIO = EST.CODEST'
      'AND ORC.CODFILIAL = USU.I_EMP_FIL'
      'AND ORC.CODUSUARIO = USU.I_COD_USU')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'select EST.CODEST, EST.NOMEST, ORC.DATESTAGIO, ORC.DESMOTIVO,'
      'USU.C_NOM_USU, ORC.LOGALTERACAO, ORC.SEQESTAGIO'
      ''
      'from ESTAGIOORCAMENTO ORC, ESTAGIOPRODUCAO EST, CADUSUARIOS USU'
      'Where ORC.CODESTAGIO = EST.CODEST'
      'AND ORC.CODFILIAL = USU.I_EMP_FIL'
      'AND ORC.CODUSUARIO = USU.I_COD_USU')
    Left = 324
    Top = 43
    object EstagiosCODEST: TFMTBCDField
      FieldName = 'CODEST'
      Origin = 'BASEDADOS.ESTAGIOPRODUCAO.CODEST'
    end
    object EstagiosNOMEST: TWideStringField
      FieldName = 'NOMEST'
      Origin = 'BASEDADOS.ESTAGIOPRODUCAO.NOMEST'
      Size = 50
    end
    object EstagiosDATESTAGIO: TSQLTimeStampField
      FieldName = 'DATESTAGIO'
      Origin = 'BASEDADOS.ESTAGIOORCAMENTO.DATESTAGIO'
    end
    object EstagiosC_NOM_USU: TWideStringField
      FieldName = 'C_NOM_USU'
      Origin = 'BASEDADOS.CADUSUARIOS.C_NOM_USU'
      Size = 60
    end
    object EstagiosDESMOTIVO: TWideStringField
      FieldName = 'DESMOTIVO'
      Origin = 'BASEDADOS.ESTAGIOORCAMENTO.DESMOTIVO'
      Size = 150
    end
    object EstagiosLOGALTERACAO: TWideStringField
      FieldName = 'LOGALTERACAO'
      Origin = 'BASEDADOS.ESTAGIOORCAMENTO.LOGALTERACAO'
      Size = 1
    end
    object EstagiosSEQESTAGIO: TFMTBCDField
      FieldName = 'SEQESTAGIO'
      Required = True
      Precision = 10
      Size = 0
    end
  end
  object DataEstagios: TDataSource
    DataSet = Estagios
    Left = 356
    Top = 43
  end
  object MCadastrar: TPopupMenu
    Left = 320
    Top = 96
    object MAlterar: TMenuItem
      Caption = 'Alterar'
      OnClick = MAlterarClick
    end
  end
  object ORCAMENTOEMAIL: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'SELECT OCE.DATEMAIL, OCE.DESEMAIL, USU.C_NOM_USU'
      'FROM ORCAMENTOEMAIL OCE, CADUSUARIOS USU'
      'WHERE USU.I_COD_USU = OCE.CODUSUARIO')
    Left = 413
    Top = 40
    object ORCAMENTOEMAILDATEMAIL: TSQLTimeStampField
      FieldName = 'DATEMAIL'
      Origin = 'BASEDADOS.ORCAMENTOEMAIL.DATEMAIL'
    end
    object ORCAMENTOEMAILDESEMAIL: TWideStringField
      FieldName = 'DESEMAIL'
      Origin = 'BASEDADOS.ORCAMENTOEMAIL.DESEMAIL'
      Size = 100
    end
    object ORCAMENTOEMAILC_NOM_USU: TWideStringField
      FieldName = 'C_NOM_USU'
      Origin = 'BASEDADOS.CADUSUARIOS.C_NOM_USU'
      Size = 60
    end
  end
  object DataORCAMENTOEMAIL: TDataSource
    DataSet = ORCAMENTOEMAIL
    Left = 445
    Top = 40
  end
  object MCupom: TPopupMenu
    Left = 534
    Top = 45
    object NotaFiscaldeServico1: TMenuItem
      Caption = 'Nota Fiscal de Servico'
    end
  end
  object MEmail: TPopupMenu
    Left = 600
    Top = 112
    object EnviaremailTransportadora1: TMenuItem
      Caption = 'Enviar e-mail Transportadora'
      OnClick = EnviaremailTransportadora1Click
    end
  end
  object Log: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 440
    Top = 160
  end
  object VisualizadorImagem1: TVisualizadorImagem
    Left = 256
    Top = 88
  end
end
