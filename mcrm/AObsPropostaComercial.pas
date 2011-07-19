
unit AObsPropostaComercial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Componentes1, DB, DBClient, Tabela, Grids, DBGrids, DBKeyViolation,
  StdCtrls, Localizacao, Mask, DBCtrls, PainelGradiente, BotaoCadastro, Buttons,
  CBancoDados;

type
  TFObsPropostaComercial = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    DataOBSERVACAOINSTALACAOPROPOSTA: TDataSource;
    PanelColor2: TPanelColor;
    Label2: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    ECodigo: TDBKeyViolation;
    EConsulta: TLocalizaEdit;
    GGrid: TGridIndice;
    MObs: TDBMemoColor;
    PainelGradiente1: TPainelGradiente;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BAlterar: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    OBSERVACAOINSTALACAOPROPOSTA: TRBSQL;
    OBSERVACAOINSTALACAOPROPOSTACODOBSINSTALACAOPROPOSTA: TFMTBCDField;
    OBSERVACAOINSTALACAOPROPOSTANOMOBSINSTALACAOPROPOSTA: TWideStringField;
    OBSERVACAOINSTALACAOPROPOSTADESOBSINSTALACAOPROPOSTA: TWideStringField;
    Label3: TLabel;
    DBEditColor1: TDBEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OBSERVACAOINSTALACAOPROPOSTAAfterEdit(DataSet: TDataSet);
    procedure OBSERVACAOINSTALACAOPROPOSTAAfterInsert(DataSet: TDataSet);
    procedure OBSERVACAOINSTALACAOPROPOSTAAfterPost(DataSet: TDataSet);
    procedure OBSERVACAOINSTALACAOPROPOSTABeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure GGridOrdem(Ordem: string);
  private
  public
    { Public declarations }
  end;

var
  FObsPropostaComercial: TFObsPropostaComercial;

implementation

uses APrincipal, UnSistema, FunObjeto ;

{$R *.DFM}


{ **************************************************************************** }
procedure TFObsPropostaComercial.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus    }
  OBSERVACAOINSTALACAOPROPOSTA.Open;
  EConsulta.AtualizaConsulta;
end;

procedure TFObsPropostaComercial.GGridOrdem(Ordem: string);
begin
  EConsulta.AOrdem := Ordem;
end;

procedure TFObsPropostaComercial.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFObsPropostaComercial.OBSERVACAOINSTALACAOPROPOSTAAfterEdit(
  DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

procedure TFObsPropostaComercial.OBSERVACAOINSTALACAOPROPOSTAAfterInsert(
  DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  Ecodigo.ProximoCodigo;
end;

procedure TFObsPropostaComercial.OBSERVACAOINSTALACAOPROPOSTAAfterPost(
  DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

procedure TFObsPropostaComercial.OBSERVACAOINSTALACAOPROPOSTABeforePost(
  DataSet: TDataSet);
begin
  if OBSERVACAOINSTALACAOPROPOSTA.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{ *************************************************************************** }
procedure TFObsPropostaComercial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  OBSERVACAOINSTALACAOPROPOSTA.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFObsPropostaComercial]);
end.
