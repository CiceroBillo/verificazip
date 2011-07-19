unit AMaterialRotulo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  Db, DBTables, Tabela, CBancoDados, Grids, DBGrids, DBKeyViolation,
  Localizacao, Mask, DBCtrls, DBClient;

type
  TFMaterialRotulo = class(TFormularioPermissao)
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
    MaterialRotulo: TRBSQL;
    MaterialRotuloCODMATERIALROTULO: TIntegerField;
    MaterialRotuloNOMMATERIALROTULO: TStringField;
    DataMaterialRotulo: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MaterialRotuloAfterInsert(DataSet: TDataSet);
    procedure MaterialRotuloAfterEdit(DataSet: TDataSet);
    procedure MaterialRotuloAfterPost(DataSet: TDataSet);
    procedure MaterialRotuloBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMaterialRotulo: TFMaterialRotulo;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMaterialRotulo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMaterialRotulo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MaterialRotulo.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFMaterialRotulo.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFMaterialRotulo.MaterialRotuloAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFMaterialRotulo.MaterialRotuloAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMaterialRotulo.MaterialRotuloAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMaterialRotulo.MaterialRotuloBeforePost(DataSet: TDataSet);
begin
  if MaterialRotulo.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMaterialRotulo]);
end.
