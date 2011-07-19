unit AConsultaTransferencias;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, Componentes1, Grids, DBGrids,
  Tabela, DB, DBClient, ComCtrls, FunSql, Constantes, FunData, UnCaixa, DmRave;

type
  TFConsultaTransferencias = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Splitter1: TSplitter;
    GradeItem: TDBGridColor;
    Splitter2: TSplitter;
    GradeCheque: TDBGridColor;
    PanelColor3: TPanelColor;
    BFechar: TBitBtn;
    BGeraArquivo: TBitBtn;
    TransferenciaExternaCorpo: TSQL;
    DataTransferenciaExternaCorpo: TDataSource;
    DataTransferenciaExternaItem: TDataSource;
    TransferenciaExternaItem: TSQL;
    TransferenciaExternaCheque: TSQL;
    DataTransferenciaExternaCheque: TDataSource;
    PanelColor1: TPanelColor;
    Label4: TLabel;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    GradeCorpo: TDBGridColor;
    TransferenciaExternaCorpoSEQTRANSFERENCIA: TFMTBCDField;
    TransferenciaExternaCorpoDATTRANSFERENCIA: TSQLTimeStampField;
    TransferenciaExternaCorpoCODUSUARIO: TFMTBCDField;
    TransferenciaExternaCorpoVALTOTAL: TFMTBCDField;
    TransferenciaExternaCorpoSEQCAIXA: TFMTBCDField;
    TransferenciaExternaCorpoC_NOM_USU: TWideStringField;
    TransferenciaExternaCorpoI_COD_USU: TFMTBCDField;
    TransferenciaExternaItemSEQTRANSFERENCIA: TFMTBCDField;
    TransferenciaExternaItemSEQITEM: TFMTBCDField;
    TransferenciaExternaItemVALATUAL: TFMTBCDField;
    TransferenciaExternaItemI_COD_FRM: TFMTBCDField;
    TransferenciaExternaItemC_NOM_FRM: TWideStringField;
    TransferenciaExternaChequeSEQTRANSFERENCIA: TFMTBCDField;
    TransferenciaExternaChequeSEQITEM: TFMTBCDField;
    TransferenciaExternaChequeSEQITEMCHEQUE: TFMTBCDField;
    TransferenciaExternaChequeSEQCHEQUE: TFMTBCDField;
    TransferenciaExternaChequeSEQCHEQUE_1: TFMTBCDField;
    TransferenciaExternaChequeNOMEMITENTE: TWideStringField;
    TransferenciaExternaChequeNUMCHEQUE: TFMTBCDField;
    TransferenciaExternaChequeVALCHEQUE: TFMTBCDField;
    BImprimir: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGeraArquivoClick(Sender: TObject);
    procedure GradeCorpoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TransferenciaExternaCorpoAfterScroll(DataSet: TDataSet);
    procedure CPeriodoClick(Sender: TObject);
    procedure EDatInicioExit(Sender: TObject);
    procedure EDatFimExit(Sender: TObject);
    procedure GradeItemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeItemCellClick(Column: TColumn);
    procedure TransferenciaExternaItemAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure BImportarClick(Sender: TObject);
  private
     procedure AtualizaConsulta;
     procedure AdicionaFiltros(VpaSelect : TStrings);
     procedure PosTransferenciaExternaItem(VpaSeqTransferencia :integer);
     procedure PosTransferenciaExternaCheque(VpaSeqTransferencia, VpaSeqItem :integer);
  public
    { Public declarations }
  end;

var
  FConsultaTransferencias: TFConsultaTransferencias;

implementation

{$R *.DFM}


