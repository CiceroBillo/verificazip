unit ARemessas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela,
  DBKeyViolation, StdCtrls, Buttons, Db, DBTables, ComCtrls, UnDados, Unremessa,
  DBClient;

type
  TFRemessas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BExcluirItem: TBitBtn;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    RemessaCorpo: TSQL;
    DataRemessaCorpo: TDataSource;
    PanelColor3: TPanelColor;
    GRemessa: TGridIndice;
    GRemessaItem: TGridIndice;
    Splitter1: TSplitter;
    RemessaCorpoSEQREMESSA: TFMTBCDField;
    RemessaCorpoDATINICIO: TSQLTimeStampField;
    RemessaCorpoDATENVIO: TSQLTimeStampField;
    RemessaCorpoI_COD_BAN: TFMTBCDField;
    RemessaCorpoC_NRO_CON: TWideStringField;
    RemessaCorpoC_NOM_BAN: TWideStringField;
    Label1: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label2: TLabel;
    ESituacao: TComboBoxColor;
    Label3: TLabel;
    RemessaItem: TSQL;
    RemessaItemC_NOM_CLI: TWideStringField;
    RemessaItemD_DAT_EMI: TSQLTimeStampField;
    RemessaItemC_NRO_DUP: TWideStringField;
    RemessaItemD_DAT_VEN: TSQLTimeStampField;
    RemessaItemN_VLR_PAR: TFMTBCDField;
    DataRemessaItem: TDataSource;
    RemessaCorpoCODFILIAL: TFMTBCDField;
    RemessaItemCODFILIAL: TFMTBCDField;
    RemessaItemSEQREMESSA: TFMTBCDField;
    RemessaItemLANRECEBER: TFMTBCDField;
    RemessaItemNUMPARCELA: TFMTBCDField;
    BarraStatus: TStatusBar;
    BImprimir: TBitBtn;
    BBloquear: TBitBtn;
    RemessaCorpoDATBLOQUEIO: TSQLTimeStampField;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ESituacaoClick(Sender: TObject);
    procedure GRemessaOrdem(Ordem: String);
    procedure GRemessaItemOrdem(Ordem: String);
    procedure RemessaCorpoAfterScroll(DataSet: TDataSet);
    procedure BExcluirItemClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BBloquearClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    VprOrdem, VprOrdemItem :String;
    FunRemessa :TRBFuncoesRemessa;
    procedure AtualizaConsulta(VpaPosicionar : Boolean = false);
    procedure AtualizaConsultaItem;
  public
    { Public declarations }
  end;

var
  FRemessas: TFRemessas;

implementation

uses APrincipal, FunData,FunSql, ConstMsg, UnContasAreceber, uncrystal, Constantes,
  dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRemessas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunRemessa := TRBFuncoesRemessa.cria(FPrincipal.BaseDados);
  Vprordem := 'order by DATINICIO';
  VprOrdemItem := 'Order by CLI.C_NOM_CLI';
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  ESituacao.ItemIndex := 1;
  atualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRemessas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  RemessaCorpo.Close;
  FunRemessa.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRemessas.AtualizaConsulta(VpaPosicionar : Boolean = false);
Var
  VpfPosicao : TBookmark;
