unit ATarefaTelemarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, ExtCtrls, BotaoCadastro,
  StdCtrls, Buttons, ComCtrls, Componentes1, PainelGradiente, Db, DBTables;

type
  TFTarefasTelemarketingProspect = class(TFormularioPermissao)
    TAREFATELEMARKETINGPROSPECT: TQuery;
    DataTAREFATELEMARKETINGPROSPECT: TDataSource;
    PainelGradiente1: TPainelGradiente;
    TAREFATELEMARKETINGPROSPECTITEM: TQuery;
    DataTAREFATELEMARKETINGPROSPECTITEM: TDataSource;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicial: TCalendario;
    EDatFinal: TCalendario;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BFechar: TBitBtn;
    BotaoExcluir1: TBotaoExcluir;
    BotaoConsultar1: TBotaoConsultar;
    PanelColor3: TPanelColor;
    TAREFATELEMARKETINGPROSPECTITEMNOMPROSPECT: TStringField;
    TAREFATELEMARKETINGPROSPECTITEMDATLIGACAO: TDateField;
    TAREFATELEMARKETINGPROSPECTSEQTAREFA: TIntegerField;
    TAREFATELEMARKETINGPROSPECTDATTAREFA: TDateTimeField;
    TAREFATELEMARKETINGPROSPECTQTDLIGACAO: TIntegerField;
    TAREFATELEMARKETINGPROSPECTDATAGENDAMENTO: TDateTimeField;
    TAREFATELEMARKETINGPROSPECTC_NOM_REG: TStringField;
    TAREFATELEMARKETINGPROSPECTC_NOM_PRO: TStringField;
    TAREFATELEMARKETINGPROSPECTC_NOM_CLA: TStringField;
    TAREFATELEMARKETINGPROSPECTC_NOM_USU: TStringField;
    Splitter1: TSplitter;
    GTarefasProspect: TGridIndice;
    GTarefas: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure TAREFATELEMARKETINGPROSPECTAfterScroll(DataSet: TDataSet);
    procedure GTarefasOrdem(Ordem: String);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BotaoConsultar1Atividade(Sender: TObject);
    procedure EDatInicialExit(Sender: TObject);
  private
    VprOrdem: String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
    procedure PosItens;
  public
  end;

var
  FTarefasTelemarketingProspect: TFTarefasTelemarketingProspect;

implementation
uses
  FunSQL, FunData, ANovaTarefaTelemarketingProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTarefasTelemarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicial.DateTime:= PrimeiroDiaMes(date);
  EDatFinal.DateTime:= UltimoDiaMes(date);
  VprOrdem:= ' ORDER BY TAR.SEQTAREFA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTarefasTelemarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TAREFATELEMARKETINGPROSPECT.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFTarefasTelemarketingProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.AdicionaFiltros(VpaSelect: TStrings);
begin
  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('TAR.DATTAREFA',EDatInicial.Datetime,incdia(EDatfinal.Datetime,1),true));
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.AtualizaConsulta;
begin
  TAREFATELEMARKETINGPROSPECT.SQL.Clear;
  TAREFATELEMARKETINGPROSPECT.SQL.Add('SELECT'+
                                      ' TAR.SEQTAREFA, TAR.DATTAREFA,TAR.QTDLIGACAO,TAR.DATAGENDAMENTO,'+
                                      ' REG.C_NOM_REG,'+
                                      ' PRO.C_NOM_PRO,'+
                                      ' CLA.C_NOM_CLA,'+
                                      ' USU.C_NOM_USU'+
                                      ' FROM'+
                                      ' TAREFATELEMARKETINGPROSPECT TAR, CADREGIAOVENDA REG, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, CADUSUARIOS USU'+
                                      ' WHERE'+
                                      ' TAR.CODREGIAO *= REG.I_COD_REG'+
                                      ' AND TAR.CODCLASSIFICACAO *= CLA.C_COD_CLA'+
                                      ' AND TAR.SEQPRODUTO *= PRO.I_SEQ_PRO'+
                                      ' AND TAR.CODUSUARIO *= USU.I_COD_USU');
  AdicionaFiltros(TAREFATELEMARKETINGPROSPECT.SQL);
  TAREFATELEMARKETINGPROSPECT.SQL.Add(VprOrdem);
  GTarefasProspect.ALinhaSQLOrderBy:= TAREFATELEMARKETINGPROSPECT.SQL.Count-1;
  TAREFATELEMARKETINGPROSPECT.Open;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.TAREFATELEMARKETINGPROSPECTAfterScroll(
  DataSet: TDataSet);
begin
  PosItens;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.PosItens;
begin
  if TAREFATELEMARKETINGPROSPECTSEQTAREFA.AsInteger <> 0 then
    AdicionaSQLAbreTabela(TAREFATELEMARKETINGPROSPECTITEM,
                          'SELECT PRO.NOMPROSPECT, TAR.DATLIGACAO'+
                          ' FROM TAREFATELEMARKETINGPROSPECTITEM TAR, PROSPECT PRO'+
                          ' WHERE TAR.CODPROSPECT = PRO.CODPROSPECT'+
                          ' AND TAR.SEQTAREFA = '+TAREFATELEMARKETINGPROSPECTSEQTAREFA.AsString)
  else
    TAREFATELEMARKETINGPROSPECTITEM.Close;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.GTarefasOrdem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.BotaoCadastrar1AntesAtividade(
  Sender: TObject);
begin
  FNovaTarefaTelemarketingProspect:= TFNovaTarefaTelemarketingProspect.CriarSDI(Application,'',True);
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.BotaoCadastrar1DepoisAtividade(
  Sender: TObject);
begin
  FNovaTarefaTelemarketingProspect.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.BotaoExcluir1DepoisAtividade(
  Sender: TObject);
begin
  FNovaTarefaTelemarketingProspect.Show;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.BotaoExcluir1DestroiFormulario(
  Sender: TObject);
begin
  FNovaTarefaTelemarketingProspect.Close;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.BotaoConsultar1Atividade(
  Sender: TObject);
begin
  if TAREFATELEMARKETINGPROSPECTSEQTAREFA.AsInteger <> 0 then
    AdicionaSQLAbreTabela(FNovaTarefaTelemarketingProspect.Tarefa,
                          'SELECT * FROM TAREFATELEMARKETINGPROSPECT'+
                          ' WHERE SEQTAREFA = '+TAREFATELEMARKETINGPROSPECTSEQTAREFA.AsString)
  else
    Abort;
end;

{******************************************************************************}
procedure TFTarefasTelemarketingProspect.EDatInicialExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTarefasTelemarketingProspect]);
end.
