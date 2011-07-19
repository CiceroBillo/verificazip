unit AMaterialFrasco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  Db, Grids, DBGrids, Tabela, DBKeyViolation, Localizacao, Mask, DBCtrls,
  DBTables, CBancoDados, DBClient;

type
  TFMaterialFrasco = class(TFormularioPermissao)
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
    MaterialFrasco: TRBSQL;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    DataMaterialFrasco: TDataSource;
    MaterialFrascoCODMATERIALFRASCO: TIntegerField;
    MaterialFrascoNOMMATERIALFRASCO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MaterialFrascoAfterInsert(DataSet: TDataSet);
    procedure MaterialFrascoAfterPost(DataSet: TDataSet);
    procedure MaterialFrascoAfterEdit(DataSet: TDataSet);
    procedure MaterialFrascoBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMaterialFrasco: TFMaterialFrasco;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMaterialFrasco.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMaterialFrasco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMaterialFrasco.MaterialFrascoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFMaterialFrasco.MaterialFrascoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMaterialFrasco.MaterialFrascoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMaterialFrasco.MaterialFrascoBeforePost(DataSet: TDataSet);
begin
  if MaterialFrasco.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFMaterialFrasco.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMaterialFrasco.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMaterialFrasco]);
end.
