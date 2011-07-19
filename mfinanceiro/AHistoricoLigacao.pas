unit AHistoricoLigacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  Db, Tabela, Mask, DBCtrls, DBKeyViolation, DBTables, CBancoDados, Grids,
  DBGrids, Localizacao, DBClient;

type
  TFHistoricoLigacao = class(TFormularioPermissao)
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
    HistoricoLigacao: TRBSQL;
    HistoricoLigacaoCODHISTORICO: TFMTBCDField;
    HistoricoLigacaoDESHISTORICO: TWideStringField;
    HistoricoLigacaoINDATENDEU: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    DataHistoricoLigacao: TDataSource;
    Bevel1: TBevel;
    Label4: TLabel;
    EConsulta: TLocalizaEdit;
    Localiza: TConsultaPadrao;
    Grade: TGridIndice;
    CAtendeu: TDBCheckBox;
    CEmUso: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    Label3: TLabel;
    HistoricoLigacaoDESTIPOLIGACAO: TWideStringField;
    HistoricoLigacaoINDATIVO: TWideStringField;
    CCadastroRapido: TDBCheckBox;
    HistoricoLigacaoINDCADASTRORAPIDO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeOrdem(Ordem: String);
    procedure HistoricoLigacaoAfterInsert(DataSet: TDataSet);
    procedure HistoricoLigacaoAfterEdit(DataSet: TDataSet);
    procedure HistoricoLigacaoAfterPost(DataSet: TDataSet);
    procedure HistoricoLigacaoBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FHistoricoLigacao: TFHistoricoLigacao;

implementation

uses APrincipal,FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHistoricoLigacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
  IniciallizaCheckBox([CAtendeu,CEmUso,CCadastroRapido],'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHistoricoLigacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  HistoricoLigacao.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFHistoricoLigacao.GradeOrdem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

procedure TFHistoricoLigacao.HistoricoLigacaoAfterInsert(
  DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
  HistoricoLigacaoINDATENDEU.AsString := 'N';
  HistoricoLigacaoINDATIVO.AsString := 'S';
  HistoricoLigacaoINDCADASTRORAPIDO.AsString := 'N';
  HistoricoLigacaoDESTIPOLIGACAO.AsString := 'A';
end;

{******************************************************************************}
procedure TFHistoricoLigacao.HistoricoLigacaoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.readOnly := true;
end;

{******************************************************************************}
procedure TFHistoricoLigacao.HistoricoLigacaoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFHistoricoLigacao.HistoricoLigacaoBeforePost(DataSet: TDataSet);
begin
  if HistoricoLigacao.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

procedure TFHistoricoLigacao.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHistoricoLigacao]);
end.
