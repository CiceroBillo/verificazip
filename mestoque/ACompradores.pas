unit ACompradores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Mask, DBCtrls, Componentes1, Localizacao, ExtCtrls, Db, DBTables,
  CBancoDados, PainelGradiente, DBClient;

type
  TFCompradores = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BMover: TMoveBasico;
    BCadastrar: TBotaoCadastrar;
    BAlterar: TBotaoAlterar;
    BExcluir: TBotaoExcluir;
    BGravar: TBotaoGravar;
    BCancelar: TBotaoCancelar;
    COMPRADOR: TRBSQL;
    DataCOMPRADORES: TDataSource;
    ValidaGravacao: TValidaGravacao;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    ENome: TDBEditColor;
    Label6: TLabel;
    Bevel1: TBevel;
    COMPRADORCODCOMPRADOR: TFMTBCDField;
    COMPRADORNOMCOMPRADOR: TWideStringField;
    Label1: TLabel;
    EConsulta: TLocalizaEdit;
    GCompradores: TGridIndice;
    COMPRADORDESEMAIL: TWideStringField;
    COMPRADORDESFONE: TWideStringField;
    Label3: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ECodigoChange(Sender: TObject);
    procedure GCompradoresOrdem(Ordem: String);
    procedure COMPRADORAfterInsert(DataSet: TDataSet);
    procedure COMPRADORBeforePost(DataSet: TDataSet);
    procedure COMPRADORAfterPost(DataSet: TDataSet);
    procedure COMPRADORAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCompradores: TFCompradores;

implementation
uses
  APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCompradores.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCompradores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  COMPRADOR.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFCompradores.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFCompradores.ECodigoChange(Sender: TObject);
begin
  if COMPRADOR.State in [dsInsert,dsEdit] then
    ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFCompradores.GCompradoresOrdem(Ordem: String);
begin
  EConsulta.AOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFCompradores.COMPRADORAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= False;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFCompradores.COMPRADORBeforePost(DataSet: TDataSet);
begin
  if COMPRADOR.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFCompradores.COMPRADORAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaTabela;
end;

{******************************************************************************}
procedure TFCompradores.COMPRADORAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= True;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCompradores]);
end.
