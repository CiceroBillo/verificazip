unit ACompactador;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, StdCtrls, IdBaseComponent, IdZLibCompressorBase,
  IdCompressorZLib, ZipMstr19, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTPCommon, IdFTP, DB, DBClient, Tabela;

type
  TFCompactador = class(TForm)
    Gauge1: TGauge;
    Label1: TLabel;
    Label2: TLabel;
    ZM: TZipMaster19;
    FTP: TIdFTP;
    Aux: TSQL;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZMProgress(Sender: TObject; details: TZMProgressDetails);
    procedure FTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
  private
    procedure AtualizaStatus(VpaTexto : string);
    procedure ConectaFTP;
    procedure EnviaArquivoFTP(VpaNomArquivo : string);
    function VenceuPrazoEnvioBackup : boolean;
    procedure AtualizaDataUltimoEnvio;
  public
    function CompactaArquivo(VpaNomArquivo : String): String;
  end;

var
  FCompactador: TFCompactador;

implementation
uses
  Constantes, FunArquivos,FunData, APrincipal, Funsql;

{$R *.DFM}

{******************************************************************************}
procedure TFCompactador.AtualizaDataUltimoEnvio;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CFG_GERAL');
  Aux.Edit;
  aux.FieldByName('D_ENV_BAC').AsDateTime := date;
  Aux.Post;
end;

{******************************************************************************}
procedure TFCompactador.AtualizaStatus(VpaTexto: string);
begin
  Label1.Caption:= VpaTexto;
  Label1.Refresh;
end;

{******************************************************************************}
function TFCompactador.CompactaArquivo(VpaNomArquivo : String): String;
var
  VpfArquivoBackup,VpfArquivoSencundario: String;
begin
  Result:= '';
  Show;
  Label1.Caption:= 'Compactando o arquivo';
  VpfArquivoBackup := VpaNomArquivo+FormatDateTime('YYMMDD HHMMSS',now)+'.zip';
  Label2.Caption:= VpfArquivoBackup;
  ZM.ZipFileName := VpfArquivoBackup;
  ZM.FSpecArgs.Add(VpaNomArquivo+'.DMP');
  ZM.Add;
  Label1.Caption:= 'Copiando o arquivo para o destino.';
  if Varia.PathSecundarioBackup <> '' then
  begin
    NaoExisteCriaDiretorio(Varia.PathSecundarioBackup,false);
    VpfArquivoSencundario :=Varia.PathSecundarioBackup+RetornaNomArquivoSemDiretorio(VpfArquivoBackup);
    Label1.Caption:= 'Copiando o arquivo para o destino.';
    CopyFile(PChar(VpfArquivoBackup),PChar(VpfArquivoSencundario),False);
  end;
  EnviaArquivoFTP(VpfArquivoBackup);
  Close;
end;

{******************************************************************************}
procedure TFCompactador.ConectaFTP;
begin
  AtualizaStatus('Conectando com o FTP');
  FTP.Username := VARIA.UsuarioFTPEficacia;
  FTP.Password := varia.SenhaFTPEficacia;
  FTP.Connect;
  if FTP.Connected then
  begin
    // transfere um arquivo texto
    FTP.TransferType := ftBinary;
    FTP.ChangeDir(varia.DiretorioFTPEficacia+'Dados/');
  end;
end;

{******************************************************************************}
procedure TFCompactador.EnviaArquivoFTP(VpaNomArquivo: string);
begin
  if config.EnviarBackupFTPEficacia then
  begin
    if VenceuPrazoEnvioBackup then
    begin
      ConectaFTP;
      AtualizaStatus('Enviando arquivo FTP');
      Gauge1.MaxValue := TamanhoArquivoByte(VpaNomArquivo);
      FTP.Put(VpaNomArquivo,RetornaNomArquivoSemDiretorio(VpaNomArquivo));
      FTP.Disconnect;
      AtualizaDataUltimoEnvio;
    end;
  end;
end;

{******************************************************************************}
procedure TFCompactador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFCompactador.FTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Gauge1.Progress := AWorkCount;
  Gauge1.Refresh;
  self.Refresh;
end;

{******************************************************************************}
function TFCompactador.VenceuPrazoEnvioBackup: boolean;
begin
  result := false;
  case varia.PeriodicidadeEnvioBackup of
    peDiario : result := DiasPorPeriodo(Varia.DatUltimoEnvioBackupEficacia,date) >=1;
    peSemanal : result := DiasPorPeriodo(Varia.DatUltimoEnvioBackupEficacia,date) >=7;
    peQuinzenal : result := DiasPorPeriodo(Varia.DatUltimoEnvioBackupEficacia,date) >=15;
    peMensal : result := MesesPorPeriodo(Varia.DatUltimoEnvioBackupEficacia,date) >=1;
  end;
end;

{******************************************************************************}
procedure TFCompactador.ZMProgress(Sender: TObject; details: TZMProgressDetails);
begin
  Gauge1.Progress := details.ItemPerCent
end;

{******************************************************************************}

end.
