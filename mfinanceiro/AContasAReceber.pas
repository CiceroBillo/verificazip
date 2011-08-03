unit AContasAReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores, ToolWin,
  ImgList, numericos, UnContasAReceber, UnDadosProduto, UnNotaFiscal, UnSistema,
  Menus, UnDados, UnClientes,UnImpressaoBoleto, UnDadosCR, UnClassesImprimir, UnImpressao,
  DBClient, RpDefine, RpBase, RpSystem,RPDevice;

type
  TFContasaReceber = class(TFormularioPermissao)
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
    MovNotasI_EMP_FIL: TFMTBCDField;
    MovNotasI_NRO_PAR: TFMTBCDField;
    MovNotasD_DAT_VEN: TSQLTimeStampField;
    MovNotasD_DAT_PAG: TSQLTimeStampField;
    MovNotasN_PER_JUR: TFMTBCDField;
    MovNotasN_VLR_DES: TFMTBCDField;
    MovNotasN_VLR_PAG: TFMTBCDField;
    MovNotasN_PER_MOR: TFMTBCDField;
    MovNotasN_VLR_ACR: TFMTBCDField;
    PanelColor4: TPanelColor;
    Label15: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    LNomFilial: TLabel;
    Label16: TLabel;
    Label21: TLabel;
    Filtro: TCheckBox;
    tempo: TPainelTempo;
    Panel1: TPanel;
    DBMemoColor1: TDBMemoColor;
    BNGraficoNota: TBitBtn;
    FotoNotas: TBitBtn;
    Label11: TLabel;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    dataNota1: TCalendario;
    DataNota2: TCalendario;
    ECliente: TEditLocaliza;
    ECodFilial: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    EditLocaliza7: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    EditLocaliza8: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    MovNotasI_LAN_REC: TFMTBCDField;
    MovNotasN_VLR_PAR: TFMTBCDField;
    MovNotasN_PER_COR: TFMTBCDField;
    Detalhes: TComponenteMove;
    Label50: TLabel;
    PanelColor5: TPanelColor;
    Label49: TLabel;
    DBText27: TDBText;
    Label29: TLabel;
    DBText8: TDBText;
    Label30: TLabel;
    DBText7: TDBText;
    Label31: TLabel;
    DBText9: TDBText;
    Label32: TLabel;
    DBText10: TDBText;
    Label33: TLabel;
    DBText11: TDBText;
    Label34: TLabel;
    DBText12: TDBText;
    Label35: TLabel;
    Label36: TLabel;
    DBText14: TDBText;
    Label39: TLabel;
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
    BitBtn2: TBitBtn;
    DBText13: TDBText;
    Label37: TLabel;
    DBText15: TDBText;
    MovNotasC_NRO_DUP: TWideStringField;
    SpeedButton9: TSpeedButton;
    MovParcelasI_LAN_REC: TFMTBCDField;
    MovParcelasL_OBS_REC: TWideStringField;
    MovParcelasI_COD_CLI: TFMTBCDField;
    MovParcelasI_NRO_NOT: TFMTBCDField;
    MovParcelasI_NRO_PAR: TFMTBCDField;
    MovParcelasD_DAT_VEN: TSQLTimeStampField;
    MovParcelasN_VLR_PAR: TFMTBCDField;
    MovParcelasD_DAT_PAG: TSQLTimeStampField;
    MovParcelasN_VLR_PAG: TFMTBCDField;
    MovParcelasC_NOM_CLI: TWideStringField;
    MovParcelasI_SEQ_NOT: TFMTBCDField;
    MovParcelasN_PER_DES: TFMTBCDField;
    MovParcelasC_NOM_PAG: TWideStringField;
    MovParcelasC_NOM_FRM: TWideStringField;
    MovParcelasC_NRO_DUP: TWideStringField;
    MovParcelasN_DES_VEN: TFMTBCDField;
    MovParcelasn_PER_MUL: TFMTBCDField;
    MovParcelasn_PER_JUR: TFMTBCDField;
    MovParcelasN_VLR_DES: TFMTBCDField;
    MovParcelasN_VLR_ACR: TFMTBCDField;
    MovParcelasC_NRO_DOC: TWideStringField;
    MovParcelasN_PER_MOR: TFMTBCDField;
    CadNotasI_EMP_FIL: TFMTBCDField;
    CadNotasI_LAN_REC: TFMTBCDField;
    CadNotasN_VLR_TOT: TFMTBCDField;
    CadNotasI_NRO_NOT: TFMTBCDField;
    CadNotasD_DAT_EMI: TSQLTimeStampField;
    CadNotasD_DAT_MOV: TSQLTimeStampField;
    CadNotasC_NOM_CLI: TWideStringField;
    ImageList1: TImageList;
    Label13: TLabel;
    DBText3: TDBText;
    Label12: TLabel;
    DBText2: TDBText;
    MovParcelasD_DAT_EMI: TSQLTimeStampField;
    MovNotasL_OBS_REC: TWideStringField;
    MovNotasN_PER_MUL: TFMTBCDField;
    GParcelas: TGridIndice;
    GridIndice2: TGridIndice;
    CadNotasI_SEQ_NOT: TFMTBCDField;
    Label3: TLabel;
    Label9: TLabel;
    DBText5: TDBText;
    MovParcelasC_CLA_PLA: TWideStringField;
    CadNotasC_NOM_PLA: TWideStringField;
    Label1: TLabel;
    EPlanoGeral: TEditColor;
    SpeedButton2: TSpeedButton;
    LPlanoGeral: TLabel;
    BProdutos: TBitBtn;
    TotalAberto: Tnumerico;
    numerico2: Tnumerico;
    SitPar: TComboBoxColor;
    RPeriodo: TComboBoxColor;
    MovParcelasD_DAT_MOV: TSQLTimeStampField;
    Label14: TLabel;
    Label19: TLabel;
    BComissoes: TBitBtn;
    numerico3: Tnumerico;
    Label26: TLabel;
    BGraficos: TBitBtn;
    BImprimir: TBitBtn;
    BitBtn9: TBitBtn;
    ToolBar1: TToolBar;
    ExZoom: TToolButton;
    BAlterar: TBitBtn;
    MovParcelasI_COD_BAN: TFMTBCDField;
    BMostrarConta: TSpeedButton;
    BitBtn3: TBitBtn;
    MovParcelasI_EMP_FIL: TFMTBCDField;
    CAtualizarTotais: TCheckBox;
    MovParcelasC_IND_CAD: TWideStringField;
    CadNotasC_IND_CAD: TWideStringField;
    PopupMenu1: TPopupMenu;
    AdicionarRemessa1: TMenuItem;
    Label23: TLabel;
    EFormaPagamento: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    LFormaPagamento: TLabel;
    BitBtn4: TBitBtn;
    EContaCorrente: TEditLocaliza;
    Label28: TLabel;
    SpeedButton3: TSpeedButton;
    Label38: TLabel;
    BFiltros: TBitBtn;
    EDuplicata: TEditColor;
    Label47: TLabel;
    N1: TMenuItem;
    HistricoCobrana1: TMenuItem;
    Label51: TLabel;
    DBText25: TDBText;
    MovParcelasD_PRO_LIG: TSQLTimeStampField;
    N2: TMenuItem;
    ImprimirBoleto1: TMenuItem;
    Label52: TLabel;
    DBText16: TDBText;
    MovParcelasC_IND_RET: TWideStringField;
    EmailBoleto1: TMenuItem;
    CFundoPerdido: TCheckBox;
    MovParcelasC_FUN_PER: TWideStringField;
    ENossoNumero: TEditColor;
    Label53: TLabel;
    MovParcelasI_COD_FRM: TFMTBCDField;
    ENotaFiscal: Tnumerico;
    Label54: TLabel;
    Label55: TLabel;
    ECidade: TEditColor;
    EnviarCartrio1: TMenuItem;
    N3: TMenuItem;
    Label48: TLabel;
    DBText1: TDBText;
    MovParcelasD_ENV_CAR: TSQLTimeStampField;
    N4: TMenuItem;
    ConsultaCheques1: TMenuItem;
    Label2: TLabel;
    LBanco: TLabel;
    ELanReceber: Tnumerico;
    Label22: TLabel;
    MovParcelasC_NRO_CON: TWideStringField;
    N5: TMenuItem;
    ImprimeReceibo1: TMenuItem;
    MovParcelasC_DUP_DES: TWideStringField;
    Label56: TLabel;
    DBText4: TDBText;
    MovParcelasN_TAR_DES: TFMTBCDField;
    EfetuarCobrana1: TMenuItem;
    N6: TMenuItem;
    LTotalSemNota: TLabel;
    ETotalSemNota: Tnumerico;
    N7: TMenuItem;
    AlterarCliente1: TMenuItem;
    MovParcelasC_NOS_NUM: TWideStringField;
    RvSystem: TRvSystem;
    Label25: TLabel;
    EClienteMaster: TRBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label27: TLabel;
    ImprimePromissria1: TMenuItem;
    Label57: TLabel;
    SpeedButton10: TSpeedButton;
    Label58: TLabel;
    EVendedor: TRBEditLocaliza;
    MovParcelasC_MOS_FLU: TWideStringField;
    MovParcelasC_IND_SIN: TWideStringField;
    Label59: TLabel;
    DBText6: TDBText;
    N8: TMenuItem;
    MMostrarFluxo: TMenuItem;
    Label60: TLabel;
    DBText26: TDBText;
    MovParcelasD_DAT_PRO: TSQLTimeStampField;
    EDescontos: TComboBoxColor;
    Label61: TLabel;
    Label17: TLabel;
    EPlano: TEditColor;
    BPlano: TSpeedButton;
    LPlano: TLabel;
    AdicionarTodosArquivosnaRemessa1: TMenuItem;
    MovParcelasN_SIN_BAI: TFMTBCDField;
    CPeriodo: TCheckBox;
    LTotalSelecionado: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure CadNotasAfterScroll(DataSet: TDataSet);
    procedure TipoDataNotaChange(Sender: TObject);
    procedure DataNota1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TipoDataParcelaChange(Sender: TObject);
    procedure DataParcela1Change(Sender: TObject);
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
    procedure EditLocaliza1FimConsulta(Sender: TObject);
    procedure ECodFilialSelect(Sender: TObject);
    procedure EditLocaliza6FimConsulta(Sender: TObject);
    procedure gradeParcelas2DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure gradeParcelas2KeyPress(Sender: TObject; var Key: Char);
    procedure ECodFilialExit(Sender: TObject);
    procedure ExZoomClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoGeralExit(Sender: TObject);
    procedure MovParcelasAfterScroll(DataSet: TDataSet);
    procedure MovNotasAfterScroll(DataSet: TDataSet);
    procedure BComissoesClick(Sender: TObject);
    procedure BProdutosClick(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure ECodFilialFimConsulta(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BMostrarContaClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure AdicionarRemessa1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure EDuplicataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HistricoCobrana1Click(Sender: TObject);
    procedure ImprimirBoleto1Click(Sender: TObject);
    procedure EmailBoleto1Click(Sender: TObject);
    procedure GParcelasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EnviarCartrio1Click(Sender: TObject);
    procedure ConsultaCheques1Click(Sender: TObject);
    procedure GParcelasOrdem(Ordem: String);
    procedure ImprimeReceibo1Click(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure EfetuarCobrana1Click(Sender: TObject);
    procedure AlterarCliente1Click(Sender: TObject);
    procedure RvSystemNewPage(Sender: TObject);
    procedure RvSystemBeforePrint(Sender: TObject);
    procedure RvSystemPrintFooter(Sender: TObject);
    procedure RvSystemPrint(Sender: TObject);
    procedure ImprimePromissria1Click(Sender: TObject);
    procedure MMostrarFluxoClick(Sender: TObject);
    procedure AdicionarTodosArquivosnaRemessa1Click(Sender: TObject);
    procedure GParcelasCellClick(Column: TColumn);
  private
    TeclaPresionada : Boolean;
    SomenteUmaNota : Boolean;
    VprMostrarContas,
    VprPressionadoR : Boolean;
    VprOrdem : string;
    VprCodFilial,
    VprLanReceberSinalPagamento,
    VprSeqCheque : Integer;
    CR : TCalculosContasAReceber;
    FunImpressao : TFuncoesImpressao;
    FunImpFolhaBranca: TImpressaoBoleto;
    procedure executaNotaPai;
    procedure executaNotaFilho;
    procedure executaParcelaPai;
    procedure AdicionaFiltrosParcelaPai(VpaSelect : TStrings);
    procedure AtualizaTotais;
    procedure PosNaoDescontadosPorFormaPagamento(VpaTabela : TSql);
    procedure VerificaBotoes( estado : Boolean );
    procedure AtualizaDados;
    function CarDParcelaMovParcela(VpaDParcela : TRBDParcelaBaixaCR) : Boolean;
    function CarParcelasaBaixar(VpaDBaixa : trbDBaixaCR) : Boolean;
    procedure ImprimeRecibo;
    procedure ImprimePromissoria;
    procedure ImprimeRelatorioContasAReceber;
    procedure InicializaRelatorio(VpaRelatorio : Integer);
    procedure ImprimeCabecalhoRelatorioCR;
    procedure DefineTabelaImpressaoCR;
    procedure ImprimeLinhasCR;
    procedure ImprimeSomaDiaCR(VpaTotalDuplicataDia,VpaTotalPagoDia : Double);
    procedure ImprimeSomaMesCR(VpaTotalDuplicataMes,VpaTotalPagoMes : Double;VpaMes : TDateTime);
    procedure ImprimeporFormaPagamento;
    procedure CarDRepresentanteFilial(VpaDFilial : TRBDFilial);
    procedure AdicionaParcelasArquivoRemessa;
    procedure SomaCRSelecionado;
  public
    procedure ConsultaContasReceberCliente(VpaCodCliente: Integer);
    procedure ConsultaContasdoCheque(VpaSeqCheque : Integer);
    procedure ConsultaAdiantamento(VpaCodFilial, VpaLanReceber : Integer);
  end;

var
  FContasaReceber: TFContasaReceber;

implementation

uses fundata, APrincipal, constmsg, ANovoContasaReceber,
   AGraficosContasaReceber, AManutencaoCR, funsql, APlanoConta,
  AMovComissoes, ANovaNotaFiscalNota, AConsolidarCR, ANovaCotacao, FunObjeto,
  AVisualizaLogReceber, ACobrancas, AConsultacheques,
  ABaixaContasAReceberOO, AMostraObservacaoCliente, ANovaCobranca,
  ANovoCliente, dmRave, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContasaReceber.FormCreate(Sender: TObject);
begin
  VprOrdem := ' order by MCR.D_DAT_VEN';
  FunImpressao := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
   SitPar.ItemIndex := 9;
   RPeriodo.ItemIndex := 0;
   EDescontos.ItemIndex := 0;
   VprMostrarContas := false;
   VprPressionadoR := false;
   DataParcela1.Date := PrimeiroDiaMes(date);
   DataParcela2.Date := UltimoDiaMes(date);
   DataNota1.Date := DataParcela1.Date;
   DataNota2.Date := DataParcela2.Date;
   TeclaPresionada := true;
   SomenteUmaNota := false;
   FunImpFolhaBranca := TImpressaoBoleto.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContasaReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(CadNotas);
   FechaTabela(MovNotas);
   FechaTabela(MovParcelas);
   CR.Free;
   FunImpFolhaBranca.free;
   FunImpressao.Free;
   Action := CaFree;
end;

{********************Quando o formulario é mostrado****************************}
procedure TFContasaReceber.FormShow(Sender: TObject);
begin
  Paginas.ActivePage := TabParcelas;
  ECodFilial.Text := IntToStr(varia.CodigoEmpFil);
  LNomFilial.Caption := varia.nomeFilial;
  EditLocaliza8.Text := IntToStr(varia.CodigoEmpFil);
  Label21.Caption := varia.nomeFilial;
  ExecutaParcelaPai;
  ///////////////////////////////
  // ATIVA SE O MÓDULO EXISTIR //
  ///////////////////////////////
  BProdutos.Visible := ConfigModulos.NotaFiscal;
  //////////////////////////////////
  // CONFIG. MÓDULO DE COMISSÕES  //
  //////////////////////////////////
  BComissoes.Visible := ConfigModulos.Comissao;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Atividades dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************* cadastra uma nova conta ************************************** }
procedure TFContasaReceber.BotaoCadastrar1Click(Sender: TObject);
begin
   FNovoContasAReceber := TFNovoContasAReceber.CriarSdi(self,'',true);
   FNovoContasAReceber.NovoContasAReceber(ECliente.AInteiro);
   FNovoContasAReceber.free;
   AtualizaDados;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFContasaReceber.BitBtn1Click(Sender: TObject);
begin
  if FGraficosCR <> nil then
   FGraficosCR.close;
  self.close;
end;


{***************************Chama a baixa da parcela***************************}
procedure TFContasaReceber.BPagamentoClick(Sender: TObject);
var
  VpfDBaixaCR : TRBDBaixaCR;
begin
  VpfDBaixaCR := TRBDBaixaCR.Cria;
  if CarParcelasaBaixar(VpfDBaixaCR) then
  begin
    if VpfDBaixaCR.Parcelas.Count > 0 then
    begin
      FBaixaContasaReceberOO := TFBaixaContasaReceberOO.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaContasaReceberOO'));
      if FBaixaContasaReceberOO.BaixarContasAReceber(VpfDBaixaCR) then
        executaParcelaPai;
      FBaixaContasaReceberOO.free;
    end
    else
      aviso('As parcelas selecionadas já foram pagas.');
  end;
  VpfDBaixaCR.free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da Nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.CadNotasAfterScroll(DataSet: TDataSet);
begin
   if TeclaPresionada then
    executaNotaFilho;
   if CadNotas.EOF then
     CadNotas.Prior;
end;


{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.TipoDataNotaChange(Sender: TObject);
begin
   ExecutaNotaPai;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.DataNota1Change(Sender: TObject);
begin
   executaNotaPai;
   CarregaVariaveisGrafico;
end;

{*****************************Atualiza a Consulta******************************}
procedure TFContasaReceber.executaNotaPai;
begin
 CadNotas.close;
  LimpaSQLTabela(CadNotas);
  InseriLinhaSQL(CadNotas, 0,' Select ' +
                         ' CR.I_EMP_FIL, CR.I_LAN_REC, CR.N_VLR_TOT, CR.I_NRO_NOT, ' +
                         ' CR.D_DAT_EMI, CR.D_DAT_MOV, CR.I_SEQ_NOT, CR.C_IND_CAD,' +
                         ' P.C_NOM_PLA, C.C_NOM_CLI ' +
                         ' from CadContasAReceber  CR, CadClientes C, CAD_PLANO_CONTA P ' +
                         ' where CR.C_CLA_PLA = P.C_CLA_PLA and CR.I_COD_CLI = C.I_COD_CLI' );

   if EditLocaliza8.Text = '' then
         InseriLinhaSQL(CadNotas, 1,'and CR.I_EMP_FIL >= 0 ')
   else
        InseriLinhaSQL(CadNotas, 1,'and CR.I_EMP_FIL = ' + EditLocaliza8.Text );


   if EPlanoGeral.Text <> '' then
     InseriLinhaSQL(CadNotas, 2,' and CR.C_CLA_PLA = ''' + Trim(EPlanoGeral.Text) + '''' )
   else
     InseriLinhaSQL(CadNotas, 2,'');


   if EditLocaliza7.Text <> '' then
     InseriLinhaSQL(CadNotas, 3,' and CR.I_COD_CLI = ' + EditLocaliza7.Text )
   else
     InseriLinhaSQL(CadNotas, 3,'');
   InseriLinhaSQL(CadNotas, 4,SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',DataNota1.Date,DataNota2.Date,true));

   if  SomenteUmaNota then
   begin
     InseriLinhaSQL(CadNotas, 5,' and CR.I_LAN_REC = ' + MovPArcelasI_LAN_REC.AsString );
     SomenteUmaNota := false;
   end
     else
       InseriLinhaSQL(CadNotas, 5,' ');

   InseriLinhaSQL(CadNotas, 6,' order by CR.I_LAN_REC'); //para ordenar

   AbreTabela(CadNotas);
   executaNotaFilho;
   VerificaBotoes(not CadNotas.EOF)
end;

{*****************************Atualiza a consulta******************************}
procedure TFContasaReceber.executaNotaFilho;
begin
  MovNOtas.close;
   LimpaSQLTabela(MovNotas);
   if not CadNotas.EOF then
   begin
     AdicionaSQLTabela(MovNotas, 'Select * from MovContasaReceber ' +
                      ' where I_EMP_FIL = ' + IntToStr(CadNotasI_EMP_FIL.AsInteger) +
                      ' and I_LAN_REC = ' + CadNotasI_LAN_REC.AsString +
                      ' order by d_dat_ven');
     AbreTabela(MovNotas);
   end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.EditLocaliza6FimConsulta(Sender: TObject);
begin
  ExecutaNotaPai;
  CarregaVariaveisGrafico;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.EditLocaliza1FimConsulta(Sender: TObject);
begin
   ECodFilial.Text :=  '';
   if Filtro.Checked then
    executaParcelaPai;
   CarregaVariaveisGrafico;
end;

{**********************Carrega a select da filial******************************}
procedure TFContasaReceber.ECodFilialSelect(Sender: TObject);
begin
   ECodFilial.ASelectLocaliza.Text := ' Select * from CadFiliais fil ' +
                                         ' where c_nom_fan like ''@%'' ' +
                                         ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   ECodFilial.ASelectValida.Text := ' Select * from CadFiliais where I_EMP_FIL = @ ' +
                                       ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.ECodFilialExit(Sender: TObject);
begin
  AtualizaTotais;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos grid's
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************Trata as teclas precionadas***************************}
procedure TFContasaReceber.GradeNota1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TeclaPresionada := false;
  MovNotas.close;
end;

{************************Trata as teclas precionadas***************************}
procedure TFContasaReceber.GradeNota1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   TeclaPresionada := true;
   if key in[37..40]  then
     executaNotaFilho;
end;

{************************Trata as teclas pressionadas**************************}
procedure TFContasaReceber.gradeParcelas2KeyPress(Sender: TObject;
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

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da parcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFContasaReceber.executaParcelaPai;
var
  VpfPosicao : TBookMark;
begin
  VpfPosicao := MovParcelas.GetBookmark;
  MovParcelas.close;
  MovParcelas.sql.clear;
  MovParcelas.sql.add('Select ' );
  MovParcelas.sql.add(' CR.I_EMP_FIL, CR.I_LAN_REC, CR.C_CLA_PLA, MCR.L_OBS_REC, CR.I_SEQ_NOT,' +
                           ' CR.I_COD_CLI, CR.I_NRO_NOT, CR.D_DAT_EMI, CR.C_IND_CAD, CR.C_IND_SIN, '+
                           ' MCR.I_NRO_PAR, MCR.D_PRO_LIG, MCR.C_IND_RET, MCR.C_FUN_PER,' +
                           ' MCR.D_DAT_VEN, MCR.N_DES_VEN, MCR.C_DUP_DES, CR.D_DAT_EMI,' +
                           ' MCR.I_COD_FRM, MCR.D_ENV_CAR, '+SQLTextoIsNull('MCR.C_MOS_FLU','''S''')+' C_MOS_FLU ,'+
                           ' MCR.D_DAT_PRO, MCR.N_SIN_BAI, '+
                           ' CR.C_IND_CON, '+
                           ' (MCR.N_VLR_PAR) as N_VLR_PAR, MCR.D_DAT_PAG,' +
                           ' (MCR.N_VLR_PAG) as N_VLR_PAG, '+
                           ' C.C_NOM_CLI, CR.D_DAT_MOV, ' +
                           ' MCR.C_NRO_DUP,MCR.N_TAR_DES, MCR.C_NOS_NUM, ' +
                           ' CPG.N_PER_DES, CPG.C_NOM_PAG, FRM.C_NOM_FRM,' +
                           ' MCR.N_PER_MUL, MCR.N_PER_JUR, MCR.N_VLR_DES, MCR.I_COD_BAN, ' +
                           ' MCR.N_VLR_ACR, MCR.C_NRO_DOC, MCR.N_PER_MOR, MCR.C_NRO_CON ' );
  MovParcelas.sql.add('from ' +
                           ' MovContasaReceber MCR, ' +
                           ' CadContasaReceber CR, ' +
                           ' CadClientes  C, '+
                           ' CadCondicoesPagto CPG, ' +
                           ' CadFormasPagamento FRM ' +
                           ' where CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                           ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                           ' and CR.I_COD_CLI = C.I_COD_CLI ' +
                           ' and CR.I_COD_PAG = CPG.I_COD_PAG ' +
                           ' and MCR.I_COD_FRM = FRM.I_COD_FRM');
  AdicionaFiltrosParcelaPai(MovParcelas.sql);
  MovParcelas.sql.add(VprOrdem);
   MovParcelas.Open;
   try
     MovParcelas.GotoBookmark(vpfPosicao);
   except
   end;
   GParcelas.ALinhaSQLOrderBy := MovParcelas.SQL.count - 1;
   MovParcelas.FreeBookmark(VpfPosicao);
   VerificaBotoes(not movParcelas.EOF);
   AtualizaTotais;
end;

{******************************************************************************}
procedure TFContasaReceber.AdicionaFiltrosParcelaPai(VpaSelect : TStrings);
begin
  if VprSeqCheque <> 0 then
    VpaSelect.add('and exists ( Select * from CHEQUECR CHE '+
                                        ' Where CHE.CODFILIALRECEBER = MCR.I_EMP_FIL '+
                                        ' AND CHE.LANRECEBER = MCR.I_LAN_REC '+
                                        ' AND CHE.NUMPARCELA = MCR.I_NRO_PAR '+
                                        ' AND CHE.SEQCHEQUE = ' + IntToStr(VprSeqCheque)+')')
  else
    if VprLanReceberSinalPagamento <> 0 then
      VpaSelect.Add(' and exists(select  * '+
                    ' from CADCONTASARECEBER CAD, NOTAFISCALSINALPAGAMENTO ADI '+
                    ' Where CAD.I_EMP_FIL = ADI.CODFILIAL '+
                    ' AND CAD.I_SEQ_NOT = ADI.SEQNOTAFISCAL '+
                    ' AND ADI.CODFILIALSINAL = MCR.I_EMP_FIL  ' +
                    ' AND ADI.LANRECEBERSINAL = MCR.I_LAN_REC ' +
                    ' AND ADI.NUMPARCELASINAL = MCR.I_NRO_PAR)')
  else
  begin
    VpaSelect.add(' AND CR.C_IND_DEV = ''N''');
    if (EDuplicata.Text = '') and (ELanReceber.AsInteger = 0) then
    begin
      if CPeriodo.Checked then
      begin
        case RPeriodo.ItemIndex of
         0 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_VEN',DataParcela1.Date, DataParcela2.Date, true)); // VENCIMENTO;
         1 :begin
              VpaSelect.add(SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',DataParcela1.Date, DataParcela2.Date, true) ); // EMISSÃO.
              VprOrdem := 'order by CR.D_DAT_EMI';
            end;
         2 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_PAG',DataParcela1.Date, DataParcela2.Date, true));// PAGAMENTO.
         3 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('CR.D_DAT_MOV', DataParcela1.Date, DataParcela2.Date, true)); // cadastro.
        end;
      end;
    end;
    case SitPar.ItemIndex of
       0 : VpaSelect.add(' AND MCR.D_DAT_PAG is null' );
       1 : VpaSelect.add(' and MCR.D_DAT_VEN < '+ SQLTextoDataAAAAMMMDD(Date) + ' and MCR.D_DAT_PAG is null ' );
       2 : VpaSelect.add(' and not(MCR.D_DAT_PAG is null)' );
       3 : VpaSelect.add(' and MCR.D_DAT_VEN = '+ SQLTextoDataAAAAMMMDD(Date) + ' and MCR.D_DAT_PAG is null' );
       4 : VpaSelect.add(' and MCR.D_DAT_VEN > '+ SQLTextoDataAAAAMMMDD(Date) +' and MCR.D_DAT_PAG is null ' );
       5 : VpaSelect.add(' and MCR.C_IND_REM = ''N''' );
       6 : VpaSelect.add(' and MCR.C_IND_RET is null');
       7 : VpaSelect.add(' and MCR.C_FUN_PER = ''S''');
       8 : VpaSelect.add(' and MCR.C_DUP_DES IS NULL');
     end;
     // filtro empresa / filial
     if ECodFilial.Text <> '' then
       VpaSelect.add(' and MCR.I_EMP_FIL = ' + ECodFilial.Text);

     // FILTRO DO PLANO DE CONTAS
     if EPlano.Text <> '' then
       VpaSelect.add(' and CR.C_CLA_PLA like ''' + EPLano.Text + '%''' );
     // filtro cliente
     if ECliente.Text <> '' then
       VpaSelect.add(' and MCR.I_COD_CLI = ' + ECliente.Text );
     if EClienteMaster.AInteiro <> 0 then
       VpaSelect.Add(' and C.I_CLI_MAS = '+EClienteMaster.Text);

     IF EContaCorrente.Text <> '' then
       VpaSelect.add(' and MCR.C_NRO_CON = ''' + EContaCorrente.Text+'''' );
    if not VprMostrarContas then
       VpaSelect.add(' and MCR.C_IND_CAD = ''N''');
    if EFormaPagamento.AInteiro <> 0 then
      VpaSelect.add(' AND MCR.I_COD_FRM = '+EFormaPagamento.Text);
    if not CFundoPerdido.Checked then
      VpaSelect.add(' AND MCR.C_FUN_PER = ''N''');
    if EVendedor.AInteiro <> 0 then
      VpaSelect.Add(' AND C.I_COD_VEN = '+EVendedor.Text);
    if ENossoNumero.Text <> '' then
       VpaSelect.add(' AND MCR.C_NOS_NUM = '''+ENossoNumero.Text+'''');
    if ENotaFiscal.AValor <> 0 then
       VpaSelect.add(' AND CR.I_NRO_NOT = '+ENotaFiscal.Text);
    if ECidade.Text <> '' then
      VpaSelect.add(' AND C.C_CID_CLI LIKE '''+ECidade.Text+'%''');
    IF ELanReceber.AsInteger <> 0 then
      VpaSelect.add(' AND CR.I_LAN_REC =  '+ELanReceber.Text);

     IF EDuplicata.Text <> '' then
       VpaSelect.add(' AND MCR.C_NRO_DUP = '''+EDuplicata.Text+'''');
    case EDescontos.ItemIndex of
      1 : VpaSelect.add(' AND MCR.C_DUP_DES = ''S''');
      2 : VpaSelect.add(' AND MCR.C_DUP_DES IS NULL');
    end;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.AtualizaTotais;
begin
  // totais
  if CAtualizarTotais.Checked then
  begin
    Aux.close;
    Aux.sql.clear;
    Aux.Sql.add('Select sum('+SQLTextoIsNull('N_VLR_PAG','N_VLR_PAR * MOE.N_VLR_DIA')+') VALDUPLICATA, ' +
                                ' sum('+SQLTextoIsNull('MCR.N_VLR_PAG','0')+') VALPAGO '+
                ' FROM CADCONTASARECEBER CR, MOVCONTASARECEBER MCR, CADCLIENTES C, CADMOEDAS MOE '+
                ' where CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                ' and MCR.I_COD_MOE = MOE.I_COD_MOE ' +
                ' and CR.I_COD_CLI = C.I_COD_CLI ');
    AdicionaFiltrosParcelaPai(Aux.sql);
    Aux.Open;
    aUX.SQL.SaveToFile('PARCELAS.SQL');
    numerico3.AValor := Aux.FieldByname('VALDUPLICATA').AsFloat;
    numerico2.AValor := Aux.FieldByname('VALPAGO').AsFloat;
    TotalAberto.AValor := numerico3.AValor - numerico2.AValor;

    Aux.close;
    Aux.sql.clear;
    Aux.Sql.add('Select sum('+SQLTextoIsnull('N_VLR_PAG','N_VLR_PAR * MOE.N_VLR_DIA')+') VALDUPLICATA ' +
                ' FROM CADCONTASARECEBER CR, MOVCONTASARECEBER MCR, CADCLIENTES C, CADMOEDAS MOE '+
                ' where CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                ' and MCR.I_COD_MOE = MOE.I_COD_MOE '+
                ' AND CR.I_COD_CLI = C.I_COD_CLI '+
                ' and MCR.C_IND_CAD = ''S''');
    AdicionaFiltrosParcelaPai(Aux.sql);
    Aux.Open;
    ETotalSemNota.AValor := Aux.FieldByname('VALDUPLICATA').AsFloat;;
    Aux.close;
  end
  else
  begin
    numerico3.Clear;
    Numerico2.Clear;
    TotalAberto.Clear;
  end;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.PosNaoDescontadosPorFormaPagamento(VpaTabela : TSql);
begin
    VpaTabela.close;
    VpaTabela.sql.clear;
    VpaTabela.Sql.add('Select sum(N_VLR_PAR) VALDUPLICATA, FRM.C_NOM_FRM '+
                ' FROM CADCONTASARECEBER CR, MOVCONTASARECEBER MCR, CADCLIENTES C, CADMOEDAS MOE, '+
                '  CadFormasPagamento FRM '+
                ' where CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                ' and MCR.I_COD_FRM = FRM.I_COD_FRM '+
                ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                ' and MCR.I_COD_MOE = MOE.I_COD_MOE ' +
                ' and CR.I_COD_CLI = C.I_COD_CLI '+
                ' AND MCR.D_DAT_PAG IS NULL '+
                ' AND MCR.C_DUP_DES IS  NULL ');
    AdicionaFiltrosParcelaPai(VpaTabela.sql);
    VpaTabela.Sql.add(' GROUP BY C_NOM_FRM');

    VpaTabela.Open;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.TipoDataParcelaChange(Sender: TObject);
begin
   executaParcelaPai;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.DataParcela1Change(Sender: TObject);
begin
   if Filtro.Checked then
      executaParcelaPai;
   CarregaVariaveisGrafico;
end;

{******************************Atualiza a consulta*****************************}
procedure TFContasaReceber.PaginasChange(Sender: TObject);
begin
   if paginas.ActivePage = TabNotas then
   begin
     if not (MovParcelas.EOF) then
     begin
       EditLocaliza8.Text := ECodFilial.Text;
       label21.Caption := LNomFilial.caption;
       DataNota1.Date := PrimeiroDiaMes(MovPArcelasD_DAT_EMI.AsDateTime);
       DataNota2.Date := UltimoDiaMes(MovPArcelasD_DAT_EMI.AsDateTime);
       self.ActiveControl := Gradeparcelas1;
       SomenteUmaNota := true;
       ExecutaNotaPai;
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

{*******************************************************************************}
procedure TFContasaReceber.RvSystemBeforePrint(Sender: TObject);
begin
   Case RVSystem.Tag of
     1 : DefineTabelaImpressaoCR;
   End;

end;

procedure TFContasaReceber.RvSystemNewPage(Sender: TObject);
begin
   Case RVSystem.Tag of
     1 : ImprimeCabecalhoRelatorioCR;
   End;
end;

procedure TFContasaReceber.RvSystemPrint(Sender: TObject);
begin
   Case RVSystem.Tag of
     1 : ImprimeLinhasCR;
   End;
end;

procedure TFContasaReceber.RvSystemPrintFooter(Sender: TObject);
begin
   with RVSystem.BaseReport do
  begin
    MoveTo(0,28.5);
    LineTo(21,28.5);
    YPos := 29.0;
    SetFont('Arial',10);
    Bold := False;
    PrintLeft('Data Impressao : '  + FormatDatetime('DD/MM/YYYY - HH:MM:SS',NOW),0.3);
    Printright('Página ' + Macro(midCurrentPage) + ' de ' +
                Macro(midTotalPages),PageWidth-0.5);
  end;

end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.SitParClick(Sender: TObject);
begin
   if Filtro.Checked then
      executaparcelapai;
end;

{******************************************************************************}
procedure TFContasaReceber.SomaCRSelecionado;
var
  VpfLaco : Integer;
  VpfValor : double;
begin
  VpfValor := 0;
  LTotalSelecionado.Visible := GParcelas.SelectedRows.Count  >1;
  if LTotalSelecionado.Visible then
  begin
    for VpfLaco := 0 to GParcelas.SelectedRows.Count -1 do
    begin
      MovParcelas.GotoBookmark(GParcelas.SelectedRows[VpfLaco]);
      VpfValor := VpfValor + MovParcelasN_VLR_PAR.AsFloat;
    end;
    LTotalSelecionado.Caption := 'Total Selecionado : '+FormatFloat('#,###,###,###,##0.00',VpfValor);
  end;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.BitBtn9Click(Sender: TObject);
begin
   executaparcelapai;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************Imprime o contas a Receber**************************}
procedure TFContasaReceber.BImprimirClick(Sender: TObject);
begin
  ImprimeRelatorioContasAReceber;
end;

{***********************Carrega as variáveis no gráfico************************}
procedure TFContasaReceber.CarregaVariaveisGrafico;
begin
  if FGraficosCR <> nil then
  begin
    if paginas.ActivePage = TabNotas then
    begin
      FGraficosCR.CodigoEmpresa := IntTostr(varia.CodigoEmpresa);
      FGraficosCR.CodigoFilial :=  EditLocaliza8.Text;
      FGraficosCR.NomeEmpresa := varia.NomeEmpresa;
      FGraficosCR.NomeFilial := label21.Caption;
      FGraficosCR.Data1 :=  dataNota1.Date;
      FGraficosCR.Data2 := dataNota2.Date;
    end
    else
     if paginas.ActivePage = TabParcelas then
     begin
        FGraficosCR.CodigoEmpresa := IntToStr(varia.CodigoEmpresa);
        FGraficosCR.CodigoFilial :=  ECodFilial.Text;
        FGraficosCR.NomeEmpresa := varia.NomeEmpresa;
        FGraficosCR.NomeFilial :=  LNomFilial.Caption;
        FGraficosCR.Data1 :=  DataParcela1.Date;
        FGraficosCR.Data2 :=  DataParcela2.Date;
    end
  end;
end;

{***************Habilita os botões conforme passado o paramentro***************}
procedure TFContasaReceber.VerificaBotoes( estado : Boolean );
begin
  BProdutos.Enabled := estado;
  BPagamento.Enabled := estado;
  BImprimir.Enabled := estado;
  BGraficos.Enabled := estado;
  BNGraficoNota.Enabled := estado;
end;

{******************************Mostra o gráfico********************************}
procedure TFContasaReceber.BGraficosClick(Sender: TObject);
begin
   FGraficosCR := TFgraficosCR.CriarSDI(application,'',true);
   CarregaVariaveisGrafico;
   FGraficosCR.Show;
end;

{****O Botao de Filtro Manual recebe o contrário do check filtro automático****}
procedure TFContasaReceber.FiltroClick(Sender: TObject);
begin
  BitBtn9.Enabled := not filtro.Checked;
end;

{**************************Mostra o grid das parcelas**************************}
procedure TFContasaReceber.gradeParcelas2DblClick(Sender: TObject);
begin
   Detalhes.Visible := True;
end;

{**********************Esconde o grid das parcelas*****************************}
procedure TFContasaReceber.BitBtn2Click(Sender: TObject);
begin
   detalhes.Visible := false;
end;

{*********************Altera os desenho do botão do zoom***********************}
procedure TFContasaReceber.ExZoomClick(Sender: TObject);
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

{***********************atualiza os dados das tabelas**************************}
procedure TFContasaReceber.AtualizaDados;
begin
  if paginas.ActivePage = TabNotas then
  begin
    AtualizaSQLTabela(CadNotas);
    BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
  end
  else
  begin
    AtualizaSQLTabela(MovParcelas);
    BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
  end;
end;

{******************************************************************************}
function TFContasaReceber.CarDParcelaMovParcela(VpaDParcela : TRBDParcelaBaixaCR) : Boolean;
begin
  FunContasAReceber.CarDParcelaBaixa(VpaDParcela,MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
  result := FunContasAReceber.ValidaParcelaPagamento(VpaDParcela.CodFilial,VpaDParcela.LanReceber,VpaDParcela.NumParcela);
end;

{******************************************************************************}
procedure TFContasaReceber.CarDRepresentanteFilial(VpaDFilial: TRBDFilial);
begin
  AdicionaSQLAbreTabela(Aux, 'SELECT C_DIR_FIL,C_CPF_RES FROM CADFILIAIS WHERE I_EMP_FIL = ' +
                             IntToStr(MovParcelasI_EMP_FIL.AsInteger) );
  VpaDFilial.CodFilial := MovParcelasI_EMP_FIL.AsInteger;
  if not Aux.IsEmpty then
  begin
    VpaDFilial.NomRepresentante := Aux.FieldByName('C_DIR_FIL').AsString;
    VpaDFilial.DesCPFRepresentante := Aux.FieldByName('C_CPF_RES').AsString;
  end;
  FechaTabela(Aux);
end;

{******************************************************************************}
function TFContasaReceber.CarParcelasaBaixar(VpaDBaixa : TRBDBaixaCR) : Boolean;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  result := true;
  FreeTObjectsList(VpaDBaixa.Parcelas);
  if paginas.ActivePage = TabNotas then
  begin

  end
  else
  begin
    if GParcelas.SelectedRows.count = 0 then
    begin
      if(MovParcelasI_EMP_FIL.AsInteger <> 0) and
         MovParcelasD_DAT_PAG.IsNull then
      begin
        VpfDParcela := VpaDBaixa.AddParcela;
        Result := CarDParcelaMovParcela(VpfDParcela);
      end;
    end
    else
    begin
      for VpfLaco := 0 to GParcelas.SelectedRows.Count - 1 do
      begin
        MovParcelas.GotoBookmark(TBookmark(GParcelas.SelectedRows.Items[VpfLaco]));
        if(MovParcelasI_EMP_FIL.AsInteger <> 0) and
           MovParcelasD_DAT_PAG.IsNull then
        begin
          VpfDParcela := VpaDBaixa.AddParcela;
          result := CarDParcelaMovParcela(VpfDParcela);
          if not result then
            break;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeRecibo;
var
  //VpfDRecibo : TDadosRecibo;
  VpfDCliente : TRBDCliente;
begin
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := MovParcelasI_COD_CLI.AsInteger;
  FunClientes.CarDCliente(VpfDCliente);
  dtRave := TdtRave.create(self);
  dtRave.ImprimeRecibo(MovParcelasI_EMP_FIL.AsInteger,VpfDCliente,MovParcelasC_NRO_DUP.AsString,FormatFloat('#,###,##0.00',MovParcelasN_VLR_PAR.AsFloat),Extenso(MovParcelasN_VLR_PAR.AsFloat,'reais','real'),varia.CidadeFilial+' '+ IntTostr(dia(date))+', de ' + TextoMes(date,false)+ ' de '+Inttostr(ano(date)),varia.NomeFilial);
  dtRave.free;
  VpfDCliente.free;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeRelatorioContasAReceber;
begin
  InicializaRelatorio(1);
end;

{******************************************************************************}
procedure TFContasaReceber.InicializaRelatorio(VpaRelatorio : Integer);
begin
   RVSystem.SystemPrinter.MarginBottom  := 1;
   RVSystem.SystemPrinter.MarginLeft    := 1;
   RVSystem.SystemPrinter.MarginTop     := 1;
   RVSystem.SystemPrinter.MarginBottom  := 1;
   RVSystem.SystemPrinter.Units         := unCM;
   RVSystem.SystemPrinter.UnitsFactor   := 2.54;
   rpDev.SelectPaper('A4',false);
   rpDev.Copies                          := 1;
   RVSystem.SystemPrinter.Copies        := rpDev.Copies;
   rpDev.Orientation                     := poPortrait;
   RVSystem.SystemPrinter.Orientation   := rpDev.Orientation;
// regua  RVSystem.SystemPreview.RulerType     := rtBothCm;
   RVSystem.SystemSetups := RVSystem.SystemSetups - [ssAllowSetup];
   RVSystem.SystemPreview.FormState     := wsMaximized;
   RVSystem.Tag := VpaRelatorio;
   RVSystem.Execute;

end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeCabecalhoRelatorioCR;
begin
   with RVSystem.BaseReport do begin
//      PrintBitmapRect(1,1,4.5,2,Image1.Picture.Bitmap);

      SetFont('Arial',16);
      MarginTop := 0.5;
      Home;
      Bold := true;
      PrintHeader('Relatório de Contas a Receber', pjCenter);
      Bold := false;

      SetFont('Arial',10);
      MarginTop := MarginTop+LineHeight;
      Home;
      if ECodfilial.Ainteiro <> 0 then
        PrintHeader('Filial : '+LNomfilial.Caption, pjLeft)
      else
        PrintHeader('Empresa : '+Varia.NomeEmpresa, pjLeft);
      PrintHeader('Período de '+FormatDatetime('DD/MM/YYYY',DataParcela1.Date)+
                  ' até '+FormatDatetime('DD/MM/YYYY',DataParcela2.Date)+'    ' , pjRight);

//      PrintHeader('Página '+Macro(midCurrentPage)+' de '+Macro(midTotalPages),pjRight);

      MarginTop := MarginTop+LineHeight;
      Home;
      SetFont('Arial',10);
      PrintHeader('Periodo por '+RPeriodo.text, pjleft);
      PrintHeader('Situação : '+SitPar.text+'    ',pjRight);
      if EFormaPagamento.AInteiro <> 0  then
        PrintHeader('Forma Pgto : '+LFormaPagamento.Caption,pjCenter);

      // Traca uma linha
      Canvas.Pen.Width := 7;
      Canvas.Pen.Color := clBlack;
      MoveTo(MarginLeft,YPos+0.3);
      LineTo(PageWidth-MarginRight,YPos+0.3);
      Bold := True;
      MarginTop := MarginTop+LineHeight+0.3;
      case rperiodo.Itemindex of
        0 : PrintHeader('Vencimento',pjleft);
        1 : PrintHeader('Emissão',pjleft);
        2 : PrintHeader('Pagamento',pjleft);
        3 : PrintHeader('Cadastro',pjleft);
      end;

      MarginTop := MarginTop+LineHeight;
      Home;
      RestoreTabs(1);
      PrintTab('Cliente');
      PrintTab('Forma Pg.');
      PrintTab('FP');
      PrintTab('Dup.');
      case rperiodo.Itemindex of
        0 : PrintTab('Emissão');
        1 : PrintTab('Vcto');
        2 : PrintTab('Emissão');
        3 : PrintTab('Vcto');
      end;
      PrintTab('D');
      PrintTab('PZ');
      PrintTab('Vl a Receber');
      case rperiodo.Itemindex of
        0 : PrintTab('Data Pg.');
        1 : PrintTab('Data Pg.');
        2 : PrintTab('Dt Vcto');
        3 : PrintTab('Data Pg.');
      end;
      PrintTab('Vl Recebido');
      newline;
      Bold := False;
      MarginTop := MarginTop+LineHeight+0.2;
      Home;
      AdjustLine;
   end; { with }
end;

{******************************************************************************}
procedure TFContasaReceber.DefineTabelaImpressaoCR;
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjLeft,6.5,0.1,Boxlinenone,0); //cliente
     SetTab(NA,pjLeft,2,0.5,Boxlinenone,0); //FormaPagamento
     SetTab(NA,pjLeft,0.5,0.1,Boxlinenone,0); //Fundo Perdido
     SetTab(NA,pjLeft,1.5,0.1,Boxlinenone,0); //Duplicata
     SetTab(NA,pjCenter,1.5,0,Boxlinenone,0); //Emissao
     SetTab(NA,pjCenter,0.5,0,Boxlinenone,0); //Descontado
     SetTab(NA,pjLeft,0.5,0,Boxlinenone,0); //Prazo
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor a receber
     SetTab(NA,pjCenter,1.6,0,Boxlinenone,0); //Data pagamento
     SetTab(NA,pjRight,2.4,0,Boxlinenone,0); //Valor recebido
     SaveTabs(1);
     clearTabs;
     SetTab(2.0,pjCenter,pageWidth-4,0,BoxlineALL,0); //cliente
     SaveTabs(2);
     clearTabs;
     SetTab(2.0,pjleft,11,0.5,BoxlineALL,0); //Forma Pagamento
     SetTab(NA,pjright,6,0.5,BoxlineALL,0); //Valor;
     SaveTabs(3);
   end;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeLinhasCR;
Var
  VpfCampoGrupo : String;
  VpfTotalDuplicataDia,VpfTotalPagoDia,VpfTotalGeralDuplicata,VpfTotalGeralPago,
  VpfTotalDescontado,VpfTotalDescontadoAReceber,VpfTotalEmAberto,
  VpfTotalDuplicataMes, VpfTotalPagoMes : Double;
  VpfDataAtual : TDateTime;
begin
  vpfDataAtual := 0;
  VpfTotalDuplicataDia := 0;
  VpfTotalPagodia := 0;
  VpfTotalGeralDuplicata := 0;
  VpfTotalDescontadoAReceber := 0;
  VpfTotalGeralPago := 0;
  VpfTotalDescontado := 0;
  VpfTotalEmAberto := 0;
  VpfTotalDuplicataMes := 0;
  VpfTotalPagoMes := 0;
  case rperiodo.Itemindex of
    0 : VpfCampoGrupo := 'D_DAT_VEN';
    1 : VpfCampoGrupo := 'D_DAT_EMI';
    2 : VpfCampoGrupo := 'D_DAT_PAG';
    3 : VpfCampoGrupo := 'D_DAT_EMI';
  end;
  MovParcelas.first;
  MovParcelas.DisableControls;
  with RVSystem.BaseReport do begin
    while not MovParcelas.Eof  do
    begin
      if VpfDataAtual <> MovParcelas.FieldByName(VpfCampoGrupo).AsDatetime then
      begin
        if VpfDataAtual <> 0 then
        begin
          ImprimeSomaDiaCR(VpfTotalDuplicataDia,VpfTotalPagoDia);
          VpfTotalDuplicataDia := 0;
          VpfTotalPagodia := 0;
          if mes(VpfDataAtual) <> mes(MovParcelas.FieldByName(VpfCampoGrupo).AsDatetime) then
          begin
            ImprimeSomaMesCR(VpfTotalDuplicataMes,VpfTotalPagoMes,VpfDataAtual);
            VpfTotalDuplicataMes := 0;
            VpfTotalPagoMes := 0;
          end;
        end;
        Bold := true;
        VpfDataAtual := MovParcelas.FieldByName(VpfCampoGrupo).AsDatetime;
        PrintTab(FormatDatetime('DD/MM/YYYY',VpfDataAtual));
        Bold := false;
        newline;
        If LinesLeft<=1 Then
          NewPage;
      end;

      PrintTab(' '+MovParcelasI_COD_CLI.AsString+'-'+MovParcelasC_NOM_CLI.AsString);
      PrintTab('  '+MovParcelasC_NOM_FRM.AsString);
      PrintTab(MovParcelasC_FUN_PER.AsString);
      PrintTab(MovParcelasC_NRO_DUP.AsString);
      case rperiodo.Itemindex of
        0 : PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_EMI.AsDateTime));
        1 : PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_VEN.AsDateTime));
        2 : PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_EMI.AsDateTime));
        3 : PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_VEN.AsDateTime));
      end;
      PrintTab(MovParcelasC_DUP_DES.AsString);
      PrintTab(Inttostr(0));
      PrintTab(FormatFloat('#,###,###,###,##0.00',MovParcelasN_VLR_PAR.AsFloat));
      case rperiodo.Itemindex of
        0 : begin
              if MovParcelasD_DAT_PAG.AsDateTime > Montadata(1,1,1900)then
                PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_PAG.AsDateTime))
              else
                PrintTab(' ');
            end;
        1 : begin
              if MovParcelasD_DAT_PAG.AsDateTime > Montadata(1,1,1900)then
                PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_PAG.AsDateTime))
              else
                PrintTab(' ');
            end;
        2 : PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_VEN.AsDateTime));
        3 : begin
              if MovParcelasD_DAT_PAG.AsDateTime > Montadata(1,1,1900)then
                PrintTab(FormatDateTime('DD/MM/YY',MovParcelasD_DAT_PAG.AsDateTime))
              else
                PrintTab(' ');
            end;
      end;
      if MovParcelasN_VLR_PAG.AsFloat > 0 then
        PrintTab(FormatFloat('#,###,###,###,##0.00',MovParcelasN_VLR_PAG.AsFloat))
      else
        PrintTab('');
      newline;
        If LinesLeft<=1 Then
          NewPage;
      if MovParcelasD_DAT_PAG.IsNull then
      begin
        VpfTotalDuplicataDia := VpfTotalDuplicataDia + MovParcelasN_VLR_PAR.AsFloat;
        VpfTotalDuplicataMes := VpfTotalDuplicataMes + MovParcelasN_VLR_PAR.AsFloat;
        VpfTotalGeralDuplicata := VpfTotalGeralDuplicata +MovParcelasN_VLR_PAR.AsFloat;
      end
      else
      begin
        VpfTotalDuplicataDia := VpfTotalDuplicataDia + MovParcelasN_VLR_PAG.AsFloat;
        VpfTotalDuplicataMes := VpfTotalDuplicataMes + MovParcelasN_VLR_PAG.AsFloat;
        VpfTotalGeralDuplicata := VpfTotalGeralDuplicata +MovParcelasN_VLR_PAG.AsFloat;
      end;
      if MovParcelasC_DUP_DES.AsString = 'S' then
        VpfTotalDescontado := VpfTotalDescontado + MovParcelasN_VLR_PAR.AsFloat;
      if MovParcelasD_DAT_PAG.AsDateTime > Montadata(1,1,1900)then
      begin
        VpfTotalPagodia := VpfTotalPagodia + MovParcelasN_VLR_PAG.AsFloat;
        VpfTotalPagoMes := VpfTotalPagoMes + MovParcelasN_VLR_PAG.AsFloat;
        VpfTotalGeralPago := VpfTotalGeralPago + MovParcelasN_VLR_PAG.AsFloat;
      end
      else
      begin
        VpfTotalEmAberto := VpfTotalEmAberto +MovParcelasN_VLR_PAR.Asfloat;
        if MovParcelasC_DUP_DES.AsString = 'S' then
          VpfTotalDescontadoAReceber := VpfTotalDescontadoAReceber + MovParcelasN_VLR_PAR.Asfloat;
      end;

      MovParcelas.next;
    end;
    MovParcelas.EnableControls;
    if VpfDataAtual <> 0 then
    begin
      ImprimeSomaDiaCR(VpfTotalDuplicataDia,VpfTotalPagoDia);
      ImprimeSomaMesCR(VpfTotalDuplicataMes,VpfTotalPagoMes,VpfDataAtual);
    end;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    Bold := true;
    Printright('Total Contas a Receber : '+FormatFloat('#,###,###,###,##0.00',VpfTotalGeralDuplicata),6.5);
    Printright('Total Em Aberto : '+FormatFloat('#,###,###,###,##0.00',VpfTotalEmAberto),PageWidth-0.5);
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    Printright('Total Pago : '+FormatFloat('#,###,###,###,##0.00',VpfTotalGeralPago),6.5);
    Printright('Total Descontado Em Aberto : '+FormatFloat('#,###,###,###,##0.00',VpfTotalDescontadoAReceber),PageWidth-0.5);
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    Printright('Total Descontado : '+FormatFloat('#,###,###,###,##0.00',VpfTotalDescontado),6.5);
    Printright('Total Receber - Descontado : '+FormatFloat('#,###,###,###,##0.00',VpfTotalEmAberto - VpfTotalDescontadoAReceber),PageWidth-0.5);

    ImprimeporFormaPagamento;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeSomaMesCR(VpaTotalDuplicataMes,VpaTotalPagoMes : Double;VpaMes : TDateTime);
