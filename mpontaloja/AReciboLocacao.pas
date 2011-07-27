unit AReciboLocacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Tabela, Componentes1, UnContrato,
  Localizacao, ComCtrls, PainelGradiente, DB, DBClient, FunSQL, Constantes, ConstMsg,
  DBCtrls, Menus, Mask, numericos;

type
  TFReciboLocacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label4: TLabel;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    LCliente: TLabel;
    SpeedButton1: TSpeedButton;
    ECliente: TEditLocaliza;
    Label1: TLabel;
    GradeCorpo: TDBGridColor;
    Splitter1: TSplitter;
    GradeItem: TDBGridColor;
    localiza: TConsultaPadrao;
    RECIBOLOCACAOCORPO: TSQL;
    DataRECIBOLOCACAOCORPO: TDataSource;
    DataRECIBOLOCACAOSERVICO: TDataSource;
    RECIBOLOCACAOSERVICO: TSQL;
    RECIBOLOCACAOCORPOCODFILIAL: TFMTBCDField;
    RECIBOLOCACAOCORPOSEQRECIBO: TFMTBCDField;
    RECIBOLOCACAOCORPOSEQLEITURALOCACAO: TFMTBCDField;
    RECIBOLOCACAOCORPOLANORCAMENTO: TFMTBCDField;
    RECIBOLOCACAOCORPOC_NOM_CLI: TWideStringField;
    RECIBOLOCACAOCORPODATEMISSAO: TSQLTimeStampField;
    RECIBOLOCACAOCORPOVALTOTAL: TFMTBCDField;
    RECIBOLOCACAOCORPODESOBSERVACAO: TWideStringField;
    Label15: TLabel;
    EFilial: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    RECIBOLOCACAOSERVICOSEQITEM: TFMTBCDField;
    RECIBOLOCACAOSERVICOC_NOM_SER: TWideStringField;
    RECIBOLOCACAOSERVICOQTDSERVICO: TFMTBCDField;
    RECIBOLOCACAOSERVICOVALUNITARIO: TFMTBCDField;
    RECIBOLOCACAOSERVICOVALTOTAL: TFMTBCDField;
    Label6: TLabel;
    ECotacao: TEditColor;
    Label2: TLabel;
    ERecibo: TEditColor;
    Aux: TSQL;
    RECIBOLOCACAOCORPOINDCANCELADO: TWideStringField;
    RECIBOLOCACAOCORPODESMOTIVOCANCELAMENTO: TWideStringField;
    RECIBOLOCACAOCORPODATCANCELAMENTO: TSQLTimeStampField;
    RECIBOLOCACAOCORPOCODUSUARIOCANCELAMENTO: TFMTBCDField;
    RECIBOLOCACAOCORPOC_NOM_USU: TWideStringField;
    RECIBOLOCACAOCORPOI_COD_USU: TFMTBCDField;
    DBMemoColor1: TDBMemoColor;
    PanelColor2: TPanelColor;
    MenuGrade: TPopupMenu;
    MVisualizarNota: TMenuItem;
    PanelColor3: TPanelColor;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    BCancelar: TBitBtn;
    PTotal: TPanelColor;
    Label10: TLabel;
    CTotal: TCheckBox;
    EValorTotal: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCorpoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CPeriodoClick(Sender: TObject);
    procedure EDatInicioExit(Sender: TObject);
    procedure EDatFimExit(Sender: TObject);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure EFilialFimConsulta(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure ECotacaoExit(Sender: TObject);
    procedure EReciboExit(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCorpoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure RECIBOLOCACAOCORPOAfterScroll(DataSet: TDataSet);
    procedure MVisualizarNotaClick(Sender: TObject);
    procedure CTotalClick(Sender: TObject);
    procedure BEnviarEmailClienteClick(Sender: TObject);
  private
     VprCodFilial,
     VprLanOrcamento : Integer;
     FunContrato : TRBFuncoesContrato;
     procedure PosReciboLocacaoServico(VpaCodfilial, VpaSeqReciboLocacao : integer);
     procedure AtualizaConsulta;
     procedure AdicionaFiltros(VpaSelect : TStrings);
     procedure AtualizaTotal;
  public
    { Public declarations }
    procedure consultaReciboCotacao(VpaCodFilial, VpaLanOrcamento : Integer);
  end;

var
  FReciboLocacao: TFReciboLocacao;

implementation

uses dmRave, FunData, APrincipal, ACotacao;

{$R *.DFM}


{ **************************************************************************** }
procedure TFReciboLocacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprLanOrcamento := 0;
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  RECIBOLOCACAOCORPOVALTOTAL.DisplayFormat:= varia.MascaraValor;
  RECIBOLOCACAOSERVICOVALUNITARIO.DisplayFormat:= varia.MascaraValor;
  RECIBOLOCACAOSERVICOVALTOTAL.DisplayFormat:= varia.MascaraValor;
  EDatInicio.Date:= PrimeiroDiaMes(date);
  EDatFim.Date:= UltimoDiaMes(date);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReciboLocacao.GradeCorpoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if RECIBOLOCACAOCORPOINDCANCELADO.AsString = 'S'  then
  begin
    GradeCorpo.Canvas.Font.Color:= clRed;
    GradeCorpo.DefaultDrawDataCell(Rect, GradeCorpo.columns[datacol].field, State);
  end;
end;

{******************************************************************************}
procedure TFReciboLocacao.GradeCorpoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in[37..40]  then
    PosReciboLocacaoServico(RECIBOLOCACAOCORPOCODFILIAL.AsInteger, RECIBOLOCACAOCORPOSEQRECIBO.AsInteger);
end;

procedure TFReciboLocacao.MVisualizarNotaClick(Sender: TObject);
var
  VpfLanOrcamento: Integer;
begin
  if RECIBOLOCACAOCORPOSEQRECIBO.AsInteger <> 0 then
  begin
    FCotacao := TFCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCotacao'));
    FCotacao.ConsultaCotacaoRecibo(RECIBOLOCACAOCORPOCODFILIAL.AsInteger,RECIBOLOCACAOCORPOSEQRECIBO.AsInteger);
    FCotacao.free;
  end;
end;

{******************************************************************************}
procedure TFReciboLocacao.PosReciboLocacaoServico(VpaCodfilial,
  VpaSeqReciboLocacao: integer);
begin
  RECIBOLOCACAOSERVICO.close;
  if VpaSeqReciboLocacao <> 0 then
  begin
    RECIBOLOCACAOSERVICO.sql.clear;
    RECIBOLOCACAOSERVICO.sql.add('SELECT REC.SEQITEM, SER.C_NOM_SER, REC.QTDSERVICO, REC.VALUNITARIO, REC.VALTOTAL ' +
                                 ' FROM RECIBOLOCACAOSERVICO REC, CADSERVICO SER ' +
                                 ' WHERE REC.CODSERVICO = SER.I_COD_SER' +
                                 ' AND REC.CODFILIAL = ' + IntToStr(VpaCodfilial) +
                                 ' AND REC.SEQRECIBO = ' + IntToStr(VpaSeqReciboLocacao));
    RECIBOLOCACAOSERVICO.sql.add(' order by REC.SEQITEM ');
    RECIBOLOCACAOSERVICO.open;
  end;
end;

{******************************************************************************}
procedure TFReciboLocacao.RECIBOLOCACAOCORPOAfterScroll(DataSet: TDataSet);
begin
  PosReciboLocacaoServico(RECIBOLOCACAOCORPOCODFILIAL.AsInteger, RECIBOLOCACAOCORPOSEQRECIBO.AsInteger);
end;

{ *************************************************************************** }
procedure TFReciboLocacao.AdicionaFiltros(VpaSelect: TStrings);
begin
  if ERecibo.AInteiro <> 0 then
    VpaSelect.Add(' AND REC.SEQRECIBO = ' + IntToStr(ERecibo.AInteiro))
  else
    if VprLanOrcamento <> 0 then
    begin
      VpaSelect.Add(' AND REC.CODFILIAL = ' +IntToStr(VprCodFilial) +
                    ' AND REC.LANORCAMENTO = ' +IntToStr(VprLanOrcamento));
    end
    else
    begin
      if ECliente.AInteiro <> 0 then
        VpaSelect.Add(' AND REC.CODCLIENTE = ' + IntToStr(ECliente.AInteiro));

      if EFilial.AInteiro <> 0 then
        VpaSelect.Add(' AND REC.CODFILIAL = ' + IntToStr(EFilial.AInteiro));

      if ECotacao.AInteiro <> 0 then
        VpaSelect.Add(' AND REC.LANORCAMENTO = ' + IntToStr(ECotacao.AInteiro));

      if CPeriodo.Checked then
        VpaSelect.add(' AND ' + SQLTextoDataEntreAAAAMMDD('REC.DATEMISSAO',EDatInicio.Date,EDatFim.Date,FALSE));
    end;
end;

{******************************************************************************}
procedure TFReciboLocacao.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := RECIBOLOCACAOCORPO.GetBookmark;
  RECIBOLOCACAOCORPO.Close;
  RECIBOLOCACAOCORPO.SQL.Clear;
  RECIBOLOCACAOCORPO.SQL.Add('SELECT REC.CODFILIAL, REC.SEQRECIBO, REC.SEQLEITURALOCACAO, REC.LANORCAMENTO, CLI.C_NOM_CLI, ' +
                             ' REC.DATEMISSAO, REC.VALTOTAL, REC.DESOBSERVACAO, REC.INDCANCELADO, REC.DESMOTIVOCANCELAMENTO, REC.DATCANCELAMENTO, REC.CODUSUARIOCANCELAMENTO,' +
                             ' USU.C_NOM_USU, USU.I_COD_USU ' +
                             ' FROM RECIBOLOCACAOCORPO REC, CADCLIENTES CLI, CADUSUARIOS USU ' +
                             ' WHERE REC.CODCLIENTE = CLI.I_COD_CLI ' +
                             ' AND ' + SQLTextoRightJoin('REC.CODUSUARIOCANCELAMENTO','USU.I_COD_USU'));
  AdicionaFiltros(RECIBOLOCACAOCORPO.SQL);
  RECIBOLOCACAOCORPO.sql.add('order by REC.SEQRECIBO');
  RECIBOLOCACAOCORPO.open;
  if CTotal.Checked then
     AtualizaTotal
  else
  begin
     EValorTotal.text := '0';
  end;
  try
    RECIBOLOCACAOCORPO.GotoBookmark(VpfPosicao);
  except
    RECIBOLOCACAOCORPO.Last;
    RECIBOLOCACAOCORPO.GotoBookmark(VpfPosicao);
  end;
  RECIBOLOCACAOCORPO.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFReciboLocacao.AtualizaTotal;
begin
  Aux.Close;
  Aux.sql.Clear;
  AdicionaSQLTabela(Aux,'Select Sum(VALTOTAL) VALOR'+
                        ' from RECIBOLOCACAOCORPO REC where SEQRECIBO = SEQRECIBO');
  AdicionaFiltros(Aux.Sql);
  Aux.open;
  EValorTotal.AValor := Aux.FieldByName('VALOR').AsFloat;
end;

{******************************************************************************}
procedure TFReciboLocacao.BCancelarClick(Sender: TObject);
var
  VpfMotivoCancelamento, VpfResultado : String;
begin
 if RECIBOLOCACAOCORPOSEQRECIBO.AsInteger > 0 then
 begin
    if Confirmacao('Tem certeza que deseja cancelar o recibo "' + IntToStr(RECIBOLOCACAOCORPOSEQRECIBO.AsInteger)+'"') then
    begin
     if Entrada('Motivo Cancelamento','Motivo Cancelamento',VpfMotivoCancelamento,false,clInfoBk,clGray) then
       VpfResultado := FunContrato.CancelaRecibo(RECIBOLOCACAOCORPOCODFILIAL.AsInteger, RECIBOLOCACAOCORPOSEQRECIBO.AsInteger,VpfMotivoCancelamento)
     else
       VpfResultado := 'NÃO FOI POSSÍVEL CANCELAR O RECIBO!!!'#13'Operação cancelada pelo usuário';
    end;
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsulta;
 end;
end;

{******************************************************************************}
procedure TFReciboLocacao.BEnviarEmailClienteClick(Sender: TObject);
var
  VpfResultado : String;
begin
//  VpfResultado := FunContrato.EnviaEmailCliente(vp,VprDCliente);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFReciboLocacao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFReciboLocacao.BImprimirClick(Sender: TObject);
begin
   dtRave := TdtRave.create(self);
   if CPeriodo.Checked then
     dtRave.ImprimeReciboLocacao(Varia.CodigoEmpFil,RECIBOLOCACAOCORPOSEQRECIBO.AsInteger,true, false, EDatInicio.Date, EDatFim.Date)
   else
     dtRave.ImprimeReciboLocacao(Varia.CodigoEmpFil,RECIBOLOCACAOCORPOSEQRECIBO.AsInteger,true, false, EDatInicio.Date, EDatFim.Date);
   dtRave.free;
end;

{******************************************************************************}
procedure TFReciboLocacao.consultaReciboCotacao(VpaCodFilial,VpaLanOrcamento: Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprLanOrcamento :=  VpaLanOrcamento;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFReciboLocacao.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReciboLocacao.CTotalClick(Sender: TObject);
var
  vpfPosicao : TBookmark;
begin
  VpfPosicao := RECIBOLOCACAOCORPO.GetBookmark;
  AtualizaConsulta;
  RECIBOLOCACAOCORPO.GotoBookmark(VpfPosicao);
  RECIBOLOCACAOCORPO.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFReciboLocacao.EClienteFimConsulta(Sender: TObject);
begin
  AtualizaConsulta
end;

{******************************************************************************}
procedure TFReciboLocacao.ECotacaoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReciboLocacao.EDatFimExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReciboLocacao.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReciboLocacao.EFilialFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReciboLocacao.EReciboExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReciboLocacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  RECIBOLOCACAOCORPO.Close;
  RECIBOLOCACAOSERVICO.close;
  FunContrato.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFReciboLocacao]);
end.
