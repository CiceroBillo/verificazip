unit ARoteiroEntrega;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Componentes1, DB, Grids, DBGrids, Tabela, DBClient, StdCtrls,
  Buttons, ComCtrls, FunSql, PainelGradiente, ConstMsg, Menus, Localizacao,
  DBKeyViolation;

type
  TFRoteiroEntrega = class(TFormularioPermissao)
    PanelColor2: TPanelColor;
    GradeCorpo: TGridIndice;
    DataORCAMENTOROTEIROENTREGA: TDataSource;
    ORCAMENTOROTEIROENTREGA: TSQL;
    PanelColor3: TPanelColor;
    ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO: TFMTBCDField;
    ORCAMENTOROTEIROENTREGAC_NOM_TRA: TWideStringField;
    ORCAMENTOROTEIROENTREGADATABERTURA: TSQLTimeStampField;
    ORCAMENTOROTEIROENTREGADATFECHAMENTO: TSQLTimeStampField;
    Splitter1: TSplitter;
    GradeItem: TGridIndice;
    DataORCAMENTOROTEIROENTREGAITEM: TDataSource;
    ORCAMENTOROTEIROENTREGAITEM: TSQL;
    ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTOROTEIRO: TFMTBCDField;
    ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTO: TFMTBCDField;
    ORCAMENTOROTEIROENTREGAITEMC_NOM_CLI: TWideStringField;
    ORCAMENTOROTEIROENTREGAITEMCODFILIALORCAMENTO: TFMTBCDField;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    Aux: TSQL;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ESituacao: TComboBoxColor;
    ORCAMENTOROTEIROENTREGACODENTREGADOR: TFMTBCDField;
    BtExcluirItem: TBitBtn;
    BExcluirEntrega: TBitBtn;
    MenuItem: TPopupMenu;
    MFinalizarEntrega: TMenuItem;
    ORCAMENTOROTEIROENTREGAITEMDATFECHAMENTO: TSQLTimeStampField;
    ETransportadora: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    LTransportadora: TLabel;
    localiza: TConsultaPadrao;
    BGeraNota: TBitBtn;
    ORCAMENTOROTEIROENTREGAITEMDATSAIDAENTREGA: TSQLTimeStampField;
    MenuGrade: TPopupMenu;
    MenuItem1: TMenuItem;
    ORCAMENTOROTEIROENTREGADATBLOQUEIO: TSQLTimeStampField;
    BBloquear: TBitBtn;
    Label82: TLabel;
    ERegiaoVenda: TRBEditLocaliza;
    SpeedButton10: TSpeedButton;
    Label83: TLabel;
    ORCAMENTOROTEIROENTREGACODREGIAOVENDAS: TFMTBCDField;
    ORCAMENTOROTEIROENTREGAC_NOM_REG: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCorpoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ORCAMENTOROTEIROENTREGAAfterScroll(DataSet: TDataSet);
    procedure BFinalizaClick(Sender: TObject);
    procedure BtExcluirItemClick(Sender: TObject);
    procedure BExcluirEntregaClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure MFinalizarEntregaClick(Sender: TObject);
    procedure GradeCorpoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GradeItemDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ESituacaoExit(Sender: TObject);
    procedure CPeriodoClick(Sender: TObject);
    procedure ETransportadoraChange(Sender: TObject);
    procedure ETransportadoraFimConsulta(Sender: TObject);
    procedure ESituacaoSelect(Sender: TObject);
    procedure EDatInicioExit(Sender: TObject);
    procedure EDatFimExit(Sender: TObject);
    procedure BGeraNotaClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure BBloquearClick(Sender: TObject);
    procedure ERegiaoVendaFimConsulta(Sender: TObject);
  private
     procedure PosRoteiroEntregaItem(VpaCodfilial, VpaSeqRoteiro : integer);
     function ExcluiItemRoteiroEntrega(VpaCodfilial, VpaSeqRoteiro, VpaSeqOrcamento : integer):string;
     function ExcluiRoteiroEntrega(VpaCodfilial, VpaSeqRoteiro, VpaCodEntregador: integer):string;
     function FinalizaRoteiroEntregaItem(VpaSeqOrcamento: integer): string;
     function FinalizaRoteiroEntrega(VpaSeqRoteiro: Integer): String;
     function BloqueiaAmostra(VpaSeqRoteiro: Integer):String;
     function AlteraRoteiroSaidaEntrega(VpaCodfilial, VpaSeqOrcamento : integer):string;
     procedure AtualizaConsulta;
     procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FRoteiroEntrega: TFRoteiroEntrega;