begin
  with RVSystem.BaseReport do begin
    bold := true;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos+LineHeight-1+0.3,PageWidth-0.3,YPos+0.1));
    PrintLeft( 'Total mês : '+TextoMes(VpaMes,false)+'/'+InttoStr(ano(VpaMes)),4);
    PrintRight(FormatFloat('#,###,###,###,##0.00',VpaTotalDuplicataMes),16.5);
    PrintRight(FormatFloat('#,###,###,###,##0.00',VpaTotalPagoMes),20.6);
    bold := false;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeporFormaPagamento;
begin

  with RVSystem.BaseReport do begin
    newline;
    newline;
    RestoreTabs(2);
    LineHeight := LineHeight+0.3;
    SetFont('Arial',14);
    PrintTab('Valores não descontados por Forma de Pagamento');
    bold := false;
    LineHeight := LineHeight-0.2;
    newline;
    If LinesLeft <=1 Then
      NewPage;
    bold := true;
    SetFont('Arial',10);
    RestoreTabs(3);

    PosNaoDescontadosPorFormaPagamento(Aux);
    while not Aux.eof do
    begin
      PrintTab('  '+Aux.FieldByName('C_NOM_FRM').AsString);
      PrintTab(FormatFloat('#,###,###,###,##0.00',Aux.FieldByName('VALDUPLICATA').AsFloat)+'  ');
      newline;
      If LinesLeft <=1 Then
        NewPage;
      Aux.next;
    end;
    Aux.close;
  end;

