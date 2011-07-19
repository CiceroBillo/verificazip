unit AFormatoFrasco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  Mask, DBCtrls, Tabela, DBKeyViolation, Db, DBTables, CBancoDados, Grids,
  DBGrids, Localizacao, DBClient;

type
  TFFormatoFrasco = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    FormatoFrasco: TRBSQL;
    DataFormatoFrasco: TDataSource;
    FormatoFrascoCODFORMATO: TIntegerField;
    FormatoFrascoNOMFORMATO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure FormatoFrascoAfterInsert(DataSet: TDataSet);
    procedure FormatoFrascoAfterEdit(DataSet: TDataSet);
    procedure FormatoFrascoAfterPost(DataSet: TDataSet);
    procedure FormatoFrascoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFormatoFrasco: TFFormatoFrasco;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFormatoFrasco.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormatoFrasco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FormatoFrasco.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFFormatoFrasco.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFFormatoFrasco.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFFormatoFrasco.FormatoFrascoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFFormatoFrasco.FormatoFrascoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFFormatoFrasco.FormatoFrascoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFormatoFrasco.FormatoFrascoBeforePost(DataSet: TDataSet);
begin
  if FormatoFrasco.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFormatoFrasco]);
end.