implementation

uses APrincipal, Constantes, AFinalizaOrcamentoRoteiroEntrega, dmRave,
  UnCotacao;

{$R *.DFM}


{ **************************************************************************** }
procedure TFRoteiroEntrega.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.Date:= now;
  EDatFim.Date:= now;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.GradeCorpoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not (ORCAMENTOROTEIROENTREGADATFECHAMENTO.IsNull) then
  begin
    GradeCorpo.Canvas.Font.Color:= clGreen;
    GradeCorpo.DefaultDrawDataCell(Rect, GradeCorpo.columns[datacol].field, State);
  end;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.GradeCorpoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in[37..40]  then
    PosRoteiroEntregaItem(varia.CodigoEmpFil, ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger);
end;

{******************************************************************************}
procedure TFRoteiroEntrega.GradeItemDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not (ORCAMENTOROTEIROENTREGADATFECHAMENTO.IsNull) then
  begin
    GradeItem.Canvas.Font.Color:= clGreen;
    GradeItem.DefaultDrawDataCell(Rect, GradeItem.columns[datacol].field, State);
  end;
  if not (ORCAMENTOROTEIROENTREGAITEMDATFECHAMENTO.IsNull) then
  begin
    GradeItem.Canvas.Font.Color:= clGreen;
    GradeItem.DefaultDrawDataCell(Rect, GradeItem.columns[datacol].field, State);
  end
  else
  begin
    if not (ORCAMENTOROTEIROENTREGAITEMDATSAIDAENTREGA.IsNull) then
    begin
      GradeItem.Canvas.Font.Color:= clRed;
      GradeItem.DefaultDrawDataCell(Rect, GradeItem.columns[datacol].field, State);
    end;
  end;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.MenuItem1Click(Sender: TObject);
begin
  FinalizaRoteiroEntrega(ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger);
  ORCAMENTOROTEIROENTREGA.Close;
  ORCAMENTOROTEIROENTREGA.open;
  ORCAMENTOROTEIROENTREGAITEM.Close;
  ORCAMENTOROTEIROENTREGAITEM.open;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.MFinalizarEntregaClick(Sender: TObject);
begin
  FinalizaRoteiroEntregaItem(ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTO.AsInteger);
  ORCAMENTOROTEIROENTREGAITEM.Close;
  ORCAMENTOROTEIROENTREGAITEM.open;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.ORCAMENTOROTEIROENTREGAAfterScroll(
  DataSet: TDataSet);
begin
   PosRoteiroEntregaItem(varia.CodigoEmpFil, ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger);
end;

{******************************************************************************}
procedure TFRoteiroEntrega.PosRoteiroEntregaItem(VpaCodfilial,
  VpaSeqRoteiro: integer);
begin
  ORCAMENTOROTEIROENTREGAITEM.close;
  if VpaSeqRoteiro <> 0 then
  begin
    ORCAMENTOROTEIROENTREGAITEM.sql.clear;
    ORCAMENTOROTEIROENTREGAITEM.sql.add('select ITE.SEQORCAMENTOROTEIRO, ITE.SEQORCAMENTO, CLI.C_NOM_CLI, ITE.CODFILIALORCAMENTO, ITE.DATFECHAMENTO, ITE.DATSAIDAENTREGA ' +
                                        ' from ORCAMENTOROTEIROENTREGAITEM ITE, CADORCAMENTOS ORC, CADCLIENTES CLI ' +
                                        ' WHERE ITE.SEQORCAMENTO = ORC.I_LAN_ORC AND ' +
                                        ' ORC.I_COD_CLI = CLI.I_COD_CLI AND ' +
                                        ' ITE.SEQORCAMENTOROTEIRO = ' + IntToStr(VpaSeqRoteiro) + '  AND ' +
                                        ' ITE.CODFILIALORCAMENTO = ' + IntToStr(VpaCodfilial));
    ORCAMENTOROTEIROENTREGAITEM.sql.add(' order by ITE.SEQORCAMENTOROTEIRO ');
    ORCAMENTOROTEIROENTREGAITEM.open;
  end;
end;

