unit AHorarioTrabalho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Tabela, CBancoDados, Componentes1, ExtCtrls,
  PainelGradiente, BotaoCadastro, StdCtrls, Buttons, Mask, DBCtrls,
  DBKeyViolation, Grids, DBGrids, DBClient;

type
  TFHorarioTrabalho = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    HorarioTrabalho: TRBSQL;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    HorarioTrabalhoCODHORARIO: TFMTBCDField;
    HorarioTrabalhoDESHORAINICIO: TWideStringField;
    HorarioTrabalhoDESHORAFIM: TWideStringField;
    Label1: TLabel;
    DataHorarioTrabalho: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    Bevel1: TBevel;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure HorarioTrabalhoAfterEdit(DataSet: TDataSet);
    procedure HorarioTrabalhoAfterInsert(DataSet: TDataSet);
    procedure HorarioTrabalhoBeforePost(DataSet: TDataSet);
    procedure HorarioTrabalhoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FHorarioTrabalho: TFHorarioTrabalho;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHorarioTrabalho.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  HorarioTrabalho.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHorarioTrabalho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  HorarioTrabalho.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFHorarioTrabalho.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFHorarioTrabalho.HorarioTrabalhoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFHorarioTrabalho.HorarioTrabalhoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

procedure TFHorarioTrabalho.HorarioTrabalhoBeforePost(DataSet: TDataSet);
begin
  if HorarioTrabalho.state = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFHorarioTrabalho.HorarioTrabalhoAfterPost(DataSet: TDataSet);
begin
  HorarioTrabalho.Close;
  HorarioTrabalho.Open;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHorarioTrabalho]);
end.
