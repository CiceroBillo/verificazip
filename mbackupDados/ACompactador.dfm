object FCompactador: TFCompactador
  Left = 192
  Top = 103
  Caption = 'Por favor, Aguarde!'
  ClientHeight = 90
  ClientWidth = 337
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object Gauge1: TGauge
    Left = 8
    Top = 25
    Width = 321
    Height = 41
    Progress = 0
  end
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 321
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Aguarde enquanto o sistema compacta o backup.'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 41
    Height = 16
    Caption = 'Label2'
  end
  object ZM: TZipMaster19
    AddOptions = []
    AddStoreSuffixes = [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR, assJPG, assJPEG, ass7Zp, assMP3, assWMV, assWMA, assDVR, assAVI]
    ConfirmErase = False
    DLL_Load = False
    ExtrOptions = []
    KeepFreeOnAllDisks = 0
    KeepFreeOnDisk1 = 0
    MaxVolumeSize = 0
    MaxVolumeSizeKb = 0
    NoReadAux = False
    OnProgress = ZMProgress
    SFXOptions = []
    SFXOverwriteMode = ovrAlways
    SpanOptions = []
    Trace = False
    Unattended = False
    Verbose = False
    Version = '1.9.0.0102'
    WriteOptions = []
    Left = 128
    Top = 50
  end
  object FTP: TIdFTP
    OnWork = FTPWork
    IPVersion = Id_IPv4
    Host = 'ftp.eficaciaconsultoria.com.br'
    Password = 'rafael12'
    Username = 'eficaciaconsultoria1'
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 232
    Top = 32
  end
  object Aux: TSQL
    Aggregates = <>
    Params = <>
    ProviderName = 'InternalProvider'
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    Left = 296
    Top = 40
  end
end
