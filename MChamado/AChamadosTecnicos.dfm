object FChamadoTecnico: TFChamadoTecnico
  Left = 70
  Top = 133
  Caption = 'Chamado T'#233'cnico'
  ClientHeight = 452
  ClientWidth = 919
  Color = clBtnFace
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
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 255
    Width = 919
    Height = 6
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    ExplicitTop = 210
    ExplicitWidth = 774
  end
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 919
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Chamados T'#233'cnicos   '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = FPrincipal.CorPainelGra
  end
  object PanelColor1: TPanelColor
    Left = 0
    Top = 41
    Width = 919
    Height = 144
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
    object Label1: TLabel
      Left = 440
      Top = 7
      Width = 73
      Height = 16
      Caption = 'Per'#237'odo de :'
    end
    object Label2: TLabel
      Left = 632
      Top = 8
      Width = 25
      Height = 16
      Caption = 'at'#233' :'
    end
    object Label3: TLabel
      Left = 27
      Top = 7
      Width = 65
      Height = 16
      Caption = 'Chamado :'
    end
    object Label4: TLabel
      Left = 44
      Top = 33
      Width = 47
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cliente :'
    end
    object SpeedButton1: TSpeedButton
      Left = 156
      Top = 29
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
    object LNomCliente: TLabel
      Left = 186
      Top = 33
      Width = 249
      Height = 16
      AutoSize = False
      Caption = '                   '
    end
    object Label6: TLabel
      Left = 393
      Top = 58
      Width = 121
      Height = 16
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o Chamado :'
    end
    object Label8: TLabel
      Left = 36
      Top = 60
      Width = 55
      Height = 16
      Alignment = taRightJustify
      Caption = 'T'#233'cnico :'
    end
    object SpeedButton3: TSpeedButton
      Left = 156
      Top = 56
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
    object LNomTecnico: TLabel
      Left = 186
      Top = 60
      Width = 249
      Height = 16
      AutoSize = False
      Caption = '                   '
    end
    object Label10: TLabel
      Left = 435
      Top = 33
      Width = 77
      Height = 16
      Alignment = taRightJustify
      Caption = 'Per'#237'odo por :'
    end
    object Label11: TLabel
      Left = 419
      Top = 86
      Width = 96
      Height = 16
      Alignment = taRightJustify
      Caption = 'Tipo Chamado :'
    end
    object SpeedButton5: TSpeedButton
      Left = 580
      Top = 82
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
    object LTipoChamado: TLabel
      Left = 611
      Top = 86
      Width = 51
      Height = 16
      Caption = '                 '
    end
    object LNomEstagio: TLabel
      Left = 184
      Top = 86
      Width = 48
      Height = 16
      Caption = '                '
    end
    object SpeedButton2: TSpeedButton
      Left = 155
      Top = 82
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
      Left = 39
      Top = 86
      Width = 52
      Height = 16
      Alignment = taRightJustify
      Caption = 'Est'#225'gio :'
    end
    object Label7: TLabel
      Left = 481
      Top = 113
      Width = 34
      Height = 16
      Alignment = taRightJustify
      Caption = 'Filial :'
    end
    object SpeedButton4: TSpeedButton
      Left = 580
      Top = 109
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
    object LFilial: TLabel
      Left = 611
      Top = 113
      Width = 51
      Height = 16
      Caption = '                 '
    end
    object EDatInicio: TCalendario
      Left = 520
      Top = 3
      Width = 105
      Height = 24
      Date = 39090.804953703700000000
      Time = 39090.804953703700000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnCloseUp = EChamadoExit
      OnExit = EChamadoExit
      ACorFoco = FPrincipal.CorFoco
    end
    object EDatFim: TCalendario
      Left = 664
      Top = 3
      Width = 105
      Height = 24
      Date = 39090.804953703700000000
      Time = 39090.804953703700000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnCloseUp = EChamadoExit
      OnExit = EChamadoExit
      ACorFoco = FPrincipal.CorFoco
    end
    object EChamado: Tnumerico
      Left = 96
      Top = 3
      Width = 85
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
      TabOrder = 0
      OnExit = EChamadoExit
      OnKeyDown = ECodEstagioKeyDown
    end
    object ECliente: TEditLocaliza
      Left = 96
      Top = 29
      Width = 59
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
      ATexto = LNomCliente
      ABotao = SpeedButton1
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from CadClientes '
        'Where I_Cod_cli = @'
        'and c_ind_cli = '#39'S'#39)
      ASelectLocaliza.Strings = (
        'Select * from CadClientes '
        'Where C_Nom_Cli like '#39'@%'#39
        'and c_ind_cli = '#39'S'#39
        'order by C_NOM_CLI')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_Cod_cli'
      AInfo.CampoNome = 'C_Nom_Cli'
      AInfo.CampoMostra3 = 'C_CID_CLI'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Nome3 = 'Cidade'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 30
      AInfo.TituloForm = '   Localiza Cliente   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EChamadoExit
    end
    object ETecnico: TEditLocaliza
      Left = 96
      Top = 56
      Width = 59
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
      ATexto = LNomTecnico
      ABotao = SpeedButton3
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from TECNICO '
        'Where CODTECNICO = @')
      ASelectLocaliza.Strings = (
        'Select * from TECNICO'
        'Where NOMTECNICO like '#39'@%'#39
        'order by NOMTECNICO')
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'CODTECNICO'
      AInfo.CampoNome = 'NOMTECNICO'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Nome'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza T'#233'cnico   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EChamadoExit
    end
    object ETipoPeriodo: TComboBoxColor
      Left = 520
      Top = 29
      Width = 249
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
      OnChange = EChamadoExit
      Items.Strings = (
        'Data do Chamado'
        'Previs'#227'o de Atendimento')
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
    end
    object ETipoChamado: TEditLocaliza
      Left = 521
      Top = 82
      Width = 58
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnChange = ETipoChamadoChange
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = LTipoChamado
      ABotao = SpeedButton5
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from TIPOCHAMADO'
        'Where CODTIPOCHAMADO = @')
      ASelectLocaliza.Strings = (
        'Select * from TIPOCHAMADO'
        'Where NOMTIPOCHAMADO like '#39'@%'#39)
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'CODTIPOCHAMADO'
      AInfo.CampoNome = 'NOMTIPOCHAMADO'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Tipo Chamado   '
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EChamadoExit
    end
    object CPesquisa: TCheckBox
      Left = 96
      Top = 106
      Width = 321
      Height = 17
      Caption = 'Somente Pesquisa de Satisfa'#231#227'o n'#227'o realizada'
      TabOrder = 8
      OnClick = EChamadoExit
    end
    object ECodEstagio: TEditLocaliza
      Left = 95
      Top = 82
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
      OnKeyDown = ECodEstagioKeyDown
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = LNomEstagio
      ABotao = SpeedButton2
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where CODEST = @'
        'and TIPEST = '#39'A'#39)
      ASelectLocaliza.Strings = (
        'Select * from ESTAGIOPRODUCAO'
        'Where NOMEST Like '#39'@%'#39
        'and TIPEST = '#39'A'#39
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
      OnFimConsulta = EChamadoExit
    end
    object CEstagio: TComboBoxColor
      Left = 520
      Top = 54
      Width = 249
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 6
      Text = 'Todos'
      OnChange = EChamadoExit
      Items.Strings = (
        'Todos'
        'Somente N'#227'o Finalizados'
        'Somente Finalizados')
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
    end
    object EFilial: TEditLocaliza
      Left = 521
      Top = 110
      Width = 58
      Height = 24
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnChange = ETipoChamadoChange
      ACampoObrigatorio = False
      AIgnorarCor = False
      ACorFoco = FPrincipal.CorFoco
      AInteiro = 0
      ATexto = LFilial
      ABotao = SpeedButton4
      ADataBase = FPrincipal.BaseDados
      ACorForm = FPrincipal.CorForm
      ACorPainelGra = FPrincipal.CorPainelGra
      ALocaliza = Localiza
      ASelectValida.Strings = (
        'Select * from CADFILIAIS'
        'Where I_EMP_FIL = @')
      ASelectLocaliza.Strings = (
        'Select * from CADFILIAIS'
        'Where C_NOM_FIL like '#39'@%'#39)
      APermitirVazio = True
      ASomenteNumeros = True
      AInfo.CampoCodigo = 'I_EMP_FIL'
      AInfo.CampoNome = 'C_NOM_FIL'
      AInfo.Nome1 = 'C'#243'digo'
      AInfo.Nome2 = 'Descri'#231#227'o'
      AInfo.Tamanho1 = 8
      AInfo.Tamanho2 = 40
      AInfo.Tamanho3 = 0
      AInfo.TituloForm = '   Localiza Filiais'
      ADarFocoDepoisdoLocaliza = True
      OnFimConsulta = EChamadoExit
    end
  end
  object Grade: TGridIndice
    Left = 0
    Top = 185
    Width = 919
    Height = 70
    Align = alClient
    Color = clInfoBk
    DataSource = DataChamadoTecnico
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
    OnDrawColumnCell = GradeDrawColumnCell
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
      '11')
    AListaCAmpos.Strings = (
      'CHA.NUMCHAMADO'
      'CHA.DATCHAMADO'
      'CHA.DATPREVISAO'
      'TIC.NOMTIPOCHAMADO'
      'CLI.C_NOM_CLI'
      'TEC.NOMTECNICO'
      'EST.NOMEST'
      'CHA.LANORCAMENTO')
    AindiceInicial = 0
    ALinhaSQLOrderBy = 0
    OnOrdem = GradeOrdem
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMCHAMADO'
        Title.Caption = 'Chamado  [>]'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATCHAMADO'
        Title.Caption = 'Data Chamado  [+]'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATPREVISAO'
        Title.Caption = 'Previs'#227'o Atend.  [+]'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMTIPOCHAMADO'
        Title.Caption = 'Tipo Chamado  [+]'
        Width = 131
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C_NOM_CLI'
        Title.Caption = 'Cliente  [+]'
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMTECNICO'
        Title.Caption = 'T'#233'cnico  [+]'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEST'
        Title.Caption = 'Est'#225'gio  [+]'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMSOLICITANTE'
        Title.Caption = 'Solicitante'
        Width = 242
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALCHAMADO'
        Title.Caption = 'Valor Chamado'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALDESLOCAMENTO'
        Title.Caption = 'Val Deslocamento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C_NOM_USU'
        Title.Caption = 'Usu'#225'rio'
        Width = 238
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LANORCAMENTO'
        Title.Caption = 'Cota'#231#227'o  [+]'
        Visible = True
      end>
  end
  object PanelColor3: TPanelColor
    Left = 0
    Top = 261
    Width = 919
    Height = 191
    Align = alBottom
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
    object GridIndice1: TGridIndice
      Left = 1
      Top = 1
      Width = 917
      Height = 71
      Align = alTop
      Color = clInfoBk
      DataSource = DataChamadoProduto
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
      AindiceInicial = 0
      ALinhaSQLOrderBy = 0
      Columns = <
        item
          Expanded = False
          FieldName = 'C_NOM_PRO'
          Title.Caption = 'Produto'
          Width = 204
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESUM'
          Title.Caption = 'UM'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDPRODUTO'
          Title.Caption = 'Quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDBAIXADO'
          Title.Caption = 'Qtd Baixado'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPOCONTRATO'
          Title.Caption = 'Contrato'
          Width = 178
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMSERIE'
          Title.Caption = 'S'#233'rie'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESSETOR'
          Title.Caption = 'Setor'
          Width = 146
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATGARANTIA'
          Title.Caption = 'Garantia'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMCONTADOR'
          Title.Caption = ']'
          Visible = True
        end>
    end
    object DBMemoColor1: TDBMemoColor
      Left = 1
      Top = 72
      Width = 917
      Height = 52
      Align = alClient
      Color = clInfoBk
      DataField = 'DESPROBLEMA'
      DataSource = DataChamadoProduto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ACampoObrigatorio = False
      ACorFoco = FPrincipal.CorFoco
    end
    object PanelColor2: TPanelColor
      Left = 1
      Top = 124
      Width = 917
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
        Left = 107
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
        Left = 200
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
        Left = 299
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
        TabOrder = 3
        OnClick = BExcluirClick
      end
      object BImprimir: TBitBtn
        Left = 398
        Top = 6
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
        PopupMenu = MImprimir
        TabOrder = 4
        OnClick = BImprimirClick
      end
      object BFechar: TBitBtn
        Left = 730
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
        TabOrder = 5
        OnClick = BFecharClick
      end
      object BGerarCotacao: TBitBtn
        Left = 497
        Top = 5
        Width = 120
        Height = 30
        Caption = 'Gerar Cota'#231#227'o'
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
        TabOrder = 6
        OnClick = BGerarCotacaoClick
      end
      object BGraficos: TBitBtn
        Left = 200
        Top = 34
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
        TabOrder = 7
        OnClick = BGraficosClick
      end
      object BImplantacao: TBitBtn
        Left = 299
        Top = 34
        Width = 100
        Height = 30
        Caption = '&Implanta'#231#227'o'
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
        OnClick = BImplantacaoClick
      end
      object BAgenda: TBitBtn
        Left = 398
        Top = 34
        Width = 100
        Height = 30
        Caption = '&Agenda'
        DoubleBuffered = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333300000000000000000FF8FF8FF8FF8FF009F89F89F8FF8FF0088888888888
          88800FF8FF8FF8FF8FF009F89F89F89F89F008888888888888800FF8FF8FF8FF
          8FF009F89F89F89F89F008888888888888800FFFFF8FF8FF8FF00FFFFF89F89F
          89F00000000000000000CCCCCC7777CCCCCCCCCCCCCCCCCCCCCC}
        ParentDoubleBuffered = False
        TabOrder = 9
        OnClick = BAgendaClick
      end
    end
  end
  object PGraficos: TCorPainelGra
    Left = 352
    Top = 33
    Width = 193
    Height = 243
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
      Width = 189
      Height = 222
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
      object Label17: TLabel
        Left = 214
        Top = 87
        Width = 57
        Height = 16
        Caption = '                   '
      end
      object Label12: TLabel
        Left = 214
        Top = 50
        Width = 51
        Height = 16
        Caption = '                 '
      end
      object BMeioDivulgacao: TBitBtn
        Left = 1
        Top = 1
        Width = 189
        Height = 30
        Caption = '&T'#233'cnico'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = BMeioDivulgacaoClick
      end
      object BFechaGrafico: TBitBtn
        Left = 1
        Top = 190
        Width = 189
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
        TabOrder = 4
        OnClick = BFechaGraficoClick
      end
      object BVendedor: TBitBtn
        Left = 1
        Top = 30
        Width = 189
        Height = 30
        Caption = '&Tipo Chamado'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = BVendedorClick
      end
      object BProduto: TBitBtn
        Left = 1
        Top = 154
        Width = 189
        Height = 30
        Caption = '&Data Chamado'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        Visible = False
        OnClick = BProdutoClick
      end
      object BitBtn1: TBitBtn
        Left = 9
        Top = 154
        Width = 189
        Height = 30
        Caption = '&Previs'#227'o Atendimento'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 6
        Visible = False
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 1
        Top = 154
        Width = 189
        Height = 30
        Caption = '&Dia Semana Data Chamado'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 7
        Visible = False
        OnClick = BitBtn2Click
      end
      object BitBtn3: TBitBtn
        Left = 9
        Top = 154
        Width = 189
        Height = 30
        Caption = '&Dia Semana Previs'#227'o Atend.'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 8
        Visible = False
        OnClick = BitBtn3Click
      end
      object BData: TBitBtn
        Left = 1
        Top = 60
        Width = 189
        Height = 30
        Caption = '&Est'#225'gio'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 3
        OnClick = BDataClick
      end
      object BEstado: TBitBtn
        Left = 1
        Top = 89
        Width = 189
        Height = 30
        Caption = '&Cidade'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 5
        OnClick = BEstadoClick
      end
      object BitBtn5: TBitBtn
        Left = 0
        Top = 118
        Width = 189
        Height = 30
        Caption = '&Produto'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 9
        OnClick = BitBtn5Click
      end
      object BitBtn6: TBitBtn
        Left = 0
        Top = 154
        Width = 189
        Height = 30
        Caption = '&Hora'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 10
        Visible = False
        OnClick = BitBtn6Click
      end
    end
  end
  object ChamadoTecnico: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    AfterScroll = ChamadoTecnicoAfterScroll
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQL.Strings = (
      
        'select  CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.DATCHAMADO, CHA.DATPR' +
        'EVISAO, CHA.NOMSOLICITANTE,'
      
        '           CHA.VALCHAMADO, CHA.VALDESLOCAMENTO, CHA.CODESTAGIO, ' +
        'CHA.LANORCAMENTO,'
      '          CHA.CODTECNICO,'
      '          CLI.C_NOM_CLI,  CLI.I_COD_CLI,'
      '    TEC.NOMTECNICO,'
      '   USU.C_NOM_USU,'
      '  EST.NOMEST, EST.INDFIN,'
      '  TIC.NOMTIPOCHAMADO'
      ''
      
        'from CHAMADOCORPO CHA, CADCLIENTES CLI, TECNICO TEC, CADUSUARIOS' +
        ' USU, ESTAGIOPRODUCAO EST,'
      '        TIPOCHAMADO TIC'
      ''
      'Where CHA.CODCLIENTE = CLI.I_COD_CLI'
      'AND CHA.CODTECNICO = TEC.CODTECNICO'
      'AND CHA.CODUSUARIO = USU.I_COD_USU'
      'AND CHA.CODESTAGIO = EST.CODEST'
      'AND CHA.CODTIPOCHAMADO = TIC.CODTIPOCHAMADO')
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select  CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.DATCHAMADO, CHA.DATPR' +
        'EVISAO, CHA.NOMSOLICITANTE,'
      
        '           CHA.VALCHAMADO, CHA.VALDESLOCAMENTO, CHA.CODESTAGIO, ' +
        'CHA.LANORCAMENTO,'
      '          CHA.CODTECNICO,'
      '          CLI.C_NOM_CLI,  CLI.I_COD_CLI,'
      '    TEC.NOMTECNICO,'
      '   USU.C_NOM_USU,'
      '  EST.NOMEST, EST.INDFIN,'
      '  TIC.NOMTIPOCHAMADO'
      ''
      
        'from CHAMADOCORPO CHA, CADCLIENTES CLI, TECNICO TEC, CADUSUARIOS' +
        ' USU, ESTAGIOPRODUCAO EST,'
      '        TIPOCHAMADO TIC'
      ''
      'Where CHA.CODCLIENTE = CLI.I_COD_CLI'
      'AND CHA.CODTECNICO = TEC.CODTECNICO'
      'AND CHA.CODUSUARIO = USU.I_COD_USU'
      'AND CHA.CODESTAGIO = EST.CODEST'
      'AND CHA.CODTIPOCHAMADO = TIC.CODTIPOCHAMADO')
    object ChamadoTecnicoCODFILIAL: TFMTBCDField
      FieldName = 'CODFILIAL'
      Origin = 'BASEDADOS.CHAMADOCORPO.CODFILIAL'
    end
    object ChamadoTecnicoNUMCHAMADO: TFMTBCDField
      FieldName = 'NUMCHAMADO'
      Origin = 'BASEDADOS.CHAMADOCORPO.NUMCHAMADO'
    end
    object ChamadoTecnicoDATCHAMADO: TSQLTimeStampField
      FieldName = 'DATCHAMADO'
      Origin = 'BASEDADOS.CHAMADOCORPO.DATCHAMADO'
    end
    object ChamadoTecnicoDATPREVISAO: TSQLTimeStampField
      FieldName = 'DATPREVISAO'
      Origin = 'BASEDADOS.CHAMADOCORPO.DATPREVISAO'
    end
    object ChamadoTecnicoNOMSOLICITANTE: TWideStringField
      FieldName = 'NOMSOLICITANTE'
      Origin = 'BASEDADOS.CHAMADOCORPO.NOMSOLICITANTE'
      Size = 50
    end
    object ChamadoTecnicoVALCHAMADO: TFMTBCDField
      FieldName = 'VALCHAMADO'
      Origin = 'BASEDADOS.CHAMADOCORPO.VALCHAMADO'
      currency = True
    end
    object ChamadoTecnicoVALDESLOCAMENTO: TFMTBCDField
      FieldName = 'VALDESLOCAMENTO'
      Origin = 'BASEDADOS.CHAMADOCORPO.VALDESLOCAMENTO'
      currency = True
    end
    object ChamadoTecnicoC_NOM_CLI: TWideStringField
      FieldName = 'C_NOM_CLI'
      Origin = 'BASEDADOS.CADCLIENTES.C_NOM_CLI'
      Size = 50
    end
    object ChamadoTecnicoNOMTECNICO: TWideStringField
      FieldName = 'NOMTECNICO'
      Origin = 'BASEDADOS.TECNICO.NOMTECNICO'
      Size = 50
    end
    object ChamadoTecnicoC_NOM_USU: TWideStringField
      FieldName = 'C_NOM_USU'
      Origin = 'BASEDADOS.CADUSUARIOS.C_NOM_USU'
      Size = 60
    end
    object ChamadoTecnicoNOMEST: TWideStringField
      FieldName = 'NOMEST'
      Origin = 'BASEDADOS.ESTAGIOPRODUCAO.NOMEST'
      Size = 50
    end
    object ChamadoTecnicoCODESTAGIO: TFMTBCDField
      FieldName = 'CODESTAGIO'
      Origin = 'BASEDADOS.CHAMADOCORPO.CODESTAGIO'
    end
    object ChamadoTecnicoCODTECNICO: TFMTBCDField
      FieldName = 'CODTECNICO'
      Origin = 'BASEDADOS.CHAMADOCORPO.CODTECNICO'
    end
    object ChamadoTecnicoNOMTIPOCHAMADO: TWideStringField
      FieldName = 'NOMTIPOCHAMADO'
      Origin = 'BASEDADOS.TIPOCHAMADO.NOMTIPOCHAMADO'
      Size = 50
    end
    object ChamadoTecnicoLANORCAMENTO: TFMTBCDField
      FieldName = 'LANORCAMENTO'
      Origin = 'BASEDADOS.CHAMADOCORPO.LANORCAMENTO'
    end
    object ChamadoTecnicoINDFIN: TWideStringField
      FieldName = 'INDFIN'
      FixedChar = True
      Size = 1
    end
    object ChamadoTecnicoI_COD_CLI: TFMTBCDField
      FieldName = 'I_COD_CLI'
      Required = True
      Precision = 10
      Size = 0
    end
  end
  object DataChamadoTecnico: TDataSource
    DataSet = ChamadoTecnico
    Left = 32
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 204
  end
  object ChamadoProduto: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    OnCalcFields = ChamadoProdutoCalcFields
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      
        'select CHP.SEQITEM, CHP.SEQPRODUTO,  CHP.NUMCONTADOR, CHP.NUMSER' +
        'IE, CHP.NUMSERIEINTERNO, CHP.DESSETOR, CHP.DATGARANTIA,'
      
        'CHP.DESPROBLEMA, CHP.CODFILIALCONTRATO, CHP.DESUM, CHP.QTDPRODUT' +
        'O, CHP.QTDBAIXADO,'
      'PRO.C_NOM_PRO,'
      'COC.SEQCONTRATO, COC.CODTIPOCONTRATO '
      'from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO COC '
      'Where CHP.SEQPRODUTO = PRO.I_SEQ_PRO'
      'AND CHP.SEQCONTRATO *= COC.SEQCONTRATO'
      'AND CHP.CODFILIALCONTRATO *= COC.CODFILIAL')
    Left = 64
    object ChamadoProdutoSEQITEM: TFMTBCDField
      FieldName = 'SEQITEM'
    end
    object ChamadoProdutoSEQPRODUTO: TFMTBCDField
      FieldName = 'SEQPRODUTO'
    end
    object ChamadoProdutoNUMCONTADOR: TFMTBCDField
      FieldName = 'NUMCONTADOR'
    end
    object ChamadoProdutoNUMSERIE: TWideStringField
      FieldName = 'NUMSERIE'
    end
    object ChamadoProdutoNUMSERIEINTERNO: TWideStringField
      FieldName = 'NUMSERIEINTERNO'
      Size = 30
    end
    object ChamadoProdutoDESSETOR: TWideStringField
      FieldName = 'DESSETOR'
      Size = 30
    end
    object ChamadoProdutoDATGARANTIA: TSQLTimeStampField
      FieldName = 'DATGARANTIA'
    end
    object ChamadoProdutoC_NOM_PRO: TWideStringField
      FieldName = 'C_NOM_PRO'
      Size = 50
    end
    object ChamadoProdutoSEQCONTRATO: TFMTBCDField
      FieldName = 'SEQCONTRATO'
    end
    object ChamadoProdutoCODTIPOCONTRATO: TFMTBCDField
      FieldName = 'CODTIPOCONTRATO'
    end
    object ChamadoProdutoTIPOCONTRATO: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TIPOCONTRATO'
      Size = 50
      Calculated = True
    end
    object ChamadoProdutoDESPROBLEMA: TWideStringField
      FieldName = 'DESPROBLEMA'
      Size = 1
    end
    object ChamadoProdutoCODFILIALCONTRATO: TFMTBCDField
      FieldName = 'CODFILIALCONTRATO'
    end
    object ChamadoProdutoDESUM: TWideStringField
      FieldName = 'DESUM'
      Size = 2
    end
    object ChamadoProdutoQTDPRODUTO: TFMTBCDField
      FieldName = 'QTDPRODUTO'
    end
    object ChamadoProdutoQTDBAIXADO: TFMTBCDField
      FieldName = 'QTDBAIXADO'
    end
  end
  object DataChamadoProduto: TDataSource
    DataSet = ChamadoProduto
    Left = 96
  end
  object PopupMenu1: TPopupMenu
    Left = 136
    object EfetuarPesquisaSatisfao1: TMenuItem
      Caption = 'Efetuar Pesquisa Satisfa'#231#227'o'
      OnClick = EfetuarPesquisaSatisfao1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MAlterarEstagio: TMenuItem
      Caption = 'Alterar Est'#225'gio'
      OnClick = MAlterarEstagioClick
    end
    object TMenuItem
      Caption = '-'
    end
    object AlteraCliente1: TMenuItem
      Caption = 'Altera Cliente'
      OnClick = AlteraCliente1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object GerarProposta1: TMenuItem
      Caption = 'Gerar Proposta'
      OnClick = GerarProposta1Click
    end
    object ConsultaPropostas1: TMenuItem
      Caption = 'Consulta Propostas'
      OnClick = ConsultaPropostas1Click
    end
    object GerarPropostaProdutosExtras1: TMenuItem
      Caption = 'Gerar Proposta Produtos Extras'
      OnClick = GerarPropostaProdutosExtras1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object SeparaoProdutos1: TMenuItem
      Caption = 'Separa'#231#227'o Produtos'
      OnClick = SeparaoProdutos1Click
    end
    object ConsultaSeparaoProdutos1: TMenuItem
      Caption = 'Consulta Separa'#231#227'o Produtos'
      OnClick = ConsultaSeparaoProdutos1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object RetornoProdutos1: TMenuItem
      Caption = 'Retorno Produtos'
      OnClick = RetornoProdutos1Click
    end
    object ConsultaRetornoProdutos1: TMenuItem
      Caption = 'Consulta Retorno Produtos'
      OnClick = ConsultaRetornoProdutos1Click
    end
    object EnviarEmailBoleto1: TMenuItem
      Caption = 'Enviar E-mail Cliente'
      OnClick = EnviarEmailBoleto1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object GeraSolicitaodeCompras1: TMenuItem
      Caption = 'Gera Solicita'#231#227'o de Compras'
      OnClick = GeraSolicitaodeCompras1Click
    end
    object ConsultarSolicitao1: TMenuItem
      Caption = 'Consulta Solicita'#231#227'o de Compras'
      OnClick = ConsultarSolicitao1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ImprimeProdutosPendentesaProduzir1: TMenuItem
      Caption = 'Imprime Produtos Pendentes a Produzir'
      OnClick = ImprimeProdutosPendentesaProduzir1Click
    end
  end
  object GraficosTrio: TGraficosTrio
    ADataBase = FPrincipal.BaseDados
    AConfiguracoes = FPrincipal.CorPainelGra
    Left = 248
    Top = 1
  end
  object MImprimir: TPopupMenu
    Left = 296
    object Chamadoc1: TMenuItem
      Caption = 'Chamado com Observa'#231#245'es do Cliente'
      OnClick = Chamadoc1Click
    end
    object ImprimirSolicitacaoProducao1: TMenuItem
      Caption = 'Imprimir Solicitacao Producao'
      OnClick = ImprimirSolicitacaoProducao1Click
    end
  end
end
