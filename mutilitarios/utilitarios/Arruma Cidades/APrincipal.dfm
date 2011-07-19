object Form1: TForm1
  Left = 120
  Top = 110
  Width = 319
  Height = 167
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 112
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Arrumar'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BaseDados: TDatabase
    AliasName = 'SisCorp'
    DatabaseName = 'BaseDados'
    LoginPrompt = False
    Params.Strings = (
      'User Name=DBA'
      'Password=9774')
    SessionName = 'Default'
  end
  object Clientes: TQuery
    DatabaseName = 'BaseDados'
    Left = 48
  end
  object Aux: TQuery
    DatabaseName = 'BaseDados'
    Left = 88
  end
  object Aux1: TQuery
    DatabaseName = 'BaseDados'
    Left = 128
  end
end
