unit ARevisaoExterna;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, Db,
  DBTables, Grids, DBGrids, Tabela, DBKeyViolation, UnOrdemProducao, UnDadosProduto,
  Localizacao;

type
  TFRevisaoExterna = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EOrdemProducao: TEditColor;
    Label1: TLabel;
    ColetaOPCorpo: TQuery;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label3: TLabel;
    BFechar: TBitBtn;
    DataColetaOpCorpo: TDataSource;
    ColetaOPCorpoEMPFIL: TIntegerField;
    ColetaOPCorpoSEQORD: TIntegerField;
    ColetaOPCorpoSEQCOL: TIntegerField;
    ColetaOPCorpoDATCOL: TDateTimeField;
    ColetaOPCorpoINDFIN: TStringField;
    ColetaOPCorpoINDREP: TStringField;
    ColetaOpItem: TQuery;
    DataColetaOpItem: TDataSource;
    ColetaOPCorpoC_NOM_PRO: TStringField;
    ColetaOPCorpoUNMPED: TStringField;
    ColetaOpItemCODCOM: TIntegerField;
    ColetaOpItemCODMAN: TStringField;
    ColetaOpItemNROFIT: TIntegerField;
    ColetaOpItemMETCOL: TFloatField;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    GridIndice2: TGridIndice;
    Localiza: TConsultaPadrao;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    ECodUsuario: TEditLocaliza;
    BRevisaoExterna: TBitBtn;
    ColetaOPCorpoC_NOM_USU: TStringField;
    ColetaOPCorpoDATREV: TDateTimeField;
    ColetaOPCorpoCODUSU: TIntegerField;
    ColetaOPCorpoCODPRO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EOrdemProducaoExit(Sender: TObject);
    procedure EOrdemProducaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ColetaOPCorpoAfterScroll(DataSet: TDataSet);
    procedure BAdicionarClick(Sender: TObject);
    procedure BRevisaoExternaClick(Sender: TObject);
  private
    { Private declarations }
    VprDColetaOP : TRBDColetaOP;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure AtualizaConsulta;
    procedure AtualizaConsultaItem;
  public
    { Public declarations }
  end;

var
  FRevisaoExterna: TFRevisaoExterna;

implementation

uses APrincipal,Constantes, FunSql, FunData, ConstMsg, ANovaRevisaoExterna;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRevisaoExterna.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprDColetaOP := TRBDColetaOP.cria;
  EDatInicio.DateTime := decDia(date,1);
  EDatFim.DateTime := date;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRevisaoExterna.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDColetaOP.free;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRevisaoExterna.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFRevisaoExterna.AtualizaConsulta;
Var
  vpfPosicao : TBookMark;
begin
  VpfPosicao := ColetaOPCorpo.GetBookmark;
  ColetaOPCorpo.Sql.Clear;
  ColetaOPCorpo.Sql.Add('select OPC.EMPFIL, OPC.SEQORD, OPC.SEQCOL, OPC.DATCOL,'+
                        ' OPC.INDFIN, OPC.INDREP, ' +
                        ' PRO.C_NOM_PRO, '+
                        ' OP.UNMPED, OP.CODPRO, USU.C_NOM_USU, OPE.DATREV, OPE.CODUSU '+
                        ' from coletaopcorpo opc, ORDEMPRODUCAOCORPO OP, '+
                        ' CADPRODUTOS PRO, REVISAOOPEXTERNA OPE, CADUSUARIOS USU'+
                        ' Where OPC.EMPFIL = OP.EMPFIL'+
                        ' AND OPC.SEQORD = OP.SEQORD'+
                        ' AND OP.SEQPRO = PRO.I_SEQ_PRO'+
                        ' AND OPE.EMPFIL = OPC.EMPFIL '+
                        ' AND OPE.SEQORD = OPC.SEQORD '+
                        ' AND OPE.SEQCOL = OPC.SEQCOL '+
                        ' AND USU.I_COD_USU = OPE.CODUSU' );
  if config.EstoqueCentralizado then
    ColetaOPCorpo.Sql.Add('and OPC.EMPFIL = '+ InttoStr(Varia.CodFilialControladoraEstoque))
  else
    ColetaOpCorpo.Sql.add('and OPC.EMPFIL = '+ IntToStr(Varia.CodigoEMpfil));
  if EOrdemProducao.AInteiro <> 0 then
    ColetaOPCorpo.Sql.Add('and OPC.SEQORD = '+ EOrdemProducao.Text)
  else
  begin
    ColetaOPCorpo.Sql.Add('and OPE.DATREV >= '+SQLTextoDataAAAAMMMDD(EDatInicio.DateTime)+
                          ' and OPE.DATREV <= '+SQLTextoDataAAAAMMMDD(EDatFim.DateTime));
    if ECodUsuario.Ainteiro <> 0 then
      ColetaOPCorpo.Sql.Add('and OPE.CODUSU = '+EcodUsuario.Text);

  end;
  ColetaOPCorpo.Sql.SaveToFile('c:\consulta.sql');
  ColetaOPCorpo.Open;
  try
    ColetaOPCorpo.GotoBookmark(vpfPosicao);
    ColetaOPCorpo.FreeBookmark(vpfPosicao);
  except
  end;
end;

{******************************************************************************}
procedure TFRevisaoExterna.AtualizaConsultaItem;
begin
  ColetaOpItem.Sql.Clear;
  IF ColetaOPCorpoSEQORD.AsInteger <> 0 then
  begin
    ColetaOpItem.Sql.Add('select OPI.CODCOM,OPI.CODMAN, OPI.NROFIT, OPI.METCOL'+
                         ' from COLETAOPITEM OPI '+
                         ' Where EMPFIL = '+ ColetaOPCorpoEMPFIL.AsString+
                         ' and SEQORD = '+ColetaOPCorpoSEQORD.AsString+
                         ' and SEQCOL = ' + ColetaOPCorpoSEQCOL.AsString);
    ColetaOpItem.Sql.SaveToFile('C:\consulta.sql');
    ColetaOpItem.Open;
  end;
end;

{******************************************************************************}
procedure TFRevisaoExterna.EOrdemProducaoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRevisaoExterna.EOrdemProducaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRevisaoExterna.ColetaOPCorpoAfterScroll(
  DataSet: TDataSet);
begin
  AtualizaConsultaItem;
end;

procedure TFRevisaoExterna.BAdicionarClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFRevisaoExterna.BRevisaoExternaClick(Sender: TObject);
begin
  if confirmacao(CT_DeletaRegistro) then
  begin
    FunOrdemProducao.ExcluiRevisaoExterna(ColetaOPCorpoEMPFIL.AsString,ColetaOPCorpoSEQORD.AsString,ColetaOPCorpoSEQCOL.AsString,ColetaOPCorpoCODUSU.AsString);
    AtualizaConsulta;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRevisaoExterna]);
end.
