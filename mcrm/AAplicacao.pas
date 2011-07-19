unit AAplicacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, DB,
  DBClient, Tabela, CBancoDados, Mask, DBCtrls, DBKeyViolation, Grids, DBGrids,
  Localizacao;

type
  TFAplicacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BotaoCancelar1: TBotaoCancelar;
    BotaoGravar1: TBotaoGravar;
    BotaoExcluir1: TBotaoExcluir;
    BAlterar: TBotaoAlterar;
    BotaoCadastrar: TBotaoCadastrar;
    MoveBasico1: TMoveBasico;
    Label1: TLabel;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    APLICACAO: TRBSQL;
    APLICACAOCODAPLICACAO: TFMTBCDField;
    APLICACAONOMAPLICACAO: TWideStringField;
    DSAPLICACAO: TDataSource;
    EAplicacao: TDBEditColor;
    Bevel1: TBevel;
    LConsulta: TLabel;
    EConsulta: TLocalizaEdit;
    GGrid: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure APLICACAOAfterInsert(DataSet: TDataSet);
    procedure APLICACAOBeforePost(DataSet: TDataSet);
    procedure APLICACAOAfterPost(DataSet: TDataSet);
    procedure APLICACAOAfterEdit(DataSet: TDataSet);
    procedure APLICACAOAfterCancel(DataSet: TDataSet);
    procedure GGridOrdem(Ordem: string);
  private
    { Private declarations }
    procedure ConfiguraConsulta(VpaAcao : Boolean);
  public
    { Public declarations }
  end;

var
  FAplicacao: TFAplicacao;

implementation

uses APrincipal;

{$R *.DFM}

{ **************************************************************************** }
procedure TFAplicacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

procedure TFAplicacao.GGridOrdem(Ordem: string);
begin
  EConsulta.AOrdem := ordem;
end;

{ *************************************************************************** }
procedure TFAplicacao.APLICACAOAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(True);
end;

{ *************************************************************************** }
procedure TFAplicacao.APLICACAOAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
  ConfiguraConsulta(False);
end;

{ *************************************************************************** }
procedure TFAplicacao.APLICACAOAfterInsert(DataSet: TDataSet);
begin
   ECodigo.ReadOnly := False;
   ECodigo.ProximoCodigo;
   ConfiguraConsulta(False);
end;

{ *************************************************************************** }
procedure TFAplicacao.APLICACAOAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
  ConfiguraConsulta(True);
end;

{ *************************************************************************** }
procedure TFAplicacao.APLICACAOBeforePost(DataSet: TDataSet);
begin
  if APLICACAO.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{ *************************************************************************** }
procedure TFAplicacao.BFecharClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFAplicacao.ConfiguraConsulta(VpaAcao: Boolean);
begin
  LConsulta.Enabled := VpaAcao;
  EConsulta.Enabled := VpaAcao;
  GGrid.Enabled := VpaAcao;
end;

{ *************************************************************************** }
procedure TFAplicacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  APLICACAO.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAplicacao]);
end.