{ *************************************************************************** }
procedure TFRoteiroEntrega.AdicionaFiltros(VpaSelect: TStrings);
begin
  if ETransportadora.AInteiro <> 0 then
  begin
    VpaSelect.Add(' AND ORC.CODENTREGADOR = ' + IntToStr(ETransportadora.AInteiro));
  end;

  if ERegiaoVenda.AInteiro <> 0 then
  begin
    VpaSelect.Add(' AND ORC.CODREGIAOVENDAS = ' + IntToStr(ERegiaoVenda.AInteiro));
  end;

  case ESituacao.ItemIndex of
    0 : VpaSelect.Add(' AND ORC.DATFECHAMENTO IS NULL ');
    1 : VpaSelect.Add(' AND ORC.DATFECHAMENTO IS NOT NULL ');
  end;

  if CPeriodo.Checked then
    VpaSelect.add(' AND ' + SQLTextoDataEntreAAAAMMDD('ORC.DATABERTURA',EDatInicio.Date,EDatFim.Date,FALSE));
end;

{******************************************************************************}
function TFRoteiroEntrega.AlteraRoteiroSaidaEntrega(VpaCodfilial, VpaSeqOrcamento : integer): string;
begin
    Aux.sql.clear;
    AdicionaSQLAbreTabela(Aux, ' SELECT DATSAIDAENTREGA, CODFILIALORCAMENTO, SEQORCAMENTO ' +
                               ' FROM ORCAMENTOROTEIROENTREGAITEM ' +
                               ' WHERE SEQORCAMENTO = ' + IntToStr(VpaSeqOrcamento) +
                               ' AND CODFILIALORCAMENTO = ' + IntToStr(VpaCodfilial));
    Aux.Edit;
    Aux.FieldByName('DATSAIDAENTREGA').AsDateTime := now;
    Aux.Post;
    result := Aux.AMensagemErroGravacao;
    Aux.Close;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.AtualizaConsulta;
begin
  ORCAMENTOROTEIROENTREGA.Close;
  LimpaSQLTabela(ORCAMENTOROTEIROENTREGA);
  AdicionaSQLTabela(ORCAMENTOROTEIROENTREGA,' select ORC.SEQORCAMENTOROTEIRO,  TRA.C_NOM_CLI, ORC.DATABERTURA, ' +
                                            ' ORC.DATFECHAMENTO, ORC.CODENTREGADOR, ORC.DATBLOQUEIO, ORC.CODREGIAOVENDAS, ' +
                                            ' REG.C_NOM_REG ' +
                                            ' from ORCAMENTOROTEIROENTREGA ORC, CADCLIENTES TRA, CADREGIAOVENDA REG ' +
                                            ' WHERE ORC.CODENTREGADOR = TRA.I_COD_CLI ' +
                                            ' AND ORC.CODREGIAOVENDAS = REG.I_COD_REG');
  AdicionaFiltros(ORCAMENTOROTEIROENTREGA.SQL);
  ORCAMENTOROTEIROENTREGA.sql.add('order by ORC.SEQORCAMENTOROTEIRO');
  ORCAMENTOROTEIROENTREGA.open;

  PosRoteiroEntregaItem(varia.CodigoEmpFil, ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger);
end;

{******************************************************************************}
procedure TFRoteiroEntrega.BBloquearClick(Sender: TObject);
Var
  VpfResultado: String;