begin
  RemessaItem.Close;
  VpfPosicao := RemessaCorpo.GetBookmark;
  RemessaCorpo.Close;
  RemessaCorpo.Sql.Clear;
  RemessaCorpo.Sql.Add('select REM.CODFILIAL,REM.SEQREMESSA, REM.DATINICIO, REM.DATENVIO, '+
                       ' REM.DATBLOQUEIO, '+
                       ' CON.I_COD_BAN, CON.C_NRO_CON,BAN.C_NOM_BAN '+
                       ' from REMESSACORPO REM, CADCONTAS CON, CADBANCOS BAN '+
                       ' Where REM.NUMCONTA = CON.C_NRO_CON '+
                       ' AND REM.CODFILIAL = '+IntToStr(Varia.codigoEmpfil) +
                       ' AND CON.I_COD_BAN = BAN.I_COD_BAN ');
  RemessaCorpo.Sql.Add(SQLTextoDataEntreAAAAMMDD('DATINICIO',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
  case ESituacao.ItemIndex of
    1 : RemessaCorpo.Sql.Add('AND REM.DATENVIO IS NULL');
    2 : RemessaCorpo.Sql.Add('AND REM.DATENVIO IS NOT NULL');
  end;
  RemessaCorpo.Sql.add(VprOrdem);
  GRemessa.ALinhaSQLOrderBy := RemessaCorpo.Sql.Count-1;
  RemessaCorpo.open;
  if VpaPosicionar then
  begin
    try
      RemessaCorpo.GotoBookmark(VpfPosicao);
    except
    end;
    RemessaCorpo.FreeBookmark(VpfPosicao);
  end;
end;

{******************************************************************************}
procedure TFRemessas.AtualizaConsultaItem;
begin
  RemessaItem.close;
  RemessaItem.sql.Clear;
  if RemessaCorpoCODFILIAL.AsInteger <> 0 then
  begin
    RemessaItem.Sql.Add('select ITE.CODFILIAL, ITE.SEQREMESSA, ITE.LANRECEBER, ITE.NUMPARCELA, '+
                        ' CLI.C_NOM_CLI, CAD.D_DAT_EMI, MOV.C_NRO_DUP, MOV.D_DAT_VEN, MOV.N_VLR_PAR '+
                        ' from CADCLIENTES CLI, CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV, REMESSAITEM ITE '+
                        ' Where CLI.I_COD_CLI = CAD.I_COD_CLI '+
                        ' and MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                        ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                        ' AND ITE.CODFILIAL = MOV.I_EMP_FIL '+
                        ' AND ITE.LANRECEBER = MOV.I_LAN_REC '+
                        ' AND ITE.NUMPARCELA = MOV.I_NRO_PAR '+
                        ' and ITE.CODFILIAL = '+RemessaCorpoCODFILIAL.AsString+
                        ' and ITE.SEQREMESSA = '+RemessaCorpoSEQREMESSA.AsString);
    RemessaItem.Sql.add(VprOrdemItem);
    remessaItem.Open;
    GRemessaItem.ALinhaSQLOrderBy := RemessaItem.Sql.Count-1;
  end;
end;

{******************************************************************************}
procedure TFRemessas.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFRemessas.ESituacaoClick(Sender: TObject);
begin
  Atualizaconsulta;
end;

{******************************************************************************}
procedure TFRemessas.GRemessaOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFRemessas.GRemessaItemOrdem(Ordem: String);
begin
  VprOrdemItem := Ordem;
end;

{******************************************************************************}
procedure TFRemessas.RemessaCorpoAfterScroll(DataSet: TDataSet);
begin
  AtualizaConsultaItem;
  BBloquear.Enabled := RemessaCorpoDATBLOQUEIO.IsNull;
end;

{******************************************************************************}
procedure TFRemessas.BExcluirItemClick(Sender: TObject);
begin
  if confirmacao(CT_DeletarItem) then
  begin
    if RemessaItemCODFILIAL.AsInteger <> 0 then
    begin
      FunContasAReceber.ExcluiItemRemessa(RemessaItemCODFILIAL.asInteger,RemessaItemSEQREMESSA.AsInteger,RemessaItemLANRECEBER.AsInteger,RemessaItemNUMPARCELA.AsInteger);
      AtualizaConsulta(true);
    end;
  end;
end;

{**********************************************************************************}
procedure TFRemessas.BGerarClick(Sender: TObject);
var
  VpfDRemessa : TRBDRemessaCorpo;
  VpfResultado : String;
begin
  if RemessaCorpoCODFILIAL.AsInteger <> 0 then
  begin
    VpfDRemessa := TRBDRemessaCorpo.cria;
    VpfDRemessa.CodFilial := RemessaCorpoCODFILIAL.AsInteger;
    VpfDRemessa.SeqRemessa := RemessaCorpoSEQREMESSA.AsInteger;
    FunRemessa.CarDRemessa(VpfDRemessa);
    VpfResultado := FunRemessa.GeraRemessa(VpfDRemessa,BarraStatus);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      dtRave := TdtRave.create(self);
      dtRave.ImprimeRemessa(RemessaCorpoCodFilial.AsInteger,RemessaCorpoSEQremessa.AsInteger);
      dtRave.free;
      AtualizaConsulta(true);
    end;
    VpfDRemessa.free;
  end;
end;

{**********************************************************************************}
procedure TFRemessas.BImprimirClick(Sender: TObject);
begin
  if RemessaCorpoSEQremessa.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeRemessa(RemessaCorpoCodFilial.AsInteger,RemessaCorpoSEQremessa.AsInteger);
    dtRave.free;
    Atualizaconsulta(False);
  end;
end;

{******************************************************************************}
procedure TFRemessas.BitBtn1Click(Sender: TObject);
begin
  RemessaItem.First;
  dtRave := TdtRave.Create(self);
  while not RemessaItem.Eof do
  begin
    dtRave.ImprimeDuplicata(RemessaCorpoCODFILIAL.AsInteger,RemessaItemLANRECEBER.AsInteger,RemessaItemNUMPARCELA.AsInteger,false);
    RemessaItem.Next;
  end;
  dtRave.Free;
end;

{******************************************************************************}
procedure TFRemessas.BBloquearClick(Sender: TObject);
begin
  if RemessaCorpoCODFILIAL.AsInteger <> 0 then
  begin
    FunRemessa.BloqueiaRemessa(RemessaCorpoCODFILIAL.AsInteger,RemessaCorpoSEQREMESSA.AsInteger);
    AtualizaConsulta;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRemessas]);
end.
