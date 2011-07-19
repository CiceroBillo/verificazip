unit ATarefas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, DBGrids,
  Tabela, DBKeyViolation, ComCtrls, StdCtrls, BotaoCadastro, Buttons, DBClient;

type
  TFTarefas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EDatInicial: TCalendario;
    EDatFinal: TCalendario;
    Tarefas: TSQL;
    TarefasSEQTAREFA: TFMTBCDField;
    TarefasDATTAREFA: TSQLTimeStampField;
    TarefasQTDLIGACOES: TFMTBCDField;
    TarefasDATAGENDAMENTO: TSQLTimeStampField;
    TarefasC_NOM_REG: TWideStringField;
    TarefasC_NOM_PRO: TWideStringField;
    TarefasC_NOM_CLA: TWideStringField;
    TarefasC_NOM_USU: TWideStringField;
    DataTarefaItem: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoConsultar1: TBotaoConsultar;
    BFechar: TBitBtn;
    BotaoExcluir1: TBotaoExcluir;
    TarefaItem: TSQL;
    DataTarefas: TDataSource;
    TarefaItemC_NOM_CLI: TWideStringField;
    TarefaItemDATLIGACAO: TSQLTimeStampField;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    Splitter1: TSplitter;
    GridIndice2: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure EDatInicialCloseUp(Sender: TObject);
    procedure BotaoConsultar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure TarefasAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure PosItems;
  public
    { Public declarations }
  end;

var
  FTarefas: TFTarefas;

implementation

uses APrincipal, fundata,FunSql, ANovaTarefa;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTarefas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicial.DateTime := PrimeiroDiaMes(date);
  EDatFinal.DateTime := UltimoDiaMes(date);
  VprOrdem := 'order by TAR.SEQTAREFA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTarefas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Tarefas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTarefas.AtualizaConsulta;
begin
  Tarefas.close;
  Tarefas.sql.clear;
  Tarefas.sql.add('SELECT TAR.SEQTAREFA, TAR.DATTAREFA,TAR.QTDLIGACOES,TAR.DATAGENDAMENTO, '+
                  ' REG.C_NOM_REG, '+
                  ' PRO.C_NOM_PRO, '+
                  ' CLA.C_NOM_CLA, '+
                  ' USU.C_NOM_USU '+
                  ' FROM TAREFATELEMARKETING TAR, CADREGIAOVENDA REG, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, CADUSUARIOS USU '+
                  ' Where '+SQLTextoRightJoin('TAR.CODREGIAO','REG.I_COD_REG')+
                  ' and '+SQLTextoRightJoin('TAR.CODCLASSIFICACAO','CLA.C_COD_CLA')+
                  ' and '+SQLTextoRightJoin('TAR.SEQPRODUTO','PRO.I_SEQ_PRO')+
                  ' and TAR.CODUSUARIO = USU.I_COD_USU');
  Tarefas.sql.add(SQLTextoDataEntreAAAAMMDD('DATTAREFA',EDatInicial.Datetime,incdia(EDatfinal.Datetime,1),true));
  Tarefas.sql.add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := Tarefas.sql.count -1;
  Tarefas.open;
end;

{******************************************************************************}
procedure TFTarefas.PosItems;
begin
  IF TarefasSEQTAREFA.AsInteger <> 0 then
    AdicionaSQLAbreTabela(TarefaItem,'SELECT CLI.C_NOM_CLI, TAR.DATLIGACAO '+
                                   ' FROM TAREFATELEMARKETINGITEM TAR, CADCLIENTES CLI '+
                                   ' WHERE TAR.CODCLIENTE = CLI.I_COD_CLI '+
                                   ' AND SEQTAREFA = '+TarefasSEQTAREFA.AsString +
                                   ' order by cli.c_nom_cli ')
  else
    TarefaItem.close;
end;

{******************************************************************************}
procedure TFTarefas.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFTarefas.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovaTarefa := tFNovaTarefa.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaTarefa'));
end;

{******************************************************************************}
procedure TFTarefas.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaTarefa.showmodal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefas.GridIndice1Ordem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFTarefas.EDatInicialCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefas.BotaoConsultar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaTarefa.Tarefa,'Select * from TAREFATELEMARKETING '+
                                           ' Where SEQTAREFA = '+InttoStr(TarefasSEQTAREFA.AsInteger));
end;

{******************************************************************************}
procedure TFTarefas.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaTarefa.show;
end;

{******************************************************************************}
procedure TFTarefas.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaTarefa.close;
  AtualizaConsulta;
end;

procedure TFTarefas.TarefasAfterScroll(DataSet: TDataSet);
begin
  PosItems;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTarefas]);
end.
