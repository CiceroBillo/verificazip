unit AContasAPagar;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores,
  ToolWin, ImgList, numericos, UnComissoes, UnContasAPAgar,
  UnDespesas, Menus, UnDadosCR, FMTBcd, SqlExpr, DBClient, WideStrings, RpCon,
  RpConDS, RpDefine, RpRave, jpeg, RpBase, RpSystem;

type
  TFContasaPagar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    CadNotas: TSQL;
    DataCadNotas: TDataSource;
    BotaoCadastrar1: TBitBtn;
    BitBtn1: TBitBtn;
    DataMovcontasapagar: TDataSource;
    BPagamento: TBitBtn;
    Aux: TSQL;
    Localiza: TConsultaPadrao;
    MovNotas: TSQL;
    Paginas: TPageControl;
    TabNotas: TTabSheet;
    PanelColor1: TPanelColor;
    Label4: TLabel;
    Label6: TLabel;
    Splitter1: TSplitter;
    GradeParcelas1: TDBGridColor;
    TabParcelas: TTabSheet;
    PanelColor3: TPanelColor;
    DBMemoColor2: TDBMemoColor;
    Label5: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    DataMovParcelas: TDataSource;
    MovParcelas: TSQL;
    PanelColor4: TPanelColor;
    Label15: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    LFilial: TLabel;
    Label16: TLabel;
    Label21: TLabel;
    tempo: TPainelTempo;
    BProdutos: TBitBtn;
    Panel1: TPanel;
    DBMemoColor1: TDBMemoColor;
    BNGraficoNota: TBitBtn;
    FotoNotas: TBitBtn;
    Label11: TLabel;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    dataNota1: TCalendario;
    DataNota2: TCalendario;
    ECodFilial: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    EditLocaliza7: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    EditLocaliza8: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    VisualizaFoto: TVisualizadorImagem;
    Detalhes: TComponenteMove;
    PanelColor5: TPanelColor;
    Label49: TLabel;
    DBText27: TDBText;
    Label28: TLabel;
    DBText8: TDBText;
    Label29: TLabel;
    DBText1: TDBText;
    Label30: TLabel;
    DBText7: TDBText;
    Label31: TLabel;
    DBText9: TDBText;
    Label32: TLabel;
    DBText10: TDBText;
    Label34: TLabel;
    DBText12: TDBText;
    Label35: TLabel;
    DBText13: TDBText;
    Label36: TLabel;
    DBText14: TDBText;
    DBText15: TDBText;
    DBText16: TDBText;
    DBText17: TDBText;
    Label40: TLabel;
    DBText18: TDBText;
    Label41: TLabel;
    DBText19: TDBText;
    Label42: TLabel;
    DBText20: TDBText;
    Label43: TLabel;
    DBText21: TDBText;
    Label44: TLabel;
    DBText22: TDBText;
    Label45: TLabel;
    DBText23: TDBText;
    Label46: TLabel;
    DBText24: TDBText;
    Label47: TLabel;
    DBText25: TDBText;
    BitBtn2: TBitBtn;
    Label50: TLabel;
    SpeedButton9: TSpeedButton;
    MovParcelasI_LAN_APG: TFMTBCDField;
    MovParcelasI_COD_CLI: TFMTBCDField;
    MovParcelasI_NRO_NOT: TFMTBCDField;
    MovParcelasI_NRO_PAR: TFMTBCDField;
    MovParcelasC_NRO_DUP: TWideStringField;
    MovParcelasD_DAT_VEN: TSQLTimeStampField;
    MovParcelasN_VLR_DUP: TFMTBCDField;
    MovParcelasD_DAT_PAG: TSQLTimeStampField;
    MovParcelasN_VLR_PAG: TFMTBCDField;
    MovParcelasC_NOM_CLI: TWideStringField;
    MovParcelasN_PER_DES: TFMTBCDField;
    MovParcelasC_NOM_FAN: TWideStringField;
    MovParcelasc_pat_fot: TWideStringField;
    MovParcelasI_SEQ_NOT: TFMTBCDField;
    MovParcelasN_PER_MUL: TFMTBCDField;
    MovParcelasN_PER_JUR: TFMTBCDField;
    MovParcelasN_PER_MOR: TFMTBCDField;
    MovParcelasN_VLR_MUL: TFMTBCDField;
    MovParcelasN_VLR_JUR: TFMTBCDField;
    MovParcelasN_VLR_MOR: TFMTBCDField;
    MovParcelasC_NRO_DOC: TWideStringField;
    MovParcelasN_VLR_ACR: TFMTBCDField;
    MovParcelasN_VLR_DES: TFMTBCDField;
    MovParcelasC_NRO_CON: TWideStringField;
    MovParcelasC_NOM_FRM: TWideStringField;
    MovNotasI_EMP_FIL: TFMTBCDField;
    MovNotasI_LAN_APG: TFMTBCDField;
    MovNotasI_NRO_PAR: TFMTBCDField;
    MovNotasC_NRO_CON: TWideStringField;
    MovNotasC_NRO_DUP: TWideStringField;
    MovNotasD_DAT_VEN: TSQLTimeStampField;
    MovNotasN_VLR_DUP: TFMTBCDField;
    MovNotasD_DAT_PAG: TSQLTimeStampField;
    MovNotasN_VLR_PAG: TFMTBCDField;
    MovNotasN_VLR_DES: TFMTBCDField;
    MovNotasN_PER_JUR: TFMTBCDField;
    MovNotasN_PER_MOR: TFMTBCDField;
    MovNotasN_PER_MUL: TFMTBCDField;
    MovNotasI_COD_USU: TFMTBCDField;
    MovNotasN_VLR_ACR: TFMTBCDField;
    MovNotasN_PER_DES: TFMTBCDField;
    MovNotasC_NRO_DOC: TWideStringField;
    MovNotasN_VLR_JUR: TFMTBCDField;
    MovNotasN_VLR_MOR: TFMTBCDField;
    MovNotasN_VLR_MUL: TFMTBCDField;
    MovNotasI_COD_FRM: TFMTBCDField;
    MovParcelasI_EMP_FIL: TFMTBCDField;
    CadNotasI_EMP_FIL: TFMTBCDField;
    CadNotasI_LAN_APG: TFMTBCDField;
    CadNotasN_VLR_TOT: TFMTBCDField;
    CadNotasI_NRO_NOT: TFMTBCDField;
    CadNotasD_DAT_EMI: TSQLTimeStampField;
    CadNotasD_DAT_MOV: TSQLTimeStampField;
    CadNotasC_NOM_CLI: TWideStringField;
    ImageList1: TImageList;
    MovNotasL_OBS_APG: TWideStringField;
    MovParcelasL_OBS_APG: TWideStringField;
    MovParcelasD_DAT_EMI: TSQLTimeStampField;
    Label14: TLabel;
    DBText4: TDBText;
    MovParcelasC_NOM_MOE: TWideStringField;
    MovNotasC_NOM_FRM: TWideStringField;
    Label33: TLabel;
    ETotalTitulos: Tnumerico;
    ETotalPago: Tnumerico;
    ETotalemAberto: Tnumerico;
    GParcelas: TGridIndice;
    GradeNota1: TGridIndice;
    MovNotasI_LAN_BAC: TFMTBCDField;
    BAlterar: TBitBtn;
    Label12: TLabel;
    DBText5: TDBText;
    Label17: TLabel;
    MovParcelasC_CLA_PLA: TWideStringField;
    MovParcelasC_NOM_PLA: TWideStringField;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    CadNotasC_NOM_PLA: TWideStringField;
    Label1: TLabel;
    SpeedButton6: TSpeedButton;
    LPlanoGeral: TLabel;
    EPlanoGeral: TEditColor;
    EPlano: TEditColor;
    CadNotasC_PAT_FOT: TWideStringField;
    SitPar: TComboBoxColor;
    RPeriodo: TComboBoxColor;
    Filtro: TCheckBox;
    MovParcelasD_DAT_MOV: TSQLTimeStampField;
    Label2: TLabel;
    Label3: TLabel;
    BComissoes: TBitBtn;
    FotoParcelas: TBitBtn;
    BGraficos: TBitBtn;
    BImprimir: TBitBtn;
    BitBtn9: TBitBtn;
    Somador: TSpeedButton;
    ToolBar1: TToolBar;
    ExZoom: TToolButton;
    BMostrarConta: TSpeedButton;
    Label9: TLabel;
    DBText2: TDBText;
    MovParcelasC_BOL_REC: TWideStringField;
    DBText3: TDBText;
    Label19: TLabel;
    BFiltros: TBitBtn;
    Label23: TLabel;
    SpeedButton1: TSpeedButton;
    Label27: TLabel;
    EFormaPagamento: TEditLocaliza;
    ENotaFiscal: Tnumerico;
    Label22: TLabel;
    MovParcelasNOMCENTRO: TWideStringField;
    Label26: TLabel;
    SpeedButton2: TSpeedButton;
    Label37: TLabel;
    ECentroCusto: TEditLocaliza;
    PopupMenu1: TPopupMenu;
    MConsultaCheques: TMenuItem;
    CPeriodo: TCheckBox;
    rvParcelas: TRvProject;
    RvMovParcelasCP: TRvDataSetConnection;
    RvSystem1: TRvSystem;
    N1: TMenuItem;
    ImprimirAutorizaoPagamento1: TMenuItem;
    ImprimirTodasAutorizaesPagamento1: TMenuItem;
    N2: TMenuItem;
    MProrrogado: TMenuItem;
    MovParcelasC_DES_PRR: TWideStringField;
    CDespesasProrrogadas: TCheckBox;
    N3: TMenuItem;
    AlterarFornecedor1: TMenuItem;
    LTotalSemNota: TLabel;
    ETotalSemNota: Tnumerico;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    Label38: TLabel;
    EContaCorrente: TEditLocaliza;
    MovParcelasC_IND_CAD: TWideStringField;
    ECodCliente: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure CadNotasAfterScroll(DataSet: TDataSet);
    procedure TipoDataNotaChange(Sender: TObject);
    procedure DataNota1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TipoDataParcelaChange(Sender: TObject);
    procedure GradeNota1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeNota1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaginasChange(Sender: TObject);
    procedure SitParClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FiltroClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure CarregaVariaveisGrafico;
    procedure FotoParcelasClick(Sender: TObject);
    procedure FotoNotasClick(Sender: TObject);
    procedure MovParcelasAfterScroll(DataSet: TDataSet);
    procedure EditLocaliza1FimConsulta(Sender: TObject);
    procedure EditLocaliza2FimConsulta(Sender: TObject);
    procedure ECodFilialSelect(Sender: TObject);
    procedure EditLocaliza6FimConsulta(Sender: TObject);
    procedure DataParcela1CloseUp(Sender: TObject);
    procedure BProdutosClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure GParcelasDblClick(Sender: TObject);
    procedure GParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure ECodFilialExit(Sender: TObject);
    procedure ECodFilialChange(Sender: TObject);
    procedure ExZoomClick(Sender: TObject);
    procedure BComissoesClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure SomadorClick(Sender: TObject);
    procedure EPlanoGeralExit(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure MovNotasAfterScroll(DataSet: TDataSet);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BMostrarContaClick(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure MConsultaChequesClick(Sender: TObject);
    procedure ImprimirAutorizaoPagamento1Click(Sender: TObject);
    procedure ImprimirTodasAutorizaesPagamento1Click(Sender: TObject);
    procedure CPeriodoClick(Sender: TObject);
    procedure MProrrogadoClick(Sender: TObject);
    procedure AlterarFornecedor1Click(Sender: TObject);
    procedure GParcelasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    Despesa : TFuncoesDespesas;
    TeclaPresionada : Boolean;
    SomenteUmaNota : Boolean;
    CP : TCalculosContasAPagar;
    VprMostrarContas,
    VprPressionadoR : Boolean;
    VprSeqCheque : Integer;
    procedure executaNotaPai;
    procedure executaNotaFilho;
    procedure executaParcelaPai;
    procedure AdicionaFiltrosParcelaPai(VpaSelect : TStrings);
    procedure AtualizaValorTotal;
    procedure VerificaBotoes( estado : Boolean );
    procedure atualizadados;
    function CarDParcelaMovParcela(VpaDParcela : TRBDParcelaCP) : Boolean;
    function CarParcelasaBaixar(VpaDBaixa : trbDBaixaCP) : Boolean;
  public
    { Public declarations }
    procedure ConsultaContasdoCheque(VpaSeqCheque : Integer);
  end;

var
  FContasaPagar: TFContasaPagar;

implementation

uses ANovoContasaPagar, ADespesas,  fundata,
  APrincipal, AGeraDespesasFixas, constmsg,  funObjeto,
  AGraficosContasaPagar, AMovComissoes, FunSQL, AManutencaoCP,
  APlanoConta, ANovaNotaFiscaisFor, AConsultacheques, ABaixaContasaPagarOO,
  ABaixaContasAReceberOO, dmRave, ANovoCliente;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFContasaPagar.FormCreate(Sender: TObject);
begin
  SitPar.ItemIndex := 5;
  RPeriodo.ItemIndex := 0;
  VprSeqCheque := 0;
  VprMostrarContas := false;
  VprPressionadoR := false;
  Despesa := TFuncoesDespesas.Criar(self, FPrincipal.BaseDados);
  DataParcela1.Date := PrimeiroDiaMes(date);
  DataParcela2.Date := UltimoDiaMes(date);
  DataNota1.Date := DataParcela1.Date;
  DataNota2.Date := DataParcela2.Date;
  TeclaPresionada := true;
  SomenteUmaNota := false;
  cp := TCalculosContasAPagar.criar(self,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContasaPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadNotas.close; { fecha tabelas }
  MovNotas.close;
  MovParcelas.close;
  Despesa.Destroy;
  CP.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFContasaPagar.ConsultaContasdoCheque(VpaSeqCheque : Integer);
begin
  VprSeqCheque := VpaSeqCheque;
  executaParcelaPai;
  showmodal;
end;

procedure TFContasaPagar.CPeriodoClick(Sender: TObject);
begin
  executaParcelaPai;
end;

{**************************Munda o Enabled dos botões**************************}
procedure TFContasaPagar.VerificaBotoes( estado : Boolean );
begin
  BAlterar.Enabled := estado;
  BProdutos.Enabled := estado;
  BPagamento.Enabled := estado;
  BImprimir.Enabled := estado;
  BGraficos.Enabled := estado;
  BNGraficoNota.Enabled := estado;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da Nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****************Atualiza as tabelas filho e as opções************************}
procedure TFContasaPagar.CadNotasAfterScroll(DataSet: TDataSet);
begin
  if TeclaPresionada then
     executaNotaFilho;
  if CadNotas.EOF then
    CadNotas.Prior;
  if CadNotas.fieldByName('C_PAT_FOT').AsString <> '' then
     FotoNotas.Enabled := true
  else
     FotoNotas.Enabled := false;
end;

{************************Atualiza a Tabela pai*********************************}
procedure TFContasaPagar.TipoDataNotaChange(Sender: TObject);
begin
  ExecutaNotaPai;
end;

{************************Atualiza a Tabela pai*********************************}
procedure TFContasaPagar.DataNota1Change(Sender: TObject);
begin
  ExecutaNotaPai;
  CarregaVariaveisGrafico;
end;

{***************************Atualiza a tabela CadNotas*************************}
procedure TFContasaPagar.executaNotaPai;
begin
  LimpaSQLTabela(CadNotas);
  InseriLinhaSQL(CadNotas,0,' Select ' +
                            ' CP.I_EMP_FIL, CP.I_LAN_APG, CP.N_VLR_TOT  AS N_VLR_TOT, CP.I_NRO_NOT, ' +
                            ' CP.D_DAT_EMI, CP.D_DAT_MOV, CP.C_PAT_FOT, ' +
                            ' P.C_NOM_PLA, C.C_NOM_CLI ' +
                            ' from CadContasapagar as CP, CadClientes as C, Cad_PLANO_CONTA as P ' +
                            ' where CP.C_CLA_PLA = P.C_CLA_PLA ' +
                            ' and CP.I_COD_CLI = C.I_COD_CLI ' );

  if EditLocaliza8.Text = '' then
    InseriLinhaSQL(CadNotas, 1,' and CP.I_EMP_FIL >= 0 ') else
      InseriLinhaSQL(CadNotas, 1,' and CP.I_EMP_FIL = ' + EditLocaliza8.Text );

  if EPlanoGeral.Text <> '' then
    InseriLinhaSQL(CadNotas, 2,' and CP.C_CLA_PLA = ''' + Trim(EPlanoGeral.Text) + '''') else
    InseriLinhaSQL(CadNotas, 2,'');

  if EditLocaliza7.Text <> '' then
    InseriLinhaSQL(CadNotas, 3,' and CP.I_COD_CLI = ' + EditLocaliza7.Text )  else
    InseriLinhaSQL(CadNotas, 3,'');

  InseriLinhaSQL(CadNotas, 4, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI',
                 dataNota1.DateTime, DataNota2.DateTime, true));

  if  SomenteUmaNota then
  begin
    InseriLinhaSQL(CadNotas, 5,' and CP.I_LAN_APG = ' + MovPArcelasI_LAN_APG.AsString );
    SomenteUmaNota := false;
  end
    else
      InseriLinhaSQL(CadNotas, 5,' ');

  InseriLinhaSQL(CadNotas, 6,' '); //para ordenar

  AbreTabela(CadNotas);
  ExecutaNotaFilho;
    VerificaBotoes(not CadNotas.Eof);
end;

{*********************Atualiza a tabela de movimento da nota*******************}
procedure TFContasaPagar.executaNotaFilho;
begin
LimpaSQLTabela(MovNotas);
if not CadNotas.EOF then
begin
  AdicionaSQLTabela(MovNotas, 'Select * from MovContasapagar  MCP, CadFormasPagamento  FRM ' +
                    'where MCP.I_EMP_FIL = ' + IntToStr(CadNotasI_EMP_FIL.AsInteger) +
                    ' and MCP.I_LAN_APG = ' + CadNotasI_LAN_APG.AsString +
                    ' and mcp.i_cod_frm *= frm.I_COD_FRM ' +
//                    ' and isnull(mcp.c_dup_can, ''N'') <> ''S''' +
//15/06/2007 foi colocado o filtro em comentario porque estava muito lento para atualizar a consulta do contas a pagar.
                    ' order by MCP.d_dat_ven');
  AbreTabela(MovNotas);
end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos grids
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************Fecha a tabela de movimento para agilizar a consulta*************}
procedure TFContasaPagar.GradeNota1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TeclaPresionada := false;
  FechaTabela(MovNotas);
end;

{*********************Atualiza a tabela de movimentos**************************}
procedure TFContasaPagar.GradeNota1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TeclaPresionada := true;
  if key in[37..40]  then
    executaNotaFilho;
end;

procedure TFContasaPagar.ImprimirAutorizaoPagamento1Click(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeAutorizacaoPagamento(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_APG.AsInteger,MovParcelasI_NRO_PAR.AsInteger,date,date);
  dtRave.free;
end;

{*************************Mostra os detalhes da conta**************************}
procedure TFContasaPagar.ImprimirTodasAutorizaesPagamento1Click(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeAutorizacaoPagamento(MovParcelasI_EMP_FIL.AsInteger,0,0,DataParcela1.Date,dataParcela2.date);
  dtRave.free;
end;

{*************************Mostra os detalhes da conta**************************}
procedure TFContasaPagar.GParcelasDblClick(Sender: TObject);
begin
  detalhes.Visible := true;
end;

{******************************************************************************}
procedure TFContasaPagar.GParcelasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (MovParcelasC_IND_CAD.AsString = 'S') then
  begin
    GParcelas.Canvas.Font.Color:= clGray;
    GParcelas.DefaultDrawDataCell(Rect, GParcelas.columns[datacol].field, State);
  end;
end;

{*************************Mostra os detalhes da conta**************************}
procedure TFContasaPagar.GParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #13 then
  detalhes.Visible := true;

if key = '+' then
begin
  ExZoom.Down := true;
  ExZoomClick(ExZoom);
end
else
   if key = '-' then
   begin
      ExZoom.Down := false;
      ExZoomClick(ExZoom);
    end;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da parcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************atualiza a parcela pai******************************}
procedure TFContasaPagar.executaParcelaPai;
var
  VpfPosicao : TBookMark;
begin
  VpfPosicao := MovParcelas.GetBookmark;
  MovParcelas.close;
  MovParcelas.Sql.clear;
  MovParcelas.sql.add('Select CP.I_LAN_APG, CP.C_CLA_PLA, MCP.L_OBS_APG, CP.I_SEQ_NOT,' +
                                'CP.I_COD_CLI, CP.I_NRO_NOT, CP.C_PAT_FOT, CP.C_IND_CAD, MCP.I_NRO_PAR, ' +
                                'MCP.C_BOL_REC , '+
                                'MCP.C_NRO_DUP, MCP.D_DAT_VEN, CP.D_DAT_EMI, CP.D_DAT_MOV,' +
                                '(MCP.N_VLR_DUP * MOE.N_VLR_DIA)  N_VLR_DUP, MCP.D_DAT_PAG,' +
                                '(MCP.N_VLR_PAG * MOE.N_VLR_DIA)  N_VLR_PAG, MCP.C_NRO_CON, MCP.N_PER_DES, ' +
                                'C.C_NOM_CLI, P.C_CLA_PLA, P.C_NOM_PLA, MOE.C_NOM_MOE, ' +
                                'FIL.C_NOM_FAN, ' +
                                'MCP.N_PER_MUL,MCP.N_PER_JUR,MCP.N_PER_MOR,' +
                                'MCP.N_VLR_MUL,MCP.N_VLR_JUR,MCP.N_VLR_MOR, MCP.C_NRO_DOC,' +
                                'MCP.N_VLR_ACR, MCP.N_VLR_DES, MCP.C_NRO_CON, FRM.C_NOM_FRM, CP.I_EMP_FIL,'+
                                ' MCP.C_DES_PRR, '+
                                'CEN.NOMCENTRO ' );
  MovParcelas.sql.add(' from  MovContasapagar MCP, ' +
                               ' CadContasaPagar CP, ' +
                               ' CadClientes C, '+
                               ' Cad_PLANO_CONTA P, ' +
                               ' CadFiliais Fil, ' +
                               ' CadFormasPagamento FRM, ' +
                               ' CadMoedas MOE, ' +
                               ' CENTROCUSTO CEN ');

  MovParcelas.sql.add('Where CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                                 'and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                                 'and CP.I_COD_CLI = C.I_COD_CLI ' +
                                 'and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                                 'and MCP.I_EMP_FIL = FIL.I_EMP_FIL ' +
                                 ' and '+SQLTextoRightJoin('CP.I_COD_CEN','CEN.CODCENTRO')+
                                 ' and '+ SQLTextoRightJoin('MCP.I_COD_FRM','FRM.I_COD_FRM') +
                                 'and MCP.I_COD_MOE = MOE.I_COD_MOE  ' +
                                 ' and P.I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa) );
  AdicionaFiltrosParcelaPai(MovParcelas.sql);

  MovParcelas.sql.add(' order by MCP.D_DAT_VEN');

  GParcelas.ALinhaSQLOrderBy := MovParcelas.sql.count-1;

  if Somador.Down then
  begin
    AtualizaValorTotal;
  end
  else
  begin
   ETotalTitulos.AValor := 0;
   ETotalPago.AValor := 0;
   ETotalemAberto.AValor := 0;
   AlterarEnabledDet([label15, label11, label33,ETotalTitulos,ETotalPago, ETotalemAberto], false);
 end;
  MovParcelas.Open;
  try
    MovParcelas.GotoBookmark(VpfPosicao);
  except
    MovParcelas.Last;
    try
      MovParcelas.GotoBookmark(VpfPosicao);
    except
    end;

  end;
  MovParcelas.FreeBookmark(VpfPosicao);
  VerificaBotoes(MovParcelasI_LAN_APG.AsInteger <> 0);
end;

{******************************************************************************}
procedure TFContasaPagar.AdicionaFiltrosParcelaPai(VpaSelect : TStrings);
begin
  if VprSeqCheque <> 0 then
    VpaSelect.add('and exists ( Select * from CHEQUECP CHE '+
                                        ' Where CHE.CODFILIALPAGAR = MCP.I_EMP_FIL '+
                                        ' AND CHE.LANPAGAR = MCP.I_LAN_APG '+
                                        ' AND CHE.NUMPARCELA = MCP.I_NRO_PAR '+
                                        ' AND CHE.SEQCHEQUE = ' + IntToStr(VprSeqCheque)+')')
  else
  begin
    if EContaCorrente.Text <> '' then
      VpaSelect.Add('AND MCP.C_NRO_CON = '''+EContaCorrente.Text+'''');
    if CPeriodo.Checked then
    begin
      case RPeriodo.ItemIndex of
        // VENCIMENTO;
        0 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD( 'MCP.D_DAT_VEN',DataParcela1.Date, DataParcela2.Date, true) );// ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
        // EMISSÃO.
        1 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI',DataParcela1.Date, DataParcela2.Date, true));// + ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
                                                                //15/06/2007 foi colocado o filtro em comentario porque estava muito lento para atualizar a consulta do contas a pagar.
        // PAGAMENTO.
        2 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MCP.D_DAT_PAG',DataParcela1.Date, DataParcela2.Date, true));// +  ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
                                                                //15/06/2007 foi colocado o filtro em comentario porque estava muito lento para atualizar a consulta do contas a pagar.
        // cadastro.
        3 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('CP.D_DAT_MOV',DataParcela1.Date, DataParcela2.Date, true));// +  ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
                                                                     //15/06/2007 foi colocado o filtro em comentario porque estava muito lento para atualizar a consulta do contas a pagar.
      end;
    end;

    case SitPar.ItemIndex of
      0 : VpaSelect.add(' AND MCP.D_DAT_PAG is null' );     // A Pagar
      1 : VpaSelect.add(' and MCP.D_DAT_VEN < ' + SQLTextoDataAAAAMMMDD(date) +' and MCP.D_DAT_PAG is null ' );  // Vencidas
      2 : VpaSelect.add(' and not(MCP.D_DAT_PAG is null)' );  //  Pagas
      3 : VpaSelect.add(' and MCP.D_DAT_VEN = ' + SQLTextoDataAAAAMMMDD(Date) + ' and MCP.D_DAT_PAG is null' );  // Vence hoje
      4 : VpaSelect.add(' and MCP.D_DAT_VEN > ' + SQLTextoDataAAAAMMMDD(Date) + ' and MCP.D_DAT_PAG is null ' );  // A Vencer
      5 : VpaSelect.add(' ');  // Todas
    end;
    if not CDespesasProrrogadas.Checked then
      VpaSelect.Add('MCP.C_DES_PRR = ''N''');


   // filtro empresa / filial
      if ECodFilial.Text <> '' then
        VpaSelect.add(' and MCP.I_EMP_FIL = ' + ECodFilial.Text)
      else
        VpaSelect.add(' and p.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) );


    // FILTRO DO PLANO DE CONTAS
    if EPlano.Text <> '' then
      VpaSelect.add(' and CP.C_CLA_PLA = ''' + Trim(EPlano.Text) + '''' );

    // filtro fornecedor
    if ECodCliente.Text <> '' then
      VpaSelect.add(' and CP.I_COD_CLI = ' + ECodCliente.Text );

    if not VprMostrarContas then
      VpaSelect.add(' and '+SQLTextoIsNull('CP.C_IND_CAD','''N''')+' <> ''S''');
  //15/06/2007 foi colocado o filtro em comentario porque estava muito lento para atualizar a consulta do contas a pagar.


    if EFormaPagamento.AInteiro <> 0 then
      VpaSelect.add(' and MCP.I_COD_FRM = '+EFormaPagamento.Text);
    if  ENotaFiscal.AsInteger <> 0 Then
      VpaSelect.add(' and CP.I_NRO_NOT = '+ENotaFiscal.Text);

    if ECentroCusto.AInteiro <> 0 Then
      VpaSelect.add(' and CP.I_COD_CEN = '+ECentroCusto.text);
  end;

  //cheque
end;

{******************************************************************************}
procedure TFContasaPagar.AtualizaValorTotal;
begin
  Aux.sql.clear;
  Aux.sql.add(' Select sum('+SQLTextoIsnull('N_VLR_PAG','N_VLR_DUP * MOE.N_VLR_DIA')+') valorDup, ' +
                   ' sum('+SQLTextoIsnull('MCP.N_VLR_PAG','0')+ '* MOE.N_VLR_DIA)  valorPAG '+
              ' from  MovContasapagar  MCP,  CadContasaPagar  CP, Cad_PLANO_CONTA P, '+
               ' CadMoedas MOE ');
  Aux.sql.add('Where CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
              ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
              ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
              ' and MCP.I_COD_MOE = MOE.I_COD_MOE  ' +
              ' and P.I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa));
  AdicionaFiltrosParcelaPai(Aux.sql);
  Aux.open;
  ETotalTitulos.AValor := Aux.fieldByname('valorDup').AsFloat;
  ETotalPago.Avalor := Aux.fieldByname('valorPAG').AsFloat;

  ETotalemAberto.AValor := ETotalTitulos.AValor - ETotalPago.AValor;
  Aux.close;

  if BMostrarConta.Visible then
  begin
    Aux.sql.clear;
    Aux.sql.add(' Select sum('+SQLTextoIsnull('N_VLR_PAG','N_VLR_DUP * MOE.N_VLR_DIA')+') valorDup '+
                ' from  MovContasapagar  MCP,  CadContasaPagar  CP, Cad_PLANO_CONTA P, '+
                 ' CadMoedas MOE ');
    Aux.sql.add('Where CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                ' and MCP.I_COD_MOE = MOE.I_COD_MOE  ' +
                ' and P.I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa)+
                ' and CP.C_IND_CAD = ''S''');

    AdicionaFiltrosParcelaPai(Aux.sql);
    Aux.open;
    ETotalSemNota.AValor := Aux.fieldByname('valorDup').AsFloat;
    Aux.Close
  end;


end;

{******************************Atualiza a cad parcelas*************************}
procedure TFContasaPagar.TipoDataParcelaChange(Sender: TObject);
begin
   executaParcelaPai;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************Atualiza as consultas***************************}
procedure TFContasaPagar.EditLocaliza1FimConsulta(Sender: TObject);
begin
  if Filtro.Checked then
     executaParcelaPai;
  CarregaVariaveisGrafico;
end;

{******************************Atualiza as consultas***************************}
procedure TFContasaPagar.EditLocaliza2FimConsulta(Sender: TObject);
begin
  if Filtro.Checked then
    executaparcelapai;
end;

{***************************Atualiza a consulta********************************}
procedure TFContasaPagar.EditLocaliza6FimConsulta(Sender: TObject);
begin
  executaNotaPai;
  CarregaVariaveisGrafico;
end;

{*************************Carrega a select do cadfiliais***********************}
procedure TFContasaPagar.ECodFilialSelect(Sender: TObject);
begin
   ECodFilial.ASelectLocaliza.Text := ' Select * from CadFiliais ' +
                                         ' Where c_nom_fan like ''@%'''  +
                                         ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   ECodFilial.ASelectValida.Text := ' Select * from CadFiliais where I_EMP_FIL = @ ' +
                                       ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
end;

{*************************Atualiza a tabela pai********************************}
procedure TFContasaPagar.ECodFilialExit(Sender: TObject);
begin
  if (sender as TEditlocaliza).Text = '' then
    executaParcelaPai;
end;

{**************************Quando a filial é alterada**************************}
procedure TFContasaPagar.ECodFilialChange(Sender: TObject);
begin
{ if EditLocaliza5.Text = '' then
    TabNotas.TabVisible := false
  else
    TabNotas.TabVisible := true;}
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Chamada de procedures que atualizam a consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************Quando o usuário altera a página**************************}
procedure TFContasaPagar.PaginasChange(Sender: TObject);
begin
  if paginas.ActivePage = TabNotas then
  begin
    if not (MovParcelas.EOF) then
    begin
      EditLocaliza8.Text := ECodFilial.Text;
      label21.Caption := LFilial.caption;
      DataNota1.Date := PrimeiroDiaMes( MovParcelasD_DAT_EMI.AsDateTime);
      DataNota2.Date := UltimoDiaMes(MovParcelasD_DAT_EMI.AsDateTime);
      SomenteUmaNota := true;
      EPlanoGeral.Clear;
      EditLocaliza7.Clear;
      executaNotaPai;
      CarregaVariaveisGrafico;
    end
    else
       ExecutaNotaPai;
    BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
  end
  else
  begin
    if paginas.ActivePage = TabParcelas then
    begin

      executaParcelaPai;
      FechaTabela(MovNotas);
      FechaTabela(cadNotas);
    end;
    BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
  end;
  CarregaVariaveisGrafico;
end;

{****************************Atualiza as consultas*****************************}
procedure TFContasaPagar.DataParcela1CloseUp(Sender: TObject);
begin
   if Filtro.Checked then
   begin
     executaParcelaPai;
   end;
   CarregaVariaveisGrafico;
end;

{*******************Atualiza a tabela pai das parcelas*************************}
procedure TFContasaPagar.SitParClick(Sender: TObject);
begin
  if Filtro.Checked then
    executaparcelapai;
end;

{*******************Atualiza a tabela pai das parcelas*************************}
procedure TFContasaPagar.BitBtn9Click(Sender: TObject);
begin
   executaparcelapai;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Visualiza a foto da conta que será paga*********************}
procedure TFContasaPagar.FotoParcelasClick(Sender: TObject);
begin
   VisualizaFoto.execute(varia.DriveFoto + MovParcelas.fieldByName('C_PAT_FOT').AsString)
end;

{******************Visualiza a foto da conta que será paga*********************}
procedure TFContasaPagar.FotoNotasClick(Sender: TObject);
begin
   VisualizaFoto.execute(varia.DriveFoto + CadNotas.fieldByName('C_PAT_FOT').AsString)
end;

{ **********************  Chama a tela de comissõoes ********************** }
procedure TFContasaPagar.BComissoesClick(Sender: TObject);
begin
  FMovComissoes := TFMovComissoes.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMovComissoes'));
  FMovComissoes.MostraComissoes(dataparcela1.DateTime, dataParcela2.DateTime);
end;

{**********************Esconde os detalhes da conta****************************}
procedure TFContasaPagar.BitBtn2Click(Sender: TObject);
begin
  Detalhes.Visible := false;
end;

{***************************Fecha  o Formulario corrente***********************}
procedure TFContasaPagar.BitBtn1Click(Sender: TObject);
begin
  if FGraficosCP <> nil then
     FGraficosCP.close;
  self.close;
end;

{***********************atualiza os dados das tabelas**************************}
procedure TFContasaPagar.AlterarFornecedor1Click(Sender: TObject);
begin
  if MovParcelasI_COD_CLI.AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+IntToStr(MovParcelasI_COD_CLI.AsInteger));
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    FNovoCliente.Free;
  end;
end;

procedure TFContasaPagar.atualizadados;
begin
    if paginas.ActivePage = TabNotas then
    begin
      AtualizaSQLTabela(CadNotas);
      BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
    end
    else
    begin
       executaParcelaPai;
    end;
end;

{******************************************************************************}
function TFContasaPagar.CarDParcelaMovParcela(VpaDParcela : TRBDParcelaCP) : Boolean;
begin
  result := true;
  if MovParcelasI_EMP_FIL.AsInteger <> 0 then
  begin
    FunContasAPagar.CarDParcelaBaixa(VpaDParcela,MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_APG.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
    result := FunContasAPagar.ValidaParcelaPagamento(VpaDParcela.CodFilial,VpaDParcela.LanPagar,VpaDParcela.NumParcela);
  end;
end;

{******************************************************************************}
function TFContasaPagar.CarParcelasaBaixar(VpaDBaixa : trbDBaixaCP) : Boolean;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
begin
  result := true;
  FreeTObjectsList(VpaDBaixa.Parcelas);
  if paginas.ActivePage = TabNotas then
  begin

  end
  else
  begin
    if GParcelas.SelectedRows.Count = 0 then
    begin
      VpfDParcela := VpaDBaixa.AddParcela;
      result := CarDParcelaMovParcela(VpfDParcela);
    end
    else
    begin
      for VpfLaco := 0 to GParcelas.SelectedRows.Count - 1 do
      begin
        MovParcelas.GotoBookmark(TBookmark(GParcelas.SelectedRows.Items[VpfLaco]));
        VpfDParcela := VpaDBaixa.AddParcela;
        result := CarDParcelaMovParcela(VpfDParcela);
        if not result then
          break;
      end;
    end;
  end;
  VpaDBaixa.CodFornecedor:= VpfDParcela.CodCliente;
end;

{*******************Chama o formulario para efetuar baixa**********************}
procedure TFContasaPagar.BPagamentoClick(Sender: TObject);
var
  VpfDBaixaCP : TRBDBaixaCP;
begin
  VpfDBaixaCP := TRBDBaixaCP.Cria;
  if CarParcelasaBaixar(VpfDBaixaCP) then
  begin
    FBaixaContasaPagarOO := TFBaixaContasaPagarOO.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaContasaPagarOO'));
    if FBaixaContasaPagarOO.BaixarContasAPagar(VpfDBaixaCP) then
      executaParcelaPai;
//    FBaixaContasaReceberOO.free;
  end;
  VpfDBaixaCP.free;
end;

{**********O botao de executar filtro recebe o contraio do checek filtro*******}
procedure TFContasaPagar.FiltroClick(Sender: TObject);
begin
  BitBtn9.Enabled := not filtro.Checked;
end;

{***************Chama o formulario para imprimir o contas a pagar**************}
procedure TFContasaPagar.BImprimirClick(Sender: TObject);
begin
  rvParcelas.close;
  rvParcelas.ProjectFile := varia.PathRelatorios+'\Financeiro\XX_ContasAPagar.rav';
  rvParcelas.SetParam('FILIAL',LFilial.Caption);
  rvParcelas.SetParam('PERIODO','Período de '+FormatDateTime('DD/MM/YY',DataParcela1.DateTime)+' até '+FormatDateTime('DD/MM/YY',DataParcela2.DateTime));
  rvParcelas.execute;
end;

{************Carrega as variáveis do gráfico do contas a pagar*****************}
procedure TFContasaPagar.CarregaVariaveisGrafico;
begin
  if FGraficosCP <> nil then
  begin
    if paginas.ActivePage = TabNotas then
    begin
      FGraficosCP.CodigoEmpresa := IntToStr(varia.CodigoEmpresa);
      FGraficosCP.CodigoFilial :=  EditLocaliza8.Text;
      FGraficosCP.NomeEmpresa := varia.NomeEmpresa;
      FGraficosCP.NomeFilial := label21.Caption;
      FGraficosCP.Data1 :=  dataNota1.Date;
      FGraficosCP.Data2 := dataNota2.Date;
    end
    else
     if paginas.ActivePage = TabParcelas then
     begin
        FGraficosCP.CodigoEmpresa := IntToStr(varia.CodigoEmpresa);
        FGraficosCP.CodigoFilial :=  ECodFilial.Text;
        FGraficosCP.NomeEmpresa := varia.NomeEmpresa;
        FGraficosCP.NomeFilial :=  LFilial.Caption;
        FGraficosCP.Data1 :=  DataParcela1.Date;
        FGraficosCP.Data2 :=  DataParcela2.Date;
    end
  end;
end;

{********************Chama o gráfico do contas a pagar*************************}
procedure TFContasaPagar.BGraficosClick(Sender: TObject);
begin
  if FGraficosCP = nil then
  begin
    FGraficosCP := TFgraficosCP.CriarSDI(application,'',true);
    CarregaVariaveisGrafico;
    FGraficosCP.Show;
  end;
end;

{**************************Visualiza a nota Fiscal*****************************}
procedure TFContasaPagar.BProdutosClick(Sender: TObject);
 var
    VpfCodFilial, NumeroNota : Integer;
begin
  NumeroNota := 0;
  if (paginas.ActivePage = TabNotas) and  (not CadNotas.FieldByName('I_SEQ_NOT').IsNull) then
  begin
      NumeroNota := CadNotas.FieldByName('I_SEQ_NOT').AsInteger;
      VpfCodFilial := CadNotas.FieldByName('I_EMP_FIL').AsInteger;
  end
  else
     if (paginas.ActivePage = TabParcelas) and ( not MovParcelas.FieldByName('I_SEQ_NOT').IsNull) then
     begin
         NumeroNota :=  MovParcelas.FieldByName('I_SEQ_NOT').AsInteger;
         VpfCodFilial := MovParcelas.FieldByName('I_EMP_FIL').AsInteger;
     end;
  if NumeroNota <> 0 then
  begin
    FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaNotaFiscaisFor'));;
    FNovaNotaFiscaisFor.ConsultaNota( VpfCodFilial,NumeroNota);
    FNovaNotaFiscaisFor.free;
  end
  else
     aviso(CT_NaoPossuiNota);
end;

procedure TFContasaPagar.ExZoomClick(Sender: TObject);
begin
  if ExZoom.Down then
  begin
    ExZoom.ImageIndex := 1;
     PanelColor3.Visible := false;
  end
  else
  begin
     ExZoom.ImageIndex := 0;
     PanelColor3.Visible := true;
  end;
end;

{******************************************************************************}
procedure TFContasaPagar.BAlterarClick(Sender: TObject);
begin
  FManutencaoCP := TFManutencaoCP.CriarSDI(self, '', FPrincipal.VerificaPermisao('FManutencaoCP'));
  if paginas.ActivePage = TabNotas then
  begin
    FManutencaoCP.CarregaConta(CadNotasI_EMP_FIL.AsInteger,CadNotasI_LAN_APG.AsInteger);
    FManutencaoCP.ShowModal;
    AtualizaSQLTabela(CadNotas);
    AtualizaSQLTabela(movnotas);
  end
  else
  begin
    FManutencaoCP.CarregaConta(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_APG.AsInteger);
    FManutencaoCP.ShowModal;
    executaParcelaPai;
  end;
end;

{ *************** cadastra uma nova conta *********************************** }
procedure TFContasaPagar.BotaoCadastrar1Click(Sender: TObject);
begin
  FNovoContasAPagar := TFNovoContasAPagar.CriarSDI(self,'', FPrincipal.VerificaPermisao('FNovoContasAPagar'));
  if FNovoContasAPagar.NovoContasaPagar(ECodCliente.AInteiro) then
    AtualizaDados;
  FNovoContasAPagar.free;
end;

{******************************************************************************}
procedure TFContasaPagar.SomadorClick(Sender: TObject);
begin
  executaParcelaPai;
end;

{******************************************************************************}
procedure TFContasaPagar.EPlanoGeralExit(Sender: TObject);
var
  VpfCodigo,VpfTipoE_S : string;
begin
  VpfTipoE_S := 'D';
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  if (Sender is TSpeedButton)  then
    VpfCodigo := '99999'
  else
    VpfCodigo := EPlanoGeral.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, VpfTipoE_S, LPlanoGeral, False) then
    EPlanoGeral.SetFocus;
  EPlanoGeral.text := VpfCodigo;
  executaNotaPai;
  CarregaVariaveisGrafico;
end;

procedure TFContasaPagar.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.VerificaCodigo(VpfCodigo,'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.Text := VpfCodigo;
  // ------------ //
  if Filtro.Checked then
     executaparcelapai;
end;

procedure TFContasaPagar.MovNotasAfterScroll(DataSet: TDataSet);
begin
  if paginas.ActivePage = TabNotas then
    BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull and (not MovNotas.EOF);
end;

{*************Habilita ou não o botão para visualizar a foto*******************}
procedure TFContasaPagar.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if MovParcelas.fieldByName('C_PAT_FOT').AsString <> '' then
    FotoParcelas.Enabled := true
  else
    FotoParcelas.Enabled := false;
  if paginas.ActivePage <> TabNotas then
    BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
  BAlterar.Enabled := true;
  if MovParcelasC_DES_PRR.AsString ='S' then
    MProrrogado.Caption := 'Desmarcar Prorrogada'
  else
    MProrrogado.Caption := 'Marcar Prorrogada'

end;

{******************************************************************************}
procedure TFContasaPagar.MProrrogadoClick(Sender: TObject);
begin
  if MovParcelasC_DES_PRR.AsString = 'N' then
    FunContasAPagar.MarcaProrrogado(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_APG.AsInteger,MovParcelasI_NRO_PAR.AsInteger,true)
  else
    FunContasAPagar.MarcaProrrogado(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_APG.AsInteger,MovParcelasI_NRO_PAR.AsInteger,false);
  executaParcelaPai;
end;

{********Verifica se é virada do mes para atualizar as despesas fixas**********}
procedure TFContasaPagar.FormShow(Sender: TObject);
begin
  if Config.GerarDespesasFixa then
  begin
{     AbreTabela(CFG);
     if Mes(cfg.fieldByName('D_ATU_DES').AsDateTime) <> Mes(date) then   // atualiza o mes
     begin
        if confirmacao(CT_AtualizaMes) then
        begin
          // ROTINA DE ATUALIZAÇÃO DAS DESPESAS FIXAS.
          Despesa.AtualizaDespesas;
          EditarReg(CFG); // GRAVA A DATA DA ÚLTIMA ATUALIZAÇÃO DAS DESPESAS FIXAS EFETUADA.
          CFG.fieldByName('D_ATU_DES').AsDateTime := Date;
          GravaReg(CFG);
        end;
     end;
     FechaTabela(aux);
     FechaTabela(cfg);}
  end;
  Paginas.ActivePage := TabParcelas;
  ECodFilial.Text := IntToStr(varia.CodigoEmpFil);
  LFilial.Caption := varia.nomeFilial;
  EditLocaliza8.Text := IntToStr(varia.CodigoEmpFil);
  Label21.Caption := varia.nomeFilial;
  ExecutaParcelaPai;
  // Desativa a parte de faturamento.
  BProdutos.Visible := ConfigModulos.NotaFiscal;
end;

procedure TFContasaPagar.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

procedure TFContasaPagar.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFContasaPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
        if (key = 77) then
        begin
          if (puFIConsultarCPOculto in varia.PermissoesUsuario) then
          begin
            VprMostrarContas := true;
            executaParcelaPai;
            BMostrarConta.Visible := true;
            ETotalSemNota.Visible := true;
            LTotalSemNota.Visible := true;
            VprPressionadoR := false;
          end;
        end
        else
          VprPressionadoR := false;
  end;
end;

{******************************************************************************}
procedure TFContasaPagar.BMostrarContaClick(Sender: TObject);
begin
  VprMostrarContas := false;
  BMostrarConta.visible := false;
  ETotalSemNota.Visible := false;
  LTotalSemNota.Visible := false;
  executaParcelaPai;
end;

procedure TFContasaPagar.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    PanelColor3.Height := EContaCorrente.Top + EContaCorrente.Height + 5;
    BFiltros.Caption := '<<';
  end
  else
  begin
    PanelColor3.Height := ENotaFiscal.Top + ENotaFiscal.Height + 5;
    BFiltros.Caption := '>>';
  end;

end;

procedure TFContasaPagar.MConsultaChequesClick(Sender: TObject);
begin
  FConsultaCheques := tFConsultaCheques.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaCheques'));
  FConsultaCheques.ConsultaChequesContasPAgar(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_APG.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
  FConsultaCheques.free;
end;

Initialization
  RegisterClasses([TFContasaPagar]);
end.
