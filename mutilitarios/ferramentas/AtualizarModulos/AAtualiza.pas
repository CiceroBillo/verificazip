unit AAtualiza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ComCtrls, ExtCtrls, DB, DBClient, Tabela, CBancoDados, StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP,IdFTPCommon, Registry, TlHelp32,
  ZipMstr19;

type
  TFAtualiza = class(TFormularioPermissao)
    Panel1: TPanel;
    Progresso: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    LVersaoAtual: TLabel;
    LVersaoDisponivel: TLabel;
    Aux: TRBSQL;
    Modulo: TRBSQL;
    FTP: TIdFTP;
    Label3: TLabel;
    LNomeModulo: TLabel;
    StatusBar1: TStatusBar;
    ZipMaster191: TZipMaster19;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
  private
    { Private declarations }
    procedure ConectaFTP;
    function Atualizar(VpaVersaoDisponivel : Double):Boolean;
    procedure BaixaModulo;
    procedure FechaAplicativoemExecucao;
    function RDiretorioSisCorp : string;
    function RDiretorioServidor : string;
    procedure AtualizaStatus(VpaTexto : string);
    procedure AtualizaVersaoCFG(VpaVersaoDisponivel : Double);
  public
    { Public declarations }
    procedure AtualizaModulo(VpaSeqModulo : Integer;VpaVersaoAtual:Double);
  end;

var
  FAtualiza: TFAtualiza;

implementation

uses APrincipal, FunSql, FunString,FunArquivos, constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFAtualiza.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

procedure TFAtualiza.FTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Progresso.Position := AWorkCount;
  Progresso.Refresh;
end;

{******************************************************************************}
function TFAtualiza.RDiretorioServidor: string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_DIR_VER from CFG_GERAL');
  result := Aux.FieldByName('C_DIR_VER').AsString;
  aux.Close;
end;

function TFAtualiza.RDiretorioSisCorp: string;
var
 VpfIni : TRegIniFile;
begin
  VpfIni := TRegIniFile.Create('Software\Listeners\SisCorp');
  result := VpfIni.ReadString('DIRETORIOS','PATH_SISCORP','C:\Eficacia');
  VpfIni.Free;
end;

{ *************************************************************************** }
procedure TFAtualiza.AtualizaModulo(VpaSeqModulo: Integer;VpaVersaoAtual:Double);
begin
  LVersaoDisponivel.Caption := FloatToStr(VpaVersaoAtual);
  AdicionaSQLAbreTabela(Modulo,'Select * from MODULO ' +
                               ' Where SEQMODULO = '+IntToStr(VpaSeqModulo));
  LNomeModulo.Caption := Modulo.FieldByName('NOMMODULO').AsString;
  if Atualizar(VpaVersaoAtual) then
  begin
    Show;
    BaixaModulo;
    AtualizaVersaoCFG(VpaVersaoAtual);
  end;
end;

{******************************************************************************}
function TFAtualiza.Atualizar(VpaVersaoDisponivel: Double): Boolean;
var
  VpfVersaoAtual : Double;
begin
  AtualizaStatus('Verificando se a versão está desatualizada.');
  AdicionaSQLAbreTabela(Aux,'Select '+Modulo.FieldByName('NOMCAMPOCFG').AsString +
                            ' from CFG_GERAL');
  VpfVersaoAtual  := StrToFloat(SubstituiStr(Aux.FieldByName(Modulo.FieldByName('NOMCAMPOCFG').AsString).AsString,'.',','));
  LVersaoAtual.Caption := FormatFloat('#,###,##0.000',VpfVersaoAtual);
  result := VpaVersaoDisponivel > VpfVersaoAtual;
end;

{******************************************************************************}
procedure TFAtualiza.AtualizaStatus(VpaTexto: string);
begin
  StatusBar1.Panels[0].Text := VpaTexto;
  StatusBar1.Refresh;
  self.Refresh;
end;

{******************************************************************************}
procedure TFAtualiza.AtualizaVersaoCFG(VpaVersaoDisponivel: Double);
begin
  AdicionaSQLAbreTabela(Aux,'Select '+Modulo.FieldByName('NOMCAMPOCFG').AsString +
                            ' from CFG_GERAL ');
  if VpaVersaoDisponivel > StrToFloat(SubstituiStr(Aux.FieldByName(Modulo.FieldByName('NOMCAMPOCFG').AsString).AsString,'.',',')) then
  begin
    Aux.Edit;
    Aux.FieldByName(Modulo.FieldByName('NOMCAMPOCFG').AsString).AsString := SubstituiStr(FloatToStr(VpaVersaoDisponivel),',','.');
    Aux.Post;
    Aux.Close;
  end;

end;