{ **************************************************************************** }
procedure TFConsultaTransferencias.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  TransferenciaExternaCorpoVALTOTAL.DisplayFormat:= varia.MascaraValor;
  TransferenciaExternaItemVALATUAL.DisplayFormat:= varia.MascaraValor;
  TransferenciaExternaChequeVALCHEQUE.DisplayFormat:= varia.MascaraValor;
  EDatInicio.Date:= PrimeiroDiaMes(date);
  EDatFim.Date:= UltimoDiaMes(date);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.GradeCorpoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key in[37..40]  then
    PosTransferenciaExternaItem(TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaTransferencias.GradeItemCellClick(Column: TColumn);
begin
  PosTransferenciaExternaCheque(TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger, TransferenciaExternaItemSEQITEM.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaTransferencias.GradeItemKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key in[37..40]  then
    PosTransferenciaExternaCheque(TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger, TransferenciaExternaItemSEQITEM.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaTransferencias.PosTransferenciaExternaCheque(VpaSeqTransferencia, VpaSeqItem: integer);
begin
  TransferenciaExternaCheque.close;
  if VpaSeqTransferencia <> 0 then
  begin
    TransferenciaExternaCheque.sql.clear;
    TransferenciaExternaCheque.sql.add('SELECT TRA.SEQTRANSFERENCIA, TRA.SEQITEM, TRA.SEQITEMCHEQUE, TRA.SEQCHEQUE,  ' +
                                     ' CHE.SEQCHEQUE, CHE.NOMEMITENTE, CHE.NUMCHEQUE, CHE.VALCHEQUE ' +
                                     ' FROM TRANSFERENCIAEXTERNACHEQUE TRA, CHEQUE CHE ' +
                                     ' WHERE TRA.SEQCHEQUE = CHE.SEQCHEQUE' +
                                     ' AND TRA.SEQTRANSFERENCIA = ' + IntToStr(VpaSeqTransferencia)+
                                     ' AND TRA.SEQITEM = ' + IntToStr(VpaSeqItem));
    TransferenciaExternaCheque.sql.add(' order by TRA.SEQITEMCHEQUE');
    TransferenciaExternaCheque.open;
  end;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.PosTransferenciaExternaItem(VpaSeqTransferencia: integer);
Var
  VpfPosicao: TBookmark;
begin
  TransferenciaExternaItem.close;
  if VpaSeqTransferencia <> 0 then
  begin
    TransferenciaExternaitem.sql.clear;
    TransferenciaExternaitem.sql.add('SELECT TRA.SEQTRANSFERENCIA, TRA.SEQITEM, TRA.VALATUAL,  ' +
                                     ' FRM.I_COD_FRM, FRM.C_NOM_FRM ' +
                                     ' FROM TRANSFERENCIAEXTERNAITEM TRA, CADFORMASPAGAMENTO FRM ' +
                                     ' WHERE TRA.CODFORMAPAGAMENTO = FRM.I_COD_FRM' +
                                     ' AND TRA.SEQTRANSFERENCIA = ' + IntToStr(VpaSeqTransferencia));
    TransferenciaExternaitem.sql.add(' order by TRA.SEQITEM ');
    TransferenciaExternaitem.open;
  end;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.TransferenciaExternaCorpoAfterScroll(
  DataSet: TDataSet);
begin
   PosTransferenciaExternaItem(TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaTransferencias.TransferenciaExternaItemAfterScroll(
  DataSet: TDataSet);
begin
  PosTransferenciaExternaCheque(TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger, TransferenciaExternaItemSEQITEM.AsInteger);
end;

{ *************************************************************************** }
procedure TFConsultaTransferencias.AdicionaFiltros(VpaSelect: TStrings);
begin
  if TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger <> 0 then
  begin
    if CPeriodo.Checked then
      VpaSelect.add(' AND ' + SQLTextoDataEntreAAAAMMDD('TRA.DATTRANSFERENCIA',EDatInicio.Date,EDatFim.Date,FALSE));
  end;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.AtualizaConsulta;
Var
  VpfPosicao: TBookmark;
begin
  VpfPosicao := TransferenciaExternaCorpo.GetBookmark;
  TransferenciaExternaCorpo.Close;
  TransferenciaExternaCorpo.SQL.Clear;
  TransferenciaExternaCorpo.SQL.Add('SELECT TRA.SEQTRANSFERENCIA, TRA.DATTRANSFERENCIA, TRA.CODUSUARIO, TRA.VALTOTAL, TRA.SEQCAIXA, ' +
                                    ' USU.C_NOM_USU, USU.I_COD_USU ' +
                                    ' FROM TRANSFERENCIAEXTERNACORPO TRA, CADUSUARIOS USU ' +
                                    ' WHERE TRA.CODUSUARIO = USU.I_COD_USU');
  AdicionaFiltros(TransferenciaExternaCorpo.SQL);
  TransferenciaExternaCorpo.sql.add('order by TRA.SEQTRANSFERENCIA');
  TransferenciaExternaCorpo.open;
  try
    TransferenciaExternaCorpo.GotoBookmark(VpfPosicao);
  except
    TransferenciaExternaCorpo.Last;
    TransferenciaExternaCorpo.GotoBookmark(VpfPosicao);
  end;
  TransferenciaExternaCorpo.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFConsultaTransferencias.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.BGeraArquivoClick(Sender: TObject);
begin
  FunCaixa.GeraArquivoTransferenciasCaixasemXML(TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaTransferencias.BImportarClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFConsultaTransferencias.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeTransferenciaExterna(TransferenciaExternaCorpoSEQTRANSFERENCIA.AsInteger);
  dtRave.free;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.EDatFimExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaTransferencias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaTransferencias]);
end.
