unit ANovoPerfilCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DB, DBClient, Tabela, BotaoCadastro, StdCtrls, Buttons, DBKeyViolation, Mask,
  DBCtrls, Componentes1, ExtCtrls, PainelGradiente, CBancoDados;

type
  TFNovoPerfilCliente = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    Label12: TLabel;
    Label13: TLabel;
    EPerfil: TDBEditColor;
    ECodigo: TDBKeyViolation;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    DataCadPerfilCliente: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PerfilCliente: TRBSQL;
    PerfilClienteCODPERFIL: TFMTBCDField;
    PerfilClienteNOMPERFIL: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CadPerfilClienteAfterInsert(DataSet: TDataSet);
    procedure CadPerfilClienteBeforePost(DataSet: TDataSet);
    procedure CadPerfilClienteAfterPost(DataSet: TDataSet);
    procedure CadPerfilClienteAfterEdit(DataSet: TDataSet);
    procedure PerfilClienteAfterInsert(DataSet: TDataSet);
    procedure PerfilClienteBeforePost(DataSet: TDataSet);
    procedure PerfilClienteAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovoPerfilCliente: TFNovoPerfilCliente;

implementation

uses APerfilCliente, APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFNovoPerfilCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PerfilCliente.Open;
end;

{******************************************************************************}
procedure TFNovoPerfilCliente.PerfilClienteAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
end;

procedure TFNovoPerfilCliente.PerfilClienteAfterPost(DataSet: TDataSet);
begin
  FPerfilCliente.EConsulta.AtualizaTabela;
end;

{******************************************************************************}
procedure TFNovoPerfilCliente.PerfilClienteBeforePost(DataSet: TDataSet);
begin
  if PerfilCliente.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{ *************************************************************************** }
procedure TFNovoPerfilCliente.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovoPerfilCliente.CadPerfilClienteAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= true;
end;

{******************************************************************************}
procedure TFNovoPerfilCliente.CadPerfilClienteAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

procedure TFNovoPerfilCliente.CadPerfilClienteAfterPost(DataSet: TDataSet);
begin

end;

{******************************************************************************}
procedure TFNovoPerfilCliente.CadPerfilClienteBeforePost(DataSet: TDataSet);
begin
   //if CadPerfilCliente.State = dsinsert then
   //   ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFNovoPerfilCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PerfilCliente.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoPerfilCliente]);
end.
