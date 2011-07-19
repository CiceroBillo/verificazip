object FMensagemAtualizando: TFMensagemAtualizando
  Left = 137
  Top = 243
  BorderStyle = bsNone
  Caption = 'FMensagemAtualizando'
  ClientHeight = 135
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 135
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 80
      Width = 456
      Height = 24
      Caption = 'Foi detectado que existe uma nova vers'#227'o do sistema '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 56
      Top = 104
      Width = 451
      Height = 24
      Caption = 'executado. Aguarde enquanto o sistema '#233' atualizado.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Animate1: TAnimate
      Left = 128
      Top = 8
      Width = 272
      Height = 60
      Active = True
      CommonAVI = aviCopyFiles
      StopFrame = 34
    end
  end
end
