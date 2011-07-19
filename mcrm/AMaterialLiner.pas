unit AMaterialLiner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  Db, Grids, DBGrids, Tabela, DBKeyViolation, Localizacao, Mask, DBCtrls,
  DBTables, CBancoDados, DBClient;

type
  TFMaterialLiner = class(TFormularioPermissao)
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
    MateriaLiner: TRBSQL;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    MateriaLinerCODMATERIALLINER: TIntegerField;
    MateriaLinerNOMMATERIALLINER: TStringField;
    DataMateriaLiner: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridIndice1Ordem(Ordem: String);
    procedure MateriaLinerAfterInsert(DataSet: TDataSet);
    procedure MateriaLinerAfterEdit(DataSet: TDataSet);
    procedure MateriaLinerBeforePost(DataSet: TDataSet);
    procedure MateriaLinerAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMaterialLiner: TFMaterialLiner;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMaterialLiner.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMaterialLiner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MateriaLiner.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMaterialLiner.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFMaterialLiner.MateriaLinerAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFMaterialLiner.MateriaLinerAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMaterialLiner.MateriaLinerBeforePost(DataSet: TDataSet);
begin
  if MateriaLiner.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFMaterialLiner.MateriaLinerAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMaterialLiner.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMaterialLiner]);
end.
