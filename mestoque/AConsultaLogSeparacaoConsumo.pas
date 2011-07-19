unit AConsultaLogSeparacaoConsumo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, ExtCtrls, PainelGradiente, ComCtrls, Localizacao, DBClient;

type
  TFConsultaLogSeparacaoConsumo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    BFechar: TBitBtn;
    Log: TSQL;
    DataLog: TDataSource;
    LogDATLOG: TSQLTimeStampField;
    LogCODFILIAL: TFMTBCDField;
    LogSEQORDEM: TFMTBCDField;
    LogSEQFRACAO: TFMTBCDField;
    LogC_COD_PRO: TWideStringField;
    LogC_NOM_PRO: TWideStringField;
    LogCODMATERIAPRIMA: TWideStringField;
    LogNOMMATERIAPRIMA: TWideStringField;
    LogC_NOM_CLI: TWideStringField;
    LogC_NOM_USU: TWideStringField;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    EUsuario: TRBEditLocaliza;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    EFilial: TRBEditLocaliza;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    EOrdemProducao: TRBEditLocaliza;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButton4: TSpeedButton;
    EFracao: TRBEditLocaliza;
    LogQTDBAIXADO: TFMTBCDField;
    LogDESUM: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CPeriodoClick(Sender: TObject);
    procedure EUsuarioFimConsulta(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
    procedure ConsultaLogSeparacaoFracao(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao : Integer);
  end;

var
  FConsultaLogSeparacaoConsumo: TFConsultaLogSeparacaoConsumo;

implementation

uses APrincipal, Funsql, FunDAta;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaLogSeparacaoConsumo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by LOG.DATLOG';
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaLogSeparacaoConsumo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Log.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFConsultaLogSeparacaoConsumo.AtualizaConsulta;
begin
  Log.sql.clear;
  Log.sql.add('select LOG.DATLOG, LOG.CODFILIAL, LOG.SEQORDEM, LOG.SEQFRACAO, LOG.QTDBAIXADO, LOG.DESUM, '+
              ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
              ' MAP.C_COD_PRO CODMATERIAPRIMA, MAP.C_NOM_PRO NOMMATERIAPRIMA, '+
              ' CLI.C_NOM_CLI, USU.C_NOM_USU '+
              ' from  FRACAOOPCONSUMOLOG LOG, ORDEMPRODUCAOCORPO OP, CADCLIENTES CLI, CADPRODUTOS PRO, CADPRODUTOS MAP, COR, '+
              ' CADUSUARIOS USU '+
              ' Where LOG.CODFILIAL = OP.EMPFIL '+
              ' AND LOG.SEQORDEM = OP.SEQORD '+
              ' AND OP.CODCLI = CLI.I_COD_CLI '+
              ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
              ' AND LOG.SEQPRODUTO = MAP.I_SEQ_PRO '+
              ' AND LOG.CODCOR = COR.COD_COR '+
              ' AND LOG.CODUSUARIO = USU.I_COD_USU');
  AdicionaFiltros(Log.sql);
  Log.sql.add(VprOrdem);
  Log.open;
end;

{******************************************************************************}
procedure TFConsultaLogSeparacaoConsumo.AdicionaFiltros(VpaSelect : TStrings);
begin
  if CPeriodo.Checked then
    VpaSelect.add(SQLTextoDataEntreAAAAMMDD('LOG.DATLOG',EDatInicio.DateTime,INCDIA(EDatFim.DateTime,1),true));
  IF EUsuario.AInteiro <> 0 then
    VpaSelect.add(' and LOG.CODUSUARIO = '+EUsuario.Text);
  if Efilial.AInteiro <> 0 then
    VpaSelect.add(' and LOG.CODFILIAL = '+EFilial.Text);
  if EOrdemProducao.AInteiro <> 0 then
    VpaSelect.add(' and LOG.SEQORDEM = '+EOrdemProducao.Text);
  if EFracao.AInteiro <> 0 then
    VpaSelect.add(' and LOG.SEQFRACAO = '+EFracao.Text);
end;

{******************************************************************************}
procedure TFConsultaLogSeparacaoConsumo.ConsultaLogSeparacaoFracao(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao : Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EFracao.AInteiro := VpaSeqFracao;
  CPeriodo.Checked := false;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFConsultaLogSeparacaoConsumo.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConsultaLogSeparacaoConsumo.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaLogSeparacaoConsumo.EUsuarioFimConsulta(
  Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFConsultaLogSeparacaoConsumo.EOrdemProducaoSelect(
  Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI ';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

procedure TFConsultaLogSeparacaoConsumo.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaLogSeparacaoConsumo]);
end.
