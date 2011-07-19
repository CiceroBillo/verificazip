unit ATarefaEMarketing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, ExtCtrls, Componentes1, PainelGradiente, UnDados,
  ComCtrls, Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, unEMarketing,
  Localizacao, DBClient;

type
  TFTarefaEMarketing = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoConsultar1: TBotaoConsultar;
    BFechar: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicial: TCalendario;
    EDatFinal: TCalendario;
    TarefaEMarketing: TSQL;
    DataTarefaEMarketing: TDataSource;
    TarefaEMarketingSEQTAREFA: TFMTBCDField;
    TarefaEMarketingDATTAREFA: TSQLTimeStampField;
    TarefaEMarketingC_NOM_REG: TWideStringField;
    TarefaEMarketingC_NOM_PRO: TWideStringField;
    TarefaEMarketingC_NOM_CLA: TWideStringField;
    TarefaEMarketingQTDEMAIL: TFMTBCDField;
    TarefaEMarketingC_NOM_USU: TWideStringField;
    BEnviar: TBitBtn;
    TarefaEMarketingQTDEMAILENVIADO: TFMTBCDField;
    TarefaEmarketingItem: TSQL;
    DataTarefaEmarketingItem: TDataSource;
    TarefaEmarketingItemINDENVIADO: TWideStringField;
    TarefaEmarketingItemDESERRO: TWideStringField;
    TarefaEmarketingItemDATENVIO: TSQLTimeStampField;
    TarefaEmarketingItemC_NOM_CLI: TWideStringField;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    Splitter1: TSplitter;
    Grade: TGridIndice;
    BGeraTelemarketing: TBitBtn;
    EUsuario: TEditLocaliza;
    Localiza: TConsultaPadrao;
    TarefaEmarketingItemNOMCONTATO: TWideStringField;
    BExcluir: TBitBtn;
    TarefaEmarketingItemDESEMAIL: TWideStringField;
    BotaoAlterar1: TBotaoAlterar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EDatInicialExit(Sender: TObject);
    procedure GradeOrdem(Ordem: String);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BotaoExcluir1Atividade(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
    procedure TarefaEMarketingAfterScroll(DataSet: TDataSet);
    procedure BGeraTelemarketingClick(Sender: TObject);
    procedure BotaoExcluir1Click(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
  private
    VprOrdem: String;
    VprDTarefa : TRBDTarefaEMarketing;
    FunEMarketing : TRBFuncoesEMarketing;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
    procedure PosTarefaItem(VpaSeqTarefa : Integer);
  public
    { Public declarations }
  end;

var
  FTarefaEMarketing: TFTarefaEMarketing;

implementation
uses
  APrincipal, FunSQL, FunData, ANovaTarefaEMarketing, ConstMsg,
  AEnvioEmarketing;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTarefaEMarketing.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEMarketing := TRBFuncoesEMarketing.cria(FPrincipal.BaseDados);
  VprDTarefa := TRBDTarefaEMarketing.cria;
  EDatInicial.DateTime:= PrimeiroDiaMes(Date);
  EDatFinal.DateTime:= UltimoDiaMes(Date);
  VprOrdem:= ' ORDER BY TEM.DATTAREFA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTarefaEMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TarefaEMarketing.Close;
  FunEMarketing.free;
  VprDTarefa.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTarefaEMarketing.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.AtualizaConsulta;
begin
  TarefaEmarketingItem.Close;
  TarefaEMarketing.close;
  TarefaEMarketing.SQL.Clear;
  TarefaEMarketing.SQL.Add('SELECT TEM.SEQTAREFA, TEM.DATTAREFA, REV.C_NOM_REG, PRO.C_NOM_PRO,'+
                           ' CLA.C_NOM_CLA, TEM.QTDEMAIL, TEM.QTDEMAILENVIADO, USU.C_NOM_USU'+
                           ' FROM TAREFAEMARKETING TEM, CADREGIAOVENDA REV,'+
                           ' CADPRODUTOS PRO, CADCLASSIFICACAO CLA, CADUSUARIOS USU'+
                           ' WHERE'+SQLTextoRightJoin('TEM.CODREGIAO','REV.I_COD_REG')+
                           ' AND '+SQLTextoRightJoin('TEM.SEQPRODUTO','PRO.I_SEQ_PRO')+
                           ' AND '+SQLTextoRightJoin('TEM.CODCLASSIFICACAO','CLA.C_COD_CLA')+
                           ' AND USU.I_COD_USU = TEM.CODUSUARIO');
  AdicionaFiltros(TarefaEMarketing.SQL);
  TarefaEMarketing.SQL.Add(VprOrdem);
  Grade.ALinhaSQLOrderBy:= TarefaEMarketing.SQL.Count-1;
  TarefaEMarketing.Open;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.AdicionaFiltros(VpaSelect: TStrings);
begin
  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('DATTAREFA',EDatInicial.Datetime,Incdia(EDatFinal.Datetime,1),True));
end;

{******************************************************************************}
procedure TFTarefaEMarketing.PosTarefaItem(VpaSeqTarefa : Integer);
begin
  TarefaEmarketingItem.close;
  TarefaEmarketingItem.sql.clear;
  TarefaEmarketingItem.sql.Add('SELECT TEI.INDENVIADO, TEI.DESERRO, TEI.DATENVIO, '+
                               ' TEI.NOMCONTATO, TEI.DESEMAIL, '+
                               ' CLI.C_NOM_CLI ' +
                               ' FROM TAREFAEMARKETINGITEM TEI, CADCLIENTES CLI '+
                               ' Where CLI.I_COD_CLI = TEI.CODCLIENTE '+
                               ' and TEI.SEQTAREFA = '+IntToStr(VpaSeqTarefa));
  TarefaEmarketingItem.Open;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.EDatInicialExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.GradeOrdem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.BotaoCadastrar1AntesAtividade(
  Sender: TObject);
begin
  FNovaTarefaEMarketing:= TFNovaTarefaEMarketing.CriarSDI(Application,'',True);
end;

{******************************************************************************}
procedure TFTarefaEMarketing.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaTarefaEMarketing.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaTarefaEMarketing.Show;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.BotaoExcluir1DestroiFormulario(
  Sender: TObject);
begin
  FNovaTarefaEMarketing.Close;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTarefaEMarketing.BotaoExcluir1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaTarefaEMarketing.TAREFAEMARKETING,'SELECT * FROM TAREFAEMARKETING'+
                                                               ' WHERE SEQTAREFA = '+InttoStr(TarefaEMarketingSEQTAREFA.AsInteger));