end;

{******************************************************************************}
procedure TFContasaReceber.ImprimePromissoria;
var
  VpfDCliente : TRBDCliente;
  VpfDFilial  : TRBDFilial;
  VpfDia, VpfMes, VpfAno: Word;
begin
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := MovParcelasI_COD_CLI.AsInteger;
  FunClientes.CarDCliente(VpfDCliente);
  dtRave := TdtRave.create(self);
  DecodeDate(MovParcelasD_DAT_VEN.AsDateTime, VpfAno, VpfMes, VpfDia);
  VpfDFilial := TRBDFilial.cria;
  CarDRepresentanteFilial(VpfDFilial);
  dtRave.ImprimePromissoria(VpfDFilial,VpfDCliente,MovParcelasC_NRO_DUP.AsString,
        FormatFloat('#,###,##0.00',MovParcelasN_VLR_PAR.AsFloat),
            Extenso(MovParcelasN_VLR_PAR.AsFloat,'real','reais'),
            varia.CidadeFilial+' '+ IntTostr(dia(date))+', de ' + TextoMes(date,false)+ ' de '+Inttostr(ano(date)),
            IntToStr(VpfDia),Extenso(VpfDia,'dia','dias'), IntToStr(VpfAno),TextoMes(MovParcelasD_DAT_VEN.AsDateTime,false),true);
  VpfDFilial.Free;
  dtRave.free;
  VpfDCliente.free;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimePromissria1Click(Sender: TObject);