begin
  VpfResultado:= BloqueiaAmostra(ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.BExcluirEntregaClick(Sender: TObject);
var
  VpfResultado: String;
begin
  if (ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger <> 0) and Confirmacao('Tem certeza que deseja excluir a entrega: ' + IntToStr(ORCAMENTOROTEIROENTREGACODENTREGADOR.AsInteger) + '-' + ORCAMENTOROTEIROENTREGAC_NOM_TRA.AsString + '?') then
    VpfResultado:= ExcluiRoteiroEntrega(Varia.CodigoEmpFil, ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger, ORCAMENTOROTEIROENTREGACODENTREGADOR.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.BFinalizaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFRoteiroEntrega.BGeraNotaClick(Sender: TObject);
var
  VpfResultado: String;
begin
  FunCotacao.AlteraEstagioCotacao(ORCAMENTOROTEIROENTREGAITEMCODFILIALORCAMENTO.AsInteger,varia.CodigoUsuario,ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTO.AsInteger, varia.EstagioNaEntrega, '');
  VpfResultado:= AlteraRoteiroSaidaEntrega(ORCAMENTOROTEIROENTREGAITEMCODFILIALORCAMENTO.AsInteger, ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTO.AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  ORCAMENTOROTEIROENTREGAITEM.Close;
  ORCAMENTOROTEIROENTREGAITEM.Open;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.BImprimirClick(Sender: TObject);
begin
   dtRave := TdtRave.create(self);
   if CPeriodo.Checked then
     dtRave.ImprimeOrcamentoRoteiroEntrega(Varia.CodigoEmpFil,ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger,true, true, EDatInicio.Date, EDatFim.Date)
   else
     dtRave.ImprimeOrcamentoRoteiroEntrega(Varia.CodigoEmpFil,ORCAMENTOROTEIROENTREGASEQORCAMENTOROTEIRO.AsInteger,true, false, EDatInicio.Date, EDatFim.Date);
   dtRave.free;
end;

{******************************************************************************}
function TFRoteiroEntrega.BloqueiaAmostra(VpaSeqRoteiro: Integer): String;
begin
  if VpaSeqRoteiro <> 0 then
  begin
    Aux.sql.clear;
    AdicionaSQLAbreTabela(Aux, ' SELECT DATBLOQUEIO, SEQORCAMENTOROTEIRO ' +
                               ' FROM ORCAMENTOROTEIROENTREGA ' +
                               ' WHERE SEQORCAMENTOROTEIRO = ' + IntToStr(VpaSeqRoteiro));
    Aux.Edit;
    Aux.FieldByName('DATBLOQUEIO').AsDateTime := now;
    Aux.Post;
    result := Aux.AMensagemErroGravacao;
    Aux.Close;
 end;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.BtExcluirItemClick(Sender: TObject);
begin
   if ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTOROTEIRO.AsInteger <> 0 then
   begin
      FAlteraEntregador := TFAlteraEntregador.CriarSDI(self,'',true);
      FAlteraEntregador.ESeqRoteiro.Text:= IntToStr(ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTOROTEIRO.AsInteger);
      FAlteraEntregador.ESeqOrcamento.Text:= IntToStr(ORCAMENTOROTEIROENTREGAITEMSEQORCAMENTO.AsInteger);
      FAlteraEntregador.EFilial.Text:= IntToStr(ORCAMENTOROTEIROENTREGAITEMCODFILIALORCAMENTO.AsInteger);
      FAlteraEntregador.ShowModal;
      FAlteraEntregador.Free;
   end;
   ORCAMENTOROTEIROENTREGA.Close;
   ORCAMENTOROTEIROENTREGA.Open;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.EDatFimExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.ERegiaoVendaFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.ESituacaoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.ESituacaoSelect(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.ETransportadoraChange(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.ETransportadoraFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
function TFRoteiroEntrega.ExcluiItemRoteiroEntrega(VpaCodfilial,  VpaSeqRoteiro, VpaSeqOrcamento: integer): string;
begin
    if VpaSeqRoteiro <> 0 then
    begin
      Aux.sql.clear;
      ExecutaComandoSql(Aux, ' DELETE FROM ORCAMENTOROTEIROENTREGAITEM '+
                             ' WHERE SEQORCAMENTOROTEIRO = ' + InttoStr(VpaSeqRoteiro) +
                             ' AND SEQORCAMENTO = ' + InttoStr(VpaSeqOrcamento) +
                             ' AND CODFILIALORCAMENTO = ' + IntToStr(VpaCodfilial));
      result := Aux.AMensagemErroGravacao;
      Aux.Close;
      ORCAMENTOROTEIROENTREGAITEM.Close;
      ORCAMENTOROTEIROENTREGAITEM.open;
      FunCotacao.AlteraEstagioCotacao(VpaCodfilial,varia.CodigoUsuario,VpaSeqOrcamento, varia.EstagioAguardandoEntrega, '');
    end;
end;

{******************************************************************************}
function TFRoteiroEntrega.ExcluiRoteiroEntrega(VpaCodfilial,
  VpaSeqRoteiro, VpaCodEntregador: integer): string;
begin
   if VpaSeqRoteiro <> 0 then
    begin
      Aux.sql.clear;
      ExecutaComandoSql(Aux, ' DELETE FROM ORCAMENTOROTEIROENTREGAITEM '+
                             ' WHERE SEQORCAMENTOROTEIRO = ' + InttoStr(VpaSeqRoteiro) +
                             ' AND CODFILIALORCAMENTO = ' + IntToStr(VpaCodfilial));
      result := Aux.AMensagemErroGravacao;
      Aux.Close;

      Aux.sql.clear;
      ExecutaComandoSql(Aux, ' DELETE FROM ORCAMENTOROTEIROENTREGA '+
                             ' WHERE SEQORCAMENTOROTEIRO = ' + InttoStr(VpaSeqRoteiro) +
                             ' AND CODENTREGADOR = ' + IntToStr(VpaCodEntregador));
      result := Aux.AMensagemErroGravacao;
      Aux.Close;
      ORCAMENTOROTEIROENTREGA.Close;
      ORCAMENTOROTEIROENTREGA.open;
      ORCAMENTOROTEIROENTREGAITEM.Close;
      ORCAMENTOROTEIROENTREGAITEM.open;
    end;
end;

{******************************************************************************}
function TFRoteiroEntrega.FinalizaRoteiroEntrega(
  VpaSeqRoteiro: Integer): String;
begin
  if VpaSeqRoteiro <> 0 then
  begin
    //Altera Corpo
    Aux.sql.clear;
    AdicionaSQLAbreTabela(Aux, ' SELECT DATFECHAMENTO, SEQORCAMENTOROTEIRO ' +
                               ' FROM ORCAMENTOROTEIROENTREGA ' +
                               ' WHERE SEQORCAMENTOROTEIRO = ' + IntToStr(VpaSeqRoteiro));
    Aux.Edit;
    Aux.FieldByName('DATFECHAMENTO').AsDateTime := now;
    Aux.Post;
    result := Aux.AMensagemErroGravacao;
    if Result <> '' then
    begin
      aviso(Result);
    end;
    Aux.Close;

     //Altera os Itens
    Aux.sql.clear;
    AdicionaSQLAbreTabela(Aux, ' SELECT DATFECHAMENTO, SEQORCAMENTOROTEIRO, SEQORCAMENTO, CODFILIALORCAMENTO ' +
                               ' FROM ORCAMENTOROTEIROENTREGAITEM ' +
                               ' WHERE SEQORCAMENTOROTEIRO = ' + IntToStr(VpaSeqRoteiro));
    while not aux.Eof do
    begin
      Aux.Edit;
      Aux.FieldByName('DATFECHAMENTO').AsDateTime := now;
      Aux.Post;
      result := Aux.AMensagemErroGravacao;
      if Result <> '' then
      begin
        aviso(Result);
        Break;
      end
      else
      begin
        FunCotacao.AlteraEstagioCotacao(Aux.FieldByName('CODFILIALORCAMENTO').AsInteger,varia.CodigoUsuario,Aux.FieldByName('SEQORCAMENTO').AsInteger, varia.EstagioFinalOrdemProducao, '');
        aux.Next;
      end;
    end;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFRoteiroEntrega.FinalizaRoteiroEntregaItem(
  VpaSeqOrcamento: integer): string;
begin
  if VpaSeqOrcamento <> 0 then
  begin
    Aux.sql.clear;
    AdicionaSQLAbreTabela(Aux, ' SELECT DATFECHAMENTO, CODFILIALORCAMENTO, SEQORCAMENTO ' +
                               ' FROM ORCAMENTOROTEIROENTREGAITEM ' +
                               ' WHERE SEQORCAMENTO = ' + IntToStr(VpaSeqOrcamento));
    Aux.Edit;
    Aux.FieldByName('DATFECHAMENTO').AsDateTime := now;
    Aux.Post;
    result := Aux.AMensagemErroGravacao;
    FunCotacao.AlteraEstagioCotacao(Aux.FieldByName('CODFILIALORCAMENTO').AsInteger,varia.CodigoUsuario,Aux.FieldByName('SEQORCAMENTO').AsInteger, varia.EstagioFinalOrdemProducao, '');
    Aux.Close;
 end;
end;

{******************************************************************************}
procedure TFRoteiroEntrega.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ORCAMENTOROTEIROENTREGA.Close;
  ORCAMENTOROTEIROENTREGAITEM.close;
  aux.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRoteiroEntrega]);
end.
