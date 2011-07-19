unit AAlteraPermissaoFilial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, Buttons, StdCtrls, Componentes1, ExtCtrls,
  PainelGradiente, Db, DBTables, FMTBcd, SqlExpr, DBClient;

type
  TFAlteraPermissaoFilial = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Desativa: TSpeedButton;
    Label2: TLabel;
    Ativa: TSpeedButton;
    DBGridColor1: TDBGridColor;
    DBGridColor2: TDBGridColor;
    ComPermissao: TSQL;
    DataComPermissao: TDataSource;
    SemPermissao: TSQL;
    DataSemPermissao: TDataSource;
    Aux: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DesativaClick(Sender: TObject);
    procedure AtivaClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    VprCodUsuario : Integer;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    procedure AlteraPermissaoUsuario(VpaCodUsuario : Integer);
  end;

var
  FAlteraPermissaoFilial: TFAlteraPermissaoFilial;

implementation

uses APrincipal, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraPermissaoFilial.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraPermissaoFilial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFAlteraPermissaoFilial.AlteraPermissaoUsuario(VpaCodUsuario : Integer);
begin
  VprCodUsuario := VpaCodUsuario;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFAlteraPermissaoFilial.AtualizaConsulta;
begin
  AdicionaSQLAbreTabela(ComPermissao,'Select I_EMP_FIL, I_EMP_FIL || ''-''|| C_NOM_FIL FILIAL '+
                                     ' FROM CADFILIAIS FIL ' +
                                     ' Where not exists(SELECT * FROM SEMPERMISSAOFILIAL SEM '+
                                     ' WHERE SEM.CODUSUARIO = ' + IntToStr(VprCodUsuario)+
                                     ' AND SEM.CODFILIAL = FIL.I_EMP_FIL)');
  AdicionaSQLAbreTabela(SemPermissao,'Select I_EMP_FIL, I_EMP_FIL || ''-''|| C_NOM_FIL FILIAL '+
                                     ' FROM CADFILIAIS FIL ' +
                                     ' Where exists(SELECT * FROM SEMPERMISSAOFILIAL SEM '+
                                     ' WHERE SEM.CODUSUARIO = ' + IntToStr(VprCodUsuario)+
                                     ' AND SEM.CODFILIAL = FIL.I_EMP_FIL)');
end;

{******************************************************************************}
procedure TFAlteraPermissaoFilial.DesativaClick(Sender: TObject);
begin
  if ComPermissao.FieldByName('I_EMP_FIL').AsInteger <> 0 then
  begin
    ExecutaComandoSql(Aux,'INSERT INTO SEMPERMISSAOFILIAL(CODFILIAL,CODUSUARIO)'+
                        ' VALUES('+ComPermissao.FieldByName('I_EMP_FIL').AsString+','+IntToStr(VprCodUsuario)+')');
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFAlteraPermissaoFilial.AtivaClick(Sender: TObject);
begin
  if SemPermissao.FieldByName('I_EMP_FIL').AsInteger <> 0 then
  begin
    ExecutaComandoSql(Aux,'Delete from SEMPERMISSAOFILIAL '+
                          ' Where CODFILIAL = '+SemPermissao.FieldByName('I_EMP_FIL').AsString+
                          ' and CODUSUARIO = ' +IntToStr(VprCodUsuario));
    AtualizaConsulta;
  end;
end;

procedure TFAlteraPermissaoFilial.BitBtn1Click(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraPermissaoFilial]);
end.
