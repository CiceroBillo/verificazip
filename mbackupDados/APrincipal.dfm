object FPrincipal: TFPrincipal
  Left = 192
  Top = 114
  Caption = 'FPrincipal'
  ClientHeight = 318
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CorPainelGra: TCorPainelGra
    Left = 15
    Top = 56
    Width = 29
    Height = 28
    Alignment = taLeftJustify
    Caption = 'A'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Visible = False
    AEfeitosDeFundos = bdEsquerda
    AColorFim = 16777088
    AColorSombra = clBlack
    AColorInicio = 4227072
    AEfeitosTexto = teContorno
  end
  object BaseDados: TSQLConnection
    ConnectionName = 'BASEDADOSORA'
    DriverName = 'Oracle'
    GetDriverFunc = 'getSQLDriverORACLE'
    LibraryName = 'dbxora.dll'
    LoginPrompt = False
    Params.Strings = (
      'drivername=Oracle'
      'Database=SisCorp'
      'user_name=system'
      'password=1298'
      'rowsetsize=20'
      'blobsize=-1'
      'localecode=0000'
      'oracle transisolation=ReadCommited'
      'os authentication=False'
      'multiple transaction=False'
      'trim char=False'
      'decimal separator=,')
    VendorLib = 'oci.dll'
    Left = 40
    Top = 24
  end
  object CorForm: TCorForm
    ACorFormulario = clSilver
    ACorPainel = clSilver
    AFonteForm.Charset = DEFAULT_CHARSET
    AFonteForm.Color = clWindowText
    AFonteForm.Height = -13
    AFonteForm.Name = 'MS Sans Serif'
    AFonteForm.Style = []
    Left = 78
    Top = 56
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
    ACodigoUsuario = 0
    AGravarConsultaSQl = False
    APermitePercentualConsulta = False
    ATipoLetra = ecNormal
    ACodigoFilial = 0
    ACodigoEmpresa = 0
    AIndVisualizaClientesdoVendedor = False
    Left = 47
    Top = 56
  end
end