end;

{******************************************************************************}
procedure TFTarefaEMarketing.BotaoExcluir1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFTarefaEMarketing.BEnviarClick(Sender: TObject);
begin
  if TarefaEMarketingSEQTAREFA.AsInteger <> 0 then
  begin
    FEnvioEMarketing := TFEnvioEMarketing.criarSDI(Application,'',FPrincipal.VerificaPermisao('FEnvioEMarketing'));
    FEnvioEMarketing.EnviaEmail(TarefaEMarketingSEQTAREFA.AsInteger);
    FEnvioEMarketing.free;
    AtualizaConsulta;
  end;
end;

procedure TFTarefaEMarketing.BExcluirClick(Sender: TObject);
begin
  if confirmacao(CT_DeletaRegistro) then
  begin
    FunEMarketing.ExcluiTarefa(TarefaEMarketingSEQTAREFA.AsInteger);
    AtualizaConsulta;
  end;

end;

{******************************************************************************}
procedure TFTarefaEMarketing.TarefaEMarketingAfterScroll(
  DataSet: TDataSet);
begin
  PosTarefaItem(TarefaEMarketingSEQTAREFA.AsInteger);
end;

procedure TFTarefaEMarketing.BGeraTelemarketingClick(Sender: TObject);
begin
  if TarefaEMarketingSEQTAREFA.AsInteger <> 0 then
    IF EUsuario.AAbreLocalizacao then
    begin
      FunEMarketing.GeraTarefaTeleMarketing(TarefaEMarketingSEQTAREFA.AsInteger,EUsuario.Ainteiro);
      aviso('Tafefa do Telemarketing gerado com sucesso.');
    end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTarefaEMarketing]);
end.
