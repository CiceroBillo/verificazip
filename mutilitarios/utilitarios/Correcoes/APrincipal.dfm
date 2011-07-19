object FPrincipal: TFPrincipal
  Left = 183
  Top = 68
  Width = 349
  Height = 562
  Caption = 'Comandos 1.1v'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 4
    Top = 8
    Width = 73
    Height = 16
    Caption = 'Período de :'
  end
  object Label2: TLabel
    Left = 180
    Top = 8
    Width = 25
    Height = 16
    Caption = 'até :'
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 48
    Width = 281
    Height = 41
    Hint = 
      'Exclui o contas a receber conforme o período selecionado e gera ' +
      'novamente a partir da cotação (Perído de: até)'
    Caption = 'Regerar Comissão e C.R. Cotação'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object EDatInicio: TCalendario
    Left = 80
    Top = 4
    Width = 97
    Height = 24
    CalAlignment = dtaLeft
    Date = 38568.4108481597
    Time = 38568.4108481597
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
  end
  object EDatFim: TCalendario
    Left = 208
    Top = 4
    Width = 97
    Height = 24
    CalAlignment = dtaLeft
    Date = 38568.4108794444
    Time = 38568.4108794444
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object BarraStatus: TStatusBar
    Left = 0
    Top = 509
    Width = 341
    Height = 19
    Panels = <
      item
        Width = 300
      end>
    SimplePanel = False
  end
  object CorPainelGra: TCorPainelGra
    Left = 24
    Top = 8
    Width = 29
    Height = 29
    Alignment = taLeftJustify
    Caption = 'A'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Visible = False
    AEfeitosDeFundos = bdEsquerda
    AColorSombra = clBlack
    AColorInicio = 16744448
    AEfeitosTexto = teContorno
  end
  object tempo: TPainelTempo
    Left = 112
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
    TabOrder = 5
    Visible = False
    AColorSombra = clBlack
    AColorInicio = clSilver
  end
  object BitBtn2: TBitBtn
    Left = 40
    Top = 96
    Width = 281
    Height = 41
    Hint = 
      'Exclui o contas a receber conforme o período selecionado e gera ' +
      'novamente a partir da cotação (Perído de: até)'
    Caption = 'UM produto m3'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 40
    Top = 152
    Width = 281
    Height = 41
    Hint = 
      'Exclui o contas a receber conforme o período selecionado e gera ' +
      'novamente a partir da cotação (Perído de: até)'
    Caption = 'Corrige Condição Pagamento'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 40
    Top = 208
    Width = 281
    Height = 41
    Hint = 
      'Exclui o contas a receber conforme o período selecionado e gera ' +
      'novamente a partir da cotação (Perído de: até)'
    Caption = 'Adiciona 3 nos Telefones'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = BitBtn4Click
  end
  object BitBtn5: TBitBtn
    Left = 40
    Top = 264
    Width = 281
    Height = 41
    Hint = 'Nomes Cliente Minusculo'
    Caption = 'Nomes Cliente Minusculo'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = BitBtn5Click
  end
  object BitBtn6: TBitBtn
    Left = 40
    Top = 312
    Width = 281
    Height = 41
    Hint = 'Nomes Cliente Minusculo'
    Caption = 'Contato Financeiro'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = BitBtn6Click
  end
  object BitBtn7: TBitBtn
    Left = 40
    Top = 362
    Width = 281
    Height = 41
    Hint = 'Nomes Cliente Minusculo'
    Caption = 'Corrige Estoque Feldmann'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    Visible = False
    OnClick = BitBtn7Click
  end
  object BitBtn8: TBitBtn
    Left = 40
    Top = 418
    Width = 281
    Height = 41
    Hint = 'Nomes Cliente Minusculo'
    Caption = 'Reprocessa contratos'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = BitBtn8Click
  end
  object BitBtn9: TBitBtn
    Left = 40
    Top = 466
    Width = 281
    Height = 41
    Hint = 'Nomes Cliente Minusculo'
    Caption = 'Importa CEP correios'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = BitBtn9Click
  end
  object BaseDados: TDatabase
    AliasName = 'SisCorp'
    DatabaseName = 'BaseDados'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=DBA'
      'PASSWORD=9774')
    SessionName = 'Default'
    Top = 176
  end
  object Aux: TQuery
    DatabaseName = 'BaseDados'
    Left = 72
    Top = 176
  end
  object Orcamentos: TQuery
    DatabaseName = 'BaseDados'
    RequestLive = True
    Left = 144
    Top = 176
  end
  object CorForm: TCorForm
    ACorFormulario = clSilver
    ACorPainel = clSilver
    AFonteForm.Charset = DEFAULT_CHARSET
    AFonteForm.Color = clWindowText
    AFonteForm.Height = -13
    AFonteForm.Name = 'MS Sans Serif'
    AFonteForm.Style = []
    Left = 48
  end
  object CorFoco: TCorFoco
    ACorFundoFoco = clWhite
    ACorObrigatorio = 11661566
    ACorFonteFoco = clBlack
    AFonteComponentes.Charset = DEFAULT_CHARSET
    AFonteComponentes.Color = clBlue
    AFonteComponentes.Height = -13
    AFonteComponentes.Name = 'MS Sans Serif'
    AFonteComponentes.Style = []
    AFundoComponentes = clInfoBk
    AFonteTituloGrid.Charset = DEFAULT_CHARSET
    AFonteTituloGrid.Color = clBlue
    AFonteTituloGrid.Height = -13
    AFonteTituloGrid.Name = 'MS Sans Serif'
    AFonteTituloGrid.Style = []
    ACorTituloGrid = clSilver
    AcorNegativo = clBlack
    AMascaraData = '!99\/99\/0000;1;'
    Left = 80
  end
  object BaseEndereco: TDatabase
    AliasName = 'Endereco'
    DatabaseName = 'BaseEndereco'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=DBA'
      'PASSWORD=SQL')
    SessionName = 'Default'
    Left = 32
    Top = 176
  end
  object Tabela: TQuery
    DatabaseName = 'BaseDados'
    Left = 184
    Top = 176
  end
  object MovOrcamentos: TQuery
    DatabaseName = 'BaseDados'
    Left = 224
    Top = 184
  end
  object CEPCorreios: TQuery
    DatabaseName = 'C:\instaladores\CEP'
    Left = 16
    Top = 136
  end
  object Endereco: TQuery
    DatabaseName = 'BaseEndereco'
    RequestLive = True
    Left = 256
    Top = 112
  end
  object AuxEndereco: TQuery
    DatabaseName = 'BaseEndereco'
    Left = 288
    Top = 112
  end
end