{******************************************************************************}
procedure TFAtualiza.BaixaModulo;
var
  VpfDiretorioSisCorp,VpfDiretorioServidor, VpfNomArquivoExecutavel : String;
begin
  AtualizaStatus('Baixando modulo atualizado');
  Self.Refresh;
  Application.ProcessMessages;
  ConectaFTP;
  VpfDiretorioSisCorp := RDiretorioSisCorp;
  VpfNomArquivoExecutavel := VpfDiretorioSisCorp+'\'+CopiaAteChar(Modulo.FieldByName('NOMARQUIVOFTP').AsString,'.')+'.exe';
  DeletaArquivo(VpfDiretorioSisCorp+'\'+Modulo.FieldByName('NOMARQUIVOFTP').AsString);
  FTP.Get(Modulo.FieldByName('NOMARQUIVOFTP').AsString,VpfDiretorioSisCorp+'\'+MODULO.FieldByName('NOMARQUIVOFTP').AsString,true);
  // transfere um arquivo texto
  FTP.TransferType := ftBinary;
  FTP.Disconnect;
  FechaAplicativoemExecucao;
//  DeletaArquivo(VpfNomArquivoExecutavel);
  ZipMaster191.ExtrOptions := ZipMaster191.ExtrOptions + [ExtrOverwrite];
  ZipMaster191.FSpecArgs.Add('*.*');
  ZipMaster191.ZipFileName := VpfDiretorioSisCorp+'\'+Modulo.FieldByName('NOMARQUIVOFTP').AsString;
  ZipMaster191.ExtrBaseDir := VpfDiretorioSisCorp;
  ZipMaster191.Extract;
  VpfDiretorioServidor := RDiretorioServidor;
  AtualizaStatus('Exluindo arquivo do servidor');
//  DeletaArquivo(VpfDiretorioServidor+'\'+RetornaNomeSemExtensao(VpfNomArquivoExecutavel)+'.exe');
  AtualizaStatus('Copiando arquivo para o servidor');
  ZipMaster191.ExtrBaseDir := VpfDiretorioServidor;
  ZipMaster191.Extract;

//  CopiaArquivo(VpfNomArquivoExecutavel,VpfDiretorioServidor+'\'+RetornaNomeSemExtensao(VpfNomArquivoExecutavel)+'.exe');
end;

{******************************************************************************}
procedure TFAtualiza.ConectaFTP;
var
  VpfLaco : Integer;
begin
  AtualizaStatus('Conectando com o FTP');
  AdicionaSQLAbreTabela(Aux,'Select * from CFG_GERAL');
  FTP.Username := Aux.FieldByName('C_USU_FTE').AsString;
  FTP.Password := Aux.FieldByName('C_SEN_FTE').AsString;
  FTP.Connect;
  if FTP.Connected then
  begin
    // transfere um arquivo texto
    FTP.TransferType := ftBinary;
    FTP.ChangeDir(Aux.FieldByName('C_FTP_EFI').AsString);
    FTP.List;
    for VpfLaco := 0 to ftp.DirectoryListing.Count -1 do
    begin
      if FTP.DirectoryListing.Items[VpfLaco].FileName = Modulo.FieldByName('NOMARQUIVOFTP').AsString then
      begin
        Progresso.Max := FTP.DirectoryListing.Items[VpfLaco].Size;
        break;
      end;
    end;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TFAtualiza.FechaAplicativoemExecucao;
var
  i: Integer;
  bContinue: BOOL;
  NewItem: TListItem;
  VpfSnapshotHandle: THandle;
  VpfProcessEntry32: TProcessEntry32;
  VpfNomAplicativo : string ;
  Ret: BOOL;
  PrID: Integer; // processidentifier
  Ph: THandle;   // processhandle
begin
  VpfNomAplicativo := LowerCase(CopiaAteChar(Modulo.FieldByName('NOMARQUIVOFTP').AsString,'.')+'.exe');

  VpfSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  VpfProcessEntry32.dwSize := SizeOf(VpfProcessEntry32);
  bContinue := Process32First(VpfSnapshotHandle, VpfProcessEntry32);
  while Integer(bContinue) <> 0 do
  begin
    if lowercase(VpfProcessEntry32.szExeFile)= VpfNomAplicativo then
    begin
       PrID := StrToInt('$'+ IntToHex(VpfProcessEntry32.th32ProcessID, 4));
       Ph := OpenProcess(1, BOOL(0), PrID);
       Ret := TerminateProcess(Ph, 0);
    end;
    bContinue := Process32Next(VpfSnapshotHandle, VpfProcessEntry32);
  end;
  CloseHandle(VpfSnapshotHandle);
end;

{******************************************************************************}
procedure TFAtualiza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAtualiza]);
end.
