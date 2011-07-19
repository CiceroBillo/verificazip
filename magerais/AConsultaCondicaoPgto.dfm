object FConsultaCondicaoPgto: TFConsultaCondicaoPgto
  Left = 0
  Top = 0
  Caption = 'Condi'#231#245'es de Pagamento'
  ClientHeight = 401
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 498
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Condi'#231#245'es de Pagamento   '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = FPrincipal.CorPainelGra
  end
  object PanelColor4: TPanelColor
    Left = 0
    Top = 41
    Width = 498
    Height = 360
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
    object PanelColor3: TPanelColor
      Left = 1
      Top = 318
      Width = 496
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
      TabOrder = 0
      AUsarCorForm = False
      ACorForm = FPrincipal.CorForm
      object BOk: TBitBtn
        Left = 141
        Top = 6
        Width = 100
        Height = 30
        Caption = 'Ok'
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
        OnClick = BOkClick
      end
      object BCancelar: TBitBtn
        Left = 240
        Top = 6
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
        OnClick = BCancelarClick
      end
    end
    object PanelColor2: TPanelColor
      Left = 1
      Top = 158
      Width = 496
      Height = 160
      Align = alBottom
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
      object Label3: TLabel
        Left = 229
        Top = 6
        Width = 115
        Height = 16
        Caption = 'Total Condi'#231#227'o :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 33
        Top = 40
        Width = 118
        Height = 16
        Alignment = taRightJustify
        Caption = 'Forma Pagamento :'
      end
      object SpeedButton2: TSpeedButton
        Left = 229
        Top = 36
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
        Left = 261
        Top = 40
        Width = 57
        Height = 16
        Caption = '                   '
      end
      object Label6: TLabel
        Left = 50
        Top = 70
        Width = 101
        Height = 16
        Alignment = taRightJustify
        Caption = 'Valor a Calcular :'
      end
      object Label7: TLabel
        Left = 85
        Top = 100
        Width = 66
        Height = 16
        Alignment = taRightJustify
        Caption = 'Vendedor :'
      end
      object SpeedButton3: TSpeedButton
        Left = 229
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
      object Label8: TLabel
        Left = 263
        Top = 100
        Width = 57
        Height = 16
        Caption = '                   '
      end
      object Label9: TLabel
        Left = 84
        Top = 130
        Width = 67
        Height = 16
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o :'
      end
      object ETotalCondicao: Tnumerico
        Left = 373
        Top = 2
        Width = 121
        Height = 24
        ACampoObrigatorio = False
        ACorFoco = FPrincipal.CorFoco
        ANaoUsarCorNegativo = False
        Color = clInfoBk
        ADecimal = 3
        AMascara = 'R$ ,0.000;-R$ ,0.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = ETotalCondicaoChange
      end
      object ECodFormaPagamento: TRBEditLocaliza
        Left = 157
        Top = 36
        Width = 71
        Height = 24
        Color = 11661566
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = ECondicaoPagamentoChange
        ACampoObrigatorio = True
        AIgnorarCor = False
        ACorFoco = FPrincipal.CorFoco
        AInteiro = 0
        ATexto = Label5
        ABotao = SpeedButton2
        ADataBase = FPrincipal.BaseDados
        ACorForm = FPrincipal.CorForm
        ACorPainelGra = FPrincipal.CorPainelGra
        ASelectValida.Strings = (
          'Select I_COD_FRM, C_NOM_FRM '
          ' from CADFORMASPAGAMENTO '
          ' Where I_COD_FRM = @')
        ASelectLocaliza.Strings = (
          'Select I_COD_FRM, C_NOM_FRM '
          ' from CADFORMASPAGAMENTO ')
        APermitirVazio = True
        AColunas = <
          item
            ATituloColuna = 'C'#243'digo'
            ATamanhoColuna = 8
            ACampoFiltro = False
            ANomeCampo = 'I_COD_FRM'
            AMostrarNaGrade = True
            AOrdemInicial = False
          end
          item
            ATituloColuna = 'Descri'#231#227'o'
            ATamanhoColuna = 40
            ACampoFiltro = True
            ANomeCampo = 'C_NOM_FRM'
            AMostrarNaGrade = True
            AOrdemInicial = True
          end>
        ALocalizaPadrao = lpFormaPagamento
        ATituloFormulario = '   Localiza Forma Pagamento   '
      end
      object EValorCalcularComissao: Tnumerico
        Left = 157
        Top = 66
        Width = 98
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
        TabOrder = 2
      end
      object EVendedor: TRBEditLocaliza
        Left = 157
        Top = 96
        Width = 71
        Height = 24
        Color = 11661566
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = ECondicaoPagamentoChange
        ACampoObrigatorio = True
        AIgnorarCor = False
        ACorFoco = FPrincipal.CorFoco
        AInteiro = 0
        ATexto = Label8
        ABotao = SpeedButton3
        ADataBase = FPrincipal.BaseDados
        ACorForm = FPrincipal.CorForm
        ACorPainelGra = FPrincipal.CorPainelGra
        ASelectValida.Strings = (
          'Select I_COD_VEN, C_NOM_VEN, N_PER_COM'
          ' from CADVENDEDORES '
          ' Where I_COD_VEN = @'
          ' AND C_IND_ATI = '#39'S'#39)
        ASelectLocaliza.Strings = (
          'Select I_COD_VEN, C_NOM_VEN, N_PER_COM'
          ' from CADVENDEDORES '
          ' Where C_IND_ATI = '#39'S'#39)
        APermitirVazio = True
        AColunas = <
          item
            ATituloColuna = 'C'#243'digo'
            ATamanhoColuna = 8
            ACampoFiltro = False
            ANomeCampo = 'I_COD_VEN'
            AMostrarNaGrade = True
            AOrdemInicial = False
          end
          item
            ATituloColuna = 'Nome'
            ATamanhoColuna = 40
            ACampoFiltro = True
            ANomeCampo = 'C_NOM_VEN'
            AMostrarNaGrade = True
            AOrdemInicial = False
          end
          item
            ATituloColuna = 'Comissao'
            ATamanhoColuna = 40
            ACampoFiltro = False
            ANomeCampo = 'N_PER_COM'
            AMostrarNaGrade = False
            AOrdemInicial = True
          end>
        ALocalizaPadrao = lpPersonalizado
        ATituloFormulario = '   Localiza Vendedor   '
        OnRetorno = EVendedorRetorno
      end
      object EPercComissaoVen: Tnumerico
        Left = 157
        Top = 126
        Width = 98
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
        TabOrder = 4
      end
    end
    object PanelColor1: TPanelColor
      Left = 1
      Top = 1
      Width = 496
      Height = 30
      Align = alTop
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
      object Label1: TLabel
        Left = 16
        Top = 6
        Width = 137
        Height = 16
        Alignment = taRightJustify
        Caption = 'Condi'#231#227'o Pagamento :'
      end
      object SpeedButton1: TSpeedButton
        Left = 227
        Top = 0
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
      object Label2: TLabel
        Left = 258
        Top = 8
        Width = 57
        Height = 16
        Caption = '                   '
      end
      object ECondicaoPagamento: TRBEditLocaliza
        Left = 156
        Top = 1
        Width = 71
        Height = 24
        Color = 11661566
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = ECondicaoPagamentoChange
        ACampoObrigatorio = True
        AIgnorarCor = False
        ACorFoco = FPrincipal.CorFoco
        AInteiro = 0
        ATexto = Label2
        ABotao = SpeedButton1
        ADataBase = FPrincipal.BaseDados
        ACorForm = FPrincipal.CorForm
        ACorPainelGra = FPrincipal.CorPainelGra
        ASelectValida.Strings = (
          'Select I_COD_PAG, C_NOM_PAG '
          ' from CADCONDICOESPAGTO '
          ' Where I_COD_PAG = @')
        ASelectLocaliza.Strings = (
          'Select I_COD_PAG, C_NOM_PAG '
          ' from CADCONDICOESPAGTO ')
        APermitirVazio = True
        AColunas = <
          item
            ATituloColuna = 'C'#243'digo'
            ATamanhoColuna = 8
            ACampoFiltro = False
            ANomeCampo = 'I_COD_PAG'
            AMostrarNaGrade = True
            AOrdemInicial = False
          end
          item
            ATituloColuna = 'Descri'#231#227'o'
            ATamanhoColuna = 40
            ACampoFiltro = True
            ANomeCampo = 'C_NOM_PAG'
            AMostrarNaGrade = True
            AOrdemInicial = True
          end>
        ALocalizaPadrao = lpCondicaoPagamento
        ATituloFormulario = '   Localiza Condi'#231#227'o Pagamento   '
        OnCadastrar = ECondicaoPagamentoCadastrar
        OnFimConsulta = ECondicaoPagamentoFimConsulta
      end
    end
    object GridCondicao: TStringGrid
      Left = 1
      Top = 31
      Width = 496
      Height = 127
      Align = alClient
      Color = clInfoBk
      ColCount = 3
      DefaultRowHeight = 20
      FixedCols = 0
      TabOrder = 3
      ColWidths = (
        118
        147
        169)
    end
  end
  object CriaParcelas: TCriaParcelasReceber
    ADataBase = FPrincipal.BaseDados
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
    Left = 368
    Top = 16
  end
  object ValidaGravacao1: TValidaGravacao
    AComponente = PanelColor4
    ABotaoGravar = BOk
    Left = 304
    Top = 16
  end
end
