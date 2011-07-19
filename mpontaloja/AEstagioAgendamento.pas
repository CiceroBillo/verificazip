unit AEstagioAgendamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls, Componentes1,
  Localizacao, ExtCtrls, Mask, DBCtrls, Db, BotaoCadastro, Buttons,
  DBTables, CBancoDados, PainelGradiente, DBClient;

type
  TFEstagioAgendamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EstagioAgenda: TRBSQL;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    EstagioAgendaCODESTAGIO: TFMTBCDField;
    EstagioAgendaNOMESTAGIO: TWideStringField;
    DataEstagioAgenda: TDataSource;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label1: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure EstagioAgendaAfterEdit(DataSet: TDataSet);
    procedure EstagioAgendaAfterInsert(DataSet: TDataSet);
    procedure EstagioAgendaBeforePost(DataSet: TDataSet);
    procedure EstagioAgendaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEstagioAgendamento: TFEstagioAgendamento;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEstagioAgendamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEstagioAgendamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEstagioAgendamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFEstagioAgendamento.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFEstagioAgendamento.EstagioAgendaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFEstagioAgendamento.EstagioAgendaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFEstagioAgendamento.EstagioAgendaBeforePost(DataSet: TDataSet);
begin
  if EstagioAgenda.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFEstagioAgendamento.EstagioAgendaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEstagioAgendamento]);
end.
