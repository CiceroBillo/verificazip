unit AAdicionaColetaOPRomaneio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, Db,
  DBTables, Grids, DBGrids, Tabela, DBKeyViolation, UnOrdemProducao, UnDadosProduto, DBClient;

type
  TFAdicionaColetaOPRomaneio = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EOrdemProducao: TEditColor;
    Label1: TLabel;
    ColetaOPCorpo: TSQL;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label3: TLabel;
    BAdicionar: TBitBtn;
    BFechar: TBitBtn;
    DataColetaOpCorpo: TDataSource;
    ColetaOPCorpoEMPFIL: TFMTBCDField;
    ColetaOPCorpoSEQORD: TFMTBCDField;
    ColetaOPCorpoSEQCOL: TFMTBCDField;
    ColetaOPCorpoDATCOL: TSQLTimeStampField;
    ColetaOPCorpoINDFIN: TWideStringField;
    ColetaOPCorpoINDREP: TWideStringField;
    ColetaOpItem: TSQL;
    DataColetaOpItem: TDataSource;
    ColetaOPCorpoC_NOM_PRO: TWideStringField;
    ColetaOPCorpoUNMPED: TWideStringField;
    ColetaOpItemCODCOM: TFMTBCDField;
    ColetaOpItemCODMAN: TWideStringField;
    ColetaOpItemNROFIT: TFMTBCDField;
    ColetaOpItemMETCOL: TFMTBCDField;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    GridIndice2: TGridIndice;
    ESituacao: TComboBoxColor;
    Label4: TLabel;
    BRevisaoExterna: TBitBtn;
    BImprimir: TBitBtn;
    CVisualizar: TCheckBox;
    ColetaOPCorpoCODPRO: TWideStringField;
    ColetaOPCorpoTIPPED: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EOrdemProducaoExit(Sender: TObject);
    procedure EOrdemProducaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ColetaOPCorpoAfterScroll(DataSet: TDataSet);
    procedure BAdicionarClick(Sender: TObject);
    procedure BRevisaoExternaClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
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
  FAdicionaColetaOPRomaneio: TFAdicionaColetaOPRomaneio;

implementation

uses APrincipal,Constantes, FunSql, FunData, ConstMsg, ANovaRevisaoExterna, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAdicionaColetaOPRomaneio.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprDColetaOP := TRBDColetaOP.cria;
  ESituacao.ItemIndex := 0;
  EDatInicio.DateTime := decDia(date,1);
  EDatFim.DateTime := IncDia(date,1);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAdicionaColetaOPRomaneio.FormClose(Sender: TObject; var Action: TCloseAction);
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
procedure TFAdicionaColetaOPRomaneio.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.AtualizaConsulta;
Var
  vpfPosicao : TBookMark;
begin
  VpfPosicao := ColetaOPCorpo.GetBookmark;
  ColetaOPCorpo.Close;
  ColetaOPCorpo.Sql.Clear;
  ColetaOPCorpo.Sql.Add('select OPC.EMPFIL, OPC.SEQORD, OPC.SEQCOL, OPC.DATCOL,'+
                        ' OPC.INDFIN, OPC.INDREP, ' +
                        ' PRO.C_NOM_PRO, '+
                        ' OP.UNMPED, OP.CODPRO, OP.TIPPED '+
                        ' from coletaopcorpo opc, ORDEMPRODUCAOCORPO OP, '+
                        ' CADPRODUTOS PRO '+
                        ' Where OPC.EMPFIL = OP.EMPFIL'+
                        ' AND OPC.SEQORD = OP.SEQORD'+
                        ' AND OP.SEQPRO = PRO.I_SEQ_PRO');
  if config.EstoqueCentralizado then
    ColetaOpCorpo.Sql.Add('and OPC.EMPFIL = '+IntTostr(Varia.CodFilialControladoraEstoque))
  else
    ColetaOpCorpo.Sql.Add('and OPC.EMPFIL = '+IntToStr(Varia.CodigoEmpFil));

  if EOrdemProducao.AInteiro <> 0 then
    ColetaOPCorpo.Sql.Add('and OPC.SEQORD = '+ EOrdemProducao.Text)
  else
  begin
    ColetaOPCorpo.Sql.Add('and OPC.DATCOL >= '+SQLTextoDataAAAAMMMDD(EDatInicio.DateTime)+
                          ' and OPC.DATCOL <= '+SQLTextoDataAAAAMMMDD(EDatFim.DateTime));
  end;
  case ESituacao.ItemIndex of
    0 : ColetaOPCorpo.SQL.Add('and OPC.INDROM = ''N''');
    1 : ColetaOPCorpo.SQL.Add('and OPC.INDROM = ''S''');
  end;
  ColetaOPCorpo.Open;
  try
    ColetaOPCorpo.GotoBookmark(vpfPosicao);
    ColetaOPCorpo.FreeBookmark(vpfPosicao);
  except
  end;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.AtualizaConsultaItem;
begin
  ColetaOpItem.Close;
  ColetaOpItem.Sql.Clear;
  IF ColetaOPCorpoSEQORD.AsInteger <> 0 then
  begin
    ColetaOpItem.Sql.Add('select OPI.CODCOM,OPI.CODMAN, OPI.NROFIT, OPI.METCOL'+
                         ' from COLETAOPITEM OPI '+
                         ' Where EMPFIL = '+ ColetaOPCorpoEMPFIL.AsString+
                         ' and SEQORD = '+ColetaOPCorpoSEQORD.AsString+
                         ' and SEQCOL = ' + ColetaOPCorpoSEQCOL.AsString);
    ColetaOpItem.Open;
  end;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.EOrdemProducaoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.EOrdemProducaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.ColetaOPCorpoAfterScroll(
  DataSet: TDataSet);
begin
  AtualizaConsultaItem;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.BAdicionarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if ColetaOPCorpoEMPFIL.AsInteger <> 0 then
  begin
    if ColetaOPCorpoTIPPED.AsInteger = 3 then
      aviso('REPROGRAMAÇÃO NÃO FATURAR!!!'#13'Essa OP é referente a uma reprogramação Não faturar, por isso não pode ser adicionada no romaneio')
    else
    begin
      VpfResultado := FunOrdemProducao.AdicionaColetaRomaneio(ColetaOPCorpoEMPFIL.AsString,ColetaOPCorpoSEQORD.AsString,ColetaOPCorpoSEQCOL.AsString);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
        AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.BRevisaoExternaClick(Sender: TObject);
begin
  VprDColetaOP.CodEmpresaFilial := ColetaOPCorpoEMPFIL.AsInteger;
  VprDColetaOP.SeqOrdemProducao := ColetaOPCorpoSEQORD.AsInteger;
  VprDColetaOP.SeqColeta := ColetaOPCorpoSEQCOL.AsInteger;
  FunOrdemProducao.CarDColetaOP(VprDColetaOP);
  FNovaRevisaoExterna := TFNovaRevisaoExterna.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaRevisaoExterna'));
  FNovaRevisaoExterna.NovaRevisaoExterna(VprDColetaOP);
  FNovaRevisaoExterna.free;
end;

{******************************************************************************}
procedure TFAdicionaColetaOPRomaneio.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeColetaOP(ColetaOPCorpoEMPFIL.AsInteger,ColetaOPCorpoSEQORD.AsInteger,ColetaOPCorpoSEQCOL.AsInteger,CVisualizar.Checked);
  dtRave.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAdicionaColetaOPRomaneio]);
end.
