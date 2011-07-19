unit AOrdensProducaoCadarco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls, UnDadosProduto, UnOrdemProducao,
  PainelGradiente, Db, DBTables, StdCtrls, Mask, numericos, Buttons, DBClient;

type
  TFOrdensProducaoCadarco = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    ENumPedido: Tnumerico;
    OrdemProducaoCorpo: TSQL;
    DataOrdemProducaoCorpo: TDataSource;
    OrdemProducaoCorpoEMPFIL: TFMTBCDField;
    OrdemProducaoCorpoSEQORD: TFMTBCDField;
    OrdemProducaoCorpoCODCLI: TFMTBCDField;
    OrdemProducaoCorpoNUMPED: TFMTBCDField;
    OrdemProducaoCorpoTIPPED: TFMTBCDField;
    OrdemProducaoCorpoCODUSU: TFMTBCDField;
    OrdemProducaoCorpoC_NOM_USU: TWideStringField;
    OrdemProducaoCorpoC_NOM_CLI: TWideStringField;
    OrdemProducaoCorpoTipoPedido: TWideStringField;
    BAlterar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    OpItem: TSQL;
    DataOpItem: TDataSource;
    OpItemQTDMET: TFMTBCDField;
    OpItemDESENG: TWideStringField;
    OpItemQTDFUS: TFMTBCDField;
    OpItemNROFIO: TFMTBCDField;
    OpItemTITFIO: TWideStringField;
    OpItemDESENC: TWideStringField;
    OpItemNROMAQ: TFMTBCDField;
    OpItemNUMTAB: TFMTBCDField;
    OpItemC_NOM_PRO: TWideStringField;
    OpItemNOM_COR: TWideStringField;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    GridIndice2: TGridIndice;
    Splitter1: TSplitter;
    OpItemGROPRO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OrdemProducaoCorpoCalcFields(DataSet: TDataSet);
    procedure ENumPedidoExit(Sender: TObject);
    procedure ENumPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BFecharClick(Sender: TObject);
    procedure OrdemProducaoCorpoAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
  private
    { Private declarations }
    VprDOP : TRBDOrdemProducaoEtiqueta;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure AtualizaConsulta;
    procedure AtualizaConsultaItem;
  public
    { Public declarations }
    procedure ConsultaOrdensProducao;
    procedure ConsultaOPCotacao(VpaSeqOrcamento : Integer);
  end;

var
  FOrdensProducaoCadarco: TFOrdensProducaoCadarco;

implementation

uses APrincipal, FunSql, ANovaOrdemProducaoCadarco, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFOrdensProducaoCadarco.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFOrdensProducaoCadarco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFOrdensProducaoCadarco.OrdemProducaoCorpoCalcFields(
  DataSet: TDataSet);
begin
  case OrdemProducaoCorpoTIPPED.AsInteger of
    0 : OrdemProducaoCorpoTipoPedido.AsString := 'Espula Grande';
    1 : OrdemProducaoCorpoTipoPedido.AsString := 'Espula Pequena';
    2 : OrdemProducaoCorpoTipoPedido.AsString := 'Espula Transilin';
  end;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.AtualizaConsulta;
begin
  OrdemProducaoCorpo.Close;
  OrdemProducaoCorpo.sql.clear;
  OrdemProducaoCorpo.Sql.add('Select ORD.EMPFIL, ORD.SEQORD, ORD.DATEMI, ORD.DATENP, ORD.CODCLI, ORD.NUMPED,'+
                             ' ORD.TIPPED, ORD.CODUSU, USU.C_NOM_USU, CLI.C_NOM_CLI '+
                             ' from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI, CADUSUARIOS USU '+
                             ' Where ORD.CODCLI = CLI.I_COD_CLI '+
                             ' AND ORD.CODUSU = USU.I_COD_USU');
  if ENumPedido.AsInteger <> 0 then
    OrdemProducaoCorpo.Sql.add('and ORD.NUMPED = '+ENumPedido.text);
  OrdemProducaoCorpo.SQL.ADD('order by ORD.NUMPED');
  GridIndice1.ALinhaSQLOrderBy := OrdemProducaoCorpo.sQL.Count -1;
  OrdemProducaoCorpo.open;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.AtualizaConsultaItem;
begin
  if OrdemProducaoCorpoSEQORD.AsInteger <> 0 then
  begin
    AdicionaSQLAbreTabela(OpItem,'Select ITE.QTDMET, ITE.GROPRO, ITE.DESENG, ITE.QTDFUS, ITE.NROFIO, ITE.TITFIO, ' +
                   ' ITE.DESENC, ITE.NROMAQ, ITE.NUMTAB, '+
                   ' PRO.C_NOM_PRO, ' +
                   ' COR.NOM_COR '+
                   ' from OPITEMCADARCO ITE, CADPRODUTOS PRO, COR '+
                   ' where ITE.EMPFIL = '+OrdemProducaoCorpoEMPFIL.AsString +
                   ' and ITE.SEQORD = '+ OrdemProducaoCorpoSEQORD.AsString +
                   ' and ITE.SEQPRO = PRO.I_SEQ_PRO '+
                   ' and ITE.CODCOR = COR.COD_COR'+
                   ' order by ITE.SEQITE');
  end
  else
    OpItem.Close;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.ENumPedidoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.ENumPedidoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.ConsultaOrdensProducao;
begin
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.ConsultaOPCotacao(VpaSeqOrcamento : Integer);
begin
  ENumPedido.AsInteger := VpaSeqOrcamento;
  AtualizaConsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.BFecharClick(Sender: TObject);
begin
 close;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.OrdemProducaoCorpoAfterScroll(
  DataSet: TDataSet);
begin
  AtualizaConsultaItem;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.BImprimirClick(Sender: TObject);
begin
  if OrdemProducaoCorpoSEQORD.AsInteger <> 0 then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeOPCadarcoTrancado(OrdemProducaoCorpoEMPFIL.AsInteger,OrdemProducaoCorpoSEQORD.AsInteger,true);
    dtRave.Free;
  end;
end;

{******************************************************************************}
procedure TFOrdensProducaoCadarco.BAlterarClick(Sender: TObject);
begin
  if OrdemProducaoCorpoSEQORD.AsInteger <> 0 then
  begin
    VprDOP := TRBDOrdemProducaoEtiqueta.cria;
    VprDOP.CodEmpresafilial := OrdemProducaoCorpoEMPFIL.AsInteger;
    VprDOP.SeqOrdem := OrdemProducaoCorpoSEQORD.AsInteger;
    FunOrdemProducao.CarDOrdemProducao(VprDOP);
    FNovaOrdemProducaoCadarco := TFNovaOrdemProducaoCadarco.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaOrdemProducaoCadarco'));
    FNovaOrdemProducaoCadarco.AlteraOP(VprDOP);
    FNovaOrdemProducaoCadarco.free;
    VprDOp.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFOrdensProducaoCadarco]);
end.
