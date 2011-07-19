unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,zlib,
  Db, DBTables, StdCtrls, Componentes1, WideStrings, DBXOracle, SqlExpr, ExtCtrls, PainelGradiente, unSistema;

Const
  NomeModulo = 'Backup dados';
  CampoPermissaoModulo = 'C_MOD_PON';
type
  TFPrincipal = class(TForm)
    BaseDados: TSQLConnection;
    CorForm: TCorForm;
    CorFoco: TCorFoco;
    CorPainelGra: TCorPainelGra;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function AbreBaseDados( Alias : string ) : Boolean;
    procedure CompactaArquivo;
  public
    { Public declarations }
    Function  VerificaPermisao( nome : string ) : Boolean;
    procedure AlteraNomeEmpresa;
    procedure VerificaMoeda;

  end;

var
  FPrincipal: TFPrincipal;

implementation

Uses FunSql, FunObjeto, Constantes, FunArquivos, ACompactador, ConstMsg;

{$R *.DFM}

{******************************************************************************}
procedure TFPrincipal.AlteraNomeEmpresa;
begin

end;

procedure TFPrincipal.CompactaArquivo;
var
  FileIni, FileOut: TFileStream;
  Zip: TCompressionStream;
begin
  FileIni:=TFileStream.Create('C:\pasta\...arquivo a ser comprimido...', fmOpenRead and fmShareExclusive);
  FileOut:=TFileStream.Create('C:\pasta\...arquivo comprimido...', fmCreate or fmShareExclusive);
  Zip:=TCompressionStream.Create(clMax, FileOut);
  Zip.CopyFrom(FileIni, FileIni.Size);
  Zip.Free;
  FileOut.Free;
  FileIni.Free;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
var
  VpfResultado: String;
  VpfUsuarioBD : String;
  VpfNomArquivo : String;
begin
  if ParamStr(1) <> '' then
    VpfUsuarioBD := ParamStr(1)
  else
    VpfUsuarioBD := 'system';

  if AbreBaseDados(VpfUsuarioBD) then
  begin
    varia := TVariaveis.cria(BaseDados);
    config := TConfig.Create;
    ConfigModulos := TConfigModulo.Create;
    carregaCFG(BaseDados);
    if Varia.PathSybase <> '' then
    begin

      NaoExisteCriaDiretorio(Varia.PathBackup,false);

      VpfNomArquivo  := Varia.PathBackup+varia.NomBackup;
      ExecutaArquivoEXE('"'+Varia.PathSybase+'\exp.exe " '+VpfUsuarioBD+'/1298@siscorp file='+VpfNomArquivo,1);
      FCompactador:= TFCompactador.Create(Self);
      VpfResultado:= FCompactador.CompactaArquivo(VpfNomArquivo);
      FCompactador.Free;
      if VpfResultado <> '' then
        aviso(VpfResultado);
      varia.free;
      Config.free;
      ConfigModulos.free;
      Sistema := TRBFuncoesSistema.cria(BaseDados);
      Sistema.AtualizaDataUltimoBackup;
      Sistema.Free;
    end
    else
      aviso('DIRETÓRIO ORACLE NÃO CONFIGURADO!!!'#13'O diretório do oracle não está configurado.');
  end;
  close;
end;

{******************************************************************************}
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
begin
  Result := true;
  BaseDados.close;
  BaseDados.Params.clear;
  BaseDados.Params.add('drivername=Oracle');
  BaseDados.Params.add('Database=SisCorp');
  BaseDados.Params.add('decimal separator=,');
  BaseDados.Params.add('Password=1298');
  if UpperCase(Alias) <> 'SISCORP' then
  begin
    BaseDados.Params.add('User_Name='+Alias);
  end
  else
    BaseDados.Params.add('User_Name=system');
  BaseDados.Open;

end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin
  close;
end;

procedure TFPrincipal.VerificaMoeda;
begin

end;

function TFPrincipal.VerificaPermisao(nome: string): Boolean;
begin
  result := true;
end;

end.