begin
  ImprimePromissoria;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeSomaDiaCR(VpaTotalDuplicataDia,VpaTotalPagoDia : Double);
begin
  with RVSystem.BaseReport do begin
    bold := true;
    PrintTab('');PrintTab('');PrintTab('');PrintTab('');
    PrintTab('');PrintTab('');PrintTab('');
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpaTotalDuplicataDia));
    PrintTab('');
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpaTotalPagoDia));
    bold := false;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;
{******************************************************************************}
procedure TFContasaReceber.BAlterarClick(Sender: TObject);
begin
  FManutencaoCR := TFManutencaoCR.CriarSDI(self, '', FPrincipal.VerificaPermisao('FManutencaoCR'));
  if paginas.ActivePage = TabNotas then
  begin
    FManutencaoCR.AlteraContasaReceber(CadNotasI_EMP_FIL.AsInteger,CadNotasI_LAN_REC.AsInteger);
    AtualizaSQLTabela(CadNotas);
    AtualizaSQLTabela(movnotas);
  end
  else
  begin
    FManutencaoCR.AlteraContasaReceber(MovParcelasI_EMP_FIL.AsInteger, MovParcelasI_LAN_REC.AsInteger);
    executaParcelaPai;
  end;
  FManutencaoCR.free;
end;

{******************************************************************************}
procedure TFContasaReceber.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
  if Filtro.Checked then
    ExecutaParcelaPai;
  CarregaVariaveisGrafico;
