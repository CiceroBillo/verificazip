unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXOracle, DB, SqlExpr, DBClient, Tabela, CBancoDados, StdCtrls,
  Mask, DBCtrls, DBCGrids, ExtCtrls, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP,IdFTPCommon,
  Inifiles, ZipMstr19,TlHelp32, ComCtrls;

type
  TFPrincipal = class(TForm)
    BaseDados: TSQLConnection;
    Modulo: TRBSQL;
    ModuloSEQMODULO: TFMTBCDField;
    ModuloNOMMODULO: TWideStringField;
    ModuloNOMCAMPOCFG: TWideStringField;
    ModuloNOMARQUIVOFTP: TWideStringField;
    ModuloDATULTIMAATUALIZACAO: TSQLTimeStampField;
    DataModulo: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBCtrlGrid1: TDBCtrlGrid;
    ModuloINDATUALIZAR: TWideStringField;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Aux: TRBSQL;
    BAtualizar: TBitBtn;
    BFechar: TBitBtn;
    FTP: TIdFTP;
    procedure FormShow(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BAtualizarClick(Sender: TObject);
  private
    { Private declarations }
    VprArquivoIni : TIniFile;
    procedure InicializaCamposIndAtualizar;
    procedure AtualizaModulos;
    procedure AbreArquivoVersoes;
  public
    { Public declarations }
    function AbreBaseDados( Alias : string ) : Boolean;
  end;

var
  FPrincipal: TFPrincipal;


implementation

{$R *.dfm}

Uses funSQL, AAtualiza, constmsg, FunArquivos;

{ TFPrincipal }

{******************************************************************************}
procedure TFPrincipal.AbreArquivoVersoes;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CFG_GERAL');
  FTP.Username := Aux.FieldByName('C_USU_FTE').AsString;
  FTP.Password := Aux.FieldByName('C_SEN_FTE').AsString;
  FTP.Connect;
  if FTP.Connected then
  begin
    // transfere um arquivo texto
    FTP.TransferType := ftASCII;
    FTP.ChangeDir(Aux.FieldByName('C_FTP_EFI').AsString);
    DeletaArquivo(RetornaDiretorioCorrente+'\Versoes.ini');
    FTP.Get('VERSOES.ini',RetornaDiretorioCorrente+'\versoes.ini',true);
    VprArquivoIni := TIniFile.Create(RetornaDiretorioCorrente+'\Versoes.ini');
 end;
  FTP.Disconnect;
end;

function TFPrincipal.AbreBaseDados(Alias: string): Boolean;
begin
  if Alias = '' then
    Alias := 'SISCORP';
  Result := true;
  BaseDados.close;
  BaseDados.Params.clear;
  BaseDados.Params.add('drivername=Oracle');
  if UpperCase(Alias) = 'EFICACIA' then
    BaseDados.Params.add('Database=Eficacia')
  else
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

{******************************************************************************}
procedure TFPrincipal.AtualizaModulos;
begin
  AbreArquivoVersoes;
  Modulo.First;
  while not Modulo.Eof do
  begin
    if ModuloINDATUALIZAR.AsString = 'S' then
    begin
      FAtualiza := TFAtualiza.criarSDI(Application,'',true);
      FAtualiza.AtualizaModulo(ModuloSEQMODULO.AsInteger,VprArquivoIni.ReadFloat('VERSOES',ModuloNOMCAMPOCFG.AsString,0));
      FAtualiza.free;
    end;
    Modulo.Edit;
    ModuloINDATUALIZAR.AsString := 'N';
    Modulo.Post;
    Modulo.Next;
  end;
  Modulo.Close;
  Modulo.Open;
end;

{******************************************************************************}
procedure TFPrincipal.BAtualizarClick(Sender: TObject);
begin
  AtualizaModulos;
end;

procedure TFPrincipal.BFecharClick(Sender: TObject);
begin
  close;
end;



{******************************************************************************}
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  InicializaCamposIndAtualizar;
end;

{******************************************************************************}
procedure TFPrincipal.InicializaCamposIndAtualizar;
begin
  ExecutaComandoSql(Aux,'UPDATE MODULO ' +
                        ' SET INDATUALIZAR = ''S''');
  AdicionaSQLAbreTabela(Modulo,'Select * FROM MODULO ' +
                               ' order by SEQMODULO');

end;



end.
