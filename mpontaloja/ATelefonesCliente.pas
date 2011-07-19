unit ATelefonesCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids, DBGrids,
  Tabela, DBKeyViolation, DB, DBClient, CBancoDados;

type
  TFTelefoneCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    BFechar: TBitBtn;
    ClienteTelefone: TRBSQL;
    DataClienteTelefone: TDataSource;
    ClienteTelefoneCODCLIENTE: TFMTBCDField;
    ClienteTelefoneSEQTELEFONE: TFMTBCDField;
    ClienteTelefoneDESTELEFONE: TWideStringField;
    Aux: TRBSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ClienteTelefoneAfterInsert(DataSet: TDataSet);
    procedure ClienteTelefoneBeforePost(DataSet: TDataSet);
    procedure GridIndice1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprCodCliente : Integer;
    function RSeqTelefoneDisponivel(VpaCodCliente : Integer):integer;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    procedure TelefoneCliente(VpaCodCliente : Integer);
  end;

var
  FTelefoneCliente: TFTelefoneCliente;

implementation

uses APrincipal, FunSql, FunString, Constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFTelefoneCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{******************************************************************************}
procedure TFTelefoneCliente.GridIndice1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ClienteTelefone.State = dsBrowse then
  begin
    if key = VK_DELETE then
      if confirmacao(CT_DeletaRegistro) then
        ClienteTelefone.Delete;
  end;
end;

{******************************************************************************}
function TFTelefoneCliente.RSeqTelefoneDisponivel(VpaCodCliente: Integer): integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQTELEFONE) ULTIMO FROM CLIENTETELEFONE ' +
                            ' Where CODCLIENTE = ' +IntToStr(VpaCodCliente));
  result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.Close;
end;

{******************************************************************************}
procedure TFTelefoneCliente.TelefoneCliente(VpaCodCliente: Integer);
begin
  VprCodCliente :=  VpaCodCliente;
  AtualizaConsulta;
  ShowModal;
end;

{ *************************************************************************** }
procedure TFTelefoneCliente.AtualizaConsulta;
begin
  AdicionaSQLAbreTabela(ClienteTelefone,'SELECT * FROM CLIENTETELEFONE ' +
                                        ' WHERE CODCLIENTE = '+IntToStr(VprCodCliente)+
                                        ' order by DESTELEFONE');
end;


{******************************************************************************}
procedure TFTelefoneCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTelefoneCliente.ClienteTelefoneAfterInsert(DataSet: TDataSet);
begin
  ClienteTelefoneCODCLIENTE.AsInteger := VprCodCliente;

end;

{******************************************************************************}
procedure TFTelefoneCliente.ClienteTelefoneBeforePost(DataSet: TDataSet);
begin
  if DeletaChars(DeletaChars(DeletaChars(DeletaChars(ClienteTelefoneDESTELEFONE.AsString,'('),' '),')'),'-') = ''  then
  begin
    aviso('TELEFONE INVÁLIDO!!!!'#13'O telefone digitado não é valido.');
    abort;
  end;

  ClienteTelefoneSEQTELEFONE.AsInteger := RSeqTelefoneDisponivel(VprCodCliente);
end;

{******************************************************************************}
procedure TFTelefoneCliente.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFTelefoneCliente]);
end.