end;

{******************************************************************************}
procedure TFContasaReceber.EPlanoGeralExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  if (Sender is TSpeedButton)  then
    VpfCodigo := '99999'
  else
    VpfCodigo := EPlanoGeral.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlanoGeral, False) then
    EPlanoGeral.SetFocus;
  EPlanoGeral.text := VpfCodigo;
  ExecutaNotaPai;
  CarregaVariaveisGrafico;
end;

{******************************************************************************}
procedure TFContasaReceber.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if paginas.ActivePage <> TabNotas then
  begin
    BAlterar.Enabled := true;
    BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
    LBanco.Caption := MovParcelasI_COD_BAN.AsString + '-'+FunContasAReceber.RNomBanco(MovParcelasI_COD_BAN.AsInteger);
    if MovParcelasC_MOS_FLU.AsString = 'S' then
      MMostrarFluxo.Caption := 'Ocultar no Fluxo'
    else
      MMostrarFluxo.Caption := 'Mostrar no Fluxo';
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.MMostrarFluxoClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if MovParcelasC_MOS_FLU.AsString = 'N' then
    VpfREsultado := FunContasAReceber.SetaMostarnoFluxo(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger)
  else
    VpfREsultado := FunContasAReceber.SetaOcultarrnoFluxo(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    executaParcelaPai;
end;

procedure TFContasaReceber.MovNotasAfterScroll(DataSet: TDataSet);
begin
  if paginas.ActivePage = TabNotas then
    BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
end;

{******************************************************************************}
procedure TFContasaReceber.BComissoesClick(Sender: TObject);
begin
  FMovComissoes := TFMovComissoes.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMovComissoes'));
  FMovComissoes.MostraComissoes(dataparcela1.DateTime, dataParcela2.DateTime);
end;

{******************************************************************************}
procedure TFContasaReceber.BProdutosClick(Sender: TObject);
var
  VpfDNota : TRBDNotaFiscal;

begin
  if Paginas.ActivePage = TabParcelas Then
  begin
    if MovParcelasC_IND_CAD.AsString = 'S' then //mostra a cotação do CR
    begin
      FNovaCotacao := TFNovaCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCotacao'));
      FNovaCotacao.ConsultaCotacao(MovParcelasI_EMP_FIL.AsString,MovParcelasI_NRO_NOT.AsString);
      FNovaCotacao.free;
    end
    else
    begin
      if not(MovParcelasI_SEQ_NOT.IsNull) then
      begin
        VpfDNota := TRBDNotaFiscal.cria;
        VpfDNota.CodFilial := MovParcelasI_EMP_FIL.AsInteger;
        VpfDNota.SeqNota := MovParcelasI_SEQ_NOT.AsInteger;
        FunNotaFiscal.CarDNotaFiscal(VpfDNota);
        FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
        FNovaNotaFiscalNota.ConsultaNota(VpfDNota);
        FNovaNotaFiscalNota.free;
 //       VpfDNota.free;
      end;
    end;
  end
  else
    if Paginas.ActivePage = TabNotas Then
    begin
      if CadNotasC_IND_CAD.AsString = 'S' then //mostra a cotação do CR
      begin
        FNovaCotacao := TFNovaCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCotacao'));
        FNovaCotacao.ConsultaCotacao(CadNotasI_EMP_FIL.AsString,CadNotasI_NRO_NOT.AsString);
        FNovaCotacao.free;
      end
      else
      begin
        VpfDNota := TRBDNotaFiscal.cria;
        VpfDNota.CodFilial := CadNotasI_EMP_FIL.AsInteger;
        VpfDNota.SeqNota := CadNotasI_SEQ_NOT.AsInteger;
        FunNotaFiscal.CarDNotaFiscal(VpfDNota);
        FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
        FNovaNotaFiscalNota.ConsultaNota(VpfDNota);
        FNovaNotaFiscalNota.free;
//        VpfDNota.free;
      end;
    end;
end;

{******************************************************************************}
procedure TFContasaReceber.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

{******************************************************************************}
procedure TFContasaReceber.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFContasaReceber.ECodFilialFimConsulta(Sender: TObject);
begin
  executaParcelaPai;
end;

{******************************************************************************}
procedure TFContasaReceber.FormKeyDown(Sender: TObject; var Key: Word;
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
          VprMostrarContas := true;
          executaParcelaPai;
          BMostrarConta.Visible := true;
          ETotalSemNota.Visible := true;
          LTotalSemNota.Visible := true;
          VprPressionadoR := false;
        end
        else
          VprPressionadoR := false;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.BMostrarContaClick(Sender: TObject);
begin
  VprMostrarContas := false;
  BMostrarConta.visible := false;
  ETotalSemNota.Visible := false;
  LTotalSemNota.Visible := false;
  executaParcelaPai;
end;

{******************************************************************************}
procedure TFContasaReceber.BitBtn3Click(Sender: TObject);
begin
  FConsolidarCR := TFConsolidarCR.criarSDI(Application,'',FPrincipal.VerificaPermisao('FConsolidarCR'));
  if FConsolidarCR.ConsolidarContas then
    executaParcelaPai;
  FConsolidarCR.free;;
end;

{******************************************************************************}
procedure TFContasaReceber.AdicionaParcelasArquivoRemessa;
var
  VpfREsultado : string;
begin
  MovParcelas.First;
  while not MovParcelas.Eof do
  begin
    if MovParcelasI_COD_FRM.AsInteger = varia.FormaPagamentoBoleto then
    begin
      VpfResultado := FunContasAReceber.AdicionaRemessa(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger,1,'Remessa');
      if VpfREsultado = '' then
        VpfREsultado := FunContasAReceber.MarcaTituloComoDescontado(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);

      if vpfresultado <> '' then
        aviso('PARCELA "'+MovParcelasC_NRO_DUP.AsString+'"'+#13+VpfResultado);
    end
    else
      aviso('PARCELA "'+MovParcelasC_NRO_DUP.AsString+'"'+#13+'FORMA DE PAGAMENTO INVÁLIDA!!!'#13'A forma de pagamento dessa parcela não é boleto bancário.');
    MovParcelas.Next;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.AdicionarRemessa1Click(Sender: TObject);
var
  VpfResultado : String;
begin
  if MovParcelasI_COD_FRM.AsInteger = varia.FormaPagamentoBoleto then
  begin
    VpfResultado := FunContasAReceber.AdicionaRemessa(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger,1,'Remessa');
    if vpfresultado <> '' then
      aviso(VpfResultado)
    else
      executaParcelaPai;
  end
  else
    aviso('FORMA DE PAGAMENTO INVÁLIDA!!!'#13'A forma de pagamento dessa parcela não é boleto bancário.');
end;

{******************************************************************************}
procedure TFContasaReceber.AdicionarTodosArquivosnaRemessa1Click(
  Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja adicionar todos as duplicatas no arquivo de remessa?') then
  begin
    AdicionaParcelasArquivoRemessa;
    executaParcelaPai;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.BitBtn4Click(Sender: TObject);
begin
  FVisualizaLogReceber := TFVisualizaLogReceber.CriarSDI(application,'', FPrincipal.VerificaPermisao('FVisualizaLogReceber'));
  FVisualizaLogReceber.VisualizaLog(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
  FVisualizaLogReceber.free;
end;

{******************************************************************************}
procedure TFContasaReceber.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    PanelColor3.Height := EClienteMaster.Top + EClienteMaster.Height + 5;
    BFiltros.Caption := '<<';
  end
  else
  begin
    PanelColor3.Height := EFormaPagamento.Top + EFormaPagamento.Height + 5;
    BFiltros.Caption := '>>';
  end;

end;

{******************************************************************************}
procedure TFContasaReceber.EDuplicataKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    DataParcela1Change(DataParcela1);
end;

{******************************************************************************}
procedure TFContasaReceber.HistricoCobrana1Click(Sender: TObject);
begin
  FCobrancas := tFCobrancas.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCobrancas'));
  FCobrancas.HistoricoCobranca(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.asInteger);
  FCobrancas.free;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimirBoleto1Click(Sender: TObject);
var
  VpfDadosClinte: TRBDCliente;
begin
  VpfDadosClinte := TRBDCliente.cria;
  VpfDadosClinte.CodCliente := MovParcelasI_COD_CLI.AsInteger;

  FunClientes.CarDCliente(VpfDadosClinte);
  FunImpFolhaBranca.ImprimeBoleto(MovParcelasI_EMP_FIL.AsInteger, MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger,
                                  VpfDadosClinte, false,'',false);

  VpfDadosClinte.Free;
end;

{******************************************************************************}
procedure TFContasaReceber.EmailBoleto1Click(Sender: TObject);
var
  VpfDadosClinte: TRBDCliente;
begin
  VpfDadosClinte := TRBDCliente.cria;
  VpfDadosClinte.CodCliente := MovParcelasI_COD_CLI.AsInteger;


  FunClientes.CarDCliente(VpfDadosClinte);
  FunImpFolhaBranca.ImprimeBoleto(MovParcelasI_EMP_FIL.AsInteger, MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger,
                                  VpfDadosClinte, false,'',true);

  VpfDadosClinte.Free;
end;

{******************************************************************************}
procedure TFContasaReceber.GParcelasCellClick(Column: TColumn);
begin
  SomaCRSelecionado
end;

{******************************************************************************}
procedure TFContasaReceber.GParcelasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if MovParcelasC_FUN_PER.AsString = 'S' then
  begin
    GParcelas.Canvas.brush.Color:= clred; // coloque aqui a cor desejada
    GParcelas.Canvas.Font.Color:= clWhite;
    GParcelas.DefaultDrawDataCell(Rect, GParcelas.columns[datacol].field, State);
  end
  else
    if (MovParcelasC_IND_SIN.AsString = 'S') AND (MovParcelasN_VLR_PAR.AsFloat > MovParcelasN_SIN_BAI.AsFloat) then
    begin
     GParcelas.Canvas.Font.Color:= $FFD700;
      GParcelas.DefaultDrawDataCell(Rect, GParcelas.columns[datacol].field, State);
    end;
end;

{******************************************************************************}
procedure TFContasaReceber.EnviarCartrio1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if MovParcelasI_COD_FRM.AsInteger = varia.FormaPagamentoBoleto then
  begin
    VpfResultado := FunContasAReceber.AdicionaRemessa(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger,9,'Pedido de Protesto');
    if VpfResultado = '' then
      VpfResultado := FunContasAReceber.AtualizaDataCartorio(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);

    if vpfresultado <> '' then
      aviso(VpfResultado)
    else
      executaParcelaPai;
  end
  else
    aviso('FORMA DE PAGAMENTO INVÁLIDA!!!'#13'A forma de pagamento dessa parcela não é boleto bancário.');
end;

{******************************************************************************}
procedure TFContasaReceber.ConsultaAdiantamento(VpaCodFilial,VpaLanReceber: Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprLanReceberSinalPagamento := VpaLanReceber;
  executaParcelaPai;
  showmodal;
end;

procedure TFContasaReceber.ConsultaCheques1Click(Sender: TObject);
begin
  FConsultaCheques := tFConsultaCheques.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaCheques'));
  FConsultaCheques.ConsultaChequesContasReceber(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
  FConsultaCheques.free;
end;

{******************************************************************************}
procedure TFContasaReceber.GParcelasOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFContasaReceber.ConsultaContasReceberCliente(VpaCodCliente: Integer);
begin
  ECliente.AInteiro:= VpaCodCliente;
  DataParcela1.DateTime:= PrimeiroDiaMes(DecAno(Date,1));
  DataParcela2.DateTime:= Now;
  SitPar.ItemIndex:= 1;
  AtualizaLocalizas(FContasaReceber.PanelColor3);
  ShowModal;
end;

{******************************************************************************}
procedure TFContasaReceber.ConsultaContasdoCheque(VpaSeqCheque : Integer);
begin
  VprSeqCheque := VpaSeqCheque;
  executaParcelaPai;
  showmodal;
end;

{******************************************************************************}
procedure TFContasaReceber.ImprimeReceibo1Click(Sender: TObject);
begin
  ImprimeRecibo;
end;

{******************************************************************************}
procedure TFContasaReceber.EClienteRetorno(Retorno1,
  Retorno2: String);
var
  VpfDCliente : TRBDCliente;
begin
  if ECliente.AInteiro <> 0 then
  begin
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := ECliente.AInteiro;
    FunClientes.CarDCliente(VpfDCliente);
    if VpfDCliente.DesObservacao <> '' then
    begin
      FMostraObservacaoCliente := TFMostraObservacaoCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMostraObservacaoCliente'));
      FMostraObservacaoCliente.MostraObservacaoCliente(VpfDCliente);
      FMostraObservacaoCliente.free;
    end;
    VpfDCliente.Free;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.EfetuarCobrana1Click(Sender: TObject);
begin
  if MovParcelasI_LAN_REC.AsInteger <> 0 then
  begin
    FNovaCobranca := TFNovaCobranca.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCobranca'));
    FNovaCobranca.CobrancaCliente(MovParcelasI_COD_CLI.AsInteger);
    FNovaCobranca.free;
  end;
end;

{******************************************************************************}
procedure TFContasaReceber.AlterarCliente1Click(Sender: TObject);
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

Initialization
  RegisterClasses([TFContasaReceber]);
end.
