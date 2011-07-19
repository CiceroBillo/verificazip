unit AEstagioProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, StdCtrls, Mask,
  DBCtrls, Tabela, DBKeyViolation, Db, DBTables, CBancoDados, Buttons,
  BotaoCadastro, Grids, DBGrids, DBClient;

type
  TFEstagioProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BFechar: TBitBtn;
    Grade: TGridIndice;
    PanelColor1: TPanelColor;
    BotaoConsultar1: TBotaoConsultar;
    EDescricao: TEditColor;
    Label2: TLabel;
    EstagioProducao: TRBSQL;
    EstagioProducaoCODEST: TFMTBCDField;
    EstagioProducaoNOMEST: TWideStringField;
    EstagioProducaoCODTIP: TFMTBCDField;
    EstagioProducaoINDFIN: TWideStringField;
    EstagioProducaoCODPLA: TWideStringField;
    EstagioProducaoCODEMP: TFMTBCDField;
    EstagioProducaoINDOBS: TWideStringField;
    EstagioProducaoMAXDIA: TFMTBCDField;
    EstagioProducaoTIPEST: TWideStringField;
    EstagioProducaoDATALT: TSQLTimeStampField;
    DataEstagioProducao: TDataSource;
    EstagioProducaoVALHOR: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeOrdem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure EDescricaoExit(Sender: TObject);
    procedure EDescricaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    VprOrdem : string;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaFiltros : TStrings);
  public
    { Public declarations }
  end;

var
  FEstagioProducao: TFEstagioProducao;

implementation

uses APrincipal, ATipoEstagioProducao, FunObjeto, UnSistema, funSql, ANovoEstagio;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEstagioProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by CODEST';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEstagioProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  EstagioProducao.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEstagioProducao.GradeOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFEstagioProducao.AdicionaFiltros(VpaFiltros: TStrings);
begin
  if EDescricao.Text <> '' then
    AdicionaSQLTabela(EstagioProducao,'and NOMEST LIKE '''+EDescricao.Text + '%''');
end;

{******************************************************************************}
procedure TFEstagioProducao.AtualizaConsulta;
begin
  LimpaSQLTabela(EstagioProducao);
  AdicionaSQLTabela(EstagioProducao,'Select * from ESTAGIOPRODUCAO '+
                                    ' Where 1 = 1');
  AdicionaFiltros(EstagioProducao.SQL);
  AdicionaSQLTabela(EstagioProducao,VprOrdem);
  EstagioProducao.Open;
end;

{******************************************************************************}
procedure TFEstagioProducao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFEstagioProducao.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoEstagio.EstagioProducao,'Select * from ESTAGIOPRODUCAO ' +
                                                     ' Where CODEST = '+IntToStr(EstagioProducaoCODEST.AsInteger));
end;

{******************************************************************************}
procedure TFEstagioProducao.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoEstagio := TFNovoEstagio.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoEstagio'));
end;

{******************************************************************************}
procedure TFEstagioProducao.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoEstagio.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstagioProducao.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovoEstagio.Show;
end;

{******************************************************************************}
procedure TFEstagioProducao.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoEstagio.Free;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstagioProducao.EDescricaoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstagioProducao.EDescricaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEstagioProducao]);
end.
