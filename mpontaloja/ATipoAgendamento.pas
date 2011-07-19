unit ATipoAgendamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  Db, Grids, DBGrids, Tabela, DBKeyViolation, Localizacao, Mask, DBCtrls,
  DBTables, CBancoDados, DBClient;

type
  TFTipoAgendamento = class(TFormularioPermissao)
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
    TipoAgendamento: TRBSQL;
    TipoAgendamentoCODTIPOAGENDAMENTO: TFMTBCDField;
    TipoAgendamentoNOMTIPOAGENDAMENTO: TWideStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    DataTipoAgendamento: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure TipoAgendamentoAfterEdit(DataSet: TDataSet);
    procedure TipoAgendamentoAfterInsert(DataSet: TDataSet);
    procedure TipoAgendamentoAfterPost(DataSet: TDataSet);
    procedure TipoAgendamentoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoAgendamento: TFTipoAgendamento;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoAgendamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoAgendamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TipoAgendamento.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFTipoAgendamento.BotaoCancelar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFTipoAgendamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTipoAgendamento.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFTipoAgendamento.TipoAgendamentoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFTipoAgendamento.TipoAgendamentoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFTipoAgendamento.TipoAgendamentoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoAgendamento.TipoAgendamentoBeforePost(DataSet: TDataSet);
begin
  if TipoAgendamento.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoAgendamento]);
end.
