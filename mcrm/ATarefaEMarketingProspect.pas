unit ATarefaEMarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, ComCtrls, Componentes1, ExtCtrls, UnDados,
  PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, UnEMarketingProspect,
  DBClient;

type
  TFTarefaEMarketingProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicial: TCalendario;
    EDatFinal: TCalendario;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BFechar: TBitBtn;
    BotaoConsultar1: TBotaoConsultar;
    PanelColor3: TPanelColor;
    Splitter1: TSplitter;
    Tarefas: TSQL;
    DataTarefas: TDataSource;
    TarefaItem: TSQL;
    DataTarefaItem: TDataSource;
    GridIndice1: TGridIndice;
    TarefasSEQTAREFA: TFMTBCDField;
    TarefasDATTAREFA: TSQLTimeStampField;
    TarefasQTDEMAIL: TFMTBCDField;
    TarefasDATPROPOSTADESDE: TSQLTimeStampField;
    TarefasC_NOM_REG: TWideStringField;
    TarefasC_NOM_PRO: TWideStringField;
    TarefasC_NOM_CLA: TWideStringField;
    TarefasC_NOM_USU: TWideStringField;
    GridIndice2: TGridIndice;
    BGeraTelemarketing: TBitBtn;
    BEnviar: TBitBtn;
    TarefasQTDEMAILENVIADO: TFMTBCDField;
    TarefasQTDNAOENVIADO: TFMTBCDField;
    BExcluir: TBitBtn;
    BitBtn1: TBitBtn;
    BotaoAlterar1: TBotaoAlterar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure TarefasAfterScroll(DataSet: TDataSet);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoConsultar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
    procedure EDatInicialExit(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    VprOrdem: String;
    VprDTarefa : TRBDTarefaEMarketingProspect;
    FunEmarketingProspect : TRBFuncoesEMarketingProspect;
    procedure AtualizaConsulta;
    procedure PosItens;
  public
  end;

var
  FTarefaEMarketingProspect: TFTarefaEMarketingProspect;

implementation
uses
  FunData, FunSql, ANovaTarefaEMarketingProspect, APrincipal, ConstMsg, AEnvioEmarketingProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTarefaEMarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEmarketingProspect := TRBFuncoesEMarketingProspect.cria(FPrincipal.bASEdADOS);
  VprDTarefa := TRBDTarefaEMarketingProspect.cria;
  EDatInicial.DateTime:= PrimeiroDiaMes(date);
  EDatFinal.DateTime:= UltimoDiaMes(date);
  VprOrdem:= ' ORDER BY SEQTAREFA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTarefaEMarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunEmarketingProspect.free;
  Tarefas.close;
  TarefaItem.close;
  VprDTarefa.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BitBtn1Click(Sender: TObject);
begin
  if TarefasSEQTAREFA.AsInteger <> 0 then
  begin
    FunEmarketingProspect.ExcluiemailclientesEficacia(TarefasSEQTAREFA.AsInteger);
    aviso('E-mails excluidos com sucesso');
  end
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.AtualizaConsulta;
begin
  TarefaItem.Close;
  Tarefas.close;
  Tarefas.SQL.Clear;
  Tarefas.SQL.Add('SELECT'+
                  ' TMP.SEQTAREFA, TMP.DATTAREFA,TMP.QTDEMAIL,TMP.DATPROPOSTADESDE,'+
                  ' TMP.QTDEMAILENVIADO, TMP.QTDNAOENVIADO, '+
                  ' REG.C_NOM_REG,'+
                  ' PRO.C_NOM_PRO,'+
                  ' CLA.C_NOM_CLA,'+
                  ' USU.C_NOM_USU'+
                  ' FROM'+
                  ' TAREFAEMARKETINGPROSPECT TMP, CADREGIAOVENDA REG,'+
                  ' CADPRODUTOS PRO, CADCLASSIFICACAO CLA, CADUSUARIOS USU'+
                  ' WHERE'+ SQLTextoRightJoin('TMP.CODREGIAO','REG.I_COD_REG')+
                  ' AND '+SQLTextoRightJoin('TMP.CODCLASSIFICACAO','CLA.C_COD_CLA')+
                  ' AND '+SQLTextoRightJoin('TMP.SEQPRODUTO','PRO.I_SEQ_PRO')+
                  ' AND TMP.CODUSUARIO = USU.I_COD_USU');
  Tarefas.SQL.Add(SQLTextoDataEntreAAAAMMDD('DATTAREFA',EDatInicial.Datetime,incdia(EDatfinal.Datetime,1),True));
  Tarefas.SQL.Add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy:= Tarefas.SQL.Count - 1;
  Tarefas.Open;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.PosItens;
begin
  if TarefasSEQTAREFA.AsInteger <> 0 then
    AdicionaSQLAbreTabela(TarefaItem,'SELECT TMI.NOMCONTATO, TMI.INDENVIADO, TMI.DESERRO, '+
                                     ' TMI.DESEMAIL '+
                                     ' FROM TAREFAEMARKETINGPROSPECTITEM TMI '+
                                     ' Where TMI.SEQTAREFA = '+TarefasSEQTAREFA.AsString+
                                     ' order by TMI.DESEMAIL');
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.TarefasAfterScroll(DataSet: TDataSet);
begin
  PosItens;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.GridIndice1Ordem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BotaoCadastrar1AntesAtividade(
  Sender: TObject);
begin
  FNovaTarefaEMarketingProspect:= TFNovaTarefaEMarketingProspect.CriarSDI(Application,'',True);
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BotaoCadastrar1DepoisAtividade(
  Sender: TObject);
begin
  FNovaTarefaEMarketingProspect.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BotaoConsultar1Atividade(
  Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaTarefaEMarketingProspect.TAREFAEMARKETINGPROSPECT,
                        'SELECT * FROM TAREFAEMARKETINGPROSPECT'+
                        ' WHERE SEQTAREFA = '+InttoStr(TarefasSEQTAREFA.AsInteger));
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BotaoExcluir1DepoisAtividade(
  Sender: TObject);
begin
  FNovaTarefaEMarketingProspect.Show;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaTarefaEMarketingProspect.Close;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BEnviarClick(Sender: TObject);
begin
  if TarefasSEQTAREFA.AsInteger <> 0 then
  begin
    FEnvioEMarketingProspect := TFEnvioEMarketingProspect.criarSDI(Application,'',FPrincipal.VerificaPermisao('FEnvioEMarketingProspect'));
    FEnvioEMarketingProspect.EnviaEmail(TarefasSEQTAREFA.AsInteger);
    FEnvioEMarketingProspect.free;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.BExcluirClick(Sender: TObject);
begin
  if TarefasSEQTAREFA.AsInteger <> 0 then
  begin
    if confirmacao('Tem certeza que deseja excluir o item selecionado') then
    begin
      FunEmarketingProspect.ExcluiTarefaEmarketing(TarefasSEQTAREFA.AsInteger);
      AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFTarefaEMarketingProspect.EDatInicialExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTarefaEMarketingProspect]);
end.
